# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

MY_CM_COMMIT="d790fc39c1a5f06aa66415110b8ebe3026df665a"

DESCRIPTION="Notepad++-like editor for Linux"
HOMEPAGE="http://notepadqq.altervista.org"
SRC_URI="https://github.com/notepadqq/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://api.github.com/repos/notepadqq/CodeMirror/tarball/${MY_CM_COMMIT} -> codemirror-${MY_CM_COMMIT}.tar.gz"

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qttest:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}"

src_unpack() {
	default

	rmdir "${S}/src/editor/libs/codemirror" || die
	mv "${WORKDIR}/notepadqq-CodeMirror-${MY_CM_COMMIT:0:7}" "${S}/src/editor/libs/codemirror" || die
}

src_prepare() {
	default

	sed -i '/Desktop Action/,$d' "${S}/support_files/shortcuts/notepadqq.desktop" || die
	sed -i '/Actions=/d' "${S}/support_files/shortcuts/notepadqq.desktop" || die
}

src_configure() {
	eqmake5 PREFIX="${EPREFIX}/usr" "${PN}.pro"
}

src_install() {
	emake INSTALL_ROOT="${D}" -j1 install
}