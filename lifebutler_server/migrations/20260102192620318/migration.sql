BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reflection" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "goalId" bigint,
    "type" bigint NOT NULL,
    "content" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR lifebutler
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('lifebutler', '20260102192620318', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260102192620318', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();


COMMIT;
