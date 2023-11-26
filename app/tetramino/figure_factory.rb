$gtk.reset

module Tetramino
  class FigureFactory
    def initialize(cell_size, figures_folder_path="sprites/tetrominos/")
      @figures_folder_path = figures_folder_path
      @cell_size = cell_size
    end

    def build_figure(key)
      case key
      when :long_straight
        long_straight
      when :t_shaped
        t_shaped
      end
    end

    def long_straight
      path = @figures_folder_path + "I.png"
      grid_mask = [[true], [true], [true], [true]]
      w = 4 * @cell_size
      h = @cell_size

      figure = Figure.new(w: h, h: w, path: path, grid_mask: grid_mask)

      figure
    end

    def t_shaped
      path = @figures_folder_path + "T.png"
      grid_mask = [[true, false], [true, true], [true, false]]
      w = 3 * @cell_size
      h = 2 * @cell_size

      Figure.new(w: w, h: h, path: path, grid_mask: grid_mask)
    end
  end
end
