# Étape 1 : Builder OCaml
FROM ocaml/opam:alpine-3.18-ocaml-5.0 AS builder
WORKDIR /app

# Copier le code OCaml
COPY . /app

# Installer dépendances si besoin (opam install ...)
# Compiler marina (exemple)
RUN dune build

# Récupérer le binaire compilé (supposons _build/default/marina.exe)
RUN cp _build/default/marina.exe /app/marina

# Étape 2 : Image finale avec Python + binaire marina
FROM python:3.11-alpine
WORKDIR /app

# Copier le binaire marina depuis builder
COPY --from=builder /app/marina /app/marina

# Rendre exécutable
RUN chmod +x /app/marina

# Installer Flask
RUN pip install flask

# Copier API Python
COPY api.py /app/api.py

EXPOSE 5000

CMD ["python", "api.py"]
