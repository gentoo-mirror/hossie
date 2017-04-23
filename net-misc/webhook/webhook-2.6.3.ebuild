# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-base

DESCRIPTION="A lightweight tool that allows you to easily create HTTP endpoints to run commands"
HOMEPAGE="https://github.com/adnanh/webhook"
SRC_URI="https://github.com/adnanh/webhook/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND=""
DEPEND="dev-go/fsnotify
	|| ( app-emulation/lxd dev-go/mux )
	>=dev-go/negroni-0.2.0_p20170226"

src_compile() {
	export GOPATH="$(get_golibdir_gopath):${WORKDIR}/.gopath"

	mkdir -p "${WORKDIR}/.gopath/src/github.com/adnanh/webhook" || die
	mv "${S}/hook" "${WORKDIR}/.gopath/src/github.com/adnanh/webhook" || die

	go build -v -work -x ${EGO_BUILD_FLAGS} || die
}

src_install() {
	newbin "${P}" "${PN}"

	insinto "/etc/${PN}"
	doins hooks.json.example

	newinitd "${FILESDIR}/webhook-initd" "${PN}"
}