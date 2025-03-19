#!/bin/bash
tmux split-window -h
clear
tmux split-window -v
tmux select-pane -t 0
tmux split-window -v
tmux select-pane -t 0
clear
