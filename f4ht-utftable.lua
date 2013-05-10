#!/usr/bin/env texlua
function mysplit(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end
for line in io.lines() do
	local t =  mysplit(line,"\t") 
	if t[3] then
		local hchars = mysplit(t[3]," ")
		local h = string.format('\\HChar{%s}\\HChar{%s}',hchars[1],hchars[2])
	  local msg = t[2] and (string.format("\\newunicodechar{%s}{%s}",t[2],h)) or ''
  	io.write(msg.."\n")
	end
end
