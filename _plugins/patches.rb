# frozen_string_literal: true

module Jekyll::ThucydideanTimes
end

module Jekyll
	module ThucydideanTimes::Patches

		module PagePatches
			include Filters::URLFilters
			def url
				strip_index super
			end
		end
		Page.prepend PagePatches

		# https://github.com/sverrirs/jekyll-paginate-v2/issues/254
		module PaginationPagePatches
			attr_reader :relative_path
			def initialize page_to_copy, cur_page_nr, total_pages, index_pageandext
				super
				@relative_path = page_to_copy.relative_path
			end
		end
		PaginateV2::Generator::PaginationPage.prepend PaginationPagePatches

	end
end
