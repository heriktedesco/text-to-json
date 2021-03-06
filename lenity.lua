--[[ Version retrieved from http://github.com/LPLBrasil/lenity commit a3804fe024e66d5ec045e06cb9d03bcef3f5f020 ]]--

function verifyZ()
	verifyZenity = os.execute('which zenity')
	if verifyZenity == nil then
		print("Zenity isn't installed on this system or isn't reacheable within the $PATH of the system.")
    print("If you are using a Debian based distro, install it using the command $sudo apt-get install zenity")
    print("If you are using Mac OSX, install it with brew using the command $brew install zenity")
		return false
	else
		return true
	end
end

if verifyZ() then
	local z = {}
		function z.checkTitle(title)
			if title == nil or title == 0 then
				title = ''
			else
				assert(type(title) == 'string', "Input Error: 'title' isn't a valid string")
				title = ' --title="'..title..'"'
			end
			return title
		end

		function z.checkText(text)
			if text == nil or text == 0 then
				text = ''
			else
				assert(type(text) == 'string', "Input Error: 'text' isn't a valid string")
				text = ' --text="'..text..'"'
			end
			return text
		end

		function z.checkShowPalette(showPalette)
			if showPalette == nil or showPalette == 0 then
				showPalette = ''
			else
				assert(type(showPalette) == 'boolean', "Input Error: 'showPallete isn't a boolean")
				if showPalette then
					showPalette = ' --show-palette'
				else
					showPalette = ''
				end
			end
			return showPalette
		end

		function z.checkIsPassword(isPassword)
			if isPassword == nil or isPassword == 0 then
				isPassword = ''
			else
				assert(type(isPassword) == 'boolean', "Input Error: 'isPassword' isn't a boolean")
				if isPassword then
					isPassword = ' --hide-text'
				else
					isPassword = ''
				end
			end
			return isPassword
		end

		function z.checkDimensions(vector, x)
			if x == 0 or x == nil then
				x = ''
			else
				assert(vector == 'height' or vector == 'width', "Input Error: 'vector' must be height or width")
				assert(type(x) == 'number', "Input Error: 'x' isn't a number")
				if vector == 'height' then
					x = ' --height='..tostring(x)
				elseif vector == 'width' then
					x = ' --width='..tostring(x)
				end
			end
			return x
		end

		function z.checkTimeout(timeout)
			if timeout == 0 or timeout == nil then
				timeout = ''
			else
				assert(type(timeout) == 'number', "Input Error: 'timeout' isn't a number")
				timeout = ' --timeout='..tostring(timeout)
			end
			return timeout
		end

		function z.checkEntryText(entryText)
			if entryText == nil or entryText == 0 then
				entryText = ''
			else
				assert(type(entryText) == 'string', "Input Error: 'entryText' isn't a string")
				entryText = ' --entry-text="'..entryText..'"'
			end
			return entryText
		end

		function z.checkWindowIcon(windowIcon)
			--TODO: Due to a know bug on zenity this function is not yet implemented...
			-- Bug: https://bugs.launchpad.net/ubuntu/+source/zenity/+bug/998491
			print("WARNING: Due to a know bug on zenity this function is not yet implemented...")
			windowIcon = ''
			return windowIcon
		end

		function z.checkNoWrap(noWrap)
			if noWrap == 0 or noWrap == nil then
				noWrap = ''
			else
				if noWrap then
					assert(type(noWrap) == 'boolean', "Input Error: 'noWrap' isn't a boolean value")
					noWrap = ' --no-wrap'
				else
					noWrap = ''
				end
			end
			return noWrap
		end

		function z.checkNoMarkup(noMarkup)
			if noMarkup == 0 or noMarkup == nil then
				noMarkup = ''
			else
				if noMarkup then
					assert(type(noMarkup) == 'boolean', "Input Error: 'noMarkup' isn't a boolean value")
					noMarkup = ' --no-markup'
				else
					assert(type(noMarkup) == 'boolean', "Input Error: 'noMarkup' isn't a boolean value")
					noMarkup = ''
				end
			end
			return noMarkup
		end

		function z.buildHex(showPalette, r, g, b)
			assert(type(showPalette) == 'boolean', "Input Error: 'showPalette' isn't a boolean value")
			if showPalette == false then
				assert(r >= 0 and r < 256, "Input Error: 'r' isn't a valid RGB value")
				assert(g >= 0 and g < 256, "Input Error: 'g' isn't a valid RGB value")
				assert(b >= 0 and b < 256, "Input Error: 'b' isn't a valid RGB value")
				r = string.format("%x", r)
				g = string.format("%x", g)
				b = string.format("%x", b)
				--[[
				TODO: This function below is only required because zenity sucks at
				interpreting hexadecimal colors with less than 6 chars, when zenity
				solve this idiotic problem, this can be discarded.
				]]--
				r = z.zenitySucks(r)
				g = z.zenitySucks(g)
				b = z.zenitySucks(b)
				color = ' --color=#'..r..g..b
			else
				color = ''
			end
			return color
		end

		function z.zenitySucks(x)
			assert(string.len(x) < 3, "Input Error: 'x' has more than two characters")
			if string.len(x) < 2 then
				x = x..x
			end
			return x
		end

		function z.checkInitialFileName(initialFileName)
			if initialFileName == nil or initialFileName == 0 then
				initialFileName = ''
			else
				assert(type(initialFileName) == 'string', "Input Error: 'initialFileName' isn't a valid string")
				initialFileName = ' --filename='..tostring(initialFileName)
			end
			return initialFileName
		end

		function z.checkIfOverwriteMsg(overwriteMsg)
			if overwriteMsg == nil or overwriteMsg == 0 then
				overwriteMsg = ''
			else
				assert(type(overwriteMsg) == 'boolean', "Input Error: 'overwriteMsg' isn't a boolean value")
				if overwriteMsg then
					overwriteMsg = ' --confirm-overwrite'
				else
					overwriteMsg = ''
				end
			end
			return overwriteMsg
		end

		function z.checkIfSave(isSave)
			if isSave == nil or isSave == 0 then
				isSave = ''
			else
				assert(type(isSave) == 'boolean', "Input Error: 'isSave' isn't a boolean value")
				if isSave then
					isSave = ' --save'
				else
					isSave = ''
				end
			end
			return isSave
		end

		function z.checkIfDirectory(isDirectory)
			if isDirectory == false or isDirectory == nil or isDirectory == 0 then
				isDirectory = ''
			else
				assert(type(isDirectory) == 'boolean', "Input Error: 'isDirectory' isn't a boolean value")
				if isDirectory then
					isDirectory = ' --directory'
				else
					isDirectory = ''
				end
			end
			return isDirectory
		end

		function z.checkSeparator(allowMultiple, separator)
			if allowMultiple == 0 or allowMultiple == nil or allowMultiple == false then
				separator = ''
			else
				assert(type(separator) == 'string', "Input Error: 'separator' isn't a string")
				if allowMultiple then
					separator = ' --separator="'..separator..'"'
				else
					separator = ''
				end
			end
			return separator
		end

		function z.checkAllowMultiple(allowMultiple)
			if allowMultiple == 0 or allowMultiple == nil then
				allowMultiple = ''
			else
				assert(type(allowMultiple) == 'boolean', "Input Error: 'allowMultiple' isn't a boolean value")
				if allowMultiple then
					allowMultiple = ' --multiple'
				else
					allowMultiple = ''
				end
			end
			return allowMultiple
		end

		function z.checkFileFilter(fileFilter)
			mensagem = ''
			if fileFilter == 0 or fileFilter == nil then
				fileFilter = ''
			else
				assert(type(checkFileFilter) == 'table', "Input Error: 'fileFilter' isn't a valid table")
				for pos in ipairs(fileFilter) do
					mensagem = mensagem..' --file-filter="'..tostring(fileFilter[pos])..'"'
				end
			end
			return mensagem
		end

		function z.checkDate(month, day, year)
			if month == 0 or month == nil then
				date = ''
			else
				assert(type(month) == 'number', "Input Error: 'month' isn't a valid integer")
				assert(type(day) == 'number', "Input Error: 'day' isn't a valid integer")
				assert(type(year) == 'number', "Input Error: 'year' isn't a valid integer")
				assert((month < 13 and month > 0), "Input Error: 'month' isn't a valid month")
				assert((day < 32 and day > 0), "Input Error: 'day' isn't a valid day")
				date = ' --month='..month..' --day='..day..' --year='..year
			end
			return date
		end

		function z.checkDateFormat(dateFormat)
			if dateFormat == 0 or dateFormat == nil then
				dateFormat = ''
			else
				assert(type(dateFormat) == 'string', "Input Error: 'dateFormat' isn't a valid string")
				dateFormat = ' --date-format="'..dateFormat..'"'
			end
			return dateFormat
		end

		function z.checkButtonLabel(btnType, label)
			if label == nil or label == 0 then
				label = ''
			else
				message = "input Error: '"..btnType.."Label' isn't a valid string"
				assert(type(label) == 'string', message)
				if btnType == 'ok' then
					label = ' --ok-label="'..label..'"'
				elseif btnType == 'cancel' then
					label = ' --cancel-label="'..label..'"'
				end
			end
			return label
		end

		function z.checkShowUsername(showUsername)
			if showUsername == nil or showUsername == nil then
				showUsername = ''
			else
				assert(type(showUsername) == 'boolean', "Input Error: 'showUsername' isn't a valid boolean value")
				if showUsername then
					showUsername = ' --username'
				else
					showUsername = ''
				end
			end
			return showUsername
		end

		function z.checkFilename(filename)
			if filename == 0 or filename == nil then
				filename = ''
			else
				assert(type(filename) == 'string', "Input Error: Variable 'filename' isn't a valid string")
				filename = ' --filename="'..filename..'"'
			end
			return filename
		end

		function z.checkIfHasCheckbox(hasCheckbox, checkboxText)
			if hasCheckbox == 0 or hasCheckbox == nil then
				hasCheckbox = ''
			else
				assert(type(hasCheckbox) == 'boolean', "Input Error: Variable 'hasCheckbox' isn't a valid boolean")
				if checkboxText == '' or checkboxText == 0 or checkboxText == nil then
					checkboxText = "I've read and accept the terms and conditions."
				end
				if hasCheckbox then
					hasCheckbox = ' --checkbox="'..checkboxText..'"'
				else
					hasCheckbox = ''
				end
			end
			return hasCheckbox
		end

		function z.checkIfIsEditable(isEditable)
			if isEditable == 0 or isEditable == nil then
				isEditable = ''
			else
				assert(type(isEditable) == 'boolean', "Input Error: 'isEditable' isn't a valid boolean")
				if isEditable then
					isEditable = ' --editable'
				else
					isEditable = ''
				end
			end
			return isEditable
		end

		function z.checkIcons(icon)
			if icon == 0 or icon == nil then
				return ''
			else
				assert(type(icon) == 'string', "Input Error: The 'icon' variable isn't a string")
				inList = false
				iconsList = {
					"address-book-new",
					"application-exit",
					"appointment-new",
					"call-start",
					"call-stop",
					"contact-new",
					"document-new",
					"document-open",
					"document-open-recent",
					"document-page-setup",
					"document-print",
					"document-print-preview",
					"document-properties",
					"document-revert",
					"document-save",
					"document-save-as",
					"document-send",
					"edit-clear",
					"edit-copy",
					"edit-cut",
					"edit-delete",
					"edit-find",
					"edit-find-replace",
					"edit-paste",
					"edit-redo",
					"edit-select-all",
					"edit-undo",
					"folder-new",
					"format-indent-less",
					"format-indent-more",
					"format-justify-center",
					"format-justify-fill",
					"format-justify-left",
					"format-justify-right",
					"format-text-direction-ltr",
					"format-text-direction-rtl",
					"format-text-bold",
					"format-text-italic",
					"format-text-underline",
					"format-text-strikethrough",
					"go-bottom",
					"go-down",
					"go-first",
					"go-home",
					"go-jump",
					"go-last",
					"go-next",
					"go-previous",
					"go-top",
					"go-up",
					"help-about",
					"help-contents",
					"help-faq",
					"insert-image",
					"insert-link",
					"insert-object",
					"insert-text",
					"list-add",
					"list-remove",
					"mail-forward",
					"mail-mark-important",
					"mail-mark-junk",
					"mail-mark-notjunk",
					"mail-mark-read",
					"mail-mark-unread",
					"mail-message-new",
					"mail-reply-all",
					"mail-reply-sender",
					"mail-send",
					"mail-send-receive",
					"media-eject",
					"media-playback-pause",
					"media-playback-start",
					"media-playback-stop",
					"media-record",
					"media-seek-backward",
					"media-seek-forward",
					"media-skip-backward",
					"media-skip-forward",
					"object-flip-horizontal",
					"object-flip-vertical",
					"object-rotate-left",
					"object-rotate-right",
					"process-stop",
					"system-lock-screen",
					"system-log-out",
					"system-run",
					"system-search",
					"system-reboot",
					"system-shutdown",
					"tools-check-spelling",
					"view-fullscreen",
					"view-refresh",
					"view-restore",
					"view-sort-ascending",
					"view-sort-descending",
					"window-close",
					"window-new",
					"zoom-fit-best",
					"zoom-in",
					"zoom-original",
					"zoom-out",
					"process-working",
					"accessories-calculator",
					"accessories-character-map",
					"accessories-dictionary",
					"accessories-text-editor",
					"help-browser",
					"multimedia-volume-control",
					"preferences-desktop-accessibility",
					"preferences-desktop-font",
					"preferences-desktop-keyboard",
					"preferences-desktop-locale",
					"preferences-desktop-multimedia",
					"preferences-desktop-screensaver",
					"preferences-desktop-theme",
					"preferences-desktop-wallpaper",
					"system-file-manager",
					"system-software-install",
					"system-software-update",
					"utilities-system-monitor",
					"utilities-terminal",
					"applications-accessories",
					"applications-development",
					"applications-engineering",
					"applications-games",
					"applications-graphics",
					"applications-internet",
					"applications-multimedia",
					"applications-office",
					"applications-other",
					"applications-science",
					"applications-system",
					"applications-utilities",
					"preferences-desktop",
					"preferences-desktop-peripherals",
					"preferences-desktop-personal",
					"preferences-other",
					"preferences-system",
					"preferences-system-network",
					"system-help",
					"audio-card",
					"audio-input-microphone",
					"battery",
					"camera-photo",
					"camera-video",
					"camera-web",
					"computer",
					"drive-harddisk",
					"drive-optical",
					"drive-removable-media",
					"input-gaming",
					"input-keyboard",
					"input-mouse",
					"input-tablet",
					"media-flash",
					"media-floppy",
					"media-optical",
					"media-tape",
					"modem",
					"multimedia-player",
					"network-wired",
					"network-wireless",
					"pda",
					"phone",
					"printer",
					"scanner",
					"video-display",
					"emblem-default",
					"emblem-documents",
					"emblem-downloads",
					"emblem-favorite",
					"emblem-important",
					"emblem-mail",
					"emblem-photos",
					"emblem-readonly",
					"emblem-shared",
					"emblem-symbolic-link",
					"emblem-synchronized",
					"emblem-system",
					"emblem-unreadable",
					"face-angel",
					"face-angry",
					"face-cool",
					"face-crying",
					"face-devilish",
					"face-embarrassed",
					"face-kiss",
					"face-laugh",
					"face-monkey",
					"face-plain",
					"face-raspberry",
					"face-sad",
					"face-sick",
					"face-smile",
					"face-smile-big",
					"face-smirk",
					"face-surprise",
					"face-tired",
					"face-uncertain",
					"face-wink",
					"face-worried",
					"flag-aa",
					"application-x-executable",
					"audio-x-generic",
					"font-x-generic",
					"image-x-generic",
					"package-x-generic",
					"text-html",
					"text-x-generic",
					"text-x-generic-template",
					"text-x-script",
					"video-x-generic",
					"x-office-address-book",
					"x-office-calendar",
					"x-office-document",
					"x-office-presentation",
					"x-office-spreadsheet",
					"folder",
					"folder-remote",
					"network-server",
					"network-workgroup",
					"start-here",
					"user-bookmarks",
					"user-desktop",
					"user-home",
					"user-trash",
					"appointment-missed",
					"appointment-soon",
					"audio-volume-high",
					"audio-volume-low",
					"audio-volume-medium",
					"audio-volume-muted",
					"battery-caution",
					"battery-low",
					"dialog-error",
					"dialog-information",
					"dialog-password",
					"dialog-question",
					"dialog-warning",
					"folder-drag-accept",
					"folder-open",
					"folder-visiting",
					"image-loading",
					"image-missing",
					"mail-attachment",
					"mail-unread",
					"mail-read",
					"mail-replied",
					"mail-signed",
					"mail-signed-verified",
					"media-playlist-repeat",
					"media-playlist-shuffle",
					"network-error",
					"network-idle",
					"network-offline",
					"network-receive",
					"network-transmit",
					"network-transmit-receive",
					"printer-error",
					"printer-printing",
					"security-high",
					"security-medium",
					"security-low",
					"software-update-available",
					"software-update-urgent",
					"sync-error",
					"sync-synchronizing",
					"task-due",
					"task-past-due",
					"user-available",
					"user-away",
					"user-idle",
					"user-offline",
					"user-trash-full",
					"weather-clear",
					"weather-clear-night",
					"weather-few-clouds",
					"weather-few-clouds-night",
					"weather-fog",
					"weather-overcast",
					"weather-severe-alert",
					"weather-showers",
					"weather-showers-scattered",
					"weather-snow",
					"weather-storm"
				}
				for index, listItem in ipairs(iconsList) do
					if icon == listItem then
						inList = true
					end
				end
			end
			if inList then
				icon = ' --icon-name="'..icon..'"'
			else
				icon = ''
			end
			return icon
		end

		function z.entry(title, text, entryText, isPassword, width, height, timeout)
			-- call validation of fields
			title = z.checkTitle(title)
			text = z.checkText(text)
			entryText = z.checkEntryText(entryText)
			isPassword = z.checkIsPassword(isPassword)
			height = z.checkDimensions("height", height)
			width = z.checkDimensions("width", width)
			timeout = z.checkTimeout(timeout)
			-- process zenity command and return
			local command = "zenity --entry"..title..text..entryText..isPassword..width..height..timeout
			local f = io.popen(command)
			local l = f:read("*a")
			f:close()
			return l:gsub("\n","")
		end

		function z.info(title, text, icon, noWrap, width, height, timeout)
			title = z.checkTitle(title)
			text = z.checkText(text)
			icon = z.checkIcons(icon)
			noWrap = z.checkNoWrap(noWrap)
			width = z.checkDimensions('width', width)
			height = z.checkDimensions('height', height)
			timeout = z.checkTimeout(timeout)
			command = 'zenity --info'..title..text..icon..noWrap..width..height..timeout
			os.execute(command)
		end

		function z.colorselection(title, showPalette, r, g, b, timeout)
			title = z.checkTitle(title)
			showPalette = z.checkShowPalette(showPalette)
			color = z.buildHex(showPalette, r, g, b)
			timeout = z.checkTimeout(timeout)
			command = 'zenity --color-selection'..title..showPalette..color
			local f = io.popen(command)
			local l = f:read("*a")
			f:close()
			return l:gsub("\n",""):gsub("rgb%(",""):gsub("%)","")
		end

		function z.warning(title, text, icon, noWrap, width, height, timeout)
			title = z.checkTitle(title)
			text = z.checkText(text)
			icon = z.checkIcons(icon)
			noWrap = z.checkNoWrap(noWrap)
			width = z.checkDimensions('width', width)
			height = z.checkDimensions('height', height)
			timeout = z.checkTimeout(timeout)
			command = 'zenity --warning'..title..text..icon..noWrap..width..height..timeout
			os.execute(command)
		end

		function z.fileselection(title, fileFilter, allowMultiple, separator, isDirectory, isSave, overwriteMsg, initialFileName, timeout)
			title = z.checkTitle(title)
			fileFilter = z.checkFileFilter(fileFilter)
			separator = z.checkSeparator(allowMultiple, separator)
			allowMultiple = z.checkAllowMultiple(allowMultiple)
			isDirectory = z.checkIfDirectory(isDirectory)
			isSave = z.checkIfSave(isSave)
			overwriteMsg = z.checkIfOverwriteMsg(overwriteMsg)
			initialFileName = z.checkInitialFileName(initialFileName)
			timeout = z.checkTimeout(timeout)
			command = 'zenity --file-selection'..title..fileFilter..allowMultiple..separator..isDirectory..isSave..overwriteMsg..initialFileName..timeout
			local f = io.popen(command)
			local l = f:read("*a")
			return l:gsub("\n","")
		end

		function z.error(title, text, noWrap, noMarkup, width, height, timeout)
			title = z.checkTitle(title)
			text = z.checkText(text)
			noWrap = z.checkNoWrap(noWrap)
			noMarkup = z.checkNoMarkup(noMarkup)
			width = z.checkDimensions('width', width)
			height = z.checkDimensions('height', height)
			timeout = z.checkTimeout(timeout)
			command = 'zenity --error'..title..text..noWrap..noMarkup..width..height..timeout
			os.execute(command)
		end

		function z.calendar(title, text, month, day, year, dateFormat, width, height, noMarkup, timeout)
			title = z.checkTitle(title)
			text = z.checkText(text)
			noMarkup = z.checkNoMarkup(noMarkup)
			width = z.checkDimensions('width', width)
			height = z.checkDimensions('height', height)
			timeout = z.checkTimeout(timeout)
			date = z.checkDate(month, day, year)
			dateFormat = z.checkDateFormat(dateFormat)
			command = 'zenity --calendar'..title..text..date..dateFormat..width..height..noMarkup..timeout
			local f = io.popen(command)
			local l = f:read("*a")
			return l:gsub("\n","")
		end

		function z.question(title, text, okLabel, cancelLabel, noWrap, noMarkup, width, height, timeout)
			title = z.checkTitle(title)
			text = z.checkText(text)
			noMarkup = z.checkNoMarkup(noMarkup)
			width = z.checkDimensions('width', width)
			height = z.checkDimensions('height', height)
			timeout = z.checkTimeout(timeout)
			noWrap = z.checkNoWrap(noWrap)
			okLabel = z.checkButtonLabel('ok', okLabel)
			cancelLabel = z.checkButtonLabel('cancel', cancelLabel)
			command = 'zenity --question'..title..text..okLabel..cancelLabel..noWrap..noMarkup..width..height..timeout
			result = os.execute(command)
			if result == nil then
				return false
			elseif result == true then
				return result
			end
		end

		function z.notification(title, text, timeout)
			-- I decided not to use "zenity --notification" because of his bugs, exchanged to notify-send
			assert(type(title) == 'string', "Input Error: 'title' isn't a valid string")
			assert(type(text) == 'string', "Input Error: 'text' isn't a valid string")
			assert(type(timeout) == 'number', "Input Error: timeout isn't a valid number")
			timeout = timeout * 1000
			command = 'notify-send -t '..tostring(timeout)..' "'..title..'" "'..text..'"'
			os.execute(command)
		end

		function z.password(title, showUsername, okLabel, cancelLabel, noMarkup, timeout)
			--TODO: Zenity has a shitty implementation for this. Text, icon and separator are impossible to change! Shitty AF! If they ever decide to fix this, this function needs to be upgraded
			title = z.checkTitle(title)
			noMarkup = z.checkNoMarkup(noMarkup)
			timeout = z.checkTimeout(timeout)
			okLabel = z.checkButtonLabel('ok', okLabel)
			cancelLabel = z.checkButtonLabel('cancel', cancelLabel)
			showUsername = z.checkShowUsername(showUsername)
			command = 'zenity --password'..title..showUsername..okLabel..cancelLabel..noMarkup..timeout
			local f = io.popen(command)
			local l = f:read("*a")
			return l:gsub("\n","")
		end

		function z.textinfo(title, filename, isEditable, hasCheckbox, checkboxText, okLabel, cancelLabel, width, height, timeout)
			title = z.checkTitle(title)
			filename = z.checkFilename(filename)
			isEditable = z.checkIfIsEditable(isEditable)
			hasCheckbox = z.checkIfHasCheckbox(hasCheckbox, checkboxText)
			okLabel = z.checkButtonLabel('ok', okLabel)
			cancelLabel = z.checkButtonLabel('cancel', cancelLabel)
			width = z.checkDimensions('width', width)
			height = z.checkDimensions('height', height)
			timeout = z.checkTimeout(timeout)
			command = 'zenity --text-info'..title..filename..isEditable..hasCheckbox..okLabel..cancelLabel..width..height..timeout
			local f = io.popen(command)
			local l = f:read("*a")
			return l
		end

		--[[TODO: zenity --scale --title="titulo" --text="texto" --ok-label="confirma" --cancel-label="não confirma" --value=50 --min-value=0 --max-value=100 --step=5 --hide-value]]--
	return z
else
	return 'Error!'
end
