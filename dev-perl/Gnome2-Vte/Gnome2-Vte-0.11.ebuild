# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MODULE_AUTHOR=XAOC
MODULE_VERSION=0.11
inherit perl-module

DESCRIPTION="Perl interface to the Virtual Terminal Emulation library."

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/Gtk2
	>=dev-perl/glib-perl-1.01
	x11-libs/vte:0"

DEPEND="${RDEPEND}
	>=dev-perl/ExtUtils-Depends-0.202
	dev-perl/ExtUtils-PkgConfig
	virtual/pkgconfig"

SRC_TEST=do