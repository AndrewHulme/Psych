import React, { useState } from "react";
import { useHistory } from "react-router-dom";

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

  const [name, updateName] = useState("");

  const history = useHistory();

  async function handleClick() {
    console.log("Username Submission!");
    await changeUsername({ variables: { name: name } });

    console.log(data);

    history.push("/");
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
          value={name}
          onChange={(e) => updateName(e.target.value)}
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
