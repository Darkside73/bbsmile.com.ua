require('jquery-ujs');
require('bootstrap-sass/assets/javascripts/bootstrap');

if (__RAILS_ENV__ != 'production')
  require('common/admin-panel');

require('common/main');
require('common/search-box');
require('./components/App.vue');
