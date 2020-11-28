import { IAction } from "../actions/interfaces";

const loggedReducer = (state = false, action: IAction) => {
  switch (action.type) {
    case "SIGN_IN":
      return !state;
    default:
      return state;
  }
};

export default loggedReducer;
