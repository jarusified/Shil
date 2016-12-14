# Emacs Notes

## Hooks
 A hook is a variable which holds the list of functions to call. There are two types of hooks in emacs:
    > Normal hook
    > Abnormal hook
 The names that end in -functions are abnormal hooks. These abnormal hooks can be passed on arguments whereas hooks dont have the arguments passed in while it is being called. They stop the execution as soon as one of the function return a nil. 
 
## setq
setq is nothing but set + quote. 
''' Example:
	(setq foo 'bar) === (set 'foo 'bar)
"""
### Difference between setq and setq-default
Emacs has something called "buffer-local", each buffer is allowed to have a separate value for that variable. It would overwrite the default. 

## Emacs Start-up 
[source] (https://www.gnu.org/software/emacs/manual/html_node/elisp/Startup-Summary.html)
Emacs generally takes a sweet time to load all the configurations. 

* Use Emacs Start up profiler [ESUP](https://github.com/jschaf/esup), It is useful to edit emacs init files with performace. Provides the compile time for each hook or function. 
* 

## Package initialize
This is an important line in the .emacs file as it initialises all the dependent packages so that it can be accessed later. 
'''
(package-initialize)
'''

## ido-mode 
Mode used to navigate between buffers and file. One problem is creation of files with the same name as the folders. 



