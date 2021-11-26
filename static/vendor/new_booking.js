$(function () {
    new ProductTableApp({
      $el: $('#product-table-app'),
      url: 'https://gist.githubusercontent.com/yha-1228/dafe947f4437e83deb91136203cb1f2b/raw/2b8de5fb6126a51d750bfd38ef38464fdb44f8cf/products.json',
    })
  })
  
  /**
   * @param {jQuery object} options.$el
   * @param {String} options.url
   */
  class ProductTableApp {
    constructor(options) {
      this.initState()
      this.defineElements(options.$el, this.state.products)
      this.render(this.state.products)
      this.fetchJson(options.url).then(
        (res) => {
          this.state.isLoaded = true
          this.state.products = res
          this.defineElements(options.$el, this.state.products)
          this.render(this.state.products)
          this.bindEvents()
        },
        (jqXHR) => {
          this.state.err = jqXHR
          console.log(`ERR! ${this.state.err.responseText}`)
        }
      )
    }
  
    initState() {
      this.state = { isLoaded: false, products: [], err: null }
    }
  
    /**
     * @param {String} url
     * @returns {Array}
     */
    fetchJson(url) {
      return $.ajax({
        url: url,
        dataType: 'json',
      })
    }
  
    /**
     *
     * @param {jQuery object} $el
     * @param {Array} products
     */
    defineElements($el, products) {
      const brands = [...new Set(products.map((product) => product.brand))]
      const categories = [...new Set(products.map((product) => product.category))]
  
      this.$el = $el
      this.$tbody = this.$el.find('tbody')
      this.$noResults = this.$el.find('#no-results')
      this.$handleTable = this.$el.find('.js-handle-table')
      this.$sortBy = this.$el.find('#sort-by')
      this.$filter = this.$el.find('.js-filter')
      this.$filterBrand = this.$el
        .find('#filter-brand')
        .append(
          brands.map((brand) => `<option value="${brand}">${brand}</option>`)
        )
      this.$filterCategory = this.$el
        .find('#filter-category')
        .append(
          categories.map(
            (category) => `<option value="${category}">${category}</option>`
          )
        )
      this.$hidingOutOfStock = this.$el.find('[value="hiding-out-of-stock"]')
    }
  
    bindEvents() {
      this.handleChange = this.handleChange.bind(this)
      this.$handleTable.on('change', this.handleChange)
    }
  
    handleChange() {
      const sorted = this.sort(this.state.products)
      const filtered = this.filter(sorted)
      const toggled = this.toggle(filtered)
      this.render(toggled)
    }
  
    /**
     * @param {Array} products
     * @returns {Array}
     */
    sort(products) {
      const $selectedSortTarget = this.$sortBy.find('option:selected')
      const val = $selectedSortTarget.val()
  
      // No sort
      if (val === 'none') {
        return products
      }
  
      // val: Number
      if (val === 'price') {
        return [...products].sort((a, b) => {
          if (a[val] < b[val]) {
            return -1
          }
          if (a[val] > b[val]) {
            return 1
          }
          return 0
        })
      }
  
      // val: String ('YYYY/MM/DD')
      if (val === 'created_at' || val === 'updated_at')
        return [...products].sort((a, b) => {
          /**
           * Convert 'YYYY/MM/DD' string to date
           * @param {String} dateString
           * @returns Date object
           */
          const toDate = (dateString) => {
            const momentObject = moment(dateString, 'YYYY/MM/DD')
            const dateObject = momentObject.toDate()
            return dateObject
          }
  
          if (toDate(a[val]) < toDate(b[val])) return -1
          if (toDate(a[val]) > toDate(b[val])) return 1
          return 0
        })
    }
  
    /**
     * @param {Array} products
     * @returns {Array}
     */
    filter(products) {
      const $selectedBrand = this.$filterBrand.find('option:selected')
      const $selectedCategory = this.$filterCategory.find('option:selected')
  
      /**
       * @param {Object} product
       */
      const isBrandValid = (product) => {
        return $selectedBrand.val() === 'all'
          ? product
          : product.brand === $selectedBrand.text()
      }
  
      /**
       * @param {Object} product
       */
      const isCategoryValid = (product) => {
        return $selectedCategory.val() === 'all'
          ? product
          : product.category === $selectedCategory.text()
      }
  
      return products.filter(isBrandValid).filter(isCategoryValid)
    }
  
    /**
     * @param {Array} products
     * @returns {Array}
     */
    toggle(products) {
      return this.$hidingOutOfStock.prop('checked')
        ? products.filter((product) => product.stocked === true)
        : products
    }
  
    render(products) {
      const twoSpace = '&nbsp;&nbsp;'
  
      if (!this.state.isLoaded) {
        this.$tbody.html('<div>Loading...</div>')
        return
      }
  
      this.$tbody.html(
        products.map(
          (product) =>
            `<tr class="table-row" data-key="${product.id}">
              <td class="table-cell align-right">${product.id}</td>
              <td class="table-cell align-left">${product.brand}</td>
              <td class="table-cell align-left">${product.name}</td>
              <td class="table-cell align-left">${product.category}</td>
              <td class="table-cell align-right">&yen; ${product.price}</td>
              <td class="table-cell align-left">${
                product.stocked
                  ? `<i class="fas fa-check-circle light-text"></i>${twoSpace}In stock`
                  : `<i class="fas fa-minus-circle light-text"></i>${twoSpace}Out of stock`
              }</td>
              <td class="table-cell align-left">${product.created_at}</td>
              <td class="table-cell align-left">${product.updated_at}</td>
            </tr>`
        )
      )
  
      products.length === 0
        ? this.$noResults.removeClass('hidden')
        : this.$noResults.addClass('hidden')
    }
  }
  