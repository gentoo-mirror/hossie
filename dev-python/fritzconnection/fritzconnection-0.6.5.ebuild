# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_5 python3_6 )

inherit distutils-r1

DESCRIPTION="Communicate with the AVM FritzBox"
HOMEPAGE="https://bitbucket.org/kbr/fritzconnection/overview"
SRC_URI="https://files.pythonhosted.org/packages/aa/b9/94bf1387093dd7c90d7a51cb131340249ecd93b3b68d0c75eaaec6628b80/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~arm ~x86 ~amd64"

RDEPEND="${PYTHON_DEPS}
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"