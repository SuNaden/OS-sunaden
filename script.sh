echo "Executing boot.s assembly"
i686-elf-as bootloader/boot.s -o bootloader/boot.o
echo "Compiling kernel"
i686-elf-gcc -c kernel/kernel.c -o kernel/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
echo "Linking kernel and assembly"
i686-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib bootloader/boot.o kernel/kernel.o -lgcc
echo "Building ISO"
mkdir -p isodir/boot/grub
cp myos.bin isodir/boot/myos.bin
cp grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue /usr/lib/grub/i386-pc -o myos.iso isodir
