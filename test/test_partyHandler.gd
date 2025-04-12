extends GutTest

var PartyHandler = preload("res://scripts/handlers/partyHandler.gd") 
var ph

func before_each() -> void:
	ph = PartyHandler.new()
	add_child(ph)
	await get_tree().process_frame
	
func after_each() -> void:
	ph.queue_free()
	
	
func test_ready() -> void:
	assert_eq(ph._test, 0, "expected 0, got " + str(ph._test))
