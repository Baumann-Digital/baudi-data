xquery version "3.1";

declare namespace mei = "http://www.music-encoding.org/ns/mei";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
import module namespace functx = "http://www.functx.com" at "../../baudiResources/data/libraries/functx.xqm";

declare option saxon:output "method=xml";
declare option saxon:output "media-type=text/xml";
declare option saxon:output "omit-xml-declaration=no";
declare option saxon:output "indent=yes";
declare option saxon:output "saxon:line-length=10000";

let $coll := collection('../institutions?select=*.xml;recurse=yes')/tei:org
let $orgsCleaned := doc('listOrgs.xml')/tei:listOrg/tei:org

for $object in $coll
    let $documentUri := document-uri($object/root())
    let $doc := doc($documentUri)/tei:org
    let $fileID := $doc/@xml:id
    let $orgCleaned := $orgsCleaned[@xml:id = $fileID]
    
    return
        replace node $doc with $orgCleaned