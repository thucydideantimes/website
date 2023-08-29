# frozen_string_literal: true

module Jekyll::ThucydideanTimes
end

module Jekyll
	module ThucydideanTimes::BlogLayout
		module_function

		def hook
			Hooks.register :pages, :post_init do |page|
				next unless page.data['layout'] == 'blog'
				raise unless collection = page.site.collections[page.basename]
				page.data['pagination'] = {'enabled'=>true, 'collection'=>page.basename}
				page.data['permalink'] = "/blog/#{page.basename}/"
				page.data['title'] = collection.metadata['title']
				page.data['teaser'] = collection.metadata['description']
				page.data['subheadline'] = '板块'
				page.data['sidebar'] = 'right'
			end
		end
	end
end

Jekyll::ThucydideanTimes::BlogLayout.hook
