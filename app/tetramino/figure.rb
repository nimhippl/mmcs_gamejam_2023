$gtk.reset

module Tetramino
  class Figure < Sprite
    include Draggable

    attr_accessor :grid_mask

    def initialize(x: nil, y: nil, w: nil, h: nil, path: nil, color: nil, anchor_x: 0.5, anchor_y: 0.5,
                   grid_mask: [[true]])
      super(x: x, y: y, w: w, h: h, path: path, color: color, anchor_x: anchor_x, anchor_y: anchor_y)

      @grid_mask = grid_mask
    end
  end
end
