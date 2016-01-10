require('jquery-ujs');
require('bootstrap');

if (__RAILS_ENV__ != 'production')
  require('./common/admin-panel');

require('./common/main');
