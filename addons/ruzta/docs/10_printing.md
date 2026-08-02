# Printing and String Formatting

Use `print`, `prints`, and `printerr` for output. Supports percent-style string formatting (`%d`, `%s`, `%02f`) for debug messages and status text.

## Console output and formatted strings

```printing.rz
print("ready:", player_name)
prints("spawn", wave, position)
printerr("Missing save file")

var hp_label = "HP %03d / %03d" % [health, max_health]
var time_label = "Time %.02f" % elapsed
print(hp_label)
print(time_label)
```

- Use `print` for general logging and `printerr` when you want the message to stand out as a problem.
- Use `prints` when you want several values separated cleanly without building a string first.
- Use the `%` formatter for width, padding, decimal precision, and multi-value templating.
- Prefer readable format strings over long chains of concatenation when building debug messages.

### References

- [Format strings](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_format_string.html) :: Percent-based string formatting reference