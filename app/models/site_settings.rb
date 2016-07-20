require 'yaml/store'

class SiteSettings
  include ActiveModel::Model
  ATTRS = {
    offline_mode: { default: 0, type: :boolean }
  }

  attr_accessor *ATTRS.keys

  def initialize(args = nil)
    @store = Store.new.store
    @store.transaction do
      self.class.attributes.each do |attribute|
        value = if @store[attribute] != nil
          @store[attribute]
        else
          ATTRS[attribute][:default]
        end
        self.send("#{attribute}=", value)
      end
    end
    super
  end

  def save
    @store.transaction do
      self.class.attributes.each do |attribute|
        @store[attribute] = self.send(attribute)
      end
    end
  end

  def self.attributes
    ATTRS.keys
  end

  def self.get(attribute)
    store = Store.new.store
    store.transaction do
      store[attribute]
    end
  end

  def self.all
    settings = {}
    store = Store.new.store
    store.transaction do
      attributes.each { |attribute| settings[attribute] = store[attribute] }
    end
    settings
  end

  class Store
    PATH = Rails.root.join("data", "site.settings")
    attr_reader :store

    def initialize
      @store = YAML::Store.new PATH
    end
  end
end
