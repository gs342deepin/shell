#!/bin/bash 
#sudo apt-get update ;
wget -q http://packages/real-2014/ppa/dists/trusty/main/source/Sources.gz
gzip -d Sources.gz ;mv Sources Sources_Up
wget -q http://10.0.0.127/ppa/dists/2015/main/source/Sources.gz
gzip -d Sources.gz ;mv Sources Sources_Local
grep -e 'Package:' -e '^Version:' Sources_Up |awk '{print $2}' |xargs -n 2 >list_Up
grep -e 'Package:' -e '^Version:' Sources_Local |awk '{print $2}' |xargs -n 2 >list_Local
rm Sources_Up ;rm Sources_Local ; 

diff list_Up list_Local |grep '<'|awk '{print $2 " " $3}'> uplist ;
#rm list_Up ;rm list_Local;
echo "This Packages  below will be update : "
echo 
cat uplist;

cat uplist |awk '{print $1}' > uplist_packages;


while read line
do
 mkdir $line ;cd $line ;
 echo 
 version=$(grep "$line" ../uplist | awk '{print $2}'|head -n 1 );
 apt-get -y -qq source $line=$version ;
 if [ -f *.dsc  ];then
 rm *.dsc ;
 else 
  echo $line >>../failed_package;
  continue ;
 fi

 cp ~/ppa/pkg_debian/$line/debian/patches/ppa_deepin.patch  . ;
 cd $line* ;

 if [ -f ../ppa_deepin.patch ] ; then
     patch -p1 < ../ppa_deepin.patch 
 fi

 if [ -f debian/control  ]; then
  dch -bv "$version"   -D unstable  "Port to Debian."  ;
  yes | debuild -S -us -uc -Zgzip
 fi
 cd ..
 rm *.changes ;
#arch ?any all
echo 
deb_arch=$(grep 'Architecture:' *.dsc|sed 's/Architecture: //')  ;
echo "$deb_arch" ;
case "$deb_arch" in 
any ) sbuild -s -d 2015 *.dsc --debbuildopts="-Zgzip -sa" &&  sbuild  -d 2015 *.dsc  --arch=i386   ;;
all ) sbuild -A -s -d 2015 *.dsc  --debbuildopts="-Zgzip -sa"   ;;
*   ) sbuild   -d 2015 *.dsc  --arch=i386  && sbuild  -A -s -d 2015 *.dsc --debbuildopts="-Zgzip -sa"  ;;
esac

if [ -f  *i386.changes  ] ; then
 dput my-ppa  *amd64.changes ;
 dput my-ppa  *i386.changes ;
 echo $line >>../success_package;
else
  if [ -f *amd64.changes  ] ;then
  dput my-ppa *amd64.changes ;
  echo $line >>../success_package;
  else
 echo $line >>../failed_package;
 fi
fi

cd .. ;
echo 

done < uplist_packages;

rm uplist_packages;
#update reprepro
#cd /var/www/ppa ;
#reprepro processincoming my-incoming;
