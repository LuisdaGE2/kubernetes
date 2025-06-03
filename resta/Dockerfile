FROM python:3.10-slim
WORKDIR /microservicios

# Actualiza los paquetes del sistema y elimina la caché para reducir vulnerabilidades
RUN apt-get update && apt-get upgrade -y && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY resta.py .
RUN pip install --no-cache-dir fastapi pydantic requests uvicorn
CMD ["uvicorn", "resta:app", "--host", "0.0.0.0", "--port", "8000"]