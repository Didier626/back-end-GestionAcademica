package com.example.demo.config;

import org.springframework.lang.NonNull;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * CorsConfig
 * -----------------------------------------------------
 * ✔ Configuración global de CORS para todos los endpoints /api/**
 * ✔ Permite todos los puertos de localhost usando patrones
 * ✔ Soporta credenciales (cookies, headers de autenticación)
 * ✔ Configuración centralizada y mantenible
 */
@Configuration
public class CorsConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(@NonNull CorsRegistry registry) {
        registry.addMapping("/api/**")
                // ✅ Patrones de orígenes permitidos (soporta wildcards en puertos)
                .allowedOriginPatterns(
                        "http://localhost:*",      // Todos los puertos de localhost
                        "http://127.0.0.1:*",      // Todos los puertos de 127.0.0.1
                        "https://back-end-gestionacademica.onrender.com" // Producción
                )
                // ✅ Métodos HTTP permitidos
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                // ✅ Headers permitidos
                .allowedHeaders("*")
                // ✅ Permitir credenciales (cookies, Authorization headers)
                // ⚠️ Funciona porque usamos allowedOriginPatterns en lugar de allowedOrigins
                .allowCredentials(true)
                // ✅ Tiempo de caché para preflight requests (en segundos)
                .maxAge(3600);
    }
}
