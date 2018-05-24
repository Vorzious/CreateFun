#!/bin/bash
cd /application/create_fun_umbrella \
  && mix local.hex --force \
  && mix local.rebar --force \
  && mix clean \
  && mix deps.clean --all \
  && mix deps.get

cd /application/create_fun_umbrella/apps/create_fun_cms/assets \
  && npm install \
  && brunch build

cd /application/create_fun_umbrella/apps/create_fun_web/assets \
  && npm install \
  && brunch build

cd /application/create_fun_umbrella \
  && mix compile \
  && mix create_fun_endpoint.digest default \
  && mix phx.server
