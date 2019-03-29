"File: fold_license.vim
"Author: Felipe Tanus (fotanus@gmail.com)
"Version: 1.0
"Copyright: Copyright (C) 2013 Felipe Tanus (GNU License 3.0)
"
"    This program is free software: you can redistribute it and/or modify
"    it under the terms of the GNU General Public License version 3 as
"    published by the Free Software Foundation.
"
"    This program is distributed in the hope that it will be useful,
"    but WITHOUT ANY WARRANTY; without even the implied warranty of
"    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"    GNU General Public License for more details.
"
"    The full license is at http://www.gnu.org/licenses/gpl.txt
"
"
"    This simple vim plugin aims to hide copyright information on the top
"    of any files.

"Check if a block has license keyword
function! HasLicenseKeyword(block_range)
	exec "call cursor(".a:block_range[0].",1)"
	return search('\clicense\|\ccopyright', 'W', a:block_range[1]) != 0
endfunction

"Get start and end from a comment block
function! GetCommentBlock(block_start, block_end)
	call cursor(1,1)
	exec "let s:comment_start = search('^\s*".a:block_start ."', 'c')"
	exec "let s:comment_end = search('"a:block_end."','W')"
	return [s:comment_start,s:comment_end]
endfunction

"Get start and end from a comment line-by-line style
function! GetCommentLine(line_start)
	call cursor(1,1)
	exec "let s:comment_start = search('^\s*".a:line_start ."', 'c')"

	if s:comment_start != 0
		let s:current_line = s:comment_start
		let s:is_comment = 1
		while (s:is_comment != -1) && (s:current_line != line("$"))
			let s:current_line = s:current_line + 1
			exec "call cursor(".(s:current_line).",1)"
			exec "let s:is_comment = match(getline('.'),'^\s*".a:line_start ."')"
		endwhile
		let s:comment_end = s:current_line - 1
		return [s:comment_start, s:comment_end]
	else
		return [0,0]
	end
endfunction

"Test if is a license header
function! IsLicenseHeader(pos,has_license_keyword)
	return (a:pos[0] != 0) && (a:pos[1] != 0) && a:has_license_keyword
endfunction

"Interacts on each element
function! TestCommentBlock(block_check_callback, params)
	let s:pos = call(a:block_check_callback, a:params)
	let s:license_keyword = HasLicenseKeyword(s:pos)
	if IsLicenseHeader(s:pos,s:license_keyword)
		exec s:pos[0].",".s:pos[1]."fold"
	endif
endfunction

"Main function
function! FoldLicense()
	let s:BlocksToTest =  [
				\[function("GetCommentBlock"),
				\['\/\*', '\*\/']],
				\[function("GetCommentLine"), ['//']],
				\[function("GetCommentLine"), ['#']],
				\[function("GetCommentLine"), ['"']],
				\[function("GetCommentLine"), ['--']],
			\]

	for config in s:BlocksToTest
		call TestCommentBlock(config[0], config[1])
	endfor

endfunction

autocmd Filetype * :call FoldLicense()
