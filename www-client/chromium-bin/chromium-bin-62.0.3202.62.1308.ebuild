# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker versionator

MY_VERSION="$(get_version_component_range 1-4)"
MY_PATCH="$(get_version_component_range 5)"
MY_UBUNTUVERS="16.04"

KEYWORDS="~arm"
SRC_URI="http://ports.ubuntu.com/ubuntu-ports/pool/universe/c/chromium-browser/chromium-browser_${MY_VERSION}-0ubuntu0.${MY_UBUNTUVERS}.${MY_PATCH}_armhf.deb
	http://ports.ubuntu.com/ubuntu-ports/pool/universe/c/chromium-browser/chromium-codecs-ffmpeg_${MY_VERSION}-0ubuntu0.${MY_UBUNTUVERS}.${MY_PATCH}_armhf.deb"

DESCRIPTION="Chromium Binary from Ubuntu for ARM (e.g. Raspberry Pi)"
HOMEPAGE="http://packages.ubuntu.com/xenial/chromium-browser"

LICENSE="BSD"
SLOT="0"

QA_PREBUILT="usr/lib*/chromium-browser/*"

S="${WORKDIR}"

RDEPEND="dev-libs/libtasn1
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/libpng:0
	net-libs/gnutls
	net-print/cups
	sys-apps/lsb-release
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver"

src_install() {
	mv "${S}"/{usr,etc} "${D}"/ || die
	chmod 4755 "${D}/usr/$(get_libdir)/chromium-browser/chrome-sandbox" || die
}
