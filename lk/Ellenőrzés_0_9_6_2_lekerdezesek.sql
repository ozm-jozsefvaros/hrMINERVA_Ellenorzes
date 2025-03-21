#/#/#/
20241001OrvosiAlkalmassági1
#/#/
SELECT [20241001OrvosiAlkalmassági].Főosztály, [20241001OrvosiAlkalmassági].Osztály, [20241001OrvosiAlkalmassági].[TAJ szám], IIf([Orvosi vizsgálat időpontja]<>dtÁtal([Dátum]) And Not IsNull([Dátum]),dtÁtal([Dátum]),[20241001OrvosiAlkalmassági].[Orvosi vizsgálat következő időpontja]) AS Következő, IIf(IsNull([Következő]),"2501",IIf(Right(0 & Year([Következő]),2) & Right(0 & Month([Következő]),2)<"2411","25" & Right(0 & Month([Következő]),2),Right(0 & Year([Következő]),2) & Right(0 & Month([Következő]),2))) AS ÉvHó_
FROM [tOrvosiAlkalmasságiVizsgálatok202310-202408Összefűzött] RIGHT JOIN 20241001OrvosiAlkalmassági ON [tOrvosiAlkalmasságiVizsgálatok202310-202408Összefűzött].TAJ = [20241001OrvosiAlkalmassági].[TAJ szám]
WHERE ((([20241001OrvosiAlkalmassági].[TAJ szám]) Is Not Null));

#/#/#/
20241001OrvosiAlkalmassági2a
#/#/
SELECT [20241001OrvosiAlkalmassági1].Főosztály, [20241001OrvosiAlkalmassági1].Osztály, [20241001OrvosiAlkalmassági1].[TAJ szám], [20241001OrvosiAlkalmassági1].évhó_ AS ÉvHó
FROM 20241001OrvosiAlkalmassági1
WHERE ((([20241001OrvosiAlkalmassági1].évhó_) Between "2411" And "2602"));

#/#/#/
20241001OrvosiAlkalmassági2b
#/#/
SELECT [20241001OrvosiAlkalmassági1].Főosztály, [20241001OrvosiAlkalmassági1].Osztály, [20241001OrvosiAlkalmassági1].[TAJ szám], ([ÉVHÓ_]*1+100) & "" AS ÉvHó
FROM 20241001OrvosiAlkalmassági1;

#/#/#/
20241001OrvosiAlkalmassági3
#/#/
TRANSFORM Count([24_26].TAJ) AS [SumOfTAJ szám]
SELECT 1 AS Sor, [24_26].Szervezet
FROM (SELECT [Főosztály] &" "& [Osztály] AS Szervezet, ([TAJ szám]) as Taj, ÉvHó
FROM 20241001OrvosiAlkalmassági2b

UNION SELECT [Főosztály] &" "& [Osztály] AS Szervezet, ([TAJ szám]) as Taj, ÉvHó
FROM 20241001OrvosiAlkalmassági2a
)  AS 24_26
WHERE ((([24_26].ÉvHó) Between "2411" And "2602"))
GROUP BY 1, [24_26].Szervezet
PIVOT [24_26].ÉvHó;

#/#/#/
20241001OrvosiAlkalmassági3Mindösszesen
#/#/
SELECT Count([24_26].[TAJ szám]) AS [CountOfTAJ szám]
FROM (SELECT [Főosztály] & [Osztály] AS Szervezet, [TAJ szám], ÉvHó
FROM 20241001OrvosiAlkalmassági2b
UNION SELECT [Főosztály] & [Osztály] AS Szervezet, [TAJ szám], ÉvHó
FROM 20241001OrvosiAlkalmassági2a)  AS 24_26
WHERE ((([24_26].ÉvHó) Between "2411" And "2602"))
GROUP BY 2;

#/#/#/
20241001OrvosiAlkalmassági3ÖsszegOszlop
#/#/
TRANSFORM Count([24_26].[TAJ szám]) AS [CountOfTAJ szám]
SELECT [24_26].Szervezet
FROM (SELECT [Főosztály] &" " & [Osztály] AS Szervezet, [TAJ szám], ÉvHó
FROM 20241001OrvosiAlkalmassági2b
UNION SELECT [Főosztály] & " " & [Osztály] AS Szervezet, [TAJ szám], ÉvHó
FROM 20241001OrvosiAlkalmassági2a)  AS 24_26
WHERE ((([24_26].ÉvHó) Between "2411" And "2602"))
GROUP BY 1, [24_26].Szervezet
PIVOT "Összesen";

#/#/#/
20241001OrvosiAlkalmassági3Összegoszloppal
#/#/
SELECT [20241001OrvosiAlkalmassági3].Sor, [20241001OrvosiAlkalmassági3].Szervezet, [20241001OrvosiAlkalmassági3].[2411] AS 2411, [20241001OrvosiAlkalmassági3].[2412] AS 2412, [20241001OrvosiAlkalmassági3].[2501] AS 2501, [20241001OrvosiAlkalmassági3].[2502] AS 2502, [20241001OrvosiAlkalmassági3].[2503] AS 2503, [20241001OrvosiAlkalmassági3].[2504] AS 2504, [20241001OrvosiAlkalmassági3].[2505] AS 2505, [20241001OrvosiAlkalmassági3].[2506] AS 2506, [20241001OrvosiAlkalmassági3].[2507] AS 2507, [20241001OrvosiAlkalmassági3].[2508] AS 2508, [20241001OrvosiAlkalmassági3].[2509] AS 2509, [20241001OrvosiAlkalmassági3].[2510] AS 2510, [20241001OrvosiAlkalmassági3].[2511] AS 2511, [20241001OrvosiAlkalmassági3].[2512] AS 2512, [20241001OrvosiAlkalmassági3].[2601] AS 2601, [20241001OrvosiAlkalmassági3].[2602] AS 2602, [20241001OrvosiAlkalmassági3ÖsszegOszlop].Összesen AS Összesen
FROM 20241001OrvosiAlkalmassági3 INNER JOIN 20241001OrvosiAlkalmassági3ÖsszegOszlop ON [20241001OrvosiAlkalmassági3].Szervezet = [20241001OrvosiAlkalmassági3ÖsszegOszlop].Szervezet;

#/#/#/
20241001OrvosiAlkalmassági3összegsor
#/#/
TRANSFORM Count([24_26].[TAJ szám]) AS [CountOfTAJ szám]
SELECT 2 AS Sor, "Hivatal összesen:" AS Szervezet
FROM (SELECT [Főosztály] & [Osztály] AS Szervezet, [TAJ szám], ÉvHó
FROM 20241001OrvosiAlkalmassági2b
UNION SELECT [Főosztály] & [Osztály] AS Szervezet, [TAJ szám], ÉvHó
FROM 20241001OrvosiAlkalmassági2a)  AS 24_26
WHERE ((([24_26].ÉvHó) Between "2411" And "2602"))
GROUP BY 2, "Hivatal összesen:"
PIVOT [24_26].ÉvHó;

#/#/#/
20241001OrvosiAlkalmassági3összegsorMindösszesennel
#/#/
SELECT [20241001OrvosiAlkalmassági3összegsor].*, [20241001OrvosiAlkalmassági3Mindösszesen].[CountOfTAJ szám]
FROM 20241001OrvosiAlkalmassági3összegsor, 20241001OrvosiAlkalmassági3Mindösszesen;

#/#/#/
20241001OrvosiAlkalmassági4
#/#/
SELECT [20241001OrvosiAlkalmassági3Összegoszloppal].*
FROM  20241001OrvosiAlkalmassági3Összegoszloppal
UNION SELECT  [20241001OrvosiAlkalmassági3összegsorMindösszesennel].*
FROM 20241001OrvosiAlkalmassági3összegsorMindösszesennel;

#/#/#/
25_életévüket_betöltők
#/#/
SELECT lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Születési idő], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Kerekített 100 %-os illetmény (eltérítés nélküli)] AS Illetmény, lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS [Belépés dátuma]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Születési idő]) Between #1/1/1999# And #12/31/1999#) AND ((lkSzemélyek.[Státusz neve])="álláshely"));

#/#/#/
aaaExcelbe
#/#/
SELECT lkSzemélyek.*
FROM lkSzemélyek;

#/#/#/
alkSzemélyek_csak_az_utolsó_előfordulások
#/#/
SELECT lkSzemélyek.Adójel, Max(lkSzemélyek.[Jogviszony sorszáma]) AS [MaxOfJogviszony sorszáma], Max(lkSzemélyek.[Jogviszony kezdete (belépés dátuma)]) AS [MaxOfJogviszony kezdete (belépés dátuma)], First(lkSzemélyek.Azonosító) AS azSzemély
FROM lkSzemélyek
GROUP BY lkSzemélyek.Adójel
ORDER BY lkSzemélyek.Adójel, Max(lkSzemélyek.[Jogviszony sorszáma]) DESC , Max(lkSzemélyek.[Jogviszony kezdete (belépés dátuma)]) DESC;

#/#/#/
Álláshely_Jel
#/#/
SELECT lkÁlláshelyek.[Álláshely azonosító], lkÁlláshelyek.jel
FROM lkÁlláshelyek;

#/#/#/
Címek_összevetése
#/#/
SELECT tTelephelyek.Mező1 AS Főosztály, tTelephelyek.[Szervezeti egység], lkSzemélyek.[Szint 5 szervezeti egység név], lkSzemélyek.[Dolgozó teljes neve], tTelephelyek.Cím, lkSzemélyek.[Munkavégzés helye - cím], Left([Cím],4) AS Kif1, Left([Munkavégzés helye - cím],4) AS Kif1
FROM lkSzemélyek LEFT JOIN tTelephelyek ON lkSzemélyek.[Szervezeti egység kódja] = tTelephelyek.SzervezetKód
WHERE (((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null))
ORDER BY tTelephelyek.[Szervezeti egység];

#/#/#/
ideigllkMobilModulKieg
#/#/
SELECT ideiglMobilModulKieg.[Dolgozó teljes neve], ideiglMobilModulKieg.[Hivatali email], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, kt_azNexon_Adójel02.azNexon
FROM kt_azNexon_Adójel02 RIGHT JOIN (lkSzemélyek RIGHT JOIN ideiglMobilModulKieg ON lkSzemélyek.[Hivatali email] = ideiglMobilModulKieg.[Hivatali email] OR ideiglMobilModulKieg.[Dolgozó teljes neve]=lkSzemélyek.[Dolgozó teljes neve]) ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel;

#/#/#/
kt_azNexon_Adójel
#/#/
SELECT tNexonAzonosítók.Azonosító, tNexonAzonosítók.Név, tNexonAzonosítók.[Személy azonosító] AS azNexon, [tnexonazonosítók].[Adóazonosító jel]*1 AS Adójel, "<a href=""https://nexonport.kh.gov.hu/menu/hrmapp/szemelytorzs/szemelyikarton?szemelyAzonosito=" & [azNexon] & "&r=13"" target=""_blank"">" & [Dolgozó teljes neve] & "</a>" AS NLink, (SELECT COUNT(tnexonazonosítók.Azonosító) 
        FROM tNexonAzonosítók AS Tmp 
        Where (Tmp.Kezdete >= tNexonAzonosítók.Kezdete
        AND Tmp.[Személy azonosító] = tNexonAzonosítók.[Személy azonosító]) AND  Tmp.[Azonosító] > tNexonAzonosítók.[Azonosító]
)+1 AS Sorszám
FROM tNexonAzonosítók INNER JOIN lkSzemélyek ON tNexonAzonosítók.[Adóazonosító jel] = lkSzemélyek.[Adóazonosító jel]
ORDER BY tNexonAzonosítók.Név;

#/#/#/
kt_azNexon_Adójel_ - azonosak keresése
#/#/
SELECT First(kt_azNexon_Adójel.[azNexon]) AS [azNexon Mező], First(kt_azNexon_Adójel.[Adójel]) AS [Adójel Mező], Count(kt_azNexon_Adójel.[azNexon]) AS AzonosakSzáma
FROM kt_azNexon_Adójel
GROUP BY kt_azNexon_Adójel.[azNexon], kt_azNexon_Adójel.[Adójel]
HAVING (((Count([kt_azNexon_Adójel].[azNexon]))>1) AND ((Count([kt_azNexon_Adójel].[Adójel]))>1));

#/#/#/
kt_azNexon_Adójel02
#/#/
SELECT kt_azNexon_Adójel.Azonosító, kt_azNexon_Adójel.Név, kt_azNexon_Adójel.azNexon, kt_azNexon_Adójel.Adójel, kt_azNexon_Adójel.NLink, kt_azNexon_Adójel.Sorszám
FROM kt_azNexon_Adójel
WHERE (((kt_azNexon_Adójel.Sorszám)=1));

#/#/#/
Lekérdezés1
#/#/
SELECT DISTINCT [Álláshely azonosító]
FROM lkÜresÁlláshelyek001
UNION Select DISTINCT lkÜresÁlláshelyek002.[Álláshely azonosító]
FROM lkÜresÁlláshelyek002;

#/#/#/
Lekérdezés10
#/#/
INSERT INTO tSzemélyek IN 'L:\Ugyintezok\Adatszolgáltatók\Adatbázisok\Háttértárak\Ellenőrzés_0.9.6_háttér_.mdb.accdb'
SELECT [tSzemélyek_import].[Adójel] AS Adójel, [tSzemélyek_import].[Dolgozó teljes neve] AS [Dolgozó teljes neve], [tSzemélyek_import].[Dolgozó születési neve] AS [Dolgozó születési neve], [tSzemélyek_import].[Születési idő] AS [Születési idő], [tSzemélyek_import].[Születési hely] AS [Születési hely], [tSzemélyek_import].[Anyja neve] AS [Anyja neve], [tSzemélyek_import].[Neme] AS Neme, [tSzemélyek_import].[Törzsszám] AS Törzsszám, [tSzemélyek_import].[Egyedi azonosító] AS [Egyedi azonosító], [tSzemélyek_import].[Adóazonosító jel] AS [Adóazonosító jel], [tSzemélyek_import].[TAJ szám] AS [TAJ szám], [tSzemélyek_import].[Ügyfélkapu kód] AS [Ügyfélkapu kód], [tSzemélyek_import].[Elsődleges állampolgárság] AS [Elsődleges állampolgárság], [tSzemélyek_import].[Személyi igazolvány száma] AS [Személyi igazolvány száma], [tSzemélyek_import].[Személyi igazolvány érvényesség kezdete] AS [Személyi igazolvány érvényesség kezdete], [tSzemélyek_import].[Személyi igazolvány érvényesség vége] AS [Személyi igazolvány érvényesség vége], [tSzemélyek_import].[Nyelvtudás Angol] AS [Nyelvtudás Angol], [tSzemélyek_import].[Nyelvtudás Arab] AS [Nyelvtudás Arab], [tSzemélyek_import].[Nyelvtudás Bolgár] AS [Nyelvtudás Bolgár], [tSzemélyek_import].[Nyelvtudás Cigány] AS [Nyelvtudás Cigány], [tSzemélyek_import].[Nyelvtudás Cigány (lovári)] AS [Nyelvtudás Cigány (lovári)], [tSzemélyek_import].[Nyelvtudás Cseh] AS [Nyelvtudás Cseh], [tSzemélyek_import].[Nyelvtudás Eszperantó] AS [Nyelvtudás Eszperantó], [tSzemélyek_import].[Nyelvtudás Finn] AS [Nyelvtudás Finn], [tSzemélyek_import].[Nyelvtudás Francia] AS [Nyelvtudás Francia], [tSzemélyek_import].[Nyelvtudás Héber] AS [Nyelvtudás Héber], [tSzemélyek_import].[Nyelvtudás Holland] AS [Nyelvtudás Holland], [tSzemélyek_import].[Nyelvtudás Horvát] AS [Nyelvtudás Horvát], [tSzemélyek_import].[Nyelvtudás Japán] AS [Nyelvtudás Japán], [tSzemélyek_import].[Nyelvtudás Jelnyelv] AS [Nyelvtudás Jelnyelv], [tSzemélyek_import].[Nyelvtudás Kínai] AS [Nyelvtudás Kínai], [tSzemélyek_import].[Nyelvtudás Latin] AS [Nyelvtudás Latin], [tSzemélyek_import].[Nyelvtudás Lengyel] AS [Nyelvtudás Lengyel], [tSzemélyek_import].[Nyelvtudás Német] AS [Nyelvtudás Német], [tSzemélyek_import].[Nyelvtudás Norvég] AS [Nyelvtudás Norvég], [tSzemélyek_import].[Nyelvtudás Olasz] AS [Nyelvtudás Olasz], [tSzemélyek_import].[Nyelvtudás Orosz] AS [Nyelvtudás Orosz], [tSzemélyek_import].[Nyelvtudás Portugál] AS [Nyelvtudás Portugál], [tSzemélyek_import].[Nyelvtudás Román] AS [Nyelvtudás Román], [tSzemélyek_import].[Nyelvtudás Spanyol] AS [Nyelvtudás Spanyol], [tSzemélyek_import].[Nyelvtudás Szerb] AS [Nyelvtudás Szerb], [tSzemélyek_import].[Nyelvtudás Szlovák] AS [Nyelvtudás Szlovák], [tSzemélyek_import].[Nyelvtudás Szlovén] AS [Nyelvtudás Szlovén], [tSzemélyek_import].[Nyelvtudás Török] AS [Nyelvtudás Török], [tSzemélyek_import].[Nyelvtudás Újgörög] AS [Nyelvtudás Újgörög], [tSzemélyek_import].[Nyelvtudás Ukrán] AS [Nyelvtudás Ukrán], [tSzemélyek_import].[Orvosi vizsgálat időpontja] AS [Orvosi vizsgálat időpontja], [tSzemélyek_import].[Orvosi vizsgálat típusa] AS [Orvosi vizsgálat típusa], [tSzemélyek_import].[Orvosi vizsgálat eredménye] AS [Orvosi vizsgálat eredménye], [tSzemélyek_import].[Orvosi vizsgálat észrevételek] AS [Orvosi vizsgálat észrevételek], [tSzemélyek_import].[Orvosi vizsgálat következő időpontja] AS [Orvosi vizsgálat következő időpontja], [tSzemélyek_import].[Erkölcsi bizonyítvány száma] AS [Erkölcsi bizonyítvány száma], [tSzemélyek_import].[Erkölcsi bizonyítvány dátuma] AS [Erkölcsi bizonyítvány dátuma], [tSzemélyek_import].[Erkölcsi bizonyítvány eredménye] AS [Erkölcsi bizonyítvány eredménye], [tSzemélyek_import].[Erkölcsi bizonyítvány kérelem azonosító] AS [Erkölcsi bizonyítvány kérelem azonosító], [tSzemélyek_import].[Erkölcsi bizonyítvány közügyektől eltiltva] AS [Erkölcsi bizonyítvány közügyektől eltiltva], [tSzemélyek_import].[Erkölcsi bizonyítvány járművezetéstől eltiltva] AS [Erkölcsi bizonyítvány járművezetéstől eltiltva], [tSzemélyek_import].[Erkölcsi bizonyítvány intézkedés alatt áll] AS [Erkölcsi bizonyítvány intézkedés alatt áll], [tSzemélyek_import].[Munkaköri leírások (csatolt dokumentumok fájlnevei)] AS [Munkaköri leírások (csatolt dokumentumok fájlnevei)], [tSzemélyek_import].[Egyéb HR dokumentumok (csatolt dokumentumok fájlnevei)] AS [Egyéb HR dokumentumok (csatolt dokumentumok fájlnevei)], [tSzemélyek_import].[Kormányhivatal rövid neve] AS [Kormányhivatal rövid neve], [tSzemélyek_import].[Szervezeti egység kódja] AS [Szervezeti egység kódja], [tSzemélyek_import].[Szervezeti egység neve] AS [Szervezeti egység neve], [tSzemélyek_import].[Szervezeti munkakör neve] AS [Szervezeti munkakör neve], [tSzemélyek_import].[Vezetői megbízás típusa] AS [Vezetői megbízás típusa], [tSzemélyek_import].[Státusz kódja] AS [Státusz kódja], [tSzemélyek_import].[Státusz költséghelyének kódja] AS [Státusz költséghelyének kódja], [tSzemélyek_import].[Státusz költséghelyének neve ] AS [Státusz költséghelyének neve ], [tSzemélyek_import].[Létszámon felül létrehozott státusz] AS [Létszámon felül létrehozott státusz], [tSzemélyek_import].[Státusz típusa] AS [Státusz típusa], [tSzemélyek_import].[Státusz neve] AS [Státusz neve], [tSzemélyek_import].[Többes betöltés] AS [Többes betöltés], [tSzemélyek_import].[Vezető neve] AS [Vezető neve], [tSzemélyek_import].[Vezető adóazonosító jele] AS [Vezető adóazonosító jele], [tSzemélyek_import].[Vezető email címe] AS [Vezető email címe], [tSzemélyek_import].[Állandó lakcím] AS [Állandó lakcím], [tSzemélyek_import].[Tartózkodási lakcím] AS [Tartózkodási lakcím], [tSzemélyek_import].[Levelezési cím_] AS [Levelezési cím_], [tSzemélyek_import].[Öregségi nyugdíj-korhatár elérésének időpontja (dátum)] AS [Öregségi nyugdíj-korhatár elérésének időpontja (dátum)], [tSzemélyek_import].[Nyugdíjas] AS Nyugdíjas, [tSzemélyek_import].[Nyugdíj típusa] AS [Nyugdíj típusa], [tSzemélyek_import].[Nyugdíjas korú továbbfoglalkoztatási engedéllyel rendelkezik] AS [Nyugdíjas korú továbbfoglalkoztatási engedéllyel rendelkezik], [tSzemélyek_import].[Megváltozott munkaképesség] AS [Megváltozott munkaképesség], [tSzemélyek_import].[Önkéntes tartalékos katona] AS [Önkéntes tartalékos katona], [tSzemélyek_import].[Utolsó vagyonnyilatkozat leadásának dátuma] AS [Utolsó vagyonnyilatkozat leadásának dátuma], [tSzemélyek_import].[Vagyonnyilatkozat nyilvántartási száma] AS [Vagyonnyilatkozat nyilvántartási száma], [tSzemélyek_import].[Következő vagyonnyilatkozat esedékessége] AS [Következő vagyonnyilatkozat esedékessége], [tSzemélyek_import].[Nemzetbiztonsági ellenőrzés dátuma] AS [Nemzetbiztonsági ellenőrzés dátuma], [tSzemélyek_import].[Védett állományba tartozó munkakör] AS [Védett állományba tartozó munkakör], [tSzemélyek_import].[Vezetői megbízás típusa1] AS [Vezetői megbízás típusa1], [tSzemélyek_import].[Vezetői beosztás megnevezése] AS [Vezetői beosztás megnevezése], [tSzemélyek_import].[Vezetői beosztás (megbízás) kezdete] AS [Vezetői beosztás (megbízás) kezdete], [tSzemélyek_import].[Vezetői beosztás (megbízás) vége] AS [Vezetői beosztás (megbízás) vége], [tSzemélyek_import].[Iskolai végzettség foka] AS [Iskolai végzettség foka], [tSzemélyek_import].[Iskolai végzettség neve] AS [Iskolai végzettség neve], [tSzemélyek_import].[Alapvizsga kötelezés dátuma] AS [Alapvizsga kötelezés dátuma], [tSzemélyek_import].[Alapvizsga letétel tényleges határideje] AS [Alapvizsga letétel tényleges határideje], [tSzemélyek_import].[Alapvizsga mentesség] AS [Alapvizsga mentesség], [tSzemélyek_import].[Alapvizsga mentesség oka] AS [Alapvizsga mentesség oka], [tSzemélyek_import].[Szakvizsga kötelezés dátuma] AS [Szakvizsga kötelezés dátuma], [tSzemélyek_import].[Szakvizsga letétel tényleges határideje] AS [Szakvizsga letétel tényleges határideje], [tSzemélyek_import].[Szakvizsga mentesség] AS [Szakvizsga mentesség], [tSzemélyek_import].[Foglalkozási viszony] AS [Foglalkozási viszony], [tSzemélyek_import].[Foglalkozási viszony statisztikai besorolása] AS [Foglalkozási viszony statisztikai besorolása], [tSzemélyek_import].[Dolgozó szerződéses/kinevezéses munkaköre / kinevezési okmányban] AS [Dolgozó szerződéses/kinevezéses munkaköre / kinevezési okmányban], [tSzemélyek_import].[Beosztástervezés helyszínek] AS [Beosztástervezés helyszínek], [tSzemélyek_import].[Beosztástervezés tevékenységek] AS [Beosztástervezés tevékenységek], [tSzemélyek_import].[Részleges távmunka szerződés kezdete] AS [Részleges távmunka szerződés kezdete], [tSzemélyek_import].[Részleges távmunka szerződés vége] AS [Részleges távmunka szerződés vége], [tSzemélyek_import].[Részleges távmunka szerződés intervalluma] AS [Részleges távmunka szerződés intervalluma], [tSzemélyek_import].[Részleges távmunka szerződés mértéke] AS [Részleges távmunka szerződés mértéke], [tSzemélyek_import].[Részleges távmunka szerződés helyszíne] AS [Részleges távmunka szerződés helyszíne], [tSzemélyek_import].[Részleges távmunka szerződés helyszíne 2] AS [Részleges távmunka szerződés helyszíne 2], [tSzemélyek_import].[Részleges távmunka szerződés helyszíne 3] AS [Részleges távmunka szerződés helyszíne 3], [tSzemélyek_import].[Egyéni túlóra keret megállapodás kezdete] AS [Egyéni túlóra keret megállapodás kezdete], [tSzemélyek_import].[Egyéni túlóra keret megállapodás vége] AS [Egyéni túlóra keret megállapodás vége], [tSzemélyek_import].[Egyéni túlóra keret megállapodás mértéke] AS [Egyéni túlóra keret megállapodás mértéke], [tSzemélyek_import].[KIRA feladat azonosítója - intézmény prefix-szel ellátva] AS [KIRA feladat azonosítója - intézmény prefix-szel ellátva], [tSzemélyek_import].[KIRA feladat azonosítója] AS [KIRA feladat azonosítója], [tSzemélyek_import].[KIRA feladat megnevezés] AS [KIRA feladat megnevezés], [tSzemélyek_import].[Osztott munkakör] AS [Osztott munkakör], [tSzemélyek_import].[Funkciócsoport: kód-megnevezés] AS [Funkciócsoport: kód-megnevezés], [tSzemélyek_import].[Funkció: kód-megnevezés] AS [Funkció: kód-megnevezés], [tSzemélyek_import].[Dolgozó költséghelyének kódja] AS [Dolgozó költséghelyének kódja], [tSzemélyek_import].[Dolgozó költséghelyének neve] AS [Dolgozó költséghelyének neve], [tSzemélyek_import].[Feladatkör] AS Feladatkör, [tSzemélyek_import].[Elsődleges feladatkör] AS [Elsődleges feladatkör], [tSzemélyek_import].[Feladatok] AS Feladatok, [tSzemélyek_import].[FEOR] AS FEOR, [tSzemélyek_import].[Elméleti (szerződés/kinevezés szerinti) ledolgozandó napi óraker] AS [Elméleti (szerződés/kinevezés szerinti) ledolgozandó napi óraker], [tSzemélyek_import].[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker] AS [Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker], [tSzemélyek_import].[Elméleti (szerződés/kinevezés szerinti) ledolgozandó havi óraker] AS [Elméleti (szerződés/kinevezés szerinti) ledolgozandó havi óraker], [tSzemélyek_import].[Szerződés/Kinevezés típusa] AS [Szerződés/Kinevezés típusa], [tSzemélyek_import].[Iktatószám] AS Iktatószám, [tSzemélyek_import].[Szerződés/kinevezés verzió_érvényesség kezdete] AS [Szerződés/kinevezés verzió_érvényesség kezdete], [tSzemélyek_import].[Szerződés/kinevezés verzió_érvényesség vége] AS [Szerződés/kinevezés verzió_érvényesség vége], [tSzemélyek_import].[Határozott idejű _szerződés/kinevezés lejár] AS [Határozott idejű _szerződés/kinevezés lejár], [tSzemélyek_import].[Szerződés dokumentum (csatolt dokumentumok fájlnevei)] AS [Szerződés dokumentum (csatolt dokumentumok fájlnevei)], [tSzemélyek_import].[Megjegyzés (pl# határozott szerződés/kinevezés oka)] AS [Megjegyzés (pl# határozott szerződés/kinevezés oka)], [tSzemélyek_import].[Munkavégzés helye - megnevezés] AS [Munkavégzés helye - megnevezés], [tSzemélyek_import].[Munkavégzés helye - cím] AS [Munkavégzés helye - cím], [tSzemélyek_import].[Jogviszony típusa / jogviszony típus] AS [Jogviszony típusa / jogviszony típus], [tSzemélyek_import].[Jogviszony sorszáma] AS [Jogviszony sorszáma], [tSzemélyek_import].[KIRA jogviszony jelleg] AS [KIRA jogviszony jelleg], [tSzemélyek_import].[Kölcsönbe adó cég] AS [Kölcsönbe adó cég], [tSzemélyek_import].[Teljesítményértékelés - Értékelő személy] AS [Teljesítményértékelés - Értékelő személy], [tSzemélyek_import].[Teljesítményértékelés - Érvényesség kezdet] AS [Teljesítményértékelés - Érvényesség kezdet], [tSzemélyek_import].[Teljesítményértékelés - Értékelt időszak kezdet] AS [Teljesítményértékelés - Értékelt időszak kezdet], [tSzemélyek_import].[Teljesítményértékelés - Értékelt időszak vége] AS [Teljesítményértékelés - Értékelt időszak vége], [tSzemélyek_import].[Teljesítményértékelés dátuma] AS [Teljesítményértékelés dátuma], [tSzemélyek_import].[Teljesítményértékelés - Beállási százalék] AS [Teljesítményértékelés - Beállási százalék], [tSzemélyek_import].[Teljesítményértékelés - Pontszám] AS [Teljesítményértékelés - Pontszám], [tSzemélyek_import].[Teljesítményértékelés - Megjegyzés] AS [Teljesítményértékelés - Megjegyzés], [tSzemélyek_import].[Dolgozói jellemzők] AS [Dolgozói jellemzők], [tSzemélyek_import].[Fizetési osztály (KA)/ Pedagógusi fokozat (KA pedagógus)/besorol] AS [Fizetési osztály (KA)/ Pedagógusi fokozat (KA pedagógus)/besorol], [tSzemélyek_import].[Besorolási  fokozat (KT)] AS [Besorolási  fokozat (KT)], [tSzemélyek_import].[Jogfolytonos idő kezdete] AS [Jogfolytonos idő kezdete], [tSzemélyek_import].[Jogviszony kezdete (belépés dátuma)] AS [Jogviszony kezdete (belépés dátuma)], [tSzemélyek_import].[Jogviszony vége (kilépés dátuma)] AS [Jogviszony vége (kilépés dátuma)], [tSzemélyek_import].[Utolsó munkában töltött nap] AS [Utolsó munkában töltött nap], [tSzemélyek_import].[Kezdeményezés dátuma] AS [Kezdeményezés dátuma], [tSzemélyek_import].[Hatályossá válik] AS [Hatályossá válik], [tSzemélyek_import].[HR kapcsolat megszűnés módja (Kilépés módja)] AS [HR kapcsolat megszűnés módja (Kilépés módja)], [tSzemélyek_import].[HR kapcsolat megszűnes indoka (Kilépés indoka)] AS [HR kapcsolat megszűnes indoka (Kilépés indoka)], [tSzemélyek_import].[Indokolás] AS Indokolás, [tSzemélyek_import].[Következő munkahely] AS [Következő munkahely], [tSzemélyek_import].[MT: Felmondási idő kezdete KJT, KTTV: Felmentési idő kezdete] AS [MT: Felmondási idő kezdete KJT, KTTV: Felmentési idő kezdete], [tSzemélyek_import].[Felmondási idő vége (MT) Felmentési idő vége (KJT, KTTV)] AS [Felmondási idő vége (MT) Felmentési idő vége (KJT, KTTV)], [tSzemélyek_import].[Munkavégzés alóli mentesítés kezdete (KJT, KTTV) Felmentési idő ] AS [Munkavégzés alóli mentesítés kezdete (KJT, KTTV) Felmentési idő ], [tSzemélyek_import].[Munkavégzés alóli mentesítés vége (KJT, KTTV) Felmentési idő vég] AS [Munkavégzés alóli mentesítés vége (KJT, KTTV) Felmentési idő vég], [tSzemélyek_import].[Átmeneti eltérő foglalkoztatás típusa] AS [Átmeneti eltérő foglalkoztatás típusa], [tSzemélyek_import].[Átmeneti eltérő foglalkoztatás kezdete] AS [Átmeneti eltérő foglalkoztatás kezdete], [tSzemélyek_import].[Tartós távollét típusa] AS [Tartós távollét típusa], [tSzemélyek_import].[Tartós távollét kezdete] AS [Tartós távollét kezdete], [tSzemélyek_import].[Tartós távollét vége] AS [Tartós távollét vége], [tSzemélyek_import].[Tartós távollét tervezett vége] AS [Tartós távollét tervezett vége], [tSzemélyek_import].[Helyettesített dolgozó neve] AS [Helyettesített dolgozó neve], [tSzemélyek_import].[Szerződés/Kinevezés - próbaidő vége] AS [Szerződés/Kinevezés - próbaidő vége], [tSzemélyek_import].[Utalási cím] AS [Utalási cím], [tSzemélyek_import].[Alapilletmény / Munkabér / Megbízási díj (eltérítés nélküli)] AS [Alapilletmény / Munkabér / Megbízási díj (eltérítés nélküli)], [tSzemélyek_import].[Garantált bérminimumra történő kiegészítés] AS [Garantált bérminimumra történő kiegészítés], [tSzemélyek_import].[Kerekítés] AS Kerekítés, [tSzemélyek_import].[Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS % (eltérít] AS [Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS % (eltérít], [tSzemélyek_import].[Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS összeg (el] AS [Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS összeg (el], [tSzemélyek_import].[Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY % (eltérítés nélküli)] AS [Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY % (eltérítés nélküli)], [tSzemélyek_import].[Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY összeg (eltérítés nél] AS [Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY összeg (eltérítés nél], [tSzemélyek_import].[Egyéb pótlék - összeg (eltérítés nélküli)] AS [Egyéb pótlék - összeg (eltérítés nélküli)], [tSzemélyek_import].[Illetmény összesen kerekítés nélkül (eltérítés nélküli)] AS [Illetmény összesen kerekítés nélkül (eltérítés nélküli)], [tSzemélyek_import].[Kerekített 100 %-os illetmény (eltérítés nélküli)] AS [Kerekített 100 %-os illetmény (eltérítés nélküli)], [tSzemélyek_import].[Eltérítés %] AS [Eltérítés %], [tSzemélyek_import].[Alapilletmény / Munkabér / Megbízási díj (eltérített)] AS [Alapilletmény / Munkabér / Megbízási díj (eltérített)], [tSzemélyek_import].[Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS % (eltérí1] AS [Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS % (eltérí1], [tSzemélyek_import].[Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS összeg (e1] AS [Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS összeg (e1], [tSzemélyek_import].[Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY % (eltérített)] AS [Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY % (eltérített)], [tSzemélyek_import].[Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY összeg (eltérített)] AS [Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY összeg (eltérített)], [tSzemélyek_import].[Egyéb pótlék - összeg (eltérített)] AS [Egyéb pótlék - összeg (eltérített)], [tSzemélyek_import].[Illetmény összesen kerekítés nélkül (eltérített)] AS [Illetmény összesen kerekítés nélkül (eltérített)], [tSzemélyek_import].[Kerekített 100 %-os illetmény (eltérített)] AS [Kerekített 100 %-os illetmény (eltérített)], [tSzemélyek_import].[További munkavégzés helye 1 Teljes munkaidő %-a] AS [További munkavégzés helye 1 Teljes munkaidő %-a], [tSzemélyek_import].[További munkavégzés helye 2 Teljes munkaidő %-a] AS [További munkavégzés helye 2 Teljes munkaidő %-a], [tSzemélyek_import].[KT: Kerekített 100 %-os illetmény (eltérített) + Helyettesítési ] AS [KT: Kerekített 100 %-os illetmény (eltérített) + Helyettesítési ], [tSzemélyek_import].[Szint 1 szervezeti egység név] AS [Szint 1 szervezeti egység név], [tSzemélyek_import].[Szint 1 szervezeti egység kód] AS [Szint 1 szervezeti egység kód], [tSzemélyek_import].[Szint 2 szervezeti egység név] AS [Szint 2 szervezeti egység név], [tSzemélyek_import].[Szint 2 szervezeti egység kód] AS [Szint 2 szervezeti egység kód], [tSzemélyek_import].[Szint 3 szervezeti egység név] AS [Szint 3 szervezeti egység név], [tSzemélyek_import].[Szint 3 szervezeti egység kód] AS [Szint 3 szervezeti egység kód], [tSzemélyek_import].[Szint 4 szervezeti egység név] AS [Szint 4 szervezeti egység név], [tSzemélyek_import].[Szint 4 szervezeti egység kód] AS [Szint 4 szervezeti egység kód], [tSzemélyek_import].[Szint 5 szervezeti egység név] AS [Szint 5 szervezeti egység név], [tSzemélyek_import].[Szint 5 szervezeti egység kód] AS [Szint 5 szervezeti egység kód], [tSzemélyek_import].[Szint 6 szervezeti egység név] AS [Szint 6 szervezeti egység név], [tSzemélyek_import].[Szint 6 szervezeti egység kód] AS [Szint 6 szervezeti egység kód], [tSzemélyek_import].[Szint 7 szervezeti egység név] AS [Szint 7 szervezeti egység név], [tSzemélyek_import].[Szint 7 szervezeti egység kód] AS [Szint 7 szervezeti egység kód], [tSzemélyek_import].[AD egyedi azonosító] AS [AD egyedi azonosító], [tSzemélyek_import].[Hivatali email] AS [Hivatali email], [tSzemélyek_import].[Hivatali mobil] AS [Hivatali mobil], [tSzemélyek_import].[Hivatali telefon] AS [Hivatali telefon], [tSzemélyek_import].[Hivatali telefon mellék] AS [Hivatali telefon mellék], [tSzemélyek_import].[Iroda] AS Iroda, [tSzemélyek_import].[Otthoni e-mail] AS [Otthoni e-mail], [tSzemélyek_import].[Otthoni mobil] AS [Otthoni mobil], [tSzemélyek_import].[Otthoni telefon] AS [Otthoni telefon], [tSzemélyek_import].[További otthoni mobil] AS [További otthoni mobil]
FROM tSzemélyek_import;

#/#/#/
Lekérdezés11
#/#/
SELECT DISTINCT lkSzemélyek.Adójel, lkSzemélyek.Feladatkör, lkSzemélyek.[Elsődleges feladatkör]
FROM lkSzemélyek INNER JOIN lkSzemélyek AS lkSzemélyek_1 ON (lkSzemélyek_1.Feladatkör) Like "*" & ffsplit([lkSzemélyek].[Feladatkör],"-") & "*"
WHERE ((lkSzemélyek.[Státusz neve])="álláshely") AND ((lkSzemélyek.Feladatkör) Like "Lezárt_*");

#/#/#/
Lekérdezés12
#/#/
SELECT tBesorolásVáltoztatások.ÁlláshelyAzonosító, tBesorolásÁtalakítóEltérőBesoroláshoz.jel
FROM tBesorolásÁtalakítóEltérőBesoroláshoz INNER JOIN tBesorolásVáltoztatások ON tBesorolásÁtalakítóEltérőBesoroláshoz.[Álláshely besorolási kategóriája] = tBesorolásVáltoztatások.ÚjBesorolás
WHERE (((tBesorolásVáltoztatások.Hatály)=#1/1/2025#));

#/#/#/
Lekérdezés13
#/#/
SELECT 
FROM lkVezetők INNER JOIN tMeghagyandókAránya ON lkVezetők.BFKH = tMeghagyandókAránya.BFKH;

#/#/#/
Lekérdezés14
#/#/
SELECT lkMeghagyásVezetők.[TAJ szám], ffsplit([Dolgozó születési neve]," ",1) AS [Születési név1], ffsplit([Dolgozó születési neve]," ",2) AS [Születési név2], IIf(ffsplit([Dolgozó születési neve]," ",3)=ffsplit([Dolgozó születési neve]," ",2) Or Left(ffsplit([Dolgozó születési neve]," ",3),1)="(","",ffsplit([Dolgozó születési neve]," ",3)) AS [Születési név3], IIf(InStr(1,[Dolgozó teljes neve],"dr.",0),"dr.",IIf(InStr(1,[Dolgozó teljes neve],"Dr.",0),"Dr.","")) AS Előtag, ffsplit([Dolgozó teljes neve]," ",1) AS [Házassági név1], ffsplit([Dolgozó teljes neve]," ",2) AS [Házassági név2], IIf(ffsplit([Dolgozó teljes neve]," ",3)=ffsplit([Dolgozó teljes neve]," ",2) Or Left(ffsplit([Dolgozó teljes neve]," ",3),1)="(" Or Left(ffsplit([Dolgozó teljes neve]," ",3),3)="dr." Or Left(ffsplit([Dolgozó teljes neve]," ",3),3)="Dr.","",ffsplit([Dolgozó teljes neve]," ",3)) AS [Házassági név3], Trim(ffsplit(drLeválaszt([Anyja neve],False)," ",1)) AS [Anyja neve1], ffsplit(drLeválaszt([Anyja neve],False)," ",2) AS [Anyja neve2], IIf(ffsplit(drLeválaszt([Anyja neve],False)," ",3)=ffsplit(drLeválaszt([Anyja neve],False)," ",2) Or Left(ffsplit(drLeválaszt([Anyja neve],False)," ",3),1)="(","",ffsplit(drLeválaszt([Anyja neve],False)," ",3)) AS [Anyja neve3], lkMeghagyásVezetők.[Születési idő], lkMeghagyásVezetők.[Születési hely], lkMeghagyásVezetők.Feladatkörök AS munkakör
FROM lkMeghagyásVezetők;

#/#/#/
Lekérdezés15
#/#/
SELECT ffsplit([Dolgozó születési neve]," ",1) AS [Születési név1], ffsplit([Dolgozó születési neve]," ",2) AS [Születési név2], IIf(ffsplit([Dolgozó születési neve]," ",3)=ffsplit([Dolgozó születési neve]," ",2) Or Left(ffsplit([Dolgozó születési neve]," ",3),1)="(","",ffsplit([Dolgozó születési neve]," ",3)) AS [Születési név3], IIf(InStr(1,[Dolgozó teljes neve],"dr.",0),"dr.",IIf(InStr(1,[Dolgozó teljes neve],"Dr.",0),"Dr.","")) AS Előtag, ffsplit([Dolgozó teljes neve]," ",1) AS [Házassági név1], ffsplit([Dolgozó teljes neve]," ",2) AS [Házassági név2], IIf(ffsplit([Dolgozó teljes neve]," ",3)=ffsplit([Dolgozó teljes neve]," ",2) Or Left(ffsplit([Dolgozó teljes neve]," ",3),1)="(" Or Left(ffsplit([Dolgozó teljes neve]," ",3),3)="dr." Or Left(ffsplit([Dolgozó teljes neve]," ",3),3)="Dr.","",ffsplit([Dolgozó teljes neve]," ",3)) AS [Házassági név3], drLeválaszt([Anyja neve]) & " " & ffsplit(drLeválaszt([Anyja neve],False)," ",1) AS [Anyja neve1], ffsplit(drLeválaszt([Anyja neve],False)," ",2) AS [Anyja neve2], IIf(ffsplit(drLeválaszt([Anyja neve],False)," ",3)=ffsplit(drLeválaszt([Anyja neve],False)," ",2) Or Left(ffsplit(drLeválaszt([Anyja neve],False)," ",3),1)="(","",ffsplit(drLeválaszt([Anyja neve],False)," ",3)) AS [Anyja neve3], lkSzemélyek.[Születési idő], lkSzemélyek.[Születési hely], lkSzemélyek.[KIRA feladat megnevezés] AS munkakör
FROM lkSzemélyek
WHERE (((lkSzemélyek.[KIRA feladat megnevezés])="tűzvédelmi hatósági feladatok" Or (lkSzemélyek.[KIRA feladat megnevezés])="iparbiztonsági hatósági feladatok") AND ((lkSzemélyek.FőosztályKód)="BFKH.1.36.") AND ((lkSzemélyek.Neme)="férfi") AND ((lkSzemélyek.[KIRA jogviszony jelleg])="Kormányzati szolgálati jogviszony (KIT)"));

#/#/#/
Lekérdezés2
#/#/
SELECT lkSzervezetenkéntiLétszámadatok03.*
FROM lkSzervezetenkéntiLétszámadatok03;

#/#/#/
Lekérdezés3
#/#/
SELECT lk_Garantált_bérminimum_Illetmények.[Dolgozó teljes neve], lk_Garantált_bérminimum_Illetmények.[Álláshely azonosító], lkSzemélyek.[Besorolási  fokozat (KT)]
FROM lkSzemélyek INNER JOIN lk_Garantált_bérminimum_Illetmények ON lkSzemélyek.tSzemélyek.Adójel = lk_Garantált_bérminimum_Illetmények.Adójel
WHERE (((lk_Garantált_bérminimum_Illetmények.[Álláshely azonosító]) In (SELECT lk_Garantált_bérminimum_Illetmények.[Álláshely azonosító] FROM lk_Garantált_bérminimum_Illetmények LEFT JOIN lkSzemélyek ON lk_Garantált_bérminimum_Illetmények.[Álláshely azonosító] = lkSzemélyek.[Státusz kódja] GROUP BY lk_Garantált_bérminimum_Illetmények.[Álláshely azonosító] HAVING (((Count(lkSzemélyek.[Státusz kódja]))>1)))));

#/#/#/
Lekérdezés4
#/#/
SELECT tIntézkedésFajták.IntézkedésFajta, tRégiHibák.[Első mező], ktRégiHibákIntézkedések.azIntézkedések, tRégiHibák.[Második mező]
FROM tRégiHibák INNER JOIN (tIntézkedésFajták INNER JOIN (tIntézkedések INNER JOIN ktRégiHibákIntézkedések ON tIntézkedések.azIntézkedések = ktRégiHibákIntézkedések.azIntézkedések) ON tIntézkedésFajták.azIntFajta = tIntézkedések.azIntFajta) ON tRégiHibák.[Első mező] = ktRégiHibákIntézkedések.HASH;

#/#/#/
Lekérdezés5
#/#/
SELECT tBejövőVisszajelzések.Hash, Min(DateDiff("d",[tRégiHibák].[Első Időpont],[tBejövőÜzenetek].[DeliveredDate])) AS Kif1
FROM tRégiHibák LEFT JOIN (tBejövőÜzenetek RIGHT JOIN tBejövőVisszajelzések ON tBejövőÜzenetek.azÜzenet = tBejövőVisszajelzések.azÜzenet) ON tRégiHibák.[Első mező] = tBejövőVisszajelzések.Hash
WHERE (((tBejövőVisszajelzések.azVisszajelzés) Is Not Null))
GROUP BY tBejövőVisszajelzések.Hash;

#/#/#/
Lekérdezés6
#/#/
SELECT tRégiHibák.lekérdezésNeve, Count(tRégiHibák.[Első mező]) AS Hibák, Count(lkktRégiHibákIntézkedésekLegutolsóIntézkedés.azIntézkedések) AS CountOfazIntézkedések
FROM tRégiHibák LEFT JOIN lkktRégiHibákIntézkedésekLegutolsóIntézkedés ON tRégiHibák.[Első mező] = lkktRégiHibákIntézkedésekLegutolsóIntézkedés.HASH
WHERE (((tRégiHibák.[Utolsó Időpont])=(select max([utolsó időpont]) from tRégiHibák )))
GROUP BY tRégiHibák.lekérdezésNeve
HAVING (((tRégiHibák.lekérdezésNeve)<>"lkLejártAlkalmasságiÉrvényesség"));

#/#/#/
Lekérdezés7
#/#/
SELECT tmpÁNYRekHavihoz.ÁNYR, lkSzemélyek.[Státusz kódja], lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Adóazonosító jel], Year([Születési idő]) AS [Születési év], IIf([neme]="Férfi",1,2) AS Kif1, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Szervezeti egység kódja], lkSzemélyek.[KIRA feladat megnevezés], lkSzemélyek.[Szerződés/kinevezés verzió_érvényesség kezdete], "SZ" AS F, "T" AS T, 40 AS Óra, 1 AS Arány, tBesorolásÁtalakítóEltérőBesoroláshoz.jel
FROM (lkSzemélyek LEFT JOIN tmpÁNYRekHavihoz ON lkSzemélyek.[Státusz kódja] = tmpÁNYRekHavihoz.ÁNYR) LEFT JOIN tBesorolásÁtalakítóEltérőBesoroláshoz ON lkSzemélyek.[Besorolási  fokozat (KT)] = tBesorolásÁtalakítóEltérőBesoroláshoz.[Besorolási  fokozat (KT)]
WHERE (((tmpÁNYRekHavihoz.ÁNYR) Is Null) AND ((lkSzemélyek.[Státusz neve])="álláshely"));

#/#/#/
Lekérdezés8
#/#/
SELECT tFőosztályokOsztályokSorszámmal.Főosztály, lkOrvosiAlkalmasságiTeljesítésÖsszesítés01.Osztály, lkOrvosiAlkalmasságiTeljesítésÖsszesítés01.AlkalmasságiOsztály, lkOrvosiAlkalmasságiTeljesítésÖsszesítés01.[Alk# tipus], lkOrvosiAlkalmasságiTeljesítésÖsszesítés01.Egységár, IIf(IsNull([lkOrvosiAlkalmasságiTeljesítésÖsszesítés01].[Főosztály]),0,1) AS Mennyiség, lkOrvosiAlkalmasságiTeljesítésÖsszesítés01.Egységár AS [Összes nettó]
FROM tFőosztályokOsztályokSorszámmal LEFT JOIN lkOrvosiAlkalmasságiTeljesítésÖsszesítés01 ON tFőosztályokOsztályokSorszámmal.Főosztály = lkOrvosiAlkalmasságiTeljesítésÖsszesítés01.Főosztály
WHERE (((tFőosztályokOsztályokSorszámmal.Főosztály) Is Not Null) AND ((lkOrvosiAlkalmasságiTeljesítésÖsszesítés01.Osztály) Is Null));

#/#/#/
Lekérdezés9
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], EsetiÁNYRszámok.StátuszKód, lkSzemélyek.[Státusz neve]
FROM lkSzemélyek LEFT JOIN EsetiÁNYRszámok ON lkSzemélyek.[Státusz kódja] = EsetiÁNYRszámok.StátuszKód
WHERE (((EsetiÁNYRszámok.StátuszKód) Is Null) AND ((lkSzemélyek.[Státusz neve])="álláshely"));

#/#/#/
lk__BesorolásokHavi_vs_Ányr01
#/#/
SELECT lk__BesorolásokHaviból.BFKH, Nü([lkÁlláshelyek].[FőosztályÁlláshely],[Járási Hivatal]) AS FőosztályÁlláshely, lkÁlláshelyek.[5 szint] AS Szervezet, lk__BesorolásokHaviból.[Álláshely azonosító], lkÁlláshelyek.[Álláshely besorolási kategóriája] AS ÁNYR, Nz([lkBesorolásVáltoztatások].[ÚjBesorolás],[tBesorolás_átalakító].[Besorolási_fokozat]) AS NexonHavi, lk__BesorolásokHaviból.[Besorolási fokozat kód:]
FROM lkBesorolásVáltoztatások RIGHT JOIN (lkÁlláshelyek RIGHT JOIN (tBesorolás_átalakító RIGHT JOIN lk__BesorolásokHaviból ON (tBesorolás_átalakító.[Az álláshely megynevezése] = lk__BesorolásokHaviból.[Besorolási fokozat megnevezése:]) AND (tBesorolás_átalakító.[Az álláshely jelölése] = lk__BesorolásokHaviból.[Besorolási fokozat kód:])) ON lkÁlláshelyek.[Álláshely azonosító] = lk__BesorolásokHaviból.[Álláshely azonosító]) ON lkBesorolásVáltoztatások.ÁlláshelyAzonosító = lk__BesorolásokHaviból.[Álláshely azonosító]
WHERE (((Nz([lkBesorolásVáltoztatások].[ÚjBesorolás],[tBesorolás_átalakító].[Besorolási_fokozat]))<>Nz([Álláshely besorolási kategóriája],"")));

#/#/#/
lk__BesorolásokHavi_vs_Ányr02
#/#/
SELECT lk__BesorolásokHavi_vs_Ányr01.FőosztályÁlláshely AS Főosztály, lk__BesorolásokHavi_vs_Ányr01.Szervezet AS Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lk__BesorolásokHavi_vs_Ányr01.[Álláshely azonosító] AS [Státusz kód], lk__BesorolásokHavi_vs_Ányr01.NexonHavi AS [Nexon havi], lk__BesorolásokHavi_vs_Ányr01.ÁNYR AS ÁNYR, lk__BesorolásokHavi_vs_Ányr01.[Besorolási fokozat kód:] AS [Besorolás kód], kt_azNexon_Adójel02.NLink AS NLink
FROM (lkSzemélyek RIGHT JOIN lk__BesorolásokHavi_vs_Ányr01 ON lkSzemélyek.[Státusz kódja] = lk__BesorolásokHavi_vs_Ányr01.[Álláshely azonosító]) LEFT JOIN kt_azNexon_Adójel02 ON lkSzemélyek.Adójel = kt_azNexon_Adójel02.Adójel
ORDER BY lk__BesorolásokHavi_vs_Ányr01.BFKH;

#/#/#/
lk__BesorolásokHaviból
#/#/
SELECT HavibólBesorolások.Zóna, HavibólBesorolások.[Álláshely azonosító], HavibólBesorolások.[Besorolási fokozat kód:], HavibólBesorolások.[Besorolási fokozat megnevezése:], Replace(Replace([Besorolási fokozat kód:],"Mt.",""),"ÜÁ.","") AS Jel, Nz([Adóazonosító],0)*1 AS Adójel, bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]) AS BFKH, HavibólBesorolások.[Járási Hivatal]
FROM (SELECT Járási_állomány.[Álláshely azonosító]
, Járási_állomány.[Besorolási fokozat megnevezése:]
, [Besorolási fokozat kód:]
, "Alaplétszám" as Zóna
, Adóazonosító
, [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
, [Járási Hivatal]
FROM  lkJárási_állomány
UNION
SELECT  Kormányhivatali_állomány.[Álláshely azonosító]
, Kormányhivatali_állomány.[Besorolási fokozat megnevezése:]
, [Besorolási fokozat kód:]
, "Alaplétszám" as Zóna
, Adóazonosító
, [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
, Főosztály
FROM  lkKormányhivatali_állomány
UNION
SELECT Központosítottak.[Álláshely azonosító]
, Központosítottak.[Besorolási fokozat megnevezése:]
, [Besorolási fokozat kód:]
, "Központosított" as Zóna
, Adóazonosító
, [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
, Főoszt
FROM lkKözpontosítottak
)  AS HavibólBesorolások;

#/#/#/
lk__Eltérő_Szevezetnevek
#/#/
SELECT lkÁlláshelyek.FőosztályÁlláshely AS [Főosztály (ÁNYR)], lkÁlláshelyek.[5 szint] AS [Osztály (ÁNYR)], lkSzemélyek.Főosztály AS [Főosztály (Nexon Személyi karton)], lkSzemélyek.osztály AS [Osztály (Nexon Személyi karton)], lkSzemélyek.[Dolgozó teljes neve] AS Név, lkÁlláshelyek.[Álláshely azonosító] AS [Státusz kód], kt_azNexon_Adójel02.NLink AS NLink
FROM (lkÁlláshelyek INNER JOIN (lkSzemélyek LEFT JOIN tSzervezet ON lkSzemélyek.[Státusz kódja] = tSzervezet.[Szervezetmenedzsment kód]) ON lkÁlláshelyek.[Álláshely azonosító] = lkSzemélyek.[Státusz kódja]) LEFT JOIN kt_azNexon_Adójel02 ON lkSzemélyek.Adójel = kt_azNexon_Adójel02.Adójel
WHERE (((lkÁlláshelyek.[5 szint])<>[Szint 7 szervezeti egység név] And (lkÁlláshelyek.[5 szint])<>"") AND ((bfkh([Szervezeti egység kódja])) Is Not Null) AND ((Date()) Between [Érvényesség kezdete] And IIf([Érvényesség vége]=0,#1/1/3000#,[Érvényesség vége]))) OR (((lkSzemélyek.Főosztály)<>[lkÁlláshelyek].[FőosztályÁlláshely]) AND ((bfkh([Szervezeti egység kódja])) Is Not Null) AND ((Date()) Between [Érvényesség kezdete] And IIf([Érvényesség vége]=0,#1/1/3000#,[Érvényesség vége])))
ORDER BY bfkh([Szervezeti egység kódja]);

#/#/#/
lk__EltérőBesorolások
#/#/
SELECT DISTINCT lkSzervezetÁlláshelyek.SzervezetKód, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Tartós távollét típusa], lkSzemélyek.[Helyettesített dolgozó neve], Replace([lkSzemélyek].[Főosztály],"Budapest Főváros Kormányhivatala ","BFKH ") AS Főosztály, lkSzervezetÁlláshelyek.Álláshely AS Álláshely, Álláshelyek.[Álláshely besorolási kategóriája] AS ÁNYR, lkSzemélyek.Besorolás AS [Személyi karton], lkSzervezetÁlláshelyek.[Tervezett betöltési adatok - Előmeneteli fokozat megnevezés] AS [Szervezeti struktúra], "https://nexonport.kh.gov.hu/menu/hrm/szemelyiKarton/index?szemelyAzonosito=" & [azNexon] & "&r=13" AS Link, IIf(UCase$(Nz([Álláshely besorolási kategóriája],""))=UCase$(Nz([Tervezett betöltési adatok - Előmeneteli fokozat megnevezés],"")),True,False) AS Ányr_vs_Szervezeti, IIf(Nz([Tervezett betöltési adatok - Előmeneteli fokozat megnevezés],"")=Nz([lkSzemélyek].[Besorolás],""),True,False) AS Szervezeti_vs_Személyi, IIf(UCase$(Nz([Álláshely besorolási kategóriája],""))=UCase$(Nz([lkSzemélyek].[Besorolás],"")),True,False) AS Ány_vs_Személyi, lkSzervezetÁlláshelyek.Betöltött, kt_azNexon_Adójel.azNexon, lkSzemélyek.adójel
FROM (kt_azNexon_Adójel RIGHT JOIN (lkSzervezetÁlláshelyek LEFT JOIN lkSzemélyek ON lkSzervezetÁlláshelyek.Álláshely = lkSzemélyek.[Státusz kódja]) ON kt_azNexon_Adójel.Adójel = lkSzemélyek.Adójel) LEFT JOIN Álláshelyek ON lkSzervezetÁlláshelyek.Álláshely = Álláshelyek.[Álláshely azonosító]
WHERE (((IIf(UCase$(Nz([Álláshely besorolási kategóriája],""))=UCase$(Nz([Tervezett betöltési adatok - Előmeneteli fokozat megnevezés],"")),True,False))=False) And ((lkSzemélyek.[Jogviszony típusa / jogviszony típus]) Like "Munka*")) Or (((IIf(Nz([Tervezett betöltési adatok - Előmeneteli fokozat megnevezés],"")=Nz(lkSzemélyek.Besorolás,""),True,False))=False) And ((lkSzemélyek.[Jogviszony típusa / jogviszony típus]) Not Like "Munka*")) Or (((IIf(UCase$(Nz([Álláshely besorolási kategóriája],""))=UCase$(Nz([Tervezett betöltési adatok - Előmeneteli fokozat megnevezés],"")),True,False))=False) And ((lkSzemélyek.[Jogviszony típusa / jogviszony típus]) Not Like "Munka*")) Or (((IIf(UCase$(Nz([Álláshely besorolási kategóriája],""))=UCase$(Nz(lkSzemélyek.Besorolás,"")),True,False))=False) And ((lkSzemélyek.[Jogviszony típusa / jogviszony típus]) Not Like "Munka*")) Or (((IIf(UCase$(Nz([Álláshely besorolási kategóriája],""))=UCase$(Nz([Tervezett betöltési adatok - Előmeneteli fokozat megnevezés],"")),True,False))=False) And ((lkSzemélyek.[Jogviszony típusa / jogviszony típus]) Is Null))
ORDER BY lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lk__EltérőBesorolások_Ányr_vs_Szervezeti
#/#/
SELECT lk__EltérőBesorolások.SzervezetKód, lk__EltérőBesorolások.Főosztály, lk__EltérőBesorolások.Álláshely, lk__EltérőBesorolások.[Személyi karton], lk__EltérőBesorolások.[Szervezeti struktúra], lk__EltérőBesorolások.[Dolgozó teljes neve], lk__EltérőBesorolások.[Tartós távollét típusa], lk__EltérőBesorolások.[Helyettesített dolgozó neve], lk__EltérőBesorolások.Link, lk__EltérőBesorolások.Ányr_vs_Szervezeti, lk__EltérőBesorolások.Szervezeti_vs_Személyi, lk__EltérőBesorolások.Ány_vs_Személyi, *
FROM lk__EltérőBesorolások
WHERE (((lk__EltérőBesorolások.Ányr_vs_Szervezeti)=False) AND ((lk__EltérőBesorolások.Ány_vs_Személyi)=True))
ORDER BY lk__EltérőBesorolások.SzervezetKód, lk__EltérőBesorolások.[Dolgozó teljes neve];

#/#/#/
lk__EltérőBesorolások_Ányr_vs_Szervezeti_Címzettek
#/#/
SELECT DISTINCT lk__EltérőBesorolások_Ányr_vs_Szervezeti.Címzett
FROM lk__EltérőBesorolások_Ányr_vs_Szervezeti
GROUP BY lk__EltérőBesorolások_Ányr_vs_Szervezeti.Címzett, lk__EltérőBesorolások_Ányr_vs_Szervezeti.Főosztály;

#/#/#/
lk__EltérőBesorolások_Ányr_vs_Szervezeti_felelősök
#/#/
SELECT lk__EltérőBesorolások_Ányr_vs_Szervezeti.Főosztály, tReferensek.[Dolgozó teljes neve] AS Felelős, Count(lk__EltérőBesorolások_Ányr_vs_Szervezeti.Álláshely) AS [Javítandó adatok száma], lk__EltérőBesorolások_Ányr_vs_Szervezeti.[Dolgozó teljes neve]
FROM (ktReferens_SzervezetiEgység RIGHT JOIN lk__EltérőBesorolások_Ányr_vs_Szervezeti ON ktReferens_SzervezetiEgység.azSzervezet=lk__EltérőBesorolások_Ányr_vs_Szervezeti.azSzervezet) LEFT JOIN tReferensek ON ktReferens_SzervezetiEgység.azRef=tReferensek.azRef
GROUP BY lk__EltérőBesorolások_Ányr_vs_Szervezeti.Főosztály, tReferensek.[Dolgozó teljes neve], lk__EltérőBesorolások_Ányr_vs_Szervezeti.[Dolgozó teljes neve]
HAVING (((tReferensek.[Dolgozó teljes neve]) Like "Sz*"))
ORDER BY lk__EltérőBesorolások_Ányr_vs_Szervezeti.Főosztály, Count(lk__EltérőBesorolások_Ányr_vs_Szervezeti.Álláshely) DESC;

#/#/#/
lk__EltérőBesorolások_Ányr_vs_Szervezeti_szervezetek
#/#/
SELECT DISTINCT lk__EltérőBesorolások_Ányr_vs_Szervezeti.Főosztály, Count(lk__EltérőBesorolások_Ányr_vs_Szervezeti.Álláshely) AS [Javítandó adatok száma]
FROM lk__EltérőBesorolások_Ányr_vs_Szervezeti
GROUP BY lk__EltérőBesorolások_Ányr_vs_Szervezeti.Főosztály
ORDER BY Count(lk__EltérőBesorolások_Ányr_vs_Szervezeti.Álláshely) DESC;

#/#/#/
lk__EltérőBesorolások_Szervezet_vs_Személy
#/#/
SELECT lk__EltérőBesorolások.SzervezetKód, lk__EltérőBesorolások.Főosztály, lk__EltérőBesorolások.Álláshely, lk__EltérőBesorolások.[Személyi karton], lk__EltérőBesorolások.[Szervezeti struktúra], lk__EltérőBesorolások.[Dolgozó teljes neve], lk__EltérőBesorolások.[Tartós távollét típusa], lk__EltérőBesorolások.[Helyettesített dolgozó neve], lk__EltérőBesorolások.Link
FROM lk__EltérőBesorolások
WHERE (((lk__EltérőBesorolások.[Személyi karton])<>[Szervezeti struktúra]) AND ((lk__EltérőBesorolások.Betöltött)=True) AND ((lk__EltérőBesorolások.Szervezeti_vs_Személyi)=False))
ORDER BY lk__EltérőBesorolások.SzervezetKód, lk__EltérőBesorolások.[Dolgozó teljes neve];

#/#/#/
lk__Mintalekérdezés
#/#/
SELECT 'Járási_állomány' AS Tábla, "Ellátott feladat" AS [Hiányzó érték], Járási_állomány.Adóazonosító, Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
FROM Járási_állomány
WHERE (((Járási_állomány.Mező9) Is Null Or (Járási_állomány.Mező9)="") AND ((Járási_állomány.Mező4)<>"üres állás"));

#/#/#/
lk__osztályvezető_halmozó_szervezeti_egységek
#/#/
SELECT Álláshelyek.[3 szint], Álláshelyek.[4 szint], Álláshelyek.[5 szint], Count(Álláshelyek.[Álláshely azonosító]) AS [CountOfÁlláshely azonosító], 2 AS Sor
FROM Álláshelyek
WHERE (((Álláshelyek.[Álláshely besorolási kategóriája])="osztályvezető"))
GROUP BY Álláshelyek.[3 szint], Álláshelyek.[4 szint], Álláshelyek.[5 szint], 2
HAVING (((Count(Álláshelyek.[Álláshely azonosító]))>1));

#/#/#/
lk__osztályvezető_halmozó_szervezeti_egységek_összefoglaló
#/#/
SELECT Összevont.[3 szint], Összevont.[4 szint], Összevont.[5 szint], IIf(Left([Összevont].[Álláshely azonosító],1)="S",[Összevont].[Álláshely azonosító],"Összesen: " & [Összevont].[Álláshely azonosító] & " db.") AS Álláshely, Álláshelyek.[Álláshely státusza], lkSzemélyek.[Dolgozó teljes neve]
FROM lkSzemélyek RIGHT JOIN (Álláshelyek RIGHT JOIN (SELECT lk__osztályvezető_halmozó_szervezeti_egységek_részletező.* FROM lk__osztályvezető_halmozó_szervezeti_egységek_részletező UNION SELECT  lk__osztályvezető_halmozó_szervezeti_egységek.* FROM lk__osztályvezető_halmozó_szervezeti_egységek )  AS Összevont ON Álláshelyek.[Álláshely azonosító] = Összevont.[Álláshely azonosító]) ON lkSzemélyek.[Státusz kódja] = Álláshelyek.[Álláshely azonosító]
ORDER BY Összevont.[3 szint], Összevont.[4 szint], Összevont.[5 szint], Összevont.sor;

#/#/#/
lk__osztályvezető_halmozó_szervezeti_egységek_részletező
#/#/
SELECT lk__osztályvezető_halmozó_szervezeti_egységek.[3 szint], lk__osztályvezető_halmozó_szervezeti_egységek.[4 szint], lk__osztályvezető_halmozó_szervezeti_egységek.[5 szint], Álláshelyek.[Álláshely azonosító], 1 AS sor
FROM Álláshelyek RIGHT JOIN lk__osztályvezető_halmozó_szervezeti_egységek ON (Álláshelyek.[3 szint] = lk__osztályvezető_halmozó_szervezeti_egységek.[3 szint]) AND (Álláshelyek.[4 szint] = lk__osztályvezető_halmozó_szervezeti_egységek.[4 szint]) AND (Álláshelyek.[5 szint] = lk__osztályvezető_halmozó_szervezeti_egységek.[5 szint])
WHERE (((Álláshelyek.[Álláshely besorolási kategóriája])="osztályvezető"));

#/#/#/
lk__osztályvezető_nélküli_szervezetei_egységek
#/#/
SELECT MindenSzervezetiEgység.Szervezet, SzervezetekOsztályvezetővel.Szervezet, *
FROM (SELECT DISTINCT IIf([4 szint]="" Or [4 szint] Is Null,[3 szint],[4 szint]) & " - " & [5 szint] AS Szervezet FROM Álláshelyek WHERE [5 szint]<>"")  AS MindenSzervezetiEgység LEFT JOIN (SELECT DISTINCT IIf([4 szint]="" Or [4 szint] Is Null,[3 szint],[4 szint]) & " - " & [5 szint] AS Szervezet FROM Álláshelyek WHERE Álláshelyek.[Álláshely besorolási kategóriája]="osztályvezető")  AS SzervezetekOsztályvezetővel ON MindenSzervezetiEgység.Szervezet=SzervezetekOsztályvezetővel.Szervezet
WHERE (((SzervezetekOsztályvezetővel.Szervezet) Is Null));

#/#/#/
lk_382_2_lkNFSZ_kapacitás_felmérés_00
#/#/
SELECT lkJárásiKormányKözpontosítottUnióFőosztKód.Főosztály, IIf([Születési év \ üres állás]<>"üres állás","Betöltött","Üres") AS Betöltött, lkJárásiKormányKözpontosítottUnióFőosztKód.Jelleg, lkJárásiKormányKözpontosítottUnióFőosztKód.[Álláshely azonosító], IIf(([Főosztály] Not Like "*Főosztály" And [Osztály] Like "Foglalkoztatás*") Or [Főosztály]="Foglalkoztatási Főosztály",1,0) AS Foglalkoztatás, IIf([Főosztály]="Foglalkoztatás-felügyeleti és Munkavédelmi Főosztály",IIf(Nz([KIRA feladat megnevezés],"")="Foglalkoztatás-felügyeleti és munkavédelmi feladatok, munkaügyi ellenőr",1,IIf(Nz([KIRA feladat megnevezés],"")="Foglalkoztatás-felügyeleti és munkavédelmi feladatok",0.5,0)),0) AS Munkaügy, IIf([Főosztály]="Foglalkoztatás-felügyeleti és Munkavédelmi Főosztály",IIf(Nz([KIRA feladat megnevezés],"")="Foglalkoztatás-felügyeleti és munkavédelmi feladatok, munkavédelmi ellenőr",1,IIf(Nz([KIRA feladat megnevezés],"")="Foglalkoztatás-felügyeleti és munkavédelmi feladatok",0.5,0)),0) AS Munkavédelem
FROM lkSzemélyek RIGHT JOIN (lkJárásiKormányKözpontosítottUnióFőosztKód INNER JOIN lktNFSZSzervezetek ON lkJárásiKormányKözpontosítottUnióFőosztKód.Főosztálykód = lktNFSZSzervezetek.BFKH) ON lkSzemélyek.[Adóazonosító jel] = lkJárásiKormányKözpontosítottUnióFőosztKód.Adóazonosító
ORDER BY lktNFSZSzervezetek.BFKH;

#/#/#/
lk_Állománytáblákból_Illetmények
#/#/
SELECT Unió.Adóazonosító, Unió.Illetmény, Unió.[Heti munkaórák száma], Unió.[Álláshely azonosító], Unió.Név, Unió.Főosztály, Unió.Osztály, [Adóazonosító]*1 AS Adójel, Unió.TávollétJogcíme, Unió.Szervezetkód, Unió.BesorolásHavi
FROM (SELECT Járási_állomány.Adóazonosító, 
        Járási_állomány.Mező18 AS Illetmény, 
        [Heti munkaórák száma], 
        [Álláshely azonosító], 
        Név, 
        Replace([Járási hivatal],"Budapest Főváros Kormányhivatala ","BFKH ") as Főosztály,
        Mező7 as Osztály,
        [Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp] as TávollétJogcíme, 
        [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] as Szervezetkód,
        [Besorolási fokozat kód:] as BesorolásHavi
    FROM Járási_állomány
    WHERE Adóazonosító  not like ""

    UNION SELECT Kormányhivatali_állomány.Adóazonosító, 
        Kormányhivatali_állomány.Mező18, 
        [Heti munkaórák száma], 
        [Álláshely azonosító], 
        Név, 
        Mező6, 
        Mező7, 
        [Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], 
        [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ],
        [Besorolási fokozat kód:]
    FROM  Kormányhivatali_állomány
    WHERE Adóazonosító  not  like ""
    
    UNION SELECT Központosítottak.Adóazonosító, Központosítottak.Mező17, lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker] AS [Heti munkaórák száma], Központosítottak.[Álláshely azonosító], Központosítottak.Név, Központosítottak.Mező7, Központosítottak.[Projekt megnevezése], Központosítottak.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító], Központosítottak.[Besorolási fokozat kód:]
FROM lkSzemélyek RIGHT JOIN Központosítottak ON lkSzemélyek.[Adóazonosító jel] = Központosítottak.Adóazonosító
WHERE (Központosítottak.[Adóazonosító]) Not Like ""
)  AS Unió;

#/#/#/
lk_BetöltésTávollétEltérés
#/#/
SELECT lkJárásiKormányKözpontosítottUnió.Adójel, lkJárásiKormányKözpontosítottUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkJárásiKormányKözpontosítottUnió.[Álláshely azonosító], lkJárásiKormányKözpontosítottUnió.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h], lkJárásiKormányKözpontosítottUnió.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], lkSzervezetSzemélyek.[Státuszbetöltés típusa], lkSzemélyek.[Tartós távollét típusa], lkSzemélyek.[Tartós távollét kezdete], lkSzemélyek.[Tartós távollét vége], lkSzemélyek.[Tartós távollét tervezett vége], lkSzemélyek.[Helyettesített dolgozó neve], dtÁtal([Érvényesség kezdete]) AS ÉrvKezd, IIf(dtÁtal([Érvényesség vége])=0,#1/1/3000#,dtÁtal([Érvényesség vége])) AS ÉrvVége
FROM lkSzemélyek INNER JOIN (lkJárásiKormányKözpontosítottUnió INNER JOIN lkSzervezetSzemélyek ON lkJárásiKormányKözpontosítottUnió.Adójel = lkSzervezetSzemélyek.Adójel) ON lkSzemélyek.Adójel = lkJárásiKormányKözpontosítottUnió.Adójel
WHERE (((lkJárásiKormányKözpontosítottUnió.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h]) Like "*TT*") AND ((dtÁtal([Érvényesség kezdete]))<=dtÁtal(Now())) AND ((IIf(dtÁtal([Érvényesség vége])=0,#1/1/3000#,dtÁtal([Érvényesség vége])))>=dtátal(Now()))) OR (((lkJárásiKormányKözpontosítottUnió.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp])<>"") AND ((dtÁtal([Érvényesség kezdete]))<=dtÁtal(Now())) AND ((IIf(dtÁtal([Érvényesség vége])=0,#1/1/3000#,dtÁtal([Érvényesség vége])))>=dtátal(Now()))) OR (((lkSzervezetSzemélyek.[Státuszbetöltés típusa])<>"Általános") AND ((dtÁtal([Érvényesség kezdete]))<=dtÁtal(Now())) AND ((IIf(dtÁtal([Érvényesség vége])=0,#1/1/3000#,dtÁtal([Érvényesség vége])))>=dtátal(Now())));

#/#/#/
lk_CSED-en lévők
#/#/
SELECT [Adóazonosító]*1 AS Adójel, [lk_TT-sek].Név, [lk_TT-sek].[Járási Hivatal], [lk_TT-sek].Osztály, [lk_TT-sek].Jogcíme
FROM [lk_TT-sek];

#/#/#/
lk_Ellenőrzés_01
#/#/
SELECT 'Járási_állomány' AS Tábla, 'Kinevezés dátuma
Álláshely megüresedésének dátuma
(most ellátott feladat)
év,hó,nap' AS Hiányzó_érték, Járási_állomány.[Adóazonosító], Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Járási_állomány] 
WHERE ([Járási_állomány].[Mező10] Is Null )  AND ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null ) 
 UNION SELECT 'Járási_állomány' AS Tábla, 'Ellátott feladatok megjelölése
a fővárosi és megyei kormányhivatalok szervezeti és működési szabályzatáról szóló 3/2020. (II. 28.) MvM utasítás alapján' AS Hiányzó_érték, Járási_állomány.[Adóazonosító], Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Járási_állomány] 
WHERE ([Járási_állomány].[Mező9] Is Null OR [Járási_állomány].[Mező9]='')  AND ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null ) 
 UNION SELECT 'Járási_állomány' AS Tábla, 'ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ' AS Hiányzó_érték, Járási_állomány.[Adóazonosító], Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Járási_állomány] 
WHERE ([Járási_állomány].[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] Is Null OR [Járási_állomány].[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]='')  AND ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null ) 
 UNION SELECT 'Járási_állomány' AS Tábla, 'Szervezeti egység
Osztály megnevezése' AS Hiányzó_érték, Járási_állomány.[Adóazonosító], Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Járási_állomány] 
WHERE ([Járási_állomány].[Mező7] Is Null OR [Járási_állomány].[Mező7]='')  AND ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null ) 
 UNION SELECT 'Járási_állomány' AS Tábla, 'Járási Hivatal' AS Hiányzó_érték, Járási_állomány.[Adóazonosító], Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Járási_állomány] 
WHERE ([Járási_állomány].[Járási Hivatal] Is Null OR [Járási_állomány].[Járási Hivatal]='')  AND ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null ) 
 UNION SELECT 'Járási_állomány' AS Tábla, 'Dolgozó neme' AS Hiányzó_érték, Járási_állomány.[Adóazonosító], Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Járási_állomány] 
WHERE ([Járási_állomány].[Mező5] Is Null OR [Járási_állomány].[Mező5]='')  AND ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null ) 
 UNION SELECT 'Járási_állomány' AS Tábla, 'Születési év/ Üres állás
/ Üres állás' AS Hiányzó_érték, Járási_állomány.[Adóazonosító], Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Járási_állomány] 
WHERE ([Járási_állomány].[Mező4] Is Null OR [Járási_állomány].[Mező4]='')  AND ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null ) 
 UNION SELECT 'Járási_állomány' AS Tábla, 'Adóazonosító' AS Hiányzó_érték, Járási_állomány.[Adóazonosító], Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Járási_állomány] 
WHERE ([Járási_állomány].[Adóazonosító] Is Null )  AND ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null ) 
 UNION SELECT 'Járási_állomány' AS Tábla, 'Név' AS Hiányzó_érték, Járási_állomány.[Adóazonosító], Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Járási_állomány] 
WHERE ([Járási_állomány].[Név] Is Null OR [Járási_állomány].[Név]='')  AND ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null ) 
UNION SELECT 'Járási_állomány' AS Tábla, 'Legmagasabb iskolai végzettség 1=8. osztály; 2=érettségi; 3=főiskolai végzettség; 4=egyetemi végzettség; 5=technikus; 6= KAB vizsga' AS Hiányzó_érték, Járási_állomány.Adóazonosító, Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
FROM lkVégzettségek RIGHT JOIN Járási_állomány ON lkVégzettségek.[Dolgozó azonosító] = Járási_állomány.Adóazonosító
WHERE (((Járási_állomány.[Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis]) Like "") AND ((Járási_állomány.Mező4)<>'üres állás' Or (Járási_állomány.Mező4) Is Null) AND ((lkVégzettségek.[Végzettség típusa])="Iskolai végzettség"))
UNION SELECT 'Járási_állomány' AS Tábla, 'Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)' AS Hiányzó_érték, Járási_állomány.[Adóazonosító], Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Járási_állomány]  WHERE ([Járási_állomány].[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)] Is Null OR [Járási_állomány].[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)]='')  AND ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null )
UNION SELECT 'Járási_állomány' AS Tábla, 'Havi illetmény teljes összege (kerekítve) (FT)' AS Hiányzó_érték, Járási_állomány.[Adóazonosító], Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Járási_állomány]  WHERE ([Járási_állomány].[Mező18] Is Null )  AND ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null )
UNION SELECT 'Járási_állomány' AS Tábla, 'Álláshely azonosító' AS Hiányzó_érték, Járási_állomány.[Adóazonosító], Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Járási_állomány]  WHERE ([Járási_állomány].[Álláshely azonosító] Is Null OR [Járási_állomány].[Álláshely azonosító]='')  AND ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null )
UNION SELECT 'Járási_állomány' AS Tábla, 'Besorolási fokozat megnevezése:' AS Hiányzó_érték, Járási_állomány.[Adóazonosító], Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Járási_állomány]  WHERE ([Járási_állomány].[Besorolási fokozat megnevezése:] Is Null OR [Járási_állomány].[Besorolási fokozat megnevezése:]='')  AND ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null )
UNION SELECT 'Járási_állomány' AS Tábla, 'Besorolási fokozat kód:' AS Hiányzó_érték, Járási_állomány.[Adóazonosító], Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Járási_állomány]  WHERE ([Járási_állomány].[Besorolási fokozat kód:] Is Null OR [Járási_állomány].[Besorolási fokozat kód:]='')  AND ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null )
UNION SELECT 'Járási_állomány' AS Tábla, 'Álláshely betöltésének aránya és Üres álláshely betöltés aránya' AS Hiányzó_érték, Járási_állomány.[Adóazonosító], Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Járási_állomány]  WHERE ([Járási_állomány].[Mező14] Is Null )  AND ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null )   UNION SELECT 'Járási_állomány' AS Tábla, 'Heti munkaórák száma' AS Hiányzó_érték, Járási_állomány.[Adóazonosító], Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Járási_állomány]  WHERE ([Járási_állomány].[Heti munkaórák száma] Is Null )  AND ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null )   UNION SELECT 'Járási_állomány' AS Tábla, 'Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas teljes (NYT), részmunkaidős (NYR)' AS Hiányzó_érték, Járási_állomány.[Adóazonosító], Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Járási_állomány]  WHERE ([Járási_állomány].[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ] Is Null OR [Járási_állomány].[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ]='')  AND ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null )   UNION SELECT 'Járási_állomány' AS Tábla, 'Feladat jellege: szakmai (SZ) / funkcionális (F) feladatellátás; KAB szakmai (KAB/SZ) / KAB funkcionális (KAB/F) feladatellátás;' AS Hiányzó_érték, Járási_állomány.Adóazonosító, Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
FROM Járási_állomány
WHERE (((Járási_állomány.[Feladat jellege: szakmai (SZ) / funkcionális (F) feladatellátás;]) Is Null Or (Járási_állomány.[Feladat jellege: szakmai (SZ) / funkcionális (F) feladatellátás;])='') AND ((Járási_állomány.Mező4)<>'üres állás' Or (Járási_állomány.Mező4) Is Null))
UNION
SELECT 'Kormányhivatali_állomány' AS Tábla, 'Kinevezés dátuma
Álláshely megüresedésének dátuma
(most ellátott feladat)
év,hó,nap' AS Hiányzó_érték, Kormányhivatali_állomány.[Adóazonosító], Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Kormányhivatali_állomány] 
WHERE ([Kormányhivatali_állomány].[Mező10] Is Null )  AND ([Kormányhivatali_állomány].[Mező4]<> 'üres állás' OR [Kormányhivatali_állomány].[Mező4] is null ) 
 UNION SELECT 'Kormányhivatali_állomány' AS Tábla, 'Ellátott feladatok megjelölése
a fővárosi és megyei kormányhivatalok szervezeti és működési szabályzatáról szóló 3/2020. (II. 28.) MvM utasítás alapján' AS Hiányzó_érték, Kormányhivatali_állomány.[Adóazonosító], Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Kormányhivatali_állomány] 
WHERE ([Kormányhivatali_állomány].[Mező9] Is Null OR [Kormányhivatali_állomány].[Mező9]='')  AND ([Kormányhivatali_állomány].[Mező4]<> 'üres állás' OR [Kormányhivatali_állomány].[Mező4] is null ) 
 UNION SELECT 'Kormányhivatali_állomány' AS Tábla, 'ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ' AS Hiányzó_érték, Kormányhivatali_állomány.[Adóazonosító], Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Kormányhivatali_állomány] 
WHERE ([Kormányhivatali_állomány].[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] Is Null OR [Kormányhivatali_állomány].[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]='')  AND ([Kormányhivatali_állomány].[Mező4]<> 'üres állás' OR [Kormányhivatali_állomány].[Mező4] is null ) 
 UNION SELECT 'Kormányhivatali_állomány' AS Tábla, 'Szervezeti egység
Osztály megnevezése' AS Hiányzó_érték, Kormányhivatali_állomány.[Adóazonosító], Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Kormányhivatali_állomány] 
WHERE ([Kormányhivatali_állomány].[Mező7] Is Null OR [Kormányhivatali_állomány].[Mező7]='')  AND ([Kormányhivatali_állomány].[Mező4]<> 'üres állás' OR [Kormányhivatali_állomány].[Mező4] is null ) 
 UNION SELECT 'Kormányhivatali_állomány' AS Tábla, 'Szervezeti egység
Főosztály megnevezése' AS Hiányzó_érték, Kormányhivatali_állomány.[Adóazonosító], Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Kormányhivatali_állomány] 
WHERE ([Kormányhivatali_állomány].[Mező6] Is Null OR [Kormányhivatali_állomány].[Mező6]='')  AND ([Kormányhivatali_állomány].[Mező4]<> 'üres állás' OR [Kormányhivatali_állomány].[Mező4] is null ) 
 UNION SELECT 'Kormányhivatali_állomány' AS Tábla, 'Dolgozó neme' AS Hiányzó_érték, Kormányhivatali_állomány.[Adóazonosító], Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Kormányhivatali_állomány] 
WHERE ([Kormányhivatali_állomány].[Mező5] Is Null OR [Kormányhivatali_állomány].[Mező5]='')  AND ([Kormányhivatali_állomány].[Mező4]<> 'üres állás' OR [Kormányhivatali_állomány].[Mező4] is null ) 
 UNION SELECT 'Kormányhivatali_állomány' AS Tábla, 'Születési év/ Üres állás' AS Hiányzó_érték, Kormányhivatali_állomány.[Adóazonosító], Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Kormányhivatali_állomány] 
WHERE ([Kormányhivatali_állomány].[Mező4] Is Null OR [Kormányhivatali_állomány].[Mező4]='')  AND ([Kormányhivatali_állomány].[Mező4]<> 'üres állás' OR [Kormányhivatali_állomány].[Mező4] is null ) 
 UNION SELECT 'Kormányhivatali_állomány' AS Tábla, 'Adóazonosító' AS Hiányzó_érték, Kormányhivatali_állomány.[Adóazonosító], Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Kormányhivatali_állomány] 
WHERE ([Kormányhivatali_állomány].[Adóazonosító] Is Null )  AND ([Kormányhivatali_állomány].[Mező4]<> 'üres állás' OR [Kormányhivatali_állomány].[Mező4] is null ) 
 UNION SELECT 'Kormányhivatali_állomány' AS Tábla, 'Név' AS Hiányzó_érték, Kormányhivatali_állomány.[Adóazonosító], Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Kormányhivatali_állomány] 
WHERE ([Kormányhivatali_állomány].[Név] Is Null OR [Kormányhivatali_állomány].[Név]='')  AND ([Kormányhivatali_állomány].[Mező4]<> 'üres állás' OR [Kormányhivatali_állomány].[Mező4] is null ) 
 UNION SELECT 'Járási_állomány' AS Tábla, 'Képesítést adó végzettség megnevezése.
(az az egy ami a feladat betöltéséhez szükséges)' AS Hiányzó_érték, Járási_állomány.[Adóazonosító], Járási_állomány.[Álláshely azonosító], Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Járási_állomány] 
WHERE ([Járási_állomány].[Mező26] Is Null OR [Járási_állomány].[Mező26]='')  AND ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null ) 

union
SELECT 'Kormányhivatali_állomány' AS Tábla, 'Képesítést adó végzettség megnevezése.
(az az egy ami a feladat betöltéséhez szükséges)' AS Hiányzó_érték, Kormányhivatali_állomány.[Adóazonosító], Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Kormányhivatali_állomány] 
WHERE ([Kormányhivatali_állomány].[Mező26] Is Null OR [Kormányhivatali_állomány].[Mező26]='')  AND ([Kormányhivatali_állomány].[Mező4]<> 'üres állás' OR [Kormányhivatali_állomány].[Mező4] is null ) 
 UNION SELECT 'Kormányhivatali_állomány' AS Tábla, 'Legmagasabb iskolai végzettség 1=8. osztály; 2=érettségi; 3=főiskolai végzettség; 4=egyetemi végzettség; 5=technikus; 6= KAB vizsga' AS Hiányzó_érték, Kormányhivatali_állomány.Adóazonosító, Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
FROM lkVégzettségek RIGHT JOIN Kormányhivatali_állomány ON lkVégzettségek.[Dolgozó azonosító] = Kormányhivatali_állomány.Adóazonosító
WHERE (((Kormányhivatali_állomány.[Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis]) Like "") AND ((Kormányhivatali_állomány.Mező4)<>'üres állás' Or (Kormányhivatali_állomány.Mező4) Is Null) AND ((lkVégzettségek.[Végzettség típusa])="Iskolai végzettség"))
 UNION SELECT 'Kormányhivatali_állomány' AS Tábla, 'Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)' AS Hiányzó_érték, Kormányhivatali_állomány.[Adóazonosító], Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Kormányhivatali_állomány] 
WHERE ([Kormányhivatali_állomány].[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)] Is Null OR [Kormányhivatali_állomány].[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)]='')  AND ([Kormányhivatali_állomány].[Mező4]<> 'üres állás' OR [Kormányhivatali_állomány].[Mező4] is null ) 
 UNION SELECT 'Kormányhivatali_állomány' AS Tábla, 'Havi illetmény teljes összege (kerekítve)
(FT)' AS Hiányzó_érték, Kormányhivatali_állomány.[Adóazonosító], Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Kormányhivatali_állomány] 
WHERE ([Kormányhivatali_állomány].[Mező18] Is Null )  AND ([Kormányhivatali_állomány].[Mező4]<> 'üres állás' OR [Kormányhivatali_állomány].[Mező4] is null ) 
 UNION SELECT 'Kormányhivatali_állomány' AS Tábla, 'Álláshely azonosító' AS Hiányzó_érték, Kormányhivatali_állomány.[Adóazonosító], Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Kormányhivatali_állomány] 
WHERE ([Kormányhivatali_állomány].[Álláshely azonosító] Is Null OR [Kormányhivatali_állomány].[Álláshely azonosító]='')  AND ([Kormányhivatali_állomány].[Mező4]<> 'üres állás' OR [Kormányhivatali_állomány].[Mező4] is null ) 
 UNION SELECT 'Kormányhivatali_állomány' AS Tábla, 'Besorolási fokozat megnevezése:' AS Hiányzó_érték, Kormányhivatali_állomány.[Adóazonosító], Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Kormányhivatali_állomány] 
WHERE ([Kormányhivatali_állomány].[Besorolási fokozat megnevezése:] Is Null OR [Kormányhivatali_állomány].[Besorolási fokozat megnevezése:]='')  AND ([Kormányhivatali_állomány].[Mező4]<> 'üres állás' OR [Kormányhivatali_állomány].[Mező4] is null ) 
 UNION SELECT 'Kormányhivatali_állomány' AS Tábla, 'Álláshely betöltésének aránya és
Üres álláshely betöltés aránya' AS Hiányzó_érték, Kormányhivatali_állomány.[Adóazonosító], Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Kormányhivatali_állomány] 
WHERE ([Kormányhivatali_állomány].[Mező14] Is Null )  AND ([Kormányhivatali_állomány].[Mező4]<> 'üres állás' OR [Kormányhivatali_állomány].[Mező4] is null ) 
 UNION SELECT 'Kormányhivatali_állomány' AS Tábla, 'Heti munkaórák száma' AS Hiányzó_érték, Kormányhivatali_állomány.[Adóazonosító], Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Kormányhivatali_állomány] 
WHERE ([Kormányhivatali_állomány].[Heti munkaórák száma] Is Null )  AND ([Kormányhivatali_állomány].[Mező4]<> 'üres állás' OR [Kormányhivatali_állomány].[Mező4] is null ) 
 UNION SELECT 'Kormányhivatali_állomány' AS Tábla, 'Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas teljes (NYT), részmunkaidős (NYR)' AS Hiányzó_érték, Kormányhivatali_állomány.[Adóazonosító], Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Kormányhivatali_állomány] 
WHERE ([Kormányhivatali_állomány].[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ] Is Null OR [Kormányhivatali_állomány].[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ]='')  AND ([Kormányhivatali_állomány].[Mező4]<> 'üres állás' OR [Kormányhivatali_állomány].[Mező4] is null ) 
 UNION SELECT 'Kormányhivatali_állomány' AS Tábla, 'Feladat jellege: szakmai (SZ) / funkcionális (F) feladatellátás; KAB szakmai (KAB/SZ) / KAB funkcionális (KAB/F) feladatellátás;' AS Hiányzó_érték, Kormányhivatali_állomány.Adóazonosító, Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
FROM Kormányhivatali_állomány
WHERE (((Kormányhivatali_állomány.[Feladat jellege: szakmai (SZ) / funkcionális (F) feladatellátás;]) Is Null Or (Kormányhivatali_állomány.[Feladat jellege: szakmai (SZ) / funkcionális (F) feladatellátás;])='') AND ((Kormányhivatali_állomány.Mező4)<>'üres állás' Or (Kormányhivatali_állomány.Mező4) Is Null))


union
SELECT 'Központosítottak' AS Tábla, 'Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas teljes (NYT), részmunkaidős (NYR)' AS Hiányzó_érték, Központosítottak.[Adóazonosító], Központosítottak.[Álláshely azonosító], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] FROM [Központosítottak] 
WHERE ([Központosítottak].[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ] Is Null OR [Központosítottak].[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ]='')  AND ([Központosítottak].[Mező4]<> 'üres állás' OR [Központosítottak].[Mező4] is null ) 
 UNION SELECT 'Központosítottak' AS Tábla, 'Kinevezés dátuma
Álláshely megüresedésének dátuma
(most ellátott feladat)
év,hó,nap' AS Hiányzó_érték, Központosítottak.[Adóazonosító], Központosítottak.[Álláshely azonosító], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] FROM [Központosítottak] 
WHERE ([Központosítottak].[Mező11] Is Null )  AND ([Központosítottak].[Mező4]<> 'üres állás' OR [Központosítottak].[Mező4] is null ) 
 UNION SELECT 'Központosítottak' AS Tábla, 'Ellátott feladatok megjelölése
a fővárosi és megyei kormányhivatalok szervezeti és működési szabályzatáról szóló 3/2020. (II. 28.) MvM utasítás alapján' AS Hiányzó_érték, Központosítottak.[Adóazonosító], Központosítottak.[Álláshely azonosító], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] FROM [Központosítottak] 
WHERE ([Központosítottak].[Mező10] Is Null OR [Központosítottak].[Mező10]='')  AND ([Központosítottak].[Mező4]<> 'üres állás' OR [Központosítottak].[Mező4] is null ) 
 UNION SELECT 'Központosítottak' AS Tábla, 'Nexon szótárelemnek megfelelő szervezeti egység azonosító' AS Hiányzó_érték, Központosítottak.[Adóazonosító], Központosítottak.[Álláshely azonosító], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] FROM [Központosítottak] 
WHERE ([Központosítottak].[Nexon szótárelemnek megfelelő szervezeti egység azonosító] Is Null OR [Központosítottak].[Nexon szótárelemnek megfelelő szervezeti egység azonosító]='')  AND ([Központosítottak].[Mező4]<> 'üres állás' OR [Központosítottak].[Mező4] is null ) 
 UNION SELECT 'Központosítottak' AS Tábla, 'Szervezeti egység
Osztály megnevezése' AS Hiányzó_érték, Központosítottak.[Adóazonosító], Központosítottak.[Álláshely azonosító], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] FROM [Központosítottak] 
WHERE ([Központosítottak].[Mező7] Is Null OR [Központosítottak].[Mező7]='')  AND ([Központosítottak].[Mező4]<> 'üres állás' OR [Központosítottak].[Mező4] is null ) 
 UNION SELECT 'Központosítottak' AS Tábla, 'Szervezeti egység
Főosztály megnevezése' AS Hiányzó_érték, Központosítottak.[Adóazonosító], Központosítottak.[Álláshely azonosító], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] FROM [Központosítottak] 
WHERE ([Központosítottak].[Mező6] Is Null OR [Központosítottak].[Mező6]='')  AND ([Központosítottak].[Mező4]<> 'üres állás' OR [Központosítottak].[Mező4] is null ) 
 UNION SELECT 'Központosítottak' AS Tábla, 'Megyei szint VAGY Járási Hivatal' AS Hiányzó_érték, Központosítottak.[Adóazonosító], Központosítottak.[Álláshely azonosító], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] FROM [Központosítottak] 
WHERE ([Központosítottak].[Megyei szint VAGY Járási Hivatal] Is Null OR [Központosítottak].[Megyei szint VAGY Járási Hivatal]='')  AND ([Központosítottak].[Mező4]<> 'üres állás' OR [Központosítottak].[Mező4] is null ) 
 UNION SELECT 'Központosítottak' AS Tábla, 'Születési év/ Üres állás' AS Hiányzó_érték, Központosítottak.[Adóazonosító], Központosítottak.[Álláshely azonosító], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] FROM [Központosítottak] 
WHERE ([Központosítottak].[Mező4] Is Null OR [Központosítottak].[Mező4]='')  AND ([Központosítottak].[Mező4]<> 'üres állás' OR [Központosítottak].[Mező4] is null ) 
 UNION SELECT 'Központosítottak' AS Tábla, 'Adóazonosító' AS Hiányzó_érték, Központosítottak.[Adóazonosító], Központosítottak.[Álláshely azonosító], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] FROM [Központosítottak] 
WHERE ([Központosítottak].[Adóazonosító] Is Null )  AND ([Központosítottak].[Mező4]<> 'üres állás' OR [Központosítottak].[Mező4] is null ) 
 UNION SELECT 'Központosítottak' AS Tábla, 'Név' AS Hiányzó_érték, Központosítottak.[Adóazonosító], Központosítottak.[Álláshely azonosító], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] FROM [Központosítottak] 
WHERE ([Központosítottak].[Név] Is Null OR [Központosítottak].[Név]='')  AND ([Központosítottak].[Mező4]<> 'üres állás' OR [Központosítottak].[Mező4] is null );

#/#/#/
lk_Ellenőrzés_01a
#/#/
SELECT [01a].Tábla, [01a].Hiányzó_érték, [01a].Adóazonosító, [01a].[Álláshely azonosító], [01a].[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], [Adóazonosító]*1 AS adójel
FROM (SELECT 'lkKilépők' AS Tábla, 'Jogviszony megszűnésének, megszüntetésének időpontja' AS Hiányzó_érték, lkKilépőUnió.[Adóazonosító], lkKilépőUnió.[Álláshely azonosító], lkKilépőUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
FROM [lkKilépőUnió] 
WHERE (([lkKilépőUnió].[Jogviszony megszűnésének, megszüntetésének időpontja] Is Null ) AND ((lkKilépőUnió.Év)>(Select dtátal(Min(TulajdonságÉrték)) From tAlapadatok Where TulajdonságNeve="VizsgáltElsőÉv")))
UNION 
SELECT 'lkKilépők' AS Tábla, 'Jogviszony kezdő dátuma' AS Hiányzó_érték, lkKilépőUnió.[Adóazonosító], lkKilépőUnió.[Álláshely azonosító], lkKilépőUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
FROM [lkKilépőUnió] 
WHERE (([lkKilépőUnió].[Jogviszony kezdő dátuma] Is Null ) AND ((lkKilépőUnió.Év)>(Select dtátal(Min(TulajdonságÉrték)) From tAlapadatok Where TulajdonságNeve="VizsgáltElsőÉv")))
UNION
SELECT 'lkKilépők' AS Tábla, 'Jogviszony megszűnésének, megszüntetésének oka: jogszabályi hivatkozás száma (§, bek., pontja)' AS Hiányzó_érték, lkKilépőUnió.[Adóazonosító], lkKilépőUnió.[Álláshely azonosító], lkKilépőUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
FROM [lkKilépőUnió] 
WHERE (([lkKilépőUnió].[Jogviszony megszűnésének, megszüntetésének oka: jogszabályi hiva] Is Null OR [lkKilépőUnió].[Jogviszony megszűnésének, megszüntetésének oka: jogszabályi hiva]='') AND ((lkKilépőUnió.Év)>(Select dtátal(Min(TulajdonságÉrték)) From tAlapadatok Where TulajdonságNeve="VizsgáltElsőÉv")))
UNION
SELECT 'lkKilépők' AS Tábla, 'Álláshely azonosító' AS Hiányzó_érték, lkKilépőUnió.[Adóazonosító], lkKilépőUnió.[Álláshely azonosító], lkKilépőUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
FROM [lkKilépőUnió] 
WHERE ( ([lkKilépőUnió].[Álláshely azonosító] Is Null OR [lkKilépőUnió].[Álláshely azonosító]='') AND ((lkKilépőUnió.Év)>(Select dtátal(Min(TulajdonságÉrték)) From tAlapadatok Where TulajdonságNeve="VizsgáltElsőÉv")))
UNION
SELECT 'lkKilépők' AS Tábla, 'Ellátott feladatok megjelölése
a fővárosi és megyei kormányhivatalok szervezeti és működési szabályzatáról szóló 3/2020. (II. 28.) MvM utasítás alapján' AS Hiányzó_érték, lkKilépőUnió.[Adóazonosító], lkKilépőUnió.[Álláshely azonosító], lkKilépőUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [lkKilépőUnió] 
WHERE (([lkKilépőUnió].[Mező8] Is Null OR [lkKilépőUnió].[Mező8]='') AND ((lkKilépőUnió.Év)>(Select dtátal(Min(TulajdonságÉrték)) From tAlapadatok Where TulajdonságNeve="VizsgáltElsőÉv")))
UNION
SELECT 'lkKilépők' AS Tábla, 'ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ' AS Hiányzó_érték, lkKilépőUnió.[Adóazonosító], lkKilépőUnió.[Álláshely azonosító], lkKilépőUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [lkKilépőUnió] 
WHERE (([lkKilépőUnió].[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] Is Null OR [lkKilépőUnió].[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]='') AND ((lkKilépőUnió.Év)>(Select dtátal(Min(TulajdonságÉrték)) From tAlapadatok Where TulajdonságNeve="VizsgáltElsőÉv")))
UNION
SELECT 'lkKilépők' AS Tábla, 'Szervezeti egység
Osztály megnevezése' AS Hiányzó_érték, lkKilépőUnió.[Adóazonosító], lkKilépőUnió.[Álláshely azonosító], lkKilépőUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [lkKilépőUnió] 
WHERE (([lkKilépőUnió].[Mező6] Is Null OR [lkKilépőUnió].[Mező6]='') AND ((lkKilépőUnió.Év)>(Select dtátal(Min(TulajdonságÉrték)) From tAlapadatok Where TulajdonságNeve="VizsgáltElsőÉv")))
UNION
SELECT 'lkKilépők' AS Tábla, 'Szervezeti egység
Főosztály megnevezése' AS Hiányzó_érték, lkKilépőUnió.[Adóazonosító], lkKilépőUnió.[Álláshely azonosító], lkKilépőUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [lkKilépőUnió] 
WHERE (([lkKilépőUnió].[Mező5] Is Null OR [lkKilépőUnió].[Mező5]='') AND ((lkKilépőUnió.Év)>(Select dtátal(Min(TulajdonságÉrték)) From tAlapadatok Where TulajdonságNeve="VizsgáltElsőÉv")))
UNION
SELECT 'lkKilépők' AS Tábla, 'Megyei szint VAGY Járási Hivatal' AS Hiányzó_érték, lkKilépőUnió.[Adóazonosító], lkKilépőUnió.[Álláshely azonosító], lkKilépőUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [lkKilépőUnió] 
WHERE (([lkKilépőUnió].[Megyei szint VAGY Járási Hivatal] Is Null OR [lkKilépőUnió].[Megyei szint VAGY Járási Hivatal]='') AND ((lkKilépőUnió.Év)>(Select dtátal(Min(TulajdonságÉrték)) From tAlapadatok Where TulajdonságNeve="VizsgáltElsőÉv")))
UNION
SELECT 'lkKilépők' AS Tábla, 'Adóazonosító' AS Hiányzó_érték, lkKilépőUnió.[Adóazonosító], lkKilépőUnió.[Álláshely azonosító], lkKilépőUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [lkKilépőUnió] 
WHERE (([lkKilépőUnió].[Adóazonosító] Is Null ) AND ((lkKilépőUnió.Év)>(Select dtátal(Min(TulajdonságÉrték)) From tAlapadatok Where TulajdonságNeve="VizsgáltElsőÉv")))
)  AS 01a;

#/#/#/
lk_Ellenőrzés_01b
#/#/
SELECT [01b].Tábla, [01b].Hiányzó_érték, [01b].Adóazonosító, [01b].[Álláshely azonosító], [01b].[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], [Adóazonosító]*1 AS Adójel
FROM (SELECT 'lkBelépők' AS Tábla, 'Adóazonosító' AS Hiányzó_érték, lkBelépők.[Adóazonosító], lkBelépők.[Álláshely azonosító], lkBelépők.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [lkBelépők]  WHERE ([lkBelépők].[Adóazonosító] Is Null )   

UNION SELECT 'lkBelépők' AS Tábla, 'Név' AS Hiányzó_érték, lkBelépők.[Adóazonosító], lkBelépők.[Álláshely azonosító], lkBelépők.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [lkBelépők]  WHERE ([lkBelépők].[Név] Is Null OR [lkBelépők].[Név]='')   

UNION SELECT 'Központosítottak' AS Tábla, 'Legmagasabb iskolai végzettség 1=8. osztály; 2=érettségi; 3=főiskolai végzettség; 4=egyetemi végzettség; 5=technikus; 6= KAB vizsga' AS Hiányzó_érték, Központosítottak.[Adóazonosító], Központosítottak.[Álláshely azonosító], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] FROM [Központosítottak]  WHERE ([Központosítottak].[Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis] Is Null )  AND ([Központosítottak].[Mező4]<> 'üres állás' OR [Központosítottak].[Mező4] is null )   

UNION SELECT 'Központosítottak' AS Tábla, 'Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)' AS Hiányzó_érték, Központosítottak.[Adóazonosító], Központosítottak.[Álláshely azonosító], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] FROM [Központosítottak]  WHERE ([Központosítottak].[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)] Is Null OR [Központosítottak].[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)]='')  AND ([Központosítottak].[Mező4]<> 'üres állás' OR [Központosítottak].[Mező4] is null )   



  UNION SELECT 'Központosítottak' AS Tábla, 'Havi illetmény teljes összege (kerekítve) (FT)' AS Hiányzó_érték, Központosítottak.[Adóazonosító], Központosítottak.[Álláshely azonosító], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] FROM [Központosítottak]  WHERE ([Központosítottak].[Mező17] Is Null )  AND ([Központosítottak].[Mező4]<> 'üres állás' OR [Központosítottak].[Mező4] is null )  

 UNION SELECT 'Központosítottak' AS Tábla, 'Álláshely azonosító' AS Hiányzó_érték, Központosítottak.[Adóazonosító], Központosítottak.[Álláshely azonosító], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] FROM [Központosítottak]  WHERE ([Központosítottak].[Álláshely azonosító] Is Null OR [Központosítottak].[Álláshely azonosító]='')  AND ([Központosítottak].[Mező4]<> 'üres állás' OR [Központosítottak].[Mező4] is null )

   UNION SELECT 'Központosítottak' AS Tábla, 'Besorolási fokozat megnevezése:' AS Hiányzó_érték, Központosítottak.[Adóazonosító], Központosítottak.[Álláshely azonosító], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] FROM [Központosítottak]  WHERE ([Központosítottak].[Besorolási fokozat megnevezése:] Is Null OR [Központosítottak].[Besorolási fokozat megnevezése:]='')  AND ([Központosítottak].[Mező4]<> 'üres állás' OR [Központosítottak].[Mező4] is null )  

 UNION SELECT 'Központosítottak' AS Tábla, 'Besorolási fokozat kód:' AS Hiányzó_érték, Központosítottak.[Adóazonosító], Központosítottak.[Álláshely azonosító], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] FROM [Központosítottak]  WHERE ([Központosítottak].[Besorolási fokozat kód:] Is Null OR [Központosítottak].[Besorolási fokozat kód:]='')  AND ([Központosítottak].[Mező4]<> 'üres állás' OR [Központosítottak].[Mező4] is null )   

UNION SELECT 'Központosítottak' AS Tábla, 'Álláshely betöltésének aránya és Üres álláshely betöltés aránya' AS Hiányzó_érték, Központosítottak.[Adóazonosító], Központosítottak.[Álláshely azonosító], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] FROM [Központosítottak]  WHERE ([Központosítottak].[Mező13] Is Null )  AND ([Központosítottak].[Mező4]<> 'üres állás' OR [Központosítottak].[Mező4] is null )
)  AS 01b;

#/#/#/
lk_Ellenőrzés_01c
#/#/
SELECT [01c].Tábla, [01c].Hiányzó_érték, [01c].Adóazonosító, [01c].[Álláshely azonosító], [01c].[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], [Adóazonosító]*1 AS Adójel
FROM (SELECT 'lkKilépők' AS Tábla, 'Név' AS Hiányzó_érték, lkKilépők.[Adóazonosító], lkKilépők.[Álláshely azonosító], lkKilépők.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [lkKilépők] 
WHERE ([lkKilépők].[Név] Is Null OR [lkKilépők].[Név]='') 
 UNION SELECT 'lkBelépők' AS Tábla, 'Illetmény (Ft/hó)' AS Hiányzó_érték, lkBelépők.[Adóazonosító], lkBelépők.[Álláshely azonosító], lkBelépők.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [lkBelépők] 
WHERE ([lkBelépők].[Illetmény (Ft/hó)] Is Null ) 
 UNION SELECT 'lkBelépők' AS Tábla, 'Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)' AS Hiányzó_érték, lkBelépők.[Adóazonosító], lkBelépők.[Álláshely azonosító], lkBelépők.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [lkBelépők] 
WHERE ([lkBelépők].[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)] Is Null OR [lkBelépők].[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)]='') 
 UNION SELECT 'lkBelépők' AS Tábla, 'Jogviszony kezdő dátuma' AS Hiányzó_érték, lkBelépők.[Adóazonosító], lkBelépők.[Álláshely azonosító], lkBelépők.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [lkBelépők] 
WHERE ([lkBelépők].[Jogviszony kezdő dátuma] Is Null ) 
 UNION SELECT 'lkBelépők' AS Tábla, 'Álláshely azonosító' AS Hiányzó_érték, lkBelépők.[Adóazonosító], lkBelépők.[Álláshely azonosító], lkBelépők.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [lkBelépők] 
WHERE ([lkBelépők].[Álláshely azonosító] Is Null OR [lkBelépők].[Álláshely azonosító]='') 
 UNION SELECT 'lkBelépők' AS Tábla, 'Ellátott feladatok megjelölése
a fővárosi és megyei kormányhivatalok szervezeti és működési szabályzatáról szóló 3/2020. (II. 28.) MvM utasítás alapján' AS Hiányzó_érték, lkBelépők.[Adóazonosító], lkBelépők.[Álláshely azonosító], lkBelépők.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [lkBelépők] 
WHERE ([lkBelépők].[Mező8] Is Null OR [lkBelépők].[Mező8]='') 
 UNION SELECT 'lkBelépők' AS Tábla, 'ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ' AS Hiányzó_érték, lkBelépők.[Adóazonosító], lkBelépők.[Álláshely azonosító], lkBelépők.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [lkBelépők] 
WHERE ([lkBelépők].[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] Is Null OR [lkBelépők].[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]='') 
 UNION SELECT 'lkBelépők' AS Tábla, 'Szervezeti egység
Osztály megnevezése' AS Hiányzó_érték, lkBelépők.[Adóazonosító], lkBelépők.[Álláshely azonosító], lkBelépők.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [lkBelépők] 
WHERE ([lkBelépők].[Mező6] Is Null OR [lkBelépők].[Mező6]='') 
 UNION SELECT 'lkBelépők' AS Tábla, 'Szervezeti egység
Főosztály megnevezése' AS Hiányzó_érték, lkBelépők.[Adóazonosító], lkBelépők.[Álláshely azonosító], lkBelépők.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [lkBelépők] 
WHERE ([lkBelépők].[Mező5] Is Null OR [lkBelépők].[Mező5]='') 
 UNION SELECT 'lkBelépők' AS Tábla, 'Megyei szint VAGY Járási Hivatal' AS Hiányzó_érték, lkBelépők.[Adóazonosító], lkBelépők.[Álláshely azonosító], lkBelépők.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [lkBelépők] 
WHERE ([lkBelépők].[Megyei szint VAGY Járási Hivatal] Is Null OR [lkBelépők].[Megyei szint VAGY Járási Hivatal]='')
)  AS 01c;

#/#/#/
lk_Ellenőrzés_01d_Illetmény_nulla
#/#/
SELECT [01D].Tábla, [01D].Hiányzó_érték, [01D].Adójel AS Adóazonosító, [01D].[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], [Álláshely azonosító]
FROM (SELECT 'Járási_állomány' as Tábla, 'Illetmény' As [Hiányzó_érték], [Adóazonosító] As Adójel, [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]  , [Álláshely azonosító]
 FROM [Járási_állomány] WHERE [Mező18]=0 AND ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null )  
UNION 
SELECT 'Kormányhivatali_állomány' as Tábla, 'Illetmény' As [Hiányzó érték], [Adóazonosító] As Adójel, [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] As SzervezetKód , [Álláshely azonosító]
 FROM [Kormányhivatali_állomány] WHERE [Mező18]=0 AND ([Kormányhivatali_állomány].[Mező4]<> 'üres állás' OR [Kormányhivatali_állomány].[Mező4] is null )  
UNION 
SELECT 'Központosítottak' as Tábla, 'Illetmény' As [Hiányzó érték], [Adóazonosító] As Adójel, [Nexon szótárelemnek megfelelő szervezeti egység azonosító] As SzervezetKód , [Álláshely azonosító]
 FROM [Központosítottak] WHERE [Mező17]=0 AND ([Központosítottak].[Mező4]<> 'üres állás' OR [Központosítottak].[Mező4] is null )  
UNION 
SELECT 'lkBelépők' as Tábla, 'Illetmény' As [Hiányzó érték], [Adóazonosító] As Adójel, [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] As SzervezetKód , [Álláshely azonosító]
FROM [lkBelépők] WHERE [Illetmény (Ft/hó)]=0 AND ([lkBelépők].[Üres]<> 'üres állás' OR [lkBelépők].[Üres] is null )  
UNION 
SELECT 'lkKilépők' as Tábla, 'Illetmény' As [Hiányzó érték], [Adóazonosító] As Adójel, [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] As SzervezetKód , [Álláshely azonosító]
FROM [lkKilépők] WHERE [Illetmény (Ft/hó)]=0 AND ([lkKilépők].[Üres]<> 'üres állás' OR [lkKilépők].[Üres] is null )  
UNION 
SELECT 'lkHatározottak_TT' as Tábla, 'Illetmény' As [Hiányzó érték], [Adóazonosító] As Adójel, [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] As SzervezetKód, [Álláshely azonosító]
 FROM [lkHatározottak_TT] WHERE [Tartósan távollévő illetményének teljes összege]=0 AND ([lkHatározottak_TT].[Üres]<> 'üres állás' OR [lkHatározottak_TT].[Üres] is null )  
UNION 
SELECT 'lkHatározottak_TTH' as Tábla, 'Illetmény' As [Hiányzó érték], [Mező17] As Adójel, [Mező25] As SzervezetKód , [Mező25]
FROM [lkHatározottak_TTH] WHERE [Tartós távollévő státuszán foglalkoztatott illetményének teljes ]=0 AND ([lkHatározottak_TTH].[Üres]<> 'üres állás' OR [lkHatározottak_TTH].[Üres] is null )
)  AS 01D;

#/#/#/
lk_Ellenőrzés_01e_Részmunkaidő_Munkaidő_eltérések_Személy-ben
#/#/
SELECT "Személytörzs" AS Tábla, IIf(IIf([elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]=40,"T","R")="T" And Switch([Foglalkozási viszony statisztikai besorolása] Like "*teljes*","T",[Foglalkozási viszony statisztikai besorolása] Like "*részmunkaidős*","R",[Foglalkozási viszony statisztikai besorolása] Not Like "*teljes*" And [Foglalkozási viszony statisztikai besorolása] Not Like "*részmunkaidős*","-")="R","Részmunkaidősnek van jelölve, de teljes munkaidőben dolgozik.","Teljes munkaidősnek van jelölve, de részmunkaidőben dolgozik.") AS [Hiányzó érték], lkSzemélyek.[Adóazonosító jel] AS Adóazonosító, lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], lkSzemélyek.[Szervezeti egység kódja] AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkSzemélyek.Adójel
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz kódja]) Like "S-*") AND ((lkSzemélyek.[Foglalkozási viszony statisztikai besorolása]) Not Like "Á*") AND ((IIf([elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]=40,"T","R")<>Switch([Foglalkozási viszony statisztikai besorolása] Like "*teljes*","T",[Foglalkozási viszony statisztikai besorolása] Like "*részmunkaidős*","R",[Foglalkozási viszony statisztikai besorolása] Not Like "*teljes*" And [Foglalkozási viszony statisztikai besorolása] Not Like "*részmunkaidős*","-"))=True));

#/#/#/
lk_Ellenőrzés_01e_Részmunkaidő_Munkaidő_eltérések_táblákban
#/#/
SELECT DISTINCT "Személy és Havi" AS Tábla, UnióUnió.Hiányzó_érték, UnióUnió.Adóazonosító, UnióUnió.[Álláshely azonosító], UnióUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], UnióUnió.Adójel
FROM (SELECT DISTINCT Tábla, RészmunkaidősUnió.Hiányzó_érték, RészmunkaidősUnió.Adóazonosító, RészmunkaidősUnió.[Álláshely azonosító], RészmunkaidősUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], [Adóazonosító]*1 AS Adójel
FROM (SELECT "Kormányhivatali_állomány" AS Tábla
, "Részmunkaidősnek van jelölve, de teljes munkaidőben dolgozik." AS [Hiányzó_érték]
, Kormányhivatali_állomány.Adóazonosító, Kormányhivatali_állomány.[Álláshely azonosító]
, Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
, Kormányhivatali_állomány.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ]
, Kormányhivatali_állomány.[Heti munkaórák száma]
, IIf(Right([Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ],1)="R" And [Heti munkaórák száma]=40,True,False) AS Hibás
FROM Kormányhivatali_állomány
WHERE (((
IIf
             (Right([Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ],1)="R" 
     And [Heti munkaórák száma]=40
   ,True
   ,False))
=-1))
UNION
SELECT "Járási_állomány" AS Tábla
, "Részmunkaidősnek van jelölve, de teljes munkaidőben dolgozik." AS [Hibás érték]
, Járási_állomány.Adóazonosító
, Járási_állomány.[Álláshely azonosító]
, Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
, Járási_állomány.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ]
, Járási_állomány.[Heti munkaórák száma]
, IIf(Right([Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ],1)="R" And [Heti munkaórák száma]=40,True,False) AS Hibás
FROM Járási_állomány
WHERE (((
IIf
             (Right([Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ],1)="R" 
     And [Heti munkaórák száma]=40
   ,True
   ,False))
=-1))
UNION
SELECT "Kormányhivatali_állomány" AS Tábla
, "Teljes munkaidősnek van jelölve, de részmunkaidőben dolgozik." AS [Hibás érték]
, Kormányhivatali_állomány.Adóazonosító, Kormányhivatali_állomány.[Álláshely azonosító]
, Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
, Kormányhivatali_állomány.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ]
, Kormányhivatali_állomány.[Heti munkaórák száma]
, IIf(Right([Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ],1)="T" And [Heti munkaórák száma]<>40,True,False) AS Hibás
FROM Kormányhivatali_állomány
WHERE (((
IIf
             (Right([Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ],1)="T" 
     And [Heti munkaórák száma]<>40
   ,True
   ,False))
=-1))
UNION SELECT "Járási_állomány" AS Tábla
, "Teljes munkaidősnek van jelölve, de részmunkaidőben dolgozik." AS [Hibás érték]
, Járási_állomány.Adóazonosító
, Járási_állomány.[Álláshely azonosító]
, Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
, Járási_állomány.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ]
, Járási_állomány.[Heti munkaórák száma]
, IIf(Right([Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ],1)="T" And [Heti munkaórák száma]<>40,True,False) AS Hibás
FROM Járási_állomány
WHERE (((
IIf
             (Right([Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ],1)="T" 
     And [Heti munkaórák száma]<>40
   ,True
   ,False))
=-1))
)  AS RészmunkaidősUnió
UNION SELECT *
FROM [lk_Ellenőrzés_01e_Részmunkaidő_Munkaidő_eltérések_Személy-ben])  AS UnióUnió;

#/#/#/
lk_Ellenőrzés_01f_hiányzó_besorolás_megnevezés
#/#/
SELECT Unió5tábla.Tábla, Unió5tábla.Hiányzó_érték, Unió5tábla.Adóazonosító, Unió5tábla.[Álláshely azonosító], Unió5tábla.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], [Adóazonosító]*1 AS Adójel
FROM (SELECT Kormányhivatali_állomány.Adóazonosító, Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], "Kormányhivatali_állomány" AS Tábla, "Besorolási fokozat megnevezése:" AS Hiányzó_érték, Kormányhivatali_állomány.[Besorolási fokozat megnevezése:]
FROM Kormányhivatali_állomány LEFT JOIN lkSzemélyek ON Kormányhivatali_állomány.Adóazonosító = lkSzemélyek.[Adóazonosító jel]
WHERE (((lkSzemélyek.[Jogviszony típusa / jogviszony típus])<>"hivatásos állományú"))

UNION
SELECT Kormányhivatali_állomány.Adóazonosító, Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], "Kormányhivatali_állomány" AS Tábla, "Besorolási fokozat megnevezése:" AS Hiányzó_érték, Kormányhivatali_állomány.[Besorolási fokozat megnevezése:]
FROM Kormányhivatali_állomány LEFT JOIN lkSzemélyek ON Kormányhivatali_állomány.Adóazonosító = lkSzemélyek.[Adóazonosító jel]
WHERE (((lkSzemélyek.[Jogviszony típusa / jogviszony típus])<>"hivatásos állományú"))

UNION
SELECT Központosítottak.Adóazonosító, Központosítottak.[Álláshely azonosító], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító], "Központosítottak" as Tábla, "Besorolási fokozat megnevezése:" as Hiányzó_érték,  [Besorolási fokozat megnevezése:]
FROM   Központosítottak
WHERE '///--- Töröltem, mert a ki- és belépők táblákból a jogviszony nem állapítható meg, de a munkaviszonyosokra nem jön le adat
UNION
SELECT lkBelépők.Adóazonosító, lkBelépők.[Álláshely azonosító], lkBelépők.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], "lkBelépők" as Tábla, "Besorolási fokozat megnevezése:" as Hiányzó_érték, [Besorolási fokozat megnevezése:]
FROM lkBelépők

UNION
SELECT lkKilépők.Adóazonosító, lkKilépők.[Álláshely azonosító], lkKilépők.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], "lkKilépők" as Tábla, "Besorolási fokozat megnevezése:" as Hiányzó_érték, [Besorolási fokozat megnevezése:]
FROM lkKilépők
---///'

)  AS Unió5tábla
WHERE (((Unió5tábla.[Besorolási fokozat megnevezése:]) Is Null Or (Unió5tábla.[Besorolási fokozat megnevezése:])="Error 2042"));

#/#/#/
lk_Ellenőrzés_01f2_hiányzó_besorolás_megnevezésSzemély
#/#/
SELECT "Személytörzs alapriport" AS Tábla, "Besorolási fokozat (Személytörzs)" AS Hiányzó_érték, lkSzemélyek.[Adóazonosító jel] AS Adóazonosító, lkSzemélyek.[státusz kódja] AS [Álláshely azonosító], lkSzemélyek.[szervezeti egység kódja] AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkSzemélyek.Adójel
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Besorolási  fokozat (KT)]) Is Null) AND ((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Jogviszony típusa / jogviszony típus])<>"Hivatásos állományú" And (lkSzemélyek.[Jogviszony típusa / jogviszony típus])<>"Munkaviszony"));

#/#/#/
lk_Ellenőrzés_01g_MunkahelyCímHiánya
#/#/
SELECT "tSzemélyek" AS Tábla, "Munkavégzés helye - cím" AS Hiányzó_érték, lkSzemélyek.Adójel AS Adóazonosító, lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], lkSzemélyek.[Szervezeti egység kódja] AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkSzemélyek.Adójel
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null) AND ((lkSzemélyek.[Munkavégzés helye - cím]) Is Null) AND ((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null));

#/#/#/
lk_Ellenőrzés_01h_HivataliEmailHiánya
#/#/
SELECT lk_Ellenőrzés_01h_HivataliEmailHiánya00.Tábla, lk_Ellenőrzés_01h_HivataliEmailHiánya00.Hiányzó_érték, lk_Ellenőrzés_01h_HivataliEmailHiánya00.Adóazonosító, lk_Ellenőrzés_01h_HivataliEmailHiánya00.[Álláshely azonosító], lk_Ellenőrzés_01h_HivataliEmailHiánya00.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lk_Ellenőrzés_01h_HivataliEmailHiánya00.Adójel
FROM lk_Ellenőrzés_01h_HivataliEmailHiánya00
GROUP BY lk_Ellenőrzés_01h_HivataliEmailHiánya00.Tábla, lk_Ellenőrzés_01h_HivataliEmailHiánya00.Hiányzó_érték, lk_Ellenőrzés_01h_HivataliEmailHiánya00.Adóazonosító, lk_Ellenőrzés_01h_HivataliEmailHiánya00.[Álláshely azonosító], lk_Ellenőrzés_01h_HivataliEmailHiánya00.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lk_Ellenőrzés_01h_HivataliEmailHiánya00.Adójel;

#/#/#/
lk_Ellenőrzés_01h_HivataliEmailHiánya00
#/#/
SELECT "Személytörzs" AS Tábla, "Hivatali email" AS Hiányzó_érték, tSzemélyek.[Adóazonosító jel] AS Adóazonosító, tSzemélyek.[Státusz kódja] AS [Álláshely azonosító], tSzemélyek.[Szervezeti egység kódja] AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], tSzemélyek.Adójel, tSzemélyek.[Jogviszony sorszáma]
FROM tSzemélyek
WHERE (((tSzemélyek.[Státusz neve])="Álláshely") AND ((Len(Nz([Hivatali email]," ")))<4) AND ((tSzemélyek.[Tartós távollét típusa]) Is Null))
ORDER BY tSzemélyek.Adójel, tSzemélyek.[Jogviszony sorszáma] DESC;

#/#/#/
lk_Ellenőrzés_01i_FeladatkörNélküliek
#/#/
SELECT DISTINCT "Személytörzs" AS Tábla, "KIRA feladatkör" AS Hiányzó_érték, lkSzemélyek.[Adóazonosító jel] AS Adóazonosító, lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], lkSzemélyek.[Szervezeti egység kódja] AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkSzemélyek.Adójel
FROM lkSzemélyek
WHERE (((lkSzemélyek.[KIRA feladat megnevezés]) Is Null Or (lkSzemélyek.[KIRA feladat megnevezés])="") AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY "KIRA feladatkör";

#/#/#/
lk_Ellenőrzés_01j_NemInaktívTT_s
#/#/
SELECT "Személyek vs. Szervezeti" AS Tábla, "A 'tartós távollét típusa': <üres>, ugyanakkor a 'Státuszbetöltés típusa': ""Inaktív""" AS Hiányzó_érték, lkSzemélyek.[Adóazonosító jel] AS Adóazonosító, lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], lkSzemélyek.[Szervezeti egység kódja] AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkSzemélyek.Adójel
FROM lk_InaktívBetöltőkÉsÁlláshelyük RIGHT JOIN lkSzemélyek ON lk_InaktívBetöltőkÉsÁlláshelyük.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Tartós távollét típusa]) Is Null) AND ((lk_InaktívBetöltőkÉsÁlláshelyük.Adójel) Is Not Null) AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
AND "####Az inaktív betöltők között keresi meg azokat, akiknek a tartós távollét típusa mező a személytörzsben Null. #####";

#/#/#/
lk_Ellenőrzés_01jj_InaktívNemTT_s
#/#/
SELECT "Személyek vs. Szervezeti" AS Tábla, "A 'tartós távollét típusa': """ & [Tartós távollét típusa] & """, ugyanakkor a 'Státuszbetöltés típusa': nem ""Inaktív""" AS Hiányzó_érték, lkSzemélyek.[Adóazonosító jel] AS Adóazonosító, lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], lkSzemélyek.[Szervezeti egység kódja] AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkSzemélyek.Adójel
FROM lk_InaktívBetöltőkÉsÁlláshelyük LEFT JOIN lkSzemélyek ON lk_InaktívBetöltőkÉsÁlláshelyük.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Tartós távollét típusa]) Is Not Null) AND ((lk_InaktívBetöltőkÉsÁlláshelyük.Adójel) Is Null) AND ((lkSzemélyek.[Státusz neve])="Álláshely") AND (("##### Azokat keresi a személytörzsben, akiknek a tartós távollét típusa nem Null, de az inaktív betöltők lekérdezésben nem szerepelnek. ####")<>""));

#/#/#/
lk_Ellenőrzés_01k_UtalásiCímHiánya
#/#/
SELECT "tSzemélyek" AS Tábla, "Utalási - cím" AS Hiányzó_érték, lkSzemélyek.Adójel AS Adóazonosító, lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], lkSzemélyek.[Szervezeti egység kódja] AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkSzemélyek.Adójel
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null) AND ((ffsplit([Utalási cím],"|",3))="") AND ((lkSzemélyek.[Státusz típusa]) Is Not Null));

#/#/#/
lk_Ellenőrzés_01L_IskolaiVégzettségFoka
#/#/
SELECT "tSzemélyek" AS Tábla, "A legmagasabb iskolai végzettség foka" AS Hiányzó_érték, lkSzemélyek.Adójel AS Adóazonosító, lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], lkSzemélyek.[Szervezeti egység kódja] AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkSzemélyek.Adójel
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null) AND ((lkSzemélyek.[Iskolai végzettség foka]) Is Null) AND ((lkSzemélyek.[Státusz típusa]) Is Not Null));

#/#/#/
lk_Ellenőrzés_01m_AlapvizsgaHiánya
#/#/
SELECT "tSzemélyek" AS Tábla, "Letelt a próbaidő, de nincs alapvizsga határidő kitűzve" AS Hiányzó_érték, lkSzemélyek.Adójel AS Adóazonosító, lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], lkSzemélyek.[Szervezeti egység kódja] AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkSzemélyek.Adójel, lkSzemélyek.[Alapvizsga letétel tényleges határideje] AS AlapHatáridő, lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége] AS PróbaidőVége, lkSzemélyek.[Alapvizsga mentesség], lkSzemélyek.[Státusz neve]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null) AND ((lkSzemélyek.[Alapvizsga letétel tényleges határideje]) Is Null) AND ((lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége])<Date()) AND ((lkSzemélyek.[Alapvizsga mentesség])<>True) AND ((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Státusz típusa]) Is Not Null));

#/#/#/
lk_Ellenőrzés_01m_EskületételIdőpontHiány
#/#/
SELECT "tEsküLejártIdőpontok" AS Tábla, "Eskületétel időpontja" AS Hiányzó_érték, lkSzemélyek.[Adóazonosító jel] AS Adóazonosító, lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], lkSzemélyek.[szervezeti egység kódja] AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkSzemélyek.Adójel
FROM lkSzemélyek LEFT JOIN lkLejáróHatáridők ON lkSzemélyek.[Adóazonosító jel] = lkLejáróHatáridők.[Adóazonosító jel]
WHERE (((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)]) Between DateSerial(2024,11,1) And DateSerial(Year(Now()),Month(Now())-1,1)) AND ((lkLejáróHatáridők.[Figyelendő dátum])=0) AND ((lkSzemélyek.[Státusz neve])="álláshely") AND ((lkSzemélyek.[Jogviszony típusa / jogviszony típus])="Kormányzati szolgálati jogviszony"));

#/#/#/
lk_Ellenőrzés_01n_KözpontosítottKöltséghelyNélkül
#/#/
SELECT DISTINCT "tSzemélyek" AS Tábla, "Központosított álláshelyhez nincs megjelölve költséghely vagy költséghely-kód (projekt)." AS Hiányzó_érték, lkSzemélyek.Adójel AS Adóazonosító, lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], lkSzemélyek.[Szervezeti egység kódja] AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkSzemélyek.Adójel
FROM kt_azNexon_Adójel02 RIGHT JOIN lkSzemélyek ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null) AND (([lkSzemélyek].[Státusz költséghelyének neve]) Is Null) AND ((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Státusz típusa])="Központosított állomány")) OR (((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Státusz típusa])="Központosított állomány") AND ((lkSzemélyek.[Státusz költséghelyének kódja]) Is Null));

#/#/#/
lk_Ellenőrzés_01n_KözpontosítottKöltséghelyNélkülDolgozó
#/#/
SELECT DISTINCT "tSzemélyek" AS Tábla, "Központosított álláshelyhez nincs megjelölve költséghely vagy költséghely-kód (projekt)." AS Hiányzó_érték, lkSzemélyek.Adójel AS Adóazonosító, lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], lkSzemélyek.[Szervezeti egység kódja] AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkSzemélyek.Adójel
FROM kt_azNexon_Adójel02 RIGHT JOIN lkSzemélyek ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Dolgozó költséghelyének kódja]) Is Null) AND ((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Státusz típusa])="Központosított állomány")) OR (((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Státusz típusa])="Központosított állomány") AND ((lkSzemélyek.[Dolgozó költséghelyének neve]) Is Null));

#/#/#/
lk_Ellenőrzés_01nn_HavibólKözpontosítottKöltséghelyNélkül
#/#/
SELECT DISTINCT "Központosítottak" AS Tábla, "Központosított álláshelyhez nincs megjelölve költséghely vagy költséghely-kód (projekt megnevezése)." AS Hiányzó_érték, KözpontosítottakAllekérdezés.Adóazonosító, KözpontosítottakAllekérdezés.[Álláshely azonosító], KözpontosítottakAllekérdezés.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], KözpontosítottakAllekérdezés.Adójel
FROM (SELECT Nz([Adóazonosító],0)*1 AS Adójel, * FROM lkKözpontosítottak WHERE Nz([Adóazonosító],0)<>0 AND Adóazonosító<>"")  AS KözpontosítottakAllekérdezés RIGHT JOIN kt_azNexon_Adójel02 ON KözpontosítottakAllekérdezés.Adójel = kt_azNexon_Adójel02.Adójel
WHERE (((KözpontosítottakAllekérdezés.[Születési év \ üres állás])<>"üres állás") AND ((KözpontosítottakAllekérdezés.[Projekt megnevezése])=""));

#/#/#/
lk_Ellenőrzés_01o_TTs_OkHiánya
#/#/
SELECT [01O].Tábla, [01O].Hiányzó_érték, [01O].Adójel AS Adóazonosító, [01O].[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], [01O].[Álláshely azonosító]
FROM (SELECT 'Járási_állomány' AS Tábla, 'TT oka' AS [Hiányzó_érték], Járási_állomány.[Adóazonosító] AS Adójel, Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Járási_állomány.[Álláshely azonosító]
FROM Járási_állomány
WHERE (((Járási_állomány.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h])<>"GB" And (Járási_állomány.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h])<>"") AND ((Járási_állomány.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp])="") AND ((Járási_állomány.Mező4)<>'üres állás' Or (Járási_állomány.Mező4) Is Null))
UNION
SELECT 'Kormányhivatali_állomány' AS Tábla, 'TT oka' AS [Hiányzó_érték], Kormányhivatali_állomány.Adóazonosító AS Adójel, Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] AS SzervezetKód, Kormányhivatali_állomány.[Álláshely azonosító]
FROM Kormányhivatali_állomány
WHERE (((Kormányhivatali_állomány.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h])<>"GB" And (Kormányhivatali_állomány.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h])<>"") AND ((Kormányhivatali_állomány.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp])="") AND ((Kormányhivatali_állomány.Mező4)<>'üres állás' Or (Kormányhivatali_állomány.Mező4) Is Null))
UNION
SELECT 'Központosítottak' AS Tábla, 'TT oka' AS [Hiányzó_érték], Központosítottak.[Adóazonosító] AS Adójel, Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] AS SzervezetKód, Központosítottak.[Álláshely azonosító]
FROM Központosítottak
WHERE (((Központosítottak.[Tartós távollévő nincs helyettese (TT)/ tartós távollévőnek van ])<>"GB" And (Központosítottak.[Tartós távollévő nincs helyettese (TT)/ tartós távollévőnek van ])<>"") AND ((Központosítottak.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp])="") AND ((Központosítottak.Mező4)<>'üres állás' Or (Központosítottak.Mező4) Is Null))
)  AS 01O;

#/#/#/
lk_Ellenőrzés_01p_ElsődlegesÁllampolgárságHiánya
#/#/
SELECT "tSzemélyek" AS Tábla, "Elsődleges állampolgárság hiányzik, vagy nem érvényes" AS Hiányzó_érték, lkSzemélyek.Adójel AS Adóazonosító, lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], lkSzemélyek.[Szervezeti egység kódja] AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkSzemélyek.Adójel
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Elsődleges állampolgárság]) Is Null Or (lkSzemélyek.[Elsődleges állampolgárság])="") AND ((lkSzemélyek.[Jogviszony típusa / jogviszony típus])<>"Személyes jelenlét" And (lkSzemélyek.[Jogviszony típusa / jogviszony típus])<>"Megbízásos") AND ((lkSzemélyek.KilépésDátuma)>(Select dtátal(Min(TulajdonságÉrték)) From tAlapadatok Where TulajdonságNeve="VizsgáltElsőÉv") Or (lkSzemélyek.KilépésDátuma)=0) AND ((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)])<Date()));

#/#/#/
lk_Ellenőrzés_01q_ÁllandóLakcímHiánya
#/#/
SELECT "tSzemélyek" AS Tábla, "Állandó lakcím hiányzik, vagy nem érvényes" AS Hiányzó_érték, lkSzemélyek.Adójel AS Adóazonosító, lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], lkSzemélyek.[Szervezeti egység kódja] AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkSzemélyek.Adójel
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Állandó lakcím]) Is Null Or (lkSzemélyek.[Állandó lakcím])="") AND ((lkSzemélyek.[Jogviszony típusa / jogviszony típus])<>"Személyes jelenlét" And (lkSzemélyek.[Jogviszony típusa / jogviszony típus])<>"Megbízásos") AND ((lkSzemélyek.KilépésDátuma)>Date() Or (lkSzemélyek.KilépésDátuma)=0) AND ((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)])<Date()));

#/#/#/
lk_Ellenőrzés_01r_FunkcióHiányzik
#/#/
SELECT "tSzemélyek" AS Tábla, "Funkció hiányzik" AS Hiányzó_érték, lkSzemélyek.Adójel AS Adóazonosító, lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], lkSzemélyek.[Szervezeti egység kódja] AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkSzemélyek.Adójel
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Funkció: kód-megnevezés]) Is Null Or (lkSzemélyek.[Funkció: kód-megnevezés])="") AND ((lkSzemélyek.[Jogviszony típusa / jogviszony típus])<>"Személyes jelenlét" And (lkSzemélyek.[Jogviszony típusa / jogviszony típus])<>"Megbízásos") AND ((lkSzemélyek.KilépésDátuma)>(Select dtátal(Min(TulajdonságÉrték)) From tAlapadatok Where TulajdonságNeve="VizsgáltElsőÉv") Or (lkSzemélyek.KilépésDátuma)=0) AND ((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)])<Date()));

#/#/#/
lk_Ellenőrzés_01rr_FunkciócsoportHiányzik
#/#/
SELECT "tSzemélyek" AS Tábla, "Funkciócsoport hiányzik" AS Hiányzó_érték, lkSzemélyek.Adójel AS Adóazonosító, lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], lkSzemélyek.[Szervezeti egység kódja] AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkSzemélyek.Adójel
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Funkciócsoport: kód-megnevezés]) Is Null Or (lkSzemélyek.[Funkciócsoport: kód-megnevezés])="") AND ((lkSzemélyek.[Jogviszony típusa / jogviszony típus])<>"Személyes jelenlét" And (lkSzemélyek.[Jogviszony típusa / jogviszony típus])<>"Megbízásos") AND ((lkSzemélyek.KilépésDátuma)>(Select dtátal(Min(TulajdonságÉrték)) From tAlapadatok Where TulajdonságNeve="VizsgáltElsőÉv") Or (lkSzemélyek.KilépésDátuma)=0) AND ((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)])<Date()));

#/#/#/
lk_Ellenőrzés_02
#/#/
INSERT INTO t__Ellenőrzés_02 ( Tábla, Hiányzó_érték, Adóazonosító, [Álláshely azonosító], [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Adójel )
SELECT lk_Ellenőrzés_01.Tábla, lk_Ellenőrzés_01.Hiányzó_érték, lk_Ellenőrzés_01.Adóazonosító, lk_Ellenőrzés_01.[Álláshely azonosító], lk_Ellenőrzés_01.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], [Adóazonosító]*1 AS Adójel
FROM lk_Ellenőrzés_01;

#/#/#/
lk_Ellenőrzés_02_táblába_adójelKonverzió
#/#/
UPDATE t__Ellenőrzés_02 SET t__Ellenőrzés_02.Adójel = CDbl([Adóazonosító]);

#/#/#/
lk_Ellenőrzés_02a
#/#/
INSERT INTO t__Ellenőrzés_02
SELECT lk_Ellenőrzés_01a.*
FROM lk_Ellenőrzés_01a;

#/#/#/
lk_Ellenőrzés_02b
#/#/
INSERT INTO t__Ellenőrzés_02
SELECT lk_Ellenőrzés_01b.*
FROM lk_Ellenőrzés_01b;

#/#/#/
lk_Ellenőrzés_02c
#/#/
INSERT INTO t__Ellenőrzés_02
SELECT lk_Ellenőrzés_01c.*
FROM lk_Ellenőrzés_01c;

#/#/#/
lk_Ellenőrzés_02d_Illetmény_nulla
#/#/
INSERT INTO t__Ellenőrzés_02 ( Tábla, Hiányzó_érték, Adóazonosító, [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] )
SELECT lk_Ellenőrzés_01d_Illetmény_nulla.Tábla, lk_Ellenőrzés_01d_Illetmény_nulla.Hiányzó_érték, lk_Ellenőrzés_01d_Illetmény_nulla.Adójel AS Adóazonosító, lk_Ellenőrzés_01d_Illetmény_nulla.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
FROM lk_Ellenőrzés_01d_Illetmény_nulla;

#/#/#/
lk_Ellenőrzés_02f_hiányzó_besorolás_megnevezés
#/#/
INSERT INTO t__Ellenőrzés_02 ( Tábla, Hiányzó_érték, Adóazonosító, [Álláshely azonosító], [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] )
SELECT lk_Ellenőrzés_01f_hiányzó_besorolás_megnevezés.Tábla, lk_Ellenőrzés_01f_hiányzó_besorolás_megnevezés.Hiányzó_érték, lk_Ellenőrzés_01f_hiányzó_besorolás_megnevezés.Adóazonosító, lk_Ellenőrzés_01f_hiányzó_besorolás_megnevezés.[Álláshely azonosító], lk_Ellenőrzés_01f_hiányzó_besorolás_megnevezés.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
FROM lk_Ellenőrzés_01f_hiányzó_besorolás_megnevezés;

#/#/#/
lk_Ellenőrzés_02g_MunkahelyCímHiánya
#/#/
INSERT INTO t__Ellenőrzés_02 ( Tábla, Adóazonosító, [Álláshely azonosító], [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Adójel )
SELECT lk_Ellenőrzés_01g_MunkahelyCímHiánya.Tábla, lk_Ellenőrzés_01g_MunkahelyCímHiánya.Adóazonosító, lk_Ellenőrzés_01g_MunkahelyCímHiánya.[Álláshely azonosító], lk_Ellenőrzés_01g_MunkahelyCímHiánya.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lk_Ellenőrzés_01g_MunkahelyCímHiánya.Adójel
FROM lk_Ellenőrzés_01g_MunkahelyCímHiánya;

#/#/#/
lk_Ellenőrzés_02h_HivataliEmailHiánya
#/#/
INSERT INTO t__Ellenőrzés_02 ( Tábla, Hiányzó_érték, Adóazonosító, [Álláshely azonosító], [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Adójel )
SELECT lk_Ellenőrzés_01h_HivataliEmailHiánya.Tábla, lk_Ellenőrzés_01h_HivataliEmailHiánya.Hiányzó_érték, [Adójel] & "" AS Adóazonosító, lk_Ellenőrzés_01h_HivataliEmailHiánya.[Státusz kódja] AS Kif1, lk_Ellenőrzés_01h_HivataliEmailHiánya.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lk_Ellenőrzés_01h_HivataliEmailHiánya.Adójel
FROM lk_Ellenőrzés_01h_HivataliEmailHiánya;

#/#/#/
lk_Ellenőrzés_03
#/#/
SELECT DISTINCT lkSzemélyUtolsóSzervezetiEgysége.Főosztály, lkSzemélyUtolsóSzervezetiEgysége.Osztály, kt_azNexon_Adójel02.Név AS Név, t__Ellenőrzés_02.Hiányzó_érték AS [Hiányzó érték], t__Ellenőrzés_02.[Álláshely azonosító] AS [Státusz kód], kt_azNexon_Adójel02.NLink AS NLink, tNexonMezők.Megjegyzés
FROM lkSzemélyUtolsóSzervezetiEgysége RIGHT JOIN (tNexonMezők RIGHT JOIN ((tJav_mezők RIGHT JOIN t__Ellenőrzés_02 ON tJav_mezők.Eredeti = t__Ellenőrzés_02.Hiányzó_érték) LEFT JOIN kt_azNexon_Adójel02 ON t__Ellenőrzés_02.Adójel = kt_azNexon_Adójel02.Adójel) ON tNexonMezők.azNexonMező = tJav_mezők.azNexonMezők) ON lkSzemélyUtolsóSzervezetiEgysége.Adójel = t__Ellenőrzés_02.Adójel
GROUP BY lkSzemélyUtolsóSzervezetiEgysége.Főosztály, lkSzemélyUtolsóSzervezetiEgysége.Osztály, kt_azNexon_Adójel02.Név, t__Ellenőrzés_02.Hiányzó_érték, t__Ellenőrzés_02.[Álláshely azonosító], kt_azNexon_Adójel02.NLink, tNexonMezők.Megjegyzés, t__Ellenőrzés_02.Adójel;

#/#/#/
lk_Ellenőrzés_aHavibólHiányzók
#/#/
SELECT lkSzemélyek.[Státusz kódja], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve]
FROM lkSzemélyek LEFT JOIN (SELECT Kormányhivatali_állomány.[Álláshely azonosító] FROM Kormányhivatali_állomány UNION SELECT Járási_állomány.[Álláshely azonosító] FROM Járási_állomány UNION SELECT Központosítottak.[Álláshely azonosító] FROM Központosítottak)  AS HaviÁlláshelyAz ON lkSzemélyek.[Státusz kódja] = HaviÁlláshelyAz.[Álláshely azonosító]
WHERE (((lkSzemélyek.[státusz neve])="Álláshely") AND ((HaviÁlláshelyAz.[Álláshely azonosító]) Is Null))
ORDER BY lkSzemélyek.BFKH, lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lk_Ellenőrzés_ÁlláshelyStátusza_StátuszbetöltésTípusa
#/#/
SELECT DISTINCT lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, Álláshelyek.[Álláshely azonosító], Álláshelyek.[Álláshely státusza], lkSzemélyek.[Helyettesített dolgozó neve], tSzervezet.[Státuszbetöltés típusa]
FROM (Álláshelyek LEFT JOIN lkSzemélyek ON Álláshelyek.[Álláshely azonosító] = lkSzemélyek.[Státusz kódja]) LEFT JOIN tSzervezet ON lkSzemélyek.[Adóazonosító jel] = tSzervezet.[Szervezetmenedzsment kód]
WHERE (((Álláshelyek.[Álláshely státusza]) Like "betöltött *"));

#/#/#/
lk_Ellenőrzés_FEOR_kira
#/#/
SELECT bfkh([lkszemélyek].[Szervezeti egység kódja]) AS BFKH, lkJogviszonyok.Adójel, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.FEOR AS [NEXON FEOR], lkJogviszonyok.FEOR AS [KIRA FEOR], kt_azNexon_Adójel02.NLink
FROM (lkJogviszonyok LEFT JOIN lkSzemélyek ON lkJogviszonyok.Adójel=lkSzemélyek.Adójel) LEFT JOIN kt_azNexon_Adójel02 ON lkJogviszonyok.Adójel=kt_azNexon_Adójel02.Adójel
WHERE (((lkSzemélyek.FEOR) Not Like [lkJogviszonyok].[FEOR] & "*"));

#/#/#/
lk_Ellenőrzés_foglalkoztatás_01
#/#/
SELECT lk_Ellenőrzés_foglalkoztatás_havi.Adójel, lk_Ellenőrzés_foglalkoztatás_havi.Név, lk_Ellenőrzés_foglalkoztatás_személyek.Főosztály, lk_Ellenőrzés_foglalkoztatás_személyek.Osztály, lk_Ellenőrzés_foglalkoztatás_havi.[Státusz típusa], lk_Ellenőrzés_foglalkoztatás_havi.Foglalkoztatás AS A, lk_Ellenőrzés_foglalkoztatás_személyek.Foglalkoztatás AS B, lk_Ellenőrzés_foglalkoztatás_havi.[Heti munkaórák száma] AS C, lk_Ellenőrzés_foglalkoztatás_személyek.[Heti óraszám] AS D, lk_Ellenőrzés_foglalkoztatás_havi.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] AS SzervezetAz
FROM lk_Ellenőrzés_foglalkoztatás_havi RIGHT JOIN lk_Ellenőrzés_foglalkoztatás_személyek ON lk_Ellenőrzés_foglalkoztatás_havi.Adójel = lk_Ellenőrzés_foglalkoztatás_személyek.Adójel
WHERE (((lk_Ellenőrzés_foglalkoztatás_havi.Név) Like "kovács*") AND ((lk_Ellenőrzés_foglalkoztatás_havi.[Státusz típusa])<>""));

#/#/#/
lk_Ellenőrzés_foglalkoztatás_02a_b
#/#/
SELECT lk_Ellenőrzés_foglalkoztatás_01.Adójel, lk_Ellenőrzés_foglalkoztatás_01.Név, lk_Ellenőrzés_foglalkoztatás_01.SzervezetAz, lk_Ellenőrzés_foglalkoztatás_01.Főosztály, lk_Ellenőrzés_foglalkoztatás_01.Osztály, lk_Ellenőrzés_foglalkoztatás_01.[Státusz típusa], IIf([A]=[B],"-","Nexon/Foglalkozás/Foglalkozási viszony mező és a Nexon/Betöltött státuszok/Óraszám mezők értékei nincsenek összhangban!") AS A_B, lk_Ellenőrzés_foglalkoztatás_01.A, lk_Ellenőrzés_foglalkoztatás_01.B, lk_Ellenőrzés_foglalkoztatás_01.C, lk_Ellenőrzés_foglalkoztatás_01.D
FROM lk_Ellenőrzés_foglalkoztatás_01
WHERE (((IIf([A]=[B],"-","Nexon/Foglalkozás/Foglalkozási viszony mező és a Nexon/Betöltött státuszok/Óraszám mezők értékei nincsenek összhangban!"))<>"-"));

#/#/#/
lk_Ellenőrzés_foglalkoztatás_02c_a
#/#/
SELECT lk_Ellenőrzés_foglalkoztatás_01.Adójel, lk_Ellenőrzés_foglalkoztatás_01.Név, lk_Ellenőrzés_foglalkoztatás_01.SzervezetAz, lk_Ellenőrzés_foglalkoztatás_01.Főosztály, lk_Ellenőrzés_foglalkoztatás_01.Osztály, lk_Ellenőrzés_foglalkoztatás_01.[Státusz típusa], IIf(IIf([C]=40,"T","R")=[A],"-","A Nexon/Foglalkozási/Foglalkozási viszony és a Szerződések/SZERZŐDÉS/KINEVEZÉS VERZIÓ ADATOK SZERKESZTÉSE\Elméleti ledolgozandó napi órakeret  mezők értékei nincsenek összhangban!") AS C_D, lk_Ellenőrzés_foglalkoztatás_01.A, lk_Ellenőrzés_foglalkoztatás_01.B, lk_Ellenőrzés_foglalkoztatás_01.C, lk_Ellenőrzés_foglalkoztatás_01.D
FROM lk_Ellenőrzés_foglalkoztatás_01
WHERE (((lk_Ellenőrzés_foglalkoztatás_01.[Státusz típusa]) Not Like "Közpon*") AND ((IIf(IIf([C]=40,"T","R")=[A],"-","A Nexon/Foglalkozási/Foglalkozási viszony és a Szerződések/SZERZŐDÉS/KINEVEZÉS VERZIÓ ADATOK SZERKESZTÉSE\Elméleti ledolgozandó napi órakeret  mezők értékei nincsenek összhangban!"))<>"-"));

#/#/#/
lk_Ellenőrzés_foglalkoztatás_02d_c
#/#/
SELECT lk_Ellenőrzés_foglalkoztatás_01.Adójel, lk_Ellenőrzés_foglalkoztatás_01.Név, lk_Ellenőrzés_foglalkoztatás_01.SzervezetAz, lk_Ellenőrzés_foglalkoztatás_01.Főosztály, lk_Ellenőrzés_foglalkoztatás_01.Osztály, lk_Ellenőrzés_foglalkoztatás_01.[Státusz típusa], IIf([C]=[D],"-","Szerződések/SZERZŐDÉS/KINEVEZÉS VERZIÓ ADATOK SZERKESZTÉSE\Elméleti ledolgozandó napi órakeret és a  Nexon/Betöltött státuszok/Óraszám mezők értékei nincsenek összhangban!") AS C_D, lk_Ellenőrzés_foglalkoztatás_01.A, lk_Ellenőrzés_foglalkoztatás_01.B, lk_Ellenőrzés_foglalkoztatás_01.C, lk_Ellenőrzés_foglalkoztatás_01.D
FROM lk_Ellenőrzés_foglalkoztatás_01
WHERE (((lk_Ellenőrzés_foglalkoztatás_01.[Státusz típusa]) Not Like "Közpon*") AND ((IIf([C]=[D],"-","Szerződések/SZERZŐDÉS/KINEVEZÉS VERZIÓ ADATOK SZERKESZTÉSE\Elméleti ledolgozandó napi órakeret és a  Nexon/Betöltött státuszok/Óraszám mezők értékei nincsenek összhangban!"))<>"-"));

#/#/#/
lk_Ellenőrzés_foglalkoztatás_03
#/#/
SELECT Ellenőrzés.Főosztály, Ellenőrzés.Osztály, Ellenőrzés.A_B AS [Hiba leírása], Ellenőrzés.Adójel, Ellenőrzés.Név, "" AS [Álláshely azonosító], kt_azNexon_Adójel.NLINK AS Link, "" AS Megjegyzés
FROM kt_azNexon_Adójel RIGHT JOIN (SELECT * FROM lk_Ellenőrzés_foglalkoztatás_02a_b  UNION ALL SELECT * FROM lk_Ellenőrzés_foglalkoztatás_02c_a  UNION ALL  SELECT * FROM lk_Ellenőrzés_foglalkoztatás_02d_c )  AS Ellenőrzés ON kt_azNexon_Adójel.Adójel = Ellenőrzés.Adójel
ORDER BY Ellenőrzés.Főosztály;

#/#/#/
lk_Ellenőrzés_foglalkoztatás_emailcímek
#/#/
SELECT DISTINCT lk_Ellenőrzés_foglalkoztatás_03.TO AS Kif1
FROM lk_Ellenőrzés_foglalkoztatás_03;

#/#/#/
lk_Ellenőrzés_foglalkoztatás_havi
#/#/
SELECT Unió.Adójel, Unió.Név, Unió.[Járási Hivatal] AS Főosztály, Unió.Mező7 AS Osztály, Unió.Foglalkoztatás, Unió.[Heti munkaórák száma], Unió.[Státusz típusa], Unió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Unió.Mező4 AS [Születési év], [Mező10] AS Belépés, *
FROM (SELECT Járási_állomány.Adóazonosító * 1 AS Adójel, Járási_állomány.Név, Járási_állomány.[Járási Hivatal], Járási_állomány.Mező7, right(Járási_állomány.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ],1) AS Foglalkoztatás, Járási_állomány.[Heti munkaórák száma], "Szervezeti alaplétszám" As [Státusz típusa], [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Mező4, mező10
FROM Járási_állomány
WHERE Járási_állomány.Adóazonosító  <>""
UNION
SELECT Kormányhivatali_állomány.Adóazonosító * 1 AS Adójel, Kormányhivatali_állomány.Név, Kormányhivatali_állomány.Mező6, Kormányhivatali_állomány.Mező7, right(Kormányhivatali_állomány.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ],1),Kormányhivatali_állomány.[Heti munkaórák száma], "Szervezeti alaplétszám" As [Státusz típusa], [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Mező4, Mező10
FROM  Kormányhivatali_állomány
WHERE Kormányhivatali_állomány.Adóazonosító  <>""
UNION SELECT Központosítottak.Adóazonosító * 1 AS Adójel, Központosítottak.Név, Központosítottak.Mező6, Központosítottak.Mező7, right(Központosítottak.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ],1), 0 As [Heti munkaórák száma],"Központosított állomány" As [Státusz típusa], [Nexon szótárelemnek megfelelő szervezeti egység azonosító], Mező4, Mező11
FROM   Központosítottak
WHERE  Központosítottak.Adóazonosító <>"")  AS Unió;

#/#/#/
lk_Ellenőrzés_foglalkoztatás_személyek
#/#/
SELECT lkSzemélyek.Adójel, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker] AS [Heti óraszám], IIf([Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]=40,"T","R") AS Foglalkoztatás, lkSzemélyek.[Státusz típusa], lkSzemélyek.[Szervezeti egység kódja]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz típusa]) Is Not Null) AND ((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null))
ORDER BY lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lk_Ellenőrzés_határozottak
#/#/
SELECT lkSzervezetSzemélyek.[Státuszbetöltés típusa], lkSzemélyek.[Szerződés/Kinevezés típusa], lkSzervezetSzemélyek.[Érvényesség kezdete], lkSzervezetSzemélyek.[Érvényesség vége], lkSzemélyek.[Dolgozó teljes neve], lkSzervezetSzemélyek.[Státuszának kódja], lkSzemélyek.[Státusz kódja], lkSzemélyek.[Helyettesített dolgozó neve], lkSzemélyek.[Státusz neve], lkSzemélyek.[Jogviszony kezdete (belépés dátuma)], lkSzemélyek.[Jogviszony vége (kilépés dátuma)]
FROM lkSzervezetSzemélyek LEFT JOIN lkSzemélyek ON lkSzervezetSzemélyek.Adójel=lkSzemélyek.Adójel
WHERE (((lkSzervezetSzemélyek.[Státuszbetöltés típusa])="Helyettes") AND ((lkSzervezetSzemélyek.[Érvényesség kezdete])<=Date()) AND ((lkSzervezetSzemélyek.[Érvényesség vége])>=Date() Or (lkSzervezetSzemélyek.[Érvényesség vége]) Is Null) AND ((lkSzemélyek.[Státusz neve])="Álláshely")) OR (((lkSzervezetSzemélyek.[Státuszbetöltés típusa])="Általános") AND ((lkSzemélyek.[Szerződés/Kinevezés típusa])="határozott") AND ((lkSzervezetSzemélyek.[Érvényesség kezdete])<=Date()) AND ((lkSzervezetSzemélyek.[Érvényesség vége])>=Date() Or (lkSzervezetSzemélyek.[Érvényesség vége]) Is Null) AND ((lkSzemélyek.[Státusz neve])="Álláshely"));

#/#/#/
lk_Ellenőrzés_HiányzóÁlláshelyek
#/#/
SELECT Álláshelyek.[Álláshely azonosító], Álláshelyek.[Álláshely besorolási kategóriája], Álláshelyek.[Álláshely típusa]
FROM lkÁlláshelyAzonosítókHaviból LEFT JOIN Álláshelyek ON lkÁlláshelyAzonosítókHaviból.Álláshely = Álláshelyek.[Álláshely azonosító]
WHERE (((Álláshelyek.[Álláshely azonosító]) Is Null));

#/#/#/
lk_Ellenőrzés_hozzátartozó_hiány01
#/#/
SELECT Nz([lkHozzátartozók].[Szervezeti egység kódja],[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]) AS SzervezetKód, lkHozzátartozók.[Dolgozó neve], lkHozzátartozók.Adójel AS [Dolgozó adóazonosító jele], lkHozzátartozók.[Hozzátartozó neve], lkHozzátartozók.[Hozzátartozó adóazonosító jele], lkHozzátartozók.[Születési hely], Trim([Anyja családi neve] & " " & [Anyja utóneve]) AS [Anyja neve], lkHozzátartozók.[Születési idő], Trim(Replace(Nz([lkHozzátartozók].[Állandó lakcím],""),"Magyarország","")) AS GyermekÁllandó, Trim(Replace(Nz([lkHozzátartozók].[Tartózkodási lakcím],""),"Magyarország","")) AS GyermekTartózkodási, Replace(Nz([lkSzemélyek].[Állandó lakcím],""),"Magyarország, ","") AS SzülőÁllandó, Replace(Nz([lkszemélyek].[Tartózkodási lakcím],""),"Magyarország, ","") AS SzülőTartózkodási, lkKilépők.[Jogviszony megszűnésének, megszüntetésének időpontja], lkHozzátartozók.[Hozzátartozó TAJ száma]
FROM (lkHozzátartozók LEFT JOIN lkSzemélyek ON lkHozzátartozók.Adójel = lkSzemélyek.Adójel) LEFT JOIN lkKilépők ON lkHozzátartozók.Adójel = lkKilépők.Adójel
WHERE (((lkHozzátartozók.[Hozzátartozó neve]) Not Like "*elhalt*" And (lkHozzátartozók.[Hozzátartozó neve]) Not Like "*elhunyt*") AND ((lkHozzátartozók.[Születési idő])>DateSerial(Year(Date())-18,1,1)) AND ((lkKilépők.[Jogviszony megszűnésének, megszüntetésének időpontja])>DateSerial(Year(Date()),1,1) Or (lkKilépők.[Jogviszony megszűnésének, megszüntetésének időpontja]) Is Null) AND ((lkHozzátartozók.[Otthoni e-mail cím]) Not Like "elhunyt*") AND ((Nz([tHozzátartozók].[Szervezeti egység kódja],[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ])) Is Not Null) AND ((lkSzemélyek.[Státusz típusa]) Like "Központosított állomány" Or (lkSzemélyek.[Státusz típusa]) Like "Szervezeti*") AND ((lkHozzátartozók.[Kapcsolat jellege])="Gyermek") AND ((lkSzemélyek.[Státusz neve])="Álláshely")) OR (((lkHozzátartozók.[Hozzátartozó neve]) Not Like "*elhalt*" And (lkHozzátartozók.[Hozzátartozó neve]) Not Like "*elhunyt*") AND ((lkHozzátartozók.[Születési idő])>DateSerial(Year(Date())-18,1,1)) AND ((lkKilépők.[Jogviszony megszűnésének, megszüntetésének időpontja])>DateSerial(Year(Date()),1,1) Or (lkKilépők.[Jogviszony megszűnésének, megszüntetésének időpontja]) Is Null) AND ((lkHozzátartozók.[Otthoni e-mail cím]) Is Null) AND ((Nz([tHozzátartozók].[Szervezeti egység kódja],[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ])) Is Not Null) AND ((lkSzemélyek.[Státusz típusa]) Like "Központosított állomány" Or (lkSzemélyek.[Státusz típusa]) Like "Szervezeti*") AND ((lkHozzátartozók.[Kapcsolat jellege])="Gyermek") AND ((lkSzemélyek.[Státusz neve])="Álláshely")) OR (((lkHozzátartozók.[Hozzátartozó neve]) Not Like "*elhalt*" And (lkHozzátartozók.[Hozzátartozó neve]) Not Like "*elhunyt*") AND ((lkHozzátartozók.[Születési idő])>DateSerial(Year(Date())-18,1,1)) AND ((lkKilépők.[Jogviszony megszűnésének, megszüntetésének időpontja])>DateSerial(Year(Date()),1,1) Or (lkKilépők.[Jogviszony megszűnésének, megszüntetésének időpontja]) Is Null) AND ((lkHozzátartozók.[Otthoni e-mail cím]) Not Like "elhunyt*") AND ((Nz([tHozzátartozók].[Szervezeti egység kódja],[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ])) Is Not Null) AND ((lkSzemélyek.[Státusz típusa]) Is Null) AND ((lkHozzátartozók.[Kapcsolat jellege])="Gyermek") AND ((lkSzemélyek.[Státusz neve])="Álláshely")) OR (((lkHozzátartozók.[Hozzátartozó neve]) Not Like "*elhalt*" And (lkHozzátartozók.[Hozzátartozó neve]) Not Like "*elhunyt*") AND ((lkHozzátartozók.[Születési idő])>DateSerial(Year(Date())-18,1,1)) AND ((lkKilépők.[Jogviszony megszűnésének, megszüntetésének időpontja])>DateSerial(Year(Date()),1,1) Or (lkKilépők.[Jogviszony megszűnésének, megszüntetésének időpontja]) Is Null) AND ((lkHozzátartozók.[Otthoni e-mail cím]) Is Null) AND ((Nz([tHozzátartozók].[Szervezeti egység kódja],[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ])) Is Not Null) AND ((lkSzemélyek.[Státusz típusa]) Is Null) AND ((lkHozzátartozók.[Kapcsolat jellege])="Gyermek") AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY lkHozzátartozók.[Születési idő];

#/#/#/
lk_Ellenőrzés_hozzátartozó_hiány02
#/#/
SELECT lk_Főosztály_Osztály_lkSzemélyek.Főosztály AS Főosztály, lk_Főosztály_Osztály_lkSzemélyek.Osztály AS Osztály, Unió.[Dolgozó neve] AS Név, Unió.[Hozzátartozó neve] AS [A hozzátartozó neve], Unió.[Születési idő] AS [A születés ideje], Unió.HiányzóAdat AS [A hiányzó adat], kt_azNexon_Adójel02.NLink AS NLink
FROM kt_azNexon_Adójel02 RIGHT JOIN (lk_Főosztály_Osztály_lkSzemélyek RIGHT JOIN (SELECT lk_Ellenőrzés_hozzátartozó_hiány01.[SzervezetKód], lk_Ellenőrzés_hozzátartozó_hiány01.[Dolgozó neve] ,          lk_Ellenőrzés_hozzátartozó_hiány01.[Dolgozó adóazonosító jele]*1 as Adójel ,          tHozzátartozók.[Hozzátartozó neve] ,          tHozzátartozók.[Születési idő] ,         "Hozzátartozó neve" as HiányzóAdat                FROM lk_Ellenőrzés_hozzátartozó_hiány01                WHERE lk_Ellenőrzés_hozzátartozó_hiány01.[Hozzátartozó neve] is null       UNION       SELECT lk_Ellenőrzés_hozzátartozó_hiány01.[SzervezetKód] ,          lk_Ellenőrzés_hozzátartozó_hiány01.[Dolgozó neve] ,          lk_Ellenőrzés_hozzátartozó_hiány01.[Dolgozó adóazonosító jele] ,          tHozzátartozók.[Hozzátartozó neve] ,          tHozzátartozók.[Születési idő] ,         "Hozzátartozó adóazonosító jele" as HiányzóAdat              FROM lk_Ellenőrzés_hozzátartozó_hiány01                  WHERE lk_Ellenőrzés_hozzátartozó_hiány01.[Hozzátartozó adóazonosító jele] is null       UNION       SELECT lk_Ellenőrzés_hozzátartozó_hiány01.[SzervezetKód] ,          lk_Ellenőrzés_hozzátartozó_hiány01.[Dolgozó neve] ,          lk_Ellenőrzés_hozzátartozó_hiány01.[Dolgozó adóazonosító jele]*1 as Adójel ,          tHozzátartozók.[Hozzátartozó neve] ,          tHozzátartozók.[Születési idő] ,          "Születési hely" as HiányzóAdat                 FROM lk_Ellenőrzés_hozzátartozó_hiány01                  WHERE lk_Ellenőrzés_hozzátartozó_hiány01.[Születési hely] is null        UNION       SELECT lk_Ellenőrzés_hozzátartozó_hiány01.[SzervezetKód] ,          lk_Ellenőrzés_hozzátartozó_hiány01.[Dolgozó neve] ,          lk_Ellenőrzés_hozzátartozó_hiány01.[Dolgozó adóazonosító jele]*1 as Adójel ,          tHozzátartozók.[Hozzátartozó neve] ,          tHozzátartozók.[Születési idő] ,          "Anyja neve" as HiányzóAdat                 FROM lk_Ellenőrzés_hozzátartozó_hiány01                  WHERE lk_Ellenőrzés_hozzátartozó_hiány01.[Anyja neve] is null  OR trim(lk_Ellenőrzés_hozzátartozó_hiány01.[Anyja neve])=""       UNION       SELECT lk_Ellenőrzés_hozzátartozó_hiány01.[SzervezetKód] ,          lk_Ellenőrzés_hozzátartozó_hiány01.[Dolgozó neve] ,          lk_Ellenőrzés_hozzátartozó_hiány01.[Dolgozó adóazonosító jele]*1 as Adójel ,          tHozzátartozók.[Hozzátartozó neve] ,          tHozzátartozók.[Születési idő] ,          "Születési idő" as HiányzóAdat                 FROM lk_Ellenőrzés_hozzátartozó_hiány01                 WHERE lk_Ellenőrzés_hozzátartozó_hiány01.[Születési idő] is null       UNION       SELECT lk_Ellenőrzés_hozzátartozó_hiány01.[SzervezetKód] ,           lk_Ellenőrzés_hozzátartozó_hiány01.[Dolgozó neve] ,           lk_Ellenőrzés_hozzátartozó_hiány01.[Dolgozó adóazonosító jele]*1 as Adójel ,           lk_Ellenőrzés_hozzátartozó_hiány01.[Hozzátartozó neve] ,           tHozzátartozók.[Születési idő] ,           "Hozzátartozó állandó lakcíme" AS [Hiányzó adat]                  FROM lk_Ellenőrzés_hozzátartozó_hiány01                  WHERE lk_Ellenőrzés_hozzátartozó_hiány01.[GyermekÁllandó] Is Null Or lk_Ellenőrzés_hozzátartozó_hiány01.[GyermekÁllandó]=""       UNION       SELECT lk_Ellenőrzés_hozzátartozó_hiány01.[SzervezetKód] ,           lk_Ellenőrzés_hozzátartozó_hiány01.[Dolgozó neve] ,           lk_Ellenőrzés_hozzátartozó_hiány01.[Dolgozó adóazonosító jele]*1 as Adójel ,           lk_Ellenőrzés_hozzátartozó_hiány01.[Hozzátartozó neve] ,           tHozzátartozók.[Születési idő] ,           "Hozzátartozó TAJ" AS [Hiányzó adat]                  FROM lk_Ellenőrzés_hozzátartozó_hiány01                  WHERE lk_Ellenőrzés_hozzátartozó_hiány01.[Hozzátartozó TAJ száma] Is Null Or lk_Ellenőrzés_hozzátartozó_hiány01.[Hozzátartozó TAJ száma]=""        )  AS Unió ON lk_Főosztály_Osztály_lkSzemélyek.[Szervezeti egység kódja] = Unió.SzervezetKód) ON kt_azNexon_Adójel02.Adójel = Unió.Adójel;

#/#/#/
lk_Ellenőrzés_kirahibák01
#/#/
SELECT lkSzemélyek.BFKH, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkKiraHiba.Adójel, lkKiraHiba.Név, lkKiraHiba.Hiba, tKiraHibaüzenetek.Magyarázat
FROM (lkKiraHiba INNER JOIN lkSzemélyek ON lkKiraHiba.Adójel = lkSzemélyek.Adójel) LEFT JOIN tKiraHibaüzenetek ON lkKiraHiba.Hiba = tKiraHibaüzenetek.Hibaüzenet
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY lkSzemélyek.BFKH, lkKiraHiba.Név;

#/#/#/
lk_Ellenőrzés_kirahibák02
#/#/
SELECT lk_Ellenőrzés_kirahibák01.BFKH, lk_Ellenőrzés_kirahibák01.Főosztály, lk_Ellenőrzés_kirahibák01.Osztály, lk_Ellenőrzés_kirahibák01.Adójel, lk_Ellenőrzés_kirahibák01.Név, lk_Ellenőrzés_kirahibák01.Hiba, lk_Ellenőrzés_kirahibák01.Magyarázat, kt_azNexon_Adójel02.NLink
FROM kt_azNexon_Adójel02 RIGHT JOIN lk_Ellenőrzés_kirahibák01 ON kt_azNexon_Adójel02.Adójel = lk_Ellenőrzés_kirahibák01.Adójel;

#/#/#/
lk_Ellenőrzés_munkakör_kira01
#/#/
SELECT bfkh(Nz([lkszemélyek].[Szervezeti egység kódja],"")) AS BFKH, IIf(Nz([Főosztály],"")="","_Kilépett",[Főosztály]) AS Főoszt, lkSzemélyek.Osztály, lkSzemélyek.Adójel, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Dolgozó szerződéses/kinevezéses munkaköre / kinevezési okmányban] AS [Nexon munkakör], lkJogviszonyok.[Munkakör megnevezése] AS [Kira munkakör], kt_azNexon_Adójel02.NLink
FROM lkJogviszonyok RIGHT JOIN (kt_azNexon_Adójel02 RIGHT JOIN lkSzemélyek ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel) ON lkJogviszonyok.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely" Or (lkSzemélyek.[Státusz neve]) Is Null) AND ((lkSzemélyek.[Jogviszony típusa / jogviszony típus])="Munkaviszony"))
ORDER BY bfkh(Nz([lkszemélyek].[Szervezeti egység kódja],"")), IIf(Nz([Főosztály],"")="","_Kilépett",[Főosztály]), lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lk_Ellenőrzés_születésihely_kira_Statisztika
#/#/
SELECT Összesített.Főoszt, Összesített.[Hibák száma], Összesített.Összlétszám, [Hibák száma]/[Összlétszám] AS Arány
FROM (SELECT Unió.Főoszt, Sum(Unió.Hibás) AS [Hibák száma], Sum(Unió.Létszám) AS Összlétszám
FROM (SELECT lk_Ellenőrzés_születésihely_kira02.Főoszt, Count(lk_Ellenőrzés_születésihely_kira02.Adójel) AS Hibás, 0 AS Létszám
FROM lk_Ellenőrzés_születésihely_kira02
GROUP BY lk_Ellenőrzés_születésihely_kira02.Főoszt, 0
UNION
SELECT lkSzemélyek.Főosztály, 0 AS Hibás, Count(lkSzemélyek.Adójel) AS CountOfAdójel
FROM lkSzemélyek
GROUP BY lkSzemélyek.Főosztály, 0, lkSzemélyek.[Státusz neve]
HAVING (((lkSzemélyek.[Státusz neve])="Álláshely"))
)  AS Unió
GROUP BY Unió.Főoszt
)  AS Összesített
GROUP BY Összesített.Főoszt, Összesített.[Hibák száma], Összesített.Összlétszám, [Hibák száma]/[Összlétszám];

#/#/#/
lk_Ellenőrzés_születésihely_kira01
#/#/
SELECT bfkh(Nz([Szervezeti egység kódja],0)) AS bfkh, IIf(Nz([Főosztály],"")="","_Kilépett",[Főosztály]) AS Főoszt, lkSzemélyek.Osztály, lkSzemélyek.Adójel, lkSzemélyek.[Dolgozó teljes neve], Switch(Nz([Születési hely],"") Not Like "Budapest ##*","A születési hely nem a KIRA szabványos cím, azaz: 'Budapest' + szóköz + két számjegy a kerületnek :(",Len(Nz([Születési hely],""))<2,"Születési hely hiányzik") AS Hiba, Nz([Születési hely],"") AS [Születés helye], "Budapest " & Right("0" & num2num(Replace(Replace(Trim(Replace([Születési hely],"Budapest","")),"ker",""),".",""),99,10),2) AS Javasolt, kt_azNexon_Adójel02.NLink
FROM lkSzemélyek LEFT JOIN kt_azNexon_Adójel02 ON lkSzemélyek.Adójel = kt_azNexon_Adójel02.Adójel
WHERE (((Nz([Születési hely],"")) Not Like "Budapest ##*") AND ((lkSzemélyek.[Születési hely]) Like "*Budapest*") AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY bfkh(Nz([Szervezeti egység kódja],0)), IIf(Nz([Főosztály],"")="","_Kilépett",[Főosztály]), lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lk_Ellenőrzés_születésihely_kira01_hiány
#/#/
SELECT bfkh(Nz([Szervezeti egység kódja],0)) AS bfkh, IIf(Nz([Főosztály],"")="","_Kilépett",[Főosztály]) AS Főoszt, lkSzemélyek.Osztály, lkSzemélyek.Adójel, lkSzemélyek.[Dolgozó teljes neve], "A születési hely nincs kitöltve" AS Hiba, "" AS [Születési helye], "" AS Javasolt, kt_azNexon_Adójel02.NLink
FROM lkSzemélyek LEFT JOIN kt_azNexon_Adójel02 ON lkSzemélyek.Adójel = kt_azNexon_Adójel02.Adójel
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely") AND ((Len(Nz([Születési hely],"")))<2))
ORDER BY bfkh(Nz([Szervezeti egység kódja],0)), IIf(Nz([Főosztály],"")="","_Kilépett",[Főosztály]), lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lk_Ellenőrzés_születésihely_kira02
#/#/
SELECT BudapestRomaiEsHiany.Főosztály, BudapestRomaiEsHiany.Osztály, BudapestRomaiEsHiany.Név, BudapestRomaiEsHiany.Hiba, BudapestRomaiEsHiany.[Születési hely], BudapestRomaiEsHiany.Javaslat, BudapestRomaiEsHiany.NLink
FROM (SELECT
  lk_Ellenőrzés_születésihely_kira01.bfkh
, lk_Ellenőrzés_születésihely_kira01.Főoszt AS Főosztály
, lk_Ellenőrzés_születésihely_kira01.Osztály AS Osztály
, lk_Ellenőrzés_születésihely_kira01.[Dolgozó teljes neve] AS Név
, lk_Ellenőrzés_születésihely_kira01.Hiba
, lk_Ellenőrzés_születésihely_kira01.[Születés helye] AS [Születési hely]
, IIf([Javasolt] Like "*00*","-- nincs javaslat --",[Javasolt]) AS Javaslat
, lk_Ellenőrzés_születésihely_kira01.NLink AS NLink 
FROM lk_Ellenőrzés_születésihely_kira01
UNION
SELECT
  lk_Ellenőrzés_születésihely_kira01_hiány.bfkh
, lk_Ellenőrzés_születésihely_kira01_hiány.Főoszt
, lk_Ellenőrzés_születésihely_kira01_hiány.Osztály
, lk_Ellenőrzés_születésihely_kira01_hiány.[Dolgozó teljes neve] as Név
, lk_Ellenőrzés_születésihely_kira01_hiány.Hiba
, lk_Ellenőrzés_születésihely_kira01_hiány.[Születési helye]
, "-- nincs javaslat --" as Javaslat
, lk_Ellenőrzés_születésihely_kira01_hiány.NLink
FROM lk_Ellenőrzés_születésihely_kira01_hiány
)  AS BudapestRomaiEsHiany
ORDER BY BudapestRomaiEsHiany.bfkh, BudapestRomaiEsHiany.Osztály, BudapestRomaiEsHiany.Név;

#/#/#/
lk_Fesz_03
#/#/
SELECT Unió01b_02.Azonosító, Unió01b_02.Főosztály, Unió01b_02.Osztály, Unió01b_02.Név, Unió01b_02.TAJ, Unió01b_02.Szül, Unió01b_02.EüOsztály, Unió01b_02.[FEOR megnevezés], Unió01b_02.[Alk tipus], Unió01b_02.ADátum, Unió01b_02.Érvény, Unió01b_02.Korlátozás, Unió01b_02.[Orvosi vizsgálat időpontja], Unió01b_02.[Orvosi vizsgálat típusa], Unió01b_02.[Orvosi vizsgálat eredménye], Unió01b_02.[Orvosi vizsgálat észrevételek], Unió01b_02.[Orvosi vizsgálat következő időpontja]
FROM (SELECT DISTINCT lkFesz_01b.*
FROM  lkFesz_01b
UNION
SELECT lkFesz_02.*
FROM lkFesz_02)  AS Unió01b_02;

#/#/#/
lk_Főosztály_Osztály
#/#/
SELECT DISTINCT lkSzemélyek.[Szervezeti egység kódja] AS BFKH, lkSzemélyek.Főosztály, lkSzemélyek.Osztály
FROM lkSzemélyek;

#/#/#/
lk_Főosztály_Osztály_lkSzemélyek
#/#/
SELECT DISTINCT lkSzemélyek.BFKH, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, IIf(Nz([Osztály],"")="",0,IIf(utolsó([BFKH],".")="",0,utolsó([BFKH],"."))*1)+1 AS Sorszám, lkSzemélyek.[Szervezeti egység kódja]
FROM lkSzemélyek;

#/#/#/
lk_Főosztály_Osztály_tSzervezet
#/#/
SELECT bfkh(Nz([tSzervezet].[Szervezetmenedzsment kód],"")) AS bfkhkód, tSzervezet.[Szervezetmenedzsment kód], IIf(Nz([tSzervezet].[Szint],1)>6,Nz([tSzervezet_1].[Név],""),Nz([tSzervezet].[Név],"")) AS Főosztály, IIf([tSzervezet].[Szint]>6,[tSzervezet].[Név],"") AS Osztály, Replace(IIf([tSzervezet].[Szint]>6,[tSzervezet_1].[Név],[tSzervezet].[Név]),"Budapest Főváros Kormányhivatala","BFKH") AS Főoszt
FROM tSzervezet AS tSzervezet_1 RIGHT JOIN tSzervezet ON tSzervezet_1.[Szervezetmenedzsment kód] = tSzervezet.[Szülő szervezeti egységének kódja]
WHERE (((tSzervezet.OSZLOPOK)="szervezeti egység"))
ORDER BY bfkh(Nz([tSzervezet].[Szervezetmenedzsment kód],""));

#/#/#/
lk_Főosztályonkénti_átlagilletmény01
#/#/
SELECT bfkh([FőosztályKód]) AS FK, lkSzemélyek.Főosztály, Avg([Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40) AS Illetmény
FROM lkSzemélyek
GROUP BY bfkh([FőosztályKód]), lkSzemélyek.Főosztály, lkSzemélyek.[Státusz neve]
HAVING (((lkSzemélyek.[Státusz neve])="Álláshely"));

#/#/#/
lk_Főosztályonkénti_átlagilletmény01_vezetőknélkül
#/#/
SELECT bfkh([FőosztályKód]) AS FK, lkSzemélyek.Főosztály, Avg([Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40) AS Illetmény
FROM tBesorolás_átalakító INNER JOIN lkSzemélyek ON tBesorolás_átalakító.Besorolási_fokozat = lkSzemélyek.[Besorolási  fokozat (KT)]
WHERE (((tBesorolás_átalakító.Vezető)=No))
GROUP BY bfkh([FőosztályKód]), lkSzemélyek.Főosztály, lkSzemélyek.[Státusz neve]
HAVING (((lkSzemélyek.[Státusz neve])="Álláshely"));

#/#/#/
lk_Főosztályonkénti_átlagilletmény02
#/#/
SELECT lk_Főosztályonkénti_átlagilletmény01.Főosztály AS Főosztály, Round([Illetmény]/100,0)*100 AS Átlagilletmény
FROM lk_Főosztályonkénti_átlagilletmény01
ORDER BY lk_Főosztályonkénti_átlagilletmény01.[FK];

#/#/#/
lk_Főosztályonkénti_átlagilletmény02_vezetőknélkül
#/#/
SELECT lk_Főosztályonkénti_átlagilletmény01_vezetőknélkül.Főosztály AS Főosztály, Round([Illetmény]/100,0)*100 AS Átlagilletmény
FROM lk_Főosztályonkénti_átlagilletmény01_vezetőknélkül
ORDER BY lk_Főosztályonkénti_átlagilletmény01_vezetőknélkül.FK;

#/#/#/
lk_Garantált_bérminimum_alatti_02
#/#/
SELECT lkSzemélyek.Adójel, lkSzemélyek.[Kerekített 100 %-os illetmény (eltérített)] AS Illetmény, lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker] AS [Heti munkaórák száma], lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], Nz([Kerekített 100 %-os illetmény (eltérített)],0)/IIf(Nz([Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker],0)=0,0.00001,[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker])*40 AS Bruttó_bér, IIf(Nz([Kerekített 100 %-os illetmény (eltérített)],0)/IIf(Nz([Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker],0)=0,0.00001,[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker])*40<(Select Min(TulajdonságÉrték) From tAlapadatok Where TulajdonságNeve="garantált bérminimum")*1,Yes,No) AS Garantált_min_alatt
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely"));

#/#/#/
lk_Garantált_bérminimum_alatti_állománytáblából
#/#/
SELECT [Adóazonosító]*1 AS Adójel, lk_Állománytáblákból_Illetmények.Illetmény, lk_Állománytáblákból_Illetmények.[Heti munkaórák száma], lk_Állománytáblákból_Illetmények.[Álláshely azonosító], [Illetmény]/IIf(Nz([Heti munkaórák száma],0)=0,0.00001,[Heti munkaórák száma])*40 AS Bruttó_bér, IIf([Illetmény]/IIf(Nz([Heti munkaórák száma],0)=0,0.00001,[Heti munkaórák száma])*40<(Select Min(TulajdonságÉrték) From tAlapadatok Where TulajdonságNeve="garantált bérminimum")*1,Yes,No) AS Garantált_min_alatt
FROM lk_Állománytáblákból_Illetmények
WHERE (((IIf([Illetmény]/IIf(Nz([Heti munkaórák száma],0)=0,0.00001,[Heti munkaórák száma])*40<(Select Min(TulajdonságÉrték) From tAlapadatok Where TulajdonságNeve="garantált bérminimum")*1,Yes,No))=Yes));

#/#/#/
lk_Garantált_bérminimum_Illetmények
#/#/
SELECT lkSzemélyek.Főosztály AS Főosztály, lkSzemélyek.Osztály AS Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lk_Garantált_bérminimum_alatti_02.[Álláshely azonosító] AS [Státusz kód], lk_Garantált_bérminimum_alatti_02.Illetmény AS Illetmény, lk_Garantált_bérminimum_alatti_02.[Heti munkaórák száma] AS [Heti munkaórák száma], lk_Garantált_bérminimum_alatti_02.Bruttó_bér AS [Bruttó illetmény], lkSzemélyek.[KIRA jogviszony jelleg], lkSzemélyek.[Iskolai végzettség foka], lkSzemélyek.[Iskolai végzettség neve], kt_azNexon_Adójel02.NLink AS NLink, lkSzemélyek.[Tartós távollét típusa]
FROM (kt_azNexon_Adójel02 RIGHT JOIN lkSzemélyek ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel) RIGHT JOIN lk_Garantált_bérminimum_alatti_02 ON lkSzemélyek.Adójel = lk_Garantált_bérminimum_alatti_02.Adójel
WHERE (((lk_Garantált_bérminimum_alatti_02.Garantált_min_alatt)=Yes))
ORDER BY lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lk_HavibólÁlláshelyek
#/#/
SELECT FedlaprólÁlláshelyekUnió.Tábla, FedlaprólÁlláshelyekUnió.Azonosító, FedlaprólÁlláshelyekUnió.[Az álláshely megynevezése], FedlaprólÁlláshelyekUnió.[Álláshely száma], *
FROM (SELECT *, "Alaplétszám" as Tábla
FROM FedlaprólLétszámtábla
UNION
SELECT *, "Központosított" as Tábla
FROM FedlaprólLétszámtábla2
)  AS FedlaprólÁlláshelyekUnió
ORDER BY FedlaprólÁlláshelyekUnió.Tábla, FedlaprólÁlláshelyekUnió.Azonosító;

#/#/#/
lk_Illetménysávok_és_illetmények_havi_alapján_01
#/#/
SELECT Bfkh([Szervezetkód]) AS BFKH, lk_Állománytáblákból_Illetmények.Szervezetkód, lk_Állománytáblákból_Illetmények.Adójel, tSzervezet.[Tervezett betöltési adatok - Előmeneteli fokozat megnevezés] AS besorolás, lk_Állománytáblákból_Illetmények.[Álláshely azonosító], tBesorolás_átalakító_1.[alsó határ], tBesorolás_átalakító_1.[felső határ], lk_Állománytáblákból_Illetmények.Illetmény, lk_Állománytáblákból_Illetmények.[Heti munkaórák száma], [Illetmény]/IIf([Heti munkaórák száma]=0,0.0001,[Heti munkaórák száma])*40 AS [40 órás illetmény], tBesorolás_átalakító_1.[Jogviszony típusa], lk_Állománytáblákból_Illetmények.Név, lk_Állománytáblákból_Illetmények.Főosztály, lk_Állománytáblákból_Illetmények.Osztály, lk_Állománytáblákból_Illetmények.Adójel, lk_Állománytáblákból_Illetmények.BesorolásHavi
FROM tBesorolás_átalakító AS tBesorolás_átalakító_1 RIGHT JOIN (lk_Állománytáblákból_Illetmények RIGHT JOIN tSzervezet ON lk_Állománytáblákból_Illetmények.[Álláshely azonosító] = tSzervezet.[Szervezetmenedzsment kód]) ON tBesorolás_átalakító_1.[Az álláshely jelölése] = lk_Állománytáblákból_Illetmények.BesorolásHavi
WHERE ((([Illetmény]/IIf([Heti munkaórák száma]=0,0.0001,[Heti munkaórák száma])*40) Not Between [alsó határ] And [felső határ]));

#/#/#/
lk_Illetménysávok_és_illetmények_havi_alapján_02
#/#/
SELECT lk_Illetménysávok_és_illetmények_havi_alapján_01.Szervezetkód, lk_Illetménysávok_és_illetmények_havi_alapján_01.Főosztály, lk_Illetménysávok_és_illetmények_havi_alapján_01.Név, lk_Illetménysávok_és_illetmények_havi_alapján_01.Adójel, lk_Illetménysávok_és_illetmények_havi_alapján_01.besorolás, lk_Illetménysávok_és_illetmények_havi_alapján_01.[alsó határ], lk_Illetménysávok_és_illetmények_havi_alapján_01.[felső határ], lk_Illetménysávok_és_illetmények_havi_alapján_01.Illetmény, lk_Illetménysávok_és_illetmények_havi_alapján_01.[Heti munkaórák száma], lk_Illetménysávok_és_illetmények_havi_alapján_01.[40 órás illetmény], lk_Illetménysávok_és_illetmények_havi_alapján_01.[Jogviszony típusa], kt_azNexon_Adójel02.Nlink AS Hivatkozás
FROM lk_Illetménysávok_és_illetmények_havi_alapján_01 LEFT JOIN kt_azNexon_Adójel02 ON lk_Illetménysávok_és_illetmények_havi_alapján_01.Adójel = kt_azNexon_Adójel02.Adójel
ORDER BY lk_Illetménysávok_és_illetmények_havi_alapján_01.BFKH;

#/#/#/
lk_Illetménysávok_és_illetmények_havi_alapján_03
#/#/
SELECT DISTINCT lk_Illetménysávok_és_illetmények_havi_alapján_02.Főosztály, lk_Illetménysávok_és_illetmények_havi_alapján_02.Név, lk_Illetménysávok_és_illetmények_havi_alapján_02.besorolás, lk_Illetménysávok_és_illetmények_havi_alapján_02.[alsó határ], lk_Illetménysávok_és_illetmények_havi_alapján_02.[felső határ], lk_Illetménysávok_és_illetmények_havi_alapján_02.Illetmény, lk_Illetménysávok_és_illetmények_havi_alapján_02.[Heti munkaórák száma], lk_Illetménysávok_és_illetmények_havi_alapján_02.[40 órás illetmény], lk_Illetménysávok_és_illetmények_havi_alapján_02.[Jogviszony típusa], lk_Illetménysávok_és_illetmények_havi_alapján_02.Hivatkozás
FROM lk_Illetménysávok_és_illetmények_havi_alapján_02;

#/#/#/
lk_Illetménysávok_és_illetmények_összevontan
#/#/
SELECT  *
FROM lk_Illetménysávok_és_illetmények_havi_alapján_03
UNION SELECT *
FROM  lk_Illetménysávok_és_illetmények_személytörzs_alapján02;

#/#/#/
lk_Illetménysávok_és_illetmények_személytörzs_alapján
#/#/
SELECT lkSzemélyek.[Szervezeti egység kódja], lkSzemélyek.Főosztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Adójel, lkSzemélyek.[Besorolási  fokozat (KT)], tBesorolás_átalakító.[alsó határ], tBesorolás_átalakító.[felső határ], lkSzemélyek.[Illetmény összesen kerekítés nélkül (eltérített)], lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker] AS [Heti óraszám], [Illetmény összesen kerekítés nélkül (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40 AS [40 órás illetmény], tBesorolás_átalakító.[Jogviszony típusa], kt_azNexon_Adójel.NLink AS Hivatkozás
FROM (lkSzemélyek INNER JOIN tBesorolás_átalakító ON (lkSzemélyek.[Jogviszony típusa / jogviszony típus] = tBesorolás_átalakító.[Jogviszony típusa]) AND (lkSzemélyek.[Besorolási  fokozat (KT)] = tBesorolás_átalakító.Besorolási_fokozat)) LEFT JOIN kt_azNexon_Adójel ON lkSzemélyek.Adójel = kt_azNexon_Adójel.Adójel
WHERE (((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null) AND (([Illetmény összesen kerekítés nélkül (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40) Not Between [alsó határ] And [felső határ]) AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null) AND ((lkSzemélyek.[Jogviszony vége (kilépés dátuma)]) Is Null Or (lkSzemélyek.[Jogviszony vége (kilépés dátuma)])>Date()))
ORDER BY lkSzemélyek.[Szervezeti egység kódja], lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lk_Illetménysávok_és_illetmények_személytörzs_alapján02
#/#/
SELECT lk_Illetménysávok_és_illetmények_személytörzs_alapján.Főosztály, lk_Illetménysávok_és_illetmények_személytörzs_alapján.[Dolgozó teljes neve], lk_Illetménysávok_és_illetmények_személytörzs_alapján.[Besorolási  fokozat (KT)], lk_Illetménysávok_és_illetmények_személytörzs_alapján.[alsó határ], lk_Illetménysávok_és_illetmények_személytörzs_alapján.[felső határ], lk_Illetménysávok_és_illetmények_személytörzs_alapján.[Illetmény összesen kerekítés nélkül (eltérített)], lk_Illetménysávok_és_illetmények_személytörzs_alapján.[Heti óraszám], lk_Illetménysávok_és_illetmények_személytörzs_alapján.[40 órás illetmény], lk_Illetménysávok_és_illetmények_személytörzs_alapján.[Jogviszony típusa], lk_Illetménysávok_és_illetmények_személytörzs_alapján.Hivatkozás
FROM lk_Illetménysávok_és_illetmények_személytörzs_alapján LEFT JOIN lk_Illetménysávok_és_illetmények_havi_alapján_02 ON lk_Illetménysávok_és_illetmények_személytörzs_alapján.adójel = lk_Illetménysávok_és_illetmények_havi_alapján_02.adójel
WHERE (((lk_Illetménysávok_és_illetmények_havi_alapján_02.adójel) Is Null));

#/#/#/
lk_InaktívBetöltőkÉsÁlláshelyük
#/#/
SELECT [Szervezetmenedzsment kód]*1 AS Adójel, tSzervezeti.[Státuszának kódja], tSzervezeti.[Érvényesség kezdete], tSzervezeti.[Érvényesség vége]
FROM tSzervezeti
WHERE (((tSzervezeti.[Érvényesség kezdete])<(SELECT TOP 1 tHaviJelentésHatálya.hatálya
FROM tHaviJelentésHatálya
GROUP BY tHaviJelentésHatálya.hatálya
ORDER BY First(tHaviJelentésHatálya.[rögzítés]) DESC)) AND ((tSzervezeti.[Érvényesség vége])>(SELECT TOP 1 tHaviJelentésHatálya.hatálya
FROM tHaviJelentésHatálya
GROUP BY tHaviJelentésHatálya.hatálya
ORDER BY First(tHaviJelentésHatálya.[rögzítés]) DESC)) AND ((tSzervezeti.OSZLOPOK)="Státusz betöltés") AND ((tSzervezeti.[Státuszbetöltés típusa])="Inaktív"))
AND "######Azok számítanak inaktívnak, akik a Szervezeti alapriportban olyan sorral rendelkeznek, amelyikben a státuszbetöltés inaktív, és az érvényesség a havi létszámjelentés dátuma előtt kezdődött és azt követően ér véget.#####"<>"";

#/#/#/
lk_IskolaiVégzettségMegoszlása_Főosztályonként
#/#/
TRANSFORM Count(lkSzemélyek.azonosító) AS CountOfadójel
SELECT lkSzemélyek.FőosztályKód, lkSzemélyek.Főosztály AS [Főosztály ill hivatal]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null) AND ((lkSzemélyek.[Státusz típusa]) Is Not Null))
GROUP BY lkSzemélyek.FőosztályKód, lkSzemélyek.Főosztály
ORDER BY lkSzemélyek.Főosztály
PIVOT lkSzemélyek.[Iskolai végzettség foka] In ("","Általános iskola 8 osztály","Egyetemi /felsőfokú (MA/MsC) vagy osztatlan képz.","Éretts.biz.szakképes-vel,képesítő biz.","Éretts.biz.Szakkép-vel,éretts.ép. iskr-ben szakkép","Érettségi biz. szakképesítés nélk (pl: gimn.ér.)","Felsőokt-i (felsőfokú) szakképzésben szerzett biz.","Főiskolai vagy felsőfokú alapképzés (BA/BsC)okl.","Gimnázium","Szakiskola","Szakképzettség érettségi bizonyítvány nélkül","Szakközépiskola","Szakmunkásképző iskola","Technikum");

#/#/#/
lk_IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesen
#/#/
TRANSFORM Count(lkSzemélyek.azonosító) AS CountOfadójel
SELECT "BFKH.1" AS Kif1, "Összesen:" AS [Főosztály ill hivatal]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null) AND ((lkSzemélyek.[Státusz típusa]) Is Not Null))
GROUP BY "Összesen:"
PIVOT lkSzemélyek.[Iskolai végzettség foka] In ("","Általános iskola 8 osztály","Egyetemi /felsőfokú (MA/MsC) vagy osztatlan képz.","Éretts.biz.szakképes-vel,képesítő biz.","Éretts.biz.Szakkép-vel,éretts.ép. iskr-ben szakkép","Érettségi biz. szakképesítés nélk (pl: gimn.ér.)","Felsőokt-i (felsőfokú) szakképzésben szerzett biz.","Főiskolai vagy felsőfokú alapképzés (BA/BsC)okl.","Gimnázium","Szakiskola","Szakképzettség érettségi bizonyítvány nélkül","Szakközépiskola","Szakmunkásképző iskola","Technikum");

#/#/#/
lk_IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesennel
#/#/
SELECT IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesennel.[Főosztály ill hivatal], IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesennel.[<>], IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesennel.[Általános iskola 8 osztály], IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesennel.[Egyetemi /felsőfokú (MA/MsC) vagy osztatlan képz_], IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesennel.[Éretts_biz_szakképes-vel,képesítő biz_], IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesennel.[Éretts_biz_Szakkép-vel,éretts_ép_ iskr-ben szakkép], IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesennel.[Érettségi biz_ szakképesítés nélk (pl: gimn_ér_)], IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesennel.[Felsőokt-i (felsőfokú) szakképzésben szerzett biz_], IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesennel.[Főiskolai vagy felsőfokú alapképzés (BA/BsC)okl_], IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesennel.Gimnázium, IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesennel.Szakiskola, IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesennel.[Szakképzettség érettségi bizonyítvány nélkül], IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesennel.Szakközépiskola, IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesennel.[Szakmunkásképző iskola], IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesennel.Technikum
FROM (SELECT * ,0 as sor
FROM  lk_IskolaiVégzettségMegoszlása_Főosztályonként
UNION

SELECT *, 1 as sor
FROM lk_IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesen
)  AS IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesennel
ORDER BY IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesennel.sor, IskolaiVégzettségMegoszlása_FőosztályonkéntÖsszesennel.FőosztályKód;

#/#/#/
lk_jogász_átlagilletmény
#/#/
SELECT DISTINCT lkSzemélyek.Főosztály, Round(Avg([Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40)/100,0)*100 AS Illetmény
FROM lkSzemélyek INNER JOIN tBesorolás_átalakító ON lkSzemélyek.[Besorolási  fokozat (KT)] = tBesorolás_átalakító.Besorolási_fokozat
WHERE (((lkSzemélyek.[Iskolai végzettség neve]) Like "*jogász*") AND ((lkSzemélyek.[Státusz neve])="Álláshely") AND ((tBesorolás_átalakító.Vezető)=No) AND ((lkSzemélyek.főosztály) Like "*kerület*"))
GROUP BY lkSzemélyek.Főosztály;

#/#/#/
lk_Jogviszony_jellege_01
#/#/
SELECT lkSzemélyek.BFKH, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], Nz([Személytörzs],[KIRA jogviszony jelleg]) AS KIRA_, lkSzemélyek.[Jogviszony típusa / jogviszony típus] AS Nexon, IIf([KIRA_]<>[NEXON] Or [KIRA_] Is Null,1,0) AS hiba, kt_azNexon_Adójel02.NLink
FROM (kt_azNexon_Adójel02 RIGHT JOIN lkSzemélyek ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel) LEFT JOIN tJogviszonyKonverzió ON lkSzemélyek.[KIRA jogviszony jelleg] = tJogviszonyKonverzió.KIRA
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lk_jogviszony_jellege_02
#/#/
SELECT lk_Jogviszony_jellege_01.Főosztály, lk_Jogviszony_jellege_01.Osztály, lk_Jogviszony_jellege_01.[Dolgozó teljes neve], lk_Jogviszony_jellege_01.KIRA_ AS KIRA, lk_Jogviszony_jellege_01.Nexon, lk_Jogviszony_jellege_01.NLink
FROM lk_Jogviszony_jellege_01
WHERE (((lk_Jogviszony_jellege_01.hiba)=1))
ORDER BY lk_Jogviszony_jellege_01.BFKH;

#/#/#/
lk_jogviszony_jellege_02_régi
#/#/
SELECT lk_Jogviszony_jellege_01.BFKH, lk_Jogviszony_jellege_01.[Dolgozó teljes neve] AS Név, lk_Jogviszony_jellege_01.Főosztály, lk_Jogviszony_jellege_01.Osztály, lk_Jogviszony_jellege_01.Kira, lk_Jogviszony_jellege_01.Nexon, lk_Jogviszony_jellege_01.NLink
FROM lk_Jogviszony_jellege_01
WHERE (((lk_Jogviszony_jellege_01.Nexon)<>[Kira]));

#/#/#/
lk_KiraHiba
#/#/
SELECT tKiraHiba.Azonosító, lkSzemélyek.[Szervezeti egység kódja], tSzervezetiEgységek.Főosztály, tSzervezetiEgységek.Osztály, tKiraHiba.Adóazonosító, tKiraHiba.Név, tKiraHiba.Hiba
FROM (tKiraHiba LEFT JOIN lkSzemélyek ON tKiraHiba.Adóazonosító = lkSzemélyek.Adójel) LEFT JOIN tSzervezetiEgységek ON lkSzemélyek.[Szervezeti egység kódja] = tSzervezetiEgységek.[Szervezeti egység kódja]
WHERE (((tKiraHiba.Hiba) Like "*kitöltve*" Or (tKiraHiba.Hiba) Like "*kötelező*" Or (tKiraHiba.Hiba) Like "*nincs*") AND ((lkSzemélyek.[Státusz neve])="álláshely"))
ORDER BY bfkh(Nz([lkSzemélyek].[Szervezeti egység kódja],0)), tKiraHiba.Név;

#/#/#/
lk_KiraHiba_01
#/#/
SELECT bfkh([Szervezeti egység kódja]) AS BFKH, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, tKiraHiba.Adóazonosító, tKiraHiba.Név, lkSzemélyek.[Szervezeti egység kódja], lkSzemélyek.[Státusz kódja], tKiraHiba.Hiba
FROM tKiraHiba LEFT JOIN lkSzemélyek ON tKiraHiba.Adóazonosító = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Státusz kódja]) Like "S-*") AND ((tKiraHiba.Hiba) Not Like "A dolgozo*" And (tKiraHiba.Hiba) Not Like "2-es*" And (tKiraHiba.Hiba) Not Like "*AHELISMD*" And (tKiraHiba.Hiba) Not Like "A dolgozó új belépőként lett*"))
ORDER BY bfkh([Szervezeti egység kódja]);

#/#/#/
lk_KiraHiba_01_címzettek
#/#/
SELECT DISTINCT lk_KiraHiba_01.TO, Count(lk_KiraHiba_01.Adóazonosító) AS CountOfAdóazonosító
FROM lk_KiraHiba_01
GROUP BY lk_KiraHiba_01.TO;

#/#/#/
lk_Lekérdezésíró__Illetmény_nulla_01
#/#/
SELECT tJavítandóMezőnevek.azJavítandó, tNexonMezők.[Nexon mező megnevezése], tJavítandóMezőnevek.Tábla, tJavítandóMezőnevek.Ellenőrzéshez, tJavítandóMezőnevek.Import, "AND ([" & [Ellenőrzéshez] & "].[" & [ÜresÁlláshelyMezők] & "]<> 'üres állás' OR [" & [Ellenőrzéshez] & "].[" & [ÜresÁlláshelyMezők] & "] is null ) " AS Üres, "SELECT '" & [Ellenőrzéshez] & "' as Tábla, 'Illetmény' As [Hiányzó érték], [" & [Adó] & "] As Adójel, [" & [SzervezetKód_mező] & "] As SzervezetKód FROM [" & [Ellenőrzéshez] & "] WHERE [" & [Import] & "]=0 " & [üres] AS [SQL], (Select import From tJavítandóMezőnevek as Belső where Belső.azNexonMezők = 7 and Belső.Ellenőrzéshez = tJavítandóMezőnevek.Ellenőrzéshez) AS Adó
FROM tNexonMezők RIGHT JOIN tJavítandóMezőnevek ON tNexonMezők.azNexonMező = tJavítandóMezőnevek.azNexonMezők
WHERE (((tNexonMezők.[Nexon mező megnevezése])="Illetmény"));

#/#/#/
lk_Lekérdezésíró__Illetmény_nulla_02
#/#/
SELECT (Select count(azJavítandó) From lk_Lekérdezésíró__Illetmény_nulla_01 as Tmp where Tmp.azJavítandó <= külső.azJavítandó) AS Sorszám, külső.azJavítandó, külső.[Nexon mező megnevezése], külső.Tábla, külső.Ellenőrzéshez, külső.Import, külső.SQL, külső.Adó
FROM lk_Lekérdezésíró__Illetmény_nulla_01 AS külső;

#/#/#/
lk_Lekérdezésíró__Illetmény_nulla_03
#/#/
SELECT lk_Lekérdezésíró__Illetmény_nulla_02.Sorszám, lk_Lekérdezésíró__Illetmény_nulla_02.azJavítandó, lk_Lekérdezésíró__Illetmény_nulla_02.[Nexon mező megnevezése], lk_Lekérdezésíró__Illetmény_nulla_02.Tábla, lk_Lekérdezésíró__Illetmény_nulla_02.Ellenőrzéshez, lk_Lekérdezésíró__Illetmény_nulla_02.Import, [SQL] & IIf([Sorszám]<>(Select Max(Sorszám) From lk_Lekérdezésíró__Illetmény_nulla_02)," UNION ","") AS SQL1
FROM lk_Lekérdezésíró__Illetmény_nulla_02;

#/#/#/
lk_mérnök_átlagilletmény
#/#/
SELECT DISTINCT lkSzemélyek.Főosztály, Round(Avg([Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40)/100,0)*100 AS Illetmény
FROM lkSzemélyek INNER JOIN tBesorolás_átalakító ON lkSzemélyek.[Besorolási  fokozat (KT)] = tBesorolás_átalakító.Besorolási_fokozat
WHERE (((lkSzemélyek.[Iskolai végzettség neve]) Like "*mérnök*") AND ((lkSzemélyek.[Státusz neve])="Álláshely") AND ((tBesorolás_átalakító.Vezető)=No) AND ((lkSzemélyek.főosztály) Like "*kerület*"))
GROUP BY lkSzemélyek.Főosztály;

#/#/#/
lk_Népegészségügy_átlagilletmény
#/#/
SELECT bfkh([Szervezeti egység kódja]) AS bfkh, lkSzemélyek.Főosztály, IIf([KIRA feladat megnevezés]="Népegészségügyi feladatok, tisztifőorvos, tisztiorvos","Tisztifőorvos",IIf([FEOR]="2225 - Védőnő","Védőnő","Egyéb")) AS Feladatkörök, Round(Avg([Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40)/100,0)*100 AS Illetmény
FROM lkSzemélyek INNER JOIN tBesorolás_átalakító ON lkSzemélyek.[Besorolási  fokozat (KT)] = tBesorolás_átalakító.Besorolási_fokozat
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.Osztály)="Népegészségügyi Osztály") AND ((tBesorolás_átalakító.Vezető)=No))
GROUP BY bfkh([Szervezeti egység kódja]), lkSzemélyek.Főosztály, IIf([KIRA feladat megnevezés]="Népegészségügyi feladatok, tisztifőorvos, tisztiorvos","Tisztifőorvos",IIf([FEOR]="2225 - Védőnő","Védőnő","Egyéb"))
ORDER BY bfkh([Szervezeti egység kódja]);

#/#/#/
lk_Népegészségügy_átlagilletmény_tisztifőorvos
#/#/
SELECT DISTINCT lkSzemélyek.Adójel, lkSzemélyek.Főosztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Anyja neve], Round([Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40/100,0)*100 AS Illetmény
FROM lkSzemélyek INNER JOIN tBesorolás_átalakító ON lkSzemélyek.[Besorolási  fokozat (KT)] = tBesorolás_átalakító.Besorolási_fokozat
WHERE (((lkSzemélyek.[KIRA feladat megnevezés])="Népegészségügyi feladatok, tisztifőorvos, tisztiorvos") AND ((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.Osztály)="Népegészségügyi Osztály") AND ((tBesorolás_átalakító.Vezető)=No));

#/#/#/
lk_Népegészségügy_átlagilletményFeladatonként
#/#/
SELECT IIf([KIRA feladat megnevezés]="Népegészségügyi feladatok, tisztifőorvos, tisztiorvos","Tisztifőorvos",IIf([FEOR]="2225 - Védőnő","Védőnő",IIf([Iskolai végzettség neve] Like "*járványügyi felügyelő*","Járványügyi felügyelő","Egyéb"))) AS Feladatkörök, Round(Avg([Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40)/100,0)*100 AS Illetmény
FROM lkSzemélyek INNER JOIN tBesorolás_átalakító ON lkSzemélyek.[Besorolási  fokozat (KT)] = tBesorolás_átalakító.Besorolási_fokozat
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.Osztály)="Népegészségügyi Osztály") AND ((tBesorolás_átalakító.Vezető)=No))
GROUP BY IIf([KIRA feladat megnevezés]="Népegészségügyi feladatok, tisztifőorvos, tisztiorvos","Tisztifőorvos",IIf([FEOR]="2225 - Védőnő","Védőnő",IIf([Iskolai végzettség neve] Like "*járványügyi felügyelő*","Járványügyi felügyelő","Egyéb")));

#/#/#/
lk_Népegészségügy_átlagilletményHivatalonként
#/#/
SELECT bfkh([Szervezeti egység kódja]) AS bfkh, lkSzemélyek.Főosztály, Round(Avg([Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40)/100,0)*100 AS Illetmény
FROM lkSzemélyek INNER JOIN tBesorolás_átalakító ON lkSzemélyek.[Besorolási  fokozat (KT)] = tBesorolás_átalakító.Besorolási_fokozat
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.Osztály)="Népegészségügyi Osztály") AND ((tBesorolás_átalakító.Vezető)=No))
GROUP BY bfkh([Szervezeti egység kódja]), lkSzemélyek.Főosztály
ORDER BY bfkh([Szervezeti egység kódja]);

#/#/#/
lk_Osztályonkénti_átlagilletmény_hatóság, gyámügy
#/#/
SELECT bfkh([Szervezeti egység kódja]) AS bfkh, lkSzemélyek.Főosztály, Round(Avg([Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40)/100,0)*100 AS Illetmény, IIf([KIRA feladat megnevezés]="Szociális és gyámügyi feladatok","Gyámügyi feladatok","Hatósági feladatok") AS Feladatkör
FROM lkSzemélyek INNER JOIN tBesorolás_átalakító ON lkSzemélyek.[Besorolási  fokozat (KT)] = tBesorolás_átalakító.Besorolási_fokozat
WHERE (((lkSzemélyek.Osztály)="Hatósági és Gyámügyi Osztály") AND ((tBesorolás_átalakító.Vezető)=No) AND ((lkSzemélyek.[Elsődleges feladatkör]) Not Like "15-Titkársági és igazgatási feladatok"))
GROUP BY bfkh([Szervezeti egység kódja]), lkSzemélyek.Főosztály, IIf([KIRA feladat megnevezés]="Szociális és gyámügyi feladatok","Gyámügyi feladatok","Hatósági feladatok"), lkSzemélyek.[Státusz neve]
HAVING (((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY bfkh([Szervezeti egység kódja]);

#/#/#/
lk_Osztályonkénti_átlagilletmény01
#/#/
SELECT bfkh([Szervezeti egység kódja]) AS bfkh, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, Avg([Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40) AS Illetmény
FROM lkSzemélyek INNER JOIN tBesorolás_átalakító ON lkSzemélyek.[Besorolási  fokozat (KT)] = tBesorolás_átalakító.Besorolási_fokozat
WHERE (((tBesorolás_átalakító.Vezető)=No))
GROUP BY bfkh([Szervezeti egység kódja]), lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Státusz neve]
HAVING (((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY bfkh([Szervezeti egység kódja]);

#/#/#/
lk_Osztályonkénti_átlagilletmény01_kerületiek
#/#/
SELECT bfkh([Szervezeti egység kódja]) AS bfkh, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, Avg([Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40) AS Illetmény, lkSzemélyek.[Elsődleges feladatkör] AS Feladatköre, Count(lkSzemélyek.[Adóazonosító jel]) AS Fő
FROM lkSzemélyek INNER JOIN tBesorolás_átalakító ON lkSzemélyek.jel2 = tBesorolás_átalakító.[Az álláshely jelölése]
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely") AND ((tBesorolás_átalakító.Vezető)=No))
GROUP BY bfkh([Szervezeti egység kódja]), lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Elsődleges feladatkör]
HAVING (((lkSzemélyek.[Elsődleges feladatkör]) Not Like "15-Titkársági és igazgatási feladatok"))
ORDER BY bfkh([Szervezeti egység kódja]);

#/#/#/
lk_Osztályonkénti_átlagilletmény02
#/#/
SELECT lk_Osztályonkénti_átlagilletmény01.Főosztály, lk_Osztályonkénti_átlagilletmény01.Osztály, Round([Illetmény]/100,0)*100 AS Átlagilletmény
FROM lk_Osztályonkénti_átlagilletmény01;

#/#/#/
lk_Osztályonkénti_átlagilletmény02_kerületiek
#/#/
SELECT lk_Osztályonkénti_átlagilletmény01_kerületiek.bfkh, lk_Osztályonkénti_átlagilletmény01_kerületiek.Főosztály, Left([Osztály],15) AS Osztályok, Round([Illetmény]/100,0)*100 AS Átlagilletmény, lk_Osztályonkénti_átlagilletmény01_kerületiek.Fő
FROM lk_Osztályonkénti_átlagilletmény01_kerületiek
WHERE (((lk_Osztályonkénti_átlagilletmény01_kerületiek.Főosztály) Like "bfkh*"));

#/#/#/
lk_Osztályonkénti_átlagilletmény03_kerületiek
#/#/
SELECT lk_Osztályonkénti_átlagilletmény02_kerületiek.Főosztály, IIf([Osztályok]="Kormányablak Os","Kormányablak Osztály",IIf([Osztályok]="Foglalkoztatási","Foglalkoztatási Osztály",IIf([Osztályok]="Gyámügyi Osztál","Gyámügyi Osztály",IIf([Osztályok]="Hatósági és Gyá","Hatósági és Gyámügyi Osztály",IIf([Osztályok]="Hatósági Osztál","Hatósági Osztály",IIf([Osztályok]="Népegészségügyi","Népegészségügyi Osztály","")))))) AS Osztály, Round(Sum([Átlagilletmény]*[Fő])/Sum([Fő])/100,0)*100 AS Átlagilletmények
FROM lk_Osztályonkénti_átlagilletmény02_kerületiek
GROUP BY lk_Osztályonkénti_átlagilletmény02_kerületiek.Főosztály, IIf([Osztályok]="Kormányablak Os","Kormányablak Osztály",IIf([Osztályok]="Foglalkoztatási","Foglalkoztatási Osztály",IIf([Osztályok]="Gyámügyi Osztál","Gyámügyi Osztály",IIf([Osztályok]="Hatósági és Gyá","Hatósági és Gyámügyi Osztály",IIf([Osztályok]="Hatósági Osztál","Hatósági Osztály",IIf([Osztályok]="Népegészségügyi","Népegészségügyi Osztály",""))))));

#/#/#/
lk_RefEmail_01
#/#/
SELECT tSzervezetiEgységek.azSzervezet, tSzervezetiEgységek.[Szervezeti egység kódja], tReferensek.azRef AS azRef, tReferensek.[Hivatali email], tSzervezetiEgységek.Főosztály, tSzervezetiEgységek.Osztály
FROM (tSzervezetiEgységek LEFT JOIN ktReferens_SzervezetiEgység ON tSzervezetiEgységek.azSzervezet=ktReferens_SzervezetiEgység.azSzervezet) LEFT JOIN tReferensek ON ktReferens_SzervezetiEgység.azRef=tReferensek.azRef;

#/#/#/
lk_RefEmail_02
#/#/
SELECT lk_RefEmail_01.azSzervezet, lk_RefEmail_01.[Szervezeti egység kódja], lk_RefEmail_01.azRef, lk_RefEmail_01.[Hivatali email], (Select Count(Tmp.AzSzervezet)
    From lk_RefEmail_01 As Tmp
    Where Tmp.azRef <= lk_RefEmail_01.azRef
      AND Tmp.[Szervezeti egység kódja] =lk_RefEmail_01.[Szervezeti egység kódja]
   ) AS Sorszám, lk_RefEmail_01.Főosztály, lk_RefEmail_01.Osztály
FROM lk_RefEmail_01;

#/#/#/
lk_RefEmail_03
#/#/
PARAMETERS Üssél_egy_entert Long;
TRANSFORM First(lk_RefEmail_02.[Hivatali email]) AS [FirstOfHivatali email]
SELECT lk_RefEmail_02.azSzervezet, lk_RefEmail_02.[Szervezeti egység kódja], lk_RefEmail_02.Főosztály, lk_RefEmail_02.Osztály
FROM lk_RefEmail_02
GROUP BY lk_RefEmail_02.azSzervezet, lk_RefEmail_02.[Szervezeti egység kódja], lk_RefEmail_02.Főosztály, lk_RefEmail_02.Osztály
PIVOT lk_RefEmail_02.Sorszám In (1,2,3,4,5,6);

#/#/#/
lk_RefEmail_04
#/#/
SELECT lk_RefEmail_03.azSzervezet, lk_RefEmail_03.[Szervezeti egység kódja], lk_RefEmail_03.Főosztály, lk_RefEmail_03.Osztály, lk_RefEmail_03.[1], lk_RefEmail_03.[2], lk_RefEmail_03.[3], lk_RefEmail_03.[4], lk_RefEmail_03.[5], lk_RefEmail_03.[6], [1] & IIf(Nz([2],"")="","","; " & [2]) & IIf(Nz([3],"")="","","; " & [3]) & IIf(Nz([4],"")="","","; " & [4]) & IIf(Nz([5],"")="","","; " & [5]) & IIf(Nz([6],"")="","","; " & [6]) AS [TO]
FROM lk_RefEmail_03;

#/#/#/
lk_Szervezet_Referensei
#/#/
SELECT tSzervezetiEgységek.azSzervezet, tSzervezetiEgységek.Főosztály, tSzervezetiEgységek.Osztály, tSzervezetiEgységek.[Szervezeti egység kódja], ktReferens_SzervezetiEgység.azRef
FROM ktReferens_SzervezetiEgység RIGHT JOIN tSzervezetiEgységek ON ktReferens_SzervezetiEgység.azSzervezet=tSzervezetiEgységek.azSzervezet;

#/#/#/
lk_TT_TTH_ellenőrzés_01
#/#/
SELECT Adóazonosító, [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] AS SzervezetKód, [Álláshely azonosító], [Garantált bérminimumban részesül (GB) / tartós távollévő nincs h], [Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], Név
FROM Járási_állomány
WHERE  [Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp] <>""
UNION
SELECT Adóazonosító, [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] AS SzervezetKód, [Álláshely azonosító], [Garantált bérminimumban részesül (GB) / tartós távollévő nincs h], [Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], Név
FROM Kormányhivatali_állomány
WHERE  [Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp] <>""
UNION SELECT Adóazonosító, [Nexon szótárelemnek megfelelő szervezeti egység azonosító] AS SzervezetKód, [Álláshely azonosító], [Tartós távollévő nincs helyettese (TT)/ tartós távollévőnek van ], [Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], Név
FROM Központosítottak
WHERE  [Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp] <>"";

#/#/#/
lk_TT_TTH_ellenőrzés_02a
#/#/
SELECT lk_TT_TTH_ellenőrzés_01.Név, [Adóazonosító]*1 AS Adójel, lk_TT_TTH_ellenőrzés_01.SzervezetKód, lk_TT_TTH_ellenőrzés_01.[Álláshely azonosító], lk_TT_TTH_ellenőrzés_01.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h], lk_TT_TTH_ellenőrzés_01.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], IIf(InStr(1,[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h],"TTH"),1,0) AS TTH, IIf(InStr(1,[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h],"TTH"),0,1) AS TT
FROM lk_TT_TTH_ellenőrzés_01
WHERE (((IIf(InStr(1,[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h],"TTH"),1,0))=1));

#/#/#/
lk_TT_TTH_ellenőrzés_02b
#/#/
SELECT lkSzemélyek_1.[Dolgozó teljes neve] AS [Helyettesített neve], lkSzemélyek_1.Adójel AS [Helyettesített adójele], "A" AS Alaplétszám, Replace(Replace(IIf(InStr(1,[lkSzemélyek_1].[Szint 6 szervezeti egység név],"Budapest"),[lkSzemélyek_1].[Szint 6 szervezeti egység név],"Megyei"),"Budapest Főváros Kormányhivatala","BFKH"),"  ","") AS Megyei_TT, Replace(Replace(IIf(InStr(1,[lkSzemélyek_1].[Szint 6 szervezeti egység név],"Budapest"),[lkSzemélyek_1].[Szint 6 szervezeti egység név],[lkSzemélyek_1].[Szint 6 szervezeti egység név]),"Budapest Főváros Kormányhivatala","BFKH"),"  ","") AS Főoszt_TT, lkSzemélyek_1.[Szint 6 szervezeti egység név], lkSzemélyek_1.[Szervezeti egység kódja] AS [Helyettesített szervezete], lkSzemélyek_1.[KIRA feladat megnevezés], lkSzemélyek_1.[Státusz kódja] AS [Helyettesített álláshelye], lkSzemélyek_1.[Tartós távollét típusa], lkSzemélyek_1.[Tartós távollét kezdete], lkSzemélyek_1.[Tartós távollét vége], lkSzemélyek_1.[Tartós távollét tervezett vége], lkSzemélyek.[Dolgozó teljes neve] AS [Helyettes neve], lkSzemélyek.Adójel AS [Helyettes adójele], "A" AS [Helyettes alaplétszám], lkSzemélyek.[Szervezeti egység kódja] AS [Helyettes szervezete], lkSzemélyek.[Státusz kódja] AS [Helyettes álláshelye], Replace(Replace(IIf(InStr(1,[lkSzemélyek].[Szint 6 szervezeti egység név],"Budapest"),[lkSzemélyek].[Szint 6 szervezeti egység név],"Megyei"),"Budapest Főváros Kormányhivatala","BFKH"),"  ","") AS Megyei_TTH, Replace(Replace(IIf(InStr(1,[lkSzemélyek].[Szint 6 szervezeti egység név],"Budapest"),[lkSzemélyek].[Szint 6 szervezeti egység név],[lkSzemélyek].[Szint 6 szervezeti egység név]),"Budapest Főváros Kormányhivatala","BFKH"),"  ","") AS Főoszt_TTH, lkSzemélyek.[Szint 6 szervezeti egység név], lkSzemélyek.[Szervezeti egység kódja] AS [Helyettesítő szervezete], lkSzemélyek.[KIRA feladat megnevezés], lkSzemélyek.[Státusz kódja] AS Álláshely_TTH, lkSzemélyek.[Jogviszony kezdete (belépés dátuma)], lkSzemélyek.[Jogviszony vége (kilépés dátuma)], lkSzemélyek.[Kerekített 100 %-os illetmény (eltérített)] AS Illetmény_TTH
FROM lkSzemélyek RIGHT JOIN lkSzemélyek AS lkSzemélyek_1 ON lkSzemélyek.[Helyettesített dolgozó neve] = lkSzemélyek_1.[Dolgozó teljes neve]
WHERE (((lkSzemélyek_1.[Tartós távollét típusa]) Is Not Null) And ((IIf(lkSzemélyek.[Helyettesített dolgozó neve]<>"",1,0))=1)) Or (((lkSzemélyek_1.[Tartós távollét típusa]) Not Like "") And ((IIf(lkSzemélyek.[Helyettesített dolgozó neve]<>"",1,0))=1));

#/#/#/
lk_TT_TTH_ellenőrzés_03
#/#/
SELECT tSzervezetiEgységek.Főosztály, tSzervezetiEgységek.Osztály, lk_TT_TTH_ellenőrzés_02a.Név, lk_TT_TTH_ellenőrzés_02a.[Álláshely azonosító], lk_TT_TTH_ellenőrzés_02a.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h], lk_TT_TTH_ellenőrzés_02a.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], lk_TT_TTH_ellenőrzés_02a.Adójel AS Adójel, kt_azNexon_Adójel.NLink AS Nlink
FROM (kt_azNexon_Adójel RIGHT JOIN (lk_TT_TTH_ellenőrzés_02a LEFT JOIN lk_TT_TTH_ellenőrzés_02b ON lk_TT_TTH_ellenőrzés_02a.Adójel = lk_TT_TTH_ellenőrzés_02b.[Helyettesített adójele]) ON kt_azNexon_Adójel.Adójel = lk_TT_TTH_ellenőrzés_02a.Adójel) INNER JOIN tSzervezetiEgységek ON lk_TT_TTH_ellenőrzés_02a.SzervezetKód = tSzervezetiEgységek.[Szervezeti egység kódja]
WHERE (((lk_TT_TTH_ellenőrzés_02b.[Helyettesített adójele]) Is Null) AND ((lk_TT_TTH_ellenőrzés_02a.TTH)=1));

#/#/#/
lk_TTösszevetéseSzemély_Havi
#/#/
SELECT Havi.Bfkh AS bfkh, Havi.Adójel, Havi.Név, Replace([Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH") AS [Szervezeti egység], Havi.Osztály, Havi.Jogcíme AS [Inaktív állományba kerülés oka], Személyek.[Tartós távollét típusa], kt_azNexon_Adójel02.NLink
FROM kt_azNexon_Adójel02 RIGHT JOIN ((SELECT [Adóazonosító]*1 AS Adójel, [lk_TT-sek].Név, [lk_TT-sek].[Járási Hivatal], [lk_TT-sek].Osztály, [lk_TT-sek].Jogcíme, BFKH FROM [lk_TT-sek])  AS Havi LEFT JOIN (SELECT lkSzemélyek.Adójel, lkSzemélyek.[Tartós távollét típusa] FROM lkSzemélyek)  AS Személyek ON Havi.Adójel = Személyek.Adójel) ON kt_azNexon_Adójel02.Adójel = Havi.Adójel
WHERE (((Személyek.[Tartós távollét típusa])<>[Jogcíme]))
ORDER BY Havi.Bfkh, Havi.Név;

#/#/#/
lk_TTösszevetéseSzemély_Havi_Statisztika
#/#/
SELECT bfkh([Szervezeti egység kódja]) AS BFKH, lk_TTösszevetéseSzemély_Havi.[Szervezeti egység], Count(lk_TTösszevetéseSzemély_Havi.Adójel) AS CountOfAdójel
FROM lkFőosztályok INNER JOIN lk_TTösszevetéseSzemély_Havi ON lkFőosztályok.Főosztály=lk_TTösszevetéseSzemély_Havi.[Szervezeti egység]
GROUP BY bfkh([Szervezeti egység kódja]), lk_TTösszevetéseSzemély_Havi.[Szervezeti egység];

#/#/#/
lk_TT-sek
#/#/
SELECT Unió.Adóazonosító, Unió.Név, Unió.[Járási Hivatal], Unió.Osztály, Unió.Jogcíme, Unió.Kinevezés, bfkh([BFKHkód]) AS bfkh
FROM (SELECT Járási_állomány.Adóazonosító, Járási_állomány.Név, Járási_állomány.[Járási Hivatal], Járási_állomány.Mező7 as Osztály, Járási_állomány.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp] as Jogcíme, Mező10 as Kinevezés,[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] as BFKHkód
FROM Járási_állomány
WHERE ((Len(Járási_állomány.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp])>"0"))
UNION
SELECT Kormányhivatali_állomány.Adóazonosító, Kormányhivatali_állomány.Név, Kormányhivatali_állomány.Mező6, Kormányhivatali_állomány.Mező7, Kormányhivatali_állomány.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], Mező10, [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
FROM  Kormányhivatali_állomány
WHERE ((Len(Kormányhivatali_állomány.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp])>"0"))
UNION 
SELECT Központosítottak.Adóazonosító, Központosítottak.Név, Központosítottak.Mező6, Központosítottak.Mező7, Központosítottak.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp],Mező11, [Nexon szótárelemnek megfelelő szervezeti egység azonosító]
FROM   Központosítottak
WHERE ((Len(Központosítottak.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp])>"0"))
)  AS Unió;

#/#/#/
lk_TT-sekFőosztályonként
#/#/
SELECT UnióÖsszeggel.Főosztály AS Főosztály, UnióÖsszeggel.[Tartósan távollévők] AS [Tartósan távollévők]
FROM (SELECT "1." as sor, Replace([lk_TT-sek].[Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH") AS Főosztály, Count([lk_TT-sek].Adóazonosító) AS [Tartósan távollévők],  IIf(Left(Replace([bfkh],"BFKH.01.",""),2)="02",Left(Replace([bfkh],"BFKH.01.",""),5),Left(Replace([bfkh],"BFKH.01.",""),2)) as SzSz
FROM [lk_TT-sek]
WHERE ((([lk_TT-sek].Jogcíme)<>"Mentesítés munkáltató engedélye alapján"))
GROUP BY [lk_TT-sek].[Járási Hivatal], IIf(Left(Replace([bfkh],"BFKH.01.",""),2)="02",Left(Replace([bfkh],"BFKH.01.",""),5),Left(Replace([bfkh],"BFKH.01.",""),2))

UNION SELECT "2." as sor, "Összesen:" AS Főosztály, Count([lk_TT-sek].Adóazonosító) AS [Tartósan távollévők], "999" as SzSz
FROM [lk_TT-sek]
WHERE ((([lk_TT-sek].Jogcíme)<>"Mentesítés munkáltató engedélye alapján"))
GROUP BY "Összesen:")  AS UnióÖsszeggel
GROUP BY UnióÖsszeggel.Főosztály, UnióÖsszeggel.[Tartósan távollévők], UnióÖsszeggel.SzSz, UnióÖsszeggel.sor, UnióÖsszeggel.SzSz
ORDER BY UnióÖsszeggel.sor, UnióÖsszeggel.SzSz;

#/#/#/
lk_TT-TTH_ellenőrzés_02bb
#/#/
SELECT lk_TT_TTH_ellenőrzés_02b.[Helyettesített adójele] As Adójel, "TT" As Állapot
FROM lk_TT_TTH_ellenőrzés_02b
UNION select
lk_TT_TTH_ellenőrzés_02b_1.[Helyettes adójele], "TTH" As Állapot
FROM  lk_TT_TTH_ellenőrzés_02b AS lk_TT_TTH_ellenőrzés_02b_1;

#/#/#/
lk_végzettségenkénti_átlagilletmény00
#/#/
SELECT lkSzemélyek.[Iskolai végzettség neve] AS Végzettség, Round(Avg([Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40)/100,0)*100 AS Illetmény
FROM lkSzemélyek
GROUP BY lkSzemélyek.[Iskolai végzettség neve], lkSzemélyek.[Státusz neve]
HAVING (((lkSzemélyek.[Státusz neve])="Álláshely"));

#/#/#/
lk_végzettségenkénti_átlagilletmény01
#/#/
SELECT IIf([Iskolai végzettség neve] Like "*jog*","Jogász",IIf([Iskolai végzettség neve] Like "*informatik*","Informatikus",IIf([Iskolai végzettség neve] Like "*mérnök*","Mérnök",IIf([Iskolai végzettség neve] Like "*orvos*","Orvos",IIf([Iskolai végzettség neve] Like "*közgazd*","Közgazdász",[Iskolai végzettség neve]))))) AS Végzettség, Round(Avg([Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40)\100,0)*100 AS Illetmény
FROM lkSzemélyek
GROUP BY IIf([Iskolai végzettség neve] Like "*jog*","Jogász",IIf([Iskolai végzettség neve] Like "*informatik*","Informatikus",IIf([Iskolai végzettség neve] Like "*mérnök*","Mérnök",IIf([Iskolai végzettség neve] Like "*orvos*","Orvos",IIf([Iskolai végzettség neve] Like "*közgazd*","Közgazdász",[Iskolai végzettség neve]))))), lkSzemélyek.[Státusz neve]
HAVING (((lkSzemélyek.[Státusz neve])="Álláshely"));

#/#/#/
lk2019ótaAGyámraBelépettek
#/#/
SELECT lkBelépőkUnió.Adójel, lkBelépőkUnió.Név, IIf(Len([lkszemélyek].[Főosztály])<1,"--",[lkszemélyek].[Főosztály]) AS [Jelenlegi főosztálya], ([lkszemélyek].[Osztály]) AS [Jelenlegi osztálya], lkKilépőUnió.Főosztály, lkKilépőUnió.Osztály, lkBelépőkUnió.[Jogviszony kezdő dátuma] AS Belépés, lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja] AS Kilépés
FROM lkSzemélyek RIGHT JOIN (lkBelépőkUnió LEFT JOIN lkKilépőUnió ON lkBelépőkUnió.Adójel = lkKilépőUnió.Adójel) ON lkSzemélyek.Adójel = lkBelépőkUnió.Adójel
WHERE (((lkBelépőkUnió.Főosztály) Like "Gyám*") AND ((lkBelépőkUnió.Osztály) Like "gyám*") AND ((lkBelépőkUnió.[Jogviszony kezdő dátuma])>#1/1/2019#) AND ((lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja])>[lkBelépőkUnió].[Jogviszony kezdő dátuma] Or (lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja]) Is Null));

#/#/#/
lk2019ótaAGyámügyrőlKilépettek
#/#/
SELECT DISTINCT lkKilépőUnió.Adójel, lkKilépőUnió.Név, "--" AS [Jelenlegi főosztálya], "" AS [Jelenlegi osztálya], lkKilépőUnió.Főosztály, lkKilépőUnió.Osztály, lkKilépőUnió.[Jogviszony kezdő dátuma] AS Belépés, lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja] AS Kilépés
FROM lkKilépőUnió
WHERE (((lkKilépőUnió.Főosztály) Like "Gyám*") AND ((lkKilépőUnió.Osztály) Like "*gyám*") AND ((lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja])>#1/1/2019#))
ORDER BY lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja] DESC;

#/#/#/
lk25ÉletévüketBeNemTöltöttekLétszáma
#/#/
SELECT 5 AS Sor, "25 évnél fiatalabbak létszáma:" AS Adat, Sum([25Max].fő) AS Érték, Sum([25Max].TTnélkül) AS nemTT
FROM (SELECT DISTINCT lkSzemélyek.Adójel, 1 AS Fő, Abs([Tartós távollét típusa] Is Null) AS TTnélkül FROM lkSzemélyek WHERE lkSzemélyek.[Születési idő]>DateSerial(Year(Now())-25,Month(Now()),Day(Now())) AND lkSzemélyek.[Státusz neve]="Álláshely")  AS 25Max
GROUP BY 5, "25 évnél fiatalabbak létszáma:";

#/#/#/
lk25ÉvnélIdősebbGyermekHozzátartozók
#/#/
SELECT lkHozzátartozók.[Szervezeti egység neve], lkHozzátartozók.[Dolgozó neve], lkHozzátartozók.[Dolgozó adóazonosító jele], lkHozzátartozók.[Kapcsolat jellege], lkHozzátartozók.[Hozzátartozó neve], lkHozzátartozók.[Születési idő]
FROM lkHozzátartozók
WHERE (((lkHozzátartozók.[Kapcsolat jellege])<>"házastárs" And (lkHozzátartozók.[Kapcsolat jellege])<>"nagykorú hozzátartozó") AND ((lkHozzátartozók.[Születési idő])<DateAdd("yyyy",-25,Date())));

#/#/#/
lk4Talapján
#/#/
SELECT lkMentességek.Azonosító, lkMentességek.[Szervezet név], lkMentességek.[Szervezet telephely sorszám], lkMentességek.[Név előtag], lkMentességek.Családnév, lkMentességek.Utónév, lkMentességek.[Név utótag], lkMentességek.[Email cím], lkMentességek.[Születési név], lkSzemélyek.[Dolgozó születési neve], lkMentességek.[Születési hely], lkSzemélyek.[Születési hely], lkMentességek.[Születési idő], lkSzemélyek.[Születési idő], lkMentességek.[Anyja neve], lkSzemélyek.[Anyja neve], lkMentességek.Mentesség, lkMentességek.[Jogviszony időszak kezdete], lkMentességek.[Jogviszony időszak vége], lkMentességek.Név, lkMentességek.SzülHely, lkSzemélyek.[Besorolási  fokozat (KT)]
FROM lkMentességek LEFT JOIN lkSzemélyek ON (lkMentességek.[Születési név] like "*" & lkSzemélyek.[Dolgozó születési neve] & "*") AND (lkSzemélyek.[Születési hely] LIKE "*" & lkMentességek.[SzülHely]  &"*") AND (lkMentességek.[Születési idő] = lkSzemélyek.[Születési idő]) AND (lkMentességek.[Anyja neve] like "*" & lkSzemélyek.[Anyja neve] & "*")
WHERE IIf([Válaszolj "i"-t, ha csak a vezetőket szeretnéd]="i",[Besorolási  fokozat (KT)]="osztályvezető" Or [Besorolási  fokozat (KT)] Like "kerületi*" Or [Besorolási  fokozat (KT)] Like "*igazgató*" Or [Besorolási  fokozat (KT)] Like "főosztály*" Or [Besorolási  fokozat (KT)]="főispán",[Besorolási  fokozat (KT)] Like "*")
ORDER BY LCase(Replace(Nz([Besorolási  fokozat (KT)],""),"Járási / ","")) & IIf(Nz([Tartós távollét típusa],"")<>""," (TT)","");

#/#/#/
lk55ÉletévüketBetöltöttekLétszáma
#/#/
SELECT 6 AS Sor, "55 évnél idősebbek létszáma:" AS Adat, Sum(MIN56.Fő) AS Érték, Sum(MIN56.TTnélkül) AS nemTT
FROM (SELECT DISTINCT lkSzemélyek.Adójel, 1 AS Fő, Abs([Tartós távollét típusa] Is Null) AS TTnélkül FROM lkSzemélyek WHERE (((lkSzemélyek.[Születési idő])<DateSerial(Year(Now())-55,Month(Now()),Day(Now()))) AND ((lkSzemélyek.[Státusz neve])="Álláshely")))  AS MIN56
GROUP BY "55 évnél idősebbek létszáma:";

#/#/#/
lkAdatváltozásiIgényekElbírálatlanok
#/#/
SELECT lkSzemélyek.Főosztály AS Főosztály, lkSzemélyek.Osztály AS Osztály, lkAdatváltoztatásiIgények.[Dolgozó neve] AS Név, lkAdatváltoztatásiIgények.Állapot AS Állapot, lkAdatváltoztatásiIgények.Adatkör, dtátal([Igény dátuma]) AS [Igény kelte], kt_azNexon_Adójel02.NLink AS NLink
FROM (lkAdatváltoztatásiIgények LEFT JOIN lkSzemélyek ON lkAdatváltoztatásiIgények.Adójel = lkSzemélyek.Adójel) LEFT JOIN kt_azNexon_Adójel02 ON lkAdatváltoztatásiIgények.Adójel = kt_azNexon_Adójel02.Adójel
WHERE (((lkAdatváltoztatásiIgények.Állapot)="Elbírálatlan"))
ORDER BY lkSzemélyek.BFKH, lkAdatváltoztatásiIgények.[Dolgozó neve], lkSzemélyek.[Státusz kódja];

#/#/#/
lkAdatváltozásiIgényekElbírálatlanokUNIXtime
#/#/
SELECT lkSzemélyek.Főosztály AS Főosztály, lkSzemélyek.Osztály AS Osztály, lkAdatváltoztatásiIgények.[Dolgozó neve] AS Név, lkAdatváltoztatásiIgények.Állapot AS Állapot, lkAdatváltoztatásiIgények.Adatkör, Format(DateAdd("s",[Igény dátuma]/1000,#1/1/1970#),"yyyy/mm/dd") AS [Igény kelte], kt_azNexon_Adójel02.NLink AS NLink
FROM (lkAdatváltoztatásiIgények LEFT JOIN lkSzemélyek ON lkAdatváltoztatásiIgények.Adójel = lkSzemélyek.Adójel) LEFT JOIN kt_azNexon_Adójel02 ON lkAdatváltoztatásiIgények.Adójel = kt_azNexon_Adójel02.Adójel
WHERE (((lkAdatváltoztatásiIgények.Állapot)="Elbírálatlan"))
ORDER BY lkSzemélyek.BFKH, lkAdatváltoztatásiIgények.[Dolgozó neve], lkSzemélyek.[Státusz kódja];

#/#/#/
lkAdatváltoztatásiIgények
#/#/
SELECT tAdatváltoztatásiIgények.Azonosító, tAdatváltoztatásiIgények.[Dolgozó neve], tAdatváltoztatásiIgények.[Adóazonosító jel], tAdatváltoztatásiIgények.Adatkör, tAdatváltoztatásiIgények.[Igény dátuma], tAdatváltoztatásiIgények.Állapot, tAdatváltoztatásiIgények.[Elbírálás dátuma], tAdatváltoztatásiIgények.Elbíráló, [Adóazonosító jel]*1 AS Adójel
FROM tAdatváltoztatásiIgények;

#/#/#/
lkAdHocKerületek01
#/#/
SELECT DISTINCT Switch([Végzettség neve] Like "*tiszti*orvos*","tisztiorvos",[Végzettség neve] Like "*védőnő*","védőnő",[Végzettség neve] Like "*járványügyi*","járványügyifelügyelő",[Végzettség neve] Like "*közegészségügyi*","járványügyifelügyelő",[Végzettség neve] Like "*népegészségügyi*","járványügyifelügyelő",[Végzettség neve] Like "*egészségnevelő*","egészségnevelő",[KIRA feladat megnevezés]="Népegészségügyi feladatok, tisztifőorvos, tisztiorvos","tisztiorvos") AS Csoport, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[KIRA feladat megnevezés], Replace([Végzettségei],"nem ismert, ","") AS Végzettsége, [Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40 AS Illetmény
FROM lkDolgozókVégzettségeiFelsorolás04 RIGHT JOIN (lkVégzettségek RIGHT JOIN lkSzemélyek ON lkVégzettségek.Adójel = lkSzemélyek.Adójel) ON lkDolgozókVégzettségeiFelsorolás04.Adójel = lkSzemélyek.Adójel
WHERE (((Switch([Végzettség neve] Like "*tiszti*orvos*","tisztiorvos",[Végzettség neve] Like "*védőnő*","védőnő",[Végzettség neve] Like "*járványügyi*","járványügyifelügyelő",[Végzettség neve] Like "*közegészségügyi*","járványügyifelügyelő",[Végzettség neve] Like "*népegészségügyi*","járványügyifelügyelő",[Végzettség neve] Like "*egészségnevelő*","egészségnevelő",[KIRA feladat megnevezés]="Népegészségügyi feladatok, tisztifőorvos, tisztiorvos","tisztiorvos")) Is Not Null) AND ((lkSzemélyek.Főosztály) Like "* II.*")) OR (((Switch([Végzettség neve] Like "*tiszti*orvos*","tisztiorvos",[Végzettség neve] Like "*védőnő*","védőnő",[Végzettség neve] Like "*járványügyi*","járványügyifelügyelő",[Végzettség neve] Like "*közegészségügyi*","járványügyifelügyelő",[Végzettség neve] Like "*népegészségügyi*","járványügyifelügyelő",[Végzettség neve] Like "*egészségnevelő*","egészségnevelő",[KIRA feladat megnevezés]="Népegészségügyi feladatok, tisztifőorvos, tisztiorvos","tisztiorvos")) Is Not Null) AND ((lkSzemélyek.Főosztály) Like "* V.*")) OR (((Switch([Végzettség neve] Like "*tiszti*orvos*","tisztiorvos",[Végzettség neve] Like "*védőnő*","védőnő",[Végzettség neve] Like "*járványügyi*","járványügyifelügyelő",[Végzettség neve] Like "*közegészségügyi*","járványügyifelügyelő",[Végzettség neve] Like "*népegészségügyi*","járványügyifelügyelő",[Végzettség neve] Like "*egészségnevelő*","egészségnevelő",[KIRA feladat megnevezés]="Népegészségügyi feladatok, tisztifőorvos, tisztiorvos","tisztiorvos")) Is Not Null) AND ((lkSzemélyek.Főosztály) Like "* VI.*")) OR (((Switch([Végzettség neve] Like "*tiszti*orvos*","tisztiorvos",[Végzettség neve] Like "*védőnő*","védőnő",[Végzettség neve] Like "*járványügyi*","járványügyifelügyelő",[Végzettség neve] Like "*közegészségügyi*","járványügyifelügyelő",[Végzettség neve] Like "*népegészségügyi*","járványügyifelügyelő",[Végzettség neve] Like "*egészségnevelő*","egészségnevelő",[KIRA feladat megnevezés]="Népegészségügyi feladatok, tisztifőorvos, tisztiorvos","tisztiorvos")) Is Not Null) AND ((lkSzemélyek.Főosztály) Like "* X.*")) OR (((Switch([Végzettség neve] Like "*tiszti*orvos*","tisztiorvos",[Végzettség neve] Like "*védőnő*","védőnő",[Végzettség neve] Like "*járványügyi*","járványügyifelügyelő",[Végzettség neve] Like "*közegészségügyi*","járványügyifelügyelő",[Végzettség neve] Like "*népegészségügyi*","járványügyifelügyelő",[Végzettség neve] Like "*egészségnevelő*","egészségnevelő",[KIRA feladat megnevezés]="Népegészségügyi feladatok, tisztifőorvos, tisztiorvos","tisztiorvos")) Is Not Null) AND ((lkSzemélyek.Főosztály) Like "* XI.*")) OR (((Switch([Végzettség neve] Like "*tiszti*orvos*","tisztiorvos",[Végzettség neve] Like "*védőnő*","védőnő",[Végzettség neve] Like "*járványügyi*","járványügyifelügyelő",[Végzettség neve] Like "*közegészségügyi*","járványügyifelügyelő",[Végzettség neve] Like "*népegészségügyi*","járványügyifelügyelő",[Végzettség neve] Like "*egészségnevelő*","egészségnevelő",[KIRA feladat megnevezés]="Népegészségügyi feladatok, tisztifőorvos, tisztiorvos","tisztiorvos")) Is Not Null) AND ((lkSzemélyek.Főosztály) Like "* XIV.*")) OR (((Switch([Végzettség neve] Like "*tiszti*orvos*","tisztiorvos",[Végzettség neve] Like "*védőnő*","védőnő",[Végzettség neve] Like "*járványügyi*","járványügyifelügyelő",[Végzettség neve] Like "*közegészségügyi*","járványügyifelügyelő",[Végzettség neve] Like "*népegészségügyi*","járványügyifelügyelő",[Végzettség neve] Like "*egészségnevelő*","egészségnevelő",[KIRA feladat megnevezés]="Népegészségügyi feladatok, tisztifőorvos, tisztiorvos","tisztiorvos")) Is Not Null) AND ((lkSzemélyek.Főosztály) Like "* XXI.*")) OR (((lkSzemélyek.Főosztály) Like "* II.*") AND ((lkSzemélyek.[KIRA feladat megnevezés]) Like "*tiszti*orvos*" And (lkSzemélyek.[KIRA feladat megnevezés])<>"Főosztályvezetői feladatok (több szakmai területet magában foglaló szervezeti egységeknél, ha nem főállatorvos vagy tisztifőorvos)")) OR (((lkSzemélyek.Főosztály) Like "* V.*") AND ((lkSzemélyek.[KIRA feladat megnevezés]) Like "*tiszti*orvos*" And (lkSzemélyek.[KIRA feladat megnevezés])<>"Főosztályvezetői feladatok (több szakmai területet magában foglaló szervezeti egységeknél, ha nem főállatorvos vagy tisztifőorvos)")) OR (((lkSzemélyek.Főosztály) Like "* VI.*") AND ((lkSzemélyek.[KIRA feladat megnevezés]) Like "*tiszti*orvos*" And (lkSzemélyek.[KIRA feladat megnevezés])<>"Főosztályvezetői feladatok (több szakmai területet magában foglaló szervezeti egységeknél, ha nem főállatorvos vagy tisztifőorvos)")) OR (((lkSzemélyek.Főosztály) Like "* X.*") AND ((lkSzemélyek.[KIRA feladat megnevezés]) Like "*tiszti*orvos*" And (lkSzemélyek.[KIRA feladat megnevezés])<>"Főosztályvezetői feladatok (több szakmai területet magában foglaló szervezeti egységeknél, ha nem főállatorvos vagy tisztifőorvos)")) OR (((lkSzemélyek.Főosztály) Like "* XI.*") AND ((lkSzemélyek.[KIRA feladat megnevezés]) Like "*tiszti*orvos*" And (lkSzemélyek.[KIRA feladat megnevezés])<>"Főosztályvezetői feladatok (több szakmai területet magában foglaló szervezeti egységeknél, ha nem főállatorvos vagy tisztifőorvos)")) OR (((lkSzemélyek.Főosztály) Like "* XIV.*") AND ((lkSzemélyek.[KIRA feladat megnevezés]) Like "*tiszti*orvos*" And (lkSzemélyek.[KIRA feladat megnevezés])<>"Főosztályvezetői feladatok (több szakmai területet magában foglaló szervezeti egységeknél, ha nem főállatorvos vagy tisztifőorvos)")) OR (((lkSzemélyek.Főosztály) Like "* XXI.*") AND ((lkSzemélyek.[KIRA feladat megnevezés]) Like "*tiszti*orvos*" And (lkSzemélyek.[KIRA feladat megnevezés])<>"Főosztályvezetői feladatok (több szakmai területet magában foglaló szervezeti egységeknél, ha nem főállatorvos vagy tisztifőorvos)"))
ORDER BY Switch([Végzettség neve] Like "*tiszti*orvos*","tisztiorvos",[Végzettség neve] Like "*védőnő*","védőnő",[Végzettség neve] Like "*járványügyi*","járványügyifelügyelő",[Végzettség neve] Like "*közegészségügyi*","járványügyifelügyelő",[Végzettség neve] Like "*népegészségügyi*","járványügyifelügyelő",[Végzettség neve] Like "*egészségnevelő*","egészségnevelő",[KIRA feladat megnevezés]="Népegészségügyi feladatok, tisztifőorvos, tisztiorvos","tisztiorvos");

#/#/#/
lkAdHocKerületek02
#/#/
SELECT DISTINCT lkAdHocKerületek01.Adójel, lkAdHocKerületek01.Név, lkAdHocKerületek01.[KIRA feladat megnevezés], lkAdHocKerületek01.Főosztály, lkAdHocKerületek01.Csoport
FROM lkAdHocKerületek01
ORDER BY lkAdHocKerületek01.Név;

#/#/#/
lkAdottÉviÖsszesIlletmény
#/#/
SELECT DISTINCT lkÁllománytáblákTörténetiUniója.Főoszt AS Főosztály, lkÁllománytáblákTörténetiUniója.Osztály, lkÁllománytáblákTörténetiUniója.[Besorolási fokozat megnevezése:] AS Besorolás, lkÁllománytáblákTörténetiUniója.Név, lkÁllománytáblákTörténetiUniója.Adóazonosító, [Havi illetmény]/IIf([Heti munkaórák száma]=0,40,[heti munkaórák száma])*40 AS Illetmény, tHaviJelentésHatálya1.hatálya
FROM lkÁllománytáblákTörténetiUniója INNER JOIN tHaviJelentésHatálya1 ON lkÁllománytáblákTörténetiUniója.hatályaID = tHaviJelentésHatálya1.hatályaID
WHERE (((tHaviJelentésHatálya1.hatálya)>#12/31/2023# And (tHaviJelentésHatálya1.hatálya)<#1/1/2025#) AND ((lkÁllománytáblákTörténetiUniója.[Születési év \ üres állás])<>"üres állás"));

#/#/#/
lkAdottÉviÖsszesIlletmény01
#/#/
SELECT lkAdottÉviÖsszesIlletmény.Főosztály, lkAdottÉviÖsszesIlletmény.Osztály, lkAdottÉviÖsszesIlletmény.Besorolás, lkAdottÉviÖsszesIlletmény.Név, lkAdottÉviÖsszesIlletmény.Adóazonosító, Avg(lkAdottÉviÖsszesIlletmény.Illetmény) AS [AvgOfHavi illetmény], dtátal(Year([hatálya]) & "." & Month([hatálya])) AS Kif1
FROM lkAdottÉviÖsszesIlletmény
WHERE (((lkAdottÉviÖsszesIlletmény.[Illetmény])<>0) AND ((lkAdottÉviÖsszesIlletmény.Besorolás) Not Like "*osztályvezető*" And (lkAdottÉviÖsszesIlletmény.Besorolás) Not Like "*Járási hivatalvezető*" And (lkAdottÉviÖsszesIlletmény.Besorolás) Not Like "*igazgató*" And (lkAdottÉviÖsszesIlletmény.Besorolás)<>"főispán") AND ((lkAdottÉviÖsszesIlletmény.Osztály)<>"Kormánymegbízott"))
GROUP BY lkAdottÉviÖsszesIlletmény.Főosztály, lkAdottÉviÖsszesIlletmény.Osztály, lkAdottÉviÖsszesIlletmény.Besorolás, lkAdottÉviÖsszesIlletmény.Név, lkAdottÉviÖsszesIlletmény.Adóazonosító, dtátal(Year([hatálya]) & "." & Month([hatálya]));

#/#/#/
lkAGyámonJelenlegDolgozók
#/#/
SELECT lkSzemélyek.Adójel, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Főosztály AS [Jelenlegi főosztálya], lkSzemélyek.Osztály AS [Jelenlegi osztálya], BelépőkUnió.Főosztály, BelépőkUnió.Osztály, BelépőkUnió.[Jogviszony kezdő dátuma] AS Belépés, lkSzemélyek.[Jogviszony vége (kilépés dátuma)] AS Kilépés
FROM (Select * FROM lkBelépőkUnió 
UNION SELECT Belépők.*, IIf([Megyei szint VAGY Járási Hivatal]="megyei szint",[Mező5],[Megyei szint VAGY Járási Hivatal]) AS Főosztály, Belépők.Mező6 AS Osztály, [adóazonosító]*1 AS Adójel
FROM Belépők
)  AS BelépőkUnió RIGHT JOIN lkSzemélyek ON BelépőkUnió.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.Főosztály) Like "Gyám*") AND ((lkSzemélyek.Osztály) Like "*gyám*") AND ((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)])>#1/1/2019#));

#/#/#/
lkAIKiosk01
#/#/
SELECT tAIKiosk02.Azonosító, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Adójel, lkSzemélyek.[Szervezeti egység kódja], tAIKiosk02.Főosztály
FROM lkSzemélyek, tAIKiosk02
WHERE (((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null) And ((Trim(Replace([Dolgozó teljes neve],"dr.",""))) Like "*" & Trim(Replace([Név],"dr.","")) & "*") And ((tAIKiosk02.Főosztály)=lkSzemélyek.Főosztály))
ORDER BY tAIKiosk02.Azonosító;

#/#/#/
lkAIKiosk01b
#/#/
SELECT lkAIKiosk01.Azonosító, Count(lkAIKiosk01.Azonosító) AS db
FROM lkAIKiosk01
GROUP BY lkAIKiosk01.Azonosító;

#/#/#/
lkAIKiosk02
#/#/
SELECT DISTINCT tAIKiosk02.Főosztály, tAIKiosk02.Osztály, tAIKiosk02.Név, IIf(Nz([db],0)<>1,"Ez az adat nem azonosítható egyértelműen, " & Nz([db],0) & " azonos eredmény található.","Bizonytalanság foka (L.táv.):" & Ls([Név],[lkSzemélyek].[Dolgozó teljes neve])) AS Megjegyzés, IIf(Nz([db],0)=1,[lkSzemélyek].[Dolgozó teljes neve],"") AS Neve, IIf(Nz([db],0)=1,[lkSzemélyek].[Dolgozó születési neve],"") AS [Születési név], IIf(Nz([db],0)=1,[Születési hely] & ", " & [Születési idő],"") AS [Születési hely \ idő], IIf(Nz([db],0)=1,[Anyja neve],"") AS Anyja_neve, IIf(Nz([db],0)=1,[lkSzemélyek].[Adójel],0) AS Adó, IIf(Nz([db],0)=1,[TAJ szám],"") AS TAJ, IIf(Nz([db],0)=1,[Állandó lakcím],"") AS Lakcím, lkSzemélyek.[Státusz kódja], lkSzemélyek.[Besorolási  fokozat (KT)], lkSzemélyek.[Kerekített 100 %-os illetmény (eltérített)]
FROM lkSzemélyek RIGHT JOIN ((lkAIKiosk01 RIGHT JOIN tAIKiosk02 ON lkAIKiosk01.Azonosító = tAIKiosk02.Azonosító) LEFT JOIN lkAIKiosk01b ON tAIKiosk02.Azonosító = lkAIKiosk01b.Azonosító) ON lkSzemélyek.Adójel = lkAIKiosk01.Adójel
WHERE (((tAIKiosk02.Főosztály)=[lkSzemélyek].[Főosztály]))
ORDER BY tAIKiosk02.Osztály;

#/#/#/
lkAlapadatok
#/#/
SELECT tAlapadatok.azAlapadat, tAlapadatok.TulajdonságNeve, tAlapadatok.TulajdonságÉrték, tAlapadatok.Objektum, tAlapadatok.ObjektumTípus
FROM tAlapadatok
WHERE (((tAlapadatok.TulajdonságNeve) Like "*" & [TempVars]![TulNeve] & "*") AND ((tAlapadatok.Objektum) Like "*" & [TempVars]![Obj] & "*") AND ((tAlapadatok.ObjektumTípus) Like "*" & [TempVars]![ObjTip] & "*"));

#/#/#/
lkAlaplétszámIlletmények
#/#/
SELECT Alaplétszám.[járási hivatal] AS [Főosztály\hivatal], Alaplétszám.Adóazonosító, Alaplétszám.Név, Alaplétszám.[Álláshely azonosító], Alaplétszám.[Besorolási fokozat megnevezése:], Alaplétszám.[Heti munkaórák száma], Alaplétszám.Mező18, Round([Mező18]/[Heti munkaórák száma]*40,0) AS [40 órára vetített illetmény], IIf(InStr(1,[Besorolási fokozat kód:],"Mt."),"Mt.","Kit.") AS [Folgalkoztatás jellege], Alaplétszám.mező4 AS Betöltés
FROM (SELECT [járási hivatal], Járási_állomány.Adóazonosító, Név, Járási_állomány.[Álláshely azonosító], [Besorolási fokozat megnevezése:], Járási_állomány.[Heti munkaórák száma], Járási_állomány.Mező18, [Besorolási fokozat kód:], mező4
FROM Járási_állomány
UNION
SELECT Mező6,Kormányhivatali_állomány.Adóazonosító, Név, [Álláshely azonosító], Kormányhivatali_állomány.[Besorolási fokozat megnevezése:], Kormányhivatali_állomány.[Heti munkaórák száma], Kormányhivatali_állomány.Mező18, [Besorolási fokozat kód:], mező4
FROM Kormányhivatali_állomány

)  AS Alaplétszám
WHERE (((Alaplétszám.[Besorolási fokozat megnevezése:]) Like "*hivatali tanácsos*"));

#/#/#/
lkAlapvizsgaSzakvizsga
#/#/
SELECT tSzemélyek.[Dolgozó teljes neve], Replace(IIf(IsNull([tSzemélyek].[Szint 4 szervezeti egység név]),[tSzemélyek].[Szint 3 szervezeti egység név] & "",[tSzemélyek].[Szint 4 szervezeti egység név] & ""),"Budapest Főváros Kormányhivatala ","BFKH ") AS Főosztály, tSzemélyek.[Szervezeti egység neve], tSzemélyek.[Alapvizsga kötelezés dátuma], tSzemélyek.[Alapvizsga letétel tényleges határideje], tSzemélyek.[Alapvizsga mentesség], tSzemélyek.[Alapvizsga mentesség oka], tSzemélyek.[Szakvizsga kötelezés dátuma], tSzemélyek.[Szakvizsga letétel tényleges határideje], tSzemélyek.[Szakvizsga mentesség]
FROM tSzemélyek;

#/#/#/
lkALegutóbbiBesorolásváltozássalÉrintettÁlláshelyekBetöltői
#/#/
SELECT lkJárásiKormányKözpontosítottUnió.Főosztály, lkJárásiKormányKözpontosítottUnió.Osztály, lkJárásiKormányKözpontosítottUnió.Név, lkBesorolásVáltoztatások2.ÁlláshelyAzonosító, lkBesorolásVáltoztatások2.RégiBesorolás, lkBesorolásVáltoztatások2.ÚjBesorolás
FROM lkJárásiKormányKözpontosítottUnió RIGHT JOIN lkBesorolásVáltoztatások2 ON lkJárásiKormányKözpontosítottUnió.[Álláshely azonosító] = lkBesorolásVáltoztatások2.ÁlláshelyAzonosító
WHERE (((lkBesorolásVáltoztatások2.Hatály)=(select max(Hatály) from [tBesorolásVáltoztatások])))
ORDER BY bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]);

#/#/#/
lkÁlláshelyAzonosítókHaviból
#/#/
SELECT Járási_állomány.[Álláshely azonosító] As Álláshely FROM Járási_állomány UNION 
SELECT Kormányhivatali_állomány.[Álláshely azonosító] As Álláshely FROM Kormányhivatali_állomány UNION SELECT Központosítottak.[Álláshely azonosító] As Álláshely  FROM Központosítottak;

#/#/#/
lkÁlláshelyBesorolásEltérés
#/#/
SELECT DISTINCT Unió.név, Unió.Álláshely, Álláshelyek.[Álláshely besorolási kategóriája] AS ÁNYR, tBesorolás_átalakító.Besorolás, tBesorolás_átalakító.Besorolási_fokozat, Unió.Tábla
FROM Álláshelyek RIGHT JOIN ((SELECT Járási_állomány.Név, Járási_állomány.[Álláshely azonosító] As Álláshely, [Besorolási fokozat kód:] as besorolás, "Járási" as Tábla FROM Járási_állomány UNION SELECT Kormányhivatali_állomány.Név, Kormányhivatali_állomány.[Álláshely azonosító] As Álláshely, [Besorolási fokozat kód:] as besorolás, "Kormányhivatali" as Tábla FROM Kormányhivatali_állomány UNION SELECT Központosítottak.Név, Központosítottak.[Álláshely azonosító] As Álláshely, [Besorolási fokozat kód:] as besorolás, "Központosítottak" as Tábla FROM Központosítottak )  AS Unió LEFT JOIN tBesorolás_átalakító ON Unió.besorolás = tBesorolás_átalakító.[Az álláshely jelölése]) ON Álláshelyek.[Álláshely azonosító] = Unió.Álláshely
WHERE (((Álláshelyek.[Álláshely besorolási kategóriája]) Not Like [tBesorolás_átalakító].[Besorolási_fokozat]));

#/#/#/
lkÁlláshelyek
#/#/
SELECT Replace(IIf(Nz([4 szint],"")="",IIf(Nz([3 szint],"")="",IIf(Nz([2 szint],"")="",Nz([1 szint],""),Nz([2 szint],"")),Nz([3 szint],"")),Nz([4 szint],"")),"Budapest Főváros Kormányhivatala ","BFKH ") AS FőosztályÁlláshely, Álláshelyek.[5 szint] AS Osztály, Nz(Switch([FőosztályÁlláshely]="Védelmi bizottság titkársága","Főispán",[FőosztályÁlláshely]="Főigazgatói titkárság","Főigazgató",[FőosztályÁlláshely]="Belső Ellenőrzési Osztály","Főispán"),[FőosztályÁlláshely]) AS Főoszt, Nz(Switch([FőosztályÁlláshely]="Védelmi bizottság titkársága",[FőosztályÁlláshely],[FőosztályÁlláshely]="Főigazgatói titkárság",[FőosztályÁlláshely],[FőosztályÁlláshely]="Belső Ellenőrzési Osztály",[FőosztályÁlláshely]),[Osztály]) AS Oszt, Álláshelyek.*, tBesorolásÁtalakítóEltérőBesoroláshoz.[Besorolási  fokozat (KT)], tBesorolásÁtalakítóEltérőBesoroláshoz.rang, tBesorolásÁtalakítóEltérőBesoroláshoz.jel, IIf([Álláshely státusza]="betöltetlen","ÜÁ." & [jel],IIf([Álláshelyen fennálló jogviszony] Like "Munka*","Mt." & [jel],[jel])) AS jel2
FROM tBesorolásÁtalakítóEltérőBesoroláshoz RIGHT JOIN Álláshelyek ON tBesorolásÁtalakítóEltérőBesoroláshoz.[Álláshely besorolási kategóriája] = Álláshelyek.[Álláshely besorolási kategóriája];

#/#/#/
lkÁlláshelyek(havi)
#/#/
SELECT Unió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Unió.Főosztály, Unió.Osztály, Unió.[Álláshely azonosító], Unió.Állapot, Unió.mező9 AS Feladatkör
FROM (SELECT [Álláshely azonosító], Mező4, [Besorolási fokozat megnevezése:], [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], IIf(Instr(1,[Besorolási fokozat kód:],"ÜÁ"),"üres","betöltött") as Állapot, mező9    , [Járási Hivatal] as Főosztály, Mező7 as Osztály                                           FROM Járási_állomány              UNION SELECT [Álláshely azonosító], Mező4, [Besorolási fokozat megnevezése:], [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], IIf(Instr(1,[Besorolási fokozat kód:],"ÜÁ"),"üres","betöltött") as Állapot, mező9 , mező6 as Főosztály, Mező7 as Osztály FROM Kormányhivatali_állomány            UNION SELECT [Álláshely azonosító], Mező4, [Besorolási fokozat megnevezése:], [Nexon szótárelemnek megfelelő szervezeti egység azonosító], IIf(Instr(1,[Besorolási fokozat kód:],"ÜÁ"),"üres","betöltött") as Állapot, Mező10,  Replace(     IIf(         [Megyei szint VAGY Járási Hivatal]="Megyei szint",         [Mező6],         [Megyei szint VAGY Járási Hivatal]         ),     "Budapest Főváros Kormányhivatala ",     "BFKH "     ) AS Főoszt, mező7 as Osztály FROM Központosítottak                                              )  AS Unió
ORDER BY Bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]);

#/#/#/
lkÁlláshelyek_Alaplétszám
#/#/
SELECT Unió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], [Szint5 - leírás] & [Szint6 - leírás] AS [Főosztály\Hivatal], Unió.[Álláshely azonosító], Unió.Állapot
FROM tSzervezeti RIGHT JOIN (SELECT [Álláshely azonosító], Mező4, [Besorolási fokozat megnevezése:], [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], IIf(Instr(1,[Besorolási fokozat kód:],"ÜÁ"),"üres","betöltött") as Állapot                        FROM Járási_állomány             UNION SELECT [Álláshely azonosító], Mező4, [Besorolási fokozat megnevezése:], [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], IIf(Instr(1,[Besorolási fokozat kód:],"ÜÁ"),"üres","betöltött") as Állapot                        FROM Kormányhivatali_állomány      )  AS Unió ON tSzervezeti.[Szervezetmenedzsment kód]=Unió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
ORDER BY Bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]);

#/#/#/
lkÁlláshelyekÁllapotánakÖsszevetése_Havi_Ányr01
#/#/
SELECT Álláshelyek.[Álláshely azonosító], Álláshelyek.[Álláshely típusa], IIf([Álláshely státusza] Like "*tartósan távollévő*","betöltött",[Álláshely státusza]) AS Ányr, IIf([Állapot]="üres","betöltetlen",[Állapot]) AS Nexon, lkÁlláshelyek_Alaplétszám.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] AS BFKHkód
FROM lkÁlláshelyek_Alaplétszám RIGHT JOIN Álláshelyek ON lkÁlláshelyek_Alaplétszám.[Álláshely azonosító]=Álláshelyek.[Álláshely azonosító];

#/#/#/
lkÁlláshelyekÁllapotánakÖsszevetése_Havi_Ányr02
#/#/
SELECT lk_Főosztály_Osztály_tSzervezet.Főoszt AS Főosztály, lk_Főosztály_Osztály_tSzervezet.Osztály AS Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkÁlláshelyekÁllapotánakÖsszevetése_Havi_Ányr01.[Álláshely azonosító] AS [Státusz kód], lkÁlláshelyekÁllapotánakÖsszevetése_Havi_Ányr01.Ányr AS Ányr, lkÁlláshelyekÁllapotánakÖsszevetése_Havi_Ányr01.Nexon AS Nexon, kt_azNexon_Adójel02.NLink AS NLink
FROM (lk_Főosztály_Osztály_tSzervezet RIGHT JOIN (lkSzemélyek RIGHT JOIN lkÁlláshelyekÁllapotánakÖsszevetése_Havi_Ányr01 ON lkSzemélyek.[Státusz kódja] = lkÁlláshelyekÁllapotánakÖsszevetése_Havi_Ányr01.[Álláshely azonosító]) ON lk_Főosztály_Osztály_tSzervezet.[Szervezetmenedzsment kód] = lkÁlláshelyekÁllapotánakÖsszevetése_Havi_Ányr01.BFKHkód) LEFT JOIN kt_azNexon_Adójel02 ON lkSzemélyek.Adójel = kt_azNexon_Adójel02.Adójel
WHERE (((IIf([Ányr]<>[Nexon],1,0))<>0))
ORDER BY lk_Főosztály_Osztály_tSzervezet.bfkhkód, lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkÁlláshelyekBelsőElosztásaFőosztályOsztály
#/#/
SELECT tÁlláshelyekBelsőElosztásaFőosztályOsztály.azElosztás, Replace([Főosztály],"Budapest Főváros Kormányhivatala","BFKH") AS Főoszt, tÁlláshelyekBelsőElosztásaFőosztályOsztály.Osztály, tÁlláshelyekBelsőElosztásaFőosztályOsztály.[Álláshely azonosító], tÁlláshelyekBelsőElosztásaFőosztályOsztály.Hatály
FROM tÁlláshelyekBelsőElosztásaFőosztályOsztály
WHERE (((tÁlláshelyekBelsőElosztásaFőosztályOsztály.azElosztás)=(Select Top 1 azElosztás from [tÁlláshelyekBelsőElosztásaFőosztályOsztály] as tmp Where tmp.[Álláshely azonosító]=[tÁlláshelyekBelsőElosztásaFőosztályOsztály].[Álláshely azonosító] Order By  tmp.hatály Desc)));

#/#/#/
lkÁlláshelyekBesorolásiJeleHavihoz
#/#/
SELECT lkÁlláshelyek.[Álláshely azonosító], lkÁlláshelyek.jel, lkÁlláshelyek.jel2
FROM lkÁlláshelyek;

#/#/#/
lkÁlláshelyekHaviból
#/#/
SELECT Unió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], [Szint5 - leírás] & [Szint6 - leírás] AS [Főosztály\Hivatal], Unió.[Álláshely azonosító], Unió.[Besorolási fokozat megnevezése:], Unió.Jelleg, Unió.Mező4, Unió.[Besorolási fokozat kód:], Unió.Kinevezés AS [BetöltésMegüresedés dátuma], Unió.TT, Replace([Szint5 - leírás] & [Szint6 - leírás], "Budapest Főváros Kormányhivatala", "BFKH") AS Főoszt, Osztály
FROM tSzervezeti RIGHT JOIN (SELECT [Álláshely azonosító]
		, Mező4
		, [Besorolási fokozat megnevezése:]
		, [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
		, [Besorolási fokozat kód:]
		, "A" AS Jelleg
		, Mező10 AS Kinevezés
		, [Garantált bérminimumban részesül (GB) / tartós távollévő nincs h] AS TT
, Mező7 as Osztály
	FROM Járási_állomány
	
	UNION
	
	SELECT [Álláshely azonosító]
		, Mező4
		, [Besorolási fokozat megnevezése:]
		, [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
		, [Besorolási fokozat kód:]
		, "A" AS Jelleg
		, Mező10
		, [Garantált bérminimumban részesül (GB) / tartós távollévő nincs h] AS TT
, Mező7 as Osztály
	FROM Kormányhivatali_állomány
	
	UNION
	
	SELECT [Álláshely azonosító]
		, Mező4
		, [Besorolási fokozat megnevezése:]
		, [Nexon szótárelemnek megfelelő szervezeti egység azonosító]
		, [Besorolási fokozat kód:]
		, "K" AS Jelleg
		, Mező11
		, "" AS TT
, Mező7 as Osztály
	FROM Központosítottak
	)  AS Unió ON tSzervezeti.[Szervezetmenedzsment kód] = Unió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
ORDER BY Bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]);

#/#/#/
lkÁlláshelyStátuszÖsszevetéseNexonÁnyr
#/#/
SELECT lkÁlláshelyek.FőosztályÁlláshely, lkÁlláshelyek.[Álláshely státusza] AS [Állapot ÁNYR], tBesorolás_átalakító.Üres, lkÁlláshelyek.[Álláshely azonosító]
FROM (lkÁlláshelyek LEFT JOIN lkÁlláshelyekHaviból ON lkÁlláshelyek.[Álláshely azonosító] = lkÁlláshelyekHaviból.[Álláshely azonosító]) LEFT JOIN tBesorolás_átalakító ON lkÁlláshelyekHaviból.[Besorolási fokozat kód:] = tBesorolás_átalakító.[Az álláshely jelölése];

#/#/#/
lkÁlláshelyTábla_HaviLétszámjelentéshez
#/#/
SELECT DISTINCT lkÁlláshelyek.[Álláshely azonosító], lkÁlláshelyek.[Álláshely besorolási kategóriája], lkÁlláshelyek.jel2
FROM lkÁlláshelyek;

#/#/#/
lkÁllományEgyIdőszakban_Kilépettek
#/#/
SELECT lkKilépőUnió.Adóazonosító AS Adójel, lkSzemélyekMind.[Dolgozó teljes neve], Nz([lkKilépőUnió].[Főosztály],[lkSzemélyekMind].[Főosztály]) AS Főoszt, Nz([lkKilépőUnió].[Osztály],[lkSzemélyekMind].[Osztály]) AS Oszt, ffsplit([Feladatkör],"-",2) AS [Ellátandó feladat], lkSzemélyekMind.[Jogviszony kezdete (belépés dátuma)] AS Belépés, lkSzemélyekMind.[Jogviszony vége (kilépés dátuma)] AS Kilépés
FROM lkKilépőUnió INNER JOIN lkSzemélyekMind ON (lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja] = lkSzemélyekMind.[Jogviszony vége (kilépés dátuma)]) AND (lkKilépőUnió.Adójel = lkSzemélyekMind.Adójel) AND (lkSzemélyekMind.[Jogviszony kezdete (belépés dátuma)] = lkKilépőUnió.[Jogviszony kezdő dátuma])
WHERE (((Nz(lkKilépőUnió.Főosztály,lkSzemélyekMind.Főosztály)) Like "Humán*") And ((ffsplit([Feladatkör],"-",2))<>"") And ((lkSzemélyekMind.[Jogviszony kezdete (belépés dátuma)])<=[Az időszak vége]) And ((lkSzemélyekMind.[Jogviszony vége (kilépés dátuma)])>=[Az időszak kezdete]));

#/#/#/
lkÁllománytáblaEgyIdőszakban_Belépettek
#/#/
SELECT lkBelépőkUnió.Adóazonosító AS Adójel, lkSzemélyekMind.[Dolgozó teljes neve], lkBelépőkUnió.Főosztály, lkBelépőkUnió.Osztály, ffsplit([Feladatkör],"-",2) AS [Ellátandó feladat], lkSzemélyekMind.[Jogviszony kezdete (belépés dátuma)] AS Belépés, lkSzemélyekMind.[Jogviszony vége (kilépés dátuma)] AS Kilépés
FROM lkSzemélyekMind INNER JOIN lkBelépőkUnió ON (lkSzemélyekMind.[Jogviszony kezdete (belépés dátuma)] = lkBelépőkUnió.[Jogviszony kezdő dátuma]) AND (lkSzemélyekMind.Adójel = lkBelépőkUnió.Adójel)
WHERE (((lkBelépőkUnió.Főosztály) Like "*" & [Az érintett főosztály] & "*") AND ((lkBelépőkUnió.Osztály) Like "*" & [Az érintett osztály] & "*") AND ((ffsplit([Feladatkör],"-",2))<>"") AND ((lkSzemélyekMind.[Jogviszony kezdete (belépés dátuma)])<=[Az időszak vége]) AND ((lkSzemélyekMind.[Jogviszony vége (kilépés dátuma)])>=[Az időszak kezdete]));

#/#/#/
lkÁllománytáblákTörténetiUniója
#/#/
SELECT Unió.Sorszám, Unió.Név, Unió.Adóazonosító, Unió.[Születési év \ üres állás], Unió.[Nem], Unió.Főoszt, Unió.Osztály, Unió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Unió.[Ellátott feladat], Unió.Kinevezés, Unió.[Feladat jellege], Unió.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ], Unió.[Heti munkaórák száma], Unió.[Betöltés aránya], Unió.[Besorolási fokozat kód:], Unió.[Besorolási fokozat megnevezése:], Unió.[Álláshely azonosító], Unió.[Havi illetmény], Unió.[Eu finanszírozott], Unió.[Illetmény forrása], Unió.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h], Unió.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], Unió.[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)], Unió.[Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis], Unió.[Ügyfélszolgálati munkatárs (1) ügyfélszolgálati háttér munkatárs], Unió.[Képesítést adó végzettség], Unió.KAB, Unió.[KAB 001-3** Branch ID], Unió.hatályaID
FROM (SELECT lktKözpontosítottak.*
FROM  lktKözpontosítottak
UNION
SELECT lktKormányhivatali_állomány.*
FROM lktKormányhivatali_állomány
UNION
SELECT lktJárási_állomány.*
FROM  lktJárási_állomány)  AS Unió;

#/#/#/
lkÁllományUnió20230102_készítő
#/#/
SELECT lkJárásiKormányKözpontosítottUnió.* INTO tÁllományUnió20230102
FROM lkJárásiKormányKözpontosítottUnió;

#/#/#/
lkÁllományUnió20231231_készítő
#/#/
SELECT lkJárásiKormányKözpontosítottUnió.* INTO tÁllományUnió20231231
FROM lkJárásiKormányKözpontosítottUnió;

#/#/#/
lkÁNYR
#/#/
SELECT Álláshelyek.*
FROM Álláshelyek;

#/#/#/
lkAPróbaidőKözelgőLejárata
#/#/
SELECT DISTINCT lkSzemélyek.Főosztály AS Főosztály, lkSzemélyek.Osztály AS Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Hivatali email] AS [Hivatali email], lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége] AS [Próbaidő vége], kt_azNexon_Adójel02.NLink
FROM kt_azNexon_Adójel02 RIGHT JOIN lkSzemélyek ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége]) Between DateSerial(Year(Date()),Month(Date()),1) And DateSerial(Year(Date()),Month(Date())+1,1)-1) AND ((lkSzemélyek.[Státusz neve]) Like "Álláshely"))
ORDER BY lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége];

#/#/#/
lkAPróbaidőKözelgőLejárata03
#/#/
SELECT DISTINCT lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Születési idő], lkSzemélyek.Főosztály AS Főosztály, lkSzemélyek.Osztály AS Osztály, lkSzemélyek.[Hivatali email] AS [Hivatali email], lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége] AS [Próbaidő vége], IIf(Nz([KIRA feladat megnevezés],"") Like "Ügykezelői*","igen","nem") AS Ügykezelőe, lkKözigazgatásiVizsga.[Vizsga típusa] AS Vizsga, lkKözigazgatásiVizsga.[Vizsga letétel terv határideje], lkKözigazgatásiVizsga.[Oklevél dátuma], IIf([Mentesség]=0,"HAMIS","IGAZ") AS Mentes, IIf([Jogviszony vége (kilépés dátuma)]=0,"",[Jogviszony vége (kilépés dátuma)]) AS [Jogviszony vége], kt_azNexon_Adójel02.NLink
FROM kt_azNexon_Adójel02 RIGHT JOIN (lkSzemélyek LEFT JOIN lkKözigazgatásiVizsga ON lkSzemélyek.Adójel = lkKözigazgatásiVizsga.Adójel) ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége]) Between DateSerial(Year(Date()),Month(Date())-1,1) And DateSerial(Year(Date()),Month(Date())+1,1)-1) AND ((lkSzemélyek.[Jogviszony típusa / jogviszony típus])="Hivatásos állományú" Or (lkSzemélyek.[Jogviszony típusa / jogviszony típus])="Munkaviszony" Or (lkSzemélyek.[Jogviszony típusa / jogviszony típus])="Kormányzati szolgálati jogviszony"))
ORDER BY lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége];

#/#/#/
lkÁtlagéletkor
#/#/
SELECT Eredm.Kif1 AS Kif2, #1/1/1867# AS Kif3, DateDiff("yyyy",[Kif2]+[Kif3],Now()) AS Átlagéletkor
FROM (SELECT Avg(Mid([Adójel],2,5)) AS Kif1, lkSzemélyek.[Státusz neve] FROM lkSzemélyek GROUP BY lkSzemélyek.[Státusz neve] HAVING (((lkSzemélyek.[Státusz neve])="Álláshely")))  AS Eredm;

#/#/#/
lkÁtlagéletkorNemenként
#/#/
SELECT Eredm.Kif1 AS Kif2, #1/1/1867# AS Kif3, DateDiff("yyyy",[Kif2]+[Kif3],Now()) AS Átlagéletkor, Eredm.Neme
FROM (SELECT Avg(Mid([Adójel],2,5)) AS Kif1, lkSzemélyek.[Státusz neve], lkSzemélyek.Neme FROM lkSzemélyek GROUP BY lkSzemélyek.[Státusz neve], lkSzemélyek.Neme HAVING (((lkSzemélyek.[Státusz neve])="Álláshely")))  AS Eredm;

#/#/#/
lkÁtlagilletmény_vezetőknélkül
#/#/
SELECT IIf([Jogviszony típusa / jogviszony típus]="Munkaviszony","Munkaviszony",[Besorolási  fokozat (KT)]) AS Besorolás, Sum([Illetmény összesen kerekítés nélkül (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40) AS Összilletmény, Count(lkIlletményhezÁtlag_vezetőknélkül.[Adóazonosító jel]) AS Fő, Round(Avg([Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40)/100,0)*100 AS Átlag, Round(StDev([Illetmény összesen kerekítés nélkül (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40)/100,0)*100 AS [Átlagtól való eltérés (StDev)]
FROM lkIlletményhezÁtlag_vezetőknélkül RIGHT JOIN Álláshelyek ON lkIlletményhezÁtlag_vezetőknélkül.[Státusz kódja] = Álláshelyek.[Álláshely azonosító]
WHERE (((lkIlletményhezÁtlag_vezetőknélkül.[Szervezeti egység kódja]) Is Not Null) AND ((lkIlletményhezÁtlag_vezetőknélkül.[Státusz neve])="Álláshely"))
GROUP BY IIf([Jogviszony típusa / jogviszony típus]="Munkaviszony","Munkaviszony",[Besorolási  fokozat (KT)]);

#/#/#/
lkÁtlagilletmény_vezetőknélkül_Eredmény
#/#/
SELECT "Összesen: " AS Besorolás, Round(Sum([lkÁtlagilletmény_vezetőknélkül].[Összilletmény])/100,0)*100 AS Mindösszesen, Sum(lkÁtlagilletmény_vezetőknélkül.Fő) AS Összlétszám, Round(Sum([Összilletmény])/Sum([Fő])/100,0)*100 AS Átlag, (SELECT Round(StDev([Illetmény összesen kerekítés nélkül (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40)/100,0)*100 AS [Átlagtól való eltérés]
FROM lkSzemélyek LEFT JOIN Álláshelyek ON lkSzemélyek.[Státusz kódja] = Álláshelyek.[Álláshely azonosító]
WHERE (((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null) AND ((lkSzemélyek.[Státusz neve])="Álláshely"))) AS [Átlagtól való eltérés]
FROM lkÁtlagilletmény_vezetőknélkül
GROUP BY "Összesen: ";

#/#/#/
lkÁtlagosHibajavításiIdők
#/#/
SELECT Replace(ffsplit([Második mező],"|",1),"Budapest Főváros Kormányhivatala","BFKH") AS Főosztály, Avg(DateDiff("d",[első időpont],[utolsó időpont])) AS [Átlagos javításiidő], Count(tRégiHibák.[Első mező]) AS Hibaszám
FROM tRégiHibák
WHERE (((tRégiHibák.lekérdezésNeve)<>"lkAPróbaidőKözelgőLejárata" And (tRégiHibák.lekérdezésNeve)<>"lkElvégzendőBesoroltatások02_régi" And (tRégiHibák.lekérdezésNeve)<>"lk_jogviszony_jellege_02_régi" And (tRégiHibák.lekérdezésNeve)<>"lkLejártAlkalmasságiÉrvényesség" And (tRégiHibák.lekérdezésNeve)<>"lkÜresÁlláshelyekÁllapotfelmérő") AND ((tRégiHibák.[Első Időpont])<>[Utolsó Időpont]))
GROUP BY Replace(ffsplit([Második mező],"|",1),"Budapest Főváros Kormányhivatala","BFKH")
HAVING (((Replace(ffsplit([Második mező],"|",1),"Budapest Főváros Kormányhivatala","BFKH"))<>"S-049058" And (Replace(ffsplit([Második mező],"|",1),"Budapest Főváros Kormányhivatala","BFKH"))<>"" And (Replace(ffsplit([Második mező],"|",1),"Budapest Főváros Kormányhivatala","BFKH"))<>"-" And (Replace(ffsplit([Második mező],"|",1),"Budapest Főváros Kormányhivatala","BFKH"))<>"S-045728" And (Replace(ffsplit([Második mező],"|",1),"Budapest Főváros Kormányhivatala","BFKH"))<>"Néráth Andrea Dr.") AND (("Utolsó Időpont")<>(select max([utolsó időpont]) from tRégiHibák where lekérdezésneve <>"lkÜresÁlláshelyekÁllapotfelmérő" And lekérdezésneve <>"lkFontosHiányzóAdatok02")))
ORDER BY Avg(DateDiff("d",[első időpont],[utolsó időpont])) DESC;

#/#/#/
lkAzElmúltTízNap
#/#/
SELECT DateSerial(Year(Now()),Month(Now()),Day(Now())-([Sorszám]-1)) AS Dátum
FROM lkSorszámok
WHERE (((lkSorszámok.Sorszám)<10));

#/#/#/
lkBeKilépők01
#/#/
SELECT BeKilépők.KilépésÉve AS Év, BeKilépők.KilépésHava AS Hó, Sum(BeKilépők.Belépők) AS SumOfBelépők, Sum(BeKilépők.Kilépők) AS SumOfKilépők
FROM (SELECT Adóazonosító, lkKilépők_Személyek01.KilépésÉve, lkKilépők_Személyek01.KilépésHava, 0 As Belépők, lkKilépők_Személyek01.Létszám AS Kilépők 
FROM lkKilépők_Személyek01

UNION
SELECT Adóazonosító, lkBelépők_Személyek01.BelépésÉve, lkBelépők_Személyek01.BelépésHava, lkBelépők_Személyek01.Létszám AS Belépők, 0 as Kilépők
FROM lkBelépők_Személyek01

)  AS BeKilépők
GROUP BY BeKilépők.KilépésÉve, BeKilépők.KilépésHava
HAVING ((([BeKilépők].[KilépésÉve])>2018));

#/#/#/
lkBeKilépők02
#/#/
TRANSFORM Sum([SumOfBelépők]+[SumOfKilépők]) AS Összeg
SELECT lkBeKilépők01.Hó
FROM lkBeKilépők01
GROUP BY lkBeKilépők01.Hó
PIVOT lkBeKilépők01.Év;

#/#/#/
lkBeKilépőkAKövetkezőHónapban
#/#/
SELECT KiBelépők.Dátum, Sum(KiBelépők.[Belépők száma]) AS [Belépők száma], Sum(KiBelépők.[Kilépők száma]) AS [Kilépők száma], [Belépők száma]-[Kilépők száma] AS Mozgás
FROM (SELECT 
lkBelépőkSzáma.Dátum, lkBelépőkSzáma.[Belépők száma], lkBelépőkSzáma.[Kilépők száma]
FROM lkBelépőkSzáma
UNION SELECT
lkKilépőkSzáma.Dátum, lkKilépőkSzáma.[Belépők száma], lkKilépőkSzáma.[Kilépők száma]
FROM  lkKilépőkSzáma
)  AS KiBelépők
GROUP BY KiBelépők.Dátum;

#/#/#/
lkBelépésDátumaAdójel
#/#/
SELECT lkSzemélyek.Adójel, lkSzemélyek.[Jogviszony kezdete (belépés dátuma)]
FROM lkSzemélyek;

#/#/#/
lkBelépők
#/#/
SELECT Belépők.Sorszám, Belépők.Név, Belépők.Adóazonosító, Belépők.Alaplétszám, Belépők.[Megyei szint VAGY Járási Hivatal], Belépők.Mező5, Belépők.Mező6, Belépők.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Belépők.Mező8, Belépők.[Besorolási fokozat kód:], Belépők.[Besorolási fokozat megnevezése:], Belépők.[Álláshely azonosító], Belépők.[Jogviszony kezdő dátuma], Belépők.[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)], Belépők.[Illetmény (Ft/hó)], IIf([Megyei szint VAGY Járási Hivatal]="megyei szint",[Mező5],[Megyei szint VAGY Járási Hivatal]) AS Főosztály, Belépők.Mező6 AS Osztály, CDbl([adóazonosító]) AS Adójel, "-" AS Üres
FROM Belépők;

#/#/#/
lkBelépők_Személyek01
#/#/
SELECT tSzemélyek.[Dolgozó teljes neve] AS Név, Year([Jogviszony kezdete (belépés dátuma)]) AS BelépésÉve, Month([Jogviszony kezdete (belépés dátuma)]) AS BelépésHava, [tSzemélyek].[Adójel]*1 AS Adóazonosító, tSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS Belépés, tSzemélyek.[Szervezeti egység kódja], 1 AS Létszám
FROM tSzemélyek
WHERE (((tSzemélyek.[Jogviszony kezdete (belépés dátuma)]) Is Not Null) AND ((tSzemélyek.[Szervezeti egység kódja]) Not Like "BFKH-MEGB")) OR (((tSzemélyek.[Jogviszony kezdete (belépés dátuma)]) Is Not Null) AND ((tSzemélyek.[Szervezeti egység kódja])="")) OR (((tSzemélyek.[Jogviszony kezdete (belépés dátuma)]) Is Not Null) AND ((tSzemélyek.[Szervezeti egység kódja]) Is Null));

#/#/#/
lkBelépők_Személyek02
#/#/
TRANSFORM Sum(lkBelépők_Személyek01.Létszám) AS SumOfLétszám
SELECT lkBelépők_Személyek01.BelépésHava
FROM lkBelépők_Személyek01
WHERE (((lkBelépők_Személyek01.BelépésÉve)>2018))
GROUP BY lkBelépők_Személyek01.BelépésHava
PIVOT lkBelépők_Személyek01.BelépésÉve;

#/#/#/
lkBelépők2019Jelenig
#/#/
PARAMETERS [Kezdő dátum] DateTime;
SELECT UnióUnió.BFKH, UnióUnió.Főosztály, UnióUnió.Osztály, UnióUnió.[Belépés éve hava], Sum(UnióUnió.Fő) AS SumOfFő
FROM (SELECT bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]) AS BFKH, IIf([Megyei szint VAGY Járási Hivatal]="megyei szint",[Mező5],[Megyei szint VAGY Járási Hivatal]) AS Főosztály, tBelépőkUnió.Mező6 AS Osztály, Year([Jogviszony kezdő dátuma]) & IIf(Len(Month([Jogviszony kezdő dátuma]))=1,"0","") & Month([Jogviszony kezdő dátuma]) AS [Belépés éve hava], 1 AS Fő
FROM tBelépőkUnió
WHERE (((tBelépőkUnió.[Jogviszony kezdő dátuma])>[Kezdő dátum]))
Union SELECT bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]) AS BFKH, IIf([Megyei szint VAGY Járási Hivatal]="megyei szint",[Mező5],[Megyei szint VAGY Járási Hivatal]) AS Főosztály, lkBelépők.Mező6 AS Osztály, Year([Jogviszony kezdő dátuma]) & IIf(Len(Month([Jogviszony kezdő dátuma]))=1,"0","") & Month([Jogviszony kezdő dátuma]) AS [Belépés éve hava], 1 AS Fő
FROM lkBelépők)  AS UnióUnió
GROUP BY UnióUnió.BFKH, UnióUnió.Főosztály, UnióUnió.Osztály, UnióUnió.[Belépés éve hava]
ORDER BY UnióUnió.[Belépés éve hava];

#/#/#/
lkBelépőkEgyAdottFőosztályra2023ban
#/#/
SELECT lkBelépőkUnió.Név, lkBelépőkUnió.Főosztály, lkBelépőkUnió.Osztály, ffsplit([Feladatkör],"-",2) AS [Ellátandó feladat], lkBelépőkUnió.[Jogviszony kezdő dátuma]
FROM lkBelépőkUnió RIGHT JOIN tSzemélyek ON (lkBelépőkUnió.[Jogviszony kezdő dátuma] = tSzemélyek.[Jogviszony kezdete (belépés dátuma)]) AND (lkBelépőkUnió.Adóazonosító = tSzemélyek.[Adóazonosító jel])
WHERE (((lkBelépőkUnió.Főosztály) Like [Szervezeti egység] & "*") AND ((lkBelépőkUnió.[Jogviszony kezdő dátuma]) Between #1/1/2023# And #12/31/2023#));

#/#/#/
lkBelépőkSzáma
#/#/
SELECT dtÁtal([Jogviszony kezdete (belépés dátuma)]) AS Dátum, Count(lkSzemélyek.Adójel) AS [Belépők száma], 0 AS [Kilépők száma]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Jogviszony típusa / jogviszony típus]) Like "munka*" Or (lkSzemélyek.[Jogviszony típusa / jogviszony típus]) Like "korm*"))
GROUP BY dtÁtal([Jogviszony kezdete (belépés dátuma)]), 0
HAVING (((dtÁtal([Jogviszony kezdete (belépés dátuma)])) Between Now() And DateSerial(Year(Now()),Month(Now())+1,Day(Now()))));

#/#/#/
lkBelépőkSzámaÉvente2b
#/#/
SELECT lkBelépőkSzámaÉventeHavonta.Év, Sum(lkBelépőkSzámaÉventeHavonta.[Belépők száma]) AS Belépők
FROM lkBelépőkSzámaÉventeHavonta
GROUP BY lkBelépőkSzámaÉventeHavonta.Év
HAVING (((lkBelépőkSzámaÉventeHavonta.Év)>=2019));

#/#/#/
lkBelépőkSzámaÉventeFélévente01a
#/#/
TRANSFORM Count(tSzemélyek.Azonosító) AS [Belépők száma]
SELECT 1 AS Sorszám, tSzemélyek.[KIRA jogviszony jelleg], Year([Jogviszony kezdete (belépés dátuma)]) AS Év
FROM tSzemélyek
WHERE (((tSzemélyek.[KIRA jogviszony jelleg]) Like "Kormányzati*" Or (tSzemélyek.[KIRA jogviszony jelleg])="Munkaviszony") AND ((Year([Jogviszony kezdete (belépés dátuma)]))>=2019 And (Year([Jogviszony kezdete (belépés dátuma)]))<=Year(Now())+1) AND ((tSzemélyek.[Jogviszony kezdete (belépés dátuma)]) Is Not Null Or (tSzemélyek.[Jogviszony kezdete (belépés dátuma)])<>""))
GROUP BY 1, tSzemélyek.[KIRA jogviszony jelleg], Year([Jogviszony kezdete (belépés dátuma)])
PIVOT IIf(Month([Jogviszony kezdete (belépés dátuma)])<7,1,2);

#/#/#/
lkBelépőkSzámaÉventeFélévente01b
#/#/
TRANSFORM Count(tSzemélyek.Azonosító) AS [Belépők száma]
SELECT 2 AS Sorszám, "Kit. és Mt. együtt:" AS [KIRA jogviszony jelleg], Year([Jogviszony kezdete (belépés dátuma)]) AS Év
FROM tSzemélyek
WHERE (((Year([Jogviszony kezdete (belépés dátuma)]))>=2019 And (Year([Jogviszony kezdete (belépés dátuma)]))<=Year(Now())+1) AND ((tSzemélyek.[Jogviszony kezdete (belépés dátuma)]) Is Not Null Or (tSzemélyek.[Jogviszony kezdete (belépés dátuma)])<>"") AND ((tSzemélyek.[KIRA jogviszony jelleg]) Like "Kormányzati*" Or (tSzemélyek.[KIRA jogviszony jelleg])="Munkaviszony"))
GROUP BY 2, "Kit. és Mt. együtt:", Year([Jogviszony kezdete (belépés dátuma)])
PIVOT IIf(Month([Jogviszony kezdete (belépés dátuma)])<7,1,2);

#/#/#/
lkBelépőkSzámaÉventeFélévente02
#/#/
SELECT lkBelépőkSzámaÉventeFélévente01a.Sorszám, lkBelépőkSzámaÉventeFélévente01a.[KIRA jogviszony jelleg], lkBelépőkSzámaÉventeFélévente01a.Év, lkBelépőkSzámaÉventeFélévente01a.[1], lkBelépőkSzámaÉventeFélévente01a.[2]
FROM lkBelépőkSzámaÉventeFélévente01a
UNION SELECT lkBelépőkSzámaÉventeFélévente01b.Sorszám, lkBelépőkSzámaÉventeFélévente01b.[KIRA jogviszony jelleg], lkBelépőkSzámaÉventeFélévente01b.Év, lkBelépőkSzámaÉventeFélévente01b.[1], lkBelépőkSzámaÉventeFélévente01b.[2]
FROM  lkBelépőkSzámaÉventeFélévente01b;

#/#/#/
lkBelépőkSzámaÉventeHavonta
#/#/
SELECT Year([Jogviszony kezdete (belépés dátuma)]) AS Év, Month([Jogviszony kezdete (belépés dátuma)]) AS Hó, Count(tSzemélyek.Azonosító) AS [Belépők száma]
FROM tSzemélyek
WHERE (((tSzemélyek.[KIRA jogviszony jelleg]) Like "Kormányzati*" Or (tSzemélyek.[KIRA jogviszony jelleg])="Munkaviszony") AND ((tSzemélyek.[Jogviszony kezdete (belépés dátuma)]) Is Not Null Or (tSzemélyek.[Jogviszony kezdete (belépés dátuma)])<>"") AND ((tSzemélyek.[Státusz típusa]) Like "Sz*"))
GROUP BY Year([Jogviszony kezdete (belépés dátuma)]), Month([Jogviszony kezdete (belépés dátuma)])
HAVING (((Year([Jogviszony kezdete (belépés dátuma)]))>=2019 And (Year([Jogviszony kezdete (belépés dátuma)]))<=Year(Now())+1))
ORDER BY Year([Jogviszony kezdete (belépés dátuma)]), Month([Jogviszony kezdete (belépés dátuma)]);

#/#/#/
lkBelépőkSzámaÉventeHavonta2
#/#/
SELECT lkBelépőkSzámaÉventeHavonta.Év, IIf([Hó]=1,[Belépők száma],0) AS 1, IIf([Hó]=2,[Belépők száma],0) AS 2, IIf([Hó]=3,[Belépők száma],0) AS 3, IIf([Hó]=4,[Belépők száma],0) AS 4, IIf([Hó]=5,[Belépők száma],0) AS 5, IIf([Hó]=6,[Belépők száma],0) AS 6, IIf([Hó]=7,[Belépők száma],0) AS 7, IIf([Hó]=8,[Belépők száma],0) AS 8, IIf([Hó]=9,[Belépők száma],0) AS 9, IIf([Hó]=10,[Belépők száma],0) AS 10, IIf([Hó]=11,[Belépők száma],0) AS 11, IIf([Hó]=12,[Belépők száma],0) AS 12
FROM lkBelépőkSzámaÉventeHavonta;

#/#/#/
lkBelépőkSzámaÉventeHavonta2Akkumulálva
#/#/
SELECT lkBelépőkSzámaÉventeHavonta.Év, IIf([Hó]<=1,[Belépők száma],0) AS 1, IIf([Hó]<=2,[Belépők száma],0) AS 2, IIf([Hó]<=3,[Belépők száma],0) AS 3, IIf([Hó]<=4,[Belépők száma],0) AS 4, IIf([Hó]<=5,[Belépők száma],0) AS 5, IIf([Hó]<=6,[Belépők száma],0) AS 6, IIf([Hó]<=7,[Belépők száma],0) AS 7, IIf([Hó]<=8,[Belépők száma],0) AS 8, IIf([Hó]<=9,[Belépők száma],0) AS 9, IIf([Hó]<=10,[Belépők száma],0) AS 10, IIf([Hó]<=11,[Belépők száma],0) AS 11, IIf([Hó]<=12,[Belépők száma],0) AS 12
FROM lkBelépőkSzámaÉventeHavonta;

#/#/#/
lkBelépőkSzámaÉventeHavonta3
#/#/
SELECT lkBelépőkSzámaÉventeHavonta2.Év, Sum(lkBelépőkSzámaÉventeHavonta2.[1]) AS 01, Sum(lkBelépőkSzámaÉventeHavonta2.[2]) AS 02, Sum(lkBelépőkSzámaÉventeHavonta2.[3]) AS 03, Sum(lkBelépőkSzámaÉventeHavonta2.[4]) AS 04, Sum(lkBelépőkSzámaÉventeHavonta2.[5]) AS 05, Sum(lkBelépőkSzámaÉventeHavonta2.[6]) AS 06, Sum(lkBelépőkSzámaÉventeHavonta2.[7]) AS 07, Sum(lkBelépőkSzámaÉventeHavonta2.[8]) AS 08, Sum(lkBelépőkSzámaÉventeHavonta2.[9]) AS 09, Sum(lkBelépőkSzámaÉventeHavonta2.[10]) AS 10, Sum(lkBelépőkSzámaÉventeHavonta2.[11]) AS 11, Sum(lkBelépőkSzámaÉventeHavonta2.[12]) AS 12, lkBelépőkSzámaÉvente2b.Belépők
FROM lkBelépőkSzámaÉvente2b INNER JOIN lkBelépőkSzámaÉventeHavonta2 ON lkBelépőkSzámaÉvente2b.Év = lkBelépőkSzámaÉventeHavonta2.Év
GROUP BY lkBelépőkSzámaÉventeHavonta2.Év, lkBelépőkSzámaÉvente2b.Belépők;

#/#/#/
lkBelépőkSzámaÉventeHavonta3Akkumulálva
#/#/
SELECT lkBelépőkSzámaÉventeHavonta2Akkumulálva.Év, Sum(lkBelépőkSzámaÉventeHavonta2Akkumulálva.[1]) AS 01, Sum(lkBelépőkSzámaÉventeHavonta2Akkumulálva.[2]) AS 02, Sum(lkBelépőkSzámaÉventeHavonta2Akkumulálva.[3]) AS 03, Sum(lkBelépőkSzámaÉventeHavonta2Akkumulálva.[4]) AS 04, Sum(lkBelépőkSzámaÉventeHavonta2Akkumulálva.[5]) AS 05, Sum(lkBelépőkSzámaÉventeHavonta2Akkumulálva.[6]) AS 06, Sum(lkBelépőkSzámaÉventeHavonta2Akkumulálva.[7]) AS 07, Sum(lkBelépőkSzámaÉventeHavonta2Akkumulálva.[8]) AS 08, Sum(lkBelépőkSzámaÉventeHavonta2Akkumulálva.[9]) AS 09, Sum(lkBelépőkSzámaÉventeHavonta2Akkumulálva.[10]) AS 10, Sum(lkBelépőkSzámaÉventeHavonta2Akkumulálva.[11]) AS 11, Sum(lkBelépőkSzámaÉventeHavonta2Akkumulálva.[12]) AS 12, lkBelépőkSzámaÉvente2b.Belépők
FROM lkBelépőkSzámaÉventeHavonta2Akkumulálva INNER JOIN lkBelépőkSzámaÉvente2b ON lkBelépőkSzámaÉventeHavonta2Akkumulálva.Év = lkBelépőkSzámaÉvente2b.Év
GROUP BY lkBelépőkSzámaÉventeHavonta2Akkumulálva.Év, lkBelépőkSzámaÉvente2b.Belépők;

#/#/#/
lkBelépőkSzámaÉventeHavontaFőoszt02
#/#/
SELECT lkBelépőkSzámaÉventeHavontaFőosztOszt01.Főosztály AS Főosztály, lkBelépőkSzámaÉventeHavontaFőosztOszt01.év AS Év, Sum(((IIf([Hó]=1,[Belépők száma],0)))) AS 1, Sum(((IIf([Hó]=2,[Belépők száma],0)))) AS 2, Sum(((IIf([Hó]=3,[Belépők száma],0)))) AS 3, Sum(((IIf([Hó]=4,[Belépők száma],0)))) AS 4, Sum(((IIf([Hó]=5,[Belépők száma],0)))) AS 5, Sum(((IIf([Hó]=6,[Belépők száma],0)))) AS 6, Sum(((IIf([Hó]=7,[Belépők száma],0)))) AS 7, Sum(((IIf([Hó]=8,[Belépők száma],0)))) AS 8, Sum(((IIf([Hó]=9,[Belépők száma],0)))) AS 9, Sum(((IIf([Hó]=10,[Belépők száma],0)))) AS 10, Sum(((IIf([Hó]=12,[Belépők száma],0)))) AS 11, Sum(((IIf([Hó]=12,[Belépők száma],0)))) AS 12, [1]+[2]+[3]+[4]+[5]+[6]+[7]+[8]+[9]+[10]+[11]+[12] AS Összesen
FROM lkBelépőkSzámaÉventeHavontaFőosztOszt01
GROUP BY lkBelépőkSzámaÉventeHavontaFőosztOszt01.Főosztály, lkBelépőkSzámaÉventeHavontaFőosztOszt01.év;

#/#/#/
lkBelépőkSzámaÉventeHavontaFőosztOszt01
#/#/
SELECT Trim(Replace(Replace(Replace([BelépőkUnióMáig].[Főosztály],"Budapest Főváros Kormányhivatala","BFKH")," 20200229-ig",""),"Budapest FővárosKormányhivatala","BFKH")) AS Főosztály, Replace([BelépőkUnióMáig].[Osztály]," 20200229-ig","") AS Osztály, Year([Jogviszony kezdete (belépés dátuma)]) AS Év, Month([Jogviszony kezdete (belépés dátuma)]) AS Hó, Count(tSzemélyek.Azonosító) AS [Belépők száma]
FROM tSzemélyek RIGHT JOIN (SELECT lkBelépőkUnió.Főosztály, lkBelépőkUnió.Osztály, lkBelépőkUnió.Adóazonosító, lkBelépőkUnió.[Jogviszony kezdő dátuma]
  FROM lkBelépőkUnió
  UNION
  SELECT IIf([Megyei szint VAGY Járási Hivatal]="megyei szint",[Mező5],[Megyei szint VAGY Járási Hivatal]) AS Főosztály, lkBelépők.Mező6 AS Osztály, lkBelépők.Adóazonosító, lkBelépők.[Jogviszony kezdő dátuma]
  FROM lkBelépők
)  AS BelépőkUnióMáig ON (tSzemélyek.[Adóazonosító jel] = BelépőkUnióMáig.Adóazonosító) AND (tSzemélyek.[Jogviszony kezdete (belépés dátuma)] = BelépőkUnióMáig.[Jogviszony kezdő dátuma])
WHERE (((tSzemélyek.[KIRA jogviszony jelleg]) Like "Kormányzati*" Or (tSzemélyek.[KIRA jogviszony jelleg])="Munkaviszony") AND ((tSzemélyek.[Jogviszony kezdete (belépés dátuma)]) Is Not Null Or (tSzemélyek.[Jogviszony kezdete (belépés dátuma)])<>"") AND ((Year([Jogviszony kezdete (belépés dátuma)])) Between Year(Now())-4 And Year(Now())+1))
GROUP BY Trim(Replace(Replace(Replace([BelépőkUnióMáig].[Főosztály],"Budapest Főváros Kormányhivatala","BFKH")," 20200229-ig",""),"Budapest FővárosKormányhivatala","BFKH")), Replace([BelépőkUnióMáig].[Osztály]," 20200229-ig",""), Year([Jogviszony kezdete (belépés dátuma)]), Month([Jogviszony kezdete (belépés dátuma)])
ORDER BY Year([Jogviszony kezdete (belépés dátuma)]), Month([Jogviszony kezdete (belépés dátuma)]);

#/#/#/
lkBelépőkSzámaÉventeHavontaFőosztOszt02
#/#/
SELECT lkBelépőkSzámaÉventeHavontaFőosztOszt01.Főosztály, lkBelépőkSzámaÉventeHavontaFőosztOszt01.Osztály, lkBelépőkSzámaÉventeHavontaFőosztOszt01.Év, Sum(IIf([Hó]=1,[Belépők száma],0)) AS 1, Sum(IIf([Hó]=2,[Belépők száma],0)) AS 2, Sum(IIf([Hó]=3,[Belépők száma],0)) AS 3, Sum(IIf([Hó]=4,[Belépők száma],0)) AS 4, Sum(IIf([Hó]=5,[Belépők száma],0)) AS 5, Sum(IIf([Hó]=6,[Belépők száma],0)) AS 6, Sum(IIf([Hó]=7,[Belépők száma],0)) AS 7, Sum(IIf([Hó]=8,[Belépők száma],0)) AS 8, Sum(IIf([Hó]=9,[Belépők száma],0)) AS 9, Sum(IIf([Hó]=10,[Belépők száma],0)) AS 10, Sum(IIf([Hó]=12,[Belépők száma],0)) AS 11, Sum(IIf([Hó]=12,[Belépők száma],0)) AS 12, [1]+[2]+[3]+[4]+[5]+[6]+[7]+[8]+[9]+[10]+[11]+[12] AS Összesen
FROM lkBelépőkSzámaÉventeHavontaFőosztOszt01
GROUP BY lkBelépőkSzámaÉventeHavontaFőosztOszt01.Főosztály, lkBelépőkSzámaÉventeHavontaFőosztOszt01.Osztály, lkBelépőkSzámaÉventeHavontaFőosztOszt01.Év;

#/#/#/
lkBelépőkSzámaÉventeHavontaFőosztOszt02-EgyFőosztályra
#/#/
SELECT lkBelépőkSzámaÉventeHavontaFőosztOszt02.*
FROM lkBelépőkSzámaÉventeHavontaFőosztOszt02
WHERE (((lkBelépőkSzámaÉventeHavontaFőosztOszt02.Főosztály) Like "*" & [Add meg a Főosztály] & "*"));

#/#/#/
lkBelépőkTeljes
#/#/
SELECT tBelépőkUnióÉstBelépőkJövő.Sorszám, tBelépőkUnióÉstBelépőkJövő.Név, tBelépőkUnióÉstBelépőkJövő.Adóazonosító, tBelépőkUnióÉstBelépőkJövő.Alaplétszám, tBelépőkUnióÉstBelépőkJövő.[Megyei szint VAGY Járási Hivatal], tBelépőkUnióÉstBelépőkJövő.Mező5, tBelépőkUnióÉstBelépőkJövő.Mező6, tBelépőkUnióÉstBelépőkJövő.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], tBelépőkUnióÉstBelépőkJövő.Mező8, tBelépőkUnióÉstBelépőkJövő.[Besorolási fokozat kód:], tBelépőkUnióÉstBelépőkJövő.[Besorolási fokozat megnevezése:], tBelépőkUnióÉstBelépőkJövő.[Álláshely azonosító], tBelépőkUnióÉstBelépőkJövő.[Jogviszony kezdő dátuma], tBelépőkUnióÉstBelépőkJövő.[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)], tBelépőkUnióÉstBelépőkJövő.[Illetmény (Ft/hó)]
FROM (SELECT tBelépőkUnió.*
FROM tBelépőkUnió
UNION SELECT  tBelépőkJövő.*
FROM tBelépőkJövő)  AS tBelépőkUnióÉstBelépőkJövő;

#/#/#/
lkBelépőkUnió
#/#/
SELECT tBelépőkUnió.*, IIf([Megyei szint VAGY Járási Hivatal]="megyei szint",[Mező5],[Megyei szint VAGY Járási Hivatal]) AS Főosztály, tBelépőkUnió.Mező6 AS Osztály, CDbl([adóazonosító]) AS Adójel, "-" AS Üres
FROM tBelépőkUnió;

#/#/#/
lkBelsőEllenőrzésNemesfém01
#/#/
SELECT tKormányhivatali_állomány.Mező7 AS Osztály, tHaviJelentésHatálya1.hatálya AS Időszak, Count(tKormányhivatali_állomány.Adóazonosító) AS CountOfAdóazonosító
FROM tHaviJelentésHatálya1 INNER JOIN tKormányhivatali_állomány ON tHaviJelentésHatálya1.hatályaID = tKormányhivatali_állomány.hatályaID
WHERE (((tKormányhivatali_állomány.Mező4)<>"üres állás")) OR (((tKormányhivatali_állomány.Mező4)<>"üres állás"))
GROUP BY tKormányhivatali_állomány.Mező7, tHaviJelentésHatálya1.hatálya
HAVING (((tKormányhivatali_állomány.Mező7)="Nemesfém Nyilvántartási, Ellenőrzési és Vizsgálati Osztály") AND ((tHaviJelentésHatálya1.hatálya) Between #12/31/2023# And #12/31/2024#)) OR (((tKormányhivatali_állomány.Mező7)="Nemesfémhitelesítési és Pénzmosás Felügyeleti Osztály") AND ((tHaviJelentésHatálya1.hatálya) Between #12/31/2023# And #12/31/2024#));

#/#/#/
lkBelsőEllenőrzésNemesfém02
#/#/
SELECT lkBelsőEllenőrzésNemesfém01.Osztály, lkBelsőEllenőrzésNemesfém01.Időszak, lkBelsőEllenőrzésNemesfém01.CountOfAdóazonosító
FROM lkBelsőEllenőrzésNemesfém01 INNER JOIN lkKiemeltNapok ON lkBelsőEllenőrzésNemesfém01.Időszak = lkKiemeltNapok.KiemeltNapok
WHERE (((lkKiemeltNapok.tnap)=31));

#/#/#/
lkBelsőEllenőrzésNemesfémLista
#/#/
SELECT DISTINCT tKormányhivatali_állomány.Mező7 AS Osztály, tHaviJelentésHatálya1.hatálya AS Időszak, tKormányhivatali_állomány.Adóazonosító, tKormányhivatali_állomány.Név
FROM tHaviJelentésHatálya1 INNER JOIN tKormányhivatali_állomány ON tHaviJelentésHatálya1.hatályaID = tKormányhivatali_állomány.hatályaID
WHERE (((tKormányhivatali_állomány.Mező7)="Nemesfém Nyilvántartási, Ellenőrzési és Vizsgálati Osztály") AND ((tHaviJelentésHatálya1.hatálya) Between #12/31/2023# And #12/31/2024#) AND ((tKormányhivatali_állomány.Mező4)<>"üres állás") AND ((Day([hatálya]))=28 Or (Day([hatálya]))=29 Or (Day([hatálya]))=30 Or (Day([hatálya]))=31)) OR (((tKormányhivatali_állomány.Mező7)="Nemesfémhitelesítési és Pénzmosás Felügyeleti Osztály") AND ((tHaviJelentésHatálya1.hatálya) Between #12/31/2023# And #12/31/2024#) AND ((tKormányhivatali_állomány.Mező4)<>"üres állás") AND ((Day([hatálya]))=28 Or (Day([hatálya]))=29 Or (Day([hatálya]))=30 Or (Day([hatálya]))=31))
ORDER BY tKormányhivatali_állomány.Mező7, tHaviJelentésHatálya1.hatálya, tKormányhivatali_állomány.Adóazonosító;

#/#/#/
lkBelsőEngedélyezettLétszámokJelenleg
#/#/
SELECT tBelsőEngedélyezettLétszámok.FőosztályKód, tBelsőEngedélyezettLétszámok.Főosztály, tBelsőEngedélyezettLétszámok.Osztály, Sum(tBelsőEngedélyezettLétszámok.EngedélyVáltozás) AS Létszám
FROM tBelsőEngedélyezettLétszámok
WHERE (((tBelsőEngedélyezettLétszámok.Hatály)=(Select Max([Hatály]) From [tBelsőEngedélyezettLétszámok] as TMP WHere [tBelsőEngedélyezettLétszámok].[FőosztályKód]=tmp.[FőosztályKód])))
GROUP BY tBelsőEngedélyezettLétszámok.FőosztályKód, tBelsőEngedélyezettLétszámok.Főosztály, tBelsőEngedélyezettLétszámok.Osztály;

#/#/#/
lkBelsőEngedélyezettLétszámtólEltérés01
#/#/
SELECT ÖsszesenAzlkÁlláshelyekHaviból.Főosztály, lkBelsőEngedélyezettLétszámokJelenleg.Létszám AS Engedélyezett, ÖsszesenAzlkÁlláshelyekHaviból.[CountOfÁlláshely azonosító] AS Tényleges, [Engedélyezett]-[Tényleges] AS Eltérés
FROM lkBelsőEngedélyezettLétszámokJelenleg INNER JOIN (SELECT [lkÁlláshelyek(havi)].Főosztály, Count([lkÁlláshelyek(havi)].[Álláshely azonosító]) AS [CountOfÁlláshely azonosító] FROM [lkÁlláshelyek(havi)] GROUP BY [lkÁlláshelyek(havi)].Főosztály)  AS ÖsszesenAzlkÁlláshelyekHaviból ON lkBelsőEngedélyezettLétszámokJelenleg.Főosztály = ÖsszesenAzlkÁlláshelyekHaviból.Főosztály
GROUP BY ÖsszesenAzlkÁlláshelyekHaviból.Főosztály, lkBelsőEngedélyezettLétszámokJelenleg.Létszám, ÖsszesenAzlkÁlláshelyekHaviból.[CountOfÁlláshely azonosító];

#/#/#/
lkBelsőEngedélyezettLétszámtólEltérés02
#/#/
SELECT lkBelsőEngedélyezettLétszámtólEltérés01.Főosztály, lkBelsőEngedélyezettLétszámtólEltérés01.Engedélyezett, lkBelsőEngedélyezettLétszámtólEltérés01.Tényleges, lkBelsőEngedélyezettLétszámtólEltérés01.Eltérés
FROM lkBelsőEngedélyezettLétszámtólEltérés01
WHERE (((lkBelsőEngedélyezettLétszámtólEltérés01.Eltérés)<>0));

#/#/#/
lkBesorolásEmeléshez01
#/#/
SELECT Bfkh([Szervezetkód]) AS BFKH, lk_Állománytáblákból_Illetmények.Szervezetkód, lk_Állománytáblákból_Illetmények.Adójel, tSzervezet.[Tervezett betöltési adatok - Előmeneteli fokozat megnevezés] AS besorolás, lk_Állománytáblákból_Illetmények.[Álláshely azonosító], tBesorolás_átalakító_1.[alsó határ], tBesorolás_átalakító_1.[felső határ], lk_Állománytáblákból_Illetmények.Illetmény, Besorolás_átalakító.alsó2, Besorolás_átalakító.felső2, lk_Állománytáblákból_Illetmények.[Heti munkaórák száma], [Illetmény]/IIf([Heti munkaórák száma]=0,0.0001,[Heti munkaórák száma])*40 AS [40 órás illetmény], tBesorolás_átalakító_1.[Jogviszony típusa], lk_Állománytáblákból_Illetmények.Név, lk_Állománytáblákból_Illetmények.Főosztály, lk_Állománytáblákból_Illetmények.Osztály
FROM (SELECT [alsó határ] AS alsó2, [felső határ] AS felső2, Üres, Kit, Mt, [Sorrend]-1 AS EmeltSorrend FROM tBesorolás_átalakító)  AS Besorolás_átalakító RIGHT JOIN (tBesorolás_átalakító AS tBesorolás_átalakító_1 RIGHT JOIN (lk_Állománytáblákból_Illetmények RIGHT JOIN tSzervezet ON lk_Állománytáblákból_Illetmények.[Álláshely azonosító]=tSzervezet.[Szervezetmenedzsment kód]) ON tBesorolás_átalakító_1.[Az álláshely jelölése]=lk_Állománytáblákból_Illetmények.BesorolásHavi) ON (Besorolás_átalakító.EmeltSorrend=tBesorolás_átalakító_1.Sorrend) AND (Besorolás_átalakító.Mt=tBesorolás_átalakító_1.Mt) AND (Besorolás_átalakító.Kit=tBesorolás_átalakító_1.Kit) AND (Besorolás_átalakító.Üres=tBesorolás_átalakító_1.Üres)
WHERE ((([Illetmény]/IIf([Heti munkaórák száma]=0,0.0001,[Heti munkaórák száma])*40) Not Between [alsó határ] And [felső határ])) OR ((([Illetmény]/IIf([Heti munkaórák száma]=0,0.0001,[Heti munkaórák száma])*40) Not Between [alsó2] And [felső2]));

#/#/#/
lkBesorolásEmeléshez02
#/#/
SELECT lkBesorolásEmeléshez01.BFKH, lkBesorolásEmeléshez01.Főosztály, lkBesorolásEmeléshez01.Osztály, lkBesorolásEmeléshez01.Adójel, lkBesorolásEmeléshez01.Név, lkBesorolásEmeléshez01.[Jogviszony típusa], lkBesorolásEmeléshez01.besorolás AS [Jelenlegi beorolás], lkBesorolásEmeléshez01.[alsó határ] AS [Jelenlegi alsó határ], lkBesorolásEmeléshez01.[felső határ] AS [Jelenlegi felsó határ], lkBesorolásEmeléshez01.[40 órás illetmény], lkBesorolásEmeléshez01.alsó2 AS [Emelt alsó határ], lkBesorolásEmeléshez01.felső2 AS [Emelt felső határ], *
FROM lkBesorolásEmeléshez01
WHERE (((lkBesorolásEmeléshez01.besorolás)="Vezető-hivatalitanácsos")) OR (((lkBesorolásEmeléshez01.besorolás)="Hivatali tanácsos"))
ORDER BY lkBesorolásEmeléshez01.Adójel, lkBesorolásEmeléshez01.[40 órás illetmény];

#/#/#/
lkBesorolásHaviÁNYR
#/#/
SELECT lkJárásiKormányKözpontosítottUnió.[Álláshely azonosító], lkJárásiKormányKözpontosítottUnió.[Besorolási fokozat kód:], lkÁlláshelyek.jel2 AS ÁNYRből, lkJárásiKormányKözpontosítottUnió.[Besorolási fokozat megnevezése:]
FROM lkJárásiKormányKözpontosítottUnió INNER JOIN lkÁlláshelyek ON lkJárásiKormányKözpontosítottUnió.[Álláshely azonosító] = lkÁlláshelyek.[Álláshely azonosító];

#/#/#/
lkBesorolásHelyettes02
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkBesorolásHelyettesek.Név AS [TT-s neve], lkBesorolásHelyettesek.Adójel AS [TT-s adójele], lkSzemélyek.[Tartós távollét típusa], [Családi név] & " " & [Utónév] AS [TTH-s neve], lkBesorolásHelyettesek.Kezdete1, lkBesorolásHelyettesek.Vége1, "https://nexonport.kh.gov.hu/menu/hrm/szemelyiKarton/index?szemelyAzonosito=" & [azNexon] & "&r=13" AS Link
FROM kt_azNexon_Adójel INNER JOIN (lkSzemélyek RIGHT JOIN lkBesorolásHelyettesek ON lkSzemélyek.[Dolgozó teljes neve] = lkBesorolásHelyettesek.Név) ON kt_azNexon_Adójel.Adójel = lkBesorolásHelyettesek.Adójel
WHERE (((lkSzemélyek.[Tartós távollét típusa]) Is Not Null))
ORDER BY lkBesorolásHelyettesek.Név, lkBesorolásHelyettesek.Kezdete1, lkBesorolásHelyettesek.Vége1;

#/#/#/
lkBesorolásHelyettesek
#/#/
SELECT BesorolásHelyettesített.Azonosító, BesorolásHelyettesített.Adójel, BesorolásHelyettesített.[TAJ szám], BesorolásHelyettesített.[Egyedi azonosító], BesorolásHelyettesített.Törzsszám, BesorolásHelyettesített.Előnév, BesorolásHelyettesített.[Családi név], BesorolásHelyettesített.Utónév, BesorolásHelyettesített.[Jogviszony ID], BesorolásHelyettesített.Kód, BesorolásHelyettesített.Megnevezés, BesorolásHelyettesített.Kezdete, BesorolásHelyettesített.Vége, BesorolásHelyettesített.Kezdete1, BesorolásHelyettesített.Vége1, BesorolásHelyettesített.[Helyettesítés oka], BesorolásHelyettesített.[Jogviszony ID1], BesorolásHelyettesített.[Eltérő illetmény fokozata], BesorolásHelyettesített.Előnév1, BesorolásHelyettesített.[Családi név1], BesorolásHelyettesített.Utónév1, Trim([Családi név1]) & " " & Trim([Utónév1] & " " & [Előnév1]) AS Név
FROM BesorolásHelyettesített;

#/#/#/
lkBesorolásiEredményadatok
#/#/
SELECT [Adóazonosító jel]*1 AS Adójel, tBesorolásiEredményadatok.*, tBesorolásiEredményadatok.Kezdete4, dtÁtal([Vége5]) AS SzerzVég
FROM tBesorolásiEredményadatok;

#/#/#/
lkBesorolásiEredményadatokUtolsó
#/#/
SELECT lkBesorolásiEredményadatok.*
FROM lkBesorolásiEredményadatok
WHERE (((lkBesorolásiEredményadatok.[Változás dátuma])=(select Max([Tmp].[Változás dátuma]) from [lkBesorolásiEredményadatok] as Tmp where tmp.adójel=[lkBesorolásiEredményadatok].[Adójel])));

#/#/#/
lkBesorolásokSzervezetiVsÁNYR
#/#/
SELECT lkJárásiKormányKözpontosítottUnió.[Járási Hivatal] AS Főosztály, lkJárásiKormányKözpontosítottUnió.Osztály, lkJárásiKormányKözpontosítottUnió.Név, tBesorolás_átalakító.Besorolási_fokozat AS Nexon, Álláshelyek.[Álláshely besorolási kategóriája] AS ÁNYR, kt_azNexon_Adójel02.NLink
FROM (tBesorolás_átalakító RIGHT JOIN (lkJárásiKormányKözpontosítottUnió RIGHT JOIN Álláshelyek ON lkJárásiKormányKözpontosítottUnió.[Álláshely azonosító] = Álláshelyek.[Álláshely azonosító]) ON (tBesorolás_átalakító.[Az álláshely megynevezése] = lkJárásiKormányKözpontosítottUnió.[Besorolási fokozat megnevezése:]) AND (tBesorolás_átalakító.[Az álláshely jelölése] = lkJárásiKormányKözpontosítottUnió.[Besorolási fokozat kód:])) LEFT JOIN kt_azNexon_Adójel02 ON lkJárásiKormányKözpontosítottUnió.Adójel = kt_azNexon_Adójel02.Adójel
WHERE (((Álláshelyek.[Álláshely besorolási kategóriája])<>[Besorolási_fokozat]));

#/#/#/
lkBesorolásonkénti_létszám_01
#/#/
SELECT Álláshelyek.[Álláshely besorolási kategóriája], Count(Unió.Álláshely) AS CountOfÁlláshely
FROM (SELECT Járási_állomány.Név, Járási_állomány.[Álláshely azonosító] As Álláshely, [Besorolási fokozat kód:] as besorolás, "Járási" as Tábla FROM Járási_állomány UNION SELECT Kormányhivatali_állomány.Név, Kormányhivatali_állomány.[Álláshely azonosító] As Álláshely, [Besorolási fokozat kód:] as besorolás, "Kormányhivatali" as Tábla FROM Kormányhivatali_állomány UNION SELECT Központosítottak.Név, Központosítottak.[Álláshely azonosító] As Álláshely, [Besorolási fokozat kód:] as besorolás, "Központosítottak" as Tábla FROM Központosítottak )  AS Unió LEFT JOIN Álláshelyek ON Unió.Álláshely = Álláshelyek.[Álláshely azonosító]
GROUP BY Álláshelyek.[Álláshely besorolási kategóriája];

#/#/#/
lkBesorolásonkénti_létszám_és_illetmény
#/#/
SELECT IIf([Jogviszony típusa / jogviszony típus]="Munkaviszony","Munkaviszony",[Besorolási  fokozat (KT)]) AS Besorolás, Sum([Illetmény összesen kerekítés nélkül (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40) AS Összilletmény, Count(lkSzemélyek.[Adóazonosító jel]) AS Fő, Round(Avg([Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40)/100,0)*100 AS Átlag, Round(StDev([Illetmény összesen kerekítés nélkül (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40)/100,0)*100 AS [Átlagtól való eltérés (StDev)]
FROM Álláshelyek LEFT JOIN lkSzemélyek ON Álláshelyek.[Álláshely azonosító] = lkSzemélyek.[Státusz kódja]
WHERE (((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null) AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
GROUP BY IIf([Jogviszony típusa / jogviszony típus]="Munkaviszony","Munkaviszony",[Besorolási  fokozat (KT)]);

#/#/#/
lkBesorolásonkénti_létszám_és_illetmény_AdottFőosztályra
#/#/
SELECT lkSzemélyek.Főosztály, IIf([Jogviszony típusa / jogviszony típus]="Munkaviszony","Munkaviszony",[Besorolási  fokozat (KT)]) AS Besorolás, Sum([Illetmény összesen kerekítés nélkül (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40) AS Összilletmény, Count(lkSzemélyek.[Adóazonosító jel]) AS Fő, Round(Avg([Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40)/100,0)*100 AS Átlag, Round(StDev([Illetmény összesen kerekítés nélkül (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40)/100,0)*100 AS [Átlagtól való eltérés (StDev)]
FROM Álláshelyek LEFT JOIN lkSzemélyek ON Álláshelyek.[Álláshely azonosító] = lkSzemélyek.[Státusz kódja]
WHERE (((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null) AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
GROUP BY lkSzemélyek.Főosztály, IIf([Jogviszony típusa / jogviszony típus]="Munkaviszony","Munkaviszony",[Besorolási  fokozat (KT)]);

#/#/#/
lkBesorolásonkénti_létszám_és_illetmény_átlaggal
#/#/
SELECT Nz([rang],0)*1 AS Rang_, lkBesorolásonkénti_létszám_és_illetmény.Besorolás, lkBesorolásonkénti_létszám_és_illetmény.Összilletmény, lkBesorolásonkénti_létszám_és_illetmény.Fő, lkBesorolásonkénti_létszám_és_illetmény.Átlag, lkBesorolásonkénti_létszám_és_illetmény.[Átlagtól való eltérés (StDev)]
FROM lkBesorolásonkénti_létszám_és_illetmény LEFT JOIN tBesorolásKonverzió ON lkBesorolásonkénti_létszám_és_illetmény.Besorolás = tBesorolásKonverzió.Személytörzsből
GROUP BY Nz([rang],0)*1, lkBesorolásonkénti_létszám_és_illetmény.Besorolás, lkBesorolásonkénti_létszám_és_illetmény.Összilletmény, lkBesorolásonkénti_létszám_és_illetmény.Fő, lkBesorolásonkénti_létszám_és_illetmény.Átlag, lkBesorolásonkénti_létszám_és_illetmény.[Átlagtól való eltérés (StDev)];

#/#/#/
lkBesorolásonkénti_létszám_és_illetmény_Eredmény
#/#/
SELECT Végösszeggel.Rang_ AS Sorszám, Végösszeggel.Besorolás AS Besorolás, Végösszeggel.Összilletmény AS Összilletmény, Végösszeggel.Fő AS Fő, Végösszeggel.Átlag AS Átlag, Végösszeggel.[Átlagtól való eltérés (StDev)] AS [Átlagtól való eltérés (StDev)]
FROM (SELECT lkBesorolásonkénti_létszám_és_illetmény_átlaggal.*
FROM lkBesorolásonkénti_létszám_és_illetmény_átlaggal
UNION
SELECT lkBesorolásonkénti_létszám_és_illetmény_Mindösszesen.*
FROM lkBesorolásonkénti_létszám_és_illetmény_Mindösszesen
)  AS Végösszeggel
ORDER BY Végösszeggel.Rang_;

#/#/#/
lkBesorolásonkénti_létszám_és_illetmény_Mindösszesen
#/#/
SELECT Max([Rang_])+1 AS rangsor, "Összesen: " AS Besorolás, Round(Sum(lkBesorolásonkénti_létszám_és_illetmény_átlaggal.Összilletmény)/100,0)*100 AS Mindösszesen, Sum(lkBesorolásonkénti_létszám_és_illetmény_átlaggal.Fő) AS Összlétszám, Round(Sum([Összilletmény])/Sum([Fő])/100,0)*100 AS Átlag, (SELECT Round(StDev([Illetmény összesen kerekítés nélkül (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40)/100,0)*100 AS [Átlagtól való eltérés]
FROM lkSzemélyek LEFT JOIN Álláshelyek ON lkSzemélyek.[Státusz kódja] = Álláshelyek.[Álláshely azonosító]
WHERE (((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null) AND ((lkSzemélyek.[Státusz neve])="Álláshely"))) AS [Átlagtól való eltérés]
FROM lkBesorolásonkénti_létszám_és_illetmény_átlaggal
GROUP BY "Összesen: ";

#/#/#/
lkBesorolásVáltoztatások
#/#/
SELECT tBesorolásVáltoztatások.*
FROM tBesorolásVáltoztatások
WHERE (((tBesorolásVáltoztatások.Azonosító)=(Select Top 1 Azonosító from [tBesorolásVáltoztatások] as tmp Where tmp.[ÁlláshelyAzonosító]=[tBesorolásVáltoztatások].[ÁlláshelyAzonosító] Order By  tmp.hatály Desc)));

#/#/#/
lkBesorolásVáltoztatások2
#/#/
SELECT tBesorolásVáltoztatások.Azonosító, tBesorolásVáltoztatások.Darabszám, tBesorolásVáltoztatások.ÉrintettSzerv, tBesorolásVáltoztatások.ÁlláshelyAzonosító, tBesorolásVáltoztatások.RégiBesorolás, tBesorolásVáltoztatások.ÚjBesorolás, tBesorolásVáltoztatások.Hatály
FROM (SELECT tBesorolásVáltoztatások.ÁlláshelyAzonosító, Max(tBesorolásVáltoztatások.Hatály) AS MaxOfHatály
FROM tBesorolásVáltoztatások
GROUP BY tBesorolásVáltoztatások.ÁlláshelyAzonosító
)  AS Utolsók INNER JOIN tBesorolásVáltoztatások ON (Utolsók.ÁlláshelyAzonosító = tBesorolásVáltoztatások.ÁlláshelyAzonosító) AND (Utolsók.MaxOfHatály = tBesorolásVáltoztatások.Hatály)
GROUP BY tBesorolásVáltoztatások.Azonosító, tBesorolásVáltoztatások.Darabszám, tBesorolásVáltoztatások.ÉrintettSzerv, tBesorolásVáltoztatások.ÁlláshelyAzonosító, tBesorolásVáltoztatások.RégiBesorolás, tBesorolásVáltoztatások.ÚjBesorolás, tBesorolásVáltoztatások.Hatály;

#/#/#/
lkBetöltöttLétszám
#/#/
SELECT 1 AS Sor, "Betöltött létszám:" AS Adat, Sum([fő]) AS Érték, Sum(TTnélkül) AS nemTT
FROM (SELECT DISTINCT lkSzemélyek.Adójel, 1 AS Fő, Abs([Tartós távollét típusa] Is Null) AS TTnélkül FROM lkSzemélyek WHERE lkSzemélyek.[Státusz neve] = "Álláshely")  AS lista;

#/#/#/
lkBFKHForrásKód
#/#/
SELECT DISTINCT lkSzemélyek.BFKH, lkForrásNexonSzervezetekÖsszerendelés.Főoszt, lkForrásNexonSzervezetekÖsszerendelés.Oszt, lkForrásNexonSzervezetekÖsszerendelés.ForrásKód, tSzakfeladatForráskód.SZAKFELADAT
FROM (lkForrásNexonSzervezetekÖsszerendelés INNER JOIN tSzakfeladatForráskód ON lkForrásNexonSzervezetekÖsszerendelés.ForrásKód = tSzakfeladatForráskód.SzervEgysKód) INNER JOIN lkSzemélyek ON (lkForrásNexonSzervezetekÖsszerendelés.Főoszt = lkSzemélyek.Főosztály) AND (lkForrásNexonSzervezetekÖsszerendelés.Oszt = lkSzemélyek.[Szervezeti egység neve]);

#/#/#/
lkBiztosanJogosultakUtazásiKedvezményre
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Adójel, "FőosztRöv_" & [Dolgozó teljes neve] & "_(" & [azNexon] & ")_utazási.pdf" AS Fájlnév
FROM kt_azNexon_Adójel02 INNER JOIN (lkSzemélyek INNER JOIN lkFordulónaptólEgyévigMindenJogviszonyMunkanapjai ON lkSzemélyek.Adójel = lkFordulónaptólEgyévigMindenJogviszonyMunkanapjai.Adójel) ON kt_azNexon_Adójel02.Adójel = lkFordulónaptólEgyévigMindenJogviszonyMunkanapjai.Adójel
GROUP BY lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Adójel, "FőosztRöv_" & [Dolgozó teljes neve] & "_(" & [azNexon] & ")_utazási.pdf", lkSzemélyek.BFKH
HAVING (((Sum(lkFordulónaptólEgyévigMindenJogviszonyMunkanapjai.Napok))>=365))
ORDER BY lkSzemélyek.BFKH, lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkCímek01
#/#/
SELECT strcount(Nz([Állandó lakcím],"")," ") AS Kif1, lkSzemélyek.[Státusz neve]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY strcount(Nz([Állandó lakcím],"")," ") DESC;

#/#/#/
lkDÁP
#/#/
SELECT lkSzemélyek.[Adóazonosító jel] AS Adószám, lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], lkSzemélyek.[Besorolási  fokozat (KT)] AS Besorolás, lkSzemélyek.[KIRA feladat megnevezés] AS [Ellátandó feladat], lkSzemélyek.[Illetmény összesen kerekítés nélkül (eltérített)] AS Illetmény, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, "" AS [Születési név], "" AS [Születési hely], "" AS [Születési idő], "" AS [Anyja neve], lkSzemélyek.[Állandó lakcím], lkSzemélyek.[Tartózkodási lakcím], [Hivatali email] & ", " & [Hivatali telefon] AS Elérhetőség, lkSzemélyek.[TAJ szám], "" AS Pénzintézet, ffsplit([Utalási cím],"|",3) AS Bankszámlaszám
FROM lkSzemélyek INNER JOIN tSpecifikusDolgozók ON (tSpecifikusDolgozók.[Anyja neve] = lkSzemélyek.[Anyja neve]) AND (tSpecifikusDolgozók.[Születési idő] = lkSzemélyek.[Születési idő]) AND (tSpecifikusDolgozók.[Születési hely] = lkSzemélyek.[Születési hely]) AND (lkSzemélyek.[Dolgozó születési neve] = tSpecifikusDolgozók.[Születési név]);

#/#/#/
lkDÁPb
#/#/
SELECT lkSzemélyek.[Adóazonosító jel] AS Adószám, tDÁPrésztvevők.Név, lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], lkSzemélyek.[Besorolási  fokozat (KT)] AS Besorolás, lkSzemélyek.[KIRA feladat megnevezés] AS [Ellátandó feladat], lkSzemélyek.[Illetmény összesen kerekítés nélkül (eltérített)] AS Illetmény, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó születési neve] AS [Születési név], lkSzemélyek.[Születési hely], lkSzemélyek.[Születési idő], lkSzemélyek.[Anyja neve], lkSzemélyek.[Állandó lakcím], lkSzemélyek.[Tartózkodási lakcím], [Hivatali email] & ", " & [Hivatali telefon] AS Elérhetőség, lkSzemélyek.[TAJ szám], "" AS Pénzintézet, ffsplit([Utalási cím],"|",3) AS Bankszámlaszám
FROM lkSzemélyek RIGHT JOIN tDÁPrésztvevők ON lkSzemélyek.Főosztály = tDÁPrésztvevők.Hivatal;

#/#/#/
lkDiplomások4eFtAlatt
#/#/
SELECT bfkh([Szervezeti egység kódja]) AS BFKH, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], kt_azNexon_Adójel.azNexon, lkSzemélyek.[Besorolási  fokozat (KT)], lkSzemélyek.[Kerekített 100 %-os illetmény (eltérített)] AS Illetmény, lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker] AS Óraszám, [Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40 AS 40órásIlletmény, lkSzemélyek.[KIRA feladat megnevezés], lkSzemélyek.[Iskolai végzettség foka], lkSzemélyek.[Tartós távollét típusa], lkSzemélyek.[Tartós távollét vége], lkSzemélyek.[Tartós távollét tervezett vége]
FROM kt_azNexon_Adójel RIGHT JOIN lkSzemélyek ON kt_azNexon_Adójel.Adójel = lkSzemélyek.Adójel
WHERE ((([Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40)<=400000) AND ((lkSzemélyek.[Iskolai végzettség foka])="Főiskolai vagy felsőfokú alapképzés (BA/BsC)okl." Or (lkSzemélyek.[Iskolai végzettség foka])="Egyetemi /felsőfokú (MA/MsC) vagy osztatlan képz.") AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY bfkh([Szervezeti egység kódja]), lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkDolgozók18ÉvAlattiGyermekkel
#/#/
SELECT lkHozzátartozók.[Dolgozó adóazonosító jele], 1 AS fő, Abs([Tartós távollét típusa] Is Null) AS TTnélkül
FROM lkHozzátartozók INNER JOIN lkSzemélyek ON lkHozzátartozók.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkHozzátartozók.[Születési idő])>DateSerial(Year(Now())-18,Month(Now()),Day(Now()))) AND ((lkHozzátartozók.[Kapcsolat jellege])="Gyermek" Or (lkHozzátartozók.[Kapcsolat jellege])="Nevelt (mostoha)" Or (lkHozzátartozók.[Kapcsolat jellege])="Örökbe fogadott"));

#/#/#/
lkDolgozókFeladatköreBesorolása
#/#/
SELECT lkSzemélyek.Adójel, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[KIRA feladat megnevezés], lkSzemélyek.Feladatkör, lkSzemélyek.[Elsődleges feladatkör], lkSzemélyek.FEOR, lkSzemélyek.[KIRA jogviszony jelleg], lkSzemélyek.[Besorolási  fokozat (KT)]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY lkSzemélyek.BFKH, lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkDolgozókLétszáma18ÉvAlattiGyermekkel
#/#/
SELECT 4 AS sor, "Dolgozók létszáma 18 év alatti gyermekkel:" AS Adat, Sum(fő) AS Érték, Sum([TTnélkül]) AS NemTT
FROM (SELECT DISTINCT lkHozzátartozók.[Dolgozó adóazonosító jele], 1 AS fő, Abs([Tartós távollét típusa] Is Null) AS TTnélkül FROM lkHozzátartozók INNER JOIN lkSzemélyek ON lkHozzátartozók.Adójel = lkSzemélyek.Adójel WHERE lkSzemélyek.[Státusz neve]="Álláshely" And lkHozzátartozók.[Születési idő]>DateSerial(Year(Now())-18,Month(Now()),Day(Now())) And (lkHozzátartozók.[Kapcsolat jellege]="Gyermek" Or lkHozzátartozók.[Kapcsolat jellege]="Nevelt (mostoha)" Or lkHozzátartozók.[Kapcsolat jellege]="Örökbe fogadott"))  AS allekérdezésEgyedi;

#/#/#/
lkDolgozókLétszáma18ÉvAlattiUnokával
#/#/
SELECT "Dolgozók létszáma 18 év alatti unokával:" AS Adat, Sum(fő) AS Érték, Sum([TTnélkül]) AS NemTT
FROM (SELECT DISTINCT lkHozzátartozók.[Dolgozó adóazonosító jele], 1 AS fő, Abs([Tartós távollét típusa] Is Null) AS TTnélkül FROM lkHozzátartozók INNER JOIN lkSzemélyek ON lkHozzátartozók.Adójel = lkSzemélyek.Adójel WHERE lkSzemélyek.[Státusz neve]="Álláshely" And lkHozzátartozók.[Születési idő]>DateSerial(Year(Now())-18,Month(Now()),Day(Now())) And (lkHozzátartozók.[Kapcsolat jellege]="Unoka"))  AS allekérdezésEgyedi;

#/#/#/
lkDolgozókLétszáma6ÉvAlattiGyermekkel
#/#/
SELECT "Dolgozók létszáma 6 év alatti gyermekkel:" AS Adat, Sum(fő) AS Érték, Sum([TTnélkül]) AS NemTT
FROM (SELECT DISTINCT lkHozzátartozók.[Dolgozó adóazonosító jele], 1 AS fő, Abs([Tartós távollét típusa] Is Null) AS TTnélkül FROM lkHozzátartozók INNER JOIN lkSzemélyek ON lkHozzátartozók.Adójel = lkSzemélyek.Adójel WHERE lkSzemélyek.[Státusz neve]="Álláshely" And lkHozzátartozók.[Születési idő]>DateSerial(Year(Now())-6,Month(Now()),Day(Now())) And (lkHozzátartozók.[Kapcsolat jellege]="Gyermek" Or lkHozzátartozók.[Kapcsolat jellege]="Nevelt (mostoha)" Or lkHozzátartozók.[Kapcsolat jellege]="Örökbe fogadott"))  AS allekérdezésEgyedi;

#/#/#/
lkDolgozókLétszámaTöbb18ÉvAlattiGyermekkel
#/#/
SELECT "Dolgozók létszáma több 18 év alatti gyermekkel:" AS Adat, Sum([darab]) AS Érték, Sum(IIf([NemTT]<>0,[darab],0)) AS NemTT_
FROM lkDolgozókTöbb18ÉvAlattiGyermekkel;

#/#/#/
lkDolgozókTöbb18ÉvAlattiGyermekkel
#/#/
SELECT "Dolgozók létszáma 18 év alatti gyermekkel:" AS Adat, Sum(lkDolgozók18ÉvAlattiGyermekkel.fő) AS Érték, Sum(lkDolgozók18ÉvAlattiGyermekkel.[TTnélkül]) AS NemTT, 1 AS darab
FROM lkDolgozók18ÉvAlattiGyermekkel
GROUP BY 1, lkDolgozók18ÉvAlattiGyermekkel.[Dolgozó adóazonosító jele]
HAVING (((Sum(lkDolgozók18ÉvAlattiGyermekkel.[fő]))>1));

#/#/#/
lkDolgozókVégzettségeiFelsorolás01
#/#/
SELECT lkSzemélyekVégzettségeinekSzáma.VégzettségeinekASzáma, lkVégzettségek.Adójel, lkVégzettségek.[Végzettség neve], Min(lkVégzettségek.Azonosító) AS Azonosítók
FROM lkSzemélyekVégzettségeinekSzáma INNER JOIN lkVégzettségek ON lkSzemélyekVégzettségeinekSzáma.Adójel = lkVégzettségek.Adójel
GROUP BY lkSzemélyekVégzettségeinekSzáma.VégzettségeinekASzáma, lkVégzettségek.Adójel, lkVégzettségek.[Végzettség neve];

#/#/#/
lkDolgozókVégzettségeiFelsorolás02
#/#/
SELECT 1+(Select count(Tmp.Azonosítók) From tDolgozókVégzettségeiFelsorolás01 as Tmp Where Tmp.Adójel=tDolgozókVégzettségeiFelsorolás01.Adójel AND Tmp.Azonosítók<tDolgozókVégzettségeiFelsorolás01.Azonosítók ) AS Sorszám, tDolgozókVégzettségeiFelsorolás01.VégzettségeinekASzáma, tDolgozókVégzettségeiFelsorolás01.Adójel, tDolgozókVégzettségeiFelsorolás01.[Végzettség neve]
FROM tDolgozókVégzettségeiFelsorolás01;

#/#/#/
lkDolgozókVégzettségeiFelsorolás03
#/#/
PARAMETERS Üssél_egy_entert Long;
TRANSFORM First(tDolgozókVégzettségeiFelsorolás02.[Végzettség neve]) AS [FirstOfVégzettség neve]
SELECT tDolgozókVégzettségeiFelsorolás02.Adójel, tDolgozókVégzettségeiFelsorolás02.VégzettségeinekASzáma
FROM tDolgozókVégzettségeiFelsorolás02
GROUP BY tDolgozókVégzettségeiFelsorolás02.Adójel, tDolgozókVégzettségeiFelsorolás02.VégzettségeinekASzáma
PIVOT tDolgozókVégzettségeiFelsorolás02.Sorszám In (1,2,3,4,5,6,7,8,9,10,11,12);

#/#/#/
lkDolgozókVégzettségeiFelsorolás04
#/#/
SELECT lkDolgozókVégzettségeiFelsorolás03.Adójel, lkDolgozókVégzettségeiFelsorolás03.VégzettségeinekASzáma, strim([1] & ", " & [2] & ", " & [3] & ", " & [4] & ", " & [5] & ", " & [6] & ", " & [7] & ", " & [8] & ", " & [9] & ", " & [10] & ", " & [11] & ", " & [12],", ") AS Végzettségei
FROM lkDolgozókVégzettségeiFelsorolás03;

#/#/#/
lkDolgozókVégzettségeiFelsorolásTmp
#/#/
SELECT Count(Tmp.Azonosítók) AS CountOfAzonosítók
FROM lkDolgozókVégzettségeiFelsorolás01 AS Tmp
WHERE (((Tmp.Adójel)=lkDolgozókVégzettségeiFelsorolás01.Adójel) And ((Tmp.Azonosítók)<lkDolgozókVégzettségeiFelsorolás01.Azonosítók));

#/#/#/
lkEgészségügyiAlkalmasságiVizsga
#/#/
SELECT lkSzemélyek.Főosztály AS Főosztály, lkSzemélyek.Osztály AS Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Hivatali telefon] AS [Hivatali telefon], lkSzemélyek.[Hivatali email] AS [Hivatali email], Format([TAJ szám] & ""," @") AS TAJ, lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS Belépés, kt_azNexon_Adójel02.NLink AS NLink
FROM lkSzemélyek LEFT JOIN kt_azNexon_Adójel02 ON lkSzemélyek.Adójel = kt_azNexon_Adójel02.Adójel
WHERE (((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)])>=DateSerial(Year(DateAdd("m",-3,Date())),Month(DateAdd("m",-3,Date())),1)) AND ((lkSzemélyek.[Orvosi vizsgálat következő időpontja]) Is Null) AND ((lkSzemélyek.[Orvosi vizsgálat eredménye]) Is Null) AND ((lkSzemélyek.[Státusz neve])="Álláshely")) OR (((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)])>=DateSerial(Year(DateAdd("m",-3,Date())),Month(DateAdd("m",-3,Date())),1)) AND ((lkSzemélyek.[Orvosi vizsgálat következő időpontja])<[Jogviszony kezdete (belépés dátuma)]) AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY lkSzemélyek.[Jogviszony kezdete (belépés dátuma)], lkSzemélyek.BFKH;

#/#/#/
lkEgészségügyiSzolgáltatóAdataiUnió
#/#/
SELECT tEgészségügyiSzolgáltatóAdatai02.*
FROM tEgészségügyiSzolgáltatóAdatai02
UNION SELECT tEgészségügyiSzolgáltatóAdatai01.*
FROM  tEgészségügyiSzolgáltatóAdatai01;

#/#/#/
lkEgyesMunkakörökFőosztályai
#/#/
SELECT tEgyesMunkakörökFőosztályai.Azonosító, bfkh([tEgyesMunkakörökFőosztályai].[Főosztály]) AS Főosztály, tEgyesMunkakörökFőosztályai.Osztály
FROM tEgyesMunkakörökFőosztályai;

#/#/#/
lkEgyesOsztályokTisztviselői_lkSzemélyek
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS Belépés, IIf(Nz([Tartós távollét típusa],"")="","","tartósan távollévő") AS [Tartósan távollévő]
FROM lkSzemélyek
WHERE (((lkSzemélyek.Főosztály) Like "* I. *") AND ((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Jogviszony típusa / jogviszony típus]) Like "kormány*")) OR (((lkSzemélyek.Főosztály) Like "* XII. *")) OR (((lkSzemélyek.Főosztály) Like "* XXI. *")) OR (((lkSzemélyek.Főosztály) Like "* XXIII. *")) OR (((lkSzemélyek.Főosztály) Like "* VI. *"))
ORDER BY bfkh([Szervezeti egység kódja]), lkSzemélyek.Osztály, lkSzemélyek.[Jogviszony kezdete (belépés dátuma)], lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkEgyFőosztályAktívDolgozóiEmailFeladat
#/#/
SELECT lkSzemélyek.[Szervezeti egység neve], lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Hivatali email], lkSzemélyek.[KIRA feladat megnevezés]
FROM lkSzemélyek INNER JOIN tBesorolásÁtalakítóEltérőBesoroláshoz ON lkSzemélyek.jel2 = tBesorolásÁtalakítóEltérőBesoroláshoz.jel
WHERE (((lkSzemélyek.Főosztály) Like "Lakás*") AND ((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null))
ORDER BY lkSzemélyek.BFKH, tBesorolásÁtalakítóEltérőBesoroláshoz.rang DESC , IIf(InStr([KIRA feladat megnevezés],"vezető")>0,1,2);

#/#/#/
lkEgyFőosztályIlletményei(név_bes_illetmény)
#/#/
SELECT Replace([lkSzemélyek].[Osztály],"Humánpolitikai Osztály","") AS Osztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Besorolási  fokozat (KT)], lkSzemélyek.[Illetmény összesen kerekítés nélkül (eltérített)]
FROM lkSzemélyek
WHERE (((lkSzemélyek.Főosztály) Like [Főosztály nevének részlete] & "*") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null))
ORDER BY Replace([lkSzemélyek].[Osztály],"Humánpolitikai Osztály",""), lkSzemélyek.[Besorolási  fokozat (KT)];

#/#/#/
lkÉletkorok
#/#/
SELECT Int(Sqr([Törzsszám])) AS Szám, DateDiff("yyyy",[Születési idő],Date()) AS Életkor
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz neve])="álláshely"));

#/#/#/
lkElismerésreJogosítóIdőtCsakABfkhbanSzerzettek
#/#/
SELECT lkÖsszesJogviszonyIdőtartamSzemélyek.Adójel, Date()-Dtátal([Szolgálati elismerésre jogosultság / Jubileumi jutalom kezdő dát])+1 AS ElsimerésreJogosítóIdőtartam
FROM lkSzolgálatiIdőElismerés INNER JOIN lkÖsszesJogviszonyIdőtartamSzemélyek ON lkSzolgálatiIdőElismerés.Adójel = lkÖsszesJogviszonyIdőtartamSzemélyek.Adójel
WHERE (((Date()-Dtátal([Szolgálati elismerésre jogosultság / Jubileumi jutalom kezdő dát])+1)=[ÖsszIdőtartam]));

#/#/#/
lkElkószáltÁlláshelyekÁNYR
#/#/
SELECT lkÁlláshelyekBelsőElosztásaFőosztályOsztály.Főoszt AS [Engedély szerinti főosztály], lkÁlláshelyek.Főoszt AS [ÁNYR szerinti főosztály], lkÁlláshelyekBelsőElosztásaFőosztályOsztály.[Álláshely azonosító]
FROM lkÁlláshelyek INNER JOIN lkÁlláshelyekBelsőElosztásaFőosztályOsztály ON lkÁlláshelyek.[Álláshely azonosító] = lkÁlláshelyekBelsőElosztásaFőosztályOsztály.[Álláshely azonosító]
WHERE (((lkÁlláshelyek.Főoszt)<>[lkÁlláshelyekBelsőElosztásaFőosztályOsztály].[Főoszt]));

#/#/#/
lkElkószáltÁlláshelyekNexon
#/#/
SELECT lkÁlláshelyekBelsőElosztásaFőosztályOsztály.Főoszt AS [Engedély szerinti főosztály], lkÁlláshelyekHaviból.Főoszt, lkÁlláshelyekBelsőElosztásaFőosztályOsztály.[Álláshely azonosító]
FROM lkÁlláshelyekBelsőElosztásaFőosztályOsztály INNER JOIN lkÁlláshelyekHaviból ON lkÁlláshelyekBelsőElosztásaFőosztályOsztály.[Álláshely azonosító] = lkÁlláshelyekHaviból.[Álláshely azonosító]
WHERE (((lkÁlláshelyekHaviból.Főoszt)<>[lkÁlláshelyekBelsőElosztásaFőosztályOsztály].[Főoszt]));

#/#/#/
lkEllenőrzés_03_e-mail_címek
#/#/
SELECT DISTINCT lk_Ellenőrzés_03.TO AS Kif1
FROM lk_Ellenőrzés_03;

#/#/#/
lkEllenőrzés_ProjektesekAlaplétszámon
#/#/
SELECT DISTINCT lkSzemélyek.Főosztály AS Főosztály, lkSzemélyek.Osztály AS Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Státusz költséghelyének neve] AS Költséghely, lkSzemélyek.[Státusz költséghelyének kódja] AS [Költséghely kód], kt_azNexon_Adójel02.NLink AS NLink, lkSzemélyek.[Státusz neve]
FROM kt_azNexon_Adójel02 RIGHT JOIN lkSzemélyek ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely") AND (([lkSzemélyek].[Státusz költséghelyének neve]) Is Not Null) AND ((lkSzemélyek.[Státusz típusa])="Szervezeti alaplétszám")) OR (((lkSzemélyek.[Státusz költséghelyének kódja]) Is Not Null) AND ((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Státusz típusa])="Szervezeti alaplétszám"));

#/#/#/
lkEllenőrzés_többszörösJogviszony
#/#/
SELECT "Központosítottak" AS Tábla, "Két utolsó jogviszonya van a Nexonban." AS Adathiba, lkSzemélyek.[Adóazonosító jel], lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], lkSzemélyek.bfkh AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkSzemélyek.[KIRA jogviszony jelleg]
FROM lkSzemélyek INNER JOIN (SELECT lkSzemélyek.[Adóazonosító jel], Count(lkSzemélyek.[Adóazonosító jel]) AS [CountOfAdóazonosító jel] FROM lkSzemélyek GROUP BY lkSzemélyek.[Adóazonosító jel] HAVING (((Count(lkSzemélyek.[Adóazonosító jel]))>1)))  AS Többszörösek ON lkSzemélyek.[Adóazonosító jel] = Többszörösek.[Adóazonosító jel]
WHERE (("KIRA jogviszony jelleg "="Fegyveres szervek hiv. állományú tagjainak szolgv." Or (lkSzemélyek.[KIRA jogviszony jelleg])="Kormányzati szolgálati jogviszony (KIT)" Or (lkSzemélyek.[KIRA jogviszony jelleg])="Megbízási jogviszony" Or (lkSzemélyek.[KIRA jogviszony jelleg])="Munkaviszony" Or (lkSzemélyek.[KIRA jogviszony jelleg])="Politikai jogviszony" Or (lkSzemélyek.[KIRA jogviszony jelleg])="Rendvédelmi igazgatási, szolgálati jogviszony"));

#/#/#/
lkEllenőrzés_vezetőkFeladatköreBeosztása
#/#/
SELECT lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Szervezeti egység neve], lkSzemélyek.Besorolás, lkSzemélyek.Feladatok, lkSzemélyek.Feladatkör, lkSzemélyek.[KIRA feladat megnevezés], lkSzemélyek.[Vezetői beosztás megnevezése], lkSzemélyek.[Vezetői megbízás típusa]
FROM kt_azNexon_Adójel INNER JOIN lkSzemélyek ON kt_azNexon_Adójel.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.Besorolás) Like "járási*" Or (lkSzemélyek.Besorolás) Like "*igazgató*" Or (lkSzemélyek.Besorolás) Like "*osztály*") AND ((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null))
ORDER BY lkSzemélyek.[Szervezeti egység kódja], lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkEllenőrző_Lekérdezések__NEM_üres
#/#/
SELECT tJavítandóMezőnevek.azJavítandó, "SELECT '"          & [Ellenőrzéshez] & "' AS Tábla, '"          & [Eredeti] & "' AS Hiányzó_érték, "          & [Ellenőrzéshez] & ".[Adóazonosító], "          & [Ellenőrzéshez] & ".[Álláshely azonosító], "          & [Ellenőrzéshez] & ".[" & [SzervezetKód_mező] & "] " AS [Select], "FROM [" & [Ellenőrzéshez] & "] " AS [From], "WHERE ([" & [Ellenőrzéshez] & "].[" & [Import] & "] Is Null " & IIf([Szöveg],"OR [" & [Ellenőrzéshez] & "].[" & [Import] & "]='') ",") ") & IIf(IsNull([ÜresÁlláshelyMezők]),""," AND ([" & [Ellenőrzéshez] & "].[" & [ÜresÁlláshelyMezők] & "]<> 'üres állás' OR [" & [Ellenőrzéshez] & "].[" & [ÜresÁlláshelyMezők] & "] is null ) ") AS [Where], tJavítandóMezőnevek.NemKötelező, tJavítandóMezőnevek.NemKötelezőÜresÁlláshelyEsetén, [Select] & [From] & [Where] AS [SQL], Len([SQL]) AS Hossz, tJavítandóMezőnevek.Ellenőrzéshez
FROM tJavítandóMezőnevek
WHERE (((tJavítandóMezőnevek.NemKötelező)=False) AND ((tJavítandóMezőnevek.Ellenőrzéshez) Is Not Null))
ORDER BY tJavítandóMezőnevek.azJavítandó;

#/#/#/
lkEllenőrző_Lekérdezések__ÜRES
#/#/
SELECT "SELECT '" & [Tábla] & "' AS Tábla, '" & [Import] & "' AS Hiányzó_érték, " & [Tábla] & ".[Adóazonosító], " & [Tábla] & ".[Álláshely azonosító], " & [Tábla] & ".[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] " AS [Select], "FROM [" & [Tábla] & "] " AS [From], "WHERE ([" & [Tábla] & "].[" & [Import] & "] Is Null OR [" & [Tábla] & "].[" & [Import] & "] = '')" & IIf(IsNull([ÜresÁlláshelyMezők]),""," AND [" & [Tábla] & "].[" & [ÜresÁlláshelyMezők] & "] = 'üres állás' ") AS [Where], tJavítandóMezőnevek.azJavítandó, tJavítandóMezőnevek.NemKötelező, tJavítandóMezőnevek.NemKötelezőÜresÁlláshelyEsetén, [Select] & [From] & [Where] AS [SQL], Len([SQL]) AS Hossz
FROM tJavítandóMezőnevek
WHERE (((tJavítandóMezőnevek.NemKötelező)=True) AND ((tJavítandóMezőnevek.NemKötelezőÜresÁlláshelyEsetén)=False));

#/#/#/
lkEllenőrző_Lekérdezések_ÜRES_union
#/#/
SELECT 'Kilépők' AS Tábla, 'Besorolási fokozat megnevezése:' AS Hiányzó_érték, Kilépők.[Adóazonosító], Kilépők.[Álláshely azonosító], Kilépők.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Kilépők] WHERE ([Kilépők].[Besorolási fokozat megnevezése:] Is Null OR [Kilépők].[Besorolási fokozat megnevezése:] = '')
UNION
SELECT 'Határozottak' AS Tábla, 'Megyei szint VAGY Járási Hivatal' AS Hiányzó_érték, Határozottak.[Adóazonosító], Határozottak.[Álláshely azonosító], Határozottak.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Határozottak] WHERE ([Határozottak].[Megyei szint VAGY Járási Hivatal] Is Null OR [Határozottak].[Megyei szint VAGY Járási Hivatal] = '')
UNION
SELECT 'Határozottak' AS Tábla, 'Mező5' AS Hiányzó_érték, Határozottak.[Adóazonosító], Határozottak.[Álláshely azonosító], Határozottak.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Határozottak] WHERE ([Határozottak].[Mező5] Is Null OR [Határozottak].[Mező5] = '')
UNION
SELECT 'Határozottak' AS Tábla, 'Mező6' AS Hiányzó_érték, Határozottak.[Adóazonosító], Határozottak.[Álláshely azonosító], Határozottak.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Határozottak] WHERE ([Határozottak].[Mező6] Is Null OR [Határozottak].[Mező6] = '')
UNION
SELECT 'Határozottak' AS Tábla, 'ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ' AS Hiányzó_érték, Határozottak.[Adóazonosító], Határozottak.[Álláshely azonosító], Határozottak.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Határozottak] WHERE ([Határozottak].[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] Is Null OR [Határozottak].[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] = '')
UNION
SELECT 'Határozottak' AS Tábla, 'Besorolási fokozat megnevezése:' AS Hiányzó_érték, Határozottak.[Adóazonosító], Határozottak.[Álláshely azonosító], Határozottak.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Határozottak] WHERE ([Határozottak].[Besorolási fokozat megnevezése:] Is Null OR [Határozottak].[Besorolási fokozat megnevezése:] = '')
UNION SELECT 'Határozottak' AS Tábla, 'Mező24' AS Hiányzó_érték, Határozottak.[Adóazonosító], Határozottak.[Álláshely azonosító], Határozottak.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] FROM [Határozottak] WHERE ([Határozottak].[Mező24] Is Null OR [Határozottak].[Mező24] = '');

#/#/#/
lkEllenőrzőLekérdezések
#/#/
SELECT *
FROM lkEllenőrzőLekérdezések2
WHERE (((lkEllenőrzőLekérdezések2.[Osztály])=[qWhere]))
ORDER BY lkEllenőrzőLekérdezések2.[LapNév], lkEllenőrzőLekérdezések2.[TáblaCím];

#/#/#/
lkEllenőrzőLekérdezések2
#/#/
SELECT [Lekérdezések(tEllenőrzőLekérdezések)].azEllenőrző, [Lekérdezések(tEllenőrzőLekérdezések)].EllenőrzőLekérdezés, [Lekérdezések(tEllenőrzőLekérdezések)].Táblacím, IIf([graftulajdonság]="Type",[graftulérték],"") AS VaneGraf, [Lekérdezések(tEllenőrzőLekérdezések)].Kimenet, [Lekérdezések(tEllenőrzőLekérdezések)].KellVisszajelzes, [Lekérdezések(tEllenőrzőLekérdezések)].azUnion, [Lekérdezések(tEllenőrzőLekérdezések)].TáblaMegjegyzés, [Fejezetek(tLekérdezésTípusok)].azETípus, [Fejezetek(tLekérdezésTípusok)].TípusNeve, [Fejezetek(tLekérdezésTípusok)].LapNév, [Fejezetek(tLekérdezésTípusok)].Megjegyzés, [Fejezetek(tLekérdezésTípusok)].Osztály, [Fejezetek(tLekérdezésTípusok)].vbaPostProcessing, [Lekérdezések(tEllenőrzőLekérdezések)].Sorrend, [Fejezetek(tLekérdezésTípusok)].Sorrend, [Lekérdezések(tEllenőrzőLekérdezések)].Sorrend
FROM tLekérdezésOsztályok AS [Oldalak(tLekérdezésOsztályok)] INNER JOIN ((tLekérdezésTípusok AS [Fejezetek(tLekérdezésTípusok)] INNER JOIN tEllenőrzőLekérdezések AS [Lekérdezések(tEllenőrzőLekérdezések)] ON [Fejezetek(tLekérdezésTípusok)].azETípus = [Lekérdezések(tEllenőrzőLekérdezések)].azETípus) LEFT JOIN tGrafikonok ON [Lekérdezések(tEllenőrzőLekérdezések)].azEllenőrző = tGrafikonok.azEllenőrző) ON [Oldalak(tLekérdezésOsztályok)].azOsztály = [Fejezetek(tLekérdezésTípusok)].Osztály
ORDER BY [Lekérdezések(tEllenőrzőLekérdezések)].Sorrend, [Fejezetek(tLekérdezésTípusok)].Sorrend, [Lekérdezések(tEllenőrzőLekérdezések)].Sorrend;

#/#/#/
lkEllenőrzőLekérdezések2csakLekérdezések
#/#/
SELECT DISTINCT lkEllenőrzőLekérdezések2.EllenőrzőLekérdezés
FROM lkEllenőrzőLekérdezések2
ORDER BY lkEllenőrzőLekérdezések2.EllenőrzőLekérdezés;

#/#/#/
lkEllenőrzőLekérdezések2Mezőnevekkel
#/#/
SELECT DISTINCT mSyslkMezőnevek.Alias, tEllenőrzőLekérdezések.EllenőrzőLekérdezés, tLekérdezésMezőTípusok.MezőNeve
FROM (tEllenőrzőLekérdezések INNER JOIN mSyslkMezőnevek ON tEllenőrzőLekérdezések.EllenőrzőLekérdezés = mSyslkMezőnevek.QueryName) LEFT JOIN tLekérdezésMezőTípusok ON (mSyslkMezőnevek.QueryName = tLekérdezésMezőTípusok.LekérdezésNeve) AND (mSyslkMezőnevek.Alias = tLekérdezésMezőTípusok.MezőNeve)
WHERE (((tEllenőrzőLekérdezések.EllenőrzőLekérdezés)=[Űrlapok]![űEllenőrzőLekérdezések2]![A lekérdezés mezők típusai:]![LekérdezésNeve]) AND ((tLekérdezésMezőTípusok.mezoAz) Is Null) AND ((tEllenőrzőLekérdezések.Kimenet)=True))
ORDER BY tEllenőrzőLekérdezések.EllenőrzőLekérdezés, mSyslkMezőnevek.Alias;

#/#/#/
lkEllenőrzőLekérdezések2űrlaphoz
#/#/
SELECT tLekérdezésOsztályok.Sorrend AS [Oldalak sorrendje], tLekérdezésTípusok.Sorrend AS [Fejezetek sorrendje], tEllenőrzőLekérdezések.Sorrend AS [Lekérdezések sorrendje], tEllenőrzőLekérdezések.azEllenőrző, tEllenőrzőLekérdezések.EllenőrzőLekérdezés, tEllenőrzőLekérdezések.Táblacím, tEllenőrzőLekérdezések.Kimenet, tEllenőrzőLekérdezések.KellVisszajelzes, tEllenőrzőLekérdezések.azUnion, tEllenőrzőLekérdezések.TáblaMegjegyzés, tEllenőrzőLekérdezések.azETípus, tEllenőrzőLekérdezések.ElőzményUnió
FROM tLekérdezésOsztályok INNER JOIN (tLekérdezésTípusok INNER JOIN tEllenőrzőLekérdezések ON tLekérdezésTípusok.azETípus = tEllenőrzőLekérdezések.azETípus) ON tLekérdezésOsztályok.azOsztály = tLekérdezésTípusok.Osztály
WHERE (((tEllenőrzőLekérdezések.Táblacím) Like "*" & [Űrlapok]![űEllenőrzőLekérdezések2]![Keresés] & "*")) OR (((tEllenőrzőLekérdezések.EllenőrzőLekérdezés) Like "*" & [Űrlapok]![űEllenőrzőLekérdezések2]![Keresés] & "*")) OR (((tEllenőrzőLekérdezések.TáblaMegjegyzés) Like "*" & [Űrlapok]![űEllenőrzőLekérdezések2]![Keresés] & "*"))
ORDER BY tLekérdezésOsztályok.Sorrend, tLekérdezésTípusok.Sorrend, tEllenőrzőLekérdezések.Sorrend, tEllenőrzőLekérdezések.Táblacím;

#/#/#/
lkEllenőrzőLekérdezések3
#/#/
SELECT tLekérdezésTípusok.Sorrend AS Fejezetsorrend, tEllenőrzőLekérdezések.Sorrend AS Leksorrend, tEllenőrzőLekérdezések.EllenőrzőLekérdezés, tLekérdezésTípusok.LapNév, tLekérdezésTípusok.Osztály, tLekérdezésTípusok.Megjegyzés, tEllenőrzőLekérdezések.Táblacím, Nz([graftulérték],"") AS vaneGraf, tLekérdezésTípusok.azETípus, tEllenőrzőLekérdezések.Kimenet, tEllenőrzőLekérdezések.KellVisszajelzes, tEllenőrzőLekérdezések.azUnion, tEllenőrzőLekérdezések.TáblaMegjegyzés, tEllenőrzőLekérdezések.azHibaCsoport
FROM (tLekérdezésTípusok INNER JOIN tEllenőrzőLekérdezések ON tLekérdezésTípusok.azETípus = tEllenőrzőLekérdezések.azETípus) LEFT JOIN tGrafikonok ON tEllenőrzőLekérdezések.azEllenőrző = tGrafikonok.azEllenőrző
WHERE (((tGrafikonok.grafTulajdonság)="Type" Or (tGrafikonok.grafTulajdonság) Is Null))
ORDER BY tLekérdezésTípusok.Osztály, tLekérdezésTípusok.LapNév, tEllenőrzőLekérdezések.Táblacím, tLekérdezésTípusok.azETípus;

#/#/#/
lkEllenőrzőLekérdezésekHiányosMezőtípussal
#/#/
SELECT lkLekérdezésekMezőinekSzáma.EllenőrzőLekérdezés, lkLekérdezésekMezőinekSzáma.CountOfAttribute, lkEllenőrzőLekérdezésekTípusolMezőinekSzáma.CountOfMezőNeve, lkEllenőrzőLekérdezésekTípusolMezőinekSzáma.EllenőrzőLekérdezés
FROM lkLekérdezésekMezőinekSzáma RIGHT JOIN lkEllenőrzőLekérdezésekTípusolMezőinekSzáma ON lkLekérdezésekMezőinekSzáma.EllenőrzőLekérdezés = lkEllenőrzőLekérdezésekTípusolMezőinekSzáma.EllenőrzőLekérdezés
WHERE (((lkEllenőrzőLekérdezésekTípusolMezőinekSzáma.CountOfMezőNeve)<[CountOfAttribute]));

#/#/#/
lkEllenőrzőLekérdezésekMezőneveiAliassal
#/#/
SELECT DISTINCT tEllenőrzőLekérdezések.EllenőrzőLekérdezés, mSyslkMezőnevek.MezőNév, Replace(Replace(ffsplit([mSyslkMezőnevek].[MezőNév],".",2),"[",""),"]","") AS [Javasolt alias]
FROM mSyslkMezőnevek AS mSyslkMezőnevek_1, mSyslkMezőnevek INNER JOIN tEllenőrzőLekérdezések ON mSyslkMezőnevek.QueryName = tEllenőrzőLekérdezések.EllenőrzőLekérdezés
WHERE (((mSyslkMezőnevek.MezőNév) Like "*" & [mSyslkMezőnevek_1].[QueryName] & "*"));

#/#/#/
lkEllenőrzőLekérdezésekSegédűrlaphoz
#/#/
SELECT tEllenőrzőLekérdezések.azETípus, tEllenőrzőLekérdezések.azEllenőrző, tEllenőrzőLekérdezések.Táblacím, tEllenőrzőLekérdezések.Sorrend
FROM tEllenőrzőLekérdezések;

#/#/#/
lkEllenőrzőLekérdezésekTípusolMezőinekSzáma
#/#/
SELECT lkEllenőrzőLekérdezések2.EllenőrzőLekérdezés, Count(tLekérdezésMezőTípusok.MezőNeve) AS CountOfMezőNeve
FROM lkEllenőrzőLekérdezések2 LEFT JOIN tLekérdezésMezőTípusok ON lkEllenőrzőLekérdezések2.EllenőrzőLekérdezés = tLekérdezésMezőTípusok.LekérdezésNeve
WHERE (((lkEllenőrzőLekérdezések2.Kimenet)=True))
GROUP BY lkEllenőrzőLekérdezések2.EllenőrzőLekérdezés;

#/#/#/
lkEllenőrzőLekérdezésVanegraf
#/#/
SELECT tEllenőrzőLekérdezések.EllenőrzőLekérdezés, IIf([tGrafikonok].[azEllenőrző] Is Null,0,-1) AS VaneGraf
FROM tEllenőrzőLekérdezések LEFT JOIN tGrafikonok ON tEllenőrzőLekérdezések.azEllenőrző = tGrafikonok.azEllenőrző;

#/#/#/
lkElsőOsztályvezetővéSorolásDátuma
#/#/
SELECT [Adóazonosító jel]*1 AS Adójel, Min(tBesorolásiEredményadatok.[Változás dátuma]) AS [MinOfVáltozás dátuma]
FROM tBesorolásiEredményadatok
WHERE (((tBesorolásiEredményadatok.[Besorolási fokozat12])="Osztályvezető"))
GROUP BY [Adóazonosító jel]*1;

#/#/#/
lkEltérésBankszámlaszámPGFNexon
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], ffsplit([Utalási cím],"|",3) AS Bankszámlaszám, PGF_2025_02.Folyószámlaszám
FROM lkSzemélyek INNER JOIN PGF_2025_02 ON lkSzemélyek.Adójel = PGF_2025_02.[Adóazonosító jel]
WHERE (((Replace(Nz(ffsplit([Utalási cím],"|",3),""),"-00000000",""))<>Replace(Nz([Folyószámlaszám],""),"-00000000","")))
ORDER BY lkSzemélyek.BFKH;

#/#/#/
lkEltérőBesorolásokLechnernek
#/#/
SELECT lkSzemélyek.Adójel, "" AS [HR kapcsolat azonosító], #1/1/2024# AS [Érvényesség kezdete], tBesorolásiKódok.Kód, tBesorolásÁtalakítóEltérőBesoroláshoz.[Besorolási  fokozat (KT)] AS ÁNYR, lkSzemélyek.[Besorolási  fokozat (KT)] AS [Nexon személytörzs], lkBesorolásVáltoztatások.RégiBesorolás, lkBesorolásVáltoztatások.ÚjBesorolás, lkÁlláshelyek.[Álláshely azonosító]
FROM lkBesorolásVáltoztatások RIGHT JOIN (tBesorolásiKódok INNER JOIN (lkSzemélyek INNER JOIN (lkÁlláshelyek INNER JOIN tBesorolásÁtalakítóEltérőBesoroláshoz ON lkÁlláshelyek.[Álláshely besorolási kategóriája] = tBesorolásÁtalakítóEltérőBesoroláshoz.[Álláshely besorolási kategóriája]) ON lkSzemélyek.[Státusz kódja] = lkÁlláshelyek.[Álláshely azonosító]) ON tBesorolásiKódok.Besorolás = tBesorolásÁtalakítóEltérőBesoroláshoz.[Besorolási  fokozat (KT)]) ON lkBesorolásVáltoztatások.ÁlláshelyAzonosító = lkÁlláshelyek.[Álláshely azonosító]
WHERE (((tBesorolásÁtalakítóEltérőBesoroláshoz.[Besorolási  fokozat (KT)])<>[lkSzemélyek].[Besorolási  fokozat (KT)]) AND ((lkBesorolásVáltoztatások.RégiBesorolás) Is Not Null));

#/#/#/
lkEltérőBesorolásokÚj01
#/#/
SELECT DISTINCT lkSzemélyek.Adójel, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzervezetiÁlláshelyek.[Tervezett betöltési adatok - Előmeneteli fokozat megnevezés] AS [Szervezeti struktúra], lkBesorolásVáltoztatások.ÚjBesorolás, lkSzemélyek.Besorolás AS [Személyi karton], lkSzemélyek.[Jogviszony típusa / jogviszony típus], lkSzemélyek.[Tartós távollét típusa], lkSzervezetiÁlláshelyek.ÁlláshelyAzonosító AS [Álláshely azonosító], kt_azNexon_Adójel02.NLink, bfkh([SzervezetKód]) AS BFKH, IIf([Besorolás]<>[ÚjBesorolás],"Az eltérés oka: az új besoroltatás még nincs rögzítve a Nexon-ban.","") AS Megjegyzés
FROM lkBesorolásVáltoztatások RIGHT JOIN (kt_azNexon_Adójel02 RIGHT JOIN (lkSzervezetiÁlláshelyek LEFT JOIN lkSzemélyek ON lkSzervezetiÁlláshelyek.ÁlláshelyAzonosító = lkSzemélyek.[Státusz kódja]) ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel) ON lkBesorolásVáltoztatások.ÁlláshelyAzonosító = lkSzervezetiÁlláshelyek.ÁlláshelyAzonosító
WHERE (((lkSzervezetiÁlláshelyek.[Tervezett betöltési adatok - Előmeneteli fokozat megnevezés])<>[Besorolás]) AND ((lkSzemélyek.[Jogviszony típusa / jogviszony típus])<>"Munkaviszony"));

#/#/#/
lkEltérőBesorolásokÚj02
#/#/
SELECT lkEltérőBesorolásokÚj01.Főosztály AS Főosztály, lkEltérőBesorolásokÚj01.Osztály AS Osztály, lkEltérőBesorolásokÚj01.Név AS Név, lkEltérőBesorolásokÚj01.[Álláshely azonosító] AS [Státusz kód], lkEltérőBesorolásokÚj01.[Szervezeti struktúra] AS [Szervezeti struktúrában], lkEltérőBesorolásokÚj01.[Személyi karton] AS [Személyi kartonon], lkEltérőBesorolásokÚj01.[Jogviszony típusa / jogviszony típus] AS [Jogviszony típusa], lkEltérőBesorolásokÚj01.[Tartós távollét típusa] AS [Tartós távollét típusa], lkEltérőBesorolásokÚj01.NLink AS NLink, lkEltérőBesorolásokÚj01.Megjegyzés AS Megjegyzés
FROM lkEltérőBesorolásokÚj01
ORDER BY lkEltérőBesorolásokÚj01.BFKH;

#/#/#/
lkEltérőIlletményekHaviSzemély
#/#/
SELECT lkSzemélyek.Adójel, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkIlletményekHavi.Illetmény, lkSzemélyek.[Alapilletmény / Munkabér / Megbízási díj (eltérítés nélküli)], lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker], lkSzemélyek.[Garantált bérminimumra történő kiegészítés], lkSzemélyek.[Egyéb pótlék - összeg (eltérítés nélküli)], lkSzemélyek.Kerekítés, lkSzemélyek.[Illetmény összesen kerekítés nélkül (eltérítés nélküli)], lkSzemélyek.[Kerekített 100 %-os illetmény (eltérítés nélküli)], lkSzemélyek.[Eltérítés %]
FROM lkIlletményekHavi RIGHT JOIN lkSzemélyek ON lkIlletményekHavi.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Kerekített 100 %-os illetmény (eltérítés nélküli)])<>[lkIlletményekHavi].[Illetmény]));

#/#/#/
lkEltérőKöltséghelyek
#/#/
SELECT DISTINCT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Dolgozó költséghelyének kódja], lkSzemélyek.[Dolgozó költséghelyének neve], lkSzemélyek.[Státusz költséghelyének kódja], lkSzemélyek.[Státusz költséghelyének neve]
FROM lkSzemélyek;

#/#/#/
lkEltérőSzervezetnevek2
#/#/
SELECT lkÁlláshelyek.[Álláshely azonosító], lkÁlláshelyek.FőosztályÁlláshely AS [Főosztály (ÁNYR)], Nz([5 szint]) AS [Osztály (ÁNYR)], lkSzervezetiÁlláshelyek.[Szervezeti egységének megnevezése], lkSzervezetiÁlláshelyek.Főosztály AS [Főosztály (Szervezeti)], lkSzervezetiÁlláshelyek.Osztály AS [Osztály (Szervezeti)]
FROM lkSzervezetiÁlláshelyek INNER JOIN lkÁlláshelyek ON lkSzervezetiÁlláshelyek.ÁlláshelyAzonosító = lkÁlláshelyek.[Álláshely azonosító]
WHERE (((lkSzervezetiÁlláshelyek.Osztály)<>[lkÁlláshelyek].[Oszt])) OR (((lkSzervezetiÁlláshelyek.Főosztály)<>[lkÁlláshelyek].[FőosztályÁlláshely]));

#/#/#/
lkELvégzendőBesoroltatások00
#/#/
SELECT DISTINCT lkBesorolásiEredményadatok.Adójel, lkBesorolásiEredményadatok.kezdete10 AS BesorolásiFokozatKezdete, lkBesorolásiEredményadatok.vége11 AS BesorolásiFokozatVége, lkBesorolásiEredményadatok.[Utolsó besorolás dátuma], lkBesorolásiEredményadatok.Vége AS JogviszonVége
FROM lkBesorolásiEredményadatok
WHERE (((lkBesorolásiEredményadatok.[Utolsó besorolás dátuma]) Is Not Null) AND ((lkBesorolásiEredményadatok.Vége) Is Null Or (lkBesorolásiEredményadatok.Vége)>Date()) AND ((lkBesorolásiEredményadatok.vége11) Is Null Or (lkBesorolásiEredményadatok.vége11)>Date()));

#/#/#/
lkElvégzendőBesoroltatások01
#/#/
SELECT DISTINCT lkSzemélyek.BFKH, lkELvégzendőBesoroltatások00.Adójel, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Jogviszony kezdete (belépés dátuma)], lkSzemélyek.[Jogviszony vége (kilépés dátuma)], lkELvégzendőBesoroltatások00.[Utolsó besorolás dátuma]
FROM lkELvégzendőBesoroltatások00 INNER JOIN lkSzemélyek ON lkELvégzendőBesoroltatások00.Adójel = lkSzemélyek.Adójel
WHERE (((lkELvégzendőBesoroltatások00.[Utolsó besorolás dátuma])<(select dtÁtal(Min([tAlapadatok].[TulajdonságÉrték])) from [tAlapadatok] where [tAlapadatok].[TulajdonságNeve]="besoroltatásDátuma")) AND ((lkSzemélyek.[Jogviszony típusa / jogviszony típus])="Kormányzati szolgálati jogviszony") AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY lkSzemélyek.BFKH;

#/#/#/
lkElvégzendőBesoroltatások02
#/#/
SELECT lkElvégzendőBesoroltatások01.Főosztály AS Főosztály, lkElvégzendőBesoroltatások01.Osztály AS Osztály, lkElvégzendőBesoroltatások01.Név AS Név, lkElvégzendőBesoroltatások01.[Utolsó besorolás dátuma] AS [Utolsó besorolás dátuma], kt_azNexon_Adójel02.NLink AS NLink
FROM kt_azNexon_Adójel02 RIGHT JOIN lkElvégzendőBesoroltatások01 ON kt_azNexon_Adójel02.Adójel = lkElvégzendőBesoroltatások01.Adójel
ORDER BY lkElvégzendőBesoroltatások01.Főosztály, lkElvégzendőBesoroltatások01.Osztály, lkElvégzendőBesoroltatások01.Név;

#/#/#/
lkElvégzendőBesoroltatások02_régi
#/#/
SELECT lkElvégzendőBesoroltatások01.BFKH, lkElvégzendőBesoroltatások01.Adójel, lkElvégzendőBesoroltatások01.Főosztály AS Főosztály, lkElvégzendőBesoroltatások01.Osztály AS Osztály, lkElvégzendőBesoroltatások01.Név AS Név, lkElvégzendőBesoroltatások01.[Utolsó besorolás dátuma] AS [Utolsó besorolás dátuma], kt_azNexon_Adójel.NLink AS NLink
FROM lkElvégzendőBesoroltatások01 LEFT JOIN kt_azNexon_Adójel ON lkElvégzendőBesoroltatások01.Adójel = kt_azNexon_Adójel.Adójel
ORDER BY lkElvégzendőBesoroltatások01.Főosztály, lkElvégzendőBesoroltatások01.Osztály, lkElvégzendőBesoroltatások01.Név;

#/#/#/
lkEngedélyezettBesorolásHavihoz
#/#/
SELECT tBesorolásÁtalakítóEltérőBesoroláshoz.jel, IIf([Álláshely típusa] Like "A*","A","K") AS Típus, tBesorolásÁtalakítóEltérőBesoroláshoz.rang, lkÁlláshelyek.[Álláshely besorolási kategóriája], Count(lkÁlláshelyek.[Álláshely azonosító]) AS [CountOfÁlláshely azonosító]
FROM tBesorolásÁtalakítóEltérőBesoroláshoz INNER JOIN lkÁlláshelyek ON tBesorolásÁtalakítóEltérőBesoroláshoz.[Álláshely besorolási kategóriája] = lkÁlláshelyek.[Álláshely besorolási kategóriája]
GROUP BY tBesorolásÁtalakítóEltérőBesoroláshoz.jel, IIf([Álláshely típusa] Like "A*","A","K"), tBesorolásÁtalakítóEltérőBesoroláshoz.rang, lkÁlláshelyek.[Álláshely besorolási kategóriája]
ORDER BY IIf([Álláshely típusa] Like "A*","A","K"), tBesorolásÁtalakítóEltérőBesoroláshoz.rang;

#/#/#/
lkEngedélyezettBesorolásHavihoz1
#/#/
SELECT tBesorolásÁtalakítóEltérőBesoroláshoz.jel, IIf([Álláshely típusa] Like "A*","A","K") AS Típus, tBesorolásÁtalakítóEltérőBesoroláshoz.rang, lkÁlláshelyek.[Álláshely besorolási kategóriája], Count(lkÁlláshelyek.[Álláshely azonosító]) AS [CountOfÁlláshely azonosító]
FROM tBesorolásÁtalakítóEltérőBesoroláshoz INNER JOIN lkÁlláshelyek ON tBesorolásÁtalakítóEltérőBesoroláshoz.[Álláshely besorolási kategóriája] = lkÁlláshelyek.[Álláshely besorolási kategóriája]
GROUP BY tBesorolásÁtalakítóEltérőBesoroláshoz.jel, IIf([Álláshely típusa] Like "A*","A","K"), tBesorolásÁtalakítóEltérőBesoroláshoz.rang, lkÁlláshelyek.[Álláshely besorolási kategóriája]
ORDER BY IIf([Álláshely típusa] Like "A*","A","K"), tBesorolásÁtalakítóEltérőBesoroláshoz.rang;

#/#/#/
lkEngedélyezettésLétszámKimenet
#/#/
SELECT IIf([Főosztály]="Kormánymegbízott","Főispán",[Főosztály]) AS Főoszt, IIf(([Főosztály] Like "*Főosztály" And ([Osztály]="" Or [Osztály]="Főosztályvezető")) Or ([Főosztály] Like "BFKH*" And ([Osztály]="" Or [Osztály]="Hivatalvezetés")),[Főosztály],IIf([Osztály]="Kormánymegbízott","Főispán",[Osztály])) AS Oszt1, Sum(TT21_22_23ésLétszám21_22.L2021) AS L2021, Sum(TT21_22_23ésLétszám21_22.L2022) AS L2022, Sum(TT21_22_23ésLétszám21_22.L2023) AS L2023, Sum(TT21_22_23ésLétszám21_22.TT2021) AS TT2021, Sum(TT21_22_23ésLétszám21_22.TT2022) AS TT2022, Sum(TT21_22_23ésLétszám21_22.TT2023) AS TT2023
FROM (SELECT lkTT21_22_23.Főosztály, lkTT21_22_23.Osztály, 0 AS L2021, 0 AS L2022, SumOfLétszám2023 as L2023, lkTT21_22_23.SumOfTTLétszám2021 AS TT2021, lkTT21_22_23.SumOfTTLétszám2022 AS TT2022, lkTT21_22_23.SumOfTTLétszám2023 AS TT2023
FROM lkTT21_22_23
UNION
SELECT lkEngedélyezettLétszámok.[Főosztály], lkEngedélyezettLétszámok.Osztály, lkEngedélyezettLétszámok.SumOf2021 AS L2021, lkEngedélyezettLétszámok.SumOf2022 AS L2022, 0 AS L2023, 0 AS TT2021, 0 AS TT2022, 0 AS TT2023
FROM  lkEngedélyezettLétszámok)  AS TT21_22_23ésLétszám21_22
GROUP BY IIf([Főosztály]="Kormánymegbízott","Főispán",[Főosztály]), IIf(([Főosztály] Like "*Főosztály" And ([Osztály]="" Or [Osztály]="Főosztályvezető")) Or ([Főosztály] Like "BFKH*" And ([Osztály]="" Or [Osztály]="Hivatalvezetés")),[Főosztály],IIf([Osztály]="Kormánymegbízott","Főispán",[Osztály]));

#/#/#/
lkEngedélyezettésLétszámKimenet02
#/#/
SELECT [Főoszt] AS Főosztály, IIf([Oszt1]="",[Főoszt],[Oszt1]) AS Oszt, Sum(lkEngedélyezettésLétszámKimenet.L2021) AS L2021, Sum(lkEngedélyezettésLétszámKimenet.L2022) AS L2022, Sum(lkEngedélyezettésLétszámKimenet.L2023) AS L2023, Sum(lkEngedélyezettésLétszámKimenet.TT2021) AS TT2021, Sum(lkEngedélyezettésLétszámKimenet.TT2022) AS TT2022, Sum(lkEngedélyezettésLétszámKimenet.TT2023) AS TT2023
FROM lkEngedélyezettésLétszámKimenet
GROUP BY [Főoszt], IIf([Oszt1]="",[Főoszt],[Oszt1]);

#/#/#/
lkEngedélyezettLétszámok
#/#/
SELECT Replace(Replace([Főosztály/Vezető],"Budapest Főváros Kormányhivatala","BFKH"),"  "," ") AS Főosztály, Unió2122.Osztály, Sum(Unió2122.[2021]) AS SumOf2021, Sum(Unió2122.[2022]) AS SumOf2022, Sum(Unió2122.[2023]) AS SumOf2023
FROM (SELECT tEngedélyezettLétszámok.[Főosztály/Vezető], tEngedélyezettLétszámok.Osztály, tEngedélyezettLétszámok.Létszám AS 2021, 0 AS 2022, 0 AS 2023
FROM tEngedélyezettLétszámok
WHERE (((tEngedélyezettLétszámok.Hatály)=#1/1/2021#))
UNION
SELECT tEngedélyezettLétszámok.[Főosztály/Vezető], tEngedélyezettLétszámok.Osztály, 0 AS 2021, tEngedélyezettLétszámok.Létszám AS 2022, 0 AS 2023
FROM tEngedélyezettLétszámok
WHERE (((tEngedélyezettLétszámok.Hatály)=#1/1/2022#))
UNION
SELECT tEngedélyezettLétszámok.[Főosztály/Vezető], tEngedélyezettLétszámok.Osztály, 0 AS 2021, 0 AS 2022, tEngedélyezettLétszámok.Létszám AS 2023
FROM tEngedélyezettLétszámok
WHERE (((tEngedélyezettLétszámok.Hatály)=#3/25/2023#))
)  AS Unió2122
GROUP BY Unió2122.Osztály, Replace([Főosztály/Vezető],"Budapest Főváros Kormányhivatala","BFKH");

#/#/#/
lkEsetiCsúcsvezetők
#/#/
SELECT "Budapest Főváros Kormányhivatala" AS Kormányhivatal, lkSzemélyek.Besorolás, lkSzemélyek.[Dolgozó teljes neve]
FROM lkSzemélyek
WHERE (((lkSzemélyek.Besorolás)="főispán") AND ((lkSzemélyek.[Státusz neve])="álláshely")) OR (((lkSzemélyek.Besorolás)="főigazgató") AND ((lkSzemélyek.[Státusz neve])="álláshely")) OR (((lkSzemélyek.Besorolás) Like "*hivatal vezetője") AND ((lkSzemélyek.[Státusz neve])="álláshely")) OR (((lkSzemélyek.Főosztály) Like "Pénz*") AND ((lkSzemélyek.Besorolás)="főosztályvezető") AND ((lkSzemélyek.[Státusz neve])="álláshely"))
ORDER BY lkSzemélyek.BFKH;

#/#/#/
lkEsetiEgyesFőosztályokLétszámaÉsVezetői
#/#/
SELECT lkSzemélyek.BFKH, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.Adójel, lkSzemélyek.[Dolgozó teljes neve], lkFőosztályonéntiOsztályonkéntiLétszám.Létszám, lkSzemélyek.[Státusz típusa]
FROM lkSzemélyek INNER JOIN lkFőosztályonéntiOsztályonkéntiLétszám ON lkSzemélyek.BFKH = lkFőosztályonéntiOsztályonkéntiLétszám.BFKH
WHERE (((lkSzemélyek.Főosztály)="Foglalkoztatási Főosztály") AND ((lkSzemélyek.[Státusz típusa]) Like "Köz*") AND ((lkSzemélyek.Besorolás2)="Osztályvezető") AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY lkSzemélyek.BFKH;

#/#/#/
lkEsetiGyámügyiÁllománytábla01
#/#/
SELECT bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]) AS bfkh, lkJárásiKormányKözpontosítottUnió.Főosztály, lkJárásiKormányKözpontosítottUnió.Osztály, lkJárásiKormányKözpontosítottUnió.[Álláshely azonosító], lkJárásiKormányKözpontosítottUnió.Név, lkJárásiKormányKözpontosítottUnió.[Havi illetmény], lkJárásiKormányKözpontosítottUnió.[Heti munkaórák száma], "" AS [Jogviszony vége]
FROM lkJárásiKormányKözpontosítottUnió
WHERE (((lkJárásiKormányKözpontosítottUnió.Főosztály)="Gyámügyi Főosztály") AND ((lkJárásiKormányKözpontosítottUnió.[Születési év \ üres állás])<>"üres állás"))
ORDER BY lkJárásiKormányKözpontosítottUnió.Főosztály, lkJárásiKormányKözpontosítottUnió.Osztály;

#/#/#/
lkEsetiGyámügyiÁllománytábla02
#/#/
SELECT bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]) AS bfkh, lkKilépőUnió.Főosztály, lkKilépőUnió.Osztály, lkKilépőUnió.[Álláshely azonosító], lkKilépőUnió.Név, lkKilépőUnió.[Illetmény (Ft/hó)], lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker], lkSzemélyek.[Jogviszony vége (kilépés dátuma)]
FROM lkSzemélyek INNER JOIN lkKilépőUnió ON (lkSzemélyek.[Jogviszony vége (kilépés dátuma)] = lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja]) AND (lkSzemélyek.[Adóazonosító jel] = lkKilépőUnió.Adóazonosító)
WHERE (((lkKilépőUnió.Főosztály)="Gyámügyi Főosztály"));

#/#/#/
lkEsetiGyámügyiÁllománytábla03
#/#/
SELECT *
FROM (SELECT lkEsetiGyámügyiÁllománytábla02.*
FROM lkEsetiGyámügyiÁllománytábla02
UNION SELECT  lkEsetiGyámügyiÁllománytábla01.*
FROM lkEsetiGyámügyiÁllománytábla01)  AS lkEsetiGyámügyiÁllománytábla0102;

#/#/#/
lkEsetiKockázatiKérdőív01
#/#/
SELECT lkSzemélyek.BFKH, "Budapest Főváros Kormányhivatala" AS Szervezet, lkSzemélyek.[Szint 5 szervezeti egység név] AS Hivatal, lkSzemélyek.[Szint 6 szervezeti egység név] AS Főosztály, lkSzemélyek.Osztály, lkSzemélyek.Besorolás2, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Státusz kódja] AS [Álláshely azonosító], lkSzemélyek.[Státusz típusa] AS Jelleg, lkSzemélyek.[KIRA jogviszony jelleg] AS Jogviszony
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY lkSzemélyek.BFKH, lkSzemélyek.[Státusz típusa], lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkEsetiKockázatiKérdőív02
#/#/
SELECT lkSzervezetiÁlláshelyek.SzervezetKód AS BFKH, "Budapest Főváros Kormányhivatala" AS Szervezet, lkSzervezetiÁlláshelyek.[Szint5 - leírás] AS Hivatal, lkSzervezetiÁlláshelyek.[Szint6 - leírás] AS Főosztály, lkSzervezetiÁlláshelyek.[Szint7 - leírás] AS Osztály, lkSzervezetiÁlláshelyek.[Tervezett betöltési adatok - Előmeneteli fokozat megnevezés] AS Besorolás, "" AS Név, lkSzervezetiÁlláshelyek.ÁlláshelyAzonosító AS [Álláshely azonosító], lkSzervezetiÁlláshelyek.[Státusz típusa] AS Jelleg, lkSzervezetiÁlláshelyek.[Tervezett betöltési adatok - Jogviszony típus] AS Jogviszony
FROM lkSzervezetiÁlláshelyek
WHERE (((lkSzervezetiÁlláshelyek.OSZLOPOK)="Státusz (betöltetlen)"));

#/#/#/
lkEsetiKockázatiKérdőív03
#/#/
SELECT lkEsetiKockázatiKérdőív02.*
FROM lkEsetiKockázatiKérdőív02
UNION SELECT lkEsetiKockázatiKérdőív01.*
FROM  lkEsetiKockázatiKérdőív01;

#/#/#/
lkEsetiNemzetiKorrupcióellenesStratégia
#/#/
SELECT lkSzervezetiVezetőkListája02.[Szervezeti egység vezetője] AS [Kitöltő neve], [Főosztály] & ", " & [Név] AS [Kitöltő szervezeti egysége], lkSzervezetiVezetőkListája02.Besorolása AS [Kitöltő beosztása], IIf(Nz([HivataliVezetékes],[HivataliMobil]) Like "Hibás*","",Nz([HivataliVezetékes],[HivataliMobil])) AS [Kitöltő telefonszáma], lkSzervezetiVezetőkListája02.[Hivatali email] AS [Kitöltő e-mail címe], lkSzervezetiVezetőkListája02.HivataliMobil
FROM lkSzervezetiVezetőkListája02 INNER JOIN tmpKorrupcióEllenesLekérdezéshez ON lkSzervezetiVezetőkListája02.[BFKH kód] = tmpKorrupcióEllenesLekérdezéshez.BFKH
WHERE (((tmpKorrupcióEllenesLekérdezéshez.Kell_e)=True))
ORDER BY bfkh([BFKH kód]);

#/#/#/
lkEsetiProjektbeFelveendők
#/#/
SELECT kt_azNexon_Adójel02.Adójel, tEsetiProjektbeFelveendők.[Költséghely*]
FROM tEsetiProjektbeFelveendők LEFT JOIN kt_azNexon_Adójel02 ON tEsetiProjektbeFelveendők.[Személy azonosítója*] = kt_azNexon_Adójel02.azNexon;

#/#/#/
lkEsküLejártIdőpontokhozHozzáfűz
#/#/
INSERT INTO tEsküLejártIdőpontok ( [Szervezeti egység kód], [Szervezeti egység], [Szervezeti szint száma-neve], [Jogviszony típus], [Jogviszony kezdete], [Jogviszony vége], [Dolgozó neve], [Adóazonosító jel], [Figyelendő dátum típusa], [Figyelendő dátum], [Szint 1 szervezeti egység kód], [Szint 1 szervezeti egység név], [Szint 2 szervezeti egység kód], [Szint 2 szervezeti egység név], [Szint 3 szervezeti egység kód], [Szint 3 szervezeti egység név], [Szint 4 szervezeti egység kód], [Szint 4 szervezeti egység név], [Szint 5 szervezeti egység kód], [Szint 5 szervezeti egység név], [Szint 6 szervezeti egység kód], [Szint 6 szervezeti egység név], [Szint 7 szervezeti egység kód], [Szint 7 szervezeti egység név], [Szint 8 szervezeti egység kód], [Szint 8 szervezeti egység név], [Szint 9 szervezeti egység kód], [Szint 9 szervezeti egység név], [Szint 10 szervezeti egység kód], [Szint 10 szervezeti egység név] )
SELECT TmptEsküLejártIdőpontok.[Szervezeti egység kód] AS Kif1, TmptEsküLejártIdőpontok.[Szervezeti egység] AS Kif2, TmptEsküLejártIdőpontok.[Szervezeti szint száma-neve] AS Kif3, TmptEsküLejártIdőpontok.[Jogviszony típus] AS Kif4, dtátal([  Jogviszony kezdete]) AS [Jogviszony kezdete], dtátal([  Jogviszony vége]) AS [Jogviszony vége], TmptEsküLejártIdőpontok.[Dolgozó neve] AS Kif5, TmptEsküLejártIdőpontok.[Adóazonosító jel] AS Kif6, TmptEsküLejártIdőpontok.[Figyelendő dátum típusa] AS Kif7, dtátal([Figyelendő dátum]) AS Kif3, TmptEsküLejártIdőpontok.[Szint 1 szervezeti egység kód] AS Kif8, TmptEsküLejártIdőpontok.[Szint 1 szervezeti egység név] AS Kif9, TmptEsküLejártIdőpontok.[Szint 2 szervezeti egység kód] AS Kif10, TmptEsküLejártIdőpontok.[Szint 2 szervezeti egység név] AS Kif11, TmptEsküLejártIdőpontok.[Szint 3 szervezeti egység kód] AS Kif12, TmptEsküLejártIdőpontok.[Szint 3 szervezeti egység név] AS Kif13, TmptEsküLejártIdőpontok.[Szint 4 szervezeti egység kód] AS Kif14, TmptEsküLejártIdőpontok.[Szint 4 szervezeti egység név] AS Kif15, TmptEsküLejártIdőpontok.[Szint 5 szervezeti egység kód] AS Kif16, TmptEsküLejártIdőpontok.[Szint 5 szervezeti egység név] AS Kif17, TmptEsküLejártIdőpontok.[Szint 6 szervezeti egység kód] AS Kif18, TmptEsküLejártIdőpontok.[Szint 6 szervezeti egység név] AS Kif19, TmptEsküLejártIdőpontok.[Szint 7 szervezeti egység kód] AS Kif20, TmptEsküLejártIdőpontok.[Szint 7 szervezeti egység név] AS Kif21, TmptEsküLejártIdőpontok.[Szint 8 szervezeti egység kód] AS Kif22, TmptEsküLejártIdőpontok.[Szint 8 szervezeti egység név] AS Kif23, TmptEsküLejártIdőpontok.[Szint 9 szervezeti egység kód] AS Kif24, TmptEsküLejártIdőpontok.[Szint 9 szervezeti egység név] AS Kif25, TmptEsküLejártIdőpontok.[Szint 10 szervezeti egység kód] AS Kif26, TmptEsküLejártIdőpontok.[Szint 10 szervezeti egység név] AS Kif27
FROM TmptEsküLejártIdőpontok
WHERE ((([TmptEsküLejártIdőpontok].[Adóazonosító jel]) Is Not Null));

#/#/#/
lkÉvNem
#/#/
SELECT lkSzemélyek.[Adóazonosító jel], Year([Születési idő]) AS Év, IIf([Neme]="nő",2,1) AS Nem
FROM lkSzemélyek;

#/#/#/
lkÉvNem_kereszttábla
#/#/
TRANSFORM Count(lkÉvNem.[Adóazonosító jel]) AS [CountOfAdóazonosító jel]
SELECT lkÉvNem.Év, Count(lkÉvNem.[Adóazonosító jel]) AS Összesen
FROM lkÉvNem
GROUP BY lkÉvNem.Év
PIVOT lkÉvNem.[Nem] In (1,2);

#/#/#/
lkÉvVégiLétszámokÉsKilépőkNyugdíjasokNélkül
#/#/
SELECT lkLétszámMindenÉvUtolsóNapján.Év, lkLétszámMindenÉvUtolsóNapján.CountOfAdóazonosító AS [Létszám az év utolsó napján], lkKilépőkSzámaÉvente.[Kilépők száma]
FROM lkKilépőkSzámaÉvente RIGHT JOIN lkLétszámMindenÉvUtolsóNapján ON lkKilépőkSzámaÉvente.KilépésÉve = lkLétszámMindenÉvUtolsóNapján.Év;

#/#/#/
lkFARrésztvevő
#/#/
SELECT tFARrésztvevő.Adóazonosító, tFARrésztvevő.[Legmagasabb iskolai végzettsége], lkFARfordítótáblaVégzettséghez.FAR, lkSzemélyek.[Iskolai végzettség foka], lkSzemélyek.[Dolgozó teljes neve] AS [Viselt neve], lkSzemélyek.[Dolgozó születési neve] AS [Születési neve], lkSzemélyek.[Anyja neve], tFARrésztvevő.[Születési ország], lkSzemélyek.[Születési hely] AS [Születési helye], lkSzemélyek.[Születési idő] AS [Születési ideje], tFARrésztvevő.[E-mail címe], tFARrésztvevő.[Magyarországi lakcímmel nem rendelkező nem magyar állampolgár], tFARrésztvevő.[DHK Képzési hitel?], tFARrésztvevő.[Résztvevő által fizetendő díj], tFARrésztvevő.Tábla
FROM (lkSzemélyek RIGHT JOIN tFARrésztvevő ON lkSzemélyek.[Adóazonosító jel]=tFARrésztvevő.Adóazonosító) LEFT JOIN lkFARfordítótáblaVégzettséghez ON lkSzemélyek.[Iskolai végzettség foka]=lkFARfordítótáblaVégzettséghez.Nexon;

#/#/#/
lkFeladatKirafeladatFunkció
#/#/
SELECT ktFeladatKirafeladatFunkció.Azonosító, Nz([Feladat],"") AS Feladata, ktFeladatKirafeladatFunkció.[KIRA feladat megnevezés], Nz([Megnevezés (magyar)],"-") AS Funkció
FROM ktFeladatKirafeladatFunkció LEFT JOIN tFunkciók ON ktFeladatKirafeladatFunkció.azFunkció = tFunkciók.azFunkció;

#/#/#/
lkFeladatkör_KIRAfeladat
#/#/
SELECT DISTINCT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.Feladatkör, lkSzemélyek.[KIRA feladat megnevezés]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely"));

#/#/#/
lkFeladatkörökAKabinetbenÉsAzIgazgatóságon
#/#/
SELECT DISTINCT lkSzemélyek.Főosztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[KIRA feladat megnevezés]
FROM lkSzemélyek
WHERE (((lkSzemélyek.Főosztály) Like "Főispáni*" Or (lkSzemélyek.Főosztály) Like "Főigazgatói*") AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY lkSzemélyek.Főosztály DESC , lkSzemélyek.[KIRA feladat megnevezés], lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkFeladatkörönkéntiLétszám
#/#/
SELECT DISTINCT lkSzemélyek.[KIRA feladat megnevezés] AS [meghagyásra kijelölt munkakörök megnevezése], Count(lkSzemélyek.Adójel) AS A, 0 AS B, Count(lkSzemélyek.Adójel) AS C
FROM lkSzemélyek RIGHT JOIN tMeghagyásraKijelöltMunkakörök ON lkSzemélyek.[KIRA feladat megnevezés] like "*"&tMeghagyásraKijelöltMunkakörök.Feladatkörök&"*"
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely"))
GROUP BY lkSzemélyek.[KIRA feladat megnevezés], 0
ORDER BY lkSzemélyek.[KIRA feladat megnevezés];

#/#/#/
lkFeladatkörönkéntiMeghagyottak
#/#/
SELECT lkMeghagyandóMaxLétszámFeladatkörönként.Feladatkörök, lkMeghagyandóMaxLétszámFeladatkörönként.Létszám AS A, lkMeghagyandóMaxLétszámFeladatkörönként.[Betöltött létszám arányosítva] AS B, [A]-[b] AS C
FROM lkMeghagyandóMaxLétszámFeladatkörönként;

#/#/#/
lkFeltehetőenTévesNeműDolgozók
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Neme, kt_azNexon_Adójel02.NLink
FROM tUtónevekNemekkel, kt_azNexon_Adójel02 INNER JOIN lkSzemélyek ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.Neme)<>[tUtónevekNemekkel].[neme]) AND ((utolsó([Dolgozó teljes neve]," ",0))=[tUtónevekNemekkel].[Keresztnév]) AND ((lkSzemélyek.[Státusz neve])="álláshely"));

#/#/#/
lkFennállóHibák
#/#/
SELECT tRégiHibák.[Első mező] AS Hash, tRégiHibák.lekérdezésNeve, tRégiHibák.[Második mező] AS Hibaszöveg, tRégiHibák.[Első Időpont]
FROM tRégiHibák
WHERE (((tRégiHibák.[Utolsó Időpont])=(select max([utolsó időpont]) from tRégiHibák )))
ORDER BY tRégiHibák.[Első Időpont];

#/#/#/
lkFennállóHibákStatisztika
#/#/
SELECT lkEllenőrzőLekérdezések2.Táblacím, [Hibák]-[Ebből intézett] AS Intézetlen, Count(tRégiHibák.[Első mező]) AS Hibák, Count(lkktRégiHibákIntézkedésekUtolsóIntézkedés.azIntézkedések) AS [Ebből intézett]
FROM lkEllenőrzőLekérdezések2 INNER JOIN (tRégiHibák LEFT JOIN lkktRégiHibákIntézkedésekUtolsóIntézkedés ON tRégiHibák.[Első mező] = lkktRégiHibákIntézkedésekUtolsóIntézkedés.HASH) ON lkEllenőrzőLekérdezések2.EllenőrzőLekérdezés = tRégiHibák.lekérdezésNeve
WHERE (((tRégiHibák.[Utolsó Időpont])=(select max([utolsó időpont]) from tRégiHibák where lekérdezésneve <>"lkÜresÁlláshelyekÁllapotfelmérő" And lekérdezésneve <>"lkFontosHiányzóAdatok02")))
GROUP BY lkEllenőrzőLekérdezések2.Táblacím, tRégiHibák.lekérdezésNeve
HAVING (((tRégiHibák.lekérdezésNeve)<>"lkLejártAlkalmasságiÉrvényesség" And (tRégiHibák.lekérdezésNeve)<>"lkÜresÁlláshelyekÁllapotfelmérő") AND (("lekérdezésneve")<>"lkFontosHiányzóAdatok02"))
ORDER BY Count(tRégiHibák.[Első mező]) DESC , Count(lkktRégiHibákIntézkedésekUtolsóIntézkedés.azIntézkedések) DESC;

#/#/#/
lkFennállóNemHibák
#/#/
SELECT lkVisszajelzésekKezelése.SenderEmailAddress, lkVisszajelzésekKezelése.lekérdezésNeve, lkVisszajelzésekKezelése.VisszajelzésSzövege, lkVisszajelzésekKezelése.[Fennállás kezdete], lkFennállóHibák.Hibaszöveg
FROM lkFennállóHibák INNER JOIN ((lkVisszajelzésekKezelése INNER JOIN lkRégiHibákUtolsóIntézkedés ON lkVisszajelzésekKezelése.Hash = lkRégiHibákUtolsóIntézkedés.HASH) INNER JOIN tIntézkedésFajták ON lkRégiHibákUtolsóIntézkedés.azIntFajta = tIntézkedésFajták.azIntFajta) ON lkFennállóHibák.Hash = lkVisszajelzésekKezelése.Hash
WHERE (((tIntézkedésFajták.IntézkedésFajta)="referens szerint nem hiba"));

#/#/#/
lkFennállóOsztályozandóHibák
#/#/
SELECT lkVisszajelzésekKezelése.SenderEmailAddress, lkVisszajelzésekKezelése.lekérdezésNeve, lkVisszajelzésekKezelése.VisszajelzésSzövege, lkVisszajelzésekKezelése.[Fennállás kezdete], lkFennállóHibák.Hibaszöveg
FROM lkFennállóHibák INNER JOIN ((lkVisszajelzésekKezelése INNER JOIN lkRégiHibákUtolsóIntézkedés ON lkVisszajelzésekKezelése.Hash = lkRégiHibákUtolsóIntézkedés.HASH) INNER JOIN tIntézkedésFajták ON lkRégiHibákUtolsóIntézkedés.azIntFajta = tIntézkedésFajták.azIntFajta) ON lkFennállóHibák.Hash = lkVisszajelzésekKezelése.Hash
WHERE (((tIntézkedésFajták.IntézkedésFajta)="osztályozandó"));

#/#/#/
lkFESZ
#/#/
SELECT FESZ.Azonosító, FESZ.Név, Csakszám([TAJ]) AS [TAJ szám], dtÁtal([Szüldátum]) AS Szül, FESZ.Osztály, FESZ.[FEOR megnevezés], FESZ.[Alk tipus], dtÁtal([Alk dátuma]) AS ADátum, dtÁtal([Érvényes]) AS Érvény, FESZ.Korlátozás, FESZ.Hatály
FROM FESZ;

#/#/#/
lkFesz_01
#/#/
SELECT CStr([TAJ szám]) AS TAJ, lkFESZ.Név, lkFESZ.Szül, lkFESZ.Osztály, lkFESZ.[FEOR megnevezés], lkFESZ.[Alk tipus], lkFESZ.ADátum, lkFESZ.Érvény, lkFESZ.Korlátozás
FROM lkFESZ
WHERE (((CStr([TAJ szám]))<>0));

#/#/#/
lkFesz_01b
#/#/
SELECT lkSzemélyek.Azonosító, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkFesz_01.Név, lkFesz_01.TAJ, lkFesz_01.Szül, lkFesz_01.Osztály AS EüOsztály, lkFesz_01.[FEOR megnevezés], lkFesz_01.[Alk tipus], lkFesz_01.ADátum, lkFesz_01.Érvény, lkFesz_01.Korlátozás, lkSzemélyek.[Orvosi vizsgálat időpontja], lkSzemélyek.[Orvosi vizsgálat típusa], lkSzemélyek.[Orvosi vizsgálat eredménye], lkSzemélyek.[Orvosi vizsgálat észrevételek], lkSzemélyek.[Orvosi vizsgálat következő időpontja]
FROM lkFesz_01 INNER JOIN lkSzemélyek ON lkFesz_01.TAJ = lkSzemélyek.[TAJ szám];

#/#/#/
lkFesz_02
#/#/
SELECT lkSzemélyek.Azonosító, lkSzemélyek.Főosztály, lkSzemélyek.[Szervezeti egység neve] AS Osztály, lkFESZ.Név, lkFESZ.[TAJ szám], lkFESZ.Szül, lkFESZ.Osztály AS EüOsztály, lkFESZ.[FEOR megnevezés], lkFESZ.[Alk tipus], lkFESZ.ADátum, lkFESZ.Érvény, lkFESZ.Korlátozás, lkSzemélyek.[Orvosi vizsgálat időpontja], lkSzemélyek.[Orvosi vizsgálat típusa], lkSzemélyek.[Orvosi vizsgálat eredménye], lkSzemélyek.[Orvosi vizsgálat észrevételek], lkSzemélyek.[Orvosi vizsgálat következő időpontja]
FROM lkSzemélyek RIGHT JOIN lkFESZ ON (lkSzemélyek.[Születési idő] = lkFESZ.Szül) AND (lkSzemélyek.[Dolgozó teljes neve] = lkFESZ.Név)
WHERE (((lkSzemélyek.Azonosító) Is Not Null));

#/#/#/
lkFESZ_ellenőrzés
#/#/
SELECT lkFESZ.Név, lkFESZ.Szül
FROM lkFESZ LEFT JOIN lk_Fesz_03 ON (lkFESZ.Név = lk_Fesz_03.Név) AND (lkFESZ.Szül = lk_Fesz_03.Szül)
WHERE (((lk_Fesz_03.Azonosító) Is Null));

#/#/#/
lkFontosHiányzóAdatok01
#/#/
SELECT lk_Ellenőrzés_03.Főosztály, lk_Ellenőrzés_03.Osztály, lk_Ellenőrzés_03.Név, lk_Ellenőrzés_03.[Hiányzó érték], lk_Ellenőrzés_03.[Státusz kód], lk_Ellenőrzés_03.Megjegyzés, lk_Ellenőrzés_03.NLink, TextToMD5Hex([Főosztály] & "|" & [Osztály] & "|" & [Név] & "|" & [Hiányzó érték] & "|" & [Státusz kód] & "|" & [NLink] & "|" & [Megjegyzés] & "|") AS Hash
FROM lk_Ellenőrzés_03
WHERE (((lk_Ellenőrzés_03.[Hiányzó érték])<>"Hivatali email" And (lk_Ellenőrzés_03.[Hiányzó érték])<>"Munkavégzés helye - cím" And (lk_Ellenőrzés_03.[Hiányzó érték])<>"Központosított álláshelyhez nincs megjelölve költséghely vagy költséghely-kód (projekt)." And (lk_Ellenőrzés_03.[Hiányzó érték])<>"Eskületétel időpontja" And (lk_Ellenőrzés_03.[Hiányzó érték])<>"Állandó lakcím hiányzik, vagy nem érvényes"));

#/#/#/
lkFontosHiányzóAdatok02
#/#/
SELECT lkFontosHiányzóAdatok01.Főosztály, lkFontosHiányzóAdatok01.Osztály, lkFontosHiányzóAdatok01.Név, lkFontosHiányzóAdatok01.[Hiányzó érték], lkFontosHiányzóAdatok01.[Státusz kód], lkFontosHiányzóAdatok01.NLink, lkFontosHiányzóAdatok01.Megjegyzés
FROM lkFontosHiányzóAdatok01 LEFT JOIN lkktRégiHibákIntézkedésekLegutolsóIntézkedés ON lkFontosHiányzóAdatok01.Hash = lkktRégiHibákIntézkedésekLegutolsóIntézkedés.HASH
WHERE (((lkktRégiHibákIntézkedésekLegutolsóIntézkedés.azIntFajta)=3 Or (lkktRégiHibákIntézkedésekLegutolsóIntézkedés.azIntFajta) Is Null Or (lkktRégiHibákIntézkedésekLegutolsóIntézkedés.azIntFajta)=8));

#/#/#/
lkFordulónaptólABelépésigElőzőMunkahelyMunkanapjai
#/#/
SELECT [Adóazonosító jel]*1 AS Adójel, tElőzőMunkahelyek.[Munkahely neve], tElőzőMunkahelyek.[Jogviszony típus megnevezése], tElőzőMunkahelyek.Kezdete1, tElőzőMunkahelyek.Vége2, DateDiff("d",[Fordulónap],[Vége2])-IIf(DateDiff("d",[Fordulónap],[Kezdete1])>0,DateDiff("d",[Fordulónap],[Kezdete1]),0)+1 AS Napok
FROM tElőzőMunkahelyek
WHERE (((tElőzőMunkahelyek.Vége2)>=[Fordulónap]));

#/#/#/
lkFordulónaptólABelépésigElőzőÖsszesMunkanapja
#/#/
SELECT lkFordulónaptólABelépésigElőzőMunkahelyMunkanapjai.*
FROM lkFordulónaptólABelépésigElőzőMunkahelyMunkanapjai
UNION SELECT lkFordulónaptólABelépésigElőzőJogviszonyMunkanapjai.*
FROM lkFordulónaptólABelépésigElőzőJogviszonyMunkanapjai;

#/#/#/
lkFordulónaptólEgyévigMindenJogviszonyMunkanapjai
#/#/
SELECT lkSzemélyek.Adójel, "BFKH" AS [Munkahely neve], lkSzemélyek.[Jogviszony típusa / jogviszony típus], lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS Kezdete, IIf([Jogviszony vége (kilépés dátuma)]=0 Or [Jogviszony vége (kilépés dátuma)]>DateSerial(Year([Fordulónap])+1,Month([Fordulónap]),Day([Fordulónap])-1),DateSerial(Year([Fordulónap])+1,Month([Fordulónap]),Day([Fordulónap])-1),[Jogviszony vége (kilépés dátuma)]) AS Vége, DateDiff("d",[Fordulónap],[Vége])-IIf(DateDiff("d",[Fordulónap],[Kezdete])>0,DateDiff("d",[Fordulónap],[Kezdete]),0)+1 AS Napok
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Jogviszony típusa / jogviszony típus]) Like "K*" 
        Or (lkSzemélyek.[Jogviszony típusa / jogviszony típus]) Like "H*"
        Or (lkSzemélyek.[Jogviszony típusa / jogviszony típus]) Like "Mu*" 
        Or (lkSzemélyek.[Jogviszony típusa / jogviszony típus]) Like "P*") 
	AND ((lkSzemélyek.[Jogviszony vége (kilépés dátuma)])>=[Fordulónap] 
		Or (lkSzemélyek.[Jogviszony vége (kilépés dátuma)])=0));

#/#/#/
lkForrásNexonSzervezetekÖsszerendelés
#/#/
SELECT tForrásNexonSzervezetekÖsszerendelés.Azonosító, Replace([Főosztály],"Budapest Főváros Kormányhivatala","BFKH") AS Főoszt, IIf([Osztály]="Járási hivatal",[Főosztály],[Osztály]) AS Oszt, tForrásNexonSzervezetekÖsszerendelés.ForrásKód
FROM tForrásNexonSzervezetekÖsszerendelés;

#/#/#/
lkFőispániKabinetÁlláshelyei
#/#/
TRANSFORM Min(tHaviJelentésHatálya1.hatálya) AS MinOfhatálya
SELECT tKormányhivatali_állomány.[Álláshely azonosító]
FROM tKormányhivatali_állomány INNER JOIN tHaviJelentésHatálya1 ON tKormányhivatali_állomány.hatályaID = tHaviJelentésHatálya1.hatályaID
WHERE (((tHaviJelentésHatálya1.hatálya)>#1/1/2024#) AND ((tKormányhivatali_állomány.Mező6)="főispáni kabinet"))
GROUP BY tKormányhivatali_állomány.[Álláshely azonosító]
ORDER BY tKormányhivatali_állomány.[Álláshely azonosító], tHaviJelentésHatálya1.hatálya
PIVOT tHaviJelentésHatálya1.hatálya;

#/#/#/
lkFőispániKabinetÁlláshelyei2
#/#/
TRANSFORM First(lkÁllománytáblákTörténetiUniója.Főoszt) AS FirstOfFőoszt
SELECT lkÁllománytáblákTörténetiUniója.[Álláshely azonosító]
FROM tFőispániKabinetÁlláshelyei20240831ig INNER JOIN (lkÁllománytáblákTörténetiUniója INNER JOIN tHaviJelentésHatálya1 ON lkÁllománytáblákTörténetiUniója.hatályaID = tHaviJelentésHatálya1.hatályaID) ON tFőispániKabinetÁlláshelyei20240831ig.ÁlláshelyAz = lkÁllománytáblákTörténetiUniója.[Álláshely azonosító]
WHERE (((tHaviJelentésHatálya1.hatálya)>#1/1/2024#))
GROUP BY lkÁllománytáblákTörténetiUniója.[Álláshely azonosító]
PIVOT tHaviJelentésHatálya1.hatálya;

#/#/#/
lkFőosztályDolgozóinakListájaIdőszakiMátrixban01
#/#/
SELECT HumánUnió.Adójel, HumánUnió.[Dolgozó teljes neve], HumánUnió.Belépés, HumánUnió.Kilépés, lkKiemeltNapok.év & Right("0" & lkKiemeltNapok.hó,2) AS ÉvHó, IIf(lkKiemeltNapok.KiemeltNapok Between dtÁtal(Nz([Tartós távollét kezdete],#1/1/3000#)) And dtÁtal(Nz([Tartós távollét vége],#1/1/3000#)),2,1)
FROM (SELECT lkSzemélyek.Adójel, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS Belépés, #01/01/3000# AS Kilépés, [Tartós távollét kezdete], [Tartós távollét vége] FROM lkSzemélyek WHERE (((lkSzemélyek.Főosztály) Like "*"&[Melyik főosztályt keressük]&"*")) 
UNION 
SELECT lkKilépőUnió.Adójel, lkKilépőUnió.Név, lkKilépőUnió.[Jogviszony kezdő dátuma] AS Belépés, iif(dtÁtal(lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja])=0,#01/01/3000#,dtÁtal(lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja])) AS Kilépés,#01/01/3000# as TTkezdete, #01/01/3000# as TTvége 
FROM lkKilépőUnió WHERE (((lkKilépőUnió.Főosztály) Like "*"&[Melyik főosztályt keressük]&"*"))  )  AS HumánUnió INNER JOIN lkKiemeltNapok ON (HumánUnió.Belépés <= lkKiemeltNapok.KiemeltNapok) AND (HumánUnió.Kilépés >= lkKiemeltNapok.KiemeltNapok)
WHERE (((HumánUnió.Kilépés)>#1/1/2023#) AND ((lkKiemeltNapok.KiemeltNapok) Between #1/1/2023# And Now()) AND ((lkKiemeltNapok.nap)=1));

#/#/#/
lkFőosztályDolgozóinakListájaIdőszakiMátrixban02
#/#/
TRANSFORM Sum(lkFőosztályDolgozóinakListájaIdőszakiMátrixban01.Expr1005) AS SumOfExpr1005
SELECT lkFőosztályDolgozóinakListájaIdőszakiMátrixban01.[Dolgozó teljes neve]
FROM lkFőosztályDolgozóinakListájaIdőszakiMátrixban01
GROUP BY lkFőosztályDolgozóinakListájaIdőszakiMátrixban01.[Dolgozó teljes neve]
PIVOT lkFőosztályDolgozóinakListájaIdőszakiMátrixban01.ÉvHó In (2301,2302,2303,2304,2305,2306,2307,2308,2309,2310,2311,2312,2401,2402,2403);

#/#/#/
lkFőosztályiLétszám2024Ifélév00
#/#/
SELECT lktKormányhivatali_állomány.Osztály, lktKormányhivatali_állomány.hatályaID, IIf([Születési év \ üres állás]="üres állás",0,1) AS Létszám
FROM lktKormányhivatali_állomány
WHERE (((lktKormányhivatali_állomány.Főosztály) Like "Humán*"));

#/#/#/
lkFőosztályiLétszám2024Ifélév01
#/#/
SELECT tHaviJelentésHatálya1.hatályaID, lkKiemeltNapok.KiemeltNapok
FROM tHaviJelentésHatálya1 INNER JOIN lkKiemeltNapok ON tHaviJelentésHatálya1.hatálya = lkKiemeltNapok.KiemeltNapok
WHERE (((lkKiemeltNapok.tnap)<>1 And (lkKiemeltNapok.tnap)<>15) AND ((lkKiemeltNapok.KiemeltNapok) Between #12/31/2023# And #7/31/2024#))
GROUP BY tHaviJelentésHatálya1.hatályaID, lkKiemeltNapok.KiemeltNapok;

#/#/#/
lkFőosztályiLétszám2024Ifélév02
#/#/
SELECT lkFőosztályiLétszám2024Ifélév01.KiemeltNapok, lkFőosztályiLétszám2024Ifélév00.Osztály, Sum(lkFőosztályiLétszám2024Ifélév00.Létszám) AS SumOfLétszám
FROM lkFőosztályiLétszám2024Ifélév00 INNER JOIN lkFőosztályiLétszám2024Ifélév01 ON lkFőosztályiLétszám2024Ifélév00.hatályaID = lkFőosztályiLétszám2024Ifélév01.hatályaID
GROUP BY lkFőosztályiLétszám2024Ifélév01.KiemeltNapok, lkFőosztályiLétszám2024Ifélév00.Osztály;

#/#/#/
lkFőosztályiLétszám2024Ifélév03
#/#/
SELECT ElőzőDátumIs.hatályaID, ElőzőDátumIs.MaxOfKiemeltNapok AS Előző, ElőzőDátumIs.KiemeltNapok
FROM (SELECT lkFőosztályiLétszám2024Ifélév01.hatályaID, lkFőosztályiLétszám2024Ifélév01.KiemeltNapok, Max(lkFőosztályiLétszám2024Ifélév01_1.[KiemeltNapok]) AS MaxOfKiemeltNapok FROM lkFőosztályiLétszám2024Ifélév01 AS lkFőosztályiLétszám2024Ifélév01_1 RIGHT JOIN lkFőosztályiLétszám2024Ifélév01 ON lkFőosztályiLétszám2024Ifélév01_1.KiemeltNapok < lkFőosztályiLétszám2024Ifélév01.KiemeltNapok GROUP BY lkFőosztályiLétszám2024Ifélév01.hatályaID, lkFőosztályiLétszám2024Ifélév01.KiemeltNapok)  AS ElőzőDátumIs
ORDER BY ElőzőDátumIs.KiemeltNapok;

#/#/#/
lkFőosztályiLétszám2024Ifélév04
#/#/
TRANSFORM Sum(1) AS Létszám
SELECT lktKormányhivatali_állomány.Adóazonosító
FROM (lktKormányhivatali_állomány INNER JOIN tHaviJelentésHatálya1 ON lktKormányhivatali_állomány.hatályaID = tHaviJelentésHatálya1.hatályaID) INNER JOIN lkFőosztályiLétszám2024Ifélév01 ON tHaviJelentésHatálya1.hatályaID = lkFőosztályiLétszám2024Ifélév01.hatályaID
WHERE (((lktKormányhivatali_állomány.Főosztály) Like "Humán*") AND ((lktKormányhivatali_állomány.[Születési év \ üres állás])<>"üres állás"))
GROUP BY lktKormányhivatali_állomány.Adóazonosító, lktKormányhivatali_állomány.Főosztály
PIVOT tHaviJelentésHatálya1.hatálya;

#/#/#/
lkFőosztályiLétszám2024Ifélév05
#/#/
SELECT lktKormányhivatali_állomány.Osztály, lktKormányhivatali_állomány.Adóazonosító, tHaviJelentésHatálya1.hatálya, lkFőosztályiLétszám2024Ifélév03.Előző, 1 AS Létszám, tHaviJelentésHatálya1.hatályaID
FROM ((lktKormányhivatali_állomány INNER JOIN tHaviJelentésHatálya1 ON lktKormányhivatali_állomány.hatályaID = tHaviJelentésHatálya1.hatályaID) INNER JOIN lkFőosztályiLétszám2024Ifélév01 ON tHaviJelentésHatálya1.hatályaID = lkFőosztályiLétszám2024Ifélév01.hatályaID) INNER JOIN lkFőosztályiLétszám2024Ifélév03 ON tHaviJelentésHatálya1.hatályaID = lkFőosztályiLétszám2024Ifélév03.hatályaID
WHERE (((lktKormányhivatali_állomány.[Születési év \ üres állás])<>"üres állás") AND ((lktKormányhivatali_állomány.Főosztály) Like "Humán*"));

#/#/#/
lkFőosztályiLétszám2024Ifélév06belépők
#/#/
SELECT jelenlegi.Osztály, jelenlegi.hatálya, Sum(IIf(IsNull([Előző].[Adóazonosító]),1,0)) AS Belépők, Sum(0) AS Kilépők
FROM lkFőosztályiLétszám2024Ifélév05 AS előző RIGHT JOIN lkFőosztályiLétszám2024Ifélév05 AS jelenlegi ON (előző.hatálya = jelenlegi.Előző) AND (előző.Adóazonosító = jelenlegi.Adóazonosító)
GROUP BY jelenlegi.Osztály, jelenlegi.hatálya;

#/#/#/
lkFőosztályiLétszám2024Ifélév06kilépők
#/#/
SELECT előző.Osztály, előző.hatálya, Sum(0) AS Belépők, Sum(IIf(IsNull([jelenlegi].[Adóazonosító]),1,0)) AS Kilépők
FROM lkFőosztályiLétszám2024Ifélév05 AS előző LEFT JOIN lkFőosztályiLétszám2024Ifélév05 AS jelenlegi ON (előző.Adóazonosító = jelenlegi.Adóazonosító) AND (előző.hatálya = jelenlegi.Előző)
GROUP BY előző.Osztály, előző.hatálya;

#/#/#/
lkFőosztályiLétszám2024Ifélév06létszám
#/#/
SELECT lkFőosztályiLétszám2024Ifélév05.Osztály, lkFőosztályiLétszám2024Ifélév05.hatálya, Sum(lkFőosztályiLétszám2024Ifélév05.Létszám) AS Létszám
FROM lkFőosztályiLétszám2024Ifélév05
GROUP BY lkFőosztályiLétszám2024Ifélév05.Osztály, lkFőosztályiLétszám2024Ifélév05.hatálya;

#/#/#/
lkFőosztályiLétszám2024Ifélév06összes
#/#/
SELECT BeKilépők.Osztály, BeKilépők.hatálya, lkFőosztályiLétszám2024Ifélév06létszám.Létszám, Sum(BeKilépők.Belépők) AS SumOfBelépők, Sum(BeKilépők.Kilépők) AS SumOfKilépők
FROM lkFőosztályiLétszám2024Ifélév06létszám INNER JOIN (SELECT lkFőosztályiLétszám2024Ifélév06kilépők.*
FROM lkFőosztályiLétszám2024Ifélév06kilépők
UNION
SELECT lkFőosztályiLétszám2024Ifélév06belépők.*
FROM  lkFőosztályiLétszám2024Ifélév06belépők
)  AS BeKilépők ON (lkFőosztályiLétszám2024Ifélév06létszám.Osztály = BeKilépők.Osztály) AND (lkFőosztályiLétszám2024Ifélév06létszám.hatálya = BeKilépők.hatálya)
GROUP BY BeKilépők.Osztály, BeKilépők.hatálya, lkFőosztályiLétszám2024Ifélév06létszám.Létszám
HAVING (((BeKilépők.hatálya) Between #1/1/2024# And #6/30/2024#));

#/#/#/
lkFőosztályiLétszám2024Ifélév07
#/#/
SELECT jelenlegi.Főosztály, jelenlegi.Osztály, jelenlegi.Név, jelenlegi.Adóazonosító, jelenlegi.[Ellátott feladat], lkSzemélyek.[Jogviszony kezdete (belépés dátuma)], lkSzemélyek.[Jogviszony vége (kilépés dátuma)], IIf(IsNull([Előző].[Főosztály]) And IsNull([Előző].[osztály]),"",Format([jelenlegi].[hatálya],"yyyy/ mm/")) AS Hónaptól, "" AS Hónapig, [Előző].[Főosztály] & IIf(IsNull([Előző].[Osztály]),"","/" & [Előző].[Osztály]) AS Honnan, [Jelenlegi].[Főosztály] & "/" & [Jelenlegi].[Osztály] AS Hová, jelenlegi.Jogviszony, jelenlegi.hatályaID, IIf(IsNull([Előző].[Adóazonosító]),1,0) AS Belépő
FROM lkSzemélyek INNER JOIN (lkFőosztályiLétszám2024Ifélév0700 AS előző RIGHT JOIN lkFőosztályiLétszám2024Ifélév0700 AS jelenlegi ON (előző.hatálya = jelenlegi.Előző) AND (előző.Adóazonosító = jelenlegi.Adóazonosító)) ON lkSzemélyek.[Adóazonosító jel] = jelenlegi.Adóazonosító
WHERE (((jelenlegi.Főosztály)<>[Előző].[főosztály])) OR (((jelenlegi.Osztály)<>[Előző].[osztály])) OR (((előző.Főosztály) Is Null) AND ((előző.Osztály) Is Null));

#/#/#/
lkFőosztályiLétszám2024Ifélév0700
#/#/
SELECT lkÁllománytáblákTörténetiUniója.Főoszt AS Főosztály, lkÁllománytáblákTörténetiUniója.Osztály, lkÁllománytáblákTörténetiUniója.Adóazonosító, lkÁllománytáblákTörténetiUniója.Név, lkÁllománytáblákTörténetiUniója.[Ellátott feladat], tHaviJelentésHatálya1.hatálya, lkFőosztályiLétszám2024Ifélév03.Előző, 1 AS Létszám, tHaviJelentésHatálya1.hatályaID, IIf(InStr(1,[Besorolási fokozat kód:],"Mt.")>0,"Mt.","Kit.") AS Jogviszony
FROM ((lkÁllománytáblákTörténetiUniója INNER JOIN tHaviJelentésHatálya1 ON lkÁllománytáblákTörténetiUniója.hatályaID = tHaviJelentésHatálya1.hatályaID) INNER JOIN lkFőosztályiLétszám2024Ifélév01 ON tHaviJelentésHatálya1.hatályaID = lkFőosztályiLétszám2024Ifélév01.hatályaID) INNER JOIN lkFőosztályiLétszám2024Ifélév03 ON tHaviJelentésHatálya1.hatályaID = lkFőosztályiLétszám2024Ifélév03.hatályaID
WHERE (((lkÁllománytáblákTörténetiUniója.[Születési év \ üres állás])<>"üres állás"));

#/#/#/
lkFőosztályLétszámÉsVezetőkNélküliÁtlagbér01
#/#/
SELECT DISTINCT lkHaviLétszámFőosztály.Jelleg, IIf(Len([FőosztályKód])<=9,0,IIf([FőosztályKód] Like "BFKH.1.2.*",2,1)) AS Sorrend, lkFőosztályok.FőosztályKód, lkHaviLétszámFőosztály.Főosztály, lkFőosztályLétszámÉsVezetőkNélküliÁtlagbér01b.Engedélyezett, lkHaviLétszámFőosztály.[Betöltött létszám], "" AS [indokolás a betöltetlen álláshelyhez], lkHaviLétszámFőosztály.[Üres álláshely], lk_Főosztályonkénti_átlagilletmény02_vezetőknélkül.Átlagilletmény
FROM lkFőosztályLétszámÉsVezetőkNélküliÁtlagbér01b RIGHT JOIN (lkFőosztályok RIGHT JOIN (lk_Főosztályonkénti_átlagilletmény02_vezetőknélkül RIGHT JOIN lkHaviLétszámFőosztály ON lk_Főosztályonkénti_átlagilletmény02_vezetőknélkül.Főosztály = lkHaviLétszámFőosztály.Főosztály) ON lkFőosztályok.Főosztály = lkHaviLétszámFőosztály.Főosztály) ON (lkFőosztályLétszámÉsVezetőkNélküliÁtlagbér01b.FőosztályÁlláshely = lkHaviLétszámFőosztály.Főosztály) AND (lkFőosztályLétszámÉsVezetőkNélküliÁtlagbér01b.jelleg = lkHaviLétszámFőosztály.Jelleg);

#/#/#/
lkFőosztályLétszámÉsVezetőkNélküliÁtlagbér01b
#/#/
SELECT lkÁlláshelyek.FőosztályÁlláshely, Count(lkÁlláshelyek.[Álláshely azonosító]) AS Engedélyezett, IIf([Álláshely típusa] Like "ALAP*","A","K") AS jelleg
FROM lkÁlláshelyek
GROUP BY lkÁlláshelyek.FőosztályÁlláshely, IIf([Álláshely típusa] Like "ALAP*","A","K");

#/#/#/
lkFőosztályLétszámÉsVezetőkNélküliÁtlagbér02
#/#/
SELECT lkFőosztályLétszámÉsVezetőkNélküliÁtlagbér01.Főosztály, lkFőosztályLétszámÉsVezetőkNélküliÁtlagbér01.Engedélyezett, lkFőosztályLétszámÉsVezetőkNélküliÁtlagbér01.[Betöltött létszám], lkFőosztályLétszámÉsVezetőkNélküliÁtlagbér01.[indokolás a betöltetlen álláshelyhez], lkFőosztályLétszámÉsVezetőkNélküliÁtlagbér01.[Üres álláshely], lkFőosztályLétszámÉsVezetőkNélküliÁtlagbér01.Átlagilletmény
FROM lkFőosztályLétszámÉsVezetőkNélküliÁtlagbér01
ORDER BY lkFőosztályLétszámÉsVezetőkNélküliÁtlagbér01.Jelleg, lkFőosztályLétszámÉsVezetőkNélküliÁtlagbér01.Sorrend, lkFőosztályLétszámÉsVezetőkNélküliÁtlagbér01.FőosztályKód;

#/#/#/
lkFőosztályok
#/#/
SELECT DISTINCT lkSzemélyek.[Szervezeti egység kódja], lkSzemélyek.Főosztály, lkSzemélyek.BFKH, lkSzemélyek.FőosztályKód
FROM lkSzemélyek;

#/#/#/
lkFőosztályokLétszámánakKerületenkéntiEloszlása
#/#/
SELECT lkVárosKerületenkéntiFőosztályonkéntiLétszám01.Főosztály, lkVárosKerületenkéntiFőosztályonkéntiLétszám01.Kerület, [Létszám]/[FőosztályiLétszám] AS Arány
FROM lkVárosKerületenkéntiFőosztályonkéntiLétszám01 INNER JOIN lkFőosztályonkéntiBetöltöttLétszám ON lkVárosKerületenkéntiFőosztályonkéntiLétszám01.Főosztály = lkFőosztályonkéntiBetöltöttLétszám.Főosztály;

#/#/#/
lkFőosztályokOsztályokSorszámal2
#/#/
SELECT lk_Főosztály_Osztály_lkSzemélyek.BFKH, lk_Főosztály_Osztály_lkSzemélyek.Főosztály, lk_Főosztály_Osztály_lkSzemélyek.Osztály, [lk_Főosztály_Osztály_lkSzemélyek].[Sorszám]*1 AS Sorszám INTO tFőosztályokOsztályokSorszámmal
FROM lk_Főosztály_Osztály_lkSzemélyek
WHERE (((lk_Főosztály_Osztály_lkSzemélyek.BFKH) Like "BFKH*"))
ORDER BY [lk_Főosztály_Osztály_lkSzemélyek].[Sorszám]*1;

#/#/#/
lkFőosztályokOsztályokSorszámmal
#/#/
SELECT tFőosztályokOsztályokSorszámmal.bfkh AS bfkhkód, tFőosztályokOsztályokSorszámmal.Főosztály, tFőosztályokOsztályokSorszámmal.Osztály, tFőosztályokOsztályokSorszámmal.Sorszám AS Sorsz
FROM tFőosztályokOsztályokSorszámmal;

#/#/#/
lkFőosztályonéntiOsztályonkéntiLétszám
#/#/
SELECT 1 AS sor, lkSzemélyek.BFKH, lkSzemélyek.Főosztály, Nz(Osztály,"-") AS Osztály_, Count(*) AS Létszám
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null))
GROUP BY 1, lkSzemélyek.BFKH, lkSzemélyek.Főosztály, Nz(Osztály,"-"), lkSzemélyek.FőosztályKód, lkSzemélyek.Osztály;

#/#/#/
lkFőosztályonkéntiBetöltöttLétszám
#/#/
SELECT lkSzemélyekFőosztÉsÖsszesen.Főosztály AS Főosztály, lkSzemélyekFőosztÉsÖsszesen.FőosztályiLétszám AS FőosztályiLétszám, [lk_TT-sekFőosztályonként].[Tartósan távollévők] AS [Tartósan távollévők], [Tartósan távollévők]/([FőosztályiLétszám]) AS [TT-sek aránya], lkSzemélyekFőosztÉsÖsszesen.KözpontosítottLétszám AS [Központosított létszám]
FROM [lk_TT-sekFőosztályonként] RIGHT JOIN lkSzemélyekFőosztÉsÖsszesen ON [lk_TT-sekFőosztályonként].Főosztály = lkSzemélyekFőosztÉsÖsszesen.Főosztály
ORDER BY [lkSzemélyekFőosztÉsÖsszesen].[Sor] & ".", lkSzemélyekFőosztÉsÖsszesen.FőosztKód;

#/#/#/
lkFőosztályonkéntiOsztályonkéntiLétszám_részösszegekkel
#/#/
SELECT [Sor] & "." AS Sorsz, UNIÓ.BFKH AS [Szervezeti egység kód], UNIÓ.Főosztály, UNIÓ.Osztály, UNIÓ.Létszám
FROM (SELECT 0 AS sor, bfkh(Nz(lkSzemélyek.FőosztályKód,0)) AS BFKH, lkSzemélyek.Főosztály, "Összesen:" AS Osztály, Count(*) AS Létszám
    FROM lkSzemélyek
    WHERE (((lkSzemélyek.[Státusz neve])="Álláshely"))
    GROUP BY 0, lkSzemélyek.Főosztály, lkSzemélyek.FőosztályKód, ""

    UNION
    SELECT 1 as sor, bfkh(Nz(lkSzemélyek.FőosztályKód,0)) AS BFKH, Főosztály,Osztály, Count(*) as Létszám
    FROM lkSzemélyek
    WHERE lkSzemélyek.[Státusz neve]="Álláshely"
    GROUP BY 1,bfkh(Nz(lkSzemélyek.FőosztályKód,0)) , lkSzemélyek.Főosztály,lkSzemélyek.FőosztályKód,Osztály
    )  AS UNIÓ
WHERE ((("/// Leírás: A megadott lekérdezés két SELECT utasítást kombinál az UNION használatával, hogy egyetlen eredménykészletet hozzon létre. 
        Az első SELECT kimutatás a főosztályonkénti (osztályvezetői), míg a második SELECT utasítás a BFKH-nként (osztályonkénti) és a 
        főosztályonkénti dolgozók számát számolja ki. 
        Az eredményül kapott adatkészlet tartalmazza a Sor (sorszám), Szervezeti egység kód (szervezeti egység kódja), Főosztály, 
        Osztály és Létszám (alkalmazottak száma) oszlopokat. 
        A végeredményt ezután a BFKH és a sor szerint csökkenő sorrendbe rendezi. ///")<>False))
ORDER BY UNIÓ.BFKH, UNIÓ.sor DESC , UNIÓ.Osztály;

#/#/#/
lkFőosztályOsztályNévIlletmény
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Illetmény összesen kerekítés nélkül (eltérített)] AS Illetmény, lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker] AS Óraszám, [Illetmény]/[Óraszám]*40 AS [40 órás illetmény], lkSzemélyek.[Tartós távollét típusa]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Tartós távollét típusa])="" Or (lkSzemélyek.[Tartós távollét típusa]) Is Null) AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY lkSzemélyek.BFKH;

#/#/#/
lkFőosztályvezetőkHivatalvezetők
#/#/
SELECT lkMindenVezető.Főosztály, lkMindenVezető.[Dolgozó teljes neve] AS Név, lkMindenVezető.Besorolás2
FROM lkMindenVezető
WHERE (((lkMindenVezető.Besorolás2)<>"osztályvezető" And (lkMindenVezető.Besorolás2) Not Like "*helyett*" And (lkMindenVezető.Besorolás2)<>"főispán" And (lkMindenVezető.Besorolás2) Not Like "*igazgató*"));

#/#/#/
lkFőosztOsztSzintűMobilitás_Befogadók
#/#/
SELECT tÁllományUnió20231231.[Járási Hivatal], tÁllományUnió20231231.Osztály, Count(tÁllományUnió20231231.Adóazonosító) AS [Létszám (fő)]
FROM tÁllományUnió20231231 INNER JOIN tÁllományUnió20230102 ON tÁllományUnió20231231.Adóazonosító = tÁllományUnió20230102.Adóazonosító
WHERE (((tÁllományUnió20231231.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ])<>[tÁllományUnió20230102].[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]) AND ((tÁllományUnió20231231.[Születési év \ üres állás])<>"üres állás"))
GROUP BY tÁllományUnió20231231.[Járási Hivatal], tÁllományUnió20231231.Osztály;

#/#/#/
lkFőosztOsztSzintűMobilitás_Kibocsátók
#/#/
SELECT tÁllományUnió20230102.[Járási Hivatal], tÁllományUnió20230102.Osztály, Count(tÁllományUnió20230102.Adóazonosító) AS [Létszám (fő)]
FROM tÁllományUnió20231231 INNER JOIN tÁllományUnió20230102 ON tÁllományUnió20231231.Adóazonosító = tÁllományUnió20230102.Adóazonosító
WHERE (((tÁllományUnió20230102.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ])<>tÁllományUnió20231231.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]) And ((tÁllományUnió20230102.[Születési év \ üres állás])<>"üres állás"))
GROUP BY tÁllományUnió20230102.[Járási Hivatal], tÁllományUnió20230102.Osztály;

#/#/#/
lkFőosztSzintűMobilitás_Befogadók
#/#/
SELECT tÁllományUnió20231231.[Járási Hivatal], Count(tÁllományUnió20231231.Adóazonosító) AS [Létszám (fő)]
FROM tÁllományUnió20231231 INNER JOIN tÁllományUnió20230102 ON tÁllományUnió20231231.Adóazonosító = tÁllományUnió20230102.Adóazonosító
WHERE (((tÁllományUnió20231231.[Járási Hivatal])<>[tÁllományUnió20230102].[Járási Hivatal]) AND ((tÁllományUnió20231231.[Születési év \ üres állás])<>"üres állás"))
GROUP BY tÁllományUnió20231231.[Járási Hivatal];

#/#/#/
lkFőosztSzintűMobilitás_Kibocsátók
#/#/
SELECT tÁllományUnió20230102.[Járási Hivatal], Count(tÁllományUnió20230102.Adóazonosító) AS [Létszám (fő)]
FROM tÁllományUnió20231231 INNER JOIN tÁllományUnió20230102 ON tÁllományUnió20231231.Adóazonosító = tÁllományUnió20230102.Adóazonosító
WHERE (((tÁllományUnió20230102.[Járási Hivatal])<>[tÁllományUnió20231231].[Járási Hivatal]) AND ((tÁllományUnió20230102.[Születési év \ üres állás])<>"üres állás"))
GROUP BY tÁllományUnió20230102.[Járási Hivatal];

#/#/#/
lkFunkciókSzerintiLétszámok01
#/#/
SELECT lkSzemélyek.Adójel, lkSzemélyek.Feladat, lkSzemélyek.[KIRA feladat megnevezés], IIf([Funkció]="-",IIf([Funkcionális]=True,"a) csoport","Egyéb (…) II"),[Funkció]) AS Funkciója, Choose(Left(IIf([Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis] Is Null Or [Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis]="",0,[Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis]),1)*1,"alapfokú","középfokú","felsőfokú","felsőfokú","középfokú","középfokú") AS Végzettség, IIf([lkSzemélyek].[Besorolás2] Like "*osztály*" Or [lkSzemélyek].[Besorolás2] Like "*járási*" Or [lkSzemélyek].[Besorolás2] Like "*igazgató*" Or [lkSzemélyek].[Besorolás2] Like "főispán","Vezetői létszám","Nem vezetői létszám") AS Vezető, 1 AS Létszám, lkSzemélyek.[jogviszony típusa / jogviszony típus] AS Jogviszony
FROM lkJárásiKormányKözpontosítottUnió RIGHT JOIN (tFunkcionálisSzakmaiFőosztályok RIGHT JOIN (lkFeladatKirafeladatFunkció RIGHT JOIN lkSzemélyek ON (lkFeladatKirafeladatFunkció.[KIRA feladat megnevezés] = lkSzemélyek.[KIRA feladat megnevezés]) AND (lkFeladatKirafeladatFunkció.Feladata = lkSzemélyek.Feladat)) ON tFunkcionálisSzakmaiFőosztályok.SzervezetKód = lkSzemélyek.FőosztályKód) ON lkJárásiKormányKözpontosítottUnió.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Tartós távollét típusa]) Is Null) AND ((lkSzemélyek.[Státusz típusa]) Not Like "Központosít*") AND ((lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó havi óraker])>=60) AND ((lkSzemélyek.[Státusz neve])="álláshely"));

#/#/#/
lkFunkciókSzerintiLétszámok02
#/#/
SELECT lkFunkciókSzerintiLétszámok01.Funkciója, lkFunkciókSzerintiLétszámok01.Végzettség, lkFunkciókSzerintiLétszámok01.Vezető, lkFunkciókSzerintiLétszámok01.Jogviszony AS Jogviszony, Sum(lkFunkciókSzerintiLétszámok01.Létszám) AS SumOfLétszám
FROM lkFunkciókSzerintiLétszámok01
GROUP BY lkFunkciókSzerintiLétszámok01.Funkciója, lkFunkciókSzerintiLétszámok01.Végzettség, lkFunkciókSzerintiLétszámok01.Vezető, lkFunkciókSzerintiLétszámok01.Jogviszony;

#/#/#/
lkFunkciókSzerintiLétszámok03
#/#/
SELECT lkFunkciókSzerintiLétszámok02.Funkciója, lkFunkciókSzerintiLétszámok02.Végzettség, lkFunkciókSzerintiLétszámok02.Vezető, lkFunkciókSzerintiLétszámok02.Jogviszony, lkFunkciókSzerintiLétszámok02.SumOfLétszám AS Létszám, Round([Létszám]*Nz([Engedélyezett létszám, ha semmi, akkor 5350],5350)/(Select sum([Létszám]) from lkFunkciókSzerintiLétszámok01),0) AS Statisztikai
FROM lkFunkciókSzerintiLétszámok02;

#/#/#/
lkGarantáltBérminimumEmelése
#/#/
PARAMETERS [Emelés%] IEEEDouble;
SELECT lkSzemélyek.Adójel, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Iskolai végzettség foka], lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker], [Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40 AS Illetmény40, (296400*(1+[Emelés%]/100))/[Illetmény40]-1 AS [Szükséges emelés], lkJárásiKormányKözpontosítottUnió.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h]
FROM lkSzemélyek INNER JOIN lkJárásiKormányKözpontosítottUnió ON lkSzemélyek.Adójel=lkJárásiKormányKözpontosítottUnió.Adójel
WHERE (((lkSzemélyek.[Iskolai végzettség foka])<>"Általános iskola 8 osztály") AND (([Kerekített 100 %-os illetmény (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40)<296400*(1+[Emelés%]/100)) AND ((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Jogviszony vége (kilépés dátuma)])>#7/1/2023# Or (lkSzemélyek.[Jogviszony vége (kilépés dátuma)]) Is Null));

#/#/#/
lkGyámügyiDolgozók
#/#/
SELECT lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[KIRA feladat megnevezés], lkSzemélyek.[Tartós távollét típusa], lkSzemélyek.[Tartós távollét vége], lkSzemélyek.[Tartós távollét tervezett vége]
FROM lkSzemélyek
WHERE (((lkSzemélyek.Főosztály) Like "*gyám*")) OR (((lkSzemélyek.Osztály) Like "*gyám*"))
ORDER BY lkSzemélyek.BFKH, lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkGyámügyiFőosztályDolgozói
#/#/
SELECT GyámDolgozók.Adójel, GyámDolgozók.Név, GyámDolgozók.[Jelenlegi főosztálya], GyámDolgozók.[Jelenlegi osztálya], GyámDolgozók.Főosztály, GyámDolgozók.Osztály, GyámDolgozók.Belépés, GyámDolgozók.Kilépés, Megjegyzés
FROM (SELECT lk2019ótaAGyámügyrőlKilépettek.*, "2019 óta kilépett" as Megjegyzés
FROM lk2019ótaAGyámügyrőlKilépettek
UNION SELECT lkAGyámonJelenlegDolgozók.*, "Jelenleg a Gymúgyi Főosztályon dolgozik" as Megjegyzés
FROM lkAGyámonJelenlegDolgozók
UNION SELECT lk2019ótaAGyámraBelépettek.*, "2019 óta lépett be" as Megjegyzés
FROM lk2019ótaAGyámraBelépettek)  AS GyámDolgozók
ORDER BY GyámDolgozók.Név, GyámDolgozók.Belépés;

#/#/#/
lkHASHCsere01
#/#/
PARAMETERS [Megtartandó szakaszok száma] Short, Lekérdezés Text ( 255 );
SELECT tRégiHibák.lekérdezésNeve, TextToMD5Hex(strVége([Második mező],"|",[megtartandó szakaszok száma])) AS ÚjHash, tRégiHibák.[Első Időpont], strVége([Második mező],"|",[megtartandó szakaszok száma]) AS [Új szöveg]
FROM tRégiHibák
WHERE (((tRégiHibák.lekérdezésNeve)=[lekérdezés]));

#/#/#/
lkHASHCsere02
#/#/
UPDATE lkHASHCsere01 INNER JOIN tRégiHibák ON lkHASHCsere01.ÚjHash = tRégiHibák.[Első mező] SET tRégiHibák.[Első Időpont] = [lkHASHCsere01].[Első Időpont];

#/#/#/
lkHatályIDDistinct
#/#/
SELECT DISTINCT lkÁllománytáblákTörténetiUniója.hatályaID
FROM lkÁllománytáblákTörténetiUniója;

#/#/#/
lkHatályUnion
#/#/
SELECT Kormányhivatali_állomány.HatályaID
FROM Kormányhivatali_állomány
UNION
SELECT Járási_állomány.HatályaID
FROM Járási_állomány
UNION
SELECT Központosítottak.HatályaID
FROM Központosítottak
UNION
SELECT Határozottak.HatályaID
FROM Határozottak
UNION
SELECT Belépők.HatályaID
FROM Belépők
UNION
SELECT Kilépők.HatályaID
FROM Kilépők
UNION
SELECT FedlaprólLétszámtábla.HatályaID
FROM FedlaprólLétszámtábla
UNION SELECT FedlaprólLétszámtábla2.HatályaID
FROM FedlaprólLétszámtábla2;

#/#/#/
lkHatályUnionCount
#/#/
SELECT Count(lkHatályUnion.HatályaID) AS Szám
FROM lkHatályUnion;

#/#/#/
lkHatározottak_TT
#/#/
SELECT Határozottak.[Tartós távollévő neve], Határozottak.Adóazonosító, Határozottak.[Megyei szint VAGY Járási Hivatal], Határozottak.Mező5, Határozottak.Mező6, Határozottak.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Határozottak.Mező8, Határozottak.[Besorolási fokozat kód:], Határozottak.[Besorolási fokozat megnevezése:], Határozottak.[Álláshely azonosító], Határozottak.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], Határozottak.[Tartós távollét kezdete], Határozottak.[Tartós távollét várható vége], Határozottak.[Tartósan távollévő illetményének teljes összege], "" AS Üres
FROM Határozottak;

#/#/#/
lkHatározottak_TTH
#/#/
SELECT Határozottak.[Tartós távollévő álláshelyén határozott időre foglalkoztatott ne], Határozottak.Mező17, Határozottak.Mező18, Határozottak.Mező19, Határozottak.Mező20, Határozottak.Mező21, Határozottak.Mező22, Határozottak.Mező23, Határozottak.Mező24, Határozottak.Mező25, Határozottak.[Tartós távollévő státuszán foglalkoztatott határozott idejű jogv], Határozottak.Mező27, Határozottak.[Tartós távollévő státuszán foglalkoztatott illetményének teljes ], "" AS Üres
FROM Határozottak;

#/#/#/
lkHatározottak_TTH_OsztályonkéntiLétszám
#/#/
SELECT lkHatározottak_TTH.Mező21 AS BFKH, IIf([Mező18]="megyei szint",[Mező19],[Mező18]) AS Főosztály, lkHatározottak_TTH.Mező20 AS Osztály, 0 AS [Betöltött létszám], 0 AS TTLétszám, Count(lkHatározottak_TTH.Mező17) AS HatározottLétszám, 0 AS Korr
FROM lkHatározottak_TTH
GROUP BY lkHatározottak_TTH.Mező21, IIf([Mező18]="megyei szint",[Mező19],[Mező18]), lkHatározottak_TTH.Mező20, 0, "", 0, 0, 0;

#/#/#/
lkHatározottak_TTH_Személytörzs_alapján
#/#/
SELECT lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Adójel, lkSzemélyek.[Szervezeti egység kódja], lkSzemélyek.[Besorolási  fokozat (KT)], lkSzemélyek.[Besorolási  fokozat (KT)], lkSzemélyek.[Státusz kódja], lkSzemélyek.[Helyettesített dolgozó neve], lkSzemélyek.[Helyettesített dolgozó szerződés/kinevezéses munkaköre] AS Kif1
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Helyettesített dolgozó neve]) Is Not Null));

#/#/#/
lkHatározottakÉsHelyettesek
#/#/
SELECT lkSzemélyek.[Szerződés/Kinevezés típusa], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Státusz kódja] AS ÁNYR, lkSzemélyek.[Besorolási  fokozat (KT)], lkSzemélyek.[Dolgozó teljes neve] AS Név, Trim([Előnév1] & " " & [Családi név1] & " " & [Utónév1]) AS [Helyettesített neve], lkSzemélyek.[Határozott idejű _szerződés/kinevezés lejár] AS [Határozott idő vége]
FROM BesorolásHelyettesített RIGHT JOIN lkSzemélyek ON BesorolásHelyettesített.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Szerződés/Kinevezés típusa])="határozott") AND ((lkSzemélyek.[KIRA jogviszony jelleg])="Kormányzati szolgálati jogviszony (KIT)") AND ((lkSzemélyek.[Státusz típusa])="Szervezeti alaplétszám")) OR (((lkSzemélyek.[KIRA jogviszony jelleg])="Kormányzati szolgálati jogviszony (KIT)") AND ((lkSzemélyek.[Státusz típusa])="Szervezeti alaplétszám") AND ((BesorolásHelyettesített.Adójel) Is Not Null))
ORDER BY lkSzemélyek.[Szerződés/Kinevezés típusa];

#/#/#/
lkháttértár_tBesorolásiEredményadatok_áttöltés
#/#/
INSERT INTO tBesorolásiEredményadatok IN 'L:\Ugyintezok\Adatszolgáltatók\Adatbázisok\Háttértárak\Ellenőrzés_0.9.6_háttér_.mdb.accdb'
SELECT [tBesorolásiEredményadatok_import].[Adóazonosító jel] AS [Adóazonosító jel], [tBesorolásiEredményadatok_import].[TAJ szám] AS [TAJ szám], [tBesorolásiEredményadatok_import].[Egyedi azonosító] AS [Egyedi azonosító], [tBesorolásiEredményadatok_import].[Törzsszám] AS Törzsszám, [tBesorolásiEredményadatok_import].[Előnév] AS Előnév, [tBesorolásiEredményadatok_import].[Családi név] AS [Családi név], [tBesorolásiEredményadatok_import].[Utónév] AS Utónév, [tBesorolásiEredményadatok_import].[Jogviszony ID] AS [Jogviszony ID], [tBesorolásiEredményadatok_import].[Kód] AS Kód, [tBesorolásiEredményadatok_import].[Megnevezés] AS Megnevezés, [tBesorolásiEredményadatok_import].[Kezdete] AS Kezdete, [tBesorolásiEredményadatok_import].[Vége] AS Vége, [tBesorolásiEredményadatok_import].[Változás dátuma] AS [Változás dátuma], [tBesorolásiEredményadatok_import].[Kezdete1] AS Kezdete1, [tBesorolásiEredményadatok_import].[Vége2] AS Vége2, [tBesorolásiEredményadatok_import].[Megnevezés3] AS Megnevezés3, [tBesorolásiEredményadatok_import].[Kezdete4] AS Kezdete4, [tBesorolásiEredményadatok_import].[Vége5] AS Vége5, [tBesorolásiEredményadatok_import].[Napi óra] AS [Napi óra], [tBesorolásiEredményadatok_import].[Heti óra] AS [Heti óra], [tBesorolásiEredményadatok_import].[Havi óra] AS [Havi óra], [tBesorolásiEredményadatok_import].[Kezdete6] AS Kezdete6, [tBesorolásiEredményadatok_import].[Vége7] AS Vége7, [tBesorolásiEredményadatok_import].[Típus] AS Típus, [tBesorolásiEredményadatok_import].[Jelleg] AS Jelleg, [tBesorolásiEredményadatok_import].[Kezdete8] AS Kezdete8, [tBesorolásiEredményadatok_import].[Vége9] AS Vége9, [tBesorolásiEredményadatok_import].[Besorolási fokozat] AS [Besorolási fokozat], [tBesorolásiEredményadatok_import].[Nem fogadta el a besorolást] AS [Nem fogadta el a besorolást], [tBesorolásiEredményadatok_import].[Kezdete10] AS Kezdete10, [tBesorolásiEredményadatok_import].[Vége11] AS Vége11, [tBesorolásiEredményadatok_import].[Kulcsszám] AS Kulcsszám, [tBesorolásiEredményadatok_import].[Besorolási osztály] AS [Besorolási osztály], [tBesorolásiEredményadatok_import].[Besorolási fokozat12] AS [Besorolási fokozat12], [tBesorolásiEredményadatok_import].[Következő besorolási fokozat dátum] AS [Következő besorolási fokozat dátum], [tBesorolásiEredményadatok_import].[Fiktív kulcsszám] AS [Fiktív kulcsszám], [tBesorolásiEredményadatok_import].[Fiktív besorolási osztály] AS [Fiktív besorolási osztály], [tBesorolásiEredményadatok_import].[Fiktív besorolási fokozat] AS [Fiktív besorolási fokozat], [tBesorolásiEredményadatok_import].[Fiktív következő besorolási fokozat dátum] AS [Fiktív következő besorolási fokozat dátum], [tBesorolásiEredményadatok_import].[Utolsó besorolás dátuma] AS [Utolsó besorolás dátuma], [tBesorolásiEredményadatok_import].[Kezdete13] AS Kezdete13, [tBesorolásiEredményadatok_import].[Vége14] AS Vége14, [tBesorolásiEredményadatok_import].[Eszmei fizetési fokozat idő] AS [Eszmei fizetési fokozat idő], [tBesorolásiEredményadatok_import].[Kezdete15] AS Kezdete15, [tBesorolásiEredményadatok_import].[Vége16] AS Vége16, [tBesorolásiEredményadatok_import].[Eszmei közszolgálati jogviszony idő] AS [Eszmei közszolgálati jogviszony idő], [tBesorolásiEredményadatok_import].[Kezdete17] AS Kezdete17, [tBesorolásiEredményadatok_import].[Vége18] AS Vége18, [tBesorolásiEredményadatok_import].[Közszolgálati jogviszony idő] AS [Közszolgálati jogviszony idő], [tBesorolásiEredményadatok_import].[Kezdete19] AS Kezdete19, [tBesorolásiEredményadatok_import].[Vége20] AS Vége20, [tBesorolásiEredményadatok_import].[Számított fizetési fokozat idő] AS [Számított fizetési fokozat idő], [tBesorolásiEredményadatok_import].[Kezdete21] AS Kezdete21, [tBesorolásiEredményadatok_import].[Vége22] AS Vége22, [tBesorolásiEredményadatok_import].[Szolgálati elismerés / Jubileum jutalom idő] AS [Szolgálati elismerés / Jubileum jutalom idő], [tBesorolásiEredményadatok_import].[Kezdete23] AS Kezdete23, [tBesorolásiEredményadatok_import].[Vége24] AS Vége24, [tBesorolásiEredményadatok_import].[Végkielégítésre jogosító idő] AS [Végkielégítésre jogosító idő], [tBesorolásiEredményadatok_import].[Kezdete25] AS Kezdete25, [tBesorolásiEredményadatok_import].[Vége26] AS Vége26, [tBesorolásiEredményadatok_import].[Szolgálati jogviszonyban eltöltött idő] AS [Szolgálati jogviszonyban eltöltött idő], [tBesorolásiEredményadatok_import].[Kezdete27] AS Kezdete27, [tBesorolásiEredményadatok_import].[Vége28] AS Vége28, [tBesorolásiEredményadatok_import].[Álláshelyi idő] AS [Álláshelyi idő], [tBesorolásiEredményadatok_import].[Kezdete29] AS Kezdete29, [tBesorolásiEredményadatok_import].[Vége30] AS Vége30, [tBesorolásiEredményadatok_import].[Saját munkahelyen eltöltött idő] AS [Saját munkahelyen eltöltött idő], [tBesorolásiEredményadatok_import].[Kezdete31] AS Kezdete31, [tBesorolásiEredményadatok_import].[Vége32] AS Vége32, [tBesorolásiEredményadatok_import].[Szakmai gyakorlat kezdő dátuma] AS [Szakmai gyakorlat kezdő dátuma], [tBesorolásiEredményadatok_import].[Kezdete33] AS Kezdete33, [tBesorolásiEredményadatok_import].[Vége34] AS Vége34, [tBesorolásiEredményadatok_import].[Alapilletmény] AS Alapilletmény, [tBesorolásiEredményadatok_import].[Garantált bérminimum] AS [Garantált bérminimum], [tBesorolásiEredményadatok_import].[Kerekítés] AS Kerekítés, [tBesorolásiEredményadatok_import].[Összesen] AS Összesen
FROM tBesorolásiEredményadatok_import;

#/#/#/
lkháttértár_tBesorolásiEredményadatok_törlő
#/#/
DELETE *
FROM tBesorolásiEredményadatok IN 'L:\Ugyintezok\Adatszolgáltatók\Adatbázisok\Háttértárak\Ellenőrzés_0.9.6_háttér_.mdb.accdb';

#/#/#/
lkháttértár_tElőzőMunkahelyek_törlő
#/#/
DELETE *
FROM tElőzőMunkahelyek IN 'L:\Ugyintezok\Adatszolgáltatók\Adatbázisok\Háttértárak\Ellenőrzés_0.9.6_háttér_.mdb.accdb';

#/#/#/
lkháttértár_tSzemélyek_áttöltés
#/#/
INSERT INTO tSzemélyek IN 'L:\Ugyintezok\Adatszolgáltatók\Adatbázisok\Háttértárak\Ellenőrzés_0.9.6_háttér_.mdb.accdb'
SELECT [tSzemélyek_import].[Adójel] AS Adójel, [tSzemélyek_import].[Dolgozó teljes neve] AS [Dolgozó teljes neve], [tSzemélyek_import].[Dolgozó születési neve] AS [Dolgozó születési neve], [tSzemélyek_import].[Születési idő] AS [Születési idő], [tSzemélyek_import].[Születési hely] AS [Születési hely], [tSzemélyek_import].[Anyja neve] AS [Anyja neve], [tSzemélyek_import].[Neme] AS Neme, [tSzemélyek_import].[Törzsszám] AS Törzsszám, [tSzemélyek_import].[Egyedi azonosító] AS [Egyedi azonosító], [tSzemélyek_import].[Adóazonosító jel] AS [Adóazonosító jel], [tSzemélyek_import].[TAJ szám] AS [TAJ szám], [tSzemélyek_import].[Ügyfélkapu kód] AS [Ügyfélkapu kód], [tSzemélyek_import].[Elsődleges állampolgárság] AS [Elsődleges állampolgárság], [tSzemélyek_import].[Személyi igazolvány száma] AS [Személyi igazolvány száma], dtÁtal([tSzemélyek_import].[Személyi igazolvány érvényesség kezdete]) AS [Személyi igazolvány érvényesség kezdete], [tSzemélyek_import].[Személyi igazolvány érvényesség vége] AS [Személyi igazolvány érvényesség vége], [tSzemélyek_import].[Nyelvtudás Angol] AS [Nyelvtudás Angol], [tSzemélyek_import].[Nyelvtudás Arab] AS [Nyelvtudás Arab], [tSzemélyek_import].[Nyelvtudás Bolgár] AS [Nyelvtudás Bolgár], [tSzemélyek_import].[Nyelvtudás Cigány] AS [Nyelvtudás Cigány], [tSzemélyek_import].[Nyelvtudás Cigány (lovári)] AS [Nyelvtudás Cigány (lovári)], [tSzemélyek_import].[Nyelvtudás Cseh] AS [Nyelvtudás Cseh], [tSzemélyek_import].[Nyelvtudás Eszperantó] AS [Nyelvtudás Eszperantó], [tSzemélyek_import].[Nyelvtudás Finn] AS [Nyelvtudás Finn], [tSzemélyek_import].[Nyelvtudás Francia] AS [Nyelvtudás Francia], [tSzemélyek_import].[Nyelvtudás Héber] AS [Nyelvtudás Héber], [tSzemélyek_import].[Nyelvtudás Holland] AS [Nyelvtudás Holland], [tSzemélyek_import].[Nyelvtudás Horvát] AS [Nyelvtudás Horvát], [tSzemélyek_import].[Nyelvtudás Japán] AS [Nyelvtudás Japán], [tSzemélyek_import].[Nyelvtudás Jelnyelv] AS [Nyelvtudás Jelnyelv], [tSzemélyek_import].[Nyelvtudás Kínai] AS [Nyelvtudás Kínai], [tSzemélyek_import].[Nyelvtudás Koreai] AS [Nyelvtudás Koreai], [tSzemélyek_import].[Nyelvtudás Latin] AS [Nyelvtudás Latin], [tSzemélyek_import].[Nyelvtudás Lengyel] AS [Nyelvtudás Lengyel], [tSzemélyek_import].[Nyelvtudás Német] AS [Nyelvtudás Német], [tSzemélyek_import].[Nyelvtudás Norvég] AS [Nyelvtudás Norvég], [tSzemélyek_import].[Nyelvtudás Olasz] AS [Nyelvtudás Olasz], [tSzemélyek_import].[Nyelvtudás Orosz] AS [Nyelvtudás Orosz], [tSzemélyek_import].[Nyelvtudás Portugál] AS [Nyelvtudás Portugál], [tSzemélyek_import].[Nyelvtudás Román] AS [Nyelvtudás Román], [tSzemélyek_import].[Nyelvtudás Spanyol] AS [Nyelvtudás Spanyol], [tSzemélyek_import].[Nyelvtudás Szerb] AS [Nyelvtudás Szerb], [tSzemélyek_import].[Nyelvtudás Szlovák] AS [Nyelvtudás Szlovák], [tSzemélyek_import].[Nyelvtudás Szlovén] AS [Nyelvtudás Szlovén], [tSzemélyek_import].[Nyelvtudás Török] AS [Nyelvtudás Török], [tSzemélyek_import].[Nyelvtudás Újgörög] AS [Nyelvtudás Újgörög], [tSzemélyek_import].[Nyelvtudás Ukrán] AS [Nyelvtudás Ukrán], [tSzemélyek_import].[Orvosi vizsgálat időpontja] AS [Orvosi vizsgálat időpontja], [tSzemélyek_import].[Orvosi vizsgálat típusa] AS [Orvosi vizsgálat típusa], [tSzemélyek_import].[Orvosi vizsgálat eredménye] AS [Orvosi vizsgálat eredménye], [tSzemélyek_import].[Orvosi vizsgálat észrevételek] AS [Orvosi vizsgálat észrevételek], [tSzemélyek_import].[Orvosi vizsgálat következő időpontja] AS [Orvosi vizsgálat következő időpontja], [tSzemélyek_import].[Erkölcsi bizonyítvány száma] AS [Erkölcsi bizonyítvány száma], [tSzemélyek_import].[Erkölcsi bizonyítvány dátuma] AS [Erkölcsi bizonyítvány dátuma], [tSzemélyek_import].[Erkölcsi bizonyítvány eredménye] AS [Erkölcsi bizonyítvány eredménye], [tSzemélyek_import].[Erkölcsi bizonyítvány kérelem azonosító] AS [Erkölcsi bizonyítvány kérelem azonosító], [tSzemélyek_import].[Erkölcsi bizonyítvány közügyektől eltiltva] AS [Erkölcsi bizonyítvány közügyektől eltiltva], [tSzemélyek_import].[Erkölcsi bizonyítvány járművezetéstől eltiltva] AS [Erkölcsi bizonyítvány járművezetéstől eltiltva], [tSzemélyek_import].[Erkölcsi bizonyítvány intézkedés alatt áll] AS [Erkölcsi bizonyítvány intézkedés alatt áll], [tSzemélyek_import].[Munkaköri leírások (csatolt dokumentumok fájlnevei)] AS [Munkaköri leírások (csatolt dokumentumok fájlnevei)], [tSzemélyek_import].[Egyéb HR dokumentumok (csatolt dokumentumok fájlnevei)] AS [Egyéb HR dokumentumok (csatolt dokumentumok fájlnevei)], [tSzemélyek_import].[Kormányhivatal rövid neve] AS [Kormányhivatal rövid neve], [tSzemélyek_import].[Szervezeti egység kódja] AS [Szervezeti egység kódja], [tSzemélyek_import].[Szervezeti egység neve] AS [Szervezeti egység neve], [tSzemélyek_import].[Szervezeti munkakör neve] AS [Szervezeti munkakör neve], [tSzemélyek_import].[Vezetői megbízás típusa] AS [Vezetői megbízás típusa], [tSzemélyek_import].[Státusz kódja] AS [Státusz kódja], [tSzemélyek_import].[Státusz költséghelyének kódja] AS [Státusz költséghelyének kódja], [tSzemélyek_import].[Státusz költséghelyének neve ] AS [Státusz költséghelyének neve ], [tSzemélyek_import].[Létszámon felül létrehozott státusz] AS [Létszámon felül létrehozott státusz], [tSzemélyek_import].[Státusz típusa] AS [Státusz típusa], [tSzemélyek_import].[Státusz neve] AS [Státusz neve], [tSzemélyek_import].[Többes betöltés] AS [Többes betöltés], [tSzemélyek_import].[Vezető neve] AS [Vezető neve], [tSzemélyek_import].[Vezető adóazonosító jele] AS [Vezető adóazonosító jele], [tSzemélyek_import].[Vezető email címe] AS [Vezető email címe], [tSzemélyek_import].[Állandó lakcím] AS [Állandó lakcím], [tSzemélyek_import].[Tartózkodási lakcím] AS [Tartózkodási lakcím], [tSzemélyek_import].[Levelezési cím_] AS [Levelezési cím_], [tSzemélyek_import].[Öregségi nyugdíj-korhatár elérésének időpontja (dátum)] AS [Öregségi nyugdíj-korhatár elérésének időpontja (dátum)], [tSzemélyek_import].[Nyugdíjas] AS Nyugdíjas, [tSzemélyek_import].[Nyugdíj típusa] AS [Nyugdíj típusa], [tSzemélyek_import].[Nyugdíjas korú továbbfoglalkoztatási engedéllyel rendelkezik] AS [Nyugdíjas korú továbbfoglalkoztatási engedéllyel rendelkezik], [tSzemélyek_import].[Megváltozott munkaképesség] AS [Megváltozott munkaképesség], [tSzemélyek_import].[Önkéntes tartalékos katona] AS [Önkéntes tartalékos katona], [tSzemélyek_import].[Utolsó vagyonnyilatkozat leadásának dátuma] AS [Utolsó vagyonnyilatkozat leadásának dátuma], [tSzemélyek_import].[Vagyonnyilatkozat nyilvántartási száma] AS [Vagyonnyilatkozat nyilvántartási száma], [tSzemélyek_import].[Következő vagyonnyilatkozat esedékessége] AS [Következő vagyonnyilatkozat esedékessége], [tSzemélyek_import].[Nemzetbiztonsági ellenőrzés dátuma] AS [Nemzetbiztonsági ellenőrzés dátuma], [tSzemélyek_import].[Védett állományba tartozó munkakör] AS [Védett állományba tartozó munkakör], [tSzemélyek_import].[Vezetői megbízás típusa1] AS [Vezetői megbízás típusa1], [tSzemélyek_import].[Vezetői beosztás megnevezése] AS [Vezetői beosztás megnevezése], [tSzemélyek_import].[Vezetői beosztás (megbízás) kezdete] AS [Vezetői beosztás (megbízás) kezdete], [tSzemélyek_import].[Vezetői beosztás (megbízás) vége] AS [Vezetői beosztás (megbízás) vége], [tSzemélyek_import].[Iskolai végzettség foka] AS [Iskolai végzettség foka], [tSzemélyek_import].[Iskolai végzettség neve] AS [Iskolai végzettség neve], dtÁtal([tSzemélyek_import].[Alapvizsga kötelezés dátuma]) AS [Alapvizsga kötelezés dátuma], [tSzemélyek_import].[Alapvizsga letétel tényleges határideje] AS [Alapvizsga letétel tényleges határideje], [tSzemélyek_import].[Alapvizsga mentesség] AS [Alapvizsga mentesség], [tSzemélyek_import].[Alapvizsga mentesség oka] AS [Alapvizsga mentesség oka], [tSzemélyek_import].[Szakvizsga kötelezés dátuma] AS [Szakvizsga kötelezés dátuma], [tSzemélyek_import].[Szakvizsga letétel tényleges határideje] AS [Szakvizsga letétel tényleges határideje], [tSzemélyek_import].[Szakvizsga mentesség] AS [Szakvizsga mentesség], [tSzemélyek_import].[Foglalkozási viszony] AS [Foglalkozási viszony], [tSzemélyek_import].[Foglalkozási viszony statisztikai besorolása] AS [Foglalkozási viszony statisztikai besorolása], [tSzemélyek_import].[Dolgozó szerződéses/kinevezéses munkaköre / kinevezési okmányban] AS [Dolgozó szerződéses/kinevezéses munkaköre / kinevezési okmányban], [tSzemélyek_import].[Beosztástervezés helyszínek] AS [Beosztástervezés helyszínek], [tSzemélyek_import].[Beosztástervezés tevékenységek] AS [Beosztástervezés tevékenységek], [tSzemélyek_import].[Részleges távmunka szerződés kezdete] AS [Részleges távmunka szerződés kezdete], [tSzemélyek_import].[Részleges távmunka szerződés vége] AS [Részleges távmunka szerződés vége], [tSzemélyek_import].[Részleges távmunka szerződés intervalluma] AS [Részleges távmunka szerződés intervalluma], [tSzemélyek_import].[Részleges távmunka szerződés mértéke] AS [Részleges távmunka szerződés mértéke], [tSzemélyek_import].[Részleges távmunka szerződés helyszíne] AS [Részleges távmunka szerződés helyszíne], [tSzemélyek_import].[Részleges távmunka szerződés helyszíne 2] AS [Részleges távmunka szerződés helyszíne 2], [tSzemélyek_import].[Részleges távmunka szerződés helyszíne 3] AS [Részleges távmunka szerződés helyszíne 3], [tSzemélyek_import].[Egyéni túlóra keret megállapodás kezdete] AS [Egyéni túlóra keret megállapodás kezdete], [tSzemélyek_import].[Egyéni túlóra keret megállapodás vége] AS [Egyéni túlóra keret megállapodás vége], [tSzemélyek_import].[Egyéni túlóra keret megállapodás mértéke] AS [Egyéni túlóra keret megállapodás mértéke], [tSzemélyek_import].[KIRA feladat azonosítója - intézmény prefix-szel ellátva] AS [KIRA feladat azonosítója - intézmény prefix-szel ellátva], [tSzemélyek_import].[KIRA feladat azonosítója] AS [KIRA feladat azonosítója], [tSzemélyek_import].[KIRA feladat megnevezés] AS [KIRA feladat megnevezés], [tSzemélyek_import].[Osztott munkakör] AS [Osztott munkakör], [tSzemélyek_import].[Funkciócsoport: kód-megnevezés] AS [Funkciócsoport: kód-megnevezés], [tSzemélyek_import].[Funkció: kód-megnevezés] AS [Funkció: kód-megnevezés], [tSzemélyek_import].[Dolgozó költséghelyének kódja] AS [Dolgozó költséghelyének kódja], [tSzemélyek_import].[Dolgozó költséghelyének neve] AS [Dolgozó költséghelyének neve], [tSzemélyek_import].[Feladatkör] AS Feladatkör, [tSzemélyek_import].[Elsődleges feladatkör] AS [Elsődleges feladatkör], [tSzemélyek_import].[Feladatok] AS Feladatok, [tSzemélyek_import].[FEOR] AS FEOR, [tSzemélyek_import].[Elméleti (szerződés/kinevezés szerinti) ledolgozandó napi óraker] AS [Elméleti (szerződés/kinevezés szerinti) ledolgozandó napi óraker], [tSzemélyek_import].[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker] AS [Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker], [tSzemélyek_import].[Elméleti (szerződés/kinevezés szerinti) ledolgozandó havi óraker] AS [Elméleti (szerződés/kinevezés szerinti) ledolgozandó havi óraker], [tSzemélyek_import].[Szerződés/Kinevezés típusa] AS [Szerződés/Kinevezés típusa], [tSzemélyek_import].[Iktatószám] AS Iktatószám, [tSzemélyek_import].[Szerződés/kinevezés verzió_érvényesség kezdete] AS [Szerződés/kinevezés verzió_érvényesség kezdete], dtÁtal([tSzemélyek_import].[Szerződés/kinevezés verzió_érvényesség vége]) AS [Szerződés/kinevezés verzió_érvényesség vége], [tSzemélyek_import].[Határozott idejű _szerződés/kinevezés lejár] AS [Határozott idejű _szerződés/kinevezés lejár], [tSzemélyek_import].[Szerződés dokumentum (csatolt dokumentumok fájlnevei)] AS [Szerződés dokumentum (csatolt dokumentumok fájlnevei)], [tSzemélyek_import].[Megjegyzés (pl# határozott szerződés/kinevezés oka)] AS [Megjegyzés (pl# határozott szerződés/kinevezés oka)], [tSzemélyek_import].[Munkavégzés helye - megnevezés] AS [Munkavégzés helye - megnevezés], [tSzemélyek_import].[Munkavégzés helye - cím] AS [Munkavégzés helye - cím], [tSzemélyek_import].[Jogviszony típusa / jogviszony típus] AS [Jogviszony típusa / jogviszony típus], [tSzemélyek_import].[Jogviszony sorszáma] AS [Jogviszony sorszáma], [tSzemélyek_import].[KIRA jogviszony jelleg] AS [KIRA jogviszony jelleg], [tSzemélyek_import].[Kölcsönbe adó cég] AS [Kölcsönbe adó cég], [tSzemélyek_import].[Teljesítményértékelés - Értékelő személy] AS [Teljesítményértékelés - Értékelő személy], [tSzemélyek_import].[Teljesítményértékelés - Érvényesség kezdet] AS [Teljesítményértékelés - Érvényesség kezdet], [tSzemélyek_import].[Teljesítményértékelés - Értékelt időszak kezdet] AS [Teljesítményértékelés - Értékelt időszak kezdet], [tSzemélyek_import].[Teljesítményértékelés - Értékelt időszak vége] AS [Teljesítményértékelés - Értékelt időszak vége], [tSzemélyek_import].[Teljesítményértékelés dátuma] AS [Teljesítményértékelés dátuma], [tSzemélyek_import].[Teljesítményértékelés - Beállási százalék] AS [Teljesítményértékelés - Beállási százalék], [tSzemélyek_import].[Teljesítményértékelés - Pontszám] AS [Teljesítményértékelés - Pontszám], [tSzemélyek_import].[Teljesítményértékelés - Megjegyzés] AS [Teljesítményértékelés - Megjegyzés], [tSzemélyek_import].[Dolgozói jellemzők] AS [Dolgozói jellemzők], [tSzemélyek_import].[Fizetési osztály (KA)/ Pedagógusi fokozat (KA pedagógus)/besorol] AS [Fizetési osztály (KA)/ Pedagógusi fokozat (KA pedagógus)/besorol], [tSzemélyek_import].[Besorolási  fokozat (KT)] AS [Besorolási  fokozat (KT)], [tSzemélyek_import].[Jogfolytonos idő kezdete] AS [Jogfolytonos idő kezdete], [tSzemélyek_import].[Jogviszony kezdete (belépés dátuma)] AS [Jogviszony kezdete (belépés dátuma)], dtÁtal([tSzemélyek_import].[Jogviszony vége (kilépés dátuma)]) AS [Jogviszony vége (kilépés dátuma)], [tSzemélyek_import].[Utolsó munkában töltött nap] AS [Utolsó munkában töltött nap], [tSzemélyek_import].[Kezdeményezés dátuma] AS [Kezdeményezés dátuma], [tSzemélyek_import].[Hatályossá válik] AS [Hatályossá válik], [tSzemélyek_import].[HR kapcsolat megszűnés módja (Kilépés módja)] AS [HR kapcsolat megszűnés módja (Kilépés módja)], [tSzemélyek_import].[HR kapcsolat megszűnes indoka (Kilépés indoka)] AS [HR kapcsolat megszűnes indoka (Kilépés indoka)], [tSzemélyek_import].[Indokolás] AS Indokolás, [tSzemélyek_import].[Következő munkahely] AS [Következő munkahely], [tSzemélyek_import].[MT: Felmondási idő kezdete KJT, KTTV: Felmentési idő kezdete] AS [MT: Felmondási idő kezdete KJT, KTTV: Felmentési idő kezdete], [tSzemélyek_import].[Felmondási idő vége (MT) Felmentési idő vége (KJT, KTTV)] AS [Felmondási idő vége (MT) Felmentési idő vége (KJT, KTTV)], [tSzemélyek_import].[Munkavégzés alóli mentesítés kezdete (KJT, KTTV) Felmentési idő ] AS [Munkavégzés alóli mentesítés kezdete (KJT, KTTV) Felmentési idő ], [tSzemélyek_import].[Munkavégzés alóli mentesítés vége (KJT, KTTV) Felmentési idő vég] AS [Munkavégzés alóli mentesítés vége (KJT, KTTV) Felmentési idő vég], [tSzemélyek_import].[Átmeneti eltérő foglalkoztatás típusa] AS [Átmeneti eltérő foglalkoztatás típusa], [tSzemélyek_import].[Átmeneti eltérő foglalkoztatás kezdete] AS [Átmeneti eltérő foglalkoztatás kezdete], [tSzemélyek_import].[Tartós távollét típusa] AS [Tartós távollét típusa], [tSzemélyek_import].[Tartós távollét kezdete] AS [Tartós távollét kezdete], [tSzemélyek_import].[Tartós távollét vége] AS [Tartós távollét vége], [tSzemélyek_import].[Tartós távollét tervezett vége] AS [Tartós távollét tervezett vége], [tSzemélyek_import].[Helyettesített dolgozó neve] AS [Helyettesített dolgozó neve], [tSzemélyek_import].[Szerződés/Kinevezés - próbaidő vége] AS [Szerződés/Kinevezés - próbaidő vége], [tSzemélyek_import].[Utalási cím] AS [Utalási cím], [tSzemélyek_import].[Alapilletmény / Munkabér / Megbízási díj (eltérítés nélküli)] AS [Alapilletmény / Munkabér / Megbízási díj (eltérítés nélküli)], [tSzemélyek_import].[Garantált bérminimumra történő kiegészítés] AS [Garantált bérminimumra történő kiegészítés], [tSzemélyek_import].[Kerekítés] AS Kerekítés, [tSzemélyek_import].[Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS % (eltérít] AS [Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS % (eltérít], [tSzemélyek_import].[Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS összeg (el] AS [Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS összeg (el], [tSzemélyek_import].[Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY % (eltérítés nélküli)] AS [Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY % (eltérítés nélküli)], [tSzemélyek_import].[Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY összeg (eltérítés nél] AS [Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY összeg (eltérítés nél], [tSzemélyek_import].[Egyéb pótlék - összeg (eltérítés nélküli)] AS [Egyéb pótlék - összeg (eltérítés nélküli)], [tSzemélyek_import].[Illetmény összesen kerekítés nélkül (eltérítés nélküli)] AS [Illetmény összesen kerekítés nélkül (eltérítés nélküli)], [tSzemélyek_import].[Kerekített 100 %-os illetmény (eltérítés nélküli)] AS [Kerekített 100 %-os illetmény (eltérítés nélküli)], [tSzemélyek_import].[Eltérítés %] AS [Eltérítés %], [tSzemélyek_import].[Alapilletmény / Munkabér / Megbízási díj (eltérített)] AS [Alapilletmény / Munkabér / Megbízási díj (eltérített)], [tSzemélyek_import].[Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS % (eltérí1] AS [Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS % (eltérí1], [tSzemélyek_import].[Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS összeg (e1] AS [Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS összeg (e1], [tSzemélyek_import].[Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY % (eltérített)] AS [Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY % (eltérített)], [tSzemélyek_import].[Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY összeg (eltérített)] AS [Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY összeg (eltérített)], [tSzemélyek_import].[Egyéb pótlék - összeg (eltérített)] AS [Egyéb pótlék - összeg (eltérített)], [tSzemélyek_import].[Illetmény összesen kerekítés nélkül (eltérített)] AS [Illetmény összesen kerekítés nélkül (eltérített)], [tSzemélyek_import].[Kerekített 100 %-os illetmény (eltérített)] AS [Kerekített 100 %-os illetmény (eltérített)], [tSzemélyek_import].[További munkavégzés helye 1 Teljes munkaidő %-a] AS [További munkavégzés helye 1 Teljes munkaidő %-a], [tSzemélyek_import].[További munkavégzés helye 2 Teljes munkaidő %-a] AS [További munkavégzés helye 2 Teljes munkaidő %-a], [tSzemélyek_import].[KT: Kerekített 100 %-os illetmény (eltérített) + Helyettesítési ] AS [KT: Kerekített 100 %-os illetmény (eltérített) + Helyettesítési ], [tSzemélyek_import].[Szint 1 szervezeti egység név] AS [Szint 1 szervezeti egység név], [tSzemélyek_import].[Szint 1 szervezeti egység kód] AS [Szint 1 szervezeti egység kód], [tSzemélyek_import].[Szint 2 szervezeti egység név] AS [Szint 2 szervezeti egység név], [tSzemélyek_import].[Szint 2 szervezeti egység kód] AS [Szint 2 szervezeti egység kód], [tSzemélyek_import].[Szint 3 szervezeti egység név] AS [Szint 3 szervezeti egység név], [tSzemélyek_import].[Szint 3 szervezeti egység kód] AS [Szint 3 szervezeti egység kód], [tSzemélyek_import].[Szint 4 szervezeti egység név] AS [Szint 4 szervezeti egység név], [tSzemélyek_import].[Szint 4 szervezeti egység kód] AS [Szint 4 szervezeti egység kód], [tSzemélyek_import].[Szint 5 szervezeti egység név] AS [Szint 5 szervezeti egység név], [tSzemélyek_import].[Szint 5 szervezeti egység kód] AS [Szint 5 szervezeti egység kód], [tSzemélyek_import].[Szint 6 szervezeti egység név] AS [Szint 6 szervezeti egység név], [tSzemélyek_import].[Szint 6 szervezeti egység kód] AS [Szint 6 szervezeti egység kód], [tSzemélyek_import].[Szint 7 szervezeti egység név] AS [Szint 7 szervezeti egység név], [tSzemélyek_import].[Szint 7 szervezeti egység kód] AS [Szint 7 szervezeti egység kód], [tSzemélyek_import].[Szint 8 szervezeti egység név] AS [Szint 8 szervezeti egység név], [tSzemélyek_import].[Szint 8 szervezeti egység kód] AS [Szint 8 szervezeti egység kód], [tSzemélyek_import].[AD egyedi azonosító] AS [AD egyedi azonosító], [tSzemélyek_import].[Hivatali email] AS [Hivatali email], [tSzemélyek_import].[Hivatali mobil] AS [Hivatali mobil], [tSzemélyek_import].[Hivatali telefon] AS [Hivatali telefon], [tSzemélyek_import].[Hivatali telefon mellék] AS [Hivatali telefon mellék], [tSzemélyek_import].[Iroda] AS Iroda, [tSzemélyek_import].[Otthoni e-mail] AS [Otthoni e-mail], [tSzemélyek_import].[Otthoni mobil] AS [Otthoni mobil], [tSzemélyek_import].[Otthoni telefon] AS [Otthoni telefon], [tSzemélyek_import].[További otthoni mobil] AS [További otthoni mobil]
FROM tSzemélyek_import;

#/#/#/
lkháttértár_tSzemélyek_törlő
#/#/
DELETE *
FROM tSzemélyek IN 'L:\Ugyintezok\Adatszolgáltatók\Adatbázisok\Háttértárak\Ellenőrzés_0.9.6_háttér_.mdb.accdb';

#/#/#/
lkHaviAdatszolgáltatásbólHiányzók
#/#/
SELECT lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Adóazonosító jel] AS Adóazonosító, Year([Születési idő]) AS [Születési év], IIf([lkszemélyek].[Neme]="nő",2,1) AS Nem, lkSzemélyek.Főosztály AS [Járási Hivatal], lkSzemélyek.Osztály, lkSzemélyek.[Szervezeti egység kódja], ffsplit([Feladatkör],"-",2) AS [Ellátott feladat], lkSzemélyek.[Szerződés/kinevezés verzió_érvényesség kezdete] AS Kinevezés, "SZ" AS [Feladat jellege], IIf([Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]=40,"T","R") AS Forma, lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker] AS [Heti munkaórák száma], 1 AS [Betöltés aránya], tBesorolás_átalakító.[Az álláshely jelölése], lkSzemélyek.Besorolás2 AS [Besorolási fokozat], lkÁlláshelyek.[Álláshely azonosító], lkSzemélyek.[Illetmény összesen kerekítés nélkül (eltérített)], "" AS [Eu finanszírozott], "" AS [Illetmény forrása], IIf(Len([Tartós távollét típusa])<1,"","TT") AS Kif1, lkSzemélyek.[Tartós távollét típusa], IIf([Szerződés/Kinevezés típusa]="határozatlan","HL","HT") AS Időtartam, tLegmagasabbVégzettség04.azFok AS [Végzettség foka], "" AS Kif2, lkSzemélyek.VégzettségFok, IIf([lkszemélyek].[Osztály] Like "*ablak*",Mid(Left([munkavégzés helye - cím],13),6,13) & " " & Mid([munkavégzés helye - cím],2,2),"") AS KAB
FROM (tLegmagasabbVégzettség04 RIGHT JOIN (lkSzemélyek RIGHT JOIN (lkJárásiKormányKözpontosítottUnió RIGHT JOIN lkÁlláshelyek ON lkJárásiKormányKözpontosítottUnió.[Álláshely azonosító] = lkÁlláshelyek.[Álláshely azonosító]) ON lkSzemélyek.[Státusz kódja] = lkÁlláshelyek.[Álláshely azonosító]) ON tLegmagasabbVégzettség04.[Dolgozó azonosító] = lkSzemélyek.[Adóazonosító jel]) LEFT JOIN tBesorolás_átalakító ON (lkSzemélyek.[Besorolási  fokozat (KT)] = tBesorolás_átalakító.Besorolási_fokozat) AND (lkSzemélyek.[Jogviszony típusa / jogviszony típus] = tBesorolás_átalakító.[Jogviszony típusa])
WHERE (((lkJárásiKormányKözpontosítottUnió.[Álláshely azonosító]) Is Null) AND ((tBesorolás_átalakító.Üres)=False))
ORDER BY lkSzemélyek.BFKH;

#/#/#/
lkHaviAdatszolgáltatásbólHiányzókNexonaz
#/#/
SELECT DISTINCT lkSzemélyekÉsNexonAz.azNexon
FROM lkSzemélyekÉsNexonAz INNER JOIN lkHaviAdatszolgáltatásbólHiányzók ON lkSzemélyekÉsNexonAz.[Adóazonosító jel] = lkHaviAdatszolgáltatásbólHiányzók.Adóazonosító
ORDER BY lkSzemélyekÉsNexonAz.azNexon;

#/#/#/
lkHavibólHiányzóÁlláshelyek
#/#/
SELECT lkÁlláshelyekHaviból.[Álláshely azonosító], lkÁlláshelyek.[Álláshely azonosító], lkÁlláshelyek.[Álláshely besorolási kategóriája]
FROM lkÁlláshelyek LEFT JOIN lkÁlláshelyekHaviból ON lkÁlláshelyek.[Álláshely azonosító] = lkÁlláshelyekHaviból.[Álláshely azonosító]
WHERE (((lkÁlláshelyekHaviból.[Álláshely azonosító]) Is Null));

#/#/#/
lkHaviJelentésHatálya
#/#/
SELECT TOP 1 IIf((Select TOP 1 [szám] from [lkHatályUnionCount])>1,'Hibás beolvasás!',[hatálya]) AS Hatály
FROM lkHatályUnion INNER JOIN tHaviJelentésHatálya ON lkHatályUnion.HatályaID = tHaviJelentésHatálya.hatályaID;

#/#/#/
lkHaviJelentésHatálya_utolsók
#/#/
SELECT tHaviJelentésHatálya1.hatályaID, tHaviJelentésHatálya1.hatálya, tHaviJelentésHatálya1.rögzítés AS [Utolsó rögzítés], tHaviJelentésHatálya1.fájlnév
FROM tHaviJelentésHatálya1 INNER JOIN lkHatályIDDistinct ON tHaviJelentésHatálya1.hatályaID = lkHatályIDDistinct.hatályaID
WHERE (((tHaviJelentésHatálya1.rögzítés)=(SELECT Max(TMP.rögzítés) FROM tHaviJelentésHatálya1 as TMP WHERE (((TMP.hatálya)=[tHaviJelentésHatálya1].[hatálya])))))
ORDER BY tHaviJelentésHatálya1.hatályaID;

#/#/#/
lkHaviJelentésHatályaAFileMezőAlapján
#/#/
SELECT TOP 1 thavijelentéshatálya.hatálya
FROM thavijelentéshatálya
WHERE (((thavijelentéshatálya.fájlnév)=[Űrlapok]![űFőmenü02]![File]))
ORDER BY thavijelentéshatálya.rögzítés DESC;

#/#/#/
lkHaviLétszám
#/#/
SELECT lkHaviLétszámUnió.BFKHKód, lkHaviLétszámUnió.Főosztály, lkHaviLétszámUnió.Osztály, Sum(lkHaviLétszámUnió.Betöltött) AS [Betöltött létszám], Sum(lkHaviLétszámUnió.Üres) AS [Üres álláshely], Sum(lkHaviLétszámUnió.TT) AS TT
FROM lkHaviLétszámUnió
GROUP BY lkHaviLétszámUnió.BFKHKód, lkHaviLétszámUnió.Főosztály, lkHaviLétszámUnió.Osztály, lkHaviLétszámUnió.Jelleg
ORDER BY bfkh([BFKHkód]);

#/#/#/
lkHaviLétszámFőosztály
#/#/
SELECT lkHaviLétszámUnió.Jelleg, lkHaviLétszámUnió.Főosztály, Sum(lkHaviLétszámUnió.Betöltött) AS [Betöltött létszám], Sum(lkHaviLétszámUnió.Üres) AS [Üres álláshely], Sum(lkHaviLétszámUnió.TT) AS TT
FROM lkHaviLétszámUnió
GROUP BY lkHaviLétszámUnió.Jelleg, lkHaviLétszámUnió.Főosztály;

#/#/#/
lkHaviLétszámJárási
#/#/
SELECT Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] AS BFKHKód, Replace([Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH") AS Főosztály, Járási_állomány.Mező7 AS Osztály, Sum(IIf([Mező4]="üres állás",0,[Mező14])) AS Betöltött, Sum(IIf([Mező4]="üres állás",[Mező14],0)) AS Üres, Járási_állomány.[Besorolási fokozat kód:], Sum(IIf([Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp] Is Null Or [Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp]="",0,[Mező14])) AS TT
FROM Járási_állomány
GROUP BY Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Replace([Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH"), Járási_állomány.Mező7, Járási_állomány.[Besorolási fokozat kód:];

#/#/#/
lkHaviLétszámKormányhivatali
#/#/
SELECT Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] AS BFKHKód, Kormányhivatali_állomány.Mező6 AS Főosztály, Kormányhivatali_állomány.Mező7 AS Osztály, Sum(IIf([Mező4]="üres állás",0,[Mező14])) AS Betöltött, Sum(IIf([Mező4]="üres állás",[Mező14],0)) AS Üres, Kormányhivatali_állomány.[Besorolási fokozat kód:], Sum(IIf([Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp] Is Null Or [Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp]="",0,[Mező14])) AS TT
FROM Kormányhivatali_állomány
GROUP BY Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Kormányhivatali_állomány.Mező6, Kormányhivatali_állomány.Mező7, Kormányhivatali_állomány.[Besorolási fokozat kód:];

#/#/#/
lkHaviLétszámKorrekció
#/#/
SELECT First(lkJárásiKormányUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]) AS BFKH, lkJárásiKormányUnió.[Járási Hivatal] AS Főosztály, lkJárásiKormányUnió.Osztály, 0 AS [Betöltött létszám], 0 AS TTLétszám, 0 AS HatározottLétszám, -([CountOfAdóazonosító]-1) AS Korr
FROM lkJárásiKormányUnió RIGHT JOIN lkJárásiKormányUnióDuplikátumok ON lkJárásiKormányUnió.Adóazonosító = lkJárásiKormányUnióDuplikátumok.Adóazonosító
GROUP BY lkJárásiKormányUnió.[Járási Hivatal], lkJárásiKormányUnió.Osztály, 0, -([CountOfAdóazonosító]-1), lkJárásiKormányUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], 0, 0, 0;

#/#/#/
lkHaviLétszámKözpontosított
#/#/
SELECT Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] AS BFKHKód, IIf([Megyei szint VAGY Járási Hivatal]="megyei szint",[Mező6],[Megyei szint VAGY Járási Hivatal]) AS Főosztály, Központosítottak.Mező7 AS Osztály, Sum(IIf([Mező4]="üres állás",0,[Mező13])) AS Betöltött, Sum(IIf([Mező4]="üres állás",[Mező13],0)) AS Üres, Központosítottak.[Besorolási fokozat kód:], Sum(IIf([Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp] Is Null Or [Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp]="",0,[Mező13])) AS TT
FROM Központosítottak
GROUP BY Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító], IIf([Megyei szint VAGY Járási Hivatal]="megyei szint",[Mező6],[Megyei szint VAGY Járási Hivatal]), Központosítottak.Mező7, Központosítottak.[Besorolási fokozat kód:];

#/#/#/
lkHaviLétszámUnió
#/#/
SELECT *, "A" as Jelleg
FROM  lkHaviLétszámKormányhivatali
UNION SELECT *, "A" as Jelleg
FROM lkHaviLétszámJárási
UNION SELECT *, "K" as Jelleg
FROM  lkHaviLétszámKözpontosított;

#/#/#/
lkHibákIntézkedésFajtánkéntiSzáma
#/#/
SELECT IIf([IntézkedésFajta] Is Null,"nem volt intézkedés",[IntézkedésFajta]) AS Fajta, Count(tRégiHibák.[Első mező]) AS [CountOfElső mező]
FROM tIntézkedésFajták RIGHT JOIN (tIntézkedések RIGHT JOIN (tRégiHibák LEFT JOIN ktRégiHibákIntézkedések ON tRégiHibák.[Első mező] = ktRégiHibákIntézkedések.HASH) ON tIntézkedések.azIntézkedések = ktRégiHibákIntézkedések.azIntézkedések) ON tIntézkedésFajták.azIntFajta = tIntézkedések.azIntFajta
WHERE ((((select max([utolsó időpont]) from tRégiHibák ))=[Utolsó Időpont]))
GROUP BY IIf([IntézkedésFajta] Is Null,"nem volt intézkedés",[IntézkedésFajta]);

#/#/#/
lkHibásKöltséghelyűStátuszok
#/#/
SELECT lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Státusz kódja], lkSzemélyek.[Dolgozó költséghelyének neve], lkSzemélyek.[Státusz költséghelyének neve ], tSzervezet_1.[Státuszának költséghely megnevezése], tSzervezet.[Költséghely megnevezés]
FROM (lkSzemélyek LEFT JOIN tSzervezet ON lkSzemélyek.[Státusz kódja] = tSzervezet.[Szervezetmenedzsment kód]) LEFT JOIN tSzervezet AS tSzervezet_1 ON lkSzemélyek.[Adóazonosító jel] = tSzervezet_1.[Szervezetmenedzsment kód]
WHERE (((lkSzemélyek.[Dolgozó költséghelyének neve])<>[tszervezet_1].[Státuszának költséghely megnevezése]) AND (([Dolgozó költséghelyének neve] Or [tszervezet].[Költséghely megnevezés] Or [tszervezet_1].[Státuszának költséghely megnevezése])=-1)) OR (((lkSzemélyek.[Dolgozó költséghelyének neve])<>[tszervezet].[Költséghely megnevezés]) AND (([Dolgozó költséghelyének neve] Or [tszervezet].[Költséghely megnevezés] Or [tszervezet_1].[Státuszának költséghely megnevezése])=-1)) OR (((tSzervezet_1.[Státuszának költséghely megnevezése])<>[tszervezet].[Költséghely megnevezés]) AND (([Dolgozó költséghelyének neve] Or [tszervezet].[Költséghely megnevezés] Or [tszervezet_1].[Státuszának költséghely megnevezése])=-1)) OR (((tSzervezet_1.[Státuszának költséghely megnevezése])<>[lkszemélyek].[Dolgozó költséghelyének neve]) AND (([Dolgozó költséghelyének neve] Or [tszervezet].[Költséghely megnevezés] Or [tszervezet_1].[Státuszának költséghely megnevezése])=-1)) OR (((tSzervezet.[Költséghely megnevezés])<>[lkszemélyek].[Dolgozó költséghelyének neve]) AND (([Dolgozó költséghelyének neve] Or [tszervezet].[Költséghely megnevezés] Or [tszervezet_1].[Státuszának költséghely megnevezése])=-1)) OR (((tSzervezet.[Költséghely megnevezés])<>[tszervezet_1].[Státuszának költséghely megnevezése]) AND (([Dolgozó költséghelyének neve] Or [tszervezet].[Költséghely megnevezés] Or [tszervezet_1].[Státuszának költséghely megnevezése])=-1));

#/#/#/
lkHibaVisszajelzéstKüldőkÉsVisszajelzéseikÖsszSzáma
#/#/
SELECT DISTINCT [Dolgozó teljes neve] & " (" & [SenderEmailAddress] & ")" AS Feladó, Count(tBejövőVisszajelzések.azVisszajelzés) AS [Visszajelzések száma]
FROM (lkSzemélyek INNER JOIN tBejövőÜzenetek ON lkSzemélyek.[Hivatali email] = tBejövőÜzenetek.SenderEmailAddress) INNER JOIN (tBejövőVisszajelzések INNER JOIN tVisszajelzésTípusok ON tBejövőVisszajelzések.VisszajelzésKód = tVisszajelzésTípusok.VisszajelzésKód) ON tBejövőÜzenetek.azÜzenet = tBejövőVisszajelzések.azÜzenet
WHERE (((tVisszajelzésTípusok.VisszajelzésTípusCsoport)=1) AND ((tBejövőÜzenetek.DeliveredDate) Between Date() And Date()-30))
GROUP BY [Dolgozó teljes neve] & " (" & [SenderEmailAddress] & ")"
ORDER BY Count(tBejövőVisszajelzések.azVisszajelzés) DESC;

#/#/#/
lkHibaVisszajelzéstKüldőkÉsVisszajelzéseikSzáma
#/#/
SELECT DISTINCT lkAzElmúltTízNap.Dátum, [Dolgozó teljes neve] & " (" & [SenderEmailAddress] & ")" AS Feladó, Count(tBejövőVisszajelzések.azVisszajelzés) AS [Visszajelzések száma]
FROM lkAzElmúltTízNap, (lkSzemélyek INNER JOIN tBejövőÜzenetek ON lkSzemélyek.[Hivatali email] = tBejövőÜzenetek.SenderEmailAddress) INNER JOIN (tBejövőVisszajelzések INNER JOIN tVisszajelzésTípusok ON tBejövőVisszajelzések.VisszajelzésKód = tVisszajelzésTípusok.VisszajelzésKód) ON tBejövőÜzenetek.azÜzenet = tBejövőVisszajelzések.azÜzenet
WHERE (((tBejövőÜzenetek.DeliveredDate)>=[Dátum] And (tBejövőÜzenetek.DeliveredDate)<[Dátum]+1) AND ((tVisszajelzésTípusok.VisszajelzésTípusCsoport)=1))
GROUP BY lkAzElmúltTízNap.Dátum, [Dolgozó teljes neve] & " (" & [SenderEmailAddress] & ")"
ORDER BY lkAzElmúltTízNap.Dátum DESC , Count(tBejövőVisszajelzések.azVisszajelzés) DESC;

#/#/#/
lkHozzátartozók
#/#/
SELECT tHozzátartozók.*, Nz([Dolgozó adóazonosító jele],0)*1 AS Adójel
FROM tHozzátartozók;

#/#/#/
lkHRvezetők
#/#/
SELECT 
FROM lkSzemélyek;

#/#/#/
lkIlletmények
#/#/
SELECT lkSzemélyek.Törzsszám, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, Álláshelyek.[Álláshely besorolási kategóriája], lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Illetmény összesen kerekítés nélkül (eltérített)] AS Illetmény, lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker] AS Óraszám, [Illetmény összesen kerekítés nélkül (eltérített)]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40 AS [40 órás illetmény], IIf(ffsplit([Feladatkör],"-",2)="",[Feladatkör],ffsplit([Feladatkör],"-",2)) AS Feladat, IIf(Nz([Tartós távollét típusa],"")="","","Igen") AS TT
FROM Álláshelyek INNER JOIN lkSzemélyek ON Álláshelyek.[Álláshely azonosító] = lkSzemélyek.[Státusz kódja]
WHERE (((IIf(Nz([Tartós távollét típusa],"")="","","Igen"))="" Or (IIf(Nz([Tartós távollét típusa],"")="","","Igen"))=IIf(Nz([A tartós távollévőket is belevegyük (Igen/Nem)],"Nem")="Igen","Igen","")) AND ((lkSzemélyek.[Státusz neve])="Álláshely"));

#/#/#/
lkIlletményekABottom30IlletménybenRészesülők
#/#/
SELECT DISTINCT lkIlletmények.Törzsszám, lkIlletmények.Főosztály, lkIlletmények.Osztály, lkIlletmények.Név, lkIlletmények.[40 órás illetmény], lkIlletmények.TT
FROM lkIlletmények LEFT JOIN lkIlletményekBottom30 ON lkIlletmények.[40 órás illetmény] = lkIlletményekBottom30.[40 órás illetmény]
WHERE (((lkIlletményekBottom30.[40 órás illetmény]) Is Not Null));

#/#/#/
lkIlletményekBottom30
#/#/
SELECT TOP 31 lkIlletmények.[40 órás illetmény]
FROM lkIlletmények
GROUP BY lkIlletmények.[40 órás illetmény]
ORDER BY lkIlletmények.[40 órás illetmény];

#/#/#/
lkIlletményekHavi
#/#/
SELECT Illetmény, Adójel, SzervezetKód
FROM (SELECT 'Járási_állomány' as Tábla, [Járási_állomány].[Mező18] as [Illetmény], (Nz([Adóazonosító],0)*1) As Adójel, [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]  as SzervezetKód
        FROM [Járási_állomány] 
        WHERE ([Járási_állomány].[Mező4]<> 'üres állás' OR [Járási_állomány].[Mező4] is null )  
    UNION 
    SELECT 'Kormányhivatali_állomány' as Tábla, [Kormányhivatali_állomány].[Mező18] as [Illetmény], (Nz([Adóazonosító],0)*1) As Adójel, [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] As SzervezetKód 
        FROM [Kormányhivatali_állomány] 
        WHERE ([Kormányhivatali_állomány].[Mező4]<> 'üres állás'  OR [Kormányhivatali_állomány].[Mező4] is null)  
    UNION 
    SELECT 'Központosítottak' as Tábla, [Központosítottak].[Mező17] as [Illetmény], (Nz([Adóazonosító],0)*1) As Adójel, [Nexon szótárelemnek megfelelő szervezeti egység azonosító] As SzervezetKód 
        FROM [Központosítottak] 
        WHERE ([Központosítottak].[Mező4]<> 'üres állás' OR [Központosítottak].[Mező4] is null  )  
)  AS IlletményUnió;

#/#/#/
lkIlletményekÖsszevetésPénzüggyel01
#/#/
SELECT DISTINCT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkIlletményekPÜ.Név, lkIlletményekPÜ.[Adóazonosító jel], lkIlletményekPÜ.[Átsorolás összesen] AS PGF, lkSzemélyek.[Kerekített 100 %-os illetmény (eltérített)] AS NEXON, lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker] AS [Heti óra], [Nexon]/[Heti óra]*40 AS [Nexon 40 óra], kt_azNexon_Adójel.Nlink AS Link, lkSzemélyek.[Státusz típusa], lkIlletményekPÜ.[Jogviszony, juttatás típusa]
FROM (lkIlletményekPÜ LEFT JOIN lkSzemélyek ON lkIlletményekPÜ.[Adóazonosító jel] = lkSzemélyek.Adójel) LEFT JOIN kt_azNexon_Adójel ON lkSzemélyek.Adójel = kt_azNexon_Adójel.Adójel
WHERE (((lkSzemélyek.[Státusz típusa]) Is Not Null) AND ((lkIlletményekPÜ.[Jogviszony, juttatás típusa])=20 Or (lkIlletményekPÜ.[Jogviszony, juttatás típusa])=6 Or (lkIlletményekPÜ.[Jogviszony, juttatás típusa])=18));

#/#/#/
lkIlletményekÖsszevetésPénzüggyel02
#/#/
SELECT DISTINCT lkIlletményekÖsszevetésPénzüggyel01.Főosztály, lkIlletményekÖsszevetésPénzüggyel01.Osztály, lkIlletményekÖsszevetésPénzüggyel01.Név, lkIlletményekÖsszevetésPénzüggyel01.PGF, lkIlletményekÖsszevetésPénzüggyel01.NEXON, lkIlletményekÖsszevetésPénzüggyel01.[Heti óra], lkIlletményekÖsszevetésPénzüggyel01.[Nexon 40 óra], lkIlletményekÖsszevetésPénzüggyel01.Link AS NLink
FROM lkIlletményekÖsszevetésPénzüggyel01
WHERE (((lkIlletményekÖsszevetésPénzüggyel01.NEXON)<>[PGF]));

#/#/#/
lkIlletményekPÜ
#/#/
SELECT tIlletmények.*, dtÁtal([Jv kezdete]) AS JogvKezdete, dtÁtal([Jv vége]) AS JogvVége
FROM tIlletmények
WHERE (((dtÁtal([Jv kezdete]))<=#11/30/2023# Or (dtÁtal([Jv kezdete])) Is Null) AND ((dtÁtal([Jv vége]))>="#2023. 11. 30.#" Or (dtÁtal([Jv vége])) Is Null));

#/#/#/
lkIlletményekVégzettségFokaSzerint
#/#/
SELECT lkSzemélyek.Főosztály, lkLegmagasabbVégzettség05.FirstOfazFok, Avg([KT: Kerekített 100 %-os illetmény (eltérített) + Helyettesítési ]/[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40) AS Illetmény, tVégzFok.Végzettségek
FROM tVégzFok INNER JOIN ((lkSzemélyek INNER JOIN lkLegmagasabbVégzettség05 ON lkSzemélyek.[Adóazonosító jel] = lkLegmagasabbVégzettség05.[Dolgozó azonosító]) LEFT JOIN lkMindenVezető ON lkSzemélyek.[Adóazonosító jel] = lkMindenVezető.[Adóazonosító jel]) ON tVégzFok.azFok = lkLegmagasabbVégzettség05.FirstOfazFok
WHERE (((lkSzemélyek.Főosztály) Like "Humán*") AND ((lkMindenVezető.[Adóazonosító jel]) Is Null) AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null) AND (("###### Ez a lekérdezés kommentje ######")<>False))
GROUP BY lkSzemélyek.Főosztály, lkLegmagasabbVégzettség05.FirstOfazFok, tVégzFok.Végzettségek;

#/#/#/
lkIlletményhezÁtlag_vezetőknélkül
#/#/
SELECT DISTINCT lkSzemélyek.*
FROM lkSzemélyek LEFT JOIN tBesorolás_átalakító ON lkSzemélyek.[Besorolási  fokozat (KT)] = tBesorolás_átalakító.Besorolási_fokozat
WHERE (((tBesorolás_átalakító.Vezető)=No) AND ((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null));

#/#/#/
lkIlletményLista
#/#/
SELECT [lkSzemélyek].[Kerekített 100 %-os illetmény (eltérített)]/[lkSzemélyek].[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40 AS Illetmény
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz neve])="álláshely") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null Or (lkSzemélyek.[Tartós távollét típusa])="") AND ((lkSzemélyek.[Jogviszony típusa / jogviszony típus])<>"Hivatásos állományú")) OR (((lkSzemélyek.[Jogviszony típusa / jogviszony típus])="Hivatásos állományú") AND ((lkSzemélyek.[Besorolási  fokozat (KT)])="Főosztályvezető"))
ORDER BY [lkSzemélyek].[Kerekített 100 %-os illetmény (eltérített)]/[lkSzemélyek].[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]*40;

#/#/#/
lkIlletményNöveléshezAdatok01
#/#/
SELECT kt_azNexon_Adójel.azNexon AS Az, lkSzemélyek.[Szervezeti egység kódja], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, IIf(Nz([besorolási  fokozat (KT)],"")="",[Tervezett betöltési adatok - Előmeneteli fokozat megnevezés],Nz([besorolási  fokozat (KT)],"")) AS Besorolás, lkSzemélyek.[Kerekített 100 %-os illetmény (eltérített)] AS [Jelenlegi illetmény], lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker] AS [Heti munkaidő], lkSzemélyek.[Jogviszony vége (kilépés dátuma)] AS Kilépés, 1 AS Fő
FROM (lkSzemélyek LEFT JOIN kt_azNexon_Adójel ON lkSzemélyek.Adójel=kt_azNexon_Adójel.Adójel) LEFT JOIN lkSzervezetÁlláshelyek ON lkSzemélyek.[Státusz kódja]=lkSzervezetÁlláshelyek.Álláshely
WHERE (((lkSzemélyek.[Jogviszony vége (kilépés dátuma)])>#6/13/2023# Or (lkSzemélyek.[Jogviszony vége (kilépés dátuma)]) Is Null) AND ((lkSzemélyek.[Státusz neve])="Álláshely"));

#/#/#/
lkIlletményNöveléshezAdatok02
#/#/
SELECT lkFőosztályok.[Szervezeti egység kódja], lkIlletményNöveléshezAdatok01.Főosztály, Sum(lkIlletményNöveléshezAdatok01.fő) AS [Főosztályi létszám]
FROM lkFőosztályok INNER JOIN lkIlletményNöveléshezAdatok01 ON lkFőosztályok.Főosztály=lkIlletményNöveléshezAdatok01.Főosztály
GROUP BY lkFőosztályok.[Szervezeti egység kódja], lkIlletményNöveléshezAdatok01.Főosztály;

#/#/#/
lkIlletményNöveléshezAdatok03
#/#/
SELECT lkIlletményNöveléshezAdatok01.Az, lkIlletményNöveléshezAdatok01.[Szervezeti egység kódja], lkIlletményNöveléshezAdatok01.Főosztály, lkIlletményNöveléshezAdatok01.Osztály, lkIlletményNöveléshezAdatok01.Név, lkIlletményNöveléshezAdatok01.Besorolás, lkIlletményNöveléshezAdatok01.[Jelenlegi illetmény], lkIlletményNöveléshezAdatok01.[Heti munkaidő], lkIlletményNöveléshezAdatok01.Kilépés, lkIlletményNöveléshezAdatok02.[Főosztályi létszám]
FROM lkIlletményNöveléshezAdatok02 RIGHT JOIN lkIlletményNöveléshezAdatok01 ON lkIlletményNöveléshezAdatok02.Főosztály=lkIlletményNöveléshezAdatok01.Főosztály
ORDER BY lkIlletményNöveléshezAdatok01.Főosztály;

#/#/#/
lkIlletményNöveléshezAdatokPénzügynek01
#/#/
SELECT kt_azNexon_Adójel.azNexon AS Az, lkSzemélyek.Adójel, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Státusz kódja], IIf(Nz([besorolási  fokozat (KT)],"")="",[Tervezett betöltési adatok - Előmeneteli fokozat megnevezés],Nz([besorolási  fokozat (KT)],"")) AS Besorolás, lkSzemélyek.[Státusz típusa], lkSzemélyek.[Foglalkozási viszony statisztikai besorolása], lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker] AS [Heti munkaidő], lkSzemélyek.[Szerződés/Kinevezés típusa], lkSzemélyek.[KIRA jogviszony jelleg], lkSzemélyek.[Jogviszony kezdete (belépés dátuma)], lkSzemélyek.[Jogviszony vége (kilépés dátuma)] AS Kilépés, lkSzemélyek.[Kerekített 100 %-os illetmény (eltérített)] AS [Jelenlegi illetmény], lkSzemélyek.[Tartós távollét típusa], lkSzemélyek.[Tartós távollét kezdete], lkSzemélyek.[Tartós távollét vége], lkSzemélyek.[Helyettesített dolgozó neve], 1 AS Fő, IIf([KIRA jogviszony jelleg]="Munkaviszony",True,False) AS Mt, IIf([KIRA jogviszony jelleg]="Munkaviszony",False,True) AS Kit, False AS Üres
FROM (lkSzemélyek LEFT JOIN kt_azNexon_Adójel ON lkSzemélyek.Adójel=kt_azNexon_Adójel.Adójel) LEFT JOIN lkSzervezetÁlláshelyek ON lkSzemélyek.[Státusz kódja]=lkSzervezetÁlláshelyek.Álláshely
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely"));

#/#/#/
lkIlletményNöveléshezAdatokPénzügynek02
#/#/
SELECT DISTINCT lkIlletményNöveléshezAdatokPénzügynek01.Adójel, lkIlletményNöveléshezAdatokPénzügynek01.Név, lkIlletményNöveléshezAdatokPénzügynek01.Főosztály, lkIlletményNöveléshezAdatokPénzügynek01.Osztály, lkIlletményNöveléshezAdatokPénzügynek01.[Státusz kódja], lkIlletményNöveléshezAdatokPénzügynek01.Besorolás, lkIlletményNöveléshezAdatokPénzügynek01.[Státusz típusa], lkIlletményNöveléshezAdatokPénzügynek01.[Foglalkozási viszony statisztikai besorolása], lkIlletményNöveléshezAdatokPénzügynek01.[Heti munkaidő], lkIlletményNöveléshezAdatokPénzügynek01.[Szerződés/Kinevezés típusa], lkIlletményNöveléshezAdatokPénzügynek01.[KIRA jogviszony jelleg], lkIlletményNöveléshezAdatokPénzügynek01.[Jogviszony kezdete (belépés dátuma)], lkIlletményNöveléshezAdatokPénzügynek01.Kilépés, lkIlletményNöveléshezAdatokPénzügynek01.[Tartós távollét típusa], lkIlletményNöveléshezAdatokPénzügynek01.[Tartós távollét kezdete], lkIlletményNöveléshezAdatokPénzügynek01.[Tartós távollét vége], lkIlletményNöveléshezAdatokPénzügynek01.[Helyettesített dolgozó neve], lkIlletményNöveléshezAdatokPénzügynek01.[Jelenlegi illetmény], "" AS [Javasolt emelés], "" AS [Új illetmény], tBesorolás_átalakító.[alsó határ], tBesorolás_átalakító.[felső határ], "" AS [alsó ellenőrzés], "" AS [felső ellenőrzés], "" AS kontroll, "" AS Megjegyzés
FROM tBesorolás_átalakító INNER JOIN lkIlletményNöveléshezAdatokPénzügynek01 ON (tBesorolás_átalakító.Besorolás = lkIlletményNöveléshezAdatokPénzügynek01.Besorolás) AND (tBesorolás_átalakító.Üres = lkIlletményNöveléshezAdatokPénzügynek01.Üres) AND (tBesorolás_átalakító.Kit = lkIlletményNöveléshezAdatokPénzügynek01.Kit) AND (tBesorolás_átalakító.Mt = lkIlletményNöveléshezAdatokPénzügynek01.Mt)
WHERE (((lkIlletményNöveléshezAdatokPénzügynek01.[Státusz típusa])="Szervezeti alaplétszám") AND ((lkIlletményNöveléshezAdatokPénzügynek01.Kilépés) Is Null Or (lkIlletményNöveléshezAdatokPénzügynek01.Kilépés)>#6/13/2023#))
ORDER BY lkIlletményNöveléshezAdatokPénzügynek01.Adójel;

#/#/#/
lkIlletményTörténet
#/#/
SELECT lkKormányhivataliJárásiKözpTörténet.Adójel, lkKormányhivataliJárásiKözpTörténet.[Heti munkaórák száma], lkKormányhivataliJárásiKözpTörténet.[Havi illetmény], lkKormányhivataliJárásiKözpTörténet.hatálya, lkKormányhivataliJárásiKözpTörténet.[Besorolási fokozat kód:], lkKormányhivataliJárásiKözpTörténet.[Besorolási fokozat megnevezése:]
FROM lkKormányhivataliJárásiKözpTörténet;

#/#/#/
lkIndítópulthozOldalakFejezetek
#/#/
SELECT tLekérdezésOsztályok.azOsztály, tLekérdezésOsztályok.Osztály, tLekérdezésOsztályok.TartalomIsmertető, tLekérdezésTípusok.LapNév, tLekérdezésTípusok.Megjegyzés
FROM tLekérdezésOsztályok INNER JOIN tLekérdezésTípusok ON tLekérdezésOsztályok.azOsztály = tLekérdezésTípusok.Osztály;

#/#/#/
lkInformatikaiSzakterületiFejlesztésNexius
#/#/
SELECT lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Hivatali email]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz neve])="álláshely"))
ORDER BY lkSzemélyek.BFKH;

#/#/#/
lkIntézkedések
#/#/
SELECT tIntézkedések.azIntézkedések, tIntézkedések.azIntFajta, tIntézkedések.IntézkedésDátuma, tIntézkedések.Hivatkozás, tIntézkedésFajták.IntézkedésFajta
FROM tIntézkedésFajták INNER JOIN tIntézkedések ON tIntézkedésFajták.azIntFajta = tIntézkedések.azIntFajta;

#/#/#/
lkJárási_állomány
#/#/
SELECT Járási_állomány.Sorszám, Járási_állomány.Név, Járási_állomány.Adóazonosító, Járási_állomány.Mező4 AS [Születési év \ üres állás], Járási_állomány.Mező5 AS Neme, Járási_állomány.[Járási Hivatal], Járási_állomány.Mező7 AS Osztály, "" AS Projekt, Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Járási_állomány.Mező9 AS [Ellátott feladat], Járási_állomány.Mező10 AS Kinevezés, Járási_állomány.[Feladat jellege: szakmai (SZ) / funkcionális (F) feladatellátás;], Járási_állomány.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ], Járási_állomány.[Heti munkaórák száma], Járási_állomány.Mező14 AS [Betöltés aránya], Járási_állomány.[Besorolási fokozat kód:], Járási_állomány.[Besorolási fokozat megnevezése:], Járási_állomány.[Álláshely azonosító], Járási_állomány.Mező18 AS [Havi illetmény], Járási_állomány.Mező19 AS [Eu finanszírozott], Járási_állomány.Mező20 AS [Illetmény forrása], Járási_állomány.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h], Járási_állomány.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], Járási_állomány.[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)], Járási_állomány.[Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis], Járási_állomány.[Ügyfélszolgálati munkatárs (1) ügyfélszolgálati háttér munkatárs], Járási_állomány.Mező26 AS [Képesítést adó végzettség], Járási_állomány.Mező27 AS KAB, Járási_állomány.[KAB 001-3** Branch ID]
FROM Járási_állomány;

#/#/#/
lkJárásiKormányKözpontosítottUnió
#/#/
SELECT LétszámUnió.Sorszám, LétszámUnió.Név, LétszámUnió.Adóazonosító, LétszámUnió.[Születési év \ üres állás], LétszámUnió.Neme, LétszámUnió.[Járási Hivatal], LétszámUnió.Osztály, LétszámUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], LétszámUnió.[Ellátott feladat], LétszámUnió.Kinevezés, LétszámUnió.[Feladat jellege: szakmai (SZ) / funkcionális (F) feladatellátás;], LétszámUnió.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ], LétszámUnió.[Heti munkaórák száma], LétszámUnió.[Betöltés aránya], LétszámUnió.[Besorolási fokozat kód:], LétszámUnió.[Besorolási fokozat megnevezése:], LétszámUnió.[Álláshely azonosító], LétszámUnió.[Havi illetmény], LétszámUnió.[Eu finanszírozott], LétszámUnió.[Illetmény forrása], LétszámUnió.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h], LétszámUnió.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], LétszámUnió.[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)], LétszámUnió.[Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis], LétszámUnió.[Ügyfélszolgálati munkatárs (1) ügyfélszolgálati háttér munkatárs], LétszámUnió.[Képesítést adó végzettség], LétszámUnió.KAB, LétszámUnió.[KAB 001-3** Branch ID], IIf([Adóazonosító] Is Null Or [Adóazonosító]="",0,[Adóazonosító]*1) AS Adójel, LétszámUnió.Jelleg, TextToMD5Hex([Álláshely azonosító]) AS Hash, Replace([Járási Hivatal],"budapest főváros kormányhivatala","BFKH") AS Főosztály, BFKH(LétszámUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]) AS BFKH
FROM (SELECT *, "A" as Jelleg
FROM lkJárási_állomány
UNION SELECT *, "A" as Jelleg
FROM lkKormányhivatali_állomány
UNION SELECT *, "K" as Jelleg
FROM lkKözpontosítottak
)  AS LétszámUnió;

#/#/#/
lkJárásiKormányKözpontosítottUnióFőosztKód
#/#/
SELECT lkJárásiKormányKözpontosítottUnió.*, bfkh(IIf([Járási Hivatal]=[Osztály] Or [Osztály] Is Null,[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ],strLevág([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ],".") & ".")) AS Főosztálykód
FROM lkJárásiKormányKözpontosítottUnió;

#/#/#/
lkJárásiKormányUnió
#/#/
SELECT AlaplétszámUnió.Sorszám, AlaplétszámUnió.Név, AlaplétszámUnió.Adóazonosító, AlaplétszámUnió.[Születési év \ üres állás], AlaplétszámUnió.Neme, AlaplétszámUnió.[Járási Hivatal], AlaplétszámUnió.Osztály, AlaplétszámUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], AlaplétszámUnió.[Ellátott feladat], AlaplétszámUnió.Kinevezés, AlaplétszámUnió.[Feladat jellege: szakmai (SZ) / funkcionális (F) feladatellátás;], AlaplétszámUnió.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ], AlaplétszámUnió.[Heti munkaórák száma], AlaplétszámUnió.[Betöltés aránya], AlaplétszámUnió.[Besorolási fokozat kód:], AlaplétszámUnió.[Besorolási fokozat megnevezése:], AlaplétszámUnió.[Álláshely azonosító], AlaplétszámUnió.[Havi illetmény], AlaplétszámUnió.[Eu finanszírozott], AlaplétszámUnió.[Illetmény forrása], AlaplétszámUnió.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h], AlaplétszámUnió.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], AlaplétszámUnió.[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)], AlaplétszámUnió.[Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis], AlaplétszámUnió.[Ügyfélszolgálati munkatárs (1) ügyfélszolgálati háttér munkatárs], AlaplétszámUnió.[Képesítést adó végzettség], AlaplétszámUnió.KAB, AlaplétszámUnió.[KAB 001-3** Branch ID], *
FROM (SELECT *
FROM lkJárási_állomány
UNION SELECT *
FROM lkKormányhivatali_állomány
)  AS AlaplétszámUnió;

#/#/#/
lkJárásiKormányUnióDuplikátumok
#/#/
SELECT lkJárásiKormányUnió.Adóazonosító, Count(lkJárásiKormányUnió.Adóazonosító) AS CountOfAdóazonosító
FROM lkJárásiKormányUnió
WHERE (((lkJárásiKormányUnió.Adóazonosító)<>""))
GROUP BY lkJárásiKormányUnió.Adóazonosító
HAVING Count(lkJárásiKormányUnió.Adóazonosító)>1;

#/#/#/
lkJárásiVezetőHelyettesekIlletménye
#/#/
SELECT lkJárásiVezetők.Kód, lkJárásiVezetők.[Dolgozó teljes neve], lkJárásiVezetők.Hivatal, lkJárásiVezetők.[Besorolási  fokozat (KT)], lkJárásiVezetők.[Kerekített 100 %-os illetmény (eltérített)] AS Illetmény
FROM lkJárásiVezetők
WHERE (((lkJárásiVezetők.[Besorolási  fokozat (KT)])="Járási / kerületi hivatal vezetőjének helyettese"));

#/#/#/
lkJárásiVezetők
#/#/
SELECT bfkh(Nz([Szervezeti egység kódja],"")) AS Kód, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Adóazonosító jel], lkSzemélyek.Főosztály AS Hivatal, lkSzemélyek.[Születési hely], lkSzemélyek.[Születési idő], lkSzemélyek.[Állandó lakcím], lkSzemélyek.[Tartózkodási lakcím], lkSzemélyek.[Besorolási  fokozat (KT)], lkSzemélyek.[Vezetői beosztás megnevezése], lkSzemélyek.[Kerekített 100 %-os illetmény (eltérített)]
FROM lkSzemélyek
WHERE (((lkSzemélyek.Főosztály) Like "BFKH*") AND ((lkSzemélyek.[Besorolási  fokozat (KT)]) Like "Járási*"))
ORDER BY bfkh(Nz([Szervezeti egység kódja],""));

#/#/#/
lkJav_táblák
#/#/
SELECT tJav_táblák.kód, tJav_táblák.Tábla, tJav_táblák.Ellenőrzéshez
FROM tJav_táblák;

#/#/#/
lkJogviszonybanEltöltöttLedolgozottIdő01
#/#/
SELECT Replace(Nz([lkSzemélyUtolsóSzervezetiEgysége].[Főosztály],""),"Budapest Főváros Kormányhivatala","BFKH") AS Főosztály_, lkSzemélyUtolsóSzervezetiEgysége.Osztály, DateDiff("d",[belépés],[kilépés]) AS [Eltelt idő], lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS Belépés, IIf([Jogviszony vége (kilépés dátuma)]=0,CDate(Now()),[Jogviszony vége (kilépés dátuma)]) AS Kilépés, lkSzemélyek.Adójel
FROM lkSzemélyUtolsóSzervezetiEgysége RIGHT JOIN lkSzemélyek ON lkSzemélyUtolsóSzervezetiEgysége.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)]) Between #1/1/2024# And CDate(Now())) AND ((lkSzemélyek.[Jogviszony típusa / jogviszony típus])<>"Személyes jelenlét" And (lkSzemélyek.[Jogviszony típusa / jogviszony típus])<>"Megbízásos"));

#/#/#/
lkJogviszonybanEltöltöttLedolgozottIdő02
#/#/
SELECT lkJogviszonybanEltöltöttLedolgozottIdő01.Főosztály_ AS Főosztály, Avg(lkJogviszonybanEltöltöttLedolgozottIdő01.[Eltelt idő]) AS [AvgOfEltelt idő], Count(lkJogviszonybanEltöltöttLedolgozottIdő01.Adójel) AS Létszám
FROM lkJogviszonybanEltöltöttLedolgozottIdő01
GROUP BY lkJogviszonybanEltöltöttLedolgozottIdő01.Főosztály_
ORDER BY Avg(lkJogviszonybanEltöltöttLedolgozottIdő01.[Eltelt idő]) DESC;

#/#/#/
lkJogviszonybanEltöltöttLedolgozottIdőStatisztika
#/#/
SELECT lkJogviszonybanEltöltöttLedolgozottIdő02.Főosztály, lkJogviszonybanEltöltöttLedolgozottIdő02.[AvgOfEltelt idő], lkJogviszonybanEltöltöttLedolgozottIdő02.Létszám AS [Belépők száma], lkHaviLétszámFőosztály.[Betöltött létszám] AS Összlétszám
FROM lkHaviLétszámFőosztály RIGHT JOIN lkJogviszonybanEltöltöttLedolgozottIdő02 ON lkHaviLétszámFőosztály.Főosztály = lkJogviszonybanEltöltöttLedolgozottIdő02.Főosztály
WHERE (((lkHaviLétszámFőosztály.Jelleg)="A" Or (lkHaviLétszámFőosztály.Jelleg) Is Null));

#/#/#/
lkJogviszonyok
#/#/
SELECT tIlletmények.*, [Adóazonosító jel]*1 AS Adójel
FROM tIlletmények;

#/#/#/
lkJogviszonyokÉsSzemélyekSzáma
#/#/
SELECT Egy.CountOfAzonosító AS [Jogviszonyok száma], Count(Egy.Adójel) AS [Érintett személyek száma]
FROM (SELECT DISTINCT tSzemélyek.Adójel, Count(tSzemélyek.Azonosító) AS CountOfAzonosító FROM tSzemélyek GROUP BY tSzemélyek.Adójel)  AS Egy
GROUP BY Egy.CountOfAzonosító;

#/#/#/
lkjogviszonytartam
#/#/
SELECT DISTINCT [Adóazonosító]*1 AS Adójel, lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS Belépés, IIf([Jogviszony vége (kilépés dátuma)]=0 Or [Jogviszony vége (kilépés dátuma)]>Date(),Date(),[Jogviszony vége (kilépés dátuma)]) AS Kilépés, [Kilépés]-[belépés] AS Tartam
FROM lkSzemélyek INNER JOIN tBelépők ON (tBelépők.[Jogviszony kezdő dátuma] = lkSzemélyek.[Jogviszony kezdete (belépés dátuma)]) AND (lkSzemélyek.[Adóazonosító jel] = tBelépők.Adóazonosító)
WHERE (((tBelépők.[Jogviszony kezdő dátuma])>#12/31/2022#));

#/#/#/
lkjogviszonytartam02
#/#/
SELECT Year([Belépés]) AS Év, lkSzemélyUtolsóSzervezetiEgysége.Főosztály, Count(lkSzemélyUtolsóSzervezetiEgysége.Adójel) AS CountOfAdójel
FROM lkjogviszonytartam INNER JOIN lkSzemélyUtolsóSzervezetiEgysége ON lkjogviszonytartam.Adójel = lkSzemélyUtolsóSzervezetiEgysége.Adójel
WHERE (((lkjogviszonytartam.Belépés)>=#1/1/2023#) AND ((lkjogviszonytartam.Kilépés)<Date()) AND ((lkjogviszonytartam.Tartam)<185))
GROUP BY Year([Belépés]), lkSzemélyUtolsóSzervezetiEgysége.Főosztály;

#/#/#/
lkJövőidejűEskükRögzítve
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], lkLejáróHatáridők.[Figyelendő dátum]
FROM lkSzemélyek LEFT JOIN lkLejáróHatáridők ON lkSzemélyek.[Adóazonosító jel] = lkLejáróHatáridők.[Adóazonosító jel]
WHERE (((lkLejáróHatáridők.[Figyelendő dátum])>Now()));

#/#/#/
lkKABdolgozók
#/#/
SELECT Replace([Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH") AS Hivatal, lkJárásiKormányKözpontosítottUnió.Osztály, lkJárásiKormányKözpontosítottUnió.Név, lkJárásiKormányKözpontosítottUnió.[Ellátott feladat]
FROM lkSzemélyek RIGHT JOIN lkJárásiKormányKözpontosítottUnió ON lkSzemélyek.[Adóazonosító jel] = lkJárásiKormányKözpontosítottUnió.Adóazonosító
WHERE (((lkJárásiKormányKözpontosítottUnió.Osztály) Like "*Személy*" Or (lkJárásiKormányKözpontosítottUnió.Osztály) Like "Kormányabla*" Or (lkJárásiKormányKözpontosítottUnió.Osztály) Like "*Okmány*") AND ((lkJárásiKormányKözpontosítottUnió.[Születési év \ üres állás])<>"üres állás"))
ORDER BY bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]);

#/#/#/
lkKABKormányablakVégzettségűek
#/#/
SELECT lkVégzettségek.Adójel, lkSzemélyek.BFKH, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkVégzettségek.[Végzettség neve], lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS Belépés, "" AS [Vizsga letétel terv határideje], "" AS [Vizsga letétel tény határideje], "" AS [Kötelezés dátuma]
FROM lkSzemélyek INNER JOIN lkVégzettségek ON lkSzemélyek.Adójel = lkVégzettségek.Adójel
WHERE (((lkVégzettségek.[Végzettség neve])="kormányablak ügyintézői vizsga (NKE)") AND ((lkSzemélyek.[Státusz neve])="Álláshely")) OR (((lkVégzettségek.[Végzettség neve])="kormányablak ügyintéző"))
ORDER BY lkSzemélyek.BFKH;

#/#/#/
lkKABKormányablakVizsgávalRendelkezők
#/#/
SELECT lkKözigazgatásiVizsga.Adójel, lkSzemélyek.BFKH, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkKözigazgatásiVizsga.[Vizsga típusa], lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS Belépés, lkKözigazgatásiVizsga.[Vizsga letétel terv határideje], lkKözigazgatásiVizsga.[Vizsga letétel tény határideje], lkKözigazgatásiVizsga.[Kötelezés dátuma]
FROM lkKözigazgatásiVizsga INNER JOIN lkSzemélyek ON lkKözigazgatásiVizsga.Adójel = lkSzemélyek.Adójel
WHERE (((lkKözigazgatásiVizsga.[Vizsga típusa])="KAB Kormányablak ügyintézői vizsg.") AND 


((([lkKözigazgatásiVizsga].[Vizsga eredménye] Is Null Or [lkKözigazgatásiVizsga].[Vizsga eredménye]="") 
And ([lkKözigazgatásiVizsga].[Oklevél száma] Is Null Or [lkKözigazgatásiVizsga].[Oklevél száma]="") 
And ([lkKözigazgatásiVizsga].[Oklevél dátuma] Is Null Or [lkKözigazgatásiVizsga].[Oklevél dátuma]=0))=False) 



AND (("####### Az Eredmény, az Oklevél száma vagy az oklevél dátuma közül legalább az egyik ki van töltve. ############")=True))
ORDER BY lkSzemélyek.BFKH;

#/#/#/
lkKABÜgyintézők
#/#/
SELECT [lkJárásiKormányKözpontosítottUnió].[Adóazonosító]*1 AS Adójel, bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]) AS BFKH, Replace([Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH") AS Hivatal, lkJárásiKormányKözpontosítottUnió.Osztály, lkJárásiKormányKözpontosítottUnió.Név, lkJárásiKormányKözpontosítottUnió.[Ellátott feladat], lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS Belépés, lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége] AS [Próbaidő vége], IIf([Tartós távollét típusa] Is Not Null,"Igen","Nem") AS Távollévő
FROM lkSzemélyek RIGHT JOIN lkJárásiKormányKözpontosítottUnió ON lkSzemélyek.[Adóazonosító jel] = lkJárásiKormányKözpontosítottUnió.Adóazonosító
WHERE (((lkJárásiKormányKözpontosítottUnió.Osztály) Like "*Személy*" Or (lkJárásiKormányKözpontosítottUnió.Osztály) Like "Kormányabla*" Or (lkJárásiKormányKözpontosítottUnió.Osztály) Like "*Okmány*") AND ((lkJárásiKormányKözpontosítottUnió.[Ellátott feladat])="Ügyfélszolgálati és kormányablak feladatok") AND ((lkJárásiKormányKözpontosítottUnió.[Születési év \ üres állás])<>"üres állás")) OR (((lkJárásiKormányKözpontosítottUnió.Osztály) Like "*Személy*" Or (lkJárásiKormányKözpontosítottUnió.Osztály) Like "Kormányabla*" Or (lkJárásiKormányKözpontosítottUnió.Osztály) Like "*Okmány*") AND ((lkJárásiKormányKözpontosítottUnió.[Ellátott feladat])="Okmányirodai feladatok") AND ((lkJárásiKormányKözpontosítottUnió.[Születési év \ üres állás])<>"üres állás")) OR (((lkJárásiKormányKözpontosítottUnió.Osztály) Like "*Személy*" Or (lkJárásiKormányKözpontosítottUnió.Osztály) Like "Kormányabla*" Or (lkJárásiKormányKözpontosítottUnió.Osztály) Like "*Okmány*") AND ((lkJárásiKormányKözpontosítottUnió.[Ellátott feladat])="Ügyfélszolgálati feladatok") AND ((lkJárásiKormányKözpontosítottUnió.[Születési év \ üres állás])<>"üres állás"))
ORDER BY bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]);

#/#/#/
lkKABÜgyintézőkIlletménye_eseti
#/#/
SELECT tBFKH([Járási Hivatal]) AS Hivatal, lkJárásiKormányKözpontosítottUnió.Osztály, [Név] & IIf([Besorolási fokozat kód:]="Ov."," (ov.)","") AS Neve, lkJárásiKormányKözpontosítottUnió.[Havi illetmény], lkJárásiKormányKözpontosítottUnió.[Heti munkaórák száma], tBesorolás_átalakító.[alsó határ], tBesorolás_átalakító.[felső határ]
FROM (lkSzemélyek RIGHT JOIN lkJárásiKormányKözpontosítottUnió ON lkSzemélyek.[Adóazonosító jel] = lkJárásiKormányKözpontosítottUnió.Adóazonosító) INNER JOIN tBesorolás_átalakító ON lkJárásiKormányKözpontosítottUnió.[Besorolási fokozat kód:] = tBesorolás_átalakító.[Az álláshely jelölése]
WHERE (((lkJárásiKormányKözpontosítottUnió.Osztály) Like "Kormányabla*") AND ((lkJárásiKormányKözpontosítottUnió.[Születési év \ üres állás])<>"üres állás")) OR (((lkJárásiKormányKözpontosítottUnió.Osztály) Like "Kormányabla*") AND ((lkJárásiKormányKözpontosítottUnió.[Születési év \ üres állás])<>"üres állás")) OR (((lkJárásiKormányKözpontosítottUnió.Osztály) Like "Kormányabla*") AND ((lkJárásiKormányKözpontosítottUnió.[Születési év \ üres állás])<>"üres állás"))
ORDER BY bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]), IIf([Besorolási fokozat kód:]="Ov.",0,1), [Név] & IIf([Besorolási fokozat kód:]="Ov."," (ov.)","");

#/#/#/
lkKABügyintézőkKormányirodaiLekérdezése
#/#/
SELECT "Budapest Főváros Kormányhivatala" AS Kormányhivatal, Replace([Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH") AS Hivatal, lkJárásiKormányKözpontosítottUnió.Osztály, lkSzervezetiEgységekLegnagyobbLétszámúTelephelyei.Cím, lkJárásiKormányKözpontosítottUnió.[Álláshely azonosító], lkJárásiKormányKözpontosítottUnió.Neme, lkJárásiKormányKözpontosítottUnió.[Besorolási fokozat megnevezése:], IIf([Szerződés/Kinevezés - próbaidő vége]>=Date(),"x","") AS [Próbaidejét tölti], "" AS Kormányablakban, lkJárásiKormányKözpontosítottUnió.Kinevezés
FROM lkSzervezetiEgységekLegnagyobbLétszámúTelephelyei RIGHT JOIN (lkSzemélyek RIGHT JOIN lkJárásiKormányKözpontosítottUnió ON lkSzemélyek.[Adóazonosító jel] = lkJárásiKormányKözpontosítottUnió.Adóazonosító) ON lkSzervezetiEgységekLegnagyobbLétszámúTelephelyei.BFKH = lkSzemélyek.BFKH
WHERE (((lkJárásiKormányKözpontosítottUnió.Osztály) Like "*Személy*" Or (lkJárásiKormányKözpontosítottUnió.Osztály) Like "Kormányabla*" Or (lkJárásiKormányKözpontosítottUnió.Osztály) Like "*Okmány*") AND ((lkJárásiKormányKözpontosítottUnió.[Besorolási fokozat megnevezése:]) Not Like "M*") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null) AND ((lkJárásiKormányKözpontosítottUnió.[Ellátott feladat])="Ügyfélszolgálati és kormányablak feladatok") AND ((lkJárásiKormányKözpontosítottUnió.[Születési év \ üres állás])<>"üres állás")) OR (((lkJárásiKormányKözpontosítottUnió.Osztály) Like "*Személy*" Or (lkJárásiKormányKözpontosítottUnió.Osztály) Like "Kormányabla*" Or (lkJárásiKormányKözpontosítottUnió.Osztály) Like "*Okmány*") AND ((lkJárásiKormányKözpontosítottUnió.[Besorolási fokozat megnevezése:]) Not Like "M*") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null) AND ((lkJárásiKormányKözpontosítottUnió.[Ellátott feladat])="Okmányirodai feladatok") AND ((lkJárásiKormányKözpontosítottUnió.[Születési év \ üres állás])<>"üres állás")) OR (((lkJárásiKormányKözpontosítottUnió.Osztály) Like "*Személy*" Or (lkJárásiKormányKözpontosítottUnió.Osztály) Like "Kormányabla*" Or (lkJárásiKormányKözpontosítottUnió.Osztály) Like "*Okmány*") AND ((lkJárásiKormányKözpontosítottUnió.[Besorolási fokozat megnevezése:]) Not Like "M*") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null) AND ((lkJárásiKormányKözpontosítottUnió.[Ellátott feladat])="Ügyfélszolgálati feladatok") AND ((lkJárásiKormányKözpontosítottUnió.[Születési év \ üres állás])<>"üres állás"))
ORDER BY bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]);

#/#/#/
lkKABVizsgaÉsVégzettség
#/#/
SELECT DISTINCT KABVizgaÉsKABVégzettségUnió.Adójel, KABVizgaÉsKABVégzettségUnió.BFKH, KABVizgaÉsKABVégzettségUnió.Főosztály, KABVizgaÉsKABVégzettségUnió.Osztály, KABVizgaÉsKABVégzettségUnió.Név, KABVizgaÉsKABVégzettségUnió.Belépés, KABVizgaÉsKABVégzettségUnió.[Vizsga letétel terv határideje], KABVizgaÉsKABVégzettségUnió.[Vizsga letétel tény határideje], KABVizgaÉsKABVégzettségUnió.[Kötelezés dátuma]
FROM (SELECT Adójel, lkKABKormányablakVégzettségűek.BFKH, lkKABKormányablakVégzettségűek.Főosztály, lkKABKormányablakVégzettségűek.Osztály, lkKABKormányablakVégzettségűek.Név, lkKABKormányablakVégzettségűek.Belépés,   [Vizsga letétel terv határideje],  [Vizsga letétel tény határideje],  [Kötelezés dátuma]
FROM lkKABKormányablakVégzettségűek
UNION
SELECT Adójel, lkKABKormányablakVizsgávalRendelkezők.BFKH, lkKABKormányablakVizsgávalRendelkezők.Főosztály, lkKABKormányablakVizsgávalRendelkezők.Osztály, lkKABKormányablakVizsgávalRendelkezők.Név, lkKABKormányablakVizsgávalRendelkezők.Belépés,   [Vizsga letétel terv határideje],  [Vizsga letétel tény határideje],  [Kötelezés dátuma]
FROM  lkKABKormányablakVizsgávalRendelkezők)  AS KABVizgaÉsKABVégzettségUnió;

#/#/#/
lkKABVizsgaHiány
#/#/
SELECT DISTINCT lkKABVizsgaHiány00.Főosztály, lkKABVizsgaHiány00.Osztály, lkKABVizsgaHiány00.[Dolgozó teljes neve], lkKABVizsgaHiány00.Belépés, lkKABVizsgaHiány00.NLink
FROM lkKABVizsgaHiány00;

#/#/#/
lkKABVizsgaHiány00
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS Belépés, kt_azNexon_Adójel02.NLink
FROM kt_azNexon_Adójel02 RIGHT JOIN (lkKözigazgatásiVizsga RIGHT JOIN lkSzemélyek ON lkKözigazgatásiVizsga.Adójel = lkSzemélyek.Adójel) ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.Osztály) Like "Kormányablak Osztály*") AND ((lkKözigazgatásiVizsga.[Vizsga típusa])="KAB Kormányablak ügyintézői vizsg." Or (lkKözigazgatásiVizsga.[Vizsga típusa]) Is Null) AND ((lkKözigazgatásiVizsga.Mentesség)=False Or (lkKözigazgatásiVizsga.Mentesség) Is Null) AND ((lkKözigazgatásiVizsga.[Oklevél száma]) Is Null Or (lkKözigazgatásiVizsga.[Oklevél száma])="") AND ((lkSzemélyek.[Jogviszony típusa / jogviszony típus]) Like "ko*"))
ORDER BY lkSzemélyek.BFKH;

#/#/#/
lkKABvizsgávalNemRendelkezőKABÜgyintézők
#/#/
SELECT lkKABÜgyintézők.Hivatal, lkKABÜgyintézők.Osztály, lkKABÜgyintézők.Név, lkKABÜgyintézők.[Ellátott feladat], lkKABÜgyintézők.[Próbaidő vége], (SELECT DISTINCT TOP 1
 Tmp1.[Vizsga letétel terv határideje]
    FROM lkKözigazgatásiVizsga as Tmp1
    WHERE Tmp1.[Vizsga típusa]="KAB Kormányablak ügyintézői vizsg."
        AND
               Tmp1.Adójel = lkKABÜgyintézők.Adójel
    ORDER BY  Tmp1.[Vizsga letétel terv határideje] Desc
) AS VizsgaTervHatárideje, (SELECT DISTINCT TOP 1
  Tmp1.[Vizsga letétel tény határideje]
    FROM lkKözigazgatásiVizsga as Tmp1
    WHERE Tmp1.[Vizsga típusa]="KAB Kormányablak ügyintézői vizsg."
        AND
               Tmp1.Adójel = lkKABÜgyintézők.Adójel
    ORDER BY Tmp1.[Vizsga letétel tény határideje] DESC
) AS VizsgaTényHatárideje, (SELECT DISTINCT TOP 1
  Tmp1.[Kötelezés dátuma]
    FROM lkKözigazgatásiVizsga as Tmp1
    WHERE Tmp1.[Vizsga típusa]="KAB Kormányablak ügyintézői vizsg."
        AND
               Tmp1.Adójel = lkKABÜgyintézők.Adójel
    ORDER BY   Tmp1.[Kötelezés dátuma] DESC
) AS KötelezésDátuma
FROM lkKABÜgyintézők LEFT JOIN lkKABVizsgaÉsVégzettség ON lkKABÜgyintézők.Adójel = lkKABVizsgaÉsVégzettség.Adójel
WHERE (((lkKABÜgyintézők.Távollévő)="Nem") AND ((lkKABVizsgaÉsVégzettség.Adójel) Is Null))
ORDER BY lkKABÜgyintézők.BFKH;

#/#/#/
lkKABvizsgávalNemRendelkezőKABÜgyintézőkSzáma
#/#/
SELECT 1 as sor, Count(lkKABvizsgávalNemRendelkezőKABÜgyintézők.Adójel) AS Létszám, Sum(IIf([Távollévő]="IGEN",1,0)) AS [Tartós távollévő], Létszám -[Tartós távollévő] as Összesen
FROM lkKABvizsgávalNemRendelkezőKABÜgyintézők
UNION
SELECT 2 as sor, Count(lkKABvizsgávalNemRendelkezőKABÜgyintézők.Adójel) AS Létszám, Sum(IIf([Távollévő]="IGEN",1,0)) AS [Tartós távollévő], Létszám -[Tartós távollévő]
FROM lkKABvizsgávalNemRendelkezőKABÜgyintézők
WHERE (((lkKABvizsgávalNemRendelkezőKABÜgyintézők.[Próbaidő vége])<=#7/1/2024#))
UNION SELECT 3 as sor, Count(lkKABvizsgávalNemRendelkezőKABÜgyintézők.Adójel) AS Létszám, Sum(IIf([Távollévő]="IGEN",1,0)) AS [Tartós távollévő], Létszám -[Tartós távollévő]
FROM lkKABvizsgávalNemRendelkezőKABÜgyintézők
WHERE (((lkKABvizsgávalNemRendelkezőKABÜgyintézők.Belépés)>=#1/1/2022#) AND ((lkKABvizsgávalNemRendelkezőKABÜgyintézők.[Próbaidő vége])<=#7/1/2024#));

#/#/#/
lkKabvizsgávalNemRendelkezőkListája
#/#/
SELECT lkKABvizsgávalNemRendelkezőKABÜgyintézők.Hivatal, lkKABvizsgávalNemRendelkezőKABÜgyintézők.Osztály, kt_azNexon_Adójel02.NLink, lkKABvizsgávalNemRendelkezőKABÜgyintézők.[Ellátott feladat], IIf([lkKABvizsgávalNemRendelkezőKABÜgyintézők]![Próbaidő vége] Is Not Null,"Próbaidő vége:" & [lkKABvizsgávalNemRendelkezőKABÜgyintézők]![Próbaidő vége] & "," & Chr(13) & Chr(10),"") & IIf([lkKABvizsgávalNemRendelkezőKABÜgyintézők]![Távollévő] Is Not Null,"Távollévő:" & [lkKABvizsgávalNemRendelkezőKABÜgyintézők]![Távollévő] & "," & Chr(13) & Chr(10),"") & IIf([lkKABvizsgávalNemRendelkezőKABÜgyintézők]![VizsgaTervHatárideje] Is Not Null,"A vizsga tervezett határideje:" & [lkKABvizsgávalNemRendelkezőKABÜgyintézők]![VizsgaTervHatárideje] & "," & Chr(13) & Chr(10),"") & IIf([lkKABvizsgávalNemRendelkezőKABÜgyintézők]![VizsgaTényHatárideje] Is Not Null,"A vizsga ténylegs határideje:" & [lkKABvizsgávalNemRendelkezőKABÜgyintézők]![VizsgaTényHatárideje] & "," & Chr(13) & Chr(10),"") & IIf([lkKABvizsgávalNemRendelkezőKABÜgyintézők]![KötelezésDátuma] Is Not Null,"A kötelezés dátuma:" & [lkKABvizsgávalNemRendelkezőKABÜgyintézők]![KötelezésDátuma],"") AS Megj
FROM kt_azNexon_Adójel02 RIGHT JOIN lkKABvizsgávalNemRendelkezőKABÜgyintézők ON kt_azNexon_Adójel02.Adójel = lkKABvizsgávalNemRendelkezőKABÜgyintézők.Adójel
ORDER BY lkKABvizsgávalNemRendelkezőKABÜgyintézők.BFKH;

#/#/#/
lkKABvizsgávalRendelkezőKABÜgyintézők
#/#/
SELECT lkKABÜgyintézők.BFKH, "Budapest Főváros Kormányhivatala" AS Kormányhivatal, lkKABÜgyintézők.Hivatal, lkKABÜgyintézők.Osztály, lkKABÜgyintézők.Adójel, lkKABÜgyintézők.Név, lkKABÜgyintézők.[Ellátott feladat], lkKABÜgyintézők.Belépés, lkKABÜgyintézők.[Próbaidő vége], lkKABÜgyintézők.Távollévő, (SELECT DISTINCT TOP 1
 Tmp1.[Vizsga letétel terv határideje]
    FROM lkKözigazgatásiVizsga as Tmp1
    WHERE Tmp1.[Vizsga típusa]="KAB Kormányablak ügyintézői vizsg."
        AND
               Tmp1.Adójel = lkKABÜgyintézők.Adójel
    ORDER BY  Tmp1.[Vizsga letétel terv határideje] Desc
) AS VizsgaTervHatárideje, (SELECT DISTINCT TOP 1
  Tmp1.[Vizsga letétel tény határideje]
    FROM lkKözigazgatásiVizsga as Tmp1
    WHERE Tmp1.[Vizsga típusa]="KAB Kormányablak ügyintézői vizsg."
        AND
               Tmp1.Adójel = lkKABÜgyintézők.Adójel
    ORDER BY Tmp1.[Vizsga letétel tény határideje] DESC
) AS VizsgaTényHatárideje, (SELECT DISTINCT TOP 1
  Tmp1.[Kötelezés dátuma]
    FROM lkKözigazgatásiVizsga as Tmp1
    WHERE Tmp1.[Vizsga típusa]="KAB Kormányablak ügyintézői vizsg."
        AND
               Tmp1.Adójel = lkKABÜgyintézők.Adójel
    ORDER BY   Tmp1.[Kötelezés dátuma] DESC
) AS KötelezésDátuma
FROM lkKABÜgyintézők INNER JOIN lkKABVizsgaÉsVégzettség ON lkKABÜgyintézők.Adójel = lkKABVizsgaÉsVégzettség.Adójel
WHERE (((lkKABVizsgaÉsVégzettség.Adójel) Is Null));

#/#/#/
lkKABvizsgávalRendelkezőKABÜgyintézőkSzámaOsztályonként
#/#/
SELECT lkKABvizsgávalRendelkezőKABÜgyintézők.BFKH, lkKABvizsgávalRendelkezőKABÜgyintézők.Kormányhivatal, lkKABvizsgávalRendelkezőKABÜgyintézők.Hivatal, lkKABvizsgávalRendelkezőKABÜgyintézők.Osztály, Count(lkKABvizsgávalRendelkezőKABÜgyintézők.Adójel) AS [KAB vizsgával rendelkezők]
FROM lkKABvizsgávalRendelkezőKABÜgyintézők
WHERE (((lkKABvizsgávalRendelkezőKABÜgyintézők.Távollévő)="Nem"))
GROUP BY lkKABvizsgávalRendelkezőKABÜgyintézők.BFKH, lkKABvizsgávalRendelkezőKABÜgyintézők.Kormányhivatal, lkKABvizsgávalRendelkezőKABÜgyintézők.Hivatal, lkKABvizsgávalRendelkezőKABÜgyintézők.Osztály;

#/#/#/
lkKEHIOrvosiAlkalmasságik2024_09_2024_12
#/#/
SELECT 789235 AS [PIR törzsszám], "Budapest Főváros Kormányhivatala" AS [kormányzati igazgatási szerv neve], [lkSzemélyUtolsóSzervezetiEgysége].[Főosztály] & " " & [lkSzemélyUtolsóSzervezetiEgysége].[osztály] AS [szervezeti egység neve], lkSzemélyek.[Dolgozó teljes neve] AS [családi és utónév], lkSzemélyek.Adójel AS [adóazonosító jel], Mid([Elsődleges feladatkör],InStr(Nz([elsődleges Feladatkör],""),"-")+1) AS [munkakör / feladatkör megnevezése], lkSzemélyUtolsóSzervezetiEgysége.ÁNYR AS [álláshely ÁNYR azonosító száma], lkSzervezetiÁlláshelyek.[Tervezett betöltési adatok - Előmeneteli fokozat megnevezés] AS [az álláshely besorolása], lkSzemélyek.[Jogviszony típusa / jogviszony típus] AS [az álláshelyen fennálló jogviszony típusa], "2024. III-IV. negyedév" AS tárgyidőszak, lkSzemélyek.[Orvosi vizsgálat időpontja] AS [a vizsgálat időpontja], Replace(Replace([Orvosi vizsgálat típusa],"Munkábalépés előtti","előzetes"),"Munkakör változás előtti","soron kívüli") AS [a vizsgálat típusa]
FROM lkSzervezetiÁlláshelyek RIGHT JOIN (lkSzemélyUtolsóSzervezetiEgysége INNER JOIN lkSzemélyek ON lkSzemélyUtolsóSzervezetiEgysége.Adójel = lkSzemélyek.Adójel) ON lkSzervezetiÁlláshelyek.ÁlláshelyAzonosító = lkSzemélyUtolsóSzervezetiEgysége.ÁNYR
WHERE (((lkSzemélyek.[Orvosi vizsgálat időpontja]) Between #9/1/2024# And #12/31/2024#));

#/#/#/
lkKeresendők
#/#/
SELECT tKeresendők.Azonosító, tKeresendők.Sorszám, tKeresendők.Főosztály, tKeresendők.Osztály
FROM tKeresendők;

#/#/#/
lkKerületiLakosok
#/#/
SELECT lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Születési idő], lkSzemélyek.[Születési hely], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, Replace(Nz([Állandó lakcím],""),"Magyarország, ","") AS Állandó, Replace(Nz([Tartózkodási lakcím],""),"Magyarország, ","") AS Tartózkodási, IRSZ(Replace(Nz([Állandó lakcím],""),"Magyarország, ","")) AS [Állandó IRSZ], IRSZ(Replace(Nz([Tartózkodási lakcím],""),"Magyarország, ","")) AS [Tartózkodási IRSZ], lkSzemélyek.[Otthoni e-mail], lkSzemélyek.[Otthoni mobil], lkSzemélyek.[Otthoni telefon], lkSzemélyek.[További otthoni mobil]
FROM lkSzemélyek
WHERE (((IRSZ(Replace(Nz([Állandó lakcím],""),"Magyarország, ",""))) Like "10" & [Kerület] & "*")) OR (((IRSZ(Replace(Nz([Tartózkodási lakcím],""),"Magyarország, ",""))) Like "10" & [Kerület] & "*"));

#/#/#/
lkKiBelépőkLétszáma
#/#/
SELECT KiBelépőkLétszáma.Főosztály, KiBelépőkLétszáma.Osztály, KiBelépőkLétszáma.Dátum, Sum(KiBelépőkLétszáma.Létszám) AS Fő INTO tKiBelépőkLétszáma
FROM (SELECT lkKilépőUnió.Főosztály, lkKilépőUnió.Osztály, lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja] AS Dátum, Sum(-1) AS Létszám
FROM lkKilépőUnió
GROUP BY lkKilépőUnió.Főosztály, lkKilépőUnió.Osztály, lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja]
UNION
SELECT  lkBelépőkUnió.Főosztály, lkBelépőkUnió.Osztály, lkBelépőkUnió.[Jogviszony kezdő dátuma] AS Dátum, Sum(1) AS Létszám
FROM  lkBelépőkUnió
GROUP BY lkBelépőkUnió.Főosztály, lkBelépőkUnió.Osztály, lkBelépőkUnió.[Jogviszony kezdő dátuma])  AS KiBelépőkLétszáma
GROUP BY KiBelépőkLétszáma.Főosztály, KiBelépőkLétszáma.Osztály, KiBelépőkLétszáma.Dátum;

#/#/#/
lkKiemeltNapok
#/#/
SELECT lkSorszámok.Sorszám AS év, lkSorszámok_1.Sorszám AS hó, lkSorszámok_2.Sorszám AS tnap, dtÁtal([év] & "." & [hó] & "." & [tnap]) AS KiemeltNapok, Day([KiemeltNapok]) AS nap
FROM lkSorszámok, lkSorszámok AS lkSorszámok_1, lkSorszámok AS lkSorszámok_2
WHERE (((lkSorszámok.Sorszám) Between 19 And Year(Now())-2000) AND ((lkSorszámok_1.Sorszám)<13) AND ((lkSorszámok_2.Sorszám) In (1,15,31)))
ORDER BY lkSorszámok.Sorszám, lkSorszámok_1.Sorszám, lkSorszámok_2.Sorszám;

#/#/#/
lkKilépésiDátumNélküliek
#/#/
SELECT kt_azNexon_Adójel02.azNexon, lkKilépőUnió.Név, lkKilépőUnió.Adóazonosító, lkKilépőUnió.Főosztály, lkKilépőUnió.Osztály, lkSzemélyekMind.[Jogviszony kezdete (belépés dátuma)], lkKilépőUnió.[Jogviszony kezdő dátuma], lkSzemélyekMind.[Jogviszony vége (kilépés dátuma)], lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja], lkSzemélyekMind.[Jogviszony sorszáma]
FROM (lkSzemélyekMind INNER JOIN lkKilépőUnió ON (lkSzemélyekMind.[Jogviszony kezdete (belépés dátuma)] = lkKilépőUnió.[Jogviszony kezdő dátuma]) AND (lkSzemélyekMind.Adójel = lkKilépőUnió.Adójel)) INNER JOIN kt_azNexon_Adójel02 ON lkSzemélyekMind.Adójel = kt_azNexon_Adójel02.Adójel
WHERE (((lkSzemélyekMind.[Jogviszony vége (kilépés dátuma)])=0));

#/#/#/
lkKilépőDolgozók
#/#/
SELECT DISTINCT bfkh([Szervezeti egység kódja]) AS BFKH, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.Adójel, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Státusz kódja], IIf(Nz([besorolási  fokozat (KT)],"")="",[Tervezett betöltési adatok - Előmeneteli fokozat megnevezés],Nz([besorolási  fokozat (KT)],"")) AS Besorolás, lkSzemélyek.[Státusz típusa], lkSzemélyek.[KIRA jogviszony jelleg], lkSzemélyek.[Jogviszony vége (kilépés dátuma)], lkSzemélyek.[HR kapcsolat megszűnés módja (Kilépés módja)]
FROM lkSzemélyek LEFT JOIN lkSzervezetÁlláshelyek ON lkSzemélyek.[Státusz kódja] = lkSzervezetÁlláshelyek.Álláshely
WHERE (((lkSzemélyek.[Jogviszony vége (kilépés dátuma)])>Date()) AND ((lkSzemélyek.[Státusz neve])="Álláshely")) OR (((lkSzemélyek.[Jogviszony vége (kilépés dátuma)]) Is Null) AND ((lkSzemélyek.[HR kapcsolat megszűnés módja (Kilépés módja)]) Is Not Null) AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY bfkh([Szervezeti egység kódja]);

#/#/#/
lkKilépők
#/#/
SELECT Kilépők.Sorszám, Kilépők.Név, Kilépők.Adóazonosító, Kilépők.[Megyei szint VAGY Járási Hivatal], Kilépők.Mező5, Kilépők.Mező6, Kilépők.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Kilépők.Mező8, Kilépők.[Besorolási fokozat kód:], Kilépők.[Besorolási fokozat megnevezése:], Kilépők.[Álláshely azonosító], Kilépők.[Jogviszony megszűnésének, megszüntetésének oka: jogszabályi hiva], Kilépők.[Jogviszony kezdő dátuma], Kilépők.[Jogviszony megszűnésének, megszüntetésének időpontja], Kilépők.[Végkielégítésre jogosító hónapok száma], Kilépők.[Felmentési idő hónapok száma], "-" AS Üres, Kilépők.[Illetmény (Ft/hó)], [Adóazonosító]*1 AS Adójel
FROM Kilépők;

#/#/#/
lkKilépők_Havi
#/#/
SELECT Kilépők.Név, [Kilépők].[Adóazonosító]*1 AS Adóazonosító, Kilépők.[Jogviszony megszűnésének, megszüntetésének időpontja] AS Kilépés, Month([Jogviszony megszűnésének, megszüntetésének időpontja]) AS Hó
FROM Kilépők;

#/#/#/
lkKilépők_Havi_vs_Személyek
#/#/
SELECT lkKilépők_Havi.Név AS NévHavi, lkKilépők_Havi.Adóazonosító, lkKilépők_Havi.Kilépés, lkSzemélyek.[Dolgozó teljes neve] AS Név_, lkSzemélyek.Adójel, lkSzemélyek.[Jogviszony vége (kilépés dátuma)] AS Kilépés_, lkSzemélyek.[Helyettesített dolgozó neve], lkSzemélyek.[Tartós távollét típusa], lkSzemélyek.[HR kapcsolat megszűnés módja (Kilépés módja)], lkSzemélyek.[Jogviszony típusa / jogviszony típus]
FROM lkSzemélyek LEFT JOIN lkKilépők_Havi ON lkSzemélyek.Adójel = lkKilépők_Havi.Adóazonosító
WHERE (((lkKilépők_Havi.Adóazonosító) Is Null) AND ((lkSzemélyek.[Jogviszony vége (kilépés dátuma)]) Between #1/1/2023# And #4/30/2023#) AND ((lkSzemélyek.[Jogviszony típusa / jogviszony típus]) Not Like "Személyes*"));

#/#/#/
lkKilépők_Személyek01
#/#/
SELECT tSzemélyek.[Dolgozó teljes neve] AS Név, Year([Jogviszony vége (kilépés dátuma)]) AS KilépésÉve, Month([Jogviszony vége (kilépés dátuma)]) AS KilépésHava, [tSzemélyek].[Adójel]*1 AS Adóazonosító, tSzemélyek.[Jogviszony vége (kilépés dátuma)] AS Kilépés, tSzemélyek.[Szervezeti egység kódja], -1 AS Létszám
FROM tSzemélyek
WHERE (((tSzemélyek.[Jogviszony vége (kilépés dátuma)]) Is Not Null) AND ((tSzemélyek.[Szervezeti egység kódja]) Not Like "BFKH-MEGB")) OR (((tSzemélyek.[Jogviszony vége (kilépés dátuma)]) Is Not Null) AND ((tSzemélyek.[Szervezeti egység kódja])="")) OR (((tSzemélyek.[Jogviszony vége (kilépés dátuma)]) Is Not Null) AND ((tSzemélyek.[Szervezeti egység kódja]) Is Null));

#/#/#/
lkKilépők_Személyek02
#/#/
TRANSFORM Sum(lkKilépők_Személyek01.Létszám) AS SumOfLétszám
SELECT lkKilépők_Személyek01.KilépésHava
FROM lkKilépők_Személyek01
WHERE (((lkKilépők_Személyek01.KilépésÉve)>2018))
GROUP BY lkKilépők_Személyek01.KilépésHava
PIVOT lkKilépők_Személyek01.KilépésÉve;

#/#/#/
lkKilépőkBFKHnálLedolgozottIdejeHetente
#/#/
TRANSFORM Count(tSzemélyek.Adójel) AS CountOfAdójel
SELECT DateDiff("w",[Jogviszony kezdete (belépés dátuma)],[Jogviszony vége (kilépés dátuma)]) AS Kif1
FROM tSzemélyek
WHERE (((tSzemélyek.[Jogviszony vége (kilépés dátuma)])<>0))
GROUP BY DateDiff("w",[Jogviszony kezdete (belépés dátuma)],[Jogviszony vége (kilépés dátuma)])
PIVOT Year([Jogviszony vége (kilépés dátuma)]);

#/#/#/
lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta01
#/#/
SELECT Trim(Replace(Replace(Replace([lkKilépőUnió].[Főosztály],"Budapest Főváros Kormányhivatala","BFKH")," 20200229-ig",""),"Budapest FővárosKormányhivatala","BFKH")) AS Főosztály, Year([Jogviszony megszűnésének, megszüntetésének időpontja]) AS Év, Month([Jogviszony megszűnésének, megszüntetésének időpontja]) AS Hó, 1 AS fő
FROM lkKilépőUnió
WHERE (((lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének oka: jogszabályi hiva]) Like "*próbaidő*"));

#/#/#/
lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta02
#/#/
SELECT lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta01.Főosztály, lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta01.Év, lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta01.fő, IIf([Hó]=1,[fő],0) AS 1, IIf([Hó]=2,[fő],0) AS 2, IIf([Hó]=3,[fő],0) AS 3, IIf([Hó]=4,[fő],0) AS 4, IIf([Hó]=5,[fő],0) AS 5, IIf([Hó]=6,[fő],0) AS 6, IIf([Hó]=7,[fő],0) AS 7, IIf([Hó]=8,[fő],0) AS 8, IIf([Hó]=9,[fő],0) AS 9, IIf([Hó]=10,[fő],0) AS 10, IIf([Hó]=11,[fő],0) AS 11, IIf([Hó]=12,[fő],0) AS 12
FROM lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta01;

#/#/#/
lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta03
#/#/
SELECT lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta02.Főosztály, lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta02.Év, Sum(lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta02.[1]) AS [1 hó], Sum(lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta02.[2]) AS [2 hó], Sum(lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta02.[3]) AS [3 hó], Sum(lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta02.[4]) AS [4 hó], Sum(lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta02.[5]) AS [5 hó], Sum(lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta02.[6]) AS [6 hó], Sum(lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta02.[7]) AS [7 hó], Sum(lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta02.[8]) AS [8 hó], Sum(lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta02.[9]) AS [9 hó], Sum(lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta02.[10]) AS [10 hó], Sum(lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta02.[11]) AS [11 hó], Sum(lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta02.[12]) AS [12 hó]
FROM lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta02
GROUP BY lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta02.Főosztály, lkKilépőkPróbaidőFőosztályonkéntÉventeHavonta02.Év;

#/#/#/
lkKilépőkSzáma
#/#/
SELECT dtÁtal([Jogviszony vége (kilépés dátuma)]) AS Dátum, 0 AS [Belépők száma], Count(lkSzemélyek.Adójel) AS [Kilépők száma]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Jogviszony típusa / jogviszony típus]) Like "munka*" Or (lkSzemélyek.[Jogviszony típusa / jogviszony típus]) Like "korm*"))
GROUP BY dtÁtal([Jogviszony vége (kilépés dátuma)]), 0
HAVING (((dtÁtal([Jogviszony vége (kilépés dátuma)])) Between Now() And DateSerial(Year(Now()),Month(Now())+1,Day(Now()))));

#/#/#/
lkKilépőkSzámaÉvente
#/#/
SELECT Year([Jogviszony megszűnésének, megszüntetésének időpontja]) AS KilépésÉve, Sum(IIf([Csoport]="nyugdíj",0,1)) AS [Kilépők száma]
FROM tMegszűnésMódjaCsoportok RIGHT JOIN lkKilépőUnió ON tMegszűnésMódjaCsoportok.MegszűnésMódja = lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének oka: jogszabályi hiva]
WHERE (((lkKilépőUnió.Főosztály) Like Nz([Főosztály_],"") & "*") AND ((lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja])<#9/30/2024#))
GROUP BY Year([Jogviszony megszűnésének, megszüntetésének időpontja])
HAVING (((Year([Jogviszony megszűnésének, megszüntetésének időpontja])) Between 2020 And 2024));

#/#/#/
lkKilépőkSzámaÉvente_Indokonként
#/#/
TRANSFORM Count(lkSzemélyekMind.Azonosító) AS [Kilépők száma]
SELECT lkSzemélyekMind.[HR kapcsolat megszűnés módja (Kilépés módja)]
FROM tSzemélyek INNER JOIN lkSzemélyekMind ON tSzemélyek.Azonosító = lkSzemélyekMind.Azonosító
WHERE (((lkSzemélyekMind.[KIRA jogviszony jelleg]) Like "Kormányzati*" Or (lkSzemélyekMind.[KIRA jogviszony jelleg])="Munkaviszony") AND ((lkSzemélyekMind.JogviszonyVége) Is Not Null Or (lkSzemélyekMind.JogviszonyVége)<>"") AND ((Year([JogviszonyVége]))>=2019 And (Year([JogviszonyVége]))<=Year(Now())))
GROUP BY lkSzemélyekMind.[HR kapcsolat megszűnés módja (Kilépés módja)]
ORDER BY Year([JogviszonyVége])
PIVOT Year([JogviszonyVége]);

#/#/#/
lkKilépőkSzámaÉvente2b
#/#/
SELECT lkKilépőkSzámaÉventeHavonta.Év, Sum(lkKilépőkSzámaÉventeHavonta.[Kilépők száma]) AS Kilépők
FROM lkKilépőkSzámaÉventeHavonta
GROUP BY lkKilépőkSzámaÉventeHavonta.Év;

#/#/#/
lkKilépőkSzámaÉventeFélévente01
#/#/
SELECT Year([JogviszonyVége]) AS Év, IIf(Month([JogviszonyVége])<7,1,2) AS Félév, lkSzemélyekMind.[KIRA jogviszony jelleg], Count(lkSzemélyekMind.Azonosító) AS [Kilépők száma]
FROM lkSzemélyekMind
WHERE (((lkSzemélyekMind.[Jogviszony vége (kilépés dátuma)]) Is Not Null Or (lkSzemélyekMind.[Jogviszony vége (kilépés dátuma)])<>"") AND ((Year([JogviszonyVége]))>=2019 And (Year([JogviszonyVége]))<=Year(Now())+1))
GROUP BY Year([JogviszonyVége]), IIf(Month([JogviszonyVége])<7,1,2), lkSzemélyekMind.[KIRA jogviszony jelleg]
HAVING (((lkSzemélyekMind.[KIRA jogviszony jelleg]) Like "Kormányzati*" Or (lkSzemélyekMind.[KIRA jogviszony jelleg])="Munkaviszony"))
ORDER BY Year([JogviszonyVége]), IIf(Month([JogviszonyVége])<7,1,2);

#/#/#/
lkKilépőkSzámaÉventeFélévente02a
#/#/
TRANSFORM Sum(lkKilépőkSzámaÉventeFélévente01.[Kilépők száma]) AS [SumOfKilépők száma]
SELECT 1 AS Sorszám, lkKilépőkSzámaÉventeFélévente01.[KIRA jogviszony jelleg], lkKilépőkSzámaÉventeFélévente01.Év
FROM lkKilépőkSzámaÉventeFélévente01
GROUP BY 1, lkKilépőkSzámaÉventeFélévente01.[KIRA jogviszony jelleg], lkKilépőkSzámaÉventeFélévente01.Év
ORDER BY lkKilépőkSzámaÉventeFélévente01.[KIRA jogviszony jelleg], lkKilépőkSzámaÉventeFélévente01.Év
PIVOT lkKilépőkSzámaÉventeFélévente01.Félév;

#/#/#/
lkKilépőkSzámaÉventeFélévente02b
#/#/
TRANSFORM Sum(lkKilépőkSzámaÉventeFélévente01.[Kilépők száma]) AS [SumOfKilépők száma]
SELECT 2 AS Sorszám, "Kit. és Mt. együtt:" AS [KIRA jogviszony jelleg], lkKilépőkSzámaÉventeFélévente01.Év
FROM lkKilépőkSzámaÉventeFélévente01
GROUP BY 2, "Kit. és Mt. együtt:", lkKilépőkSzámaÉventeFélévente01.Év
ORDER BY "Kit. és Mt. együtt:", lkKilépőkSzámaÉventeFélévente01.Év
PIVOT lkKilépőkSzámaÉventeFélévente01.Félév;

#/#/#/
lkKilépőkSzámaÉventeFélévente03
#/#/
SELECT lkKilépőkSzámaÉventeFélévente02a.Sorszám, lkKilépőkSzámaÉventeFélévente02a.[KIRA jogviszony jelleg], lkKilépőkSzámaÉventeFélévente02a.Év, lkKilépőkSzámaÉventeFélévente02a.[1], lkKilépőkSzámaÉventeFélévente02a.[2]
FROM lkKilépőkSzámaÉventeFélévente02a
UNION SELECT lkKilépőkSzámaÉventeFélévente02b.Sorszám, lkKilépőkSzámaÉventeFélévente02b.[KIRA jogviszony jelleg], lkKilépőkSzámaÉventeFélévente02b.Év, lkKilépőkSzámaÉventeFélévente02b.[1], lkKilépőkSzámaÉventeFélévente02b.[2]
FROM lkKilépőkSzámaÉventeFélévente02b;

#/#/#/
lkKilépőkSzámaÉventeHavonta
#/#/
SELECT Year([JogviszonyVége]) AS Év, Month([JogviszonyVége]) AS Hó, Count(lkSzemélyekMind.Azonosító) AS [Kilépők száma]
FROM lkSzemélyekMind
WHERE (((lkSzemélyekMind.[KIRA jogviszony jelleg]) Like "Kormányzati*" Or (lkSzemélyekMind.[KIRA jogviszony jelleg])="Munkaviszony" Or (lkSzemélyekMind.[KIRA jogviszony jelleg]) Like "Hivatás*") AND ((lkSzemélyekMind.[Jogviszony vége (kilépés dátuma)]) Is Not Null Or (lkSzemélyekMind.[Jogviszony vége (kilépés dátuma)])<>"") AND ((Year([JogviszonyVége]))>=2019 And (Year([JogviszonyVége]))<=Year(Now())+1))
GROUP BY Year([JogviszonyVége]), Month([JogviszonyVége])
ORDER BY Year([JogviszonyVége]), Month([JogviszonyVége]);

#/#/#/
lkKilépőkSzámaÉventeHavonta2
#/#/
SELECT lkKilépőkSzámaÉventeHavonta.Év, IIf([Hó]=1,[Kilépők száma],0) AS 1, IIf([Hó]=2,[Kilépők száma],0) AS 2, IIf([Hó]=3,[Kilépők száma],0) AS 3, IIf([Hó]=4,[Kilépők száma],0) AS 4, IIf([Hó]=5,[Kilépők száma],0) AS 5, IIf([Hó]=6,[Kilépők száma],0) AS 6, IIf([Hó]=7,[Kilépők száma],0) AS 7, IIf([Hó]=8,[Kilépők száma],0) AS 8, IIf([Hó]=9,[Kilépők száma],0) AS 9, IIf([Hó]=10,[Kilépők száma],0) AS 10, IIf([Hó]=11,[Kilépők száma],0) AS 11, IIf([Hó]=12,[Kilépők száma],0) AS 12
FROM lkKilépőkSzámaÉventeHavonta;

#/#/#/
lkKilépőkSzámaÉventeHavonta2Akkumulálva
#/#/
SELECT lkKilépőkSzámaÉventeHavonta.Év, IIf([Hó]<=1,[Kilépők száma],0) AS 1, IIf([Hó]<=2,[Kilépők száma],0) AS 2, IIf([Hó]<=3,[Kilépők száma],0) AS 3, IIf([Hó]<=4,[Kilépők száma],0) AS 4, IIf([Hó]<=5,[Kilépők száma],0) AS 5, IIf([Hó]<=6,[Kilépők száma],0) AS 6, IIf([Hó]<=7,[Kilépők száma],0) AS 7, IIf([Hó]<=8,[Kilépők száma],0) AS 8, IIf([Hó]<=9,[Kilépők száma],0) AS 9, IIf([Hó]<=10,[Kilépők száma],0) AS 10, IIf([Hó]<=11,[Kilépők száma],0) AS 11, IIf([Hó]<=12,[Kilépők száma],0) AS 12
FROM lkKilépőkSzámaÉventeHavonta;

#/#/#/
lkKilépőkSzámaÉventeHavonta3
#/#/
SELECT lkKilépőkSzámaÉventeHavonta2.Év, Sum(lkKilépőkSzámaÉventeHavonta2.[1]) AS 01, Sum(lkKilépőkSzámaÉventeHavonta2.[2]) AS 02, Sum(lkKilépőkSzámaÉventeHavonta2.[3]) AS 03, Sum(lkKilépőkSzámaÉventeHavonta2.[4]) AS 04, Sum(lkKilépőkSzámaÉventeHavonta2.[5]) AS 05, Sum(lkKilépőkSzámaÉventeHavonta2.[6]) AS 06, Sum(lkKilépőkSzámaÉventeHavonta2.[7]) AS 07, Sum(lkKilépőkSzámaÉventeHavonta2.[8]) AS 08, Sum(lkKilépőkSzámaÉventeHavonta2.[9]) AS 09, Sum(lkKilépőkSzámaÉventeHavonta2.[10]) AS 10, Sum(lkKilépőkSzámaÉventeHavonta2.[11]) AS 11, Sum(lkKilépőkSzámaÉventeHavonta2.[12]) AS 12, lkKilépőkSzámaÉvente2b.Kilépők
FROM lkKilépőkSzámaÉvente2b INNER JOIN lkKilépőkSzámaÉventeHavonta2 ON lkKilépőkSzámaÉvente2b.Év=lkKilépőkSzámaÉventeHavonta2.Év
GROUP BY lkKilépőkSzámaÉventeHavonta2.Év, lkKilépőkSzámaÉvente2b.Kilépők;

#/#/#/
lkKilépőkSzámaÉventeHavonta3Akkumulálva
#/#/
SELECT lkKilépőkSzámaÉventeHavonta2Akkumulálva.Év, Sum(lkKilépőkSzámaÉventeHavonta2Akkumulálva.[1]) AS 01, Sum(lkKilépőkSzámaÉventeHavonta2Akkumulálva.[2]) AS 02, Sum(lkKilépőkSzámaÉventeHavonta2Akkumulálva.[3]) AS 03, Sum(lkKilépőkSzámaÉventeHavonta2Akkumulálva.[4]) AS 04, Sum(lkKilépőkSzámaÉventeHavonta2Akkumulálva.[5]) AS 05, Sum(lkKilépőkSzámaÉventeHavonta2Akkumulálva.[6]) AS 06, Sum(lkKilépőkSzámaÉventeHavonta2Akkumulálva.[7]) AS 07, Sum(lkKilépőkSzámaÉventeHavonta2Akkumulálva.[8]) AS 08, Sum(lkKilépőkSzámaÉventeHavonta2Akkumulálva.[9]) AS 09, Sum(lkKilépőkSzámaÉventeHavonta2Akkumulálva.[10]) AS 10, Sum(lkKilépőkSzámaÉventeHavonta2Akkumulálva.[11]) AS 11, Sum(lkKilépőkSzámaÉventeHavonta2Akkumulálva.[12]) AS 12, lkKilépőkSzámaÉvente2b.Kilépők
FROM lkKilépőkSzámaÉventeHavonta2Akkumulálva INNER JOIN lkKilépőkSzámaÉvente2b ON lkKilépőkSzámaÉventeHavonta2Akkumulálva.Év = lkKilépőkSzámaÉvente2b.Év
GROUP BY lkKilépőkSzámaÉventeHavonta2Akkumulálva.Év, lkKilépőkSzámaÉvente2b.Kilépők;

#/#/#/
lkKilépőkSzámaÉventeHavontaFőoszt02
#/#/
SELECT lkKilépőkSzámaÉventeHavontaFőosztOszt01.Főosztály AS Főosztály, lkKilépőkSzámaÉventeHavontaFőosztOszt01.Év AS Év, Sum((IIf([Hó]=1,[Kilépők száma],0))) AS 1, Sum((IIf([Hó]=2,[Kilépők száma],0))) AS 2, Sum((IIf([Hó]=3,[Kilépők száma],0))) AS 3, Sum((IIf([Hó]=4,[Kilépők száma],0))) AS 4, Sum((IIf([Hó]=5,[Kilépők száma],0))) AS 5, Sum((IIf([Hó]=6,[Kilépők száma],0))) AS 6, Sum((IIf([Hó]=7,[Kilépők száma],0))) AS 7, Sum((IIf([Hó]=8,[Kilépők száma],0))) AS 8, Sum((IIf([Hó]=9,[Kilépők száma],0))) AS 9, Sum((IIf([Hó]=10,[Kilépők száma],0))) AS 10, Sum((IIf([Hó]=11,[Kilépők száma],0))) AS 11, Sum((IIf([Hó]=12,[Kilépők száma],0))) AS 12, [1]+[2]+[3]+[4]+[5]+[6]+[7]+[8]+[9]+[10]+[11]+[12] AS Összesen
FROM lkKilépőkSzámaÉventeHavontaFőosztOszt01
GROUP BY lkKilépőkSzámaÉventeHavontaFőosztOszt01.Főosztály, lkKilépőkSzámaÉventeHavontaFőosztOszt01.Év;

#/#/#/
lkKilépőkSzámaÉventeHavontaFőosztOszt01
#/#/
SELECT Trim(Replace(Replace(Replace([lkKilépőUnió].[Főosztály],"Budapest Főváros Kormányhivatala","BFKH")," 20200229-ig",""),"Budapest FővárosKormányhivatala","BFKH")) AS Főosztály, Replace([lkKilépőUnió].[Osztály]," 20200229-ig","") AS Osztály, Year([JogviszonyVége]) AS Év, Month([JogviszonyVége]) AS Hó, Count(lkSzemélyekMind.Azonosító) AS [Kilépők száma]
FROM lkSzemélyekMind RIGHT JOIN lkKilépőUnió ON (lkSzemélyekMind.[Adóazonosító jel] = lkKilépőUnió.Adóazonosító) AND (lkSzemélyekMind.JogviszonyVége = lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja])
WHERE (((lkSzemélyekMind.[KIRA jogviszony jelleg]) Like "Kormányzati*" Or (lkSzemélyekMind.[KIRA jogviszony jelleg])="Munkaviszony") AND ((lkSzemélyekMind.JogviszonyVége)<>0) AND ((Year([JogviszonyVége])) Between Year(Now())-4 And Year(Now())+1))
GROUP BY Trim(Replace(Replace(Replace([lkKilépőUnió].[Főosztály],"Budapest Főváros Kormányhivatala","BFKH")," 20200229-ig",""),"Budapest FővárosKormányhivatala","BFKH")), Replace([lkKilépőUnió].[Osztály]," 20200229-ig",""), Year([JogviszonyVége]), Month([JogviszonyVége])
ORDER BY Year([JogviszonyVége]), Month([JogviszonyVége]);

#/#/#/
lkKilépőkSzámaÉventeHavontaFőosztOszt02
#/#/
SELECT lkKilépőkSzámaÉventeHavontaFőosztOszt01.Főosztály, lkKilépőkSzámaÉventeHavontaFőosztOszt01.Osztály, lkKilépőkSzámaÉventeHavontaFőosztOszt01.Év, Sum(IIf([Hó]=1,[Kilépők száma],0)) AS 1, Sum(IIf([Hó]=2,[Kilépők száma],0)) AS 2, Sum(IIf([Hó]=3,[Kilépők száma],0)) AS 3, Sum(IIf([Hó]=4,[Kilépők száma],0)) AS 4, Sum(IIf([Hó]=5,[Kilépők száma],0)) AS 5, Sum(IIf([Hó]=6,[Kilépők száma],0)) AS 6, Sum(IIf([Hó]=7,[Kilépők száma],0)) AS 7, Sum(IIf([Hó]=8,[Kilépők száma],0)) AS 8, Sum(IIf([Hó]=9,[Kilépők száma],0)) AS 9, Sum(IIf([Hó]=10,[Kilépők száma],0)) AS 10, Sum(IIf([Hó]=11,[Kilépők száma],0)) AS 11, Sum(IIf([Hó]=12,[Kilépők száma],0)) AS 12, [1]+[2]+[3]+[4]+[5]+[6]+[7]+[8]+[9]+[10]+[11]+[12] AS Összesen
FROM lkKilépőkSzámaÉventeHavontaFőosztOszt01
GROUP BY lkKilépőkSzámaÉventeHavontaFőosztOszt01.Főosztály, lkKilépőkSzámaÉventeHavontaFőosztOszt01.Osztály, lkKilépőkSzámaÉventeHavontaFőosztOszt01.Év;

#/#/#/
lkKilépőkSzámaÉventeHavontaFőosztOszt02-EgyFőosztályra
#/#/
SELECT lkKilépőkSzámaÉventeHavontaFőosztOszt02.*
FROM lkKilépőkSzámaÉventeHavontaFőosztOszt02
WHERE (((lkKilépőkSzámaÉventeHavontaFőosztOszt02.Főosztály) Like "*" & [Add meg a Főosztály] & "*"));

#/#/#/
lkKilépőkSzámaÉventeHavontaKorral
#/#/
SELECT Year([JogviszonyVége]) AS Év, Month([JogviszonyVége]) AS Hó, Count(lkSzemélyekMind.Azonosító) AS [Kilépők száma], Year(Now())-Year([Születési idő]) AS Kor
FROM lkSzemélyekMind
WHERE (((lkSzemélyekMind.[KIRA jogviszony jelleg]) Like "Kormányzati*" Or (lkSzemélyekMind.[KIRA jogviszony jelleg])="Munkaviszony") AND ((lkSzemélyekMind.[Jogviszony vége (kilépés dátuma)]) Is Not Null Or (lkSzemélyekMind.[Jogviszony vége (kilépés dátuma)])<>"") AND ((Year([JogviszonyVége]))>=2019 And (Year([JogviszonyVége]))<=Year(Now())+1))
GROUP BY Year([JogviszonyVége]), Month([JogviszonyVége]), Year(Now())-Year([Születési idő])
ORDER BY Year([JogviszonyVége]), Month([JogviszonyVége]);

#/#/#/
lkKilépőkSzámaÉventeKorral
#/#/
SELECT lkKilépőkSzámaÉventeHavontaKorral.Év, Switch([Kor]>=0 And [Kor]<=22,"18-22 évek között:",[Kor]>=23 And [Kor]<=28,"23-28 évek között:",[Kor]>=29 And [Kor]<=35,"29-35 évek között:",[Kor]>=36 And [Kor]<=40,"36-40 évek között:",[Kor]>=41 And [Kor]<=45,"41-45 évek között:",[Kor]>=46 And [Kor]<=50,"46-50 évek között:",[Kor]>=51 And [Kor]<=60,"51-60 évek között:",[Kor]>=61 And [Kor]<=65,"61-65 évek között:",[Kor]>=66 And [Kor]<=200,"66 év fölött:") AS Korkategoria, Sum(lkKilépőkSzámaÉventeHavontaKorral.[Kilépők száma]) AS Kilépők
FROM lkKilépőkSzámaÉventeHavontaKorral
GROUP BY lkKilépőkSzámaÉventeHavontaKorral.Év, Switch([Kor]>=0 And [Kor]<=22,"18-22 évek között:",[Kor]>=23 And [Kor]<=28,"23-28 évek között:",[Kor]>=29 And [Kor]<=35,"29-35 évek között:",[Kor]>=36 And [Kor]<=40,"36-40 évek között:",[Kor]>=41 And [Kor]<=45,"41-45 évek között:",[Kor]>=46 And [Kor]<=50,"46-50 évek között:",[Kor]>=51 And [Kor]<=60,"51-60 évek között:",[Kor]>=61 And [Kor]<=65,"61-65 évek között:",[Kor]>=66 And [Kor]<=200,"66 év fölött:");

#/#/#/
lkKilépőUnió
#/#/
SELECT DISTINCT Unió2019_mostanáig.Sorszám, Unió2019_mostanáig.Név, Unió2019_mostanáig.Adóazonosító, Unió2019_mostanáig.Alaplétszám, Unió2019_mostanáig.[Megyei szint VAGY Járási Hivatal], Unió2019_mostanáig.Mező5, Unió2019_mostanáig.Mező6, Unió2019_mostanáig.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Unió2019_mostanáig.Mező8, Unió2019_mostanáig.[Besorolási fokozat kód:], Unió2019_mostanáig.[Besorolási fokozat megnevezése:], Unió2019_mostanáig.[Álláshely azonosító], Unió2019_mostanáig.[Jogviszony megszűnésének, megszüntetésének oka: jogszabályi hiva], Unió2019_mostanáig.[Jogviszony kezdő dátuma], Unió2019_mostanáig.[Jogviszony megszűnésének, megszüntetésének időpontja], Unió2019_mostanáig.[Illetmény (Ft/hó)], Unió2019_mostanáig.[Végkielégítésre jogosító hónapok száma], Unió2019_mostanáig.[Felmentési idő hónapok száma], IIf([Megyei szint VAGY Járási Hivatal]="megyei szint",[Mező5],[Megyei szint VAGY Járási Hivatal]) AS Főosztály, Unió2019_mostanáig.tKilépőkUnió.Mező6 AS Osztály, [adóazonosító]*1 AS Adójel, *
FROM (SELECT  tKilépőkUnió.Sorszám, tKilépőkUnió.Név, tKilépőkUnió.Adóazonosító, tKilépőkUnió.Alaplétszám, tKilépőkUnió.[Megyei szint VAGY Járási Hivatal], tKilépőkUnió.Mező5, tKilépőkUnió.Mező6, tKilépőkUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], tKilépőkUnió.Mező8, tKilépőkUnió.[Besorolási fokozat kód:], tKilépőkUnió.[Besorolási fokozat megnevezése:], tKilépőkUnió.[Álláshely azonosító], tKilépőkUnió.[Jogviszony megszűnésének, megszüntetésének oka: jogszabályi hiva], tKilépőkUnió.[Jogviszony kezdő dátuma], tKilépőkUnió.[Jogviszony megszűnésének, megszüntetésének időpontja], tKilépőkUnió.[Illetmény (Ft/hó)], tKilépőkUnió.[Végkielégítésre jogosító hónapok száma], tKilépőkUnió.[Felmentési idő hónapok száma], Év
FROM tKilépőkUnió
UNION
SELECT Kilépők.Sorszám, Kilépők.Név, Kilépők.Adóazonosító, Kilépők.Alaplétszám, Kilépők.[Megyei szint VAGY Járási Hivatal], Kilépők.Mező5, Kilépők.Mező6, Kilépők.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Kilépők.Mező8, Kilépők.[Besorolási fokozat kód:], Kilépők.[Besorolási fokozat megnevezése:], Kilépők.[Álláshely azonosító], Kilépők.[Jogviszony megszűnésének, megszüntetésének oka: jogszabályi hiva], Kilépők.[Jogviszony kezdő dátuma], Kilépők.[Jogviszony megszűnésének, megszüntetésének időpontja], Kilépők.[Illetmény (Ft/hó)], Kilépők.[Végkielégítésre jogosító hónapok száma], Kilépők.[Felmentési idő hónapok száma],Year(date()) as Év
FROM Kilépők)  AS Unió2019_mostanáig;

#/#/#/
lkKimenetÜresÁlláshelyekKimutatáshoz
#/#/
SELECT BetöltöttekÉsÜresek.[ÁNYR azonosító], BetöltöttekÉsÜresek.Besorolás, BetöltöttekÉsÜresek.Jelleg, BetöltöttekÉsÜresek.[Betöltő neve], BetöltöttekÉsÜresek.Főosztály, BetöltöttekÉsÜresek.Osztály, BetöltöttekÉsÜresek.Állapot, BetöltöttekÉsÜresek.[Ellátott feladat], BetöltöttekÉsÜresek.Megjegyzés, *
FROM (SELECT Betöltöttek.*
FROM lkKimenetÜresÁlláshelyekKimutatáshoz01 AS Betöltöttek
UNION SELECT Üresek.*
FROM lkKimenetÜresÁlláshelyekKimutatáshoz02 AS Üresek
union SELECT Határozottak.mező25 AS [ÁNYR azonosító], Határozottak.mező24 AS Besorolás, Határozottak.[Központosított álláshely] AS Jelleg, Határozottak.[Tartós távollévő álláshelyén határozott időre foglalkoztatott ne] AS [Betöltő neve], IIf([mező18]="megyei szint",[mező19],[mező18]) AS Főosztály, Határozottak.mező20 AS Osztály, "Betöltött" AS Állapot, Határozottak.mező22 AS [Ellátott feladat], IIf(CStr([Mező23]) Like "*Ov*" Or CStr([Mező23]) Like "*Jhv*" Or CStr([mező23]) Like "*ig." Or CStr([Mező23])="fsp.","vezetői","") AS Megjegyzés
FROM Határozottak)  AS BetöltöttekÉsÜresek;

#/#/#/
lkKimenetÜresÁlláshelyekKimutatáshoz01
#/#/
SELECT lkJárásiKormányKözpontosítottUnió.[Álláshely azonosító] AS [ÁNYR azonosító], lkJárásiKormányKözpontosítottUnió.[Besorolási fokozat megnevezése:] AS Besorolás, lkJárásiKormányKözpontosítottUnió.Jelleg, lkJárásiKormányKözpontosítottUnió.Név AS [Betöltő neve], lkJárásiKormányKözpontosítottUnió.[Járási Hivatal] AS Főosztály, lkJárásiKormányKözpontosítottUnió.Osztály, "Betöltött" AS Állapot, lkJárásiKormányKözpontosítottUnió.[Ellátott feladat], IIf([Besorolási fokozat kód:] Like "*Ov*" Or [Besorolási fokozat kód:] Like "*Jhv*" Or [Besorolási fokozat kód:] Like "*ig." Or [Besorolási fokozat kód:]="fsp.","vezetői","") AS Megjegyzés
FROM lkJárásiKormányKözpontosítottUnió
WHERE (((lkJárásiKormányKözpontosítottUnió.[Születési év \ üres állás]) Not Like "üres*"));

#/#/#/
lkKimenetÜresÁlláshelyekKimutatáshoz02
#/#/
SELECT lkJárásiKormányKözpontosítottUnió.[Álláshely azonosító] AS [ÁNYR azonosító], lkJárásiKormányKözpontosítottUnió.[Besorolási fokozat megnevezése:] AS Besorolás, lkJárásiKormányKözpontosítottUnió.Jelleg, lkJárásiKormányKözpontosítottUnió.Név AS [Betöltő neve], lkJárásiKormányKözpontosítottUnió.[Járási Hivatal] AS Főosztály, lkJárásiKormányKözpontosítottUnió.Osztály, "Üres:" & Nz([VisszajelzésSzövege],"Nincs folyamatban") AS Állapot, lkJárásiKormányKözpontosítottUnió.[Ellátott feladat], IIf([Besorolási fokozat kód:] Like "*Ov*" Or [Besorolási fokozat kód:] Like "*Jhv*" Or [Besorolási fokozat kód:] Like "*ig." Or [Besorolási fokozat kód:]="fsp.","vezetői","") AS Megjegyzés
FROM lkJárásiKormányKözpontosítottUnió LEFT JOIN (lkÜzenetekVisszajelzések LEFT JOIN tVisszajelzésTípusok ON lkÜzenetekVisszajelzések.VisszajelzésKód = tVisszajelzésTípusok.VisszajelzésKód) ON lkJárásiKormányKözpontosítottUnió.[Hash] = lkÜzenetekVisszajelzések.Hash
WHERE (((lkJárásiKormányKözpontosítottUnió.[Születési év \ üres állás]) Like "üres*") AND ((lkÜzenetekVisszajelzések.DeliveredDate)=(Select Max([DeliveredDate]) FROM [lkÜzenetekVisszajelzések] as Tmp Where [lkÜzenetekVisszajelzések].Hash=Tmp.hash) Or (lkÜzenetekVisszajelzések.DeliveredDate) Is Null)) OR (((lkJárásiKormányKözpontosítottUnió.[Születési év \ üres állás]) Like "üres*") AND ((lkÜzenetekVisszajelzések.DeliveredDate) Is Null));

#/#/#/
lkKimenetÜresÁlláshelyekKimutetáshoz2a
#/#/
SELECT lkKimenetÜresÁlláshelyekKimutatáshoz.Főosztály, lkKimenetÜresÁlláshelyekKimutatáshoz.Osztály, lkKimenetÜresÁlláshelyekKimutatáshoz.Jelleg, IIf([Állapot] Like "üres*",1,0) AS Üres, IIf([Megjegyzés]="vezetői" And [Állapot] Like "üres*",1,0) AS [Ebből üres vezetői álláshely], IIf([Állapot] Like "üres*",0,1) AS Betöltött, IIf([Megjegyzés]="vezetői" And [Állapot] Not Like "üres*",1,0) AS [Betöltött vezetői]
FROM lkKimenetÜresÁlláshelyekKimutatáshoz;

#/#/#/
lkKimenetÜresÁlláshelyekKimutetáshoz2b
#/#/
SELECT lkKimenetÜresÁlláshelyekKimutetáshoz2a.Főosztály, lkKimenetÜresÁlláshelyekKimutetáshoz2a.Osztály, lkKimenetÜresÁlláshelyekKimutetáshoz2a.Jelleg, Sum(lkKimenetÜresÁlláshelyekKimutetáshoz2a.Üres) AS Üres, Sum(lkKimenetÜresÁlláshelyekKimutetáshoz2a.[Ebből üres vezetői álláshely]) AS [Ebből üres vezetői álláshely], Sum(lkKimenetÜresÁlláshelyekKimutetáshoz2a.Betöltött) AS Betöltött, Sum(lkKimenetÜresÁlláshelyekKimutetáshoz2a.[Betöltött vezetői]) AS [Betöltött vezetői]
FROM lkKimenetÜresÁlláshelyekKimutetáshoz2a
GROUP BY lkKimenetÜresÁlláshelyekKimutetáshoz2a.Főosztály, lkKimenetÜresÁlláshelyekKimutetáshoz2a.Osztály, lkKimenetÜresÁlláshelyekKimutetáshoz2a.Jelleg;

#/#/#/
lkKinaiulBeszélők
#/#/
SELECT lkSzemélyek.Törzsszám, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Nyelvtudás Kínai]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null) AND ((lkSzemélyek.[Nyelvtudás Kínai])="IGEN") AND ((lkSzemélyek.[Státusz neve])="Álláshely"));

#/#/#/
lkKiraFeladatMegnevezések
#/#/
SELECT DISTINCT lkSzemélyek.[KIRA feladat megnevezés]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[KIRA feladat megnevezés]) Is Not Null));

#/#/#/
lkKiraHiba
#/#/
SELECT tKiraHiba.Azonosító, [Adóazonosító]*1 AS Adójel, tKiraHiba.Név, tKiraHiba.KIRAzonosító, tKiraHiba.Egység, tKiraHiba.Hiba, tKiraHiba.ImportDátum
FROM lkSzemélyek RIGHT JOIN tKiraHiba ON lkSzemélyek.Adójel = tKiraHiba.Adóazonosító
WHERE (((tKiraHiba.ImportDátum)=#9/18/2023#) AND ((lkSzemélyek.[Státusz neve])="Álláshely"));

#/#/#/
lkKiraHibaStatisztika
#/#/
SELECT lkKiraHibaJav.Hibák, Count(lkKiraHibaJav.Azonosító) AS Mennyiség
FROM (SELECT IIf([Hiba] Like "A dolgozó új belépőként lett rögzítve * hatály dátummal. Csak az adott napon érvényes adatok kerülnek feldolgozásra.","##A dolgozó...##",[hiba]) AS Hibák, lkKiraHiba.Azonosító FROM lkKiraHiba)  AS lkKiraHibaJav
GROUP BY lkKiraHibaJav.Hibák;

#/#/#/
lkKorfa01
#/#/
SELECT Switch(Year(Now())-Year([lkSzemélyek].[Születési idő])>=0 AND Year(Now())-Year([lkSzemélyek].[Születési idő])<=20,"20 év alatt:",
Year(Now())-Year([lkSzemélyek].[Születési idő])>=21 AND Year(Now())-Year([lkSzemélyek].[Születési idő])<=25,"21-25 évek között:",
Year(Now())-Year([lkSzemélyek].[Születési idő])>=26 AND Year(Now())-Year([lkSzemélyek].[Születési idő])<=30,"26-30 évek között:",
Year(Now())-Year([lkSzemélyek].[Születési idő])>=31 AND Year(Now())-Year([lkSzemélyek].[Születési idő])<=35,"31-35 évek között:",
Year(Now())-Year([lkSzemélyek].[Születési idő])>=36 AND Year(Now())-Year([lkSzemélyek].[Születési idő])<=40,"36-40 évek között:",
Year(Now())-Year([lkSzemélyek].[Születési idő])>=41 AND Year(Now())-Year([lkSzemélyek].[Születési idő])<=45,"41-45 évek között:",
Year(Now())-Year([lkSzemélyek].[Születési idő])>=46 AND Year(Now())-Year([lkSzemélyek].[Születési idő])<=50,"46-50 évek között:",
Year(Now())-Year([lkSzemélyek].[Születési idő])>=51 AND Year(Now())-Year([lkSzemélyek].[Születési idő])<=55,"51-55 évek között:",
Year(Now())-Year([lkSzemélyek].[Születési idő])>=56 AND Year(Now())-Year([lkSzemélyek].[Születési idő])<=60,"56-60 évek között:",
Year(Now())-Year([lkSzemélyek].[Születési idő])>=61 AND Year(Now())-Year([lkSzemélyek].[Születési idő])<=65,"61-65 évek között:",
Year(Now())-Year([lkSzemélyek].[Születési idő])>=66 AND Year(Now())-Year([lkSzemélyek].[Születési idő])<=70,"66-70 évek között:",
Year(Now())-Year([lkSzemélyek].[Születési idő])>=71 AND Year(Now())-Year([lkSzemélyek].[Születési idő])<=200,"70 év fölött:",
) AS Korcsoport, lkSzemélyek.Adójel AS adó, IIf(lkSzemélyek.Neme="férfi",-1,0) AS Férfi, IIf(lkSzemélyek.Neme<>"férfi",1,0) AS Nő
FROM lkSzemélyek
WHERE tSzemélyek.[Státusz neve]="Álláshely";

#/#/#/
lkKorfa02
#/#/
SELECT Korcsoport, sum([Férfi]) AS Férfiak, sum([Nő]) AS Nők
FROM lkKorfa01
GROUP BY Korcsoport;

#/#/#/
lkKorfa03
#/#/
SELECT "Összesen:" AS Korcsoport, Sum(lkKorfa02.Férfiak) AS Férfiak, Sum(lkKorfa02.Nők) AS Nők
FROM lkKorfa02
GROUP BY "Összesen:";

#/#/#/
lkKorfa04
#/#/
SELECT Unió.Korcsoport, Unió.Férfiak AS Férfi, Unió.Nők AS Nő
FROM (SELECT *
  FROM lkKorfa02
  UNION
  SELECT *
  FROM lkKorfa03
  )  AS Unió;

#/#/#/
lkKorfa06
#/#/
SELECT lkKorfa04.Korcsoport AS Korcsoport, lkKorfa04.Férfi AS Férfi, lkKorfa04.Nő AS Nő
FROM lkKorfa04;

#/#/#/
lkKormányhivatali_állomány
#/#/
SELECT Kormányhivatali_állomány.Sorszám, Kormányhivatali_állomány.Név, Kormányhivatali_állomány.Adóazonosító, Kormányhivatali_állomány.Mező4 AS [Születési év \ üres állás], Kormányhivatali_állomány.Mező5 AS Neme, Kormányhivatali_állomány.Mező6 AS Főosztály, Kormányhivatali_állomány.Mező7 AS Osztály, "" AS Projekt, Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Kormányhivatali_állomány.Mező9 AS [Ellátott feladat], Kormányhivatali_állomány.Mező10 AS Kinevezés, Kormányhivatali_állomány.[Feladat jellege: szakmai (SZ) / funkcionális (F) feladatellátás;], Kormányhivatali_állomány.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ], Kormányhivatali_állomány.[Heti munkaórák száma], Kormányhivatali_állomány.Mező14 AS [Betöltés aránya], Kormányhivatali_állomány.[Besorolási fokozat kód:], Kormányhivatali_állomány.[Besorolási fokozat megnevezése:], Kormányhivatali_állomány.[Álláshely azonosító], Kormányhivatali_állomány.Mező18 AS [Havi illetmény], Kormányhivatali_állomány.Mező19 AS [Eu finanszírozott], Kormányhivatali_állomány.Mező20 AS [Illetmény forrása], Kormányhivatali_állomány.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h], Kormányhivatali_állomány.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], Kormányhivatali_állomány.[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)], Kormányhivatali_állomány.[Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis], Kormányhivatali_állomány.[Ügyfélszolgálati munkatárs (1) ügyfélszolgálati háttér munkatárs], Kormányhivatali_állomány.Mező26 AS [Képesítést adó végzettség], Kormányhivatali_állomány.Mező27 AS KAB, Kormányhivatali_állomány.[KAB 001-3** Branch ID]
FROM Kormányhivatali_állomány;

#/#/#/
lkKormányhivataliJárásiKözpTörténet
#/#/
SELECT LétszámUnióTörténet.Sorszám, LétszámUnióTörténet.Név, LétszámUnióTörténet.Adóazonosító, LétszámUnióTörténet.[Születési év \ üres állás], LétszámUnióTörténet.Neme, LétszámUnióTörténet.[Járási Hivatal_], LétszámUnióTörténet.Osztály, LétszámUnióTörténet.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], LétszámUnióTörténet.[Ellátott feladat], LétszámUnióTörténet.Kinevezés, LétszámUnióTörténet.[Feladat jellege: szakmai (SZ) / funkcionális (F) feladatellátás;], LétszámUnióTörténet.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ], LétszámUnióTörténet.[Heti munkaórák száma], LétszámUnióTörténet.[Betöltés aránya], LétszámUnióTörténet.[Besorolási fokozat kód:], LétszámUnióTörténet.[Besorolási fokozat megnevezése:], LétszámUnióTörténet.[Álláshely azonosító], LétszámUnióTörténet.[Havi illetmény], LétszámUnióTörténet.[Eu finanszírozott], LétszámUnióTörténet.[Illetmény forrása], LétszámUnióTörténet.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h], LétszámUnióTörténet.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], LétszámUnióTörténet.[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)], LétszámUnióTörténet.[Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis], LétszámUnióTörténet.[Ügyfélszolgálati munkatárs (1) ügyfélszolgálati háttér munkatárs], LétszámUnióTörténet.[Képesítést adó végzettség], LétszámUnióTörténet.KAB, LétszámUnióTörténet.[KAB 001-3** Branch ID], IIf([Adóazonosító] Is Null Or [Adóazonosító]="",0,[Adóazonosító]*1) AS Adójel, tHaviJelentésHatálya1.hatálya
FROM (SELECT *
FROM lktJárási_állomány
UNION SELECT *
FROM lktKormányhivatali_állomány
UNION SELECT *
FROM lktKözpontosítottak
)  AS LétszámUnióTörténet INNER JOIN tHaviJelentésHatálya1 ON LétszámUnióTörténet.hatályaID = tHaviJelentésHatálya1.hatályaID;

#/#/#/
lkKöltözőSzervezetLétszám
#/#/
SELECT lkKeresendők.Sorszám, Tmp.Főosztály, Tmp.Osztály_, Tmp.Létszám
FROM lkKeresendők, lkFőosztályonéntiOsztályonkéntiLétszám AS Tmp
WHERE (((Tmp.Főosztály)=[lkKeresendők].[Főosztály]) AND ((Tmp.Osztály_)=[lkKeresendők].[Osztály])) OR (((Tmp.Főosztály)=[lkKeresendők].[Főosztály]) AND ((Tmp.Osztály_) Like [lkKeresendők].[Osztály]))
ORDER BY lkKeresendők.Sorszám, Tmp.BFKH DESC , Tmp.Sor;

#/#/#/
lkKöltségvetéshezBesorolásonkéntiLétszám01
#/#/
SELECT lkSzemélyek.Adójel, lkSzemélyek.[Jogviszony típusa / jogviszony típus], Nz(IIf([Jogviszony típusa / jogviszony típus]="Munkaviszony",Choose(Left(IIf([Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis] Is Null Or [Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis]="",0,[Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis]),1)*1,"alapfokú","középfokú","felsőfokú","felsőfokú","középfokú","középfokú"),"-"),"középfokú") AS Végzettség, lkSzemélyek.[Státusz neve], lkSzemélyek.[Tartós távollét típusa], lkSzemélyek.[Státusz típusa], lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó havi óraker], Nz([Összesen],[lkSzemélyek].[Kerekített 100 %-os illetmény (eltérítés nélküli)]) AS [Kerekített 100 %-os illetmény (eltérítés nélküli)], Nz([tKöltségvetéshezHivatásosok].[Besorolás],[lkSzemélyek].[Besorolás2]) AS Besorolás2
FROM tKöltségvetéshezHivatásosok RIGHT JOIN (lkJárásiKormányKözpontosítottUnió RIGHT JOIN (lkSzemélyek LEFT JOIN lkBesorolásVáltoztatások ON lkSzemélyek.[Státusz kódja] = lkBesorolásVáltoztatások.ÁlláshelyAzonosító) ON lkJárásiKormányKözpontosítottUnió.Adójel = lkSzemélyek.Adójel) ON tKöltségvetéshezHivatásosok.[Adóazonosító jel] = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null) AND ((lkSzemélyek.[Státusz típusa])="Szervezeti alaplétszám") AND ((lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó havi óraker])>=60));

#/#/#/
lkKöltségvetéshezBesorolásonkéntiLétszám01 másolata
#/#/
SELECT lkSzemélyek.Adójel, lkSzemélyek.[Jogviszony típusa / jogviszony típus], Nz(IIf([Jogviszony típusa / jogviszony típus]="Munkaviszony",Choose(Left(IIf([Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis] Is Null Or [Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis]="",0,[Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis]),1)*1,"alapfokú","középfokú","felsőfokú","felsőfokú","középfokú","középfokú"),"-"),"középfokú") AS Végzettség, lkSzemélyek.[Státusz neve], lkSzemélyek.[Tartós távollét típusa], lkSzemélyek.[Státusz típusa], lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó havi óraker], Nz([Összesen],[lkSzemélyek].[Kerekített 100 %-os illetmény (eltérítés nélküli)]) AS [Kerekített 100 %-os illetmény (eltérítés nélküli)], Nz([tKöltségvetéshezHivatásosok].[Besorolás],[lkSzemélyek].[Besorolás2]) AS Besorolás2
FROM tKöltségvetéshezHivatásosok RIGHT JOIN (lkJárásiKormányKözpontosítottUnió RIGHT JOIN (lkSzemélyek LEFT JOIN lkBesorolásVáltoztatások ON lkSzemélyek.[Státusz kódja] = lkBesorolásVáltoztatások.ÁlláshelyAzonosító) ON lkJárásiKormányKözpontosítottUnió.Adójel = lkSzemélyek.Adójel) ON tKöltségvetéshezHivatásosok.[Adóazonosító jel] = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null) AND ((lkSzemélyek.[Státusz típusa])="Szervezeti alaplétszám") AND ((lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó havi óraker])>=60));

#/#/#/
lkKöltségvetéshezBesorolásonkéntiLétszám02
#/#/
SELECT lkKöltségvetéshezBesorolásonkéntiLétszám01.[Jogviszony típusa / jogviszony típus] AS Jogviszony, lkKöltségvetéshezBesorolásonkéntiLétszám01.Végzettség, IIf([Jogviszony típusa / jogviszony típus]="Munkaviszony","-",[Besorolás2]) AS Besorolás, Count(lkKöltségvetéshezBesorolásonkéntiLétszám01.Adójel) AS [Betöltött létszám], Round([Betöltött létszám]*Nz([Engedélyezett létszám, ha semmi, akkor 5350],5350)/(Select count(adójel) from lkKöltségvetéshezBesorolásonkéntiLétszám01),2) AS [Statisztikai létszám], Sum(lkKöltségvetéshezBesorolásonkéntiLétszám01.[Kerekített 100 %-os illetmény (eltérítés nélküli)]) AS Illetmény
FROM lkKöltségvetéshezBesorolásonkéntiLétszám01
GROUP BY lkKöltségvetéshezBesorolásonkéntiLétszám01.[Jogviszony típusa / jogviszony típus], lkKöltségvetéshezBesorolásonkéntiLétszám01.Végzettség, IIf([Jogviszony típusa / jogviszony típus]="Munkaviszony","-",[Besorolás2]);

#/#/#/
lkKöltségvetéshezBesorolásonkéntiLétszám02Átlagbér
#/#/
SELECT Sum(lkKöltségvetéshezBesorolásonkéntiLétszám02.[Betöltött létszám]) AS Fő, Sum(lkKöltségvetéshezBesorolásonkéntiLétszám02.Illetmény) AS Ft, Nz([Új átlagbér, ha semmi, akkor 585000],585000)/([Ft]/[Fő]) AS Átlagbérszorzó
FROM lkKöltségvetéshezBesorolásonkéntiLétszám02;

#/#/#/
lkKöltségvetéshezBesorolásonkéntiLétszám03
#/#/
SELECT tKöltségvetéshezBesorolások.Sor, tKöltségvetéshezBesorolások.Besorolás, Sum(lkKöltségvetéshezBesorolásonkéntiLétszám02.[Betöltött létszám]) AS [SumOfBetöltött létszám], Sum(lkKöltségvetéshezBesorolásonkéntiLétszám02.[Statisztikai létszám]) AS [SumOfStatisztikai létszám], Sum(lkKöltségvetéshezBesorolásonkéntiLétszám02.Illetmény) AS SumOfIlletmény, Sum([Statisztikai létszám]/[Betöltött létszám]*[Illetmény]*(SELECT first([Átlagbérszorzó]) FROM lkKöltségvetéshezBesorolásonkéntiLétszám02Átlagbér )) AS [Statisztikai illetmény]
FROM tKöltségvetéshezBesorolások RIGHT JOIN lkKöltségvetéshezBesorolásonkéntiLétszám02 ON (tKöltségvetéshezBesorolások.BesorolásSzemélytörzs = lkKöltségvetéshezBesorolásonkéntiLétszám02.Besorolás) AND (tKöltségvetéshezBesorolások.Végzettség = lkKöltségvetéshezBesorolásonkéntiLétszám02.Végzettség) AND (tKöltségvetéshezBesorolások.Jogviszony = lkKöltségvetéshezBesorolásonkéntiLétszám02.[Jogviszony])
GROUP BY tKöltségvetéshezBesorolások.Sor, tKöltségvetéshezBesorolások.Besorolás;

#/#/#/
lkKöltségvetéshezHivatásosokKimutatás
#/#/
SELECT lkSzemélyek.[KIRA jogviszony jelleg], lkSzemélyek.[Besorolási  fokozat (KT)], IIf(Nz([tKöltségvetéshezHivatásosok].[Adóazonosító jel],0)>0,True,False) AS [Táblában-e], Count(lkSzemélyek.Adójel) AS CountOfAdójel
FROM tKöltségvetéshezHivatásosok RIGHT JOIN lkSzemélyek ON tKöltségvetéshezHivatásosok.[Adóazonosító jel] = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.Főosztály) Like "Tűz*"))
GROUP BY lkSzemélyek.[KIRA jogviszony jelleg], lkSzemélyek.[Besorolási  fokozat (KT)], IIf(Nz([tKöltségvetéshezHivatásosok].[Adóazonosító jel],0)>0,True,False);

#/#/#/
lkKözeliLejáróHatározottIdősök
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], IIf(dtátal([Határozott idejű _szerződés/kinevezés lejár])=0,#1/1/3000#,dtátal([Határozott idejű _szerződés/kinevezés lejár])) AS [Szerződés lejár], kt_azNexon_Adójel02.NLink
FROM kt_azNexon_Adójel02 RIGHT JOIN lkSzemélyek ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((IIf(dtátal([Határozott idejű _szerződés/kinevezés lejár])=0,#1/1/3000#,dtátal([Határozott idejű _szerződés/kinevezés lejár])))<DateAdd("d",30,Now())) AND ((lkSzemélyek.[Státusz neve])="álláshely"))
ORDER BY IIf(dtátal([Határozott idejű _szerződés/kinevezés lejár])=0,#1/1/3000#,dtátal([Határozott idejű _szerződés/kinevezés lejár]));

#/#/#/
lkKözigazgatásiAlapvizsgaAlólMentesítettek
#/#/
SELECT lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Dolgozó születési neve], lkSzemélyek.[Anyja neve], lkSzemélyek.[Születési idő], lkSzemélyek.[Hivatali email], lkSzemélyek.[Jogviszony kezdete (belépés dátuma)]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)]) Between #1/5/2020# And #4/30/2022#) AND ((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null) AND ((lkSzemélyek.[Jogviszony típusa / jogviszony típus]) Like "Kormány*") AND ((lkSzemélyek.[Besorolási  fokozat (KT)]) Not Like "*osztály*" And (lkSzemélyek.[Besorolási  fokozat (KT)]) Not Like "*járás*" And (lkSzemélyek.[Besorolási  fokozat (KT)]) Not Like "*igazg*" And (lkSzemélyek.[Besorolási  fokozat (KT)])<>"főispán"));

#/#/#/
lkKözigazgatásiAlapvizsgaKötelezettségHiánya
#/#/
SELECT lkKözigazgatásiAlapvizsgaKötelezettségHiánya00.Főosztály, lkKözigazgatásiAlapvizsgaKötelezettségHiánya00.Osztály, lkKözigazgatásiAlapvizsgaKötelezettségHiánya00.Név, lkKözigazgatásiAlapvizsgaKötelezettségHiánya00.Belépés, lkKözigazgatásiAlapvizsgaKötelezettségHiánya00.NLink
FROM lkKözigazgatásiAlapvizsgaKötelezettségHiánya00
ORDER BY lkKözigazgatásiAlapvizsgaKötelezettségHiánya00.BFKH, lkKözigazgatásiAlapvizsgaKötelezettségHiánya00.Név;

#/#/#/
lkKözigazgatásiAlapvizsgaKötelezettségHiánya00
#/#/
SELECT TOP 1000 lkSzemélyek.Adójel, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS Belépés, kt_azNexon_Adójel02.NLink, lkSzemélyek.BFKH
FROM (lkSzemélyek LEFT JOIN kt_azNexon_Adójel02 ON lkSzemélyek.Adójel = kt_azNexon_Adójel02.Adójel) LEFT JOIN lkKözigazgatásiAlapvizsgávalRendelkezők ON lkSzemélyek.Adójel = lkKözigazgatásiAlapvizsgávalRendelkezők.Adójel
WHERE (((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)])<Date()) AND ((lkSzemélyek.[Alapvizsga mentesség])<>True) AND ((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Alapvizsga letétel tényleges határideje]) Is Null) AND ((lkSzemélyek.[Státusz típusa]) Is Not Null) AND ((lkKözigazgatásiAlapvizsgávalRendelkezők.Adójel) Is Null) AND ((lkSzemélyek.[Jogviszony típusa / jogviszony típus]) Like "ko*") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null Or (lkSzemélyek.[Tartós távollét típusa])=""))
ORDER BY lkSzemélyek.Adójel;

#/#/#/
lkKözigazgatásiAlapvizsgávalRendelkezők
#/#/
SELECT lkKözigazgatásiVizsga.Adójel, lkKözigazgatásiVizsga.[Vizsga típusa], lkKözigazgatásiVizsga.[Oklevél száma], lkKözigazgatásiVizsga.[Oklevél dátuma], lkKözigazgatásiVizsga.[Oklevél lejár], lkKözigazgatásiVizsga.[Vizsga eredménye], lkKözigazgatásiVizsga.Mentesség
FROM lkKözigazgatásiVizsga
WHERE (((lkKözigazgatásiVizsga.[Vizsga típusa])="Közigazgatási alapvizsga") AND ((lkKözigazgatásiVizsga.Mentesség)=False));

#/#/#/
lkKözigazgatásiVizsga
#/#/
SELECT [Dolgozó azonosító]*1 AS Adójel, tKözigazgatásiVizsga.*
FROM tKözigazgatásiVizsga;

#/#/#/
lkKözpontosítottak
#/#/
SELECT Központosítottak.Sorszám, Központosítottak.Név, Központosítottak.Adóazonosító, Központosítottak.Mező4 AS [Születési év \ üres állás], "" AS Nem, Replace(IIf([Megyei szint VAGY Járási Hivatal]="Megyei szint",[Központosítottak].[Mező6],[Megyei szint VAGY Járási Hivatal]),"Budapest Főváros Kormányhivatala ","BFKH ") AS Főoszt, Központosítottak.Mező7 AS Osztály, Központosítottak.[Projekt megnevezése], Központosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Központosítottak.Mező10 AS [Ellátott feladat], Központosítottak.Mező11 AS Kinevezés, "SZ" AS [Feladat jellege], Központosítottak.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ], 0 AS [Heti munkaórák száma], 1 AS [Betöltés aránya], Központosítottak.[Besorolási fokozat kód:], Központosítottak.[Besorolási fokozat megnevezése:], Központosítottak.[Álláshely azonosító], Központosítottak.Mező17 AS [Havi illetmény], "" AS [Eu finanszírozott], "" AS [Illetmény forrása], "" AS [Garantált bérminimumban részesül (GB) / tartós távollévő nincs h], Központosítottak.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], Központosítottak.[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)], Központosítottak.[Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis], "" AS [Ügyfélszolgálati munkatárs (1) ügyfélszolgálati háttér munkatárs], "" AS [Képesítést adó végzettség], "" AS KAB, "" AS [KAB 001-3** Branch ID]
FROM Központosítottak
WHERE ((("")=True Or ("")='IIf([Neme]="Nő";2;1)'));

#/#/#/
lkKözpontosítottakLétszámánakaMegoszlása
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, Nz([Költséghely*],[Státusz költséghelyének neve ]) AS Ktghely, Count(lkSzemélyek.Azonosító) AS Létszám
FROM tEsetiProjektbeFelveendők RIGHT JOIN (kt_azNexon_Adójel02 RIGHT JOIN lkSzemélyek ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel) ON tEsetiProjektbeFelveendők.[Személy azonosítója*] = kt_azNexon_Adójel02.azNexon
WHERE (((lkSzemélyek.[Státusz típusa]) Like "Köz*"))
GROUP BY lkSzemélyek.Főosztály, lkSzemélyek.Osztály, Nz([Költséghely*],[Státusz költséghelyének neve ]);

#/#/#/
lkKözpontosítottÁlláshelyenElőfordulókSzáma
#/#/
SELECT subquery.Jogviszony, Count(subquery.Adóazonosító) AS Létszám
FROM (SELECT DISTINCT IIf([Besorolási fokozat kód:] Like "Mt.*","munkaviszony","kormánytisztviselői jogviszony") AS Jogviszony, lktKözpontosítottak.Adóazonosító FROM lktKözpontosítottak INNER JOIN tHaviJelentésHatálya ON lktKözpontosítottak.hatályaID = tHaviJelentésHatálya.hatályaID WHERE (tHaviJelentésHatálya.hatálya Between Nz([Kezdő dátum, ha semmi, akkor az előző év eleje],DateSerial(Year(Date())-1,1,1)) And Nz([Vége dátum, ha semmi, akkor az előző év vége],DateSerial(Year(Date())-1,12,31))) And tHaviJelentésHatálya.hatálya=DateSerial(Year([hatálya]),Month([hatálya])+1,0) And lktKözpontosítottak.[Születési év \ üres állás]<>"üres állás")  AS subquery
GROUP BY subquery.Jogviszony;

#/#/#/
lkKSZDRbenNemSzereplők
#/#/
SELECT DISTINCT bfkh([FőosztályKód]) AS BFKH, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS Belépés
FROM lkSzemélyek LEFT JOIN tKSZDR ON lkSzemélyek.[Adóazonosító jel] = tKSZDR.[Adóazonosító jel]
WHERE (((tKSZDR.[Teljes név]) Is Null) AND ((lkSzemélyek.[Státusz neve])="álláshely"))
ORDER BY bfkh([FőosztályKód]), lkSzemélyek.[Jogviszony kezdete (belépés dátuma)];

#/#/#/
lkKSZDRhibákKimenet
#/#/
SELECT IIf(Nz([lkSzemélyek].[Főosztály],"")="",[lkKilépőUnió].[Főosztály],[lkSzemélyek].[Főosztály]) AS Főoszt, IIf(Nz([lkSzemélyek].[osztály],"")="",[lkKilépőUnió].[osztály],[lkSzemélyek].[osztály]) AS Oszt, tKSZDRhibák.Név, tKSZDRhibák.Adószám, tKSZDRhibák.[KSZDR hiányzó adat], tKSZDRhibák.Megoldások, lkSzemélyek.[Jogviszony vége (kilépés dátuma)]
FROM lkKilépőUnió RIGHT JOIN (lkSzemélyek RIGHT JOIN tKSZDRhibák ON lkSzemélyek.Adójel = tKSZDRhibák.Adószám) ON lkKilépőUnió.Adójel = tKSZDRhibák.Adószám;

#/#/#/
lkktRégiHibákIntézkedésekLegutolsóIntézkedés
#/#/
SELECT lkktRégiHibákIntézkedésekUtolsóIntézkedés.HASH, lkktRégiHibákIntézkedésekUtolsóIntézkedés.azIntézkedések, lkktRégiHibákIntézkedésekUtolsóIntézkedés.IntézkedésDátuma, lkktRégiHibákIntézkedésekUtolsóIntézkedés.azIntFajta, lkktRégiHibákIntézkedésekUtolsóIntézkedés.rögzítésDátuma, lkktRégiHibákIntézkedésekUtolsóIntézkedés.Hivatkozás, lkktRégiHibákIntézkedésekUtolsóIntézkedés.IntézkedésFajta
FROM lkktRégiHibákIntézkedésekUtolsóIntézkedés
WHERE (((lkktRégiHibákIntézkedésekUtolsóIntézkedés.azIntézkedések)=(SELECT top 1 First(Tmp.azIntézkedések) AS FirstOfazIntézkedések
FROM lkktRégiHibákIntézkedésekUtolsóIntézkedés AS Tmp
WHERE (((Tmp.Hash)=[lkktRégiHibákIntézkedésekUtolsóIntézkedés].[hash]))
GROUP BY Tmp.IntézkedésDátuma, Tmp.rögzítésDátuma
ORDER BY Tmp.IntézkedésDátuma DESC , Tmp.rögzítésDátuma DESC
)));

#/#/#/
lkktRégiHibákIntézkedésekUtolsóIntézkedés
#/#/
SELECT ktRégiHibákIntézkedések.HASH, ktRégiHibákIntézkedések.azIntézkedések, lkIntézkedések.IntézkedésDátuma, lkIntézkedések.azIntFajta, ktRégiHibákIntézkedések.rögzítésDátuma, lkIntézkedések.Hivatkozás, lkIntézkedések.IntézkedésFajta
FROM lkIntézkedések INNER JOIN ktRégiHibákIntézkedések ON lkIntézkedések.azIntézkedések = ktRégiHibákIntézkedések.azIntézkedések;

#/#/#/
lkLakcímek
#/#/
SELECT DISTINCT lkSzemélyek.Adójel, Trim(Replace(IIf(Len(Nz([Tartózkodási lakcím],Nz([Állandó lakcím],"")))<2,Nz([Állandó lakcím],""),Nz([Tartózkodási lakcím],Nz([Állandó lakcím],""))),"Magyarország,","")) AS Cím, lkSzemélyek.[Állandó lakcím], lkSzemélyek.[Tartózkodási lakcím], IIf(IsNumeric(Left([Cím],1)),Left([Cím],4),0)*1 AS Irsz
FROM lkSzemélyek;

#/#/#/
lkLaktámFluktuációLista01
#/#/
SELECT Nü([tKormányhivatali_állomány].[Adóazonosító],"-") AS [Adóazonosító jel], tKormányhivatali_állomány.Név, tKormányhivatali_állomány.Mező6 AS Főosztály, tHaviJelentésHatálya.hatálya, Year([MaxOfhatálya]) & ". " & Right("0" & Month([MaxOfhatálya]),2) & "." AS [Utolsó teljes hónapja a főosztályon]
FROM (SELECT tKormányhivatali_állomány.Adóazonosító, Max(tHaviJelentésHatálya.hatálya) AS MaxOfhatálya FROM tKormányhivatali_állomány INNER JOIN tHaviJelentésHatálya ON tKormányhivatali_állomány.hatályaID = tHaviJelentésHatálya.hatályaID WHERE (((tKormányhivatali_állomány.Mező6)="Lakástámogatási Főosztály")) GROUP BY tKormányhivatali_állomány.Adóazonosító)  AS MaxLaktám RIGHT JOIN (tKormányhivatali_állomány INNER JOIN tHaviJelentésHatálya ON tKormányhivatali_állomány.hatályaID = tHaviJelentésHatálya.hatályaID) ON MaxLaktám.Adóazonosító = tKormányhivatali_állomány.Adóazonosító
WHERE (((Nü(tKormányhivatali_állomány.Adóazonosító,"-"))<>"-") And ((tKormányhivatali_állomány.Mező6)="Lakástámogatási Főosztály") And ((tHaviJelentésHatálya.hatályaID)=47));

#/#/#/
lkLaktámFluktuációLista02
#/#/
SELECT lkSzemélyek.[Adóazonosító jel], Nü([Főosztály],"Kilépett: " & [Jogviszony vége (kilépés dátuma)]) AS [Jelenlegi szervezeti egysége]
FROM lkSzemélyek;

#/#/#/
lkLaktámFluktuációLista03
#/#/
SELECT lkLaktámFluktuációLista01.[Adóazonosító jel], lkLaktámFluktuációLista01.Név, lkLaktámFluktuációLista01.Főosztály, lkLaktámFluktuációLista01.hatálya, lkLaktámFluktuációLista01.[Utolsó teljes hónapja a főosztályon], lkLaktámFluktuációLista02.[Jelenlegi szervezeti egysége]
FROM lkLaktámFluktuációLista01 LEFT JOIN lkLaktámFluktuációLista02 ON lkLaktámFluktuációLista01.[Adóazonosító jel] = lkLaktámFluktuációLista02.[Adóazonosító jel];

#/#/#/
lkLaktámFluktuációLista04
#/#/
SELECT lkSzemélyek.[Adóazonosító jel], lkSzemélyek.[Dolgozó teljes neve] AS Név, IIf([Jogviszony vége (kilépés dátuma)] Is Null,Year([Jogviszony vége (kilépés dátuma)]) & ". " & Right("0" & Month([Jogviszony vége (kilépés dátuma)]),2) & ".",Year(Now()) & ". " & Right("0" & Month(Now()),2) & ".") AS [Utolsó teljes hónapja a főosztályon], lkSzemélyek.Főosztály AS [Jelenlegi szervezeti egysége]
FROM lkSzemélyek LEFT JOIN tmpLaktámFluktuációLista ON lkSzemélyek.Adójel = tmpLaktámFluktuációLista.[Adóazonosító jel]
WHERE (((lkSzemélyek.Főosztály) Like "Lakás*") AND ((tmpLaktámFluktuációLista.[Adóazonosító jel]) Is Null));

#/#/#/
lkLegkorábbiKinevezés
#/#/
SELECT tSzemélyek.[Adóazonosító jel], Min(tSzemélyek.[Jogviszony kezdete (belépés dátuma)]) AS [Első belépése]
FROM tSzemélyek
WHERE (((tSzemélyek.[Szerződés/kinevezés verzió_érvényesség kezdete])>0))
GROUP BY tSzemélyek.[Adóazonosító jel];

#/#/#/
lkLegmagasabbVégzettség05
#/#/
SELECT tLegmagasabbVégzettség04.[Dolgozó azonosító], First(tLegmagasabbVégzettség04.azFok) AS FirstOfazFok
FROM tLegmagasabbVégzettség04
GROUP BY tLegmagasabbVégzettség04.[Dolgozó azonosító]
ORDER BY tLegmagasabbVégzettség04.[Dolgozó azonosító], First(tLegmagasabbVégzettség04.azFok) DESC;

#/#/#/
lkLegrégibbHibák
#/#/
SELECT tRégiHibák.[Második mező], tRégiHibák.[Első Időpont]
FROM tRégiHibák
WHERE ((((select max([utolsó időpont]) from tRégiHibák ))=[Utolsó Időpont]))
GROUP BY tRégiHibák.[Második mező], tRégiHibák.[Első Időpont], tRégiHibák.[Utolsó Időpont]
ORDER BY tRégiHibák.[Első Időpont];

#/#/#/
lkLegrégibbHibák_aktív_statisztika
#/#/
SELECT TOP 10 ffsplit([Második mező],"|",1) AS Főosztály, Count(tRégiHibák.[Első Időpont]) AS [Szükséges intézkedések száma]
FROM lkktRégiHibákIntézkedésekLegutolsóIntézkedés RIGHT JOIN tRégiHibák ON lkktRégiHibákIntézkedésekLegutolsóIntézkedés.HASH = tRégiHibák.[Első mező]
WHERE ((((select max([utolsó időpont]) from tRégiHibák where lekérdezésneve <>"lkÜresÁlláshelyekÁllapotfelmérő" And lekérdezésneve <>"lkFontosHiányzóAdatok02"))=[Utolsó Időpont]) AND ((lkktRégiHibákIntézkedésekLegutolsóIntézkedés.IntézkedésFajta)="referens beavatkozását igényli" Or (lkktRégiHibákIntézkedésekLegutolsóIntézkedés.IntézkedésFajta) Is Null Or (lkktRégiHibákIntézkedésekLegutolsóIntézkedés.IntézkedésFajta)="hiba") AND ((tRégiHibák.lekérdezésNeve)<>"lkÜresÁlláshelyekÁllapotfelmérő"))
GROUP BY ffsplit([Második mező],"|",1)
ORDER BY Count(tRégiHibák.[Első Időpont]) DESC;

#/#/#/
lkLegrégibbHibák_aktív_statisztika_előkészítés
#/#/
SELECT Replace(ffsplit([Második mező],"|",1),"Budapest Főváros Kormányhivatala","BFKH") AS Főosztály, tRégiHibák.[Második mező], tRégiHibák.[Első Időpont], tRégiHibák.[Utolsó Időpont]
FROM lkktRégiHibákIntézkedésekLegutolsóIntézkedés RIGHT JOIN tRégiHibák ON lkktRégiHibákIntézkedésekLegutolsóIntézkedés.HASH = tRégiHibák.[Első mező]
WHERE ((((select max([utolsó időpont]) from tRégiHibák where lekérdezésneve <>"lkÜresÁlláshelyekÁllapotfelmérő" And lekérdezésneve <>"lkFontosHiányzóAdatok02"))=[Utolsó Időpont]) AND ((lkktRégiHibákIntézkedésekLegutolsóIntézkedés.IntézkedésFajta)="referens beavatkozását igényli" Or (lkktRégiHibákIntézkedésekLegutolsóIntézkedés.IntézkedésFajta) Is Null Or (lkktRégiHibákIntézkedésekLegutolsóIntézkedés.IntézkedésFajta)="hiba") AND ((tRégiHibák.lekérdezésNeve)<>"lkÜresÁlláshelyekÁllapotfelmérő" And (tRégiHibák.lekérdezésNeve)<>"lkFontosHiányzóAdatok02"))
ORDER BY tRégiHibák.[Első Időpont];

#/#/#/
lkLegrégibbHibák_aktív_statisztika2
#/#/
SELECT lkLegrégibbHibák_aktív_statisztika_előkészítés.Főosztály, Round(Max([Utolsó Időpont]-[Első Időpont]),0) AS [Legrégebbi hiba (nap)], Round(Avg([Utolsó időpont]-[Első Időpont]),0) AS [Átlag (nap)], Count(lkLegrégibbHibák_aktív_statisztika_előkészítés.[Első Időpont]) AS [Hibák száma (db)], Round(Sum([Utolsó időpont]-[Első Időpont]),0) AS Súlyosság
FROM lkLegrégibbHibák_aktív_statisztika_előkészítés
GROUP BY lkLegrégibbHibák_aktív_statisztika_előkészítés.Főosztály
ORDER BY Round(Max([Utolsó Időpont]-[Első Időpont]),0) DESC , Round(Sum([Utolsó időpont]-[Első Időpont]),0) DESC , Count(lkLegrégibbHibák_aktív_statisztika_előkészítés.[Első Időpont]) DESC;

#/#/#/
lkLegrégibbHibák_aktív_statisztika3
#/#/
SELECT lkLegrégibbHibák_aktív_statisztika_előkészítés.Főosztály, Round(Max(([Utolsó időpont]-[Első Időpont])),0) AS [Legrégebbi hiba (nap)], Round(Avg([Utolsó időpont]-[Első Időpont]),0) AS [Átlag (nap)], Count(lkLegrégibbHibák_aktív_statisztika_előkészítés.[Első Időpont]) AS [Hibák száma (db)], Round(Sum([Utolsó időpont]-[Első Időpont]),0) AS Súlyosság
FROM lkLegrégibbHibák_aktív_statisztika_előkészítés
GROUP BY lkLegrégibbHibák_aktív_statisztika_előkészítés.Főosztály
HAVING (((Round(Sum([Utolsó időpont]-[Első Időpont]),0))>=1000))
ORDER BY Round(Sum([Utolsó időpont]-[Első Időpont]),0) DESC , Count(lkLegrégibbHibák_aktív_statisztika_előkészítés.[Első Időpont]) DESC , Round(Avg([Utolsó időpont]-[Első Időpont]),0) DESC;

#/#/#/
lkLegrégibbHibák_statisztika
#/#/
SELECT TOP 100 ffsplit([Második mező],"|",1) AS Főosztály, Count(lkLegrégibbHibák_statisztika_előkészítés.[Első Időpont]) AS [Szükséges intézkedések száma]
FROM lkLegrégibbHibák_statisztika_előkészítés
GROUP BY ffsplit([Második mező],"|",1)
ORDER BY Count(lkLegrégibbHibák_statisztika_előkészítés.[Első Időpont]) DESC;

#/#/#/
lkLegrégibbHibák_statisztika_előkészítés
#/#/
SELECT tRégiHibák.[Második mező], tRégiHibák.[Első Időpont]
FROM tRégiHibák
WHERE ((((select max([utolsó időpont]) from tRégiHibák ))=[Utolsó Időpont]) AND (((select min([első időpont]) from lkLegrégibbHibák ))=[Első Időpont]))
GROUP BY tRégiHibák.[Második mező], tRégiHibák.[Első Időpont], tRégiHibák.[Utolsó Időpont]
ORDER BY tRégiHibák.[Első Időpont];

#/#/#/
lkLegrégibbHibák_teljes_statisztika
#/#/
SELECT TOP 10 ffsplit([Második mező],"|",1) AS Főosztály, Count(lkLegrégibbHibák.[Első Időpont]) AS [Szükséges intézkedések száma]
FROM lkLegrégibbHibák
GROUP BY ffsplit([Második mező],"|",1)
ORDER BY Count(lkLegrégibbHibák.[Első Időpont]) DESC;

#/#/#/
lkLehethogyJogosultakUtazásiKedvezményre
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Adójel, "FőosztRöv_" & [lkszemélyek].[Dolgozó teljes neve] & "_(" & [azNexon] & ")_utazási.pdf" AS Fájlnév
FROM lkSzemélyek INNER JOIN (kt_azNexon_Adójel02 INNER JOIN (lkBiztosanJogosultakUtazásiKedvezményre RIGHT JOIN (SELECT lkFordulónaptólABelépésigElőzőMunkahelyMunkanapjai.Adójel, lkFordulónaptólABelépésigElőzőMunkahelyMunkanapjai.Napok
FROM lkFordulónaptólABelépésigElőzőMunkahelyMunkanapjai
UNION SELECT lkFordulónaptólEgyévigMindenJogviszonyMunkanapjai.Adójel, lkFordulónaptólEgyévigMindenJogviszonyMunkanapjai.Napok
FROM lkFordulónaptólEgyévigMindenJogviszonyMunkanapjai)  AS UNIÓ ON lkBiztosanJogosultakUtazásiKedvezményre.Adójel = UNIÓ.Adójel) ON kt_azNexon_Adójel02.Adójel = UNIÓ.Adójel) ON lkSzemélyek.Adójel = UNIÓ.Adójel
WHERE (((lkBiztosanJogosultakUtazásiKedvezményre.Adójel) Is Null))
GROUP BY lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Adójel, "FőosztRöv_" & [lkszemélyek].[Dolgozó teljes neve] & "_(" & [azNexon] & ")_utazási.pdf", lkSzemélyek.BFKH
HAVING (((Sum(UNIÓ.Napok))>=365))
ORDER BY lkSzemélyek.BFKH, lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkLejáróHatáridők
#/#/
SELECT tLejáróHatáridők.[Szervezeti egység kód], tLejáróHatáridők.[Szervezeti egység], tLejáróHatáridők.[Szervezeti szint száma-neve], tLejáróHatáridők.[Jogviszony típus], dtátal([tLejáróHatáridők].[Jogviszony kezdete]) AS [Jogviszony kezdete], dtátal([tLejáróHatáridők].[Jogviszony vége]) AS [Jogviszony vége], tLejáróHatáridők.[Dolgozó neve], tLejáróHatáridők.[Adóazonosító jel], tLejáróHatáridők.[Figyelendő dátum típusa], dtátal([tLejáróHatáridők].[Figyelendő dátum]) AS [Figyelendő dátum], tLejáróHatáridők.[Szint 1 szervezeti egység kód], tLejáróHatáridők.[Szint 1 szervezeti egység név], tLejáróHatáridők.[Szint 2 szervezeti egység kód], tLejáróHatáridők.[Szint 2 szervezeti egység név], tLejáróHatáridők.[Szint 3 szervezeti egység kód], tLejáróHatáridők.[Szint 3 szervezeti egység név], tLejáróHatáridők.[Szint 4 szervezeti egység kód], tLejáróHatáridők.[Szint 4 szervezeti egység név], tLejáróHatáridők.[Szint 5 szervezeti egység kód], tLejáróHatáridők.[Szint 5 szervezeti egység név], tLejáróHatáridők.[Szint 6 szervezeti egység kód], tLejáróHatáridők.[Szint 6 szervezeti egység név], tLejáróHatáridők.[Szint 7 szervezeti egység kód], tLejáróHatáridők.[Szint 7 szervezeti egység név], tLejáróHatáridők.[Szint 8 szervezeti egység kód], tLejáróHatáridők.[Szint 8 szervezeti egység név], tLejáróHatáridők.[Szint 9 szervezeti egység kód], tLejáróHatáridők.[Szint 9 szervezeti egység név], tLejáróHatáridők.[Szint 10 szervezeti egység kód], tLejáróHatáridők.[Szint 10 szervezeti egység név]
FROM tLejáróHatáridők;

#/#/#/
lkLejáróHatáridők1
#/#/
SELECT tLejáróHatáridők.[Szervezeti egység kód], tLejáróHatáridők.[Szervezeti egység], tLejáróHatáridők.[Szervezeti szint száma-neve], tLejáróHatáridők.[Jogviszony típus], dtátal([tLejáróHatáridők].[Jogviszony kezdete]) AS [Jogviszony kezdete], dtátal([tLejáróHatáridők].[Jogviszony vége]) AS [Jogviszony vége], tLejáróHatáridők.[Dolgozó neve], tLejáróHatáridők.[Adóazonosító jel], tLejáróHatáridők.[Figyelendő dátum típusa], dtátal([tLejáróHatáridők].[Figyelendő dátum]) AS [Figyelendő dátum], tLejáróHatáridők.[Szint 1 szervezeti egység kód], tLejáróHatáridők.[Szint 1 szervezeti egység név], tLejáróHatáridők.[Szint 2 szervezeti egység kód], tLejáróHatáridők.[Szint 2 szervezeti egység név], tLejáróHatáridők.[Szint 3 szervezeti egység kód], tLejáróHatáridők.[Szint 3 szervezeti egység név], tLejáróHatáridők.[Szint 4 szervezeti egység kód], tLejáróHatáridők.[Szint 4 szervezeti egység név], tLejáróHatáridők.[Szint 5 szervezeti egység kód], tLejáróHatáridők.[Szint 5 szervezeti egység név], tLejáróHatáridők.[Szint 6 szervezeti egység kód], tLejáróHatáridők.[Szint 6 szervezeti egység név], tLejáróHatáridők.[Szint 7 szervezeti egység kód], tLejáróHatáridők.[Szint 7 szervezeti egység név], tLejáróHatáridők.[Szint 8 szervezeti egység kód], tLejáróHatáridők.[Szint 8 szervezeti egység név], tLejáróHatáridők.[Szint 9 szervezeti egység kód], tLejáróHatáridők.[Szint 9 szervezeti egység név], tLejáróHatáridők.[Szint 10 szervezeti egység kód], tLejáróHatáridők.[Szint 10 szervezeti egység név]
FROM tLejáróHatáridők;

#/#/#/
lkLejártAlkalmasságiÉrvényesség
#/#/
SELECT lkSzemélyek.Főosztály AS Főosztály, lkSzemélyek.Osztály AS Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Orvosi vizsgálat következő időpontja], kt_azNexon_Adójel02.NLink AS NLink
FROM kt_azNexon_Adójel02 RIGHT JOIN lkSzemélyek ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Orvosi vizsgálat következő időpontja])<DateSerial(Year(Date()),Month(Date())-11,1)-1) AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null) AND ((lkSzemélyek.[státusz neve])="Álláshely"))
ORDER BY lkSzemélyek.BFKH;

#/#/#/
lkLejártAlkalmasságiÉrvényesség1
#/#/
SELECT lkSzemélyek.Főosztály AS Főosztály, lkSzemélyek.Osztály AS Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Orvosi vizsgálat következő időpontja], kt_azNexon_Adójel02.NLink AS NLink
FROM kt_azNexon_Adójel02 RIGHT JOIN lkSzemélyek ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Orvosi vizsgálat következő időpontja])<DateSerial(Year(Date()),Month(Date())-11,1)-1) AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null) AND ((lkSzemélyek.[státusz neve])="Álláshely"))
ORDER BY lkSzemélyek.BFKH;

#/#/#/
lkLekérdezésekMezőinekSzáma
#/#/
SELECT lkEllenőrzőLekérdezések2.EllenőrzőLekérdezés, Count(MSysQueries.Attribute) AS CountOfAttribute
FROM lkEllenőrzőLekérdezések2 INNER JOIN (MSysObjects INNER JOIN MSysQueries ON MSysObjects.Id = MSysQueries.ObjectId) ON lkEllenőrzőLekérdezések2.EllenőrzőLekérdezés = MSysObjects.Name
WHERE (((MSysQueries.Attribute)=6) AND ((lkEllenőrzőLekérdezések2.Kimenet)=True))
GROUP BY lkEllenőrzőLekérdezések2.EllenőrzőLekérdezés;

#/#/#/
lkLekérdezésekTípusokCsoportok
#/#/
SELECT nSelect([EllenőrzőLekérdezés]) AS db, tLekérdezésTípusok.Osztály, tLekérdezésTípusok.LapNév, tLekérdezésTípusok.Megjegyzés, tEllenőrzőLekérdezések.EllenőrzőLekérdezés, tUnionCsoportok.azUnion
FROM tUnionCsoportok RIGHT JOIN (tLekérdezésTípusok RIGHT JOIN tEllenőrzőLekérdezések ON tLekérdezésTípusok.azETípus = tEllenőrzőLekérdezések.azETípus) ON tUnionCsoportok.azUnion = tEllenőrzőLekérdezések.azUnion
ORDER BY tLekérdezésTípusok.Osztály, tLekérdezésTípusok.LapNév;

#/#/#/
lkLekérdezésekTípusokCsoportok_allekérdezésCsoportokSzáma
#/#/
SELECT Count(DistinctlkLekérdezésekTípusokCsoportok.azUnion) AS AlLekérdezésCsoportokSzáma
FROM (SELECT DISTINCT lkLekérdezésekTípusokCsoportok.[azUnion] FROM lkLekérdezésekTípusokCsoportok WHERE (((lkLekérdezésekTípusokCsoportok.[azUnion]) Is Not Null)))  AS DistinctlkLekérdezésekTípusokCsoportok;

#/#/#/
lkLekérdezésTípusok
#/#/
SELECT tLekérdezésTípusok.azETípus, tLekérdezésTípusok.LapNév AS Fejezet, tLekérdezésOsztályok.Osztály AS Oldal, tLekérdezésTípusok.Sorrend, tLekérdezésTípusok.Megjegyzés, tLekérdezésTípusok.vbaPostProcessing, tLekérdezésTípusok.azVisszajelzésTípusCsoport, tLekérdezésOsztályok.Sorrend
FROM tLekérdezésOsztályok INNER JOIN tLekérdezésTípusok ON tLekérdezésOsztályok.azOsztály = tLekérdezésTípusok.Osztály
ORDER BY tLekérdezésOsztályok.Osztály, tLekérdezésOsztályok.Sorrend, IIf([tLekérdezésTípusok].[Sorrend] Is Null,999,[tLekérdezésTípusok].[Sorrend]), tLekérdezésTípusok.LapNév;

#/#/#/
lkLétreNemJöttJogviszony
#/#/
SELECT DISTINCT lkKilépőUnió.Adóazonosító, kt_azNexon_Adójel02.azNexon, "?" AS [Jogviszony sorszáma]
FROM lkKilépőUnió LEFT JOIN kt_azNexon_Adójel02 ON lkKilépőUnió.Adójel = kt_azNexon_Adójel02.Adójel
WHERE (((lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének oka: jogszabályi hiva])="Létre nem jött jogviszony") AND ((lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének oka: jogszabályi hiva])>=DateSerial(Year(Date()),1,1)));

#/#/#/
lkLétreNemJöttJogviszony_SMAX
#/#/
SELECT DISTINCT tSzemélyek.Adójel, kt_azNexon_Adójel.azNexon, tSzemélyek.[Jogviszony sorszáma]
FROM kt_azNexon_Adójel INNER JOIN tSzemélyek ON kt_azNexon_Adójel.Adójel = tSzemélyek.Adójel
WHERE (((tSzemélyek.[HR kapcsolat megszűnés módja (Kilépés módja)])="Létre nem jött jogviszony"));

#/#/#/
lkLétszámBelépésKiépésJogviszony
#/#/
SELECT tSzemélyek.[Státusz típusa], tSzemélyek.[Jogviszony típusa / jogviszony típus] AS Jogviszony, tSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS Belépés, IIf(dtÁtal([Jogviszony vége (kilépés dátuma)])=0,#1/1/3000#,dtÁtal([Jogviszony vége (kilépés dátuma)])) AS Kilépés, 1 AS Létszám
FROM tSzemélyek
WHERE (((tSzemélyek.[Jogviszony típusa / jogviszony típus])<>"Személyes jelenlét" And (tSzemélyek.[Jogviszony típusa / jogviszony típus])<>"Megbízásos"));

#/#/#/
lkLétszámBesorolásonkéntHavibólAlaplétszám
#/#/
SELECT lk_HavibólÁlláshelyek.Tábla AS Zóna, lk_HavibólÁlláshelyek.[Az álláshely megynevezése] AS Besorolás_bemenet, lk_HavibólÁlláshelyek.[Álláshely száma] AS Nexonban
FROM lk_HavibólÁlláshelyek
WHERE (((lk_HavibólÁlláshelyek.Tábla)="Alaplétszám"))
ORDER BY lk_HavibólÁlláshelyek.Azonosító;

#/#/#/
lkLétszámBesorolásonkéntHavibólAlaplétszámÖssz
#/#/
SELECT lkLétszámBesorolásonkéntHavibólAlaplétszám.Zóna, "Alaplétszám összesen:" AS Besorolás_bemenet, Sum(lkLétszámBesorolásonkéntHavibólAlaplétszám.Nexonban) AS SumOfNexonban
FROM lkLétszámBesorolásonkéntHavibólAlaplétszám
GROUP BY lkLétszámBesorolásonkéntHavibólAlaplétszám.Zóna, "Alaplétszám összesen:";

#/#/#/
lkLétszámBesorolásonkéntHavibólKözpontosított
#/#/
SELECT lk_HavibólÁlláshelyek.Tábla AS Zóna, lk_HavibólÁlláshelyek.[Az álláshely megynevezése] AS Besorolás_bemenet, lk_HavibólÁlláshelyek.[Álláshely száma] AS Nexonban
FROM lk_HavibólÁlláshelyek
WHERE (((lk_HavibólÁlláshelyek.Tábla)="Központosított"))
ORDER BY lk_HavibólÁlláshelyek.Azonosító;

#/#/#/
lkLétszámBesorolásonkéntHavibólKözpontosítottÖssz
#/#/
SELECT lkLétszámBesorolásonkéntHavibólKözpontosított.Zóna, "Központosított összesen:" AS Besorolás_bemenet, Sum(lkLétszámBesorolásonkéntHavibólKözpontosított.Nexonban) AS SumOfNexonban
FROM lkLétszámBesorolásonkéntHavibólKözpontosított
GROUP BY lkLétszámBesorolásonkéntHavibólKözpontosított.Zóna, "Központosított összesen:";

#/#/#/
lkLétszámBesorolásonkéntHavibólMindösszesen
#/#/
SELECT "Mindösszesen" AS Zóna, lkLétszámBesorolásonkéntHavibólAlaplétszámÉsKözpontosított.Besorolás_bemenet, Sum(lkLétszámBesorolásonkéntHavibólAlaplétszámÉsKözpontosított.Nexonban) AS SumOfNexonban
FROM (SELECT lkLétszámBesorolásonkéntHavibólKözpontosított.Zóna, lkLétszámBesorolásonkéntHavibólKözpontosított.Besorolás_bemenet, lkLétszámBesorolásonkéntHavibólKözpontosított.Nexonban
FROM lkLétszámBesorolásonkéntHavibólKözpontosított
UNION
SELECT lkLétszámBesorolásonkéntHavibólAlaplétszám.Zóna, lkLétszámBesorolásonkéntHavibólAlaplétszám.Besorolás_bemenet, lkLétszámBesorolásonkéntHavibólAlaplétszám.Nexonban
FROM lkLétszámBesorolásonkéntHavibólAlaplétszám
)  AS lkLétszámBesorolásonkéntHavibólAlaplétszámÉsKözpontosított
GROUP BY "Mindösszesen", lkLétszámBesorolásonkéntHavibólAlaplétszámÉsKözpontosított.Besorolás_bemenet;

#/#/#/
lkLétszámBesorolásonkéntHavibólMindösszesenÖssz
#/#/
SELECT lkLétszámBesorolásonkéntHavibólMindösszesen.Zóna, "Mindösszesen összesen:" AS Besorolás_bemenet, Sum(lkLétszámBesorolásonkéntHavibólMindösszesen.SumOfNexonban) AS SumOfSumOfNexonban
FROM lkLétszámBesorolásonkéntHavibólMindösszesen
GROUP BY lkLétszámBesorolásonkéntHavibólMindösszesen.Zóna, "Mindösszesen összesen:";

#/#/#/
lkLétszámBesorolásonkéntHavibólUNIÓ
#/#/
SELECT HatRészesUnió.Sor, HatRészesUnió.Zóna, tBesorolásKonverzió.ÁNYRből AS Besorolás, HatRészesUnió.Nexonban
FROM tBesorolásKonverzió INNER JOIN (SELECT *, 3 as Sor FROM lkLétszámBesorolásonkéntHavibólKözpontosított  UNION SELECT *, 5 as Sor FROM lkLétszámBesorolásonkéntHavibólMindösszesen  UNION SELECT *, 1 as Sor FROM lkLétszámBesorolásonkéntHavibólAlaplétszám  UNION SELECT *, 2 as Sor FROM lkLétszámBesorolásonkéntHavibólAlaplétszámÖssz  UNION SELECT *, 4 as Sor FROM lkLétszámBesorolásonkéntHavibólKözpontosítottÖssz  UNION SELECT *, 6 as Sor FROM lkLétszámBesorolásonkéntHavibólMindösszesenÖssz )  AS HatRészesUnió ON tBesorolásKonverzió.Haviból=HatRészesUnió.Besorolás_bemenet;

#/#/#/
lkLétszámEngedéllyelValóÖsszevetés_Eredmény
#/#/
SELECT (Select max(SorszámEng) From tEngedéllyelValóÖsszevetésTábla)-[SorszámEng]+(IIf([tEngedéllyelValóÖsszevetésTábla].[Zóna]="Alaplétszám",0,IIf([tEngedéllyelValóÖsszevetésTábla].[zóna]="Központosított",12,24))) AS Sorszám, tEngedéllyelValóÖsszevetésTábla.Magyarázat, tEngedéllyelValóÖsszevetésTábla.Zóna AS Keret, tEngedéllyelValóÖsszevetésTábla.Besorolás_bemenet AS Besorolás, tEngedéllyelValóÖsszevetésTábla.Engedélyezett, tEngedéllyelValóÖsszevetésTábla.Betöltött, tEngedéllyelValóÖsszevetésTábla.Üres, tEngedéllyelValóÖsszevetésTábla.[Összes álláshely], ([Nexonban]) AS [Nexonban összesen], ([Összes álláshely]-[Nexonban]) AS Eltérés
FROM lkLétszámBesorolásonkéntHavibólUNIÓ RIGHT JOIN tEngedéllyelValóÖsszevetésTábla ON (lkLétszámBesorolásonkéntHavibólUNIÓ.Besorolás = tEngedéllyelValóÖsszevetésTábla.Besorolás_bemenet) AND (lkLétszámBesorolásonkéntHavibólUNIÓ.Zóna = tEngedéllyelValóÖsszevetésTábla.Zóna);

#/#/#/
lkLétszámÉsTTOsztályonként01
#/#/
SELECT Replace([Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH") AS [Hivatal\Főosztály], Unió.Osztály, 1 AS Létszám, fvCaseSelect(Nz([Jogcíme],"-"),"-",0,"Mentesítés munkáltató engedélye alapján",0,"",0,Null,1)*1 AS TT, bfkh([BFKHkód]) AS bfkh
FROM (SELECT Járási_állomány.Adóazonosító, Járási_állomány.Név, Járási_állomány.[Járási Hivatal], Járási_állomány.Mező7 as Osztály, Járási_állomány.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp] as Jogcíme, Mező10 as Kinevezés,[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ] as BFKHkód
FROM Járási_állomány

UNION
SELECT Kormányhivatali_állomány.Adóazonosító, Kormányhivatali_állomány.Név, Kormányhivatali_állomány.Mező6, Kormányhivatali_állomány.Mező7, Kormányhivatali_állomány.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], Mező10, [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
FROM  Kormányhivatali_állomány

UNION 
SELECT Központosítottak.Adóazonosító, Központosítottak.Név, Központosítottak.Mező6, Központosítottak.Mező7, Központosítottak.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp],Mező11, [Nexon szótárelemnek megfelelő szervezeti egység azonosító]
FROM   Központosítottak

)  AS Unió
ORDER BY bfkh([BFKHkód]);

#/#/#/
lkLétszámÉsTTOsztályonként02
#/#/
SELECT lkLétszámÉsTTOsztályonként01.bfkh, lkLétszámÉsTTOsztályonként01.[Hivatal\Főosztály], lkLétszámÉsTTOsztályonként01.Osztály, Sum(lkLétszámÉsTTOsztályonként01.Létszám) AS Létszám, Sum(lkLétszámÉsTTOsztályonként01.TT) AS TT, [TT]/[Létszám] AS Arány
FROM lkLétszámÉsTTOsztályonként01
GROUP BY lkLétszámÉsTTOsztályonként01.bfkh, lkLétszámÉsTTOsztályonként01.[Hivatal\Főosztály], lkLétszámÉsTTOsztályonként01.Osztály;

#/#/#/
lkLétszámFőosztályonkéntOsztályonként20230101
#/#/
SELECT lkTTLétszámFőosztályonkéntOsztályonként2023.Főosztály, lkTTLétszámFőosztályonkéntOsztályonként2023.Osztály, 0 AS TTLétszám2021, 0 AS TTLétszám2022, 0 AS TTLétszám2023, Sum(lkTTLétszámFőosztályonkéntOsztályonként2023.Létszám2023) AS SumOfLétszám2023
FROM lkTTLétszámFőosztályonkéntOsztályonként2023
GROUP BY lkTTLétszámFőosztályonkéntOsztályonként2023.Főosztály, lkTTLétszámFőosztályonkéntOsztályonként2023.Osztály, 0, 0, 0;

#/#/#/
lkLétszámMindenÉvUtolsóNapján
#/#/
SELECT Year([hatálya]) AS Év, Count(lkÁllománytáblákTörténetiUniója.Adóazonosító) AS CountOfAdóazonosító
FROM lkÁllománytáblákTörténetiUniója INNER JOIN tHaviJelentésHatálya1 ON lkÁllománytáblákTörténetiUniója.hatályaID = tHaviJelentésHatálya1.hatályaID
WHERE (((Year([hatálya])) Between 2019 And 2023) AND ((Month([hatálya]))=12) AND ((Day([hatálya]))=31) AND ((lkÁllománytáblákTörténetiUniója.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h]) Not Like "*TT*") AND ((lkÁllománytáblákTörténetiUniója.Adóazonosító) Is Not Null) AND ((lkÁllománytáblákTörténetiUniója.[Születési év \ üres állás])<>"üres állás") AND ((lkÁllománytáblákTörténetiUniója.Főoszt) Like Nz([Főosztály_],"") & "*")) OR (((Year([hatálya]))=2024) AND ((Month([hatálya]))=9) AND ((Day([hatálya]))=30) AND ((lkÁllománytáblákTörténetiUniója.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h]) Not Like "*TT*") AND ((lkÁllománytáblákTörténetiUniója.Adóazonosító) Is Not Null) AND ((lkÁllománytáblákTörténetiUniója.[Születési év \ üres állás])<>"üres állás") AND ((lkÁllománytáblákTörténetiUniója.Főoszt) Like Nz([Főosztály_],"") & "*"))
GROUP BY Year([hatálya]);

#/#/#/
lkLétszámokNevezetesNapokon01
#/#/
SELECT lkKiemeltNapok.KiemeltNapok, lkLétszámBelépésKiépésJogviszony.Jogviszony, Sum(lkLétszámBelépésKiépésJogviszony.Létszám) AS SumOfLétszám
FROM lkLétszámBelépésKiépésJogviszony, lkKiemeltNapok
WHERE (((lkKiemeltNapok.Nap)=IIf([hó]=1,31,28)) And ((lkKiemeltNapok.Év)=21) And (("######### A JOIN műveletet szétszedi, ezért WHERE feltételt használunk! #################")<>False) And ((lkKiemeltNapok.KiemeltNapok) Between lkLétszámBelépésKiépésJogviszony.Belépés And lkLétszámBelépésKiépésJogviszony.Kilépés))
GROUP BY lkKiemeltNapok.KiemeltNapok, lkLétszámBelépésKiépésJogviszony.Jogviszony, lkLétszámBelépésKiépésJogviszony.Létszám;

#/#/#/
lkLétszámokNevezetesNapokonŰrlaphoz01B
#/#/
SELECT lkKiemeltNapok.KiemeltNapok, lkLétszámBelépésKiépésJogviszony.Jogviszony, Sum(lkLétszámBelépésKiépésJogviszony.Létszám) AS SumOfLétszám
FROM lkLétszámBelépésKiépésJogviszony, lkKiemeltNapok
WHERE (((lkLétszámBelépésKiépésJogviszony.Jogviszony) Like [Űrlapok]![űLétszámKiemeltNapokonB]![Jogviszony] & "*") AND ((lkKiemeltNapok.Nap)=[Űrlapok]![űLétszámKiemeltNapokonB]![VálasztottNap]) AND (("######### A JOIN műveletet szétszedi, ezért WHERE feltételt használunk! #################")<>False) AND ((lkKiemeltNapok.KiemeltNapok) Between [lkLétszámBelépésKiépésJogviszony].[Belépés] And [lkLétszámBelépésKiépésJogviszony].[Kilépés]))
GROUP BY lkKiemeltNapok.KiemeltNapok, lkLétszámBelépésKiépésJogviszony.Jogviszony, lkLétszámBelépésKiépésJogviszony.Létszám;

#/#/#/
lkLétszámokNevezetesNapokonŰrlaphoz02B
#/#/
SELECT lkLétszámokNevezetesNapokonŰrlaphoz01b.KiemeltNapok, lkLétszámokNevezetesNapokonŰrlaphoz01b.Jogviszony, lkLétszámokNevezetesNapokonŰrlaphoz01b.SumOfLétszám
FROM lkLétszámokNevezetesNapokonŰrlaphoz01b
WHERE (((lkLétszámokNevezetesNapokonŰrlaphoz01b.KiemeltNapok) Between [Űrlapok]![űLétszámKiemeltNapokonB]![Kezdőév] And [Űrlapok]![űLétszámKiemeltNapokonB]![VégeÉv]));

#/#/#/
lkLétszámStatisztikaÖsszetett
#/#/
SELECT 
FROM lkDolgozókLétszáma18ÉvAlattiGyermekkel, lkNőkLétszáma02, lkNőkLétszáma6ÉvAlattiGyermekkel;

#/#/#/
lkLezártFeladatkörhözRendeltDolgozókFőosztályonként
#/#/
SELECT DISTINCT lkSzemélyek.FőosztályKód, lkSzemélyek.Főosztály, Count(lkSzemélyek.Azonosító) AS Létszám
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Elsődleges feladatkör]) Like "Lezárt*"))
GROUP BY lkSzemélyek.FőosztályKód, lkSzemélyek.Főosztály
ORDER BY lkSzemélyek.FőosztályKód;

#/#/#/
lkMásBesorolásúOsztályvezetők
#/#/
SELECT lkOsztályvezetőiÁlláshelyek.Főosztály, lkOsztályvezetőiÁlláshelyek.Osztály, lkOsztályvezetőiÁlláshelyek.[Dolgozó teljes neve], lkOsztályvezetőiÁlláshelyek.[Besorolási  fokozat (KT)] AS Besorolás, lkOsztályvezetőiÁlláshelyek.[Vezetői beosztás megnevezése], lkOsztályvezetőiÁlláshelyek.[Tartós távollét típusa], lkOsztályvezetőiÁlláshelyek.álláshely, lkOsztályvezetőiÁlláshelyek.NLink
FROM lkOsztályvezetőiÁlláshelyek
WHERE (((lkOsztályvezetőiÁlláshelyek.[Besorolási  fokozat (KT)]) Not Like "*Osztályvezető" Or (lkOsztályvezetőiÁlláshelyek.[Besorolási  fokozat (KT)]) Is Null) AND ((lkOsztályvezetőiÁlláshelyek.[Vezetői beosztás megnevezése]) Like "*Osztályvezető")) OR (((lkOsztályvezetőiÁlláshelyek.[Besorolási  fokozat (KT)]) Like "*Osztályvezető") AND ((lkOsztályvezetőiÁlláshelyek.[Vezetői beosztás megnevezése]) Not Like "*Osztályvezető" Or (lkOsztályvezetőiÁlláshelyek.[Vezetői beosztás megnevezése]) Is Null)) OR (((lkOsztályvezetőiÁlláshelyek.[Besorolási  fokozat (KT)]) Not Like "*kerületi*") AND ((lkOsztályvezetőiÁlláshelyek.[Vezetői beosztás megnevezése]) Like "*kerületi*")) OR (((lkOsztályvezetőiÁlláshelyek.[Besorolási  fokozat (KT)]) Like "*kerületi*") AND ((lkOsztályvezetőiÁlláshelyek.[Vezetői beosztás megnevezése]) Not Like "*kerületi*"))
ORDER BY lkOsztályvezetőiÁlláshelyek.bfkh;

#/#/#/
lkMeghagyandóMaxLétszámFeladatkörönként
#/#/
SELECT tMeghagyásraKijelöltMunkakörök.Feladatkörök, Sum(1) AS Létszám, Sum([Meghagyandó]/100) AS [Betöltött létszám arányosítva]
FROM (lkSzemélyek AS lkSzemélyek_1 INNER JOIN tMeghagyandókAránya ON lkSzemélyek_1.FőosztályBFKHKód = tMeghagyandókAránya.BFKH) INNER JOIN tMeghagyásraKijelöltMunkakörök ON lkSzemélyek_1.[KIRA feladat megnevezés] = tMeghagyásraKijelöltMunkakörök.Feladatkörök
WHERE (((lkSzemélyek_1.[Státusz neve])="álláshely") AND ((tMeghagyandókAránya.Főosztály) Is Not Null))
GROUP BY tMeghagyásraKijelöltMunkakörök.Feladatkörök;

#/#/#/
lkMeghagyás01_Archiv
#/#/
SELECT tMeghagyandókAránya.Azonosító, tMeghagyandókAránya.Főosztály, lkSzervezetiBetöltések.FőosztályKód, lkSzervezetiBetöltések.[Szülő szervezeti egységének kódja], 1 AS Létszám, tMeghagyandókAránya.Meghagyandó AS [Meghagyandó%], lkSzervezetiBetöltések.[Szervezetmenedzsment kód]
FROM lkSzemélyek INNER JOIN (tMeghagyandókAránya INNER JOIN lkSzervezetiBetöltések ON tMeghagyandókAránya.[Szervezeti egység kódja] = lkSzervezetiBetöltések.FőosztályKód) ON lkSzemélyek.[Adóazonosító jel] = lkSzervezetiBetöltések.[Szervezetmenedzsment kód];

#/#/#/
lkMeghagyás01_régiArchiv
#/#/
SELECT tMeghagyandókAránya.Azonosító, tMeghagyandókAránya.Főosztály, lkSzervezetiBetöltések.FőosztályKód, lkSzervezetiBetöltések.[Szülő szervezeti egységének kódja], 1 AS Létszám, tMeghagyandókAránya.Meghagyandó AS [Meghagyandó%], lkSzervezetiBetöltések.[Szervezetmenedzsment kód]
FROM lkSzemélyek INNER JOIN (tMeghagyandókAránya INNER JOIN lkSzervezetiBetöltések ON tMeghagyandókAránya.[Szervezeti egység kódja] = lkSzervezetiBetöltések.FőosztályKód) ON lkSzemélyek.[Adóazonosító jel] = lkSzervezetiBetöltések.[Szervezetmenedzsment kód]
WHERE (((lkSzemélyek.[Besorolási  fokozat (KT)])<>"Főosztályvezető" And (lkSzemélyek.[Besorolási  fokozat (KT)])<>"Osztályvezető" And (lkSzemélyek.[Besorolási  fokozat (KT)])<>"Járási / kerületi hivatal vezetője" And (lkSzemélyek.[Besorolási  fokozat (KT)])<>"Járási / kerületi hivatal vezetőjének helyettese" And (lkSzemélyek.[Besorolási  fokozat (KT)])<>"Főispán" And (lkSzemélyek.[Besorolási  fokozat (KT)])<>"Kormányhivatal főigazgatója" And (lkSzemélyek.[Besorolási  fokozat (KT)])<>"Kormányhivatal igazgatója") AND ((Year(Now())-Year([Születési idő])) Between 18 And 65) AND ((lkSzemélyek.Neme)=("férfi")));

#/#/#/
lkMeghagyás02_Archiv
#/#/
SELECT lkMeghagyás01.Azonosító, lkMeghagyás01.FőosztályKód, lkMeghagyás01.Főosztály, Sum(lkMeghagyás01.Létszám) AS SumOfLétszám, lkMeghagyás01.[Meghagyandó%], Sum([Létszám]*[Meghagyandó%]/100) AS [Meghagyandó létszám]
FROM lkMeghagyás01
GROUP BY lkMeghagyás01.Azonosító, lkMeghagyás01.FőosztályKód, lkMeghagyás01.Főosztály, lkMeghagyás01.[Meghagyandó%];

#/#/#/
lkMeghagyás03
#/#/
SELECT tMeghagyandókAránya.Azonosító, lkSzervezetiBetöltések.FőosztályKód, tMeghagyandókAránya.Főosztály, COUNT(lkSzemélyek.[Adóazonosító jel]) AS Létszám, tMeghagyandókAránya.Meghagyandó AS [Meghagyandó%], ROUND(SUM(1 * tMeghagyandókAránya.Meghagyandó / 100)) AS Meghagyandók INTO tMeghagyás03
FROM (lkSzemélyek INNER JOIN lkSzervezetiBetöltések ON lkSzemélyek.[Adóazonosító jel] = lkSzervezetiBetöltések.[Szervezetmenedzsment kód]) INNER JOIN tMeghagyandókAránya ON tMeghagyandókAránya.[Szervezeti egység kódja] = lkSzervezetiBetöltések.FőosztályKód
GROUP BY tMeghagyandókAránya.Azonosító, lkSzervezetiBetöltések.FőosztályKód, tMeghagyandókAránya.Főosztály, tMeghagyandókAránya.Meghagyandó;

#/#/#/
lkMeghagyásB01
#/#/
SELECT DISTINCT lkSzervezetiBetöltések.FőosztályKód, tBesorolás_átalakító.Sorrend, lkSzervezetiBetöltések.[Státuszának kódja], Replace([Státuszának kódja],"S-","")*1 AS Szám, lkSzemélyek.[Dolgozó teljes neve] INTO tMeghagyásB01
FROM ((lkSzervezetiBetöltések INNER JOIN lkSzemélyek ON lkSzervezetiBetöltések.[Szervezetmenedzsment kód] = lkSzemélyek.[Adóazonosító jel]) INNER JOIN tBesorolás_átalakító ON lkSzemélyek.Besorolás2 = tBesorolás_átalakító.Besorolási_fokozat) INNER JOIN tMeghagyásraKijelöltMunkakörök ON lkSzemélyek.[KIRA feladat megnevezés] = tMeghagyásraKijelöltMunkakörök.Feladatkörök
WHERE (((Year(Now())-Year([Születési idő])) Between 18 And 65) AND ((lkSzemélyek.Neme)="férfi"));

#/#/#/
lkMeghagyásB02
#/#/
SELECT tMeghagyásB01.FőosztályKód, tMeghagyásB01.Sorrend AS Besorolás, tMeghagyásB01.Szám, tMeghagyásB01.[Státuszának kódja], DCount("*","tMeghagyásB01","FőosztályKód = '" & [FőosztályKód] & "' AND sorrend < " & [sorrend])+DCount("*","tMeghagyásB01","FőosztályKód = '" & [FőosztályKód] & "' AND sorrend = " & [sorrend] & " AND Szám < " & [Szám])+1 AS Sorszám3 INTO tMeghagyásB02
FROM tMeghagyásB01
ORDER BY tMeghagyásB01.FőosztályKód, tMeghagyásB01.Sorrend, tMeghagyásB01.Szám;

#/#/#/
lkMeghagyásEredmény
#/#/
SELECT [TAJ szám], ffsplit([Dolgozó születési neve]," ",1) AS [Születési név1], ffsplit([Dolgozó születési neve]," ",2) AS [Születési név2], IIf(ffsplit([Dolgozó születési neve]," ",3)=ffsplit([Dolgozó születési neve]," ",2) Or Left(ffsplit([Dolgozó születési neve]," ",3),1)="(","",ffsplit([Dolgozó születési neve]," ",3)) AS [Születési név3], IIf(InStr(1,[Dolgozó teljes neve],"dr.",0),"dr.",IIf(InStr(1,[Dolgozó teljes neve],"Dr.",0),"Dr.","")) AS Előtag, ffsplit([Dolgozó teljes neve]," ",1) AS [Házassági név1], ffsplit([Dolgozó teljes neve]," ",2) AS [Házassági név2], IIf(ffsplit([Dolgozó teljes neve]," ",3)=ffsplit([Dolgozó teljes neve]," ",2) Or Left(ffsplit([Dolgozó teljes neve]," ",3),1)="(" Or Left(ffsplit([Dolgozó teljes neve]," ",3),3)="dr." Or Left(ffsplit([Dolgozó teljes neve]," ",3),3)="Dr.","",ffsplit([Dolgozó teljes neve]," ",3)) AS [Házassági név3], trim(ffsplit(drLeválaszt([Anyja neve],False)," ",1)) AS [Anyja neve1], ffsplit(drLeválaszt([Anyja neve],False)," ",2) AS [Anyja neve2], IIf(ffsplit(drLeválaszt([Anyja neve],False)," ",3)=ffsplit(drLeválaszt([Anyja neve],False)," ",2) Or Left(ffsplit(drLeválaszt([Anyja neve],False)," ",3),1)="(","",ffsplit(drLeválaszt([Anyja neve],False)," ",3)) AS [Anyja neve3], [Születési idő], [Születési hely], Feladatkörök AS munkakör
FROM (SELECT * FROM lkMeghagyásÚjEredmény UNION SELECT * FROM lkMeghagyásVezetők)  AS ÚjEredményÉsVezetők;

#/#/#/
lkMeghagyásEredmény_ÁllományTáblaSzerűen
#/#/
SELECT tMeghagyás03.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], tMeghagyásB02.[Státuszának kódja] AS ÁNYR, lkSzemélyek.[KIRA feladat megnevezés], tMeghagyás03.CountOfLétszám AS Betöltött, tMeghagyás03.[Meghagyandó%], tMeghagyás03.Meghagyandók, [CountOfLétszám]-[Meghagyandók] AS MegNemHagyandók, tMeghagyásB02.Sorszám3, IIf([Sorszám3]<=([CountOfLétszám]-[Meghagyandók]),"Nem kerül meghagyásra",IIf([Szervezeti egység kódja]="BFKH.1.27.2.","Nem kerül meghagyásra","Meghagyandó")) AS Eredmény
FROM lkSzemélyek RIGHT JOIN (tMeghagyás03 RIGHT JOIN tMeghagyásB02 ON tMeghagyás03.FőosztályKód = tMeghagyásB02.FőosztályKód) ON lkSzemélyek.[Státusz kódja] = tMeghagyásB02.[Státuszának kódja]
ORDER BY lkSzemélyek.BFKH, tMeghagyásB02.Sorszám3;

#/#/#/
lkMeghagyásEredmény_régi
#/#/
SELECT lkSzemélyek.[TAJ szám], lkSzemélyek.[Dolgozó születési neve] AS [Születési név], lkSzemélyek.[Dolgozó teljes neve] AS [Házassági név], lkSzemélyek.[Anyja neve], lkSzemélyek.[Születési idő], lkSzemélyek.[Születési hely], lkSzemélyek.[KIRA feladat megnevezés] AS munkakör, tMeghagyásB02.Besorolás
FROM lkSzemélyek RIGHT JOIN (tMeghagyás03 RIGHT JOIN tMeghagyásB02 ON tMeghagyás03.FőosztályKód = tMeghagyásB02.FőosztályKód) ON lkSzemélyek.[Státusz kódja] = tMeghagyásB02.[Státuszának kódja]
WHERE (((tMeghagyásB02.Besorolás)<>"Főosztályvezető" And (tMeghagyásB02.Besorolás)<>"Osztályvezető" And (tMeghagyásB02.Besorolás)<>"Járási / kerületi hivatal vezetője" And (tMeghagyásB02.Besorolás)<>"Járási / kerületi hivatal vezetőjének helyettese" And (tMeghagyásB02.Besorolás)<>"Főispán" And (tMeghagyásB02.Besorolás)<>"Kormányhivatal főigazgatója" And (tMeghagyásB02.Besorolás)<>"Kormányhivatal igazgatója") AND ((IIf([Sorszám3]<=([SumOfLétszám]-[Meghagyandók]),False,True))=True))
ORDER BY Bfkh(Nz([tMeghagyás03].[FőosztályKód],"BFKH.1.")), tMeghagyásB02.Sorszám3 DESC;

#/#/#/
lkMeghagyásMátrix
#/#/
SELECT lkMeghagyandóMaxLétszámFeladatkörönként.feladatkörök AS [Meghagyásra kijelölt munkakörök megnevezése], lkMeghagyandóMaxLétszámFeladatkörönként.Létszám AS [Azonos munkakörök mennyisége], Round([Betöltött létszám arányosítva],0) AS [Azonos munkakörök közül meghagyásra tervezettek száma], [Létszám]-Round([Betöltött létszám arányosítva],0) AS [Azonos munkakörök közül meghagyásra nem tervezettek száma]
FROM lkMeghagyandóMaxLétszámFeladatkörönként;

#/#/#/
lkMeghagyásMátrixB
#/#/
SELECT valami.[meghagyásra kijelölt munkakörök megnevezése], Sum(valami.A) AS Összes, Sum(valami.B) AS Meghagyandók, Sum(valami.C) AS [Meg nem hagyandók]
FROM (SELECT lkFeladatkörönkéntiLétszám.*
  FROM lkFeladatkörönkéntiLétszám
  UNION
  SELECT lkFeladatkörönkéntiMeghagyottak.*
  FROM  lkFeladatkörönkéntiMeghagyottak)  AS valami
GROUP BY valami.[meghagyásra kijelölt munkakörök megnevezése];

#/#/#/
lkMeghagyásÚj01
#/#/
SELECT DISTINCT lkSzemélyek.BFKH, lkSzemélyek.FőosztályKód, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[TAJ szám], lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Dolgozó születési neve], lkSzemélyek.[Anyja neve], lkSzemélyek.[Születési idő], lkSzemélyek.[Születési hely], IIf([Besorolás2] In ('Főosztályvezető','Osztályvezető','Főispán','Kormányhivatal főigazgatója','Kormányhivatal igazgatója') And [Meghagyandó%]>0,0,1) AS Vezető, IIf(Year(Date())-Year([Születési idő])>65,0,1) AS Kor, IIf([Neme]='nő',0,1) AS Nem, ([Vezető] * [Kor] * [Nem]) AS Rang, CLng(Replace([Státusz kódja],"S-","")) AS Szám, tBesorolás_átalakító.Sorrend, lkSzemélyek.[KIRA feladat megnevezés] INTO tMeghagyásÚjB01
FROM (lkSzemélyek LEFT JOIN tBesorolás_átalakító ON lkSzemélyek.Besorolás2 = tBesorolás_átalakító.Besorolási_fokozat) LEFT JOIN tMeghagyás03 ON lkSzemélyek.FőosztályKód = tMeghagyás03.FőosztályKód
WHERE lkSzemélyek.[Státusz neve] = "Álláshely";

#/#/#/
lkMeghagyásÚj02
#/#/
SELECT tMeghagyásÚjB01.FőosztályKód, tMeghagyásÚjB01.Sorrend AS Besorolás, tMeghagyásÚjB01.Szám, tMeghagyásÚjB01.Sorrend, CDbl(DCount("*","tMeghagyásÚjB01","FőosztályKód = '" & [FőosztályKód] & "' AND rang < " & [rang])+DCount("*","tMeghagyásÚjB01","FőosztályKód = '" & [FőosztályKód] & "' AND rang = " & [rang] & " AND sorrend > " & [sorrend])+DCount("*","tMeghagyásÚjB01","FőosztályKód = '" & [FőosztályKód] & "' AND rang = " & [rang] & " AND sorrend = " & [sorrend] & " AND Szám < " & [Szám])+1) AS Sorszám3, tMeghagyásÚjB01.Főosztály, tMeghagyásÚjB01.Osztály, tMeghagyásÚjB01.[TAJ szám], tMeghagyásÚjB01.[Dolgozó születési neve], tMeghagyásÚjB01.[Dolgozó teljes neve], tMeghagyásÚjB01.[Anyja neve], tMeghagyásÚjB01.[Születési idő], tMeghagyásÚjB01.[Születési hely], tMeghagyásÚjB01.Vezető, tMeghagyásÚjB01.Kor, tMeghagyásÚjB01.[Nem], tMeghagyásÚjB01.Rang, tMeghagyásÚjB01.[KIRA feladat megnevezés] INTO tMeghagyásÚjB02
FROM tMeghagyásÚjB01
ORDER BY tMeghagyásÚjB01.FőosztályKód, tMeghagyásÚjB01.Sorrend, tMeghagyásÚjB01.Szám;

#/#/#/
lkMeghagyásÚj03
#/#/
SELECT tMeghagyásÚjB02.Besorolás, tMeghagyásÚjB02.Sorrend, tMeghagyásÚjB02.Szám, tMeghagyásÚjB02.Vezető, tMeghagyásÚjB02.Kor, tMeghagyásÚjB02.[Nem], tMeghagyásÚjB02.FőosztályKód, tMeghagyásÚjB02.Rang, tMeghagyásÚjB02.Sorszám3, tMeghagyásÚjB02.Főosztály, tMeghagyásÚjB02.Osztály, tMeghagyásÚjB02.[TAJ szám], tMeghagyásÚjB02.[Dolgozó születési neve], tMeghagyásÚjB02.[Dolgozó teljes neve], tMeghagyásÚjB02.[Anyja neve], tMeghagyásÚjB02.[Születési idő], tMeghagyásÚjB02.[Születési hely], [KIRA feladat megnevezés]
FROM tMeghagyásÚjB02 INNER JOIN tMeghagyás03 ON (tMeghagyásÚjB02.FőosztályKód=tMeghagyás03.FőosztályKód) AND (tMeghagyás03.Meghagyandók>=tMeghagyásÚjB02.Sorszám3)
ORDER BY tMeghagyásÚjB02.FőosztályKód, tMeghagyásÚjB02.Rang, tMeghagyásÚjB02.Sorszám3;

#/#/#/
lkMeghagyásÚjEredmény
#/#/
SELECT lkMeghagyásÚj03.[TAJ szám], lkMeghagyásÚj03.[Dolgozó születési neve], lkMeghagyásÚj03.[Dolgozó teljes neve], lkMeghagyásÚj03.[Anyja neve], lkMeghagyásÚj03.[Születési idő], lkMeghagyásÚj03.[Születési hely], tMeghagyásraKijelöltMunkakörök.Feladatkörök
FROM tMeghagyásraKijelöltMunkakörök INNER JOIN lkMeghagyásÚj03 ON tMeghagyásraKijelöltMunkakörök.Feladatkörök = lkMeghagyásÚj03.[KIRA feladat megnevezés]
WHERE (((lkMeghagyásÚj03.[Nem])=1) AND ((lkMeghagyásÚj03.Kor)=1))
ORDER BY lkMeghagyásÚj03.FőosztályKód;

#/#/#/
lkMeghagyásVezetők
#/#/
SELECT lkSzemélyek.[TAJ szám], lkSzemélyek.[Dolgozó születési neve], lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Anyja neve], lkSzemélyek.[Születési idő], lkSzemélyek.[Születési hely], lkSzemélyek.[KIRA feladat megnevezés] AS Feladatkörök
FROM lkSzemélyek
WHERE (((IIf([Besorolás2] In ('Főosztályvezető','Kormányhivatal főigazgatója','Kormányhivatal igazgatója'),1,0))=1) AND ((lkSzemélyek.Neme)<>'nő') AND ((Year(Date())-Year([Születési idő]))<65) AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY lkSzemélyek.BFKH;

#/#/#/
lkMentességek
#/#/
SELECT tMentességek.*, [Családnév] & " " & [Utónév] AS Név, IIf([Születési hely] Like "Budapest*","Budapest",[Születési hely]) AS SzülHely
FROM tMentességek;

#/#/#/
lkMezőkÉsTípusuk
#/#/
SELECT tImportMezők.Az, tImportMezők.Oszlopnév, tImportMezők.Típus, tImportMezők.Mezőnév, tImportMezők.Skip, tMezőTípusok.Constant, tMezőTípusok.Description, tMezőTípusok.DbType
FROM tImportMezők INNER JOIN tMezőTípusok ON tImportMezők.Típus = tMezőTípusok.Value;

#/#/#/
lkMindenKerületbeBelépők
#/#/
SELECT lkBelépőkUnió.[Megyei szint VAGY Járási Hivatal] AS Kerület, lkBelépőkUnió.Név, lkBelépőkUnió.[Jogviszony kezdő dátuma]
FROM lkBelépőkUnió
WHERE (((lkBelépőkUnió.[Megyei szint VAGY Járási Hivatal])="Budapest Főváros Kormányhivatala XIV. Kerületi Hivatala") AND ((lkBelépőkUnió.[Jogviszony kezdő dátuma]) Between #7/1/2023# And #7/31/2024#));

#/#/#/
lkMindenKerületbőlKilépettekHavonta
#/#/
SELECT Replace([Megyei szint VAGY Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH") AS Kerület, DateSerial(Year([Jogviszony megszűnésének, megszüntetésének időpontja]),Month([Jogviszony megszűnésének, megszüntetésének időpontja])+1,1)-1 AS Tárgyhó, Sum(1) AS Fő
FROM lkKilépőUnió
WHERE (((lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének oka: jogszabályi hiva]) Not Like "*létre*") AND ((lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja]) Between #7/1/2023# And #7/31/2024#))
GROUP BY Replace([Megyei szint VAGY Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH"), DateSerial(Year([Jogviszony megszűnésének, megszüntetésének időpontja]),Month([Jogviszony megszűnésének, megszüntetésének időpontja])+1,1)-1;

#/#/#/
lkMindenKerületiBetöltöttLétszám01
#/#/
SELECT Replace([Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH") AS [Kerületi hivatal], tHaviJelentésHatálya1.hatálya, Sum(IIf([Mező4]="üres állás",0,1)) AS [Betöltött létszám], Sum(IIf([Mező4]="üres állás",1,0)) AS Üres
FROM tHaviJelentésHatálya1 INNER JOIN tJárási_állomány ON tHaviJelentésHatálya1.hatályaID = tJárási_állomány.hatályaID
GROUP BY Replace([Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH"), tHaviJelentésHatálya1.hatálya
HAVING (((tHaviJelentésHatálya1.hatálya) Between #7/1/2023# And #7/31/2024#));

#/#/#/
lkMindenKerületiBetöltöttLétszám02
#/#/
SELECT lkMindenKerületiBetöltöttLétszám01.[Kerületi hivatal], lkMindenKerületiBetöltöttLétszám01.hatálya, lkMindenKerületiBetöltöttLétszám01.[Betöltött létszám], lkMindenKerületiBetöltöttLétszám01.Üres, [Betöltött létszám]+[Üres] AS Engedélyezett
FROM lkMindenKerületiBetöltöttLétszám01;

#/#/#/
lkMindenKerületiKimutatás01
#/#/
SELECT lkMindenKerületiBetöltöttLétszám02.[Kerületi hivatal], lkMindenKerületiBetöltöttLétszám02.hatálya, lkMindenKerületiBetöltöttLétszám02.[Betöltött létszám], lkMindenKerületiBetöltöttLétszám02.Üres, lkMindenKerületiBetöltöttLétszám02.Engedélyezett, IIf([hatálya]=[Tárgyhó] And [kerületi hivatal]=[kerület],[Fő],0) AS Kilépettek
FROM lkMindenKerületiBetöltöttLétszám02 LEFT JOIN lkMindenKerületbőlKilépettekHavonta ON lkMindenKerületiBetöltöttLétszám02.[Kerületi hivatal] = lkMindenKerületbőlKilépettekHavonta.Kerület;

#/#/#/
lkMindenKerületiKimutatás02
#/#/
SELECT lkMindenKerületiKimutatás01.[Kerületi hivatal], lkMindenKerületiKimutatás01.hatálya, lkMindenKerületiKimutatás01.[Betöltött létszám], lkMindenKerületiKimutatás01.Üres, lkMindenKerületiKimutatás01.Engedélyezett, Sum(lkMindenKerületiKimutatás01.Kilépettek) AS SumOfKilépettek
FROM lkMindenKerületiKimutatás01
GROUP BY lkMindenKerületiKimutatás01.[Kerületi hivatal], lkMindenKerületiKimutatás01.hatálya, lkMindenKerületiKimutatás01.[Betöltött létszám], lkMindenKerületiKimutatás01.Üres, lkMindenKerületiKimutatás01.Engedélyezett
HAVING (((lkMindenKerületiKimutatás01.[Kerületi hivatal]) Like "*XIV*"));

#/#/#/
lkMindenKilépettVezető
#/#/
SELECT lkKilépőUnió.Adójel, lkKilépőUnió.Név, lkKilépőUnió.Főosztály, lkKilépőUnió.Osztály, lkKilépőUnió.[Besorolási fokozat megnevezése:], lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének oka: jogszabályi hiva], lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja] AS Kilépés, DateDiff("yyyy",Mid([Adóazonosító],2,5)*1-12051,dtÁtal([Jogviszony megszűnésének, megszüntetésének időpontja])) AS [Életkora kilépéskor], Mid([Adóazonosító],2,5)*1-12051 AS [Születési dátum]
FROM lkKilépőUnió
WHERE (((lkKilépőUnió.[Besorolási fokozat megnevezése:])="osztályvezető" Or (lkKilépőUnió.[Besorolási fokozat megnevezése:]) Like "kerületi*" Or (lkKilépőUnió.[Besorolási fokozat megnevezése:]) Like "főosztály*" Or (lkKilépőUnió.[Besorolási fokozat megnevezése:]) Like "*igazgató*" Or (lkKilépőUnió.[Besorolási fokozat megnevezése:])="főispán"));

#/#/#/
lkMindenVezető
#/#/
SELECT lkSzemélyek.[Adóazonosító jel], bfkh(Nz([Szervezeti egység kódja],"-")) AS BFKH, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.Besorolás2, LCase(Replace(Nz([Besorolási  fokozat (KT)],""),"Járási / ","")) & IIf(Nz([Tartós távollét típusa],"")<>""," (TT)","") AS [Ellátott feladat], lkSzemélyek.[Születési hely], lkSzemélyek.[Születési idő], lkSzemélyek.[Anyja neve], lkSzemélyek.[Állandó lakcím], lkSzemélyek.[Tartózkodási lakcím], lkSzemélyek.Adójel, dtÁtal([Jogviszony vége (kilépés dátuma)]) AS Kilépés, DateSerial(Year(Nz([Születési idő],0))+65,Month(Nz([Születési idő],0)),Day(Nz([Születési idő],0))-1) AS [Öregségi nyugdíj korhatár], lkSzemélyek.[Születési idő], lkSzemélyek.[Hivatali email]
FROM lkSzemélyek
WHERE (((LCase(Replace(Nz([Besorolási  fokozat (KT)],""),"Járási / ","")) & IIf(Nz([Tartós távollét típusa],"")<>""," (TT)",""))="osztályvezető") AND ((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null)) OR (((LCase(Replace(Nz([Besorolási  fokozat (KT)],""),"Járási / ","")) & IIf(Nz([Tartós távollét típusa],"")<>""," (TT)","")) Like "kerületi*") AND ((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null)) OR (((LCase(Replace(Nz([Besorolási  fokozat (KT)],""),"Járási / ","")) & IIf(Nz([Tartós távollét típusa],"")<>""," (TT)","")) Like "főosztály*") AND ((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null)) OR (((LCase(Replace(Nz([Besorolási  fokozat (KT)],""),"Járási / ","")) & IIf(Nz([Tartós távollét típusa],"")<>""," (TT)","")) Like "*igazgató*") AND ((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null)) OR (((LCase(Replace(Nz([Besorolási  fokozat (KT)],""),"Járási / ","")) & IIf(Nz([Tartós távollét típusa],"")<>""," (TT)",""))="főispán") AND ((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null))
ORDER BY bfkh(Nz([Szervezeti egység kódja],"-")), LCase(Replace(Nz([Besorolási  fokozat (KT)],""),"Járási / ","")) & IIf(Nz([Tartós távollét típusa],"")<>""," (TT)","");

#/#/#/
lkMinervaIndítóOldalak
#/#/
SELECT DISTINCT [Oldalak(tLekérdezésOsztályok)].azOsztály, [Oldalak(tLekérdezésOsztályok)].Oldalcím, [Oldalak(tLekérdezésOsztályok)].TartalomIsmertető, [Fejezetek(tLekérdezésTípusok)].LapNév AS [Fejezet címe], [Fejezetek(tLekérdezésTípusok)].Megjegyzés AS [Fejezet leírása], [Lekérdezések(tEllenőrzőLekérdezések)].Táblacím, [Lekérdezések(tEllenőrzőLekérdezések)].TáblaMegjegyzés AS [Tábla leírása], IIf([graftulajdonság]="Type",[graftulérték],"") AS VaneGraf, [Oldalak(tLekérdezésOsztályok)].Fájlnév
FROM tLekérdezésOsztályok AS [Oldalak(tLekérdezésOsztályok)] INNER JOIN ((tLekérdezésTípusok AS [Fejezetek(tLekérdezésTípusok)] INNER JOIN tEllenőrzőLekérdezések AS [Lekérdezések(tEllenőrzőLekérdezések)] ON [Fejezetek(tLekérdezésTípusok)].azETípus = [Lekérdezések(tEllenőrzőLekérdezések)].azETípus) LEFT JOIN tGrafikonok ON [Lekérdezések(tEllenőrzőLekérdezések)].azEllenőrző = tGrafikonok.azEllenőrző) ON [Oldalak(tLekérdezésOsztályok)].azOsztály = [Fejezetek(tLekérdezésTípusok)].Osztály;

#/#/#/
lkMobilmodulAdatFelülvizsgálat
#/#/
SELECT DISTINCT [SIM adatok - 2023-08-29 (2)].Azonosító, [SIM adatok - 2023-08-29 (2)].TelefonszámId, [SIM adatok - 2023-08-29 (2)].Telefonszám, [SIM adatok - 2023-08-29 (2)].Megjegyzés, [SIM adatok - 2023-08-29 (2)].[Dolgozó név], [SIM adatok - 2023-08-29 (2)].[Személytörzsben aktív -e], [SIM adatok - 2023-08-29 (2)].[Személytörzs szerinti e-mail cím], [SIM adatok - 2023-08-29 (2)].[Személytörzsben szervezeti egysége], [SIM adatok - 2023-08-29 (2)].[NEXON ID], [SIM adatok - 2023-08-29 (2)].Beosztás, [SIM adatok - 2023-08-29 (2)].[Szervezeti egység], lkSzemélyekÉsNexonAz.Főosztály, lkSzemélyekÉsNexonAz.[Dolgozó teljes neve], lkSzemélyekÉsNexonAz.[Hivatali email], IIf([Státusz neve] Is Null,
    "A dolgozó kilépett",
    Trim(
        IIf([Főosztály]<>[Szervezeti egység],
            "A szervezeti egység:" & [Főosztály] & ".",
            "") 
        & " " & 
        IIf([Dolgozó teljes neve]<>[Dolgozó név] AND [Dolgozó név] NOT LIKE "Dr.*",
            "A név: " & [Dolgozó teljes neve] & ".",
            "") 
        & " " & 
        IIf([Hivatali email]<>[Személytörzs szerinti e-mail cím],
            "A Nexonban nyilvántartott email: " & [Hivatali email] & ".",
            "")
        )
    ) AS Adathelyesbítés, ffsplit(lkSzemélyekÉsNexonAz.[Elsődleges feladatkör],"-",2) AS [Elsődleges feladatkör Nexon]
FROM lkSzemélyekÉsNexonAz RIGHT JOIN [SIM adatok - 2023-08-29 (2)] ON (lkSzemélyekÉsNexonAz.azNexon = [SIM adatok - 2023-08-29 (2)].[NEXON ID]) 
            OR 
            (lkSzemélyekÉsNexonAz.[Dolgozó teljes neve] = [SIM adatok - 2023-08-29 (2)].[Dolgozó név]);

#/#/#/
lkMozgásÉventeHavonta
#/#/
SELECT Mozgás.Év, Sum(Mozgás.[01]) AS [01 hó], Sum(Mozgás.[02]) AS [02 hó], Sum(Mozgás.[03]) AS [03 hó], Sum(Mozgás.[04]) AS [04 hó], Sum(Mozgás.[05]) AS [05 hó], Sum(Mozgás.[06]) AS [06 hó], Sum(Mozgás.[07]) AS [07 hó], Sum(Mozgás.[08]) AS [08 hó], Sum(Mozgás.[09]) AS [09 hó], Sum(Mozgás.[10]) AS [10 hó], Sum(Mozgás.[11]) AS [11 hó], Sum(Mozgás.[12]) AS [12 hó], Sum(Mozgás.Belépők) AS Mozgás
FROM (SELECT *
FROM lkBelépőkSzámaÉventeHavonta3
UNION
SELECT lkKilépőkSzámaÉventeHavonta3.Év
, lkKilépőkSzámaÉventeHavonta3.[01] * -1
, lkKilépőkSzámaÉventeHavonta3.[02] * -1
, lkKilépőkSzámaÉventeHavonta3.[03] * -1
, lkKilépőkSzámaÉventeHavonta3.[04] * -1
, lkKilépőkSzámaÉventeHavonta3.[05] * -1
, lkKilépőkSzámaÉventeHavonta3.[06] * -1
, lkKilépőkSzámaÉventeHavonta3.[07] * -1
, lkKilépőkSzámaÉventeHavonta3.[08] * -1
, lkKilépőkSzámaÉventeHavonta3.[09] * -1
, lkKilépőkSzámaÉventeHavonta3.[10] * -1
, lkKilépőkSzámaÉventeHavonta3.[11] * -1
, lkKilépőkSzámaÉventeHavonta3.[12] * -1
, lkKilépőkSzámaÉventeHavonta3.Kilépők * -1
FROM lkKilépőkSzámaÉventeHavonta3
)  AS Mozgás
GROUP BY Mozgás.Év;

#/#/#/
lkMSysQueries
#/#/
SELECT qry.Attribute, qry.Expression, qry.Flag, qry.LvExtra, qob.Name AS ObjectName, qry.Name1 AS columnName, qry.Name2 AS alias
FROM MSysQueries AS qry LEFT JOIN MSysObjects AS qob ON qry.ObjectId = qob.Id
ORDER BY qob.Name;

#/#/#/
lkMunkaalkalmassági
#/#/
SELECT lkSzemélyek.[TAJ szám] AS [azonosító száma], "" AS [név előtag], lkSzemélyek.[Dolgozó teljes neve] AS [munkavállaló neve], lkSzemélyek.Neme AS nem, lkSzemélyek.[Születési hely], lkSzemélyek.[Születési idő], lkSzemélyek.[Dolgozó születési neve] AS [leánykori név], lkSzemélyek.[Anyja neve], lkSzemélyek.[Hivatali telefon] AS [telefon szám], lkSzemélyek.[Hivatali email] AS [e-mail], lkSzemélyek.[Állandó lakcím] AS lakcím, "" AS jogosítvány, "" AS [katonai szolgálat], Trim(ffsplit([FEOR],"-",1)) AS [FEOR kód], Trim(ffsplit([FEOR],"-",2)) AS [FEOR név], "" AS [foglalkozásegészségügyi osztály], "" AS [fizikai megterhelés], "Budapest Főváros Kormányhivatala" AS [cég teljes neve], "BFKH" AS [cég rövid neve], lkSzemélyek.[Munkavégzés helye - megnevezés] AS [telephely neve], lkSzemélyek.[Munkavégzés helye - cím] AS [telephely címe], lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS [munkaviszony kezdete], lkSzemélyek.[Orvosi vizsgálat időpontja] AS [alkalmassági vizsgálat dátuma], lkSzemélyek.[Orvosi vizsgálat következő időpontja] AS [alkalmassági vizsgálat érvényesség], lkSzemélyek.[Orvosi vizsgálat típusa] AS [alkalmassági vizsgálat típus], lkSzemélyek.[Orvosi vizsgálat eredménye] AS [alkalmassági vizsgálat eredmény], lkSzemélyek.[Orvosi vizsgálat észrevételek] AS [alkalmassági vizsgálat korlázotás]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely"));

#/#/#/
lkMunkábajárásTávolsága01
#/#/
SELECT lkSzemélyek.Adójel, lkSzemélyek.[Dolgozó teljes neve], tIrányítószámokKoordináták.dblSzélesség AS LakSzél, tIrányítószámokKoordináták.dblHosszúság AS LakHossz, tIrányítószámokKoordináták_1.dblSzélesség AS MunkSzél, tIrányítószámokKoordináták_1.dblHosszúság AS MunkHossz, GetDistance([Lakszél],[Lakhossz],[MunkSzél],[MunkHossz]) AS Távolság
FROM tIrányítószámokKoordináták AS tIrányítószámokKoordináták_1 INNER JOIN (lkMunkahelycímek INNER JOIN ((lkLakcímek INNER JOIN tIrányítószámokKoordináták ON lkLakcímek.Irsz = tIrányítószámokKoordináták.Irsz) INNER JOIN lkSzemélyek ON lkLakcímek.Adójel = lkSzemélyek.Adójel) ON lkMunkahelycímek.Adójel = lkSzemélyek.Adójel) ON tIrányítószámokKoordináták_1.Irsz = lkMunkahelycímek.Irsz
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY GetDistance([Lakszél],[Lakhossz],[MunkSzél],[MunkHossz]) DESC;

#/#/#/
lkMunkahelycímek
#/#/
SELECT lkSzemélyek.Adójel, lkSzemélyek.[Munkavégzés helye - megnevezés], lkSzemélyek.[Munkavégzés helye - cím], IIf(IsNumeric(Left(Nz([Munkavégzés helye - cím],""),1)),Left(Nz([Munkavégzés helye - cím],""),4)*1,0) AS Irsz
FROM lkSzemélyek;

#/#/#/
lkMunkahelyCímNélküliek
#/#/
SELECT lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Munkavégzés helye - cím], lkSzemélyek.[Szervezeti egység kódja], Replace(IIf(IsNull([lkSzemélyek].[Szint 4 szervezeti egység név]),[lkSzemélyek].[Szint 3 szervezeti egység név] & "",[lkSzemélyek].[Szint 4 szervezeti egység név] & ""),"Budapest Főváros Kormányhivatala ","BFKH ") AS Főosztály, lkSzemélyek.[Szint 5 szervezeti egység név] AS Osztály, lkSzemélyek.Adójel, "https://nexonport.kh.gov.hu/menu/hrm/szemelyiKarton/index?szemelyAzonosito=" & [azNexon] & "&r=13" AS Link
FROM lkSzemélyek LEFT JOIN kt_azNexon_Adójel ON lkSzemélyek.tSzemélyek.Adójel=kt_azNexon_Adójel.Adójel
WHERE (((lkSzemélyek.[Munkavégzés helye - cím]) Is Null) AND ((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null) AND ((lkSzemélyek.[Státusz típusa]) Is Not Null));

#/#/#/
lkMunkahelyCímNélküliek_Statisztika
#/#/
SELECT lkMunkahelyCímNélküliek.Főosztály, Count(lkMunkahelyCímNélküliek.Link) AS db
FROM lkMunkahelyCímNélküliek
GROUP BY lkMunkahelyCímNélküliek.Főosztály;

#/#/#/
lkMunkakörökFőosztályJSON
#/#/
SELECT DISTINCT lkJárásiKormányKözpontosítottUnióFőosztKód.BFKH, Replace([Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH") AS Főosztály, "{ id: """ & Nz([Személy azonosító],[Álláshely azonosító]) & """, neve: """ & Nü([lkJárásiKormányKözpontosítottUnióFőosztKód].[Név],"Betöltetlen álláshely (" & [Álláshely azonosító] & ")") & " (" & [lkJárásiKormányKözpontosítottUnióFőosztKód].[Osztály] & ")" & """ }," AS Json, lkJárásiKormányKözpontosítottUnióFőosztKód.Osztály, drhátra([lkJárásiKormányKözpontosítottUnióFőosztKód].[név]) AS Név, lkJárásiKormányKözpontosítottUnióFőosztKód.Osztály, tNexonAzonosítók.[Személy azonosító]
FROM tEgyesMunkakörökFőosztályai INNER JOIN (lkJárásiKormányKözpontosítottUnióFőosztKód LEFT JOIN tNexonAzonosítók ON lkJárásiKormányKözpontosítottUnióFőosztKód.Adóazonosító = tNexonAzonosítók.[Adóazonosító jel]) ON tEgyesMunkakörökFőosztályai.Főosztály = lkJárásiKormányKözpontosítottUnióFőosztKód.Főosztálykód
WHERE (((lkJárásiKormányKözpontosítottUnióFőosztKód.Osztály) Like "*" & [tEgyesMunkakörökFőosztályai].[Osztály] & "*"))
ORDER BY lkJárásiKormányKözpontosítottUnióFőosztKód.BFKH, drhátra([lkJárásiKormányKözpontosítottUnióFőosztKód].[név]);

#/#/#/
lkMunkakörökJson
#/#/
SELECT "{ ""id"": """ & [MunkakörKód] & """, ""neve"": """ & [Munkakör] & """ }," AS Json
FROM tMunkakörök
ORDER BY tMunkakörök.Munkakör;

#/#/#/
lkMunkakörökKörlevélCímzettek00
#/#/
SELECT DISTINCT bfkh([FőosztályKód]) AS BFKHFőosztKód, lkSzemélyek.Főosztály, lkSzemélyek.[Dolgozó teljes neve], IIf([Neme]="férfi","Úr","Asszony") AS Megszólítás, Replace(Nz([Besorolási  fokozat (KT)],""),"Járási / kerületi hivatal vezetője","Hivatalvezető") AS Cím, lkSzemélyek.[Hivatali email], lkSzemélyek.Adójel
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz neve])="álláshely") AND ((lkSzemélyek.[Besorolási  fokozat (KT)])="Járási / kerületi hivatal vezetője")) OR (((lkSzemélyek.[Státusz neve])="álláshely") AND ((lkSzemélyek.[Besorolási  fokozat (KT)])="Főosztályvezető")) OR (((bfkh([FőosztályKód]))="BFKH.01.14") AND ((lkSzemélyek.[Státusz neve])="álláshely") AND ((lkSzemélyek.[Besorolási  fokozat (KT)])="osztályvezető"));

#/#/#/
lkMunkakörökKörlevélCímzettek01
#/#/
SELECT DISTINCT lkMunkakörökKörlevélCímzettek00.BFKHFőosztKód, lkMunkakörökKörlevélCímzettek00.Főosztály, lkMunkakörökKörlevélCímzettek00.Adójel, lkMunkakörökKörlevélCímzettek00.[Dolgozó teljes neve] AS Név, lkMunkakörökKörlevélCímzettek00.Megszólítás, lkMunkakörökKörlevélCímzettek00.Cím, lkMunkakörökKörlevélCímzettek00.[Hivatali email], lkMunkakörökKörlevélCsakALegfrissebbMaiMellékletek.Útvonal
FROM lkMunkakörökKörlevélCsakALegfrissebbMaiMellékletek INNER JOIN (tEgyesMunkakörökFőosztályai INNER JOIN lkMunkakörökKörlevélCímzettek00 ON tEgyesMunkakörökFőosztályai.Főosztály = lkMunkakörökKörlevélCímzettek00.BFKHFőosztKód) ON lkMunkakörökKörlevélCsakALegfrissebbMaiMellékletek.FőosztályNeve = lkMunkakörökKörlevélCímzettek00.Főosztály;

#/#/#/
lkMunkakörökKörlevélCsakALegfrissebbMaiMellékletek
#/#/
SELECT DISTINCT tMunkakörKörlevélMellékletÚtvonalak.azMelléklet, tMunkakörKörlevélMellékletÚtvonalak.FőosztályNeve, tMunkakörKörlevélMellékletÚtvonalak.Útvonal, tMunkakörKörlevélMellékletÚtvonalak.Készült, DateValue([Készült]) AS Dátum
FROM tMunkakörKörlevélMellékletÚtvonalak
WHERE (((tMunkakörKörlevélMellékletÚtvonalak.Készült)=(Select Max([Készült]) from [tMunkakörKörlevélMellékletÚtvonalak] as tmp where [tMunkakörKörlevélMellékletÚtvonalak].[FőosztályNeve]=tmp.főosztályneve)) AND ((DateValue([Készült]))=Date()));

#/#/#/
lkMunkavégzés helye - cím nélkül
#/#/
SELECT lkSzemélyek.[Munkavégzés helye - megnevezés], Nü([Munkavégzés helye - cím],"") AS Kif1, Count(lkSzemélyek.Adójel) AS CountOfAdójel
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz neve])="álláshely"))
GROUP BY lkSzemélyek.[Munkavégzés helye - megnevezés], Nü([Munkavégzés helye - cím],"")
HAVING (((Nü([Munkavégzés helye - cím],""))=""));

#/#/#/
lkMunkaviszonyHosszaKimutatáshoz01
#/#/
SELECT Year([Jogviszony vége (kilépés dátuma)]) AS [Utolsó év], DateDiff("d",[Jogviszony kezdete (belépés dátuma)],[Jogviszony vége (kilépés dátuma)])/365.25 AS [Eltöltött évek], tSzemélyek.Adójel
FROM tSzemélyek
WHERE (((Year([Jogviszony vége (kilépés dátuma)]))<>1899));

#/#/#/
lkMunkaviszonyHosszaKimutatáshoz01 naponta
#/#/
SELECT Year([Jogviszony vége (kilépés dátuma)]) AS [Utolsó év], DateDiff("d",[Jogviszony kezdete (belépés dátuma)],[Jogviszony vége (kilépés dátuma)])/7 AS [Eltöltött hetek], tSzemélyek.Adójel
FROM tSzemélyek
WHERE (((Year([Jogviszony vége (kilépés dátuma)]))<>1899));

#/#/#/
lkMunkaviszonyHosszaKimutatáshoz02
#/#/
TRANSFORM Count(lkMunkaviszonyHosszaKimutatáshoz01.Adójel) AS Darabszám
SELECT lkMunkaviszonyHosszaKimutatáshoz01.[Utolsó év]
FROM lkMunkaviszonyHosszaKimutatáshoz01
GROUP BY lkMunkaviszonyHosszaKimutatáshoz01.[Utolsó év]
PIVOT Int([Eltöltött évek]);

#/#/#/
lkMunkaviszonyHosszaKimutatáshoz02 naponta
#/#/
TRANSFORM Count([lkMunkaviszonyHosszaKimutatáshoz01 naponta].Adójel) AS Darabszám
SELECT Int([Eltöltött hetek]) AS [Hetek száma]
FROM [lkMunkaviszonyHosszaKimutatáshoz01 naponta]
GROUP BY Int([Eltöltött hetek])
PIVOT [lkMunkaviszonyHosszaKimutatáshoz01 naponta].[Utolsó év];

#/#/#/
lkMunkaviszonyosokBesorolásaFőosztályOsztály
#/#/
SELECT lkSzemélyek.[Státusz kódja], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], IIf([Besorolási  fokozat (KT)] Is Null,[Tervezett betöltési adatok - Előmeneteli fokozat megnevezés],[Besorolási  fokozat (KT)]) AS Besorolás
FROM lkSzemélyek INNER JOIN tSzervezet ON lkSzemélyek.[Státusz kódja] = tSzervezet.[Szervezetmenedzsment kód]
WHERE (((lkSzemélyek.[KIRA jogviszony jelleg])="munkaviszony") And ((lkSzemélyek.[Státusz neve])="álláshely") And ((tSzervezet.[Érvényesség kezdete])<=Date()) And ((IIf(tszervezet.[Érvényesség vége]=0,#1/1/3000#,tszervezet.[Érvényesség vége]))>=Date()))
ORDER BY IIf([Besorolási  fokozat (KT)] Is Null,[Tervezett betöltési adatok - Előmeneteli fokozat megnevezés],[Besorolási  fokozat (KT)]), lkSzemélyek.BFKH, lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkNapok01
#/#/
SELECT ([évek].[Sorszám])+2000 AS Év, Napok.Sorszám AS Nap, DateSerial([Év],1,1+[Nap]-1) AS Dátum
FROM lkSorszámok AS Napok, lkSorszámok AS Évek
WHERE évek.Sorszám+2000 Between 2019 And Year(Date()) And Napok.Sorszám<367;

#/#/#/
lkNapok02
#/#/
SELECT lkNapok01.Év, lkNapok01.Nap, lkNapok01.Dátum INTO tNapok03
FROM lkNapok01
WHERE (((Year([Dátum]))=[Év]));

#/#/#/
lkNemJogosultakUtazásiKedvezményre
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], UNIÓ.Adójel, "FőosztRöv_" & [Dolgozó teljes neve] & "_(" & [azNexon] & ")_utazási.pdf" AS Fájlnév
FROM kt_azNexon_Adójel02 INNER JOIN (lkSzemélyek INNER JOIN (SELECT lkFordulónaptólABelépésigElőzőMunkahelyMunkanapjai.Adójel, lkFordulónaptólABelépésigElőzőMunkahelyMunkanapjai.Napok
FROM lkFordulónaptólABelépésigElőzőMunkahelyMunkanapjai
UNION SELECT lkFordulónaptólEgyévigMindenJogviszonyMunkanapjai.Adójel, lkFordulónaptólEgyévigMindenJogviszonyMunkanapjai.Napok
FROM lkFordulónaptólEgyévigMindenJogviszonyMunkanapjai)  AS UNIÓ ON lkSzemélyek.Adójel = UNIÓ.Adójel) ON kt_azNexon_Adójel02.Adójel = UNIÓ.Adójel
WHERE (((lkSzemélyek.Főosztály)<>""))
GROUP BY lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], UNIÓ.Adójel, "FőosztRöv_" & [Dolgozó teljes neve] & "_(" & [azNexon] & ")_utazási.pdf", lkSzemélyek.BFKH
HAVING (((Sum(UNIÓ.Napok)) Between 1 And 365))
ORDER BY lkSzemélyek.BFKH, lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkNemOrvosÁlláshelyekenDolgozóOrvosok
#/#/
SELECT "" AS Sorszám, 789235 AS [PIR törzsszám], lkSzemélyek.[Státusz kódja] AS [az álláshely ÁNYR azonosító száma], Nü([Dolgozó teljes neve],"üres") AS [a kormánytisztviselő neve], lkSzemélyek.adójel AS [adóazonosító jele (10 karakter)], lkSzemélyek.[Születési idő], lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS [a belépés dátuma], lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker] AS [a heti munkaidő tartama], "igen" AS [rendelkezik orvos végzettséggel], "?" AS [egészségügyi alapnyilvántartási száma], lkSzemélyek.[KIRA feladat megnevezés] AS [a kormánytisztviselő feladatköre], IIf([Besorolási  fokozat (KT)] Like "*osztály*",[Besorolási  fokozat (KT)],"nincs") AS [a kormánytisztviselő vezetői besorolása], IIf(Nz([Státuszkód],"-")="-",False,True) AS [Orvos álláshely], lkIlletményTörténet.[Havi illetmény] AS [a Kit szerinti bruttó illetménye 2024 június hónapban], lkIlletményTörténet.[Besorolási fokozat megnevezése:] AS [a Kit szerinti besorolási fokozata 2024 június hónapban], lkSzemélyek.[Besorolási  fokozat (KT)] AS [a Kit szerinti bruttó illetménye 2024 július hónapban], lkSzemélyek.[Kerekített 100 %-os illetmény (eltérített)] AS [a Kit szerinti besorolási fokozata 2024 július hónapban], lkÁlláshelyekHaviból.Főoszt, lkÁlláshelyekHaviból.Osztály, lkSzemélyek.FEOR, lkIlletményTörténet.hatálya, lkSzemélyek.[Iskolai végzettség neve]
FROM lkIlletményTörténet RIGHT JOIN (lkOrvosiÁlláshelyek RIGHT JOIN (lkÁlláshelyekHaviból LEFT JOIN lkSzemélyek ON lkÁlláshelyekHaviból.[Álláshely azonosító] = lkSzemélyek.[Státusz kódja]) ON lkOrvosiÁlláshelyek.Státuszkód = lkSzemélyek.[Státusz kódja]) ON lkIlletményTörténet.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.FEOR) Like "*orvos*" And (lkSzemélyek.FEOR) Not Like "*rvosi laboratóriumi asszisztens") AND ((lkIlletményTörténet.hatálya)=#6/30/2024#) AND ((lkSzemélyek.[státusz neve])="Álláshely") AND ((lkOrvosiÁlláshelyek.Státuszkód) Is Null)) OR (((lkIlletményTörténet.hatálya)=#6/30/2024#) AND ((lkSzemélyek.[Iskolai végzettség neve]) Like "*orvos*") AND ((lkSzemélyek.[státusz neve])="Álláshely") AND ((lkOrvosiÁlláshelyek.Státuszkód) Is Null)) OR (((lkIlletményTörténet.hatálya)=#6/30/2024#) AND ((lkSzemélyek.[Iskolai végzettség neve]) Like "*járvány*" And (lkSzemélyek.[Iskolai végzettség neve])<>"közegészségügyi - járványügyi ellenőr" And (lkSzemélyek.[Iskolai végzettség neve])<>"közegészségügyi - járványügyi felügyelő") AND ((lkSzemélyek.[státusz neve])="Álláshely") AND ((lkOrvosiÁlláshelyek.Státuszkód) Is Null));

#/#/#/
lkNemOrvosÁlláshelyekenDolgozóOrvosokEllenőrzésbe
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Státusz kódja] AS ÁNYR, Nü([Dolgozó teljes neve],"üres") AS Név, lkSzemélyek.adójel AS Adóazonosító, lkSzemélyek.[KIRA feladat megnevezés] AS [KIRA feladat], lkSzemélyek.[Besorolási  fokozat (KT)], lkSzemélyek.FEOR, lkSzemélyek.[Iskolai végzettség neve], kt_azNexon_Adójel02.NLink
FROM kt_azNexon_Adójel02 RIGHT JOIN (lkOrvosiÁlláshelyek RIGHT JOIN lkSzemélyek ON lkOrvosiÁlláshelyek.Státuszkód = lkSzemélyek.[Státusz kódja]) ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.FEOR) Like "*orvos*" And (lkSzemélyek.FEOR) Not Like "*rvosi laboratóriumi asszisztens") AND ((lkSzemélyek.[státusz neve])="Álláshely") AND ((lkOrvosiÁlláshelyek.Státuszkód) Is Null)) OR (((lkSzemélyek.[Iskolai végzettség neve]) Like "*orvos*") AND ((lkSzemélyek.[státusz neve])="Álláshely") AND ((lkOrvosiÁlláshelyek.Státuszkód) Is Null)) OR (((lkSzemélyek.[Iskolai végzettség neve]) Like "*járvány*" And (lkSzemélyek.[Iskolai végzettség neve])<>"közegészségügyi - járványügyi ellenőr" And (lkSzemélyek.[Iskolai végzettség neve])<>"közegészségügyi - járványügyi felügyelő") AND ((lkSzemélyek.[státusz neve])="Álláshely") AND ((lkOrvosiÁlláshelyek.Státuszkód) Is Null));

#/#/#/
lkNépegészségügyiDolgozók
#/#/
SELECT lkJárásiKormányKözpontosítottUnió.Adóazonosító, lkJárásiKormányKözpontosítottUnió.Név, lkJárásiKormányKözpontosítottUnió.[Születési év \ üres állás], lkJárásiKormányKözpontosítottUnió.Neme AS [Dolgozó neme 1 férfi 2 nő], IIf([Járási Hivatal] Like "*kerületi*",[Járási Hivatal],"Megyei szint") AS [Megyei szint], Replace([Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH") AS Főosztály, lkJárásiKormányKözpontosítottUnió.Osztály, lkJárásiKormányKözpontosítottUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkJárásiKormányKözpontosítottUnió.[Ellátott feladat], lkJárásiKormányKözpontosítottUnió.Kinevezés, lkJárásiKormányKözpontosítottUnió.[Feladat jellege: szakmai (SZ) / funkcionális (F) feladatellátás;], lkJárásiKormányKözpontosítottUnió.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ], lkJárásiKormányKözpontosítottUnió.[Heti munkaórák száma], lkJárásiKormányKözpontosítottUnió.[Betöltés aránya], lkJárásiKormányKözpontosítottUnió.[Besorolási fokozat kód:], lkJárásiKormányKözpontosítottUnió.[Besorolási fokozat megnevezése:], lkJárásiKormányKözpontosítottUnió.[Álláshely azonosító], lkJárásiKormányKözpontosítottUnió.[Havi illetmény], lkJárásiKormányKözpontosítottUnió.[Eu finanszírozott], lkJárásiKormányKözpontosítottUnió.[Illetmény forrása], lkJárásiKormányKözpontosítottUnió.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h], lkJárásiKormányKözpontosítottUnió.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], lkJárásiKormányKözpontosítottUnió.[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)], lkJárásiKormányKözpontosítottUnió.[Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis], lkJárásiKormányKözpontosítottUnió.[Ügyfélszolgálati munkatárs (1) ügyfélszolgálati háttér munkatárs], lkJárásiKormányKözpontosítottUnió.[Képesítést adó végzettség], Nz([Adóazonosító],0)*1 AS Adójel, "" AS [Járási hivatal neve]
FROM lkJárásiKormányKözpontosítottUnió
WHERE (((IIf([Járási Hivatal] Like "*kerületi*",[Járási Hivatal],"Megyei szint")) Like "*XXI.*") AND ((lkJárásiKormányKözpontosítottUnió.[Ellátott feladat]) Like "népe*")) OR (((Replace([Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH")) Like "Népeg*")) OR (((lkJárásiKormányKözpontosítottUnió.Osztály) Like "Népeg*"));

#/#/#/
lkNépegészségügyiDolgozókAdatbekérő
#/#/
SELECT lkNépegészségügyiDolgozók.Adójel, lkNépegészségügyiDolgozók.Név, lkNépegészségügyiDolgozók.Főosztály, lkNépegészségügyiDolgozók.Osztály, "" AS [Védőnő?], "" AS [Vezető védőnő?], lkNépegészségügyiDolgozók.Adóazonosító
FROM lkNépegészségügyiDolgozók
WHERE (((lkNépegészségügyiDolgozók.Adóazonosító) Is Not Null And (lkNépegészségügyiDolgozók.Adóazonosító)<>""))
ORDER BY lkNépegészségügyiDolgozók.Főosztály, lkNépegészségügyiDolgozók.Osztály, lkNépegészségügyiDolgozók.Név;

#/#/#/
lkNevek_IFB_részére
#/#/
SELECT tSzemélyek.[Dolgozó teljes neve], tSzervezetiEgységek.Főosztály, tSzervezetiEgységek.Osztály, tSzemélyek.azonosító
FROM tSzemélyek LEFT JOIN tSzervezetiEgységek ON tSzemélyek.[Szervezeti egység kódja] = tSzervezetiEgységek.[Szervezeti egység kódja]
WHERE (((tSzemélyek.azonosító) In (Select azSzemély FROM alkSzemélyek_csak_az_utolsó_előfordulások)) AND ((tSzemélyek.[Tartós távollét típusa]) Is Null) AND ((tSzemélyek.[Szervezeti egység kódja]) Is Not Null And (tSzemélyek.[Szervezeti egység kódja]) Not Like "*MEGB*") AND ((tSzemélyek.[Státusz kódja]) Like "S-*"));

#/#/#/
lkNevekÉsFiktívTörzsszámok
#/#/
SELECT tUtónevek.Keresztnév, CalcStrNumber([Keresztnév]) AS Érték
FROM tUtónevek;

#/#/#/
lkNevekGyakoriságSzerint
#/#/
SELECT lkSorszámok.Sorszám, lkUtónevekGyakorisága.Keresztnév
FROM lkUtónevekGyakorisága, lkSorszámok
ORDER BY lkUtónevekGyakorisága.Keresztnév, lkSorszámok.Sorszám;

#/#/#/
lkNevekOltáshoz
#/#/
SELECT tNevekOltáshoz.Azonosító, tNevekOltáshoz.Főosztály, tNevekOltáshoz.Osztály, tNevekOltáshoz.Oltandók, drhátra([Oltandók]) AS DolgTeljNeve
FROM tNevekOltáshoz;

#/#/#/
lkNevekSzámokkal
#/#/
SELECT DISTINCT Nü([lkszemélyek].[Főosztály],[lkKilépőUnió].[Főosztály]) AS Főosztály, Nü([lkSzemélyek].[Osztály],[lkKilépőUnió].[Osztály]) AS Osztály, zárojeltelenítő([Dolgozó teljes neve]) AS [Dolgozó neve], zárojeltelenítő([Dolgozó születési neve]) AS [Születési név], zárojeltelenítő([Anyja neve]) AS [Anyja születési neve], "Személyi karton / Személyes adatok / Alap adatok / SZEMÉLYNÉV ADATOK -> A születési névben, a viselt névben vagy az anyja nevében számok szerepelnek" AS Megjegyzés, kt_azNexon_Adójel02.NLink AS NLink
FROM lkKilépőUnió RIGHT JOIN (lkSzemélyek LEFT JOIN kt_azNexon_Adójel02 ON lkSzemélyek.Adójel = kt_azNexon_Adójel02.Adójel) ON lkKilépőUnió.Adójel = lkSzemélyek.Adójel
WHERE (((zárojeltelenítő([Dolgozó teljes neve])) Like "*[0-9]*")) OR (((zárojeltelenítő([Dolgozó születési neve])) Like "*[0-9]*")) OR (((zárojeltelenítő([Anyja neve])) Like "*[0-9]*"));

#/#/#/
lkNevekTajOltáshoz01
#/#/
SELECT lkNevekOltáshoz.Főosztály, lkNevekOltáshoz.Osztály, lkNevekOltáshoz.DolgTeljNeve, lkSzemélyek.[TAJ szám], [Születési hely] & ", " & [Születési idő] AS [szül hely \ idő], lkSzemélyek.[Anyja neve], lkSzemélyek.[Állandó lakcím], lkNevekOltáshoz.Oltandók, lkSzemélyek.[Hivatali email]
FROM lkSzemélyek RIGHT JOIN lkNevekOltáshoz ON lkSzemélyek.[Dolgozó teljes neve]=lkNevekOltáshoz.Oltandók
WHERE (((lkSzemélyek.[TAJ szám]) Is Not Null));

#/#/#/
lkNevekTajOltáshoz02
#/#/
SELECT lkNevekOltáshoz.Főosztály, lkNevekOltáshoz.Osztály, lkNevekOltáshoz.DolgTeljNeve, lkSzemélyek.[TAJ szám], [Születési hely] & ", " & [Születési idő] AS [szül hely \ idő], lkSzemélyek.[Anyja neve], lkSzemélyek.[Állandó lakcím], lkNevekOltáshoz.Oltandók, lkSzemélyek.[Hivatali email]
FROM lkNevekOltáshoz LEFT JOIN lkSzemélyek ON lkNevekOltáshoz.DolgTeljNeve=lkSzemélyek.[Dolgozó teljes neve]
WHERE (((lkSzemélyek.[TAJ szám]) Is Not Null));

#/#/#/
lkNevekTajOltáshoz03
#/#/
SELECT DISTINCT Unió.Főosztály, Unió.Osztály, Unió.DolgTeljNeve, Unió.[TAJ szám], Unió.[szül hely \ idő], Unió.[Anyja neve], Unió.[Állandó lakcím], Unió.Oltandók, *
FROM (SELECT  lkNevekTajOltáshoz02.*
FROM lkNevekTajOltáshoz02
UNION SELECT lkNevekTajOltáshoz01.*
FROM  lkNevekTajOltáshoz01
)  AS Unió;

#/#/#/
lkNevekTajOltáshoz04
#/#/
SELECT tNevekOltáshoz.Azonosító, Nz(tNevekOltáshoz.Főosztály,"") AS Főosztály_, Nz(tNevekOltáshoz.Osztály,"") AS Osztály_, Trim(Replace(tNevekOltáshoz.[Oltandók],"dr.","")) AS Név, tNevekOltáshoz.Oltandók
FROM tNevekOltáshoz LEFT JOIN lkNevekTajOltáshoz03 ON tNevekOltáshoz.Oltandók=lkNevekTajOltáshoz03.Oltandók
WHERE (((lkNevekTajOltáshoz03.Oltandók) Is Null));

#/#/#/
lkNevekTajOltáshoz05
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[dolgozó teljes neve] AS DolgTeljNév, lkSzemélyek.[TAJ szám], [Születési hely] & ", " & [Születési idő] AS [szül hely \ idő], lkSzemélyek.[Anyja neve], lkSzemélyek.[Állandó lakcím], lkNevekTajOltáshoz04.Oltandók, lkSzemélyek.[Hivatali email]
FROM lkSzemélyek RIGHT JOIN lkNevekTajOltáshoz04 ON (lkSzemélyek.Főosztály=lkNevekTajOltáshoz04.Főosztály_) AND (lkSzemélyek.Osztály=lkNevekTajOltáshoz04.Osztály_)
WHERE (((lkSzemélyek.[dolgozó teljes neve]) Like "*" & [Név] & "*" Or (lkSzemélyek.[dolgozó teljes neve]) Like "*" & [Oltandók] & "*"));

#/#/#/
lkNevekTajOltáshoz06
#/#/
SELECT lkNevekTajOltáshoz03.*
FROM lkNevekTajOltáshoz03
UNION SELECT lkNevekTajOltáshoz05.*
FROM lkNevekTajOltáshoz05;

#/#/#/
lkNevekTajOltáshoz07
#/#/
SELECT tNevekOltáshoz.Azonosító, tNevekOltáshoz.Főosztály, tNevekOltáshoz.Osztály, tNevekOltáshoz.Oltandók
FROM tNevekOltáshoz LEFT JOIN lkNevekTajOltáshoz06 ON tNevekOltáshoz.Oltandók = lkNevekTajOltáshoz06.Oltandók
WHERE (((lkNevekTajOltáshoz06.Oltandók) Is Null));

#/#/#/
lkNevekTöbbSzóközzel
#/#/
SELECT lkSzemélyek.Főosztály AS Főosztály, lkSzemélyek.Osztály AS Osztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Dolgozó születési neve], lkSzemélyek.[Anyja neve], "Személyi karton / Személyes adatok / Alap adatok / SZEMÉLYNÉV ADATOK vagy SZÜLETÉSI ADATOK -> A születési, a viselt, vagy az anyja nevében túl sok szóköz található, mivel egyet a rendszer automatikusan hozzátesz. A kötőjelek előtt és után nem kell szóköz." AS Megjegyzés, kt_azNexon_Adójel02.NLink AS NLink
FROM lkSzemélyek LEFT JOIN kt_azNexon_Adójel02 ON lkSzemélyek.Adójel = kt_azNexon_Adójel02.Adójel
WHERE (((lkSzemélyek.[Dolgozó teljes neve]) Like "*  *" Or (lkSzemélyek.[Dolgozó teljes neve]) Like "*- *" Or (lkSzemélyek.[Dolgozó teljes neve]) Like "* -*") AND ((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)])<Date())) OR (((lkSzemélyek.[Dolgozó születési neve]) Like "*  *") AND ((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)])<Date())) OR (((lkSzemélyek.[Dolgozó születési neve]) Like "*- *") AND ((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)])<Date())) OR (((lkSzemélyek.[Dolgozó születési neve]) Like "* -*") AND ((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)])<Date())) OR (((lkSzemélyek.[Anyja neve]) Like "*  *") AND ((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)])<Date())) OR (((lkSzemélyek.[Anyja neve]) Like "* -*") AND ((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)])<Date())) OR (((lkSzemélyek.[Anyja neve]) Like "*- *") AND ((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)])<Date()));

#/#/#/
lkNexonForrásÖsszevetés
#/#/
SELECT tNexonForrás.[Forrás Személy azon#], kt_azNexon_Adójel02.azNexon, lkSzemélyek.Törzsszám, lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS Belépés, lkSzemélyek.[Jogviszony vége (kilépés dátuma)] AS Kilépés, lkSzemélyek.[Státusz neve], lkSzemélyek.Főosztály
FROM (kt_azNexon_Adójel02 LEFT JOIN tNexonForrás ON kt_azNexon_Adójel02.azNexon = tNexonForrás.[NEXON személy ID]) INNER JOIN lkSzemélyek ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((tNexonForrás.[NEXON személy ID]) Is Null) AND ((lkSzemélyek.[Jogviszony vége (kilépés dátuma)])>=Now())) OR (((tNexonForrás.[NEXON személy ID]) Is Null) AND ((lkSzemélyek.[Jogviszony vége (kilépés dátuma)]) Is Null) AND ((lkSzemélyek.[Státusz neve])<>"Jegyző")) OR (((tNexonForrás.[NEXON személy ID]) Is Not Null))
ORDER BY IIf(IsNull([Nexon személy ID]),0,1), lkSzemélyek.[Jogviszony vége (kilépés dátuma)];

#/#/#/
lkNőkLétszáma01
#/#/
SELECT DISTINCT lkSzemélyek.Adójel, 1 AS fő, Abs([Tartós távollét típusa] Is Null) AS TTnélkül
FROM lkSzemélyek
WHERE (lkSzemélyek.Neme="Nő" AND lkSzemélyek.[Státusz neve]="Álláshely");

#/#/#/
lkNőkLétszáma02
#/#/
SELECT 2 AS Sor, "Nők létszáma:" AS Adat, Sum(lkNőkLétszáma01.fő) AS Érték, Sum(lkNőkLétszáma01.TTnélkül) AS NemTT
FROM lkNőkLétszáma01
GROUP BY 2, "Nők létszáma:";

#/#/#/
lkNőkLétszáma6ÉvAlattiGyermekkel
#/#/
SELECT 3 AS Sor, "Nők létszáma 6 év alatti gyermekkel:" AS Adat, Sum(fő) AS Érték, Sum([TTnélkül]) AS NemTT
FROM (SELECT DISTINCT lkHozzátartozók.[Dolgozó adóazonosító jele], 1 AS fő, Abs([Tartós távollét típusa] Is Null) AS TTnélkül FROM lkHozzátartozók INNER JOIN lkSzemélyek ON lkHozzátartozók.Adójel = lkSzemélyek.Adójel WHERE lkSzemélyek.Neme="Nő" And lkSzemélyek.[Státusz neve]="Álláshely" And lkHozzátartozók.[Születési idő]>DateSerial(Year(Now())-6,Month(Now()),Day(Now())) And (lkHozzátartozók.[Kapcsolat jellege]="Gyermek" Or lkHozzátartozók.[Kapcsolat jellege]="Nevelt (mostoha)" Or lkHozzátartozók.[Kapcsolat jellege]="Örökbe fogadott"))  AS allekérdezésEgyedi;

#/#/#/
lkNyelvtudásOsztályonként
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, Sum([Nyelvtudás Angol]="IGEN") AS Angol, Sum([Nyelvtudás Arab]="IGEN") AS Arab, Sum([Nyelvtudás Bolgár]="IGEN") AS Bolgár, Sum([Nyelvtudás Cigány]="IGEN") AS Cigány, Sum([Nyelvtudás Cigány (lovári)]="IGEN") AS [Cigány (lovári)], Sum([Nyelvtudás Cseh]="IGEN") AS Cseh, Sum([Nyelvtudás Eszperantó]="IGEN") AS Eszperantó, Sum([Nyelvtudás Finn]="IGEN") AS Finn, Sum([Nyelvtudás Francia]="IGEN") AS Francia, Sum([Nyelvtudás Héber]="IGEN") AS Héber, Sum([Nyelvtudás Holland]="IGEN") AS Holland, Sum([Nyelvtudás Horvát]="IGEN") AS Horvát, Sum([Nyelvtudás Japán]="IGEN") AS Japán, Sum([Nyelvtudás Jelnyelv]="IGEN") AS Jelnyelv, Sum([Nyelvtudás Kínai]="IGEN") AS Kínai, Sum([Nyelvtudás Latin]="IGEN") AS Latin, Sum([Nyelvtudás Lengyel]="IGEN") AS Lengyel, Sum([Nyelvtudás Német]="IGEN") AS Német, Sum([Nyelvtudás Norvég]="IGEN") AS Norvég, Sum([Nyelvtudás Olasz]="IGEN") AS Olasz, Sum([Nyelvtudás Orosz]="IGEN") AS Orosz, Sum([Nyelvtudás Portugál]="IGEN") AS Portugál, Sum([Nyelvtudás Román]="IGEN") AS Román, Sum([Nyelvtudás Spanyol]="IGEN") AS Spanyol, Sum([Nyelvtudás Szerb]="IGEN") AS Szerb, Sum([Nyelvtudás Szlovák]="IGEN") AS Szlovák, Sum([Nyelvtudás Szlovén]="IGEN") AS Szlovén, Sum([Nyelvtudás Török]="IGEN") AS Török, Sum([Nyelvtudás Újgörög]="IGEN") AS Újgörög, Sum([Nyelvtudás Ukrán]="IGEN") AS Ukrán
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely"))
GROUP BY lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.BFKH, lkSzemélyek.[Státusz neve]
ORDER BY lkSzemélyek.BFKH;

#/#/#/
lkNyugdíjazandóDolgozók
#/#/
SELECT lkSzemélyek.[Dolgozó teljes neve], DateSerial(Year(Nz([Születési idő],#1/1/1900#))+65,Month(Nz([Születési idő],#1/1/1900#)),Day(Nz([Születési idő],#1/1/1900#))) AS [Nyugdíjkorhatárt betölti], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.Besorolás2
FROM lkSzemélyek
WHERE (((DateSerial(Year(Nz([Születési idő],#1/1/1900#))+65,Month(Nz([Születési idő],#1/1/1900#)),Day(Nz([Születési idő],#1/1/1900#)))) Between Date() And DateAdd("m",18,Date())) AND ((lkSzemélyek.[Státusz neve])="álláshely"))
ORDER BY DateSerial(Year(Nz([Születési idő],#1/1/1900#))+65,Month(Nz([Születési idő],#1/1/1900#)),Day(Nz([Születési idő],#1/1/1900#))), Month([Születési idő]);

#/#/#/
lkNyugdíjazandóDolgozókHavonta
#/#/
SELECT Year(IIf([Nyugdíjkorhatárt betölti]<Date(),Date(),[Nyugdíjkorhatárt betölti])) & "." & IIf(Len(Month(IIf([Nyugdíjkorhatárt betölti]<Date(),Date(),[Nyugdíjkorhatárt betölti])))<2,0,"") & Month(IIf([Nyugdíjkorhatárt betölti]<Date(),Date(),[Nyugdíjkorhatárt betölti])) AS Év_hónap, Count(lkNyugdíjazandóDolgozók.[Dolgozó teljes neve]) AS Fő
FROM lkNyugdíjazandóDolgozók
GROUP BY Year(IIf([Nyugdíjkorhatárt betölti]<Date(),Date(),[Nyugdíjkorhatárt betölti])) & "." & IIf(Len(Month(IIf([Nyugdíjkorhatárt betölti]<Date(),Date(),[Nyugdíjkorhatárt betölti])))<2,0,"") & Month(IIf([Nyugdíjkorhatárt betölti]<Date(),Date(),[Nyugdíjkorhatárt betölti]));

#/#/#/
lkNyugdíjazandóDolgozókNők40
#/#/
SELECT lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Születési idő], DateSerial(Year(Nz([Születési idő],#1/1/1900#))+65,Month(Nz([Születési idő],#1/1/1900#)),Day(Nz([Születési idő],#1/1/1900#))) AS [65_ életévét betölti], DateSerial(Year(Nz([Születési idő],#1/1/1900#))+58,Month(Nz([Születési idő],#1/1/1900#)),Day(Nz([Születési idő],#1/1/1900#))) AS [58_ életévét betölti], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.Besorolás2 AS Besorolás, lkSzemélyek.[Jogviszony típusa / jogviszony típus] AS Jogviszony, lkSzemélyek.Neme, Year(Date())-ffsplit(Nz([Szolgálati elismerésre jogosultság / Jubileumi jutalom kezdő dát],Year(Date())),".",1)*1 AS [Szolgálati évek]
FROM lkSzemélyek LEFT JOIN lkSzolgálatiIdőElismerés ON lkSzemélyek.Adójel=lkSzolgálatiIdőElismerés.Adójel
WHERE (((DateSerial(Year(Nz([Születési idő],#1/1/1900#))+58,Month(Nz([Születési idő],#1/1/1900#)),Day(Nz([Születési idő],#1/1/1900#)))) Between Date() And DateAdd("m",18,Date())) AND ((lkSzemélyek.Neme)="nő") AND ((lkSzemélyek.[Státusz neve])="álláshely") AND (("Keressük azokat a nőket, akik az 58. születésnapjukat a következő 18 hónapban töltik be.")=True)) OR (((DateSerial(Year(Nz([Születési idő],#1/1/1900#))+65,Month(Nz([Születési idő],#1/1/1900#)),Day(Nz([Születési idő],#1/1/1900#))))>Date()) AND ((DateSerial(Year(Nz([Születési idő],#1/1/1900#))+58,Month(Nz([Születési idő],#1/1/1900#)),Day(Nz([Születési idő],#1/1/1900#))))<Date()) AND ((lkSzemélyek.Neme)="nő") AND ((lkSzemélyek.[Státusz neve])="álláshely") AND (("Keressük azokat a nőket, akik még nem töltötték be a 65. életévüket, de az 58. már igen.")=True))
ORDER BY Year([Születési idő])+58, Month([Születési idő]);

#/#/#/
lkNyugdíjazandóDolgozókNők40Havonta
#/#/
SELECT Year(IIf([58_ életévét betölti]<Date(),Date(),[58_ életévét betölti])) & "." & IIf(Len(Month(IIf([58_ életévét betölti]<Date(),Date(),[58_ életévét betölti])))<2,0,"") & Month(IIf([58_ életévét betölti]<Date(),Date(),[58_ életévét betölti])) AS Hónapok, Count(lkNyugdíjazandóDolgozókNők40.[Dolgozó teljes neve]) AS Létszám
FROM lkNyugdíjazandóDolgozókNők40
GROUP BY Year(IIf([58_ életévét betölti]<Date(),Date(),[58_ életévét betölti])) & "." & IIf(Len(Month(IIf([58_ életévét betölti]<Date(),Date(),[58_ életévét betölti])))<2,0,"") & Month(IIf([58_ életévét betölti]<Date(),Date(),[58_ életévét betölti]));

#/#/#/
lkNyugdíjazandóVezetők
#/#/
SELECT Year([Születési idő])+65 AS Év, Format([Születési idő],"mmmm") AS Hó, Format([születési idő],"dd") AS Nap, lkMindenVezető.[Dolgozó teljes neve] AS Név, lkMindenVezető.Főosztály, lkMindenVezető.Osztály, lkMindenVezető.Besorolás2 AS Besorolás
FROM lkMindenVezető
WHERE (((lkMindenVezető.[Születési idő]) Between DateAdd("yyyy",-61,Date()) And DateAdd("yyyy",-65,Date())))
ORDER BY lkMindenVezető.[Születési idő], lkMindenVezető.BFKH;

#/#/#/
lkNyugdíjazottÉsNyugdíjazandóVezetőkKétDátumKözött01
#/#/
SELECT lkMindenKilépettVezető.Adójel, lkMindenKilépettVezető.Név, lkMindenKilépettVezető.Főosztály, lkMindenKilépettVezető.Osztály, lkMindenKilépettVezető.[Besorolási fokozat megnevezése:], lkMindenKilépettVezető.[Jogviszony megszűnésének, megszüntetésének oka: jogszabályi hiva], lkMindenKilépettVezető.Kilépés AS [Kilépés dátuma]
FROM lkMindenKilépettVezető
WHERE (((lkMindenKilépettVezető.[Jogviszony megszűnésének, megszüntetésének oka: jogszabályi hiva])="A kormánytisztviselő kérelmére a társadalombiztosítási nyugellátásról szóló 1997. évi LXXXI. tv. 18. § (2a) bekezdésében foglalt feltétel fennállása miatt [Kit. 107. § (2) bek. e) pont, 105. § (1) bekezdés c]") AND ((lkMindenKilépettVezető.Kilépés) Between [a Kilépés legkorábbi dátuma] And [A Kilépés legkésőbbi dátuma])) OR (((lkMindenKilépettVezető.Kilépés)>=DateSerial(Year([születési dátum])+65,Month([Születési dátum]),Day([Születési dátum])-1) And (lkMindenKilépettVezető.Kilépés) Between [a Kilépés legkorábbi dátuma] And [A Kilépés legkésőbbi dátuma]));

#/#/#/
lkNyugdíjazottÉsNyugdíjazandóVezetőkKétDátumKözött02
#/#/
SELECT lkMindenVezető.Adójel, lkMindenVezető.[Dolgozó teljes neve], lkMindenVezető.Főosztály, lkMindenVezető.Osztály, lkMindenVezető.[Ellátott feladat] AS [Besorolási fokozat], "" AS Jogvmegsz, lkMindenVezető.[Öregségi nyugdíj korhatár] AS [Kilépés dátuma]
FROM lkMindenVezető
WHERE (((lkMindenVezető.[Öregségi nyugdíj korhatár])>[A Kilépés legkorábbi dátuma] And (lkMindenVezető.[Öregségi nyugdíj korhatár])<[A Kilépés legkésőbbi dátuma] And (lkMindenVezető.[Öregségi nyugdíj korhatár])<=IIf([Kilépés]=0,#1/1/3000#,[kilépés])));

#/#/#/
lkNyugdíjazottÉsNyugdíjazandóVezetőkKétDátumKözött03
#/#/
SELECT DISTINCT lkNyugdíjazottÉsNyugdíjazandóVezetőkKétDátumKözött01.*
FROM lkNyugdíjazottÉsNyugdíjazandóVezetőkKétDátumKözött01
UNION SELECT lkNyugdíjazottÉsNyugdíjazandóVezetőkKétDátumKözött02.*
FROM  lkNyugdíjazottÉsNyugdíjazandóVezetőkKétDátumKözött02;

#/#/#/
lkororszukrányNyelvvizsgák20240912
#/#/
SELECT Nz([Dolgozó azonosító],0)*1 AS Adójel, tOroszUkránNyelvvizsgák20240912.*
FROM tOroszUkránNyelvvizsgák20240912;

#/#/#/
lkoroszukránVégzettség
#/#/
SELECT DISTINCT lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Hivatali email], lkSzemélyek.[Hivatali telefon], lkVégzettségek.[Végzettség neve]
FROM lkVégzettségek INNER JOIN lkSzemélyek ON lkVégzettségek.Adójel = lkSzemélyek.Adójel
WHERE (((lkVégzettségek.[Végzettség neve]) Like "*" & [idegen_nyelv] & "*"));

#/#/#/
lkoroszukránNyelvtudásSzemélytörzsből
#/#/
SELECT lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Hivatali email], lkSzemélyek.[Hivatali telefon], lkororszukrányNyelvvizsgák20240912.[Nyelv neve], lkororszukrányNyelvvizsgák20240912.[Nyelvvizsga foka], lkororszukrányNyelvvizsgák20240912.[Nyelvvizsga típusa], lkSzemélyek.[Státusz neve]
FROM lkororszukrányNyelvvizsgák20240912 LEFT JOIN lkSzemélyek ON lkororszukrányNyelvvizsgák20240912.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Nyelvtudás Orosz])<>"") AND ((lkSzemélyek.[Státusz neve])="álláshely")) OR (((lkSzemélyek.[Nyelvtudás Ukrán])<>"") AND ((lkSzemélyek.[Státusz neve])="álláshely"));

#/#/#/
lkOrvosÁlláshelyekenDolgozók
#/#/
SELECT lkOrvosiÁlláshelyekSorszáma.Sor AS Sorszám, 789235 AS [PIR törzsszám], lkÁlláshelyekHaviból.[Álláshely azonosító] AS [az álláshely ÁNYR azonosító száma], Nü([Dolgozó teljes neve],"üres") AS [a kormánytisztviselő neve], lkSzemélyek.adójel AS [adóazonosító jele (10 karakter)], lkSzemélyek.[Születési idő], lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS [a belépés dátuma], lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker] AS [a heti munkaidő tartama], IIf(IsNull([Dolgozó teljes neve]),"","igen") AS [rendelkezik orvos végzettséggel], lkOrvosokAdatai.NyilvántartásiSzám AS [egészségügyi alapnyilvántartási száma], lkSzemélyek.[KIRA feladat megnevezés] AS [a kormánytisztviselő feladatköre], IIf([Besorolási  fokozat (KT)] Like "*osztály*",[Besorolási  fokozat (KT)],"nincs") AS [a kormánytisztviselő vezetői besorolása], IIf(Nz([Státuszkód],"-")="-",False,True) AS [Orvos álláshely], lkIlletményTörténet.[Havi illetmény] AS [a Kit szerinti bruttó illetménye 2024 június hónapban], lkIlletményTörténet.[Besorolási fokozat megnevezése:] AS [a Kit szerinti besorolási fokozata 2024 június hónapban], lkSzemélyek.[Kerekített 100 %-os illetmény (eltérített)] AS [a Kit szerinti illetménye 2024 július hónapban], lkÁlláshelyekHaviból.Főoszt, lkÁlláshelyekHaviból.Osztály, lkSzemélyek.FEOR, lkSzemélyek.[Iskolai végzettség neve], lkSzemélyek.[KIRA feladat megnevezés], lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Besorolási  fokozat (KT)], lkOrvosokAdatai.EszmeiIdőKezdete, DateDiff("yyyy",[EszmeiIdőKezdete],Now()) AS ÉvekSzáma, lkOrvosokAdatai.EszjtvBesorolásSzerintiIlletmény
FROM lkOrvosokAdatai RIGHT JOIN (lkOrvosiÁlláshelyekSorszáma RIGHT JOIN ((lkIlletményTörténet RIGHT JOIN lkSzemélyek ON lkIlletményTörténet.Adójel = lkSzemélyek.Adójel) RIGHT JOIN (lkOrvosiÁlláshelyek RIGHT JOIN lkÁlláshelyekHaviból ON lkOrvosiÁlláshelyek.Státuszkód = lkÁlláshelyekHaviból.[Álláshely azonosító]) ON lkSzemélyek.[Státusz kódja] = lkOrvosiÁlláshelyek.Státuszkód) ON lkOrvosiÁlláshelyekSorszáma.Státuszkód = lkOrvosiÁlláshelyek.Státuszkód) ON lkOrvosokAdatai.Adójel = lkSzemélyek.Adójel
WHERE (((lkOrvosiÁlláshelyek.Státuszkód) Is Not Null) AND ((lkSzemélyek.[státusz neve])="Álláshely" Or (lkSzemélyek.[státusz neve]) Is Null) AND ((lkIlletményTörténet.hatálya)=#6/30/2024# Or (lkIlletményTörténet.hatálya) Is Null));

#/#/#/
lkOrvosÁlláshelyekenDolgozókEllenőrzésbe
#/#/
SELECT lkSzemélyek.[Dolgozó teljes neve] AS Név, lkÁlláshelyekHaviból.[Álláshely azonosító] AS [az álláshely ÁNYR azonosító száma], lkÁlláshelyekHaviból.Főoszt, lkÁlláshelyekHaviból.Osztály, lkSzemélyek.[Iskolai végzettség neve], lkSzemélyek.[KIRA feladat megnevezés], lkSzemélyek.FEOR, lkSzemélyek.[Besorolási  fokozat (KT)]
FROM lkSzemélyek RIGHT JOIN (lkOrvosiÁlláshelyek RIGHT JOIN lkÁlláshelyekHaviból ON lkOrvosiÁlláshelyek.Státuszkód = lkÁlláshelyekHaviból.[Álláshely azonosító]) ON lkSzemélyek.[Státusz kódja] = lkOrvosiÁlláshelyek.Státuszkód
WHERE (((lkOrvosiÁlláshelyek.Státuszkód) Is Not Null) AND ((lkSzemélyek.[státusz neve])="Álláshely" Or (lkSzemélyek.[státusz neve]) Is Null));

#/#/#/
lkOrvosÁlláshelyekenDolgozókEllenőrzésbe_archív
#/#/
SELECT lkOrvosÁlláshelyekenDolgozók.Név, lkOrvosÁlláshelyekenDolgozók.[az álláshely ÁNYR azonosító száma], lkOrvosÁlláshelyekenDolgozók.Főoszt, lkOrvosÁlláshelyekenDolgozók.Osztály, lkOrvosÁlláshelyekenDolgozók.[Iskolai végzettség neve], lkOrvosÁlláshelyekenDolgozók.[KIRA feladat megnevezés], lkOrvosÁlláshelyekenDolgozók.FEOR, lkOrvosÁlláshelyekenDolgozók.[Besorolási  fokozat (KT)]
FROM lkOrvosÁlláshelyekenDolgozók;

#/#/#/
lkOrvosÁlláshelyekenDolgozókKEHI01
#/#/
SELECT lkOrvosÁlláshelyekenDolgozók.Sorszám, lkOrvosÁlláshelyekenDolgozók.[PIR törzsszám], lkOrvosÁlláshelyekenDolgozók.[az álláshely ÁNYR azonosító száma], lkOrvosÁlláshelyekenDolgozók.[a kormánytisztviselő neve], lkOrvosÁlláshelyekenDolgozók.[adóazonosító jele (10 karakter)], lkOrvosÁlláshelyekenDolgozók.[Születési idő], lkOrvosÁlláshelyekenDolgozók.[a belépés dátuma], lkOrvosÁlláshelyekenDolgozók.[a heti munkaidő tartama], lkOrvosÁlláshelyekenDolgozók.[rendelkezik orvos végzettséggel], lkOrvosÁlláshelyekenDolgozók.[egészségügyi alapnyilvántartási száma], lkOrvosÁlláshelyekenDolgozók.[a kormánytisztviselő feladatköre], lkOrvosÁlláshelyekenDolgozók.[a kormánytisztviselő vezetői besorolása], lkOrvosÁlláshelyekenDolgozók.[Orvos álláshely], lkOrvosÁlláshelyekenDolgozók.[a Kit szerinti bruttó illetménye 2024 június hónapban], lkOrvosÁlláshelyekenDolgozók.[a Kit szerinti besorolási fokozata 2024 június hónapban], lkOrvosÁlláshelyekenDolgozók.[a Kit szerinti bruttó illetménye 2024 június hónapban], lkOrvosÁlláshelyekenDolgozók.Főoszt, lkOrvosÁlláshelyekenDolgozók.Osztály, lkOrvosÁlláshelyekenDolgozók.FEOR, lkOrvosÁlláshelyekenDolgozók.[Iskolai végzettség neve], lkOrvosÁlláshelyekenDolgozók.[KIRA feladat megnevezés], lkOrvosÁlláshelyekenDolgozók.Név, lkOrvosÁlláshelyekenDolgozók.[Besorolási  fokozat (KT)], lkOrvosÁlláshelyekenDolgozók.EszmeiIdőKezdete, lkOrvosÁlláshelyekenDolgozók.ÉvekSzáma, EszjtvBesorolásiKategóriák.EszjtvBesorolásiKategóriák, lkOrvosÁlláshelyekenDolgozók.EszjtvBesorolásSzerintiIlletmény
FROM lkOrvosÁlláshelyekenDolgozók, EszjtvBesorolásiKategóriák
WHERE (((EszjtvBesorolásiKategóriák.Max)>=[ÉvekSzáma]) AND ((EszjtvBesorolásiKategóriák.Min)<=[ÉvekSzáma]));

#/#/#/
lkOrvosÁlláshelyekenDolgozókKEHI02
#/#/
SELECT lkOrvosÁlláshelyekenDolgozók.Sorszám, lkOrvosÁlláshelyekenDolgozók.[PIR törzsszám], lkOrvosÁlláshelyekenDolgozók.[az álláshely ÁNYR azonosító száma], lkOrvosÁlláshelyekenDolgozók.[a kormánytisztviselő neve], lkOrvosÁlláshelyekenDolgozók.[adóazonosító jele (10 karakter)], lkOrvosÁlláshelyekenDolgozók.[Születési idő], lkOrvosÁlláshelyekenDolgozók.[a belépés dátuma], lkOrvosÁlláshelyekenDolgozók.[a heti munkaidő tartama], lkOrvosÁlláshelyekenDolgozók.[rendelkezik orvos végzettséggel], lkOrvosÁlláshelyekenDolgozók.[egészségügyi alapnyilvántartási száma], lkOrvosÁlláshelyekenDolgozók.[a kormánytisztviselő feladatköre], lkOrvosÁlláshelyekenDolgozók.[a kormánytisztviselő vezetői besorolása], lkOrvosÁlláshelyekenDolgozók.[Orvos álláshely], lkOrvosÁlláshelyekenDolgozók.[a Kit szerinti bruttó illetménye 2024 június hónapban], lkOrvosÁlláshelyekenDolgozók.[a Kit szerinti besorolási fokozata 2024 június hónapban], lkOrvosÁlláshelyekenDolgozók.[a Kit szerinti illetménye 2024 július hónapban], lkOrvosÁlláshelyekenDolgozók.Főoszt, lkOrvosÁlláshelyekenDolgozók.Osztály, lkOrvosÁlláshelyekenDolgozók.FEOR, lkOrvosÁlláshelyekenDolgozók.[Iskolai végzettség neve], lkOrvosÁlláshelyekenDolgozók.[KIRA feladat megnevezés], lkOrvosÁlláshelyekenDolgozók.Név, lkOrvosÁlláshelyekenDolgozók.[Besorolási  fokozat (KT)], lkOrvosÁlláshelyekenDolgozók.EszmeiIdőKezdete, lkOrvosÁlláshelyekenDolgozók.ÉvekSzáma, "" AS EszjtvBesorolásiKategóriák, 0 AS EszjtvBesorolásSzerintiIlletmény
FROM lkOrvosÁlláshelyekenDolgozók
WHERE (((lkOrvosÁlláshelyekenDolgozók.[a kormánytisztviselő neve])="üres"));

#/#/#/
lkOrvosÁlláshelyekenDolgozókKEHI03
#/#/
SELECT ÜresekÉsKategóriázottak.*, *
FROM (SELECT lkOrvosÁlláshelyekenDolgozókKEHI02.*
from lkOrvosÁlláshelyekenDolgozókKEHI02 union
SELECT lkOrvosÁlláshelyekenDolgozókKEHI01.*
FROM lkOrvosÁlláshelyekenDolgozókKEHI01)  AS ÜresekÉsKategóriázottak;

#/#/#/
lkOrvosÁlláshelyekenDolgozóNemOrvosokEllenőrzésbe
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Besorolási  fokozat (KT)], lkSzemélyek.[Státusz kódja] AS ÁNYR, lkSzemélyek.[KIRA feladat megnevezés] AS [KIRA feladat], lkSzemélyek.FEOR, lkSzemélyek.[Iskolai végzettség neve], kt_azNexon_Adójel02.NLink
FROM kt_azNexon_Adójel02 RIGHT JOIN (lkSzemélyek RIGHT JOIN lkOrvosiÁlláshelyek ON lkSzemélyek.[Státusz kódja] = lkOrvosiÁlláshelyek.Státuszkód) ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Iskolai végzettség neve]) Not Like "*orvos*") AND ((([lkSzemélyek].[FEOR]) Like "*orvos*" And ([lkSzemélyek].[FEOR]) Not Like "*rvosi laboratóriumi asszisztens")=False) AND ((([lkSzemélyek].[Iskolai végzettség neve]) Like "*járvány*" And ([lkSzemélyek].[Iskolai végzettség neve])<>"közegészségügyi - járványügyi ellenőr" And ([lkSzemélyek].[Iskolai végzettség neve])<>"közegészségügyi - járványügyi felügyelő")=False) AND ((lkSzemélyek.[státusz neve])="Álláshely"));

#/#/#/
lkOrvosÁlláshelyekrőlJelentés
#/#/
SELECT lkOrvosÁlláshelyekenDolgozók.Név, lkOrvosÁlláshelyekenDolgozók.Státuszkód, lkOrvosÁlláshelyekenDolgozók.Főoszt, lkOrvosÁlláshelyekenDolgozók.Osztály, lkOrvosÁlláshelyekenDolgozók.[Iskolai végzettség neve], lkOrvosÁlláshelyekenDolgozók.[KIRA feladat megnevezés], lkOrvosÁlláshelyekenDolgozók.FEOR, lkOrvosÁlláshelyekenDolgozók.[Besorolási  fokozat (KT)], lkOrvosÁlláshelyekenDolgozók.Szint, lkOrvosÁlláshelyekenDolgozók.tisztifőorvos, lkOrvosÁlláshelyekenDolgozók.helyettes, lkOrvosÁlláshelyekenDolgozók.[közegészség-, vagy járványügyi], lkOrvosÁlláshelyekenDolgozók.Egészségbiztosítási, lkOrvosÁlláshelyekenDolgozók.Rehabilitációs, [lkOrvosok].[Státusz kódja] Is Not Null AS Orvos
FROM (lkOrvosÁlláshelyekenDolgozók LEFT JOIN lkOrvosok ON lkOrvosÁlláshelyekenDolgozók.Státuszkód = lkOrvosok.[Státusz kódja]) LEFT JOIN lkSzemélyek ON lkOrvosÁlláshelyekenDolgozók.Adójel = lkSzemélyek.Adójel;

#/#/#/
lkOrvosiAlkalmasságiVizsgálatElőzőHónap
#/#/
SELECT lkSzemélyek.[TAJ szám], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Orvosi vizsgálat időpontja]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Orvosi vizsgálat időpontja]) Between DateSerial(Year(Now()),Month(Now())-1,1) And DateSerial(Year(Now()),Month(Now()),0)))
ORDER BY lkSzemélyek.BFKH, lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkOrvosiÁlláshelyek
#/#/
SELECT tOrvosiÁlláshelyek.azOrvosiÁlláshely, tOrvosiÁlláshelyek.[alaplétszámba tartozó orvosi  álláshely azonosítója] AS Státuszkód, tOrvosiÁlláshelyek.HatályKezdet AS [Utolsó hatály], tOrvosiÁlláshelyek.HatályVég
FROM tOrvosiÁlláshelyek
WHERE (((tOrvosiÁlláshelyek.HatályVég) Is Null) AND (("Eredetileg ez volt:(Select Max(Hatály) From [tOrvosiÁlláshelyek] as tmp Where [tOrvosiÁlláshelyek].[alaplétszámba tartozó orvosi  álláshely azonosítója]=tmp.[alaplétszámba tartozó orvosi  álláshely azonosítója])")<>""));

#/#/#/
lkOrvosiÁlláshelyekSorszáma
#/#/
SELECT (Select count([Státuszkód]) From lkOrvosiÁlláshelyek as Tmp Where Tmp.[Státuszkód]>=lkOrvosiÁlláshelyek.[Státuszkód]) AS Sor, lkOrvosiÁlláshelyek.Státuszkód
FROM lkOrvosiÁlláshelyek
ORDER BY lkOrvosiÁlláshelyek.Státuszkód DESC;

#/#/#/
lkOrvosiVizsgálatHumán
#/#/
SELECT Month([Jogviszony kezdete (belépés dátuma)]) AS [Belépés hónapja], IIf([Orvosi vizsgálat következő időpontja]<DateAdd("m",1,DateSerial(Year(Now()),Month(Now()),1))-1,"Lejáró","") AS Lejárók, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[TAJ szám], lkSzemélyek.[Hivatali email], lkSzemélyek.[Hivatali mobil], lkSzemélyek.[Születési idő], lkSzemélyek.[Születési hely], lkSzemélyek.[Anyja neve], lkSzemélyek.Neme, lkSzemélyek.[Állandó lakcím], lkSzemélyek.[Szervezeti egység neve], lkSzemélyek.[Orvosi vizsgálat időpontja], lkSzemélyek.[Orvosi vizsgálat típusa], lkSzemélyek.[Orvosi vizsgálat eredménye], lkSzemélyek.[Orvosi vizsgálat észrevételek], lkSzemélyek.[Orvosi vizsgálat következő időpontja], lkSzemélyek.[Tartós távollét típusa]
FROM lkSzemélyek
GROUP BY Month([Jogviszony kezdete (belépés dátuma)]), IIf([Orvosi vizsgálat következő időpontja]<DateAdd("m",1,DateSerial(Year(Now()),Month(Now()),1))-1,"Lejáró",""), lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[TAJ szám], lkSzemélyek.[Hivatali email], lkSzemélyek.[Hivatali mobil], lkSzemélyek.[Születési idő], lkSzemélyek.[Születési hely], lkSzemélyek.[Anyja neve], lkSzemélyek.Neme, lkSzemélyek.[Állandó lakcím], lkSzemélyek.[Szervezeti egység neve], lkSzemélyek.[Orvosi vizsgálat időpontja], lkSzemélyek.[Orvosi vizsgálat típusa], lkSzemélyek.[Orvosi vizsgálat eredménye], lkSzemélyek.[Orvosi vizsgálat észrevételek], lkSzemélyek.[Orvosi vizsgálat következő időpontja], lkSzemélyek.[Tartós távollét típusa]
HAVING (((lkSzemélyek.[Szervezeti egység neve]) Like "*humán*"));

#/#/#/
lkOrvosiVizsgálatTeljesÁllomány
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Dolgozó születési neve] AS [Születési név], lkSzemélyek.[Születési idő], lkSzemélyek.[Születési hely], lkSzemélyek.[TAJ szám], lkSzemélyek.[Orvosi vizsgálat időpontja], lkSzemélyek.[Orvosi vizsgálat következő időpontja], lkSzemélyek.[Hivatali email], IIf([tartós távollét típusa] Is Not Null,"TT","") AS TT, lkSzemélyek.[Jogviszony vége (kilépés dátuma)] AS [Kilépés dátuma]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY lkSzemélyek.BFKH;

#/#/#/
lkOrvosiVizsgálatTeljesÁllomány_EgészségügyiSzolgáltatóAdataival
#/#/
SELECT lkOrvosiVizsgálatTeljesÁllomány.Főosztály, lkOrvosiVizsgálatTeljesÁllomány.Osztály, lkOrvosiVizsgálatTeljesÁllomány.Név, lkOrvosiVizsgálatTeljesÁllomány.[Születési név], lkOrvosiVizsgálatTeljesÁllomány.[Születési idő], lkOrvosiVizsgálatTeljesÁllomány.[Születési hely], lkOrvosiVizsgálatTeljesÁllomány.[TAJ szám], IIf([Kilépés dátuma]<DateSerial(Year(Now()),Month(Now())+4,1)-1 And (Nz([Orvosi vizsgálat következő időpontja],0)<Now() And Nz([TT],"")<>"TT") Or (Nz([Lejárat dátuma],"")<>"" And Nz([Lejárat dátuma],0)<Now()),"Lejárt","") AS Lejárt_e, lkOrvosiVizsgálatTeljesÁllomány.[Orvosi vizsgálat következő időpontja], lkOrvosiVizsgálatTeljesÁllomány.[Hivatali email], lkOrvosiVizsgálatTeljesÁllomány.TT, lkOrvosiVizsgálatTeljesÁllomány.[Kilépés dátuma], lkEgészségügyiSzolgáltatóAdataiUnió.Munkakör, lkEgészségügyiSzolgáltatóAdataiUnió.[Vizsgálat típusa], lkEgészségügyiSzolgáltatóAdataiUnió.[Lejárat dátuma], lkEgészségügyiSzolgáltatóAdataiUnió.Korlátozás, lkEgészségügyiSzolgáltatóAdataiUnió.[Vizsgálat eredménye], lkEgészségügyiSzolgáltatóAdataiUnió.[Vizsgálat Dátuma]
FROM lkEgészségügyiSzolgáltatóAdataiUnió RIGHT JOIN lkOrvosiVizsgálatTeljesÁllomány ON lkEgészségügyiSzolgáltatóAdataiUnió.TAJ = lkOrvosiVizsgálatTeljesÁllomány.[TAJ szám]
WHERE (((True)<>False))
ORDER BY IIf([Kilépés dátuma]<DateSerial(Year(Now()),Month(Now())+4,1)-1 And (Nz([Orvosi vizsgálat következő időpontja],0)<Now() And Nz([TT],"")<>"TT") Or (Nz([Lejárat dátuma],"")<>"" And Nz([Lejárat dátuma],0)<Now()),"Lejárt","") DESC , lkOrvosiVizsgálatTeljesÁllomány.[Orvosi vizsgálat következő időpontja];

#/#/#/
lkOrvosiVizsgálatTeljesÁllomány_munkahelyStatisztika01
#/#/
SELECT IIf([Munkavégzés helye - cím] Is Null Or [Munkavégzés helye - cím]="",[Munkavégzés helye - megnevezés],[Munkavégzés helye - cím]) AS Cím, lkOrvosiVizsgálatTeljesÁllomány_EgészségügyiSzolgáltatóAdataival.[TAJ szám], Irsz([Cím])*1 AS irsz, kerület([irsz]) AS Kerület, IIf(Kerület([irsz]) Between 1 And 3 Or kerület([irsz]) Between 11 And 12 Or kerület([irsz])=22,"Buda","Pest") AS Oldal
FROM lkOrvosiVizsgálatTeljesÁllomány_EgészségügyiSzolgáltatóAdataival INNER JOIN lkSzemélyek ON lkOrvosiVizsgálatTeljesÁllomány_EgészségügyiSzolgáltatóAdataival.[TAJ szám] = lkSzemélyek.[TAJ szám]
WHERE (((lkOrvosiVizsgálatTeljesÁllomány_EgészségügyiSzolgáltatóAdataival.Lejárt_e)="Lejárt"))
ORDER BY lkOrvosiVizsgálatTeljesÁllomány_EgészségügyiSzolgáltatóAdataival.[TAJ szám] DESC;

#/#/#/
lkOrvosiVizsgálatTeljesÁllomány_telephelyenként
#/#/
SELECT lkOrvosiVizsgálatTeljesÁllomány_munkahelyStatisztika01.Cím, Count(lkOrvosiVizsgálatTeljesÁllomány_munkahelyStatisztika01.[TAJ szám]) AS Létszám
FROM lkOrvosiVizsgálatTeljesÁllomány_munkahelyStatisztika01
GROUP BY lkOrvosiVizsgálatTeljesÁllomány_munkahelyStatisztika01.Cím;

#/#/#/
lkOrvosiVizsgálatTeljesÁllomány_városrészenként
#/#/
SELECT lkOrvosiVizsgálatTeljesÁllomány_munkahelyStatisztika01.Oldal, lkOrvosiVizsgálatTeljesÁllomány_munkahelyStatisztika01.Kerület, Count(lkOrvosiVizsgálatTeljesÁllomány_munkahelyStatisztika01.[TAJ szám]) AS Létszám
FROM lkOrvosiVizsgálatTeljesÁllomány_munkahelyStatisztika01
GROUP BY lkOrvosiVizsgálatTeljesÁllomány_munkahelyStatisztika01.Oldal, lkOrvosiVizsgálatTeljesÁllomány_munkahelyStatisztika01.Kerület;

#/#/#/
lkOrvosok
#/#/
SELECT IIf([Dolgozó teljes neve] Is Null,"üres",[Dolgozó teljes neve]) AS Név, lkSzemélyek.[Státusz kódja], lkÁlláshelyekHaviból.Főoszt, lkÁlláshelyekHaviból.Osztály, lkSzemélyek.[Iskolai végzettség neve], lkSzemélyek.[KIRA feladat megnevezés], lkSzemélyek.FEOR, lkSzemélyek.[Besorolási  fokozat (KT)], IIf([Főoszt] Like "*kerületi*","járás","vármegye") AS Szint, "" AS tisztifőorvos, "" AS helyettes, IIf([főoszt] Like "*népegészség*" Or [Osztály] Like "*népegészség*","igen","") AS [közegészség-, vagy járványügyi], IIf([főoszt] Like "*Egészségbizt*","igen","") AS Egészségbiztosítási, IIf([osztály]="Rehabilitációs Szakértői Osztály 2." Or [osztály]="Rehabilitációs Szakértői Osztály 3.","igen","") AS Rehabilitációs, IIf(Nz([Státuszkód],"-")="-",False,True) AS [Orvos álláshely], lkSzemélyek.[Jogfolytonos idő kezdete], lkSzemélyek.Adójel
FROM lkOrvosiÁlláshelyek RIGHT JOIN (lkÁlláshelyekHaviból LEFT JOIN lkSzemélyek ON lkÁlláshelyekHaviból.[Álláshely azonosító] = lkSzemélyek.[Státusz kódja]) ON lkOrvosiÁlláshelyek.Státuszkód = lkSzemélyek.[Státusz kódja]
WHERE (((lkÁlláshelyekHaviból.Főoszt) Like "Rehab*" Or (lkÁlláshelyekHaviból.Főoszt) Like "Népeg*" Or (lkÁlláshelyekHaviból.Főoszt) Like "Egész*") AND ((lkSzemélyek.FEOR) Like "*orvos*") AND ((lkSzemélyek.[státusz neve])="Álláshely")) OR (((lkÁlláshelyekHaviból.Főoszt) Like "Rehab*" Or (lkÁlláshelyekHaviból.Főoszt) Like "Népeg*" Or (lkÁlláshelyekHaviból.Főoszt) Like "Egész*") AND ((lkSzemélyek.[KIRA feladat megnevezés]) Like "*orvos*" And (lkSzemélyek.[KIRA feladat megnevezés])<>"Főosztályvezetői feladatok (több szakmai területet magában foglaló szervezeti egységeknél, ha nem főállatorvos vagy tisztifőorvos)")) OR (((lkÁlláshelyekHaviból.Osztály) Like "Népeg*") AND ((lkSzemélyek.FEOR) Like "*orvos*")) OR (((lkÁlláshelyekHaviból.Osztály) Like "Népeg*") AND ((lkSzemélyek.[KIRA feladat megnevezés]) Like "*orvos*" And (lkSzemélyek.[KIRA feladat megnevezés])<>"Főosztályvezetői feladatok (több szakmai területet magában foglaló szervezeti egységeknél, ha nem főállatorvos vagy tisztifőorvos)")) OR (((lkSzemélyek.[Iskolai végzettség neve]) Like "*orvos*")) OR (((lkSzemélyek.[Iskolai végzettség neve]) Like "*járvány*" And (lkSzemélyek.[Iskolai végzettség neve])<>"közegészségügyi - járványügyi ellenőr" And (lkSzemélyek.[Iskolai végzettség neve])<>"közegészségügyi - járványügyi felügyelő"));

#/#/#/
lkOrvosokAdatai
#/#/
SELECT tOrvosokAdatai.azOrvos, tOrvosokAdatai.Adójel, tOrvosokAdatai.EszmeiIdőKezdete, tOrvosokAdatai.ÉvekSzáma, tOrvosokAdatai.EszjtvBesorolásSzerintiIlletmény, tOrvosokAdatai.NyilvántartásiSzám
FROM tOrvosokAdatai
WHERE (((tOrvosokAdatai.OrvosHatályVége) Is Null));

#/#/#/
lkOsztályokFeladatkörönkéntiLétszáma
#/#/
SELECT [lkÁlláshelyek(havi)_1].Főosztály, [lkÁlláshelyek(havi)_1].Osztály, [lkÁlláshelyek(havi)_1].Feladatkör, Sum(IIf([Állapot]="betöltött",1,0)) AS Betöltött, Sum(IIf([Állapot]="betöltött",0,1)) AS Üres
FROM [lkÁlláshelyek(havi)] AS [lkÁlláshelyek(havi)_1]
GROUP BY [lkÁlláshelyek(havi)_1].Főosztály, [lkÁlláshelyek(havi)_1].Osztály, [lkÁlláshelyek(havi)_1].Feladatkör, [lkÁlláshelyek(havi)_1].[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
ORDER BY bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]);

#/#/#/
lkOsztályonkéntiÁlláshelyekÁNYR
#/#/
SELECT lk_Főosztály_Osztály_tSzervezet.bfkhkód, Nz([Dolgozó teljes neve],"üres álláshely") AS Név, lk_Főosztály_Osztály_tSzervezet.Főoszt, lk_Főosztály_Osztály_tSzervezet.Osztály, lkÁlláshelyek.[Álláshely besorolási kategóriája] AS [Álláshely besorolása], lkÁlláshelyek.[Álláshely azonosító], Nz([Szerződés/Kinevezés típusa],"határozatlan") AS [Álláshely hatálya], IIf(Nz([Tartós távollét típusa],"")="","Nem","Igen") AS [Tartós távollévő], lkSzemélyek.[Jogviszony típusa / jogviszony típus] AS [Jogviszony típusa], lkÁlláshelyek.[Álláshely típusa], lkSzemélyek.[Jogviszony vége (kilépés dátuma)] AS [KIlépés dátuma]
FROM lk_Főosztály_Osztály_tSzervezet RIGHT JOIN (lkSzemélyek RIGHT JOIN lkÁlláshelyek ON lkSzemélyek.[Státusz kódja] = lkÁlláshelyek.[Álláshely azonosító]) ON (lk_Főosztály_Osztály_tSzervezet.Osztály = lkÁlláshelyek.Oszt) AND (lk_Főosztály_Osztály_tSzervezet.Főoszt = lkÁlláshelyek.Főoszt);

#/#/#/
lkOsztályonkéntiÁlláshelyekÁNYR - azonosak keresése
#/#/
SELECT lkOsztályonkéntiÁlláshelyekÁNYR.[Álláshely azonosító], lkOsztályonkéntiÁlláshelyekÁNYR.Főoszt
FROM lkOsztályonkéntiÁlláshelyekÁNYR
WHERE (((lkOsztályonkéntiÁlláshelyekÁNYR.[Álláshely azonosító]) In (SELECT [Álláshely azonosító] FROM [lkOsztályonkéntiÁlláshelyekÁNYR] As Tmp GROUP BY [Álláshely azonosító] HAVING Count(*)>1 )))
ORDER BY lkOsztályonkéntiÁlláshelyekÁNYR.[Álláshely azonosító];

#/#/#/
lkOsztályvezetőiÁlláshelyek
#/#/
SELECT lkSzervezetekSzemélyekből.bfkh, lkSzervezetÁlláshelyek.SzervezetKód, lkSzervezetekSzemélyekből.Főosztály, lkSzervezetekSzemélyekből.Osztály, lkSzervezetÁlláshelyek.álláshely, lkSzervezetÁlláshelyek.[Tervezett betöltési adatok - Előmeneteli fokozat megnevezés], lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Besorolási  fokozat (KT)], lkSzemélyek.[Vezetői beosztás megnevezése], lkSzemélyek.[Vezetői megbízás típusa], lkSzemélyek.[Kerekített 100 %-os illetmény (eltérített)] AS Illetmény, lkSzemélyek.[Tartós távollét típusa], lkSzemélyek.[Tartós távollét vége], lkSzemélyek.[Tartós távollét tervezett vége], kt_azNexon_Adójel02.NLink
FROM (lkSzervezetekSzemélyekből RIGHT JOIN (lkSzervezetÁlláshelyek LEFT JOIN lkSzemélyek ON lkSzervezetÁlláshelyek.Álláshely = lkSzemélyek.[Státusz kódja]) ON lkSzervezetekSzemélyekből.[Szervezeti egység kódja] = lkSzervezetÁlláshelyek.SzervezetKód) LEFT JOIN kt_azNexon_Adójel02 ON lkSzemélyek.Adójel = kt_azNexon_Adójel02.Adójel
WHERE (((lkSzemélyek.[Besorolási  fokozat (KT)])="Osztályvezető") AND ((lkSzemélyek.[Státusz neve])="Álláshely")) OR (((lkSzemélyek.[Vezetői megbízás típusa])="Osztályvezető") AND ((lkSzemélyek.[Státusz neve])="Álláshely")) OR (((lkSzemélyek.[Vezetői beosztás megnevezése])="Osztályvezető") AND ((lkSzemélyek.[Státusz neve])="Álláshely")) OR (((lkSzervezetÁlláshelyek.[Tervezett betöltési adatok - Előmeneteli fokozat megnevezés])="osztályvezető"))
ORDER BY lkSzervezetekSzemélyekből.bfkh;

#/#/#/
lkOsztályvezetőiÁlláshelyekElsőKinevezésDátumával
#/#/
SELECT lkOsztályvezetőiÁlláshelyek.bfkh, lkOsztályvezetőiÁlláshelyek.SzervezetKód, lkOsztályvezetőiÁlláshelyek.Főosztály, lkOsztályvezetőiÁlláshelyek.Osztály, lkOsztályvezetőiÁlláshelyek.álláshely, Nz([Dolgozó teljes neve],"Betöltetlen") AS Név, lkOsztályvezetőiÁlláshelyek.Illetmény, lkElsőOsztályvezetővéSorolásDátuma.[MinOfVáltozás dátuma]
FROM lkElsőOsztályvezetővéSorolásDátuma RIGHT JOIN (kt_azNexon_Adójel02 RIGHT JOIN lkOsztályvezetőiÁlláshelyek ON kt_azNexon_Adójel02.NLink = lkOsztályvezetőiÁlláshelyek.NLink) ON lkElsőOsztályvezetővéSorolásDátuma.Adójel = kt_azNexon_Adójel02.Adójel;

#/#/#/
lkÖregkoriNyugdíjazásÉsTT
#/#/
SELECT lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, Year([Születési idő])+65 AS [Öregkori nyugdíjazás éve], lkSzemélyek.[Jogviszony vége (kilépés dátuma)], lkSzemélyek.[Tartós távollét típusa], lkSzemélyek.[Tartós távollét kezdete], lkSzemélyek.[Tartós távollét vége], lkSzemélyek.[Tartós távollét tervezett vége]
FROM lkSzemélyek
WHERE (((lkSzemélyek.Főosztály) Like "* V. ker*") AND ((Year([Születési idő])+65) Between Year(Date()) And Year(Date())+1)) OR (((lkSzemélyek.Főosztály) Like "* II. ker*") AND ((Year([Születési idő])+65) Between Year(Date()) And Year(Date())+1)) OR (((lkSzemélyek.Főosztály) Like "* IX. ker*") AND ((Year([Születési idő])+65) Between Year(Date()) And Year(Date())+1)) OR (((lkSzemélyek.Főosztály) Like "* V. ker*") AND ((lkSzemélyek.[Tartós távollét kezdete]) Is Not Null)) OR (((lkSzemélyek.Főosztály) Like "* II. ker*") AND ((lkSzemélyek.[Tartós távollét kezdete]) Is Not Null)) OR (((lkSzemélyek.Főosztály) Like "* IX. ker*") AND ((lkSzemélyek.[Tartós távollét kezdete]) Is Not Null))
ORDER BY Year([Születési idő])+65, Bfkh([Szervezeti egység kódja]), lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkÖsszesÁlláshely
#/#/
SELECT [Álláshely azonosító], Mező4, [Besorolási fokozat megnevezése:], [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], [Besorolási fokozat kód:], "A" as Jelleg, Mező14 as BetöltésAránya
                      FROM Járási_állomány
                      
                  UNION SELECT [Álláshely azonosító], Mező4, [Besorolási fokozat megnevezése:], [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], [Besorolási fokozat kód:], "A" as Jelleg, Mező14 as BetöltésAránya
                      FROM Kormányhivatali_állomány
                    
                   UNION SELECT [Álláshely azonosító], Mező4, [Besorolási fokozat megnevezése:], [Nexon szótárelemnek megfelelő szervezeti egység azonosító], [Besorolási fokozat kód:], "K" as Jelleg, Mező13 as BetöltésAránya
                      FROM Központosítottak;

#/#/#/
lkÖsszesJogviszonyIdőtartamSzemélyek
#/#/
SELECT tSzemélyek.Adójel, Sum(Nü([Jogviszony vége (kilépés dátuma)],Date())-[Jogviszony kezdete (belépés dátuma)]+1) AS ÖsszIdőtartam
FROM tSzemélyek
WHERE (((tSzemélyek.[Jogviszony típusa / jogviszony típus])="Kormányzati szolgálati jogviszony") AND ((Nü([Jogviszony vége (kilépés dátuma)],Date())-[Jogviszony kezdete (belépés dátuma)]+1)>0)) OR (((tSzemélyek.[Jogviszony típusa / jogviszony típus])="Hivatásos állományú") AND ((Nü([Jogviszony vége (kilépés dátuma)],Date())-[Jogviszony kezdete (belépés dátuma)]+1)>0))
GROUP BY tSzemélyek.Adójel;

#/#/#/
lkÖsszetettLétszámStatisztika01
#/#/
SELECT TTvel.Sor, TTvel.Adat, TTvel.Érték AS [Tartósan távollévőkkel], TTvel.nemTT AS [Tartósan távollévők nélkül]
FROM (SELECT Sor, Adat, Érték, nemTT
FROM lkRészmunkaidősökLétszáma
UNION ALL
SELECT Sor, Adat, Érték, nemTT
FROM lkNőkLétszáma6ÉvAlattiGyermekkel
UNION ALL
SELECT Sor, Adat, Érték, nemTT
FROM lkNőkLétszáma02
UNION ALL
SELECT Sor, Adat, Érték, nemTT
FROM lkDolgozókLétszáma18ÉvAlattiGyermekkel
UNION ALL
SELECT Sor, Adat, Érték, nemTT
FROM lk55ÉletévüketBetöltöttekLétszáma
UNION ALL
SELECT Sor, Adat, Érték, nemTT
FROM lk25ÉletévüketBeNemTöltöttekLétszáma
UNION ALL
SELECT Sor, Adat, Érték, nemTT
FROM lkBetöltöttLétszám
)  AS TTvel
ORDER BY TTvel.Sor;

#/#/#/
lkÖsszetettLétszámStatisztika02
#/#/
SELECT lkÖsszetettLétszámStatisztika01.Sor, lkÖsszetettLétszámStatisztika01.Adat, lkÖsszetettLétszámStatisztika01.[Tartósan távollévőkkel], lkÖsszetettLétszámStatisztika01.[Tartósan távollévőkkel]/(SELECT COUNT(Adójel) 
        FROM lkSzemélyek 
        WHERE [Státusz neve] = "Álláshely"
    ) AS ArányTávollévőkkel, lkÖsszetettLétszámStatisztika01.[Tartósan távollévők nélkül], lkÖsszetettLétszámStatisztika01.[Tartósan távollévők nélkül]/((SELECT COUNT(Adójel) 
            FROM lkSzemélyek 
            WHERE [Státusz neve] = "Álláshely"
        )-(SELECT COUNT([Tartós távollét típusa]) 
            FROM lkSzemélyek 
            WHERE [Státusz neve] = "Álláshely"
        )) AS ArányTávollévőkNélkül
FROM lkÖsszetettLétszámStatisztika01;

#/#/#/
lkÖsszKerületbőlKilépettekHavonta
#/#/
SELECT "Mind" AS Kerület, DateSerial(Year([Jogviszony megszűnésének, megszüntetésének időpontja]),Month([Jogviszony megszűnésének, megszüntetésének időpontja])+1,1)-1 AS Tárgyhó, Sum(1) AS Fő
FROM lkKilépőUnió
WHERE (((lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének oka: jogszabályi hiva]) Not Like "*létre*") AND ((lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja]) Between #7/1/2023# And #7/31/2024#) AND ((lkKilépőUnió.[Megyei szint VAGY Járási Hivatal]) Like "Budapest Főváros Kormányhivatala *"))
GROUP BY "Mind", DateSerial(Year([Jogviszony megszűnésének, megszüntetésének időpontja]),Month([Jogviszony megszűnésének, megszüntetésének időpontja])+1,1)-1;

#/#/#/
lkÖsszKerületiBetöltöttLétszám01
#/#/
SELECT Replace([Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH") AS [Kerületi hivatal], tHaviJelentésHatálya1.hatálya, Sum(IIf([Mező4]="üres állás",0,1)) AS [Betöltött létszám], Sum(IIf([Mező4]="üres állás",1,0)) AS Üres
FROM tHaviJelentésHatálya1 INNER JOIN tJárási_állomány ON tHaviJelentésHatálya1.hatályaID = tJárási_állomány.hatályaID
GROUP BY Replace([Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH"), tHaviJelentésHatálya1.hatálya
HAVING (((tHaviJelentésHatálya1.hatálya) Between #7/1/2023# And #7/31/2024#));

#/#/#/
lkÖsszKerületiBetöltöttLétszám02
#/#/
SELECT "Mind" AS [Kerületi hivatal], lkÖsszKerületiBetöltöttLétszám01.hatálya, Sum(lkÖsszKerületiBetöltöttLétszám01.[Betöltött létszám]) AS Betöltött, Sum(lkÖsszKerületiBetöltöttLétszám01.Üres) AS Üresek, [Betöltött]+[Üresek] AS Engedélyezett
FROM lkÖsszKerületiBetöltöttLétszám01
GROUP BY "Mind", lkÖsszKerületiBetöltöttLétszám01.hatálya;

#/#/#/
lkÖsszKerületiKimutatás
#/#/
SELECT lkÖsszKerületiBetöltöttLétszám02.[Kerületi hivatal], lkÖsszKerületiBetöltöttLétszám02.hatálya, lkÖsszKerületiBetöltöttLétszám02.Betöltött, lkÖsszKerületiBetöltöttLétszám02.Üresek, lkÖsszKerületiBetöltöttLétszám02.Engedélyezett, lkÖsszKerületbőlKilépettekHavonta.Fő AS Kilépettek
FROM lkÖsszKerületbőlKilépettekHavonta RIGHT JOIN lkÖsszKerületiBetöltöttLétszám02 ON lkÖsszKerületbőlKilépettekHavonta.Tárgyhó = lkÖsszKerületiBetöltöttLétszám02.hatálya;

#/#/#/
lkPGFtábla
#/#/
SELECT [adóazonosító jel]*1 AS Adójel, tPGFtábla.*
FROM tPGFtábla;

#/#/#/
lkpróba
#/#/
SELECT *
FROM lkEngedélyezettésLétszámKimenet02
WHERE ((([Főosztály]) Like 'Nyugd*' Or ([Főosztály]) Like "Egész*")) OR ((([Főosztály]) Like "* V.*"))
ORDER BY Főosztály, [Oszt];

#/#/#/
lkpróbaidősKilépőkSzámaÉvente2b
#/#/
SELECT lkpróbaidősKilépőkSzámaÉventeHavonta.Év, Sum(lkpróbaidősKilépőkSzámaÉventeHavonta.[Kilépők száma]) AS Kilépők
FROM lkpróbaidősKilépőkSzámaÉventeHavonta
GROUP BY lkpróbaidősKilépőkSzámaÉventeHavonta.Év;

#/#/#/
lkpróbaidősKilépőkSzámaÉventeHavonta
#/#/
SELECT Year([JogviszonyVége]) AS Év, Month([JogviszonyVége]) AS Hó, Count(lkSzemélyekMind.Azonosító) AS [Kilépők száma]
FROM lkSzemélyekMind
WHERE (((lkSzemélyekMind.[KIRA jogviszony jelleg]) Like "Kormányzati*" Or (lkSzemélyekMind.[KIRA jogviszony jelleg])="Munkaviszony") AND ((lkSzemélyekMind.JogviszonyVége) Is Not Null Or (lkSzemélyekMind.JogviszonyVége)<>"") AND ((lkSzemélyekMind.[HR kapcsolat megszűnés módja (Kilépés módja)]) Like "*próbaidő*") AND ((Year([JogviszonyVége]))>=2019 And (Year([JogviszonyVége]))<=Year(Now())))
GROUP BY Year([JogviszonyVége]), Month([JogviszonyVége])
ORDER BY Year([JogviszonyVége]), Month([JogviszonyVége]);

#/#/#/
lkpróbaidősKilépőkSzámaÉventeHavonta2
#/#/
SELECT lkpróbaidősKilépőkSzámaÉventeHavonta.Év, IIf([Hó]=1,[Kilépők száma],0) AS 1, IIf([Hó]=2,[Kilépők száma],0) AS 2, IIf([Hó]=3,[Kilépők száma],0) AS 3, IIf([Hó]=4,[Kilépők száma],0) AS 4, IIf([Hó]=5,[Kilépők száma],0) AS 5, IIf([Hó]=6,[Kilépők száma],0) AS 6, IIf([Hó]=7,[Kilépők száma],0) AS 7, IIf([Hó]=8,[Kilépők száma],0) AS 8, IIf([Hó]=9,[Kilépők száma],0) AS 9, IIf([Hó]=10,[Kilépők száma],0) AS 10, IIf([Hó]=12,[Kilépők száma],0) AS 11, IIf([Hó]=12,[Kilépők száma],0) AS 12
FROM lkpróbaidősKilépőkSzámaÉventeHavonta;

#/#/#/
lkpróbaidősKilépőkSzámaÉventeHavonta3
#/#/
SELECT lkpróbaidősKilépőkSzámaÉventeHavonta2.Év AS Év, Sum(lkpróbaidősKilépőkSzámaÉventeHavonta2.[1]) AS 01, Sum(lkpróbaidősKilépőkSzámaÉventeHavonta2.[2]) AS 02, Sum(lkpróbaidősKilépőkSzámaÉventeHavonta2.[3]) AS 03, Sum(lkpróbaidősKilépőkSzámaÉventeHavonta2.[4]) AS 04, Sum(lkpróbaidősKilépőkSzámaÉventeHavonta2.[5]) AS 05, Sum(lkpróbaidősKilépőkSzámaÉventeHavonta2.[6]) AS 06, Sum(lkpróbaidősKilépőkSzámaÉventeHavonta2.[7]) AS 07, Sum(lkpróbaidősKilépőkSzámaÉventeHavonta2.[8]) AS 08, Sum(lkpróbaidősKilépőkSzámaÉventeHavonta2.[9]) AS 09, Sum(lkpróbaidősKilépőkSzámaÉventeHavonta2.[10]) AS 10, Sum(lkpróbaidősKilépőkSzámaÉventeHavonta2.[11]) AS 11, Sum(lkpróbaidősKilépőkSzámaÉventeHavonta2.[12]) AS 12, lkpróbaidősKilépőkSzámaÉvente2b.Kilépők AS Összesen
FROM lkpróbaidősKilépőkSzámaÉventeHavonta2 INNER JOIN lkpróbaidősKilépőkSzámaÉvente2b ON lkpróbaidősKilépőkSzámaÉventeHavonta2.Év = lkpróbaidősKilépőkSzámaÉvente2b.Év
GROUP BY lkpróbaidősKilépőkSzámaÉventeHavonta2.Év, lkpróbaidősKilépőkSzámaÉvente2b.Kilépők;

#/#/#/
lkPróbaidőVégeNincsKitöltve
#/#/
SELECT DISTINCT IIf(Nz([lkszemélyek].[Főosztály],"")="",[Mező5],[lkszemélyek].[Főosztály]) AS Főosztály, IIf([lkszemélyek].[Osztály]="",[Mező6],[lkszemélyek].[Osztály]) AS Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, kt_azNexon_Adójel02.NLink
FROM kt_azNexon_Adójel02 RIGHT JOIN (lkSzemélyek LEFT JOIN lkKilépők ON lkSzemélyek.[Adóazonosító jel] = lkKilépők.Adóazonosító) ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Státusz neve])="álláshely") AND ((lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége]) Is Null) AND ((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)])>Date()-200))
ORDER BY IIf(Nz([lkszemélyek].[Főosztály],"")="",[Mező5],[lkszemélyek].[Főosztály]);

#/#/#/
lkProjektekHaviTörténetből
#/#/
SELECT DISTINCT tKözpontosítottak.[Adóazonosító], tKözpontosítottak.[Projekt megnevezése]
FROM tHaviJelentésHatálya1 INNER JOIN tKözpontosítottak ON tHaviJelentésHatálya1.hatályaID = tKözpontosítottak.hatályaID
WHERE (((Len([Projekt megnevezése]))>0));

#/#/#/
lkReferensek
#/#/
SELECT kt_azNexon_Adójel02.azNexon, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Osztály, lkSzemélyek.[Hivatali email], lkSzemélyek.[Hivatali telefon], IIf([KIRA feladat megnevezés] Like "*osztály*" Or [Besorolási  fokozat (KT)] Like "*osztály*",True,False) Or [lkSzemélyek].[Feladatkör] Like "*osztály*" Or [Vezetői megbízás típusa1] Is Not Null AS Vezető, IIf(IsNull((Select NexonAz From tReferensekTerületNélkül as t Where [kt_azNexon_Adójel].[azNexon]=t.NexonAz)),True,False) AS VanTerülete, IIf(Nz([Tartós távollét típusa],False)<>False,True,False) AS TT
FROM kt_azNexon_Adójel02 RIGHT JOIN lkSzemélyek ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.Főosztály) Like "Humán*") AND ((lkSzemélyek.[KIRA feladat megnevezés]) Like "humán*" Or (lkSzemélyek.[KIRA feladat megnevezés]) Like "*osztály*"))
ORDER BY lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkReferensekFőosztályok
#/#/
SELECT tReferensekFőosztályok.azRef, tReferensekFőosztályok.Főosztály, tReferensekFőosztályok.bfkhFőosztály, tReferensekFőosztályok.Referens, 1/(Select count(azRef) from tReferensekFőosztályok as Tmp Where Tmp.Főosztály=tReferensekFőosztályok.Főosztály) AS Arány, tReferensekFőosztályok.azNexon, tReferensekFőosztályok.Osztály, tReferensekFőosztályok.bfkhOsztály, tReferensekFőosztályok.Telefon, tReferensekFőosztályok.Szoba, tReferensekFőosztályok.azSzoba
FROM tReferensekFőosztályok;

#/#/#/
lkReferensekreJutóÁlláshelyekSzáma
#/#/
SELECT lkReferensekFőosztályok.Referens, Sum(IIf([Születési év \ üres állás]="üres állás",1,0)*[Betöltés aránya]*[Arány]) AS Üres, Sum(IIf([Születési év \ üres állás]="üres állás",0,1)*[Betöltés aránya]*[Arány]) AS Betöltött, Sum([Betöltés aránya]*[Arány]) AS [Összes álláshely]
FROM lkJárásiKormányKözpontosítottUnió INNER JOIN lkReferensekFőosztályok ON lkJárásiKormányKözpontosítottUnió.Főosztály = lkReferensekFőosztályok.Főosztály
GROUP BY lkReferensekFőosztályok.Referens;

#/#/#/
lkRégiÉsJelenlegiIlletmény
#/#/
SELECT lkÁllománytáblákTörténetiUniója.hatályaID, lkJárásiKormányKözpontosítottUnió.Adóazonosító, lkJárásiKormányKözpontosítottUnió.Kinevezés, lkÁllománytáblákTörténetiUniója.Kinevezés, [lkJárásiKormányKözpontosítottUnió].[Havi illetmény]/[lkJárásiKormányKözpontosítottUnió].[Heti munkaórák száma]*40 AS Jelenlegi40órás, [lkÁllománytáblákTörténetiUniója].[Havi illetmény]/[lkÁllománytáblákTörténetiUniója].[Heti munkaórák száma]*40 AS Régi40órás, Len([lkJárásiKormányKözpontosítottUnió].[Adóazonosító]) AS Hossz, lkJárásiKormányKözpontosítottUnió.Jelleg INTO tmpRégiÉsJelenlegiIlletmény IN 'L:\Ugyintezok\Adatszolgáltatók\Adatbázisok\Háttértárak\EllenőrzésHavi_háttértár.accdb'
FROM lkJárásiKormányKözpontosítottUnió LEFT JOIN lkÁllománytáblákTörténetiUniója ON lkJárásiKormányKözpontosítottUnió.Adóazonosító = lkÁllománytáblákTörténetiUniója.Adóazonosító
WHERE (((lkJárásiKormányKözpontosítottUnió.Adóazonosító) Is Not Null Or (lkJárásiKormányKözpontosítottUnió.Adóazonosító)<>"") And ((Len(lkJárásiKormányKözpontosítottUnió.Adóazonosító))>1) And ((lkJárásiKormányKözpontosítottUnió.Jelleg)="A"));

#/#/#/
lkRégiHibákIntézkedésekSegédűrlaphoz
#/#/
SELECT ktRégiHibákIntézkedések.HASH, ktRégiHibákIntézkedések.azIntézkedések, tIntézkedések.azIntFajta, tIntézkedések.IntézkedésDátuma, tIntézkedések.Hivatkozás
FROM tIntézkedések INNER JOIN ktRégiHibákIntézkedések ON tIntézkedések.azIntézkedések = ktRégiHibákIntézkedések.azIntézkedések
ORDER BY tIntézkedések.IntézkedésDátuma;

#/#/#/
lkRégiHibákUtolsóIntézkedés
#/#/
SELECT ktRégiHibákIntézkedések.azIntézkedések, ktRégiHibákIntézkedések.HASH, tIntézkedések.azIntFajta
FROM tIntézkedésFajták INNER JOIN (tIntézkedések INNER JOIN ktRégiHibákIntézkedések ON tIntézkedések.azIntézkedések = ktRégiHibákIntézkedések.azIntézkedések) ON tIntézkedésFajták.azIntFajta = tIntézkedések.azIntFajta
WHERE (((ktRégiHibákIntézkedések.rögzítésDátuma)=(Select Max([tmp].[rögzítésDátuma]) 
FROM [ktRégiHibákIntézkedések] as Tmp 
Where Tmp.[HASH] = [ktRégiHibákIntézkedések].[HASH] 
Group By Tmp.Hash)));

#/#/#/
lkRégiHibákŰrlaphoz
#/#/
SELECT tRégiHibák.[Első mező], Szétbontó([Második mező],[lekérdezésNeve]) AS Hiba, tRégiHibák.[Első Időpont], tRégiHibák.[Utolsó Időpont]
FROM tRégiHibák
WHERE (((tRégiHibák.lekérdezésNeve) Is Not Null));

#/#/#/
lkRégiHibákŰrlapRekordforrása
#/#/
SELECT tRégiHibák.[Első mező], ktRégiHibákIntézkedések.HASH, ktRégiHibákIntézkedések.azIntézkedések, tRégiHibák.lekérdezésNeve, IIf([Utolsó Időpont]=(select max([utolsó időpont]) from tRégiHibák where lekérdezésneve <>"lkÜresÁlláshelyekÁllapotfelmérő" And lekérdezésneve <>"lkFontosHiányzóAdatok02") Or (select max([utolsó időpont]) from tRégiHibák where lekérdezésneve ="lkFontosHiányzóAdatok02"),1,2) AS V
FROM tRégiHibák LEFT JOIN ktRégiHibákIntézkedések ON tRégiHibák.[Első mező] = ktRégiHibákIntézkedések.HASH
WHERE (((tRégiHibák.lekérdezésNeve) Like "*" & [Űrlapok]![űRégiHibákIntézkedések]![Kereső] & "*") AND ((IIf([Utolsó Időpont]=(select max([utolsó időpont]) from tRégiHibák where lekérdezésneve <>"lkÜresÁlláshelyekÁllapotfelmérő" And lekérdezésneve <>"lkFontosHiányzóAdatok02") Or (select max([utolsó időpont]) from tRégiHibák where lekérdezésneve ="lkFontosHiányzóAdatok02"),1,2))=IIf([Űrlapok]![űRégiHibákIntézkedések]![FennállE]=3,1,[Űrlapok]![űRégiHibákIntézkedések]![FennállE]) Or (IIf([Utolsó Időpont]=(select max([utolsó időpont]) from tRégiHibák where lekérdezésneve <>"lkÜresÁlláshelyekÁllapotfelmérő" And lekérdezésneve <>"lkFontosHiányzóAdatok02") Or (select max([utolsó időpont]) from tRégiHibák where lekérdezésneve ="lkFontosHiányzóAdatok02"),1,2))=IIf([Űrlapok]![űRégiHibákIntézkedések]![FennállE]=3,2,[Űrlapok]![űRégiHibákIntézkedések]![FennállE]))) OR (((ktRégiHibákIntézkedések.HASH) Like "*" & [Űrlapok]![űRégiHibákIntézkedések]![Kereső] & "*") AND ((IIf([Utolsó Időpont]=(select max([utolsó időpont]) from tRégiHibák where lekérdezésneve <>"lkÜresÁlláshelyekÁllapotfelmérő" And lekérdezésneve <>"lkFontosHiányzóAdatok02") Or (select max([utolsó időpont]) from tRégiHibák where lekérdezésneve ="lkFontosHiányzóAdatok02"),1,2))=IIf([Űrlapok]![űRégiHibákIntézkedések]![FennállE]=3,1,[Űrlapok]![űRégiHibákIntézkedések]![FennállE]) Or (IIf([Utolsó Időpont]=(select max([utolsó időpont]) from tRégiHibák where lekérdezésneve <>"lkÜresÁlláshelyekÁllapotfelmérő" And lekérdezésneve <>"lkFontosHiányzóAdatok02") Or (select max([utolsó időpont]) from tRégiHibák where lekérdezésneve ="lkFontosHiányzóAdatok02"),1,2))=IIf([Űrlapok]![űRégiHibákIntézkedések]![FennállE]=3,2,[Űrlapok]![űRégiHibákIntézkedések]![FennállE]))) OR (((IIf([Utolsó Időpont]=(select max([utolsó időpont]) from tRégiHibák where lekérdezésneve <>"lkÜresÁlláshelyekÁllapotfelmérő" And lekérdezésneve <>"lkFontosHiányzóAdatok02") Or (select max([utolsó időpont]) from tRégiHibák where lekérdezésneve ="lkFontosHiányzóAdatok02"),1,2))=IIf([Űrlapok]![űRégiHibákIntézkedések]![FennállE]=3,1,[Űrlapok]![űRégiHibákIntézkedések]![FennállE]) Or (IIf([Utolsó Időpont]=(select max([utolsó időpont]) from tRégiHibák where lekérdezésneve <>"lkÜresÁlláshelyekÁllapotfelmérő" And lekérdezésneve <>"lkFontosHiányzóAdatok02") Or (select max([utolsó időpont]) from tRégiHibák where lekérdezésneve ="lkFontosHiányzóAdatok02"),1,2))=IIf([Űrlapok]![űRégiHibákIntézkedések]![FennállE]=3,2,[Űrlapok]![űRégiHibákIntézkedések]![FennállE])) AND ((tRégiHibák.[Második mező]) Like "*" & [Űrlapok]![űRégiHibákIntézkedések]![Kereső] & "*"));

#/#/#/
lkRehabilitációhozLista_TAJ_jogvVégeKezdete
#/#/
SELECT lkSzemélyek.[TAJ szám], lkSzemélyek.[Jogviszony kezdete (belépés dátuma)], lkSzemélyek.[Jogviszony vége (kilépés dátuma)], lkSzemélyek.[Jogviszony típusa / jogviszony típus]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Jogviszony vége (kilépés dátuma)]) Is Null Or (lkSzemélyek.[Jogviszony vége (kilépés dátuma)])>="#2023. 01. 01.#") AND ((lkSzemélyek.[Jogviszony típusa / jogviszony típus])="Kormányzati szolgálati jogviszony")) OR (((lkSzemélyek.[Jogviszony vége (kilépés dátuma)]) Is Null Or (lkSzemélyek.[Jogviszony vége (kilépés dátuma)])>="#2023. 01. 01.#") AND ((lkSzemélyek.[Jogviszony típusa / jogviszony típus])="Munkaviszony"));

#/#/#/
lkRészmunkaidősökAránya01
#/#/
SELECT DISTINCT Unió.Tábla, tSzervezetiEgységek.Főosztály, tSzervezetiEgységek.Osztály, Unió.Adóazonosító, Unió.[Álláshely azonosító], Unió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Unió.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ], Unió.[Heti munkaórák száma], IIf([Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ] = "T"
		OR [Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ] = "NYT", 1, 0) AS [Teljes munkaidős], IIf([Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ] = "T"
		OR [Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ] = "NYT", 0, 1) AS Részmunkaidős
FROM tSzervezetiEgységek RIGHT JOIN (SELECT "Kormányhivatali_állomány" AS Tábla
		,"Részmunkaidősnek van jelölve, de teljes munkaidőben dolgozik." AS [Hibás érték]
		,Kormányhivatali_állomány.Adóazonosító
		,Kormányhivatali_állomány.[Álláshely azonosító]
		,Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
		,Kormányhivatali_állomány.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ]
		,Kormányhivatali_állomány.[Heti munkaórák száma]
		,IIf(Right([Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ], 1) = "R"
			AND [Heti munkaórák száma] = 40, True, False) AS Hibás
	FROM Kormányhivatali_állomány
	
	UNION
	
	SELECT "Járási_állomány" AS Tábla
		,"Részmunkaidősnek van jelölve, de teljes munkaidőben dolgozik." AS [Hibás érték]
		,Járási_állomány.Adóazonosító
		,Járási_állomány.[Álláshely azonosító]
		,Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
		,Járási_állomány.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ]
		,Járási_állomány.[Heti munkaórák száma]
		,IIf(Right([Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ], 1) = "R"
			AND [Heti munkaórák száma] = 40, True, False) AS Hibás
	FROM Járási_állomány
	
	UNION
	
	SELECT "Kormányhivatali_állomány" AS Tábla
		,"Teljes munkaidősnek van jelölve, de részmunkaidőben dolgozik." AS [Hibás érték]
		,Kormányhivatali_állomány.Adóazonosító
		,Kormányhivatali_állomány.[Álláshely azonosító]
		,Kormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
		,Kormányhivatali_állomány.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ]
		,Kormányhivatali_állomány.[Heti munkaórák száma]
		,IIf(Right([Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ], 1) = "T"
			AND [Heti munkaórák száma] <> 40, True, False) AS Hibás
	FROM Kormányhivatali_állomány
	
	UNION
	
	SELECT "Járási_állomány" AS Tábla
		,"Teljes munkaidősnek van jelölve, de részmunkaidőben dolgozik." AS [Hibás érték]
		,Járási_állomány.Adóazonosító
		,Járási_állomány.[Álláshely azonosító]
		,Járási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
		,Járási_állomány.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ]
		,Járási_állomány.[Heti munkaórák száma]
		,IIf(Right([Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ], 1) = "T"
			AND [Heti munkaórák száma] <> 40, True, False) AS Hibás
	FROM Járási_állomány
	)  AS Unió ON tSzervezetiEgységek.[Szervezeti egység kódja] = Unió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
WHERE (((Len([Adóazonosító])) > "0"));

#/#/#/
lkRészmunkaidősökAránya02
#/#/
SELECT lkRészmunkaidősökAránya01.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkRészmunkaidősökAránya01.Főosztály, lkRészmunkaidősökAránya01.Osztály, Sum(lkRészmunkaidősökAránya01.[Teljes munkaidős]) AS [Teljes munkaidős létszám], Sum(lkRészmunkaidősökAránya01.Részmunkaidős) AS [Részmunkaidős létszám]
FROM lkRészmunkaidősökAránya01
GROUP BY lkRészmunkaidősökAránya01.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkRészmunkaidősökAránya01.Főosztály, lkRészmunkaidősökAránya01.Osztály;

#/#/#/
lkRészmunkaidősökAránya03
#/#/
SELECT bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]) AS [BFKH kód], lkRészmunkaidősökAránya02.Főosztály, lkRészmunkaidősökAránya02.Osztály, lkRészmunkaidősökAránya02.[Teljes munkaidős létszám], lkRészmunkaidősökAránya02.[Részmunkaidős létszám], [Részmunkaidős létszám]/[Teljes munkaidős létszám] AS Aránya
FROM lkRészmunkaidősökAránya02
ORDER BY bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]), [Részmunkaidős létszám]/[Teljes munkaidős létszám] DESC;

#/#/#/
lkRészmunkaidősökLétszáma
#/#/
SELECT 7 AS Sor, "Részmunkaidősök létszáma:" AS Adat, Sum([fő]) AS Érték, Sum(TTnélkül) AS nemTT
FROM (SELECT DISTINCT lkSzemélyek.Adójel, 1 AS Fő, Abs([Tartós távollét típusa] Is Null) AS TTnélkül FROM lkSzemélyek WHERE (((lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker])<>40)) and lkSzemélyek.[Státusz neve] = "Álláshely")  AS lista;

#/#/#/
lkRuházatiTámogatásraJogosultakLétszáma
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, Count(lkSzemélyek.Adójel) AS CountOfAdójel
FROM lkSzemélyek
WHERE (((lkSzemélyek.Főosztály) Like "BFKH*") AND ((lkSzemélyek.Osztály) Like "Kormányablak*") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null Or (lkSzemélyek.[Tartós távollét típusa])<>"Mentesítés felmentési / felmondási időn belül") AND ((lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége]) Is Null Or (lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége])<Date()) AND ((DateAdd("m",30,dtátal([Tartós távollét kezdete]))<dtátal(Nü([Tartós távollét vége],[Tartós távollét tervezett vége])))=0) AND ((lkSzemélyek.[Státusz neve])="Álláshely")) OR (((lkSzemélyek.Főosztály) Like "Központi*") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null Or (lkSzemélyek.[Tartós távollét típusa])<>"Mentesítés felmentési / felmondási időn belül") AND ((lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége]) Is Null Or (lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége])<Date()) AND ((DateAdd("m",30,dtátal([Tartós távollét kezdete]))<dtátal(Nü([Tartós távollét vége],[Tartós távollét tervezett vége])))=0) AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
GROUP BY lkSzemélyek.Főosztály, lkSzemélyek.Osztály;

#/#/#/
lkRuházatiTámogatásraJogosultakListája
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Adójel
FROM lkSzemélyek
WHERE (((lkSzemélyek.Főosztály) Like "BFKH*") AND ((lkSzemélyek.Osztály) Like "Kormányablak*") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null Or (lkSzemélyek.[Tartós távollét típusa])<>"Mentesítés felmentési / felmondási időn belül") AND ((lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége]) Is Null Or (lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége])<Date()) AND ((DateAdd("d",30,dtátal([Tartós távollét kezdete]))<dtátal(Nü([Tartós távollét vége],[Tartós távollét tervezett vége])))=0) AND ((lkSzemélyek.[Státusz neve])="Álláshely")) OR (((lkSzemélyek.Főosztály) Like "Központi*") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null Or (lkSzemélyek.[Tartós távollét típusa])<>"Mentesítés felmentési / felmondási időn belül") AND ((lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége]) Is Null Or (lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége])<Date()) AND ((DateAdd("d",30,dtátal([Tartós távollét kezdete]))<dtátal(Nü([Tartós távollét vége],[Tartós távollét tervezett vége])))=0) AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY lkSzemélyek.BFKH, lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkRuházatiTámogatásraJogosultakListájaMegjegyzésekkel
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Adójel, lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége] AS [Próbaidő vége], IIf(Nü([Szerződés/Kinevezés - próbaidő vége],0)<Date() Or [Szerződés/Kinevezés - próbaidő vége] Is Null,"","Próbaidős") & [Tartós távollét típusa] AS Megjegyzés
FROM lkSzemélyek
WHERE (((lkSzemélyek.Főosztály) Like "BFKH*") AND ((lkSzemélyek.Osztály) Like "Kormányablak*") AND ((lkSzemélyek.[Státusz neve])="Álláshely")) OR (((lkSzemélyek.Főosztály) Like "Központi*") AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY lkSzemélyek.BFKH, lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkSávosBérStatisztika01
#/#/
SELECT tBesorolás_átalakító.Sorrend, lk_Állománytáblákból_Illetmények.BesorolásHavi, Min([Illetmény]/[Heti munkaórák száma]*40) AS Bérmin, Max([Illetmény]/[Heti munkaórák száma]*40) AS Bérmax
FROM tBesorolás_átalakító INNER JOIN lk_Állománytáblákból_Illetmények ON tBesorolás_átalakító.[Az álláshely jelölése] = lk_Állománytáblákból_Illetmények.BesorolásHavi
WHERE (((lk_Állománytáblákból_Illetmények.BesorolásHavi) Is Not Null))
GROUP BY tBesorolás_átalakító.Sorrend, lk_Állománytáblákból_Illetmények.BesorolásHavi;

#/#/#/
lkSávosBérStatisztika02a
#/#/
SELECT lkSávosBérStatisztika01.Sorrend, lkSorszámok.Sorszám, lkSávosBérStatisztika01.Bérmin, lkSávosBérStatisztika01.Bérmax, ([Bérmax]-[Bérmin])/10 AS Egység, [Bérmin]+(([Sorszám]-1)*([Bérmax]-[Bérmin])/10) AS Sávalj, [Bérmin]+([Sorszám]*([Bérmax]-[Bérmin])/10) AS Sávtető
FROM lkSávosBérStatisztika01, lkSorszámok
WHERE (((lkSorszámok.Sorszám)<11) AND ((([Bérmax]-[Bérmin])/10)<>0))
ORDER BY lkSávosBérStatisztika01.Sorrend, lkSorszámok.Sorszám;

#/#/#/
lkSávosBérStatisztika02b
#/#/
SELECT lkSávosBérStatisztika01.BesorolásHavi, lkSávosBérStatisztika01.Sorrend, lkSorszámok.Sorszám, lkSávosBérStatisztika01.Bérmin, lkSávosBérStatisztika01.Bérmax, ([Bérmax]-[Bérmin])/10 AS Egység, [Bérmin]+([Sorszám]*([Bérmax]-[Bérmin])/10) AS Sávtető
FROM lkSávosBérStatisztika01, lkSorszámok
WHERE (((lkSorszámok.Sorszám)<11) AND ((([Bérmax]-[Bérmin])/10)<>0))
ORDER BY lkSávosBérStatisztika01.BesorolásHavi, lkSávosBérStatisztika01.Sorrend, lkSorszámok.Sorszám;

#/#/#/
lkSávosBérStatisztika03a
#/#/
SELECT lkSávosBérStatisztika02a.Sorrend, lkSávosBérStatisztika02a.Sorszám, lk_Állománytáblákból_Illetmények.Adójel, lk_Állománytáblákból_Illetmények.[Álláshely azonosító], lk_Állománytáblákból_Illetmények.Név, lk_Állománytáblákból_Illetmények.Főosztály, lk_Állománytáblákból_Illetmények.Osztály, lk_Állománytáblákból_Illetmények.BesorolásHavi, [Illetmény]/[Heti munkaórák száma]*40 AS Bér, lk_Állománytáblákból_Illetmények.TávollétJogcíme, bfkh([Szervezetkód]) AS Bfkh
FROM lkSávosBérStatisztika02a INNER JOIN lk_Állománytáblákból_Illetmények ON (lkSávosBérStatisztika02a.Sávalj <= lk_Állománytáblákból_Illetmények.Illetmény) AND (lkSávosBérStatisztika02a.Sávtető >= lk_Állománytáblákból_Illetmények.Illetmény)
ORDER BY bfkh([Szervezetkód]);

#/#/#/
lkSofőrök
#/#/
SELECT lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.FEOR, lkSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker], lkSzemélyek.[Kerekített 100 %-os illetmény (eltérített)]
FROM lkSzemélyek
WHERE (((lkSzemélyek.FEOR)="8416 - Személygépkocsi-vezető") AND ((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Null)) OR (((lkSzemélyek.[Dolgozó teljes neve])="Kovács Tibor")) OR (((lkSzemélyek.[Dolgozó teljes neve])="Döbrei Lajos"));

#/#/#/
lkSorszámok
#/#/
SELECT ([Ten1].[N]+[Ten10].[N]*10+[Ten100].[N]*100)+1 AS Sorszám
FROM (SELECT DISTINCT Abs([id] Mod 10) AS N FROM MSysObjects)  AS Ten1, (SELECT DISTINCT Abs([id] Mod 10) AS N FROM MSysObjects)  AS Ten10, (SELECT DISTINCT Abs([id] Mod 10) AS N FROM MSysObjects)  AS Ten100;

#/#/#/
lkStatisztikaiLétszám
#/#/
SELECT lkLétszámokNevezetesNapokon01.KiemeltNapok, Sum(lkLétszámokNevezetesNapokon01.SumOfLétszám) AS SumOfSumOfLétszám
FROM lkLétszámokNevezetesNapokon01
GROUP BY lkLétszámokNevezetesNapokon01.KiemeltNapok;

#/#/#/
lkSzakterületiAdatszolgáltatáshoz
#/#/
SELECT tSzakterületSzervezet.[Szakterületi adatszolgáltatás], Sum(IIf([Születési év \ üres állás]="üres állás",0,1)) AS Betöltött, Sum(IIf([Születési év \ üres állás]="üres állás",1,0)) AS Üres, Sum(1) AS Összes
FROM tSzakterületSzervezet INNER JOIN lkJárásiKormányKözpontosítottUnió ON (tSzakterületSzervezet.Osztály = lkJárásiKormányKözpontosítottUnió.Osztály) AND (tSzakterületSzervezet.Főosztály = lkJárásiKormányKözpontosítottUnió.[Járási Hivatal])
GROUP BY tSzakterületSzervezet.[Szakterületi adatszolgáltatás];

#/#/#/
lkSzemélyek
#/#/
SELECT tSzemélyek.*, Replace(Nz(tSzemélyek.[Szint 8 szervezeti egység név],Nz(tSzemélyek.[Szint 6 szervezeti egység név],Nz(tSzemélyek.[Szint 5 szervezeti egység név],Nz(tSzemélyek.[Szint 7 szervezeti egység név],Nz(tSzemélyek.[Szint 4 szervezeti egység név],Nz(tSzemélyek.[Szint 3 szervezeti egység név],Nz(tSzemélyek.[Szint 2 szervezeti egység név],""))))))),"Budapest Főváros Kormányhivatala","BFKH") AS Főosztály, Replace(Nz(IIf(IsNull([tSzemélyek].[Szint 6 szervezeti egység kód]),IIf(IsNull([tSzemélyek].[Szint 5 szervezeti egység kód]),IIf(IsNull([tSzemélyek].[Szint 7 szervezeti egység kód]),IIf(IsNull([tSzemélyek].[Szint 4 szervezeti egység kód]),IIf(IsNull([tSzemélyek].[Szint 3 szervezeti egység kód]),[tSzemélyek].[Szint 2 szervezeti egység kód] & "",[tSzemélyek].[Szint 3 szervezeti egység kód] & ""),[tSzemélyek].[Szint 4 szervezeti egység kód] & ""),[tSzemélyek].[Szint 7 szervezeti egység kód] & ""),[tSzemélyek].[Szint 5 szervezeti egység kód] & ""),[tSzemélyek].[Szint 6 szervezeti egység kód] & ""),""),"Budapest Főváros Kormányhivatala ","BFKH ") AS FőosztályKód, IIf([főosztály]=[Szint 7 szervezeti egység név],"",[Szint 7 szervezeti egység név] & "") AS Osztály, Replace(Nz([Munkavégzés helye - cím],"")," .",".") AS MunkavégzésCíme, tSzemélyek.[besorolási  fokozat (KT)] AS Besorolás, Replace(Nz([tszemélyek].[Besorolási  fokozat (KT)],Nz([tBesorolásÁtalakítóEltérőBesoroláshoz].[Besorolási  fokozat (KT)],"")),"/ ","") AS Besorolás2, bfkh(Nz([szervezeti egység kódja],0)) AS BFKH, Replace([Feladatkör],"Lezárt_","") AS Feladat, Nz([Iskolai végzettség foka],"-") AS VégzettségFok, tSzemélyek.[Születési idő] AS SzületésiIdeje, lkÁlláshelyek.jel2, tSzemélyek.[Jogviszony vége (kilépés dátuma)] AS KilépésDátuma, Nz([tSzemélyek].[TAJ szám],0)*1 AS TAJ, [Törzsszám]*1 AS SzámTörzsSzám, bfkh(Replace(Nz(IIf(IsNull([tSzemélyek].[Szint 6 szervezeti egység kód]),IIf(IsNull([tSzemélyek].[Szint 5 szervezeti egység kód]),IIf(IsNull([tSzemélyek].[Szint 7 szervezeti egység kód]),IIf(IsNull([tSzemélyek].[Szint 4 szervezeti egység kód]),IIf(IsNull([tSzemélyek].[Szint 3 szervezeti egység kód]),[tSzemélyek].[Szint 2 szervezeti egység kód] & "",[tSzemélyek].[Szint 3 szervezeti egység kód] & ""),[tSzemélyek].[Szint 4 szervezeti egység kód] & ""),[tSzemélyek].[Szint 7 szervezeti egység kód] & ""),[tSzemélyek].[Szint 5 szervezeti egység kód] & ""),[tSzemélyek].[Szint 6 szervezeti egység kód] & ""),""),"Budapest Főváros Kormányhivatala ","BFKH ")) AS FőosztályBFKHKód
FROM (tSzemélyek LEFT JOIN lkÁlláshelyek ON tSzemélyek.[Státusz kódja] = lkÁlláshelyek.[Álláshely azonosító]) LEFT JOIN tBesorolásÁtalakítóEltérőBesoroláshoz ON lkÁlláshelyek.[Álláshely besorolási kategóriája] = tBesorolásÁtalakítóEltérőBesoroláshoz.[Álláshely besorolási kategóriája]
WHERE ((((SELECT Max(IIf(Tmp.[Jogviszony vége (kilépés dátuma)]=0,#01/01/3000#,Tmp.[Jogviszony vége (kilépés dátuma)])) AS [MaxOfJogviszony sorszáma]         FROM tSzemélyek as Tmp         WHERE tSzemélyek.Adójel=Tmp.Adójel         GROUP BY Tmp.Adójel     ))=IIf([Jogviszony vége (kilépés dátuma)]=0,#1/1/3000#,[Jogviszony vége (kilépés dátuma)])))
ORDER BY tSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkSzemélyekAdottNapon
#/#/
SELECT tSzemélyek.*, Replace(Nz(IIf(IsNull([tSzemélyek].[Szint 6 szervezeti egység név]),IIf(IsNull([tSzemélyek].[Szint 5 szervezeti egység név]),IIf(IsNull([tSzemélyek].[Szint 7 szervezeti egység név]),IIf(IsNull([tSzemélyek].[Szint 4 szervezeti egység név]),IIf(IsNull([tSzemélyek].[Szint 3 szervezeti egység név]),[tSzemélyek].[Szint 2 szervezeti egység név] & "",[tSzemélyek].[Szint 3 szervezeti egység név] & ""),[tSzemélyek].[Szint 4 szervezeti egység név] & ""),[tSzemélyek].[Szint 7 szervezeti egység név] & ""),[tSzemélyek].[Szint 5 szervezeti egység név] & ""),[tSzemélyek].[Szint 6 szervezeti egység név] & ""),""),"Budapest Főváros Kormányhivatala ","BFKH ") & "" AS Főosztály, Replace(Nz(IIf(IsNull([tSzemélyek].[Szint 6 szervezeti egység kód]),IIf(IsNull([tSzemélyek].[Szint 5 szervezeti egység kód]),IIf(IsNull([tSzemélyek].[Szint 7 szervezeti egység kód]),IIf(IsNull([tSzemélyek].[Szint 4 szervezeti egység kód]),IIf(IsNull([tSzemélyek].[Szint 3 szervezeti egység kód]),[tSzemélyek].[Szint 2 szervezeti egység kód] & "",[tSzemélyek].[Szint 3 szervezeti egység kód] & ""),[tSzemélyek].[Szint 4 szervezeti egység kód] & ""),[tSzemélyek].[Szint 7 szervezeti egység kód] & ""),[tSzemélyek].[Szint 5 szervezeti egység kód] & ""),[tSzemélyek].[Szint 6 szervezeti egység kód] & ""),""),"Budapest Főváros Kormányhivatala ","BFKH ") AS FőosztályKód, IIf([főosztály]=[Szint 7 szervezeti egység név],"",[Szint 7 szervezeti egység név] & "") AS Osztály, Replace(Nz([Munkavégzés helye - cím],"")," .",".") AS MunkavégzésCíme, tSzemélyek.[besorolási  fokozat (KT)] AS Besorolás, Replace(Nz([tszemélyek].[Besorolási  fokozat (KT)],Nz([tBesorolásÁtalakítóEltérőBesoroláshoz].[Besorolási  fokozat (KT)],"")),"/ ","") AS Besorolás2, bfkh(Nz([szervezeti egység kódja],0)) AS BFKH, Replace([Feladatkör],"Lezárt_","") AS Feladat, Nz([Iskolai végzettség foka],"-") AS VégzettségFok, tSzemélyek.[Születési idő] AS SzületésiIdeje, lkÁlláshelyek.jel2, dtátal([Jogviszony vége (kilépés dátuma)]) AS KilépésDátuma, Nz([tSzemélyek].[TAJ szám],0)*1 AS TAJ, [Törzsszám]*1 AS SzámTörzsSzám
FROM (tSzemélyek LEFT JOIN lkÁlláshelyek ON tSzemélyek.[Státusz kódja] = lkÁlláshelyek.[Álláshely azonosító]) LEFT JOIN tBesorolásÁtalakítóEltérőBesoroláshoz ON lkÁlláshelyek.[Álláshely besorolási kategóriája] = tBesorolásÁtalakítóEltérőBesoroláshoz.[Álláshely besorolási kategóriája]
WHERE (((dtátal([Jogviszony kezdete (belépés dátuma)]))<=dtátal(Nz([Keresett dátum],Date()))) AND ((dtátal(IIf(Nz([Jogviszony vége (kilépés dátuma)],0)=0,#1/1/3000#,[Jogviszony vége (kilépés dátuma)])))>=dtátal(Nz([Keresett dátum],Date()))))
ORDER BY tSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkSzemélyekÉsNexonAz
#/#/
SELECT lkSzemélyek.*, kt_azNexon_Adójel02.azNexon, kt_azNexon_Adójel02.NLink
FROM kt_azNexon_Adójel02 RIGHT JOIN lkSzemélyek ON kt_azNexon_Adójel02.Adójel=lkSzemélyek.Adójel;

#/#/#/
lkSzemélyekFőosztályOsztályLink
#/#/
SELECT lkSzemélyekÉsKilépőkUnió.Adójel, lkSzemélyekÉsKilépőkUnió.Főosztály, lkSzemélyekÉsKilépőkUnió.Osztály, "https://nexonport.kh.gov.hu/menu/hrm/szemelyiKarton/index?szemelyAzonosito=" & [azNexon] & "&r=13" AS NexonLink, kt_azNexon_Adójel02.Név
FROM (SELECT tSzemélyek.Adójel,  Replace(Nz(IIf(IsNull([tSzemélyek].[Szint 4 szervezeti egység név]),IIf(IsNull([tSzemélyek].[Szint 3 szervezeti egység név]),[tSzemélyek].[Szint 2 szervezeti egység név] & "",[tSzemélyek].[Szint 3 szervezeti egység név] & ""),[tSzemélyek].[Szint 4 szervezeti egység név] & ""),""),"Budapest Főváros Kormányhivatala ","BFKH ") AS Főosztály, tSzemélyek.[Szint 5 szervezeti egység név] AS Osztály FROM tSzemélyek WHERE (((tSzemélyek.[státusz neve])="Álláshely")) UNION SELECT  [Adóazonosító]*1 AS Adójel, IIf([Megyei szint VAGY Járási Hivatal]="megyei szint",[Mező5],[Megyei szint VAGY Járási Hivatal]) AS Főosztály, tKilépőkUnió.mező6 AS Osztály FROM   tKilépőkUnió UNION SELECT  [Adóazonosító]*1 AS Adójel, IIf([Megyei szint VAGY Járási Hivatal]="megyei szint",[Mező5],[Megyei szint VAGY Járási Hivatal]) AS Főosztály, lkKilépők.mező6 AS Osztály FROM   lkKilépők  )  AS lkSzemélyekÉsKilépőkUnió LEFT JOIN kt_azNexon_Adójel02 ON lkSzemélyekÉsKilépőkUnió.Adójel = kt_azNexon_Adójel02.Adójel;

#/#/#/
lkSzemélyekFőosztÉsÖsszesen
#/#/
SELECT UNIÓ.sor, UNIÓ.Főosztály, Sum(UNIÓ.FőosztályiLétszám) AS FőosztályiLétszám, UNIÓ.FőosztKód, Sum(UNIÓ.KözpontosítottLétszám) AS KözpontosítottLétszám
FROM (SELECT 1 AS sor, lkSzemélyek.Főosztály, Count(lkSzemélyek.Adójel) AS FőosztályiLétszám, Bfkh([lkSzemélyek].[FőosztályKód]) AS FőosztKód, 0 AS KözpontosítottLétszám
FROM lkSzemélyek
WHERE lkSzemélyek.[Státusz neve]="Álláshely" AND lkSzemélyek.[Státusz típusa] Like "Szervezeti alaplétszám"
GROUP BY lkSzemélyek.Főosztály, Bfkh([lkSzemélyek].[FőosztályKód]), lkSzemélyek.[Státusz neve], lkSzemélyek.[Státusz típusa]
UNION
SELECT 1 as sor, lkSzemélyek.Főosztály, 0 AS FőosztályiLétszám, Bfkh([lkSzemélyek].[FőosztályKód]) as FőosztKód, Count(lkSzemélyek.Adójel) as KözpontosítottLétszám
    FROM lkSzemélyek 
       WHERE lkSzemélyek.[Státusz neve]="Álláshely" AND lkSzemélyek.[Státusz típusa] Like "Központosított állomány"
       GROUP BY lkSzemélyek.Főosztály, lkSzemélyek.[Státusz neve], Bfkh([lkSzemélyek].[FőosztályKód])
  UNION SELECT 2 as sor, "Összesen:" as Főosztály, Count(lkSzemélyek.Adójel) AS CountOfAdójel , "BFKH.99" as FőosztKód, 0 AS KözpontosítottLétszám
    FROM lkSzemélyek 
       WHERE lkSzemélyek.[Státusz neve]="Álláshely" AND lkSzemélyek.[Státusz típusa] Like "Szervezeti alaplétszám"
       GROUP BY lkSzemélyek.[Státusz neve], "BFKH.99"
  UNION SELECT 2 as sor, "Összesen:" as Főosztály, 0 AS CountOfAdójel , "BFKH.99" as FőosztKód, Count(lkSzemélyek.Adójel) AS KözpontosítottLétszám
    FROM lkSzemélyek 
       WHERE lkSzemélyek.[Státusz neve]="Álláshely" AND lkSzemélyek.[Státusz típusa] Like "Központosított állomány"
       GROUP BY lkSzemélyek.[Státusz neve], "BFKH.99")  AS UNIÓ
GROUP BY UNIÓ.sor, UNIÓ.Főosztály, UNIÓ.FőosztKód
ORDER BY UNIÓ.sor;

#/#/#/
lkSzemélyekKITesekNemTTsekAdottNapon
#/#/
SELECT DISTINCT tSzemélyek.[Adóazonosító jel]
FROM tSzemélyek
WHERE (((tSzemélyek.[Jogviszony típusa / jogviszony típus])="kormányzati szolgálati jogviszony") AND ((tSzemélyek.[Jogviszony kezdete (belépés dátuma)])<=[dátum]) AND ((tSzemélyek.[Jogviszony vége (kilépés dátuma)])>=[dátum] Or (tSzemélyek.[Jogviszony vége (kilépés dátuma)])=0) AND ((dtátal([Tartós távollét kezdete]))>=dtátal([dátum]) Or (dtátal([Tartós távollét kezdete]))=0)) OR (((tSzemélyek.[Jogviszony típusa / jogviszony típus])="kormányzati szolgálati jogviszony") AND ((tSzemélyek.[Jogviszony kezdete (belépés dátuma)])<=[dátum]) AND ((tSzemélyek.[Jogviszony vége (kilépés dátuma)])>=[dátum] Or (tSzemélyek.[Jogviszony vége (kilépés dátuma)])=0) AND ((dtátal([Tartós távollét vége])) Between 1 And dtátal([dátum])));

#/#/#/
lkSzemélyekMind
#/#/
SELECT tSzemélyek.Azonosító, tSzemélyek.Adójel, tSzemélyek.[Dolgozó teljes neve], tSzemélyek.[Dolgozó születési neve], tSzemélyek.[Születési idő], tSzemélyek.[Születési hely], tSzemélyek.[Anyja neve], tSzemélyek.Neme, tSzemélyek.Törzsszám, tSzemélyek.[Egyedi azonosító], tSzemélyek.[Adóazonosító jel], tSzemélyek.[TAJ szám], tSzemélyek.[Ügyfélkapu kód], tSzemélyek.[Elsődleges állampolgárság], tSzemélyek.[Személyi igazolvány száma], tSzemélyek.[Személyi igazolvány érvényesség kezdete], tSzemélyek.[Személyi igazolvány érvényesség vége], tSzemélyek.[Nyelvtudás Angol], tSzemélyek.[Nyelvtudás Arab], tSzemélyek.[Nyelvtudás Bolgár], tSzemélyek.[Nyelvtudás Cigány], tSzemélyek.[Nyelvtudás Cigány (lovári)], tSzemélyek.[Nyelvtudás Cseh], tSzemélyek.[Nyelvtudás Eszperantó], tSzemélyek.[Nyelvtudás Finn], tSzemélyek.[Nyelvtudás Francia], tSzemélyek.[Nyelvtudás Héber], tSzemélyek.[Nyelvtudás Holland], tSzemélyek.[Nyelvtudás Horvát], tSzemélyek.[Nyelvtudás Japán], tSzemélyek.[Nyelvtudás Jelnyelv], tSzemélyek.[Nyelvtudás Kínai], tSzemélyek.[Nyelvtudás Latin], tSzemélyek.[Nyelvtudás Lengyel], tSzemélyek.[Nyelvtudás Német], tSzemélyek.[Nyelvtudás Norvég], tSzemélyek.[Nyelvtudás Olasz], tSzemélyek.[Nyelvtudás Orosz], tSzemélyek.[Nyelvtudás Portugál], tSzemélyek.[Nyelvtudás Román], tSzemélyek.[Nyelvtudás Spanyol], tSzemélyek.[Nyelvtudás Szerb], tSzemélyek.[Nyelvtudás Szlovák], tSzemélyek.[Nyelvtudás Szlovén], tSzemélyek.[Nyelvtudás Török], tSzemélyek.[Nyelvtudás Újgörög], tSzemélyek.[Nyelvtudás Ukrán], tSzemélyek.[Orvosi vizsgálat időpontja], tSzemélyek.[Orvosi vizsgálat típusa], tSzemélyek.[Orvosi vizsgálat eredménye], tSzemélyek.[Orvosi vizsgálat észrevételek], tSzemélyek.[Orvosi vizsgálat következő időpontja], tSzemélyek.[Erkölcsi bizonyítvány száma], tSzemélyek.[Erkölcsi bizonyítvány dátuma], tSzemélyek.[Erkölcsi bizonyítvány eredménye], tSzemélyek.[Erkölcsi bizonyítvány kérelem azonosító], tSzemélyek.[Erkölcsi bizonyítvány közügyektől eltiltva], tSzemélyek.[Erkölcsi bizonyítvány járművezetéstől eltiltva], tSzemélyek.[Erkölcsi bizonyítvány intézkedés alatt áll], tSzemélyek.[Munkaköri leírások (csatolt dokumentumok fájlnevei)], tSzemélyek.[Egyéb HR dokumentumok (csatolt dokumentumok fájlnevei)], tSzemélyek.[Kormányhivatal rövid neve], tSzemélyek.[Szervezeti egység kódja], tSzemélyek.[Szervezeti egység neve], tSzemélyek.[Szervezeti munkakör neve], tSzemélyek.[Vezetői megbízás típusa], tSzemélyek.[Státusz kódja], tSzemélyek.[Státusz költséghelyének kódja], tSzemélyek.[Státusz költséghelyének neve ], tSzemélyek.[Létszámon felül létrehozott státusz], tSzemélyek.[Státusz típusa], tSzemélyek.[Státusz neve], tSzemélyek.[Többes betöltés], tSzemélyek.[Vezető neve], tSzemélyek.[Vezető adóazonosító jele], tSzemélyek.[Vezető email címe], tSzemélyek.[Állandó lakcím], tSzemélyek.[Tartózkodási lakcím], tSzemélyek.[Levelezési cím_], tSzemélyek.[Öregségi nyugdíj-korhatár elérésének időpontja (dátum)], tSzemélyek.Nyugdíjas, tSzemélyek.[Nyugdíj típusa], tSzemélyek.[Nyugdíjas korú továbbfoglalkoztatási engedéllyel rendelkezik], tSzemélyek.[Megváltozott munkaképesség], tSzemélyek.[Önkéntes tartalékos katona], tSzemélyek.[Utolsó vagyonnyilatkozat leadásának dátuma], tSzemélyek.[Vagyonnyilatkozat nyilvántartási száma], tSzemélyek.[Következő vagyonnyilatkozat esedékessége], tSzemélyek.[Nemzetbiztonsági ellenőrzés dátuma], tSzemélyek.[Védett állományba tartozó munkakör], tSzemélyek.[Vezetői megbízás típusa1], tSzemélyek.[Vezetői beosztás megnevezése], tSzemélyek.[Vezetői beosztás (megbízás) kezdete], tSzemélyek.[Vezetői beosztás (megbízás) vége], tSzemélyek.[Iskolai végzettség foka], tSzemélyek.[Iskolai végzettség neve], tSzemélyek.[Alapvizsga kötelezés dátuma], tSzemélyek.[Alapvizsga letétel tényleges határideje], tSzemélyek.[Alapvizsga mentesség], tSzemélyek.[Alapvizsga mentesség oka], tSzemélyek.[Szakvizsga kötelezés dátuma], tSzemélyek.[Szakvizsga letétel tényleges határideje], tSzemélyek.[Szakvizsga mentesség], tSzemélyek.[Foglalkozási viszony], tSzemélyek.[Foglalkozási viszony statisztikai besorolása], tSzemélyek.[Dolgozó szerződéses/kinevezéses munkaköre / kinevezési okmányban], tSzemélyek.[Beosztástervezés helyszínek], tSzemélyek.[Beosztástervezés tevékenységek], tSzemélyek.[Részleges távmunka szerződés kezdete], tSzemélyek.[Részleges távmunka szerződés vége], tSzemélyek.[Részleges távmunka szerződés intervalluma], tSzemélyek.[Részleges távmunka szerződés mértéke], tSzemélyek.[Részleges távmunka szerződés helyszíne], tSzemélyek.[Részleges távmunka szerződés helyszíne 2], tSzemélyek.[Részleges távmunka szerződés helyszíne 3], tSzemélyek.[Egyéni túlóra keret megállapodás kezdete], tSzemélyek.[Egyéni túlóra keret megállapodás vége], tSzemélyek.[Egyéni túlóra keret megállapodás mértéke], tSzemélyek.[KIRA feladat azonosítója - intézmény prefix-szel ellátva], tSzemélyek.[KIRA feladat azonosítója], tSzemélyek.[KIRA feladat megnevezés], tSzemélyek.[Osztott munkakör], tSzemélyek.[Funkciócsoport: kód-megnevezés], tSzemélyek.[Funkció: kód-megnevezés], tSzemélyek.[Dolgozó költséghelyének kódja], tSzemélyek.[Dolgozó költséghelyének neve], tSzemélyek.Feladatkör, tSzemélyek.[Elsődleges feladatkör], tSzemélyek.Feladatok, tSzemélyek.FEOR, tSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó napi óraker], tSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker], tSzemélyek.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó havi óraker], tSzemélyek.[Szerződés/Kinevezés típusa], tSzemélyek.Iktatószám, tSzemélyek.[Szerződés/kinevezés verzió_érvényesség kezdete], tSzemélyek.[Szerződés/kinevezés verzió_érvényesség vége], tSzemélyek.[Határozott idejű _szerződés/kinevezés lejár], tSzemélyek.[Szerződés dokumentum (csatolt dokumentumok fájlnevei)], tSzemélyek.[Megjegyzés (pl# határozott szerződés/kinevezés oka)], tSzemélyek.[Munkavégzés helye - megnevezés], tSzemélyek.[Munkavégzés helye - cím], tSzemélyek.[Jogviszony típusa / jogviszony típus], tSzemélyek.[Jogviszony sorszáma], tSzemélyek.[KIRA jogviszony jelleg], tSzemélyek.[Kölcsönbe adó cég], tSzemélyek.[Teljesítményértékelés - Értékelő személy], tSzemélyek.[Teljesítményértékelés - Érvényesség kezdet], tSzemélyek.[Teljesítményértékelés - Értékelt időszak kezdet], tSzemélyek.[Teljesítményértékelés - Értékelt időszak vége], tSzemélyek.[Teljesítményértékelés dátuma], tSzemélyek.[Teljesítményértékelés - Beállási százalék], tSzemélyek.[Teljesítményértékelés - Pontszám], tSzemélyek.[Teljesítményértékelés - Megjegyzés], tSzemélyek.[Dolgozói jellemzők], tSzemélyek.[Fizetési osztály (KA)/ Pedagógusi fokozat (KA pedagógus)/besorol], tSzemélyek.[Besorolási  fokozat (KT)], tSzemélyek.[Jogfolytonos idő kezdete], tSzemélyek.[Jogviszony kezdete (belépés dátuma)], tSzemélyek.[Jogviszony vége (kilépés dátuma)], dtÁtal([Jogviszony vége (kilépés dátuma)]) AS JogviszonyVége, tSzemélyek.[Utolsó munkában töltött nap], tSzemélyek.[Kezdeményezés dátuma], tSzemélyek.[Hatályossá válik], tSzemélyek.[HR kapcsolat megszűnés módja (Kilépés módja)], tSzemélyek.[HR kapcsolat megszűnes indoka (Kilépés indoka)], tSzemélyek.Indokolás, tSzemélyek.[Következő munkahely], tSzemélyek.[MT: Felmondási idő kezdete KJT, KTTV: Felmentési idő kezdete], tSzemélyek.[Felmondási idő vége (MT) Felmentési idő vége (KJT, KTTV)], tSzemélyek.[Munkavégzés alóli mentesítés kezdete (KJT, KTTV) Felmentési idő ], tSzemélyek.[Munkavégzés alóli mentesítés vége (KJT, KTTV) Felmentési idő vég], tSzemélyek.[Tartós távollét típusa], tSzemélyek.[Tartós távollét kezdete], tSzemélyek.[Tartós távollét vége], tSzemélyek.[Tartós távollét tervezett vége], tSzemélyek.[Helyettesített dolgozó neve], tSzemélyek.[Szerződés/Kinevezés - próbaidő vége], tSzemélyek.[Utalási cím], tSzemélyek.[Alapilletmény / Munkabér / Megbízási díj (eltérítés nélküli)], tSzemélyek.[Garantált bérminimumra történő kiegészítés], tSzemélyek.Kerekítés, tSzemélyek.[Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS % (eltérít], tSzemélyek.[Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS összeg (el], tSzemélyek.[Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY % (eltérítés nélküli)], tSzemélyek.[Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY összeg (eltérítés nél], tSzemélyek.[Egyéb pótlék - összeg (eltérítés nélküli)], tSzemélyek.[Illetmény összesen kerekítés nélkül (eltérítés nélküli)], tSzemélyek.[Kerekített 100 %-os illetmény (eltérítés nélküli)], tSzemélyek.[Eltérítés %], tSzemélyek.[Alapilletmény / Munkabér / Megbízási díj (eltérített)], tSzemélyek.[Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS % (eltérí1], tSzemélyek.[Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS összeg (e1], tSzemélyek.[Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY % (eltérített)], tSzemélyek.[Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY összeg (eltérített)], tSzemélyek.[Egyéb pótlék - összeg (eltérített)], tSzemélyek.[Illetmény összesen kerekítés nélkül (eltérített)], tSzemélyek.[Kerekített 100 %-os illetmény (eltérített)], tSzemélyek.[További munkavégzés helye 1 Teljes munkaidő %-a], tSzemélyek.[További munkavégzés helye 2 Teljes munkaidő %-a], tSzemélyek.[KT: Kerekített 100 %-os illetmény (eltérített) + Helyettesítési ], tSzemélyek.[Szint 1 szervezeti egység név], tSzemélyek.[Szint 1 szervezeti egység kód], tSzemélyek.[Szint 2 szervezeti egység név], tSzemélyek.[Szint 2 szervezeti egység kód], tSzemélyek.[Szint 3 szervezeti egység név], tSzemélyek.[Szint 3 szervezeti egység kód], tSzemélyek.[Szint 6 szervezeti egység név], tSzemélyek.[Szint 6 szervezeti egység kód], tSzemélyek.[Szint 7 szervezeti egység név], tSzemélyek.[Szint 7 szervezeti egység kód], tSzemélyek.[AD egyedi azonosító], tSzemélyek.[Hivatali email], tSzemélyek.[Hivatali mobil], tSzemélyek.[Hivatali telefon], tSzemélyek.[Hivatali telefon mellék], tSzemélyek.Iroda, tSzemélyek.[Otthoni e-mail], tSzemélyek.[Otthoni mobil], tSzemélyek.[Otthoni telefon], tSzemélyek.[További otthoni mobil], Replace(Nz(IIf(IsNull([tSzemélyek].[Szint 6 szervezeti egység név]),IIf(IsNull([tSzemélyek].[Szint 5 szervezeti egység név]),IIf(IsNull([tSzemélyek].[Szint 7 szervezeti egység név]),IIf(IsNull([tSzemélyek].[Szint 4 szervezeti egység név]),IIf(IsNull([tSzemélyek].[Szint 3 szervezeti egység név]),[tSzemélyek].[Szint 2 szervezeti egység név] & "",[tSzemélyek].[Szint 3 szervezeti egység név] & ""),[tSzemélyek].[Szint 4 szervezeti egység név] & ""),[tSzemélyek].[Szint 7 szervezeti egység név] & ""),[tSzemélyek].[Szint 5 szervezeti egység név] & ""),[tSzemélyek].[Szint 6 szervezeti egység név] & ""),""),"Budapest Főváros Kormányhivatala ","BFKH ") & "" AS Főosztály, IIf([főosztály]=[Szint 7 szervezeti egység név],"",[Szint 7 szervezeti egység név] & "") AS Osztály
FROM tSzemélyek;

#/#/#/
lkSzemélyekNemMegbízásÉsNemSzemélyesJelenlét
#/#/
SELECT tSzemélyek.*, Replace(Nz(IIf(IsNull([tSzemélyek].[Szint 6 szervezeti egység név]),IIf(IsNull([tSzemélyek].[Szint 5 szervezeti egység név]),IIf(IsNull([tSzemélyek].[Szint 7 szervezeti egység név]),IIf(IsNull([tSzemélyek].[Szint 4 szervezeti egység név]),IIf(IsNull([tSzemélyek].[Szint 3 szervezeti egység név]),[tSzemélyek].[Szint 2 szervezeti egység név] & "",[tSzemélyek].[Szint 3 szervezeti egység név] & ""),[tSzemélyek].[Szint 4 szervezeti egység név] & ""),[tSzemélyek].[Szint 7 szervezeti egység név] & ""),[tSzemélyek].[Szint 5 szervezeti egység név] & ""),[tSzemélyek].[Szint 6 szervezeti egység név] & ""),""),"Budapest Főváros Kormányhivatala ","BFKH ") & "" AS Főosztály, Replace(Nz(IIf(IsNull([tSzemélyek].[Szint 6 szervezeti egység kód]),IIf(IsNull([tSzemélyek].[Szint 5 szervezeti egység kód]),IIf(IsNull([tSzemélyek].[Szint 7 szervezeti egység kód]),IIf(IsNull([tSzemélyek].[Szint 4 szervezeti egység kód]),IIf(IsNull([tSzemélyek].[Szint 3 szervezeti egység kód]),[tSzemélyek].[Szint 2 szervezeti egység kód] & "",[tSzemélyek].[Szint 3 szervezeti egység kód] & ""),[tSzemélyek].[Szint 4 szervezeti egység kód] & ""),[tSzemélyek].[Szint 7 szervezeti egység kód] & ""),[tSzemélyek].[Szint 5 szervezeti egység kód] & ""),[tSzemélyek].[Szint 6 szervezeti egység kód] & ""),""),"Budapest Főváros Kormányhivatala ","BFKH ") AS FőosztályKód, IIf([főosztály]=[Szint 7 szervezeti egység név],"",[Szint 7 szervezeti egység név] & "") AS Osztály, Replace(Nz([Munkavégzés helye - cím],"")," .",".") AS MunkavégzésCíme, tSzemélyek.[besorolási  fokozat (KT)] AS Besorolás, Replace(Nz([tszemélyek].[Besorolási  fokozat (KT)],Nz([tBesorolásÁtalakítóEltérőBesoroláshoz].[Besorolási  fokozat (KT)],"")),"/ ","") AS Besorolás2, bfkh(Nz([szervezeti egység kódja],0)) AS BFKH, Replace([Feladatkör],"Lezárt_","") AS Feladat, Nz([Iskolai végzettség foka],"-") AS VégzettségFok, tSzemélyek.[Születési idő] AS SzületésiIdeje, lkÁlláshelyek.jel2, dtátal([Jogviszony vége (kilépés dátuma)]) AS KilépésDátuma, Nz([tSzemélyek].[TAJ szám],0)*1 AS TAJ, [Törzsszám]*1 AS SzámTörzsSzám
FROM (tSzemélyek LEFT JOIN lkÁlláshelyek ON tSzemélyek.[Státusz kódja] = lkÁlláshelyek.[Álláshely azonosító]) LEFT JOIN tBesorolásÁtalakítóEltérőBesoroláshoz ON lkÁlláshelyek.[Álláshely besorolási kategóriája] = tBesorolásÁtalakítóEltérőBesoroláshoz.[Álláshely besorolási kategóriája]
WHERE ((((SELECT Max(iif(Nz(Tmp.[Jogviszony vége (kilépés dátuma)],0)=0,#01/01/3000#,Tmp.[Jogviszony vége (kilépés dátuma)])) AS [MaxOfJogviszony sorszáma]   FROM tSzemélyek as Tmp         WHERE tSzemélyek.Adójel=Tmp.Adójel AND
[Jogviszony típusa / jogviszony típus]<>"megbízásos"
AND
[Jogviszony típusa / jogviszony típus]<>"személyes jelenlét"
GROUP BY Tmp.Adójel  ))=IIf(Nz([Jogviszony vége (kilépés dátuma)],0)=0,#1/1/3000#,[Jogviszony vége (kilépés dátuma)])))
ORDER BY tSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkSzemélyekVégzettségeinekSzáma
#/#/
SELECT lkVégzettségek.Adójel, Count(lkVégzettségek.Azonosító) AS VégzettségeinekASzáma
FROM lkVégzettségek
GROUP BY lkVégzettségek.Adójel;

#/#/#/
lkSzemélykereső
#/#/
SELECT tSzemélyek.[Dolgozó teljes neve], Replace(Nz(IIf(IsNull([tSzemélyek].[Szint 6 szervezeti egység név]),IIf(IsNull([tSzemélyek].[Szint 5 szervezeti egység név]),IIf(IsNull([tSzemélyek].[Szint 7 szervezeti egység név]),IIf(IsNull([tSzemélyek].[Szint 4 szervezeti egység név]),IIf(IsNull([tSzemélyek].[Szint 3 szervezeti egység név]),[tSzemélyek].[Szint 2 szervezeti egység név] & "",[tSzemélyek].[Szint 3 szervezeti egység név] & ""),[tSzemélyek].[Szint 4 szervezeti egység név] & ""),[tSzemélyek].[Szint 7 szervezeti egység név] & ""),[tSzemélyek].[Szint 5 szervezeti egység név] & ""),[tSzemélyek].[Szint 6 szervezeti egység név] & ""),""),"Budapest Főváros Kormányhivatala ","BFKH ") & "" AS Főosztály, IIf([főosztály]=[Szint 7 szervezeti egység név],"",[Szint 7 szervezeti egység név] & "") AS Osztály, tSzemélyek.[Születési idő], tSzemélyek.[Születési hely], tSzemélyek.[Anyja neve], tSzemélyek.[Státusz kódja], tSzemélyek.[Státusz neve], tSzemélyek.[KIRA jogviszony jelleg], tSzemélyek.[Besorolási  fokozat (KT)], tSzemélyek.[Kerekített 100 %-os illetmény (eltérített)], tSzemélyek.[Iskolai végzettség foka], tSzemélyek.[Iskolai végzettség neve], tSzemélyek.[Jogviszony sorszáma], tSzemélyek.Azonosító, kt_azNexon_Adójel02.azNexon, kt_azNexon_Adójel02.NLink, tSzemélyek.Adójel, tSzemélyek.[KIRA feladat megnevezés]
FROM kt_azNexon_Adójel02 RIGHT JOIN tSzemélyek ON kt_azNexon_Adójel02.Adójel = tSzemélyek.Adójel
WHERE (((tSzemélyek.[Dolgozó teljes neve]) Like "*" & Űrlapok!űSzemélykereső!Kereső & "*") And ((tSzemélyek.[Státusz neve]) Like IIf(Űrlapok!űSzemélykereső!Álláshelyen,"Álláshely","*") Or (tSzemélyek.[Státusz neve]) Like IIf(Űrlapok!űSzemélykereső!Álláshelyen,"Álláshely",Null)));

#/#/#/
lkSzemélyTelephelyek
#/#/
SELECT lkSzemélyek.Adójel, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Munkavégzés helye - cím], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Tartós távollét típusa] AS [Tartós távollét jogcíme], lkSzemélyek.[Jogviszony vége (kilépés dátuma)] AS [Kilépés dátuma], lkSzemélyek.BFKH, lkSzemélyek.[Munkavégzés helye - cím] AS TelephelyCíme
FROM lkSzemélyek
WHERE (((lkSzemélyek.BFKH) Is Not Null) AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY lkSzemélyek.BFKH, lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkSzemélyUtolsóSzervezetiEgysége
#/#/
SELECT lkSzemélyekNemMegbízásÉsNemSzemélyesJelenlét.Adójel, lkSzemélyekNemMegbízásÉsNemSzemélyesJelenlét.KilépésDátuma, IIf([lkSzemélyekNemMegbízásÉsNemSzemélyesJelenlét].[főosztály]="" Or [lkSzemélyekNemMegbízásÉsNemSzemélyesJelenlét].[főosztály] Is Null,IIf([lkKilépőUnió].[főosztály]="","-",[lkKilépőUnió].[főosztály]),[lkSzemélyekNemMegbízásÉsNemSzemélyesJelenlét].[főosztály]) AS Főosztály, IIf([lkSzemélyekNemMegbízásÉsNemSzemélyesJelenlét].[osztály]="",IIf([lkKilépőUnió].[osztály]="","-",[lkKilépőUnió].[osztály]),[lkSzemélyekNemMegbízásÉsNemSzemélyesJelenlét].[osztály]) AS Osztály, IIf([lkSzemélyekNemMegbízásÉsNemSzemélyesJelenlét].[főosztálykód]="",[ányr szervezeti egység azonosító],[lkSzemélyekNemMegbízásÉsNemSzemélyesJelenlét].[főosztálykód]) AS FőosztályKód, IIf([Státusz kódja] Is Null,[Álláshely azonosító],[Státusz kódja]) AS ÁNYR, Nz([Státusz típusa],IIf(Nz([Alaplétszám],"A")="A","Szervezeti alaplétszám","Központosított állomány")) AS Jelleg
FROM lkSzemélyekNemMegbízásÉsNemSzemélyesJelenlét LEFT JOIN lkKilépőUnió ON (lkSzemélyekNemMegbízásÉsNemSzemélyesJelenlét.[Jogviszony vége (kilépés dátuma)] = lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja]) AND (lkSzemélyekNemMegbízásÉsNemSzemélyesJelenlét.Adójel = lkKilépőUnió.Adójel)
ORDER BY lkSzemélyekNemMegbízásÉsNemSzemélyesJelenlét.KilépésDátuma;

#/#/#/
lkSzervezetÁlláshelyek
#/#/
SELECT DISTINCT tSzervezet.OSZLOPOK, tSzervezet.[Szervezetmenedzsment kód] AS Álláshely, Choose([tSzervezet]![Szervezeti egységének szintje],[tSzervezet]![Szint1 - kód],[tSzervezet]![Szint2 - kód],[tSzervezet]![Szint3 - kód],[tSzervezet]![Szint4 - kód],[tSzervezet]![Szint5 - kód],[tSzervezet]![Szint6 - kód],[tSzervezet]![Szint7 - kód],[tSzervezet]![Szint8 - kód]) AS SzervezetKód, IIf(InStr(1,[OSZLOPOK],"betöltött")>0,True,False) AS Betöltött, tSzervezet.[Vezetői státusz], tSzervezet.[Státusz típusa], tSzervezet.[Státusz betöltési óraszáma], tSzervezet.[Státusz betöltési FTE], tSzervezet.[Tervezett betöltési adatok - Előmeneteli fokozat megnevezés], tSzervezet.[Érvényesség kezdete], tSzervezet.[Érvényesség vége], tSzervezet.[Szint3 - leírás], tSzervezet.[Szint4 - leírás], tSzervezet.[Szint5 - leírás], tSzervezet.[Szint6 - leírás], tSzervezet.[Szint7 - leírás]
FROM tSzervezet
WHERE (((tSzervezet.OSZLOPOK) Like "Státusz (*") AND ((tSzervezet.[Szervezetmenedzsment kód]) Like "S-*"));

#/#/#/
lkSzervezetekSzemélyekből
#/#/
SELECT DISTINCT bfkh(Nz([Szervezeti egység kódja],1)) AS bfkh, lkSzemélyek.[Szervezeti egység kódja], lkSzemélyek.Főosztály, lkSzemélyek.Osztály
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null))
ORDER BY bfkh(Nz([Szervezeti egység kódja],1));

#/#/#/
lkSzervezetenkénti létszámadatok01
#/#/
SELECT lkHaviLétszám.BFKHKód, lkHaviLétszám.Főosztály, lkHaviLétszám.Osztály, lkHaviLétszám.[Betöltött létszám], [TT]*-1 AS TTLétszám, 0 AS HatározottLétszám, 0 AS Korr
FROM lkHaviLétszám
WHERE ((([lkHaviLétszám].[jelleg])="A"))
GROUP BY lkHaviLétszám.BFKHKód, lkHaviLétszám.Főosztály, lkHaviLétszám.Osztály, lkHaviLétszám.[Betöltött létszám], [TT]*-1;

#/#/#/
lkSzervezetenkénti létszámadatok02
#/#/
SELECT AlaplétszámUnió.BFKHKód, AlaplétszámUnió.Főosztály, AlaplétszámUnió.Osztály, Sum(AlaplétszámUnió.[Betöltött létszám]) AS [SumOfBetöltött létszám], Sum(AlaplétszámUnió.TTLétszám) AS SumOfTTLétszám, Sum(AlaplétszámUnió.HatározottLétszám) AS SumOfHatározottLétszám, Sum(AlaplétszámUnió.Korr) AS SumOfKorr
FROM (SELECT [lkSzervezetenkénti létszámadatok01].*
FROM [lkSzervezetenkénti létszámadatok01]

UNION
SELECT lkHatározottak_TTH_OsztályonkéntiLétszám.*
FROM   lkHatározottak_TTH_OsztályonkéntiLétszám)  AS AlaplétszámUnió
GROUP BY AlaplétszámUnió.BFKHKód, AlaplétszámUnió.Főosztály, AlaplétszámUnió.Osztály;

#/#/#/
lkSzervezetenkéntiLétszámadatok03
#/#/
SELECT [lkSzervezetenkénti létszámadatok02].Főosztály, [lkSzervezetenkénti létszámadatok02].Osztály, [SumofBetöltött létszám]+[SumofTTLétszám]+[SumofHatározottLétszám]+[SumofKorr] AS Létszám
FROM [lkSzervezetenkénti létszámadatok02]
ORDER BY bfkh([BFKHKód]);

#/#/#/
lkSzervezetiÁlláshelyek
#/#/
SELECT tSzervezeti.OSZLOPOK, bfkh(Nz([tSzervezeti].[Szülő szervezeti egységének kódja],"")) AS SzervezetKód, tSzervezeti.[Szülő szervezeti egységének kódja], tSzervezeti.[Szervezetmenedzsment kód] AS ÁlláshelyAzonosító, IIf([Szervezeti egységének szintje]=7 And [Szint3 - kód]="",[Szülő szervezeti egységének kódja],IIf([Szint6 - kód]="",IIf([Szint5 - kód]="",IIf([Szint4 - kód]="",IIf([Szint3 - kód]="",[Szint2 - kód],[Szint3 - kód]),[Szint4 - kód]),[Szint5 - kód]),[Szint6 - kód])) AS FőosztályKód, tSzervezeti.[Megnevezés szótárelem kódja], tSzervezeti.Név, tSzervezeti.[Érvényesség kezdete], tSzervezeti.[Érvényesség vége], tSzervezeti.[Költséghely kód], tSzervezeti.[Költséghely megnevezés], tSzervezeti.[Szervezeti egységének szintje], tSzervezeti.[Szülő szervezeti egységének kódja], tSzervezeti.[Szervezeti egységének megnevezése], tSzervezeti.[Szervezeti egységének vezetője], tSzervezeti.[Szervezeti egységének vezetőjének azonosítója], tSzervezeti.[A költséghely eltér a szervezeti egységének költséghelytől?], tSzervezeti.[Szervezeti munkakörének kódja], tSzervezeti.[Szervezeti munkakörének megnevezése], tSzervezeti.[A költséghely eltér a szervezeti munkakörének költséghelyétől?], tSzervezeti.[Vezetői státusz], tSzervezeti.[Helyettes vezető-e], tSzervezeti.[Tervezett betöltési adatok - Jogviszony típus], tSzervezeti.[Tervezett betöltési adatok - Kulcsszám kód], tSzervezeti.[Tervezett betöltési adatok - Kulcsszám megnevezés], tSzervezeti.[Tervezett betöltési adatok - Előmeneteli fokozat kód], tSzervezeti.[Tervezett betöltési adatok - Előmeneteli fokozat megnevezés], tSzervezeti.[Pályáztatás határideje], tSzervezeti.[Vezetői beosztás KT], tSzervezeti.[Pályáztatás alatt áll], tSzervezeti.Megjegyzés, tSzervezeti.[Státusz engedélyezett óraszáma], tSzervezeti.[Státusz engedélyezett FTE (üzleti paraméter szerint számolva)], tSzervezeti.[Átmeneti óraszám], tSzervezeti.[Átmeneti létszám (FTE)], tSzervezeti.[Közzétett hierarchiában megjelenítendő], tSzervezeti.[Asszisztens státusz], tSzervezeti.[Létszámon felül létrehozott státusz], tSzervezeti.[Státusz típusa], tSzervezeti.[Státusz betöltési óraszáma], tSzervezeti.[Státusz betöltési FTE], tSzervezeti.[Státusz betöltési óraszáma minusz státusz engedélyezett óraszáma], tSzervezeti.[Státusz betöltési FTE minusz státusz engedélyezett FTE], tSzervezeti.[Mióta betöltetlen a státusz (dátum)], tSzervezeti.[Hány napja betöltetlen (munkanap, alapnaptár alapján)], tSzervezeti.[Szint1 - kód], tSzervezeti.[Szint1 - leírás], tSzervezeti.[Szint2 - kód], tSzervezeti.[Szint2 - leírás], tSzervezeti.[Szint3 - kód], tSzervezeti.[Szint3 - leírás], tSzervezeti.[Szint4 - kód], tSzervezeti.[Szint4 - leírás], tSzervezeti.[Szint5 - kód], tSzervezeti.[Szint5 - leírás], tSzervezeti.[Szint6 - kód], tSzervezeti.[Szint6 - leírás], tSzervezeti.[Szint7 - kód], tSzervezeti.[Szint7 - leírás], tSzervezeti.[Szint8 - kód], tSzervezeti.[Szint8 - leírás], Replace(Choose(IIf([Szervezeti egységének szintje]>6,IIf([tSzervezeti].[Szint6 - leírás]="",5,6),[Szervezeti egységének szintje]),[tSzervezeti].[Szint1 - leírás],[tSzervezeti].[Szint2 - leírás],[tSzervezeti].[Szint3 - leírás],[tSzervezeti].[Szint4 - leírás],[tSzervezeti].[Szint5 - leírás],[tSzervezeti].[Szint6 - leírás]) & IIf([tSzervezeti].[Szint7 - kód]="BFKH.1.7.",[tSzervezeti].[Szint7 - leírás],""),"Budapest Főváros Kormányhivatala","BFKH") AS Főosztály, IIf([tSzervezeti].[Szint7 - kód]="BFKH.1.7.","",[tSzervezeti].[Szint7 - leírás]) AS Osztály
FROM tSzervezeti
WHERE (((tSzervezeti.[Szervezetmenedzsment kód]) Like "S-*") AND ((tSzervezeti.[Érvényesség kezdete])<=Date()) AND ((tSzervezeti.[Érvényesség vége])>=Date() Or (tSzervezeti.[Érvényesség vége])=0));

#/#/#/
lkSzervezetiÁlláshelyek - azonosak keresése
#/#/
SELECT First(lkSzervezetiÁlláshelyek.ÁlláshelyAzonosító) AS [ÁlláshelyAzonosító Mező], Count(lkSzervezetiÁlláshelyek.ÁlláshelyAzonosító) AS AzonosakSzáma
FROM lkSzervezetiÁlláshelyek
GROUP BY lkSzervezetiÁlláshelyek.ÁlláshelyAzonosító
HAVING (((Count(lkSzervezetiÁlláshelyek.ÁlláshelyAzonosító))>1));

#/#/#/
lkSzervezetiBetöltések
#/#/
SELECT tSzervezeti.OSZLOPOK, tSzervezeti.[Szervezetmenedzsment kód], IIf([Szervezeti egységének szintje]=7 And [Szint3 - kód]="",[Szülő szervezeti egységének kódja],IIf([Szint6 - kód]="",IIf([Szint5 - kód]="",IIf([Szint4 - kód]="",IIf([Szint3 - kód]="",[Szint2 - kód],[Szint3 - kód]),[Szint4 - kód]),[Szint5 - kód]),[Szint6 - kód])) AS FőosztályKód, tSzervezeti.[HR kapcsolat sorszáma], tSzervezeti.Név, tSzervezeti.[Érvényesség kezdete], tSzervezeti.[Érvényesség vége], tSzervezeti.[Költséghely kód], tSzervezeti.[Költséghely megnevezés], tSzervezeti.[Szervezeti egységének szintje], tSzervezeti.[Szülő szervezeti egységének kódja], tSzervezeti.[Szervezeti egységének megnevezése], tSzervezeti.[Szervezeti egységének vezetője], tSzervezeti.[Szervezeti egységének vezetőjének azonosítója], tSzervezeti.[A költséghely eltér a szervezeti egységének költséghelytől?], tSzervezeti.[Szervezeti munkakörének kódja], tSzervezeti.[Szervezeti munkakörének megnevezése], tSzervezeti.[A költséghely eltér a szervezeti munkakörének költséghelyétől?], tSzervezeti.[Státuszbetöltéssel rendelkezik a kilépést követően?], tSzervezeti.[Közzétett hierarchiában megjelenítendő], tSzervezeti.[Helyettesítés mértéke (%)], tSzervezeti.[Helyettesítési díj (%)], tSzervezeti.[Státuszának kódja], tSzervezeti.[Státuszának neve], tSzervezeti.[Státuszának az engedélyezett óraszáma], tSzervezeti.[Státusz engedélyezett FTE (üzleti paraméter szerint számolva)], tSzervezeti.[Aktuális betöltés óraszáma], tSzervezeti.[Aktuális betöltés FTE], tSzervezeti.[Státuszának költséghely kódja], tSzervezeti.[Státuszának költséghely megnevezése], tSzervezeti.[A költséghely eltér a státuszának költséghelyétől?], tSzervezeti.[A Bér F6 besorolási szint eltér a szervezeti munkakörének Bér F6], tSzervezeti.[Státuszbetöltés típusa], tSzervezeti.[Inaktív állományba kerülés oka], tSzervezeti.[Tartós távollét kezdete], tSzervezeti.[Tartós távollét számított kezdete], tSzervezeti.[Tartós távollét vége], tSzervezeti.[Tartós távollét típusa], tSzervezeti.Elsődleges, tSzervezeti.[Státusz vizualizációjában először megjelenítendő], tSzervezeti.[Betöltő szerződéses/kinevezéses munkakörének kódja], tSzervezeti.[Betöltő szerződéses/kinevezéses munkakörének neve], tSzervezeti.[Szervezeti munkakör eltér a szerződéses/kinevezéses munkakörtől], tSzervezeti.[Betöltő közvetlen vezetője], tSzervezeti.[Betöltő közvetlen vezetőjének azonosítója], tSzervezeti.[Szint1 - kód], tSzervezeti.[Szint1 - leírás], tSzervezeti.[Szint2 - kód], tSzervezeti.[Szint2 - leírás], tSzervezeti.[Szint3 - kód], tSzervezeti.[Szint3 - leírás], tSzervezeti.[Szint4 - kód], tSzervezeti.[Szint4 - leírás], tSzervezeti.[Szint5 - kód], tSzervezeti.[Szint5 - leírás], tSzervezeti.[Szint6 - kód], tSzervezeti.[Szint6 - leírás], tSzervezeti.[Szint7 - kód], tSzervezeti.[Szint7 - leírás], tSzervezeti.[Szint8 - kód], tSzervezeti.[Szint8 - leírás], tSzervezeti.[HRM-ben lévő költséghely kód besorolási adat], tSzervezeti.[HRM-ben lévő költséghely megnevezés besorolási adat], tSzervezeti.[A Költséghely érvényességének kezdete], tSzervezeti.[HRM-ben lévő FEOR besorolási adat], tSzervezeti.[A FEOR érvényességének kezdete], tSzervezeti.[A FEOR érvényességének vége], tSzervezeti.[HRM-ben lévő Munkakör besorolási adat], tSzervezeti.[A Munkakör érvényességének kezdete]
FROM tSzervezeti
WHERE (((tSzervezeti.OSZLOPOK)="Státusz betöltés") AND ((tSzervezeti.[Érvényesség kezdete])<=Date()) AND ((tSzervezeti.[Érvényesség vége])>=Date() Or (tSzervezeti.[Érvényesség vége])=0) AND ((tSzervezeti.[Státuszának kódja]) Like "S-*") AND ((tSzervezeti.[Státuszbetöltés típusa])<>"Helyettes"));

#/#/#/
lkSzervezetiBetöltések - azonosak keresése
#/#/
SELECT First(lkSzervezetiBetöltések.[Státuszának kódja]) AS [Státuszának kódja Mező], Count(lkSzervezetiBetöltések.[Státuszának kódja]) AS AzonosakSzáma
FROM lkSzervezetiBetöltések
GROUP BY lkSzervezetiBetöltések.[Státuszának kódja]
HAVING (((Count(lkSzervezetiBetöltések.[Státuszának kódja]))>1));

#/#/#/
lkSzervezetiEgységekLegnagyobbLétszámúTelephelyei
#/#/
SELECT lkTelephelyekLétszáma.BFKH, lkTelephelyekLétszáma.Főosztály, lkTelephelyekLétszáma.Osztály, lkTelephelyekLétszáma.Cím
FROM lkTelephelyekLétszáma INNER JOIN (SELECT Tmp.BFKH, Max(Tmp.Létszám) AS MaxOfLétszám FROM lkTelephelyekLétszáma AS Tmp GROUP BY Tmp.BFKH)  AS TMP1 ON (lkTelephelyekLétszáma.Létszám = TMP1.MaxOfLétszám) AND (lkTelephelyekLétszáma.BFKH = TMP1.BFKH);

#/#/#/
lkSzervezetiHibásanNemElsődleges
#/#/
SELECT DISTINCT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], dtÁtal([tSzervezeti].[Érvényesség kezdete]) AS [Betöltés kezdete], IIf(dtÁtal([tSzervezeti].[Érvényesség vége])=0,"",dtÁtal([tSzervezeti].[Érvényesség vége])) AS [Betöltés vége], kt_azNexon_Adójel02.NLink
FROM kt_azNexon_Adójel02 RIGHT JOIN (lkSzemélyek INNER JOIN (tSzervezeti INNER JOIN lkSzervezetÁlláshelyek ON tSzervezeti.[Státuszának kódja] = lkSzervezetÁlláshelyek.Álláshely) ON lkSzemélyek.[Adóazonosító jel] = tSzervezeti.[Szervezetmenedzsment kód]) ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((dtÁtal([tSzervezeti].[Érvényesség kezdete]))<=dtátal(Now())) AND ((IIf(dtÁtal([tSzervezeti].[Érvényesség vége])=0,"",dtÁtal([tSzervezeti].[Érvényesség vége])))>=dtátal(Now()) Or (IIf(dtÁtal([tSzervezeti].[Érvényesség vége])=0,"",dtÁtal([tSzervezeti].[Érvényesség vége])))="") AND ((dtÁtal([lkSzervezetÁlláshelyek].[Érvényesség kezdete]))<=dtátal(Now())) AND ((dtÁtal(Nü([lkSzervezetÁlláshelyek].[Érvényesség vége],#1/1/3000#)))>=dtátal(Now())) AND ((tSzervezeti.OSZLOPOK)="Státusz betöltés") AND ((tSzervezeti.Elsődleges)="nem"));

#/#/#/
lkSzervezetiStatisztika01
#/#/
SELECT Replace(Replace([OSZLOPOK],"Szervezeti egység összesen (",""),")","") AS [Szervezeti egység neve], tSzervezet.[Betöltött státuszok száma (db)], tSzervezet.[Betöltetlen státuszok száma (db)]
FROM tSzervezet
WHERE (((tSzervezet.OSZLOPOK) Like "Szervezeti egység összesen (*"));

#/#/#/
lkSzervezetiUtolsóBetöltések
#/#/
SELECT tSzervezet.[Szervezetmenedzsment kód], Max(IIf([Érvényesség vége]=0,#1/1/3000#,[érvényesség vége])) AS Maxvég INTO tSzervezetiUtolsóBetöltésekTmp
FROM tSzervezet
WHERE (((tSzervezet.OSZLOPOK)="státusz betöltés"))
GROUP BY tSzervezet.[Szervezetmenedzsment kód];

#/#/#/
lkSzervezetiUtolsóMegszűntBetöltésHibásElsődlegesVolt
#/#/
SELECT DISTINCT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], tSzervezeti.[Szervezetmenedzsment kód], tNexonAzonosítók.[Személy azonosító], tSzervezeti.Elsődleges, tSzervezeti.[Érvényesség vége] AS BetöltésVég, dtÁtal(Nü([Jogviszony vége (kilépés dátuma)],#1/1/3000#)) AS Kilépés
FROM (lkSzemélyek INNER JOIN (tSzervezeti INNER JOIN tNexonAzonosítók ON tSzervezeti.[Szervezetmenedzsment kód] = tNexonAzonosítók.[Adóazonosító jel]) ON lkSzemélyek.[Adóazonosító jel] = tSzervezeti.[Szervezetmenedzsment kód]) INNER JOIN tSzervezetiUtolsóBetöltésekTmp ON (tSzervezetiUtolsóBetöltésekTmp.[Szervezetmenedzsment kód] = tSzervezeti.[Szervezetmenedzsment kód]) AND (tSzervezeti.[Érvényesség vége] = tSzervezetiUtolsóBetöltésekTmp.Maxvég)
WHERE (((tSzervezeti.Elsődleges)="nem") AND ((dtÁtal(Nü([Jogviszony vége (kilépés dátuma)],#1/1/3000#)))<dtÁtal(Date())) AND ((tSzervezeti.OSZLOPOK)="Státusz betöltés"));

#/#/#/
lkSzervezetiVezetőkListája01
#/#/
SELECT lkSzemélyek.BFKH AS [BFKH kód], lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[KIRA feladat megnevezés], tSzervezet.[Szervezeti egység vezetője], lkSzemélyek.[Besorolási  fokozat (KT)] AS Besorolása, lkSzemélyek.[Hivatali email], lkSzemélyek.[Hivatali mobil], lkSzemélyek.[Hivatali telefon], lkSzemélyek.[Hivatali telefon mellék], tTelefonkonyv.[Külső vezetékes telefonszám], tTelefonkonyv.[Belső vezetékes telefonszám], tTelefonkonyv.Mobiltelefonszám, tTelefonkonyv.[Külső fax szám], tTelefonkonyv.[Belső fax szám], tTelefonkonyv.[Levelezési cím], tTelefonkonyv.Emelet, tTelefonkonyv.Szobaszám, tTelefonkonyv.Város, tTelefonkonyv.Irányítószám, tTelefonkonyv.Település, tTelefonkonyv.Utca, tTelefonkonyv.Épület, lkSzemélyek.[Munkavégzés helye - cím]
FROM (tSzervezet INNER JOIN lkSzemélyek ON tSzervezet.[Szervezeti egység vezetőjének azonosítója] = lkSzemélyek.[Adóazonosító jel]) LEFT JOIN tTelefonkonyv ON lkSzemélyek.[Hivatali email] = tTelefonkonyv.[E-mail cím]
ORDER BY bfkh([Szervezetmenedzsment kód]);

#/#/#/
lkSzervezetiVezetőkListája02
#/#/
SELECT lkSzervezetiVezetőkListája01.[BFKH kód], lkSzervezetiVezetőkListája01.Név, lkSzervezetiVezetőkListája01.[KIRA feladat megnevezés] AS Feladat, lkSzervezetiVezetőkListája01.[Szervezeti egység vezetője], lkSzervezetiVezetőkListája01.Besorolása, lkSzervezetiVezetőkListája01.[Hivatali email], Nü(telefonszámjavító([lkSzervezetiVezetőkListája01]![Hivatali telefon]),telefonszámjavító([Külső vezetékes telefonszám])) AS HivataliVezetékes, telefonszámjavító([Hivatali mobil]) AS HivataliMobil, lkSzervezetiVezetőkListája01.[Munkavégzés helye - cím]
FROM lkSzervezetiVezetőkListája01;

#/#/#/
lkSzervezetSzemélyek
#/#/
SELECT tSzervezet.*, [Szervezetmenedzsment kód]*1 AS Adójel
FROM tSzervezet
WHERE (((tSzervezet.OSZLOPOK)="Státusz betöltés"));

#/#/#/
lkSzóközöket_tartalmazó_szervek
#/#/
SELECT *
FROM (SELECT DISTINCT tSzemélyek.[Szint 1 szervezeti egység név] AS SzervNév, [Szervezeti egység kódja] As Kód FROM tSzemélyek UNION SELECT DISTINCT  tSzemélyek.[Szint 2 szervezeti egység név], [Szervezeti egység kódja] FROM tSzemélyek UNION SELECT DISTINCT  tSzemélyek.[Szint 3 szervezeti egység név], [Szervezeti egység kódja] FROM tSzemélyek UNION SELECT DISTINCT  tSzemélyek.[Szint 4 szervezeti egység név], [Szervezeti egység kódja] FROM tSzemélyek UNION SELECT DISTINCT  tSzemélyek.[Szint 5 szervezeti egység név], [Szervezeti egység kódja] FROM tSzemélyek UNION SELECT DISTINCT  tSzemélyek.[Szint 6 szervezeti egység név], [Szervezeti egység kódja] FROM tSzemélyek UNION SELECT DISTINCT  tSzemélyek.[Szint 7 szervezeti egység név], [Szervezeti egység kódja] FROM tSzemélyek UNION SELECT lkSzemélyek.Főosztály, lkSzemélyek.[Szervezeti egység kódja] FROM lkSzemélyek UNION SELECT lkSzemélyek.Osztály, lkSzemélyek.[Szervezeti egység kódja] FROM lkSzemélyek   )  AS SzervezetUnió
WHERE (((SzervezetUnió.szervnév) Like "*  *")) Or (((SzervezetUnió.szervnév) Like "*   *")) Or (((SzervezetUnió.szervnév) Like "*    *"));

#/#/#/
lkSzolgálatiIdőElismerés
#/#/
SELECT tSzolgálatiIdőElsimerés.[Szolgálati elismerésre jogosultság / Jubileumi jutalom kezdő dát] AS SzolgIdKezd, bfkh(Nz([Szervezeti egység kód],0)) AS Kif1, [Azonosító]*1 AS Adójel, tSzolgálatiIdőElsimerés.*
FROM tSzolgálatiIdőElsimerés
WHERE (((tSzolgálatiIdőElsimerés.Azonosító)<>"" Or (tSzolgálatiIdőElsimerés.Azonosító) Is Not Null))
ORDER BY bfkh(Nz([Szervezeti egység kód],0));

#/#/#/
lkSzolgálatiIdőElsimerés
#/#/
SELECT tSzolgálatiIdőElsimerés.[Szolgálati elismerésre jogosultság / Jubileumi jutalom kezdő dát] AS SzolgIdKezd, bfkh(Nz([Szervezeti egység kód],0)) AS Kif1, [Azonosító]*1 AS Adójel, tSzolgálatiIdőElsimerés.*
FROM tSzolgálatiIdőElsimerés
WHERE ((([tSzolgálatiIdőElsimerés].[Azonosító])<>"" Or ([tSzolgálatiIdőElsimerés].[Azonosító]) Is Not Null))
ORDER BY bfkh(Nz([Szervezeti egység kód],0));

#/#/#/
lkszületésiévésNem
#/#/
SELECT lkSzemélyek.Adójel, Year([Születési idő]) AS [Szül év], IIf([Neme]="Férfi",1,2) AS Nem
FROM lkSzemélyek;

#/#/#/
lkTáblanevek
#/#/
SELECT MSysObjects.Name, MSysObjects.Flags
FROM MSysObjects
WHERE (((MSysObjects.Type)=1) AND ((MSysObjects.Flags)=0)) OR (((MSysObjects.Type)=5))
ORDER BY MSysObjects.Type, MSysObjects.Name;

#/#/#/
lkTartósanÜresÁlláshelyek
#/#/
SELECT lkÜresÁlláshelyekNemVezető.[Főosztály\Hivatal], lkÜresÁlláshelyekNemVezető.[Megüresedéstől eltelt hónapok], lkÜresÁlláshelyekÁllapotfelmérő.[Legutóbbi állapot], lkÜresÁlláshelyekÁllapotfelmérő.[Legutóbbi állapot ideje]
FROM lkÜresÁlláshelyekNemVezető INNER JOIN lkÜresÁlláshelyekÁllapotfelmérő ON lkÜresÁlláshelyekNemVezető.[Álláshely azonosító] = lkÜresÁlláshelyekÁllapotfelmérő.[Álláshely azonosító]
WHERE (((lkÜresÁlláshelyekNemVezető.[Megüresedéstől eltelt hónapok])=5 Or (lkÜresÁlláshelyekNemVezető.[Megüresedéstől eltelt hónapok])=4) AND ((lkÜresÁlláshelyekNemVezető.Jelleg)="A"))
ORDER BY lkÜresÁlláshelyekNemVezető.[Megüresedéstől eltelt hónapok] DESC , lkÜresÁlláshelyekÁllapotfelmérő.[Legutóbbi állapot ideje];

#/#/#/
lkTartósTávollétEltérésÁnyrNexon
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Státusz kódja], lkSzemélyek.[Tartós távollét típusa] AS Nexon, lkÁlláshelyek.[Álláshely státusza] AS Ányr, kt_azNexon_Adójel02.NLink
FROM kt_azNexon_Adójel02 RIGHT JOIN (lkSzemélyek LEFT JOIN lkÁlláshelyek ON lkSzemélyek.[Státusz kódja] = lkÁlláshelyek.[Álláshely azonosító]) ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Tartós távollét típusa]) Is Null) AND ((lkÁlláshelyek.[Álláshely státusza]) Not Like "*betöltött*" And (lkÁlláshelyek.[Álláshely státusza])<>"betöltetlen") AND ((lkSzemélyek.[Státusz neve])="álláshely")) OR (((lkSzemélyek.[Tartós távollét típusa]) Is Not Null And (lkSzemélyek.[Tartós távollét típusa])<>"CSED" And (lkSzemélyek.[Tartós távollét típusa])<>"Mentesítés felmentési / felmondási időn belül" And (lkSzemélyek.[Tartós távollét típusa])<>"Mentesítés munkáltató engedélye alapján") AND ((lkÁlláshelyek.[Álláshely státusza]) Not Like "*tartós*") AND ((lkSzemélyek.[Státusz neve])="álláshely"))
ORDER BY lkSzemélyek.BFKH;

#/#/#/
lkTartósTávollétÉsBetöltésTípusEltérés
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Tartós távollét típusa] AS [TT típus], lkSzemélyek.[Tartós távollét vége] AS [TT vége], lkSzemélyek.[Tartós távollét tervezett vége] AS [TT tervezett vége], lkSzervezetiBetöltések.[Státuszbetöltés típusa], kt_azNexon_Adójel02.NLink
FROM kt_azNexon_Adójel02 INNER JOIN (lkSzemélyek INNER JOIN lkSzervezetiBetöltések ON lkSzemélyek.[Adóazonosító jel] = lkSzervezetiBetöltések.[Szervezetmenedzsment kód]) ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Tartós távollét típusa])<>"Mentesítés felmentési / felmondási időn belül" Or (lkSzemélyek.[Tartós távollét típusa]) Is Null) AND ((lkSzervezetiBetöltések.[Státuszbetöltés típusa])="Felmentés alatt")) OR (((lkSzemélyek.[Tartós távollét vége])<Date() Or (lkSzemélyek.[Tartós távollét vége]) Is Null) AND ((lkSzemélyek.[Tartós távollét tervezett vége])<Date() Or (lkSzemélyek.[Tartós távollét tervezett vége]) Is Null) AND ((lkSzervezetiBetöltések.[Státuszbetöltés típusa])="Inaktív")) OR (((lkSzemélyek.[Tartós távollét típusa]) Is Null) AND ((lkSzervezetiBetöltések.[Státuszbetöltés típusa])="Inaktív")) OR (((lkSzemélyek.[Tartós távollét típusa]) Is Not Null And (lkSzemélyek.[Tartós távollét típusa])<>"Mentesítés munkáltató engedélye alapján (szabadságra nem jogosító)") AND ((lkSzervezetiBetöltések.[Státuszbetöltés típusa])="általános"))
ORDER BY lkSzemélyek.BFKH, lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkTartósTávollévőkAdottÉvben
#/#/
SELECT lkSzemélyek.[Szint 3 szervezeti egység név], lkSzemélyek.[Szint 4 szervezeti egység név], lkSzemélyek.[Szint 5 szervezeti egység név], lkSzemélyek.[Tartós távollét kezdete], lkSzemélyek.[Tartós távollét vége], lkSzemélyek.[Tartós távollét tervezett vége]
FROM lkSzemélyek
WHERE (((Year(dtátal(2022))) Between Year(dtátal([tartós távollét kezdete])) And IIf(Nz([tartós távollét vége],"")="",IIf(Nz([tartós távollét tervezett vége],"")="",Year(dtátal(3000)),Year(dtátal([tartós távollét tervezett vége]))),Year(dtátal([tartós távollét vége])))) AND ((Nz([Tartós távollét kezdete],""))<>""))
ORDER BY lkSzemélyek.[Szint 4 szervezeti egység név];

#/#/#/
lkTelefonszámMinták
#/#/
SELECT lkSzemélyek.[Hivatali telefon], feltöltő(lkSzemélyek.[Hivatali telefon]) AS Tel
FROM lkSzemélyek
WHERE lkSzemélyek.[Hivatali telefon] Is Not Null
UNION SELECT lkSzemélyek.[Hivatali mobil],feltöltő(lkSzemélyek.[Hivatali mobil])
FROM lkSzemélyek
WHERE lkSzemélyek.[Hivatali mobil] Is Not Null and
"UNION
SELECT lkSzemélyek.[Otthoni mobil],feltöltő(lkSzemélyek.[Otthoni mobil])
FROM lkSzemélyek
WHERE lkSzemélyek.[Otthoni mobil] Is Not Null
UNION
SELECT lkSzemélyek.[Otthoni telefon],feltöltő(lkSzemélyek.[Otthoni telefon])
FROM lkSzemélyek
WHERE lkSzemélyek.[Otthoni telefon] Is Not Null
UNION
SELECT lkSzemélyek.[További otthoni mobil],Feltöltő(lkSzemélyek.[További otthoni mobil])
FROM lkSzemélyek
WHERE lkSzemélyek.[További otthoni mobil] Is Not Null";

#/#/#/
lkTelephelyCímek
#/#/
SELECT DISTINCT lkTelephelyek.Sorszám, lkTelephelyek.Cím_Személyek
FROM lkTelephelyek;

#/#/#/
lkTelephelyCímEllenőrzés
#/#/
SELECT lkSzervezetiEgységekLegnagyobbLétszámúTelephelyei.Főosztály, lkSzervezetiEgységekLegnagyobbLétszámúTelephelyei.Osztály, Replace(Nz([Cím],"")," .",".") AS [Szervezet címe], lkSzemélyek.MunkavégzésCíme, kt_azNexon_Adójel02.NLink
FROM kt_azNexon_Adójel02 INNER JOIN (lkSzervezetiEgységekLegnagyobbLétszámúTelephelyei INNER JOIN lkSzemélyek ON lkSzervezetiEgységekLegnagyobbLétszámúTelephelyei.BFKH = lkSzemélyek.BFKH) ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((Replace(Nz([Cím],"")," .","."))<>"") AND ((lkSzemélyek.[Státusz neve])="álláshely") AND (([MunkavégzésCíme]=Replace(Nz([lkSzervezetiEgységekLegnagyobbLétszámúTelephelyei].[Cím],"")," .","."))=False))
ORDER BY lkSzervezetiEgységekLegnagyobbLétszámúTelephelyei.Főosztály;

#/#/#/
lkTelephelyEgyMegadottFőosztályra
#/#/
SELECT lkSzemélyek.MunkavégzésCíme, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, kt_azNexon_Adójel.NLink
FROM kt_azNexon_Adójel INNER JOIN lkSzemélyek ON kt_azNexon_Adójel.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.Főosztály) Like "*" & [A keresendő főosztály neve, vagy a nevének a részlete:] & "*"))
ORDER BY lkSzemélyek.MunkavégzésCíme;

#/#/#/
lkTelephelyek
#/#/
SELECT tTelephelyek230301.Sorszám, tTelephelyek230301.Irsz, tTelephelyek230301.Város, tTelephelyek230301.Cím, tTelephelyek230301.Tulajdonos, tTelephelyek230301.Üzemeltető, IIf(Nz([Nexon cím],"")="",([Irsz] & " " & [Város] & ", " & IIf(Left([Irsz],1)=1,num2num(Mid([Irsz],2,2),10,99) & ". kerület, ","") & [Cím]),[Nexon cím]) AS Cím_Személyek, tTelephelyek230301.[Nexon cím]
FROM tTelephelyek230301;

#/#/#/
lkTelephelyekCímNélkül
#/#/
SELECT DISTINCT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Munkavégzés helye - megnevezés], lkSzemélyek.[Munkavégzés helye - cím], Count(lkSzemélyek.Adójel) AS CountOfAdójel
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Munkavégzés helye - cím]) Is Null)) OR (((lkSzemélyek.[Státusz neve])="Álláshely") AND ((Len([Munkavégzés helye - cím]))<3))
GROUP BY lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Munkavégzés helye - megnevezés], lkSzemélyek.[Munkavégzés helye - cím];

#/#/#/
lkTelephelyekenDolgozók
#/#/
SELECT lkSzemélyTelephelyek.[Szervezeti egység kódja], lkSzemélyTelephelyek.Főosztály, lkSzemélyTelephelyek.Osztály, lkTelephelyek.Sorszám, lkSzemélyTelephelyek.[Dolgozó teljes neve], lkTelephelyek.Irsz, lkTelephelyek.Város, lkTelephelyek.Cím, lkTelephelyek.Tulajdonos, lkTelephelyek.Üzemeltető, 1 AS Létszám
FROM lkTelephelyek RIGHT JOIN lkSzemélyTelephelyek ON lkTelephelyek.Cím_Személyek=lkSzemélyTelephelyek.TelephelyCíme
ORDER BY bfkh([Szervezeti egység kódja]);

#/#/#/
lkTelephelyekLétszáma
#/#/
SELECT lkSzemélyek.BFKH, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, IIf(Len([Munkavégzés helye - cím])<2,[Munkavégzés helye - megnevezés],[Munkavégzés helye - cím]) AS Cím, Count(lkSzemélyek.Adójel) AS Létszám
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely"))
GROUP BY lkSzemélyek.BFKH, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, IIf(Len([Munkavégzés helye - cím])<2,[Munkavégzés helye - megnevezés],[Munkavégzés helye - cím]);

#/#/#/
lkTelephelyenkéntiLétszám2
#/#/
SELECT lkSzemélyek.[Munkavégzés helye - megnevezés], lkSzemélyek.[Munkavégzés helye - cím], Count(lkSzemélyek.Azonosító) AS [Létszám (fő)]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Jogviszony vége (kilépés dátuma)])>Date()-1 Or (lkSzemélyek.[Jogviszony vége (kilépés dátuma)]) Is Null Or (lkSzemélyek.[Jogviszony vége (kilépés dátuma)])=0))
GROUP BY lkSzemélyek.[Munkavégzés helye - megnevezés], lkSzemélyek.[Munkavégzés helye - cím]
ORDER BY Count(lkSzemélyek.Azonosító) DESC;

#/#/#/
lkTelephelyenkéntiLétszámSzervezetenként
#/#/
SELECT lkSzemélyTelephelyek.[Munkavégzés helye - cím] AS Telephely, lkSzemélyTelephelyek.Főosztály, Count(lkSzemélyTelephelyek.adójel) AS Létszám
FROM lkSzemélyTelephelyek
GROUP BY lkSzemélyTelephelyek.[Munkavégzés helye - cím], lkSzemélyTelephelyek.Főosztály;

#/#/#/
lkTelephelyenkéntiOsztályonkéntiLétszám
#/#/
SELECT lkSzemélyek.BFKH, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.MunkavégzésCíme, Count(lkSzemélyek.Adójel) AS Létszám
FROM lkSzemélyek
WHERE (((lkSzemélyek.MunkavégzésCíme) Is Not Null) AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
GROUP BY lkSzemélyek.BFKH, lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.MunkavégzésCíme
ORDER BY lkSzemélyek.BFKH, Count(lkSzemélyek.Adójel) DESC;

#/#/#/
lktJárási_állomány
#/#/
SELECT tJárási_állomány.Sorszám, tJárási_állomány.Név, tJárási_állomány.Adóazonosító, tJárási_állomány.Mező4 AS [Születési év \ üres állás], tJárási_állomány.Mező5 AS Neme, Replace([Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH") AS [Járási Hivatal_], tJárási_állomány.Mező7 AS Osztály, tJárási_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], tJárási_állomány.Mező9 AS [Ellátott feladat], tJárási_állomány.Mező10 AS Kinevezés, tJárási_állomány.[Feladat jellege: szakmai (SZ) / funkcionális (F) feladatellátás;], tJárási_állomány.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ], tJárási_állomány.[Heti munkaórák száma], tJárási_állomány.Mező14 AS [Betöltés aránya], tJárási_állomány.[Besorolási fokozat kód:], tJárási_állomány.[Besorolási fokozat megnevezése:], tJárási_állomány.[Álláshely azonosító], tJárási_állomány.Mező18 AS [Havi illetmény], tJárási_állomány.Mező19 AS [Eu finanszírozott], tJárási_állomány.Mező20 AS [Illetmény forrása], tJárási_állomány.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h], tJárási_állomány.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], tJárási_állomány.[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)], tJárási_állomány.[Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis], tJárási_állomány.[Ügyfélszolgálati munkatárs (1) ügyfélszolgálati háttér munkatárs], tJárási_állomány.Mező26 AS [Képesítést adó végzettség], tJárási_állomány.Mező27 AS KAB, tJárási_állomány.[KAB 001-3** Branch ID], tJárási_állomány.hatályaID, tJárási_állomány.azJárásiSor
FROM tJárási_állomány;

#/#/#/
lktKormányhivatali_állomány
#/#/
SELECT tKormányhivatali_állomány.Sorszám, tKormányhivatali_állomány.Név, tKormányhivatali_állomány.Adóazonosító, tKormányhivatali_állomány.Mező4 AS [Születési év \ üres állás], tKormányhivatali_állomány.Mező5 AS Neme, tKormányhivatali_állomány.Mező6 AS Főosztály, tKormányhivatali_állomány.Mező7 AS Osztály, tKormányhivatali_állomány.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], tKormányhivatali_állomány.Mező9 AS [Ellátott feladat], tKormányhivatali_állomány.Mező10 AS Kinevezés, tKormányhivatali_állomány.[Feladat jellege: szakmai (SZ) / funkcionális (F) feladatellátás;], tKormányhivatali_állomány.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ], tKormányhivatali_állomány.[Heti munkaórák száma], tKormányhivatali_állomány.Mező14 AS [Betöltés aránya], tKormányhivatali_állomány.[Besorolási fokozat kód:], tKormányhivatali_állomány.[Besorolási fokozat megnevezése:], tKormányhivatali_állomány.[Álláshely azonosító], tKormányhivatali_állomány.Mező18 AS [Havi illetmény], tKormányhivatali_állomány.Mező19 AS [Eu finanszírozott], tKormányhivatali_állomány.Mező20 AS [Illetmény forrása], tKormányhivatali_állomány.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h], tKormányhivatali_állomány.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], tKormányhivatali_állomány.[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)], tKormányhivatali_állomány.[Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis], tKormányhivatali_állomány.[Ügyfélszolgálati munkatárs (1) ügyfélszolgálati háttér munkatárs], tKormányhivatali_állomány.Mező26 AS [Képesítést adó végzettség], tKormányhivatali_állomány.Mező27 AS KAB, tKormányhivatali_állomány.[KAB 001-3** Branch ID], tKormányhivatali_állomány.hatályaID, tKormányhivatali_állomány.azKormányhivataliSor
FROM tKormányhivatali_állomány;

#/#/#/
lktKormányhivataliRekordokSzáma
#/#/
SELECT lktKormányhivatali_állomány.hatályaID, tHaviJelentésHatálya1.hatálya, Count(lktKormányhivatali_állomány.[Álláshely azonosító]) AS [CountOfÁlláshely azonosító]
FROM lktKormányhivatali_állomány INNER JOIN tHaviJelentésHatálya1 ON lktKormányhivatali_állomány.hatályaID = tHaviJelentésHatálya1.hatályaID
GROUP BY lktKormányhivatali_állomány.hatályaID, tHaviJelentésHatálya1.hatálya
ORDER BY tHaviJelentésHatálya1.hatálya;

#/#/#/
lktKözpontosítottak
#/#/
SELECT tKözpontosítottak.Sorszám, tKözpontosítottak.Név, tKözpontosítottak.Adóazonosító, tKözpontosítottak.Mező4 AS [Születési év \ üres állás], "" AS Nem, Replace(IIf([Megyei szint VAGY Járási Hivatal]="Megyei szint",[tKözpontosítottak].[Mező6],[Megyei szint VAGY Járási Hivatal]),"Budapest Főváros Kormányhivatala ","BFKH ") AS Főoszt, tKözpontosítottak.Mező7 AS Osztály, tKözpontosítottak.[Nexon szótárelemnek megfelelő szervezeti egység azonosító] AS [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], tKözpontosítottak.Mező10 AS [Ellátott feladat], tKözpontosítottak.Mező11 AS Kinevezés, "SZ" AS [Feladat jellege], tKözpontosítottak.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ], 0 AS [Heti munkaórák száma], 1 AS [Betöltés aránya], tKözpontosítottak.[Besorolási fokozat kód:], tKözpontosítottak.[Besorolási fokozat megnevezése:], tKözpontosítottak.[Álláshely azonosító], tKözpontosítottak.Mező17 AS [Havi illetmény], "" AS [Eu finanszírozott], "" AS [Illetmény forrása], "" AS [Garantált bérminimumban részesül (GB) / tartós távollévő nincs h], tKözpontosítottak.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], tKözpontosítottak.[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)], tKözpontosítottak.[Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis], "" AS [Ügyfélszolgálati munkatárs (1) ügyfélszolgálati háttér munkatárs], "" AS [Képesítést adó végzettség], "" AS KAB, "" AS [KAB 001-3** Branch ID], tKözpontosítottak.hatályaID, tKözpontosítottak.azKözpontosítottakSor
FROM tKözpontosítottak;

#/#/#/
lktKSZDR - azonosak keresése
#/#/
SELECT First(tKSZDR.[Adóazonosító jel]) AS [Adóazonosító jel Mező], Count(tKSZDR.[Adóazonosító jel]) AS AzonosakSzáma
FROM tKSZDR
GROUP BY tKSZDR.[Adóazonosító jel]
HAVING (((Count(tKSZDR.[Adóazonosító jel]))>1));

#/#/#/
lkTmpEgyesMunkakörökFőosztályaiLétszám
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, Count(lkSzemélyek.Adójel) AS Létszám
FROM tTmpEgyesMunkakörökFőosztályai INNER JOIN lkSzemélyek ON tTmpEgyesMunkakörökFőosztályai.Főosztály = lkSzemélyek.FőosztályKód
WHERE (((lkSzemélyek.[KIRA feladat megnevezés]) Not Like "*titkársági*") AND ((tTmpEgyesMunkakörökFőosztályai.Főosztály)=[lkSzemélyek].[Főosztálykód]) AND ((lkSzemélyek.Osztály) Like [tTmpEgyesMunkakörökFőosztályai].[Osztály]))
GROUP BY lkSzemélyek.Főosztály, lkSzemélyek.Osztály;

#/#/#/
lkTMPIlletményMióta01
#/#/
SELECT lkSzemélyekAdottNapon.BFKH, tmpRégiÉsJelenlegiIlletmény.Adóazonosító, lkSzemélyekAdottNapon.[Dolgozó teljes neve] AS Név, lkSzemélyekAdottNapon.[KIRA feladat megnevezés] AS Munkakör, lkSzemélyekAdottNapon.Főosztály, lkSzemélyekAdottNapon.Osztály, lkLegkorábbiKinevezés.[Első belépése], tmpRégiÉsJelenlegiIlletmény.Jelenlegi40órás AS Illetménye, Max(tHaviJelentésHatálya1.hatálya) AS MaxOfhatálya
FROM tHaviJelentésHatálya1 INNER JOIN ((lkLegkorábbiKinevezés INNER JOIN tmpRégiÉsJelenlegiIlletmény ON lkLegkorábbiKinevezés.[Adóazonosító jel] = tmpRégiÉsJelenlegiIlletmény.Adóazonosító) INNER JOIN lkSzemélyekAdottNapon ON tmpRégiÉsJelenlegiIlletmény.Adóazonosító = lkSzemélyekAdottNapon.[Adóazonosító jel]) ON tHaviJelentésHatálya1.hatályaID = tmpRégiÉsJelenlegiIlletmény.hatályaID
WHERE ((([Jelenlegi40órás]=[Régi40órás])=0)) Or (((DateSerial(Year(lkLegkorábbiKinevezés.[Első belépése]),Month(lkLegkorábbiKinevezés.[Első belépése]),1)=DateSerial(Year([hatálya]),Month([hatálya]),1))<>0))
GROUP BY lkSzemélyekAdottNapon.BFKH, tmpRégiÉsJelenlegiIlletmény.Adóazonosító, lkSzemélyekAdottNapon.[Dolgozó teljes neve], lkSzemélyekAdottNapon.[KIRA feladat megnevezés], lkSzemélyekAdottNapon.Főosztály, lkSzemélyekAdottNapon.Osztály, lkLegkorábbiKinevezés.[Első belépése], tmpRégiÉsJelenlegiIlletmény.Jelenlegi40órás
ORDER BY lkSzemélyekAdottNapon.BFKH, tmpRégiÉsJelenlegiIlletmény.Adóazonosító, Max(tHaviJelentésHatálya1.hatálya) DESC;

#/#/#/
lkTMPIlletményMióta02
#/#/
SELECT lkTMPIlletményMióta01.BFKH, lkTMPIlletményMióta01.Adóazonosító, lkTMPIlletményMióta01.Név, lkTMPIlletményMióta01.Munkakör, lkTMPIlletményMióta01.Főosztály, lkTMPIlletményMióta01.Osztály, lkTMPIlletményMióta01.[Első belépése], lkTMPIlletményMióta01.Illetménye, DateSerial(Year([MaxOfhatálya]),Month([MaxOfhatálya])+IIf([lkTMPIlletményMióta01].[Első belépése]=[lkTMPIlletményMióta01].[MaxOfhatálya],0,1),1) AS [Mióta kapja]
FROM lkTMPIlletményMióta01;

#/#/#/
lktNFSZSzervezetek
#/#/
SELECT *
FROM (SELECT TOP 1 "BFKH.01.02.03" AS BFKH FROM tszemélyek UNION
   SELECT TOP 1 "BFKH.01.02.04" AS BFKH FROM tszemélyek UNION
   SELECT TOP 1 "BFKH.01.02.08" AS BFKH FROM tszemélyek UNION
   SELECT TOP 1 "BFKH.01.02.09" AS BFKH FROM tszemélyek UNION
   SELECT TOP 1 "BFKH.01.02.09" AS BFKH FROM tszemélyek UNION
   SELECT TOP 1 "BFKH.01.02.10" AS BFKH FROM tszemélyek UNION
   SELECT TOP 1 "BFKH.01.02.13" AS BFKH FROM tszemélyek UNION
   SELECT TOP 1 "BFKH.01.02.18" AS BFKH FROM tszemélyek UNION
   SELECT TOP 1 "BFKH.01.02.20" AS BFKH FROM tszemélyek UNION
   SELECT TOP 1 "BFKH.01.02.21" AS BFKH FROM tszemélyek UNION
   SELECT TOP 1 "BFKH.01.16" AS BFKH FROM tszemélyek UNION
   SELECT TOP 1 "BFKH.01.16" AS BFKH FROM tszemélyek UNION
   SELECT TOP 1 "BFKH.01.17" AS BFKH FROM tszemélyek UNION
   SELECT TOP 1 "BFKH.01.17" AS BFKH FROM tszemélyek 
)  AS SzervezetiEgységek;

#/#/#/
lkTovábbfoglalkoztatottak
#/#/
SELECT lkSzemélyek.Adójel, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Szerződés/kinevezés verzió_érvényesség vége], lkSzemélyek.[Határozott idejű _szerződés/kinevezés lejár], lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja], lkSzemélyek.[Jogviszony kezdete (belépés dátuma)], lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének oka: jogszabályi hiva], lkSzemélyek.[Jogviszony típusa / jogviszony típus], lkSzemélyek.[Születési idő], lkSzemélyek.[KIRA feladat megnevezés], lkSzemélyek.Feladatkör
FROM lkKilépőUnió INNER JOIN lkSzemélyek ON lkKilépőUnió.Adójel = lkSzemélyek.Adójel
WHERE (((lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja])<[Jogviszony kezdete (belépés dátuma)]) AND ((lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének oka: jogszabályi hiva])="A kormánytisztviselő kérelmére a társadalombiztosítási nyugellátásról szóló 1997. évi LXXXI. tv. 18. § (2a) bekezdésében foglalt feltétel fennállása miatt [Kit. 107. § (2) bek. e) pont, 105. § (1) bekezdés c]") AND ((lkSzemélyek.[Státusz neve])="Álláshely")) OR (((lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja])<[Jogviszony kezdete (belépés dátuma)]) AND ((lkSzemélyek.[Státusz neve])="Álláshely") AND ((lkSzemélyek.[Születési idő])<#5/17/1959#))
ORDER BY lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkTörvényességiFelügyeletiÁlláshely
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[Jogviszony típusa / jogviszony típus], ffsplit([Elsődleges feladatkör],"-",2) AS Feladatkör, lkSzemélyek.[Státusz kódja], lkSzemélyek.[Besorolási  fokozat (KT)]
FROM lkSzemélyek INNER JOIN tTmp ON lkSzemélyek.[Státusz kódja] = tTmp.F1;

#/#/#/
lkTörzsszám_Szervezeti_egység
#/#/
SELECT [Törzsszám]*1 AS Törzsszám_, lkFőosztályok.Főosztály, lkSzemélyek.[Szint 5 szervezeti egység név] AS Osztály, Max(lkSzemélyek.[Jogviszony sorszáma]) AS [MaxOfJogviszony sorszáma]
FROM lkSzemélyek INNER JOIN lkFőosztályok ON lkSzemélyek.[Szervezeti egység kódja] = lkFőosztályok.[Szervezeti egység kódja]
GROUP BY [Törzsszám]*1, lkFőosztályok.Főosztály, lkSzemélyek.[Szint 5 szervezeti egység név];

#/#/#/
lkTT21_22_23
#/#/
SELECT TT21_22_23.Főosztály, TT21_22_23.Osztály, Sum(TT21_22_23.TTLétszám2021) AS SumOfTTLétszám2021, Sum(TT21_22_23.TTLétszám2022) AS SumOfTTLétszám2022, Sum(TT21_22_23.TTLétszám2023) AS SumOfTTLétszám2023, Sum(TT21_22_23.Létszám2023) AS SumOfLétszám2023
FROM (SELECT lkTTLétszámFőosztályonkéntOsztályonként2021.Főosztály, lkTTLétszámFőosztályonkéntOsztályonként2021.Osztály, lkTTLétszámFőosztályonkéntOsztályonként2021.TTLétszám2021, lkTTLétszámFőosztályonkéntOsztályonként2021.TTLétszám2022, lkTTLétszámFőosztályonkéntOsztályonként2021.TTLétszám2023, 0 as Létszám2023
FROM lkTTLétszámFőosztályonkéntOsztályonként2021
UNION
SELECT
lkTTLétszámFőosztályonkéntOsztályonként2022.Főosztály, lkTTLétszámFőosztályonkéntOsztályonként2022.Osztály, lkTTLétszámFőosztályonkéntOsztályonként2022.TTLétszám2021, lkTTLétszámFőosztályonkéntOsztályonként2022.TTLétszám2022, lkTTLétszámFőosztályonkéntOsztályonként2022.TTLétszám2023, 0 as Létszám2023
FROM lkTTLétszámFőosztályonkéntOsztályonként2022
UNION
SELECT lkTTLétszámFőosztályonkéntOsztályonként2023.Főosztály, lkTTLétszámFőosztályonkéntOsztályonként2023.Osztály, lkTTLétszámFőosztályonkéntOsztályonként2023.TTLétszám2021, lkTTLétszámFőosztályonkéntOsztályonként2023.TTLétszám2022, lkTTLétszámFőosztályonkéntOsztályonként2023.TTLétszám2023, 0 as Létszám2023
FROM lkTTLétszámFőosztályonkéntOsztályonként2023
UNION
SELECT lkLétszámFőosztályonkéntOsztályonként20230101.Főosztály, lkLétszámFőosztályonkéntOsztályonként20230101.Osztály, lkLétszámFőosztályonkéntOsztályonként20230101.TTLétszám2021, lkLétszámFőosztályonkéntOsztályonként20230101.TTLétszám2022, 0 as TTLétszám2023, SumOfLétszám2023
FROM lkLétszámFőosztályonkéntOsztályonként20230101)  AS TT21_22_23
GROUP BY TT21_22_23.Főosztály, TT21_22_23.Osztály;

#/#/#/
lkTTLétszámFőosztályonkéntOsztályonként2021
#/#/
SELECT Replace(Nz(IIf(IsNull([tSzemélyek20210101].[Szint 4 szervezeti egység név]),IIf(IsNull([tSzemélyek20210101].[Szint 3 szervezeti egység név]),[tSzemélyek20210101].[Szint 2 szervezeti egység név] & "",[tSzemélyek20210101].[Szint 3 szervezeti egység név] & ""),[tSzemélyek20210101].[Szint 4 szervezeti egység név] & ""),""),"Budapest Főváros Kormányhivatala ","BFKH ") & "" AS Főosztály, [Szint 5 szervezeti egység név] & "" AS Osztály, Sum(IIf(Nz([Tartós távollét típusa],"")="",0,1)) AS TTLétszám2021, Sum(0) AS TTLétszám2022, Sum(0) AS TTLétszám2023
FROM tSzemélyek20210101
WHERE (((tSzemélyek20210101.[Státusz neve])="Álláshely"))
GROUP BY Replace(Nz(IIf(IsNull([tSzemélyek20210101].[Szint 4 szervezeti egység név]),IIf(IsNull([tSzemélyek20210101].[Szint 3 szervezeti egység név]),[tSzemélyek20210101].[Szint 2 szervezeti egység név] & "",[tSzemélyek20210101].[Szint 3 szervezeti egység név] & ""),[tSzemélyek20210101].[Szint 4 szervezeti egység név] & ""),""),"Budapest Főváros Kormányhivatala ","BFKH ") & "", [Szint 5 szervezeti egység név] & "";

#/#/#/
lkTTLétszámFőosztályonkéntOsztályonként2022
#/#/
SELECT Replace(Nz(IIf(IsNull([tSzemélyek20220101].[Szint 4 szervezeti egység név]),IIf(IsNull([tSzemélyek20220101].[Szint 3 szervezeti egység név]),[tSzemélyek20220101].[Szint 2 szervezeti egység név] & "",[tSzemélyek20220101].[Szint 3 szervezeti egység név] & ""),[tSzemélyek20220101].[Szint 4 szervezeti egység név] & ""),""),"Budapest Főváros Kormányhivatala ","BFKH ") & "" AS Főosztály, [Szint 5 szervezeti egység név] & "" AS Osztály, Sum(0) AS TTLétszám2021, Sum(IIf(Nz([Tartós távollét típusa],"")="",0,1)) AS TTLétszám2022, Sum(0) AS TTLétszám2023
FROM tSzemélyek20220101
WHERE (((tSzemélyek20220101.[Státusz neve])="Álláshely"))
GROUP BY Replace(Nz(IIf(IsNull([tSzemélyek20220101].[Szint 4 szervezeti egység név]),IIf(IsNull([tSzemélyek20220101].[Szint 3 szervezeti egység név]),[tSzemélyek20220101].[Szint 2 szervezeti egység név] & "",[tSzemélyek20220101].[Szint 3 szervezeti egység név] & ""),[tSzemélyek20220101].[Szint 4 szervezeti egység név] & ""),""),"Budapest Főváros Kormányhivatala ","BFKH ") & "", [Szint 5 szervezeti egység név] & "";

#/#/#/
lkTTLétszámFőosztályonkéntOsztályonként2023
#/#/
SELECT Replace(Nz(IIf(IsNull([tSzemélyek20230101].[Szint 4 szervezeti egység név]),IIf(IsNull([tSzemélyek20230101].[Szint 3 szervezeti egység név]),[tSzemélyek20230101].[Szint 2 szervezeti egység név] & "",[tSzemélyek20230101].[Szint 3 szervezeti egység név] & ""),[tSzemélyek20230101].[Szint 4 szervezeti egység név] & ""),""),"Budapest Főváros Kormányhivatala ","BFKH ") & "" AS Főosztály, [Szint 5 szervezeti egység név] & "" AS Osztály, Sum(0) AS TTLétszám2021, Sum(0) AS TTLétszám2022, Sum(IIf(Nz([Tartós távollét típusa],"")="",0,1)) AS TTLétszám2023, Sum(1) AS Létszám2023
FROM tSzemélyek20230101
WHERE (((tSzemélyek20230101.[Státusz neve])="Álláshely"))
GROUP BY Replace(Nz(IIf(IsNull([tSzemélyek20230101].[Szint 4 szervezeti egység név]),IIf(IsNull([tSzemélyek20230101].[Szint 3 szervezeti egység név]),[tSzemélyek20230101].[Szint 2 szervezeti egység név] & "",[tSzemélyek20230101].[Szint 3 szervezeti egység név] & ""),[tSzemélyek20230101].[Szint 4 szervezeti egység név] & ""),""),"Budapest Főváros Kormányhivatala ","BFKH ") & "", [Szint 5 szervezeti egység név] & "";

#/#/#/
lkTTvége01
#/#/
SELECT Year(IIf(dtÁtal([Tartós távollét vége])=1,dtÁtal([Tartós távollét tervezett vége]),dtÁtal([Tartós távollét vége]))) AS VégeÉv, Month(IIf(dtÁtal([Tartós távollét vége])=1,dtÁtal([Tartós távollét tervezett vége]),dtÁtal([Tartós távollét vége]))) AS VégeHó, 1 AS Létszám, lkSzemélyek.Azonosító, IIf(dtÁtal([Tartós távollét vége])=1,dtÁtal([Tartós távollét tervezett vége]),dtÁtal([Tartós távollét vége])) AS Dátum
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null) AND ((lkSzemélyek.[Tartós távollét típusa]) Is Not Null));

#/#/#/
lkTTvége012024
#/#/
SELECT lkTTvége01.VégeHó, 0 AS 2026_év, lkTTvége01.Létszám AS 2024_év, 0 AS 2025_év
FROM lkTTvége01
WHERE (((lkTTvége01.Dátum) Between #1/1/2024# And #12/31/2024#));

#/#/#/
lkTTvége012025
#/#/
SELECT lkTTvége01.VégeHó, 0 AS 2026_év, 0 AS 2024_év, lkTTvége01.Létszám AS 2025_év
FROM lkTTvége01
WHERE (((lkTTvége01.Dátum) Between #1/1/2025# And #12/31/2025#));

#/#/#/
lkTTvége012026
#/#/
SELECT lkTTvége01.VégeHó, lkTTvége01.Létszám AS 2026_év, 0 AS 2024_év, 0 AS 2025_év
FROM lkTTvége01
WHERE (((lkTTvége01.Dátum) Between #1/1/2026# And #12/31/2026#));

#/#/#/
lkTTvége02
#/#/
SELECT *
FROM lkTTvége012026
UNION all
SELECT *
FROM lkTTvége012024
UNION ALL SELECT *
FROM lkTTvége012025;

#/#/#/
lkTTvége03
#/#/
SELECT tHónapok.hónap AS [Tartós távollét vége], Sum(lkTTvége02.[2024_év]) AS [2024 év], Sum(lkTTvége02.[2025_év]) AS [2025 év], Sum([2026_év]) AS [2026 év]
FROM tHónapok INNER JOIN lkTTvége02 ON tHónapok.Azonosító = lkTTvége02.VégeHó
GROUP BY tHónapok.hónap, lkTTvége02.VégeHó
ORDER BY lkTTvége02.VégeHó;

#/#/#/
lkÚjBelépőKépzés
#/#/
SELECT (Select count(Tmp.Azonosító) From lkSzemélyek as Tmp Where Tmp.[Jogviszony típusa / jogviszony típus]<=lkSzemélyek.[Jogviszony típusa / jogviszony típus] and Tmp.[Jogviszony kezdete (belépés dátuma)]<=lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] And Tmp.[Dolgozó teljes neve]<=lkSzemélyek.[Dolgozó teljes neve]) AS Sorszám, lkSzemélyek.[Jogviszony típusa / jogviszony típus] AS Jogviszony, lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS Belépés, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.Főosztály, lkSzemélyek.[Hivatali email] AS [E-mail cím], lkSzemélyek.Adójel AS [Adóazonosító jel], [Születési hely] & ", " & [Születési idő] AS [Születési hely dátum], lkSzemélyek.[Anyja neve], lkSzemélyek.[TAJ szám], lkKilépők.[Jogviszony megszűnésének, megszüntetésének időpontja], lkSzemélyek.[Jogviszony vége (kilépés dátuma)] AS Kilépés, lkSzemélyek.[Jogfolytonos idő kezdete], lkSzemélyek.[Szerződés/Kinevezés - próbaidő vége], lkSzemélyek.Nyugdíjas, lkSzemélyek.[Nyugdíj típusa], lkSzemélyek.[Nyugdíjas korú továbbfoglalkoztatási engedéllyel rendelkezik]
FROM lkKilépők RIGHT JOIN lkSzemélyek ON lkKilépők.Adóazonosító = lkSzemélyek.[Adóazonosító jel]
WHERE (((lkSzemélyek.[Jogviszony típusa / jogviszony típus])="Kormányzati szolgálati jogviszony" Or (lkSzemélyek.[Jogviszony típusa / jogviszony típus])="Munkaviszony") AND ((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)])>=#11/1/2022#) AND ((lkSzemélyek.[Jogviszony vége (kilépés dátuma)])>="#2023. 05. 15.#" Or (lkSzemélyek.[Jogviszony vége (kilépés dátuma)]) Is Null))
ORDER BY lkSzemélyek.[Jogviszony típusa / jogviszony típus], lkSzemélyek.[Jogviszony kezdete (belépés dátuma)], lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkUtolsóBesorolás
#/#/
SELECT lkBesorolásiEredményadatok.*
FROM lkBesorolásiEredményadatok
WHERE (((lkBesorolásiEredményadatok.[Változás dátuma])=(select max(a.[Változás dátuma]) from lkBesorolásiEredményadatok as a where a.[Adóazonosító jel] = lkBesorolásiEredményadatok.[Adóazonosító jel])));

#/#/#/
lkUtolsóBesorolásAktíve
#/#/
SELECT lkUtolsóBesorolás.[Adóazonosító jel], lkSzemélyek.[Dolgozó teljes neve]
FROM lkUtolsóBesorolás INNER JOIN lkSzemélyek ON lkUtolsóBesorolás.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely"));

#/#/#/
lkUtónevek
#/#/
SELECT UtónevekBesorolásiból.Keresztnév INTO tUtónevek
FROM (SELECT  ffsplit([Utónév]," ",1) AS Keresztnév
FROM lkBesorolásiEredményadatok
UNION
SELECT  ffsplit([Utónév]," ",2) AS Kif1
FROM lkBesorolásiEredményadatok)  AS UtónevekBesorolásiból;

#/#/#/
lkUtónevekGyakorisága
#/#/
SELECT Találatok.Keresztnév, Count(lkSzemélyek.[Adóazonosító jel]) AS [CountOfAdóazonosító jel]
FROM (SELECT [Keresztnév], * FROM lkSzemélyek INNER JOIN tUtónevek ON [lkSzemélyek].[Dolgozó Teljes Neve] like "* "&[tUtónevek].[Keresztnév]&" *")  AS Találatok
GROUP BY Találatok.Keresztnév;

#/#/#/
lkUtónevekNemekkel
#/#/
SELECT UtónevekBesorolásiból.Keresztnév, UtónevekBesorolásiból.Neme INTO tUtónevekNemekkel
FROM (SELECT ffsplit([Utónév]," ",1) AS Keresztnév, lkSzemélyek.Neme
FROM lkSzemélyek RIGHT JOIN lkBesorolásiEredményadatok ON lkSzemélyek.[Adóazonosító jel] = lkBesorolásiEredményadatok.[Adóazonosító jel]
UNION
SELECT ffsplit([Utónév]," ",2) AS Keresztnév, lkSzemélyek.Neme
FROM lkSzemélyek RIGHT JOIN lkBesorolásiEredményadatok ON lkSzemélyek.[Adóazonosító jel] = lkBesorolásiEredményadatok.[Adóazonosító jel]
)  AS UtónevekBesorolásiból;

#/#/#/
lkUtónévtárbanNemSzereplőUtónevek
#/#/
SELECT tUtónevek.Keresztnév, Right([Keresztnév],2)="né" AS Kif1
FROM tUtónevek LEFT JOIN tÖsszesUtónév ON tUtónevek.Keresztnév = tÖsszesUtónév.Utónév
WHERE (((tÖsszesUtónév.Utónév) Is Null) AND ((Right([Keresztnév],2)="né")=False));

#/#/#/
lkÜresÁlláshelyek
#/#/
SELECT lkJárásiKormányKözpontosítottUnió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], Replace([Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH") AS [Főosztály\Hivatal], lkJárásiKormányKözpontosítottUnió.[Álláshely azonosító], lkJárásiKormányKözpontosítottUnió.[Besorolási fokozat megnevezése:], lkJárásiKormányKözpontosítottUnió.Jelleg, lkJárásiKormányKözpontosítottUnió.[Születési év \ üres állás] AS Mező4, lkJárásiKormányKözpontosítottUnió.[Besorolási fokozat kód:], lkJárásiKormányKözpontosítottUnió.Kinevezés AS [Megüresedés dátuma], DateDiff("m",[Kinevezés],Now()) AS [Megüresedéstől eltelt hónapok], TextToMD5Hex([Álláshely azonosító]) AS Hash
FROM lkJárásiKormányKözpontosítottUnió
WHERE (((lkJárásiKormányKözpontosítottUnió.[Születési év \ üres állás]) Like "üres*"))
ORDER BY Bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]);

#/#/#/
lkÜresÁlláshelyek_Alaplétszám
#/#/
SELECT Unió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], [Szint5 - leírás] & [Szint6 - leírás] AS [Főosztály\Hivatal], Unió.[Álláshely azonosító], Unió.[Besorolási fokozat megnevezése:]
FROM tSzervezeti RIGHT JOIN (SELECT [Álláshely azonosító], Mező4, [Besorolási fokozat megnevezése:], [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], [Besorolási fokozat kód:]                       FROM Járási_állomány                       WHERE [Besorolási fokozat kód:] like "ÜÁ*"           UNION SELECT [Álláshely azonosító], Mező4, [Besorolási fokozat megnevezése:], [ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], [Besorolási fokozat kód:]                       FROM Kormányhivatali_állomány                       WHERE (((Kormányhivatali_állomány.[Besorolási fokozat kód:]) like "ÜÁ*"))    )  AS Unió ON tSzervezeti.[Szervezetmenedzsment kód] = Unió.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]
ORDER BY Bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]);

#/#/#/
lkÜresÁlláshelyek001
#/#/
SELECT lkJárásiKormányKözpontosítottUnió.[Járási Hivatal] AS [Főosztály\Hivatal], lkJárásiKormányKözpontosítottUnió.Osztály, lkJárásiKormányKözpontosítottUnió.[Álláshely azonosító], lkJárásiKormányKözpontosítottUnió.[Besorolási fokozat megnevezése:], lkHaviJelentésHatálya.hatálya
FROM lkJárásiKormányKözpontosítottUnió, lkHaviJelentésHatálya
WHERE (((lkJárásiKormányKözpontosítottUnió.[Születési év \ üres állás]) Like "üres*"));

#/#/#/
lkÜresÁlláshelyek002
#/#/
SELECT IIf([Megyei szint VAGY Járási Hivatal]="megyei szint",[Mező5],[Megyei szint VAGY Járási Hivatal]) AS Főosztály, lkBelépőkTeljes.Mező6 AS Osztály, lkBelépőkTeljes.[Álláshely azonosító], lkBelépőkTeljes.[Besorolási fokozat megnevezése:], lkBelépőkTeljes.[Jogviszony kezdő dátuma]
FROM lkBelépőkTeljes
WHERE (((lkBelépőkTeljes.[Jogviszony kezdő dátuma]) Between Date() And IIf(Day(Now()) Between 2 And 15,DateSerial(Year(Date()),Month(Date()),15),DateSerial(Year(Date()),Month(Date())+1,1))));

#/#/#/
lkÜresÁlláshelyek003
#/#/
SELECT tKilépőkUnió.Főosztály, tKilépőkUnió.Osztály, tKilépőkUnió.[Álláshely azonosító], tKilépőkUnió.[Besorolási fokozat megnevezése:], tKilépőkUnió.[Jogviszony megszűnésének, megszüntetésének időpontja]
FROM tKilépőkUnió
WHERE (((tKilépőkUnió.[Jogviszony megszűnésének, megszüntetésének időpontja]) Between Date() And IIf(Day(Now()) Between 2 And 15,DateSerial(Year(Date()),Month(Date()),15),DateSerial(Year(Date()),Month(Date())+1,1))));

#/#/#/
lkÜresÁlláshelyek004
#/#/
SELECT IIf([lkÜresÁlláshelyek002].[Főosztály] Is Null,[lkÜresÁlláshelyek001].[Főosztály\Hivatal],[lkÜresÁlláshelyek002].[Főosztály]) AS Főosztálya, IIf([lkÜresÁlláshelyek002].[osztály] Is Null,[lkÜresÁlláshelyek001].[Osztály],[lkÜresÁlláshelyek002].[osztály]) AS Osztálya, IIf([lkÜresÁlláshelyek002].[Álláshely azonosító] Is Null,[lkÜresÁlláshelyek001].[Álláshely azonosító],[lkÜresÁlláshelyek002].[Álláshely azonosító]) AS Álláshely, IIf([lkÜresÁlláshelyek002].[Besorolási fokozat megnevezése:] Is Null,[lkÜresÁlláshelyek001].[Besorolási fokozat megnevezése:],[lkÜresÁlláshelyek002].[Besorolási fokozat megnevezése:]) AS Besorolás, IIf([lkÜresÁlláshelyek002].[Álláshely azonosító] Is Null,[lkÜresÁlláshelyek001].[hatálya],[lkÜresÁlláshelyek002].[Jogviszony kezdő dátuma]) AS Dátum
FROM lkÜresÁlláshelyek001 LEFT JOIN lkÜresÁlláshelyek002 ON lkÜresÁlláshelyek001.[Álláshely azonosító] = lkÜresÁlláshelyek002.[Álláshely azonosító]
WHERE (((lkÜresÁlláshelyek002.[Álláshely azonosító]) Is Null));

#/#/#/
lkÜresÁlláshelyek005
#/#/
SELECT DISTINCT [004És002].Főosztálya, [004És002].Osztálya, [004És002].Álláshely, [004És002].Dátum, [004És002].Besorolás, TextToMD5Hex([Álláshely]) AS Hash, *
FROM (SELECT *
FROM lkÜresÁlláshelyek004
UNION SELECT *
FROM  lkÜresÁlláshelyek003)  AS 004És002
ORDER BY [004És002].Dátum;

#/#/#/
lkÜresÁlláshelyekÁllapotfelmérő
#/#/
SELECT lkÜresÁlláshelyek.[Főosztály\Hivatal], lkÜresÁlláshelyek.[Álláshely azonosító], lkÜresÁlláshelyek.[Besorolási fokozat megnevezése:], IIf(dtátal([DeliveredDate])=0,"",dtátal([DeliveredDate])) AS [Legutóbbi állapot ideje], Nz([VisszajelzésSzövege],"Nincs folyamatban") AS [Legutóbbi állapot]
FROM (tVisszajelzésTípusok RIGHT JOIN lkÜzenetekVisszajelzések ON tVisszajelzésTípusok.VisszajelzésKód = lkÜzenetekVisszajelzések.VisszajelzésKód) RIGHT JOIN lkÜresÁlláshelyek ON lkÜzenetekVisszajelzések.Hash = lkÜresÁlláshelyek.Hash
WHERE (((lkÜzenetekVisszajelzések.DeliveredDate)=(Select Max([DeliveredDate]) FROM [lkÜzenetekVisszajelzések] as Tmp Where [lkÜzenetekVisszajelzések].Hash=Tmp.hash) Or (lkÜzenetekVisszajelzések.DeliveredDate) Is Null))
ORDER BY lkÜresÁlláshelyek.[Főosztály\Hivatal], lkÜresÁlláshelyek.[Álláshely azonosító];

#/#/#/
lkÜresÁlláshelyekEredetiÁllapot
#/#/
SELECT 182 AS azÜzenet, TextToMD5Hex([ÁNYR]) AS Hash, tVisszajelzésTípusok.VisszajelzésKód
FROM tVisszajelzésTípusok RIGHT JOIN ÁnyrÉsVálaszok240815 ON tVisszajelzésTípusok.VisszajelzésSzövege = ÁnyrÉsVálaszok240815.Állapot
WHERE (((tVisszajelzésTípusok.VisszajelzésKód) Is Not Null));

#/#/#/
lkÜresÁlláshelyekÉrkezettVisszajelzésekFőosztályonként
#/#/
SELECT Számlálás.[Főosztály\Hivatal], Számlálás.[Érkezett válasz], Számlálás.[Nem érkezett válasz], Számlálás.Összesen, *
FROM (SELECT lkÜresÁlláshelyekÁllapotfelmérő.[Főosztály\Hivatal], Sum(IIf([Legutóbbi állapot ideje]=DateSerial(Year(Now()),Month(Now()),Day(Now())),1,0)) AS [Érkezett válasz], Sum(IIf([Legutóbbi állapot ideje]<>DateSerial(Year(Now()),Month(Now()),Day(Now())),1,0)) AS [Nem érkezett válasz], Sum(1) as Összesen
FROM lkÜresÁlláshelyekÁllapotfelmérő
GROUP BY lkÜresÁlláshelyekÁllapotfelmérő.[Főosztály\Hivatal])  AS Számlálás
WHERE (((Számlálás.[Érkezett válasz])=0));

#/#/#/
lküresÁlláshelyekHaviból01
#/#/
SELECT lkJárásiKormányKözpontosítottUnió.[Álláshely azonosító], lkJárásiKormányKözpontosítottUnió.Kinevezés, IIf([Születési év \ üres állás]="üres állás",True,False) AS Üres, IIf([Kinevezés]<Date(),True,False) AS Korábbi, IIf([Kinevezés]>Date(),True,False) AS Későbbi, [Kinevezés]=Date() AS Mai, Switch([Üres] And [Korábbi],"üres",[üres] And [későbbi],"betöltött",[üres] And [mai],"üres",Not [üres] And [Mai],"betöltött",Not [üres] And [korábbi],"betöltött",Not [üres] And [későbbi],"üres") AS Állapot
FROM lkJárásiKormányKözpontosítottUnió;

#/#/#/
lkÜresÁlláshelyekNemVezető
#/#/
SELECT lkÜresÁlláshelyek.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkÜresÁlláshelyek.[Főosztály\Hivatal], lkÜresÁlláshelyek.[Álláshely azonosító], lkÜresÁlláshelyek.[Besorolási fokozat megnevezése:], lkÜresÁlláshelyek.[Besorolási fokozat kód:], lkÜresÁlláshelyek.Jelleg, lkÜresÁlláshelyek.[Megüresedéstől eltelt hónapok]
FROM lkÜresÁlláshelyek
WHERE (((lkÜresÁlláshelyek.[Besorolási fokozat kód:]) Not Like "*Ov*" And (lkÜresÁlláshelyek.[Besorolási fokozat kód:]) Not Like "*Jhv*" And (lkÜresÁlláshelyek.[Besorolási fokozat kód:]) Not Like "*ig." And (lkÜresÁlláshelyek.[Besorolási fokozat kód:])<>"Fsp."));

#/#/#/
lkÜresÁlláshelyekNemVezető_besorolásonkéntimegoszlás
#/#/
SELECT lkÜresÁlláshelyekNemVezető.[Besorolási fokozat megnevezése:], Count(lkÜresÁlláshelyekNemVezető.[Álláshely azonosító]) AS [Üres álláshelyek száma]
FROM lkÜresÁlláshelyekNemVezető
GROUP BY lkÜresÁlláshelyekNemVezető.[Besorolási fokozat megnevezése:], lkÜresÁlláshelyekNemVezető.[Besorolási fokozat kód:]
ORDER BY lkÜresÁlláshelyekNemVezető.[Besorolási fokozat kód:];

#/#/#/
lkÜresÁlláshelyekNemVezető_szerveztiágankéntimegoszlás
#/#/
SELECT IIf(InStr(1,[Főosztály\Hivatal],"kerületi"),"Kerületi hivatalok","Főosztályok") AS Ág, Count(lkÜresÁlláshelyekNemVezető.[Álláshely azonosító]) AS [Üres álláshelyek száma]
FROM lkÜresÁlláshelyekNemVezető
GROUP BY IIf(InStr(1,[Főosztály\Hivatal],"kerületi"),"Kerületi hivatalok","Főosztályok")
ORDER BY Count(lkÜresÁlláshelyekNemVezető.[Álláshely azonosító]) DESC;

#/#/#/
lkÜresÁlláshelyekStatisztika
#/#/
SELECT Statisztika.Jelleg, Statisztika.[CountOfÁlláshely azonosító] AS Létszám
FROM (SELECT "Összes:" AS Jelleg, Count(lkÜresÁlláshelyek.[Álláshely azonosító]) AS [CountOfÁlláshely azonosító], 1 AS Sorszám
FROM lkÜresÁlláshelyekÁllapotfelmérő INNER JOIN (lkÜresÁlláshelyek INNER JOIN tBesorolás_átalakító ON lkÜresÁlláshelyek.[Besorolási fokozat kód:] = tBesorolás_átalakító.[Az álláshely jelölése]) ON lkÜresÁlláshelyekÁllapotfelmérő.[Álláshely azonosító] = lkÜresÁlláshelyek.[Álláshely azonosító]

union SELECT "Központosított:" AS Jelleg, Count(lkÜresÁlláshelyek.[Álláshely azonosító]) AS [CountOfÁlláshely azonosító], 2 AS Sorszám
FROM lkÜresÁlláshelyekÁllapotfelmérő INNER JOIN (lkÜresÁlláshelyek INNER JOIN tBesorolás_átalakító ON lkÜresÁlláshelyek.[Besorolási fokozat kód:] = tBesorolás_átalakító.[Az álláshely jelölése]) ON lkÜresÁlláshelyekÁllapotfelmérő.[Álláshely azonosító] = lkÜresÁlláshelyek.[Álláshely azonosító]
WHERE (((lkÜresÁlláshelyek.Jelleg)="K"))

union SELECT "Alaplétszám:" AS Jelleg, Count(lkÜresÁlláshelyek.[Álláshely azonosító]) AS [CountOfÁlláshely azonosító], 3 AS Sorszám
FROM lkÜresÁlláshelyekÁllapotfelmérő INNER JOIN (lkÜresÁlláshelyek INNER JOIN tBesorolás_átalakító ON lkÜresÁlláshelyek.[Besorolási fokozat kód:] = tBesorolás_átalakító.[Az álláshely jelölése]) ON lkÜresÁlláshelyekÁllapotfelmérő.[Álláshely azonosító] = lkÜresÁlláshelyek.[Álláshely azonosító]
WHERE (((lkÜresÁlláshelyek.jelleg)="A"))

union SELECT "Vezetők:" AS Jelleg, Count(lkÜresÁlláshelyek.[Álláshely azonosító]) AS [CountOfÁlláshely azonosító], 4 AS Sorszám
FROM lkÜresÁlláshelyekÁllapotfelmérő INNER JOIN (lkÜresÁlláshelyek INNER JOIN tBesorolás_átalakító ON lkÜresÁlláshelyek.[Besorolási fokozat kód:] = tBesorolás_átalakító.[Az álláshely jelölése]) ON lkÜresÁlláshelyekÁllapotfelmérő.[Álláshely azonosító] = lkÜresÁlláshelyek.[Álláshely azonosító]
WHERE (((tBesorolás_átalakító.Vezető)=Yes) AND ((lkÜresÁlláshelyek.Jelleg)="A"))

union SELECT "Netto üres:" AS Jelleg, Count(lkÜresÁlláshelyek.[Álláshely azonosító]) AS [CountOfÁlláshely azonosító], 5 AS Sorszám
FROM lkÜresÁlláshelyekÁllapotfelmérő INNER JOIN (lkÜresÁlláshelyek INNER JOIN tBesorolás_átalakító ON lkÜresÁlláshelyek.[Besorolási fokozat kód:] = tBesorolás_átalakító.[Az álláshely jelölése]) ON lkÜresÁlláshelyekÁllapotfelmérő.[Álláshely azonosító] = lkÜresÁlláshelyek.[Álláshely azonosító]
WHERE (((lkÜresÁlláshelyekÁllapotfelmérő.[Legutóbbi állapot])="Nincs folyamatban" Or (lkÜresÁlláshelyekÁllapotfelmérő.[Legutóbbi állapot])="Pályázat kiírva")) )  AS Statisztika
ORDER BY Statisztika.Sorszám;

#/#/#/
lkÜresÁlláshelyekVezető
#/#/
SELECT lkÜresÁlláshelyek.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkÜresÁlláshelyek.[Főosztály\Hivatal], lkÁlláshelyek.Osztály, lkÜresÁlláshelyek.[Álláshely azonosító], lkÁlláshelyek.[Álláshely besorolási kategóriája], lkÁlláshelyek.rang, lkÜresÁlláshelyek.Jelleg, lkÁlláshelyek.[Álláshely státusza], lkÁlláshelyek.[Hatályosság kezdete] AS [Mióta üres ÁNYR], lkÜresÁlláshelyek.[Megüresedés dátuma] AS [Mióta üres Nexon], Date()-[Hatályosság kezdete] AS [Hány napja üres ÁNYR], Date()-[Hatályosság kezdete] AS [Hány napja üres NEXON]
FROM lkÜresÁlláshelyek RIGHT JOIN lkÁlláshelyek ON lkÜresÁlláshelyek.[Álláshely azonosító] = lkÁlláshelyek.[Álláshely azonosító]
WHERE (((lkÁlláshelyek.[Álláshely státusza])="betöltetlen - tartósan távollévő" Or (lkÁlláshelyek.[Álláshely státusza])="betöltetlen") AND ((lkÜresÁlláshelyek.[Besorolási fokozat kód:]) Like "*Ov*" Or (lkÜresÁlláshelyek.[Besorolási fokozat kód:]) Like "*Jhv*" Or (lkÜresÁlláshelyek.[Besorolási fokozat kód:]) Like "*ig." Or (lkÜresÁlláshelyek.[Besorolási fokozat kód:])="fsp."));

#/#/#/
lkÜresÁlláshelyekVisszajelzésekStatisztika0
#/#/
SELECT lkÜresÁlláshelyekÁllapotfelmérő.[Főosztály\Hivatal], Sum(IIf([Legutóbbi állapot ideje]>=DateAdd("d",-5,dtÁtal(Now())),1,0)) AS [Érkezett válasz], Sum(IIf(Nz([Legutóbbi állapot ideje],0)<DateAdd("d",-5,dtÁtal(Now())),1,0)) AS [Nem érkezett válasz], Sum(1) AS Összesen
FROM lkÜresÁlláshelyekÁllapotfelmérő
GROUP BY lkÜresÁlláshelyekÁllapotfelmérő.[Főosztály\Hivatal];

#/#/#/
lkÜresÁlláshelyekVisszajelzésekStatisztikaA
#/#/
SELECT Switch([érkezett válasz]=0,"Egy válasz sem érkezett",[Érkezett válasz]<[Összesen],"Még nem érkezett meg minden válasz",[Érkezett válasz]=[Összesen],"Minden válasz megérkezett") AS Kategória, Sum(1) AS db
FROM lkÜresÁlláshelyekVisszajelzésekStatisztika0 AS Számlálás
GROUP BY Switch([érkezett válasz]=0,"Egy válasz sem érkezett",[Érkezett válasz]<[Összesen],"Még nem érkezett meg minden válasz",[Érkezett válasz]=[Összesen],"Minden válasz megérkezett");

#/#/#/
lkÜresÁlláshelyekVisszajelzésekStatisztikaB
#/#/
SELECT Válaszok.Kategória AS Kategória, Válaszok.[Nem érkezett válasz] AS Érték
FROM (SELECT 1 AS Sorszám, "Még meg nem érkezett válaszok száma" AS Kategória, Sum(lkÜresÁlláshelyekVisszajelzésekStatisztika0.[Nem érkezett válasz]) AS [Nem érkezett válasz]
FROM lkÜresÁlláshelyekVisszajelzésekStatisztika0
GROUP BY "Még meg nem érkezett válaszok száma"
UNION SELECT 2 AS Sorszám, "Beérkezett válaszok száma" AS Kategória, Sum(lkÜresÁlláshelyekVisszajelzésekStatisztika0.[Érkezett válasz]) as [Érkezett válasz]
FROM lkÜresÁlláshelyekVisszajelzésekStatisztika0
GROUP BY "Beérkezett válaszok száma"
 )  AS Válaszok
ORDER BY Válaszok.Sorszám;

#/#/#/
lkÜresÁlláshelyJelentés
#/#/
SELECT bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]) AS BFKH, lkJárásiKormányKözpontosítottUnió.[Álláshely azonosító] AS ÁNYR, lkJárásiKormányKözpontosítottUnió.[járási hivatal] AS [szervezeti egység/kerületi hivatal], lkJárásiKormányKözpontosítottUnió.Osztály, IIf([Születési év \ üres állás]="üres állás","üres","") AS [Nexon szerint], lkJárásiKormányKözpontosítottUnió.[Besorolási fokozat megnevezése:] AS Besorolás, lkÜresÁlláshelyekExcel.Feladatkör, lkÜresÁlláshelyekExcel.Állapot
FROM lkÜresÁlláshelyekExcel RIGHT JOIN lkJárásiKormányKözpontosítottUnió ON lkÜresÁlláshelyekExcel.státusz = lkJárásiKormányKözpontosítottUnió.[Álláshely azonosító]
WHERE (((IIf([Születési év \ üres állás]="üres állás","üres",""))="üres"))
ORDER BY bfkh([ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ]);

#/#/#/
lkÜresÁlláshelyKimutatáshoz
#/#/
SELECT Álláshelyek.[Álláshely azonosító], IIf(Nz([Dolgozó teljes neve],"")="","Betöltetlen","Betöltött") AS Állapot, lkSzemélyek.[Dolgozó teljes neve] AS [Betöltő neve], lkSzemélyek.[Jogviszony kezdete (belépés dátuma)] AS Belépés
FROM lkSzemélyek RIGHT JOIN Álláshelyek ON lkSzemélyek.[Státusz kódja]=Álláshelyek.[Álláshely azonosító]
ORDER BY Álláshelyek.[Álláshely azonosító];

#/#/#/
lkÜresÁllásLegutolsóVisszajelzés
#/#/
SELECT lkÜresÁlláshelyek.[Álláshely azonosító], Nz([VisszajelzésSzövege],"") AS [Legutóbbi állapot]
FROM (tVisszajelzésTípusok RIGHT JOIN lkÜzenetekVisszajelzések ON tVisszajelzésTípusok.VisszajelzésKód = lkÜzenetekVisszajelzések.VisszajelzésKód) RIGHT JOIN lkÜresÁlláshelyek ON lkÜzenetekVisszajelzések.Hash = lkÜresÁlláshelyek.Hash
WHERE (((lkÜzenetekVisszajelzések.DeliveredDate)=(Select Max([DeliveredDate]) FROM [lkÜzenetekVisszajelzések] as Tmp Where [lkÜzenetekVisszajelzések].Hash=Tmp.hash) Or (lkÜzenetekVisszajelzések.DeliveredDate) Is Null))
ORDER BY lkÜresÁlláshelyek.[Álláshely azonosító];

#/#/#/
lkÜresSzervezetiEgységek
#/#/
SELECT tSzervezeti.OSZLOPOK, tSzervezeti.[Betöltött státuszok száma (db)], tSzervezeti.[Betöltetlen státuszok száma (db)]
FROM tSzervezeti
WHERE (((tSzervezeti.OSZLOPOK) Like "Szervezeti egység összesen*") AND ((tSzervezeti.[Betöltött státuszok száma (db)])=0));

#/#/#/
lkÜzenetekVisszajelzések
#/#/
SELECT tBejövőVisszajelzések.*, tBejövőÜzenetek.*
FROM tBejövőÜzenetek INNER JOIN tBejövőVisszajelzések ON tBejövőÜzenetek.azÜzenet = tBejövőVisszajelzések.azÜzenet;

#/#/#/
lkÜzenetekVisszajelzések01
#/#/
SELECT curr.Hash, curr.SenderEmailAddress, curr.DeliveredDate, tVisszajelzésTípusok.VisszajelzésKód, tVisszajelzésTípusok.VisszajelzésSzövege, curr.Hatály
FROM lkÜzenetekVisszajelzések AS curr INNER JOIN tVisszajelzésTípusok ON curr.VisszajelzésKód = tVisszajelzésTípusok.VisszajelzésKód
WHERE curr.Hash = [AzonosítóHASH]
    AND (
        curr.SenderEmailAddress <> 
        (SELECT TOP 1 prev.SenderEmailAddress 
         FROM lkÜzenetekVisszajelzések AS prev
         WHERE prev.Hash = curr.Hash 
           AND prev.azVisszajelzés < curr.azVisszajelzés
         ORDER BY prev.azVisszajelzés DESC)
        OR curr.VisszajelzésKód <> 
        (SELECT TOP 1 prev.VisszajelzésKód 
         FROM lkÜzenetekVisszajelzések AS prev
         WHERE prev.Hash = curr.Hash 
           AND prev.azVisszajelzés < curr.azVisszajelzés
         ORDER BY prev.azVisszajelzés DESC)
        OR curr.Hatály <> 
        (SELECT TOP 1 prev.Hatály 
         FROM lkÜzenetekVisszajelzések AS prev
         WHERE prev.Hash = curr.Hash 
           AND prev.azVisszajelzés < curr.azVisszajelzés
         ORDER BY prev.azVisszajelzés DESC)
        OR (SELECT TOP 1 prev.azVisszajelzés 
            FROM lkÜzenetekVisszajelzések AS prev
            WHERE prev.Hash = curr.Hash 
              AND prev.azVisszajelzés < curr.azVisszajelzés
            ORDER BY prev.azVisszajelzés DESC) IS NULL
    )
ORDER BY curr.Hash, curr.DeliveredDate;

#/#/#/
lkVárosKerületenkéntiFőosztályonkéntiLétszám01
#/#/
SELECT lkVárosOldalankéntiLétszám01.Főosztály, lkVárosOldalankéntiLétszám01.Kerület, Sum(lkVárosOldalankéntiLétszám01.fő) AS Létszám
FROM lkVárosOldalankéntiLétszám01
GROUP BY lkVárosOldalankéntiLétszám01.Főosztály, lkVárosOldalankéntiLétszám01.Kerület;

#/#/#/
lkVárosKerületenkéntiFőosztályonkéntiLétszám02
#/#/
TRANSFORM Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám01.Létszám) AS SumOfLétszám
SELECT lkVárosKerületenkéntiFőosztályonkéntiLétszám01.Főosztály
FROM lkVárosKerületenkéntiFőosztályonkéntiLétszám01
GROUP BY lkVárosKerületenkéntiFőosztályonkéntiLétszám01.Főosztály
PIVOT lkVárosKerületenkéntiFőosztályonkéntiLétszám01.Kerület in (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,"egyéb");

#/#/#/
lkVárosKerületenkéntiFőosztályonkéntiLétszám03
#/#/
SELECT "Összesen:" AS Főosztály, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[1]) AS SumOf1, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[2]) AS SumOf2, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[3]) AS SumOf3, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[4]) AS SumOf4, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[5]) AS SumOf5, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[6]) AS SumOf6, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[7]) AS SumOf7, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[8]) AS SumOf8, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[9]) AS SumOf9, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[10]) AS SumOf10, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[11]) AS SumOf11, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[12]) AS SumOf12, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[13]) AS SumOf13, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[14]) AS SumOf14, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[15]) AS SumOf15, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[16]) AS SumOf16, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[17]) AS SumOf17, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[18]) AS SumOf18, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[19]) AS SumOf19, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[20]) AS SumOf20, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[21]) AS SumOf21, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[22]) AS SumOf22, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.[23]) AS SumOf23, Sum(lkVárosKerületenkéntiFőosztályonkéntiLétszám02.egyéb) AS SumOfegyéb
FROM lkVárosKerületenkéntiFőosztályonkéntiLétszám02
GROUP BY "Összesen:";

#/#/#/
lkVárosKerületenkéntiFőosztályonkéntiLétszám04
#/#/
SELECT *
FROM (SELECT 1 as sor, lkVárosKerületenkéntiFőosztályonkéntiLétszám02.*
FROM lkVárosKerületenkéntiFőosztályonkéntiLétszám02
UNION
SELECT 2 as sor, lkVárosKerületenkéntiFőosztályonkéntiLétszám03.*
FROM  lkVárosKerületenkéntiFőosztályonkéntiLétszám03)  AS 02ÉS03;

#/#/#/
lkVárosKerületenkéntiFőosztályonkéntiLétszám05
#/#/
SELECT lkVárosKerületenkéntiFőosztályonkéntiLétszám04.*, lkFőosztályonkéntiBetöltöttLétszám.FőosztályiLétszám AS Összesen
FROM lkFőosztályonkéntiBetöltöttLétszám INNER JOIN lkVárosKerületenkéntiFőosztályonkéntiLétszám04 ON lkFőosztályonkéntiBetöltöttLétszám.Főosztály=lkVárosKerületenkéntiFőosztályonkéntiLétszám04.Főosztály;

#/#/#/
lkVárosKerületenkéntiLétszám
#/#/
SELECT lkVárosOldalankéntiLétszám01.Kerület, Sum(lkVárosOldalankéntiLétszám01.fő) AS SumOffő
FROM lkVárosOldalankéntiLétszám01
GROUP BY lkVárosOldalankéntiLétszám01.Kerület;

#/#/#/
lkVárosOldalankéntiFőosztályonkéntLétszám
#/#/
SELECT lkVárosOldalankéntiLétszám01.Oldal, lkVárosOldalankéntiLétszám01.Főosztály, Sum(lkVárosOldalankéntiLétszám01.fő) AS SumOffő
FROM lkVárosOldalankéntiLétszám01
GROUP BY lkVárosOldalankéntiLétszám01.Oldal, lkVárosOldalankéntiLétszám01.Főosztály;

#/#/#/
lkVárosOldalankéntiLétszám01
#/#/
SELECT Mid(Replace([FőosztályKód],"BFKH.1.",""),1,InStr(1,Replace([FőosztályKód],"BFKH.1.",""),".")-1) AS Sor, lkSzemélyek.Főosztály, lkSzemélyek.[Munkavégzés helye - cím], Irsz([Munkavégzés helye - cím])*1 AS irsz, kerület([irsz]) AS Kerület, IIf(Left([irsz],1)<>1,"Nem Budapest",IIf(Kerület([irsz]) Between 1 And 3 Or kerület([irsz]) Between 11 And 12 Or kerület([irsz])=22,"Buda","Pest")) AS Oldal, 1 AS fő
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY lkSzemélyek.Főosztály;

#/#/#/
lkVárosOldalankéntiLétszám02
#/#/
SELECT lkVárosOldalankéntiLétszám01.Oldal, Sum(lkVárosOldalankéntiLétszám01.fő) AS Létszám
FROM lkVárosOldalankéntiLétszám01
GROUP BY lkVárosOldalankéntiLétszám01.Oldal;

#/#/#/
lkVédőnők00
#/#/
SELECT tVédőnők.Adójel, tVédőnők.Dátum, tVédőnők.Védőnő, tVédőnők.[Vezető védőnő], tVédőnők.CsVSz, [tVédőnők].[Adójel] & "" AS Adóazonosító, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Jogviszony vége (kilépés dátuma)]
FROM tVédőnők INNER JOIN lkSzemélyek ON tVédőnők.Adójel = lkSzemélyek.Adójel;

#/#/#/
lkVédőnők01
#/#/
SELECT lkNépegészségügyiDolgozók.Adójel, "Budapest Főváros Kormányhivatala" AS Kormányhivatal, 0 AS Sorszám, lkNépegészségügyiDolgozók.Név, lkVédőnők00.Adóazonosító, lkNépegészségügyiDolgozók.[Születési év \ üres állás], lkNépegészségügyiDolgozók.[Megyei szint], lkNépegészségügyiDolgozók.Főosztály, lkNépegészségügyiDolgozók.Osztály, lkNépegészségügyiDolgozók.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkNépegészségügyiDolgozók.[Ellátott feladat], lkNépegészségügyiDolgozók.Kinevezés, lkNépegészségügyiDolgozók.[Feladat jellege: szakmai (SZ) / funkcionális (F) feladatellátás;], lkNépegészségügyiDolgozók.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ], lkNépegészségügyiDolgozók.[Heti munkaórák száma], lkNépegészségügyiDolgozók.[Betöltés aránya], lkNépegészségügyiDolgozók.[Besorolási fokozat kód:], lkNépegészségügyiDolgozók.[Besorolási fokozat megnevezése:], lkNépegészségügyiDolgozók.[Álláshely azonosító], lkNépegészségügyiDolgozók.[Havi illetmény], lkNépegészségügyiDolgozók.[Eu finanszírozott], lkNépegészségügyiDolgozók.[Illetmény forrása], lkNépegészségügyiDolgozók.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h], lkNépegészségügyiDolgozók.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], lkNépegészségügyiDolgozók.[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)], lkNépegészségügyiDolgozók.[Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis], lkNépegészségügyiDolgozók.[Ügyfélszolgálati munkatárs (1) ügyfélszolgálati háttér munkatárs], lkNépegészségügyiDolgozók.[Képesítést adó végzettség], IIf([Megyei szint]<>"Megyei szint",[Megyei szint],"") AS [Járási hivatal neve], lkVédőnők00.Védőnő, lkVédőnők00.[Vezető védőnő], lkVédőnők00.CsVSz
FROM lkVédőnők00 INNER JOIN lkNépegészségügyiDolgozók ON lkVédőnők00.Adóazonosító = lkNépegészségügyiDolgozók.Adóazonosító;

#/#/#/
lkVédőnők02
#/#/
SELECT lkVédőnők01.Adójel, lkVédőnők01.Kormányhivatal, (Select Count(Tmp.Adójel) From lkVédőnők01 as Tmp Where Tmp.Adójel<=lkVédőnők01.Adójel) AS Sorszám, lkVédőnők01.Név, lkVédőnők01.Adóazonosító, lkVédőnők01.[Születési év \ üres állás], lkVédőnők01.[Megyei szint], lkVédőnők01.Főosztály, lkVédőnők01.Osztály, lkVédőnők01.[ÁNYR SZERVEZETI EGYSÉG AZONOSÍTÓ], lkVédőnők01.[Ellátott feladat], lkVédőnők01.Kinevezés, lkVédőnők01.[Feladat jellege: szakmai (SZ) / funkcionális (F) feladatellátás;], lkVédőnők01.[Foglalkoztatási forma teljes (T) / részmunkaidős (R), nyugdíjas ], lkVédőnők01.[Heti munkaórák száma], lkVédőnők01.[Betöltés aránya], lkVédőnők01.[Besorolási fokozat kód:], lkVédőnők01.[Besorolási fokozat megnevezése:], lkVédőnők01.[Álláshely azonosító], lkVédőnők01.[Havi illetmény], lkVédőnők01.[Eu finanszírozott], lkVédőnők01.[Illetmény forrása], lkVédőnők01.[Garantált bérminimumban részesül (GB) / tartós távollévő nincs h], lkVédőnők01.[Tartós távollévő esetén a távollét jogcíme (CSED, GYED, GYES, Tp], lkVédőnők01.[Foglalkoztatás időtartama Határozatlan (HL) / Határozott (HT)], lkVédőnők01.[Legmagasabb iskolai végzettség 1=8 osztály; 2=érettségi; 3=főis], lkVédőnők01.[Ügyfélszolgálati munkatárs (1) ügyfélszolgálati háttér munkatárs], lkVédőnők01.[Képesítést adó végzettség], lkVédőnők01.[Járási hivatal neve], lkVédőnők01.Védőnő, lkVédőnők01.[Vezető védőnő], lkVédőnők01.CsVSz
FROM lkVédőnők01;

#/#/#/
lkVégzettségek
#/#/
SELECT [Dolgozó azonosító]*1 AS Adójel, tVégzettségek.*
FROM tVégzettségek;

#/#/#/
lkVégzettségekMaxSzáma
#/#/
SELECT Max(lkSzemélyekVégzettségeinekSzáma.VégzettségeinekASzáma) AS MaxOfVégzettségeinekASzáma
FROM lkSzemélyekVégzettségeinekSzáma;

#/#/#/
lkVégzettségÉsBesorolásÖsszeegyeztethetetlen
#/#/
SELECT lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.[Státusz kódja], lkSzemélyek.[Iskolai végzettség foka] AS Végzettség, lkSzemélyek.[Besorolási  fokozat (KT)] AS Besorolás, kt_azNexon_Adójel02.NLink
FROM lkSzemélyek INNER JOIN kt_azNexon_Adójel02 ON lkSzemélyek.Adójel = kt_azNexon_Adójel02.Adójel
WHERE (((lkSzemélyek.[Iskolai végzettség foka])="Szakközépiskola") AND ((lkSzemélyek.[Besorolási  fokozat (KT)])<>"Vezető-hivatalitanácsos") AND ((lkSzemélyek.[Státusz neve])="álláshely")) OR (((lkSzemélyek.[Iskolai végzettség foka])<>"Főiskolai vagy felsőfokú alapképzés (BA/BsC)okl." And (lkSzemélyek.[Iskolai végzettség foka])<>"Egyetemi /felsőfokú (MA/MsC) vagy osztatlan képz.") AND ((lkSzemélyek.[Besorolási  fokozat (KT)])="Vezető-hivatalifőtanácsos") AND ((lkSzemélyek.[Státusz neve])="álláshely"))
ORDER BY lkSzemélyek.BFKH, lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkVezetők
#/#/
SELECT DISTINCT lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.[Hivatali email], lkSzemélyek.[Hivatali telefon], lkSzemélyek.BFKH, lkSzemélyek.Besorolás2
FROM lkSzemélyek INNER JOIN tBesorolás_átalakító ON lkSzemélyek.Besorolás2 = tBesorolás_átalakító.Besorolási_fokozat
WHERE (((lkSzemélyek.[Státusz neve])="álláshely") AND ((tBesorolás_átalakító.Vezető)=Yes))
ORDER BY lkSzemélyek.BFKH;

#/#/#/
lkVezetőkIlletménye01
#/#/
SELECT DISTINCT lkSzemélyek.BFKH, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.Főosztály, lkSzemélyek.Osztály, lkSzemélyek.Besorolás2 AS Besorolás, lkSzemélyek.[Vezetői megbízás típusa], [Kerekített 100 %-os illetmény (eltérített)]*[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker]/40 AS [Bruttó illetmény]
FROM lkSzemélyek INNER JOIN tBesorolás_átalakító ON lkSzemélyek.Besorolás2 = tBesorolás_átalakító.Besorolási_fokozat
WHERE (((lkSzemélyek.[Státusz neve])="álláshely") AND ((tBesorolás_átalakító.Vezető)=Yes)) OR (((lkSzemélyek.[Vezetői megbízás típusa]) Is Not Null) AND ((lkSzemélyek.[Státusz neve])="álláshely")) OR (((lkSzemélyek.[Státusz neve])="álláshely") AND ((Left(Replace(Nü([feladatkör],0),"Lezárt_",""),2)*1) Between 11 And 14));

#/#/#/
lkVezetőkIlletménye02
#/#/
SELECT lkVezetőkIlletménye01.[Dolgozó teljes neve] AS [Dolgozó teljes neve], lkVezetőkIlletménye01.Főosztály AS Főosztály, lkVezetőkIlletménye01.Osztály AS Osztály, lkVezetőkIlletménye01.Besorolás AS Besorolás, lkVezetőkIlletménye01.[Vezetői megbízás típusa] AS [Vezetői megbízás típusa], lkVezetőkIlletménye01.[Bruttó illetmény] AS [Bruttó illetmény]
FROM lkVezetőkIlletménye01
ORDER BY lkVezetőkIlletménye01.BFKH;

#/#/#/
lkVezetőkSzakvizsgaHiány
#/#/
SELECT lkMindenVezető.Főosztály, lkMindenVezető.Osztály, lkMindenVezető.[Dolgozó teljes neve], lkMindenVezető.Besorolás2 AS [Besorolási fokozat], lkKözigazgatásiVizsga.[Vizsga típusa], lkKözigazgatásiVizsga.[Oklevél dátuma], lkKözigazgatásiVizsga.[Oklevél száma], lkKözigazgatásiVizsga.Mentesség, lkKözigazgatásiVizsga.[Vizsga letétel terv határideje], lkKözigazgatásiVizsga.[Vizsga letétel tény határideje]
FROM lkKözigazgatásiVizsga RIGHT JOIN lkMindenVezető ON lkKözigazgatásiVizsga.Adójel = lkMindenVezető.Adójel
WHERE (((lkKözigazgatásiVizsga.[Vizsga típusa])="közigazgatási szakvizsga" Or (lkKözigazgatásiVizsga.[Vizsga típusa]) Is Null) AND ((lkKözigazgatásiVizsga.[Oklevél száma]) Is Null Or (lkKözigazgatásiVizsga.[Oklevél száma])="") AND ((lkKözigazgatásiVizsga.Mentesség)=False Or (lkKözigazgatásiVizsga.Mentesség) Is Null));

#/#/#/
lkVezetőkTartósTávolléten
#/#/
SELECT lkSzemélyek.Főosztály AS Főosztály, lkSzemélyek.Osztály AS Osztály, lkSzemélyek.[Dolgozó teljes neve] AS Név, lkSzemélyek.Besorolás2 AS Besorolás, lkSzemélyek.[Vezetői beosztás megnevezése] AS Beosztás, lkSzemélyek.[Tartós távollét típusa] AS [Távollét típusa], kt_azNexon_Adójel02.NLink AS NLink
FROM kt_azNexon_Adójel02 RIGHT JOIN lkSzemélyek ON kt_azNexon_Adójel02.Adójel = lkSzemélyek.Adójel
WHERE (((lkSzemélyek.[Vezetői beosztás megnevezése])="főispán") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Not Null) AND ((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null)) OR (((lkSzemélyek.[Vezetői beosztás megnevezése]) Like "*igazgató*") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Not Null) AND ((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null)) OR (((lkSzemélyek.Besorolás2) Like "*igazgató*") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Not Null) AND ((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null)) OR (((lkSzemélyek.Besorolás2)="főispán") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Not Null) AND ((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null)) OR (((lkSzemélyek.[Vezetői beosztás megnevezése])="osztályvezető") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Not Null) AND ((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null)) OR (((lkSzemélyek.Besorolás2)="osztályvezető") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Not Null) AND ((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null)) OR (((lkSzemélyek.[Vezetői beosztás megnevezése]) Like "*kerületi*") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Not Null) AND ((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null)) OR (((lkSzemélyek.Besorolás2) Like "főosztály*") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Not Null) AND ((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null)) OR (((lkSzemélyek.[Vezetői beosztás megnevezése]) Like "főosztály*") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Not Null) AND ((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null)) OR (((lkSzemélyek.Besorolás2) Like "*kerületi*") AND ((lkSzemélyek.[Tartós távollét típusa]) Is Not Null) AND ((lkSzemélyek.[Szervezeti egység kódja]) Is Not Null))
ORDER BY bfkh(Nz([Szervezeti egység kódja],"-"));

#/#/#/
lkVIIKerületbeBelépők
#/#/
SELECT lkBelépőkUnió.[Megyei szint VAGY Járási Hivatal] AS Kerület, lkBelépőkUnió.Név, lkBelépőkUnió.[Jogviszony kezdő dátuma]
FROM lkBelépőkUnió
WHERE (((lkBelépőkUnió.[Megyei szint VAGY Járási Hivatal])="Budapest Főváros Kormányhivatala VII. Kerületi Hivatala") AND ((lkBelépőkUnió.[Jogviszony kezdő dátuma]) Between #7/1/2023# And #7/31/2024#));

#/#/#/
lkVIIKerületbőlKilépettekHavonta
#/#/
SELECT lkKilépőUnió.[Megyei szint VAGY Járási Hivatal] AS Kerület, DateSerial(Year([Jogviszony megszűnésének, megszüntetésének időpontja]),Month([Jogviszony megszűnésének, megszüntetésének időpontja])+1,1)-1 AS Tárgyhó, Sum(1) AS Fő
FROM lkKilépőUnió
WHERE (((lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének oka: jogszabályi hiva]) Not Like "*létre*") AND ((lkKilépőUnió.[Jogviszony megszűnésének, megszüntetésének időpontja]) Between #7/1/2023# And #7/31/2024#))
GROUP BY lkKilépőUnió.[Megyei szint VAGY Járási Hivatal], DateSerial(Year([Jogviszony megszűnésének, megszüntetésének időpontja]),Month([Jogviszony megszűnésének, megszüntetésének időpontja])+1,1)-1
HAVING (((lkKilépőUnió.[Megyei szint VAGY Járási Hivatal])="Budapest Főváros Kormányhivatala VII. Kerületi Hivatala"));

#/#/#/
lkVIIKerületiBetöltöttLétszám01
#/#/
SELECT Replace([Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH") AS [Kerületi hivatal], tHaviJelentésHatálya1.hatálya, Sum(IIf([Mező4]="üres állás",0,1)) AS [Betöltött létszám], Sum(IIf([Mező4]="üres állás",1,0)) AS Üres
FROM tHaviJelentésHatálya1 INNER JOIN tJárási_állomány ON tHaviJelentésHatálya1.hatályaID = tJárási_állomány.hatályaID
GROUP BY Replace([Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH"), tHaviJelentésHatálya1.hatálya
HAVING (((Replace([Járási Hivatal],"Budapest Főváros Kormányhivatala","BFKH"))="BFKH VII. Kerületi Hivatala") AND ((tHaviJelentésHatálya1.hatálya) Between #7/1/2023# And #7/31/2024#));

#/#/#/
lkVIIKerületiBetöltöttLétszám02
#/#/
SELECT lkVIIKerületiBetöltöttLétszám01.[Kerületi hivatal], lkVIIKerületiBetöltöttLétszám01.hatálya, lkVIIKerületiBetöltöttLétszám01.[Betöltött létszám], lkVIIKerületiBetöltöttLétszám01.Üres, [Betöltött létszám]+[Üres] AS Engedélyezett
FROM lkVIIKerületiBetöltöttLétszám01;

#/#/#/
lkVIIKerületiKimutatás
#/#/
SELECT lkVIIKerületiBetöltöttLétszám02.[Kerületi hivatal], lkVIIKerületiBetöltöttLétszám02.hatálya, lkVIIKerületiBetöltöttLétszám02.[Betöltött létszám], lkVIIKerületiBetöltöttLétszám02.Üres, lkVIIKerületiBetöltöttLétszám02.Engedélyezett, Nz([Fő],0) AS Kilépettek
FROM lkVIIKerületbőlKilépettekHavonta RIGHT JOIN lkVIIKerületiBetöltöttLétszám02 ON lkVIIKerületbőlKilépettekHavonta.Tárgyhó = lkVIIKerületiBetöltöttLétszám02.hatálya;

#/#/#/
lkVirtuálisKormányablak
#/#/
SELECT drhátra(zárojeltelenítő([Dolgozó teljes neve])) AS [Dolgozó neve], lkSzemélyek.[Dolgozó születési neve], lkSzemélyek.[Anyja neve], [Születési hely] & ", " & [Születési idő] AS [Születési hely, idő], IIf(Len(Nz([Tartózkodási lakcím],""))<15,[Állandó lakcím],[Tartózkodási lakcím]) AS Lakhely, lkSzemélyek.[Adóazonosító jel], lkSzemélyek.[TAJ szám], ffsplit([Utalási cím],"|",2) AS Számlaszám, lkSzemélyek.[Hivatali email], IIf(Nz([Hivatali telefon],"")="",[Hivatali telefon mellék],[Hivatali telefon]) AS [Hivatali telefonszám], lkSzemélyek.[Szint 1 szervezeti egység név], "Budapest" AS [Igazgatási szerv székhelye], lkSzemélyek.[Vezető neve], [Főosztály] & "/" & [Osztály] AS [Főosztály, osztály], lkSzemélyek.[Illetmény összesen kerekítés nélkül (eltérítés nélküli)], lkSzemélyek.[Státusz kódja], lkSzemélyek.[Besorolási  fokozat (KT)], lkSzemélyek.FEOR, lkSzemélyek.Feladatkör
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Jogviszony vége (kilépés dátuma)]) Is Null Or (lkSzemélyek.[Jogviszony vége (kilépés dátuma)])>Date()) AND ((lkSzemélyek.Főosztály) Not Like "*főosztály*"))
ORDER BY lkSzemélyek.FőosztályKód, lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkVirtuálisKormányablakPárosítani
#/#/
SELECT drhátra(zárojeltelenítő([Dolgozó teljes neve])) AS [Dolgozó neve], lkSzemélyek.[Dolgozó születési neve], lkSzemélyek.[Anyja neve], [Születési hely] & ", " & [Születési idő] AS [Születési hely, idő], IIf(Len(Nz([Tartózkodási lakcím],""))<15,[Állandó lakcím],[Tartózkodási lakcím]) AS Lakhely, lkSzemélyek.[Adóazonosító jel], lkSzemélyek.[TAJ szám], ffsplit([Utalási cím],"|",2) AS Számlaszám, lkSzemélyek.[Hivatali email], IIf(Nz([Hivatali telefon],"")="",[Hivatali telefon mellék],[Hivatali telefon]) AS [Hivatali telefonszám], lkSzemélyek.[Szint 1 szervezeti egység név], "Budapest" AS [Igazgatási szerv székhelye], lkSzemélyek.[Vezető neve], [Főosztály] & "/" & [Osztály] AS [Főosztály, osztály], lkSzemélyek.[Illetmény összesen kerekítés nélkül (eltérítés nélküli)], lkSzemélyek.[Státusz kódja], lkSzemélyek.[Besorolási  fokozat (KT)], lkSzemélyek.FEOR, lkSzemélyek.Feladatkör
FROM lkSzemélyek
WHERE (((lkSzemélyek.Főosztály) Like "*kerületi hivatal*") AND ((lkSzemélyek.[Státusz neve])="Álláshely"))
ORDER BY lkSzemélyek.FőosztályKód, lkSzemélyek.[Dolgozó teljes neve];

#/#/#/
lkVirtuálisKormányablakPárosítva
#/#/
SELECT tVirtuálisKormányablak.Kerület, tVirtuálisKormányablak.[Célfeladattal megbízott személy családi és utóneve], lkVirtuálisKormányablak.[Dolgozó neve], lkVirtuálisKormányablak.[Dolgozó születési neve], lkVirtuálisKormányablak.[Anyja neve], lkVirtuálisKormányablak.[Születési hely, idő], lkVirtuálisKormányablak.Lakhely, lkVirtuálisKormányablak.[Adóazonosító jel], lkVirtuálisKormányablak.[TAJ szám], lkVirtuálisKormányablak.Számlaszám, lkVirtuálisKormányablak.[Hivatali email], lkVirtuálisKormányablak.[Hivatali telefonszám], lkVirtuálisKormányablak.[Szint 1 szervezeti egység név], lkVirtuálisKormányablak.[Igazgatási szerv székhelye], lkVirtuálisKormányablak.[Vezető neve], lkVirtuálisKormányablak.[Főosztály, osztály], lkVirtuálisKormányablak.[Illetmény összesen kerekítés nélkül (eltérítés nélküli)], lkVirtuálisKormányablak.[Státusz kódja], lkVirtuálisKormányablak.[Besorolási  fokozat (KT)], lkVirtuálisKormányablak.FEOR, lkVirtuálisKormányablak.Feladatkör
FROM tVirtuálisKormányablak LEFT JOIN lkVirtuálisKormányablak ON tVirtuálisKormányablak.[Célfeladattal megbízott személy családi és utóneve] = lkVirtuálisKormányablak.[Dolgozó neve];

#/#/#/
lkVisszajelzésekKezelése
#/#/
SELECT tBejövőÜzenetek.*, tBejövőVisszajelzések.*, tRégiHibák.lekérdezésNeve, tVisszajelzésTípusok.VisszajelzésSzövege, tRégiHibák.[Első Időpont] AS [Fennállás kezdete]
FROM tBejövőÜzenetek INNER JOIN ((tRégiHibák INNER JOIN tBejövőVisszajelzések ON tRégiHibák.[Első mező] = tBejövőVisszajelzések.Hash) INNER JOIN tVisszajelzésTípusok ON tBejövőVisszajelzések.VisszajelzésKód = tVisszajelzésTípusok.VisszajelzésKód) ON tBejövőÜzenetek.azÜzenet = tBejövőVisszajelzések.azÜzenet
WHERE (((tRégiHibák.[Utolsó Időpont])=(select max([utolsó időpont]) from tRégiHibák where lekérdezésneve <>"lkÜresÁlláshelyekÁllapotfelmérő" And lekérdezésneve <>"lkFontosHiányzóAdatok02") Or (tRégiHibák.[Utolsó Időpont])=(select max([utolsó időpont]) from tRégiHibák where lekérdezésneve ="lkFontosHiányzóAdatok02")));

#/#/#/
lkVisszajelzésTörténete
#/#/
SELECT lkÜzenetekVisszajelzések.Hash, lkÜzenetekVisszajelzések.SenderEmailAddress, tVisszajelzésTípusok.VisszajelzésKód, tVisszajelzésTípusok.VisszajelzésSzövege, lkÜzenetekVisszajelzések.DeliveredDate
FROM lkÜzenetekVisszajelzések INNER JOIN tVisszajelzésTípusok ON lkÜzenetekVisszajelzések.VisszajelzésKód = tVisszajelzésTípusok.VisszajelzésKód
WHERE (((lkÜzenetekVisszajelzések.Hash)="15ee45f6766e93397131c751708f6847" Or (lkÜzenetekVisszajelzések.Hash)="Like [AzonosítóHASH]"))
ORDER BY lkÜzenetekVisszajelzések.Hash, lkÜzenetekVisszajelzések.DeliveredDate;

#/#/#/
lkXVIkerületi_költözés
#/#/
SELECT lkSzemélyek.[Szervezeti egység kódja], lkSzemélyek.tSzemélyek.Adójel, lkSzemélyek.[TAJ szám], lkSzemélyek.[Dolgozó születési neve], lkSzemélyek.[Születési idő], lkSzemélyek.[Születési hely], lkSzemélyek.[Anyja neve], Replace([Állandó lakcím],"Magyarország, ","") AS Lakcím, lkSzemélyek.[Munkavégzés helye - cím] AS [Nexon szerinti munkahely], "" AS [Ügyintéző neve], "" AS [Ügyintéző tel], "" AS [Ügyintéző email]
FROM lkSzemélyek
WHERE (((lkSzemélyek.[Szervezeti egység kódja])="BFKH.1.2.16.4." Or (lkSzemélyek.[Szervezeti egység kódja])="BFKH.1.2.16.2." Or (lkSzemélyek.[Szervezeti egység kódja])="BFKH.1.2.16.1."));

#/#/#/
MSyslkLekérdezésekTípusai
#/#/
SELECT DISTINCT MSysObjects.Name AS queryName
FROM (MSysQueries INNER JOIN MSysObjects ON MSysQueries.ObjectId = MSysObjects.Id) LEFT JOIN (SELECT * FROM MSysQueries WHERE Attribute=5)  AS src ON MSysQueries.ObjectId = src.ObjectId
WHERE (((MSysObjects.Name)>"~z") AND ((Mid("SelectMakTblAppendUpdateDeleteXtab  AltTblPassThUnion ",([msysqueries]![Flag]-1)*6+1,6))="SELECT" Or (Mid("SelectMakTblAppendUpdateDeleteXtab  AltTblPassThUnion ",([msysqueries]![Flag]-1)*6+1,6))="XTab") AND ((MSysQueries.Attribute)=1))
ORDER BY MSysObjects.Name;

#/#/#/
mSyslkMezőnevek
#/#/
SELECT IIf([MSysQueries_1].[Name1] Is Null,[MSysQueries_1].[Expression],[MSysQueries_1].[Name1]) AS MezőNév, Replace(Replace(utolsó(IIf([MSysQueries_1].[Name1] Is Null,[MSysQueries_1].[Expression],[MSysQueries_1].[Name1]),"."),"[",""),"]","") AS Alias, MSysObjects.Name AS QueryName, MSysQueries.Name1, MSysQueries.Attribute, MSysQueries.Flag, MSysQueries_1.Attribute, MSysQueries_1.Flag, MSysQueries.Expression, MSysQueries_1.Expression, MSysQueries.ObjectId
FROM (MSysObjects RIGHT JOIN MSysQueries ON MSysObjects.Id = MSysQueries.ObjectId) LEFT JOIN MSysQueries AS MSysQueries_1 ON MSysQueries.ObjectId = MSysQueries_1.ObjectId
WHERE (((MSysQueries.Attribute)=1) AND ((MSysQueries.Flag)=1 Or (MSysQueries.Flag)=6) AND ((MSysQueries_1.Attribute)=6) AND ((MSysQueries_1.Flag)=0 Or (MSysQueries_1.Flag)=1)) OR (((MSysQueries.Attribute)=0) AND ((MSysQueries_1.Attribute)=6) AND ((MSysQueries_1.Flag)=0 Or (MSysQueries_1.Flag)=1))
ORDER BY MSysObjects.Name, MSysQueries.ObjectId;

#/#/#/
Osztályvezetők átlagilletménye
#/#/
SELECT lkOsztályvezetőiÁlláshelyek.[Besorolási  fokozat (KT)], Round(Avg([Illetmény])/100,0)*100 AS Átlagilletmény
FROM lkOsztályvezetőiÁlláshelyek
GROUP BY lkOsztályvezetőiÁlláshelyek.[Besorolási  fokozat (KT)];

#/#/#/
oz_lkBelépők_Hiány2
#/#/
SELECT lkBelépők_Hiány.[Személynév] AS Név, lkBelépők_Hiány.[Adóazonosító] AS Adóazonosító, lkBelépők_Hiány.[Szervezeti egység] AS Megyei_szint_VAGY_Járási_Hivatal, lkBelépők_Hiány.[Szervezeti egység] AS Szervezeti_egységFőosztály_megnevezése, lkBelépők_Hiány.[Szervezeti egység] AS Szervezeti_egységOsztály_megnevezése, lkBelépők_Hiány.[Szervezeti egység] AS ÁNYR_SZERVEZETI_EGYSÉG_AZONOSÍTÓ, lkBelépők_Hiány.[Ellátandó feladat] AS Ellátott_feladatok_megjelölésea_fővárosi_és_megyei_kormányhi, lkBelépők_Hiány.[Álláshely azonosító] AS Álláshely_azonosító, lkBelépők_Hiány.[Kinevezés kezdete] AS Jogviszony_kezdő_dátuma, lkBelépők_Hiány.[Szerződés_kinevezés típusa] AS Foglalkoztatás_időtartama_Határozatlan__HL____Határozott__HT_, lkBelépők_Hiány.[Illetmény] AS Illetmény__Ft_hó_, lkBelépők_Hiány.[-] AS Szervezti_alaplétszám__A_Központosított_álláshely__K_, lkBelépők_Hiány.[Illetmény2] AS Illetmény754
FROM lkBelépők_Hiány;

#/#/#/
oz_lkHatározottak_Hiány2
#/#/
SELECT lkHatározottak_Hiány.[Személynév] AS Tartós_távollévő_neve, lkHatározottak_Hiány.[Adóazonosító] AS Adóazonosító_tt, lkHatározottak_Hiány.[Szervezeti egység] AS Megyei_szint_VAGY_Járási_Hivatal, lkHatározottak_Hiány.[Szervezeti egység] AS Szervezeti_egységFőosztály_megnevezése, lkHatározottak_Hiány.[Szervezeti egység] AS Szervezeti_egységOsztály_megnevezése, lkHatározottak_Hiány.[Szervezeti egység] AS ÁNYR_SZERVEZETI_EGYSÉG_AZONOSÍTÓ, lkHatározottak_Hiány.[Ellátandó feladat] AS Ellátott_feladatok_megjelölésea_fővárosi_és_megyei_kormányhi, lkHatározottak_Hiány.[Álláshely azonosító] AS Álláshely_azonosító, lkHatározottak_Hiány.[Tartós távollét típusa] AS Tartós_távollévő_esetén_a_távollét_jogcíme__CSED__GYED__GYES, lkHatározottak_Hiány.[Tartós távollét Érv.kezdete] AS Tartós_távollét_kezdete, lkHatározottak_Hiány.[Tartós távollét Érv.vége] AS Tartós_távollét_várható_vége, lkHatározottak_Hiány.[Illetmény] AS Tartósan_távollévő_illetményének_teljes_összege, lkHatározottak_Hiány.[-] AS Tartós_távollévő_álláshelyén_határozott_időre_foglalkoztatot, lkHatározottak_Hiány.[Adóazonosító] AS Adóazonosító_tth, lkHatározottak_Hiány.[Szervezeti egység] AS Megyei_szint_VAGY_Járási_Hivatal164, lkHatározottak_Hiány.[Szervezeti egység] AS Szervezeti_egységFőosztály_megnevezése243, lkHatározottak_Hiány.[Szervezeti egység] AS Szervezeti_egységOsztály_megnevezése328, lkHatározottak_Hiány.[Szervezeti egység] AS ÁNYR_SZERVEZETI_EGYSÉG_AZONOSÍTÓ411, lkHatározottak_Hiány.[Ellátandó feladat] AS Ellátott_feladatok_megjelölésea_fővárosi_és_megyei_kormányhi490, lkHatározottak_Hiány.[Álláshely azonosító] AS Álláshely_azonosító599, lkHatározottak_Hiány.[Hat.Idő kezdete] AS Tartós_távollévő_státuszán_foglalkoztatott_határozott_idejű_, lkHatározottak_Hiány.[Hat.Idő lejárta] AS Tartós_távollévő_státuszán_foglalkoztatott_határozott_idejű_1691, lkHatározottak_Hiány.[Illetmény] AS Tartós_távollévő_státuszán_foglalkoztatott_illetményének_tel
FROM lkHatározottak_Hiány;

#/#/#/
oz_lkJárási_Hiány2
#/#/
SELECT lkJárási_Hiány.[Személynév] AS Név, lkJárási_Hiány.[Adóazonosító] AS Adóazonosító, lkJárási_Hiány.[Születési idő] AS Születési_év__Üres_állás__Üres_állás, lkJárási_Hiány.[Nem] AS Dolgozó_neme1_férfi2_nő, lkJárási_Hiány.[Szervezeti egység] AS Járási_Hivatal, lkJárási_Hiány.[Szervezeti egység] AS Szervezeti_egységOsztály_megnevezése, lkJárási_Hiány.[Szervezeti egység] AS ÁNYR_SZERVEZETI_EGYSÉG_AZONOSÍTÓ, lkJárási_Hiány.[Ellátandó feladat] AS Ellátott_feladatok_megjelölésea_fővárosi_és_megyei_kormányhi, lkJárási_Hiány.[Kinevezés kezdete] AS Kinevezés_dátumaÁlláshely_megüresedésének_dátuma_most_elláto, lkJárási_Hiány.[Ellátandó feladat jellege] AS Feladat_jellege__szakmai__SZ____funkcionális__F__feladatellá, lkJárási_Hiány.[Foglalkozási viszony (Besorolás típusa)] AS Foglalkoztatási_forma_teljes__T____részmunkaidős__R___nyugdí, lkJárási_Hiány.[Heti órakeret] AS Heti_munkaórák_száma, lkJárási_Hiány.[-] AS Álláshely_betöltésének_aránya_ésÜres_álláshely_betöltés_aránya, lkJárási_Hiány.[-] AS Besorolási_fokozat_kód_, lkJárási_Hiány.[Besorolási fokozat] AS Besorolási_fokozat_megnevezése_, lkJárási_Hiány.[Álláshely azonosító] AS Álláshely_azonosító, lkJárási_Hiány.[Illetmény] AS Havi_illetmény_teljes_összege__kerekítve__FT_, lkJárási_Hiány.[Szerződés_kinevezés típusa] AS Foglalkoztatás_időtartama_Határozatlan__HL____Határozott__HT_, lkJárási_Hiány.[Legmagasabb fokú végzettsége] AS Legmagasabb_iskolai_végzettség_1_8__osztály__2_érettségi__3_, lkJárási_Hiány.[Képesítést adó végzettség] AS Képesítést_adó_végzettség_megnevezése__az_az_egy_ami_a_felad
FROM lkJárási_Hiány;

#/#/#/
oz_lkKilépők_Hiány2
#/#/
SELECT lkKilépők_Hiány.[Személynév] AS Név, lkKilépők_Hiány.[Adóazonosító] AS Adóazonosító, lkKilépők_Hiány.[Szervezeti egység] AS Megyei_szint_VAGY_Járási_Hivatal, lkKilépők_Hiány.[Szervezeti egység] AS Szervezeti_egységFőosztály_megnevezése, lkKilépők_Hiány.[Szervezeti egység] AS Szervezeti_egységOsztály_megnevezése, lkKilépők_Hiány.[Szervezeti egység] AS ÁNYR_SZERVEZETI_EGYSÉG_AZONOSÍTÓ, lkKilépők_Hiány.[Ellátandó feladat] AS Ellátott_feladatok_megjelölésea_fővárosi_és_megyei_kormányhi, lkKilépők_Hiány.[Álláshely azonosító] AS Álláshely_azonosító, lkKilépők_Hiány.[Jogviszony megszűnés indoka] AS Jogviszony_megszűnésének__megszüntetésének_oka__jogszabályi_, lkKilépők_Hiány.[Kinevezés kezdete] AS Jogviszony_kezdő_dátuma, lkKilépők_Hiány.[Kinevezés vége] AS Jogviszony_megszűnésének__megszüntetésének_időpontja, lkKilépők_Hiány.[Illetmény] AS Illetmény__Ft_hó_, lkKilépők_Hiány.[-] AS Szervezti_alaplétszám__A_Központosított_álláshely__K_
FROM lkKilépők_Hiány;

#/#/#/
oz_lkKormányhivatali_Hiány2
#/#/
SELECT lkKormányhivatali_Hiány.[Személynév] AS Név, lkKormányhivatali_Hiány.[Adóazonosító] AS Adóazonosító, lkKormányhivatali_Hiány.[Születési idő] AS Születési_év__Üres_állás, lkKormányhivatali_Hiány.[Nem] AS Dolgozó_neme1_férfi2_nő, lkKormányhivatali_Hiány.[Szervezeti egység] AS Szervezeti_egységFőosztály_megnevezése, lkKormányhivatali_Hiány.[Szervezeti egység] AS Szervezeti_egységOsztály_megnevezése, lkKormányhivatali_Hiány.[Szervezeti egység] AS ÁNYR_SZERVEZETI_EGYSÉG_AZONOSÍTÓ, lkKormányhivatali_Hiány.[Ellátandó feladat] AS Ellátott_feladatok_megjelölésea_fővárosi_és_megyei_kormányhi, lkKormányhivatali_Hiány.[Kinevezés kezdete] AS Kinevezés_dátumaÁlláshely_megüresedésének_dátuma_most_elláto, lkKormányhivatali_Hiány.[Ellátandó feladat jellege] AS Feladat_jellege__szakmai__SZ____funkcionális__F__feladatellá, lkKormányhivatali_Hiány.[Foglalkozási viszony (Besorolás típusa)] AS Foglalkoztatási_forma_teljes__T____részmunkaidős__R___nyugdí, lkKormányhivatali_Hiány.[Heti órakeret] AS Heti_munkaórák_száma, lkKormányhivatali_Hiány.[Álláshely azonosító] AS Álláshely_betöltésének_aránya_ésÜres_álláshely_betöltés_aránya, lkKormányhivatali_Hiány.[Besorolási fokozat] AS Besorolási_fokozat_megnevezése_, lkKormányhivatali_Hiány.[Álláshely azonosító] AS Álláshely_azonosító, lkKormányhivatali_Hiány.[Illetmény] AS Havi_illetmény_teljes_összege__kerekítve__FT_, lkKormányhivatali_Hiány.[Szerződés_kinevezés típusa] AS Foglalkoztatás_időtartama_Határozatlan__HL____Határozott__HT_, lkKormányhivatali_Hiány.[Legmagasabb fokú végzettsége] AS Legmagasabb_iskolai_végzettség_1_8__osztály__2_érettségi__3_, lkKormányhivatali_Hiány.[Képesítést adó végzettség] AS Képesítést_adó_végzettség_megnevezése__az_az_egy_ami_a_felad
FROM lkKormányhivatali_Hiány;

#/#/#/
oz_lkKözpontosítottak_Hiány2
#/#/
SELECT lkKözpontosítottak_Hiány.[Személynév] AS Név, lkKözpontosítottak_Hiány.[Adóazonosító] AS Adóazonosító, lkKözpontosítottak_Hiány.[Születési idő] AS Születési_év__Üres_állás, lkKözpontosítottak_Hiány.[Szervezeti egység] AS Megyei_szint_VAGY_Járási_Hivatal, lkKözpontosítottak_Hiány.[Szervezeti egység] AS Szervezeti_egységFőosztály_megnevezése, lkKözpontosítottak_Hiány.[Szervezeti egység] AS Szervezeti_egységOsztály_megnevezése, lkKözpontosítottak_Hiány.[Szervezeti egység] AS Nexon_szótárelemnek_megfelelő_szervezeti_egység_azonosító, lkKözpontosítottak_Hiány.[Ellátandó feladat] AS Ellátott_feladatok_megjelölésea_fővárosi_és_megyei_kormányhi, lkKözpontosítottak_Hiány.[Kinevezés kezdete] AS Kinevezés_dátumaÁlláshely_megüresedésének_dátuma_most_elláto, lkKözpontosítottak_Hiány.[Foglalkozási viszony (Besorolás típusa)] AS Foglalkoztatási_forma_teljes__T____részmunkaidős__R___nyugdí, lkKözpontosítottak_Hiány.[-] AS Álláshely_betöltésének_aránya_ésÜres_álláshely_betöltés_aránya, lkKözpontosítottak_Hiány.[-] AS Besorolási_fokozat_kód_, lkKözpontosítottak_Hiány.[Besorolási fokozat] AS Besorolási_fokozat_megnevezése_, lkKözpontosítottak_Hiány.[Álláshely azonosító] AS Álláshely_azonosító, lkKözpontosítottak_Hiány.[Illetmény] AS Havi_illetmény_teljes_összege__kerekítve__FT_, lkKözpontosítottak_Hiány.[Szerződés_kinevezés típusa] AS Foglalkoztatás_időtartama_Határozatlan__HL____Határozott__HT_, lkKözpontosítottak_Hiány.[Legmagasabb fokú végzettsége] AS Legmagasabb_iskolai_végzettség_1_8__osztály__2_érettségi__3_
FROM lkKözpontosítottak_Hiány;

#/#/#/
parlkEllenőrzőLekérdezések
#/#/
SELECT lkEllenőrzőLekérdezések3.Fejezetsorrend, lkEllenőrzőLekérdezések3.Leksorrend, lkEllenőrzőLekérdezések3.EllenőrzőLekérdezés, lkEllenőrzőLekérdezések3.LapNév, lkEllenőrzőLekérdezések3.Osztály, lkEllenőrzőLekérdezések3.Megjegyzés, lkEllenőrzőLekérdezések3.Táblacím, lkEllenőrzőLekérdezések3.vaneGraf, lkEllenőrzőLekérdezések3.azETípus, lkEllenőrzőLekérdezések3.Kimenet, lkEllenőrzőLekérdezések3.KellVisszajelzes, lkEllenőrzőLekérdezések3.azUnion, lkEllenőrzőLekérdezések3.TáblaMegjegyzés, lkEllenőrzőLekérdezések3.azHibaCsoport
FROM lkEllenőrzőLekérdezések3
WHERE (((lkEllenőrzőLekérdezések3.Osztály)=[qWhere]) AND ((lkEllenőrzőLekérdezések3.Kimenet)=True))
ORDER BY lkEllenőrzőLekérdezések3.Fejezetsorrend, lkEllenőrzőLekérdezések3.Leksorrend;

#/#/#/
Szervezeti egységek pivot
#/#/
PARAMETERS Üssél_egy_entert Long;
TRANSFORM First(lkFőosztályokOsztályokSorszámmal.Osztály) AS FirstOfOsztály
SELECT lkFőosztályokOsztályokSorszámmal.Főosztály
FROM lkFőosztályokOsztályokSorszámmal
WHERE (((lkFőosztályokOsztályokSorszámmal.bfkhkód) Like "BFKH*"))
GROUP BY lkFőosztályokOsztályokSorszámmal.Főosztály
PIVOT lkFőosztályokOsztályokSorszámmal.Sorsz In (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21);

#/#/#/
temp
#/#/
PARAMETERS [__Sorszám] Value;
SELECT DISTINCTROW *
FROM ktSzervezetTelephely AS lkTelephelyek
WHERE ((([__Sorszám])=[azTelephely]));

#/#/#/
tHaviJelentésHatálya
#/#/
SELECT tHaviJelentésHatálya1.*
FROM tHaviJelentésHatálya1;

#/#/#/
tJavítandóMezőnevek
#/#/
SELECT tJav_mezők.azJavítandó, tJav_mezők.tTáblák_azonosító, tJav_táblák.Tábla, tJav_táblák.Ellenőrzéshez, tJav_mezők.azNexonMezők, tJav_mezők.Eredeti, tNexonMezők.[nexon mező megnevezése] AS Import, tJav_mezők.TáblánBelüliSorszáma, tJav_mezők.NemKötelező, tJav_mezők.NemKötelezőÜresÁlláshelyEsetén, tJav_táblák.SzervezetKód_mező, tJav_mezők.Szöveg, tNexonMezők.Megjegyzés AS Elérés, tJav_táblák.ÜresÁlláshelyMezők
FROM tJav_táblák INNER JOIN (tJav_mezők LEFT JOIN tNexonMezők ON tJav_mezők.azNexonMezők = tNexonMezők.azNexonMező) ON tJav_táblák.kód = tJav_mezők.tTáblák_azonosító;

#/#/#/
tkDolgozókVégzettségeiFelsorolás01
#/#/
SELECT lkDolgozókVégzettségeiFelsorolás01.VégzettségeinekASzáma, lkDolgozókVégzettségeiFelsorolás01.Adójel, lkDolgozókVégzettségeiFelsorolás01.[Végzettség neve], lkDolgozókVégzettségeiFelsorolás01.Azonosítók INTO tDolgozókVégzettségeiFelsorolás01
FROM lkDolgozókVégzettségeiFelsorolás01;

#/#/#/
tkDolgozókVégzettségeiFelsorolás02
#/#/
SELECT lkDolgozókVégzettségeiFelsorolás02.Sorszám, lkDolgozókVégzettségeiFelsorolás02.VégzettségeinekASzáma, lkDolgozókVégzettségeiFelsorolás02.Adójel, lkDolgozókVégzettségeiFelsorolás02.[Végzettség neve] INTO tDolgozókVégzettségeiFelsorolás02
FROM lkDolgozókVégzettségeiFelsorolás02;

#/#/#/
tlk tNexonAzonosítók - azonosak keresése
#/#/
DELETE tNexonAzonosítók.Azonosító
FROM tNexonAzonosítók
WHERE (((tNexonAzonosítók.Azonosító) In (Select FirstOfAzonosító From [tNexonAzonosítók - azonosak keresése])));

#/#/#/
tmp01
#/#/
SELECT tSzemélyek_Import.Adójel AS Adójel, tSzemélyek_Import.[Dolgozó teljes neve] AS [Dolgozó teljes neve], tSzemélyek_Import.[Dolgozó születési neve] AS [Dolgozó születési neve], tSzemélyek_Import.[Születési idő] AS [Születési idő], tSzemélyek_Import.[Születési hely] AS [Születési hely], tSzemélyek_Import.[Anyja neve] AS [Anyja neve], tSzemélyek_Import.Neme AS Neme, tSzemélyek_Import.Törzsszám AS Törzsszám, tSzemélyek_Import.[Egyedi azonosító] AS [Egyedi azonosító], tSzemélyek_Import.[Adóazonosító jel] AS [Adóazonosító jel], tSzemélyek_Import.[TAJ szám] AS [TAJ szám], tSzemélyek_Import.[Ügyfélkapu kód] AS [Ügyfélkapu kód], tSzemélyek_Import.[Elsődleges állampolgárság] AS [Elsődleges állampolgárság], tSzemélyek_Import.[Személyi igazolvány száma] AS [Személyi igazolvány száma], tSzemélyek_Import.[Személyi igazolvány érvényesség kezdete] AS [Személyi igazolvány érvényesség kezdete], tSzemélyek_Import.[Személyi igazolvány érvényesség vége] AS [Személyi igazolvány érvényesség vége], tSzemélyek_Import.[Nyelvtudás Angol] AS [Nyelvtudás Angol], tSzemélyek_Import.[Nyelvtudás Arab] AS [Nyelvtudás Arab], tSzemélyek_Import.[Nyelvtudás Bolgár] AS [Nyelvtudás Bolgár], tSzemélyek_Import.[Nyelvtudás Cigány] AS [Nyelvtudás Cigány], tSzemélyek_Import.[Nyelvtudás Cigány (lovári)] AS [Nyelvtudás Cigány (lovári)], tSzemélyek_Import.[Nyelvtudás Cseh] AS [Nyelvtudás Cseh], tSzemélyek_Import.[Nyelvtudás Eszperantó] AS [Nyelvtudás Eszperantó], tSzemélyek_Import.[Nyelvtudás Finn] AS [Nyelvtudás Finn], tSzemélyek_Import.[Nyelvtudás Francia] AS [Nyelvtudás Francia], tSzemélyek_Import.[Nyelvtudás Héber] AS [Nyelvtudás Héber], tSzemélyek_Import.[Nyelvtudás Holland] AS [Nyelvtudás Holland], tSzemélyek_Import.[Nyelvtudás Horvát] AS [Nyelvtudás Horvát], tSzemélyek_Import.[Nyelvtudás Japán] AS [Nyelvtudás Japán], tSzemélyek_Import.[Nyelvtudás Jelnyelv] AS [Nyelvtudás Jelnyelv], tSzemélyek_Import.[Nyelvtudás Kínai] AS [Nyelvtudás Kínai], tSzemélyek_Import.[Nyelvtudás Latin] AS [Nyelvtudás Latin], tSzemélyek_Import.[Nyelvtudás Lengyel] AS [Nyelvtudás Lengyel], tSzemélyek_Import.[Nyelvtudás Német] AS [Nyelvtudás Német], tSzemélyek_Import.[Nyelvtudás Norvég] AS [Nyelvtudás Norvég], tSzemélyek_Import.[Nyelvtudás Olasz] AS [Nyelvtudás Olasz], tSzemélyek_Import.[Nyelvtudás Orosz] AS [Nyelvtudás Orosz], tSzemélyek_Import.[Nyelvtudás Portugál] AS [Nyelvtudás Portugál], tSzemélyek_Import.[Nyelvtudás Román] AS [Nyelvtudás Román], tSzemélyek_Import.[Nyelvtudás Spanyol] AS [Nyelvtudás Spanyol], tSzemélyek_Import.[Nyelvtudás Szerb] AS [Nyelvtudás Szerb], tSzemélyek_Import.[Nyelvtudás Szlovák] AS [Nyelvtudás Szlovák], tSzemélyek_Import.[Nyelvtudás Szlovén] AS [Nyelvtudás Szlovén], tSzemélyek_Import.[Nyelvtudás Török] AS [Nyelvtudás Török], tSzemélyek_Import.[Nyelvtudás Újgörög] AS [Nyelvtudás Újgörög], tSzemélyek_Import.[Nyelvtudás Ukrán] AS [Nyelvtudás Ukrán], tSzemélyek_Import.[Orvosi vizsgálat időpontja] AS [Orvosi vizsgálat időpontja], tSzemélyek_Import.[Orvosi vizsgálat típusa] AS [Orvosi vizsgálat típusa], tSzemélyek_Import.[Orvosi vizsgálat eredménye] AS [Orvosi vizsgálat eredménye], tSzemélyek_Import.[Orvosi vizsgálat észrevételek] AS [Orvosi vizsgálat észrevételek], tSzemélyek_Import.[Orvosi vizsgálat következő időpontja] AS [Orvosi vizsgálat következő időpontja], tSzemélyek_Import.[Erkölcsi bizonyítvány száma] AS [Erkölcsi bizonyítvány száma], tSzemélyek_Import.[Erkölcsi bizonyítvány dátuma] AS [Erkölcsi bizonyítvány dátuma], tSzemélyek_Import.[Erkölcsi bizonyítvány eredménye] AS [Erkölcsi bizonyítvány eredménye], tSzemélyek_Import.[Erkölcsi bizonyítvány kérelem azonosító] AS [Erkölcsi bizonyítvány kérelem azonosító], tSzemélyek_Import.[Erkölcsi bizonyítvány közügyektől eltiltva] AS [Erkölcsi bizonyítvány közügyektől eltiltva], tSzemélyek_Import.[Erkölcsi bizonyítvány járművezetéstől eltiltva] AS [Erkölcsi bizonyítvány járművezetéstől eltiltva], tSzemélyek_Import.[Erkölcsi bizonyítvány intézkedés alatt áll] AS [Erkölcsi bizonyítvány intézkedés alatt áll], tSzemélyek_Import.[Munkaköri leírások (csatolt dokumentumok fájlnevei)] AS [Munkaköri leírások (csatolt dokumentumok fájlnevei)], tSzemélyek_Import.[Egyéb HR dokumentumok (csatolt dokumentumok fájlnevei)] AS [Egyéb HR dokumentumok (csatolt dokumentumok fájlnevei)], tSzemélyek_Import.[Kormányhivatal rövid neve] AS [Kormányhivatal rövid neve], tSzemélyek_Import.[Szervezeti egység kódja] AS [Szervezeti egység kódja], tSzemélyek_Import.[Szervezeti egység neve] AS [Szervezeti egység neve], tSzemélyek_Import.[Szervezeti munkakör neve] AS [Szervezeti munkakör neve], tSzemélyek_Import.[Vezetői megbízás típusa] AS [Vezetői megbízás típusa], tSzemélyek_Import.[Státusz kódja] AS [Státusz kódja], tSzemélyek_Import.[Státusz költséghelyének kódja] AS [Státusz költséghelyének kódja], tSzemélyek_Import.[Státusz költséghelyének neve ] AS [Státusz költséghelyének neve ], tSzemélyek_Import.[Létszámon felül létrehozott státusz] AS [Létszámon felül létrehozott státusz], tSzemélyek_Import.[Státusz típusa] AS [Státusz típusa], tSzemélyek_Import.[Státusz neve] AS [Státusz neve], tSzemélyek_Import.[Többes betöltés] AS [Többes betöltés], tSzemélyek_Import.[Vezető neve] AS [Vezető neve], tSzemélyek_Import.[Vezető adóazonosító jele] AS [Vezető adóazonosító jele], tSzemélyek_Import.[Vezető email címe] AS [Vezető email címe], tSzemélyek_Import.[Állandó lakcím] AS [Állandó lakcím], tSzemélyek_Import.[Tartózkodási lakcím] AS [Tartózkodási lakcím], tSzemélyek_Import.[Levelezési cím_] AS [Levelezési cím_], tSzemélyek_Import.[Öregségi nyugdíj-korhatár elérésének időpontja (dátum)] AS [Öregségi nyugdíj-korhatár elérésének időpontja (dátum)], tSzemélyek_Import.Nyugdíjas AS Nyugdíjas, tSzemélyek_Import.[Nyugdíj típusa] AS [Nyugdíj típusa], tSzemélyek_Import.[Nyugdíjas korú továbbfoglalkoztatási engedéllyel rendelkezik] AS [Nyugdíjas korú továbbfoglalkoztatási engedéllyel rendelkezik], tSzemélyek_Import.[Megváltozott munkaképesség] AS [Megváltozott munkaképesség], tSzemélyek_Import.[Önkéntes tartalékos katona] AS [Önkéntes tartalékos katona], tSzemélyek_Import.[Utolsó vagyonnyilatkozat leadásának dátuma] AS [Utolsó vagyonnyilatkozat leadásának dátuma], tSzemélyek_Import.[Vagyonnyilatkozat nyilvántartási száma] AS [Vagyonnyilatkozat nyilvántartási száma], tSzemélyek_Import.[Következő vagyonnyilatkozat esedékessége] AS [Következő vagyonnyilatkozat esedékessége], tSzemélyek_Import.[Nemzetbiztonsági ellenőrzés dátuma] AS [Nemzetbiztonsági ellenőrzés dátuma], tSzemélyek_Import.[Védett állományba tartozó munkakör] AS [Védett állományba tartozó munkakör], tSzemélyek_Import.[Vezetői megbízás típusa1] AS [Vezetői megbízás típusa1], tSzemélyek_Import.[Vezetői beosztás megnevezése] AS [Vezetői beosztás megnevezése], tSzemélyek_Import.[Vezetői beosztás (megbízás) kezdete] AS [Vezetői beosztás (megbízás) kezdete], tSzemélyek_Import.[Vezetői beosztás (megbízás) vége] AS [Vezetői beosztás (megbízás) vége], tSzemélyek_Import.[Iskolai végzettség foka] AS [Iskolai végzettség foka], tSzemélyek_Import.[Iskolai végzettség neve] AS [Iskolai végzettség neve], tSzemélyek_Import.[Alapvizsga kötelezés dátuma] AS [Alapvizsga kötelezés dátuma], tSzemélyek_Import.[Alapvizsga letétel tényleges határideje] AS [Alapvizsga letétel tényleges határideje], tSzemélyek_Import.[Alapvizsga mentesség] AS [Alapvizsga mentesség], tSzemélyek_Import.[Alapvizsga mentesség oka] AS [Alapvizsga mentesség oka], tSzemélyek_Import.[Szakvizsga kötelezés dátuma] AS [Szakvizsga kötelezés dátuma], tSzemélyek_Import.[Szakvizsga letétel tényleges határideje] AS [Szakvizsga letétel tényleges határideje], tSzemélyek_Import.[Szakvizsga mentesség] AS [Szakvizsga mentesség], tSzemélyek_Import.[Foglalkozási viszony] AS [Foglalkozási viszony], tSzemélyek_Import.[Foglalkozási viszony statisztikai besorolása] AS [Foglalkozási viszony statisztikai besorolása], tSzemélyek_Import.[Dolgozó szerződéses/kinevezéses munkaköre / kinevezési okmányban] AS [Dolgozó szerződéses/kinevezéses munkaköre / kinevezési okmányban], tSzemélyek_Import.[Beosztástervezés helyszínek] AS [Beosztástervezés helyszínek], tSzemélyek_Import.[Beosztástervezés tevékenységek] AS [Beosztástervezés tevékenységek], tSzemélyek_Import.[Részleges távmunka szerződés kezdete] AS [Részleges távmunka szerződés kezdete], tSzemélyek_Import.[Részleges távmunka szerződés vége] AS [Részleges távmunka szerződés vége], tSzemélyek_Import.[Részleges távmunka szerződés intervalluma] AS [Részleges távmunka szerződés intervalluma], tSzemélyek_Import.[Részleges távmunka szerződés mértéke] AS [Részleges távmunka szerződés mértéke], tSzemélyek_Import.[Részleges távmunka szerződés helyszíne] AS [Részleges távmunka szerződés helyszíne], tSzemélyek_Import.[Részleges távmunka szerződés helyszíne 2] AS [Részleges távmunka szerződés helyszíne 2], tSzemélyek_Import.[Részleges távmunka szerződés helyszíne 3] AS [Részleges távmunka szerződés helyszíne 3], tSzemélyek_Import.[Egyéni túlóra keret megállapodás kezdete] AS [Egyéni túlóra keret megállapodás kezdete], tSzemélyek_Import.[Egyéni túlóra keret megállapodás vége] AS [Egyéni túlóra keret megállapodás vége], tSzemélyek_Import.[Egyéni túlóra keret megállapodás mértéke] AS [Egyéni túlóra keret megállapodás mértéke], tSzemélyek_Import.[KIRA feladat azonosítója - intézmény prefix-szel ellátva] AS [KIRA feladat azonosítója - intézmény prefix-szel ellátva], tSzemélyek_Import.[KIRA feladat azonosítója] AS [KIRA feladat azonosítója], tSzemélyek_Import.[KIRA feladat megnevezés] AS [KIRA feladat megnevezés], tSzemélyek_Import.[Osztott munkakör] AS [Osztott munkakör], tSzemélyek_Import.[Funkciócsoport: kód-megnevezés] AS [Funkciócsoport: kód-megnevezés], tSzemélyek_Import.[Funkció: kód-megnevezés] AS [Funkció: kód-megnevezés], tSzemélyek_Import.[Dolgozó költséghelyének kódja] AS [Dolgozó költséghelyének kódja], tSzemélyek_Import.[Dolgozó költséghelyének neve] AS [Dolgozó költséghelyének neve], tSzemélyek_Import.Feladatkör AS Feladatkör, tSzemélyek_Import.[Elsődleges feladatkör] AS [Elsődleges feladatkör], tSzemélyek_Import.Feladatok AS Feladatok, tSzemélyek_Import.FEOR AS FEOR, tSzemélyek_Import.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó napi óraker] AS [Elméleti (szerződés/kinevezés szerinti) ledolgozandó napi óraker], tSzemélyek_Import.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker] AS [Elméleti (szerződés/kinevezés szerinti) ledolgozandó heti óraker], tSzemélyek_Import.[Elméleti (szerződés/kinevezés szerinti) ledolgozandó havi óraker] AS [Elméleti (szerződés/kinevezés szerinti) ledolgozandó havi óraker], tSzemélyek_Import.[Szerződés/Kinevezés típusa] AS [Szerződés/Kinevezés típusa], tSzemélyek_Import.Iktatószám AS Iktatószám, tSzemélyek_Import.[Szerződés/kinevezés verzió_érvényesség kezdete] AS [Szerződés/kinevezés verzió_érvényesség kezdete], tSzemélyek_Import.[Szerződés/kinevezés verzió_érvényesség vége] AS [Szerződés/kinevezés verzió_érvényesség vége], tSzemélyek_Import.[Határozott idejű _szerződés/kinevezés lejár] AS [Határozott idejű _szerződés/kinevezés lejár], tSzemélyek_Import.[Szerződés dokumentum (csatolt dokumentumok fájlnevei)] AS [Szerződés dokumentum (csatolt dokumentumok fájlnevei)], tSzemélyek_Import.[Megjegyzés (pl# határozott szerződés/kinevezés oka)] AS [Megjegyzés (pl# határozott szerződés/kinevezés oka)], tSzemélyek_Import.[Munkavégzés helye - megnevezés] AS [Munkavégzés helye - megnevezés], tSzemélyek_Import.[Munkavégzés helye - cím] AS [Munkavégzés helye - cím], tSzemélyek_Import.[Jogviszony típusa / jogviszony típus] AS [Jogviszony típusa / jogviszony típus], tSzemélyek_Import.[Jogviszony sorszáma] AS [Jogviszony sorszáma], tSzemélyek_Import.[KIRA jogviszony jelleg] AS [KIRA jogviszony jelleg], tSzemélyek_Import.[Kölcsönbe adó cég] AS [Kölcsönbe adó cég], tSzemélyek_Import.[Teljesítményértékelés - Értékelő személy] AS [Teljesítményértékelés - Értékelő személy], tSzemélyek_Import.[Teljesítményértékelés - Érvényesség kezdet] AS [Teljesítményértékelés - Érvényesség kezdet], tSzemélyek_Import.[Teljesítményértékelés - Értékelt időszak kezdet] AS [Teljesítményértékelés - Értékelt időszak kezdet], tSzemélyek_Import.[Teljesítményértékelés - Értékelt időszak vége] AS [Teljesítményértékelés - Értékelt időszak vége], tSzemélyek_Import.[Teljesítményértékelés dátuma] AS [Teljesítményértékelés dátuma], tSzemélyek_Import.[Teljesítményértékelés - Beállási százalék] AS [Teljesítményértékelés - Beállási százalék], tSzemélyek_Import.[Teljesítményértékelés - Pontszám] AS [Teljesítményértékelés - Pontszám], tSzemélyek_Import.[Teljesítményértékelés - Megjegyzés] AS [Teljesítményértékelés - Megjegyzés], tSzemélyek_Import.[Dolgozói jellemzők] AS [Dolgozói jellemzők], tSzemélyek_Import.[Fizetési osztály (KA)/ Pedagógusi fokozat (KA pedagógus)/besorol] AS [Fizetési osztály (KA)/ Pedagógusi fokozat (KA pedagógus)/besorol], tSzemélyek_Import.[Besorolási  fokozat (KT)] AS [Besorolási  fokozat (KT)], tSzemélyek_Import.[Jogfolytonos idő kezdete] AS [Jogfolytonos idő kezdete], tSzemélyek_Import.[Jogviszony kezdete (belépés dátuma)] AS [Jogviszony kezdete (belépés dátuma)], tSzemélyek_Import.[Jogviszony vége (kilépés dátuma)] AS [Jogviszony vége (kilépés dátuma)], tSzemélyek_Import.[Utolsó munkában töltött nap] AS [Utolsó munkában töltött nap], tSzemélyek_Import.[Kezdeményezés dátuma] AS [Kezdeményezés dátuma], tSzemélyek_Import.[Hatályossá válik] AS [Hatályossá válik], tSzemélyek_Import.[HR kapcsolat megszűnés módja (Kilépés módja)] AS [HR kapcsolat megszűnés módja (Kilépés módja)], tSzemélyek_Import.[HR kapcsolat megszűnes indoka (Kilépés indoka)] AS [HR kapcsolat megszűnes indoka (Kilépés indoka)], tSzemélyek_Import.Indokolás AS Indokolás, tSzemélyek_Import.[Következő munkahely] AS [Következő munkahely], tSzemélyek_Import.[MT: Felmondási idő kezdete KJT, KTTV: Felmentési idő kezdete] AS [MT: Felmondási idő kezdete KJT, KTTV: Felmentési idő kezdete], tSzemélyek_Import.[Felmondási idő vége (MT) Felmentési idő vége (KJT, KTTV)] AS [Felmondási idő vége (MT) Felmentési idő vége (KJT, KTTV)], tSzemélyek_Import.[Munkavégzés alóli mentesítés kezdete (KJT, KTTV) Felmentési idő ] AS [Munkavégzés alóli mentesítés kezdete (KJT, KTTV) Felmentési idő ], tSzemélyek_Import.[Munkavégzés alóli mentesítés vége (KJT, KTTV) Felmentési idő vég] AS [Munkavégzés alóli mentesítés vége (KJT, KTTV) Felmentési idő vég], tSzemélyek_Import.[Tartós távollét típusa] AS [Tartós távollét típusa], tSzemélyek_Import.[Tartós távollét kezdete] AS [Tartós távollét kezdete], tSzemélyek_Import.[Tartós távollét vége] AS [Tartós távollét vége], tSzemélyek_Import.[Tartós távollét tervezett vége] AS [Tartós távollét tervezett vége], tSzemélyek_Import.[Helyettesített dolgozó neve] AS [Helyettesített dolgozó neve], tSzemélyek_Import.[Szerződés/Kinevezés - próbaidő vége] AS [Szerződés/Kinevezés - próbaidő vége], tSzemélyek_Import.[Utalási cím] AS [Utalási cím], tSzemélyek_Import.[Alapilletmény / Munkabér / Megbízási díj (eltérítés nélküli)] AS [Alapilletmény / Munkabér / Megbízási díj (eltérítés nélküli)], tSzemélyek_Import.[Garantált bérminimumra történő kiegészítés] AS [Garantált bérminimumra történő kiegészítés], tSzemélyek_Import.Kerekítés AS Kerekítés, tSzemélyek_Import.[Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS % (eltérít] AS [Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS % (eltérít], tSzemélyek_Import.[Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS összeg (el] AS [Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS összeg (el], tSzemélyek_Import.[Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY % (eltérítés nélküli)] AS [Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY % (eltérítés nélküli)], tSzemélyek_Import.[Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY összeg (eltérítés nél] AS [Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY összeg (eltérítés nél], tSzemélyek_Import.[Egyéb pótlék - összeg (eltérítés nélküli)] AS [Egyéb pótlék - összeg (eltérítés nélküli)], tSzemélyek_Import.[Illetmény összesen kerekítés nélkül (eltérítés nélküli)] AS [Illetmény összesen kerekítés nélkül (eltérítés nélküli)], tSzemélyek_Import.[Kerekített 100 %-os illetmény (eltérítés nélküli)] AS [Kerekített 100 %-os illetmény (eltérítés nélküli)], tSzemélyek_Import.[Eltérítés %] AS [Eltérítés %], tSzemélyek_Import.[Alapilletmény / Munkabér / Megbízási díj (eltérített)] AS [Alapilletmény / Munkabér / Megbízási díj (eltérített)], tSzemélyek_Import.[Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS % (eltérí1] AS [Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS % (eltérí1], tSzemélyek_Import.[Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS összeg (e1] AS [Egyéb pótlék, GARANTÁLT BÉRMINIMUMRA VALÓ KIEGÉSZÍTÉS összeg (e1], tSzemélyek_Import.[Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY % (eltérített)] AS [Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY % (eltérített)], tSzemélyek_Import.[Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY összeg (eltérített)] AS [Egyéb pótlék, KEREKÍTÉSBŐL ADÓDÓ ILLETMÉNY összeg (eltérített)], tSzemélyek_Import.[Egyéb pótlék - összeg (eltérített)] AS [Egyéb pótlék - összeg (eltérített)], tSzemélyek_Import.[Illetmény összesen kerekítés nélkül (eltérített)] AS [Illetmény összesen kerekítés nélkül (eltérített)], tSzemélyek_Import.[Kerekített 100 %-os illetmény (eltérített)] AS [Kerekített 100 %-os illetmény (eltérített)], tSzemélyek_Import.[További munkavégzés helye 1 Teljes munkaidő %-a] AS [További munkavégzés helye 1 Teljes munkaidő %-a], tSzemélyek_Import.[További munkavégzés helye 2 Teljes munkaidő %-a] AS [További munkavégzés helye 2 Teljes munkaidő %-a], tSzemélyek_Import.[KT: Kerekített 100 %-os illetmény (eltérített) + Helyettesítési ] AS [KT: Kerekített 100 %-os illetmény (eltérített) + Helyettesítési ], tSzemélyek_Import.[Szint 1 szervezeti egység név] AS [Szint 1 szervezeti egység név], tSzemélyek_Import.[Szint 1 szervezeti egység kód] AS [Szint 1 szervezeti egység kód], tSzemélyek_Import.[Szint 2 szervezeti egység név] AS [Szint 2 szervezeti egység név], tSzemélyek_Import.[Szint 2 szervezeti egység kód] AS [Szint 2 szervezeti egység kód], tSzemélyek_Import.[Szint 3 szervezeti egység név] AS [Szint 3 szervezeti egység név], tSzemélyek_Import.[Szint 3 szervezeti egység kód] AS [Szint 3 szervezeti egység kód], tSzemélyek_Import.[Szint 4 szervezeti egység név] AS [Szint 4 szervezeti egység név], tSzemélyek_Import.[Szint 4 szervezeti egység kód] AS [Szint 4 szervezeti egység kód], tSzemélyek_Import.[Szint 5 szervezeti egység név] AS [Szint 5 szervezeti egység név], tSzemélyek_Import.[Szint 5 szervezeti egység kód] AS [Szint 5 szervezeti egység kód], tSzemélyek_Import.[AD egyedi azonosító] AS [AD egyedi azonosító], tSzemélyek_Import.[Hivatali email] AS [Hivatali email], tSzemélyek_Import.[Hivatali mobil] AS [Hivatali mobil], tSzemélyek_Import.[Hivatali telefon] AS [Hivatali telefon], tSzemélyek_Import.[Hivatali telefon mellék] AS [Hivatali telefon mellék], tSzemélyek_Import.Iroda AS Iroda, tSzemélyek_Import.[Otthoni e-mail] AS [Otthoni e-mail], tSzemélyek_Import.[Otthoni mobil] AS [Otthoni mobil], tSzemélyek_Import.[Otthoni telefon] AS [Otthoni telefon], tSzemélyek_Import.[További otthoni mobil] AS [További otthoni mobil]
FROM tSzemélyek_Import;

#/#/#/
tmplkHiányzóKinevezésekDátumastb
#/#/
SELECT lkSzemélyek.Főosztály, kt_azNexon_Adójel02.azNexon, lkSzemélyek.Adójel, lkSzemélyek.[Jogviszony kezdete (belépés dátuma)], tmpHiányzóKinevezésDátuma.Azonosító, kt_azNexon_Adójel02.azNexon, lkSzemélyek.[Dolgozó teljes neve], lkSzemélyek.[KIRA feladat megnevezés], lkSzemélyek.Feladatkör, lkSzemélyek.[Elsődleges feladatkör], lkSzemélyek.Feladatok, lkSzemélyek.[KIRA feladat azonosítója - intézmény prefix-szel ellátva], lkSzemélyek.[KIRA feladat azonosítója]
FROM kt_azNexon_Adójel02 INNER JOIN (tmpHiányzóKinevezésDátuma INNER JOIN lkSzemélyek ON tmpHiányzóKinevezésDátuma.F1 = lkSzemélyek.Adójel) ON kt_azNexon_Adójel02.Adójel = tmpHiányzóKinevezésDátuma.F1
WHERE (((lkSzemélyek.[Jogviszony kezdete (belépés dátuma)]) Between Date() And #5/13/2024#));

#/#/#/
tmplkNapokKilépők
#/#/
SELECT [Főosztály] & [Osztály] AS Kif1, tNapok03.Nap, Sum(tKiBelépőkLétszáma.Fő) AS SumOfFő
FROM tKiBelépőkLétszáma INNER JOIN tNapok03 ON tKiBelépőkLétszáma.Dátum = tNapok03.Dátum
WHERE (((tNapok03.Év)=2023))
GROUP BY [Főosztály] & [Osztály], tNapok03.Nap;

#/#/#/
tNexonAzonosítók - azonosak keresése
#/#/
SELECT tNexonAzonosítók.[Személy azonosító], tNexonAzonosítók.[HR kapcsolat azonosító], First(tNexonAzonosítók.Azonosító) AS FirstOfAzonosító
FROM tNexonAzonosítók
GROUP BY tNexonAzonosítók.[Személy azonosító], tNexonAzonosítók.[HR kapcsolat azonosító]
HAVING (((tNexonAzonosítók.[Személy azonosító]) In (SELECT [Személy azonosító] FROM [tNexonAzonosítók] As Tmp GROUP BY [Személy azonosító],[HR kapcsolat azonosító] HAVING Count(*)>1  And [HR kapcsolat azonosító] = [tNexonAzonosítók].[HR kapcsolat azonosító])))
ORDER BY tNexonAzonosítók.[Személy azonosító], tNexonAzonosítók.[HR kapcsolat azonosító], First(tNexonAzonosítók.Azonosító) DESC;

#/#/#/
tSzemélyMezők - azonosak keresése
#/#/
SELECT tSzemélyMezők.Mezőnév, tSzemélyMezők.Típus, tSzemélyMezők.Az
FROM tSzemélyMezők
WHERE (((tSzemélyMezők.Mezőnév) In (SELECT [Mezőnév] FROM [tSzemélyMezők] As Tmp GROUP BY [Mezőnév],[Típus] HAVING Count(*)>1  And [Típus] = [tSzemélyMezők].[Típus])))
ORDER BY tSzemélyMezők.Mezőnév, tSzemélyMezők.Típus;

#/#/#/
tSzervezet
#/#/
SELECT tSzervezeti.*
FROM tSzervezeti;

#/#/#/
tSzervezetiEgységek - azonosak keresése
#/#/
SELECT tSzervezetiEgységek.[Szervezeti egység kódja], tSzervezetiEgységek.azSzervezet, tSzervezetiEgységek.Főosztály, tSzervezetiEgységek.Osztály
FROM tSzervezetiEgységek
WHERE (((tSzervezetiEgységek.[Szervezeti egység kódja]) In (SELECT [Szervezeti egység kódja] FROM [tSzervezetiEgységek] As Tmp GROUP BY [Szervezeti egység kódja] HAVING Count(*)>1 )))
ORDER BY tSzervezetiEgységek.[Szervezeti egység kódja];

#/#/#/
xxx_01_azNexon_és_Adójel_a_tSzemélyek_táblához
#/#/
ALTER TABLE tSzemélyek
ADD COLUMN Adójel Double, azNexon Double;
#/#/#/
xxx_02_Adóazonosító_jel_Konv_Adójel
#/#/
UPDATE tSzemélyek SET tSzemélyek.Adójel = [Adóazonosító jel]*1;

#/#/#/
xxx_03_azNexon_frissítése_tk_Nexon-ból
#/#/
UPDATE kt_azNexon_Adójel INNER JOIN tSzemélyek ON kt_azNexon_Adójel.Adójel=tSzemélyek.Adójel SET tSzemélyek.azNexon = [kt_azNexon_Adójel].[azNexon];

