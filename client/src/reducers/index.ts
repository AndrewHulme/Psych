import counterReducer from "./counter";
import loggedReducer from "./isLogged";
import userReducer from "./user";
import { combineReducers } from "redux";

const allReducers = combineReducers({
  counter: counterReducer,
  isLogged: loggedReducer,
  user: userReducer,
});

export default allReducers;
