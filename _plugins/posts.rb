# frozen_string_literal: true

module Jekyll::ThucydideanTimes
end

module Jekyll
	module ThucydideanTimes::Posts

		COLLECTIONS = %w[echoesofcapital dailynews yongledadian militarytimes]

		module_function

		def change_collection_paths site
			COLLECTIONS.each do |collection|
				dir = File.join '_articles', collection
				site.collections[collection].instance_variable_set :@relative_directory, dir
			end
		end

		def add_all site
			COLLECTIONS.each do |collection|
				site.collections[collection].docs.each do |doc|
					doc.data['assets'] = File.join site.config['article_assets'], collection, doc.basename_without_ext, ''
					doc = doc.dup
					doc.instance_variable_set :@write_p, false
					site.posts.docs.push doc
				end
			end
		end

		def hook
			Hooks.register :site, :after_reset do |site|
				change_collection_paths site
			end
			Hooks.register :site, :post_read do |site|
				add_all site
			end
		end
	end
end

Jekyll::ThucydideanTimes::Posts.hook
