class AddRussianDictionary < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE TEXT SEARCH DICTIONARY russian_ispell (
      TEMPLATE = ispell,
      DictFile = russian,
      AffFile = russian,
      StopWords = russian
      );
      CREATE TEXT SEARCH CONFIGURATION ru ( COPY = russian );
      ALTER TEXT SEARCH CONFIGURATION ru ALTER MAPPING FOR hword, hword_part, word WITH russian_ispell, russian_stem;
    SQL
  end

  def down
    execute <<-SQL
      DROP TEXT SEARCH CONFIGURATION ru;
      DROP TEXT SEARCH DICTIONARY russian_ispell;
    SQL
  end
end
