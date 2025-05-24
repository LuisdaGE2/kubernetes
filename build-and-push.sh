#!/bin/bash

# Configuración
DOCKER_REGISTRY="gigo2404"  # Reemplaza con tu usuario de Docker Hub
VERSION="1.0.0"

# Servicios a construir
SERVICES=("suma" "resta" "ecuacion" "almacenar")

# Login a Docker Hub (se te pedirá tu contraseña)
echo "Iniciando sesión en Docker Hub..."
docker login

# Construir y subir cada imagen
for service in "${SERVICES[@]}"
do
    echo "Construyendo imagen para $service..."
    docker build -t $DOCKER_REGISTRY/$service:$VERSION ./$service
    
    echo "Subiendo imagen de $service a Docker Hub..."
    docker push $DOCKER_REGISTRY/$service:$VERSION
    
    # También subimos la versión latest
    docker tag $DOCKER_REGISTRY/$service:$VERSION $DOCKER_REGISTRY/$service:latest
    docker push $DOCKER_REGISTRY/$service:latest
done

echo "¡Proceso completado!" 