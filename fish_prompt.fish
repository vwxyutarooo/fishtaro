function fish_prompt --description 'Write out the prompt'
  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
  end
  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  switch $USER

    case root
      if not set -q __fish_prompt_cwd
        if set -q fish_color_cwd_root
          set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
        else
          set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end
      end
      set prompt_symbol '#'

    case '*'
      if not set -q __fish_prompt_cwd
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
      end
      set prompt_symbol '$'

  end

  if [ "$HOME" = (pwd) ]
    set pwd '~'
  else
    set pwd (basename (pwd))
  end

  printf "%s@%s %s%s%s%s " $USER (hostname -s) (set_color $fish_color_cwd) $pwd (set_color normal) $prompt_symbol

end
