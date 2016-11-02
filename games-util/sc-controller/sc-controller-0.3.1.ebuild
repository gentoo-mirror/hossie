# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="User-mode driver and GTK3 based GUI for Steam Controller"
HOMEPAGE="https://github.com/kozec/sc-controller/"
SRC_URI="https://github.com/kozec/sc-controller/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND="${PYTHON_DEPS}
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/pylibacl[${PYTHON_USEDEP}]
	>=x11-libs/gtk+-3.10:3"
DEPEND="${RDEPEND}"