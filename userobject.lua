local UserObject = {}
UserObject.__index = UserObject

------------------------------------------------------------
-- Constructor
------------------------------------------------------------
function UserObject.new(id, name, index, total)
	local self = setmetatable({}, UserObject)
	self.id = id
	self.name = name

	-- Stable initial layout: users evenly spaced in a big circle
	local angle = (index / total) * math.pi * 2
	local r = 250

	self.x = math.cos(angle) * r
	self.y = math.sin(angle) * r

	-- friendId → { angle }
	self.orbits = {}

	-- for double-buffering
	self.nextX = self.x
	self.nextY = self.y

	return self
end

------------------------------------------------------------
-- Register a friend (stores an orbit angle)
------------------------------------------------------------
function UserObject:addFriend(friendId)
	self.orbits[friendId] = {
		angle = math.random(-200, 200) / 100 * math.pi * 2,
	}
end

------------------------------------------------------------
-- Compute next position based on all orbits
------------------------------------------------------------
function UserObject:computeNextPosition(users)
	local sumX, sumY = 0, 0
	local count = 0

	for friendId, rel in pairs(self.orbits) do
		local F = users[friendId]
		if F then
			local mx = (self.x + F.x) / 2
			local my = (self.y + F.y) / 2

			local dx = F.x - self.x
			local dy = F.y - self.y
			local dist = math.sqrt(dx * dx + dy * dy)

			-- Avoid collapse
			if dist < 1 then
				dist = 1
			end

			local r = dist / 2

			-- User's position on the orbit
			sumX = sumX + (mx + math.cos(rel.angle) * r)
			sumY = sumY + (my + math.sin(rel.angle) * r)

			count = count + 1
		end
	end

	if count > 0 then
		self.nextX = sumX / count
		self.nextY = sumY / count
	else
		self.nextX = self.x
		self.nextY = self.y
	end
end

------------------------------------------------------------
-- Apply next position (double buffering)
------------------------------------------------------------
function UserObject:applyNextPosition()
	self.x = self.nextX
	self.y = self.nextY
end

return UserObject
