<template>
  <div class="mt-4">
    <div class="col-md-6 offset-md-3">
      <b-card v-if="feedback" header="Feedback Questions">
        <section v-if="feedback.usersFeedbacks.length > 0">
          <span v-for="(uf, i) in feedback.usersFeedbacks" :key="i">
            <p>
              User:
              <span class="text-success"
                >{{ uf.user.name }}({{ uf.user.email }})</span
              >
            </p>
            <p>
              Reviewer:
              <span class="text-primary"
                >{{ uf.reviewer.name }}({{ uf.reviewer.email }})</span
              >
            </p>
          </span>
        </section>
        <section v-else>
          <ul>
            <li>Not assigned yet</li>
          </ul>
        </section>
        <div class="text-right">
          <!-- <router-link
            :to="{
              name: 'userEdit',
              params: { userId: user.id },
            }"
          >
            <button type="button" class="btn btn-success">
              Edit <i class="fas fa-edit"></i>
            </button>
          </router-link> -->
        </div>
        <b-alert v-if="errors.length > 0" show variant="danger" color="error">
          <ul v-for="err in errors" :key="err.message">
            <li>{{ err.message }}</li>
          </ul>
        </b-alert>
        <table class="table mt-2">
          <tbody>
            <tr>
              <th scope="col">Title:</th>
              <td scope="row">{{ feedback.title }}</td>
            </tr>
            <tr>
              <th scope="col">Status:</th>
              <td scope="row">{{ feedback.status }}</td>
            </tr>
          </tbody>
        </table>
        <hr />
        <b-form @submit.prevent="submitForm">
          <span class="mt-4">
            <strong>Feedback Questions:</strong>
          </span>
          <hr />
          <span class="text-danger"
            >* Enter at least 10 characters as feedback</span
          >
          <b-alert v-if="errors.length > 0" show variant="danger" color="error">
            <ul v-for="err in errors" :key="err.message">
              <li>{{ err.message }}</li>
            </ul>
          </b-alert>
          <section v-if="form.feedbacksQuestions.length > 0">
            <p v-for="(fq, i) in form.feedbacksQuestions" :key="i">
              {{ ++i }}. {{ fq.question.text }}
              <b-container fluid>
                <b-col sm="12">
                  <b-form-textarea
                    v-model="fq.question.answer"
                    :state="
                      fq.question.answer && fq.question.answer.length >= 10
                    "
                    placeholder="Write your feedback"
                    required
                  ></b-form-textarea>
                </b-col>
              </b-container>
            </p>
          </section>
          <section v-else>
            <p>Questions not created</p>
          </section>
          <b-button :disabled="submitting" variant="success" @click="submitForm"
            >Submit
          </b-button>
        </b-form>
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
      form: {
        feedbackId: this.feedbackId,
        userId: null,
        reviewerId: null,
        usersFeedbacksId: null,
        feedbacksQuestions: [],
      },
      submitting: false,
      errors: [],
    };
  },
  created() {
    this.getFeedback();
  },
  methods: {
    async getFeedback() {
      try {
        this.feedback = await this.$store.dispatch("feedbacks/getFeedback", {
          feedbackId: this.feedbackId,
        });

        this.form.userId = this.feedback.usersFeedbacks[0].userId;
        this.form.reviewerId = this.feedback.usersFeedbacks[0].reviewerId;
        this.form.usersFeedbacksId = this.feedback.usersFeedbacks[0].id;
        this.form.feedbacksQuestions = this.feedback.feedbacksQuestions;
      } catch (errors) {
        this.handleApiErrors(errors, {
          store: this.$store,
          router: this.$router,
        });
      }
    },
    async submitForm() {
      if (document.getElementsByClassName("is-invalid").length > 0) {
        return;
      }
      if (this.submitting) {
        return;
      }

      this.submitting = true;
      this.errors = [];
      try {
        await this.$store.dispatch("feedbacks/giveFeedback", this.form);
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
