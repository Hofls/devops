* If you have a runner with build environment - everything is easy, just run `mvn clean install` during build
    * It should have local maven repository at e.g. `/home/gitlab-runner/.m2/repository/`
* Good example is in `java-dependencies` repo, `test-containers` folder
* Alternative is runner with Docker (build your project in container)
    * Problem - no local cache, build have to download dependencies each time
    * Fixes (pick 1):
        * Good. Use mount - [example](mount-for-build)
        * Bad. Create an image for build (with all necessary dependencies), then build inside it - [example](image-for-build)
