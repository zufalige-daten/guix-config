(define-module (sysconf desktop)
			   #:use-module ((sysconf common)
							 #:select (common-packages common-services common-system))
			   #:use-module ((userconf desktop)
							 #:select (user-desktop-home))
			   #:use-module (gnu)
			   #:use-module (guix utils)
			   #:use-module (gnu packages)
			   #:use-module (guix packages)
			   #:export (desktop-system)) ;; Special configuration for desktop.

(define desktop-system
  (operating-system
	(inherit (common-system user-desktop-home))
	(host-name "null0")
	(keyboard-layout (keyboard-layout "gb"))
	(packages (append
				'()
				common-packages))
	(services (append
				'()
				(common-services user-desktop-home)))
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

