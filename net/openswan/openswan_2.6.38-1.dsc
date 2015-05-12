Format: 3.0 (quilt)
Source: openswan
Binary: openswan, openswan-dbg, openswan-doc, openswan-modules-source, openswan-modules-dkms
Architecture: linux-any all
Version: 1:2.6.38-1
Maintainer: Rene Mayrhofer <rmayr@debian.org>
Uploaders: Harald Jenny <harald@a-little-linux-box.at>
Homepage: http://www.openswan.org/
Standards-Version: 3.9.3
Vcs-Browser: http://git.debian.org/?p=pkg-swan/openswan.git;a=summary
Vcs-Git: git://git.debian.org/git/pkg-swan/openswan.git
Build-Depends: dpkg-dev (>= 1.16.1~), debhelper (>= 7.1), libgmp3-dev, libssl-dev (>= 0.9.8), libcurl4-openssl-dev, libldap2-dev, libpam0g-dev, libkrb5-dev, bison, flex, bzip2, po-debconf
Package-List:
 openswan deb net optional arch=linux-any
 openswan-dbg deb debug extra arch=linux-any
 openswan-doc deb doc optional arch=all
 openswan-modules-dkms deb kernel optional arch=linux-any
 openswan-modules-source deb kernel optional arch=all
Checksums-Sha1:
 39fa279d43aa1ea736ad1a70450b7bc0504c96eb 10861574 openswan_2.6.38.orig.tar.gz
 cd4866fbb4e7de1a62decb0c01d3eff48ba3d80d 104896 openswan_2.6.38-1.debian.tar.xz
Checksums-Sha256:
 bdd3ccf31df1f3e8530887986ea8b6702a3db139486738213f5de8d8690b3723 10861574 openswan_2.6.38.orig.tar.gz
 8350a6d76edd4f0c00da6ac416c136ee026cc31d544f34161992ddf997abc3bc 104896 openswan_2.6.38-1.debian.tar.xz
Files:
 13073eb5314b83a31be88e4117e8bbcd 10861574 openswan_2.6.38.orig.tar.gz
 85d5f9168d673546bcf1bf1f46f880d3 104896 openswan_2.6.38-1.debian.tar.xz
