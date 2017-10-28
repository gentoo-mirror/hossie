# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MODULE_AUTHOR=RBO
MODULE_VERSION=0.34

inherit perl-module

DESCRIPTION='Excel::Template'
LICENSE=" || ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/IO-stringy
	>=dev-perl/Spreadsheet-WriteExcel-0.420.0
	dev-perl/XML-Parser
	virtual/perl-Test-Simple
"
DEPEND="${RDEPEND}
	>=dev-perl/Test-Deep-0.95.0
	>=dev-perl/Test-Exception-0.210.0
	>=virtual/perl-ExtUtils-MakeMaker-6.42
	virtual/perl-File-Path
	virtual/perl-File-Temp
	>=virtual/perl-Test-Simple-0.470.0
"

PERL_RM_FILES=(
	t/998_pod.t
	t/999_pod_coverage.t
)

SRC_TEST="do"