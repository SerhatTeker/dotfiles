# run every zsh logout

# Push journals
if [[ ! -z "${JOURNAL_DIR}" ]]; then
    cd ${JOURNAL_DIR} && git push -v
fi
