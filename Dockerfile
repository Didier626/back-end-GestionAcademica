# Usar imagen base de OpenJDK 17
FROM openjdk:17-jdk-slim

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

# Exponer el puerto
EXPOSE 8080

# Variable de entorno para el puerto
ENV PORT=8080

# Comando para ejecutar la aplicación
ENTRYPOINT ["sh", "-c", "java -jar target/*.jar"]

