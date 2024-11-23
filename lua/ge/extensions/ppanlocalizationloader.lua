local M = {}

if extensions.isExtensionLoaded("ppanlocalization") then
  log("E", "ppanlocalizationloader", "ppanlocalization already loaded, skipping")
  return
end

M.onWorldReadyState = function(state)
	if state == 2 then
		log('I', 'ppanlocalizationloader', "Loading module ppanlocalization")
		setExtensionUnloadMode("ppanlocalization", "auto")
		extensions.load("ppanlocalization")
		log('I', 'ppanlocalizationloader', "Done loading everything.")
	end
end

return M