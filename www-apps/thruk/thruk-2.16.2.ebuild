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

DEPEND="dev-perl/Class-Inspector
	dev-perl/Date-Manip
	dev-perl/Date-Calc
	dev-perl/DateTime
	dev-perl/DBD-mysql
	dev-perl/DBI
	dev-perl/Excel-Template
	dev-perl/File-Slurp
	dev-perl/GD
	dev-perl/HTML-Escape
	dev-perl/IO-String
	dev-perl/JSON-XS
	dev-perl/libwww-perl
	dev-perl/Log-Dispatch
	dev-perl/Log-Log4perl
	dev-perl/LWP-Protocol-connect
	dev-perl/MIME-Lite
	dev-perl/Plack
	dev-perl/Template-Toolkit
	net-analyzer/nagios
	www-apache/mod_fcgid
	www-servers/apache"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_VERSION}"

src_configure () {
	econf \
		--datadir="/usr/share/${PN}" \
		--localstatedir="/var/lib/${PN}" \
		--sysconfdir="/etc/${PN}" \
		--with-httpd-conf=/etc/apache2/vhosts.d \
		--with-initdir=/etc/init.d \
		--with-logdir="/var/log/${PN}" \
		--with-logrotatedir=/etc/logrotate.d \
		--with-tempdir=/var/tmp \
		--with-thruk-user=apache \
		--without-thruk-libs
}