function install-ficus {
	sudo cp arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb /mnt/
	sudo cp arch/arm64/boot/Image /mnt/
	sudo cp arch/arm64/boot/Image.gz /mnt/
	sudo cp arch/arm64/boot/Image.lz4 /mnt/
}

function make-neek {
	make -j4 vmImage 
	cp ${KBUILD_OUTPUT}/arch/nios2/boot/vmImage /srv/tftp/vmImage-neek
}

function make-hitex-xip {
	board=lpc4350-hitex-eval
	dtb=${KBUILD_OUTPUT}/arch/arm/boot/dts/${board}.dtb
        kernel=${KBUILD_OUTPUT}/arch/arm/boot/xipImage
	ver=`make kernelrelease`
        make -j${bake_jobs} xipImage dtbs
	echo "Creating U-Boot image"
	dd if=/dev/zero bs=64 count=1 | tr "\000" "\377" > hdr.bin
	cat hdr.bin ${kernel} > ${KBUILD_OUTPUT}/xip.img
	./scripts/mkuboot.sh -x -A arm -O linux -T kernel -C none -a 0x1c040000 -e 0x1c040041 -n "My XIP Linux" -d ${KBUILD_OUTPUT}/xip.img xipuImage
	cp xipuImage /srv/tftp/uImage-$board -v
	cp xipuImage /srv/tftp/ -v
	baked
}

function make-ciaa-nxp-xip {
	board=ciaa-nxp
	dtb=${KBUILD_OUTPUT}/arch/arm/boot/dts/lpc4337-ciaa.dtb
        kernel=${KBUILD_OUTPUT}/arch/arm/boot/xipImage
	ver=`make kernelrelease`
        make -j${bake_jobs} xipImage dtbs
	echo "Creating U-Boot image"
	dd if=/dev/zero bs=64 count=1 | tr "\000" "\377" > hdr.bin
	cat hdr.bin ${kernel} > ${KBUILD_OUTPUT}/xip.img
	./scripts/mkuboot.sh -x -A arm -O linux -T kernel -C none -a 0x14000000 -e 0x14000041 -n "CIAA XIP Linux" -d ${KBUILD_OUTPUT}/xip.img xipuImage
	cp xipuImage /srv/tftp/uImage-$board -v
	baked
}

function make-ciaa-nxp {
	board=ciaa-nxp
	dtb=${KBUILD_OUTPUT}/arch/arm/boot/dts/lpc4337-ciaa.dtb
        kernel=${KBUILD_OUTPUT}/arch/arm/boot/zImage
	ver=`make kernelrelease`
        make -j${bake_jobs} zImage dtbs
	echo "Appending ${dtb}"
	cat ${kernel} ${dtb} > ${KBUILD_OUTPUT}/zImage.dtb
	echo "Creating U-Boot image"
	./scripts/mkuboot.sh -A arm -O linux -T kernel -C none -a 0x28008000 -e 0x28008001 -n "CIAA-Linux" -d ${KBUILD_OUTPUT}/zImage.dtb uImage
	cp uImage /srv/tftp/uImage-$board -v
	baked
}

function make-hitex-lpc4350 {
	board=lpc4350-hitex-eval
	dtb=${KBUILD_OUTPUT}/arch/arm/boot/dts/${board}.dtb
        kernel=${KBUILD_OUTPUT}/arch/arm/boot/zImage
	ver=`make kernelrelease`
        LOADADDR=28008000 make -j${bake_jobs} uImage dtbs
	cat ${kernel} ${dtb} > ${KBUILD_OUTPUT}/Image.dtb
	./scripts/mkuboot.sh -A arm -O linux -T kernel -C none -a 0x28008000 -e 0x28008001 -n "lpc4350-hitex-devkit" -d ${KBUILD_OUTPUT}/Image.dtb uImage
	cp uImage /srv/tftp/uImage-$board -v
	cp ${dtb} /srv/tftp/ -v
	baked
}

function make-hitex-lpc4350-a {
	board=lpc4350-hitex-eval
	dtb=${KBUILD_OUTPUT}/arch/arm/boot/dts/${board}.dtb
        kernel=${KBUILD_OUTPUT}/arch/arm/boot/zImage
	ver=`make kernelrelease`
        LOADADDR=28008000 make -j${bake_jobs} uImage dtbs
	cat ${kernel} ${dtb} > ${KBUILD_OUTPUT}/Image.dtb
	./scripts/mkuboot.sh -A arm -O linux -T kernel -C none -a 0x28008000 -e 0x28008001 -n "lpc4350-hitex-devkit" -d ${KBUILD_OUTPUT}/Image.dtb uImage
	cp uImage /srv/tftp/uImage-$board -v
	cp ${dtb} /srv/tftp/ -v
	baked
}

function make-hitex-lpc4350-u {
	board=lpc4350-hitex-eval
	dtb=${KBUILD_OUTPUT}/arch/arm/boot/dts/${board}.dtb
        kernel=${KBUILD_OUTPUT}/arch/arm/boot/Image
	ver=`make kernelrelease`
        LOADADDR=28008000 make -j${bake_jobs} Image
	cp ${kernel} ${KBUILD_OUTPUT}/Image
	./scripts/mkuboot.sh -A arm -O linux -T kernel -C none -a 0x28008000 -e 0x28008001 -n "lpc4350-hitex-devkit" -d ${KBUILD_OUTPUT}/Image uImage
	cp uImage /srv/tftp/uImage-$board -v
	#cp ${dtb} /srv/tftp/ -v
	baked
}

function make-rpi {
	board=rpi
	dtb=arch/arm/boot/dts/bcm2835-rpi-b.dtb
        kernel=arch/arm/boot/uImage
	ver=`make kernelrelease`
        LOADADDR=80008000 make -j${bake_jobs} uImage dtbs
        cp ${kernel} /srv/tftp/uImage-$board -v
	cp ${dtb} /srv/tftp -v
	baked
}

function make-nios2-run {
	make -j${bake_jobs} zImage && \
	nios2-run-linux
}

function make-igep2-dt {
	make -j${bake_jobs} modules zImage dtbs
	dtb=arch/arm/boot/dts/omap3-igep0020.dtb
	cat arch/arm/boot/zImage ${dtb} > zImage.dtb
	./scripts/mkuboot.sh -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 -n "linux" -d zImage.dtb uImage
	cp uImage /srv/tftp/uImage-igep2 -v
	INSTALL_MOD_PATH=/home/zeta/buildroot/buildroot-arm/rootfs-overlay make modules_install
	baked
}

function make-igep2-legacy {
	LOADADDR=80008000 make -j${bake_jobs} uImage modules
	cp ./arch/arm/boot/uImage /srv/tftp/uImage-igep2 -v
	INSTALL_MOD_PATH=/home/zeta/buildroot/buildroot-arm/rootfs-overlay make modules_install
	baked
}

function make-igep2 {
	LOADADDR=80008000 make -j${bake_jobs} uImage dtbs
	dtb=arch/arm/boot/dts/omap3-igep0020.dtb
	kernel=arch/arm/boot/uImage
	cp ${kernel} /srv/tftp/uImage-igep2 -v
	baked
}

function make-boneblack {
	dtb=arch/arm/boot/dts/am335x-boneblack.dtb
	LOADADDR=80008000 make -j${bake_jobs} zImage dtbs
	kernel=arch/arm/boot/zImage
	cp ${kernel} /srv/tftp/zImage-bone -v
	cp ${dtb} /srv/tftp/bone.dtb -v
#	INSTALL_MOD_PATH=/home/zeta/buildroot/buildroot-arm/rootfs-overlay make modules_install
	baked
}

function make-socfpga {
	dtb=arch/arm/boot/dts/socfpga_cyclone5.dtb
	LOADADDR=80008000 make -j${bake_jobs} uImage dtbs
	kernel=arch/arm/boot/uImage
	cp ${kernel} /srv/tftp/uImage-socfpga -v
	cp ${dtb} /srv/tftp/socfpga.dtb -v
	baked
}

function make-ppst {
	board=ppst
	LOADADDR=80008000 make -j${bake_jobs} uImage modules
	ver=`make kernelrelease`
	kernel=arch/arm/boot/uImage
	cp ${kernel} /srv/tftp/uImage-ppst -v
	#rm /home/zeta/buildroot/ppst/rootfs-overlay/lib/modules/ -r
	#INSTALL_MOD_PATH=/home/zeta/buildroot/ppst/rootfs-overlay make modules_install
	baked
}

function make-carambola2 {
	board=carambola2
	make -j${bake_jobs} uImage
	kernel=arch/mips/boot/uImage
	cp ${kernel} /srv/tftp/uImage-${board} -v
	baked
}

function make-pxa {
	make uImage
	kernel=${KBUILD_OUTPUT}/arch/arm/boot/uImage
	cp ${kernel} /srv/tftp/uImage-pxa -v
	baked
}

function make-ci20z {
	make -j${bake_jobs} dtbs vmlinuz.bin
	dtb=arch/mips/boot/dts/ingenic/ci20.dtb
	cat vmlinuz.bin ${dtb} > vmlinuz.dtb
	./scripts/mkuboot.sh -A mips -O linux -T kernel -C none -a 0x80010000 -e 0x80010000 -n "linux" -d vmlinuz.dtb /srv/atftp/uImage-ci20
	baked
}

function make-ci20u {
	make -j${bake_jobs} dtbs vmlinux.bin
	dtb=arch/mips/boot/dts/ingenic/ci20.dtb
	cat arch/mips/boot/vmlinux.bin ${dtb} > vmlinux.dtb
	./scripts/mkuboot.sh -A mips -O linux -T kernel -C none -a 0x80010000 -e 0x80010000 -n "linux" -d vmlinux.dtb /srv/atftp/uImage-ci20
	baked
}

function make-ci20 {
	make -j${bake_jobs} uImage
	cp -v arch/mips/boot/uImage /srv/atftp/uImage-ci20
	baked
}

function make-frontpanel {
	board=ppst
	make -j${bake_jobs} dtbs zImage modules
	dtb=${KBUILD_OUTPUT}/arch/arm/boot/dts/am335x-frontpanel.dtb
	cat ${KBUILD_OUTPUT}/arch/arm/boot/zImage ${dtb} > ${KBUILD_OUTPUT}/zImage.dtb
	./scripts/mkuboot.sh -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 -n "linux" -d ${KBUILD_OUTPUT}/zImage.dtb /srv/tftp/uImage-$board
	#rm /home/zeta/buildroot/frontpanel-rootfs/rootfs-overlay/lib/modules/* -rf
	#INSTALL_MOD_PATH=/home/zeta/buildroot/frontpanel-rootfs/rootfs-overlay make modules_install
	#INSTALL_MOD_PATH=/home/zeta/buildroot/arm/rootfs-overlay make modules_install
	baked
}

function make-frontpanel-v2 {
	board=ppst
	make -j${bake_jobs} dtbs zImage modules
	dtb=${KBUILD_OUTPUT}/arch/arm/boot/dts/am335x-frontpanel-motherboard-v2.dtb
	cat ${KBUILD_OUTPUT}/arch/arm/boot/zImage ${dtb} > ${KBUILD_OUTPUT}/zImage.dtb
	./scripts/mkuboot.sh -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 -n "linux" -d ${KBUILD_OUTPUT}/zImage.dtb /srv/tftp/uImage-$board
	#rm /home/zeta/buildroot/frontpanel-rootfs/rootfs-overlay/lib/modules/* -rf
	#INSTALL_MOD_PATH=/home/zeta/buildroot/frontpanel-rootfs/rootfs-overlay make modules_install
	#INSTALL_MOD_PATH=/home/zeta/buildroot/arm/rootfs-overlay make modules_install
	baked
}

function make-dt {
	board=$1
	make -j${bake_jobs}
	cp -v ${KBUILD_OUTPUT}/arch/arm/boot/zImage /srv/atftp/zImage-${board}
	cp -v ${KBUILD_OUTPUT}/arch/arm/boot/dts/${board}.dtb /srv/atftp
	baked
}

function make-appended {
	board=$1
	loadaddr=$2
	make -j${bake_jobs} zImage dtbs
	cat ${KBUILD_OUTPUT}/arch/arm/boot/zImage \
            ${KBUILD_OUTPUT}/arch/arm/boot/dts/${board}.dtb \
            > ${KBUILD_OUTPUT}/zImage.dtb;
	./scripts/mkuboot.sh -A arm -O linux -T kernel -C none \
            -a ${loadaddr} -e ${loadaddr} -n "linux" \
            -d ${KBUILD_OUTPUT}/zImage.dtb /srv/tftp/uImage-${board};
	cp ${KBUILD_OUTPUT}/arch/arm/boot/zImage /srv/tftp/zImage-${board};

#	TODO: Add some variable to control module install
#	INSTALL_MOD_PATH=/home/zeta/buildroot/arm/rootfs-overlay make modules_install
	baked
}

# Appended DT boards

function make-bone-appendeddt {
	make-appended am335x-boneblack 0x80008000
	cp -v /srv/tftp/uImage-am335x-boneblack /srv/tftp/uImage-ppst
}

function make-appended-aquila {
	make-appended am335x-base0033 0x80008000
	cp -v /srv/tftp/uImage-am335x-base0033 /srv/tftp/uImage-ppst
}

function make-mirabox {
	make-appended armada-370-mirabox 0x8000
}

function make-370-rd {
	make-appended armada-370-rd 0xA00000
}

function make-xp-gp {
	make-appended armada-xp-gp 0x8000
}

function make-openblocks-ax3 {
	make-appended armada-xp-openblocks-ax3-4 0x8000
}

function make-385-db {
	make-appended armada-385-db 0x8000
}

function make-375-db {
	make-appended armada-375-db 0x8000
}

function make-cubox {
	make-appended dove-cubox 0x8000
}

function make-openblocks-a6 {
	make-appended kirkwood-openblocks_a6 0x8000
}

function make-topkick {
	make-appended kirkwood-topkick 0x8000
}

function make-wandboard {
	make-appended imx6dl-wandboard 0x10008000
}

function make-riotboard {
	make-appended imx6dl-riotboard 0x10008000
}

function make-sun7i-a20-olinuxino-micro {
	make-appended sun7i-a20-olinuxino-micro 0x40008000
}

# DT boards

function make-aquila {
	make-dt am335x-base0033
	INSTALL_MOD_PATH=/home/zeta/buildroot/frontpanel-rootfs/rootfs-overlay make modules_install
}

function make-rock2 {
	make-dt rk3288-rock2-square
	baked
}