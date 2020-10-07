import Axios from "axios";
import * as Qs from "qs";
import { camelizeKeys, decamelizeKeys } from "humps";

const axios = Axios.create({
  timeout: 30000,
  baseURL: "/employee/api",
});

// When URL parameters(QueryString), Convert camelCase -> snake_case
axios.defaults.paramsSerializer = (params: any): string => {
  return Qs.stringify(decamelizeKeys(params), { arrayFormat: "brackets" });
};

// When calling API from ApiClient, Covert camelCase -> snake_case
if (axios.defaults.transformRequest instanceof Array) {
  axios.defaults.transformRequest.unshift((data: any): any => {
    switch (typeof data) {
      case "object":
        return decamelizeKeys(data);
      default:
        return data;
    }
  });
}

// API response, Convert snake_case -> camelCase
if (axios.defaults.transformResponse instanceof Array) {
  axios.defaults.transformResponse.push((data: any): any => {
    switch (typeof data) {
      case "object":
        return camelizeKeys(data);
      default:
        return data;
    }
  });
}

export default axios;
