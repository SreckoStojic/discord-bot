// Static
import { TourRole } from '../common/static/tour.enums';
import { Command } from './static/commands.enums';

// Prisma Enums
import { Region, TourType } from '@prisma/client';

// Utils
import { createCommandChoices } from '../utils';

export const commands = [
  // hello
  {
    name: Command.HELLO,
    description: 'Pings back hello user',
  },
  // roll
  {
    name: Command.ROLL,
    description: 'Pings back random number',
    options: [
      {
        name: 'from',
        description: 'Roll number from.',
        type: 4,
        required: true,
      },
      {
        name: 'to',
        description: 'Roll number to.',
        type: 4,
        required: true,
      },
    ],
  },
  // create_tour
  {
    name: Command.CREATE_TOUR,
    description: 'Create tournament with options.',
    options: [
      {
        name: 'name',
        description: 'Name of the tournament.',
        type: 3,
        required: true,
      },
      {
        name: 'type',
        description: 'Type of the tournament.',
        type: 3,
        required: true,
        choices: createCommandChoices(TourType),
      },
      {
        name: 'role',
        description: 'Type of the role for tournament.',
        type: 3,
        required: true,
        choices: createCommandChoices(TourRole),
      },
      {
        name: 'max',
        description: 'Set the limit of the maximum participants.',
        type: 4,
        required: true,
      },
    ],
  },
  // register
  {
    name: Command.REGISTER,
    description: 'Register user to database',
    options: [
      {
        name: 'email',
        description: 'Player email. (optional)',
        type: 3,
        required: false,
      },
      {
        name: 'region',
        description: 'Player region. (optional)',
        type: 3,
        required: false,
        choices: createCommandChoices(Region),
      },
    ],
  },
];
