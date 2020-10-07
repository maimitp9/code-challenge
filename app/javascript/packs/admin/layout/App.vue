<template>
  <div id="app">
    <header-nav v-if="!hideNavbar" />
    <div class="container">
      <router-view />
    </div>
  </div>
</template>

<script>
import HeaderNav from "../layout/HeaderNav";

export default {
  components: {
    HeaderNav,
  },
  data: function () {
    return {
      message: "Hello Vue!",
    };
  },
  computed: {
    hideNavbar() {
      return this.$route.matched.some((record) => record.meta.hideNavbar);
    },
  },
};
</script>
