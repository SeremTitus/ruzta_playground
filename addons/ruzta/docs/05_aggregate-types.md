# Aggregate Types

Ruzta supports typed `Array`, typed `Dictionary`, and new `tuple` types. Tuples are fixed-size values with named or positional fields, destructuring, and match patterns.

## Array

Arrays are [ordered collections](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_advanced.html#arrays). Use them for sequences, inventories, waypoints, batched events, or any other list-shaped data.

```arrays.rz
var checkpoints: Array[Vector2] = [Vector2.ZERO, Vector2(64, 0)]

checkpoints.append(Vector2(128, 0))

for point in checkpoints:
	print(point)
```

- Untyped arrays are flexible and useful for quick gameplay scripting or dynamic data.
- Typed arrays such as `Array[int]` or `Array[Enemy]` give stronger editor help and earlier errors.
- When the element type is a class or script, compatible subclasses are valid elements too, so `Array[Enemy]` can store `BossEnemy` instances.
- Nested typed arrays are supported, for example `Array[Array[int]]`.
- Loop arrays directly with `for item in items:` or by index when you need positional access.


## Dictionary

[Dictionaries](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_advanced.html#dictionaries) store key-value pairs. Use them for named stats, lookup tables, metadata blobs, and other record-like structures where labels matter more than order.

```dictionary.rz
var stats: Dictionary[String, int] = {
	"hp": 8,
	"mp": 3,
}

stats["hp"] += 1

for key: String in stats:
	print("%s = %d" % [key, stats[key]])
```

- Untyped dictionaries are convenient for quick configuration data and deserialized content.
- Typed dictionaries such as `Dictionary[String, int]` or `Dictionary[int, LootDrop]` are better when a shape is expected.
- When keys or values are typed as classes or scripts, compatible subclasses are valid too, including subclass instances used as dictionary keys.
- Nested typed dictionaries and mixed nested containers are supported, for example `Dictionary[String, Array[int]]`.
- Iterating a dictionary yields keys; use those keys to read or update the stored values.

## Tuple

Tuples are fixed-size aggregate values. You can declare named tuple types with `tuple Name(...)`, create unnamed tuple literals with `(a, b)`, access elements by index (`.0`) or field name (`.name`), and destructure values into local bindings.

```tuples.rz
tuple Player(
	name: String,
	hp: int,
	alive: bool
)

tuple Vec2(
	x: float,
	y: float
)

func get_data() -> (String, int):
	return ("Coins", 50)

func test() -> void:
	var a := Vec2(10.0, 20.0)
	var b := Vec2(x: 2.0, y: 3.0)
	print(a.0, a.1)
	print(b.x, b.y)

	var pos: (int, int) = (10, 20)
	var (x, y) = pos
	print(x, y)

	match pos:
		(0, var any_y):
			print("x is zero", any_y)
		(var any_x, 0):
			print("y is zero", any_x)
		(var any_x, var any_y):
			print(any_x, any_y)
```

- Declare tuple types with named, unnamed, or mixed fields: `tuple Vec2(x: float, y: float)` and `tuple Player(name: String, int, bool)` are both valid.
- Tuple literals use parentheses with commas: `(10, 20)`; single parentheses without a comma remain expression grouping.
- Use tuple type annotations in variables and return types, for example `var pos: (int, int)` and `func get_data() -> (String, int)`.
- Destructure declarations with `var (x, y) = pos` or `const (name, hp) = get_player()`.
- Tuple index access works on all tuples (`value.0`, `value.1`), while named access (`value.x`) works only on tuple types that declare those names.
- Tuple values can nest naturally, participate in `match` tuple patterns, and follow constant immutability rules (`const pos = (10, 20)` rejects `pos.0 = 5`).

### References

- [zen-c style tuple](https://docs.zenc-lang.org/tour/03-aggregate-types) :: tuple
