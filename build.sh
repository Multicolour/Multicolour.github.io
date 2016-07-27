#!/bin/bash

# Loop over each found markdown file.
for file in content/*.md; do
  # Check it's an actual readable file.
  if [ -e "$file" ] ; then
    # Get our 💩 together.
    TEMPLATE=`cat template.html`
    CONTENT=`cat "$file" | pandoc --no-highlight -f markdown`

    # Compile the template.
    FILE="${TEMPLATE/CONTENT_HERE/$CONTENT}"

    # Pandoc just puts the language in there, we want language-{language}.
    FILE="${FILE/class=\"javascript\"/class=\"language-javascript\"}"

    # Get the base name.
    WRITE_TO=$(basename $file | cut -d. -f1)

    # Create the path for it.
    mkdir -p $WRITE_TO

    # Write the file contents like a baws.
    echo "$FILE" > "./$WRITE_TO/index.html"
  fi
done
