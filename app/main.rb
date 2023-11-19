require "app/requirements"

def tick args
  args.state.scenes ||= { main_menu: MainMenuScene.new(args), solitaire: SolitaireScene.new(args) }
  args.state.scene_manager ||= SceneManager.new(args.state.scenes, :main_menu)

  args.state.scene_manager.tick args
end
