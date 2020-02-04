---------------------------------------------------------
-- Lua Password Generator                              --
-- Version 1                                           --
--                                                     --
-- (C) 2020 IARD                                       --
-- Licensed under the GNU GPLv3                        --
--                                                     --
-- Using the GUI libraries from                        --
-- https://github.com/adriweb/EEPro-for-Nspire         --
--                                                     --
-- Password generator based on                         --
-- https://rosettacode.org/wiki/Password_generator#Lua --
---------------------------------------------------------

platform.apilevel = '2.0'  

function randPW (length, includeSpecials)
    local index, pw, rnd = 0, ""
    local normals = {
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
        "abcdefghijklmnopqrstuvwxyz",
        "0123456789"
	}
    local specials = {
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
        "abcdefghijklmnopqrstuvwxyz",
        "0123456789",
        "!#$%&()*+,-./:;<=>?@[]^_{|}~"
    }
	local chars = ""
	if includeSpecials == "Yes" then 
		chars = specials
	else
		chars = normals
	end
    repeat
        index = index + 1
        rnd = math.random(chars[index]:len())
        if math.random(2) == 1 then
            pw = pw .. chars[index]:sub(rnd, rnd)
        else
            pw = chars[index]:sub(rnd, rnd) .. pw
        end
        index = index % #chars
    until pw:len() >= length
    return pw
end


do
	mainWindow	= Dialog("Lua Password Generator", 10, 10, 300, 190)
	
    local label1 = sLabel ("PassGen v. 1")
    mainWindow:appendWidget(label1, 10, 35)
	label1.font = {"sansserif", "b", 12}

    local label2 = sLabel ("(C)2020 by IARD")
    mainWindow:appendWidget(label2, 10, 55)

    local label3 = sLabel ("Length")
    mainWindow:appendWidget(label3, 10, 80)

    local input1 = sDropdown({4, 6, 8, 10, 12, 14, 16})
	input1.value = 8
	
	function input1:enterKey()
    end
    mainWindow:appendWidget(input1, 10, 100)

    local label4 = sLabel ("Special chars")
    mainWindow:appendWidget(label4, 150, 80)

    local input2 = sDropdown({"Yes", "No"})
	input2.value = "Yes"
	
	function input2:enterKey()
    end
    mainWindow:appendWidget(input2, 150, 100)

    local button1 = sButton ("Generate")
    mainWindow:appendWidget(button1, -10, -10)

	function button1:action()
		math.randomseed(timer.getMilliSecCounter())
        local dialog = Dialog("Password", 10, 20, 220, 160)

		local text = randPW(input1.value, input2.value)
		
        local pwdLabel = sLabel (text)
		pwdLabel.font = {"sansserif", "b", 14}
        dialog:appendWidget(pwdLabel, 10, 35)

        local cpyLabel = sLabel ("Password will be copied to clipboard")
		cpyLabel.font = {"sansserif", "r", 9}
        dialog:appendWidget(cpyLabel, 10, 75)

        local closeButton = sButton ("Close")
        dialog:appendWidget(closeButton, -10, -10)
		
		function closeButton:action()
			clipboard.addText(text)
			remove_screen(dialog)
        end

		closeButton:giveFocus()
        push_screen_direct(dialog)
    end

	button1:giveFocus()
	push_screen_direct(mainWindow)

end