const fs = require('fs');
const path = require('path');

function Plugin(path, options) {
  this.assetsPath = path;
  this.renameFilesMap = options;
}

Plugin.prototype.apply = function(compiler) {
  compiler.plugin("after-emit", (compilation, callback) => {
    for (var filename in compilation.assets) {
      this.renameFilesMap.forEach(filemap => {
        if (filename.match(filemap.test))
          fs.rename(
            path.join(this.assetsPath, filename),
            path.join(this.assetsPath, filemap.destination)
          );
      });
    }
    callback();
  });
}

module.exports = Plugin;
