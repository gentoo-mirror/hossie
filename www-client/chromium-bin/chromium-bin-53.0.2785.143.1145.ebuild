# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit unpacker

KEYWORDS="~arm"
SRC_URI="http://ports.ubuntu.com/ubuntu-ports/pool/universe/c/chromium-browser/chromium-browser_53.0.2785.143-0ubuntu0.14.04.1.1145_armhf.deb
	http://ports.ubuntu.com/ubuntu-ports/pool/universe/c/chromium-browser/chromium-codecs-ffmpeg_53.0.2785.143-0ubuntu0.14.04.1.1145_armhf.deb"

DESCRIPTION="Chromium Binary from Ubuntu for ARM (e.g. Raspberry Pi)"
HOMEPAGE="http://packages.ubuntu.com/trusty/chromium-browser"

LICENSE="BSD"
SLOT="0"

QA_PREBUILT="usr/lib*/chromium/*"

RDEPEND="app-accessibility/speech-dispatcher
	app-crypt/mit-krb5
	dev-libs/expat
	dev-libs/libgcrypt:11
	dev-libs/libpcre
	dev-libs/libtasn1
	dev-libs/nspr
	dev-libs/nss
	gnome-base/gnome-keyring
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/libpng:0
	net-libs/gnutls
	net-print/cups
	>=sys-devel/gcc-4.9
	x11-libs/gtk+:2
	x11-libs/libXScrnSaver
	x11-libs/pango
	virtual/jpeg:0"

src_install() {
	mv "${S}"/{usr,etc} "${D}"/ || die
	chmod 4755 "${D}/usr/$(get_libdir)/chromium/chrome-sandbox" || die
}
