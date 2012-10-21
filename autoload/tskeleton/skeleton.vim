" skeleton.vim
" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2007-09-15.
" @Last Change: 2010-05-13.
" @Revision:    0.0.35

if &cp || exists("loaded_tskeleton_skeleton_autoload")
    finish
endif
let loaded_tskeleton_skeleton_autoload = 1


function! tskeleton#skeleton#Initialize() "{{{3
endf

function! tskeleton#skeleton#FiletypeBits(dict, type) "{{{3
    " TAssert IsDictionary(a:dict)
    " TAssert IsString(a:type)
    call tskeleton#FetchMiniBits(a:dict, g:tskelBitsDir . a:type .'.txt', 0)
    let bf = tskeleton#GlobBits(g:tskelBitsDir . a:type .'/', 2)
    " let cx = tskeleton#CursorMarker('rx')
    " let cm = tskeleton#CursorMarker()
    for f in bf
        " TLogVAR f
        if !isdirectory(f) && filereadable(f)
            let cache_name = tskeleton#MaybePathshorten(f)
            let cfile = tlib#cache#Filename('tskel_skel', tlib#url#Encode(cache_name), 1)
            let ftime = getftime(f)
            let bitdef = tlib#cache#Value(cfile, 'tskeleton#skeleton#Generator', ftime, [f])
            " TLogVAR bitdef
            let a:dict[bitdef.cname] = bitdef
        endif
    endfor
endf


function! tskeleton#skeleton#Generator(filename) "{{{3
    let fname = fnamemodify(a:filename, ":t")
    let [cname, mname] = tskeleton#PurifyBit(fname)
    " TLogVAR cname
    let body = join(readfile(a:filename), "\n")
    let [body, meta] = tskeleton#ExtractMeta(body)
    " if body !~ cx
    "     let body .= cm
    " endif
    if has_key(meta, 'menu') && !empty(meta.menu)
        let mname = meta.menu
    endif
    return {'cname': cname, 'text': body, 'menu': mname, 'meta': meta, 'bitfile': a:filename, 'type': 'tskeleton'}
endf


