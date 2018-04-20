#!/bin/bash


mkdir -p /etc/kubernetes/pki/etcd
cd /etc/kubernetes/pki/etcd

# =============================================
# ===  create CA config file
# =============================================

cat > ca-config.json <<EOF
{
  "signing": {
    "default": {
      "expiry": "8760h"
    },
    "profiles": {
      "kubernetes": {
        "usages": ["signing", "key encipherment", "server auth", "client auth"],
        "expiry": "8760h"
      }
    }
  }
}
EOF


# =============================================
# ===  create CA cert signing request
# =============================================

cat > ca-csr.json <<EOF
{
  "CN": "Kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "Kubernetes",
      "OU": "CA",
      "ST": "Oregon"
    }
  ]
}
EOF


# =============================================
# ===  generate CA cert and private key
# =============================================

cfssl gencert -initca ca-csr.json | cfssljson -bare ca


