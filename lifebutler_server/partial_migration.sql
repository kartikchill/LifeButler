-- Partially applied migration for user tables

CREATE TABLE IF NOT EXISTS "goal" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "isActive" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

CREATE TABLE IF NOT EXISTS "streak" (
    "id" bigserial PRIMARY KEY,
    "goalId" bigint NOT NULL,
    "currentStreak" bigint NOT NULL,
    "bestStreak" bigint NOT NULL,
    "lastCompletedDate" timestamp without time zone
);

CREATE TABLE IF NOT EXISTS "task" (
    "id" bigserial PRIMARY KEY,
    "goalId" bigint NOT NULL,
    "scheduledTime" timestamp without time zone NOT NULL,
    "durationMinutes" bigint NOT NULL,
    "repeatDaily" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

CREATE TABLE IF NOT EXISTS "task_completion" (
    "id" bigserial PRIMARY KEY,
    "taskId" bigint NOT NULL,
    "completedAt" timestamp without time zone NOT NULL
);

CREATE TABLE IF NOT EXISTS "user_mode" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "mode" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Update migration version
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('lifebutler', '20251221153142730', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251221153142730', "timestamp" = now();
