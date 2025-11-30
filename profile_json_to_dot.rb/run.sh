#!/bin/bash

set -e

ruby --profile.json --profile.out profile.json your_code.rb
ruby profile_json_to_dot.rb profile.json > profile.dot
dot -Tpdf -o profile.pdf profile.dot
open profile.pdf