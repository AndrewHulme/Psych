import { IUser } from "../interfaces/index";

export interface IRootState {
  counter: number;
  isLogged: boolean;
  user: IUser;
}

export default IRootState;
