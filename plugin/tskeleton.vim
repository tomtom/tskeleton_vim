" tSkeleton.vim
" @Author:      Tom Link (micathom AT gmail com?subject=vim)
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     21-Sep-2004.
" @Last Change: 2012-10-25.
" @Revision:    3952
"
" GetLatestVimScripts: 1160 1 tskeleton.vim
" http://www.vim.org/scripts/script.php?script_id=1160

if &cp || exists("loaded_tskeleton") "{{{2
    finish
endif
if !exists('loaded_tlib') || loaded_tlib < 103
    runtime plugin/02tlib.vim
    if !exists('loaded_tlib') || loaded_tlib < 103
        echoerr "tSkeleton requires tlib >= 1.03"
        finish
    endif
endif
let loaded_tskeleton = 500


if !exists("g:tskelDir") "{{{2
    let g:tskelDir = get(split(globpath(&rtp, 'skeletons/'), '\n'), 0, '')
endif
if !isdirectory(g:tskelDir) "{{{2
    echoerr 'tSkeleton: g:tskelDir ('. g:tskelDir .') isn''t readable. See :help tSkeleton-install for details!'
    finish
endif
let g:tskelDir = tlib#dir#CanonicName(g:tskelDir)

if !exists('g:tskelGlobalBitsPath') "{{{2
    " A comma-separated list of directories (see |globpath()|) for 
    " globally available bits. If empty, use all "skeletons/bits/" 
    " subdirectories in 'runtimepath'.
    let g:tskelGlobalBitsPath = exists('g:tskelBitsDir') ? g:tskelBitsDir : ''  "{{{2
endif

if !exists('g:tskelLocalBitsDirs') "{{{2
    " A list of directories that contains buffer-local bits.
    let g:tskelLocalBitsDirs = ['.tskel', '_tskel']  "{{{2
endif

let g:tskeleton_SetFiletype = 1

if !exists("g:tskelMapLeader")
    " Map leader for maps in normal mode.
    let g:tskelMapLeader = "<Leader>#"  "{{{2
endif

if !exists("g:tskelMapInsert")
    " Map leader for maps in insert mode.
    let g:tskelMapInsert = '<c-\><c-\>'  "{{{2
endif

if !exists("g:tskelAddMapInsert")
    " If true, insert |g:tskelMapInsert| after expanding a bit. This 
    " could be useful if you plan to map |g:tskelMapInsert| to something 
    " like <space>.
    let g:tskelAddMapInsert  = 0  "{{{2
endif

if !exists("g:tskelMenuCache")
    " If non-empty, cache menu items.
    let g:tskelMenuCache = '.tskelmenu'  "{{{2
endif

if !exists("g:tskelMenuPrefix")
    " :nodoc:
    " Prefix for menu items.
    let g:tskelMenuPrefix  = 'TSke&l'  "{{{2
endif

if !exists("g:tskelMapGoToNextTag")
    " If non-empty, create maps for "go to next place holder" feature. 
    " This map should work in normal, visual, selection, and insert 
    " mode.
    let g:tskelMapGoToNextTag = '<c-j>'  "{{{2
endif

if !exists("g:tskelMapHyperComplete") "{{{2
    if empty(maparg('<c-space>') . maparg('<c-space>', 'i'))
        " Key to invoke hyper completion (see |g:tskelHyperComplete|).
        let g:tskelMapHyperComplete = '<c-space>'  "{{{2
    else
        let g:tskelMapHyperComplete = ''
    endif
endif

if !exists("g:tskelHyperComplete") "{{{2
    " A dictionary of items that should be offered on "hyper complete".
    let g:tskelHyperComplete = {'use_completefunc': 1, 'scan_words': 1, 'scan_tags': 1}  "{{{2
endif

if !exists('g:tskelHyperType')
    " Either query or pum.
    " If you set the variable to "pum", you have to accept completions 
    " with <c-y>.
    " This variable must be set in your |vimrc| file before loading the 
    " tskeleton plugin.
    let g:tskelHyperType = 'query'   "{{{2
endif


" :nodoc:
" Create maps for the "go to next placeholder" functionality (see g:tskelMapGoToNextTag|).
function! TSkeletonMapGoToNextTag() "{{{3
    let map = type(g:tskelMapGoToNextTag) == 0 ? '<c-j>' : g:tskelMapGoToNextTag
    exec 'nnoremap <silent>' map ':call tskeleton#GoToNextTag()<cr>'
    exec 'vnoremap <silent>' map '<c-\><c-n>:call tskeleton#GoToNextTag()<cr>'
    exec 'inoremap <silent>' map '<c-\><c-o>:call tskeleton#GoToNextTag()<cr>'
endf
if !empty(g:tskelMapGoToNextTag)
    call TSkeletonMapGoToNextTag()
endif


" In the current buffer, map a:key so that
"   - If the cursor is located at the beginning of the line or if the 
"     the cursor is over a whitespace character, indent the current
"     line
"   - otherwise expand the bit under the cursor or (if not suitable bit
"     was found) use &omnifunc, &completefunc, tags, and (as fallback 
"     strategy) the words in the buffer as possible completions.
function! TSkeletonMapHyperComplete(key, ...) "{{{3
    let default = a:0 >= 1 ? a:1 : '=='
    if g:tskelHyperType == 'pum'
        exec 'inoremap '. a:key .' <C-R>=tskeleton#HyperComplete_'. g:tskelHyperType .'("i", '. string(default) .')<cr>'
    elseif g:tskelHyperType == 'query'
        exec 'inoremap '. a:key .' <c-\><c-o>:call tskeleton#HyperComplete_'. g:tskelHyperType .'("i", '. string(default) .')<cr>'
    else
        echoerr "tSkeleton: Unknown type for g:tskelHyperType: "+ g:tskelHyperType
    endif
    exec 'noremap '. a:key .' :call tskeleton#HyperComplete_query("n", '. string(default) .')<cr>'
endf
if !empty(g:tskelMapHyperComplete)
    call TSkeletonMapHyperComplete(g:tskelMapHyperComplete)
endif


" Fill in a file template.
command! -nargs=* -complete=custom,tskeleton#SelectTemplate TSkeletonSetup 
            \ call tskeleton#Setup(<f-args>)


" Edit a file template.
command! -nargs=? -complete=custom,tskeleton#SelectTemplate TSkeletonEdit 
            \ call tskeleton#Edit(<q-args>)


" Edit a bit.
command! -nargs=? -complete=customlist,tskeleton#EditBitCompletion TSkeletonEditBit 
            \ call tskeleton#EditBit(<q-args>)


" Create a new file template.
command! -nargs=* -complete=custom,tskeleton#SelectTemplate TSkeletonNewFile 
            \ call tskeleton#NewFile(<f-args>)


" Reset a buffer's bits. Use this command if the list of bits known in a 
" buffer is outdated.
command! -bar -nargs=? TSkeletonBitReset call tskeleton#ResetBits(<q-args>)


" Insert a bit/snippet.
command! -nargs=? -complete=custom,tskeleton#SelectBit TSkeletonBit
            \ call tskeleton#Bit(<q-args>)


" :nodoc:
" Remove lines containing placeholders from a bibtex entry.
command! TSkeletonCleanUpBibEntry call tskeleton#CleanUpBibEntry()

if !empty(g:tskelMapLeader)
    " noremap <unique> <Leader>tt ""diw:TSkeletonBit <c-r>"
    exec "noremap <unique> ". g:tskelMapLeader ."t :TSkeletonBit "
    
    exec "nnoremap <unique> ". g:tskelMapLeader ."# :call tskeleton#ExpandBitUnderCursor('n')<cr>"
    if g:tskelAddMapInsert
        exec "inoremap <unique> ". g:tskelMapInsert ." <c-\\><c-o>:call tskeleton#ExpandBitUnderCursor('i','', {'string':". string(g:tskelMapInsert) ."})<cr>"
    else
        exec "inoremap <unique> ". g:tskelMapInsert ." <c-\\><c-o>:call tskeleton#ExpandBitUnderCursor('i')<cr>"
    endif
    
    exec "vnoremap <unique> ". g:tskelMapLeader ."# d:call tskeleton#WithSelection('')<cr>"
    exec "vnoremap <unique> ". g:tskelMapLeader ."<space> d:call tskeleton#WithSelection(' ')<cr>"
    
    exec "nnoremap <unique> ". g:tskelMapLeader ."x :call tskeleton#LateExpand()<cr>"
    exec "vnoremap <unique> ". g:tskelMapLeader ."x <esc>`<:call tskeleton#LateExpand()<cr>"
endif


augroup tSkeleton
    autocmd!
    if !exists("g:tskelDontSetup") "{{{2
        function! s:DefineAutoCmd(template) "{{{3
            " TLogVAR a:template
            " let sfx = fnamemodify(a:template, ':e')
            let tpl = fnamemodify(a:template, ':t')
            " TLogVAR tpl
            let filetype = tlib#url#Decode(matchstr(tpl, '^\S\+'))
            let pattern  = matchstr(tpl, '^\S\+ \+\zs.*$')
            if !empty(filetype) && !empty(pattern)
                " TLogVAR pattern
                let pattern  = substitute(pattern, '#', '*', 'g')
                " TLogVAR pattern
                let pattern  = tlib#url#Decode(pattern)
                " TLogVAR pattern
                " TLogDBG 'autocmd BufNewFile '. escape(pattern, ' ') .' set ft='. escape(filetype, ' ') .' | TSkeletonSetup '. escape(a:template, ' ')
                exec 'autocmd BufNewFile '. escape(pattern, ' ') .' set ft='. escape(filetype, ' ') .' | TSkeletonSetup '. escape(a:template, ' ')
            endif
        endf

        call map(split(glob(tlib#file#Join([g:tskelDir, 'templates', '**'], 1)), '\n'), 'isdirectory(v:val) || s:DefineAutoCmd(v:val)')
        delfunction s:DefineAutoCmd

        for [s:pat, s:tpl] in [
                    \ ["*.bat",       "batch.bat"],
                    \ ["*.tex",       "latex.tex"],
                    \ ["tc-*.rb",     "tc-ruby.rb"],
                    \ ["*.rb",        "ruby.rb"],
                    \ ["*.rbx",       "ruby.rb"],
                    \ ["*.sh",        "shell.sh"],
                    \ ["*.txt",       "text.txt"],
                    \ ["*.vim",       "plugin.vim"],
                    \ ["*.inc.php",   "php.inc.php"],
                    \ ["*.class.php", "php.class.php"],
                    \ ["*.php",       "php.php"],
                    \ ["*.tpl",       "smarty.tpl"],
                    \ ["*.html",      "html.html"]
                    \ ]
            if filereadable(tlib#file#Join([g:tskelDir, s:tpl]))
                exec 'autocmd BufNewFile' s:pat 'TSkeletonSetup' s:tpl
            endif
        endfor

    endif

    exec 'autocmd BufNewFile,BufRead '. escape(g:tskelDir, ' ') .'* if g:tskeleton_SetFiletype | set ft=tskeleton | endif'
    autocmd FileType * call tskeleton#PrepareBits(&filetype)
    autocmd SessionLoadPost,BufEnter * if (g:tskelMenuPrefix != '' && g:tskelMenuCache != '' && !tskeleton#IsScratchBuffer()) | call tskeleton#BuildBufferMenu(1) | endif
    
    autocmd FileType bib if !hasmapto(":TSkeletonCleanUpBibEntry") | exec "noremap <buffer> ". g:tskelMapLeader ."c :TSkeletonCleanUpBibEntry<cr>" | endif
augroup END


" call tskeleton#PrepareBits('general')

