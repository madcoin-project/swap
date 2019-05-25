
Debian
====================
This directory contains files used to package madcoind/madcoin-qt
for Debian-based Linux systems. If you compile madcoind/madcoin-qt yourself, there are some useful files here.

## madcoin: URI support ##


madcoin-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install madcoin-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your madcoinqt binary to `/usr/bin`
and the `../../share/pixmaps/madcoin128.png` to `/usr/share/pixmaps`

madcoin-qt.protocol (KDE)

