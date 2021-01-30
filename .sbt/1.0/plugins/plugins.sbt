addSbtPlugin("com.github.sbt" % "sbt-cpd" % "2.0.0")
addSbtPlugin("com.orrsella" % "sbt-stats" % "1.0.7")

// Running the application in a forked jvm
addSbtPlugin("io.spray" % "sbt-revolver" % "0.9.1")

// Use a subset of git from inside sbt
addSbtPlugin("com.typesafe.sbt" % "sbt-git" % "1.0.0")

// tiny SBT plugin for running shell actions
addSbtPlugin("com.oradian.sbt" % "sbt-sh" % "0.3.0")

// dependency tree
addSbtPlugin("net.virtual-void" % "sbt-dependency-graph" % "0.10.0-RC1")

// An SBT plugin for making your SBT prompt more awesome
// https://github.com/agemooij/sbt-prompt
addSbtPlugin("com.scalapenos" % "sbt-prompt" % "1.0.2")

// SBT plugin that can check Maven and Ivy repositories for dependency updates
// https://github.com/rtimush/sbt-updates
addSbtPlugin("com.timushev.sbt" % "sbt-updates" % "0.5.1")

// Bloop - https://github.com/scalacenter/bloop
addSbtPlugin("ch.epfl.scala" % "sbt-bloop" % "1.4.6")

// A tool for catching binary incompatibility in Scala
addSbtPlugin("com.typesafe" % "sbt-mima-plugin" % "0.8.0")

// Sbt will start showing `scalac` warnings whenever you run tasks like `compile` or `test`, even if there are no changes in sources
// addSbtPlugin("com.timushev.sbt" % "sbt-rewarn" % "0.1.2")
