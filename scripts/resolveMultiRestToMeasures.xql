xquery version "3.1";

declare default element namespace "http://www.music-encoding.org/ns/mei";
declare namespace uuid = "java:java.util.UUID";
declare namespace mei = "http://www.music-encoding.org/ns/mei";

import module namespace functx = "http://www.functx.com" at "../../../BauDi/baudiResources/data/libraries/functx.xqm";


let $file := doc('../sources/music/cantatas/baudi-01-5f9f9f33.xml')

for $multiRest in $file//mei:multiRest
    let $measure := $multiRest/ancestor::mei:measure
    let $measureReg := element {fn:QName("http://www.music-encoding.org/ns/mei", "measure")} {
    												for $attr in $measure/@*
    												return
    													attribute {local-name($attr)} {$attr/data()},
    												element staff{
    													element layer {
    														element mRest{}
    														}
    													}
    												}
    let $newMeasures := for $each at $i in 1 to $multiRest/@num 
    											let $Id := 'measure_' || uuid:randomUUID()
    											let $n := $measure/@n/number() + $i
    											let $label := $measure/@label/number() + $i
    											return
    											element {fn:QName("http://www.music-encoding.org/ns/mei", "measure")} {
    												attribute xml:id {$Id},
    												attribute n {$n},
    												if($measure/@label) then(attribute label {$label}) else(),
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
    	(insert node $multiRest after $measure,
    	delete node $measure)