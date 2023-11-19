$gtk.reset

class Button
  attr_accessor :x, :y, :w, :h, :button_color, :text, :text_color, :anchor_x, :anchor_y
  attr_reader :default_a

  def initialize(x:, y:, w:, h:, color:, text:, text_color:, anchor_x: 0.5, anchor_y: 0.5)
    @x = x
    @y = y
    @w = w
    @h = h
    @text = text
    @button_color = color
    @text_color = text_color
    @anchor_x = anchor_x
    @anchor_y = anchor_y

    setup_default_hover_leave_actions
    @active = true
  end

  private def setup_default_hover_leave_actions
    @default_a = button_color.a

    @on_hover = Proc.new do |button|
      button.button_color.a = button.default_a - 50
    end

    @on_leave = Proc.new do |button|
      button.button_color.a = button.default_a
    end
  end

  def set_active(flag)
    @active = flag
  end

  def active?
    @active
  end

  def render args
    args.outputs.solids << button_body
    args.outputs.labels << label
  end

  def button_body
    return {
      x: x,
      y: y,
      w: w,
      h: h,
      anchor_x: anchor_x,
      anchor_y: anchor_y
    }.merge(button_color.serialize)
  end

  def label
    return {
      x: x,
      y: y,
      anchor_x: anchor_x,
      anchor_y: anchor_y,
      text: text
    }.merge(text_color.serialize)
  end

  def on_mouse_hover(&block)
    if block_given?
      @on_hover = block
    end
  end

  def trigger_mouse_hover(args=nil)
    @on_hover.call(self, args)
  end

  def on_mouse_leave(&block)
    if block_given?
      @on_leave = block
    end
  end

  def trigger_mouse_leave(args=nil)
    @on_leave.call(self, args)
  end

  def on_mouse_click(&block)
    if block_given?
      @on_click = block
    end
  end

  def trigger_mouse_click(args=nil)
    return if @on_click.nil?

    @on_click.call(self, args)
  end
end
