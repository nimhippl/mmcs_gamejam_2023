$gtk.reset

class TetraminoScene < Scene
  CELL_SIZE = 50
  GAP_BETWEEN_FIGURES = 50
  MARGIN_BOTTOM = 20
  SCREEN_WIDTH = 1280
  SCREEN_HEIGHT = 720

  def initialize args
    super(args)

    @cell_primitive = Border.new(color: Color.white)
    @grid = Tetramino::Grid.new(rows: 5, cols: 10, position: [640, 360], cell_size: CELL_SIZE,
                                cell_primitive: @cell_primitive)

    @background_color = Color.gray
    setup_figures(:long_straight, :t_shaped)
  end

  def setup_figures(*figure_names)
    @figure_factory = Tetramino::FigureFactory.new(CELL_SIZE)
    @figures = figure_names.map { |f_name| @figure_factory.build_figure(f_name) }

    position_figures
    @draggables = @figures
  end

  def position_figures
    return if @figures.empty?

    w = @figures.sum { |fig| fig.w }
    w += (@figures.count - 1) * GAP_BETWEEN_FIGURES

    x = (SCREEN_WIDTH - w) / 2
    y = MARGIN_BOTTOM
    @figures.each do |figure|
      figure.x = x + figure.anchor_x * figure.w
      figure.y = y + figure.anchor_y * figure.h
      x += figure.w + GAP_BETWEEN_FIGURES
    end
  end

  def render
    super
    args.outputs.background_color = @background_color.pack
    @grid.render args

    @figures.each do |figure|
      figure.render args
    end
  end
end
