ASM=nasm
BUILD=build

.PHONY: all init clean bootloader kernel floppy_image

all: init bootloader kernel floppy_image

init:
	mkdir -p $(BUILD)

bootloader: $(BUILD)/bootloader.bin

$(BUILD)/bootloader.bin: bootloader/bootloader.asm
	$(ASM) -f bin bootloader/bootloader.asm -o $(BUILD)/bootloader.bin

kernel:
	# Add your kernel build steps here if needed

floppy_image: $(BUILD)/floppy.img

$(BUILD)/floppy.img: $(BUILD)/bootloader.bin
	#Create a zeroed out blank image file inside the build folder
	dd if=/dev/zero of=$(BUILD)/floppy.img bs=1024 count=1440
	#Format  as FAT12 
	mkfs.fat -F 12 $(BUILD)/floppy.img
	#Patch  bootloader onto it 
	dd if=$(BUILD)/bootloader.bin of=$(BUILD)/floppy.img conv=notrunc bs=512 count=1

clean:
	rm -rf $(BUILD)

run:
	qemu-system-x86_64 -hda $(BUILD)/floppy.img
