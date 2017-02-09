# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

#Based on https://bugs.gentoo.org/show_bug.cgi?id=581506

EAPI="5"

inherit autotools eutils

LANGUAGES="linguas_ar linguas_be linguas_bn_BD linguas_cs linguas_da linguas_de
	linguas_es linguas_fr linguas_hu linguas_id linguas_it linguas_ka_GE linguas_pl
	linguas_pt_BR linguas_ru linguas_tr linguas_uk linguas_vi linguas_zh_CN
	linguas_zh_TW"

IUSE="gnutls gstreamer libnotify nls openssl rss-notify ${LANGUAGES}"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
SRC_URI="mirror://sourceforge/urlget/${P}.tar.gz"

DESCRIPTION="Download manager using gtk+ and libcurl"
HOMEPAGE="http://www.ugetdm.com"

LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND="dev-libs/libpcre
	>=dev-libs/glib-2.32:2
	>=x11-libs/gtk+-3.4:3
	gnutls? ( net-libs/gnutls dev-libs/libgcrypt:0 )
	gstreamer? ( media-libs/gstreamer:0.10 )
	libnotify? ( x11-libs/libnotify )"

DEPEND="${RDEPEND}
	dev-util/intltool
	net-misc/aria2
	net-misc/curl
	virtual/pkgconfig
	sys-devel/gettext"

src_prepare() {
	eautoreconf

	# fix LINGUAS not getting applied
	epatch "${FILESDIR}"/${PN}-${PV}-linguas-fix.patch
}

src_configure() {
	econf $(use_enable nls) \
		  $(use_with openssl) \
		  $(use_with gnutls) \
		  $(use_enable gstreamer) \
		  $(use_enable libnotify notify) \
		  $(use_enable rss-notify)
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	echo
	elog "This uGet version has aria2 plugin built-in. This allows"
	elog "you to control a local or remote instance of aria2 through"
	elog "xmlrpc. To use aria2 locally you have to emerge net-misc/aria2"
	elog "with the xmlrpc USE enabled manually."
	echo
}
