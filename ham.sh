#!/bin/bash

# Determine the directory of the script
SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

# Path to the counter file and HAM file in the repository directory
COUNTER_FILE="$SCRIPT_DIR/.prompt_counter"
HAM_FILE="$SCRIPT_DIR/All_Lyrics_No_Speakers"

# Check if HAM_FILE exists and is not empty
if [ ! -f "$HAM_FILE" ] || [ ! -s "$HAM_FILE" ]; then
    echo "Error: HAM_FILE does not exist or is empty."
    return 1
fi

HAM_LENGTH=$(wc -l < "$HAM_FILE")

# Function to update the prompt
update_prompt() {
    # Read the current counter value
    if [ ! -f "$COUNTER_FILE" ]; then
        echo "1" > "$COUNTER_FILE"
    fi
    COUNTER=$(cat "$COUNTER_FILE")
    
    # Set the new prompt with the current counter value
    PROMPT="$(sed "${COUNTER}q;d" "$HAM_FILE")"
    PS1="${PROMPT} $ "

    # Increment the counter
    NEXT_COUNTER=$((COUNTER + 1))
    NEXT_COUNTER=$((NEXT_COUNTER % HAM_LENGTH))
    
    # Save the new counter value back to the file
    echo "$NEXT_COUNTER" > "$COUNTER_FILE"
}

# Export the function so it can be used in the prompt command
export -f update_prompt

# Set the PROMPT_COMMAND to call update_prompt before displaying each prompt
PROMPT_COMMAND="update_prompt"