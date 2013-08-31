$ ->
  $('#category-content .offers .nav a').click ->
    _gaq.push ['_trackEvent', 'Категория', 'Открыть вкладку', $(this).text()]
  $('#whole-catalog-items .subitems .view-all').click ->
    _gaq.push ['_trackEvent', 'Категория', 'Смотреть все', $(this).data('title')]
  $('.contacts .siteheart').click ->

    _gaq.push ['_trackEvent', 'Контакты', 'Открыть чат']
  $('.contacts .phone').click ->
    _gaq.push ['_trackEvent', 'Контакты', 'Позвонить'] unless $(this).hasClass('active')
  $('.contacts .email').click ->
    _gaq.push ['_trackEvent', 'Контакты', 'Написать письмо']

  $('#filterByCategory ul>li>a').click ->
    _gaq.push ['_trackEvent', 'Категория', 'Перейти к подкатегории', $(this).text()]
  $('#filterByPrice ul>li>a').click ->
    _gaq.push ['_trackEvent', 'Категория', 'Фильтровать по цене', $(this).text()]
  $('#filterByTags ul>li>a').click ->
    _gaq.push ['_trackEvent', 'Категория', 'Фильтровать по тегу', $(this).text()]
  $('#filterByBrand ul>li>a').click ->
    _gaq.push ['_trackEvent', 'Категория', 'Фильтровать по бренду', $(this).text()]
  $('.selected-filters ul.nav>li>a').click ->
    _gaq.push ['_trackEvent', 'Категория', 'Удалить фильтр', $(this).text()]
  $('.selected-filters a.remove-all').click ->
    _gaq.push ['_trackEvent', 'Категория', 'Удалить все фильтры']
  $('.show-options ul>li>a').click ->
    _gaq.push ['_trackEvent', 'Категория', 'Сортировать по цене', $(this).text()]
  $('.show-options .more').click ->
    _gaq.push ['_trackEvent', 'Категория', 'Просмотреть информацию']

  $('a.product-back').click ->
    _gaq.push ['_trackEvent', 'Навигация', 'Вернуться назад', $(this).data('title')]
  $('p.shipping a').click ->
    _gaq.push ['_trackEvent', 'Товар', 'Информация о доставке']
  $('#product-info-tabs li>a').click ->
    _gaq.push ['_trackEvent', 'Товар', 'Открыть вкладку', $(this).text()]
  $('.share .icon-vk').click ->
    _gaq.push ['_trackEvent', 'Товар', 'Поделиться в соцсети', 'Вконтакте']
  $('.share .icon-facebook').click ->
    _gaq.push ['_trackEvent', 'Товар', 'Поделиться в соцсети', 'Фейсбук']
  $('.share .icon-twitter').click ->
    _gaq.push ['_trackEvent', 'Товар', 'Поделиться в соцсети', 'Твиттер']