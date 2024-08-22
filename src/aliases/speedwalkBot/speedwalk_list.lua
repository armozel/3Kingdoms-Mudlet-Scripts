echo("Places to  to/Home From:\n")
speedwalkBot.printResult = ""
for i,v in ipairs(speedwalkBot.paths) do
    speedwalkBot.printResult = speedwalkBot.printResult .. tostring(v) .. "\t"
end
speedwalkBot.printResult = speedwalkBot.printResult .. "\n"
echo(speedwalkBot.printResult)
            