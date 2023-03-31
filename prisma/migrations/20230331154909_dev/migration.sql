-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Timecard" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "numOfWeeks" INTEGER NOT NULL,
    "isSubmitted" BOOLEAN NOT NULL,
    "isApproved" BOOLEAN NOT NULL,
    "isRejected" BOOLEAN NOT NULL,
    "isLocked" BOOLEAN NOT NULL,

    CONSTRAINT "Timecard_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Entry" (
    "id" SERIAL NOT NULL,
    "timecardId" INTEGER NOT NULL,
    "numberOfHours" INTEGER NOT NULL,
    "task" TEXT NOT NULL,

    CONSTRAINT "Entry_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- AddForeignKey
ALTER TABLE "Timecard" ADD CONSTRAINT "Timecard_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Entry" ADD CONSTRAINT "Entry_timecardId_fkey" FOREIGN KEY ("timecardId") REFERENCES "Timecard"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
