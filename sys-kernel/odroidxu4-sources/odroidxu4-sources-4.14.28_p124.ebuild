# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

ETYPE=sources
K_SECURITY_UNSUPPORTED=1

inherit kernel-2 versionator

MY_KERN_VERS="$(get_version_component_range 1-3)"
MY_PATCH="$(get_version_component_range 4)"
MY_VERS="${MY_KERN_VERS}-${MY_PATCH//p}"
MY_DIR="linux-${MY_VERS}"
K_DEFCONFIG="odroidxu4_defconfig"
EXTRAVERSION="-${MY_PATCH}"

detect_arch
detect_version

DESCRIPTION="Kernel sources for Odroid XU4"
HOMEPAGE="https://github.com/hardkernel/linux"
SRC_URI="https://github.com/hardkernel/linux/archive/${MY_VERS}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~arm"

S="${WORKDIR}/linux-${PV}-odroidxu4"

src_unpack() {
	unpack "${P}.tar.gz"
	mv "${MY_DIR}" "linux-${PV}-odroidxu4" || die
	env_setup_xmakeopts
	unpack_set_extraversion
}

pkg_postinst() {
	einfo "The default config is called odroidxu4_defconfig"

	kernel-2_pkg_postinst
}