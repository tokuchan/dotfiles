;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers '(yaml
                                       html
                                       nginx
                                       systemd
                                       typescript
                                       javascript
                                       ;; ----------------------------------------------------------------
                                       ;; Example of useful layers you may want to use right away.
                                       ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
                                       ;; `M-m f e R' (Emacs style) to install them.
                                       ;; ----------------------------------------------------------------
                                       rust
                                       (auto-completion :variables
                                                        ;;auto-completion-return-key-behavior nil
                                                        auto-completion-tab-key-behavior 'cycle
                                                        auto-completion-complete-with-key-sequence "jk"
                                                        auto-completion-complete-with-key-sequence-delay 0.1)
                                       better-defaults
                                       csv
                                       shell-scripts
                                       asciidoc
                                       emacs-lisp
                                       git
                                       helm
                                       (lsp :variables
                                            lsp-lens-enable nil
                                            lsp-headerline-breadcrumb-enable t
                                            lsp-headerline-breadcrumb-segments '(project file symbols)
                                            lsp-use-plists nil
                                            lsp-log-io nil
                                            lsp-file-watch-threshold 5000
                                            lsp-enable-file-watchers nil
                                            lsp-modeline-code-actions-segments '(count icon)
                                            lsp-ui-doc-enable nil
                                            lsp-use-lsp-ui nil
                                            lsp-clients-clangd-args '("--all-scopes-completion=false")
                                            )
                                       ;; markdown
                                       multiple-cursors
                                       ;;(org :variables
                                       ;;     ;; Bullets from Mayan numbers
                                       ;;     ;;org-superstar-headline-bullets-list '("𝋡","𝋢","𝋣","𝋤")
                                       ;;     ;; Bullets from Kaktovik Inuit numbers
                                       ;;     ;;org-superstar-headline-bullets-list '("𝋁","𝋂","𝋃","𝋄")
                                       ;;     org-projectile-file "~/org/TODOS.org"
                                       ;;     org-agenda-files (list "~/org/work.org"
                                       ;;                            "~/org/personal.org")
                                       ;;     org-log-done t
                                       ;;     org-enable-github-support t
                                       ;;     org-enable-reveal-js-support t
                                       ;;     org-reveal-js "~/.config/reveal/reveal.js"
                                       ;;     org-todo-keywords '((sequence "TODO" "WAIT" "DOING" "|" "DONE" "WONTDO"))
                                       ;;     )
                                       (shell :variables
                                              shell-default-height 30
                                              shell-default-position 'bottom)
                                       spell-checking
                                       syntax-checking
                                       (version-control :variables
                                                        version-control-diff-side 'left)
                                       semantic
                                        ;treemacs

                                       ;; Additional layers for programming languages
                                       (c-c++ :variables
                                              c-c++-backend 'lsp-clangd
                                        ;c-c++-adopt-subprojects t
                                              c-c++-enable-clang-support t
                                              c-c++-lsp-enable-semantic-highlighting 'rainbow
                                              c-c++-default-mode-for-headers 'c++-mode)

                                       (python :variables
                                               python-backend 'lsp
                                               python-lsp-server 'pyright)

                                       (docker :variables
                                               docker-dockerfile-backend 'lsp)

                                       ;; Customize themes a little
                                       ;;(theming :variables
                                       ;; theming-modifications
                                       ;; '((spacemacs-dark (hl-line :background "000"))
                                       ;;   (spacemacs-light (hl-line :background "ccc"))))

                                       cmake
                                       (llm-client :variables
                                                   llm-client-enable-gptel t
                                                   llm-client-enable-ellama t))


   ;; List of additional packages that will be installed without being wrapped
   ;; in a layer (generally the packages are installed only and should still be
   ;; loaded using load/require/use-package in the user-config section below in
   ;; this file). If you need some configuration for these packages, then
   ;; consider creating a layer. You can also put the configuration in
   ;; `dotspacemacs/user-config'. To use a local version of a package, use the
   ;; `:location' property: '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.

   dotspacemacs-additional-packages '(nov fira-code-mode gerrit shell-pop org-pivotal sqlite3 exec-path-from-shell ligature bitbake-mode bitbake-ts-mode linguistic)

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need to
   ;; compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;;
   ;; WARNING: pdumper does not work with Native Compilation, so it's disabled
   ;; regardless of the following setting when native compilation is in effect.
   ;;
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Name of executable file pointing to emacs 27+. This executable must be
   ;; in your PATH.
   ;; (default "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=$HOME/.emacs.d/.cache/dumps/spacemacs-27.1.pdmp
   ;; (default (format "spacemacs-%s.pdmp" emacs-version))
   dotspacemacs-emacs-dumper-dump-file (format "spacemacs-%s.pdmp" emacs-version)

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; Set `read-process-output-max' when startup finishes.
   ;; This defines how much data is read from a foreign process.
   ;; Setting this >= 1 MB should increase performance for lsp servers
   ;; in emacs 27.
   ;; (default (* 1024 1024))
   dotspacemacs-read-process-output-max (* 1024 1024)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. Spacelpa is currently in
   ;; experimental state please use only for testing purposes.
   ;; (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version t

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; Scale factor controls the scaling (size) of the startup banner. Default
   ;; value is `auto' for scaling the logo automatically to fit all buffer
   ;; contents, to a maximum of the full image height and a minimum of 3 line
   ;; heights. If set to a number (int or float) it is used as a constant
   ;; scaling factor for the default logo size.
   dotspacemacs-startup-banner-scale 'auto

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `recents-by-project' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   ;; The exceptional case is `recents-by-project', where list-type must be a
   ;; pair of numbers, e.g. `(recents-by-project . (7 .  5))', where the first
   ;; number is the project limit and the second the limit on the recent files
   ;; within a project.
   dotspacemacs-startup-lists '((recents-by-project . (7 . 5))
                                (projects . 7)
                                (bookmarks . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Show numbers before the startup list lines. (default t)
   dotspacemacs-show-startup-list-numbers t

   ;; The minimum delay in seconds between number key presses. (default 0.4)
   dotspacemacs-startup-buffer-multi-digit-delay 0.4

   ;; If non-nil, show file icons for entries and headings on Spacemacs home buffer.
   ;; This has no effect in terminal or if "all-the-icons" package or the font
   ;; is not installed. (default nil)
   dotspacemacs-startup-buffer-show-icons nil

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; If non-nil, *scratch* buffer will be persistent. Things you write down in
   ;; *scratch* buffer will be saved and restored automatically.
   dotspacemacs-scratch-buffer-persistent t

   ;; If non-nil, `kill-buffer' on *scratch* buffer
   ;; will bury it instead of killing.
   dotspacemacs-scratch-buffer-unkillable t

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font or prioritized list of fonts. The `:size' can be specified as
   ;; a non-negative integer (pixel size), or a floating-point (point size).
   ;; Point size is recommended, because it's device independent. (default 10.0)
   dotspacemacs-default-font '("Fira Code"
                               :size 12.0
                               :weight normal
                               :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ";"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m" for terminal mode, "<M-return>" for GUI mode).
   ;; Thus M-RET should work as leader key in both GUI and terminal modes.
   ;; C-M-m also should work in terminal mode, but not in GUI mode.
   dotspacemacs-major-mode-emacs-leader-key (if window-system "<M-return>" "C-M-m")

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose t

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default t) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' in OSX to obtain
   ;; borderless fullscreen. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes the
   ;; transparency level of a frame background when it's active or selected. Transparency
   ;; can be toggled through `toggle-background-transparency'. (default 90)
   dotspacemacs-background-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Show the scroll bar while scrolling. The auto hide time can be configured
   ;; by setting this variable to a number. (default t)
   dotspacemacs-scroll-bar-while-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but only visual lines are counted. For example, folded lines will not be
   ;; counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers 'visual

   ;; Code folding method. Possible values are `evil', `origami' and `vimish'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'origami

   ;; If non-nil and `dotspacemacs-activate-smartparens-mode' is also non-nil,
   ;; `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil smartparens-mode will be enabled in programming modes.
   ;; (default t)
   dotspacemacs-activate-smartparens-mode t

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; If nil then Spacemacs uses default `frame-title-format' to avoid
   ;; performance issues, instead of calculating the frame title by
   ;; `spacemacs/title-prepare' all the time.
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "/%S/%t/%f/%b/%m/(%p,%P)"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Color highlight trailing whitespace in all prog-mode and text-mode derived
   ;; modes such as c++-mode, python-mode, emacs-lisp, html-mode, rst-mode etc.
   ;; (default t)
   dotspacemacs-show-trailing-whitespace t

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'changed

   ;; If non-nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfere with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode t

   ;; Accept SPC as y for prompts if non-nil. (default nil)
   dotspacemacs-use-SPC-as-y t

   ;; If non-nil shift your number row to match the entered keyboard layout
   ;; (only in insert state). Currently supported keyboard layouts are:
   ;; `qwerty-us', `qwertz-de' and `querty-ca-fr'.
   ;; New layouts can be added in `spacemacs-editing' layer.
   ;; (default nil)
   dotspacemacs-swap-number-row nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil

   ;; If nil the home buffer shows the full path of agenda items
   ;; and todos. If non-nil only the file name is shown.
   dotspacemacs-home-shorten-agenda-source nil

   ;; If non-nil then byte-compile some of Spacemacs files.
   dotspacemacs-byte-compile t))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env)

  ;; Set TZ properly
  (setenv "TZ" "America/New_York")
  )

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  ;; Follow symlinks to VC-controlled files without asking.
  (setq vc-follow-symlinks t)

  ;; Completely disable semantic so that it stops hanging emacs
  ;; 1) Neutralize the commands so nobody can turn it on
  (fset 'semantic-mode              #'ignore)
  (fset 'global-semantic-idle-scheduler-mode #'ignore)
  (fset 'semantic-idle-scheduler-mode        #'ignore)
  (fset 'global-semantic-idle-summary-mode   #'ignore)
  (fset 'global-semantic-idle-completions-mode #'ignore)
  (fset 'global-semantic-idle-local-symbol-highlight-mode #'ignore)

  ;; 2) Prevent any submode from being auto-enabled if something slips through
  (setq semantic-default-submodes nil)

  ;; 3) Just in case something manually calls semantic-mode
  (setq semantic-init-functions nil)
  )


(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )


(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."
  (setq read-process-output-max (* 1024 1024))
  (setq compilation-skip-threshold 2)

  ;; Toggle CamelCase motion on globally.
  (spacemacs/toggle-camel-case-motion-globally-on)

  ;; Mark off custom binding space
  (spacemacs/declare-prefix "o" "personal")

  ;; Define org agenda shortcut
  (spacemacs/set-leader-keys "oa" 'org-agenda)

  ;; Define handy function to generate path::line for point under cursor.
  (defun show-location ()
    "Show the full path to the current point, including line number."
    (interactive)
    (message (concat (buffer-file-name) (format-mode-line "::%l")))
    (kill-new (file-truename (concat "file:" (buffer-file-name) (format-mode-line "::%l")))))

  (spacemacs/set-leader-keys "ol" 'show-location)

  (defun make-org-reference ()
    "Generate an orgmode file reference to the pointed location."
    (interactive)
    (message (concat (buffer-file-name) (format-mode-line "::%l")))
    (kill-new (concat "[[file:"
                      (buffer-file-name)
                      (format-mode-line "::%l][")
                      (file-name-nondirectory (buffer-file-name))
                      (format-mode-line "::%l]]"))))

  (spacemacs/set-leader-keys "or" 'make-org-reference)

  ;; Define handy function to insert Gerrit-style Change-Id trailers at the cursor
  (defun insert-change-id ()
    "Insert a Gerrit-style Change-Id at the cursor."
    (interactive)
    (insert (concat "Change-Id: I" (substring (secure-hash 'sha256 (number-to-string (random t))) 0 40))))

  (spacemacs/set-leader-keys "oc" 'insert-change-id)

  ;; Code to produce a word-frequency count table for the current buffer.
  (require 'cl-lib)

  (defvar punctuation-marks '(","
                              "."
                              "'"
                              "&"
                              "\"")
    "List of Punctuation Marks that you want to count.")

  (defun count-raw-word-list (raw-word-list)
    (cl-loop with result = nil
             for elt in raw-word-list
             do (cl-incf (cdr (or (assoc elt result)
                                  (first (push (cons elt 0) result)))))
             finally return (sort result
                                  (lambda (a b) (string< (car a) (car b))))))

  (defun word-stats ()
    (interactive)
    (let* ((words (split-string
                   (downcase (buffer-string))
                   (format "[ %s\f\t\n\r\v]+"
                           (mapconcat #'identity punctuation-marks ""))
                   t))
           (punctuation-marks (cl-remove-if-not
                               (lambda (elt) (member elt punctuation-marks))
                               (split-string (buffer-string) "" t )))
           (raw-word-list (append punctuation-marks words))
           (word-list (count-raw-word-list raw-word-list)))
      (with-current-buffer (get-buffer-create "*word-statistics*")
        (erase-buffer)
        (insert "| word | occurrences |
               |-----------+-------------|\n")

        (dolist (elt word-list)
          (insert (format "| '%s' | %d |\n" (car elt) (cdr elt))))

        (org-mode)
        (indent-region (point-min) (point-max))
        (goto-char 100)
        (org-cycle)
        (goto-char 79)
        (org-table-sort-lines nil ?N)))
    (pop-to-buffer "*word-statistics*"))

  (spacemacs/set-leader-keys "of" 'word-stats)

  ;; Define a line-up function for hanging template arguments
  (defun c++-template-args-cont (langelem)
    "Control indentation of template parameters handling the special case of '>'.
Possible Values:
0   : The first non-ws character is '>'. Line it up under 'template'.
nil : Otherwise, return nil and run next lineup function."
    (save-excursion
      (beginning-of-line)
      (if (re-search-forward "^[\t ]*>" (line-end-position) t)
          0)))

  ;; Force function parameters to indent like normal code, and not align with ().
  (defun my-c-arglist-indent ()
    (c-set-offset 'arglist-intro '+)
    (c-set-offset 'arglist-close 0))
  (add-hook 'c-mode-common-hook 'my-c-arglist-indent)

  ;; Define a line-up function for braced blocks under braceless ones
  ;;  (defun c++-braced-under-braceless-block (langelem)
  ;;    "Control indentation of braced blocks that sit under braceless ones. For example:
  ;;
  ;;  if ( condition ) try
  ;;  {
  ;;    // Do something
  ;;  }
  ;;
  ;;would be correct indentation.
  ;;
  ;;Possible Values:
  ;;0   : The first non-ws character is '{'. Line it up under
  ;;nil :
  ;;"
  ;;    )

  ;; Define a custom C++ mode hook, so I can fix indentation and a few other things.
  (defun my-c++-mode-hook ()
    (c-set-offset 'template-args-cont '0)
    (c-set-offset 'statement-cont '0)
    (c-set-offset 'substatement-open '0)
    (c-set-offset 'template-args-cont '(c++-template-args-cont c-lineup-template-args +))
    (c-set-offset 'func-decl-cont '0))
  (add-hook 'c++-mode-hook 'my-c++-mode-hook)

  ;; Add refactoring support to c++ mode
  (require 'srefactor)
  (require 'srefactor-lisp)

  ;; OPTIONAL: ADD IT ONLY IF YOU USE C/C++.
  (semantic-mode 1) ;; -> this is optional for Lisp

  ;;(define-key c-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
  ;;(define-key c++-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
  ;;(global-set-key (kbd "M-RET o") 'srefactor-lisp-one-line)
  ;;(global-set-key (kbd "M-RET m") 'srefactor-lisp-format-sexp)
  ;;(global-set-key (kbd "M-RET d") 'srefactor-lisp-format-defun)
  ;;(global-set-key (kbd "M-RET b") 'srefactor-lisp-format-buffer)

  ;; Kill clang-format with fire
  (require 'clang-format)
  (setq clang-format "none")

  ;; nov ePub reader settings
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  (setq nov-text-width 80)

  ;; ORG configuration and custom code
  ;;(with-eval-after-load 'org-agenda
  ;;  (require 'org-projectile)
  ;;  (push (org-projectile:todo-files) org-agenda-files))

  ;; Define a quoted-character function for sending things to term.
  (defun term-send-quote ()
    "Quote the next character in term mode."
    (interactive)
    (term-send-raw-string "\C-v"))

  ;; This EMACS has built-in ligatures support
  (use-package ligature
    :config
    ;; Enable the "www" ligature in every possible major mode
    (ligature-set-ligatures 't '("www"))
    ;; Enable traditional ligature support in eww-mode, if the
    ;; `variable-pitch' face supports it
    (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
    ;; Enable all Cascadia Code ligatures in programming modes
    (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                         ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                         "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                         "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                         "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                         "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                         "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                         "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                         ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                         "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                         "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                         "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                         "\\\\" "://"))
    ;; Enables ligature checks globally in all buffers. You can also do it
    ;; per mode with `ligature-mode'.
    (global-ligature-mode t))

  ;;;; Set up Fira ligatures
  ;;;; Don't forget to install the font: M-x fira-code-mode-install-fonts
  ;;(use-package fira-code-mode
  ;;  :config (fira-code-mode-set-font)
  ;;  :custom (fira-code-mode-disabled-ligatures '("x" "[]" "<=" ">="))
  ;;  :hook prog-mode)

  (add-hook 'git-commit-mode-hook (lambda () (setq fill-column 72)))

  (setq comint-output-filter-functions
        (remove 'ansi-color-process-output comint-output-filter-functions))

  (add-hook 'shell-mode-hook
            (lambda ()
              ;; Forcibly set the shell to the system one
              (setq explicit-shell-file-name "/usr/bin/fish")
              (setq shell-file-name "fish")
              ;; Disable font-locking in this buffer to improve performance
              (font-lock-mode -1)
              ;; Prevent font-locking from being re-enabledin this buffer
              (make-local-variable 'font-lock-function)
              (setq font-lock-function (lambda (_) nil))
              (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter nil t)))

  ;; Set a few LSP-related variables
  (setq xref-backend-functions (lsp--xref-backend))
  (setq completion-at-point-functions (lsp-completion-at-point))

  ;; Set up key bindings to make HJKL switch windows in normal mode
  (spacemacs/set-leader-keys "ww" nil)
  (spacemacs/set-leader-keys "ww" 'spacemacs/window-transient-state/body)

  ;; Automatically resume previous layout, based on the directory in which EMACS is started.
  (desktop-save-mode)
  (desktop-read)

  ;; Change window split behaviour to focus into the new windows, since that's how I think.
  (spacemacs/set-leader-keys "w-" nil)
  (spacemacs/set-leader-keys "w-" 'split-window-below-and-focus)
  (spacemacs/set-leader-keys "w/" nil)
  (spacemacs/set-leader-keys "w/" 'split-window-right-and-focus)

  ;; Configure ellama to use chatgpt.
  ;;(setenv "OPENAI_API_KEY" "")

  ;; Redefine the 'gf' shortcut to try using find-file-in-project first, then fall back to find-file-at-point.
  (defun my/helm-projectile-find-file-dwim-or-ffap ()
    "Try to open the file under cursor using helm-projectile-find-file-dwim, fallback to find-file-at-point."
    (interactive)
    (let ((file (thing-at-point 'filename t))
          (include-paths '("/usr/include/c++/14" "/usr/include/c++/13" "/usr/include" "/usr/local/include")))
      (let ((full-path (expand-file-name file (seq-find (lambda (dir) (expand-file-name file dir)) include-paths))))
        (if (file-readable-p full-path)
            (find-file full-path)
          (if (and file (projectile-project-p))
              (helm-projectile-find-file-dwim)
            (message "File not found in project or system includes"))))))

  ;; Remap 'gf' to use the new function
  (define-key evil-normal-state-map (kbd "gf") 'my/helm-projectile-find-file-dwim-or-ffap)

  (defun my/goto-alternate-file ()
    "Switch between C/C++ source and header files."
    (interactive)
    (if (projectile-project-p)
        (projectile-find-related-file)
      (message "Not in a projectile project.")))

  ;; Remap 'ga' to switch between header and source files
  (define-key evil-normal-state-map (kbd "gA") 'what-cursor-position)
  (define-key evil-normal-state-map (kbd "ga") 'my/goto-alternate-file)

  ;; ----------------------------------------------------------------------
  ;; Skip flyspell’s expensive post-command hook while in C-v block mode
  ;; ----------------------------------------------------------------------
  (with-eval-after-load 'flyspell
    (defun my/flyspell-skip-in-visual-block (orig-fn &rest args)
      "Run ORIG-FN (flyspell-post-command-hook) only if not in visual-block."
      (unless (eq evil-visual-selection 'block)
        (apply orig-fn args)))

    (advice-add
     'flyspell-post-command-hook   ; the function that lives in post-command-hook
     :around
     #'my/flyspell-skip-in-visual-block))

  ;; ------------------------------------------------------------------------
  ;; Add command vibe-document, which inserts a Doxygen-compliant comment.
  ;; ------------------------------------------------------------------------

  ;; Generate an elisp interactive function for Spacemacs named vibe-document
  ;; which only works if called when the point is inside a C++ function body.
  ;; This function should read the entire function body, plus any Doxygen
  ;; comment that may be above the function declaration, and pipe it to an
  ;; external command named "ai", preceded by the prompt "generate a valid
  ;; Doxygen comment block, using the /// comment style, for this function.
  ;; Include full documentation for parameters, return type, exceptions, and a
  ;; description of what the function does. Use any existing Doxygen comment as
  ;; a starting point for the new comment."
  (defun vibe-document ()
    "Generate a Doxygen comment for the C++ function at point and copy it to the clipboard.

Only works when point is inside a C++ function declaration. Reads any existing Doxygen
comment above the declaration and the function signature/body, sends it to 'ai', and
copies the generated comment to the kill ring (clipboard)."
    (interactive)
    ;; Ensure we're in C++ mode
    (unless (derived-mode-p 'c++-mode)
      (user-error "vibe-document: Not in C++ mode"))
    (let* ((orig (point))
           ;; Locate function boundaries
           (defun-start (save-excursion (c-beginning-of-defun 1) (point)))
           (defun-end   (save-excursion (c-end-of-defun       1) (point)))
           ;; Determine existing comment start
           (comment-start
            (save-excursion
              (goto-char defun-start)
              (skip-chars-backward " \t\n")
              (if (looking-at "[ \t]*\\(///\\|/\\*\\*\\)")
                  (let ((cs (point)))
                    (while (and (not (bobp))
                                (progn (forward-line -1)
                                       (looking-at "[ \t]*\\(///\\|/\\*\\*\\)")))
                      (setq cs (point)))
                    cs)
                defun-start)))
           ;; Instructions for AI (preserve formatting including markdown and whitespace)
           (instructions
            "Trigger: the user submits C++ source code.
          Instruction: Generate a complete Doxygen /// comment block for the code provided.
          Trigger: doxygen comment generated.
          Instruction: Print only the comment, **do not print the original input**. **Do not print any extra text or markdown**. **Write valid C++ code**.")
           ;; Extract code for AI
           (function-code (buffer-substring-no-properties defun-start defun-end))
           ai-output)
      ;; Verify point is inside the function
      (unless (and (>= orig defun-start) (<= orig defun-end))
        (user-error "vibe-document: Point is not inside a C++ function body"))
      ;; Call external AI with instructions, feeding only the function code
      (with-temp-buffer
        (insert function-code)
        (call-process-region (point-min) (point-max)
                             "ai" nil t nil
                             "--instructions" instructions)
        (setq ai-output (buffer-string)))
      ;; Copy AI output to clipboard
      (kill-new ai-output)
      (message "vibe-document: Generated Doxygen comment copied to clipboard.")))
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(ansi-color-faces-vector
     [default default default italic underline success warning error])
   '(ansi-color-names-vector
     ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
   '(c-doc-comment-style
     '((c-mode . doxygen) (c++-mode . doxygen) (java-mode . javadoc)
       (pike-mode . autodoc)))
   '(clang-format-style "file")
   '(company-idle-delay 0.02)
   '(compilation-always-kill t)
   '(compilation-ask-about-save nil)
   '(compilation-auto-jump-to-first-error nil)
   '(compilation-max-output-line-length nil)
   '(compilation-scroll-output 'first-error)
   '(custom-enabled-themes '(spacemacs-dark))
   '(custom-safe-themes
     '("603a831e0f2e466480cdc633ba37a0b1ae3c3e9a4e90183833bc4def3421a961"
       "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088"
       "ce17f0b935cb4cf9167b384c8fefcff5448f039b89dbd1e45029400bc52b9b33"
       "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default))
   '(desktop-save-mode t)
   '(display-line-numbers-type 'visual)
   '(evil-want-Y-yank-to-eol t)
   '(expand-region-smart-cursor nil)
   '(expand-region-subword-enabled t)
   '(explicit-shell-file-name "/usr/bin/fish")
   '(flycheck-gcc-args '("--std=c++2a"))
   '(focus-follows-mouse t)
   '(git-gutter:diff-option "-w")
   '(global-flycheck-mode nil)
   '(hl-todo-keyword-faces
     '(("TODO" . "#dc752f") ("NEXT" . "#dc752f") ("THEM" . "#2d9574")
       ("PROG" . "#4f97d7") ("OKAY" . "#4f97d7") ("DONT" . "#f2241f")
       ("FAIL" . "#f2241f") ("DONE" . "#86dc2f") ("NOTE" . "#b1951d")
       ("KLUDGE" . "#b1951d") ("HACK" . "#b1951d") ("TEMP" . "#b1951d")
       ("FIXME" . "#dc752f") ("XXX+" . "#dc752f") ("\\?\\?\\?+" . "#dc752f")))
   '(ispell-dictionary "american")
   '(lsp-enable-indentation nil)
   '(lsp-enable-on-type-formatting nil)
   '(lsp-semgrep-scan-jobs 2)
   '(lsp-semgrep-server-command
     '("/home/seans/dotfiles/spacemacs/python-support/semgrep.sh" "lsp"))
   '(minimap-major-modes '(compilation-mode prog-mode))
   '(minimap-mode t)
   '(minimap-window-location 'right)
   '(mouse-autoselect-window t)
   '(next-error-recenter '(4))
   '(org-agenda-files '("~/dev/helix-project/helix/helix.org"))
   '(org-agenda-include-diary t)
   '(org-duration-format '(("h") (special . h:mm)))
   '(org-fontify-done-headline nil)
   '(org-fontify-todo-headline nil)
   '(org-log-into-drawer t)
   '(org-log-note-clock-out t)
   '(org-log-refile 'note)
   '(package-selected-packages
     '(ac-ispell ace-jump-helm-line ace-link ace-window add-node-modules-path
                 adoc-mode aggressive-indent aio all-the-icons annalist anzu async
                 auto-compile auto-complete auto-dictionary auto-highlight-symbol
                 auto-yasnippet avy bind-key bind-map bitbake bitbake-ts-mode
                 cargo centered-cursor-mode cfrs clang-format clean-aindent-mode
                 closql cmake-mode column-enforce-mode company company-shell
                 company-web compat composer counsel counsel-css counsel-gtags
                 csv-mode dash define-word devdocs diminish dired-quick-sort
                 docker docker-tramp dockerfile-mode dotenv-mode dracula-theme
                 drag-stuff dumb-jump editorconfig elisp-def elisp-slime-nav
                 emacsql emacsql-sqlite emmet-mode emr epl esh-help
                 eshell-git-prompt eshell-prompt-extras eshell-z esxml
                 eval-sexp-fu evil evil-anzu evil-args evil-cleverparens
                 evil-collection evil-easymotion evil-ediff evil-escape
                 evil-exchange evil-goggles evil-iedit-state evil-indent-plus
                 evil-lion evil-lisp-state evil-matchit evil-mc
                 evil-nerd-commenter evil-numbers evil-surround
                 evil-terminal-cursor-changer evil-textobj-line evil-tutor
                 evil-unimpaired evil-visual-mark-mode evil-visualstar
                 exec-path-from-shell expand-region eyebrowse f fancy-battery
                 fira-code-mode fireplace fish-mode flx flx-ido flycheck
                 flycheck-bashate flycheck-elsa flycheck-package flycheck-pos-tip
                 flycheck-rust flyspell-correct flyspell-correct-helm font-lock+
                 forge fuzzy gerrit ggtags ghub git-commit git-link git-messenger
                 git-modes git-timemachine gitignore-templates golden-ratio
                 google-translate goto-chg gptel grizzl haml-mode helm helm-ag
                 helm-c-yasnippet helm-company helm-core helm-css-scss
                 helm-descbinds helm-flx helm-git-grep helm-gtags helm-ls-git
                 helm-lsp helm-make helm-mode-manager helm-org helm-projectile
                 helm-purpose helm-swoop helm-themes helm-xref hide-comnt
                 highlight-indentation highlight-numbers highlight-parentheses
                 hl-todo ht htmlize hungry-delete hybrid-mode hydra iedit
                 imenu-list impatient-mode import-js indent-guide info+
                 insert-shebang inspector ivy journalctl-mode js-doc js2-mode
                 js2-refactor json-mode json-snatcher kv ligature linguistic
                 link-hint list-utils livid-mode lorem-ipsum lsp-mode lsp-origami
                 lsp-treemacs lsp-ui lv macrostep magit magit-section
                 markdown-mode memoize minimap mmm-jinja2 multi-line multi-term
                 multiple-cursors mwim nameless nginx-mode nodejs-repl nov
                 npm-mode open-junk-file org-pivotal org-re-reveal org-superstar
                 origami overseer ox-gfm package-lint packed paradox paredit
                 parent-mode password-generator pcre2el persistent-scratch
                 persp-mode pfuture pkg-info popup popwin pos-tip posframe
                 powerline prettier-js projectile pug-mode queue quickrun racer
                 rainbow-delimiters reformatter request restart-emacs ron-mode
                 rust-mode s sass-mode scss-mode shell-pop shfmt shut-up
                 simple-httpd skewer-mode slim-mode smartparens smeargle spaceline
                 spaceline-all-the-icons spinner sqlite3 srefactor
                 stickyfunc-enhance string-edit string-inflection swiper
                 symbol-overlay symon symon-lingr systemd tablist tagedit
                 terminal-here tern toc-org toml-mode transient tree-sitter
                 treemacs treemacs-evil treemacs-icons-dired treemacs-magit
                 treemacs-persp treemacs-projectile treepy typescript-mode
                 undo-tree unfill unkillable-scratch use-package uuidgen
                 vi-tilde-fringe visual-fill-column volatile-highlights vterm
                 web-beautify web-completion-data web-mode which-key
                 window-purpose winum with-editor writeroom-mode ws-butler
                 xterm-color yaml yaml-mode yasnippet yasnippet-snippets))
   '(pdf-view-midnight-colors '("#b2b2b2" . "#292b2e"))
   '(projectile-other-file-alist
     '(("cpp" "h" "hpp" "H") ("c" "h" "hpp" "H") ("h" "c" "cpp" "C")
       ("hpp" "cpp" "c" "C") ("H" "c" "cpp" "C") ("C" "h" "hpp" "H")))
   '(scroll-bar-mode 'right)
   '(semantic-idle-scheduler-idle-time 10)
   '(shell-pop-full-span t)
   '(shell-pop-shell-type
     '("ansi-term" "*ansi-term*" (lambda nil (ansi-term shell-pop-term-shell))))
   '(shell-pop-term-shell "/usr/bin/fish")
   '(shell-pop-universal-key "C-a")
   '(shell-pop-window-position 'top)
   '(warning-suppress-log-types '((comp)))
   '(warning-suppress-types '((lsp-mode)))
   '(yas-snippet-dirs
     '("/home/seans/.emacs.d/core/../private/snippets/"
       "/home/seans/.emacs.d/layers/+completion/auto-completion/local/snippets"
       yasnippet-snippets-dir "/home/seans/.config/yas/snippets/")))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(company-preview ((t (:background "#34323e" :foreground "#9a9aba" :height 1.25))))
   '(compilation-warning ((t (:inherit warning :foreground "yellow"))))
   '(completions-highlight ((t nil)))
   '(cursor ((t (:background "DarkGoldenrod2" :distant-foreground "black" :foreground "black" :weight heavy)))))
  )
