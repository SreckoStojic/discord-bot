// Discord
import { CacheType, CommandInteraction, InteractionResponse } from 'discord.js';
import { getRandomNumber } from '../utils';

export const replyMessage = async (
  interaction: CommandInteraction<CacheType>,
  message: string
): Promise<InteractionResponse> => {
  return interaction.reply(message);
};

export const roll = async (
  interaction: CommandInteraction<CacheType>
): Promise<InteractionResponse | undefined> => {
  const from = interaction.options.get('from')?.value;
  const to = interaction.options.get('to')?.value;
  if (typeof from === 'number' && typeof to === 'number')
    return replyMessage(interaction, `${getRandomNumber(from, to)}`);
};
