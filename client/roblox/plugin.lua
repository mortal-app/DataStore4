local pluginName = "Data Store 4 (v1.0)"

local StudioService = game:GetService("StudioService")
local toolbar = plugin:CreateToolbar(pluginName)

local toolbarBtn_main = toolbar:CreateButton("Menu", "Open main menu", "rbxassetid://9603104210")
local toolbarBtn_script = toolbar:CreateButton("Summon Script", "Summon lib script", "rbxassetid://9581591695")

local WidgetInfo = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Left,true,false,350,300,350)

local WIDGET = plugin:CreateDockWidgetPluginGui("ds4-menu", WidgetInfo)
WIDGET.Title = pluginName

local FRAME = script.Parent["widget"]
FRAME.Parent = WIDGET

local ViewPage = FRAME.content["view-db"]
local ReqPage = FRAME.content["send-rq"]
local CredPage = FRAME.content["server-cd"]

local HttpService = game:GetService("HttpService")

-- Functions

local function encode(dataFields)	

	local data = ""
	for k, v in pairs(dataFields) do
		data = data .. ("&%s=%s"):format(
		HttpService:UrlEncode(k),
		HttpService:UrlEncode(v)
		)
	end
	return data
end

local function testScript()
	local con = false
	
	if game:GetService("ServerScriptService"):FindFirstChild('DataStore4')  then
		 con = true
	end
	
	if not con then
		local cloneScript = script.Parent.InjectScripts.ds4
		local new = cloneScript:Clone()
		new.Parent = game:GetService("ServerScriptService")
		new.Name = 'DataStore4'
	end
	
	if game:GetService("ServerScriptService"):FindFirstChild('DataStore4')  then
		con = true
	end
	
	if con then
		FRAME.hide.Visible = false
	else
		FRAME.hide.Visible = true
	end
end

local function viewTable()
	local ds4 = require(game:GetService("ServerScriptService").DataStore4)
	local HttpService = game:GetService("HttpService")

	local response = ds4.tables()

	local c = FRAME.content["view-db"].viewTables:GetChildren('tableName')
	for i = 1,#c do
		if c[i].Name == "tableName" then
			c[i]:Destroy()
		end
	end

	if response.ReturnCode == 1 then
		for _, tableName in ipairs(response.response) do
			local table1 = Instance.new("Frame")
			local TextButton = Instance.new("TextButton")
			local UIGridLayout = Instance.new("UIGridLayout")

			table1.Name = "tableName"
			table1.Parent = FRAME.content["view-db"].viewTables
			table1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			table1.Size = UDim2.new(0, 100, 0, 100)

			TextButton.Name = "btn"
			TextButton.Parent = table1
			TextButton.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
			TextButton.BorderColor3 = Color3.fromRGB(34, 34, 34)
			TextButton.Size = UDim2.new(0, 200, 0, 50)
			TextButton.Font = Enum.Font.RobotoMono
			TextButton.Text = " ➡ " .. tableName
			TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextButton.TextSize = 14.000
			TextButton.TextXAlignment = Enum.TextXAlignment.Left

			UIGridLayout.Parent = table1
			UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
			UIGridLayout.CellSize = UDim2.new(1, 0, 0, 30)

			local function UOYR_fake_script()
				local script = Instance.new('Script', TextButton)

				-- Start code
				function tablelength(T)
					local count = 0
					for _ in pairs(T) do count = count + 1 end
					return count
				end
				
				TextButton.MouseButton1Up:Connect(function()
					local ds4 = require(game:GetService("ServerScriptService").DataStore4)
					local HttpService = game:GetService("HttpService")

					local response = ds4.rows(tableName, 10, 0)
					
					local c = FRAME.content["view-db"].viewRows:GetChildren('rowData')
					for i = 1,#c do
						if c[i].Name == "rowData" then
							c[i]:Destroy()
						end
					end
					
					if response.ReturnCode == 1 then

						local displayKeys = false
						local loopIndex = 0

						for k,v in pairs(response.response) do
							if displayKeys then
								local ScrollingFrame = Instance.new("ScrollingFrame")
								local UIListLayout = Instance.new("UIListLayout")

								ScrollingFrame.Name = "rowData"
								ScrollingFrame.Parent = FRAME.content["view-db"].viewRows
								ScrollingFrame.Active = true
								ScrollingFrame.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
								ScrollingFrame.BorderColor3 = Color3.fromRGB(34, 34, 34)
								ScrollingFrame.BorderSizePixel = 0
								ScrollingFrame.Transparency = 0
								ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
								ScrollingFrame.Size = UDim2.new(0, 100, 0, 100)
								ScrollingFrame.CanvasSize = UDim2.new(0, (tablelength(v) * 150) - 100, 0, 0)
								ScrollingFrame.ScrollBarThickness = 4

								UIListLayout.Parent = ScrollingFrame
								UIListLayout.Padding = UDim.new(0, 0)
								UIListLayout.FillDirection = Enum.FillDirection.Horizontal
								UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
								UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

								local TextLabel = Instance.new("TextLabel")
								TextLabel.Parent = ScrollingFrame
								TextLabel.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
								TextLabel.BorderColor3 = Color3.fromRGB(34, 34, 34)
								TextLabel.BorderSizePixel = 2
								TextLabel.Size = UDim2.new(0, 50, 1, -8)
								TextLabel.Font = Enum.Font.SourceSans
								TextLabel.LineHeight = 3.000
								TextLabel.Text = ' ' .. loopIndex
								TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
								TextLabel.TextSize = 15.000
								TextLabel.TextWrapped = true
								TextLabel.TextXAlignment = Enum.TextXAlignment.Left

								for k2,v2 in pairs(v) do
									local TextLabel = Instance.new("TextLabel")
									TextLabel.Parent = ScrollingFrame
									TextLabel.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
									TextLabel.BorderColor3 = Color3.fromRGB(34, 34, 34)
									TextLabel.BorderSizePixel = 2
									TextLabel.Size = UDim2.new(0, 150, 1, -8)
									TextLabel.Font = Enum.Font.SourceSans
									TextLabel.LineHeight = 3.000
									TextLabel.Text = ' ' .. v2
									TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
									TextLabel.TextSize = 15.000
									TextLabel.TextWrapped = true
									TextLabel.TextXAlignment = Enum.TextXAlignment.Left
								end
							else
								local ScrollingFrame = Instance.new("ScrollingFrame")
								local UIListLayout = Instance.new("UIListLayout")

								ScrollingFrame.Name = "rowData"
								ScrollingFrame.Parent = FRAME.content["view-db"].viewRows
								ScrollingFrame.Active = true
								ScrollingFrame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
								ScrollingFrame.BorderColor3 = Color3.fromRGB(46, 46, 46)
								ScrollingFrame.BorderSizePixel = 0
								ScrollingFrame.Transparency = 0
								ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
								ScrollingFrame.Size = UDim2.new(0, 100, 0, 100)
								ScrollingFrame.CanvasSize = UDim2.new(0, (tablelength(v) * 150) - 100, 0, 0)
								ScrollingFrame.ScrollBarThickness = 4

								UIListLayout.Parent = ScrollingFrame
								UIListLayout.Padding = UDim.new(0, 0)
								UIListLayout.FillDirection = Enum.FillDirection.Horizontal
								UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
								UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

								local TextLabel = Instance.new("TextLabel")
								TextLabel.Parent = ScrollingFrame
								TextLabel.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
								TextLabel.BorderColor3 = Color3.fromRGB(46, 46, 46)
								TextLabel.BorderSizePixel = 2
								TextLabel.Size = UDim2.new(0, 50, 1, -8)
								TextLabel.Font = Enum.Font.SourceSans
								TextLabel.LineHeight = 3.000
								TextLabel.Text = ' #'
								TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
								TextLabel.TextSize = 15.000
								TextLabel.TextWrapped = true
								TextLabel.TextXAlignment = Enum.TextXAlignment.Left

								for k2,v2 in pairs(v) do
									local TextLabel = Instance.new("TextLabel")
									TextLabel.Parent = ScrollingFrame
									TextLabel.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
									TextLabel.BorderColor3 = Color3.fromRGB(46, 46, 46)
									TextLabel.BorderSizePixel = 2
									TextLabel.Size = UDim2.new(0, 150, 1, -8)
									TextLabel.Font = Enum.Font.SourceSans
									TextLabel.LineHeight = 3.000
									TextLabel.Text = ' ' .. k2
									TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
									TextLabel.TextSize = 15.000
									TextLabel.TextWrapped = true
									TextLabel.TextXAlignment = Enum.TextXAlignment.Left
								end

								local ScrollingFrame = Instance.new("ScrollingFrame")
								local UIListLayout = Instance.new("UIListLayout")

								ScrollingFrame.Name = "rowData"
								ScrollingFrame.Parent = FRAME.content["view-db"].viewRows
								ScrollingFrame.Active = true
								ScrollingFrame.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
								ScrollingFrame.BorderColor3 = Color3.fromRGB(34, 34, 34)
								ScrollingFrame.BorderSizePixel = 0
								ScrollingFrame.Transparency = 0
								ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
								ScrollingFrame.Size = UDim2.new(0, 100, 0, 100)
								ScrollingFrame.CanvasSize = UDim2.new(0, (tablelength(v) * 150) - 100, 0, 0)
								ScrollingFrame.ScrollBarThickness = 4

								UIListLayout.Parent = ScrollingFrame
								UIListLayout.Padding = UDim.new(0, 0)
								UIListLayout.FillDirection = Enum.FillDirection.Horizontal
								UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
								UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

								local TextLabel = Instance.new("TextLabel")
								TextLabel.Parent = ScrollingFrame
								TextLabel.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
								TextLabel.BorderColor3 = Color3.fromRGB(34, 34, 34)
								TextLabel.BorderSizePixel = 2
								TextLabel.Size = UDim2.new(0, 50, 1, -8)
								TextLabel.Font = Enum.Font.SourceSans
								TextLabel.LineHeight = 3.000
								TextLabel.Text = ' ' .. loopIndex
								TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
								TextLabel.TextSize = 15.000
								TextLabel.TextWrapped = true
								TextLabel.TextXAlignment = Enum.TextXAlignment.Left

								for k2,v2 in pairs(v) do
									local TextLabel = Instance.new("TextLabel")
									TextLabel.Parent = ScrollingFrame
									TextLabel.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
									TextLabel.BorderColor3 = Color3.fromRGB(34, 34, 34)
									TextLabel.BorderSizePixel = 2
									TextLabel.Size = UDim2.new(0, 150, 1, -8)
									TextLabel.Font = Enum.Font.SourceSans
									TextLabel.LineHeight = 3.000
									TextLabel.Text = ' ' .. v2
									TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
									TextLabel.TextSize = 15.000
									TextLabel.TextWrapped = true
									TextLabel.TextXAlignment = Enum.TextXAlignment.Left
								end
								displayKeys = true
							end

							loopIndex += 1
						end
					else
						local table1 = Instance.new("Frame")
						local TextButton = Instance.new("TextButton")
						local UIGridLayout = Instance.new("UIGridLayout")

						table1.Name = "rowData"
						table1.Parent = FRAME.content["view-db"].viewRows
						table1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						table1.Size = UDim2.new(0, 100, 0, 100)

						TextButton.Name = "btn"
						TextButton.Parent = table1
						TextButton.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
						TextButton.BorderColor3 = Color3.fromRGB(34, 34, 34)
						TextButton.Size = UDim2.new(0, 200, 0, 50)
						TextButton.Font = Enum.Font.RobotoMono
						TextButton.Text = " Error connecting to db, Try reload your studio"
						TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
						TextButton.TextSize = 14.000
						TextButton.TextXAlignment = Enum.TextXAlignment.Left

						UIGridLayout.Parent = table1
						UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
						UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
						UIGridLayout.CellSize = UDim2.new(1, 0, 0, 30)
					end
					
					TextButton.Parent.Parent.Visible = false
					TextButton.Parent.Parent.Parent.viewRows.Visible = true
				end)
				-- End code
			end

			coroutine.wrap(UOYR_fake_script)()

		end
	else
		local table1 = Instance.new("Frame")
		local TextButton = Instance.new("TextButton")
		local UIGridLayout = Instance.new("UIGridLayout")

		table1.Name = "tableName"
		table1.Parent = FRAME.content["view-db"].viewTables
		table1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		table1.Size = UDim2.new(0, 100, 0, 100)

		TextButton.Name = "btn"
		TextButton.Parent = table1
		TextButton.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
		TextButton.BorderColor3 = Color3.fromRGB(34, 34, 34)
		TextButton.Size = UDim2.new(0, 200, 0, 50)
		TextButton.Font = Enum.Font.RobotoMono
		TextButton.Text = " Error connecting to db, Try reload your studio"
		TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton.TextSize = 14.000
		TextButton.TextXAlignment = Enum.TextXAlignment.Left

		UIGridLayout.Parent = table1
		UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
		UIGridLayout.CellSize = UDim2.new(1, 0, 0, 30)
	end
end

-- ToolBar Btns

FRAME.hide.Visible = false
if pcall(viewTable) then
	viewTable()
else
	local table1 = Instance.new("Frame")
	local TextButton = Instance.new("TextButton")
	local UIGridLayout = Instance.new("UIGridLayout")

	table1.Name = "tableName"
	table1.Parent = FRAME.content["view-db"].viewTables
	table1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	table1.Size = UDim2.new(0, 100, 0, 100)

	TextButton.Name = "btn"
	TextButton.Parent = table1
	TextButton.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
	TextButton.BorderColor3 = Color3.fromRGB(34, 34, 34)
	TextButton.Size = UDim2.new(0, 200, 0, 50)
	TextButton.Font = Enum.Font.RobotoMono
	TextButton.Text = " Error connecting to db, Try reload your studio"
	TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextButton.TextSize = 14.000
	TextButton.TextXAlignment = Enum.TextXAlignment.Left

	UIGridLayout.Parent = table1
	UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
	UIGridLayout.CellSize = UDim2.new(1, 0, 0, 30)
end

toolbarBtn_main.Click:Connect(function()
	if WIDGET.Enabled then
		WIDGET.Enabled = false
	else
		WIDGET.Enabled = true
	end
end)

toolbarBtn_script.Click:Connect(function()
	local cloneScript = script.Parent.InjectScripts.ds4
	local new = cloneScript:Clone()
	new.Parent = game:GetService("ServerScriptService")
	new.Name = 'DataStore4'
end)

-- Menu Btns

FRAME.nav["view-db"].btn.MouseButton1Up:Connect(function()
	
	ViewPage.Visible = true
	ViewPage.viewRows.Visible = false
	ViewPage.viewTables.Visible = true
	
	ReqPage.Visible = false
	CredPage.Visible = false
	
	viewTable()
end)

FRAME.nav["send-rq"].btn.MouseButton1Up:Connect(function()
	ViewPage.Visible = false
	ReqPage.Visible = true
	CredPage.Visible = false
end)

FRAME.nav["server-cd"].btn.MouseButton1Up:Connect(function()
	ViewPage.Visible = false
	ReqPage.Visible = false
	CredPage.Visible = true
	
	local ds4 = game:GetService("ServerScriptService").DataStore4
	
	FRAME.content["server-cd"].host.TextBox.Text = ds4.host.Value
	FRAME.content["server-cd"].key.TextBox.Text = ds4.key.Value
	
end)

-- Update server creds
FRAME.content["server-cd"].submit.TextButton.MouseButton1Up:Connect(function()
	local ds4Script = game:GetService("ServerScriptService").DataStore4
	local ds4 = require(game:GetService("ServerScriptService").DataStore4)
	local host = FRAME.content["server-cd"].host.TextBox.Text
	local key = FRAME.content["server-cd"].key.TextBox.Text
	
	local work = false
	
	local function qt()
		local url = "http://"..host.."/api/test/"
		local dataFields = {
			["key"] = key;
		}

		local data = encode(dataFields)

		local response = HttpService:PostAsync(url, data, Enum.HttpContentType.ApplicationUrlEncoded, false)
		local data = HttpService:JSONDecode(response)

		return data
	end
	
	qt()
	
	if pcall(qt)  then
		local test = qt()
		if test.ReturnCode == 1 then
			work = true
		end
	end
	
	if work then
		ds4Script.host.Value = host
		ds4Script.key.Value = key
		FRAME.content["server-cd"].submit.TextButton.Text = "Connection Success"
	else
		FRAME.content["server-cd"].submit.TextButton.Text = "Connection Failed"
	end
	
end)
