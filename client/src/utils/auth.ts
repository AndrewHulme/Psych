// import Cookies from 'js-cookie'

// export const loadAuthToken = () => {
//   return Cookies.get('visitor_key');
// };

const AUTH_TOKEN_STORAGE_KEY = 'visitor_key';

export const loadAuthToken = () => {
  return localStorage.getItem(AUTH_TOKEN_STORAGE_KEY);
};

export const storeAuthToken = (token: string | null) => {
  if (token) {
    localStorage.setItem(AUTH_TOKEN_STORAGE_KEY, token);
  } else {
    localStorage.removeItem(AUTH_TOKEN_STORAGE_KEY);
  }
};
