import React from "react";
import { Button, Typography, Container } from "@material-ui/core";
import { Link } from "react-router-dom";

function Homepage() {
  return (
    <React.Fragment>
      <Typography variant="h3" gutterBottom>
        Psych?!
      </Typography>

      <Button color="primary" variant="outlined">
        JOIN A GAME
      </Button>

      <Link to={"/start"}>
        <Button color="primary" variant="outlined">
          START A GAME
        </Button>
      </Link>
    </React.Fragment>
  );
}

export default Homepage;
