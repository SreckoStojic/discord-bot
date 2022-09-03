import { prismaClient } from '../../../prisma';
import { PlayerConstructor } from '../contracts/player.types';

export const findOne = async (condition: object) => {
  return prismaClient.player.findUnique({
    where: { ...condition },
    include: {
      tournaments: true,
    },
  });
};

export const createPlayer = async ({
  id,
  username,
  email,
  region,
}: PlayerConstructor) => {
  const data = {
    id,
    username,
    email,
    region,
  };
  return prismaClient.player.create({ data });
};
