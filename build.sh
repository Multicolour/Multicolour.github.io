#!/bin/bash

# Loop over each found markdown file.
for file in content/*.md; do
  # Check it's an actual readable file.
  if [ -e "$file" ] ; then
    # Get our 💩 together.
    TEMPLATE=`cat template.html`
    CONTENT=`cat "$file" | pandoc -f markdown_github`

    # Compile the template.
    FILE="${TEMPLATE/CONTENT_HERE/$CONTENT}"
    PATH=$(basename $file | cut -d. -f1)

    # Create the path for it.
    mkdir -p $PATH

    echo "$FILE" > "$PATH/index.html"
  fi
done
