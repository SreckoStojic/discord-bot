import { Region } from '@prisma/client';

export type PlayerConstructor = {
  id: string;
  username: string;
  email?: string | null | undefined;
  region?: Region | null | undefined;
};
