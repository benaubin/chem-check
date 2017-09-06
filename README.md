# ChemCheck

My school needed open source software to track the chemicals & stuff from a science lab as they were checked in and out.

This is that app.

## Installation

You don't need to install Ruby. Instead, Docker is used to make it work everywhere (even on your school's server).

Clone this repository.

    $ git@github.com:benaubin/chem-check.git
    $ cd chem-check
    
Startup Docker

    $ docker-compose up

Then <kbd>CTRL</kbd><kbd>C</kbd> to stop.

Feel free to run it in the background.

    $ docker-compose up -d

When you need to stop the server, run:

    $ docker-compose stop

## Updating

Updating chem-check is easy.

First, just pull changes from the repo.

    $ git pull

Then bundle the app to update any dependencies and run any migrations.

    $ docker-compose run web bundle
    $ docker-compose run web rails db:migrate
 
And start the server.

    $ docker-compose up -d
    
You should be up. If you need help, send [me] an email.

[me]: git.io/aubin