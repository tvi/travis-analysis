#!/usr/bin/env sh
max=10
for i in `seq 2 $max`
do
	ruby1.9.3 main.rb
    # echo "$i"
done