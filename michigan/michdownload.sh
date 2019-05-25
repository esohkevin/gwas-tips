#!/bin/bash

for i in $(cat list.txt); do
	wget ${i}
done
