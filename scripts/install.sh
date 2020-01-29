#!/bin/bash

set -e

getLatestFromRepo() {
    echo "git fetch && git pull;";
    git fetch && git pull;
}

createEnv() {
    echo "cp ./.env-example ./.env";
    cp ./.env-example ./.env
}

dockerRefresh() {
    if [[ $(uname -s) == "Darwin" ]]; then

        echo "brew install unison";
        brew install unison;

        echo "brew install eugenmayer/dockersync/unox";
        brew install eugenmayer/dockersync/unox;

        echo "gem install docker-sync;";
        sudo gem install docker-sync;

        if which ruby >/dev/null && which gem >/dev/null; then
            PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
            if [ -f ~/.bash_profile ]; then
                echo "source ~/.bash_profile";
                source ~/.bash_profile

                echo "source ~/.profile";
                source ~/.profile

                echo "source ~/.bashrc";
                source ~/.bashrc
            fi
        fi

        echo "sed -i '' 's/SSL=true/SSL=false/g' ${PWD}/.env";
        sed -i '' 's/SSL=true/SSL=false/g' ${PWD}/.env

        echo "docker-sync start";
        docker-sync start;

        echo "docker-compose -f docker-compose.osx.yml down"
        docker-compose -f docker-compose.osx.yml down

        echo "docker-compose -f docker-compose.osx.yml build"
        docker-compose -f docker-compose.osx.yml build

        echo "docker-compose -f docker-compose.osx.yml up -d"
        docker-compose -f docker-compose.osx.yml up -d;
    else
        echo "docker-compose down"
        docker-compose down

        echo "docker-compose build"
        docker-compose build

        echo "docker-compose up -d"
        docker-compose up -d;
    fi;

    sleep 5
}


createHtdocs
getLatestFromRepo
createEnv

. ${PWD}/.env;

dockerRefresh
