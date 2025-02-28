#!/bin/bash
tmux split-window -h -l 30%
tmux select-pane -t 0
clear
tmux select-pane -t 1
tmux split-window -v -l 66%
tmux split-window -v
tmux select-pane -t 0
