<template>
  <div class="mt-4">
    <div class="col-md-6 offset-md-3">
      <b-card header="New Feedback">
        <div></div>
        <b-alert v-if="errors.length > 0" show variant="danger" color="error">
          <ul v-for="err in errors" :key="err.message">
            <li>{{ err.message }}</li>
          </ul>
        </b-alert>
        <b-form @submit.prevent="submitForm">
          <b-form-group label="Feedback Title:">
            <b-form-input
              v-model="form.title"
              required
              placeholder="Enter title"
            ></b-form-input>
          </b-form-group>
          <b-form-group label="Status">
            <b-form-radio v-model="form.status" value="active"
              >Active</b-form-radio
            >
            <b-form-radio v-model="form.status" value="inactive"
              >Inactive</b-form-radio
            >
          </b-form-group>

          Questions:
          <div v-for="(input, k) in form.questions" :key="k" class="mt-1">
            <label class="sr-only">Question</label>
            <div class="row">
              <div class="col-md-8">
                <b-input
                  v-model="input.text"
                  required
                  class="mr-sm-1 mb-sm-0"
                  placeholder="Enter question"
                ></b-input>
              </div>
              <div class="col-md-1">
                <b-button
                  v-show="k == form.questions.length - 1"
                  variant="primary"
                  class="mr-sm-1 mb-sm-0"
                  @click="add()"
                  ><i class="fa fa-plus"></i
                ></b-button>
              </div>
              <div class="col-md-1">
                <b-button
                  v-show="k || (!k && form.questions.length > 1)"
                  variant="danger"
                  @click="remove(k)"
                  ><i class="far fa-trash-alt"></i
                ></b-button>
              </div>
            </div>
          </div>
          <div class="mt-3">
            <b-button type="submit" :disabled="submitting" variant="success"
              >Submit</b-button
            >
          </div>
        </b-form>
      </b-card>
    </div>
  </div>
</template>

<script>
import ApiErrorHandler from "../../mixins/ApiErrorHandler";

export default {
  mixins: [ApiErrorHandler],
  data() {
    return {
      form: {
        title: "",
        status: "active",
        questions: [{ text: "" }],
      },
      submitting: false,
      isFeedbackCreated: false,
      errors: [],
    };
  },
  methods: {
    async submitForm() {
      if (this.submitting) {
        return;
      }
      this.submitting = true;
      this.errors = [];
      try {
        await this.$store.dispatch("feedbacks/createFeedback", this.form);
        this.$router.push({
          name: "feedbackList",
        });
      } catch (errors) {
        if (errors.status === 400) {
          this.errors = errors.errors;
        } else {
          this.handleApiErrors(errors, {
            store: this.$store,
            router: this.$router,
          });
        }
      } finally {
        this.submitting = false;
      }
    },
    add() {
      this.form.questions.push({ text: "" });
    },
    remove(index) {
      this.form.questions.splice(index, 1);
    },
  },
};
</script>
