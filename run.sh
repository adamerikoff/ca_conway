#!/bin/bash

# Check if the command is 'start'
if [ "$1" = "start" ]; then
    # Replace 'your_script.rb' with the actual path to your Ruby script
    echo "Calling Ruby interpreter."
    echo -e "\n\n\n\n"
    ruby src/main.rb
    echo -e "\n\n\n\n"
    echo "Ruby script finished."
else
    echo "Usage: $0 start"
    exit 1
fi