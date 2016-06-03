# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

CMAKE_IN_SOURCE_BUILD=1
inherit eutils cmake-utils gnome2-utils versionator multilib

MY_P="CorsixTH-${PV}-Source"
MY_PV="$(replace_version_separator 2 '-')"

DESCRIPTION="Open source clone of Theme Hospital"
HOMEPAGE="https://github.com/CorsixTH/CorsixTH"
SRC_URI="https://github.com/CorsixTH/CorsixTH/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-libav midi +sound truetype"

RDEPEND=">=dev-lang/lua-5.1:0
	media-libs/libsdl2[X,opengl]
	dev-lua/luafilesystem
	dev-lua/lpeg
	dev-lua/luasocket
	virtual/opengl
	midi? ( media-sound/timidity++ )
	!libav? ( media-video/ffmpeg:0= )
	libav? ( media-video/libav:0= )
	sound? ( media-libs/sdl2-mixer )
	truetype? ( media-libs/freetype:2 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/CorsixTH-${MY_PV}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with sound AUDIO)
		$(cmake-utils_use_with truetype FREETYPE2)
		$(cmake-utils_use_with libav LIBAV)
		-DCMAKE_INSTALL_PREFIX=/usr/share/games
		-DWITH_MOVIES="ON"
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	DOCS="CorsixTH/changelog.txt" cmake-utils_src_install
	newicon -s scalable CorsixTH/Original_Logo.svg "${PN}.svg"
	make_wrapper "${PN}" /usr/share/games/CorsixTH/CorsixTH
	make_desktop_entry "${PN}"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
