BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "goal" DROP COLUMN "currentStreak";
ALTER TABLE "goal" DROP COLUMN "longestStreak";
ALTER TABLE "goal" DROP COLUMN "lastEvaluatedPeriodEnd";

--
-- MIGRATION VERSION FOR lifebutler
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('lifebutler', '20260108165358940', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260108165358940', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();


COMMIT;
