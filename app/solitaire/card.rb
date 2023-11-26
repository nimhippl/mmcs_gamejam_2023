$gtk.reset

class Card < Sprite
  include Draggable
  CARD_WIDTH = 100
  CARD_HEIGHT = 170
  CARDS_FOLDER = 'sprites/cards asset/Standard 52 Cards/normal_cards/individual/'

  def initialize(suit, value, x=0, y=0)
    @suit = suit
    @value = value

    self.path = card_path(suit, value)
    self.x = x
    self.y = y
    self.w = CARD_WIDTH
    self.h = CARD_HEIGHT
    self.anchor_x = self.anchor_y = 0.5
    self.angle = 0
    self.a = 255
  end

  def card_path(suit, value)
    s = CARDS_FOLDER + suit + "/card" + suit.capitalize + "s_" + value + ".png"
    s
  end

  def card_back
    CARDS_FOLDER + 'card back/cardBackRed.png'
  end

  # def rect
  #   [x - CARD_WIDTH / 2, y - CARD_HEIGHT / 2, CARD_WIDTH, CARD_HEIGHT]
  # end
end
