export TFTPD_PATH=/srv/tftp

function umenv {
	export ARCH=um
}

function crosenv {
	echo "ChromiumOS environment"
	export PATH=/opt/depot_tools:"$PATH"
}

function hostenv {
	unset ARCH
	unset CROSS_COMPILE
	echo "Host environment"
}

function ubootenv {
	export ARCH=arm
	export PATH=$PATH:/home/zeta/repos/buildroot/arm/output/host/usr/bin/
	export CROSS_COMPILE="arm-none-linux-gnueabi-"
}

function newnios2env {
	export ARCH=nios2
	export KBUILD_OUTPUT=/home/zeta/repos/builds/newnios2
	export PATH=$PATH:/home/zeta/repos/buildroot/nios2/output/host/usr/bin/
	export CROSS_COMPILE="/usr/bin/ccache nios2-linux-gnu-"
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function nios2env {
	export ARCH=nios2
	export KBUILD_OUTPUT=/home/zeta/repos/builds/nios2
	export PATH=$PATH:/home/zeta/repos/buildroot/nios2/output/host/usr/bin/
	export CROSS_COMPILE="/usr/bin/ccache nios2-linux-gnu-"
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function nios2brenv {
	export ARCH=nios2
	unset KBUILD_OUTPUT
	export PATH=$PATH:/home/zeta/repos/buildroot/nios2/output/host/usr/bin/
	export CROSS_COMPILE="/usr/bin/ccache nios2-buildroot-linux-gnu-"
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function arm64brenv {
	export ARCH=arm64
	unset KBUILD_OUTPUT
	export PATH=$PATH:/home/zeta/repos/buildroot/arm64/output/host/usr/bin/
	export CROSS_COMPILE="/usr/bin/ccache aarch64-linux-gnu-"
	test -f /home/zeta/repos/buildroot/arm64/output/host/usr/bin/aarch64-linux-gnu-gcc && \
	echo "ARM64 environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}" || \
        echo "No toolchain installed!"
}

function armenv {
	export ARCH=arm
	unset KBUILD_OUTPUT
	export PATH=$PATH:/home/zeta/repos/buildroot/arm/output/host/usr/bin/
	export CROSS_COMPILE="arm-none-linux-gnueabi-"
	test -f /home/zeta/repos/buildroot/arm/output/host/usr/bin/arm-none-linux-gnueabi-gcc && \
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}" || \
        echo "No toolchain installed!"
}

function emcraftenv {
	export ARCH=arm
	export KBUILD_OUTPUT=
	export PATH=$PATH:/opt/uclinuxeabi/bin/
	export CROSS_COMPILE="arm-uclinuxeabi-"
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function lpc43xx_br_env {
	export ARCH=arm
	export KBUILD_OUTPUT=/home/zeta/repos/builds/lpc43xx
	export PATH=$PATH:/home/zeta/repos/buildroot/ciaa/output/host/usr/bin/
	export CROSS_COMPILE="/usr/bin/ccache arm-buildroot-uclinux-uclibcgnueabi-"
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function lpc43xxenv {
	export ARCH=arm
	export KBUILD_OUTPUT=/home/zeta/repos/builds/lpc43xx
	export PATH=$PATH:/home/zeta/repos/buildroot/ciaa/output/host/usr/bin/
	export CROSS_COMPILE="arm-cortexm3-uclinuxeabi-"
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function mipsbeenv {
	export ARCH=mips
	export PATH=$PATH:/home/zeta/repos/buildroot/mipsbe/output/host/usr/bin/
	export CROSS_COMPILE="/usr/bin/ccache mips-linux-gnu-"
	echo "MIPS environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function mipsenv {
	export ARCH=mips
	export PATH=$PATH:/home/zeta/repos/buildroot/mips/output/host/usr/bin/
	export CROSS_COMPILE="mips-linux-gnu-"
	echo "MIPS environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function ci20env {
	export ARCH=mips
	export KBUILD_OUTPUT=/home/zeta/repos/builds/ci20
	export PATH=$PATH:/home/zeta/repos/buildroot/mips/output/host/usr/bin/
	export CROSS_COMPILE="mips-linux-gnu-"
	echo "MIPS environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function ficus_rk3399_env {
	export ARCH=arm64
	export KBUILD_OUTPUT=/home/zeta/repos/builds/rk3399_ficus
	export CROSS_COMPILE="aarch64-linux-gnu-"
	echo "Ficus environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function virtmeenv {
	unset ARCH
	unset CROSS_COMPILE
	export KBUILD_OUTPUT=/home/zeta/repos/builds/virtme-x86_64
	echo "Native environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function arm64env {
	export ARCH=arm64
	unset KBUILD_OUTPUT
	export CROSS_COMPILE="/usr/bin/ccache aarch64-linux-gnu-"
	echo "ARM64 environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function metagenv {
	export ARCH=metag
	export PATH=$PATH:/home/zeta/repos/buildroot/metag/output/host/usr/bin/
	export CROSS_COMPILE="/usr/bin/ccache metag-buildroot-linux-uclibc-"
	echo "Metag environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function pxa_env {
	export ARCH=arm
	export KBUILD_OUTPUT=/home/zeta/repos/builds/pxa
	export PATH=$PATH:/home/zeta/repos/buildroot/arm/output/host/usr/bin/
	export CROSS_COMPILE="/usr/bin/ccache arm-none-linux-gnueabi-"
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function mvebu_v5_env {
	export ARCH=arm
	export KBUILD_OUTPUT=/home/zeta/repos/builds/mvebu_v5
	export PATH=$PATH:/home/zeta/repos/buildroot/arm/output/host/usr/bin/
	export CROSS_COMPILE="/usr/bin/ccache arm-none-linux-gnueabi-"
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function mvebu_v5_env_hmem_on {
	export ARCH=arm
	export KBUILD_OUTPUT=/home/zeta/repos/builds/mvebu_v5_hmem_on
	export PATH=$PATH:/home/zeta/repos/buildroot/arm/output/host/usr/bin/
	export CROSS_COMPILE="/usr/bin/ccache arm-none-linux-gnueabi-"
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function cool_test_env {
	export ARCH=arm
	export KBUILD_OUTPUT=/home/zeta/repos/builds/mvebu_v7
	export PATH=$PATH:/opt/our-cool-arm-toolchain/arm-2014.05/bin/
	export CROSS_COMPILE="/usr/bin/ccache arm-none-linux-gnueabi-"
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function mvebu_v7_env {
	export ARCH=arm
	export KBUILD_OUTPUT=/home/zeta/repos/builds/mvebu_v7
	export PATH=$PATH:/home/zeta/repos/buildroot/arm/output/host/usr/bin/
	export CROSS_COMPILE="/usr/bin/ccache arm-none-linux-gnueabi-"
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function rk3288_env {
	export ARCH=arm
	export KBUILD_OUTPUT=/home/zeta/repos/builds/rk3288
	export PATH=$PATH:/home/zeta/repos/buildroot/arm/output/host/usr/bin/
	export CROSS_COMPILE="arm-buildroot-linux-uclibcgnueabihf-"
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function sun7i_env {
	export ARCH=arm
	export KBUILD_OUTPUT=/home/zeta/repos/builds/sun7i
	export PATH=$PATH:/home/zeta/repos/buildroot/arm/output/host/usr/bin/
	export CROSS_COMPILE="arm-buildroot-linux-uclibcgnueabihf-"
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function sun7i_linaro_env {
	export ARCH=arm
	export KBUILD_OUTPUT=/home/zeta/repos/builds/sun7i
	export PATH=$PATH:/home/zeta/repos/buildroot/olimex/output/host/usr/bin/
	export CROSS_COMPILE="/usr/bin/ccache arm-linux-gnueabihf-"
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function mvebu_lsp {
	export ARCH=arm
	export KBUILD_OUTPUT=/home/zeta/repos/builds/mvebu_lsp
	export PATH=$PATH:/home/zeta/repos/buildroot/arm/output/host/usr/bin/
	export CROSS_COMPILE="/usr/bin/ccache arm-none-linux-gnueabi-"
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function mvebu_v7_env_smp {
	export ARCH=arm
	export KBUILD_OUTPUT=/home/zeta/repos/builds/mvebu_v7_smp
	export PATH=$PATH:/home/zeta/repos/buildroot/arm/output/host/usr/bin/
	export CROSS_COMPILE="/usr/bin/ccache arm-none-linux-gnueabi-"
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function am335x_env {
	export ARCH=arm
	export KBUILD_OUTPUT=/home/zeta/repos/builds/am335x
	export PATH=$PATH:/home/zeta/repos/buildroot/arm/output/host/usr/bin/
	export CROSS_COMPILE="arm-none-linux-gnueabi-"
	echo "AM335X environment (you know, the dark beaglebone). ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function frontpanel_env {
	export ARCH=arm
	unset KBUILD_OUTPUT
	export PATH=$PATH:/home/zeta/repos/buildroot/frontpanel-rootfs/output/host/usr/bin/
	export CROSS_COMPILE="arm-none-linux-gnueabi-"
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function imx6_env {
	export ARCH=arm
	export KBUILD_OUTPUT=/home/zeta/repos/builds/imx6
	export PATH=$PATH:/home/zeta/repos/buildroot/arm/output/host/usr/bin/
	export CROSS_COMPILE="arm-buildroot-linux-uclibcgnueabihf-"
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}

function mofigs_env {
	export ARCH=arm
	export PATH=$PATH:/home/zeta/repos/motionfigures/mofigs-buildroot/output/host/usr/bin/
	export CROSS_COMPILE="arm-buildroot-linux-gnueabihf-"
	echo "ARM environment. ARCH=${ARCH}, CC=${CROSS_COMPILE}"
}
