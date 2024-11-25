local M = {}
log('I', 'ppanlocalization', "Loading Locale Data")

local NO_LOCALE = "暂无翻译"

local LOCALE_KEYWORDS_MATCHING = { -- keyword matching to reduce translation workload?
  ["Front Left"] = "左前",
  ["Front Right"] = "右前",
  ["Rear Left"] = "左后",
  ["Rear Right"] = "右后",
  ["Front"] = "前",
  ["Rear"] = "后",
  ["Left"] = "左",
  ["Right"] = "右",

  ["Stock"] = "原厂",
  ["Base"] = "标准",
  ["Lifted"] = "抬升",
  ["Medium Duty"] = "",
  ["Heavy Duty"] = "重工",
  ["Super Heavy Duty"] = "超重工",
  ["Ultra Heavy Duty"] = "极重工",
  ["Sport"] = "运动",
  ["Race"] = "赛用",
  ["Performance"] = "性能",
  ["High Performance"] = "高性能",
  ["Stage 1"] = "一阶",
  ["Stage 2"] = "二阶",
  ["Stage 3"] = "三阶",

  ["Chorme"] = "镀铬",
  ["Black"] = "黑",
  ["Body Colored"] = "车漆",
  ["Primary"] = "油漆1",
  ["Secondary"] = "油漆2",
  ["Tertiary"] = "油漆3",
}

local LOCALIZATION_SLOT_ID = {
  ["licenseplate_design_2_1"] = "车牌风格",
  ["paint_design"] = "涂装",
  ["bx_body"] = "车身",
  ["bx_ABS"] = "防抱死系统",
  ["bx_fueltank"] = "油箱",
  ["bx_rollcage"] = "防滚架",
  ["bx_roof_accessory_hatch"] = "车顶配件",
  ["bx_sideskirt_L"] = "左侧裙",
  ["bx_sideskirt_R"] = "右侧裙",
  ["bx_taillight_L_hatch"] = "左尾灯",
  ["bx_taillight_R_hatch"] = "右尾灯",
  ["bx_windshield"] = "挡风玻璃",
  ["bx_trunk_load"] = "后备箱载荷",
  ["bx_bumper_F"] = "前保险杠",
  ["bx_bumper_R"] = "后保险杠",
  ["bx_door_L"] = "左车门",
  ["bx_door_R"] = "右车门",
}

local LOCALIZATION_SLOT_DISPLAYNAME = {
  ["Frame"] = "底盘",
  ["Chassis"] = "车架",
  ["Engine"] = "引擎",
  ["Oil Cooler"] = "油冷器",
  ["Radiator"] = "散热器",
  ["Radiators"] = "散热器",
  ["Radiator Support"] = "散热器固定框",
  ["Fuel Tank"] = "油箱",
  ["Left Fuel Tank"] = "左油箱",
  ["Right Fuel Tank"] = "右油箱",
  ["Anti-Lock Braking System"] = "防抱死系统",
  ["Front Suspension"] = "前悬挂",
  ["Rear Suspension"] = "后悬挂",
  ["Front Springs"] = "前弹簧",
  ["Rear Springs"] = "后弹簧",
  ["Front Shocks"] = "前减震器", -- [TODO] 找名称区别
  ["Rear Shocks"] = "后减震器", -- [TODO] 找名称区别
  ["Front Coilovers"] = "前避震器", -- [TODO] 找名称区别
  ["Rear Coilovers"] = "后避震器", -- [TODO] 找名称区别
  ["Front Struts"] = "前避震器", -- [TODO] 找名称区别
  ["Rear Struts"] = "后避震器", -- [TODO] 找名称区别
  ["Front Sway Bar"] = "前防倾杆",
  ["Rear Sway Bar"] = "后防倾杆",
  ["Front Tires"] = "前轮胎",
  ["Rear Tires"] = "后轮胎",
  ["Front Wheels"] = "前轮毂",
  ["Rear Wheels"] = "后轮毂",
  ["Front Brakes"] = "前刹车",
  ["Rear Brakes"] = "后刹车",

  ["Body"] = "车身",
  ["Left Fender"] = "左翼子板",
  ["Right Fender"] = "右翼子板",
  ["Front Left Fender"] = "左前翼子板",
  ["Front Right Fender"] = "右前翼子板",
  ["Rear Left Fender"] = "左后翼子板",
  ["Rear Right Fender"] = "右后翼子板",
  ["Quarter Panels"] = "后侧围板",
  ["Left Quarter Panel"] = "左后侧围板",
  ["Right Quarter Panel"] = "右后侧围板",
  ["Rear Left Quarter Panel"] = "左后侧围板",
  ["Rear Right Quarter Panel"] = "右后侧围板",
  ["Left Door"] = "左门",
  ["Right Door"] = "右门",
  ["Front Left Door"] = "左前门",
  ["Front Right Door"] = "右前门",
  ["Rear Left Door"] = "左后门",
  ["Rear Right Door"] = "右后门",
  ["Left Door Glass"] = "左门车窗",
  ["Right Door Glass"] = "右门车窗",
  ["Front Left Door Glass"] = "左前门车窗",
  ["Front Right Door Glass"] = "右前门车窗",
  ["Rear Left Door Glass"] = "左后门车窗",
  ["Rear Right Door Glass"] = "右后门车窗",
  ["Left Door Handle"] = "左门把手",
  ["Right Door Handle"] = "右门把手",
  ["Front Left Door Handle"] = "左前门把手",
  ["Front Right Door Handle"] = "右前门把手",
  ["Rear Left Door Handle"] = "左后门把手",
  ["Rear Right Door Handle"] = "右后门把手",
  ["Left Door Panel"] = "左门内饰板",
  ["Right Door Panel"] = "右门内饰板",
  ["Front Left Door Panel"] = "左前门内饰板",
  ["Front Right Door Panel"] = "右前门内饰板",
  ["Rear Left Door Panel"] = "左后门内饰板",
  ["Rear Right Door Panel"] = "右后门内饰板",
  ["Left Mirror"] = "左后视镜",
  ["Right Mirror"] = "右后视镜",
  ["Left Side Skirt"] = "左侧裙",
  ["Right Side Skirt"] = "右侧裙",
  ["Left Headlight"] = "左头灯",
  ["Right Headlight"] = "右头灯",
  ["Left Taillight"] = "左尾灯",
  ["Right Taillight"] = "右尾灯",
  ["Taillights"] = "尾灯",
  ["Front Bumper"] = "前保险杠",
  ["Rear Bumper"] = "后保险杠",
  ["Front Bumper Support"] = "前防撞梁",
  ["Rear Bumper Support"] = "后防撞梁",
  ["Hood"] = "引擎盖",
  ["Trunk"] = "后备箱",
  ["Spoiler"] = "尾翼",
  ["Tailgate"] = "后备箱",
  ["Windshield"] = "挡风玻璃",
  ["Backlight"] = "后窗玻璃",
  
  ["Interior"] = "内饰",
  ["Dashboard"] = "仪表台",
  ["Interior Color"] = "内饰配色",
  ["Steering Wheel"] = "方向盘",
  ["Driver Seat"] = "驾驶员座椅",
  ["Passenger Seat"] = "副驾驶员座椅",
  ["Front Seat"] = "前座",
  ["Front Seats"] = "前座",
  ["Left Seat"] = "左座椅",
  ["Right Seat"] = "右座椅",
  ["Front Left Seat"] = "左前座椅",
  ["Front Right Seat"] = "右前座椅",
  ["Rear Seat"] = "后座",
  ["Rear Seats"] = "后座",
  ["Horn"] = "喇叭",
  
  ["Roll Cage"] = "防滚架",
  ["Roof Accessory"] = "车顶配件",
  ["Left Spotlight"] = "左探照灯",
  ["Right Spotlight"] = "右探照灯",
  ["Snorkel"] = "涉水喉",
  ["Trunk Load"] = "后备箱载荷",
  ["Front Seat Load"] = "前座载荷",
  ["Rear Seat Load"] = "后座载荷",
}

local LOCALIZATION_PART_ID = {
  ["bx_body_coupe"] = "轿跑车身",
  ["bx_body_hatch"] = "掀背车身",
  ["bx_trunk_coupe"] = "后备箱",
  ["bx_ABS"] = "防抱死系统",
  ["bx_fueltank"] = "油箱",
  ["bx_rollcage"] = "防滚架",
  ["bx_roof_accessory_hatch"] = "车顶配件",
  ["bx_sideskirt_L"] = "左侧裙",
  ["bx_sideskirt_R"] = "右侧裙",
  ["bx_taillight_L_hatch"] = "左尾灯",
  ["bx_taillight_R_hatch"] = "右尾灯",
  ["bx_windshield"] = "挡风玻璃",
  ["bx_bumper_F"] = "前保险杠",
  ["bx_bumper_R"] = "后保险杠",
  ["bx_door_L"] = "左车门",
  ["bx_door_R"] = "右车门",
}
local LOCALIZATION_PART_DISPLAYNAME = {
  ["Frame"] = "底盘",
  ["Chassis"] = "车架",
  ["Engine"] = "引擎",
  ["Oil Cooler"] = "油冷器",
  ["Radiator"] = "散热器",
  ["Radiators"] = "散热器",
  ["Radiator Support"] = "散热器固定框",
  ["Fuel Tank"] = "油箱",
  ["Left Fuel Tank"] = "左油箱",
  ["Right Fuel Tank"] = "右油箱",
  ["Anti-Lock Braking System"] = "防抱死系统",
  ["Front Suspension"] = "前悬挂",
  ["Rear Suspension"] = "后悬挂",
  ["Front Springs"] = "前弹簧",
  ["Rear Springs"] = "后弹簧",
  ["Front Shocks"] = "前减震器", -- [TODO] 找名称区别
  ["Rear Shocks"] = "后减震器", -- [TODO] 找名称区别
  ["Front Coilovers"] = "前避震器", -- [TODO] 找名称区别
  ["Rear Coilovers"] = "后避震器", -- [TODO] 找名称区别
  ["Front Struts"] = "前避震器", -- [TODO] 找名称区别
  ["Rear Struts"] = "后避震器", -- [TODO] 找名称区别
  ["Front Sway Bar"] = "前防倾杆",
  ["Rear Sway Bar"] = "后防倾杆",
  ["Front Brakes"] = "前刹车",
  ["Rear Brakes"] = "后刹车",

  ["Body"] = "车身",
  ["Left Fender"] = "左翼子板",
  ["Right Fender"] = "右翼子板",
  ["Front Left Fender"] = "左前翼子板",
  ["Front Right Fender"] = "右前翼子板",
  ["Rear Left Fender"] = "左后翼子板",
  ["Rear Right Fender"] = "右后翼子板",
  ["Quarter Panels"] = "后侧围板",
  ["Left Quarter Panel"] = "左后侧围板",
  ["Right Quarter Panel"] = "右后侧围板",
  ["Rear Left Quarter Panel"] = "左后侧围板",
  ["Rear Right Quarter Panel"] = "右后侧围板",
  ["Left Door"] = "左门",
  ["Right Door"] = "右门",
  ["Front Left Door"] = "左前门",
  ["Front Right Door"] = "右前门",
  ["Rear Left Door"] = "左后门",
  ["Rear Right Door"] = "右后门",
  ["Left Door Glass"] = "左门车窗",
  ["Right Door Glass"] = "右门车窗",
  ["Front Left Door Glass"] = "左前门车窗",
  ["Front Right Door Glass"] = "右前门车窗",
  ["Rear Left Door Glass"] = "左后门车窗",
  ["Rear Right Door Glass"] = "右后门车窗",
  ["Left Door Handle"] = "左门把手",
  ["Right Door Handle"] = "右门把手",
  ["Front Left Door Handle"] = "左前门把手",
  ["Front Right Door Handle"] = "右前门把手",
  ["Rear Left Door Handle"] = "左后门把手",
  ["Rear Right Door Handle"] = "右后门把手",
  ["Left Door Panel"] = "左门内饰板",
  ["Right Door Panel"] = "右门内饰板",
  ["Front Left Door Panel"] = "左前门内饰板",
  ["Front Right Door Panel"] = "右前门内饰板",
  ["Rear Left Door Panel"] = "左后门内饰板",
  ["Rear Right Door Panel"] = "右后门内饰板",
  ["Left Mirror"] = "左后视镜",
  ["Right Mirror"] = "右后视镜",
  ["Left Side Skirt"] = "左侧裙",
  ["Right Side Skirt"] = "右侧裙",
  ["Left Headlight"] = "左头灯",
  ["Right Headlight"] = "右头灯",
  ["Left Taillight"] = "左尾灯",
  ["Right Taillight"] = "右尾灯",
  ["Taillights"] = "尾灯",
  ["Front Bumper"] = "前保险杠",
  ["Rear Bumper"] = "后保险杠",
  ["Front Bumper Support"] = "前防撞梁",
  ["Rear Bumper Support"] = "后防撞梁",
  ["Hood"] = "引擎盖",
  ["Trunk"] = "后备箱",
  ["Tailgate"] = "后备箱",
  ["Spoiler"] = "尾翼",
  ["Windshield"] = "挡风玻璃",
  ["Backlight"] = "后窗玻璃",
  
  ["Interior"] = "内饰",
  ["Dashboard"] = "仪表台",
  ["Interior Color"] = "内饰配色",
  ["Steering Wheel"] = "方向盘",
  ["Driver Seat"] = "驾驶员座椅",
  ["Passenger Seat"] = "副驾驶员座椅",
  ["Front Seat"] = "前座",
  ["Front Seats"] = "前座",
  ["Left Seat"] = "左座椅",
  ["Right Seat"] = "右座椅",
  ["Front Left Seat"] = "左前座椅",
  ["Front Right Seat"] = "右前座椅",
  ["Rear Seat"] = "后座",
  ["Rear Seats"] = "后座",
  ["Horn"] = "喇叭",
  
  ["Roll Cage"] = "防滚架",
  ["Roof Accessory"] = "车顶配件",
  ["Left Spotlight"] = "左探照灯",
  ["Right Spotlight"] = "右探照灯",
  ["Snorkel"] = "涉水喉",
}

local function getSlotLocale(slotID, displayName)
  return LOCALIZATION_SLOT_ID[slotID] or LOCALIZATION_SLOT_DISPLAYNAME[displayName] --[[ or NO_LOCALE ]] or displayName
end

local function getPartLocale(partID, displayName)
  return LOCALIZATION_PART_ID[partID] or LOCALIZATION_PART_DISPLAYNAME[displayName] --[[ or NO_LOCALE ]] or displayName
end



M.getSlotLocale = getSlotLocale
M.getPartLocale = getPartLocale

return M