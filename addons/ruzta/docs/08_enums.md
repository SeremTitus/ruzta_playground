# Enum

Ruzta supports plain enums and payload enums (tagged unions). Payload enums let each case carry different data, with destructuring in `match` patterns.

## Plain named and unnamed enums

Plain enums group related integer constants under a readable name. Use named enums for most public APIs and unnamed enums when you want a few file-local constants without an extra type name.

```enums.rz
enum Direction { LEFT = -1, RIGHT = 1 }
enum { STARTING_LIVES = 3 }

var facing: Direction = Direction.RIGHT
var lives := STARTING_LIVES
```

- A named enum is accessed through its type, such as `Direction.LEFT`.
- Unnamed enum entries are introduced directly into the surrounding scope.
- You can assign explicit numeric values when you need stable save data, wire formats, or editor-facing identifiers.


## Payload enums / tagged unions

If any enum case declares payload, the whole enum becomes a tagged union instead of an int-backed enum. Use this when each case needs to carry different data but you still want one shared enum type.

```payload_enum.rz
enum Message {
	Quit,
	Move(x: int, y: int),
	Write(text: String),
}

func handle_message(msg: Message) -> void:
	if msg is Message.Move(x, y):
		prints("preview move", x, y)

	match msg:
		Message.Quit:
			print("quit")
		Message.Move(x, y):
			prints("move", x, y)
		Message.Write(_):
			print("write")
```

- Construct payload cases like `Message.Move(x: 4, y: 9)` or, for unnamed enums, `Ping(id: 3)` inside the declaring scope.
- Destructure payload with `if value is Message.Move(x, y)` or directly in `match` patterns.
- Use `_` inside a payload pattern when you want to ignore that payload, such as `Message.Write(_)`.
- Payload enums may declare explicit numeric case values and can be cast to `int`, which keeps only the case tag and discards payload.
- A payload enum case pattern must stand on its own branch; do not combine it with `,`-separated alternatives.

## Using enums in typed code

Use enums when a variable should stay inside one finite domain. Plain enums compare like named integer states, while payload enums let each case carry structured data without leaving the enum type.

```enum_usage.rz
enum State { IDLE, RUN, HIT, DOWN }

func set_state(state: State) -> void:
	match state:
		State.IDLE:
			print("idle")
		State.RUN:
			print("run")
		_:
			print("other")
```

- Use enum types for variables, parameters, return values, and dictionary keys when a state machine or finite set is involved.
- Enums work well in `match` expressions because every branch reads like a named state or case instead of a magic number.
- If you inherit or preload scripts, enum members can also be accessed through those script types.