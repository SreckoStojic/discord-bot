// Contracts
import { CommandChoice } from '../commands/contracts';

export const createCommandChoices = (
  commandType: any
): Array<CommandChoice<unknown>> => {
  return Object.values(commandType).map((type) => {
    return {
      name: type as string,
      value: type,
    };
  });
};
