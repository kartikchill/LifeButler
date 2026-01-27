BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "goal" ADD COLUMN "currentStreak" bigint;
ALTER TABLE "goal" ADD COLUMN "longestStreak" bigint;
ALTER TABLE "goal" ADD COLUMN "lastEvaluatedPeriodEnd" timestamp without time zone;

--
-- MIGRATION VERSION FOR lifebutler
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('lifebutler', '20260108170142326', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260108170142326', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();


COMMIT;
