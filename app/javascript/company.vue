<template lang="pug">
.user-group(v-if='company.users.length > 0')
  header.user-group__header
    h2.group-company-name
      a.group-company-name__link(:href='company.users_url')
        span.group-company-name__icon
          img.group-company-name__icon-image(
            :title='company.name',
            :alt='company.name',
            :src='company.logo_url')
        span.group-company-name__name
          span.group-company-name__label
            | {{ company.name }}
          span.group-company-name__label-option
            | {{ company.description }}
  .a-user-icons
    .a-user-icons__items
      .a-user-icons__item(v-for='user in company.users', :key='user.id')
        a.a-user-icons__item-link(:href='user.url')
          span(:class='["a-user-role", `is-${user.primary_role}`]')
            img(
              :src='user.avatar_url',
              :title='user.icon_title',
              :data-login-name='user.login_name',
              :class='"a-user-icons__item-icon a-user-icon"')
</template>
<script>
export default {
  props: {
    company: { type: Object, required: true }
  }
}
</script>
