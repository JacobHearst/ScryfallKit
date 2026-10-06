#!/bin/sh
# Formats all Swift sources in place using the config in .swift-format
set -e
cd "$(dirname "$0")"
swift format --in-place --recursive Package.swift Sources Tests SampleCode
