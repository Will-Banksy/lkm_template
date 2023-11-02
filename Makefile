# E.g.
# make KERNEL=~/rpisrc/linux CROSS=~/rpi_tools/arm-bcm2708/arm-linux-gnueabihf/bin/arm-linux-gnueabihf-
#     (for linux src in ~/rpisrc/linux and raspberrypi/tools at ~/rpi_tools)

TARGET := $(shell pwd | xargs basename)

all:
	make -C target KERNEL=$(KERNEL) CROSS=$(CROSS)
	cp target/$(TARGET).ko $(TARGET).ko

clean:
	rm -rf target
	rm -f *.ko