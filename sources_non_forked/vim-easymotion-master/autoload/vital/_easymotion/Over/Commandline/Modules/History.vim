scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:module = {
\	"name" : "History",
\	"mode" : "cmd",
\}

function! s:module.histories()
	return map(range(1, &history), 'histget(self.mode, v:val * -1)')
endfunction

function! s:_should_match_cmdline(cmdline)
	return a:cmdline.is_input("\<Up>")
\		|| a:cmdline.is_input("\<Down>")
endfunction

function! s:_reset()
	let s:cmdhist = []
	let s:count = 0
	let s:is_match_mode = 0 " <Up>/<Down>: true, <C-n>/<C-p>: false
endfunction

function! s:module.on_enter(...)
	call s:_reset()
endfunction

function! s:module.on_char_pre(cmdline)
	if !a:cmdline.is_input("\<Up>") && !a:cmdline.is_input("\<Down>")
	\	&& !a:cmdline.is_input("\<C-p>") && !a:cmdline.is_input("\<C-n>")
		call s:_reset()
		return
	else
		if s:count == 0 && empty(s:cmdhist)
		\	|| s:is_match_mode != s:_should_match_cmdline(a:cmdline)
			let cmdline = '^' . a:cmdline.getline()
			let s:is_match_mode = s:_should_match_cmdline(a:cmdline)
			let s:cmdhist = [a:cmdline.getline()] + (s:is_match_mode ?
			\	filter(self.histories(), 'v:val =~ cmdline') : self.histories())
		endif
	endif
	call a:cmdline.setchar("")
	if a:cmdline.is_input("\<Down>") || a:cmdline.is_input("\<C-n>")
		let s:count = max([s:count - 1, 0])
	endif
	if a:cmdline.is_input("\<Up>") || a:cmdline.is_input("\<C-p>")
		let s:count = min([s:count + 1, len(s:cmdhist)])
	endif
	call a:cmdline.setline(get(s:cmdhist, s:count, a:cmdline.getline()))
endfunction

function! s:make(...)
	let module = deepcopy(s:module)
	let module.mode = get(a:, 1, "cmd")
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

let s:___revitalizer_functions___ = {'make': s:___revitalizer_function___('s:make')}

unlet! s:___revitalizer_sid
delfunction s:___revitalizer_function___

function! vital#_easymotion#Over#Commandline#Modules#History#import() abort
  return s:___revitalizer_functions___
endfunction
" ___Revitalizer___