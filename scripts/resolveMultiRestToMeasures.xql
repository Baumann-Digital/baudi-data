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

for $multiRest at $z in $file//mei:multiRest
    let $measure := $multiRest/ancestor::mei:measure
    let $iterations := count($file//mei:multiRest)
    let $measureFacs := $measure/@facs
    let $measureReg := element {fn:QName("http://www.music-encoding.org/ns/mei", "measure")} {
    												for $attr in $measure/@*[not(local-name(.) = "id")]
    												return
    													attribute {local-name($attr)} {$attr/data()},
    													attribute xml:id {$measure/@*[local-name(.) = "id"]/data()},
    												element staff{
    													element layer {
    														element mRest{}
    														}
    													}
    												}
    let $newMeasures := for $each at $i in 1 to xs:integer($multiRest/@num/number() - 1)
    											let $Id := 'measure_' || uuid:randomUUID()
    											let $n := $measure/@n/number() + $i
    											let $label := $measure/@label/number() + $i
    											return
    											element {fn:QName("http://www.music-encoding.org/ns/mei", "measure")} {
    												attribute xml:id {$Id},
    												attribute n {$n},
    												if($measure/@label) then(attribute label {$label}) else(),
    												attribute facs {$measureFacs},
    												element staff{
    													element layer {
    														element mRest{}
    														}
    													}
    												}
    let $multiRestResolved := element {fn:QName("http://www.music-encoding.org/ns/mei", "reg")} {
														    	$measureReg,
														    	$newMeasures
														    }
    return
    	(insert node $multiRestResolved after $measure,
    	 delete node $measure,
    	 if($z = $iterations)
    	 then(for $mdiv in $file//mei:mdiv
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
    	 			)
    	 else()
    	 )