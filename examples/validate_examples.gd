extends SceneTree
## Headless validator for every example in res://examples.
##
## Usage:
##   godot --headless --path . --script res://examples/validate_examples.gd
##
## For each registry entry it checks that the template exists, that
## RuztaLanguage reports no validation errors (twice, using a real .rz path
## like the playground does) and that the script loads and runs as a Node.

const VERIFY_DIR := "user://validate_examples/"
const REGISTRY_PATH := "res://examples/registry.rz"

var error_count := 0
var run_count := 0
var load_fail := 0

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	_prepare_dir()
	var registry = load(REGISTRY_PATH)
	if registry == null:
		print("FAIL: cannot load ", REGISTRY_PATH)
		quit(1)
		return
	var groups: Array = registry.GROUPS
	var total := 0
	for group: Dictionary in groups:
		var examples: Array = group.get("examples", [])
		for example: Dictionary in examples:
			total += 1
			await _check_example(str(example.get("label", "")), str(example.get("path", "")))
	_cleanup()
	print("VALIDATE total=%d errors=%d ran=%d load_fail=%d" % [total, error_count, run_count, load_fail])
	if error_count == 0 and run_count == total:
		print("ALL EXAMPLES OK")
	quit(0 if error_count == 0 else 1)

func _check_example(label: String, path: String) -> void:
	var f := FileAccess.open(path, FileAccess.READ)
	if f == null:
		print("ERR_MISSING ", path)
		error_count += 1
		return
	var code: String = f.get_as_text()
	f.close()

	var target := VERIFY_DIR + label + ".rz"
	var w := FileAccess.open(target, FileAccess.WRITE)
	if w == null:
		print("ERR_WRITE ", target)
		error_count += 1
		return
	w.store_string(code)
	w.close()

	for pass_index in [0, 1]:
		var res: Dictionary = RuztaLanguage.validate(code, target, true, true, true, true)
		var errs: Array = res.get("errors", [])
		if errs.size() > 0:
			error_count += 1
			var parts := PackedStringArray()
			for e: Dictionary in errs:
				parts.append("L%s: %s" % [str(e.get("line", "?")), str(e.get("message", ""))])
			print("ERR [", label, "] pass", pass_index, " -> ", " ; ".join(parts))
			return

	var script = load(target)
	if script == null:
		print("ERR_LOAD ", label)
		error_count += 1
		load_fail += 1
		return
	var node = script.new()
	if node == null or not (node is Node):
		print("ERR_NOT_NODE ", label)
		error_count += 1
		return
	print("RUN ", label)
	root.add_child(node)
	await process_frame
	await process_frame
	node.queue_free()
	await process_frame
	run_count += 1

func _prepare_dir() -> void:
	if not DirAccess.dir_exists_absolute(VERIFY_DIR):
		DirAccess.make_dir_recursive_absolute(VERIFY_DIR)
	var dir := DirAccess.open(VERIFY_DIR)
	if dir == null:
		return
	dir.list_dir_begin()
	while true:
		var n := dir.get_next()
		if n == "":
			break
		if not n.begins_with("."):
			DirAccess.remove_absolute(VERIFY_DIR.path_join(n))
	dir.list_dir_end()

func _cleanup() -> void:
	_prepare_dir()
	DirAccess.remove_absolute(VERIFY_DIR)
