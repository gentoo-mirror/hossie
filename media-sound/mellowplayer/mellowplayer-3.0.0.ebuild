# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Cloud music integration for your desktop"
HOMEPAGE="https://colinduquesnoy.github.io/MellowPlayer"
SRC_URI="https://github.com/ColinDuquesnoy/MellowPlayer/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"