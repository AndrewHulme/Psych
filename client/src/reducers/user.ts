import { IAction } from "../actions/interfaces";
import { IUser } from "../interfaces/index";

const defaultUser: IUser = {
  id: 0,
  name: "Player",
};

const userReducer = (state: IUser = defaultUser, action: IAction) => {
  switch (action.type) {
    case "UPDATE":
      return action.payload;
    default:
      return state;
  }
};

export default userReducer;
