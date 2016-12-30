# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Enterprise Kubernetes for Developers (Client Tools)"
HOMEPAGE="https://www.openshift.org"
SRC_URI="https://github.com/openshift/origin/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="kerberos"

DEPEND="dev-lang/go
	kerberos? ( app-crypt/mit-krb5 )"

S="${WORKDIR}/origin-${PV}"

src_compile() {
	use kerberos && MY_TAGS="-tags=gssapi"
	emake all OS_GIT_MINOR="" OS_GIT_MAJOR="" OS_GIT_VERSION="v${PV}" WHAT="cmd/oc ${MY_TAGS}"
}

src_install() {
	dobin _output/local/bin/linux/amd64/oc
}