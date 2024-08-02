xquery version "3.1";

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace mei="http://www.music-encoding.org/ns/mei";

declare option saxon:output "method=xml";
declare option saxon:output "media-type=text/xml";
declare option saxon:output "omit-xml-declaration=no";
declare option saxon:output "indent=yes";
declare option saxon:output "saxon:line-length=10000";


let $collection := collection('../persons?select=*.xml;recurse=yes')
let $list := doc('../personsColl.xml')/tei:persons

for $document in $collection
    let $doc := doc(document-uri($document))/tei:person
    let $docID := $doc/@xml:id
    let $person := $list/tei:person[@id=$docID]
    let $persNameOld := $doc/tei:persName[1]
    let $persNameNew := $person/tei:persName[1]
    
    return
        if($person/@sameAs)
        then()
        else(replace node $persNameOld with $persNameNew)
        