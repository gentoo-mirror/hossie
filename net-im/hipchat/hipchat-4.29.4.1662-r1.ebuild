# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils unpacker

DESCRIPTION="Hipchat - persistent group chat using XMPP"
HOMEPAGE="https://www.hipchat.com/"
SRC_URI="https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client/pool/HipChat4-${PV}-Linux.deb"

LICENSE="Atlassian-Customer-Agreement"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

QA_PRESTRIPPED="opt/HipChat4/bin/hellocpp
	opt/HipChat4/lib/QtWebEngineProcess.bin
	/opt/HipChat4/lib/.*.so.*
	/opt/HipChat4/lib/Qt.*
	/opt/HipChat4/lib/plugins/*"

DEPEND="app-arch/snappy:*
	dev-libs/glib:2
	dev-libs/libbsd:*
	dev-libs/libpcre:*
	dev-libs/openssl:0
	media-gfx/graphite2:*
	media-libs/fontconfig:*
	media-libs/freetype:*
	media-libs/libpng:0
	media-libs/mesa:*
	x11-libs/libxkbcommon:*[X]
	x11-libs/xcb-util-keysyms:*"

RDEPEND="${DEPEND}"

S=${WORKDIR}

#For now, it seems impossible to delete bundled qt
#Any tips are welcome

src_prepare() {
	rm opt/HipChat4/lib/libxkbcommon{,-x11}.so.0 || die
	default
}

src_install() {
	for size in 16x16 24x24 32x32 48x48 128x128 256x256; do
		doicon -s "${size}" "usr/share/icons/hicolor/${size}/apps/hipchat4-attention.png"
		doicon -s "${size}" "usr/share/icons/hicolor/${size}/apps/hipchat4.png"
	done

	insinto /opt
	doins -r opt/HipChat4
	fperms a+x /opt/HipChat4/bin/{hellocpp,HipChat4,QtWebEngineProcess}
	fperms a+x /opt/HipChat4/lib/{HipChat.bin,QtWebEngineProcess.bin,linuxbrowserlaunch.sh}

	make_wrapper "${PN}" /opt/HipChat4/bin/HipChat4
	make_desktop_entry "${PN}" HipChat hipchat4 "Network;Chat"
}