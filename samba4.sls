dependencias:
  pkg.installed:
    - pkgs:
        - gcc
        - libacl-devel
        - libblkid-devel
        - gnutls-devel
        - readline-devel
        - python-devel
        - gdb
        - pkgconfig
        - krb5-workstation
        - zlib-devel
        - setroubleshoot-server
        - libaio-devel
        - setroubleshoot-plugins
        - policycoreutils-python
        - libsemanage-python
        - setools-libs-python
        - setools-libs
        - popt-devel
        - libpcap-devel
        - sqlite-devel
        - libidn-devel
        - libxml2-devel
        - libacl-devel
        - libsepol-devel
        - libattr-devel
        - keyutils-libs-devel
        - cyrus-sasl-devel
        - cups-devel
        - bind-utils
        - wget

resolv_file:
  file:
    - managed
    - name: /etc/resolv.conf
    - source: salt://resolv.conf
    - user: root
    - group: root
    - mode: 644
    - require:
        - pkg: dependencias

krb5_file:
  file:
    - managed
    - name: /etc/krb5.conf
    - source: salt://krb5.conf
    - user: root
    - group: root
    - mode: 644
    - require:
        - pkg: dependencias  
