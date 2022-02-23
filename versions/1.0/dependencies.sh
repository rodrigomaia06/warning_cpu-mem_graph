#!/bin/bash
DEPENDENCIES=(bc python3 wget pip git)
sudo apt install ${DEPENDENCIES[*]} -y &> /dev/null
pip install matplotlib &> /dev/null
