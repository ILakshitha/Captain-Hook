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

# Main loop to watch for commits
while true; do
    # Get the current HEAD commit hash
    current_commit=$(git rev-parse HEAD)

    # Wait for a new commit
    while [[ $current_commit == $(git rev-parse HEAD) ]]; do
        sleep 5
    done

    # A new commit has been detected!
    new_commit=$(git rev-parse HEAD)
    commit_message=$(git log -1 --pretty=%B)
    commit_author=$(git log -1 --pretty=%an)
    commit_date=$(git log -1 --pretty=%ad --date=format:'%Y-%m-%d %H:%M:%S')

    # Add pirate flair to the commit message
    pirate_message=$(add_pirate_flair "$commit_message")

    # Log the commit details
    echo "⚓ Commit: $new_commit" >> "$LOGFILE"
    echo "🏴‍☠️ Message: $pirate_message" >> "$LOGFILE"
    echo "👤 Author: $commit_author" >> "$LOGFILE"
    echo "🕰️ Date: $commit_date" >> "$LOGFILE"
    echo "---" >> "$LOGFILE"

    echo "Yarr! New treasure be added to the map!"
done