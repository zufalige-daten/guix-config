(define-module (userconf common)
			   #:use-module (gnu home)
			   #:use-module (gnu packages)
			   #:use-module (gnu services)
			   #:use-module (guix packages)
			   #:use-module (gnu home services)
			   #:use-module (gnu home services shells)
			   #:use-module (guix gexp)
			   #:use-module (guix utils)
			   #:export (user-common-packages user-common-services user-common-home)) ;; Common home definitions for user.

(define user-common-packages
  (map specification->package+output
       '("hyfetch"
         "fastfetch"
         "nano"
         "neovim"
         "bash"
         "gcc")))
(define user-common-services
  (append
    (list
      (service home-bash-service-type
    		   (home-bash-configuration
    		     (guix-defaults? #t)
    		     (variables
    			   `(("HISTFILE" . "$HOME/.bash_history")
    			     ("HISTSIZE" . "50000"))))))
    %base-home-services))

(define user-common-home
  (home-environment
	(packages user-common-packages)
    (services user-common-services)))

