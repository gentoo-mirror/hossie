# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="pup is a command line tool for processing HTML"
HOMEPAGE="https://github.com/ericchiang/pup"
SRC_URI="https://github.com/ericchiang/pup/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/go"
RDEPEND=""

GO_PN="github.com/ericchiang/${PN}"

src_compile() {
	go build -v -x "${GO_PN}" || die
}

src_install() {
	dobin pup
}