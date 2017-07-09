# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-build golang-vcs-snapshot

MY_COMMIT="c49b5436b29d52b735097d449e59d9794833bafe"

DESCRIPTION="Windows-portable ANSI escape sequence utility for Go language"
HOMEPAGE="https://github.com/k0kubun/go-ansi"
SRC_URI="https://api.github.com/repos/k0kubun/go-ansi/tarball/${MY_COMMIT} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

EGO_PN="github.com/k0kubun/go-ansi"

src_unpack() {
	default

	mkdir -p "${S}/src/${EGO_PN}"
	mv "${WORKDIR}/k0kubun-go-ansi-${MY_COMMIT:0:7}"/* "${S}/src/${EGO_PN}"
}