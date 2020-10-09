<template>
  <div class="mt-4">
    <div class="row">
      <div class="col-12">
        <div class="text-right">
          <router-link :to="{ name: 'userNew' }">
            <button type="button" class="btn btn-primary">New User</button>
          </router-link>
        </div>
        <section v-if="users.length > 0" class="mt-2">
          <table class="table table-bordered">
            <thead>
              <tr>
                <th scope="col">Id</th>
                <th scope="col">Name</th>
                <th scope="col">Email</th>
                <th scope="col">Rolwe</th>
                <th scope="col">Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(user, index) in users" :key="user.id">
                <th scope="row">{{ user.id }}</th>
                <td>{{ user.name }}</td>
                <td>{{ user.email }}</td>
                <td>{{ user.role }}</td>
                <td>
                  <router-link
                    :to="{
                      name: 'userShow',
                      params: { userId: user.id },
                    }"
                  >
                    <button type="button" class="btn btn-primary">
                      <i class="far fa-eye"></i>
                    </button>
                  </router-link>
                  <router-link
                    :to="{
                      name: 'userEdit',
                      params: { userId: user.id },
                    }"
                  >
                    <button type="button" class="btn btn-success">
                      <i class="fas fa-edit"></i>
                    </button>
                  </router-link>
                  <button
                    type="button"
                    class="btn btn-danger"
                    @click="deleteUser(user.id, index)"
                  >
                    <i class="far fa-trash-alt"></i>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </section>
        <section v-else>
          <h3 class="text-center">Users are empty, please create</h3>
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
      users: [],
    };
  },
  created() {
    this.getUsers();
  },
  methods: {
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
    async deleteUser(userId, index) {
      try {
        await this.$store.dispatch("users/deleteUser", { userId: userId });
        this.users.splice(index, 1);
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
