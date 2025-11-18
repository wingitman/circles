local DB = require("db")
local UserObject = require("userobject")

local Social = {}

local function count(tbl)
	local n = 0
	for _ in pairs(tbl) do
		n = n + 1
	end
	return n
end

function Social.buildUsers()
	local users = {}
	local total = count(DB.users)
	local index = 0

	-- Create objects
	for id, udata in pairs(DB.users) do
		index = index + 1
		users[id] = UserObject.new(id, udata.name, index, total)
	end

	-- Add orbit/friend relationships
	for _, f in ipairs(DB.friends) do
		users[f.user1_id]:addFriend(f.user2_id)
		users[f.user2_id]:addFriend(f.user1_id)
	end

	return users
end

return Social
