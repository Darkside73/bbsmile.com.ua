class FileInput < SimpleForm::Inputs::FileInput
  def input_html_classes
    super.delete 'form-control'
    super
  end
end
