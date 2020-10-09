<template>
  <div class="mt-4">
    <div class="row">
      <div class="col-12">
        <section v-if="feedbacks.length > 0" class="mt-2">
          <table class="table table-bordered">
            <thead>
              <tr>
                <th scope="col">Sr. No</th>
                <th scope="col">Title</th>
                <th scope="col">Status</th>
                <th scope="col">Questions</th>
                <th scope="col">User | Reviewer</th>
                <th scope="col">Action</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(feedback, i) in feedbacks" :key="feedback.id">
                <th scope="row">{{ ++i }}</th>
                <td>{{ feedback.title }}</td>
                <td>{{ feedback.status }}</td>
                <td>
                  <section v-if="feedback.questions.length > 0">
                    <p v-for="(q, j) in feedback.questions" :key="j">
                      {{ ++j }}. {{ q.text }}
                    </p>
                  </section>
                  <section v-else>
                    <p>Questions not created</p>
                  </section>
                </td>
                <td>
                  <section v-if="feedback.usersFeedbacks.length > 0">
                    <ul v-for="(uf, k) in feedback.usersFeedbacks" :key="k">
                      <li>
                        {{ uf.user.name }}({{ uf.user.email }}) |
                        <span class="text-primary">
                          {{ uf.reviewer.name }}({{ uf.reviewer.email }})
                        </span>
                      </li>
                    </ul>
                  </section>
                  <section v-else>
                    <ul>
                      <li>Not assigned yet</li>
                    </ul>
                  </section>
                </td>
                <td>
                  <section
                    v-if="feedback.usersFeedbacks[0].status === 'completed'"
                  >
                    {{ feedback.usersFeedbacks[0].status }}
                  </section>
                  <section v-else>
                    <router-link
                      :to="{
                        name: 'giveFeedback',
                        params: { feedbackId: feedback.id },
                      }"
                    >
                      <button type="button" class="btn btn-info">
                        Give Feedback
                      </button>
                    </router-link>
                  </section>
                </td>
              </tr>
            </tbody>
          </table>
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
  data() {
    return {
      feedbacks: [],
    };
  },
  created() {
    this.getFeedbacks();
  },
  methods: {
    async getFeedbacks() {
      try {
        this.feedbacks = await this.$store.dispatch("feedbacks/getFeedbacks");
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
