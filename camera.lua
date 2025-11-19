local Camera = {
	x = 0,
	y = 0,
}

function Camera.follow(user)
	if user.x ~= user.x or user.y ~= user.y then
		-- fallback if NaN ever occurs (should not happen now)
		user.x, user.y = 0, 0
	end

	Camera.x = user.x
	Camera.y = user.y
end

function Camera.apply()
	love.graphics.push()
	local x = love.graphics.getWidth() / 4 - Camera.x
	local y = love.graphics.getHeight() / 4 - Camera.y
	love.graphics.translate(x, y)
end

function Camera.clear()
	love.graphics.pop()
end

return Camera
