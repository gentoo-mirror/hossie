# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MY_COMMIT="e6eb15063500cee87eba1286c9021967881bf1ca"
MY_DIR="linux-odroidxu4-${PVR}"

ETYPE=sources
K_SECURITY_UNSUPPORTED=1

inherit kernel-2

detect_version
detect_arch

DESCRIPTION="Kernel sources for Odroid XU4"
HOMEPAGE="https://github.com/hardkernel/linux/tree/odroidxu4-4.9.y"
SRC_URI="https://api.github.com/repos/hardkernel/linux/tarball/${MY_COMMIT} -> ${P}.tar.gz"

KEYWORDS="~arm"

S="${WORKDIR}/${MY_DIR}"

src_unpack() {
	unpack "${P}.tar.gz"
	mv "hardkernel-linux-${MY_COMMIT:0:7}" "${MY_DIR}" || die
	epatch_user
	env_setup_xmakeopts
	cd "${S}"
}

pkg_postinst() {
	einfo "The default config is called odroidxu3_defconfig"
	einfo ""

	kernel-2_pkg_postinst
}