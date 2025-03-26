import org.gradle.api.tasks.Delete

plugins {
    id("com.android.application") version "8.7.0" apply false
    id("com.google.gms.google-services") version "4.3.10" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    buildDir = File(rootProject.buildDir, name)
    evaluationDependsOn(":app")
}

tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}
