<template lang="pug">
li.user-icons__item
  a.user-icons__item-link(:href='`${footprint.user.url}`')
    span(:class='["a-user-role", primaryRoleClass]')
      img.a-user-icon.is-sm(
        :title='footprint.user.icon_title',
        :alt='footprint.user.icon_title',
        :src='footprint.user.avatar_url',
        :class='loginNameClass')
</template>
<script>
export default {
  props: {
    footprint: { type: Object, required: true }
  },
  computed: {
    loginNameClass() {
      return `is-${this.footprint.user.login_name}`
    },
    primaryRoleClass() {
      return `is-${this.footprint.user.primary_role}`
    }
  }
}
</script>
