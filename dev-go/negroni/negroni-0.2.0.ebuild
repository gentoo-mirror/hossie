# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-build golang-vcs-snapshot

DESCRIPTION="Idiomatic HTTP Middleware for Golang"
HOMEPAGE="https://github.com/urfave/negroni"
SRC_URI="https://github.com/urfave/negroni/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"

EGO_PN="github.com/codegangsta/negroni"