# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils gnome2-utils vcs-snapshot

DESCRIPTION="tint2 is a lightweight panel/taskbar for Linux."
HOMEPAGE="https://gitlab.com/o9000/tint2"
SRC_URI="https://gitlab.com/o9000/${PN}/repository/archive.tar.gz?ref=v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="battery debug svg startup-notification themes tint2conf udev"

DEPEND="startup-notification? ( x11-libs/startup-notification )
	svg? ( gnome-base/librsvg:2 )
	tint2conf? ( x11-libs/gtk+:2 )
	dev-libs/glib:2
	>=media-libs/imlib2-1.4.2[X,png]
	x11-libs/cairo
	x11-libs/pango[X]
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXinerama
	>=x11-libs/libXrandr-1.3
	x11-libs/libXrender"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DENABLE_BATTERY="$(usex battery)"
		-DENABLE_BACKTRACE="$(usex debug)"
		-DENABLE_BACKTRACE_ON_SIGNAL="$(usex debug)"
		-DENABLE_EXTRA_THEMES="$(usex themes)"
		-DENABLE_SN="$(usex startup-notification)"
		-DENABLE_RSVG="$(usex svg)"
		-DENABLE_TINT2CONF="$(usex tint2conf)"
		-DENABLE_UEVENT="$(usex udev)"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
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