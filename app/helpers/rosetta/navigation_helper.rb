module Rosetta
  module NavigationHelper
    def tab_link_to(name = nil, options = nil, html_options = nil, &block)
      is_current_page = current_page?(block_given? ? name : options)

      css_classes = class_names(
        "flex group whitespace-nowrap border-b-2 px-1 py-4 text-sm font-medium",
        "active border-indigo-500 text-indigo-600": is_current_page,
        "border-transparent text-gray-500 hover:border-gray-200 hover:text-gray-700": !is_current_page
      )

      html_options = { class: css_classes, aria: { current: "page" } }

      if block_given?
        link_to(name, html_options, &block)
      else
        link_to(name, options, html_options)
      end
    end
  end
end
