# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils flag-o-matic linux-info linux-mod user versionator udev

PV_MAJOR=$(get_major_version)
PV_MINOR=$(get_version_component_range 2)

DESCRIPTION="VMware kernel modules"
HOMEPAGE="http://www.vmware.com/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}
	|| ( =app-emulation/vmware-player-7.${PV_MINOR}*
	=app-emulation/vmware-workstation-11.${PV_MINOR}* )"

S=${WORKDIR}

pkg_setup() {
	CONFIG_CHECK="~HIGH_RES_TIMERS VMWARE_VMCI VMWARE_VMCI_VSOCKETS"

	linux-info_pkg_setup
	linux-mod_pkg_setup

	VMWARE_GROUP=${VMWARE_GROUP:-vmware}
	VMWARE_MODULE_LIST="vmblock vmmon vmnet"
	VMWARE_MOD_DIR="${PN}-${PVR}"

	BUILD_TARGETS="auto-build KERNEL_DIR=${KERNEL_DIR} KBUILD_OUTPUT=${KV_OUT_DIR}"

	enewgroup "${VMWARE_GROUP}"
	filter-flags -mfpmath=sse
	filter-flags -msse -msse2 -msse3 -mssse3 -msse4.1 -msse4.2 -mf16c -mpclmul

	for mod in ${VMWARE_MODULE_LIST}; do
		MODULE_NAMES="${MODULE_NAMES} ${mod}(misc:${S}/${mod}-only)"
	done
}

src_unpack() {
	cd "${S}"
	for mod in ${VMWARE_MODULE_LIST}; do
		tar -xf /opt/vmware/lib/vmware/modules/source/${mod}.tar
	done
}

src_prepare() {
	epatch "${FILESDIR}/${PV_MAJOR}-makefile-kernel-dir.patch"
	epatch "${FILESDIR}/${PV_MAJOR}-makefile-include.patch"
	epatch "${FILESDIR}/${PV_MAJOR}-netdevice.patch"
	epatch "${FILESDIR}/${PV_MAJOR}-apic.patch"

	kernel_is ge 3 7 0 && epatch "${FILESDIR}/${PV_MAJOR}-putname.patch"
	kernel_is ge 3 10 0 && epatch "${FILESDIR}/${PV_MAJOR}-vmblock.patch"
	kernel_is ge 3 11 0 && epatch "${FILESDIR}/${PV_MAJOR}-filldir.patch"
	kernel_is ge 3 12 0 && epatch "${FILESDIR}/${PV_MAJOR}-vfsfollowlink.patch"
	kernel_is ge 3 14 0 && epatch "${FILESDIR}/${PV_MAJOR}-vmblock-3.14.patch"
	kernel_is ge 3 15 0 && epatch "${FILESDIR}/${PV_MAJOR}-kernel-3.15.patch"
	kernel_is ge 3 18 0 && epatch "${FILESDIR}/${PV_MAJOR}-vmblock-3.18.patch"

	epatch_user
}

src_install() {
	linux-mod_src_install
	local udevrules="${T}/60-vmware.rules"
	cat > "${udevrules}" <<-EOF
		KERNEL=="vmci",  GROUP="${VMWARE_GROUP}", MODE="660"
		KERNEL=="vmw_vmci",  GROUP="${VMWARE_GROUP}", MODE="660"
		KERNEL=="vmmon", GROUP="${VMWARE_GROUP}", MODE="660"
		KERNEL=="vsock", GROUP="${VMWARE_GROUP}", MODE="660"
	EOF
	udev_dorules "${udevrules}"
}
