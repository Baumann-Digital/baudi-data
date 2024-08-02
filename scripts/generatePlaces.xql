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


let $placesToGenerate := <places xmlns="http://www.music-encoding.org/ns/mei">
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Brooklyn N.-Y.</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Schutterwald</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Schwetzingen</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Ludwigshafen</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Merchingen</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Durlach</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Erfurter</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Paderborn</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Großsachen</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Bruchsal</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Mümling-Gau</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Seckenheim</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Pforzheim-Brötzingen</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Ötigheim</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Pforzheimer</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Müllheim (Baden)</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Säckingen</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Wehr</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Rintheim</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Worms</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Mannheim-Käfertal</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Teningen</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Weiskirchen</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">KRAICHGAU</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">MÜHLBACH</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">B. Baden</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Pirmasens</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Grünwinkel</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Dillingen-Saar</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Triberg</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Frankfurt a/M</settlement>
    <settlement xmlns="http://www.music-encoding.org/ns/mei">Frankfurt a/M-Eschersheim</settlement>
    <country xmlns="http://www.music-encoding.org/ns/mei" xmlns:xlink="http://www.w3.org/1999/xlink">Germany</country>
    <settlement xmlns="http://www.music-encoding.org/ns/mei" xmlns:xlink="http://www.w3.org/1999/xlink">Waldsee</settlement>
</places>

for $elem in $placesToGenerate//(*:settlement|*:country)
    let $uuid := concat('baudi-06-',substring(uuid:randomUUID(),1,8))
    let $placeRecord := <place xmlns="http://www.tei-c.org/ns/1.0" xml:id="{$uuid}" type="city" status="proposed">
                           <placeName>{$elem/text()}</placeName>
                           <location>
                               <geo/>
                               <region/>
                               <country key="D"/>
                           </location>
                           <idno type="geonames"/>
                           <note/>
                       </place>
    return
        put($placeRecord,'../loci/' || $uuid || '.xml')
