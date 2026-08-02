# Builtin Functions

Ruzta has access to Godot's standard builtins: `print`, `len`, `str`, `typeof`, `range`, `preload`, `load`, and more from `@GlobalScope`.

## Everyday builtins

Ruzta scripts have access to the usual Godot globals plus script-level helpers. In practice, that means you already have a large toolkit available before writing any utility class of your own.

```builtins_everyday.rz
func _ready() -> void:
	assert(len("ruzta") == 5)
	print(typeof(3.5))
	print(char(65))
	print(ord("A"))
```

- Use `print`, `prints`, and `printerr` for output.
- Use `len`, `str`, `int`, `float`, and `typeof` for basic conversions and inspection.
- Use `range` constantly in loops and `assert` when you want a development-time correctness check.
- Use `char` and `ord` when you need character/code point conversions.

## Loading, debugging, and runtime helpers

A second group of builtins covers resource loading, stack inspection, and dynamic type checks. These are the helpers you reach for when wiring projects together or debugging script behavior.

```builtins_runtime.rz
const HUD_SCENE = preload("res://ui/hud.tscn")

func spawn_hud(scene_path: String) -> void:
	var hud_scene = load(scene_path)
	print_debug(hud_scene)
	print(is_instance_of(HUD_SCENE, TYPE_OBJECT))
```

- Use `preload` for constant asset references known at parse time and `load` for dynamic paths chosen at runtime.
- Use `print_debug`, `print_stack`, and `get_stack` when a regular `print` is not enough.
- Use `is_instance_of` when the type you want to compare against is itself dynamic.
- Remember that many engine-wide constants and helpers come from `@GlobalScope`, not only the script helper set.