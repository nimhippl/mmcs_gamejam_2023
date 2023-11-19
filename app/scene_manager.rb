$gtk.reset

class SceneManager
  def initialize(scenes, starting_scene)
    @scenes = scenes
    @current_scene = @scenes[starting_scene]
  end

  def tick args
    @current_scene.tick args

    next_scene = args.state.next_scene

    return if next_scene.nil?

    return unless @scenes.include?(next_scene)

    @current_scene = @scenes[next_scene]
  end
end
