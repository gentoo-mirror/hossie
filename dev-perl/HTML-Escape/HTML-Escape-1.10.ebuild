# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MODULE_AUTHOR="TOKUHIROM"
MODULE_VERSION="1.10"

inherit perl-module

DESCRIPTION="Extremely fast HTML escaping"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/Module-Build-0.421.600
	>=dev-perl/Module-Build-Pluggable-PPPort-0.04
	dev-perl/Test-Requires
	dev-lang/perl"
