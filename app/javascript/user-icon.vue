<template lang="pug">
a(:href='user.url', :class='`${blockClass}user-link`')
  span(:class='["a-user-role", roleClass]')
    img(
      :src='user.avatar_url',
      :alt='user.icon_title',
      :title='user.icon_title',
      :class='[`${blockClass}user-icon`, "a-user-icon"]')
</template>

<script>
export default {
  props: {
    user: { type: Object, required: true },
    blockClassSuffix: { type: String, required: true }
  },
  computed: {
    blockClass: function () {
      return `${this.blockClassSuffix}__`
    },
    roleClass: function () {
      return `is-${this.user.primary_role}`
    }
  }
}
</script>
