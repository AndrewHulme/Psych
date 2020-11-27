import React from "react";
import logo from "./logo.svg";
import { Button, Typography, Container } from "@material-ui/core";
// import "./App.css";

function App() {
  return (
    <Container maxWidth="sm">
      <Typography variant="h3" gutterBottom>
        Psych?!
      </Typography>

      <Button color="primary" variant="outlined">
        Play
      </Button>
    </Container>
  );
}

export default App;
