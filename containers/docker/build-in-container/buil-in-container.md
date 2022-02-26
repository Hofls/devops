* If you have a runner with build environment - everything is easy, just run `mvn clean install` during build
    * It should have local maven repository at e.g. `/home/gitlab-runner/.m2/repository/`
* Alternative is runner with Docker (build you project in container)
    * Problem - no local cache, build have to download dependencies each time
    * Fix - Create an image for build (with all necessary dependencies), then build inside it 
