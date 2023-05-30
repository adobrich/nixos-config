{home, ...}: let
  inherit (home.sessionVariables) BROWSER EDITOR TERMINAL;
in ''
  $mainMod = SUPER
  general {
    gaps_in = 3
    gaps_out = 5
    border_size = 3
    col.active_border = rgb(ffc0cb)
    col.inactive_border = rgba(595959aa)
    cursor_inactive_timeout = 4
  }

  decoration {
    multisample_edges = true
    active_opacity = 1.0
    inactive_opacity = 0.9
    fullscreen_opacity = 1.0
    rounding = 0
    blur = no
    blur_size = 3
    blur_passes = 1
    blur_new_optimizations = true
    drop_shadow = false
    # shadow_range = 4
    # shadow_offset =3 3
    # col.shadow = rgba()
    # col.shadow_inactive =rgba()
  }

  dwindle {
    no_gaps_when_only = false
    force_split = 0
    special_scale_factor = 0.8
    split_width_multiplier = 1.0
    use_active_for_splits = true
    pseudotile = yes
    preserve_split = yes
  }

  master {
    no_gaps_when_only = false
    new_is_master = true
    special_scale_factor = 0.8
  }

  animations {
    enabled = true
    bezier = overshot, 0.13, 0.99, 0.29, 1.1
    animation = windows, 1, 4, overshot, slide
    animation = windowsOut, 1, 5, default, popin 80%
    animation = border, 1, 5, default
    animation = fade, 1, 8, default
    animation = workspaces, 1, 6, overshot, slidevert
  }

  input {
    kb_layout=us
    touchpad {
      disable_while_typing = true
    }
  }

  misc {
    disable_hyprland_logo = true
    always_follow_on_dnd = true
    layers_hog_keyboard_focus = true
    animate_manual_resizes = false
    enable_swallow = true
    focus_on_activate = true
  }

  # Startup
  # exec-once=waybar
  # exec=swaybg -i ~/wallpaper/current.jpg --mode fill
  # exec-once=mako
  # exec-once=swayidle -w

  # Fn bindings
  bind=,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
  bind=,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
  bind=,XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
  bind=,XF86MonBrightnessUp,exec,brightnessctl s 5%+
  bind=,XF86MonBrightnessDown,exec,brightnessctl s 5%-
  bind=,XF86PowerOff,exec,bash ~/dev/scripts/power_menu.sh

  # Program bindings
  bind=$mainMod,Return,exec,${TERMINAL}
  bind=$mainMod,b,exec,${BROWSER}
  # bind=$mainMod,w,exec,makoctl dismiss
  bind=$mainMod_SHIFT,h,exec,${TERMINAL} $SHELL -ic ${EDITOR}

  bind=$mainMod,x,exec,wofi -S drun -x 10 -y 10 -W 25% -H 60%
  bind=$mainMod,d,exec,wofi -S run

  # Window Controls
  bind=$mainMod_SHIFT,q,killactive
  bind=$mainMod_SHIFT,e,exit
  # TODO: pin doesn't seem to work. Look into it
  bind=$mainMod_SHIFT,y,pin

  bind=$mainMod,s,togglesplit
  bind=$mainMod,f,fullscreen,1
  bind=$mainMod_SHIFT,f,fullscreen,0
  bind=$mainMod_SHIFT,space,togglefloating

  bind=$mainMod,h,movefocus,l
  bind=$mainMod,l,movefocus,r
  bind=$mainMod,k,movefocus,u
  bind=$mainMod,j,movefocus,d

  bind=$mainMod_SHIFT,h,movewindow,l
  bind=$mainMod_SHIFT,l,movewindow,r
  bind=$mainMod_SHIFT,k,movewindow,u
  bind=$mainMod_SHIFT,j,movewindow,d

  bind=$mainMod,1,workspace,01
  bind=$mainMod,2,workspace,02
  bind=$mainMod,3,workspace,03
  bind=$mainMod,4,workspace,04

  bind=$mainMod_SHIFT,1,movetoworkspacesilent,01
  bind=$mainMod_SHIFT,2,movetoworkspacesilent,02
  bind=$mainMod_SHIFT,3,movetoworkspacesilent,03
  bind=$mainMod_SHIFT,4,movetoworkspacesilent,04
''
