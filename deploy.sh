#!/usr/bin/env bash

outputdir='./output'

rm $outputdir/* -rf

pelican content/

cd $outputdir
touch CNAME
echo 'becaning.com'>CNAME

git add .
git commit -m'deploy to Github Pages'
git push GithubPages master


