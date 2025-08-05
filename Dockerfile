FROM python:3.11

WORKDIR /code

COPY requirements.txt .

RUN pip install --no-cache-dir -r deps.txt

COPY ./src /code/src

CMD ["uvicorn", "src.main:server", "--host", "0.0.0.0", "--port", "80"]
