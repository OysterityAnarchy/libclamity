local libclamity = {}

function libclamity.parse_chat_message(rawmsg)
	local msg = minetest.strip_colors(rawmsg)
	local nameidx = msg:find("<")
	local first_byte = rawmsg:byte(1)
	if nameidx and (first_byte == 60 or first_byte == 27) then
		local idx = msg:find(">")
		local player = msg:sub(nameidx + 1, idx - 1)
		local sidx = idx + 2
		if msg:sub(idx + 1, idx + 1) == ":" then
			sidx = sidx + 1
		end
		local message = msg:sub(sidx, #msg)
		local discord = first_byte == 27 and rawmsg:sub(2, 12) == "(c@#63d269)" and nameidx == 1
		return {
			player = player,
			message = message,
			discord = discord,
		}
	end
end
