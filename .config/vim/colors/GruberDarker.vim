" Gruber Darker Color Scheme for Vim
" Emacs theme by Jason Blevins and Alexey Kutepov a.k.a. rexim ported by ikos3k

set background=dark
highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "gruber-darker"

let s:fg          = "#e4e4ef"
let s:fg1         = "#f4f4ff"
let s:fg2         = "#f5f5f5"
let s:white       = "#ffffff"
let s:black       = "#000000"
let s:bg1         = "#101010"
let s:bg          = "#181818"
let s:bg2         = "#282828"
let s:bg3         = "#453d41"
let s:bg4         = "#484848"
let s:bg5         = "#52494e"
let s:red1        = "#c73c3f"
let s:red         = "#f43841"
let s:red2        = "#ff4f58"
let s:green       = "#73c936"
let s:yellow      = "#ffdd33"
let s:brown       = "#cc8c3c"
let s:quartz      = "#95a99f"
let s:niagara2    = "#303540"
let s:niagara1    = "#565f73"
let s:niagara     = "#96a6c8"
let s:wisteria    = "#9e95c7"

function! s:HL(group, fg, bg, attr)
  let l:attr = a:attr == "" ? "NONE" : a:attr
  let l:bg = a:bg == "" ? "NONE" : a:bg
  let l:fg = a:fg == "" ? "NONE" : a:fg

  exec "hi " . a:group . " guifg=" . l:fg . " guibg=" . l:bg . " gui=" . l:attr
endfunction

call s:HL("Normal",       s:fg, s:bg, "")
call s:HL("Cursor",       s:yellow, "", "")
call s:HL("CursorLine",   "", s:bg2, "")
call s:HL("CursorLineNr", s:yellow, "", "bold")
call s:HL("LineNr",       s:quartz, "", "")
call s:HL("SignColumn",   "", s:bg, "")
call s:HL("VertSplit",    s:bg3, s:bg, "")
call s:HL("Folded",       s:quartz, s:bg1, "")
call s:HL("FoldColumn",   s:quartz, s:bg1, "")
call s:HL("Pmenu",        s:fg, s:bg2, "")
call s:HL("PmenuSel",     s:fg, s:bg4, "")
call s:HL("PmenuSbar",    "", s:bg2, "")
call s:HL("PmenuThumb",   "", s:bg4, "")
call s:HL("StatusLine",   s:white, s:bg2, "")
call s:HL("StatusLineNC", s:quartz, s:bg2, "")
call s:HL("TabLine",      s:quartz, s:bg2, "")
call s:HL("TabLineSel",   s:yellow, "", "bold")
call s:HL("TabLineFill",  "", s:bg1, "")
call s:HL("Visual",       "", s:bg3, "")
call s:HL("Search",       s:black, s:fg2, "")
call s:HL("IncSearch",    s:black, s:yellow, "")
call s:HL("MatchParen",   "", s:bg5, "")
call s:HL("WildMenu",     s:fg, s:bg4, "")
call s:HL("Question",     s:green, "", "")
call s:HL("Directory",    s:niagara, "", "bold")
call s:HL("Title",        s:yellow, "", "bold")
call s:HL("ErrorMsg",     s:red, "", "bold")
call s:HL("ModeMsg",      s:green, "", "")
call s:HL("MoreMsg",      s:green, "", "")
call s:HL("WarningMsg",   s:red, "", "bold")

call s:HL("Comment",      s:brown, "", "italic")
call s:HL("Constant",     s:quartz, "", "")
call s:HL("String",       s:green, "", "")
call s:HL("Character",    s:green, "", "")
call s:HL("Number",       s:wisteria, "", "")
call s:HL("Boolean",      s:wisteria, "", "")
call s:HL("Float",        s:wisteria, "", "")
call s:HL("Identifier",   s:fg1, "", "")
call s:HL("Function",     s:niagara, "", "")
call s:HL("Statement",    s:yellow, "", "bold")
call s:HL("Conditional",  s:yellow, "", "bold")
call s:HL("Repeat",       s:yellow, "", "bold")
call s:HL("Label",        s:yellow, "", "bold")
call s:HL("Operator",     s:yellow, "", "bold")
call s:HL("Keyword",      s:yellow, "", "bold")
call s:HL("Exception",    s:yellow, "", "bold")
call s:HL("PreProc",      s:quartz, "", "")
call s:HL("Include",      s:quartz, "", "")
call s:HL("Define",       s:quartz, "", "")
call s:HL("Macro",        s:quartz, "", "")
call s:HL("PreCondit",    s:quartz, "", "")
call s:HL("Type",        s:quartz, "", "")
call s:HL("StorageClass", s:quartz, "", "")
call s:HL("Structure",    s:quartz, "", "")
call s:HL("Typedef",      s:quartz, "", "")
call s:HL("Special",      s:fg, "", "bold")
call s:HL("SpecialChar",  s:fg, "", "bold")
call s:HL("Tag",          s:fg, "", "bold")
call s:HL("Delimiter",    s:fg, "", "bold")
call s:HL("SpecialComment", s:brown, "", "italic")
call s:HL("Debug",        s:fg, "", "bold")
call s:HL("Underlined",   s:niagara, "", "underline")
call s:HL("Ignore",       s:quartz, "", "")
call s:HL("Error",        s:red, "", "bold")
call s:HL("Todo",         s:red1, "", "bold")

call s:HL("DiffAdd",      s:green, s:bg1, "")
call s:HL("DiffChange",   s:yellow, s:bg1, "")
call s:HL("DiffDelete",   s:red2, s:bg1, "")
call s:HL("DiffText",     s:yellow, s:bg3, "")

call s:HL("SpellBad",     s:red, "", "underline")
call s:HL("SpellCap",     s:yellow, "", "underline")
call s:HL("SpellRare",    s:green, "", "underline")
call s:HL("SpellLocal",   s:quartz, "", "underline")

if has('terminal')
  let g:terminal_ansi_colors = [
        \ s:bg4, s:red1, s:green, s:yellow,
        \ s:niagara, s:wisteria, s:quartz, s:fg,
        \ s:bg3, s:red, s:green, s:brown,
        \ s:niagara, s:wisteria, s:quartz, s:white
        \ ]
endif

delfunction s:HL