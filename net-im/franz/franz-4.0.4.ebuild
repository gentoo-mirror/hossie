# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib

case "${ARCH}" in
	x86)	MY_ARCH="ia32" ;;
	amd64)	MY_ARCH="x64" ;;
	*)		MY_ARCH="${ARCH}" ;;
esac

DESCRIPTION="Franz is a free messaging app"
HOMEPAGE="http://meetfranz.com/"
SRC_URI="https://github.com/meetfranz/franz-app/releases/download/4.0.4/Franz-linux-${MY_ARCH}-4.0.4.tgz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=""

RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	insinto "/usr/$(get_libdir)/${PN}"
	doins -r *.pak *.so *.bin *.dat locales resources Franz
	fperms 755 "/usr/$(get_libdir)/${PN}/Franz"
}