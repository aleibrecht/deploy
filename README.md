Scripts para deployar Tryton con la localización Argentina.
===========================================================

Nota: `Previamente se debe seguir los pasos de instalación de algunos paquetes con el usuario root.`

El script de instalación esta preparado para que se ejecute por un usuario distinto a root si fuera necesario.

Antes de ejecutar el archivo `deploy.sh`, se deben acomodar las variables al entorno.
Al script `deploy.sh` se le deben pasar ciertos parámetros.

Ejemplo de ejecución::

```
./deploy.sh -t 3.4 -i /opt/tryton-localizacion-ar -c /etc/trytond.conf
```

Utilizará el tag 3.4, se instalará en el directorio /opt/tryton-localizacion-ar y utilizará la configuración de /etc/trytond.conf

Variable que usa el script y se pueden reacomodar.
```
VIRTUALENV="tryton-localizacion-ar"
DATABASE_NAME="tryton_ar"
DATABASE_HOST="localhost"
```

Instalación
-----------

Esta documentación esta basada para ser instalada usando `debian-7.x`.
Este script utiliza virtualenv para instalar trytond con la Localización Argentina.

1. Crear el usuario para ejecutar el script de deploy.

Para la versión 3.4 estamos instalando de la siguiente manera:

 * instalar los paquetes necesarios para ejecutar y desarrollar sobre el servidor::

```
    apt-get install \
           python-dev swig python-pip python-dev python-lxml libxml2-dev libxslt-dev \
           postgresql postgresql-client postgresql-server-dev-all libpq-dev \
           make git mercurial
```

   * si queremos generar pdfs, es necesario instalar dos paquetes más::

```
    apt-get install libreoffice-java-common python-uno
```

 * instalar el virtualenvwrapper::

```
    pip install virtualenvwrapper
```

Configuración:
--------------

Creamos el usuario en el posgreSLQ

 * configurar el usuario en postgresql::

```
    sudo su postgres -c 'createuser --createdb --no-adduser -P tryton'
```

   * para la clave podemos usar ``tryton``.
   * si no cambiamos la configuración el servidor postgresql responderá sólo a localhost.

 * modificar la configuración del servidor ``trytond`` en ``/etc/trytond.conf``:

Ejemplo de trytond.conf:

```
[jsonrpc]
listen=*:8000
data=/var/lib/trytond

[database]
uri=postgresql://tryton:tryton@localhost:5432
path=/var/lib/trytond # directorio donde se guardaran los adjuntos

[session]
timeout=3600
super_pwd=hrNNibAnqs1ng
```

   * el crypt indicado en ``super_pwd`` corresponde a la clave ``tryton34``. de ser necesario puede generarse un crypt para otra clave con el siguiente comando::

```
    python -c 'import getpass,crypt,random,string; print crypt.crypt(getpass.getpass(), \
               "".join(random.sample(string.ascii_letters + string.digits, 8)))'
```

Ejecutar el servidor
--------------------

Para correr el servidor, se debe ingresar al virtualenv y ejecutar el comando ``trytond -c /etc/trytond.conf``.

Ejemplo de script de Inicio:
----------------------------

```
#!/bin/bash -e

source /PATH/.virtualenvs/tryton-localizacion-ar/bin/activate
trytond -c /etc/trytond.conf

exit 0
```
