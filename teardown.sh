#!/bin/bash
set -xe
terraform destroy -auto-approve
rm -rf ./tempFiles/*
