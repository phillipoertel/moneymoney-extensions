Exporter{version          = 1.00,
         format           = "Category sums",
         fileExtension    = "csv",
         reverseOrder     = false,
         description      = "Export the transactions summed up by category"}

-- initialize global array to store category sums
categorySums = {}

function writeLine(line)
   assert(io.write(line, "\n"))
end

function WriteHeader (account, startDate, endDate, transactionCount)
    _start = os.date('%b %d %Y', startDate)
    _end   = os.date('%b %d %Y', endDate)
    writeLine("Category sums from " .. _start .. " to " .. _end .. " (" .. transactionCount .. " transactions).")
    writeLine(os.date("File exported at %c."))
end


-- called for every booking day
function WriteTransactions (account, transactions)
    -- This method is called for every booking day.
    -- I use it to sum up all the bookings into a global categorySums variable.
    for _,transaction in ipairs(transactions) do
        categoryName = transaction.category
        if categoryName == "" then
          categoryName = "(ohne)"
        end
        if (categorySums[categoryName]) then
            categorySums[categoryName] =
                categorySums[categoryName] + transaction.amount
        else
            categorySums[categoryName] = transaction.amount
        end
    end
end

function WriteTail (account)
    -- write the finished categories to CSV
    for k, v in pairs(categorySums) do
        -- extract the category name only
        -- changes "Group A\Group B\Category name" to "Category name"
        categoryName = string.match(k, "[^\\]+$")

        -- change "-39.99 to 39,99"
        sum = string.gsub(tostring(v * -1), "%.", ",")
        writeLine(categoryName .. ";" .. sum)
    end
end