hossie overlay
==============

Add it to layman
----------------

Edit the file /etc/layman/layman.cfg and add the line

    https://git.hossie.de/projects/GEN/repos/gentoo-overlay/browse/overlay.xml?raw

to the "overlays" section. Then, run

    layman -a hossie
