;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;

;; org-mode windmove compatibility
(setq org-replace-disputed-keys t)

;; setq dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))
(setq dotfiles-dir (file-name-directory (or load-file-name (buffer-file-name))))


(add-to-list 'load-path (expand-file-name
                         "lisp" (expand-file-name
                                 "org" (expand-file-name
                                        "src" dotfiles-dir))))

;; Package Locations
;; Location of various local packages (in .emacs.d/vendor or .emacs.d/src)
;;  because I don't want to keep them in =/Applications/Emacs.app/= or in
;;  =/usr/share/local/=.

(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/.emacs.d/")
           (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))

;; Font-face setup. Check the availability of a some default fonts, in
;; order of preference. The first of these alternatives to be found is
;; set as the default font, together with base size and fg/bg
;; colors. If none of the preferred fonts is found, nothing happens
;; and Emacs carries on with the default setup. We do this here to
;; prevent some of the irritating flickering and resizing that
;; otherwise goes on during startup. You can reorder or replace the
;; options here with the names of your preferred choices.

(defun font-existsp (font)
  "Check to see if the named FONT is available."
  (if (null (x-list-fonts font))
      nil t))

;; Set default font. First one found is selected.

;; Load up Org Mode and Babel
(require 'org-install)

;; load up the main file
(org-babel-load-file (expand-file-name "starter-kit.org" dotfiles-dir))

;;; init.el ends here
(require 'zenburnish)
(zenburnish)
(setenv "PATH" (concat (getenv "PATH") ":/opt/local/bin/:/opt/local/bin/git/:/bin/"))
(require 'org-latex)
(setq org-export-latex-listings t)
(add-to-list 'org-export-latex-classes
             '("org-article"
               "\\documentclass{org-article}
             [NO-DEFAULT-PACKAGES]
             [PACKAGES]
             [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'exec-path "/opt/local/bin/:/opt/local/bin/git/")


(load "php-mode-1.5.0/php-mode.el")
(require 'php-mode)
(url-retrieve
 "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
 (lambda (s)
   (end-of-buffer)
   (eval-print-last-sexp)))


(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)
(setq el-get-byte-compile nil)
(setq el-get-sources
      '(cssh el-get switch-window vkill google-maps  xcscope
             (:name codepilot
                    :type git
                    :url "git://github.com/brianjcj/codepilot.git"
                    )
             (:name dea
                    :type svn
                    :url "http://dea.googlecode.com/svn/trunk/"
                    )
             ))



(setq my-packages
      (append
       '(cssh el-get switch-window vkill  xcscope )
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my-packages)
(el-get 'wait)

(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups
(setq display-time-day-and-date t
      display-time-24hr-format t)
(display-time)





;; Turn on tabs
(setq indent-tabs-mode t)
(setq-default indent-tabs-mode t)


;; Set the tab width
(setq default-tab-width 4)
(setq tab-width 4)
(setq c-basic-indent 4)
(setq c-basic-offset 4)

(global-set-key [backtab] "\C-q\t")   ; Control tab quotes a tab.
(setq backup-by-copying-when-mismatch t)



;;(require 'nxml-mode)
;;(setq tab-width 4
;;      indent-tabs-mode nil
;;      nxml-child-indent 4
;;      nxml-attribute-indent 4)

(defconst my-emacs-path ".emacs.d/el-get/dea/" "emacs相关配置文件的路径")
(defconst my-emacs-my-lisps-path  (concat my-emacs-path "my-lisps/") "我自己写的emacs lisp包的路径")
(defconst my-emacs-lisps-path     (concat my-emacs-path "lisps/") "我下载的emacs lisp包的路径")
(defconst my-emacs-templates-path (concat my-emacs-path "templates/") "Path for templates")

(setq kill-ring-max 200)
;; 一个Emacs的16进制文件查看器，可以瞬间打开巨大的文件，比官方的
;; hexl-mode好用
(require 'hexview-mode)

;; 一些基本的小函数
(require 'ahei-misc)

;; 利用`eval-after-load'加快启动速度的库
;;

;;用eval-after-load避免不必要的elisp包的加载
;; http://emacser.com/eval-after-load.htm
;;(require 'eval-after-load)

(require 'util)

;; 一些Emacs的小设置
(require 'misc-settings)

;; 编码设置
(require 'coding-settings)

;; 鼠标配置
(require 'mouse-settings)

;; 关于mark的一些设置，使你非常方便的选择region
(require 'mark-settings)

;; `mode-line'显示格式
(require 'mode-line-settings)


;; 不要menu-bar和tool-bar
;; (unless window-system
;;   (menu-bar-mode -1))
(menu-bar-mode -1)
;; GUI下显示toolbar的话select-buffer会出问题
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

;; 打开压缩文件时自动解压缩
;; 必须放在session前面
(auto-compression-mode 1)

;; 所有关于buffer方面的配置
(require 'all-buffer-settings)

;; frame-cmds.el必须放在multi-term前面,否则ediff退出时会出现错误
;; 而icicles soft-requires frame-cmds.el, 所以icicles也必须放在
;; multi-term前面
;; emacs22下也必须放在kde-emacs前面, 否则会说shell-command是
;; void-function
;; http://emacser.com/icicles-doremi-palette.htm
(require 'icicles-settings)
(require 'doremi-settings)
(require 'palette-settings)

;; 用M-x执行某个命令的时候，在输入的同时给出可选的命令名提示
(require 'icomplete-settings)

;; minibuffer中输入部分命令就可以使用补全
(unless is-after-emacs-23
  (partial-completion-mode 1))


;; 方便的在kill-ring里寻找需要的东西
(require 'browse-kill-ring-settings)

;; diff
(require 'diff-settings)

;; Emacs的diff: ediff
(require 'ediff-settings)

;; 在buffer中方便的查找字符串: color-moccur
(require 'moccur-settings)

;; Emacs超强的增量搜索Isearch配置
(require 'isearch-settings)

;; 非常酷的一个扩展。可以“所见即所得”的编辑一个文本模式的表格
(if is-before-emacs-21 (require 'table "table-for-21"))
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
;; 增加更丰富的高亮
(require 'generic-x)
;; 返回到最近去过的地方
(require 'recent-jump-settings)

(require 'php-mode)
(require 'php-completion)
(php-completion-mode t)
(define-key php-mode-map (kbd "C-o") 'phpcmp-complete)
(require 'misc)

(global-set-key (kbd "C-x C-o") 'ff-find-other-file)
(global-set-key (kbd "C-z") 'cpro)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)


(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d)")
        (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
        (sequence "|" "CANCELED(c)")))
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
  )
(add-hook 'org-mode-hook 'org-mode-reftex-setup)


(setq org-agenda-files (list "~/Dropbox/research/gex/gex.org"))
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

(global-set-key (kbd "C-x C-r") 'recentf-open-files)
