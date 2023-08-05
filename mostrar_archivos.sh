#!/bin/bash
find . -type f ! -name ".*" | grep -vE "node_modules|\.git|.*lock.*|README.md|/\..*|\.png$|\.jpg$|\.jpeg$|\.gif$|\.svg$|\.ico$|\.zip$|\.tar$|\.gz$|\.rar$|\.pdf$" | while read f; do
  echo "Archivo: $f"
  cat "$f"
  echo ""
done

# #!/bin/bash
# find . -type f ! -name ".*" | grep -vE "node_modules|\.git|.*lock.*|README.md|/\..*" | while read f; do
#   echo "Archivo: $f"
#   cat "$f"
#   echo ""
# done
