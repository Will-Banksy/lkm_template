# lkm_template

A generic project template for developing Linux Kernel Modules (LKMs), specifically enabling out of source tree builds. I'm a beginner with LKMs so I don't really know what I'm doing but this works for me so far, but there may be errors or bad design decisions.

There is a c_cpp_properties.json file for configuring intellisense in vscode, which should just work - *provided* the linux source code can be found at toolchain/linux and the raspberrypi/tools repository can be found at toolchain/tools (if not, just change the include paths and compiler path in the json file to reflect the actual locations, or make use of symlinks).

## Compilation

(Both steps should be run in the project root directory)

```bash
./configure
```
This will discover all .c and .h files in src, and symlink them (preserving directory structure) into newly created target/src.

It will also create a Makefile at target/Makefile that can be used to compile the project in-tree in the target directory.

The Makefile will compile 1 module, named after the basename of the project root directory (e.g. if your project directory is ~/projects/gpio_drv then the module will be called gpio_drv). All the source (.c) files in src will be used to compile the module.

The configure.sh script will need to be re-run whenever a new file is added. To remove old files in target/src, just run `make clean` and reconfigure and compile.

```bash
make KERNEL=<path_to_kernel_src> CROSS=<path_to_raspberrypi/tools>/arm-bcm2708/arm-linux-gnueabihf/bin/arm-linux-gnueabihf-
```
Where `<path_to_kernel_src>` is the path to the source code of linux of the version that you want to build against, and `<path_to_raspberrypi/tools>` is the path to where you've cloned [https://github.com/raspberrypi/tools](https://github.com/raspberrypi/tools).

E.g. `make KERNEL=toolchain/linux CROSS=toolchain/tools/arm-bcm2708/arm-linux-gnueabihf/bin/arm-linux-gnueabihf-`

This will invoke the compilation process to produce a kernel module (.ko) file in target, which is then copied into the project root directory.

## Running the module on the pi

Also provided is a script, rpiz_exec.sh, which can be used to transfer the module onto the raspberry pi at ~/mods and put you in a SSH session in that directory, intended so you can then manually do whatever to the module.

```bash
./rpiz_exec.sh <pi_username>@<pi_ip_addr>
```

This will connect to the SSH daemon/service running on the pi and transfer the module, and then drop you into a shell (this will require entering the password for SSH twice unless a different authentication mechanism is set up).

## Cleanup

Simply run `make clean`, which just deletes the .ko file and target directory.