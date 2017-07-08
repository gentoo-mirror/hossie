# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-build golang-vcs-snapshot

DESCRIPTION="Color package for Go"
HOMEPAGE="http://godoc.org/github.com/fatih/color"
SRC_URI="https://github.com/fatih/color/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

EGO_PN="github.com/fatih/color"

DEPEND="dev-go/go-colorable"