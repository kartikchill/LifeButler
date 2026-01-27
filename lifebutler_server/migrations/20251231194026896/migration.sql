BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "goal" ADD COLUMN "consistencyStyle" text;
ALTER TABLE "goal" ADD COLUMN "anchorTime" timestamp without time zone;

--
-- MIGRATION VERSION FOR lifebutler
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('lifebutler', '20251231194026896', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251231194026896', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();


COMMIT;
