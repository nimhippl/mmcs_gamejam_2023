$gtk.reset

module Tetramino
  class Grid
    def initialize(rows:, cols:, position:, cell_size:, anchor_x: 0.5, anchor_y: 0.5, cell_primitive: nil, mask: nil)
      @grid = []

      @position = position
      @cell_size = cell_size
      @anchor_x, @anchor_y = anchor_x, anchor_y
      set_grid(rows, cols)
      set_cell_primitive(cell_primitive)
      set_render_mask(mask)
    end

    private

    def set_cell_primitive(cell_primitive)
      @cell_primitive = cell_primitive
      if @cell_primitive.nil?
        @cell_primitive = Border.new(color: Color.white)
      end
    end

    def set_grid(rows, cols)
      rows.times do |row|
        cols.times do |col|
          @grid[row] ||= []
          @grid[row][col] = nil
        end
      end
    end

    def set_render_mask(mask)
      return if mask.nil? or mask[0].nil?

      return if mask.length != @grid.length or mask[0].length != @grid[0].length

      @mask = mask
    end

    def left_upper_corner
      x, y = @position
      w, h = size
      [x - @anchor_x * w, y + @anchor_y * h]
    end

    def size
      h = @grid.length * @cell_size
      w = @grid[0].length * @cell_size

      [w, h]
    end

    public

    def render args
      @grid.each_with_index do |row, i|
        row.each_with_index do |element, j|
          next unless should_render_element_at?(i, j)

          render_grid_element(args, element, j, i)
        end
      end
    end

    private

    def should_render_element_at?(i, j)
      @mask.nil? or @mask[i][j]
    end

    def render_grid_element(args, element, i, j)
      left_corner_x, left_corner_y = left_upper_corner

      x = left_corner_x + i * @cell_size
      y = left_corner_y - j * @cell_size

      cell = @cell_primitive.clone
      cell.x = x
      cell.y = y
      cell.w = @cell_size
      cell.h = @cell_size
      cell.anchor_x = 0
      cell.anchor_y = 0

      cell.render args
    end
  end
end
