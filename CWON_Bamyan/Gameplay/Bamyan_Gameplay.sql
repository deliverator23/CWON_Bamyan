
INSERT INTO Types (Type, Kind) VALUES ('BUILDING_BAMYAN', 'KIND_BUILDING');

INSERT INTO Buildings (BuildingType, Name, Description, PrereqTech, Cost, AdvisorType, MaxWorldInstances, IsWonder, RequiresPlacement, Quote, AdjacentToMountain)
VALUES ('BUILDING_BAMYAN', 'LOC_BUILDING_BAMYAN_NAME', 'LOC_BUILDING_BAMYAN_DESCRIPTION', 'TECH_CURRENCY', 710, 'ADVISOR_CULTURE', '1', 1, 1, 'LOC_BUILDING_BAMYAN_QUOTE', 1);


INSERT INTO Building_ValidTerrains (BuildingType, TerrainType)
VALUES
  (
    'BUILDING_BAMYAN', 'TERRAIN_GRASS'
  ),
  (
    'BUILDING_BAMYAN', 'TERRAIN_PLAINS'
  ),
  (
    'BUILDING_BAMYAN', 'TERRAIN_DESERT'
  );

-- 2 Culture, 1 Gold.
INSERT INTO Building_YieldChanges (
  BuildingType, YieldType, YieldChange
)
VALUES
  ('BUILDING_BAMYAN', 'YIELD_CULTURE',2),
  ('BUILDING_BAMYAN', 'YIELD_GOLD',1);


-- +1 Faith yield for every International Trade Route.
-- Other Civilizations' Trade Routes to this Player grants both the Player +1 Faith and other Civilization +1 Faith.

INSERT INTO Modifiers
		(ModifierId,									ModifierType)
VALUES	('BAMYAN_INTERNATIONAL_TRADE_FAITH',	'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES ('BAMYAN_INTERNATIONAL_TRADE_FAITH', 'YieldType', 'YIELD_FAITH');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES ('BAMYAN_INTERNATIONAL_TRADE_FAITH', 'Amount', 1);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES ('BAMYAN_INTERNATIONAL_TRADE_FAITH', 'Intercontinental', 0);

INSERT INTO Modifiers
		(ModifierId,									ModifierType)
VALUES	('BAMYAN_INCOMING_TRADE_GAIN_FAITH',	'MODIFIER_PLAYER_CITIES_ADJUST_TRADE_ROUTE_YIELD_FROM_OTHERS');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES ('BAMYAN_INCOMING_TRADE_GAIN_FAITH', 'YieldType', 'YIELD_FAITH');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES ('BAMYAN_INCOMING_TRADE_GAIN_FAITH', 'Amount', 1);

INSERT INTO Modifiers
		(ModifierId,									ModifierType)
VALUES	('BAMYAN_INCOMING_TRADE_OFFER_FAITH',	'MODIFIER_PLAYER_CITIES_ADJUST_TRADE_ROUTE_YIELD_TO_OTHERS');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES ('BAMYAN_INCOMING_TRADE_OFFER_FAITH', 'YieldType', 'YIELD_FAITH');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES ('BAMYAN_INCOMING_TRADE_OFFER_FAITH', 'Amount', 1);

INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES ('BUILDING_BAMYAN', 'BAMYAN_INTERNATIONAL_TRADE_FAITH');
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES ('BUILDING_BAMYAN', 'BAMYAN_INCOMING_TRADE_GAIN_FAITH');
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES ('BUILDING_BAMYAN', 'BAMYAN_INCOMING_TRADE_OFFER_FAITH');


-- Farms and Pastures within 6 tiles yield +1 Faith
INSERT INTO Requirements
		(RequirementId,								RequirementType)
VALUES	('REQUIRES_PLOT_HAS_BAMYAN_WITHIN_X',	'REQUIREMENT_PLOT_ADJACENT_BUILDING_TYPE_MATCHES');

INSERT INTO RequirementArguments
		(RequirementId,								Name,			Value)
VALUES	('REQUIRES_PLOT_HAS_BAMYAN_WITHIN_X',	'BuildingType',	'BUILDING_BAMYAN'),
		('REQUIRES_PLOT_HAS_BAMYAN_WITHIN_X',	'MaxRange',		6),
		('REQUIRES_PLOT_HAS_BAMYAN_WITHIN_X',	'MinRange',		0);

INSERT INTO RequirementSets
		(RequirementSetId,						RequirementSetType)
VALUES	('BAMYAN_HAS_PASTURE_REQUIREMENTS',	'REQUIREMENTSET_TEST_ALL'),
        ('BAMYAN_HAS_FARM_REQUIREMENTS',	'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements
		(RequirementSetId,						RequirementId)
VALUES	('BAMYAN_HAS_PASTURE_REQUIREMENTS',	'REQUIRES_PLOT_HAS_BAMYAN_WITHIN_X'),
        ('BAMYAN_HAS_PASTURE_REQUIREMENTS',	'REQUIRES_PLOT_HAS_PASTURE'),
       	('BAMYAN_HAS_FARM_REQUIREMENTS',	'REQUIRES_PLOT_HAS_BAMYAN_WITHIN_X'),
        ('BAMYAN_HAS_FARM_REQUIREMENTS',	'REQUIRES_PLOT_HAS_FARM');

INSERT INTO Modifiers
		(ModifierId,									ModifierType,										SubjectRequirementSetId)
VALUES	('BAMYAN_INCREASED_PASTURE_FAITH',	'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',	'BAMYAN_HAS_PASTURE_REQUIREMENTS'),
        ('BAMYAN_INCREASED_FARM_FAITH',	'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',	'BAMYAN_HAS_FARM_REQUIREMENTS');

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES ('BAMYAN_INCREASED_PASTURE_FAITH', 'YieldType', 'YIELD_FAITH');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES ('BAMYAN_INCREASED_PASTURE_FAITH', 'Amount', '1');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES ('BAMYAN_INCREASED_FARM_FAITH', 'YieldType', 'YIELD_FAITH');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES ('BAMYAN_INCREASED_FARM_FAITH', 'Amount', '1');

INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES ('BUILDING_BAMYAN', 'BAMYAN_INCREASED_PASTURE_FAITH');
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES ('BUILDING_BAMYAN', 'BAMYAN_INCREASED_FARM_FAITH');


-- Provides 2 Relic Slots.
INSERT INTO Building_GreatWorks (
  BuildingType, GreatWorkSlotType, NumSlots
)
VALUES
  (
    'BUILDING_BAMYAN', 'GREATWORKSLOT_RELIC', 2
  );


-- Grants 1 Free Relic.
INSERT INTO Modifiers
		(ModifierId,									ModifierType, RunOnce, Permanent)
VALUES	('BAMYAN_GRANT_RELIC',	'MODIFIER_PLAYER_GRANT_RELIC', 1, 1);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES ('BAMYAN_GRANT_RELIC', 'Amount', '1');

INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES ('BUILDING_BAMYAN', 'BAMYAN_GRANT_RELIC');
