FROM python:3.10

WORKDIR /opt/events/

RUN pip install poetry
RUN poetry self add poetry-plugin-export
RUN poetry config virtualenvs.create false

COPY pyproject.toml poetry.lock /opt/events/
RUN poetry export -f requirements.txt --output requirements.txt --without dev \
    && pip install --only-binary :all: -r requirements.txt

COPY ./app /opt/events/app

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--proxy-headers"]
