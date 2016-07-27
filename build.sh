#!/bin/bash

loop_templates () {
  if [ -z "$1" ] ; then
    echo "Incorrect number of arguments to loop_templates <glob pattern>."
    exit 1
  fi

  # Loop over each found markdown file.
  for file in ${1}; do
    # Check it's an actual readable file.
    if [ -e "$file" ] ; then
      # Get our 💩 together.
      TEMPLATE=`cat template.html`
      CONTENT=`cat "$file" | pandoc --no-highlight -f markdown`

      # Compile the template.
      FILE="${TEMPLATE/CONTENT_HERE/$CONTENT}"

      # Pandoc just puts the language in there, we want language-{language}.
      FILE="${FILE/class=\"javascript\"/class=\"language-javascript\"}"

      # If we passed in a target directory, use that.
      if [ $# == 2 ] ; then
        WRITE_TO="$2$(basename $file | cut -d. -f1 | tr '[:upper:]' '[:lower:]')"
      else
        WRITE_TO=$(echo $file | cut -d. -f1 | sed 's,^[^/]*/,,' | tr '[:upper:]' '[:lower:]')
      fi

      # Create the path for it.
      mkdir -p "$WRITE_TO"

      # Write the file contents like a baws.
      echo "$FILE" > "./$WRITE_TO/index.html"
    fi
  done
}

loop_templates "content/*.md"
loop_templates "content/docs/*.md" docs/0.4.0/
