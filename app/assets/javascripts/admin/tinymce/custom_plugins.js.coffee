tinymce.PluginManager.add('product_template', (editor, url) ->
  editor.addMenuItem(
    'product_template1'
    text: 'Шаблон для товара 1'
    icon: false
    context: 'insert'
    onclick: ->
      editor.insertContent(
        "<div class=\"row text-center\">
          <div class=\"col-sm-4\">
            <i class=\"fa fa-truck fa-4x text-muted\">&nbsp;</i>
            <br/>
            <h4>Бесплатная доставка по Украине</h4>
          </div>
          <div class=\"col-sm-4\">
            <i class=\"fa fa-shopping-bag fa-4x text-muted\">&nbsp;</i>
            <br/>
            <h4>Проверка товара перед покупкой</h4>
          </div>
          <div class=\"col-sm-4\">
            <i class=\"fa fa-history fa-4x text-muted\">&nbsp;</i>
            <br/>
            <h4>Возврат в течение <mark>14</mark> дней</h4>
          </div>
        </div>
        <p>&nbsp;</p>"
      )
  )
  editor.addMenuItem(
    'product_template2'
    text: 'Шаблон для товара 2'
    icon: false
    context: 'insert'
    onclick: ->
      editor.insertContent(
        "<div class=\"row text-center\">
          <div class=\"col-sm-4\">
            <i class=\"fa fa-home fa-4x text-muted\">&nbsp;</i>
            <br/>
            <h4>Доставка по Киеву сегодня</h4>
          </div>
          <div class=\"col-sm-4\">
            <i class=\"fa fa-shopping-bag fa-4x text-muted\">&nbsp;</i>
            <br/>
            <h4>Проверка товара перед покупкой</h4>
          </div>
          <div class=\"col-sm-4\">
            <i class=\"fa fa-history fa-4x text-muted\">&nbsp;</i>
            <br/>
            <h4>Возврат в течение <mark>14</mark> дней</h4>
          </div>
        </div>
        <p>&nbsp;</p>"
      )
  )
)
