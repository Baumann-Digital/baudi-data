xquery version "3.1";

declare default element namespace "http://www.music-encoding.org/ns/mei";
declare namespace uuid = "java:java.util.UUID";
declare namespace mei = "http://www.music-encoding.org/ns/mei";

import module namespace functx = "http://www.functx.com" at "../../../BauDi/baudiResources/libraries/functx.xqm";

declare option saxon:output "method=xml";
declare option saxon:output "media-type=text/xml";
declare option saxon:output "omit-xml-declaration=no";
declare option saxon:output "indent=yes";
declare option saxon:output "saxon:line-length=10000";

declare function local:transformHandList1($handList1, $handList2) {
    for $hand in $handList1/mei:hand
        let $handLabelTokens := tokenize($hand/@label,' ')
        let $handLabelType := subsequence(tokenize($hand/@label,' '),3,1)
        let $handLabelType := switch ($handLabelType)
                                    case 'BiblVermerk' return 'biblNote'
                                    case 'Schlussvermerk' return 'closingNote'
                                    case 'AuffVermerk' return 'perfNote'
                                    default return $handLabelType
        let $handMedium := $hand/@medium
        let $handMedium := switch ($handMedium)
                                    case 'Bleistift' return 'pencil'
                                    case 'Tinte' return 'ink'
                                    case 'TinteBlau' return 'inkBlue'
                                    case 'TinteSchwarz' return 'inkBlack'
                                    case 'FarbstiftBlau' return 'pencilBlue'
                                    case 'BundstiftBlau' return 'pencilBlue'
                                    case 'BundstiftViolett' return 'pencilViolet'
                                    default return $handMedium
        let $handID := $handList2//mei:hand[@type=$handLabelType and @medium=$handMedium]/@xml:id/string()
        let $type := $handLabelType
        let $place := if($handLabelTokens[matches(.,'^[NESW]{1,3}$')]) then($handLabelTokens[matches(.,'^[NESW]{1,3}$')] || '-oriented') else()
        let $folio := $handLabelTokens[matches(.,'\d(r|v)')]
        let $plist := string-join(($type,$place,$folio),' ')
        where $hand/data()
        where $handID != ''
        return
            <annot xmlns="http://www.music-encoding.org/ns/mei" xmlns:xlink="http://www.w3.org/1999/xlink" plist="{$plist}" corresp="#{$handID}">{$hand/data()}</annot>
};

declare function local:transformHandList2($handList1, $handList2) {

};

let $coll := collection('../sources/music?select=*.xml;recurse=yes')[count(.//mei:handList) gt 1]

for $file in $coll
    let $file := doc(document-uri($file))//mei:mei
    let $fileID := $file/@xml:id
    let $handList1 := $file//mei:handList[1]
    let $handList2 := $file//mei:handList[2]
    let $handList1Transformed := local:transformHandList1($handList1, $handList2)
    let $handList2Transformed := local:transformHandList2($handList1, $handList2)
    
    return
        (for $annot in $handList1Transformed
            return
                insert node $annot as last into $file//mei:manifestation/mei:notesStmt,
        delete node $handList1)
