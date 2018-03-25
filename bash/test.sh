#!/bin/bash

echo 'Testing image: '$1

cd app
python manage.py test