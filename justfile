alias ci := watch-local-ci

watch-local-ci:
    cargo watch \
        --watch . \
        --why \
        --shell "just local-ci"

local-ci:
    cargo clippy --workspace --all-targets -- --deny=warnings
    cargo fmt --all -- --check
    cargo test
    cargo doc --document-private-items
    echo "TODO(max): Put a run command here here"

# Continuously iterate on something
iterate *args:
    # e.g. `just iterate cargo test test_parse -- --show-output`
    cargo watch \
        --watch . \
        --why \
        --shell "{{ args }}" \
        --shell "just local-ci"

just-fmt:
    just --fmt --unstable
