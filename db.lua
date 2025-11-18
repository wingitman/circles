local DB = {}

DB.users = {}
DB.friends = {}
DB.chat = {}
DB.listeners = {}

DB._autoUser = 1

-- USER
function DB.addUser(name)
	local id = DB._autoUser
	DB._autoUser = DB._autoUser + 1

	DB.users[id] = {
		id = id,
		name = name,
	}

	return id
end

function DB.getUser(id)
	return DB.users[id]
end

-- FRIENDS (undirected)
function DB.addFriend(u1, u2)
	table.insert(DB.friends, {
		user1_id = u1,
		user2_id = u2,
	})
end

function DB.getFriendsOf(userId)
	local list = {}
	for _, f in ipairs(DB.friends) do
		if f.user1_id == userId then
			table.insert(list, f.user2_id)
		elseif f.user2_id == userId then
			table.insert(list, f.user1_id)
		end
	end
	return list
end

-- CHAT
function DB.addChat(user, msg)
	local row = {
		user_id = user,
		message = msg,
		datetime = os.time(),
	}
	table.insert(DB.chat, row)
	return #DB.chat
end

-- LISTENERS
function DB.addChatListener(chatId, userId)
	table.insert(DB.listeners, {
		chat_id = chatId,
		user_id = userId,
	})
end

return DB
