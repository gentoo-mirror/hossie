# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

DESCRIPTION="Powerful yet simple to use screenshot software"
HOMEPAGE="https://github.com/lupoDharkael/flameshot"
SRC_URI="https://github.com/lupoDharkael/flameshot/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0 FreeArt GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtdbus:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}"

src_prepare () {
	sed -i "s/\(VERSION = \).*/\1${PV}/" "${PN}.pro"
	epatch "${FILESDIR}/${P}-desktop-fixes.patch"

	eapply_user
}

src_configure() {
	eqmake5 "CONFIG+=packaging" "${PN}.pro"
}

src_install () {
	emake INSTALL_ROOT="${D}" install
}