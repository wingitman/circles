local DB = require("db")
local Social = require("social")
local Input = require("input")
local Camera = require("camera")
local UserRender = require("userrender")

local users = {}
local activeUser

------------------------------------------------------------

function love.load()
	-- sample data
	local alice = DB.addUser("Alice")
	local bob = DB.addUser("Bob")
	local cara = DB.addUser("Cara")
	local dan = DB.addUser("Dan")
	local erin = DB.addUser("Erin")

	DB.addFriend(alice, bob)
	DB.addFriend(alice, cara)
	DB.addFriend(bob, dan)
	DB.addFriend(cara, erin)

	-- build user objects
	users = Social.buildUsers()
	activeUser = users[alice]
end

------------------------------------------------------------

function love.update(dt)
	Input.update(dt, activeUser)

	-- DOUBLE BUFFER update
	for _, U in pairs(users) do
		U:computeNextPosition(users)
	end

	for _, U in pairs(users) do
		U:applyNextPosition()
	end

	Camera.follow(activeUser)
end

------------------------------------------------------------

function love.mousepressed(x, y, button)
	if button == 1 then
		local clicked = Input.mousePressed(x, y, users, Camera)
		if clicked then
			activeUser = clicked
		end
	end
end

------------------------------------------------------------

function love.draw()
	Camera.apply()

	UserRender.drawRings(users)
	UserRender.drawUsers(users, activeUser)

	Camera.clear()

	love.graphics.print("Selected: " .. activeUser.name, 20, 20)
end
