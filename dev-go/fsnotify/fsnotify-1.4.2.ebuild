# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-build golang-vcs-snapshot

DESCRIPTION="Cross-platform file system notifications for Go"
HOMEPAGE="https://fsnotify.org/"
SRC_URI="https://github.com/fsnotify/fsnotify/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

EGO_PN="gopkg.in/fsnotify.v1"