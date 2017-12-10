# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit bash-completion-r1

DESCRIPTION="Enterprise Kubernetes for Developers (Client Tools)"
HOMEPAGE="https://www.openshift.org"
SRC_URI="https://github.com/openshift/origin/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion kerberos"

DEPEND="dev-lang/go
	kerberos? ( app-crypt/mit-krb5 )"
RDEPEND="bash-completion? ( >=app-shells/bash-completion-2.3-r1 )"

S="${WORKDIR}/origin-${PV}"

src_compile() {
	use kerberos && MY_TAGS="-tags=gssapi"

	export OS_GIT_CATALOG_VERSION="v${PV}"
	export OS_GIT_MINOR=""
	export OS_GIT_MAJOR=""
	export OS_GIT_VERSION="v${PV}"

	emake all WHAT="cmd/oc ${MY_TAGS} -v"

	emake all WHAT="tools/gendocs -v"
	emake all WHAT="tools/genman -v"
	hack/generate-docs.sh || exit 1
}

src_install() {
	case "${ARCH}" in
		x86)	MY_ARCH="386" ;;
		*)		MY_ARCH="${ARCH}" ;;
	esac

	dobin "_output/local/bin/linux/${MY_ARCH}/oc"
	doman docs/man/man1/oc*
	use bash-completion && dobashcomp contrib/completions/bash/oc
}