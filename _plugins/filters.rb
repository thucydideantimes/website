# frozen_string_literal: true

module Jekyll::ThucydideanTimes
end

module Jekyll
	module ThucydideanTimes::Filters

		module Helper
			class << self
				include Liquid::StandardFilters
				include LiquidFilter
				include Filters
				def context context
					@context = context
				end
			end
		end

		def strip_p input
			result = input.gsub %r{</?p>}, ''
			result.chomp!
			result
		end

		def liq input
			Helper.context @context
			Helper.markdownify Helper.liquify input
		end

		def p_liq input
			strip_p liq input
		end

		def strip_liq input
			Helper.context @context
			Helper.strip_html liq input
		end

		def escape_liq input
			Helper.context @context
			Helper.escape_once strip_liq input
		end

		def self.register
			Liquid::Template.register_filter self
		end
	end
end

Jekyll::ThucydideanTimes::Filters.register
