" custom syntax file for xresources
" NOTE: still WIP, I have no idea what I am doing here

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syntax case match

" comments
syntax region xresourcesComment  start="!" end="$" contains=@Spell
syntax region xresourcesComment  start="#" end="$" contains=@Spell
highlight default link xresourcesComment Comment

" match xresource identifiers, separators, and values
"         separator
"            v
" ex: xft.dpi: 144
"     ^^        ^^
"  identifier   value


syntax match xresourcesIdentifier /^[^:]*/
" syntax match xresourcesValueDef /:.*$/ contains=xresourcesSeparator,xresourcesValue

" syntax match xresourcesSeparator /:/ contained
" syntax match xresourcesValue /.*$/ contained


highlight link xresourcesIdentifier Identifier
highlight link xresourcesValue String
highlight link xresourcesSeparator Type



let b:current_syntax = "xresources"
