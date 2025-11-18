local m = {}
m.objects = require("objects")

function m.startGame()
	print("starting game")
	m.objects.new(4, 16)
	for i, o in ipairs(m.objects.objects) do
		o.draw()
	end
end

return m
