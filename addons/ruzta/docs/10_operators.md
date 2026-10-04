# Operators

Standard arithmetic, comparison, and boolean operators plus postfix `++`/`--`. Ruzta adds compact range syntax (`0..10`, `10..0`) and type membership with `is`/`as`/`in`.

## Arithmetic, comparison, and assignment

The core [operator set](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#operators) is the familiar one: arithmetic, comparisons, boolean logic, compound assignments, and a couple of small mutation shorthands.

```operators.rz
score += 10
ammo--
combo++

var can_dash = stamina > 0 and not exhausted
var same_lane = lane_a == lane_b
var wrapped = turn % 4
```

- Use `+`, `-`, `*`, `/`, and `%` for numeric work.
- Use `==`, `!=`, `<`, `<=`, `>`, and `>=` for comparisons.
- Use `and`, `or`, and `not` for boolean logic.
- Compound assignments such as `+=`, `-=`, `*=`, `/=`, and `%=` keep mutations compact.
- Use postfix `value++` and `value--` as shorthand for `value += 1` and `value -= 1`.
- Treat `++` and `--` like assignment statements: they mutate a target rather than producing a separate expression value.


## Range Syntax

Ruzta supports compact range literals for exclusive bounds, inclusive bounds, reverse iteration, and custom steps without forcing every use through a `range(...)` call.

```range_syntax.rz
print(0..10)
print(0..=10)
print(0..10:2)
print(10..0)
print(10..=0)
print(0..2 + [3, 4])
```

- Use `start..end` for an exclusive upper bound.
- Use `start..=end` when the final value should be included.
- Use `start..end:step` when the stride is not the default `1`.
- When the step is omitted, the direction is inferred from the bounds, so `0..10` uses `1` while `10..0` uses `-1`.
- Negative steps still let you force reverse traversal or larger jumps, such as `10..0:-2`.
- Keep range bounds and steps as bare variables or integer literals; precompute more complex values first.
- Syntax ranges still evaluate to arrays, so array operators such as `+` continue to work on them.

## Type and membership operators

A few operators matter especially often in script code: `is`, `as`, and `in`.

```type_ops.rz
if target is Node2D:
	print(target.position)

var named_target := target as Node

if "dash" in abilities:
	print("dash ready")
```

- Use `is` for runtime type checks before touching object members or narrowing a dynamic value.
- Use `as` when a typed conversion is intentional and should be visible in the code.
- Use `in` to test whether a value exists in an array, string, or other container-like type.
