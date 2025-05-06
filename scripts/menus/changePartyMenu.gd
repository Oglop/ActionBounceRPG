extends Node2D


@onready var lblAbilities = $Panel/lblAbilities
@onready var lblListAbilities = $Panel2/lblListAbilities
@onready var lblDesc = $Panel/Panel/lblDesc
@onready var selectedOne = $Panel/SelectedPartyMemberOne
@onready var selectedTwo = $Panel/SelectedPartyMemberTwo
@onready var pointer = $Panel/pointer
@onready var tailWizard = $Panel/tailWizard
@onready var tailPooch = $Panel/tailPooch
@onready var tailElf = $Panel/tailelf
@onready var tailThief = $Panel/tailThief
@onready var tailCleric = $Panel/tailCleric
@onready var tailSlotOne = $Panel/tailOne
@onready var tailSlotTwo = $Panel/tailTwo

var s:skills
var selectingSlot:bool = false
var selectingMember:bool = false
var selectingSlotIndex:int = 0
var selectingMemberIndex:int = 0


func _ready() -> void:
	visible = false
	s = skills.new()
	Events.connect("ROOM_CHANGE_PARTY", _on_roomChangePartyMemebers)
	#visible = false
	_upateSlotOne()
	_updateSlotTwo()
	_updateAbilityList()
	_updatePointersAndLabels()
	_setTailIcons()
	
	
func _on_roomChangePartyMemebers() -> void:
	selectingSlotIndex = 0
	selectingMemberIndex = 0
	selectingSlot = true
	_setTailIcons()
	_upateSlotOne()
	_updateSlotTwo()
	_updateAbilityList()
	_updatePointersAndLabels()
	visible = true
	
	
func _physics_process(delta: float) -> void:
	if visible:
		if !selectingSlot && !selectingMember || selectingSlot && selectingMember:
			selectingSlot = true
			selectingMember = false
			
		if selectingMember && Input.is_action_just_pressed("btn_down"):
			if selectingMemberIndex < 4:
				selectingMemberIndex += 1
				_updatePointersAndLabels()
		elif selectingMember && Input.is_action_just_pressed("btn_up"):
			if selectingMemberIndex > 0:
				selectingMemberIndex -= 1
				_updatePointersAndLabels()
		elif selectingMember && Input.is_action_just_pressed("btn_accept"):
			_setSelectedCompanion()
			_setTailIcons()
			_upateSlotOne()
			_updateSlotTwo()
			_updateAbilityList()
			_updatePointersAndLabels()
		elif selectingMember && Input.is_action_just_pressed("btn_jump"):
			selectingSlot = true
			selectingMember = false
			_updatePointersAndLabels()
		
		if selectingSlot && selectingSlotIndex == 0:
			if Input.is_action_just_pressed("btn_right"):
				selectingSlotIndex = 1
				_updatePointersAndLabels()
		elif selectingSlot && selectingSlotIndex == 1:
			if Input.is_action_just_pressed("btn_left"):
				selectingSlotIndex = 0
				_updatePointersAndLabels()
		if selectingSlot && Input.is_action_just_pressed("btn_accept"):
			selectingSlot = false
			selectingMember = true
			_updatePointersAndLabels()
		elif selectingSlot && Input.is_action_just_pressed("btn_jump"):
			selectingSlot = false
			selectingMember = false
			visible = false
			Events.UPDATE_TAIL.emit()
			get_tree().paused = false
			
	
func _updatePointersAndLabels() -> void:
	if selectingSlotIndex == 0:
		if selectingSlot:
			lblDesc.text = "Select first companion."
		selectedOne.play("slot_one_selected")
		selectedTwo.play("slot_two_unselected")
	elif selectingSlotIndex == 1:
		selectedTwo.play("slot_two_selected")
		selectedOne.play("slot_one_unselected")
		if selectingSlot:
			lblDesc.text = "Select second companion."
	
	if selectingMember:
		if selectingMemberIndex == 0:
			pointer.global_position.x = tailWizard.global_position.x - 8
			pointer.global_position.y = tailWizard.global_position.y - 8
			lblDesc.text = Statics.CHARACTER_WIZARD_NAME
		elif selectingMemberIndex == 1:
			pointer.global_position.x = tailPooch.global_position.x - 8
			pointer.global_position.y = tailPooch.global_position.y - 8
			lblDesc.text = Statics.CHARACTER_POOCH_NAME
		elif selectingMemberIndex == 2:
			pointer.global_position.x = tailElf.global_position.x - 8
			pointer.global_position.y = tailElf.global_position.y - 8
			lblDesc.text = Statics.CHARACTER_ELF_NAME
		elif selectingMemberIndex == 3:
			pointer.global_position.x = tailThief.global_position.x - 8
			pointer.global_position.y = tailThief.global_position.y - 8
			lblDesc.text = Statics.CHARACTER_THIEF_NAME
		elif selectingMemberIndex == 4:
			pointer.global_position.x = tailCleric.global_position.x - 8
			pointer.global_position.y = tailCleric.global_position.y - 8
			lblDesc.text = Statics.CHARACTER_CLERIC_NAME
		_updateAbilityList()
		



func _setTailIcons() -> void:
	tailCleric.play("cleric_idle")
	tailElf.play("elf_idle")
	tailPooch.play("pooch_idle")
	tailThief.play("thief_idle")
	tailWizard.play("wizard_idle")
	
	
func _updateAbilityList() -> void:
	var skills:Array = []
	lblListAbilities.text = ""
	
	if s.canPushBlocks:
		skills.append("Push blocks\n")
	if s.canCastFireBalls:
		skills.append("Cast fire\n")
	if s.canFindPathInForest:
		skills.append("Path finding\n")
	if s.canLightUpDarkness:
		skills.append("Use light\n")
	if s.canPickLocks:
		skills.append("Pick locks\n")
	if s.canSeeSpiritDoors:
		skills.append("See magic doors\n")
	if s.canSolveInfinityPuzzle:
		skills.append("Break illusion\n")
	if s.canTalkToAnimals:
		skills.append("Hear animals\n")
	
		
	for n in range(0, 8):
		if n < skills.size():
			lblListAbilities.text += skills[n]
	
	
func _upateSlotOne() -> void:
	if Data.tailNo1Type == Enums.tailType.NONE:
		tailSlotOne.visible = false
		return
	tailSlotOne.visible = true
	tailSlotOne.global_position = selectedOne.global_position
	
	if Data.tailNo1Type == Enums.tailType.WIZARD:
		tailSlotOne.play("wizard_walk")
	elif Data.tailNo1Type == Enums.tailType.POOCH:
		tailSlotOne.play("pooch_walk")
	elif Data.tailNo1Type == Enums.tailType.ELF:
		tailSlotOne.play("elf_walk")
	elif Data.tailNo1Type == Enums.tailType.THIEF:
		tailSlotOne.play("thief_walk")
	elif Data.tailNo1Type == Enums.tailType.CLERIC:
		tailSlotOne.play("cleric_walk")
	
	
func _updateSlotTwo() -> void:
	if Data.tailNo2Type == Enums.tailType.NONE:
		tailSlotTwo.visible = false
		return
	tailSlotTwo.visible = true
	tailSlotTwo.global_position = selectedTwo.global_position
	
	if Data.tailNo2Type == Enums.tailType.WIZARD:
		tailSlotTwo.play("wizard_walk")
	elif Data.tailNo2Type == Enums.tailType.POOCH:
		tailSlotTwo.play("pooch_walk")
	elif Data.tailNo2Type == Enums.tailType.ELF:
		tailSlotTwo.play("elf_walk")
	elif Data.tailNo2Type == Enums.tailType.THIEF:
		tailSlotTwo.play("thief_walk")
	elif Data.tailNo2Type == Enums.tailType.CLERIC:
		tailSlotTwo.play("cleric_walk")
	
	
func _setSelectedCompanion() -> void:
	match selectingMemberIndex:
		0: _updateSelectedSlot(selectingSlotIndex, Enums.tailType.WIZARD)
		1: _updateSelectedSlot(selectingSlotIndex, Enums.tailType.POOCH)
		2: _updateSelectedSlot(selectingSlotIndex, Enums.tailType.ELF)
		3: _updateSelectedSlot(selectingSlotIndex, Enums.tailType.THIEF)
		4: _updateSelectedSlot(selectingSlotIndex, Enums.tailType.CLERIC)
	selectingSlot = false
	selectingMember = false
			

func _updateSelectedSlot(slot:int, type:Enums.tailType) -> void:

	if slot == 0:
		if Data.tailNo1Type == type:
			return
		if Data.tailNo2Type == type:
			Data.tailNo1Type = type
			Events.SPAWN_TAIL.emit(0)
			Data.tailNo2Type = Enums.tailType.NONE
			return
		Data.tailNo1Type = type
	if slot == 1:
		if Data.tailNo2Type == type:
			return
		if Data.tailNo1Type == type:
			Data.tailNo2Type = type
			Data.tailNo1Type = Enums.tailType.NONE
			return
		Data.tailNo2Type = type
		
	Events.SYNC_TAIL.emit()
		
	
