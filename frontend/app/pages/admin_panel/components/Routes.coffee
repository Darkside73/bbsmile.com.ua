module.exports = {
  props:
    items:
      type: Object
  methods:
    items: (name) -> @items[name]
}
