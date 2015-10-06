$ ->
  $('#category-content .offers .nav a').click ->
    ga 'send', 'Категория', 'Открыть вкладку', $(this).text()
  $('#whole-catalog-items .subitems .view-all').click ->
    ga 'send', 'Категория', 'Смотреть все', $(this).data('title')
  $('.contacts .siteheart').click ->
    ga 'send', 'Контакты', 'Открыть чат'
  $('.contacts .phone').click ->
    ga('send', 'Контакты', 'Позвонить') unless $(this).hasClass('active')
  $('.contacts .email').click ->
    ga 'send', 'Контакты', 'Написать письмо', 'Открыть'
  $('.contacts .callback').click ->
    ga 'send', 'Контакты', 'Обратный звонок', 'Открыть'

  $('#filterByCategory ul>li:not(.active)>a').click ->
    ga 'send', 'Категория', 'Перейти к подкатегории', $(this).text()
  $('#filterByPrice ul>li:not(.active)>a').click ->
    ga 'send', 'Категория', 'Фильтровать по цене', $(this).text()
  $('#filterByAge ul>li:not(.active)>a').click ->
    ga 'send', 'Категория', 'Фильтровать по возрасту', $(this).text()
  $('#filterByTags ul>li:not(.active)>a').click ->
    ga 'send', 'Категория', 'Фильтровать по тегу', $(this).text()
  $('#filterByBrand ul>li:not(.active)>a').click ->
    ga 'send', 'Категория', 'Фильтровать по бренду', $(this).text()
  $('.selected-filters ul.nav>li>a').click ->
    ga 'send', 'Категория', 'Удалить фильтр', $(this).text()
  $('.selected-filters a.remove-all').click ->
    ga 'send', 'Категория', 'Удалить все фильтры'
  $('.show-options ul>li>a').click ->
    ga 'send', 'Категория', 'Сортировать по цене', $(this).text()
  $('.show-options .more').click ->
    ga 'send', 'Категория', 'Просмотреть информацию'
  $('#show-rest-products').click ->
    ga 'send', 'Категория', 'Показать остальные товары'

  $('a.product-back').click ->
    ga 'send', 'Навигация', 'Вернуться назад', $(this).data('title')
  $('a[href="#shippingModal"]').click ->
    ga 'send', 'Товар', 'Информация о доставке'
  $('#product-info-tabs li>a').click ->
    ga 'send', 'Товар', 'Открыть вкладку', $(this).text()
  $('.share .fa-vk').click ->
    ga 'send', 'Товар', 'Поделиться в соцсети', 'Вконтакте'
  $('.share .fa-facebook').click ->
    ga 'send', 'Товар', 'Поделиться в соцсети', 'Фейсбук'
  $('.share .fa-twitter').click ->
    ga 'send', 'Товар', 'Поделиться в соцсети', 'Твиттер'
