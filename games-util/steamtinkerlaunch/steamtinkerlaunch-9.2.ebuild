# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="Wrapper script for Steam custom launch options"
HOMEPAGE="https://github.com/frostworx/steamtinkerlaunch"
SRC_URI="https://github.com/frostworx/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-arch/unzip
	app-editors/vim-core
	gnome-extra/yad
	x11-apps/xprop
	x11-apps/xrandr
	x11-apps/xwininfo
	x11-misc/xdotool"

src_prepare() {
	sed -e 's|PREFIX := /usr|PREFIX := $(DESTDIR)/usr|g' \
		-e "s|share/doc/${PN}|share/doc/${PF}|g" \
		-e '/sed "s:^PREFIX/d' \
		-i Makefile || die
	default
}

pkg_postinst() {
	xdg_pkg_postinst
}
