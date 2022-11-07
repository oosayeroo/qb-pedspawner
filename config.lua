Config = {}
Config.TargetName = 'qb-target'

-- 3 example peds set up for you already 
-- you do not need target stuff on any ped you dont want it on. just simply do not add the target = true and you wont need any of the other options. 
--Relationship Groups
AddRelationshipGroup("HAVEN") --custom group i added for example feel free to change it or remove it

--Relationships Between Groups
SetRelationshipBetweenGroups(3, "HAVEN", "PLAYER") --makes that group like the player(will attack if provoked)
SetRelationshipBetweenGroups(0, "HAVEN", "HAVEN") --makes the same group not attack each other

Config.Peds = {
{ 
  Model="s_m_m_marine_01", 
  x=-416.11, y=1170.26, z=325.85, a=352.74, 
  AnimDict=nil, 
  AnimName=nil,
  IgnoreEvents=false,
  Male=true,
  Soldier=true,
  PatrolArea=true,
  Radius=100,
  WalkBeforeRest=25,
  RestBreak=10,
  SightRange=100,
  HearRange=100,
  Accuracy=100,
  GiveArmour=true,
  ArmourAmount=200,
  Armed=true,
  Weapon='weapon_pistol',
  AmmoCount=999,
  Relationship="HAVEN",
	God=false,
  Target=true,
  JobLocked=true,
  Job = {
    ["police"] = 0,
    ["ambulance"] = 0,
  },
  Event='example:example',
  Type='client',
  Icon='fas fa-cannabis',
  Label='test',
  Distance=2.0
},
  
{
  Model="s_f_y_cop_01",
  x=-390.6, y=1163.44, z=329.59, a=277.14,
  AnimDict=nil,
  AnimName=nil,
  IgnoreEvents=false,
  Male=false,
  Soldier=true,
  Armed=true,
  Weapon='weapon_combatpdw',
  AmmoCount=100,
  Relationship="HAVEN",
  God=true,
  CustomHealth=true,
  HealthAmount=200,
  Target=true,
  GangLocked=true,
  Gang='ballas',
  Event='example:example',
  Type='client',
  Icon='fas fa-burger',
  Label='food',
  Distance=2.0
},
  
{
  Model="s_m_y_cop_01",
  x=-383.79, y=1187.7, z=329.38, a=248.87,
  AnimDict=nil,
  AnimName=nil,
  IgnoreEvents=false,
  Male=true,
  Soldier=true,
  Armed=true,
  EnableBlip=true,
  BlipSprite=16,
  BlipColour=2,
  BlipScale=0.8,
  BlipName='test',
  Weapon='weapon_militaryrifle',
  AmmoCount=250,
  Relationship="HAVEN",
  God=true,
  Target=true,
  Event='example:example',
  Type='client',
  Icon='fas fa-burger',
  Label='food',
  Distance=2.0
},

{
  Model="s_m_y_cop_01",
  x=-1901.51, y=2015.32, z=141.07, a=265.03,
  AnimDict=nil,
  AnimName=nil,
  Male=true,
  EnableBlip=true,
  BlipSprite=72,
  BlipColour=1,
  BlipScale=0.8,
  BlipName='test2',
  Relationship="HAVEN",
  God=true
},
  
}
