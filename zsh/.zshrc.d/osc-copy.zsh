# Copy the standard input to the system clipboard using the OSC 52 escape sequence.
osc-cp() {
  if [ -t 0 ]; then
    echo "Usage: <command> | osc-cp"
    echo "Copies standard input to the system clipboard."
    return 1
  fi
  printf "\033]52;c;$(base64 | tr -d '\n')\a"
}