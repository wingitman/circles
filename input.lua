local Input = {}

function Input.update(dt, activeUser)
	if not activeUser then
		return
	end

	local speed = 1.5

	if love.keyboard.isDown("a", "left") then
		for _, rel in pairs(activeUser.orbits) do
			rel.angle = rel.angle - speed * dt
		end
	elseif love.keyboard.isDown("d", "right") then
		for _, rel in pairs(activeUser.orbits) do
			rel.angle = rel.angle + speed * dt
		end
	end
end

function Input.mousePressed(x, y, users, camera)
	local wx = x + camera.x - love.graphics.getWidth() / 2
	local wy = y + camera.y - love.graphics.getHeight() / 2

	local best, dist = nil, 25

	for _, U in pairs(users) do
		local dx = wx - U.x
		local dy = wy - U.y
		local d = math.sqrt(dx * dx + dy * dy)

		if d < dist then
			best = U
			dist = d
		end
	end

	return best
end

return Input
