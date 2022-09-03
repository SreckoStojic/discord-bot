// Discord
import { CacheType, Interaction } from 'discord.js';

// Entities
import { Player } from '../entities/player/player.entity';

// Actions
import { replyMessage, roll } from './commands.actions';

// Static
import { Command } from './static';

// Prisma enums
import { Region } from '@prisma/client';

// Utils
import { getRandomNumber, isAction } from '../utils';
import {
  createPlayer,
  findOne,
} from '../entities/player/repository/player.repository';

export const interactionCreate = async (
  interaction: Interaction<CacheType>
) => {
  if (!interaction.isChatInputCommand()) return;

  // HELLO
  if (isAction(interaction, Command.HELLO)) {
    console.log(interaction.options);
    await replyMessage(interaction, `Greetings ${interaction.member}!`);
  }

  // ROLL
  if (isAction(interaction, Command.ROLL)) {
    await roll(interaction);
  }

  // CREATE TOUR
  if (isAction(interaction, Command.CREATE_TOUR)) {
    await replyMessage(
      interaction,
      `${interaction.options.data.map((obj) => obj.value)} `
    );
  }

  // REGISTER
  if (isAction(interaction, Command.REGISTER)) {
    console.log(interaction.options);
    const { id, username } = interaction.user;
    const email = interaction.options.get('email')?.value;
    const region = interaction.options.get('region')?.value;
    const player = await createPlayer({
      id,
      username,
      email: email ? (email as string) : null,
      region: region ? (region as Region) : null,
    });
    await replyMessage(interaction, `${JSON.stringify(player)} `);
  }
};
