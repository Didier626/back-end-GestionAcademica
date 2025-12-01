# Usar imagen base de Eclipse Temurin (OpenJDK oficial)
FROM eclipse-temurin:17-jdk

# Establecer directorio de trabajo
WORKDIR /app

# Copiar el wrapper de Maven
COPY mvnw .
COPY .mvn .mvn

# Dar permisos de ejecución al wrapper
RUN chmod +x ./mvnw

# Copiar el archivo pom.xml
COPY pom.xml .

# Descargar dependencias (esto se cachea si pom.xml no cambia)
RUN ./mvnw dependency:go-offline -B

# Copiar el código fuente
COPY src ./src

# Compilar la aplicación
RUN ./mvnw clean package -DskipTests

# Exponer el puerto (Render usa PORT dinámicamente)
EXPOSE ${PORT:-8080}

# Comando para ejecutar la aplicación
# Render inyecta PORT como variable de entorno
ENTRYPOINT ["sh", "-c", "java -jar target/*.jar"]

