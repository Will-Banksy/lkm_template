#!/bin/bash

bsrc_sdelim=$(find src -regextype egrep -regex '.*/.*\.(c|h)')
bsrc_arr=(${bsrc_sdelim});

target_name=$(pwd | xargs basename)

for i in ${!bsrc_arr[@]}; do
	# echo "bsrc_arr[$i] => ${bsrc_arr[$i]}";
	new_path=$(echo ${bsrc_arr[$i]} | sed -E 's/(^| )src\//\1target\/src\//g');
	# echo "${bsrc_arr[$i]} => ${new_path}";
	mkdir -p $(dirname ${new_path});
	ln -srf ${bsrc_arr[$i]} $new_path;
	new_path=$(echo ${bsrc_arr[$i]} | sed -E -e 's/\.c$$/\.o/g' -e 's/.*\.h//g');
	bsrc_arr[$i]=$new_path;
done;

bsrc_sdelim=${bsrc_arr[@]}

makefile=$(echo 'KERNEL := ~/rpisrc/linux
PWD := $(shell pwd)
obj-m += %TARGET%.o
%TARGET%-y += %OBJECTS%

all:
	make ARCH=arm CROSS_COMPILE=$(CROSS) -C $(KERNEL) M=$(PWD) modules

clean:
	make -C $(KERNEL) M=$(PWD) clean' | sed -e "s|%OBJECTS%|${bsrc_sdelim}|g" -e "s|%TARGET%|${target_name}|g");

mkdir -p "target"
echo "$makefile" > target/Makefile