import LogInPage from "../pages/Login";
import DashboardPage from "../pages/dashboard/Dashboard";

import ErrorNotFoundPage from "./error/NotFound";
import ErrorServerErrorPage from "./error/ServerError";

const routes = [
  {
    path: "/",
    name: "login",
    component: LogInPage,
    meta: {
      title: "Login",
      hideNavbar: true,
    },
  },
  {
    path: "/admin/dashboard",
    name: "dashboard",
    component: DashboardPage,
  },
  {
    path: "/error/not_found",
    name: "notFound",
    component: ErrorNotFoundPage,
    meta: {
      title: "Page Not Found",
    },
  },
  {
    path: "/error/server_error",
    name: "serverError",
    component: ErrorServerErrorPage,
    meta: {
      title: "Server Error",
    },
  },
  // no route match
  {
    path: "*",
    component: ErrorNotFoundPage,
    meta: {
      title: "Page Not Found",
    },
  },
];

export default routes;
