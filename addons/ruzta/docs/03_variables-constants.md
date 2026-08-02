# Variables and Constants

Use `var` for mutable state and `const` for immutable values. Ruzta supports static variables and type inference with `:=`.

## Declaring values

```values.rz
const DEFAULT_SPEED := 240.0
const ENEMY_SCENE = preload("res://enemy.tscn")

var health := 5
var title: String = "Scout"
var active := true
```

- Use `=` when you want a simple assignment and `:=` when you want [inference](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/static_typing.html) from the initializer.

## Scope and static state

Ruzta also supports `static var` and `static func` for data or helpers that belong to the class itself instead of an instance.

```static_values.rz
static var spawned_count := 0

var nickname := "unit"

func _init() -> void:
	spawned_count += 1

static func get_spawned_count() -> int:
	return spawned_count
```
