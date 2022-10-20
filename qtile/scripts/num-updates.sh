#!/bin/env bash
set -e

printf "$(checkupdates | wc -l)"
