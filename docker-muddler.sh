#!/bin/bash
docker run --pull always --rm -it -u $(id -u):$(id -g) -v $PWD:/$PWD -w /$PWD demonnic/muddler

