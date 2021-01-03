import React from "react";
import { Button, TextField, Container } from "@material-ui/core";

import { gql, useMutation } from "@apollo/client";

const CHANGE_USERNAME = gql`
  mutation updateUserName($name: String!) {
    updateUserName(name: $name) {
      user {
        id
        name
      }
      status
      errors
    }
  }
`;

function UserNameInput() {
  const [changeUsername, { data }] = useMutation(CHANGE_USERNAME);

  function handleClick() {
    console.log("Username Submission!");
    changeUsername({ variables: { name: "Andrew" } });

    // setTimeout(() => {
    //   console.log(data);
    // }, 3000);

    console.log(data);
  }

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
          label="WHAT'S YOUR NAME?"
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
          onClick={() => handleClick()}
        >
          SUBMIT!
        </Button>
      </Container>
    </div>
  );
}

export default UserNameInput;
