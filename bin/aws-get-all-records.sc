#!/usr/bin/env amm
// common imports
import sys.process._
import collection.mutable
import os._
import ammonite.ops._
import ammonite.runtime.tools.GrepResult
import pprint.pprintln

@main
def main(streamName: String, path: os.Path = os.pwd): Unit = {
  println("Start script!!")
  val out:String = s"""aws kinesis describe-stream --stream-name $streamName --output text""".!!
  pprintln(out)
  val linesWithSHARDS = out.split("\\n").map(_.trim).toList
  pprintln(linesWithSHARDS)
  val shardNames = linesWithSHARDS.filter(_.contains("SHARDS\t"))
  pprintln(shardNames)
  val yk = shardNames.map(str => str.split("\\t")(1))
  // get iterator for each shard
  val iterator = yk.map {
    shard => getiterator(streamName, shard)
  }
  pprintln(iterator)
  println("End of script!!")
}

def getiterator(streamName: String, shardName: String ):String = {
  s"""aws kinesis get-shard-iterator --shard-id $shardName --shard-iterator-type TRIM_HORIZON --stream-name $streamName --output text """.!!
}


