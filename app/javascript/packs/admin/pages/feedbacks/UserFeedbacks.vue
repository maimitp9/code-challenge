<template>
  <div class="mt-4">
    <div class="row">
      <div class="col-12">
        <section v-if="userFeedbacks.length > 0" class="mt-2">
          <div class="col-md-6 offset-md-3">
            <b-card
              v-for="(feedback, i) in userFeedbacks"
              :key="i"
              :header="feedback.title"
              class="mt-3"
            >
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
                    <th scope="col">User:</th>
                    <td scope="row">
                      {{ feedback.usersFeedbacks[0].user.name }}({{
                        feedback.usersFeedbacks[0].user.email
                      }})
                    </td>
                  </tr>
                  <tr>
                    <th scope="col">Feedbacks:</th>
                    <td scope="row">
                      <section v-if="feedback.feedbacksQuestions.length > 0">
                        <div
                          v-for="(fq, j) in feedback.feedbacksQuestions"
                          :key="j"
                        >
                          {{ ++j }}. {{ fq.question.text }}
                          <ul
                            v-for="(fq_answer,
                            k) in fq.feedbacksQuestionsAnswers"
                            :key="k"
                          >
                            <li>
                              {{ fq_answer.answer }} =>
                              <strong
                                >{{ fq_answer.reviewer.name }} ({{
                                  fq_answer.reviewer.email
                                }})
                              </strong>
                            </li>
                          </ul>
                        </div>
                      </section>
                      <section v-else>
                        <p>Questions not created</p>
                      </section>
                    </td>
                  </tr>
                </tbody>
              </table>
            </b-card>
          </div>
        </section>
        <section v-else>
          <h3 class="text-center">Feedbacks are empty, please create</h3>
        </section>
      </div>
    </div>
  </div>
</template>

<script>
import ApiErrorHandler from "../../mixins/ApiErrorHandler";

export default {
  mixins: [ApiErrorHandler],
  props: {
    userId: {
      type: Number,
      required: true,
    },
  },
  data() {
    return {
      userFeedbacks: [],
    };
  },
  created() {
    this.getUserFeedbacks();
  },
  methods: {
    async getUserFeedbacks() {
      try {
        this.userFeedbacks = await this.$store.dispatch(
          "feedbacks/getUserFeedbacks",
          { userId: this.userId }
        );
      } catch (errors) {
        this.handleApiErrors(errors, {
          store: this.$store,
          router: this.$router,
        });
      }
    },
  },
};
</script>
