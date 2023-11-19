$gtk.reset

class MainMenuScene < Scene
  attr_accessor :args

  def initialize(args)
    @args = args
    @play_button = Button.new(x: 640, y: 500, w: 300, h: 80, color: Color.new(60, 60, 60, 100),
                              text_color: Color.new(250, 250, 250), text: "Play")

    @play_button.on_mouse_click do |button, args|
      puts "Play!"
      args.state.next_scene = :solitaire
    end

    @settings_button = Button.new(x: 640, y: 400, w: 300, h: 80, color: Color.new(60, 60, 60, 100),
                              text_color: Color.new(250, 250, 250), text: "Settings")
  end

  def render_ui
    args.outputs.background_color = [0, 0, 0]
    super
  end
end
