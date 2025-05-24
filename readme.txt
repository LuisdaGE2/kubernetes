# Guía de Setup para Microservicios en Kubernetes

## Prerrequisitos
- Docker Desktop instalado
- Cuenta en Docker Hub
- kubectl instalado

## 1. Habilitar Kubernetes en Docker Desktop
1. Abrir Docker Desktop
2. Ir a Settings (Configuración)
3. En la sección "Kubernetes"
4. Marcar la casilla "Enable Kubernetes"
5. Hacer clic en "Apply & Restart"
6. Esperar a que Kubernetes esté listo

## 2. Verificar la instalación de Kubernetes
```bash
kubectl cluster-info
kubectl get nodes
```

## 3. Construir y subir las imágenes Docker

### Importante: Reemplazar el usuario de Docker Hub
En todos los comandos que siguen, reemplaza `mushunaitor` por tu nombre de usuario de Docker Hub.

También necesitas modificar el archivo `build-and-push.sh` y cambiar la línea:
```bash
DOCKER_REGISTRY="mushunaitor"  # Reemplaza con tu usuario de Docker Hub
```
por tu nombre de usuario de Docker Hub.

### Login a Docker Hub
```bash
docker login
```

### Construir y subir cada microservicio

#### Para el servicio suma
```bash
docker build -t mushunaitor/suma:1.0.0 ./suma
docker push mushunaitor/suma:1.0.0
docker tag mushunaitor/suma:1.0.0 mushunaitor/suma:latest
docker push mushunaitor/suma:latest
```

#### Para el servicio resta
```bash
docker build -t mushunaitor/resta:1.0.0 ./resta
docker push mushunaitor/resta:1.0.0
docker tag mushunaitor/resta:1.0.0 mushunaitor/resta:latest
docker push mushunaitor/resta:latest
```

#### Para el servicio ecuacion
```bash
docker build -t mushunaitor/ecuacion:1.0.0 ./ecuacion
docker push mushunaitor/ecuacion:1.0.0
docker tag mushunaitor/ecuacion:1.0.0 mushunaitor/ecuacion:latest
docker push mushunaitor/ecuacion:latest
```

#### Para el servicio almacenar
```bash
docker build -t mushunaitor/almacenar:1.0.0 ./almacenar
docker push mushunaitor/almacenar:1.0.0
docker tag mushunaitor/almacenar:1.0.0 mushunaitor/almacenar:latest
docker push mushunaitor/almacenar:latest
```

## 4. Desplegar en Kubernetes

### Aplicar la configuración
```bash
kubectl apply -k k8s/
```

### Verificar el despliegue
```bash
# Ver el estado de los pods
kubectl get pods

# Ver los servicios
kubectl get services

# Ver el ingress
kubectl get ingress
```

## 5. Probar la aplicación

### En Postman
1. Crear una nueva petición POST
2. URL: http://localhost:8001/sumar
3. En la opción raw (JSON), enviar:
```json
{
    "a": 15,
    "b": 17
}
```
4. El resultado en JSON será: 32

## 6. Estructura del proyecto
- `suma/`: Microservicio para operaciones de suma
- `resta/`: Microservicio para operaciones de resta
- `ecuacion/`: Microservicio coordinador
- `almacenar/`: Microservicio para almacenar resultados
- `mysql/`: Configuración de la base de datos
- `k8s/`: Archivos de configuración de Kubernetes

## 7. Comandos útiles para debugging
```bash
# Ver logs de un pod específico
kubectl logs <nombre-del-pod>

# Ver detalles de un pod
kubectl describe pod <nombre-del-pod>

# Ver detalles de un servicio
kubectl describe service <nombre-del-servicio>

# Acceder a un pod
kubectl exec -it <nombre-del-pod> -- /bin/bash
```

## 8. Limpieza
Para eliminar todos los recursos de Kubernetes:
```bash
kubectl delete -k k8s/
```