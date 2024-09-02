module Rosetta
  module DialogHelper
    def within_modal(&block)
      turbo_frame_tag :dialog_content, &block
    end

    def modal_title(title)
      tag.h1(title, class: "hidden", data: { dialog_target: "titleSource" })
    end
  end
end
