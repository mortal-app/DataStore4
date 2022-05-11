local apiKey = script.key.Value
local hostname = script.host.Value

local HttpService = game:GetService("HttpService")

local ds4 = {};

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

ds4.testConnection = function()

	local url = "http://"..hostname.."/api/test/"
	local dataFields = {
		["key"] = apiKey;
	}

	local data = encode(dataFields)

	local response = HttpService:PostAsync(url, data, Enum.HttpContentType.ApplicationUrlEncoded, false)
	local data = HttpService:JSONDecode(response)

	return data

end

ds4.tables = function()

	local url = "http://"..hostname.."/api/tables"
	local data = encode({
		["key"] = apiKey;
	})

	local response = HttpService:PostAsync(url, data, Enum.HttpContentType.ApplicationUrlEncoded, false)
	local data = HttpService:JSONDecode(response)

	return data

end

ds4.rows = function(table, limit, offset)

	local url = "http://"..hostname.."/api/rows"
	local data = encode({
		["key"] = apiKey;
		["table"] = table;
		["limit"] = limit;
		["offset"] = offset;
	})

	local response = HttpService:PostAsync(url, data, Enum.HttpContentType.ApplicationUrlEncoded, false)
	local data = HttpService:JSONDecode(response)

	return data

end

ds4.post = function(data)

	local url = "http://"..hostname.."/api/post"
	local data = encode({
		["key"] = apiKey;
		["payload"] = data;
	})

	local response = HttpService:PostAsync(url, data, Enum.HttpContentType.ApplicationUrlEncoded, false)
	local data = HttpService:JSONDecode(response)

	return data

end

ds4.get = function(data)

	local url = "http://"..hostname.."/api/get"
	local data = encode({
		["key"] = apiKey;
		["payload"] = data;
	})

	local response = HttpService:PostAsync(url, data, Enum.HttpContentType.ApplicationUrlEncoded, false)
	local data = HttpService:JSONDecode(response)

	return data

end


return ds4
