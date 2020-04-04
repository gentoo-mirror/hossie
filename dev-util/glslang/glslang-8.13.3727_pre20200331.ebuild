# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_COMMIT="e157435c1e777aa1052f446dafed162b4a722e03"

CMAKE_ECLASS="cmake"
PYTHON_COMPAT=( python3_{6,7,8} )
inherit cmake-multilib python-any-r1

SRC_URI="https://github.com/KhronosGroup/${PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~ppc64 ~x86"

DESCRIPTION="Khronos reference front-end for GLSL and ESSL, and sample SPIR-V generator"
HOMEPAGE="https://www.khronos.org/opengles/sdk/tools/Reference-Compiler/ https://github.com/KhronosGroup/glslang"

LICENSE="BSD"
SLOT="0"

S="${WORKDIR}/${PN}-${MY_COMMIT}"

RDEPEND="!<media-libs/shaderc-2019-r1"
BDEPEND="${PYTHON_DEPS}"

# Bug 698850
RESTRICT="test"
