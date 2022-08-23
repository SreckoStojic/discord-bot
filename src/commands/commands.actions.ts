// Discord
import { CacheType, CommandInteraction, InteractionResponse } from 'discord.js';

export const message = async (
  interaction: CommandInteraction<CacheType>,
  message: string
): Promise<InteractionResponse> => {
  return interaction.reply(message);
};
