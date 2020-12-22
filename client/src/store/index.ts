import { IUser } from "../interfaces/index";

export interface IRootState {
  counter: number;
  isLogged: boolean;
  currentUser: IUser;
}

export default IRootState;
