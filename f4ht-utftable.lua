#!/usr/bin/env texlua
-- convert utf8 table from http://www.utf8-chartable.de/unicode-utf8-table.pl
-- to \newunicodechar
-- on the webpage, select unicode codepoint, character and and UTF-8 (dec)
-- run texlua f4ht-utftable.lua < savedtable.tsv > utf-scriptname-4ht.tex
-- options:
--   -e: save codes as html entities, instead of direct utf8 codes

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
local hcode_enc = function(hchars) 
	local h = {} -- string.format('\\HChar{%s}\\HChar{%s}',hchars[1],hchars[2])
	for _,ch in ipairs(hchars) do
		table.insert(h, '\\HChar{'..ch..'}')
	end
	return table.concat(h)
end
local entity_enc = function(hchars,enc)
	local result = unicode.utf8.byte(enc)
	return string.format('\\entity{%d}',result)
end

if arg[1] == "-e" then 
	encode = entity_enc
else
	encode = hcode_enc
end

for line in io.lines() do
	local t =  mysplit(line,"\t") 
	if t[3] then
		local hchars = mysplit(t[3]," ")
		local h = encode(hchars,t[2])
	  local msg = t[2] and (string.format("\\newunicodechar{%s}{%s}",t[2],h)) or ''
  	io.write(msg.."\n")
	end
end
