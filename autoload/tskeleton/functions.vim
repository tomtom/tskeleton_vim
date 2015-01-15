" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Revision:    7


function! tskeleton#functions#Initialize() "{{{3
endf


function! tskeleton#functions#FiletypeBits_vim(dict, filetype) "{{{3
    " TAssert IsDictionary(a:dict)
    " TAssert IsString(a:filetype)
    let fnl = tlib#cmd#OutputAsList('fun')
    call map(fnl, 'matchstr(v:val, ''^\S\+\s\+\zs.\+$'')')
    call filter(fnl, 'v:val[0:4] != ''<SNR>''')
    for f in sort(fnl)
        let fn = matchstr(f, '^.\{-}\ze(')
        let fr = substitute(f, '(\(.\{-}\))$', '\=tskeleton#ReplacePrototypeArgs(submatch(1), ''\V...'')', "g")
        " TLogDBG fn ." -> ". fr
        " let a:dict[fn] = {'text': fr, 'menu': 'Function.'. fn, 'type': 'tskeleton'}
        let a:dict[fn] = {'text': fr, 'type': 'tskeleton'}
    endfor
endf


