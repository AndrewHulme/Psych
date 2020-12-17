import React from "react";
import { Button, TextField, Container } from "@material-ui/core";

function StartGame() {
  return (
    <div className="homepage">
      <Container component="main" maxWidth="xs">
        <TextField
          id="outlined-basic"
          style={{
            maxWidth: "400px",
            maxHeight: "100px",
            minWidth: "400px",
            minHeight: "100px",
            fontSize: "35px",
          }}
          label="ROOM NAME (optional)"
          variant="outlined"
        />

        <TextField
          id="outlined-basic"
          style={{
            maxWidth: "400px",
            maxHeight: "100px",
            minWidth: "400px",
            minHeight: "100px",
            fontSize: "35px",
          }}
          label="PASSWORD (optional)"
          variant="outlined"
        />

        <Button
          style={{
            maxWidth: "400px",
            maxHeight: "100px",
            minWidth: "400px",
            minHeight: "100px",
            fontSize: "35px",
          }}
          color="primary"
          variant="outlined"
        >
          SUBMIT!
        </Button>
      </Container>
    </div>
  );
}

export default StartGame;
