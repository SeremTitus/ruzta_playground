# Generics

Use `@generic(T)` on classes and functions for type parameterization. Supports constraints (`@generic(T: Node)`), multiple type parameters, and inference from call sites.

## Generic classes, functions, and constraints

```generics.rz
@generic(T)
class Box:
	var value: T

	func _init(v: T):
		value = v

	func get_value() -> T:
		return value

@generic(T)
func identity(value: T) -> T:
	return value

@generic(K, V)
func pick(values: Dictionary[K, V], key: K) -> V:
	return values[key]

@generic(T)
func dup(value: T) -> (T, T):
	return (value, value)

@generic(T: Node)
func child_as(parent: Node, index: int) -> T:
	return parent.get_child(index) as T

func test() -> void:
	var int_box := Box<int>.new(10)
	var str_box := Box<String>.new("hello")
	print(int_box.get_value(), str_box.get_value())
	print(identity(10), identity<int>(5), identity<String>("ok"))
	var stats: Dictionary[String, int] = { "hp": 9 }
	print(pick<String, int>(stats, "hp"))
	var pair: (int, int) = dup<int>(2)
	print(pair.0, pair.1)
```

- Use `@generic(T)` on classes and call them as `Box<int>.new(...)` or `Box<String>.new(...)`.
- Use `@generic(T)` on functions and call with explicit type arguments such as `identity<int>(10)`, or let the call infer them with `identity(10)` when the arguments provide enough information.
- Explicit type arguments always take priority over inference, so `identity<int>(10)` stays deterministic even when the call site could be inferred.
- Use multiple type parameters: `@generic(K, V)` then `Dictionary[K, V]` and calls like `pick<String, int>(...)`.
- Use constraints with `@generic(T: Node)` to require a base class or subtype.
- Generic parameters are valid inside aggregate annotations like `Array[T]`, `Dictionary[K, V]`, and tuple returns like `(T, T)`.
