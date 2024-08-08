xquery version "3.1";

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace mei = "http://www.music-encoding.org/ns/mei";
(:import module namespace functx = "http://www.functx.com" at "../../baudiResources/libraries/functx.xqm";:)
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace saxon = "http://saxon.sf.net/";

declare option saxon:output "method=xml";
declare option saxon:output "media-type=text/xml";
declare option saxon:output "omit-xml-declaration=no";
declare option saxon:output "indent=yes";
declare option saxon:output "saxon:line-length=10000";


let $collection := (collection('../works?select=*.xml;recurse=yes')|collection('../sources/music?select=*.xml;recurse=yes'))/mei:*
let $list := doc('listOrgs.xml')/tei:listOrg

for $doc in $collection
    let $doc := doc(document-uri($doc/root()))
    let $names := $doc//mei:corpName[@codedval]
        for $name in $names
            let $key := $name/@codedval
            let $object := $list/tei:org[@xml:id=$key]
            let $objectKeyNew := $object/@sameAs
            let $keyNew := if($objectKeyNew)
                           then(replace($key, string($key), string($objectKeyNew)))
                           else($key)
            return
                replace value of node $key with $keyNew
