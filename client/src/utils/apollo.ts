import { ApolloClient, InMemoryCache, DefaultOptions, createHttpLink } from "@apollo/client";
import { setContext } from '@apollo/client/link/context';

import { HOSTNAME } from 'utils/constants'
import { loadAuthToken } from 'utils/auth'

const apolloCache = new InMemoryCache();

const defaultOptions: DefaultOptions = {
  query: {
    fetchPolicy: 'network-only',
  },
};

const endpoint = `${HOSTNAME}/graphql`;
const httpLink = createHttpLink({ uri: endpoint });

const authLink = setContext((_, { headers }) => {
  // get the authentication token from local storage if it exists
  // const token = localStorage.getItem('token');
  const token = loadAuthToken();

  console.log("index:: token: ", token);
  // return the headers to the context so httpLink can read them
  return {
    headers: {
      ...headers,
      Authorization: token ? token : "",
      CustomAuthorization: token ? token : "",
    }
  }
});

export const apolloClient = new ApolloClient({
  // uri: endpoint,
  link: authLink.concat(httpLink),
  cache: apolloCache,
  credentials: "include",
  defaultOptions,
});
