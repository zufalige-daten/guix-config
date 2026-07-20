(define-module (sysconf common)
			   #:use-module (gnu)
			   #:use-module (guix utils)
			   #:use-module (gnu packages)
			   #:use-module (guix packages)
			   #:use-module (gnu services)
			   #:use-module (gnu system nss)
			   #:use-module (gnu packages bash)
			   #:use-module (gnu services desktop)
			   #:use-module (gnu services guix)
			   #:export (common-packages common-services common-system)) ;; Common system definitions.
(use-service-modules networking ssh authentication desktop dbus)
(use-package-modules certs shells)

(define common-packages
  (append (map specification->package+output
			   '("bash"
				 "git"
				 "openssl"
				 "polkit"
			     "dbus"
			     "cryptsetup"
	    	     "libusb"
	    		 "dosfstools"
				 "ncurses"
				 "network-manager"
				 "wpa-supplicant"))
		  %base-packages))
(define (common-services user-home)
  (append (list
			(service accountsservice-service-type)
			(service elogind-service-type)
	  		(service wpa-supplicant-service-type)
	  		(service network-manager-service-type)
			(service guix-home-service-type
					 `(("user" ,user-home))))
		  %base-services))

(define (common-system user-home)
  (operating-system
	(locale "en_GB.utf8")
	(timezone "Europe/London")
	(keyboard-layout (keyboard-layout "gb"))
	(host-name "common")
	(bootloader (bootloader-configuration
                  (bootloader grub-bootloader)
                  (targets '("/dev/sda"))
                  (timeout 5)
                  (keyboard-layout keyboard-layout)))
	(file-systems %base-file-systems)
	(users (append
		   (list
			 (user-account (name "user")
						   (comment "Main User")
						   (group "users")
						   (home-directory "/home/user")
						   (password (crypt "default" "default"))
						   (shell (file-append bash "/bin/bash"))
						   (supplementary-groups
							 '("wheel" "users" "audio" "cdrom"))))
		   %base-user-accounts))
	(packages common-packages)
	(services (common-services user-home))
	(swap-devices (list
					(swap-space
					  (target "/swap-file")
					  (dependencies file-systems))))))

