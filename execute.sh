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

# Get the initial HEAD commit hash
last_commit=$(git rev-parse HEAD)

echo "Ahoy! Captain Hook's commit logger be ready to chart yer code voyage!"

# Set a time limit (in seconds) - 4 minutes 30 seconds to allow for some buffer
end_time=$((SECONDS + 270))

while [ $SECONDS -lt $end_time ]; do
    # Check for new commits
    current_commit=$(git rev-parse HEAD)
    
    if [ "$current_commit" != "$last_commit" ]; then
        # New commit found! Log it
        commit_message=$(git log -1 --pretty=%B)
        commit_author=$(git log -1 --pretty=%an)
        commit_date=$(git log -1 --pretty=%ad --date=format:'%Y-%m-%d %H:%M:%S')

        # Add pirate flair to the commit message
        pirate_message=$(add_pirate_flair "$commit_message")

        # Log the commit details
        echo "⚓ Commit: $current_commit" >> "$LOGFILE"
        echo "🏴‍☠️ Message: $pirate_message" >> "$LOGFILE"
        echo "👤 Author: $commit_author" >> "$LOGFILE"
        echo "🕰️ Date: $commit_date" >> "$LOGFILE"
        echo "---" >> "$LOGFILE"

        echo "Yarr! New treasure be added to the map!"
        
        # Update last commit
        last_commit=$current_commit
    fi

    # Wait a bit before checking again (reduced from 5 to 1 second)
    sleep 1
done

echo "Avast ye! The time limit be reached. Ending the script."