<template lang="pug">
.col-xxl-3.col-xl-4.col-lg-4.col-md-6.col-xs-12
  .users-item
    .users-item__inner.a-card
      .users-item__inactive-message.is-only-mentor(
        v-if='currentUser.mentor && user.student_or_trainee && !user.active')
        | 1ヶ月以上ログインがありません
      header.users-item__header
        .users-item__header-inner
          .users-item__header-start
            .users-item__icon
              a(:href='user.url')
                span(:class='["a-user-role", roleClass]')
                  img.users-item__user-icon-image.a-user-icon(
                    :title='user.icon_title',
                    :alt='user.icon_title',
                    :src='user.avatar_url')
          .users-item__header-end
            .card-list-item__rows
              .card-list-item__row
                .card-list-item-title
                  a.card-list-item-title__title.is-lg.a-text-link(
                    :href='user.url')
                    | {{ loginName }}
                  a(
                    v-if='user.company && user.company.logo_url',
                    :href='user.company.url')
                    img.user-item__company-logo(:src='user.company.logo_url')
              .card-list-item__row
                .card-list-item-meta
                  .card-list-item-meta__items
                    .card-list-item-meta__item
                      .a-meta
                        | {{ user.name }}
                    .card-list-item-meta__item
                      a.a-meta(v-if='user.times_url', :href='user.times_url')
                        .a-meta__icon
                          i.fa-brands.fa-discord
                        | {{ user.discord_account }}
                      .a-meta(v-else)
                        .a-meta__icon
                          i.fa-brands.fa-discord
                        | {{ user.discord_account }}

        user-sns(:user='user')
      .users-item__body
        .users-item__description.a-short-text
          p(v-for='paragraph in userDescParagraphs', :key='paragraph.id')
            | {{ paragraph.text }}
        .users-item__tags
          user-tags(:user='user')
      user-practice-progress(:user='user')
      footer.card-footer
        .card-main-actions
          ul.card-main-actions__items
            li.card-main-actions__item(
              v-if='currentUser.id != user.id && currentUser.adviser && user.company && currentUser.company_id == user.company.id')
              .a-button.is-disabled.is-sm.is-block
                i.fa-solid.fa-check
                span
                  | 自社研修生
            li.card-main-actions__item(v-else-if='currentUser.id != user.id')
              following(
                :isFollowing='user.isFollowing',
                :userId='user.id',
                :isWatching='user.isWatching')
            li.card-main-actions__item.is-only-admin(
              v-if='currentUser.admin && user.talkUrl')
              a.a-button.is-secondary.is-sm.is-block(:href='user.talkUrl')
                | 相談部屋
</template>
<script>
import Following from '../following.vue'
import UserSns from './user-sns.vue'
import UserTags from './user-tags.vue'
import UserPracticeProgress from './user-practice-progress.vue'

export default {
  name: 'User',
  components: {
    following: Following,
    'user-sns': UserSns,
    'user-tags': UserTags,
    'user-practice-progress': UserPracticeProgress
  },
  props: {
    user: { type: Object, required: true },
    currentUser: { type: Object, required: true }
  },
  computed: {
    loginName() {
      return this.user.login_name
    },
    userDescParagraphs() {
      let description = this.user.description
      description =
        description.length <= 200
          ? description
          : description.substring(0, 200) + '...'
      const paragraphs = description.split(/\n|\r\n/).map((text, i) => {
        return {
          id: i,
          text: text
        }
      })
      return paragraphs
    },
    roleClass() {
      return `is-${this.user.primary_role}`
    }
  }
}
</script>
