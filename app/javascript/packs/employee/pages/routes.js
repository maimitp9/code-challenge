import DashboardPage from "../pages/dashboard/Dashboard";
import FeedbackListPage from "../pages/feedbacks/List";
import GiveFeedbackPage from "../pages/feedbacks/GiveFeedback";

import ErrorNotFoundPage from "./error/NotFound";
import ErrorServerErrorPage from "./error/ServerError";

const routes = [
  {
    path: "/employee/dashboard",
    name: "dashboard",
    component: DashboardPage,
  },
  {
    path: "/employee/feedbacks",
    name: "feedbackList",
    component: FeedbackListPage,
  },
  {
    path: "/employee/feedbacks/:feedbackId/give_feedback",
    name: "giveFeedback",
    component: GiveFeedbackPage,
    props: (route) => {
      return {
        feedbackId: parseInt(route.params.feedbackId),
      };
    },
  },
  {
    path: "/employee/error/not_found",
    name: "notFound",
    component: ErrorNotFoundPage,
    meta: {
      title: "Page Not Found",
    },
  },
  {
    path: "/employee/error/server_error",
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
