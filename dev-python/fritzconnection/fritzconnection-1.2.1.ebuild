# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Communicate with the AVM FritzBox"
HOMEPAGE="https://github.com/kbr/fritzconnection"
SRC_URI="https://github.com/kbr/fritzconnection/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"