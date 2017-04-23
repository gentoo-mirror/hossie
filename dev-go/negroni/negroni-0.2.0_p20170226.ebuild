# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-build golang-vcs-snapshot

DESCRIPTION="Idiomatic HTTP Middleware for Golang"
HOMEPAGE="https://github.com/urfave/negroni"
SRC_URI="https://api.github.com/repos/urfave/negroni/tarball/c0db5feaa33826cd5117930c8f4ee5c0f565eec6 -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"

EGO_PN="github.com/codegangsta/negroni"