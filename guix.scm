(use-modules
 (gnu packages autotools)
 (gnu packages guile)
 (gnu packages man)
 (gnu packages pkg-config)
 (gnu packages wm)
 (guix build-system gnu)
 (guix gexp)
 (guix git-download)
 (guix licenses)
 (guix packages))

(define cagebreak-autotools
  (package
    (inherit cagebreak)
    (name "cagebreak-autotools")
    (version "git")
    (source
     (let ((dir (dirname (or (current-filename)
                             "/home/ivan/workspace/cagebreak/guix.scm"))))
       (local-file dir #:recursive? #t #:select? (git-predicate dir))))
    (build-system gnu-build-system)
    (native-inputs
     (list autoconf automake pkg-config scdoc))
    (license gpl3)))

cagebreak-autotools
