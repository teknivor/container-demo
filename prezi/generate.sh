#!/bin/sh -v

for f in sources/*.md
do
  ./pandoc.exe -V theme=white -t revealjs -o $(basename $f .md).html -s ${f} --slide-level 1 --template sources/default.revealjs
done

#./generate.sh && aws s3 cp index.html s3://awscli.mudrii.com


#for f in *.md ; do  pandoc -V theme=white -t revealjs -o $(basename $f .md).html -s ${f} --slide-level 1 --template default.revealjs ; done