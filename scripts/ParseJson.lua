local json = require "cjson"
local dirr =  CCUserDefault:sharedUserDefault():getStringForKey("directory")

ParseJson = {}

function ParseJson.decode(filename)
    local data =  json.decode(file_load(dirr..filename))
    return data
    
end

return ParseJson