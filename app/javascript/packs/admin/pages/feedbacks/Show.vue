<template>
  <div class="mt-4">
    <div class="col-md-6 offset-md-3">
      <b-card v-if="feedback" header="Feedback Questions">
        <b-alert v-if="errors.length > 0" show variant="danger" color="error">
          <ul v-for="err in errors" :key="err.message">
            <li>{{ err.message }}</li>
          </ul>
        </b-alert>
        <table class="table mt-2">
          <tbody>
            <tr>
              <th scope="col">Id:</th>
              <td scope="row">{{ feedback.id }}</td>
            </tr>
            <tr>
              <th scope="col">Title:</th>
              <td scope="row">{{ feedback.title }}</td>
            </tr>
            <tr>
              <th scope="col">Status:</th>
              <td scope="row">{{ feedback.status }}</td>
            </tr>
            <tr>
              <th scope="col">Questions:</th>
              <td scope="row">
                <section v-if="feedback.questions.length > 0">
                  <p v-for="(q, i) in feedback.questions" :key="i">
                    {{ ++i }}. {{ q.text }}
                  </p>
                </section>
                <section v-else>
                  <p>Questions not created</p>
                </section>
              </td>
            </tr>
            <tr>
              <th scope="col">User | Reviewer</th>
              <td scope="row">
                <section v-if="feedback.usersFeedbacks.length > 0">
                  <ul v-for="(uf, i) in feedback.usersFeedbacks" :key="i">
                    <li>
                      {{ uf.user.name }}({{ uf.user.email }}) |
                      {{ uf.reviewer.name }}({{ uf.reviewer.email }})
                    </li>
                  </ul>
                </section>
                <section v-else>
                  <ul>
                    <li>Not assigned yet</li>
                  </ul>
                </section>
              </td>
            </tr>
            <tr>
              <th scope="col">User:</th>
              <td scope="row">
                <b-form-select v-model="form.user_id" class="mb-3">
                  <b-form-select-option :value="null"
                    >Please select user</b-form-select-option
                  >
                  <b-form-select-option
                    v-for="user in users"
                    :key="user.id"
                    :value="user.id"
                    >{{ user.name }}({{ user.email }})</b-form-select-option
                  >
                </b-form-select>
              </td>
            </tr>
            <tr>
              <th scope="col">Reviewer:</th>
              <td scope="row">
                <b-form-select v-model="form.reviewer_id" class="mb-3">
                  <b-form-select-option :value="null"
                    >Please select reviewer</b-form-select-option
                  >
                  <b-form-select-option
                    v-for="reviewer in users"
                    :key="reviewer.id"
                    :value="reviewer.id"
                    >{{ reviewer.name }}({{
                      reviewer.email
                    }})</b-form-select-option
                  >
                </b-form-select>
              </td>
            </tr>
          </tbody>
          <b-button :disabled="submitting" variant="success" @click="submitForm"
            >Submit</b-button
          >
        </table>
      </b-card>
    </div>
  </div>
</template>

<script>
import ApiErrorHandler from "../../mixins/ApiErrorHandler";

export default {
  mixins: [ApiErrorHandler],
  props: {
    feedbackId: {
      type: Number,
      required: true,
    },
  },
  data() {
    return {
      feedback: undefined,
      users: [],
      form: {
        feedback_id: this.feedbackId,
        user_id: null,
        reviewer_id: null,
      },
      submitting: false,
      errors: [],
    };
  },
  created() {
    this.getFeedback();
    this.getUsers();
  },
  methods: {
    async getFeedback() {
      try {
        this.feedback = await this.$store.dispatch("feedbacks/getFeedback", {
          feedbackId: this.feedbackId,
        });
      } catch (errors) {
        this.handleApiErrors(errors, {
          store: this.$store,
          router: this.$router,
        });
      }
    },
    async getUsers() {
      try {
        this.users = await this.$store.dispatch("users/getUsers");
      } catch (errors) {
        this.handleApiErrors(errors, {
          store: this.$store,
          router: this.$router,
        });
      }
    },
    async submitForm() {
      if (this.submitting) {
        return;
      }

      this.submitting = true;
      this.errors = [];
      try {
        await this.$store.dispatch("feedbacks/assignFeedback", this.form);
        this.$router.push({ name: "feedbackList" });
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
  },
};
</script>
