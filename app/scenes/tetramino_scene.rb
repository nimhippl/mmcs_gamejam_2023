$gtk.reset

class TetraminoScene < Scene
  def initialize args
    @args = args
    @cell_primitive = Border.new(color: Color.white)
    @grid = Tetramino::Grid.new(rows: 5, cols: 10, position: [640, 360], cell_size: 50, cell_primitive: @cell_primitive)

    @background_color = Color.black
  end

  def render
    super
    args.outputs.background_color = @background_color.pack
    @grid.render args
  end
end
