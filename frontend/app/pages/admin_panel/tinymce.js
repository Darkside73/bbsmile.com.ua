if ($('.tinymce').length) {
  tinymce.init({
    selector: '.tinymce',
    language: 'ru',
    toolbar: [
      'styleselect | bold italic | removeformat | link unlink image pastetext | undo redo | bullist numlist outdent indent | alignleft aligncenter alignright alignjustify | table youtube example'
    ],
    menubar: 'edit insert view format table tools',
    plugins: [
      'link', 'table', 'code', 'image', 'paste', 'contextmenu', 'youtube', 'product_template'
    ],
    height: 300,
    relative_urls: false,
    convert_urls: false,
    document_base_url: '/',
    remove_script_host: true,
    extended_valid_elements: "i[class],div[class]",
    content_css: __TINYMCE_CONTENT_STYLES__,
    table_default_attributes: {
      class: "table table-responsive"
    },
    table_class_list: [
      { title: "полосатая", value: "table table-responsive table-striped" },
      { title: "с границами", value: "table table-responsive table-bordered" },
      { title: "полосатая с границами", value: "table table-responsive table-striped table-bordered" }
    ]
  });
}
