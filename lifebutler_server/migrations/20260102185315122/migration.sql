BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "goal" ADD COLUMN "priority" bigint;

--
-- MIGRATION VERSION FOR lifebutler
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('lifebutler', '20260102185315122', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260102185315122', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();


COMMIT;
