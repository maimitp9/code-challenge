import DashboardPage from "../pages/dashboard/Dashboard";

import ErrorNotFoundPage from './error/NotFound';
import ErrorServerErrorPage from './error/ServerError';

const routes = [
  {
    path: '/employee/dashboard',
    name: 'dashboard',
    component: DashboardPage
  },
  {
    path: '/employee/error/not_found',
    name: 'notFound',
    component: ErrorNotFoundPage,
    meta: {
      title: 'Page Not Found'
    }
  },
  {
    path: '/employee/error/server_error',
    name: 'serverError',
    component: ErrorServerErrorPage,
    meta: {
      title: 'Server Error'
    }
  },
  // no route match
  {
    path: '*',
    component: ErrorNotFoundPage,
    meta: {
      title: 'Page Not Found'
    }
  }
];

export default routes;
