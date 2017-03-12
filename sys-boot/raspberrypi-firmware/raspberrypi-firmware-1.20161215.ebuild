# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Raspberry PI boot loader and firmware"
HOMEPAGE="https://github.com/raspberrypi/firmware"
SRC_URI="https://github.com/raspberrypi/firmware/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 raspberrypi-videocore-bin"
SLOT="0"
KEYWORDS="~arm -*"

IUSE="rpi-b rpi-b-plus rpi-cm rpi-2-b rpi-3-b rpi-cm3"
REQUIRED_USE="|| ( $IUSE )"

S="${WORKDIR}/${P/raspberrypi-}"

RESTRICT="binchecks strip"

pkg_preinst() {
	if ! grep "${ROOT}boot" /proc/mounts >/dev/null 2>&1; then
		ewarn "${ROOT}boot is not mounted, the files might not be installed at the right place"
	fi
}

src_install() {
	cd "${S}/boot"

	insinto /boot
	use rpi-b && doins bcm2708-rpi-b.dtb
	use rpi-b-plus && doins bcm2708-rpi-b-plus.dtb
	use rpi-cm && doins bcm2708-rpi-cm.dtb
	use rpi-2-b && doins bcm2709-rpi-2-b.dtb
	use rpi-3-b && doins bcm2710-rpi-3-b.dtb
	use rpi-cm3 && doins bcm2710-rpi-cm3.dtb

	doins start*.elf fixup*.dat bootcode.bin

	insinto /boot/overlays
	rm overlays/README
	doins -r overlays/*
}