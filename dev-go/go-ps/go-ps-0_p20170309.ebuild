# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-build golang-vcs-snapshot

MY_COMMIT="4fdf99ab29366514c69ccccddab5dc58b8d84062"

DESCRIPTION="Find, list, and inspect processes from Go"
HOMEPAGE="https://github.com/mitchellh/go-ps"
SRC_URI="https://api.github.com/repos/mitchellh/go-ps/tarball/${MY_COMMIT} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

EGO_PN="github.com/mitchellh/go-ps"

src_unpack() {
	default

	mkdir -p "${S}/src/${EGO_PN}"
	mv "${WORKDIR}/mitchellh-go-ps-${MY_COMMIT:0:7}"/* "${S}/src/${EGO_PN}"
}