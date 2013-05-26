namespace :convert do
  namespace :products do
    desc 'Import products from old_content/prices.csv file'
    task :import do
      require 'converter/products_importer'
      csv_file = File.read 'old_content/prices.csv'
      log_file = File.open('old_content/import.log', 'w+')
      importer = Converter::ProductsImporter.new csv_file
      importer.logger = Logger.new(log_file)
      importer.data_base_path = 'old_content'
      importer.categories_map = YAML.load(File.read('old_content/categories_map.yml'))
      importer.import
      importer.results.show
    end
  end
end