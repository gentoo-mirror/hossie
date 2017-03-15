# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools gnome2-utils

DESCRIPTION="A simple GTK+ frontend for mpv"
HOMEPAGE="https://github.com/gnome-mpv/gnome-mpv"
SRC_URI="https://github.com/gnome-mpv/gnome-mpv/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm ~x86 ~amd64"

DEPEND="dev-libs/appstream-glib
	dev-libs/glib
	media-libs/libepoxy
	media-video/mpv[libmpv]
	x11-libs/gtk+:3"
RDEPEND="${DEPEND}"

pkg_preinst(){
	gnome2_schemas_savelist
}

src_prepare(){
	epatch "${FILESDIR}/gnome-mpv-makefile.patch"
	eapply_user
	mkdir m4

	eautoreconf
}

pkg_postinst(){
	gnome2_schemas_update
}

pkg_postrm(){
	gnome2_schemas_update
}