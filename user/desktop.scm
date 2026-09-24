(define-module (userconf desktop)
			   #:use-module ((userconf common)
							 #:select (user-common-packages user-common-services user-common-home))
			   #:use-module (gnu home)
			   #:use-module (gnu packages)
			   #:use-module (gnu services)
			   #:use-module (guix packages)
			   #:use-module (gnu home services)
			   #:use-module (gnu home services shells)
			   #:use-module (guix gexp)
			   #:use-module (guix utils)
			   #:export (user-desktop-home)) ;; Desktop home definitions for user.

(define user-desktop-home
  (home-environment
	(inherit user-common-home)
	(packages (append
				'()
				user-common-packages))
    (services (append
				'()
				user-common-services))))

