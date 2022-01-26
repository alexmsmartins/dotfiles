addSbtPlugin("com.github.sbt" % "sbt-cpd" % "2.0.0")
addSbtPlugin("com.orrsella" % "sbt-stats" % "1.0.7")

// Running the application in a forked jvm
addSbtPlugin("io.spray" % "sbt-revolver" % "0.9.1")

// Use a subset of git from inside sbt
addSbtPlugin("com.typesafe.sbt" % "sbt-git" % "1.0.1")

// tiny SBT plugin for running shell actions
addSbtPlugin("com.oradian.sbt" % "sbt-sh" % "0.3.0")

// dependency tree
addSbtPlugin("com.dwijnand" % "sbt-project-graph" % "0.4.0")
// For sbt < 1.3 use:
// addSbtPlugin("net.virtual-void" % "sbt-dependency-graph" % "0.10.0-RC1")
// builtin plugin that replaces sbt-dependency-graph in SBT 1.4.x
addDependencyTreePlugin

// An SBT plugin for making your SBT prompt more awesome
// https://github.com/agemooij/sbt-prompt
addSbtPlugin("com.scalapenos" % "sbt-prompt" % "1.0.2")

// SBT plugin that can check Maven and Ivy repositories for dependency updates
// https://github.com/rtimush/sbt-updates
addSbtPlugin("com.timushev.sbt" % "sbt-updates" % "0.6.1")

// Bloop - https://github.com/scalacenter/bloop
addSbtPlugin("ch.epfl.scala" % "sbt-bloop" % "1.4.11")


// scala3-migrate has been designed to make the migration to scala 3 easier.
// It proposes an incremental approach
addSbtPlugin("ch.epfl.scala" % "sbt-scala3-migrate" % "0.5.0")

// A tool for catching binary incompatibility in Scala
addSbtPlugin("com.typesafe" % "sbt-mima-plugin" % "1.0.1")

// Sbt will start showing `scalac` warnings whenever you run tasks like `compile` or `test`, even if there are no changes in sources
addSbtPlugin("com.timushev.sbt" % "sbt-rewarn" % "0.1.3")

// scala3-migrate has been designed to make the migration to scala 3 easier.
addSbtPlugin("ch.epfl.scala" % "sbt-scala3-migrate" % "0.4.6")
