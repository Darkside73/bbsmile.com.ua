tinymce.PluginManager.add('product_template', function (editor, url) {
  editor.addMenuItem(
    'product_template1',
    {
      text: 'Шаблон для товара (Стандарт)',
      icon: false,
      context: 'insert',
      onclick: function() {
        editor.insertContent(
          "<div class=\"row text-center\"> <div class=\"col-sm-3 col-xs-6\"> <i class=\"fa fa-truck fa-4x text-muted\">&nbsp;</i> <br/> <h4>Доставка по всей Украине</h4> </div> <div class=\"col-sm-3 col-xs-6\"> <i class=\"fa fa-money fa-4x text-muted\">&nbsp;</i> <br/> <h4>Оплата при получении</h4> </div> <div class=\"clearfix visible-xs\"></div> <div class=\"col-sm-3 col-xs-6\"> <i class=\"fa fa-history fa-4x text-muted\">&nbsp;</i> <br/> <h4>Возврат в течение 14 дней</h4> </div> <div class=\"col-sm-3 col-xs-6\"> <i class=\"fa fa-check-square-o fa-4x text-muted\">&nbsp;</i> <br/> <h4>Гарантия от производителя</h4> </div> </div> <p>&nbsp;</p>"
        );
      }
    }
  );

  editor.addMenuItem(
    'product_template2',
    {
      text: 'Шаблон для товара (Верес)',
      icon: false,
      context: 'insert',
      onclick: function() {
        editor.insertContent(
          "<div class=\"row text-center\"> <div class=\"col-sm-3 col-xs-6\"> <i class=\"fa fa-truck fa-4x text-muted\">&nbsp;</i> <br/> <h4>Бесплатная доставка по Украине</h4> </div> <div class=\"col-sm-3 col-xs-6\"> <i class=\"fa fa-shopping-bag fa-4x text-muted\">&nbsp;</i> <br/> <h4>Проверка товара перед покупкой</h4> </div> <div class=\"clearfix visible-xs\"></div> <div class=\"col-sm-3 col-xs-6\"> <i class=\"fa fa-history fa-4x text-muted\">&nbsp;</i> <br/> <h4>Возврат в течение 14 дней</h4> </div> <div class=\"col-sm-3 col-xs-6\"> <i class=\"fa fa-check-square-o fa-4x text-muted\">&nbsp;</i> <br/> <h4>Гарантия от производителя</h4> </div> </div> <p>&nbsp;</p>"
        );
      }
    }
  );

  editor.addMenuItem(
    'product_template3',
    {
      text: 'Шаблон для товара (Луцк)',
      icon: false,
      context: 'insert',
      onclick: function() {
        editor.insertContent(
          "<div class=\"row text-center\"> <div class=\"col-sm-3 col-xs-6\"> <i class=\"fa fa-home fa-4x text-muted\">&nbsp;</i> <br/> <h4>Доставка по Киеву сегодня</h4> </div> <div class=\"col-sm-3 col-xs-6\"> <i class=\"fa fa-shopping-bag fa-4x text-muted\">&nbsp;</i> <br/> <h4>Проверка товара перед покупкой</h4> </div> <div class=\"clearfix visible-xs\"></div> <div class=\"col-sm-3 col-xs-6\"> <i class=\"fa fa-history fa-4x text-muted\">&nbsp;</i> <br/> <h4>Возврат в течение 14 дней</h4> </div> <div class=\"col-sm-3 col-xs-6\"> <i class=\"fa fa-check-square-o fa-4x text-muted\">&nbsp;</i> <br/> <h4>Гарантия от производителя</h4> </div> </div> <p>&nbsp;</p>"
        );
      }
    }
  )

  editor.addMenuItem(
    'product_template4',
    {
      text: 'Шаблон для товара (Краснал)',
      icon: false,
      context: 'insert',
      onclick: function() {
        editor.insertContent(
          "<div class=\"row text-center\"> <div class=\"col-sm-3 col-xs-6\"> <i class=\"fa fa-money fa-4x text-muted\">&nbsp;</i> <br/> <h4>Оплата при получении</h4> </div> <div class=\"col-sm-3 col-xs-6\"> <i class=\"fa fa-shopping-bag fa-4x text-muted\">&nbsp;</i> <br/> <h4>Проверка товара перед покупкой</h4> </div> <div class=\"clearfix visible-xs\"></div> <div class=\"col-sm-3 col-xs-6\"> <i class=\"fa fa-history fa-4x text-muted\">&nbsp;</i> <br/> <h4>Возврат в течение 14 дней</h4> </div> <div class=\"col-sm-3 col-xs-6\"> <i class=\"fa fa-check-square-o fa-4x text-muted\">&nbsp;</i> <br/> <h4>Гарантия от производителя</h4> </div> </div> <p>&nbsp;</p>"
        );
      }
    }
  )
});
