# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils multilib

DESCRIPTION="Open source re-implementation of Roller Coaster Tycoon 2"
HOMEPAGE="https://openrct2.website/"
SRC_URI="https://github.com/OpenRCT2/OpenRCT2/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/opengl
"

if has_multilib_profile; then
	DEPEND+="dev-libs/jansson:0[abi_x86_32]
		dev-libs/openssl:0[abi_x86_32]
		media-libs/libpng:0[abi_x86_32]
		media-libs/sdl2-ttf:0[abi_x86_32]
		media-libs/speex:0[abi_x86_32]
		net-misc/curl:0[abi_x86_32]"
fi

RDEPEND="${DEPEND}"

S="${WORKDIR}/OpenRCT2-${PV}"

pkg_setup() {
	use amd64 && { has_multilib_profile || die "You need a multilib profile on amd64 for now"; }
}