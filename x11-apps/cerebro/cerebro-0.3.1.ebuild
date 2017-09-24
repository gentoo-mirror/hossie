# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils multilib

DESCRIPTION="Open-source productivity booster with a brain"
HOMEPAGE="https://cerebroapp.com/"
SRC_URI="https://github.com/KELiON/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND="dev-libs/libpcre:3
	dev-libs/libtasn1:0
	dev-libs/nettle:0
	dev-libs/nspr:0
	dev-libs/nss:0
	gnome-base/gconf:2
	media-libs/libpng:0
	net-libs/gnutls:0
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	>=net-libs/nodejs-6.0:0
	>=sys-apps/yarn-0.21.3-r1" #Gentoo Bug 614094

QA_EXECSTACK="usr/lib*/${PN}/cerebro"
QA_PRESTRIPPED="usr/lib.*/${PN}/lib.*
	usr/lib.*/${PN}/cerebro"

case "${ARCH}" in
	x86)	MY_ARCH="ia32"; MY_FOLDER="linux-ia32-unpacked" ;;
	amd64)	MY_ARCH="x64"; MY_FOLDER="linux-unpacked" ;;
	*)		MY_ARCH="${ARCH}"; MY_FOLDER="linux-unpacked" ;;
esac

src_compile() {
	yarn --no-progress --non-interactive || die
	cd app; yarn --no-progress --non-interactive || die
	cd ..
	yarn build || die
	node_modules/.bin/build --linux --${MY_ARCH} --dir || die
}

src_install() {
	insinto "/usr/$(get_libdir)/${PN}"

	cd "${S}/release/${MY_FOLDER}"
	doins -r *.pak *.so *.bin *.dat locales resources cerebro

	fperms +x "/usr/$(get_libdir)/${PN}/cerebro"

	cd "${S}/build/icons"
	for size in 16 32 48 128 256 512; do
		newicon -s "${size}" "${size}x${size}.png" "${PN}.png"
	done

	make_wrapper "${PN}" "/usr/lib/${PN}/cerebro"
	make_desktop_entry "${PN}" "Cerebro" "${PN}"
}