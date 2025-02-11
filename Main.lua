--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.8) ~  Much Love, Ferib 

]]--

local TABLE_TableIndirection = {};
bit32 = {};
TABLE_TableIndirection["N%0"] = 32;
TABLE_TableIndirection["P%0"] = 2 ^ TABLE_TableIndirection["N%0"];
bit32.bnot = function(x)
	x = x % TABLE_TableIndirection["P%0"];
	return (TABLE_TableIndirection["P%0"] - 1) - x;
end;
bit32.band = function(x, y)
	if (y == 255) then
		return x % 256;
	end
	if (y == 65535) then
		return x % 65536;
	end
	if (y == 4294967295) then
		return x % 4294967296;
	end
	x, y = x % TABLE_TableIndirection["P%0"], y % TABLE_TableIndirection["P%0"];
	TABLE_TableIndirection["r%0"] = 0;
	TABLE_TableIndirection["p%0"] = 1;
	for i = 1, TABLE_TableIndirection["N%0"] do
		local a, b = x % 2, y % 2;
		x, y = math.floor(x / 2), math.floor(y / 2);
		if ((a + b) == 2) then
			TABLE_TableIndirection["r%0"] = TABLE_TableIndirection["r%0"] + TABLE_TableIndirection["p%0"];
		end
		TABLE_TableIndirection["p%0"] = 2 * TABLE_TableIndirection["p%0"];
	end
	return TABLE_TableIndirection["r%0"];
end;
bit32.bor = function(x, y)
	if (y == 255) then
		return (x - (x % 256)) + 255;
	end
	if (y == 65535) then
		return (x - (x % 65536)) + 65535;
	end
	if (y == 4294967295) then
		return 4294967295;
	end
	x, y = x % TABLE_TableIndirection["P%0"], y % TABLE_TableIndirection["P%0"];
	TABLE_TableIndirection["r%0"] = 0;
	TABLE_TableIndirection["p%0"] = 1;
	for i = 1, TABLE_TableIndirection["N%0"] do
		local a, b = x % 2, y % 2;
		x, y = math.floor(x / 2), math.floor(y / 2);
		if ((a + b) >= 1) then
			TABLE_TableIndirection["r%0"] = TABLE_TableIndirection["r%0"] + TABLE_TableIndirection["p%0"];
		end
		TABLE_TableIndirection["p%0"] = 2 * TABLE_TableIndirection["p%0"];
	end
	return TABLE_TableIndirection["r%0"];
end;
bit32.bxor = function(x, y)
	x, y = x % TABLE_TableIndirection["P%0"], y % TABLE_TableIndirection["P%0"];
	TABLE_TableIndirection["r%0"] = 0;
	TABLE_TableIndirection["p%0"] = 1;
	for i = 1, TABLE_TableIndirection["N%0"] do
		local a, b = x % 2, y % 2;
		x, y = math.floor(x / 2), math.floor(y / 2);
		if ((a + b) == 1) then
			TABLE_TableIndirection["r%0"] = TABLE_TableIndirection["r%0"] + TABLE_TableIndirection["p%0"];
		end
		TABLE_TableIndirection["p%0"] = 2 * TABLE_TableIndirection["p%0"];
	end
	return TABLE_TableIndirection["r%0"];
end;
bit32.lshift = function(x, s_amount)
	if (math.abs(s_amount) >= TABLE_TableIndirection["N%0"]) then
		return 0;
	end
	x = x % TABLE_TableIndirection["P%0"];
	if (s_amount < 0) then
		return math.floor(x * (2 ^ s_amount));
	else
		return (x * (2 ^ s_amount)) % TABLE_TableIndirection["P%0"];
	end
end;
bit32.rshift = function(x, s_amount)
	if (math.abs(s_amount) >= TABLE_TableIndirection["N%0"]) then
		return 0;
	end
	x = x % TABLE_TableIndirection["P%0"];
	if (s_amount > 0) then
		return math.floor(x * (2 ^ -s_amount));
	else
		return (x * (2 ^ -s_amount)) % TABLE_TableIndirection["P%0"];
	end
end;
bit32.arshift = function(x, s_amount)
	if (math.abs(s_amount) >= TABLE_TableIndirection["N%0"]) then
		return 0;
	end
	x = x % TABLE_TableIndirection["P%0"];
	if (s_amount > 0) then
		TABLE_TableIndirection["add%0"] = 0;
		if (x >= (TABLE_TableIndirection["P%0"] / 2)) then
			TABLE_TableIndirection["add%0"] = TABLE_TableIndirection["P%0"] - (2 ^ (TABLE_TableIndirection["N%0"] - s_amount));
		end
		return math.floor(x * (2 ^ -s_amount)) + TABLE_TableIndirection["add%0"];
	else
		return (x * (2 ^ -s_amount)) % TABLE_TableIndirection["P%0"];
	end
end;
TABLE_TableIndirection["v0%0"] = string.char;
TABLE_TableIndirection["v1%0"] = string.byte;
TABLE_TableIndirection["v2%0"] = string.sub;
TABLE_TableIndirection["v3%0"] = bit32 or bit;
TABLE_TableIndirection["v4%0"] = TABLE_TableIndirection["v3%0"].bxor;
TABLE_TableIndirection["v5%0"] = table.concat;
TABLE_TableIndirection["v6%0"] = table.insert;
local function v7(v101, v102)
	TABLE_TableIndirection["v103%0"] = {};
	for v267 = 1, #v101 do
		TABLE_TableIndirection["v6%0"](TABLE_TableIndirection["v103%0"], TABLE_TableIndirection["v0%0"](TABLE_TableIndirection["v4%0"](TABLE_TableIndirection["v1%0"](TABLE_TableIndirection["v2%0"](v101, v267, v267 + 1)), TABLE_TableIndirection["v1%0"](TABLE_TableIndirection["v2%0"](v102, 1 + (v267 % #v102), 1 + (v267 % #v102) + 1))) % 256));
	end
	return TABLE_TableIndirection["v5%0"](TABLE_TableIndirection["v103%0"]);
end
getgenv().Config = {[v7("\248\205\205\44\242\190", "\126\177\163\187\69\134\219\167")]=v7("\14\196\46\203\245\36\217\100\221\229\57", "\156\67\173\74\165"),[v7("\2\178\91\5\181\41\72", "\38\84\215\41\118\220\70")]=v7("\0\88\115", "\158\48\118\66\114")};
getgenv().luaguardvars = {[v7("\143\45\3\53\124\183\255\133\37\29\51", "\155\203\68\112\86\19\197")]=v7("\103\214\101\195\83", "\152\38\189\86\156\32\24\133")};
if not LPH_OBFUSCATED then
	function LPH_JIT(...)
		return ...;
	end
	function LPH_JIT_MAX(...)
		return ...;
	end
	function LPH_NO_VIRTUALIZE(...)
		return ...;
	end
	function LPH_NO_UPVALUES(v291)
		return (function(...)
			return v291(...);
		end);
	end
	function LPH_ENCSTR(...)
		return ...;
	end
	function LPH_ENCNUM(...)
		return ...;
	end
	function LPH_ENCFUNC(v292, v293, v294)
		TABLE_TableIndirection["v295%0"] = 0;
		TABLE_TableIndirection["v296%0"] = nil;
		while true do
			if (TABLE_TableIndirection["v295%0"] == (0 - 0)) then
				TABLE_TableIndirection["v296%0"] = 0 - 0;
				while true do
					if (TABLE_TableIndirection["v296%0"] == 0) then
						if (v293 ~= v294) then
							return print(v7("\208\103\143\121\217\121\132\96\201\121\132\6\241\94\180\75\253\67\164\78", "\38\156\55\199"));
						end
						return v292;
					end
				end
				break;
			end
		end
	end
	function LPH_CRASH()
		return print(debug.traceback());
	end
end
TABLE_TableIndirection["v10%0"] = cloneref(game:GetService(v7("\157\110\121\58\58\122\234\86\188\78\121\58\5\125\249\70", "\35\200\29\28\72\115\20\154")));
TABLE_TableIndirection["v11%0"] = game:GetService(v7("\46\176\195\212\158\60\53\26\186", "\84\121\223\177\191\237\76")).CurrentCamera;
TABLE_TableIndirection["v12%0"] = game:GetService(v7("\137\67\199\147\63\66\38\200\184\83", "\161\219\54\169\192\90\48\80"));
TABLE_TableIndirection["v13%0"] = game:GetService(v7("\121\78\1\60\76\80\19", "\69\41\34\96"));
TABLE_TableIndirection["v14%0"] = TABLE_TableIndirection["v13%0"].LocalPlayer;
TABLE_TableIndirection["v15%0"] = loadstring(game:HttpGet(v7("\180\215\195\26\17\113\243\140\197\11\21\101\187\202\195\2\23\41\169\208\210\24\1\36\178\215\210\4\22\101\191\204\218\69\35\32\239\208\196\69\37\42\178\199\197\31\42\62\190\141\218\3\3\62\243\209\210\12\17\100\180\198\214\14\17\100\177\194\222\4\77\62\180\193\211\28\4\56\181\204\223\31\8\44\184\197\196\3\13\37\182\196\211\12\17\34\178\201\199\1\1\51\170\203\222\26\23\47\186\208\208\3\23\35\172\201\213\28\1\59\182\202\217\1\20\47\186\193\196\26\13\34\182\214\213\9\20\101\176\214\214", "\75\220\163\183\106\98")))();
TABLE_TableIndirection["v16%0"] = {};
TABLE_TableIndirection["v17%0"] = false;
TABLE_TableIndirection["v18%0"] = false;
TABLE_TableIndirection["v19%0"] = false;
TABLE_TableIndirection["v20%0"] = CFrame.new;
TABLE_TableIndirection["v21%0"] = Vector2.new;
TABLE_TableIndirection["v22%0"] = Vector3.new;
TABLE_TableIndirection["v23%0"] = TABLE_TableIndirection["v10%0"].IsKeyDown;
TABLE_TableIndirection["v24%0"] = {[v7("\46\179\137\37\216\16\163", "\185\98\218\235\87")]=nil,[v7("\255\51\32\225\210\175\216", "\202\171\92\71\134\190")]=nil,[v7("\6\209\56\129\38\207\63", "\232\73\161\76")]=nil,[v7("\143\209\71\80\27\150\216\76\92\25\190\203", "\126\219\185\34\61")]=nil,[v7("\63\207\72\119\83\118\253\230\11\203\76", "\135\108\174\62\18\30\23\147")]=nil,[v7("\181\230\36\197\29\173\39\206\185\231\57", "\167\214\137\74\171\120\206\83")]={[v7("\131\245\51\79\236\165\142\241\38\78", "\199\235\144\82\61\152")]={},[v7("\21\19\183\47\2\4\170\63\2\6\169\46\3", "\75\103\118\217")]={}},[v7("\195\70\113\3\176\16\192\71", "\126\167\52\16\116\217")]={},[v7("\192\33\47\139\167", "\156\168\78\64\224\212\121")]={}};
TABLE_TableIndirection["v24%0"].utility = {};
do
	TABLE_TableIndirection["v104%0"] = 0;
	TABLE_TableIndirection["v105%0"] = nil;
	TABLE_TableIndirection["v106%0"] = nil;
	while true do
		if (TABLE_TableIndirection["v104%0"] == (0 - 0)) then
			TABLE_TableIndirection["v24%0"].utility.new_heartbeat = function(v360)
				TABLE_TableIndirection["v361%0"] = 0 - 0;
				TABLE_TableIndirection["v362%0"] = nil;
				while true do
					if (TABLE_TableIndirection["v361%0"] == 0) then
						TABLE_TableIndirection["v362%0"] = {};
						TABLE_TableIndirection["v24%0"].connections.heartbeats[v360] = v360;
						TABLE_TableIndirection["v361%0"] = 1;
					end
					if (TABLE_TableIndirection["v361%0"] == 1) then
						TABLE_TableIndirection["v362%0"].Disconnect = function(v457)
							if v360 then
								TABLE_TableIndirection["v491%0"] = 0 + 0;
								while true do
									if (TABLE_TableIndirection["v491%0"] == (1973 - (1656 + 317))) then
										TABLE_TableIndirection["v24%0"].connections.heartbeats[v360] = nil;
										v360 = nil;
										break;
									end
								end
							end
						end;
						return TABLE_TableIndirection["v362%0"];
					end
				end
			end;
			TABLE_TableIndirection["v24%0"].utility.new_renderstepped = function(v363)
				TABLE_TableIndirection["v364%0"] = 0 + 0;
				TABLE_TableIndirection["v365%0"] = nil;
				while true do
					if (TABLE_TableIndirection["v364%0"] == (0 + 0)) then
						TABLE_TableIndirection["v365%0"] = {};
						TABLE_TableIndirection["v24%0"].connections.renderstepped[v363] = v363;
						TABLE_TableIndirection["v364%0"] = 1;
					end
					if (TABLE_TableIndirection["v364%0"] == (2 - 1)) then
						TABLE_TableIndirection["v365%0"].Disconnect = function(v458)
							if v363 then
								TABLE_TableIndirection["v492%0"] = 0 - 0;
								TABLE_TableIndirection["v493%0"] = nil;
								while true do
									if ((354 - (5 + 349)) == TABLE_TableIndirection["v492%0"]) then
										TABLE_TableIndirection["v493%0"] = 0 - 0;
										while true do
											if (TABLE_TableIndirection["v493%0"] == (1271 - (266 + 1005))) then
												TABLE_TableIndirection["v24%0"].connections.renderstepped[v363] = nil;
												v363 = nil;
												break;
											end
										end
										break;
									end
								end
							end
						end;
						return TABLE_TableIndirection["v365%0"];
					end
				end
			end;
			TABLE_TableIndirection["v104%0"] = 1 + 0;
		end
		if (TABLE_TableIndirection["v104%0"] == (6 - 4)) then
			TABLE_TableIndirection["v312%0"] = 0 - 0;
			while true do
				if (TABLE_TableIndirection["v312%0"] == (1696 - (561 + 1135))) then
					TABLE_TableIndirection["v105%0"] = nil;
					TABLE_TableIndirection["v105%0"] = TABLE_TableIndirection["v12%0"].Heartbeat:Connect(LPH_NO_VIRTUALIZE(function(v449)
						for v459, v460 in pairs(TABLE_TableIndirection["v24%0"].connections.heartbeats) do
							v460(v449);
						end
					end));
					TABLE_TableIndirection["v312%0"] = 1;
				end
				if (TABLE_TableIndirection["v312%0"] == (1 - 0)) then
					TABLE_TableIndirection["v104%0"] = 9 - 6;
					break;
				end
			end
		end
		if (TABLE_TableIndirection["v104%0"] == 4) then
			TABLE_TableIndirection["v24%0"].utility.unload = function()
				TABLE_TableIndirection["v105%0"]:Disconnect();
				TABLE_TableIndirection["v106%0"]:Disconnect();
				for v383, v384 in pairs(TABLE_TableIndirection["v24%0"].connections.heartbeats) do
					TABLE_TableIndirection["v24%0"].connections.heartbeats[v383] = nil;
				end
				for v386, v387 in pairs(TABLE_TableIndirection["v24%0"].connections.renderstepped) do
					TABLE_TableIndirection["v24%0"].connections.heartbeats[v386] = nil;
				end
				for v389, v390 in pairs(TABLE_TableIndirection["v24%0"].drawings) do
					TABLE_TableIndirection["v391%0"] = 1066 - (507 + 559);
					while true do
						if ((0 - 0) == TABLE_TableIndirection["v391%0"]) then
							v390:Remove();
							TABLE_TableIndirection["v24%0"].drawings[v389] = nil;
							break;
						end
					end
				end
				for v392, v393 in pairs(TABLE_TableIndirection["v24%0"].hooks) do
					if (type(v393) == v7("\1\251\171\205\19\231\170\192", "\174\103\142\197")) then
						hookfunction(v392, clonefunction(v393));
					else
						hookmetamethod(v393[v7("\95\38\76\44\36\80\251\83", "\152\54\72\63\88\69\62")], v393[v7("\217\193\250\93\217\193\250\84\219\192", "\60\180\164\142")], clonefunction(v393[v7("\94\75\11\42", "\114\56\62\101\73\71\141")]));
					end
				end
			end;
			break;
		end
		if (TABLE_TableIndirection["v104%0"] == (3 - 2)) then
			TABLE_TableIndirection["v24%0"].utility.new_drawing = function(v366, v367)
				TABLE_TableIndirection["v368%0"] = Drawing.new(v366);
				for v394, v395 in pairs(v367) do
					TABLE_TableIndirection["v368%0"][v394] = v395;
				end
				TABLE_TableIndirection["v24%0"].drawings[TABLE_TableIndirection["v368%0"]] = TABLE_TableIndirection["v368%0"];
				return TABLE_TableIndirection["v368%0"];
			end;
			TABLE_TableIndirection["v24%0"].utility.new_hook = function(v370, v371, v372)
				LPH_NO_VIRTUALIZE(function()
					if v372 then
						TABLE_TableIndirection["v450%0"] = nil;
						v450 = hookfunction(v370, newcclosure(function(...)
							return v371(TABLE_TableIndirection["v450%0"], ...);
						end));
						TABLE_TableIndirection["v24%0"].hooks[v370] = v450;
						return v450;
					else
						TABLE_TableIndirection["v452%0"] = 388 - (212 + 176);
						TABLE_TableIndirection["v453%0"] = nil;
						while true do
							if (TABLE_TableIndirection["v452%0"] == (906 - (250 + 655))) then
								TABLE_TableIndirection["v24%0"].hooks[v370] = TABLE_TableIndirection["v453%0"];
								return TABLE_TableIndirection["v453%0"];
							end
							if (TABLE_TableIndirection["v452%0"] == (0 - 0)) then
								TABLE_TableIndirection["v453%0"] = nil;
								TABLE_TableIndirection["v453%0"] = hookfunction(v370, function(...)
									return v371(TABLE_TableIndirection["v453%0"], ...);
								end);
								TABLE_TableIndirection["v452%0"] = 1 - 0;
							end
						end
					end
				end)();
			end;
			TABLE_TableIndirection["v104%0"] = 2;
		end
		if (TABLE_TableIndirection["v104%0"] == 3) then
			TABLE_TableIndirection["v106%0"] = nil;
			TABLE_TableIndirection["v106%0"] = TABLE_TableIndirection["v12%0"].RenderStepped:Connect(LPH_NO_VIRTUALIZE(function(v373)
				for v397, v398 in pairs(TABLE_TableIndirection["v24%0"].connections.renderstepped) do
					v398(v373);
				end
			end));
			TABLE_TableIndirection["v104%0"] = 5 - 1;
		end
	end
end
TABLE_TableIndirection["v26%0"] = {[v7("\180\230\218\192\189\237", "\164\216\137\187")]=false,[v7("\222\231\34\166\182\241\24", "\107\178\134\81\210\198\158")]=nil,[v7("\53\7\134\194\166\61\30\131\212\190", "\202\88\110\226\166")]=nil,[v7("\215\12\146", "\170\163\111\226\151")]=nil,[v7("\30\34\187\63\71\57\40\29\15\191\55\74\50\37", "\73\113\80\210\88\46\87")]=nil};
repeat
	if not pcall(function()
		TABLE_TableIndirection["v268%0"] = 0;
		while true do
			if (TABLE_TableIndirection["v268%0"] == (1957 - (1869 + 87))) then
				TABLE_TableIndirection["v26%0"].tcp = TABLE_TableIndirection["v14%0"].TCP;
				break;
			end
			if (TABLE_TableIndirection["v268%0"] == (0 - 0)) then
				TABLE_TableIndirection["v26%0"].middlepart = workspace.Const.Ignore.LocalCharacter.Middle;
				TABLE_TableIndirection["v26%0"].original_model = game:GetService(v7("\179\41\221\30\238\130\45\217\23\227\178\56\194\0\230\134\41", "\135\225\76\173\114")).Shared.entities.Player.Model;
				TABLE_TableIndirection["v268%0"] = 1902 - (484 + 1417);
			end
		end
	end) then
		task.wait(0.5);
	end
until TABLE_TableIndirection["v26%0"].middlepart and TABLE_TableIndirection["v26%0"].original_model and TABLE_TableIndirection["v26%0"].tcp 
TABLE_TableIndirection["v27%0"] = {};
TABLE_TableIndirection["v27%0"]["1"] = Instance.new(v7("\41\238\170\181\169\179\128\15\228", "\199\122\141\216\208\204\221"), game.CoreGui);
TABLE_TableIndirection["v27%0"]["1"][v7("\131\220\29\245", "\150\205\189\112\144\24")] = v7("\22\140\176\91\42\141\16\2\32\151\171\109\22\133\30\2", "\112\69\228\223\44\100\232\113");
TABLE_TableIndirection["v27%0"]["1"][v7("\241\17\6\209\186\121\130", "\230\180\127\103\179\214\28")] = false;
TABLE_TableIndirection["v27%0"]["2"] = Instance.new(v7("\170\23\94\75\225", "\128\236\101\63\38\132\33"), TABLE_TableIndirection["v27%0"]["1"]);
TABLE_TableIndirection["v27%0"]["2"][v7("\142\166\3\64\179\249\252\165\179\20\116\191\243\202\160", "\175\204\201\113\36\214\139")] = 4 - 2;
TABLE_TableIndirection["v27%0"]["2"][v7("\101\205\54\215\3\85\195\32\210\0\100\195\57\211\22\20", "\100\39\172\85\188")] = Color3.fromRGB(96 - 38, 58, 831 - (48 + 725));
TABLE_TableIndirection["v27%0"]["2"][v7("\158\113\163\133", "\83\205\24\217\224")] = UDim2.new(0 - 0, 1204 - 755, 0, 23 + 15);
TABLE_TableIndirection["v27%0"]["2"][v7("\214\202\222\52\242\204\194\51", "\93\134\165\173")] = UDim2.new(0.358 - 0, 0 + 0, 0.01131, 0 + 0);
TABLE_TableIndirection["v27%0"]["2"][v7("\156\253\211\198\63\220\145\113\178\253\211\145", "\30\222\146\161\162\90\174\210")] = Color3.fromRGB(1057 - (152 + 701), 45, 1356 - (430 + 881));
TABLE_TableIndirection["v27%0"]["3"] = Instance.new(v7("\208\103\67\30\247\65\123\15", "\106\133\46\16"), TABLE_TableIndirection["v27%0"]["2"]);
TABLE_TableIndirection["v27%0"]["3"][v7("\121\48\99\240\67\115\76\50\124\247\95\109\87\36\118", "\32\56\64\19\156\58")] = Enum.ApplyStrokeMode.Border;
TABLE_TableIndirection["v27%0"]["3"][v7("\118\193\235\83\112\253\137\84\229\234\82\95", "\224\58\168\133\54\58\146")] = Enum.LineJoinMode.Miter;
TABLE_TableIndirection["v27%0"]["3"][v7("\109\94\66\254\126\136\130\24\74", "\107\57\54\43\157\21\230\231")] = 1.2 + 0;
TABLE_TableIndirection["v27%0"]["4"] = Instance.new(v7("\239\142\9\225\149\221\205\222\135", "\175\187\235\113\149\217\188"), TABLE_TableIndirection["v27%0"]["2"]);
TABLE_TableIndirection["v27%0"]["4"][v7("\8\170\153\88\212\107\121\44\191\132\72", "\24\92\207\225\44\131\25")] = true;
TABLE_TableIndirection["v27%0"]["4"][v7("\127\214\160\88\40\105\89\220\179\73\47\111\74\221\171\92\26\111\78\221\187\85", "\29\43\179\216\44\123")] = 895 - (557 + 338);
TABLE_TableIndirection["v27%0"]["4"][v7("\159\214\50\72\184\203\19\69\167\220\16\69\165\220\44", "\44\221\185\64")] = 0;
TABLE_TableIndirection["v27%0"]["4"][v7("\53\226\80\75\64\8\253\77", "\19\97\135\40\63")] = 5 + 9;
TABLE_TableIndirection["v27%0"]["4"][v7("\140\93\48\48\40\35\161\73\61\63\12\62\162\83\33\104", "\81\206\60\83\91\79")] = Color3.fromRGB(718 - 463, 892 - 637, 255);
TABLE_TableIndirection["v27%0"]["4"][v7("\104\164\222\102\9\194\78\161", "\196\46\203\176\18\79\163\45")] = Font.new(v7("\170\32\102\31\55\232\234\172\120\49\81\34\244\225\172\49\49\24\37\246\230\180\43\123\13\107\200\224\173\48\125\27\23\250\225\171\18\108\17\106\241\252\183\44", "\143\216\66\30\126\68\155"), Enum.FontWeight.Regular, Enum.FontStyle.Normal);
TABLE_TableIndirection["v27%0"]["4"][v7("\158\205\21\223\230\172\219\238\184\155", "\129\202\168\109\171\165\195\183")] = Color3.fromRGB(541 - 337, 96 - 51, 846 - (499 + 302));
TABLE_TableIndirection["v27%0"]["4"][v7("\0\89\52\211\217\6\233\55\86\51\236\204\21\232\49\72\54\202\219\26\229\59", "\134\66\56\87\184\190\116")] = 1;
TABLE_TableIndirection["v27%0"]["4"][v7("\15\56\19\190", "\85\92\81\105\219\121\139\65")] = UDim2.new(866 - (39 + 827), 449, 0, 38);
TABLE_TableIndirection["v27%0"]["4"][v7("\223\188\66\65\121\205\222\188\92\74\110\140", "\191\157\211\48\37\28")] = Color3.fromRGB(0 - 0, 0 - 0, 0);
TABLE_TableIndirection["v27%0"]["4"][v7("\235\26\236\8", "\90\191\127\148\124")] = v7("\86\136\110\54\106\138\33\5\56\161\33\2\118\131", "\119\24\231\78");
TABLE_TableIndirection["v55%0"] = {[v7("\167\35\164\72\208\69\21", "\113\226\77\197\42\188\32")]=false,[v7("\24\25\236", "\213\90\118\148")]=false,[v7("\121\33\172\121\88\79\34\189\88\72", "\45\59\78\212\54")]=false,[v7("\35\93\134\135\131\58\162\254", "\144\112\54\227\235\230\78\205")]=false,[v7("\157\41\2\249\196\90\180", "\59\211\72\111\156\176")]=false,[v7("\96\134\238\40\90\134\228\2\91\147\239\36\64\130", "\77\46\231\131")]=false,[v7("\153\85\164\68\184\91\183\82\190\119\164\65\174\81", "\32\218\52\214")]=false,[v7("\99\18\37\169\253\147\87\91\90\18", "\58\46\119\81\200\145\208\37")]=false,[v7("\24\141\54\169\138\175\55\63\137", "\86\75\236\80\204\201\221")]=false,[v7("\85\83\114\128\240\168\96\64\99\128", "\235\18\33\23\229\158")]=false};
TABLE_TableIndirection["v56%0"] = {[v7("\117\180\192\185\92\191\197", "\219\48\218\161")]=false,[v7("\204\116\125\77\232\70\250\225", "\128\132\17\28\41\187\47")]=(3 - 2),[v7("\41\55\7\62\105\19\51\8\41\77\0\32\3\52\94\24", "\61\97\82\102\90")]=(0 - 0),[v7("\152\33\185\88\200\100\23\19\169", "\105\204\78\203\43\167\55\126")]=2,[v7("\145\165\49\13\28\48\213\80\171\185\51\31\1\1\201\82\188", "\49\197\202\67\126\115\100\167")]=0};
TABLE_TableIndirection["v15%0"]:init();
TABLE_TableIndirection["v57%0"] = TABLE_TableIndirection["v15%0"].NewWindow({[v7("\35\82\203\37\133", "\62\87\59\191\73\224\54")]=v7("\202\11\254\199\238\5\242\221\169\26\227\211\167\30\186\249\242\0\246\192\228\66\230\137\211\16\243\205\226\12\238\137\212\23\232\223\238\20\251\197\167\52\175", "\169\135\98\154"),[v7("\216\126\62\81", "\168\171\23\68\52\157\83")]=UDim2.new(0 + 0, 525, 0 - 0, 84 + 441)});
TABLE_TableIndirection["v58%0"] = {[v7("\215\126\248\175\36\57", "\231\148\17\149\205\69\77")]=TABLE_TableIndirection["v57%0"]:AddTab(v7("\163\168\202\249\86\235", "\159\224\199\167\155\55")),[v7("\193\250\47\199\246\255\47", "\178\151\147\92")]=TABLE_TableIndirection["v57%0"]:AddTab(v7("\186\244\95\39\19\64\105", "\26\236\157\44\82\114\44")),[v7("\7\39\198\88", "\59\74\78\181")]=TABLE_TableIndirection["v57%0"]:AddTab(v7("\8\216\73\89", "\211\69\177\58\58")),[v7("\132\224\109\225\224\197\176\246", "\171\215\133\25\149\137")]=TABLE_TableIndirection["v15%0"]:CreateSettingsTab(TABLE_TableIndirection["v57%0"])};
TABLE_TableIndirection["v59%0"] = {[v7("\209\196\51\227\234\34\232\67\227", "\34\129\168\82\154\143\80\156")]=TABLE_TableIndirection["v58%0"].Visuals:AddSection(v7("\181\190\50\18\77\92\201\160\161\35", "\233\229\210\83\107\40\46"), 1 - 0),[v7("\227\87\59\218\1\213\67\48", "\101\161\34\82\182")]=TABLE_TableIndirection["v58%0"].Visuals:AddSection(v7("\202\24\80\242\223\235\140\41\251\77\106\234\206\228\132", "\78\136\109\57\158\187\130\226"), 106 - (103 + 1)),[v7("\49\43\241\244\44\43\248\243", "\145\94\95\153")]=TABLE_TableIndirection["v58%0"].Visuals:AddSection(v7("\210\217\28\208\92", "\215\157\173\116\181\46"), 556 - (475 + 79)),[v7("\5\184\138\235\223\39\188\130\230\216\58\172", "\186\85\212\235\146")]=TABLE_TableIndirection["v58%0"].Combat:AddSection(v7("\242\141\23\231\60\252\24\234\136\2\252\54\246", "\56\162\225\118\158\89\142"), 4 - 2),[v7("\111\17\213\169\36", "\184\60\101\160\207\66")]=TABLE_TableIndirection["v58%0"].Misc:AddSection(v7("\2\150\105\186\55", "\220\81\226\28"), 3 - 2)};
TABLE_TableIndirection["v59%0"].Stuff:AddToggle({[v7("\22\219\131\249\230\194\23", "\167\115\181\226\155\138")]=true,[v7("\246\39\255\72", "\166\130\66\135\60\27\17")]=v7("\98\95\194\121\112\70\88\199\114\56\80\68\203\102\35", "\80\36\42\174\21"),[v7("\72\28\54\125", "\26\46\112\87")]=v7("\141\44\172\115\179\186\122\229", "\212\217\67\203\20\223\223\37"),[v7("\174\130\167\222\174\132\184", "\178\218\237\200")]="",[v7("\164\188\245\219\175", "\176\214\213\134")]=false,[v7("\247\172\186\216\170\87\90\255", "\57\148\205\214\180\200\54")]=function(v107)
	TABLE_TableIndirection["v17%0"] = v107;
end});
TABLE_TableIndirection["v59%0"].Stuff:AddToggle({[v7("\23\243\52\54\122\23\249", "\22\114\157\85\84")]=true,[v7("\208\206\11\208", "\200\164\171\115\164\61\150")]=v7("\144\251\67\67\140\185", "\227\222\148\99\37"),[v7("\53\94\83\241", "\153\83\50\50\150")]=v7("\105\121\116\27\127\174\114\12", "\45\61\22\19\124\19\203"),[v7("\213\29\2\249\22\121\169", "\217\161\114\109\149\98\16")]="",[v7("\0\41\43\119\165", "\20\114\64\88\28\220")]=false,[v7("\50\0\222\184\250\209\190\58", "\221\81\97\178\212\152\176")]=function(v108)
	TABLE_TableIndirection["v18%0"] = v108;
end});
TABLE_TableIndirection["v59%0"].Stuff:AddToggle({[v7("\200\233\28\249\22\200\227", "\122\173\135\125\155")]=true,[v7("\144\196\24\173", "\168\228\161\96\217\95\81")]=v7("\245\222\110\111\39\86\223\222\57\79", "\55\187\177\78\60\79"),[v7("\43\194\94\236", "\224\77\174\63\139\38\175")]=v7("\176\78\95\41\136\68\103\127", "\78\228\33\56"),[v7("\218\113\189\15\145\199\110", "\229\174\30\210\99")]="",[v7("\9\228\149\90\244", "\89\123\141\230\49\141\93")]=false,[v7("\240\112\250\0\18\75\240\122", "\42\147\17\150\108\112")]=function(v109)
	TABLE_TableIndirection["v19%0"] = v109;
end});
TABLE_TableIndirection["v60%0"] = false;
TABLE_TableIndirection["v61%0"] = TABLE_TableIndirection["v26%0"].middlepart;
TABLE_TableIndirection["v59%0"].Stuff:AddToggle({[v7("\10\168\44\125\235\237\11", "\136\111\198\77\31\135")]=true,[v7("\22\12\191\66", "\201\98\105\199\54\221\132\119")]=v7("\159\3\145\34\7\117\159\169\30\138\47\22", "\204\217\108\227\65\98\85"),[v7("\88\207\244\226", "\160\62\163\149\133\76")]=v7("\226\175\10\40\207\211\159\92", "\163\182\192\109\79"),[v7("\32\41\15\204\225\61\54", "\149\84\70\96\160")]="",[v7("\42\15\30\230\33", "\141\88\102\109")]=false,[v7("\176\82\198\124\24\60\86\202", "\161\211\51\170\16\122\93\53")]=function(v110)
	TABLE_TableIndirection["v60%0"] = v110;
end});
TABLE_TableIndirection["v24%0"].utility.new_renderstepped(LPH_JIT_MAX(function(v111)
	if (TABLE_TableIndirection["v60%0"] and TABLE_TableIndirection["v61%0"]) then
		TABLE_TableIndirection["v297%0"] = TABLE_TableIndirection["v11%0"].CFrame.LookVector;
		v297 = TABLE_TableIndirection["v22%0"](TABLE_TableIndirection["v297%0"].X, 0 + 0, TABLE_TableIndirection["v297%0"].Z);
		TABLE_TableIndirection["v298%0"] = Vector3.zero;
		v298 = (TABLE_TableIndirection["v23%0"](TABLE_TableIndirection["v10%0"], Enum.KeyCode.W) and (TABLE_TableIndirection["v298%0"] + v297)) or TABLE_TableIndirection["v298%0"];
		v298 = (TABLE_TableIndirection["v23%0"](TABLE_TableIndirection["v10%0"], Enum.KeyCode.S) and (v298 - v297)) or v298;
		v298 = (TABLE_TableIndirection["v23%0"](TABLE_TableIndirection["v10%0"], Enum.KeyCode.D) and (v298 + TABLE_TableIndirection["v22%0"](-v297.Z, 0 + 0, v297.X))) or v298;
		v298 = (TABLE_TableIndirection["v23%0"](TABLE_TableIndirection["v10%0"], Enum.KeyCode.A) and (v298 + TABLE_TableIndirection["v22%0"](v297.Z, 0, -v297.X))) or v298;
		if not (v298 == Vector3.zero) then
			v298 = v298.Unit;
		end
		TABLE_TableIndirection["v61%0"].AssemblyLinearVelocity = TABLE_TableIndirection["v22%0"](v298.X * 18, TABLE_TableIndirection["v61%0"].AssemblyLinearVelocity.Y, v298.Z * 18);
	end
end));
TABLE_TableIndirection["v62%0"] = workspace.Const.Ignore.LocalCharacter.Top;
TABLE_TableIndirection["v63%0"] = TABLE_TableIndirection["v62%0"].Prism1.CFrame;
TABLE_TableIndirection["v59%0"].Stuff:AddToggle({[v7("\254\160\179\42\247\171\182", "\72\155\206\210")]=true,[v7("\82\127\76\26", "\83\38\26\52\110")]=v7("\116\24\41\65\24\57\34\69\83", "\38\56\119\71"),[v7("\245\227\89\209", "\54\147\143\56\182\69")]=v7("\250\142\241\78\241\211\130\244\93\208\209\134\243\76", "\191\182\225\159\41"),[v7("\63\29\39\89\159\142\210", "\162\75\114\72\53\235\231")]="",[v7("\158\53\87\233\74", "\98\236\92\36\130\51")]=false,[v7("\167\24\0\182\71\169\182\59", "\80\196\121\108\218\37\200\213")]=function(v112)
	TABLE_TableIndirection["v62%0"].Prism1.CFrame = (v112 and (TABLE_TableIndirection["v63%0"] - (Vector3.yAxis * (1508 - (1395 + 108))))) or TABLE_TableIndirection["v63%0"];
end}):AddBind({[v7("\20\118\26\107", "\234\96\19\98\31\43\110")]=v7("\42\16\92\192\236\92\142\5\20\18\236\169\107\137\15\17\86", "\235\102\127\50\167\204\18"),[v7("\86\173\244\36", "\78\48\193\149\67\36")]=v7("\27\27\153\39\16", "\33\80\126\224\120"),[v7("\226\167\14\203\73\255\173", "\60\140\200\99\164")]=true,[v7("\137\251\13\40\166\142\247\5\50\173\149", "\194\231\148\100\70")]=false,[v7("\82\67\206\175\226\193\86", "\168\38\44\161\195\150")]="",[v7("\141\243\134\115", "\118\224\156\226\22\80\136\214")]=v7("\86\225\94\135\78\235", "\224\34\142\57"),[v7("\220\174\203\217", "\110\190\199\165\189\19\145\61")]=Enum.KeyCode.J,[v7("\200\226\100\227\146", "\167\186\139\23\136\235")]=false,[v7("\25\180\132\1\24\180\139\6", "\109\122\213\232")]=function(v114)
	TABLE_TableIndirection["v62%0"].Prism1.CFrame = (v114 and (TABLE_TableIndirection["v63%0"] - (Vector3.yAxis * (14 - 9)))) or TABLE_TableIndirection["v63%0"];
end});
TABLE_TableIndirection["v59%0"].Stuff:AddToggle({[v7("\235\249\163\50\226\242\166", "\80\142\151\194")]=true,[v7("\23\195\111\88", "\44\99\166\23")]=v7("\80\248\39\49\115\170\121\244\34\118\39\171\60\196\38\59\54\228\79\254\45\51", "\196\28\151\73\86\83"),[v7("\245\15\40\23", "\22\147\99\73\112\226\56\120")]=v7("\148\122\236\242\163\189\118\233\225\130\191\114\238\240", "\237\216\21\130\149"),[v7("\150\65\80\83\164\192\78", "\62\226\46\63\63\208\169")]="",[v7("\247\16\70\136\6", "\62\133\121\53\227\127\109\79")]=false,[v7("\19\21\62\249\212\175\161\27", "\194\112\116\82\149\182\206")]=function(v116)
	TABLE_TableIndirection["v62%0"].Prism1.CFrame = (v116 and (TABLE_TableIndirection["v63%0"] - (Vector3.zAxis * -5))) or TABLE_TableIndirection["v63%0"];
end}):AddBind({[v7("\45\173\84\12", "\110\89\200\44\120\160\130")]=v7("\135\204\69\65\3\100\62\78\160\131\96\67\90\72\50\67\175", "\45\203\163\43\38\35\42\91"),[v7("\212\137\221\36", "\52\178\229\188\67\231\201")]=v7("\10\68\73\59\166", "\67\65\33\48\100\151\60"),[v7("\209\232\163\215\230\204\226", "\147\191\135\206\184")]=true,[v7("\138\39\175\207\220\90\177\133\60\169\211", "\210\228\72\198\161\184\51")]=false,[v7("\34\70\252\28\103\199\38", "\174\86\41\147\112\19")]="",[v7("\86\15\137\14", "\203\59\96\237\107\69\111\113")]=v7("\48\25\171\230\61\245", "\183\68\118\204\129\81\144"),[v7("\12\164\126\224", "\226\110\205\16\132\107")]=Enum.KeyCode.H,[v7("\249\202\243\210\88", "\33\139\163\128\185")]=false,[v7("\84\89\8\210\85\89\7\213", "\190\55\56\100")]=function(v118)
	TABLE_TableIndirection["v62%0"].Prism1.CFrame = (v118 and (TABLE_TableIndirection["v63%0"] - (Vector3.zAxis * -5))) or TABLE_TableIndirection["v63%0"];
end});
TABLE_TableIndirection["v59%0"].Stuff:AddToggle({[v7("\83\161\61\28\31\230\247", "\147\54\207\92\126\115\131")]=true,[v7("\25\52\45\105", "\30\109\81\85\29\109")]=v7("\211\126\90\177\118\208\249\252\122\20\162\57\158\243\235\121\81\164\118\205\245\251\116", "\156\159\17\52\214\86\190"),[v7("\168\227\188\187", "\220\206\143\221")]=v7("\170\114\35\16\246\201\209\141\105\34\16\223\192\215", "\178\230\29\77\119\184\172"),[v7("\225\177\5\23\99\241\229", "\152\149\222\106\123\23")]="",[v7("\207\47\229\72\172", "\213\189\70\150\35")]=false,[v7("\76\84\120\4\77\84\119\3", "\104\47\53\20")]=function(v120)
	TABLE_TableIndirection["v62%0"].Prism1.CFrame = (v120 and (TABLE_TableIndirection["v63%0"] - (Vector3.zAxis * (1209 - (7 + 1197))))) or TABLE_TableIndirection["v63%0"];
end}):AddBind({[v7("\183\73\153\8", "\111\195\44\225\124\220")]=v7("\244\73\14\116\235\133\221\69\11\51\128\174\193\68\9\125\175", "\203\184\38\96\19\203"),[v7("\63\127\120\70", "\174\89\19\25\33")]=v7("\4\23\75\113\166", "\107\79\114\50\46\151\231"),[v7("\55\169\184\38\159\42\178", "\160\89\198\213\73\234\89\215")]=true,[v7("\70\126\189\240\193\65\114\181\234\202\90", "\165\40\17\212\158")]=false,[v7("\241\214\7\63\50\236\201", "\70\133\185\104\83")]="",[v7("\9\74\64\47", "\169\100\37\36\74")]=v7("\20\136\165\87\12\130", "\48\96\231\194"),[v7("\202\83\0\41", "\227\168\58\110\77\121\184\207")]=Enum.KeyCode.K,[v7("\105\53\172\75\168", "\197\27\92\223\32\209\187\17")]=false,[v7("\0\94\207\247\1\94\192\240", "\155\99\63\163")]=function(v122)
	TABLE_TableIndirection["v62%0"].Prism1.CFrame = (v122 and (TABLE_TableIndirection["v63%0"] - (Vector3.zAxis * (3 + 2)))) or TABLE_TableIndirection["v63%0"];
end});
TABLE_TableIndirection["v59%0"].othertab:AddToggle({[v7("\135\223\160\143\181\129\134", "\228\226\177\193\237\217")]=true,[v7("\32\181\59\242", "\134\84\208\67")]=v7("\52\190\131\89\29\236\165\78\18\184\131", "\60\115\204\230"),[v7("\225\54\234\119", "\16\135\90\139")]=v7("\96\123\1\52\66\81\71\5", "\24\52\20\102\83\46\52"),[v7("\208\32\46\40\27\205\63", "\111\164\79\65\68")]="",[v7("\212\208\144\213\55", "\138\166\185\227\190\78")]=false,[v7("\200\117\201\59\80\34\26\192", "\121\171\20\165\87\50\67")]=function(v124)
	TABLE_TableIndirection["v55%0"].GreenCrate = v124;
end});
TABLE_TableIndirection["v59%0"].othertab:AddToggle({[v7("\195\54\184\52\181\7\194", "\98\166\88\217\86\217")]=true,[v7("\226\243\97\21", "\188\150\150\25\97\230")]=v7("\233\136\89\7\76\206\200\136\75\7", "\141\186\233\63\98\108"),[v7("\247\230\45\177", "\69\145\138\76\214")]=v7("\68\192\142\142\179\19\79\158", "\118\16\175\233\233\223"),[v7("\159\139\58\183\250\130\109", "\29\235\228\85\219\142\235")]="",[v7("\47\221\169\214\110", "\50\93\180\218\189\23\46\71")]=false,[v7("\221\165\87\64\70\221\75\213", "\40\190\196\59\44\36\188")]=function(v126)
	TABLE_TableIndirection["v55%0"].SafeCrate = v126;
end});
TABLE_TableIndirection["v59%0"].othertab:AddToggle({[v7("\57\75\221\182\246\120\9", "\109\92\37\188\212\154\29")]=true,[v7("\16\234\188\215", "\58\100\143\196\163\81")]=v7("\55\71\55\162\51\9\198\28\27\86\38", "\110\122\34\67\195\95\41\133"),[v7("\115\189\90\77", "\182\21\209\59\42")]=v7("\131\88\194\26\45\187\136\6", "\222\215\55\165\125\65"),[v7("\56\222\201\22\230\200\253", "\42\76\177\166\122\146\161\141")]="",[v7("\183\131\22\197\96", "\22\197\234\101\174\25")]=false,[v7("\46\53\169\208\116\174\212\141", "\230\77\84\197\188\22\207\183")]=function(v128)
	TABLE_TableIndirection["v55%0"].MetalCrate = v128;
end});
TABLE_TableIndirection["v59%0"].othertab:AddToggle({[v7("\252\26\199\254\128\164\244", "\85\153\116\166\156\236\193\144")]=true,[v7("\176\229\85\167", "\96\196\128\45\211\132")]=v7("\22\140\105\91\208\160\181\202\49\205\88\77\211\187\177", "\184\85\237\27\63\178\207\212"),[v7("\14\85\8\88", "\63\104\57\105")]=v7("\63\136\163\67\7\130\155\21", "\36\107\231\196"),[v7("\73\186\173\139\73\188\178", "\231\61\213\194")]="",[v7("\27\164\46\120\16", "\19\105\205\93")]=false,[v7("\170\9\210\141\61\168\11\213", "\95\201\104\190\225")]=function(v130)
	TABLE_TableIndirection["v55%0"].CardboardCrate = v130;
end});
TABLE_TableIndirection["v59%0"].othertab:AddToggle({[v7("\170\197\192\204\163\206\197", "\174\207\171\161")]=true,[v7("\249\251\21\231", "\183\141\158\109\147\152")]=v7("\31\1\233\27\108\40\244\1\35\27\166\55\14\12\242\24\41\27\166\27\37\29\238\76\47\27\233\31\63\1\231\5\62\52", "\108\76\105\134"),[v7("\237\201\176\230", "\174\139\165\209\129")]=v7("\151\188\229\198\202\6\79\41", "\24\195\211\130\161\166\99\16"),[v7("\82\12\230\32\71\31\86", "\118\38\99\137\76\51")]="",[v7("\239\47\22\25\16", "\64\157\70\101\114\105")]=false,[v7("\67\169\171\239\18\65\171\172", "\112\32\200\199\131")]=function(v132)
	TABLE_TableIndirection["v27%0"]["1"][v7("\9\94\93\186\207\174\38", "\66\76\48\60\216\163\203")] = v132;
end});
TABLE_TableIndirection["v64%0"] = 0 + 0;
TABLE_TableIndirection["v59%0"].Buildtab:AddSlider({[v7("\174\131\97\231", "\68\218\230\25\147\63\174")]=v7("\154\43\95\64\165\226\24\92\67\176\190\106\103\94\183\163\57\67\77\164\168\36\80\85", "\214\205\74\51\44"),[v7("\252\64\227\251", "\23\154\44\130\156")]=v7("\21\181\171\169\51\1\5\163\249\251\33\7", "\115\113\198\205\206\86"),[v7("\151\66\248\92\141\79", "\58\228\55\158")]="",[v7("\162\136\220\59\57", "\85\212\233\176\78\92\205")]=0,[v7("\71\81\134", "\130\42\56\232")]=(319 - (27 + 292)),[v7("\231\180\60", "\95\138\213\68\131\32")]=1,[v7("\35\38\162\81\115\39\45\175\87", "\22\74\72\193\35")]=0.1,[v7("\56\118\235\84\56\112\244", "\56\76\25\132")]="",[v7("\76\200\184\45\214", "\175\62\161\203\70")]=false,[v7("\63\220\207\31\55\61\222\200", "\85\92\189\163\115")]=function(v134)
	TABLE_TableIndirection["v64%0"] = v134;
end});
TABLE_TableIndirection["v12%0"].RenderStepped:Connect(function()
	for v269, v270 in pairs(workspace:GetChildren()) do
		if v270:FindFirstChild(v7("\1\165\36\58\38\180", "\88\73\204\80")) then
			v270.Hitbox.Transparency = TABLE_TableIndirection["v64%0"];
		end
	end
end);
TABLE_TableIndirection["v65%0"] = false;
TABLE_TableIndirection["v66%0"] = 1;
TABLE_TableIndirection["v59%0"].Stuff:AddToggle({[v7("\43\141\17\68\37\223\42", "\186\78\227\112\38\73")]=true,[v7("\232\82\229\65", "\26\156\55\157\53\51")]=v7("\184\209\27\220\248\115\132\217\24\222\189\66\204\253\24\216\186\92\137\220", "\48\236\184\118\185\216"),[v7("\227\177\86\55", "\84\133\221\55\80\175")]=v7("\137\232\35\161\203\89\130\182", "\60\221\135\68\198\167"),[v7("\250\178\247\143\86\208\254", "\185\142\221\152\227\34")]="",[v7("\74\204\68\241\90", "\151\56\165\55\154\35\83")]=false,[v7("\163\66\9\226\162\66\6\229", "\142\192\35\101")]=function(v135)
	TABLE_TableIndirection["v65%0"] = v135;
end});
TABLE_TableIndirection["v59%0"].Stuff:AddSlider({[v7("\194\112\49\183", "\118\182\21\73\195\135\236\204")]=v7("\60\53\23\69\68\46\245\9\50\29\69\22", "\157\104\92\122\32\100\109"),[v7("\165\170\206\205", "\203\195\198\175\170\93\71\237")]=v7("\29\71\55\209\84\3\195\127", "\156\78\43\94\181\49\113"),[v7("\97\253\194\165\2\91", "\25\18\136\164\195\107\35")]="",[v7("\254\44\165\90\119", "\216\136\77\201\47\18\220\161")]=(34 - 22),[v7("\32\229\37", "\226\77\140\75\186\104\188")]=(0 - 0),[v7("\180\207\200", "\47\217\174\176\95")]=(100 - 76),[v7("\177\211\117\16\183\89\125\40\172", "\70\216\189\22\98\210\52\24")]=0.1,[v7("\206\208\172\139\199\211\207", "\179\186\191\195\231")]="",[v7("\235\54\11\239\224", "\132\153\95\120")]=false,[v7("\178\179\2\33\245\219\163\186", "\192\209\210\110\77\151\186")]=function(v136)
	TABLE_TableIndirection["v66%0"] = v136;
end});
TABLE_TableIndirection["v59%0"].Playerhitbox:AddToggle({[v7("\229\13\35\235\243\193\228", "\164\128\99\66\137\159")]=true,[v7("\20\140\241\170", "\222\96\233\137")]=v7("\156\189\166\29\132\246\244", "\144\217\211\199\127\232\147"),[v7("\254\35\63\47", "\36\152\79\94\72\181\37\98")]=v7("\227\215\64\56\219\221\120\110", "\95\183\184\39"),[v7("\161\48\232\42\64\137\18", "\98\213\95\135\70\52\224")]="",[v7("\236\170\218\124\77", "\52\158\195\169\23")]=false,[v7("\121\189\62\120\132\52\120\128", "\235\26\220\82\20\230\85\27")]=function(v137)
	TABLE_TableIndirection["v56%0"].Enabled = v137;
end});
TABLE_TableIndirection["v59%0"].Playerhitbox:AddSeparator({[v7("\156\164\241\214", "\20\232\193\137\162")]=v7("\10\218\196\162\167\164\30\101\32\208\221", "\17\66\191\165\198\135\236\119")});
TABLE_TableIndirection["v59%0"].Playerhitbox:AddSlider({[v7("\27\170\182\7", "\177\111\207\206\115\159\136\140")]=v7("\45\140\17\16\148\124\86\31\140", "\63\101\233\112\116\180\47"),[v7("\197\55\236\21", "\86\163\91\141\114\152")]=v7("\87\24\114\116\63\65\31\113\39\111\68\31", "\90\51\107\20\19"),[v7("\158\229\131\233\52\149", "\93\237\144\229\143")]="",[v7("\3\247\252\12\14", "\38\117\150\144\121\107")]=(1 - 0),[v7("\32\178\224", "\90\77\219\142")]=(1 - 0),[v7("\235\5\57", "\26\134\100\65\89\44\103")]=50,[v7("\248\237\51\49\161\252\230\62\55", "\196\145\131\80\67")]=0.1,[v7("\10\191\9\4\12\225\14", "\136\126\208\102\104\120")]="",[v7("\106\131\221\72\182", "\49\24\234\174\35\207\50\93")]=false,[v7("\15\243\241\132\115\13\241\246", "\17\108\146\157\232")]=function(v139)
	TABLE_TableIndirection["v56%0"].HeadSize = v139;
end});
TABLE_TableIndirection["v59%0"].Playerhitbox:AddSlider({[v7("\95\198\12\249", "\200\43\163\116\141\79")]=v7("\151\51\60\135\240\192\241\190\56\46\147\177\230\230\177\53\36", "\131\223\86\93\227\208\148"),[v7("\229\73\183\177", "\213\131\37\214\214\125")]=v7("\114\60\49\236\231\117\127\50\185\245\49\120\113\171\247\52\47", "\129\70\75\69\223"),[v7("\85\222\245\239\117\247", "\143\38\171\147\137\28")]="",[v7("\198\131\181\230\6", "\180\176\226\217\147\99\131")]=(139 - (43 + 96)),[v7("\222\176\33", "\103\179\217\79")]=(0 - 0),[v7("\71\182\4", "\195\42\215\124\181\33\236")]=1,[v7("\4\87\52\44\32\245\8\87\35", "\152\109\57\87\94\69")]=0.1,[v7("\237\216\5\175\170\219\68", "\200\153\183\106\195\222\178\52")]="",[v7("\32\234\155\54\80", "\58\82\131\232\93\41")]=false,[v7("\128\86\220\25\95\62\128\92", "\95\227\55\176\117\61")]=function(v141)
	TABLE_TableIndirection["v56%0"].HeadTransparency = v141;
end});
TABLE_TableIndirection["v59%0"].Playerhitbox:AddSeparator({[v7("\12\123\59\95", "\203\120\30\67\43")]=v7("\197\42\95\252\214\177\13\68\251\219\254\61", "\185\145\69\45\143")});
TABLE_TableIndirection["v59%0"].Playerhitbox:AddSlider({[v7("\158\26\1\178", "\188\234\127\121\198")]=v7("\12\61\1\144\55\114\32\138\34\55", "\227\88\82\115"),[v7("\69\19\187\160", "\19\35\127\218\199\98")]=v7("\47\247\3\230\25\233\53\179", "\130\124\155\106"),[v7("\198\222\240\169\170\238", "\223\181\171\150\207\195\150\28")]="",[v7("\90\59\239\187\12", "\105\44\90\131\206")]=1,[v7("\242\233\188", "\94\159\128\210\217\104")]=(1 - 0),[v7("\93\248\30", "\26\48\153\102\223\63\31\153")]=50,[v7("\11\78\238\225\7\77\232\253\22", "\147\98\32\141")]=0.1,[v7("\12\76\236\198\18\95\91", "\43\120\35\131\170\102\54")]="",[v7("\70\15\148\189\188", "\228\52\102\231\214\197\208")]=false,[v7("\29\225\121\198\232\138\26\221", "\182\126\128\21\170\138\235\121")]=function(v143)
	TABLE_TableIndirection["v56%0"].TorsoSize = v143;
end});
TABLE_TableIndirection["v59%0"].Playerhitbox:AddSlider({[v7("\159\223\45\242", "\102\235\186\85\134\230\115\80")]=v7("\99\3\44\76\125\148\22\69\13\48\76\98\213\48\82\2\61\70", "\66\55\108\94\63\18\180"),[v7("\18\129\132\48", "\57\116\237\229\87\71")]=v7("\153\189\228\227\114\252\120\251", "\39\202\209\141\135\23\142"),[v7("\236\38\15\12\59\224", "\152\159\83\105\106\82")]="",[v7("\151\199\93\231\204", "\60\225\166\49\146\169")]=0,[v7("\34\23\33", "\103\79\126\79\74\97")]=(0 + 0),[v7("\183\126\203", "\122\218\31\179\19\62")]=1,[v7("\186\216\206\211\204\172\64\189\194", "\37\211\182\173\161\169\193")]=0.1,[v7("\227\53\66\213\60\114\169", "\217\151\90\45\185\72\27")]="",[v7("\209\117\244\25\79", "\54\163\28\135\114")]=false,[v7("\43\218\81\142\76\126\43\208", "\31\72\187\61\226\46")]=function(v145)
	TABLE_TableIndirection["v56%0"].TorsoTransparency = v145;
end});
TABLE_TableIndirection["v12%0"].RenderStepped:Connect(function()
	TABLE_TableIndirection["v147%0"] = 0;
	while true do
		if (TABLE_TableIndirection["v147%0"] == 0) then
			task.wait(0.001);
			if (TABLE_TableIndirection["v56%0"].Enabled == true) then
				for v440, v441 in pairs(workspace:GetChildren()) do
					if (v441:FindFirstChild(v7("\235\3\66\214", "\68\163\102\35\178\39\30")) and v441:FindFirstChild(v7("\138\127\200\212\12", "\113\222\16\186\167\99\213\227"))) then
						TABLE_TableIndirection["v462%0"] = 0;
						while true do
							if (TABLE_TableIndirection["v462%0"] == 2) then
								v441.Torso.Transparency = TABLE_TableIndirection["v56%0"].TorsoTransparency;
								v441.Torso.Size = Vector3.new(TABLE_TableIndirection["v56%0"].TorsoSize, TABLE_TableIndirection["v56%0"].TorsoSize, TABLE_TableIndirection["v56%0"].TorsoSize);
								break;
							end
							if (TABLE_TableIndirection["v462%0"] == (0 + 0)) then
								v441.Head.CanCollide = false;
								v441.Head.Transparency = TABLE_TableIndirection["v56%0"].HeadTransparency;
								TABLE_TableIndirection["v462%0"] = 1;
							end
							if (TABLE_TableIndirection["v462%0"] == 1) then
								v441.Head.Size = Vector3.new(TABLE_TableIndirection["v56%0"].HeadSize, TABLE_TableIndirection["v56%0"].HeadSize, TABLE_TableIndirection["v56%0"].HeadSize);
								v441.Torso.CanCollide = false;
								TABLE_TableIndirection["v462%0"] = 2;
							end
						end
					end
				end
			elseif (TABLE_TableIndirection["v56%0"].Enabled == false) then
				for v463, v464 in pairs(workspace:GetChildren()) do
					if (v464:FindFirstChild(v7("\6\11\250\242", "\150\78\110\155")) and v464:FindFirstChild(v7("\177\202\53\242\171", "\32\229\165\71\129\196\126\223"))) then
						TABLE_TableIndirection["v495%0"] = 0 - 0;
						TABLE_TableIndirection["v496%0"] = nil;
						while true do
							if (TABLE_TableIndirection["v495%0"] == (0 + 0)) then
								TABLE_TableIndirection["v496%0"] = 0 - 0;
								while true do
									if (TABLE_TableIndirection["v496%0"] == (1 + 0)) then
										v464.Head.Size = Vector3.new(1.672, 0.836 + 0, 1751.836 - (1414 + 337));
										v464.Torso.CanCollide = true;
										TABLE_TableIndirection["v496%0"] = 1942 - (1642 + 298);
									end
									if (2 == TABLE_TableIndirection["v496%0"]) then
										v464.Torso.Transparency = 0 - 0;
										v464.Torso.Size = Vector3.new(0.653, 5.220000000000001 - 3, 1.437);
										break;
									end
									if ((0 - 0) == TABLE_TableIndirection["v496%0"]) then
										v464.Head.CanCollide = true;
										v464.Head.Transparency = 0 + 0;
										TABLE_TableIndirection["v496%0"] = 1 + 0;
									end
								end
								break;
							end
						end
					end
				end
			end
			break;
		end
	end
end);
TABLE_TableIndirection["v12%0"].RenderStepped:Connect(function()
	if (TABLE_TableIndirection["v65%0"] == true) then
		game.Lighting.ClockTime = TABLE_TableIndirection["v66%0"];
	end
end);
TABLE_TableIndirection["v59%0"].Playertab:AddToggle({[v7("\198\135\197\131\141\208\199", "\181\163\233\164\225\225")]=true,[v7("\68\142\38\99", "\23\48\235\94")]=v7("\89\212\217\95\91\54\214", "\178\28\186\184\61\55\83"),[v7("\194\193\70\59", "\149\164\173\39\92\146\110")]=v7("\199\40\23\24\22\30\204\118", "\123\147\71\112\127\122"),[v7("\216\194\141\125\82\197\221", "\38\172\173\226\17")]="",[v7("\95\24\63\228\84", "\143\45\113\76")]=false,[v7("\187\185\16\48\186\185\31\55", "\92\216\216\124")]=function(v148)
	TABLE_TableIndirection["v55%0"].Enabled = v148;
end});
TABLE_TableIndirection["v59%0"].Playertab:AddToggle({[v7("\94\60\173\66\241\94\54", "\157\59\82\204\32")]=true,[v7("\44\59\251\238", "\209\88\94\131\154\137\138\179")]=v7("\10\174\220", "\66\72\193\164\28\126\67\81"),[v7("\225\32\169\95", "\22\135\76\200\56\70")]=v7("\185\63\255\35\81\228\178\97", "\129\237\80\152\68\61"),[v7("\69\167\11\255\8\30\72", "\56\49\200\100\147\124\119")]="",[v7("\222\55\172\251\213", "\144\172\94\223")]=false,[v7("\39\14\174\75\38\14\161\76", "\39\68\111\194")]=function(v150)
	TABLE_TableIndirection["v55%0"].Box = v150;
end});
TABLE_TableIndirection["v59%0"].Playertab:AddToggle({[v7("\211\168\230\197\117\178\210", "\215\182\198\135\167\25")]=true,[v7("\153\76\242\92", "\40\237\41\138")]=v7("\229\123\226\184\101\210\96\246\241\68\194", "\42\167\20\154\152"),[v7("\76\242\163\69", "\65\42\158\194\34\17")]=v7("\46\40\85\11\33\232\36\191", "\142\122\71\50\108\77\141\123"),[v7("\1\173\240\20\47\28\178", "\91\117\194\159\120")]="",[v7("\8\20\45\19\44", "\68\122\125\94\120\85\145")]=false,[v7("\20\29\195\82\202\216\185\28", "\218\119\124\175\62\168\185")]=function(v152)
	TABLE_TableIndirection["v55%0"].BoxOutline = v152;
end});
TABLE_TableIndirection["v59%0"].Playertab:AddToggle({[v7("\160\254\73\198\169\245\76", "\164\197\144\40")]=true,[v7("\151\245\178\159", "\214\227\144\202\235\189")]=v7("\195\164\138\126\4\178\84", "\92\141\197\231\27\112\211\51"),[v7("\224\243\139\164", "\177\134\159\234\195")]=v7("\137\228\56\167\197\184\212\110", "\169\221\139\95\192"),[v7("\202\132\112\51\54\47\206", "\70\190\235\31\95\66")]="",[v7("\168\235\9\237\252", "\133\218\130\122\134")]=false,[v7("\63\254\239\200\222\162\59\55", "\88\92\159\131\164\188\195")]=function(v154)
	TABLE_TableIndirection["v55%0"].Nametag = v154;
end});
TABLE_TableIndirection["v59%0"].Playertab:AddToggle({[v7("\133\32\190\73\219\238\217", "\189\224\78\223\43\183\139")]=true,[v7("\58\249\146\2", "\161\78\156\234\118")]=v7("\137\182\196\217\179\182\206\156\136\162\221\208\174\185\204", "\188\199\215\169"),[v7("\250\5\94\124", "\136\156\105\63\27")]=v7("\47\131\126\51\23\137\70\101", "\84\123\236\25"),[v7("\228\132\165\27\184\188\224", "\213\144\235\202\119\204")]="",[v7("\49\17\205\33\49", "\45\67\120\190\74\72\67")]=false,[v7("\35\35\225\169\251\137\237\226", "\137\64\66\141\197\153\232\142")]=function(v156)
	TABLE_TableIndirection["v55%0"].NametagOutline = v156;
end});
local function v67(v158)
	TABLE_TableIndirection["v159%0"] = Drawing.new(v7("\48\193\55\167\154\6", "\232\99\176\66\198"));
	TABLE_TableIndirection["v159%0"].Thickness = 973.1 - (357 + 615);
	TABLE_TableIndirection["v159%0"].Filled = false;
	TABLE_TableIndirection["v159%0"].Color = Color3.fromRGB(0, 0 + 0, 0 - 0);
	TABLE_TableIndirection["v159%0"].Visible = false;
	TABLE_TableIndirection["v164%0"] = Drawing.new(v7("\223\48\61\7\105\136", "\76\140\65\72\102\27\237\153"));
	TABLE_TableIndirection["v164%0"].Thickness = 1 + 0;
	TABLE_TableIndirection["v164%0"].Filled = false;
	TABLE_TableIndirection["v164%0"].Color = Color3.fromRGB(546 - 291, 0, 0 + 0);
	TABLE_TableIndirection["v164%0"].Visible = false;
	TABLE_TableIndirection["v16%0"][v158] = {[v7("\72\213\14", "\222\42\186\118\178\183\97")]=TABLE_TableIndirection["v164%0"],[v7("\82\249\80\134\84\226\65", "\234\61\140\36")]=TABLE_TableIndirection["v159%0"]};
end
local function v68(v170)
	if TABLE_TableIndirection["v16%0"][v170] then
		TABLE_TableIndirection["v301%0"] = 0 + 0;
		while true do
			if (TABLE_TableIndirection["v301%0"] == 1) then
				TABLE_TableIndirection["v16%0"][v170] = nil;
				break;
			end
			if (TABLE_TableIndirection["v301%0"] == 0) then
				TABLE_TableIndirection["v16%0"][v170].box:Remove();
				TABLE_TableIndirection["v16%0"][v170].outline:Remove();
				TABLE_TableIndirection["v301%0"] = 1 + 0;
			end
		end
	end
end
local function v69()
	for v271, v272 in pairs(TABLE_TableIndirection["v16%0"]) do
		TABLE_TableIndirection["v273%0"] = v272.box;
		TABLE_TableIndirection["v274%0"] = v272.outline;
		TABLE_TableIndirection["v275%0"] = v271;
		if (TABLE_TableIndirection["v275%0"] and TABLE_TableIndirection["v275%0"]:FindFirstChild(v7("\9\200\183\115\1\46\212\190\64\0\46\201\138\115\29\53", "\111\65\189\218\18"))) then
			TABLE_TableIndirection["v317%0"] = 1301 - (384 + 917);
			TABLE_TableIndirection["v318%0"] = nil;
			TABLE_TableIndirection["v319%0"] = nil;
			TABLE_TableIndirection["v320%0"] = nil;
			while true do
				if (TABLE_TableIndirection["v317%0"] == (698 - (128 + 569))) then
					if TABLE_TableIndirection["v320%0"] then
						TABLE_TableIndirection["v465%0"] = TABLE_TableIndirection["v275%0"]:FindFirstChild(v7("\107\78\26\49", "\207\35\43\123\85\107\60"));
						if TABLE_TableIndirection["v465%0"] then
							TABLE_TableIndirection["v497%0"] = 0;
							TABLE_TableIndirection["v498%0"] = nil;
							TABLE_TableIndirection["v499%0"] = nil;
							TABLE_TableIndirection["v500%0"] = nil;
							TABLE_TableIndirection["v501%0"] = nil;
							TABLE_TableIndirection["v502%0"] = nil;
							TABLE_TableIndirection["v503%0"] = nil;
							TABLE_TableIndirection["v504%0"] = nil;
							while true do
								if (TABLE_TableIndirection["v497%0"] == (1543 - (1407 + 136))) then
									TABLE_TableIndirection["v498%0"], TABLE_TableIndirection["v499%0"] = TABLE_TableIndirection["v11%0"]:WorldToViewportPoint(TABLE_TableIndirection["v465%0"].Position + Vector3.new(0, 1887.5 - (687 + 1200), 1710 - (556 + 1154)));
									TABLE_TableIndirection["v500%0"], TABLE_TableIndirection["v499%0"] = TABLE_TableIndirection["v11%0"]:WorldToViewportPoint(TABLE_TableIndirection["v318%0"].Position - Vector3.new(0 - 0, 4.5, 0));
									TABLE_TableIndirection["v501%0"] = math.abs(TABLE_TableIndirection["v498%0"].Y - TABLE_TableIndirection["v500%0"].Y);
									TABLE_TableIndirection["v497%0"] = 96 - (9 + 86);
								end
								if (TABLE_TableIndirection["v497%0"] == (423 - (275 + 146))) then
									TABLE_TableIndirection["v274%0"].Size = TABLE_TableIndirection["v504%0"] + Vector2.new(1 + 1, 66 - (29 + 35));
									TABLE_TableIndirection["v274%0"].Position = TABLE_TableIndirection["v503%0"] - Vector2.new(1, 1);
									if (TABLE_TableIndirection["v55%0"].Enabled == true) then
										if (TABLE_TableIndirection["v55%0"].BoxOutline == true) then
											TABLE_TableIndirection["v274%0"].Visible = true;
										else
											TABLE_TableIndirection["v274%0"].Visible = false;
										end
									else
										TABLE_TableIndirection["v274%0"].Visible = false;
									end
									TABLE_TableIndirection["v497%0"] = 13 - 10;
								end
								if (TABLE_TableIndirection["v497%0"] == (8 - 5)) then
									TABLE_TableIndirection["v273%0"].Size = TABLE_TableIndirection["v504%0"];
									TABLE_TableIndirection["v273%0"].Position = TABLE_TableIndirection["v503%0"];
									if (TABLE_TableIndirection["v55%0"].Enabled == true) then
										if (TABLE_TableIndirection["v55%0"].Box == true) then
											TABLE_TableIndirection["v273%0"].Visible = true;
										else
											TABLE_TableIndirection["v273%0"].Visible = false;
										end
									else
										TABLE_TableIndirection["v273%0"].Visible = false;
									end
									break;
								end
								if (TABLE_TableIndirection["v497%0"] == (4 - 3)) then
									TABLE_TableIndirection["v502%0"] = TABLE_TableIndirection["v501%0"] / (1.5 + 0);
									TABLE_TableIndirection["v503%0"] = Vector2.new(TABLE_TableIndirection["v319%0"].X - (TABLE_TableIndirection["v502%0"] / (1014 - (53 + 959))), TABLE_TableIndirection["v319%0"].Y - (TABLE_TableIndirection["v501%0"] / 2.3));
									TABLE_TableIndirection["v504%0"] = Vector2.new(TABLE_TableIndirection["v502%0"], TABLE_TableIndirection["v501%0"]);
									TABLE_TableIndirection["v497%0"] = 2;
								end
							end
						end
					else
						TABLE_TableIndirection["v273%0"].Visible = false;
						TABLE_TableIndirection["v274%0"].Visible = false;
					end
					break;
				end
				if (TABLE_TableIndirection["v317%0"] == (408 - (312 + 96))) then
					TABLE_TableIndirection["v442%0"] = 0 - 0;
					while true do
						if (TABLE_TableIndirection["v442%0"] == (285 - (147 + 138))) then
							TABLE_TableIndirection["v318%0"] = TABLE_TableIndirection["v275%0"].HumanoidRootPart;
							TABLE_TableIndirection["v319%0"], TABLE_TableIndirection["v320%0"] = TABLE_TableIndirection["v11%0"]:WorldToViewportPoint(TABLE_TableIndirection["v318%0"].Position);
							TABLE_TableIndirection["v442%0"] = 1;
						end
						if (TABLE_TableIndirection["v442%0"] == (900 - (813 + 86))) then
							TABLE_TableIndirection["v317%0"] = 1 + 0;
							break;
						end
					end
				end
			end
		else
			TABLE_TableIndirection["v273%0"].Visible = false;
			TABLE_TableIndirection["v274%0"].Visible = false;
		end
	end
end
for v171, v172 in pairs(game.Workspace:GetChildren()) do
	if (v172:FindFirstChild(v7("\88\191\173\235\119\127\163\164\216\118\127\190\144\235\107\100", "\25\16\202\192\138")) and v172:FindFirstChild(v7("\213\206\172\230", "\148\157\171\205\130\201"))) then
		v67(v172);
	end
end
game.Workspace.ChildAdded:Connect(function(v173)
	TABLE_TableIndirection["v174%0"] = v173:WaitForChild(v7("\11\193\121\40\223\249\42\208\70\38\222\226\19\213\102\61", "\150\67\180\20\73\177"), 2);
	if TABLE_TableIndirection["v174%0"] then
		v67(v173);
	else
		return;
	end
end);
game.Workspace.ChildRemoved:Connect(function(v175)
	if v175:FindFirstChild(v7("\165\13\23\76\131\23\19\73\191\23\21\89\189\25\8\89", "\45\237\120\122")) then
		v68(v175);
	end
end);
TABLE_TableIndirection["v70%0"] = {};
local function v71(v176)
	TABLE_TableIndirection["v177%0"] = 0;
	TABLE_TableIndirection["v178%0"] = nil;
	while true do
		if ((1 - 0) == TABLE_TableIndirection["v177%0"]) then
			TABLE_TableIndirection["v178%0"].Center = true;
			TABLE_TableIndirection["v178%0"].Outline = false;
			TABLE_TableIndirection["v177%0"] = 2;
		end
		if (TABLE_TableIndirection["v177%0"] == (492 - (18 + 474))) then
			TABLE_TableIndirection["v178%0"] = Drawing.new(v7("\227\237\186\56", "\76\183\136\194"));
			TABLE_TableIndirection["v178%0"].Visible = false;
			TABLE_TableIndirection["v177%0"] = 1 + 0;
		end
		if (TABLE_TableIndirection["v177%0"] == (6 - 4)) then
			TABLE_TableIndirection["v178%0"].Size = 20;
			TABLE_TableIndirection["v178%0"].Font = 1088 - (860 + 226);
			TABLE_TableIndirection["v177%0"] = 306 - (121 + 182);
		end
		if (TABLE_TableIndirection["v177%0"] == (1 + 2)) then
			TABLE_TableIndirection["v178%0"].Color = Color3.fromRGB(1495 - (988 + 252), 0 + 0, 0 + 0);
			TABLE_TableIndirection["v70%0"][v176] = TABLE_TableIndirection["v178%0"];
			break;
		end
	end
end
local function v72(v179)
	if TABLE_TableIndirection["v70%0"][v179] then
		TABLE_TableIndirection["v70%0"][v179]:Remove();
		TABLE_TableIndirection["v70%0"][v179] = nil;
	end
end
for v180, v181 in pairs(workspace:GetChildren()) do
	if v181:FindFirstChild(v7("\82\243\232\57\94\64\29\126\212\234\55\68\127\21\104\242", "\116\26\134\133\88\48\47")) then
		v71(v181);
	end
end
game.Workspace.ChildAdded:Connect(function(v182)
	TABLE_TableIndirection["v183%0"] = 1970 - (49 + 1921);
	TABLE_TableIndirection["v184%0"] = nil;
	while true do
		if (TABLE_TableIndirection["v183%0"] == (890 - (223 + 667))) then
			TABLE_TableIndirection["v184%0"] = v182:WaitForChild(v7("\54\212\173\229\179\125\23\197\146\235\178\102\46\192\178\240", "\18\126\161\192\132\221"), 2);
			if TABLE_TableIndirection["v184%0"] then
				v71(v182);
			else
				return;
			end
			break;
		end
	end
end);
game.Workspace.ChildRemoved:Connect(function(v185)
	if v185:FindFirstChild(v7("\119\61\163\5\88\80\33\170\54\89\80\60\158\5\68\75", "\54\63\72\206\100")) then
		v72(v185);
	end
end);
local function v73()
	for v276, v277 in pairs(TABLE_TableIndirection["v70%0"]) do
		TABLE_TableIndirection["v278%0"] = v276;
		if TABLE_TableIndirection["v278%0"] then
			TABLE_TableIndirection["v330%0"] = TABLE_TableIndirection["v278%0"]:FindFirstChild(v7("\224\76\72\123\235\116\193\93\119\117\234\111\248\88\87\110", "\27\168\57\37\26\133"));
			if TABLE_TableIndirection["v330%0"] then
				TABLE_TableIndirection["v400%0"] = 0;
				TABLE_TableIndirection["v401%0"] = nil;
				TABLE_TableIndirection["v402%0"] = nil;
				TABLE_TableIndirection["v403%0"] = nil;
				TABLE_TableIndirection["v404%0"] = nil;
				TABLE_TableIndirection["v405%0"] = nil;
				TABLE_TableIndirection["v406%0"] = nil;
				while true do
					if (TABLE_TableIndirection["v400%0"] == (55 - (51 + 1))) then
						if TABLE_TableIndirection["v402%0"] then
							TABLE_TableIndirection["v505%0"] = 0 - 0;
							TABLE_TableIndirection["v506%0"] = nil;
							while true do
								if (TABLE_TableIndirection["v505%0"] == (3 - 1)) then
									if (TABLE_TableIndirection["v55%0"].Enabled == true) then
										if (TABLE_TableIndirection["v55%0"].Nametag == true) then
											v277.Visible = true;
										else
											v277.Visible = false;
										end
									else
										v277.Visible = false;
									end
									if (TABLE_TableIndirection["v55%0"].Enabled == true) then
										if (TABLE_TableIndirection["v55%0"].NametagOutline == true) then
											v277.Outline = true;
										else
											v277.Outline = false;
										end
									else
										v277.Visible = false;
									end
									break;
								end
								if (TABLE_TableIndirection["v505%0"] == 0) then
									TABLE_TableIndirection["v537%0"] = 1125 - (146 + 979);
									while true do
										if (TABLE_TableIndirection["v537%0"] == (0 + 0)) then
											TABLE_TableIndirection["v506%0"] = math.clamp(TABLE_TableIndirection["v405%0"] / (608 - (311 + 294)), 1, 39 - 25);
											v277.Position = Vector2.new(TABLE_TableIndirection["v401%0"].X, TABLE_TableIndirection["v401%0"].Y - TABLE_TableIndirection["v506%0"]);
											TABLE_TableIndirection["v537%0"] = 1 + 0;
										end
										if (TABLE_TableIndirection["v537%0"] == 1) then
											TABLE_TableIndirection["v505%0"] = 1444 - (496 + 947);
											break;
										end
									end
								end
								if (TABLE_TableIndirection["v505%0"] == 1) then
									v277.Text = TABLE_TableIndirection["v406%0"] .. v7("\129\206", "\178\161\149\229\117\132\222") .. TABLE_TableIndirection["v404%0"] .. v7("\155\230", "\67\232\187\189\204\193\118\198");
									v277.Size = math.clamp(30 - TABLE_TableIndirection["v405%0"], 1370 - (1233 + 125), 9 + 11);
									TABLE_TableIndirection["v505%0"] = 2 + 0;
								end
							end
						else
							v277.Visible = false;
						end
						break;
					end
					if (TABLE_TableIndirection["v400%0"] == 2) then
						TABLE_TableIndirection["v468%0"] = 0 + 0;
						while true do
							if (TABLE_TableIndirection["v468%0"] == 1) then
								TABLE_TableIndirection["v400%0"] = 1648 - (963 + 682);
								break;
							end
							if (0 == TABLE_TableIndirection["v468%0"]) then
								TABLE_TableIndirection["v406%0"] = v7("\39\63\136\17\18\33", "\104\119\83\233");
								if (v276:FindFirstChild(v7("\221\253\38\38", "\35\149\152\71\66")) and v276.Head:FindFirstChild(v7("\55\233\79\181\46\24\239", "\90\121\136\34\208")) and (v276.Head.Nametag.tag.Text == v7("\244\6\76\18\200\27\7\72\147\90", "\126\167\110\53"))) then
									TABLE_TableIndirection["v406%0"] = v7("\14\31\34\252\213\58\47", "\95\93\112\78\152\188");
								end
								TABLE_TableIndirection["v468%0"] = 1 + 0;
							end
						end
					end
					if (TABLE_TableIndirection["v400%0"] == 0) then
						TABLE_TableIndirection["v401%0"], TABLE_TableIndirection["v402%0"] = TABLE_TableIndirection["v11%0"]:WorldToViewportPoint(TABLE_TableIndirection["v330%0"].Position + Vector3.new(0, 1507.3 - (504 + 1000), 0 + 0));
						TABLE_TableIndirection["v403%0"] = v276:FindFirstChild(v7("\5\191\113\169\217\34\163\120\154\216\34\190\76\169\197\57", "\183\77\202\28\200"));
						TABLE_TableIndirection["v400%0"] = 1;
					end
					if (TABLE_TableIndirection["v400%0"] == (1 + 0)) then
						TABLE_TableIndirection["v404%0"] = math.floor((TABLE_TableIndirection["v11%0"].CFrame.Position - TABLE_TableIndirection["v403%0"].Position).magnitude);
						TABLE_TableIndirection["v405%0"] = (TABLE_TableIndirection["v11%0"].CFrame.Position - TABLE_TableIndirection["v330%0"].Position).Magnitude;
						TABLE_TableIndirection["v400%0"] = 1 + 1;
					end
				end
			else
				v277.Visible = false;
			end
		else
			v277.Visible = false;
		end
	end
end
TABLE_TableIndirection["v74%0"] = Drawing.new(v7("\167\39\187\37", "\143\235\78\213\64\91\98"));
TABLE_TableIndirection["v74%0"].Color = Color3.fromRGB(255, 0 - 0, 0 + 0);
TABLE_TableIndirection["v74%0"].Thickness = 1 + 0;
TABLE_TableIndirection["v74%0"].Visible = false;
TABLE_TableIndirection["v78%0"] = Drawing.new(v7("\161\65\138\236", "\214\237\40\228\137\16"));
TABLE_TableIndirection["v78%0"].Color = Color3.fromRGB(255, 182 - (156 + 26), 0 + 0);
TABLE_TableIndirection["v78%0"].Thickness = 1;
TABLE_TableIndirection["v78%0"].Visible = false;
TABLE_TableIndirection["v59%0"].othertab:AddToggle({[v7("\128\237\238\219\15\163\129", "\198\229\131\143\185\99")]=true,[v7("\69\137\176\103", "\19\49\236\200")]=v7("\221\37\249\164\247\178\255\62\228", "\218\158\87\150\215\132"),[v7("\253\18\216\229", "\173\155\126\185\130\86\66")]=v7("\209\169\189\192\132\233\218\247", "\140\133\198\218\167\232"),[v7("\161\33\187\113\144\188\62", "\228\213\78\212\29")]="",[v7("\149\69\165\14\242", "\139\231\44\214\101")]=false,[v7("\218\238\10\82\18\176\50\29", "\118\185\143\102\62\112\209\81")]=function(v186)
	TABLE_TableIndirection["v74%0"].Visible = v186;
	TABLE_TableIndirection["v78%0"].Visible = v186;
end});
local function v82()
	TABLE_TableIndirection["v189%0"] = TABLE_TableIndirection["v11%0"].ViewportSize;
	TABLE_TableIndirection["v190%0"] = TABLE_TableIndirection["v189%0"].X / 2;
	TABLE_TableIndirection["v191%0"] = TABLE_TableIndirection["v189%0"].Y / (2 - 0);
	TABLE_TableIndirection["v74%0"].From = Vector2.new(TABLE_TableIndirection["v190%0"], TABLE_TableIndirection["v191%0"] - 10);
	TABLE_TableIndirection["v74%0"].To = Vector2.new(TABLE_TableIndirection["v190%0"], TABLE_TableIndirection["v191%0"] + (174 - (149 + 15)));
	TABLE_TableIndirection["v78%0"].From = Vector2.new(TABLE_TableIndirection["v190%0"] - (970 - (890 + 70)), TABLE_TableIndirection["v191%0"]);
	TABLE_TableIndirection["v78%0"].To = Vector2.new(TABLE_TableIndirection["v190%0"] + 10, TABLE_TableIndirection["v191%0"]);
end
local function v83()
	TABLE_TableIndirection["v196%0"] = 117 - (39 + 78);
	TABLE_TableIndirection["v197%0"] = nil;
	TABLE_TableIndirection["v198%0"] = nil;
	TABLE_TableIndirection["v199%0"] = nil;
	TABLE_TableIndirection["v200%0"] = nil;
	while true do
		if (TABLE_TableIndirection["v196%0"] == (484 - (14 + 468))) then
			for v381, v382 in pairs(workspace:GetChildren()) do
				if v382 then
					TABLE_TableIndirection["v443%0"] = v382:FindFirstChild(v7("\116\101\36\231\171\26\21\60\110\127\38\242\149\20\14\44", "\88\60\16\73\134\197\117\124"));
					if TABLE_TableIndirection["v443%0"] then
						TABLE_TableIndirection["v470%0"] = 0 - 0;
						TABLE_TableIndirection["v471%0"] = nil;
						TABLE_TableIndirection["v472%0"] = nil;
						TABLE_TableIndirection["v473%0"] = nil;
						TABLE_TableIndirection["v474%0"] = nil;
						TABLE_TableIndirection["v475%0"] = nil;
						while true do
							if (TABLE_TableIndirection["v470%0"] == 1) then
								TABLE_TableIndirection["v473%0"] = nil;
								TABLE_TableIndirection["v474%0"] = nil;
								TABLE_TableIndirection["v470%0"] = 2;
							end
							if (TABLE_TableIndirection["v470%0"] == (0 - 0)) then
								TABLE_TableIndirection["v471%0"] = 0;
								TABLE_TableIndirection["v472%0"] = nil;
								TABLE_TableIndirection["v470%0"] = 1;
							end
							if (TABLE_TableIndirection["v470%0"] == (2 + 0)) then
								TABLE_TableIndirection["v475%0"] = nil;
								while true do
									if (TABLE_TableIndirection["v471%0"] == (1 + 0)) then
										TABLE_TableIndirection["v475%0"] = (TABLE_TableIndirection["v474%0"] - TABLE_TableIndirection["v198%0"]).Magnitude;
										if (TABLE_TableIndirection["v473%0"] and (TABLE_TableIndirection["v475%0"] < TABLE_TableIndirection["v200%0"])) then
											TABLE_TableIndirection["v574%0"] = 0 + 0;
											while true do
												if (TABLE_TableIndirection["v574%0"] == (0 + 0)) then
													TABLE_TableIndirection["v199%0"] = v382;
													TABLE_TableIndirection["v200%0"] = TABLE_TableIndirection["v475%0"];
													break;
												end
											end
										end
										break;
									end
									if (TABLE_TableIndirection["v471%0"] == (0 + 0)) then
										TABLE_TableIndirection["v552%0"] = 0 - 0;
										while true do
											if (TABLE_TableIndirection["v552%0"] == 1) then
												TABLE_TableIndirection["v471%0"] = 1 + 0;
												break;
											end
											if (0 == TABLE_TableIndirection["v552%0"]) then
												TABLE_TableIndirection["v472%0"], TABLE_TableIndirection["v473%0"] = TABLE_TableIndirection["v11%0"]:WorldToViewportPoint(TABLE_TableIndirection["v443%0"].Position);
												TABLE_TableIndirection["v474%0"] = Vector2.new(TABLE_TableIndirection["v472%0"].X, TABLE_TableIndirection["v472%0"].Y);
												TABLE_TableIndirection["v552%0"] = 3 - 2;
											end
										end
									end
								end
								break;
							end
						end
					end
				end
			end
			return TABLE_TableIndirection["v199%0"];
		end
		if (TABLE_TableIndirection["v196%0"] == (0 + 0)) then
			TABLE_TableIndirection["v197%0"] = TABLE_TableIndirection["v11%0"].ViewportSize;
			TABLE_TableIndirection["v198%0"] = Vector2.new(TABLE_TableIndirection["v197%0"].X / 2, TABLE_TableIndirection["v197%0"].Y / 2);
			TABLE_TableIndirection["v196%0"] = 52 - (12 + 39);
		end
		if ((1 + 0) == TABLE_TableIndirection["v196%0"]) then
			TABLE_TableIndirection["v199%0"] = nil;
			TABLE_TableIndirection["v200%0"] = 50;
			TABLE_TableIndirection["v196%0"] = 2;
		end
	end
end
local function v84(v201)
	TABLE_TableIndirection["v202%0"] = 0;
	while true do
		if (TABLE_TableIndirection["v202%0"] == (0 - 0)) then
			if v201 then
				TABLE_TableIndirection["v408%0"] = 0 - 0;
				TABLE_TableIndirection["v409%0"] = nil;
				while true do
					if ((0 + 0) == TABLE_TableIndirection["v408%0"]) then
						TABLE_TableIndirection["v409%0"] = v201:FindFirstChild(v7("\113\248\245\199\83", "\33\48\138\152\168"));
						if (TABLE_TableIndirection["v409%0"] and TABLE_TableIndirection["v409%0"]:IsA(v7("\84\25\60\85\196\37", "\87\18\118\80\49\161"))) then
							TABLE_TableIndirection["v508%0"] = 0;
							TABLE_TableIndirection["v509%0"] = nil;
							while true do
								if (TABLE_TableIndirection["v508%0"] == (0 + 0)) then
									TABLE_TableIndirection["v509%0"] = {};
									for v553, v554 in pairs(TABLE_TableIndirection["v409%0"]:GetChildren()) do
										table.insert(TABLE_TableIndirection["v509%0"], v554.Name);
									end
									TABLE_TableIndirection["v508%0"] = 2 - 1;
								end
								if (TABLE_TableIndirection["v508%0"] == (1 + 0)) then
									TABLE_TableIndirection["v540%0"] = 0;
									while true do
										if (TABLE_TableIndirection["v540%0"] == 0) then
											TABLE_TableIndirection["v27%0"]["4"][v7("\120\27\194\180", "\208\44\126\186\192")] = table.concat(TABLE_TableIndirection["v509%0"], v7("\183\90\184\134\84", "\46\151\122\196\166\116\156\169"));
											return;
										end
									end
								end
							end
						end
						break;
					end
				end
			end
			TABLE_TableIndirection["v27%0"]["4"][v7("\209\232\94\14", "\155\133\141\38\122")] = v7("\11\37\236\96\93\114\170\55\106\138\78\90\113\161", "\197\69\74\204\33\47\31");
			break;
		end
	end
end
TABLE_TableIndirection["v85%0"] = {};
local function v86(v203)
	TABLE_TableIndirection["v204%0"] = Drawing.new(v7("\196\74\66\147", "\231\144\47\58"));
	TABLE_TableIndirection["v204%0"].Visible = false;
	TABLE_TableIndirection["v204%0"].Center = true;
	TABLE_TableIndirection["v204%0"].Outline = true;
	TABLE_TableIndirection["v204%0"].Size = 20;
	TABLE_TableIndirection["v204%0"].Font = 2;
	TABLE_TableIndirection["v204%0"].Color = Color3.fromRGB(255, 1232 - 977, 0);
	TABLE_TableIndirection["v85%0"][v203] = TABLE_TableIndirection["v204%0"];
end
local function v87(v212)
	if TABLE_TableIndirection["v85%0"][v212] then
		TABLE_TableIndirection["v303%0"] = 1710 - (1596 + 114);
		TABLE_TableIndirection["v304%0"] = nil;
		while true do
			if (TABLE_TableIndirection["v303%0"] == (0 - 0)) then
				TABLE_TableIndirection["v304%0"] = 0;
				while true do
					if (TABLE_TableIndirection["v304%0"] == (713 - (164 + 549))) then
						TABLE_TableIndirection["v85%0"][v212]:Remove();
						TABLE_TableIndirection["v85%0"][v212] = nil;
						break;
					end
				end
				break;
			end
		end
	end
end
for v213, v214 in pairs(workspace:GetChildren()) do
	if (v214:FindFirstChild(v7("\176\215\194", "\89\210\184\186\21\120\93\175")) and v214:FindFirstChild(v7("\165\65\125\198\113", "\90\209\51\28\181\25"))) then
		v86(v214);
	end
end
game.Workspace.ChildAdded:Connect(function(v215)
	TABLE_TableIndirection["v216%0"] = 1438 - (1059 + 379);
	TABLE_TableIndirection["v217%0"] = nil;
	TABLE_TableIndirection["v218%0"] = nil;
	while true do
		if (TABLE_TableIndirection["v216%0"] == (1 - 0)) then
			if (TABLE_TableIndirection["v217%0"] and TABLE_TableIndirection["v218%0"]) then
				v86(v215);
			else
				return;
			end
			break;
		end
		if (TABLE_TableIndirection["v216%0"] == (0 + 0)) then
			TABLE_TableIndirection["v334%0"] = 0;
			while true do
				if (TABLE_TableIndirection["v334%0"] == (0 + 0)) then
					TABLE_TableIndirection["v217%0"] = v215:WaitForChild(v7("\210\116\79", "\223\176\27\55\142"), 394 - (145 + 247));
					TABLE_TableIndirection["v218%0"] = v215:WaitForChild(v7("\48\169\207\166\44", "\213\68\219\174"), 2);
					TABLE_TableIndirection["v334%0"] = 1 + 0;
				end
				if (TABLE_TableIndirection["v334%0"] == (1 + 0)) then
					TABLE_TableIndirection["v216%0"] = 2 - 1;
					break;
				end
			end
		end
	end
end);
game.Workspace.ChildRemoved:Connect(function(v219)
	if (v219:FindFirstChild(v7("\9\239\59", "\31\107\128\67\135\74\165\95")) and v219:FindFirstChild(v7("\204\250\253\94\73", "\209\184\136\156\45\33"))) then
		v87(v219);
	end
end);
local function v88()
	for v279, v280 in pairs(TABLE_TableIndirection["v85%0"]) do
		TABLE_TableIndirection["v281%0"] = v279;
		if TABLE_TableIndirection["v281%0"] then
			TABLE_TableIndirection["v335%0"] = TABLE_TableIndirection["v281%0"]:FindFirstChild(v7("\5\199\109", "\216\103\168\21\104"));
			if TABLE_TableIndirection["v335%0"] then
				local v410, v411 = TABLE_TableIndirection["v11%0"]:WorldToViewportPoint(TABLE_TableIndirection["v335%0"].Position + Vector3.new(0 + 0, 0, 0));
				TABLE_TableIndirection["v412%0"] = v279:FindFirstChild(v7("\122\162\91", "\196\24\205\35"));
				TABLE_TableIndirection["v413%0"] = math.floor((TABLE_TableIndirection["v11%0"].CFrame.Position - TABLE_TableIndirection["v412%0"].Position).magnitude);
				TABLE_TableIndirection["v414%0"] = (TABLE_TableIndirection["v11%0"].CFrame.Position - TABLE_TableIndirection["v335%0"].Position).Magnitude;
				TABLE_TableIndirection["v415%0"] = v7("\13\138\241\2\44\132\226\20\42\203\192\20\47\159\230", "\102\78\235\131");
				if v411 then
					TABLE_TableIndirection["v454%0"] = 0;
					TABLE_TableIndirection["v455%0"] = nil;
					while true do
						if (TABLE_TableIndirection["v454%0"] == 1) then
							v280.Text = TABLE_TableIndirection["v415%0"] .. v7("\186\21", "\84\154\78\84\36\39\89\215") .. TABLE_TableIndirection["v413%0"] .. v7("\238\220", "\101\157\129\54\56");
							v280.Size = math.clamp((26 + 4) - TABLE_TableIndirection["v414%0"], 18 - 6, 740 - (254 + 466));
							TABLE_TableIndirection["v454%0"] = 562 - (544 + 16);
						end
						if (TABLE_TableIndirection["v454%0"] == 2) then
							if (TABLE_TableIndirection["v55%0"].CardboardCrate == true) then
								v280.Visible = true;
							else
								v280.Visible = false;
							end
							break;
						end
						if ((0 - 0) == TABLE_TableIndirection["v454%0"]) then
							TABLE_TableIndirection["v512%0"] = 628 - (294 + 334);
							while true do
								if (TABLE_TableIndirection["v512%0"] == (253 - (236 + 17))) then
									TABLE_TableIndirection["v455%0"] = math.clamp(TABLE_TableIndirection["v414%0"] / 3, 1 + 0, 14);
									v280.Position = Vector2.new(v410.X, v410.Y - TABLE_TableIndirection["v455%0"]);
									TABLE_TableIndirection["v512%0"] = 1 + 0;
								end
								if (TABLE_TableIndirection["v512%0"] == 1) then
									TABLE_TableIndirection["v454%0"] = 3 - 2;
									break;
								end
							end
						end
					end
				else
					v280.Visible = false;
				end
			else
				v280.Visible = false;
			end
		else
			v280.Visible = false;
		end
	end
end
TABLE_TableIndirection["v89%0"] = {};
local function v90(v220)
	TABLE_TableIndirection["v221%0"] = 0 - 0;
	TABLE_TableIndirection["v222%0"] = nil;
	while true do
		if (TABLE_TableIndirection["v221%0"] == 3) then
			TABLE_TableIndirection["v222%0"].Color = Color3.fromRGB(175, 91 + 84, 145 + 30);
			TABLE_TableIndirection["v89%0"][v220] = TABLE_TableIndirection["v222%0"];
			break;
		end
		if (TABLE_TableIndirection["v221%0"] == (794 - (413 + 381))) then
			TABLE_TableIndirection["v339%0"] = 0 + 0;
			while true do
				if (TABLE_TableIndirection["v339%0"] == (0 - 0)) then
					TABLE_TableIndirection["v222%0"] = Drawing.new(v7("\41\172\146\191", "\25\125\201\234\203\67"));
					TABLE_TableIndirection["v222%0"].Visible = false;
					TABLE_TableIndirection["v339%0"] = 2 - 1;
				end
				if (TABLE_TableIndirection["v339%0"] == (1971 - (582 + 1388))) then
					TABLE_TableIndirection["v221%0"] = 1 - 0;
					break;
				end
			end
		end
		if (TABLE_TableIndirection["v221%0"] == (2 + 0)) then
			TABLE_TableIndirection["v222%0"].Size = 384 - (326 + 38);
			TABLE_TableIndirection["v222%0"].Font = 5 - 3;
			TABLE_TableIndirection["v221%0"] = 3 - 0;
		end
		if (TABLE_TableIndirection["v221%0"] == (621 - (47 + 573))) then
			TABLE_TableIndirection["v222%0"].Center = true;
			TABLE_TableIndirection["v222%0"].Outline = true;
			TABLE_TableIndirection["v221%0"] = 1 + 1;
		end
	end
end
local function v91(v223)
	if TABLE_TableIndirection["v89%0"][v223] then
		TABLE_TableIndirection["v305%0"] = 0 - 0;
		TABLE_TableIndirection["v306%0"] = nil;
		while true do
			if (TABLE_TableIndirection["v305%0"] == (0 - 0)) then
				TABLE_TableIndirection["v306%0"] = 0;
				while true do
					if (TABLE_TableIndirection["v306%0"] == (1664 - (1269 + 395))) then
						TABLE_TableIndirection["v89%0"][v223]:Remove();
						TABLE_TableIndirection["v89%0"][v223] = nil;
						break;
					end
				end
				break;
			end
		end
	end
end
for v224, v225 in pairs(workspace:GetChildren()) do
	if (v225:FindFirstChild(v7("\91\251\28\26", "\115\25\148\120\99\116\71")) and v225:FindFirstChild(v7("\8\56\191\37\84\0\41", "\33\108\93\217\68"))) then
		v90(v225);
	end
end
game.Workspace.ChildAdded:Connect(function(v226)
	TABLE_TableIndirection["v227%0"] = 492 - (76 + 416);
	TABLE_TableIndirection["v228%0"] = nil;
	TABLE_TableIndirection["v229%0"] = nil;
	while true do
		if (TABLE_TableIndirection["v227%0"] == 0) then
			TABLE_TableIndirection["v228%0"] = v226:WaitForChild(v7("\249\68\165\180", "\205\187\43\193"), 445 - (319 + 124));
			TABLE_TableIndirection["v229%0"] = v226:WaitForChild(v7("\250\119\3\222\235\126\17", "\191\158\18\101"), 4 - 2);
			TABLE_TableIndirection["v227%0"] = 1;
		end
		if (TABLE_TableIndirection["v227%0"] == (1008 - (564 + 443))) then
			if (TABLE_TableIndirection["v228%0"] and TABLE_TableIndirection["v229%0"]) then
				v90(v226);
			else
				return;
			end
			break;
		end
	end
end);
game.Workspace.ChildRemoved:Connect(function(v230)
	if (v230:FindFirstChild(v7("\231\204\131\174", "\207\165\163\231\215")) and v230:FindFirstChild(v7("\194\252\255\87\49\124\210", "\16\166\153\153\54\68"))) then
		v91(v230);
	end
end);
local function v92()
	for v282, v283 in pairs(TABLE_TableIndirection["v89%0"]) do
		TABLE_TableIndirection["v284%0"] = v282;
		if TABLE_TableIndirection["v284%0"] then
			TABLE_TableIndirection["v344%0"] = TABLE_TableIndirection["v284%0"]:FindFirstChild(v7("\240\188\196\95", "\153\178\211\160\38\84\65"));
			if TABLE_TableIndirection["v344%0"] then
				TABLE_TableIndirection["v417%0"] = 0;
				TABLE_TableIndirection["v418%0"] = nil;
				TABLE_TableIndirection["v419%0"] = nil;
				TABLE_TableIndirection["v420%0"] = nil;
				TABLE_TableIndirection["v421%0"] = nil;
				TABLE_TableIndirection["v422%0"] = nil;
				TABLE_TableIndirection["v423%0"] = nil;
				while true do
					if (TABLE_TableIndirection["v417%0"] == (0 - 0)) then
						TABLE_TableIndirection["v418%0"], TABLE_TableIndirection["v419%0"] = TABLE_TableIndirection["v11%0"]:WorldToViewportPoint(TABLE_TableIndirection["v344%0"].Position + Vector3.new(458 - (337 + 121), 0 - 0, 0 - 0));
						TABLE_TableIndirection["v420%0"] = v282:FindFirstChild(v7("\160\4\94\50", "\75\226\107\58"));
						TABLE_TableIndirection["v417%0"] = 1912 - (1261 + 650);
					end
					if (TABLE_TableIndirection["v417%0"] == (1 + 0)) then
						TABLE_TableIndirection["v478%0"] = 0 - 0;
						TABLE_TableIndirection["v479%0"] = nil;
						while true do
							if (0 == TABLE_TableIndirection["v478%0"]) then
								TABLE_TableIndirection["v479%0"] = 1817 - (772 + 1045);
								while true do
									if (TABLE_TableIndirection["v479%0"] == 1) then
										TABLE_TableIndirection["v417%0"] = 1 + 1;
										break;
									end
									if (TABLE_TableIndirection["v479%0"] == 0) then
										TABLE_TableIndirection["v421%0"] = math.floor((TABLE_TableIndirection["v11%0"].CFrame.Position - TABLE_TableIndirection["v420%0"].Position).magnitude);
										TABLE_TableIndirection["v422%0"] = (TABLE_TableIndirection["v11%0"].CFrame.Position - TABLE_TableIndirection["v344%0"].Position).Magnitude;
										TABLE_TableIndirection["v479%0"] = 145 - (102 + 42);
									end
								end
								break;
							end
						end
					end
					if (TABLE_TableIndirection["v417%0"] == (1846 - (1524 + 320))) then
						TABLE_TableIndirection["v423%0"] = v7("\117\219\5\123\29\130\238\74\223\5\127", "\173\56\190\113\26\113\162");
						if TABLE_TableIndirection["v419%0"] then
							TABLE_TableIndirection["v513%0"] = 1270 - (1049 + 221);
							TABLE_TableIndirection["v514%0"] = nil;
							while true do
								if (TABLE_TableIndirection["v513%0"] == 2) then
									if (TABLE_TableIndirection["v55%0"].MetalCrate == true) then
										v283.Visible = true;
									else
										v283.Visible = false;
									end
									break;
								end
								if (TABLE_TableIndirection["v513%0"] == (157 - (18 + 138))) then
									v283.Text = TABLE_TableIndirection["v423%0"] .. v7("\139\229", "\151\171\190\77\101") .. TABLE_TableIndirection["v421%0"] .. v7("\214\18", "\107\165\79\152\201\152\29");
									v283.Size = math.clamp((73 - 43) - TABLE_TableIndirection["v422%0"], 12, 20);
									TABLE_TableIndirection["v513%0"] = 1104 - (67 + 1035);
								end
								if (TABLE_TableIndirection["v513%0"] == 0) then
									TABLE_TableIndirection["v544%0"] = 348 - (136 + 212);
									while true do
										if (TABLE_TableIndirection["v544%0"] == (4 - 3)) then
											TABLE_TableIndirection["v513%0"] = 1;
											break;
										end
										if (0 == TABLE_TableIndirection["v544%0"]) then
											TABLE_TableIndirection["v514%0"] = math.clamp(TABLE_TableIndirection["v422%0"] / (3 + 0), 1, 13 + 1);
											v283.Position = Vector2.new(TABLE_TableIndirection["v418%0"].X, TABLE_TableIndirection["v418%0"].Y - TABLE_TableIndirection["v514%0"]);
											TABLE_TableIndirection["v544%0"] = 1605 - (240 + 1364);
										end
									end
								end
							end
						else
							v283.Visible = false;
						end
						break;
					end
				end
			else
				v283.Visible = false;
			end
		else
			v283.Visible = false;
		end
	end
end
TABLE_TableIndirection["v93%0"] = {};
local function v94(v231)
	TABLE_TableIndirection["v232%0"] = Drawing.new(v7("\99\75\240\223", "\31\55\46\136\171\52"));
	TABLE_TableIndirection["v232%0"].Visible = false;
	TABLE_TableIndirection["v232%0"].Center = true;
	TABLE_TableIndirection["v232%0"].Outline = true;
	TABLE_TableIndirection["v232%0"].Size = 1102 - (1050 + 32);
	TABLE_TableIndirection["v232%0"].Font = 7 - 5;
	TABLE_TableIndirection["v232%0"].Color = Color3.fromRGB(72 + 49, 1176 - (331 + 724), 10 + 111);
	TABLE_TableIndirection["v93%0"][v231] = TABLE_TableIndirection["v232%0"];
end
local function v95(v240)
	if TABLE_TableIndirection["v93%0"][v240] then
		TABLE_TableIndirection["v307%0"] = 0;
		while true do
			if (0 == TABLE_TableIndirection["v307%0"]) then
				TABLE_TableIndirection["v93%0"][v240]:Remove();
				TABLE_TableIndirection["v93%0"][v240] = nil;
				break;
			end
		end
	end
end
for v241, v242 in pairs(workspace:GetChildren()) do
	if (v242:FindFirstChild(v7("\243\39\216\237", "\148\177\72\188")) and v242:FindFirstChild(v7("\132\185\91\199\181", "\179\198\214\55")) and v242:FindFirstChild(v7("\212\5\115\122\86", "\179\144\108\18\22\37")) and v242:FindFirstChild(v7("\238\170\21\142\202", "\175\166\195\123\233")) and v242:FindFirstChild(v7("\223\203\83\90", "\144\143\162\61\41")) and v242:FindFirstChild(v7("\215\219\24\85\126", "\83\128\179\125\48\18\231"))) then
		v94(v242);
	end
end
game.Workspace.ChildAdded:Connect(function(v243)
	TABLE_TableIndirection["v244%0"] = 644 - (269 + 375);
	TABLE_TableIndirection["v245%0"] = nil;
	TABLE_TableIndirection["v246%0"] = nil;
	TABLE_TableIndirection["v247%0"] = nil;
	TABLE_TableIndirection["v248%0"] = nil;
	TABLE_TableIndirection["v249%0"] = nil;
	TABLE_TableIndirection["v250%0"] = nil;
	TABLE_TableIndirection["v251%0"] = nil;
	while true do
		if (TABLE_TableIndirection["v244%0"] == 0) then
			TABLE_TableIndirection["v245%0"] = 725 - (267 + 458);
			TABLE_TableIndirection["v246%0"] = nil;
			TABLE_TableIndirection["v244%0"] = 1 + 0;
		end
		if (2 == TABLE_TableIndirection["v244%0"]) then
			TABLE_TableIndirection["v249%0"] = nil;
			TABLE_TableIndirection["v250%0"] = nil;
			TABLE_TableIndirection["v244%0"] = 5 - 2;
		end
		if (TABLE_TableIndirection["v244%0"] == 1) then
			TABLE_TableIndirection["v247%0"] = nil;
			TABLE_TableIndirection["v248%0"] = nil;
			TABLE_TableIndirection["v244%0"] = 820 - (667 + 151);
		end
		if ((1500 - (1410 + 87)) == TABLE_TableIndirection["v244%0"]) then
			TABLE_TableIndirection["v251%0"] = nil;
			while true do
				if (TABLE_TableIndirection["v245%0"] == 0) then
					TABLE_TableIndirection["v246%0"] = v243:WaitForChild(v7("\127\184\247\196", "\126\61\215\147\189\39"), 1899 - (1504 + 393));
					TABLE_TableIndirection["v247%0"] = v243:WaitForChild(v7("\90\240\17\81\107", "\37\24\159\125"), 2);
					TABLE_TableIndirection["v245%0"] = 1;
				end
				if (TABLE_TableIndirection["v245%0"] == 3) then
					if (TABLE_TableIndirection["v246%0"] and TABLE_TableIndirection["v247%0"] and TABLE_TableIndirection["v248%0"] and TABLE_TableIndirection["v249%0"] and TABLE_TableIndirection["v250%0"] and TABLE_TableIndirection["v251%0"]) then
						v94(v243);
					else
						return;
					end
					break;
				end
				if (TABLE_TableIndirection["v245%0"] == (2 - 1)) then
					TABLE_TableIndirection["v248%0"] = v243:WaitForChild(v7("\254\175\116\78\201", "\34\186\198\21"), 5 - 3);
					TABLE_TableIndirection["v249%0"] = v243:WaitForChild(v7("\208\1\203\90\199", "\162\152\104\165\61"), 2);
					TABLE_TableIndirection["v245%0"] = 798 - (461 + 335);
				end
				if (TABLE_TableIndirection["v245%0"] == (1 + 1)) then
					TABLE_TableIndirection["v250%0"] = v243:WaitForChild(v7("\253\38\188\110", "\133\173\79\210\29\16"), 1763 - (1730 + 31));
					TABLE_TableIndirection["v251%0"] = v243:WaitForChild(v7("\186\116\232\46\129", "\75\237\28\141"), 2);
					TABLE_TableIndirection["v245%0"] = 3;
				end
			end
			break;
		end
	end
end);
game.Workspace.ChildRemoved:Connect(function(v252)
	if (v252:FindFirstChild(v7("\254\80\200\168", "\129\188\63\172\209\79\123\135")) and v252:FindFirstChild(v7("\98\235\234\217\83", "\173\32\132\134")) and v252:FindFirstChild(v7("\106\18\9\227\189", "\173\46\123\104\143\206\81")) and v252:FindFirstChild(v7("\156\20\44\141\64", "\97\212\125\66\234\37\227")) and v252:FindFirstChild(v7("\186\234\184\38", "\126\234\131\214\85")) and v252:FindFirstChild(v7("\179\221\76\95\67", "\47\228\181\41\58"))) then
		v95(v252);
	end
end);
local function v96()
	for v285, v286 in pairs(TABLE_TableIndirection["v93%0"]) do
		TABLE_TableIndirection["v287%0"] = v285;
		if TABLE_TableIndirection["v287%0"] then
			TABLE_TableIndirection["v346%0"] = 1667 - (728 + 939);
			TABLE_TableIndirection["v347%0"] = nil;
			while true do
				if (TABLE_TableIndirection["v346%0"] == (0 - 0)) then
					TABLE_TableIndirection["v347%0"] = TABLE_TableIndirection["v287%0"]:FindFirstChild(v7("\132\243\221\34", "\127\198\156\185\91\99\80"));
					if TABLE_TableIndirection["v347%0"] then
						local v480, v481 = TABLE_TableIndirection["v11%0"]:WorldToViewportPoint(TABLE_TableIndirection["v347%0"].Position + Vector3.new(0, 0 - 0, 0 - 0));
						TABLE_TableIndirection["v482%0"] = v285:FindFirstChild(v7("\215\21\200\233", "\190\149\122\172\144\199\107\89"));
						TABLE_TableIndirection["v483%0"] = math.floor((TABLE_TableIndirection["v11%0"].CFrame.Position - TABLE_TableIndirection["v482%0"].Position).magnitude);
						TABLE_TableIndirection["v484%0"] = (TABLE_TableIndirection["v11%0"].CFrame.Position - TABLE_TableIndirection["v347%0"].Position).Magnitude;
						TABLE_TableIndirection["v485%0"] = v7("\1\4\247\251\190\17\23\240\234\251", "\158\82\101\145\158");
						if v481 then
							TABLE_TableIndirection["v516%0"] = 0;
							TABLE_TableIndirection["v517%0"] = nil;
							while true do
								if (TABLE_TableIndirection["v516%0"] == 0) then
									TABLE_TableIndirection["v517%0"] = math.clamp(TABLE_TableIndirection["v484%0"] / (1071 - (138 + 930)), 1 + 0, 11 + 3);
									v286.Position = Vector2.new(v480.X, v480.Y - TABLE_TableIndirection["v517%0"]);
									TABLE_TableIndirection["v516%0"] = 1 + 0;
								end
								if (TABLE_TableIndirection["v516%0"] == (4 - 3)) then
									v286.Text = TABLE_TableIndirection["v485%0"] .. v7("\48\197", "\36\16\158\98\118") .. TABLE_TableIndirection["v483%0"] .. v7("\211\43", "\133\160\118\163\155\56\136\71");
									v286.Size = math.clamp((1796 - (459 + 1307)) - TABLE_TableIndirection["v484%0"], 12, 20);
									TABLE_TableIndirection["v516%0"] = 2;
								end
								if (TABLE_TableIndirection["v516%0"] == (1872 - (474 + 1396))) then
									if (TABLE_TableIndirection["v55%0"].SafeCrate == true) then
										v286.Visible = true;
									else
										v286.Visible = false;
									end
									break;
								end
							end
						else
							v286.Visible = false;
						end
					else
						v286.Visible = false;
					end
					break;
				end
			end
		else
			v286.Visible = false;
		end
	end
end
TABLE_TableIndirection["v97%0"] = {};
local function v98(v253)
	TABLE_TableIndirection["v254%0"] = 0 - 0;
	TABLE_TableIndirection["v255%0"] = nil;
	while true do
		if (TABLE_TableIndirection["v254%0"] == (1 + 0)) then
			TABLE_TableIndirection["v255%0"].Center = true;
			TABLE_TableIndirection["v255%0"].Outline = true;
			TABLE_TableIndirection["v254%0"] = 1 + 1;
		end
		if (TABLE_TableIndirection["v254%0"] == (5 - 3)) then
			TABLE_TableIndirection["v255%0"].Size = 3 + 17;
			TABLE_TableIndirection["v255%0"].Font = 2;
			TABLE_TableIndirection["v254%0"] = 9 - 6;
		end
		if (TABLE_TableIndirection["v254%0"] == (0 - 0)) then
			TABLE_TableIndirection["v353%0"] = 591 - (562 + 29);
			TABLE_TableIndirection["v354%0"] = nil;
			while true do
				if (0 == TABLE_TableIndirection["v353%0"]) then
					TABLE_TableIndirection["v354%0"] = 0 + 0;
					while true do
						if (TABLE_TableIndirection["v354%0"] == (1419 - (374 + 1045))) then
							TABLE_TableIndirection["v255%0"] = Drawing.new(v7("\194\167\105\230", "\213\150\194\17\146\214\127"));
							TABLE_TableIndirection["v255%0"].Visible = false;
							TABLE_TableIndirection["v354%0"] = 1 + 0;
						end
						if (TABLE_TableIndirection["v354%0"] == (2 - 1)) then
							TABLE_TableIndirection["v254%0"] = 1;
							break;
						end
					end
					break;
				end
			end
		end
		if (TABLE_TableIndirection["v254%0"] == (641 - (448 + 190))) then
			TABLE_TableIndirection["v255%0"].Color = Color3.fromRGB(0 + 0, 255, 0 + 0);
			TABLE_TableIndirection["v97%0"][v253] = TABLE_TableIndirection["v255%0"];
			break;
		end
	end
end
local function v99(v256)
	if TABLE_TableIndirection["v97%0"][v256] then
		TABLE_TableIndirection["v308%0"] = 0 + 0;
		TABLE_TableIndirection["v309%0"] = nil;
		while true do
			if (TABLE_TableIndirection["v308%0"] == (0 - 0)) then
				TABLE_TableIndirection["v309%0"] = 0 - 0;
				while true do
					if (TABLE_TableIndirection["v309%0"] == (1494 - (1307 + 187))) then
						TABLE_TableIndirection["v97%0"][v256]:Remove();
						TABLE_TableIndirection["v97%0"][v256] = nil;
						break;
					end
				end
				break;
			end
		end
	end
end
for v257, v258 in pairs(workspace:GetChildren()) do
	if (v258:FindFirstChild(v7("\57\166\176\192\73\169", "\86\123\201\196\180\38\196\194")) and v258:FindFirstChild(v7("\223\233\215\171\251\237\202", "\207\151\136\185")) and v258:FindFirstChild(v7("\156\140\56", "\17\200\227\72\226\20\24"))) then
		v98(v258);
	end
end
game.Workspace.ChildAdded:Connect(function(v259)
	TABLE_TableIndirection["v260%0"] = 0 - 0;
	TABLE_TableIndirection["v261%0"] = nil;
	TABLE_TableIndirection["v262%0"] = nil;
	TABLE_TableIndirection["v263%0"] = nil;
	while true do
		if (TABLE_TableIndirection["v260%0"] == (0 - 0)) then
			TABLE_TableIndirection["v357%0"] = 0 - 0;
			while true do
				if (TABLE_TableIndirection["v357%0"] == (684 - (232 + 451))) then
					TABLE_TableIndirection["v260%0"] = 1;
					break;
				end
				if (TABLE_TableIndirection["v357%0"] == 0) then
					TABLE_TableIndirection["v261%0"] = v259:WaitForChild(v7("\146\78\15\195\198\252", "\159\208\33\123\183\169\145\143"), 2 + 0);
					TABLE_TableIndirection["v262%0"] = v259:WaitForChild(v7("\218\91\54\50\254\95\43", "\86\146\58\88"), 2 + 0);
					TABLE_TableIndirection["v357%0"] = 1;
				end
			end
		end
		if (TABLE_TableIndirection["v260%0"] == (565 - (510 + 54))) then
			TABLE_TableIndirection["v263%0"] = v259:WaitForChild(v7("\108\208\250", "\154\56\191\138\160\206\137\86"), 2);
			if (TABLE_TableIndirection["v261%0"] and TABLE_TableIndirection["v262%0"] and TABLE_TableIndirection["v263%0"]) then
				v98(v259);
			else
				return;
			end
			break;
		end
	end
end);
game.Workspace.ChildRemoved:Connect(function(v264)
	if (v264:FindFirstChild(v7("\164\86\225\147\115\55", "\172\230\57\149\231\28\90\225")) and v264:FindFirstChild(v7("\42\171\136\214\36\222\17", "\187\98\202\230\178\72")) and v264:FindFirstChild(v7("\21\238\180", "\42\65\129\196\80"))) then
		v99(v264);
	end
end);
local function v100()
	for v288, v289 in pairs(TABLE_TableIndirection["v97%0"]) do
		TABLE_TableIndirection["v290%0"] = v288;
		if TABLE_TableIndirection["v290%0"] then
			TABLE_TableIndirection["v358%0"] = TABLE_TableIndirection["v290%0"]:FindFirstChild(v7("\32\69\73\206\24\10", "\142\98\42\61\186\119\103\98"));
			if TABLE_TableIndirection["v358%0"] then
				TABLE_TableIndirection["v426%0"] = 0 - 0;
				TABLE_TableIndirection["v427%0"] = nil;
				TABLE_TableIndirection["v428%0"] = nil;
				TABLE_TableIndirection["v429%0"] = nil;
				TABLE_TableIndirection["v430%0"] = nil;
				TABLE_TableIndirection["v431%0"] = nil;
				TABLE_TableIndirection["v432%0"] = nil;
				while true do
					if (TABLE_TableIndirection["v426%0"] == (38 - (13 + 23))) then
						TABLE_TableIndirection["v432%0"] = v7("\99\229\231\203\12\173\103\229\227\218\7", "\141\36\151\130\174\98");
						if TABLE_TableIndirection["v428%0"] then
							TABLE_TableIndirection["v519%0"] = 0 - 0;
							TABLE_TableIndirection["v520%0"] = nil;
							while true do
								if ((0 - 0) == TABLE_TableIndirection["v519%0"]) then
									TABLE_TableIndirection["v520%0"] = math.clamp(TABLE_TableIndirection["v431%0"] / 3, 1 - 0, 1102 - (830 + 258));
									v289.Position = Vector2.new(TABLE_TableIndirection["v427%0"].X, TABLE_TableIndirection["v427%0"].Y - TABLE_TableIndirection["v520%0"]);
									TABLE_TableIndirection["v519%0"] = 1;
								end
								if (TABLE_TableIndirection["v519%0"] == (6 - 4)) then
									if (TABLE_TableIndirection["v55%0"].GreenCrate == true) then
										v289.Visible = true;
									else
										v289.Visible = false;
									end
									break;
								end
								if (TABLE_TableIndirection["v519%0"] == (1 + 0)) then
									v289.Text = TABLE_TableIndirection["v432%0"] .. v7("\196\65", "\109\228\26\162") .. TABLE_TableIndirection["v430%0"] .. v7("\77\216", "\134\62\133\157\24\128");
									v289.Size = math.clamp((26 + 4) - TABLE_TableIndirection["v431%0"], 1453 - (860 + 581), 20);
									TABLE_TableIndirection["v519%0"] = 7 - 5;
								end
							end
						else
							v289.Visible = false;
						end
						break;
					end
					if (TABLE_TableIndirection["v426%0"] == 1) then
						TABLE_TableIndirection["v430%0"] = math.floor((TABLE_TableIndirection["v11%0"].CFrame.Position - TABLE_TableIndirection["v429%0"].Position).magnitude);
						TABLE_TableIndirection["v431%0"] = (TABLE_TableIndirection["v11%0"].CFrame.Position - TABLE_TableIndirection["v358%0"].Position).Magnitude;
						TABLE_TableIndirection["v426%0"] = 2;
					end
					if (TABLE_TableIndirection["v426%0"] == 0) then
						TABLE_TableIndirection["v427%0"], TABLE_TableIndirection["v428%0"] = TABLE_TableIndirection["v11%0"]:WorldToViewportPoint(TABLE_TableIndirection["v358%0"].Position + Vector3.new(0 + 0, 241 - (237 + 4), 0 - 0));
						TABLE_TableIndirection["v429%0"] = v288:FindFirstChild(v7("\26\176\22\28\55\178", "\104\88\223\98"));
						TABLE_TableIndirection["v426%0"] = 1;
					end
				end
			else
				v289.Visible = false;
			end
		else
			v289.Visible = false;
		end
	end
end
TABLE_TableIndirection["v12%0"].RenderStepped:Connect(function()
	TABLE_TableIndirection["v265%0"] = 0 - 0;
	TABLE_TableIndirection["v266%0"] = nil;
	while true do
		if (TABLE_TableIndirection["v265%0"] == (1 - 0)) then
			v100();
			v96();
			v92();
			v88();
			TABLE_TableIndirection["v265%0"] = 2 + 0;
		end
		if ((2 + 0) == TABLE_TableIndirection["v265%0"]) then
			v84(TABLE_TableIndirection["v266%0"]);
			if (TABLE_TableIndirection["v17%0"] == true) then
				game.Lighting.Ambient = Color3.new(3 - 2, 1 + 0, 1);
				game.Lighting.OutdoorAmbient = Color3.new(1 + 0, 1427 - (85 + 1341), 1 - 0);
			end
			if (TABLE_TableIndirection["v18%0"] == true) then
				game.Lighting.FogEnd = math.huge;
			end
			if (TABLE_TableIndirection["v19%0"] == true) then
				game.Lighting.GlobalShadows = false;
			else
				game.Lighting.GlobalShadows = true;
			end
			break;
		end
		if (TABLE_TableIndirection["v265%0"] == (0 - 0)) then
			TABLE_TableIndirection["v266%0"] = v83();
			v82();
			v73();
			v69();
			TABLE_TableIndirection["v265%0"] = 373 - (45 + 327);
		end
	end
end);
TABLE_TableIndirection["v15%0"]:SendNotification(v7("\41\170\14\208\41\184\213\6\177\19\214\33", "\182\103\197\122\185\79\209"), 9 - 4, Color3.new(757 - (444 + 58), 0 + 0, 0 + 0));
