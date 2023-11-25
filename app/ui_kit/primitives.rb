class Primitive
  attr_accessor :x, :y, :w, :h, :anchor_x, :anchor_y, :r, :g, :b, :a, :blendmode_enum

  def initialize(x: nil, y: nil, w: nil, h: nil, color: Color.black, anchor_x: 0.5, anchor_y: 0.5, blendmode_enum: 0)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.r, self.g, self.b, self.a = color.pack
    self.anchor_x = anchor_x
    self.anchor_y = anchor_y
    self.blendmode_enum = blendmode_enum
  end

  def primitive_marker
    :solid
  end

  def render args
    case self.primitive_marker
    when :solid
      args.outputs.solids << self
    when :border
      args.outputs.borders << self
    when :sprite
      args.outputs.sprites << self
    end
  end

  def serialize
    {
      x: x,
      y: y,
      w: w,
      h: h,
      r: r,
      b: b,
      g: g,
      a: a,
      anchor_x: anchor_x,
      anchor_y: anchor_y
    }
  end

  def to_s
    serialize.to_s
  end
end

class Solid < Primitive
  attr_accessor :x2, :y2, :x3, :y3
end

class Border < Primitive
  def primitive_marker
    :border
  end
end

class Sprite < Primitive
  attr_accessor :path, :angle, :angle_anchor_x, :angle_anchor_y,  :tile_x, :tile_y, :tile_w, :tile_h,
                :source_x, :source_y, :source_w, :source_h, :flip_horizontally, :flip_vertically

  def initialize(x: nil, y: nil, w: nil, h: nil, path: nil, color: nil, anchor_x: 0.5, anchor_y: 0.5)
    super(x: x, y: y, w: w, h: h, color: color, anchor_x: anchor_x, anchor_y: anchor_y)
    self.path = path
  end

  def primitive_marker
    :sprite
  end
end
