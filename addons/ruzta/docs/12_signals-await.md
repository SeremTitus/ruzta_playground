# Signals and Concurrency

Declare signals with `signal`, connect with `connect()`, emit with `emit()`. Use `await` for async flow control with signals and coroutines.

## Signals

[Signals](https://docs.godotengine.org/en/stable/classes/class_signal.html#signal) decouple systems cleanly. Declare with `signal`, connect with `connect()`, and emit with `emit()`.

```signals.rz
signal collected(item_name, amount)

func _ready() -> void:
	collected.connect(_on_collected)

func pickup(name: String, amount: int) -> void:
	collected.emit(name, amount)

func _on_collected(item_name: String, amount: int) -> void:
	print(item_name, amount)
```

- Custom signals are great for UI updates, combat events, scene transitions, and gameplay milestones.
- A signal can declare parameters, which makes the payload contract explicit.
- Typed signal parameters also drive editor help for `emit(...)` calls and typed `connect(...)` handlers.
- You can connect a named method or an inline lambda depending on how much logic the handler needs.

## Typed signal emit and connect checks

When a `Signal` type has a known signature, the editor validates `emit(...)` arguments and `connect(...)` callables against that signal shape.

```typed_signals.rz
signal announced(value: int, ignored: String)

func _ready() -> void:
	var handler: Callable = func(value: int) -> void:
		print("lambda:", value)

	announced.connect(handler.unbind(1))
	announced.connect(_on_tagged.bind("ui"))

	var forwarded := Signal(self, "announced")
	forwarded.emit(3, "drop")

func _on_tagged(value: int, _ignored: String, tag: String) -> void:
	print(tag, value)
```

- Typed `signal name(value: Type, ...)` declarations drive argument checking for `signal.emit(...)`.
- The same typed signal metadata flows through `Signal(self, "name")` when the signal name is statically known.
- Typed `connect(...)` checks apply to named methods, typed lambdas stored in `Callable` variables, and `Callable.bind(...)` or `Callable.unbind(...)` chains when the callable shape is still knowable.
- These are editor-time checks. Runtime signal behavior and legacy string-based signal APIs stay unchanged.

## Await and asynchronous flow

Use `await` to suspend a function until a signal or coroutine result is ready. This keeps async scene logic readable without manually threading state through callbacks.

```await.rz
signal finished(result)

func _ready() -> void:
	call_deferred("emit_finished")
	var result = await finished
	print(result)

func emit_finished() -> void:
	finished.emit("done")
```

- Await a signal directly with `await some_signal`.