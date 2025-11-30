#!/usr/bin/env bash
set -euo pipefail

# Ensure gh is authenticated
if ! gh auth status &>/dev/null; then
  echo "You must authenticate first: gh auth login"
  exit 1
fi

echo "Fetching public gists via GitHub API (forced GET)..."

# Force GET to avoid alias/extension POST overrides
gists_json=$(gh api -X GET /gists --paginate -F per_page=100)

# Only public gists
echo "$gists_json" | jq -c '.[] | select(.public == true)' | while read -r gist; do
  gist_id=$(echo "$gist" | jq -r '.id')
  description=$(echo "$gist" | jq -r '.description')
  files_json=$(echo "$gist" | jq -c '.files')

  file_count=$(echo "$files_json" | jq 'keys | length')

  # Determine folder name
  if [ "$file_count" -eq 1 ]; then
    folder=$(echo "$files_json" | jq -r 'to_entries[0].value.filename')
  else
    folder=$(echo "$files_json" | jq -r '
      to_entries
      | max_by(.value.size)
      | .value.filename
    ')
  fi

  echo "Processing $gist_id → folder: $folder"
  mkdir -p "$folder"

  # Download each file
  echo "$files_json" | jq -c 'to_entries[]' | while read -r f; do
    filename=$(echo "$f" | jq -r '.value.filename')
    url=$(echo "$f" | jq -r '.value.raw_url')
    curl -sL "$url" -o "$folder/$filename"
  done

  # README
  readme="$folder/README.md"
  {
    echo "# $folder"
    echo
    echo "### Description"
    echo "$description"
    echo
    echo "### Extra"
  } > "$readme"

  forks=$(echo "$gist" | jq -c '.forks')
  if [ "$(echo "$forks" | jq length)" -gt 0 ]; then
    echo "- **Original fork:** $(echo "$forks" | jq -r '.[0].url')" >> "$readme"
  else
    echo "- No fork information." >> "$readme"
  fi

done

echo "Done."
