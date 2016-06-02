# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

CMAKE_IN_SOURCE_BUILD=1
WX_GTK_VER="3.0"
inherit eutils cmake-utils games gnome2-utils wxwidgets

MY_P="CorsixTH-${PV}-Source"

DESCRIPTION="Open source clone of Theme Hospital"
HOMEPAGE="https://github.com/CorsixTH/CorsixTH"
SRC_URI="https://github.com/CorsixTH/CorsixTH/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-libav +sound truetype"

RDEPEND=">=dev-lang/lua-5.1:0
	media-libs/libsdl2
	dev-lua/luafilesystem
	dev-lua/lpeg
	dev-lua/luasocket
	virtual/opengl
	!libav? ( media-video/ffmpeg )
	libav? ( media-video/libav )
	sound? ( media-libs/sdl2-mixer )
	truetype? ( media-libs/freetype:2 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/CorsixTH-${PV}

pkg_setup() {
	games_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-install.patch
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with sound AUDIO)
		$(cmake-utils_use_with truetype FREETYPE2)
		$(cmake-utils_use_with libav LIBAV)
		-DWITH_MOVIES="ON"
		-DCMAKE_INSTALL_PREFIX="${GAMES_DATADIR}"
		-DBINDIR="$(games_get_libdir)/${PN}"
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install

	DOCS="CorsixTH/changelog.txt" cmake-utils_src_install
	games_make_wrapper ${PN} "$(games_get_libdir)/${PN}/CorsixTH" \
		"${GAMES_DATADIR}/CorsixTH"
	games_make_wrapper ${PN}-mapedit "$(games_get_libdir)/${PN}/MapEdit" \
		"${GAMES_DATADIR}/CorsixTH"
	newicon -s scalable CorsixTH/Original_Logo.svg ${PN}.svg
	make_desktop_entry ${PN}
	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
