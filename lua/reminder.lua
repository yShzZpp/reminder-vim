-- ~/.vim/plugged/reminder-vim/lua/reminder.lua

vim.notify = require("notify")
vim.notify.setup({
  stages = "fade_in_slide_out",
  timeout = 5000,

  background_colour = "Normal",

  icons = {
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "✎",
  },
})

-- Function to create reminders
function create_reminder_info(duration, content, title)
    level = 'info'
    title = title or 'Reminder'
    
    vim.notify(content, level, {
        title = title,
        timeout = duration,
        stages = "slide",
        background_colour = "Normal",
        icon = ""
    })
end

-- Function to create reminders
function create_reminder_warn(duration, content, title)
    level = 'warn'
    title = title or 'Reminder'
    
    vim.notify(content, level, {
        title = title,
        timeout = duration,
    })
end

-- Function to create reminders
function create_reminder_error(duration, content, title)
    level = 'error'
    title = title or 'Reminder'
    
    vim.notify(content, level, {
        title = title,
        timeout = duration,
    })
end

