local mod = get_mod("danger_zone")
local version = "1.1.1"
local utils = mod:io_dofile("danger_zone/scripts/mods/danger_zone/utils")
local init_loc = {
	mod_name = {
		["en"] = "Danger Zone",
		["zh-cn"] = "危险区域",
		["ru"] = "Опасная зона",
	},
	mod_description = {
		["en"] = "Shows the range for area of effect hazards like fire and explosions. Version: " .. version,
		["zh-cn"] = "显示火焰、爆炸等危险区域的范围。版本：" .. version,
		["ru"] = "Danger Zone - Показывает радиусы опасных зон, таких как огонь и взрывы. Версия:" .. version,
	},

	area_effects_group = {
		["en"] = "Area Effect Outlines",
		["zh-cn"] = "区域效果轮廓",
		["ru"] = "Контуры области эффекта",
	},
	fire_barrel_explosion_outline_enabled = {
		["en"] = "Barrel Fire",
		["zh-cn"] = "燃料桶火焰",
		["ru"] = "Огонь от бочки",
	},
	fire_barrel_explosion_outline_enabled_tooltip = {
		["en"] = "Show outline around barrel fire",
		["zh-cn"] = "在燃料桶火焰周围显示轮廓",
		["ru"] = "Показывает контур вокруг огня от бочки",
	},
	scab_bomber_grenade_outline_enabled = {
		["en"] = "Scab Bomber Grenade",
		["zh-cn"] = "血痂轰炸者手雷",
		["ru"] = "Граната Скаба-гренадёра",
	},
	scab_bomber_grenade_outline_enabled_tooltip = {
		["en"] = "Show outline around the fire left by a Scab Bomber's grenade",
		["zh-cn"] = "在血痂轰炸者手雷留下的火焰周围显示轮廓",
		["ru"] = "Показывает контур вокруг огня от гранаты Скаба-гренадёра",
	},
	tox_bomber_gas_outline_enabled = {
		["en"] = "Tox Bomber Gas",
		["zh-cn"] = "剧毒轰炸者毒气",
		["ru"] = "Газ Токс-гренадёра",
	},
	tox_bomber_gas_outline_enabled_tooltip = {
		["en"] = "Show outline around the gas left by a Tox Bomber's grenade",
		["zh-cn"] = "在剧毒轰炸者手雷留下的毒气周围显示轮廓",
		["ru"] = "Показывает контур вокруг газа, оставшегося от гранаты Токс-гренадёра",
	},
	scab_flamer_explosion_outline_enabled = {
		["en"] = "Scab Flamer Explosion",
		["zh-cn"] = "血痂火焰兵爆炸",
		["ru"] = "Взрыв Скаба-огнемётчика",
	},
	scab_flamer_explosion_outline_enabled_tooltip = {
		["en"] = "Show outline around the fire left by a Scab Flamer explosion",
		["zh-cn"] = "在血痂火焰兵爆炸留下的火焰周围显示轮廓",
		["ru"] = "Показывает контур вокруг огня, оставшегося от взрыва Скаба-огнемётчика",
	},
	tox_flamer_explosion_outline_enabled = {
		["en"] = "Tox Flamer Explosion",
		["zh-cn"] = "剧毒火焰兵爆炸",
		["ru"] = "Взрыв Токс-огнемётчика",
	},
	tox_flamer_explosion_outline_enabled_tooltip = {
		["en"] = "Show outline around the fire left by a Tox Flamer explosion",
		["zh-cn"] = "在剧毒火焰兵爆炸留下的火焰周围显示轮廓",
		["ru"] = "Показывает контур вокруг огня, оставшегося от взрыва Токс-огнемётчика",
	},

	explosive_barrel_effects_group = {
		["en"] = "Explosive Barrel Explosion Radius",
		["zh-cn"] = "爆炸桶爆炸半径",
		["ru"] = "Радиус взрыва Взрыной бочки",
	},
	explosive_barrel_spawn_outline_enabled = {
		["en"] = "Show when spawned",
		["zh-cn"] = "生成时显示",
		["ru"] = "Показывать при появлении",
	},
	explosive_barrel_spawn_outline_enabled_tooltip = {
		["en"] = "Show barrel explosion radius when barrel spawns in",
		["zh-cn"] = "在桶被生成时显示爆炸半径",
		["ru"] = "Показывает радиус взрыва, когда бочка появляется",
	},
	explosive_barrel_fuse_outline_enabled = {
		["en"] = "Show when hit",
		["zh-cn"] = "点燃后显示",
		["ru"] = "Показывать при ударе",
	},
	explosive_barrel_fuse_outline_enabled_tooltip = {
		["en"] = "Show barrel explosion radius when barrel is about to explode",
		["zh-cn"] = "在桶将要爆炸时显示爆炸半径",
		["ru"] = "Показывает радиус взрыва, когда бочка почти готова взорваться",
	},

	fire_barrel_effects_group = {
		["en"] = "Fire Barrel Explosion Radius",
		["zh-cn"] = "燃料桶爆炸半径",
		["ru"] = "Радиус взрыва Огненной бочки",
	},
	fire_barrel_spawn_outline_enabled = {
		["en"] = "Show when spawned",
		["zh-cn"] = "生成时显示",
		["ru"] = "Показывать при появлении",
	},
	fire_barrel_spawn_outline_enabled_tooltip = {
		["en"] = "Show barrel explosion radius when barrel spawns in",
		["zh-cn"] = "在桶被生成时显示爆炸半径",
		["ru"] = "Показывает радиус взрыва, когда бочка появляется",
	},
	fire_barrel_fuse_outline_enabled = {
		["en"] = "Show when hit",
		["zh-cn"] = "点燃后显示",
		["ru"] = "Показывать при ударе",
	},
	fire_barrel_fuse_outline_enabled_tooltip = {
		["en"] = "Show barrel explosion radius when barrel is about to explode",
		["zh-cn"] = "在桶将要爆炸时显示爆炸半径",
		["ru"] = "Показывает радиус взрыва, когда бочка почти готова взорваться",
	},

	daemonhost_effects_group = {
		["en"] = "Daemonhost Proximity Radius",
		["zh-cn"] = "恶魔宿主接近半径",
		["ru"] = "Радиус приближения к демонхосту",
	},
	daemonhost_spawn_outline_enabled = {
		["en"] = "Show aggro radius",
		["zh-cn"] = "显示仇恨半径",
		["ru"] = "Показывать радиус агрессии",
	},
	daemonhost_spawn_outline_enabled_tooltip = {
		["en"] = "Show area where player movement will start to wake a sleeping Daemonhost",
		["zh-cn"] = "显示玩家移动会唤醒恶魔宿主的区域",
		["ru"] = "Показывает область, в которой движение игрока начнёт пробуждать спящего демонхоста.",
	},
	daemonhost_aura_outline_enabled = {
		["en"] = "Show corruption aura radius",
		["zh-cn"] = "显示腐化光环半径",
		["ru"] = "Показывать радиус ауры порчи",
	},
	daemonhost_aura_outline_enabled_tooltip = {
		["en"] = "Show area where players near aggressive Daemonhost will take corruption damage over time",
		["zh-cn"] = "显示被激怒的恶魔宿主会对附近的玩家持续造成腐化伤害的区域",
		["ru"] = "Показывает область рядом с разозлённым демонхостом, в которой игрок будет получать урон от порчи.",
	},

	poxburster_effects_group = {
		["en"] = "Poxburster Explosion Radius",
		["zh-cn"] = "瘟疫爆破手爆炸半径",
		["ru"] = "Радиус взрыва Чумного взрывника",
	},
	poxburster_spawn_outline_enabled = {
		["en"] = "Show when spawned",
		["zh-cn"] = "生成时显示",
		["ru"] = "Показывать при появлении",
	},
	poxburster_spawn_outline_enabled_tooltip = {
		["en"] = "Show Poxburster explosion radius",
		["zh-cn"] = "显示瘟疫爆破手爆炸半径",
		["ru"] = "Показывает радиус взрыва Чумного взрывника",
	},

	scab_flamer_effects_group = {
		["en"] = "Scab Flamer Explosion Radius",
		["zh-cn"] = "血痂火焰兵爆炸半径",
		["ru"] = "Радиус взрыва Скаба-огнемётчика",
	},
	scab_flamer_spawn_outline_enabled = {
		["en"] = "Show when spawned",
		["zh-cn"] = "生成时显示",
		["ru"] = "Показывать при появлении",
	},
	scab_flamer_spawn_outline_enabled_tooltip = {
		["en"] = "Show Scab Flamer explosion radius when they spawn",
		["zh-cn"] = "在血痂火焰兵被生成时显示爆炸半径",
		["ru"] = "Показывает радиус взрыва Скаба-огнемётчика при появлении",
	},
	scab_flamer_fuse_outline_enabled = {
		["en"] = "Show when set to explode",
		["zh-cn"] = "将要爆炸时显示",
		["ru"] = "Показывать, когда готов взорваться",
	},
	scab_flamer_fuse_outline_enabled_tooltip = {
		["en"] = "Show Scab Flamer explosion radius when Scab Flamer is set to explode upon death",
		["zh-cn"] = "在血痂火焰兵即将爆炸死亡时显示爆炸半径",
		["ru"] = "Показывает радиус взрыва Скаба-огнемётчика, когда он готов взорваться при смерти",
	},

	tox_flamer_effects_group = {
		["en"] = "Tox Flamer Explosion Radius",
		["zh-cn"] = "剧毒火焰兵爆炸半径",
		["ru"] = "Радиус взрыва Токс-огнемётчика",
	},
	tox_flamer_spawn_outline_enabled = {
		["en"] = "Show when spawned",
		["zh-cn"] = "生成时显示",
		["ru"] = "Показывать при появлении",
	},
	tox_flamer_spawn_outline_enabled_tooltip = {
		["en"] = "Show Tox Flamer explosion radius when they spawn",
		["zh-cn"] = "在剧毒火焰兵被生成时显示爆炸半径",
		["ru"] = "Показывает радиус взрыва Токс-огнемётчика при появлении",
	},
	tox_flamer_fuse_outline_enabled = {
		["en"] = "Show when set to explode",
		["zh-cn"] = "将要爆炸时显示",
		["ru"] = "Показывать, когда готов взорваться",
	},
	tox_flamer_fuse_outline_enabled_tooltip = {
		["en"] = "Show Tox Flamer explosion radius when Tox Flamer is set to explode upon death",
		["zh-cn"] = "在剧毒火焰兵即将爆炸死亡时显示爆炸半径",
		["ru"] = "Показывает радиус взрыва Токс-огнемётчика, когда он готов взорваться при смерти",
	},
}

local subheaders_loc = {
	daemonhost_spawn = {
		{
			group_id = "daemonhost_spawn",
			loc = {
				["en"] = "Stage: Sleeping",
				["zh-cn"] = "阶段：睡眠",
				["ru"] = "Стадия: Спит",
			},
		},
		{
			group_id = "daemonhost_alert1",
			loc = {
				["en"] = "Stage: Alert 1",
				["zh-cn"] = "阶段：警告 1",
				["ru"] = "Стадия: Встревожен 1",
			},
		},
		{
			group_id = "daemonhost_alert2",
			loc = {
				["en"] = "Stage: Alert 2",
				["zh-cn"] = "阶段：警告 2",
				["ru"] = "Стадия: Встревожен 2",
			},
		},
		{
			group_id = "daemonhost_alert3",
			loc = {
				["en"] = "Stage: Alert 3 (about to attack)",
				["zh-cn"] = "阶段：警告 3",
				["ru"] = "Стадия: Встревожен 3 (готов напасть)",
			},
		},
	},
}

local function add_group_loc(group_id, table, subheader)
	-- Use nbsp ( ) instead of regular spaces between characters that should stay on the same line
	-- e.g. for displaying "indents"
	if subheader then
		table[group_id .. "_colour_red"] = {
			["en"] = subheader["en"] .. "\n    Red (%%)\n ",
			["zh-cn"] = subheader["zh-cn"] .. "\n    红色（%%）\n ",
			["ru"] = subheader["ru"] .. "\n    Красный (%%)\n ",
		}
		table[group_id .. "_colour_green"] = {
			["en"] = "    Green (%%)",
			["zh-cn"] = "    绿色（%%）",
			["ru"] = "    Зелёный (%%)",
		}
		table[group_id .. "_colour_blue"] = {
			["en"] = "    Blue (%%)",
			["zh-cn"] = "    蓝色（%%）",
			["ru"] = "    Синий (%%)",
		}
		table[group_id .. "_colour_alpha"] = {
			["en"] = "    Opacity (%%)",
			["zh-cn"] = "    不透明度（%%）",
			["ru"] = "    Прозрачность (%%)",
		}
	else
		table[group_id .. "_colour_red"] = {
			["en"] = "Red (%%)",
			["zh-cn"] = "红色（%%）",
			["ru"] = "Красный (%%)",
		}
		table[group_id .. "_colour_green"] = {
			["en"] = "Green (%%)",
			["zh-cn"] = "绿色（%%）",
			["ru"] = "Зелёный (%%)",
		}
		table[group_id .. "_colour_blue"] = {
			["en"] = "Blue (%%)",
			["zh-cn"] = "蓝色（%%）",
			["ru"] = "Синий (%%)",
		}
		table[group_id .. "_colour_alpha"] = {
			["en"] = "Opacity (%%)",
			["zh-cn"] = "不透明度（%%）",
			["ru"] = "Прозрачность (%%)",
		}
	end
end

local localizations = {}
for key, val in pairs(init_loc) do
	localizations[key] = val
	local match = "_outline_enabled"
	if utils.endswith(key, match) then
		local group_id = utils.strip_end(key, match)
		local subheaders = subheaders_loc[group_id]
		if subheaders then
			for _, v in ipairs(subheaders) do
				add_group_loc(v.group_id, localizations, v.loc)
			end
		else
			add_group_loc(group_id, localizations)
		end
	end
end

return localizations
