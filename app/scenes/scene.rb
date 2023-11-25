$gtk.reset

class Scene
  attr_reader :args

  def initialize(args)
    @args = args
    @draggables = []
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
    process_buttons
    process_draggables
  end

  private

  def process_buttons
    @__buttons__.each do |button|
      process_button button if button.active?
    end
  end

  def process_button button
    if args.inputs.mouse.intersect_rect?(button.button_body)
      button.trigger_mouse_hover(args)

      if args.inputs.mouse.click
        button.trigger_mouse_click(args)
      end

      return
    end

    button.trigger_mouse_leave(args)
  end

  def process_draggables
    return if @draggables.empty?

    if mouse_leave_draggable?
      on_mouse_leave_draggable
      return
    end

    args.state.draggable_under_mouse ||= @draggables.find { |draggable| draggable.intersect_with_mouse?(args) }

    process_draggable_under_mouse unless args.state.draggable_under_mouse.nil?
  end

  def mouse_leave_draggable?
    draggable = args.state.draggable_under_mouse
    !args.state.dragging && !draggable.nil? && !draggable.intersect_with_mouse?(args)
  end

  def process_draggable_under_mouse
    draggable = args.state.draggable_under_mouse
    draggable.on_mouse_over args

    if args.inputs.mouse.click
      draggable.on_mouse_click args
    elsif args.inputs.mouse.held
      draggable.on_mouse_held args
    elsif args.inputs.mouse.up
      draggable_dropped(draggable)
    end
  end

  protected

  def on_mouse_leave_draggable
    args.state.draggable_under_mouse.on_mouse_leave args
    args.state.draggable_under_mouse = nil
  end

  def draggable_dropped(draggable)
    draggable.on_mouse_up args
  end
end

