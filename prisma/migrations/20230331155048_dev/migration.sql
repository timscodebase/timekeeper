-- AlterTable
ALTER TABLE "Timecard" ALTER COLUMN "isSubmitted" SET DEFAULT false,
ALTER COLUMN "isApproved" SET DEFAULT false,
ALTER COLUMN "isRejected" SET DEFAULT false,
ALTER COLUMN "isLocked" SET DEFAULT false;
