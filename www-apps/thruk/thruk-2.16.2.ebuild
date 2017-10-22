# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools versionator

MY_VERSION="$(get_version_component_range 1-2)-$(get_version_component_range 3)"

DESCRIPTION="Webinterface for Nagios, Icinga, Shinken and Naemon"
HOMEPAGE="https://www.thruk.org/"
SRC_URI="https://download.thruk.org/pkg/v${MY_VERSION}/src/thruk-${MY_VERSION}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="net-analyzer/nagios"

S="${WORKDIR}/${PN}-${MY_VERSION}"

src_configure () {
	econf \
		--without-thruk-libs
}