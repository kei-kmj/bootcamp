<template lang="pug">
.page-content(v-if='!loaded')
  loadingListPlaceholder
.o-empty-message(v-else-if='products.length === 0')
  .o-empty-message__icon
    i.fa-regular.fa-smile
  p.o-empty-message__text
    | {{ title }}はありません
.o-empty-message(v-else-if='isDashboard && isNotProduct5daysElapsed')
  .o-empty-message__icon
    i.fa-regular.fa-smile
  p.o-empty-message__text
    | 5日経過した提出物はありません
div(:class='contentClassName')(v-else)
  nav.pagination(v-if='totalPages > 1')
    pager(v-bind='pagerProps')
  div(:class='columnsClassName')
    div(:class='columnClassName')
      .a-card(v-if='productsGroupedByElapsedDays === null')
        .card-list
          .card-list__items
            product(
              v-for='product in products',
              :key='product.id',
              :product='product',
              :currentUserId='currentUserId',
              :isMentor='isMentor')
      template(v-for='product_n_days_passed in productsGroupedByElapsedDays') <!-- product_n_days_passedはn日経過の提出物 -->
        .a-card(:class='cardClassName')(
          v-if='!isDashboard || (isDashboard && product_n_days_passed.elapsed_days >= 5)')
          //- prettier-ignore: need space between v-if and id
          header.card-header.a-elapsed-days(
            v-if='product_n_days_passed.elapsed_days === 0', id='0days-elapsed'
          )
            h2.card-header__title
              | 今日提出
              span.card-header__count(v-if='selectedTab === "unassigned"')
                | （{{ countProductsGroupedBy(product_n_days_passed) }}）
          //- prettier-ignore: need space between v-else-if and id
          header.card-header.a-elapsed-days.is-reply-warning(
            v-else-if='product_n_days_passed.elapsed_days === 5', id='5days-elapsed'
          )
            h2.card-header__title
              | {{ product_n_days_passed.elapsed_days }}日経過
              span.card-header__count(v-if='selectedTab === "unassigned"')
                | （{{ countProductsGroupedBy(product_n_days_passed) }}）
          //- prettier-ignore: need space between v-else-if and id
          header.card-header.a-elapsed-days.is-reply-alert(
            v-else-if='product_n_days_passed.elapsed_days === 6', id='6days-elapsed'
          )
            h2.card-header__title
              | {{ product_n_days_passed.elapsed_days }}日経過
              span.card-header__count(v-if='selectedTab === "unassigned"')
                | （{{ countProductsGroupedBy(product_n_days_passed) }}）
          //- prettier-ignore: need space between v-else-if and id
          header.card-header.a-elapsed-days.is-reply-deadline(
            v-else-if='product_n_days_passed.elapsed_days === 7', id='7days-elapsed'
          )
            h2.card-header__title
              | {{ product_n_days_passed.elapsed_days }}日以上経過
              span.card-header__count(v-if='selectedTab === "unassigned"')
                | （{{ countProductsGroupedBy(product_n_days_passed) }}）
          header.card-header.a-elapsed-days(
            v-else,
            :id='elapsedDaysId(product_n_days_passed.elapsed_days)')
            h2.card-header__title
              | {{ product_n_days_passed.elapsed_days }}日経過
              span.card-header__count(v-if='selectedTab === "unassigned"')
                | （{{ countProductsGroupedBy(product_n_days_passed) }}）
          .card-list
            .card-list__items
              product(
                v-for='product in product_n_days_passed.products',
                :key='product.id',
                :product='product',
                :currentUserId='currentUserId',
                :isMentor='isMentor')
      unconfirmed-links-open-button(
        v-if='isMentor && selectedTab != "all" && !isDashboard',
        :label='`${unconfirmedLinksName}の提出物を一括で開く`')
    elapsedDays(
      v-if='!isDashboard && selectedTab === "unassigned"',
      :productsGroupedByElapsedDays='productsGroupedByElapsedDays',
      :countProductsGroupedBy='countProductsGroupedBy')
  nav.pagination(v-if='totalPages > 1')
    pager(v-bind='pagerProps')
</template>

<script>
import Product from 'product.vue'
import UnconfirmedLinksOpenButton from 'unconfirmed_links_open_button.vue'
import LoadingListPlaceholder from 'loading-list-placeholder.vue'
import Pager from 'pager.vue'
import ElapsedDays from 'elapsed_days.vue'

export default {
  components: {
    product: Product,
    'unconfirmed-links-open-button': UnconfirmedLinksOpenButton,
    loadingListPlaceholder: LoadingListPlaceholder,
    pager: Pager,
    elapsedDays: ElapsedDays
  },
  props: {
    title: { type: String, required: true },
    selectedTab: { type: String, required: true },
    isMentor: { type: Boolean, required: true },
    currentUserId: { type: String, required: true },
    checkerId: { type: String, required: false, default: null }
  },
  data() {
    return {
      products: [],
      totalPages: 0,
      currentPage: Number(this.getPageValueFromParameter()) || 1,
      loaded: false,
      productsGroupedByElapsedDays: null,
      params: this.getParams()
    }
  },
  computed: {
    url() {
      return (
        '/api/products' +
        (this.selectedTab === 'all'
          ? ''
          : '/' + this.selectedTab.replace('-', '_')) +
        `?page=${this.currentPage}` +
        (this.checkerId ? `&checker_id=${this.checkerId}` : '') +
        (this.params.target ? `&target=${this.params.target}` : '')
      )
    },
    unconfirmedLinksName() {
      return {
        unchecked: '未完了',
        'self-assigned': '自分の担当',
        unassigned: '未アサイン'
      }[this.selectedTab]
    },
    pagerProps() {
      return {
        initialPageNumber: this.currentPage,
        pageCount: this.totalPages,
        pageRange: 5,
        clickHandle: this.paginateClickCallback
      }
    },
    contentClassName() {
      return this.isDashboard ? 'block' : 'page-content is-products'
    },
    columnsClassName() {
      return this.isDashboard ? 'block' : 'page-body__columns'
    },
    columnClassName() {
      return this.isDashboard ? 'block' : 'page-body__column is-main'
    },
    cardClassName() {
      return this.isDashboard ? 'h-auto' : ''
    },
    isDashboard() {
      return location.pathname === '/'
    },
    isNotProduct5daysElapsed() {
      const elapsedDays = []
      this.productsGroupedByElapsedDays.forEach((h) => {
        elapsedDays.push(h.elapsed_days)
      })
      return elapsedDays.every((day) => day < 5)
    }
  },
  created() {
    window.onpopstate = () => {
      this.currentPage = Number(this.getPageValueFromParameter()) || 1
      this.getProductsPerPage()
    }
    this.getProductsPerPage()
  },
  methods: {
    token() {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    getProductsPerPage() {
      fetch(this.url, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': this.token()
        },
        credentials: 'same-origin',
        redirect: 'manual'
      })
        .then((response) => {
          return response.json()
        })
        .then((json) => {
          if (
            location.pathname === '/products/unassigned' ||
            location.pathname === '/products/unchecked' ||
            location.pathname === '/'
          ) {
            this.productsGroupedByElapsedDays =
              json.products_grouped_by_elapsed_days
          }
          this.totalPages = json.total_pages
          this.products = []
          json.products.forEach((product) => {
            this.products.push(product)
          })
          this.loaded = true
        })
        .then(() => {
          const hash = location.hash.slice(1)
          const element = document.getElementById(hash)
          if (element) {
            element.scrollIntoView()
          }
        })
        .catch((error) => {
          console.warn(error)
        })
    },
    getPageValueFromParameter() {
      const url = location.href
      const results = url.match(/\?page=(\d+)/)
      if (!results) return null
      return results[1]
    },
    paginateClickCallback(pageNumber) {
      this.currentPage = pageNumber
      this.getProductsPerPage()
      history.pushState(null, null, this.newUrl(pageNumber))
      window.scrollTo(0, 0)
    },
    newUrl(pageNumber) {
      const params = new URL(location.origin).searchParams
      if (pageNumber !== 1) params.set('page', pageNumber)
      if (this.params.target) params.set('target', this.params.target)
      if (this.params.checker_id)
        params.set('checker_id', this.params.checker_id)
      if (
        params.get('page') ||
        params.get('target') ||
        params.get('checker_id')
      )
        return `${location.pathname}?${params}`
      return location.pathname
    },
    getParams() {
      const params = {}
      location.search
        .slice(1)
        .split('&')
        .forEach((query) => {
          const queryArr = query.split('=')
          params[queryArr[0]] = queryArr[1]
        })
      return params
    },
    countProductsGroupedBy({ elapsed_days: elapsedDays }) {
      const element = this.productsGroupedByElapsedDays.find(
        (el) => el.elapsed_days === elapsedDays
      )
      return element === undefined ? 0 : element.products.length
    },
    elapsedDaysId(elapsedDays) {
      return `${elapsedDays}days-elapsed`
    }
  }
}
</script>
