FROM dart:3.10

WORKDIR /app
COPY . .

RUN dart pub get
RUN dart pub global activate serverpod_cli 3.1.1

EXPOSE 8082

CMD ["/bin/sh", "-c", "dart pub get && dart run bin/main.dart --apply-migrations"]
