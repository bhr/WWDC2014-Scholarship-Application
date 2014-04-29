1. cd into the folder where the submodule should be
2. git submodule add https://github.com/bhr/BHRExtensions
3. Drag and Drop Xcodeproj into your workspace
4. Project Settings -> Link Framework
5. Project Build Settings -> Other Linker Flags -> Add '-ObjC'
6. Move Framework header file to project (don't copy)
7. Place '#import "BHRExtensions.h"' in the precompiled header of your project or where you need it!
