-- CreateEnum
CREATE TYPE "TourType" AS ENUM ('SINGLE', 'TEAM');

-- CreateEnum
CREATE TYPE "TourCheckIn" AS ENUM ('CHECKED', 'NOT_CHECKED');

-- CreateEnum
CREATE TYPE "Region" AS ENUM ('EU', 'USE', 'USW', 'AUS');

-- CreateTable
CREATE TABLE "Tournament" (
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "maxParticipants" INTEGER NOT NULL,
    "role" TEXT NOT NULL,
    "type" "TourType" NOT NULL,
    "startDate" TIMESTAMP(3),
    "registrationEndDate" TIMESTAMP(3),
    "channelCategoryId" TEXT,
    "registrationChannelId" TEXT,
    "informationChannelId" TEXT,
    "commandChannelId" TEXT,
    "brackets" TEXT,
    "stream" TEXT,
    "prizepool" TEXT,
    "details" TEXT,
    "rules" TEXT,
    "seasonId" TEXT,
    "buyIn" BOOLEAN NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "Tournament_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TournamentPlayer" (
    "playerId" TEXT NOT NULL,
    "tourId" TEXT NOT NULL,
    "checkIn" "TourCheckIn" NOT NULL DEFAULT 'NOT_CHECKED',
    "buyIn" BOOLEAN
);

-- CreateTable
CREATE TABLE "Player" (
    "id" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT,
    "region" "Region",
    "deletedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "Player_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "TournamentPlayer_playerId_tourId_key" ON "TournamentPlayer"("playerId", "tourId");

-- AddForeignKey
ALTER TABLE "TournamentPlayer" ADD CONSTRAINT "TournamentPlayer_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "Player"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TournamentPlayer" ADD CONSTRAINT "TournamentPlayer_tourId_fkey" FOREIGN KEY ("tourId") REFERENCES "Tournament"("id") ON DELETE CASCADE ON UPDATE CASCADE;
