xquery version "3.1";

declare namespace mei = "http://www.music-encoding.org/ns/mei";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
import module namespace functx = "http://www.functx.com" at "../../baudiResources/data/libraries/functx.xqm";

declare option saxon:output "method=xml";
declare option saxon:output "media-type=text/xml";
declare option saxon:output "omit-xml-declaration=no";
declare option saxon:output "indent=yes";
declare option saxon:output "saxon:line-length=10000";

<places>{
(: Aufrufen aller Sammlungen. Der Teil '?select=*xml;recurse=yes' muss stehen bleiben! :)
let $collPlaces := collection('../loci?select=*.xml;recurse=yes')/tei:place
let $dbPlaceNames := $collPlaces/tei:placeName[1]

let $collToAddKeys := collection('../works?select=*xml;recurse=yes')/mei:*

for $document at $n in $collToAddKeys

	let $documentUri := document-uri($document/root())
	let $doc := doc($documentUri)
	let $fileID := $doc/node()/@xml:id

	let $Settlement := $doc//*:settlement[not(@codedval)]
	let $PlaceName := $doc//*:placeName[not(@codedval)]
	let $County := $doc//*:country[not(@codedval)]
	let $Bloc := $doc//*:bloc[not(@codedval)]
	let $Region := $doc//*:region[not(@codedval)]
	let $District := $doc//*:district[not(@codedval)]
	let $GeogName := $doc//*:geogName[not(@codedval)]
	
	let $Elems := $Settlement | $PlaceName | $County | $Bloc | $Region | $District | $GeogName
	
	
	return
	   $Elems
}</places>