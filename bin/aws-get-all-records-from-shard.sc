#!/usr/bin/env amm
// common imports
import sys.process._
import collection.mutable
import os._
import ammonite.ops._
import ammonite.runtime.tools.GrepResult
import pprint.pprintln

@main
def main(streamName: String, shardName: String, path: os.Path = os.pwd): Unit = {
  val out:String = s"""aws kinesis describe-stream --stream-name $streamName --output text""".!!
  pprintln(out)

}
