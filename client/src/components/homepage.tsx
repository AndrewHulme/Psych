import React from "react";
import { Button, Typography, Container } from "@material-ui/core";
import { Link } from "react-router-dom";

function Homepage() {
  return (
    <React.Fragment>
      <Container component="main" maxWidth="xs">
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
          JOIN A GAME
        </Button>

        <Link to={"/start"}>
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
            START A GAME
          </Button>
        </Link>
      </Container>
    </React.Fragment>
  );
}

export default Homepage;
