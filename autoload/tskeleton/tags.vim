" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Revision:    18


let s:tag_defs = {}


function! tskeleton#tags#Initialize() "{{{3
endf


function! s:SortBySource(a, b)
    let ta = s:sort_tag_defs[a:a]
    let tb = s:sort_tag_defs[a:b]
    let fa = ta.source
    let fb = tb.source
    if fa == fb
        return ta.menu == tb.menu ? 0 : ta.menu > tb.menu ? 1 : -1
    else
        return fa > fb ? 1 : -1
    endif
endf


function! s:SortByFilename(tag1, tag2)
    let f1 = a:tag1['filename']
    let f2 = a:tag2['filename']
    return f1 == f2 ? 0 : f1 > f2 ? 1 : -1
endf


function! tskeleton#tags#BufferBits(dict, filetype) "{{{3
    " TAssert IsDictionary(a:dict)
    " TAssert IsString(a:filetype)
    " TLogVAR a:filetype
    if exists('*tskeleton#tags#Process_'. a:filetype)
        let td_id = join(map(tagfiles(), 'fnamemodify(v:val, ":p")'), '\n')
        " TLogVAR td_id
        if !empty(td_id)
            let tag_defs = get(s:tag_defs, td_id, {})
            " TLogDBG len(tag_defs)
            if empty(tag_defs)
                echom 'tSkeleton: Building tags menu for '. expand('%')
                let tags = taglist('.')
                call sort(tags, 's:SortByFilename')
                call filter(tags, 'tskeleton#tags#Process_{a:filetype}(tag_defs, v:val)')
                let s:tag_defs[td_id] = tag_defs
                echo
                redraw
            endif
            call extend(a:dict, tag_defs, 'keep')
            let menu_prefix = tlib#var#Get('tskelMenuPrefix_tags', 'bg')
            if !empty(menu_prefix)
                let s:sort_tag_defs = tag_defs
                let tagnames = sort(keys(tag_defs), 's:SortBySource')
                " TLogVAR tagnames
                " call filter(tagnames, 'tskeleton#NewBufferMenuItem(b:tskelBufferMenu, v:val)')
                call filter(tagnames, 'tskeleton#NewBufferMenuItem(b:tskelBufferMenu, v:val)')
            endif
        endif
    endif
endf


function! tskeleton#tags#Process_vim(dict, tag)
    return s:ProcessTag_functions_with_parentheses('f', a:dict, a:tag, '\V...')
endf


function! tskeleton#tags#Process_ruby(dict, tag)
    return s:ProcessTag_functions_with_parentheses('f', a:dict, a:tag, '\*\a\+\s*$')
endf


function! tskeleton#tags#Process_c(dict, tag)
    return s:ProcessTag_functions_with_parentheses('f', a:dict, a:tag, '')
endf


function! tskeleton#tags#Process_java(dict, tag)
    return s:ProcessTag_functions_with_parentheses('f', a:dict, a:tag, '\V...')
endf


function! s:ProcessTag_functions_with_parentheses(kinds, dict, tag, restargs)
    if empty(a:kinds) || stridx(a:kinds, a:tag['kind']) != -1
        let source0 = fnamemodify(a:tag['filename'], ':p')
        let source  = source0
        let xname   = a:tag['name']
        if has_key(a:tag, 'signature')
            let args0 = a:tag.signature
        else
            let args0 = matchstr(a:tag['cmd'], '(.\{-})')
        endif
        let args    = matchstr(args0, '(\zs.\{-}\ze)')
        let bname0  = xname . args0 .'@'
        let bname   = bname0 . fnamemodify(source, ':t')
        if has_key(a:dict, bname)
            if fnamemodify(get(a:dict[bname], 'source', ''), ':p') == source0
                return ''
            else
                let bname = bname0 . source
            endif
        endif
        let xname .= tskeleton#ReplacePrototypeArgs(args, a:restargs)
        let a:dict[bname] = {'text': xname, 'source': source, 'type': 'tskeleton'}
        let menu_prefix = tlib#var#Get('tskelMenuPrefix_tags', 'bg')
        if !empty(menu_prefix)
            let smenu  = join(map(split(source, '[\/]'), 'escape(v:val, ".")'), '.')
            let mname  = menu_prefix . smenu .'.'. escape(bname, '.')
            " TLogDBG xname .' -- '. xname
            let a:dict[bname]['menu'] = mname
        endif
        return bname
    endif
    return ''
endf


