(define-module (sysconf desktop)
			   #:use-module ((userconf common)
							 #:select (user-common-home))
			   #:use-module ((userconf desktop)
							 #:select (user-desktop-home-transformation))
			   #:use-module (gnu)
			   #:use-module (guix utils)
			   #:use-module (gnu packages)
			   #:use-module (guix packages)
			   #:export (desktop-system-transformation)) ;; Special configuration for desktop.

(define (desktop-system-transformation os)
  (operating-system
	(inherit os)
	(host-name "null0")
	(keyboard-layout (keyboard-layout "gb"))
	(services (append
				(operating-system-services os)
				(service guix-home-service-type
					 `(("user" ,(user-desktop-home-transformation user-common-home))))))
	(bootloader (bootloader-configuration
                  (bootloader grub-bootloader)
                  (targets '("/dev/sda"))
                  (timeout 5)
                  (keyboard-layout keyboard-layout)))
	(file-systems (append
				    (list
				      (file-system
                        (mount-point "/")
                        (device "/dev/sda2")
                        (type "ext4"))
                      (file-system
                        (mount-point "/boot")
                        (device "/dev/sda1")
                        (type "vfat")))
					%base-file-systems))))

