# Functions, Lambdas, and Setters/Getters

Define functions with `func`. Ruzta adds function overloading, named arguments.

## Functions and return values

Define behavior with `func`. Parameters go in parentheses, defaults keep call sites short, and `->` documents the return type when a function produces a value.

```functions.rz
func heal(amount: int = 1) -> void:
	health += amount

func is_alive() -> bool:
	return health > 0
```



## Function overloading

Ruzta allows multiple functions to share one public name as long as their parameter signatures differ. Calls are resolved deterministically by best signature fit, including generic candidates that can infer their type arguments from the call.

```function_overloading.rz
class Tool:
	func _init(id: String) -> void:
		print("string init:", id)

	func _init(id: int) -> void:
		print("int init:", id)

	static func pick(value: int) -> String:
		return "int"

	static func pick(value: String) -> String:
		return "string"

func test() -> void:
	var a := Tool.new("x")
	var b := Tool.new(3)
	print(Tool.call("pick", 7))
	var picker := Tool.pick
	print(picker.call("ok"))
```

- Overloading works for global functions, class methods, static methods, and constructors (`_init`).
- Resolution prefers exact type/shape matches before candidates that require implicit conversion.
- Overloads that differ only by return type are rejected.
- Named arguments are checked per candidate before final overload selection.
- Reflective calls (`call`, `callv`) and callable references dispatch through the same overload rules at runtime.

## Named arguments

Function and method calls can mix positional and named arguments. Positional arguments still bind left to right, while named arguments bind by parameter name.

```named_arguments.rz
func create_user(name: String, age: int, admin: bool = false) -> void:
	print(name, age, admin)

create_user("Xkai", admin: true, age: 22)
create_user(name: "Blue", age: 19)
```

- Write named arguments as `parameter_name: value` inside the call.
- Positional arguments must come first, then named arguments, then any variadic tail values.
- Named arguments can reorder the remaining supplied parameters, which helps at call sites with several same-shaped values.
- Default arguments still follow the usual trailing omission rule, so you cannot skip an earlier parameter and then provide a later one.
- With overloaded functions, named-argument compatibility is checked per overload candidate before type-fit scoring.
- If several overloads remain equally valid after named-argument and type-fit checks, the call is reported as ambiguous.


## Lambdas and callables

Lambdas are inline functions created with `func`. They are useful for short callbacks, custom sort logic, deferred work, and signal handlers that do not deserve a named method.

```lambdas.rz
var announce := func(message: String) -> void:
	print("announce:", message)

var double := func(value: int) -> int:
	return value * 2

announce.call("ready")
print(double.call(4))
```

- Store lambdas in variables or pass them directly where a `Callable` is expected.
- A lambda can declare parameter types and a return type just like a named function.
- Call lambdas with `.call(...)`.


## Setters and getters

[Properties](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html) can expose a computed interface instead of a raw backing field. Inline `get:` and `set(value):` blocks are the clearest form when the logic is small.

```properties.rz
var _speed := 200.0

var speed: float:
	get:
		return _speed
	set(value):
		_speed = maxf(0.0, value)
```

- Use a private backing variable when the property should validate or normalize writes.
- For larger property logic, you can also route through named getter and setter functions.
- Typed properties work the same way as untyped ones.

## Variadic arguments

Ruzta supports variadic parameters with `...args: Array`. Use them when the function really accepts a flexible tail of values.

```variadic.rz
func log_event(name: String, level: int = 0, ...args: Array) -> void:
	prints(name, level, args)

var collector := func(prefix: String, ...args: Array) -> void:
	prints(prefix, args)

log_event("spawn")
log_event("damage", 2, "orc", 15)
collector.call("values", 1, 2, 3)
```

- Keep required parameters first, optional defaults next, and the variadic tail last.
- The collected extra arguments arrive as an array.
- Variadics also work in lambdas, so short forwarding helpers can stay inline.