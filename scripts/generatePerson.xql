xquery version "3.1";

declare namespace mei = "http://www.music-encoding.org/ns/mei";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace uuid = "java:java.util.UUID";
import module namespace functx = "http://www.functx.com" at "../../baudiResources/data/libraries/functx.xqm";

declare option saxon:output "method=xml";
declare option saxon:output "media-type=text/xml";
declare option saxon:output "omit-xml-declaration=no";
declare option saxon:output "indent=yes";
declare option saxon:output "saxon:line-length=10000";


let $placesToGenerate :=
<persons>
    <persName xmlns="http://www.music-encoding.org/ns/mei">N.N.</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei" role="conductor">Herrn Lenz</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">unbekannt, Baumann?</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">[unbekannt]</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei" role="choirMaster">Herrn THEODOR ZIEGLER, <settlement codedval="baudi-06-0d28666e">Karlsruhe - Mühlburg</settlement>
    </persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">Rud. Löwenstein (1+2Str.)</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">unbekannt</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">Aus dem 14. Jhd.</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">A. F. Meyer</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei" role="conductor">Herrn W. Grieser</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">Anton König</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">Fr. Oser</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">volksweise</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">Fr. Kinkel</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">Dräseler Manfred</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">W. Ensinger</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">Inge Karsten</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">Herrn Musikdirektor Kurt Layher-<settlement codedval="baudi-06-80c04255">Säckingen</settlement>
    </persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">August Sturm</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">A. Strodtmann</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">Bibel, Ruth, 1, 16–17</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">Nach einem englischen Text: Child Jesus</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei" role="conductor">Herrn Karl Schmidt</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">R. Otto</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">Herman Dold</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei" role="conductor">Herrn N. Barth</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">Maria Lillig</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei"/>
    <persName xmlns="http://www.music-encoding.org/ns/mei">Alter Text</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">Volksweise</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">Ehrenfried Liebich?</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">S. Dellevie</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei">[Unbekannt]</persName>
    <tei:persName xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.music-encoding.org/ns/mei" xmlns:xlink="http://www.w3.org/1999/xlink"/>
    <persName xmlns="http://www.music-encoding.org/ns/mei" xmlns:xlink="http://www.w3.org/1999/xlink">wer</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei" xmlns:xlink="http://www.w3.org/1999/xlink">
        <ref target="baudi-04-1d680f20.xml#dried">Dennis Ried</ref>
    </persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei" xmlns:xlink="http://www.w3.org/1999/xlink">[unbekannt] LB(RISM)</persName>
    <persName xmlns="http://www.music-encoding.org/ns/mei" xmlns:xlink="http://www.w3.org/1999/xlink">Karl Lahn</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Dr. Goy</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Grimme</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Prof. Kemmer</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Rech. Rat Höllischer</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Rech. Rat Müller</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Jul. Gersdorff</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">A. Thielert</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">unbekannt, 18. Jahrhundert</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei" role="conductor">Herrn Musikdirektor HEINRICH GRASS</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">M. Schneider</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Fritz Eifler</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">F. W. Weber</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">T. Resa</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei" role="conductor">Herrn Hauptlehrer A. Maier</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Rob. Reinick</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei" role="conductor">Herrn Professor Wilhelm Rinkens</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Herrn Musikdirektor Kurt Layher-<settlement codedval="baudi-06-80c04255">Säckingen</settlement>
    </persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Egon v. Waldow</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei" role="choirMaster">Herrn THEODOR ZIEGLER, <settlement codedval="baudi-06-0d28666e">Karlsruhe - Mühlburg</settlement>
    </persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">M. Martin</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">E. Höfer</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">K. Bulcke</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">aus dem 14. Jhd.</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei" role="chairman">Herrn Postverwalter Wilhelm Mayer</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">C. Sieveking</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei" role="chairman">Herrn Albert Hamminger</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Hans Willy Mertens</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">A. Klauwell</persName>
    <persName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei" role="conductor">Herrn Gesangspädagogen Herbold</persName>
</persons>

for $elem in $placesToGenerate//(*:persName)
    let $uuid := concat('baudi-04-',substring(uuid:randomUUID(),1,8))
    let $placeRecord := <person xmlns="http://www.tei-c.org/ns/1.0" xml:id="{$uuid}" status="proposed">
                             <persName>{$elem/text()}</persName>
                             <birth/>
                             <death/>
                             <faith key="unknown"/>
                             <education/>
                             <sex type="unknown"/>
                             <!--<nationality key="de"/>-->
                             <occupation/>
                             <affiliation/>
                             <idno type="gnd"/>
                             <idno type="viaf"/>
                             <note/>
                         </person>
    return
        put($placeRecord,'../persons/' || $uuid || '.xml')
