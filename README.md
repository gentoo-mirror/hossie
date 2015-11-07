daugustin (hossie) overlay
==========================

Add it to layman
----------------

**Temporary:**

    layman -o https://raw.githubusercontent.com/daugustin/gentoo-overlay/master/overlay.xml -a daugustin
    
**Permanently:**

Edit the file /etc/layman/layman.cfg and add the line

    https://raw.githubusercontent.com/daugustin/gentoo-overlay/master/overlay.xml

to the "overlays" section. Then, run

    layman -a daugustin
