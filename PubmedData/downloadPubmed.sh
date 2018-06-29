#!/bin/sh

START=0001
MAX=0928

curl -O "ftp://ftp.ncbi.nlm.nih.gov/pubmed/baseline/pubmed18n[$START-$MAX].xml.gz"