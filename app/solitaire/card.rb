$gtk.reset

class Card
  attr_accessor :x, :y, :w, :h, :path, :anchor_x, :anchor_y, :angle, :r, :g, :b, :a
  CARD_WIDTH = 100
  CARD_HEIGHT = 170
  CARDS_FOLDER = 'sprites/cards asset/Standard 52 Cards/normal_cards/individual/'

  def initialize(suit, value, x=0, y=0)
    @suit = suit
    @value = value
    @path = card_path(suit, value)
    @x = x
    @y = y
    @w = CARD_WIDTH
    @h = CARD_HEIGHT
    @anchor_x = @anchor_y = 0.5
    @angle = 0
    @a = 255
  end

  def card_path(suit, value)
    s = CARDS_FOLDER + suit + "/card" + suit.capitalize + "s_" + value + ".png"
    s
  end

  def card_back
    CARDS_FOLDER + 'card back/cardBackRed.png'
  end

  def move_to(x, y)
    @x = x
    @y = y
  end

  def serialize
    {
      path: path,
      x: x,
      y: y,
      w: w,
      h: h,
      anchor_x: anchor_x,
      anchor_y: anchor_y,
      a: a
    }
  end

  def rect
    [x - CARD_WIDTH / 2, y - CARD_HEIGHT / 2, CARD_WIDTH, CARD_HEIGHT]
  end

  def to_s
    serialize.to_s
  end

  def inspect
    serialize.to_s
  end

  def render(args)
    args.sprites << self.serialize
  end
end
