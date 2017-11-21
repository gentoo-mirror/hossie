# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils mono-env gnome2-utils vcs-snapshot xdg-utils

MY_PV="release-${PV}"
DESCRIPTION="A free RTS engine supporting games like Command & Conquer, Red Alert and Dune2k"
HOMEPAGE="http://www.openra.net/"
SRC_URI="https://github.com/OpenRA/OpenRA/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +xdg +zenity"
RESTRICT="mirror"

RDEPEND="dev-dotnet/libgdiplus
	>=dev-lang/mono-3.2
	media-libs/freetype:2[X]
	media-libs/libsdl2[X,opengl,video]
	media-libs/openal
	virtual/jpeg:0
	virtual/opengl
	=dev-lang/lua-5.1*:0
	xdg? ( x11-misc/xdg-utils )
	zenity? ( gnome-extra/zenity )"
DEPEND="${RDEPEND}"

pkg_setup() {
	mono-env_pkg_setup
}

src_unpack() {
	vcs-snapshot_src_unpack
}

src_prepare() {
	sed -i "s/^\(VERSION\).*/\1 = ${MY_PV}/g" Makefile

	emake cli-dependencies version
}

src_compile() {
	emake all man-page $(usex debug "" "DEBUG=false")
}

src_install() {
	dodoc "${FILESDIR}"/README.gentoo AUTHORS

	rm AUTHORS
	sed -i '/.*INSTALL_DATA) AUTHORS.*/d' Makefile
	sed -i '/.*INSTALL_DATA) COPYING.*/d' Makefile

	emake $(usex debug "" "DEBUG=false") \
		prefix=/usr \
		libdir="/usr/$(get_libdir)" \
		bindir="/usr/bin" \
		datadir="/usr/share" \
		DESTDIR="${D}" \
		install install-man-page install-linux-mime install-linux-shortcuts
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
