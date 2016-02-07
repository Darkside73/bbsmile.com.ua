module Webpack
  module Helpers
    COMMON_ENTRY = 'common'

    def webpack_bundle_js_tags(entry)
      webpack_tags :js, entry
    end

    def webpack_bundle_css_tags(entry)
      webpack_tags :css, entry
    end

    def webpack_tags(kind, entry)
      common_bundle = asset_tag(kind, COMMON_ENTRY)
      page_bundle   = asset_tag(kind, entry)
      if common_bundle
        common_bundle + page_bundle
      else
        page_bundle
      end
    end

    def asset_tag(kind, entry)
      if Rails.configuration.use_webpack
        manifest = Rails.configuration.webpack[:assets_manifest]
        if manifest.dig(entry, kind)
          file_name = manifest[entry][kind]
          case kind
          when :js
            javascript_include_tag file_name
          when :css
            stylesheet_link_tag file_name
          else
            throw "Unknown asset kind: #{kind}"
          end
        end
      end
    end
  end
end
