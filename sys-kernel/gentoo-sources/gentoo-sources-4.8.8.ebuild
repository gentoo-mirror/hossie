# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="9"

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~alpha ~amd64 ~arm ~arm64 -hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
HOMEPAGE="https://dev.gentoo.org/~mpagano/genpatches"
IUSE="experimental"

DESCRIPTION="Full sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}
	http://algo.ing.unimo.it/people/paolo/disk_sched/patches/4.8.0-v8r4/0001-block-cgroups-kconfig-build-bits-for-BFQ-v7r11-4.8.0.patch
	http://algo.ing.unimo.it/people/paolo/disk_sched/patches/4.8.0-v8r4/0002-block-introduce-the-BFQ-v7r11-I-O-sched-to-be-ported.patch -> 0002-block-introduce-the-BFQ-v7r11-I-O-sched-to-be-ported-4.8.0.patch
	http://algo.ing.unimo.it/people/paolo/disk_sched/patches/4.8.0-v8r4/0003-block-bfq-add-Early-Queue-Merge-EQM-to-BFQ-v7r11-to-.patch -> 0003-block-bfq-add-Early-Queue-Merge-EQM-to-BFQ-v7r11-to-4.8.0.patch
	http://algo.ing.unimo.it/people/paolo/disk_sched/patches/4.8.0-v8r4/0004-Turn-BFQ-v7r11-into-BFQ-v8r4-for-4.8.0.patch"

UNIPATCH_LIST="${DISTDIR}/0001-block-cgroups-kconfig-build-bits-for-BFQ-v7r11-4.8.0.patch \
	${DISTDIR}/0002-block-introduce-the-BFQ-v7r11-I-O-sched-to-be-ported-4.8.0.patch \
	${DISTDIR}/0003-block-bfq-add-Early-Queue-Merge-EQM-to-BFQ-v7r11-to-4.8.0.patch \
	${DISTDIR}/0004-Turn-BFQ-v7r11-into-BFQ-v8r4-for-4.8.0.patch"

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
