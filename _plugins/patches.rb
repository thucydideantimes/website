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

	end
end
