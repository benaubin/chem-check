# ChemCheck

My school needed open source software to track the chemicals & stuff from a science lab as they were checked in and out.

This is that app.

## Installation

You don't need to install Ruby. Instead, we use Docker make sure the app works everywhere (probably even on your
school's server).

Install [Docker Compose].

Clone this repository.

    $ git@github.com:benaubin/chem-check.git
    $ cd chem-check
    
Startup the docker container.

    $ docker-compose up

Then <kbd>CTRL</kbd><kbd>C</kbd> to stop.

Feel free to run it in the background.

    $ docker-compose up -d

When you need to stop the server, run:

    $ docker-compose stop

## Usage

See [the documentation][docs] built into the server.

## Updating

Updating chem-check is easy.

First, just pull changes from the repo.

    $ git pull

Then bundle the app to update any dependencies and run any migrations.

    $ docker-compose run web bundle
    $ docker-compose run web rails db:migrate
 
And start the server.

    $ docker-compose up -d
    
You should be updated. If you need help, send [me] an email.

[me]: git.io/aubin
[Docker Compose]: https://docs.docker.com/compose/install/#install-compose
[docs]: http://localhost:3000/docs