# Config for Powerlevel10k with lean prompt style. Doesn't require a Powerline font.
# The color scheme is suitable for dark terminal background.
#
# Once you've installed Powerlevel10k, run these commands to apply lean style.
#
#   curl -fsSL -O ~/p10k-lean.zsh https://raw.githubusercontent.com/romkatv/powerlevel10k/master/config/p10k-lean.zsh
#   echo 'source ~/p10k-lean.zsh' >>! ~/.zshrc
#
# To customize your prompt, open ~/p10k-lean.zsh in your favorite text editor, change it and
# restart ZSH. The file is well-documented.
#
# Tip: Looking for a nice color? Here's a one-liner to print colormap.
#
#   for i in {0..255}; do print -Pn "%${i}F${(l:3::0:)i}%f " ${${(M)$((i%8)):#7}:+$'\n'}; done

if [[ -o 'aliases' ]]; then
  # Temporarily disable aliases.
  'builtin' 'unsetopt' 'aliases'
  local p10k_lean_restore_aliases=1
else
  local p10k_lean_restore_aliases=0
fi

set_pl_colours_tc() {
  # Use hex colour codes if the terminal supports 24 bit
  # colour.
  typeset -g POWERLEVEL9K_DIR_FOREGROUND='#33859E'
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND='#599cab'

  # I don't really want different path colourings depending on context.
  typeset -g POWERLEVEL9K_DIR_{HOME,HOME_SUBFOLDER,DEFAULT,ETC}_FOREGROUND='#599cab'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS}_FOREGROUND='#d26937'
  typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND='#1e6479'

  # Truncate the username if it is longer than 10 characters.
  # Elipsis are displayed when this occurs.
  typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='[%10>...>%n%>>@%m]'

  typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#0a3749"
  
}

set_pl_colours_256() {

  #### Prompt
  # Green prompt symbol if the last command succeeded.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS}_FOREGROUND=76
  # Red prompt symbol if the last command failed.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS}_FOREGROUND=196

  ### Prompt dir segment
  # Default current directory color.
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=39
  # Color of the shortened directory segments.
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=92
  # Color of the anchor directory segments. Anchor segments are never shortened. The first
  # segment is always an anchor.
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=39

  # Context specific dir colour.
  typeset -g POWERLEVEL9K_DIR_{HOME,HOME_SUBFOLDER,DEFAULT,ETC}_FOREGROUND=39

  #### VCS segment
  # Show last vcs status in grey(244) if status is still being async loaded.
  typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND=244
  typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_COLOR=76
  # Non-git colours.
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=76
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=11
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=76
  
  #### Error status color.
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=9
  
  #### Execution time color.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=101

  #### Background jobs icon color.
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VISUAL_IDENTIFIER_COLOR=2

  #### Context
  # Default context color.
  typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND=127
  # Context color when running with privileges.
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=127

  #### Python virtual environment color.
  typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=244

  # Public IP color.
  typeset -g POWERLEVEL9K_PUBLIC_IP_FOREGROUND=144

  # Current time color.
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=66

  typeset -g POWERLEVEL9K_HISTORY_FOREGROUND=244

  typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=235
}


() {
  emulate -L zsh
  setopt no_unset

  # The list of segments shown on the left. Fill it with the most important segments.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
      # =========================[ Line #1 ]=========================
      context
      dir                     # current directory
      vcs                     # git status
      # =========================[ Line #2 ]=========================
      newline
      virtualenv
      prompt_char             # prompt symbol
  )

  #typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

  # Basic style options that define the overall look of your prompt.
  typeset -g POWERLEVEL9K_BACKGROUND=                            # transparent background
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=  # no surrounding whitespace
  typeset -g POWERLEVEL9K_RPROMPT_ON_NEWLINE=false               # align the first left/right lines
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '  # separate segments with a space
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=        # no end-of-line symbol

  # Disable segment icons by default.
  # Note: Many default icons cannot be displayed with system fonts. You'll need to install a
  # Powerline font to use them. See POWERLEVEL9K_MODE below.
  typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION=

  # Add an empty line before each prompt. If you set it to false, you might want to
  # set POWERLEVEL9K_SHOW_RULER=true or POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR='·' below.
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

  # Ruler, a.k.a. the horizontal line before each prompt. If you set it to true, you'll
  # probably want to set POWERLEVEL9K_PROMPT_ADD_NEWLINE=false above and
  # POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR=' ' below.
  typeset -g POWERLEVEL9K_SHOW_RULER=false

  # Filler between left and right prompt on the first prompt line. You can set it to '·' or '─'
  # to make it easier to see the alignment between left and right prompt and to separate prompt
  # from command output. It serves the same purpose as ruler (see above) without increasing
  # the number of prompt lines. You'll probably want to set POWERLEVEL9K_SHOW_RULER=false
  # if using this. You might also like POWERLEVEL9K_PROMPT_ADD_NEWLINE=false for more compact
  # prompt.
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR=' '

  # Default prompt symbol.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
  # Prompt symbol in command vi mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
  # Prompt symbol in visual vi mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='Ⅴ'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''

  # Enable special styling for non-writable directories.
  typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=true
  # If directory is too long, shorten some of its segments to the shortest possible unique
  # prefix. The shortened directory can be tab-completed to the original.
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  # Replace removed segment suffixes with this symbol.
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=
  # Display anchor directory segments in bold.
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
  # Don't shorten directories that contain files matching this pattern. They are anchors.
  typeset -g POWERLEVEL9K_SHORTEN_FOLDER_MARKER='(.shorten_folder_marker|.bzr|CVS|.git|.hg|.svn|.terraform|.citc)'
  # Don't shorten this many last directory segments. They are anchors.
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
  # Shorten directory if it's longer than this even if there is space for it. The value can
  # be either absolute (e.g., '80') or a percentage of terminal width (e.g, '50%'). If empty,
  # directory will be shortened only when prompt doesn't fit.
  typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=80
  # If set to true, embed a hyperlink into the directory. Useful for quickly
  # opening a directory in the file manager simply by clicking the link.
  # Can also be handy when the directory is shortened, as it allows you to see
  # the full directory that was used in previous commands.
  typeset -g POWERLEVEL9K_DIR_HYPERLINK=false
  #typeset -g POWERLEVEL9K_DIR_PATH_SEPARATOR_FOREGROUND=12
  typeset -g POWERLEVEL9K_DIR_BOLD=true



  # Git status: feature:master#tag ⇣42⇡42 *42 merge ~42 +42 !42 ?42.
  # We are using parameters defined by the gitstatus plugin. See reference:
  # https://github.com/romkatv/gitstatus/blob/master/gitstatus.plugin.zsh.
  local vcs=''
  # 'feature' or '@72f5c8a' if not on a branch.
  vcs+='%76F${${VCS_STATUS_LOCAL_BRANCH//\%/%%}:-%f@%76F${VCS_STATUS_COMMIT[1,8]}}'
  # ':master' if the tracking branch name differs from local branch.
  vcs+='${${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH}:+%f:%76F${VCS_STATUS_REMOTE_BRANCH//\%/%%}}'
  # '#tag' if on a tag.
  vcs+='${VCS_STATUS_TAG:+%f#%76F${VCS_STATUS_TAG//\%/%%}}'
  # ⇣42 if behind the remote.
  vcs+='${${VCS_STATUS_COMMITS_BEHIND:#0}:+ %76F⇣${VCS_STATUS_COMMITS_BEHIND}}'
  # ⇡42 if ahead of the remote; no leading space if also behind the remote: ⇣42⇡42.
  # If you want '⇣42 ⇡42' instead, replace '${${(M)VCS_STATUS_COMMITS_BEHIND:#0}:+ }' with ' '.
  vcs+='${${VCS_STATUS_COMMITS_AHEAD:#0}:+${${(M)VCS_STATUS_COMMITS_BEHIND:#0}:+ }%76F⇡${VCS_STATUS_COMMITS_AHEAD}}'
  # *42 if have stashes.
  vcs+='${${VCS_STATUS_STASHES:#0}:+ %76F*${VCS_STATUS_STASHES}}'
  # 'merge' if the repo is in an unusual state.
  vcs+='${VCS_STATUS_ACTION:+ %196F${VCS_STATUS_ACTION//\%/%%}}'
  # ~42 if have merge conflicts.
  vcs+='${${VCS_STATUS_NUM_CONFLICTED:#0}:+ %196F~${VCS_STATUS_NUM_CONFLICTED}}'
  # +42 if have staged changes.
  vcs+='${${VCS_STATUS_NUM_STAGED:#0}:+ %11F+${VCS_STATUS_NUM_STAGED}}'
  # !42 if have unstaged changes.
  vcs+='${${VCS_STATUS_NUM_UNSTAGED:#0}:+ %11F!${VCS_STATUS_NUM_UNSTAGED}}'
  # ?42 if have untracked files.
  vcs+='${${VCS_STATUS_NUM_UNTRACKED:#0}:+ %12F?${VCS_STATUS_NUM_UNTRACKED}}'
  # If P9K_CONTENT is not empty, leave it unchanged. It's either "loading" or from vcs_info.
  vcs="\${P9K_CONTENT:-$vcs}"

  # Disable the default Git status formatting.
  typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
  # Install our own Git status formatter.
  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_CONTENT_EXPANSION=$vcs
  # When Git status is being refreshed asynchronously,
  # display the last known repo status in grey.
  typeset -g POWERLEVEL9K_VCS_LOADING_CONTENT_EXPANSION=${${vcs//\%f}//\%<->F}
  # Enable counters for staged, unstaged, etc.
  typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1

  # Show status of repositories of these types. You can add svn and/or hg if you are
  # using them. If you do, your prompt may become slow even when your current directory
  # isn't in an svn or hg reposotiry.
  typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)

  # These settings are used for respositories other than Git or when gitstatusd fails and
  # Powerlevel10k has to fall back to using vcs_info.
  typeset -g POWERLEVEL9K_VCS_REMOTE_BRANCH_ICON=':'
  typeset -g POWERLEVEL9K_VCS_COMMIT_ICON='@'
  typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='⇣'
  typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='⇡'
  typeset -g POWERLEVEL9K_VCS_STASH_ICON='*'
  typeset -g POWERLEVEL9K_VCS_TAG_ICON=$'%{\b#%}'
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON=$'%{\b?%}'
  typeset -g POWERLEVEL9K_VCS_UNSTAGED_ICON=$'%{\b!%}'
  typeset -g POWERLEVEL9K_VCS_STAGED_ICON=$'%{\b+%}'
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=

  # Don't show status on success.
  typeset -g POWERLEVEL9K_STATUS_OK=false
  # Don't show status unless the last command was terminated by a signal.
  # Show signals as "INT", "ABORT", "KILL", etc.
  typeset -g POWERLEVEL9K_STATUS_ERROR_CONTENT_EXPANSION='${${P9K_CONTENT#SIG}//[!A-Z]}'

  # Show duration of the last command if takes longer than this many seconds.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
  # Show this many fractional digits. Zero means round to seconds.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
  # Duration format: 1d 2h 3m 4s.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'

  # Don't show the number of background jobs.
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false
  # Icon to show when there are background jobs.
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VISUAL_IDENTIFIER_EXPANSION='⇶'

  # Context format: user@host.
  typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'
  # Don't show context unless running with privileges on in SSH.
  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION=
  typeset -g POWERLEVEL9K_ALWAYS_SHOW_CONTEXT=true

  # Show Python version next to the virtual environment name.
  typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=true
  # Separate environment name from Python version only with a space.
  typeset -g POWERLEVEL9K_VIRTUALENV_{LEFT,RIGHT}_DELIMITER=
  typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false
  typeset -g POWERLEVEL9K_VIRTUALENV_LEFT_DELIMITER='('
  typeset -g POWERLEVEL9K_VIRTUALENV_RIGHT_DELIMITER=')'  

  # Format for the current time: 09:51:02. See `man 3 strftime`.
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
  # If set to true, time will update when you hit enter. This way prompts for the past
  # commands will contain the start times of their commands as opposed to the default
  # behavior where they contain the end times of their preceding commands.
  typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false

  # Set up xterm-256color compatible colours first.
  set_pl_colours_256

  if [[ ${ZSH_VERSION%.*} -ge 5.7 ]]
  then
    # ZSH supports both truecolour, and nearest colour emulation
    # starting at version 5.7. If ZSH meets that version requirement,
    # use that.
    
    if [ ! -v COLORTERM ]
    then
        typeset -g COLORTERM=
    fi

    [[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor
    set_pl_colours_tc
  
  fi
}

(( ! p10k_lean_restore_aliases )) || setopt aliases
'builtin' 'unset' 'p10k_lean_restore_aliases'
