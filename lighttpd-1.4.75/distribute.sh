#!/bin/sh
PACKAGE=lighttpd
VERSION=1.4.75
NAME=lighttpd-1.4.75

DISTDIR="/home/jan/wwwroot/servers/www.lighttpd.net/pages/download/"
RPMS="/home/jan/rpmbuild/RPMS/i386/${NAME}-1.i386.rpm \
	/home/jan/rpmbuild/SRPMS/${NAME}-1.src.rpm"
FILES="${RPMS}	${NAME}.tar.gz \
	NEWS.html \
	ChangeLog \
	release-news.${VERSION}.txt \
	${NAME}.tar.gz.sig"
DLURL="https://www.lighttpd.net/download"
pack=0
echo $1
case "$1" in
	--pack) pack=1;;
esac

echo ${nopack}

if test x${pack} = x1; then
	make distcheck && rpmbuild -ta --nodeps ${NAME}.tar.gz
	gpg --detach-sign ${NAME}.tar.gz
	rpm --addsign ${RPMS}
fi

MD5RPM=`md5sum /home/jan/rpmbuild/RPMS/i386/${NAME}-1.i386.rpm| cut -b 1-32`
MD5SRPM=`md5sum /home/jan/rpmbuild/SRPMS/${NAME}-1.src.rpm| cut -b 1-32`
MD5TGZ=`md5sum ${NAME}.tar.gz| cut -b 1-32`
DATE=`date +'%Y-%m-%d %H:%M'`
NEWS=`cat NEWS | sed "/^- ${VERSION}/,/^-/p;d" | sed "/^- /d;/^$/d"`
DLNAME="${DLURL}/${NAME}"

cat > release-news.${VERSION}-mail.txt <<EOF
${PACKAGE} ${VERSION} - ${DATE}

Changes
-------
${NEWS}

Download
- ${NAME}-1.i386.rpm [built on Fedora Core 4]
  ${DLNAME}-1.i386.rpm
  MD5: ${MD5RPM}
- ${NAME}-1.src.rpm
  ${DLNAME}-1.src.rpm
  MD5: ${MD5SRPM}
- ${NAME}.tar.gz
  ${DLNAME}.tar.gz
  MD5: ${MD5TGZ}
  Signature: ${DLNAME}.tar.gz.sig

EOF

cat > release-news.${VERSION}.txt <<EOF
${PACKAGE} ${VERSION} - ${DATE}

Changes
-------
${NEWS}

Checksums
- ${NAME}-1.i386.rpm [built on Fedora Core 4]
  MD5: ${MD5RPM}
- ${NAME}-1.src.rpm
  MD5: ${MD5SRPM}
- ${NAME}.tar.gz
  MD5: ${MD5TGZ}

EOF

rst2html NEWS > NEWS.html

for i in ${DISTDIR}; do
	cp -u ${FILES} $i
done

curdir=`pwd`
cd ~/wwwroot/servers/www.lighttpd.net/
make put
cd ${curdir}


