#!/bin/bash
#set -e
rand (){
  openssl rand -hex 20
}
CA_PASS=`rand | cut -c1-40`
TS_PASS=`rand | cut -c1-20`
./clean.sh
echo "CA password: $CA_PASS" >> Readme.txt
echo "Truststore password: $TS_PASS" >> Readme.txt
./gen_root_ca.sh $CA_PASS $TS_PASS
./gen_node_cert.sh 0 `rand | cut -c1-20` $CA_PASS && ./gen_node_cert.sh 1 `rand | cut -c1-20` $CA_PASS &&  ./gen_node_cert.sh 2 `rand | cut -c1-20` $CA_PASS
#./gen_client_node_cert.sh spock `rand | cut -c1-20` $CA_PASS
./gen_client_node_cert.sh kirk `rand | cut -c1-20` $CA_PASS
./gen_client_node_cert.sh sgadmin `rand | cut -c1-20` $CA_PASS
