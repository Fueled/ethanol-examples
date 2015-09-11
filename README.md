# ethanol-examples

This repository contains a workspace which includes all ethanol frameworks (and their dependencies) into itself, as well as playground files that shows how to use most of the feature of each frameworks.

### Usage

Before you're able to compile it, you must fetch its dependencies via [Carthage](https://github.com/Carthage/Carthage). The command line to use when first downloading the project is `carthage bootstrap --use-submodules --no-build` (**And not another**). This will fetch each dependencies into a [git submodule](http://git-scm.com/docs/git-submodule). Each's project file from each frameworks are what is included as part of the example workspace.

### Playground development

Once the EthanolExamples scheme is compiled on an **iphone simulator** (![Screenshot](https://www.dropbox.com/s/gb6tzot6uvwn74x/Screenshot%202015-08-14%2012.07.15.png?dl=1) for example), you are free to reference any frameworks from the workspace into the playground (Via `#import`s). It's very important to compile on the simulator otherwise playgrounds won't find the frameworks.

You can also compile only a given framework by selecting its scheme and building only that scheme (![Screenshot](https://www.dropbox.com/s/d3ckyy92gbuve53/Screenshot%202015-08-14%2012.07.01.png?dl=1) for example) for development purpose.

Note: You can create additional playgrounds using the xcode interface, but make sure that the playground settings (In the right sidebar) are set to use the platform `iOS`.

![Platform iOS](https://www.dropbox.com/s/due634brlpzqk6r/Screenshot%202015-08-14%2014.00.02.png?dl=1)

### Ethanol Frameworks development

The frameworks being fetched as submodules, the project of the framework should be used to develop on the frameworks, as it allows for very fast iterative developement via playgrounds. It also allows to implement additional unit tests like you would on any other frameworks.

To develop on frameworks via the example project, you can simply change any files from the Framework project in the workspace. The tricky part comes from them being submodules: in order to commit a change to a framework, you have to reference the right .git folder which will be under `<workspace directory>/Carthage/Checkouts/<Framework folder>`. You can then commit, fetch and push as if you were in the framework's git repository.

Your changes in the examples project should be committed on the same branch name as the changes for the framework (both for consistency and so it's easier to know which changes are linked to what), and the Cartfile of the example project should reflect that branch from the framework as well.

For example, let's say you want to work on the keyboard helper (Branch name for this example will be `keyboardHelper`), which is located in the ui-extensions framework:

1. In the EthanolExamples workspace, only EthanolExamples and the EthanolUIExtensions project can be modified
2. To commit changes made on EthanolUIExtensions, you should commit and push from `<workspace directory>/Carthage/Checkouts/ethanol-ui-extensions`, on the branch `keyboardHelper`
3. A new branch `keyboardHelper` should be created on the actual EthanolExamples git repository, and the Cartfile should be updated to:

	```
	github "Fueled/ethanol-ui-components" ~> 0.2
	github "Fueled/ethanol-ui-extensions" "keyboardHelper"
	```

4. Any changes to the EthanolExamples should be committed and pushed to this branch (`keyboardHelper`).  
   Once you're ready to create the PR, run `carthage update --use-submodules --no-build` and commit the results of that command (In a separate commit from the other).

![Summary of where to commit](https://www.dropbox.com/s/b8z8sjlu97b82km/Screenshot%202015-08-14%2013.41.00.png?dl=1)

Once done, you should create a PR for both repositories from your branch (In the example, from `keyboardHelper`) to develop, and your changes will be reviewed and merged later on once all issues has been fixed (if there is any).

### Adding a new dependency

Adding a new dependency into the workspace is non-trivial because of what we suspect is an xcode bug.
For example, let's imagine that the framework `ethanol-social` has not been yet added to the workspace, and because of recent development is ready to be included in the workspace (This will work for every dependencies found on github and added via Carthage, not only for Ethanol).

##### Add it via Carthage

1. Add `ethanol-social` into the Cartfile. For example, the result will be:

	```
	# <Current dependencies...>
	github "Fueled/ethanol-social" ~> 0.1
	```

2. Run `carthage update --use-submodules --no-build`
   This will create a new folder in the relative directory `Carthage/Checkouts` called `ethanol-social`

##### Add it into the workspace

1. Locate the .xcodeproj package from `ethanol-social`:  
   ![ethanol-social .xcodeproj package](https://www.dropbox.com/s/e79f4b8lx3m961r/Screenshot%202015-09-08%2007.48.32.png?dl=1)  
   Drag and drop it into the workspace:  
   ![result](https://www.dropbox.com/s/uuiyjo1ivkv5gf3/Screenshot%202015-09-08%2007.49.32.png?dl=1)
   
2. Open the workspace `EthanolExamples.xcworkspace`, and go to the `Link Binary with Libraries` build phase for the EthanolExamples target. To do so, first click on `EthanolExamples` project, then click on the target `EthanolExamples`, go to `Build Phases`, and finally expand `Link Binary with Libraries`.  
      ![Build Phases](https://www.dropbox.com/s/8v4f3nb32qbftxx/Screenshot%202015-09-08%2007.58.53.png?dl=1)  
   From there, click the "+" button at the bottom and select the framework from the dependency you're adding (In our case, `EthanolSocial.framework`):  
   ![Add framework](https://www.dropbox.com/s/i7bcb3bhl7g6ii4/Screenshot%202015-09-08%2008.00.43.png?dl=1)  
   _Note that if xcode was properly setting this up, there would be no need for step #4 and #5._
   
3. We then need to update the `Carthage Copy Frameworks` build phase so that the new framework is properly copied where it should be when running the project. To do so, just exapnd the phase, and then click the "+" button to add the line `$(BUILT_PRODUCTS_DIR)/<Your framework name>` (In our case, it becomes `$(BUILT_PRODUCTS_DIR)/EthanolSocial.framework`)  
   ![Carthage Copy Frameworks](https://www.dropbox.com/s/lgw4800dn67j3zj/Screenshot%202015-09-08%2008.10.29.png?dl=1)  
   
4. Now, we need to edit the project file so that everything works for other people when they fetch it later on. Do to so, first right-click on `EthanolExample` in the workspace and click on `Show in Finder`  
   ![Show in finder](https://www.dropbox.com/s/74cffcn1yp0bhbt/Screenshot%202015-09-08%2007.55.19.png?dl=1)  
   From the finder window that shows up, right-click on the `EthanolExamples.xcodeproj` and click on `Show Package Contents`.  
   ![Show Package Contents](https://www.dropbox.com/s/luen91fodyjkvv6/Screenshot%202015-09-08%2007.54.44.png?dl=1)  
   From then, locate the file `project.pbxproj` and open it with your favorite text editor.  
   ![project.pbxproj](https://www.dropbox.com/s/4819nv3mchdiu6v/Screenshot%202015-09-08%2007.56.50.png?dl=1)
   
5. Search for the framework you added on step #2 (In our case, `EthanolSocial.framework`). After a few hits, you should find a line that looks like this one:  

	```
	F43F75DA1B9F05C200954745 /* EthanolSocial.framework */ = {isa = PBXFileReference; lastKnownFileType = wrapper.framework; name = EthanolSocial.framework; path = "../ethanol-social/build/Debug-iphoneos/EthanolSocial.framework"; sourceTree = "<group>"; };
	```

   See that ugly `path` reference? That's what we're going to fix. What's happening here is that xcode has found our framework but wants to us the result as if it was created via `carthage build`, which is not what we want, since we want to build it with xcode directly.  
   In order to fix it, we need to tell xcode to find the framework into the build directory for the current workspace (As everything built as part of the workspace goes into the same folder). This folder changes for every project/workspace, and is indicated by the xcodebuild environment variable `BUILT_PRODUCTS_DIR`.
   What we need to do then is this: change `sourceTree` so that it's relative to `BUILT_PRODUCTS_DIR`, and change the path so it's just the name of the framework. In our example, the line becomes:

	```
	F43F75DA1B9F05C200954745 /* EthanolSocial.framework */ = {isa = PBXFileReference; lastKnownFileType = wrapper.framework; name = EthanolSocial.framework; path = EthanolSocial.framework; sourceTree = BUILT_PRODUCTS_DIR; };
	```

   You can then save the file and the project should run and compile fine.





