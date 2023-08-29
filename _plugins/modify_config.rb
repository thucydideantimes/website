# frozen_string_literal: true

module Jekyll::ThucydideanTimes
end

module Jekyll
	module ThucydideanTimes::ModifyConfig
		module_function
		def run site
			site.config['paginate'] = nil
		end
		def hook
			Hooks.register :site, :after_init do |site|
				run site
			end
		end
	end
end

Jekyll::ThucydideanTimes::ModifyConfig.hook
