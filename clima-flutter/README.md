#  Clima Flutter

Aplicación móvil desarrollada con **Flutter** que permite consultar información meteorológica utilizando una **API de clima**.

La aplicación obtiene datos actualizados del clima y los presenta de forma sencilla e intuitiva, permitiendo al usuario consultar las condiciones meteorológicas de una ubicación.

##  Características

*  Consulta de temperatura actual.
*  Información de humedad.
*  Velocidad del viento.
*  Condición meteorológica actual.
*  Información del pronóstico.
*  Iconos e imágenes según las condiciones del clima.
*  Consumo de datos mediante una API meteorológica.

## 🛠️ Tecnologías utilizadas

* **Flutter**
* **Dart**
* **API REST de clima**
* **HTTP/JSON** para la comunicación y procesamiento de datos.

##  Plataforma

El proyecto está desarrollado con Flutter, por lo que puede ejecutarse en diferentes plataformas compatibles con Flutter.

##  Estructura del proyecto

```text
lib/
├── screens/
│   ├── inicio.dart
│   └── welcome.dart
├── services/
│   └── clima_service.dart
├── widgets/
│   ├── item_clima.dart
│   ├── item_pronostico.dart
│   └── tarjeta_clima.dart
└── main.dart

assets/
└── images/
```

La carpeta `services` contiene la lógica utilizada para comunicarse con la API meteorológica, mientras que `screens` y `widgets` contienen las diferentes partes de la interfaz de la aplicación.

##  Instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/Jonathann57/software-projects.git
```

### 2. Entrar al proyecto

```bash
cd software-projects/clima-flutter
```

### 3. Instalar las dependencias

```bash
flutter pub get
```

### 4. Ejecutar la aplicación

```bash
flutter run
```

##  API de clima

La aplicación utiliza una API meteorológica para obtener los datos del clima.

Para ejecutar el proyecto correctamente, es necesario configurar la clave de API de acuerdo con la implementación utilizada en el proyecto.

> **Nota:** No se debe subir una clave de API privada directamente al repositorio público.

## Objetivo del proyecto

Este proyecto fue desarrollado como una práctica de **desarrollo de aplicaciones móviles con Flutter**, implementando el consumo de una API externa para obtener y mostrar información meteorológica en tiempo real.

## Aprendizaje

Con este proyecto se practicaron conceptos como:

* Desarrollo de interfaces con Flutter.
* Programación en Dart.
* Consumo de APIs REST.
* Procesamiento de respuestas JSON.
* Uso de widgets reutilizables.
* Organización del código por servicios, pantallas y componentes.
* Manejo y presentación de información obtenida desde servicios externos.
