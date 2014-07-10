-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" }, properties = { floating = true } },
    { rule = { class = "pinentry" }, properties = { floating = true } },
    { rule = { class = "gimp" }, properties = { floating = true } },
    { rule = { class = "Firefox" }, properties = { tag = tags[1][2] } },
    { rule = { class = "Clementine" }, properties = { tag = tags[1][7] } },
    { rule = { class = "Skype" }, properties = { tag = tags[1][5] } }
}
-- }}}

