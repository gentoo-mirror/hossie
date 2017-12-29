# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools versionator

DESCRIPTION="Webinterface for Nagios, Icinga, Shinken and Naemon"
HOMEPAGE="https://www.thruk.org/"
SRC_URI="https://download.thruk.org/pkg/v${PV}/src/thruk-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/Class-Inspector
	dev-perl/Date-Calc
	dev-perl/Date-Manip
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
	net-analyzer/mk-livestatus
	net-analyzer/nagios
	www-apache/mod_fcgid
	www-servers/apache"
RDEPEND="${DEPEND}"

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
		--with-thruk-group=apache \
		--without-thruk-libs
}

src_install () {
	default

	fowners apache /var/lib/thruk
	fowners apache /var/log/thruk
}