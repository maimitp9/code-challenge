import VueRouter from "vue-router";
import ApiErrors from "../lib/ApiErrors";
import { Store } from "vuex";
import { RootState } from "../store/types";

const mixin = {
  methods: {
    handleApiErrors(
      errors: ApiErrors,
      context: { store: Store<RootState>; router: VueRouter; }
    ): void {
      switch (errors.status) {
        case 404: // Not found
          context.router.push({ name: "notFound" });
          break;
        default: {
          // system error
          console.log(errors);
          context.router.push({ name: "serverError" });
        }
      }
    },
  },
};

export default mixin;
