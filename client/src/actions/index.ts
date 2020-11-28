import { IAction } from "./interfaces";

export const increment = (): IAction => {
  return {
    type: "INCREMENT",
  };
};

export const decrement: IAction = { type: "DECREMENT" };
