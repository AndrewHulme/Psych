import React from "react";
import { Button, Grid, Container } from "@material-ui/core";
import { Link } from "react-router-dom";

function Homepage() {
  return (
    <div className="homepage">
      <Container component="main" maxWidth="xs">
        <Grid container spacing={2}>
          <Grid item>
            <Link to={"/join"}>
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
            </Link>
          </Grid>

          <Grid item>
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
          </Grid>
        </Grid>
      </Container>
    </div>
  );
}

export default Homepage;
