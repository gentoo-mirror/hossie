# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools xorg-2

EGIT_REPO_URI="git://anongit.freedesktop.org/xorg/driver/${PN}"
EGIT_COMMIT="${PV}"
inherit git-r3

DESCRIPTION="xf86-video-armsoc driver, e.g. for Odroid"
HOMEPAGE="https://cgit.freedesktop.org/xorg/driver/xf86-video-armsoc"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

DEPEND="x11-libs/libdrm"
RDEPEND="${DEPEND}"

src_prepare() {
	eaclocal
	eautoheader
	_elibtoolize --copy --force
	eautomake
	eautoconf
}

XORG_CONFIGURE_OPTIONS=(
	"--disable-selective-werror"
)