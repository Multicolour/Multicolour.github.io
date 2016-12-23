#!/bin/bash

# Don't need no CMS. Just markdown and a bash script 👌

# Loop over a pattern of files and render them to html using template.html
# @param {string} $1 Pattern to use to find markdown files.
# @param {string} $2 Optional directory to specifically write files to.
# @returns {void}
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
      FILE="${FILE//class=\"javascript\"/class=\"language-javascript\"}"

      BASENAME="$(basename $file | cut -d. -f1 | tr '[:upper:]' '[:lower:]')"

      FILE="${FILE/CLASS_HERE/$BASENAME}"

      if [ "$BASENAME" == "index" ] ; then
        # If we passed in a target directory, use that.
        if [ $# == 2 ] ; then
          WRITE_TO="$2"
        else
          WRITE_TO=$(echo $BASENAME | sed 's,^[^/]*/,,')
        fi
      else
        # If we passed in a target directory, use that.
        if [ $# == 2 ] ; then
          WRITE_TO="$2/$BASENAME"
        else
          WRITE_TO=$(echo $BASENAME | sed 's,^[^/]*/,,')
        fi
      fi

      echo "./$WRITE_TO/index.html"

      # Create the path for it.
      mkdir -p "$WRITE_TO"

      # Write the file contents like a baws.
      echo "$FILE" > "./$WRITE_TO/index.html"
    fi
  done
}

# Render our templates.
loop_templates "content/*.md"
loop_templates "content/docs/*.md" docs/0.5.2
