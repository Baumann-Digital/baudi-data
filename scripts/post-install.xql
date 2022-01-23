xquery version "3.1";

import module namespace xdb="http://exist-db.org/xquery/xmldb";
import module namespace functx="http://www.functx.com";
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare function local:deleteResource($file) {
        let $docUri := document-uri($file)
        let $collUri := functx:substring-before-last($docUri, '/')
        let $resource := functx:substring-after-last($docUri, '/')
        return
            xdb:remove($collUri, $resource)
};

declare function local:cleanDataLetters() {
    let $collLetters := collection('/db/apps/hwh-data/letters')
    
    for $file in $collLetters
        let $test := exists($file//tei:fileDesc/tei:titleStmt/tei:title/@level)
        where $test = false()
        return
            local:deleteResource($file)
};

declare function local:cleanDataPersOrgPlace() {
let $collections := ('persons', 'orgs', 'places')

for $collection in $collections
    let $coll := collection('/db/apps/hwh-data/' || $collection)
    return
        for $file in $coll
            let $test := exists($file[count(.//*[contains(local-name(), 'Name') and @type[.='reg']]) > 1])
            where $test = true()
            return
                local:deleteResource($file)
};

(: clean data that will break WeGA-WebApp :)
(:local:cleanDataLetters(),
local:cleanDataPersOrgPlace()
:)
true()