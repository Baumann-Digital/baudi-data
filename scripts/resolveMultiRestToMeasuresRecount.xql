xquery version "3.1";

declare default element namespace "http://www.music-encoding.org/ns/mei";
declare namespace uuid = "java:java.util.UUID";
declare namespace mei = "http://www.music-encoding.org/ns/mei";

import module namespace functx = "http://www.functx.com" at "../../../BauDi/baudiResources/data/libraries/functx.xqm";

declare option saxon:output "method=xml";
declare option saxon:output "media-type=text/xml";
declare option saxon:output "omit-xml-declaration=no";
declare option saxon:output "indent=yes";
declare option saxon:output "saxon:line-length=10000";

let $file := doc('../sources/music/cantatas/baudi-01-5f9f9f33.xml')

for $mdiv in $file//mei:mdiv
   return
     if($mdiv//mei:part)
     then(
     			for $part in $mdiv//mei:part
          	for $each at $n in $part//mei:measure
     				return
     					replace value of node $each/@n with $n
     			)
     else(
     	for $each at $n in $mdiv//mei:measure
     		return
     			replace value of node $each/@n with $n)