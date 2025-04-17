Proyecto - technical_test_puntos_point

Este es un proyecto desarrollado con Ruby on Rails. A continuación, se encuentran las instrucciones necesarias para levantar el servidor y ejecutar la aplicación localmente.

Requisitos
Antes de comenzar, asegúrate de tener instalados los siguientes requisitos:

Ruby: 2.7.7

Rails: 5.2.8.1

PostgreSQL: Asegúrate de tener PostgreSQL instalado y en ejecución en tu sistema.

Node.js y Yarn: Se necesita para gestionar los activos estáticos.

Bundler: Usado para gestionar las dependencias de Ruby.

Instrucciones para levantar el servidor
1. Clonar el repositorio
Primero, clona el repositorio desde GitHub:

git clone git@github.com:mliedo05/technical_test_puntos_point.git
cd technical_test_puntos_point

2. Instalar las dependencias

bundle install

3. Configurar la base de datos

rails db:create
rails db:migrate
rails db:seed

4. Iniciar el servidor

rails server

5. Ejecutar pruebas

bundle exec rspec

Tecnologías utilizadas
Este proyecto utiliza las siguientes tecnologías:

Ruby 2.7.7

Rails 5.2.8.1

PostgreSQL

RSpec para pruebas

Sidekiq para procesamiento en segundo plano

Devise para autenticación

Sendgrid para envío de correos electrónicos


Gemas utilizadas

Rails: ~> 5.2.8, >= 5.2.8.1

PostgreSQL: pg, >= 0.18, < 2.0

Puma: ~> 3.11

Devise: Para autenticación de usuarios

Devise JWT: Para autenticación JWT

Groupdate: Para realizar operaciones con fechas

SendGrid: Para el envío de correos electrónicos

Dotenv Rails: Para la gestión de variables de entorno

Net-HTTP: Para realizar peticiones HTTP

Sidekiq: Para procesamiento en segundo plano

Whenever: Para la gestión de tareas programadas

RuboCop: Para análisis estático de código

RSpec Rails: Para pruebas en Rails

FactoryBot Rails: Para la creación de datos de prueba

Faker: Para generar datos falsos

Bootsnap: Para reducir el tiempo de arranque

Byebug: Para depuración en desarrollo

Listen: Para la detección de cambios en el sistema de archivos

Spring: Para acelerar el tiempo de arranque en desarrollo

Spring Watcher Listen: Para la vigilancia de cambios en el sistema de archivos

TZInfo Data: Para zonas horarias en sistemas Windows
