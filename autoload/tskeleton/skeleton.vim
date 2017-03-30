" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Revision:    61


function! tskeleton#skeleton#Initialize() "{{{3
endf

function! tskeleton#skeleton#FiletypeBits(dict, type) "{{{3
    " TLogVAR a:type
    " TAssert IsDictionary(a:dict)
    " TAssert IsString(a:type)
    call tskeleton#FetchMiniBits(a:dict, tskeleton#BitsPath(), a:type .'.txt', 0)
    call s:ScanPath(a:dict, a:type, tskeleton#BitsPath())
endf


function! tskeleton#skeleton#BufferBits(dict, type) "{{{3
    " TLogVAR a:type
    if !exists('b:tskel_bufferbits_path')
        let b:tskel_bufferbits_path = ''
        for dir0 in g:tskelLocalBitsDirs
            let dirs1 = finddir(dir0, '.;', -1)
            " TLogVAR dirs1
            let dirs1 = map(dirs1, 'escape(fnamemodify(v:val, ":p"), ",")')
            let dirs  = join(dirs1, ',')
            if empty(b:tskel_bufferbits_path)
                let b:tskel_bufferbits_path = dirs
            else
                let b:tskel_bufferbits_path .= ','. dirs
            endif
        endfor
    endif
    if !empty(b:tskel_bufferbits_path)
        call s:ScanPath(a:dict, a:type, b:tskel_bufferbits_path)
    endif
endf


function! s:ScanPath(dict, type, path) "{{{3
    let bf = s:GlobBits(a:path, a:type, 2)
    " let cx = tskeleton#CursorMarker('rx')
    " let cm = tskeleton#CursorMarker()
    for f in bf
        " TLogVAR f
        if !isdirectory(f) && filereadable(f)
            let cache_name = tskeleton#MaybePathshorten(f)
            let cfile = tlib#cache#Filename('tskel_skel', tlib#url#Encode(cache_name), 1)
            let ftime = getftime(f)
            let bitdef = tlib#cache#Value(cfile, 'tskeleton#skeleton#Generator', ftime, [f], {'in_memory': g:tskeleton#use_in_memory_cache})
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


" s:GlobBits(path, ?mode=1)
function! s:GlobBits(path, type, ...) "{{{3
    let mode = a:0 >= 1 ? a:1 : 1
    let pt   = a:type .'/*'
    let rvs  = globpath(a:path, pt)
    let rvs  = substitute(rvs, '\\', '/', 'g')
    let rv   = sort(split(rvs, "\n"))
    let stop_rx = tlib#var#Get('tskelBitsIgnore', 'bg')
    if !empty(stop_rx)
        call filter(rv, 'v:val !~ stop_rx')
    endif
    if mode == 0
        call map(rv, 'fnamemodify(v:val, ":t")')
    elseif mode == 1
        call map(rv, 'tskeleton#PurifyBit(fnamemodify(v:val, ":t"))[0]')
    elseif mode == 2
    else
        echoerr 'tSkeleton: Unknown mode: '. mode
    endif
    " TAssert IsList(rv)
    return rv
endf


