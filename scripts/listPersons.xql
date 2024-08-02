xquery version "3.1";

declare namespace mei = "http://www.music-encoding.org/ns/mei";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
import module namespace functx = "http://www.functx.com" at "../../baudiResources/data/libraries/functx.xqm";

declare option saxon:output "method=xml";
declare option saxon:output "media-type=text/xml";
declare option saxon:output "omit-xml-declaration=no";
declare option saxon:output "indent=yes";
declare option saxon:output "saxon:line-length=10000";

<persons>{functx:distinct-deep(
(: Aufrufen aller Sammlungen. Der Teil '?select=*xml;recurse=yes' muss stehen bleiben! :)
let $collPlaces := collection('../persons?select=*.xml;recurse=yes')/tei:person
let $dbPlaceNames := $collPlaces/tei:persName[1]

let $collToAddKeys := (collection('../works?select=*xml;recurse=yes')|collection('../sources/music?select=*xml;recurse=yes'))/mei:*

for $document at $n in $collToAddKeys

	let $documentUri := document-uri($document/root())
	let $doc := doc($documentUri)
	let $fileID := $doc/node()/@xml:id

	let $persNames := $doc//*:persName[not(@codedval)]
	
	return
	   for $persName in $persNames
	       order by $persName
	       return
	           $persName
)}</persons>