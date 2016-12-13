class SliderInput < SimpleForm::Inputs::Base
  def input
    "<div class='slider-input'></div><div class='text-center'><span class='row slider-value'>5</span></div>#{@builder.hidden_field(attribute_name, input_html_options)}".html_safe
  end
end
