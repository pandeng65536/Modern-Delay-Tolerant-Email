#!/bin/bash

# Set hostname and domain
# Check the environment variable HOSTNAME; if it's not set or empty, use the default value "mailserver"
HOSTNAME=${HOSTNAME:-"mailserver"}
DOMAIN=${DOMAIN:-"example.com"}
FQDN="$HOSTNAME.$DOMAIN"

# Configure Postfix
postconf -e "myhostname = $FQDN"
postconf -e "mydomain = $DOMAIN"
postconf -e "myorigin = $DOMAIN"
postconf -e "mydestination = $FQDN, localhost.$DOMAIN, localhost"
postconf -e "mynetworks = 172.0.0.0/8 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128"
postconf -e "inet_interfaces = all"
postconf -e "inet_protocols = all"
postconf -e "alias_maps = hash:/etc/aliases"
postconf -e "smtpd_recipient_restrictions = permit_mynetworks permit_sasl_authenticated reject_unauth_destination"

# Create user
useradd -m -s /bin/bash $HOSTNAME || echo "User already exists"
echo "$HOSTNAME:password" | chpasswd

# Configure Dovecot
sed -i 's/^#listen = .*/listen = */g' /etc/dovecot/dovecot.conf
sed -i 's/^#disable_plaintext_auth = .*/disable_plaintext_auth = no/g' /etc/dovecot/conf.d/10-auth.conf
sed -i 's/^auth_mechanisms = .*/auth_mechanisms = plain login/g' /etc/dovecot/conf.d/10-auth.conf
sed -i 's/^#mail_location = .*/mail_location = mbox:~\/mail:INBOX=\/var\/mail\/%u/g' /etc/dovecot/conf.d/10-mail.conf
sed -i 's/^mail_location = .*/mail_location = mbox:~\/mail:INBOX=\/var\/mail\/%u/g' /etc/dovecot/conf.d/10-mail.conf

# Create mail directory
mkdir -p /var/mail
chmod 777 /var/mail

service postfix start
service dovecot start

echo "Mail server started with hostname: $FQDN"
echo "Created user: $HOSTNAME with password: password"

# Keep container running
tail -f /dev/null
