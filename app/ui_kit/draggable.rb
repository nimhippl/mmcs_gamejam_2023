module Draggable
  def intersect_with_mouse? args
    args.inputs.mouse.intersect_rect?(self.rect)
  end

  private def rect
    {
      x: self.x,
      y: self.y,
      w: self.w,
      h: self.h,
      anchor_x: self.anchor_x,
      anchor_y: self.anchor_y
    }
  end

  def on_mouse_over args
    self.a = 200
  end

  def on_mouse_click args
    args.state.mouse_point_inside_draggable = {
      x: args.inputs.mouse.x - self.x,
      y: args.inputs.mouse.y - self.y
    }
  end

  def on_mouse_held args
    args.state.dragging = true
    self.x = args.inputs.mouse.x - args.state.mouse_point_inside_draggable.x
    self.y = args.inputs.mouse.y - args.state.mouse_point_inside_draggable.y
  end

  def on_mouse_up args
    args.state.dragging = false
  end

  def on_mouse_leave args
    self.a = 255
  end
end
