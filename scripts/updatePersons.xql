xquery version "3.1";

declare default element namespace "http://www.music-encoding.org/ns/mei";
declare namespace uuid = "java:java.util.UUID";
declare namespace mei = "http://www.music-encoding.org/ns/mei";

import module namespace functx = "http://www.functx.com" at "../../baudiResources/libraries/functx.xqm";

declare option saxon:output "method=xml";
declare option saxon:output "media-type=text/xml";
declare option saxon:output "omit-xml-declaration=no";
declare option saxon:output "indent=yes";
declare option saxon:output "saxon:line-length=10000";

<persons>{
        let $coll := collection('../persons?select=*.xml;recurse=yes')
        
        for $file in $coll
        let $file := doc(document-uri($file))
        return
            $file/node()
    }</persons>
