extends Node
class_name enemyStatsBase

func getMaxHp(type:Enums.enemyType) -> int:
	return Data.enemyData[Enums.enemyTypeToString(type)]["hp"]

	
func getToughness(type:Enums.enemyType) -> int:
	return Data.enemyData[Enums.enemyTypeToString(type)]["toughness"]
		
func getAttack(type:Enums.enemyType) -> int:
	return Data.enemyData[Enums.enemyTypeToString(type)]["attack"]

func getArmor(type:Enums.enemyType) -> int:
	return Data.enemyData[Enums.enemyTypeToString(type)]["armor"]
	
func getXpGain(type:Enums.enemyType) -> int:
	return Data.enemyData[Enums.enemyTypeToString(type)]["xp"]
		
func getCrownsGain(type:Enums.enemyType) -> int:
	return Data.enemyData[Enums.enemyTypeToString(type)]["crowns"]
		
func getHurtBlock(type:Enums.enemyType) -> float:
	return Data.enemyData[Enums.enemyTypeToString(type)]["hurt-block"]
	
func getDefaultState(type:Enums.enemyType) -> float:
	return Data.enemyData[Enums.enemyTypeToString(type)]["default-state"]
	
func getNextStateBounce(type:Enums.enemyType) -> String:
	match type:
		Enums.enemyType.JELLY: return Statics.STATE_ENEMY_WALK
		_: return Statics.STATE_ENEMY_WALK
	
