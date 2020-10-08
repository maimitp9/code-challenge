import LogInPage from "../pages/Login";
import DashboardPage from "../pages/dashboard/Dashboard";
import UserListPage from "../pages/users/List";
import UserShowPage from "../pages/users/Show";
import UserEditPage from "../pages/users/Edit";
import UserNewPage from "../pages/users/New";
import FeedbackNewPage from "../pages/feedbacks/New";
import AssignFeedbackPage from "../pages/feedbacks/AssignFeedback";

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
    path: "/admin/users",
    name: "users",
    component: UserListPage,
  },
  {
    path: "/admin/users/:userId/show",
    name: "userShow",
    component: UserShowPage,
    props: (route) => {
      return {
        userId: parseInt(route.params.userId),
      };
    },
  },
  {
    path: "/admin/users/new",
    name: "userNew",
    component: UserNewPage,
  },
  {
    path: "/admin/users/:userId/edit",
    name: "userEdit",
    component: UserEditPage,
    props: (route) => {
      return {
        userId: parseInt(route.params.userId),
      };
    },
  },
  {
    path: "/admin/feedbacks/new",
    name: "feedbackNew",
    component: FeedbackNewPage,
  },
  {
    path: "/admin/feedbacks/assign_feedback",
    name: "assignFeedback",
    component: AssignFeedbackPage,
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
