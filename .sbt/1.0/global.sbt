val sonatypeSnapshots = Seq("sonatype-snapshots" at "https://oss.sonatype.org/content/repositories/snapshots")
resolvers ++= sonatypeSnapshots
val medidataJFrogRepo = Seq("JFrog" at "https://mdsol.jfrog.io/mdsol/all-repos-release")
resolvers ++= medidataJFrogRepo

val strategicMonitoringJFrog = Seq("SMJFrog" at "https://mdsol.jfrog.io/mdsol/monitoring-release")

resolvers ++= strategicMonitoringJFrog

//sbt revolver
addCommandAlias("ondebug", "set every reStart/debugSettings:= Some(spray.revolver.DebugSettings(5050, suspend = false))")
addCommandAlias("ondebugsuspend", "set every reStart/debugSettings:= Some(spray.revolver.DebugSettings(5050, suspend = true))")
addCommandAlias("offdebug", "set every reStart/debugSettings := None")

addCommandAlias("downloadSources", "updateClassifiers")

// Bloop
bloopExportJarClassifiers.in(Global) := Some(Set("sources"))


libraryDependencies ++= Seq(
    "org.slf4j"     % "jcl-over-slf4j"          % "1.7.29"
  )

// Acyclic is a Scala compiler plugin to let you prohibit circular dependencies between files
//
// scalacOptions ++= Seq("-P:acyclic:force")
