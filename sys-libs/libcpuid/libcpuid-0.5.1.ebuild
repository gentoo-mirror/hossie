# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A small C library for x86 (and x86_64) CPU detection and feature extraction"
HOMEPAGE="http://libcpuid.sourceforge.net/"
SRC_URI="https://github.com/anrieff/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0/15"
KEYWORDS="~amd64"

IUSE="static-libs"

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	econf "$(use_enable static-libs static)"
}

src_install() {
	default

	find "${ED}" -name "*.la" -delete || die
}
