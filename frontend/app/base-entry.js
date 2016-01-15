require('jquery-ujs');
require('bootstrap-sass/assets/javascripts/bootstrap');

if (__RAILS_ENV__ != 'production')
  require('common/admin-panel');

require('common/main');
require('./components/App.vue');

require('common/styles/application.scss');
