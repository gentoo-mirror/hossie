# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MODULE_AUTHOR=CRAZYDJ
MODULE_VERSION=1.0.9
MODULE_A_EXT=tgz
inherit perl-module

DESCRIPTION="Perl extension for creating ARP packets"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Net-Pcap"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}
PATCHES=( "${FILESDIR}"/"${PV}"-header.diff )

src_prepare() {
	perl -MDevel::PPPort -e 'Devel::PPPort::WriteFile();'
	perl-module_src_prepare
}
