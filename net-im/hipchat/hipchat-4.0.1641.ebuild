# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils unpacker

DESCRIPTION="Hipchat - persistent group chat using XMPP"
HOMEPAGE=""
SRC_URI="https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client/pool/HipChat4-${PV}-Linux.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

QA_PRESTRIPPED="/opt/HipChat4/bin/hellocpp"

DEPEND="dev-libs/glib:2
	dev-libs/libbsd
	dev-libs/libpcre
	dev-libs/openssl:0
	dev-qt/qtcore:5[icu]
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5[xcb]
	dev-qt/qtnetwork:5
	dev-qt/qtwebengine:5[widgets]
	dev-qt/qtx11extras:5
	kde-frameworks/kwindowsystem:5
	media-gfx/graphite2
	media-libs/freetype
	media-libs/libpng:0
	media-libs/mesa"

RDEPEND="${DEPEND}"

S=${WORKDIR}

src_prepare() {
	rm opt/HipChat4/lib/libQt5*
	rm -r opt/HipChat4/lib/{Qt,QtQuick}
}

src_install() {
	for size in 16x16 24x24 32x32 48x48 128x128 256x256; do
		doicon -s "${size}" "usr/share/icons/hicolor/${size}/apps/hipchat4-attention.png"
		doicon -s "${size}" "usr/share/icons/hicolor/${size}/apps/hipchat4.png"
	done

	insinto /opt
	doins -r opt/HipChat4
	fperms 755 /opt/HipChat4/bin/hellocpp /opt/HipChat4/bin/HipChat4 /opt/HipChat4/bin/QtWebEngineProcess
	fperms 755 /opt/HipChat4/lib/HipChat.bin /opt/HipChat4/lib/QtWebEngineProcess.bin
}