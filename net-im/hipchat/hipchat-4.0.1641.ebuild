# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Hipchat - persistent group chat using XMPP"
HOMEPAGE=""
SRC_URI="https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client/pool/HipChat4-4.0.1641-Linux.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/alsa-lib
	dev-libs/expat
	media-libs/fontconfig
	media-libs/freetype
	media-libs/mesa
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	dev-qt/qtgui:5
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5
	dev-qt/qtopengl:5
	dev-qt/qtpositioning:5
	dev-qt/qtdeclarative:5
	dev-qt/qtwebkit:5
	dev-qt/qtwebsockets:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/qtxml:5"
RDEPEND="${DEPEND}"
