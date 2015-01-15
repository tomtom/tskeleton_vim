" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Revision:    19


function! tskeleton#mini#Initialize() "{{{3
endf


function! tskeleton#mini#FiletypeBits(dict, type) "{{{3
    " TLogVAR a:dict, a:type
    let files = findfile('.tskelmini', expand('%:p:h') .';', -1)
    " TLogVAR files
    for file in reverse(files)
        " TLogVAR file
        call tskeleton#FetchMiniBits(a:dict, '', file, 1)
    endfor
endf


