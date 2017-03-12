# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils multilib

DESCRIPTION="Open source re-implementation of Roller Coaster Tycoon 2"
HOMEPAGE="https://openrct2.website/"
SRC_URI="https://github.com/OpenRCT2/OpenRCT2/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/jansson:0
	dev-libs/libzip:0
	dev-libs/openssl:0
	media-libs/fontconfig:1.0
	media-libs/libpng:0
	media-libs/sdl2-ttf:0
	media-libs/speex:0
	net-misc/curl:0
	virtual/opengl"
RDEPEND="${DEPEND}"

MAKEOPTS+=" -j1"

S="${WORKDIR}/OpenRCT2-${PV}"

src_prepare() {
	#https://devmanual.gentoo.org/ebuild-writing/common-mistakes/
	sed -i 's#-Werror ##' CMakeLists.txt

	default
}