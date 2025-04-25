# Fit Match - Documentación de Despliegue

## Descripción
Fit Match es una plataforma digital diseñada para conectar personas con intereses fitness similares, facilitando la coordinación de sesiones de entrenamiento conjuntas. El proyecto, desarrollado como una aplicación web en Java, busca expandirse a plataformas móviles (Android e iOS).

## Requisitos

### Hardware
*   **Servidor web (dedicado o en la nube):**
    *   Procesador: Intel Xeon o AMD Ryzen (mínimo 4 núcleos)
    *   Memoria RAM: 8 GB mínimo
    *   Almacenamiento: 100 GB SSD
*   **Equipo de desarrollo:**
    *   Laptops o PCs con procesador i5 o superior
    *   8 GB de RAM o más
    *   Disco SSD de al menos 256 GB

### Software
*   Lenguaje de programación: Java 11 o superior
*   Frontend: HTML, CSS, JavaScript
*   Base de datos: MySQL / PostgreSQL
*   Servidor de aplicaciones: Apache Tomcat
*   Control de versiones: Git

### Requisitos de Seguridad
*   Certificado SSL para cifrado HTTPS
*   Autenticación segura (OAuth 2.0, tokens JWT)
*   Políticas de privacidad conforme a la normativa local
*   Backups automáticos y cifrado de base de datos
*   Protección contra ataques comunes (XSS, SQL Injection)

## Procedimientos

### Pasos para el Despliegue

1.  **Configuración del Entorno:**
    *   Instalar Java 11 o superior.
    *   Instalar Apache Tomcat.
    *   Configurar la base de datos (MySQL o PostgreSQL).
2.  **Obtención del Código Fuente:**
    *   Clonar el repositorio de Git:
        ```
        git clone https://github.com/UPT-FAING-EPIS/proyecto-si784-2025-i-u1-fitmatch.git
        ```
3.  **Configuración de la Aplicación:**
    *   Configurar la conexión a la base de datos en el archivo de propiedades.
    *   Ajustar la configuración del servidor (puerto, etc.) en el archivo `server.xml` de Tomcat.
4.  **Compilación y Empaquetado:**
    *   Generar el archivo WAR para desplegar en Tomcat.
5.  **Despliegue en Tomcat:**
    *   Copiar el archivo WAR a la carpeta `webapps` de Tomcat.
    *   Iniciar o reiniciar el servidor Tomcat.
6.  **Verificación:**
    *   Acceder a la aplicación a través del navegador (`http://localhost:8080/FitMatch`).
    *   Verificar el correcto funcionamiento de las funcionalidades principales.

