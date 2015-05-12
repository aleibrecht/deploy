#!/bin/bash


echo "Comienza la instalación"
apt-get update
apt-get install -y \
           python-dev swig python-pip python-dev python-lxml libxml2-dev libxslt-dev \
           postgresql postgresql-client postgresql-server-dev-all libpq-dev \
           make git mercurial unoconv virtualenvwrapper
pip install -r requirements.txt
