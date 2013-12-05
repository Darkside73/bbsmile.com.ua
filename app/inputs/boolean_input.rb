class BooleanInput < SimpleForm::Inputs::BooleanInput
  def input_html_classes
    super.delete 'form-control'
    super
  end
end
