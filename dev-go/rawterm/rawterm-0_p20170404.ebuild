# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-build golang-vcs-snapshot

MY_COMMIT="f84711c380fdfbaa529baff2605283945313a03c"

DESCRIPTION="Striped down version of readline"
HOMEPAGE="http://godoc.org/github.com/heppu/rawterm"
SRC_URI="https://api.github.com/repos/heppu/rawterm/tarball/${MY_COMMIT} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

EGO_PN="github.com/heppu/rawterm"

src_unpack() {
	default

	mkdir -p "${S}/src/github.com/heppu/rawterm"
	mv "${WORKDIR}/heppu-rawterm-${MY_COMMIT:0:7}"/* "${S}/src/github.com/heppu/rawterm"
}