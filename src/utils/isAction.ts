// Discord
import { CommandInteraction } from 'discord.js';

// Static
import { Command } from '../commands/static';

export const isAction = (interaction: CommandInteraction, command: Command) => {
  return interaction.commandName === command ? true : false;
};
