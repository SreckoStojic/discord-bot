-- CreateEnum
CREATE TYPE "TourType" AS ENUM ('SINGLE', 'TEAM');

-- CreateEnum
CREATE TYPE "TourCheckIn" AS ENUM ('CHECKED', 'NOT_CHECKED');

-- CreateEnum
CREATE TYPE "Region" AS ENUM ('EU', 'USE', 'USW', 'AUS');

-- CreateTable
CREATE TABLE "Tournament" (
    "id" BIGINT NOT NULL,
    "guildId" BIGINT NOT NULL,
    "name" TEXT NOT NULL,
    "maxParticipants" INTEGER NOT NULL,
    "role" TEXT NOT NULL,
    "type" "TourType" NOT NULL,
    "startDate" TIMESTAMP(3),
    "registrationEndDate" TIMESTAMP(3),
    "channelCategoryId" BIGINT,
    "registrationChannelId" BIGINT,
    "informationChannelId" BIGINT,
    "commandChannelId" BIGINT,
    "brackets" TEXT,
    "stream" TEXT,
    "prizepool" TEXT,
    "details" TEXT,
    "rules" TEXT,
    "seasonId" BIGINT,
    "buyIn" BOOLEAN NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "Tournament_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TournamentPlayer" (
    "playerId" BIGINT NOT NULL,
    "tourId" BIGINT NOT NULL,
    "checkIn" "TourCheckIn" NOT NULL DEFAULT 'NOT_CHECKED',
    "buyIn" BOOLEAN
);

-- CreateTable
CREATE TABLE "Player" (
    "id" BIGINT NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT,
    "region" "Region",
    "deletedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "Player_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Guild" (
    "id" BIGINT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Guild_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Role" (
    "id" BIGINT NOT NULL,
    "name" TEXT NOT NULL,
    "guildId" BIGINT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Season" (
    "id" BIGINT NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Season_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Team" (
    "id" BIGINT NOT NULL,
    "name" TEXT NOT NULL,
    "captainId" BIGINT NOT NULL,
    "region" "Region",
    "imgUrl" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Team_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TourTeam" (
    "tourId" BIGINT NOT NULL,
    "teamId" BIGINT NOT NULL,
    "joinId" BIGINT NOT NULL,
    "captainId" BIGINT NOT NULL,
    "points" INTEGER NOT NULL,
    "placement" INTEGER NOT NULL,
    "confirmed" "TourCheckIn" NOT NULL DEFAULT 'NOT_CHECKED',
    "wins" INTEGER NOT NULL,
    "loses" INTEGER NOT NULL,
    "confirmedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "TourTeamPlayer" (
    "tourId" BIGINT NOT NULL,
    "teamId" BIGINT NOT NULL,
    "playerId" BIGINT NOT NULL,
    "checkIn" "TourCheckIn" NOT NULL DEFAULT 'NOT_CHECKED',
    "buyIn" BOOLEAN,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateIndex
CREATE UNIQUE INDEX "TournamentPlayer_playerId_tourId_key" ON "TournamentPlayer"("playerId", "tourId");

-- CreateIndex
CREATE UNIQUE INDEX "TourTeam_joinId_key" ON "TourTeam"("joinId");

-- CreateIndex
CREATE UNIQUE INDEX "TourTeam_tourId_teamId_key" ON "TourTeam"("tourId", "teamId");

-- CreateIndex
CREATE UNIQUE INDEX "TourTeamPlayer_tourId_teamId_playerId_key" ON "TourTeamPlayer"("tourId", "teamId", "playerId");

-- AddForeignKey
ALTER TABLE "Tournament" ADD CONSTRAINT "Tournament_guildId_fkey" FOREIGN KEY ("guildId") REFERENCES "Guild"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Tournament" ADD CONSTRAINT "Tournament_seasonId_fkey" FOREIGN KEY ("seasonId") REFERENCES "Season"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TournamentPlayer" ADD CONSTRAINT "TournamentPlayer_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "Player"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TournamentPlayer" ADD CONSTRAINT "TournamentPlayer_tourId_fkey" FOREIGN KEY ("tourId") REFERENCES "Tournament"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Role" ADD CONSTRAINT "Role_guildId_fkey" FOREIGN KEY ("guildId") REFERENCES "Guild"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Team" ADD CONSTRAINT "Team_captainId_fkey" FOREIGN KEY ("captainId") REFERENCES "Player"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TourTeam" ADD CONSTRAINT "TourTeam_captainId_fkey" FOREIGN KEY ("captainId") REFERENCES "Player"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TourTeam" ADD CONSTRAINT "TourTeam_tourId_fkey" FOREIGN KEY ("tourId") REFERENCES "Tournament"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TourTeam" ADD CONSTRAINT "TourTeam_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TourTeamPlayer" ADD CONSTRAINT "TourTeamPlayer_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "Player"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TourTeamPlayer" ADD CONSTRAINT "TourTeamPlayer_tourId_teamId_fkey" FOREIGN KEY ("tourId", "teamId") REFERENCES "TourTeam"("tourId", "teamId") ON DELETE CASCADE ON UPDATE CASCADE;
