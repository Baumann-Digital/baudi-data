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
<orgs>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">»Liederkranz-<settlement codedval="baudi-06-d8892966">Schutterwald</settlement>«</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">»Arion« <settlement>Brooklyn N.-Y.</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">»Sängerbund <settlement codedval="baudi-06-66ecc816">Schwetzingen</settlement>«</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">»<settlement codedval="baudi-06-21978c6c">Berliner</settlement> Liedertafel«</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">»Harmonie Worms«</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Lehrergesangverein <settlement codedval="baudi-06-8cd102e5">Mannheim</settlement>-<settlement codedval="baudi-06-8eb96db4">Ludwigshafen</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Gesangverein »Eintracht« <settlement codedval="baudi-06-aadb800d">Merchingen</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Schneider’schen Chorvereinigung <settlement codedval="baudi-06-98b20dee">Stuttgart</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Gesangverein »Liederhalle <settlement codedval="baudi-06-eda48674">Pforzheim</settlement>«</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Männergesangverein »Nähmaschienenbauer <settlement codedval="baudi-06-084bd83b">Durlach</settlement>«</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">
        <settlement codedval="baudi-06-2222bf73">Erfurter</settlement> Männergesangverein</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">»Sängervereinigung Jahn«, <settlement codedval="baudi-06-3c7883d5">Paderborn</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">»Sängerbund <settlement codedval="baudi-06-be4616fd">Großsachen</settlement>«</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">»Männergesangverein« <settlement codedval="baudi-06-6dc34df3">Kirchheim</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">»Liederkranz <settlement codedval="baudi-06-0e4bc7d0">Bruchsal</settlement>«</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Liederkranz <settlement codedval="baudi-06-98b20dee">Stuttgart</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">»<settlement codedval="baudi-06-ba47e315">Mümling-Gau</settlement>«</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">»Männergesangverein <settlement codedval="baudi-06-16791bb5">Seckenheim</settlement>«</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">»Männergesangverein« <settlement codedval="baudi-06-dbf3e187">Heidelberg-Kirchheim</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">M. G. V. »Eintracht« <settlement codedval="baudi-06-3b89085d">Pforzheim-Brötzingen</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">»Liederkranz <settlement codedval="baudi-06-02bfb7e8">Ötigheim</settlement>«</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">»<settlement codedval="baudi-06-2306bccf">Pforzheimer</settlement> Sängerkranz«</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Bad. Sängerbundes</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Männergesangverein <settlement codedval="baudi-06-8087d350">Müllheim (Baden)</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Männergesangverein »Liederkranz« <settlement codedval="baudi-06-30a688ff">Wehr</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Gesangverein KONKORDIA <settlement codedval="baudi-06-ba166af7">Karlsruhe</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Männergesangverein <settlement codedval="baudi-06-084bd83b">Durlach</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">»Männergesangverein« <settlement codedval="baudi-06-3b89085d">Pforzheim-Brötzingen</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">»Lyra« <settlement codedval="baudi-06-fa48135f">Rintheim</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Männergesangverein »Harmonie« <settlement codedval="baudi-06-b4ddff19">Worms</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Männergesangverein »Sängerbund <settlement codedval="baudi-06-5a7b4905">Mannheim-Käfertal</settlement>«</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">»Gesangverein <settlement codedval="baudi-06-2ef72d49">Teningen</settlement>«</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">
        <settlement codedval="baudi-06-21978c6c">Berliner</settlement> Lehrergesangverein</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Männergesangverein <settlement codedval="baudi-06-5baa36a3">Weiskirchen</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">»<settlement codedval="baudi-06-5580642a">KRAICHGAU</settlement>-SÄNGERBUND«</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">»Liederkranz <settlement codedval="baudi-06-9720d65f">MÜHLBACH</settlement>«</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">M. G. V. »Frohsinn« <settlement>B. Baden</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Gesangverein »EINTRACHT« <settlement codedval="baudi-06-9cd6eb6a">Pirmasens</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Gesangverein Liedertafel <settlement codedval="baudi-06-14ee7fa7">Grünwinkel</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Quartett-Verein »Zwanglos« <settlement codedval="baudi-06-4b135191">Dillingen-Saar</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Gesangverein <settlement codedval="baudi-06-d446d857">Triberg</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Gesangverein Konkordia <settlement codedval="baudi-06-7c57d8b9">Frankfurt a/M-Eschersheim</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei">Solo-Quartett der <settlement codedval="baudi-06-ba166af7">Karlsruher</settlement> »Liederhalle«</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei" xmlns:xlink="http://www.w3.org/1999/xlink">Johann André</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">Badische Landesbibliothek</corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Chormusikverlag Seebold, St. Augustin</corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Männergesangverein <settlement codedval="baudi-06-084bd83b">Durlach</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei" role="printing"/>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei" role="printing">Paris &amp; CO., Berlin Nr [?]</corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei" role="printing">Stich und Druck von C.G.Röder G. m. b. H., Leipzig</corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">»Männergesangverein« <settlement codedval="baudi-06-dbf3e187">Heidelberg-Kirchheim</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Gesangverein Konkordia <settlement codedval="baudi-06-7c57d8b9">Frankfurt a/M-Eschersheim</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei" role="printing">Printed in Germany</corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei" role="printing">Stich und Druck der Universitätsdruckerei H. Stürtz A. G., Würzburg</corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">M. G. V. »Frohsinn« <settlement>B. Baden</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">»Arion« <settlement>Brooklyn N.-Y.</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Liederkranz <settlement codedval="baudi-06-98b20dee">Stuttgart</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Gesangverein Liedertafel <settlement codedval="baudi-06-14ee7fa7">Grünwinkel</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Männergesangverein »Harmonie« <settlement codedval="baudi-06-b4ddff19">Worms</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei" xmlns:xlink="http://www.w3.org/1999/xlink">»Sängerbund Hohenbaden«</corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Männergesangverein <settlement codedval="baudi-06-5baa36a3">Weiskirchen</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">
        <settlement codedval="baudi-06-21978c6c">Berliner</settlement> Lehrergesangverein</corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Lehrergesangverein <settlement codedval="baudi-06-8cd102e5">Mannheim</settlement>-<settlement codedval="baudi-06-8eb96db4">Ludwigshafen</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei" role="printing">Stich &amp; Druck von Engelmann &amp; Mühlberg, Leipzig</corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei" role="printing">Berliner Musikalien-Druckerei G.m.b.H. Berlin</corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Gesangverein KONKORDIA <settlement codedval="baudi-06-ba166af7">Karlsruhe</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">
        <settlement codedval="baudi-06-2222bf73">Erfurter</settlement> Männergesangverein</corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Männergesangverein <settlement codedval="baudi-06-8087d350">Müllheim (Baden)</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Männergesangverein »Liederkranz« <settlement codedval="baudi-06-30a688ff">Wehr</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Schneider’schen Chorvereinigung <settlement codedval="baudi-06-98b20dee">Stuttgart</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Gesangverein <settlement codedval="baudi-06-d446d857">Triberg</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei" role="printing">Stich &amp; Druck von Engelmann &amp; Mühlberg in Leipzig</corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">»Männergesangverein« <settlement codedval="baudi-06-3b89085d">Pforzheim-Brötzingen</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Gesangverein »EINTRACHT« <settlement codedval="baudi-06-9cd6eb6a">Pirmasens</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">M. G. V. »Eintracht« <settlement codedval="baudi-06-3b89085d">Pforzheim-Brötzingen</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei" role="printing">Berliner Musikalien-Druckerei G.m.b.H. Berlin S.W.63</corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Gesangverein »Eintracht« <settlement codedval="baudi-06-aadb800d">Merchingen</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">Quartett-Verein »Zwanglos« <settlement codedval="baudi-06-4b135191">Dillingen-Saar</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei" role="printing">Notendruckerei Paris &amp; Co., Verlin N. 58</corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">»Männergesangverein« <settlement codedval="baudi-06-6dc34df3">Kirchheim</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">»Lyra« <settlement codedval="baudi-06-fa48135f">Rintheim</settlement>
    </corpName>
    <corpName xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.music-encoding.org/ns/mei">»Sängervereinigung Jahn«, <settlement codedval="baudi-06-3c7883d5">Paderborn</settlement>
    </corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei" xmlns:xlink="http://www.w3.org/1999/xlink">Chr. Friedrich Vieweg</corpName>
    <corpName xmlns="http://www.music-encoding.org/ns/mei" xmlns:xlink="http://www.w3.org/1999/xlink">C.F.W. Siegel's Musikalienhandlung (R. Linnemann)</corpName>
</orgs>

for $elem in $placesToGenerate//(*:corpName)
    let $uuid := concat('baudi-05-',substring(uuid:randomUUID(),1,8))
    let $placeRecord := <org xmlns="http://www.tei-c.org/ns/1.0" xml:id="{$uuid}">
                            <idno type="gnd"/>
                            <idno type="viaf"/>
                            <orgName>{$elem//text() => string-join(' ') => normalize-space()}</orgName>
                            <location>
                                <placeName type="street">
                                    <num/>
                                </placeName>
                                <settlement type="city"/>
                                <!--<country key="DE"/>-->
                            </location>
                            <note/>
                        </org>

    return
        put($placeRecord,'../institutions/' || $uuid || '.xml')
