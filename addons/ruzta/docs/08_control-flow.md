# Control Flow

Standard `if`/`elif`/`else`, `for`/`while` loops, `match` with pattern matching and guards, plus `break`/`continue`/`return`/`pass`.

## Conditionals

Use `if`/`elif`/`else` for branching, with an inline ternary form for compact value selection.

```conditionals.rz
if health <= 0:
	state = "down"
elif sprinting:
	state = "run"
else:
	state = "idle"

var banner = "danger" if health < 3 else "safe"
```

- Reach for `if` blocks when each branch performs multiple actions.
- Use the inline `a if condition else b` form when you only need to pick one value.

## Pattern matching

Use `match` when the branching logic is state-based or pattern-based. It reads better than a long `if` chain once values, destructuring, or guards are involved.

```match.rz
match state:
	"idle":
		print("standing")
	"run":
		print("moving")
	var current when current.begins_with("attack"):
		print("combat")
	_:
		print("unknown")
```

- Use `_` as the fallback pattern.
- Pattern guards with `when` let you refine a matching branch without leaving the `match` block.
- Arrays and other structured values can be matched destructively, including variable binds inside the pattern.

## Loops

Use `for` when iterating a range or iterable value and `while` when the stop condition depends on state that changes inside the loop.

```loops.rz
for index in 0..=3:
	print(index)

for action in ["jump", "dash", "roll"]:
	print(action)

while energy > 0:
	energy -= 1
```

- Loop arrays, strings, dictionaries, and custom iterables with `for item in value:`.
- Use `range(start, end, step)` when you need index-style iteration.
- Use range syntax when you want the compact loop form: `start..end`, `start..=end`, or `start..end:step`.
- When the step is omitted, the direction is inferred from the bounds, so `10..0` walks backward automatically.
- A dictionary loop yields keys, not key-value tuples.
- Keep `while` loops tight and make the exit condition obvious so they do not turn into hidden infinite loops.
