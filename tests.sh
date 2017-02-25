#!/bin/bash
# Test that wiki family is up and running

set -e

echo "###############"
echo "can get wiki family entrance page"
curl --silent    http://0.0.0.0:8001/            | grep FFA

echo "###############"
echo "can get wiki family member"
curl --silent -v http://0.0.0.0:8001/ffa_re_pnp/ 2>&1 | grep "Moved Permanently"
curl --silent -L http://0.0.0.0:8001/ffa_re_pnp/      | grep FFA
curl --silent -v http://0.0.0.0:8001/ffa_pb_pnp/ 2>&1 | grep "Moved Permanently"
curl --silent -L http://0.0.0.0:8001/ffa_pb_pnp/      | grep FFA

echo "###############"
echo "can get resources independently of family as well as via family member"
curl --silent -v http://0.0.0.0:8001/resources/assets/poweredby_mediawiki_88x31.png            2>&1 1>/dev/null | grep public
curl --silent -v http://0.0.0.0:8001/ffa_re_pnp/resources/assets/poweredby_mediawiki_88x31.png 2>&1 1>/dev/null | grep public
curl --silent -v http://0.0.0.0:8001/ffa_pb_pnp/resources/assets/poweredby_mediawiki_88x31.png 2>&1 1>/dev/null | grep public
echo "###############"
echo "END OF TESTS"
