: ==== start ====
TESTNAME=ipv6-v4-through-v6-klips-klips
source /testing/pluto/bin/eastlocal.sh

ipsec setup start
/testing/pluto/bin/wait-until-pluto-started

ipsec auto --add westnet-eastnet-4in6
# Alternatively, direct whack
# ipsec whack --name west-east-4in6 --ipv6 --tunnelipv4 --id @west --host 2001:db8:1:2::45 --client 192.0.1.0/24 --to --id @east --host 2001:db8:1:2::23 --client 192.0.2.0/2 --tunnel --psk --encrypt --pfs
# echo '@west @east: PSK "test"' >> /tmp/$TESTNAME/ipsec.secrets
# ipsec secrets

ipsec whack --debug-control --debug-controlmore --debug-crypt
