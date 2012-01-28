module ApplicationHelper
  # Return a title on a per-page basis.
    def title
      base_title = "Atheneum"
      if @title.nil?
        base_title
      else
        "#{base_title} | #{@title}"
      end
    end
    
    def logo
        image_tag("Logo.PNG", :alt => "Atheneum", :class => "round", :size => "300x100")
    end
end
