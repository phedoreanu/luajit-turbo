local turbo = require("turbo")

-- Handler that responds with '{"hello":"json"}' and a Content-Type of application/json
local HelloJSONHandler = class("HelloJSONHandler", turbo.web.RequestHandler)
function HelloJSONHandler:get()
    self:write({hello="json"})
end

local application = turbo.web.Application:new({
    {"/", HelloJSONHandler}
})

application:listen(8888)
turbo.ioloop.instance():start()
