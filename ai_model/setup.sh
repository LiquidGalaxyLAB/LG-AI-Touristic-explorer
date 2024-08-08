#!/usr/bin/env bash

apt-get install -y curl

curl -fsSL https://ollama.com/install.sh | sh 

ollama serve & sleep 5 && ollama run gemma:2b