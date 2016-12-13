module ListingsHelper
  def expiry(date)
    if date
      delta = date - Time.now
      one_week = 60*60*24*7

      if (delta < 0)
        return "class=expired"
      elsif (delta < one_week)
        return "class=expiring"
      else
        return "class=active"
      end
    end
  end

  def expiry_tooltip(date)
    if date
      delta = date - Time.now

      if delta < 0
        return "Expired."
      elsif (delta < 60)
        return "Expires in #{delta.floor} second(s)."
      elsif (delta < 60*60)
        return "Expires in #{(delta/60).floor} minute(s)."
      elsif (delta < 60*60*24)
        return "Expires in #{(delta / (60*60)).floor} hour(s) and #{((delta % (60*60)/60)).floor} minute(s)."
      elsif (delta < 60*60*24*7)
        return "Expires in #{(delta / (60*60*24)).floor} day(s)."
      else
        return "Expires in #{(delta / (60*60*24*7)).floor} week(s)."
      end
    end
  end

  def link_to_add_fields(f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.simple_fields_for(association, new_object, child_index: id) do |r|
      render("rooms/" + association.to_s.singularize + "_fields", f: r)
    end
    link_to('Add Field', class: "add_fields button small-12", data: {id: id, fields: fields.gsub("\n", "")}) do
       raw("<i class='fa fa-plus fa-2x'></i>")
    end
  end

  def simple_form_type_from_key(key)
    float = %w(square_footage)
    integer = %w(size appliance_count)
    if float.include?(key.to_s)
      return :float, :room_input
    elsif integer.include?(key.to_s)
      return :integer, :room_input
    else
      return :boolean, :room_checkbox
    end
  end

end
