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
        - ntp

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


localtime:
    file:
      - managed
      - name: /etc/localtime
      - source: salt://localtime
      - user: root
      - group: root
      - mode: 644
      - require:
          - pkg: dependencias

localtime:
      file:
        - managed
        - name: /etc/fstab
        - source: salt://fstab
        - user: root
        - group: root
        - mode: 644
        - require:
            - pkg: dependencias


samba4-source:
    file:
       - managed
       - name: /opt/samba-latest.tar.gz
       - source: salt://samba-latest.tar.gz
       - user: root
       - group: root
       - mode: 644
       - require:
           - pkg: dependencias

samba4-decomp:
  cmd:
    - run
    - name: tar xfz /opt/samba-latest.tar.gz
    - cwd: /opt
    - unless: test -d /opt/samba-4.1.11 
    - require:
      - file: samba4-source

samba4-install:
  cmd:
    - run
    - name: ./configure && make && make install && touch /usr/local/samba/.compilado
    - cwd: /opt/samba-4.1.11 
    - unless: test -f /usr/local/samba/.compilado
    - require:
      - file: samba4-source

samba-provision:
  cmd:
    - run
    - name: /usr/local/samba/bin/samba-tool domain provision --use-rfc2307 --domain vhgroup.corp  --realm vhgroup --dns-backend SAMBA_INTERNAL --adminpass 54linux* && touch /usr/local/samba/.samba.provisioned
    - unless: test -f /usr/local/samba/.samba.provisioned
    - require:
      - cmd: samba4-install

levantar-samba:
  cmd:
    - run 
    - name: /usr/local/samba/sbin/samba
    - unless: test -f /usr/local/samba/var/run/smbd.pid
    - require:
      - cmd: samba-provision

