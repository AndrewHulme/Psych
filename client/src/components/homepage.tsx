import React from "react";
import { Button, Grid, Container } from "@material-ui/core";
import { Link } from "react-router-dom";

import UserNameInput from "./userNameInput";

// import { gql } from "apollo-boost";
// import { Query } from "react-apollo";

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

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error {error.toString()}</p>;

  console.log(data);
  console.log(data.currentUser.name);

  return (
    // <Query query={GET_CURRENT_USER}>
    // {(result: any) => {
    // const { data, loading, error } = result;

    // if (loading) return <p>Loading...</p>;
    // if (error) return <p>Error {error.toString()}</p>;

    <div>
      {data.currentUser.name === "Player" ? (
        <UserNameInput />
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
    // );
    // }}
    // </Query>
  );
}

export default Homepage;
