$gtk.reset

class Color
  attr_accessor :r, :g, :b, :a

  def initialize(r, g, b, a=255)
    @r, @g, @b, @a = r, g, b, a
  end

  def pack
    [r, g, b, a]
  end

  def serialize
    {r: r, g: g, b: b, a: a}
  end
end
