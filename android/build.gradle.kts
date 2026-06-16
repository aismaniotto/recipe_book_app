allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// Force all plugin buildscripts to use the project's Kotlin version,
// preventing KGP conflicts with share_plus, device_info_plus, etc.
subprojects {
    project.buildscript.configurations.all {
        resolutionStrategy {
            force("org.jetbrains.kotlin:kotlin-gradle-plugin:2.3.20")
            force("org.jetbrains.kotlin:kotlin-stdlib:2.3.20")
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
