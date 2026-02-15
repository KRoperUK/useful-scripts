#!/usr/bin/env bash
# shellcheck shell=bash
# Auto-commit: AI-generated conventional commit messages via Claude Haiku
# Usage: stage files with `git add`, then run `auto-commit`
# Requires: AUTO_COMMIT_OPENAI_API_KEY (or OPENROUTER_API_KEY), jq, curl
# Optional: AUTO_COMMIT_OPENAI_BASEURL (default: OpenRouter), AUTO_COMMIT_MODEL, AUTO_COMMIT_INSTRUCTIONS
auto-commit() {
	# Configuration
	local api_key="${AUTO_COMMIT_OPENAI_API_KEY:-$OPENROUTER_API_KEY}"
	local base_url="${AUTO_COMMIT_OPENAI_BASEURL:-https://openrouter.ai/api/v1}"
	local model="${AUTO_COMMIT_MODEL:-anthropic/claude-3.5-haiku}"
	local instructions="${AUTO_COMMIT_INSTRUCTIONS:-}"

	# Check prerequisites
	if [[ -z $api_key ]]; then
		echo "❌ AUTO_COMMIT_OPENAI_API_KEY not set. Export it in your shell or .zshrc"
		return 1
	fi

	local diff
	diff=$(git diff --cached --stat 2>/dev/null)
	if [[ -z $diff ]]; then
		echo "❌ No staged changes. Run 'git add' first."
		return 1
	fi

	# Get the detailed diff (truncate to ~8000 chars to stay within token limits)
	local full_diff
	full_diff=$(git diff --cached | head -c 8000)

	local branch_name
	branch_name=$(git branch --show-current)

	echo "🤖 Generating commit message for branch '${branch_name}' using ${model}..."

	local prompt="You are a commit message generator. Given the following git diff and branch name, write a single conventional commit message.

Branch: ${branch_name}

Rules:
- Use format: type(scope): description
- Types: feat, fix, refactor, docs, test, chore, style, ci, perf, build
- Scope is optional, use it when changes are focused on one area
- Description should be lowercase, imperative mood, no period at end
- If there are multiple changes, pick the most significant one for the main message
- Output ONLY the commit message, nothing else. No quotes, no explanation.

${instructions:+Additional Requirements:
$instructions
}
Git diff:
${full_diff}"

	local response
	response=$(curl -s "${base_url}/chat/completions" \
		-H "Authorization: Bearer $api_key" \
		-H "Content-Type: application/json" \
		-H "X-Title: AutoCommit CLI" \
		-d "$(jq -n --arg prompt "$prompt" --arg model "$model" '{
            "model": $model,
            "messages": [{"role": "user", "content": $prompt}],
            "max_tokens": 300,
            "temperature": 0.3
        }')" 2>/dev/null)

	local msg
	# Try content first, fall back to reasoning for reasoning models
	msg=$(echo "$response" | jq -r '.choices[0].message.content // empty' 2>/dev/null)
	if [[ -z $msg ]]; then
		msg=$(echo "$response" | jq -r '.choices[0].message.reasoning // empty' 2>/dev/null)
	fi

	# Clean up: strip quotes, trailing whitespace, newlines
	msg=$(echo "$msg" | sed 's/^["\x27]//; s/["\x27]$//; s/[[:space:]]*$//' | head -1)

	if [[ -z $msg ]]; then
		local err
		err=$(echo "$response" | jq -r '.error.message // empty' 2>/dev/null)
		echo "❌ Failed to generate message: ${err:-unknown error}"
		echo "   Response: $response"
		return 1
	fi

	# Show the message and ask for confirmation
	echo ""
	echo "📝 Suggested commit message:"
	echo "   \033[1;36m${msg}\033[0m"
	echo ""
	echo -n "Commit with this message? [Y/n/e(dit)] "
	read -r choice

	case "$choice" in
	n | N)
		echo "Aborted."
		return 0
		;;
	e | E)
		echo -n "Enter your commit message: "
		read -r custom_msg
		git commit -m "$custom_msg"
		;;
	*)
		git commit -m "$msg"
		;;
	esac
}
