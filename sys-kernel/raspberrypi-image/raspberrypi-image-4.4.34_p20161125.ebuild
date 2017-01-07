# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit versionator

DESCRIPTION="Raspberry PI kernel image"
HOMEPAGE="https://github.com/raspberrypi/firmware"

LICENSE="GPL-2 raspberrypi-videocore-bin"
SLOT="${PVR}"
KEYWORDS="~arm -*"

#We cannot use "armv6", because that use flag is forced on armv7
#So we would always install the lower kernels too
IUSE="+kernel +kernel7"
REQUIRED_USE="|| ( kernel kernel7 )"

MY_PV="1.$(get_version_component_range 4)"
MY_PV="${MY_PV//p}"
MY_KERNV="$(get_version_component_range 1-3)"
SRC_URI="https://github.com/raspberrypi/firmware/archive/${MY_PV}.tar.gz -> raspberrypi-firmware-${MY_PV}.tar.gz"

S="${WORKDIR}/firmware-${MY_PV}"

pkg_preinst() {
	if ! grep "${ROOT}boot" /proc/mounts >/dev/null 2>&1; then
		ewarn "${ROOT}boot is not mounted, the files might not be installed at the right place"
	fi
}

src_install() {
	if use kernel; then
		insinto /lib/modules
		doins -r "modules/${MY_KERNV}+"
		insinto /boot
		newins boot/kernel.img "kernel-${PVR}.img"
	fi
	if use kernel7; then
		insinto /lib/modules
		doins -r "modules/${MY_KERNV}-v7+"
		insinto /boot
		newins boot/kernel7.img "kernel7-${PVR}.img"
	fi
}

pkg_postinst() {
	einfo "Note, this is just the kernel and modules"
	einfo "To boot, you also need sys-boot/raspberrypi-firmware"
}