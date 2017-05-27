# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib

MY_COMMIT="98f099e2fe1ff2c82bb77e35d1e0dc8a79bc67ca"

DESCRIPTION="PAC is a Perl/GTK replacement for SecureCRT/Putty/etc"
HOMEPAGE="http://sites.google.com/site/davidtv"
SRC_URI="https://api.github.com/repos/perseo22/pacmanager/tarball/${MY_COMMIT} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="freerdp mosh rdesktop vnc webdav"

S="${WORKDIR}/perseo22-${PN}-${MY_COMMIT:0:7}"

RDEPEND="freerdp? ( net-misc/freerdp )
	mosh? ( net-misc/mosh )
	rdesktop? ( net-misc/rdesktop )
	vnc? ( net-misc/tigervnc )
	webdav? ( net-misc/cadaver )
	dev-libs/ossp-uuid[perl]
	dev-perl/Crypt-Blowfish
	dev-perl/Crypt-CBC
	dev-perl/Crypt-Rijndael
	dev-perl/Expect
	dev-perl/Gnome2-GConf
	dev-perl/gnome2-perl
	dev-perl/Gnome2-Vte
	dev-perl/Gtk2
	dev-perl/Gtk2-Ex-Simple-List
	dev-perl/gtk2-gladexml
	dev-perl/Gtk2-Unique
	dev-perl/IO-Stty
	dev-perl/Net-ARP
	dev-perl/Socket6
	dev-perl/YAML"

src_prepare() {
	default

	rm -rf lib/ex/vte*
	find utils lib pac -type f | while read f
	do
		sed -i -e "s@\$RealBin[^']*\('\?\)\([./]*\)/lib@\1/usr/$(get_libdir)/pacmanager@g" "$f"
		sed -i -e "s@\$RealBin[^']*\('\?\)\([./]*\)/res@\1/usr/share/pacmanager@g" "$f"
	done

	sed -i 's/Categories=.*/Categories=Network;/' res/pac.desktop
}

src_install() {
	dobin pac
	dodoc README

	doman res/pac.1
	insinto /usr/share/applications
	doins res/pac.desktop
	rm res/{pac.1,pac.desktop}

	insinto /usr/share/pixmaps
	newins res/pac64x64.png pac.png

	insinto /usr/$(get_libdir)/${PN}
	doins -r lib/*
	insinto /usr/share/${PN}
	doins -r res/*
	doins -r utils
	doins qrcode_pacmanager.png
}

pkg_postinst() {
	einfo "Please install keepassx if you need a password manager."
}