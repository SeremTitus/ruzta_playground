# Style Reference

Follow GDScript conventions: `snake_case` for variables/functions, `PascalCase` for classes, `CONSTANT_CASE` for constants. 

## Formatting and naming

Ruzta reads best when it follows the same clear, conservative style that Godot recommends for GDScript: strong naming, one clear statement per line, and indentation that makes control flow obvious.

```style.rz
const MAX_SPEED = 400.0

@export var move_speed := 220.0

func apply_damage(amount: int) -> void:
	if amount <= 0:
		return

	health -= amount
```

- Use tabs for indentation and keep block depth visually clean.
- Use `snake_case` for variables and functions.
- Use `PascalCase` for classes, traits, namespace  and `CONSTANT_CASE` for constants.
- Use traits to keep code DRY (Don't Repeat Yourself)
- Use Tuple to hold data.