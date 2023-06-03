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

let $coll := collection('../sources/music/cantatas?select=*.xml;recurse=yes')

for $file in $coll
let $file := doc(document-uri($file)) 

for $annot in $file//mei:annot[.//mei:locus]
    let $locus := '#fol' || $annot/mei:locus/text()
    let $class := $annot/mei:locus/@class/string()
    return
    	(insert node attribute plist {$locus || ' ' || $class} into $annot,
    	 delete node $annot/mei:locus)