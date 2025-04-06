#!/bin/bash

cd ~/dev/love/
rm -rf abyss/build
npx love.js abyss build -m 1280000000 -t abyss
mv build abyss/build
cd abyss
python3 serve.py