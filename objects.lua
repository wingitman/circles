local m = {}

m.objects = {}
m.new = function(x, y)
	local o = {
		position = { x = x, y = y },
		size = { x = 4, y = 4 },
		velocity = { x = 0, y = 0 },
	}
	o.draw = function()
		love.graphics.print("Hello World!", o.position.x, o.position.y - o.size.y)
		love.graphics.setColor(1, 1, 1)
		love.graphics.circle("fill", o.position.x, o.position.y, o.size.x)
	end
	m.objects[#m.objects + 1] = o
	return o
end

return m
