import React, { useEffect } from "react";
import { Button, Grid, Container } from "@material-ui/core";
import { Link, Redirect } from "react-router-dom";

import { useDispatch } from "react-redux";
import { updateUser } from "../actions/userActions";

import { useQuery, gql } from "@apollo/client";

const GET_CURRENT_USER = gql`
  query GetCurrentUser {
    currentUser {
      id
      name
    }
  }
`;

function Homepage() {
  const { loading, error, data } = useQuery(GET_CURRENT_USER);

  const dispatch = useDispatch();

  useEffect(() => {
    if (data) {
      var userData = { id: data.currentUser.id, name: data.currentUser.name };

      dispatch(updateUser(userData));
    }
  }, [data, dispatch]);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error {error.toString()}</p>;

  console.log(data);
  console.log(data.currentUser.name);

  return (
    <div>
      {data.currentUser.name === "Player" ? (
        <Redirect to="/inputusername" />
      ) : (
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
      )}
    </div>
  );
}

export default Homepage;
