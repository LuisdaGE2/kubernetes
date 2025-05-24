```markdown
# Guía de Configuración: Microservicios con Kubernetes

Este documento explica paso a paso cómo preparar y desplegar un conjunto de microservicios en un clúster local de Kubernetes, utilizando Docker y kubectl.

---

## Requisitos

Antes de comenzar, asegúrate de tener lo siguiente instalado y configurado:

- Docker Desktop
- kubectl (herramienta de línea de comandos para Kubernetes)
- Una cuenta en Docker Hub

---

## Paso 1: Activar Kubernetes desde Docker Desktop

1. Abre la aplicación Docker Desktop.
2. Haz clic en **Settings** (Configuración).
3. Ve a la pestaña **Kubernetes**.
4. Activa la opción **Enable Kubernetes**.
5. Presiona **Apply & Restart** para aplicar los cambios.
6. Espera a que Kubernetes termine de inicializarse.

---

## Paso 2: Validar que Kubernetes está funcionando

Abre una terminal y ejecuta:

```bash
kubectl cluster-info
kubectl get nodes
```

Ambos comandos deben devolver información del clúster si todo está funcionando correctamente.

---

## Paso 3: Construcción y Publicación de Imágenes en Docker Hub

> **Importante:** En los siguientes comandos, reemplaza `tuusuario` por tu propio usuario de Docker Hub.

Si utilizas un script como `build-and-push.sh`, asegúrate de modificar la línea:

```bash
DOCKER_REGISTRY="tuusuario"
```

### Iniciar sesión en Docker Hub

```bash
docker login
```

### Crear y subir imágenes para cada servicio

#### Servicio suma

```bash
docker build -t tuusuario/suma:1.0.0 ./suma
docker push tuusuario/suma:1.0.0
docker tag tuusuario/suma:1.0.0 tuusuario/suma:latest
docker push tuusuario/suma:latest
```

#### Servicio resta

```bash
docker build -t tuusuario/resta:1.0.0 ./resta
docker push tuusuario/resta:1.0.0
docker tag tuusuario/resta:1.0.0 tuusuario/resta:latest
docker push tuusuario/resta:latest
```

#### Servicio ecuacion

```bash
docker build -t tuusuario/ecuacion:1.0.0 ./ecuacion
docker push tuusuario/ecuacion:1.0.0
docker tag tuusuario/ecuacion:1.0.0 tuusuario/ecuacion:latest
docker push tuusuario/ecuacion:latest
```

#### Servicio almacenar

```bash
docker build -t tuusuario/almacenar:1.0.0 ./almacenar
docker push tuusuario/almacenar:1.0.0
docker tag tuusuario/almacenar:1.0.0 tuusuario/almacenar:latest
docker push tuusuario/almacenar:latest
```

---

## Paso 4: Desplegar en Kubernetes

Aplica los archivos de configuración desde el directorio `k8s/`:

```bash
kubectl apply -k k8s/
```

Verifica que los recursos se hayan desplegado correctamente:

```bash
kubectl get pods
kubectl get services
kubectl get ingress
```

---

## Paso 5: Probar la Aplicación (Postman)

1. Abre Postman.
2. Crea una nueva solicitud de tipo **POST**.
3. Usa la siguiente URL:  
   `http://localhost:8001/sumar`
4. En el cuerpo (**Body**), selecciona la opción **raw** y elige **JSON**.
5. Envía lo siguiente:

```json
{
  "a": 15,
  "b": 17
}
```

6. El resultado esperado es:

```json
{
  "resultado": 32
}
```

---

## Estructura General del Proyecto

```plaintext
.
├── suma/         # Servicio para sumar
├── resta/        # Servicio para restar
├── ecuacion/     # Servicio principal coordinador
├── almacenar/    # Servicio para guardar resultados
├── mysql/        # Configuración de base de datos
└── k8s/          # Archivos de configuración de Kubernetes
```

---

## Comandos Útiles para Diagnóstico

```bash
# Ver logs de un pod
kubectl logs <nombre-del-pod>

# Obtener detalles de un pod
kubectl describe pod <nombre-del-pod>

# Obtener detalles de un servicio
kubectl describe service <nombre-del-servicio>

# Ingresar a un contenedor dentro de un pod
kubectl exec -it <nombre-del-pod> -- /bin/bash
```

---

## Limpieza de Recursos

Para eliminar todos los recursos creados en Kubernetes:

```bash
kubectl delete -k k8s/
```
