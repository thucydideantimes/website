# frozen_string_literal: true

module Jekyll::ThucydideanTimes
end

module Jekyll
	module ThucydideanTimes::BlogLayout
		module_function

		def hook
			Hooks.register :pages, :post_init do |page|
				site = page.site
				next unless page.data['layout'] == 'blog'
				is_post = page.basename == 'blog'
				collection_name = is_post ? 'posts' : page.basename
				raise unless collection = site.collections[collection_name]
				page.data['pagination'] = {'enabled'=>true, 'collection'=>collection_name}
				if is_post
					page.data['permalink'] = '/blog/'
					page.data['title'] = '所有文章'
					page.data['teaser'] = 'TODO: 所有文章的描述'
					page.data['subheadline'] = '特殊页面'
				else
					page.data['permalink'] = "/blog/#{collection_name}/"
					page.data['title'] = collection.metadata['title']
					page.data['teaser'] = collection.metadata['description']
					page.data['subheadline'] = '板块'
				end
			end
		end
	end
end

Jekyll::ThucydideanTimes::BlogLayout.hook
