--[[

by DAPZ
14/03/2024

]]--


menu = 0
gg.setVisible(false)

-- Functions to read the contents of a file, filter it, and save the filter results into a new file
function filterFile(filename, keywords)
    local file = io.open(filename, "r") -- Open files in read ("r") mode
    if file then
        local content = file:read("*all") -- Read the entire content of the file
        gg.toast("Reading the file")
        file:close() -- Closing the file after reading
        
        local filteredContent = "" -- Variable to store the filter result
        
        -- Loop through each line in the file content
        for line in content:gmatch("[^\r\n]+") do
            -- Loop through each keyword you want to search for
            for _, keyword in ipairs(keywords) do
                -- If the row contains a keyword, add the row to the filter result
                if string.find(line, keyword) then
                    filteredContent = filteredContent .. line .. "\n"
                    break -- Exit the keyword search loop when found
                end
            end
        end
        
        -- Save the filter result into a new file
        local newFilename = "filtered_output.txt" -- New filename for the filter result
        local newFile = io.open(newFilename, "w") -- Opens a new file to write to
        if newFile then
            gg.setVisible(false) gg.toast("Writing new file.") gg.sleep(750)
            newFile:write(filteredContent) -- Write the filtered content into a new file
            gg.toast("Writing new file..") gg.sleep(750)
            newFile:close() -- Closes the new file once it has finished writing
            gg.toast("Writing new file...") gg.sleep(750)
            print("Process complete. The filter results are saved in a new file:", newFilename)
            return true -- Returns true to indicate the process completed successfully
        else
            print("Failed to save filter results in a new file")
            return false -- Returns false to indicate failure to save filter results
        end
    else
        print("File cannot be opened")
        return false -- Returns false to indicate failed to open the file
    end
end

-- The main function is to run the filter process and save the results
function Main()
    menu = 1
    
    local p = gg.prompt({"Select Your File"}, {[1] = "/storage"}, {[1] = "file"})
    if p == nil then 
        gg.toast("Canceled") 
        Main() 
        return 
    end
    
    local filename = p[1] -- Retrieves the file path from the prompt
    local keywords = {"coin", "mana", "dmg"} -- The keyword you want to search for in the file line
    
    -- Call the filterFile function to filter the file contents and save the results
    local success = filterFile(filename, keywords)
    
    if success then
        gg.toast("Process complete")
        print("Process complete.")
        gg.setVisible(true)
        os.exit()
    else
        print("An error occurred in the process")
        gg.setVisible(true)
        os.exit()
    end
end

-- Calls the main function to run the filter process
Main()