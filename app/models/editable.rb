class Editable
  def initialize(params)
    

    @datatype        = params[0].class.columns_hash[method.to_s].type
    @model           = object.class.model_name.singular
    @id              = object.send object.class.primary_key
    @url             = url_for(object)
    @identifier      = "#{model}_#{id}_#{method}"
    @raw_value       = object.send(method)
    @value           = parse_value raw_value, display_with
    @contenteditable = active ? 'contenteditable=""' : ''
    @ondemand_class  = ondemand ? "ondemand" : ""
  end
  
  def print
    "
      <#{@tag} class=\"#{@classname} #{@ondemand}\" data-editable=\"#{@identifier}\"\
        data-editable-model=\"#{@model}\"\
        data-editable-id=\"#{@id}\"\
        data-editable-method=\"#{@method}\"\
        data-editable-datatype=\"#{@datatype}\"\
        data-editable-value=\"#{@raw_value}\"\
        data-editable-url=\"#{@url}\"\
        data-editable-display-with=\"#{@display_with}\"
        #{@contenteditable}>
          #{@value}
      </#{@tag}>
    ".squish..html_safe
  end
end