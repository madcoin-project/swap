#/bin/bash
##make download && make HOST=i686-w64-mingw32 -j10 && make HOST=x86_64-w64-mingw32 -j10 && make HOST=x86_64-pc-linux-gnu -j10 && make HOST=aarch64-linux-gnu -j10 && make HOST=x86_64-apple-darwin11 SDK_PATH=/home/debian/ -j10 && make HOST=arm-linux-gnueabihf -j10
##sudo apt-get install -y unzip python python-pip && \
##sudo pip install ez_setup && \
##sudo apt-get install -y build-essential libtool autotools-dev autoconf pkg-config libssl-dev && \
##sudo apt-get install -y ca-certificates curl g++ git pkg-config autoconf librsvg2-bin libtiff-tools libtool automake faketime bsdmainutils cmake imagemagick libcap-dev libz-dev libbz2-dev python python-dev python-setuptools fonts-tuffy && \
##sudo apt-get install -y g++-aarch64-linux-gnu g++-7-aarch64-linux-gnu gcc-7-aarch64-linux-gnu binutils-aarch64-linux-gnu g++-arm-linux-gnueabihf g++-7-arm-linux-gnueabihf gcc-7-arm-linux-gnueabihf binutils-arm-linux-gnueabihf g++-7-multilib gcc-7-multilib binutils-gold bsdmainutils
##sudo apt-get install nsis mingw-w64 g++-mingw-w64

echo "Please inform me the depends folder for your coin"
read DEPENDSFOLDER
echo "Please inform me the repository for your coin (include username and password if private)"
read REPOSITORY
echo "Please inform me the coin name"
read COINNAME
echo "Please inform me the coin VERSION (1.0.0 example)"
read COINVERSION

mkdir ${COINNAME}releases
mkdir ${COINNAME}compile
cd ${COINNAME}compile

## WINDOWS 32 BITS COMPILE, ZIPPING AND SETUP

git clone ${REPOSITORY} ${COINNAME}windows32
cd ${COINNAME}windows32
chmod +x autogen.sh && chmod +x share/genbuild.sh && chmod +x src/leveldb/build_detect_platform
./autogen.sh && ./configure --prefix=${DEPENDSFOLDER}i686-w64-mingw32/ && make -j10
make install DESTDIR=/home/debian/${COINNAME}compile/${COINNAME}windows32/releases/
make deploy
makensis share/setup.nsi
mv *setup* /home/debian/${COINNAME}releases/
rm /home/debian/${COINNAME}compile/${COINNAME}windows32/releases${DEPENDSFOLDER}i686-w64-mingw32/bin/test*
zip -r -j /home/debian/${COINNAME}releases/${COINNAME}-${COINVERSION}-w32.zip /home/debian/${COINNAME}compile/${COINNAME}windows32/releases${DEPENDSFOLDER}i686-w64-mingw32/
cd /home/debian/

## WINDOWS 64 BITS COMPILE, ZIPPING AND SETUP

cd ${COINNAME}compile
git clone ${REPOSITORY} ${COINNAME}windows64
cd ${COINNAME}windows64
chmod +x autogen.sh && chmod +x share/genbuild.sh && chmod +x src/leveldb/build_detect_platform
./autogen.sh && ./configure --prefix=${DEPENDSFOLDER}x86_64-w64-mingw32/ && make -j10
make install DESTDIR=/home/debian/${COINNAME}compile/${COINNAME}windows64/releases/
make deploy
makensis share/setup.nsi
mv *setup* /home/debian/${COINNAME}releases/
rm /home/debian/${COINNAME}compile/${COINNAME}windows64/releases${DEPENDSFOLDER}x86_64-w64-mingw32/bin/test*
zip -r -j /home/debian/${COINNAME}releases/${COINNAME}-${COINVERSION}-w64.zip /home/debian/${COINNAME}compile/${COINNAME}windows64/releases${DEPENDSFOLDER}x86_64-w64-mingw32/
cd /home/debian/
 
## LINUX 64 BITS 


cd ${COINNAME}compile
git clone ${REPOSITORY} ${COINNAME}linux
cd ${COINNAME}linux
chmod +x autogen.sh && chmod +x share/genbuild.sh && chmod +x src/leveldb/build_detect_platform
./autogen.sh && ./configure --prefix=${DEPENDSFOLDER}x86_64-pc-linux-gnu/ && make -j10
make install DESTDIR=/home/debian/${COINNAME}compile/${COINNAME}linux/releases/
rm /home/debian/${COINNAME}compile/${COINNAME}linux/releases${DEPENDSFOLDER}x86_64-pc-linux-gnu/bin/test*
zip -r -j /home/debian/${COINNAME}releases/${COINNAME}-${COINVERSION}-x86_64-pc-linux-gnu.zip /home/debian/${COINNAME}compile/${COINNAME}linux/releases${DEPENDSFOLDER}x86_64-pc-linux-gnu/
cd /home/debian/


 
## LINUX ARM 64 BITS 


cd ${COINNAME}compile
git clone ${REPOSITORY} ${COINNAME}arm64
cd ${COINNAME}arm64
chmod +x autogen.sh && chmod +x share/genbuild.sh && chmod +x src/leveldb/build_detect_platform
./autogen.sh && ./configure --without-gui --prefix=${DEPENDSFOLDER}aarch64-linux-gnu/ && make -j10
make install DESTDIR=/home/debian/${COINNAME}compile/${COINNAME}arm64/releases/
rm /home/debian/${COINNAME}compile/${COINNAME}arm64/releases${DEPENDSFOLDER}aarch64-linux-gnu/bin/test*
zip -r -j /home/debian/${COINNAME}releases/${COINNAME}-${COINVERSION}-aarch64-linux-gnu.zip /home/debian/${COINNAME}compile/${COINNAME}arm64/releases${DEPENDSFOLDER}aarch64-linux-gnu/
cd /home/debian/


## MacOS Non-High Sierra

cd ${COINNAME}compile
git clone ${REPOSITORY} ${COINNAME}macos
cd ${COINNAME}macos
chmod +x autogen.sh && chmod +x share/genbuild.sh && chmod +x src/leveldb/build_detect_platform
./autogen.sh && ./configure --prefix=${DEPENDSFOLDER}x86_64-apple-darwin11/ && make -j10
make install DESTDIR=/home/debian/${COINNAME}compile/${COINNAME}macos/releases/
make deploy
mv *.dmg* /home/debian/${COINNAME}releases/
rm /home/debian/${COINNAME}compile/${COINNAME}macos/releases${DEPENDSFOLDER}x86_64-apple-darwin11/bin/test*
zip -r -j /home/debian/${COINNAME}releases/${COINNAME}-${COINVERSION}-osx.zip /home/debian/${COINNAME}compile/${COINNAME}macos/releases${DEPENDSFOLDER}x86_64-apple-darwin11/
cd /home/debian/

## ARM Based 32 BITS Processors

cd ${COINNAME}compile
git clone ${REPOSITORY} ${COINNAME}arm32
cd ${COINNAME}arm32
chmod +x autogen.sh && chmod +x share/genbuild.sh && chmod +x src/leveldb/build_detect_platform
./autogen.sh && ./configure --without-gui --prefix=${DEPENDSFOLDER}arm-linux-gnueabihf/ && make -j10
make install DESTDIR=/home/debian/${COINNAME}compile/${COINNAME}arm32/releases/
rm /home/debian/${COINNAME}compile/${COINNAME}arm32/releases${DEPENDSFOLDER}arm-linux-gnueabihf/bin/test*
zip -r -j /home/debian/${COINNAME}releases/${COINNAME}-${COINVERSION}-arm-linux-gnueabihf.zip /home/debian/${COINNAME}compile/${COINNAME}arm32/releases${DEPENDSFOLDER}arm-linux-gnueabihf/
cd /home/debian/

echo "DONE!"
