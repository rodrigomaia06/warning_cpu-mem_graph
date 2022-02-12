#!/bin/bash
DEPENDENCIES=(bc python3 wget pip)
sudo apt install ${DEPENDENCIES[*]} &> /dev/null
pip install matplotlib &> /dev/null
