local redis = require 'redis'
local client = redis.connect('127.0.0.1', 6379)

MAX_NUMBER_OF_AGENTS = 100000
KEY_BRAND_PREFERENCES = ":consumer:brand_preferences"
NUMBER_OF_INTERVAL = 3
AREA = "Polska"
function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end


function getDataToHistogram(file)
	if not file_exists(file) then return nil end
	io.open(file, "w")
	io.output(file)	
	
	for i=1, MAX_NUMBER_OF_AGENTS do
		brandScores = client:zrange(tostring(i)..KEY_BRAND_PREFERENCES, 0, -1, "WITHSCORES")
		
		for brand, score in pairs(brandScores) do
			
		end
	end
	
	for brand, interval in pairs(tCounter) do
		for number, counter in pairs(interval) do 
			hmset(KEY_COUNTER_BRAND..brand, number, counter)
		end
	
	end
end	


local brands = {"Asus", "Dell", "Lenovo"}
--przygotowywanie pliku z danymi do histogramu 
getDataToHist = function(file)
	if not file_exists(file) then return nil end
	io.open(file, "w")
	io.output(file)
	local str = ""
	io.write("Marka\t-3\t-2\t-1\t0\t1\t2\t3\n")
	for i, brand in ipairs(brands) do
		local lines = client:zrange("counter:brand:"..brand, 0, -1, "WITHSCORES")
		print(lines)
		str = ""
		for k,v in pairs(lines) do
			str = str.."\t"..v[1]
  			
		end
		print(io.write(brand, str,"\n"))
	end
	io.close()
	return "OK"
end


local file = "dataToHistogram.dat"
getDataToHist(file)
