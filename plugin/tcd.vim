" ======================================================================
" File: tcd.vim
" Description: Tab-specific directories.
" Maintainer: Thomas Allen <thomas@oinksoft.com>
"
" Copyright (c) 2013- Thomas Allen <thomas@oinksoft.com>
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be
" included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
" IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
" CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
" TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
" SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" ======================================================================

if exists('loaded_tcd')
  fini
end

fu! g:Tcd(path)
  let t:tcd_ocwd = getcwd()
  let t:tcd_cwd = a:path
  call s:cd(a:path)
endf

fu! s:tab_entered()
  if exists('t:tcd_cwd')
    let t:tcd_ocwd = getcwd()
    cal s:cd(t:tcd_cwd)
  end
endf

fu! s:tab_exited()
  if exists('t:tcd_ocwd')
    cal s:cd(t:tcd_ocwd)
  end
endf

fu! s:cd(path)
  exe 'cd ' . a:path
endf

au TabEnter * silent call s:tab_entered()
au TabLeave * silent call s:tab_exited()

com! -nargs=1 -complete=dir Tcd :call g:Tcd(<f-args>)
