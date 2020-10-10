import LogInPage from "../pages/Login";
import DashboardPage from "../pages/dashboard/Dashboard";
import UserListPage from "../pages/users/List";
import UserShowPage from "../pages/users/Show";
import UserEditPage from "../pages/users/Edit";
import UserNewPage from "../pages/users/New";

import FeedbackListPage from "../pages/feedbacks/List";
import FeedbackNewPage from "../pages/feedbacks/New";
import FeedbackAssignPage from "../pages/feedbacks/Show";
import UserFeedbacksPage from "../pages/feedbacks/UserFeedbacks";

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
    name: "usersList",
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
    path: "/admin/feedbacks",
    name: "feedbackList",
    component: FeedbackListPage,
  },
  {
    path: "/admin/feedbacks/new",
    name: "feedbackNew",
    component: FeedbackNewPage,
  },
  {
    path: "/admin/feedbacks/:feedbackId/assign",
    name: "feedbackAssign",
    component: FeedbackAssignPage,
    props: (route) => {
      return {
        feedbackId: parseInt(route.params.feedbackId),
      };
    },
  },
  {
    path: "/admin/feedbacks/:userId/user_feedbacks",
    name: "userFeedback",
    component: UserFeedbacksPage,
    props: (route) => {
      return {
        userId: parseInt(route.params.userId),
      };
    },
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
