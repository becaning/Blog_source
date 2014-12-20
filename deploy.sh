#!/usr/bin/env bash

outputdir='./output'

cd outputdir
touch CANME
echo 'becaning'>CANME

git add .
git commit -m'deploy to Github Pages'
git push GithubPages master


