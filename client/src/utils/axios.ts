import Axios, { AxiosError, AxiosRequestConfig } from 'axios';
// import { loadAuthToken } from 'modules/core/utils/api';
import { isArray } from 'util';
import { HOSTNAME } from 'utils/constants';

const makeUrl = (path: string): string => {
  const parts = [HOSTNAME];
  if (path) {
    parts.push(path.trim().replace(/(^\/+)|(\/+$)/g, ''));
  }
  return parts.join('/');
};

// const refreshAuthToken = () => {
//   const token = loadAuthToken();
//   const headers: any = {};
//   if (token) {
//     headers.Authorization = `bearer ${token}`;
//   }
//   Axios.defaults.headers.common = headers;
// };

export const axiosGet = (path: string, options: Partial<AxiosRequestConfig> = {}) => {
  const url = makeUrl(path);
  return (params: any) => {
    // refreshAuthToken();
    return Axios.get(url, { params, ...options });
  };
};

export const axiosPost = (path: string, options: Partial<AxiosRequestConfig> = {}) => {
  const url = makeUrl(path);
  return (body: any, reqOptions = {}) => {
    // refreshAuthToken();
    return Axios.post(url, body, { ...options, ...reqOptions });
  };
};
