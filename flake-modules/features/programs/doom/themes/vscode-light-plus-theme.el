;;; vscode-light-plus-theme.el --- VSCode Light+ feel on top of the Modus themes -*- lexical-binding:t -*-

;;; Commentary:
;;
;; A personal derivative of the `modus-themes' (version 5 or later) that
;; feels like Visual Studio Code's "Light+" theme in Doom Emacs.
;;
;; Rather than copying VSCode's token colors verbatim, it follows the
;; approach of Doom's `doom-dark+' port of Dark+:
;;
;; - a soft near-black foreground instead of pure #000000;
;; - variables get their own visible color (VSCode Light+'s #001080 is
;;   barely distinguishable from the foreground);
;; - doc comments are grey rather than string-colored;
;; - the harshest VSCode values (#0000ff keywords, #008000 comments,
;;   #a31515 strings) are toned down while keeping their hue;
;; - line numbers are grey, the cursor is blue;
;; - non-file buffers (popups, sidebars) get a slightly darker
;;   background via `solaire-mode', like the VSCode side bar;
;; - rainbow delimiters cycle through the full palette;
;; - the blue VSCode status bar gets mode-line colors that stay legible
;;   on it (borrowed from Dark+'s editor colors).
;;
;; All text colors are at least 4.5:1 against the background.
;;
;; Load with (setq doom-theme 'vscode-light-plus).  Individual colors
;; can be tweaked through `vscode-light-plus-palette-overrides'.

;;; Code:

(require 'modus-themes)

(defconst vscode-light-plus-palette-partial
  '(;; Editor / workbench
    (bg-main     "#ffffff")
    (fg-main     "#1f1f1f")
    (bg-dim      "#f3f3f3")             ; VSCode side bar / widgets
    (fg-dim      "#6e6e6e")
    (fg-alt      "#616161")
    (bg-active   "#e0e0e0")
    (bg-inactive "#ececec")
    (border      "#d4d4d4")
    (grey        "#9e9e9e")

    ;; Token colors
    (red            "#cd3131")          ; error, VSCode errorForeground
    (red-warmer     "#b5452f")          ; string
    (red-cooler     "#811f3f")          ; regexp
    (red-faint      "#a31515")          ; VSCode Light+ string
    (red-intense    "#e51400")
    (green          "#3d7b33")          ; comment
    (green-warmer   "#388a34")
    (green-cooler   "#098658")          ; number
    (green-faint    "#4f7a46")
    (green-intense  "#107c10")
    (yellow         "#795e26")          ; function
    (yellow-warmer  "#9a6700")          ; warning
    (yellow-cooler  "#c05621")          ; orange
    (yellow-faint   "#8f6d00")          ; gold
    (yellow-intense "#bf8803")
    (blue           "#1d4ed8")          ; keyword, constant
    (blue-warmer    "#3a3fbf")
    (blue-cooler    "#0070c1")
    (blue-faint     "#0451a5")
    (blue-intense   "#0f6fc0")          ; info
    (magenta        "#a626a4")          ; control keyword / builtin
    (magenta-warmer "#bc05bc")
    (magenta-cooler "#7a4fbf")          ; violet
    (magenta-faint  "#8e4b8e")
    (magenta-intense "#c51fc5")
    (cyan           "#0b6aa2")          ; variable, property
    (cyan-warmer    "#006ab1")          ; link
    (cyan-cooler    "#0f7b6c")          ; type (teal)
    (cyan-faint     "#1a7590")
    (cyan-intense   "#0598bc")

    ;; Backgrounds
    (bg-red-intense     "#f8c9ab")      ; VSCode findMatchHighlight
    (bg-green-intense   "#c4e3a6")
    (bg-yellow-intense  "#ffe48a")
    (bg-blue-intense    "#add6ff")
    (bg-magenta-intense "#e5c6f0")
    (bg-cyan-intense    "#a6d8ee")
    (bg-red-subtle      "#ffd7d7")
    (bg-green-subtle    "#dff0d0")
    (bg-yellow-subtle   "#fdf3c8")
    (bg-blue-subtle     "#d6ebff")
    (bg-magenta-subtle  "#f3e1f8")
    (bg-cyan-subtle     "#d4eef7")
    (bg-red-nuanced     "#fff0f0")
    (bg-green-nuanced   "#eff8e9")
    (bg-yellow-nuanced  "#fffaeb")
    (bg-blue-nuanced    "#eef5ff")
    (bg-magenta-nuanced "#faf2fc")
    (bg-cyan-nuanced    "#eaf6fa")

    ;; Specific UI elements
    (bg-region             "#cfe3fc")   ; softened editor.selectionBackground
    (bg-hl-line            "#f2f2f2")
    (bg-completion         "#dce9fa")
    (bg-hover              "#e8e8e8")
    (bg-hover-secondary    "#e4e6f1")
    (bg-paren-match        "#d4e8d4")
    (bg-paren-expression   "#eef5ff")
    (bg-search-lazy-grey   "#e4e4e4")
    (bg-mode-line-active   "#007acc")   ; statusBar.background
    (fg-mode-line-active   "#ffffff")
    (bg-mode-line-inactive "#f3f3f3")
    (fg-mode-line-inactive "#616161")
    ;; Dark+ editor colors, legible on the blue status bar
    (mode-line-red     "#ffb3b3")
    (mode-line-yellow  "#ffe08a")
    (mode-line-cyan    "#b5f2ff")
    (mode-line-magenta "#f0c6ee")

    ;; Terminal (VSCode light terminal.ansi* colors)
    (term-red     "#cd3131")
    (term-green   "#00bc00")
    (term-yellow  "#949800")
    (term-blue    "#0451a5")
    (term-magenta "#bc05bc")
    (term-cyan    "#0598bc")

    ;; Diffs (fringe colors are VSCode's editorGutter.*Background)
    (bg-added          "#dff0d0")
    (bg-added-faint    "#eff8e9")
    (bg-added-refine   "#c4e3a6")
    (bg-added-fringe   "#81b88b")
    (fg-added          "#107c10")
    (fg-added-intense  "#008000")
    (bg-changed         "#d6ebff")
    (bg-changed-faint   "#eef5ff")
    (bg-changed-refine  "#add6ff")
    (bg-changed-fringe  "#66afe0")
    (fg-changed         "#0451a5")
    (fg-changed-intense "#0070c1")
    (bg-removed         "#ffd7d7")
    (bg-removed-faint   "#fff0f0")
    (bg-removed-refine  "#ffb3b3")
    (bg-removed-fringe  "#ca4b51")
    (fg-removed         "#a31515")
    (fg-removed-intense "#e51400")))

(defconst vscode-light-plus-palette-mappings-partial
  '(;; Code
    (comment      green)
    (string       red-warmer)
    (docstring    fg-dim)
    (docmarkup    fg-alt)
    (keyword      blue)
    (builtin      magenta)
    (preprocessor magenta)
    (constant     blue)
    (number       green-cooler)
    (fnname       yellow)
    (fnname-call  yellow)
    (type         cyan-cooler)
    (variable     cyan)
    (variable-use cyan)
    (property     cyan)
    (identifier   cyan)
    (rx-construct red-cooler)
    (rx-backslash magenta)

    ;; Diagnostics
    (err     red)
    (warning yellow-warmer)
    (info    blue-intense)
    (underline-err     red)
    (underline-warning yellow-intense)
    (underline-note    blue-intense)
    (modeline-err     mode-line-red)
    (modeline-warning mode-line-yellow)
    (modeline-info    mode-line-cyan)

    ;; UI
    (cursor                  blue)
    (fringe                  bg-main)
    (fg-region               unspecified)
    (bg-popup                bg-dim)
    (bg-line-number-inactive bg-main)
    (bg-line-number-active   bg-main)
    (fg-line-number-inactive grey)
    (fg-line-number-active   fg-main)
    (border-mode-line-active   bg-mode-line-active)
    (border-mode-line-inactive bg-mode-line-inactive)
    (bg-tab-bar     bg-dim)
    (bg-tab-current bg-main)
    (bg-tab-other   bg-inactive)
    (keybind   blue)
    (name      yellow)
    (fg-prompt blue)
    (fg-link         cyan-warmer)
    (underline-link  cyan-warmer)
    (fg-link-visited magenta-cooler)
    (underline-link-visited magenta-cooler)

    ;; Search
    (bg-search-current bg-red-intense)
    (bg-search-lazy    bg-search-lazy-grey)
    (bg-search-static  bg-yellow-subtle)
    (bg-search-replace bg-red-subtle)

    ;; Completion
    (fg-completion-match-0 blue)
    (fg-completion-match-1 magenta)
    (fg-completion-match-2 cyan-cooler)
    (fg-completion-match-3 yellow-cooler)

    ;; Accents
    (accent-0 blue)
    (accent-1 magenta)
    (accent-2 cyan-cooler)
    (accent-3 yellow-cooler)

    ;; Rainbow delimiters, in `doom-dark+' order
    (rainbow-0 magenta)
    (rainbow-1 yellow-cooler)
    (rainbow-2 green)
    (rainbow-3 cyan)
    (rainbow-4 magenta-cooler)
    (rainbow-5 yellow-faint)
    (rainbow-6 blue)
    (rainbow-7 cyan-cooler)
    (rainbow-8 cyan-faint)

    ;; Prose (org/markdown), after Doom's defaults
    (fg-heading-0 blue)
    (fg-heading-1 blue)
    (fg-heading-2 magenta)
    (fg-heading-3 magenta-cooler)
    (fg-heading-4 cyan-cooler)
    (fg-heading-5 cyan)
    (fg-heading-6 yellow-cooler)
    (fg-heading-7 green)
    (fg-heading-8 fg-dim)
    (fg-prose-code     yellow-cooler)
    (fg-prose-verbatim green)
    (fg-prose-macro    magenta)
    (prose-done     fg-dim)
    (prose-todo     red)
    (prose-tag      fg-dim)
    (prose-metadata fg-dim)
    (prose-table-formula cyan-cooler)

    ;; Dates (org agenda)
    (date-common    cyan)
    (date-deadline  red)
    (date-scheduled yellow-cooler)
    (date-weekday   blue)
    (date-weekend   magenta)

    ;; Terminal
    (fg-term-red     term-red)
    (bg-term-red     term-red)
    (fg-term-green   term-green)
    (bg-term-green   term-green)
    (fg-term-yellow  term-yellow)
    (bg-term-yellow  term-yellow)
    (fg-term-blue    term-blue)
    (bg-term-blue    term-blue)
    (fg-term-magenta term-magenta)
    (bg-term-magenta term-magenta)
    (fg-term-cyan    term-cyan)
    (bg-term-cyan    term-cyan)))

(defconst vscode-light-plus-custom-faces
  '(;; solaire-mode: darker background for non-file buffers, as Doom
    ;; themes do.  Modus does not style these faces.
    `(solaire-default-face ((,c :inherit default :background ,bg-dim)))
    `(solaire-hl-line-face ((,c :inherit hl-line :background ,bg-main :extend t)))
    `(solaire-org-hide-face ((,c :inherit org-hide :foreground ,bg-dim)))
    ;; doom-modeline: keep every segment legible on the blue status bar.
    `(mode-line-emphasis ((,c :foreground ,fg-mode-line-active :weight bold)))
    `(doom-modeline-bar ((,c :background ,bg-mode-line-active)))
    `(doom-modeline-bar-inactive ((,c :background ,bg-mode-line-inactive)))
    `(doom-modeline-buffer-file ((,c :inherit mode-line-emphasis)))
    `(doom-modeline-project-dir ((,c :inherit mode-line-emphasis)))
    `(doom-modeline-info ((,c :foreground ,modeline-info)))
    `(doom-modeline-lsp-success ((,c :foreground ,modeline-info)))
    `(doom-modeline-repl-success ((,c :foreground ,modeline-info)))
    `(doom-modeline-warning ((,c :foreground ,modeline-warning)))
    `(doom-modeline-lsp-warning ((,c :foreground ,modeline-warning)))
    `(doom-modeline-repl-warning ((,c :foreground ,modeline-warning)))
    `(doom-modeline-battery-warning ((,c :foreground ,modeline-warning)))
    `(doom-modeline-notification ((,c :foreground ,modeline-err)))
    `(doom-modeline-evil-insert-state ((,c :foreground ,mode-line-cyan)))
    `(doom-modeline-evil-visual-state ((,c :foreground ,mode-line-yellow)))
    `(doom-modeline-evil-replace-state ((,c :foreground ,mode-line-red)))
    `(doom-modeline-evil-emacs-state ((,c :foreground ,mode-line-magenta))))
  "Faces that `vscode-light-plus' sets on top of the Modus defaults.")

(defcustom vscode-light-plus-palette-overrides nil
  "Overrides for `vscode-light-plus-palette'.
Mirror the elements of the palette, overriding their value."
  :group 'modus-themes
  :type '(repeat (list symbol (choice symbol string))))

(defconst vscode-light-plus-palette
  (modus-themes-generate-palette
   vscode-light-plus-palette-partial
   'cool                                ; fills the gaps from `modus-themes-operandi-palette'
   nil
   vscode-light-plus-palette-mappings-partial))

;;;###theme-autoload
(modus-themes-theme
 'vscode-light-plus
 'vscode-themes
 "Light theme with the feel of VSCode's Light+, tuned for Emacs."
 'light
 'vscode-light-plus-palette
 nil
 'vscode-light-plus-palette-overrides
 'vscode-light-plus-custom-faces)

(provide 'vscode-light-plus-theme)

;;; vscode-light-plus-theme.el ends here
