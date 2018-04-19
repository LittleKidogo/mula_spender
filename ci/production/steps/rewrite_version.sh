#!/bin/sh
sed -i -e "s/.*@vsn.*/@version $SEMVERSION/" mix.exs
