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
	love.graphics.translate(love.graphics.getWidth() / 2 - Camera.x, love.graphics.getHeight() / 2 - Camera.y)
end

function Camera.clear()
	love.graphics.pop()
end

return Camera
