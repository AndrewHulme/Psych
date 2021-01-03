import { IAction } from "./interfaces";
import { IUser } from "../interfaces/index";

export const updateUser = (user: IUser): IAction => {
  return {
    type: "UPDATE",
    payload: user,
  };
};
