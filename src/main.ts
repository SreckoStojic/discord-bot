// Discord
import { Routes } from 'discord.js';

// Config
import { client, config, rest } from './config';

// Commands
import { commands, interactionCreate } from './commands';

(async () => {
  try {
    console.log('Started refreshing application (/) commands.');
    await rest.put(Routes.applicationCommands(config.applicationId), {
      body: commands,
    });

    console.log('Successfully reloaded application (/) commands.');
  } catch (error) {
    console.error(error);
  }
})();

client.on('ready', () => {
  console.info(`
                ################################################
                🛡️  Logged in as ${client.user?.tag}! 🛡️
                ################################################
              `);
});
client.on('interactionCreate', interactionCreate);

console.log('Webhook test');

client.login(config.token);
