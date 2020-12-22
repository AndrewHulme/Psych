import React from "react";
// import { useSelector, useDispatch } from "react-redux";
// import { increment, decrement } from "./actions/index";
// import { IRootState } from "./store/index";

import ApolloClient from "apollo-boost";
import { ApolloProvider } from "react-apollo";

import "./styles.css";

import Header from "./components/header";
import Homepage from "./components/homepage";
import StartGame from "./components/startGame";
import JoinGame from "./components/joinGame";

import { BrowserRouter as Router, Switch, Route } from "react-router-dom";

const client = new ApolloClient({
  uri: "http://backend.lvh.me/graphql",
});

function App() {
  return (
    <ApolloProvider client={client}>
      <Router>
        <Header />

        <Switch>
          <Route path="/" exact component={Homepage} />
          <Route path="/start" component={StartGame} />
          <Route path="/join" component={JoinGame} />
        </Switch>
      </Router>
    </ApolloProvider>
  );
}

export default App;
