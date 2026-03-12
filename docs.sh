#!/usr/bin/env bash

readonly DOCS_DIR="${HOME}/Documents"
readonly SUPPORTED_EXTENSIONS=("pdf" "docx" "epub")
declare -A READERS=(
  ["pdf"]="zathura"
  ["docx"]="libreoffice"
  ["epub"]="foliate"
)

build_fd_args() {
  local args=()
  for ext in "${SUPPORTED_EXTENSIONS[@]}"; do
    args+=("--extension" "$ext")
  done
  echo "${args[@]}"
}

select_document() {
  local fd_args
  read -ra fd_args <<<"$(build_fd_args)"

  fd . "${fd_args[@]}" "${DOCS_DIR}" |
    sed "s|^$DOCS_DIR/||" |
    sort -u |
    uniq |
    dmenu -i -p 'Select a document to read: '
}

open_document() {
  local doc_path="$1"
  local full_path="$DOCS_DIR/$doc_path"
  local reader

  [[ -f "$full_path" ]] || exit 1

  extension=$(echo "$full_path" | awk -F "." '{print $NF}')
  reader="${READERS[$extension]:-}"

  [[ -n "$reader" ]] || exit 1

  exec "$reader" "$full_path"
}

main() {
  local selected_doc
  selected_doc=$(select_document)

  [[ -n "$selected_doc" ]] && open_document "$selected_doc"
}

main "$@"
