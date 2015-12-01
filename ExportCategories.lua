Exporter{version          = 1.0,
         format           = "Export categories",
         fileExtension    = "csv",
         reverseOrder     = false,
         description      = "Export all categories"}

function writeLine(line)
   assert(io.write(line, "\n"))
end

-- called once at the beginning of the export
function WriteHeader (account, startDate, endDate, transactionCount)
    -- initialize global array to store categories
    allCategories = {}
end


-- called for every booking day
function WriteTransactions (account, transactions)
    -- This method is called for every booking day.
    for _,transaction in ipairs(transactions) do
        allCategories[transaction.category] = true
    end
end

function WriteTail (account)
    -- write the finished categories to CSV
    for name in pairs(allCategories) do
        writeLine(name)
    end
end