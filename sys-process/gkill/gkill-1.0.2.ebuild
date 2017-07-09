# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-base

DESCRIPTION="Interactice process killer for Linux and macOS"
HOMEPAGE="https://github.com/heppu/gkill"
SRC_URI="https://github.com/heppu/gkill/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-go/color
	dev-go/go-ansi
	dev-go/go-ps
	dev-go/rawterm"

src_compile() {
	export GOPATH="$(get_golibdir_gopath):${WORKDIR}/.gopath"

	mkdir -p "${WORKDIR}/.gopath/src/github.com/heppu/gkill" || die
	mv "${S}/killer" "${WORKDIR}/.gopath/src/github.com/heppu/gkill" || die

	go build -v -work -x ${EGO_BUILD_FLAGS} || die
}

src_install() {
	newbin "${P}" "${PN}"
}