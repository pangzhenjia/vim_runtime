scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:module = {
\	"name" : "NoInsert",
\	"chars" : []
\}


function! s:module.is_no_insert(char)
	return index(self.chars, a:char) >= 0
endfunction


function! s:module.on_char_pre(cmdline)
	if self.is_no_insert(a:cmdline.char())
		call a:cmdline.setchar("", 0)
	endif
endfunction


function! s:make(chars)
	let module = deepcopy(s:module)
	let module.chars = type(a:chars) == type([]) ? a:chars : [a:chars]
	return module
endfunction


function! s:make_special_chars()
	let module = s:make([])
	function! module.is_no_insert(char)
		return char2nr(a:char) == 128 || char2nr(a:char) < 27
	endfunction
	return module
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
" ___Revitalizer___
" NOTE: below code is generated by :Revitalize.
" Do not mofidify the code nor append new lines
if v:version > 703 || v:version == 703 && has('patch1170')
  function! s:___revitalizer_function___(fstr) abort
    return function(a:fstr)
  endfunction
else
  function! s:___revitalizer_SID() abort
    return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze____revitalizer_SID$')
  endfunction
  let s:___revitalizer_sid = '<SNR>' . s:___revitalizer_SID() . '_'
  function! s:___revitalizer_function___(fstr) abort
    return function(substitute(a:fstr, 's:', s:___revitalizer_sid, 'g'))
  endfunction
endif

let s:___revitalizer_functions___ = {'make': s:___revitalizer_function___('s:make'),'make_special_chars': s:___revitalizer_function___('s:make_special_chars')}

unlet! s:___revitalizer_sid
delfunction s:___revitalizer_function___

function! vital#_easymotion#Over#Commandline#Modules#NoInsert#import() abort
  return s:___revitalizer_functions___
endfunction
" ___Revitalizer___