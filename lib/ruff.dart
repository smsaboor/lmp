//multiDexEnabled true
//org.gradle.jvmargs=-Xmx1536M
//
//android.useAndroidX=true
//android.enableJetifier=true
//android.enableR8=true

//subprojects {
//project.configurations.all {
//resolutionStrategy.eachDependency { details ->
//if (details.requested.group == 'com.android.support'
//&& !details.requested.name.contains('multidex') ) {
//details.useVersion "27.1.1"
//}
//if (details.requested.group == 'androidx.core'
//&& !details.requested.name.contains('androidx') ) {
//details.useVersion "1.0.1"
//}
//}
//}
//}