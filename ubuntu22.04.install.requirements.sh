#!/bin/bash
# Install requirements for Ubuntu 22.04 LTS
cat ./ubuntu22.04.requirements.txt | xargs sudo apt install -yqq
