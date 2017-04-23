# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-build golang-vcs-snapshot

DESCRIPTION="A powerful URL router and dispatcher for golang"
HOMEPAGE="http://www.gorillatoolkit.org/pkg/mux"
SRC_URI="https://github.com/gorilla/mux/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

EGO_PN="github.com/gorilla/mux"