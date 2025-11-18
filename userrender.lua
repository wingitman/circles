local UserRender = {}

------------------------------------------------------------
-- Draw rings between user pairs without duplication
------------------------------------------------------------
function UserRender.drawRings(users)
	local drawn = {}

	for id, U in pairs(users) do
		for friendId in pairs(U.orbits) do
			local key = math.min(id, friendId) .. ":" .. math.max(id, friendId)
			if not drawn[key] then
				drawn[key] = true

				local F = users[friendId]

				local mx = (U.x + F.x) / 2
				local my = (U.y + F.y) / 2
				local dx = F.x - U.x
				local dy = F.y - U.y
				local r = math.sqrt(dx * dx + dy * dy) / 2

				love.graphics.setColor(1, 0.8, 0.1, 0.4)
				love.graphics.circle("line", mx, my, r)
			end
		end
	end
end

------------------------------------------------------------
-- Draw user nodes
------------------------------------------------------------
function UserRender.drawUsers(users, active)
	for _, U in pairs(users) do
		-- Circle
		if U == active then
			love.graphics.setColor(0.1, 1, 0.4)
			love.graphics.circle("fill", U.x, U.y, 14)
		else
			love.graphics.setColor(0.2, 0.8, 1)
			love.graphics.circle("fill", U.x, U.y, 12)
		end

		-- Label
		love.graphics.setColor(1, 1, 1)
		love.graphics.print(U.name, U.x + 20, U.y - 6)
	end
end

return UserRender
