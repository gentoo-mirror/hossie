# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 linux-mod

DESCRIPTION="Extensible Virtual Display Interface"
HOMEPAGE="https://github.com/DisplayLink/evdi"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"

EGIT_REPO_URI="git://github.com/DisplayLink/evdi.git"
EGIT_COMMIT="a378a15708bd1fe219aa35a6c4c0f80b5eca7d3c"

DEPEND="x11-libs/libdrm"
RDEPEND="${DEPEND}"

MODULE_NAMES="evdi(video:${S}/module)"

src_compile() {
	linux-mod_src_compile
	cd "${S}/library"
	sed -i 's#<drm/drm\.h#<libdrm/drm.h#g' ../module/evdi_ioctl.h
	default
}

src_install() {
	linux-mod_src_install
	dolib.so library/libevdi.so
}
