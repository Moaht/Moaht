#!/bin/bash

if ! $(which pyftsubset > /dev/null); then
    echo "pyftsubset is not installed. Please install it using 'apt-get install fonttools' and try again."
    exit 1
fi

if [ $# -gt 1 ]; then
    echo "Invalid number of arguments. Please provide a single string argument to be used as the text for font optimisation."
    exit 1
fi

ARGS="$1"

# Supply the text to be used as an argument to the script, and it will create a .b64 file containing the base64 encoded optimised font.
get_font_b64() {
local STRING=$(echo "$1" | grep -o . | awk '!seen[$0]++' | tr -d '\n')
pyftsubset fonts/CMUSerif-Roman.woff2 --text="$STRING" --output-file=/dev/stdout --flavor=woff2 2>/dev/null | base64 -w 0
}

RESULT=$(get_font_b64 "$ARGS")

echo "$RESULT"
