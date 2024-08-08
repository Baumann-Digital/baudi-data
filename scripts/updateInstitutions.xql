xquery version "3.1";

declare namespace mei = "http://www.music-encoding.org/ns/mei";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
import module namespace functx = "http://www.functx.com" at "../../baudiResources/data/libraries/functx.xqm";

declare option saxon:output "method=xml";
declare option saxon:output "media-type=text/xml";
declare option saxon:output "omit-xml-declaration=no";
declare option saxon:output "indent=yes";
declare option saxon:output "saxon:line-length=10000";


(: Aufrufen aller Sammlungen. Der Teil '?select=*xml;recurse=yes' muss stehen bleiben! :)
let $collOrgs := collection('../institutions?select=*.xml;recurse=yes')/tei:org
let $dbOrgNames := $collOrgs/tei:orgName[1]

let $collToAddKeys := (collection('../works?select=*xml;recurse=yes')|collection('../sources/music?select=*xml;recurse=yes'))/mei:*

for $document at $n in $collToAddKeys

	let $documentUri := document-uri($document/root())
	let $doc := doc($documentUri)
	let $fileID := $doc/node()/@xml:id

	let $corpNames := $doc//*:corpName[not(@codedval)]
	
	let $Elems := $corpNames
	
	let $ElemStr := $Elems/text()
	
	
	let $ElemStrMod := for $each in $ElemStr
								return
									$each
									=> replace('\[','')
									=> replace('\]','')
									=> replace('\?','')
									=> replace('\.','')
									=> normalize-space()
									=> lower-case()
	let $ElemStrDist := distinct-values($ElemStrMod)
	
	let $listValuesKeyAssigned := if(count($ElemStrDist) gt 0)
	then(<matches file="{$fileID}">{for $each in $ElemStrDist
									let $key := $dbOrgNames[lower-case(normalize-space(string-join(./text(),' '))) = $each]/ancestor::tei:org/@xml:id/string()
									where count($key) = 1
									order by $each
									return
										element match {
											attribute key {$key},
											attribute file {$fileID},
											$each
										}
										}</matches>)
										else()
										=> functx:distinct-deep()
	
	return
		for $elem in $Elems
			let $elemTextMod := $elem/text() => string-join(' ') => replace('\[','') => replace('\]','') => replace('\?','') => replace('\.','') => normalize-space() => lower-case()
			let $key := $listValuesKeyAssigned//match[./text() = $elemTextMod]/@key/string()
			where count($key) = 1
			where not($elem/@key)
			return
				insert node attribute codedval {$key} into $elem
(:		$listValuesKeyAssigned:)