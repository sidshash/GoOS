# GoOS

GoOS is a small x86 operating-system experiment. Its current boot sector is
written in 16-bit NASM assembly and prints `Welcome to GoOS!` when started.
The kernel directory is a placeholder; the build does not yet compile or load
a kernel.

## Requirements

Build and run the project in a Linux environment (including WSL) with:

- GNU Make
- NASM
- `dd` and `mkdir` (typically provided by coreutils)
- `mkfs.fat` (provided by dosfstools)
- `qemu-system-x86_64` to run the image

## Build

Build the bootloader and create a 1.44 MB FAT12 floppy image:

```sh
make
```

The generated files are placed in `build/`:

- `bootloader.bin` — assembled boot sector
- `floppy.img` — FAT12 floppy image with the boot sector written to its first
  512 bytes

## Run

After building, start the image in QEMU:

```sh
make run
```

The bootloader initializes the real-mode environment, switches to text mode,
prints its welcome message, then halts. Close the QEMU window to exit.

## Clean

Remove generated build files:

```sh
make clean
```

## Project layout

```text
bootloader/
  bootloader.asm   16-bit BIOS boot sector
kernel/
  kernel.asm      Kernel source placeholder
Makefile          Build, image, run, and clean targets
```
