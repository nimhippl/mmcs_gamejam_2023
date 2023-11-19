# Theme

Game Jam theme is "Fractal Gameplay"

# Development guidelines

- If you work on a sub module like Solitaire(Memo/Tetramino) minigame, please place files specific to this minigame in a separate folder
- You should require all your needed files in requirements.rb
- If you want DR to life reload on update to a specific file, write on top of a file:

```ruby
$gtk.reset
```
