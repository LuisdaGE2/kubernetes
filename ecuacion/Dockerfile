FROM python:3.10-slim
WORKDIR /microservicios
COPY multiplica.py .
RUN pip install fastapi pydantic requests uvicorn
RUN pip install mysql-connector-python
CMD ["uvicorn", "multiplica:app", "--host", "0.0.0.0", "--port", "8000"]