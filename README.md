# ARM-CM4-simple-led-blinking-example-with-GNU-make
* Sure,IDE provides GUI to set different specifications  which saves efforts for applications development and generates an important file 
used for automate building process called "makefile",this file generally depends on specific architecture .

* Once your own IDE did not support a specific target,in this case you have to write your own makefile.

* if it first time you hear about make file ,go directly to these two abstracted introductions to make system.
* http://maemo.org/maemo_training_material/maemo4.x/html/maemo_Application_Development_Chinook/Chapter_02_GNU_Make_and_makefiles.html?fbclid=IwAR2xPEzkcUlIW9lYr1p4iveDj1QUqTzy0Iy8JGQ4oiIhCUrquca9Fcr7Wfk

* http://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/

* for more info here the gnu make manual.
* https://www.gnu.org/software/make/manual/make.html


* After reading the above documents lets show how to handle the cross-compilation process with makefile attached with the repo.
* Here ,folders organisation must be set before run makefile as shown below.
*![vj](https://user-images.githubusercontent.com/60859162/79701740-c7b28d80-829f-11ea-9236-c543276e00d8.PNG)


* the makefile starts with the following:
* 1:setting the compilation ,linking and file transformatin commands 
* 2:setting compilation and linking (ccflags,ldflags) flags which are target specific
* 3: specifying filders contain sources files(src,library/src) and  output folders(build,build/src,build/library/src) contain objects from compilation process .
* 4:setting three varaibles (SRCS,ASRC and OBJ_c_asm) hold .c files,.asm files and objects resultant from compilation respectively  
* 5:define the needed targets (.elf,.hex,.bin) with their dependencies and rules
*After running make(do not forget to set folders organisation as above),you will get the following as ouputs from build process
*![hkk](https://user-images.githubusercontent.com/60859162/79701924-33492a80-82a1-11ea-8187-f78e93a65bbf.PNG)



