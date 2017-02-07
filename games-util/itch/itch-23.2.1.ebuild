# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils multilib

DESCRIPTION="The best way to play itch.io games"
HOMEPAGE="https://itch.io/app"
SRC_URI="https://github.com/itchio/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=net-libs/nodejs-5.1:0[npm]"
RDEPEND="${DEPEND}"

QA_EXECSTACK="usr/lib64/${PN}/itch"
QA_PRESTRIPPED="usr/lib.*/${PN}/lib.*
	usr/lib.*/${PN}/itch"

case "${ARCH}" in
	x86)	MY_ARCH="ia32" ;;
	amd64)	MY_ARCH="x64" ;;
	*)		MY_ARCH="${ARCH}" ;;
esac

src_configure() {
	npm install || die
}

src_compile() {
	export CI_BUILD_TAG="v${PV}"
	export CI_CHANNEL="stable"
	export PATH="${PATH}:${S}/node_modules/grunt/bin"

	release/ci-compile.js || die
	release/ci-generate-linux-extras.js || die

	grunt -v "electron:linux-${MY_ARCH}" || die
}

src_install() {
	cd "${S}/build/v${PV}/${PN}-linux-${MY_ARCH}"
	insinto "/usr/$(get_libdir)/${PN}"
	doins -r *.pak *.so *.bin *.dat locales resources itch
	fperms 755 "/usr/$(get_libdir)/${PN}/itch"

	cd "${S}/linux-extras"
	make_wrapper "${PN}" "/usr/lib/${PN}/itch"
	domenu io.itch.itch.desktop
}