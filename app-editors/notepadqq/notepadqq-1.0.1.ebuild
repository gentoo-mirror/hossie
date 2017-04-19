# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

MY_CM_VER="5.18.2"

DESCRIPTION="Notepad++-like editor for Linux"
HOMEPAGE="http://notepadqq.altervista.org"
SRC_URI="https://github.com/notepadqq/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/notepadqq/CodeMirror/archive/${MY_CM_VER}.tar.gz -> codemirror-${MY_CM_VER}.tar.gz"

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}"

src_unpack() {
	default

	rmdir "${S}/src/editor/libs/codemirror" || die
	mv "${WORKDIR}/CodeMirror-${MY_CM_VER}" "${S}/src/editor/libs/codemirror" || die
}

src_configure() {
	eqmake5 PREFIX="${EPREFIX}/usr" "${PN}.pro"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}