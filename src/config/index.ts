import { Client, GatewayIntentBits, REST } from 'discord.js';
import * as dotenv from 'dotenv';

process.env.NODE_ENV = process.env.NODE_ENV || 'development';

dotenv.config();

export const config = {
  token: process.env.TOKEN!,
  applicationId: process.env.APPLICATION_ID!,
};

export const rest = new REST({ version: '10' }).setToken(config.token);
export const client = new Client({ intents: [GatewayIntentBits.Guilds] });
