# Docker
<!-- TOC -->

- [About Docker](#about-docker)
- [Important Commands](#important-commands)

<!-- /TOC -->

## About Docker


## Important Commands
```sh
  # Build docker image
  $ docker-compose up --build

  # Run existing docker image
  $ docker-compose run --rm --service-ports create_fun_dev mix phx.server

  # Run existing docker image including interactive elixir
  $ docker-compose run --rm --service-ports create_fun_dev mix phx.server iex -S

  # !important!
  # Running an existing docker image will result in a different docker image name
  # Replace create_fun_dev with that docker image name

  # Run ecto command through docker
  # Create database
  $ docker exec -it create_fun_dev mix ecto.create

  # Run migrations
  $ docker exec -it create_fun_dev mix ecto.migrate

  # Both creates database and migrates files
  $ docker exec -it create_fun_dev mix do ecto.create, ecto.migrate

  # Fill database with development seeds
  $ docker exec -it create_fun_dev mix run apps/create_fun/priv/repo/seeds_dev.exs

  # Fill database with production seeds
  $ docker exec -it create_fun_dev mix run apps/create_fun/priv/repo/seeds.exs
```
