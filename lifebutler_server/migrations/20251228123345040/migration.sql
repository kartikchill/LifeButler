BEGIN;

--
-- ACTION ALTER TABLE "goal"
--
ALTER TABLE "goal" ADD COLUMN "targetCount" bigint NOT NULL DEFAULT 1;
ALTER TABLE "goal" ADD COLUMN "completedCount" bigint NOT NULL DEFAULT 0;
ALTER TABLE "goal" ADD COLUMN "periodType" text NOT NULL DEFAULT 'month';

-- Add periodStart and set default to createdAt
ALTER TABLE "goal" ADD COLUMN "periodStart" timestamp without time zone;
UPDATE "goal" SET "periodStart" = "createdAt";
ALTER TABLE "goal" ALTER COLUMN "periodStart" SET NOT NULL;

-- Add periodEnd and set default to end of month of createdAt
ALTER TABLE "goal" ADD COLUMN "periodEnd" timestamp without time zone;
UPDATE "goal" SET "periodEnd" = (date_trunc('month', "createdAt") + interval '1 month' - interval '1 second');
ALTER TABLE "goal" ALTER COLUMN "periodEnd" SET NOT NULL;

ALTER TABLE "goal" ADD COLUMN "lastCompletedAt" timestamp without time zone;

--
-- MIGRATION VERSION FOR lifebutler
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('lifebutler', '20251228123345040', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251228123345040', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();

COMMIT;
