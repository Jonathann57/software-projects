# NBiblioteca

Sistema de gestión de biblioteca desarrollado con **Django 6**. Permite administrar libros, alumnos, préstamos, devoluciones y multas por retrasos.

## Características

* **Alumnos** — registro, perfil, historial de préstamos y estado (activo, suspendido o inactivo).
* **Libros** — inventario con autores, categorías, portadas y control de stock.
* **Categorías** — clasificación de libros y filtrado en el catálogo público.
* **Préstamos** — registro y devolución de libros con actualización automática del stock.
* **Multas** — generación automática de multas por devolución tardía ($1.00 por día), además de gestión de pagos y anulaciones según el rol.
* **Catálogo público** — consulta de libros con portadas, búsqueda y filtro por categoría sin necesidad de iniciar sesión.
* **Reporte de morosos** — consulta de alumnos con multas pendientes o préstamos vencidos.
* **Sistema de roles** — diferenciación de permisos entre Bibliotecarios y Administradores.
* **Panel administrativo** — administración mediante Django Admin y Jazzmin.

---

## Tecnologías

| Tecnología / Paquete | Versión |
| -------------------- | ------- |
| Python               | 3.x     |
| Django               | 6.0.4   |
| Pillow               | 12.2.0  |
| django-jazzmin       | 3.0.4   |
| Bootstrap            | 5.3.3   |
| Bootstrap Icons      | 1.11.3  |
| Boxicons             | 2.1.4   |
| Base de datos        | SQLite  |

> SQLite se utiliza actualmente para el entorno de desarrollo.

---

## Estructura del proyecto

```text
NBiblioteca/
├── apps/
│   ├── alumnos/        # Gestión de alumnos
│   ├── libros/         # Libros, autores y categorías
│   ├── prestamos/      # Préstamos y devoluciones
│   ├── multas/         # Multas por retrasos
│   └── management/     # Comandos personalizados
│
├── media/
│   └── portadas/       # Imágenes de portadas de libros
│
├── static/
│   ├── css/
│   ├── js/
│   └── img/
│
├── templates/
│   ├── base.html
│   ├── base_catalogo.html
│   ├── dashboard.html
│   ├── components/
│   ├── alumnos/
│   ├── libros/
│   ├── prestamos/
│   └── multas/
│
├── NBiblioteca/
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
│
├── manage.py
├── requirements.txt
├── build.sh
└── README.md
```

---

## Instalación

### 1. Clonar el repositorio

```bash
git clone <url-del-repositorio>
cd NBiblioteca
```

### 2. Crear el entorno virtual

#### Windows

```bash
python -m venv venv
venv\Scripts\activate
```

#### Linux / macOS

```bash
python3 -m venv venv
source venv/bin/activate
```

Una vez activado el entorno virtual, el terminal debería mostrar `(venv)` al inicio.

### 3. Instalar las dependencias

```bash
pip install -r requirements.txt
```

### 4. Aplicar las migraciones

```bash
python manage.py migrate
```

### 5. Crear el superusuario

Para crear un usuario administrador de Django:

```bash
python manage.py createsuperuser
```

Django solicitará interactivamente el nombre de usuario, correo electrónico y contraseña.

### 6. Crear roles y permisos

```bash
python manage.py crear_roles
```

### 7. Poblar datos de ejemplo

Si deseas cargar datos de prueba:

```bash
python manage.py poblar_datos
```

### 8. Ejecutar el servidor

```bash
python manage.py runserver
```

La aplicación estará disponible en:

```text
http://127.0.0.1:8000/
```

---

## Instalación rápida con `build.sh`

El proyecto incluye un script `build.sh` que automatiza la preparación de la aplicación.

El script realiza:

| Paso | Acción                                            |
| ---- | ------------------------------------------------- |
| 1/5  | Instala las dependencias desde `requirements.txt` |
| 2/5  | Ejecuta las migraciones de Django                 |
| 3/5  | Solicita la creación del superusuario             |
| 4/5  | Crea los roles y permisos del sistema             |
| 5/5  | Carga datos de ejemplo                            |

### Ejecutar

En Linux / macOS:

```bash
bash build.sh
```

En Windows se recomienda realizar los pasos de instalación manualmente o utilizar **Git Bash** para ejecutar el script.

---

## Creación de usuarios

### Superusuario

El superusuario tiene acceso al panel administrativo de Django.

```bash
python manage.py createsuperuser
```

### Comando personalizado

El proyecto también incluye:

```bash
python manage.py createsu
```

Este comando permite crear un superusuario utilizando variables de entorno.

Ejemplo:

```bash
DJANGO_SUPERUSER_USERNAME=admin
DJANGO_SUPERUSER_EMAIL=admin@example.com
DJANGO_SUPERUSER_PASSWORD=tu_contraseña_segura
python manage.py createsu
```

> No se incluyen contraseñas predeterminadas ni credenciales reales dentro del código fuente.

---

## Comandos personalizados

El proyecto incluye los siguientes comandos de administración:

| Comando                         | Descripción                                          |
| ------------------------------- | ---------------------------------------------------- |
| `python manage.py createsu`     | Crea un superusuario utilizando variables de entorno |
| `python manage.py crear_roles`  | Crea el grupo Bibliotecario y sus permisos           |
| `python manage.py poblar_datos` | Carga datos de ejemplo                               |

---

## Rutas principales

| URL                         | Descripción                    |
| --------------------------- | ------------------------------ |
| `/`                         | Dashboard principal            |
| `/login/`                   | Inicio de sesión               |
| `/catalogo/`                | Catálogo público               |
| `/alumnos/`                 | Gestión de alumnos             |
| `/libros/`                  | Gestión de libros              |
| `/libros/categorias/`       | Gestión de categorías          |
| `/libros/autores/`          | Gestión de autores             |
| `/prestamos/`               | Gestión de préstamos           |
| `/prestamos/<id>/devolver/` | Devolución de un préstamo      |
| `/multas/`                  | Gestión de multas              |
| `/reportes/morosos/`        | Reporte de alumnos morosos     |
| `/admin/`                   | Panel administrativo de Django |

---

## Roles y permisos

El sistema cuenta con dos roles principales:

| Funcionalidad             | Bibliotecario | Administrador |
| ------------------------- | :-----------: | :-----------: |
| Gestionar alumnos         |       ✅       |       ✅       |
| Gestionar libros          |       ✅       |       ✅       |
| Gestionar autores         |       ✅       |       ✅       |
| Gestionar categorías      |       ✅       |       ✅       |
| Registrar préstamos       |       ✅       |       ✅       |
| Registrar devoluciones    |       ✅       |       ✅       |
| Consultar multas          |       ✅       |       ✅       |
| Registrar pagos de multas |       ✅       |       ✅       |
| Anular multas             |       ❌       |       ✅       |
| Acceder a `/admin/`       |       ❌       |       ✅       |
| Crear usuarios            |       ❌       |       ✅       |
| Asignar permisos          |       ❌       |       ✅       |

---

## Crear el grupo Bibliotecario

Ejecuta:

```bash
python manage.py crear_roles
```

Esto crea el grupo **Bibliotecario** y configura los permisos correspondientes.

### Asignar un usuario al grupo

1. Ingresa al panel administrativo.
2. Accede a `/admin/`.
3. Selecciona **Autenticación → Usuarios**.
4. Selecciona el usuario.
5. En **Grupos**, selecciona `Bibliotecario`.
6. Guarda los cambios.

Un usuario con rol Bibliotecario puede utilizar las funcionalidades correspondientes de la aplicación sin tener acceso al panel administrativo de Django.

---

## Lógica de negocio

El sistema implementa diferentes reglas para controlar la operación de la biblioteca:

* Un alumno debe encontrarse en estado **Activo** para recibir préstamos.
* Los alumnos con multas pendientes no pueden recibir nuevos préstamos.
* Al registrar un préstamo, el stock disponible del libro se reduce automáticamente.
* Al devolver un libro, el stock disponible se incrementa automáticamente.
* Las devoluciones tardías generan una multa de **$1.00 por cada día de retraso**.
* Los usuarios pueden consultar el estado de sus préstamos y multas según los permisos asignados.
* Los libros y alumnos que tienen registros relacionados con préstamos cuentan con restricciones para evitar inconsistencias en la información.

---

## Catálogo público

La aplicación incluye un catálogo público que permite consultar los libros disponibles sin iniciar sesión.

El catálogo permite:

* Visualizar portadas.
* Consultar información de los libros.
* Filtrar por categoría.
* Buscar libros.
* Consultar disponibilidad.

---

## Panel administrativo

El proyecto utiliza **django-jazzmin** para proporcionar una interfaz administrativa personalizada para Django.

Desde el panel administrativo se pueden gestionar:

* Usuarios.
* Grupos.
* Permisos.
* Información administrativa del sistema.

---

## Variables de entorno

Para entornos de producción se recomienda utilizar variables de entorno para información sensible.

Por ejemplo:

```text
DJANGO_SECRET_KEY=<clave-secreta>
DJANGO_SUPERUSER_USERNAME=<usuario>
DJANGO_SUPERUSER_EMAIL=<correo>
DJANGO_SUPERUSER_PASSWORD=<contraseña-segura>
```

La clave secreta y las credenciales reales **no deben almacenarse directamente en el repositorio público**.

Para producción también se recomienda configurar:

```python
DEBUG = False

SECRET_KEY = "<clave-secreta-aleatoria>"

ALLOWED_HOSTS = [
    "tu-dominio.com",
]
```

---

## Flujo de trabajo con Git

El proyecto puede utilizar un flujo basado en ramas para organizar el desarrollo.

### Ramas principales

| Rama        | Propósito               |
| ----------- | ----------------------- |
| `main`      | Código estable          |
| `develop`   | Integración de cambios  |
| `avance-50` | Versión de presentación |

### Ramas de trabajo

```text
feature/nombre
```

Para nuevas funcionalidades.

```text
fix/nombre
```

Para correcciones de errores.

### Ejemplo de flujo

```bash
# Actualizar develop
git checkout develop
git pull origin develop

# Crear una rama para una nueva funcionalidad
git checkout -b feature/mi-funcionalidad

# Realizar cambios

# Preparar cambios
git add .

# Crear commit
git commit -m "Agrega nueva funcionalidad"

# Subir la rama
git push origin feature/mi-funcionalidad
```

Posteriormente se puede crear un Pull Request hacia `develop`.

---

## Seguridad

Antes de desplegar el proyecto en producción:

* Cambiar `DEBUG = False`.
* Utilizar una `SECRET_KEY` segura y privada.
* Configurar `ALLOWED_HOSTS`.
* Utilizar variables de entorno para credenciales.
* No subir archivos `.env`.
* No almacenar contraseñas reales en el código fuente.
* Configurar correctamente la base de datos de producción.
* Revisar los permisos de usuarios y grupos.

---

## Estado del proyecto

**Proyecto de gestión de biblioteca desarrollado con Django para fines académicos y de portafolio.**

El sistema integra autenticación, administración de usuarios, gestión de libros, alumnos, préstamos, devoluciones, multas, roles y un catálogo público.
