# frozen_string_literal: true

module Jekyll::ThucydideanTimes
end

module Jekyll
	class ThucydideanTimes::ArticleAssets < Liquid::Tag

		def render context
			site = context.registers[:site]
			page = context.registers[:page]
			basedir = site.source
			arguments = Liquid::Template.parse(@markup).render context
			asset_path, *options = arguments.split
			return asset_path if asset_path =~ %r{^\w+:}
			options.map! { |opt| opt.split '=', 2 }
			options = options.to_h
			if assets_home = options['home'] || page['assets']
				if File.exist? File.join basedir, assets_home, asset_path
					return File.join assets_home, asset_path
				end
			end
			assets_home = site.config['urlimg']
			if File.exist? File.join basedir, assets_home, asset_path
				return File.join assets_home, asset_path
			end
			assets_home = 'assets'
			if File.exist? File.join basedir, assets_home, asset_path
				return File.join assets_home, asset_path
			end
			Jekyll.logger.warn "ArticleAssets", "File #{asset_path} not found in any assets dir"
			asset_path
		end

		class << self

			def hook
				Hooks.register :documents, :post_init do |doc|
					doc.data['assets'] = File.join(
						doc.site.config['article_assets'],
						doc.collection.label,
						doc.basename_without_ext,
						''
					)
				end
			end

			def register_tag
				::Liquid::Template.register_tag 'asset', self
			end
		end
	end
end

Jekyll::ThucydideanTimes::ArticleAssets.hook
Jekyll::ThucydideanTimes::ArticleAssets.register_tag
