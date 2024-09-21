#!/bin/bash

# Ahoy! Set up the seas of your Git repo!
# Ensure the out directory exists for the commits.txt treasure
mkdir -p out

# Get the latest commit info and log it to the commits.txt treasure map
commit_hash=$(git log -1 --pretty=format:"%H")
commit_message=$(git log -1 --pretty=format:"%s")
commit_author=$(git log -1 --pretty=format:"%an")
commit_date=$(git log -1 --pretty=format:"%ad")

echo "Arrr, a new commit be here! ⚓" >> out/commits.txt
echo "Commit: $commit_hash" >> out/commits.txt
echo "Message: $commit_message" >> out/commits.txt
echo "Author: $commit_author" >> out/commits.txt
echo "Date: $commit_date" >> out/commits.txt
echo "-----------------------------------" >> out/commits.txt

echo "Ahoy, matey! Commit $commit_hash be added to the log!" 
