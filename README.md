# Demo - Spring Boot API

API REST desarrollada con Spring Boot para gestión de cursos, estudiantes, profesores y evaluaciones.

## 🚀 Despliegue en Render

### Prerrequisitos

1. Cuenta en [Render](https://render.com)
2. Base de datos MySQL (puedes usar [Render PostgreSQL](https://render.com/docs/databases) o cualquier proveedor de MySQL)
3. Repositorio en GitHub

### Pasos para Desplegar

#### 1. Preparar el Repositorio en GitHub

```bash
# Asegúrate de estar en la raíz del proyecto (donde está el pom.xml)
git init
git add .
git commit -m "Initial commit - Ready for Render deployment"
git branch -M main
git remote add origin <TU_REPOSITORIO_GITHUB>
git push -u origin main
```

#### 2. Crear Base de Datos en Render

1. Ve a tu dashboard de Render
2. Click en "New +" → "PostgreSQL" (o MySQL si está disponible)
3. Configura la base de datos:
   - **Name**: `demo-db` (o el nombre que prefieras)
   - **Database**: `as_cursos` (o el nombre que uses)
   - **User**: Se generará automáticamente
   - **Password**: Se generará automáticamente
4. Guarda las credenciales que Render te proporciona

#### 3. Crear Web Service en Render

1. En Render, click en "New +" → "Web Service"
2. Conecta tu repositorio de GitHub
3. Configura el servicio:
   - **Name**: `demo-api` (o el nombre que prefieras)
   - **Environment**: `Java`
   - **Build Command**: `./mvnw clean package -DskipTests`
   - **Start Command**: `java -jar target/*.jar`
   - **Instance Type**: `Free` (o el plan que prefieras)

#### 4. Configurar Variables de Entorno en Render

En la sección "Environment" del servicio web, agrega las siguientes variables:

```
PORT=8080
SPRING_DATASOURCE_URL=jdbc:mysql://<HOST>:<PORT>/<DATABASE>?useSSL=true&serverTimezone=UTC
SPRING_DATASOURCE_USERNAME=<TU_USUARIO>
SPRING_DATASOURCE_PASSWORD=<TU_CONTRASEÑA>
JWT_SECRET=<TU_CLAVE_SECRETA_BASE64>
```

**Ejemplo de valores:**

```
PORT=8080
SPRING_DATASOURCE_URL=jdbc:mysql://dpg-xxxxx-a.oregon-postgres.render.com:5432/as_cursos
SPRING_DATASOURCE_USERNAME=demo_user
SPRING_DATASOURCE_PASSWORD=tu_password_seguro
JWT_SECRET=tu_clave_base64_aqui
```

**⚠️ IMPORTANTE - Generar JWT_SECRET:**

Para generar una clave JWT segura, ejecuta en tu terminal:

```bash
# Linux/Mac
openssl rand -base64 64

# Windows (PowerShell)
[Convert]::ToBase64String((1..64 | ForEach-Object { Get-Random -Minimum 0 -Maximum 256 }))
```

Copia el resultado y úsalo como valor de `JWT_SECRET`.

#### 5. Desplegar

1. Click en "Create Web Service"
2. Render comenzará a construir y desplegar tu aplicación
3. Espera a que el build termine (puede tomar 5-10 minutos la primera vez)
4. Una vez desplegado, tu API estará disponible en: `https://tu-servicio.onrender.com`

### 🔍 Verificar el Despliegue

Una vez desplegado, puedes verificar que funciona:

1. **Swagger UI**: `https://tu-servicio.onrender.com/swagger-ui.html`
2. **Health Check**: `https://tu-servicio.onrender.com/api/auth/login` (debería responder con error 400/401, lo cual es normal)

### 📝 Notas Importantes

- **Primera carga lenta**: Render "duerme" los servicios gratuitos después de 15 minutos de inactividad. La primera petición puede tardar 30-60 segundos.
- **Base de datos**: Asegúrate de que la URL de la base de datos sea accesible desde Render. Si usas una base de datos externa, verifica que permita conexiones desde la IP de Render.
- **Logs**: Puedes ver los logs en tiempo real en el dashboard de Render.
- **Variables de entorno**: Nunca subas archivos `.env` al repositorio. Todas las credenciales deben estar en las variables de entorno de Render.

## 🏃 Ejecución Local

Para ejecutar el proyecto localmente:

```bash
# Compilar
./mvnw clean package -DskipTests

# Ejecutar
mvn spring-boot:run
```

O con variables de entorno:

```bash
export PORT=8080
export SPRING_DATASOURCE_URL=jdbc:mysql://localhost:3306/as_cursos
export SPRING_DATASOURCE_USERNAME=root
export SPRING_DATASOURCE_PASSWORD=tu_password
export JWT_SECRET=tu_clave_base64

mvn spring-boot:run
```

## 📦 Estructura del Proyecto

```
demo/
├── src/
│   ├── main/
│   │   ├── java/com/example/demo/
│   │   │   ├── controllers/     # Controladores REST
│   │   │   ├── services/        # Interfaces de servicios
│   │   │   ├── servicesImpl/   # Implementaciones
│   │   │   ├── repositories/    # Repositorios JPA
│   │   │   ├── entities/        # Entidades JPA
│   │   │   ├── dtos/            # Data Transfer Objects
│   │   │   ├── security/        # Configuración JWT y Security
│   │   │   └── config/          # Configuraciones
│   │   └── resources/
│   │       └── application.properties
│   └── test/
├── pom.xml
└── README.md
```

## 🔐 Seguridad

- La API usa JWT para autenticación
- Las contraseñas se encriptan con BCrypt
- Las rutas públicas son: `/api/auth/login` y `/api/auth/register`
- Todas las demás rutas requieren autenticación

## 📚 Endpoints Principales

- `POST /api/auth/register` - Registro de usuarios
- `POST /api/auth/login` - Inicio de sesión
- `GET /api/auth/me` - Obtener usuario autenticado
- `GET /swagger-ui.html` - Documentación Swagger

## 🛠️ Tecnologías

- Spring Boot 3.5.5
- Spring Security
- JWT (JSON Web Tokens)
- MySQL
- MapStruct
- Lombok
- Swagger/OpenAPI

