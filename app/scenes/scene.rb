$gtk.reset

class Scene
  attr_reader :args

  def initialize
    @args = nil
  end

  private def search_buttons
    self.instance_variables.map {|vname| instance_variable_get(vname) }.filter {|v| v.is_a?(Button)}
  end

  def tick args
    @args = args
    @__buttons__ ||= search_buttons
    render
    process_input
  end

  def render
    render_ui
  end

  def render_ui
    @__buttons__.each do |button|
      button.render args if button.active?
    end
  end

  def process_input
    @__buttons__.each do |button|
      process_button button if button.active?
    end
  end

  private def process_button button
    if args.inputs.mouse.intersect_rect?(button.button_body)
      button.trigger_mouse_hover(args)

      if args.inputs.mouse.click
        button.trigger_mouse_click(args)
      end

      return
    end

    button.trigger_mouse_leave(args)
  end
end

