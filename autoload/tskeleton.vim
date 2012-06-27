" tskeleton.vim
" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2007-09-03.
" @Last Change: 2012-02-28.
" @Revision:    0.0.1976


" call tlog#Log('Load: '. expand('<sfile>')) " vimtlib-sfile


if !exists('g:tskelMapsDir') "{{{2
    let g:tskelMapsDir = g:tskelDir .'map/'
endif
let g:tskelMapsDir = tlib#dir#CanonicName(g:tskelDir)

if !exists('g:tskelBitsIgnore')
    let g:tskelBitsIgnore = tlib#rx#Suffixes()   "{{{2
endif

if !exists('g:tskelNewBufferIsDirty')
    " If true, a new file that was filled with a template is marked as 
    " 'modified'.
    let g:tskelNewBufferIsDirty = ! &hidden   "{{{2
endif

if !exists("g:tskelTypes") "{{{2
    " 'skeleton' (standard tSkeleton functionality)
    " 'abbreviations' (VIM abbreviations)
    " 'functions' (VIM script functions extracted from :function)
    " 'mini' ("mini" bits, one-liners etc.)
    " 'tags' (tags-based code templates, requires ctags, I presume)
    let g:tskelTypes = ['skeleton', 'mini']
endif

if !exists('g:tskelLicense') "{{{2
    let g:tskelLicense = 'GPL (see http://www.gnu.org/licenses/gpl.txt)'
endif

if !exists("g:tskelMarkerHiGroup") | let g:tskelMarkerHiGroup = 'Special'     | endif "{{{2
if !exists("g:tskelMarkerLeft")    | let g:tskelMarkerLeft    = "<+"           | endif "{{{2
if !exists("g:tskelMarkerRight")   | let g:tskelMarkerRight   = "+>"           | endif "{{{2
if !exists('g:tskelMarkerExtra')   | let g:tskelMarkerExtra   = '???\|+++\|!!!\|###' | endif
if !exists("g:tskelMarkerCursor_mark") | let g:tskelMarkerCursor_mark = "CURSOR"           | endif "{{{2
if !exists("g:tskelMarkerCursor_volatile") | let g:tskelMarkerCursor_volatile = "/CURSOR"           | endif "{{{2
if !exists("g:tskelMarkerCursor_rx")   | let g:tskelMarkerCursor_rx = 'CURSOR\(/\(.\{-}\)\)\?' | endif "{{{2
if !exists("g:tskelDateFormat")    | let g:tskelDateFormat    = '%Y-%m-%d'    | endif "{{{2
if !exists("g:tskelUserName")      | let g:tskelUserName      = g:tskelMarkerLeft."NAME".g:tskelMarkerRight    | endif "{{{2
if !exists("g:tskelUserAddr")      | let g:tskelUserAddr      = g:tskelMarkerLeft."ADDRESS".g:tskelMarkerRight | endif "{{{2
if !exists("g:tskelUserEmail")     | let g:tskelUserEmail     = g:tskelMarkerLeft."EMAIL".g:tskelMarkerRight   | endif "{{{2
if !exists("g:tskelUserWWW")       | let g:tskelUserWWW       = g:tskelMarkerLeft."WWW".g:tskelMarkerRight     | endif "{{{2
if !exists("g:tskelUserCompany")     | let g:tskelUserCompany     = g:tskelMarkerLeft."COMPANY".g:tskelMarkerRight   | endif "{{{2

if !exists("g:tskelRevisionMarkerRx") | let g:tskelRevisionMarkerRx = '@Revision:\s\+' | endif "{{{2
if !exists("g:tskelRevisionVerRx")    | let g:tskelRevisionVerRx = '\(RC\d*\|pre\d*\|p\d\+\|-\?\d\+\)\.' | endif "{{{2
if !exists("g:tskelRevisionGrpIdx")   | let g:tskelRevisionGrpIdx = 3 | endif "{{{2

if !exists("g:tskelMaxRecDepth") | let g:tskelMaxRecDepth = 10 | endif "{{{2
if !exists("g:tskelChangeDir")   | let g:tskelChangeDir   = 1  | endif "{{{2
if !exists("g:tskelMapComplete") | let g:tskelMapComplete = 1  | endif "{{{2
" if g:tskelMapComplete
"     set completefunc=tskeleton#Complete
" endif

if !exists("g:tskelMenuPriority")   | let g:tskelMenuPriority = 90         | endif "{{{2
if !exists("g:tskelMenuMiniPrefix") | let g:tskelMenuMiniPrefix = 'etc.'   | endif "{{{2
if !exists("g:tskelAutoAbbrevs")    | let g:tskelAutoAbbrevs = 0           | endif "{{{2
if !exists("g:tskelAbbrevPostfix")  | let g:tskelAbbrevPostfix = '#'       | endif "{{{2

" By default bit names are case sensitive.
"  1 ... case sensitive
" -1 ... default (see 'smartcase')
"  0 ... case insensitive
if !exists("g:tskelCaseSensitive")        | let g:tskelCaseSensitive = 1        | endif "{{{2
if !exists("g:tskelCaseSensitive_html")   | let g:tskelCaseSensitive_html = 0   | endif "{{{2
if !exists("g:tskelCaseSensitive_bbcode") | let g:tskelCaseSensitive_bbcode = 0 | endif "{{{2

if !exists("g:tskelUseBufferCache") | let g:tskelUseBufferCache = 0             | endif "{{{2
if !exists("g:tskelBufferCacheDir") | let g:tskelBufferCacheDir = '.tskeleton'  | endif "{{{2

if !exists("g:tskelMenuPrefix_tags") | let g:tskelMenuPrefix_tags = 'Tags.' | endif "{{{2

if !exists("g:tskelQueryType") "{{{2
    " if has('gui_win32') || has('gui_win32s') || has('gui_gtk')
    "     let g:tskelQueryType = 'popup'
    " else
        let g:tskelQueryType = 'query'
    " end
endif

if !exists("g:tskelPopupNumbered") | let g:tskelPopupNumbered = 1 | endif "{{{2

" set this to v for using visual mode when calling TSkeletonGoToNextTag()
if !exists("g:tskelSelectTagMode") | let g:tskelSelectTagMode = 's' | endif "{{{2

" \Q will be replaced with a quantifier
if !exists("g:tskelKeyword_bbcode") | let g:tskelKeyword_bbcode = '\(\[\*\|[\[\\][*[:alnum:]]\Q\)' | endif "{{{2
if !exists("g:tskelKeyword_bib")  | let g:tskelKeyword_bib  = '[@[:alnum:]]\Q'       | endif "{{{2
if !exists("g:tskelKeyword_java") | let g:tskelKeyword_java = '[[:alnum:]_@<&]\Q'    | endif "{{{2
if !exists("g:tskelKeyword_php")  | let g:tskelKeyword_java = '[[:alnum:]_@<&$]\Q'   | endif "{{{2
if !exists("g:tskelKeyword_html") | let g:tskelKeyword_html = '<\?[^>[:blank:]]\Q'   | endif "{{{2
if !exists("g:tskelKeyword_sh")   | let g:tskelKeyword_sh   = '[\[@${([:alpha:]]\Q'  | endif "{{{2
if !exists("g:tskelKeyword_tex")  | let g:tskelKeyword_tex  = '\\\?\k\Q'             | endif "{{{2
if !exists("g:tskelKeyword_viki") | let g:tskelKeyword_viki = '\(#\|{\|\\\)\?[^#{[:blank:][:punct:]-]\Q' | endif "{{{2
" if !exists("g:tskelKeyword_viki") | let g:tskelKeyword_viki = '\(#\|{\)\?[^#{[:blank:]]\{-}' | endif "{{{2

if !exists("g:tskelBitGroup_html") "{{{2
    let g:tskelBitGroup_html = ['html', 'html_common']
endif
if !exists("g:tskelBitGroup_bbcode") "{{{2
    let g:tskelBitGroup_bbcode = ['bbcode', 'tex']
endif
if !exists("g:tskelBitGroup_php") "{{{2
    let g:tskelBitGroup_php  = ['php', 'html', 'html_common']
endif
if !exists("g:tskelBitGroup_java") "{{{2
    let g:tskelBitGroup_java = ['java', 'html_common']
endif
if !exists("g:tskelBitGroup_viki") "{{{2
    let g:tskelBitGroup_viki = ['tex', 'viki']
endif
if !exists("g:tskelBitGroup_xslt") "{{{2
    let g:tskelBitGroup_xslt = ['xslt', 'xml']
endif


if !exists("g:tskel_completions") "{{{2
    let g:tskel_completions = {
                \ 'use_omnifunc': 'tskeleton#Complete_use_omnifunc',
                \ 'use_completefunc': 'tskeleton#Complete_use_completefunc',
                \ 'scan_words': 'tskeleton#Complete_scan_words',
                \ 'scan_tags': 'tskeleton#Complete_scan_tags',
                \ }
endif

if !exists('g:tskeleton#enable_stakeholders')
    let g:tskeleton#enable_stakeholders = 0   "{{{2
endif

if !exists('g:tskeleton#conceal_cchar')
    " With |+conceal|, show this character for placeholders.
    " If empty, don't use |:syn-conceal|.
    let g:tskeleton#conceal_cchar = has('conceal') ? {'utf-8': '⬚', '_': '#'} : {}   "{{{2
endif


if !exists('*TSkeleton_FILE_DIRNAME') "{{{2
    function! TSkeleton_FILE_DIRNAME() "{{{3
        return tskeleton#EvalInDestBuffer('expand("%:p:h")')
    endf
endif


if !exists('*TSkeleton_FILE_SUFFIX') "{{{2
    function! TSkeleton_FILE_SUFFIX() "{{{3
        return tskeleton#EvalInDestBuffer('expand("%:e")')
    endf
endif


if !exists('*TSkeleton_FILE_NAME_ROOT') "{{{2
    function! TSkeleton_FILE_NAME_ROOT() "{{{3
        return tskeleton#EvalInDestBuffer('expand("%:t:r")')
    endf
endif


if !exists('*TSkeleton_FILE_NAME') "{{{2
    function! TSkeleton_FILE_NAME() "{{{3
        return tskeleton#EvalInDestBuffer('expand("%:t")')
    endf
endif


if !exists('*TSkeleton_NOTE') "{{{2
    function! TSkeleton_NOTE() "{{{3
        let title = tskeleton#GetVar("tskelTitle", 'input("Please describe the project: ")', '')
        let note  = title != "" ? " -- ".title : ""
        return note
    endf
endif


if !exists('*TSkeleton_DATE') "{{{2
    function! TSkeleton_DATE() "{{{3
        return strftime(tskeleton#GetVar('tskelDateFormat'))
    endf
endif


if !exists('*TSkeleton_TIME') "{{{2
    function! TSkeleton_TIME() "{{{3
        return strftime('%X')
    endf
endif


if !exists('*TSkeleton_AUTHOR') "{{{2
    function! TSkeleton_AUTHOR() "{{{3
        return tskeleton#GetVar('tskelUserName')
    endf
endif


if !exists('*TSkeleton_EMAIL') "{{{2
    function! TSkeleton_EMAIL() "{{{3
        let email = tskeleton#GetVar('tskelUserEmail')
        " return substitute(email, "@"," AT ", "g")
        return email
    endf
endif


if !exists('*TSkeleton_COMPANY') "{{{2
    function! TSkeleton_COMPANY() "{{{3
        let company = tskeleton#GetVar('tskelUserCompany')
        return company
    endf
endif


if !exists('*TSkeleton_WEBSITE') "{{{2
    function! TSkeleton_WEBSITE() "{{{3
        return tskeleton#GetVar('tskelUserWWW')
    endf
endif


if !exists('*TSkeleton_LICENSE') "{{{2
    function! TSkeleton_LICENSE() "{{{3
        return tskeleton#GetVar('tskelLicense')
    endf
endif


function! TSkeletonCB_FILENAME() "{{{3
    return input('File name: ', '', 'file')
endf


function! TSkeletonCB_DIRNAME() "{{{3
    return input('Directory name: ', '', 'dir')
endf


function! TSkelNewScratchHook_viki()
    let b:vikiMarkInexistent = 0
endf






" let s:tskelScratchVars = ['tskelMarkerCursor', 'tskelMarkerLeft', 'tskelMarkerRight']
let s:tskelScratchVars = []
let s:tskelScratchIdx  = 0
let s:tskelScratchMax  = 0
let s:tskelDestBufNr   = -1
let s:tskelBuiltMenu   = 0
let s:tskelLine        = 0
let s:tskelCol         = 0
let s:tskelProcessing  = 0
let s:tskelConditions  = []
let s:tskelLoops       = []
let s:initialized      = []


function! tskeleton#Initialize(...) "{{{3
    TVarArg ['types', g:tskelTypes]
    " TLogVAR types
    for type in types
        if index(s:initialized, type) == -1
            " TLogVAR type
            call {'tskeleton#'. type .'#Initialize'}()
            call add(s:initialized, type)
        endif
    endfor
endf


function! tskeleton#WrapMarker(text, ...) "{{{3
    TVarArg 'type'
    let left  = tlib#var#Get('tskelMarkerLeft', 'bg')
    let right = tlib#var#Get('tskelMarkerRight', 'bg')
    if type == 'rx'
        return tlib#rx#Escape(left) . a:text . tlib#rx#Escape(right)
    else
        return left . a:text . right
    endif
endf


function! tskeleton#CursorMarker(...) "{{{3
    TVarArg ['type', 'mark']
    let cursor = tlib#var#Get('tskelMarkerCursor_'.type, 'bg')
    return tskeleton#WrapMarker(cursor, type)
endf


function! tskeleton#TagRx() "{{{3
    " let quoted = '"\(\\"\|[^"]\)*"\|''\(''''\|[^'']\)*'''
    " return tskeleton#WrapMarker("\\("
    "         \ ."[\\&].\\{-}\\|[gbws]:.\\{-}\\|\\(bit\\|tskel\\):.\\{-}"
    "         \ ."\\|call:\\(". quoted ."\\|[bgs]:\\|.\\)\\{-1,}"
    "         \ ."\\|[a-zA-Z_ -]*\\(/.\\{-}\\)\\?"
    "         \ ."\\|\\(if\\|elseif\\|for\\|input\\|let\\|\\include\\|execute\\)(\\([^'\"]*\\|". quoted ."\\)\\{-})"
    "         \ ."\\|?.\\{-}?"
    "         \ ."\\)\\(: *.\\{-} *\\)\\?"
    "         \ , 'rx')
    return tskeleton#WrapMarker("\\("
            \ ."\\$[a-zA-Z_]\\+\\|[\\&].\\{-}\\|[gbws]:.\\{-}\\|\\(bit\\|tskel\\):.\\{-}"
            \ ."\\|call:\\('[^']*'\\|\"\\(\\\\\"\\|[^\"]\\)*\"\\|[bgs]:\\|.\\)\\{-1,}"
            \ ."\\|[a-zA-Z_ -]*\\(/.\\{-}\\)\\?"
            \ ."\\|\\(if\\|elseif\\|for\\|input\\|select\\|let\\|\\include\\|execute\\)(.\\{-})"
            \ ."\\|?.\\{-}?"
            \ ."\\)\\(: *.\\{-} *\\)\\?"
            \ , 'rx')
endf

function! tskeleton#ExpandedAbbreviationTemplate() "{{{3
    return '<c-\><c-o>:call tskeleton#ExpandBitUnderCursor("n", %s)<cr>'
endf


" :def: function! tskeleton#FillIn(bit, ?filetype='', ?meta={})
" Expand special tags.
function! tskeleton#FillIn(bit, ...) "{{{3
    " TLogVAR a:bit
    let filetype = a:0 >= 1 && a:1 != '' ? a:1 : s:Filetype()
    " TLogVAR filetype
    call tskeleton#PrepareBits(filetype)
    let b:tskelTemporaryVariables = []
    if a:0 >= 2
        let meta = a:2
    else
        let bitdef = tskeleton#BitDef(a:bit)
        " TLogVAR bitdef
        let meta = get(bitdef, 'meta', {})
    endif
    " TLogVAR meta
    if !empty(meta)
        let msg = get(meta, 'msg', '')
        if !empty(msg)
            echom msg
        endif
        call s:EvalBitProcess(get(meta, 'before'), 1)
        call s:EvalBitProcess(get(meta, 'here_before'), 0)
    endif
    let foldenable = &l:foldenable
    setlocal nofoldenable
    try
        " silent norm! G$
        silent norm! gg0
        " call tlog#Debug(tskeleton#TagRx())
        " call tlog#Debug(s:tskelScratchIdx)
        let s:tskelLine_{s:tskelScratchIdx} = search(tskeleton#TagRx(), 'cW')
        while s:tskelLine_{s:tskelScratchIdx} > 0
            " TLogDBG string(getpos('.'))
            " TLogDBG string(getline(1, '$'))
            let s:tskelPos0 = getpos('.')
            " call tlog#Debug(s:tskelLine_{s:tskelScratchIdx})
            " let col  = virtcol(".")
            let col  = col('.')
            " TLogVAR col
            let line = strpart(getline('.'), col - 1)
            let mlst = matchlist(line, tskeleton#TagRx())
            " TLogVAR mlst
            " TLogVAR getline('.'), col, line
            let text0 = matchstr(line, tskeleton#TagRx())
            " TLogVAR text0
            " let text  = substitute(line, tskeleton#TagRx() .'.*$', '\1', '')
            let text  = mlst[1]
            " TLogVAR text
            let s:tskelPostExpand = ''
            let [postprocess, repl] = s:HandleTag(text, b:tskelFiletype)
            " TLogVAR postprocess, repl
            if postprocess == -1
                call s:ReplaceLine(col, repl)
                exec 'norm! '. len(repl) .'l'
            elseif postprocess == 1
                if repl != '' && line =~ '\V\^'. escape(repl, '\')
                    norm! l
                else
                    let mod  = get(mlst, 7)
                    " TLogVAR mod
                    let repl = s:Modify(repl, mod)
                    " TLogVAR repl
                    call s:ReplaceLine(col, repl)
                endif
            endif
            if s:tskelPostExpand != ''
                " call tlog#Debug(s:tskelPostExpand)
                exec s:tskelPostExpand
                let s:tskelPostExpand = ''
            end
            if s:tskelLine_{s:tskelScratchIdx} > 0
                " call tlog#Debug('search(tskeleton#TagRx(), "W")')
                let s:tskelLine_{s:tskelScratchIdx} = search(tskeleton#TagRx(), 'cW')
            endif
        endwh
        " TLogDBG "endwhile"
    finally
        let &l:foldenable = foldenable
    endtry
    if !empty(meta)
        call s:EvalBitProcess(get(meta, 'here_after'), 0)
        call s:EvalBitProcess(get(meta, 'after'), 1)
    endif
    " TLogVAR b:tskelTemporaryVariables
    for def in b:tskelTemporaryVariables
        let var = get(def, 0)
        " TLogVAR def, var
        if len(def) == 1
            exec 'unlet! '. var
        else
            call s:SetVar(var, get(def, 1))
        endif
    endfor
    if empty(a:bit)
        " TLogDBG "tskeleton#SetCursor"
        call tskeleton#SetCursor('%', '')
    endif
    " TLogDBG "done"
endf


function! s:ReplaceLine(col, repl) "{{{3
    let tagrx = escape(tskeleton#TagRx(), '/')
    exec 'silent! s/\%'. a:col .'c'. tagrx .'//'
    call tlib#buffer#InsertText0(a:repl, {
                \ 'pos': 's',
                \ 'col': a:col,
                \ 'indent': 1,
                \ })
    " call tlib#buffer#InsertText(a:repl, {
    "             \ 'pos': 's',
    "             \ 'shift': -1,
    "             \ 'col': a:col,
    "             \ 'indent': 1,
    "             \ })
endf


function! tskeleton#ExtractMeta(text)
    " TLogVAR a:text
    let meta = {'type': 'tskeleton'}
    let [text, meta.msg]         = s:GetBitProcess(a:text, 'msg', 2)
    let [text, meta.before]      = s:GetBitProcess(text, 'before', 1)
    " TLogVAR meta.before
    let [text, meta.after]       = s:GetBitProcess(text, 'after', 1)
    " TLogVAR meta.after
    let [text, meta.here_before] = s:GetBitProcess(text, 'here_before', 0)
    " TLogVAR meta.here_before
    let [text, meta.here_after]  = s:GetBitProcess(text, 'here_after', 0)
    " TLogVAR meta.here_after
    let [text, meta.abbrev]      = s:GetBitProcess(text, 'abbrev', 0)
    " TLogVAR meta.abbrev
    let [text, meta.menu]        = s:GetBitProcess(text, 'menu', 0)
    let [text, meta.condition]   = s:GetBitProcess(text, 'condition', 0)
    if empty(meta.condition)
        let meta.condition = 1
    endif
    " TLogVAR meta.condition
    " TLogVAR text
    return [text, meta]
endf


function! s:HandleTag(match, filetype) "{{{3
    " TLogVAR a:match
    let s:tskel_use_placeholders = 1
    " TLogDBG a:match =~# '^[bgsw]:'
    if a:match =~# '^[bgsw]:'
        return [1, s:Var(a:match)]
    elseif a:match =~# '^\$[a-zA-Z_]\+$'
        return [1, exists(a:match) ? eval(a:match) : '']
    elseif a:match =~# '^nl$'
        return [1, "\n"]
    elseif a:match =~# '^nop$'
        return [1, ""]
    elseif a:match =~# '^joinline$'
        call s:JoinLine()
        return [1, ""]
    elseif a:match =~# '^input('
        return s:Input(strpart(a:match, 5))
    elseif a:match =~# '^select('
        return s:Select(strpart(a:match, 6))
    elseif a:match =~# '^if('
        return [0, s:SwitchIf(strpart(a:match, 2))]
    elseif a:match =~# '^elseif('
        return [0, s:SwitchElseif(strpart(a:match, 6))]
    elseif a:match =~# '^else$'
        return [0, s:SwitchElse()]
    elseif a:match =~# '^endif$'
        return [0, s:SwitchEndif()]
    elseif a:match =~# '^for('
        return [0, s:LoopFor(strpart(a:match, 3))]
    elseif a:match =~# '^let('
        return [0, s:LetVar(strpart(a:match, 3))]
    elseif a:match =~# '^include('
        return [1, s:Expand(matchstr(a:match, '(\zs.\{-}\ze)$'), a:filetype)]
    elseif a:match =~# '^execute('
        return [0, s:Execute(matchstr(a:match, '(\zs.\{-}\ze)$'))]
    elseif a:match =~# '^\([A-Z ]\+\)'
        return [1, s:Dispatch(a:match)]
    elseif a:match[0] == '&'
        return [1, s:Exec(a:match)]
    elseif a:match[0] == '\'
        return [-1, tskeleton#WrapMarker(strpart(a:match, 1))]
    elseif a:match[0] == '?'
        return [1, s:Query(strpart(a:match, 1, strlen(a:match) - 2))]
    elseif strpart(a:match, 0, 4) =~# '\(bit\|tskel\):'
        " return [1, s:Expand(strpart(a:match, 4), a:filetype)]
        return [1, s:Expand(matchstr(a:match, ':\zs.*'), a:filetype)]
    " elseif strpart(a:match, 0, 6) =~# 'tskel:'
    "     return [1, s:Expand(strpart(a:match, 6), a:filetype)]
    " elseif strpart(a:match, 0, 6) =~# 'include:'
    "     return [1, s:Expand(strpart(a:match, 8), a:filetype)]
    elseif strpart(a:match, 0, 5) =~# 'call:'
        return [1, s:Call(strpart(a:match, 5))]
    else
        return [1, tskeleton#WrapMarker(a:match)]
    end
endf


" tskeleton#SetCursor(from, to, ?findAny=0, ?findOnly)
function! tskeleton#SetCursor(from, to, ...) "{{{3
    " TLogVAR a:from, a:to
    let findAny  = a:0 >= 1 ? a:1 : 0
    let findOnly = a:0 >= 2 ? a:2 : (s:tskelScratchIdx > 1)
    " TLogVAR findAny, findOnly
    let c = col('.')
    let l = line('.')
    if a:to == ''
        if a:from == '%'
            silent norm! gg0
        else
            exec a:from
        endif
    else
        exec a:to
        norm! 0
    end
    let cursor_rx = tskeleton#CursorMarker('rx')
    let l = search(cursor_rx, 'Wc')
    if l == 0 && findAny
        let cursor_rx = tskeleton#TagRx()
        let l = -search(cursor_rx, 'Wc')
    endif
    if l == 0
        call cursor(l, c)
        return 0
    elseif !findOnly
        let c = col('.')
        " TLogDBG getline('.')
        if !findAny && l > 0
            let smarttaglen = len(get(matchlist(getline('.')[c - 1 :], cursor_rx), 2, ''))
            silent exec 's/'. escape(cursor_rx, '/') .'/\2/e'
        else
            let smarttaglen = len(matchstr(getline('.')[c - 1 :], cursor_rx))
        endif
        call cursor(0, c)
        if smarttaglen > 0
            exec 'norm! v'. (smarttaglen - s:InclusiveSelection()) .'l'
            call s:SelectTagMode()
        endif
        " TLogVAR findAny, cursor_rx, l, smarttaglen
        " TLogDBG getline('.')
    endif
    " TLogVAR l
    return l
endf


function! s:JoinLine()
    let s:tskelPostExpand = 'silent norm! d/\S'
endf


function! s:Input(text) "{{{3
    " TLogVAR a:text
    let args = eval('['. matchstr(a:text, '^(\zs.*\ze)$') .']')
    " TLogVAR args
    let var  = get(args, 0, '')
    let vdef = s:VarName(var)
    if var[-1:-1] == '!'
        call s:DelTo('input(.\{-}', 1)
        let s:tskelPostExpand = "call setpos('.', ". string(s:tskelPos0) .")"
        " TLogDBG string(getline(1, '$'))
        let reval = 0
        let var   = var[0:-2]
    else
        let reval = 1
    endif
    if s:SkipVar(vdef)
        let val = s:GetVar(vdef.name)
    else
        let val = call('input', args[1:-1])
        call s:TemporaryLet(var, val)
    endif
    return [reval, val]
endf


function! s:Select(text) "{{{3
    let args = eval('['. matchstr(a:text, '^(\zs.*\ze)$') .']')
    " TLogVAR args
    let var  = get(args, 0, '')
    let type = get(args, 2, 's')
    let join = get(args, 3, ', ')
    let vdef = s:VarName(var)
    if var[-1:-1] == '!'
        call s:DelTo('select(.\{-}', 1)
        let s:tskelPostExpand = "call setpos('.', ". string(s:tskelPos0) .")"
        " TLogDBG string(getline(1, '$'))
        let reval = 0
        let var   = var[0:-2]
    else
        let reval = 1
    endif
    if s:SkipVar(vdef)
        let val = s:GetVar(vdef.name)
    else
        let val0 = tlib#input#List(type, 'Select item:', get(args, 1, ['Malformed arguments']))
        if type =~# 'm'
            let val = join(val0, join)
        else
            let val = val0
        endif
        call s:TemporaryLet(var, val)
    endif
    return [reval, val]
endf


function! s:TemporaryLet(var, val) "{{{3
    if !empty(a:var)
        " TLogVAR a:var
        let var = s:VarName(a:var)
        if s:SkipVar(var)
            return
        endif
        if var.mod !~ '&'
            if exists(var.name)
                call insert(b:tskelTemporaryVariables, [var.name, s:GetVar(var.name)])
            else
                call insert(b:tskelTemporaryVariables, [var.name])
            endif
        endif
        call s:SetVar(var.name, a:val)
    endif
endf


function! s:VarName(var) "{{{3
     let [match, var, mod; rest] = matchlist(a:var, '^\(.\{-}\)\([!?&]*\)$')
     return {'match': match, 'name': var, 'mod': mod}
endf


function! s:SkipVar(var) "{{{3
    return a:var.mod =~ '?' && exists(a:var.name)
endf

function! s:GetVar(var) "{{{3
    " if a:var[0] == '@'
    "     return getreg(a:var[1:])
    " elseif a:var[0] == '&'
        return eval(a:var)
    " else
    "     return {a:var}
    " endif
endf

function! s:SetVar(var, val) "{{{3
    exec 'let '. a:var .'= a:val'
    return
    " if a:var[0] == '@'
    "     call setreg(a:var[1:], a:val)
    " elseif a:var[0] == '&'
    "     " exec 'let &l:'. a:var[1:] .'= a:val'
    "     exec 'let '. a:var .'= a:val'
    " else
    "     let {a:var} = {a:val}
    " endif
endf


function! s:SwitchIf(text)
    " TLogDBG 'if'
    " TLogVAR a:text
    if empty(s:tskelConditions) || s:LastCondition()
        if eval(a:text)
            " TLogDBG 'true'
            call add(s:tskelConditions, 1)
            call s:DelTo('if(.\{-}', 1)
        else
            " TLogDBG 'false'
            call add(s:tskelConditions, 0)
            call s:DelTo('\(if(.\{-}\|elseif(.\{-}\|else\|endif\)', 0)
        endif
    else
        call add(s:tskelConditions, 0)
        call s:DelTo('\(if(.\{-}\|endif\)', 0)
    endif
    return ''
endf


function! s:SwitchElseif(text)
    " TLogDBG 'elseif'
    " TLogVAR a:text
    " TLogDBG string(getline(1, '$'))
    if s:LastCondition()
        " TLogDBG 'elseif obsolete'
        call s:DelTo('endif', 1)
    elseif eval(a:text)
        " TLogDBG 'elseif true'
        call add(s:tskelConditions, 1)
        call s:DelTo('elseif(.\{-}', 1)
    else
        " TLogDBG 'elseif false'
        call s:DelTo('\(elseif(.\{-}\|else\|endif\)', 0)
    endif
    return ''
endf


function! s:SwitchElse()
    " TLogDBG 'else'
    if s:LastCondition()
        " TLogDBG 'else false'
        call s:DelTo('endif', 1)
    else
        " TLogDBG 'else true'
        let s:tskelConditions[-1] = 1
        call s:DelTo('else', 1)
    endif
    return ''
endf


function! s:SwitchEndif()
    " TLogDBG 'endif'
    if empty(s:tskelConditions)
        echoerr 'tSkeleton: "endif" without "if"'
    endif
    call remove(s:tskelConditions, -1)
    call s:DelTo('endif', 1)
    return ''
endf


function! s:LastCondition() "{{{3
    if !empty(s:tskelConditions)
        return s:tskelConditions[-1]
    endif
    echoerr 'tSkeleton: "else/elseif/endif" without "if"'
    return 0
endf


function! s:LetVar(text) "{{{3
    let var = matchstr(a:text, '^(\s*\zs[^=]\{-}\ze\s*=')
    let val = matchstr(a:text, '=\s*\zs.\{-}\ze)$')
    " TLogVAR var, val
    call s:TemporaryLet(var, eval(val))
    call s:DelTo('let.\{-}', 1)
    return ''
endf


function! s:LoopFor(text) "{{{3
    " TLogDBG 'for'
    " TLogVAR a:text
    let var   = matchstr(a:text, '^(\zs\S\+')
    let endrx = 'endfor\(('.var.')\)\?'
    " TLogVAR var, endrx
    let lists = matchstr(a:text, '\sin\s\+\zs.\{-}\ze)$')
    " TLogVAR var, lists
    let t = @t
    try
        call s:DoVisual('for(.\{-}', 1, '"ty')
        let head = @t
        " TLogVAR head
        call s:DelTo('for(.\{-}', 1)
        call s:DoVisual(endrx, 0, '"ty')
        let body = @t
        " TLogVAR body
        call s:DelTo(endrx, 1)
    finally
        let @t = t
    endtry
    let acc = []
    for e in eval(lists)
        call add(acc, tskeleton#WrapMarker(printf('let(%s=%s)', var, string(e))))
        call add(acc, body)
    endfor
    " TLogVAR acc
    " call s:InsertBitText('i', join(acc, ''))
    call s:InsertBitText('gil', join(acc, ''))
    let s:tskelPostExpand = "call setpos('.', ". string(s:tskelPos0) .")"
    return ''
endf


function! s:DoVisual(pattern, inclusive, cmd) "{{{3
    let rx = tskeleton#WrapMarker(a:pattern, 'rx')
    " TLogVAR rx
    exec 'silent! norm! v/'. escape(rx, '/') .(a:inclusive ? '/e1' : '') ."\<cr>". a:cmd
endf


function! s:DelTo(pattern, inclusive)
    call s:DoVisual(a:pattern, a:inclusive, 'd')
endf



function! s:Var(arg) "{{{3
    " TLogVAR a:arg
    if exists(a:arg)
        " exec 'return '.a:arg
        " TLogVAR {a:arg}
        return {a:arg}
    else
        return tskeleton#EvalInDestBuffer(printf('exists("%s") ? %s : "%s"', a:arg, a:arg, a:arg))
    endif
endf

function! s:Execute(text) "{{{3
    " TLogDBG string(getline(1, '$'))
    call s:DelTo('execute(.\{-}', 1)
    exec a:text
    " TLogDBG string(getline(1, '$'))
    return ''
endf

function! s:Exec(arg) "{{{3
    return tskeleton#EvalInDestBuffer(a:arg)
endf


" function! TSkelIncreaseIndex(var) "{{{3
"     exec 'let '. a:var .'='. a:var .'+1'
"     return a:var
" endf


function! s:Query(arg) "{{{3
    let sepx = stridx(a:arg, '|')
    let var  = strpart(a:arg, 0, sepx)
    " let text = substitute(strpart(a:arg, sepx + 1), ':?$', ':', '')
    let text = strpart(a:arg, sepx + 1)
    let tsep = stridx(text, '|')
    if tsep == -1
        let repl = ''
    else
        let repl = strpart(text, tsep + 1)
        let text = strpart(text, 0, tsep)
    endif
    if var != ''
        if !tskeleton#EvalInDestBuffer('exists('. string(var) .')')
            echom 'Unknown choice variable: '. var
        else
            let val0 = tskeleton#EvalInDestBuffer(var)
            if type(val0) == 3
                let val = val0
            else
                let val = split(val0, '\n')
            endif
            " TAssert IsList(val)
            let val = sort(copy(val))
            " TLogVAR val
            let rv = tlib#input#List('s', 'Choices:', val)
            " TLogVAR rv
            if repl != '' && rv != ''
                let rv = s:sprintf1(repl, rv)
            endif
            " TLogVAR rv
            return rv
        endif
    endif
    let rv = input(text. ' ', '')
    if rv != '' && repl != ''
        let rv = s:sprintf1(repl, rv)
    endif
    return rv
endf


function! s:GetVarName(name, global) "{{{3
    if a:global == 2
        return 's:tskelBitProcess_'. a:name
    elseif a:global == 1
        return 's:tskelBitProcess_'. s:tskelScratchIdx .'_'. a:name
    else
        return 'b:tskelBitProcess_'. a:name
    endif
endf


function! s:SaveBitProcess(name, match, global) "{{{3
    let s:tskelGetBit = a:match
    return ''
endf


function! s:GetBitProcess(text, name, global) "{{{3
    let s:tskelGetBit = ''
    let text = substitute(a:text, '^\s*<tskel:'. a:name .'>\s*\n\(\(.\{-}\n\)\{-}\)\s*<\/tskel:'. a:name .'>\s*\n', '\=s:SaveBitProcess("'. a:name .'", submatch(1), '. a:global .')', '')
    " call tlog#Debug(s:tskelGetBit)
    return [text, tlib#string#Chomp(s:tskelGetBit)]
endf


function! s:EvalBitProcess(eval, global) "{{{3
    " TLogVAR a:global, a:eval
    if !empty(a:eval)
        let eval = substitute(a:eval, '\(^\|\n\)\s*".*\n', '', 'g')
        " TLogVAR eval
        if a:global
            call tskeleton#ExecInDestBuffer(eval)
        else
            exec eval
        endif
    endif
    " TLogVAR 'done'
endf


function! s:Modify(text, modifier) "{{{3
    " TLogVAR a:text, a:modifier
    " let rv = escape(a:text, '\&~')
    let rv = a:text
    let premod = '^[:ulcCs]\{-}\zs'
    if a:modifier =~# premod.'u'
        " TLogVAR "u", rv
        let rv = toupper(rv)
    endif
    if a:modifier =~# premod.'l'
        " TLogVAR "l", rv
        let rv = tolower(rv)
    endif
    if a:modifier =~# premod.'c'
        " TLogVAR "c", rv
        let rv = toupper(rv[0]) . tolower(strpart(rv, 1))
    endif
    if a:modifier =~# premod.'C'
        " TLogVAR "C", rv
        let rv = substitute(rv, '\(^\|[^a-zA-Z0-9]\)\(.\)', '\u\2', 'g')
    endif
    if a:modifier =~# premod.'s'
        " TLogVAR "s", rv
        " let mod  = matchstr(a:modifier, '^[^s]*s\zs.*\ze$')
        let mod  = matchstr(a:modifier, 's\zs.*\ze$')
        " let rxm  = '\V'
        let rxm  = ''
        let sep  = mod[0]
        let esep = escape(sep, '\')
        let pat  = '\(\[^'. sep .']\*\)'
        let rx   = '\V\^'. esep . pat . esep . pat . esep .'\$'
        let from = matchlist(mod, rx)[1]
        let to   = matchlist(mod, rx)[2]
        let rv   = substitute(rv, rxm . from, to, 'g')
    endif
    return rv
endf


function! s:Dispatch(name) "{{{3
    let name = matchstr(a:name, '^ *\zs.\{-}\ze *$')
    let name = substitute(name, ' ', '_', 'g')
    " TLogVAR name
    if exists('*TSkeleton_'. name)
        let rv = TSkeleton_{name}()
        " TLogVAR rv
    else
        let rv = tskeleton#WrapMarker(a:name)
    endif
    return rv
endf


function! s:Call(fn) "{{{3
    return tskeleton#EvalInDestBuffer(a:fn)
endf


function! s:Expand(bit, ...) "{{{3
    " TLogVAR a:bit
    let filetype = a:0 >= 1 && a:0 != '' ? a:1 : &filetype
    " TLogVAR filetype
    " TLogVAR b:tskelFiletype
    call tskeleton#PrepareBits(filetype)
    let sepx = match(a:bit, '|')
    if sepx == -1
        let name    = a:bit
        let default = ''
    else
        let name    = strpart(a:bit, 0, sepx)
        let default = strpart(a:bit, sepx + 1)
    endif
    let bittext = ''
    " TLogVAR name, default
    " TLogDBG string(keys(b:tskelBitDefs))
    let indent = s:GetIndent(getline('.'))
    if s:IsDefined(name)
        let [setCursor, bittext] = s:RetrieveBit('text', name, indent, filetype)
        " TLogVAR setCursor, bittext
    endif
    " TLogVAR bittext
    if empty(bittext)
        if default =~ '".*"'
            let bittext = matchstr(default, '^"\ze.*\ze"$')
        elseif default != ''
            let s:tskelPostExpand = s:tskelPostExpand .'|norm '. default
        else
            let bittext = tskeleton#WrapMarker('bit:'.a:bit)
        endif
    endif
    " TLogVAR bittext
    return bittext
endf


" :def: function! tskeleton#GetVar(name, ?default=g:name)
" Get the value of variable name from the destination buffer.
function! tskeleton#GetVar(name, ...) "{{{3
    if tskeleton#EvalInDestBuffer('exists("b:'. a:name .'")')
        return tskeleton#EvalInDestBuffer('b:'. a:name)
    elseif a:0 >= 1
        exec 'return '. a:1
    else
        exec 'return g:'. a:name
    endif
endf


" Evaluate code in the destination buffer.
function! tskeleton#EvalInDestBuffer(code) "{{{3
    return tskeleton#ExecInDestBuffer('return '. a:code)
endf


" Execute code in the destination buffer.
function! tskeleton#ExecInDestBuffer(code) "{{{3
    let cb = bufnr('%')
    let wb = bufwinnr('%')
    " TLogVAR cb
    let sb = s:tskelDestBufNr >= 0 && s:tskelDestBufNr != cb
    let lazyredraw = &lazyredraw
    set lazyredraw
    if sb
        let ws = bufwinnr(s:tskelDestBufNr)
        if ws != -1
            try
                exec 'noautocmd' ws.'wincmd w'
                let code = substitute("\n". a:code ."\n", '\n\s*".\{-}\ze\n', "", "g")
                " TLogVAR a:code
                exec 'noautocmd' a:code
            finally
                exec 'noautocmd' wb.'wincmd w'
            endtry
        else
            try
                silent exec 'noautocmd sbuffer! '. s:tskelDestBufNr
                exec a:code
            finally
                noautocmd wincmd c
            endtry
        endif
    else
        exec a:code
    endif
    let &lazyredraw = lazyredraw
    " TLogDBG 'done'
endf


function! tskeleton#FindTemplate(template) "{{{3
    "<+BODY+>
endf


function! tskeleton#CollectTemplates() "{{{3
    "<+BODY+>
endf


" :def: function! tskeleton#Setup(template, ?unconditionally=0)
" Fill in a file template.
function! tskeleton#Setup(template, ...) "{{{3
    " TLogVAR a:template
    let anyway = a:0 >= 1 ? a:1 : 0
    " TLogVAR anyway
    if anyway || !exists('b:tskelDidFillIn') || !b:tskelDidFillIn
        if filereadable(g:tskelDir . a:template)
            let tf = g:tskelDir . a:template
        elseif filereadable(a:template)
            let tf = a:template
        else
            echoerr 'Unknown skeleton: '. a:template
            return
        endif
        let unset_ft = !exists('g:tskelFiletype')
        if unset_ft
            let g:tskelFiletype = &filetype
        endif
        try
            let meta = s:ReadSkeleton(tf)
            let s:tskel_use_placeholders = 0
            call tskeleton#FillIn('', &filetype, meta)
            call tskeleton#Placeholders(0, 0)
            if g:tskelChangeDir
                let cd = substitute(expand('%:p:h'), '\', '/', 'g')
                let cd = substitute(cd, '^\@<!//\+', '/', 'g')
                exec 'cd '. tlib#arg#Ex(cd)
            endif
            let b:tskelDidFillIn = 1
            if g:tskelNewBufferIsDirty
                setlocal modified
            endif
        finally
            if unset_ft
                unlet g:tskelFiletype
            endif
        endtry
    endif
endf


function! s:GetTemplates(aslist) "{{{3
    let files = split(glob(g:tskelDir. '*'), '\n') + split(glob(g:tskelDir. 'templates/**'), '\n')
    call filter(files, '!isdirectory(v:val)')
    " call map(files, 'fnamemodify(v:val, ":t")')
    let fns = len(g:tskelDir)
    call map(files, 'v:val[fns : -1]')
    if a:aslist
        return files
    else
        return join(files, "\n")
    endif
endf


" Command line completion.
function! tskeleton#SelectTemplate(ArgLead, CmdLine, CursorPos) "{{{3
    if a:CmdLine =~ '^.\{-}\s\+.\{-}\s'
        return ''
    else
        return s:GetTemplates(0)
    endif
endf


" Command line completion.
function! tskeleton#EditBitCompletion(ArgLead, CmdLine, CursorPos) "{{{3
    if a:CmdLine =~ '^.\{-}\s\+.\{-}\s'
        return []
    endif
    let bitdefs = s:GetBitDefs()
    if !empty(bitdefs)
        let bits  = filter(copy(bitdefs), 'has_key(v:val, "bitfile")')
        let bits  = map(bits, 'tlib#file#Relative(v:val["bitfile"], g:tskelBitsDir)')
        let bvals = values(bits)
        if !empty(a:ArgLead)
            call filter(bvals, 's:MatchBit(v:val, ''\V\^''. escape(a:ArgLead, ''\''))')
        endif
        return bvals
    endif
    return []
endf


function! s:Browse(save, title, initdir, default) "{{{3
    let tpl = tlib#input#List('s', 'Select template', s:GetTemplates(1), [
                \ {'display_format': 'filename'},
                \ ])
    return tpl
endf


" :def: function! tskeleton#Edit(?dir)
" Edit a file template.
function! tskeleton#Edit(...) "{{{3
    let tpl = a:0 >= 1 && !empty(a:1) ? a:1 : s:Browse(0, "Template", g:tskelDir, "")
    if !empty(tpl)
        let tf = tlib#arg#Ex(g:tskelDir . tpl)
        " TLogVAR tf
        exe 'edit '. tf
    end
endf


" Edit a skeleton bit.
function! tskeleton#EditBit(bit) "{{{3
    if !empty(a:bit)
        let tf = tlib#arg#Ex(g:tskelBitsDir. a:bit)
        " TLogVAR tf
        exe 'edit '. tf
    end
endf


" :def: function! tskeleton#NewFile(?template, ?dir, ?fileName)
" Create a new file template.
function! tskeleton#NewFile(...) "{{{3
    if a:0 >= 1 && a:1 != ""
        let tpl = g:tskelDir. a:1
    else
        let tpl = s:Browse(0, "Template", g:tskelDir, "")
        if tpl == ""
            return
        else
            let tpl = fnamemodify(tpl, ":p")
        endif
    endif
    if a:0 >= 2 && a:2 != ""
        let dir = a:2
    else
        let dir = getcwd()
    endif
    if a:0 >= 3
        let fn = a:3
    else
        let fn = s:Browse(1, "New File", dir, "new.".fnamemodify(tpl, ":e"))
        if fn == ""
            return
        else
            let fn = fnamemodify(fn, ":p")
        endif
    endif
    if fn != "" && tpl != ""
        " TLogVAR tpl
        exe 'edit '. tpl
        exe 'saveas '. fn
        let s:tskel_use_placeholders = 0
        call tskeleton#FillIn('', &filetype)
        call tskeleton#Placeholders(0, 0)
        exe "bdelete ". tpl
    endif
endf


" tskeleton#GlobBits(path, ?mode=1)
function! tskeleton#GlobBits(path, ...) "{{{3
    let mode = a:0 >= 1 ? a:1 : 1
    let pt   = "*"
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


function! s:PrepareMiniBit(dict, def, buildmenu) "{{{3
    " TAssert IsDictionary(a:dict)
    " TAssert IsString(a:def)
    if !empty(a:def)
        " TLogVAR a:def
        if a:def =~ '\S\+\s'
            let bit = matchstr(a:def, '^\S\+\ze\s')
            let exp = matchstr(a:def, '\s\zs.\+$')
        else
            let bit = a:def
            let exp = a:def
        endif
        " TAssert IsString(exp)
        let a:dict[bit] = {'text': exp, 'menu': g:tskelMenuMiniPrefix . bit, 'type': 'tskeleton'}
        if a:buildmenu
            call tskeleton#NewBufferMenuItem(b:tskelBufferMenu, bit)
        endif
        " TAssert IsNotEmpty(a:dict[bit])
    endif
endf


function! tskeleton#NewBufferMenuItem(menu, bit, ...)
    TVarArg ['subpriority', 10]
    " TLogVAR a:menu
    " TLogVAR a:bit
    " TLogVAR subpriority
    let min = s:PrepareMenuEntry(a:bit, subpriority, "n")
    " TLogVAR min
    call add(a:menu, min)
    let mii = s:PrepareMenuEntry(a:bit, subpriority, "i")
    " TLogVAR mii
    call add(a:menu, mii)
    if tlib#var#Get('tskelAutoAbbrevs', 'bg')
        let mia = s:PrepareAbbreviation(a:bit)
        " TLogVAR mia
        if !empty(mia)
            call add(a:menu, mia)
        endif
    endif
    " TLogDBG 'tskeleton#NewBufferMenuItem end'
endf


function! tskeleton#FetchMiniBits(dict, filename, buildmenu) "{{{3
    " TAssert IsDictionary(a:dict)
    " TLogVAR a:filename
    let c = s:ReadFile(a:filename)
    if c =~ '\S'
        for line in sort(split(c, "\n"))
            call s:PrepareMiniBit(a:dict, line, a:buildmenu)
        endfor
    endif
    return a:dict
endf


function! tskeleton#ProcessTag_functions_with_parentheses(kinds, dict, tag, restargs)
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
            " let smenu  = join(map(split(source, '[\/]'), 'escape(v:val, ". ")'), '.')
            " let mname  = 'Tag.'. smenu .'.'. escape(bname, '. ')
            let smenu  = join(map(split(source, '[\/]'), 'escape(v:val, ".")'), '.')
            let mname  = menu_prefix . smenu .'.'. escape(bname, '.')
            " TLogDBG xname .' -- '. xname
            let a:dict[bname]['menu'] = mname
        endif
        return bname
    endif
    return ''
endf


function! tskeleton#ReplacePrototypeArgs(text, rest)
    let args = split(a:text, ',\s\+')
    if empty(args)
        return '()' . tskeleton#CursorMarker()
    else
        let max = len(args) - 1
        " let rv  = map(range(0, max), '!empty(a:rest) && args[v:val] =~# a:rest ? tskeleton#WrapMarker("") : (v:val == 0 ? "" : ", ") . printf(tskeleton#WrapMarker("%s"), toupper(args[v:val]))')
        let rv  = map(range(0, max), '!empty(a:rest) && args[v:val] =~# a:rest ? tskeleton#WrapMarker("") : (v:val == 0 ? "" : ", ") . printf(tskeleton#WrapMarker("%s"), s:CleanArgument(args[v:val]))')
        return printf('(%s%s)%s', tskeleton#CursorMarker(), join(rv, ''), tskeleton#WrapMarker(''))
    endif
endf


function! s:CleanArgument(arg) "{{{3
    return substitute(a:arg, '[?&:|()<>]', ' ', 'g')
endf


function! s:ExpandMiniBit(bit) "{{{3
    let rv = ''
    if s:IsDefined(a:bit)
        let rv = tskeleton#BitDef(a:bit, 'text')
    endif
    " TAssert IsString(rv)
    return rv
endf


function! s:sprintf1(string, arg) "{{{3
    let rv = substitute(a:string, '\C\(^\|%%\|[^%]\)\zs%s', escape(a:arg, '"\'), 'g')
    let rv = substitute(rv, '%%', '%', 'g')
    return rv
    " return printf(a:string, a:arg)
endf


function! s:GetBitGroup(filetype, ...) "{{{3
    let general_first = a:0 >= 1 ? a:1 : 0
    let filetype = substitute(a:filetype, '\W', '_', 'g')
    let bg = tlib#var#Get('tskelBitGroup_'. filetype, 'bg')
    if !empty(bg)
        if type(bg) == 1
            echom 'tSkeleton: [bg]:tskelBitGroup_'. filetype .' should be a list'
            let rv = split(bg, "\n")
        else
            let rv = copy(bg)
        endif
    else
        let rv = [filetype]
    endif
    " TAssert IsList(rv)
    if filetype != 'general'
        if general_first
            call insert(rv, 'general')
        else
            call add(rv, 'general')
        endif
    endif
    return rv
endf


function! tskeleton#PurifyBit(bit) "{{{3
    " let rv = a:bit
    " let rv = substitute(rv, '^[^[:cntrl:]]\{-}[/.]\([^/.[:cntrl:]]\{-}\)$', '\1', 'g')
    " let rv = substitute(rv, '^[^[:cntrl:]]\{-}[/.]\([^/.[:cntrl:]]\{-}\)$', '\1', 'g')
    " let rv = fnamemodify(rv, ':t')
    let mname = tlib#url#Decode(a:bit)
    let cname = a:bit
    let cname = substitute(cname, '^.\{-}\.\ze[^.]\+$', '', '')
    let cname = tlib#url#Decode(substitute(cname, '&', '', 'g'))
    return [cname, mname]
endf


function! s:DidSetup(filetype) "{{{3
    return exists('g:tskelBits_'. a:filetype)
endf


function! s:ToBeInitialized(list, filetype) "{{{3
    return index(a:list, a:filetype) != -1
endf


function! s:FiletypesToBeInitialized(ftgroup, explicit_reset) "{{{3
    if a:explicit_reset
        return a:ftgroup
    endif
    return filter(copy(a:ftgroup), 's:FiletypeToBeInitialized(v:val)')
endf


function! s:FiletypeToBeInitialized(filetype) "{{{3
    if !s:DidSetup(a:filetype)
        return 1
    else
        let ftm = s:GetMenuCacheFilename(a:filetype)
        if empty(ftm)
            return 0
        else
            return !filereadable(ftm)
        endif
    endif
endf


" s:PrepareMenu(type, ?menuprefix='')
function! s:PrepareMenu(filetype, ...) "{{{3
    if g:tskelMenuCache == '' || g:tskelMenuPrefix == ''
        return
    endif
    " TLogVAR a:filetype
    let menu_file = s:GetMenuCacheFilename(a:filetype)
    " TLogVAR menu_file
    if menu_file != ''
        let sub = a:0 >= 1 ? a:1 : ''
        let tskelMenuPrefix = g:tskelMenuPrefix
        let verbose    = &verbose
        let lazyredraw = &lazyredraw
        let backup     = &backup
        let patchmode  = &patchmode
        let g:tskeleton_SetFiletype = 0
        set lazyredraw
        set nobackup
        set patchmode=
        set verbose&
        try
            let menu = s:MakeMenuEntry(keys(g:tskelBits_{a:filetype}), sub)
            if !empty(menu)
                exec 'redir! > '. menu_file
                if exists('*TSkelMenuCacheEditHook')
                    silent! call TSkelMenuCacheEditHook()
                endif
                silent! echo join(menu, "\n")
                if exists('*TSkelMenuCachePostWriteHook')
                    silent! call TSkelMenuCachePostWriteHook()
                endif
                redir END
            endif
        catch
            echohl Error
            echom v:errmsg
            echohl NONE
        finally
            let &verbose    = verbose
            let &lazyredraw = lazyredraw
            let &backup     = backup
            let &patchmode  = patchmode
            let g:tskeleton_SetFiletype = 1
            let g:tskelMenuPrefix = tskelMenuPrefix
        endtry
    endif
endf


function! s:MakeMenuEntry(items, ...)
    let sub = a:0 >= 1 ? a:1 : ''
    " TLogVAR a:items
    " TAssert IsList(a:items)
    if sub != ''
        let g:tskelMenuPrefix = g:tskelMenuPrefix .'.'. sub
        let subpriority = 10
    else
        let subpriority = 20
    endif
    let menu = []
    call filter(sort(copy(a:items)), 'tskeleton#NewBufferMenuItem(menu, v:val, subpriority)')
    " TLogVAR menu
    return menu
endf


function! s:GetCacheFilename(filetype, what) "{{{3
    " TLogVAR a:filetype
    if a:filetype == ''
        return ''
    endif
    " let filetype = 'tskel_'. a:filetype
    let cfn  = tlib#cache#Filename(a:what, a:filetype, 1)
    " TLogVAR cfn
    return cfn
endf


function! s:GetMenuCacheFilename(filetype) "{{{3
    return s:GetCacheFilename(a:filetype, 'tskel_menu')
endf


function! s:GetFiletypeBitsCacheFilename(filetype) "{{{3
    return s:GetCacheFilename(a:filetype, 'tskel_bits')
endf


function! s:ResetBufferCacheForFiletype(filetype) "{{{3
    let dir = s:GetCacheFilename(a:filetype, 'tskel_bbits')
    if !empty(dir)
        let files = split(globpath(dir, '**'), '\n')
        for fname in files
            if !isdirectory(fname)
                " TLogVAR fname
                call delete(fname)
            endif
        endfor
    endif
endf


function! s:GetBufferCacheFilename(filetype, ...) "{{{3
    if g:tskelUseBufferCache
        let fname = expand('%:t')
        " TLogVAR fname
        if !empty(fname)
            let create_dir = a:0 >= 1 ? a:1 : 0
            let dir = s:GetCacheFilename(a:filetype, 'tskel_bbits')
            if !empty(dir)
                let dir = tlib#file#Join([
                            \ dir,
                            \ substitute(expand('%:p:h'), '[:&<>]\|//\+\|\\\\\+', '_', 'g')
                            \ ])
                " TLogVAR dir
                if create_dir && !isdirectory(dir)
                    call tlib#dir#Ensure(dir)
                endif
                " let fname = expand('%:t') .'.'. a:filetype
                let cname = tlib#file#Join([dir, fname])
                " TLogVAR cname
                return cname
            endif
        endif
    endif
    return ''
endf


function! tskeleton#BitDef(name, ...) "{{{3
    TVarArg 'field', 'default'
    " TLogVAR a:name, field, default
    let def = get(s:GetBitDefs(), a:name, {})
    " TLogVAR def
    if empty(field)
        return def
    else
        return get(def, field, default)
    endif
endf


function! s:PrepareAbbreviation(name) "{{{3
    if a:name =~ '\S'
        " TLogVAR a:name
        let bit = tskeleton#BitDef(a:name)
        if !(has_key(bit, 'abbrev') && empty(bit.abbrev))
            " let abb = empty(g:tskelAbbrevPostfix) ? '' : (a:name.g:tskelAbbrevPostfix)
            let abb = a:name. tlib#var#Get('tskelAbbrevPostfix', 'bg')
            if abb =~ '\W\W$'
                echom 'tSkeleton: Invalid name for an abbreviation: '. abb
            else
                if !empty(bit)
                    let meta = get(bit, 'meta', {})
                    let abbr = get(meta, 'abbrev', get(bit, 'abbrev', ''))
                    let abbr = substitute(abbr, '\s', '', 'g')
                    " let abbr = tlib#string#Chomp(abbr)
                    if !empty(abbr)
                        let abb = abbr
                    endif
                endif
                " TLogVAR abb
                if !empty(abb)
                    return 'iabbrev <buffer> '. abb .' '. printf(tskeleton#ExpandedAbbreviationTemplate(), string(a:name))
                endif
            endif
        endif
    endif
    return ''
endf


function! s:PrepareMenuEntry(name, subpriority, mode) "{{{3
    " TLogVAR a:name
    if a:name =~ '\S'
        " TLogVAR a:mode
        let bit   = tskeleton#BitDef(a:name)
        " TLogVAR bit
        let mname = a:name
        " let mname = escape(a:name, ' 	')
        " let mname = escape(a:name, ' 	\')
        " TLogVAR mname
        if !empty(bit)
            let mname = get(bit, 'menu', mname)
        endif
        let mname = escape(mname, ' 	\')
        " TLogVAR mname
        let acc = []
        for menu_name in split(mname, "\n")
            " TLogVAR menu_name
            let spri  = stridx(menu_name, '.') >= 0 ? a:subpriority - 1 : a:subpriority
            " TLogVAR spri
            let pri   = g:tskelMenuPriority .'.'. spri
            " TLogVAR pri
            " if a:mode == 'i'
            if s:IsInsertMode(a:mode)
                call add(acc, 'imenu '. pri .' '. g:tskelMenuPrefix .'.'. menu_name .
                            \ ' <c-\><c-o>:call tskeleton#ExpandBitUnderCursor("i", '. string(a:name) .')<cr>')
            else
                call add(acc, 'menu '. pri .' '. g:tskelMenuPrefix .'.'. menu_name .
                            \ ' :call tskeleton#ExpandBitUnderCursor("n", '. string(a:name) .')<cr>')
            endif
        endfor
        return join(acc, "\n")
    else
        return ''
    endif
endf


function! s:InitBufferMenu()
    if !exists('b:tskelBufferMenu')
        let b:tskelBufferMenu = []
    endif
endf


function! tskeleton#BuildBufferMenu(prepareBits) "{{{3
    " TLogVAR a:prepareBits
    if !s:tskelProcessing && &filetype != '' && g:tskelMenuCache != '' && g:tskelMenuPrefix != ''
        if a:prepareBits
            call tskeleton#PrepareBits()
        endif
        if s:tskelBuiltMenu == 1
            try
                silent exec 'aunmenu '. g:tskelMenuPrefix
            finally
            endtry
        endif
        let pri = g:tskelMenuPriority .'.'. 5
        exec 'amenu '. pri .' '. g:tskelMenuPrefix .'.Reset :TSkeletonBitReset<cr>'
        exec 'amenu '. pri .' '. g:tskelMenuPrefix .'.-tskel1- :'
        let bg = s:GetBitGroup(&filetype, 1)
        " TLogVAR bg
        call map(bg, 's:GetMenuCache(v:val)')
        if exists('b:tskelBufferMenu')
            " TLogVAR b:tskelBufferMenu
            for m in b:tskelBufferMenu
                exec m
            endfor
        endif
        let s:tskelBuiltMenu = 1
    endif
endf


function! s:GetMenuCache(filetype) "{{{3
    let pg = s:GetMenuCacheFilename(a:filetype)
    " TLogVAR pg
    if filereadable(pg)
        exec 'source '. pg
    endif
endf


" :def: function! tskeleton#PrepareBits(?filetype=&filetype, ?reset=0)
" Prepare the buffer for use with tskeleton.
function! tskeleton#PrepareBits(...) "{{{3
    if a:0 >= 1 && !empty(a:1)
        let filetype = a:1
        " TLogVAR 'a:1', filetype
    else
        let filetype = s:Filetype()
    endif
    " TLogVAR a:0, filetype, &filetype
    call tskeleton#Initialize()
    " if filetype == ''
    "     let b:tskelFiletype = ''
    "     return
    " endif
    let explicit_reset = a:0 >= 2 ? a:2 : 0
    if explicit_reset
        for idx in range(1, s:tskelScratchMax)
            let ibn = bufnr(s:tskelScratchNr{idx})
            if bufloaded(ibn)
                exec 'noautocmd bdelete! '. ibn
            endif
        endfor
        let s:tskelScratchMax = 0
        if g:tskelUseBufferCache
            call s:ResetBufferCacheForFiletype(filetype)
        endif
    endif
    " TLogVAR explicit_reset
    let init_buffer    = !exists('b:tskelFiletype') || b:tskelFiletype != filetype
    " TLogVAR init_buffer
    if !explicit_reset && !init_buffer
        return
    endif
    " TLogVAR filetype
    let ft_group = s:GetBitGroup(filetype)
    " TAssert IsList(ft_group)
    " TLogVAR ft_group
    let to_be_initialized = s:FiletypesToBeInitialized(ft_group, explicit_reset)
    " TAssert IsList(to_be_initialized)
    " TLogVAR to_be_initialized
    if init_buffer || !empty(to_be_initialized)
        if !explicit_reset && g:tskelUseBufferCache && s:HasCachedBufferBits(filetype)
            " TLogDBG 'PrepareBufferFromCache'
            call s:PrepareBufferFromCache(filetype)
        else
            call s:InitBufferMenu()
            let b:tskelBitDefs  = {}
            for gfiletype in ft_group
                " TLogVAR gfiletype
                let reset = s:ToBeInitialized(to_be_initialized, gfiletype)
                let resetcache = explicit_reset || !s:FiletypeInCache(gfiletype)
                " TLogVAR reset, resetcache
                if reset
                    if resetcache
                        call s:PrepareFiletype(gfiletype, reset)
                    else
                        call s:PrepareFiletypeFromCache(gfiletype)
                    endif
                endif
                " TLogDBG 'ExtendBitDefs'
                call s:ExtendBitDefs(b:tskelBitDefs, gfiletype)
                " TLogDBG 'PrepareFiletypeMap'
                call s:PrepareFiletypeMap(gfiletype, reset)
                if reset
                    if resetcache
                        " TLogDBG 'CacheFiletypeBits'
                        call s:CacheFiletypeBits(gfiletype)
                    endif
                    if !tskeleton#IsScratchBuffer()
                        " TLogDBG 'PrepareFiletypeMenu'
                        call s:PrepareFiletypeMenu(gfiletype)
                    endif
                endif
            endfor
            " if s:PrepareBuffer(gfiletype) && empty(&buftype)
            if s:PrepareBuffer(gfiletype) && g:tskelUseBufferCache
                " TLogDBG 'CacheBufferBits'
                call s:CacheBufferBits(gfiletype)
            endif
        endif
        " TAssert IsDictionary(b:tskelBitDefs)
        " let b:tskelBitNames = keys(b:tskelBitDefs)
        " let b:tskelBitNames = tlib#list#Compact(tlib#list#Flatten(b:tskelBitNames))
        " if g:tskelPopupNumbered
        "     call map(b:tskelBitNames, "substitute(v:val, '&', '', 'g')")
        " endif
        " TLogDBG 'tskeleton#BuildBufferMenu'
        call tskeleton#BuildBufferMenu(0)
        let b:tskelFiletype = filetype
    endif
endf


function! s:HasCachedBufferBits(filetype) "{{{3
    let cname = s:GetBufferCacheFilename(a:filetype)
    return filereadable(cname)
endf


function! s:CacheBufferBits(filetype) "{{{3
    let cname = s:GetBufferCacheFilename(a:filetype, 1)
    if !empty(cname)
        " TLogVAR cname
        call writefile([string(s:GetBitDefs())], cname, 'b')
    endif
endf


function! s:PrepareBufferFromCache(filetype) "{{{3
    let cname = s:GetBufferCacheFilename(a:filetype)
    let b:tskelBitDefs = eval(join(readfile(cname, 'b'), "\n"))
endf


function! s:FiletypeInCache(filetype) "{{{3
    let cache = s:GetFiletypeBitsCacheFilename(a:filetype)
    let filereadable = filereadable(cache)
    " TLogVAR cache, filereadable
    return filereadable
endf


function! s:PrepareFiletypeFromCache(filetype) "{{{3
    let cache = s:GetFiletypeBitsCacheFilename(a:filetype)
    if !empty(cache)
        let g:tskelBits_{a:filetype} = eval(join(readfile(cache, 'b'), "\n"))
        " TLogVAR cache, len(g:tskelBits_{a:filetype})
    endif
endf


function! s:CacheFiletypeBits(filetype) "{{{3
    let cache = s:GetFiletypeBitsCacheFilename(a:filetype)
    if !empty(cache)
        call writefile([string(g:tskelBits_{a:filetype})], cache, 'b')
        " TLogVAR cache, len(g:tskelBits_{a:filetype})
    endif
endf


function! s:PrepareFiletype(filetype, reset)
    " TLogVAR a:filetype
    " TLogVAR a:reset
    let g:tskelBits_{a:filetype} = {}
    let fns = s:CollectFunctions('tskeleton#%s#FiletypeBits')
                \ + s:CollectFunctions('tskeleton#%s#FiletypeBits_'. a:filetype)
    " TLogVAR fns
    for fn in fns
        " TLogDBG 'PrepareFiletype '.fn
        call {fn}(g:tskelBits_{a:filetype}, a:filetype)
        " TLogVAR fn, len(g:tskelBits_{a:filetype})
    endfor
    " TLogDBG 'bits for '. a:filetype .'='. string(keys(g:tskelBits_{a:filetype}))
endf


function! s:PrepareBuffer(filetype)
    " TLogDBG bufname('%')
    let fns = s:CollectFunctions('tskeleton#%s#BufferBits')
                \ + s:CollectFunctions('tskeleton#%s#BufferBits_'. a:filetype)
    " TLogVAR fns
    for fn in fns
        " TLogDBG 'PrepareBuffer '.fn
        call {fn}(s:GetBitDefs(), a:filetype)
    endfor
    " TLogDBG string(keys(b:tskelBitDefs))
    return !empty(fns)
endf


function! s:CollectFunctions(pattern)
    let rv = []
    let ts = tlib#var#Get('tskelTypes', 'bg')
    call tskeleton#Initialize(ts)
    for t in ts
        let f = printf(a:pattern, t)
        " TLogVAR f
        " TLogDBG exists('*'. f)
        if exists('*'. f)
            call add(rv, f)
        endif
    endfor
    " let types   = '\('. join(tlib#var#Get('tskelTypes', 'bg'), '\|') .'\)'
    " let pattern = printf(a:pattern, types)
    " let fns = tlib#cmd#OutputAsList('function /'. pattern)
    " let rv  = map(fns, 'matchstr(v:val, ''^\S\+\s\+\zs.\{-}\ze('')')
    " call filter(rv, '!empty(v:val)')
    " TLogVAR a:pattern, ts, rv
    return rv
endf


" function! s:PrepareConditionEntry(pattern, eligible) "{{{3
"     let pattern  = escape(substitute(a:pattern, '%', '%%', 'g'), '"')
"     let eligible = escape(a:eligible, '"')
"     return 'if search("'. pattern .'%s", "W") | return "'. eligible .'" | endif | '
" endf


function! s:ReadFile(filename) "{{{3
    " TAssert IsString(a:filename)
    if filereadable(a:filename)
        return join(readfile(a:filename), "\n")
    endif
    return ''
endf


function! s:ReadSkeleton(filename) "{{{3
    let lines = readfile(a:filename)
    let [text, meta] = tskeleton#ExtractMeta(join(lines, "\n"))
    " echom "DBG" text string(meta)
    " TLogDBG string(getlines(1, line('$')))
    " let lines = split(text, '\n', 1)
    " TLogVAR lines
    " call append(0, lines)
    call tlib#buffer#InsertText(text)
    " norm! Gdd
    " echom "DBG ReadSkeleton" string(getline(1, line('$')))
    return meta
endf


function! s:PrepareFiletypeMap(filetype, anyway) "{{{3
    if !exists('g:tskelBitMap_'. a:filetype) || a:anyway
        let fn = g:tskelMapsDir . a:filetype
        let c  = s:ReadFile(fn)
        if c =~ '\S'
            let g:tskelBitMap_{a:filetype} = {}
            for line in split(c, "\n")
                let pattern = matchstr(line, '^.\{-}\ze\t')
                if !empty(pattern)
                    let bits    = matchstr(line, '\t\zs.*$')
                    let g:tskelBitMap_{a:filetype}[pattern] = split(bits, '\s\+')
                endif
            endfor
        endif
    endif
endf


function! s:PrepareFiletypeMenu(filetype) "{{{3
    " TLogVAR a:filetype
    if a:filetype == 'general'
        call s:PrepareMenu('general', 'General')
    else
        call s:PrepareMenu(a:filetype)
    endif
endf


function! s:ExtendBitDefs(dict, filetype) "{{{3
    " TAssert IsDictionary(a:dict)
    if s:DidSetup(a:filetype)
        let bm = g:tskelBits_{a:filetype}
        " TAssert IsDictionary(bm)
        if !empty(bm)
            call extend(a:dict, bm)
        endif
    endif
endf


function! tskeleton#ResetBits(filetype) "{{{3
    let filetype =  empty(a:filetype) ? &filetype : a:filetype
    for bn in range(1, bufnr('$'))
        if bufloaded(bn) && (filetype == 'general' || getbufvar(bn, 'tskelFiletype') == filetype)
            call setbufvar(bn, 'tskelFiletype', '')
        endif
    endfor
    call tskeleton#PrepareBits(filetype, 1)
endf


function! tskeleton#SelectBit(ArgLead, CmdLine, CursorPos) "{{{3
    call tskeleton#PrepareBits()
    return join(s:EligibleBits(&filetype), "\n")
endf


function! s:SetLine(mode) "{{{3
    let s:tskelLine = line('.')
    let s:tskelCol  = col('.')
endf


function! s:UnsetLine() "{{{3
    let s:tskelLine = 0
    let s:tskelCol  = 0
endf


function! s:GetEligibleBits(filetype) "{{{3
    let pos = '\\%'. s:tskelLine .'l\\%'. s:tskelCol .'c'
    for pattern in keys(g:tskelBitMap_{a:filetype})
        if search(pattern.pos, 'W')
            return g:tskelBitMap_{a:filetype}[pattern]
        endif
    endfor
    return []
endf


function! s:EligibleBits(filetype) "{{{3
    if s:tskelLine && exists('g:tskelBitMap_'. a:filetype)
        norm! {
        let eligible = s:GetEligibleBits(a:filetype)
        " TAssert IsList(eligible)
        call cursor(s:tskelLine, s:tskelCol)
        if !empty(eligible)
            " TLogDBG a:filetype.': '. string(eligible)
            return eligible
        endif
    endif
    let ok = filter(items(s:GetBitDefs()), 'eval(get(get(get(v:val, 1, {}), "meta", {}), "condition", 1))')
    return map(ok, 'v:val[0]')
    " if exists('b:tskelBitNames')
    "     " TAssert IsList(b:tskelBitNames)
    "     " TLogVAR b:tskelBitNames
    "     return b:tskelBitNames
    " else
    "     return []
    " endif
endf


function! s:EditScratchBuffer(filetype, ...) "{{{3
    let idx = a:0 >= 1 ? a:1 : s:tskelScratchIdx
    if exists("s:tskelScratchNr". idx) && s:tskelScratchNr{idx} >= 0
        let tsbnr = bufnr(s:tskelScratchNr{idx})
    else
        let tsbnr = -1
    endif
    let vars = map(copy(s:tskelScratchVars), 'exists("b:".v:val) ? ["b:".v:val, b:{v:val}] : ["", ""]')
    let tskel_bitDefs = b:tskelBitDefs
    let tskelFiletype = b:tskelFiletype
    if tsbnr >= 0
        " TLogVAR tsbnr
        silent exec "noautocmd sbuffer ". tsbnr
    else
        silent noautocmd split
        " TLogVAR idx
        " TLogDBG 'edit __TSkeletonScratch_'. idx .'__'
        silent exec 'noautocmd edit __TSkeletonScratch_'. idx .'__'
        " TLogDBG 1
        let s:tskelScratchNr{idx} = bufnr("%")
        " let b:tskelScratchBuffer = 1
    endif
    for [var, val] in vars
        if !empty(var) && !exists(var)
            let {var} = val
        endif
    endfor
    " TLogDBG 2
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal nobuflisted
    setlocal foldlevel=99
    setlocal foldmethod=manual
    silent norm! ggdG
    " TLogVAR a:filetype, tskelFiletype
    " TLogDBG 3
    " Let's assume the bits get inherited from the parent buffer
    let b:tskelFiletype = tskelFiletype
    let b:tskelBitDefs = copy(tskel_bitDefs)
    " TLogDBG 4
    if exists('*TSkelNewScratchHook_'. a:filetype)
        call TSkelNewScratchHook_{a:filetype}()
    endif
    " TLogDBG 'exit'
endf


function! tskeleton#IsScratchBuffer()
    " return exists('b:tskelScratchBuffer') || bufname('%') =~ '\V__TSkeletonScratch_\d\+__'
    return bufname('%') =~ '\V__TSkeletonScratch_\d\+__'
endf


function! tskeleton#Retrieve(name) "{{{3
    let [setCursor, bittext] = s:RetrieveBit('text', a:name)
    return bittext
endf


function! s:Filetype() "{{{3
    if exists('b:tskelFiletype')
        let filetype = b:tskelFiletype
    elseif exists('g:tskelFiletype')
        let filetype = g:tskelFiletype
    else
        let filetype = &filetype
    endif
    " TLogVAR filetype
    return filetype
endf


" s:RetrieveBit(agent, bit, ?indent, ?filetype) => setCursor?; @t=expanded template bit
function! s:RetrieveBit(agent, bit, ...) "{{{3
    if s:tskelScratchIdx >= g:tskelMaxRecDepth
        return 0
    endif
    " TLogVAR a:agent, a:bit
    let indent = a:0 >= 1 ? a:1 : ''
    let filetype = a:0 >= 2 ? a:2 : s:Filetype()
    " TLogVAR filetype
    let rv     = ''
    if s:tskelScratchIdx == 0
        let s:tskelDestBufNr = bufnr("%")
    endif
    let s:tskelScratchIdx = s:tskelScratchIdx + 1
    if s:tskelScratchIdx > s:tskelScratchMax
        let s:tskelScratchMax = s:tskelScratchIdx
        let s:tskelScratchNr{s:tskelScratchIdx} = -1
    endif
    let setCursor  = 0
    let pos        = getpos('.')
    let processing = s:SetProcessing()
    let t          = @t
    try
        call s:EditScratchBuffer(filetype)
        if filetype != ""
            call tskeleton#PrepareBits(filetype)
        endif
        let type = tskeleton#BitDef(a:bit, 'type', 'tskeleton')
        " TLogVAR type
        " TLogExec sleep 3 | redraw
        if type != 'tskeleton'
            let retriever = printf('tskeleton#%s#Retrieve', type)
            " TLogVAR retriever
            let setCursor = {retriever}(a:bit, indent, filetype)
        else
            if s:RetrieveAgent_{a:agent}(a:bit)
                " TLogDBG string(getline(1, '$'))
                " call s:IndentLines(2, line("$"), indent)
                " TLogDBG string(getline(1, '$'))
                silent norm! gg
                call tskeleton#FillIn(a:bit, filetype)
                " TLogDBG string(getline(1, '$'))
                let setCursor = tskeleton#SetCursor('%', '', 1, 1)
                " TLogDBG string(getline(1, '$'))
            else
                echoerr "Internal error"
            endif
        endif
        " TLogVAR setCursor
        " TLogExec sleep 3 | redraw
        let bot = line('$')
        let rv = join(getline(1, bot), "\n")
        " TLogVAR rv
        let rv = tlib#string#Chomp(rv)
        " TLogVAR rv
    finally
        let @t = t
        call s:SetProcessing(processing)
        noautocmd wincmd c
        let s:tskelScratchIdx = s:tskelScratchIdx - 1
        if s:tskelScratchIdx == 0
            silent exec 'noautocmd buffer '. s:tskelDestBufNr
            let s:tskelDestBufNr = -1
        else
            silent exec 'noautocmd buffer '. s:tskelScratchNr{s:tskelScratchIdx}
        endif
        call setpos('.', pos)
    endtry
    " TLogVAR rv
    return [setCursor, rv]
endf


function! s:SetProcessing(...) "{{{3
    if a:0 >= 1
        let s:tskelProcessing = a:1
        return a:1
    else
        let rv = s:tskelProcessing
        let s:tskelProcessing = 1
        return rv
    endif
endf


" function! s:RetrieveAgent_read(bit) "{{{3
"     let cpo = &cpo
"     try
"       set cpoptions-=a
"       silent exec "0read ". escape(a:bit, '\#%')
"       norm! Gdd
"     finally
"       let &cpo = cpo
"     endtry
" endf


function! s:RetrieveAgent_text(bit) "{{{3
    " TLogVAR a:bit
    if s:IsDefined(a:bit)
        let text  = tskeleton#BitDef(a:bit, 'text')
        " TLogVAR text
        let lines = split(text, '\n', 1)
        " if lines[-1] != ''
        "     call add(lines, '')
        " endif
        " TLogVAR lines
        call append(0, lines)
        " TLogVAR line('$'), len(lines)
        if line('$') > len(lines)
        " if getline('$') == ""
            norm! Gdd
        endif
        return 1
    else
        " TLogDBG "Undefined bit: ". a:bit
        echoerr "Undefined bit: ". a:bit
        return 0
    endif
    " norm! Gdd
    " TLogDBG string(getline(1, '$'))
endf


function! s:InsertBit(agent, bit, mode) "{{{3
    " TLogVAR a:agent, a:bit, a:mode
    let c  = col(".")
    let e  = col("$")
    let l  = line(".")
    let li = getline(l)
    let sli = s:Subline(li, c, a:mode)
    let by = line2byte(l) + c
    " Adjust for vim idiosyncrasy
    " TLogVAR "orig", li, sli, c, e, l, by
    if c == e - 1 && li[c - 1] == " "
        let e = e - 1
    endif
    " TLogVAR "adj", li, sli, c, e, l, by
    let i = s:GetIndent(sli)
    let [setCursor, bittext] = s:RetrieveBit(a:agent, a:bit, i)
    " TLogVAR setCursor, bittext
    " TLogVAR getpos('.')
    call cursor(0, c)
    " TLogVAR getpos('.')
    let shift = s:InsertBitText(a:mode, bittext)
    " TLogVAR shift, getpos('.')
    if setCursor
        let ll = l + abs(setCursor) - 1
        " TLogVAR ll
        call tskeleton#SetCursor(l, ll, setCursor < 0)
    else
        let byte = by + len(bittext) - 1 + shift
        " TLogVAR byte, by, len(bittext)
        if s:IsInsertMode(a:mode) && s:IsEOL(a:mode) && len(li) > 0
            let byte += 1
        end
        exec 'go '. byte
        " TLogVAR getpos('.')
    endif
endf


function! s:InsertBitText(mode, bittext) "{{{3
    " TLogVAR a:mode, a:bittext
    " TLogDBG "Pre: ". getline('.')
    " call tlib#buffer#InsertText0(a:bittext, {
    "             \ 'pos': 's',
    "             \ 'indent': a:mode =~# 'l' ? 0 : 1,
    "             \ 'mode': a:mode,
    "             \ })
    " TLogDBG string(getline(1, '$'))
    " TLogExec sleep 3 | redraw
    let s:bit_lines = len(split(a:bittext, '\n', 1))
    let rv = tlib#buffer#InsertText(a:bittext, {
                \ 'shift': s:IsEOL(a:mode) ? 0 : -1,
                \ 'pos': 's',
                \ 'indent': a:mode =~# 'l' ? 0 : 1,
                \ })
    if !s:IsInsertMode(a:mode) && !s:IsEOL(a:mode)
        let rv -= 1
    endif
    " TLogExec sleep 3 | redraw
    " TLogDBG string(getline(1, '$'))
    " TLogDBG "Post: ". getline('.')
    return rv
endf


function! s:GetIndent(line) "{{{3
    return matchstr(a:line, '^\(\s*\)')
endf


function! s:IndentLines(from, to, indent) "{{{3
    " silent exec a:from.",".a:to.'s/\(^\|\n\)/\1'. escape(a:indent, '/\') .'/g'
    " TLogVAR a:indent
    silent exec a:from.",".a:to.'s/^/'. escape(a:indent, '/\') .'/g'
endf


function! s:CharRx(char) "{{{3
    let rv = '&\?'
    if a:char == '\\'
        return rv .'\('. tlib#url#EncodeChar('\') .'\|\\\)'
    elseif a:char =~ '[/*#<>|:"?{}~]'
        return rv .'\('. tlib#url#EncodeChar(a:char) .'\|'. a:char .'\)'
    else
        return rv . a:char
    endif
endf


function! s:BitRx(bit, escapebs) "{{{3
    let rv = substitute(escape(a:bit, '\'), '\(\\\\\|.\)', '\=s:CharRx(submatch(1))', 'g')
    return rv
endf


function! s:FindValue(list, function, ...)
    " TLogDBG "function=". a:function
    " TLogDBG "list=". string(a:list)
    for elt in a:list
        try
            let fn  = printf(a:function, escape(string(elt), '\'))
            " TLogDBG "fn=". fn
            let val = eval(fn)
            " TLogDBG "val=". val
            if !empty(val)
                " TLogDBG "rv=". val
                return val
            endif
        catch
            echohl Error
            echom v:errmsg
            echohl NONE
        endtry
        unlet elt
    endfor
    return a:0 >= 1 ? a:1 : 0
endf


function! s:IsDefined(bit) "{{{3
    " TLogVAR bufname('%'), !empty(a:bit), exists('b:tskelBitDefs')
    " call tlog#Log("has_key(b:tskelBitDefs, a:bit) = ". has_key(b:tskelBitDefs, a:bit))
    return !empty(a:bit) && exists('b:tskelBitDefs') && has_key(b:tskelBitDefs, a:bit)
endf


function! s:GetBitDefs() "{{{3
    if !exists('b:tskelBitDefs')
        call tskeleton#PrepareBits()
    endif
    return exists('b:tskelBitDefs') ? b:tskelBitDefs : {}
endf


function! s:SelectAndInsert(bit, mode) "{{{3
    " TLogVAR a:bit
    if s:IsDefined(a:bit)
        call s:InsertBit('text', a:bit, a:mode)
        return 1
    endif
    return 0
endf


" tskeleton#Bit(bit, ?mode='n')
function! tskeleton#Bit(bit, ...) "{{{3
    " TLogVAR a:bit
    " TAssert IsNotEmpty(a:bit)
    call tskeleton#PrepareBits()
    let mode = a:0 >= 1 ? a:1 : 'n'
    let processing = s:SetProcessing()
    " let wlayout    = tlib#win#GetLayout(1)
    let wlayout    = tlib#win#GetLayout()
    let s:tskel_use_placeholders = 0
    let s:bit_lines = 0
    try
        if empty(a:bit)
            call s:BitMenu(a:bit, mode, s:Filetype())
        elseif s:SelectAndInsert(a:bit, mode)
            " call tlog#Debug('s:SelectAndInsert ok')
            return 1
        else
            " call tlog#Debug("TSkeletonBit: Unknown bit '". a:bit ."'")
            if s:IsPopup(mode)
                call s:InsertBitText(mode, a:bit)
                return 1
            endif
            return 0
        endif
        " catch
        "     echom "An error occurred in TSkeletonBit() ... ignored"
    finally
        let lnum = line('.')
        call tskeleton#Placeholders(lnum, lnum + s:bit_lines - 1)
        call tlib#win#SetLayout(wlayout)
        call s:SetProcessing(processing)
    endtry
endf


function! s:IsInsertMode(mode) "{{{3
    return a:mode =~? 'i'
endf


function! s:IsEOL(mode) "{{{3
    if a:mode =~ 'g'
        let mode = a:mode . s:Eol(a:mode, col('.'))
    else
        let mode = a:mode
    endif
    " TLogVAR a:mode, mode
    return mode =~? '1'
endf


function! s:IsPopup(mode) "{{{3
    return a:mode =~? 'p'
endf


function! s:Subline(line, col, mode) "{{{3
    " TLogVAR a:line, a:col, a:mode
    let e = a:col - 1
    " if s:IsInsertMode(a:mode) || s:IsEOL(a:mode)
    " if a:col == 1 && s:IsInsertMode(a:mode)
    "     let e -= 1
    " endif
    if s:IsEOL(a:mode)
        let e += 1
    endif
    if e < 0
        let e = 0
    endif
    let rv = strpart(a:line, 0, e)
    " TLogVAR rv
    return rv
endf


function! s:BitMenu(bit, mode, filetype) "{{{3
    " TLogVAR a:bit
    if has("menu") && g:tskelQueryType == 'popup'
        return s:BitMenu_menu(a:bit, a:mode, a:filetype)
    else
        return s:BitMenu_query(a:bit, a:mode, a:filetype)
    endif
endf


function! s:BitMenuEligible(agent, bit, mode, filetype) "{{{3
    " TLogVAR a:agent, a:bit, a:mode, a:filetype
    call s:SetLine(a:mode)
    let t = copy(s:EligibleBits(a:filetype))
    " TLogVAR len(t)
    " TAssert IsList(t)
    let s:tskelMenuEligibleIdx = 0
    let s:tskelMenuEligibleRx  = '^'. s:BitRx(a:bit, 0)
    call filter(t, 'v:val =~ ''\S'' && s:MatchBit(v:val, s:tskelMenuEligibleRx)')
    " TLogVAR len(t)
    if g:tskelPopupNumbered
        call sort(t)
    endif
    let e = map(t, 's:BitMenuEligible_'. a:agent .'_cb(v:val, '. string(a:mode) .')')
    " TAssert IsList(e)
    " TLogDBG 'e='. string(e)
    return tlib#list#Compact(e)
endf


function! s:MatchBit(value, rx) "{{{3
    let case_sensitive = tlib#var#Get('tskelCaseSensitive_'. s:Filetype(), 'bg', tlib#var#Get('tskelCaseSensitive', 'bg'))
    if case_sensitive == 1
        return a:value =~# a:rx
    elseif case_sensitive == -1
        return a:value =~ a:rx
    elseif case_sensitive == 0
        return a:value =~? a:rx
    else
        echoerr 'tskelCaseSensitive: Must be one of: 1, -1, 0'
    endif
endf


function! s:BitMenuEligible_complete_cb(bit, mode) "{{{3
   return s:BitMenuEligible_query_cb(a:bit, a:mode)
endf


function! s:BitMenu_query(bit, mode, filetype) "{{{3
    let s:tskelQueryAcc = s:BitMenuEligible('query', a:bit, a:mode, a:filetype)
    if len(s:tskelQueryAcc) <= 1
        let rv = get(s:tskelQueryAcc, 0, a:bit)
        let rv = get(s:tskelQueryAcc, 0, '')
    else
        let qu = "s:tskelQueryAcc|Select bit:"
        let rv = s:Query(qu)
    endif
    " TLogVAR rv
    if rv != ''
        call tskeleton#Bit(rv, a:mode .'p')
        return 1
    endif
    return 0
endf


function! s:BitMenuEligible_query_cb(bit, mode) "{{{3
    return tlib#url#Decode(a:bit)
endf


function! s:BitMenu_menu(bit, mode, filetype) "{{{3
    try
        silent! aunmenu ]TSkeleton
    catch
        " echohl Error
        " echom v:errmsg
        " echohl NONE
    endtry
    " TLogDBG 'bit='. a:bit
    let rv = s:BitMenuEligible('menu', a:bit, a:mode, a:filetype)
    " TAssert IsList(rv)
    let j = len(rv)
    if j == 1
        exec s:tskelMenuEligibleEntry
        return 1
    elseif j > 0
        popup ]TSkeleton
        return 1
    endif
    return 0
endf


function! s:BitMenuEligible_menu_cb(bit, mode) "{{{3
    " TAssert IsString(a:bit)
    " TLogDBG 'bit='. a:bit
    " call tlog#Debug('tskelMenuEligibleRx=~'. a:bit =~ s:tskelMenuEligibleRx)
    let s:tskelMenuEligibleIdx = s:tskelMenuEligibleIdx + 1
    if g:tskelPopupNumbered
        if stridx(a:bit, '&') == -1
            let x = substitute(s:tskelMenuEligibleIdx, '\(.\)$', '\&\1', '')
        else
            let x = s:tskelMenuEligibleIdx
        end
        let x .= '\ '
        let m = a:bit
    else
        let x = ''
        let m = escape(tskeleton#BitDef(a:bit, 'menu'), '"\ 	')
    endif
    let s:tskelMenuEligibleEntry = 'call tskeleton#Bit('. string(a:bit) .', "'. a:mode .'p")'
    " call tlog#Debug(s:tskelMenuEligibleEntry)
    exec 'amenu ]TSkeleton.'. x . m .' :'. s:tskelMenuEligibleEntry .'<cr>'
    return 1
endf


function! s:Eol(mode, col) "{{{3
    " TLogVAR a:mode, a:col, col('$'), a:col >= col('$')
    " TLogDBG col('.') .'-'. col('$')
    " echom "DBG Eol ". a:mode .' '. s:IsInsertMode(a:mode)
    " if s:IsInsertMode(a:mode)
    "     return a:col >= col('$')
    " else
        return a:col >= col('$') && &virtualedit =~ '^\(block\|onemore\)\?$'
    " endif
endf


" tskeleton#ExpandBitUnderCursor(mode, ?bit="", ?default={})
" See also |g:tskelHyperComplete|.
function! tskeleton#ExpandBitUnderCursor(mode, ...) "{{{3
    let bit     = a:0 >= 1 && a:1 != '' ? a:1 : ''
    let default = a:0 >= 2 && !empty(a:2) ? a:2 : {}
    let line  = line('.')
    let l     = getline(line)
    let col0  = col('.')
    " TLogVAR 1, col('.')
    " TLogDBG 'ExpandBit saveview '. line('w0')
    let view  = winsaveview()
    " TLogVAR line, col0, l
    " TLogVAR bit
    call tskeleton#PrepareBits()
    let t = @t
    let lazyredraw = &lazyredraw
    set lazyredraw
    let unset_ft = !exists('g:tskelFiletype')
    if unset_ft
        let g:tskelFiletype = &filetype
    endif
    " TLogVAR g:tskelFiletype
    " TLogVAR 2, col('.')
    try
        let @t    = ''
        let filetype = s:Filetype()
        let imode = s:IsInsertMode(a:mode)
        " TLogVAR a:mode, imode, col0
        let col   = col0
        if imode
            if s:Eol(a:mode, col)
                let eol_adjustment = 1
            else
                let col -= 1
                let eol_adjustment = 0
            endif
        else
            let eol_adjustment = (col + 1 >= col('$'))
        endif
        " TLogVAR imode, eol_adjustment
        let mode = a:mode . eol_adjustment
        " TLogVAR 3, col('.')
        " TLogVAR mode
        " TLogDBG string(getline(line))
        if bit != ''
            let @t = bit
        else
            let c = l[col - 1]
            let pos = '\%#'
            if c =~ '\s'
                let @t = ''
                " TLogDBG " 0 @t=". @t
                if !imode && !eol_adjustment
                    norm! l
                endif
            elseif s:SearchKeyword(filetype, pos)
                if imode && eol_adjustment
                    let d = col - col('.')
                else
                    let d = col - col('.') + 1
                endif
                " TLogVAR imode, eol_adjustment, d, col, col('.')
                if d > 0
                    exec 'silent norm! "td'. d .'l'
                else
                    exec 'silent norm! "tdl'
                endif
                " TLogDBG " 1 @t='". @t ."'"
            elseif imode && !eol_adjustment
                silent norm! h"tdiw
                " TLogDBG " 2 @t='". @t ."'"
            else
                silent norm! "tdiw
                " TLogDBG " 3 @t='". @t ."'"
            endif
        endif
        " TLogDBG "#1". getline(line)
        let bit = @t
        if bit =~ '^\s\+$'
            let bit = ''
        endif
        " TLogDBG " 4 bit='". bit ."'"
        " TLogDBG string(getline(line))
        if bit != '' && tskeleton#Bit(bit, mode) == 1
            " call tlog#Debug("TSkeletonBit succeeded!")
            return 1
        elseif (bit	!= '' || empty(default)) && s:BitMenu(bit, mode, filetype)
            " call tlog#Debug("s:BitMenu succeeded!")
            " TLogVAR mode, bit, default
            " return s:InsertDefault(mode, bit, default)
            return 0
        endif
        " TLogDBG "#2". getline(line)
        " TLogVAR bit
        " TLogVAR default
        let s:got_default_string = 0
        " TLogDBG 'ExpandBit w0='. line('w0')
        " TLogDBG string(getline(line))
        if s:InsertDefault(mode, bit, default)
            " TLogDBG 's:InsertDefault succeeded! '. line('w0')
            return 1
        else
            " TLogDBG "#3". getline(line)
            " TLogDBG 'Last ressort'
            if s:got_default_string
                " TLogDBG 'got_default_string'
                " TLogDBG string(getline(line))
                call s:InsertBitText(mode, bit)
                let success = 0
            else
                " TLogDBG 'GetDefaultString'
                let [success, default_string] = s:GetDefaultString(bit, default)
                " TLogVAR success, default_string
                " TLogDBG string(getline(line))
                call s:InsertBitText(mode, default_string)
            endif
            if !success
                echom "TSkeletonBit: Unknown bit '". bit ."'"
            endif
            " TLogVAR line, col0
            " call cursor(line, col0, imode)
            " call cursor(line, col0)
            " TLogDBG col('.')
            call winrestview(view)
            " TLogDBG 'ExpandBit restview '. line('w0')
            return success
        endif
    finally
        let @t = t
        call s:UnsetLine()
        let lazyredraw  = &lazyredraw
        if unset_ft
            unlet g:tskelFiletype
        endif
    endtry
endf


function! s:KeywordRx(...) "{{{3
    TVarArg ['quantifier', '\{-}'], ['filetype', '']
    " TLogVAR filetype
    if empty(filetype)
        let filetype = s:Filetype()
    endif
    let rx = tlib#var#Get('tskelKeyword_'. filetype, 'bg', '\k\Q')
    " TLogVAR filetype, rx
    let rx = substitute(rx, '\(\\\)\@<!\\Q', tlib#rx#EscapeReplace(quantifier), 'g')
    " TLogVAR rx
    return rx
endf


function! s:SearchKeyword(filetype, pos) "{{{3
    let kw = s:KeywordRx()
    if !empty(kw)
        " TLogVAR kw
        let pat = kw . a:pos
        " TLogVAR pat
        let found = search(pat) != -1
        return found
    else
        return 0
    endif
endf


function! tskeleton#WithSelection(pre) "{{{3
    let text = @"
    let bit = input('Skeleton: ', '', 'custom,tskeleton#SelectBit')
    " TLogVAR bit
    if !empty(bit)
        call tskeleton#Bit(bit)
        call tlib#buffer#InsertText(a:pre . tlib#string#Chomp(text), {
                    \ 'shift': -1,
                    \ 'pos': 's',
                    \ 'indent': 0,
                    \ })
    else
        norm! u
    endif
endf


function! s:InsertDefault(mode, bit, default) "{{{3
    " TLogVAR a:mode, a:bit, a:default
    if !empty(a:default)
        let view = winsaveview()
        let [success, default_string] = s:GetDefaultString(a:bit, a:default)
        " TLogVAR success, default_string
        if success
            call winrestview(view)
            let pos = getpos('.')
            call s:InsertBitText(a:mode, default_string)
            " TLogDBG col('.')
            if default_string =~ '<+CURSOR+>'
                call setpos('.', pos)
                if search('<+CURSOR+>', 'W')
                    norm! cf>
                endif
            else
                let left = len(default_string)
                if col('.') == 1
                    let left -= 1
                endif
                exec 'norm! '. left .'l'
            endif
            if s:IsInsertMode(a:mode)
                call cursor(line('.'), col('.') + 1)
            endif
        endif
        return success
    else
        return 0
    endif
endf


function! s:AddDefaultCompletions(completions, bit, default) "{{{3
    " TLogVAR a:default
    for [name, fn] in items(tlib#var#Get('tskel_completions', 'bg', {}))
        if has_key(a:default, name)
            call call(fn, [a:bit, a:completions])
            " TLogVAR name, fn, len(a:completions)
        endif
    endfor
    return a:completions
endf


function! s:GetDefaultString(bit, default) "{{{3
    " TLogVAR a:bit, a:default
    " Don't call this function twice in one go -- see tskeleton#ExpandBitUnderCursor().
    let s:got_default_string = 1
    let completions = {}
    call s:AddDefaultCompletions(completions, a:bit, a:default)

    if !empty(completions)
        " TLogDBG 'Process completions'
        let s:tskelQueryAcc = keys(completions)
        " call sort(s:tskelQueryAcc, 1)
        " call tlog#Debug(string(s:tskelQueryAcc))
        let rv = s:Query("s:tskelQueryAcc|Select bit:")
        " TLogVAR rv
        return [!empty(rv), rv]
    endif

    if has_key(a:default, 'string')
        " TLogDBG 'Process string'
        " TLogVAR a:default.string
        return [1, a:bit . a:default.string]
    endif

    " TLogDBG "Fall back"
    " TLogVAR a:bit
    return [0, a:bit]
endf


function! tskeleton#Complete_use_omnifunc(bit, completions) "{{{3
    " TLogDBG 'use_omnifunc'
    if !empty(&omnifunc)
        " TLogDBG 'use_omnicomplete'
        for w in tskeleton#GetCompletions(&omnifunc, a:bit)
            let [cname, mname] = tskeleton#PurifyBit(w)
            let a:completions[w] = {'text': w, 'menu': 'OmniComplete.'. mname, 'type': 'tskeleton'}
        endfor
    endif
endf


function! tskeleton#Complete_use_completefunc(bit, completions) "{{{3
    if !empty(&completefunc)
        " TLogDBG 'use_completefunc'
        for w in tskeleton#GetCompletions(&completefunc, a:bit)
            let [cname, mname] = tskeleton#PurifyBit(w)
            let a:completions[w] = {'text': w, 'menu': 'CompleteFunc.'. mname, 'type': 'tskeleton'}
        endfor
    endif
endfun


function! tskeleton#Complete_scan_words(bit, completions) "{{{3
    " TLogVAR a:bit
    " TLogDBG 'scan_tags saveview '. line('w0')
    let view = winsaveview()
    if !empty(a:bit)
        let kw = '\k\+'
        let rx = tlib#rx#Escape(a:bit) . kw
        " TLogVAR kw, rx
        norm! G$
        let [lnum, col] = searchpos(rx, 'w')
        " TLogVAR lnum, col
        while lnum > 0
            let subline = getline(lnum)[col - 1 : -1]
            let match = matchstr(subline, '^'. rx)
            if !empty(match)
                " TLogVAR subline, match
                let a:completions[match] = {'text': match, 'type': 'tskeleton'}
            endif
            norm! w
            " TLogVAR lnum, col, match, subline
            let [lnum, col] = searchpos(rx, 'W')
        endwh
        call winrestview(view)
    endif
    " TLogDBG 'scan_tags restview '. line('w0')
endf


function! tskeleton#Complete_scan_tags(bit, completions) "{{{3
    " TLogDBG 'scan_tags'
    let tags = taglist('^'. tlib#rx#Escape(a:bit))
    if !empty(tags)
        for tag in tags
            let a:completions[tag.name] = {'text': tag.name, 'type': 'tskeleton'}
        endfor
    endif
endf


function! tskeleton#GetCompletions(func, bit) "{{{3
    let b:compl_context = getline('.')[0 : col('.')] . a:bit
    let completions = call(a:func, [0, a:bit])
    " TLogVAR a:func, completions
    call map(completions, 'substitute(type(v:val) == 4 ? v:val.word : v:val, "($", "", "")')
    call filter(completions, 'v:val != a:bit')
    return completions
endf


" :display: tskeleton#Complete(findstart, base, ?default={})
" A function suitable for use as 'completefunc' or 'omnifunc'.
" You have to accept a match with <c-y> in order to trigger skeleton 
" expansion. See |popupmenu-keys|.
function! tskeleton#Complete(findstart, base, ...)
    " TLogVAR a:findstart, a:base
    if a:findstart
        let pattern = s:KeywordRx()
        let line    = strpart(getline('.'), 0, col('.') - 1)
        let start   = match(line, pattern.'$')
        " TLogVAR pattern, line, start
        return start == -1 ? col('.') - 1 : start
    else
        let default = a:0 >= 1 ? a:1 : {}
        " TAssertType default, 'dictionary'
        let filetype = s:Filetype()
        let t = s:BitMenuEligible('complete', a:base, 'i', filetype)
        let setup_done = s:DidSetup(filetype)
        " TLogVAR len(t), setup_done
        if setup_done
            let completions = copy(g:tskelBits_{filetype})
            " TLogVAR len(completions)
            call filter(completions, 'strpart(v:val.text, 0, len(a:base)) ==# a:base')
            " TLogVAR len(completions)
            if !empty(default)
                call s:AddDefaultCompletions(completions, a:base, default)
            endif
            " TLogVAR len(completions), completions
            for [bit, def] in items(completions)
                " TLogVAR bit, def
                " TAssert IsDictionary(def)
                call add(t, {'word': def['text'], 'abbr': bit})
            endfor
        endif
        if len(t) > 0
            let s:pum_complete_args = {
                        \ 'pos': getpos('.'),
                        \ 'eol': col('.') >= col('$'),
                        \ 'view': winsaveview(),
                        \ 'eligible': t,
                        \ }
            " call tlog#Debug("s:pum_complete_args: ". string(s:pum_complete_args))
            autocmd! tSkeleton CursorMoved,CursorMovedI,CursorHold,CursorHoldI <buffer>
            autocmd tSkeleton CursorMoved,CursorMovedI,CursorHold,CursorHoldI <buffer> call s:ExpandCompletion(s:pum_complete_args)
        endif
        " TAssert IsList(t)
        return t
    endif
endf


function! s:ExpandCompletion(args) "{{{3
    " TLogVAR pumvisible()
    if !pumvisible()
        autocmd! tSkeleton CursorMoved,CursorMovedI,CursorHold,CursorHoldI <buffer>
        " TLogVAR a:args.pos, bufnr('%'), col('.')
        if a:args.pos[0] == 0 || a:args.pos[0] == bufnr('%')
            let line = getline('.')
            let beg  = a:args.pos[2] - 1
            let end  = col('.') - 1
            let bit  = strpart(line, beg, end)
            " TLogVAR line, beg, end, bit
            if index(a:args.eligible, bit) != -1
                " exec 'norm! a'. repeat("\<BS>", len(bit))
                " call tskeleton#ExpandBitUnderCursor("n", bit)
                " norm! a<++><Left><Left><Left><Left><Left>
                call tskeleton#ExpandBitUnderCursor("i")
                redraw
            endif
        endif
    endif
endf


function! s:TagSelect(chars, mode) "{{{3
    " TLogDBG 'chars='. a:chars .' mode='. a:mode
    let chars = a:chars - s:InclusiveSelection()
    " TLogVAR chars
    if a:mode == 'd'
        let cp = col('.') + chars
        " TLogDBG 'col.='. col('.') .' colp='. cp .' col$='. col('$')
        if cp >= col('$')
            if &ve =~ 'all'
                let correction = '$l'
            else
                let correction = '$'
            endif
        else
            let correction = ''
        endif
        " TLogVAR correction
        exec 'norm! d'. chars .'l'.correction
    else
        " TLogDBG 'norm! v'. chars .'l'
        exec 'norm! v'. chars .'l'
        call s:SelectTagMode()
    endif
endf


function! s:InclusiveSelection() "{{{3
    return &selection =~ '^[io]' ? 1 : 0
endf


function! s:SelectTagMode() "{{{3
    if g:tskelSelectTagMode[0] == 's'
        exec "norm! \<c-g>"
    endif
endf


function! tskeleton#GoToNextTag() "{{{3
    let rx = '\('. g:tskelMarkerExtra .'\|'. tskeleton#WrapMarker('') .'\|'. tskeleton#TagRx() .'\)'
    let x  = search(rx, 'c')
    if x > 0
        let lc = exists('b:tskelLastCol')  ? b:tskelLastCol : col('.')
        " TLogVAR lc
        let l  = strpart(getline(x), lc - 1)
        " TLogVAR l
        let ms = matchstr(l, rx)
        " TLogVAR ms
        let ml = len(ms)
        " TLogVAR ml
        if ms =~# g:tskelMarkerExtra
            call s:TagSelect(ml, 'v')
        else
            if ml == 4
                call s:TagSelect(ml + s:InclusiveSelection(), 'd')
            else
                let defrx = tskeleton#WrapMarker('.\{-}/\zs.\{-}\ze', 'rx')
                if ms =~ defrx
                    let default = matchstr(ms, defrx)
                    " TLogVAR getline('.')
                    call s:TagSelect(ml, 'd')
                    " TLogVAR getline('.')
                    let shift = s:Eol('i', col('.')) ? 0 : -1
                    " TLogVAR shift
                    call tlib#buffer#InsertText(default, {'pos': 's', 'shift': shift})
                    " TLogVAR getline('.')
                    " TLogVAR col('.'), col('$')
                    if col('.') > 1
                        norm! l
                    endif
                    exec 'norm! v'. len(default) .'l'
                    if !empty(&selectmode)
                        call feedkeys("\<c-g>")
                    endif
                else
                    call s:TagSelect(ml, 'v')
                endif
            endif
        endif
    endif
endf


let s:syn_clusters = {}


function! tskeleton#Placeholders(line1, line2) "{{{3
    if s:tskel_use_placeholders
        if !exists("b:tskelHighlight")
            if !empty(g:tskelMarkerHiGroup)
                " exec 'syntax match TSkelPlaceHolder /'. escape(tskeleton#WrapMarker('\w*', 'rx'), '/') .'/'
                let cchar = get(g:tskeleton#conceal_cchar, &enc, get(g:tskeleton#conceal_cchar, '_', ''))
                let conceal = empty(cchar) ? '' : (' conceal cchar='. cchar)
                " TLogVAR &enc, cchar, conceal
                exec 'syntax match TSkelPlaceHolder /'. escape(tskeleton#WrapMarker('.\{-}', 'rx'), '/') .'/'. conceal
                exec 'hi def link TSkelPlaceHolder '. g:tskelMarkerHiGroup
                if has_key(s:syn_clusters, &filetype)
                    let syn = s:syn_clusters[&filetype]
                else
                    let syn = tlib#cmd#OutputAsList('syn list')
                    call filter(syn, 'v:val =~ ''^\w\+\s\+cluster=''')
                    " TLogVAR syn
                    call map(syn, 'matchstr(v:val, ''^\w\+'')')
                    let s:syn_clusters[&filetype] = syn
                endif
                " TLogVAR syn
                for syncluster in syn
                    exec 'syn cluster' syncluster 'add=TSkelPlaceHolder'
                endfor
            endif
            let b:tskelHighlight = 1
        endif
        if g:tskeleton#enable_stakeholders
            " TLogVAR a:line1, a:line2
            if a:line1 > 0 && a:line2 >= a:line1
                call stakeholders#EnableInRange(a:line1, a:line2)
            else
                call stakeholders#EnableBuffer()
            endif
        endif
    endif
endf


function! tskeleton#LateExpand() "{{{3
    let l  = getline('.')
    let lc = col('.') - 1
    let left  = tlib#var#Get('tskelMarkerLeft', 'bg')
    let right = tlib#var#Get('tskelMarkerRight', 'bg')
    while strpart(l, lc, len(left)) != left
        " TLogVAR lc
        " TLogDBG strpart(l, lc, 2)
        let lc -= 1
        if lc <= -1 || strpart(l, lc, len(right)) == right
            throw "TSkeleton: No tag under cursor"
        endif
    endwh
    let l  = strpart(l, lc)
    let me = matchend(l, tskeleton#WrapMarker('.\{-}', 'rx'))
    if me < 0
        throw "TSkeleton: No tag under cursor"
    else
        let lp = substitute(strpart(l, 2, me - 4), '\W', '_', 'g')
        let v  = ''
        if exists('*TSkeletonCB_'. lp)
            let v = TSkeletonCB_{lp}()
        elseif exists('*TSkeleton_'. lp)
            let v = TSkeleton_{lp}()
        else
            throw 'TSkeleton: No callback defined for '. lp .' (TSkeletonCB_'. lp .')'
        endif
        if v != ''
            " exec 'norm! '. (lc + 1) .'|d'. me .'li'. v
            call cursor(0, lc + 1)
            exec 'norm! d'. me .'li'. v
            return
        endif
    endif
endf


" misc utilities {{{1
function! tskeleton#IncreaseRevisionNumber() "{{{3
    let rev = exists("b:revisionRx") ? b:revisionRx : g:tskelRevisionMarkerRx
    let ver = exists("b:versionRx")  ? b:versionRx  : g:tskelRevisionVerRx
    let pos = getpos('.')
    let rs  = @/
    " exec 'keepjumps %s/'.rev.'\('.ver.'\)*\zs\(-\?\d\+\)/\=(submatch(g:tskelRevisionGrpIdx) + 1)/e'
    exec '%s/'.rev.'\('.ver.'\)*\zs\(-\?\d\+\)/\=(submatch(g:tskelRevisionGrpIdx) + 1)/e'
    let @/  = rs
    call setpos('.', pos)
endf


function! tskeleton#CleanUpBibEntry() "{{{3
    " '{,'}s/^.*<+.\{-}+>.*\n//e
    exec printf('''{,''}s/^.*%s.*\n//e', tskeleton#WrapMarker('.\{-}', 'rx'))
    if exists('*TSkeletonCleanUpBibEntry_User')
        call TSkeletonCleanUpBibEntry_User()
    endif
endf


" tskeleton#Repeat(n, string, ?sep="\n")
function! tskeleton#Repeat(n, string, ...) "{{{3
    let sep = a:0 >= 1 ? a:1 : "\n"
    let rv  = a:string
    let n   = a:n - 1
    while n > 0
        let rv = rv . sep . a:string
        let n  = n - 1
    endwh
    return rv
endf


function! tskeleton#InsertTable(rows, cols, rowbeg, rowend, celljoin) "{{{3
    let y = a:rows
    let r = ''
    while y > 0
        let x = a:cols
        let r = r . a:rowbeg
        while x > 0
            if x == a:cols
                let r = r .tskeleton#WrapMarker('CELL')
            else
                let r = r . a:celljoin .tskeleton#WrapMarker('CELL')
            end
            let x = x - 1
        endwh
        let r = r. a:rowend
        if y > 1
            let r = r ."\n"
        endif
        let y = y - 1
    endwh
    return r
endf


function! tskeleton#HyperComplete_query(mode, default) "{{{3
    let col = col('.') - 1
    if s:IsInsertMode(a:mode) && col > 0
        let col -= 1
    endif
    let pre = getline('.')[0 : col]
    " TLogVAR col, pre
    if empty(pre) || pre =~ '\s$'
        " TLogVAR a:default
        let view = winsaveview()
        exec 'norm! '. a:default
        call winrestview(view)
    else
        " TLogVAR a:mode
        let w:tskeleton_hypercomplete = 1
        try
            let filetype = s:Filetype()
            call tskeleton#ExpandBitUnderCursor(a:mode, '', tlib#var#Get('tskelHyperComplete_'. filetype, 'bg', tlib#var#Get('tskelHyperComplete', 'bg', {})))
        finally
            unlet! w:tskeleton_hypercomplete
        endtry
    endif
endf


function! tskeleton#HyperComplete_pum(mode, default) "{{{3
    let start = tskeleton#Complete(1, "")
    let pos   = getpos('.')
    let line  = pos[1]
    let col   = pos[2]
    let text0 = getline(line)
    let base0 = strpart(text0, start)
    let kwrx  = s:KeywordRx('\+')
    let kwrx  = substitute(kwrx, '\(\\\)\@<!\\{-}', '\\+', 'g')
    " TLogVAR line, col, start, kwrx, text0, base0
    let base  = matchstr(base0, '^'. kwrx)
    let text  = strpart(text0, 0, start) . strpart(text0, start + len(base))
    " TLogVAR text, base
    let pos[2] = start + 1
    exec line .'delete'
    " TLogVAR text
    call append(line - 1, text)
    call setpos('.', pos)
    let filetype = s:Filetype()
    let hyper = tlib#var#Get('tskelHyperComplete_'. filetype, 'bg', tlib#var#Get('tskelHyperComplete', 'bg', {}))
    let completions = tskeleton#Complete(0, base, hyper)
    " TLogVAR len(completions)
    call sort(completions)
    call complete(col, completions)
    return ''
endf


