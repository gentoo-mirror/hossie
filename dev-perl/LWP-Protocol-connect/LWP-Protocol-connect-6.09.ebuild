# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MODULE_AUTHOR="BENNING"
MODULE_VERSION="6.09"

inherit perl-module

DESCRIPTION="Provides HTTP/CONNECT proxy support for LWP::UserAgent"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/IO-Socket-SSL
	dev-perl/Test-Exception
	dev-perl/HTTP-Message
	dev-perl/URI
	dev-perl/LWP-Protocol-https
	dev-perl/libwww-perl
	dev-lang/perl"
