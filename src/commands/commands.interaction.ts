// Discord
import { CacheType, Interaction } from 'discord.js';

// Entities
import { Player } from '../entities';

// Actions
import { message } from './commands.actions';

// Static
import { Command } from './static';

// Utils
import { getRandomNumber, isAction } from '../utils';
import { Region } from '@prisma/client';

export const interactionCreate = async (
  interaction: Interaction<CacheType>
) => {
  if (!interaction.isChatInputCommand()) return;

  // HELLO
  if (isAction(interaction, Command.HELLO)) {
    console.log(interaction.options);
    await message(interaction, `Greetings ${interaction.member}!`);
  }

  // ROLL
  if (isAction(interaction, Command.ROLL)) {
    const from = interaction.options.get('from')?.value;
    const to = interaction.options.get('to')?.value;
    if (typeof from === 'number' && typeof to === 'number')
      await message(interaction, `${getRandomNumber(from, to)}`);
  }

  // CREATE TOUR
  if (isAction(interaction, Command.CREATE_TOUR)) {
    await message(
      interaction,
      `${interaction.options.data.map((obj) => obj.value)} `
    );
  }

  // REGISTER
  if (isAction(interaction, Command.REGISTER)) {
    console.log(interaction.options);
    const { user } = interaction;
    const email = interaction.options.get('email')?.value;
    const region = interaction.options.get('region')?.value;
    const player = new Player(
      user.id,
      user.username,
      email ? (email as string) : null,
      region ? (region as Region) : null
    );
    await message(interaction, `${JSON.stringify(player)} `);
  }
};
