" ~/.vim/pack/my-plugins/start/my-notify-plugin/my-notify-plugin.vim

luafile ~/.vim/plugged/reminder-vim/lua/reminder.lua

" Function to create reminders
function! s:create_reminder_info(duration, content, title = 'Reminder', level = 'info')
  let lua_code = printf('create_reminder_info("%d","%s", "%s")',
              \ a:duration, a:content, a:title)
  call luaeval(lua_code)
endfunction

function s:timer_callback(interval, duration, content, name)
  call s:create_reminder_info(a:duration, a:content, a:name)
  call timer_start(a:interval, {-> s:timer_callback(a:interval, a:duration, a:content, a:name)})
endfunction

" " 定义字典来存储配置
let g:configurations = {}

" 添加配置项
let g:configurations[1] = {'name': '喝水', 'type': 'interval', 'interval': 30, 'duration': 10, 'content': '喝水'}
let g:configurations[1] = {'name': '买票', 'type': 'interval', 'interval': 30, 'duration': 10, 'content': '买火车票'}
let g:configurations[2] = {'name': '打卡', 'type': 'alarm', 'hour': 09, 'min': 30, 'duration': 60, 'content': '上班打卡'}
let g:configurations[3] = {'name': '打卡', 'type': 'alarm', 'hour': 18, 'min': 30, 'duration': 60, 'content': '下班打卡'}

for key in keys(g:configurations)
    let config = g:configurations[key]
    let s:name = config.name
    let s:type = config.type

    if s:type == 'interval'
        let s:content = "每" . config.interval . "分钟提醒：" . s:name
        let s:interval = config.interval * 1000 * 60
        let s:duration = config.duration * 1000
        call s:create_reminder_info(5000, "加载" . s:content, s:name)
        call timer_start(s:interval, {-> s:timer_callback(s:interval, s:duration, s:content, s:name)})
    elseif s:type == 'alarm'
        let s:content = config.content
        let s:hour = config.hour
        let s:min = config.min
        let s:now = localtime()
        let s:now_sec = strftime("%H", s:now) * 3600 + strftime("%M", s:now) * 60 + strftime("%S", s:now)
        let s:alarm_sec = s:hour * 3600 + s:min * 60
        if s:now_sec > s:alarm_sec
          let s:interval = (24 * 3600 - s:now_sec + s:alarm_sec)
          let s:temp_content = "明日提醒：" . s:content. "剩余(" . s:interval / 3600 . "小时" . (s:interval / 60 % 60) . "分钟" . (s:interval % 60) . "秒) "
          call s:create_reminder_info(5000, s:temp_content, s:name)
        else
          let s:interval = (s:alarm_sec - s:now_sec)
          let s:temp_content = "今日提醒：" . s:content. "剩余(" . s:interval / 3600 . "小时" . (s:interval / 60 % 60) . "分钟" . (s:interval % 60) . "秒) "
          call s:create_reminder_info(5000, s:temp_content, s:name)
        endif
        let s:interval = s:interval * 1000
        let s:duration = config.duration * 1000
        call timer_start(s:interval, {-> s:timer_callback(s:interval, s:duration * 1000, s:content, s:name)})
    endif
endfor
