$gtk.reset

class SolitaireScene < Scene
  attr_reader :args

  SCREEN_WIDTH = 1280
  SCREEN_HEIGHT = 720
  CARDS_IN_HAND = 5
  BOARD_COLOR = [49, 139, 87]
  DECK_AREA_COLOR = Color.new(8, 92, 8)
  BUTTON_COLOR = Color.new(50, 50, 50, 200)
  BUTTON_TEXT_COLOR = Color.new(250, 250, 250)
  MARGIN_BOTTOM = 20
  SPACE_BETWEEN_CARDS = 20

  def initialize args
    @args = args
    setup_ui
    setup_board
    @card_under_mouse = nil
  end

  def setup_ui
    @bg_color = [49, 139, 87]
    @finish_turn_button = Button.new(x: 1150, y: 70, w: 150, h: 70, color: BUTTON_COLOR, text: "Finish turn",
                                     text_color: BUTTON_TEXT_COLOR, anchor_x: 0.5, anchor_y: 0.5)

    @finish_turn_button.on_mouse_click do
      finish_turn
    end


    @dragging_card = false
  end

  def setup_board
    @deck_manager = DeckManager.new
    @deck_area = { x: 0, y: 0, w: 1280, h: Card::CARD_HEIGHT + 2 * MARGIN_BOTTOM, anchor_x: 0, anchor_y: 0 }
                    .merge(DECK_AREA_COLOR.serialize)
    @board = []
    draw_hand
  end

  def shuffle_deck
    puts "Shuffle!"
  end

  def draw_hand
    @hand = @deck_manager.draw(CARDS_IN_HAND)
    compute_card_positions_in_hand
  end

  def finish_turn
    @deck_manager.move_to_discard(@hand)
    @hand.clear

    draw_hand
  end

  def render
    super
    render_cards
  end

  def render_ui
    args.outputs.background_color = @bg_color
    args.outputs.solids << @deck_area
    super
  end

  def render_cards
    @hand.each do |card|
      card.render args
    end
    @board.each do |card|
      card.render args
    end
  end

  def compute_card_positions_in_hand
    y = Card::CARD_HEIGHT / 2 + MARGIN_BOTTOM
    hand_width = @hand.length * Card::CARD_WIDTH + (@hand.length - 1) * SPACE_BETWEEN_CARDS
    x = (SCREEN_WIDTH - hand_width) / 2 + Card::CARD_WIDTH / 2
    @hand.each do |card|
      card.x = x
      card.y = y
      x += Card::CARD_WIDTH + SPACE_BETWEEN_CARDS
    end
  end

  def process_input
    super
    process_cards
  end

  def process_cards
    if mouse_leave_card?
      on_mouse_leave_card
      return
    end

    unless @card_under_mouse
      cards = @hand + @board
      @card_under_mouse = cards.find { |card| args.geometry.intersect_rect?(args.inputs.mouse, card.serialize) }
    end

    return if @card_under_mouse.nil?

    process_card_under_mouse
  end

  def mouse_leave_card?
    !@dragging_card && !@card_under_mouse.nil? && !args.inputs.mouse.intersect_rect?(@card_under_mouse.serialize)
  end

  def on_mouse_leave_card
    @card_under_mouse.a = 255
    @card_under_mouse = nil
  end

  def process_card_under_mouse
    @card_under_mouse.a = 200

    if args.inputs.mouse.click
      @dragging_card = true
      args.state.mouse_point_inside_card = {
        x: args.inputs.mouse.x - @card_under_mouse.x,
        y: args.inputs.mouse.y - @card_under_mouse.y,
      }
    elsif args.inputs.mouse.held
      @card_under_mouse.x = args.inputs.mouse.x - args.state.mouse_point_inside_card.x
      @card_under_mouse.y = args.inputs.mouse.y - args.state.mouse_point_inside_card.y
    elsif args.inputs.mouse.up
      @dragging_card = false
      unless args.geometry.intersect_rect?(@card_under_mouse.serialize, @deck_area)
        if @hand.include? @card_under_mouse
          @hand.delete @card_under_mouse
          @board << @card_under_mouse
        end
      end

      compute_card_positions_in_hand
    end
  end

  def tick args
    @args = args

    draw_hand if args.state.tick_count == 0

    super args
  end
end
