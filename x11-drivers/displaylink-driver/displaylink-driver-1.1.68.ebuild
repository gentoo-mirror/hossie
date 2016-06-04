# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils systemd udev

DESCRIPTION="DisplayLink USB Graphics Software"
HOMEPAGE="http://www.displaylink.com/downloads/ubuntu"
SRC_URI="DisplayLink_USB_Graphics_Software_for_Ubuntu_${PV}.zip"

LICENSE="DisplayLink"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="systemd"

QA_PREBUILT="/usr/lib/displaylink/DisplayLinkManager"
RESTRICT="fetch"

DEPEND="app-admin/chrpath"
RDEPEND="=x11-drivers/evdi-1.1*
	virtual/libusb:1
	|| ( x11-drivers/xf86-video-modesetting >=x11-base/xorg-server-1.17.0 )
	!systemd? ( sys-power/pm-utils )"

pkg_nofetch() {
	einfo "Please download \"DisplayLink USB Graphics Software for Ubuntu ${PV}.zip\" from"
	einfo "${HOMEPAGE} and name it"
	einfo "DisplayLink_USB_Graphics_Software_for_Ubuntu_${PV}.zip"
}

src_unpack() {
	default
	sh ./"${PN}"-1.1.62.run --noexec --target "${P}"
}

src_install() {
	case "${ARCH}" in
		amd64)  DLM="${S}/x64/DisplayLinkManager" ;;
		x86)    DLM="${S}/x86/DisplayLinkManager" ;;
	esac

	dodir /usr/lib/displaylink
	dodir /var/log/displaylink

	exeinto /usr/lib/displaylink
	chrpath -d "${DLM}"
	doexe "${DLM}"

	insinto /usr/lib/displaylink
	doins *.spkg

	local udevrules="${T}/99-displaylink.rules"

	cat > "${udevrules}" <<-EOF
        ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="179", ATTR{bNumInterfaces}=="*5", GROUP="plugdev", MODE="0660"
	EOF
	udev_dorules "${udevrules}"

	if use systemd; then
		systemd_dounit "${FILESDIR}/displaylink.service"
		insinto /usr/lib/displaylink
		insopts -m0755
		newins "${FILESDIR}/pm-systemd-displaylink" displaylink.sh
		dosym /usr/lib/displaylink/displaylink.sh /lib/systemd/system-sleep/displaylink.sh
	else
		newinitd "${FILESDIR}/rc-displaylink" displaylink
		insinto /usr/lib/displaylink
		insopts -m0755
		newins "${FILESDIR}/pm-displaylink" displaylink.sh
		dosym /usr/lib/displaylink/displaylink.sh /etc/pm/sleep.d/displaylink.sh
	fi
}

pkg_postinst() {
	einfo "Please add the evdi module to /etc/conf.d/modules and"
	einfo "add the displaylink init.d / systemd service to your default runlevel"
	einfo ""
	einfo "Afterwards, you should be able to use xrandr as follows:"
	einfo "xrandr --setprovideroutputsource 1 0"
	einfo "Repeat for more screens, like:"
	einfo "xrandr --setprovideroutputsource 2 0"
	einfo "Then, you can use xrandr or GUI tools like arandr to configure the screens, e.g."
	einfo "xrandr --output DVI-1-0 --auto"
}
