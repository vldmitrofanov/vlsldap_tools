vlsldap_tools
=============

vlsldap_tools

Description: I made these scripts to help myself managing openLDAP + samba in company im working for. All scripts are having --help option, so you can see the full list of options. 


Here is working samba config. Im using smbldap-tools as well

<pre>
cat /etc/samba/smb.conf
[global]
        workgroup = MYCOMPANY
        server string = Samba Server Version %v
        netbios name = PDC
        wins support = yes
        name resolve order = wins lmhosts hosts bcast
        deadtime = 10
        log level = 3
#	log level = 10 all:10
        log file = /var/log/samba/log.%m
        max log size = 5000
        debug pid = yes
        debug uid = yes
        syslog = 0
        utmp = yes
        security = user
#       security = domain
        domain logons = yes
#	os level = 64
        domain master = Yes
        local master = Yes
        preferred master = Yes

        os level = 35
        logon path =
        logon home =
        logon drive =
        logon script =
        #passdb backend = ldapsam:"ldap://localhost:389/"
        passdb backend = ldapsam:ldap://192.168.11.23/
        #ldap ssl = start tls
        ldap ssl = off
        ldap admin dn = cn=Manager,dc=company,dc=com
        ldap delete dn = no
        ## Sync UNIX password with Samba password
        ## Method 1:
        ldap password sync = yes
        ## Method 2:
        ;unix password sync = yes
        ;passwd program = /usr/local/sbin/smbldap-passwd -u '%u'
        passwd program = /usr/local/slapdtools_vlad/sbin/vlsldap_passwd '%u' -p
        passwd chat = "Changing *\nNew password*" %n\n "*Retype new password*" %n\n"
        ldap suffix = dc=company,dc=com
        ldap user suffix = ou=Users
        ldap group suffix = ou=Groups
        ldap machine suffix = ou=Computers
        ldap idmap suffix = ou=Idmap
        add user script = /usr/local/sbin/smbldap-useradd -m '%u' -t 1
        #add user script = /usr/local/slapdtools_vlad/sbin/vlsldap_useradd --fullname='Firstname Lastname'
        rename user script = /usr/local/sbin/smbldap-usermod -r '%unew' '%uold'
        delete user script = /usr/local/sbin/smbldap-userdel '%u'
        set primary group script = /usr/local/sbin/smbldap-usermod -g '%g' '%u'
        add group script = /usr/local/sbin/smbldap-groupadd -p '%g'
        delete group script = /usr/local/sbin/smbldap-groupdel '%g'
        add user to group script = /usr/local/sbin/smbldap-groupmod -m '%u' '%g'
        delete user from group script = /usr/local/sbin/smbldap-groupmod -x '%u' '%g'
        add machine script = /usr/local/sbin/smbldap-useradd -w '%u' -t 1
        #add machine script = /usr/local/slapdtools_vlad/sbin/vlsldap_machineadd --pcname="%u"
[NETLOGON]
        path = /var/lib/samba/netlogon
        browseable = no
        #share modes = no
[PROFILES]
        path = /var/lib/samba/profiles
        browseable = no
        writeable = yes
        create mask = 0611
        directory mask = 0700
        profile acls = yes
        csc policy = disable
        map system = yes
        map hidden = yes
[homes]
        comment = Home Directories
        browseable = no
        writable = yes
;        valid users = %S
;        valid users = MYDOMAIN\%S
</pre>
