import React from "react";
// import { useSelector, useDispatch } from "react-redux";
// import { increment, decrement } from "./actions/index";
// import { IRootState } from "./store/index";

import "./styles.css";

import Header from "./components/header";
import Homepage from "./components/homepage";
import StartGame from "./components/startGame";

import { BrowserRouter as Router, Switch, Route } from "react-router-dom";

function App() {
  return (
    <Router>
      <Header />

      <Switch>
        <Route path="/" exact component={Homepage} />
        <Route path="/start" component={StartGame} />
      </Switch>
    </Router>
  );
}

export default App;
