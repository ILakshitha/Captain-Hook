#!/bin/bash

# Ensure the out directory exists
mkdir -p out

# File to store the commit logs
LOGFILE="out/commits.txt"

# Function to add a pirate flair to commit messages
add_pirate_flair() {
    local message="$1"
    local pirate_phrases=("Arrr!" "Shiver me timbers!" "Yo ho ho!" "Avast ye!" "Blimey!")
    local random_phrase=${pirate_phrases[$RANDOM % ${#pirate_phrases[@]}]}
    echo "$random_phrase $message"
}

# Get the total number of commits
total_commits=$(git rev-list --all --count)

# Log the last 10 commits (or all if less than 10)
commits_to_log=$((total_commits < 10 ? total_commits : 10))

echo "Yarr! Logging the last $commits_to_log commits to the treasure map!"

git log -n "$commits_to_log" --reverse --pretty=format:"%H%n%s%n%an%n%ad" --date=format:"%Y-%m-%d %H:%M:%S" | while read -r commit_hash && read -r commit_message && read -r commit_author && read -r commit_date; do
    # Add pirate flair to the commit message
    pirate_message=$(add_pirate_flair "$commit_message")

    # Log the commit details
    echo "⚓ Commit: $commit_hash" >> "$LOGFILE"
    echo "🏴‍☠️ Message: $pirate_message" >> "$LOGFILE"
    echo "👤 Author: $commit_author" >> "$LOGFILE"
    echo "🕰️ Date: $commit_date" >> "$LOGFILE"
    echo "---" >> "$LOGFILE"

    echo "Added commit $commit_hash to the log!"
done

echo "Ahoy! All commits be logged in the treasure map at $LOGFILE"