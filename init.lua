-- Surround command mod by Zorman2000

minetest.register_chatcommand("tnt_surround", {
	privs = {
		interact = true,
		server = true
	},
	func = function(name, param)
		for _,player in pairs(minetest.get_connected_players()) do
			if param == player:get_player_name() then
				local start_pos = vector.round(player:getpos())
				for y = 0, 3 do
					minetest.set_node({x=start_pos.x - 1, y=start_pos.y + y, z=start_pos.z}, {name="tnt:tnt"})
					minetest.set_node({x=start_pos.x + 1, y=start_pos.y + y, z=start_pos.z}, {name="tnt:tnt"})
					minetest.set_node({x=start_pos.x, y=start_pos.y + y, z=start_pos.z - 1}, {name="tnt:tnt"})
					minetest.set_node({x=start_pos.x, y=start_pos.y + y, z=start_pos.z + 1}, {name="tnt:tnt"})
				end
				minetest.set_node({x=start_pos.x, y=start_pos.y-1, z=start_pos.z}, {name="tnt:tnt"})
				minetest.set_node({x=start_pos.x, y=start_pos.y+4, z=start_pos.z}, {name="tnt:tnt"})
				
				local ignite = function(start_pos)
					minetest.set_node({x=start_pos.x, y=start_pos.y+5, z=start_pos.z}, {name="fire:basic_flame"})
				end
				
				minetest.after(3, ignite, start_pos)
				return true, "" .. param .. " has been surrounded by TNT!"
			end
		end
		return false, "Unable to find player "..param
	end
})
