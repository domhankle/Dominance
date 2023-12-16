#!/usr/bin/env bash
cd ~/dev/dominance/scripts

rm -r ../build
mkdir ../build
cmake -S .. -B ../build
