FROM python:3.11

ENV PYTHONUNBUFFERED=13

WORKDIR /app

RUN pip install --upgrade pip "poetry==2.2.1"
RUN poetry config virtualenvs.create false --local
COPY pyproject.toml poetry.lock ./
RUN poetry install --no-root

COPY prod /app/prod

ENV PYTHONPATH=/app/prod/mysite:/app/prod:/app

CMD ["gunicorn", "prod.mysite.mysite.wsgi:application", "--bind", "0.0.0.0:8000"]