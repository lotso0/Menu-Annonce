function RageUI.Info(Title, RightText, LeftText)
    local LineCount = #RightText >= #LeftText and #RightText or #LeftText
    if Title ~= nil then
        RenderText("~h~" .. Title .. "~s~", 270 + 20 + 100 + 30, 7, 0, 0.30, 255, 255, 255, 255, 0)
    end
    if RightText ~= nil then
        RenderText(table.concat(RightText, "\n"), 270 + 20 + 100 + 30, Title ~= nil and 37 or 7, 0, 0.25, 255, 255, 255, 255, 0)
    end
    if LeftText ~= nil then
        RenderText(table.concat(LeftText, "\n"), 270 + 432 + 100 + 30, Title ~= nil and 37 or 7, 0, 0.25, 255, 255, 255, 255, 2)
    end
    
    RenderRectangle(270 + 10 + 100 + 30, 0, 432, Title ~= nil and 50 + (LineCount * 20) or ((LineCount + 1) * 20), 18, 18, 18, 90)
end