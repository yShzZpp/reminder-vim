" 设置超时时间，默认为5秒
let g:my_custom_timeout = 5000

" 提示文本
let g:my_custom_prompt = 'Hello, this is a custom prompt!'

" 定义函数显示提示文本
function! s:ShowPrompt()
    echohl WarningMsg
    echo g:my_custom_prompt
    echohl None
endfunction

" 定义函数启动超时计时器
function! s:StartTimeout()
    let s:timer = timer_start(g:my_custom_timeout, {-> s:ShowPrompt()}, {'repeat': -1})
endfunction

" 启动超时计时器
call s:StartTimeout()

