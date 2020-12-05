import React from "react";
import logo from "./logo.svg";
import { Button, Typography, Container } from "@material-ui/core";
import { useSelector, useDispatch } from "react-redux";
import { increment, decrement } from "./actions/index";
import { IRootState } from "./store/index";
// import "./App.css";

function App() {
  // const counter = useSelector((state: IRootState) => state.counter);
  // const dispatch = useDispatch();

  return (
    <Container maxWidth="sm">
      <Typography variant="h3" gutterBottom>
        Psych?!
      </Typography>

      {/* <button onClick={() => dispatch(increment())}>+</button> */}
      {/* <button onClick={() => dispatch(decrement)}>-</button> */}

      <Button color="primary" variant="outlined">
        JOIN A GAME
      </Button>

      <Button color="primary" variant="outlined">
        START A GAME
      </Button>
    </Container>
  );
}

export default App;
