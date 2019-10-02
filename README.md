# Datawarehousing con R

Este codigo es de la presentacion https://docs.google.com/presentation/d/1du-xW0qrS4wJTfTYnzjfPIlQobKY6Q57KadZUO5-xtw/edit?usp=sharing

Pasos para usarlo, luego de instalar [Docker](https://hub.docker.com/search/?type=edition&offering=community):

* Primero con start_postgres.sh se levanta la base de datos
* Con extract_load.R se baja la data de la API de stripe y se sube a la base de datos
* Finalmente hacemos las transformaciones en transform.R
