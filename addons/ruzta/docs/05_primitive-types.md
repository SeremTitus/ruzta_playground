# Primitive Types

Ruzta uses Godot's standard types: `bool`, `int`, `float`, `String`, `StringName`, `NodePath`, and math types like `Vector2`. Use `is` for type checks and `as` for casts.

## Core value types

```primitive_values.rz
var retries: int = 3
var cooldown: float = 0.35
var label: String = "Ruzta"
var enemy_name: StringName = &"Enemy"
var camera_path: NodePath = ^"Player/Camera2D"
var position_2d := Vector2(16, 32)
```

- `bool`, `int`, and `float` cover most gameplay flags, counters, timers, and movement values.
- `String` is the everyday text type; `StringName` is useful for identifiers, property names, and other interned keys.
- `NodePath` is the typed representation behind scene paths, and math/value structs such as `Vector2`, `Vector3`, `Color`, and `Transform3D` work the same way as in [GDScript](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html).
- `null` is valid for `Variant` and object-like references where an empty value makes sense.

## Casts and type checks

Use `is` when you want to test a value's runtime type and `as` when you want to cast it into a more specific type. See the [static typing guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/static_typing.html) for details.

```casts.rz
func describe(value: Variant) -> void:
	if value is int:
		print("int:", value)
	elif value is String:
		print("string:", value)

	var amount := value as int
```

- Use `is` in guards before touching members on dynamic values.
- Use `as` when the conversion is intentional and should produce a typed result.
- Typed arrays and dictionaries can also participate in type tests such as `value is Array[int]`.