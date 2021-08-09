self: super:
let
  myEmacsPkgs = ep: with ep.melpaPackages; [
    # There's a bug in the current source of evil-escape that causes it to
    # fail to build. We'll patch it out for now and hope it gets fixed in a
    # future version.
    (
      ep.evil-escape.overrideAttrs (
        o: {
          patches = (o.patches or [ ]) ++ [
            (
              super.fetchpatch {
                url = https://github.com/BrianHicks/evil-escape/commit/b548e8450570a0c8dea47b47221b728c047a9baf.patch;
                sha256 = "1a2qrf4bpj7wm84qa3haqdg3pd9d8nh5vrj8v1sc0j1a9jifsbf6";
              }
            )
          ];
        }
      )
    )

    # Not packaged
    # evil-unimpaired
    # git-gutter-plus
    # git-gutter-fringe-plus
    # hybrid-mode
    # company-ghc
    # company-ghci
    # ghc
    # intero

    ac-ispell
    ace-jump-helm-line
    ace-jump-mode
    ace-link
    ace-window
    adoc-mode
    aggressive-indent
    alert
    all-the-icons
    alsamixer
    anaconda-mode
    anaphora
    ansible
    ansible-doc
    anzu
    async
    attrap
    auto-compile
    auto-complete
    auto-dictionary
    auto-highlight-symbol
    auto-yasnippet
    autothemer
    avy
    bind-key
    bind-map
    blacken
    browse-at-remote
    bundler
    cargo
    ccls
    centered-cursor-mode
    chruby
    clang-format
    clean-aindent-mode
    closql
    cmm-mode
    column-enforce-mode
    company
    company-anaconda
    company-ansible
    company-c-headers
    company-cabal
    company-emacs-eclim
    company-go
    company-lua
    company-nixos-options
    company-php
    company-plsense
    company-quickhelp
    company-restclient
    company-shell
    company-statistics
    company-terraform
    company-web
    concurrent
    copy-as-format
    counsel
    counsel-gtags
    counsel-projectile
    cpp-auto-include
    cquery
    ctable
    cython-mode
    dactyl-mode
    dante
    dap-mode
    deferred
    define-word
    devdocs
    diff-hl
    diminish
    dired-quick-sort
    direnv
    disaster
    docker
    docker-tramp
    dockerfile-mode
    doom-modeline
    dotenv-mode
    dumb-jump
    eclim
    editorconfig
    ein
    eldoc-eval
    elfeed
    elfeed-goodies
    elfeed-org
    elfeed-web
    elisp-slime-nav
    emacsql
    emacsql-sqlite
    emmet-mode
    emms
    emr
    engine-mode
    ep.csv-mode
    ep.elpaPackages.xclip
    ep.font-lock-plus
    ep.mmm-mode
    ep.orgPackages.org
    ep.orgPackages.org-plus-contrib
    ep.rtags
    ep.sql-indent
    ep.undo-tree
    epc
    epl
    esh-help
    eshell-prompt-extras
    eshell-z
    eval-sexp-fu
    evil
    evil-anzu
    evil-args
    evil-cleverparens
    evil-easymotion
    evil-ediff
    evil-exchange
    evil-goggles
    evil-iedit-state
    evil-indent-plus
    evil-ledger
    evil-lion
    evil-lisp-state
    evil-matchit
    evil-mc
    evil-nerd-commenter
    evil-numbers
    evil-org
    evil-surround
    evil-textobj-line
    evil-tutor
    evil-visual-mark-mode
    evil-visualstar
    exec-path-from-shell
    expand-region
    eyebrowse
    f
    fancy-battery
    fill-column-indicator
    fish-mode
    flx
    flx-ido
    flycheck
    flycheck-bashate
    flycheck-elsa
    flycheck-haskell
    flycheck-ledger
    flycheck-package
    flycheck-pos-tip
    flycheck-rust
    flyspell-correct
    flyspell-correct-helm
    forge
    fringe-helper
    fuzzy
    gcmh
    ggtags
    gh
    gh-md
    ghub
    gist
    git-commit
    git-gutter
    git-gutter-fringe
    git-link
    git-messenger
    git-timemachine
    gitattributes-mode
    gitconfig-mode
    github-clone
    github-search
    gitignore-mode
    gitignore-templates
    gntp
    gnuplot-mode
    go-eldoc
    go-fill-struct
    go-gen-test
    go-guru
    go-impl
    go-mode
    go-rename
    go-tag
    godoctor
    golden-ratio
    google-c-style
    google-translate
    goto-chg
    gradle-mode
    graphviz-dot-mode
    grip-mode
    groovy-imports
    groovy-mode
    gruvbox-theme
    haml-mode
    haskell-mode
    haskell-snippets
    hcl-mode
    helm
    helm-ag
    helm-c-yasnippet
    helm-company
    helm-core
    helm-css-scss
    helm-descbinds
    helm-flx
    helm-git-grep
    helm-gitignore
    helm-gtags
    helm-hoogle
    helm-ls-git
    helm-lsp
    helm-make
    helm-mode-manager
    helm-nixos-options
    helm-notmuch
    helm-org
    helm-org-rifle
    helm-projectile
    helm-purpose
    helm-pydoc
    helm-swoop
    helm-themes
    helm-xref
    hierarchy
    highlight
    highlight-indentation
    highlight-numbers
    highlight-parentheses
    hl-todo
    hlint-refactor
    ht
    htmlize
    hungry-delete
    hydra
    ibuffer-projectile
    iedit
    imenu-list
    impatient-mode
    importmagic
    indent-guide
    inf-ruby
    insert-shebang
    ivy
    jenkins
    jinja2-mode
    js-doc
    js2-mode
    js2-refactor
    json-mode
    json-navigator
    json-reformat
    json-snatcher
    jupyter
    know-your-http-well
    language-detection
    lcr
    ledger-mode
    link-hint
    list-utils
    live-py-mode
    livid-mode
    log4e
    logito
    lorem-ipsum
    lsp-haskell
    lsp-java
    lsp-mode
    lsp-origami
    lsp-pyright
    lsp-treemacs
    lsp-ui
    lua-mode
    macrostep
    magit
    magit-gitflow
    magit-popup
    magit-section
    magit-svn
    markdown-mode
    markdown-toc
    markup-faces
    marshal
    maven-test-mode
    meghanada
    memoize
    minitest
    mmm-jinja2
    move-text
    multi-term
    multiple-cursors
    mvn
    mwim
    nameless
    names
    nginx-mode
    nix-mode
    nix-update
    nixos-options
    nodejs-repl
    noflet
    notmuch
    ob-http
    ob-restclient
    open-junk-file
    org-bookmark-heading
    org-brain
    org-bullets
    org-category-capture
    org-cliplink
    org-download
    org-jira
    org-journal
    org-mime
    org-mru-clock
    org-pomodoro
    org-present
    org-projectile
    org-rich-yank
    org-super-agenda
    org-superstar
    orgit
    origami
    overseer
    ox-gfm
    ox-jira
    ox-pandoc
    ox-twbs
    p4
    package-lint
    packed
    pandoc-mode
    paradox
    paredit
    parent-mode
    password-generator
    pcache
    pcre2el
    pdf-tools
    persp-mode
    pfuture
    pip-requirements
    pipenv
    pippel
    pkg-info
    polymode
    popup
    popwin
    pos-tip
    powerline
    prettier-js
    projectile
    pug-mode
    py-isort
    pyenv-mode
    pytest
    pythonic
    pyvenv
    racer
    rainbow-delimiters
    rake
    rbenv
    request
    request-deferred
    restart-emacs
    restclient
    restclient-helm
    ripgrep
    robe
    ron-mode
    rpm-spec-mode
    rspec-mode
    rubocop
    rubocopfmt
    ruby-hash-syntax
    ruby-refactor
    ruby-test-mode
    ruby-tools
    rvm
    s
    salt-mode
    sass-mode
    sbt-mode
    scala-mode
    scss-mode
    seeing-is-believing
    shell-pop
    shrink-path
    simple-httpd
    skewer-mode
    slim-mode
    smartparens
    smeargle
    solarized-theme
    spaceline
    spaceline-all-the-icons
    sphinx-doc
    string-inflection
    swiper
    symbol-overlay
    symon
    systemd
    tablist
    tagedit
    terminal-here
    tern
    terraform-mode
    tmux-pane
    toc-org
    toml-mode
    treemacs
    treemacs-evil
    treemacs-magit
    treemacs-projectile
    treepy
    unfill
    use-package
    uuidgen
    vi-tilde-fringe
    vimrc-mode
    visual-fill-column
    volatile-highlights
    vterm
    web-beautify
    web-completion-data
    web-mode
    websocket
    which-key
    window-purpose
    winum
    with-editor
    writeroom-mode
    ws-butler
    xcscope
    xml-rpc
    xterm-color
    yaml-mode
    yapfify
    yasnippet
    yasnippet-snippets
    zeal-at-point
  ];

  # Many emacs packages may pull in dependencies on things they need
  # automatically, but for those that don't, here are the requisite NixPkgs. Nix
  # will wrap these into a buildEnv dir, and then add it to the wrapped emacs'
  # `exec-path` variable so that they're accessible inside emacs.
  myEmacsDeps = [
    # General tools
    self.direnv # For direnv-mode
    self.ripgrep # For helm

    # C/C++ Tools
    self.clang-tools

    # Python Tools
    self.autoflake
    self.python3Packages.pyflakes
    self.python3Packages.pyls-black
    self.python3Packages.pyls-isort
    self.python3Packages.pyls-mypy

    # Rust Tools
    self.cargo
    self.rustc
    self.rustfmt

    # LSP Tools
    self.nodePackages.bash-language-server
    self.nodePackages.pyright
    self.nodePackages.vscode-json-languageserver
  ];

  # Build a spacemacs with the pinned overlay import, using the passed emacs
  mkSpacemacs = package:
    self.emacsWithPackagesFromUsePackage {
      config = "";
      inherit package;
      extraEmacsPackages = ep: ((myEmacsPkgs ep) ++ myEmacsDeps);
    };

  spacemacsGcc = mkSpacemacs self.emacsGcc;
  spacemacsGit = mkSpacemacs self.emacsGit;
  spacemacs = spacemacsGcc;

in
{
  inherit spacemacsGcc spacemacsGit spacemacs;
}
