#include <linux/module.h>

// Module metadata - visible with modinfo
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Will B");
MODULE_DESCRIPTION("A basic template for writing Linux Kernel Modules");
MODULE_VERSION("0.1");

/// Entry point of module, called on driver load (i.e. on insmod)
static int __init lkm_template_init(void) {
	pr_info("lkm_template: init\n");

	return 0;
}

/// Destructor for module, called on driver exit (i.e. on rmmod)
static void __exit lkm_template_exit(void) {
	pr_info("lkm_template: exit\n");
}

module_init(lkm_template_init);
module_exit(lkm_template_exit);