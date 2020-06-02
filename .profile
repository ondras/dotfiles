if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux a || tmux
fi
