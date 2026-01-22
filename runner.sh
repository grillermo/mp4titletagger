#!/bin/bash

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Please install it to continue."
    exit 1
fi

# Check if taglib is installed
if ! brew list taglib &> /dev/null; then
    echo "taglib is not installed. Please run 'brew install taglib' to install it."
    exit 1
fi

# Check if taglib-ruby is installed
if ! gem list taglib-ruby -i &> /dev/null; then
    echo "taglib-ruby is not installed. Please run 'gem install taglib-ruby' to install it."
    exit 1
fi

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

DIRECTORY="$1"

if [ ! -d "$DIRECTORY" ]; then
    echo "Error: Directory '$DIRECTORY' not found."
    exit 1
fi

ruby tag_mp4.rb "$DIRECTORY"
