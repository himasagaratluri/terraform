#!/bin/bash

## make sure virtualenv is set
pip install virtualenv

## activate the virtualenv
virtualenv -p python3 venv
source .venv/bin/activate

## Install requisites
pip install -r requirements.txt