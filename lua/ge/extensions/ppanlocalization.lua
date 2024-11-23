local M = {}
local jbeamIO = require('jbeam/io')
local localeData
M.reloadLocale = function()
  package.loaded["ppanlocale/localedata"] = nil
  localeData = require('ppanlocale/localedata')
end
M.reloadLocale()

log('I', 'ppanlocalization', "Thank you for using Vehicle Config Menu Localizer")
local origSendDataToUI

local vehsPartsData = {}
local function getVehData(vehID)
  local vehObj = vehID and be:getObjectByID(vehID) or be:getPlayerVehicle(0)
  if not vehObj then
    return
  end
  vehID = vehObj:getID()

  local vehData = extensions.core_vehicle_manager.getVehicleData(vehID)
  if not vehData then
    return
  end

  if not vehsPartsData[vehID] then
    vehsPartsData[vehID] = {vehName = vehObj:getJBeamFilename(), alpha = 1, partsHighlighted = nil}
  end

  return vehObj, vehData, vehID, vehsPartsData[vehID]
end
-- function override for sending data to the part picker menu
local function customSendDataToUI()
  log("W", "customSendDataToUI", "customSendDataToUI")

  local vehObj, vehData, vehID, partsData
  local playerVehicle = be:getPlayerVehicle(0)
  if playerVehicle then
    vehObj, vehData, vehID, partsData = getVehData(playerVehicle:getID())
  end
  if not vehObj then
    log("E", "customSendDataToUI", "no active vehicle")
    return
  end

  local jbeam = stringToTable(vehData.vehicleDirectory, "/")[2] -- '/vehicles/pickup/'

  log("W", "customSendDataToUI", "jbeam: " .. jbeam)

  local pcFilename = vehData.config.partConfigFilename
  local configDefaults = nil
  if pcFilename then
    local data = core_vehicle_partmgmt.buildConfigFromString(vehData.vehicleDirectory, pcFilename)
    if data ~= nil then
      configDefaults = data
      configDefaults.parts = configDefaults.parts or {}
      configDefaults.vars = configDefaults.vars or {}
    end
  end
  if configDefaults == nil then
    configDefaults = {parts = {}, vars = {}}
  end
  log("W", "customSendDataToUI", "customSendDataToUI")
  --  dump(vehData.mainPartName)
  local data = {
    mainPartName = vehData.mainPartName,
    chosenParts = vehData.chosenParts,
    variables = vehData.vdata.variables,
    availableParts = deepcopy(jbeamIO.getAvailableParts(vehData.ioCtx)), -- deepcopy to ensure sanity
    slotMap = jbeamIO.getAvailableSlotMap(vehData.ioCtx),
    partsHighlighted = partsData.partsHighlighted,
    defaults = configDefaults
  }

  -- enrich the data a bit for the UI
  for partName, part in pairs(data.availableParts) do
    if part.modName then
      local mod = core_modmanager.getModDB(part.modName)
      if mod and mod.modData then
        part.modTagLine = mod.modData.tag_line
        part.modTitle = mod.modData.title
        part.modLastUpdate = mod.modData.last_update
      end
    end
  end

  -- INJECT LOCALIZATION BELOW

  log("I", "customSendDataToUI", "jbeam: " .. jbeam)

  --dump(data.slotMap)
  -- Loop through all the available parts
  for partName, partsTable in pairs(data.availableParts) do
    partsTable.description = localeData.getPartLocale(partName, partsTable.description)

    -- Cursed way to loop through all the available slots
    for slotName, slotsTable in pairs(partsTable.slotInfoUi) do
      slotsTable.description = localeData.getSlotLocale(slotName, slotsTable.description)
    end
  end
  
  guihooks.trigger("VehicleConfigChange", data)
  --log("I", "customSendDataToUI", "VehicleConfigChange")
end

local function injectPartPrices()
  if extensions.core_vehicle_partmgmt and extensions.core_vehicle_partmgmt.sendDataToUI ~= customSendDataToUI then
    log("E", "ppanlocalization", "loaded custom part schenanigans")
    origSendDataToUI = extensions.core_vehicle_partmgmt.sendDataToUI
    extensions.core_vehicle_partmgmt.sendDataToUI = customSendDataToUI
    extensions.core_vehicle_partmgmt.reset = customSendDataToUI
  end
end

local function onExtensionLoaded()
  injectPartPrices()
  log("I", "onExtensionLoaded", "ppanlocalization initialized.")
end

local function onExtensionUnloaded()
  if origSendDataToUI ~= nil then
    extensions.core_vehicle_partmgmt.sendDataToUI = origSendDataToUI
  end

end

M.onExtensionLoaded = onExtensionLoaded
M.onExtensionUnloaded = onExtensionUnloaded

return M