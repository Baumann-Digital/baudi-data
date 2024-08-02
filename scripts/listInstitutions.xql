xquery version "3.1";

declare namespace mei = "http://www.music-encoding.org/ns/mei";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
import module namespace functx = "http://www.functx.com" at "../../baudiResources/data/libraries/functx.xqm";

declare option saxon:output "method=xml";
declare option saxon:output "media-type=text/xml";
declare option saxon:output "omit-xml-declaration=no";
declare option saxon:output "indent=yes";
declare option saxon:output "saxon:line-length=10000";

<orgs>{functx:distinct-deep(
(: Aufrufen aller Sammlungen. Der Teil '?select=*xml;recurse=yes' muss stehen bleiben! :)
let $collPlaces := collection('../institutions?select=*.xml;recurse=yes')/tei:org
let $dbPlaceNames := $collPlaces/tei:orgName[1]

let $collToAddKeys := (collection('../works?select=*xml;recurse=yes')|collection('../sources/music?select=*xml;recurse=yes'))/mei:*

for $document at $n in $collToAddKeys

	let $documentUri := document-uri($document/root())
	let $doc := doc($documentUri)
	let $fileID := $doc/node()/@xml:id

	let $corpNames := $doc//*:corpName[not(@codedval)]
	
	return
	   for $corpName in $corpNames
	       order by $corpName
	       return
	           $corpName
)}</orgs>