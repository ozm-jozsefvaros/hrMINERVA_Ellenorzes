-- [20241001OrvosiAlkalmass�gi1]
SELECT [20241001OrvosiAlkalmass�gi].F�oszt�ly, [20241001OrvosiAlkalmass�gi].Oszt�ly, [20241001OrvosiAlkalmass�gi].[TAJ sz�m], IIf([Orvosi vizsg�lat id�pontja]<>dt�tal([D�tum]) And Not IsNull([D�tum]),dt�tal([D�tum]),[20241001OrvosiAlkalmass�gi].[Orvosi vizsg�lat k�vetkez� id�pontja]) AS K�vetkez�, IIf(IsNull([K�vetkez�]),"2501",IIf(Right(0 & Year([K�vetkez�]),2) & Right(0 & Month([K�vetkez�]),2)<"2411","25" & Right(0 & Month([K�vetkez�]),2),Right(0 & Year([K�vetkez�]),2) & Right(0 & Month([K�vetkez�]),2))) AS �vH�_
FROM [tOrvosiAlkalmass�giVizsg�latok202310-202408�sszef�z�tt] RIGHT JOIN 20241001OrvosiAlkalmass�gi ON [tOrvosiAlkalmass�giVizsg�latok202310-202408�sszef�z�tt].TAJ = [20241001OrvosiAlkalmass�gi].[TAJ sz�m]
WHERE ((([20241001OrvosiAlkalmass�gi].[TAJ sz�m]) Is Not Null));

-- [20241001OrvosiAlkalmass�gi2a]
SELECT [20241001OrvosiAlkalmass�gi1].F�oszt�ly, [20241001OrvosiAlkalmass�gi1].Oszt�ly, [20241001OrvosiAlkalmass�gi1].[TAJ sz�m], [20241001OrvosiAlkalmass�gi1].�vh�_ AS �vH�
FROM 20241001OrvosiAlkalmass�gi1
WHERE ((([20241001OrvosiAlkalmass�gi1].�vh�_) Between "2411" And "2602"));

-- [20241001OrvosiAlkalmass�gi2b]
SELECT [20241001OrvosiAlkalmass�gi1].F�oszt�ly, [20241001OrvosiAlkalmass�gi1].Oszt�ly, [20241001OrvosiAlkalmass�gi1].[TAJ sz�m], ([�VH�_]*1+100) & "" AS �vH�
FROM 20241001OrvosiAlkalmass�gi1;

-- [20241001OrvosiAlkalmass�gi3]
TRANSFORM Count([24_26].TAJ) AS [SumOfTAJ sz�m]
SELECT 1 AS Sor, [24_26].Szervezet
FROM (SELECT [F�oszt�ly] &" "& [Oszt�ly] AS Szervezet, ([TAJ sz�m]) as Taj, �vH�
FROM 20241001OrvosiAlkalmass�gi2b

UNION SELECT [F�oszt�ly] &" "& [Oszt�ly] AS Szervezet, ([TAJ sz�m]) as Taj, �vH�
FROM 20241001OrvosiAlkalmass�gi2a
)  AS 24_26
WHERE ((([24_26].�vH�) Between "2411" And "2602"))
GROUP BY 1, [24_26].Szervezet
PIVOT [24_26].�vH�;

-- [20241001OrvosiAlkalmass�gi3Mind�sszesen]
SELECT Count([24_26].[TAJ sz�m]) AS [CountOfTAJ sz�m]
FROM (SELECT [F�oszt�ly] & [Oszt�ly] AS Szervezet, [TAJ sz�m], �vH�
FROM 20241001OrvosiAlkalmass�gi2b
UNION SELECT [F�oszt�ly] & [Oszt�ly] AS Szervezet, [TAJ sz�m], �vH�
FROM 20241001OrvosiAlkalmass�gi2a)  AS 24_26
WHERE ((([24_26].�vH�) Between "2411" And "2602"))
GROUP BY 2;

-- [20241001OrvosiAlkalmass�gi3�sszegOszlop]
TRANSFORM Count([24_26].[TAJ sz�m]) AS [CountOfTAJ sz�m]
SELECT [24_26].Szervezet
FROM (SELECT [F�oszt�ly] &" " & [Oszt�ly] AS Szervezet, [TAJ sz�m], �vH�
FROM 20241001OrvosiAlkalmass�gi2b
UNION SELECT [F�oszt�ly] & " " & [Oszt�ly] AS Szervezet, [TAJ sz�m], �vH�
FROM 20241001OrvosiAlkalmass�gi2a)  AS 24_26
WHERE ((([24_26].�vH�) Between "2411" And "2602"))
GROUP BY 1, [24_26].Szervezet
PIVOT "�sszesen";

-- [20241001OrvosiAlkalmass�gi3�sszegoszloppal]
SELECT [20241001OrvosiAlkalmass�gi3].Sor, [20241001OrvosiAlkalmass�gi3].Szervezet, [20241001OrvosiAlkalmass�gi3].[2411] AS 2411, [20241001OrvosiAlkalmass�gi3].[2412] AS 2412, [20241001OrvosiAlkalmass�gi3].[2501] AS 2501, [20241001OrvosiAlkalmass�gi3].[2502] AS 2502, [20241001OrvosiAlkalmass�gi3].[2503] AS 2503, [20241001OrvosiAlkalmass�gi3].[2504] AS 2504, [20241001OrvosiAlkalmass�gi3].[2505] AS 2505, [20241001OrvosiAlkalmass�gi3].[2506] AS 2506, [20241001OrvosiAlkalmass�gi3].[2507] AS 2507, [20241001OrvosiAlkalmass�gi3].[2508] AS 2508, [20241001OrvosiAlkalmass�gi3].[2509] AS 2509, [20241001OrvosiAlkalmass�gi3].[2510] AS 2510, [20241001OrvosiAlkalmass�gi3].[2511] AS 2511, [20241001OrvosiAlkalmass�gi3].[2512] AS 2512, [20241001OrvosiAlkalmass�gi3].[2601] AS 2601, [20241001OrvosiAlkalmass�gi3].[2602] AS 2602, [20241001OrvosiAlkalmass�gi3�sszegOszlop].�sszesen AS �sszesen
FROM 20241001OrvosiAlkalmass�gi3 INNER JOIN 20241001OrvosiAlkalmass�gi3�sszegOszlop ON [20241001OrvosiAlkalmass�gi3].Szervezet = [20241001OrvosiAlkalmass�gi3�sszegOszlop].Szervezet;

-- [20241001OrvosiAlkalmass�gi3�sszegsor]
TRANSFORM Count([24_26].[TAJ sz�m]) AS [CountOfTAJ sz�m]
SELECT 2 AS Sor, "Hivatal �sszesen:" AS Szervezet
FROM (SELECT [F�oszt�ly] & [Oszt�ly] AS Szervezet, [TAJ sz�m], �vH�
FROM 20241001OrvosiAlkalmass�gi2b
UNION SELECT [F�oszt�ly] & [Oszt�ly] AS Szervezet, [TAJ sz�m], �vH�
FROM 20241001OrvosiAlkalmass�gi2a)  AS 24_26
WHERE ((([24_26].�vH�) Between "2411" And "2602"))
GROUP BY 2, "Hivatal �sszesen:"
PIVOT [24_26].�vH�;

-- [20241001OrvosiAlkalmass�gi3�sszegsorMind�sszesennel]
SELECT [20241001OrvosiAlkalmass�gi3�sszegsor].*, [20241001OrvosiAlkalmass�gi3Mind�sszesen].[CountOfTAJ sz�m]
FROM 20241001OrvosiAlkalmass�gi3�sszegsor, 20241001OrvosiAlkalmass�gi3Mind�sszesen;

-- [20241001OrvosiAlkalmass�gi4]
SELECT [20241001OrvosiAlkalmass�gi3�sszegoszloppal].*
FROM  20241001OrvosiAlkalmass�gi3�sszegoszloppal
UNION SELECT  [20241001OrvosiAlkalmass�gi3�sszegsorMind�sszesennel].*
FROM 20241001OrvosiAlkalmass�gi3�sszegsorMind�sszesennel;

-- [25_�let�v�ket_bet�lt�k]
SELECT lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Kerek�tett 100 %-os illetm�ny (elt�r�t�s n�lk�li)] AS Illetm�ny, lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS [Bel�p�s d�tuma]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Sz�let�si id�]) Between #1/1/1999# And #12/31/1999#) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [aaaExcelbe]
SELECT lkSzem�lyek.*
FROM lkSzem�lyek;

-- [alkSzem�lyek_csak_az_utols�_el�fordul�sok]
SELECT lkSzem�lyek.Ad�jel, Max(lkSzem�lyek.[Jogviszony sorsz�ma]) AS [MaxOfJogviszony sorsz�ma], Max(lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)]) AS [MaxOfJogviszony kezdete (bel�p�s d�tuma)], First(lkSzem�lyek.Azonos�t�) AS azSzem�ly
FROM lkSzem�lyek
GROUP BY lkSzem�lyek.Ad�jel
ORDER BY lkSzem�lyek.Ad�jel, Max(lkSzem�lyek.[Jogviszony sorsz�ma]) DESC , Max(lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)]) DESC;

-- [�ll�shely_Jel]
SELECT lk�ll�shelyek.[�ll�shely azonos�t�], lk�ll�shelyek.jel
FROM lk�ll�shelyek;

-- [C�mek_�sszevet�se]
SELECT tTelephelyek.Mez�1 AS F�oszt�ly, tTelephelyek.[Szervezeti egys�g], lkSzem�lyek.[Szint 5 szervezeti egys�g n�v], lkSzem�lyek.[Dolgoz� teljes neve], tTelephelyek.C�m, lkSzem�lyek.[Munkav�gz�s helye - c�m], Left([C�m],4) AS Kif1, Left([Munkav�gz�s helye - c�m],4) AS Kif1
FROM lkSzem�lyek LEFT JOIN tTelephelyek ON lkSzem�lyek.[Szervezeti egys�g k�dja] = tTelephelyek.SzervezetK�d
WHERE (((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null))
ORDER BY tTelephelyek.[Szervezeti egys�g];

-- [ideigllkMobilModulKieg]
SELECT ideiglMobilModulKieg.[Dolgoz� teljes neve], ideiglMobilModulKieg.[Hivatali email], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, kt_azNexon_Ad�jel02.azNexon
FROM kt_azNexon_Ad�jel02 RIGHT JOIN (lkSzem�lyek RIGHT JOIN ideiglMobilModulKieg ON lkSzem�lyek.[Hivatali email] = ideiglMobilModulKieg.[Hivatali email] OR ideiglMobilModulKieg.[Dolgoz� teljes neve]=lkSzem�lyek.[Dolgoz� teljes neve]) ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel;

-- [kt_azNexon_Ad�jel]
SELECT tNexonAzonos�t�k.Azonos�t�, tNexonAzonos�t�k.N�v, tNexonAzonos�t�k.[Szem�ly azonos�t�] AS azNexon, [tnexonazonos�t�k].[Ad�azonos�t� jel]*1 AS Ad�jel, "<a href=""https://nexonport.kh.gov.hu/menu/hrmapp/szemelytorzs/szemelyikarton?szemelyAzonosito=" & [azNexon] & "&r=13"" target=""_blank"">" & [Dolgoz� teljes neve] & "</a>" AS NLink, (SELECT COUNT(tnexonazonos�t�k.Azonos�t�) 
        FROM tNexonAzonos�t�k AS Tmp 
        Where (Tmp.Kezdete >= tNexonAzonos�t�k.Kezdete
        AND Tmp.[Szem�ly azonos�t�] = tNexonAzonos�t�k.[Szem�ly azonos�t�]) AND  Tmp.[Azonos�t�] > tNexonAzonos�t�k.[Azonos�t�]
)+1 AS Sorsz�m
FROM tNexonAzonos�t�k INNER JOIN lkSzem�lyek ON tNexonAzonos�t�k.[Ad�azonos�t� jel] = lkSzem�lyek.[Ad�azonos�t� jel]
ORDER BY tNexonAzonos�t�k.N�v;

-- [kt_azNexon_Ad�jel_ - azonosak keres�se]
SELECT First(kt_azNexon_Ad�jel.[azNexon]) AS [azNexon Mez�], First(kt_azNexon_Ad�jel.[Ad�jel]) AS [Ad�jel Mez�], Count(kt_azNexon_Ad�jel.[azNexon]) AS AzonosakSz�ma
FROM kt_azNexon_Ad�jel
GROUP BY kt_azNexon_Ad�jel.[azNexon], kt_azNexon_Ad�jel.[Ad�jel]
HAVING (((Count([kt_azNexon_Ad�jel].[azNexon]))>1) AND ((Count([kt_azNexon_Ad�jel].[Ad�jel]))>1));

-- [kt_azNexon_Ad�jel02]
SELECT kt_azNexon_Ad�jel.Azonos�t�, kt_azNexon_Ad�jel.N�v, kt_azNexon_Ad�jel.azNexon, kt_azNexon_Ad�jel.Ad�jel, kt_azNexon_Ad�jel.NLink, kt_azNexon_Ad�jel.Sorsz�m
FROM kt_azNexon_Ad�jel
WHERE (((kt_azNexon_Ad�jel.Sorsz�m)=1));

-- [Lek�rdez�s1]
SELECT DISTINCT [�ll�shely azonos�t�]
FROM lk�res�ll�shelyek001
UNION Select DISTINCT lk�res�ll�shelyek002.[�ll�shely azonos�t�]
FROM lk�res�ll�shelyek002;

-- [Lek�rdez�s10]
INSERT INTO tSzem�lyek IN 'L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\H�tt�rt�rak\Ellen�rz�s_0.9.6_h�tt�r_.mdb.accdb'
SELECT [tSzem�lyek_import].[Ad�jel] AS Ad�jel, [tSzem�lyek_import].[Dolgoz� teljes neve] AS [Dolgoz� teljes neve], [tSzem�lyek_import].[Dolgoz� sz�let�si neve] AS [Dolgoz� sz�let�si neve], [tSzem�lyek_import].[Sz�let�si id�] AS [Sz�let�si id�], [tSzem�lyek_import].[Sz�let�si hely] AS [Sz�let�si hely], [tSzem�lyek_import].[Anyja neve] AS [Anyja neve], [tSzem�lyek_import].[Neme] AS Neme, [tSzem�lyek_import].[T�rzssz�m] AS T�rzssz�m, [tSzem�lyek_import].[Egyedi azonos�t�] AS [Egyedi azonos�t�], [tSzem�lyek_import].[Ad�azonos�t� jel] AS [Ad�azonos�t� jel], [tSzem�lyek_import].[TAJ sz�m] AS [TAJ sz�m], [tSzem�lyek_import].[�gyf�lkapu k�d] AS [�gyf�lkapu k�d], [tSzem�lyek_import].[Els�dleges �llampolg�rs�g] AS [Els�dleges �llampolg�rs�g], [tSzem�lyek_import].[Szem�lyi igazolv�ny sz�ma] AS [Szem�lyi igazolv�ny sz�ma], [tSzem�lyek_import].[Szem�lyi igazolv�ny �rv�nyess�g kezdete] AS [Szem�lyi igazolv�ny �rv�nyess�g kezdete], [tSzem�lyek_import].[Szem�lyi igazolv�ny �rv�nyess�g v�ge] AS [Szem�lyi igazolv�ny �rv�nyess�g v�ge], [tSzem�lyek_import].[Nyelvtud�s Angol] AS [Nyelvtud�s Angol], [tSzem�lyek_import].[Nyelvtud�s Arab] AS [Nyelvtud�s Arab], [tSzem�lyek_import].[Nyelvtud�s Bolg�r] AS [Nyelvtud�s Bolg�r], [tSzem�lyek_import].[Nyelvtud�s Cig�ny] AS [Nyelvtud�s Cig�ny], [tSzem�lyek_import].[Nyelvtud�s Cig�ny (lov�ri)] AS [Nyelvtud�s Cig�ny (lov�ri)], [tSzem�lyek_import].[Nyelvtud�s Cseh] AS [Nyelvtud�s Cseh], [tSzem�lyek_import].[Nyelvtud�s Eszperant�] AS [Nyelvtud�s Eszperant�], [tSzem�lyek_import].[Nyelvtud�s Finn] AS [Nyelvtud�s Finn], [tSzem�lyek_import].[Nyelvtud�s Francia] AS [Nyelvtud�s Francia], [tSzem�lyek_import].[Nyelvtud�s H�ber] AS [Nyelvtud�s H�ber], [tSzem�lyek_import].[Nyelvtud�s Holland] AS [Nyelvtud�s Holland], [tSzem�lyek_import].[Nyelvtud�s Horv�t] AS [Nyelvtud�s Horv�t], [tSzem�lyek_import].[Nyelvtud�s Jap�n] AS [Nyelvtud�s Jap�n], [tSzem�lyek_import].[Nyelvtud�s Jelnyelv] AS [Nyelvtud�s Jelnyelv], [tSzem�lyek_import].[Nyelvtud�s K�nai] AS [Nyelvtud�s K�nai], [tSzem�lyek_import].[Nyelvtud�s Latin] AS [Nyelvtud�s Latin], [tSzem�lyek_import].[Nyelvtud�s Lengyel] AS [Nyelvtud�s Lengyel], [tSzem�lyek_import].[Nyelvtud�s N�met] AS [Nyelvtud�s N�met], [tSzem�lyek_import].[Nyelvtud�s Norv�g] AS [Nyelvtud�s Norv�g], [tSzem�lyek_import].[Nyelvtud�s Olasz] AS [Nyelvtud�s Olasz], [tSzem�lyek_import].[Nyelvtud�s Orosz] AS [Nyelvtud�s Orosz], [tSzem�lyek_import].[Nyelvtud�s Portug�l] AS [Nyelvtud�s Portug�l], [tSzem�lyek_import].[Nyelvtud�s Rom�n] AS [Nyelvtud�s Rom�n], [tSzem�lyek_import].[Nyelvtud�s Spanyol] AS [Nyelvtud�s Spanyol], [tSzem�lyek_import].[Nyelvtud�s Szerb] AS [Nyelvtud�s Szerb], [tSzem�lyek_import].[Nyelvtud�s Szlov�k] AS [Nyelvtud�s Szlov�k], [tSzem�lyek_import].[Nyelvtud�s Szlov�n] AS [Nyelvtud�s Szlov�n], [tSzem�lyek_import].[Nyelvtud�s T�r�k] AS [Nyelvtud�s T�r�k], [tSzem�lyek_import].[Nyelvtud�s �jg�r�g] AS [Nyelvtud�s �jg�r�g], [tSzem�lyek_import].[Nyelvtud�s Ukr�n] AS [Nyelvtud�s Ukr�n], [tSzem�lyek_import].[Orvosi vizsg�lat id�pontja] AS [Orvosi vizsg�lat id�pontja], [tSzem�lyek_import].[Orvosi vizsg�lat t�pusa] AS [Orvosi vizsg�lat t�pusa], [tSzem�lyek_import].[Orvosi vizsg�lat eredm�nye] AS [Orvosi vizsg�lat eredm�nye], [tSzem�lyek_import].[Orvosi vizsg�lat �szrev�telek] AS [Orvosi vizsg�lat �szrev�telek], [tSzem�lyek_import].[Orvosi vizsg�lat k�vetkez� id�pontja] AS [Orvosi vizsg�lat k�vetkez� id�pontja], [tSzem�lyek_import].[Erk�lcsi bizony�tv�ny sz�ma] AS [Erk�lcsi bizony�tv�ny sz�ma], [tSzem�lyek_import].[Erk�lcsi bizony�tv�ny d�tuma] AS [Erk�lcsi bizony�tv�ny d�tuma], [tSzem�lyek_import].[Erk�lcsi bizony�tv�ny eredm�nye] AS [Erk�lcsi bizony�tv�ny eredm�nye], [tSzem�lyek_import].[Erk�lcsi bizony�tv�ny k�relem azonos�t�] AS [Erk�lcsi bizony�tv�ny k�relem azonos�t�], [tSzem�lyek_import].[Erk�lcsi bizony�tv�ny k�z�gyekt�l eltiltva] AS [Erk�lcsi bizony�tv�ny k�z�gyekt�l eltiltva], [tSzem�lyek_import].[Erk�lcsi bizony�tv�ny j�rm�vezet�st�l eltiltva] AS [Erk�lcsi bizony�tv�ny j�rm�vezet�st�l eltiltva], [tSzem�lyek_import].[Erk�lcsi bizony�tv�ny int�zked�s alatt �ll] AS [Erk�lcsi bizony�tv�ny int�zked�s alatt �ll], [tSzem�lyek_import].[Munkak�ri le�r�sok (csatolt dokumentumok f�jlnevei)] AS [Munkak�ri le�r�sok (csatolt dokumentumok f�jlnevei)], [tSzem�lyek_import].[Egy�b HR dokumentumok (csatolt dokumentumok f�jlnevei)] AS [Egy�b HR dokumentumok (csatolt dokumentumok f�jlnevei)], [tSzem�lyek_import].[Korm�nyhivatal r�vid neve] AS [Korm�nyhivatal r�vid neve], [tSzem�lyek_import].[Szervezeti egys�g k�dja] AS [Szervezeti egys�g k�dja], [tSzem�lyek_import].[Szervezeti egys�g neve] AS [Szervezeti egys�g neve], [tSzem�lyek_import].[Szervezeti munkak�r neve] AS [Szervezeti munkak�r neve], [tSzem�lyek_import].[Vezet�i megb�z�s t�pusa] AS [Vezet�i megb�z�s t�pusa], [tSzem�lyek_import].[St�tusz k�dja] AS [St�tusz k�dja], [tSzem�lyek_import].[St�tusz k�lts�ghely�nek k�dja] AS [St�tusz k�lts�ghely�nek k�dja], [tSzem�lyek_import].[St�tusz k�lts�ghely�nek neve ] AS [St�tusz k�lts�ghely�nek neve ], [tSzem�lyek_import].[L�tsz�mon fel�l l�trehozott st�tusz] AS [L�tsz�mon fel�l l�trehozott st�tusz], [tSzem�lyek_import].[St�tusz t�pusa] AS [St�tusz t�pusa], [tSzem�lyek_import].[St�tusz neve] AS [St�tusz neve], [tSzem�lyek_import].[T�bbes bet�lt�s] AS [T�bbes bet�lt�s], [tSzem�lyek_import].[Vezet� neve] AS [Vezet� neve], [tSzem�lyek_import].[Vezet� ad�azonos�t� jele] AS [Vezet� ad�azonos�t� jele], [tSzem�lyek_import].[Vezet� email c�me] AS [Vezet� email c�me], [tSzem�lyek_import].[�lland� lakc�m] AS [�lland� lakc�m], [tSzem�lyek_import].[Tart�zkod�si lakc�m] AS [Tart�zkod�si lakc�m], [tSzem�lyek_import].[Levelez�si c�m_] AS [Levelez�si c�m_], [tSzem�lyek_import].[�regs�gi nyugd�j-korhat�r el�r�s�nek id�pontja (d�tum)] AS [�regs�gi nyugd�j-korhat�r el�r�s�nek id�pontja (d�tum)], [tSzem�lyek_import].[Nyugd�jas] AS Nyugd�jas, [tSzem�lyek_import].[Nyugd�j t�pusa] AS [Nyugd�j t�pusa], [tSzem�lyek_import].[Nyugd�jas kor� tov�bbfoglalkoztat�si enged�llyel rendelkezik] AS [Nyugd�jas kor� tov�bbfoglalkoztat�si enged�llyel rendelkezik], [tSzem�lyek_import].[Megv�ltozott munkak�pess�g] AS [Megv�ltozott munkak�pess�g], [tSzem�lyek_import].[�nk�ntes tartal�kos katona] AS [�nk�ntes tartal�kos katona], [tSzem�lyek_import].[Utols� vagyonnyilatkozat lead�s�nak d�tuma] AS [Utols� vagyonnyilatkozat lead�s�nak d�tuma], [tSzem�lyek_import].[Vagyonnyilatkozat nyilv�ntart�si sz�ma] AS [Vagyonnyilatkozat nyilv�ntart�si sz�ma], [tSzem�lyek_import].[K�vetkez� vagyonnyilatkozat esed�kess�ge] AS [K�vetkez� vagyonnyilatkozat esed�kess�ge], [tSzem�lyek_import].[Nemzetbiztons�gi ellen�rz�s d�tuma] AS [Nemzetbiztons�gi ellen�rz�s d�tuma], [tSzem�lyek_import].[V�dett �llom�nyba tartoz� munkak�r] AS [V�dett �llom�nyba tartoz� munkak�r], [tSzem�lyek_import].[Vezet�i megb�z�s t�pusa1] AS [Vezet�i megb�z�s t�pusa1], [tSzem�lyek_import].[Vezet�i beoszt�s megnevez�se] AS [Vezet�i beoszt�s megnevez�se], [tSzem�lyek_import].[Vezet�i beoszt�s (megb�z�s) kezdete] AS [Vezet�i beoszt�s (megb�z�s) kezdete], [tSzem�lyek_import].[Vezet�i beoszt�s (megb�z�s) v�ge] AS [Vezet�i beoszt�s (megb�z�s) v�ge], [tSzem�lyek_import].[Iskolai v�gzetts�g foka] AS [Iskolai v�gzetts�g foka], [tSzem�lyek_import].[Iskolai v�gzetts�g neve] AS [Iskolai v�gzetts�g neve], [tSzem�lyek_import].[Alapvizsga k�telez�s d�tuma] AS [Alapvizsga k�telez�s d�tuma], [tSzem�lyek_import].[Alapvizsga let�tel t�nyleges hat�rideje] AS [Alapvizsga let�tel t�nyleges hat�rideje], [tSzem�lyek_import].[Alapvizsga mentess�g] AS [Alapvizsga mentess�g], [tSzem�lyek_import].[Alapvizsga mentess�g oka] AS [Alapvizsga mentess�g oka], [tSzem�lyek_import].[Szakvizsga k�telez�s d�tuma] AS [Szakvizsga k�telez�s d�tuma], [tSzem�lyek_import].[Szakvizsga let�tel t�nyleges hat�rideje] AS [Szakvizsga let�tel t�nyleges hat�rideje], [tSzem�lyek_import].[Szakvizsga mentess�g] AS [Szakvizsga mentess�g], [tSzem�lyek_import].[Foglalkoz�si viszony] AS [Foglalkoz�si viszony], [tSzem�lyek_import].[Foglalkoz�si viszony statisztikai besorol�sa] AS [Foglalkoz�si viszony statisztikai besorol�sa], [tSzem�lyek_import].[Dolgoz� szerz�d�ses/kinevez�ses munkak�re / kinevez�si okm�nyban] AS [Dolgoz� szerz�d�ses/kinevez�ses munkak�re / kinevez�si okm�nyban], [tSzem�lyek_import].[Beoszt�stervez�s helysz�nek] AS [Beoszt�stervez�s helysz�nek], [tSzem�lyek_import].[Beoszt�stervez�s tev�kenys�gek] AS [Beoszt�stervez�s tev�kenys�gek], [tSzem�lyek_import].[R�szleges t�vmunka szerz�d�s kezdete] AS [R�szleges t�vmunka szerz�d�s kezdete], [tSzem�lyek_import].[R�szleges t�vmunka szerz�d�s v�ge] AS [R�szleges t�vmunka szerz�d�s v�ge], [tSzem�lyek_import].[R�szleges t�vmunka szerz�d�s intervalluma] AS [R�szleges t�vmunka szerz�d�s intervalluma], [tSzem�lyek_import].[R�szleges t�vmunka szerz�d�s m�rt�ke] AS [R�szleges t�vmunka szerz�d�s m�rt�ke], [tSzem�lyek_import].[R�szleges t�vmunka szerz�d�s helysz�ne] AS [R�szleges t�vmunka szerz�d�s helysz�ne], [tSzem�lyek_import].[R�szleges t�vmunka szerz�d�s helysz�ne 2] AS [R�szleges t�vmunka szerz�d�s helysz�ne 2], [tSzem�lyek_import].[R�szleges t�vmunka szerz�d�s helysz�ne 3] AS [R�szleges t�vmunka szerz�d�s helysz�ne 3], [tSzem�lyek_import].[Egy�ni t�l�ra keret meg�llapod�s kezdete] AS [Egy�ni t�l�ra keret meg�llapod�s kezdete], [tSzem�lyek_import].[Egy�ni t�l�ra keret meg�llapod�s v�ge] AS [Egy�ni t�l�ra keret meg�llapod�s v�ge], [tSzem�lyek_import].[Egy�ni t�l�ra keret meg�llapod�s m�rt�ke] AS [Egy�ni t�l�ra keret meg�llapod�s m�rt�ke], [tSzem�lyek_import].[KIRA feladat azonos�t�ja - int�zm�ny prefix-szel ell�tva] AS [KIRA feladat azonos�t�ja - int�zm�ny prefix-szel ell�tva], [tSzem�lyek_import].[KIRA feladat azonos�t�ja] AS [KIRA feladat azonos�t�ja], [tSzem�lyek_import].[KIRA feladat megnevez�s] AS [KIRA feladat megnevez�s], [tSzem�lyek_import].[Osztott munkak�r] AS [Osztott munkak�r], [tSzem�lyek_import].[Funkci�csoport: k�d-megnevez�s] AS [Funkci�csoport: k�d-megnevez�s], [tSzem�lyek_import].[Funkci�: k�d-megnevez�s] AS [Funkci�: k�d-megnevez�s], [tSzem�lyek_import].[Dolgoz� k�lts�ghely�nek k�dja] AS [Dolgoz� k�lts�ghely�nek k�dja], [tSzem�lyek_import].[Dolgoz� k�lts�ghely�nek neve] AS [Dolgoz� k�lts�ghely�nek neve], [tSzem�lyek_import].[Feladatk�r] AS Feladatk�r, [tSzem�lyek_import].[Els�dleges feladatk�r] AS [Els�dleges feladatk�r], [tSzem�lyek_import].[Feladatok] AS Feladatok, [tSzem�lyek_import].[FEOR] AS FEOR, [tSzem�lyek_import].[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� napi �raker] AS [Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� napi �raker], [tSzem�lyek_import].[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker] AS [Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker], [tSzem�lyek_import].[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� havi �raker] AS [Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� havi �raker], [tSzem�lyek_import].[Szerz�d�s/Kinevez�s t�pusa] AS [Szerz�d�s/Kinevez�s t�pusa], [tSzem�lyek_import].[Iktat�sz�m] AS Iktat�sz�m, [tSzem�lyek_import].[Szerz�d�s/kinevez�s verzi�_�rv�nyess�g kezdete] AS [Szerz�d�s/kinevez�s verzi�_�rv�nyess�g kezdete], [tSzem�lyek_import].[Szerz�d�s/kinevez�s verzi�_�rv�nyess�g v�ge] AS [Szerz�d�s/kinevez�s verzi�_�rv�nyess�g v�ge], [tSzem�lyek_import].[Hat�rozott idej� _szerz�d�s/kinevez�s lej�r] AS [Hat�rozott idej� _szerz�d�s/kinevez�s lej�r], [tSzem�lyek_import].[Szerz�d�s dokumentum (csatolt dokumentumok f�jlnevei)] AS [Szerz�d�s dokumentum (csatolt dokumentumok f�jlnevei)], [tSzem�lyek_import].[Megjegyz�s (pl# hat�rozott szerz�d�s/kinevez�s oka)] AS [Megjegyz�s (pl# hat�rozott szerz�d�s/kinevez�s oka)], [tSzem�lyek_import].[Munkav�gz�s helye - megnevez�s] AS [Munkav�gz�s helye - megnevez�s], [tSzem�lyek_import].[Munkav�gz�s helye - c�m] AS [Munkav�gz�s helye - c�m], [tSzem�lyek_import].[Jogviszony t�pusa / jogviszony t�pus] AS [Jogviszony t�pusa / jogviszony t�pus], [tSzem�lyek_import].[Jogviszony sorsz�ma] AS [Jogviszony sorsz�ma], [tSzem�lyek_import].[KIRA jogviszony jelleg] AS [KIRA jogviszony jelleg], [tSzem�lyek_import].[K�lcs�nbe ad� c�g] AS [K�lcs�nbe ad� c�g], [tSzem�lyek_import].[Teljes�tm�ny�rt�kel�s - �rt�kel� szem�ly] AS [Teljes�tm�ny�rt�kel�s - �rt�kel� szem�ly], [tSzem�lyek_import].[Teljes�tm�ny�rt�kel�s - �rv�nyess�g kezdet] AS [Teljes�tm�ny�rt�kel�s - �rv�nyess�g kezdet], [tSzem�lyek_import].[Teljes�tm�ny�rt�kel�s - �rt�kelt id�szak kezdet] AS [Teljes�tm�ny�rt�kel�s - �rt�kelt id�szak kezdet], [tSzem�lyek_import].[Teljes�tm�ny�rt�kel�s - �rt�kelt id�szak v�ge] AS [Teljes�tm�ny�rt�kel�s - �rt�kelt id�szak v�ge], [tSzem�lyek_import].[Teljes�tm�ny�rt�kel�s d�tuma] AS [Teljes�tm�ny�rt�kel�s d�tuma], [tSzem�lyek_import].[Teljes�tm�ny�rt�kel�s - Be�ll�si sz�zal�k] AS [Teljes�tm�ny�rt�kel�s - Be�ll�si sz�zal�k], [tSzem�lyek_import].[Teljes�tm�ny�rt�kel�s - Pontsz�m] AS [Teljes�tm�ny�rt�kel�s - Pontsz�m], [tSzem�lyek_import].[Teljes�tm�ny�rt�kel�s - Megjegyz�s] AS [Teljes�tm�ny�rt�kel�s - Megjegyz�s], [tSzem�lyek_import].[Dolgoz�i jellemz�k] AS [Dolgoz�i jellemz�k], [tSzem�lyek_import].[Fizet�si oszt�ly (KA)/ Pedag�gusi fokozat (KA pedag�gus)/besorol] AS [Fizet�si oszt�ly (KA)/ Pedag�gusi fokozat (KA pedag�gus)/besorol], [tSzem�lyek_import].[Besorol�si  fokozat (KT)] AS [Besorol�si  fokozat (KT)], [tSzem�lyek_import].[Jogfolytonos id� kezdete] AS [Jogfolytonos id� kezdete], [tSzem�lyek_import].[Jogviszony kezdete (bel�p�s d�tuma)] AS [Jogviszony kezdete (bel�p�s d�tuma)], [tSzem�lyek_import].[Jogviszony v�ge (kil�p�s d�tuma)] AS [Jogviszony v�ge (kil�p�s d�tuma)], [tSzem�lyek_import].[Utols� munk�ban t�lt�tt nap] AS [Utols� munk�ban t�lt�tt nap], [tSzem�lyek_import].[Kezdem�nyez�s d�tuma] AS [Kezdem�nyez�s d�tuma], [tSzem�lyek_import].[Hat�lyoss� v�lik] AS [Hat�lyoss� v�lik], [tSzem�lyek_import].[HR kapcsolat megsz�n�s m�dja (Kil�p�s m�dja)] AS [HR kapcsolat megsz�n�s m�dja (Kil�p�s m�dja)], [tSzem�lyek_import].[HR kapcsolat megsz�nes indoka (Kil�p�s indoka)] AS [HR kapcsolat megsz�nes indoka (Kil�p�s indoka)], [tSzem�lyek_import].[Indokol�s] AS Indokol�s, [tSzem�lyek_import].[K�vetkez� munkahely] AS [K�vetkez� munkahely], [tSzem�lyek_import].[MT: Felmond�si id� kezdete KJT, KTTV: Felment�si id� kezdete] AS [MT: Felmond�si id� kezdete KJT, KTTV: Felment�si id� kezdete], [tSzem�lyek_import].[Felmond�si id� v�ge (MT) Felment�si id� v�ge (KJT, KTTV)] AS [Felmond�si id� v�ge (MT) Felment�si id� v�ge (KJT, KTTV)], [tSzem�lyek_import].[Munkav�gz�s al�li mentes�t�s kezdete (KJT, KTTV) Felment�si id� ] AS [Munkav�gz�s al�li mentes�t�s kezdete (KJT, KTTV) Felment�si id� ], [tSzem�lyek_import].[Munkav�gz�s al�li mentes�t�s v�ge (KJT, KTTV) Felment�si id� v�g] AS [Munkav�gz�s al�li mentes�t�s v�ge (KJT, KTTV) Felment�si id� v�g], [tSzem�lyek_import].[�tmeneti elt�r� foglalkoztat�s t�pusa] AS [�tmeneti elt�r� foglalkoztat�s t�pusa], [tSzem�lyek_import].[�tmeneti elt�r� foglalkoztat�s kezdete] AS [�tmeneti elt�r� foglalkoztat�s kezdete], [tSzem�lyek_import].[Tart�s t�voll�t t�pusa] AS [Tart�s t�voll�t t�pusa], [tSzem�lyek_import].[Tart�s t�voll�t kezdete] AS [Tart�s t�voll�t kezdete], [tSzem�lyek_import].[Tart�s t�voll�t v�ge] AS [Tart�s t�voll�t v�ge], [tSzem�lyek_import].[Tart�s t�voll�t tervezett v�ge] AS [Tart�s t�voll�t tervezett v�ge], [tSzem�lyek_import].[Helyettes�tett dolgoz� neve] AS [Helyettes�tett dolgoz� neve], [tSzem�lyek_import].[Szerz�d�s/Kinevez�s - pr�baid� v�ge] AS [Szerz�d�s/Kinevez�s - pr�baid� v�ge], [tSzem�lyek_import].[Utal�si c�m] AS [Utal�si c�m], [tSzem�lyek_import].[Alapilletm�ny / Munkab�r / Megb�z�si d�j (elt�r�t�s n�lk�li)] AS [Alapilletm�ny / Munkab�r / Megb�z�si d�j (elt�r�t�s n�lk�li)], [tSzem�lyek_import].[Garant�lt b�rminimumra t�rt�n� kieg�sz�t�s] AS [Garant�lt b�rminimumra t�rt�n� kieg�sz�t�s], [tSzem�lyek_import].[Kerek�t�s] AS Kerek�t�s, [tSzem�lyek_import].[Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S % (elt�r�t] AS [Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S % (elt�r�t], [tSzem�lyek_import].[Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S �sszeg (el] AS [Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S �sszeg (el], [tSzem�lyek_import].[Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY % (elt�r�t�s n�lk�li)] AS [Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY % (elt�r�t�s n�lk�li)], [tSzem�lyek_import].[Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY �sszeg (elt�r�t�s n�l] AS [Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY �sszeg (elt�r�t�s n�l], [tSzem�lyek_import].[Egy�b p�tl�k - �sszeg (elt�r�t�s n�lk�li)] AS [Egy�b p�tl�k - �sszeg (elt�r�t�s n�lk�li)], [tSzem�lyek_import].[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�t�s n�lk�li)] AS [Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�t�s n�lk�li)], [tSzem�lyek_import].[Kerek�tett 100 %-os illetm�ny (elt�r�t�s n�lk�li)] AS [Kerek�tett 100 %-os illetm�ny (elt�r�t�s n�lk�li)], [tSzem�lyek_import].[Elt�r�t�s %] AS [Elt�r�t�s %], [tSzem�lyek_import].[Alapilletm�ny / Munkab�r / Megb�z�si d�j (elt�r�tett)] AS [Alapilletm�ny / Munkab�r / Megb�z�si d�j (elt�r�tett)], [tSzem�lyek_import].[Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S % (elt�r�1] AS [Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S % (elt�r�1], [tSzem�lyek_import].[Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S �sszeg (e1] AS [Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S �sszeg (e1], [tSzem�lyek_import].[Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY % (elt�r�tett)] AS [Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY % (elt�r�tett)], [tSzem�lyek_import].[Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY �sszeg (elt�r�tett)] AS [Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY �sszeg (elt�r�tett)], [tSzem�lyek_import].[Egy�b p�tl�k - �sszeg (elt�r�tett)] AS [Egy�b p�tl�k - �sszeg (elt�r�tett)], [tSzem�lyek_import].[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)] AS [Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)], [tSzem�lyek_import].[Kerek�tett 100 %-os illetm�ny (elt�r�tett)] AS [Kerek�tett 100 %-os illetm�ny (elt�r�tett)], [tSzem�lyek_import].[Tov�bbi munkav�gz�s helye 1 Teljes munkaid� %-a] AS [Tov�bbi munkav�gz�s helye 1 Teljes munkaid� %-a], [tSzem�lyek_import].[Tov�bbi munkav�gz�s helye 2 Teljes munkaid� %-a] AS [Tov�bbi munkav�gz�s helye 2 Teljes munkaid� %-a], [tSzem�lyek_import].[KT: Kerek�tett 100 %-os illetm�ny (elt�r�tett) + Helyettes�t�si ] AS [KT: Kerek�tett 100 %-os illetm�ny (elt�r�tett) + Helyettes�t�si ], [tSzem�lyek_import].[Szint 1 szervezeti egys�g n�v] AS [Szint 1 szervezeti egys�g n�v], [tSzem�lyek_import].[Szint 1 szervezeti egys�g k�d] AS [Szint 1 szervezeti egys�g k�d], [tSzem�lyek_import].[Szint 2 szervezeti egys�g n�v] AS [Szint 2 szervezeti egys�g n�v], [tSzem�lyek_import].[Szint 2 szervezeti egys�g k�d] AS [Szint 2 szervezeti egys�g k�d], [tSzem�lyek_import].[Szint 3 szervezeti egys�g n�v] AS [Szint 3 szervezeti egys�g n�v], [tSzem�lyek_import].[Szint 3 szervezeti egys�g k�d] AS [Szint 3 szervezeti egys�g k�d], [tSzem�lyek_import].[Szint 4 szervezeti egys�g n�v] AS [Szint 4 szervezeti egys�g n�v], [tSzem�lyek_import].[Szint 4 szervezeti egys�g k�d] AS [Szint 4 szervezeti egys�g k�d], [tSzem�lyek_import].[Szint 5 szervezeti egys�g n�v] AS [Szint 5 szervezeti egys�g n�v], [tSzem�lyek_import].[Szint 5 szervezeti egys�g k�d] AS [Szint 5 szervezeti egys�g k�d], [tSzem�lyek_import].[Szint 6 szervezeti egys�g n�v] AS [Szint 6 szervezeti egys�g n�v], [tSzem�lyek_import].[Szint 6 szervezeti egys�g k�d] AS [Szint 6 szervezeti egys�g k�d], [tSzem�lyek_import].[Szint 7 szervezeti egys�g n�v] AS [Szint 7 szervezeti egys�g n�v], [tSzem�lyek_import].[Szint 7 szervezeti egys�g k�d] AS [Szint 7 szervezeti egys�g k�d], [tSzem�lyek_import].[AD egyedi azonos�t�] AS [AD egyedi azonos�t�], [tSzem�lyek_import].[Hivatali email] AS [Hivatali email], [tSzem�lyek_import].[Hivatali mobil] AS [Hivatali mobil], [tSzem�lyek_import].[Hivatali telefon] AS [Hivatali telefon], [tSzem�lyek_import].[Hivatali telefon mell�k] AS [Hivatali telefon mell�k], [tSzem�lyek_import].[Iroda] AS Iroda, [tSzem�lyek_import].[Otthoni e-mail] AS [Otthoni e-mail], [tSzem�lyek_import].[Otthoni mobil] AS [Otthoni mobil], [tSzem�lyek_import].[Otthoni telefon] AS [Otthoni telefon], [tSzem�lyek_import].[Tov�bbi otthoni mobil] AS [Tov�bbi otthoni mobil]
FROM tSzem�lyek_import;

-- [Lek�rdez�s11]
SELECT DISTINCT lkSzem�lyek.Ad�jel, lkSzem�lyek.Feladatk�r, lkSzem�lyek.[Els�dleges feladatk�r]
FROM lkSzem�lyek INNER JOIN lkSzem�lyek AS lkSzem�lyek_1 ON (lkSzem�lyek_1.Feladatk�r) Like "*" & ffsplit([lkSzem�lyek].[Feladatk�r],"-") & "*"
WHERE ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.Feladatk�r) Like "Lez�rt_*");

-- [Lek�rdez�s12]
SELECT tBesorol�sV�ltoztat�sok.�ll�shelyAzonos�t�, tBesorol�s�talak�t�Elt�r�Besorol�shoz.jel
FROM tBesorol�s�talak�t�Elt�r�Besorol�shoz INNER JOIN tBesorol�sV�ltoztat�sok ON tBesorol�s�talak�t�Elt�r�Besorol�shoz.[�ll�shely besorol�si kateg�ri�ja] = tBesorol�sV�ltoztat�sok.�jBesorol�s
WHERE (((tBesorol�sV�ltoztat�sok.Hat�ly)=#1/1/2025#));

-- [Lek�rdez�s13]
SELECT 
FROM lkVezet�k INNER JOIN tMeghagyand�kAr�nya ON lkVezet�k.BFKH = tMeghagyand�kAr�nya.BFKH;

-- [Lek�rdez�s14]
SELECT lkMeghagy�sVezet�k.[TAJ sz�m], ffsplit([Dolgoz� sz�let�si neve]," ",1) AS [Sz�let�si n�v1], ffsplit([Dolgoz� sz�let�si neve]," ",2) AS [Sz�let�si n�v2], IIf(ffsplit([Dolgoz� sz�let�si neve]," ",3)=ffsplit([Dolgoz� sz�let�si neve]," ",2) Or Left(ffsplit([Dolgoz� sz�let�si neve]," ",3),1)="(","",ffsplit([Dolgoz� sz�let�si neve]," ",3)) AS [Sz�let�si n�v3], IIf(InStr(1,[Dolgoz� teljes neve],"dr.",0),"dr.",IIf(InStr(1,[Dolgoz� teljes neve],"Dr.",0),"Dr.","")) AS El�tag, ffsplit([Dolgoz� teljes neve]," ",1) AS [H�zass�gi n�v1], ffsplit([Dolgoz� teljes neve]," ",2) AS [H�zass�gi n�v2], IIf(ffsplit([Dolgoz� teljes neve]," ",3)=ffsplit([Dolgoz� teljes neve]," ",2) Or Left(ffsplit([Dolgoz� teljes neve]," ",3),1)="(" Or Left(ffsplit([Dolgoz� teljes neve]," ",3),3)="dr." Or Left(ffsplit([Dolgoz� teljes neve]," ",3),3)="Dr.","",ffsplit([Dolgoz� teljes neve]," ",3)) AS [H�zass�gi n�v3], Trim(ffsplit(drLev�laszt([Anyja neve],False)," ",1)) AS [Anyja neve1], ffsplit(drLev�laszt([Anyja neve],False)," ",2) AS [Anyja neve2], IIf(ffsplit(drLev�laszt([Anyja neve],False)," ",3)=ffsplit(drLev�laszt([Anyja neve],False)," ",2) Or Left(ffsplit(drLev�laszt([Anyja neve],False)," ",3),1)="(","",ffsplit(drLev�laszt([Anyja neve],False)," ",3)) AS [Anyja neve3], lkMeghagy�sVezet�k.[Sz�let�si id�], lkMeghagy�sVezet�k.[Sz�let�si hely], lkMeghagy�sVezet�k.Feladatk�r�k AS munkak�r
FROM lkMeghagy�sVezet�k;

-- [Lek�rdez�s15]
SELECT ffsplit([Dolgoz� sz�let�si neve]," ",1) AS [Sz�let�si n�v1], ffsplit([Dolgoz� sz�let�si neve]," ",2) AS [Sz�let�si n�v2], IIf(ffsplit([Dolgoz� sz�let�si neve]," ",3)=ffsplit([Dolgoz� sz�let�si neve]," ",2) Or Left(ffsplit([Dolgoz� sz�let�si neve]," ",3),1)="(","",ffsplit([Dolgoz� sz�let�si neve]," ",3)) AS [Sz�let�si n�v3], IIf(InStr(1,[Dolgoz� teljes neve],"dr.",0),"dr.",IIf(InStr(1,[Dolgoz� teljes neve],"Dr.",0),"Dr.","")) AS El�tag, ffsplit([Dolgoz� teljes neve]," ",1) AS [H�zass�gi n�v1], ffsplit([Dolgoz� teljes neve]," ",2) AS [H�zass�gi n�v2], IIf(ffsplit([Dolgoz� teljes neve]," ",3)=ffsplit([Dolgoz� teljes neve]," ",2) Or Left(ffsplit([Dolgoz� teljes neve]," ",3),1)="(" Or Left(ffsplit([Dolgoz� teljes neve]," ",3),3)="dr." Or Left(ffsplit([Dolgoz� teljes neve]," ",3),3)="Dr.","",ffsplit([Dolgoz� teljes neve]," ",3)) AS [H�zass�gi n�v3], drLev�laszt([Anyja neve]) & " " & ffsplit(drLev�laszt([Anyja neve],False)," ",1) AS [Anyja neve1], ffsplit(drLev�laszt([Anyja neve],False)," ",2) AS [Anyja neve2], IIf(ffsplit(drLev�laszt([Anyja neve],False)," ",3)=ffsplit(drLev�laszt([Anyja neve],False)," ",2) Or Left(ffsplit(drLev�laszt([Anyja neve],False)," ",3),1)="(","",ffsplit(drLev�laszt([Anyja neve],False)," ",3)) AS [Anyja neve3], lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.[Sz�let�si hely], lkSzem�lyek.[KIRA feladat megnevez�s] AS munkak�r
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[KIRA feladat megnevez�s])="t�zv�delmi hat�s�gi feladatok" Or (lkSzem�lyek.[KIRA feladat megnevez�s])="iparbiztons�gi hat�s�gi feladatok") AND ((lkSzem�lyek.F�oszt�lyK�d)="BFKH.1.36.") AND ((lkSzem�lyek.Neme)="f�rfi") AND ((lkSzem�lyek.[KIRA jogviszony jelleg])="Korm�nyzati szolg�lati jogviszony (KIT)"));

-- [Lek�rdez�s2]
SELECT lkSzervezetenk�ntiL�tsz�madatok03.*
FROM lkSzervezetenk�ntiL�tsz�madatok03;

-- [Lek�rdez�s3]
SELECT lk_Garant�lt_b�rminimum_Illetm�nyek.[Dolgoz� teljes neve], lk_Garant�lt_b�rminimum_Illetm�nyek.[�ll�shely azonos�t�], lkSzem�lyek.[Besorol�si  fokozat (KT)]
FROM lkSzem�lyek INNER JOIN lk_Garant�lt_b�rminimum_Illetm�nyek ON lkSzem�lyek.tSzem�lyek.Ad�jel = lk_Garant�lt_b�rminimum_Illetm�nyek.Ad�jel
WHERE (((lk_Garant�lt_b�rminimum_Illetm�nyek.[�ll�shely azonos�t�]) In (SELECT lk_Garant�lt_b�rminimum_Illetm�nyek.[�ll�shely azonos�t�] FROM lk_Garant�lt_b�rminimum_Illetm�nyek LEFT JOIN lkSzem�lyek ON lk_Garant�lt_b�rminimum_Illetm�nyek.[�ll�shely azonos�t�] = lkSzem�lyek.[St�tusz k�dja] GROUP BY lk_Garant�lt_b�rminimum_Illetm�nyek.[�ll�shely azonos�t�] HAVING (((Count(lkSzem�lyek.[St�tusz k�dja]))>1)))));

-- [Lek�rdez�s4]
SELECT tInt�zked�sFajt�k.Int�zked�sFajta, tR�giHib�k.[Els� mez�], ktR�giHib�kInt�zked�sek.azInt�zked�sek, tR�giHib�k.[M�sodik mez�]
FROM tR�giHib�k INNER JOIN (tInt�zked�sFajt�k INNER JOIN (tInt�zked�sek INNER JOIN ktR�giHib�kInt�zked�sek ON tInt�zked�sek.azInt�zked�sek = ktR�giHib�kInt�zked�sek.azInt�zked�sek) ON tInt�zked�sFajt�k.azIntFajta = tInt�zked�sek.azIntFajta) ON tR�giHib�k.[Els� mez�] = ktR�giHib�kInt�zked�sek.HASH;

-- [Lek�rdez�s5]
SELECT tBej�v�Visszajelz�sek.Hash, Min(DateDiff("d",[tR�giHib�k].[Els� Id�pont],[tBej�v��zenetek].[DeliveredDate])) AS Kif1
FROM tR�giHib�k LEFT JOIN (tBej�v��zenetek RIGHT JOIN tBej�v�Visszajelz�sek ON tBej�v��zenetek.az�zenet = tBej�v�Visszajelz�sek.az�zenet) ON tR�giHib�k.[Els� mez�] = tBej�v�Visszajelz�sek.Hash
WHERE (((tBej�v�Visszajelz�sek.azVisszajelz�s) Is Not Null))
GROUP BY tBej�v�Visszajelz�sek.Hash;

-- [Lek�rdez�s6]
SELECT tR�giHib�k.lek�rdez�sNeve, Count(tR�giHib�k.[Els� mez�]) AS Hib�k, Count(lkktR�giHib�kInt�zked�sekLegutols�Int�zked�s.azInt�zked�sek) AS CountOfazInt�zked�sek
FROM tR�giHib�k LEFT JOIN lkktR�giHib�kInt�zked�sekLegutols�Int�zked�s ON tR�giHib�k.[Els� mez�] = lkktR�giHib�kInt�zked�sekLegutols�Int�zked�s.HASH
WHERE (((tR�giHib�k.[Utols� Id�pont])=(select max([utols� id�pont]) from tR�giHib�k )))
GROUP BY tR�giHib�k.lek�rdez�sNeve
HAVING (((tR�giHib�k.lek�rdez�sNeve)<>"lkLej�rtAlkalmass�gi�rv�nyess�g"));

-- [Lek�rdez�s7]
SELECT tmp�NYRekHavihoz.�NYR, lkSzem�lyek.[St�tusz k�dja], lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Ad�azonos�t� jel], Year([Sz�let�si id�]) AS [Sz�let�si �v], IIf([neme]="F�rfi",1,2) AS Kif1, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Szervezeti egys�g k�dja], lkSzem�lyek.[KIRA feladat megnevez�s], lkSzem�lyek.[Szerz�d�s/kinevez�s verzi�_�rv�nyess�g kezdete], "SZ" AS F, "T" AS T, 40 AS �ra, 1 AS Ar�ny, tBesorol�s�talak�t�Elt�r�Besorol�shoz.jel
FROM (lkSzem�lyek LEFT JOIN tmp�NYRekHavihoz ON lkSzem�lyek.[St�tusz k�dja] = tmp�NYRekHavihoz.�NYR) LEFT JOIN tBesorol�s�talak�t�Elt�r�Besorol�shoz ON lkSzem�lyek.[Besorol�si  fokozat (KT)] = tBesorol�s�talak�t�Elt�r�Besorol�shoz.[Besorol�si  fokozat (KT)]
WHERE (((tmp�NYRekHavihoz.�NYR) Is Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [Lek�rdez�s8]
SELECT tF�oszt�lyokOszt�lyokSorsz�mmal.F�oszt�ly, lkOrvosiAlkalmass�giTeljes�t�s�sszes�t�s01.Oszt�ly, lkOrvosiAlkalmass�giTeljes�t�s�sszes�t�s01.Alkalmass�giOszt�ly, lkOrvosiAlkalmass�giTeljes�t�s�sszes�t�s01.[Alk# tipus], lkOrvosiAlkalmass�giTeljes�t�s�sszes�t�s01.Egys�g�r, IIf(IsNull([lkOrvosiAlkalmass�giTeljes�t�s�sszes�t�s01].[F�oszt�ly]),0,1) AS Mennyis�g, lkOrvosiAlkalmass�giTeljes�t�s�sszes�t�s01.Egys�g�r AS [�sszes nett�]
FROM tF�oszt�lyokOszt�lyokSorsz�mmal LEFT JOIN lkOrvosiAlkalmass�giTeljes�t�s�sszes�t�s01 ON tF�oszt�lyokOszt�lyokSorsz�mmal.F�oszt�ly = lkOrvosiAlkalmass�giTeljes�t�s�sszes�t�s01.F�oszt�ly
WHERE (((tF�oszt�lyokOszt�lyokSorsz�mmal.F�oszt�ly) Is Not Null) AND ((lkOrvosiAlkalmass�giTeljes�t�s�sszes�t�s01.Oszt�ly) Is Null));

-- [Lek�rdez�s9]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], Eseti�NYRsz�mok.St�tuszK�d, lkSzem�lyek.[St�tusz neve]
FROM lkSzem�lyek LEFT JOIN Eseti�NYRsz�mok ON lkSzem�lyek.[St�tusz k�dja] = Eseti�NYRsz�mok.St�tuszK�d
WHERE (((Eseti�NYRsz�mok.St�tuszK�d) Is Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [lk__Besorol�sokHavi_vs_�nyr01]
SELECT lk__Besorol�sokHavib�l.BFKH, N�([lk�ll�shelyek].[F�oszt�ly�ll�shely],[J�r�si Hivatal]) AS F�oszt�ly�ll�shely, lk�ll�shelyek.[5 szint] AS Szervezet, lk__Besorol�sokHavib�l.[�ll�shely azonos�t�], lk�ll�shelyek.[�ll�shely besorol�si kateg�ri�ja] AS �NYR, Nz([lkBesorol�sV�ltoztat�sok].[�jBesorol�s],[tBesorol�s_�talak�t�].[Besorol�si_fokozat]) AS NexonHavi, lk__Besorol�sokHavib�l.[Besorol�si fokozat k�d:]
FROM lkBesorol�sV�ltoztat�sok RIGHT JOIN (lk�ll�shelyek RIGHT JOIN (tBesorol�s_�talak�t� RIGHT JOIN lk__Besorol�sokHavib�l ON (tBesorol�s_�talak�t�.[Az �ll�shely megynevez�se] = lk__Besorol�sokHavib�l.[Besorol�si fokozat megnevez�se:]) AND (tBesorol�s_�talak�t�.[Az �ll�shely jel�l�se] = lk__Besorol�sokHavib�l.[Besorol�si fokozat k�d:])) ON lk�ll�shelyek.[�ll�shely azonos�t�] = lk__Besorol�sokHavib�l.[�ll�shely azonos�t�]) ON lkBesorol�sV�ltoztat�sok.�ll�shelyAzonos�t� = lk__Besorol�sokHavib�l.[�ll�shely azonos�t�]
WHERE (((Nz([lkBesorol�sV�ltoztat�sok].[�jBesorol�s],[tBesorol�s_�talak�t�].[Besorol�si_fokozat]))<>Nz([�ll�shely besorol�si kateg�ri�ja],"")));

-- [lk__Besorol�sokHavi_vs_�nyr02]
SELECT lk__Besorol�sokHavi_vs_�nyr01.F�oszt�ly�ll�shely AS F�oszt�ly, lk__Besorol�sokHavi_vs_�nyr01.Szervezet AS Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lk__Besorol�sokHavi_vs_�nyr01.[�ll�shely azonos�t�] AS [St�tusz k�d], lk__Besorol�sokHavi_vs_�nyr01.NexonHavi AS [Nexon havi], lk__Besorol�sokHavi_vs_�nyr01.�NYR AS �NYR, lk__Besorol�sokHavi_vs_�nyr01.[Besorol�si fokozat k�d:] AS [Besorol�s k�d], kt_azNexon_Ad�jel02.NLink AS NLink
FROM (lkSzem�lyek RIGHT JOIN lk__Besorol�sokHavi_vs_�nyr01 ON lkSzem�lyek.[St�tusz k�dja] = lk__Besorol�sokHavi_vs_�nyr01.[�ll�shely azonos�t�]) LEFT JOIN kt_azNexon_Ad�jel02 ON lkSzem�lyek.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel
ORDER BY lk__Besorol�sokHavi_vs_�nyr01.BFKH;

-- [lk__Besorol�sokHavib�l]
SELECT Havib�lBesorol�sok.Z�na, Havib�lBesorol�sok.[�ll�shely azonos�t�], Havib�lBesorol�sok.[Besorol�si fokozat k�d:], Havib�lBesorol�sok.[Besorol�si fokozat megnevez�se:], Replace(Replace([Besorol�si fokozat k�d:],"Mt.",""),"��.","") AS Jel, Nz([Ad�azonos�t�],0)*1 AS Ad�jel, bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]) AS BFKH, Havib�lBesorol�sok.[J�r�si Hivatal]
FROM (SELECT J�r�si_�llom�ny.[�ll�shely azonos�t�]
, J�r�si_�llom�ny.[Besorol�si fokozat megnevez�se:]
, [Besorol�si fokozat k�d:]
, "Alapl�tsz�m" as Z�na
, Ad�azonos�t�
, [�NYR SZERVEZETI EGYS�G AZONOS�T�]
, [J�r�si Hivatal]
FROM  lkJ�r�si_�llom�ny
UNION
SELECT  Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�]
, Korm�nyhivatali_�llom�ny.[Besorol�si fokozat megnevez�se:]
, [Besorol�si fokozat k�d:]
, "Alapl�tsz�m" as Z�na
, Ad�azonos�t�
, [�NYR SZERVEZETI EGYS�G AZONOS�T�]
, F�oszt�ly
FROM  lkKorm�nyhivatali_�llom�ny
UNION
SELECT K�zpontos�tottak.[�ll�shely azonos�t�]
, K�zpontos�tottak.[Besorol�si fokozat megnevez�se:]
, [Besorol�si fokozat k�d:]
, "K�zpontos�tott" as Z�na
, Ad�azonos�t�
, [�NYR SZERVEZETI EGYS�G AZONOS�T�]
, F�oszt
FROM lkK�zpontos�tottak
)  AS Havib�lBesorol�sok;

-- [lk__Elt�r�_Szevezetnevek]
SELECT lk�ll�shelyek.F�oszt�ly�ll�shely AS [F�oszt�ly (�NYR)], lk�ll�shelyek.[5 szint] AS [Oszt�ly (�NYR)], lkSzem�lyek.F�oszt�ly AS [F�oszt�ly (Nexon Szem�lyi karton)], lkSzem�lyek.oszt�ly AS [Oszt�ly (Nexon Szem�lyi karton)], lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lk�ll�shelyek.[�ll�shely azonos�t�] AS [St�tusz k�d], kt_azNexon_Ad�jel02.NLink AS NLink
FROM (lk�ll�shelyek INNER JOIN (lkSzem�lyek LEFT JOIN tSzervezet ON lkSzem�lyek.[St�tusz k�dja] = tSzervezet.[Szervezetmenedzsment k�d]) ON lk�ll�shelyek.[�ll�shely azonos�t�] = lkSzem�lyek.[St�tusz k�dja]) LEFT JOIN kt_azNexon_Ad�jel02 ON lkSzem�lyek.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel
WHERE (((lk�ll�shelyek.[5 szint])<>[Szint 7 szervezeti egys�g n�v] And (lk�ll�shelyek.[5 szint])<>"") AND ((bfkh([Szervezeti egys�g k�dja])) Is Not Null) AND ((Date()) Between [�rv�nyess�g kezdete] And IIf([�rv�nyess�g v�ge]=0,#1/1/3000#,[�rv�nyess�g v�ge]))) OR (((lkSzem�lyek.F�oszt�ly)<>[lk�ll�shelyek].[F�oszt�ly�ll�shely]) AND ((bfkh([Szervezeti egys�g k�dja])) Is Not Null) AND ((Date()) Between [�rv�nyess�g kezdete] And IIf([�rv�nyess�g v�ge]=0,#1/1/3000#,[�rv�nyess�g v�ge])))
ORDER BY bfkh([Szervezeti egys�g k�dja]);

-- [lk__Elt�r�Besorol�sok]
SELECT DISTINCT lkSzervezet�ll�shelyek.SzervezetK�d, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Tart�s t�voll�t t�pusa], lkSzem�lyek.[Helyettes�tett dolgoz� neve], Replace([lkSzem�lyek].[F�oszt�ly],"Budapest F�v�ros Korm�nyhivatala ","BFKH ") AS F�oszt�ly, lkSzervezet�ll�shelyek.�ll�shely AS �ll�shely, �ll�shelyek.[�ll�shely besorol�si kateg�ri�ja] AS �NYR, lkSzem�lyek.Besorol�s AS [Szem�lyi karton], lkSzervezet�ll�shelyek.[Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s] AS [Szervezeti strukt�ra], "https://nexonport.kh.gov.hu/menu/hrm/szemelyiKarton/index?szemelyAzonosito=" & [azNexon] & "&r=13" AS Link, IIf(UCase$(Nz([�ll�shely besorol�si kateg�ri�ja],""))=UCase$(Nz([Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s],"")),True,False) AS �nyr_vs_Szervezeti, IIf(Nz([Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s],"")=Nz([lkSzem�lyek].[Besorol�s],""),True,False) AS Szervezeti_vs_Szem�lyi, IIf(UCase$(Nz([�ll�shely besorol�si kateg�ri�ja],""))=UCase$(Nz([lkSzem�lyek].[Besorol�s],"")),True,False) AS �ny_vs_Szem�lyi, lkSzervezet�ll�shelyek.Bet�lt�tt, kt_azNexon_Ad�jel.azNexon, lkSzem�lyek.ad�jel
FROM (kt_azNexon_Ad�jel RIGHT JOIN (lkSzervezet�ll�shelyek LEFT JOIN lkSzem�lyek ON lkSzervezet�ll�shelyek.�ll�shely = lkSzem�lyek.[St�tusz k�dja]) ON kt_azNexon_Ad�jel.Ad�jel = lkSzem�lyek.Ad�jel) LEFT JOIN �ll�shelyek ON lkSzervezet�ll�shelyek.�ll�shely = �ll�shelyek.[�ll�shely azonos�t�]
WHERE (((IIf(UCase$(Nz([�ll�shely besorol�si kateg�ri�ja],""))=UCase$(Nz([Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s],"")),True,False))=False) And ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]) Like "Munka*")) Or (((IIf(Nz([Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s],"")=Nz(lkSzem�lyek.Besorol�s,""),True,False))=False) And ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]) Not Like "Munka*")) Or (((IIf(UCase$(Nz([�ll�shely besorol�si kateg�ri�ja],""))=UCase$(Nz([Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s],"")),True,False))=False) And ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]) Not Like "Munka*")) Or (((IIf(UCase$(Nz([�ll�shely besorol�si kateg�ri�ja],""))=UCase$(Nz(lkSzem�lyek.Besorol�s,"")),True,False))=False) And ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]) Not Like "Munka*")) Or (((IIf(UCase$(Nz([�ll�shely besorol�si kateg�ri�ja],""))=UCase$(Nz([Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s],"")),True,False))=False) And ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]) Is Null))
ORDER BY lkSzem�lyek.[Dolgoz� teljes neve];

-- [lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti]
SELECT lk__Elt�r�Besorol�sok.SzervezetK�d, lk__Elt�r�Besorol�sok.F�oszt�ly, lk__Elt�r�Besorol�sok.�ll�shely, lk__Elt�r�Besorol�sok.[Szem�lyi karton], lk__Elt�r�Besorol�sok.[Szervezeti strukt�ra], lk__Elt�r�Besorol�sok.[Dolgoz� teljes neve], lk__Elt�r�Besorol�sok.[Tart�s t�voll�t t�pusa], lk__Elt�r�Besorol�sok.[Helyettes�tett dolgoz� neve], lk__Elt�r�Besorol�sok.Link, lk__Elt�r�Besorol�sok.�nyr_vs_Szervezeti, lk__Elt�r�Besorol�sok.Szervezeti_vs_Szem�lyi, lk__Elt�r�Besorol�sok.�ny_vs_Szem�lyi, *
FROM lk__Elt�r�Besorol�sok
WHERE (((lk__Elt�r�Besorol�sok.�nyr_vs_Szervezeti)=False) AND ((lk__Elt�r�Besorol�sok.�ny_vs_Szem�lyi)=True))
ORDER BY lk__Elt�r�Besorol�sok.SzervezetK�d, lk__Elt�r�Besorol�sok.[Dolgoz� teljes neve];

-- [lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti_C�mzettek]
SELECT DISTINCT lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti.C�mzett
FROM lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti
GROUP BY lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti.C�mzett, lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti.F�oszt�ly;

-- [lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti_felel�s�k]
SELECT lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti.F�oszt�ly, tReferensek.[Dolgoz� teljes neve] AS Felel�s, Count(lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti.�ll�shely) AS [Jav�tand� adatok sz�ma], lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti.[Dolgoz� teljes neve]
FROM (ktReferens_SzervezetiEgys�g RIGHT JOIN lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti ON ktReferens_SzervezetiEgys�g.azSzervezet=lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti.azSzervezet) LEFT JOIN tReferensek ON ktReferens_SzervezetiEgys�g.azRef=tReferensek.azRef
GROUP BY lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti.F�oszt�ly, tReferensek.[Dolgoz� teljes neve], lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti.[Dolgoz� teljes neve]
HAVING (((tReferensek.[Dolgoz� teljes neve]) Like "Sz*"))
ORDER BY lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti.F�oszt�ly, Count(lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti.�ll�shely) DESC;

-- [lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti_szervezetek]
SELECT DISTINCT lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti.F�oszt�ly, Count(lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti.�ll�shely) AS [Jav�tand� adatok sz�ma]
FROM lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti
GROUP BY lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti.F�oszt�ly
ORDER BY Count(lk__Elt�r�Besorol�sok_�nyr_vs_Szervezeti.�ll�shely) DESC;

-- [lk__Elt�r�Besorol�sok_Szervezet_vs_Szem�ly]
SELECT lk__Elt�r�Besorol�sok.SzervezetK�d, lk__Elt�r�Besorol�sok.F�oszt�ly, lk__Elt�r�Besorol�sok.�ll�shely, lk__Elt�r�Besorol�sok.[Szem�lyi karton], lk__Elt�r�Besorol�sok.[Szervezeti strukt�ra], lk__Elt�r�Besorol�sok.[Dolgoz� teljes neve], lk__Elt�r�Besorol�sok.[Tart�s t�voll�t t�pusa], lk__Elt�r�Besorol�sok.[Helyettes�tett dolgoz� neve], lk__Elt�r�Besorol�sok.Link
FROM lk__Elt�r�Besorol�sok
WHERE (((lk__Elt�r�Besorol�sok.[Szem�lyi karton])<>[Szervezeti strukt�ra]) AND ((lk__Elt�r�Besorol�sok.Bet�lt�tt)=True) AND ((lk__Elt�r�Besorol�sok.Szervezeti_vs_Szem�lyi)=False))
ORDER BY lk__Elt�r�Besorol�sok.SzervezetK�d, lk__Elt�r�Besorol�sok.[Dolgoz� teljes neve];

-- [lk__Mintalek�rdez�s]
SELECT 'J�r�si_�llom�ny' AS T�bla, "Ell�tott feladat" AS [Hi�nyz� �rt�k], J�r�si_�llom�ny.Ad�azonos�t�, J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
FROM J�r�si_�llom�ny
WHERE (((J�r�si_�llom�ny.Mez�9) Is Null Or (J�r�si_�llom�ny.Mez�9)="") AND ((J�r�si_�llom�ny.Mez�4)<>"�res �ll�s"));

-- [lk__oszt�lyvezet�_halmoz�_szervezeti_egys�gek]
SELECT �ll�shelyek.[3 szint], �ll�shelyek.[4 szint], �ll�shelyek.[5 szint], Count(�ll�shelyek.[�ll�shely azonos�t�]) AS [CountOf�ll�shely azonos�t�], 2 AS Sor
FROM �ll�shelyek
WHERE (((�ll�shelyek.[�ll�shely besorol�si kateg�ri�ja])="oszt�lyvezet�"))
GROUP BY �ll�shelyek.[3 szint], �ll�shelyek.[4 szint], �ll�shelyek.[5 szint], 2
HAVING (((Count(�ll�shelyek.[�ll�shely azonos�t�]))>1));

-- [lk__oszt�lyvezet�_halmoz�_szervezeti_egys�gek_�sszefoglal�]
SELECT �sszevont.[3 szint], �sszevont.[4 szint], �sszevont.[5 szint], IIf(Left([�sszevont].[�ll�shely azonos�t�],1)="S",[�sszevont].[�ll�shely azonos�t�],"�sszesen: " & [�sszevont].[�ll�shely azonos�t�] & " db.") AS �ll�shely, �ll�shelyek.[�ll�shely st�tusza], lkSzem�lyek.[Dolgoz� teljes neve]
FROM lkSzem�lyek RIGHT JOIN (�ll�shelyek RIGHT JOIN (SELECT lk__oszt�lyvezet�_halmoz�_szervezeti_egys�gek_r�szletez�.* FROM lk__oszt�lyvezet�_halmoz�_szervezeti_egys�gek_r�szletez� UNION SELECT  lk__oszt�lyvezet�_halmoz�_szervezeti_egys�gek.* FROM lk__oszt�lyvezet�_halmoz�_szervezeti_egys�gek )  AS �sszevont ON �ll�shelyek.[�ll�shely azonos�t�] = �sszevont.[�ll�shely azonos�t�]) ON lkSzem�lyek.[St�tusz k�dja] = �ll�shelyek.[�ll�shely azonos�t�]
ORDER BY �sszevont.[3 szint], �sszevont.[4 szint], �sszevont.[5 szint], �sszevont.sor;

-- [lk__oszt�lyvezet�_halmoz�_szervezeti_egys�gek_r�szletez�]
SELECT lk__oszt�lyvezet�_halmoz�_szervezeti_egys�gek.[3 szint], lk__oszt�lyvezet�_halmoz�_szervezeti_egys�gek.[4 szint], lk__oszt�lyvezet�_halmoz�_szervezeti_egys�gek.[5 szint], �ll�shelyek.[�ll�shely azonos�t�], 1 AS sor
FROM �ll�shelyek RIGHT JOIN lk__oszt�lyvezet�_halmoz�_szervezeti_egys�gek ON (�ll�shelyek.[3 szint] = lk__oszt�lyvezet�_halmoz�_szervezeti_egys�gek.[3 szint]) AND (�ll�shelyek.[4 szint] = lk__oszt�lyvezet�_halmoz�_szervezeti_egys�gek.[4 szint]) AND (�ll�shelyek.[5 szint] = lk__oszt�lyvezet�_halmoz�_szervezeti_egys�gek.[5 szint])
WHERE (((�ll�shelyek.[�ll�shely besorol�si kateg�ri�ja])="oszt�lyvezet�"));

-- [lk__oszt�lyvezet�_n�lk�li_szervezetei_egys�gek]
SELECT MindenSzervezetiEgys�g.Szervezet, SzervezetekOszt�lyvezet�vel.Szervezet, *
FROM (SELECT DISTINCT IIf([4 szint]="" Or [4 szint] Is Null,[3 szint],[4 szint]) & " - " & [5 szint] AS Szervezet FROM �ll�shelyek WHERE [5 szint]<>"")  AS MindenSzervezetiEgys�g LEFT JOIN (SELECT DISTINCT IIf([4 szint]="" Or [4 szint] Is Null,[3 szint],[4 szint]) & " - " & [5 szint] AS Szervezet FROM �ll�shelyek WHERE �ll�shelyek.[�ll�shely besorol�si kateg�ri�ja]="oszt�lyvezet�")  AS SzervezetekOszt�lyvezet�vel ON MindenSzervezetiEgys�g.Szervezet=SzervezetekOszt�lyvezet�vel.Szervezet
WHERE (((SzervezetekOszt�lyvezet�vel.Szervezet) Is Null));

-- [lk_382_2_lkNFSZ_kapacit�s_felm�r�s_00]
SELECT lkJ�r�siKorm�nyK�zpontos�tottUni�F�osztK�d.F�oszt�ly, IIf([Sz�let�si �v \ �res �ll�s]<>"�res �ll�s","Bet�lt�tt","�res") AS Bet�lt�tt, lkJ�r�siKorm�nyK�zpontos�tottUni�F�osztK�d.Jelleg, lkJ�r�siKorm�nyK�zpontos�tottUni�F�osztK�d.[�ll�shely azonos�t�], IIf(([F�oszt�ly] Not Like "*F�oszt�ly" And [Oszt�ly] Like "Foglalkoztat�s*") Or [F�oszt�ly]="Foglalkoztat�si F�oszt�ly",1,0) AS Foglalkoztat�s, IIf([F�oszt�ly]="Foglalkoztat�s-fel�gyeleti �s Munkav�delmi F�oszt�ly",IIf(Nz([KIRA feladat megnevez�s],"")="Foglalkoztat�s-fel�gyeleti �s munkav�delmi feladatok, munka�gyi ellen�r",1,IIf(Nz([KIRA feladat megnevez�s],"")="Foglalkoztat�s-fel�gyeleti �s munkav�delmi feladatok",0.5,0)),0) AS Munka�gy, IIf([F�oszt�ly]="Foglalkoztat�s-fel�gyeleti �s Munkav�delmi F�oszt�ly",IIf(Nz([KIRA feladat megnevez�s],"")="Foglalkoztat�s-fel�gyeleti �s munkav�delmi feladatok, munkav�delmi ellen�r",1,IIf(Nz([KIRA feladat megnevez�s],"")="Foglalkoztat�s-fel�gyeleti �s munkav�delmi feladatok",0.5,0)),0) AS Munkav�delem
FROM lkSzem�lyek RIGHT JOIN (lkJ�r�siKorm�nyK�zpontos�tottUni�F�osztK�d INNER JOIN lktNFSZSzervezetek ON lkJ�r�siKorm�nyK�zpontos�tottUni�F�osztK�d.F�oszt�lyk�d = lktNFSZSzervezetek.BFKH) ON lkSzem�lyek.[Ad�azonos�t� jel] = lkJ�r�siKorm�nyK�zpontos�tottUni�F�osztK�d.Ad�azonos�t�
ORDER BY lktNFSZSzervezetek.BFKH;

-- [lk_�llom�nyt�bl�kb�l_Illetm�nyek]
SELECT Uni�.Ad�azonos�t�, Uni�.Illetm�ny, Uni�.[Heti munka�r�k sz�ma], Uni�.[�ll�shely azonos�t�], Uni�.N�v, Uni�.F�oszt�ly, Uni�.Oszt�ly, [Ad�azonos�t�]*1 AS Ad�jel, Uni�.T�voll�tJogc�me, Uni�.Szervezetk�d, Uni�.Besorol�sHavi
FROM (SELECT J�r�si_�llom�ny.Ad�azonos�t�, 
        J�r�si_�llom�ny.Mez�18 AS Illetm�ny, 
        [Heti munka�r�k sz�ma], 
        [�ll�shely azonos�t�], 
        N�v, 
        Replace([J�r�si hivatal],"Budapest F�v�ros Korm�nyhivatala ","BFKH ") as F�oszt�ly,
        Mez�7 as Oszt�ly,
        [Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp] as T�voll�tJogc�me, 
        [�NYR SZERVEZETI EGYS�G AZONOS�T�] as Szervezetk�d,
        [Besorol�si fokozat k�d:] as Besorol�sHavi,
        J�r�si_�llom�ny.[Mez�18]/40*[Heti munka�r�k sz�ma] as B�r
    FROM J�r�si_�llom�ny
    WHERE Ad�azonos�t�  not like ""

    UNION SELECT Korm�nyhivatali_�llom�ny.Ad�azonos�t�, 
        Korm�nyhivatali_�llom�ny.Mez�18, 
        [Heti munka�r�k sz�ma], 
        [�ll�shely azonos�t�], 
        N�v, 
        Mez�6, 
        Mez�7, 
        [Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], 
        [�NYR SZERVEZETI EGYS�G AZONOS�T�],
        [Besorol�si fokozat k�d:],
        J�r�si_�llom�ny.[Mez�18]/40*[Heti munka�r�k sz�ma] as B�r
    FROM  Korm�nyhivatali_�llom�ny
    WHERE Ad�azonos�t�  not  like ""
    
    UNION SELECT K�zpontos�tottak.Ad�azonos�t�, 
        K�zpontos�tottak.Mez�17, 
        lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker] AS [Heti munka�r�k sz�ma], 
        K�zpontos�tottak.[�ll�shely azonos�t�], 
        K�zpontos�tottak.N�v, 
        K�zpontos�tottak.Mez�7, 
        K�zpontos�tottak.[Projekt megnevez�se], 
        K�zpontos�tottak.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], 
        K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�], 
        K�zpontos�tottak.[Besorol�si fokozat k�d:], 
        J�r�si_�llom�ny.[Mez�18]/40*[Heti munka�r�k sz�ma] as B�r
FROM lkSzem�lyek RIGHT JOIN K�zpontos�tottak ON lkSzem�lyek.[Ad�azonos�t� jel] = K�zpontos�tottak.Ad�azonos�t�
WHERE (K�zpontos�tottak.[Ad�azonos�t�]) Not Like ""
)  AS Uni�;

-- [lk_Bet�lt�sT�voll�tElt�r�s]
SELECT lkJ�r�siKorm�nyK�zpontos�tottUni�.Ad�jel, lkJ�r�siKorm�nyK�zpontos�tottUni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�], lkJ�r�siKorm�nyK�zpontos�tottUni�.[�ll�shely azonos�t�], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], lkSzervezetSzem�lyek.[St�tuszbet�lt�s t�pusa], lkSzem�lyek.[Tart�s t�voll�t t�pusa], lkSzem�lyek.[Tart�s t�voll�t kezdete], lkSzem�lyek.[Tart�s t�voll�t v�ge], lkSzem�lyek.[Tart�s t�voll�t tervezett v�ge], lkSzem�lyek.[Helyettes�tett dolgoz� neve], dt�tal([�rv�nyess�g kezdete]) AS �rvKezd, IIf(dt�tal([�rv�nyess�g v�ge])=0,#1/1/3000#,dt�tal([�rv�nyess�g v�ge])) AS �rvV�ge
FROM lkSzem�lyek INNER JOIN (lkJ�r�siKorm�nyK�zpontos�tottUni� INNER JOIN lkSzervezetSzem�lyek ON lkJ�r�siKorm�nyK�zpontos�tottUni�.Ad�jel = lkSzervezetSzem�lyek.Ad�jel) ON lkSzem�lyek.Ad�jel = lkJ�r�siKorm�nyK�zpontos�tottUni�.Ad�jel
WHERE (((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h]) Like "*TT*") AND ((dt�tal([�rv�nyess�g kezdete]))<=dt�tal(Now())) AND ((IIf(dt�tal([�rv�nyess�g v�ge])=0,#1/1/3000#,dt�tal([�rv�nyess�g v�ge])))>=dt�tal(Now()))) OR (((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp])<>"") AND ((dt�tal([�rv�nyess�g kezdete]))<=dt�tal(Now())) AND ((IIf(dt�tal([�rv�nyess�g v�ge])=0,#1/1/3000#,dt�tal([�rv�nyess�g v�ge])))>=dt�tal(Now()))) OR (((lkSzervezetSzem�lyek.[St�tuszbet�lt�s t�pusa])<>"�ltal�nos") AND ((dt�tal([�rv�nyess�g kezdete]))<=dt�tal(Now())) AND ((IIf(dt�tal([�rv�nyess�g v�ge])=0,#1/1/3000#,dt�tal([�rv�nyess�g v�ge])))>=dt�tal(Now())));

-- [lk_CSED-en l�v�k]
SELECT [Ad�azonos�t�]*1 AS Ad�jel, [lk_TT-sek].N�v, [lk_TT-sek].[J�r�si Hivatal], [lk_TT-sek].Oszt�ly, [lk_TT-sek].Jogc�me
FROM [lk_TT-sek];

-- [lk_Ellen�rz�s_01]
SELECT 'J�r�si_�llom�ny' AS T�bla, 'Kinevez�s d�tuma
�ll�shely meg�resed�s�nek d�tuma
(most ell�tott feladat)
�v,h�,nap' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.[Ad�azonos�t�], J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [J�r�si_�llom�ny] 
WHERE ([J�r�si_�llom�ny].[Mez�10] Is Null )  AND ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'J�r�si_�llom�ny' AS T�bla, 'Ell�tott feladatok megjel�l�se
a f�v�rosi �s megyei korm�nyhivatalok szervezeti �s m�k�d�si szab�lyzat�r�l sz�l� 3/2020. (II. 28.) MvM utas�t�s alapj�n' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.[Ad�azonos�t�], J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [J�r�si_�llom�ny] 
WHERE ([J�r�si_�llom�ny].[Mez�9] Is Null OR [J�r�si_�llom�ny].[Mez�9]='')  AND ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'J�r�si_�llom�ny' AS T�bla, '�NYR SZERVEZETI EGYS�G AZONOS�T�' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.[Ad�azonos�t�], J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [J�r�si_�llom�ny] 
WHERE ([J�r�si_�llom�ny].[�NYR SZERVEZETI EGYS�G AZONOS�T�] Is Null OR [J�r�si_�llom�ny].[�NYR SZERVEZETI EGYS�G AZONOS�T�]='')  AND ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'J�r�si_�llom�ny' AS T�bla, 'Szervezeti egys�g
Oszt�ly megnevez�se' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.[Ad�azonos�t�], J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [J�r�si_�llom�ny] 
WHERE ([J�r�si_�llom�ny].[Mez�7] Is Null OR [J�r�si_�llom�ny].[Mez�7]='')  AND ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'J�r�si_�llom�ny' AS T�bla, 'J�r�si Hivatal' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.[Ad�azonos�t�], J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [J�r�si_�llom�ny] 
WHERE ([J�r�si_�llom�ny].[J�r�si Hivatal] Is Null OR [J�r�si_�llom�ny].[J�r�si Hivatal]='')  AND ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'J�r�si_�llom�ny' AS T�bla, 'Dolgoz� neme' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.[Ad�azonos�t�], J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [J�r�si_�llom�ny] 
WHERE ([J�r�si_�llom�ny].[Mez�5] Is Null OR [J�r�si_�llom�ny].[Mez�5]='')  AND ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'J�r�si_�llom�ny' AS T�bla, 'Sz�let�si �v/ �res �ll�s
/ �res �ll�s' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.[Ad�azonos�t�], J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [J�r�si_�llom�ny] 
WHERE ([J�r�si_�llom�ny].[Mez�4] Is Null OR [J�r�si_�llom�ny].[Mez�4]='')  AND ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'J�r�si_�llom�ny' AS T�bla, 'Ad�azonos�t�' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.[Ad�azonos�t�], J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [J�r�si_�llom�ny] 
WHERE ([J�r�si_�llom�ny].[Ad�azonos�t�] Is Null )  AND ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'J�r�si_�llom�ny' AS T�bla, 'N�v' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.[Ad�azonos�t�], J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [J�r�si_�llom�ny] 
WHERE ([J�r�si_�llom�ny].[N�v] Is Null OR [J�r�si_�llom�ny].[N�v]='')  AND ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null ) 
UNION SELECT 'J�r�si_�llom�ny' AS T�bla, 'Legmagasabb iskolai v�gzetts�g 1=8. oszt�ly; 2=�retts�gi; 3=f�iskolai v�gzetts�g; 4=egyetemi v�gzetts�g; 5=technikus; 6= KAB vizsga' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.Ad�azonos�t�, J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
FROM lkV�gzetts�gek RIGHT JOIN J�r�si_�llom�ny ON lkV�gzetts�gek.[Dolgoz� azonos�t�] = J�r�si_�llom�ny.Ad�azonos�t�
WHERE (((J�r�si_�llom�ny.[Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is]) Like "") AND ((J�r�si_�llom�ny.Mez�4)<>'�res �ll�s' Or (J�r�si_�llom�ny.Mez�4) Is Null) AND ((lkV�gzetts�gek.[V�gzetts�g t�pusa])="Iskolai v�gzetts�g"))
UNION SELECT 'J�r�si_�llom�ny' AS T�bla, 'Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.[Ad�azonos�t�], J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [J�r�si_�llom�ny]  WHERE ([J�r�si_�llom�ny].[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)] Is Null OR [J�r�si_�llom�ny].[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)]='')  AND ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null )
UNION SELECT 'J�r�si_�llom�ny' AS T�bla, 'Havi illetm�ny teljes �sszege (kerek�tve) (FT)' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.[Ad�azonos�t�], J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [J�r�si_�llom�ny]  WHERE ([J�r�si_�llom�ny].[Mez�18] Is Null )  AND ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null )
UNION SELECT 'J�r�si_�llom�ny' AS T�bla, '�ll�shely azonos�t�' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.[Ad�azonos�t�], J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [J�r�si_�llom�ny]  WHERE ([J�r�si_�llom�ny].[�ll�shely azonos�t�] Is Null OR [J�r�si_�llom�ny].[�ll�shely azonos�t�]='')  AND ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null )
UNION SELECT 'J�r�si_�llom�ny' AS T�bla, 'Besorol�si fokozat megnevez�se:' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.[Ad�azonos�t�], J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [J�r�si_�llom�ny]  WHERE ([J�r�si_�llom�ny].[Besorol�si fokozat megnevez�se:] Is Null OR [J�r�si_�llom�ny].[Besorol�si fokozat megnevez�se:]='')  AND ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null )
UNION SELECT 'J�r�si_�llom�ny' AS T�bla, 'Besorol�si fokozat k�d:' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.[Ad�azonos�t�], J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [J�r�si_�llom�ny]  WHERE ([J�r�si_�llom�ny].[Besorol�si fokozat k�d:] Is Null OR [J�r�si_�llom�ny].[Besorol�si fokozat k�d:]='')  AND ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null )
UNION SELECT 'J�r�si_�llom�ny' AS T�bla, '�ll�shely bet�lt�s�nek ar�nya �s �res �ll�shely bet�lt�s ar�nya' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.[Ad�azonos�t�], J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [J�r�si_�llom�ny]  WHERE ([J�r�si_�llom�ny].[Mez�14] Is Null )  AND ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null )   UNION SELECT 'J�r�si_�llom�ny' AS T�bla, 'Heti munka�r�k sz�ma' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.[Ad�azonos�t�], J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [J�r�si_�llom�ny]  WHERE ([J�r�si_�llom�ny].[Heti munka�r�k sz�ma] Is Null )  AND ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null )   UNION SELECT 'J�r�si_�llom�ny' AS T�bla, 'Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas teljes (NYT), r�szmunkaid�s (NYR)' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.[Ad�azonos�t�], J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [J�r�si_�llom�ny]  WHERE ([J�r�si_�llom�ny].[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ] Is Null OR [J�r�si_�llom�ny].[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ]='')  AND ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null )   UNION SELECT 'J�r�si_�llom�ny' AS T�bla, 'Feladat jellege: szakmai (SZ) / funkcion�lis (F) feladatell�t�s; KAB szakmai (KAB/SZ) / KAB funkcion�lis (KAB/F) feladatell�t�s;' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.Ad�azonos�t�, J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
FROM J�r�si_�llom�ny
WHERE (((J�r�si_�llom�ny.[Feladat jellege: szakmai (SZ) / funkcion�lis (F) feladatell�t�s;]) Is Null Or (J�r�si_�llom�ny.[Feladat jellege: szakmai (SZ) / funkcion�lis (F) feladatell�t�s;])='') AND ((J�r�si_�llom�ny.Mez�4)<>'�res �ll�s' Or (J�r�si_�llom�ny.Mez�4) Is Null))
UNION
SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, 'Kinevez�s d�tuma
�ll�shely meg�resed�s�nek d�tuma
(most ell�tott feladat)
�v,h�,nap' AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.[Ad�azonos�t�], Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Korm�nyhivatali_�llom�ny] 
WHERE ([Korm�nyhivatali_�llom�ny].[Mez�10] Is Null )  AND ([Korm�nyhivatali_�llom�ny].[Mez�4]<> '�res �ll�s' OR [Korm�nyhivatali_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, 'Ell�tott feladatok megjel�l�se
a f�v�rosi �s megyei korm�nyhivatalok szervezeti �s m�k�d�si szab�lyzat�r�l sz�l� 3/2020. (II. 28.) MvM utas�t�s alapj�n' AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.[Ad�azonos�t�], Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Korm�nyhivatali_�llom�ny] 
WHERE ([Korm�nyhivatali_�llom�ny].[Mez�9] Is Null OR [Korm�nyhivatali_�llom�ny].[Mez�9]='')  AND ([Korm�nyhivatali_�llom�ny].[Mez�4]<> '�res �ll�s' OR [Korm�nyhivatali_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, '�NYR SZERVEZETI EGYS�G AZONOS�T�' AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.[Ad�azonos�t�], Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Korm�nyhivatali_�llom�ny] 
WHERE ([Korm�nyhivatali_�llom�ny].[�NYR SZERVEZETI EGYS�G AZONOS�T�] Is Null OR [Korm�nyhivatali_�llom�ny].[�NYR SZERVEZETI EGYS�G AZONOS�T�]='')  AND ([Korm�nyhivatali_�llom�ny].[Mez�4]<> '�res �ll�s' OR [Korm�nyhivatali_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, 'Szervezeti egys�g
Oszt�ly megnevez�se' AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.[Ad�azonos�t�], Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Korm�nyhivatali_�llom�ny] 
WHERE ([Korm�nyhivatali_�llom�ny].[Mez�7] Is Null OR [Korm�nyhivatali_�llom�ny].[Mez�7]='')  AND ([Korm�nyhivatali_�llom�ny].[Mez�4]<> '�res �ll�s' OR [Korm�nyhivatali_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, 'Szervezeti egys�g
F�oszt�ly megnevez�se' AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.[Ad�azonos�t�], Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Korm�nyhivatali_�llom�ny] 
WHERE ([Korm�nyhivatali_�llom�ny].[Mez�6] Is Null OR [Korm�nyhivatali_�llom�ny].[Mez�6]='')  AND ([Korm�nyhivatali_�llom�ny].[Mez�4]<> '�res �ll�s' OR [Korm�nyhivatali_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, 'Dolgoz� neme' AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.[Ad�azonos�t�], Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Korm�nyhivatali_�llom�ny] 
WHERE ([Korm�nyhivatali_�llom�ny].[Mez�5] Is Null OR [Korm�nyhivatali_�llom�ny].[Mez�5]='')  AND ([Korm�nyhivatali_�llom�ny].[Mez�4]<> '�res �ll�s' OR [Korm�nyhivatali_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, 'Sz�let�si �v/ �res �ll�s' AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.[Ad�azonos�t�], Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Korm�nyhivatali_�llom�ny] 
WHERE ([Korm�nyhivatali_�llom�ny].[Mez�4] Is Null OR [Korm�nyhivatali_�llom�ny].[Mez�4]='')  AND ([Korm�nyhivatali_�llom�ny].[Mez�4]<> '�res �ll�s' OR [Korm�nyhivatali_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, 'Ad�azonos�t�' AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.[Ad�azonos�t�], Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Korm�nyhivatali_�llom�ny] 
WHERE ([Korm�nyhivatali_�llom�ny].[Ad�azonos�t�] Is Null )  AND ([Korm�nyhivatali_�llom�ny].[Mez�4]<> '�res �ll�s' OR [Korm�nyhivatali_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, 'N�v' AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.[Ad�azonos�t�], Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Korm�nyhivatali_�llom�ny] 
WHERE ([Korm�nyhivatali_�llom�ny].[N�v] Is Null OR [Korm�nyhivatali_�llom�ny].[N�v]='')  AND ([Korm�nyhivatali_�llom�ny].[Mez�4]<> '�res �ll�s' OR [Korm�nyhivatali_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'J�r�si_�llom�ny' AS T�bla, 'K�pes�t�st ad� v�gzetts�g megnevez�se.
(az az egy ami a feladat bet�lt�s�hez sz�ks�ges)' AS Hi�nyz�_�rt�k, J�r�si_�llom�ny.[Ad�azonos�t�], J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [J�r�si_�llom�ny] 
WHERE ([J�r�si_�llom�ny].[Mez�26] Is Null OR [J�r�si_�llom�ny].[Mez�26]='')  AND ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null ) 

union
SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, 'K�pes�t�st ad� v�gzetts�g megnevez�se.
(az az egy ami a feladat bet�lt�s�hez sz�ks�ges)' AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.[Ad�azonos�t�], Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Korm�nyhivatali_�llom�ny] 
WHERE ([Korm�nyhivatali_�llom�ny].[Mez�26] Is Null OR [Korm�nyhivatali_�llom�ny].[Mez�26]='')  AND ([Korm�nyhivatali_�llom�ny].[Mez�4]<> '�res �ll�s' OR [Korm�nyhivatali_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, 'Legmagasabb iskolai v�gzetts�g 1=8. oszt�ly; 2=�retts�gi; 3=f�iskolai v�gzetts�g; 4=egyetemi v�gzetts�g; 5=technikus; 6= KAB vizsga' AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.Ad�azonos�t�, Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
FROM lkV�gzetts�gek RIGHT JOIN Korm�nyhivatali_�llom�ny ON lkV�gzetts�gek.[Dolgoz� azonos�t�] = Korm�nyhivatali_�llom�ny.Ad�azonos�t�
WHERE (((Korm�nyhivatali_�llom�ny.[Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is]) Like "") AND ((Korm�nyhivatali_�llom�ny.Mez�4)<>'�res �ll�s' Or (Korm�nyhivatali_�llom�ny.Mez�4) Is Null) AND ((lkV�gzetts�gek.[V�gzetts�g t�pusa])="Iskolai v�gzetts�g"))
 UNION SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, 'Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)' AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.[Ad�azonos�t�], Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Korm�nyhivatali_�llom�ny] 
WHERE ([Korm�nyhivatali_�llom�ny].[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)] Is Null OR [Korm�nyhivatali_�llom�ny].[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)]='')  AND ([Korm�nyhivatali_�llom�ny].[Mez�4]<> '�res �ll�s' OR [Korm�nyhivatali_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, 'Havi illetm�ny teljes �sszege (kerek�tve)
(FT)' AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.[Ad�azonos�t�], Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Korm�nyhivatali_�llom�ny] 
WHERE ([Korm�nyhivatali_�llom�ny].[Mez�18] Is Null )  AND ([Korm�nyhivatali_�llom�ny].[Mez�4]<> '�res �ll�s' OR [Korm�nyhivatali_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, '�ll�shely azonos�t�' AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.[Ad�azonos�t�], Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Korm�nyhivatali_�llom�ny] 
WHERE ([Korm�nyhivatali_�llom�ny].[�ll�shely azonos�t�] Is Null OR [Korm�nyhivatali_�llom�ny].[�ll�shely azonos�t�]='')  AND ([Korm�nyhivatali_�llom�ny].[Mez�4]<> '�res �ll�s' OR [Korm�nyhivatali_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, 'Besorol�si fokozat megnevez�se:' AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.[Ad�azonos�t�], Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Korm�nyhivatali_�llom�ny] 
WHERE ([Korm�nyhivatali_�llom�ny].[Besorol�si fokozat megnevez�se:] Is Null OR [Korm�nyhivatali_�llom�ny].[Besorol�si fokozat megnevez�se:]='')  AND ([Korm�nyhivatali_�llom�ny].[Mez�4]<> '�res �ll�s' OR [Korm�nyhivatali_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, '�ll�shely bet�lt�s�nek ar�nya �s
�res �ll�shely bet�lt�s ar�nya' AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.[Ad�azonos�t�], Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Korm�nyhivatali_�llom�ny] 
WHERE ([Korm�nyhivatali_�llom�ny].[Mez�14] Is Null )  AND ([Korm�nyhivatali_�llom�ny].[Mez�4]<> '�res �ll�s' OR [Korm�nyhivatali_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, 'Heti munka�r�k sz�ma' AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.[Ad�azonos�t�], Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Korm�nyhivatali_�llom�ny] 
WHERE ([Korm�nyhivatali_�llom�ny].[Heti munka�r�k sz�ma] Is Null )  AND ([Korm�nyhivatali_�llom�ny].[Mez�4]<> '�res �ll�s' OR [Korm�nyhivatali_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, 'Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas teljes (NYT), r�szmunkaid�s (NYR)' AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.[Ad�azonos�t�], Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Korm�nyhivatali_�llom�ny] 
WHERE ([Korm�nyhivatali_�llom�ny].[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ] Is Null OR [Korm�nyhivatali_�llom�ny].[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ]='')  AND ([Korm�nyhivatali_�llom�ny].[Mez�4]<> '�res �ll�s' OR [Korm�nyhivatali_�llom�ny].[Mez�4] is null ) 
 UNION SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, 'Feladat jellege: szakmai (SZ) / funkcion�lis (F) feladatell�t�s; KAB szakmai (KAB/SZ) / KAB funkcion�lis (KAB/F) feladatell�t�s;' AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.Ad�azonos�t�, Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
FROM Korm�nyhivatali_�llom�ny
WHERE (((Korm�nyhivatali_�llom�ny.[Feladat jellege: szakmai (SZ) / funkcion�lis (F) feladatell�t�s;]) Is Null Or (Korm�nyhivatali_�llom�ny.[Feladat jellege: szakmai (SZ) / funkcion�lis (F) feladatell�t�s;])='') AND ((Korm�nyhivatali_�llom�ny.Mez�4)<>'�res �ll�s' Or (Korm�nyhivatali_�llom�ny.Mez�4) Is Null))


union
SELECT 'K�zpontos�tottak' AS T�bla, 'Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas teljes (NYT), r�szmunkaid�s (NYR)' AS Hi�nyz�_�rt�k, K�zpontos�tottak.[Ad�azonos�t�], K�zpontos�tottak.[�ll�shely azonos�t�], K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] FROM [K�zpontos�tottak] 
WHERE ([K�zpontos�tottak].[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ] Is Null OR [K�zpontos�tottak].[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ]='')  AND ([K�zpontos�tottak].[Mez�4]<> '�res �ll�s' OR [K�zpontos�tottak].[Mez�4] is null ) 
 UNION SELECT 'K�zpontos�tottak' AS T�bla, 'Kinevez�s d�tuma
�ll�shely meg�resed�s�nek d�tuma
(most ell�tott feladat)
�v,h�,nap' AS Hi�nyz�_�rt�k, K�zpontos�tottak.[Ad�azonos�t�], K�zpontos�tottak.[�ll�shely azonos�t�], K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] FROM [K�zpontos�tottak] 
WHERE ([K�zpontos�tottak].[Mez�11] Is Null )  AND ([K�zpontos�tottak].[Mez�4]<> '�res �ll�s' OR [K�zpontos�tottak].[Mez�4] is null ) 
 UNION SELECT 'K�zpontos�tottak' AS T�bla, 'Ell�tott feladatok megjel�l�se
a f�v�rosi �s megyei korm�nyhivatalok szervezeti �s m�k�d�si szab�lyzat�r�l sz�l� 3/2020. (II. 28.) MvM utas�t�s alapj�n' AS Hi�nyz�_�rt�k, K�zpontos�tottak.[Ad�azonos�t�], K�zpontos�tottak.[�ll�shely azonos�t�], K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] FROM [K�zpontos�tottak] 
WHERE ([K�zpontos�tottak].[Mez�10] Is Null OR [K�zpontos�tottak].[Mez�10]='')  AND ([K�zpontos�tottak].[Mez�4]<> '�res �ll�s' OR [K�zpontos�tottak].[Mez�4] is null ) 
 UNION SELECT 'K�zpontos�tottak' AS T�bla, 'Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�' AS Hi�nyz�_�rt�k, K�zpontos�tottak.[Ad�azonos�t�], K�zpontos�tottak.[�ll�shely azonos�t�], K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] FROM [K�zpontos�tottak] 
WHERE ([K�zpontos�tottak].[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] Is Null OR [K�zpontos�tottak].[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�]='')  AND ([K�zpontos�tottak].[Mez�4]<> '�res �ll�s' OR [K�zpontos�tottak].[Mez�4] is null ) 
 UNION SELECT 'K�zpontos�tottak' AS T�bla, 'Szervezeti egys�g
Oszt�ly megnevez�se' AS Hi�nyz�_�rt�k, K�zpontos�tottak.[Ad�azonos�t�], K�zpontos�tottak.[�ll�shely azonos�t�], K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] FROM [K�zpontos�tottak] 
WHERE ([K�zpontos�tottak].[Mez�7] Is Null OR [K�zpontos�tottak].[Mez�7]='')  AND ([K�zpontos�tottak].[Mez�4]<> '�res �ll�s' OR [K�zpontos�tottak].[Mez�4] is null ) 
 UNION SELECT 'K�zpontos�tottak' AS T�bla, 'Szervezeti egys�g
F�oszt�ly megnevez�se' AS Hi�nyz�_�rt�k, K�zpontos�tottak.[Ad�azonos�t�], K�zpontos�tottak.[�ll�shely azonos�t�], K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] FROM [K�zpontos�tottak] 
WHERE ([K�zpontos�tottak].[Mez�6] Is Null OR [K�zpontos�tottak].[Mez�6]='')  AND ([K�zpontos�tottak].[Mez�4]<> '�res �ll�s' OR [K�zpontos�tottak].[Mez�4] is null ) 
 UNION SELECT 'K�zpontos�tottak' AS T�bla, 'Megyei szint VAGY J�r�si Hivatal' AS Hi�nyz�_�rt�k, K�zpontos�tottak.[Ad�azonos�t�], K�zpontos�tottak.[�ll�shely azonos�t�], K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] FROM [K�zpontos�tottak] 
WHERE ([K�zpontos�tottak].[Megyei szint VAGY J�r�si Hivatal] Is Null OR [K�zpontos�tottak].[Megyei szint VAGY J�r�si Hivatal]='')  AND ([K�zpontos�tottak].[Mez�4]<> '�res �ll�s' OR [K�zpontos�tottak].[Mez�4] is null ) 
 UNION SELECT 'K�zpontos�tottak' AS T�bla, 'Sz�let�si �v/ �res �ll�s' AS Hi�nyz�_�rt�k, K�zpontos�tottak.[Ad�azonos�t�], K�zpontos�tottak.[�ll�shely azonos�t�], K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] FROM [K�zpontos�tottak] 
WHERE ([K�zpontos�tottak].[Mez�4] Is Null OR [K�zpontos�tottak].[Mez�4]='')  AND ([K�zpontos�tottak].[Mez�4]<> '�res �ll�s' OR [K�zpontos�tottak].[Mez�4] is null ) 
 UNION SELECT 'K�zpontos�tottak' AS T�bla, 'Ad�azonos�t�' AS Hi�nyz�_�rt�k, K�zpontos�tottak.[Ad�azonos�t�], K�zpontos�tottak.[�ll�shely azonos�t�], K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] FROM [K�zpontos�tottak] 
WHERE ([K�zpontos�tottak].[Ad�azonos�t�] Is Null )  AND ([K�zpontos�tottak].[Mez�4]<> '�res �ll�s' OR [K�zpontos�tottak].[Mez�4] is null ) 
 UNION SELECT 'K�zpontos�tottak' AS T�bla, 'N�v' AS Hi�nyz�_�rt�k, K�zpontos�tottak.[Ad�azonos�t�], K�zpontos�tottak.[�ll�shely azonos�t�], K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] FROM [K�zpontos�tottak] 
WHERE ([K�zpontos�tottak].[N�v] Is Null OR [K�zpontos�tottak].[N�v]='')  AND ([K�zpontos�tottak].[Mez�4]<> '�res �ll�s' OR [K�zpontos�tottak].[Mez�4] is null );

-- [lk_Ellen�rz�s_01a]
SELECT [01a].T�bla, [01a].Hi�nyz�_�rt�k, [01a].Ad�azonos�t�, [01a].[�ll�shely azonos�t�], [01a].[�NYR SZERVEZETI EGYS�G AZONOS�T�], [Ad�azonos�t�]*1 AS ad�jel
FROM (SELECT 'lkKil�p�k' AS T�bla, 'Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja' AS Hi�nyz�_�rt�k, lkKil�p�Uni�.[Ad�azonos�t�], lkKil�p�Uni�.[�ll�shely azonos�t�], lkKil�p�Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
FROM [lkKil�p�Uni�] 
WHERE (([lkKil�p�Uni�].[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja] Is Null ) AND ((lkKil�p�Uni�.�v)>(Select dt�tal(Min(Tulajdons�g�rt�k)) From tAlapadatok Where Tulajdons�gNeve="Vizsg�ltEls��v")))
UNION 
SELECT 'lkKil�p�k' AS T�bla, 'Jogviszony kezd� d�tuma' AS Hi�nyz�_�rt�k, lkKil�p�Uni�.[Ad�azonos�t�], lkKil�p�Uni�.[�ll�shely azonos�t�], lkKil�p�Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
FROM [lkKil�p�Uni�] 
WHERE (([lkKil�p�Uni�].[Jogviszony kezd� d�tuma] Is Null ) AND ((lkKil�p�Uni�.�v)>(Select dt�tal(Min(Tulajdons�g�rt�k)) From tAlapadatok Where Tulajdons�gNeve="Vizsg�ltEls��v")))
UNION
SELECT 'lkKil�p�k' AS T�bla, 'Jogviszony megsz�n�s�nek, megsz�ntet�s�nek oka: jogszab�lyi hivatkoz�s sz�ma (�, bek., pontja)' AS Hi�nyz�_�rt�k, lkKil�p�Uni�.[Ad�azonos�t�], lkKil�p�Uni�.[�ll�shely azonos�t�], lkKil�p�Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
FROM [lkKil�p�Uni�] 
WHERE (([lkKil�p�Uni�].[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek oka: jogszab�lyi hiva] Is Null OR [lkKil�p�Uni�].[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek oka: jogszab�lyi hiva]='') AND ((lkKil�p�Uni�.�v)>(Select dt�tal(Min(Tulajdons�g�rt�k)) From tAlapadatok Where Tulajdons�gNeve="Vizsg�ltEls��v")))
UNION
SELECT 'lkKil�p�k' AS T�bla, '�ll�shely azonos�t�' AS Hi�nyz�_�rt�k, lkKil�p�Uni�.[Ad�azonos�t�], lkKil�p�Uni�.[�ll�shely azonos�t�], lkKil�p�Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
FROM [lkKil�p�Uni�] 
WHERE ( ([lkKil�p�Uni�].[�ll�shely azonos�t�] Is Null OR [lkKil�p�Uni�].[�ll�shely azonos�t�]='') AND ((lkKil�p�Uni�.�v)>(Select dt�tal(Min(Tulajdons�g�rt�k)) From tAlapadatok Where Tulajdons�gNeve="Vizsg�ltEls��v")))
UNION
SELECT 'lkKil�p�k' AS T�bla, 'Ell�tott feladatok megjel�l�se
a f�v�rosi �s megyei korm�nyhivatalok szervezeti �s m�k�d�si szab�lyzat�r�l sz�l� 3/2020. (II. 28.) MvM utas�t�s alapj�n' AS Hi�nyz�_�rt�k, lkKil�p�Uni�.[Ad�azonos�t�], lkKil�p�Uni�.[�ll�shely azonos�t�], lkKil�p�Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [lkKil�p�Uni�] 
WHERE (([lkKil�p�Uni�].[Mez�8] Is Null OR [lkKil�p�Uni�].[Mez�8]='') AND ((lkKil�p�Uni�.�v)>(Select dt�tal(Min(Tulajdons�g�rt�k)) From tAlapadatok Where Tulajdons�gNeve="Vizsg�ltEls��v")))
UNION
SELECT 'lkKil�p�k' AS T�bla, '�NYR SZERVEZETI EGYS�G AZONOS�T�' AS Hi�nyz�_�rt�k, lkKil�p�Uni�.[Ad�azonos�t�], lkKil�p�Uni�.[�ll�shely azonos�t�], lkKil�p�Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [lkKil�p�Uni�] 
WHERE (([lkKil�p�Uni�].[�NYR SZERVEZETI EGYS�G AZONOS�T�] Is Null OR [lkKil�p�Uni�].[�NYR SZERVEZETI EGYS�G AZONOS�T�]='') AND ((lkKil�p�Uni�.�v)>(Select dt�tal(Min(Tulajdons�g�rt�k)) From tAlapadatok Where Tulajdons�gNeve="Vizsg�ltEls��v")))
UNION
SELECT 'lkKil�p�k' AS T�bla, 'Szervezeti egys�g
Oszt�ly megnevez�se' AS Hi�nyz�_�rt�k, lkKil�p�Uni�.[Ad�azonos�t�], lkKil�p�Uni�.[�ll�shely azonos�t�], lkKil�p�Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [lkKil�p�Uni�] 
WHERE (([lkKil�p�Uni�].[Mez�6] Is Null OR [lkKil�p�Uni�].[Mez�6]='') AND ((lkKil�p�Uni�.�v)>(Select dt�tal(Min(Tulajdons�g�rt�k)) From tAlapadatok Where Tulajdons�gNeve="Vizsg�ltEls��v")))
UNION
SELECT 'lkKil�p�k' AS T�bla, 'Szervezeti egys�g
F�oszt�ly megnevez�se' AS Hi�nyz�_�rt�k, lkKil�p�Uni�.[Ad�azonos�t�], lkKil�p�Uni�.[�ll�shely azonos�t�], lkKil�p�Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [lkKil�p�Uni�] 
WHERE (([lkKil�p�Uni�].[Mez�5] Is Null OR [lkKil�p�Uni�].[Mez�5]='') AND ((lkKil�p�Uni�.�v)>(Select dt�tal(Min(Tulajdons�g�rt�k)) From tAlapadatok Where Tulajdons�gNeve="Vizsg�ltEls��v")))
UNION
SELECT 'lkKil�p�k' AS T�bla, 'Megyei szint VAGY J�r�si Hivatal' AS Hi�nyz�_�rt�k, lkKil�p�Uni�.[Ad�azonos�t�], lkKil�p�Uni�.[�ll�shely azonos�t�], lkKil�p�Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [lkKil�p�Uni�] 
WHERE (([lkKil�p�Uni�].[Megyei szint VAGY J�r�si Hivatal] Is Null OR [lkKil�p�Uni�].[Megyei szint VAGY J�r�si Hivatal]='') AND ((lkKil�p�Uni�.�v)>(Select dt�tal(Min(Tulajdons�g�rt�k)) From tAlapadatok Where Tulajdons�gNeve="Vizsg�ltEls��v")))
UNION
SELECT 'lkKil�p�k' AS T�bla, 'Ad�azonos�t�' AS Hi�nyz�_�rt�k, lkKil�p�Uni�.[Ad�azonos�t�], lkKil�p�Uni�.[�ll�shely azonos�t�], lkKil�p�Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [lkKil�p�Uni�] 
WHERE (([lkKil�p�Uni�].[Ad�azonos�t�] Is Null ) AND ((lkKil�p�Uni�.�v)>(Select dt�tal(Min(Tulajdons�g�rt�k)) From tAlapadatok Where Tulajdons�gNeve="Vizsg�ltEls��v")))
)  AS 01a;

-- #/#/#/
-- lk_Ellen�rz�s_01b
-- #/#/
SELECT [01b].T�bla, [01b].Hi�nyz�_�rt�k, [01b].Ad�azonos�t�, [01b].[�ll�shely azonos�t�], [01b].[�NYR SZERVEZETI EGYS�G AZONOS�T�], [Ad�azonos�t�]*1 AS Ad�jel
FROM (SELECT 'lkBel�p�k' AS T�bla, 'Ad�azonos�t�' AS Hi�nyz�_�rt�k, lkBel�p�k.[Ad�azonos�t�], lkBel�p�k.[�ll�shely azonos�t�], lkBel�p�k.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [lkBel�p�k]  WHERE ([lkBel�p�k].[Ad�azonos�t�] Is Null )   

UNION SELECT 'lkBel�p�k' AS T�bla, 'N�v' AS Hi�nyz�_�rt�k, lkBel�p�k.[Ad�azonos�t�], lkBel�p�k.[�ll�shely azonos�t�], lkBel�p�k.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [lkBel�p�k]  WHERE ([lkBel�p�k].[N�v] Is Null OR [lkBel�p�k].[N�v]='')   

UNION SELECT 'K�zpontos�tottak' AS T�bla, 'Legmagasabb iskolai v�gzetts�g 1=8. oszt�ly; 2=�retts�gi; 3=f�iskolai v�gzetts�g; 4=egyetemi v�gzetts�g; 5=technikus; 6= KAB vizsga' AS Hi�nyz�_�rt�k, K�zpontos�tottak.[Ad�azonos�t�], K�zpontos�tottak.[�ll�shely azonos�t�], K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] FROM [K�zpontos�tottak]  WHERE ([K�zpontos�tottak].[Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is] Is Null )  AND ([K�zpontos�tottak].[Mez�4]<> '�res �ll�s' OR [K�zpontos�tottak].[Mez�4] is null )   

UNION SELECT 'K�zpontos�tottak' AS T�bla, 'Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)' AS Hi�nyz�_�rt�k, K�zpontos�tottak.[Ad�azonos�t�], K�zpontos�tottak.[�ll�shely azonos�t�], K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] FROM [K�zpontos�tottak]  WHERE ([K�zpontos�tottak].[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)] Is Null OR [K�zpontos�tottak].[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)]='')  AND ([K�zpontos�tottak].[Mez�4]<> '�res �ll�s' OR [K�zpontos�tottak].[Mez�4] is null )   



  UNION SELECT 'K�zpontos�tottak' AS T�bla, 'Havi illetm�ny teljes �sszege (kerek�tve) (FT)' AS Hi�nyz�_�rt�k, K�zpontos�tottak.[Ad�azonos�t�], K�zpontos�tottak.[�ll�shely azonos�t�], K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] FROM [K�zpontos�tottak]  WHERE ([K�zpontos�tottak].[Mez�17] Is Null )  AND ([K�zpontos�tottak].[Mez�4]<> '�res �ll�s' OR [K�zpontos�tottak].[Mez�4] is null )  

 UNION SELECT 'K�zpontos�tottak' AS T�bla, '�ll�shely azonos�t�' AS Hi�nyz�_�rt�k, K�zpontos�tottak.[Ad�azonos�t�], K�zpontos�tottak.[�ll�shely azonos�t�], K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] FROM [K�zpontos�tottak]  WHERE ([K�zpontos�tottak].[�ll�shely azonos�t�] Is Null OR [K�zpontos�tottak].[�ll�shely azonos�t�]='')  AND ([K�zpontos�tottak].[Mez�4]<> '�res �ll�s' OR [K�zpontos�tottak].[Mez�4] is null )

   UNION SELECT 'K�zpontos�tottak' AS T�bla, 'Besorol�si fokozat megnevez�se:' AS Hi�nyz�_�rt�k, K�zpontos�tottak.[Ad�azonos�t�], K�zpontos�tottak.[�ll�shely azonos�t�], K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] FROM [K�zpontos�tottak]  WHERE ([K�zpontos�tottak].[Besorol�si fokozat megnevez�se:] Is Null OR [K�zpontos�tottak].[Besorol�si fokozat megnevez�se:]='')  AND ([K�zpontos�tottak].[Mez�4]<> '�res �ll�s' OR [K�zpontos�tottak].[Mez�4] is null )  

 UNION SELECT 'K�zpontos�tottak' AS T�bla, 'Besorol�si fokozat k�d:' AS Hi�nyz�_�rt�k, K�zpontos�tottak.[Ad�azonos�t�], K�zpontos�tottak.[�ll�shely azonos�t�], K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] FROM [K�zpontos�tottak]  WHERE ([K�zpontos�tottak].[Besorol�si fokozat k�d:] Is Null OR [K�zpontos�tottak].[Besorol�si fokozat k�d:]='')  AND ([K�zpontos�tottak].[Mez�4]<> '�res �ll�s' OR [K�zpontos�tottak].[Mez�4] is null )   

UNION SELECT 'K�zpontos�tottak' AS T�bla, '�ll�shely bet�lt�s�nek ar�nya �s �res �ll�shely bet�lt�s ar�nya' AS Hi�nyz�_�rt�k, K�zpontos�tottak.[Ad�azonos�t�], K�zpontos�tottak.[�ll�shely azonos�t�], K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] FROM [K�zpontos�tottak]  WHERE ([K�zpontos�tottak].[Mez�13] Is Null )  AND ([K�zpontos�tottak].[Mez�4]<> '�res �ll�s' OR [K�zpontos�tottak].[Mez�4] is null )
)  AS 01b;

-- [lk_Ellen�rz�s_01c]
SELECT [01c].T�bla, [01c].Hi�nyz�_�rt�k, [01c].Ad�azonos�t�, [01c].[�ll�shely azonos�t�], [01c].[�NYR SZERVEZETI EGYS�G AZONOS�T�], [Ad�azonos�t�]*1 AS Ad�jel
FROM (SELECT 'lkKil�p�k' AS T�bla, 'N�v' AS Hi�nyz�_�rt�k, lkKil�p�k.[Ad�azonos�t�], lkKil�p�k.[�ll�shely azonos�t�], lkKil�p�k.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [lkKil�p�k] 
WHERE ([lkKil�p�k].[N�v] Is Null OR [lkKil�p�k].[N�v]='') 
 UNION SELECT 'lkBel�p�k' AS T�bla, 'Illetm�ny (Ft/h�)' AS Hi�nyz�_�rt�k, lkBel�p�k.[Ad�azonos�t�], lkBel�p�k.[�ll�shely azonos�t�], lkBel�p�k.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [lkBel�p�k] 
WHERE ([lkBel�p�k].[Illetm�ny (Ft/h�)] Is Null ) 
 UNION SELECT 'lkBel�p�k' AS T�bla, 'Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)' AS Hi�nyz�_�rt�k, lkBel�p�k.[Ad�azonos�t�], lkBel�p�k.[�ll�shely azonos�t�], lkBel�p�k.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [lkBel�p�k] 
WHERE ([lkBel�p�k].[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)] Is Null OR [lkBel�p�k].[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)]='') 
 UNION SELECT 'lkBel�p�k' AS T�bla, 'Jogviszony kezd� d�tuma' AS Hi�nyz�_�rt�k, lkBel�p�k.[Ad�azonos�t�], lkBel�p�k.[�ll�shely azonos�t�], lkBel�p�k.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [lkBel�p�k] 
WHERE ([lkBel�p�k].[Jogviszony kezd� d�tuma] Is Null ) 
 UNION SELECT 'lkBel�p�k' AS T�bla, '�ll�shely azonos�t�' AS Hi�nyz�_�rt�k, lkBel�p�k.[Ad�azonos�t�], lkBel�p�k.[�ll�shely azonos�t�], lkBel�p�k.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [lkBel�p�k] 
WHERE ([lkBel�p�k].[�ll�shely azonos�t�] Is Null OR [lkBel�p�k].[�ll�shely azonos�t�]='') 
 UNION SELECT 'lkBel�p�k' AS T�bla, 'Ell�tott feladatok megjel�l�se
a f�v�rosi �s megyei korm�nyhivatalok szervezeti �s m�k�d�si szab�lyzat�r�l sz�l� 3/2020. (II. 28.) MvM utas�t�s alapj�n' AS Hi�nyz�_�rt�k, lkBel�p�k.[Ad�azonos�t�], lkBel�p�k.[�ll�shely azonos�t�], lkBel�p�k.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [lkBel�p�k] 
WHERE ([lkBel�p�k].[Mez�8] Is Null OR [lkBel�p�k].[Mez�8]='') 
 UNION SELECT 'lkBel�p�k' AS T�bla, '�NYR SZERVEZETI EGYS�G AZONOS�T�' AS Hi�nyz�_�rt�k, lkBel�p�k.[Ad�azonos�t�], lkBel�p�k.[�ll�shely azonos�t�], lkBel�p�k.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [lkBel�p�k] 
WHERE ([lkBel�p�k].[�NYR SZERVEZETI EGYS�G AZONOS�T�] Is Null OR [lkBel�p�k].[�NYR SZERVEZETI EGYS�G AZONOS�T�]='') 
 UNION SELECT 'lkBel�p�k' AS T�bla, 'Szervezeti egys�g
Oszt�ly megnevez�se' AS Hi�nyz�_�rt�k, lkBel�p�k.[Ad�azonos�t�], lkBel�p�k.[�ll�shely azonos�t�], lkBel�p�k.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [lkBel�p�k] 
WHERE ([lkBel�p�k].[Mez�6] Is Null OR [lkBel�p�k].[Mez�6]='') 
 UNION SELECT 'lkBel�p�k' AS T�bla, 'Szervezeti egys�g
F�oszt�ly megnevez�se' AS Hi�nyz�_�rt�k, lkBel�p�k.[Ad�azonos�t�], lkBel�p�k.[�ll�shely azonos�t�], lkBel�p�k.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [lkBel�p�k] 
WHERE ([lkBel�p�k].[Mez�5] Is Null OR [lkBel�p�k].[Mez�5]='') 
 UNION SELECT 'lkBel�p�k' AS T�bla, 'Megyei szint VAGY J�r�si Hivatal' AS Hi�nyz�_�rt�k, lkBel�p�k.[Ad�azonos�t�], lkBel�p�k.[�ll�shely azonos�t�], lkBel�p�k.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [lkBel�p�k] 
WHERE ([lkBel�p�k].[Megyei szint VAGY J�r�si Hivatal] Is Null OR [lkBel�p�k].[Megyei szint VAGY J�r�si Hivatal]='')
)  AS 01c;

-- [lk_Ellen�rz�s_01d_Illetm�ny_nulla]
SELECT [01D].T�bla, [01D].Hi�nyz�_�rt�k, [01D].Ad�jel AS Ad�azonos�t�, [01D].[�NYR SZERVEZETI EGYS�G AZONOS�T�], [�ll�shely azonos�t�]
FROM (SELECT 'J�r�si_�llom�ny' as T�bla, 'Illetm�ny' As [Hi�nyz�_�rt�k], [Ad�azonos�t�] As Ad�jel, [�NYR SZERVEZETI EGYS�G AZONOS�T�]  , [�ll�shely azonos�t�]
 FROM [J�r�si_�llom�ny] WHERE [Mez�18]=0 AND ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null )  
UNION 
SELECT 'Korm�nyhivatali_�llom�ny' as T�bla, 'Illetm�ny' As [Hi�nyz� �rt�k], [Ad�azonos�t�] As Ad�jel, [�NYR SZERVEZETI EGYS�G AZONOS�T�] As SzervezetK�d , [�ll�shely azonos�t�]
 FROM [Korm�nyhivatali_�llom�ny] WHERE [Mez�18]=0 AND ([Korm�nyhivatali_�llom�ny].[Mez�4]<> '�res �ll�s' OR [Korm�nyhivatali_�llom�ny].[Mez�4] is null )  
UNION 
SELECT 'K�zpontos�tottak' as T�bla, 'Illetm�ny' As [Hi�nyz� �rt�k], [Ad�azonos�t�] As Ad�jel, [Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] As SzervezetK�d , [�ll�shely azonos�t�]
 FROM [K�zpontos�tottak] WHERE [Mez�17]=0 AND ([K�zpontos�tottak].[Mez�4]<> '�res �ll�s' OR [K�zpontos�tottak].[Mez�4] is null )  
UNION 
SELECT 'lkBel�p�k' as T�bla, 'Illetm�ny' As [Hi�nyz� �rt�k], [Ad�azonos�t�] As Ad�jel, [�NYR SZERVEZETI EGYS�G AZONOS�T�] As SzervezetK�d , [�ll�shely azonos�t�]
FROM [lkBel�p�k] WHERE [Illetm�ny (Ft/h�)]=0 AND ([lkBel�p�k].[�res]<> '�res �ll�s' OR [lkBel�p�k].[�res] is null )  
UNION 
SELECT 'lkKil�p�k' as T�bla, 'Illetm�ny' As [Hi�nyz� �rt�k], [Ad�azonos�t�] As Ad�jel, [�NYR SZERVEZETI EGYS�G AZONOS�T�] As SzervezetK�d , [�ll�shely azonos�t�]
FROM [lkKil�p�k] WHERE [Illetm�ny (Ft/h�)]=0 AND ([lkKil�p�k].[�res]<> '�res �ll�s' OR [lkKil�p�k].[�res] is null )  
UNION 
SELECT 'lkHat�rozottak_TT' as T�bla, 'Illetm�ny' As [Hi�nyz� �rt�k], [Ad�azonos�t�] As Ad�jel, [�NYR SZERVEZETI EGYS�G AZONOS�T�] As SzervezetK�d, [�ll�shely azonos�t�]
 FROM [lkHat�rozottak_TT] WHERE [Tart�san t�voll�v� illetm�ny�nek teljes �sszege]=0 AND ([lkHat�rozottak_TT].[�res]<> '�res �ll�s' OR [lkHat�rozottak_TT].[�res] is null )  
UNION 
SELECT 'lkHat�rozottak_TTH' as T�bla, 'Illetm�ny' As [Hi�nyz� �rt�k], [Mez�17] As Ad�jel, [Mez�25] As SzervezetK�d , [Mez�25]
FROM [lkHat�rozottak_TTH] WHERE [Tart�s t�voll�v� st�tusz�n foglalkoztatott illetm�ny�nek teljes ]=0 AND ([lkHat�rozottak_TTH].[�res]<> '�res �ll�s' OR [lkHat�rozottak_TTH].[�res] is null )
)  AS 01D;

-- [lk_Ellen�rz�s_01e_R�szmunkaid�_Munkaid�_elt�r�sek_Szem�ly-ben]
SELECT "Szem�lyt�rzs" AS T�bla, IIf(IIf([elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]=40,"T","R")="T" And Switch([Foglalkoz�si viszony statisztikai besorol�sa] Like "*teljes*","T",[Foglalkoz�si viszony statisztikai besorol�sa] Like "*r�szmunkaid�s*","R",[Foglalkoz�si viszony statisztikai besorol�sa] Not Like "*teljes*" And [Foglalkoz�si viszony statisztikai besorol�sa] Not Like "*r�szmunkaid�s*","-")="R","R�szmunkaid�snek van jel�lve, de teljes munkaid�ben dolgozik.","Teljes munkaid�snek van jel�lve, de r�szmunkaid�ben dolgozik.") AS [Hi�nyz� �rt�k], lkSzem�lyek.[Ad�azonos�t� jel] AS Ad�azonos�t�, lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.[Szervezeti egys�g k�dja] AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], lkSzem�lyek.Ad�jel
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz k�dja]) Like "S-*") AND ((lkSzem�lyek.[Foglalkoz�si viszony statisztikai besorol�sa]) Not Like "�*") AND ((IIf([elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]=40,"T","R")<>Switch([Foglalkoz�si viszony statisztikai besorol�sa] Like "*teljes*","T",[Foglalkoz�si viszony statisztikai besorol�sa] Like "*r�szmunkaid�s*","R",[Foglalkoz�si viszony statisztikai besorol�sa] Not Like "*teljes*" And [Foglalkoz�si viszony statisztikai besorol�sa] Not Like "*r�szmunkaid�s*","-"))=True));

-- [lk_Ellen�rz�s_01e_R�szmunkaid�_Munkaid�_elt�r�sek_t�bl�kban]
SELECT DISTINCT "Szem�ly �s Havi" AS T�bla, Uni�Uni�.Hi�nyz�_�rt�k, Uni�Uni�.Ad�azonos�t�, Uni�Uni�.[�ll�shely azonos�t�], Uni�Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�], Uni�Uni�.Ad�jel
FROM (SELECT DISTINCT T�bla, R�szmunkaid�sUni�.Hi�nyz�_�rt�k, R�szmunkaid�sUni�.Ad�azonos�t�, R�szmunkaid�sUni�.[�ll�shely azonos�t�], R�szmunkaid�sUni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�], [Ad�azonos�t�]*1 AS Ad�jel
FROM (SELECT "Korm�nyhivatali_�llom�ny" AS T�bla
, "R�szmunkaid�snek van jel�lve, de teljes munkaid�ben dolgozik." AS [Hi�nyz�_�rt�k]
, Korm�nyhivatali_�llom�ny.Ad�azonos�t�, Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�]
, Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
, Korm�nyhivatali_�llom�ny.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ]
, Korm�nyhivatali_�llom�ny.[Heti munka�r�k sz�ma]
, IIf(Right([Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ],1)="R" And [Heti munka�r�k sz�ma]=40,True,False) AS Hib�s
FROM Korm�nyhivatali_�llom�ny
WHERE (((
IIf
             (Right([Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ],1)="R" 
     And [Heti munka�r�k sz�ma]=40
   ,True
   ,False))
=-1))
UNION
SELECT "J�r�si_�llom�ny" AS T�bla
, "R�szmunkaid�snek van jel�lve, de teljes munkaid�ben dolgozik." AS [Hib�s �rt�k]
, J�r�si_�llom�ny.Ad�azonos�t�
, J�r�si_�llom�ny.[�ll�shely azonos�t�]
, J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
, J�r�si_�llom�ny.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ]
, J�r�si_�llom�ny.[Heti munka�r�k sz�ma]
, IIf(Right([Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ],1)="R" And [Heti munka�r�k sz�ma]=40,True,False) AS Hib�s
FROM J�r�si_�llom�ny
WHERE (((
IIf
             (Right([Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ],1)="R" 
     And [Heti munka�r�k sz�ma]=40
   ,True
   ,False))
=-1))
UNION
SELECT "Korm�nyhivatali_�llom�ny" AS T�bla
, "Teljes munkaid�snek van jel�lve, de r�szmunkaid�ben dolgozik." AS [Hib�s �rt�k]
, Korm�nyhivatali_�llom�ny.Ad�azonos�t�, Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�]
, Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
, Korm�nyhivatali_�llom�ny.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ]
, Korm�nyhivatali_�llom�ny.[Heti munka�r�k sz�ma]
, IIf(Right([Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ],1)="T" And [Heti munka�r�k sz�ma]<>40,True,False) AS Hib�s
FROM Korm�nyhivatali_�llom�ny
WHERE (((
IIf
             (Right([Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ],1)="T" 
     And [Heti munka�r�k sz�ma]<>40
   ,True
   ,False))
=-1))
UNION SELECT "J�r�si_�llom�ny" AS T�bla
, "Teljes munkaid�snek van jel�lve, de r�szmunkaid�ben dolgozik." AS [Hib�s �rt�k]
, J�r�si_�llom�ny.Ad�azonos�t�
, J�r�si_�llom�ny.[�ll�shely azonos�t�]
, J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
, J�r�si_�llom�ny.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ]
, J�r�si_�llom�ny.[Heti munka�r�k sz�ma]
, IIf(Right([Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ],1)="T" And [Heti munka�r�k sz�ma]<>40,True,False) AS Hib�s
FROM J�r�si_�llom�ny
WHERE (((
IIf
             (Right([Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ],1)="T" 
     And [Heti munka�r�k sz�ma]<>40
   ,True
   ,False))
=-1))
)  AS R�szmunkaid�sUni�
UNION SELECT *
FROM [lk_Ellen�rz�s_01e_R�szmunkaid�_Munkaid�_elt�r�sek_Szem�ly-ben])  AS Uni�Uni�;

-- [lk_Ellen�rz�s_01f_hi�nyz�_besorol�s_megnevez�s]
SELECT Uni�5t�bla.T�bla, Uni�5t�bla.Hi�nyz�_�rt�k, Uni�5t�bla.Ad�azonos�t�, Uni�5t�bla.[�ll�shely azonos�t�], Uni�5t�bla.[�NYR SZERVEZETI EGYS�G AZONOS�T�], [Ad�azonos�t�]*1 AS Ad�jel
FROM (SELECT Korm�nyhivatali_�llom�ny.Ad�azonos�t�, Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�], "Korm�nyhivatali_�llom�ny" AS T�bla, "Besorol�si fokozat megnevez�se:" AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.[Besorol�si fokozat megnevez�se:]
FROM Korm�nyhivatali_�llom�ny LEFT JOIN lkSzem�lyek ON Korm�nyhivatali_�llom�ny.Ad�azonos�t� = lkSzem�lyek.[Ad�azonos�t� jel]
WHERE (((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])<>"hivat�sos �llom�ny�"))

UNION
SELECT Korm�nyhivatali_�llom�ny.Ad�azonos�t�, Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�], "Korm�nyhivatali_�llom�ny" AS T�bla, "Besorol�si fokozat megnevez�se:" AS Hi�nyz�_�rt�k, Korm�nyhivatali_�llom�ny.[Besorol�si fokozat megnevez�se:]
FROM Korm�nyhivatali_�llom�ny LEFT JOIN lkSzem�lyek ON Korm�nyhivatali_�llom�ny.Ad�azonos�t� = lkSzem�lyek.[Ad�azonos�t� jel]
WHERE (((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])<>"hivat�sos �llom�ny�"))

UNION
SELECT K�zpontos�tottak.Ad�azonos�t�, K�zpontos�tottak.[�ll�shely azonos�t�], K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�], "K�zpontos�tottak" as T�bla, "Besorol�si fokozat megnevez�se:" as Hi�nyz�_�rt�k,  [Besorol�si fokozat megnevez�se:]
FROM   K�zpontos�tottak
WHERE '///--- T�r�ltem, mert a ki- �s bel�p�k t�bl�kb�l a jogviszony nem �llap�that� meg, de a munkaviszonyosokra nem j�n le adat
UNION
SELECT lkBel�p�k.Ad�azonos�t�, lkBel�p�k.[�ll�shely azonos�t�], lkBel�p�k.[�NYR SZERVEZETI EGYS�G AZONOS�T�], "lkBel�p�k" as T�bla, "Besorol�si fokozat megnevez�se:" as Hi�nyz�_�rt�k, [Besorol�si fokozat megnevez�se:]
FROM lkBel�p�k

UNION
SELECT lkKil�p�k.Ad�azonos�t�, lkKil�p�k.[�ll�shely azonos�t�], lkKil�p�k.[�NYR SZERVEZETI EGYS�G AZONOS�T�], "lkKil�p�k" as T�bla, "Besorol�si fokozat megnevez�se:" as Hi�nyz�_�rt�k, [Besorol�si fokozat megnevez�se:]
FROM lkKil�p�k
---///'

)  AS Uni�5t�bla
WHERE (((Uni�5t�bla.[Besorol�si fokozat megnevez�se:]) Is Null Or (Uni�5t�bla.[Besorol�si fokozat megnevez�se:])="Error 2042"));

-- [lk_Ellen�rz�s_01f2_hi�nyz�_besorol�s_megnevez�sSzem�ly]
SELECT "Szem�lyt�rzs alapriport" AS T�bla, "Besorol�si fokozat (Szem�lyt�rzs)" AS Hi�nyz�_�rt�k, lkSzem�lyek.[Ad�azonos�t� jel] AS Ad�azonos�t�, lkSzem�lyek.[st�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.[szervezeti egys�g k�dja] AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], lkSzem�lyek.Ad�jel
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Besorol�si  fokozat (KT)]) Is Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])<>"Hivat�sos �llom�ny�" And (lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])<>"Munkaviszony"));

-- [lk_Ellen�rz�s_01g_MunkahelyC�mHi�nya]
SELECT "tSzem�lyek" AS T�bla, "Munkav�gz�s helye - c�m" AS Hi�nyz�_�rt�k, lkSzem�lyek.Ad�jel AS Ad�azonos�t�, lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.[Szervezeti egys�g k�dja] AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], lkSzem�lyek.Ad�jel
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null) AND ((lkSzem�lyek.[Munkav�gz�s helye - c�m]) Is Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null));

-- [lk_Ellen�rz�s_01h_HivataliEmailHi�nya]
SELECT lk_Ellen�rz�s_01h_HivataliEmailHi�nya00.T�bla, lk_Ellen�rz�s_01h_HivataliEmailHi�nya00.Hi�nyz�_�rt�k, lk_Ellen�rz�s_01h_HivataliEmailHi�nya00.Ad�azonos�t�, lk_Ellen�rz�s_01h_HivataliEmailHi�nya00.[�ll�shely azonos�t�], lk_Ellen�rz�s_01h_HivataliEmailHi�nya00.[�NYR SZERVEZETI EGYS�G AZONOS�T�], lk_Ellen�rz�s_01h_HivataliEmailHi�nya00.Ad�jel
FROM lk_Ellen�rz�s_01h_HivataliEmailHi�nya00
GROUP BY lk_Ellen�rz�s_01h_HivataliEmailHi�nya00.T�bla, lk_Ellen�rz�s_01h_HivataliEmailHi�nya00.Hi�nyz�_�rt�k, lk_Ellen�rz�s_01h_HivataliEmailHi�nya00.Ad�azonos�t�, lk_Ellen�rz�s_01h_HivataliEmailHi�nya00.[�ll�shely azonos�t�], lk_Ellen�rz�s_01h_HivataliEmailHi�nya00.[�NYR SZERVEZETI EGYS�G AZONOS�T�], lk_Ellen�rz�s_01h_HivataliEmailHi�nya00.Ad�jel;

-- [lk_Ellen�rz�s_01h_HivataliEmailHi�nya00]
SELECT "Szem�lyt�rzs" AS T�bla, "Hivatali email" AS Hi�nyz�_�rt�k, tSzem�lyek.[Ad�azonos�t� jel] AS Ad�azonos�t�, tSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], tSzem�lyek.[Szervezeti egys�g k�dja] AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], tSzem�lyek.Ad�jel, tSzem�lyek.[Jogviszony sorsz�ma]
FROM tSzem�lyek
WHERE (((tSzem�lyek.[St�tusz neve])="�ll�shely") AND ((Len(Nz([Hivatali email]," ")))<4) AND ((tSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null))
ORDER BY tSzem�lyek.Ad�jel, tSzem�lyek.[Jogviszony sorsz�ma] DESC;

-- [lk_Ellen�rz�s_01i_Feladatk�rN�lk�liek]
SELECT DISTINCT "Szem�lyt�rzs" AS T�bla, "KIRA feladatk�r" AS Hi�nyz�_�rt�k, lkSzem�lyek.[Ad�azonos�t� jel] AS Ad�azonos�t�, lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.[Szervezeti egys�g k�dja] AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], lkSzem�lyek.Ad�jel
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[KIRA feladat megnevez�s]) Is Null Or (lkSzem�lyek.[KIRA feladat megnevez�s])="") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY "KIRA feladatk�r";

-- [lk_Ellen�rz�s_01j_NemInakt�vTT_s]
SELECT "Szem�lyek vs. Szervezeti" AS T�bla, "A 'tart�s t�voll�t t�pusa': <�res>, ugyanakkor a 'St�tuszbet�lt�s t�pusa': ""Inakt�v""" AS Hi�nyz�_�rt�k, lkSzem�lyek.[Ad�azonos�t� jel] AS Ad�azonos�t�, lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.[Szervezeti egys�g k�dja] AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], lkSzem�lyek.Ad�jel
FROM lk_Inakt�vBet�lt�k�s�ll�shely�k RIGHT JOIN lkSzem�lyek ON lk_Inakt�vBet�lt�k�s�ll�shely�k.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null) AND ((lk_Inakt�vBet�lt�k�s�ll�shely�k.Ad�jel) Is Not Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
AND "####Az inakt�v bet�lt�k k�z�tt keresi meg azokat, akiknek a tart�s t�voll�t t�pusa mez� a szem�lyt�rzsben Null. #####";

-- [lk_Ellen�rz�s_01jj_Inakt�vNemTT_s]
SELECT "Szem�lyek vs. Szervezeti" AS T�bla, "A 'tart�s t�voll�t t�pusa': """ & [Tart�s t�voll�t t�pusa] & """, ugyanakkor a 'St�tuszbet�lt�s t�pusa': nem ""Inakt�v""" AS Hi�nyz�_�rt�k, lkSzem�lyek.[Ad�azonos�t� jel] AS Ad�azonos�t�, lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.[Szervezeti egys�g k�dja] AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], lkSzem�lyek.Ad�jel
FROM lk_Inakt�vBet�lt�k�s�ll�shely�k LEFT JOIN lkSzem�lyek ON lk_Inakt�vBet�lt�k�s�ll�shely�k.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Not Null) AND ((lk_Inakt�vBet�lt�k�s�ll�shely�k.Ad�jel) Is Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND (("##### Azokat keresi a szem�lyt�rzsben, akiknek a tart�s t�voll�t t�pusa nem Null, de az inakt�v bet�lt�k lek�rdez�sben nem szerepelnek. ####")<>""));

-- [lk_Ellen�rz�s_01k_Utal�siC�mHi�nya]
SELECT "tSzem�lyek" AS T�bla, "Utal�si - c�m" AS Hi�nyz�_�rt�k, lkSzem�lyek.Ad�jel AS Ad�azonos�t�, lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.[Szervezeti egys�g k�dja] AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], lkSzem�lyek.Ad�jel
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null) AND ((ffsplit([Utal�si c�m],"|",3))="") AND ((lkSzem�lyek.[St�tusz t�pusa]) Is Not Null));

-- [lk_Ellen�rz�s_01L_IskolaiV�gzetts�gFoka]
SELECT "tSzem�lyek" AS T�bla, "A legmagasabb iskolai v�gzetts�g foka" AS Hi�nyz�_�rt�k, lkSzem�lyek.Ad�jel AS Ad�azonos�t�, lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.[Szervezeti egys�g k�dja] AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], lkSzem�lyek.Ad�jel
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null) AND ((lkSzem�lyek.[Iskolai v�gzetts�g foka]) Is Null) AND ((lkSzem�lyek.[St�tusz t�pusa]) Is Not Null));

-- [lk_Ellen�rz�s_01m_AlapvizsgaHi�nya]
SELECT "tSzem�lyek" AS T�bla, "Letelt a pr�baid�, de nincs alapvizsga hat�rid� kit�zve" AS Hi�nyz�_�rt�k, lkSzem�lyek.Ad�jel AS Ad�azonos�t�, lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.[Szervezeti egys�g k�dja] AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], lkSzem�lyek.Ad�jel, lkSzem�lyek.[Alapvizsga let�tel t�nyleges hat�rideje] AS AlapHat�rid�, lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge] AS Pr�baid�V�ge, lkSzem�lyek.[Alapvizsga mentess�g], lkSzem�lyek.[St�tusz neve]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null) AND ((lkSzem�lyek.[Alapvizsga let�tel t�nyleges hat�rideje]) Is Null) AND ((lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge])<Date()) AND ((lkSzem�lyek.[Alapvizsga mentess�g])<>True) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[St�tusz t�pusa]) Is Not Null));

-- [lk_Ellen�rz�s_01m_Esk�let�telId�pontHi�ny]
SELECT "tEsk�Lej�rtId�pontok" AS T�bla, "Esk�let�tel id�pontja" AS Hi�nyz�_�rt�k, lkSzem�lyek.[Ad�azonos�t� jel] AS Ad�azonos�t�, lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.[szervezeti egys�g k�dja] AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], lkSzem�lyek.Ad�jel
FROM lkSzem�lyek LEFT JOIN lkLej�r�Hat�rid�k ON lkSzem�lyek.[Ad�azonos�t� jel] = lkLej�r�Hat�rid�k.[Ad�azonos�t� jel]
WHERE (((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)]) Between DateSerial(2024,11,1) And DateSerial(Year(Now()),Month(Now())-1,1)) AND ((lkLej�r�Hat�rid�k.[Figyelend� d�tum])=0) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])="Korm�nyzati szolg�lati jogviszony"));

-- [lk_Ellen�rz�s_01n_K�zpontos�tottK�lts�ghelyN�lk�l]
SELECT DISTINCT "tSzem�lyek" AS T�bla, "K�zpontos�tott �ll�shelyhez nincs megjel�lve k�lts�ghely vagy k�lts�ghely-k�d (projekt)." AS Hi�nyz�_�rt�k, lkSzem�lyek.Ad�jel AS Ad�azonos�t�, lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.[Szervezeti egys�g k�dja] AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], lkSzem�lyek.Ad�jel
FROM kt_azNexon_Ad�jel02 RIGHT JOIN lkSzem�lyek ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null) AND (([lkSzem�lyek].[St�tusz k�lts�ghely�nek neve]) Is Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[St�tusz t�pusa])="K�zpontos�tott �llom�ny")) OR (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[St�tusz t�pusa])="K�zpontos�tott �llom�ny") AND ((lkSzem�lyek.[St�tusz k�lts�ghely�nek k�dja]) Is Null));

-- [lk_Ellen�rz�s_01n_K�zpontos�tottK�lts�ghelyN�lk�lDolgoz�]
SELECT DISTINCT "tSzem�lyek" AS T�bla, "K�zpontos�tott �ll�shelyhez nincs megjel�lve k�lts�ghely vagy k�lts�ghely-k�d (projekt)." AS Hi�nyz�_�rt�k, lkSzem�lyek.Ad�jel AS Ad�azonos�t�, lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.[Szervezeti egys�g k�dja] AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], lkSzem�lyek.Ad�jel
FROM kt_azNexon_Ad�jel02 RIGHT JOIN lkSzem�lyek ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[Dolgoz� k�lts�ghely�nek k�dja]) Is Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[St�tusz t�pusa])="K�zpontos�tott �llom�ny")) OR (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[St�tusz t�pusa])="K�zpontos�tott �llom�ny") AND ((lkSzem�lyek.[Dolgoz� k�lts�ghely�nek neve]) Is Null));

-- [lk_Ellen�rz�s_01nn_Havib�lK�zpontos�tottK�lts�ghelyN�lk�l]
SELECT DISTINCT "K�zpontos�tottak" AS T�bla, "K�zpontos�tott �ll�shelyhez nincs megjel�lve k�lts�ghely vagy k�lts�ghely-k�d (projekt megnevez�se)." AS Hi�nyz�_�rt�k, K�zpontos�tottakAllek�rdez�s.Ad�azonos�t�, K�zpontos�tottakAllek�rdez�s.[�ll�shely azonos�t�], K�zpontos�tottakAllek�rdez�s.[�NYR SZERVEZETI EGYS�G AZONOS�T�], K�zpontos�tottakAllek�rdez�s.Ad�jel
FROM (SELECT Nz([Ad�azonos�t�],0)*1 AS Ad�jel, * FROM lkK�zpontos�tottak WHERE Nz([Ad�azonos�t�],0)<>0 AND Ad�azonos�t�<>"")  AS K�zpontos�tottakAllek�rdez�s RIGHT JOIN kt_azNexon_Ad�jel02 ON K�zpontos�tottakAllek�rdez�s.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel
WHERE (((K�zpontos�tottakAllek�rdez�s.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s") AND ((K�zpontos�tottakAllek�rdez�s.[Projekt megnevez�se])=""));

-- [lk_Ellen�rz�s_01o_TTs_OkHi�nya]
SELECT [01O].T�bla, [01O].Hi�nyz�_�rt�k, [01O].Ad�jel AS Ad�azonos�t�, [01O].[�NYR SZERVEZETI EGYS�G AZONOS�T�], [01O].[�ll�shely azonos�t�]
FROM (SELECT 'J�r�si_�llom�ny' AS T�bla, 'TT oka' AS [Hi�nyz�_�rt�k], J�r�si_�llom�ny.[Ad�azonos�t�] AS Ad�jel, J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�], J�r�si_�llom�ny.[�ll�shely azonos�t�]
FROM J�r�si_�llom�ny
WHERE (((J�r�si_�llom�ny.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h])<>"GB" And (J�r�si_�llom�ny.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h])<>"") AND ((J�r�si_�llom�ny.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp])="") AND ((J�r�si_�llom�ny.Mez�4)<>'�res �ll�s' Or (J�r�si_�llom�ny.Mez�4) Is Null))
UNION
SELECT 'Korm�nyhivatali_�llom�ny' AS T�bla, 'TT oka' AS [Hi�nyz�_�rt�k], Korm�nyhivatali_�llom�ny.Ad�azonos�t� AS Ad�jel, Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] AS SzervezetK�d, Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�]
FROM Korm�nyhivatali_�llom�ny
WHERE (((Korm�nyhivatali_�llom�ny.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h])<>"GB" And (Korm�nyhivatali_�llom�ny.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h])<>"") AND ((Korm�nyhivatali_�llom�ny.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp])="") AND ((Korm�nyhivatali_�llom�ny.Mez�4)<>'�res �ll�s' Or (Korm�nyhivatali_�llom�ny.Mez�4) Is Null))
UNION
SELECT 'K�zpontos�tottak' AS T�bla, 'TT oka' AS [Hi�nyz�_�rt�k], K�zpontos�tottak.[Ad�azonos�t�] AS Ad�jel, K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] AS SzervezetK�d, K�zpontos�tottak.[�ll�shely azonos�t�]
FROM K�zpontos�tottak
WHERE (((K�zpontos�tottak.[Tart�s t�voll�v� nincs helyettese (TT)/ tart�s t�voll�v�nek van ])<>"GB" And (K�zpontos�tottak.[Tart�s t�voll�v� nincs helyettese (TT)/ tart�s t�voll�v�nek van ])<>"") AND ((K�zpontos�tottak.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp])="") AND ((K�zpontos�tottak.Mez�4)<>'�res �ll�s' Or (K�zpontos�tottak.Mez�4) Is Null))
)  AS 01O;

-- [lk_Ellen�rz�s_01p_Els�dleges�llampolg�rs�gHi�nya]
SELECT "tSzem�lyek" AS T�bla, "Els�dleges �llampolg�rs�g hi�nyzik, vagy nem �rv�nyes" AS Hi�nyz�_�rt�k, lkSzem�lyek.Ad�jel AS Ad�azonos�t�, lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.[Szervezeti egys�g k�dja] AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], lkSzem�lyek.Ad�jel
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Els�dleges �llampolg�rs�g]) Is Null Or (lkSzem�lyek.[Els�dleges �llampolg�rs�g])="") AND ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])<>"Szem�lyes jelenl�t" And (lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])<>"Megb�z�sos") AND ((lkSzem�lyek.Kil�p�sD�tuma)>(Select dt�tal(Min(Tulajdons�g�rt�k)) From tAlapadatok Where Tulajdons�gNeve="Vizsg�ltEls��v") Or (lkSzem�lyek.Kil�p�sD�tuma)=0) AND ((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])<Date()));

-- [lk_Ellen�rz�s_01q_�lland�Lakc�mHi�nya]
SELECT "tSzem�lyek" AS T�bla, "�lland� lakc�m hi�nyzik, vagy nem �rv�nyes" AS Hi�nyz�_�rt�k, lkSzem�lyek.Ad�jel AS Ad�azonos�t�, lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.[Szervezeti egys�g k�dja] AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], lkSzem�lyek.Ad�jel
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[�lland� lakc�m]) Is Null Or (lkSzem�lyek.[�lland� lakc�m])="") AND ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])<>"Szem�lyes jelenl�t" And (lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])<>"Megb�z�sos") AND ((lkSzem�lyek.Kil�p�sD�tuma)>Date() Or (lkSzem�lyek.Kil�p�sD�tuma)=0) AND ((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])<Date()));

-- [lk_Ellen�rz�s_01r_Funkci�Hi�nyzik]
SELECT "tSzem�lyek" AS T�bla, "Funkci� hi�nyzik" AS Hi�nyz�_�rt�k, lkSzem�lyek.Ad�jel AS Ad�azonos�t�, lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.[Szervezeti egys�g k�dja] AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], lkSzem�lyek.Ad�jel
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Funkci�: k�d-megnevez�s]) Is Null Or (lkSzem�lyek.[Funkci�: k�d-megnevez�s])="") AND ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])<>"Szem�lyes jelenl�t" And (lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])<>"Megb�z�sos") AND ((lkSzem�lyek.Kil�p�sD�tuma)>(Select dt�tal(Min(Tulajdons�g�rt�k)) From tAlapadatok Where Tulajdons�gNeve="Vizsg�ltEls��v") Or (lkSzem�lyek.Kil�p�sD�tuma)=0) AND ((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])<Date()));

-- [lk_Ellen�rz�s_01rr_Funkci�csoportHi�nyzik]
SELECT "tSzem�lyek" AS T�bla, "Funkci�csoport hi�nyzik" AS Hi�nyz�_�rt�k, lkSzem�lyek.Ad�jel AS Ad�azonos�t�, lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.[Szervezeti egys�g k�dja] AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], lkSzem�lyek.Ad�jel
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Funkci�csoport: k�d-megnevez�s]) Is Null Or (lkSzem�lyek.[Funkci�csoport: k�d-megnevez�s])="") AND ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])<>"Szem�lyes jelenl�t" And (lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])<>"Megb�z�sos") AND ((lkSzem�lyek.Kil�p�sD�tuma)>(Select dt�tal(Min(Tulajdons�g�rt�k)) From tAlapadatok Where Tulajdons�gNeve="Vizsg�ltEls��v") Or (lkSzem�lyek.Kil�p�sD�tuma)=0) AND ((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])<Date()));

-- [lk_Ellen�rz�s_02]
INSERT INTO t__Ellen�rz�s_02 ( T�bla, Hi�nyz�_�rt�k, Ad�azonos�t�, [�ll�shely azonos�t�], [�NYR SZERVEZETI EGYS�G AZONOS�T�], Ad�jel )
SELECT lk_Ellen�rz�s_01.T�bla, lk_Ellen�rz�s_01.Hi�nyz�_�rt�k, lk_Ellen�rz�s_01.Ad�azonos�t�, lk_Ellen�rz�s_01.[�ll�shely azonos�t�], lk_Ellen�rz�s_01.[�NYR SZERVEZETI EGYS�G AZONOS�T�], [Ad�azonos�t�]*1 AS Ad�jel
FROM lk_Ellen�rz�s_01;

-- [lk_Ellen�rz�s_02_t�bl�ba_ad�jelKonverzi�]
UPDATE t__Ellen�rz�s_02 SET t__Ellen�rz�s_02.Ad�jel = CDbl([Ad�azonos�t�]);

-- [lk_Ellen�rz�s_02a]
INSERT INTO t__Ellen�rz�s_02
SELECT lk_Ellen�rz�s_01a.*
FROM lk_Ellen�rz�s_01a;

-- [lk_Ellen�rz�s_02b]
INSERT INTO t__Ellen�rz�s_02
SELECT lk_Ellen�rz�s_01b.*
FROM lk_Ellen�rz�s_01b;

-- [lk_Ellen�rz�s_02c]
INSERT INTO t__Ellen�rz�s_02
SELECT lk_Ellen�rz�s_01c.*
FROM lk_Ellen�rz�s_01c;

-- [lk_Ellen�rz�s_02d_Illetm�ny_nulla]
INSERT INTO t__Ellen�rz�s_02 ( T�bla, Hi�nyz�_�rt�k, Ad�azonos�t�, [�NYR SZERVEZETI EGYS�G AZONOS�T�] )
SELECT lk_Ellen�rz�s_01d_Illetm�ny_nulla.T�bla, lk_Ellen�rz�s_01d_Illetm�ny_nulla.Hi�nyz�_�rt�k, lk_Ellen�rz�s_01d_Illetm�ny_nulla.Ad�jel AS Ad�azonos�t�, lk_Ellen�rz�s_01d_Illetm�ny_nulla.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
FROM lk_Ellen�rz�s_01d_Illetm�ny_nulla;

-- [lk_Ellen�rz�s_02f_hi�nyz�_besorol�s_megnevez�s]
INSERT INTO t__Ellen�rz�s_02 ( T�bla, Hi�nyz�_�rt�k, Ad�azonos�t�, [�ll�shely azonos�t�], [�NYR SZERVEZETI EGYS�G AZONOS�T�] )
SELECT lk_Ellen�rz�s_01f_hi�nyz�_besorol�s_megnevez�s.T�bla, lk_Ellen�rz�s_01f_hi�nyz�_besorol�s_megnevez�s.Hi�nyz�_�rt�k, lk_Ellen�rz�s_01f_hi�nyz�_besorol�s_megnevez�s.Ad�azonos�t�, lk_Ellen�rz�s_01f_hi�nyz�_besorol�s_megnevez�s.[�ll�shely azonos�t�], lk_Ellen�rz�s_01f_hi�nyz�_besorol�s_megnevez�s.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
FROM lk_Ellen�rz�s_01f_hi�nyz�_besorol�s_megnevez�s;

-- [lk_Ellen�rz�s_02g_MunkahelyC�mHi�nya]
INSERT INTO t__Ellen�rz�s_02 ( T�bla, Ad�azonos�t�, [�ll�shely azonos�t�], [�NYR SZERVEZETI EGYS�G AZONOS�T�], Ad�jel )
SELECT lk_Ellen�rz�s_01g_MunkahelyC�mHi�nya.T�bla, lk_Ellen�rz�s_01g_MunkahelyC�mHi�nya.Ad�azonos�t�, lk_Ellen�rz�s_01g_MunkahelyC�mHi�nya.[�ll�shely azonos�t�], lk_Ellen�rz�s_01g_MunkahelyC�mHi�nya.[�NYR SZERVEZETI EGYS�G AZONOS�T�], lk_Ellen�rz�s_01g_MunkahelyC�mHi�nya.Ad�jel
FROM lk_Ellen�rz�s_01g_MunkahelyC�mHi�nya;

-- [lk_Ellen�rz�s_02h_HivataliEmailHi�nya]
INSERT INTO t__Ellen�rz�s_02 ( T�bla, Hi�nyz�_�rt�k, Ad�azonos�t�, [�ll�shely azonos�t�], [�NYR SZERVEZETI EGYS�G AZONOS�T�], Ad�jel )
SELECT lk_Ellen�rz�s_01h_HivataliEmailHi�nya.T�bla, lk_Ellen�rz�s_01h_HivataliEmailHi�nya.Hi�nyz�_�rt�k, [Ad�jel] & "" AS Ad�azonos�t�, lk_Ellen�rz�s_01h_HivataliEmailHi�nya.[St�tusz k�dja] AS Kif1, lk_Ellen�rz�s_01h_HivataliEmailHi�nya.[�NYR SZERVEZETI EGYS�G AZONOS�T�], lk_Ellen�rz�s_01h_HivataliEmailHi�nya.Ad�jel
FROM lk_Ellen�rz�s_01h_HivataliEmailHi�nya;

-- [lk_Ellen�rz�s_03]
SELECT DISTINCT lkSzem�lyUtols�SzervezetiEgys�ge.F�oszt�ly, lkSzem�lyUtols�SzervezetiEgys�ge.Oszt�ly, kt_azNexon_Ad�jel02.N�v AS N�v, t__Ellen�rz�s_02.Hi�nyz�_�rt�k AS [Hi�nyz� �rt�k], t__Ellen�rz�s_02.[�ll�shely azonos�t�] AS [St�tusz k�d], kt_azNexon_Ad�jel02.NLink AS NLink, tNexonMez�k.Megjegyz�s
FROM lkSzem�lyUtols�SzervezetiEgys�ge RIGHT JOIN (tNexonMez�k RIGHT JOIN ((tJav_mez�k RIGHT JOIN t__Ellen�rz�s_02 ON tJav_mez�k.Eredeti = t__Ellen�rz�s_02.Hi�nyz�_�rt�k) LEFT JOIN kt_azNexon_Ad�jel02 ON t__Ellen�rz�s_02.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel) ON tNexonMez�k.azNexonMez� = tJav_mez�k.azNexonMez�k) ON lkSzem�lyUtols�SzervezetiEgys�ge.Ad�jel = t__Ellen�rz�s_02.Ad�jel
GROUP BY lkSzem�lyUtols�SzervezetiEgys�ge.F�oszt�ly, lkSzem�lyUtols�SzervezetiEgys�ge.Oszt�ly, kt_azNexon_Ad�jel02.N�v, t__Ellen�rz�s_02.Hi�nyz�_�rt�k, t__Ellen�rz�s_02.[�ll�shely azonos�t�], kt_azNexon_Ad�jel02.NLink, tNexonMez�k.Megjegyz�s, t__Ellen�rz�s_02.Ad�jel;

-- [lk_Ellen�rz�s_aHavib�lHi�nyz�k]
SELECT lkSzem�lyek.[St�tusz k�dja], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve]
FROM lkSzem�lyek LEFT JOIN (SELECT Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�] FROM Korm�nyhivatali_�llom�ny UNION SELECT J�r�si_�llom�ny.[�ll�shely azonos�t�] FROM J�r�si_�llom�ny UNION SELECT K�zpontos�tottak.[�ll�shely azonos�t�] FROM K�zpontos�tottak)  AS Havi�ll�shelyAz ON lkSzem�lyek.[St�tusz k�dja] = Havi�ll�shelyAz.[�ll�shely azonos�t�]
WHERE (((lkSzem�lyek.[st�tusz neve])="�ll�shely") AND ((Havi�ll�shelyAz.[�ll�shely azonos�t�]) Is Null))
ORDER BY lkSzem�lyek.BFKH, lkSzem�lyek.[Dolgoz� teljes neve];

-- [lk_Ellen�rz�s_�ll�shelySt�tusza_St�tuszbet�lt�sT�pusa]
SELECT DISTINCT lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, �ll�shelyek.[�ll�shely azonos�t�], �ll�shelyek.[�ll�shely st�tusza], lkSzem�lyek.[Helyettes�tett dolgoz� neve], tSzervezet.[St�tuszbet�lt�s t�pusa]
FROM (�ll�shelyek LEFT JOIN lkSzem�lyek ON �ll�shelyek.[�ll�shely azonos�t�] = lkSzem�lyek.[St�tusz k�dja]) LEFT JOIN tSzervezet ON lkSzem�lyek.[Ad�azonos�t� jel] = tSzervezet.[Szervezetmenedzsment k�d]
WHERE (((�ll�shelyek.[�ll�shely st�tusza]) Like "bet�lt�tt *"));

-- [lk_Ellen�rz�s_FEOR_kira]
SELECT bfkh([lkszem�lyek].[Szervezeti egys�g k�dja]) AS BFKH, lkJogviszonyok.Ad�jel, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.FEOR AS [NEXON FEOR], lkJogviszonyok.FEOR AS [KIRA FEOR], kt_azNexon_Ad�jel02.NLink
FROM (lkJogviszonyok LEFT JOIN lkSzem�lyek ON lkJogviszonyok.Ad�jel=lkSzem�lyek.Ad�jel) LEFT JOIN kt_azNexon_Ad�jel02 ON lkJogviszonyok.Ad�jel=kt_azNexon_Ad�jel02.Ad�jel
WHERE (((lkSzem�lyek.FEOR) Not Like [lkJogviszonyok].[FEOR] & "*"));

-- [lk_Ellen�rz�s_foglalkoztat�s_01]
SELECT lk_Ellen�rz�s_foglalkoztat�s_havi.Ad�jel, lk_Ellen�rz�s_foglalkoztat�s_havi.N�v, lk_Ellen�rz�s_foglalkoztat�s_szem�lyek.F�oszt�ly, lk_Ellen�rz�s_foglalkoztat�s_szem�lyek.Oszt�ly, lk_Ellen�rz�s_foglalkoztat�s_havi.[St�tusz t�pusa], lk_Ellen�rz�s_foglalkoztat�s_havi.Foglalkoztat�s AS A, lk_Ellen�rz�s_foglalkoztat�s_szem�lyek.Foglalkoztat�s AS B, lk_Ellen�rz�s_foglalkoztat�s_havi.[Heti munka�r�k sz�ma] AS C, lk_Ellen�rz�s_foglalkoztat�s_szem�lyek.[Heti �rasz�m] AS D, lk_Ellen�rz�s_foglalkoztat�s_havi.[�NYR SZERVEZETI EGYS�G AZONOS�T�] AS SzervezetAz
FROM lk_Ellen�rz�s_foglalkoztat�s_havi RIGHT JOIN lk_Ellen�rz�s_foglalkoztat�s_szem�lyek ON lk_Ellen�rz�s_foglalkoztat�s_havi.Ad�jel = lk_Ellen�rz�s_foglalkoztat�s_szem�lyek.Ad�jel
WHERE (((lk_Ellen�rz�s_foglalkoztat�s_havi.N�v) Like "kov�cs*") AND ((lk_Ellen�rz�s_foglalkoztat�s_havi.[St�tusz t�pusa])<>""));

-- [lk_Ellen�rz�s_foglalkoztat�s_02a_b]
SELECT lk_Ellen�rz�s_foglalkoztat�s_01.Ad�jel, lk_Ellen�rz�s_foglalkoztat�s_01.N�v, lk_Ellen�rz�s_foglalkoztat�s_01.SzervezetAz, lk_Ellen�rz�s_foglalkoztat�s_01.F�oszt�ly, lk_Ellen�rz�s_foglalkoztat�s_01.Oszt�ly, lk_Ellen�rz�s_foglalkoztat�s_01.[St�tusz t�pusa], IIf([A]=[B],"-","Nexon/Foglalkoz�s/Foglalkoz�si viszony mez� �s a Nexon/Bet�lt�tt st�tuszok/�rasz�m mez�k �rt�kei nincsenek �sszhangban!") AS A_B, lk_Ellen�rz�s_foglalkoztat�s_01.A, lk_Ellen�rz�s_foglalkoztat�s_01.B, lk_Ellen�rz�s_foglalkoztat�s_01.C, lk_Ellen�rz�s_foglalkoztat�s_01.D
FROM lk_Ellen�rz�s_foglalkoztat�s_01
WHERE (((IIf([A]=[B],"-","Nexon/Foglalkoz�s/Foglalkoz�si viszony mez� �s a Nexon/Bet�lt�tt st�tuszok/�rasz�m mez�k �rt�kei nincsenek �sszhangban!"))<>"-"));

-- [lk_Ellen�rz�s_foglalkoztat�s_02c_a]
SELECT lk_Ellen�rz�s_foglalkoztat�s_01.Ad�jel, lk_Ellen�rz�s_foglalkoztat�s_01.N�v, lk_Ellen�rz�s_foglalkoztat�s_01.SzervezetAz, lk_Ellen�rz�s_foglalkoztat�s_01.F�oszt�ly, lk_Ellen�rz�s_foglalkoztat�s_01.Oszt�ly, lk_Ellen�rz�s_foglalkoztat�s_01.[St�tusz t�pusa], IIf(IIf([C]=40,"T","R")=[A],"-","A Nexon/Foglalkoz�si/Foglalkoz�si viszony �s a Szerz�d�sek/SZERZ�D�S/KINEVEZ�S VERZI� ADATOK SZERKESZT�SE\Elm�leti ledolgozand� napi �rakeret  mez�k �rt�kei nincsenek �sszhangban!") AS C_D, lk_Ellen�rz�s_foglalkoztat�s_01.A, lk_Ellen�rz�s_foglalkoztat�s_01.B, lk_Ellen�rz�s_foglalkoztat�s_01.C, lk_Ellen�rz�s_foglalkoztat�s_01.D
FROM lk_Ellen�rz�s_foglalkoztat�s_01
WHERE (((lk_Ellen�rz�s_foglalkoztat�s_01.[St�tusz t�pusa]) Not Like "K�zpon*") AND ((IIf(IIf([C]=40,"T","R")=[A],"-","A Nexon/Foglalkoz�si/Foglalkoz�si viszony �s a Szerz�d�sek/SZERZ�D�S/KINEVEZ�S VERZI� ADATOK SZERKESZT�SE\Elm�leti ledolgozand� napi �rakeret  mez�k �rt�kei nincsenek �sszhangban!"))<>"-"));

-- [lk_Ellen�rz�s_foglalkoztat�s_02d_c]
SELECT lk_Ellen�rz�s_foglalkoztat�s_01.Ad�jel, lk_Ellen�rz�s_foglalkoztat�s_01.N�v, lk_Ellen�rz�s_foglalkoztat�s_01.SzervezetAz, lk_Ellen�rz�s_foglalkoztat�s_01.F�oszt�ly, lk_Ellen�rz�s_foglalkoztat�s_01.Oszt�ly, lk_Ellen�rz�s_foglalkoztat�s_01.[St�tusz t�pusa], IIf([C]=[D],"-","Szerz�d�sek/SZERZ�D�S/KINEVEZ�S VERZI� ADATOK SZERKESZT�SE\Elm�leti ledolgozand� napi �rakeret �s a  Nexon/Bet�lt�tt st�tuszok/�rasz�m mez�k �rt�kei nincsenek �sszhangban!") AS C_D, lk_Ellen�rz�s_foglalkoztat�s_01.A, lk_Ellen�rz�s_foglalkoztat�s_01.B, lk_Ellen�rz�s_foglalkoztat�s_01.C, lk_Ellen�rz�s_foglalkoztat�s_01.D
FROM lk_Ellen�rz�s_foglalkoztat�s_01
WHERE (((lk_Ellen�rz�s_foglalkoztat�s_01.[St�tusz t�pusa]) Not Like "K�zpon*") AND ((IIf([C]=[D],"-","Szerz�d�sek/SZERZ�D�S/KINEVEZ�S VERZI� ADATOK SZERKESZT�SE\Elm�leti ledolgozand� napi �rakeret �s a  Nexon/Bet�lt�tt st�tuszok/�rasz�m mez�k �rt�kei nincsenek �sszhangban!"))<>"-"));

-- [lk_Ellen�rz�s_foglalkoztat�s_03]
SELECT Ellen�rz�s.F�oszt�ly, Ellen�rz�s.Oszt�ly, Ellen�rz�s.A_B AS [Hiba le�r�sa], Ellen�rz�s.Ad�jel, Ellen�rz�s.N�v, "" AS [�ll�shely azonos�t�], kt_azNexon_Ad�jel.NLINK AS Link, "" AS Megjegyz�s
FROM kt_azNexon_Ad�jel RIGHT JOIN (SELECT * FROM lk_Ellen�rz�s_foglalkoztat�s_02a_b  UNION ALL SELECT * FROM lk_Ellen�rz�s_foglalkoztat�s_02c_a  UNION ALL  SELECT * FROM lk_Ellen�rz�s_foglalkoztat�s_02d_c )  AS Ellen�rz�s ON kt_azNexon_Ad�jel.Ad�jel = Ellen�rz�s.Ad�jel
ORDER BY Ellen�rz�s.F�oszt�ly;

-- [lk_Ellen�rz�s_foglalkoztat�s_emailc�mek]
SELECT DISTINCT lk_Ellen�rz�s_foglalkoztat�s_03.TO AS Kif1
FROM lk_Ellen�rz�s_foglalkoztat�s_03;

-- [lk_Ellen�rz�s_foglalkoztat�s_havi]
SELECT Uni�.Ad�jel, Uni�.N�v, Uni�.[J�r�si Hivatal] AS F�oszt�ly, Uni�.Mez�7 AS Oszt�ly, Uni�.Foglalkoztat�s, Uni�.[Heti munka�r�k sz�ma], Uni�.[St�tusz t�pusa], Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�], Uni�.Mez�4 AS [Sz�let�si �v], [Mez�10] AS Bel�p�s, *
FROM (SELECT J�r�si_�llom�ny.Ad�azonos�t� * 1 AS Ad�jel, J�r�si_�llom�ny.N�v, J�r�si_�llom�ny.[J�r�si Hivatal], J�r�si_�llom�ny.Mez�7, right(J�r�si_�llom�ny.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ],1) AS Foglalkoztat�s, J�r�si_�llom�ny.[Heti munka�r�k sz�ma], "Szervezeti alapl�tsz�m" As [St�tusz t�pusa], [�NYR SZERVEZETI EGYS�G AZONOS�T�], Mez�4, mez�10
FROM J�r�si_�llom�ny
WHERE J�r�si_�llom�ny.Ad�azonos�t�  <>""
UNION
SELECT Korm�nyhivatali_�llom�ny.Ad�azonos�t� * 1 AS Ad�jel, Korm�nyhivatali_�llom�ny.N�v, Korm�nyhivatali_�llom�ny.Mez�6, Korm�nyhivatali_�llom�ny.Mez�7, right(Korm�nyhivatali_�llom�ny.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ],1),Korm�nyhivatali_�llom�ny.[Heti munka�r�k sz�ma], "Szervezeti alapl�tsz�m" As [St�tusz t�pusa], [�NYR SZERVEZETI EGYS�G AZONOS�T�], Mez�4, Mez�10
FROM  Korm�nyhivatali_�llom�ny
WHERE Korm�nyhivatali_�llom�ny.Ad�azonos�t�  <>""
UNION SELECT K�zpontos�tottak.Ad�azonos�t� * 1 AS Ad�jel, K�zpontos�tottak.N�v, K�zpontos�tottak.Mez�6, K�zpontos�tottak.Mez�7, right(K�zpontos�tottak.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ],1), 0 As [Heti munka�r�k sz�ma],"K�zpontos�tott �llom�ny" As [St�tusz t�pusa], [Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�], Mez�4, Mez�11
FROM   K�zpontos�tottak
WHERE  K�zpontos�tottak.Ad�azonos�t� <>"")  AS Uni�;

-- [lk_Ellen�rz�s_foglalkoztat�s_szem�lyek]
SELECT lkSzem�lyek.Ad�jel, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker] AS [Heti �rasz�m], IIf([Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]=40,"T","R") AS Foglalkoztat�s, lkSzem�lyek.[St�tusz t�pusa], lkSzem�lyek.[Szervezeti egys�g k�dja]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz t�pusa]) Is Not Null) AND ((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null))
ORDER BY lkSzem�lyek.[Dolgoz� teljes neve];

-- [lk_Ellen�rz�s_hat�rozottak]
SELECT lkSzervezetSzem�lyek.[St�tuszbet�lt�s t�pusa], lkSzem�lyek.[Szerz�d�s/Kinevez�s t�pusa], lkSzervezetSzem�lyek.[�rv�nyess�g kezdete], lkSzervezetSzem�lyek.[�rv�nyess�g v�ge], lkSzem�lyek.[Dolgoz� teljes neve], lkSzervezetSzem�lyek.[St�tusz�nak k�dja], lkSzem�lyek.[St�tusz k�dja], lkSzem�lyek.[Helyettes�tett dolgoz� neve], lkSzem�lyek.[St�tusz neve], lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)], lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)]
FROM lkSzervezetSzem�lyek LEFT JOIN lkSzem�lyek ON lkSzervezetSzem�lyek.Ad�jel=lkSzem�lyek.Ad�jel
WHERE (((lkSzervezetSzem�lyek.[St�tuszbet�lt�s t�pusa])="Helyettes") AND ((lkSzervezetSzem�lyek.[�rv�nyess�g kezdete])<=Date()) AND ((lkSzervezetSzem�lyek.[�rv�nyess�g v�ge])>=Date() Or (lkSzervezetSzem�lyek.[�rv�nyess�g v�ge]) Is Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkSzervezetSzem�lyek.[St�tuszbet�lt�s t�pusa])="�ltal�nos") AND ((lkSzem�lyek.[Szerz�d�s/Kinevez�s t�pusa])="hat�rozott") AND ((lkSzervezetSzem�lyek.[�rv�nyess�g kezdete])<=Date()) AND ((lkSzervezetSzem�lyek.[�rv�nyess�g v�ge])>=Date() Or (lkSzervezetSzem�lyek.[�rv�nyess�g v�ge]) Is Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [lk_Ellen�rz�s_Hi�nyz��ll�shelyek]
SELECT �ll�shelyek.[�ll�shely azonos�t�], �ll�shelyek.[�ll�shely besorol�si kateg�ri�ja], �ll�shelyek.[�ll�shely t�pusa]
FROM lk�ll�shelyAzonos�t�kHavib�l LEFT JOIN �ll�shelyek ON lk�ll�shelyAzonos�t�kHavib�l.�ll�shely = �ll�shelyek.[�ll�shely azonos�t�]
WHERE (((�ll�shelyek.[�ll�shely azonos�t�]) Is Null));

-- [lk_Ellen�rz�s_hozz�tartoz�_hi�ny01]
SELECT Nz([lkHozz�tartoz�k].[Szervezeti egys�g k�dja],[�NYR SZERVEZETI EGYS�G AZONOS�T�]) AS SzervezetK�d, lkHozz�tartoz�k.[Dolgoz� neve], lkHozz�tartoz�k.Ad�jel AS [Dolgoz� ad�azonos�t� jele], lkHozz�tartoz�k.[Hozz�tartoz� neve], lkHozz�tartoz�k.[Hozz�tartoz� ad�azonos�t� jele], lkHozz�tartoz�k.[Sz�let�si hely], Trim([Anyja csal�di neve] & " " & [Anyja ut�neve]) AS [Anyja neve], lkHozz�tartoz�k.[Sz�let�si id�], Trim(Replace(Nz([lkHozz�tartoz�k].[�lland� lakc�m],""),"Magyarorsz�g","")) AS Gyermek�lland�, Trim(Replace(Nz([lkHozz�tartoz�k].[Tart�zkod�si lakc�m],""),"Magyarorsz�g","")) AS GyermekTart�zkod�si, Replace(Nz([lkSzem�lyek].[�lland� lakc�m],""),"Magyarorsz�g, ","") AS Sz�l��lland�, Replace(Nz([lkszem�lyek].[Tart�zkod�si lakc�m],""),"Magyarorsz�g, ","") AS Sz�l�Tart�zkod�si, lkKil�p�k.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja], lkHozz�tartoz�k.[Hozz�tartoz� TAJ sz�ma]
FROM (lkHozz�tartoz�k LEFT JOIN lkSzem�lyek ON lkHozz�tartoz�k.Ad�jel = lkSzem�lyek.Ad�jel) LEFT JOIN lkKil�p�k ON lkHozz�tartoz�k.Ad�jel = lkKil�p�k.Ad�jel
WHERE (((lkHozz�tartoz�k.[Hozz�tartoz� neve]) Not Like "*elhalt*" And (lkHozz�tartoz�k.[Hozz�tartoz� neve]) Not Like "*elhunyt*") AND ((lkHozz�tartoz�k.[Sz�let�si id�])>DateSerial(Year(Date())-18,1,1)) AND ((lkKil�p�k.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])>DateSerial(Year(Date()),1,1) Or (lkKil�p�k.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]) Is Null) AND ((lkHozz�tartoz�k.[Otthoni e-mail c�m]) Not Like "elhunyt*") AND ((Nz([tHozz�tartoz�k].[Szervezeti egys�g k�dja],[�NYR SZERVEZETI EGYS�G AZONOS�T�])) Is Not Null) AND ((lkSzem�lyek.[St�tusz t�pusa]) Like "K�zpontos�tott �llom�ny" Or (lkSzem�lyek.[St�tusz t�pusa]) Like "Szervezeti*") AND ((lkHozz�tartoz�k.[Kapcsolat jellege])="Gyermek") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkHozz�tartoz�k.[Hozz�tartoz� neve]) Not Like "*elhalt*" And (lkHozz�tartoz�k.[Hozz�tartoz� neve]) Not Like "*elhunyt*") AND ((lkHozz�tartoz�k.[Sz�let�si id�])>DateSerial(Year(Date())-18,1,1)) AND ((lkKil�p�k.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])>DateSerial(Year(Date()),1,1) Or (lkKil�p�k.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]) Is Null) AND ((lkHozz�tartoz�k.[Otthoni e-mail c�m]) Is Null) AND ((Nz([tHozz�tartoz�k].[Szervezeti egys�g k�dja],[�NYR SZERVEZETI EGYS�G AZONOS�T�])) Is Not Null) AND ((lkSzem�lyek.[St�tusz t�pusa]) Like "K�zpontos�tott �llom�ny" Or (lkSzem�lyek.[St�tusz t�pusa]) Like "Szervezeti*") AND ((lkHozz�tartoz�k.[Kapcsolat jellege])="Gyermek") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkHozz�tartoz�k.[Hozz�tartoz� neve]) Not Like "*elhalt*" And (lkHozz�tartoz�k.[Hozz�tartoz� neve]) Not Like "*elhunyt*") AND ((lkHozz�tartoz�k.[Sz�let�si id�])>DateSerial(Year(Date())-18,1,1)) AND ((lkKil�p�k.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])>DateSerial(Year(Date()),1,1) Or (lkKil�p�k.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]) Is Null) AND ((lkHozz�tartoz�k.[Otthoni e-mail c�m]) Not Like "elhunyt*") AND ((Nz([tHozz�tartoz�k].[Szervezeti egys�g k�dja],[�NYR SZERVEZETI EGYS�G AZONOS�T�])) Is Not Null) AND ((lkSzem�lyek.[St�tusz t�pusa]) Is Null) AND ((lkHozz�tartoz�k.[Kapcsolat jellege])="Gyermek") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkHozz�tartoz�k.[Hozz�tartoz� neve]) Not Like "*elhalt*" And (lkHozz�tartoz�k.[Hozz�tartoz� neve]) Not Like "*elhunyt*") AND ((lkHozz�tartoz�k.[Sz�let�si id�])>DateSerial(Year(Date())-18,1,1)) AND ((lkKil�p�k.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])>DateSerial(Year(Date()),1,1) Or (lkKil�p�k.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]) Is Null) AND ((lkHozz�tartoz�k.[Otthoni e-mail c�m]) Is Null) AND ((Nz([tHozz�tartoz�k].[Szervezeti egys�g k�dja],[�NYR SZERVEZETI EGYS�G AZONOS�T�])) Is Not Null) AND ((lkSzem�lyek.[St�tusz t�pusa]) Is Null) AND ((lkHozz�tartoz�k.[Kapcsolat jellege])="Gyermek") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkHozz�tartoz�k.[Sz�let�si id�];

-- [lk_Ellen�rz�s_hozz�tartoz�_hi�ny02]
SELECT lk_F�oszt�ly_Oszt�ly_lkSzem�lyek.F�oszt�ly AS F�oszt�ly, lk_F�oszt�ly_Oszt�ly_lkSzem�lyek.Oszt�ly AS Oszt�ly, Uni�.[Dolgoz� neve] AS N�v, Uni�.[Hozz�tartoz� neve] AS [A hozz�tartoz� neve], Uni�.[Sz�let�si id�] AS [A sz�let�s ideje], Uni�.Hi�nyz�Adat AS [A hi�nyz� adat], kt_azNexon_Ad�jel02.NLink AS NLink
FROM kt_azNexon_Ad�jel02 RIGHT JOIN (lk_F�oszt�ly_Oszt�ly_lkSzem�lyek RIGHT JOIN (SELECT lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[SzervezetK�d], lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Dolgoz� neve] ,          lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Dolgoz� ad�azonos�t� jele]*1 as Ad�jel ,          tHozz�tartoz�k.[Hozz�tartoz� neve] ,          tHozz�tartoz�k.[Sz�let�si id�] ,         "Hozz�tartoz� neve" as Hi�nyz�Adat                FROM lk_Ellen�rz�s_hozz�tartoz�_hi�ny01                WHERE lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Hozz�tartoz� neve] is null       UNION       SELECT lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[SzervezetK�d] ,          lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Dolgoz� neve] ,          lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Dolgoz� ad�azonos�t� jele] ,          tHozz�tartoz�k.[Hozz�tartoz� neve] ,          tHozz�tartoz�k.[Sz�let�si id�] ,         "Hozz�tartoz� ad�azonos�t� jele" as Hi�nyz�Adat              FROM lk_Ellen�rz�s_hozz�tartoz�_hi�ny01                  WHERE lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Hozz�tartoz� ad�azonos�t� jele] is null       UNION       SELECT lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[SzervezetK�d] ,          lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Dolgoz� neve] ,          lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Dolgoz� ad�azonos�t� jele]*1 as Ad�jel ,          tHozz�tartoz�k.[Hozz�tartoz� neve] ,          tHozz�tartoz�k.[Sz�let�si id�] ,          "Sz�let�si hely" as Hi�nyz�Adat                 FROM lk_Ellen�rz�s_hozz�tartoz�_hi�ny01                  WHERE lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Sz�let�si hely] is null        UNION       SELECT lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[SzervezetK�d] ,          lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Dolgoz� neve] ,          lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Dolgoz� ad�azonos�t� jele]*1 as Ad�jel ,          tHozz�tartoz�k.[Hozz�tartoz� neve] ,          tHozz�tartoz�k.[Sz�let�si id�] ,          "Anyja neve" as Hi�nyz�Adat                 FROM lk_Ellen�rz�s_hozz�tartoz�_hi�ny01                  WHERE lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Anyja neve] is null  OR trim(lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Anyja neve])=""       UNION       SELECT lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[SzervezetK�d] ,          lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Dolgoz� neve] ,          lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Dolgoz� ad�azonos�t� jele]*1 as Ad�jel ,          tHozz�tartoz�k.[Hozz�tartoz� neve] ,          tHozz�tartoz�k.[Sz�let�si id�] ,          "Sz�let�si id�" as Hi�nyz�Adat                 FROM lk_Ellen�rz�s_hozz�tartoz�_hi�ny01                 WHERE lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Sz�let�si id�] is null       UNION       SELECT lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[SzervezetK�d] ,           lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Dolgoz� neve] ,           lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Dolgoz� ad�azonos�t� jele]*1 as Ad�jel ,           lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Hozz�tartoz� neve] ,           tHozz�tartoz�k.[Sz�let�si id�] ,           "Hozz�tartoz� �lland� lakc�me" AS [Hi�nyz� adat]                  FROM lk_Ellen�rz�s_hozz�tartoz�_hi�ny01                  WHERE lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Gyermek�lland�] Is Null Or lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Gyermek�lland�]=""       UNION       SELECT lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[SzervezetK�d] ,           lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Dolgoz� neve] ,           lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Dolgoz� ad�azonos�t� jele]*1 as Ad�jel ,           lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Hozz�tartoz� neve] ,           tHozz�tartoz�k.[Sz�let�si id�] ,           "Hozz�tartoz� TAJ" AS [Hi�nyz� adat]                  FROM lk_Ellen�rz�s_hozz�tartoz�_hi�ny01                  WHERE lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Hozz�tartoz� TAJ sz�ma] Is Null Or lk_Ellen�rz�s_hozz�tartoz�_hi�ny01.[Hozz�tartoz� TAJ sz�ma]=""        )  AS Uni� ON lk_F�oszt�ly_Oszt�ly_lkSzem�lyek.[Szervezeti egys�g k�dja] = Uni�.SzervezetK�d) ON kt_azNexon_Ad�jel02.Ad�jel = Uni�.Ad�jel;

-- [lk_Ellen�rz�s_kirahib�k01]
SELECT lkSzem�lyek.BFKH, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkKiraHiba.Ad�jel, lkKiraHiba.N�v, lkKiraHiba.Hiba, tKiraHiba�zenetek.Magyar�zat
FROM (lkKiraHiba INNER JOIN lkSzem�lyek ON lkKiraHiba.Ad�jel = lkSzem�lyek.Ad�jel) LEFT JOIN tKiraHiba�zenetek ON lkKiraHiba.Hiba = tKiraHiba�zenetek.Hiba�zenet
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.BFKH, lkKiraHiba.N�v;

-- [lk_Ellen�rz�s_kirahib�k02]
SELECT lk_Ellen�rz�s_kirahib�k01.BFKH, lk_Ellen�rz�s_kirahib�k01.F�oszt�ly, lk_Ellen�rz�s_kirahib�k01.Oszt�ly, lk_Ellen�rz�s_kirahib�k01.Ad�jel, lk_Ellen�rz�s_kirahib�k01.N�v, lk_Ellen�rz�s_kirahib�k01.Hiba, lk_Ellen�rz�s_kirahib�k01.Magyar�zat, kt_azNexon_Ad�jel02.NLink
FROM kt_azNexon_Ad�jel02 RIGHT JOIN lk_Ellen�rz�s_kirahib�k01 ON kt_azNexon_Ad�jel02.Ad�jel = lk_Ellen�rz�s_kirahib�k01.Ad�jel;

-- [lk_Ellen�rz�s_munkak�r_kira01]
SELECT bfkh(Nz([lkszem�lyek].[Szervezeti egys�g k�dja],"")) AS BFKH, IIf(Nz([F�oszt�ly],"")="","_Kil�pett",[F�oszt�ly]) AS F�oszt, lkSzem�lyek.Oszt�ly, lkSzem�lyek.Ad�jel, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Dolgoz� szerz�d�ses/kinevez�ses munkak�re / kinevez�si okm�nyban] AS [Nexon munkak�r], lkJogviszonyok.[Munkak�r megnevez�se] AS [Kira munkak�r], kt_azNexon_Ad�jel02.NLink
FROM lkJogviszonyok RIGHT JOIN (kt_azNexon_Ad�jel02 RIGHT JOIN lkSzem�lyek ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel) ON lkJogviszonyok.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely" Or (lkSzem�lyek.[St�tusz neve]) Is Null) AND ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])="Munkaviszony"))
ORDER BY bfkh(Nz([lkszem�lyek].[Szervezeti egys�g k�dja],"")), IIf(Nz([F�oszt�ly],"")="","_Kil�pett",[F�oszt�ly]), lkSzem�lyek.[Dolgoz� teljes neve];

-- [lk_Ellen�rz�s_sz�let�sihely_kira_Statisztika]
SELECT �sszes�tett.F�oszt, �sszes�tett.[Hib�k sz�ma], �sszes�tett.�sszl�tsz�m, [Hib�k sz�ma]/[�sszl�tsz�m] AS Ar�ny
FROM (SELECT Uni�.F�oszt, Sum(Uni�.Hib�s) AS [Hib�k sz�ma], Sum(Uni�.L�tsz�m) AS �sszl�tsz�m
FROM (SELECT lk_Ellen�rz�s_sz�let�sihely_kira02.F�oszt, Count(lk_Ellen�rz�s_sz�let�sihely_kira02.Ad�jel) AS Hib�s, 0 AS L�tsz�m
FROM lk_Ellen�rz�s_sz�let�sihely_kira02
GROUP BY lk_Ellen�rz�s_sz�let�sihely_kira02.F�oszt, 0
UNION
SELECT lkSzem�lyek.F�oszt�ly, 0 AS Hib�s, Count(lkSzem�lyek.Ad�jel) AS CountOfAd�jel
FROM lkSzem�lyek
GROUP BY lkSzem�lyek.F�oszt�ly, 0, lkSzem�lyek.[St�tusz neve]
HAVING (((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
)  AS Uni�
GROUP BY Uni�.F�oszt
)  AS �sszes�tett
GROUP BY �sszes�tett.F�oszt, �sszes�tett.[Hib�k sz�ma], �sszes�tett.�sszl�tsz�m, [Hib�k sz�ma]/[�sszl�tsz�m];

-- [lk_Ellen�rz�s_sz�let�sihely_kira01]
SELECT bfkh(Nz([Szervezeti egys�g k�dja],0)) AS bfkh, IIf(Nz([F�oszt�ly],"")="","_Kil�pett",[F�oszt�ly]) AS F�oszt, lkSzem�lyek.Oszt�ly, lkSzem�lyek.Ad�jel, lkSzem�lyek.[Dolgoz� teljes neve], Switch(Nz([Sz�let�si hely],"") Not Like "Budapest ##*","A sz�let�si hely nem a KIRA szabv�nyos c�m, azaz: 'Budapest' + sz�k�z + k�t sz�mjegy a ker�letnek :(",Len(Nz([Sz�let�si hely],""))<2,"Sz�let�si hely hi�nyzik") AS Hiba, Nz([Sz�let�si hely],"") AS [Sz�let�s helye], "Budapest " & Right("0" & num2num(Replace(Replace(Trim(Replace([Sz�let�si hely],"Budapest","")),"ker",""),".",""),99,10),2) AS Javasolt, kt_azNexon_Ad�jel02.NLink
FROM lkSzem�lyek LEFT JOIN kt_azNexon_Ad�jel02 ON lkSzem�lyek.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel
WHERE (((Nz([Sz�let�si hely],"")) Not Like "Budapest ##*") AND ((lkSzem�lyek.[Sz�let�si hely]) Like "*Budapest*") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY bfkh(Nz([Szervezeti egys�g k�dja],0)), IIf(Nz([F�oszt�ly],"")="","_Kil�pett",[F�oszt�ly]), lkSzem�lyek.[Dolgoz� teljes neve];

-- [lk_Ellen�rz�s_sz�let�sihely_kira01_hi�ny]
SELECT bfkh(Nz([Szervezeti egys�g k�dja],0)) AS bfkh, IIf(Nz([F�oszt�ly],"")="","_Kil�pett",[F�oszt�ly]) AS F�oszt, lkSzem�lyek.Oszt�ly, lkSzem�lyek.Ad�jel, lkSzem�lyek.[Dolgoz� teljes neve], "A sz�let�si hely nincs kit�ltve" AS Hiba, "" AS [Sz�let�si helye], "" AS Javasolt, kt_azNexon_Ad�jel02.NLink
FROM lkSzem�lyek LEFT JOIN kt_azNexon_Ad�jel02 ON lkSzem�lyek.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((Len(Nz([Sz�let�si hely],"")))<2))
ORDER BY bfkh(Nz([Szervezeti egys�g k�dja],0)), IIf(Nz([F�oszt�ly],"")="","_Kil�pett",[F�oszt�ly]), lkSzem�lyek.[Dolgoz� teljes neve];

-- [lk_Ellen�rz�s_sz�let�sihely_kira02]
SELECT BudapestRomaiEsHiany.F�oszt�ly, BudapestRomaiEsHiany.Oszt�ly, BudapestRomaiEsHiany.N�v, BudapestRomaiEsHiany.Hiba, BudapestRomaiEsHiany.[Sz�let�si hely], BudapestRomaiEsHiany.Javaslat, BudapestRomaiEsHiany.NLink
FROM (SELECT
  lk_Ellen�rz�s_sz�let�sihely_kira01.bfkh
, lk_Ellen�rz�s_sz�let�sihely_kira01.F�oszt AS F�oszt�ly
, lk_Ellen�rz�s_sz�let�sihely_kira01.Oszt�ly AS Oszt�ly
, lk_Ellen�rz�s_sz�let�sihely_kira01.[Dolgoz� teljes neve] AS N�v
, lk_Ellen�rz�s_sz�let�sihely_kira01.Hiba
, lk_Ellen�rz�s_sz�let�sihely_kira01.[Sz�let�s helye] AS [Sz�let�si hely]
, IIf([Javasolt] Like "*00*","-- nincs javaslat --",[Javasolt]) AS Javaslat
, lk_Ellen�rz�s_sz�let�sihely_kira01.NLink AS NLink 
FROM lk_Ellen�rz�s_sz�let�sihely_kira01
UNION
SELECT
  lk_Ellen�rz�s_sz�let�sihely_kira01_hi�ny.bfkh
, lk_Ellen�rz�s_sz�let�sihely_kira01_hi�ny.F�oszt
, lk_Ellen�rz�s_sz�let�sihely_kira01_hi�ny.Oszt�ly
, lk_Ellen�rz�s_sz�let�sihely_kira01_hi�ny.[Dolgoz� teljes neve] as N�v
, lk_Ellen�rz�s_sz�let�sihely_kira01_hi�ny.Hiba
, lk_Ellen�rz�s_sz�let�sihely_kira01_hi�ny.[Sz�let�si helye]
, "-- nincs javaslat --" as Javaslat
, lk_Ellen�rz�s_sz�let�sihely_kira01_hi�ny.NLink
FROM lk_Ellen�rz�s_sz�let�sihely_kira01_hi�ny
)  AS BudapestRomaiEsHiany
ORDER BY BudapestRomaiEsHiany.bfkh, BudapestRomaiEsHiany.Oszt�ly, BudapestRomaiEsHiany.N�v;

-- [lk_Fesz_03]
SELECT Uni�01b_02.Azonos�t�, Uni�01b_02.F�oszt�ly, Uni�01b_02.Oszt�ly, Uni�01b_02.N�v, Uni�01b_02.TAJ, Uni�01b_02.Sz�l, Uni�01b_02.E�Oszt�ly, Uni�01b_02.[FEOR megnevez�s], Uni�01b_02.[Alk tipus], Uni�01b_02.AD�tum, Uni�01b_02.�rv�ny, Uni�01b_02.Korl�toz�s, Uni�01b_02.[Orvosi vizsg�lat id�pontja], Uni�01b_02.[Orvosi vizsg�lat t�pusa], Uni�01b_02.[Orvosi vizsg�lat eredm�nye], Uni�01b_02.[Orvosi vizsg�lat �szrev�telek], Uni�01b_02.[Orvosi vizsg�lat k�vetkez� id�pontja]
FROM (SELECT DISTINCT lkFesz_01b.*
FROM  lkFesz_01b
UNION
SELECT lkFesz_02.*
FROM lkFesz_02)  AS Uni�01b_02;

-- [lk_F�oszt�ly_Oszt�ly]
SELECT DISTINCT lkSzem�lyek.[Szervezeti egys�g k�dja] AS BFKH, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly
FROM lkSzem�lyek;

-- [lk_F�oszt�ly_Oszt�ly_lkSzem�lyek]
SELECT DISTINCT lkSzem�lyek.BFKH, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, IIf(Nz([Oszt�ly],"")="",0,IIf(utols�([BFKH],".")="",0,utols�([BFKH],"."))*1)+1 AS Sorsz�m, lkSzem�lyek.[Szervezeti egys�g k�dja]
FROM lkSzem�lyek;

-- [lk_F�oszt�ly_Oszt�ly_tSzervezet]
SELECT bfkh(Nz([tSzervezet].[Szervezetmenedzsment k�d],"")) AS bfkhk�d, tSzervezet.[Szervezetmenedzsment k�d], IIf(Nz([tSzervezet].[Szint],1)>6,Nz([tSzervezet_1].[N�v],""),Nz([tSzervezet].[N�v],"")) AS F�oszt�ly, IIf([tSzervezet].[Szint]>6,[tSzervezet].[N�v],"") AS Oszt�ly, Replace(IIf([tSzervezet].[Szint]>6,[tSzervezet_1].[N�v],[tSzervezet].[N�v]),"Budapest F�v�ros Korm�nyhivatala","BFKH") AS F�oszt
FROM tSzervezet AS tSzervezet_1 RIGHT JOIN tSzervezet ON tSzervezet_1.[Szervezetmenedzsment k�d] = tSzervezet.[Sz�l� szervezeti egys�g�nek k�dja]
WHERE (((tSzervezet.OSZLOPOK)="szervezeti egys�g"))
ORDER BY bfkh(Nz([tSzervezet].[Szervezetmenedzsment k�d],""));

-- [lk_F�oszt�lyonk�nti_�tlagilletm�ny01]
SELECT bfkh([F�oszt�lyK�d]) AS FK, lkSzem�lyek.F�oszt�ly, Avg([Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40) AS Illetm�ny
FROM lkSzem�lyek
GROUP BY bfkh([F�oszt�lyK�d]), lkSzem�lyek.F�oszt�ly, lkSzem�lyek.[St�tusz neve]
HAVING (((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [lk_F�oszt�lyonk�nti_�tlagilletm�ny01_vezet�kn�lk�l]
SELECT bfkh([F�oszt�lyK�d]) AS FK, lkSzem�lyek.F�oszt�ly, Avg([Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40) AS Illetm�ny
FROM tBesorol�s_�talak�t� INNER JOIN lkSzem�lyek ON tBesorol�s_�talak�t�.Besorol�si_fokozat = lkSzem�lyek.[Besorol�si  fokozat (KT)]
WHERE (((tBesorol�s_�talak�t�.Vezet�)=No))
GROUP BY bfkh([F�oszt�lyK�d]), lkSzem�lyek.F�oszt�ly, lkSzem�lyek.[St�tusz neve]
HAVING (((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [lk_F�oszt�lyonk�nti_�tlagilletm�ny02]
SELECT lk_F�oszt�lyonk�nti_�tlagilletm�ny01.F�oszt�ly AS F�oszt�ly, Round([Illetm�ny]/100,0)*100 AS �tlagilletm�ny
FROM lk_F�oszt�lyonk�nti_�tlagilletm�ny01
ORDER BY lk_F�oszt�lyonk�nti_�tlagilletm�ny01.[FK];

-- [lk_F�oszt�lyonk�nti_�tlagilletm�ny02_vezet�kn�lk�l]
SELECT lk_F�oszt�lyonk�nti_�tlagilletm�ny01_vezet�kn�lk�l.F�oszt�ly AS F�oszt�ly, Round([Illetm�ny]/100,0)*100 AS �tlagilletm�ny
FROM lk_F�oszt�lyonk�nti_�tlagilletm�ny01_vezet�kn�lk�l
ORDER BY lk_F�oszt�lyonk�nti_�tlagilletm�ny01_vezet�kn�lk�l.FK;

-- [lk_Garant�lt_b�rminimum_alatti_02]
SELECT lkSzem�lyek.Ad�jel, lkSzem�lyek.[Kerek�tett 100 %-os illetm�ny (elt�r�tett)] AS Illetm�ny, lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker] AS [Heti munka�r�k sz�ma], lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], Nz([Kerek�tett 100 %-os illetm�ny (elt�r�tett)],0)/IIf(Nz([Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker],0)=0,0.00001,[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker])*40 AS Brutt�_b�r, IIf(Nz([Kerek�tett 100 %-os illetm�ny (elt�r�tett)],0)/IIf(Nz([Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker],0)=0,0.00001,[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker])*40<(Select Min(Tulajdons�g�rt�k) From tAlapadatok Where Tulajdons�gNeve="garant�lt b�rminimum")*1,Yes,No) AS Garant�lt_min_alatt
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [lk_Garant�lt_b�rminimum_alatti_�llom�nyt�bl�b�l]
SELECT [Ad�azonos�t�]*1 AS Ad�jel, lk_�llom�nyt�bl�kb�l_Illetm�nyek.Illetm�ny, lk_�llom�nyt�bl�kb�l_Illetm�nyek.[Heti munka�r�k sz�ma], lk_�llom�nyt�bl�kb�l_Illetm�nyek.[�ll�shely azonos�t�], [Illetm�ny]/IIf(Nz([Heti munka�r�k sz�ma],0)=0,0.00001,[Heti munka�r�k sz�ma])*40 AS Brutt�_b�r, IIf([Illetm�ny]/IIf(Nz([Heti munka�r�k sz�ma],0)=0,0.00001,[Heti munka�r�k sz�ma])*40<(Select Min(Tulajdons�g�rt�k) From tAlapadatok Where Tulajdons�gNeve="garant�lt b�rminimum")*1,Yes,No) AS Garant�lt_min_alatt
FROM lk_�llom�nyt�bl�kb�l_Illetm�nyek
WHERE (((IIf([Illetm�ny]/IIf(Nz([Heti munka�r�k sz�ma],0)=0,0.00001,[Heti munka�r�k sz�ma])*40<(Select Min(Tulajdons�g�rt�k) From tAlapadatok Where Tulajdons�gNeve="garant�lt b�rminimum")*1,Yes,No))=Yes));

-- [lk_Garant�lt_b�rminimum_Illetm�nyek]
SELECT lkSzem�lyek.F�oszt�ly AS F�oszt�ly, lkSzem�lyek.Oszt�ly AS Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lk_Garant�lt_b�rminimum_alatti_02.[�ll�shely azonos�t�] AS [St�tusz k�d], lk_Garant�lt_b�rminimum_alatti_02.Illetm�ny AS Illetm�ny, lk_Garant�lt_b�rminimum_alatti_02.[Heti munka�r�k sz�ma] AS [Heti munka�r�k sz�ma], lk_Garant�lt_b�rminimum_alatti_02.Brutt�_b�r AS [Brutt� illetm�ny], lkSzem�lyek.[KIRA jogviszony jelleg], lkSzem�lyek.[Iskolai v�gzetts�g foka], lkSzem�lyek.[Iskolai v�gzetts�g neve], kt_azNexon_Ad�jel02.NLink AS NLink, lkSzem�lyek.[Tart�s t�voll�t t�pusa]
FROM (kt_azNexon_Ad�jel02 RIGHT JOIN lkSzem�lyek ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel) RIGHT JOIN lk_Garant�lt_b�rminimum_alatti_02 ON lkSzem�lyek.Ad�jel = lk_Garant�lt_b�rminimum_alatti_02.Ad�jel
WHERE (((lk_Garant�lt_b�rminimum_alatti_02.Garant�lt_min_alatt)=Yes))
ORDER BY lkSzem�lyek.[Dolgoz� teljes neve];

-- [lk_Havib�l�ll�shelyek]
SELECT Fedlapr�l�ll�shelyekUni�.T�bla, Fedlapr�l�ll�shelyekUni�.Azonos�t�, Fedlapr�l�ll�shelyekUni�.[Az �ll�shely megynevez�se], Fedlapr�l�ll�shelyekUni�.[�ll�shely sz�ma], *
FROM (SELECT *, "Alapl�tsz�m" as T�bla
FROM Fedlapr�lL�tsz�mt�bla
UNION
SELECT *, "K�zpontos�tott" as T�bla
FROM Fedlapr�lL�tsz�mt�bla2
)  AS Fedlapr�l�ll�shelyekUni�
ORDER BY Fedlapr�l�ll�shelyekUni�.T�bla, Fedlapr�l�ll�shelyekUni�.Azonos�t�;

-- [lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_01]
SELECT Bfkh([Szervezetk�d]) AS BFKH, lk_�llom�nyt�bl�kb�l_Illetm�nyek.Szervezetk�d, lk_�llom�nyt�bl�kb�l_Illetm�nyek.Ad�jel, tSzervezet.[Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s] AS besorol�s, lk_�llom�nyt�bl�kb�l_Illetm�nyek.[�ll�shely azonos�t�], tBesorol�s_�talak�t�_1.[als� hat�r], tBesorol�s_�talak�t�_1.[fels� hat�r], lk_�llom�nyt�bl�kb�l_Illetm�nyek.Illetm�ny, lk_�llom�nyt�bl�kb�l_Illetm�nyek.[Heti munka�r�k sz�ma], [Illetm�ny]/IIf([Heti munka�r�k sz�ma]=0,0.0001,[Heti munka�r�k sz�ma])*40 AS [40 �r�s illetm�ny], tBesorol�s_�talak�t�_1.[Jogviszony t�pusa], lk_�llom�nyt�bl�kb�l_Illetm�nyek.N�v, lk_�llom�nyt�bl�kb�l_Illetm�nyek.F�oszt�ly, lk_�llom�nyt�bl�kb�l_Illetm�nyek.Oszt�ly, lk_�llom�nyt�bl�kb�l_Illetm�nyek.Ad�jel, lk_�llom�nyt�bl�kb�l_Illetm�nyek.Besorol�sHavi
FROM tBesorol�s_�talak�t� AS tBesorol�s_�talak�t�_1 RIGHT JOIN (lk_�llom�nyt�bl�kb�l_Illetm�nyek RIGHT JOIN tSzervezet ON lk_�llom�nyt�bl�kb�l_Illetm�nyek.[�ll�shely azonos�t�] = tSzervezet.[Szervezetmenedzsment k�d]) ON tBesorol�s_�talak�t�_1.[Az �ll�shely jel�l�se] = lk_�llom�nyt�bl�kb�l_Illetm�nyek.Besorol�sHavi
WHERE ((([Illetm�ny]/IIf([Heti munka�r�k sz�ma]=0,0.0001,[Heti munka�r�k sz�ma])*40) Not Between [als� hat�r] And [fels� hat�r]));

-- [lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_02]
SELECT lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_01.Szervezetk�d, lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_01.F�oszt�ly, lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_01.N�v, lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_01.Ad�jel, lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_01.besorol�s, lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_01.[als� hat�r], lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_01.[fels� hat�r], lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_01.Illetm�ny, lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_01.[Heti munka�r�k sz�ma], lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_01.[40 �r�s illetm�ny], lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_01.[Jogviszony t�pusa], kt_azNexon_Ad�jel02.Nlink AS Hivatkoz�s
FROM lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_01 LEFT JOIN kt_azNexon_Ad�jel02 ON lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_01.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel
ORDER BY lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_01.BFKH;

-- [lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_03]
SELECT DISTINCT lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_02.F�oszt�ly, lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_02.N�v, lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_02.besorol�s, lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_02.[als� hat�r], lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_02.[fels� hat�r], lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_02.Illetm�ny, lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_02.[Heti munka�r�k sz�ma], lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_02.[40 �r�s illetm�ny], lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_02.[Jogviszony t�pusa], lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_02.Hivatkoz�s
FROM lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_02;

-- [lk_Illetm�nys�vok_�s_illetm�nyek_�sszevontan]
SELECT  *
FROM lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_03
UNION SELECT *
FROM  lk_Illetm�nys�vok_�s_illetm�nyek_szem�lyt�rzs_alapj�n02;

-- [lk_Illetm�nys�vok_�s_illetm�nyek_szem�lyt�rzs_alapj�n]
SELECT lkSzem�lyek.[Szervezeti egys�g k�dja], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.Ad�jel, lkSzem�lyek.[Besorol�si  fokozat (KT)], tBesorol�s_�talak�t�.[als� hat�r], tBesorol�s_�talak�t�.[fels� hat�r], lkSzem�lyek.[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)], lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker] AS [Heti �rasz�m], [Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40 AS [40 �r�s illetm�ny], tBesorol�s_�talak�t�.[Jogviszony t�pusa], kt_azNexon_Ad�jel.NLink AS Hivatkoz�s
FROM (lkSzem�lyek INNER JOIN tBesorol�s_�talak�t� ON (lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus] = tBesorol�s_�talak�t�.[Jogviszony t�pusa]) AND (lkSzem�lyek.[Besorol�si  fokozat (KT)] = tBesorol�s_�talak�t�.Besorol�si_fokozat)) LEFT JOIN kt_azNexon_Ad�jel ON lkSzem�lyek.Ad�jel = kt_azNexon_Ad�jel.Ad�jel
WHERE (((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null) AND (([Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40) Not Between [als� hat�r] And [fels� hat�r]) AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null) AND ((lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)]) Is Null Or (lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)])>Date()))
ORDER BY lkSzem�lyek.[Szervezeti egys�g k�dja], lkSzem�lyek.[Dolgoz� teljes neve];

-- [lk_Illetm�nys�vok_�s_illetm�nyek_szem�lyt�rzs_alapj�n02]
SELECT lk_Illetm�nys�vok_�s_illetm�nyek_szem�lyt�rzs_alapj�n.F�oszt�ly, lk_Illetm�nys�vok_�s_illetm�nyek_szem�lyt�rzs_alapj�n.[Dolgoz� teljes neve], lk_Illetm�nys�vok_�s_illetm�nyek_szem�lyt�rzs_alapj�n.[Besorol�si  fokozat (KT)], lk_Illetm�nys�vok_�s_illetm�nyek_szem�lyt�rzs_alapj�n.[als� hat�r], lk_Illetm�nys�vok_�s_illetm�nyek_szem�lyt�rzs_alapj�n.[fels� hat�r], lk_Illetm�nys�vok_�s_illetm�nyek_szem�lyt�rzs_alapj�n.[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)], lk_Illetm�nys�vok_�s_illetm�nyek_szem�lyt�rzs_alapj�n.[Heti �rasz�m], lk_Illetm�nys�vok_�s_illetm�nyek_szem�lyt�rzs_alapj�n.[40 �r�s illetm�ny], lk_Illetm�nys�vok_�s_illetm�nyek_szem�lyt�rzs_alapj�n.[Jogviszony t�pusa], lk_Illetm�nys�vok_�s_illetm�nyek_szem�lyt�rzs_alapj�n.Hivatkoz�s
FROM lk_Illetm�nys�vok_�s_illetm�nyek_szem�lyt�rzs_alapj�n LEFT JOIN lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_02 ON lk_Illetm�nys�vok_�s_illetm�nyek_szem�lyt�rzs_alapj�n.ad�jel = lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_02.ad�jel
WHERE (((lk_Illetm�nys�vok_�s_illetm�nyek_havi_alapj�n_02.ad�jel) Is Null));

-- [lk_Inakt�vBet�lt�k�s�ll�shely�k]
SELECT [Szervezetmenedzsment k�d]*1 AS Ad�jel, tSzervezeti.[St�tusz�nak k�dja], tSzervezeti.[�rv�nyess�g kezdete], tSzervezeti.[�rv�nyess�g v�ge]
FROM tSzervezeti
WHERE (((tSzervezeti.[�rv�nyess�g kezdete])<(SELECT TOP 1 tHaviJelent�sHat�lya.hat�lya
FROM tHaviJelent�sHat�lya
GROUP BY tHaviJelent�sHat�lya.hat�lya
ORDER BY First(tHaviJelent�sHat�lya.[r�gz�t�s]) DESC)) AND ((tSzervezeti.[�rv�nyess�g v�ge])>(SELECT TOP 1 tHaviJelent�sHat�lya.hat�lya
FROM tHaviJelent�sHat�lya
GROUP BY tHaviJelent�sHat�lya.hat�lya
ORDER BY First(tHaviJelent�sHat�lya.[r�gz�t�s]) DESC)) AND ((tSzervezeti.OSZLOPOK)="St�tusz bet�lt�s") AND ((tSzervezeti.[St�tuszbet�lt�s t�pusa])="Inakt�v"))
AND "######Azok sz�m�tanak inakt�vnak, akik a Szervezeti alapriportban olyan sorral rendelkeznek, amelyikben a st�tuszbet�lt�s inakt�v, �s az �rv�nyess�g a havi l�tsz�mjelent�s d�tuma el�tt kezd�d�tt �s azt k�vet�en �r v�get.#####"<>"";

-- [lk_IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt]
TRANSFORM Count(lkSzem�lyek.azonos�t�) AS CountOfad�jel
SELECT lkSzem�lyek.F�oszt�lyK�d, lkSzem�lyek.F�oszt�ly AS [F�oszt�ly ill hivatal]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null) AND ((lkSzem�lyek.[St�tusz t�pusa]) Is Not Null))
GROUP BY lkSzem�lyek.F�oszt�lyK�d, lkSzem�lyek.F�oszt�ly
ORDER BY lkSzem�lyek.F�oszt�ly
PIVOT lkSzem�lyek.[Iskolai v�gzetts�g foka] In ("","�ltal�nos iskola 8 oszt�ly","Egyetemi /fels�fok� (MA/MsC) vagy osztatlan k�pz.","�retts.biz.szakk�pes-vel,k�pes�t� biz.","�retts.biz.Szakk�p-vel,�retts.�p.�iskr-ben szakk�p","�retts�gi biz. szakk�pes�t�s n�lk (pl: gimn.�r.)","Fels�okt-i (fels�fok�) szakk�pz�sben szerzett biz.","F�iskolai vagy fels�fok� alapk�pz�s (BA/BsC)okl.","Gimn�zium","Szakiskola","Szakk�pzetts�g �retts�gi bizony�tv�ny n�lk�l","Szakk�z�piskola","Szakmunk�sk�pz� iskola","Technikum");

-- [lk_IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesen]
TRANSFORM Count(lkSzem�lyek.azonos�t�) AS CountOfad�jel
SELECT "BFKH.1" AS Kif1, "�sszesen:" AS [F�oszt�ly ill hivatal]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null) AND ((lkSzem�lyek.[St�tusz t�pusa]) Is Not Null))
GROUP BY "�sszesen:"
PIVOT lkSzem�lyek.[Iskolai v�gzetts�g foka] In ("","�ltal�nos iskola 8 oszt�ly","Egyetemi /fels�fok� (MA/MsC) vagy osztatlan k�pz.","�retts.biz.szakk�pes-vel,k�pes�t� biz.","�retts.biz.Szakk�p-vel,�retts.�p.�iskr-ben szakk�p","�retts�gi biz. szakk�pes�t�s n�lk (pl: gimn.�r.)","Fels�okt-i (fels�fok�) szakk�pz�sben szerzett biz.","F�iskolai vagy fels�fok� alapk�pz�s (BA/BsC)okl.","Gimn�zium","Szakiskola","Szakk�pzetts�g �retts�gi bizony�tv�ny n�lk�l","Szakk�z�piskola","Szakmunk�sk�pz� iskola","Technikum");

-- [lk_IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesennel]
SELECT IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesennel.[F�oszt�ly ill hivatal], IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesennel.[<>], IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesennel.[�ltal�nos iskola 8 oszt�ly], IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesennel.[Egyetemi /fels�fok� (MA/MsC) vagy osztatlan k�pz_], IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesennel.[�retts_biz_szakk�pes-vel,k�pes�t� biz_], IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesennel.[�retts_biz_Szakk�p-vel,�retts_�p_�iskr-ben szakk�p], IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesennel.[�retts�gi biz_ szakk�pes�t�s n�lk (pl: gimn_�r_)], IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesennel.[Fels�okt-i (fels�fok�) szakk�pz�sben szerzett biz_], IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesennel.[F�iskolai vagy fels�fok� alapk�pz�s (BA/BsC)okl_], IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesennel.Gimn�zium, IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesennel.Szakiskola, IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesennel.[Szakk�pzetts�g �retts�gi bizony�tv�ny n�lk�l], IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesennel.Szakk�z�piskola, IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesennel.[Szakmunk�sk�pz� iskola], IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesennel.Technikum
FROM (SELECT * ,0 as sor
FROM  lk_IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt
UNION

SELECT *, 1 as sor
FROM lk_IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesen
)  AS IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesennel
ORDER BY IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesennel.sor, IskolaiV�gzetts�gMegoszl�sa_F�oszt�lyonk�nt�sszesennel.F�oszt�lyK�d;

-- [lk_jog�sz_�tlagilletm�ny]
SELECT DISTINCT lkSzem�lyek.F�oszt�ly, Round(Avg([Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40)/100,0)*100 AS Illetm�ny
FROM lkSzem�lyek INNER JOIN tBesorol�s_�talak�t� ON lkSzem�lyek.[Besorol�si  fokozat (KT)] = tBesorol�s_�talak�t�.Besorol�si_fokozat
WHERE (((lkSzem�lyek.[Iskolai v�gzetts�g neve]) Like "*jog�sz*") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((tBesorol�s_�talak�t�.Vezet�)=No) AND ((lkSzem�lyek.f�oszt�ly) Like "*ker�let*"))
GROUP BY lkSzem�lyek.F�oszt�ly;

-- [lk_Jogviszony_jellege_01]
SELECT lkSzem�lyek.BFKH, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], Nz([Szem�lyt�rzs],[KIRA jogviszony jelleg]) AS KIRA_, lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus] AS Nexon, IIf([KIRA_]<>[NEXON] Or [KIRA_] Is Null,1,0) AS hiba, kt_azNexon_Ad�jel02.NLink
FROM (kt_azNexon_Ad�jel02 RIGHT JOIN lkSzem�lyek ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel) LEFT JOIN tJogviszonyKonverzi� ON lkSzem�lyek.[KIRA jogviszony jelleg] = tJogviszonyKonverzi�.KIRA
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.[Dolgoz� teljes neve];

-- [lk_jogviszony_jellege_02]
SELECT lk_Jogviszony_jellege_01.F�oszt�ly, lk_Jogviszony_jellege_01.Oszt�ly, lk_Jogviszony_jellege_01.[Dolgoz� teljes neve], lk_Jogviszony_jellege_01.KIRA_ AS KIRA, lk_Jogviszony_jellege_01.Nexon, lk_Jogviszony_jellege_01.NLink
FROM lk_Jogviszony_jellege_01
WHERE (((lk_Jogviszony_jellege_01.hiba)=1))
ORDER BY lk_Jogviszony_jellege_01.BFKH;

-- [lk_jogviszony_jellege_02_r�gi]
SELECT lk_Jogviszony_jellege_01.BFKH, lk_Jogviszony_jellege_01.[Dolgoz� teljes neve] AS N�v, lk_Jogviszony_jellege_01.F�oszt�ly, lk_Jogviszony_jellege_01.Oszt�ly, lk_Jogviszony_jellege_01.Kira, lk_Jogviszony_jellege_01.Nexon, lk_Jogviszony_jellege_01.NLink
FROM lk_Jogviszony_jellege_01
WHERE (((lk_Jogviszony_jellege_01.Nexon)<>[Kira]));

-- [lk_KiraHiba]
SELECT tKiraHiba.Azonos�t�, lkSzem�lyek.[Szervezeti egys�g k�dja], tSzervezetiEgys�gek.F�oszt�ly, tSzervezetiEgys�gek.Oszt�ly, tKiraHiba.Ad�azonos�t�, tKiraHiba.N�v, tKiraHiba.Hiba
FROM (tKiraHiba LEFT JOIN lkSzem�lyek ON tKiraHiba.Ad�azonos�t� = lkSzem�lyek.Ad�jel) LEFT JOIN tSzervezetiEgys�gek ON lkSzem�lyek.[Szervezeti egys�g k�dja] = tSzervezetiEgys�gek.[Szervezeti egys�g k�dja]
WHERE (((tKiraHiba.Hiba) Like "*kit�ltve*" Or (tKiraHiba.Hiba) Like "*k�telez�*" Or (tKiraHiba.Hiba) Like "*nincs*") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY bfkh(Nz([lkSzem�lyek].[Szervezeti egys�g k�dja],0)), tKiraHiba.N�v;

-- [lk_KiraHiba_01]
SELECT bfkh([Szervezeti egys�g k�dja]) AS BFKH, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, tKiraHiba.Ad�azonos�t�, tKiraHiba.N�v, lkSzem�lyek.[Szervezeti egys�g k�dja], lkSzem�lyek.[St�tusz k�dja], tKiraHiba.Hiba
FROM tKiraHiba LEFT JOIN lkSzem�lyek ON tKiraHiba.Ad�azonos�t� = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[St�tusz k�dja]) Like "S-*") AND ((tKiraHiba.Hiba) Not Like "A dolgozo*" And (tKiraHiba.Hiba) Not Like "2-es*" And (tKiraHiba.Hiba) Not Like "*AHELISMD*" And (tKiraHiba.Hiba) Not Like "A dolgoz� �j bel�p�k�nt lett*"))
ORDER BY bfkh([Szervezeti egys�g k�dja]);

-- [lk_KiraHiba_01_c�mzettek]
SELECT DISTINCT lk_KiraHiba_01.TO, Count(lk_KiraHiba_01.Ad�azonos�t�) AS CountOfAd�azonos�t�
FROM lk_KiraHiba_01
GROUP BY lk_KiraHiba_01.TO;

-- [lk_Lek�rdez�s�r�__Illetm�ny_nulla_01]
SELECT tJav�tand�Mez�nevek.azJav�tand�, tNexonMez�k.[Nexon mez� megnevez�se], tJav�tand�Mez�nevek.T�bla, tJav�tand�Mez�nevek.Ellen�rz�shez, tJav�tand�Mez�nevek.Import, "AND ([" & [Ellen�rz�shez] & "].[" & [�res�ll�shelyMez�k] & "]<> '�res �ll�s' OR [" & [Ellen�rz�shez] & "].[" & [�res�ll�shelyMez�k] & "] is null ) " AS �res, "SELECT '" & [Ellen�rz�shez] & "' as T�bla, 'Illetm�ny' As [Hi�nyz� �rt�k], [" & [Ad�] & "] As Ad�jel, [" & [SzervezetK�d_mez�] & "] As SzervezetK�d FROM [" & [Ellen�rz�shez] & "] WHERE [" & [Import] & "]=0 " & [�res] AS [SQL], (Select import From tJav�tand�Mez�nevek as Bels� where Bels�.azNexonMez�k = 7 and Bels�.Ellen�rz�shez = tJav�tand�Mez�nevek.Ellen�rz�shez) AS Ad�
FROM tNexonMez�k RIGHT JOIN tJav�tand�Mez�nevek ON tNexonMez�k.azNexonMez� = tJav�tand�Mez�nevek.azNexonMez�k
WHERE (((tNexonMez�k.[Nexon mez� megnevez�se])="Illetm�ny"));

-- [lk_Lek�rdez�s�r�__Illetm�ny_nulla_02]
SELECT (Select count(azJav�tand�) From lk_Lek�rdez�s�r�__Illetm�ny_nulla_01 as Tmp where Tmp.azJav�tand� <= k�ls�.azJav�tand�) AS Sorsz�m, k�ls�.azJav�tand�, k�ls�.[Nexon mez� megnevez�se], k�ls�.T�bla, k�ls�.Ellen�rz�shez, k�ls�.Import, k�ls�.SQL, k�ls�.Ad�
FROM lk_Lek�rdez�s�r�__Illetm�ny_nulla_01 AS k�ls�;

-- [lk_Lek�rdez�s�r�__Illetm�ny_nulla_03]
SELECT lk_Lek�rdez�s�r�__Illetm�ny_nulla_02.Sorsz�m, lk_Lek�rdez�s�r�__Illetm�ny_nulla_02.azJav�tand�, lk_Lek�rdez�s�r�__Illetm�ny_nulla_02.[Nexon mez� megnevez�se], lk_Lek�rdez�s�r�__Illetm�ny_nulla_02.T�bla, lk_Lek�rdez�s�r�__Illetm�ny_nulla_02.Ellen�rz�shez, lk_Lek�rdez�s�r�__Illetm�ny_nulla_02.Import, [SQL] & IIf([Sorsz�m]<>(Select Max(Sorsz�m) From lk_Lek�rdez�s�r�__Illetm�ny_nulla_02)," UNION ","") AS SQL1
FROM lk_Lek�rdez�s�r�__Illetm�ny_nulla_02;

-- [lk_m�rn�k_�tlagilletm�ny]
SELECT DISTINCT lkSzem�lyek.F�oszt�ly, Round(Avg([Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40)/100,0)*100 AS Illetm�ny
FROM lkSzem�lyek INNER JOIN tBesorol�s_�talak�t� ON lkSzem�lyek.[Besorol�si  fokozat (KT)] = tBesorol�s_�talak�t�.Besorol�si_fokozat
WHERE (((lkSzem�lyek.[Iskolai v�gzetts�g neve]) Like "*m�rn�k*") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((tBesorol�s_�talak�t�.Vezet�)=No) AND ((lkSzem�lyek.f�oszt�ly) Like "*ker�let*"))
GROUP BY lkSzem�lyek.F�oszt�ly;

-- [lk_N�peg�szs�g�gy_�tlagilletm�ny]
SELECT bfkh([Szervezeti egys�g k�dja]) AS bfkh, lkSzem�lyek.F�oszt�ly, IIf([KIRA feladat megnevez�s]="N�peg�szs�g�gyi feladatok, tisztif�orvos, tisztiorvos","Tisztif�orvos",IIf([FEOR]="2225 - V�d�n�","V�d�n�","Egy�b")) AS Feladatk�r�k, Round(Avg([Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40)/100,0)*100 AS Illetm�ny
FROM lkSzem�lyek INNER JOIN tBesorol�s_�talak�t� ON lkSzem�lyek.[Besorol�si  fokozat (KT)] = tBesorol�s_�talak�t�.Besorol�si_fokozat
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.Oszt�ly)="N�peg�szs�g�gyi Oszt�ly") AND ((tBesorol�s_�talak�t�.Vezet�)=No))
GROUP BY bfkh([Szervezeti egys�g k�dja]), lkSzem�lyek.F�oszt�ly, IIf([KIRA feladat megnevez�s]="N�peg�szs�g�gyi feladatok, tisztif�orvos, tisztiorvos","Tisztif�orvos",IIf([FEOR]="2225 - V�d�n�","V�d�n�","Egy�b"))
ORDER BY bfkh([Szervezeti egys�g k�dja]);

-- [lk_N�peg�szs�g�gy_�tlagilletm�ny_tisztif�orvos]
SELECT DISTINCT lkSzem�lyek.Ad�jel, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Anyja neve], Round([Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40/100,0)*100 AS Illetm�ny
FROM lkSzem�lyek INNER JOIN tBesorol�s_�talak�t� ON lkSzem�lyek.[Besorol�si  fokozat (KT)] = tBesorol�s_�talak�t�.Besorol�si_fokozat
WHERE (((lkSzem�lyek.[KIRA feladat megnevez�s])="N�peg�szs�g�gyi feladatok, tisztif�orvos, tisztiorvos") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.Oszt�ly)="N�peg�szs�g�gyi Oszt�ly") AND ((tBesorol�s_�talak�t�.Vezet�)=No));

-- [lk_N�peg�szs�g�gy_�tlagilletm�nyFeladatonk�nt]
SELECT IIf([KIRA feladat megnevez�s]="N�peg�szs�g�gyi feladatok, tisztif�orvos, tisztiorvos","Tisztif�orvos",IIf([FEOR]="2225 - V�d�n�","V�d�n�",IIf([Iskolai v�gzetts�g neve] Like "*j�rv�ny�gyi fel�gyel�*","J�rv�ny�gyi fel�gyel�","Egy�b"))) AS Feladatk�r�k, Round(Avg([Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40)/100,0)*100 AS Illetm�ny
FROM lkSzem�lyek INNER JOIN tBesorol�s_�talak�t� ON lkSzem�lyek.[Besorol�si  fokozat (KT)] = tBesorol�s_�talak�t�.Besorol�si_fokozat
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.Oszt�ly)="N�peg�szs�g�gyi Oszt�ly") AND ((tBesorol�s_�talak�t�.Vezet�)=No))
GROUP BY IIf([KIRA feladat megnevez�s]="N�peg�szs�g�gyi feladatok, tisztif�orvos, tisztiorvos","Tisztif�orvos",IIf([FEOR]="2225 - V�d�n�","V�d�n�",IIf([Iskolai v�gzetts�g neve] Like "*j�rv�ny�gyi fel�gyel�*","J�rv�ny�gyi fel�gyel�","Egy�b")));

-- [lk_N�peg�szs�g�gy_�tlagilletm�nyHivatalonk�nt]
SELECT bfkh([Szervezeti egys�g k�dja]) AS bfkh, lkSzem�lyek.F�oszt�ly, Round(Avg([Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40)/100,0)*100 AS Illetm�ny
FROM lkSzem�lyek INNER JOIN tBesorol�s_�talak�t� ON lkSzem�lyek.[Besorol�si  fokozat (KT)] = tBesorol�s_�talak�t�.Besorol�si_fokozat
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.Oszt�ly)="N�peg�szs�g�gyi Oszt�ly") AND ((tBesorol�s_�talak�t�.Vezet�)=No))
GROUP BY bfkh([Szervezeti egys�g k�dja]), lkSzem�lyek.F�oszt�ly
ORDER BY bfkh([Szervezeti egys�g k�dja]);

-- [lk_Oszt�lyonk�nti_�tlagilletm�ny_hat�s�g, gy�m�gy]
SELECT bfkh([Szervezeti egys�g k�dja]) AS bfkh, lkSzem�lyek.F�oszt�ly, Round(Avg([Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40)/100,0)*100 AS Illetm�ny, IIf([KIRA feladat megnevez�s]="Szoci�lis �s gy�m�gyi feladatok","Gy�m�gyi feladatok","Hat�s�gi feladatok") AS Feladatk�r
FROM lkSzem�lyek INNER JOIN tBesorol�s_�talak�t� ON lkSzem�lyek.[Besorol�si  fokozat (KT)] = tBesorol�s_�talak�t�.Besorol�si_fokozat
WHERE (((lkSzem�lyek.Oszt�ly)="Hat�s�gi �s Gy�m�gyi Oszt�ly") AND ((tBesorol�s_�talak�t�.Vezet�)=No) AND ((lkSzem�lyek.[Els�dleges feladatk�r]) Not Like "15-Titk�rs�gi �s igazgat�si feladatok"))
GROUP BY bfkh([Szervezeti egys�g k�dja]), lkSzem�lyek.F�oszt�ly, IIf([KIRA feladat megnevez�s]="Szoci�lis �s gy�m�gyi feladatok","Gy�m�gyi feladatok","Hat�s�gi feladatok"), lkSzem�lyek.[St�tusz neve]
HAVING (((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY bfkh([Szervezeti egys�g k�dja]);

-- [lk_Oszt�lyonk�nti_�tlagilletm�ny01]
SELECT bfkh([Szervezeti egys�g k�dja]) AS bfkh, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, Avg([Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40) AS Illetm�ny
FROM lkSzem�lyek INNER JOIN tBesorol�s_�talak�t� ON lkSzem�lyek.[Besorol�si  fokozat (KT)] = tBesorol�s_�talak�t�.Besorol�si_fokozat
WHERE (((tBesorol�s_�talak�t�.Vezet�)=No))
GROUP BY bfkh([Szervezeti egys�g k�dja]), lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[St�tusz neve]
HAVING (((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY bfkh([Szervezeti egys�g k�dja]);

-- [lk_Oszt�lyonk�nti_�tlagilletm�ny01_ker�letiek]
SELECT bfkh([Szervezeti egys�g k�dja]) AS bfkh, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, Avg([Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40) AS Illetm�ny, lkSzem�lyek.[Els�dleges feladatk�r] AS Feladatk�re, Count(lkSzem�lyek.[Ad�azonos�t� jel]) AS F�
FROM lkSzem�lyek INNER JOIN tBesorol�s_�talak�t� ON lkSzem�lyek.jel2 = tBesorol�s_�talak�t�.[Az �ll�shely jel�l�se]
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((tBesorol�s_�talak�t�.Vezet�)=No))
GROUP BY bfkh([Szervezeti egys�g k�dja]), lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Els�dleges feladatk�r]
HAVING (((lkSzem�lyek.[Els�dleges feladatk�r]) Not Like "15-Titk�rs�gi �s igazgat�si feladatok"))
ORDER BY bfkh([Szervezeti egys�g k�dja]);

-- [lk_Oszt�lyonk�nti_�tlagilletm�ny02]
SELECT lk_Oszt�lyonk�nti_�tlagilletm�ny01.F�oszt�ly, lk_Oszt�lyonk�nti_�tlagilletm�ny01.Oszt�ly, Round([Illetm�ny]/100,0)*100 AS �tlagilletm�ny
FROM lk_Oszt�lyonk�nti_�tlagilletm�ny01;

-- [lk_Oszt�lyonk�nti_�tlagilletm�ny02_ker�letiek]
SELECT lk_Oszt�lyonk�nti_�tlagilletm�ny01_ker�letiek.bfkh, lk_Oszt�lyonk�nti_�tlagilletm�ny01_ker�letiek.F�oszt�ly, Left([Oszt�ly],15) AS Oszt�lyok, Round([Illetm�ny]/100,0)*100 AS �tlagilletm�ny, lk_Oszt�lyonk�nti_�tlagilletm�ny01_ker�letiek.F�
FROM lk_Oszt�lyonk�nti_�tlagilletm�ny01_ker�letiek
WHERE (((lk_Oszt�lyonk�nti_�tlagilletm�ny01_ker�letiek.F�oszt�ly) Like "bfkh*"));

-- [lk_Oszt�lyonk�nti_�tlagilletm�ny03_ker�letiek]
SELECT lk_Oszt�lyonk�nti_�tlagilletm�ny02_ker�letiek.F�oszt�ly, IIf([Oszt�lyok]="Korm�nyablak Os","Korm�nyablak Oszt�ly",IIf([Oszt�lyok]="Foglalkoztat�si","Foglalkoztat�si Oszt�ly",IIf([Oszt�lyok]="Gy�m�gyi Oszt�l","Gy�m�gyi Oszt�ly",IIf([Oszt�lyok]="Hat�s�gi �s Gy�","Hat�s�gi �s Gy�m�gyi Oszt�ly",IIf([Oszt�lyok]="Hat�s�gi Oszt�l","Hat�s�gi Oszt�ly",IIf([Oszt�lyok]="N�peg�szs�g�gyi","N�peg�szs�g�gyi Oszt�ly","")))))) AS Oszt�ly, Round(Sum([�tlagilletm�ny]*[F�])/Sum([F�])/100,0)*100 AS �tlagilletm�nyek
FROM lk_Oszt�lyonk�nti_�tlagilletm�ny02_ker�letiek
GROUP BY lk_Oszt�lyonk�nti_�tlagilletm�ny02_ker�letiek.F�oszt�ly, IIf([Oszt�lyok]="Korm�nyablak Os","Korm�nyablak Oszt�ly",IIf([Oszt�lyok]="Foglalkoztat�si","Foglalkoztat�si Oszt�ly",IIf([Oszt�lyok]="Gy�m�gyi Oszt�l","Gy�m�gyi Oszt�ly",IIf([Oszt�lyok]="Hat�s�gi �s Gy�","Hat�s�gi �s Gy�m�gyi Oszt�ly",IIf([Oszt�lyok]="Hat�s�gi Oszt�l","Hat�s�gi Oszt�ly",IIf([Oszt�lyok]="N�peg�szs�g�gyi","N�peg�szs�g�gyi Oszt�ly",""))))));

-- [lk_RefEmail_01]
SELECT tSzervezetiEgys�gek.azSzervezet, tSzervezetiEgys�gek.[Szervezeti egys�g k�dja], tReferensek.azRef AS azRef, tReferensek.[Hivatali email], tSzervezetiEgys�gek.F�oszt�ly, tSzervezetiEgys�gek.Oszt�ly
FROM (tSzervezetiEgys�gek LEFT JOIN ktReferens_SzervezetiEgys�g ON tSzervezetiEgys�gek.azSzervezet=ktReferens_SzervezetiEgys�g.azSzervezet) LEFT JOIN tReferensek ON ktReferens_SzervezetiEgys�g.azRef=tReferensek.azRef;

-- [lk_RefEmail_02]
SELECT lk_RefEmail_01.azSzervezet, lk_RefEmail_01.[Szervezeti egys�g k�dja], lk_RefEmail_01.azRef, lk_RefEmail_01.[Hivatali email], (Select Count(Tmp.AzSzervezet)
    From lk_RefEmail_01 As Tmp
    Where Tmp.azRef <= lk_RefEmail_01.azRef
      AND Tmp.[Szervezeti egys�g k�dja] =lk_RefEmail_01.[Szervezeti egys�g k�dja]
   ) AS Sorsz�m, lk_RefEmail_01.F�oszt�ly, lk_RefEmail_01.Oszt�ly
FROM lk_RefEmail_01;

-- [lk_RefEmail_03]
PARAMETERS �ss�l_egy_entert Long;
TRANSFORM First(lk_RefEmail_02.[Hivatali email]) AS [FirstOfHivatali email]
SELECT lk_RefEmail_02.azSzervezet, lk_RefEmail_02.[Szervezeti egys�g k�dja], lk_RefEmail_02.F�oszt�ly, lk_RefEmail_02.Oszt�ly
FROM lk_RefEmail_02
GROUP BY lk_RefEmail_02.azSzervezet, lk_RefEmail_02.[Szervezeti egys�g k�dja], lk_RefEmail_02.F�oszt�ly, lk_RefEmail_02.Oszt�ly
PIVOT lk_RefEmail_02.Sorsz�m In (1,2,3,4,5,6);

-- [lk_RefEmail_04]
SELECT lk_RefEmail_03.azSzervezet, lk_RefEmail_03.[Szervezeti egys�g k�dja], lk_RefEmail_03.F�oszt�ly, lk_RefEmail_03.Oszt�ly, lk_RefEmail_03.[1], lk_RefEmail_03.[2], lk_RefEmail_03.[3], lk_RefEmail_03.[4], lk_RefEmail_03.[5], lk_RefEmail_03.[6], [1] & IIf(Nz([2],"")="","","; " & [2]) & IIf(Nz([3],"")="","","; " & [3]) & IIf(Nz([4],"")="","","; " & [4]) & IIf(Nz([5],"")="","","; " & [5]) & IIf(Nz([6],"")="","","; " & [6]) AS [TO]
FROM lk_RefEmail_03;

-- [lk_Szervezet_Referensei]
SELECT tSzervezetiEgys�gek.azSzervezet, tSzervezetiEgys�gek.F�oszt�ly, tSzervezetiEgys�gek.Oszt�ly, tSzervezetiEgys�gek.[Szervezeti egys�g k�dja], ktReferens_SzervezetiEgys�g.azRef
FROM ktReferens_SzervezetiEgys�g RIGHT JOIN tSzervezetiEgys�gek ON ktReferens_SzervezetiEgys�g.azSzervezet=tSzervezetiEgys�gek.azSzervezet;

-- [lk_TT_TTH_ellen�rz�s_01]
SELECT Ad�azonos�t�, [�NYR SZERVEZETI EGYS�G AZONOS�T�] AS SzervezetK�d, [�ll�shely azonos�t�], [Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h], [Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], N�v
FROM J�r�si_�llom�ny
WHERE  [Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp] <>""
UNION
SELECT Ad�azonos�t�, [�NYR SZERVEZETI EGYS�G AZONOS�T�] AS SzervezetK�d, [�ll�shely azonos�t�], [Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h], [Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], N�v
FROM Korm�nyhivatali_�llom�ny
WHERE  [Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp] <>""
UNION SELECT Ad�azonos�t�, [Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] AS SzervezetK�d, [�ll�shely azonos�t�], [Tart�s t�voll�v� nincs helyettese (TT)/ tart�s t�voll�v�nek van ], [Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], N�v
FROM K�zpontos�tottak
WHERE  [Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp] <>"";

-- [lk_TT_TTH_ellen�rz�s_02a]
SELECT lk_TT_TTH_ellen�rz�s_01.N�v, [Ad�azonos�t�]*1 AS Ad�jel, lk_TT_TTH_ellen�rz�s_01.SzervezetK�d, lk_TT_TTH_ellen�rz�s_01.[�ll�shely azonos�t�], lk_TT_TTH_ellen�rz�s_01.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h], lk_TT_TTH_ellen�rz�s_01.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], IIf(InStr(1,[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h],"TTH"),1,0) AS TTH, IIf(InStr(1,[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h],"TTH"),0,1) AS TT
FROM lk_TT_TTH_ellen�rz�s_01
WHERE (((IIf(InStr(1,[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h],"TTH"),1,0))=1));

-- [lk_TT_TTH_ellen�rz�s_02b]
SELECT lkSzem�lyek_1.[Dolgoz� teljes neve] AS [Helyettes�tett neve], lkSzem�lyek_1.Ad�jel AS [Helyettes�tett ad�jele], "A" AS Alapl�tsz�m, Replace(Replace(IIf(InStr(1,[lkSzem�lyek_1].[Szint 6 szervezeti egys�g n�v],"Budapest"),[lkSzem�lyek_1].[Szint 6 szervezeti egys�g n�v],"Megyei"),"Budapest F�v�ros Korm�nyhivatala","BFKH"),"  ","") AS Megyei_TT, Replace(Replace(IIf(InStr(1,[lkSzem�lyek_1].[Szint 6 szervezeti egys�g n�v],"Budapest"),[lkSzem�lyek_1].[Szint 6 szervezeti egys�g n�v],[lkSzem�lyek_1].[Szint 6 szervezeti egys�g n�v]),"Budapest F�v�ros Korm�nyhivatala","BFKH"),"  ","") AS F�oszt_TT, lkSzem�lyek_1.[Szint 6 szervezeti egys�g n�v], lkSzem�lyek_1.[Szervezeti egys�g k�dja] AS [Helyettes�tett szervezete], lkSzem�lyek_1.[KIRA feladat megnevez�s], lkSzem�lyek_1.[St�tusz k�dja] AS [Helyettes�tett �ll�shelye], lkSzem�lyek_1.[Tart�s t�voll�t t�pusa], lkSzem�lyek_1.[Tart�s t�voll�t kezdete], lkSzem�lyek_1.[Tart�s t�voll�t v�ge], lkSzem�lyek_1.[Tart�s t�voll�t tervezett v�ge], lkSzem�lyek.[Dolgoz� teljes neve] AS [Helyettes neve], lkSzem�lyek.Ad�jel AS [Helyettes ad�jele], "A" AS [Helyettes alapl�tsz�m], lkSzem�lyek.[Szervezeti egys�g k�dja] AS [Helyettes szervezete], lkSzem�lyek.[St�tusz k�dja] AS [Helyettes �ll�shelye], Replace(Replace(IIf(InStr(1,[lkSzem�lyek].[Szint 6 szervezeti egys�g n�v],"Budapest"),[lkSzem�lyek].[Szint 6 szervezeti egys�g n�v],"Megyei"),"Budapest F�v�ros Korm�nyhivatala","BFKH"),"  ","") AS Megyei_TTH, Replace(Replace(IIf(InStr(1,[lkSzem�lyek].[Szint 6 szervezeti egys�g n�v],"Budapest"),[lkSzem�lyek].[Szint 6 szervezeti egys�g n�v],[lkSzem�lyek].[Szint 6 szervezeti egys�g n�v]),"Budapest F�v�ros Korm�nyhivatala","BFKH"),"  ","") AS F�oszt_TTH, lkSzem�lyek.[Szint 6 szervezeti egys�g n�v], lkSzem�lyek.[Szervezeti egys�g k�dja] AS [Helyettes�t� szervezete], lkSzem�lyek.[KIRA feladat megnevez�s], lkSzem�lyek.[St�tusz k�dja] AS �ll�shely_TTH, lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)], lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)], lkSzem�lyek.[Kerek�tett 100 %-os illetm�ny (elt�r�tett)] AS Illetm�ny_TTH
FROM lkSzem�lyek RIGHT JOIN lkSzem�lyek AS lkSzem�lyek_1 ON lkSzem�lyek.[Helyettes�tett dolgoz� neve] = lkSzem�lyek_1.[Dolgoz� teljes neve]
WHERE (((lkSzem�lyek_1.[Tart�s t�voll�t t�pusa]) Is Not Null) And ((IIf(lkSzem�lyek.[Helyettes�tett dolgoz� neve]<>"",1,0))=1)) Or (((lkSzem�lyek_1.[Tart�s t�voll�t t�pusa]) Not Like "") And ((IIf(lkSzem�lyek.[Helyettes�tett dolgoz� neve]<>"",1,0))=1));

-- [lk_TT_TTH_ellen�rz�s_03]
SELECT tSzervezetiEgys�gek.F�oszt�ly, tSzervezetiEgys�gek.Oszt�ly, lk_TT_TTH_ellen�rz�s_02a.N�v, lk_TT_TTH_ellen�rz�s_02a.[�ll�shely azonos�t�], lk_TT_TTH_ellen�rz�s_02a.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h], lk_TT_TTH_ellen�rz�s_02a.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], lk_TT_TTH_ellen�rz�s_02a.Ad�jel AS Ad�jel, kt_azNexon_Ad�jel.NLink AS Nlink
FROM (kt_azNexon_Ad�jel RIGHT JOIN (lk_TT_TTH_ellen�rz�s_02a LEFT JOIN lk_TT_TTH_ellen�rz�s_02b ON lk_TT_TTH_ellen�rz�s_02a.Ad�jel = lk_TT_TTH_ellen�rz�s_02b.[Helyettes�tett ad�jele]) ON kt_azNexon_Ad�jel.Ad�jel = lk_TT_TTH_ellen�rz�s_02a.Ad�jel) INNER JOIN tSzervezetiEgys�gek ON lk_TT_TTH_ellen�rz�s_02a.SzervezetK�d = tSzervezetiEgys�gek.[Szervezeti egys�g k�dja]
WHERE (((lk_TT_TTH_ellen�rz�s_02b.[Helyettes�tett ad�jele]) Is Null) AND ((lk_TT_TTH_ellen�rz�s_02a.TTH)=1));

-- [lk_TT�sszevet�seSzem�ly_Havi]
SELECT Havi.Bfkh AS bfkh, Havi.Ad�jel, Havi.N�v, Replace([J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH") AS [Szervezeti egys�g], Havi.Oszt�ly, Havi.Jogc�me AS [Inakt�v �llom�nyba ker�l�s oka], Szem�lyek.[Tart�s t�voll�t t�pusa], kt_azNexon_Ad�jel02.NLink
FROM kt_azNexon_Ad�jel02 RIGHT JOIN ((SELECT [Ad�azonos�t�]*1 AS Ad�jel, [lk_TT-sek].N�v, [lk_TT-sek].[J�r�si Hivatal], [lk_TT-sek].Oszt�ly, [lk_TT-sek].Jogc�me, BFKH FROM [lk_TT-sek])  AS Havi LEFT JOIN (SELECT lkSzem�lyek.Ad�jel, lkSzem�lyek.[Tart�s t�voll�t t�pusa] FROM lkSzem�lyek)  AS Szem�lyek ON Havi.Ad�jel = Szem�lyek.Ad�jel) ON kt_azNexon_Ad�jel02.Ad�jel = Havi.Ad�jel
WHERE (((Szem�lyek.[Tart�s t�voll�t t�pusa])<>[Jogc�me]))
ORDER BY Havi.Bfkh, Havi.N�v;

-- [lk_TT�sszevet�seSzem�ly_Havi_Statisztika]
SELECT bfkh([Szervezeti egys�g k�dja]) AS BFKH, lk_TT�sszevet�seSzem�ly_Havi.[Szervezeti egys�g], Count(lk_TT�sszevet�seSzem�ly_Havi.Ad�jel) AS CountOfAd�jel
FROM lkF�oszt�lyok INNER JOIN lk_TT�sszevet�seSzem�ly_Havi ON lkF�oszt�lyok.F�oszt�ly=lk_TT�sszevet�seSzem�ly_Havi.[Szervezeti egys�g]
GROUP BY bfkh([Szervezeti egys�g k�dja]), lk_TT�sszevet�seSzem�ly_Havi.[Szervezeti egys�g];

-- [lk_TT-sek]
SELECT Uni�.Ad�azonos�t�, Uni�.N�v, Uni�.[J�r�si Hivatal], Uni�.Oszt�ly, Uni�.Jogc�me, Uni�.Kinevez�s, bfkh([BFKHk�d]) AS bfkh
FROM (SELECT J�r�si_�llom�ny.Ad�azonos�t�, J�r�si_�llom�ny.N�v, J�r�si_�llom�ny.[J�r�si Hivatal], J�r�si_�llom�ny.Mez�7 as Oszt�ly, J�r�si_�llom�ny.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp] as Jogc�me, Mez�10 as Kinevez�s,[�NYR SZERVEZETI EGYS�G AZONOS�T�] as BFKHk�d
FROM J�r�si_�llom�ny
WHERE ((Len(J�r�si_�llom�ny.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp])>"0"))
UNION
SELECT Korm�nyhivatali_�llom�ny.Ad�azonos�t�, Korm�nyhivatali_�llom�ny.N�v, Korm�nyhivatali_�llom�ny.Mez�6, Korm�nyhivatali_�llom�ny.Mez�7, Korm�nyhivatali_�llom�ny.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], Mez�10, [�NYR SZERVEZETI EGYS�G AZONOS�T�]
FROM  Korm�nyhivatali_�llom�ny
WHERE ((Len(Korm�nyhivatali_�llom�ny.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp])>"0"))
UNION 
SELECT K�zpontos�tottak.Ad�azonos�t�, K�zpontos�tottak.N�v, K�zpontos�tottak.Mez�6, K�zpontos�tottak.Mez�7, K�zpontos�tottak.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp],Mez�11, [Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�]
FROM   K�zpontos�tottak
WHERE ((Len(K�zpontos�tottak.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp])>"0"))
)  AS Uni�;

-- [lk_TT-sekF�oszt�lyonk�nt]
SELECT Uni��sszeggel.F�oszt�ly AS F�oszt�ly, Uni��sszeggel.[Tart�san t�voll�v�k] AS [Tart�san t�voll�v�k]
FROM (SELECT "1." as sor, Replace([lk_TT-sek].[J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH") AS F�oszt�ly, Count([lk_TT-sek].Ad�azonos�t�) AS [Tart�san t�voll�v�k],  IIf(Left(Replace([bfkh],"BFKH.01.",""),2)="02",Left(Replace([bfkh],"BFKH.01.",""),5),Left(Replace([bfkh],"BFKH.01.",""),2)) as SzSz
FROM [lk_TT-sek]
WHERE ((([lk_TT-sek].Jogc�me)<>"Mentes�t�s munk�ltat� enged�lye alapj�n"))
GROUP BY [lk_TT-sek].[J�r�si Hivatal], IIf(Left(Replace([bfkh],"BFKH.01.",""),2)="02",Left(Replace([bfkh],"BFKH.01.",""),5),Left(Replace([bfkh],"BFKH.01.",""),2))

UNION SELECT "2." as sor, "�sszesen:" AS F�oszt�ly, Count([lk_TT-sek].Ad�azonos�t�) AS [Tart�san t�voll�v�k], "999" as SzSz
FROM [lk_TT-sek]
WHERE ((([lk_TT-sek].Jogc�me)<>"Mentes�t�s munk�ltat� enged�lye alapj�n"))
GROUP BY "�sszesen:")  AS Uni��sszeggel
GROUP BY Uni��sszeggel.F�oszt�ly, Uni��sszeggel.[Tart�san t�voll�v�k], Uni��sszeggel.SzSz, Uni��sszeggel.sor, Uni��sszeggel.SzSz
ORDER BY Uni��sszeggel.sor, Uni��sszeggel.SzSz;

-- [lk_TT-TTH_ellen�rz�s_02bb]
SELECT lk_TT_TTH_ellen�rz�s_02b.[Helyettes�tett ad�jele] As Ad�jel, "TT" As �llapot
FROM lk_TT_TTH_ellen�rz�s_02b
UNION select
lk_TT_TTH_ellen�rz�s_02b_1.[Helyettes ad�jele], "TTH" As �llapot
FROM  lk_TT_TTH_ellen�rz�s_02b AS lk_TT_TTH_ellen�rz�s_02b_1;

-- [lk_v�gzetts�genk�nti_�tlagilletm�ny00]
SELECT lkSzem�lyek.[Iskolai v�gzetts�g neve] AS V�gzetts�g, Round(Avg([Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40)/100,0)*100 AS Illetm�ny
FROM lkSzem�lyek
GROUP BY lkSzem�lyek.[Iskolai v�gzetts�g neve], lkSzem�lyek.[St�tusz neve]
HAVING (((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [lk_v�gzetts�genk�nti_�tlagilletm�ny01]
SELECT IIf([Iskolai v�gzetts�g neve] Like "*jog*","Jog�sz",IIf([Iskolai v�gzetts�g neve] Like "*informatik*","Informatikus",IIf([Iskolai v�gzetts�g neve] Like "*m�rn�k*","M�rn�k",IIf([Iskolai v�gzetts�g neve] Like "*orvos*","Orvos",IIf([Iskolai v�gzetts�g neve] Like "*k�zgazd*","K�zgazd�sz",[Iskolai v�gzetts�g neve]))))) AS V�gzetts�g, Round(Avg([Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40)\100,0)*100 AS Illetm�ny
FROM lkSzem�lyek
GROUP BY IIf([Iskolai v�gzetts�g neve] Like "*jog*","Jog�sz",IIf([Iskolai v�gzetts�g neve] Like "*informatik*","Informatikus",IIf([Iskolai v�gzetts�g neve] Like "*m�rn�k*","M�rn�k",IIf([Iskolai v�gzetts�g neve] Like "*orvos*","Orvos",IIf([Iskolai v�gzetts�g neve] Like "*k�zgazd*","K�zgazd�sz",[Iskolai v�gzetts�g neve]))))), lkSzem�lyek.[St�tusz neve]
HAVING (((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [lk2019�taAGy�mraBel�pettek]
SELECT lkBel�p�kUni�.Ad�jel, lkBel�p�kUni�.N�v, IIf(Len([lkszem�lyek].[F�oszt�ly])<1,"--",[lkszem�lyek].[F�oszt�ly]) AS [Jelenlegi f�oszt�lya], ([lkszem�lyek].[Oszt�ly]) AS [Jelenlegi oszt�lya], lkKil�p�Uni�.F�oszt�ly, lkKil�p�Uni�.Oszt�ly, lkBel�p�kUni�.[Jogviszony kezd� d�tuma] AS Bel�p�s, lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja] AS Kil�p�s
FROM lkSzem�lyek RIGHT JOIN (lkBel�p�kUni� LEFT JOIN lkKil�p�Uni� ON lkBel�p�kUni�.Ad�jel = lkKil�p�Uni�.Ad�jel) ON lkSzem�lyek.Ad�jel = lkBel�p�kUni�.Ad�jel
WHERE (((lkBel�p�kUni�.F�oszt�ly) Like "Gy�m*") AND ((lkBel�p�kUni�.Oszt�ly) Like "gy�m*") AND ((lkBel�p�kUni�.[Jogviszony kezd� d�tuma])>#1/1/2019#) AND ((lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])>[lkBel�p�kUni�].[Jogviszony kezd� d�tuma] Or (lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]) Is Null));

-- [lk2019�taAGy�m�gyr�lKil�pettek]
SELECT DISTINCT lkKil�p�Uni�.Ad�jel, lkKil�p�Uni�.N�v, "--" AS [Jelenlegi f�oszt�lya], "" AS [Jelenlegi oszt�lya], lkKil�p�Uni�.F�oszt�ly, lkKil�p�Uni�.Oszt�ly, lkKil�p�Uni�.[Jogviszony kezd� d�tuma] AS Bel�p�s, lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja] AS Kil�p�s
FROM lkKil�p�Uni�
WHERE (((lkKil�p�Uni�.F�oszt�ly) Like "Gy�m*") AND ((lkKil�p�Uni�.Oszt�ly) Like "*gy�m*") AND ((lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])>#1/1/2019#))
ORDER BY lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja] DESC;

-- [lk25�let�v�ketBeNemT�lt�ttekL�tsz�ma]
SELECT 5 AS Sor, "25 �vn�l fiatalabbak l�tsz�ma:" AS Adat, Sum([25Max].f�) AS �rt�k, Sum([25Max].TTn�lk�l) AS nemTT
FROM (SELECT DISTINCT lkSzem�lyek.Ad�jel, 1 AS F�, Abs([Tart�s t�voll�t t�pusa] Is Null) AS TTn�lk�l FROM lkSzem�lyek WHERE lkSzem�lyek.[Sz�let�si id�]>DateSerial(Year(Now())-25,Month(Now()),Day(Now())) AND lkSzem�lyek.[St�tusz neve]="�ll�shely")  AS 25Max
GROUP BY 5, "25 �vn�l fiatalabbak l�tsz�ma:";

-- [lk25�vn�lId�sebbGyermekHozz�tartoz�k]
SELECT lkHozz�tartoz�k.[Szervezeti egys�g neve], lkHozz�tartoz�k.[Dolgoz� neve], lkHozz�tartoz�k.[Dolgoz� ad�azonos�t� jele], lkHozz�tartoz�k.[Kapcsolat jellege], lkHozz�tartoz�k.[Hozz�tartoz� neve], lkHozz�tartoz�k.[Sz�let�si id�]
FROM lkHozz�tartoz�k
WHERE (((lkHozz�tartoz�k.[Kapcsolat jellege])<>"h�zast�rs" And (lkHozz�tartoz�k.[Kapcsolat jellege])<>"nagykor� hozz�tartoz�") AND ((lkHozz�tartoz�k.[Sz�let�si id�])<DateAdd("yyyy",-25,Date())));

-- [lk4Talapj�n]
SELECT lkMentess�gek.Azonos�t�, lkMentess�gek.[Szervezet n�v], lkMentess�gek.[Szervezet telephely sorsz�m], lkMentess�gek.[N�v el�tag], lkMentess�gek.Csal�dn�v, lkMentess�gek.Ut�n�v, lkMentess�gek.[N�v ut�tag], lkMentess�gek.[Email c�m], lkMentess�gek.[Sz�let�si n�v], lkSzem�lyek.[Dolgoz� sz�let�si neve], lkMentess�gek.[Sz�let�si hely], lkSzem�lyek.[Sz�let�si hely], lkMentess�gek.[Sz�let�si id�], lkSzem�lyek.[Sz�let�si id�], lkMentess�gek.[Anyja neve], lkSzem�lyek.[Anyja neve], lkMentess�gek.Mentess�g, lkMentess�gek.[Jogviszony id�szak kezdete], lkMentess�gek.[Jogviszony id�szak v�ge], lkMentess�gek.N�v, lkMentess�gek.Sz�lHely, lkSzem�lyek.[Besorol�si  fokozat (KT)]
FROM lkMentess�gek LEFT JOIN lkSzem�lyek ON (lkMentess�gek.[Sz�let�si n�v] like "*" & lkSzem�lyek.[Dolgoz� sz�let�si neve] & "*") AND (lkSzem�lyek.[Sz�let�si hely] LIKE "*" & lkMentess�gek.[Sz�lHely]  &"*") AND (lkMentess�gek.[Sz�let�si id�] = lkSzem�lyek.[Sz�let�si id�]) AND (lkMentess�gek.[Anyja neve] like "*" & lkSzem�lyek.[Anyja neve] & "*")
WHERE IIf([V�laszolj "i"-t, ha csak a vezet�ket szeretn�d]="i",[Besorol�si  fokozat (KT)]="oszt�lyvezet�" Or [Besorol�si  fokozat (KT)] Like "ker�leti*" Or [Besorol�si  fokozat (KT)] Like "*igazgat�*" Or [Besorol�si  fokozat (KT)] Like "f�oszt�ly*" Or [Besorol�si  fokozat (KT)]="f�isp�n",[Besorol�si  fokozat (KT)] Like "*")
ORDER BY LCase(Replace(Nz([Besorol�si  fokozat (KT)],""),"J�r�si / ","")) & IIf(Nz([Tart�s t�voll�t t�pusa],"")<>""," (TT)","");

-- [lk55�let�v�ketBet�lt�ttekL�tsz�ma]
SELECT 6 AS Sor, "55 �vn�l id�sebbek l�tsz�ma:" AS Adat, Sum(MIN56.F�) AS �rt�k, Sum(MIN56.TTn�lk�l) AS nemTT
FROM (SELECT DISTINCT lkSzem�lyek.Ad�jel, 1 AS F�, Abs([Tart�s t�voll�t t�pusa] Is Null) AS TTn�lk�l FROM lkSzem�lyek WHERE (((lkSzem�lyek.[Sz�let�si id�])<DateSerial(Year(Now())-55,Month(Now()),Day(Now()))) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")))  AS MIN56
GROUP BY "55 �vn�l id�sebbek l�tsz�ma:";

-- [lkAdatv�ltoz�siIg�nyekElb�r�latlanok]
SELECT lkSzem�lyek.F�oszt�ly AS F�oszt�ly, lkSzem�lyek.Oszt�ly AS Oszt�ly, lkAdatv�ltoztat�siIg�nyek.[Dolgoz� neve] AS N�v, lkAdatv�ltoztat�siIg�nyek.�llapot AS �llapot, lkAdatv�ltoztat�siIg�nyek.Adatk�r, dt�tal([Ig�ny d�tuma]) AS [Ig�ny kelte], kt_azNexon_Ad�jel02.NLink AS NLink
FROM (lkAdatv�ltoztat�siIg�nyek LEFT JOIN lkSzem�lyek ON lkAdatv�ltoztat�siIg�nyek.Ad�jel = lkSzem�lyek.Ad�jel) LEFT JOIN kt_azNexon_Ad�jel02 ON lkAdatv�ltoztat�siIg�nyek.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel
WHERE (((lkAdatv�ltoztat�siIg�nyek.�llapot)="Elb�r�latlan"))
ORDER BY lkSzem�lyek.BFKH, lkAdatv�ltoztat�siIg�nyek.[Dolgoz� neve], lkSzem�lyek.[St�tusz k�dja];

-- [lkAdatv�ltoz�siIg�nyekElb�r�latlanokUNIXtime]
SELECT lkSzem�lyek.F�oszt�ly AS F�oszt�ly, lkSzem�lyek.Oszt�ly AS Oszt�ly, lkAdatv�ltoztat�siIg�nyek.[Dolgoz� neve] AS N�v, lkAdatv�ltoztat�siIg�nyek.�llapot AS �llapot, lkAdatv�ltoztat�siIg�nyek.Adatk�r, Format(DateAdd("s",[Ig�ny d�tuma]/1000,#1/1/1970#),"yyyy/mm/dd") AS [Ig�ny kelte], kt_azNexon_Ad�jel02.NLink AS NLink
FROM (lkAdatv�ltoztat�siIg�nyek LEFT JOIN lkSzem�lyek ON lkAdatv�ltoztat�siIg�nyek.Ad�jel = lkSzem�lyek.Ad�jel) LEFT JOIN kt_azNexon_Ad�jel02 ON lkAdatv�ltoztat�siIg�nyek.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel
WHERE (((lkAdatv�ltoztat�siIg�nyek.�llapot)="Elb�r�latlan"))
ORDER BY lkSzem�lyek.BFKH, lkAdatv�ltoztat�siIg�nyek.[Dolgoz� neve], lkSzem�lyek.[St�tusz k�dja];

-- [lkAdatv�ltoztat�siIg�nyek]
SELECT tAdatv�ltoztat�siIg�nyek.Azonos�t�, tAdatv�ltoztat�siIg�nyek.[Dolgoz� neve], tAdatv�ltoztat�siIg�nyek.[Ad�azonos�t� jel], tAdatv�ltoztat�siIg�nyek.Adatk�r, tAdatv�ltoztat�siIg�nyek.[Ig�ny d�tuma], tAdatv�ltoztat�siIg�nyek.�llapot, tAdatv�ltoztat�siIg�nyek.[Elb�r�l�s d�tuma], tAdatv�ltoztat�siIg�nyek.Elb�r�l�, [Ad�azonos�t� jel]*1 AS Ad�jel
FROM tAdatv�ltoztat�siIg�nyek;

-- [lkAdHocKer�letek01]
SELECT DISTINCT Switch([V�gzetts�g neve] Like "*tiszti*orvos*","tisztiorvos",[V�gzetts�g neve] Like "*v�d�n�*","v�d�n�",[V�gzetts�g neve] Like "*j�rv�ny�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*k�zeg�szs�g�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*n�peg�szs�g�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*eg�szs�gnevel�*","eg�szs�gnevel�",[KIRA feladat megnevez�s]="N�peg�szs�g�gyi feladatok, tisztif�orvos, tisztiorvos","tisztiorvos") AS Csoport, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[KIRA feladat megnevez�s], Replace([V�gzetts�gei],"nem ismert, ","") AS V�gzetts�ge, [Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40 AS Illetm�ny
FROM lkDolgoz�kV�gzetts�geiFelsorol�s04 RIGHT JOIN (lkV�gzetts�gek RIGHT JOIN lkSzem�lyek ON lkV�gzetts�gek.Ad�jel = lkSzem�lyek.Ad�jel) ON lkDolgoz�kV�gzetts�geiFelsorol�s04.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((Switch([V�gzetts�g neve] Like "*tiszti*orvos*","tisztiorvos",[V�gzetts�g neve] Like "*v�d�n�*","v�d�n�",[V�gzetts�g neve] Like "*j�rv�ny�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*k�zeg�szs�g�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*n�peg�szs�g�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*eg�szs�gnevel�*","eg�szs�gnevel�",[KIRA feladat megnevez�s]="N�peg�szs�g�gyi feladatok, tisztif�orvos, tisztiorvos","tisztiorvos")) Is Not Null) AND ((lkSzem�lyek.F�oszt�ly) Like "* II.*")) OR (((Switch([V�gzetts�g neve] Like "*tiszti*orvos*","tisztiorvos",[V�gzetts�g neve] Like "*v�d�n�*","v�d�n�",[V�gzetts�g neve] Like "*j�rv�ny�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*k�zeg�szs�g�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*n�peg�szs�g�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*eg�szs�gnevel�*","eg�szs�gnevel�",[KIRA feladat megnevez�s]="N�peg�szs�g�gyi feladatok, tisztif�orvos, tisztiorvos","tisztiorvos")) Is Not Null) AND ((lkSzem�lyek.F�oszt�ly) Like "* V.*")) OR (((Switch([V�gzetts�g neve] Like "*tiszti*orvos*","tisztiorvos",[V�gzetts�g neve] Like "*v�d�n�*","v�d�n�",[V�gzetts�g neve] Like "*j�rv�ny�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*k�zeg�szs�g�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*n�peg�szs�g�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*eg�szs�gnevel�*","eg�szs�gnevel�",[KIRA feladat megnevez�s]="N�peg�szs�g�gyi feladatok, tisztif�orvos, tisztiorvos","tisztiorvos")) Is Not Null) AND ((lkSzem�lyek.F�oszt�ly) Like "* VI.*")) OR (((Switch([V�gzetts�g neve] Like "*tiszti*orvos*","tisztiorvos",[V�gzetts�g neve] Like "*v�d�n�*","v�d�n�",[V�gzetts�g neve] Like "*j�rv�ny�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*k�zeg�szs�g�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*n�peg�szs�g�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*eg�szs�gnevel�*","eg�szs�gnevel�",[KIRA feladat megnevez�s]="N�peg�szs�g�gyi feladatok, tisztif�orvos, tisztiorvos","tisztiorvos")) Is Not Null) AND ((lkSzem�lyek.F�oszt�ly) Like "* X.*")) OR (((Switch([V�gzetts�g neve] Like "*tiszti*orvos*","tisztiorvos",[V�gzetts�g neve] Like "*v�d�n�*","v�d�n�",[V�gzetts�g neve] Like "*j�rv�ny�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*k�zeg�szs�g�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*n�peg�szs�g�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*eg�szs�gnevel�*","eg�szs�gnevel�",[KIRA feladat megnevez�s]="N�peg�szs�g�gyi feladatok, tisztif�orvos, tisztiorvos","tisztiorvos")) Is Not Null) AND ((lkSzem�lyek.F�oszt�ly) Like "* XI.*")) OR (((Switch([V�gzetts�g neve] Like "*tiszti*orvos*","tisztiorvos",[V�gzetts�g neve] Like "*v�d�n�*","v�d�n�",[V�gzetts�g neve] Like "*j�rv�ny�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*k�zeg�szs�g�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*n�peg�szs�g�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*eg�szs�gnevel�*","eg�szs�gnevel�",[KIRA feladat megnevez�s]="N�peg�szs�g�gyi feladatok, tisztif�orvos, tisztiorvos","tisztiorvos")) Is Not Null) AND ((lkSzem�lyek.F�oszt�ly) Like "* XIV.*")) OR (((Switch([V�gzetts�g neve] Like "*tiszti*orvos*","tisztiorvos",[V�gzetts�g neve] Like "*v�d�n�*","v�d�n�",[V�gzetts�g neve] Like "*j�rv�ny�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*k�zeg�szs�g�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*n�peg�szs�g�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*eg�szs�gnevel�*","eg�szs�gnevel�",[KIRA feladat megnevez�s]="N�peg�szs�g�gyi feladatok, tisztif�orvos, tisztiorvos","tisztiorvos")) Is Not Null) AND ((lkSzem�lyek.F�oszt�ly) Like "* XXI.*")) OR (((lkSzem�lyek.F�oszt�ly) Like "* II.*") AND ((lkSzem�lyek.[KIRA feladat megnevez�s]) Like "*tiszti*orvos*" And (lkSzem�lyek.[KIRA feladat megnevez�s])<>"F�oszt�lyvezet�i feladatok (t�bb szakmai ter�letet mag�ban foglal� szervezeti egys�gekn�l, ha nem f��llatorvos vagy tisztif�orvos)")) OR (((lkSzem�lyek.F�oszt�ly) Like "* V.*") AND ((lkSzem�lyek.[KIRA feladat megnevez�s]) Like "*tiszti*orvos*" And (lkSzem�lyek.[KIRA feladat megnevez�s])<>"F�oszt�lyvezet�i feladatok (t�bb szakmai ter�letet mag�ban foglal� szervezeti egys�gekn�l, ha nem f��llatorvos vagy tisztif�orvos)")) OR (((lkSzem�lyek.F�oszt�ly) Like "* VI.*") AND ((lkSzem�lyek.[KIRA feladat megnevez�s]) Like "*tiszti*orvos*" And (lkSzem�lyek.[KIRA feladat megnevez�s])<>"F�oszt�lyvezet�i feladatok (t�bb szakmai ter�letet mag�ban foglal� szervezeti egys�gekn�l, ha nem f��llatorvos vagy tisztif�orvos)")) OR (((lkSzem�lyek.F�oszt�ly) Like "* X.*") AND ((lkSzem�lyek.[KIRA feladat megnevez�s]) Like "*tiszti*orvos*" And (lkSzem�lyek.[KIRA feladat megnevez�s])<>"F�oszt�lyvezet�i feladatok (t�bb szakmai ter�letet mag�ban foglal� szervezeti egys�gekn�l, ha nem f��llatorvos vagy tisztif�orvos)")) OR (((lkSzem�lyek.F�oszt�ly) Like "* XI.*") AND ((lkSzem�lyek.[KIRA feladat megnevez�s]) Like "*tiszti*orvos*" And (lkSzem�lyek.[KIRA feladat megnevez�s])<>"F�oszt�lyvezet�i feladatok (t�bb szakmai ter�letet mag�ban foglal� szervezeti egys�gekn�l, ha nem f��llatorvos vagy tisztif�orvos)")) OR (((lkSzem�lyek.F�oszt�ly) Like "* XIV.*") AND ((lkSzem�lyek.[KIRA feladat megnevez�s]) Like "*tiszti*orvos*" And (lkSzem�lyek.[KIRA feladat megnevez�s])<>"F�oszt�lyvezet�i feladatok (t�bb szakmai ter�letet mag�ban foglal� szervezeti egys�gekn�l, ha nem f��llatorvos vagy tisztif�orvos)")) OR (((lkSzem�lyek.F�oszt�ly) Like "* XXI.*") AND ((lkSzem�lyek.[KIRA feladat megnevez�s]) Like "*tiszti*orvos*" And (lkSzem�lyek.[KIRA feladat megnevez�s])<>"F�oszt�lyvezet�i feladatok (t�bb szakmai ter�letet mag�ban foglal� szervezeti egys�gekn�l, ha nem f��llatorvos vagy tisztif�orvos)"))
ORDER BY Switch([V�gzetts�g neve] Like "*tiszti*orvos*","tisztiorvos",[V�gzetts�g neve] Like "*v�d�n�*","v�d�n�",[V�gzetts�g neve] Like "*j�rv�ny�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*k�zeg�szs�g�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*n�peg�szs�g�gyi*","j�rv�ny�gyifel�gyel�",[V�gzetts�g neve] Like "*eg�szs�gnevel�*","eg�szs�gnevel�",[KIRA feladat megnevez�s]="N�peg�szs�g�gyi feladatok, tisztif�orvos, tisztiorvos","tisztiorvos");

-- [lkAdHocKer�letek02]
SELECT DISTINCT lkAdHocKer�letek01.Ad�jel, lkAdHocKer�letek01.N�v, lkAdHocKer�letek01.[KIRA feladat megnevez�s], lkAdHocKer�letek01.F�oszt�ly, lkAdHocKer�letek01.Csoport
FROM lkAdHocKer�letek01
ORDER BY lkAdHocKer�letek01.N�v;

-- [lkAdott�vi�sszesIlletm�ny]
SELECT DISTINCT lk�llom�nyt�bl�kT�rt�netiUni�ja.F�oszt AS F�oszt�ly, lk�llom�nyt�bl�kT�rt�netiUni�ja.Oszt�ly, lk�llom�nyt�bl�kT�rt�netiUni�ja.[Besorol�si fokozat megnevez�se:] AS Besorol�s, lk�llom�nyt�bl�kT�rt�netiUni�ja.N�v, lk�llom�nyt�bl�kT�rt�netiUni�ja.Ad�azonos�t�, [Havi illetm�ny]/IIf([Heti munka�r�k sz�ma]=0,40,[heti munka�r�k sz�ma])*40 AS Illetm�ny, tHaviJelent�sHat�lya1.hat�lya
FROM lk�llom�nyt�bl�kT�rt�netiUni�ja INNER JOIN tHaviJelent�sHat�lya1 ON lk�llom�nyt�bl�kT�rt�netiUni�ja.hat�lyaID = tHaviJelent�sHat�lya1.hat�lyaID
WHERE (((tHaviJelent�sHat�lya1.hat�lya)>#12/31/2023# And (tHaviJelent�sHat�lya1.hat�lya)<#1/1/2025#) AND ((lk�llom�nyt�bl�kT�rt�netiUni�ja.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s"));

-- [lkAdott�vi�sszesIlletm�ny01]
SELECT lkAdott�vi�sszesIlletm�ny.F�oszt�ly, lkAdott�vi�sszesIlletm�ny.Oszt�ly, lkAdott�vi�sszesIlletm�ny.Besorol�s, lkAdott�vi�sszesIlletm�ny.N�v, lkAdott�vi�sszesIlletm�ny.Ad�azonos�t�, Avg(lkAdott�vi�sszesIlletm�ny.Illetm�ny) AS [AvgOfHavi illetm�ny], dt�tal(Year([hat�lya]) & "." & Month([hat�lya])) AS Kif1
FROM lkAdott�vi�sszesIlletm�ny
WHERE (((lkAdott�vi�sszesIlletm�ny.[Illetm�ny])<>0) AND ((lkAdott�vi�sszesIlletm�ny.Besorol�s) Not Like "*oszt�lyvezet�*" And (lkAdott�vi�sszesIlletm�ny.Besorol�s) Not Like "*J�r�si hivatalvezet�*" And (lkAdott�vi�sszesIlletm�ny.Besorol�s) Not Like "*igazgat�*" And (lkAdott�vi�sszesIlletm�ny.Besorol�s)<>"f�isp�n") AND ((lkAdott�vi�sszesIlletm�ny.Oszt�ly)<>"Korm�nymegb�zott"))
GROUP BY lkAdott�vi�sszesIlletm�ny.F�oszt�ly, lkAdott�vi�sszesIlletm�ny.Oszt�ly, lkAdott�vi�sszesIlletm�ny.Besorol�s, lkAdott�vi�sszesIlletm�ny.N�v, lkAdott�vi�sszesIlletm�ny.Ad�azonos�t�, dt�tal(Year([hat�lya]) & "." & Month([hat�lya]));

-- [lkAGy�monJelenlegDolgoz�k]
SELECT lkSzem�lyek.Ad�jel, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.F�oszt�ly AS [Jelenlegi f�oszt�lya], lkSzem�lyek.Oszt�ly AS [Jelenlegi oszt�lya], Bel�p�kUni�.F�oszt�ly, Bel�p�kUni�.Oszt�ly, Bel�p�kUni�.[Jogviszony kezd� d�tuma] AS Bel�p�s, lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)] AS Kil�p�s
FROM (Select * FROM lkBel�p�kUni� 
UNION SELECT Bel�p�k.*, IIf([Megyei szint VAGY J�r�si Hivatal]="megyei szint",[Mez�5],[Megyei szint VAGY J�r�si Hivatal]) AS F�oszt�ly, Bel�p�k.Mez�6 AS Oszt�ly, [ad�azonos�t�]*1 AS Ad�jel
FROM Bel�p�k
)  AS Bel�p�kUni� RIGHT JOIN lkSzem�lyek ON Bel�p�kUni�.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.F�oszt�ly) Like "Gy�m*") AND ((lkSzem�lyek.Oszt�ly) Like "*gy�m*") AND ((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])>#1/1/2019#));

-- [lkAIKiosk01]
SELECT tAIKiosk02.Azonos�t�, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.Ad�jel, lkSzem�lyek.[Szervezeti egys�g k�dja], tAIKiosk02.F�oszt�ly
FROM lkSzem�lyek, tAIKiosk02
WHERE (((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null) And ((Trim(Replace([Dolgoz� teljes neve],"dr.",""))) Like "*" & Trim(Replace([N�v],"dr.","")) & "*") And ((tAIKiosk02.F�oszt�ly)=lkSzem�lyek.F�oszt�ly))
ORDER BY tAIKiosk02.Azonos�t�;

-- [lkAIKiosk01b]
SELECT lkAIKiosk01.Azonos�t�, Count(lkAIKiosk01.Azonos�t�) AS db
FROM lkAIKiosk01
GROUP BY lkAIKiosk01.Azonos�t�;

-- [lkAIKiosk02]
SELECT DISTINCT tAIKiosk02.F�oszt�ly, tAIKiosk02.Oszt�ly, tAIKiosk02.N�v, IIf(Nz([db],0)<>1,"Ez az adat nem azonos�that� egy�rtelm�en, " & Nz([db],0) & " azonos eredm�ny tal�lhat�.","Bizonytalans�g foka (L.t�v.):" & Ls([N�v],[lkSzem�lyek].[Dolgoz� teljes neve])) AS Megjegyz�s, IIf(Nz([db],0)=1,[lkSzem�lyek].[Dolgoz� teljes neve],"") AS Neve, IIf(Nz([db],0)=1,[lkSzem�lyek].[Dolgoz� sz�let�si neve],"") AS [Sz�let�si n�v], IIf(Nz([db],0)=1,[Sz�let�si hely] & ", " & [Sz�let�si id�],"") AS [Sz�let�si hely \ id�], IIf(Nz([db],0)=1,[Anyja neve],"") AS Anyja_neve, IIf(Nz([db],0)=1,[lkSzem�lyek].[Ad�jel],0) AS Ad�, IIf(Nz([db],0)=1,[TAJ sz�m],"") AS TAJ, IIf(Nz([db],0)=1,[�lland� lakc�m],"") AS Lakc�m, lkSzem�lyek.[St�tusz k�dja], lkSzem�lyek.[Besorol�si  fokozat (KT)], lkSzem�lyek.[Kerek�tett 100 %-os illetm�ny (elt�r�tett)]
FROM lkSzem�lyek RIGHT JOIN ((lkAIKiosk01 RIGHT JOIN tAIKiosk02 ON lkAIKiosk01.Azonos�t� = tAIKiosk02.Azonos�t�) LEFT JOIN lkAIKiosk01b ON tAIKiosk02.Azonos�t� = lkAIKiosk01b.Azonos�t�) ON lkSzem�lyek.Ad�jel = lkAIKiosk01.Ad�jel
WHERE (((tAIKiosk02.F�oszt�ly)=[lkSzem�lyek].[F�oszt�ly]))
ORDER BY tAIKiosk02.Oszt�ly;

-- [lkAlapadatok]
SELECT tAlapadatok.azAlapadat, tAlapadatok.Tulajdons�gNeve, tAlapadatok.Tulajdons�g�rt�k, tAlapadatok.Objektum, tAlapadatok.ObjektumT�pus
FROM tAlapadatok
WHERE (((tAlapadatok.Tulajdons�gNeve) Like "*" & [TempVars]![TulNeve] & "*") AND ((tAlapadatok.Objektum) Like "*" & [TempVars]![Obj] & "*") AND ((tAlapadatok.ObjektumT�pus) Like "*" & [TempVars]![ObjTip] & "*"));

-- [lkAlapl�tsz�mIlletm�nyek]
SELECT Alapl�tsz�m.[j�r�si hivatal] AS [F�oszt�ly\hivatal], Alapl�tsz�m.Ad�azonos�t�, Alapl�tsz�m.N�v, Alapl�tsz�m.[�ll�shely azonos�t�], Alapl�tsz�m.[Besorol�si fokozat megnevez�se:], Alapl�tsz�m.[Heti munka�r�k sz�ma], Alapl�tsz�m.Mez�18, Round([Mez�18]/[Heti munka�r�k sz�ma]*40,0) AS [40 �r�ra vet�tett illetm�ny], IIf(InStr(1,[Besorol�si fokozat k�d:],"Mt."),"Mt.","Kit.") AS [Folgalkoztat�s jellege], Alapl�tsz�m.mez�4 AS Bet�lt�s
FROM (SELECT [j�r�si hivatal], J�r�si_�llom�ny.Ad�azonos�t�, N�v, J�r�si_�llom�ny.[�ll�shely azonos�t�], [Besorol�si fokozat megnevez�se:], J�r�si_�llom�ny.[Heti munka�r�k sz�ma], J�r�si_�llom�ny.Mez�18, [Besorol�si fokozat k�d:], mez�4
FROM J�r�si_�llom�ny
UNION
SELECT Mez�6,Korm�nyhivatali_�llom�ny.Ad�azonos�t�, N�v, [�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.[Besorol�si fokozat megnevez�se:], Korm�nyhivatali_�llom�ny.[Heti munka�r�k sz�ma], Korm�nyhivatali_�llom�ny.Mez�18, [Besorol�si fokozat k�d:], mez�4
FROM Korm�nyhivatali_�llom�ny

)  AS Alapl�tsz�m
WHERE (((Alapl�tsz�m.[Besorol�si fokozat megnevez�se:]) Like "*hivatali tan�csos*"));

-- [lkAlapvizsgaSzakvizsga]
SELECT tSzem�lyek.[Dolgoz� teljes neve], Replace(IIf(IsNull([tSzem�lyek].[Szint 4 szervezeti egys�g n�v]),[tSzem�lyek].[Szint 3 szervezeti egys�g n�v] & "",[tSzem�lyek].[Szint 4 szervezeti egys�g n�v] & ""),"Budapest F�v�ros Korm�nyhivatala ","BFKH ") AS F�oszt�ly, tSzem�lyek.[Szervezeti egys�g neve], tSzem�lyek.[Alapvizsga k�telez�s d�tuma], tSzem�lyek.[Alapvizsga let�tel t�nyleges hat�rideje], tSzem�lyek.[Alapvizsga mentess�g], tSzem�lyek.[Alapvizsga mentess�g oka], tSzem�lyek.[Szakvizsga k�telez�s d�tuma], tSzem�lyek.[Szakvizsga let�tel t�nyleges hat�rideje], tSzem�lyek.[Szakvizsga mentess�g]
FROM tSzem�lyek;

-- [lkALegut�bbiBesorol�sv�ltoz�ssal�rintett�ll�shelyekBet�lt�i]
SELECT lkJ�r�siKorm�nyK�zpontos�tottUni�.F�oszt�ly, lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly, lkJ�r�siKorm�nyK�zpontos�tottUni�.N�v, lkBesorol�sV�ltoztat�sok2.�ll�shelyAzonos�t�, lkBesorol�sV�ltoztat�sok2.R�giBesorol�s, lkBesorol�sV�ltoztat�sok2.�jBesorol�s
FROM lkJ�r�siKorm�nyK�zpontos�tottUni� RIGHT JOIN lkBesorol�sV�ltoztat�sok2 ON lkJ�r�siKorm�nyK�zpontos�tottUni�.[�ll�shely azonos�t�] = lkBesorol�sV�ltoztat�sok2.�ll�shelyAzonos�t�
WHERE (((lkBesorol�sV�ltoztat�sok2.Hat�ly)=(select max(Hat�ly) from [tBesorol�sV�ltoztat�sok])))
ORDER BY bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]);

-- [lk�ll�shelyAzonos�t�kHavib�l]
SELECT J�r�si_�llom�ny.[�ll�shely azonos�t�] As �ll�shely FROM J�r�si_�llom�ny UNION 
SELECT Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�] As �ll�shely FROM Korm�nyhivatali_�llom�ny UNION SELECT K�zpontos�tottak.[�ll�shely azonos�t�] As �ll�shely  FROM K�zpontos�tottak;

-- [lk�ll�shelyBesorol�sElt�r�s]
SELECT DISTINCT Uni�.n�v, Uni�.�ll�shely, �ll�shelyek.[�ll�shely besorol�si kateg�ri�ja] AS �NYR, tBesorol�s_�talak�t�.Besorol�s, tBesorol�s_�talak�t�.Besorol�si_fokozat, Uni�.T�bla
FROM �ll�shelyek RIGHT JOIN ((SELECT J�r�si_�llom�ny.N�v, J�r�si_�llom�ny.[�ll�shely azonos�t�] As �ll�shely, [Besorol�si fokozat k�d:] as besorol�s, "J�r�si" as T�bla FROM J�r�si_�llom�ny UNION SELECT Korm�nyhivatali_�llom�ny.N�v, Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�] As �ll�shely, [Besorol�si fokozat k�d:] as besorol�s, "Korm�nyhivatali" as T�bla FROM Korm�nyhivatali_�llom�ny UNION SELECT K�zpontos�tottak.N�v, K�zpontos�tottak.[�ll�shely azonos�t�] As �ll�shely, [Besorol�si fokozat k�d:] as besorol�s, "K�zpontos�tottak" as T�bla FROM K�zpontos�tottak )  AS Uni� LEFT JOIN tBesorol�s_�talak�t� ON Uni�.besorol�s = tBesorol�s_�talak�t�.[Az �ll�shely jel�l�se]) ON �ll�shelyek.[�ll�shely azonos�t�] = Uni�.�ll�shely
WHERE (((�ll�shelyek.[�ll�shely besorol�si kateg�ri�ja]) Not Like [tBesorol�s_�talak�t�].[Besorol�si_fokozat]));

-- [lk�ll�shelyek]
SELECT Replace(IIf(Nz([4 szint],"")="",IIf(Nz([3 szint],"")="",IIf(Nz([2 szint],"")="",Nz([1 szint],""),Nz([2 szint],"")),Nz([3 szint],"")),Nz([4 szint],"")),"Budapest F�v�ros Korm�nyhivatala ","BFKH ") AS F�oszt�ly�ll�shely, �ll�shelyek.[5 szint] AS Oszt�ly, Nz(Switch([F�oszt�ly�ll�shely]="V�delmi bizotts�g titk�rs�ga","F�isp�n",[F�oszt�ly�ll�shely]="F�igazgat�i titk�rs�g","F�igazgat�",[F�oszt�ly�ll�shely]="Bels� Ellen�rz�si Oszt�ly","F�isp�n"),[F�oszt�ly�ll�shely]) AS F�oszt, Nz(Switch([F�oszt�ly�ll�shely]="V�delmi bizotts�g titk�rs�ga",[F�oszt�ly�ll�shely],[F�oszt�ly�ll�shely]="F�igazgat�i titk�rs�g",[F�oszt�ly�ll�shely],[F�oszt�ly�ll�shely]="Bels� Ellen�rz�si Oszt�ly",[F�oszt�ly�ll�shely]),[Oszt�ly]) AS Oszt, �ll�shelyek.*, tBesorol�s�talak�t�Elt�r�Besorol�shoz.[Besorol�si  fokozat (KT)], tBesorol�s�talak�t�Elt�r�Besorol�shoz.rang, tBesorol�s�talak�t�Elt�r�Besorol�shoz.jel, IIf([�ll�shely st�tusza]="bet�ltetlen","��." & [jel],IIf([�ll�shelyen fenn�ll� jogviszony] Like "Munka*","Mt." & [jel],[jel])) AS jel2
FROM tBesorol�s�talak�t�Elt�r�Besorol�shoz RIGHT JOIN �ll�shelyek ON tBesorol�s�talak�t�Elt�r�Besorol�shoz.[�ll�shely besorol�si kateg�ri�ja] = �ll�shelyek.[�ll�shely besorol�si kateg�ri�ja];

-- [lk�ll�shelyek(havi)]
SELECT Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�], Uni�.F�oszt�ly, Uni�.Oszt�ly, Uni�.[�ll�shely azonos�t�], Uni�.�llapot, Uni�.mez�9 AS Feladatk�r
FROM (SELECT [�ll�shely azonos�t�], Mez�4, [Besorol�si fokozat megnevez�se:], [�NYR SZERVEZETI EGYS�G AZONOS�T�], IIf(Instr(1,[Besorol�si fokozat k�d:],"��"),"�res","bet�lt�tt") as �llapot, mez�9    , [J�r�si Hivatal] as F�oszt�ly, Mez�7 as Oszt�ly                                           FROM J�r�si_�llom�ny              UNION SELECT [�ll�shely azonos�t�], Mez�4, [Besorol�si fokozat megnevez�se:], [�NYR SZERVEZETI EGYS�G AZONOS�T�], IIf(Instr(1,[Besorol�si fokozat k�d:],"��"),"�res","bet�lt�tt") as �llapot, mez�9 , mez�6 as F�oszt�ly, Mez�7 as Oszt�ly FROM Korm�nyhivatali_�llom�ny            UNION SELECT [�ll�shely azonos�t�], Mez�4, [Besorol�si fokozat megnevez�se:], [Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�], IIf(Instr(1,[Besorol�si fokozat k�d:],"��"),"�res","bet�lt�tt") as �llapot, Mez�10,  Replace(     IIf(         [Megyei szint VAGY J�r�si Hivatal]="Megyei szint",         [Mez�6],         [Megyei szint VAGY J�r�si Hivatal]         ),     "Budapest F�v�ros Korm�nyhivatala ",     "BFKH "     ) AS F�oszt, mez�7 as Oszt�ly FROM K�zpontos�tottak                                              )  AS Uni�
ORDER BY Bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]);

-- [lk�ll�shelyek_Alapl�tsz�m]
SELECT Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�], [Szint5 - le�r�s] & [Szint6 - le�r�s] AS [F�oszt�ly\Hivatal], Uni�.[�ll�shely azonos�t�], Uni�.�llapot
FROM tSzervezeti RIGHT JOIN (SELECT [�ll�shely azonos�t�], Mez�4, [Besorol�si fokozat megnevez�se:], [�NYR SZERVEZETI EGYS�G AZONOS�T�], IIf(Instr(1,[Besorol�si fokozat k�d:],"��"),"�res","bet�lt�tt") as �llapot                        FROM J�r�si_�llom�ny             UNION SELECT [�ll�shely azonos�t�], Mez�4, [Besorol�si fokozat megnevez�se:], [�NYR SZERVEZETI EGYS�G AZONOS�T�], IIf(Instr(1,[Besorol�si fokozat k�d:],"��"),"�res","bet�lt�tt") as �llapot                        FROM Korm�nyhivatali_�llom�ny      )  AS Uni� ON tSzervezeti.[Szervezetmenedzsment k�d]=Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
ORDER BY Bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]);

-- [lk�ll�shelyek�llapot�nak�sszevet�se_Havi_�nyr01]
SELECT �ll�shelyek.[�ll�shely azonos�t�], �ll�shelyek.[�ll�shely t�pusa], IIf([�ll�shely st�tusza] Like "*tart�san t�voll�v�*","bet�lt�tt",[�ll�shely st�tusza]) AS �nyr, IIf([�llapot]="�res","bet�ltetlen",[�llapot]) AS Nexon, lk�ll�shelyek_Alapl�tsz�m.[�NYR SZERVEZETI EGYS�G AZONOS�T�] AS BFKHk�d
FROM lk�ll�shelyek_Alapl�tsz�m RIGHT JOIN �ll�shelyek ON lk�ll�shelyek_Alapl�tsz�m.[�ll�shely azonos�t�]=�ll�shelyek.[�ll�shely azonos�t�];

-- [lk�ll�shelyek�llapot�nak�sszevet�se_Havi_�nyr02]
SELECT lk_F�oszt�ly_Oszt�ly_tSzervezet.F�oszt AS F�oszt�ly, lk_F�oszt�ly_Oszt�ly_tSzervezet.Oszt�ly AS Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lk�ll�shelyek�llapot�nak�sszevet�se_Havi_�nyr01.[�ll�shely azonos�t�] AS [St�tusz k�d], lk�ll�shelyek�llapot�nak�sszevet�se_Havi_�nyr01.�nyr AS �nyr, lk�ll�shelyek�llapot�nak�sszevet�se_Havi_�nyr01.Nexon AS Nexon, kt_azNexon_Ad�jel02.NLink AS NLink
FROM (lk_F�oszt�ly_Oszt�ly_tSzervezet RIGHT JOIN (lkSzem�lyek RIGHT JOIN lk�ll�shelyek�llapot�nak�sszevet�se_Havi_�nyr01 ON lkSzem�lyek.[St�tusz k�dja] = lk�ll�shelyek�llapot�nak�sszevet�se_Havi_�nyr01.[�ll�shely azonos�t�]) ON lk_F�oszt�ly_Oszt�ly_tSzervezet.[Szervezetmenedzsment k�d] = lk�ll�shelyek�llapot�nak�sszevet�se_Havi_�nyr01.BFKHk�d) LEFT JOIN kt_azNexon_Ad�jel02 ON lkSzem�lyek.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel
WHERE (((IIf([�nyr]<>[Nexon],1,0))<>0))
ORDER BY lk_F�oszt�ly_Oszt�ly_tSzervezet.bfkhk�d, lkSzem�lyek.[Dolgoz� teljes neve];

-- [lk�ll�shelyekBels�Eloszt�saF�oszt�lyOszt�ly]
SELECT t�ll�shelyekBels�Eloszt�saF�oszt�lyOszt�ly.azEloszt�s, Replace([F�oszt�ly],"Budapest F�v�ros Korm�nyhivatala","BFKH") AS F�oszt, t�ll�shelyekBels�Eloszt�saF�oszt�lyOszt�ly.Oszt�ly, t�ll�shelyekBels�Eloszt�saF�oszt�lyOszt�ly.[�ll�shely azonos�t�], t�ll�shelyekBels�Eloszt�saF�oszt�lyOszt�ly.Hat�ly
FROM t�ll�shelyekBels�Eloszt�saF�oszt�lyOszt�ly
WHERE (((t�ll�shelyekBels�Eloszt�saF�oszt�lyOszt�ly.azEloszt�s)=(Select Top 1 azEloszt�s from [t�ll�shelyekBels�Eloszt�saF�oszt�lyOszt�ly] as tmp Where tmp.[�ll�shely azonos�t�]=[t�ll�shelyekBels�Eloszt�saF�oszt�lyOszt�ly].[�ll�shely azonos�t�] Order By  tmp.hat�ly Desc)));

-- [lk�ll�shelyekBesorol�siJeleHavihoz]
SELECT lk�ll�shelyek.[�ll�shely azonos�t�], lk�ll�shelyek.jel, lk�ll�shelyek.jel2
FROM lk�ll�shelyek;

-- [lk�ll�shelyekHavib�l]
SELECT Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�], [Szint5 - le�r�s] & [Szint6 - le�r�s] AS [F�oszt�ly\Hivatal], Uni�.[�ll�shely azonos�t�], Uni�.[Besorol�si fokozat megnevez�se:], Uni�.Jelleg, Uni�.Mez�4, Uni�.[Besorol�si fokozat k�d:], Uni�.Kinevez�s AS [Bet�lt�sMeg�resed�s d�tuma], Uni�.TT, Replace([Szint5 - le�r�s] & [Szint6 - le�r�s], "Budapest F�v�ros Korm�nyhivatala", "BFKH") AS F�oszt, Oszt�ly
FROM tSzervezeti RIGHT JOIN (SELECT [�ll�shely azonos�t�]
		, Mez�4
		, [Besorol�si fokozat megnevez�se:]
		, [�NYR SZERVEZETI EGYS�G AZONOS�T�]
		, [Besorol�si fokozat k�d:]
		, "A" AS Jelleg
		, Mez�10 AS Kinevez�s
		, [Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h] AS TT
, Mez�7 as Oszt�ly
	FROM J�r�si_�llom�ny
	
	UNION
	
	SELECT [�ll�shely azonos�t�]
		, Mez�4
		, [Besorol�si fokozat megnevez�se:]
		, [�NYR SZERVEZETI EGYS�G AZONOS�T�]
		, [Besorol�si fokozat k�d:]
		, "A" AS Jelleg
		, Mez�10
		, [Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h] AS TT
, Mez�7 as Oszt�ly
	FROM Korm�nyhivatali_�llom�ny
	
	UNION
	
	SELECT [�ll�shely azonos�t�]
		, Mez�4
		, [Besorol�si fokozat megnevez�se:]
		, [Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�]
		, [Besorol�si fokozat k�d:]
		, "K" AS Jelleg
		, Mez�11
		, "" AS TT
, Mez�7 as Oszt�ly
	FROM K�zpontos�tottak
	)  AS Uni� ON tSzervezeti.[Szervezetmenedzsment k�d] = Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
ORDER BY Bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]);

-- [lk�ll�shelySt�tusz�sszevet�seNexon�nyr]
SELECT lk�ll�shelyek.F�oszt�ly�ll�shely, lk�ll�shelyek.[�ll�shely st�tusza] AS [�llapot �NYR], tBesorol�s_�talak�t�.�res, lk�ll�shelyek.[�ll�shely azonos�t�]
FROM (lk�ll�shelyek LEFT JOIN lk�ll�shelyekHavib�l ON lk�ll�shelyek.[�ll�shely azonos�t�] = lk�ll�shelyekHavib�l.[�ll�shely azonos�t�]) LEFT JOIN tBesorol�s_�talak�t� ON lk�ll�shelyekHavib�l.[Besorol�si fokozat k�d:] = tBesorol�s_�talak�t�.[Az �ll�shely jel�l�se];

-- [lk�ll�shelyT�bla_HaviL�tsz�mjelent�shez]
SELECT DISTINCT lk�ll�shelyek.[�ll�shely azonos�t�], lk�ll�shelyek.[�ll�shely besorol�si kateg�ri�ja], lk�ll�shelyek.jel2
FROM lk�ll�shelyek;

-- [lk�llom�nyEgyId�szakban_Kil�pettek]
SELECT lkKil�p�Uni�.Ad�azonos�t� AS Ad�jel, lkSzem�lyekMind.[Dolgoz� teljes neve], Nz([lkKil�p�Uni�].[F�oszt�ly],[lkSzem�lyekMind].[F�oszt�ly]) AS F�oszt, Nz([lkKil�p�Uni�].[Oszt�ly],[lkSzem�lyekMind].[Oszt�ly]) AS Oszt, ffsplit([Feladatk�r],"-",2) AS [Ell�tand� feladat], lkSzem�lyekMind.[Jogviszony kezdete (bel�p�s d�tuma)] AS Bel�p�s, lkSzem�lyekMind.[Jogviszony v�ge (kil�p�s d�tuma)] AS Kil�p�s
FROM lkKil�p�Uni� INNER JOIN lkSzem�lyekMind ON (lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja] = lkSzem�lyekMind.[Jogviszony v�ge (kil�p�s d�tuma)]) AND (lkKil�p�Uni�.Ad�jel = lkSzem�lyekMind.Ad�jel) AND (lkSzem�lyekMind.[Jogviszony kezdete (bel�p�s d�tuma)] = lkKil�p�Uni�.[Jogviszony kezd� d�tuma])
WHERE (((Nz(lkKil�p�Uni�.F�oszt�ly,lkSzem�lyekMind.F�oszt�ly)) Like "Hum�n*") And ((ffsplit([Feladatk�r],"-",2))<>"") And ((lkSzem�lyekMind.[Jogviszony kezdete (bel�p�s d�tuma)])<=[Az id�szak v�ge]) And ((lkSzem�lyekMind.[Jogviszony v�ge (kil�p�s d�tuma)])>=[Az id�szak kezdete]));

-- [lk�llom�nyt�blaEgyId�szakban_Bel�pettek]
SELECT lkBel�p�kUni�.Ad�azonos�t� AS Ad�jel, lkSzem�lyekMind.[Dolgoz� teljes neve], lkBel�p�kUni�.F�oszt�ly, lkBel�p�kUni�.Oszt�ly, ffsplit([Feladatk�r],"-",2) AS [Ell�tand� feladat], lkSzem�lyekMind.[Jogviszony kezdete (bel�p�s d�tuma)] AS Bel�p�s, lkSzem�lyekMind.[Jogviszony v�ge (kil�p�s d�tuma)] AS Kil�p�s
FROM lkSzem�lyekMind INNER JOIN lkBel�p�kUni� ON (lkSzem�lyekMind.[Jogviszony kezdete (bel�p�s d�tuma)] = lkBel�p�kUni�.[Jogviszony kezd� d�tuma]) AND (lkSzem�lyekMind.Ad�jel = lkBel�p�kUni�.Ad�jel)
WHERE (((lkBel�p�kUni�.F�oszt�ly) Like "*" & [Az �rintett f�oszt�ly] & "*") AND ((lkBel�p�kUni�.Oszt�ly) Like "*" & [Az �rintett oszt�ly] & "*") AND ((ffsplit([Feladatk�r],"-",2))<>"") AND ((lkSzem�lyekMind.[Jogviszony kezdete (bel�p�s d�tuma)])<=[Az id�szak v�ge]) AND ((lkSzem�lyekMind.[Jogviszony v�ge (kil�p�s d�tuma)])>=[Az id�szak kezdete]));

-- [lk�llom�nyt�bl�kT�rt�netiUni�ja]
SELECT Uni�.Sorsz�m, Uni�.N�v, Uni�.Ad�azonos�t�, Uni�.[Sz�let�si �v \ �res �ll�s], Uni�.[Nem], Uni�.F�oszt, Uni�.Oszt�ly, Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�], Uni�.[Ell�tott feladat], Uni�.Kinevez�s, Uni�.[Feladat jellege], Uni�.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ], Uni�.[Heti munka�r�k sz�ma], Uni�.[Bet�lt�s ar�nya], Uni�.[Besorol�si fokozat k�d:], Uni�.[Besorol�si fokozat megnevez�se:], Uni�.[�ll�shely azonos�t�], Uni�.[Havi illetm�ny], Uni�.[Eu finansz�rozott], Uni�.[Illetm�ny forr�sa], Uni�.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h], Uni�.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], Uni�.[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)], Uni�.[Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is], Uni�.[�gyf�lszolg�lati munkat�rs (1) �gyf�lszolg�lati h�tt�r munkat�rs], Uni�.[K�pes�t�st ad� v�gzetts�g], Uni�.KAB, Uni�.[KAB 001-3** Branch ID], Uni�.hat�lyaID
FROM (SELECT lktK�zpontos�tottak.*
FROM  lktK�zpontos�tottak
UNION
SELECT lktKorm�nyhivatali_�llom�ny.*
FROM lktKorm�nyhivatali_�llom�ny
UNION
SELECT lktJ�r�si_�llom�ny.*
FROM  lktJ�r�si_�llom�ny)  AS Uni�;

-- [lk�llom�nyUni�20230102_k�sz�t�]
SELECT lkJ�r�siKorm�nyK�zpontos�tottUni�.* INTO t�llom�nyUni�20230102
FROM lkJ�r�siKorm�nyK�zpontos�tottUni�;

-- [lk�llom�nyUni�20231231_k�sz�t�]
SELECT lkJ�r�siKorm�nyK�zpontos�tottUni�.* INTO t�llom�nyUni�20231231
FROM lkJ�r�siKorm�nyK�zpontos�tottUni�;

-- [lk�NYR]
SELECT �ll�shelyek.*
FROM �ll�shelyek;

-- [lkAPr�baid�K�zelg�Lej�rata]
SELECT DISTINCT lkSzem�lyek.F�oszt�ly AS F�oszt�ly, lkSzem�lyek.Oszt�ly AS Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[Hivatali email] AS [Hivatali email], lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge] AS [Pr�baid� v�ge], kt_azNexon_Ad�jel02.NLink
FROM kt_azNexon_Ad�jel02 RIGHT JOIN lkSzem�lyek ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge]) Between DateSerial(Year(Date()),Month(Date()),1) And DateSerial(Year(Date()),Month(Date())+1,1)-1) AND ((lkSzem�lyek.[St�tusz neve]) Like "�ll�shely"))
ORDER BY lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge];

-- [lkAPr�baid�K�zelg�Lej�rata03]
SELECT DISTINCT lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.F�oszt�ly AS F�oszt�ly, lkSzem�lyek.Oszt�ly AS Oszt�ly, lkSzem�lyek.[Hivatali email] AS [Hivatali email], lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge] AS [Pr�baid� v�ge], IIf(Nz([KIRA feladat megnevez�s],"") Like "�gykezel�i*","igen","nem") AS �gykezel�e, lkK�zigazgat�siVizsga.[Vizsga t�pusa] AS Vizsga, lkK�zigazgat�siVizsga.[Vizsga let�tel terv hat�rideje], lkK�zigazgat�siVizsga.[Oklev�l d�tuma], IIf([Mentess�g]=0,"HAMIS","IGAZ") AS Mentes, IIf([Jogviszony v�ge (kil�p�s d�tuma)]=0,"",[Jogviszony v�ge (kil�p�s d�tuma)]) AS [Jogviszony v�ge], kt_azNexon_Ad�jel02.NLink
FROM kt_azNexon_Ad�jel02 RIGHT JOIN (lkSzem�lyek LEFT JOIN lkK�zigazgat�siVizsga ON lkSzem�lyek.Ad�jel = lkK�zigazgat�siVizsga.Ad�jel) ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge]) Between DateSerial(Year(Date()),Month(Date())-1,1) And DateSerial(Year(Date()),Month(Date())+1,1)-1) AND ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])="Hivat�sos �llom�ny�" Or (lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])="Munkaviszony" Or (lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])="Korm�nyzati szolg�lati jogviszony"))
ORDER BY lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge];

-- [lk�tlag�letkor]
SELECT Eredm.Kif1 AS Kif2, #1/1/1867# AS Kif3, DateDiff("yyyy",[Kif2]+[Kif3],Now()) AS �tlag�letkor
FROM (SELECT Avg(Mid([Ad�jel],2,5)) AS Kif1, lkSzem�lyek.[St�tusz neve] FROM lkSzem�lyek GROUP BY lkSzem�lyek.[St�tusz neve] HAVING (((lkSzem�lyek.[St�tusz neve])="�ll�shely")))  AS Eredm;

-- [lk�tlag�letkorNemenk�nt]
SELECT Eredm.Kif1 AS Kif2, #1/1/1867# AS Kif3, DateDiff("yyyy",[Kif2]+[Kif3],Now()) AS �tlag�letkor, Eredm.Neme
FROM (SELECT Avg(Mid([Ad�jel],2,5)) AS Kif1, lkSzem�lyek.[St�tusz neve], lkSzem�lyek.Neme FROM lkSzem�lyek GROUP BY lkSzem�lyek.[St�tusz neve], lkSzem�lyek.Neme HAVING (((lkSzem�lyek.[St�tusz neve])="�ll�shely")))  AS Eredm;

-- [lk�tlagilletm�ny_vezet�kn�lk�l]
SELECT IIf([Jogviszony t�pusa / jogviszony t�pus]="Munkaviszony","Munkaviszony",[Besorol�si  fokozat (KT)]) AS Besorol�s, Sum([Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40) AS �sszilletm�ny, Count(lkIlletm�nyhez�tlag_vezet�kn�lk�l.[Ad�azonos�t� jel]) AS F�, Round(Avg([Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40)/100,0)*100 AS �tlag, Round(StDev([Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40)/100,0)*100 AS [�tlagt�l val� elt�r�s (StDev)]
FROM lkIlletm�nyhez�tlag_vezet�kn�lk�l RIGHT JOIN �ll�shelyek ON lkIlletm�nyhez�tlag_vezet�kn�lk�l.[St�tusz k�dja] = �ll�shelyek.[�ll�shely azonos�t�]
WHERE (((lkIlletm�nyhez�tlag_vezet�kn�lk�l.[Szervezeti egys�g k�dja]) Is Not Null) AND ((lkIlletm�nyhez�tlag_vezet�kn�lk�l.[St�tusz neve])="�ll�shely"))
GROUP BY IIf([Jogviszony t�pusa / jogviszony t�pus]="Munkaviszony","Munkaviszony",[Besorol�si  fokozat (KT)]);

-- [lk�tlagilletm�ny_vezet�kn�lk�l_Eredm�ny]
SELECT "�sszesen: " AS Besorol�s, Round(Sum([lk�tlagilletm�ny_vezet�kn�lk�l].[�sszilletm�ny])/100,0)*100 AS Mind�sszesen, Sum(lk�tlagilletm�ny_vezet�kn�lk�l.F�) AS �sszl�tsz�m, Round(Sum([�sszilletm�ny])/Sum([F�])/100,0)*100 AS �tlag, (SELECT Round(StDev([Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40)/100,0)*100 AS [�tlagt�l val� elt�r�s]
FROM lkSzem�lyek LEFT JOIN �ll�shelyek ON lkSzem�lyek.[St�tusz k�dja] = �ll�shelyek.[�ll�shely azonos�t�]
WHERE (((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))) AS [�tlagt�l val� elt�r�s]
FROM lk�tlagilletm�ny_vezet�kn�lk�l
GROUP BY "�sszesen: ";

-- [lk�tlagosHibajav�t�siId�k]
SELECT Replace(ffsplit([M�sodik mez�],"|",1),"Budapest F�v�ros Korm�nyhivatala","BFKH") AS F�oszt�ly, Avg(DateDiff("d",[els� id�pont],[utols� id�pont])) AS [�tlagos jav�t�siid�], Count(tR�giHib�k.[Els� mez�]) AS Hibasz�m
FROM tR�giHib�k
WHERE (((tR�giHib�k.lek�rdez�sNeve)<>"lkAPr�baid�K�zelg�Lej�rata" And (tR�giHib�k.lek�rdez�sNeve)<>"lkElv�gzend�Besoroltat�sok02_r�gi" And (tR�giHib�k.lek�rdez�sNeve)<>"lk_jogviszony_jellege_02_r�gi" And (tR�giHib�k.lek�rdez�sNeve)<>"lkLej�rtAlkalmass�gi�rv�nyess�g" And (tR�giHib�k.lek�rdez�sNeve)<>"lk�res�ll�shelyek�llapotfelm�r�") AND ((tR�giHib�k.[Els� Id�pont])<>[Utols� Id�pont]))
GROUP BY Replace(ffsplit([M�sodik mez�],"|",1),"Budapest F�v�ros Korm�nyhivatala","BFKH")
HAVING (((Replace(ffsplit([M�sodik mez�],"|",1),"Budapest F�v�ros Korm�nyhivatala","BFKH"))<>"S-049058" And (Replace(ffsplit([M�sodik mez�],"|",1),"Budapest F�v�ros Korm�nyhivatala","BFKH"))<>"" And (Replace(ffsplit([M�sodik mez�],"|",1),"Budapest F�v�ros Korm�nyhivatala","BFKH"))<>"-" And (Replace(ffsplit([M�sodik mez�],"|",1),"Budapest F�v�ros Korm�nyhivatala","BFKH"))<>"S-045728" And (Replace(ffsplit([M�sodik mez�],"|",1),"Budapest F�v�ros Korm�nyhivatala","BFKH"))<>"N�r�th Andrea Dr.") AND (("Utols� Id�pont")<>(select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve <>"lk�res�ll�shelyek�llapotfelm�r�" And lek�rdez�sneve <>"lkFontosHi�nyz�Adatok02")))
ORDER BY Avg(DateDiff("d",[els� id�pont],[utols� id�pont])) DESC;

-- [lkAzElm�ltT�zNap]
SELECT DateSerial(Year(Now()),Month(Now()),Day(Now())-([Sorsz�m]-1)) AS D�tum
FROM lkSorsz�mok
WHERE (((lkSorsz�mok.Sorsz�m)<10));

-- [lkBeKil�p�k01]
SELECT BeKil�p�k.Kil�p�s�ve AS �v, BeKil�p�k.Kil�p�sHava AS H�, Sum(BeKil�p�k.Bel�p�k) AS SumOfBel�p�k, Sum(BeKil�p�k.Kil�p�k) AS SumOfKil�p�k
FROM (SELECT Ad�azonos�t�, lkKil�p�k_Szem�lyek01.Kil�p�s�ve, lkKil�p�k_Szem�lyek01.Kil�p�sHava, 0 As Bel�p�k, lkKil�p�k_Szem�lyek01.L�tsz�m AS Kil�p�k 
FROM lkKil�p�k_Szem�lyek01

UNION
SELECT Ad�azonos�t�, lkBel�p�k_Szem�lyek01.Bel�p�s�ve, lkBel�p�k_Szem�lyek01.Bel�p�sHava, lkBel�p�k_Szem�lyek01.L�tsz�m AS Bel�p�k, 0 as Kil�p�k
FROM lkBel�p�k_Szem�lyek01

)  AS BeKil�p�k
GROUP BY BeKil�p�k.Kil�p�s�ve, BeKil�p�k.Kil�p�sHava
HAVING ((([BeKil�p�k].[Kil�p�s�ve])>2018));

-- [lkBeKil�p�k02]
TRANSFORM Sum([SumOfBel�p�k]+[SumOfKil�p�k]) AS �sszeg
SELECT lkBeKil�p�k01.H�
FROM lkBeKil�p�k01
GROUP BY lkBeKil�p�k01.H�
PIVOT lkBeKil�p�k01.�v;

-- [lkBeKil�p�kAK�vetkez�H�napban]
SELECT KiBel�p�k.D�tum, Sum(KiBel�p�k.[Bel�p�k sz�ma]) AS [Bel�p�k sz�ma], Sum(KiBel�p�k.[Kil�p�k sz�ma]) AS [Kil�p�k sz�ma], [Bel�p�k sz�ma]-[Kil�p�k sz�ma] AS Mozg�s
FROM (SELECT 
lkBel�p�kSz�ma.D�tum, lkBel�p�kSz�ma.[Bel�p�k sz�ma], lkBel�p�kSz�ma.[Kil�p�k sz�ma]
FROM lkBel�p�kSz�ma
UNION SELECT
lkKil�p�kSz�ma.D�tum, lkKil�p�kSz�ma.[Bel�p�k sz�ma], lkKil�p�kSz�ma.[Kil�p�k sz�ma]
FROM  lkKil�p�kSz�ma
)  AS KiBel�p�k
GROUP BY KiBel�p�k.D�tum;

-- [lkBel�p�sD�tumaAd�jel]
SELECT lkSzem�lyek.Ad�jel, lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)]
FROM lkSzem�lyek;

-- [lkBel�p�k]
SELECT Bel�p�k.Sorsz�m, Bel�p�k.N�v, Bel�p�k.Ad�azonos�t�, Bel�p�k.Alapl�tsz�m, Bel�p�k.[Megyei szint VAGY J�r�si Hivatal], Bel�p�k.Mez�5, Bel�p�k.Mez�6, Bel�p�k.[�NYR SZERVEZETI EGYS�G AZONOS�T�], Bel�p�k.Mez�8, Bel�p�k.[Besorol�si fokozat k�d:], Bel�p�k.[Besorol�si fokozat megnevez�se:], Bel�p�k.[�ll�shely azonos�t�], Bel�p�k.[Jogviszony kezd� d�tuma], Bel�p�k.[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)], Bel�p�k.[Illetm�ny (Ft/h�)], IIf([Megyei szint VAGY J�r�si Hivatal]="megyei szint",[Mez�5],[Megyei szint VAGY J�r�si Hivatal]) AS F�oszt�ly, Bel�p�k.Mez�6 AS Oszt�ly, CDbl([ad�azonos�t�]) AS Ad�jel, "-" AS �res
FROM Bel�p�k;

-- [lkBel�p�k_Szem�lyek01]
SELECT tSzem�lyek.[Dolgoz� teljes neve] AS N�v, Year([Jogviszony kezdete (bel�p�s d�tuma)]) AS Bel�p�s�ve, Month([Jogviszony kezdete (bel�p�s d�tuma)]) AS Bel�p�sHava, [tSzem�lyek].[Ad�jel]*1 AS Ad�azonos�t�, tSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS Bel�p�s, tSzem�lyek.[Szervezeti egys�g k�dja], 1 AS L�tsz�m
FROM tSzem�lyek
WHERE (((tSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)]) Is Not Null) AND ((tSzem�lyek.[Szervezeti egys�g k�dja]) Not Like "BFKH-MEGB")) OR (((tSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)]) Is Not Null) AND ((tSzem�lyek.[Szervezeti egys�g k�dja])="")) OR (((tSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)]) Is Not Null) AND ((tSzem�lyek.[Szervezeti egys�g k�dja]) Is Null));

-- [lkBel�p�k_Szem�lyek02]
TRANSFORM Sum(lkBel�p�k_Szem�lyek01.L�tsz�m) AS SumOfL�tsz�m
SELECT lkBel�p�k_Szem�lyek01.Bel�p�sHava
FROM lkBel�p�k_Szem�lyek01
WHERE (((lkBel�p�k_Szem�lyek01.Bel�p�s�ve)>2018))
GROUP BY lkBel�p�k_Szem�lyek01.Bel�p�sHava
PIVOT lkBel�p�k_Szem�lyek01.Bel�p�s�ve;

-- [lkBel�p�k2019Jelenig]
PARAMETERS [Kezd� d�tum] DateTime;
SELECT Uni�Uni�.BFKH, Uni�Uni�.F�oszt�ly, Uni�Uni�.Oszt�ly, Uni�Uni�.[Bel�p�s �ve hava], Sum(Uni�Uni�.F�) AS SumOfF�
FROM (SELECT bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]) AS BFKH, IIf([Megyei szint VAGY J�r�si Hivatal]="megyei szint",[Mez�5],[Megyei szint VAGY J�r�si Hivatal]) AS F�oszt�ly, tBel�p�kUni�.Mez�6 AS Oszt�ly, Year([Jogviszony kezd� d�tuma]) & IIf(Len(Month([Jogviszony kezd� d�tuma]))=1,"0","") & Month([Jogviszony kezd� d�tuma]) AS [Bel�p�s �ve hava], 1 AS F�
FROM tBel�p�kUni�
WHERE (((tBel�p�kUni�.[Jogviszony kezd� d�tuma])>[Kezd� d�tum]))
Union SELECT bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]) AS BFKH, IIf([Megyei szint VAGY J�r�si Hivatal]="megyei szint",[Mez�5],[Megyei szint VAGY J�r�si Hivatal]) AS F�oszt�ly, lkBel�p�k.Mez�6 AS Oszt�ly, Year([Jogviszony kezd� d�tuma]) & IIf(Len(Month([Jogviszony kezd� d�tuma]))=1,"0","") & Month([Jogviszony kezd� d�tuma]) AS [Bel�p�s �ve hava], 1 AS F�
FROM lkBel�p�k)  AS Uni�Uni�
GROUP BY Uni�Uni�.BFKH, Uni�Uni�.F�oszt�ly, Uni�Uni�.Oszt�ly, Uni�Uni�.[Bel�p�s �ve hava]
ORDER BY Uni�Uni�.[Bel�p�s �ve hava];

-- [lkBel�p�kEgyAdottF�oszt�lyra2023ban]
SELECT lkBel�p�kUni�.N�v, lkBel�p�kUni�.F�oszt�ly, lkBel�p�kUni�.Oszt�ly, ffsplit([Feladatk�r],"-",2) AS [Ell�tand� feladat], lkBel�p�kUni�.[Jogviszony kezd� d�tuma]
FROM lkBel�p�kUni� RIGHT JOIN tSzem�lyek ON (lkBel�p�kUni�.[Jogviszony kezd� d�tuma] = tSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)]) AND (lkBel�p�kUni�.Ad�azonos�t� = tSzem�lyek.[Ad�azonos�t� jel])
WHERE (((lkBel�p�kUni�.F�oszt�ly) Like [Szervezeti egys�g] & "*") AND ((lkBel�p�kUni�.[Jogviszony kezd� d�tuma]) Between #1/1/2023# And #12/31/2023#));

-- [lkBel�p�kSz�ma]
SELECT dt�tal([Jogviszony kezdete (bel�p�s d�tuma)]) AS D�tum, Count(lkSzem�lyek.Ad�jel) AS [Bel�p�k sz�ma], 0 AS [Kil�p�k sz�ma]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]) Like "munka*" Or (lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]) Like "korm*"))
GROUP BY dt�tal([Jogviszony kezdete (bel�p�s d�tuma)]), 0
HAVING (((dt�tal([Jogviszony kezdete (bel�p�s d�tuma)])) Between Now() And DateSerial(Year(Now()),Month(Now())+1,Day(Now()))));

-- [lkBel�p�kSz�ma�vente2b]
SELECT lkBel�p�kSz�ma�venteHavonta.�v, Sum(lkBel�p�kSz�ma�venteHavonta.[Bel�p�k sz�ma]) AS Bel�p�k
FROM lkBel�p�kSz�ma�venteHavonta
GROUP BY lkBel�p�kSz�ma�venteHavonta.�v
HAVING (((lkBel�p�kSz�ma�venteHavonta.�v)>=2019));

-- [lkBel�p�kSz�ma�venteF�l�vente01a]
TRANSFORM Count(tSzem�lyek.Azonos�t�) AS [Bel�p�k sz�ma]
SELECT 1 AS Sorsz�m, tSzem�lyek.[KIRA jogviszony jelleg], Year([Jogviszony kezdete (bel�p�s d�tuma)]) AS �v
FROM tSzem�lyek
WHERE (((tSzem�lyek.[KIRA jogviszony jelleg]) Like "Korm�nyzati*" Or (tSzem�lyek.[KIRA jogviszony jelleg])="Munkaviszony") AND ((Year([Jogviszony kezdete (bel�p�s d�tuma)]))>=2019 And (Year([Jogviszony kezdete (bel�p�s d�tuma)]))<=Year(Now())+1) AND ((tSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)]) Is Not Null Or (tSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])<>""))
GROUP BY 1, tSzem�lyek.[KIRA jogviszony jelleg], Year([Jogviszony kezdete (bel�p�s d�tuma)])
PIVOT IIf(Month([Jogviszony kezdete (bel�p�s d�tuma)])<7,1,2);

-- [lkBel�p�kSz�ma�venteF�l�vente01b]
TRANSFORM Count(tSzem�lyek.Azonos�t�) AS [Bel�p�k sz�ma]
SELECT 2 AS Sorsz�m, "Kit. �s Mt. egy�tt:" AS [KIRA jogviszony jelleg], Year([Jogviszony kezdete (bel�p�s d�tuma)]) AS �v
FROM tSzem�lyek
WHERE (((Year([Jogviszony kezdete (bel�p�s d�tuma)]))>=2019 And (Year([Jogviszony kezdete (bel�p�s d�tuma)]))<=Year(Now())+1) AND ((tSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)]) Is Not Null Or (tSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])<>"") AND ((tSzem�lyek.[KIRA jogviszony jelleg]) Like "Korm�nyzati*" Or (tSzem�lyek.[KIRA jogviszony jelleg])="Munkaviszony"))
GROUP BY 2, "Kit. �s Mt. egy�tt:", Year([Jogviszony kezdete (bel�p�s d�tuma)])
PIVOT IIf(Month([Jogviszony kezdete (bel�p�s d�tuma)])<7,1,2);

-- [lkBel�p�kSz�ma�venteF�l�vente02]
SELECT lkBel�p�kSz�ma�venteF�l�vente01a.Sorsz�m, lkBel�p�kSz�ma�venteF�l�vente01a.[KIRA jogviszony jelleg], lkBel�p�kSz�ma�venteF�l�vente01a.�v, lkBel�p�kSz�ma�venteF�l�vente01a.[1], lkBel�p�kSz�ma�venteF�l�vente01a.[2]
FROM lkBel�p�kSz�ma�venteF�l�vente01a
UNION SELECT lkBel�p�kSz�ma�venteF�l�vente01b.Sorsz�m, lkBel�p�kSz�ma�venteF�l�vente01b.[KIRA jogviszony jelleg], lkBel�p�kSz�ma�venteF�l�vente01b.�v, lkBel�p�kSz�ma�venteF�l�vente01b.[1], lkBel�p�kSz�ma�venteF�l�vente01b.[2]
FROM  lkBel�p�kSz�ma�venteF�l�vente01b;

-- [lkBel�p�kSz�ma�venteHavonta]
SELECT Year([Jogviszony kezdete (bel�p�s d�tuma)]) AS �v, Month([Jogviszony kezdete (bel�p�s d�tuma)]) AS H�, Count(tSzem�lyek.Azonos�t�) AS [Bel�p�k sz�ma]
FROM tSzem�lyek
WHERE (((tSzem�lyek.[KIRA jogviszony jelleg]) Like "Korm�nyzati*" Or (tSzem�lyek.[KIRA jogviszony jelleg])="Munkaviszony") AND ((tSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)]) Is Not Null Or (tSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])<>"") AND ((tSzem�lyek.[St�tusz t�pusa]) Like "Sz*"))
GROUP BY Year([Jogviszony kezdete (bel�p�s d�tuma)]), Month([Jogviszony kezdete (bel�p�s d�tuma)])
HAVING (((Year([Jogviszony kezdete (bel�p�s d�tuma)]))>=2019 And (Year([Jogviszony kezdete (bel�p�s d�tuma)]))<=Year(Now())+1))
ORDER BY Year([Jogviszony kezdete (bel�p�s d�tuma)]), Month([Jogviszony kezdete (bel�p�s d�tuma)]);

-- [lkBel�p�kSz�ma�venteHavonta2]
SELECT lkBel�p�kSz�ma�venteHavonta.�v, IIf([H�]=1,[Bel�p�k sz�ma],0) AS 1, IIf([H�]=2,[Bel�p�k sz�ma],0) AS 2, IIf([H�]=3,[Bel�p�k sz�ma],0) AS 3, IIf([H�]=4,[Bel�p�k sz�ma],0) AS 4, IIf([H�]=5,[Bel�p�k sz�ma],0) AS 5, IIf([H�]=6,[Bel�p�k sz�ma],0) AS 6, IIf([H�]=7,[Bel�p�k sz�ma],0) AS 7, IIf([H�]=8,[Bel�p�k sz�ma],0) AS 8, IIf([H�]=9,[Bel�p�k sz�ma],0) AS 9, IIf([H�]=10,[Bel�p�k sz�ma],0) AS 10, IIf([H�]=11,[Bel�p�k sz�ma],0) AS 11, IIf([H�]=12,[Bel�p�k sz�ma],0) AS 12
FROM lkBel�p�kSz�ma�venteHavonta;

-- [lkBel�p�kSz�ma�venteHavonta2Akkumul�lva]
SELECT lkBel�p�kSz�ma�venteHavonta.�v, IIf([H�]<=1,[Bel�p�k sz�ma],0) AS 1, IIf([H�]<=2,[Bel�p�k sz�ma],0) AS 2, IIf([H�]<=3,[Bel�p�k sz�ma],0) AS 3, IIf([H�]<=4,[Bel�p�k sz�ma],0) AS 4, IIf([H�]<=5,[Bel�p�k sz�ma],0) AS 5, IIf([H�]<=6,[Bel�p�k sz�ma],0) AS 6, IIf([H�]<=7,[Bel�p�k sz�ma],0) AS 7, IIf([H�]<=8,[Bel�p�k sz�ma],0) AS 8, IIf([H�]<=9,[Bel�p�k sz�ma],0) AS 9, IIf([H�]<=10,[Bel�p�k sz�ma],0) AS 10, IIf([H�]<=11,[Bel�p�k sz�ma],0) AS 11, IIf([H�]<=12,[Bel�p�k sz�ma],0) AS 12
FROM lkBel�p�kSz�ma�venteHavonta;

-- [lkBel�p�kSz�ma�venteHavonta3]
SELECT lkBel�p�kSz�ma�venteHavonta2.�v, Sum(lkBel�p�kSz�ma�venteHavonta2.[1]) AS 01, Sum(lkBel�p�kSz�ma�venteHavonta2.[2]) AS 02, Sum(lkBel�p�kSz�ma�venteHavonta2.[3]) AS 03, Sum(lkBel�p�kSz�ma�venteHavonta2.[4]) AS 04, Sum(lkBel�p�kSz�ma�venteHavonta2.[5]) AS 05, Sum(lkBel�p�kSz�ma�venteHavonta2.[6]) AS 06, Sum(lkBel�p�kSz�ma�venteHavonta2.[7]) AS 07, Sum(lkBel�p�kSz�ma�venteHavonta2.[8]) AS 08, Sum(lkBel�p�kSz�ma�venteHavonta2.[9]) AS 09, Sum(lkBel�p�kSz�ma�venteHavonta2.[10]) AS 10, Sum(lkBel�p�kSz�ma�venteHavonta2.[11]) AS 11, Sum(lkBel�p�kSz�ma�venteHavonta2.[12]) AS 12, lkBel�p�kSz�ma�vente2b.Bel�p�k
FROM lkBel�p�kSz�ma�vente2b INNER JOIN lkBel�p�kSz�ma�venteHavonta2 ON lkBel�p�kSz�ma�vente2b.�v = lkBel�p�kSz�ma�venteHavonta2.�v
GROUP BY lkBel�p�kSz�ma�venteHavonta2.�v, lkBel�p�kSz�ma�vente2b.Bel�p�k;

-- [lkBel�p�kSz�ma�venteHavonta3Akkumul�lva]
SELECT lkBel�p�kSz�ma�venteHavonta2Akkumul�lva.�v, Sum(lkBel�p�kSz�ma�venteHavonta2Akkumul�lva.[1]) AS 01, Sum(lkBel�p�kSz�ma�venteHavonta2Akkumul�lva.[2]) AS 02, Sum(lkBel�p�kSz�ma�venteHavonta2Akkumul�lva.[3]) AS 03, Sum(lkBel�p�kSz�ma�venteHavonta2Akkumul�lva.[4]) AS 04, Sum(lkBel�p�kSz�ma�venteHavonta2Akkumul�lva.[5]) AS 05, Sum(lkBel�p�kSz�ma�venteHavonta2Akkumul�lva.[6]) AS 06, Sum(lkBel�p�kSz�ma�venteHavonta2Akkumul�lva.[7]) AS 07, Sum(lkBel�p�kSz�ma�venteHavonta2Akkumul�lva.[8]) AS 08, Sum(lkBel�p�kSz�ma�venteHavonta2Akkumul�lva.[9]) AS 09, Sum(lkBel�p�kSz�ma�venteHavonta2Akkumul�lva.[10]) AS 10, Sum(lkBel�p�kSz�ma�venteHavonta2Akkumul�lva.[11]) AS 11, Sum(lkBel�p�kSz�ma�venteHavonta2Akkumul�lva.[12]) AS 12, lkBel�p�kSz�ma�vente2b.Bel�p�k
FROM lkBel�p�kSz�ma�venteHavonta2Akkumul�lva INNER JOIN lkBel�p�kSz�ma�vente2b ON lkBel�p�kSz�ma�venteHavonta2Akkumul�lva.�v = lkBel�p�kSz�ma�vente2b.�v
GROUP BY lkBel�p�kSz�ma�venteHavonta2Akkumul�lva.�v, lkBel�p�kSz�ma�vente2b.Bel�p�k;

-- [lkBel�p�kSz�ma�venteHavontaF�oszt02]
SELECT lkBel�p�kSz�ma�venteHavontaF�osztOszt01.F�oszt�ly AS F�oszt�ly, lkBel�p�kSz�ma�venteHavontaF�osztOszt01.�v AS �v, Sum(((IIf([H�]=1,[Bel�p�k sz�ma],0)))) AS 1, Sum(((IIf([H�]=2,[Bel�p�k sz�ma],0)))) AS 2, Sum(((IIf([H�]=3,[Bel�p�k sz�ma],0)))) AS 3, Sum(((IIf([H�]=4,[Bel�p�k sz�ma],0)))) AS 4, Sum(((IIf([H�]=5,[Bel�p�k sz�ma],0)))) AS 5, Sum(((IIf([H�]=6,[Bel�p�k sz�ma],0)))) AS 6, Sum(((IIf([H�]=7,[Bel�p�k sz�ma],0)))) AS 7, Sum(((IIf([H�]=8,[Bel�p�k sz�ma],0)))) AS 8, Sum(((IIf([H�]=9,[Bel�p�k sz�ma],0)))) AS 9, Sum(((IIf([H�]=10,[Bel�p�k sz�ma],0)))) AS 10, Sum(((IIf([H�]=12,[Bel�p�k sz�ma],0)))) AS 11, Sum(((IIf([H�]=12,[Bel�p�k sz�ma],0)))) AS 12, [1]+[2]+[3]+[4]+[5]+[6]+[7]+[8]+[9]+[10]+[11]+[12] AS �sszesen
FROM lkBel�p�kSz�ma�venteHavontaF�osztOszt01
GROUP BY lkBel�p�kSz�ma�venteHavontaF�osztOszt01.F�oszt�ly, lkBel�p�kSz�ma�venteHavontaF�osztOszt01.�v;

-- [lkBel�p�kSz�ma�venteHavontaF�osztOszt01]
SELECT Trim(Replace(Replace(Replace([Bel�p�kUni�M�ig].[F�oszt�ly],"Budapest F�v�ros Korm�nyhivatala","BFKH")," 20200229-ig",""),"Budapest F�v�rosKorm�nyhivatala","BFKH")) AS F�oszt�ly, Replace([Bel�p�kUni�M�ig].[Oszt�ly]," 20200229-ig","") AS Oszt�ly, Year([Jogviszony kezdete (bel�p�s d�tuma)]) AS �v, Month([Jogviszony kezdete (bel�p�s d�tuma)]) AS H�, Count(tSzem�lyek.Azonos�t�) AS [Bel�p�k sz�ma]
FROM tSzem�lyek RIGHT JOIN (SELECT lkBel�p�kUni�.F�oszt�ly, lkBel�p�kUni�.Oszt�ly, lkBel�p�kUni�.Ad�azonos�t�, lkBel�p�kUni�.[Jogviszony kezd� d�tuma]
  FROM lkBel�p�kUni�
  UNION
  SELECT IIf([Megyei szint VAGY J�r�si Hivatal]="megyei szint",[Mez�5],[Megyei szint VAGY J�r�si Hivatal]) AS F�oszt�ly, lkBel�p�k.Mez�6 AS Oszt�ly, lkBel�p�k.Ad�azonos�t�, lkBel�p�k.[Jogviszony kezd� d�tuma]
  FROM lkBel�p�k
)  AS Bel�p�kUni�M�ig ON (tSzem�lyek.[Ad�azonos�t� jel] = Bel�p�kUni�M�ig.Ad�azonos�t�) AND (tSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] = Bel�p�kUni�M�ig.[Jogviszony kezd� d�tuma])
WHERE (((tSzem�lyek.[KIRA jogviszony jelleg]) Like "Korm�nyzati*" Or (tSzem�lyek.[KIRA jogviszony jelleg])="Munkaviszony") AND ((tSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)]) Is Not Null Or (tSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])<>"") AND ((Year([Jogviszony kezdete (bel�p�s d�tuma)])) Between Year(Now())-4 And Year(Now())+1))
GROUP BY Trim(Replace(Replace(Replace([Bel�p�kUni�M�ig].[F�oszt�ly],"Budapest F�v�ros Korm�nyhivatala","BFKH")," 20200229-ig",""),"Budapest F�v�rosKorm�nyhivatala","BFKH")), Replace([Bel�p�kUni�M�ig].[Oszt�ly]," 20200229-ig",""), Year([Jogviszony kezdete (bel�p�s d�tuma)]), Month([Jogviszony kezdete (bel�p�s d�tuma)])
ORDER BY Year([Jogviszony kezdete (bel�p�s d�tuma)]), Month([Jogviszony kezdete (bel�p�s d�tuma)]);

-- [lkBel�p�kSz�ma�venteHavontaF�osztOszt02]
SELECT lkBel�p�kSz�ma�venteHavontaF�osztOszt01.F�oszt�ly, lkBel�p�kSz�ma�venteHavontaF�osztOszt01.Oszt�ly, lkBel�p�kSz�ma�venteHavontaF�osztOszt01.�v, Sum(IIf([H�]=1,[Bel�p�k sz�ma],0)) AS 1, Sum(IIf([H�]=2,[Bel�p�k sz�ma],0)) AS 2, Sum(IIf([H�]=3,[Bel�p�k sz�ma],0)) AS 3, Sum(IIf([H�]=4,[Bel�p�k sz�ma],0)) AS 4, Sum(IIf([H�]=5,[Bel�p�k sz�ma],0)) AS 5, Sum(IIf([H�]=6,[Bel�p�k sz�ma],0)) AS 6, Sum(IIf([H�]=7,[Bel�p�k sz�ma],0)) AS 7, Sum(IIf([H�]=8,[Bel�p�k sz�ma],0)) AS 8, Sum(IIf([H�]=9,[Bel�p�k sz�ma],0)) AS 9, Sum(IIf([H�]=10,[Bel�p�k sz�ma],0)) AS 10, Sum(IIf([H�]=12,[Bel�p�k sz�ma],0)) AS 11, Sum(IIf([H�]=12,[Bel�p�k sz�ma],0)) AS 12, [1]+[2]+[3]+[4]+[5]+[6]+[7]+[8]+[9]+[10]+[11]+[12] AS �sszesen
FROM lkBel�p�kSz�ma�venteHavontaF�osztOszt01
GROUP BY lkBel�p�kSz�ma�venteHavontaF�osztOszt01.F�oszt�ly, lkBel�p�kSz�ma�venteHavontaF�osztOszt01.Oszt�ly, lkBel�p�kSz�ma�venteHavontaF�osztOszt01.�v;

-- [lkBel�p�kSz�ma�venteHavontaF�osztOszt02-EgyF�oszt�lyra]
SELECT lkBel�p�kSz�ma�venteHavontaF�osztOszt02.*
FROM lkBel�p�kSz�ma�venteHavontaF�osztOszt02
WHERE (((lkBel�p�kSz�ma�venteHavontaF�osztOszt02.F�oszt�ly) Like "*" & [Add meg a F�oszt�ly] & "*"));

-- [lkBel�p�kTeljes]
SELECT tBel�p�kUni��stBel�p�kJ�v�.Sorsz�m, tBel�p�kUni��stBel�p�kJ�v�.N�v, tBel�p�kUni��stBel�p�kJ�v�.Ad�azonos�t�, tBel�p�kUni��stBel�p�kJ�v�.Alapl�tsz�m, tBel�p�kUni��stBel�p�kJ�v�.[Megyei szint VAGY J�r�si Hivatal], tBel�p�kUni��stBel�p�kJ�v�.Mez�5, tBel�p�kUni��stBel�p�kJ�v�.Mez�6, tBel�p�kUni��stBel�p�kJ�v�.[�NYR SZERVEZETI EGYS�G AZONOS�T�], tBel�p�kUni��stBel�p�kJ�v�.Mez�8, tBel�p�kUni��stBel�p�kJ�v�.[Besorol�si fokozat k�d:], tBel�p�kUni��stBel�p�kJ�v�.[Besorol�si fokozat megnevez�se:], tBel�p�kUni��stBel�p�kJ�v�.[�ll�shely azonos�t�], tBel�p�kUni��stBel�p�kJ�v�.[Jogviszony kezd� d�tuma], tBel�p�kUni��stBel�p�kJ�v�.[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)], tBel�p�kUni��stBel�p�kJ�v�.[Illetm�ny (Ft/h�)]
FROM (SELECT tBel�p�kUni�.*
FROM tBel�p�kUni�
UNION SELECT  tBel�p�kJ�v�.*
FROM tBel�p�kJ�v�)  AS tBel�p�kUni��stBel�p�kJ�v�;

-- [lkBel�p�kUni�]
SELECT tBel�p�kUni�.*, IIf([Megyei szint VAGY J�r�si Hivatal]="megyei szint",[Mez�5],[Megyei szint VAGY J�r�si Hivatal]) AS F�oszt�ly, tBel�p�kUni�.Mez�6 AS Oszt�ly, CDbl([ad�azonos�t�]) AS Ad�jel, "-" AS �res
FROM tBel�p�kUni�;

-- [lkBels�Ellen�rz�sNemesf�m01]
SELECT tKorm�nyhivatali_�llom�ny.Mez�7 AS Oszt�ly, tHaviJelent�sHat�lya1.hat�lya AS Id�szak, Count(tKorm�nyhivatali_�llom�ny.Ad�azonos�t�) AS CountOfAd�azonos�t�
FROM tHaviJelent�sHat�lya1 INNER JOIN tKorm�nyhivatali_�llom�ny ON tHaviJelent�sHat�lya1.hat�lyaID = tKorm�nyhivatali_�llom�ny.hat�lyaID
WHERE (((tKorm�nyhivatali_�llom�ny.Mez�4)<>"�res �ll�s")) OR (((tKorm�nyhivatali_�llom�ny.Mez�4)<>"�res �ll�s"))
GROUP BY tKorm�nyhivatali_�llom�ny.Mez�7, tHaviJelent�sHat�lya1.hat�lya
HAVING (((tKorm�nyhivatali_�llom�ny.Mez�7)="Nemesf�m Nyilv�ntart�si, Ellen�rz�si �s Vizsg�lati Oszt�ly") AND ((tHaviJelent�sHat�lya1.hat�lya) Between #12/31/2023# And #12/31/2024#)) OR (((tKorm�nyhivatali_�llom�ny.Mez�7)="Nemesf�mhiteles�t�si �s P�nzmos�s Fel�gyeleti Oszt�ly") AND ((tHaviJelent�sHat�lya1.hat�lya) Between #12/31/2023# And #12/31/2024#));

-- [lkBels�Ellen�rz�sNemesf�m02]
SELECT lkBels�Ellen�rz�sNemesf�m01.Oszt�ly, lkBels�Ellen�rz�sNemesf�m01.Id�szak, lkBels�Ellen�rz�sNemesf�m01.CountOfAd�azonos�t�
FROM lkBels�Ellen�rz�sNemesf�m01 INNER JOIN lkKiemeltNapok ON lkBels�Ellen�rz�sNemesf�m01.Id�szak = lkKiemeltNapok.KiemeltNapok
WHERE (((lkKiemeltNapok.tnap)=31));

-- [lkBels�Ellen�rz�sNemesf�mLista]
SELECT DISTINCT tKorm�nyhivatali_�llom�ny.Mez�7 AS Oszt�ly, tHaviJelent�sHat�lya1.hat�lya AS Id�szak, tKorm�nyhivatali_�llom�ny.Ad�azonos�t�, tKorm�nyhivatali_�llom�ny.N�v
FROM tHaviJelent�sHat�lya1 INNER JOIN tKorm�nyhivatali_�llom�ny ON tHaviJelent�sHat�lya1.hat�lyaID = tKorm�nyhivatali_�llom�ny.hat�lyaID
WHERE (((tKorm�nyhivatali_�llom�ny.Mez�7)="Nemesf�m Nyilv�ntart�si, Ellen�rz�si �s Vizsg�lati Oszt�ly") AND ((tHaviJelent�sHat�lya1.hat�lya) Between #12/31/2023# And #12/31/2024#) AND ((tKorm�nyhivatali_�llom�ny.Mez�4)<>"�res �ll�s") AND ((Day([hat�lya]))=28 Or (Day([hat�lya]))=29 Or (Day([hat�lya]))=30 Or (Day([hat�lya]))=31)) OR (((tKorm�nyhivatali_�llom�ny.Mez�7)="Nemesf�mhiteles�t�si �s P�nzmos�s Fel�gyeleti Oszt�ly") AND ((tHaviJelent�sHat�lya1.hat�lya) Between #12/31/2023# And #12/31/2024#) AND ((tKorm�nyhivatali_�llom�ny.Mez�4)<>"�res �ll�s") AND ((Day([hat�lya]))=28 Or (Day([hat�lya]))=29 Or (Day([hat�lya]))=30 Or (Day([hat�lya]))=31))
ORDER BY tKorm�nyhivatali_�llom�ny.Mez�7, tHaviJelent�sHat�lya1.hat�lya, tKorm�nyhivatali_�llom�ny.Ad�azonos�t�;

-- [lkBels�Enged�lyezettL�tsz�mokJelenleg]
SELECT tBels�Enged�lyezettL�tsz�mok.F�oszt�lyK�d, tBels�Enged�lyezettL�tsz�mok.F�oszt�ly, tBels�Enged�lyezettL�tsz�mok.Oszt�ly, Sum(tBels�Enged�lyezettL�tsz�mok.Enged�lyV�ltoz�s) AS L�tsz�m
FROM tBels�Enged�lyezettL�tsz�mok
WHERE (((tBels�Enged�lyezettL�tsz�mok.Hat�ly)=(Select Max([Hat�ly]) From [tBels�Enged�lyezettL�tsz�mok] as TMP WHere [tBels�Enged�lyezettL�tsz�mok].[F�oszt�lyK�d]=tmp.[F�oszt�lyK�d])))
GROUP BY tBels�Enged�lyezettL�tsz�mok.F�oszt�lyK�d, tBels�Enged�lyezettL�tsz�mok.F�oszt�ly, tBels�Enged�lyezettL�tsz�mok.Oszt�ly;

-- [lkBels�Enged�lyezettL�tsz�mt�lElt�r�s01]
SELECT �sszesenAzlk�ll�shelyekHavib�l.F�oszt�ly, lkBels�Enged�lyezettL�tsz�mokJelenleg.L�tsz�m AS Enged�lyezett, �sszesenAzlk�ll�shelyekHavib�l.[CountOf�ll�shely azonos�t�] AS T�nyleges, [Enged�lyezett]-[T�nyleges] AS Elt�r�s
FROM lkBels�Enged�lyezettL�tsz�mokJelenleg INNER JOIN (SELECT [lk�ll�shelyek(havi)].F�oszt�ly, Count([lk�ll�shelyek(havi)].[�ll�shely azonos�t�]) AS [CountOf�ll�shely azonos�t�] FROM [lk�ll�shelyek(havi)] GROUP BY [lk�ll�shelyek(havi)].F�oszt�ly)  AS �sszesenAzlk�ll�shelyekHavib�l ON lkBels�Enged�lyezettL�tsz�mokJelenleg.F�oszt�ly = �sszesenAzlk�ll�shelyekHavib�l.F�oszt�ly
GROUP BY �sszesenAzlk�ll�shelyekHavib�l.F�oszt�ly, lkBels�Enged�lyezettL�tsz�mokJelenleg.L�tsz�m, �sszesenAzlk�ll�shelyekHavib�l.[CountOf�ll�shely azonos�t�];

-- [lkBels�Enged�lyezettL�tsz�mt�lElt�r�s02]
SELECT lkBels�Enged�lyezettL�tsz�mt�lElt�r�s01.F�oszt�ly, lkBels�Enged�lyezettL�tsz�mt�lElt�r�s01.Enged�lyezett, lkBels�Enged�lyezettL�tsz�mt�lElt�r�s01.T�nyleges, lkBels�Enged�lyezettL�tsz�mt�lElt�r�s01.Elt�r�s
FROM lkBels�Enged�lyezettL�tsz�mt�lElt�r�s01
WHERE (((lkBels�Enged�lyezettL�tsz�mt�lElt�r�s01.Elt�r�s)<>0));

-- [lkBesorol�sEmel�shez01]
SELECT Bfkh([Szervezetk�d]) AS BFKH, lk_�llom�nyt�bl�kb�l_Illetm�nyek.Szervezetk�d, lk_�llom�nyt�bl�kb�l_Illetm�nyek.Ad�jel, tSzervezet.[Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s] AS besorol�s, lk_�llom�nyt�bl�kb�l_Illetm�nyek.[�ll�shely azonos�t�], tBesorol�s_�talak�t�_1.[als� hat�r], tBesorol�s_�talak�t�_1.[fels� hat�r], lk_�llom�nyt�bl�kb�l_Illetm�nyek.Illetm�ny, Besorol�s_�talak�t�.als�2, Besorol�s_�talak�t�.fels�2, lk_�llom�nyt�bl�kb�l_Illetm�nyek.[Heti munka�r�k sz�ma], [Illetm�ny]/IIf([Heti munka�r�k sz�ma]=0,0.0001,[Heti munka�r�k sz�ma])*40 AS [40 �r�s illetm�ny], tBesorol�s_�talak�t�_1.[Jogviszony t�pusa], lk_�llom�nyt�bl�kb�l_Illetm�nyek.N�v, lk_�llom�nyt�bl�kb�l_Illetm�nyek.F�oszt�ly, lk_�llom�nyt�bl�kb�l_Illetm�nyek.Oszt�ly
FROM (SELECT [als� hat�r] AS als�2, [fels� hat�r] AS fels�2, �res, Kit, Mt, [Sorrend]-1 AS EmeltSorrend FROM tBesorol�s_�talak�t�)  AS Besorol�s_�talak�t� RIGHT JOIN (tBesorol�s_�talak�t� AS tBesorol�s_�talak�t�_1 RIGHT JOIN (lk_�llom�nyt�bl�kb�l_Illetm�nyek RIGHT JOIN tSzervezet ON lk_�llom�nyt�bl�kb�l_Illetm�nyek.[�ll�shely azonos�t�]=tSzervezet.[Szervezetmenedzsment k�d]) ON tBesorol�s_�talak�t�_1.[Az �ll�shely jel�l�se]=lk_�llom�nyt�bl�kb�l_Illetm�nyek.Besorol�sHavi) ON (Besorol�s_�talak�t�.EmeltSorrend=tBesorol�s_�talak�t�_1.Sorrend) AND (Besorol�s_�talak�t�.Mt=tBesorol�s_�talak�t�_1.Mt) AND (Besorol�s_�talak�t�.Kit=tBesorol�s_�talak�t�_1.Kit) AND (Besorol�s_�talak�t�.�res=tBesorol�s_�talak�t�_1.�res)
WHERE ((([Illetm�ny]/IIf([Heti munka�r�k sz�ma]=0,0.0001,[Heti munka�r�k sz�ma])*40) Not Between [als� hat�r] And [fels� hat�r])) OR ((([Illetm�ny]/IIf([Heti munka�r�k sz�ma]=0,0.0001,[Heti munka�r�k sz�ma])*40) Not Between [als�2] And [fels�2]));

-- [lkBesorol�sEmel�shez02]
SELECT lkBesorol�sEmel�shez01.BFKH, lkBesorol�sEmel�shez01.F�oszt�ly, lkBesorol�sEmel�shez01.Oszt�ly, lkBesorol�sEmel�shez01.Ad�jel, lkBesorol�sEmel�shez01.N�v, lkBesorol�sEmel�shez01.[Jogviszony t�pusa], lkBesorol�sEmel�shez01.besorol�s AS [Jelenlegi beorol�s], lkBesorol�sEmel�shez01.[als� hat�r] AS [Jelenlegi als� hat�r], lkBesorol�sEmel�shez01.[fels� hat�r] AS [Jelenlegi fels� hat�r], lkBesorol�sEmel�shez01.[40 �r�s illetm�ny], lkBesorol�sEmel�shez01.als�2 AS [Emelt als� hat�r], lkBesorol�sEmel�shez01.fels�2 AS [Emelt fels� hat�r], *
FROM lkBesorol�sEmel�shez01
WHERE (((lkBesorol�sEmel�shez01.besorol�s)="Vezet�-hivatalitan�csos")) OR (((lkBesorol�sEmel�shez01.besorol�s)="Hivatali tan�csos"))
ORDER BY lkBesorol�sEmel�shez01.Ad�jel, lkBesorol�sEmel�shez01.[40 �r�s illetm�ny];

-- [lkBesorol�sHavi�NYR]
SELECT lkJ�r�siKorm�nyK�zpontos�tottUni�.[�ll�shely azonos�t�], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Besorol�si fokozat k�d:], lk�ll�shelyek.jel2 AS �NYRb�l, lkJ�r�siKorm�nyK�zpontos�tottUni�.[Besorol�si fokozat megnevez�se:]
FROM lkJ�r�siKorm�nyK�zpontos�tottUni� INNER JOIN lk�ll�shelyek ON lkJ�r�siKorm�nyK�zpontos�tottUni�.[�ll�shely azonos�t�] = lk�ll�shelyek.[�ll�shely azonos�t�];

-- [lkBesorol�sHelyettes02]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkBesorol�sHelyettesek.N�v AS [TT-s neve], lkBesorol�sHelyettesek.Ad�jel AS [TT-s ad�jele], lkSzem�lyek.[Tart�s t�voll�t t�pusa], [Csal�di n�v] & " " & [Ut�n�v] AS [TTH-s neve], lkBesorol�sHelyettesek.Kezdete1, lkBesorol�sHelyettesek.V�ge1, "https://nexonport.kh.gov.hu/menu/hrm/szemelyiKarton/index?szemelyAzonosito=" & [azNexon] & "&r=13" AS Link
FROM kt_azNexon_Ad�jel INNER JOIN (lkSzem�lyek RIGHT JOIN lkBesorol�sHelyettesek ON lkSzem�lyek.[Dolgoz� teljes neve] = lkBesorol�sHelyettesek.N�v) ON kt_azNexon_Ad�jel.Ad�jel = lkBesorol�sHelyettesek.Ad�jel
WHERE (((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Not Null))
ORDER BY lkBesorol�sHelyettesek.N�v, lkBesorol�sHelyettesek.Kezdete1, lkBesorol�sHelyettesek.V�ge1;

-- [lkBesorol�sHelyettesek]
SELECT Besorol�sHelyettes�tett.Azonos�t�, Besorol�sHelyettes�tett.Ad�jel, Besorol�sHelyettes�tett.[TAJ sz�m], Besorol�sHelyettes�tett.[Egyedi azonos�t�], Besorol�sHelyettes�tett.T�rzssz�m, Besorol�sHelyettes�tett.El�n�v, Besorol�sHelyettes�tett.[Csal�di n�v], Besorol�sHelyettes�tett.Ut�n�v, Besorol�sHelyettes�tett.[Jogviszony ID], Besorol�sHelyettes�tett.K�d, Besorol�sHelyettes�tett.Megnevez�s, Besorol�sHelyettes�tett.Kezdete, Besorol�sHelyettes�tett.V�ge, Besorol�sHelyettes�tett.Kezdete1, Besorol�sHelyettes�tett.V�ge1, Besorol�sHelyettes�tett.[Helyettes�t�s oka], Besorol�sHelyettes�tett.[Jogviszony ID1], Besorol�sHelyettes�tett.[Elt�r� illetm�ny fokozata], Besorol�sHelyettes�tett.El�n�v1, Besorol�sHelyettes�tett.[Csal�di n�v1], Besorol�sHelyettes�tett.Ut�n�v1, Trim([Csal�di n�v1]) & " " & Trim([Ut�n�v1] & " " & [El�n�v1]) AS N�v
FROM Besorol�sHelyettes�tett;

-- [lkBesorol�siEredm�nyadatok]
SELECT [Ad�azonos�t� jel]*1 AS Ad�jel, tBesorol�siEredm�nyadatok.*, tBesorol�siEredm�nyadatok.Kezdete4, dt�tal([V�ge5]) AS SzerzV�g
FROM tBesorol�siEredm�nyadatok;

-- [lkBesorol�siEredm�nyadatokUtols�]
SELECT lkBesorol�siEredm�nyadatok.*
FROM lkBesorol�siEredm�nyadatok
WHERE (((lkBesorol�siEredm�nyadatok.[V�ltoz�s d�tuma])=(select Max([Tmp].[V�ltoz�s d�tuma]) from [lkBesorol�siEredm�nyadatok] as Tmp where tmp.ad�jel=[lkBesorol�siEredm�nyadatok].[Ad�jel])));

-- [lkBesorol�sokSzervezetiVs�NYR]
SELECT lkJ�r�siKorm�nyK�zpontos�tottUni�.[J�r�si Hivatal] AS F�oszt�ly, lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly, lkJ�r�siKorm�nyK�zpontos�tottUni�.N�v, tBesorol�s_�talak�t�.Besorol�si_fokozat AS Nexon, �ll�shelyek.[�ll�shely besorol�si kateg�ri�ja] AS �NYR, kt_azNexon_Ad�jel02.NLink
FROM (tBesorol�s_�talak�t� RIGHT JOIN (lkJ�r�siKorm�nyK�zpontos�tottUni� RIGHT JOIN �ll�shelyek ON lkJ�r�siKorm�nyK�zpontos�tottUni�.[�ll�shely azonos�t�] = �ll�shelyek.[�ll�shely azonos�t�]) ON (tBesorol�s_�talak�t�.[Az �ll�shely megynevez�se] = lkJ�r�siKorm�nyK�zpontos�tottUni�.[Besorol�si fokozat megnevez�se:]) AND (tBesorol�s_�talak�t�.[Az �ll�shely jel�l�se] = lkJ�r�siKorm�nyK�zpontos�tottUni�.[Besorol�si fokozat k�d:])) LEFT JOIN kt_azNexon_Ad�jel02 ON lkJ�r�siKorm�nyK�zpontos�tottUni�.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel
WHERE (((�ll�shelyek.[�ll�shely besorol�si kateg�ri�ja])<>[Besorol�si_fokozat]));

-- [lkBesorol�sonk�nti_l�tsz�m_01]
SELECT �ll�shelyek.[�ll�shely besorol�si kateg�ri�ja], Count(Uni�.�ll�shely) AS CountOf�ll�shely
FROM (SELECT J�r�si_�llom�ny.N�v, J�r�si_�llom�ny.[�ll�shely azonos�t�] As �ll�shely, [Besorol�si fokozat k�d:] as besorol�s, "J�r�si" as T�bla FROM J�r�si_�llom�ny UNION SELECT Korm�nyhivatali_�llom�ny.N�v, Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�] As �ll�shely, [Besorol�si fokozat k�d:] as besorol�s, "Korm�nyhivatali" as T�bla FROM Korm�nyhivatali_�llom�ny UNION SELECT K�zpontos�tottak.N�v, K�zpontos�tottak.[�ll�shely azonos�t�] As �ll�shely, [Besorol�si fokozat k�d:] as besorol�s, "K�zpontos�tottak" as T�bla FROM K�zpontos�tottak )  AS Uni� LEFT JOIN �ll�shelyek ON Uni�.�ll�shely = �ll�shelyek.[�ll�shely azonos�t�]
GROUP BY �ll�shelyek.[�ll�shely besorol�si kateg�ri�ja];

-- [lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny]
SELECT IIf([Jogviszony t�pusa / jogviszony t�pus]="Munkaviszony","Munkaviszony",[Besorol�si  fokozat (KT)]) AS Besorol�s, Sum([Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40) AS �sszilletm�ny, Count(lkSzem�lyek.[Ad�azonos�t� jel]) AS F�, Round(Avg([Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40)/100,0)*100 AS �tlag, Round(StDev([Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40)/100,0)*100 AS [�tlagt�l val� elt�r�s (StDev)]
FROM �ll�shelyek LEFT JOIN lkSzem�lyek ON �ll�shelyek.[�ll�shely azonos�t�] = lkSzem�lyek.[St�tusz k�dja]
WHERE (((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
GROUP BY IIf([Jogviszony t�pusa / jogviszony t�pus]="Munkaviszony","Munkaviszony",[Besorol�si  fokozat (KT)]);

-- [lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny_AdottF�oszt�lyra]
SELECT lkSzem�lyek.F�oszt�ly, IIf([Jogviszony t�pusa / jogviszony t�pus]="Munkaviszony","Munkaviszony",[Besorol�si  fokozat (KT)]) AS Besorol�s, Sum([Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40) AS �sszilletm�ny, Count(lkSzem�lyek.[Ad�azonos�t� jel]) AS F�, Round(Avg([Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40)/100,0)*100 AS �tlag, Round(StDev([Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40)/100,0)*100 AS [�tlagt�l val� elt�r�s (StDev)]
FROM �ll�shelyek LEFT JOIN lkSzem�lyek ON �ll�shelyek.[�ll�shely azonos�t�] = lkSzem�lyek.[St�tusz k�dja]
WHERE (((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
GROUP BY lkSzem�lyek.F�oszt�ly, IIf([Jogviszony t�pusa / jogviszony t�pus]="Munkaviszony","Munkaviszony",[Besorol�si  fokozat (KT)]);

-- [lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny_�tlaggal]
SELECT Nz([rang],0)*1 AS Rang_, lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny.Besorol�s, lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny.�sszilletm�ny, lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny.F�, lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny.�tlag, lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny.[�tlagt�l val� elt�r�s (StDev)]
FROM lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny LEFT JOIN tBesorol�sKonverzi� ON lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny.Besorol�s = tBesorol�sKonverzi�.Szem�lyt�rzsb�l
GROUP BY Nz([rang],0)*1, lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny.Besorol�s, lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny.�sszilletm�ny, lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny.F�, lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny.�tlag, lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny.[�tlagt�l val� elt�r�s (StDev)];

-- [lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny_Eredm�ny]
SELECT V�g�sszeggel.Rang_ AS Sorsz�m, V�g�sszeggel.Besorol�s AS Besorol�s, V�g�sszeggel.�sszilletm�ny AS �sszilletm�ny, V�g�sszeggel.F� AS F�, V�g�sszeggel.�tlag AS �tlag, V�g�sszeggel.[�tlagt�l val� elt�r�s (StDev)] AS [�tlagt�l val� elt�r�s (StDev)]
FROM (SELECT lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny_�tlaggal.*
FROM lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny_�tlaggal
UNION
SELECT lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny_Mind�sszesen.*
FROM lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny_Mind�sszesen
)  AS V�g�sszeggel
ORDER BY V�g�sszeggel.Rang_;

-- [lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny_Mind�sszesen]
SELECT Max([Rang_])+1 AS rangsor, "�sszesen: " AS Besorol�s, Round(Sum(lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny_�tlaggal.�sszilletm�ny)/100,0)*100 AS Mind�sszesen, Sum(lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny_�tlaggal.F�) AS �sszl�tsz�m, Round(Sum([�sszilletm�ny])/Sum([F�])/100,0)*100 AS �tlag, (SELECT Round(StDev([Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40)/100,0)*100 AS [�tlagt�l val� elt�r�s]
FROM lkSzem�lyek LEFT JOIN �ll�shelyek ON lkSzem�lyek.[St�tusz k�dja] = �ll�shelyek.[�ll�shely azonos�t�]
WHERE (((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))) AS [�tlagt�l val� elt�r�s]
FROM lkBesorol�sonk�nti_l�tsz�m_�s_illetm�ny_�tlaggal
GROUP BY "�sszesen: ";

-- [lkBesorol�sV�ltoztat�sok]
SELECT tBesorol�sV�ltoztat�sok.*
FROM tBesorol�sV�ltoztat�sok
WHERE (((tBesorol�sV�ltoztat�sok.Azonos�t�)=(Select Top 1 Azonos�t� from [tBesorol�sV�ltoztat�sok] as tmp Where tmp.[�ll�shelyAzonos�t�]=[tBesorol�sV�ltoztat�sok].[�ll�shelyAzonos�t�] Order By  tmp.hat�ly Desc)));

-- [lkBesorol�sV�ltoztat�sok2]
SELECT tBesorol�sV�ltoztat�sok.Azonos�t�, tBesorol�sV�ltoztat�sok.Darabsz�m, tBesorol�sV�ltoztat�sok.�rintettSzerv, tBesorol�sV�ltoztat�sok.�ll�shelyAzonos�t�, tBesorol�sV�ltoztat�sok.R�giBesorol�s, tBesorol�sV�ltoztat�sok.�jBesorol�s, tBesorol�sV�ltoztat�sok.Hat�ly
FROM (SELECT tBesorol�sV�ltoztat�sok.�ll�shelyAzonos�t�, Max(tBesorol�sV�ltoztat�sok.Hat�ly) AS MaxOfHat�ly
FROM tBesorol�sV�ltoztat�sok
GROUP BY tBesorol�sV�ltoztat�sok.�ll�shelyAzonos�t�
)  AS Utols�k INNER JOIN tBesorol�sV�ltoztat�sok ON (Utols�k.�ll�shelyAzonos�t� = tBesorol�sV�ltoztat�sok.�ll�shelyAzonos�t�) AND (Utols�k.MaxOfHat�ly = tBesorol�sV�ltoztat�sok.Hat�ly)
GROUP BY tBesorol�sV�ltoztat�sok.Azonos�t�, tBesorol�sV�ltoztat�sok.Darabsz�m, tBesorol�sV�ltoztat�sok.�rintettSzerv, tBesorol�sV�ltoztat�sok.�ll�shelyAzonos�t�, tBesorol�sV�ltoztat�sok.R�giBesorol�s, tBesorol�sV�ltoztat�sok.�jBesorol�s, tBesorol�sV�ltoztat�sok.Hat�ly;

-- [lkBet�lt�ttL�tsz�m]
SELECT 1 AS Sor, "Bet�lt�tt l�tsz�m:" AS Adat, Sum([f�]) AS �rt�k, Sum(TTn�lk�l) AS nemTT
FROM (SELECT DISTINCT lkSzem�lyek.Ad�jel, 1 AS F�, Abs([Tart�s t�voll�t t�pusa] Is Null) AS TTn�lk�l FROM lkSzem�lyek WHERE lkSzem�lyek.[St�tusz neve] = "�ll�shely")  AS lista;

-- [lkBFKHForr�sK�d]
SELECT DISTINCT lkSzem�lyek.BFKH, lkForr�sNexonSzervezetek�sszerendel�s.F�oszt, lkForr�sNexonSzervezetek�sszerendel�s.Oszt, lkForr�sNexonSzervezetek�sszerendel�s.Forr�sK�d, tSzakfeladatForr�sk�d.SZAKFELADAT
FROM (lkForr�sNexonSzervezetek�sszerendel�s INNER JOIN tSzakfeladatForr�sk�d ON lkForr�sNexonSzervezetek�sszerendel�s.Forr�sK�d = tSzakfeladatForr�sk�d.SzervEgysK�d) INNER JOIN lkSzem�lyek ON (lkForr�sNexonSzervezetek�sszerendel�s.F�oszt = lkSzem�lyek.F�oszt�ly) AND (lkForr�sNexonSzervezetek�sszerendel�s.Oszt = lkSzem�lyek.[Szervezeti egys�g neve]);

-- [lkBiztosanJogosultakUtaz�siKedvezm�nyre]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.Ad�jel, "F�osztR�v_" & [Dolgoz� teljes neve] & "_(" & [azNexon] & ")_utaz�si.pdf" AS F�jln�v
FROM kt_azNexon_Ad�jel02 INNER JOIN (lkSzem�lyek INNER JOIN lkFordul�napt�lEgy�vigMindenJogviszonyMunkanapjai ON lkSzem�lyek.Ad�jel = lkFordul�napt�lEgy�vigMindenJogviszonyMunkanapjai.Ad�jel) ON kt_azNexon_Ad�jel02.Ad�jel = lkFordul�napt�lEgy�vigMindenJogviszonyMunkanapjai.Ad�jel
GROUP BY lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.Ad�jel, "F�osztR�v_" & [Dolgoz� teljes neve] & "_(" & [azNexon] & ")_utaz�si.pdf", lkSzem�lyek.BFKH
HAVING (((Sum(lkFordul�napt�lEgy�vigMindenJogviszonyMunkanapjai.Napok))>=365))
ORDER BY lkSzem�lyek.BFKH, lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkC�mek01]
SELECT strcount(Nz([�lland� lakc�m],"")," ") AS Kif1, lkSzem�lyek.[St�tusz neve]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY strcount(Nz([�lland� lakc�m],"")," ") DESC;

-- [lkD�P]
SELECT lkSzem�lyek.[Ad�azonos�t� jel] AS Ad�sz�m, lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.[Besorol�si  fokozat (KT)] AS Besorol�s, lkSzem�lyek.[KIRA feladat megnevez�s] AS [Ell�tand� feladat], lkSzem�lyek.[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)] AS Illetm�ny, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, "" AS [Sz�let�si n�v], "" AS [Sz�let�si hely], "" AS [Sz�let�si id�], "" AS [Anyja neve], lkSzem�lyek.[�lland� lakc�m], lkSzem�lyek.[Tart�zkod�si lakc�m], [Hivatali email] & ", " & [Hivatali telefon] AS El�rhet�s�g, lkSzem�lyek.[TAJ sz�m], "" AS P�nzint�zet, ffsplit([Utal�si c�m],"|",3) AS Banksz�mlasz�m
FROM lkSzem�lyek INNER JOIN tSpecifikusDolgoz�k ON (tSpecifikusDolgoz�k.[Anyja neve] = lkSzem�lyek.[Anyja neve]) AND (tSpecifikusDolgoz�k.[Sz�let�si id�] = lkSzem�lyek.[Sz�let�si id�]) AND (tSpecifikusDolgoz�k.[Sz�let�si hely] = lkSzem�lyek.[Sz�let�si hely]) AND (lkSzem�lyek.[Dolgoz� sz�let�si neve] = tSpecifikusDolgoz�k.[Sz�let�si n�v]);

-- [lkD�Pb]
SELECT lkSzem�lyek.[Ad�azonos�t� jel] AS Ad�sz�m, tD�Pr�sztvev�k.N�v, lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.[Besorol�si  fokozat (KT)] AS Besorol�s, lkSzem�lyek.[KIRA feladat megnevez�s] AS [Ell�tand� feladat], lkSzem�lyek.[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)] AS Illetm�ny, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� sz�let�si neve] AS [Sz�let�si n�v], lkSzem�lyek.[Sz�let�si hely], lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.[Anyja neve], lkSzem�lyek.[�lland� lakc�m], lkSzem�lyek.[Tart�zkod�si lakc�m], [Hivatali email] & ", " & [Hivatali telefon] AS El�rhet�s�g, lkSzem�lyek.[TAJ sz�m], "" AS P�nzint�zet, ffsplit([Utal�si c�m],"|",3) AS Banksz�mlasz�m
FROM lkSzem�lyek RIGHT JOIN tD�Pr�sztvev�k ON lkSzem�lyek.F�oszt�ly = tD�Pr�sztvev�k.Hivatal;

-- [lkDiplom�sok4eFtAlatt]
SELECT bfkh([Szervezeti egys�g k�dja]) AS BFKH, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], kt_azNexon_Ad�jel.azNexon, lkSzem�lyek.[Besorol�si  fokozat (KT)], lkSzem�lyek.[Kerek�tett 100 %-os illetm�ny (elt�r�tett)] AS Illetm�ny, lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker] AS �rasz�m, [Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40 AS 40�r�sIlletm�ny, lkSzem�lyek.[KIRA feladat megnevez�s], lkSzem�lyek.[Iskolai v�gzetts�g foka], lkSzem�lyek.[Tart�s t�voll�t t�pusa], lkSzem�lyek.[Tart�s t�voll�t v�ge], lkSzem�lyek.[Tart�s t�voll�t tervezett v�ge]
FROM kt_azNexon_Ad�jel RIGHT JOIN lkSzem�lyek ON kt_azNexon_Ad�jel.Ad�jel = lkSzem�lyek.Ad�jel
WHERE ((([Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40)<=400000) AND ((lkSzem�lyek.[Iskolai v�gzetts�g foka])="F�iskolai vagy fels�fok� alapk�pz�s (BA/BsC)okl." Or (lkSzem�lyek.[Iskolai v�gzetts�g foka])="Egyetemi /fels�fok� (MA/MsC) vagy osztatlan k�pz.") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY bfkh([Szervezeti egys�g k�dja]), lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkDolgoz�k18�vAlattiGyermekkel]
SELECT lkHozz�tartoz�k.[Dolgoz� ad�azonos�t� jele], 1 AS f�, Abs([Tart�s t�voll�t t�pusa] Is Null) AS TTn�lk�l
FROM lkHozz�tartoz�k INNER JOIN lkSzem�lyek ON lkHozz�tartoz�k.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkHozz�tartoz�k.[Sz�let�si id�])>DateSerial(Year(Now())-18,Month(Now()),Day(Now()))) AND ((lkHozz�tartoz�k.[Kapcsolat jellege])="Gyermek" Or (lkHozz�tartoz�k.[Kapcsolat jellege])="Nevelt (mostoha)" Or (lkHozz�tartoz�k.[Kapcsolat jellege])="�r�kbe fogadott"));

-- [lkDolgoz�kFeladatk�reBesorol�sa]
SELECT lkSzem�lyek.Ad�jel, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[KIRA feladat megnevez�s], lkSzem�lyek.Feladatk�r, lkSzem�lyek.[Els�dleges feladatk�r], lkSzem�lyek.FEOR, lkSzem�lyek.[KIRA jogviszony jelleg], lkSzem�lyek.[Besorol�si  fokozat (KT)]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.BFKH, lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkDolgoz�kL�tsz�ma18�vAlattiGyermekkel]
SELECT 4 AS sor, "Dolgoz�k l�tsz�ma 18 �v alatti gyermekkel:" AS Adat, Sum(f�) AS �rt�k, Sum([TTn�lk�l]) AS NemTT
FROM (SELECT DISTINCT lkHozz�tartoz�k.[Dolgoz� ad�azonos�t� jele], 1 AS f�, Abs([Tart�s t�voll�t t�pusa] Is Null) AS TTn�lk�l FROM lkHozz�tartoz�k INNER JOIN lkSzem�lyek ON lkHozz�tartoz�k.Ad�jel = lkSzem�lyek.Ad�jel WHERE lkSzem�lyek.[St�tusz neve]="�ll�shely" And lkHozz�tartoz�k.[Sz�let�si id�]>DateSerial(Year(Now())-18,Month(Now()),Day(Now())) And (lkHozz�tartoz�k.[Kapcsolat jellege]="Gyermek" Or lkHozz�tartoz�k.[Kapcsolat jellege]="Nevelt (mostoha)" Or lkHozz�tartoz�k.[Kapcsolat jellege]="�r�kbe fogadott"))  AS allek�rdez�sEgyedi;

-- [lkDolgoz�kL�tsz�ma18�vAlattiUnok�val]
SELECT "Dolgoz�k l�tsz�ma 18 �v alatti unok�val:" AS Adat, Sum(f�) AS �rt�k, Sum([TTn�lk�l]) AS NemTT
FROM (SELECT DISTINCT lkHozz�tartoz�k.[Dolgoz� ad�azonos�t� jele], 1 AS f�, Abs([Tart�s t�voll�t t�pusa] Is Null) AS TTn�lk�l FROM lkHozz�tartoz�k INNER JOIN lkSzem�lyek ON lkHozz�tartoz�k.Ad�jel = lkSzem�lyek.Ad�jel WHERE lkSzem�lyek.[St�tusz neve]="�ll�shely" And lkHozz�tartoz�k.[Sz�let�si id�]>DateSerial(Year(Now())-18,Month(Now()),Day(Now())) And (lkHozz�tartoz�k.[Kapcsolat jellege]="Unoka"))  AS allek�rdez�sEgyedi;

-- [lkDolgoz�kL�tsz�ma6�vAlattiGyermekkel]
SELECT "Dolgoz�k l�tsz�ma 6 �v alatti gyermekkel:" AS Adat, Sum(f�) AS �rt�k, Sum([TTn�lk�l]) AS NemTT
FROM (SELECT DISTINCT lkHozz�tartoz�k.[Dolgoz� ad�azonos�t� jele], 1 AS f�, Abs([Tart�s t�voll�t t�pusa] Is Null) AS TTn�lk�l FROM lkHozz�tartoz�k INNER JOIN lkSzem�lyek ON lkHozz�tartoz�k.Ad�jel = lkSzem�lyek.Ad�jel WHERE lkSzem�lyek.[St�tusz neve]="�ll�shely" And lkHozz�tartoz�k.[Sz�let�si id�]>DateSerial(Year(Now())-6,Month(Now()),Day(Now())) And (lkHozz�tartoz�k.[Kapcsolat jellege]="Gyermek" Or lkHozz�tartoz�k.[Kapcsolat jellege]="Nevelt (mostoha)" Or lkHozz�tartoz�k.[Kapcsolat jellege]="�r�kbe fogadott"))  AS allek�rdez�sEgyedi;

-- [lkDolgoz�kL�tsz�maT�bb18�vAlattiGyermekkel]
SELECT "Dolgoz�k l�tsz�ma t�bb 18 �v alatti gyermekkel:" AS Adat, Sum([darab]) AS �rt�k, Sum(IIf([NemTT]<>0,[darab],0)) AS NemTT_
FROM lkDolgoz�kT�bb18�vAlattiGyermekkel;

-- [lkDolgoz�kT�bb18�vAlattiGyermekkel]
SELECT "Dolgoz�k l�tsz�ma 18 �v alatti gyermekkel:" AS Adat, Sum(lkDolgoz�k18�vAlattiGyermekkel.f�) AS �rt�k, Sum(lkDolgoz�k18�vAlattiGyermekkel.[TTn�lk�l]) AS NemTT, 1 AS darab
FROM lkDolgoz�k18�vAlattiGyermekkel
GROUP BY 1, lkDolgoz�k18�vAlattiGyermekkel.[Dolgoz� ad�azonos�t� jele]
HAVING (((Sum(lkDolgoz�k18�vAlattiGyermekkel.[f�]))>1));

-- [lkDolgoz�kV�gzetts�geiFelsorol�s01]
SELECT lkSzem�lyekV�gzetts�geinekSz�ma.V�gzetts�geinekASz�ma, lkV�gzetts�gek.Ad�jel, lkV�gzetts�gek.[V�gzetts�g neve], Min(lkV�gzetts�gek.Azonos�t�) AS Azonos�t�k
FROM lkSzem�lyekV�gzetts�geinekSz�ma INNER JOIN lkV�gzetts�gek ON lkSzem�lyekV�gzetts�geinekSz�ma.Ad�jel = lkV�gzetts�gek.Ad�jel
GROUP BY lkSzem�lyekV�gzetts�geinekSz�ma.V�gzetts�geinekASz�ma, lkV�gzetts�gek.Ad�jel, lkV�gzetts�gek.[V�gzetts�g neve];

-- [lkDolgoz�kV�gzetts�geiFelsorol�s02]
SELECT 1+(Select count(Tmp.Azonos�t�k) From tDolgoz�kV�gzetts�geiFelsorol�s01 as Tmp Where Tmp.Ad�jel=tDolgoz�kV�gzetts�geiFelsorol�s01.Ad�jel AND Tmp.Azonos�t�k<tDolgoz�kV�gzetts�geiFelsorol�s01.Azonos�t�k ) AS Sorsz�m, tDolgoz�kV�gzetts�geiFelsorol�s01.V�gzetts�geinekASz�ma, tDolgoz�kV�gzetts�geiFelsorol�s01.Ad�jel, tDolgoz�kV�gzetts�geiFelsorol�s01.[V�gzetts�g neve]
FROM tDolgoz�kV�gzetts�geiFelsorol�s01;

-- [lkDolgoz�kV�gzetts�geiFelsorol�s03]
PARAMETERS �ss�l_egy_entert Long;
TRANSFORM First(tDolgoz�kV�gzetts�geiFelsorol�s02.[V�gzetts�g neve]) AS [FirstOfV�gzetts�g neve]
SELECT tDolgoz�kV�gzetts�geiFelsorol�s02.Ad�jel, tDolgoz�kV�gzetts�geiFelsorol�s02.V�gzetts�geinekASz�ma
FROM tDolgoz�kV�gzetts�geiFelsorol�s02
GROUP BY tDolgoz�kV�gzetts�geiFelsorol�s02.Ad�jel, tDolgoz�kV�gzetts�geiFelsorol�s02.V�gzetts�geinekASz�ma
PIVOT tDolgoz�kV�gzetts�geiFelsorol�s02.Sorsz�m In (1,2,3,4,5,6,7,8,9,10,11,12);

-- [lkDolgoz�kV�gzetts�geiFelsorol�s04]
SELECT lkDolgoz�kV�gzetts�geiFelsorol�s03.Ad�jel, lkDolgoz�kV�gzetts�geiFelsorol�s03.V�gzetts�geinekASz�ma, strim([1] & ", " & [2] & ", " & [3] & ", " & [4] & ", " & [5] & ", " & [6] & ", " & [7] & ", " & [8] & ", " & [9] & ", " & [10] & ", " & [11] & ", " & [12],", ") AS V�gzetts�gei
FROM lkDolgoz�kV�gzetts�geiFelsorol�s03;

-- [lkDolgoz�kV�gzetts�geiFelsorol�sTmp]
SELECT Count(Tmp.Azonos�t�k) AS CountOfAzonos�t�k
FROM lkDolgoz�kV�gzetts�geiFelsorol�s01 AS Tmp
WHERE (((Tmp.Ad�jel)=lkDolgoz�kV�gzetts�geiFelsorol�s01.Ad�jel) And ((Tmp.Azonos�t�k)<lkDolgoz�kV�gzetts�geiFelsorol�s01.Azonos�t�k));

-- [lkEg�szs�g�gyiAlkalmass�giVizsga]
SELECT lkSzem�lyek.F�oszt�ly AS F�oszt�ly, lkSzem�lyek.Oszt�ly AS Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[Hivatali telefon] AS [Hivatali telefon], lkSzem�lyek.[Hivatali email] AS [Hivatali email], Format([TAJ sz�m] & ""," @") AS TAJ, lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS Bel�p�s, kt_azNexon_Ad�jel02.NLink AS NLink
FROM lkSzem�lyek LEFT JOIN kt_azNexon_Ad�jel02 ON lkSzem�lyek.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel
WHERE (((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])>=DateSerial(Year(DateAdd("m",-3,Date())),Month(DateAdd("m",-3,Date())),1)) AND ((lkSzem�lyek.[Orvosi vizsg�lat k�vetkez� id�pontja]) Is Null) AND ((lkSzem�lyek.[Orvosi vizsg�lat eredm�nye]) Is Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])>=DateSerial(Year(DateAdd("m",-3,Date())),Month(DateAdd("m",-3,Date())),1)) AND ((lkSzem�lyek.[Orvosi vizsg�lat k�vetkez� id�pontja])<[Jogviszony kezdete (bel�p�s d�tuma)]) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)], lkSzem�lyek.BFKH;

-- [lkEg�szs�g�gyiSzolg�ltat�AdataiUni�]
SELECT tEg�szs�g�gyiSzolg�ltat�Adatai02.*
FROM tEg�szs�g�gyiSzolg�ltat�Adatai02
UNION SELECT tEg�szs�g�gyiSzolg�ltat�Adatai01.*
FROM  tEg�szs�g�gyiSzolg�ltat�Adatai01;

-- [lkEgyesMunkak�r�kF�oszt�lyai]
SELECT tEgyesMunkak�r�kF�oszt�lyai.Azonos�t�, bfkh([tEgyesMunkak�r�kF�oszt�lyai].[F�oszt�ly]) AS F�oszt�ly, tEgyesMunkak�r�kF�oszt�lyai.Oszt�ly
FROM tEgyesMunkak�r�kF�oszt�lyai;

-- [lkEgyesOszt�lyokTisztvisel�i_lkSzem�lyek]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS Bel�p�s, IIf(Nz([Tart�s t�voll�t t�pusa],"")="","","tart�san t�voll�v�") AS [Tart�san t�voll�v�]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.F�oszt�ly) Like "* I. *") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]) Like "korm�ny*")) OR (((lkSzem�lyek.F�oszt�ly) Like "* XII. *")) OR (((lkSzem�lyek.F�oszt�ly) Like "* XXI. *")) OR (((lkSzem�lyek.F�oszt�ly) Like "* XXIII. *")) OR (((lkSzem�lyek.F�oszt�ly) Like "* VI. *"))
ORDER BY bfkh([Szervezeti egys�g k�dja]), lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)], lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkEgyF�oszt�lyAkt�vDolgoz�iEmailFeladat]
SELECT lkSzem�lyek.[Szervezeti egys�g neve], lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Hivatali email], lkSzem�lyek.[KIRA feladat megnevez�s]
FROM lkSzem�lyek INNER JOIN tBesorol�s�talak�t�Elt�r�Besorol�shoz ON lkSzem�lyek.jel2 = tBesorol�s�talak�t�Elt�r�Besorol�shoz.jel
WHERE (((lkSzem�lyek.F�oszt�ly) Like "Lak�s*") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null))
ORDER BY lkSzem�lyek.BFKH, tBesorol�s�talak�t�Elt�r�Besorol�shoz.rang DESC , IIf(InStr([KIRA feladat megnevez�s],"vezet�")>0,1,2);

-- [lkEgyF�oszt�lyIlletm�nyei(n�v_bes_illetm�ny)]
SELECT Replace([lkSzem�lyek].[Oszt�ly],"Hum�npolitikai Oszt�ly","") AS Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Besorol�si  fokozat (KT)], lkSzem�lyek.[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.F�oszt�ly) Like [F�oszt�ly nev�nek r�szlete] & "*") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null))
ORDER BY Replace([lkSzem�lyek].[Oszt�ly],"Hum�npolitikai Oszt�ly",""), lkSzem�lyek.[Besorol�si  fokozat (KT)];

-- [lk�letkorok]
SELECT Int(Sqr([T�rzssz�m])) AS Sz�m, DateDiff("yyyy",[Sz�let�si id�],Date()) AS �letkor
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [lkElismer�sreJogos�t�Id�tCsakABfkhbanSzerzettek]
SELECT lk�sszesJogviszonyId�tartamSzem�lyek.Ad�jel, Date()-Dt�tal([Szolg�lati elismer�sre jogosults�g / Jubileumi jutalom kezd� d�t])+1 AS Elsimer�sreJogos�t�Id�tartam
FROM lkSzolg�latiId�Elismer�s INNER JOIN lk�sszesJogviszonyId�tartamSzem�lyek ON lkSzolg�latiId�Elismer�s.Ad�jel = lk�sszesJogviszonyId�tartamSzem�lyek.Ad�jel
WHERE (((Date()-Dt�tal([Szolg�lati elismer�sre jogosults�g / Jubileumi jutalom kezd� d�t])+1)=[�sszId�tartam]));

-- [lkElk�sz�lt�ll�shelyek�NYR]
SELECT lk�ll�shelyekBels�Eloszt�saF�oszt�lyOszt�ly.F�oszt AS [Enged�ly szerinti f�oszt�ly], lk�ll�shelyek.F�oszt AS [�NYR szerinti f�oszt�ly], lk�ll�shelyekBels�Eloszt�saF�oszt�lyOszt�ly.[�ll�shely azonos�t�]
FROM lk�ll�shelyek INNER JOIN lk�ll�shelyekBels�Eloszt�saF�oszt�lyOszt�ly ON lk�ll�shelyek.[�ll�shely azonos�t�] = lk�ll�shelyekBels�Eloszt�saF�oszt�lyOszt�ly.[�ll�shely azonos�t�]
WHERE (((lk�ll�shelyek.F�oszt)<>[lk�ll�shelyekBels�Eloszt�saF�oszt�lyOszt�ly].[F�oszt]));

-- [lkElk�sz�lt�ll�shelyekNexon]
SELECT lk�ll�shelyekBels�Eloszt�saF�oszt�lyOszt�ly.F�oszt AS [Enged�ly szerinti f�oszt�ly], lk�ll�shelyekHavib�l.F�oszt, lk�ll�shelyekBels�Eloszt�saF�oszt�lyOszt�ly.[�ll�shely azonos�t�]
FROM lk�ll�shelyekBels�Eloszt�saF�oszt�lyOszt�ly INNER JOIN lk�ll�shelyekHavib�l ON lk�ll�shelyekBels�Eloszt�saF�oszt�lyOszt�ly.[�ll�shely azonos�t�] = lk�ll�shelyekHavib�l.[�ll�shely azonos�t�]
WHERE (((lk�ll�shelyekHavib�l.F�oszt)<>[lk�ll�shelyekBels�Eloszt�saF�oszt�lyOszt�ly].[F�oszt]));

-- [lkEllen�rz�s_03_e-mail_c�mek]
SELECT DISTINCT lk_Ellen�rz�s_03.TO AS Kif1
FROM lk_Ellen�rz�s_03;

-- [lkEllen�rz�s_ProjektesekAlapl�tsz�mon]
SELECT DISTINCT lkSzem�lyek.F�oszt�ly AS F�oszt�ly, lkSzem�lyek.Oszt�ly AS Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[St�tusz k�lts�ghely�nek neve] AS K�lts�ghely, lkSzem�lyek.[St�tusz k�lts�ghely�nek k�dja] AS [K�lts�ghely k�d], kt_azNexon_Ad�jel02.NLink AS NLink, lkSzem�lyek.[St�tusz neve]
FROM kt_azNexon_Ad�jel02 RIGHT JOIN lkSzem�lyek ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND (([lkSzem�lyek].[St�tusz k�lts�ghely�nek neve]) Is Not Null) AND ((lkSzem�lyek.[St�tusz t�pusa])="Szervezeti alapl�tsz�m")) OR (((lkSzem�lyek.[St�tusz k�lts�ghely�nek k�dja]) Is Not Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[St�tusz t�pusa])="Szervezeti alapl�tsz�m"));

-- [lkEllen�rz�s_t�bbsz�r�sJogviszony]
SELECT "K�zpontos�tottak" AS T�bla, "K�t utols� jogviszonya van a Nexonban." AS Adathiba, lkSzem�lyek.[Ad�azonos�t� jel], lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.bfkh AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], lkSzem�lyek.[KIRA jogviszony jelleg]
FROM lkSzem�lyek INNER JOIN (SELECT lkSzem�lyek.[Ad�azonos�t� jel], Count(lkSzem�lyek.[Ad�azonos�t� jel]) AS [CountOfAd�azonos�t� jel] FROM lkSzem�lyek GROUP BY lkSzem�lyek.[Ad�azonos�t� jel] HAVING (((Count(lkSzem�lyek.[Ad�azonos�t� jel]))>1)))  AS T�bbsz�r�sek ON lkSzem�lyek.[Ad�azonos�t� jel] = T�bbsz�r�sek.[Ad�azonos�t� jel]
WHERE (("KIRA jogviszony jelleg "="Fegyveres szervek hiv. �llom�ny� tagjainak szolgv." Or (lkSzem�lyek.[KIRA jogviszony jelleg])="Korm�nyzati szolg�lati jogviszony (KIT)" Or (lkSzem�lyek.[KIRA jogviszony jelleg])="Megb�z�si jogviszony" Or (lkSzem�lyek.[KIRA jogviszony jelleg])="Munkaviszony" Or (lkSzem�lyek.[KIRA jogviszony jelleg])="Politikai jogviszony" Or (lkSzem�lyek.[KIRA jogviszony jelleg])="Rendv�delmi igazgat�si, szolg�lati jogviszony"));

-- [lkEllen�rz�s_vezet�kFeladatk�reBeoszt�sa]
SELECT lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Szervezeti egys�g neve], lkSzem�lyek.Besorol�s, lkSzem�lyek.Feladatok, lkSzem�lyek.Feladatk�r, lkSzem�lyek.[KIRA feladat megnevez�s], lkSzem�lyek.[Vezet�i beoszt�s megnevez�se], lkSzem�lyek.[Vezet�i megb�z�s t�pusa]
FROM kt_azNexon_Ad�jel INNER JOIN lkSzem�lyek ON kt_azNexon_Ad�jel.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.Besorol�s) Like "j�r�si*" Or (lkSzem�lyek.Besorol�s) Like "*igazgat�*" Or (lkSzem�lyek.Besorol�s) Like "*oszt�ly*") AND ((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null))
ORDER BY lkSzem�lyek.[Szervezeti egys�g k�dja], lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkEllen�rz�_Lek�rdez�sek__NEM_�res]
SELECT tJav�tand�Mez�nevek.azJav�tand�, "SELECT '"          & [Ellen�rz�shez] & "' AS T�bla, '"          & [Eredeti] & "' AS Hi�nyz�_�rt�k, "          & [Ellen�rz�shez] & ".[Ad�azonos�t�], "          & [Ellen�rz�shez] & ".[�ll�shely azonos�t�], "          & [Ellen�rz�shez] & ".[" & [SzervezetK�d_mez�] & "] " AS [Select], "FROM [" & [Ellen�rz�shez] & "] " AS [From], "WHERE ([" & [Ellen�rz�shez] & "].[" & [Import] & "] Is Null " & IIf([Sz�veg],"OR [" & [Ellen�rz�shez] & "].[" & [Import] & "]='') ",") ") & IIf(IsNull([�res�ll�shelyMez�k]),""," AND ([" & [Ellen�rz�shez] & "].[" & [�res�ll�shelyMez�k] & "]<> '�res �ll�s' OR [" & [Ellen�rz�shez] & "].[" & [�res�ll�shelyMez�k] & "] is null ) ") AS [Where], tJav�tand�Mez�nevek.NemK�telez�, tJav�tand�Mez�nevek.NemK�telez��res�ll�shelyEset�n, [Select] & [From] & [Where] AS [SQL], Len([SQL]) AS Hossz, tJav�tand�Mez�nevek.Ellen�rz�shez
FROM tJav�tand�Mez�nevek
WHERE (((tJav�tand�Mez�nevek.NemK�telez�)=False) AND ((tJav�tand�Mez�nevek.Ellen�rz�shez) Is Not Null))
ORDER BY tJav�tand�Mez�nevek.azJav�tand�;

-- [lkEllen�rz�_Lek�rdez�sek__�RES]
SELECT "SELECT '" & [T�bla] & "' AS T�bla, '" & [Import] & "' AS Hi�nyz�_�rt�k, " & [T�bla] & ".[Ad�azonos�t�], " & [T�bla] & ".[�ll�shely azonos�t�], " & [T�bla] & ".[�NYR SZERVEZETI EGYS�G AZONOS�T�] " AS [Select], "FROM [" & [T�bla] & "] " AS [From], "
WHERE ([" & [T�bla] & "].[" & [Import] & "] Is Null OR [" & [T�bla] & "].[" & [Import] & "] = '')" & IIf(IsNull([�res�ll�shelyMez�k]),""," AND [" & [T�bla] & "].[" & [�res�ll�shelyMez�k] & "] = '�res �ll�s' ") AS [Where], tJav�tand�Mez�nevek.azJav�tand�, tJav�tand�Mez�nevek.NemK�telez�, tJav�tand�Mez�nevek.NemK�telez��res�ll�shelyEset�n, [Select] & [From] & [Where] AS [SQL], Len([SQL]) AS Hossz
FROM tJav�tand�Mez�nevek
WHERE (((tJav�tand�Mez�nevek.NemK�telez�)=True) AND ((tJav�tand�Mez�nevek.NemK�telez��res�ll�shelyEset�n)=False));

-- [lkEllen�rz�_Lek�rdez�sek_�RES_union]
SELECT 'Kil�p�k' AS T�bla, 'Besorol�si fokozat megnevez�se:' AS Hi�nyz�_�rt�k, Kil�p�k.[Ad�azonos�t�], Kil�p�k.[�ll�shely azonos�t�], Kil�p�k.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Kil�p�k] 
WHERE ([Kil�p�k].[Besorol�si fokozat megnevez�se:] Is Null OR [Kil�p�k].[Besorol�si fokozat megnevez�se:] = '')
UNION
SELECT 'Hat�rozottak' AS T�bla, 'Megyei szint VAGY J�r�si Hivatal' AS Hi�nyz�_�rt�k, Hat�rozottak.[Ad�azonos�t�], Hat�rozottak.[�ll�shely azonos�t�], Hat�rozottak.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Hat�rozottak] 
WHERE ([Hat�rozottak].[Megyei szint VAGY J�r�si Hivatal] Is Null OR [Hat�rozottak].[Megyei szint VAGY J�r�si Hivatal] = '')
UNION
SELECT 'Hat�rozottak' AS T�bla, 'Mez�5' AS Hi�nyz�_�rt�k, Hat�rozottak.[Ad�azonos�t�], Hat�rozottak.[�ll�shely azonos�t�], Hat�rozottak.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Hat�rozottak] 
WHERE ([Hat�rozottak].[Mez�5] Is Null OR [Hat�rozottak].[Mez�5] = '')
UNION
SELECT 'Hat�rozottak' AS T�bla, 'Mez�6' AS Hi�nyz�_�rt�k, Hat�rozottak.[Ad�azonos�t�], Hat�rozottak.[�ll�shely azonos�t�], Hat�rozottak.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Hat�rozottak] 
WHERE ([Hat�rozottak].[Mez�6] Is Null OR [Hat�rozottak].[Mez�6] = '')
UNION
SELECT 'Hat�rozottak' AS T�bla, '�NYR SZERVEZETI EGYS�G AZONOS�T�' AS Hi�nyz�_�rt�k, Hat�rozottak.[Ad�azonos�t�], Hat�rozottak.[�ll�shely azonos�t�], Hat�rozottak.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Hat�rozottak] 
WHERE ([Hat�rozottak].[�NYR SZERVEZETI EGYS�G AZONOS�T�] Is Null OR [Hat�rozottak].[�NYR SZERVEZETI EGYS�G AZONOS�T�] = '')
UNION
SELECT 'Hat�rozottak' AS T�bla, 'Besorol�si fokozat megnevez�se:' AS Hi�nyz�_�rt�k, Hat�rozottak.[Ad�azonos�t�], Hat�rozottak.[�ll�shely azonos�t�], Hat�rozottak.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Hat�rozottak] 
WHERE ([Hat�rozottak].[Besorol�si fokozat megnevez�se:] Is Null OR [Hat�rozottak].[Besorol�si fokozat megnevez�se:] = '')
UNION SELECT 'Hat�rozottak' AS T�bla, 'Mez�24' AS Hi�nyz�_�rt�k, Hat�rozottak.[Ad�azonos�t�], Hat�rozottak.[�ll�shely azonos�t�], Hat�rozottak.[�NYR SZERVEZETI EGYS�G AZONOS�T�] FROM [Hat�rozottak] 
WHERE ([Hat�rozottak].[Mez�24] Is Null OR [Hat�rozottak].[Mez�24] = '');

-- [lkEllen�rz�Lek�rdez�sek]
SELECT *
FROM lkEllen�rz�Lek�rdez�sek2
WHERE (((lkEllen�rz�Lek�rdez�sek2.[Oszt�ly])=[qWhere]))
ORDER BY lkEllen�rz�Lek�rdez�sek2.[LapN�v], lkEllen�rz�Lek�rdez�sek2.[T�blaC�m];

-- [lkEllen�rz�Lek�rdez�sek2]
SELECT [Lek�rdez�sek(tEllen�rz�Lek�rdez�sek)].azEllen�rz�, [Lek�rdez�sek(tEllen�rz�Lek�rdez�sek)].Ellen�rz�Lek�rdez�s, [Lek�rdez�sek(tEllen�rz�Lek�rdez�sek)].T�blac�m, IIf([graftulajdons�g]="Type",[graftul�rt�k],"") AS VaneGraf, [Lek�rdez�sek(tEllen�rz�Lek�rdez�sek)].Kimenet, [Lek�rdez�sek(tEllen�rz�Lek�rdez�sek)].KellVisszajelzes, [Lek�rdez�sek(tEllen�rz�Lek�rdez�sek)].azUnion, [Lek�rdez�sek(tEllen�rz�Lek�rdez�sek)].T�blaMegjegyz�s, [Fejezetek(tLek�rdez�sT�pusok)].azET�pus, [Fejezetek(tLek�rdez�sT�pusok)].T�pusNeve, [Fejezetek(tLek�rdez�sT�pusok)].LapN�v, [Fejezetek(tLek�rdez�sT�pusok)].Megjegyz�s, [Fejezetek(tLek�rdez�sT�pusok)].Oszt�ly, [Fejezetek(tLek�rdez�sT�pusok)].vbaPostProcessing, [Lek�rdez�sek(tEllen�rz�Lek�rdez�sek)].Sorrend, [Fejezetek(tLek�rdez�sT�pusok)].Sorrend, [Lek�rdez�sek(tEllen�rz�Lek�rdez�sek)].Sorrend
FROM tLek�rdez�sOszt�lyok AS [Oldalak(tLek�rdez�sOszt�lyok)] INNER JOIN ((tLek�rdez�sT�pusok AS [Fejezetek(tLek�rdez�sT�pusok)] INNER JOIN tEllen�rz�Lek�rdez�sek AS [Lek�rdez�sek(tEllen�rz�Lek�rdez�sek)] ON [Fejezetek(tLek�rdez�sT�pusok)].azET�pus = [Lek�rdez�sek(tEllen�rz�Lek�rdez�sek)].azET�pus) LEFT JOIN tGrafikonok ON [Lek�rdez�sek(tEllen�rz�Lek�rdez�sek)].azEllen�rz� = tGrafikonok.azEllen�rz�) ON [Oldalak(tLek�rdez�sOszt�lyok)].azOszt�ly = [Fejezetek(tLek�rdez�sT�pusok)].Oszt�ly
ORDER BY [Lek�rdez�sek(tEllen�rz�Lek�rdez�sek)].Sorrend, [Fejezetek(tLek�rdez�sT�pusok)].Sorrend, [Lek�rdez�sek(tEllen�rz�Lek�rdez�sek)].Sorrend;

-- [lkEllen�rz�Lek�rdez�sek2csakLek�rdez�sek]
SELECT DISTINCT lkEllen�rz�Lek�rdez�sek2.Ellen�rz�Lek�rdez�s
FROM lkEllen�rz�Lek�rdez�sek2
ORDER BY lkEllen�rz�Lek�rdez�sek2.Ellen�rz�Lek�rdez�s;

-- [lkEllen�rz�Lek�rdez�sek2Mez�nevekkel]
SELECT DISTINCT mSyslkMez�nevek.Alias, tEllen�rz�Lek�rdez�sek.Ellen�rz�Lek�rdez�s, tLek�rdez�sMez�T�pusok.Mez�Neve
FROM (tEllen�rz�Lek�rdez�sek INNER JOIN mSyslkMez�nevek ON tEllen�rz�Lek�rdez�sek.Ellen�rz�Lek�rdez�s = mSyslkMez�nevek.QueryName) LEFT JOIN tLek�rdez�sMez�T�pusok ON (mSyslkMez�nevek.QueryName = tLek�rdez�sMez�T�pusok.Lek�rdez�sNeve) AND (mSyslkMez�nevek.Alias = tLek�rdez�sMez�T�pusok.Mez�Neve)
WHERE (((tEllen�rz�Lek�rdez�sek.Ellen�rz�Lek�rdez�s)=[�rlapok]![�Ellen�rz�Lek�rdez�sek2]![A lek�rdez�s mez�k t�pusai:]![Lek�rdez�sNeve]) AND ((tLek�rdez�sMez�T�pusok.mezoAz) Is Null) AND ((tEllen�rz�Lek�rdez�sek.Kimenet)=True))
ORDER BY tEllen�rz�Lek�rdez�sek.Ellen�rz�Lek�rdez�s, mSyslkMez�nevek.Alias;

-- [lkEllen�rz�Lek�rdez�sek2�rlaphoz]
SELECT tLek�rdez�sOszt�lyok.Sorrend AS [Oldalak sorrendje], tLek�rdez�sT�pusok.Sorrend AS [Fejezetek sorrendje], tEllen�rz�Lek�rdez�sek.Sorrend AS [Lek�rdez�sek sorrendje], tEllen�rz�Lek�rdez�sek.azEllen�rz�, tEllen�rz�Lek�rdez�sek.Ellen�rz�Lek�rdez�s, tEllen�rz�Lek�rdez�sek.T�blac�m, tEllen�rz�Lek�rdez�sek.Kimenet, tEllen�rz�Lek�rdez�sek.KellVisszajelzes, tEllen�rz�Lek�rdez�sek.azUnion, tEllen�rz�Lek�rdez�sek.T�blaMegjegyz�s, tEllen�rz�Lek�rdez�sek.azET�pus, tEllen�rz�Lek�rdez�sek.El�zm�nyUni�
FROM tLek�rdez�sOszt�lyok INNER JOIN (tLek�rdez�sT�pusok INNER JOIN tEllen�rz�Lek�rdez�sek ON tLek�rdez�sT�pusok.azET�pus = tEllen�rz�Lek�rdez�sek.azET�pus) ON tLek�rdez�sOszt�lyok.azOszt�ly = tLek�rdez�sT�pusok.Oszt�ly
WHERE (((tEllen�rz�Lek�rdez�sek.T�blac�m) Like "*" & [�rlapok]![�Ellen�rz�Lek�rdez�sek2]![Keres�s] & "*")) OR (((tEllen�rz�Lek�rdez�sek.Ellen�rz�Lek�rdez�s) Like "*" & [�rlapok]![�Ellen�rz�Lek�rdez�sek2]![Keres�s] & "*")) OR (((tEllen�rz�Lek�rdez�sek.T�blaMegjegyz�s) Like "*" & [�rlapok]![�Ellen�rz�Lek�rdez�sek2]![Keres�s] & "*"))
ORDER BY tLek�rdez�sOszt�lyok.Sorrend, tLek�rdez�sT�pusok.Sorrend, tEllen�rz�Lek�rdez�sek.Sorrend, tEllen�rz�Lek�rdez�sek.T�blac�m;

-- [lkEllen�rz�Lek�rdez�sek3]
SELECT tLek�rdez�sT�pusok.Sorrend AS Fejezetsorrend, tEllen�rz�Lek�rdez�sek.Sorrend AS Leksorrend, tEllen�rz�Lek�rdez�sek.Ellen�rz�Lek�rdez�s, tLek�rdez�sT�pusok.LapN�v, tLek�rdez�sT�pusok.Oszt�ly, tLek�rdez�sT�pusok.Megjegyz�s, tEllen�rz�Lek�rdez�sek.T�blac�m, Nz([graftul�rt�k],"") AS vaneGraf, tLek�rdez�sT�pusok.azET�pus, tEllen�rz�Lek�rdez�sek.Kimenet, tEllen�rz�Lek�rdez�sek.KellVisszajelzes, tEllen�rz�Lek�rdez�sek.azUnion, tEllen�rz�Lek�rdez�sek.T�blaMegjegyz�s, tEllen�rz�Lek�rdez�sek.azHibaCsoport
FROM (tLek�rdez�sT�pusok INNER JOIN tEllen�rz�Lek�rdez�sek ON tLek�rdez�sT�pusok.azET�pus = tEllen�rz�Lek�rdez�sek.azET�pus) LEFT JOIN tGrafikonok ON tEllen�rz�Lek�rdez�sek.azEllen�rz� = tGrafikonok.azEllen�rz�
WHERE (((tGrafikonok.grafTulajdons�g)="Type" Or (tGrafikonok.grafTulajdons�g) Is Null))
ORDER BY tLek�rdez�sT�pusok.Oszt�ly, tLek�rdez�sT�pusok.LapN�v, tEllen�rz�Lek�rdez�sek.T�blac�m, tLek�rdez�sT�pusok.azET�pus;

-- [lkEllen�rz�Lek�rdez�sekHi�nyosMez�t�pussal]
SELECT lkLek�rdez�sekMez�inekSz�ma.Ellen�rz�Lek�rdez�s, lkLek�rdez�sekMez�inekSz�ma.CountOfAttribute, lkEllen�rz�Lek�rdez�sekT�pusolMez�inekSz�ma.CountOfMez�Neve, lkEllen�rz�Lek�rdez�sekT�pusolMez�inekSz�ma.Ellen�rz�Lek�rdez�s
FROM lkLek�rdez�sekMez�inekSz�ma RIGHT JOIN lkEllen�rz�Lek�rdez�sekT�pusolMez�inekSz�ma ON lkLek�rdez�sekMez�inekSz�ma.Ellen�rz�Lek�rdez�s = lkEllen�rz�Lek�rdez�sekT�pusolMez�inekSz�ma.Ellen�rz�Lek�rdez�s
WHERE (((lkEllen�rz�Lek�rdez�sekT�pusolMez�inekSz�ma.CountOfMez�Neve)<[CountOfAttribute]));

-- [lkEllen�rz�Lek�rdez�sekMez�neveiAliassal]
SELECT DISTINCT tEllen�rz�Lek�rdez�sek.Ellen�rz�Lek�rdez�s, mSyslkMez�nevek.Mez�N�v, Replace(Replace(ffsplit([mSyslkMez�nevek].[Mez�N�v],".",2),"[",""),"]","") AS [Javasolt alias]
FROM mSyslkMez�nevek AS mSyslkMez�nevek_1, mSyslkMez�nevek INNER JOIN tEllen�rz�Lek�rdez�sek ON mSyslkMez�nevek.QueryName = tEllen�rz�Lek�rdez�sek.Ellen�rz�Lek�rdez�s
WHERE (((mSyslkMez�nevek.Mez�N�v) Like "*" & [mSyslkMez�nevek_1].[QueryName] & "*"));

-- [lkEllen�rz�Lek�rdez�sekSeg�d�rlaphoz]
SELECT tEllen�rz�Lek�rdez�sek.azET�pus, tEllen�rz�Lek�rdez�sek.azEllen�rz�, tEllen�rz�Lek�rdez�sek.T�blac�m, tEllen�rz�Lek�rdez�sek.Sorrend
FROM tEllen�rz�Lek�rdez�sek;

-- [lkEllen�rz�Lek�rdez�sekT�pusolMez�inekSz�ma]
SELECT lkEllen�rz�Lek�rdez�sek2.Ellen�rz�Lek�rdez�s, Count(tLek�rdez�sMez�T�pusok.Mez�Neve) AS CountOfMez�Neve
FROM lkEllen�rz�Lek�rdez�sek2 LEFT JOIN tLek�rdez�sMez�T�pusok ON lkEllen�rz�Lek�rdez�sek2.Ellen�rz�Lek�rdez�s = tLek�rdez�sMez�T�pusok.Lek�rdez�sNeve
WHERE (((lkEllen�rz�Lek�rdez�sek2.Kimenet)=True))
GROUP BY lkEllen�rz�Lek�rdez�sek2.Ellen�rz�Lek�rdez�s;

-- [lkEllen�rz�Lek�rdez�sVanegraf]
SELECT tEllen�rz�Lek�rdez�sek.Ellen�rz�Lek�rdez�s, IIf([tGrafikonok].[azEllen�rz�] Is Null,0,-1) AS VaneGraf
FROM tEllen�rz�Lek�rdez�sek LEFT JOIN tGrafikonok ON tEllen�rz�Lek�rdez�sek.azEllen�rz� = tGrafikonok.azEllen�rz�;

-- [lkEls�Oszt�lyvezet�v�Sorol�sD�tuma]
SELECT [Ad�azonos�t� jel]*1 AS Ad�jel, Min(tBesorol�siEredm�nyadatok.[V�ltoz�s d�tuma]) AS [MinOfV�ltoz�s d�tuma]
FROM tBesorol�siEredm�nyadatok
WHERE (((tBesorol�siEredm�nyadatok.[Besorol�si fokozat12])="Oszt�lyvezet�"))
GROUP BY [Ad�azonos�t� jel]*1;

-- [lkElt�r�sBanksz�mlasz�mPGFNexon]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], ffsplit([Utal�si c�m],"|",3) AS Banksz�mlasz�m, PGF_2025_02.Foly�sz�mlasz�m
FROM lkSzem�lyek INNER JOIN PGF_2025_02 ON lkSzem�lyek.Ad�jel = PGF_2025_02.[Ad�azonos�t� jel]
WHERE (((Replace(Nz(ffsplit([Utal�si c�m],"|",3),""),"-00000000",""))<>Replace(Nz([Foly�sz�mlasz�m],""),"-00000000","")))
ORDER BY lkSzem�lyek.BFKH;

-- [lkElt�r�Besorol�sokLechnernek]
SELECT lkSzem�lyek.Ad�jel, "" AS [HR kapcsolat azonos�t�], #1/1/2024# AS [�rv�nyess�g kezdete], tBesorol�siK�dok.K�d, tBesorol�s�talak�t�Elt�r�Besorol�shoz.[Besorol�si  fokozat (KT)] AS �NYR, lkSzem�lyek.[Besorol�si  fokozat (KT)] AS [Nexon szem�lyt�rzs], lkBesorol�sV�ltoztat�sok.R�giBesorol�s, lkBesorol�sV�ltoztat�sok.�jBesorol�s, lk�ll�shelyek.[�ll�shely azonos�t�]
FROM lkBesorol�sV�ltoztat�sok RIGHT JOIN (tBesorol�siK�dok INNER JOIN (lkSzem�lyek INNER JOIN (lk�ll�shelyek INNER JOIN tBesorol�s�talak�t�Elt�r�Besorol�shoz ON lk�ll�shelyek.[�ll�shely besorol�si kateg�ri�ja] = tBesorol�s�talak�t�Elt�r�Besorol�shoz.[�ll�shely besorol�si kateg�ri�ja]) ON lkSzem�lyek.[St�tusz k�dja] = lk�ll�shelyek.[�ll�shely azonos�t�]) ON tBesorol�siK�dok.Besorol�s = tBesorol�s�talak�t�Elt�r�Besorol�shoz.[Besorol�si  fokozat (KT)]) ON lkBesorol�sV�ltoztat�sok.�ll�shelyAzonos�t� = lk�ll�shelyek.[�ll�shely azonos�t�]
WHERE (((tBesorol�s�talak�t�Elt�r�Besorol�shoz.[Besorol�si  fokozat (KT)])<>[lkSzem�lyek].[Besorol�si  fokozat (KT)]) AND ((lkBesorol�sV�ltoztat�sok.R�giBesorol�s) Is Not Null));

-- [lkElt�r�Besorol�sok�j01]
SELECT DISTINCT lkSzem�lyek.Ad�jel, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzervezeti�ll�shelyek.[Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s] AS [Szervezeti strukt�ra], lkBesorol�sV�ltoztat�sok.�jBesorol�s, lkSzem�lyek.Besorol�s AS [Szem�lyi karton], lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus], lkSzem�lyek.[Tart�s t�voll�t t�pusa], lkSzervezeti�ll�shelyek.�ll�shelyAzonos�t� AS [�ll�shely azonos�t�], kt_azNexon_Ad�jel02.NLink, bfkh([SzervezetK�d]) AS BFKH, IIf([Besorol�s]<>[�jBesorol�s],"Az elt�r�s oka: az �j besoroltat�s m�g nincs r�gz�tve a Nexon-ban.","") AS Megjegyz�s
FROM lkBesorol�sV�ltoztat�sok RIGHT JOIN (kt_azNexon_Ad�jel02 RIGHT JOIN (lkSzervezeti�ll�shelyek LEFT JOIN lkSzem�lyek ON lkSzervezeti�ll�shelyek.�ll�shelyAzonos�t� = lkSzem�lyek.[St�tusz k�dja]) ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel) ON lkBesorol�sV�ltoztat�sok.�ll�shelyAzonos�t� = lkSzervezeti�ll�shelyek.�ll�shelyAzonos�t�
WHERE (((lkSzervezeti�ll�shelyek.[Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s])<>[Besorol�s]) AND ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])<>"Munkaviszony"));

-- [lkElt�r�Besorol�sok�j02]
SELECT lkElt�r�Besorol�sok�j01.F�oszt�ly AS F�oszt�ly, lkElt�r�Besorol�sok�j01.Oszt�ly AS Oszt�ly, lkElt�r�Besorol�sok�j01.N�v AS N�v, lkElt�r�Besorol�sok�j01.[�ll�shely azonos�t�] AS [St�tusz k�d], lkElt�r�Besorol�sok�j01.[Szervezeti strukt�ra] AS [Szervezeti strukt�r�ban], lkElt�r�Besorol�sok�j01.[Szem�lyi karton] AS [Szem�lyi kartonon], lkElt�r�Besorol�sok�j01.[Jogviszony t�pusa / jogviszony t�pus] AS [Jogviszony t�pusa], lkElt�r�Besorol�sok�j01.[Tart�s t�voll�t t�pusa] AS [Tart�s t�voll�t t�pusa], lkElt�r�Besorol�sok�j01.NLink AS NLink, lkElt�r�Besorol�sok�j01.Megjegyz�s AS Megjegyz�s
FROM lkElt�r�Besorol�sok�j01
ORDER BY lkElt�r�Besorol�sok�j01.BFKH;

-- [lkElt�r�Illetm�nyekHaviSzem�ly]
SELECT lkSzem�lyek.Ad�jel, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkIlletm�nyekHavi.Illetm�ny, lkSzem�lyek.[Alapilletm�ny / Munkab�r / Megb�z�si d�j (elt�r�t�s n�lk�li)], lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker], lkSzem�lyek.[Garant�lt b�rminimumra t�rt�n� kieg�sz�t�s], lkSzem�lyek.[Egy�b p�tl�k - �sszeg (elt�r�t�s n�lk�li)], lkSzem�lyek.Kerek�t�s, lkSzem�lyek.[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�t�s n�lk�li)], lkSzem�lyek.[Kerek�tett 100 %-os illetm�ny (elt�r�t�s n�lk�li)], lkSzem�lyek.[Elt�r�t�s %]
FROM lkIlletm�nyekHavi RIGHT JOIN lkSzem�lyek ON lkIlletm�nyekHavi.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[Kerek�tett 100 %-os illetm�ny (elt�r�t�s n�lk�li)])<>[lkIlletm�nyekHavi].[Illetm�ny]));

-- [lkElt�r�K�lts�ghelyek]
SELECT DISTINCT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Dolgoz� k�lts�ghely�nek k�dja], lkSzem�lyek.[Dolgoz� k�lts�ghely�nek neve], lkSzem�lyek.[St�tusz k�lts�ghely�nek k�dja], lkSzem�lyek.[St�tusz k�lts�ghely�nek neve]
FROM lkSzem�lyek;

-- [lkElt�r�Szervezetnevek2]
SELECT lk�ll�shelyek.[�ll�shely azonos�t�], lk�ll�shelyek.F�oszt�ly�ll�shely AS [F�oszt�ly (�NYR)], Nz([5 szint]) AS [Oszt�ly (�NYR)], lkSzervezeti�ll�shelyek.[Szervezeti egys�g�nek megnevez�se], lkSzervezeti�ll�shelyek.F�oszt�ly AS [F�oszt�ly (Szervezeti)], lkSzervezeti�ll�shelyek.Oszt�ly AS [Oszt�ly (Szervezeti)]
FROM lkSzervezeti�ll�shelyek INNER JOIN lk�ll�shelyek ON lkSzervezeti�ll�shelyek.�ll�shelyAzonos�t� = lk�ll�shelyek.[�ll�shely azonos�t�]
WHERE (((lkSzervezeti�ll�shelyek.Oszt�ly)<>[lk�ll�shelyek].[Oszt])) OR (((lkSzervezeti�ll�shelyek.F�oszt�ly)<>[lk�ll�shelyek].[F�oszt�ly�ll�shely]));

-- [lkELv�gzend�Besoroltat�sok00]
SELECT DISTINCT lkBesorol�siEredm�nyadatok.Ad�jel, lkBesorol�siEredm�nyadatok.kezdete10 AS Besorol�siFokozatKezdete, lkBesorol�siEredm�nyadatok.v�ge11 AS Besorol�siFokozatV�ge, lkBesorol�siEredm�nyadatok.[Utols� besorol�s d�tuma], lkBesorol�siEredm�nyadatok.V�ge AS JogviszonV�ge
FROM lkBesorol�siEredm�nyadatok
WHERE (((lkBesorol�siEredm�nyadatok.[Utols� besorol�s d�tuma]) Is Not Null) AND ((lkBesorol�siEredm�nyadatok.V�ge) Is Null Or (lkBesorol�siEredm�nyadatok.V�ge)>Date()) AND ((lkBesorol�siEredm�nyadatok.v�ge11) Is Null Or (lkBesorol�siEredm�nyadatok.v�ge11)>Date()));

-- [lkElv�gzend�Besoroltat�sok01]
SELECT DISTINCT lkSzem�lyek.BFKH, lkELv�gzend�Besoroltat�sok00.Ad�jel, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)], lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)], lkELv�gzend�Besoroltat�sok00.[Utols� besorol�s d�tuma]
FROM lkELv�gzend�Besoroltat�sok00 INNER JOIN lkSzem�lyek ON lkELv�gzend�Besoroltat�sok00.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkELv�gzend�Besoroltat�sok00.[Utols� besorol�s d�tuma])<(select dt�tal(Min([tAlapadatok].[Tulajdons�g�rt�k])) from [tAlapadatok] where [tAlapadatok].[Tulajdons�gNeve]="besoroltat�sD�tuma")) AND ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])="Korm�nyzati szolg�lati jogviszony") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.BFKH;

-- [lkElv�gzend�Besoroltat�sok02]
SELECT lkElv�gzend�Besoroltat�sok01.F�oszt�ly AS F�oszt�ly, lkElv�gzend�Besoroltat�sok01.Oszt�ly AS Oszt�ly, lkElv�gzend�Besoroltat�sok01.N�v AS N�v, lkElv�gzend�Besoroltat�sok01.[Utols� besorol�s d�tuma] AS [Utols� besorol�s d�tuma], kt_azNexon_Ad�jel02.NLink AS NLink
FROM kt_azNexon_Ad�jel02 RIGHT JOIN lkElv�gzend�Besoroltat�sok01 ON kt_azNexon_Ad�jel02.Ad�jel = lkElv�gzend�Besoroltat�sok01.Ad�jel
ORDER BY lkElv�gzend�Besoroltat�sok01.F�oszt�ly, lkElv�gzend�Besoroltat�sok01.Oszt�ly, lkElv�gzend�Besoroltat�sok01.N�v;

-- [lkElv�gzend�Besoroltat�sok02_r�gi]
SELECT lkElv�gzend�Besoroltat�sok01.BFKH, lkElv�gzend�Besoroltat�sok01.Ad�jel, lkElv�gzend�Besoroltat�sok01.F�oszt�ly AS F�oszt�ly, lkElv�gzend�Besoroltat�sok01.Oszt�ly AS Oszt�ly, lkElv�gzend�Besoroltat�sok01.N�v AS N�v, lkElv�gzend�Besoroltat�sok01.[Utols� besorol�s d�tuma] AS [Utols� besorol�s d�tuma], kt_azNexon_Ad�jel.NLink AS NLink
FROM lkElv�gzend�Besoroltat�sok01 LEFT JOIN kt_azNexon_Ad�jel ON lkElv�gzend�Besoroltat�sok01.Ad�jel = kt_azNexon_Ad�jel.Ad�jel
ORDER BY lkElv�gzend�Besoroltat�sok01.F�oszt�ly, lkElv�gzend�Besoroltat�sok01.Oszt�ly, lkElv�gzend�Besoroltat�sok01.N�v;

-- [lkEnged�lyezettBesorol�sHavihoz]
SELECT tBesorol�s�talak�t�Elt�r�Besorol�shoz.jel, IIf([�ll�shely t�pusa] Like "A*","A","K") AS T�pus, tBesorol�s�talak�t�Elt�r�Besorol�shoz.rang, lk�ll�shelyek.[�ll�shely besorol�si kateg�ri�ja], Count(lk�ll�shelyek.[�ll�shely azonos�t�]) AS [CountOf�ll�shely azonos�t�]
FROM tBesorol�s�talak�t�Elt�r�Besorol�shoz INNER JOIN lk�ll�shelyek ON tBesorol�s�talak�t�Elt�r�Besorol�shoz.[�ll�shely besorol�si kateg�ri�ja] = lk�ll�shelyek.[�ll�shely besorol�si kateg�ri�ja]
GROUP BY tBesorol�s�talak�t�Elt�r�Besorol�shoz.jel, IIf([�ll�shely t�pusa] Like "A*","A","K"), tBesorol�s�talak�t�Elt�r�Besorol�shoz.rang, lk�ll�shelyek.[�ll�shely besorol�si kateg�ri�ja]
ORDER BY IIf([�ll�shely t�pusa] Like "A*","A","K"), tBesorol�s�talak�t�Elt�r�Besorol�shoz.rang;

-- [lkEnged�lyezettBesorol�sHavihoz1]
SELECT tBesorol�s�talak�t�Elt�r�Besorol�shoz.jel, IIf([�ll�shely t�pusa] Like "A*","A","K") AS T�pus, tBesorol�s�talak�t�Elt�r�Besorol�shoz.rang, lk�ll�shelyek.[�ll�shely besorol�si kateg�ri�ja], Count(lk�ll�shelyek.[�ll�shely azonos�t�]) AS [CountOf�ll�shely azonos�t�]
FROM tBesorol�s�talak�t�Elt�r�Besorol�shoz INNER JOIN lk�ll�shelyek ON tBesorol�s�talak�t�Elt�r�Besorol�shoz.[�ll�shely besorol�si kateg�ri�ja] = lk�ll�shelyek.[�ll�shely besorol�si kateg�ri�ja]
GROUP BY tBesorol�s�talak�t�Elt�r�Besorol�shoz.jel, IIf([�ll�shely t�pusa] Like "A*","A","K"), tBesorol�s�talak�t�Elt�r�Besorol�shoz.rang, lk�ll�shelyek.[�ll�shely besorol�si kateg�ri�ja]
ORDER BY IIf([�ll�shely t�pusa] Like "A*","A","K"), tBesorol�s�talak�t�Elt�r�Besorol�shoz.rang;

-- [lkEnged�lyezett�sL�tsz�mKimenet]
SELECT IIf([F�oszt�ly]="Korm�nymegb�zott","F�isp�n",[F�oszt�ly]) AS F�oszt, IIf(([F�oszt�ly] Like "*F�oszt�ly" And ([Oszt�ly]="" Or [Oszt�ly]="F�oszt�lyvezet�")) Or ([F�oszt�ly] Like "BFKH*" And ([Oszt�ly]="" Or [Oszt�ly]="Hivatalvezet�s")),[F�oszt�ly],IIf([Oszt�ly]="Korm�nymegb�zott","F�isp�n",[Oszt�ly])) AS Oszt1, Sum(TT21_22_23�sL�tsz�m21_22.L2021) AS L2021, Sum(TT21_22_23�sL�tsz�m21_22.L2022) AS L2022, Sum(TT21_22_23�sL�tsz�m21_22.L2023) AS L2023, Sum(TT21_22_23�sL�tsz�m21_22.TT2021) AS TT2021, Sum(TT21_22_23�sL�tsz�m21_22.TT2022) AS TT2022, Sum(TT21_22_23�sL�tsz�m21_22.TT2023) AS TT2023
FROM (SELECT lkTT21_22_23.F�oszt�ly, lkTT21_22_23.Oszt�ly, 0 AS L2021, 0 AS L2022, SumOfL�tsz�m2023 as L2023, lkTT21_22_23.SumOfTTL�tsz�m2021 AS TT2021, lkTT21_22_23.SumOfTTL�tsz�m2022 AS TT2022, lkTT21_22_23.SumOfTTL�tsz�m2023 AS TT2023
FROM lkTT21_22_23
UNION
SELECT lkEnged�lyezettL�tsz�mok.[F�oszt�ly], lkEnged�lyezettL�tsz�mok.Oszt�ly, lkEnged�lyezettL�tsz�mok.SumOf2021 AS L2021, lkEnged�lyezettL�tsz�mok.SumOf2022 AS L2022, 0 AS L2023, 0 AS TT2021, 0 AS TT2022, 0 AS TT2023
FROM  lkEnged�lyezettL�tsz�mok)  AS TT21_22_23�sL�tsz�m21_22
GROUP BY IIf([F�oszt�ly]="Korm�nymegb�zott","F�isp�n",[F�oszt�ly]), IIf(([F�oszt�ly] Like "*F�oszt�ly" And ([Oszt�ly]="" Or [Oszt�ly]="F�oszt�lyvezet�")) Or ([F�oszt�ly] Like "BFKH*" And ([Oszt�ly]="" Or [Oszt�ly]="Hivatalvezet�s")),[F�oszt�ly],IIf([Oszt�ly]="Korm�nymegb�zott","F�isp�n",[Oszt�ly]));

-- [lkEnged�lyezett�sL�tsz�mKimenet02]
SELECT [F�oszt] AS F�oszt�ly, IIf([Oszt1]="",[F�oszt],[Oszt1]) AS Oszt, Sum(lkEnged�lyezett�sL�tsz�mKimenet.L2021) AS L2021, Sum(lkEnged�lyezett�sL�tsz�mKimenet.L2022) AS L2022, Sum(lkEnged�lyezett�sL�tsz�mKimenet.L2023) AS L2023, Sum(lkEnged�lyezett�sL�tsz�mKimenet.TT2021) AS TT2021, Sum(lkEnged�lyezett�sL�tsz�mKimenet.TT2022) AS TT2022, Sum(lkEnged�lyezett�sL�tsz�mKimenet.TT2023) AS TT2023
FROM lkEnged�lyezett�sL�tsz�mKimenet
GROUP BY [F�oszt], IIf([Oszt1]="",[F�oszt],[Oszt1]);

-- [lkEnged�lyezettL�tsz�mok]
SELECT Replace(Replace([F�oszt�ly/Vezet�],"Budapest F�v�ros Korm�nyhivatala","BFKH"),"  "," ") AS F�oszt�ly, Uni�2122.Oszt�ly, Sum(Uni�2122.[2021]) AS SumOf2021, Sum(Uni�2122.[2022]) AS SumOf2022, Sum(Uni�2122.[2023]) AS SumOf2023
FROM (SELECT tEnged�lyezettL�tsz�mok.[F�oszt�ly/Vezet�], tEnged�lyezettL�tsz�mok.Oszt�ly, tEnged�lyezettL�tsz�mok.L�tsz�m AS 2021, 0 AS 2022, 0 AS 2023
FROM tEnged�lyezettL�tsz�mok
WHERE (((tEnged�lyezettL�tsz�mok.Hat�ly)=#1/1/2021#))
UNION
SELECT tEnged�lyezettL�tsz�mok.[F�oszt�ly/Vezet�], tEnged�lyezettL�tsz�mok.Oszt�ly, 0 AS 2021, tEnged�lyezettL�tsz�mok.L�tsz�m AS 2022, 0 AS 2023
FROM tEnged�lyezettL�tsz�mok
WHERE (((tEnged�lyezettL�tsz�mok.Hat�ly)=#1/1/2022#))
UNION
SELECT tEnged�lyezettL�tsz�mok.[F�oszt�ly/Vezet�], tEnged�lyezettL�tsz�mok.Oszt�ly, 0 AS 2021, 0 AS 2022, tEnged�lyezettL�tsz�mok.L�tsz�m AS 2023
FROM tEnged�lyezettL�tsz�mok
WHERE (((tEnged�lyezettL�tsz�mok.Hat�ly)=#3/25/2023#))
)  AS Uni�2122
GROUP BY Uni�2122.Oszt�ly, Replace([F�oszt�ly/Vezet�],"Budapest F�v�ros Korm�nyhivatala","BFKH");

-- [lkEsetiCs�csvezet�k]
SELECT "Budapest F�v�ros Korm�nyhivatala" AS Korm�nyhivatal, lkSzem�lyek.Besorol�s, lkSzem�lyek.[Dolgoz� teljes neve]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.Besorol�s)="f�isp�n") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkSzem�lyek.Besorol�s)="f�igazgat�") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkSzem�lyek.Besorol�s) Like "*hivatal vezet�je") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkSzem�lyek.F�oszt�ly) Like "P�nz*") AND ((lkSzem�lyek.Besorol�s)="f�oszt�lyvezet�") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.BFKH;

-- [lkEsetiEgyesF�oszt�lyokL�tsz�ma�sVezet�i]
SELECT lkSzem�lyek.BFKH, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.Ad�jel, lkSzem�lyek.[Dolgoz� teljes neve], lkF�oszt�lyon�ntiOszt�lyonk�ntiL�tsz�m.L�tsz�m, lkSzem�lyek.[St�tusz t�pusa]
FROM lkSzem�lyek INNER JOIN lkF�oszt�lyon�ntiOszt�lyonk�ntiL�tsz�m ON lkSzem�lyek.BFKH = lkF�oszt�lyon�ntiOszt�lyonk�ntiL�tsz�m.BFKH
WHERE (((lkSzem�lyek.F�oszt�ly)="Foglalkoztat�si F�oszt�ly") AND ((lkSzem�lyek.[St�tusz t�pusa]) Like "K�z*") AND ((lkSzem�lyek.Besorol�s2)="Oszt�lyvezet�") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.BFKH;

-- [lkEsetiGy�m�gyi�llom�nyt�bla01]
SELECT bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]) AS bfkh, lkJ�r�siKorm�nyK�zpontos�tottUni�.F�oszt�ly, lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly, lkJ�r�siKorm�nyK�zpontos�tottUni�.[�ll�shely azonos�t�], lkJ�r�siKorm�nyK�zpontos�tottUni�.N�v, lkJ�r�siKorm�nyK�zpontos�tottUni�.[Havi illetm�ny], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Heti munka�r�k sz�ma], "" AS [Jogviszony v�ge]
FROM lkJ�r�siKorm�nyK�zpontos�tottUni�
WHERE (((lkJ�r�siKorm�nyK�zpontos�tottUni�.F�oszt�ly)="Gy�m�gyi F�oszt�ly") AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s"))
ORDER BY lkJ�r�siKorm�nyK�zpontos�tottUni�.F�oszt�ly, lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly;

-- [lkEsetiGy�m�gyi�llom�nyt�bla02]
SELECT bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]) AS bfkh, lkKil�p�Uni�.F�oszt�ly, lkKil�p�Uni�.Oszt�ly, lkKil�p�Uni�.[�ll�shely azonos�t�], lkKil�p�Uni�.N�v, lkKil�p�Uni�.[Illetm�ny (Ft/h�)], lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker], lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)]
FROM lkSzem�lyek INNER JOIN lkKil�p�Uni� ON (lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)] = lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]) AND (lkSzem�lyek.[Ad�azonos�t� jel] = lkKil�p�Uni�.Ad�azonos�t�)
WHERE (((lkKil�p�Uni�.F�oszt�ly)="Gy�m�gyi F�oszt�ly"));

-- [lkEsetiGy�m�gyi�llom�nyt�bla03]
SELECT *
FROM (SELECT lkEsetiGy�m�gyi�llom�nyt�bla02.*
FROM lkEsetiGy�m�gyi�llom�nyt�bla02
UNION SELECT  lkEsetiGy�m�gyi�llom�nyt�bla01.*
FROM lkEsetiGy�m�gyi�llom�nyt�bla01)  AS lkEsetiGy�m�gyi�llom�nyt�bla0102;

-- [lkEsetiKock�zatiK�rd��v01]
SELECT lkSzem�lyek.BFKH, "Budapest F�v�ros Korm�nyhivatala" AS Szervezet, lkSzem�lyek.[Szint 5 szervezeti egys�g n�v] AS Hivatal, lkSzem�lyek.[Szint 6 szervezeti egys�g n�v] AS F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.Besorol�s2, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[St�tusz k�dja] AS [�ll�shely azonos�t�], lkSzem�lyek.[St�tusz t�pusa] AS Jelleg, lkSzem�lyek.[KIRA jogviszony jelleg] AS Jogviszony
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.BFKH, lkSzem�lyek.[St�tusz t�pusa], lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkEsetiKock�zatiK�rd��v02]
SELECT lkSzervezeti�ll�shelyek.SzervezetK�d AS BFKH, "Budapest F�v�ros Korm�nyhivatala" AS Szervezet, lkSzervezeti�ll�shelyek.[Szint5 - le�r�s] AS Hivatal, lkSzervezeti�ll�shelyek.[Szint6 - le�r�s] AS F�oszt�ly, lkSzervezeti�ll�shelyek.[Szint7 - le�r�s] AS Oszt�ly, lkSzervezeti�ll�shelyek.[Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s] AS Besorol�s, "" AS N�v, lkSzervezeti�ll�shelyek.�ll�shelyAzonos�t� AS [�ll�shely azonos�t�], lkSzervezeti�ll�shelyek.[St�tusz t�pusa] AS Jelleg, lkSzervezeti�ll�shelyek.[Tervezett bet�lt�si adatok - Jogviszony t�pus] AS Jogviszony
FROM lkSzervezeti�ll�shelyek
WHERE (((lkSzervezeti�ll�shelyek.OSZLOPOK)="St�tusz (bet�ltetlen)"));

-- [lkEsetiKock�zatiK�rd��v03]
SELECT lkEsetiKock�zatiK�rd��v02.*
FROM lkEsetiKock�zatiK�rd��v02
UNION SELECT lkEsetiKock�zatiK�rd��v01.*
FROM  lkEsetiKock�zatiK�rd��v01;

-- [lkEsetiNemzetiKorrupci�ellenesStrat�gia]
SELECT lkSzervezetiVezet�kList�ja02.[Szervezeti egys�g vezet�je] AS [Kit�lt� neve], [F�oszt�ly] & ", " & [N�v] AS [Kit�lt� szervezeti egys�ge], lkSzervezetiVezet�kList�ja02.Besorol�sa AS [Kit�lt� beoszt�sa], IIf(Nz([HivataliVezet�kes],[HivataliMobil]) Like "Hib�s*","",Nz([HivataliVezet�kes],[HivataliMobil])) AS [Kit�lt� telefonsz�ma], lkSzervezetiVezet�kList�ja02.[Hivatali email] AS [Kit�lt� e-mail c�me], lkSzervezetiVezet�kList�ja02.HivataliMobil
FROM lkSzervezetiVezet�kList�ja02 INNER JOIN tmpKorrupci�EllenesLek�rdez�shez ON lkSzervezetiVezet�kList�ja02.[BFKH k�d] = tmpKorrupci�EllenesLek�rdez�shez.BFKH
WHERE (((tmpKorrupci�EllenesLek�rdez�shez.Kell_e)=True))
ORDER BY bfkh([BFKH k�d]);

-- [lkEsetiProjektbeFelveend�k]
SELECT kt_azNexon_Ad�jel02.Ad�jel, tEsetiProjektbeFelveend�k.[K�lts�ghely*]
FROM tEsetiProjektbeFelveend�k LEFT JOIN kt_azNexon_Ad�jel02 ON tEsetiProjektbeFelveend�k.[Szem�ly azonos�t�ja*] = kt_azNexon_Ad�jel02.azNexon;

-- [lkEsk�Lej�rtId�pontokhozHozz�f�z]
INSERT INTO tEsk�Lej�rtId�pontok ( [Szervezeti egys�g k�d], [Szervezeti egys�g], [Szervezeti szint sz�ma-neve], [Jogviszony t�pus], [Jogviszony kezdete], [Jogviszony v�ge], [Dolgoz� neve], [Ad�azonos�t� jel], [Figyelend� d�tum t�pusa], [Figyelend� d�tum], [Szint 1 szervezeti egys�g k�d], [Szint 1 szervezeti egys�g n�v], [Szint 2 szervezeti egys�g k�d], [Szint 2 szervezeti egys�g n�v], [Szint 3 szervezeti egys�g k�d], [Szint 3 szervezeti egys�g n�v], [Szint 4 szervezeti egys�g k�d], [Szint 4 szervezeti egys�g n�v], [Szint 5 szervezeti egys�g k�d], [Szint 5 szervezeti egys�g n�v], [Szint 6 szervezeti egys�g k�d], [Szint 6 szervezeti egys�g n�v], [Szint 7 szervezeti egys�g k�d], [Szint 7 szervezeti egys�g n�v], [Szint 8 szervezeti egys�g k�d], [Szint 8 szervezeti egys�g n�v], [Szint 9 szervezeti egys�g k�d], [Szint 9 szervezeti egys�g n�v], [Szint 10 szervezeti egys�g k�d], [Szint 10 szervezeti egys�g n�v] )
SELECT TmptEsk�Lej�rtId�pontok.[Szervezeti egys�g k�d] AS Kif1, TmptEsk�Lej�rtId�pontok.[Szervezeti egys�g] AS Kif2, TmptEsk�Lej�rtId�pontok.[Szervezeti szint sz�ma-neve] AS Kif3, TmptEsk�Lej�rtId�pontok.[Jogviszony t�pus] AS Kif4, dt�tal([  Jogviszony kezdete]) AS [Jogviszony kezdete], dt�tal([  Jogviszony v�ge]) AS [Jogviszony v�ge], TmptEsk�Lej�rtId�pontok.[Dolgoz� neve] AS Kif5, TmptEsk�Lej�rtId�pontok.[Ad�azonos�t� jel] AS Kif6, TmptEsk�Lej�rtId�pontok.[Figyelend� d�tum t�pusa] AS Kif7, dt�tal([Figyelend� d�tum]) AS Kif3, TmptEsk�Lej�rtId�pontok.[Szint 1 szervezeti egys�g k�d] AS Kif8, TmptEsk�Lej�rtId�pontok.[Szint 1 szervezeti egys�g n�v] AS Kif9, TmptEsk�Lej�rtId�pontok.[Szint 2 szervezeti egys�g k�d] AS Kif10, TmptEsk�Lej�rtId�pontok.[Szint 2 szervezeti egys�g n�v] AS Kif11, TmptEsk�Lej�rtId�pontok.[Szint 3 szervezeti egys�g k�d] AS Kif12, TmptEsk�Lej�rtId�pontok.[Szint 3 szervezeti egys�g n�v] AS Kif13, TmptEsk�Lej�rtId�pontok.[Szint 4 szervezeti egys�g k�d] AS Kif14, TmptEsk�Lej�rtId�pontok.[Szint 4 szervezeti egys�g n�v] AS Kif15, TmptEsk�Lej�rtId�pontok.[Szint 5 szervezeti egys�g k�d] AS Kif16, TmptEsk�Lej�rtId�pontok.[Szint 5 szervezeti egys�g n�v] AS Kif17, TmptEsk�Lej�rtId�pontok.[Szint 6 szervezeti egys�g k�d] AS Kif18, TmptEsk�Lej�rtId�pontok.[Szint 6 szervezeti egys�g n�v] AS Kif19, TmptEsk�Lej�rtId�pontok.[Szint 7 szervezeti egys�g k�d] AS Kif20, TmptEsk�Lej�rtId�pontok.[Szint 7 szervezeti egys�g n�v] AS Kif21, TmptEsk�Lej�rtId�pontok.[Szint 8 szervezeti egys�g k�d] AS Kif22, TmptEsk�Lej�rtId�pontok.[Szint 8 szervezeti egys�g n�v] AS Kif23, TmptEsk�Lej�rtId�pontok.[Szint 9 szervezeti egys�g k�d] AS Kif24, TmptEsk�Lej�rtId�pontok.[Szint 9 szervezeti egys�g n�v] AS Kif25, TmptEsk�Lej�rtId�pontok.[Szint 10 szervezeti egys�g k�d] AS Kif26, TmptEsk�Lej�rtId�pontok.[Szint 10 szervezeti egys�g n�v] AS Kif27
FROM TmptEsk�Lej�rtId�pontok
WHERE ((([TmptEsk�Lej�rtId�pontok].[Ad�azonos�t� jel]) Is Not Null));

-- [lk�vNem]
SELECT lkSzem�lyek.[Ad�azonos�t� jel], Year([Sz�let�si id�]) AS �v, IIf([Neme]="n�",2,1) AS Nem
FROM lkSzem�lyek;

-- [lk�vNem_keresztt�bla]
TRANSFORM Count(lk�vNem.[Ad�azonos�t� jel]) AS [CountOfAd�azonos�t� jel]
SELECT lk�vNem.�v, Count(lk�vNem.[Ad�azonos�t� jel]) AS �sszesen
FROM lk�vNem
GROUP BY lk�vNem.�v
PIVOT lk�vNem.[Nem] In (1,2);

-- [lk�vV�giL�tsz�mok�sKil�p�kNyugd�jasokN�lk�l]
SELECT lkL�tsz�mMinden�vUtols�Napj�n.�v, lkL�tsz�mMinden�vUtols�Napj�n.CountOfAd�azonos�t� AS [L�tsz�m az �v utols� napj�n], lkKil�p�kSz�ma�vente.[Kil�p�k sz�ma]
FROM lkKil�p�kSz�ma�vente RIGHT JOIN lkL�tsz�mMinden�vUtols�Napj�n ON lkKil�p�kSz�ma�vente.Kil�p�s�ve = lkL�tsz�mMinden�vUtols�Napj�n.�v;

-- [lkFARr�sztvev�]
SELECT tFARr�sztvev�.Ad�azonos�t�, tFARr�sztvev�.[Legmagasabb iskolai v�gzetts�ge], lkFARford�t�t�blaV�gzetts�ghez.FAR, lkSzem�lyek.[Iskolai v�gzetts�g foka], lkSzem�lyek.[Dolgoz� teljes neve] AS [Viselt neve], lkSzem�lyek.[Dolgoz� sz�let�si neve] AS [Sz�let�si neve], lkSzem�lyek.[Anyja neve], tFARr�sztvev�.[Sz�let�si orsz�g], lkSzem�lyek.[Sz�let�si hely] AS [Sz�let�si helye], lkSzem�lyek.[Sz�let�si id�] AS [Sz�let�si ideje], tFARr�sztvev�.[E-mail c�me], tFARr�sztvev�.[Magyarorsz�gi lakc�mmel nem rendelkez� nem magyar �llampolg�r], tFARr�sztvev�.[DHK K�pz�si hitel?], tFARr�sztvev�.[R�sztvev� �ltal fizetend� d�j], tFARr�sztvev�.T�bla
FROM (lkSzem�lyek RIGHT JOIN tFARr�sztvev� ON lkSzem�lyek.[Ad�azonos�t� jel]=tFARr�sztvev�.Ad�azonos�t�) LEFT JOIN lkFARford�t�t�blaV�gzetts�ghez ON lkSzem�lyek.[Iskolai v�gzetts�g foka]=lkFARford�t�t�blaV�gzetts�ghez.Nexon;

-- [lkFeladatKirafeladatFunkci�]
SELECT ktFeladatKirafeladatFunkci�.Azonos�t�, Nz([Feladat],"") AS Feladata, ktFeladatKirafeladatFunkci�.[KIRA feladat megnevez�s], Nz([Megnevez�s (magyar)],"-") AS Funkci�
FROM ktFeladatKirafeladatFunkci� LEFT JOIN tFunkci�k ON ktFeladatKirafeladatFunkci�.azFunkci� = tFunkci�k.azFunkci�;

-- [lkFeladatk�r_KIRAfeladat]
SELECT DISTINCT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.Feladatk�r, lkSzem�lyek.[KIRA feladat megnevez�s]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [lkFeladatk�r�kAKabinetben�sAzIgazgat�s�gon]
SELECT DISTINCT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[KIRA feladat megnevez�s]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.F�oszt�ly) Like "F�isp�ni*" Or (lkSzem�lyek.F�oszt�ly) Like "F�igazgat�i*") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.F�oszt�ly DESC , lkSzem�lyek.[KIRA feladat megnevez�s], lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkFeladatk�r�nk�ntiL�tsz�m]
SELECT DISTINCT lkSzem�lyek.[KIRA feladat megnevez�s] AS [meghagy�sra kijel�lt munkak�r�k megnevez�se], Count(lkSzem�lyek.Ad�jel) AS A, 0 AS B, Count(lkSzem�lyek.Ad�jel) AS C
FROM lkSzem�lyek RIGHT JOIN tMeghagy�sraKijel�ltMunkak�r�k ON lkSzem�lyek.[KIRA feladat megnevez�s] like "*"&tMeghagy�sraKijel�ltMunkak�r�k.Feladatk�r�k&"*"
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
GROUP BY lkSzem�lyek.[KIRA feladat megnevez�s], 0
ORDER BY lkSzem�lyek.[KIRA feladat megnevez�s];

-- [lkFeladatk�r�nk�ntiMeghagyottak]
SELECT lkMeghagyand�MaxL�tsz�mFeladatk�r�nk�nt.Feladatk�r�k, lkMeghagyand�MaxL�tsz�mFeladatk�r�nk�nt.L�tsz�m AS A, lkMeghagyand�MaxL�tsz�mFeladatk�r�nk�nt.[Bet�lt�tt l�tsz�m ar�nyos�tva] AS B, [A]-[b] AS C
FROM lkMeghagyand�MaxL�tsz�mFeladatk�r�nk�nt;

-- [lkFeltehet�enT�vesNem�Dolgoz�k]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.Neme, kt_azNexon_Ad�jel02.NLink
FROM tUt�nevekNemekkel, kt_azNexon_Ad�jel02 INNER JOIN lkSzem�lyek ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.Neme)<>[tUt�nevekNemekkel].[neme]) AND ((utols�([Dolgoz� teljes neve]," ",0))=[tUt�nevekNemekkel].[Keresztn�v]) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [lkFenn�ll�Hib�k]
SELECT tR�giHib�k.[Els� mez�] AS Hash, tR�giHib�k.lek�rdez�sNeve, tR�giHib�k.[M�sodik mez�] AS Hibasz�veg, tR�giHib�k.[Els� Id�pont]
FROM tR�giHib�k
WHERE (((tR�giHib�k.[Utols� Id�pont])=(select max([utols� id�pont]) from tR�giHib�k )))
ORDER BY tR�giHib�k.[Els� Id�pont];

-- [lkFenn�ll�Hib�kStatisztika]
SELECT lkEllen�rz�Lek�rdez�sek2.T�blac�m, [Hib�k]-[Ebb�l int�zett] AS Int�zetlen, Count(tR�giHib�k.[Els� mez�]) AS Hib�k, Count(lkktR�giHib�kInt�zked�sekUtols�Int�zked�s.azInt�zked�sek) AS [Ebb�l int�zett]
FROM lkEllen�rz�Lek�rdez�sek2 INNER JOIN (tR�giHib�k LEFT JOIN lkktR�giHib�kInt�zked�sekUtols�Int�zked�s ON tR�giHib�k.[Els� mez�] = lkktR�giHib�kInt�zked�sekUtols�Int�zked�s.HASH) ON lkEllen�rz�Lek�rdez�sek2.Ellen�rz�Lek�rdez�s = tR�giHib�k.lek�rdez�sNeve
WHERE (((tR�giHib�k.[Utols� Id�pont])=(select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve <>"lk�res�ll�shelyek�llapotfelm�r�" And lek�rdez�sneve <>"lkFontosHi�nyz�Adatok02")))
GROUP BY lkEllen�rz�Lek�rdez�sek2.T�blac�m, tR�giHib�k.lek�rdez�sNeve
HAVING (((tR�giHib�k.lek�rdez�sNeve)<>"lkLej�rtAlkalmass�gi�rv�nyess�g" And (tR�giHib�k.lek�rdez�sNeve)<>"lk�res�ll�shelyek�llapotfelm�r�") AND (("lek�rdez�sneve")<>"lkFontosHi�nyz�Adatok02"))
ORDER BY Count(tR�giHib�k.[Els� mez�]) DESC , Count(lkktR�giHib�kInt�zked�sekUtols�Int�zked�s.azInt�zked�sek) DESC;

-- [lkFenn�ll�NemHib�k]
SELECT lkVisszajelz�sekKezel�se.SenderEmailAddress, lkVisszajelz�sekKezel�se.lek�rdez�sNeve, lkVisszajelz�sekKezel�se.Visszajelz�sSz�vege, lkVisszajelz�sekKezel�se.[Fenn�ll�s kezdete], lkFenn�ll�Hib�k.Hibasz�veg
FROM lkFenn�ll�Hib�k INNER JOIN ((lkVisszajelz�sekKezel�se INNER JOIN lkR�giHib�kUtols�Int�zked�s ON lkVisszajelz�sekKezel�se.Hash = lkR�giHib�kUtols�Int�zked�s.HASH) INNER JOIN tInt�zked�sFajt�k ON lkR�giHib�kUtols�Int�zked�s.azIntFajta = tInt�zked�sFajt�k.azIntFajta) ON lkFenn�ll�Hib�k.Hash = lkVisszajelz�sekKezel�se.Hash
WHERE (((tInt�zked�sFajt�k.Int�zked�sFajta)="referens szerint nem hiba"));

-- [lkFenn�ll�Oszt�lyozand�Hib�k]
SELECT lkVisszajelz�sekKezel�se.SenderEmailAddress, lkVisszajelz�sekKezel�se.lek�rdez�sNeve, lkVisszajelz�sekKezel�se.Visszajelz�sSz�vege, lkVisszajelz�sekKezel�se.[Fenn�ll�s kezdete], lkFenn�ll�Hib�k.Hibasz�veg
FROM lkFenn�ll�Hib�k INNER JOIN ((lkVisszajelz�sekKezel�se INNER JOIN lkR�giHib�kUtols�Int�zked�s ON lkVisszajelz�sekKezel�se.Hash = lkR�giHib�kUtols�Int�zked�s.HASH) INNER JOIN tInt�zked�sFajt�k ON lkR�giHib�kUtols�Int�zked�s.azIntFajta = tInt�zked�sFajt�k.azIntFajta) ON lkFenn�ll�Hib�k.Hash = lkVisszajelz�sekKezel�se.Hash
WHERE (((tInt�zked�sFajt�k.Int�zked�sFajta)="oszt�lyozand�"));

-- [lkFESZ]
SELECT FESZ.Azonos�t�, FESZ.N�v, Csaksz�m([TAJ]) AS [TAJ sz�m], dt�tal([Sz�ld�tum]) AS Sz�l, FESZ.Oszt�ly, FESZ.[FEOR megnevez�s], FESZ.[Alk tipus], dt�tal([Alk d�tuma]) AS AD�tum, dt�tal([�rv�nyes]) AS �rv�ny, FESZ.Korl�toz�s, FESZ.Hat�ly
FROM FESZ;

-- [lkFesz_01]
SELECT CStr([TAJ sz�m]) AS TAJ, lkFESZ.N�v, lkFESZ.Sz�l, lkFESZ.Oszt�ly, lkFESZ.[FEOR megnevez�s], lkFESZ.[Alk tipus], lkFESZ.AD�tum, lkFESZ.�rv�ny, lkFESZ.Korl�toz�s
FROM lkFESZ
WHERE (((CStr([TAJ sz�m]))<>0));

-- [lkFesz_01b]
SELECT lkSzem�lyek.Azonos�t�, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkFesz_01.N�v, lkFesz_01.TAJ, lkFesz_01.Sz�l, lkFesz_01.Oszt�ly AS E�Oszt�ly, lkFesz_01.[FEOR megnevez�s], lkFesz_01.[Alk tipus], lkFesz_01.AD�tum, lkFesz_01.�rv�ny, lkFesz_01.Korl�toz�s, lkSzem�lyek.[Orvosi vizsg�lat id�pontja], lkSzem�lyek.[Orvosi vizsg�lat t�pusa], lkSzem�lyek.[Orvosi vizsg�lat eredm�nye], lkSzem�lyek.[Orvosi vizsg�lat �szrev�telek], lkSzem�lyek.[Orvosi vizsg�lat k�vetkez� id�pontja]
FROM lkFesz_01 INNER JOIN lkSzem�lyek ON lkFesz_01.TAJ = lkSzem�lyek.[TAJ sz�m];

-- [lkFesz_02]
SELECT lkSzem�lyek.Azonos�t�, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.[Szervezeti egys�g neve] AS Oszt�ly, lkFESZ.N�v, lkFESZ.[TAJ sz�m], lkFESZ.Sz�l, lkFESZ.Oszt�ly AS E�Oszt�ly, lkFESZ.[FEOR megnevez�s], lkFESZ.[Alk tipus], lkFESZ.AD�tum, lkFESZ.�rv�ny, lkFESZ.Korl�toz�s, lkSzem�lyek.[Orvosi vizsg�lat id�pontja], lkSzem�lyek.[Orvosi vizsg�lat t�pusa], lkSzem�lyek.[Orvosi vizsg�lat eredm�nye], lkSzem�lyek.[Orvosi vizsg�lat �szrev�telek], lkSzem�lyek.[Orvosi vizsg�lat k�vetkez� id�pontja]
FROM lkSzem�lyek RIGHT JOIN lkFESZ ON (lkSzem�lyek.[Sz�let�si id�] = lkFESZ.Sz�l) AND (lkSzem�lyek.[Dolgoz� teljes neve] = lkFESZ.N�v)
WHERE (((lkSzem�lyek.Azonos�t�) Is Not Null));

-- [lkFESZ_ellen�rz�s]
SELECT lkFESZ.N�v, lkFESZ.Sz�l
FROM lkFESZ LEFT JOIN lk_Fesz_03 ON (lkFESZ.N�v = lk_Fesz_03.N�v) AND (lkFESZ.Sz�l = lk_Fesz_03.Sz�l)
WHERE (((lk_Fesz_03.Azonos�t�) Is Null));

-- [lkFontosHi�nyz�Adatok01]
SELECT lk_Ellen�rz�s_03.F�oszt�ly, lk_Ellen�rz�s_03.Oszt�ly, lk_Ellen�rz�s_03.N�v, lk_Ellen�rz�s_03.[Hi�nyz� �rt�k], lk_Ellen�rz�s_03.[St�tusz k�d], lk_Ellen�rz�s_03.Megjegyz�s, lk_Ellen�rz�s_03.NLink, TextToMD5Hex([F�oszt�ly] & "|" & [Oszt�ly] & "|" & [N�v] & "|" & [Hi�nyz� �rt�k] & "|" & [St�tusz k�d] & "|" & [NLink] & "|" & [Megjegyz�s] & "|") AS Hash
FROM lk_Ellen�rz�s_03
WHERE (((lk_Ellen�rz�s_03.[Hi�nyz� �rt�k])<>"Hivatali email" And (lk_Ellen�rz�s_03.[Hi�nyz� �rt�k])<>"Munkav�gz�s helye - c�m" And (lk_Ellen�rz�s_03.[Hi�nyz� �rt�k])<>"K�zpontos�tott �ll�shelyhez nincs megjel�lve k�lts�ghely vagy k�lts�ghely-k�d (projekt)." And (lk_Ellen�rz�s_03.[Hi�nyz� �rt�k])<>"Esk�let�tel id�pontja" And (lk_Ellen�rz�s_03.[Hi�nyz� �rt�k])<>"�lland� lakc�m hi�nyzik, vagy nem �rv�nyes"));

-- [lkFontosHi�nyz�Adatok02]
SELECT lkFontosHi�nyz�Adatok01.F�oszt�ly, lkFontosHi�nyz�Adatok01.Oszt�ly, lkFontosHi�nyz�Adatok01.N�v, lkFontosHi�nyz�Adatok01.[Hi�nyz� �rt�k], lkFontosHi�nyz�Adatok01.[St�tusz k�d], lkFontosHi�nyz�Adatok01.NLink, lkFontosHi�nyz�Adatok01.Megjegyz�s
FROM lkFontosHi�nyz�Adatok01 LEFT JOIN lkktR�giHib�kInt�zked�sekLegutols�Int�zked�s ON lkFontosHi�nyz�Adatok01.Hash = lkktR�giHib�kInt�zked�sekLegutols�Int�zked�s.HASH
WHERE (((lkktR�giHib�kInt�zked�sekLegutols�Int�zked�s.azIntFajta)=3 Or (lkktR�giHib�kInt�zked�sekLegutols�Int�zked�s.azIntFajta) Is Null Or (lkktR�giHib�kInt�zked�sekLegutols�Int�zked�s.azIntFajta)=8));

-- [lkFordul�napt�lABel�p�sigEl�z�MunkahelyMunkanapjai]
SELECT [Ad�azonos�t� jel]*1 AS Ad�jel, tEl�z�Munkahelyek.[Munkahely neve], tEl�z�Munkahelyek.[Jogviszony t�pus megnevez�se], tEl�z�Munkahelyek.Kezdete1, tEl�z�Munkahelyek.V�ge2, DateDiff("d",[Fordul�nap],[V�ge2])-IIf(DateDiff("d",[Fordul�nap],[Kezdete1])>0,DateDiff("d",[Fordul�nap],[Kezdete1]),0)+1 AS Napok
FROM tEl�z�Munkahelyek
WHERE (((tEl�z�Munkahelyek.V�ge2)>=[Fordul�nap]));

-- [lkFordul�napt�lABel�p�sigEl�z��sszesMunkanapja]
SELECT lkFordul�napt�lABel�p�sigEl�z�MunkahelyMunkanapjai.*
FROM lkFordul�napt�lABel�p�sigEl�z�MunkahelyMunkanapjai
UNION SELECT lkFordul�napt�lABel�p�sigEl�z�JogviszonyMunkanapjai.*
FROM lkFordul�napt�lABel�p�sigEl�z�JogviszonyMunkanapjai;

-- [lkFordul�napt�lEgy�vigMindenJogviszonyMunkanapjai]
SELECT lkSzem�lyek.Ad�jel, "BFKH" AS [Munkahely neve], lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus], lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS Kezdete, IIf([Jogviszony v�ge (kil�p�s d�tuma)]=0 Or [Jogviszony v�ge (kil�p�s d�tuma)]>DateSerial(Year([Fordul�nap])+1,Month([Fordul�nap]),Day([Fordul�nap])-1),DateSerial(Year([Fordul�nap])+1,Month([Fordul�nap]),Day([Fordul�nap])-1),[Jogviszony v�ge (kil�p�s d�tuma)]) AS V�ge, DateDiff("d",[Fordul�nap],[V�ge])-IIf(DateDiff("d",[Fordul�nap],[Kezdete])>0,DateDiff("d",[Fordul�nap],[Kezdete]),0)+1 AS Napok
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]) Like "K*" 
        Or (lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]) Like "H*"
        Or (lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]) Like "Mu*" 
        Or (lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]) Like "P*") 
	AND ((lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)])>=[Fordul�nap] 
		Or (lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)])=0));

-- [lkForr�sNexonSzervezetek�sszerendel�s]
SELECT tForr�sNexonSzervezetek�sszerendel�s.Azonos�t�, Replace([F�oszt�ly],"Budapest F�v�ros Korm�nyhivatala","BFKH") AS F�oszt, IIf([Oszt�ly]="J�r�si hivatal",[F�oszt�ly],[Oszt�ly]) AS Oszt, tForr�sNexonSzervezetek�sszerendel�s.Forr�sK�d
FROM tForr�sNexonSzervezetek�sszerendel�s;

-- [lkF�isp�niKabinet�ll�shelyei]
TRANSFORM Min(tHaviJelent�sHat�lya1.hat�lya) AS MinOfhat�lya
SELECT tKorm�nyhivatali_�llom�ny.[�ll�shely azonos�t�]
FROM tKorm�nyhivatali_�llom�ny INNER JOIN tHaviJelent�sHat�lya1 ON tKorm�nyhivatali_�llom�ny.hat�lyaID = tHaviJelent�sHat�lya1.hat�lyaID
WHERE (((tHaviJelent�sHat�lya1.hat�lya)>#1/1/2024#) AND ((tKorm�nyhivatali_�llom�ny.Mez�6)="f�isp�ni kabinet"))
GROUP BY tKorm�nyhivatali_�llom�ny.[�ll�shely azonos�t�]
ORDER BY tKorm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], tHaviJelent�sHat�lya1.hat�lya
PIVOT tHaviJelent�sHat�lya1.hat�lya;

-- [lkF�isp�niKabinet�ll�shelyei2]
TRANSFORM First(lk�llom�nyt�bl�kT�rt�netiUni�ja.F�oszt) AS FirstOfF�oszt
SELECT lk�llom�nyt�bl�kT�rt�netiUni�ja.[�ll�shely azonos�t�]
FROM tF�isp�niKabinet�ll�shelyei20240831ig INNER JOIN (lk�llom�nyt�bl�kT�rt�netiUni�ja INNER JOIN tHaviJelent�sHat�lya1 ON lk�llom�nyt�bl�kT�rt�netiUni�ja.hat�lyaID = tHaviJelent�sHat�lya1.hat�lyaID) ON tF�isp�niKabinet�ll�shelyei20240831ig.�ll�shelyAz = lk�llom�nyt�bl�kT�rt�netiUni�ja.[�ll�shely azonos�t�]
WHERE (((tHaviJelent�sHat�lya1.hat�lya)>#1/1/2024#))
GROUP BY lk�llom�nyt�bl�kT�rt�netiUni�ja.[�ll�shely azonos�t�]
PIVOT tHaviJelent�sHat�lya1.hat�lya;

-- [lkF�oszt�lyDolgoz�inakList�jaId�szakiM�trixban01]
SELECT Hum�nUni�.Ad�jel, Hum�nUni�.[Dolgoz� teljes neve], Hum�nUni�.Bel�p�s, Hum�nUni�.Kil�p�s, lkKiemeltNapok.�v & Right("0" & lkKiemeltNapok.h�,2) AS �vH�, IIf(lkKiemeltNapok.KiemeltNapok Between dt�tal(Nz([Tart�s t�voll�t kezdete],#1/1/3000#)) And dt�tal(Nz([Tart�s t�voll�t v�ge],#1/1/3000#)),2,1)
FROM (SELECT lkSzem�lyek.Ad�jel, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS Bel�p�s, #01/01/3000# AS Kil�p�s, [Tart�s t�voll�t kezdete], [Tart�s t�voll�t v�ge] FROM lkSzem�lyek WHERE (((lkSzem�lyek.F�oszt�ly) Like "*"&[Melyik f�oszt�lyt keress�k]&"*")) 
UNION 
SELECT lkKil�p�Uni�.Ad�jel, lkKil�p�Uni�.N�v, lkKil�p�Uni�.[Jogviszony kezd� d�tuma] AS Bel�p�s, iif(dt�tal(lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])=0,#01/01/3000#,dt�tal(lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])) AS Kil�p�s,#01/01/3000# as TTkezdete, #01/01/3000# as TTv�ge 
FROM lkKil�p�Uni� WHERE (((lkKil�p�Uni�.F�oszt�ly) Like "*"&[Melyik f�oszt�lyt keress�k]&"*"))  )  AS Hum�nUni� INNER JOIN lkKiemeltNapok ON (Hum�nUni�.Bel�p�s <= lkKiemeltNapok.KiemeltNapok) AND (Hum�nUni�.Kil�p�s >= lkKiemeltNapok.KiemeltNapok)
WHERE (((Hum�nUni�.Kil�p�s)>#1/1/2023#) AND ((lkKiemeltNapok.KiemeltNapok) Between #1/1/2023# And Now()) AND ((lkKiemeltNapok.nap)=1));

-- [lkF�oszt�lyDolgoz�inakList�jaId�szakiM�trixban02]
TRANSFORM Sum(lkF�oszt�lyDolgoz�inakList�jaId�szakiM�trixban01.Expr1005) AS SumOfExpr1005
SELECT lkF�oszt�lyDolgoz�inakList�jaId�szakiM�trixban01.[Dolgoz� teljes neve]
FROM lkF�oszt�lyDolgoz�inakList�jaId�szakiM�trixban01
GROUP BY lkF�oszt�lyDolgoz�inakList�jaId�szakiM�trixban01.[Dolgoz� teljes neve]
PIVOT lkF�oszt�lyDolgoz�inakList�jaId�szakiM�trixban01.�vH� In (2301,2302,2303,2304,2305,2306,2307,2308,2309,2310,2311,2312,2401,2402,2403);

-- [lkF�oszt�lyiL�tsz�m2024If�l�v00]
SELECT lktKorm�nyhivatali_�llom�ny.Oszt�ly, lktKorm�nyhivatali_�llom�ny.hat�lyaID, IIf([Sz�let�si �v \ �res �ll�s]="�res �ll�s",0,1) AS L�tsz�m
FROM lktKorm�nyhivatali_�llom�ny
WHERE (((lktKorm�nyhivatali_�llom�ny.F�oszt�ly) Like "Hum�n*"));

-- [lkF�oszt�lyiL�tsz�m2024If�l�v01]
SELECT tHaviJelent�sHat�lya1.hat�lyaID, lkKiemeltNapok.KiemeltNapok
FROM tHaviJelent�sHat�lya1 INNER JOIN lkKiemeltNapok ON tHaviJelent�sHat�lya1.hat�lya = lkKiemeltNapok.KiemeltNapok
WHERE (((lkKiemeltNapok.tnap)<>1 And (lkKiemeltNapok.tnap)<>15) AND ((lkKiemeltNapok.KiemeltNapok) Between #12/31/2023# And #7/31/2024#))
GROUP BY tHaviJelent�sHat�lya1.hat�lyaID, lkKiemeltNapok.KiemeltNapok;

-- [lkF�oszt�lyiL�tsz�m2024If�l�v02]
SELECT lkF�oszt�lyiL�tsz�m2024If�l�v01.KiemeltNapok, lkF�oszt�lyiL�tsz�m2024If�l�v00.Oszt�ly, Sum(lkF�oszt�lyiL�tsz�m2024If�l�v00.L�tsz�m) AS SumOfL�tsz�m
FROM lkF�oszt�lyiL�tsz�m2024If�l�v00 INNER JOIN lkF�oszt�lyiL�tsz�m2024If�l�v01 ON lkF�oszt�lyiL�tsz�m2024If�l�v00.hat�lyaID = lkF�oszt�lyiL�tsz�m2024If�l�v01.hat�lyaID
GROUP BY lkF�oszt�lyiL�tsz�m2024If�l�v01.KiemeltNapok, lkF�oszt�lyiL�tsz�m2024If�l�v00.Oszt�ly;

-- [lkF�oszt�lyiL�tsz�m2024If�l�v03]
SELECT El�z�D�tumIs.hat�lyaID, El�z�D�tumIs.MaxOfKiemeltNapok AS El�z�, El�z�D�tumIs.KiemeltNapok
FROM (SELECT lkF�oszt�lyiL�tsz�m2024If�l�v01.hat�lyaID, lkF�oszt�lyiL�tsz�m2024If�l�v01.KiemeltNapok, Max(lkF�oszt�lyiL�tsz�m2024If�l�v01_1.[KiemeltNapok]) AS MaxOfKiemeltNapok FROM lkF�oszt�lyiL�tsz�m2024If�l�v01 AS lkF�oszt�lyiL�tsz�m2024If�l�v01_1 RIGHT JOIN lkF�oszt�lyiL�tsz�m2024If�l�v01 ON lkF�oszt�lyiL�tsz�m2024If�l�v01_1.KiemeltNapok < lkF�oszt�lyiL�tsz�m2024If�l�v01.KiemeltNapok GROUP BY lkF�oszt�lyiL�tsz�m2024If�l�v01.hat�lyaID, lkF�oszt�lyiL�tsz�m2024If�l�v01.KiemeltNapok)  AS El�z�D�tumIs
ORDER BY El�z�D�tumIs.KiemeltNapok;

-- [lkF�oszt�lyiL�tsz�m2024If�l�v04]
TRANSFORM Sum(1) AS L�tsz�m
SELECT lktKorm�nyhivatali_�llom�ny.Ad�azonos�t�
FROM (lktKorm�nyhivatali_�llom�ny INNER JOIN tHaviJelent�sHat�lya1 ON lktKorm�nyhivatali_�llom�ny.hat�lyaID = tHaviJelent�sHat�lya1.hat�lyaID) INNER JOIN lkF�oszt�lyiL�tsz�m2024If�l�v01 ON tHaviJelent�sHat�lya1.hat�lyaID = lkF�oszt�lyiL�tsz�m2024If�l�v01.hat�lyaID
WHERE (((lktKorm�nyhivatali_�llom�ny.F�oszt�ly) Like "Hum�n*") AND ((lktKorm�nyhivatali_�llom�ny.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s"))
GROUP BY lktKorm�nyhivatali_�llom�ny.Ad�azonos�t�, lktKorm�nyhivatali_�llom�ny.F�oszt�ly
PIVOT tHaviJelent�sHat�lya1.hat�lya;

-- [lkF�oszt�lyiL�tsz�m2024If�l�v05]
SELECT lktKorm�nyhivatali_�llom�ny.Oszt�ly, lktKorm�nyhivatali_�llom�ny.Ad�azonos�t�, tHaviJelent�sHat�lya1.hat�lya, lkF�oszt�lyiL�tsz�m2024If�l�v03.El�z�, 1 AS L�tsz�m, tHaviJelent�sHat�lya1.hat�lyaID
FROM ((lktKorm�nyhivatali_�llom�ny INNER JOIN tHaviJelent�sHat�lya1 ON lktKorm�nyhivatali_�llom�ny.hat�lyaID = tHaviJelent�sHat�lya1.hat�lyaID) INNER JOIN lkF�oszt�lyiL�tsz�m2024If�l�v01 ON tHaviJelent�sHat�lya1.hat�lyaID = lkF�oszt�lyiL�tsz�m2024If�l�v01.hat�lyaID) INNER JOIN lkF�oszt�lyiL�tsz�m2024If�l�v03 ON tHaviJelent�sHat�lya1.hat�lyaID = lkF�oszt�lyiL�tsz�m2024If�l�v03.hat�lyaID
WHERE (((lktKorm�nyhivatali_�llom�ny.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s") AND ((lktKorm�nyhivatali_�llom�ny.F�oszt�ly) Like "Hum�n*"));

-- [lkF�oszt�lyiL�tsz�m2024If�l�v06bel�p�k]
SELECT jelenlegi.Oszt�ly, jelenlegi.hat�lya, Sum(IIf(IsNull([El�z�].[Ad�azonos�t�]),1,0)) AS Bel�p�k, Sum(0) AS Kil�p�k
FROM lkF�oszt�lyiL�tsz�m2024If�l�v05 AS el�z� RIGHT JOIN lkF�oszt�lyiL�tsz�m2024If�l�v05 AS jelenlegi ON (el�z�.hat�lya = jelenlegi.El�z�) AND (el�z�.Ad�azonos�t� = jelenlegi.Ad�azonos�t�)
GROUP BY jelenlegi.Oszt�ly, jelenlegi.hat�lya;

-- [lkF�oszt�lyiL�tsz�m2024If�l�v06kil�p�k]
SELECT el�z�.Oszt�ly, el�z�.hat�lya, Sum(0) AS Bel�p�k, Sum(IIf(IsNull([jelenlegi].[Ad�azonos�t�]),1,0)) AS Kil�p�k
FROM lkF�oszt�lyiL�tsz�m2024If�l�v05 AS el�z� LEFT JOIN lkF�oszt�lyiL�tsz�m2024If�l�v05 AS jelenlegi ON (el�z�.Ad�azonos�t� = jelenlegi.Ad�azonos�t�) AND (el�z�.hat�lya = jelenlegi.El�z�)
GROUP BY el�z�.Oszt�ly, el�z�.hat�lya;

-- [lkF�oszt�lyiL�tsz�m2024If�l�v06l�tsz�m]
SELECT lkF�oszt�lyiL�tsz�m2024If�l�v05.Oszt�ly, lkF�oszt�lyiL�tsz�m2024If�l�v05.hat�lya, Sum(lkF�oszt�lyiL�tsz�m2024If�l�v05.L�tsz�m) AS L�tsz�m
FROM lkF�oszt�lyiL�tsz�m2024If�l�v05
GROUP BY lkF�oszt�lyiL�tsz�m2024If�l�v05.Oszt�ly, lkF�oszt�lyiL�tsz�m2024If�l�v05.hat�lya;

-- [lkF�oszt�lyiL�tsz�m2024If�l�v06�sszes]
SELECT BeKil�p�k.Oszt�ly, BeKil�p�k.hat�lya, lkF�oszt�lyiL�tsz�m2024If�l�v06l�tsz�m.L�tsz�m, Sum(BeKil�p�k.Bel�p�k) AS SumOfBel�p�k, Sum(BeKil�p�k.Kil�p�k) AS SumOfKil�p�k
FROM lkF�oszt�lyiL�tsz�m2024If�l�v06l�tsz�m INNER JOIN (SELECT lkF�oszt�lyiL�tsz�m2024If�l�v06kil�p�k.*
FROM lkF�oszt�lyiL�tsz�m2024If�l�v06kil�p�k
UNION
SELECT lkF�oszt�lyiL�tsz�m2024If�l�v06bel�p�k.*
FROM  lkF�oszt�lyiL�tsz�m2024If�l�v06bel�p�k
)  AS BeKil�p�k ON (lkF�oszt�lyiL�tsz�m2024If�l�v06l�tsz�m.Oszt�ly = BeKil�p�k.Oszt�ly) AND (lkF�oszt�lyiL�tsz�m2024If�l�v06l�tsz�m.hat�lya = BeKil�p�k.hat�lya)
GROUP BY BeKil�p�k.Oszt�ly, BeKil�p�k.hat�lya, lkF�oszt�lyiL�tsz�m2024If�l�v06l�tsz�m.L�tsz�m
HAVING (((BeKil�p�k.hat�lya) Between #1/1/2024# And #6/30/2024#));

-- [lkF�oszt�lyiL�tsz�m2024If�l�v07]
SELECT jelenlegi.F�oszt�ly, jelenlegi.Oszt�ly, jelenlegi.N�v, jelenlegi.Ad�azonos�t�, jelenlegi.[Ell�tott feladat], lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)], lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)], IIf(IsNull([El�z�].[F�oszt�ly]) And IsNull([El�z�].[oszt�ly]),"",Format([jelenlegi].[hat�lya],"yyyy/ mm/")) AS H�napt�l, "" AS H�napig, [El�z�].[F�oszt�ly] & IIf(IsNull([El�z�].[Oszt�ly]),"","/" & [El�z�].[Oszt�ly]) AS Honnan, [Jelenlegi].[F�oszt�ly] & "/" & [Jelenlegi].[Oszt�ly] AS Hov�, jelenlegi.Jogviszony, jelenlegi.hat�lyaID, IIf(IsNull([El�z�].[Ad�azonos�t�]),1,0) AS Bel�p�
FROM lkSzem�lyek INNER JOIN (lkF�oszt�lyiL�tsz�m2024If�l�v0700 AS el�z� RIGHT JOIN lkF�oszt�lyiL�tsz�m2024If�l�v0700 AS jelenlegi ON (el�z�.hat�lya = jelenlegi.El�z�) AND (el�z�.Ad�azonos�t� = jelenlegi.Ad�azonos�t�)) ON lkSzem�lyek.[Ad�azonos�t� jel] = jelenlegi.Ad�azonos�t�
WHERE (((jelenlegi.F�oszt�ly)<>[El�z�].[f�oszt�ly])) OR (((jelenlegi.Oszt�ly)<>[El�z�].[oszt�ly])) OR (((el�z�.F�oszt�ly) Is Null) AND ((el�z�.Oszt�ly) Is Null));

-- [lkF�oszt�lyiL�tsz�m2024If�l�v0700]
SELECT lk�llom�nyt�bl�kT�rt�netiUni�ja.F�oszt AS F�oszt�ly, lk�llom�nyt�bl�kT�rt�netiUni�ja.Oszt�ly, lk�llom�nyt�bl�kT�rt�netiUni�ja.Ad�azonos�t�, lk�llom�nyt�bl�kT�rt�netiUni�ja.N�v, lk�llom�nyt�bl�kT�rt�netiUni�ja.[Ell�tott feladat], tHaviJelent�sHat�lya1.hat�lya, lkF�oszt�lyiL�tsz�m2024If�l�v03.El�z�, 1 AS L�tsz�m, tHaviJelent�sHat�lya1.hat�lyaID, IIf(InStr(1,[Besorol�si fokozat k�d:],"Mt.")>0,"Mt.","Kit.") AS Jogviszony
FROM ((lk�llom�nyt�bl�kT�rt�netiUni�ja INNER JOIN tHaviJelent�sHat�lya1 ON lk�llom�nyt�bl�kT�rt�netiUni�ja.hat�lyaID = tHaviJelent�sHat�lya1.hat�lyaID) INNER JOIN lkF�oszt�lyiL�tsz�m2024If�l�v01 ON tHaviJelent�sHat�lya1.hat�lyaID = lkF�oszt�lyiL�tsz�m2024If�l�v01.hat�lyaID) INNER JOIN lkF�oszt�lyiL�tsz�m2024If�l�v03 ON tHaviJelent�sHat�lya1.hat�lyaID = lkF�oszt�lyiL�tsz�m2024If�l�v03.hat�lyaID
WHERE (((lk�llom�nyt�bl�kT�rt�netiUni�ja.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s"));

-- [lkF�oszt�lyL�tsz�m�sVezet�kN�lk�li�tlagb�r01]
SELECT DISTINCT lkHaviL�tsz�mF�oszt�ly.Jelleg, IIf(Len([F�oszt�lyK�d])<=9,0,IIf([F�oszt�lyK�d] Like "BFKH.1.2.*",2,1)) AS Sorrend, lkF�oszt�lyok.F�oszt�lyK�d, lkHaviL�tsz�mF�oszt�ly.F�oszt�ly, lkF�oszt�lyL�tsz�m�sVezet�kN�lk�li�tlagb�r01b.Enged�lyezett, lkHaviL�tsz�mF�oszt�ly.[Bet�lt�tt l�tsz�m], "" AS [indokol�s a bet�ltetlen �ll�shelyhez], lkHaviL�tsz�mF�oszt�ly.[�res �ll�shely], lk_F�oszt�lyonk�nti_�tlagilletm�ny02_vezet�kn�lk�l.�tlagilletm�ny
FROM lkF�oszt�lyL�tsz�m�sVezet�kN�lk�li�tlagb�r01b RIGHT JOIN (lkF�oszt�lyok RIGHT JOIN (lk_F�oszt�lyonk�nti_�tlagilletm�ny02_vezet�kn�lk�l RIGHT JOIN lkHaviL�tsz�mF�oszt�ly ON lk_F�oszt�lyonk�nti_�tlagilletm�ny02_vezet�kn�lk�l.F�oszt�ly = lkHaviL�tsz�mF�oszt�ly.F�oszt�ly) ON lkF�oszt�lyok.F�oszt�ly = lkHaviL�tsz�mF�oszt�ly.F�oszt�ly) ON (lkF�oszt�lyL�tsz�m�sVezet�kN�lk�li�tlagb�r01b.F�oszt�ly�ll�shely = lkHaviL�tsz�mF�oszt�ly.F�oszt�ly) AND (lkF�oszt�lyL�tsz�m�sVezet�kN�lk�li�tlagb�r01b.jelleg = lkHaviL�tsz�mF�oszt�ly.Jelleg);

-- [lkF�oszt�lyL�tsz�m�sVezet�kN�lk�li�tlagb�r01b]
SELECT lk�ll�shelyek.F�oszt�ly�ll�shely, Count(lk�ll�shelyek.[�ll�shely azonos�t�]) AS Enged�lyezett, IIf([�ll�shely t�pusa] Like "ALAP*","A","K") AS jelleg
FROM lk�ll�shelyek
GROUP BY lk�ll�shelyek.F�oszt�ly�ll�shely, IIf([�ll�shely t�pusa] Like "ALAP*","A","K");

-- [lkF�oszt�lyL�tsz�m�sVezet�kN�lk�li�tlagb�r02]
SELECT lkF�oszt�lyL�tsz�m�sVezet�kN�lk�li�tlagb�r01.F�oszt�ly, lkF�oszt�lyL�tsz�m�sVezet�kN�lk�li�tlagb�r01.Enged�lyezett, lkF�oszt�lyL�tsz�m�sVezet�kN�lk�li�tlagb�r01.[Bet�lt�tt l�tsz�m], lkF�oszt�lyL�tsz�m�sVezet�kN�lk�li�tlagb�r01.[indokol�s a bet�ltetlen �ll�shelyhez], lkF�oszt�lyL�tsz�m�sVezet�kN�lk�li�tlagb�r01.[�res �ll�shely], lkF�oszt�lyL�tsz�m�sVezet�kN�lk�li�tlagb�r01.�tlagilletm�ny
FROM lkF�oszt�lyL�tsz�m�sVezet�kN�lk�li�tlagb�r01
ORDER BY lkF�oszt�lyL�tsz�m�sVezet�kN�lk�li�tlagb�r01.Jelleg, lkF�oszt�lyL�tsz�m�sVezet�kN�lk�li�tlagb�r01.Sorrend, lkF�oszt�lyL�tsz�m�sVezet�kN�lk�li�tlagb�r01.F�oszt�lyK�d;

-- [lkF�oszt�lyok]
SELECT DISTINCT lkSzem�lyek.[Szervezeti egys�g k�dja], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.BFKH, lkSzem�lyek.F�oszt�lyK�d
FROM lkSzem�lyek;

-- [lkF�oszt�lyokL�tsz�m�nakKer�letenk�ntiEloszl�sa]
SELECT lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m01.F�oszt�ly, lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m01.Ker�let, [L�tsz�m]/[F�oszt�lyiL�tsz�m] AS Ar�ny
FROM lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m01 INNER JOIN lkF�oszt�lyonk�ntiBet�lt�ttL�tsz�m ON lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m01.F�oszt�ly = lkF�oszt�lyonk�ntiBet�lt�ttL�tsz�m.F�oszt�ly;

-- [lkF�oszt�lyokOszt�lyokSorsz�mal2]
SELECT lk_F�oszt�ly_Oszt�ly_lkSzem�lyek.BFKH, lk_F�oszt�ly_Oszt�ly_lkSzem�lyek.F�oszt�ly, lk_F�oszt�ly_Oszt�ly_lkSzem�lyek.Oszt�ly, [lk_F�oszt�ly_Oszt�ly_lkSzem�lyek].[Sorsz�m]*1 AS Sorsz�m INTO tF�oszt�lyokOszt�lyokSorsz�mmal
FROM lk_F�oszt�ly_Oszt�ly_lkSzem�lyek
WHERE (((lk_F�oszt�ly_Oszt�ly_lkSzem�lyek.BFKH) Like "BFKH*"))
ORDER BY [lk_F�oszt�ly_Oszt�ly_lkSzem�lyek].[Sorsz�m]*1;

-- [lkF�oszt�lyokOszt�lyokSorsz�mmal]
SELECT tF�oszt�lyokOszt�lyokSorsz�mmal.bfkh AS bfkhk�d, tF�oszt�lyokOszt�lyokSorsz�mmal.F�oszt�ly, tF�oszt�lyokOszt�lyokSorsz�mmal.Oszt�ly, tF�oszt�lyokOszt�lyokSorsz�mmal.Sorsz�m AS Sorsz
FROM tF�oszt�lyokOszt�lyokSorsz�mmal;

-- [lkF�oszt�lyon�ntiOszt�lyonk�ntiL�tsz�m]
SELECT 1 AS sor, lkSzem�lyek.BFKH, lkSzem�lyek.F�oszt�ly, Nz(Oszt�ly,"-") AS Oszt�ly_, Count(*) AS L�tsz�m
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null))
GROUP BY 1, lkSzem�lyek.BFKH, lkSzem�lyek.F�oszt�ly, Nz(Oszt�ly,"-"), lkSzem�lyek.F�oszt�lyK�d, lkSzem�lyek.Oszt�ly;

-- [lkF�oszt�lyonk�ntiBet�lt�ttL�tsz�m]
SELECT lkSzem�lyekF�oszt�s�sszesen.F�oszt�ly AS F�oszt�ly, lkSzem�lyekF�oszt�s�sszesen.F�oszt�lyiL�tsz�m AS F�oszt�lyiL�tsz�m, [lk_TT-sekF�oszt�lyonk�nt].[Tart�san t�voll�v�k] AS [Tart�san t�voll�v�k], [Tart�san t�voll�v�k]/([F�oszt�lyiL�tsz�m]) AS [TT-sek ar�nya], lkSzem�lyekF�oszt�s�sszesen.K�zpontos�tottL�tsz�m AS [K�zpontos�tott l�tsz�m]
FROM [lk_TT-sekF�oszt�lyonk�nt] RIGHT JOIN lkSzem�lyekF�oszt�s�sszesen ON [lk_TT-sekF�oszt�lyonk�nt].F�oszt�ly = lkSzem�lyekF�oszt�s�sszesen.F�oszt�ly
ORDER BY [lkSzem�lyekF�oszt�s�sszesen].[Sor] & ".", lkSzem�lyekF�oszt�s�sszesen.F�osztK�d;

-- [lkF�oszt�lyonk�ntiOszt�lyonk�ntiL�tsz�m_r�sz�sszegekkel]
SELECT [Sor] & "." AS Sorsz, UNI�.BFKH AS [Szervezeti egys�g k�d], UNI�.F�oszt�ly, UNI�.Oszt�ly, UNI�.L�tsz�m
FROM (SELECT 0 AS sor, bfkh(Nz(lkSzem�lyek.F�oszt�lyK�d,0)) AS BFKH, lkSzem�lyek.F�oszt�ly, "�sszesen:" AS Oszt�ly, Count(*) AS L�tsz�m
    FROM lkSzem�lyek
    WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
    GROUP BY 0, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.F�oszt�lyK�d, ""

    UNION
    SELECT 1 as sor, bfkh(Nz(lkSzem�lyek.F�oszt�lyK�d,0)) AS BFKH, F�oszt�ly,Oszt�ly, Count(*) as L�tsz�m
    FROM lkSzem�lyek
    WHERE lkSzem�lyek.[St�tusz neve]="�ll�shely"
    GROUP BY 1,bfkh(Nz(lkSzem�lyek.F�oszt�lyK�d,0)) , lkSzem�lyek.F�oszt�ly,lkSzem�lyek.F�oszt�lyK�d,Oszt�ly
    )  AS UNI�
WHERE ((("/// Le�r�s: A megadott lek�rdez�s k�t SELECT utas�t�st kombin�l az UNION haszn�lat�val, hogy egyetlen eredm�nyk�szletet hozzon l�tre. 
        Az els� SELECT kimutat�s a f�oszt�lyonk�nti (oszt�lyvezet�i), m�g a m�sodik SELECT utas�t�s a BFKH-nk�nt (oszt�lyonk�nti) �s a 
        f�oszt�lyonk�nti dolgoz�k sz�m�t sz�molja ki. 
        Az eredm�ny�l kapott adatk�szlet tartalmazza a Sor (sorsz�m), Szervezeti egys�g k�d (szervezeti egys�g k�dja), F�oszt�ly, 
        Oszt�ly �s L�tsz�m (alkalmazottak sz�ma) oszlopokat. 
        A v�geredm�nyt ezut�n a BFKH �s a sor szerint cs�kken� sorrendbe rendezi. ///")<>False))
ORDER BY UNI�.BFKH, UNI�.sor DESC , UNI�.Oszt�ly;

-- [lkF�oszt�lyOszt�lyN�vIlletm�ny]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)] AS Illetm�ny, lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker] AS �rasz�m, [Illetm�ny]/[�rasz�m]*40 AS [40 �r�s illetm�ny], lkSzem�lyek.[Tart�s t�voll�t t�pusa]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Tart�s t�voll�t t�pusa])="" Or (lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.BFKH;

-- [lkF�oszt�lyvezet�kHivatalvezet�k]
SELECT lkMindenVezet�.F�oszt�ly, lkMindenVezet�.[Dolgoz� teljes neve] AS N�v, lkMindenVezet�.Besorol�s2
FROM lkMindenVezet�
WHERE (((lkMindenVezet�.Besorol�s2)<>"oszt�lyvezet�" And (lkMindenVezet�.Besorol�s2) Not Like "*helyett*" And (lkMindenVezet�.Besorol�s2)<>"f�isp�n" And (lkMindenVezet�.Besorol�s2) Not Like "*igazgat�*"));

-- [lkF�osztOsztSzint�Mobilit�s_Befogad�k]
SELECT t�llom�nyUni�20231231.[J�r�si Hivatal], t�llom�nyUni�20231231.Oszt�ly, Count(t�llom�nyUni�20231231.Ad�azonos�t�) AS [L�tsz�m (f�)]
FROM t�llom�nyUni�20231231 INNER JOIN t�llom�nyUni�20230102 ON t�llom�nyUni�20231231.Ad�azonos�t� = t�llom�nyUni�20230102.Ad�azonos�t�
WHERE (((t�llom�nyUni�20231231.[�NYR SZERVEZETI EGYS�G AZONOS�T�])<>[t�llom�nyUni�20230102].[�NYR SZERVEZETI EGYS�G AZONOS�T�]) AND ((t�llom�nyUni�20231231.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s"))
GROUP BY t�llom�nyUni�20231231.[J�r�si Hivatal], t�llom�nyUni�20231231.Oszt�ly;

-- [lkF�osztOsztSzint�Mobilit�s_Kibocs�t�k]
SELECT t�llom�nyUni�20230102.[J�r�si Hivatal], t�llom�nyUni�20230102.Oszt�ly, Count(t�llom�nyUni�20230102.Ad�azonos�t�) AS [L�tsz�m (f�)]
FROM t�llom�nyUni�20231231 INNER JOIN t�llom�nyUni�20230102 ON t�llom�nyUni�20231231.Ad�azonos�t� = t�llom�nyUni�20230102.Ad�azonos�t�
WHERE (((t�llom�nyUni�20230102.[�NYR SZERVEZETI EGYS�G AZONOS�T�])<>t�llom�nyUni�20231231.[�NYR SZERVEZETI EGYS�G AZONOS�T�]) And ((t�llom�nyUni�20230102.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s"))
GROUP BY t�llom�nyUni�20230102.[J�r�si Hivatal], t�llom�nyUni�20230102.Oszt�ly;

-- [lkF�osztSzint�Mobilit�s_Befogad�k]
SELECT t�llom�nyUni�20231231.[J�r�si Hivatal], Count(t�llom�nyUni�20231231.Ad�azonos�t�) AS [L�tsz�m (f�)]
FROM t�llom�nyUni�20231231 INNER JOIN t�llom�nyUni�20230102 ON t�llom�nyUni�20231231.Ad�azonos�t� = t�llom�nyUni�20230102.Ad�azonos�t�
WHERE (((t�llom�nyUni�20231231.[J�r�si Hivatal])<>[t�llom�nyUni�20230102].[J�r�si Hivatal]) AND ((t�llom�nyUni�20231231.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s"))
GROUP BY t�llom�nyUni�20231231.[J�r�si Hivatal];

-- [lkF�osztSzint�Mobilit�s_Kibocs�t�k]
SELECT t�llom�nyUni�20230102.[J�r�si Hivatal], Count(t�llom�nyUni�20230102.Ad�azonos�t�) AS [L�tsz�m (f�)]
FROM t�llom�nyUni�20231231 INNER JOIN t�llom�nyUni�20230102 ON t�llom�nyUni�20231231.Ad�azonos�t� = t�llom�nyUni�20230102.Ad�azonos�t�
WHERE (((t�llom�nyUni�20230102.[J�r�si Hivatal])<>[t�llom�nyUni�20231231].[J�r�si Hivatal]) AND ((t�llom�nyUni�20230102.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s"))
GROUP BY t�llom�nyUni�20230102.[J�r�si Hivatal];

-- [lkFunkci�kSzerintiL�tsz�mok01]
SELECT lkSzem�lyek.Ad�jel, lkSzem�lyek.Feladat, lkSzem�lyek.[KIRA feladat megnevez�s], IIf([Funkci�]="-",IIf([Funkcion�lis]=True,"a) csoport","Egy�b (�) II"),[Funkci�]) AS Funkci�ja, Choose(Left(IIf([Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is] Is Null Or [Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is]="",0,[Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is]),1)*1,"alapfok�","k�z�pfok�","fels�fok�","fels�fok�","k�z�pfok�","k�z�pfok�") AS V�gzetts�g, IIf([lkSzem�lyek].[Besorol�s2] Like "*oszt�ly*" Or [lkSzem�lyek].[Besorol�s2] Like "*j�r�si*" Or [lkSzem�lyek].[Besorol�s2] Like "*igazgat�*" Or [lkSzem�lyek].[Besorol�s2] Like "f�isp�n","Vezet�i l�tsz�m","Nem vezet�i l�tsz�m") AS Vezet�, 1 AS L�tsz�m, lkSzem�lyek.[jogviszony t�pusa / jogviszony t�pus] AS Jogviszony
FROM lkJ�r�siKorm�nyK�zpontos�tottUni� RIGHT JOIN (tFunkcion�lisSzakmaiF�oszt�lyok RIGHT JOIN (lkFeladatKirafeladatFunkci� RIGHT JOIN lkSzem�lyek ON (lkFeladatKirafeladatFunkci�.[KIRA feladat megnevez�s] = lkSzem�lyek.[KIRA feladat megnevez�s]) AND (lkFeladatKirafeladatFunkci�.Feladata = lkSzem�lyek.Feladat)) ON tFunkcion�lisSzakmaiF�oszt�lyok.SzervezetK�d = lkSzem�lyek.F�oszt�lyK�d) ON lkJ�r�siKorm�nyK�zpontos�tottUni�.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null) AND ((lkSzem�lyek.[St�tusz t�pusa]) Not Like "K�zpontos�t*") AND ((lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� havi �raker])>=60) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [lkFunkci�kSzerintiL�tsz�mok02]
SELECT lkFunkci�kSzerintiL�tsz�mok01.Funkci�ja, lkFunkci�kSzerintiL�tsz�mok01.V�gzetts�g, lkFunkci�kSzerintiL�tsz�mok01.Vezet�, lkFunkci�kSzerintiL�tsz�mok01.Jogviszony AS Jogviszony, Sum(lkFunkci�kSzerintiL�tsz�mok01.L�tsz�m) AS SumOfL�tsz�m
FROM lkFunkci�kSzerintiL�tsz�mok01
GROUP BY lkFunkci�kSzerintiL�tsz�mok01.Funkci�ja, lkFunkci�kSzerintiL�tsz�mok01.V�gzetts�g, lkFunkci�kSzerintiL�tsz�mok01.Vezet�, lkFunkci�kSzerintiL�tsz�mok01.Jogviszony;

-- [lkFunkci�kSzerintiL�tsz�mok03]
SELECT lkFunkci�kSzerintiL�tsz�mok02.Funkci�ja, lkFunkci�kSzerintiL�tsz�mok02.V�gzetts�g, lkFunkci�kSzerintiL�tsz�mok02.Vezet�, lkFunkci�kSzerintiL�tsz�mok02.Jogviszony, lkFunkci�kSzerintiL�tsz�mok02.SumOfL�tsz�m AS L�tsz�m, Round([L�tsz�m]*Nz([Enged�lyezett l�tsz�m, ha semmi, akkor 5350],5350)/(Select sum([L�tsz�m]) from lkFunkci�kSzerintiL�tsz�mok01),0) AS Statisztikai
FROM lkFunkci�kSzerintiL�tsz�mok02;

-- [lkGarant�ltB�rminimumEmel�se]
PARAMETERS [Emel�s%] IEEEDouble;
SELECT lkSzem�lyek.Ad�jel, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Iskolai v�gzetts�g foka], lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker], [Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40 AS Illetm�ny40, (296400*(1+[Emel�s%]/100))/[Illetm�ny40]-1 AS [Sz�ks�ges emel�s], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h]
FROM lkSzem�lyek INNER JOIN lkJ�r�siKorm�nyK�zpontos�tottUni� ON lkSzem�lyek.Ad�jel=lkJ�r�siKorm�nyK�zpontos�tottUni�.Ad�jel
WHERE (((lkSzem�lyek.[Iskolai v�gzetts�g foka])<>"�ltal�nos iskola 8 oszt�ly") AND (([Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40)<296400*(1+[Emel�s%]/100)) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)])>#7/1/2023# Or (lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)]) Is Null));

-- [lkGy�m�gyiDolgoz�k]
SELECT lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[KIRA feladat megnevez�s], lkSzem�lyek.[Tart�s t�voll�t t�pusa], lkSzem�lyek.[Tart�s t�voll�t v�ge], lkSzem�lyek.[Tart�s t�voll�t tervezett v�ge]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.F�oszt�ly) Like "*gy�m*")) OR (((lkSzem�lyek.Oszt�ly) Like "*gy�m*"))
ORDER BY lkSzem�lyek.BFKH, lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkGy�m�gyiF�oszt�lyDolgoz�i]
SELECT Gy�mDolgoz�k.Ad�jel, Gy�mDolgoz�k.N�v, Gy�mDolgoz�k.[Jelenlegi f�oszt�lya], Gy�mDolgoz�k.[Jelenlegi oszt�lya], Gy�mDolgoz�k.F�oszt�ly, Gy�mDolgoz�k.Oszt�ly, Gy�mDolgoz�k.Bel�p�s, Gy�mDolgoz�k.Kil�p�s, Megjegyz�s
FROM (SELECT lk2019�taAGy�m�gyr�lKil�pettek.*, "2019 �ta kil�pett" as Megjegyz�s
FROM lk2019�taAGy�m�gyr�lKil�pettek
UNION SELECT lkAGy�monJelenlegDolgoz�k.*, "Jelenleg a Gym�gyi F�oszt�lyon dolgozik" as Megjegyz�s
FROM lkAGy�monJelenlegDolgoz�k
UNION SELECT lk2019�taAGy�mraBel�pettek.*, "2019 �ta l�pett be" as Megjegyz�s
FROM lk2019�taAGy�mraBel�pettek)  AS Gy�mDolgoz�k
ORDER BY Gy�mDolgoz�k.N�v, Gy�mDolgoz�k.Bel�p�s;

-- [lkHASHCsere01]
PARAMETERS [Megtartand� szakaszok sz�ma] Short, Lek�rdez�s Text ( 255 );
SELECT tR�giHib�k.lek�rdez�sNeve, TextToMD5Hex(strV�ge([M�sodik mez�],"|",[megtartand� szakaszok sz�ma])) AS �jHash, tR�giHib�k.[Els� Id�pont], strV�ge([M�sodik mez�],"|",[megtartand� szakaszok sz�ma]) AS [�j sz�veg]
FROM tR�giHib�k
WHERE (((tR�giHib�k.lek�rdez�sNeve)=[lek�rdez�s]));

-- [lkHASHCsere02]
UPDATE lkHASHCsere01 INNER JOIN tR�giHib�k ON lkHASHCsere01.�jHash = tR�giHib�k.[Els� mez�] SET tR�giHib�k.[Els� Id�pont] = [lkHASHCsere01].[Els� Id�pont];

-- [lkHat�lyIDDistinct]
SELECT DISTINCT lk�llom�nyt�bl�kT�rt�netiUni�ja.hat�lyaID
FROM lk�llom�nyt�bl�kT�rt�netiUni�ja;

-- [lkHat�lyUnion]
SELECT Korm�nyhivatali_�llom�ny.Hat�lyaID
FROM Korm�nyhivatali_�llom�ny
UNION
SELECT J�r�si_�llom�ny.Hat�lyaID
FROM J�r�si_�llom�ny
UNION
SELECT K�zpontos�tottak.Hat�lyaID
FROM K�zpontos�tottak
UNION
SELECT Hat�rozottak.Hat�lyaID
FROM Hat�rozottak
UNION
SELECT Bel�p�k.Hat�lyaID
FROM Bel�p�k
UNION
SELECT Kil�p�k.Hat�lyaID
FROM Kil�p�k
UNION
SELECT Fedlapr�lL�tsz�mt�bla.Hat�lyaID
FROM Fedlapr�lL�tsz�mt�bla
UNION SELECT Fedlapr�lL�tsz�mt�bla2.Hat�lyaID
FROM Fedlapr�lL�tsz�mt�bla2;

-- [lkHat�lyUnionCount]
SELECT Count(lkHat�lyUnion.Hat�lyaID) AS Sz�m
FROM lkHat�lyUnion;

-- [lkHat�rozottak_TT]
SELECT Hat�rozottak.[Tart�s t�voll�v� neve], Hat�rozottak.Ad�azonos�t�, Hat�rozottak.[Megyei szint VAGY J�r�si Hivatal], Hat�rozottak.Mez�5, Hat�rozottak.Mez�6, Hat�rozottak.[�NYR SZERVEZETI EGYS�G AZONOS�T�], Hat�rozottak.Mez�8, Hat�rozottak.[Besorol�si fokozat k�d:], Hat�rozottak.[Besorol�si fokozat megnevez�se:], Hat�rozottak.[�ll�shely azonos�t�], Hat�rozottak.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], Hat�rozottak.[Tart�s t�voll�t kezdete], Hat�rozottak.[Tart�s t�voll�t v�rhat� v�ge], Hat�rozottak.[Tart�san t�voll�v� illetm�ny�nek teljes �sszege], "" AS �res
FROM Hat�rozottak;

-- [lkHat�rozottak_TTH]
SELECT Hat�rozottak.[Tart�s t�voll�v� �ll�shely�n hat�rozott id�re foglalkoztatott ne], Hat�rozottak.Mez�17, Hat�rozottak.Mez�18, Hat�rozottak.Mez�19, Hat�rozottak.Mez�20, Hat�rozottak.Mez�21, Hat�rozottak.Mez�22, Hat�rozottak.Mez�23, Hat�rozottak.Mez�24, Hat�rozottak.Mez�25, Hat�rozottak.[Tart�s t�voll�v� st�tusz�n foglalkoztatott hat�rozott idej� jogv], Hat�rozottak.Mez�27, Hat�rozottak.[Tart�s t�voll�v� st�tusz�n foglalkoztatott illetm�ny�nek teljes ], "" AS �res
FROM Hat�rozottak;

-- [lkHat�rozottak_TTH_Oszt�lyonk�ntiL�tsz�m]
SELECT lkHat�rozottak_TTH.Mez�21 AS BFKH, IIf([Mez�18]="megyei szint",[Mez�19],[Mez�18]) AS F�oszt�ly, lkHat�rozottak_TTH.Mez�20 AS Oszt�ly, 0 AS [Bet�lt�tt l�tsz�m], 0 AS TTL�tsz�m, Count(lkHat�rozottak_TTH.Mez�17) AS Hat�rozottL�tsz�m, 0 AS Korr
FROM lkHat�rozottak_TTH
GROUP BY lkHat�rozottak_TTH.Mez�21, IIf([Mez�18]="megyei szint",[Mez�19],[Mez�18]), lkHat�rozottak_TTH.Mez�20, 0, "", 0, 0, 0;

-- [lkHat�rozottak_TTH_Szem�lyt�rzs_alapj�n]
SELECT lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.Ad�jel, lkSzem�lyek.[Szervezeti egys�g k�dja], lkSzem�lyek.[Besorol�si  fokozat (KT)], lkSzem�lyek.[Besorol�si  fokozat (KT)], lkSzem�lyek.[St�tusz k�dja], lkSzem�lyek.[Helyettes�tett dolgoz� neve], lkSzem�lyek.[Helyettes�tett dolgoz� szerz�d�s/kinevez�ses munkak�re] AS Kif1
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Helyettes�tett dolgoz� neve]) Is Not Null));

-- [lkHat�rozottak�sHelyettesek]
SELECT lkSzem�lyek.[Szerz�d�s/Kinevez�s t�pusa], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[St�tusz k�dja] AS �NYR, lkSzem�lyek.[Besorol�si  fokozat (KT)], lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, Trim([El�n�v1] & " " & [Csal�di n�v1] & " " & [Ut�n�v1]) AS [Helyettes�tett neve], lkSzem�lyek.[Hat�rozott idej� _szerz�d�s/kinevez�s lej�r] AS [Hat�rozott id� v�ge]
FROM Besorol�sHelyettes�tett RIGHT JOIN lkSzem�lyek ON Besorol�sHelyettes�tett.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[Szerz�d�s/Kinevez�s t�pusa])="hat�rozott") AND ((lkSzem�lyek.[KIRA jogviszony jelleg])="Korm�nyzati szolg�lati jogviszony (KIT)") AND ((lkSzem�lyek.[St�tusz t�pusa])="Szervezeti alapl�tsz�m")) OR (((lkSzem�lyek.[KIRA jogviszony jelleg])="Korm�nyzati szolg�lati jogviszony (KIT)") AND ((lkSzem�lyek.[St�tusz t�pusa])="Szervezeti alapl�tsz�m") AND ((Besorol�sHelyettes�tett.Ad�jel) Is Not Null))
ORDER BY lkSzem�lyek.[Szerz�d�s/Kinevez�s t�pusa];

-- [lkh�tt�rt�r_tBesorol�siEredm�nyadatok_�tt�lt�s]
INSERT INTO tBesorol�siEredm�nyadatok IN 'L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\H�tt�rt�rak\Ellen�rz�s_0.9.6_h�tt�r_.mdb.accdb'
SELECT [tBesorol�siEredm�nyadatok_import].[Ad�azonos�t� jel] AS [Ad�azonos�t� jel], [tBesorol�siEredm�nyadatok_import].[TAJ sz�m] AS [TAJ sz�m], [tBesorol�siEredm�nyadatok_import].[Egyedi azonos�t�] AS [Egyedi azonos�t�], [tBesorol�siEredm�nyadatok_import].[T�rzssz�m] AS T�rzssz�m, [tBesorol�siEredm�nyadatok_import].[El�n�v] AS El�n�v, [tBesorol�siEredm�nyadatok_import].[Csal�di n�v] AS [Csal�di n�v], [tBesorol�siEredm�nyadatok_import].[Ut�n�v] AS Ut�n�v, [tBesorol�siEredm�nyadatok_import].[Jogviszony ID] AS [Jogviszony ID], [tBesorol�siEredm�nyadatok_import].[K�d] AS K�d, [tBesorol�siEredm�nyadatok_import].[Megnevez�s] AS Megnevez�s, [tBesorol�siEredm�nyadatok_import].[Kezdete] AS Kezdete, [tBesorol�siEredm�nyadatok_import].[V�ge] AS V�ge, [tBesorol�siEredm�nyadatok_import].[V�ltoz�s d�tuma] AS [V�ltoz�s d�tuma], [tBesorol�siEredm�nyadatok_import].[Kezdete1] AS Kezdete1, [tBesorol�siEredm�nyadatok_import].[V�ge2] AS V�ge2, [tBesorol�siEredm�nyadatok_import].[Megnevez�s3] AS Megnevez�s3, [tBesorol�siEredm�nyadatok_import].[Kezdete4] AS Kezdete4, [tBesorol�siEredm�nyadatok_import].[V�ge5] AS V�ge5, [tBesorol�siEredm�nyadatok_import].[Napi �ra] AS [Napi �ra], [tBesorol�siEredm�nyadatok_import].[Heti �ra] AS [Heti �ra], [tBesorol�siEredm�nyadatok_import].[Havi �ra] AS [Havi �ra], [tBesorol�siEredm�nyadatok_import].[Kezdete6] AS Kezdete6, [tBesorol�siEredm�nyadatok_import].[V�ge7] AS V�ge7, [tBesorol�siEredm�nyadatok_import].[T�pus] AS T�pus, [tBesorol�siEredm�nyadatok_import].[Jelleg] AS Jelleg, [tBesorol�siEredm�nyadatok_import].[Kezdete8] AS Kezdete8, [tBesorol�siEredm�nyadatok_import].[V�ge9] AS V�ge9, [tBesorol�siEredm�nyadatok_import].[Besorol�si fokozat] AS [Besorol�si fokozat], [tBesorol�siEredm�nyadatok_import].[Nem fogadta el a besorol�st] AS [Nem fogadta el a besorol�st], [tBesorol�siEredm�nyadatok_import].[Kezdete10] AS Kezdete10, [tBesorol�siEredm�nyadatok_import].[V�ge11] AS V�ge11, [tBesorol�siEredm�nyadatok_import].[Kulcssz�m] AS Kulcssz�m, [tBesorol�siEredm�nyadatok_import].[Besorol�si oszt�ly] AS [Besorol�si oszt�ly], [tBesorol�siEredm�nyadatok_import].[Besorol�si fokozat12] AS [Besorol�si fokozat12], [tBesorol�siEredm�nyadatok_import].[K�vetkez� besorol�si fokozat d�tum] AS [K�vetkez� besorol�si fokozat d�tum], [tBesorol�siEredm�nyadatok_import].[Fikt�v kulcssz�m] AS [Fikt�v kulcssz�m], [tBesorol�siEredm�nyadatok_import].[Fikt�v besorol�si oszt�ly] AS [Fikt�v besorol�si oszt�ly], [tBesorol�siEredm�nyadatok_import].[Fikt�v besorol�si fokozat] AS [Fikt�v besorol�si fokozat], [tBesorol�siEredm�nyadatok_import].[Fikt�v k�vetkez� besorol�si fokozat d�tum] AS [Fikt�v k�vetkez� besorol�si fokozat d�tum], [tBesorol�siEredm�nyadatok_import].[Utols� besorol�s d�tuma] AS [Utols� besorol�s d�tuma], [tBesorol�siEredm�nyadatok_import].[Kezdete13] AS Kezdete13, [tBesorol�siEredm�nyadatok_import].[V�ge14] AS V�ge14, [tBesorol�siEredm�nyadatok_import].[Eszmei fizet�si fokozat id�] AS [Eszmei fizet�si fokozat id�], [tBesorol�siEredm�nyadatok_import].[Kezdete15] AS Kezdete15, [tBesorol�siEredm�nyadatok_import].[V�ge16] AS V�ge16, [tBesorol�siEredm�nyadatok_import].[Eszmei k�zszolg�lati jogviszony id�] AS [Eszmei k�zszolg�lati jogviszony id�], [tBesorol�siEredm�nyadatok_import].[Kezdete17] AS Kezdete17, [tBesorol�siEredm�nyadatok_import].[V�ge18] AS V�ge18, [tBesorol�siEredm�nyadatok_import].[K�zszolg�lati jogviszony id�] AS [K�zszolg�lati jogviszony id�], [tBesorol�siEredm�nyadatok_import].[Kezdete19] AS Kezdete19, [tBesorol�siEredm�nyadatok_import].[V�ge20] AS V�ge20, [tBesorol�siEredm�nyadatok_import].[Sz�m�tott fizet�si fokozat id�] AS [Sz�m�tott fizet�si fokozat id�], [tBesorol�siEredm�nyadatok_import].[Kezdete21] AS Kezdete21, [tBesorol�siEredm�nyadatok_import].[V�ge22] AS V�ge22, [tBesorol�siEredm�nyadatok_import].[Szolg�lati elismer�s / Jubileum jutalom id�] AS [Szolg�lati elismer�s / Jubileum jutalom id�], [tBesorol�siEredm�nyadatok_import].[Kezdete23] AS Kezdete23, [tBesorol�siEredm�nyadatok_import].[V�ge24] AS V�ge24, [tBesorol�siEredm�nyadatok_import].[V�gkiel�g�t�sre jogos�t� id�] AS [V�gkiel�g�t�sre jogos�t� id�], [tBesorol�siEredm�nyadatok_import].[Kezdete25] AS Kezdete25, [tBesorol�siEredm�nyadatok_import].[V�ge26] AS V�ge26, [tBesorol�siEredm�nyadatok_import].[Szolg�lati jogviszonyban elt�lt�tt id�] AS [Szolg�lati jogviszonyban elt�lt�tt id�], [tBesorol�siEredm�nyadatok_import].[Kezdete27] AS Kezdete27, [tBesorol�siEredm�nyadatok_import].[V�ge28] AS V�ge28, [tBesorol�siEredm�nyadatok_import].[�ll�shelyi id�] AS [�ll�shelyi id�], [tBesorol�siEredm�nyadatok_import].[Kezdete29] AS Kezdete29, [tBesorol�siEredm�nyadatok_import].[V�ge30] AS V�ge30, [tBesorol�siEredm�nyadatok_import].[Saj�t munkahelyen elt�lt�tt id�] AS [Saj�t munkahelyen elt�lt�tt id�], [tBesorol�siEredm�nyadatok_import].[Kezdete31] AS Kezdete31, [tBesorol�siEredm�nyadatok_import].[V�ge32] AS V�ge32, [tBesorol�siEredm�nyadatok_import].[Szakmai gyakorlat kezd� d�tuma] AS [Szakmai gyakorlat kezd� d�tuma], [tBesorol�siEredm�nyadatok_import].[Kezdete33] AS Kezdete33, [tBesorol�siEredm�nyadatok_import].[V�ge34] AS V�ge34, [tBesorol�siEredm�nyadatok_import].[Alapilletm�ny] AS Alapilletm�ny, [tBesorol�siEredm�nyadatok_import].[Garant�lt b�rminimum] AS [Garant�lt b�rminimum], [tBesorol�siEredm�nyadatok_import].[Kerek�t�s] AS Kerek�t�s, [tBesorol�siEredm�nyadatok_import].[�sszesen] AS �sszesen
FROM tBesorol�siEredm�nyadatok_import;

-- [lkh�tt�rt�r_tBesorol�siEredm�nyadatok_t�rl�]
DELETE *
FROM tBesorol�siEredm�nyadatok IN 'L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\H�tt�rt�rak\Ellen�rz�s_0.9.6_h�tt�r_.mdb.accdb';

-- [lkh�tt�rt�r_tEl�z�Munkahelyek_t�rl�]
DELETE *
FROM tEl�z�Munkahelyek IN 'L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\H�tt�rt�rak\Ellen�rz�s_0.9.6_h�tt�r_.mdb.accdb';

-- [lkh�tt�rt�r_tSzem�lyek_�tt�lt�s]
INSERT INTO tSzem�lyek IN 'L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\H�tt�rt�rak\Ellen�rz�s_0.9.6_h�tt�r_.mdb.accdb'
SELECT [tSzem�lyek_import].[Ad�jel] AS Ad�jel, [tSzem�lyek_import].[Dolgoz� teljes neve] AS [Dolgoz� teljes neve], [tSzem�lyek_import].[Dolgoz� sz�let�si neve] AS [Dolgoz� sz�let�si neve], [tSzem�lyek_import].[Sz�let�si id�] AS [Sz�let�si id�], [tSzem�lyek_import].[Sz�let�si hely] AS [Sz�let�si hely], [tSzem�lyek_import].[Anyja neve] AS [Anyja neve], [tSzem�lyek_import].[Neme] AS Neme, [tSzem�lyek_import].[T�rzssz�m] AS T�rzssz�m, [tSzem�lyek_import].[Egyedi azonos�t�] AS [Egyedi azonos�t�], [tSzem�lyek_import].[Ad�azonos�t� jel] AS [Ad�azonos�t� jel], [tSzem�lyek_import].[TAJ sz�m] AS [TAJ sz�m], [tSzem�lyek_import].[�gyf�lkapu k�d] AS [�gyf�lkapu k�d], [tSzem�lyek_import].[Els�dleges �llampolg�rs�g] AS [Els�dleges �llampolg�rs�g], [tSzem�lyek_import].[Szem�lyi igazolv�ny sz�ma] AS [Szem�lyi igazolv�ny sz�ma], dt�tal([tSzem�lyek_import].[Szem�lyi igazolv�ny �rv�nyess�g kezdete]) AS [Szem�lyi igazolv�ny �rv�nyess�g kezdete], [tSzem�lyek_import].[Szem�lyi igazolv�ny �rv�nyess�g v�ge] AS [Szem�lyi igazolv�ny �rv�nyess�g v�ge], [tSzem�lyek_import].[Nyelvtud�s Angol] AS [Nyelvtud�s Angol], [tSzem�lyek_import].[Nyelvtud�s Arab] AS [Nyelvtud�s Arab], [tSzem�lyek_import].[Nyelvtud�s Bolg�r] AS [Nyelvtud�s Bolg�r], [tSzem�lyek_import].[Nyelvtud�s Cig�ny] AS [Nyelvtud�s Cig�ny], [tSzem�lyek_import].[Nyelvtud�s Cig�ny (lov�ri)] AS [Nyelvtud�s Cig�ny (lov�ri)], [tSzem�lyek_import].[Nyelvtud�s Cseh] AS [Nyelvtud�s Cseh], [tSzem�lyek_import].[Nyelvtud�s Eszperant�] AS [Nyelvtud�s Eszperant�], [tSzem�lyek_import].[Nyelvtud�s Finn] AS [Nyelvtud�s Finn], [tSzem�lyek_import].[Nyelvtud�s Francia] AS [Nyelvtud�s Francia], [tSzem�lyek_import].[Nyelvtud�s H�ber] AS [Nyelvtud�s H�ber], [tSzem�lyek_import].[Nyelvtud�s Holland] AS [Nyelvtud�s Holland], [tSzem�lyek_import].[Nyelvtud�s Horv�t] AS [Nyelvtud�s Horv�t], [tSzem�lyek_import].[Nyelvtud�s Jap�n] AS [Nyelvtud�s Jap�n], [tSzem�lyek_import].[Nyelvtud�s Jelnyelv] AS [Nyelvtud�s Jelnyelv], [tSzem�lyek_import].[Nyelvtud�s K�nai] AS [Nyelvtud�s K�nai], [tSzem�lyek_import].[Nyelvtud�s Koreai] AS [Nyelvtud�s Koreai], [tSzem�lyek_import].[Nyelvtud�s Latin] AS [Nyelvtud�s Latin], [tSzem�lyek_import].[Nyelvtud�s Lengyel] AS [Nyelvtud�s Lengyel], [tSzem�lyek_import].[Nyelvtud�s N�met] AS [Nyelvtud�s N�met], [tSzem�lyek_import].[Nyelvtud�s Norv�g] AS [Nyelvtud�s Norv�g], [tSzem�lyek_import].[Nyelvtud�s Olasz] AS [Nyelvtud�s Olasz], [tSzem�lyek_import].[Nyelvtud�s Orosz] AS [Nyelvtud�s Orosz], [tSzem�lyek_import].[Nyelvtud�s Portug�l] AS [Nyelvtud�s Portug�l], [tSzem�lyek_import].[Nyelvtud�s Rom�n] AS [Nyelvtud�s Rom�n], [tSzem�lyek_import].[Nyelvtud�s Spanyol] AS [Nyelvtud�s Spanyol], [tSzem�lyek_import].[Nyelvtud�s Szerb] AS [Nyelvtud�s Szerb], [tSzem�lyek_import].[Nyelvtud�s Szlov�k] AS [Nyelvtud�s Szlov�k], [tSzem�lyek_import].[Nyelvtud�s Szlov�n] AS [Nyelvtud�s Szlov�n], [tSzem�lyek_import].[Nyelvtud�s T�r�k] AS [Nyelvtud�s T�r�k], [tSzem�lyek_import].[Nyelvtud�s �jg�r�g] AS [Nyelvtud�s �jg�r�g], [tSzem�lyek_import].[Nyelvtud�s Ukr�n] AS [Nyelvtud�s Ukr�n], [tSzem�lyek_import].[Orvosi vizsg�lat id�pontja] AS [Orvosi vizsg�lat id�pontja], [tSzem�lyek_import].[Orvosi vizsg�lat t�pusa] AS [Orvosi vizsg�lat t�pusa], [tSzem�lyek_import].[Orvosi vizsg�lat eredm�nye] AS [Orvosi vizsg�lat eredm�nye], [tSzem�lyek_import].[Orvosi vizsg�lat �szrev�telek] AS [Orvosi vizsg�lat �szrev�telek], [tSzem�lyek_import].[Orvosi vizsg�lat k�vetkez� id�pontja] AS [Orvosi vizsg�lat k�vetkez� id�pontja], [tSzem�lyek_import].[Erk�lcsi bizony�tv�ny sz�ma] AS [Erk�lcsi bizony�tv�ny sz�ma], [tSzem�lyek_import].[Erk�lcsi bizony�tv�ny d�tuma] AS [Erk�lcsi bizony�tv�ny d�tuma], [tSzem�lyek_import].[Erk�lcsi bizony�tv�ny eredm�nye] AS [Erk�lcsi bizony�tv�ny eredm�nye], [tSzem�lyek_import].[Erk�lcsi bizony�tv�ny k�relem azonos�t�] AS [Erk�lcsi bizony�tv�ny k�relem azonos�t�], [tSzem�lyek_import].[Erk�lcsi bizony�tv�ny k�z�gyekt�l eltiltva] AS [Erk�lcsi bizony�tv�ny k�z�gyekt�l eltiltva], [tSzem�lyek_import].[Erk�lcsi bizony�tv�ny j�rm�vezet�st�l eltiltva] AS [Erk�lcsi bizony�tv�ny j�rm�vezet�st�l eltiltva], [tSzem�lyek_import].[Erk�lcsi bizony�tv�ny int�zked�s alatt �ll] AS [Erk�lcsi bizony�tv�ny int�zked�s alatt �ll], [tSzem�lyek_import].[Munkak�ri le�r�sok (csatolt dokumentumok f�jlnevei)] AS [Munkak�ri le�r�sok (csatolt dokumentumok f�jlnevei)], [tSzem�lyek_import].[Egy�b HR dokumentumok (csatolt dokumentumok f�jlnevei)] AS [Egy�b HR dokumentumok (csatolt dokumentumok f�jlnevei)], [tSzem�lyek_import].[Korm�nyhivatal r�vid neve] AS [Korm�nyhivatal r�vid neve], [tSzem�lyek_import].[Szervezeti egys�g k�dja] AS [Szervezeti egys�g k�dja], [tSzem�lyek_import].[Szervezeti egys�g neve] AS [Szervezeti egys�g neve], [tSzem�lyek_import].[Szervezeti munkak�r neve] AS [Szervezeti munkak�r neve], [tSzem�lyek_import].[Vezet�i megb�z�s t�pusa] AS [Vezet�i megb�z�s t�pusa], [tSzem�lyek_import].[St�tusz k�dja] AS [St�tusz k�dja], [tSzem�lyek_import].[St�tusz k�lts�ghely�nek k�dja] AS [St�tusz k�lts�ghely�nek k�dja], [tSzem�lyek_import].[St�tusz k�lts�ghely�nek neve ] AS [St�tusz k�lts�ghely�nek neve ], [tSzem�lyek_import].[L�tsz�mon fel�l l�trehozott st�tusz] AS [L�tsz�mon fel�l l�trehozott st�tusz], [tSzem�lyek_import].[St�tusz t�pusa] AS [St�tusz t�pusa], [tSzem�lyek_import].[St�tusz neve] AS [St�tusz neve], [tSzem�lyek_import].[T�bbes bet�lt�s] AS [T�bbes bet�lt�s], [tSzem�lyek_import].[Vezet� neve] AS [Vezet� neve], [tSzem�lyek_import].[Vezet� ad�azonos�t� jele] AS [Vezet� ad�azonos�t� jele], [tSzem�lyek_import].[Vezet� email c�me] AS [Vezet� email c�me], [tSzem�lyek_import].[�lland� lakc�m] AS [�lland� lakc�m], [tSzem�lyek_import].[Tart�zkod�si lakc�m] AS [Tart�zkod�si lakc�m], [tSzem�lyek_import].[Levelez�si c�m_] AS [Levelez�si c�m_], [tSzem�lyek_import].[�regs�gi nyugd�j-korhat�r el�r�s�nek id�pontja (d�tum)] AS [�regs�gi nyugd�j-korhat�r el�r�s�nek id�pontja (d�tum)], [tSzem�lyek_import].[Nyugd�jas] AS Nyugd�jas, [tSzem�lyek_import].[Nyugd�j t�pusa] AS [Nyugd�j t�pusa], [tSzem�lyek_import].[Nyugd�jas kor� tov�bbfoglalkoztat�si enged�llyel rendelkezik] AS [Nyugd�jas kor� tov�bbfoglalkoztat�si enged�llyel rendelkezik], [tSzem�lyek_import].[Megv�ltozott munkak�pess�g] AS [Megv�ltozott munkak�pess�g], [tSzem�lyek_import].[�nk�ntes tartal�kos katona] AS [�nk�ntes tartal�kos katona], [tSzem�lyek_import].[Utols� vagyonnyilatkozat lead�s�nak d�tuma] AS [Utols� vagyonnyilatkozat lead�s�nak d�tuma], [tSzem�lyek_import].[Vagyonnyilatkozat nyilv�ntart�si sz�ma] AS [Vagyonnyilatkozat nyilv�ntart�si sz�ma], [tSzem�lyek_import].[K�vetkez� vagyonnyilatkozat esed�kess�ge] AS [K�vetkez� vagyonnyilatkozat esed�kess�ge], [tSzem�lyek_import].[Nemzetbiztons�gi ellen�rz�s d�tuma] AS [Nemzetbiztons�gi ellen�rz�s d�tuma], [tSzem�lyek_import].[V�dett �llom�nyba tartoz� munkak�r] AS [V�dett �llom�nyba tartoz� munkak�r], [tSzem�lyek_import].[Vezet�i megb�z�s t�pusa1] AS [Vezet�i megb�z�s t�pusa1], [tSzem�lyek_import].[Vezet�i beoszt�s megnevez�se] AS [Vezet�i beoszt�s megnevez�se], [tSzem�lyek_import].[Vezet�i beoszt�s (megb�z�s) kezdete] AS [Vezet�i beoszt�s (megb�z�s) kezdete], [tSzem�lyek_import].[Vezet�i beoszt�s (megb�z�s) v�ge] AS [Vezet�i beoszt�s (megb�z�s) v�ge], [tSzem�lyek_import].[Iskolai v�gzetts�g foka] AS [Iskolai v�gzetts�g foka], [tSzem�lyek_import].[Iskolai v�gzetts�g neve] AS [Iskolai v�gzetts�g neve], dt�tal([tSzem�lyek_import].[Alapvizsga k�telez�s d�tuma]) AS [Alapvizsga k�telez�s d�tuma], [tSzem�lyek_import].[Alapvizsga let�tel t�nyleges hat�rideje] AS [Alapvizsga let�tel t�nyleges hat�rideje], [tSzem�lyek_import].[Alapvizsga mentess�g] AS [Alapvizsga mentess�g], [tSzem�lyek_import].[Alapvizsga mentess�g oka] AS [Alapvizsga mentess�g oka], [tSzem�lyek_import].[Szakvizsga k�telez�s d�tuma] AS [Szakvizsga k�telez�s d�tuma], [tSzem�lyek_import].[Szakvizsga let�tel t�nyleges hat�rideje] AS [Szakvizsga let�tel t�nyleges hat�rideje], [tSzem�lyek_import].[Szakvizsga mentess�g] AS [Szakvizsga mentess�g], [tSzem�lyek_import].[Foglalkoz�si viszony] AS [Foglalkoz�si viszony], [tSzem�lyek_import].[Foglalkoz�si viszony statisztikai besorol�sa] AS [Foglalkoz�si viszony statisztikai besorol�sa], [tSzem�lyek_import].[Dolgoz� szerz�d�ses/kinevez�ses munkak�re / kinevez�si okm�nyban] AS [Dolgoz� szerz�d�ses/kinevez�ses munkak�re / kinevez�si okm�nyban], [tSzem�lyek_import].[Beoszt�stervez�s helysz�nek] AS [Beoszt�stervez�s helysz�nek], [tSzem�lyek_import].[Beoszt�stervez�s tev�kenys�gek] AS [Beoszt�stervez�s tev�kenys�gek], [tSzem�lyek_import].[R�szleges t�vmunka szerz�d�s kezdete] AS [R�szleges t�vmunka szerz�d�s kezdete], [tSzem�lyek_import].[R�szleges t�vmunka szerz�d�s v�ge] AS [R�szleges t�vmunka szerz�d�s v�ge], [tSzem�lyek_import].[R�szleges t�vmunka szerz�d�s intervalluma] AS [R�szleges t�vmunka szerz�d�s intervalluma], [tSzem�lyek_import].[R�szleges t�vmunka szerz�d�s m�rt�ke] AS [R�szleges t�vmunka szerz�d�s m�rt�ke], [tSzem�lyek_import].[R�szleges t�vmunka szerz�d�s helysz�ne] AS [R�szleges t�vmunka szerz�d�s helysz�ne], [tSzem�lyek_import].[R�szleges t�vmunka szerz�d�s helysz�ne 2] AS [R�szleges t�vmunka szerz�d�s helysz�ne 2], [tSzem�lyek_import].[R�szleges t�vmunka szerz�d�s helysz�ne 3] AS [R�szleges t�vmunka szerz�d�s helysz�ne 3], [tSzem�lyek_import].[Egy�ni t�l�ra keret meg�llapod�s kezdete] AS [Egy�ni t�l�ra keret meg�llapod�s kezdete], [tSzem�lyek_import].[Egy�ni t�l�ra keret meg�llapod�s v�ge] AS [Egy�ni t�l�ra keret meg�llapod�s v�ge], [tSzem�lyek_import].[Egy�ni t�l�ra keret meg�llapod�s m�rt�ke] AS [Egy�ni t�l�ra keret meg�llapod�s m�rt�ke], [tSzem�lyek_import].[KIRA feladat azonos�t�ja - int�zm�ny prefix-szel ell�tva] AS [KIRA feladat azonos�t�ja - int�zm�ny prefix-szel ell�tva], [tSzem�lyek_import].[KIRA feladat azonos�t�ja] AS [KIRA feladat azonos�t�ja], [tSzem�lyek_import].[KIRA feladat megnevez�s] AS [KIRA feladat megnevez�s], [tSzem�lyek_import].[Osztott munkak�r] AS [Osztott munkak�r], [tSzem�lyek_import].[Funkci�csoport: k�d-megnevez�s] AS [Funkci�csoport: k�d-megnevez�s], [tSzem�lyek_import].[Funkci�: k�d-megnevez�s] AS [Funkci�: k�d-megnevez�s], [tSzem�lyek_import].[Dolgoz� k�lts�ghely�nek k�dja] AS [Dolgoz� k�lts�ghely�nek k�dja], [tSzem�lyek_import].[Dolgoz� k�lts�ghely�nek neve] AS [Dolgoz� k�lts�ghely�nek neve], [tSzem�lyek_import].[Feladatk�r] AS Feladatk�r, [tSzem�lyek_import].[Els�dleges feladatk�r] AS [Els�dleges feladatk�r], [tSzem�lyek_import].[Feladatok] AS Feladatok, [tSzem�lyek_import].[FEOR] AS FEOR, [tSzem�lyek_import].[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� napi �raker] AS [Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� napi �raker], [tSzem�lyek_import].[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker] AS [Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker], [tSzem�lyek_import].[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� havi �raker] AS [Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� havi �raker], [tSzem�lyek_import].[Szerz�d�s/Kinevez�s t�pusa] AS [Szerz�d�s/Kinevez�s t�pusa], [tSzem�lyek_import].[Iktat�sz�m] AS Iktat�sz�m, [tSzem�lyek_import].[Szerz�d�s/kinevez�s verzi�_�rv�nyess�g kezdete] AS [Szerz�d�s/kinevez�s verzi�_�rv�nyess�g kezdete], dt�tal([tSzem�lyek_import].[Szerz�d�s/kinevez�s verzi�_�rv�nyess�g v�ge]) AS [Szerz�d�s/kinevez�s verzi�_�rv�nyess�g v�ge], [tSzem�lyek_import].[Hat�rozott idej� _szerz�d�s/kinevez�s lej�r] AS [Hat�rozott idej� _szerz�d�s/kinevez�s lej�r], [tSzem�lyek_import].[Szerz�d�s dokumentum (csatolt dokumentumok f�jlnevei)] AS [Szerz�d�s dokumentum (csatolt dokumentumok f�jlnevei)], [tSzem�lyek_import].[Megjegyz�s (pl# hat�rozott szerz�d�s/kinevez�s oka)] AS [Megjegyz�s (pl# hat�rozott szerz�d�s/kinevez�s oka)], [tSzem�lyek_import].[Munkav�gz�s helye - megnevez�s] AS [Munkav�gz�s helye - megnevez�s], [tSzem�lyek_import].[Munkav�gz�s helye - c�m] AS [Munkav�gz�s helye - c�m], [tSzem�lyek_import].[Jogviszony t�pusa / jogviszony t�pus] AS [Jogviszony t�pusa / jogviszony t�pus], [tSzem�lyek_import].[Jogviszony sorsz�ma] AS [Jogviszony sorsz�ma], [tSzem�lyek_import].[KIRA jogviszony jelleg] AS [KIRA jogviszony jelleg], [tSzem�lyek_import].[K�lcs�nbe ad� c�g] AS [K�lcs�nbe ad� c�g], [tSzem�lyek_import].[Teljes�tm�ny�rt�kel�s - �rt�kel� szem�ly] AS [Teljes�tm�ny�rt�kel�s - �rt�kel� szem�ly], [tSzem�lyek_import].[Teljes�tm�ny�rt�kel�s - �rv�nyess�g kezdet] AS [Teljes�tm�ny�rt�kel�s - �rv�nyess�g kezdet], [tSzem�lyek_import].[Teljes�tm�ny�rt�kel�s - �rt�kelt id�szak kezdet] AS [Teljes�tm�ny�rt�kel�s - �rt�kelt id�szak kezdet], [tSzem�lyek_import].[Teljes�tm�ny�rt�kel�s - �rt�kelt id�szak v�ge] AS [Teljes�tm�ny�rt�kel�s - �rt�kelt id�szak v�ge], [tSzem�lyek_import].[Teljes�tm�ny�rt�kel�s d�tuma] AS [Teljes�tm�ny�rt�kel�s d�tuma], [tSzem�lyek_import].[Teljes�tm�ny�rt�kel�s - Be�ll�si sz�zal�k] AS [Teljes�tm�ny�rt�kel�s - Be�ll�si sz�zal�k], [tSzem�lyek_import].[Teljes�tm�ny�rt�kel�s - Pontsz�m] AS [Teljes�tm�ny�rt�kel�s - Pontsz�m], [tSzem�lyek_import].[Teljes�tm�ny�rt�kel�s - Megjegyz�s] AS [Teljes�tm�ny�rt�kel�s - Megjegyz�s], [tSzem�lyek_import].[Dolgoz�i jellemz�k] AS [Dolgoz�i jellemz�k], [tSzem�lyek_import].[Fizet�si oszt�ly (KA)/ Pedag�gusi fokozat (KA pedag�gus)/besorol] AS [Fizet�si oszt�ly (KA)/ Pedag�gusi fokozat (KA pedag�gus)/besorol], [tSzem�lyek_import].[Besorol�si  fokozat (KT)] AS [Besorol�si  fokozat (KT)], [tSzem�lyek_import].[Jogfolytonos id� kezdete] AS [Jogfolytonos id� kezdete], [tSzem�lyek_import].[Jogviszony kezdete (bel�p�s d�tuma)] AS [Jogviszony kezdete (bel�p�s d�tuma)], dt�tal([tSzem�lyek_import].[Jogviszony v�ge (kil�p�s d�tuma)]) AS [Jogviszony v�ge (kil�p�s d�tuma)], [tSzem�lyek_import].[Utols� munk�ban t�lt�tt nap] AS [Utols� munk�ban t�lt�tt nap], [tSzem�lyek_import].[Kezdem�nyez�s d�tuma] AS [Kezdem�nyez�s d�tuma], [tSzem�lyek_import].[Hat�lyoss� v�lik] AS [Hat�lyoss� v�lik], [tSzem�lyek_import].[HR kapcsolat megsz�n�s m�dja (Kil�p�s m�dja)] AS [HR kapcsolat megsz�n�s m�dja (Kil�p�s m�dja)], [tSzem�lyek_import].[HR kapcsolat megsz�nes indoka (Kil�p�s indoka)] AS [HR kapcsolat megsz�nes indoka (Kil�p�s indoka)], [tSzem�lyek_import].[Indokol�s] AS Indokol�s, [tSzem�lyek_import].[K�vetkez� munkahely] AS [K�vetkez� munkahely], [tSzem�lyek_import].[MT: Felmond�si id� kezdete KJT, KTTV: Felment�si id� kezdete] AS [MT: Felmond�si id� kezdete KJT, KTTV: Felment�si id� kezdete], [tSzem�lyek_import].[Felmond�si id� v�ge (MT) Felment�si id� v�ge (KJT, KTTV)] AS [Felmond�si id� v�ge (MT) Felment�si id� v�ge (KJT, KTTV)], [tSzem�lyek_import].[Munkav�gz�s al�li mentes�t�s kezdete (KJT, KTTV) Felment�si id� ] AS [Munkav�gz�s al�li mentes�t�s kezdete (KJT, KTTV) Felment�si id� ], [tSzem�lyek_import].[Munkav�gz�s al�li mentes�t�s v�ge (KJT, KTTV) Felment�si id� v�g] AS [Munkav�gz�s al�li mentes�t�s v�ge (KJT, KTTV) Felment�si id� v�g], [tSzem�lyek_import].[�tmeneti elt�r� foglalkoztat�s t�pusa] AS [�tmeneti elt�r� foglalkoztat�s t�pusa], [tSzem�lyek_import].[�tmeneti elt�r� foglalkoztat�s kezdete] AS [�tmeneti elt�r� foglalkoztat�s kezdete], [tSzem�lyek_import].[Tart�s t�voll�t t�pusa] AS [Tart�s t�voll�t t�pusa], [tSzem�lyek_import].[Tart�s t�voll�t kezdete] AS [Tart�s t�voll�t kezdete], [tSzem�lyek_import].[Tart�s t�voll�t v�ge] AS [Tart�s t�voll�t v�ge], [tSzem�lyek_import].[Tart�s t�voll�t tervezett v�ge] AS [Tart�s t�voll�t tervezett v�ge], [tSzem�lyek_import].[Helyettes�tett dolgoz� neve] AS [Helyettes�tett dolgoz� neve], [tSzem�lyek_import].[Szerz�d�s/Kinevez�s - pr�baid� v�ge] AS [Szerz�d�s/Kinevez�s - pr�baid� v�ge], [tSzem�lyek_import].[Utal�si c�m] AS [Utal�si c�m], [tSzem�lyek_import].[Alapilletm�ny / Munkab�r / Megb�z�si d�j (elt�r�t�s n�lk�li)] AS [Alapilletm�ny / Munkab�r / Megb�z�si d�j (elt�r�t�s n�lk�li)], [tSzem�lyek_import].[Garant�lt b�rminimumra t�rt�n� kieg�sz�t�s] AS [Garant�lt b�rminimumra t�rt�n� kieg�sz�t�s], [tSzem�lyek_import].[Kerek�t�s] AS Kerek�t�s, [tSzem�lyek_import].[Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S % (elt�r�t] AS [Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S % (elt�r�t], [tSzem�lyek_import].[Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S �sszeg (el] AS [Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S �sszeg (el], [tSzem�lyek_import].[Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY % (elt�r�t�s n�lk�li)] AS [Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY % (elt�r�t�s n�lk�li)], [tSzem�lyek_import].[Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY �sszeg (elt�r�t�s n�l] AS [Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY �sszeg (elt�r�t�s n�l], [tSzem�lyek_import].[Egy�b p�tl�k - �sszeg (elt�r�t�s n�lk�li)] AS [Egy�b p�tl�k - �sszeg (elt�r�t�s n�lk�li)], [tSzem�lyek_import].[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�t�s n�lk�li)] AS [Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�t�s n�lk�li)], [tSzem�lyek_import].[Kerek�tett 100 %-os illetm�ny (elt�r�t�s n�lk�li)] AS [Kerek�tett 100 %-os illetm�ny (elt�r�t�s n�lk�li)], [tSzem�lyek_import].[Elt�r�t�s %] AS [Elt�r�t�s %], [tSzem�lyek_import].[Alapilletm�ny / Munkab�r / Megb�z�si d�j (elt�r�tett)] AS [Alapilletm�ny / Munkab�r / Megb�z�si d�j (elt�r�tett)], [tSzem�lyek_import].[Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S % (elt�r�1] AS [Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S % (elt�r�1], [tSzem�lyek_import].[Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S �sszeg (e1] AS [Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S �sszeg (e1], [tSzem�lyek_import].[Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY % (elt�r�tett)] AS [Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY % (elt�r�tett)], [tSzem�lyek_import].[Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY �sszeg (elt�r�tett)] AS [Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY �sszeg (elt�r�tett)], [tSzem�lyek_import].[Egy�b p�tl�k - �sszeg (elt�r�tett)] AS [Egy�b p�tl�k - �sszeg (elt�r�tett)], [tSzem�lyek_import].[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)] AS [Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)], [tSzem�lyek_import].[Kerek�tett 100 %-os illetm�ny (elt�r�tett)] AS [Kerek�tett 100 %-os illetm�ny (elt�r�tett)], [tSzem�lyek_import].[Tov�bbi munkav�gz�s helye 1 Teljes munkaid� %-a] AS [Tov�bbi munkav�gz�s helye 1 Teljes munkaid� %-a], [tSzem�lyek_import].[Tov�bbi munkav�gz�s helye 2 Teljes munkaid� %-a] AS [Tov�bbi munkav�gz�s helye 2 Teljes munkaid� %-a], [tSzem�lyek_import].[KT: Kerek�tett 100 %-os illetm�ny (elt�r�tett) + Helyettes�t�si ] AS [KT: Kerek�tett 100 %-os illetm�ny (elt�r�tett) + Helyettes�t�si ], [tSzem�lyek_import].[Szint 1 szervezeti egys�g n�v] AS [Szint 1 szervezeti egys�g n�v], [tSzem�lyek_import].[Szint 1 szervezeti egys�g k�d] AS [Szint 1 szervezeti egys�g k�d], [tSzem�lyek_import].[Szint 2 szervezeti egys�g n�v] AS [Szint 2 szervezeti egys�g n�v], [tSzem�lyek_import].[Szint 2 szervezeti egys�g k�d] AS [Szint 2 szervezeti egys�g k�d], [tSzem�lyek_import].[Szint 3 szervezeti egys�g n�v] AS [Szint 3 szervezeti egys�g n�v], [tSzem�lyek_import].[Szint 3 szervezeti egys�g k�d] AS [Szint 3 szervezeti egys�g k�d], [tSzem�lyek_import].[Szint 4 szervezeti egys�g n�v] AS [Szint 4 szervezeti egys�g n�v], [tSzem�lyek_import].[Szint 4 szervezeti egys�g k�d] AS [Szint 4 szervezeti egys�g k�d], [tSzem�lyek_import].[Szint 5 szervezeti egys�g n�v] AS [Szint 5 szervezeti egys�g n�v], [tSzem�lyek_import].[Szint 5 szervezeti egys�g k�d] AS [Szint 5 szervezeti egys�g k�d], [tSzem�lyek_import].[Szint 6 szervezeti egys�g n�v] AS [Szint 6 szervezeti egys�g n�v], [tSzem�lyek_import].[Szint 6 szervezeti egys�g k�d] AS [Szint 6 szervezeti egys�g k�d], [tSzem�lyek_import].[Szint 7 szervezeti egys�g n�v] AS [Szint 7 szervezeti egys�g n�v], [tSzem�lyek_import].[Szint 7 szervezeti egys�g k�d] AS [Szint 7 szervezeti egys�g k�d], [tSzem�lyek_import].[Szint 8 szervezeti egys�g n�v] AS [Szint 8 szervezeti egys�g n�v], [tSzem�lyek_import].[Szint 8 szervezeti egys�g k�d] AS [Szint 8 szervezeti egys�g k�d], [tSzem�lyek_import].[AD egyedi azonos�t�] AS [AD egyedi azonos�t�], [tSzem�lyek_import].[Hivatali email] AS [Hivatali email], [tSzem�lyek_import].[Hivatali mobil] AS [Hivatali mobil], [tSzem�lyek_import].[Hivatali telefon] AS [Hivatali telefon], [tSzem�lyek_import].[Hivatali telefon mell�k] AS [Hivatali telefon mell�k], [tSzem�lyek_import].[Iroda] AS Iroda, [tSzem�lyek_import].[Otthoni e-mail] AS [Otthoni e-mail], [tSzem�lyek_import].[Otthoni mobil] AS [Otthoni mobil], [tSzem�lyek_import].[Otthoni telefon] AS [Otthoni telefon], [tSzem�lyek_import].[Tov�bbi otthoni mobil] AS [Tov�bbi otthoni mobil]
FROM tSzem�lyek_import;

-- [lkh�tt�rt�r_tSzem�lyek_t�rl�]
DELETE *
FROM tSzem�lyek IN 'L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\H�tt�rt�rak\Ellen�rz�s_0.9.6_h�tt�r_.mdb.accdb';

-- [lkHaviAdatszolg�ltat�sb�lHi�nyz�k]
SELECT lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[Ad�azonos�t� jel] AS Ad�azonos�t�, Year([Sz�let�si id�]) AS [Sz�let�si �v], IIf([lkszem�lyek].[Neme]="n�",2,1) AS Nem, lkSzem�lyek.F�oszt�ly AS [J�r�si Hivatal], lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Szervezeti egys�g k�dja], ffsplit([Feladatk�r],"-",2) AS [Ell�tott feladat], lkSzem�lyek.[Szerz�d�s/kinevez�s verzi�_�rv�nyess�g kezdete] AS Kinevez�s, "SZ" AS [Feladat jellege], IIf([Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]=40,"T","R") AS Forma, lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker] AS [Heti munka�r�k sz�ma], 1 AS [Bet�lt�s ar�nya], tBesorol�s_�talak�t�.[Az �ll�shely jel�l�se], lkSzem�lyek.Besorol�s2 AS [Besorol�si fokozat], lk�ll�shelyek.[�ll�shely azonos�t�], lkSzem�lyek.[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)], "" AS [Eu finansz�rozott], "" AS [Illetm�ny forr�sa], IIf(Len([Tart�s t�voll�t t�pusa])<1,"","TT") AS Kif1, lkSzem�lyek.[Tart�s t�voll�t t�pusa], IIf([Szerz�d�s/Kinevez�s t�pusa]="hat�rozatlan","HL","HT") AS Id�tartam, tLegmagasabbV�gzetts�g04.azFok AS [V�gzetts�g foka], "" AS Kif2, lkSzem�lyek.V�gzetts�gFok, IIf([lkszem�lyek].[Oszt�ly] Like "*ablak*",Mid(Left([munkav�gz�s helye - c�m],13),6,13) & " " & Mid([munkav�gz�s helye - c�m],2,2),"") AS KAB
FROM (tLegmagasabbV�gzetts�g04 RIGHT JOIN (lkSzem�lyek RIGHT JOIN (lkJ�r�siKorm�nyK�zpontos�tottUni� RIGHT JOIN lk�ll�shelyek ON lkJ�r�siKorm�nyK�zpontos�tottUni�.[�ll�shely azonos�t�] = lk�ll�shelyek.[�ll�shely azonos�t�]) ON lkSzem�lyek.[St�tusz k�dja] = lk�ll�shelyek.[�ll�shely azonos�t�]) ON tLegmagasabbV�gzetts�g04.[Dolgoz� azonos�t�] = lkSzem�lyek.[Ad�azonos�t� jel]) LEFT JOIN tBesorol�s_�talak�t� ON (lkSzem�lyek.[Besorol�si  fokozat (KT)] = tBesorol�s_�talak�t�.Besorol�si_fokozat) AND (lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus] = tBesorol�s_�talak�t�.[Jogviszony t�pusa])
WHERE (((lkJ�r�siKorm�nyK�zpontos�tottUni�.[�ll�shely azonos�t�]) Is Null) AND ((tBesorol�s_�talak�t�.�res)=False))
ORDER BY lkSzem�lyek.BFKH;

-- [lkHaviAdatszolg�ltat�sb�lHi�nyz�kNexonaz]
SELECT DISTINCT lkSzem�lyek�sNexonAz.azNexon
FROM lkSzem�lyek�sNexonAz INNER JOIN lkHaviAdatszolg�ltat�sb�lHi�nyz�k ON lkSzem�lyek�sNexonAz.[Ad�azonos�t� jel] = lkHaviAdatszolg�ltat�sb�lHi�nyz�k.Ad�azonos�t�
ORDER BY lkSzem�lyek�sNexonAz.azNexon;

-- [lkHavib�lHi�nyz��ll�shelyek]
SELECT lk�ll�shelyekHavib�l.[�ll�shely azonos�t�], lk�ll�shelyek.[�ll�shely azonos�t�], lk�ll�shelyek.[�ll�shely besorol�si kateg�ri�ja]
FROM lk�ll�shelyek LEFT JOIN lk�ll�shelyekHavib�l ON lk�ll�shelyek.[�ll�shely azonos�t�] = lk�ll�shelyekHavib�l.[�ll�shely azonos�t�]
WHERE (((lk�ll�shelyekHavib�l.[�ll�shely azonos�t�]) Is Null));

-- [lkHaviJelent�sHat�lya]
SELECT TOP 1 IIf((Select TOP 1 [sz�m] from [lkHat�lyUnionCount])>1,'Hib�s beolvas�s!',[hat�lya]) AS Hat�ly
FROM lkHat�lyUnion INNER JOIN tHaviJelent�sHat�lya ON lkHat�lyUnion.Hat�lyaID = tHaviJelent�sHat�lya.hat�lyaID;

-- [lkHaviJelent�sHat�lya_utols�k]
SELECT tHaviJelent�sHat�lya1.hat�lyaID, tHaviJelent�sHat�lya1.hat�lya, tHaviJelent�sHat�lya1.r�gz�t�s AS [Utols� r�gz�t�s], tHaviJelent�sHat�lya1.f�jln�v
FROM tHaviJelent�sHat�lya1 INNER JOIN lkHat�lyIDDistinct ON tHaviJelent�sHat�lya1.hat�lyaID = lkHat�lyIDDistinct.hat�lyaID
WHERE (((tHaviJelent�sHat�lya1.r�gz�t�s)=(SELECT Max(TMP.r�gz�t�s) FROM tHaviJelent�sHat�lya1 as TMP WHERE (((TMP.hat�lya)=[tHaviJelent�sHat�lya1].[hat�lya])))))
ORDER BY tHaviJelent�sHat�lya1.hat�lyaID;

-- [lkHaviJelent�sHat�lyaAFileMez�Alapj�n]
SELECT TOP 1 thavijelent�shat�lya.hat�lya
FROM thavijelent�shat�lya
WHERE (((thavijelent�shat�lya.f�jln�v)=[�rlapok]![�F�men�02]![File]))
ORDER BY thavijelent�shat�lya.r�gz�t�s DESC;

-- [lkHaviL�tsz�m]
SELECT lkHaviL�tsz�mUni�.BFKHK�d, lkHaviL�tsz�mUni�.F�oszt�ly, lkHaviL�tsz�mUni�.Oszt�ly, Sum(lkHaviL�tsz�mUni�.Bet�lt�tt) AS [Bet�lt�tt l�tsz�m], Sum(lkHaviL�tsz�mUni�.�res) AS [�res �ll�shely], Sum(lkHaviL�tsz�mUni�.TT) AS TT
FROM lkHaviL�tsz�mUni�
GROUP BY lkHaviL�tsz�mUni�.BFKHK�d, lkHaviL�tsz�mUni�.F�oszt�ly, lkHaviL�tsz�mUni�.Oszt�ly, lkHaviL�tsz�mUni�.Jelleg
ORDER BY bfkh([BFKHk�d]);

-- [lkHaviL�tsz�mF�oszt�ly]
SELECT lkHaviL�tsz�mUni�.Jelleg, lkHaviL�tsz�mUni�.F�oszt�ly, Sum(lkHaviL�tsz�mUni�.Bet�lt�tt) AS [Bet�lt�tt l�tsz�m], Sum(lkHaviL�tsz�mUni�.�res) AS [�res �ll�shely], Sum(lkHaviL�tsz�mUni�.TT) AS TT
FROM lkHaviL�tsz�mUni�
GROUP BY lkHaviL�tsz�mUni�.Jelleg, lkHaviL�tsz�mUni�.F�oszt�ly;

-- [lkHaviL�tsz�mJ�r�si]
SELECT J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] AS BFKHK�d, Replace([J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH") AS F�oszt�ly, J�r�si_�llom�ny.Mez�7 AS Oszt�ly, Sum(IIf([Mez�4]="�res �ll�s",0,[Mez�14])) AS Bet�lt�tt, Sum(IIf([Mez�4]="�res �ll�s",[Mez�14],0)) AS �res, J�r�si_�llom�ny.[Besorol�si fokozat k�d:], Sum(IIf([Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp] Is Null Or [Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp]="",0,[Mez�14])) AS TT
FROM J�r�si_�llom�ny
GROUP BY J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�], Replace([J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH"), J�r�si_�llom�ny.Mez�7, J�r�si_�llom�ny.[Besorol�si fokozat k�d:];

-- [lkHaviL�tsz�mKorm�nyhivatali]
SELECT Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�] AS BFKHK�d, Korm�nyhivatali_�llom�ny.Mez�6 AS F�oszt�ly, Korm�nyhivatali_�llom�ny.Mez�7 AS Oszt�ly, Sum(IIf([Mez�4]="�res �ll�s",0,[Mez�14])) AS Bet�lt�tt, Sum(IIf([Mez�4]="�res �ll�s",[Mez�14],0)) AS �res, Korm�nyhivatali_�llom�ny.[Besorol�si fokozat k�d:], Sum(IIf([Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp] Is Null Or [Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp]="",0,[Mez�14])) AS TT
FROM Korm�nyhivatali_�llom�ny
GROUP BY Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�], Korm�nyhivatali_�llom�ny.Mez�6, Korm�nyhivatali_�llom�ny.Mez�7, Korm�nyhivatali_�llom�ny.[Besorol�si fokozat k�d:];

-- [lkHaviL�tsz�mKorrekci�]
SELECT First(lkJ�r�siKorm�nyUni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�]) AS BFKH, lkJ�r�siKorm�nyUni�.[J�r�si Hivatal] AS F�oszt�ly, lkJ�r�siKorm�nyUni�.Oszt�ly, 0 AS [Bet�lt�tt l�tsz�m], 0 AS TTL�tsz�m, 0 AS Hat�rozottL�tsz�m, -([CountOfAd�azonos�t�]-1) AS Korr
FROM lkJ�r�siKorm�nyUni� RIGHT JOIN lkJ�r�siKorm�nyUni�Duplik�tumok ON lkJ�r�siKorm�nyUni�.Ad�azonos�t� = lkJ�r�siKorm�nyUni�Duplik�tumok.Ad�azonos�t�
GROUP BY lkJ�r�siKorm�nyUni�.[J�r�si Hivatal], lkJ�r�siKorm�nyUni�.Oszt�ly, 0, -([CountOfAd�azonos�t�]-1), lkJ�r�siKorm�nyUni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�], 0, 0, 0;

-- [lkHaviL�tsz�mK�zpontos�tott]
SELECT K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] AS BFKHK�d, IIf([Megyei szint VAGY J�r�si Hivatal]="megyei szint",[Mez�6],[Megyei szint VAGY J�r�si Hivatal]) AS F�oszt�ly, K�zpontos�tottak.Mez�7 AS Oszt�ly, Sum(IIf([Mez�4]="�res �ll�s",0,[Mez�13])) AS Bet�lt�tt, Sum(IIf([Mez�4]="�res �ll�s",[Mez�13],0)) AS �res, K�zpontos�tottak.[Besorol�si fokozat k�d:], Sum(IIf([Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp] Is Null Or [Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp]="",0,[Mez�13])) AS TT
FROM K�zpontos�tottak
GROUP BY K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�], IIf([Megyei szint VAGY J�r�si Hivatal]="megyei szint",[Mez�6],[Megyei szint VAGY J�r�si Hivatal]), K�zpontos�tottak.Mez�7, K�zpontos�tottak.[Besorol�si fokozat k�d:];

-- [lkHaviL�tsz�mUni�]
SELECT *, "A" as Jelleg
FROM  lkHaviL�tsz�mKorm�nyhivatali
UNION SELECT *, "A" as Jelleg
FROM lkHaviL�tsz�mJ�r�si
UNION SELECT *, "K" as Jelleg
FROM  lkHaviL�tsz�mK�zpontos�tott;

-- [lkHib�kInt�zked�sFajt�nk�ntiSz�ma]
SELECT IIf([Int�zked�sFajta] Is Null,"nem volt int�zked�s",[Int�zked�sFajta]) AS Fajta, Count(tR�giHib�k.[Els� mez�]) AS [CountOfEls� mez�]
FROM tInt�zked�sFajt�k RIGHT JOIN (tInt�zked�sek RIGHT JOIN (tR�giHib�k LEFT JOIN ktR�giHib�kInt�zked�sek ON tR�giHib�k.[Els� mez�] = ktR�giHib�kInt�zked�sek.HASH) ON tInt�zked�sek.azInt�zked�sek = ktR�giHib�kInt�zked�sek.azInt�zked�sek) ON tInt�zked�sFajt�k.azIntFajta = tInt�zked�sek.azIntFajta
WHERE ((((select max([utols� id�pont]) from tR�giHib�k ))=[Utols� Id�pont]))
GROUP BY IIf([Int�zked�sFajta] Is Null,"nem volt int�zked�s",[Int�zked�sFajta]);

-- [lkHib�sK�lts�ghely�St�tuszok]
SELECT lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[St�tusz k�dja], lkSzem�lyek.[Dolgoz� k�lts�ghely�nek neve], lkSzem�lyek.[St�tusz k�lts�ghely�nek neve ], tSzervezet_1.[St�tusz�nak k�lts�ghely megnevez�se], tSzervezet.[K�lts�ghely megnevez�s]
FROM (lkSzem�lyek LEFT JOIN tSzervezet ON lkSzem�lyek.[St�tusz k�dja] = tSzervezet.[Szervezetmenedzsment k�d]) LEFT JOIN tSzervezet AS tSzervezet_1 ON lkSzem�lyek.[Ad�azonos�t� jel] = tSzervezet_1.[Szervezetmenedzsment k�d]
WHERE (((lkSzem�lyek.[Dolgoz� k�lts�ghely�nek neve])<>[tszervezet_1].[St�tusz�nak k�lts�ghely megnevez�se]) AND (([Dolgoz� k�lts�ghely�nek neve] Or [tszervezet].[K�lts�ghely megnevez�s] Or [tszervezet_1].[St�tusz�nak k�lts�ghely megnevez�se])=-1)) OR (((lkSzem�lyek.[Dolgoz� k�lts�ghely�nek neve])<>[tszervezet].[K�lts�ghely megnevez�s]) AND (([Dolgoz� k�lts�ghely�nek neve] Or [tszervezet].[K�lts�ghely megnevez�s] Or [tszervezet_1].[St�tusz�nak k�lts�ghely megnevez�se])=-1)) OR (((tSzervezet_1.[St�tusz�nak k�lts�ghely megnevez�se])<>[tszervezet].[K�lts�ghely megnevez�s]) AND (([Dolgoz� k�lts�ghely�nek neve] Or [tszervezet].[K�lts�ghely megnevez�s] Or [tszervezet_1].[St�tusz�nak k�lts�ghely megnevez�se])=-1)) OR (((tSzervezet_1.[St�tusz�nak k�lts�ghely megnevez�se])<>[lkszem�lyek].[Dolgoz� k�lts�ghely�nek neve]) AND (([Dolgoz� k�lts�ghely�nek neve] Or [tszervezet].[K�lts�ghely megnevez�s] Or [tszervezet_1].[St�tusz�nak k�lts�ghely megnevez�se])=-1)) OR (((tSzervezet.[K�lts�ghely megnevez�s])<>[lkszem�lyek].[Dolgoz� k�lts�ghely�nek neve]) AND (([Dolgoz� k�lts�ghely�nek neve] Or [tszervezet].[K�lts�ghely megnevez�s] Or [tszervezet_1].[St�tusz�nak k�lts�ghely megnevez�se])=-1)) OR (((tSzervezet.[K�lts�ghely megnevez�s])<>[tszervezet_1].[St�tusz�nak k�lts�ghely megnevez�se]) AND (([Dolgoz� k�lts�ghely�nek neve] Or [tszervezet].[K�lts�ghely megnevez�s] Or [tszervezet_1].[St�tusz�nak k�lts�ghely megnevez�se])=-1));

-- [lkHibaVisszajelz�stK�ld�k�sVisszajelz�seik�sszSz�ma]
SELECT DISTINCT [Dolgoz� teljes neve] & " (" & [SenderEmailAddress] & ")" AS Felad�, Count(tBej�v�Visszajelz�sek.azVisszajelz�s) AS [Visszajelz�sek sz�ma]
FROM (lkSzem�lyek INNER JOIN tBej�v��zenetek ON lkSzem�lyek.[Hivatali email] = tBej�v��zenetek.SenderEmailAddress) INNER JOIN (tBej�v�Visszajelz�sek INNER JOIN tVisszajelz�sT�pusok ON tBej�v�Visszajelz�sek.Visszajelz�sK�d = tVisszajelz�sT�pusok.Visszajelz�sK�d) ON tBej�v��zenetek.az�zenet = tBej�v�Visszajelz�sek.az�zenet
WHERE (((tVisszajelz�sT�pusok.Visszajelz�sT�pusCsoport)=1) AND ((tBej�v��zenetek.DeliveredDate) Between Date() And Date()-30))
GROUP BY [Dolgoz� teljes neve] & " (" & [SenderEmailAddress] & ")"
ORDER BY Count(tBej�v�Visszajelz�sek.azVisszajelz�s) DESC;

-- [lkHibaVisszajelz�stK�ld�k�sVisszajelz�seikSz�ma]
SELECT DISTINCT lkAzElm�ltT�zNap.D�tum, [Dolgoz� teljes neve] & " (" & [SenderEmailAddress] & ")" AS Felad�, Count(tBej�v�Visszajelz�sek.azVisszajelz�s) AS [Visszajelz�sek sz�ma]
FROM lkAzElm�ltT�zNap, (lkSzem�lyek INNER JOIN tBej�v��zenetek ON lkSzem�lyek.[Hivatali email] = tBej�v��zenetek.SenderEmailAddress) INNER JOIN (tBej�v�Visszajelz�sek INNER JOIN tVisszajelz�sT�pusok ON tBej�v�Visszajelz�sek.Visszajelz�sK�d = tVisszajelz�sT�pusok.Visszajelz�sK�d) ON tBej�v��zenetek.az�zenet = tBej�v�Visszajelz�sek.az�zenet
WHERE (((tBej�v��zenetek.DeliveredDate)>=[D�tum] And (tBej�v��zenetek.DeliveredDate)<[D�tum]+1) AND ((tVisszajelz�sT�pusok.Visszajelz�sT�pusCsoport)=1))
GROUP BY lkAzElm�ltT�zNap.D�tum, [Dolgoz� teljes neve] & " (" & [SenderEmailAddress] & ")"
ORDER BY lkAzElm�ltT�zNap.D�tum DESC , Count(tBej�v�Visszajelz�sek.azVisszajelz�s) DESC;

-- [lkHozz�tartoz�k]
SELECT tHozz�tartoz�k.*, Nz([Dolgoz� ad�azonos�t� jele],0)*1 AS Ad�jel
FROM tHozz�tartoz�k;

-- [lkHRvezet�k]
SELECT 
FROM lkSzem�lyek;

-- [lkIlletm�nyek]
SELECT lkSzem�lyek.T�rzssz�m, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, �ll�shelyek.[�ll�shely besorol�si kateg�ri�ja], lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)] AS Illetm�ny, lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker] AS �rasz�m, [Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40 AS [40 �r�s illetm�ny], IIf(ffsplit([Feladatk�r],"-",2)="",[Feladatk�r],ffsplit([Feladatk�r],"-",2)) AS Feladat, IIf(Nz([Tart�s t�voll�t t�pusa],"")="","","Igen") AS TT
FROM �ll�shelyek INNER JOIN lkSzem�lyek ON �ll�shelyek.[�ll�shely azonos�t�] = lkSzem�lyek.[St�tusz k�dja]
WHERE (((IIf(Nz([Tart�s t�voll�t t�pusa],"")="","","Igen"))="" Or (IIf(Nz([Tart�s t�voll�t t�pusa],"")="","","Igen"))=IIf(Nz([A tart�s t�voll�v�ket is belevegy�k (Igen/Nem)],"Nem")="Igen","Igen","")) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [lkIlletm�nyekABottom30Illetm�nybenR�szes�l�k]
SELECT DISTINCT lkIlletm�nyek.T�rzssz�m, lkIlletm�nyek.F�oszt�ly, lkIlletm�nyek.Oszt�ly, lkIlletm�nyek.N�v, lkIlletm�nyek.[40 �r�s illetm�ny], lkIlletm�nyek.TT
FROM lkIlletm�nyek LEFT JOIN lkIlletm�nyekBottom30 ON lkIlletm�nyek.[40 �r�s illetm�ny] = lkIlletm�nyekBottom30.[40 �r�s illetm�ny]
WHERE (((lkIlletm�nyekBottom30.[40 �r�s illetm�ny]) Is Not Null));

-- [lkIlletm�nyekBottom30]
SELECT TOP 31 lkIlletm�nyek.[40 �r�s illetm�ny]
FROM lkIlletm�nyek
GROUP BY lkIlletm�nyek.[40 �r�s illetm�ny]
ORDER BY lkIlletm�nyek.[40 �r�s illetm�ny];

-- [lkIlletm�nyekHavi]
SELECT Illetm�ny, Ad�jel, SzervezetK�d
FROM (SELECT 'J�r�si_�llom�ny' as T�bla, [J�r�si_�llom�ny].[Mez�18] as [Illetm�ny], (Nz([Ad�azonos�t�],0)*1) As Ad�jel, [�NYR SZERVEZETI EGYS�G AZONOS�T�]  as SzervezetK�d
        FROM [J�r�si_�llom�ny] 
        WHERE ([J�r�si_�llom�ny].[Mez�4]<> '�res �ll�s' OR [J�r�si_�llom�ny].[Mez�4] is null )  
    UNION 
    SELECT 'Korm�nyhivatali_�llom�ny' as T�bla, [Korm�nyhivatali_�llom�ny].[Mez�18] as [Illetm�ny], (Nz([Ad�azonos�t�],0)*1) As Ad�jel, [�NYR SZERVEZETI EGYS�G AZONOS�T�] As SzervezetK�d 
        FROM [Korm�nyhivatali_�llom�ny] 
        WHERE ([Korm�nyhivatali_�llom�ny].[Mez�4]<> '�res �ll�s'  OR [Korm�nyhivatali_�llom�ny].[Mez�4] is null)  
    UNION 
    SELECT 'K�zpontos�tottak' as T�bla, [K�zpontos�tottak].[Mez�17] as [Illetm�ny], (Nz([Ad�azonos�t�],0)*1) As Ad�jel, [Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] As SzervezetK�d 
        FROM [K�zpontos�tottak] 
        WHERE ([K�zpontos�tottak].[Mez�4]<> '�res �ll�s' OR [K�zpontos�tottak].[Mez�4] is null  )  
)  AS Illetm�nyUni�;

-- [lkIlletm�nyek�sszevet�sP�nz�ggyel01]
SELECT DISTINCT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkIlletm�nyekP�.N�v, lkIlletm�nyekP�.[Ad�azonos�t� jel], lkIlletm�nyekP�.[�tsorol�s �sszesen] AS PGF, lkSzem�lyek.[Kerek�tett 100 %-os illetm�ny (elt�r�tett)] AS NEXON, lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker] AS [Heti �ra], [Nexon]/[Heti �ra]*40 AS [Nexon 40 �ra], kt_azNexon_Ad�jel.Nlink AS Link, lkSzem�lyek.[St�tusz t�pusa], lkIlletm�nyekP�.[Jogviszony, juttat�s t�pusa]
FROM (lkIlletm�nyekP� LEFT JOIN lkSzem�lyek ON lkIlletm�nyekP�.[Ad�azonos�t� jel] = lkSzem�lyek.Ad�jel) LEFT JOIN kt_azNexon_Ad�jel ON lkSzem�lyek.Ad�jel = kt_azNexon_Ad�jel.Ad�jel
WHERE (((lkSzem�lyek.[St�tusz t�pusa]) Is Not Null) AND ((lkIlletm�nyekP�.[Jogviszony, juttat�s t�pusa])=20 Or (lkIlletm�nyekP�.[Jogviszony, juttat�s t�pusa])=6 Or (lkIlletm�nyekP�.[Jogviszony, juttat�s t�pusa])=18));

-- [lkIlletm�nyek�sszevet�sP�nz�ggyel02]
SELECT DISTINCT lkIlletm�nyek�sszevet�sP�nz�ggyel01.F�oszt�ly, lkIlletm�nyek�sszevet�sP�nz�ggyel01.Oszt�ly, lkIlletm�nyek�sszevet�sP�nz�ggyel01.N�v, lkIlletm�nyek�sszevet�sP�nz�ggyel01.PGF, lkIlletm�nyek�sszevet�sP�nz�ggyel01.NEXON, lkIlletm�nyek�sszevet�sP�nz�ggyel01.[Heti �ra], lkIlletm�nyek�sszevet�sP�nz�ggyel01.[Nexon 40 �ra], lkIlletm�nyek�sszevet�sP�nz�ggyel01.Link AS NLink
FROM lkIlletm�nyek�sszevet�sP�nz�ggyel01
WHERE (((lkIlletm�nyek�sszevet�sP�nz�ggyel01.NEXON)<>[PGF]));

-- [lkIlletm�nyekP�]
SELECT tIlletm�nyek.*, dt�tal([Jv kezdete]) AS JogvKezdete, dt�tal([Jv v�ge]) AS JogvV�ge
FROM tIlletm�nyek
WHERE (((dt�tal([Jv kezdete]))<=#11/30/2023# Or (dt�tal([Jv kezdete])) Is Null) AND ((dt�tal([Jv v�ge]))>="#2023. 11. 30.#" Or (dt�tal([Jv v�ge])) Is Null));

-- [lkIlletm�nyekV�gzetts�gFokaSzerint]
SELECT lkSzem�lyek.F�oszt�ly, lkLegmagasabbV�gzetts�g05.FirstOfazFok, Avg([KT: Kerek�tett 100 %-os illetm�ny (elt�r�tett) + Helyettes�t�si ]/[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40) AS Illetm�ny, tV�gzFok.V�gzetts�gek
FROM tV�gzFok INNER JOIN ((lkSzem�lyek INNER JOIN lkLegmagasabbV�gzetts�g05 ON lkSzem�lyek.[Ad�azonos�t� jel] = lkLegmagasabbV�gzetts�g05.[Dolgoz� azonos�t�]) LEFT JOIN lkMindenVezet� ON lkSzem�lyek.[Ad�azonos�t� jel] = lkMindenVezet�.[Ad�azonos�t� jel]) ON tV�gzFok.azFok = lkLegmagasabbV�gzetts�g05.FirstOfazFok
WHERE (((lkSzem�lyek.F�oszt�ly) Like "Hum�n*") AND ((lkMindenVezet�.[Ad�azonos�t� jel]) Is Null) AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null) AND (("###### Ez a lek�rdez�s kommentje ######")<>False))
GROUP BY lkSzem�lyek.F�oszt�ly, lkLegmagasabbV�gzetts�g05.FirstOfazFok, tV�gzFok.V�gzetts�gek;

-- [lkIlletm�nyhez�tlag_vezet�kn�lk�l]
SELECT DISTINCT lkSzem�lyek.*
FROM lkSzem�lyek LEFT JOIN tBesorol�s_�talak�t� ON lkSzem�lyek.[Besorol�si  fokozat (KT)] = tBesorol�s_�talak�t�.Besorol�si_fokozat
WHERE (((tBesorol�s_�talak�t�.Vezet�)=No) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null));

-- [lkIlletm�nyLista]
SELECT [lkSzem�lyek].[Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[lkSzem�lyek].[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40 AS Illetm�ny
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null Or (lkSzem�lyek.[Tart�s t�voll�t t�pusa])="") AND ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])<>"Hivat�sos �llom�ny�")) OR (((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])="Hivat�sos �llom�ny�") AND ((lkSzem�lyek.[Besorol�si  fokozat (KT)])="F�oszt�lyvezet�"))
ORDER BY [lkSzem�lyek].[Kerek�tett 100 %-os illetm�ny (elt�r�tett)]/[lkSzem�lyek].[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]*40;

-- [lkIlletm�nyN�vel�shezAdatok01]
SELECT kt_azNexon_Ad�jel.azNexon AS Az, lkSzem�lyek.[Szervezeti egys�g k�dja], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, IIf(Nz([besorol�si  fokozat (KT)],"")="",[Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s],Nz([besorol�si  fokozat (KT)],"")) AS Besorol�s, lkSzem�lyek.[Kerek�tett 100 %-os illetm�ny (elt�r�tett)] AS [Jelenlegi illetm�ny], lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker] AS [Heti munkaid�], lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)] AS Kil�p�s, 1 AS F�
FROM (lkSzem�lyek LEFT JOIN kt_azNexon_Ad�jel ON lkSzem�lyek.Ad�jel=kt_azNexon_Ad�jel.Ad�jel) LEFT JOIN lkSzervezet�ll�shelyek ON lkSzem�lyek.[St�tusz k�dja]=lkSzervezet�ll�shelyek.�ll�shely
WHERE (((lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)])>#6/13/2023# Or (lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)]) Is Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [lkIlletm�nyN�vel�shezAdatok02]
SELECT lkF�oszt�lyok.[Szervezeti egys�g k�dja], lkIlletm�nyN�vel�shezAdatok01.F�oszt�ly, Sum(lkIlletm�nyN�vel�shezAdatok01.f�) AS [F�oszt�lyi l�tsz�m]
FROM lkF�oszt�lyok INNER JOIN lkIlletm�nyN�vel�shezAdatok01 ON lkF�oszt�lyok.F�oszt�ly=lkIlletm�nyN�vel�shezAdatok01.F�oszt�ly
GROUP BY lkF�oszt�lyok.[Szervezeti egys�g k�dja], lkIlletm�nyN�vel�shezAdatok01.F�oszt�ly;

-- [lkIlletm�nyN�vel�shezAdatok03]
SELECT lkIlletm�nyN�vel�shezAdatok01.Az, lkIlletm�nyN�vel�shezAdatok01.[Szervezeti egys�g k�dja], lkIlletm�nyN�vel�shezAdatok01.F�oszt�ly, lkIlletm�nyN�vel�shezAdatok01.Oszt�ly, lkIlletm�nyN�vel�shezAdatok01.N�v, lkIlletm�nyN�vel�shezAdatok01.Besorol�s, lkIlletm�nyN�vel�shezAdatok01.[Jelenlegi illetm�ny], lkIlletm�nyN�vel�shezAdatok01.[Heti munkaid�], lkIlletm�nyN�vel�shezAdatok01.Kil�p�s, lkIlletm�nyN�vel�shezAdatok02.[F�oszt�lyi l�tsz�m]
FROM lkIlletm�nyN�vel�shezAdatok02 RIGHT JOIN lkIlletm�nyN�vel�shezAdatok01 ON lkIlletm�nyN�vel�shezAdatok02.F�oszt�ly=lkIlletm�nyN�vel�shezAdatok01.F�oszt�ly
ORDER BY lkIlletm�nyN�vel�shezAdatok01.F�oszt�ly;

-- [lkIlletm�nyN�vel�shezAdatokP�nz�gynek01]
SELECT kt_azNexon_Ad�jel.azNexon AS Az, lkSzem�lyek.Ad�jel, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[St�tusz k�dja], IIf(Nz([besorol�si  fokozat (KT)],"")="",[Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s],Nz([besorol�si  fokozat (KT)],"")) AS Besorol�s, lkSzem�lyek.[St�tusz t�pusa], lkSzem�lyek.[Foglalkoz�si viszony statisztikai besorol�sa], lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker] AS [Heti munkaid�], lkSzem�lyek.[Szerz�d�s/Kinevez�s t�pusa], lkSzem�lyek.[KIRA jogviszony jelleg], lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)], lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)] AS Kil�p�s, lkSzem�lyek.[Kerek�tett 100 %-os illetm�ny (elt�r�tett)] AS [Jelenlegi illetm�ny], lkSzem�lyek.[Tart�s t�voll�t t�pusa], lkSzem�lyek.[Tart�s t�voll�t kezdete], lkSzem�lyek.[Tart�s t�voll�t v�ge], lkSzem�lyek.[Helyettes�tett dolgoz� neve], 1 AS F�, IIf([KIRA jogviszony jelleg]="Munkaviszony",True,False) AS Mt, IIf([KIRA jogviszony jelleg]="Munkaviszony",False,True) AS Kit, False AS �res
FROM (lkSzem�lyek LEFT JOIN kt_azNexon_Ad�jel ON lkSzem�lyek.Ad�jel=kt_azNexon_Ad�jel.Ad�jel) LEFT JOIN lkSzervezet�ll�shelyek ON lkSzem�lyek.[St�tusz k�dja]=lkSzervezet�ll�shelyek.�ll�shely
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [lkIlletm�nyN�vel�shezAdatokP�nz�gynek02]
SELECT DISTINCT lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.Ad�jel, lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.N�v, lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.F�oszt�ly, lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.Oszt�ly, lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.[St�tusz k�dja], lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.Besorol�s, lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.[St�tusz t�pusa], lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.[Foglalkoz�si viszony statisztikai besorol�sa], lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.[Heti munkaid�], lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.[Szerz�d�s/Kinevez�s t�pusa], lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.[KIRA jogviszony jelleg], lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.[Jogviszony kezdete (bel�p�s d�tuma)], lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.Kil�p�s, lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.[Tart�s t�voll�t t�pusa], lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.[Tart�s t�voll�t kezdete], lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.[Tart�s t�voll�t v�ge], lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.[Helyettes�tett dolgoz� neve], lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.[Jelenlegi illetm�ny], "" AS [Javasolt emel�s], "" AS [�j illetm�ny], tBesorol�s_�talak�t�.[als� hat�r], tBesorol�s_�talak�t�.[fels� hat�r], "" AS [als� ellen�rz�s], "" AS [fels� ellen�rz�s], "" AS kontroll, "" AS Megjegyz�s
FROM tBesorol�s_�talak�t� INNER JOIN lkIlletm�nyN�vel�shezAdatokP�nz�gynek01 ON (tBesorol�s_�talak�t�.Besorol�s = lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.Besorol�s) AND (tBesorol�s_�talak�t�.�res = lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.�res) AND (tBesorol�s_�talak�t�.Kit = lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.Kit) AND (tBesorol�s_�talak�t�.Mt = lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.Mt)
WHERE (((lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.[St�tusz t�pusa])="Szervezeti alapl�tsz�m") AND ((lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.Kil�p�s) Is Null Or (lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.Kil�p�s)>#6/13/2023#))
ORDER BY lkIlletm�nyN�vel�shezAdatokP�nz�gynek01.Ad�jel;

-- [lkIlletm�nyT�rt�net]
SELECT lkKorm�nyhivataliJ�r�siK�zpT�rt�net.Ad�jel, lkKorm�nyhivataliJ�r�siK�zpT�rt�net.[Heti munka�r�k sz�ma], lkKorm�nyhivataliJ�r�siK�zpT�rt�net.[Havi illetm�ny], lkKorm�nyhivataliJ�r�siK�zpT�rt�net.hat�lya, lkKorm�nyhivataliJ�r�siK�zpT�rt�net.[Besorol�si fokozat k�d:], lkKorm�nyhivataliJ�r�siK�zpT�rt�net.[Besorol�si fokozat megnevez�se:]
FROM lkKorm�nyhivataliJ�r�siK�zpT�rt�net;

-- [lkInd�t�pulthozOldalakFejezetek]
SELECT tLek�rdez�sOszt�lyok.azOszt�ly, tLek�rdez�sOszt�lyok.Oszt�ly, tLek�rdez�sOszt�lyok.TartalomIsmertet�, tLek�rdez�sT�pusok.LapN�v, tLek�rdez�sT�pusok.Megjegyz�s
FROM tLek�rdez�sOszt�lyok INNER JOIN tLek�rdez�sT�pusok ON tLek�rdez�sOszt�lyok.azOszt�ly = tLek�rdez�sT�pusok.Oszt�ly;

-- [lkInformatikaiSzakter�letiFejleszt�sNexius]
SELECT lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Hivatali email]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.BFKH;

-- [lkInt�zked�sek]
SELECT tInt�zked�sek.azInt�zked�sek, tInt�zked�sek.azIntFajta, tInt�zked�sek.Int�zked�sD�tuma, tInt�zked�sek.Hivatkoz�s, tInt�zked�sFajt�k.Int�zked�sFajta
FROM tInt�zked�sFajt�k INNER JOIN tInt�zked�sek ON tInt�zked�sFajt�k.azIntFajta = tInt�zked�sek.azIntFajta;

-- [lkJ�r�si_�llom�ny]
SELECT J�r�si_�llom�ny.Sorsz�m, J�r�si_�llom�ny.N�v, J�r�si_�llom�ny.Ad�azonos�t�, J�r�si_�llom�ny.Mez�4 AS [Sz�let�si �v \ �res �ll�s], J�r�si_�llom�ny.Mez�5 AS Neme, J�r�si_�llom�ny.[J�r�si Hivatal], J�r�si_�llom�ny.Mez�7 AS Oszt�ly, "" AS Projekt, J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�], J�r�si_�llom�ny.Mez�9 AS [Ell�tott feladat], J�r�si_�llom�ny.Mez�10 AS Kinevez�s, J�r�si_�llom�ny.[Feladat jellege: szakmai (SZ) / funkcion�lis (F) feladatell�t�s;], J�r�si_�llom�ny.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ], J�r�si_�llom�ny.[Heti munka�r�k sz�ma], J�r�si_�llom�ny.Mez�14 AS [Bet�lt�s ar�nya], J�r�si_�llom�ny.[Besorol�si fokozat k�d:], J�r�si_�llom�ny.[Besorol�si fokozat megnevez�se:], J�r�si_�llom�ny.[�ll�shely azonos�t�], J�r�si_�llom�ny.Mez�18 AS [Havi illetm�ny], J�r�si_�llom�ny.Mez�19 AS [Eu finansz�rozott], J�r�si_�llom�ny.Mez�20 AS [Illetm�ny forr�sa], J�r�si_�llom�ny.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h], J�r�si_�llom�ny.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], J�r�si_�llom�ny.[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)], J�r�si_�llom�ny.[Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is], J�r�si_�llom�ny.[�gyf�lszolg�lati munkat�rs (1) �gyf�lszolg�lati h�tt�r munkat�rs], J�r�si_�llom�ny.Mez�26 AS [K�pes�t�st ad� v�gzetts�g], J�r�si_�llom�ny.Mez�27 AS KAB, J�r�si_�llom�ny.[KAB 001-3** Branch ID]
FROM J�r�si_�llom�ny;

-- [lkJ�r�siKorm�nyK�zpontos�tottUni�]
SELECT L�tsz�mUni�.Sorsz�m, L�tsz�mUni�.N�v, L�tsz�mUni�.Ad�azonos�t�, L�tsz�mUni�.[Sz�let�si �v \ �res �ll�s], L�tsz�mUni�.Neme, L�tsz�mUni�.[J�r�si Hivatal], L�tsz�mUni�.Oszt�ly, L�tsz�mUni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�], L�tsz�mUni�.[Ell�tott feladat], L�tsz�mUni�.Kinevez�s, L�tsz�mUni�.[Feladat jellege: szakmai (SZ) / funkcion�lis (F) feladatell�t�s;], L�tsz�mUni�.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ], L�tsz�mUni�.[Heti munka�r�k sz�ma], L�tsz�mUni�.[Bet�lt�s ar�nya], L�tsz�mUni�.[Besorol�si fokozat k�d:], L�tsz�mUni�.[Besorol�si fokozat megnevez�se:], L�tsz�mUni�.[�ll�shely azonos�t�], L�tsz�mUni�.[Havi illetm�ny], L�tsz�mUni�.[Eu finansz�rozott], L�tsz�mUni�.[Illetm�ny forr�sa], L�tsz�mUni�.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h], L�tsz�mUni�.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], L�tsz�mUni�.[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)], L�tsz�mUni�.[Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is], L�tsz�mUni�.[�gyf�lszolg�lati munkat�rs (1) �gyf�lszolg�lati h�tt�r munkat�rs], L�tsz�mUni�.[K�pes�t�st ad� v�gzetts�g], L�tsz�mUni�.KAB, L�tsz�mUni�.[KAB 001-3** Branch ID], IIf([Ad�azonos�t�] Is Null Or [Ad�azonos�t�]="",0,[Ad�azonos�t�]*1) AS Ad�jel, L�tsz�mUni�.Jelleg, TextToMD5Hex([�ll�shely azonos�t�]) AS Hash, Replace([J�r�si Hivatal],"budapest f�v�ros korm�nyhivatala","BFKH") AS F�oszt�ly, BFKH(L�tsz�mUni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�]) AS BFKH
FROM (SELECT *, "A" as Jelleg
FROM lkJ�r�si_�llom�ny
UNION SELECT *, "A" as Jelleg
FROM lkKorm�nyhivatali_�llom�ny
UNION SELECT *, "K" as Jelleg
FROM lkK�zpontos�tottak
)  AS L�tsz�mUni�;

-- [lkJ�r�siKorm�nyK�zpontos�tottUni�F�osztK�d]
SELECT lkJ�r�siKorm�nyK�zpontos�tottUni�.*, bfkh(IIf([J�r�si Hivatal]=[Oszt�ly] Or [Oszt�ly] Is Null,[�NYR SZERVEZETI EGYS�G AZONOS�T�],strLev�g([�NYR SZERVEZETI EGYS�G AZONOS�T�],".") & ".")) AS F�oszt�lyk�d
FROM lkJ�r�siKorm�nyK�zpontos�tottUni�;

-- [lkJ�r�siKorm�nyUni�]
SELECT Alapl�tsz�mUni�.Sorsz�m, Alapl�tsz�mUni�.N�v, Alapl�tsz�mUni�.Ad�azonos�t�, Alapl�tsz�mUni�.[Sz�let�si �v \ �res �ll�s], Alapl�tsz�mUni�.Neme, Alapl�tsz�mUni�.[J�r�si Hivatal], Alapl�tsz�mUni�.Oszt�ly, Alapl�tsz�mUni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�], Alapl�tsz�mUni�.[Ell�tott feladat], Alapl�tsz�mUni�.Kinevez�s, Alapl�tsz�mUni�.[Feladat jellege: szakmai (SZ) / funkcion�lis (F) feladatell�t�s;], Alapl�tsz�mUni�.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ], Alapl�tsz�mUni�.[Heti munka�r�k sz�ma], Alapl�tsz�mUni�.[Bet�lt�s ar�nya], Alapl�tsz�mUni�.[Besorol�si fokozat k�d:], Alapl�tsz�mUni�.[Besorol�si fokozat megnevez�se:], Alapl�tsz�mUni�.[�ll�shely azonos�t�], Alapl�tsz�mUni�.[Havi illetm�ny], Alapl�tsz�mUni�.[Eu finansz�rozott], Alapl�tsz�mUni�.[Illetm�ny forr�sa], Alapl�tsz�mUni�.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h], Alapl�tsz�mUni�.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], Alapl�tsz�mUni�.[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)], Alapl�tsz�mUni�.[Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is], Alapl�tsz�mUni�.[�gyf�lszolg�lati munkat�rs (1) �gyf�lszolg�lati h�tt�r munkat�rs], Alapl�tsz�mUni�.[K�pes�t�st ad� v�gzetts�g], Alapl�tsz�mUni�.KAB, Alapl�tsz�mUni�.[KAB 001-3** Branch ID], *
FROM (SELECT *
FROM lkJ�r�si_�llom�ny
UNION SELECT *
FROM lkKorm�nyhivatali_�llom�ny
)  AS Alapl�tsz�mUni�;

-- [lkJ�r�siKorm�nyUni�Duplik�tumok]
SELECT lkJ�r�siKorm�nyUni�.Ad�azonos�t�, Count(lkJ�r�siKorm�nyUni�.Ad�azonos�t�) AS CountOfAd�azonos�t�
FROM lkJ�r�siKorm�nyUni�
WHERE (((lkJ�r�siKorm�nyUni�.Ad�azonos�t�)<>""))
GROUP BY lkJ�r�siKorm�nyUni�.Ad�azonos�t�
HAVING Count(lkJ�r�siKorm�nyUni�.Ad�azonos�t�)>1;

-- [lkJ�r�siVezet�HelyettesekIlletm�nye]
SELECT lkJ�r�siVezet�k.K�d, lkJ�r�siVezet�k.[Dolgoz� teljes neve], lkJ�r�siVezet�k.Hivatal, lkJ�r�siVezet�k.[Besorol�si  fokozat (KT)], lkJ�r�siVezet�k.[Kerek�tett 100 %-os illetm�ny (elt�r�tett)] AS Illetm�ny
FROM lkJ�r�siVezet�k
WHERE (((lkJ�r�siVezet�k.[Besorol�si  fokozat (KT)])="J�r�si / ker�leti hivatal vezet�j�nek helyettese"));

-- [lkJ�r�siVezet�k]
SELECT bfkh(Nz([Szervezeti egys�g k�dja],"")) AS K�d, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Ad�azonos�t� jel], lkSzem�lyek.F�oszt�ly AS Hivatal, lkSzem�lyek.[Sz�let�si hely], lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.[�lland� lakc�m], lkSzem�lyek.[Tart�zkod�si lakc�m], lkSzem�lyek.[Besorol�si  fokozat (KT)], lkSzem�lyek.[Vezet�i beoszt�s megnevez�se], lkSzem�lyek.[Kerek�tett 100 %-os illetm�ny (elt�r�tett)]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.F�oszt�ly) Like "BFKH*") AND ((lkSzem�lyek.[Besorol�si  fokozat (KT)]) Like "J�r�si*"))
ORDER BY bfkh(Nz([Szervezeti egys�g k�dja],""));

-- [lkJav_t�bl�k]
SELECT tJav_t�bl�k.k�d, tJav_t�bl�k.T�bla, tJav_t�bl�k.Ellen�rz�shez
FROM tJav_t�bl�k;

-- [lkJogviszonybanElt�lt�ttLedolgozottId�01]
SELECT Replace(Nz([lkSzem�lyUtols�SzervezetiEgys�ge].[F�oszt�ly],""),"Budapest F�v�ros Korm�nyhivatala","BFKH") AS F�oszt�ly_, lkSzem�lyUtols�SzervezetiEgys�ge.Oszt�ly, DateDiff("d",[bel�p�s],[kil�p�s]) AS [Eltelt id�], lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS Bel�p�s, IIf([Jogviszony v�ge (kil�p�s d�tuma)]=0,CDate(Now()),[Jogviszony v�ge (kil�p�s d�tuma)]) AS Kil�p�s, lkSzem�lyek.Ad�jel
FROM lkSzem�lyUtols�SzervezetiEgys�ge RIGHT JOIN lkSzem�lyek ON lkSzem�lyUtols�SzervezetiEgys�ge.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)]) Between #1/1/2024# And CDate(Now())) AND ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])<>"Szem�lyes jelenl�t" And (lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])<>"Megb�z�sos"));

-- [lkJogviszonybanElt�lt�ttLedolgozottId�02]
SELECT lkJogviszonybanElt�lt�ttLedolgozottId�01.F�oszt�ly_ AS F�oszt�ly, Avg(lkJogviszonybanElt�lt�ttLedolgozottId�01.[Eltelt id�]) AS [AvgOfEltelt id�], Count(lkJogviszonybanElt�lt�ttLedolgozottId�01.Ad�jel) AS L�tsz�m
FROM lkJogviszonybanElt�lt�ttLedolgozottId�01
GROUP BY lkJogviszonybanElt�lt�ttLedolgozottId�01.F�oszt�ly_
ORDER BY Avg(lkJogviszonybanElt�lt�ttLedolgozottId�01.[Eltelt id�]) DESC;

-- [lkJogviszonybanElt�lt�ttLedolgozottId�Statisztika]
SELECT lkJogviszonybanElt�lt�ttLedolgozottId�02.F�oszt�ly, lkJogviszonybanElt�lt�ttLedolgozottId�02.[AvgOfEltelt id�], lkJogviszonybanElt�lt�ttLedolgozottId�02.L�tsz�m AS [Bel�p�k sz�ma], lkHaviL�tsz�mF�oszt�ly.[Bet�lt�tt l�tsz�m] AS �sszl�tsz�m
FROM lkHaviL�tsz�mF�oszt�ly RIGHT JOIN lkJogviszonybanElt�lt�ttLedolgozottId�02 ON lkHaviL�tsz�mF�oszt�ly.F�oszt�ly = lkJogviszonybanElt�lt�ttLedolgozottId�02.F�oszt�ly
WHERE (((lkHaviL�tsz�mF�oszt�ly.Jelleg)="A" Or (lkHaviL�tsz�mF�oszt�ly.Jelleg) Is Null));

-- [lkJogviszonyok]
SELECT tIlletm�nyek.*, [Ad�azonos�t� jel]*1 AS Ad�jel
FROM tIlletm�nyek;

-- [lkJogviszonyok�sSzem�lyekSz�ma]
SELECT Egy.CountOfAzonos�t� AS [Jogviszonyok sz�ma], Count(Egy.Ad�jel) AS [�rintett szem�lyek sz�ma]
FROM (SELECT DISTINCT tSzem�lyek.Ad�jel, Count(tSzem�lyek.Azonos�t�) AS CountOfAzonos�t� FROM tSzem�lyek GROUP BY tSzem�lyek.Ad�jel)  AS Egy
GROUP BY Egy.CountOfAzonos�t�;

-- [lkjogviszonytartam]
SELECT DISTINCT [Ad�azonos�t�]*1 AS Ad�jel, lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS Bel�p�s, IIf([Jogviszony v�ge (kil�p�s d�tuma)]=0 Or [Jogviszony v�ge (kil�p�s d�tuma)]>Date(),Date(),[Jogviszony v�ge (kil�p�s d�tuma)]) AS Kil�p�s, [Kil�p�s]-[bel�p�s] AS Tartam
FROM lkSzem�lyek INNER JOIN tBel�p�k ON (tBel�p�k.[Jogviszony kezd� d�tuma] = lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)]) AND (lkSzem�lyek.[Ad�azonos�t� jel] = tBel�p�k.Ad�azonos�t�)
WHERE (((tBel�p�k.[Jogviszony kezd� d�tuma])>#12/31/2022#));

-- [lkjogviszonytartam02]
SELECT Year([Bel�p�s]) AS �v, lkSzem�lyUtols�SzervezetiEgys�ge.F�oszt�ly, Count(lkSzem�lyUtols�SzervezetiEgys�ge.Ad�jel) AS CountOfAd�jel
FROM lkjogviszonytartam INNER JOIN lkSzem�lyUtols�SzervezetiEgys�ge ON lkjogviszonytartam.Ad�jel = lkSzem�lyUtols�SzervezetiEgys�ge.Ad�jel
WHERE (((lkjogviszonytartam.Bel�p�s)>=#1/1/2023#) AND ((lkjogviszonytartam.Kil�p�s)<Date()) AND ((lkjogviszonytartam.Tartam)<185))
GROUP BY Year([Bel�p�s]), lkSzem�lyUtols�SzervezetiEgys�ge.F�oszt�ly;

-- [lkJ�v�idej�Esk�kR�gz�tve]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkLej�r�Hat�rid�k.[Figyelend� d�tum]
FROM lkSzem�lyek LEFT JOIN lkLej�r�Hat�rid�k ON lkSzem�lyek.[Ad�azonos�t� jel] = lkLej�r�Hat�rid�k.[Ad�azonos�t� jel]
WHERE (((lkLej�r�Hat�rid�k.[Figyelend� d�tum])>Now()));

-- [lkKABdolgoz�k]
SELECT Replace([J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH") AS Hivatal, lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly, lkJ�r�siKorm�nyK�zpontos�tottUni�.N�v, lkJ�r�siKorm�nyK�zpontos�tottUni�.[Ell�tott feladat]
FROM lkSzem�lyek RIGHT JOIN lkJ�r�siKorm�nyK�zpontos�tottUni� ON lkSzem�lyek.[Ad�azonos�t� jel] = lkJ�r�siKorm�nyK�zpontos�tottUni�.Ad�azonos�t�
WHERE (((lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "*Szem�ly*" Or (lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "Korm�nyabla*" Or (lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "*Okm�ny*") AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s"))
ORDER BY bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]);

-- [lkKABKorm�nyablakV�gzetts�g�ek]
SELECT lkV�gzetts�gek.Ad�jel, lkSzem�lyek.BFKH, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkV�gzetts�gek.[V�gzetts�g neve], lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS Bel�p�s, "" AS [Vizsga let�tel terv hat�rideje], "" AS [Vizsga let�tel t�ny hat�rideje], "" AS [K�telez�s d�tuma]
FROM lkSzem�lyek INNER JOIN lkV�gzetts�gek ON lkSzem�lyek.Ad�jel = lkV�gzetts�gek.Ad�jel
WHERE (((lkV�gzetts�gek.[V�gzetts�g neve])="korm�nyablak �gyint�z�i vizsga (NKE)") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkV�gzetts�gek.[V�gzetts�g neve])="korm�nyablak �gyint�z�"))
ORDER BY lkSzem�lyek.BFKH;

-- [lkKABKorm�nyablakVizsg�valRendelkez�k]
SELECT lkK�zigazgat�siVizsga.Ad�jel, lkSzem�lyek.BFKH, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkK�zigazgat�siVizsga.[Vizsga t�pusa], lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS Bel�p�s, lkK�zigazgat�siVizsga.[Vizsga let�tel terv hat�rideje], lkK�zigazgat�siVizsga.[Vizsga let�tel t�ny hat�rideje], lkK�zigazgat�siVizsga.[K�telez�s d�tuma]
FROM lkK�zigazgat�siVizsga INNER JOIN lkSzem�lyek ON lkK�zigazgat�siVizsga.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkK�zigazgat�siVizsga.[Vizsga t�pusa])="KAB Korm�nyablak �gyint�z�i vizsg.") AND 


((([lkK�zigazgat�siVizsga].[Vizsga eredm�nye] Is Null Or [lkK�zigazgat�siVizsga].[Vizsga eredm�nye]="") 
And ([lkK�zigazgat�siVizsga].[Oklev�l sz�ma] Is Null Or [lkK�zigazgat�siVizsga].[Oklev�l sz�ma]="") 
And ([lkK�zigazgat�siVizsga].[Oklev�l d�tuma] Is Null Or [lkK�zigazgat�siVizsga].[Oklev�l d�tuma]=0))=False) 



AND (("####### Az Eredm�ny, az Oklev�l sz�ma vagy az oklev�l d�tuma k�z�l legal�bb az egyik ki van t�ltve. ############")=True))
ORDER BY lkSzem�lyek.BFKH;

-- [lkKAB�gyint�z�k]
SELECT [lkJ�r�siKorm�nyK�zpontos�tottUni�].[Ad�azonos�t�]*1 AS Ad�jel, bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]) AS BFKH, Replace([J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH") AS Hivatal, lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly, lkJ�r�siKorm�nyK�zpontos�tottUni�.N�v, lkJ�r�siKorm�nyK�zpontos�tottUni�.[Ell�tott feladat], lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS Bel�p�s, lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge] AS [Pr�baid� v�ge], IIf([Tart�s t�voll�t t�pusa] Is Not Null,"Igen","Nem") AS T�voll�v�
FROM lkSzem�lyek RIGHT JOIN lkJ�r�siKorm�nyK�zpontos�tottUni� ON lkSzem�lyek.[Ad�azonos�t� jel] = lkJ�r�siKorm�nyK�zpontos�tottUni�.Ad�azonos�t�
WHERE (((lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "*Szem�ly*" Or (lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "Korm�nyabla*" Or (lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "*Okm�ny*") AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Ell�tott feladat])="�gyf�lszolg�lati �s korm�nyablak feladatok") AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s")) OR (((lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "*Szem�ly*" Or (lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "Korm�nyabla*" Or (lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "*Okm�ny*") AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Ell�tott feladat])="Okm�nyirodai feladatok") AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s")) OR (((lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "*Szem�ly*" Or (lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "Korm�nyabla*" Or (lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "*Okm�ny*") AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Ell�tott feladat])="�gyf�lszolg�lati feladatok") AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s"))
ORDER BY bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]);

-- [lkKAB�gyint�z�kIlletm�nye_eseti]
SELECT tBFKH([J�r�si Hivatal]) AS Hivatal, lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly, [N�v] & IIf([Besorol�si fokozat k�d:]="Ov."," (ov.)","") AS Neve, lkJ�r�siKorm�nyK�zpontos�tottUni�.[Havi illetm�ny], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Heti munka�r�k sz�ma], tBesorol�s_�talak�t�.[als� hat�r], tBesorol�s_�talak�t�.[fels� hat�r]
FROM (lkSzem�lyek RIGHT JOIN lkJ�r�siKorm�nyK�zpontos�tottUni� ON lkSzem�lyek.[Ad�azonos�t� jel] = lkJ�r�siKorm�nyK�zpontos�tottUni�.Ad�azonos�t�) INNER JOIN tBesorol�s_�talak�t� ON lkJ�r�siKorm�nyK�zpontos�tottUni�.[Besorol�si fokozat k�d:] = tBesorol�s_�talak�t�.[Az �ll�shely jel�l�se]
WHERE (((lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "Korm�nyabla*") AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s")) OR (((lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "Korm�nyabla*") AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s")) OR (((lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "Korm�nyabla*") AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s"))
ORDER BY bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]), IIf([Besorol�si fokozat k�d:]="Ov.",0,1), [N�v] & IIf([Besorol�si fokozat k�d:]="Ov."," (ov.)","");

-- [lkKAB�gyint�z�kKorm�nyirodaiLek�rdez�se]
SELECT "Budapest F�v�ros Korm�nyhivatala" AS Korm�nyhivatal, Replace([J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH") AS Hivatal, lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly, lkSzervezetiEgys�gekLegnagyobbL�tsz�m�Telephelyei.C�m, lkJ�r�siKorm�nyK�zpontos�tottUni�.[�ll�shely azonos�t�], lkJ�r�siKorm�nyK�zpontos�tottUni�.Neme, lkJ�r�siKorm�nyK�zpontos�tottUni�.[Besorol�si fokozat megnevez�se:], IIf([Szerz�d�s/Kinevez�s - pr�baid� v�ge]>=Date(),"x","") AS [Pr�baidej�t t�lti], "" AS Korm�nyablakban, lkJ�r�siKorm�nyK�zpontos�tottUni�.Kinevez�s
FROM lkSzervezetiEgys�gekLegnagyobbL�tsz�m�Telephelyei RIGHT JOIN (lkSzem�lyek RIGHT JOIN lkJ�r�siKorm�nyK�zpontos�tottUni� ON lkSzem�lyek.[Ad�azonos�t� jel] = lkJ�r�siKorm�nyK�zpontos�tottUni�.Ad�azonos�t�) ON lkSzervezetiEgys�gekLegnagyobbL�tsz�m�Telephelyei.BFKH = lkSzem�lyek.BFKH
WHERE (((lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "*Szem�ly*" Or (lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "Korm�nyabla*" Or (lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "*Okm�ny*") AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Besorol�si fokozat megnevez�se:]) Not Like "M*") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null) AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Ell�tott feladat])="�gyf�lszolg�lati �s korm�nyablak feladatok") AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s")) OR (((lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "*Szem�ly*" Or (lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "Korm�nyabla*" Or (lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "*Okm�ny*") AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Besorol�si fokozat megnevez�se:]) Not Like "M*") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null) AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Ell�tott feladat])="Okm�nyirodai feladatok") AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s")) OR (((lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "*Szem�ly*" Or (lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "Korm�nyabla*" Or (lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "*Okm�ny*") AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Besorol�si fokozat megnevez�se:]) Not Like "M*") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null) AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Ell�tott feladat])="�gyf�lszolg�lati feladatok") AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s"))
ORDER BY bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]);

-- [lkKABVizsga�sV�gzetts�g]
SELECT DISTINCT KABVizga�sKABV�gzetts�gUni�.Ad�jel, KABVizga�sKABV�gzetts�gUni�.BFKH, KABVizga�sKABV�gzetts�gUni�.F�oszt�ly, KABVizga�sKABV�gzetts�gUni�.Oszt�ly, KABVizga�sKABV�gzetts�gUni�.N�v, KABVizga�sKABV�gzetts�gUni�.Bel�p�s, KABVizga�sKABV�gzetts�gUni�.[Vizsga let�tel terv hat�rideje], KABVizga�sKABV�gzetts�gUni�.[Vizsga let�tel t�ny hat�rideje], KABVizga�sKABV�gzetts�gUni�.[K�telez�s d�tuma]
FROM (SELECT Ad�jel, lkKABKorm�nyablakV�gzetts�g�ek.BFKH, lkKABKorm�nyablakV�gzetts�g�ek.F�oszt�ly, lkKABKorm�nyablakV�gzetts�g�ek.Oszt�ly, lkKABKorm�nyablakV�gzetts�g�ek.N�v, lkKABKorm�nyablakV�gzetts�g�ek.Bel�p�s,   [Vizsga let�tel terv hat�rideje],  [Vizsga let�tel t�ny hat�rideje],  [K�telez�s d�tuma]
FROM lkKABKorm�nyablakV�gzetts�g�ek
UNION
SELECT Ad�jel, lkKABKorm�nyablakVizsg�valRendelkez�k.BFKH, lkKABKorm�nyablakVizsg�valRendelkez�k.F�oszt�ly, lkKABKorm�nyablakVizsg�valRendelkez�k.Oszt�ly, lkKABKorm�nyablakVizsg�valRendelkez�k.N�v, lkKABKorm�nyablakVizsg�valRendelkez�k.Bel�p�s,   [Vizsga let�tel terv hat�rideje],  [Vizsga let�tel t�ny hat�rideje],  [K�telez�s d�tuma]
FROM  lkKABKorm�nyablakVizsg�valRendelkez�k)  AS KABVizga�sKABV�gzetts�gUni�;

-- [lkKABVizsgaHi�ny]
SELECT DISTINCT lkKABVizsgaHi�ny00.F�oszt�ly, lkKABVizsgaHi�ny00.Oszt�ly, lkKABVizsgaHi�ny00.[Dolgoz� teljes neve], lkKABVizsgaHi�ny00.Bel�p�s, lkKABVizsgaHi�ny00.NLink
FROM lkKABVizsgaHi�ny00;

-- [lkKABVizsgaHi�ny00]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS Bel�p�s, kt_azNexon_Ad�jel02.NLink
FROM kt_azNexon_Ad�jel02 RIGHT JOIN (lkK�zigazgat�siVizsga RIGHT JOIN lkSzem�lyek ON lkK�zigazgat�siVizsga.Ad�jel = lkSzem�lyek.Ad�jel) ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.Oszt�ly) Like "Korm�nyablak Oszt�ly*") AND ((lkK�zigazgat�siVizsga.[Vizsga t�pusa])="KAB Korm�nyablak �gyint�z�i vizsg." Or (lkK�zigazgat�siVizsga.[Vizsga t�pusa]) Is Null) AND ((lkK�zigazgat�siVizsga.Mentess�g)=False Or (lkK�zigazgat�siVizsga.Mentess�g) Is Null) AND ((lkK�zigazgat�siVizsga.[Oklev�l sz�ma]) Is Null Or (lkK�zigazgat�siVizsga.[Oklev�l sz�ma])="") AND ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]) Like "ko*"))
ORDER BY lkSzem�lyek.BFKH;

-- [lkKABvizsg�valNemRendelkez�KAB�gyint�z�k]
SELECT lkKAB�gyint�z�k.Hivatal, lkKAB�gyint�z�k.Oszt�ly, lkKAB�gyint�z�k.N�v, lkKAB�gyint�z�k.[Ell�tott feladat], lkKAB�gyint�z�k.[Pr�baid� v�ge], (SELECT DISTINCT TOP 1
 Tmp1.[Vizsga let�tel terv hat�rideje]
    FROM lkK�zigazgat�siVizsga as Tmp1
    WHERE Tmp1.[Vizsga t�pusa]="KAB Korm�nyablak �gyint�z�i vizsg."
        AND
               Tmp1.Ad�jel = lkKAB�gyint�z�k.Ad�jel
    ORDER BY  Tmp1.[Vizsga let�tel terv hat�rideje] Desc
) AS VizsgaTervHat�rideje, (SELECT DISTINCT TOP 1
  Tmp1.[Vizsga let�tel t�ny hat�rideje]
    FROM lkK�zigazgat�siVizsga as Tmp1
    WHERE Tmp1.[Vizsga t�pusa]="KAB Korm�nyablak �gyint�z�i vizsg."
        AND
               Tmp1.Ad�jel = lkKAB�gyint�z�k.Ad�jel
    ORDER BY Tmp1.[Vizsga let�tel t�ny hat�rideje] DESC
) AS VizsgaT�nyHat�rideje, (SELECT DISTINCT TOP 1
  Tmp1.[K�telez�s d�tuma]
    FROM lkK�zigazgat�siVizsga as Tmp1
    WHERE Tmp1.[Vizsga t�pusa]="KAB Korm�nyablak �gyint�z�i vizsg."
        AND
               Tmp1.Ad�jel = lkKAB�gyint�z�k.Ad�jel
    ORDER BY   Tmp1.[K�telez�s d�tuma] DESC
) AS K�telez�sD�tuma
FROM lkKAB�gyint�z�k LEFT JOIN lkKABVizsga�sV�gzetts�g ON lkKAB�gyint�z�k.Ad�jel = lkKABVizsga�sV�gzetts�g.Ad�jel
WHERE (((lkKAB�gyint�z�k.T�voll�v�)="Nem") AND ((lkKABVizsga�sV�gzetts�g.Ad�jel) Is Null))
ORDER BY lkKAB�gyint�z�k.BFKH;

-- [lkKABvizsg�valNemRendelkez�KAB�gyint�z�kSz�ma]
SELECT 1 as sor, Count(lkKABvizsg�valNemRendelkez�KAB�gyint�z�k.Ad�jel) AS L�tsz�m, Sum(IIf([T�voll�v�]="IGEN",1,0)) AS [Tart�s t�voll�v�], L�tsz�m -[Tart�s t�voll�v�] as �sszesen
FROM lkKABvizsg�valNemRendelkez�KAB�gyint�z�k
UNION
SELECT 2 as sor, Count(lkKABvizsg�valNemRendelkez�KAB�gyint�z�k.Ad�jel) AS L�tsz�m, Sum(IIf([T�voll�v�]="IGEN",1,0)) AS [Tart�s t�voll�v�], L�tsz�m -[Tart�s t�voll�v�]
FROM lkKABvizsg�valNemRendelkez�KAB�gyint�z�k
WHERE (((lkKABvizsg�valNemRendelkez�KAB�gyint�z�k.[Pr�baid� v�ge])<=#7/1/2024#))
UNION SELECT 3 as sor, Count(lkKABvizsg�valNemRendelkez�KAB�gyint�z�k.Ad�jel) AS L�tsz�m, Sum(IIf([T�voll�v�]="IGEN",1,0)) AS [Tart�s t�voll�v�], L�tsz�m -[Tart�s t�voll�v�]
FROM lkKABvizsg�valNemRendelkez�KAB�gyint�z�k
WHERE (((lkKABvizsg�valNemRendelkez�KAB�gyint�z�k.Bel�p�s)>=#1/1/2022#) AND ((lkKABvizsg�valNemRendelkez�KAB�gyint�z�k.[Pr�baid� v�ge])<=#7/1/2024#));

-- [lkKabvizsg�valNemRendelkez�kList�ja]
SELECT lkKABvizsg�valNemRendelkez�KAB�gyint�z�k.Hivatal, lkKABvizsg�valNemRendelkez�KAB�gyint�z�k.Oszt�ly, kt_azNexon_Ad�jel02.NLink, lkKABvizsg�valNemRendelkez�KAB�gyint�z�k.[Ell�tott feladat], IIf([lkKABvizsg�valNemRendelkez�KAB�gyint�z�k]![Pr�baid� v�ge] Is Not Null,"Pr�baid� v�ge:" & [lkKABvizsg�valNemRendelkez�KAB�gyint�z�k]![Pr�baid� v�ge] & "," & Chr(13) & Chr(10),"") & IIf([lkKABvizsg�valNemRendelkez�KAB�gyint�z�k]![T�voll�v�] Is Not Null,"T�voll�v�:" & [lkKABvizsg�valNemRendelkez�KAB�gyint�z�k]![T�voll�v�] & "," & Chr(13) & Chr(10),"") & IIf([lkKABvizsg�valNemRendelkez�KAB�gyint�z�k]![VizsgaTervHat�rideje] Is Not Null,"A vizsga tervezett hat�rideje:" & [lkKABvizsg�valNemRendelkez�KAB�gyint�z�k]![VizsgaTervHat�rideje] & "," & Chr(13) & Chr(10),"") & IIf([lkKABvizsg�valNemRendelkez�KAB�gyint�z�k]![VizsgaT�nyHat�rideje] Is Not Null,"A vizsga t�nylegs hat�rideje:" & [lkKABvizsg�valNemRendelkez�KAB�gyint�z�k]![VizsgaT�nyHat�rideje] & "," & Chr(13) & Chr(10),"") & IIf([lkKABvizsg�valNemRendelkez�KAB�gyint�z�k]![K�telez�sD�tuma] Is Not Null,"A k�telez�s d�tuma:" & [lkKABvizsg�valNemRendelkez�KAB�gyint�z�k]![K�telez�sD�tuma],"") AS Megj
FROM kt_azNexon_Ad�jel02 RIGHT JOIN lkKABvizsg�valNemRendelkez�KAB�gyint�z�k ON kt_azNexon_Ad�jel02.Ad�jel = lkKABvizsg�valNemRendelkez�KAB�gyint�z�k.Ad�jel
ORDER BY lkKABvizsg�valNemRendelkez�KAB�gyint�z�k.BFKH;

-- [lkKABvizsg�valRendelkez�KAB�gyint�z�k]
SELECT lkKAB�gyint�z�k.BFKH, "Budapest F�v�ros Korm�nyhivatala" AS Korm�nyhivatal, lkKAB�gyint�z�k.Hivatal, lkKAB�gyint�z�k.Oszt�ly, lkKAB�gyint�z�k.Ad�jel, lkKAB�gyint�z�k.N�v, lkKAB�gyint�z�k.[Ell�tott feladat], lkKAB�gyint�z�k.Bel�p�s, lkKAB�gyint�z�k.[Pr�baid� v�ge], lkKAB�gyint�z�k.T�voll�v�, (SELECT DISTINCT TOP 1
 Tmp1.[Vizsga let�tel terv hat�rideje]
    FROM lkK�zigazgat�siVizsga as Tmp1
    WHERE Tmp1.[Vizsga t�pusa]="KAB Korm�nyablak �gyint�z�i vizsg."
        AND
               Tmp1.Ad�jel = lkKAB�gyint�z�k.Ad�jel
    ORDER BY  Tmp1.[Vizsga let�tel terv hat�rideje] Desc
) AS VizsgaTervHat�rideje, (SELECT DISTINCT TOP 1
  Tmp1.[Vizsga let�tel t�ny hat�rideje]
    FROM lkK�zigazgat�siVizsga as Tmp1
    WHERE Tmp1.[Vizsga t�pusa]="KAB Korm�nyablak �gyint�z�i vizsg."
        AND
               Tmp1.Ad�jel = lkKAB�gyint�z�k.Ad�jel
    ORDER BY Tmp1.[Vizsga let�tel t�ny hat�rideje] DESC
) AS VizsgaT�nyHat�rideje, (SELECT DISTINCT TOP 1
  Tmp1.[K�telez�s d�tuma]
    FROM lkK�zigazgat�siVizsga as Tmp1
    WHERE Tmp1.[Vizsga t�pusa]="KAB Korm�nyablak �gyint�z�i vizsg."
        AND
               Tmp1.Ad�jel = lkKAB�gyint�z�k.Ad�jel
    ORDER BY   Tmp1.[K�telez�s d�tuma] DESC
) AS K�telez�sD�tuma
FROM lkKAB�gyint�z�k INNER JOIN lkKABVizsga�sV�gzetts�g ON lkKAB�gyint�z�k.Ad�jel = lkKABVizsga�sV�gzetts�g.Ad�jel
WHERE (((lkKABVizsga�sV�gzetts�g.Ad�jel) Is Null));

-- [lkKABvizsg�valRendelkez�KAB�gyint�z�kSz�maOszt�lyonk�nt]
SELECT lkKABvizsg�valRendelkez�KAB�gyint�z�k.BFKH, lkKABvizsg�valRendelkez�KAB�gyint�z�k.Korm�nyhivatal, lkKABvizsg�valRendelkez�KAB�gyint�z�k.Hivatal, lkKABvizsg�valRendelkez�KAB�gyint�z�k.Oszt�ly, Count(lkKABvizsg�valRendelkez�KAB�gyint�z�k.Ad�jel) AS [KAB vizsg�val rendelkez�k]
FROM lkKABvizsg�valRendelkez�KAB�gyint�z�k
WHERE (((lkKABvizsg�valRendelkez�KAB�gyint�z�k.T�voll�v�)="Nem"))
GROUP BY lkKABvizsg�valRendelkez�KAB�gyint�z�k.BFKH, lkKABvizsg�valRendelkez�KAB�gyint�z�k.Korm�nyhivatal, lkKABvizsg�valRendelkez�KAB�gyint�z�k.Hivatal, lkKABvizsg�valRendelkez�KAB�gyint�z�k.Oszt�ly;

-- [lkKEHIOrvosiAlkalmass�gik2024_09_2024_12]
SELECT 789235 AS [PIR t�rzssz�m], "Budapest F�v�ros Korm�nyhivatala" AS [korm�nyzati igazgat�si szerv neve], [lkSzem�lyUtols�SzervezetiEgys�ge].[F�oszt�ly] & " " & [lkSzem�lyUtols�SzervezetiEgys�ge].[oszt�ly] AS [szervezeti egys�g neve], lkSzem�lyek.[Dolgoz� teljes neve] AS [csal�di �s ut�n�v], lkSzem�lyek.Ad�jel AS [ad�azonos�t� jel], Mid([Els�dleges feladatk�r],InStr(Nz([els�dleges Feladatk�r],""),"-")+1) AS [munkak�r / feladatk�r megnevez�se], lkSzem�lyUtols�SzervezetiEgys�ge.�NYR AS [�ll�shely �NYR azonos�t� sz�ma], lkSzervezeti�ll�shelyek.[Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s] AS [az �ll�shely besorol�sa], lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus] AS [az �ll�shelyen fenn�ll� jogviszony t�pusa], "2024. III-IV. negyed�v" AS t�rgyid�szak, lkSzem�lyek.[Orvosi vizsg�lat id�pontja] AS [a vizsg�lat id�pontja], Replace(Replace([Orvosi vizsg�lat t�pusa],"Munk�bal�p�s el�tti","el�zetes"),"Munkak�r v�ltoz�s el�tti","soron k�v�li") AS [a vizsg�lat t�pusa]
FROM lkSzervezeti�ll�shelyek RIGHT JOIN (lkSzem�lyUtols�SzervezetiEgys�ge INNER JOIN lkSzem�lyek ON lkSzem�lyUtols�SzervezetiEgys�ge.Ad�jel = lkSzem�lyek.Ad�jel) ON lkSzervezeti�ll�shelyek.�ll�shelyAzonos�t� = lkSzem�lyUtols�SzervezetiEgys�ge.�NYR
WHERE (((lkSzem�lyek.[Orvosi vizsg�lat id�pontja]) Between #9/1/2024# And #12/31/2024#));

-- [lkKeresend�k]
SELECT tKeresend�k.Azonos�t�, tKeresend�k.Sorsz�m, tKeresend�k.F�oszt�ly, tKeresend�k.Oszt�ly
FROM tKeresend�k;

-- [lkKer�letiLakosok]
SELECT lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.[Sz�let�si hely], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, Replace(Nz([�lland� lakc�m],""),"Magyarorsz�g, ","") AS �lland�, Replace(Nz([Tart�zkod�si lakc�m],""),"Magyarorsz�g, ","") AS Tart�zkod�si, IRSZ(Replace(Nz([�lland� lakc�m],""),"Magyarorsz�g, ","")) AS [�lland� IRSZ], IRSZ(Replace(Nz([Tart�zkod�si lakc�m],""),"Magyarorsz�g, ","")) AS [Tart�zkod�si IRSZ], lkSzem�lyek.[Otthoni e-mail], lkSzem�lyek.[Otthoni mobil], lkSzem�lyek.[Otthoni telefon], lkSzem�lyek.[Tov�bbi otthoni mobil]
FROM lkSzem�lyek
WHERE (((IRSZ(Replace(Nz([�lland� lakc�m],""),"Magyarorsz�g, ",""))) Like "10" & [Ker�let] & "*")) OR (((IRSZ(Replace(Nz([Tart�zkod�si lakc�m],""),"Magyarorsz�g, ",""))) Like "10" & [Ker�let] & "*"));

-- [lkKiBel�p�kL�tsz�ma]
SELECT KiBel�p�kL�tsz�ma.F�oszt�ly, KiBel�p�kL�tsz�ma.Oszt�ly, KiBel�p�kL�tsz�ma.D�tum, Sum(KiBel�p�kL�tsz�ma.L�tsz�m) AS F� INTO tKiBel�p�kL�tsz�ma
FROM (SELECT lkKil�p�Uni�.F�oszt�ly, lkKil�p�Uni�.Oszt�ly, lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja] AS D�tum, Sum(-1) AS L�tsz�m
FROM lkKil�p�Uni�
GROUP BY lkKil�p�Uni�.F�oszt�ly, lkKil�p�Uni�.Oszt�ly, lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]
UNION
SELECT  lkBel�p�kUni�.F�oszt�ly, lkBel�p�kUni�.Oszt�ly, lkBel�p�kUni�.[Jogviszony kezd� d�tuma] AS D�tum, Sum(1) AS L�tsz�m
FROM  lkBel�p�kUni�
GROUP BY lkBel�p�kUni�.F�oszt�ly, lkBel�p�kUni�.Oszt�ly, lkBel�p�kUni�.[Jogviszony kezd� d�tuma])  AS KiBel�p�kL�tsz�ma
GROUP BY KiBel�p�kL�tsz�ma.F�oszt�ly, KiBel�p�kL�tsz�ma.Oszt�ly, KiBel�p�kL�tsz�ma.D�tum;

-- [lkKiemeltNapok]
SELECT lkSorsz�mok.Sorsz�m AS �v, lkSorsz�mok_1.Sorsz�m AS h�, lkSorsz�mok_2.Sorsz�m AS tnap, dt�tal([�v] & "." & [h�] & "." & [tnap]) AS KiemeltNapok, Day([KiemeltNapok]) AS nap
FROM lkSorsz�mok, lkSorsz�mok AS lkSorsz�mok_1, lkSorsz�mok AS lkSorsz�mok_2
WHERE (((lkSorsz�mok.Sorsz�m) Between 19 And Year(Now())-2000) AND ((lkSorsz�mok_1.Sorsz�m)<13) AND ((lkSorsz�mok_2.Sorsz�m) In (1,15,31)))
ORDER BY lkSorsz�mok.Sorsz�m, lkSorsz�mok_1.Sorsz�m, lkSorsz�mok_2.Sorsz�m;

-- [lkKil�p�siD�tumN�lk�liek]
SELECT kt_azNexon_Ad�jel02.azNexon, lkKil�p�Uni�.N�v, lkKil�p�Uni�.Ad�azonos�t�, lkKil�p�Uni�.F�oszt�ly, lkKil�p�Uni�.Oszt�ly, lkSzem�lyekMind.[Jogviszony kezdete (bel�p�s d�tuma)], lkKil�p�Uni�.[Jogviszony kezd� d�tuma], lkSzem�lyekMind.[Jogviszony v�ge (kil�p�s d�tuma)], lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja], lkSzem�lyekMind.[Jogviszony sorsz�ma]
FROM (lkSzem�lyekMind INNER JOIN lkKil�p�Uni� ON (lkSzem�lyekMind.[Jogviszony kezdete (bel�p�s d�tuma)] = lkKil�p�Uni�.[Jogviszony kezd� d�tuma]) AND (lkSzem�lyekMind.Ad�jel = lkKil�p�Uni�.Ad�jel)) INNER JOIN kt_azNexon_Ad�jel02 ON lkSzem�lyekMind.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel
WHERE (((lkSzem�lyekMind.[Jogviszony v�ge (kil�p�s d�tuma)])=0));

-- [lkKil�p�Dolgoz�k]
SELECT DISTINCT bfkh([Szervezeti egys�g k�dja]) AS BFKH, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.Ad�jel, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[St�tusz k�dja], IIf(Nz([besorol�si  fokozat (KT)],"")="",[Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s],Nz([besorol�si  fokozat (KT)],"")) AS Besorol�s, lkSzem�lyek.[St�tusz t�pusa], lkSzem�lyek.[KIRA jogviszony jelleg], lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)], lkSzem�lyek.[HR kapcsolat megsz�n�s m�dja (Kil�p�s m�dja)]
FROM lkSzem�lyek LEFT JOIN lkSzervezet�ll�shelyek ON lkSzem�lyek.[St�tusz k�dja] = lkSzervezet�ll�shelyek.�ll�shely
WHERE (((lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)])>Date()) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)]) Is Null) AND ((lkSzem�lyek.[HR kapcsolat megsz�n�s m�dja (Kil�p�s m�dja)]) Is Not Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY bfkh([Szervezeti egys�g k�dja]);

-- [lkKil�p�k]
SELECT Kil�p�k.Sorsz�m, Kil�p�k.N�v, Kil�p�k.Ad�azonos�t�, Kil�p�k.[Megyei szint VAGY J�r�si Hivatal], Kil�p�k.Mez�5, Kil�p�k.Mez�6, Kil�p�k.[�NYR SZERVEZETI EGYS�G AZONOS�T�], Kil�p�k.Mez�8, Kil�p�k.[Besorol�si fokozat k�d:], Kil�p�k.[Besorol�si fokozat megnevez�se:], Kil�p�k.[�ll�shely azonos�t�], Kil�p�k.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek oka: jogszab�lyi hiva], Kil�p�k.[Jogviszony kezd� d�tuma], Kil�p�k.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja], Kil�p�k.[V�gkiel�g�t�sre jogos�t� h�napok sz�ma], Kil�p�k.[Felment�si id� h�napok sz�ma], "-" AS �res, Kil�p�k.[Illetm�ny (Ft/h�)], [Ad�azonos�t�]*1 AS Ad�jel
FROM Kil�p�k;

-- [lkKil�p�k_Havi]
SELECT Kil�p�k.N�v, [Kil�p�k].[Ad�azonos�t�]*1 AS Ad�azonos�t�, Kil�p�k.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja] AS Kil�p�s, Month([Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]) AS H�
FROM Kil�p�k;

-- [lkKil�p�k_Havi_vs_Szem�lyek]
SELECT lkKil�p�k_Havi.N�v AS N�vHavi, lkKil�p�k_Havi.Ad�azonos�t�, lkKil�p�k_Havi.Kil�p�s, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v_, lkSzem�lyek.Ad�jel, lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)] AS Kil�p�s_, lkSzem�lyek.[Helyettes�tett dolgoz� neve], lkSzem�lyek.[Tart�s t�voll�t t�pusa], lkSzem�lyek.[HR kapcsolat megsz�n�s m�dja (Kil�p�s m�dja)], lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]
FROM lkSzem�lyek LEFT JOIN lkKil�p�k_Havi ON lkSzem�lyek.Ad�jel = lkKil�p�k_Havi.Ad�azonos�t�
WHERE (((lkKil�p�k_Havi.Ad�azonos�t�) Is Null) AND ((lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)]) Between #1/1/2023# And #4/30/2023#) AND ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]) Not Like "Szem�lyes*"));

-- [lkKil�p�k_Szem�lyek01]
SELECT tSzem�lyek.[Dolgoz� teljes neve] AS N�v, Year([Jogviszony v�ge (kil�p�s d�tuma)]) AS Kil�p�s�ve, Month([Jogviszony v�ge (kil�p�s d�tuma)]) AS Kil�p�sHava, [tSzem�lyek].[Ad�jel]*1 AS Ad�azonos�t�, tSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)] AS Kil�p�s, tSzem�lyek.[Szervezeti egys�g k�dja], -1 AS L�tsz�m
FROM tSzem�lyek
WHERE (((tSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)]) Is Not Null) AND ((tSzem�lyek.[Szervezeti egys�g k�dja]) Not Like "BFKH-MEGB")) OR (((tSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)]) Is Not Null) AND ((tSzem�lyek.[Szervezeti egys�g k�dja])="")) OR (((tSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)]) Is Not Null) AND ((tSzem�lyek.[Szervezeti egys�g k�dja]) Is Null));

-- [lkKil�p�k_Szem�lyek02]
TRANSFORM Sum(lkKil�p�k_Szem�lyek01.L�tsz�m) AS SumOfL�tsz�m
SELECT lkKil�p�k_Szem�lyek01.Kil�p�sHava
FROM lkKil�p�k_Szem�lyek01
WHERE (((lkKil�p�k_Szem�lyek01.Kil�p�s�ve)>2018))
GROUP BY lkKil�p�k_Szem�lyek01.Kil�p�sHava
PIVOT lkKil�p�k_Szem�lyek01.Kil�p�s�ve;

-- [lkKil�p�kBFKHn�lLedolgozottIdejeHetente]
TRANSFORM Count(tSzem�lyek.Ad�jel) AS CountOfAd�jel
SELECT DateDiff("w",[Jogviszony kezdete (bel�p�s d�tuma)],[Jogviszony v�ge (kil�p�s d�tuma)]) AS Kif1
FROM tSzem�lyek
WHERE (((tSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)])<>0))
GROUP BY DateDiff("w",[Jogviszony kezdete (bel�p�s d�tuma)],[Jogviszony v�ge (kil�p�s d�tuma)])
PIVOT Year([Jogviszony v�ge (kil�p�s d�tuma)]);

-- [lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta01]
SELECT Trim(Replace(Replace(Replace([lkKil�p�Uni�].[F�oszt�ly],"Budapest F�v�ros Korm�nyhivatala","BFKH")," 20200229-ig",""),"Budapest F�v�rosKorm�nyhivatala","BFKH")) AS F�oszt�ly, Year([Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]) AS �v, Month([Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]) AS H�, 1 AS f�
FROM lkKil�p�Uni�
WHERE (((lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek oka: jogszab�lyi hiva]) Like "*pr�baid�*"));

-- [lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta02]
SELECT lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta01.F�oszt�ly, lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta01.�v, lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta01.f�, IIf([H�]=1,[f�],0) AS 1, IIf([H�]=2,[f�],0) AS 2, IIf([H�]=3,[f�],0) AS 3, IIf([H�]=4,[f�],0) AS 4, IIf([H�]=5,[f�],0) AS 5, IIf([H�]=6,[f�],0) AS 6, IIf([H�]=7,[f�],0) AS 7, IIf([H�]=8,[f�],0) AS 8, IIf([H�]=9,[f�],0) AS 9, IIf([H�]=10,[f�],0) AS 10, IIf([H�]=11,[f�],0) AS 11, IIf([H�]=12,[f�],0) AS 12
FROM lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta01;

-- [lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta03]
SELECT lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta02.F�oszt�ly, lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta02.�v, Sum(lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta02.[1]) AS [1 h�], Sum(lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta02.[2]) AS [2 h�], Sum(lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta02.[3]) AS [3 h�], Sum(lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta02.[4]) AS [4 h�], Sum(lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta02.[5]) AS [5 h�], Sum(lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta02.[6]) AS [6 h�], Sum(lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta02.[7]) AS [7 h�], Sum(lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta02.[8]) AS [8 h�], Sum(lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta02.[9]) AS [9 h�], Sum(lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta02.[10]) AS [10 h�], Sum(lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta02.[11]) AS [11 h�], Sum(lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta02.[12]) AS [12 h�]
FROM lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta02
GROUP BY lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta02.F�oszt�ly, lkKil�p�kPr�baid�F�oszt�lyonk�nt�venteHavonta02.�v;

-- [lkKil�p�kSz�ma]
SELECT dt�tal([Jogviszony v�ge (kil�p�s d�tuma)]) AS D�tum, 0 AS [Bel�p�k sz�ma], Count(lkSzem�lyek.Ad�jel) AS [Kil�p�k sz�ma]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]) Like "munka*" Or (lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]) Like "korm*"))
GROUP BY dt�tal([Jogviszony v�ge (kil�p�s d�tuma)]), 0
HAVING (((dt�tal([Jogviszony v�ge (kil�p�s d�tuma)])) Between Now() And DateSerial(Year(Now()),Month(Now())+1,Day(Now()))));

-- [lkKil�p�kSz�ma�vente]
SELECT Year([Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]) AS Kil�p�s�ve, Sum(IIf([Csoport]="nyugd�j",0,1)) AS [Kil�p�k sz�ma]
FROM tMegsz�n�sM�djaCsoportok RIGHT JOIN lkKil�p�Uni� ON tMegsz�n�sM�djaCsoportok.Megsz�n�sM�dja = lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek oka: jogszab�lyi hiva]
WHERE (((lkKil�p�Uni�.F�oszt�ly) Like Nz([F�oszt�ly_],"") & "*") AND ((lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])<#9/30/2024#))
GROUP BY Year([Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])
HAVING (((Year([Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])) Between 2020 And 2024));

-- [lkKil�p�kSz�ma�vente_Indokonk�nt]
TRANSFORM Count(lkSzem�lyekMind.Azonos�t�) AS [Kil�p�k sz�ma]
SELECT lkSzem�lyekMind.[HR kapcsolat megsz�n�s m�dja (Kil�p�s m�dja)]
FROM tSzem�lyek INNER JOIN lkSzem�lyekMind ON tSzem�lyek.Azonos�t� = lkSzem�lyekMind.Azonos�t�
WHERE (((lkSzem�lyekMind.[KIRA jogviszony jelleg]) Like "Korm�nyzati*" Or (lkSzem�lyekMind.[KIRA jogviszony jelleg])="Munkaviszony") AND ((lkSzem�lyekMind.JogviszonyV�ge) Is Not Null Or (lkSzem�lyekMind.JogviszonyV�ge)<>"") AND ((Year([JogviszonyV�ge]))>=2019 And (Year([JogviszonyV�ge]))<=Year(Now())))
GROUP BY lkSzem�lyekMind.[HR kapcsolat megsz�n�s m�dja (Kil�p�s m�dja)]
ORDER BY Year([JogviszonyV�ge])
PIVOT Year([JogviszonyV�ge]);

-- [lkKil�p�kSz�ma�vente2b]
SELECT lkKil�p�kSz�ma�venteHavonta.�v, Sum(lkKil�p�kSz�ma�venteHavonta.[Kil�p�k sz�ma]) AS Kil�p�k
FROM lkKil�p�kSz�ma�venteHavonta
GROUP BY lkKil�p�kSz�ma�venteHavonta.�v;

-- [lkKil�p�kSz�ma�venteF�l�vente01]
SELECT Year([JogviszonyV�ge]) AS �v, IIf(Month([JogviszonyV�ge])<7,1,2) AS F�l�v, lkSzem�lyekMind.[KIRA jogviszony jelleg], Count(lkSzem�lyekMind.Azonos�t�) AS [Kil�p�k sz�ma]
FROM lkSzem�lyekMind
WHERE (((lkSzem�lyekMind.[Jogviszony v�ge (kil�p�s d�tuma)]) Is Not Null Or (lkSzem�lyekMind.[Jogviszony v�ge (kil�p�s d�tuma)])<>"") AND ((Year([JogviszonyV�ge]))>=2019 And (Year([JogviszonyV�ge]))<=Year(Now())+1))
GROUP BY Year([JogviszonyV�ge]), IIf(Month([JogviszonyV�ge])<7,1,2), lkSzem�lyekMind.[KIRA jogviszony jelleg]
HAVING (((lkSzem�lyekMind.[KIRA jogviszony jelleg]) Like "Korm�nyzati*" Or (lkSzem�lyekMind.[KIRA jogviszony jelleg])="Munkaviszony"))
ORDER BY Year([JogviszonyV�ge]), IIf(Month([JogviszonyV�ge])<7,1,2);

-- [lkKil�p�kSz�ma�venteF�l�vente02a]
TRANSFORM Sum(lkKil�p�kSz�ma�venteF�l�vente01.[Kil�p�k sz�ma]) AS [SumOfKil�p�k sz�ma]
SELECT 1 AS Sorsz�m, lkKil�p�kSz�ma�venteF�l�vente01.[KIRA jogviszony jelleg], lkKil�p�kSz�ma�venteF�l�vente01.�v
FROM lkKil�p�kSz�ma�venteF�l�vente01
GROUP BY 1, lkKil�p�kSz�ma�venteF�l�vente01.[KIRA jogviszony jelleg], lkKil�p�kSz�ma�venteF�l�vente01.�v
ORDER BY lkKil�p�kSz�ma�venteF�l�vente01.[KIRA jogviszony jelleg], lkKil�p�kSz�ma�venteF�l�vente01.�v
PIVOT lkKil�p�kSz�ma�venteF�l�vente01.F�l�v;

-- [lkKil�p�kSz�ma�venteF�l�vente02b]
TRANSFORM Sum(lkKil�p�kSz�ma�venteF�l�vente01.[Kil�p�k sz�ma]) AS [SumOfKil�p�k sz�ma]
SELECT 2 AS Sorsz�m, "Kit. �s Mt. egy�tt:" AS [KIRA jogviszony jelleg], lkKil�p�kSz�ma�venteF�l�vente01.�v
FROM lkKil�p�kSz�ma�venteF�l�vente01
GROUP BY 2, "Kit. �s Mt. egy�tt:", lkKil�p�kSz�ma�venteF�l�vente01.�v
ORDER BY "Kit. �s Mt. egy�tt:", lkKil�p�kSz�ma�venteF�l�vente01.�v
PIVOT lkKil�p�kSz�ma�venteF�l�vente01.F�l�v;

-- [lkKil�p�kSz�ma�venteF�l�vente03]
SELECT lkKil�p�kSz�ma�venteF�l�vente02a.Sorsz�m, lkKil�p�kSz�ma�venteF�l�vente02a.[KIRA jogviszony jelleg], lkKil�p�kSz�ma�venteF�l�vente02a.�v, lkKil�p�kSz�ma�venteF�l�vente02a.[1], lkKil�p�kSz�ma�venteF�l�vente02a.[2]
FROM lkKil�p�kSz�ma�venteF�l�vente02a
UNION SELECT lkKil�p�kSz�ma�venteF�l�vente02b.Sorsz�m, lkKil�p�kSz�ma�venteF�l�vente02b.[KIRA jogviszony jelleg], lkKil�p�kSz�ma�venteF�l�vente02b.�v, lkKil�p�kSz�ma�venteF�l�vente02b.[1], lkKil�p�kSz�ma�venteF�l�vente02b.[2]
FROM lkKil�p�kSz�ma�venteF�l�vente02b;

-- [lkKil�p�kSz�ma�venteHavonta]
SELECT Year([JogviszonyV�ge]) AS �v, Month([JogviszonyV�ge]) AS H�, Count(lkSzem�lyekMind.Azonos�t�) AS [Kil�p�k sz�ma]
FROM lkSzem�lyekMind
WHERE (((lkSzem�lyekMind.[KIRA jogviszony jelleg]) Like "Korm�nyzati*" Or (lkSzem�lyekMind.[KIRA jogviszony jelleg])="Munkaviszony" Or (lkSzem�lyekMind.[KIRA jogviszony jelleg]) Like "Hivat�s*") AND ((lkSzem�lyekMind.[Jogviszony v�ge (kil�p�s d�tuma)]) Is Not Null Or (lkSzem�lyekMind.[Jogviszony v�ge (kil�p�s d�tuma)])<>"") AND ((Year([JogviszonyV�ge]))>=2019 And (Year([JogviszonyV�ge]))<=Year(Now())+1))
GROUP BY Year([JogviszonyV�ge]), Month([JogviszonyV�ge])
ORDER BY Year([JogviszonyV�ge]), Month([JogviszonyV�ge]);

-- [lkKil�p�kSz�ma�venteHavonta2]
SELECT lkKil�p�kSz�ma�venteHavonta.�v, IIf([H�]=1,[Kil�p�k sz�ma],0) AS 1, IIf([H�]=2,[Kil�p�k sz�ma],0) AS 2, IIf([H�]=3,[Kil�p�k sz�ma],0) AS 3, IIf([H�]=4,[Kil�p�k sz�ma],0) AS 4, IIf([H�]=5,[Kil�p�k sz�ma],0) AS 5, IIf([H�]=6,[Kil�p�k sz�ma],0) AS 6, IIf([H�]=7,[Kil�p�k sz�ma],0) AS 7, IIf([H�]=8,[Kil�p�k sz�ma],0) AS 8, IIf([H�]=9,[Kil�p�k sz�ma],0) AS 9, IIf([H�]=10,[Kil�p�k sz�ma],0) AS 10, IIf([H�]=11,[Kil�p�k sz�ma],0) AS 11, IIf([H�]=12,[Kil�p�k sz�ma],0) AS 12
FROM lkKil�p�kSz�ma�venteHavonta;

-- [lkKil�p�kSz�ma�venteHavonta2Akkumul�lva]
SELECT lkKil�p�kSz�ma�venteHavonta.�v, IIf([H�]<=1,[Kil�p�k sz�ma],0) AS 1, IIf([H�]<=2,[Kil�p�k sz�ma],0) AS 2, IIf([H�]<=3,[Kil�p�k sz�ma],0) AS 3, IIf([H�]<=4,[Kil�p�k sz�ma],0) AS 4, IIf([H�]<=5,[Kil�p�k sz�ma],0) AS 5, IIf([H�]<=6,[Kil�p�k sz�ma],0) AS 6, IIf([H�]<=7,[Kil�p�k sz�ma],0) AS 7, IIf([H�]<=8,[Kil�p�k sz�ma],0) AS 8, IIf([H�]<=9,[Kil�p�k sz�ma],0) AS 9, IIf([H�]<=10,[Kil�p�k sz�ma],0) AS 10, IIf([H�]<=11,[Kil�p�k sz�ma],0) AS 11, IIf([H�]<=12,[Kil�p�k sz�ma],0) AS 12
FROM lkKil�p�kSz�ma�venteHavonta;

-- [lkKil�p�kSz�ma�venteHavonta3]
SELECT lkKil�p�kSz�ma�venteHavonta2.�v, Sum(lkKil�p�kSz�ma�venteHavonta2.[1]) AS 01, Sum(lkKil�p�kSz�ma�venteHavonta2.[2]) AS 02, Sum(lkKil�p�kSz�ma�venteHavonta2.[3]) AS 03, Sum(lkKil�p�kSz�ma�venteHavonta2.[4]) AS 04, Sum(lkKil�p�kSz�ma�venteHavonta2.[5]) AS 05, Sum(lkKil�p�kSz�ma�venteHavonta2.[6]) AS 06, Sum(lkKil�p�kSz�ma�venteHavonta2.[7]) AS 07, Sum(lkKil�p�kSz�ma�venteHavonta2.[8]) AS 08, Sum(lkKil�p�kSz�ma�venteHavonta2.[9]) AS 09, Sum(lkKil�p�kSz�ma�venteHavonta2.[10]) AS 10, Sum(lkKil�p�kSz�ma�venteHavonta2.[11]) AS 11, Sum(lkKil�p�kSz�ma�venteHavonta2.[12]) AS 12, lkKil�p�kSz�ma�vente2b.Kil�p�k
FROM lkKil�p�kSz�ma�vente2b INNER JOIN lkKil�p�kSz�ma�venteHavonta2 ON lkKil�p�kSz�ma�vente2b.�v=lkKil�p�kSz�ma�venteHavonta2.�v
GROUP BY lkKil�p�kSz�ma�venteHavonta2.�v, lkKil�p�kSz�ma�vente2b.Kil�p�k;

-- [lkKil�p�kSz�ma�venteHavonta3Akkumul�lva]
SELECT lkKil�p�kSz�ma�venteHavonta2Akkumul�lva.�v, Sum(lkKil�p�kSz�ma�venteHavonta2Akkumul�lva.[1]) AS 01, Sum(lkKil�p�kSz�ma�venteHavonta2Akkumul�lva.[2]) AS 02, Sum(lkKil�p�kSz�ma�venteHavonta2Akkumul�lva.[3]) AS 03, Sum(lkKil�p�kSz�ma�venteHavonta2Akkumul�lva.[4]) AS 04, Sum(lkKil�p�kSz�ma�venteHavonta2Akkumul�lva.[5]) AS 05, Sum(lkKil�p�kSz�ma�venteHavonta2Akkumul�lva.[6]) AS 06, Sum(lkKil�p�kSz�ma�venteHavonta2Akkumul�lva.[7]) AS 07, Sum(lkKil�p�kSz�ma�venteHavonta2Akkumul�lva.[8]) AS 08, Sum(lkKil�p�kSz�ma�venteHavonta2Akkumul�lva.[9]) AS 09, Sum(lkKil�p�kSz�ma�venteHavonta2Akkumul�lva.[10]) AS 10, Sum(lkKil�p�kSz�ma�venteHavonta2Akkumul�lva.[11]) AS 11, Sum(lkKil�p�kSz�ma�venteHavonta2Akkumul�lva.[12]) AS 12, lkKil�p�kSz�ma�vente2b.Kil�p�k
FROM lkKil�p�kSz�ma�venteHavonta2Akkumul�lva INNER JOIN lkKil�p�kSz�ma�vente2b ON lkKil�p�kSz�ma�venteHavonta2Akkumul�lva.�v = lkKil�p�kSz�ma�vente2b.�v
GROUP BY lkKil�p�kSz�ma�venteHavonta2Akkumul�lva.�v, lkKil�p�kSz�ma�vente2b.Kil�p�k;

-- [lkKil�p�kSz�ma�venteHavontaF�oszt02]
SELECT lkKil�p�kSz�ma�venteHavontaF�osztOszt01.F�oszt�ly AS F�oszt�ly, lkKil�p�kSz�ma�venteHavontaF�osztOszt01.�v AS �v, Sum((IIf([H�]=1,[Kil�p�k sz�ma],0))) AS 1, Sum((IIf([H�]=2,[Kil�p�k sz�ma],0))) AS 2, Sum((IIf([H�]=3,[Kil�p�k sz�ma],0))) AS 3, Sum((IIf([H�]=4,[Kil�p�k sz�ma],0))) AS 4, Sum((IIf([H�]=5,[Kil�p�k sz�ma],0))) AS 5, Sum((IIf([H�]=6,[Kil�p�k sz�ma],0))) AS 6, Sum((IIf([H�]=7,[Kil�p�k sz�ma],0))) AS 7, Sum((IIf([H�]=8,[Kil�p�k sz�ma],0))) AS 8, Sum((IIf([H�]=9,[Kil�p�k sz�ma],0))) AS 9, Sum((IIf([H�]=10,[Kil�p�k sz�ma],0))) AS 10, Sum((IIf([H�]=11,[Kil�p�k sz�ma],0))) AS 11, Sum((IIf([H�]=12,[Kil�p�k sz�ma],0))) AS 12, [1]+[2]+[3]+[4]+[5]+[6]+[7]+[8]+[9]+[10]+[11]+[12] AS �sszesen
FROM lkKil�p�kSz�ma�venteHavontaF�osztOszt01
GROUP BY lkKil�p�kSz�ma�venteHavontaF�osztOszt01.F�oszt�ly, lkKil�p�kSz�ma�venteHavontaF�osztOszt01.�v;

-- [lkKil�p�kSz�ma�venteHavontaF�osztOszt01]
SELECT Trim(Replace(Replace(Replace([lkKil�p�Uni�].[F�oszt�ly],"Budapest F�v�ros Korm�nyhivatala","BFKH")," 20200229-ig",""),"Budapest F�v�rosKorm�nyhivatala","BFKH")) AS F�oszt�ly, Replace([lkKil�p�Uni�].[Oszt�ly]," 20200229-ig","") AS Oszt�ly, Year([JogviszonyV�ge]) AS �v, Month([JogviszonyV�ge]) AS H�, Count(lkSzem�lyekMind.Azonos�t�) AS [Kil�p�k sz�ma]
FROM lkSzem�lyekMind RIGHT JOIN lkKil�p�Uni� ON (lkSzem�lyekMind.[Ad�azonos�t� jel] = lkKil�p�Uni�.Ad�azonos�t�) AND (lkSzem�lyekMind.JogviszonyV�ge = lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])
WHERE (((lkSzem�lyekMind.[KIRA jogviszony jelleg]) Like "Korm�nyzati*" Or (lkSzem�lyekMind.[KIRA jogviszony jelleg])="Munkaviszony") AND ((lkSzem�lyekMind.JogviszonyV�ge)<>0) AND ((Year([JogviszonyV�ge])) Between Year(Now())-4 And Year(Now())+1))
GROUP BY Trim(Replace(Replace(Replace([lkKil�p�Uni�].[F�oszt�ly],"Budapest F�v�ros Korm�nyhivatala","BFKH")," 20200229-ig",""),"Budapest F�v�rosKorm�nyhivatala","BFKH")), Replace([lkKil�p�Uni�].[Oszt�ly]," 20200229-ig",""), Year([JogviszonyV�ge]), Month([JogviszonyV�ge])
ORDER BY Year([JogviszonyV�ge]), Month([JogviszonyV�ge]);

-- [lkKil�p�kSz�ma�venteHavontaF�osztOszt02]
SELECT lkKil�p�kSz�ma�venteHavontaF�osztOszt01.F�oszt�ly, lkKil�p�kSz�ma�venteHavontaF�osztOszt01.Oszt�ly, lkKil�p�kSz�ma�venteHavontaF�osztOszt01.�v, Sum(IIf([H�]=1,[Kil�p�k sz�ma],0)) AS 1, Sum(IIf([H�]=2,[Kil�p�k sz�ma],0)) AS 2, Sum(IIf([H�]=3,[Kil�p�k sz�ma],0)) AS 3, Sum(IIf([H�]=4,[Kil�p�k sz�ma],0)) AS 4, Sum(IIf([H�]=5,[Kil�p�k sz�ma],0)) AS 5, Sum(IIf([H�]=6,[Kil�p�k sz�ma],0)) AS 6, Sum(IIf([H�]=7,[Kil�p�k sz�ma],0)) AS 7, Sum(IIf([H�]=8,[Kil�p�k sz�ma],0)) AS 8, Sum(IIf([H�]=9,[Kil�p�k sz�ma],0)) AS 9, Sum(IIf([H�]=10,[Kil�p�k sz�ma],0)) AS 10, Sum(IIf([H�]=11,[Kil�p�k sz�ma],0)) AS 11, Sum(IIf([H�]=12,[Kil�p�k sz�ma],0)) AS 12, [1]+[2]+[3]+[4]+[5]+[6]+[7]+[8]+[9]+[10]+[11]+[12] AS �sszesen
FROM lkKil�p�kSz�ma�venteHavontaF�osztOszt01
GROUP BY lkKil�p�kSz�ma�venteHavontaF�osztOszt01.F�oszt�ly, lkKil�p�kSz�ma�venteHavontaF�osztOszt01.Oszt�ly, lkKil�p�kSz�ma�venteHavontaF�osztOszt01.�v;

-- [lkKil�p�kSz�ma�venteHavontaF�osztOszt02-EgyF�oszt�lyra]
SELECT lkKil�p�kSz�ma�venteHavontaF�osztOszt02.*
FROM lkKil�p�kSz�ma�venteHavontaF�osztOszt02
WHERE (((lkKil�p�kSz�ma�venteHavontaF�osztOszt02.F�oszt�ly) Like "*" & [Add meg a F�oszt�ly] & "*"));

-- [lkKil�p�kSz�ma�venteHavontaKorral]
SELECT Year([JogviszonyV�ge]) AS �v, Month([JogviszonyV�ge]) AS H�, Count(lkSzem�lyekMind.Azonos�t�) AS [Kil�p�k sz�ma], Year(Now())-Year([Sz�let�si id�]) AS Kor
FROM lkSzem�lyekMind
WHERE (((lkSzem�lyekMind.[KIRA jogviszony jelleg]) Like "Korm�nyzati*" Or (lkSzem�lyekMind.[KIRA jogviszony jelleg])="Munkaviszony") AND ((lkSzem�lyekMind.[Jogviszony v�ge (kil�p�s d�tuma)]) Is Not Null Or (lkSzem�lyekMind.[Jogviszony v�ge (kil�p�s d�tuma)])<>"") AND ((Year([JogviszonyV�ge]))>=2019 And (Year([JogviszonyV�ge]))<=Year(Now())+1))
GROUP BY Year([JogviszonyV�ge]), Month([JogviszonyV�ge]), Year(Now())-Year([Sz�let�si id�])
ORDER BY Year([JogviszonyV�ge]), Month([JogviszonyV�ge]);

-- [lkKil�p�kSz�ma�venteKorral]
SELECT lkKil�p�kSz�ma�venteHavontaKorral.�v, Switch([Kor]>=0 And [Kor]<=22,"18-22 �vek k�z�tt:",[Kor]>=23 And [Kor]<=28,"23-28 �vek k�z�tt:",[Kor]>=29 And [Kor]<=35,"29-35 �vek k�z�tt:",[Kor]>=36 And [Kor]<=40,"36-40 �vek k�z�tt:",[Kor]>=41 And [Kor]<=45,"41-45 �vek k�z�tt:",[Kor]>=46 And [Kor]<=50,"46-50 �vek k�z�tt:",[Kor]>=51 And [Kor]<=60,"51-60 �vek k�z�tt:",[Kor]>=61 And [Kor]<=65,"61-65 �vek k�z�tt:",[Kor]>=66 And [Kor]<=200,"66 �v f�l�tt:") AS Korkategoria, Sum(lkKil�p�kSz�ma�venteHavontaKorral.[Kil�p�k sz�ma]) AS Kil�p�k
FROM lkKil�p�kSz�ma�venteHavontaKorral
GROUP BY lkKil�p�kSz�ma�venteHavontaKorral.�v, Switch([Kor]>=0 And [Kor]<=22,"18-22 �vek k�z�tt:",[Kor]>=23 And [Kor]<=28,"23-28 �vek k�z�tt:",[Kor]>=29 And [Kor]<=35,"29-35 �vek k�z�tt:",[Kor]>=36 And [Kor]<=40,"36-40 �vek k�z�tt:",[Kor]>=41 And [Kor]<=45,"41-45 �vek k�z�tt:",[Kor]>=46 And [Kor]<=50,"46-50 �vek k�z�tt:",[Kor]>=51 And [Kor]<=60,"51-60 �vek k�z�tt:",[Kor]>=61 And [Kor]<=65,"61-65 �vek k�z�tt:",[Kor]>=66 And [Kor]<=200,"66 �v f�l�tt:");

-- [lkKil�p�Uni�]
SELECT DISTINCT Uni�2019_mostan�ig.Sorsz�m, Uni�2019_mostan�ig.N�v, Uni�2019_mostan�ig.Ad�azonos�t�, Uni�2019_mostan�ig.Alapl�tsz�m, Uni�2019_mostan�ig.[Megyei szint VAGY J�r�si Hivatal], Uni�2019_mostan�ig.Mez�5, Uni�2019_mostan�ig.Mez�6, Uni�2019_mostan�ig.[�NYR SZERVEZETI EGYS�G AZONOS�T�], Uni�2019_mostan�ig.Mez�8, Uni�2019_mostan�ig.[Besorol�si fokozat k�d:], Uni�2019_mostan�ig.[Besorol�si fokozat megnevez�se:], Uni�2019_mostan�ig.[�ll�shely azonos�t�], Uni�2019_mostan�ig.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek oka: jogszab�lyi hiva], Uni�2019_mostan�ig.[Jogviszony kezd� d�tuma], Uni�2019_mostan�ig.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja], Uni�2019_mostan�ig.[Illetm�ny (Ft/h�)], Uni�2019_mostan�ig.[V�gkiel�g�t�sre jogos�t� h�napok sz�ma], Uni�2019_mostan�ig.[Felment�si id� h�napok sz�ma], IIf([Megyei szint VAGY J�r�si Hivatal]="megyei szint",[Mez�5],[Megyei szint VAGY J�r�si Hivatal]) AS F�oszt�ly, Uni�2019_mostan�ig.tKil�p�kUni�.Mez�6 AS Oszt�ly, [ad�azonos�t�]*1 AS Ad�jel, *
FROM (SELECT  tKil�p�kUni�.Sorsz�m, tKil�p�kUni�.N�v, tKil�p�kUni�.Ad�azonos�t�, tKil�p�kUni�.Alapl�tsz�m, tKil�p�kUni�.[Megyei szint VAGY J�r�si Hivatal], tKil�p�kUni�.Mez�5, tKil�p�kUni�.Mez�6, tKil�p�kUni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�], tKil�p�kUni�.Mez�8, tKil�p�kUni�.[Besorol�si fokozat k�d:], tKil�p�kUni�.[Besorol�si fokozat megnevez�se:], tKil�p�kUni�.[�ll�shely azonos�t�], tKil�p�kUni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek oka: jogszab�lyi hiva], tKil�p�kUni�.[Jogviszony kezd� d�tuma], tKil�p�kUni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja], tKil�p�kUni�.[Illetm�ny (Ft/h�)], tKil�p�kUni�.[V�gkiel�g�t�sre jogos�t� h�napok sz�ma], tKil�p�kUni�.[Felment�si id� h�napok sz�ma], �v
FROM tKil�p�kUni�
UNION
SELECT Kil�p�k.Sorsz�m, Kil�p�k.N�v, Kil�p�k.Ad�azonos�t�, Kil�p�k.Alapl�tsz�m, Kil�p�k.[Megyei szint VAGY J�r�si Hivatal], Kil�p�k.Mez�5, Kil�p�k.Mez�6, Kil�p�k.[�NYR SZERVEZETI EGYS�G AZONOS�T�], Kil�p�k.Mez�8, Kil�p�k.[Besorol�si fokozat k�d:], Kil�p�k.[Besorol�si fokozat megnevez�se:], Kil�p�k.[�ll�shely azonos�t�], Kil�p�k.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek oka: jogszab�lyi hiva], Kil�p�k.[Jogviszony kezd� d�tuma], Kil�p�k.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja], Kil�p�k.[Illetm�ny (Ft/h�)], Kil�p�k.[V�gkiel�g�t�sre jogos�t� h�napok sz�ma], Kil�p�k.[Felment�si id� h�napok sz�ma],Year(date()) as �v
FROM Kil�p�k)  AS Uni�2019_mostan�ig;

-- [lkKimenet�res�ll�shelyekKimutat�shoz]
SELECT Bet�lt�ttek�s�resek.[�NYR azonos�t�], Bet�lt�ttek�s�resek.Besorol�s, Bet�lt�ttek�s�resek.Jelleg, Bet�lt�ttek�s�resek.[Bet�lt� neve], Bet�lt�ttek�s�resek.F�oszt�ly, Bet�lt�ttek�s�resek.Oszt�ly, Bet�lt�ttek�s�resek.�llapot, Bet�lt�ttek�s�resek.[Ell�tott feladat], Bet�lt�ttek�s�resek.Megjegyz�s, *
FROM (SELECT Bet�lt�ttek.*
FROM lkKimenet�res�ll�shelyekKimutat�shoz01 AS Bet�lt�ttek
UNION SELECT �resek.*
FROM lkKimenet�res�ll�shelyekKimutat�shoz02 AS �resek
union SELECT Hat�rozottak.mez�25 AS [�NYR azonos�t�], Hat�rozottak.mez�24 AS Besorol�s, Hat�rozottak.[K�zpontos�tott �ll�shely] AS Jelleg, Hat�rozottak.[Tart�s t�voll�v� �ll�shely�n hat�rozott id�re foglalkoztatott ne] AS [Bet�lt� neve], IIf([mez�18]="megyei szint",[mez�19],[mez�18]) AS F�oszt�ly, Hat�rozottak.mez�20 AS Oszt�ly, "Bet�lt�tt" AS �llapot, Hat�rozottak.mez�22 AS [Ell�tott feladat], IIf(CStr([Mez�23]) Like "*Ov*" Or CStr([Mez�23]) Like "*Jhv*" Or CStr([mez�23]) Like "*ig." Or CStr([Mez�23])="fsp.","vezet�i","") AS Megjegyz�s
FROM Hat�rozottak)  AS Bet�lt�ttek�s�resek;

-- [lkKimenet�res�ll�shelyekKimutat�shoz01]
SELECT lkJ�r�siKorm�nyK�zpontos�tottUni�.[�ll�shely azonos�t�] AS [�NYR azonos�t�], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Besorol�si fokozat megnevez�se:] AS Besorol�s, lkJ�r�siKorm�nyK�zpontos�tottUni�.Jelleg, lkJ�r�siKorm�nyK�zpontos�tottUni�.N�v AS [Bet�lt� neve], lkJ�r�siKorm�nyK�zpontos�tottUni�.[J�r�si Hivatal] AS F�oszt�ly, lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly, "Bet�lt�tt" AS �llapot, lkJ�r�siKorm�nyK�zpontos�tottUni�.[Ell�tott feladat], IIf([Besorol�si fokozat k�d:] Like "*Ov*" Or [Besorol�si fokozat k�d:] Like "*Jhv*" Or [Besorol�si fokozat k�d:] Like "*ig." Or [Besorol�si fokozat k�d:]="fsp.","vezet�i","") AS Megjegyz�s
FROM lkJ�r�siKorm�nyK�zpontos�tottUni�
WHERE (((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Sz�let�si �v \ �res �ll�s]) Not Like "�res*"));

-- [lkKimenet�res�ll�shelyekKimutat�shoz02]
SELECT lkJ�r�siKorm�nyK�zpontos�tottUni�.[�ll�shely azonos�t�] AS [�NYR azonos�t�], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Besorol�si fokozat megnevez�se:] AS Besorol�s, lkJ�r�siKorm�nyK�zpontos�tottUni�.Jelleg, lkJ�r�siKorm�nyK�zpontos�tottUni�.N�v AS [Bet�lt� neve], lkJ�r�siKorm�nyK�zpontos�tottUni�.[J�r�si Hivatal] AS F�oszt�ly, lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly, "�res:" & Nz([Visszajelz�sSz�vege],"Nincs folyamatban") AS �llapot, lkJ�r�siKorm�nyK�zpontos�tottUni�.[Ell�tott feladat], IIf([Besorol�si fokozat k�d:] Like "*Ov*" Or [Besorol�si fokozat k�d:] Like "*Jhv*" Or [Besorol�si fokozat k�d:] Like "*ig." Or [Besorol�si fokozat k�d:]="fsp.","vezet�i","") AS Megjegyz�s
FROM lkJ�r�siKorm�nyK�zpontos�tottUni� LEFT JOIN (lk�zenetekVisszajelz�sek LEFT JOIN tVisszajelz�sT�pusok ON lk�zenetekVisszajelz�sek.Visszajelz�sK�d = tVisszajelz�sT�pusok.Visszajelz�sK�d) ON lkJ�r�siKorm�nyK�zpontos�tottUni�.[Hash] = lk�zenetekVisszajelz�sek.Hash
WHERE (((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Sz�let�si �v \ �res �ll�s]) Like "�res*") AND ((lk�zenetekVisszajelz�sek.DeliveredDate)=(Select Max([DeliveredDate]) FROM [lk�zenetekVisszajelz�sek] as Tmp Where [lk�zenetekVisszajelz�sek].Hash=Tmp.hash) Or (lk�zenetekVisszajelz�sek.DeliveredDate) Is Null)) OR (((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Sz�let�si �v \ �res �ll�s]) Like "�res*") AND ((lk�zenetekVisszajelz�sek.DeliveredDate) Is Null));

-- [lkKimenet�res�ll�shelyekKimutet�shoz2a]
SELECT lkKimenet�res�ll�shelyekKimutat�shoz.F�oszt�ly, lkKimenet�res�ll�shelyekKimutat�shoz.Oszt�ly, lkKimenet�res�ll�shelyekKimutat�shoz.Jelleg, IIf([�llapot] Like "�res*",1,0) AS �res, IIf([Megjegyz�s]="vezet�i" And [�llapot] Like "�res*",1,0) AS [Ebb�l �res vezet�i �ll�shely], IIf([�llapot] Like "�res*",0,1) AS Bet�lt�tt, IIf([Megjegyz�s]="vezet�i" And [�llapot] Not Like "�res*",1,0) AS [Bet�lt�tt vezet�i]
FROM lkKimenet�res�ll�shelyekKimutat�shoz;

-- [lkKimenet�res�ll�shelyekKimutet�shoz2b]
SELECT lkKimenet�res�ll�shelyekKimutet�shoz2a.F�oszt�ly, lkKimenet�res�ll�shelyekKimutet�shoz2a.Oszt�ly, lkKimenet�res�ll�shelyekKimutet�shoz2a.Jelleg, Sum(lkKimenet�res�ll�shelyekKimutet�shoz2a.�res) AS �res, Sum(lkKimenet�res�ll�shelyekKimutet�shoz2a.[Ebb�l �res vezet�i �ll�shely]) AS [Ebb�l �res vezet�i �ll�shely], Sum(lkKimenet�res�ll�shelyekKimutet�shoz2a.Bet�lt�tt) AS Bet�lt�tt, Sum(lkKimenet�res�ll�shelyekKimutet�shoz2a.[Bet�lt�tt vezet�i]) AS [Bet�lt�tt vezet�i]
FROM lkKimenet�res�ll�shelyekKimutet�shoz2a
GROUP BY lkKimenet�res�ll�shelyekKimutet�shoz2a.F�oszt�ly, lkKimenet�res�ll�shelyekKimutet�shoz2a.Oszt�ly, lkKimenet�res�ll�shelyekKimutet�shoz2a.Jelleg;

-- [lkKinaiulBesz�l�k]
SELECT lkSzem�lyek.T�rzssz�m, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Nyelvtud�s K�nai]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null) AND ((lkSzem�lyek.[Nyelvtud�s K�nai])="IGEN") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [lkKiraFeladatMegnevez�sek]
SELECT DISTINCT lkSzem�lyek.[KIRA feladat megnevez�s]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[KIRA feladat megnevez�s]) Is Not Null));

-- [lkKiraHiba]
SELECT tKiraHiba.Azonos�t�, [Ad�azonos�t�]*1 AS Ad�jel, tKiraHiba.N�v, tKiraHiba.KIRAzonos�t�, tKiraHiba.Egys�g, tKiraHiba.Hiba, tKiraHiba.ImportD�tum
FROM lkSzem�lyek RIGHT JOIN tKiraHiba ON lkSzem�lyek.Ad�jel = tKiraHiba.Ad�azonos�t�
WHERE (((tKiraHiba.ImportD�tum)=#9/18/2023#) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [lkKiraHibaStatisztika]
SELECT lkKiraHibaJav.Hib�k, Count(lkKiraHibaJav.Azonos�t�) AS Mennyis�g
FROM (SELECT IIf([Hiba] Like "A dolgoz� �j bel�p�k�nt lett r�gz�tve * hat�ly d�tummal. Csak az adott napon �rv�nyes adatok ker�lnek feldolgoz�sra.","##A dolgoz�...##",[hiba]) AS Hib�k, lkKiraHiba.Azonos�t� FROM lkKiraHiba)  AS lkKiraHibaJav
GROUP BY lkKiraHibaJav.Hib�k;

-- [lkKorfa01]
SELECT Switch(Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])>=0 AND Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])<=20,"20 �v alatt:",
Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])>=21 AND Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])<=25,"21-25 �vek k�z�tt:",
Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])>=26 AND Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])<=30,"26-30 �vek k�z�tt:",
Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])>=31 AND Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])<=35,"31-35 �vek k�z�tt:",
Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])>=36 AND Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])<=40,"36-40 �vek k�z�tt:",
Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])>=41 AND Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])<=45,"41-45 �vek k�z�tt:",
Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])>=46 AND Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])<=50,"46-50 �vek k�z�tt:",
Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])>=51 AND Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])<=55,"51-55 �vek k�z�tt:",
Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])>=56 AND Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])<=60,"56-60 �vek k�z�tt:",
Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])>=61 AND Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])<=65,"61-65 �vek k�z�tt:",
Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])>=66 AND Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])<=70,"66-70 �vek k�z�tt:",
Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])>=71 AND Year(Now())-Year([lkSzem�lyek].[Sz�let�si id�])<=200,"70 �v f�l�tt:",
) AS Korcsoport, lkSzem�lyek.Ad�jel AS ad�, IIf(lkSzem�lyek.Neme="f�rfi",-1,0) AS F�rfi, IIf(lkSzem�lyek.Neme<>"f�rfi",1,0) AS N�
FROM lkSzem�lyek
WHERE tSzem�lyek.[St�tusz neve]="�ll�shely";

-- [lkKorfa02]
SELECT Korcsoport, sum([F�rfi]) AS F�rfiak, sum([N�]) AS N�k
FROM lkKorfa01
GROUP BY Korcsoport;

-- [lkKorfa03]
SELECT "�sszesen:" AS Korcsoport, Sum(lkKorfa02.F�rfiak) AS F�rfiak, Sum(lkKorfa02.N�k) AS N�k
FROM lkKorfa02
GROUP BY "�sszesen:";

-- [lkKorfa04]
SELECT Uni�.Korcsoport, Uni�.F�rfiak AS F�rfi, Uni�.N�k AS N�
FROM (SELECT *
  FROM lkKorfa02
  UNION
  SELECT *
  FROM lkKorfa03
  )  AS Uni�;

-- [lkKorfa06]
SELECT lkKorfa04.Korcsoport AS Korcsoport, lkKorfa04.F�rfi AS F�rfi, lkKorfa04.N� AS N�
FROM lkKorfa04;

-- [lkKorm�nyhivatali_�llom�ny]
SELECT Korm�nyhivatali_�llom�ny.Sorsz�m, Korm�nyhivatali_�llom�ny.N�v, Korm�nyhivatali_�llom�ny.Ad�azonos�t�, Korm�nyhivatali_�llom�ny.Mez�4 AS [Sz�let�si �v \ �res �ll�s], Korm�nyhivatali_�llom�ny.Mez�5 AS Neme, Korm�nyhivatali_�llom�ny.Mez�6 AS F�oszt�ly, Korm�nyhivatali_�llom�ny.Mez�7 AS Oszt�ly, "" AS Projekt, Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�], Korm�nyhivatali_�llom�ny.Mez�9 AS [Ell�tott feladat], Korm�nyhivatali_�llom�ny.Mez�10 AS Kinevez�s, Korm�nyhivatali_�llom�ny.[Feladat jellege: szakmai (SZ) / funkcion�lis (F) feladatell�t�s;], Korm�nyhivatali_�llom�ny.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ], Korm�nyhivatali_�llom�ny.[Heti munka�r�k sz�ma], Korm�nyhivatali_�llom�ny.Mez�14 AS [Bet�lt�s ar�nya], Korm�nyhivatali_�llom�ny.[Besorol�si fokozat k�d:], Korm�nyhivatali_�llom�ny.[Besorol�si fokozat megnevez�se:], Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], Korm�nyhivatali_�llom�ny.Mez�18 AS [Havi illetm�ny], Korm�nyhivatali_�llom�ny.Mez�19 AS [Eu finansz�rozott], Korm�nyhivatali_�llom�ny.Mez�20 AS [Illetm�ny forr�sa], Korm�nyhivatali_�llom�ny.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h], Korm�nyhivatali_�llom�ny.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], Korm�nyhivatali_�llom�ny.[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)], Korm�nyhivatali_�llom�ny.[Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is], Korm�nyhivatali_�llom�ny.[�gyf�lszolg�lati munkat�rs (1) �gyf�lszolg�lati h�tt�r munkat�rs], Korm�nyhivatali_�llom�ny.Mez�26 AS [K�pes�t�st ad� v�gzetts�g], Korm�nyhivatali_�llom�ny.Mez�27 AS KAB, Korm�nyhivatali_�llom�ny.[KAB 001-3** Branch ID]
FROM Korm�nyhivatali_�llom�ny;

-- [lkKorm�nyhivataliJ�r�siK�zpT�rt�net]
SELECT L�tsz�mUni�T�rt�net.Sorsz�m, L�tsz�mUni�T�rt�net.N�v, L�tsz�mUni�T�rt�net.Ad�azonos�t�, L�tsz�mUni�T�rt�net.[Sz�let�si �v \ �res �ll�s], L�tsz�mUni�T�rt�net.Neme, L�tsz�mUni�T�rt�net.[J�r�si Hivatal_], L�tsz�mUni�T�rt�net.Oszt�ly, L�tsz�mUni�T�rt�net.[�NYR SZERVEZETI EGYS�G AZONOS�T�], L�tsz�mUni�T�rt�net.[Ell�tott feladat], L�tsz�mUni�T�rt�net.Kinevez�s, L�tsz�mUni�T�rt�net.[Feladat jellege: szakmai (SZ) / funkcion�lis (F) feladatell�t�s;], L�tsz�mUni�T�rt�net.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ], L�tsz�mUni�T�rt�net.[Heti munka�r�k sz�ma], L�tsz�mUni�T�rt�net.[Bet�lt�s ar�nya], L�tsz�mUni�T�rt�net.[Besorol�si fokozat k�d:], L�tsz�mUni�T�rt�net.[Besorol�si fokozat megnevez�se:], L�tsz�mUni�T�rt�net.[�ll�shely azonos�t�], L�tsz�mUni�T�rt�net.[Havi illetm�ny], L�tsz�mUni�T�rt�net.[Eu finansz�rozott], L�tsz�mUni�T�rt�net.[Illetm�ny forr�sa], L�tsz�mUni�T�rt�net.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h], L�tsz�mUni�T�rt�net.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], L�tsz�mUni�T�rt�net.[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)], L�tsz�mUni�T�rt�net.[Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is], L�tsz�mUni�T�rt�net.[�gyf�lszolg�lati munkat�rs (1) �gyf�lszolg�lati h�tt�r munkat�rs], L�tsz�mUni�T�rt�net.[K�pes�t�st ad� v�gzetts�g], L�tsz�mUni�T�rt�net.KAB, L�tsz�mUni�T�rt�net.[KAB 001-3** Branch ID], IIf([Ad�azonos�t�] Is Null Or [Ad�azonos�t�]="",0,[Ad�azonos�t�]*1) AS Ad�jel, tHaviJelent�sHat�lya1.hat�lya
FROM (SELECT *
FROM lktJ�r�si_�llom�ny
UNION SELECT *
FROM lktKorm�nyhivatali_�llom�ny
UNION SELECT *
FROM lktK�zpontos�tottak
)  AS L�tsz�mUni�T�rt�net INNER JOIN tHaviJelent�sHat�lya1 ON L�tsz�mUni�T�rt�net.hat�lyaID = tHaviJelent�sHat�lya1.hat�lyaID;

-- [lkK�lt�z�SzervezetL�tsz�m]
SELECT lkKeresend�k.Sorsz�m, Tmp.F�oszt�ly, Tmp.Oszt�ly_, Tmp.L�tsz�m
FROM lkKeresend�k, lkF�oszt�lyon�ntiOszt�lyonk�ntiL�tsz�m AS Tmp
WHERE (((Tmp.F�oszt�ly)=[lkKeresend�k].[F�oszt�ly]) AND ((Tmp.Oszt�ly_)=[lkKeresend�k].[Oszt�ly])) OR (((Tmp.F�oszt�ly)=[lkKeresend�k].[F�oszt�ly]) AND ((Tmp.Oszt�ly_) Like [lkKeresend�k].[Oszt�ly]))
ORDER BY lkKeresend�k.Sorsz�m, Tmp.BFKH DESC , Tmp.Sor;

-- [lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m01]
SELECT lkSzem�lyek.Ad�jel, lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus], Nz(IIf([Jogviszony t�pusa / jogviszony t�pus]="Munkaviszony",Choose(Left(IIf([Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is] Is Null Or [Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is]="",0,[Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is]),1)*1,"alapfok�","k�z�pfok�","fels�fok�","fels�fok�","k�z�pfok�","k�z�pfok�"),"-"),"k�z�pfok�") AS V�gzetts�g, lkSzem�lyek.[St�tusz neve], lkSzem�lyek.[Tart�s t�voll�t t�pusa], lkSzem�lyek.[St�tusz t�pusa], lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� havi �raker], Nz([�sszesen],[lkSzem�lyek].[Kerek�tett 100 %-os illetm�ny (elt�r�t�s n�lk�li)]) AS [Kerek�tett 100 %-os illetm�ny (elt�r�t�s n�lk�li)], Nz([tK�lts�gvet�shezHivat�sosok].[Besorol�s],[lkSzem�lyek].[Besorol�s2]) AS Besorol�s2
FROM tK�lts�gvet�shezHivat�sosok RIGHT JOIN (lkJ�r�siKorm�nyK�zpontos�tottUni� RIGHT JOIN (lkSzem�lyek LEFT JOIN lkBesorol�sV�ltoztat�sok ON lkSzem�lyek.[St�tusz k�dja] = lkBesorol�sV�ltoztat�sok.�ll�shelyAzonos�t�) ON lkJ�r�siKorm�nyK�zpontos�tottUni�.Ad�jel = lkSzem�lyek.Ad�jel) ON tK�lts�gvet�shezHivat�sosok.[Ad�azonos�t� jel] = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null) AND ((lkSzem�lyek.[St�tusz t�pusa])="Szervezeti alapl�tsz�m") AND ((lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� havi �raker])>=60));

-- [lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m01 m�solata]
SELECT lkSzem�lyek.Ad�jel, lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus], Nz(IIf([Jogviszony t�pusa / jogviszony t�pus]="Munkaviszony",Choose(Left(IIf([Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is] Is Null Or [Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is]="",0,[Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is]),1)*1,"alapfok�","k�z�pfok�","fels�fok�","fels�fok�","k�z�pfok�","k�z�pfok�"),"-"),"k�z�pfok�") AS V�gzetts�g, lkSzem�lyek.[St�tusz neve], lkSzem�lyek.[Tart�s t�voll�t t�pusa], lkSzem�lyek.[St�tusz t�pusa], lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� havi �raker], Nz([�sszesen],[lkSzem�lyek].[Kerek�tett 100 %-os illetm�ny (elt�r�t�s n�lk�li)]) AS [Kerek�tett 100 %-os illetm�ny (elt�r�t�s n�lk�li)], Nz([tK�lts�gvet�shezHivat�sosok].[Besorol�s],[lkSzem�lyek].[Besorol�s2]) AS Besorol�s2
FROM tK�lts�gvet�shezHivat�sosok RIGHT JOIN (lkJ�r�siKorm�nyK�zpontos�tottUni� RIGHT JOIN (lkSzem�lyek LEFT JOIN lkBesorol�sV�ltoztat�sok ON lkSzem�lyek.[St�tusz k�dja] = lkBesorol�sV�ltoztat�sok.�ll�shelyAzonos�t�) ON lkJ�r�siKorm�nyK�zpontos�tottUni�.Ad�jel = lkSzem�lyek.Ad�jel) ON tK�lts�gvet�shezHivat�sosok.[Ad�azonos�t� jel] = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null) AND ((lkSzem�lyek.[St�tusz t�pusa])="Szervezeti alapl�tsz�m") AND ((lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� havi �raker])>=60));

-- [lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m02]
SELECT lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m01.[Jogviszony t�pusa / jogviszony t�pus] AS Jogviszony, lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m01.V�gzetts�g, IIf([Jogviszony t�pusa / jogviszony t�pus]="Munkaviszony","-",[Besorol�s2]) AS Besorol�s, Count(lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m01.Ad�jel) AS [Bet�lt�tt l�tsz�m], Round([Bet�lt�tt l�tsz�m]*Nz([Enged�lyezett l�tsz�m, ha semmi, akkor 5350],5350)/(Select count(ad�jel) from lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m01),2) AS [Statisztikai l�tsz�m], Sum(lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m01.[Kerek�tett 100 %-os illetm�ny (elt�r�t�s n�lk�li)]) AS Illetm�ny
FROM lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m01
GROUP BY lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m01.[Jogviszony t�pusa / jogviszony t�pus], lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m01.V�gzetts�g, IIf([Jogviszony t�pusa / jogviszony t�pus]="Munkaviszony","-",[Besorol�s2]);

-- [lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m02�tlagb�r]
SELECT Sum(lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m02.[Bet�lt�tt l�tsz�m]) AS F�, Sum(lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m02.Illetm�ny) AS Ft, Nz([�j �tlagb�r, ha semmi, akkor 585000],585000)/([Ft]/[F�]) AS �tlagb�rszorz�
FROM lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m02;

-- [lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m03]
SELECT tK�lts�gvet�shezBesorol�sok.Sor, tK�lts�gvet�shezBesorol�sok.Besorol�s, Sum(lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m02.[Bet�lt�tt l�tsz�m]) AS [SumOfBet�lt�tt l�tsz�m], Sum(lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m02.[Statisztikai l�tsz�m]) AS [SumOfStatisztikai l�tsz�m], Sum(lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m02.Illetm�ny) AS SumOfIlletm�ny, Sum([Statisztikai l�tsz�m]/[Bet�lt�tt l�tsz�m]*[Illetm�ny]*(SELECT first([�tlagb�rszorz�]) FROM lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m02�tlagb�r )) AS [Statisztikai illetm�ny]
FROM tK�lts�gvet�shezBesorol�sok RIGHT JOIN lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m02 ON (tK�lts�gvet�shezBesorol�sok.Besorol�sSzem�lyt�rzs = lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m02.Besorol�s) AND (tK�lts�gvet�shezBesorol�sok.V�gzetts�g = lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m02.V�gzetts�g) AND (tK�lts�gvet�shezBesorol�sok.Jogviszony = lkK�lts�gvet�shezBesorol�sonk�ntiL�tsz�m02.[Jogviszony])
GROUP BY tK�lts�gvet�shezBesorol�sok.Sor, tK�lts�gvet�shezBesorol�sok.Besorol�s;

-- [lkK�lts�gvet�shezHivat�sosokKimutat�s]
SELECT lkSzem�lyek.[KIRA jogviszony jelleg], lkSzem�lyek.[Besorol�si  fokozat (KT)], IIf(Nz([tK�lts�gvet�shezHivat�sosok].[Ad�azonos�t� jel],0)>0,True,False) AS [T�bl�ban-e], Count(lkSzem�lyek.Ad�jel) AS CountOfAd�jel
FROM tK�lts�gvet�shezHivat�sosok RIGHT JOIN lkSzem�lyek ON tK�lts�gvet�shezHivat�sosok.[Ad�azonos�t� jel] = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.F�oszt�ly) Like "T�z*"))
GROUP BY lkSzem�lyek.[KIRA jogviszony jelleg], lkSzem�lyek.[Besorol�si  fokozat (KT)], IIf(Nz([tK�lts�gvet�shezHivat�sosok].[Ad�azonos�t� jel],0)>0,True,False);

-- [lkK�zeliLej�r�Hat�rozottId�s�k]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], IIf(dt�tal([Hat�rozott idej� _szerz�d�s/kinevez�s lej�r])=0,#1/1/3000#,dt�tal([Hat�rozott idej� _szerz�d�s/kinevez�s lej�r])) AS [Szerz�d�s lej�r], kt_azNexon_Ad�jel02.NLink
FROM kt_azNexon_Ad�jel02 RIGHT JOIN lkSzem�lyek ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((IIf(dt�tal([Hat�rozott idej� _szerz�d�s/kinevez�s lej�r])=0,#1/1/3000#,dt�tal([Hat�rozott idej� _szerz�d�s/kinevez�s lej�r])))<DateAdd("d",30,Now())) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY IIf(dt�tal([Hat�rozott idej� _szerz�d�s/kinevez�s lej�r])=0,#1/1/3000#,dt�tal([Hat�rozott idej� _szerz�d�s/kinevez�s lej�r]));

-- [lkK�zigazgat�siAlapvizsgaAl�lMentes�tettek]
SELECT lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Dolgoz� sz�let�si neve], lkSzem�lyek.[Anyja neve], lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.[Hivatali email], lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)]) Between #1/5/2020# And #4/30/2022#) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null) AND ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]) Like "Korm�ny*") AND ((lkSzem�lyek.[Besorol�si  fokozat (KT)]) Not Like "*oszt�ly*" And (lkSzem�lyek.[Besorol�si  fokozat (KT)]) Not Like "*j�r�s*" And (lkSzem�lyek.[Besorol�si  fokozat (KT)]) Not Like "*igazg*" And (lkSzem�lyek.[Besorol�si  fokozat (KT)])<>"f�isp�n"));

-- [lkK�zigazgat�siAlapvizsgaK�telezetts�gHi�nya]
SELECT lkK�zigazgat�siAlapvizsgaK�telezetts�gHi�nya00.F�oszt�ly, lkK�zigazgat�siAlapvizsgaK�telezetts�gHi�nya00.Oszt�ly, lkK�zigazgat�siAlapvizsgaK�telezetts�gHi�nya00.N�v, lkK�zigazgat�siAlapvizsgaK�telezetts�gHi�nya00.Bel�p�s, lkK�zigazgat�siAlapvizsgaK�telezetts�gHi�nya00.NLink
FROM lkK�zigazgat�siAlapvizsgaK�telezetts�gHi�nya00
ORDER BY lkK�zigazgat�siAlapvizsgaK�telezetts�gHi�nya00.BFKH, lkK�zigazgat�siAlapvizsgaK�telezetts�gHi�nya00.N�v;

-- [lkK�zigazgat�siAlapvizsgaK�telezetts�gHi�nya00]
SELECT TOP 1000 lkSzem�lyek.Ad�jel, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS Bel�p�s, kt_azNexon_Ad�jel02.NLink, lkSzem�lyek.BFKH
FROM (lkSzem�lyek LEFT JOIN kt_azNexon_Ad�jel02 ON lkSzem�lyek.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel) LEFT JOIN lkK�zigazgat�siAlapvizsg�valRendelkez�k ON lkSzem�lyek.Ad�jel = lkK�zigazgat�siAlapvizsg�valRendelkez�k.Ad�jel
WHERE (((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])<Date()) AND ((lkSzem�lyek.[Alapvizsga mentess�g])<>True) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Alapvizsga let�tel t�nyleges hat�rideje]) Is Null) AND ((lkSzem�lyek.[St�tusz t�pusa]) Is Not Null) AND ((lkK�zigazgat�siAlapvizsg�valRendelkez�k.Ad�jel) Is Null) AND ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]) Like "ko*") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null Or (lkSzem�lyek.[Tart�s t�voll�t t�pusa])=""))
ORDER BY lkSzem�lyek.Ad�jel;

-- [lkK�zigazgat�siAlapvizsg�valRendelkez�k]
SELECT lkK�zigazgat�siVizsga.Ad�jel, lkK�zigazgat�siVizsga.[Vizsga t�pusa], lkK�zigazgat�siVizsga.[Oklev�l sz�ma], lkK�zigazgat�siVizsga.[Oklev�l d�tuma], lkK�zigazgat�siVizsga.[Oklev�l lej�r], lkK�zigazgat�siVizsga.[Vizsga eredm�nye], lkK�zigazgat�siVizsga.Mentess�g
FROM lkK�zigazgat�siVizsga
WHERE (((lkK�zigazgat�siVizsga.[Vizsga t�pusa])="K�zigazgat�si alapvizsga") AND ((lkK�zigazgat�siVizsga.Mentess�g)=False));

-- [lkK�zigazgat�siVizsga]
SELECT [Dolgoz� azonos�t�]*1 AS Ad�jel, tK�zigazgat�siVizsga.*
FROM tK�zigazgat�siVizsga;

-- [lkK�zpontos�tottak]
SELECT K�zpontos�tottak.Sorsz�m, K�zpontos�tottak.N�v, K�zpontos�tottak.Ad�azonos�t�, K�zpontos�tottak.Mez�4 AS [Sz�let�si �v \ �res �ll�s], "" AS Nem, Replace(IIf([Megyei szint VAGY J�r�si Hivatal]="Megyei szint",[K�zpontos�tottak].[Mez�6],[Megyei szint VAGY J�r�si Hivatal]),"Budapest F�v�ros Korm�nyhivatala ","BFKH ") AS F�oszt, K�zpontos�tottak.Mez�7 AS Oszt�ly, K�zpontos�tottak.[Projekt megnevez�se], K�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], K�zpontos�tottak.Mez�10 AS [Ell�tott feladat], K�zpontos�tottak.Mez�11 AS Kinevez�s, "SZ" AS [Feladat jellege], K�zpontos�tottak.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ], 0 AS [Heti munka�r�k sz�ma], 1 AS [Bet�lt�s ar�nya], K�zpontos�tottak.[Besorol�si fokozat k�d:], K�zpontos�tottak.[Besorol�si fokozat megnevez�se:], K�zpontos�tottak.[�ll�shely azonos�t�], K�zpontos�tottak.Mez�17 AS [Havi illetm�ny], "" AS [Eu finansz�rozott], "" AS [Illetm�ny forr�sa], "" AS [Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h], K�zpontos�tottak.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], K�zpontos�tottak.[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)], K�zpontos�tottak.[Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is], "" AS [�gyf�lszolg�lati munkat�rs (1) �gyf�lszolg�lati h�tt�r munkat�rs], "" AS [K�pes�t�st ad� v�gzetts�g], "" AS KAB, "" AS [KAB 001-3** Branch ID]
FROM K�zpontos�tottak
WHERE ((("")=True Or ("")='IIf([Neme]="N�";2;1)'));

-- [lkK�zpontos�tottakL�tsz�m�nakaMegoszl�sa]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, Nz([K�lts�ghely*],[St�tusz k�lts�ghely�nek neve ]) AS Ktghely, Count(lkSzem�lyek.Azonos�t�) AS L�tsz�m
FROM tEsetiProjektbeFelveend�k RIGHT JOIN (kt_azNexon_Ad�jel02 RIGHT JOIN lkSzem�lyek ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel) ON tEsetiProjektbeFelveend�k.[Szem�ly azonos�t�ja*] = kt_azNexon_Ad�jel02.azNexon
WHERE (((lkSzem�lyek.[St�tusz t�pusa]) Like "K�z*"))
GROUP BY lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, Nz([K�lts�ghely*],[St�tusz k�lts�ghely�nek neve ]);

-- [lkK�zpontos�tott�ll�shelyenEl�fordul�kSz�ma]
SELECT subquery.Jogviszony, Count(subquery.Ad�azonos�t�) AS L�tsz�m
FROM (SELECT DISTINCT IIf([Besorol�si fokozat k�d:] Like "Mt.*","munkaviszony","korm�nytisztvisel�i jogviszony") AS Jogviszony, lktK�zpontos�tottak.Ad�azonos�t� FROM lktK�zpontos�tottak INNER JOIN tHaviJelent�sHat�lya ON lktK�zpontos�tottak.hat�lyaID = tHaviJelent�sHat�lya.hat�lyaID WHERE (tHaviJelent�sHat�lya.hat�lya Between Nz([Kezd� d�tum, ha semmi, akkor az el�z� �v eleje],DateSerial(Year(Date())-1,1,1)) And Nz([V�ge d�tum, ha semmi, akkor az el�z� �v v�ge],DateSerial(Year(Date())-1,12,31))) And tHaviJelent�sHat�lya.hat�lya=DateSerial(Year([hat�lya]),Month([hat�lya])+1,0) And lktK�zpontos�tottak.[Sz�let�si �v \ �res �ll�s]<>"�res �ll�s")  AS subquery
GROUP BY subquery.Jogviszony;

-- [lkKSZDRbenNemSzerepl�k]
SELECT DISTINCT bfkh([F�oszt�lyK�d]) AS BFKH, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS Bel�p�s
FROM lkSzem�lyek LEFT JOIN tKSZDR ON lkSzem�lyek.[Ad�azonos�t� jel] = tKSZDR.[Ad�azonos�t� jel]
WHERE (((tKSZDR.[Teljes n�v]) Is Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY bfkh([F�oszt�lyK�d]), lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)];

-- [lkKSZDRhib�kKimenet]
SELECT IIf(Nz([lkSzem�lyek].[F�oszt�ly],"")="",[lkKil�p�Uni�].[F�oszt�ly],[lkSzem�lyek].[F�oszt�ly]) AS F�oszt, IIf(Nz([lkSzem�lyek].[oszt�ly],"")="",[lkKil�p�Uni�].[oszt�ly],[lkSzem�lyek].[oszt�ly]) AS Oszt, tKSZDRhib�k.N�v, tKSZDRhib�k.Ad�sz�m, tKSZDRhib�k.[KSZDR hi�nyz� adat], tKSZDRhib�k.Megold�sok, lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)]
FROM lkKil�p�Uni� RIGHT JOIN (lkSzem�lyek RIGHT JOIN tKSZDRhib�k ON lkSzem�lyek.Ad�jel = tKSZDRhib�k.Ad�sz�m) ON lkKil�p�Uni�.Ad�jel = tKSZDRhib�k.Ad�sz�m;

-- [lkktR�giHib�kInt�zked�sekLegutols�Int�zked�s]
SELECT lkktR�giHib�kInt�zked�sekUtols�Int�zked�s.HASH, lkktR�giHib�kInt�zked�sekUtols�Int�zked�s.azInt�zked�sek, lkktR�giHib�kInt�zked�sekUtols�Int�zked�s.Int�zked�sD�tuma, lkktR�giHib�kInt�zked�sekUtols�Int�zked�s.azIntFajta, lkktR�giHib�kInt�zked�sekUtols�Int�zked�s.r�gz�t�sD�tuma, lkktR�giHib�kInt�zked�sekUtols�Int�zked�s.Hivatkoz�s, lkktR�giHib�kInt�zked�sekUtols�Int�zked�s.Int�zked�sFajta
FROM lkktR�giHib�kInt�zked�sekUtols�Int�zked�s
WHERE (((lkktR�giHib�kInt�zked�sekUtols�Int�zked�s.azInt�zked�sek)=(SELECT top 1 First(Tmp.azInt�zked�sek) AS FirstOfazInt�zked�sek
FROM lkktR�giHib�kInt�zked�sekUtols�Int�zked�s AS Tmp
WHERE (((Tmp.Hash)=[lkktR�giHib�kInt�zked�sekUtols�Int�zked�s].[hash]))
GROUP BY Tmp.Int�zked�sD�tuma, Tmp.r�gz�t�sD�tuma
ORDER BY Tmp.Int�zked�sD�tuma DESC , Tmp.r�gz�t�sD�tuma DESC
)));

-- [lkktR�giHib�kInt�zked�sekUtols�Int�zked�s]
SELECT ktR�giHib�kInt�zked�sek.HASH, ktR�giHib�kInt�zked�sek.azInt�zked�sek, lkInt�zked�sek.Int�zked�sD�tuma, lkInt�zked�sek.azIntFajta, ktR�giHib�kInt�zked�sek.r�gz�t�sD�tuma, lkInt�zked�sek.Hivatkoz�s, lkInt�zked�sek.Int�zked�sFajta
FROM lkInt�zked�sek INNER JOIN ktR�giHib�kInt�zked�sek ON lkInt�zked�sek.azInt�zked�sek = ktR�giHib�kInt�zked�sek.azInt�zked�sek;

-- [lkLakc�mek]
SELECT DISTINCT lkSzem�lyek.Ad�jel, Trim(Replace(IIf(Len(Nz([Tart�zkod�si lakc�m],Nz([�lland� lakc�m],"")))<2,Nz([�lland� lakc�m],""),Nz([Tart�zkod�si lakc�m],Nz([�lland� lakc�m],""))),"Magyarorsz�g,","")) AS C�m, lkSzem�lyek.[�lland� lakc�m], lkSzem�lyek.[Tart�zkod�si lakc�m], IIf(IsNumeric(Left([C�m],1)),Left([C�m],4),0)*1 AS Irsz
FROM lkSzem�lyek;

-- [lkLakt�mFluktu�ci�Lista01]
SELECT N�([tKorm�nyhivatali_�llom�ny].[Ad�azonos�t�],"-") AS [Ad�azonos�t� jel], tKorm�nyhivatali_�llom�ny.N�v, tKorm�nyhivatali_�llom�ny.Mez�6 AS F�oszt�ly, tHaviJelent�sHat�lya.hat�lya, Year([MaxOfhat�lya]) & ". " & Right("0" & Month([MaxOfhat�lya]),2) & "." AS [Utols� teljes h�napja a f�oszt�lyon]
FROM (SELECT tKorm�nyhivatali_�llom�ny.Ad�azonos�t�, Max(tHaviJelent�sHat�lya.hat�lya) AS MaxOfhat�lya FROM tKorm�nyhivatali_�llom�ny INNER JOIN tHaviJelent�sHat�lya ON tKorm�nyhivatali_�llom�ny.hat�lyaID = tHaviJelent�sHat�lya.hat�lyaID WHERE (((tKorm�nyhivatali_�llom�ny.Mez�6)="Lak�st�mogat�si F�oszt�ly")) GROUP BY tKorm�nyhivatali_�llom�ny.Ad�azonos�t�)  AS MaxLakt�m RIGHT JOIN (tKorm�nyhivatali_�llom�ny INNER JOIN tHaviJelent�sHat�lya ON tKorm�nyhivatali_�llom�ny.hat�lyaID = tHaviJelent�sHat�lya.hat�lyaID) ON MaxLakt�m.Ad�azonos�t� = tKorm�nyhivatali_�llom�ny.Ad�azonos�t�
WHERE (((N�(tKorm�nyhivatali_�llom�ny.Ad�azonos�t�,"-"))<>"-") And ((tKorm�nyhivatali_�llom�ny.Mez�6)="Lak�st�mogat�si F�oszt�ly") And ((tHaviJelent�sHat�lya.hat�lyaID)=47));

-- [lkLakt�mFluktu�ci�Lista02]
SELECT lkSzem�lyek.[Ad�azonos�t� jel], N�([F�oszt�ly],"Kil�pett: " & [Jogviszony v�ge (kil�p�s d�tuma)]) AS [Jelenlegi szervezeti egys�ge]
FROM lkSzem�lyek;

-- [lkLakt�mFluktu�ci�Lista03]
SELECT lkLakt�mFluktu�ci�Lista01.[Ad�azonos�t� jel], lkLakt�mFluktu�ci�Lista01.N�v, lkLakt�mFluktu�ci�Lista01.F�oszt�ly, lkLakt�mFluktu�ci�Lista01.hat�lya, lkLakt�mFluktu�ci�Lista01.[Utols� teljes h�napja a f�oszt�lyon], lkLakt�mFluktu�ci�Lista02.[Jelenlegi szervezeti egys�ge]
FROM lkLakt�mFluktu�ci�Lista01 LEFT JOIN lkLakt�mFluktu�ci�Lista02 ON lkLakt�mFluktu�ci�Lista01.[Ad�azonos�t� jel] = lkLakt�mFluktu�ci�Lista02.[Ad�azonos�t� jel];

-- [lkLakt�mFluktu�ci�Lista04]
SELECT lkSzem�lyek.[Ad�azonos�t� jel], lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, IIf([Jogviszony v�ge (kil�p�s d�tuma)] Is Null,Year([Jogviszony v�ge (kil�p�s d�tuma)]) & ". " & Right("0" & Month([Jogviszony v�ge (kil�p�s d�tuma)]),2) & ".",Year(Now()) & ". " & Right("0" & Month(Now()),2) & ".") AS [Utols� teljes h�napja a f�oszt�lyon], lkSzem�lyek.F�oszt�ly AS [Jelenlegi szervezeti egys�ge]
FROM lkSzem�lyek LEFT JOIN tmpLakt�mFluktu�ci�Lista ON lkSzem�lyek.Ad�jel = tmpLakt�mFluktu�ci�Lista.[Ad�azonos�t� jel]
WHERE (((lkSzem�lyek.F�oszt�ly) Like "Lak�s*") AND ((tmpLakt�mFluktu�ci�Lista.[Ad�azonos�t� jel]) Is Null));

-- [lkLegkor�bbiKinevez�s]
SELECT tSzem�lyek.[Ad�azonos�t� jel], Min(tSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)]) AS [Els� bel�p�se]
FROM tSzem�lyek
WHERE (((tSzem�lyek.[Szerz�d�s/kinevez�s verzi�_�rv�nyess�g kezdete])>0))
GROUP BY tSzem�lyek.[Ad�azonos�t� jel];

-- [lkLegmagasabbV�gzetts�g05]
SELECT tLegmagasabbV�gzetts�g04.[Dolgoz� azonos�t�], First(tLegmagasabbV�gzetts�g04.azFok) AS FirstOfazFok
FROM tLegmagasabbV�gzetts�g04
GROUP BY tLegmagasabbV�gzetts�g04.[Dolgoz� azonos�t�]
ORDER BY tLegmagasabbV�gzetts�g04.[Dolgoz� azonos�t�], First(tLegmagasabbV�gzetts�g04.azFok) DESC;

-- [lkLegr�gibbHib�k]
SELECT tR�giHib�k.[M�sodik mez�], tR�giHib�k.[Els� Id�pont]
FROM tR�giHib�k
WHERE ((((select max([utols� id�pont]) from tR�giHib�k ))=[Utols� Id�pont]))
GROUP BY tR�giHib�k.[M�sodik mez�], tR�giHib�k.[Els� Id�pont], tR�giHib�k.[Utols� Id�pont]
ORDER BY tR�giHib�k.[Els� Id�pont];

-- [lkLegr�gibbHib�k_akt�v_statisztika]
SELECT TOP 10 ffsplit([M�sodik mez�],"|",1) AS F�oszt�ly, Count(tR�giHib�k.[Els� Id�pont]) AS [Sz�ks�ges int�zked�sek sz�ma]
FROM lkktR�giHib�kInt�zked�sekLegutols�Int�zked�s RIGHT JOIN tR�giHib�k ON lkktR�giHib�kInt�zked�sekLegutols�Int�zked�s.HASH = tR�giHib�k.[Els� mez�]
WHERE ((((select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve <>"lk�res�ll�shelyek�llapotfelm�r�" And lek�rdez�sneve <>"lkFontosHi�nyz�Adatok02"))=[Utols� Id�pont]) AND ((lkktR�giHib�kInt�zked�sekLegutols�Int�zked�s.Int�zked�sFajta)="referens beavatkoz�s�t ig�nyli" Or (lkktR�giHib�kInt�zked�sekLegutols�Int�zked�s.Int�zked�sFajta) Is Null Or (lkktR�giHib�kInt�zked�sekLegutols�Int�zked�s.Int�zked�sFajta)="hiba") AND ((tR�giHib�k.lek�rdez�sNeve)<>"lk�res�ll�shelyek�llapotfelm�r�"))
GROUP BY ffsplit([M�sodik mez�],"|",1)
ORDER BY Count(tR�giHib�k.[Els� Id�pont]) DESC;

-- [lkLegr�gibbHib�k_akt�v_statisztika_el�k�sz�t�s]
SELECT Replace(ffsplit([M�sodik mez�],"|",1),"Budapest F�v�ros Korm�nyhivatala","BFKH") AS F�oszt�ly, tR�giHib�k.[M�sodik mez�], tR�giHib�k.[Els� Id�pont], tR�giHib�k.[Utols� Id�pont]
FROM lkktR�giHib�kInt�zked�sekLegutols�Int�zked�s RIGHT JOIN tR�giHib�k ON lkktR�giHib�kInt�zked�sekLegutols�Int�zked�s.HASH = tR�giHib�k.[Els� mez�]
WHERE ((((select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve <>"lk�res�ll�shelyek�llapotfelm�r�" And lek�rdez�sneve <>"lkFontosHi�nyz�Adatok02"))=[Utols� Id�pont]) AND ((lkktR�giHib�kInt�zked�sekLegutols�Int�zked�s.Int�zked�sFajta)="referens beavatkoz�s�t ig�nyli" Or (lkktR�giHib�kInt�zked�sekLegutols�Int�zked�s.Int�zked�sFajta) Is Null Or (lkktR�giHib�kInt�zked�sekLegutols�Int�zked�s.Int�zked�sFajta)="hiba") AND ((tR�giHib�k.lek�rdez�sNeve)<>"lk�res�ll�shelyek�llapotfelm�r�" And (tR�giHib�k.lek�rdez�sNeve)<>"lkFontosHi�nyz�Adatok02"))
ORDER BY tR�giHib�k.[Els� Id�pont];

-- [lkLegr�gibbHib�k_akt�v_statisztika2]
SELECT lkLegr�gibbHib�k_akt�v_statisztika_el�k�sz�t�s.F�oszt�ly, Round(Max([Utols� Id�pont]-[Els� Id�pont]),0) AS [Legr�gebbi hiba (nap)], Round(Avg([Utols� id�pont]-[Els� Id�pont]),0) AS [�tlag (nap)], Count(lkLegr�gibbHib�k_akt�v_statisztika_el�k�sz�t�s.[Els� Id�pont]) AS [Hib�k sz�ma (db)], Round(Sum([Utols� id�pont]-[Els� Id�pont]),0) AS S�lyoss�g
FROM lkLegr�gibbHib�k_akt�v_statisztika_el�k�sz�t�s
GROUP BY lkLegr�gibbHib�k_akt�v_statisztika_el�k�sz�t�s.F�oszt�ly
ORDER BY Round(Max([Utols� Id�pont]-[Els� Id�pont]),0) DESC , Round(Sum([Utols� id�pont]-[Els� Id�pont]),0) DESC , Count(lkLegr�gibbHib�k_akt�v_statisztika_el�k�sz�t�s.[Els� Id�pont]) DESC;

-- [lkLegr�gibbHib�k_akt�v_statisztika3]
SELECT lkLegr�gibbHib�k_akt�v_statisztika_el�k�sz�t�s.F�oszt�ly, Round(Max(([Utols� id�pont]-[Els� Id�pont])),0) AS [Legr�gebbi hiba (nap)], Round(Avg([Utols� id�pont]-[Els� Id�pont]),0) AS [�tlag (nap)], Count(lkLegr�gibbHib�k_akt�v_statisztika_el�k�sz�t�s.[Els� Id�pont]) AS [Hib�k sz�ma (db)], Round(Sum([Utols� id�pont]-[Els� Id�pont]),0) AS S�lyoss�g
FROM lkLegr�gibbHib�k_akt�v_statisztika_el�k�sz�t�s
GROUP BY lkLegr�gibbHib�k_akt�v_statisztika_el�k�sz�t�s.F�oszt�ly
HAVING (((Round(Sum([Utols� id�pont]-[Els� Id�pont]),0))>=1000))
ORDER BY Round(Sum([Utols� id�pont]-[Els� Id�pont]),0) DESC , Count(lkLegr�gibbHib�k_akt�v_statisztika_el�k�sz�t�s.[Els� Id�pont]) DESC , Round(Avg([Utols� id�pont]-[Els� Id�pont]),0) DESC;

-- [lkLegr�gibbHib�k_statisztika]
SELECT TOP 100 ffsplit([M�sodik mez�],"|",1) AS F�oszt�ly, Count(lkLegr�gibbHib�k_statisztika_el�k�sz�t�s.[Els� Id�pont]) AS [Sz�ks�ges int�zked�sek sz�ma]
FROM lkLegr�gibbHib�k_statisztika_el�k�sz�t�s
GROUP BY ffsplit([M�sodik mez�],"|",1)
ORDER BY Count(lkLegr�gibbHib�k_statisztika_el�k�sz�t�s.[Els� Id�pont]) DESC;

-- [lkLegr�gibbHib�k_statisztika_el�k�sz�t�s]
SELECT tR�giHib�k.[M�sodik mez�], tR�giHib�k.[Els� Id�pont]
FROM tR�giHib�k
WHERE ((((select max([utols� id�pont]) from tR�giHib�k ))=[Utols� Id�pont]) AND (((select min([els� id�pont]) from lkLegr�gibbHib�k ))=[Els� Id�pont]))
GROUP BY tR�giHib�k.[M�sodik mez�], tR�giHib�k.[Els� Id�pont], tR�giHib�k.[Utols� Id�pont]
ORDER BY tR�giHib�k.[Els� Id�pont];

-- [lkLegr�gibbHib�k_teljes_statisztika]
SELECT TOP 10 ffsplit([M�sodik mez�],"|",1) AS F�oszt�ly, Count(lkLegr�gibbHib�k.[Els� Id�pont]) AS [Sz�ks�ges int�zked�sek sz�ma]
FROM lkLegr�gibbHib�k
GROUP BY ffsplit([M�sodik mez�],"|",1)
ORDER BY Count(lkLegr�gibbHib�k.[Els� Id�pont]) DESC;

-- [lkLehethogyJogosultakUtaz�siKedvezm�nyre]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.Ad�jel, "F�osztR�v_" & [lkszem�lyek].[Dolgoz� teljes neve] & "_(" & [azNexon] & ")_utaz�si.pdf" AS F�jln�v
FROM lkSzem�lyek INNER JOIN (kt_azNexon_Ad�jel02 INNER JOIN (lkBiztosanJogosultakUtaz�siKedvezm�nyre RIGHT JOIN (SELECT lkFordul�napt�lABel�p�sigEl�z�MunkahelyMunkanapjai.Ad�jel, lkFordul�napt�lABel�p�sigEl�z�MunkahelyMunkanapjai.Napok
FROM lkFordul�napt�lABel�p�sigEl�z�MunkahelyMunkanapjai
UNION SELECT lkFordul�napt�lEgy�vigMindenJogviszonyMunkanapjai.Ad�jel, lkFordul�napt�lEgy�vigMindenJogviszonyMunkanapjai.Napok
FROM lkFordul�napt�lEgy�vigMindenJogviszonyMunkanapjai)  AS UNI� ON lkBiztosanJogosultakUtaz�siKedvezm�nyre.Ad�jel = UNI�.Ad�jel) ON kt_azNexon_Ad�jel02.Ad�jel = UNI�.Ad�jel) ON lkSzem�lyek.Ad�jel = UNI�.Ad�jel
WHERE (((lkBiztosanJogosultakUtaz�siKedvezm�nyre.Ad�jel) Is Null))
GROUP BY lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.Ad�jel, "F�osztR�v_" & [lkszem�lyek].[Dolgoz� teljes neve] & "_(" & [azNexon] & ")_utaz�si.pdf", lkSzem�lyek.BFKH
HAVING (((Sum(UNI�.Napok))>=365))
ORDER BY lkSzem�lyek.BFKH, lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkLej�r�Hat�rid�k]
SELECT tLej�r�Hat�rid�k.[Szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szervezeti egys�g], tLej�r�Hat�rid�k.[Szervezeti szint sz�ma-neve], tLej�r�Hat�rid�k.[Jogviszony t�pus], dt�tal([tLej�r�Hat�rid�k].[Jogviszony kezdete]) AS [Jogviszony kezdete], dt�tal([tLej�r�Hat�rid�k].[Jogviszony v�ge]) AS [Jogviszony v�ge], tLej�r�Hat�rid�k.[Dolgoz� neve], tLej�r�Hat�rid�k.[Ad�azonos�t� jel], tLej�r�Hat�rid�k.[Figyelend� d�tum t�pusa], dt�tal([tLej�r�Hat�rid�k].[Figyelend� d�tum]) AS [Figyelend� d�tum], tLej�r�Hat�rid�k.[Szint 1 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 1 szervezeti egys�g n�v], tLej�r�Hat�rid�k.[Szint 2 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 2 szervezeti egys�g n�v], tLej�r�Hat�rid�k.[Szint 3 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 3 szervezeti egys�g n�v], tLej�r�Hat�rid�k.[Szint 4 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 4 szervezeti egys�g n�v], tLej�r�Hat�rid�k.[Szint 5 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 5 szervezeti egys�g n�v], tLej�r�Hat�rid�k.[Szint 6 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 6 szervezeti egys�g n�v], tLej�r�Hat�rid�k.[Szint 7 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 7 szervezeti egys�g n�v], tLej�r�Hat�rid�k.[Szint 8 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 8 szervezeti egys�g n�v], tLej�r�Hat�rid�k.[Szint 9 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 9 szervezeti egys�g n�v], tLej�r�Hat�rid�k.[Szint 10 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 10 szervezeti egys�g n�v]
FROM tLej�r�Hat�rid�k;

-- [lkLej�r�Hat�rid�k1]
SELECT tLej�r�Hat�rid�k.[Szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szervezeti egys�g], tLej�r�Hat�rid�k.[Szervezeti szint sz�ma-neve], tLej�r�Hat�rid�k.[Jogviszony t�pus], dt�tal([tLej�r�Hat�rid�k].[Jogviszony kezdete]) AS [Jogviszony kezdete], dt�tal([tLej�r�Hat�rid�k].[Jogviszony v�ge]) AS [Jogviszony v�ge], tLej�r�Hat�rid�k.[Dolgoz� neve], tLej�r�Hat�rid�k.[Ad�azonos�t� jel], tLej�r�Hat�rid�k.[Figyelend� d�tum t�pusa], dt�tal([tLej�r�Hat�rid�k].[Figyelend� d�tum]) AS [Figyelend� d�tum], tLej�r�Hat�rid�k.[Szint 1 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 1 szervezeti egys�g n�v], tLej�r�Hat�rid�k.[Szint 2 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 2 szervezeti egys�g n�v], tLej�r�Hat�rid�k.[Szint 3 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 3 szervezeti egys�g n�v], tLej�r�Hat�rid�k.[Szint 4 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 4 szervezeti egys�g n�v], tLej�r�Hat�rid�k.[Szint 5 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 5 szervezeti egys�g n�v], tLej�r�Hat�rid�k.[Szint 6 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 6 szervezeti egys�g n�v], tLej�r�Hat�rid�k.[Szint 7 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 7 szervezeti egys�g n�v], tLej�r�Hat�rid�k.[Szint 8 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 8 szervezeti egys�g n�v], tLej�r�Hat�rid�k.[Szint 9 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 9 szervezeti egys�g n�v], tLej�r�Hat�rid�k.[Szint 10 szervezeti egys�g k�d], tLej�r�Hat�rid�k.[Szint 10 szervezeti egys�g n�v]
FROM tLej�r�Hat�rid�k;

-- [lkLej�rtAlkalmass�gi�rv�nyess�g]
SELECT lkSzem�lyek.F�oszt�ly AS F�oszt�ly, lkSzem�lyek.Oszt�ly AS Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[Orvosi vizsg�lat k�vetkez� id�pontja], kt_azNexon_Ad�jel02.NLink AS NLink
FROM kt_azNexon_Ad�jel02 RIGHT JOIN lkSzem�lyek ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[Orvosi vizsg�lat k�vetkez� id�pontja])<DateSerial(Year(Date()),Month(Date())-11,1)-1) AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null) AND ((lkSzem�lyek.[st�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.BFKH;

-- [lkLej�rtAlkalmass�gi�rv�nyess�g1]
SELECT lkSzem�lyek.F�oszt�ly AS F�oszt�ly, lkSzem�lyek.Oszt�ly AS Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[Orvosi vizsg�lat k�vetkez� id�pontja], kt_azNexon_Ad�jel02.NLink AS NLink
FROM kt_azNexon_Ad�jel02 RIGHT JOIN lkSzem�lyek ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[Orvosi vizsg�lat k�vetkez� id�pontja])<DateSerial(Year(Date()),Month(Date())-11,1)-1) AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null) AND ((lkSzem�lyek.[st�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.BFKH;

-- [lkLek�rdez�sekMez�inekSz�ma]
SELECT lkEllen�rz�Lek�rdez�sek2.Ellen�rz�Lek�rdez�s, Count(MSysQueries.Attribute) AS CountOfAttribute
FROM lkEllen�rz�Lek�rdez�sek2 INNER JOIN (MSysObjects INNER JOIN MSysQueries ON MSysObjects.Id = MSysQueries.ObjectId) ON lkEllen�rz�Lek�rdez�sek2.Ellen�rz�Lek�rdez�s = MSysObjects.Name
WHERE (((MSysQueries.Attribute)=6) AND ((lkEllen�rz�Lek�rdez�sek2.Kimenet)=True))
GROUP BY lkEllen�rz�Lek�rdez�sek2.Ellen�rz�Lek�rdez�s;

-- [lkLek�rdez�sekT�pusokCsoportok]
SELECT nSelect([Ellen�rz�Lek�rdez�s]) AS db, tLek�rdez�sT�pusok.Oszt�ly, tLek�rdez�sT�pusok.LapN�v, tLek�rdez�sT�pusok.Megjegyz�s, tEllen�rz�Lek�rdez�sek.Ellen�rz�Lek�rdez�s, tUnionCsoportok.azUnion
FROM tUnionCsoportok RIGHT JOIN (tLek�rdez�sT�pusok RIGHT JOIN tEllen�rz�Lek�rdez�sek ON tLek�rdez�sT�pusok.azET�pus = tEllen�rz�Lek�rdez�sek.azET�pus) ON tUnionCsoportok.azUnion = tEllen�rz�Lek�rdez�sek.azUnion
ORDER BY tLek�rdez�sT�pusok.Oszt�ly, tLek�rdez�sT�pusok.LapN�v;

-- [lkLek�rdez�sekT�pusokCsoportok_allek�rdez�sCsoportokSz�ma]
SELECT Count(DistinctlkLek�rdez�sekT�pusokCsoportok.azUnion) AS AlLek�rdez�sCsoportokSz�ma
FROM (SELECT DISTINCT lkLek�rdez�sekT�pusokCsoportok.[azUnion] FROM lkLek�rdez�sekT�pusokCsoportok WHERE (((lkLek�rdez�sekT�pusokCsoportok.[azUnion]) Is Not Null)))  AS DistinctlkLek�rdez�sekT�pusokCsoportok;

-- [lkLek�rdez�sT�pusok]
SELECT tLek�rdez�sT�pusok.azET�pus, tLek�rdez�sT�pusok.LapN�v AS Fejezet, tLek�rdez�sOszt�lyok.Oszt�ly AS Oldal, tLek�rdez�sT�pusok.Sorrend, tLek�rdez�sT�pusok.Megjegyz�s, tLek�rdez�sT�pusok.vbaPostProcessing, tLek�rdez�sT�pusok.azVisszajelz�sT�pusCsoport, tLek�rdez�sOszt�lyok.Sorrend
FROM tLek�rdez�sOszt�lyok INNER JOIN tLek�rdez�sT�pusok ON tLek�rdez�sOszt�lyok.azOszt�ly = tLek�rdez�sT�pusok.Oszt�ly
ORDER BY tLek�rdez�sOszt�lyok.Oszt�ly, tLek�rdez�sOszt�lyok.Sorrend, IIf([tLek�rdez�sT�pusok].[Sorrend] Is Null,999,[tLek�rdez�sT�pusok].[Sorrend]), tLek�rdez�sT�pusok.LapN�v;

-- [lkL�treNemJ�ttJogviszony]
SELECT DISTINCT lkKil�p�Uni�.Ad�azonos�t�, kt_azNexon_Ad�jel02.azNexon, "?" AS [Jogviszony sorsz�ma]
FROM lkKil�p�Uni� LEFT JOIN kt_azNexon_Ad�jel02 ON lkKil�p�Uni�.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel
WHERE (((lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek oka: jogszab�lyi hiva])="L�tre nem j�tt jogviszony") AND ((lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek oka: jogszab�lyi hiva])>=DateSerial(Year(Date()),1,1)));

-- [lkL�treNemJ�ttJogviszony_SMAX]
SELECT DISTINCT tSzem�lyek.Ad�jel, kt_azNexon_Ad�jel.azNexon, tSzem�lyek.[Jogviszony sorsz�ma]
FROM kt_azNexon_Ad�jel INNER JOIN tSzem�lyek ON kt_azNexon_Ad�jel.Ad�jel = tSzem�lyek.Ad�jel
WHERE (((tSzem�lyek.[HR kapcsolat megsz�n�s m�dja (Kil�p�s m�dja)])="L�tre nem j�tt jogviszony"));

-- [lkL�tsz�mBel�p�sKi�p�sJogviszony]
SELECT tSzem�lyek.[St�tusz t�pusa], tSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus] AS Jogviszony, tSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS Bel�p�s, IIf(dt�tal([Jogviszony v�ge (kil�p�s d�tuma)])=0,#1/1/3000#,dt�tal([Jogviszony v�ge (kil�p�s d�tuma)])) AS Kil�p�s, 1 AS L�tsz�m
FROM tSzem�lyek
WHERE (((tSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])<>"Szem�lyes jelenl�t" And (tSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])<>"Megb�z�sos"));

-- [lkL�tsz�mBesorol�sonk�ntHavib�lAlapl�tsz�m]
SELECT lk_Havib�l�ll�shelyek.T�bla AS Z�na, lk_Havib�l�ll�shelyek.[Az �ll�shely megynevez�se] AS Besorol�s_bemenet, lk_Havib�l�ll�shelyek.[�ll�shely sz�ma] AS Nexonban
FROM lk_Havib�l�ll�shelyek
WHERE (((lk_Havib�l�ll�shelyek.T�bla)="Alapl�tsz�m"))
ORDER BY lk_Havib�l�ll�shelyek.Azonos�t�;

-- [lkL�tsz�mBesorol�sonk�ntHavib�lAlapl�tsz�m�ssz]
SELECT lkL�tsz�mBesorol�sonk�ntHavib�lAlapl�tsz�m.Z�na, "Alapl�tsz�m �sszesen:" AS Besorol�s_bemenet, Sum(lkL�tsz�mBesorol�sonk�ntHavib�lAlapl�tsz�m.Nexonban) AS SumOfNexonban
FROM lkL�tsz�mBesorol�sonk�ntHavib�lAlapl�tsz�m
GROUP BY lkL�tsz�mBesorol�sonk�ntHavib�lAlapl�tsz�m.Z�na, "Alapl�tsz�m �sszesen:";

-- [lkL�tsz�mBesorol�sonk�ntHavib�lK�zpontos�tott]
SELECT lk_Havib�l�ll�shelyek.T�bla AS Z�na, lk_Havib�l�ll�shelyek.[Az �ll�shely megynevez�se] AS Besorol�s_bemenet, lk_Havib�l�ll�shelyek.[�ll�shely sz�ma] AS Nexonban
FROM lk_Havib�l�ll�shelyek
WHERE (((lk_Havib�l�ll�shelyek.T�bla)="K�zpontos�tott"))
ORDER BY lk_Havib�l�ll�shelyek.Azonos�t�;

-- [lkL�tsz�mBesorol�sonk�ntHavib�lK�zpontos�tott�ssz]
SELECT lkL�tsz�mBesorol�sonk�ntHavib�lK�zpontos�tott.Z�na, "K�zpontos�tott �sszesen:" AS Besorol�s_bemenet, Sum(lkL�tsz�mBesorol�sonk�ntHavib�lK�zpontos�tott.Nexonban) AS SumOfNexonban
FROM lkL�tsz�mBesorol�sonk�ntHavib�lK�zpontos�tott
GROUP BY lkL�tsz�mBesorol�sonk�ntHavib�lK�zpontos�tott.Z�na, "K�zpontos�tott �sszesen:";

-- [lkL�tsz�mBesorol�sonk�ntHavib�lMind�sszesen]
SELECT "Mind�sszesen" AS Z�na, lkL�tsz�mBesorol�sonk�ntHavib�lAlapl�tsz�m�sK�zpontos�tott.Besorol�s_bemenet, Sum(lkL�tsz�mBesorol�sonk�ntHavib�lAlapl�tsz�m�sK�zpontos�tott.Nexonban) AS SumOfNexonban
FROM (SELECT lkL�tsz�mBesorol�sonk�ntHavib�lK�zpontos�tott.Z�na, lkL�tsz�mBesorol�sonk�ntHavib�lK�zpontos�tott.Besorol�s_bemenet, lkL�tsz�mBesorol�sonk�ntHavib�lK�zpontos�tott.Nexonban
FROM lkL�tsz�mBesorol�sonk�ntHavib�lK�zpontos�tott
UNION
SELECT lkL�tsz�mBesorol�sonk�ntHavib�lAlapl�tsz�m.Z�na, lkL�tsz�mBesorol�sonk�ntHavib�lAlapl�tsz�m.Besorol�s_bemenet, lkL�tsz�mBesorol�sonk�ntHavib�lAlapl�tsz�m.Nexonban
FROM lkL�tsz�mBesorol�sonk�ntHavib�lAlapl�tsz�m
)  AS lkL�tsz�mBesorol�sonk�ntHavib�lAlapl�tsz�m�sK�zpontos�tott
GROUP BY "Mind�sszesen", lkL�tsz�mBesorol�sonk�ntHavib�lAlapl�tsz�m�sK�zpontos�tott.Besorol�s_bemenet;

-- [lkL�tsz�mBesorol�sonk�ntHavib�lMind�sszesen�ssz]
SELECT lkL�tsz�mBesorol�sonk�ntHavib�lMind�sszesen.Z�na, "Mind�sszesen �sszesen:" AS Besorol�s_bemenet, Sum(lkL�tsz�mBesorol�sonk�ntHavib�lMind�sszesen.SumOfNexonban) AS SumOfSumOfNexonban
FROM lkL�tsz�mBesorol�sonk�ntHavib�lMind�sszesen
GROUP BY lkL�tsz�mBesorol�sonk�ntHavib�lMind�sszesen.Z�na, "Mind�sszesen �sszesen:";

-- [lkL�tsz�mBesorol�sonk�ntHavib�lUNI�]
SELECT HatR�szesUni�.Sor, HatR�szesUni�.Z�na, tBesorol�sKonverzi�.�NYRb�l AS Besorol�s, HatR�szesUni�.Nexonban
FROM tBesorol�sKonverzi� INNER JOIN (SELECT *, 3 as Sor FROM lkL�tsz�mBesorol�sonk�ntHavib�lK�zpontos�tott  UNION SELECT *, 5 as Sor FROM lkL�tsz�mBesorol�sonk�ntHavib�lMind�sszesen  UNION SELECT *, 1 as Sor FROM lkL�tsz�mBesorol�sonk�ntHavib�lAlapl�tsz�m  UNION SELECT *, 2 as Sor FROM lkL�tsz�mBesorol�sonk�ntHavib�lAlapl�tsz�m�ssz  UNION SELECT *, 4 as Sor FROM lkL�tsz�mBesorol�sonk�ntHavib�lK�zpontos�tott�ssz  UNION SELECT *, 6 as Sor FROM lkL�tsz�mBesorol�sonk�ntHavib�lMind�sszesen�ssz )  AS HatR�szesUni� ON tBesorol�sKonverzi�.Havib�l=HatR�szesUni�.Besorol�s_bemenet;

-- [lkL�tsz�mEnged�llyelVal��sszevet�s_Eredm�ny]
SELECT (Select max(Sorsz�mEng) From tEnged�llyelVal��sszevet�sT�bla)-[Sorsz�mEng]+(IIf([tEnged�llyelVal��sszevet�sT�bla].[Z�na]="Alapl�tsz�m",0,IIf([tEnged�llyelVal��sszevet�sT�bla].[z�na]="K�zpontos�tott",12,24))) AS Sorsz�m, tEnged�llyelVal��sszevet�sT�bla.Magyar�zat, tEnged�llyelVal��sszevet�sT�bla.Z�na AS Keret, tEnged�llyelVal��sszevet�sT�bla.Besorol�s_bemenet AS Besorol�s, tEnged�llyelVal��sszevet�sT�bla.Enged�lyezett, tEnged�llyelVal��sszevet�sT�bla.Bet�lt�tt, tEnged�llyelVal��sszevet�sT�bla.�res, tEnged�llyelVal��sszevet�sT�bla.[�sszes �ll�shely], ([Nexonban]) AS [Nexonban �sszesen], ([�sszes �ll�shely]-[Nexonban]) AS Elt�r�s
FROM lkL�tsz�mBesorol�sonk�ntHavib�lUNI� RIGHT JOIN tEnged�llyelVal��sszevet�sT�bla ON (lkL�tsz�mBesorol�sonk�ntHavib�lUNI�.Besorol�s = tEnged�llyelVal��sszevet�sT�bla.Besorol�s_bemenet) AND (lkL�tsz�mBesorol�sonk�ntHavib�lUNI�.Z�na = tEnged�llyelVal��sszevet�sT�bla.Z�na);

-- [lkL�tsz�m�sTTOszt�lyonk�nt01]
SELECT Replace([J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH") AS [Hivatal\F�oszt�ly], Uni�.Oszt�ly, 1 AS L�tsz�m, fvCaseSelect(Nz([Jogc�me],"-"),"-",0,"Mentes�t�s munk�ltat� enged�lye alapj�n",0,"",0,Null,1)*1 AS TT, bfkh([BFKHk�d]) AS bfkh
FROM (SELECT J�r�si_�llom�ny.Ad�azonos�t�, J�r�si_�llom�ny.N�v, J�r�si_�llom�ny.[J�r�si Hivatal], J�r�si_�llom�ny.Mez�7 as Oszt�ly, J�r�si_�llom�ny.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp] as Jogc�me, Mez�10 as Kinevez�s,[�NYR SZERVEZETI EGYS�G AZONOS�T�] as BFKHk�d
FROM J�r�si_�llom�ny

UNION
SELECT Korm�nyhivatali_�llom�ny.Ad�azonos�t�, Korm�nyhivatali_�llom�ny.N�v, Korm�nyhivatali_�llom�ny.Mez�6, Korm�nyhivatali_�llom�ny.Mez�7, Korm�nyhivatali_�llom�ny.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], Mez�10, [�NYR SZERVEZETI EGYS�G AZONOS�T�]
FROM  Korm�nyhivatali_�llom�ny

UNION 
SELECT K�zpontos�tottak.Ad�azonos�t�, K�zpontos�tottak.N�v, K�zpontos�tottak.Mez�6, K�zpontos�tottak.Mez�7, K�zpontos�tottak.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp],Mez�11, [Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�]
FROM   K�zpontos�tottak

)  AS Uni�
ORDER BY bfkh([BFKHk�d]);

-- [lkL�tsz�m�sTTOszt�lyonk�nt02]
SELECT lkL�tsz�m�sTTOszt�lyonk�nt01.bfkh, lkL�tsz�m�sTTOszt�lyonk�nt01.[Hivatal\F�oszt�ly], lkL�tsz�m�sTTOszt�lyonk�nt01.Oszt�ly, Sum(lkL�tsz�m�sTTOszt�lyonk�nt01.L�tsz�m) AS L�tsz�m, Sum(lkL�tsz�m�sTTOszt�lyonk�nt01.TT) AS TT, [TT]/[L�tsz�m] AS Ar�ny
FROM lkL�tsz�m�sTTOszt�lyonk�nt01
GROUP BY lkL�tsz�m�sTTOszt�lyonk�nt01.bfkh, lkL�tsz�m�sTTOszt�lyonk�nt01.[Hivatal\F�oszt�ly], lkL�tsz�m�sTTOszt�lyonk�nt01.Oszt�ly;

-- [lkL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt20230101]
SELECT lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2023.F�oszt�ly, lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2023.Oszt�ly, 0 AS TTL�tsz�m2021, 0 AS TTL�tsz�m2022, 0 AS TTL�tsz�m2023, Sum(lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2023.L�tsz�m2023) AS SumOfL�tsz�m2023
FROM lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2023
GROUP BY lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2023.F�oszt�ly, lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2023.Oszt�ly, 0, 0, 0;

-- [lkL�tsz�mMinden�vUtols�Napj�n]
SELECT Year([hat�lya]) AS �v, Count(lk�llom�nyt�bl�kT�rt�netiUni�ja.Ad�azonos�t�) AS CountOfAd�azonos�t�
FROM lk�llom�nyt�bl�kT�rt�netiUni�ja INNER JOIN tHaviJelent�sHat�lya1 ON lk�llom�nyt�bl�kT�rt�netiUni�ja.hat�lyaID = tHaviJelent�sHat�lya1.hat�lyaID
WHERE (((Year([hat�lya])) Between 2019 And 2023) AND ((Month([hat�lya]))=12) AND ((Day([hat�lya]))=31) AND ((lk�llom�nyt�bl�kT�rt�netiUni�ja.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h]) Not Like "*TT*") AND ((lk�llom�nyt�bl�kT�rt�netiUni�ja.Ad�azonos�t�) Is Not Null) AND ((lk�llom�nyt�bl�kT�rt�netiUni�ja.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s") AND ((lk�llom�nyt�bl�kT�rt�netiUni�ja.F�oszt) Like Nz([F�oszt�ly_],"") & "*")) OR (((Year([hat�lya]))=2024) AND ((Month([hat�lya]))=9) AND ((Day([hat�lya]))=30) AND ((lk�llom�nyt�bl�kT�rt�netiUni�ja.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h]) Not Like "*TT*") AND ((lk�llom�nyt�bl�kT�rt�netiUni�ja.Ad�azonos�t�) Is Not Null) AND ((lk�llom�nyt�bl�kT�rt�netiUni�ja.[Sz�let�si �v \ �res �ll�s])<>"�res �ll�s") AND ((lk�llom�nyt�bl�kT�rt�netiUni�ja.F�oszt) Like Nz([F�oszt�ly_],"") & "*"))
GROUP BY Year([hat�lya]);

-- [lkL�tsz�mokNevezetesNapokon01]
SELECT lkKiemeltNapok.KiemeltNapok, lkL�tsz�mBel�p�sKi�p�sJogviszony.Jogviszony, Sum(lkL�tsz�mBel�p�sKi�p�sJogviszony.L�tsz�m) AS SumOfL�tsz�m
FROM lkL�tsz�mBel�p�sKi�p�sJogviszony, lkKiemeltNapok
WHERE (((lkKiemeltNapok.Nap)=IIf([h�]=1,31,28)) And ((lkKiemeltNapok.�v)=21) And (("######### A JOIN m�veletet sz�tszedi, ez�rt WHERE felt�telt haszn�lunk! #################")<>False) And ((lkKiemeltNapok.KiemeltNapok) Between lkL�tsz�mBel�p�sKi�p�sJogviszony.Bel�p�s And lkL�tsz�mBel�p�sKi�p�sJogviszony.Kil�p�s))
GROUP BY lkKiemeltNapok.KiemeltNapok, lkL�tsz�mBel�p�sKi�p�sJogviszony.Jogviszony, lkL�tsz�mBel�p�sKi�p�sJogviszony.L�tsz�m;

-- [lkL�tsz�mokNevezetesNapokon�rlaphoz01B]
SELECT lkKiemeltNapok.KiemeltNapok, lkL�tsz�mBel�p�sKi�p�sJogviszony.Jogviszony, Sum(lkL�tsz�mBel�p�sKi�p�sJogviszony.L�tsz�m) AS SumOfL�tsz�m
FROM lkL�tsz�mBel�p�sKi�p�sJogviszony, lkKiemeltNapok
WHERE (((lkL�tsz�mBel�p�sKi�p�sJogviszony.Jogviszony) Like [�rlapok]![�L�tsz�mKiemeltNapokonB]![Jogviszony] & "*") AND ((lkKiemeltNapok.Nap)=[�rlapok]![�L�tsz�mKiemeltNapokonB]![V�lasztottNap]) AND (("######### A JOIN m�veletet sz�tszedi, ez�rt WHERE felt�telt haszn�lunk! #################")<>False) AND ((lkKiemeltNapok.KiemeltNapok) Between [lkL�tsz�mBel�p�sKi�p�sJogviszony].[Bel�p�s] And [lkL�tsz�mBel�p�sKi�p�sJogviszony].[Kil�p�s]))
GROUP BY lkKiemeltNapok.KiemeltNapok, lkL�tsz�mBel�p�sKi�p�sJogviszony.Jogviszony, lkL�tsz�mBel�p�sKi�p�sJogviszony.L�tsz�m;

-- [lkL�tsz�mokNevezetesNapokon�rlaphoz02B]
SELECT lkL�tsz�mokNevezetesNapokon�rlaphoz01b.KiemeltNapok, lkL�tsz�mokNevezetesNapokon�rlaphoz01b.Jogviszony, lkL�tsz�mokNevezetesNapokon�rlaphoz01b.SumOfL�tsz�m
FROM lkL�tsz�mokNevezetesNapokon�rlaphoz01b
WHERE (((lkL�tsz�mokNevezetesNapokon�rlaphoz01b.KiemeltNapok) Between [�rlapok]![�L�tsz�mKiemeltNapokonB]![Kezd��v] And [�rlapok]![�L�tsz�mKiemeltNapokonB]![V�ge�v]));

-- [lkL�tsz�mStatisztika�sszetett]
SELECT 
FROM lkDolgoz�kL�tsz�ma18�vAlattiGyermekkel, lkN�kL�tsz�ma02, lkN�kL�tsz�ma6�vAlattiGyermekkel;

-- [lkLez�rtFeladatk�rh�zRendeltDolgoz�kF�oszt�lyonk�nt]
SELECT DISTINCT lkSzem�lyek.F�oszt�lyK�d, lkSzem�lyek.F�oszt�ly, Count(lkSzem�lyek.Azonos�t�) AS L�tsz�m
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Els�dleges feladatk�r]) Like "Lez�rt*"))
GROUP BY lkSzem�lyek.F�oszt�lyK�d, lkSzem�lyek.F�oszt�ly
ORDER BY lkSzem�lyek.F�oszt�lyK�d;

-- [lkM�sBesorol�s�Oszt�lyvezet�k]
SELECT lkOszt�lyvezet�i�ll�shelyek.F�oszt�ly, lkOszt�lyvezet�i�ll�shelyek.Oszt�ly, lkOszt�lyvezet�i�ll�shelyek.[Dolgoz� teljes neve], lkOszt�lyvezet�i�ll�shelyek.[Besorol�si  fokozat (KT)] AS Besorol�s, lkOszt�lyvezet�i�ll�shelyek.[Vezet�i beoszt�s megnevez�se], lkOszt�lyvezet�i�ll�shelyek.[Tart�s t�voll�t t�pusa], lkOszt�lyvezet�i�ll�shelyek.�ll�shely, lkOszt�lyvezet�i�ll�shelyek.NLink
FROM lkOszt�lyvezet�i�ll�shelyek
WHERE (((lkOszt�lyvezet�i�ll�shelyek.[Besorol�si  fokozat (KT)]) Not Like "*Oszt�lyvezet�" Or (lkOszt�lyvezet�i�ll�shelyek.[Besorol�si  fokozat (KT)]) Is Null) AND ((lkOszt�lyvezet�i�ll�shelyek.[Vezet�i beoszt�s megnevez�se]) Like "*Oszt�lyvezet�")) OR (((lkOszt�lyvezet�i�ll�shelyek.[Besorol�si  fokozat (KT)]) Like "*Oszt�lyvezet�") AND ((lkOszt�lyvezet�i�ll�shelyek.[Vezet�i beoszt�s megnevez�se]) Not Like "*Oszt�lyvezet�" Or (lkOszt�lyvezet�i�ll�shelyek.[Vezet�i beoszt�s megnevez�se]) Is Null)) OR (((lkOszt�lyvezet�i�ll�shelyek.[Besorol�si  fokozat (KT)]) Not Like "*ker�leti*") AND ((lkOszt�lyvezet�i�ll�shelyek.[Vezet�i beoszt�s megnevez�se]) Like "*ker�leti*")) OR (((lkOszt�lyvezet�i�ll�shelyek.[Besorol�si  fokozat (KT)]) Like "*ker�leti*") AND ((lkOszt�lyvezet�i�ll�shelyek.[Vezet�i beoszt�s megnevez�se]) Not Like "*ker�leti*"))
ORDER BY lkOszt�lyvezet�i�ll�shelyek.bfkh;

-- [lkMeghagyand�MaxL�tsz�mFeladatk�r�nk�nt]
SELECT tMeghagy�sraKijel�ltMunkak�r�k.Feladatk�r�k, Sum(1) AS L�tsz�m, Sum([Meghagyand�]/100) AS [Bet�lt�tt l�tsz�m ar�nyos�tva]
FROM (lkSzem�lyek AS lkSzem�lyek_1 INNER JOIN tMeghagyand�kAr�nya ON lkSzem�lyek_1.F�oszt�lyBFKHK�d = tMeghagyand�kAr�nya.BFKH) INNER JOIN tMeghagy�sraKijel�ltMunkak�r�k ON lkSzem�lyek_1.[KIRA feladat megnevez�s] = tMeghagy�sraKijel�ltMunkak�r�k.Feladatk�r�k
WHERE (((lkSzem�lyek_1.[St�tusz neve])="�ll�shely") AND ((tMeghagyand�kAr�nya.F�oszt�ly) Is Not Null))
GROUP BY tMeghagy�sraKijel�ltMunkak�r�k.Feladatk�r�k;

-- [lkMeghagy�s01_Archiv]
SELECT tMeghagyand�kAr�nya.Azonos�t�, tMeghagyand�kAr�nya.F�oszt�ly, lkSzervezetiBet�lt�sek.F�oszt�lyK�d, lkSzervezetiBet�lt�sek.[Sz�l� szervezeti egys�g�nek k�dja], 1 AS L�tsz�m, tMeghagyand�kAr�nya.Meghagyand� AS [Meghagyand�%], lkSzervezetiBet�lt�sek.[Szervezetmenedzsment k�d]
FROM lkSzem�lyek INNER JOIN (tMeghagyand�kAr�nya INNER JOIN lkSzervezetiBet�lt�sek ON tMeghagyand�kAr�nya.[Szervezeti egys�g k�dja] = lkSzervezetiBet�lt�sek.F�oszt�lyK�d) ON lkSzem�lyek.[Ad�azonos�t� jel] = lkSzervezetiBet�lt�sek.[Szervezetmenedzsment k�d];

-- [lkMeghagy�s01_r�giArchiv]
SELECT tMeghagyand�kAr�nya.Azonos�t�, tMeghagyand�kAr�nya.F�oszt�ly, lkSzervezetiBet�lt�sek.F�oszt�lyK�d, lkSzervezetiBet�lt�sek.[Sz�l� szervezeti egys�g�nek k�dja], 1 AS L�tsz�m, tMeghagyand�kAr�nya.Meghagyand� AS [Meghagyand�%], lkSzervezetiBet�lt�sek.[Szervezetmenedzsment k�d]
FROM lkSzem�lyek INNER JOIN (tMeghagyand�kAr�nya INNER JOIN lkSzervezetiBet�lt�sek ON tMeghagyand�kAr�nya.[Szervezeti egys�g k�dja] = lkSzervezetiBet�lt�sek.F�oszt�lyK�d) ON lkSzem�lyek.[Ad�azonos�t� jel] = lkSzervezetiBet�lt�sek.[Szervezetmenedzsment k�d]
WHERE (((lkSzem�lyek.[Besorol�si  fokozat (KT)])<>"F�oszt�lyvezet�" And (lkSzem�lyek.[Besorol�si  fokozat (KT)])<>"Oszt�lyvezet�" And (lkSzem�lyek.[Besorol�si  fokozat (KT)])<>"J�r�si / ker�leti hivatal vezet�je" And (lkSzem�lyek.[Besorol�si  fokozat (KT)])<>"J�r�si / ker�leti hivatal vezet�j�nek helyettese" And (lkSzem�lyek.[Besorol�si  fokozat (KT)])<>"F�isp�n" And (lkSzem�lyek.[Besorol�si  fokozat (KT)])<>"Korm�nyhivatal f�igazgat�ja" And (lkSzem�lyek.[Besorol�si  fokozat (KT)])<>"Korm�nyhivatal igazgat�ja") AND ((Year(Now())-Year([Sz�let�si id�])) Between 18 And 65) AND ((lkSzem�lyek.Neme)=("f�rfi")));

-- [lkMeghagy�s02_Archiv]
SELECT lkMeghagy�s01.Azonos�t�, lkMeghagy�s01.F�oszt�lyK�d, lkMeghagy�s01.F�oszt�ly, Sum(lkMeghagy�s01.L�tsz�m) AS SumOfL�tsz�m, lkMeghagy�s01.[Meghagyand�%], Sum([L�tsz�m]*[Meghagyand�%]/100) AS [Meghagyand� l�tsz�m]
FROM lkMeghagy�s01
GROUP BY lkMeghagy�s01.Azonos�t�, lkMeghagy�s01.F�oszt�lyK�d, lkMeghagy�s01.F�oszt�ly, lkMeghagy�s01.[Meghagyand�%];

-- [lkMeghagy�s03]
SELECT tMeghagyand�kAr�nya.Azonos�t�, lkSzervezetiBet�lt�sek.F�oszt�lyK�d, tMeghagyand�kAr�nya.F�oszt�ly, COUNT(lkSzem�lyek.[Ad�azonos�t� jel]) AS L�tsz�m, tMeghagyand�kAr�nya.Meghagyand� AS [Meghagyand�%], ROUND(SUM(1 * tMeghagyand�kAr�nya.Meghagyand� / 100)) AS Meghagyand�k INTO tMeghagy�s03
FROM (lkSzem�lyek INNER JOIN lkSzervezetiBet�lt�sek ON lkSzem�lyek.[Ad�azonos�t� jel] = lkSzervezetiBet�lt�sek.[Szervezetmenedzsment k�d]) INNER JOIN tMeghagyand�kAr�nya ON tMeghagyand�kAr�nya.[Szervezeti egys�g k�dja] = lkSzervezetiBet�lt�sek.F�oszt�lyK�d
GROUP BY tMeghagyand�kAr�nya.Azonos�t�, lkSzervezetiBet�lt�sek.F�oszt�lyK�d, tMeghagyand�kAr�nya.F�oszt�ly, tMeghagyand�kAr�nya.Meghagyand�;

-- [lkMeghagy�sB01]
SELECT DISTINCT lkSzervezetiBet�lt�sek.F�oszt�lyK�d, tBesorol�s_�talak�t�.Sorrend, lkSzervezetiBet�lt�sek.[St�tusz�nak k�dja], Replace([St�tusz�nak k�dja],"S-","")*1 AS Sz�m, lkSzem�lyek.[Dolgoz� teljes neve] INTO tMeghagy�sB01
FROM ((lkSzervezetiBet�lt�sek INNER JOIN lkSzem�lyek ON lkSzervezetiBet�lt�sek.[Szervezetmenedzsment k�d] = lkSzem�lyek.[Ad�azonos�t� jel]) INNER JOIN tBesorol�s_�talak�t� ON lkSzem�lyek.Besorol�s2 = tBesorol�s_�talak�t�.Besorol�si_fokozat) INNER JOIN tMeghagy�sraKijel�ltMunkak�r�k ON lkSzem�lyek.[KIRA feladat megnevez�s] = tMeghagy�sraKijel�ltMunkak�r�k.Feladatk�r�k
WHERE (((Year(Now())-Year([Sz�let�si id�])) Between 18 And 65) AND ((lkSzem�lyek.Neme)="f�rfi"));

-- [lkMeghagy�sB02]
SELECT tMeghagy�sB01.F�oszt�lyK�d, tMeghagy�sB01.Sorrend AS Besorol�s, tMeghagy�sB01.Sz�m, tMeghagy�sB01.[St�tusz�nak k�dja], DCount("*","tMeghagy�sB01","F�oszt�lyK�d = '" & [F�oszt�lyK�d] & "' AND sorrend < " & [sorrend])+DCount("*","tMeghagy�sB01","F�oszt�lyK�d = '" & [F�oszt�lyK�d] & "' AND sorrend = " & [sorrend] & " AND Sz�m < " & [Sz�m])+1 AS Sorsz�m3 INTO tMeghagy�sB02
FROM tMeghagy�sB01
ORDER BY tMeghagy�sB01.F�oszt�lyK�d, tMeghagy�sB01.Sorrend, tMeghagy�sB01.Sz�m;

-- [lkMeghagy�sEredm�ny]
SELECT [TAJ sz�m], ffsplit([Dolgoz� sz�let�si neve]," ",1) AS [Sz�let�si n�v1], ffsplit([Dolgoz� sz�let�si neve]," ",2) AS [Sz�let�si n�v2], IIf(ffsplit([Dolgoz� sz�let�si neve]," ",3)=ffsplit([Dolgoz� sz�let�si neve]," ",2) Or Left(ffsplit([Dolgoz� sz�let�si neve]," ",3),1)="(","",ffsplit([Dolgoz� sz�let�si neve]," ",3)) AS [Sz�let�si n�v3], IIf(InStr(1,[Dolgoz� teljes neve],"dr.",0),"dr.",IIf(InStr(1,[Dolgoz� teljes neve],"Dr.",0),"Dr.","")) AS El�tag, ffsplit([Dolgoz� teljes neve]," ",1) AS [H�zass�gi n�v1], ffsplit([Dolgoz� teljes neve]," ",2) AS [H�zass�gi n�v2], IIf(ffsplit([Dolgoz� teljes neve]," ",3)=ffsplit([Dolgoz� teljes neve]," ",2) Or Left(ffsplit([Dolgoz� teljes neve]," ",3),1)="(" Or Left(ffsplit([Dolgoz� teljes neve]," ",3),3)="dr." Or Left(ffsplit([Dolgoz� teljes neve]," ",3),3)="Dr.","",ffsplit([Dolgoz� teljes neve]," ",3)) AS [H�zass�gi n�v3], trim(ffsplit(drLev�laszt([Anyja neve],False)," ",1)) AS [Anyja neve1], ffsplit(drLev�laszt([Anyja neve],False)," ",2) AS [Anyja neve2], IIf(ffsplit(drLev�laszt([Anyja neve],False)," ",3)=ffsplit(drLev�laszt([Anyja neve],False)," ",2) Or Left(ffsplit(drLev�laszt([Anyja neve],False)," ",3),1)="(","",ffsplit(drLev�laszt([Anyja neve],False)," ",3)) AS [Anyja neve3], [Sz�let�si id�], [Sz�let�si hely], Feladatk�r�k AS munkak�r
FROM (SELECT * FROM lkMeghagy�s�jEredm�ny UNION SELECT * FROM lkMeghagy�sVezet�k)  AS �jEredm�ny�sVezet�k;

-- [lkMeghagy�sEredm�ny_�llom�nyT�blaSzer�en]
SELECT tMeghagy�s03.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], tMeghagy�sB02.[St�tusz�nak k�dja] AS �NYR, lkSzem�lyek.[KIRA feladat megnevez�s], tMeghagy�s03.CountOfL�tsz�m AS Bet�lt�tt, tMeghagy�s03.[Meghagyand�%], tMeghagy�s03.Meghagyand�k, [CountOfL�tsz�m]-[Meghagyand�k] AS MegNemHagyand�k, tMeghagy�sB02.Sorsz�m3, IIf([Sorsz�m3]<=([CountOfL�tsz�m]-[Meghagyand�k]),"Nem ker�l meghagy�sra",IIf([Szervezeti egys�g k�dja]="BFKH.1.27.2.","Nem ker�l meghagy�sra","Meghagyand�")) AS Eredm�ny
FROM lkSzem�lyek RIGHT JOIN (tMeghagy�s03 RIGHT JOIN tMeghagy�sB02 ON tMeghagy�s03.F�oszt�lyK�d = tMeghagy�sB02.F�oszt�lyK�d) ON lkSzem�lyek.[St�tusz k�dja] = tMeghagy�sB02.[St�tusz�nak k�dja]
ORDER BY lkSzem�lyek.BFKH, tMeghagy�sB02.Sorsz�m3;

-- [lkMeghagy�sEredm�ny_r�gi]
SELECT lkSzem�lyek.[TAJ sz�m], lkSzem�lyek.[Dolgoz� sz�let�si neve] AS [Sz�let�si n�v], lkSzem�lyek.[Dolgoz� teljes neve] AS [H�zass�gi n�v], lkSzem�lyek.[Anyja neve], lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.[Sz�let�si hely], lkSzem�lyek.[KIRA feladat megnevez�s] AS munkak�r, tMeghagy�sB02.Besorol�s
FROM lkSzem�lyek RIGHT JOIN (tMeghagy�s03 RIGHT JOIN tMeghagy�sB02 ON tMeghagy�s03.F�oszt�lyK�d = tMeghagy�sB02.F�oszt�lyK�d) ON lkSzem�lyek.[St�tusz k�dja] = tMeghagy�sB02.[St�tusz�nak k�dja]
WHERE (((tMeghagy�sB02.Besorol�s)<>"F�oszt�lyvezet�" And (tMeghagy�sB02.Besorol�s)<>"Oszt�lyvezet�" And (tMeghagy�sB02.Besorol�s)<>"J�r�si / ker�leti hivatal vezet�je" And (tMeghagy�sB02.Besorol�s)<>"J�r�si / ker�leti hivatal vezet�j�nek helyettese" And (tMeghagy�sB02.Besorol�s)<>"F�isp�n" And (tMeghagy�sB02.Besorol�s)<>"Korm�nyhivatal f�igazgat�ja" And (tMeghagy�sB02.Besorol�s)<>"Korm�nyhivatal igazgat�ja") AND ((IIf([Sorsz�m3]<=([SumOfL�tsz�m]-[Meghagyand�k]),False,True))=True))
ORDER BY Bfkh(Nz([tMeghagy�s03].[F�oszt�lyK�d],"BFKH.1.")), tMeghagy�sB02.Sorsz�m3 DESC;

-- [lkMeghagy�sM�trix]
SELECT lkMeghagyand�MaxL�tsz�mFeladatk�r�nk�nt.feladatk�r�k AS [Meghagy�sra kijel�lt munkak�r�k megnevez�se], lkMeghagyand�MaxL�tsz�mFeladatk�r�nk�nt.L�tsz�m AS [Azonos munkak�r�k mennyis�ge], Round([Bet�lt�tt l�tsz�m ar�nyos�tva],0) AS [Azonos munkak�r�k k�z�l meghagy�sra tervezettek sz�ma], [L�tsz�m]-Round([Bet�lt�tt l�tsz�m ar�nyos�tva],0) AS [Azonos munkak�r�k k�z�l meghagy�sra nem tervezettek sz�ma]
FROM lkMeghagyand�MaxL�tsz�mFeladatk�r�nk�nt;

-- [lkMeghagy�sM�trixB]
SELECT valami.[meghagy�sra kijel�lt munkak�r�k megnevez�se], Sum(valami.A) AS �sszes, Sum(valami.B) AS Meghagyand�k, Sum(valami.C) AS [Meg nem hagyand�k]
FROM (SELECT lkFeladatk�r�nk�ntiL�tsz�m.*
  FROM lkFeladatk�r�nk�ntiL�tsz�m
  UNION
  SELECT lkFeladatk�r�nk�ntiMeghagyottak.*
  FROM  lkFeladatk�r�nk�ntiMeghagyottak)  AS valami
GROUP BY valami.[meghagy�sra kijel�lt munkak�r�k megnevez�se];

-- [lkMeghagy�s�j01]
SELECT DISTINCT lkSzem�lyek.BFKH, lkSzem�lyek.F�oszt�lyK�d, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[TAJ sz�m], lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Dolgoz� sz�let�si neve], lkSzem�lyek.[Anyja neve], lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.[Sz�let�si hely], IIf([Besorol�s2] In ('F�oszt�lyvezet�','Oszt�lyvezet�','F�isp�n','Korm�nyhivatal f�igazgat�ja','Korm�nyhivatal igazgat�ja') And [Meghagyand�%]>0,0,1) AS Vezet�, IIf(Year(Date())-Year([Sz�let�si id�])>65,0,1) AS Kor, IIf([Neme]='n�',0,1) AS Nem, ([Vezet�] * [Kor] * [Nem]) AS Rang, CLng(Replace([St�tusz k�dja],"S-","")) AS Sz�m, tBesorol�s_�talak�t�.Sorrend, lkSzem�lyek.[KIRA feladat megnevez�s] INTO tMeghagy�s�jB01
FROM (lkSzem�lyek LEFT JOIN tBesorol�s_�talak�t� ON lkSzem�lyek.Besorol�s2 = tBesorol�s_�talak�t�.Besorol�si_fokozat) LEFT JOIN tMeghagy�s03 ON lkSzem�lyek.F�oszt�lyK�d = tMeghagy�s03.F�oszt�lyK�d
WHERE lkSzem�lyek.[St�tusz neve] = "�ll�shely";

-- [lkMeghagy�s�j02]
SELECT tMeghagy�s�jB01.F�oszt�lyK�d, tMeghagy�s�jB01.Sorrend AS Besorol�s, tMeghagy�s�jB01.Sz�m, tMeghagy�s�jB01.Sorrend, CDbl(DCount("*","tMeghagy�s�jB01","F�oszt�lyK�d = '" & [F�oszt�lyK�d] & "' AND rang < " & [rang])+DCount("*","tMeghagy�s�jB01","F�oszt�lyK�d = '" & [F�oszt�lyK�d] & "' AND rang = " & [rang] & " AND sorrend > " & [sorrend])+DCount("*","tMeghagy�s�jB01","F�oszt�lyK�d = '" & [F�oszt�lyK�d] & "' AND rang = " & [rang] & " AND sorrend = " & [sorrend] & " AND Sz�m < " & [Sz�m])+1) AS Sorsz�m3, tMeghagy�s�jB01.F�oszt�ly, tMeghagy�s�jB01.Oszt�ly, tMeghagy�s�jB01.[TAJ sz�m], tMeghagy�s�jB01.[Dolgoz� sz�let�si neve], tMeghagy�s�jB01.[Dolgoz� teljes neve], tMeghagy�s�jB01.[Anyja neve], tMeghagy�s�jB01.[Sz�let�si id�], tMeghagy�s�jB01.[Sz�let�si hely], tMeghagy�s�jB01.Vezet�, tMeghagy�s�jB01.Kor, tMeghagy�s�jB01.[Nem], tMeghagy�s�jB01.Rang, tMeghagy�s�jB01.[KIRA feladat megnevez�s] INTO tMeghagy�s�jB02
FROM tMeghagy�s�jB01
ORDER BY tMeghagy�s�jB01.F�oszt�lyK�d, tMeghagy�s�jB01.Sorrend, tMeghagy�s�jB01.Sz�m;

-- [lkMeghagy�s�j03]
SELECT tMeghagy�s�jB02.Besorol�s, tMeghagy�s�jB02.Sorrend, tMeghagy�s�jB02.Sz�m, tMeghagy�s�jB02.Vezet�, tMeghagy�s�jB02.Kor, tMeghagy�s�jB02.[Nem], tMeghagy�s�jB02.F�oszt�lyK�d, tMeghagy�s�jB02.Rang, tMeghagy�s�jB02.Sorsz�m3, tMeghagy�s�jB02.F�oszt�ly, tMeghagy�s�jB02.Oszt�ly, tMeghagy�s�jB02.[TAJ sz�m], tMeghagy�s�jB02.[Dolgoz� sz�let�si neve], tMeghagy�s�jB02.[Dolgoz� teljes neve], tMeghagy�s�jB02.[Anyja neve], tMeghagy�s�jB02.[Sz�let�si id�], tMeghagy�s�jB02.[Sz�let�si hely], [KIRA feladat megnevez�s]
FROM tMeghagy�s�jB02 INNER JOIN tMeghagy�s03 ON (tMeghagy�s�jB02.F�oszt�lyK�d=tMeghagy�s03.F�oszt�lyK�d) AND (tMeghagy�s03.Meghagyand�k>=tMeghagy�s�jB02.Sorsz�m3)
ORDER BY tMeghagy�s�jB02.F�oszt�lyK�d, tMeghagy�s�jB02.Rang, tMeghagy�s�jB02.Sorsz�m3;

-- [lkMeghagy�s�jEredm�ny]
SELECT lkMeghagy�s�j03.[TAJ sz�m], lkMeghagy�s�j03.[Dolgoz� sz�let�si neve], lkMeghagy�s�j03.[Dolgoz� teljes neve], lkMeghagy�s�j03.[Anyja neve], lkMeghagy�s�j03.[Sz�let�si id�], lkMeghagy�s�j03.[Sz�let�si hely], tMeghagy�sraKijel�ltMunkak�r�k.Feladatk�r�k
FROM tMeghagy�sraKijel�ltMunkak�r�k INNER JOIN lkMeghagy�s�j03 ON tMeghagy�sraKijel�ltMunkak�r�k.Feladatk�r�k = lkMeghagy�s�j03.[KIRA feladat megnevez�s]
WHERE (((lkMeghagy�s�j03.[Nem])=1) AND ((lkMeghagy�s�j03.Kor)=1))
ORDER BY lkMeghagy�s�j03.F�oszt�lyK�d;

-- [lkMeghagy�sVezet�k]
SELECT lkSzem�lyek.[TAJ sz�m], lkSzem�lyek.[Dolgoz� sz�let�si neve], lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Anyja neve], lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.[Sz�let�si hely], lkSzem�lyek.[KIRA feladat megnevez�s] AS Feladatk�r�k
FROM lkSzem�lyek
WHERE (((IIf([Besorol�s2] In ('F�oszt�lyvezet�','Korm�nyhivatal f�igazgat�ja','Korm�nyhivatal igazgat�ja'),1,0))=1) AND ((lkSzem�lyek.Neme)<>'n�') AND ((Year(Date())-Year([Sz�let�si id�]))<65) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.BFKH;

-- [lkMentess�gek]
SELECT tMentess�gek.*, [Csal�dn�v] & " " & [Ut�n�v] AS N�v, IIf([Sz�let�si hely] Like "Budapest*","Budapest",[Sz�let�si hely]) AS Sz�lHely
FROM tMentess�gek;

-- [lkMez�k�sT�pusuk]
SELECT tImportMez�k.Az, tImportMez�k.Oszlopn�v, tImportMez�k.T�pus, tImportMez�k.Mez�n�v, tImportMez�k.Skip, tMez�T�pusok.Constant, tMez�T�pusok.Description, tMez�T�pusok.DbType
FROM tImportMez�k INNER JOIN tMez�T�pusok ON tImportMez�k.T�pus = tMez�T�pusok.Value;

-- [lkMindenKer�letbeBel�p�k]
SELECT lkBel�p�kUni�.[Megyei szint VAGY J�r�si Hivatal] AS Ker�let, lkBel�p�kUni�.N�v, lkBel�p�kUni�.[Jogviszony kezd� d�tuma]
FROM lkBel�p�kUni�
WHERE (((lkBel�p�kUni�.[Megyei szint VAGY J�r�si Hivatal])="Budapest F�v�ros Korm�nyhivatala XIV. Ker�leti Hivatala") AND ((lkBel�p�kUni�.[Jogviszony kezd� d�tuma]) Between #7/1/2023# And #7/31/2024#));

-- [lkMindenKer�letb�lKil�pettekHavonta]
SELECT Replace([Megyei szint VAGY J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH") AS Ker�let, DateSerial(Year([Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]),Month([Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])+1,1)-1 AS T�rgyh�, Sum(1) AS F�
FROM lkKil�p�Uni�
WHERE (((lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek oka: jogszab�lyi hiva]) Not Like "*l�tre*") AND ((lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]) Between #7/1/2023# And #7/31/2024#))
GROUP BY Replace([Megyei szint VAGY J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH"), DateSerial(Year([Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]),Month([Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])+1,1)-1;

-- [lkMindenKer�letiBet�lt�ttL�tsz�m01]
SELECT Replace([J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH") AS [Ker�leti hivatal], tHaviJelent�sHat�lya1.hat�lya, Sum(IIf([Mez�4]="�res �ll�s",0,1)) AS [Bet�lt�tt l�tsz�m], Sum(IIf([Mez�4]="�res �ll�s",1,0)) AS �res
FROM tHaviJelent�sHat�lya1 INNER JOIN tJ�r�si_�llom�ny ON tHaviJelent�sHat�lya1.hat�lyaID = tJ�r�si_�llom�ny.hat�lyaID
GROUP BY Replace([J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH"), tHaviJelent�sHat�lya1.hat�lya
HAVING (((tHaviJelent�sHat�lya1.hat�lya) Between #7/1/2023# And #7/31/2024#));

-- [lkMindenKer�letiBet�lt�ttL�tsz�m02]
SELECT lkMindenKer�letiBet�lt�ttL�tsz�m01.[Ker�leti hivatal], lkMindenKer�letiBet�lt�ttL�tsz�m01.hat�lya, lkMindenKer�letiBet�lt�ttL�tsz�m01.[Bet�lt�tt l�tsz�m], lkMindenKer�letiBet�lt�ttL�tsz�m01.�res, [Bet�lt�tt l�tsz�m]+[�res] AS Enged�lyezett
FROM lkMindenKer�letiBet�lt�ttL�tsz�m01;

-- [lkMindenKer�letiKimutat�s01]
SELECT lkMindenKer�letiBet�lt�ttL�tsz�m02.[Ker�leti hivatal], lkMindenKer�letiBet�lt�ttL�tsz�m02.hat�lya, lkMindenKer�letiBet�lt�ttL�tsz�m02.[Bet�lt�tt l�tsz�m], lkMindenKer�letiBet�lt�ttL�tsz�m02.�res, lkMindenKer�letiBet�lt�ttL�tsz�m02.Enged�lyezett, IIf([hat�lya]=[T�rgyh�] And [ker�leti hivatal]=[ker�let],[F�],0) AS Kil�pettek
FROM lkMindenKer�letiBet�lt�ttL�tsz�m02 LEFT JOIN lkMindenKer�letb�lKil�pettekHavonta ON lkMindenKer�letiBet�lt�ttL�tsz�m02.[Ker�leti hivatal] = lkMindenKer�letb�lKil�pettekHavonta.Ker�let;

-- [lkMindenKer�letiKimutat�s02]
SELECT lkMindenKer�letiKimutat�s01.[Ker�leti hivatal], lkMindenKer�letiKimutat�s01.hat�lya, lkMindenKer�letiKimutat�s01.[Bet�lt�tt l�tsz�m], lkMindenKer�letiKimutat�s01.�res, lkMindenKer�letiKimutat�s01.Enged�lyezett, Sum(lkMindenKer�letiKimutat�s01.Kil�pettek) AS SumOfKil�pettek
FROM lkMindenKer�letiKimutat�s01
GROUP BY lkMindenKer�letiKimutat�s01.[Ker�leti hivatal], lkMindenKer�letiKimutat�s01.hat�lya, lkMindenKer�letiKimutat�s01.[Bet�lt�tt l�tsz�m], lkMindenKer�letiKimutat�s01.�res, lkMindenKer�letiKimutat�s01.Enged�lyezett
HAVING (((lkMindenKer�letiKimutat�s01.[Ker�leti hivatal]) Like "*XIV*"));

-- [lkMindenKil�pettVezet�]
SELECT lkKil�p�Uni�.Ad�jel, lkKil�p�Uni�.N�v, lkKil�p�Uni�.F�oszt�ly, lkKil�p�Uni�.Oszt�ly, lkKil�p�Uni�.[Besorol�si fokozat megnevez�se:], lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek oka: jogszab�lyi hiva], lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja] AS Kil�p�s, DateDiff("yyyy",Mid([Ad�azonos�t�],2,5)*1-12051,dt�tal([Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])) AS [�letkora kil�p�skor], Mid([Ad�azonos�t�],2,5)*1-12051 AS [Sz�let�si d�tum]
FROM lkKil�p�Uni�
WHERE (((lkKil�p�Uni�.[Besorol�si fokozat megnevez�se:])="oszt�lyvezet�" Or (lkKil�p�Uni�.[Besorol�si fokozat megnevez�se:]) Like "ker�leti*" Or (lkKil�p�Uni�.[Besorol�si fokozat megnevez�se:]) Like "f�oszt�ly*" Or (lkKil�p�Uni�.[Besorol�si fokozat megnevez�se:]) Like "*igazgat�*" Or (lkKil�p�Uni�.[Besorol�si fokozat megnevez�se:])="f�isp�n"));

-- [lkMindenVezet�]
SELECT lkSzem�lyek.[Ad�azonos�t� jel], bfkh(Nz([Szervezeti egys�g k�dja],"-")) AS BFKH, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.Besorol�s2, LCase(Replace(Nz([Besorol�si  fokozat (KT)],""),"J�r�si / ","")) & IIf(Nz([Tart�s t�voll�t t�pusa],"")<>""," (TT)","") AS [Ell�tott feladat], lkSzem�lyek.[Sz�let�si hely], lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.[Anyja neve], lkSzem�lyek.[�lland� lakc�m], lkSzem�lyek.[Tart�zkod�si lakc�m], lkSzem�lyek.Ad�jel, dt�tal([Jogviszony v�ge (kil�p�s d�tuma)]) AS Kil�p�s, DateSerial(Year(Nz([Sz�let�si id�],0))+65,Month(Nz([Sz�let�si id�],0)),Day(Nz([Sz�let�si id�],0))-1) AS [�regs�gi nyugd�j korhat�r], lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.[Hivatali email]
FROM lkSzem�lyek
WHERE (((LCase(Replace(Nz([Besorol�si  fokozat (KT)],""),"J�r�si / ","")) & IIf(Nz([Tart�s t�voll�t t�pusa],"")<>""," (TT)",""))="oszt�lyvezet�") AND ((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null)) OR (((LCase(Replace(Nz([Besorol�si  fokozat (KT)],""),"J�r�si / ","")) & IIf(Nz([Tart�s t�voll�t t�pusa],"")<>""," (TT)","")) Like "ker�leti*") AND ((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null)) OR (((LCase(Replace(Nz([Besorol�si  fokozat (KT)],""),"J�r�si / ","")) & IIf(Nz([Tart�s t�voll�t t�pusa],"")<>""," (TT)","")) Like "f�oszt�ly*") AND ((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null)) OR (((LCase(Replace(Nz([Besorol�si  fokozat (KT)],""),"J�r�si / ","")) & IIf(Nz([Tart�s t�voll�t t�pusa],"")<>""," (TT)","")) Like "*igazgat�*") AND ((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null)) OR (((LCase(Replace(Nz([Besorol�si  fokozat (KT)],""),"J�r�si / ","")) & IIf(Nz([Tart�s t�voll�t t�pusa],"")<>""," (TT)",""))="f�isp�n") AND ((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null))
ORDER BY bfkh(Nz([Szervezeti egys�g k�dja],"-")), LCase(Replace(Nz([Besorol�si  fokozat (KT)],""),"J�r�si / ","")) & IIf(Nz([Tart�s t�voll�t t�pusa],"")<>""," (TT)","");

-- [lkMinervaInd�t�Oldalak]
SELECT DISTINCT [Oldalak(tLek�rdez�sOszt�lyok)].azOszt�ly, [Oldalak(tLek�rdez�sOszt�lyok)].Oldalc�m, [Oldalak(tLek�rdez�sOszt�lyok)].TartalomIsmertet�, [Fejezetek(tLek�rdez�sT�pusok)].LapN�v AS [Fejezet c�me], [Fejezetek(tLek�rdez�sT�pusok)].Megjegyz�s AS [Fejezet le�r�sa], [Lek�rdez�sek(tEllen�rz�Lek�rdez�sek)].T�blac�m, [Lek�rdez�sek(tEllen�rz�Lek�rdez�sek)].T�blaMegjegyz�s AS [T�bla le�r�sa], IIf([graftulajdons�g]="Type",[graftul�rt�k],"") AS VaneGraf, [Oldalak(tLek�rdez�sOszt�lyok)].F�jln�v
FROM tLek�rdez�sOszt�lyok AS [Oldalak(tLek�rdez�sOszt�lyok)] INNER JOIN ((tLek�rdez�sT�pusok AS [Fejezetek(tLek�rdez�sT�pusok)] INNER JOIN tEllen�rz�Lek�rdez�sek AS [Lek�rdez�sek(tEllen�rz�Lek�rdez�sek)] ON [Fejezetek(tLek�rdez�sT�pusok)].azET�pus = [Lek�rdez�sek(tEllen�rz�Lek�rdez�sek)].azET�pus) LEFT JOIN tGrafikonok ON [Lek�rdez�sek(tEllen�rz�Lek�rdez�sek)].azEllen�rz� = tGrafikonok.azEllen�rz�) ON [Oldalak(tLek�rdez�sOszt�lyok)].azOszt�ly = [Fejezetek(tLek�rdez�sT�pusok)].Oszt�ly;

-- [lkMobilmodulAdatFel�lvizsg�lat]
SELECT DISTINCT [SIM adatok - 2023-08-29 (2)].Azonos�t�, [SIM adatok - 2023-08-29 (2)].Telefonsz�mId, [SIM adatok - 2023-08-29 (2)].Telefonsz�m, [SIM adatok - 2023-08-29 (2)].Megjegyz�s, [SIM adatok - 2023-08-29 (2)].[Dolgoz� n�v], [SIM adatok - 2023-08-29 (2)].[Szem�lyt�rzsben akt�v -e], [SIM adatok - 2023-08-29 (2)].[Szem�lyt�rzs szerinti e-mail c�m], [SIM adatok - 2023-08-29 (2)].[Szem�lyt�rzsben szervezeti egys�ge], [SIM adatok - 2023-08-29 (2)].[NEXON ID], [SIM adatok - 2023-08-29 (2)].Beoszt�s, [SIM adatok - 2023-08-29 (2)].[Szervezeti egys�g], lkSzem�lyek�sNexonAz.F�oszt�ly, lkSzem�lyek�sNexonAz.[Dolgoz� teljes neve], lkSzem�lyek�sNexonAz.[Hivatali email], IIf([St�tusz neve] Is Null,
    "A dolgoz� kil�pett",
    Trim(
        IIf([F�oszt�ly]<>[Szervezeti egys�g],
            "A szervezeti egys�g:" & [F�oszt�ly] & ".",
            "") 
        & " " & 
        IIf([Dolgoz� teljes neve]<>[Dolgoz� n�v] AND [Dolgoz� n�v] NOT LIKE "Dr.*",
            "A n�v: " & [Dolgoz� teljes neve] & ".",
            "") 
        & " " & 
        IIf([Hivatali email]<>[Szem�lyt�rzs szerinti e-mail c�m],
            "A Nexonban nyilv�ntartott email: " & [Hivatali email] & ".",
            "")
        )
    ) AS Adathelyesb�t�s, ffsplit(lkSzem�lyek�sNexonAz.[Els�dleges feladatk�r],"-",2) AS [Els�dleges feladatk�r Nexon]
FROM lkSzem�lyek�sNexonAz RIGHT JOIN [SIM adatok - 2023-08-29 (2)] ON (lkSzem�lyek�sNexonAz.azNexon = [SIM adatok - 2023-08-29 (2)].[NEXON ID]) 
            OR 
            (lkSzem�lyek�sNexonAz.[Dolgoz� teljes neve] = [SIM adatok - 2023-08-29 (2)].[Dolgoz� n�v]);

-- [lkMozg�s�venteHavonta]
SELECT Mozg�s.�v, Sum(Mozg�s.[01]) AS [01 h�], Sum(Mozg�s.[02]) AS [02 h�], Sum(Mozg�s.[03]) AS [03 h�], Sum(Mozg�s.[04]) AS [04 h�], Sum(Mozg�s.[05]) AS [05 h�], Sum(Mozg�s.[06]) AS [06 h�], Sum(Mozg�s.[07]) AS [07 h�], Sum(Mozg�s.[08]) AS [08 h�], Sum(Mozg�s.[09]) AS [09 h�], Sum(Mozg�s.[10]) AS [10 h�], Sum(Mozg�s.[11]) AS [11 h�], Sum(Mozg�s.[12]) AS [12 h�], Sum(Mozg�s.Bel�p�k) AS Mozg�s
FROM (SELECT *
FROM lkBel�p�kSz�ma�venteHavonta3
UNION
SELECT lkKil�p�kSz�ma�venteHavonta3.�v
, lkKil�p�kSz�ma�venteHavonta3.[01] * -1
, lkKil�p�kSz�ma�venteHavonta3.[02] * -1
, lkKil�p�kSz�ma�venteHavonta3.[03] * -1
, lkKil�p�kSz�ma�venteHavonta3.[04] * -1
, lkKil�p�kSz�ma�venteHavonta3.[05] * -1
, lkKil�p�kSz�ma�venteHavonta3.[06] * -1
, lkKil�p�kSz�ma�venteHavonta3.[07] * -1
, lkKil�p�kSz�ma�venteHavonta3.[08] * -1
, lkKil�p�kSz�ma�venteHavonta3.[09] * -1
, lkKil�p�kSz�ma�venteHavonta3.[10] * -1
, lkKil�p�kSz�ma�venteHavonta3.[11] * -1
, lkKil�p�kSz�ma�venteHavonta3.[12] * -1
, lkKil�p�kSz�ma�venteHavonta3.Kil�p�k * -1
FROM lkKil�p�kSz�ma�venteHavonta3
)  AS Mozg�s
GROUP BY Mozg�s.�v;

-- [lkMSysQueries]
SELECT qry.Attribute, qry.Expression, qry.Flag, qry.LvExtra, qob.Name AS ObjectName, qry.Name1 AS columnName, qry.Name2 AS alias
FROM MSysQueries AS qry LEFT JOIN MSysObjects AS qob ON qry.ObjectId = qob.Id
ORDER BY qob.Name;

-- [lkMunkaalkalmass�gi]
SELECT lkSzem�lyek.[TAJ sz�m] AS [azonos�t� sz�ma], "" AS [n�v el�tag], lkSzem�lyek.[Dolgoz� teljes neve] AS [munkav�llal� neve], lkSzem�lyek.Neme AS nem, lkSzem�lyek.[Sz�let�si hely], lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.[Dolgoz� sz�let�si neve] AS [le�nykori n�v], lkSzem�lyek.[Anyja neve], lkSzem�lyek.[Hivatali telefon] AS [telefon sz�m], lkSzem�lyek.[Hivatali email] AS [e-mail], lkSzem�lyek.[�lland� lakc�m] AS lakc�m, "" AS jogos�tv�ny, "" AS [katonai szolg�lat], Trim(ffsplit([FEOR],"-",1)) AS [FEOR k�d], Trim(ffsplit([FEOR],"-",2)) AS [FEOR n�v], "" AS [foglalkoz�seg�szs�g�gyi oszt�ly], "" AS [fizikai megterhel�s], "Budapest F�v�ros Korm�nyhivatala" AS [c�g teljes neve], "BFKH" AS [c�g r�vid neve], lkSzem�lyek.[Munkav�gz�s helye - megnevez�s] AS [telephely neve], lkSzem�lyek.[Munkav�gz�s helye - c�m] AS [telephely c�me], lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS [munkaviszony kezdete], lkSzem�lyek.[Orvosi vizsg�lat id�pontja] AS [alkalmass�gi vizsg�lat d�tuma], lkSzem�lyek.[Orvosi vizsg�lat k�vetkez� id�pontja] AS [alkalmass�gi vizsg�lat �rv�nyess�g], lkSzem�lyek.[Orvosi vizsg�lat t�pusa] AS [alkalmass�gi vizsg�lat t�pus], lkSzem�lyek.[Orvosi vizsg�lat eredm�nye] AS [alkalmass�gi vizsg�lat eredm�ny], lkSzem�lyek.[Orvosi vizsg�lat �szrev�telek] AS [alkalmass�gi vizsg�lat korl�zot�s]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [lkMunk�baj�r�sT�vols�ga01]
SELECT lkSzem�lyek.Ad�jel, lkSzem�lyek.[Dolgoz� teljes neve], tIr�ny�t�sz�mokKoordin�t�k.dblSz�less�g AS LakSz�l, tIr�ny�t�sz�mokKoordin�t�k.dblHossz�s�g AS LakHossz, tIr�ny�t�sz�mokKoordin�t�k_1.dblSz�less�g AS MunkSz�l, tIr�ny�t�sz�mokKoordin�t�k_1.dblHossz�s�g AS MunkHossz, GetDistance([Laksz�l],[Lakhossz],[MunkSz�l],[MunkHossz]) AS T�vols�g
FROM tIr�ny�t�sz�mokKoordin�t�k AS tIr�ny�t�sz�mokKoordin�t�k_1 INNER JOIN (lkMunkahelyc�mek INNER JOIN ((lkLakc�mek INNER JOIN tIr�ny�t�sz�mokKoordin�t�k ON lkLakc�mek.Irsz = tIr�ny�t�sz�mokKoordin�t�k.Irsz) INNER JOIN lkSzem�lyek ON lkLakc�mek.Ad�jel = lkSzem�lyek.Ad�jel) ON lkMunkahelyc�mek.Ad�jel = lkSzem�lyek.Ad�jel) ON tIr�ny�t�sz�mokKoordin�t�k_1.Irsz = lkMunkahelyc�mek.Irsz
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY GetDistance([Laksz�l],[Lakhossz],[MunkSz�l],[MunkHossz]) DESC;

-- [lkMunkahelyc�mek]
SELECT lkSzem�lyek.Ad�jel, lkSzem�lyek.[Munkav�gz�s helye - megnevez�s], lkSzem�lyek.[Munkav�gz�s helye - c�m], IIf(IsNumeric(Left(Nz([Munkav�gz�s helye - c�m],""),1)),Left(Nz([Munkav�gz�s helye - c�m],""),4)*1,0) AS Irsz
FROM lkSzem�lyek;

-- [lkMunkahelyC�mN�lk�liek]
SELECT lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Munkav�gz�s helye - c�m], lkSzem�lyek.[Szervezeti egys�g k�dja], Replace(IIf(IsNull([lkSzem�lyek].[Szint 4 szervezeti egys�g n�v]),[lkSzem�lyek].[Szint 3 szervezeti egys�g n�v] & "",[lkSzem�lyek].[Szint 4 szervezeti egys�g n�v] & ""),"Budapest F�v�ros Korm�nyhivatala ","BFKH ") AS F�oszt�ly, lkSzem�lyek.[Szint 5 szervezeti egys�g n�v] AS Oszt�ly, lkSzem�lyek.Ad�jel, "https://nexonport.kh.gov.hu/menu/hrm/szemelyiKarton/index?szemelyAzonosito=" & [azNexon] & "&r=13" AS Link
FROM lkSzem�lyek LEFT JOIN kt_azNexon_Ad�jel ON lkSzem�lyek.tSzem�lyek.Ad�jel=kt_azNexon_Ad�jel.Ad�jel
WHERE (((lkSzem�lyek.[Munkav�gz�s helye - c�m]) Is Null) AND ((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null) AND ((lkSzem�lyek.[St�tusz t�pusa]) Is Not Null));

-- [lkMunkahelyC�mN�lk�liek_Statisztika]
SELECT lkMunkahelyC�mN�lk�liek.F�oszt�ly, Count(lkMunkahelyC�mN�lk�liek.Link) AS db
FROM lkMunkahelyC�mN�lk�liek
GROUP BY lkMunkahelyC�mN�lk�liek.F�oszt�ly;

-- [lkMunkak�r�kF�oszt�lyJSON]
SELECT DISTINCT lkJ�r�siKorm�nyK�zpontos�tottUni�F�osztK�d.BFKH, Replace([J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH") AS F�oszt�ly, "{ id: """ & Nz([Szem�ly azonos�t�],[�ll�shely azonos�t�]) & """, neve: """ & N�([lkJ�r�siKorm�nyK�zpontos�tottUni�F�osztK�d].[N�v],"Bet�ltetlen �ll�shely (" & [�ll�shely azonos�t�] & ")") & " (" & [lkJ�r�siKorm�nyK�zpontos�tottUni�F�osztK�d].[Oszt�ly] & ")" & """ }," AS Json, lkJ�r�siKorm�nyK�zpontos�tottUni�F�osztK�d.Oszt�ly, drh�tra([lkJ�r�siKorm�nyK�zpontos�tottUni�F�osztK�d].[n�v]) AS N�v, lkJ�r�siKorm�nyK�zpontos�tottUni�F�osztK�d.Oszt�ly, tNexonAzonos�t�k.[Szem�ly azonos�t�]
FROM tEgyesMunkak�r�kF�oszt�lyai INNER JOIN (lkJ�r�siKorm�nyK�zpontos�tottUni�F�osztK�d LEFT JOIN tNexonAzonos�t�k ON lkJ�r�siKorm�nyK�zpontos�tottUni�F�osztK�d.Ad�azonos�t� = tNexonAzonos�t�k.[Ad�azonos�t� jel]) ON tEgyesMunkak�r�kF�oszt�lyai.F�oszt�ly = lkJ�r�siKorm�nyK�zpontos�tottUni�F�osztK�d.F�oszt�lyk�d
WHERE (((lkJ�r�siKorm�nyK�zpontos�tottUni�F�osztK�d.Oszt�ly) Like "*" & [tEgyesMunkak�r�kF�oszt�lyai].[Oszt�ly] & "*"))
ORDER BY lkJ�r�siKorm�nyK�zpontos�tottUni�F�osztK�d.BFKH, drh�tra([lkJ�r�siKorm�nyK�zpontos�tottUni�F�osztK�d].[n�v]);

-- [lkMunkak�r�kJson]
SELECT "{ ""id"": """ & [Munkak�rK�d] & """, ""neve"": """ & [Munkak�r] & """ }," AS Json
FROM tMunkak�r�k
ORDER BY tMunkak�r�k.Munkak�r;

-- [lkMunkak�r�kK�rlev�lC�mzettek00]
SELECT DISTINCT bfkh([F�oszt�lyK�d]) AS BFKHF�osztK�d, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], IIf([Neme]="f�rfi","�r","Asszony") AS Megsz�l�t�s, Replace(Nz([Besorol�si  fokozat (KT)],""),"J�r�si / ker�leti hivatal vezet�je","Hivatalvezet�") AS C�m, lkSzem�lyek.[Hivatali email], lkSzem�lyek.Ad�jel
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Besorol�si  fokozat (KT)])="J�r�si / ker�leti hivatal vezet�je")) OR (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Besorol�si  fokozat (KT)])="F�oszt�lyvezet�")) OR (((bfkh([F�oszt�lyK�d]))="BFKH.01.14") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Besorol�si  fokozat (KT)])="oszt�lyvezet�"));

-- [lkMunkak�r�kK�rlev�lC�mzettek01]
SELECT DISTINCT lkMunkak�r�kK�rlev�lC�mzettek00.BFKHF�osztK�d, lkMunkak�r�kK�rlev�lC�mzettek00.F�oszt�ly, lkMunkak�r�kK�rlev�lC�mzettek00.Ad�jel, lkMunkak�r�kK�rlev�lC�mzettek00.[Dolgoz� teljes neve] AS N�v, lkMunkak�r�kK�rlev�lC�mzettek00.Megsz�l�t�s, lkMunkak�r�kK�rlev�lC�mzettek00.C�m, lkMunkak�r�kK�rlev�lC�mzettek00.[Hivatali email], lkMunkak�r�kK�rlev�lCsakALegfrissebbMaiMell�kletek.�tvonal
FROM lkMunkak�r�kK�rlev�lCsakALegfrissebbMaiMell�kletek INNER JOIN (tEgyesMunkak�r�kF�oszt�lyai INNER JOIN lkMunkak�r�kK�rlev�lC�mzettek00 ON tEgyesMunkak�r�kF�oszt�lyai.F�oszt�ly = lkMunkak�r�kK�rlev�lC�mzettek00.BFKHF�osztK�d) ON lkMunkak�r�kK�rlev�lCsakALegfrissebbMaiMell�kletek.F�oszt�lyNeve = lkMunkak�r�kK�rlev�lC�mzettek00.F�oszt�ly;

-- [lkMunkak�r�kK�rlev�lCsakALegfrissebbMaiMell�kletek]
SELECT DISTINCT tMunkak�rK�rlev�lMell�klet�tvonalak.azMell�klet, tMunkak�rK�rlev�lMell�klet�tvonalak.F�oszt�lyNeve, tMunkak�rK�rlev�lMell�klet�tvonalak.�tvonal, tMunkak�rK�rlev�lMell�klet�tvonalak.K�sz�lt, DateValue([K�sz�lt]) AS D�tum
FROM tMunkak�rK�rlev�lMell�klet�tvonalak
WHERE (((tMunkak�rK�rlev�lMell�klet�tvonalak.K�sz�lt)=(Select Max([K�sz�lt]) from [tMunkak�rK�rlev�lMell�klet�tvonalak] as tmp where [tMunkak�rK�rlev�lMell�klet�tvonalak].[F�oszt�lyNeve]=tmp.f�oszt�lyneve)) AND ((DateValue([K�sz�lt]))=Date()));

-- [lkMunkav�gz�s helye - c�m n�lk�l]
SELECT lkSzem�lyek.[Munkav�gz�s helye - megnevez�s], N�([Munkav�gz�s helye - c�m],"") AS Kif1, Count(lkSzem�lyek.Ad�jel) AS CountOfAd�jel
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
GROUP BY lkSzem�lyek.[Munkav�gz�s helye - megnevez�s], N�([Munkav�gz�s helye - c�m],"")
HAVING (((N�([Munkav�gz�s helye - c�m],""))=""));

-- [lkMunkaviszonyHosszaKimutat�shoz01]
SELECT Year([Jogviszony v�ge (kil�p�s d�tuma)]) AS [Utols� �v], DateDiff("d",[Jogviszony kezdete (bel�p�s d�tuma)],[Jogviszony v�ge (kil�p�s d�tuma)])/365.25 AS [Elt�lt�tt �vek], tSzem�lyek.Ad�jel
FROM tSzem�lyek
WHERE (((Year([Jogviszony v�ge (kil�p�s d�tuma)]))<>1899));

-- [lkMunkaviszonyHosszaKimutat�shoz01 naponta]
SELECT Year([Jogviszony v�ge (kil�p�s d�tuma)]) AS [Utols� �v], DateDiff("d",[Jogviszony kezdete (bel�p�s d�tuma)],[Jogviszony v�ge (kil�p�s d�tuma)])/7 AS [Elt�lt�tt hetek], tSzem�lyek.Ad�jel
FROM tSzem�lyek
WHERE (((Year([Jogviszony v�ge (kil�p�s d�tuma)]))<>1899));

-- [lkMunkaviszonyHosszaKimutat�shoz02]
TRANSFORM Count(lkMunkaviszonyHosszaKimutat�shoz01.Ad�jel) AS Darabsz�m
SELECT lkMunkaviszonyHosszaKimutat�shoz01.[Utols� �v]
FROM lkMunkaviszonyHosszaKimutat�shoz01
GROUP BY lkMunkaviszonyHosszaKimutat�shoz01.[Utols� �v]
PIVOT Int([Elt�lt�tt �vek]);

-- [lkMunkaviszonyHosszaKimutat�shoz02 naponta]
TRANSFORM Count([lkMunkaviszonyHosszaKimutat�shoz01 naponta].Ad�jel) AS Darabsz�m
SELECT Int([Elt�lt�tt hetek]) AS [Hetek sz�ma]
FROM [lkMunkaviszonyHosszaKimutat�shoz01 naponta]
GROUP BY Int([Elt�lt�tt hetek])
PIVOT [lkMunkaviszonyHosszaKimutat�shoz01 naponta].[Utols� �v];

-- [lkMunkaviszonyosokBesorol�saF�oszt�lyOszt�ly]
SELECT lkSzem�lyek.[St�tusz k�dja], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], IIf([Besorol�si  fokozat (KT)] Is Null,[Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s],[Besorol�si  fokozat (KT)]) AS Besorol�s
FROM lkSzem�lyek INNER JOIN tSzervezet ON lkSzem�lyek.[St�tusz k�dja] = tSzervezet.[Szervezetmenedzsment k�d]
WHERE (((lkSzem�lyek.[KIRA jogviszony jelleg])="munkaviszony") And ((lkSzem�lyek.[St�tusz neve])="�ll�shely") And ((tSzervezet.[�rv�nyess�g kezdete])<=Date()) And ((IIf(tszervezet.[�rv�nyess�g v�ge]=0,#1/1/3000#,tszervezet.[�rv�nyess�g v�ge]))>=Date()))
ORDER BY IIf([Besorol�si  fokozat (KT)] Is Null,[Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s],[Besorol�si  fokozat (KT)]), lkSzem�lyek.BFKH, lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkNapok01]
SELECT ([�vek].[Sorsz�m])+2000 AS �v, Napok.Sorsz�m AS Nap, DateSerial([�v],1,1+[Nap]-1) AS D�tum
FROM lkSorsz�mok AS Napok, lkSorsz�mok AS �vek
WHERE �vek.Sorsz�m+2000 Between 2019 And Year(Date()) And Napok.Sorsz�m<367;

-- [lkNapok02]
SELECT lkNapok01.�v, lkNapok01.Nap, lkNapok01.D�tum INTO tNapok03
FROM lkNapok01
WHERE (((Year([D�tum]))=[�v]));

-- [lkNemJogosultakUtaz�siKedvezm�nyre]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], UNI�.Ad�jel, "F�osztR�v_" & [Dolgoz� teljes neve] & "_(" & [azNexon] & ")_utaz�si.pdf" AS F�jln�v
FROM kt_azNexon_Ad�jel02 INNER JOIN (lkSzem�lyek INNER JOIN (SELECT lkFordul�napt�lABel�p�sigEl�z�MunkahelyMunkanapjai.Ad�jel, lkFordul�napt�lABel�p�sigEl�z�MunkahelyMunkanapjai.Napok
FROM lkFordul�napt�lABel�p�sigEl�z�MunkahelyMunkanapjai
UNION SELECT lkFordul�napt�lEgy�vigMindenJogviszonyMunkanapjai.Ad�jel, lkFordul�napt�lEgy�vigMindenJogviszonyMunkanapjai.Napok
FROM lkFordul�napt�lEgy�vigMindenJogviszonyMunkanapjai)  AS UNI� ON lkSzem�lyek.Ad�jel = UNI�.Ad�jel) ON kt_azNexon_Ad�jel02.Ad�jel = UNI�.Ad�jel
WHERE (((lkSzem�lyek.F�oszt�ly)<>""))
GROUP BY lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], UNI�.Ad�jel, "F�osztR�v_" & [Dolgoz� teljes neve] & "_(" & [azNexon] & ")_utaz�si.pdf", lkSzem�lyek.BFKH
HAVING (((Sum(UNI�.Napok)) Between 1 And 365))
ORDER BY lkSzem�lyek.BFKH, lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkNemOrvos�ll�shelyekenDolgoz�Orvosok]
SELECT "" AS Sorsz�m, 789235 AS [PIR t�rzssz�m], lkSzem�lyek.[St�tusz k�dja] AS [az �ll�shely �NYR azonos�t� sz�ma], N�([Dolgoz� teljes neve],"�res") AS [a korm�nytisztvisel� neve], lkSzem�lyek.ad�jel AS [ad�azonos�t� jele (10 karakter)], lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS [a bel�p�s d�tuma], lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker] AS [a heti munkaid� tartama], "igen" AS [rendelkezik orvos v�gzetts�ggel], "?" AS [eg�szs�g�gyi alapnyilv�ntart�si sz�ma], lkSzem�lyek.[KIRA feladat megnevez�s] AS [a korm�nytisztvisel� feladatk�re], IIf([Besorol�si  fokozat (KT)] Like "*oszt�ly*",[Besorol�si  fokozat (KT)],"nincs") AS [a korm�nytisztvisel� vezet�i besorol�sa], IIf(Nz([St�tuszk�d],"-")="-",False,True) AS [Orvos �ll�shely], lkIlletm�nyT�rt�net.[Havi illetm�ny] AS [a Kit szerinti brutt� illetm�nye 2024 j�nius h�napban], lkIlletm�nyT�rt�net.[Besorol�si fokozat megnevez�se:] AS [a Kit szerinti besorol�si fokozata 2024 j�nius h�napban], lkSzem�lyek.[Besorol�si  fokozat (KT)] AS [a Kit szerinti brutt� illetm�nye 2024 j�lius h�napban], lkSzem�lyek.[Kerek�tett 100 %-os illetm�ny (elt�r�tett)] AS [a Kit szerinti besorol�si fokozata 2024 j�lius h�napban], lk�ll�shelyekHavib�l.F�oszt, lk�ll�shelyekHavib�l.Oszt�ly, lkSzem�lyek.FEOR, lkIlletm�nyT�rt�net.hat�lya, lkSzem�lyek.[Iskolai v�gzetts�g neve]
FROM lkIlletm�nyT�rt�net RIGHT JOIN (lkOrvosi�ll�shelyek RIGHT JOIN (lk�ll�shelyekHavib�l LEFT JOIN lkSzem�lyek ON lk�ll�shelyekHavib�l.[�ll�shely azonos�t�] = lkSzem�lyek.[St�tusz k�dja]) ON lkOrvosi�ll�shelyek.St�tuszk�d = lkSzem�lyek.[St�tusz k�dja]) ON lkIlletm�nyT�rt�net.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.FEOR) Like "*orvos*" And (lkSzem�lyek.FEOR) Not Like "*rvosi laborat�riumi asszisztens") AND ((lkIlletm�nyT�rt�net.hat�lya)=#6/30/2024#) AND ((lkSzem�lyek.[st�tusz neve])="�ll�shely") AND ((lkOrvosi�ll�shelyek.St�tuszk�d) Is Null)) OR (((lkIlletm�nyT�rt�net.hat�lya)=#6/30/2024#) AND ((lkSzem�lyek.[Iskolai v�gzetts�g neve]) Like "*orvos*") AND ((lkSzem�lyek.[st�tusz neve])="�ll�shely") AND ((lkOrvosi�ll�shelyek.St�tuszk�d) Is Null)) OR (((lkIlletm�nyT�rt�net.hat�lya)=#6/30/2024#) AND ((lkSzem�lyek.[Iskolai v�gzetts�g neve]) Like "*j�rv�ny*" And (lkSzem�lyek.[Iskolai v�gzetts�g neve])<>"k�zeg�szs�g�gyi - j�rv�ny�gyi ellen�r" And (lkSzem�lyek.[Iskolai v�gzetts�g neve])<>"k�zeg�szs�g�gyi - j�rv�ny�gyi fel�gyel�") AND ((lkSzem�lyek.[st�tusz neve])="�ll�shely") AND ((lkOrvosi�ll�shelyek.St�tuszk�d) Is Null));

-- [lkNemOrvos�ll�shelyekenDolgoz�OrvosokEllen�rz�sbe]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[St�tusz k�dja] AS �NYR, N�([Dolgoz� teljes neve],"�res") AS N�v, lkSzem�lyek.ad�jel AS Ad�azonos�t�, lkSzem�lyek.[KIRA feladat megnevez�s] AS [KIRA feladat], lkSzem�lyek.[Besorol�si  fokozat (KT)], lkSzem�lyek.FEOR, lkSzem�lyek.[Iskolai v�gzetts�g neve], kt_azNexon_Ad�jel02.NLink
FROM kt_azNexon_Ad�jel02 RIGHT JOIN (lkOrvosi�ll�shelyek RIGHT JOIN lkSzem�lyek ON lkOrvosi�ll�shelyek.St�tuszk�d = lkSzem�lyek.[St�tusz k�dja]) ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.FEOR) Like "*orvos*" And (lkSzem�lyek.FEOR) Not Like "*rvosi laborat�riumi asszisztens") AND ((lkSzem�lyek.[st�tusz neve])="�ll�shely") AND ((lkOrvosi�ll�shelyek.St�tuszk�d) Is Null)) OR (((lkSzem�lyek.[Iskolai v�gzetts�g neve]) Like "*orvos*") AND ((lkSzem�lyek.[st�tusz neve])="�ll�shely") AND ((lkOrvosi�ll�shelyek.St�tuszk�d) Is Null)) OR (((lkSzem�lyek.[Iskolai v�gzetts�g neve]) Like "*j�rv�ny*" And (lkSzem�lyek.[Iskolai v�gzetts�g neve])<>"k�zeg�szs�g�gyi - j�rv�ny�gyi ellen�r" And (lkSzem�lyek.[Iskolai v�gzetts�g neve])<>"k�zeg�szs�g�gyi - j�rv�ny�gyi fel�gyel�") AND ((lkSzem�lyek.[st�tusz neve])="�ll�shely") AND ((lkOrvosi�ll�shelyek.St�tuszk�d) Is Null));

-- [lkN�peg�szs�g�gyiDolgoz�k]
SELECT lkJ�r�siKorm�nyK�zpontos�tottUni�.Ad�azonos�t�, lkJ�r�siKorm�nyK�zpontos�tottUni�.N�v, lkJ�r�siKorm�nyK�zpontos�tottUni�.[Sz�let�si �v \ �res �ll�s], lkJ�r�siKorm�nyK�zpontos�tottUni�.Neme AS [Dolgoz� neme 1 f�rfi 2 n�], IIf([J�r�si Hivatal] Like "*ker�leti*",[J�r�si Hivatal],"Megyei szint") AS [Megyei szint], Replace([J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH") AS F�oszt�ly, lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly, lkJ�r�siKorm�nyK�zpontos�tottUni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Ell�tott feladat], lkJ�r�siKorm�nyK�zpontos�tottUni�.Kinevez�s, lkJ�r�siKorm�nyK�zpontos�tottUni�.[Feladat jellege: szakmai (SZ) / funkcion�lis (F) feladatell�t�s;], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Heti munka�r�k sz�ma], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Bet�lt�s ar�nya], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Besorol�si fokozat k�d:], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Besorol�si fokozat megnevez�se:], lkJ�r�siKorm�nyK�zpontos�tottUni�.[�ll�shely azonos�t�], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Havi illetm�ny], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Eu finansz�rozott], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Illetm�ny forr�sa], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is], lkJ�r�siKorm�nyK�zpontos�tottUni�.[�gyf�lszolg�lati munkat�rs (1) �gyf�lszolg�lati h�tt�r munkat�rs], lkJ�r�siKorm�nyK�zpontos�tottUni�.[K�pes�t�st ad� v�gzetts�g], Nz([Ad�azonos�t�],0)*1 AS Ad�jel, "" AS [J�r�si hivatal neve]
FROM lkJ�r�siKorm�nyK�zpontos�tottUni�
WHERE (((IIf([J�r�si Hivatal] Like "*ker�leti*",[J�r�si Hivatal],"Megyei szint")) Like "*XXI.*") AND ((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Ell�tott feladat]) Like "n�pe*")) OR (((Replace([J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH")) Like "N�peg*")) OR (((lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) Like "N�peg*"));

-- [lkN�peg�szs�g�gyiDolgoz�kAdatbek�r�]
SELECT lkN�peg�szs�g�gyiDolgoz�k.Ad�jel, lkN�peg�szs�g�gyiDolgoz�k.N�v, lkN�peg�szs�g�gyiDolgoz�k.F�oszt�ly, lkN�peg�szs�g�gyiDolgoz�k.Oszt�ly, "" AS [V�d�n�?], "" AS [Vezet� v�d�n�?], lkN�peg�szs�g�gyiDolgoz�k.Ad�azonos�t�
FROM lkN�peg�szs�g�gyiDolgoz�k
WHERE (((lkN�peg�szs�g�gyiDolgoz�k.Ad�azonos�t�) Is Not Null And (lkN�peg�szs�g�gyiDolgoz�k.Ad�azonos�t�)<>""))
ORDER BY lkN�peg�szs�g�gyiDolgoz�k.F�oszt�ly, lkN�peg�szs�g�gyiDolgoz�k.Oszt�ly, lkN�peg�szs�g�gyiDolgoz�k.N�v;

-- [lkNevek_IFB_r�sz�re]
SELECT tSzem�lyek.[Dolgoz� teljes neve], tSzervezetiEgys�gek.F�oszt�ly, tSzervezetiEgys�gek.Oszt�ly, tSzem�lyek.azonos�t�
FROM tSzem�lyek LEFT JOIN tSzervezetiEgys�gek ON tSzem�lyek.[Szervezeti egys�g k�dja] = tSzervezetiEgys�gek.[Szervezeti egys�g k�dja]
WHERE (((tSzem�lyek.azonos�t�) In (Select azSzem�ly FROM alkSzem�lyek_csak_az_utols�_el�fordul�sok)) AND ((tSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null) AND ((tSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null And (tSzem�lyek.[Szervezeti egys�g k�dja]) Not Like "*MEGB*") AND ((tSzem�lyek.[St�tusz k�dja]) Like "S-*"));

-- [lkNevek�sFikt�vT�rzssz�mok]
SELECT tUt�nevek.Keresztn�v, CalcStrNumber([Keresztn�v]) AS �rt�k
FROM tUt�nevek;

-- [lkNevekGyakoris�gSzerint]
SELECT lkSorsz�mok.Sorsz�m, lkUt�nevekGyakoris�ga.Keresztn�v
FROM lkUt�nevekGyakoris�ga, lkSorsz�mok
ORDER BY lkUt�nevekGyakoris�ga.Keresztn�v, lkSorsz�mok.Sorsz�m;

-- [lkNevekOlt�shoz]
SELECT tNevekOlt�shoz.Azonos�t�, tNevekOlt�shoz.F�oszt�ly, tNevekOlt�shoz.Oszt�ly, tNevekOlt�shoz.Oltand�k, drh�tra([Oltand�k]) AS DolgTeljNeve
FROM tNevekOlt�shoz;

-- [lkNevekSz�mokkal]
SELECT DISTINCT N�([lkszem�lyek].[F�oszt�ly],[lkKil�p�Uni�].[F�oszt�ly]) AS F�oszt�ly, N�([lkSzem�lyek].[Oszt�ly],[lkKil�p�Uni�].[Oszt�ly]) AS Oszt�ly, z�rojeltelen�t�([Dolgoz� teljes neve]) AS [Dolgoz� neve], z�rojeltelen�t�([Dolgoz� sz�let�si neve]) AS [Sz�let�si n�v], z�rojeltelen�t�([Anyja neve]) AS [Anyja sz�let�si neve], "Szem�lyi karton / Szem�lyes adatok / Alap adatok / SZEM�LYN�V ADATOK -> A sz�let�si n�vben, a viselt n�vben vagy az anyja nev�ben sz�mok szerepelnek" AS Megjegyz�s, kt_azNexon_Ad�jel02.NLink AS NLink
FROM lkKil�p�Uni� RIGHT JOIN (lkSzem�lyek LEFT JOIN kt_azNexon_Ad�jel02 ON lkSzem�lyek.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel) ON lkKil�p�Uni�.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((z�rojeltelen�t�([Dolgoz� teljes neve])) Like "*[0-9]*")) OR (((z�rojeltelen�t�([Dolgoz� sz�let�si neve])) Like "*[0-9]*")) OR (((z�rojeltelen�t�([Anyja neve])) Like "*[0-9]*"));

-- [lkNevekTajOlt�shoz01]
SELECT lkNevekOlt�shoz.F�oszt�ly, lkNevekOlt�shoz.Oszt�ly, lkNevekOlt�shoz.DolgTeljNeve, lkSzem�lyek.[TAJ sz�m], [Sz�let�si hely] & ", " & [Sz�let�si id�] AS [sz�l hely \ id�], lkSzem�lyek.[Anyja neve], lkSzem�lyek.[�lland� lakc�m], lkNevekOlt�shoz.Oltand�k, lkSzem�lyek.[Hivatali email]
FROM lkSzem�lyek RIGHT JOIN lkNevekOlt�shoz ON lkSzem�lyek.[Dolgoz� teljes neve]=lkNevekOlt�shoz.Oltand�k
WHERE (((lkSzem�lyek.[TAJ sz�m]) Is Not Null));

-- [lkNevekTajOlt�shoz02]
SELECT lkNevekOlt�shoz.F�oszt�ly, lkNevekOlt�shoz.Oszt�ly, lkNevekOlt�shoz.DolgTeljNeve, lkSzem�lyek.[TAJ sz�m], [Sz�let�si hely] & ", " & [Sz�let�si id�] AS [sz�l hely \ id�], lkSzem�lyek.[Anyja neve], lkSzem�lyek.[�lland� lakc�m], lkNevekOlt�shoz.Oltand�k, lkSzem�lyek.[Hivatali email]
FROM lkNevekOlt�shoz LEFT JOIN lkSzem�lyek ON lkNevekOlt�shoz.DolgTeljNeve=lkSzem�lyek.[Dolgoz� teljes neve]
WHERE (((lkSzem�lyek.[TAJ sz�m]) Is Not Null));

-- [lkNevekTajOlt�shoz03]
SELECT DISTINCT Uni�.F�oszt�ly, Uni�.Oszt�ly, Uni�.DolgTeljNeve, Uni�.[TAJ sz�m], Uni�.[sz�l hely \ id�], Uni�.[Anyja neve], Uni�.[�lland� lakc�m], Uni�.Oltand�k, *
FROM (SELECT  lkNevekTajOlt�shoz02.*
FROM lkNevekTajOlt�shoz02
UNION SELECT lkNevekTajOlt�shoz01.*
FROM  lkNevekTajOlt�shoz01
)  AS Uni�;

-- [lkNevekTajOlt�shoz04]
SELECT tNevekOlt�shoz.Azonos�t�, Nz(tNevekOlt�shoz.F�oszt�ly,"") AS F�oszt�ly_, Nz(tNevekOlt�shoz.Oszt�ly,"") AS Oszt�ly_, Trim(Replace(tNevekOlt�shoz.[Oltand�k],"dr.","")) AS N�v, tNevekOlt�shoz.Oltand�k
FROM tNevekOlt�shoz LEFT JOIN lkNevekTajOlt�shoz03 ON tNevekOlt�shoz.Oltand�k=lkNevekTajOlt�shoz03.Oltand�k
WHERE (((lkNevekTajOlt�shoz03.Oltand�k) Is Null));

-- [lkNevekTajOlt�shoz05]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[dolgoz� teljes neve] AS DolgTeljN�v, lkSzem�lyek.[TAJ sz�m], [Sz�let�si hely] & ", " & [Sz�let�si id�] AS [sz�l hely \ id�], lkSzem�lyek.[Anyja neve], lkSzem�lyek.[�lland� lakc�m], lkNevekTajOlt�shoz04.Oltand�k, lkSzem�lyek.[Hivatali email]
FROM lkSzem�lyek RIGHT JOIN lkNevekTajOlt�shoz04 ON (lkSzem�lyek.F�oszt�ly=lkNevekTajOlt�shoz04.F�oszt�ly_) AND (lkSzem�lyek.Oszt�ly=lkNevekTajOlt�shoz04.Oszt�ly_)
WHERE (((lkSzem�lyek.[dolgoz� teljes neve]) Like "*" & [N�v] & "*" Or (lkSzem�lyek.[dolgoz� teljes neve]) Like "*" & [Oltand�k] & "*"));

-- [lkNevekTajOlt�shoz06]
SELECT lkNevekTajOlt�shoz03.*
FROM lkNevekTajOlt�shoz03
UNION SELECT lkNevekTajOlt�shoz05.*
FROM lkNevekTajOlt�shoz05;

-- [lkNevekTajOlt�shoz07]
SELECT tNevekOlt�shoz.Azonos�t�, tNevekOlt�shoz.F�oszt�ly, tNevekOlt�shoz.Oszt�ly, tNevekOlt�shoz.Oltand�k
FROM tNevekOlt�shoz LEFT JOIN lkNevekTajOlt�shoz06 ON tNevekOlt�shoz.Oltand�k = lkNevekTajOlt�shoz06.Oltand�k
WHERE (((lkNevekTajOlt�shoz06.Oltand�k) Is Null));

-- [lkNevekT�bbSz�k�zzel]
SELECT lkSzem�lyek.F�oszt�ly AS F�oszt�ly, lkSzem�lyek.Oszt�ly AS Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Dolgoz� sz�let�si neve], lkSzem�lyek.[Anyja neve], "Szem�lyi karton / Szem�lyes adatok / Alap adatok / SZEM�LYN�V ADATOK vagy SZ�LET�SI ADATOK -> A sz�let�si, a viselt, vagy az anyja nev�ben t�l sok sz�k�z tal�lhat�, mivel egyet a rendszer automatikusan hozz�tesz. A k�t�jelek el�tt �s ut�n nem kell sz�k�z." AS Megjegyz�s, kt_azNexon_Ad�jel02.NLink AS NLink
FROM lkSzem�lyek LEFT JOIN kt_azNexon_Ad�jel02 ON lkSzem�lyek.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel
WHERE (((lkSzem�lyek.[Dolgoz� teljes neve]) Like "*  *" Or (lkSzem�lyek.[Dolgoz� teljes neve]) Like "*- *" Or (lkSzem�lyek.[Dolgoz� teljes neve]) Like "* -*") AND ((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])<Date())) OR (((lkSzem�lyek.[Dolgoz� sz�let�si neve]) Like "*  *") AND ((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])<Date())) OR (((lkSzem�lyek.[Dolgoz� sz�let�si neve]) Like "*- *") AND ((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])<Date())) OR (((lkSzem�lyek.[Dolgoz� sz�let�si neve]) Like "* -*") AND ((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])<Date())) OR (((lkSzem�lyek.[Anyja neve]) Like "*  *") AND ((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])<Date())) OR (((lkSzem�lyek.[Anyja neve]) Like "* -*") AND ((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])<Date())) OR (((lkSzem�lyek.[Anyja neve]) Like "*- *") AND ((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])<Date()));

-- [lkNexonForr�s�sszevet�s]
SELECT tNexonForr�s.[Forr�s Szem�ly azon#], kt_azNexon_Ad�jel02.azNexon, lkSzem�lyek.T�rzssz�m, lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS Bel�p�s, lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)] AS Kil�p�s, lkSzem�lyek.[St�tusz neve], lkSzem�lyek.F�oszt�ly
FROM (kt_azNexon_Ad�jel02 LEFT JOIN tNexonForr�s ON kt_azNexon_Ad�jel02.azNexon = tNexonForr�s.[NEXON szem�ly ID]) INNER JOIN lkSzem�lyek ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((tNexonForr�s.[NEXON szem�ly ID]) Is Null) AND ((lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)])>=Now())) OR (((tNexonForr�s.[NEXON szem�ly ID]) Is Null) AND ((lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)]) Is Null) AND ((lkSzem�lyek.[St�tusz neve])<>"Jegyz�")) OR (((tNexonForr�s.[NEXON szem�ly ID]) Is Not Null))
ORDER BY IIf(IsNull([Nexon szem�ly ID]),0,1), lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)];

-- [lkN�kL�tsz�ma01]
SELECT DISTINCT lkSzem�lyek.Ad�jel, 1 AS f�, Abs([Tart�s t�voll�t t�pusa] Is Null) AS TTn�lk�l
FROM lkSzem�lyek
WHERE (lkSzem�lyek.Neme="N�" AND lkSzem�lyek.[St�tusz neve]="�ll�shely");

-- [lkN�kL�tsz�ma02]
SELECT 2 AS Sor, "N�k l�tsz�ma:" AS Adat, Sum(lkN�kL�tsz�ma01.f�) AS �rt�k, Sum(lkN�kL�tsz�ma01.TTn�lk�l) AS NemTT
FROM lkN�kL�tsz�ma01
GROUP BY 2, "N�k l�tsz�ma:";

-- [lkN�kL�tsz�ma6�vAlattiGyermekkel]
SELECT 3 AS Sor, "N�k l�tsz�ma 6 �v alatti gyermekkel:" AS Adat, Sum(f�) AS �rt�k, Sum([TTn�lk�l]) AS NemTT
FROM (SELECT DISTINCT lkHozz�tartoz�k.[Dolgoz� ad�azonos�t� jele], 1 AS f�, Abs([Tart�s t�voll�t t�pusa] Is Null) AS TTn�lk�l FROM lkHozz�tartoz�k INNER JOIN lkSzem�lyek ON lkHozz�tartoz�k.Ad�jel = lkSzem�lyek.Ad�jel WHERE lkSzem�lyek.Neme="N�" And lkSzem�lyek.[St�tusz neve]="�ll�shely" And lkHozz�tartoz�k.[Sz�let�si id�]>DateSerial(Year(Now())-6,Month(Now()),Day(Now())) And (lkHozz�tartoz�k.[Kapcsolat jellege]="Gyermek" Or lkHozz�tartoz�k.[Kapcsolat jellege]="Nevelt (mostoha)" Or lkHozz�tartoz�k.[Kapcsolat jellege]="�r�kbe fogadott"))  AS allek�rdez�sEgyedi;

-- [lkNyelvtud�sOszt�lyonk�nt]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, Sum([Nyelvtud�s Angol]="IGEN") AS Angol, Sum([Nyelvtud�s Arab]="IGEN") AS Arab, Sum([Nyelvtud�s Bolg�r]="IGEN") AS Bolg�r, Sum([Nyelvtud�s Cig�ny]="IGEN") AS Cig�ny, Sum([Nyelvtud�s Cig�ny (lov�ri)]="IGEN") AS [Cig�ny (lov�ri)], Sum([Nyelvtud�s Cseh]="IGEN") AS Cseh, Sum([Nyelvtud�s Eszperant�]="IGEN") AS Eszperant�, Sum([Nyelvtud�s Finn]="IGEN") AS Finn, Sum([Nyelvtud�s Francia]="IGEN") AS Francia, Sum([Nyelvtud�s H�ber]="IGEN") AS H�ber, Sum([Nyelvtud�s Holland]="IGEN") AS Holland, Sum([Nyelvtud�s Horv�t]="IGEN") AS Horv�t, Sum([Nyelvtud�s Jap�n]="IGEN") AS Jap�n, Sum([Nyelvtud�s Jelnyelv]="IGEN") AS Jelnyelv, Sum([Nyelvtud�s K�nai]="IGEN") AS K�nai, Sum([Nyelvtud�s Latin]="IGEN") AS Latin, Sum([Nyelvtud�s Lengyel]="IGEN") AS Lengyel, Sum([Nyelvtud�s N�met]="IGEN") AS N�met, Sum([Nyelvtud�s Norv�g]="IGEN") AS Norv�g, Sum([Nyelvtud�s Olasz]="IGEN") AS Olasz, Sum([Nyelvtud�s Orosz]="IGEN") AS Orosz, Sum([Nyelvtud�s Portug�l]="IGEN") AS Portug�l, Sum([Nyelvtud�s Rom�n]="IGEN") AS Rom�n, Sum([Nyelvtud�s Spanyol]="IGEN") AS Spanyol, Sum([Nyelvtud�s Szerb]="IGEN") AS Szerb, Sum([Nyelvtud�s Szlov�k]="IGEN") AS Szlov�k, Sum([Nyelvtud�s Szlov�n]="IGEN") AS Szlov�n, Sum([Nyelvtud�s T�r�k]="IGEN") AS T�r�k, Sum([Nyelvtud�s �jg�r�g]="IGEN") AS �jg�r�g, Sum([Nyelvtud�s Ukr�n]="IGEN") AS Ukr�n
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
GROUP BY lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.BFKH, lkSzem�lyek.[St�tusz neve]
ORDER BY lkSzem�lyek.BFKH;

-- [lkNyugd�jazand�Dolgoz�k]
SELECT lkSzem�lyek.[Dolgoz� teljes neve], DateSerial(Year(Nz([Sz�let�si id�],#1/1/1900#))+65,Month(Nz([Sz�let�si id�],#1/1/1900#)),Day(Nz([Sz�let�si id�],#1/1/1900#))) AS [Nyugd�jkorhat�rt bet�lti], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.Besorol�s2
FROM lkSzem�lyek
WHERE (((DateSerial(Year(Nz([Sz�let�si id�],#1/1/1900#))+65,Month(Nz([Sz�let�si id�],#1/1/1900#)),Day(Nz([Sz�let�si id�],#1/1/1900#)))) Between Date() And DateAdd("m",18,Date())) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY DateSerial(Year(Nz([Sz�let�si id�],#1/1/1900#))+65,Month(Nz([Sz�let�si id�],#1/1/1900#)),Day(Nz([Sz�let�si id�],#1/1/1900#))), Month([Sz�let�si id�]);

-- [lkNyugd�jazand�Dolgoz�kHavonta]
SELECT Year(IIf([Nyugd�jkorhat�rt bet�lti]<Date(),Date(),[Nyugd�jkorhat�rt bet�lti])) & "." & IIf(Len(Month(IIf([Nyugd�jkorhat�rt bet�lti]<Date(),Date(),[Nyugd�jkorhat�rt bet�lti])))<2,0,"") & Month(IIf([Nyugd�jkorhat�rt bet�lti]<Date(),Date(),[Nyugd�jkorhat�rt bet�lti])) AS �v_h�nap, Count(lkNyugd�jazand�Dolgoz�k.[Dolgoz� teljes neve]) AS F�
FROM lkNyugd�jazand�Dolgoz�k
GROUP BY Year(IIf([Nyugd�jkorhat�rt bet�lti]<Date(),Date(),[Nyugd�jkorhat�rt bet�lti])) & "." & IIf(Len(Month(IIf([Nyugd�jkorhat�rt bet�lti]<Date(),Date(),[Nyugd�jkorhat�rt bet�lti])))<2,0,"") & Month(IIf([Nyugd�jkorhat�rt bet�lti]<Date(),Date(),[Nyugd�jkorhat�rt bet�lti]));

-- [lkNyugd�jazand�Dolgoz�kN�k40]
SELECT lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Sz�let�si id�], DateSerial(Year(Nz([Sz�let�si id�],#1/1/1900#))+65,Month(Nz([Sz�let�si id�],#1/1/1900#)),Day(Nz([Sz�let�si id�],#1/1/1900#))) AS [65_ �let�v�t bet�lti], DateSerial(Year(Nz([Sz�let�si id�],#1/1/1900#))+58,Month(Nz([Sz�let�si id�],#1/1/1900#)),Day(Nz([Sz�let�si id�],#1/1/1900#))) AS [58_ �let�v�t bet�lti], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.Besorol�s2 AS Besorol�s, lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus] AS Jogviszony, lkSzem�lyek.Neme, Year(Date())-ffsplit(Nz([Szolg�lati elismer�sre jogosults�g / Jubileumi jutalom kezd� d�t],Year(Date())),".",1)*1 AS [Szolg�lati �vek]
FROM lkSzem�lyek LEFT JOIN lkSzolg�latiId�Elismer�s ON lkSzem�lyek.Ad�jel=lkSzolg�latiId�Elismer�s.Ad�jel
WHERE (((DateSerial(Year(Nz([Sz�let�si id�],#1/1/1900#))+58,Month(Nz([Sz�let�si id�],#1/1/1900#)),Day(Nz([Sz�let�si id�],#1/1/1900#)))) Between Date() And DateAdd("m",18,Date())) AND ((lkSzem�lyek.Neme)="n�") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND (("Keress�k azokat a n�ket, akik az 58. sz�let�snapjukat a k�vetkez� 18 h�napban t�ltik be.")=True)) OR (((DateSerial(Year(Nz([Sz�let�si id�],#1/1/1900#))+65,Month(Nz([Sz�let�si id�],#1/1/1900#)),Day(Nz([Sz�let�si id�],#1/1/1900#))))>Date()) AND ((DateSerial(Year(Nz([Sz�let�si id�],#1/1/1900#))+58,Month(Nz([Sz�let�si id�],#1/1/1900#)),Day(Nz([Sz�let�si id�],#1/1/1900#))))<Date()) AND ((lkSzem�lyek.Neme)="n�") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND (("Keress�k azokat a n�ket, akik m�g nem t�lt�tt�k be a 65. �let�v�ket, de az 58. m�r igen.")=True))
ORDER BY Year([Sz�let�si id�])+58, Month([Sz�let�si id�]);

-- [lkNyugd�jazand�Dolgoz�kN�k40Havonta]
SELECT Year(IIf([58_ �let�v�t bet�lti]<Date(),Date(),[58_ �let�v�t bet�lti])) & "." & IIf(Len(Month(IIf([58_ �let�v�t bet�lti]<Date(),Date(),[58_ �let�v�t bet�lti])))<2,0,"") & Month(IIf([58_ �let�v�t bet�lti]<Date(),Date(),[58_ �let�v�t bet�lti])) AS H�napok, Count(lkNyugd�jazand�Dolgoz�kN�k40.[Dolgoz� teljes neve]) AS L�tsz�m
FROM lkNyugd�jazand�Dolgoz�kN�k40
GROUP BY Year(IIf([58_ �let�v�t bet�lti]<Date(),Date(),[58_ �let�v�t bet�lti])) & "." & IIf(Len(Month(IIf([58_ �let�v�t bet�lti]<Date(),Date(),[58_ �let�v�t bet�lti])))<2,0,"") & Month(IIf([58_ �let�v�t bet�lti]<Date(),Date(),[58_ �let�v�t bet�lti]));

-- [lkNyugd�jazand�Vezet�k]
SELECT Year([Sz�let�si id�])+65 AS �v, Format([Sz�let�si id�],"mmmm") AS H�, Format([sz�let�si id�],"dd") AS Nap, lkMindenVezet�.[Dolgoz� teljes neve] AS N�v, lkMindenVezet�.F�oszt�ly, lkMindenVezet�.Oszt�ly, lkMindenVezet�.Besorol�s2 AS Besorol�s
FROM lkMindenVezet�
WHERE (((lkMindenVezet�.[Sz�let�si id�]) Between DateAdd("yyyy",-61,Date()) And DateAdd("yyyy",-65,Date())))
ORDER BY lkMindenVezet�.[Sz�let�si id�], lkMindenVezet�.BFKH;

-- [lkNyugd�jazott�sNyugd�jazand�Vezet�kK�tD�tumK�z�tt01]
SELECT lkMindenKil�pettVezet�.Ad�jel, lkMindenKil�pettVezet�.N�v, lkMindenKil�pettVezet�.F�oszt�ly, lkMindenKil�pettVezet�.Oszt�ly, lkMindenKil�pettVezet�.[Besorol�si fokozat megnevez�se:], lkMindenKil�pettVezet�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek oka: jogszab�lyi hiva], lkMindenKil�pettVezet�.Kil�p�s AS [Kil�p�s d�tuma]
FROM lkMindenKil�pettVezet�
WHERE (((lkMindenKil�pettVezet�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek oka: jogszab�lyi hiva])="A korm�nytisztvisel� k�relm�re a t�rsadalombiztos�t�si nyugell�t�sr�l sz�l� 1997. �vi LXXXI. tv. 18. � (2a) bekezd�s�ben foglalt felt�tel fenn�ll�sa miatt [Kit. 107. � (2) bek. e) pont, 105. � (1) bekezd�s c]") AND ((lkMindenKil�pettVezet�.Kil�p�s) Between [a Kil�p�s legkor�bbi d�tuma] And [A Kil�p�s legk�s�bbi d�tuma])) OR (((lkMindenKil�pettVezet�.Kil�p�s)>=DateSerial(Year([sz�let�si d�tum])+65,Month([Sz�let�si d�tum]),Day([Sz�let�si d�tum])-1) And (lkMindenKil�pettVezet�.Kil�p�s) Between [a Kil�p�s legkor�bbi d�tuma] And [A Kil�p�s legk�s�bbi d�tuma]));

-- [lkNyugd�jazott�sNyugd�jazand�Vezet�kK�tD�tumK�z�tt02]
SELECT lkMindenVezet�.Ad�jel, lkMindenVezet�.[Dolgoz� teljes neve], lkMindenVezet�.F�oszt�ly, lkMindenVezet�.Oszt�ly, lkMindenVezet�.[Ell�tott feladat] AS [Besorol�si fokozat], "" AS Jogvmegsz, lkMindenVezet�.[�regs�gi nyugd�j korhat�r] AS [Kil�p�s d�tuma]
FROM lkMindenVezet�
WHERE (((lkMindenVezet�.[�regs�gi nyugd�j korhat�r])>[A Kil�p�s legkor�bbi d�tuma] And (lkMindenVezet�.[�regs�gi nyugd�j korhat�r])<[A Kil�p�s legk�s�bbi d�tuma] And (lkMindenVezet�.[�regs�gi nyugd�j korhat�r])<=IIf([Kil�p�s]=0,#1/1/3000#,[kil�p�s])));

-- [lkNyugd�jazott�sNyugd�jazand�Vezet�kK�tD�tumK�z�tt03]
SELECT DISTINCT lkNyugd�jazott�sNyugd�jazand�Vezet�kK�tD�tumK�z�tt01.*
FROM lkNyugd�jazott�sNyugd�jazand�Vezet�kK�tD�tumK�z�tt01
UNION SELECT lkNyugd�jazott�sNyugd�jazand�Vezet�kK�tD�tumK�z�tt02.*
FROM  lkNyugd�jazott�sNyugd�jazand�Vezet�kK�tD�tumK�z�tt02;

-- [lkororszukr�nyNyelvvizsg�k20240912]
SELECT Nz([Dolgoz� azonos�t�],0)*1 AS Ad�jel, tOroszUkr�nNyelvvizsg�k20240912.*
FROM tOroszUkr�nNyelvvizsg�k20240912;

-- [lkoroszukr�nV�gzetts�g]
SELECT DISTINCT lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Hivatali email], lkSzem�lyek.[Hivatali telefon], lkV�gzetts�gek.[V�gzetts�g neve]
FROM lkV�gzetts�gek INNER JOIN lkSzem�lyek ON lkV�gzetts�gek.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkV�gzetts�gek.[V�gzetts�g neve]) Like "*" & [idegen_nyelv] & "*"));

-- [lkoroszukr�nNyelvtud�sSzem�lyt�rzsb�l]
SELECT lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Hivatali email], lkSzem�lyek.[Hivatali telefon], lkororszukr�nyNyelvvizsg�k20240912.[Nyelv neve], lkororszukr�nyNyelvvizsg�k20240912.[Nyelvvizsga foka], lkororszukr�nyNyelvvizsg�k20240912.[Nyelvvizsga t�pusa], lkSzem�lyek.[St�tusz neve]
FROM lkororszukr�nyNyelvvizsg�k20240912 LEFT JOIN lkSzem�lyek ON lkororszukr�nyNyelvvizsg�k20240912.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[Nyelvtud�s Orosz])<>"") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkSzem�lyek.[Nyelvtud�s Ukr�n])<>"") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [lkOrvos�ll�shelyekenDolgoz�k]
SELECT lkOrvosi�ll�shelyekSorsz�ma.Sor AS Sorsz�m, 789235 AS [PIR t�rzssz�m], lk�ll�shelyekHavib�l.[�ll�shely azonos�t�] AS [az �ll�shely �NYR azonos�t� sz�ma], N�([Dolgoz� teljes neve],"�res") AS [a korm�nytisztvisel� neve], lkSzem�lyek.ad�jel AS [ad�azonos�t� jele (10 karakter)], lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS [a bel�p�s d�tuma], lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker] AS [a heti munkaid� tartama], IIf(IsNull([Dolgoz� teljes neve]),"","igen") AS [rendelkezik orvos v�gzetts�ggel], lkOrvosokAdatai.Nyilv�ntart�siSz�m AS [eg�szs�g�gyi alapnyilv�ntart�si sz�ma], lkSzem�lyek.[KIRA feladat megnevez�s] AS [a korm�nytisztvisel� feladatk�re], IIf([Besorol�si  fokozat (KT)] Like "*oszt�ly*",[Besorol�si  fokozat (KT)],"nincs") AS [a korm�nytisztvisel� vezet�i besorol�sa], IIf(Nz([St�tuszk�d],"-")="-",False,True) AS [Orvos �ll�shely], lkIlletm�nyT�rt�net.[Havi illetm�ny] AS [a Kit szerinti brutt� illetm�nye 2024 j�nius h�napban], lkIlletm�nyT�rt�net.[Besorol�si fokozat megnevez�se:] AS [a Kit szerinti besorol�si fokozata 2024 j�nius h�napban], lkSzem�lyek.[Kerek�tett 100 %-os illetm�ny (elt�r�tett)] AS [a Kit szerinti illetm�nye 2024 j�lius h�napban], lk�ll�shelyekHavib�l.F�oszt, lk�ll�shelyekHavib�l.Oszt�ly, lkSzem�lyek.FEOR, lkSzem�lyek.[Iskolai v�gzetts�g neve], lkSzem�lyek.[KIRA feladat megnevez�s], lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[Besorol�si  fokozat (KT)], lkOrvosokAdatai.EszmeiId�Kezdete, DateDiff("yyyy",[EszmeiId�Kezdete],Now()) AS �vekSz�ma, lkOrvosokAdatai.EszjtvBesorol�sSzerintiIlletm�ny
FROM lkOrvosokAdatai RIGHT JOIN (lkOrvosi�ll�shelyekSorsz�ma RIGHT JOIN ((lkIlletm�nyT�rt�net RIGHT JOIN lkSzem�lyek ON lkIlletm�nyT�rt�net.Ad�jel = lkSzem�lyek.Ad�jel) RIGHT JOIN (lkOrvosi�ll�shelyek RIGHT JOIN lk�ll�shelyekHavib�l ON lkOrvosi�ll�shelyek.St�tuszk�d = lk�ll�shelyekHavib�l.[�ll�shely azonos�t�]) ON lkSzem�lyek.[St�tusz k�dja] = lkOrvosi�ll�shelyek.St�tuszk�d) ON lkOrvosi�ll�shelyekSorsz�ma.St�tuszk�d = lkOrvosi�ll�shelyek.St�tuszk�d) ON lkOrvosokAdatai.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkOrvosi�ll�shelyek.St�tuszk�d) Is Not Null) AND ((lkSzem�lyek.[st�tusz neve])="�ll�shely" Or (lkSzem�lyek.[st�tusz neve]) Is Null) AND ((lkIlletm�nyT�rt�net.hat�lya)=#6/30/2024# Or (lkIlletm�nyT�rt�net.hat�lya) Is Null));

-- [lkOrvos�ll�shelyekenDolgoz�kEllen�rz�sbe]
SELECT lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lk�ll�shelyekHavib�l.[�ll�shely azonos�t�] AS [az �ll�shely �NYR azonos�t� sz�ma], lk�ll�shelyekHavib�l.F�oszt, lk�ll�shelyekHavib�l.Oszt�ly, lkSzem�lyek.[Iskolai v�gzetts�g neve], lkSzem�lyek.[KIRA feladat megnevez�s], lkSzem�lyek.FEOR, lkSzem�lyek.[Besorol�si  fokozat (KT)]
FROM lkSzem�lyek RIGHT JOIN (lkOrvosi�ll�shelyek RIGHT JOIN lk�ll�shelyekHavib�l ON lkOrvosi�ll�shelyek.St�tuszk�d = lk�ll�shelyekHavib�l.[�ll�shely azonos�t�]) ON lkSzem�lyek.[St�tusz k�dja] = lkOrvosi�ll�shelyek.St�tuszk�d
WHERE (((lkOrvosi�ll�shelyek.St�tuszk�d) Is Not Null) AND ((lkSzem�lyek.[st�tusz neve])="�ll�shely" Or (lkSzem�lyek.[st�tusz neve]) Is Null));

-- [lkOrvos�ll�shelyekenDolgoz�kEllen�rz�sbe_arch�v]
SELECT lkOrvos�ll�shelyekenDolgoz�k.N�v, lkOrvos�ll�shelyekenDolgoz�k.[az �ll�shely �NYR azonos�t� sz�ma], lkOrvos�ll�shelyekenDolgoz�k.F�oszt, lkOrvos�ll�shelyekenDolgoz�k.Oszt�ly, lkOrvos�ll�shelyekenDolgoz�k.[Iskolai v�gzetts�g neve], lkOrvos�ll�shelyekenDolgoz�k.[KIRA feladat megnevez�s], lkOrvos�ll�shelyekenDolgoz�k.FEOR, lkOrvos�ll�shelyekenDolgoz�k.[Besorol�si  fokozat (KT)]
FROM lkOrvos�ll�shelyekenDolgoz�k;

-- [lkOrvos�ll�shelyekenDolgoz�kKEHI01]
SELECT lkOrvos�ll�shelyekenDolgoz�k.Sorsz�m, lkOrvos�ll�shelyekenDolgoz�k.[PIR t�rzssz�m], lkOrvos�ll�shelyekenDolgoz�k.[az �ll�shely �NYR azonos�t� sz�ma], lkOrvos�ll�shelyekenDolgoz�k.[a korm�nytisztvisel� neve], lkOrvos�ll�shelyekenDolgoz�k.[ad�azonos�t� jele (10 karakter)], lkOrvos�ll�shelyekenDolgoz�k.[Sz�let�si id�], lkOrvos�ll�shelyekenDolgoz�k.[a bel�p�s d�tuma], lkOrvos�ll�shelyekenDolgoz�k.[a heti munkaid� tartama], lkOrvos�ll�shelyekenDolgoz�k.[rendelkezik orvos v�gzetts�ggel], lkOrvos�ll�shelyekenDolgoz�k.[eg�szs�g�gyi alapnyilv�ntart�si sz�ma], lkOrvos�ll�shelyekenDolgoz�k.[a korm�nytisztvisel� feladatk�re], lkOrvos�ll�shelyekenDolgoz�k.[a korm�nytisztvisel� vezet�i besorol�sa], lkOrvos�ll�shelyekenDolgoz�k.[Orvos �ll�shely], lkOrvos�ll�shelyekenDolgoz�k.[a Kit szerinti brutt� illetm�nye 2024 j�nius h�napban], lkOrvos�ll�shelyekenDolgoz�k.[a Kit szerinti besorol�si fokozata 2024 j�nius h�napban], lkOrvos�ll�shelyekenDolgoz�k.[a Kit szerinti brutt� illetm�nye 2024 j�nius h�napban], lkOrvos�ll�shelyekenDolgoz�k.F�oszt, lkOrvos�ll�shelyekenDolgoz�k.Oszt�ly, lkOrvos�ll�shelyekenDolgoz�k.FEOR, lkOrvos�ll�shelyekenDolgoz�k.[Iskolai v�gzetts�g neve], lkOrvos�ll�shelyekenDolgoz�k.[KIRA feladat megnevez�s], lkOrvos�ll�shelyekenDolgoz�k.N�v, lkOrvos�ll�shelyekenDolgoz�k.[Besorol�si  fokozat (KT)], lkOrvos�ll�shelyekenDolgoz�k.EszmeiId�Kezdete, lkOrvos�ll�shelyekenDolgoz�k.�vekSz�ma, EszjtvBesorol�siKateg�ri�k.EszjtvBesorol�siKateg�ri�k, lkOrvos�ll�shelyekenDolgoz�k.EszjtvBesorol�sSzerintiIlletm�ny
FROM lkOrvos�ll�shelyekenDolgoz�k, EszjtvBesorol�siKateg�ri�k
WHERE (((EszjtvBesorol�siKateg�ri�k.Max)>=[�vekSz�ma]) AND ((EszjtvBesorol�siKateg�ri�k.Min)<=[�vekSz�ma]));

-- [lkOrvos�ll�shelyekenDolgoz�kKEHI02]
SELECT lkOrvos�ll�shelyekenDolgoz�k.Sorsz�m, lkOrvos�ll�shelyekenDolgoz�k.[PIR t�rzssz�m], lkOrvos�ll�shelyekenDolgoz�k.[az �ll�shely �NYR azonos�t� sz�ma], lkOrvos�ll�shelyekenDolgoz�k.[a korm�nytisztvisel� neve], lkOrvos�ll�shelyekenDolgoz�k.[ad�azonos�t� jele (10 karakter)], lkOrvos�ll�shelyekenDolgoz�k.[Sz�let�si id�], lkOrvos�ll�shelyekenDolgoz�k.[a bel�p�s d�tuma], lkOrvos�ll�shelyekenDolgoz�k.[a heti munkaid� tartama], lkOrvos�ll�shelyekenDolgoz�k.[rendelkezik orvos v�gzetts�ggel], lkOrvos�ll�shelyekenDolgoz�k.[eg�szs�g�gyi alapnyilv�ntart�si sz�ma], lkOrvos�ll�shelyekenDolgoz�k.[a korm�nytisztvisel� feladatk�re], lkOrvos�ll�shelyekenDolgoz�k.[a korm�nytisztvisel� vezet�i besorol�sa], lkOrvos�ll�shelyekenDolgoz�k.[Orvos �ll�shely], lkOrvos�ll�shelyekenDolgoz�k.[a Kit szerinti brutt� illetm�nye 2024 j�nius h�napban], lkOrvos�ll�shelyekenDolgoz�k.[a Kit szerinti besorol�si fokozata 2024 j�nius h�napban], lkOrvos�ll�shelyekenDolgoz�k.[a Kit szerinti illetm�nye 2024 j�lius h�napban], lkOrvos�ll�shelyekenDolgoz�k.F�oszt, lkOrvos�ll�shelyekenDolgoz�k.Oszt�ly, lkOrvos�ll�shelyekenDolgoz�k.FEOR, lkOrvos�ll�shelyekenDolgoz�k.[Iskolai v�gzetts�g neve], lkOrvos�ll�shelyekenDolgoz�k.[KIRA feladat megnevez�s], lkOrvos�ll�shelyekenDolgoz�k.N�v, lkOrvos�ll�shelyekenDolgoz�k.[Besorol�si  fokozat (KT)], lkOrvos�ll�shelyekenDolgoz�k.EszmeiId�Kezdete, lkOrvos�ll�shelyekenDolgoz�k.�vekSz�ma, "" AS EszjtvBesorol�siKateg�ri�k, 0 AS EszjtvBesorol�sSzerintiIlletm�ny
FROM lkOrvos�ll�shelyekenDolgoz�k
WHERE (((lkOrvos�ll�shelyekenDolgoz�k.[a korm�nytisztvisel� neve])="�res"));

-- [lkOrvos�ll�shelyekenDolgoz�kKEHI03]
SELECT �resek�sKateg�ri�zottak.*, *
FROM (SELECT lkOrvos�ll�shelyekenDolgoz�kKEHI02.*
from lkOrvos�ll�shelyekenDolgoz�kKEHI02 union
SELECT lkOrvos�ll�shelyekenDolgoz�kKEHI01.*
FROM lkOrvos�ll�shelyekenDolgoz�kKEHI01)  AS �resek�sKateg�ri�zottak;

-- [lkOrvos�ll�shelyekenDolgoz�NemOrvosokEllen�rz�sbe]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[Besorol�si  fokozat (KT)], lkSzem�lyek.[St�tusz k�dja] AS �NYR, lkSzem�lyek.[KIRA feladat megnevez�s] AS [KIRA feladat], lkSzem�lyek.FEOR, lkSzem�lyek.[Iskolai v�gzetts�g neve], kt_azNexon_Ad�jel02.NLink
FROM kt_azNexon_Ad�jel02 RIGHT JOIN (lkSzem�lyek RIGHT JOIN lkOrvosi�ll�shelyek ON lkSzem�lyek.[St�tusz k�dja] = lkOrvosi�ll�shelyek.St�tuszk�d) ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[Iskolai v�gzetts�g neve]) Not Like "*orvos*") AND ((([lkSzem�lyek].[FEOR]) Like "*orvos*" And ([lkSzem�lyek].[FEOR]) Not Like "*rvosi laborat�riumi asszisztens")=False) AND ((([lkSzem�lyek].[Iskolai v�gzetts�g neve]) Like "*j�rv�ny*" And ([lkSzem�lyek].[Iskolai v�gzetts�g neve])<>"k�zeg�szs�g�gyi - j�rv�ny�gyi ellen�r" And ([lkSzem�lyek].[Iskolai v�gzetts�g neve])<>"k�zeg�szs�g�gyi - j�rv�ny�gyi fel�gyel�")=False) AND ((lkSzem�lyek.[st�tusz neve])="�ll�shely"));

-- [lkOrvos�ll�shelyekr�lJelent�s]
SELECT lkOrvos�ll�shelyekenDolgoz�k.N�v, lkOrvos�ll�shelyekenDolgoz�k.St�tuszk�d, lkOrvos�ll�shelyekenDolgoz�k.F�oszt, lkOrvos�ll�shelyekenDolgoz�k.Oszt�ly, lkOrvos�ll�shelyekenDolgoz�k.[Iskolai v�gzetts�g neve], lkOrvos�ll�shelyekenDolgoz�k.[KIRA feladat megnevez�s], lkOrvos�ll�shelyekenDolgoz�k.FEOR, lkOrvos�ll�shelyekenDolgoz�k.[Besorol�si  fokozat (KT)], lkOrvos�ll�shelyekenDolgoz�k.Szint, lkOrvos�ll�shelyekenDolgoz�k.tisztif�orvos, lkOrvos�ll�shelyekenDolgoz�k.helyettes, lkOrvos�ll�shelyekenDolgoz�k.[k�zeg�szs�g-, vagy j�rv�ny�gyi], lkOrvos�ll�shelyekenDolgoz�k.Eg�szs�gbiztos�t�si, lkOrvos�ll�shelyekenDolgoz�k.Rehabilit�ci�s, [lkOrvosok].[St�tusz k�dja] Is Not Null AS Orvos
FROM (lkOrvos�ll�shelyekenDolgoz�k LEFT JOIN lkOrvosok ON lkOrvos�ll�shelyekenDolgoz�k.St�tuszk�d = lkOrvosok.[St�tusz k�dja]) LEFT JOIN lkSzem�lyek ON lkOrvos�ll�shelyekenDolgoz�k.Ad�jel = lkSzem�lyek.Ad�jel;

-- [lkOrvosiAlkalmass�giVizsg�latEl�z�H�nap]
SELECT lkSzem�lyek.[TAJ sz�m], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Orvosi vizsg�lat id�pontja]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Orvosi vizsg�lat id�pontja]) Between DateSerial(Year(Now()),Month(Now())-1,1) And DateSerial(Year(Now()),Month(Now()),0)))
ORDER BY lkSzem�lyek.BFKH, lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkOrvosi�ll�shelyek]
SELECT tOrvosi�ll�shelyek.azOrvosi�ll�shely, tOrvosi�ll�shelyek.[alapl�tsz�mba tartoz� orvosi  �ll�shely azonos�t�ja] AS St�tuszk�d, tOrvosi�ll�shelyek.Hat�lyKezdet AS [Utols� hat�ly], tOrvosi�ll�shelyek.Hat�lyV�g
FROM tOrvosi�ll�shelyek
WHERE (((tOrvosi�ll�shelyek.Hat�lyV�g) Is Null) AND (("Eredetileg ez volt:(Select Max(Hat�ly) From [tOrvosi�ll�shelyek] as tmp Where [tOrvosi�ll�shelyek].[alapl�tsz�mba tartoz� orvosi  �ll�shely azonos�t�ja]=tmp.[alapl�tsz�mba tartoz� orvosi  �ll�shely azonos�t�ja])")<>""));

-- [lkOrvosi�ll�shelyekSorsz�ma]
SELECT (Select count([St�tuszk�d]) From lkOrvosi�ll�shelyek as Tmp Where Tmp.[St�tuszk�d]>=lkOrvosi�ll�shelyek.[St�tuszk�d]) AS Sor, lkOrvosi�ll�shelyek.St�tuszk�d
FROM lkOrvosi�ll�shelyek
ORDER BY lkOrvosi�ll�shelyek.St�tuszk�d DESC;

-- [lkOrvosiVizsg�latHum�n]
SELECT Month([Jogviszony kezdete (bel�p�s d�tuma)]) AS [Bel�p�s h�napja], IIf([Orvosi vizsg�lat k�vetkez� id�pontja]<DateAdd("m",1,DateSerial(Year(Now()),Month(Now()),1))-1,"Lej�r�","") AS Lej�r�k, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[TAJ sz�m], lkSzem�lyek.[Hivatali email], lkSzem�lyek.[Hivatali mobil], lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.[Sz�let�si hely], lkSzem�lyek.[Anyja neve], lkSzem�lyek.Neme, lkSzem�lyek.[�lland� lakc�m], lkSzem�lyek.[Szervezeti egys�g neve], lkSzem�lyek.[Orvosi vizsg�lat id�pontja], lkSzem�lyek.[Orvosi vizsg�lat t�pusa], lkSzem�lyek.[Orvosi vizsg�lat eredm�nye], lkSzem�lyek.[Orvosi vizsg�lat �szrev�telek], lkSzem�lyek.[Orvosi vizsg�lat k�vetkez� id�pontja], lkSzem�lyek.[Tart�s t�voll�t t�pusa]
FROM lkSzem�lyek
GROUP BY Month([Jogviszony kezdete (bel�p�s d�tuma)]), IIf([Orvosi vizsg�lat k�vetkez� id�pontja]<DateAdd("m",1,DateSerial(Year(Now()),Month(Now()),1))-1,"Lej�r�",""), lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[TAJ sz�m], lkSzem�lyek.[Hivatali email], lkSzem�lyek.[Hivatali mobil], lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.[Sz�let�si hely], lkSzem�lyek.[Anyja neve], lkSzem�lyek.Neme, lkSzem�lyek.[�lland� lakc�m], lkSzem�lyek.[Szervezeti egys�g neve], lkSzem�lyek.[Orvosi vizsg�lat id�pontja], lkSzem�lyek.[Orvosi vizsg�lat t�pusa], lkSzem�lyek.[Orvosi vizsg�lat eredm�nye], lkSzem�lyek.[Orvosi vizsg�lat �szrev�telek], lkSzem�lyek.[Orvosi vizsg�lat k�vetkez� id�pontja], lkSzem�lyek.[Tart�s t�voll�t t�pusa]
HAVING (((lkSzem�lyek.[Szervezeti egys�g neve]) Like "*hum�n*"));

-- [lkOrvosiVizsg�latTeljes�llom�ny]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[Dolgoz� sz�let�si neve] AS [Sz�let�si n�v], lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.[Sz�let�si hely], lkSzem�lyek.[TAJ sz�m], lkSzem�lyek.[Orvosi vizsg�lat id�pontja], lkSzem�lyek.[Orvosi vizsg�lat k�vetkez� id�pontja], lkSzem�lyek.[Hivatali email], IIf([tart�s t�voll�t t�pusa] Is Not Null,"TT","") AS TT, lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)] AS [Kil�p�s d�tuma]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.BFKH;

-- [lkOrvosiVizsg�latTeljes�llom�ny_Eg�szs�g�gyiSzolg�ltat�Adataival]
SELECT lkOrvosiVizsg�latTeljes�llom�ny.F�oszt�ly, lkOrvosiVizsg�latTeljes�llom�ny.Oszt�ly, lkOrvosiVizsg�latTeljes�llom�ny.N�v, lkOrvosiVizsg�latTeljes�llom�ny.[Sz�let�si n�v], lkOrvosiVizsg�latTeljes�llom�ny.[Sz�let�si id�], lkOrvosiVizsg�latTeljes�llom�ny.[Sz�let�si hely], lkOrvosiVizsg�latTeljes�llom�ny.[TAJ sz�m], IIf([Kil�p�s d�tuma]<DateSerial(Year(Now()),Month(Now())+4,1)-1 And (Nz([Orvosi vizsg�lat k�vetkez� id�pontja],0)<Now() And Nz([TT],"")<>"TT") Or (Nz([Lej�rat d�tuma],"")<>"" And Nz([Lej�rat d�tuma],0)<Now()),"Lej�rt","") AS Lej�rt_e, lkOrvosiVizsg�latTeljes�llom�ny.[Orvosi vizsg�lat k�vetkez� id�pontja], lkOrvosiVizsg�latTeljes�llom�ny.[Hivatali email], lkOrvosiVizsg�latTeljes�llom�ny.TT, lkOrvosiVizsg�latTeljes�llom�ny.[Kil�p�s d�tuma], lkEg�szs�g�gyiSzolg�ltat�AdataiUni�.Munkak�r, lkEg�szs�g�gyiSzolg�ltat�AdataiUni�.[Vizsg�lat t�pusa], lkEg�szs�g�gyiSzolg�ltat�AdataiUni�.[Lej�rat d�tuma], lkEg�szs�g�gyiSzolg�ltat�AdataiUni�.Korl�toz�s, lkEg�szs�g�gyiSzolg�ltat�AdataiUni�.[Vizsg�lat eredm�nye], lkEg�szs�g�gyiSzolg�ltat�AdataiUni�.[Vizsg�lat D�tuma]
FROM lkEg�szs�g�gyiSzolg�ltat�AdataiUni� RIGHT JOIN lkOrvosiVizsg�latTeljes�llom�ny ON lkEg�szs�g�gyiSzolg�ltat�AdataiUni�.TAJ = lkOrvosiVizsg�latTeljes�llom�ny.[TAJ sz�m]
WHERE (((True)<>False))
ORDER BY IIf([Kil�p�s d�tuma]<DateSerial(Year(Now()),Month(Now())+4,1)-1 And (Nz([Orvosi vizsg�lat k�vetkez� id�pontja],0)<Now() And Nz([TT],"")<>"TT") Or (Nz([Lej�rat d�tuma],"")<>"" And Nz([Lej�rat d�tuma],0)<Now()),"Lej�rt","") DESC , lkOrvosiVizsg�latTeljes�llom�ny.[Orvosi vizsg�lat k�vetkez� id�pontja];

-- [lkOrvosiVizsg�latTeljes�llom�ny_munkahelyStatisztika01]
SELECT IIf([Munkav�gz�s helye - c�m] Is Null Or [Munkav�gz�s helye - c�m]="",[Munkav�gz�s helye - megnevez�s],[Munkav�gz�s helye - c�m]) AS C�m, lkOrvosiVizsg�latTeljes�llom�ny_Eg�szs�g�gyiSzolg�ltat�Adataival.[TAJ sz�m], Irsz([C�m])*1 AS irsz, ker�let([irsz]) AS Ker�let, IIf(Ker�let([irsz]) Between 1 And 3 Or ker�let([irsz]) Between 11 And 12 Or ker�let([irsz])=22,"Buda","Pest") AS Oldal
FROM lkOrvosiVizsg�latTeljes�llom�ny_Eg�szs�g�gyiSzolg�ltat�Adataival INNER JOIN lkSzem�lyek ON lkOrvosiVizsg�latTeljes�llom�ny_Eg�szs�g�gyiSzolg�ltat�Adataival.[TAJ sz�m] = lkSzem�lyek.[TAJ sz�m]
WHERE (((lkOrvosiVizsg�latTeljes�llom�ny_Eg�szs�g�gyiSzolg�ltat�Adataival.Lej�rt_e)="Lej�rt"))
ORDER BY lkOrvosiVizsg�latTeljes�llom�ny_Eg�szs�g�gyiSzolg�ltat�Adataival.[TAJ sz�m] DESC;

-- [lkOrvosiVizsg�latTeljes�llom�ny_telephelyenk�nt]
SELECT lkOrvosiVizsg�latTeljes�llom�ny_munkahelyStatisztika01.C�m, Count(lkOrvosiVizsg�latTeljes�llom�ny_munkahelyStatisztika01.[TAJ sz�m]) AS L�tsz�m
FROM lkOrvosiVizsg�latTeljes�llom�ny_munkahelyStatisztika01
GROUP BY lkOrvosiVizsg�latTeljes�llom�ny_munkahelyStatisztika01.C�m;

-- [lkOrvosiVizsg�latTeljes�llom�ny_v�rosr�szenk�nt]
SELECT lkOrvosiVizsg�latTeljes�llom�ny_munkahelyStatisztika01.Oldal, lkOrvosiVizsg�latTeljes�llom�ny_munkahelyStatisztika01.Ker�let, Count(lkOrvosiVizsg�latTeljes�llom�ny_munkahelyStatisztika01.[TAJ sz�m]) AS L�tsz�m
FROM lkOrvosiVizsg�latTeljes�llom�ny_munkahelyStatisztika01
GROUP BY lkOrvosiVizsg�latTeljes�llom�ny_munkahelyStatisztika01.Oldal, lkOrvosiVizsg�latTeljes�llom�ny_munkahelyStatisztika01.Ker�let;

-- [lkOrvosok]
SELECT IIf([Dolgoz� teljes neve] Is Null,"�res",[Dolgoz� teljes neve]) AS N�v, lkSzem�lyek.[St�tusz k�dja], lk�ll�shelyekHavib�l.F�oszt, lk�ll�shelyekHavib�l.Oszt�ly, lkSzem�lyek.[Iskolai v�gzetts�g neve], lkSzem�lyek.[KIRA feladat megnevez�s], lkSzem�lyek.FEOR, lkSzem�lyek.[Besorol�si  fokozat (KT)], IIf([F�oszt] Like "*ker�leti*","j�r�s","v�rmegye") AS Szint, "" AS tisztif�orvos, "" AS helyettes, IIf([f�oszt] Like "*n�peg�szs�g*" Or [Oszt�ly] Like "*n�peg�szs�g*","igen","") AS [k�zeg�szs�g-, vagy j�rv�ny�gyi], IIf([f�oszt] Like "*Eg�szs�gbizt*","igen","") AS Eg�szs�gbiztos�t�si, IIf([oszt�ly]="Rehabilit�ci�s Szak�rt�i Oszt�ly 2." Or [oszt�ly]="Rehabilit�ci�s Szak�rt�i Oszt�ly 3.","igen","") AS Rehabilit�ci�s, IIf(Nz([St�tuszk�d],"-")="-",False,True) AS [Orvos �ll�shely], lkSzem�lyek.[Jogfolytonos id� kezdete], lkSzem�lyek.Ad�jel
FROM lkOrvosi�ll�shelyek RIGHT JOIN (lk�ll�shelyekHavib�l LEFT JOIN lkSzem�lyek ON lk�ll�shelyekHavib�l.[�ll�shely azonos�t�] = lkSzem�lyek.[St�tusz k�dja]) ON lkOrvosi�ll�shelyek.St�tuszk�d = lkSzem�lyek.[St�tusz k�dja]
WHERE (((lk�ll�shelyekHavib�l.F�oszt) Like "Rehab*" Or (lk�ll�shelyekHavib�l.F�oszt) Like "N�peg*" Or (lk�ll�shelyekHavib�l.F�oszt) Like "Eg�sz*") AND ((lkSzem�lyek.FEOR) Like "*orvos*") AND ((lkSzem�lyek.[st�tusz neve])="�ll�shely")) OR (((lk�ll�shelyekHavib�l.F�oszt) Like "Rehab*" Or (lk�ll�shelyekHavib�l.F�oszt) Like "N�peg*" Or (lk�ll�shelyekHavib�l.F�oszt) Like "Eg�sz*") AND ((lkSzem�lyek.[KIRA feladat megnevez�s]) Like "*orvos*" And (lkSzem�lyek.[KIRA feladat megnevez�s])<>"F�oszt�lyvezet�i feladatok (t�bb szakmai ter�letet mag�ban foglal� szervezeti egys�gekn�l, ha nem f��llatorvos vagy tisztif�orvos)")) OR (((lk�ll�shelyekHavib�l.Oszt�ly) Like "N�peg*") AND ((lkSzem�lyek.FEOR) Like "*orvos*")) OR (((lk�ll�shelyekHavib�l.Oszt�ly) Like "N�peg*") AND ((lkSzem�lyek.[KIRA feladat megnevez�s]) Like "*orvos*" And (lkSzem�lyek.[KIRA feladat megnevez�s])<>"F�oszt�lyvezet�i feladatok (t�bb szakmai ter�letet mag�ban foglal� szervezeti egys�gekn�l, ha nem f��llatorvos vagy tisztif�orvos)")) OR (((lkSzem�lyek.[Iskolai v�gzetts�g neve]) Like "*orvos*")) OR (((lkSzem�lyek.[Iskolai v�gzetts�g neve]) Like "*j�rv�ny*" And (lkSzem�lyek.[Iskolai v�gzetts�g neve])<>"k�zeg�szs�g�gyi - j�rv�ny�gyi ellen�r" And (lkSzem�lyek.[Iskolai v�gzetts�g neve])<>"k�zeg�szs�g�gyi - j�rv�ny�gyi fel�gyel�"));

-- [lkOrvosokAdatai]
SELECT tOrvosokAdatai.azOrvos, tOrvosokAdatai.Ad�jel, tOrvosokAdatai.EszmeiId�Kezdete, tOrvosokAdatai.�vekSz�ma, tOrvosokAdatai.EszjtvBesorol�sSzerintiIlletm�ny, tOrvosokAdatai.Nyilv�ntart�siSz�m
FROM tOrvosokAdatai
WHERE (((tOrvosokAdatai.OrvosHat�lyV�ge) Is Null));

-- [lkOszt�lyokFeladatk�r�nk�ntiL�tsz�ma]
SELECT [lk�ll�shelyek(havi)_1].F�oszt�ly, [lk�ll�shelyek(havi)_1].Oszt�ly, [lk�ll�shelyek(havi)_1].Feladatk�r, Sum(IIf([�llapot]="bet�lt�tt",1,0)) AS Bet�lt�tt, Sum(IIf([�llapot]="bet�lt�tt",0,1)) AS �res
FROM [lk�ll�shelyek(havi)] AS [lk�ll�shelyek(havi)_1]
GROUP BY [lk�ll�shelyek(havi)_1].F�oszt�ly, [lk�ll�shelyek(havi)_1].Oszt�ly, [lk�ll�shelyek(havi)_1].Feladatk�r, [lk�ll�shelyek(havi)_1].[�NYR SZERVEZETI EGYS�G AZONOS�T�]
ORDER BY bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]);

-- [lkOszt�lyonk�nti�ll�shelyek�NYR]
SELECT lk_F�oszt�ly_Oszt�ly_tSzervezet.bfkhk�d, Nz([Dolgoz� teljes neve],"�res �ll�shely") AS N�v, lk_F�oszt�ly_Oszt�ly_tSzervezet.F�oszt, lk_F�oszt�ly_Oszt�ly_tSzervezet.Oszt�ly, lk�ll�shelyek.[�ll�shely besorol�si kateg�ri�ja] AS [�ll�shely besorol�sa], lk�ll�shelyek.[�ll�shely azonos�t�], Nz([Szerz�d�s/Kinevez�s t�pusa],"hat�rozatlan") AS [�ll�shely hat�lya], IIf(Nz([Tart�s t�voll�t t�pusa],"")="","Nem","Igen") AS [Tart�s t�voll�v�], lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus] AS [Jogviszony t�pusa], lk�ll�shelyek.[�ll�shely t�pusa], lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)] AS [KIl�p�s d�tuma]
FROM lk_F�oszt�ly_Oszt�ly_tSzervezet RIGHT JOIN (lkSzem�lyek RIGHT JOIN lk�ll�shelyek ON lkSzem�lyek.[St�tusz k�dja] = lk�ll�shelyek.[�ll�shely azonos�t�]) ON (lk_F�oszt�ly_Oszt�ly_tSzervezet.Oszt�ly = lk�ll�shelyek.Oszt) AND (lk_F�oszt�ly_Oszt�ly_tSzervezet.F�oszt = lk�ll�shelyek.F�oszt);

-- [lkOszt�lyonk�nti�ll�shelyek�NYR - azonosak keres�se]
SELECT lkOszt�lyonk�nti�ll�shelyek�NYR.[�ll�shely azonos�t�], lkOszt�lyonk�nti�ll�shelyek�NYR.F�oszt
FROM lkOszt�lyonk�nti�ll�shelyek�NYR
WHERE (((lkOszt�lyonk�nti�ll�shelyek�NYR.[�ll�shely azonos�t�]) In (SELECT [�ll�shely azonos�t�] FROM [lkOszt�lyonk�nti�ll�shelyek�NYR] As Tmp GROUP BY [�ll�shely azonos�t�] HAVING Count(*)>1 )))
ORDER BY lkOszt�lyonk�nti�ll�shelyek�NYR.[�ll�shely azonos�t�];

-- [lkOszt�lyvezet�i�ll�shelyek]
SELECT lkSzervezetekSzem�lyekb�l.bfkh, lkSzervezet�ll�shelyek.SzervezetK�d, lkSzervezetekSzem�lyekb�l.F�oszt�ly, lkSzervezetekSzem�lyekb�l.Oszt�ly, lkSzervezet�ll�shelyek.�ll�shely, lkSzervezet�ll�shelyek.[Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s], lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Besorol�si  fokozat (KT)], lkSzem�lyek.[Vezet�i beoszt�s megnevez�se], lkSzem�lyek.[Vezet�i megb�z�s t�pusa], lkSzem�lyek.[Kerek�tett 100 %-os illetm�ny (elt�r�tett)] AS Illetm�ny, lkSzem�lyek.[Tart�s t�voll�t t�pusa], lkSzem�lyek.[Tart�s t�voll�t v�ge], lkSzem�lyek.[Tart�s t�voll�t tervezett v�ge], kt_azNexon_Ad�jel02.NLink
FROM (lkSzervezetekSzem�lyekb�l RIGHT JOIN (lkSzervezet�ll�shelyek LEFT JOIN lkSzem�lyek ON lkSzervezet�ll�shelyek.�ll�shely = lkSzem�lyek.[St�tusz k�dja]) ON lkSzervezetekSzem�lyekb�l.[Szervezeti egys�g k�dja] = lkSzervezet�ll�shelyek.SzervezetK�d) LEFT JOIN kt_azNexon_Ad�jel02 ON lkSzem�lyek.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel
WHERE (((lkSzem�lyek.[Besorol�si  fokozat (KT)])="Oszt�lyvezet�") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkSzem�lyek.[Vezet�i megb�z�s t�pusa])="Oszt�lyvezet�") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkSzem�lyek.[Vezet�i beoszt�s megnevez�se])="Oszt�lyvezet�") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkSzervezet�ll�shelyek.[Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s])="oszt�lyvezet�"))
ORDER BY lkSzervezetekSzem�lyekb�l.bfkh;

-- [lkOszt�lyvezet�i�ll�shelyekEls�Kinevez�sD�tum�val]
SELECT lkOszt�lyvezet�i�ll�shelyek.bfkh, lkOszt�lyvezet�i�ll�shelyek.SzervezetK�d, lkOszt�lyvezet�i�ll�shelyek.F�oszt�ly, lkOszt�lyvezet�i�ll�shelyek.Oszt�ly, lkOszt�lyvezet�i�ll�shelyek.�ll�shely, Nz([Dolgoz� teljes neve],"Bet�ltetlen") AS N�v, lkOszt�lyvezet�i�ll�shelyek.Illetm�ny, lkEls�Oszt�lyvezet�v�Sorol�sD�tuma.[MinOfV�ltoz�s d�tuma]
FROM lkEls�Oszt�lyvezet�v�Sorol�sD�tuma RIGHT JOIN (kt_azNexon_Ad�jel02 RIGHT JOIN lkOszt�lyvezet�i�ll�shelyek ON kt_azNexon_Ad�jel02.NLink = lkOszt�lyvezet�i�ll�shelyek.NLink) ON lkEls�Oszt�lyvezet�v�Sorol�sD�tuma.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel;

-- [lk�regkoriNyugd�jaz�s�sTT]
SELECT lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, Year([Sz�let�si id�])+65 AS [�regkori nyugd�jaz�s �ve], lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)], lkSzem�lyek.[Tart�s t�voll�t t�pusa], lkSzem�lyek.[Tart�s t�voll�t kezdete], lkSzem�lyek.[Tart�s t�voll�t v�ge], lkSzem�lyek.[Tart�s t�voll�t tervezett v�ge]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.F�oszt�ly) Like "* V. ker*") AND ((Year([Sz�let�si id�])+65) Between Year(Date()) And Year(Date())+1)) OR (((lkSzem�lyek.F�oszt�ly) Like "* II. ker*") AND ((Year([Sz�let�si id�])+65) Between Year(Date()) And Year(Date())+1)) OR (((lkSzem�lyek.F�oszt�ly) Like "* IX. ker*") AND ((Year([Sz�let�si id�])+65) Between Year(Date()) And Year(Date())+1)) OR (((lkSzem�lyek.F�oszt�ly) Like "* V. ker*") AND ((lkSzem�lyek.[Tart�s t�voll�t kezdete]) Is Not Null)) OR (((lkSzem�lyek.F�oszt�ly) Like "* II. ker*") AND ((lkSzem�lyek.[Tart�s t�voll�t kezdete]) Is Not Null)) OR (((lkSzem�lyek.F�oszt�ly) Like "* IX. ker*") AND ((lkSzem�lyek.[Tart�s t�voll�t kezdete]) Is Not Null))
ORDER BY Year([Sz�let�si id�])+65, Bfkh([Szervezeti egys�g k�dja]), lkSzem�lyek.[Dolgoz� teljes neve];

-- [lk�sszes�ll�shely]
SELECT [�ll�shely azonos�t�], Mez�4, [Besorol�si fokozat megnevez�se:], [�NYR SZERVEZETI EGYS�G AZONOS�T�], [Besorol�si fokozat k�d:], "A" as Jelleg, Mez�14 as Bet�lt�sAr�nya
                      FROM J�r�si_�llom�ny
                      
                  UNION SELECT [�ll�shely azonos�t�], Mez�4, [Besorol�si fokozat megnevez�se:], [�NYR SZERVEZETI EGYS�G AZONOS�T�], [Besorol�si fokozat k�d:], "A" as Jelleg, Mez�14 as Bet�lt�sAr�nya
                      FROM Korm�nyhivatali_�llom�ny
                    
                   UNION SELECT [�ll�shely azonos�t�], Mez�4, [Besorol�si fokozat megnevez�se:], [Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�], [Besorol�si fokozat k�d:], "K" as Jelleg, Mez�13 as Bet�lt�sAr�nya
                      FROM K�zpontos�tottak;

-- [lk�sszesJogviszonyId�tartamSzem�lyek]
SELECT tSzem�lyek.Ad�jel, Sum(N�([Jogviszony v�ge (kil�p�s d�tuma)],Date())-[Jogviszony kezdete (bel�p�s d�tuma)]+1) AS �sszId�tartam
FROM tSzem�lyek
WHERE (((tSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])="Korm�nyzati szolg�lati jogviszony") AND ((N�([Jogviszony v�ge (kil�p�s d�tuma)],Date())-[Jogviszony kezdete (bel�p�s d�tuma)]+1)>0)) OR (((tSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])="Hivat�sos �llom�ny�") AND ((N�([Jogviszony v�ge (kil�p�s d�tuma)],Date())-[Jogviszony kezdete (bel�p�s d�tuma)]+1)>0))
GROUP BY tSzem�lyek.Ad�jel;

-- [lk�sszetettL�tsz�mStatisztika01]
SELECT TTvel.Sor, TTvel.Adat, TTvel.�rt�k AS [Tart�san t�voll�v�kkel], TTvel.nemTT AS [Tart�san t�voll�v�k n�lk�l]
FROM (SELECT Sor, Adat, �rt�k, nemTT
FROM lkR�szmunkaid�s�kL�tsz�ma
UNION ALL
SELECT Sor, Adat, �rt�k, nemTT
FROM lkN�kL�tsz�ma6�vAlattiGyermekkel
UNION ALL
SELECT Sor, Adat, �rt�k, nemTT
FROM lkN�kL�tsz�ma02
UNION ALL
SELECT Sor, Adat, �rt�k, nemTT
FROM lkDolgoz�kL�tsz�ma18�vAlattiGyermekkel
UNION ALL
SELECT Sor, Adat, �rt�k, nemTT
FROM lk55�let�v�ketBet�lt�ttekL�tsz�ma
UNION ALL
SELECT Sor, Adat, �rt�k, nemTT
FROM lk25�let�v�ketBeNemT�lt�ttekL�tsz�ma
UNION ALL
SELECT Sor, Adat, �rt�k, nemTT
FROM lkBet�lt�ttL�tsz�m
)  AS TTvel
ORDER BY TTvel.Sor;

-- [lk�sszetettL�tsz�mStatisztika02]
SELECT lk�sszetettL�tsz�mStatisztika01.Sor, lk�sszetettL�tsz�mStatisztika01.Adat, lk�sszetettL�tsz�mStatisztika01.[Tart�san t�voll�v�kkel], lk�sszetettL�tsz�mStatisztika01.[Tart�san t�voll�v�kkel]/(SELECT COUNT(Ad�jel) 
        FROM lkSzem�lyek 
        WHERE [St�tusz neve] = "�ll�shely"
    ) AS Ar�nyT�voll�v�kkel, lk�sszetettL�tsz�mStatisztika01.[Tart�san t�voll�v�k n�lk�l], lk�sszetettL�tsz�mStatisztika01.[Tart�san t�voll�v�k n�lk�l]/((SELECT COUNT(Ad�jel) 
            FROM lkSzem�lyek 
            WHERE [St�tusz neve] = "�ll�shely"
        )-(SELECT COUNT([Tart�s t�voll�t t�pusa]) 
            FROM lkSzem�lyek 
            WHERE [St�tusz neve] = "�ll�shely"
        )) AS Ar�nyT�voll�v�kN�lk�l
FROM lk�sszetettL�tsz�mStatisztika01;

-- [lk�sszKer�letb�lKil�pettekHavonta]
SELECT "Mind" AS Ker�let, DateSerial(Year([Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]),Month([Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])+1,1)-1 AS T�rgyh�, Sum(1) AS F�
FROM lkKil�p�Uni�
WHERE (((lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek oka: jogszab�lyi hiva]) Not Like "*l�tre*") AND ((lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]) Between #7/1/2023# And #7/31/2024#) AND ((lkKil�p�Uni�.[Megyei szint VAGY J�r�si Hivatal]) Like "Budapest F�v�ros Korm�nyhivatala *"))
GROUP BY "Mind", DateSerial(Year([Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]),Month([Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])+1,1)-1;

-- [lk�sszKer�letiBet�lt�ttL�tsz�m01]
SELECT Replace([J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH") AS [Ker�leti hivatal], tHaviJelent�sHat�lya1.hat�lya, Sum(IIf([Mez�4]="�res �ll�s",0,1)) AS [Bet�lt�tt l�tsz�m], Sum(IIf([Mez�4]="�res �ll�s",1,0)) AS �res
FROM tHaviJelent�sHat�lya1 INNER JOIN tJ�r�si_�llom�ny ON tHaviJelent�sHat�lya1.hat�lyaID = tJ�r�si_�llom�ny.hat�lyaID
GROUP BY Replace([J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH"), tHaviJelent�sHat�lya1.hat�lya
HAVING (((tHaviJelent�sHat�lya1.hat�lya) Between #7/1/2023# And #7/31/2024#));

-- [lk�sszKer�letiBet�lt�ttL�tsz�m02]
SELECT "Mind" AS [Ker�leti hivatal], lk�sszKer�letiBet�lt�ttL�tsz�m01.hat�lya, Sum(lk�sszKer�letiBet�lt�ttL�tsz�m01.[Bet�lt�tt l�tsz�m]) AS Bet�lt�tt, Sum(lk�sszKer�letiBet�lt�ttL�tsz�m01.�res) AS �resek, [Bet�lt�tt]+[�resek] AS Enged�lyezett
FROM lk�sszKer�letiBet�lt�ttL�tsz�m01
GROUP BY "Mind", lk�sszKer�letiBet�lt�ttL�tsz�m01.hat�lya;

-- [lk�sszKer�letiKimutat�s]
SELECT lk�sszKer�letiBet�lt�ttL�tsz�m02.[Ker�leti hivatal], lk�sszKer�letiBet�lt�ttL�tsz�m02.hat�lya, lk�sszKer�letiBet�lt�ttL�tsz�m02.Bet�lt�tt, lk�sszKer�letiBet�lt�ttL�tsz�m02.�resek, lk�sszKer�letiBet�lt�ttL�tsz�m02.Enged�lyezett, lk�sszKer�letb�lKil�pettekHavonta.F� AS Kil�pettek
FROM lk�sszKer�letb�lKil�pettekHavonta RIGHT JOIN lk�sszKer�letiBet�lt�ttL�tsz�m02 ON lk�sszKer�letb�lKil�pettekHavonta.T�rgyh� = lk�sszKer�letiBet�lt�ttL�tsz�m02.hat�lya;

-- [lkPGFt�bla]
SELECT [ad�azonos�t� jel]*1 AS Ad�jel, tPGFt�bla.*
FROM tPGFt�bla;

-- [lkpr�ba]
SELECT *
FROM lkEnged�lyezett�sL�tsz�mKimenet02
WHERE ((([F�oszt�ly]) Like 'Nyugd*' Or ([F�oszt�ly]) Like "Eg�sz*")) OR ((([F�oszt�ly]) Like "* V.*"))
ORDER BY F�oszt�ly, [Oszt];

-- [lkpr�baid�sKil�p�kSz�ma�vente2b]
SELECT lkpr�baid�sKil�p�kSz�ma�venteHavonta.�v, Sum(lkpr�baid�sKil�p�kSz�ma�venteHavonta.[Kil�p�k sz�ma]) AS Kil�p�k
FROM lkpr�baid�sKil�p�kSz�ma�venteHavonta
GROUP BY lkpr�baid�sKil�p�kSz�ma�venteHavonta.�v;

-- [lkpr�baid�sKil�p�kSz�ma�venteHavonta]
SELECT Year([JogviszonyV�ge]) AS �v, Month([JogviszonyV�ge]) AS H�, Count(lkSzem�lyekMind.Azonos�t�) AS [Kil�p�k sz�ma]
FROM lkSzem�lyekMind
WHERE (((lkSzem�lyekMind.[KIRA jogviszony jelleg]) Like "Korm�nyzati*" Or (lkSzem�lyekMind.[KIRA jogviszony jelleg])="Munkaviszony") AND ((lkSzem�lyekMind.JogviszonyV�ge) Is Not Null Or (lkSzem�lyekMind.JogviszonyV�ge)<>"") AND ((lkSzem�lyekMind.[HR kapcsolat megsz�n�s m�dja (Kil�p�s m�dja)]) Like "*pr�baid�*") AND ((Year([JogviszonyV�ge]))>=2019 And (Year([JogviszonyV�ge]))<=Year(Now())))
GROUP BY Year([JogviszonyV�ge]), Month([JogviszonyV�ge])
ORDER BY Year([JogviszonyV�ge]), Month([JogviszonyV�ge]);

-- [lkpr�baid�sKil�p�kSz�ma�venteHavonta2]
SELECT lkpr�baid�sKil�p�kSz�ma�venteHavonta.�v, IIf([H�]=1,[Kil�p�k sz�ma],0) AS 1, IIf([H�]=2,[Kil�p�k sz�ma],0) AS 2, IIf([H�]=3,[Kil�p�k sz�ma],0) AS 3, IIf([H�]=4,[Kil�p�k sz�ma],0) AS 4, IIf([H�]=5,[Kil�p�k sz�ma],0) AS 5, IIf([H�]=6,[Kil�p�k sz�ma],0) AS 6, IIf([H�]=7,[Kil�p�k sz�ma],0) AS 7, IIf([H�]=8,[Kil�p�k sz�ma],0) AS 8, IIf([H�]=9,[Kil�p�k sz�ma],0) AS 9, IIf([H�]=10,[Kil�p�k sz�ma],0) AS 10, IIf([H�]=12,[Kil�p�k sz�ma],0) AS 11, IIf([H�]=12,[Kil�p�k sz�ma],0) AS 12
FROM lkpr�baid�sKil�p�kSz�ma�venteHavonta;

-- [lkpr�baid�sKil�p�kSz�ma�venteHavonta3]
SELECT lkpr�baid�sKil�p�kSz�ma�venteHavonta2.�v AS �v, Sum(lkpr�baid�sKil�p�kSz�ma�venteHavonta2.[1]) AS 01, Sum(lkpr�baid�sKil�p�kSz�ma�venteHavonta2.[2]) AS 02, Sum(lkpr�baid�sKil�p�kSz�ma�venteHavonta2.[3]) AS 03, Sum(lkpr�baid�sKil�p�kSz�ma�venteHavonta2.[4]) AS 04, Sum(lkpr�baid�sKil�p�kSz�ma�venteHavonta2.[5]) AS 05, Sum(lkpr�baid�sKil�p�kSz�ma�venteHavonta2.[6]) AS 06, Sum(lkpr�baid�sKil�p�kSz�ma�venteHavonta2.[7]) AS 07, Sum(lkpr�baid�sKil�p�kSz�ma�venteHavonta2.[8]) AS 08, Sum(lkpr�baid�sKil�p�kSz�ma�venteHavonta2.[9]) AS 09, Sum(lkpr�baid�sKil�p�kSz�ma�venteHavonta2.[10]) AS 10, Sum(lkpr�baid�sKil�p�kSz�ma�venteHavonta2.[11]) AS 11, Sum(lkpr�baid�sKil�p�kSz�ma�venteHavonta2.[12]) AS 12, lkpr�baid�sKil�p�kSz�ma�vente2b.Kil�p�k AS �sszesen
FROM lkpr�baid�sKil�p�kSz�ma�venteHavonta2 INNER JOIN lkpr�baid�sKil�p�kSz�ma�vente2b ON lkpr�baid�sKil�p�kSz�ma�venteHavonta2.�v = lkpr�baid�sKil�p�kSz�ma�vente2b.�v
GROUP BY lkpr�baid�sKil�p�kSz�ma�venteHavonta2.�v, lkpr�baid�sKil�p�kSz�ma�vente2b.Kil�p�k;

-- [lkPr�baid�V�geNincsKit�ltve]
SELECT DISTINCT IIf(Nz([lkszem�lyek].[F�oszt�ly],"")="",[Mez�5],[lkszem�lyek].[F�oszt�ly]) AS F�oszt�ly, IIf([lkszem�lyek].[Oszt�ly]="",[Mez�6],[lkszem�lyek].[Oszt�ly]) AS Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, kt_azNexon_Ad�jel02.NLink
FROM kt_azNexon_Ad�jel02 RIGHT JOIN (lkSzem�lyek LEFT JOIN lkKil�p�k ON lkSzem�lyek.[Ad�azonos�t� jel] = lkKil�p�k.Ad�azonos�t�) ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge]) Is Null) AND ((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])>Date()-200))
ORDER BY IIf(Nz([lkszem�lyek].[F�oszt�ly],"")="",[Mez�5],[lkszem�lyek].[F�oszt�ly]);

-- [lkProjektekHaviT�rt�netb�l]
SELECT DISTINCT tK�zpontos�tottak.[Ad�azonos�t�], tK�zpontos�tottak.[Projekt megnevez�se]
FROM tHaviJelent�sHat�lya1 INNER JOIN tK�zpontos�tottak ON tHaviJelent�sHat�lya1.hat�lyaID = tK�zpontos�tottak.hat�lyaID
WHERE (((Len([Projekt megnevez�se]))>0));

-- [lkReferensek]
SELECT kt_azNexon_Ad�jel02.azNexon, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Hivatali email], lkSzem�lyek.[Hivatali telefon], IIf([KIRA feladat megnevez�s] Like "*oszt�ly*" Or [Besorol�si  fokozat (KT)] Like "*oszt�ly*",True,False) Or [lkSzem�lyek].[Feladatk�r] Like "*oszt�ly*" Or [Vezet�i megb�z�s t�pusa1] Is Not Null AS Vezet�, IIf(IsNull((Select NexonAz From tReferensekTer�letN�lk�l as t Where [kt_azNexon_Ad�jel].[azNexon]=t.NexonAz)),True,False) AS VanTer�lete, IIf(Nz([Tart�s t�voll�t t�pusa],False)<>False,True,False) AS TT
FROM kt_azNexon_Ad�jel02 RIGHT JOIN lkSzem�lyek ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.F�oszt�ly) Like "Hum�n*") AND ((lkSzem�lyek.[KIRA feladat megnevez�s]) Like "hum�n*" Or (lkSzem�lyek.[KIRA feladat megnevez�s]) Like "*oszt�ly*"))
ORDER BY lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkReferensekF�oszt�lyok]
SELECT tReferensekF�oszt�lyok.azRef, tReferensekF�oszt�lyok.F�oszt�ly, tReferensekF�oszt�lyok.bfkhF�oszt�ly, tReferensekF�oszt�lyok.Referens, 1/(Select count(azRef) from tReferensekF�oszt�lyok as Tmp Where Tmp.F�oszt�ly=tReferensekF�oszt�lyok.F�oszt�ly) AS Ar�ny, tReferensekF�oszt�lyok.azNexon, tReferensekF�oszt�lyok.Oszt�ly, tReferensekF�oszt�lyok.bfkhOszt�ly, tReferensekF�oszt�lyok.Telefon, tReferensekF�oszt�lyok.Szoba, tReferensekF�oszt�lyok.azSzoba
FROM tReferensekF�oszt�lyok;

-- [lkReferensekreJut��ll�shelyekSz�ma]
SELECT lkReferensekF�oszt�lyok.Referens, Sum(IIf([Sz�let�si �v \ �res �ll�s]="�res �ll�s",1,0)*[Bet�lt�s ar�nya]*[Ar�ny]) AS �res, Sum(IIf([Sz�let�si �v \ �res �ll�s]="�res �ll�s",0,1)*[Bet�lt�s ar�nya]*[Ar�ny]) AS Bet�lt�tt, Sum([Bet�lt�s ar�nya]*[Ar�ny]) AS [�sszes �ll�shely]
FROM lkJ�r�siKorm�nyK�zpontos�tottUni� INNER JOIN lkReferensekF�oszt�lyok ON lkJ�r�siKorm�nyK�zpontos�tottUni�.F�oszt�ly = lkReferensekF�oszt�lyok.F�oszt�ly
GROUP BY lkReferensekF�oszt�lyok.Referens;

-- [lkR�gi�sJelenlegiIlletm�ny]
SELECT lk�llom�nyt�bl�kT�rt�netiUni�ja.hat�lyaID, lkJ�r�siKorm�nyK�zpontos�tottUni�.Ad�azonos�t�, lkJ�r�siKorm�nyK�zpontos�tottUni�.Kinevez�s, lk�llom�nyt�bl�kT�rt�netiUni�ja.Kinevez�s, [lkJ�r�siKorm�nyK�zpontos�tottUni�].[Havi illetm�ny]/[lkJ�r�siKorm�nyK�zpontos�tottUni�].[Heti munka�r�k sz�ma]*40 AS Jelenlegi40�r�s, [lk�llom�nyt�bl�kT�rt�netiUni�ja].[Havi illetm�ny]/[lk�llom�nyt�bl�kT�rt�netiUni�ja].[Heti munka�r�k sz�ma]*40 AS R�gi40�r�s, Len([lkJ�r�siKorm�nyK�zpontos�tottUni�].[Ad�azonos�t�]) AS Hossz, lkJ�r�siKorm�nyK�zpontos�tottUni�.Jelleg INTO tmpR�gi�sJelenlegiIlletm�ny IN 'L:\Ugyintezok\Adatszolg�ltat�k\Adatb�zisok\H�tt�rt�rak\Ellen�rz�sHavi_h�tt�rt�r.accdb'
FROM lkJ�r�siKorm�nyK�zpontos�tottUni� LEFT JOIN lk�llom�nyt�bl�kT�rt�netiUni�ja ON lkJ�r�siKorm�nyK�zpontos�tottUni�.Ad�azonos�t� = lk�llom�nyt�bl�kT�rt�netiUni�ja.Ad�azonos�t�
WHERE (((lkJ�r�siKorm�nyK�zpontos�tottUni�.Ad�azonos�t�) Is Not Null Or (lkJ�r�siKorm�nyK�zpontos�tottUni�.Ad�azonos�t�)<>"") And ((Len(lkJ�r�siKorm�nyK�zpontos�tottUni�.Ad�azonos�t�))>1) And ((lkJ�r�siKorm�nyK�zpontos�tottUni�.Jelleg)="A"));

-- [lkR�giHib�kInt�zked�sekSeg�d�rlaphoz]
SELECT ktR�giHib�kInt�zked�sek.HASH, ktR�giHib�kInt�zked�sek.azInt�zked�sek, tInt�zked�sek.azIntFajta, tInt�zked�sek.Int�zked�sD�tuma, tInt�zked�sek.Hivatkoz�s
FROM tInt�zked�sek INNER JOIN ktR�giHib�kInt�zked�sek ON tInt�zked�sek.azInt�zked�sek = ktR�giHib�kInt�zked�sek.azInt�zked�sek
ORDER BY tInt�zked�sek.Int�zked�sD�tuma;

-- [lkR�giHib�kUtols�Int�zked�s]
SELECT ktR�giHib�kInt�zked�sek.azInt�zked�sek, ktR�giHib�kInt�zked�sek.HASH, tInt�zked�sek.azIntFajta
FROM tInt�zked�sFajt�k INNER JOIN (tInt�zked�sek INNER JOIN ktR�giHib�kInt�zked�sek ON tInt�zked�sek.azInt�zked�sek = ktR�giHib�kInt�zked�sek.azInt�zked�sek) ON tInt�zked�sFajt�k.azIntFajta = tInt�zked�sek.azIntFajta
WHERE (((ktR�giHib�kInt�zked�sek.r�gz�t�sD�tuma)=(Select Max([tmp].[r�gz�t�sD�tuma]) 
FROM [ktR�giHib�kInt�zked�sek] as Tmp 
Where Tmp.[HASH] = [ktR�giHib�kInt�zked�sek].[HASH] 
Group By Tmp.Hash)));

-- [lkR�giHib�k�rlaphoz]
SELECT tR�giHib�k.[Els� mez�], Sz�tbont�([M�sodik mez�],[lek�rdez�sNeve]) AS Hiba, tR�giHib�k.[Els� Id�pont], tR�giHib�k.[Utols� Id�pont]
FROM tR�giHib�k
WHERE (((tR�giHib�k.lek�rdez�sNeve) Is Not Null));

-- [lkR�giHib�k�rlapRekordforr�sa]
SELECT tR�giHib�k.[Els� mez�], ktR�giHib�kInt�zked�sek.HASH, ktR�giHib�kInt�zked�sek.azInt�zked�sek, tR�giHib�k.lek�rdez�sNeve, IIf([Utols� Id�pont]=(select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve <>"lk�res�ll�shelyek�llapotfelm�r�" And lek�rdez�sneve <>"lkFontosHi�nyz�Adatok02") Or (select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve ="lkFontosHi�nyz�Adatok02"),1,2) AS V
FROM tR�giHib�k LEFT JOIN ktR�giHib�kInt�zked�sek ON tR�giHib�k.[Els� mez�] = ktR�giHib�kInt�zked�sek.HASH
WHERE (((tR�giHib�k.lek�rdez�sNeve) Like "*" & [�rlapok]![�R�giHib�kInt�zked�sek]![Keres�] & "*") AND ((IIf([Utols� Id�pont]=(select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve <>"lk�res�ll�shelyek�llapotfelm�r�" And lek�rdez�sneve <>"lkFontosHi�nyz�Adatok02") Or (select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve ="lkFontosHi�nyz�Adatok02"),1,2))=IIf([�rlapok]![�R�giHib�kInt�zked�sek]![Fenn�llE]=3,1,[�rlapok]![�R�giHib�kInt�zked�sek]![Fenn�llE]) Or (IIf([Utols� Id�pont]=(select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve <>"lk�res�ll�shelyek�llapotfelm�r�" And lek�rdez�sneve <>"lkFontosHi�nyz�Adatok02") Or (select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve ="lkFontosHi�nyz�Adatok02"),1,2))=IIf([�rlapok]![�R�giHib�kInt�zked�sek]![Fenn�llE]=3,2,[�rlapok]![�R�giHib�kInt�zked�sek]![Fenn�llE]))) OR (((ktR�giHib�kInt�zked�sek.HASH) Like "*" & [�rlapok]![�R�giHib�kInt�zked�sek]![Keres�] & "*") AND ((IIf([Utols� Id�pont]=(select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve <>"lk�res�ll�shelyek�llapotfelm�r�" And lek�rdez�sneve <>"lkFontosHi�nyz�Adatok02") Or (select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve ="lkFontosHi�nyz�Adatok02"),1,2))=IIf([�rlapok]![�R�giHib�kInt�zked�sek]![Fenn�llE]=3,1,[�rlapok]![�R�giHib�kInt�zked�sek]![Fenn�llE]) Or (IIf([Utols� Id�pont]=(select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve <>"lk�res�ll�shelyek�llapotfelm�r�" And lek�rdez�sneve <>"lkFontosHi�nyz�Adatok02") Or (select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve ="lkFontosHi�nyz�Adatok02"),1,2))=IIf([�rlapok]![�R�giHib�kInt�zked�sek]![Fenn�llE]=3,2,[�rlapok]![�R�giHib�kInt�zked�sek]![Fenn�llE]))) OR (((IIf([Utols� Id�pont]=(select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve <>"lk�res�ll�shelyek�llapotfelm�r�" And lek�rdez�sneve <>"lkFontosHi�nyz�Adatok02") Or (select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve ="lkFontosHi�nyz�Adatok02"),1,2))=IIf([�rlapok]![�R�giHib�kInt�zked�sek]![Fenn�llE]=3,1,[�rlapok]![�R�giHib�kInt�zked�sek]![Fenn�llE]) Or (IIf([Utols� Id�pont]=(select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve <>"lk�res�ll�shelyek�llapotfelm�r�" And lek�rdez�sneve <>"lkFontosHi�nyz�Adatok02") Or (select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve ="lkFontosHi�nyz�Adatok02"),1,2))=IIf([�rlapok]![�R�giHib�kInt�zked�sek]![Fenn�llE]=3,2,[�rlapok]![�R�giHib�kInt�zked�sek]![Fenn�llE])) AND ((tR�giHib�k.[M�sodik mez�]) Like "*" & [�rlapok]![�R�giHib�kInt�zked�sek]![Keres�] & "*"));

-- [lkRehabilit�ci�hozLista_TAJ_jogvV�geKezdete]
SELECT lkSzem�lyek.[TAJ sz�m], lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)], lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)], lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)]) Is Null Or (lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)])>="#2023. 01. 01.#") AND ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])="Korm�nyzati szolg�lati jogviszony")) OR (((lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)]) Is Null Or (lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)])>="#2023. 01. 01.#") AND ((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])="Munkaviszony"));

-- [lkR�szmunkaid�s�kAr�nya01]
SELECT DISTINCT Uni�.T�bla, tSzervezetiEgys�gek.F�oszt�ly, tSzervezetiEgys�gek.Oszt�ly, Uni�.Ad�azonos�t�, Uni�.[�ll�shely azonos�t�], Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�], Uni�.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ], Uni�.[Heti munka�r�k sz�ma], IIf([Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ] = "T"
		OR [Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ] = "NYT", 1, 0) AS [Teljes munkaid�s], IIf([Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ] = "T"
		OR [Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ] = "NYT", 0, 1) AS R�szmunkaid�s
FROM tSzervezetiEgys�gek RIGHT JOIN (SELECT "Korm�nyhivatali_�llom�ny" AS T�bla
		,"R�szmunkaid�snek van jel�lve, de teljes munkaid�ben dolgozik." AS [Hib�s �rt�k]
		,Korm�nyhivatali_�llom�ny.Ad�azonos�t�
		,Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�]
		,Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
		,Korm�nyhivatali_�llom�ny.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ]
		,Korm�nyhivatali_�llom�ny.[Heti munka�r�k sz�ma]
		,IIf(Right([Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ], 1) = "R"
			AND [Heti munka�r�k sz�ma] = 40, True, False) AS Hib�s
	FROM Korm�nyhivatali_�llom�ny
	
	UNION
	
	SELECT "J�r�si_�llom�ny" AS T�bla
		,"R�szmunkaid�snek van jel�lve, de teljes munkaid�ben dolgozik." AS [Hib�s �rt�k]
		,J�r�si_�llom�ny.Ad�azonos�t�
		,J�r�si_�llom�ny.[�ll�shely azonos�t�]
		,J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
		,J�r�si_�llom�ny.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ]
		,J�r�si_�llom�ny.[Heti munka�r�k sz�ma]
		,IIf(Right([Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ], 1) = "R"
			AND [Heti munka�r�k sz�ma] = 40, True, False) AS Hib�s
	FROM J�r�si_�llom�ny
	
	UNION
	
	SELECT "Korm�nyhivatali_�llom�ny" AS T�bla
		,"Teljes munkaid�snek van jel�lve, de r�szmunkaid�ben dolgozik." AS [Hib�s �rt�k]
		,Korm�nyhivatali_�llom�ny.Ad�azonos�t�
		,Korm�nyhivatali_�llom�ny.[�ll�shely azonos�t�]
		,Korm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
		,Korm�nyhivatali_�llom�ny.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ]
		,Korm�nyhivatali_�llom�ny.[Heti munka�r�k sz�ma]
		,IIf(Right([Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ], 1) = "T"
			AND [Heti munka�r�k sz�ma] <> 40, True, False) AS Hib�s
	FROM Korm�nyhivatali_�llom�ny
	
	UNION
	
	SELECT "J�r�si_�llom�ny" AS T�bla
		,"Teljes munkaid�snek van jel�lve, de r�szmunkaid�ben dolgozik." AS [Hib�s �rt�k]
		,J�r�si_�llom�ny.Ad�azonos�t�
		,J�r�si_�llom�ny.[�ll�shely azonos�t�]
		,J�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
		,J�r�si_�llom�ny.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ]
		,J�r�si_�llom�ny.[Heti munka�r�k sz�ma]
		,IIf(Right([Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ], 1) = "T"
			AND [Heti munka�r�k sz�ma] <> 40, True, False) AS Hib�s
	FROM J�r�si_�llom�ny
	)  AS Uni� ON tSzervezetiEgys�gek.[Szervezeti egys�g k�dja] = Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
WHERE (((Len([Ad�azonos�t�])) > "0"));

-- [lkR�szmunkaid�s�kAr�nya02]
SELECT lkR�szmunkaid�s�kAr�nya01.[�NYR SZERVEZETI EGYS�G AZONOS�T�], lkR�szmunkaid�s�kAr�nya01.F�oszt�ly, lkR�szmunkaid�s�kAr�nya01.Oszt�ly, Sum(lkR�szmunkaid�s�kAr�nya01.[Teljes munkaid�s]) AS [Teljes munkaid�s l�tsz�m], Sum(lkR�szmunkaid�s�kAr�nya01.R�szmunkaid�s) AS [R�szmunkaid�s l�tsz�m]
FROM lkR�szmunkaid�s�kAr�nya01
GROUP BY lkR�szmunkaid�s�kAr�nya01.[�NYR SZERVEZETI EGYS�G AZONOS�T�], lkR�szmunkaid�s�kAr�nya01.F�oszt�ly, lkR�szmunkaid�s�kAr�nya01.Oszt�ly;

-- [lkR�szmunkaid�s�kAr�nya03]
SELECT bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]) AS [BFKH k�d], lkR�szmunkaid�s�kAr�nya02.F�oszt�ly, lkR�szmunkaid�s�kAr�nya02.Oszt�ly, lkR�szmunkaid�s�kAr�nya02.[Teljes munkaid�s l�tsz�m], lkR�szmunkaid�s�kAr�nya02.[R�szmunkaid�s l�tsz�m], [R�szmunkaid�s l�tsz�m]/[Teljes munkaid�s l�tsz�m] AS Ar�nya
FROM lkR�szmunkaid�s�kAr�nya02
ORDER BY bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]), [R�szmunkaid�s l�tsz�m]/[Teljes munkaid�s l�tsz�m] DESC;

-- [lkR�szmunkaid�s�kL�tsz�ma]
SELECT 7 AS Sor, "R�szmunkaid�s�k l�tsz�ma:" AS Adat, Sum([f�]) AS �rt�k, Sum(TTn�lk�l) AS nemTT
FROM (SELECT DISTINCT lkSzem�lyek.Ad�jel, 1 AS F�, Abs([Tart�s t�voll�t t�pusa] Is Null) AS TTn�lk�l FROM lkSzem�lyek WHERE (((lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker])<>40)) and lkSzem�lyek.[St�tusz neve] = "�ll�shely")  AS lista;

-- [lkRuh�zatiT�mogat�sraJogosultakL�tsz�ma]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, Count(lkSzem�lyek.Ad�jel) AS CountOfAd�jel
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.F�oszt�ly) Like "BFKH*") AND ((lkSzem�lyek.Oszt�ly) Like "Korm�nyablak*") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null Or (lkSzem�lyek.[Tart�s t�voll�t t�pusa])<>"Mentes�t�s felment�si / felmond�si id�n bel�l") AND ((lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge]) Is Null Or (lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge])<Date()) AND ((DateAdd("m",30,dt�tal([Tart�s t�voll�t kezdete]))<dt�tal(N�([Tart�s t�voll�t v�ge],[Tart�s t�voll�t tervezett v�ge])))=0) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkSzem�lyek.F�oszt�ly) Like "K�zponti*") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null Or (lkSzem�lyek.[Tart�s t�voll�t t�pusa])<>"Mentes�t�s felment�si / felmond�si id�n bel�l") AND ((lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge]) Is Null Or (lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge])<Date()) AND ((DateAdd("m",30,dt�tal([Tart�s t�voll�t kezdete]))<dt�tal(N�([Tart�s t�voll�t v�ge],[Tart�s t�voll�t tervezett v�ge])))=0) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
GROUP BY lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly;

-- [lkRuh�zatiT�mogat�sraJogosultakList�ja]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.Ad�jel
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.F�oszt�ly) Like "BFKH*") AND ((lkSzem�lyek.Oszt�ly) Like "Korm�nyablak*") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null Or (lkSzem�lyek.[Tart�s t�voll�t t�pusa])<>"Mentes�t�s felment�si / felmond�si id�n bel�l") AND ((lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge]) Is Null Or (lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge])<Date()) AND ((DateAdd("d",30,dt�tal([Tart�s t�voll�t kezdete]))<dt�tal(N�([Tart�s t�voll�t v�ge],[Tart�s t�voll�t tervezett v�ge])))=0) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkSzem�lyek.F�oszt�ly) Like "K�zponti*") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null Or (lkSzem�lyek.[Tart�s t�voll�t t�pusa])<>"Mentes�t�s felment�si / felmond�si id�n bel�l") AND ((lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge]) Is Null Or (lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge])<Date()) AND ((DateAdd("d",30,dt�tal([Tart�s t�voll�t kezdete]))<dt�tal(N�([Tart�s t�voll�t v�ge],[Tart�s t�voll�t tervezett v�ge])))=0) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.BFKH, lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkRuh�zatiT�mogat�sraJogosultakList�jaMegjegyz�sekkel]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.Ad�jel, lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge] AS [Pr�baid� v�ge], IIf(N�([Szerz�d�s/Kinevez�s - pr�baid� v�ge],0)<Date() Or [Szerz�d�s/Kinevez�s - pr�baid� v�ge] Is Null,"","Pr�baid�s") & [Tart�s t�voll�t t�pusa] AS Megjegyz�s
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.F�oszt�ly) Like "BFKH*") AND ((lkSzem�lyek.Oszt�ly) Like "Korm�nyablak*") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkSzem�lyek.F�oszt�ly) Like "K�zponti*") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.BFKH, lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkS�vosB�rStatisztika01]
SELECT tBesorol�s_�talak�t�.Sorrend, lk_�llom�nyt�bl�kb�l_Illetm�nyek.Besorol�sHavi, Min([Illetm�ny]/[Heti munka�r�k sz�ma]*40) AS B�rmin, Max([Illetm�ny]/[Heti munka�r�k sz�ma]*40) AS B�rmax
FROM tBesorol�s_�talak�t� INNER JOIN lk_�llom�nyt�bl�kb�l_Illetm�nyek ON tBesorol�s_�talak�t�.[Az �ll�shely jel�l�se] = lk_�llom�nyt�bl�kb�l_Illetm�nyek.Besorol�sHavi
WHERE (((lk_�llom�nyt�bl�kb�l_Illetm�nyek.Besorol�sHavi) Is Not Null))
GROUP BY tBesorol�s_�talak�t�.Sorrend, lk_�llom�nyt�bl�kb�l_Illetm�nyek.Besorol�sHavi;

-- [lkS�vosB�rStatisztika02a]
SELECT lkS�vosB�rStatisztika01.Sorrend, lkSorsz�mok.Sorsz�m, lkS�vosB�rStatisztika01.B�rmin, lkS�vosB�rStatisztika01.B�rmax, ([B�rmax]-[B�rmin])/10 AS Egys�g, [B�rmin]+(([Sorsz�m]-1)*([B�rmax]-[B�rmin])/10) AS S�valj, [B�rmin]+([Sorsz�m]*([B�rmax]-[B�rmin])/10) AS S�vtet�
FROM lkS�vosB�rStatisztika01, lkSorsz�mok
WHERE (((lkSorsz�mok.Sorsz�m)<11) AND ((([B�rmax]-[B�rmin])/10)<>0))
ORDER BY lkS�vosB�rStatisztika01.Sorrend, lkSorsz�mok.Sorsz�m;

-- [lkS�vosB�rStatisztika02b]
SELECT lkS�vosB�rStatisztika01.Besorol�sHavi, lkS�vosB�rStatisztika01.Sorrend, lkSorsz�mok.Sorsz�m, lkS�vosB�rStatisztika01.B�rmin, lkS�vosB�rStatisztika01.B�rmax, ([B�rmax]-[B�rmin])/10 AS Egys�g, [B�rmin]+([Sorsz�m]*([B�rmax]-[B�rmin])/10) AS S�vtet�
FROM lkS�vosB�rStatisztika01, lkSorsz�mok
WHERE (((lkSorsz�mok.Sorsz�m)<11) AND ((([B�rmax]-[B�rmin])/10)<>0))
ORDER BY lkS�vosB�rStatisztika01.Besorol�sHavi, lkS�vosB�rStatisztika01.Sorrend, lkSorsz�mok.Sorsz�m;

-- [lkS�vosB�rStatisztika03a]
SELECT lkS�vosB�rStatisztika02a.Sorrend, lkS�vosB�rStatisztika02a.Sorsz�m, lk_�llom�nyt�bl�kb�l_Illetm�nyek.Ad�jel, lk_�llom�nyt�bl�kb�l_Illetm�nyek.[�ll�shely azonos�t�], lk_�llom�nyt�bl�kb�l_Illetm�nyek.N�v, lk_�llom�nyt�bl�kb�l_Illetm�nyek.F�oszt�ly, lk_�llom�nyt�bl�kb�l_Illetm�nyek.Oszt�ly, lk_�llom�nyt�bl�kb�l_Illetm�nyek.Besorol�sHavi, [Illetm�ny]/[Heti munka�r�k sz�ma]*40 AS B�r, lk_�llom�nyt�bl�kb�l_Illetm�nyek.T�voll�tJogc�me, bfkh([Szervezetk�d]) AS Bfkh
FROM lkS�vosB�rStatisztika02a INNER JOIN lk_�llom�nyt�bl�kb�l_Illetm�nyek ON (lkS�vosB�rStatisztika02a.S�valj <= lk_�llom�nyt�bl�kb�l_Illetm�nyek.Illetm�ny) AND (lkS�vosB�rStatisztika02a.S�vtet� >= lk_�llom�nyt�bl�kb�l_Illetm�nyek.Illetm�ny)
ORDER BY bfkh([Szervezetk�d]);

-- [lkSof�r�k]
SELECT lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.FEOR, lkSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker], lkSzem�lyek.[Kerek�tett 100 %-os illetm�ny (elt�r�tett)]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.FEOR)="8416 - Szem�lyg�pkocsi-vezet�") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null)) OR (((lkSzem�lyek.[Dolgoz� teljes neve])="Kov�cs Tibor")) OR (((lkSzem�lyek.[Dolgoz� teljes neve])="D�brei Lajos"));

-- [lkSorsz�mok]
SELECT ([Ten1].[N]+[Ten10].[N]*10+[Ten100].[N]*100)+1 AS Sorsz�m
FROM (SELECT DISTINCT Abs([id] Mod 10) AS N FROM MSysObjects)  AS Ten1, (SELECT DISTINCT Abs([id] Mod 10) AS N FROM MSysObjects)  AS Ten10, (SELECT DISTINCT Abs([id] Mod 10) AS N FROM MSysObjects)  AS Ten100;

-- [lkStatisztikaiL�tsz�m]
SELECT lkL�tsz�mokNevezetesNapokon01.KiemeltNapok, Sum(lkL�tsz�mokNevezetesNapokon01.SumOfL�tsz�m) AS SumOfSumOfL�tsz�m
FROM lkL�tsz�mokNevezetesNapokon01
GROUP BY lkL�tsz�mokNevezetesNapokon01.KiemeltNapok;

-- [lkSzakter�letiAdatszolg�ltat�shoz]
SELECT tSzakter�letSzervezet.[Szakter�leti adatszolg�ltat�s], Sum(IIf([Sz�let�si �v \ �res �ll�s]="�res �ll�s",0,1)) AS Bet�lt�tt, Sum(IIf([Sz�let�si �v \ �res �ll�s]="�res �ll�s",1,0)) AS �res, Sum(1) AS �sszes
FROM tSzakter�letSzervezet INNER JOIN lkJ�r�siKorm�nyK�zpontos�tottUni� ON (tSzakter�letSzervezet.Oszt�ly = lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly) AND (tSzakter�letSzervezet.F�oszt�ly = lkJ�r�siKorm�nyK�zpontos�tottUni�.[J�r�si Hivatal])
GROUP BY tSzakter�letSzervezet.[Szakter�leti adatszolg�ltat�s];

-- [lkSzem�lyek]
SELECT tSzem�lyek.*, Replace(Nz(tSzem�lyek.[Szint 8 szervezeti egys�g n�v],Nz(tSzem�lyek.[Szint 6 szervezeti egys�g n�v],Nz(tSzem�lyek.[Szint 5 szervezeti egys�g n�v],Nz(tSzem�lyek.[Szint 7 szervezeti egys�g n�v],Nz(tSzem�lyek.[Szint 4 szervezeti egys�g n�v],Nz(tSzem�lyek.[Szint 3 szervezeti egys�g n�v],Nz(tSzem�lyek.[Szint 2 szervezeti egys�g n�v],""))))))),"Budapest F�v�ros Korm�nyhivatala","BFKH") AS F�oszt�ly, Replace(Nz(IIf(IsNull([tSzem�lyek].[Szint 6 szervezeti egys�g k�d]),IIf(IsNull([tSzem�lyek].[Szint 5 szervezeti egys�g k�d]),IIf(IsNull([tSzem�lyek].[Szint 7 szervezeti egys�g k�d]),IIf(IsNull([tSzem�lyek].[Szint 4 szervezeti egys�g k�d]),IIf(IsNull([tSzem�lyek].[Szint 3 szervezeti egys�g k�d]),[tSzem�lyek].[Szint 2 szervezeti egys�g k�d] & "",[tSzem�lyek].[Szint 3 szervezeti egys�g k�d] & ""),[tSzem�lyek].[Szint 4 szervezeti egys�g k�d] & ""),[tSzem�lyek].[Szint 7 szervezeti egys�g k�d] & ""),[tSzem�lyek].[Szint 5 szervezeti egys�g k�d] & ""),[tSzem�lyek].[Szint 6 szervezeti egys�g k�d] & ""),""),"Budapest F�v�ros Korm�nyhivatala ","BFKH ") AS F�oszt�lyK�d, IIf([f�oszt�ly]=[Szint 7 szervezeti egys�g n�v],"",[Szint 7 szervezeti egys�g n�v] & "") AS Oszt�ly, Replace(Nz([Munkav�gz�s helye - c�m],"")," .",".") AS Munkav�gz�sC�me, tSzem�lyek.[besorol�si  fokozat (KT)] AS Besorol�s, Replace(Nz([tszem�lyek].[Besorol�si  fokozat (KT)],Nz([tBesorol�s�talak�t�Elt�r�Besorol�shoz].[Besorol�si  fokozat (KT)],"")),"/ ","") AS Besorol�s2, bfkh(Nz([szervezeti egys�g k�dja],0)) AS BFKH, Replace([Feladatk�r],"Lez�rt_","") AS Feladat, Nz([Iskolai v�gzetts�g foka],"-") AS V�gzetts�gFok, tSzem�lyek.[Sz�let�si id�] AS Sz�let�siIdeje, lk�ll�shelyek.jel2, tSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)] AS Kil�p�sD�tuma, Nz([tSzem�lyek].[TAJ sz�m],0)*1 AS TAJ, [T�rzssz�m]*1 AS Sz�mT�rzsSz�m, bfkh(Replace(Nz(IIf(IsNull([tSzem�lyek].[Szint 6 szervezeti egys�g k�d]),IIf(IsNull([tSzem�lyek].[Szint 5 szervezeti egys�g k�d]),IIf(IsNull([tSzem�lyek].[Szint 7 szervezeti egys�g k�d]),IIf(IsNull([tSzem�lyek].[Szint 4 szervezeti egys�g k�d]),IIf(IsNull([tSzem�lyek].[Szint 3 szervezeti egys�g k�d]),[tSzem�lyek].[Szint 2 szervezeti egys�g k�d] & "",[tSzem�lyek].[Szint 3 szervezeti egys�g k�d] & ""),[tSzem�lyek].[Szint 4 szervezeti egys�g k�d] & ""),[tSzem�lyek].[Szint 7 szervezeti egys�g k�d] & ""),[tSzem�lyek].[Szint 5 szervezeti egys�g k�d] & ""),[tSzem�lyek].[Szint 6 szervezeti egys�g k�d] & ""),""),"Budapest F�v�ros Korm�nyhivatala ","BFKH ")) AS F�oszt�lyBFKHK�d
FROM (tSzem�lyek LEFT JOIN lk�ll�shelyek ON tSzem�lyek.[St�tusz k�dja] = lk�ll�shelyek.[�ll�shely azonos�t�]) LEFT JOIN tBesorol�s�talak�t�Elt�r�Besorol�shoz ON lk�ll�shelyek.[�ll�shely besorol�si kateg�ri�ja] = tBesorol�s�talak�t�Elt�r�Besorol�shoz.[�ll�shely besorol�si kateg�ri�ja]
WHERE ((((SELECT Max(IIf(Tmp.[Jogviszony v�ge (kil�p�s d�tuma)]=0,#01/01/3000#,Tmp.[Jogviszony v�ge (kil�p�s d�tuma)])) AS [MaxOfJogviszony sorsz�ma]         FROM tSzem�lyek as Tmp         WHERE tSzem�lyek.Ad�jel=Tmp.Ad�jel         GROUP BY Tmp.Ad�jel     ))=IIf([Jogviszony v�ge (kil�p�s d�tuma)]=0,#1/1/3000#,[Jogviszony v�ge (kil�p�s d�tuma)])))
ORDER BY tSzem�lyek.[Dolgoz� teljes neve];

-- [lkSzem�lyekAdottNapon]
SELECT tSzem�lyek.*, Replace(Nz(IIf(IsNull([tSzem�lyek].[Szint 6 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek].[Szint 5 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek].[Szint 7 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek].[Szint 4 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek].[Szint 3 szervezeti egys�g n�v]),[tSzem�lyek].[Szint 2 szervezeti egys�g n�v] & "",[tSzem�lyek].[Szint 3 szervezeti egys�g n�v] & ""),[tSzem�lyek].[Szint 4 szervezeti egys�g n�v] & ""),[tSzem�lyek].[Szint 7 szervezeti egys�g n�v] & ""),[tSzem�lyek].[Szint 5 szervezeti egys�g n�v] & ""),[tSzem�lyek].[Szint 6 szervezeti egys�g n�v] & ""),""),"Budapest F�v�ros Korm�nyhivatala ","BFKH ") & "" AS F�oszt�ly, Replace(Nz(IIf(IsNull([tSzem�lyek].[Szint 6 szervezeti egys�g k�d]),IIf(IsNull([tSzem�lyek].[Szint 5 szervezeti egys�g k�d]),IIf(IsNull([tSzem�lyek].[Szint 7 szervezeti egys�g k�d]),IIf(IsNull([tSzem�lyek].[Szint 4 szervezeti egys�g k�d]),IIf(IsNull([tSzem�lyek].[Szint 3 szervezeti egys�g k�d]),[tSzem�lyek].[Szint 2 szervezeti egys�g k�d] & "",[tSzem�lyek].[Szint 3 szervezeti egys�g k�d] & ""),[tSzem�lyek].[Szint 4 szervezeti egys�g k�d] & ""),[tSzem�lyek].[Szint 7 szervezeti egys�g k�d] & ""),[tSzem�lyek].[Szint 5 szervezeti egys�g k�d] & ""),[tSzem�lyek].[Szint 6 szervezeti egys�g k�d] & ""),""),"Budapest F�v�ros Korm�nyhivatala ","BFKH ") AS F�oszt�lyK�d, IIf([f�oszt�ly]=[Szint 7 szervezeti egys�g n�v],"",[Szint 7 szervezeti egys�g n�v] & "") AS Oszt�ly, Replace(Nz([Munkav�gz�s helye - c�m],"")," .",".") AS Munkav�gz�sC�me, tSzem�lyek.[besorol�si  fokozat (KT)] AS Besorol�s, Replace(Nz([tszem�lyek].[Besorol�si  fokozat (KT)],Nz([tBesorol�s�talak�t�Elt�r�Besorol�shoz].[Besorol�si  fokozat (KT)],"")),"/ ","") AS Besorol�s2, bfkh(Nz([szervezeti egys�g k�dja],0)) AS BFKH, Replace([Feladatk�r],"Lez�rt_","") AS Feladat, Nz([Iskolai v�gzetts�g foka],"-") AS V�gzetts�gFok, tSzem�lyek.[Sz�let�si id�] AS Sz�let�siIdeje, lk�ll�shelyek.jel2, dt�tal([Jogviszony v�ge (kil�p�s d�tuma)]) AS Kil�p�sD�tuma, Nz([tSzem�lyek].[TAJ sz�m],0)*1 AS TAJ, [T�rzssz�m]*1 AS Sz�mT�rzsSz�m
FROM (tSzem�lyek LEFT JOIN lk�ll�shelyek ON tSzem�lyek.[St�tusz k�dja] = lk�ll�shelyek.[�ll�shely azonos�t�]) LEFT JOIN tBesorol�s�talak�t�Elt�r�Besorol�shoz ON lk�ll�shelyek.[�ll�shely besorol�si kateg�ri�ja] = tBesorol�s�talak�t�Elt�r�Besorol�shoz.[�ll�shely besorol�si kateg�ri�ja]
WHERE (((dt�tal([Jogviszony kezdete (bel�p�s d�tuma)]))<=dt�tal(Nz([Keresett d�tum],Date()))) AND ((dt�tal(IIf(Nz([Jogviszony v�ge (kil�p�s d�tuma)],0)=0,#1/1/3000#,[Jogviszony v�ge (kil�p�s d�tuma)])))>=dt�tal(Nz([Keresett d�tum],Date()))))
ORDER BY tSzem�lyek.[Dolgoz� teljes neve];

-- [lkSzem�lyek�sNexonAz]
SELECT lkSzem�lyek.*, kt_azNexon_Ad�jel02.azNexon, kt_azNexon_Ad�jel02.NLink
FROM kt_azNexon_Ad�jel02 RIGHT JOIN lkSzem�lyek ON kt_azNexon_Ad�jel02.Ad�jel=lkSzem�lyek.Ad�jel;

-- [lkSzem�lyekF�oszt�lyOszt�lyLink]
SELECT lkSzem�lyek�sKil�p�kUni�.Ad�jel, lkSzem�lyek�sKil�p�kUni�.F�oszt�ly, lkSzem�lyek�sKil�p�kUni�.Oszt�ly, "https://nexonport.kh.gov.hu/menu/hrm/szemelyiKarton/index?szemelyAzonosito=" & [azNexon] & "&r=13" AS NexonLink, kt_azNexon_Ad�jel02.N�v
FROM (SELECT tSzem�lyek.Ad�jel,  Replace(Nz(IIf(IsNull([tSzem�lyek].[Szint 4 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek].[Szint 3 szervezeti egys�g n�v]),[tSzem�lyek].[Szint 2 szervezeti egys�g n�v] & "",[tSzem�lyek].[Szint 3 szervezeti egys�g n�v] & ""),[tSzem�lyek].[Szint 4 szervezeti egys�g n�v] & ""),""),"Budapest F�v�ros Korm�nyhivatala ","BFKH ") AS F�oszt�ly, tSzem�lyek.[Szint 5 szervezeti egys�g n�v] AS Oszt�ly FROM tSzem�lyek WHERE (((tSzem�lyek.[st�tusz neve])="�ll�shely")) UNION SELECT  [Ad�azonos�t�]*1 AS Ad�jel, IIf([Megyei szint VAGY J�r�si Hivatal]="megyei szint",[Mez�5],[Megyei szint VAGY J�r�si Hivatal]) AS F�oszt�ly, tKil�p�kUni�.mez�6 AS Oszt�ly FROM   tKil�p�kUni� UNION SELECT  [Ad�azonos�t�]*1 AS Ad�jel, IIf([Megyei szint VAGY J�r�si Hivatal]="megyei szint",[Mez�5],[Megyei szint VAGY J�r�si Hivatal]) AS F�oszt�ly, lkKil�p�k.mez�6 AS Oszt�ly FROM   lkKil�p�k  )  AS lkSzem�lyek�sKil�p�kUni� LEFT JOIN kt_azNexon_Ad�jel02 ON lkSzem�lyek�sKil�p�kUni�.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel;

-- [lkSzem�lyekF�oszt�s�sszesen]
SELECT UNI�.sor, UNI�.F�oszt�ly, Sum(UNI�.F�oszt�lyiL�tsz�m) AS F�oszt�lyiL�tsz�m, UNI�.F�osztK�d, Sum(UNI�.K�zpontos�tottL�tsz�m) AS K�zpontos�tottL�tsz�m
FROM (SELECT 1 AS sor, lkSzem�lyek.F�oszt�ly, Count(lkSzem�lyek.Ad�jel) AS F�oszt�lyiL�tsz�m, Bfkh([lkSzem�lyek].[F�oszt�lyK�d]) AS F�osztK�d, 0 AS K�zpontos�tottL�tsz�m
FROM lkSzem�lyek
WHERE lkSzem�lyek.[St�tusz neve]="�ll�shely" AND lkSzem�lyek.[St�tusz t�pusa] Like "Szervezeti alapl�tsz�m"
GROUP BY lkSzem�lyek.F�oszt�ly, Bfkh([lkSzem�lyek].[F�oszt�lyK�d]), lkSzem�lyek.[St�tusz neve], lkSzem�lyek.[St�tusz t�pusa]
UNION
SELECT 1 as sor, lkSzem�lyek.F�oszt�ly, 0 AS F�oszt�lyiL�tsz�m, Bfkh([lkSzem�lyek].[F�oszt�lyK�d]) as F�osztK�d, Count(lkSzem�lyek.Ad�jel) as K�zpontos�tottL�tsz�m
    FROM lkSzem�lyek 
       WHERE lkSzem�lyek.[St�tusz neve]="�ll�shely" AND lkSzem�lyek.[St�tusz t�pusa] Like "K�zpontos�tott �llom�ny"
       GROUP BY lkSzem�lyek.F�oszt�ly, lkSzem�lyek.[St�tusz neve], Bfkh([lkSzem�lyek].[F�oszt�lyK�d])
  UNION SELECT 2 as sor, "�sszesen:" as F�oszt�ly, Count(lkSzem�lyek.Ad�jel) AS CountOfAd�jel , "BFKH.99" as F�osztK�d, 0 AS K�zpontos�tottL�tsz�m
    FROM lkSzem�lyek 
       WHERE lkSzem�lyek.[St�tusz neve]="�ll�shely" AND lkSzem�lyek.[St�tusz t�pusa] Like "Szervezeti alapl�tsz�m"
       GROUP BY lkSzem�lyek.[St�tusz neve], "BFKH.99"
  UNION SELECT 2 as sor, "�sszesen:" as F�oszt�ly, 0 AS CountOfAd�jel , "BFKH.99" as F�osztK�d, Count(lkSzem�lyek.Ad�jel) AS K�zpontos�tottL�tsz�m
    FROM lkSzem�lyek 
       WHERE lkSzem�lyek.[St�tusz neve]="�ll�shely" AND lkSzem�lyek.[St�tusz t�pusa] Like "K�zpontos�tott �llom�ny"
       GROUP BY lkSzem�lyek.[St�tusz neve], "BFKH.99")  AS UNI�
GROUP BY UNI�.sor, UNI�.F�oszt�ly, UNI�.F�osztK�d
ORDER BY UNI�.sor;

-- [lkSzem�lyekKITesekNemTTsekAdottNapon]
SELECT DISTINCT tSzem�lyek.[Ad�azonos�t� jel]
FROM tSzem�lyek
WHERE (((tSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])="korm�nyzati szolg�lati jogviszony") AND ((tSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])<=[d�tum]) AND ((tSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)])>=[d�tum] Or (tSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)])=0) AND ((dt�tal([Tart�s t�voll�t kezdete]))>=dt�tal([d�tum]) Or (dt�tal([Tart�s t�voll�t kezdete]))=0)) OR (((tSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])="korm�nyzati szolg�lati jogviszony") AND ((tSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])<=[d�tum]) AND ((tSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)])>=[d�tum] Or (tSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)])=0) AND ((dt�tal([Tart�s t�voll�t v�ge])) Between 1 And dt�tal([d�tum])));

-- [lkSzem�lyekMind]
SELECT tSzem�lyek.Azonos�t�, tSzem�lyek.Ad�jel, tSzem�lyek.[Dolgoz� teljes neve], tSzem�lyek.[Dolgoz� sz�let�si neve], tSzem�lyek.[Sz�let�si id�], tSzem�lyek.[Sz�let�si hely], tSzem�lyek.[Anyja neve], tSzem�lyek.Neme, tSzem�lyek.T�rzssz�m, tSzem�lyek.[Egyedi azonos�t�], tSzem�lyek.[Ad�azonos�t� jel], tSzem�lyek.[TAJ sz�m], tSzem�lyek.[�gyf�lkapu k�d], tSzem�lyek.[Els�dleges �llampolg�rs�g], tSzem�lyek.[Szem�lyi igazolv�ny sz�ma], tSzem�lyek.[Szem�lyi igazolv�ny �rv�nyess�g kezdete], tSzem�lyek.[Szem�lyi igazolv�ny �rv�nyess�g v�ge], tSzem�lyek.[Nyelvtud�s Angol], tSzem�lyek.[Nyelvtud�s Arab], tSzem�lyek.[Nyelvtud�s Bolg�r], tSzem�lyek.[Nyelvtud�s Cig�ny], tSzem�lyek.[Nyelvtud�s Cig�ny (lov�ri)], tSzem�lyek.[Nyelvtud�s Cseh], tSzem�lyek.[Nyelvtud�s Eszperant�], tSzem�lyek.[Nyelvtud�s Finn], tSzem�lyek.[Nyelvtud�s Francia], tSzem�lyek.[Nyelvtud�s H�ber], tSzem�lyek.[Nyelvtud�s Holland], tSzem�lyek.[Nyelvtud�s Horv�t], tSzem�lyek.[Nyelvtud�s Jap�n], tSzem�lyek.[Nyelvtud�s Jelnyelv], tSzem�lyek.[Nyelvtud�s K�nai], tSzem�lyek.[Nyelvtud�s Latin], tSzem�lyek.[Nyelvtud�s Lengyel], tSzem�lyek.[Nyelvtud�s N�met], tSzem�lyek.[Nyelvtud�s Norv�g], tSzem�lyek.[Nyelvtud�s Olasz], tSzem�lyek.[Nyelvtud�s Orosz], tSzem�lyek.[Nyelvtud�s Portug�l], tSzem�lyek.[Nyelvtud�s Rom�n], tSzem�lyek.[Nyelvtud�s Spanyol], tSzem�lyek.[Nyelvtud�s Szerb], tSzem�lyek.[Nyelvtud�s Szlov�k], tSzem�lyek.[Nyelvtud�s Szlov�n], tSzem�lyek.[Nyelvtud�s T�r�k], tSzem�lyek.[Nyelvtud�s �jg�r�g], tSzem�lyek.[Nyelvtud�s Ukr�n], tSzem�lyek.[Orvosi vizsg�lat id�pontja], tSzem�lyek.[Orvosi vizsg�lat t�pusa], tSzem�lyek.[Orvosi vizsg�lat eredm�nye], tSzem�lyek.[Orvosi vizsg�lat �szrev�telek], tSzem�lyek.[Orvosi vizsg�lat k�vetkez� id�pontja], tSzem�lyek.[Erk�lcsi bizony�tv�ny sz�ma], tSzem�lyek.[Erk�lcsi bizony�tv�ny d�tuma], tSzem�lyek.[Erk�lcsi bizony�tv�ny eredm�nye], tSzem�lyek.[Erk�lcsi bizony�tv�ny k�relem azonos�t�], tSzem�lyek.[Erk�lcsi bizony�tv�ny k�z�gyekt�l eltiltva], tSzem�lyek.[Erk�lcsi bizony�tv�ny j�rm�vezet�st�l eltiltva], tSzem�lyek.[Erk�lcsi bizony�tv�ny int�zked�s alatt �ll], tSzem�lyek.[Munkak�ri le�r�sok (csatolt dokumentumok f�jlnevei)], tSzem�lyek.[Egy�b HR dokumentumok (csatolt dokumentumok f�jlnevei)], tSzem�lyek.[Korm�nyhivatal r�vid neve], tSzem�lyek.[Szervezeti egys�g k�dja], tSzem�lyek.[Szervezeti egys�g neve], tSzem�lyek.[Szervezeti munkak�r neve], tSzem�lyek.[Vezet�i megb�z�s t�pusa], tSzem�lyek.[St�tusz k�dja], tSzem�lyek.[St�tusz k�lts�ghely�nek k�dja], tSzem�lyek.[St�tusz k�lts�ghely�nek neve ], tSzem�lyek.[L�tsz�mon fel�l l�trehozott st�tusz], tSzem�lyek.[St�tusz t�pusa], tSzem�lyek.[St�tusz neve], tSzem�lyek.[T�bbes bet�lt�s], tSzem�lyek.[Vezet� neve], tSzem�lyek.[Vezet� ad�azonos�t� jele], tSzem�lyek.[Vezet� email c�me], tSzem�lyek.[�lland� lakc�m], tSzem�lyek.[Tart�zkod�si lakc�m], tSzem�lyek.[Levelez�si c�m_], tSzem�lyek.[�regs�gi nyugd�j-korhat�r el�r�s�nek id�pontja (d�tum)], tSzem�lyek.Nyugd�jas, tSzem�lyek.[Nyugd�j t�pusa], tSzem�lyek.[Nyugd�jas kor� tov�bbfoglalkoztat�si enged�llyel rendelkezik], tSzem�lyek.[Megv�ltozott munkak�pess�g], tSzem�lyek.[�nk�ntes tartal�kos katona], tSzem�lyek.[Utols� vagyonnyilatkozat lead�s�nak d�tuma], tSzem�lyek.[Vagyonnyilatkozat nyilv�ntart�si sz�ma], tSzem�lyek.[K�vetkez� vagyonnyilatkozat esed�kess�ge], tSzem�lyek.[Nemzetbiztons�gi ellen�rz�s d�tuma], tSzem�lyek.[V�dett �llom�nyba tartoz� munkak�r], tSzem�lyek.[Vezet�i megb�z�s t�pusa1], tSzem�lyek.[Vezet�i beoszt�s megnevez�se], tSzem�lyek.[Vezet�i beoszt�s (megb�z�s) kezdete], tSzem�lyek.[Vezet�i beoszt�s (megb�z�s) v�ge], tSzem�lyek.[Iskolai v�gzetts�g foka], tSzem�lyek.[Iskolai v�gzetts�g neve], tSzem�lyek.[Alapvizsga k�telez�s d�tuma], tSzem�lyek.[Alapvizsga let�tel t�nyleges hat�rideje], tSzem�lyek.[Alapvizsga mentess�g], tSzem�lyek.[Alapvizsga mentess�g oka], tSzem�lyek.[Szakvizsga k�telez�s d�tuma], tSzem�lyek.[Szakvizsga let�tel t�nyleges hat�rideje], tSzem�lyek.[Szakvizsga mentess�g], tSzem�lyek.[Foglalkoz�si viszony], tSzem�lyek.[Foglalkoz�si viszony statisztikai besorol�sa], tSzem�lyek.[Dolgoz� szerz�d�ses/kinevez�ses munkak�re / kinevez�si okm�nyban], tSzem�lyek.[Beoszt�stervez�s helysz�nek], tSzem�lyek.[Beoszt�stervez�s tev�kenys�gek], tSzem�lyek.[R�szleges t�vmunka szerz�d�s kezdete], tSzem�lyek.[R�szleges t�vmunka szerz�d�s v�ge], tSzem�lyek.[R�szleges t�vmunka szerz�d�s intervalluma], tSzem�lyek.[R�szleges t�vmunka szerz�d�s m�rt�ke], tSzem�lyek.[R�szleges t�vmunka szerz�d�s helysz�ne], tSzem�lyek.[R�szleges t�vmunka szerz�d�s helysz�ne 2], tSzem�lyek.[R�szleges t�vmunka szerz�d�s helysz�ne 3], tSzem�lyek.[Egy�ni t�l�ra keret meg�llapod�s kezdete], tSzem�lyek.[Egy�ni t�l�ra keret meg�llapod�s v�ge], tSzem�lyek.[Egy�ni t�l�ra keret meg�llapod�s m�rt�ke], tSzem�lyek.[KIRA feladat azonos�t�ja - int�zm�ny prefix-szel ell�tva], tSzem�lyek.[KIRA feladat azonos�t�ja], tSzem�lyek.[KIRA feladat megnevez�s], tSzem�lyek.[Osztott munkak�r], tSzem�lyek.[Funkci�csoport: k�d-megnevez�s], tSzem�lyek.[Funkci�: k�d-megnevez�s], tSzem�lyek.[Dolgoz� k�lts�ghely�nek k�dja], tSzem�lyek.[Dolgoz� k�lts�ghely�nek neve], tSzem�lyek.Feladatk�r, tSzem�lyek.[Els�dleges feladatk�r], tSzem�lyek.Feladatok, tSzem�lyek.FEOR, tSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� napi �raker], tSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker], tSzem�lyek.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� havi �raker], tSzem�lyek.[Szerz�d�s/Kinevez�s t�pusa], tSzem�lyek.Iktat�sz�m, tSzem�lyek.[Szerz�d�s/kinevez�s verzi�_�rv�nyess�g kezdete], tSzem�lyek.[Szerz�d�s/kinevez�s verzi�_�rv�nyess�g v�ge], tSzem�lyek.[Hat�rozott idej� _szerz�d�s/kinevez�s lej�r], tSzem�lyek.[Szerz�d�s dokumentum (csatolt dokumentumok f�jlnevei)], tSzem�lyek.[Megjegyz�s (pl# hat�rozott szerz�d�s/kinevez�s oka)], tSzem�lyek.[Munkav�gz�s helye - megnevez�s], tSzem�lyek.[Munkav�gz�s helye - c�m], tSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus], tSzem�lyek.[Jogviszony sorsz�ma], tSzem�lyek.[KIRA jogviszony jelleg], tSzem�lyek.[K�lcs�nbe ad� c�g], tSzem�lyek.[Teljes�tm�ny�rt�kel�s - �rt�kel� szem�ly], tSzem�lyek.[Teljes�tm�ny�rt�kel�s - �rv�nyess�g kezdet], tSzem�lyek.[Teljes�tm�ny�rt�kel�s - �rt�kelt id�szak kezdet], tSzem�lyek.[Teljes�tm�ny�rt�kel�s - �rt�kelt id�szak v�ge], tSzem�lyek.[Teljes�tm�ny�rt�kel�s d�tuma], tSzem�lyek.[Teljes�tm�ny�rt�kel�s - Be�ll�si sz�zal�k], tSzem�lyek.[Teljes�tm�ny�rt�kel�s - Pontsz�m], tSzem�lyek.[Teljes�tm�ny�rt�kel�s - Megjegyz�s], tSzem�lyek.[Dolgoz�i jellemz�k], tSzem�lyek.[Fizet�si oszt�ly (KA)/ Pedag�gusi fokozat (KA pedag�gus)/besorol], tSzem�lyek.[Besorol�si  fokozat (KT)], tSzem�lyek.[Jogfolytonos id� kezdete], tSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)], tSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)], dt�tal([Jogviszony v�ge (kil�p�s d�tuma)]) AS JogviszonyV�ge, tSzem�lyek.[Utols� munk�ban t�lt�tt nap], tSzem�lyek.[Kezdem�nyez�s d�tuma], tSzem�lyek.[Hat�lyoss� v�lik], tSzem�lyek.[HR kapcsolat megsz�n�s m�dja (Kil�p�s m�dja)], tSzem�lyek.[HR kapcsolat megsz�nes indoka (Kil�p�s indoka)], tSzem�lyek.Indokol�s, tSzem�lyek.[K�vetkez� munkahely], tSzem�lyek.[MT: Felmond�si id� kezdete KJT, KTTV: Felment�si id� kezdete], tSzem�lyek.[Felmond�si id� v�ge (MT) Felment�si id� v�ge (KJT, KTTV)], tSzem�lyek.[Munkav�gz�s al�li mentes�t�s kezdete (KJT, KTTV) Felment�si id� ], tSzem�lyek.[Munkav�gz�s al�li mentes�t�s v�ge (KJT, KTTV) Felment�si id� v�g], tSzem�lyek.[Tart�s t�voll�t t�pusa], tSzem�lyek.[Tart�s t�voll�t kezdete], tSzem�lyek.[Tart�s t�voll�t v�ge], tSzem�lyek.[Tart�s t�voll�t tervezett v�ge], tSzem�lyek.[Helyettes�tett dolgoz� neve], tSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge], tSzem�lyek.[Utal�si c�m], tSzem�lyek.[Alapilletm�ny / Munkab�r / Megb�z�si d�j (elt�r�t�s n�lk�li)], tSzem�lyek.[Garant�lt b�rminimumra t�rt�n� kieg�sz�t�s], tSzem�lyek.Kerek�t�s, tSzem�lyek.[Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S % (elt�r�t], tSzem�lyek.[Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S �sszeg (el], tSzem�lyek.[Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY % (elt�r�t�s n�lk�li)], tSzem�lyek.[Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY �sszeg (elt�r�t�s n�l], tSzem�lyek.[Egy�b p�tl�k - �sszeg (elt�r�t�s n�lk�li)], tSzem�lyek.[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�t�s n�lk�li)], tSzem�lyek.[Kerek�tett 100 %-os illetm�ny (elt�r�t�s n�lk�li)], tSzem�lyek.[Elt�r�t�s %], tSzem�lyek.[Alapilletm�ny / Munkab�r / Megb�z�si d�j (elt�r�tett)], tSzem�lyek.[Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S % (elt�r�1], tSzem�lyek.[Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S �sszeg (e1], tSzem�lyek.[Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY % (elt�r�tett)], tSzem�lyek.[Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY �sszeg (elt�r�tett)], tSzem�lyek.[Egy�b p�tl�k - �sszeg (elt�r�tett)], tSzem�lyek.[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)], tSzem�lyek.[Kerek�tett 100 %-os illetm�ny (elt�r�tett)], tSzem�lyek.[Tov�bbi munkav�gz�s helye 1 Teljes munkaid� %-a], tSzem�lyek.[Tov�bbi munkav�gz�s helye 2 Teljes munkaid� %-a], tSzem�lyek.[KT: Kerek�tett 100 %-os illetm�ny (elt�r�tett) + Helyettes�t�si ], tSzem�lyek.[Szint 1 szervezeti egys�g n�v], tSzem�lyek.[Szint 1 szervezeti egys�g k�d], tSzem�lyek.[Szint 2 szervezeti egys�g n�v], tSzem�lyek.[Szint 2 szervezeti egys�g k�d], tSzem�lyek.[Szint 3 szervezeti egys�g n�v], tSzem�lyek.[Szint 3 szervezeti egys�g k�d], tSzem�lyek.[Szint 6 szervezeti egys�g n�v], tSzem�lyek.[Szint 6 szervezeti egys�g k�d], tSzem�lyek.[Szint 7 szervezeti egys�g n�v], tSzem�lyek.[Szint 7 szervezeti egys�g k�d], tSzem�lyek.[AD egyedi azonos�t�], tSzem�lyek.[Hivatali email], tSzem�lyek.[Hivatali mobil], tSzem�lyek.[Hivatali telefon], tSzem�lyek.[Hivatali telefon mell�k], tSzem�lyek.Iroda, tSzem�lyek.[Otthoni e-mail], tSzem�lyek.[Otthoni mobil], tSzem�lyek.[Otthoni telefon], tSzem�lyek.[Tov�bbi otthoni mobil], Replace(Nz(IIf(IsNull([tSzem�lyek].[Szint 6 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek].[Szint 5 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek].[Szint 7 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek].[Szint 4 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek].[Szint 3 szervezeti egys�g n�v]),[tSzem�lyek].[Szint 2 szervezeti egys�g n�v] & "",[tSzem�lyek].[Szint 3 szervezeti egys�g n�v] & ""),[tSzem�lyek].[Szint 4 szervezeti egys�g n�v] & ""),[tSzem�lyek].[Szint 7 szervezeti egys�g n�v] & ""),[tSzem�lyek].[Szint 5 szervezeti egys�g n�v] & ""),[tSzem�lyek].[Szint 6 szervezeti egys�g n�v] & ""),""),"Budapest F�v�ros Korm�nyhivatala ","BFKH ") & "" AS F�oszt�ly, IIf([f�oszt�ly]=[Szint 7 szervezeti egys�g n�v],"",[Szint 7 szervezeti egys�g n�v] & "") AS Oszt�ly
FROM tSzem�lyek;

-- [lkSzem�lyekNemMegb�z�s�sNemSzem�lyesJelenl�t]
SELECT tSzem�lyek.*, Replace(Nz(IIf(IsNull([tSzem�lyek].[Szint 6 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek].[Szint 5 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek].[Szint 7 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek].[Szint 4 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek].[Szint 3 szervezeti egys�g n�v]),[tSzem�lyek].[Szint 2 szervezeti egys�g n�v] & "",[tSzem�lyek].[Szint 3 szervezeti egys�g n�v] & ""),[tSzem�lyek].[Szint 4 szervezeti egys�g n�v] & ""),[tSzem�lyek].[Szint 7 szervezeti egys�g n�v] & ""),[tSzem�lyek].[Szint 5 szervezeti egys�g n�v] & ""),[tSzem�lyek].[Szint 6 szervezeti egys�g n�v] & ""),""),"Budapest F�v�ros Korm�nyhivatala ","BFKH ") & "" AS F�oszt�ly, Replace(Nz(IIf(IsNull([tSzem�lyek].[Szint 6 szervezeti egys�g k�d]),IIf(IsNull([tSzem�lyek].[Szint 5 szervezeti egys�g k�d]),IIf(IsNull([tSzem�lyek].[Szint 7 szervezeti egys�g k�d]),IIf(IsNull([tSzem�lyek].[Szint 4 szervezeti egys�g k�d]),IIf(IsNull([tSzem�lyek].[Szint 3 szervezeti egys�g k�d]),[tSzem�lyek].[Szint 2 szervezeti egys�g k�d] & "",[tSzem�lyek].[Szint 3 szervezeti egys�g k�d] & ""),[tSzem�lyek].[Szint 4 szervezeti egys�g k�d] & ""),[tSzem�lyek].[Szint 7 szervezeti egys�g k�d] & ""),[tSzem�lyek].[Szint 5 szervezeti egys�g k�d] & ""),[tSzem�lyek].[Szint 6 szervezeti egys�g k�d] & ""),""),"Budapest F�v�ros Korm�nyhivatala ","BFKH ") AS F�oszt�lyK�d, IIf([f�oszt�ly]=[Szint 7 szervezeti egys�g n�v],"",[Szint 7 szervezeti egys�g n�v] & "") AS Oszt�ly, Replace(Nz([Munkav�gz�s helye - c�m],"")," .",".") AS Munkav�gz�sC�me, tSzem�lyek.[besorol�si  fokozat (KT)] AS Besorol�s, Replace(Nz([tszem�lyek].[Besorol�si  fokozat (KT)],Nz([tBesorol�s�talak�t�Elt�r�Besorol�shoz].[Besorol�si  fokozat (KT)],"")),"/ ","") AS Besorol�s2, bfkh(Nz([szervezeti egys�g k�dja],0)) AS BFKH, Replace([Feladatk�r],"Lez�rt_","") AS Feladat, Nz([Iskolai v�gzetts�g foka],"-") AS V�gzetts�gFok, tSzem�lyek.[Sz�let�si id�] AS Sz�let�siIdeje, lk�ll�shelyek.jel2, dt�tal([Jogviszony v�ge (kil�p�s d�tuma)]) AS Kil�p�sD�tuma, Nz([tSzem�lyek].[TAJ sz�m],0)*1 AS TAJ, [T�rzssz�m]*1 AS Sz�mT�rzsSz�m
FROM (tSzem�lyek LEFT JOIN lk�ll�shelyek ON tSzem�lyek.[St�tusz k�dja] = lk�ll�shelyek.[�ll�shely azonos�t�]) LEFT JOIN tBesorol�s�talak�t�Elt�r�Besorol�shoz ON lk�ll�shelyek.[�ll�shely besorol�si kateg�ri�ja] = tBesorol�s�talak�t�Elt�r�Besorol�shoz.[�ll�shely besorol�si kateg�ri�ja]
WHERE ((((SELECT Max(iif(Nz(Tmp.[Jogviszony v�ge (kil�p�s d�tuma)],0)=0,#01/01/3000#,Tmp.[Jogviszony v�ge (kil�p�s d�tuma)])) AS [MaxOfJogviszony sorsz�ma]   FROM tSzem�lyek as Tmp         WHERE tSzem�lyek.Ad�jel=Tmp.Ad�jel AND
[Jogviszony t�pusa / jogviszony t�pus]<>"megb�z�sos"
AND
[Jogviszony t�pusa / jogviszony t�pus]<>"szem�lyes jelenl�t"
GROUP BY Tmp.Ad�jel  ))=IIf(Nz([Jogviszony v�ge (kil�p�s d�tuma)],0)=0,#1/1/3000#,[Jogviszony v�ge (kil�p�s d�tuma)])))
ORDER BY tSzem�lyek.[Dolgoz� teljes neve];

-- [lkSzem�lyekV�gzetts�geinekSz�ma]
SELECT lkV�gzetts�gek.Ad�jel, Count(lkV�gzetts�gek.Azonos�t�) AS V�gzetts�geinekASz�ma
FROM lkV�gzetts�gek
GROUP BY lkV�gzetts�gek.Ad�jel;

-- [lkSzem�lykeres�]
SELECT tSzem�lyek.[Dolgoz� teljes neve], Replace(Nz(IIf(IsNull([tSzem�lyek].[Szint 6 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek].[Szint 5 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek].[Szint 7 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek].[Szint 4 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek].[Szint 3 szervezeti egys�g n�v]),[tSzem�lyek].[Szint 2 szervezeti egys�g n�v] & "",[tSzem�lyek].[Szint 3 szervezeti egys�g n�v] & ""),[tSzem�lyek].[Szint 4 szervezeti egys�g n�v] & ""),[tSzem�lyek].[Szint 7 szervezeti egys�g n�v] & ""),[tSzem�lyek].[Szint 5 szervezeti egys�g n�v] & ""),[tSzem�lyek].[Szint 6 szervezeti egys�g n�v] & ""),""),"Budapest F�v�ros Korm�nyhivatala ","BFKH ") & "" AS F�oszt�ly, IIf([f�oszt�ly]=[Szint 7 szervezeti egys�g n�v],"",[Szint 7 szervezeti egys�g n�v] & "") AS Oszt�ly, tSzem�lyek.[Sz�let�si id�], tSzem�lyek.[Sz�let�si hely], tSzem�lyek.[Anyja neve], tSzem�lyek.[St�tusz k�dja], tSzem�lyek.[St�tusz neve], tSzem�lyek.[KIRA jogviszony jelleg], tSzem�lyek.[Besorol�si  fokozat (KT)], tSzem�lyek.[Kerek�tett 100 %-os illetm�ny (elt�r�tett)], tSzem�lyek.[Iskolai v�gzetts�g foka], tSzem�lyek.[Iskolai v�gzetts�g neve], tSzem�lyek.[Jogviszony sorsz�ma], tSzem�lyek.Azonos�t�, kt_azNexon_Ad�jel02.azNexon, kt_azNexon_Ad�jel02.NLink, tSzem�lyek.Ad�jel, tSzem�lyek.[KIRA feladat megnevez�s]
FROM kt_azNexon_Ad�jel02 RIGHT JOIN tSzem�lyek ON kt_azNexon_Ad�jel02.Ad�jel = tSzem�lyek.Ad�jel
WHERE (((tSzem�lyek.[Dolgoz� teljes neve]) Like "*" & �rlapok!�Szem�lykeres�!Keres� & "*") And ((tSzem�lyek.[St�tusz neve]) Like IIf(�rlapok!�Szem�lykeres�!�ll�shelyen,"�ll�shely","*") Or (tSzem�lyek.[St�tusz neve]) Like IIf(�rlapok!�Szem�lykeres�!�ll�shelyen,"�ll�shely",Null)));

-- [lkSzem�lyTelephelyek]
SELECT lkSzem�lyek.Ad�jel, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[Munkav�gz�s helye - c�m], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Tart�s t�voll�t t�pusa] AS [Tart�s t�voll�t jogc�me], lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)] AS [Kil�p�s d�tuma], lkSzem�lyek.BFKH, lkSzem�lyek.[Munkav�gz�s helye - c�m] AS TelephelyC�me
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.BFKH) Is Not Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.BFKH, lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkSzem�lyUtols�SzervezetiEgys�ge]
SELECT lkSzem�lyekNemMegb�z�s�sNemSzem�lyesJelenl�t.Ad�jel, lkSzem�lyekNemMegb�z�s�sNemSzem�lyesJelenl�t.Kil�p�sD�tuma, IIf([lkSzem�lyekNemMegb�z�s�sNemSzem�lyesJelenl�t].[f�oszt�ly]="" Or [lkSzem�lyekNemMegb�z�s�sNemSzem�lyesJelenl�t].[f�oszt�ly] Is Null,IIf([lkKil�p�Uni�].[f�oszt�ly]="","-",[lkKil�p�Uni�].[f�oszt�ly]),[lkSzem�lyekNemMegb�z�s�sNemSzem�lyesJelenl�t].[f�oszt�ly]) AS F�oszt�ly, IIf([lkSzem�lyekNemMegb�z�s�sNemSzem�lyesJelenl�t].[oszt�ly]="",IIf([lkKil�p�Uni�].[oszt�ly]="","-",[lkKil�p�Uni�].[oszt�ly]),[lkSzem�lyekNemMegb�z�s�sNemSzem�lyesJelenl�t].[oszt�ly]) AS Oszt�ly, IIf([lkSzem�lyekNemMegb�z�s�sNemSzem�lyesJelenl�t].[f�oszt�lyk�d]="",[�nyr szervezeti egys�g azonos�t�],[lkSzem�lyekNemMegb�z�s�sNemSzem�lyesJelenl�t].[f�oszt�lyk�d]) AS F�oszt�lyK�d, IIf([St�tusz k�dja] Is Null,[�ll�shely azonos�t�],[St�tusz k�dja]) AS �NYR, Nz([St�tusz t�pusa],IIf(Nz([Alapl�tsz�m],"A")="A","Szervezeti alapl�tsz�m","K�zpontos�tott �llom�ny")) AS Jelleg
FROM lkSzem�lyekNemMegb�z�s�sNemSzem�lyesJelenl�t LEFT JOIN lkKil�p�Uni� ON (lkSzem�lyekNemMegb�z�s�sNemSzem�lyesJelenl�t.[Jogviszony v�ge (kil�p�s d�tuma)] = lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]) AND (lkSzem�lyekNemMegb�z�s�sNemSzem�lyesJelenl�t.Ad�jel = lkKil�p�Uni�.Ad�jel)
ORDER BY lkSzem�lyekNemMegb�z�s�sNemSzem�lyesJelenl�t.Kil�p�sD�tuma;

-- [lkSzervezet�ll�shelyek]
SELECT DISTINCT tSzervezet.OSZLOPOK, tSzervezet.[Szervezetmenedzsment k�d] AS �ll�shely, Choose([tSzervezet]![Szervezeti egys�g�nek szintje],[tSzervezet]![Szint1 - k�d],[tSzervezet]![Szint2 - k�d],[tSzervezet]![Szint3 - k�d],[tSzervezet]![Szint4 - k�d],[tSzervezet]![Szint5 - k�d],[tSzervezet]![Szint6 - k�d],[tSzervezet]![Szint7 - k�d],[tSzervezet]![Szint8 - k�d]) AS SzervezetK�d, IIf(InStr(1,[OSZLOPOK],"bet�lt�tt")>0,True,False) AS Bet�lt�tt, tSzervezet.[Vezet�i st�tusz], tSzervezet.[St�tusz t�pusa], tSzervezet.[St�tusz bet�lt�si �rasz�ma], tSzervezet.[St�tusz bet�lt�si FTE], tSzervezet.[Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s], tSzervezet.[�rv�nyess�g kezdete], tSzervezet.[�rv�nyess�g v�ge], tSzervezet.[Szint3 - le�r�s], tSzervezet.[Szint4 - le�r�s], tSzervezet.[Szint5 - le�r�s], tSzervezet.[Szint6 - le�r�s], tSzervezet.[Szint7 - le�r�s]
FROM tSzervezet
WHERE (((tSzervezet.OSZLOPOK) Like "St�tusz (*") AND ((tSzervezet.[Szervezetmenedzsment k�d]) Like "S-*"));

-- [lkSzervezetekSzem�lyekb�l]
SELECT DISTINCT bfkh(Nz([Szervezeti egys�g k�dja],1)) AS bfkh, lkSzem�lyek.[Szervezeti egys�g k�dja], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null))
ORDER BY bfkh(Nz([Szervezeti egys�g k�dja],1));

-- [lkSzervezetenk�nti l�tsz�madatok01]
SELECT lkHaviL�tsz�m.BFKHK�d, lkHaviL�tsz�m.F�oszt�ly, lkHaviL�tsz�m.Oszt�ly, lkHaviL�tsz�m.[Bet�lt�tt l�tsz�m], [TT]*-1 AS TTL�tsz�m, 0 AS Hat�rozottL�tsz�m, 0 AS Korr
FROM lkHaviL�tsz�m
WHERE ((([lkHaviL�tsz�m].[jelleg])="A"))
GROUP BY lkHaviL�tsz�m.BFKHK�d, lkHaviL�tsz�m.F�oszt�ly, lkHaviL�tsz�m.Oszt�ly, lkHaviL�tsz�m.[Bet�lt�tt l�tsz�m], [TT]*-1;

-- [lkSzervezetenk�nti l�tsz�madatok02]
SELECT Alapl�tsz�mUni�.BFKHK�d, Alapl�tsz�mUni�.F�oszt�ly, Alapl�tsz�mUni�.Oszt�ly, Sum(Alapl�tsz�mUni�.[Bet�lt�tt l�tsz�m]) AS [SumOfBet�lt�tt l�tsz�m], Sum(Alapl�tsz�mUni�.TTL�tsz�m) AS SumOfTTL�tsz�m, Sum(Alapl�tsz�mUni�.Hat�rozottL�tsz�m) AS SumOfHat�rozottL�tsz�m, Sum(Alapl�tsz�mUni�.Korr) AS SumOfKorr
FROM (SELECT [lkSzervezetenk�nti l�tsz�madatok01].*
FROM [lkSzervezetenk�nti l�tsz�madatok01]

UNION
SELECT lkHat�rozottak_TTH_Oszt�lyonk�ntiL�tsz�m.*
FROM   lkHat�rozottak_TTH_Oszt�lyonk�ntiL�tsz�m)  AS Alapl�tsz�mUni�
GROUP BY Alapl�tsz�mUni�.BFKHK�d, Alapl�tsz�mUni�.F�oszt�ly, Alapl�tsz�mUni�.Oszt�ly;

-- [lkSzervezetenk�ntiL�tsz�madatok03]
SELECT [lkSzervezetenk�nti l�tsz�madatok02].F�oszt�ly, [lkSzervezetenk�nti l�tsz�madatok02].Oszt�ly, [SumofBet�lt�tt l�tsz�m]+[SumofTTL�tsz�m]+[SumofHat�rozottL�tsz�m]+[SumofKorr] AS L�tsz�m
FROM [lkSzervezetenk�nti l�tsz�madatok02]
ORDER BY bfkh([BFKHK�d]);

-- [lkSzervezeti�ll�shelyek]
SELECT tSzervezeti.OSZLOPOK, bfkh(Nz([tSzervezeti].[Sz�l� szervezeti egys�g�nek k�dja],"")) AS SzervezetK�d, tSzervezeti.[Sz�l� szervezeti egys�g�nek k�dja], tSzervezeti.[Szervezetmenedzsment k�d] AS �ll�shelyAzonos�t�, IIf([Szervezeti egys�g�nek szintje]=7 And [Szint3 - k�d]="",[Sz�l� szervezeti egys�g�nek k�dja],IIf([Szint6 - k�d]="",IIf([Szint5 - k�d]="",IIf([Szint4 - k�d]="",IIf([Szint3 - k�d]="",[Szint2 - k�d],[Szint3 - k�d]),[Szint4 - k�d]),[Szint5 - k�d]),[Szint6 - k�d])) AS F�oszt�lyK�d, tSzervezeti.[Megnevez�s sz�t�relem k�dja], tSzervezeti.N�v, tSzervezeti.[�rv�nyess�g kezdete], tSzervezeti.[�rv�nyess�g v�ge], tSzervezeti.[K�lts�ghely k�d], tSzervezeti.[K�lts�ghely megnevez�s], tSzervezeti.[Szervezeti egys�g�nek szintje], tSzervezeti.[Sz�l� szervezeti egys�g�nek k�dja], tSzervezeti.[Szervezeti egys�g�nek megnevez�se], tSzervezeti.[Szervezeti egys�g�nek vezet�je], tSzervezeti.[Szervezeti egys�g�nek vezet�j�nek azonos�t�ja], tSzervezeti.[A k�lts�ghely elt�r a szervezeti egys�g�nek k�lts�ghelyt�l?], tSzervezeti.[Szervezeti munkak�r�nek k�dja], tSzervezeti.[Szervezeti munkak�r�nek megnevez�se], tSzervezeti.[A k�lts�ghely elt�r a szervezeti munkak�r�nek k�lts�ghely�t�l?], tSzervezeti.[Vezet�i st�tusz], tSzervezeti.[Helyettes vezet�-e], tSzervezeti.[Tervezett bet�lt�si adatok - Jogviszony t�pus], tSzervezeti.[Tervezett bet�lt�si adatok - Kulcssz�m k�d], tSzervezeti.[Tervezett bet�lt�si adatok - Kulcssz�m megnevez�s], tSzervezeti.[Tervezett bet�lt�si adatok - El�meneteli fokozat k�d], tSzervezeti.[Tervezett bet�lt�si adatok - El�meneteli fokozat megnevez�s], tSzervezeti.[P�ly�ztat�s hat�rideje], tSzervezeti.[Vezet�i beoszt�s KT], tSzervezeti.[P�ly�ztat�s alatt �ll], tSzervezeti.Megjegyz�s, tSzervezeti.[St�tusz enged�lyezett �rasz�ma], tSzervezeti.[St�tusz enged�lyezett FTE (�zleti param�ter szerint sz�molva)], tSzervezeti.[�tmeneti �rasz�m], tSzervezeti.[�tmeneti l�tsz�m (FTE)], tSzervezeti.[K�zz�tett hierarchi�ban megjelen�tend�], tSzervezeti.[Asszisztens st�tusz], tSzervezeti.[L�tsz�mon fel�l l�trehozott st�tusz], tSzervezeti.[St�tusz t�pusa], tSzervezeti.[St�tusz bet�lt�si �rasz�ma], tSzervezeti.[St�tusz bet�lt�si FTE], tSzervezeti.[St�tusz bet�lt�si �rasz�ma minusz st�tusz enged�lyezett �rasz�ma], tSzervezeti.[St�tusz bet�lt�si FTE minusz st�tusz enged�lyezett FTE], tSzervezeti.[Mi�ta bet�ltetlen a st�tusz (d�tum)], tSzervezeti.[H�ny napja bet�ltetlen (munkanap, alapnapt�r alapj�n)], tSzervezeti.[Szint1 - k�d], tSzervezeti.[Szint1 - le�r�s], tSzervezeti.[Szint2 - k�d], tSzervezeti.[Szint2 - le�r�s], tSzervezeti.[Szint3 - k�d], tSzervezeti.[Szint3 - le�r�s], tSzervezeti.[Szint4 - k�d], tSzervezeti.[Szint4 - le�r�s], tSzervezeti.[Szint5 - k�d], tSzervezeti.[Szint5 - le�r�s], tSzervezeti.[Szint6 - k�d], tSzervezeti.[Szint6 - le�r�s], tSzervezeti.[Szint7 - k�d], tSzervezeti.[Szint7 - le�r�s], tSzervezeti.[Szint8 - k�d], tSzervezeti.[Szint8 - le�r�s], Replace(Choose(IIf([Szervezeti egys�g�nek szintje]>6,IIf([tSzervezeti].[Szint6 - le�r�s]="",5,6),[Szervezeti egys�g�nek szintje]),[tSzervezeti].[Szint1 - le�r�s],[tSzervezeti].[Szint2 - le�r�s],[tSzervezeti].[Szint3 - le�r�s],[tSzervezeti].[Szint4 - le�r�s],[tSzervezeti].[Szint5 - le�r�s],[tSzervezeti].[Szint6 - le�r�s]) & IIf([tSzervezeti].[Szint7 - k�d]="BFKH.1.7.",[tSzervezeti].[Szint7 - le�r�s],""),"Budapest F�v�ros Korm�nyhivatala","BFKH") AS F�oszt�ly, IIf([tSzervezeti].[Szint7 - k�d]="BFKH.1.7.","",[tSzervezeti].[Szint7 - le�r�s]) AS Oszt�ly
FROM tSzervezeti
WHERE (((tSzervezeti.[Szervezetmenedzsment k�d]) Like "S-*") AND ((tSzervezeti.[�rv�nyess�g kezdete])<=Date()) AND ((tSzervezeti.[�rv�nyess�g v�ge])>=Date() Or (tSzervezeti.[�rv�nyess�g v�ge])=0));

-- [lkSzervezeti�ll�shelyek - azonosak keres�se]
SELECT First(lkSzervezeti�ll�shelyek.�ll�shelyAzonos�t�) AS [�ll�shelyAzonos�t� Mez�], Count(lkSzervezeti�ll�shelyek.�ll�shelyAzonos�t�) AS AzonosakSz�ma
FROM lkSzervezeti�ll�shelyek
GROUP BY lkSzervezeti�ll�shelyek.�ll�shelyAzonos�t�
HAVING (((Count(lkSzervezeti�ll�shelyek.�ll�shelyAzonos�t�))>1));

-- [lkSzervezetiBet�lt�sek]
SELECT tSzervezeti.OSZLOPOK, tSzervezeti.[Szervezetmenedzsment k�d], IIf([Szervezeti egys�g�nek szintje]=7 And [Szint3 - k�d]="",[Sz�l� szervezeti egys�g�nek k�dja],IIf([Szint6 - k�d]="",IIf([Szint5 - k�d]="",IIf([Szint4 - k�d]="",IIf([Szint3 - k�d]="",[Szint2 - k�d],[Szint3 - k�d]),[Szint4 - k�d]),[Szint5 - k�d]),[Szint6 - k�d])) AS F�oszt�lyK�d, tSzervezeti.[HR kapcsolat sorsz�ma], tSzervezeti.N�v, tSzervezeti.[�rv�nyess�g kezdete], tSzervezeti.[�rv�nyess�g v�ge], tSzervezeti.[K�lts�ghely k�d], tSzervezeti.[K�lts�ghely megnevez�s], tSzervezeti.[Szervezeti egys�g�nek szintje], tSzervezeti.[Sz�l� szervezeti egys�g�nek k�dja], tSzervezeti.[Szervezeti egys�g�nek megnevez�se], tSzervezeti.[Szervezeti egys�g�nek vezet�je], tSzervezeti.[Szervezeti egys�g�nek vezet�j�nek azonos�t�ja], tSzervezeti.[A k�lts�ghely elt�r a szervezeti egys�g�nek k�lts�ghelyt�l?], tSzervezeti.[Szervezeti munkak�r�nek k�dja], tSzervezeti.[Szervezeti munkak�r�nek megnevez�se], tSzervezeti.[A k�lts�ghely elt�r a szervezeti munkak�r�nek k�lts�ghely�t�l?], tSzervezeti.[St�tuszbet�lt�ssel rendelkezik a kil�p�st k�vet�en?], tSzervezeti.[K�zz�tett hierarchi�ban megjelen�tend�], tSzervezeti.[Helyettes�t�s m�rt�ke (%)], tSzervezeti.[Helyettes�t�si d�j (%)], tSzervezeti.[St�tusz�nak k�dja], tSzervezeti.[St�tusz�nak neve], tSzervezeti.[St�tusz�nak az enged�lyezett �rasz�ma], tSzervezeti.[St�tusz enged�lyezett FTE (�zleti param�ter szerint sz�molva)], tSzervezeti.[Aktu�lis bet�lt�s �rasz�ma], tSzervezeti.[Aktu�lis bet�lt�s FTE], tSzervezeti.[St�tusz�nak k�lts�ghely k�dja], tSzervezeti.[St�tusz�nak k�lts�ghely megnevez�se], tSzervezeti.[A k�lts�ghely elt�r a st�tusz�nak k�lts�ghely�t�l?], tSzervezeti.[A B�r F6 besorol�si szint elt�r a szervezeti munkak�r�nek B�r F6], tSzervezeti.[St�tuszbet�lt�s t�pusa], tSzervezeti.[Inakt�v �llom�nyba ker�l�s oka], tSzervezeti.[Tart�s t�voll�t kezdete], tSzervezeti.[Tart�s t�voll�t sz�m�tott kezdete], tSzervezeti.[Tart�s t�voll�t v�ge], tSzervezeti.[Tart�s t�voll�t t�pusa], tSzervezeti.Els�dleges, tSzervezeti.[St�tusz vizualiz�ci�j�ban el�sz�r megjelen�tend�], tSzervezeti.[Bet�lt� szerz�d�ses/kinevez�ses munkak�r�nek k�dja], tSzervezeti.[Bet�lt� szerz�d�ses/kinevez�ses munkak�r�nek neve], tSzervezeti.[Szervezeti munkak�r elt�r a szerz�d�ses/kinevez�ses munkak�rt�l], tSzervezeti.[Bet�lt� k�zvetlen vezet�je], tSzervezeti.[Bet�lt� k�zvetlen vezet�j�nek azonos�t�ja], tSzervezeti.[Szint1 - k�d], tSzervezeti.[Szint1 - le�r�s], tSzervezeti.[Szint2 - k�d], tSzervezeti.[Szint2 - le�r�s], tSzervezeti.[Szint3 - k�d], tSzervezeti.[Szint3 - le�r�s], tSzervezeti.[Szint4 - k�d], tSzervezeti.[Szint4 - le�r�s], tSzervezeti.[Szint5 - k�d], tSzervezeti.[Szint5 - le�r�s], tSzervezeti.[Szint6 - k�d], tSzervezeti.[Szint6 - le�r�s], tSzervezeti.[Szint7 - k�d], tSzervezeti.[Szint7 - le�r�s], tSzervezeti.[Szint8 - k�d], tSzervezeti.[Szint8 - le�r�s], tSzervezeti.[HRM-ben l�v� k�lts�ghely k�d besorol�si adat], tSzervezeti.[HRM-ben l�v� k�lts�ghely megnevez�s besorol�si adat], tSzervezeti.[A K�lts�ghely �rv�nyess�g�nek kezdete], tSzervezeti.[HRM-ben l�v� FEOR besorol�si adat], tSzervezeti.[A FEOR �rv�nyess�g�nek kezdete], tSzervezeti.[A FEOR �rv�nyess�g�nek v�ge], tSzervezeti.[HRM-ben l�v� Munkak�r besorol�si adat], tSzervezeti.[A Munkak�r �rv�nyess�g�nek kezdete]
FROM tSzervezeti
WHERE (((tSzervezeti.OSZLOPOK)="St�tusz bet�lt�s") AND ((tSzervezeti.[�rv�nyess�g kezdete])<=Date()) AND ((tSzervezeti.[�rv�nyess�g v�ge])>=Date() Or (tSzervezeti.[�rv�nyess�g v�ge])=0) AND ((tSzervezeti.[St�tusz�nak k�dja]) Like "S-*") AND ((tSzervezeti.[St�tuszbet�lt�s t�pusa])<>"Helyettes"));

-- [lkSzervezetiBet�lt�sek - azonosak keres�se]
SELECT First(lkSzervezetiBet�lt�sek.[St�tusz�nak k�dja]) AS [St�tusz�nak k�dja Mez�], Count(lkSzervezetiBet�lt�sek.[St�tusz�nak k�dja]) AS AzonosakSz�ma
FROM lkSzervezetiBet�lt�sek
GROUP BY lkSzervezetiBet�lt�sek.[St�tusz�nak k�dja]
HAVING (((Count(lkSzervezetiBet�lt�sek.[St�tusz�nak k�dja]))>1));

-- [lkSzervezetiEgys�gekLegnagyobbL�tsz�m�Telephelyei]
SELECT lkTelephelyekL�tsz�ma.BFKH, lkTelephelyekL�tsz�ma.F�oszt�ly, lkTelephelyekL�tsz�ma.Oszt�ly, lkTelephelyekL�tsz�ma.C�m
FROM lkTelephelyekL�tsz�ma INNER JOIN (SELECT Tmp.BFKH, Max(Tmp.L�tsz�m) AS MaxOfL�tsz�m FROM lkTelephelyekL�tsz�ma AS Tmp GROUP BY Tmp.BFKH)  AS TMP1 ON (lkTelephelyekL�tsz�ma.L�tsz�m = TMP1.MaxOfL�tsz�m) AND (lkTelephelyekL�tsz�ma.BFKH = TMP1.BFKH);

-- [lkSzervezetiHib�sanNemEls�dleges]
SELECT DISTINCT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], dt�tal([tSzervezeti].[�rv�nyess�g kezdete]) AS [Bet�lt�s kezdete], IIf(dt�tal([tSzervezeti].[�rv�nyess�g v�ge])=0,"",dt�tal([tSzervezeti].[�rv�nyess�g v�ge])) AS [Bet�lt�s v�ge], kt_azNexon_Ad�jel02.NLink
FROM kt_azNexon_Ad�jel02 RIGHT JOIN (lkSzem�lyek INNER JOIN (tSzervezeti INNER JOIN lkSzervezet�ll�shelyek ON tSzervezeti.[St�tusz�nak k�dja] = lkSzervezet�ll�shelyek.�ll�shely) ON lkSzem�lyek.[Ad�azonos�t� jel] = tSzervezeti.[Szervezetmenedzsment k�d]) ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((dt�tal([tSzervezeti].[�rv�nyess�g kezdete]))<=dt�tal(Now())) AND ((IIf(dt�tal([tSzervezeti].[�rv�nyess�g v�ge])=0,"",dt�tal([tSzervezeti].[�rv�nyess�g v�ge])))>=dt�tal(Now()) Or (IIf(dt�tal([tSzervezeti].[�rv�nyess�g v�ge])=0,"",dt�tal([tSzervezeti].[�rv�nyess�g v�ge])))="") AND ((dt�tal([lkSzervezet�ll�shelyek].[�rv�nyess�g kezdete]))<=dt�tal(Now())) AND ((dt�tal(N�([lkSzervezet�ll�shelyek].[�rv�nyess�g v�ge],#1/1/3000#)))>=dt�tal(Now())) AND ((tSzervezeti.OSZLOPOK)="St�tusz bet�lt�s") AND ((tSzervezeti.Els�dleges)="nem"));

-- [lkSzervezetiStatisztika01]
SELECT Replace(Replace([OSZLOPOK],"Szervezeti egys�g �sszesen (",""),")","") AS [Szervezeti egys�g neve], tSzervezet.[Bet�lt�tt st�tuszok sz�ma (db)], tSzervezet.[Bet�ltetlen st�tuszok sz�ma (db)]
FROM tSzervezet
WHERE (((tSzervezet.OSZLOPOK) Like "Szervezeti egys�g �sszesen (*"));

-- [lkSzervezetiUtols�Bet�lt�sek]
SELECT tSzervezet.[Szervezetmenedzsment k�d], Max(IIf([�rv�nyess�g v�ge]=0,#1/1/3000#,[�rv�nyess�g v�ge])) AS Maxv�g INTO tSzervezetiUtols�Bet�lt�sekTmp
FROM tSzervezet
WHERE (((tSzervezet.OSZLOPOK)="st�tusz bet�lt�s"))
GROUP BY tSzervezet.[Szervezetmenedzsment k�d];

-- [lkSzervezetiUtols�Megsz�ntBet�lt�sHib�sEls�dlegesVolt]
SELECT DISTINCT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], tSzervezeti.[Szervezetmenedzsment k�d], tNexonAzonos�t�k.[Szem�ly azonos�t�], tSzervezeti.Els�dleges, tSzervezeti.[�rv�nyess�g v�ge] AS Bet�lt�sV�g, dt�tal(N�([Jogviszony v�ge (kil�p�s d�tuma)],#1/1/3000#)) AS Kil�p�s
FROM (lkSzem�lyek INNER JOIN (tSzervezeti INNER JOIN tNexonAzonos�t�k ON tSzervezeti.[Szervezetmenedzsment k�d] = tNexonAzonos�t�k.[Ad�azonos�t� jel]) ON lkSzem�lyek.[Ad�azonos�t� jel] = tSzervezeti.[Szervezetmenedzsment k�d]) INNER JOIN tSzervezetiUtols�Bet�lt�sekTmp ON (tSzervezetiUtols�Bet�lt�sekTmp.[Szervezetmenedzsment k�d] = tSzervezeti.[Szervezetmenedzsment k�d]) AND (tSzervezeti.[�rv�nyess�g v�ge] = tSzervezetiUtols�Bet�lt�sekTmp.Maxv�g)
WHERE (((tSzervezeti.Els�dleges)="nem") AND ((dt�tal(N�([Jogviszony v�ge (kil�p�s d�tuma)],#1/1/3000#)))<dt�tal(Date())) AND ((tSzervezeti.OSZLOPOK)="St�tusz bet�lt�s"));

-- [lkSzervezetiVezet�kList�ja01]
SELECT lkSzem�lyek.BFKH AS [BFKH k�d], lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[KIRA feladat megnevez�s], tSzervezet.[Szervezeti egys�g vezet�je], lkSzem�lyek.[Besorol�si  fokozat (KT)] AS Besorol�sa, lkSzem�lyek.[Hivatali email], lkSzem�lyek.[Hivatali mobil], lkSzem�lyek.[Hivatali telefon], lkSzem�lyek.[Hivatali telefon mell�k], tTelefonkonyv.[K�ls� vezet�kes telefonsz�m], tTelefonkonyv.[Bels� vezet�kes telefonsz�m], tTelefonkonyv.Mobiltelefonsz�m, tTelefonkonyv.[K�ls� fax sz�m], tTelefonkonyv.[Bels� fax sz�m], tTelefonkonyv.[Levelez�si c�m], tTelefonkonyv.Emelet, tTelefonkonyv.Szobasz�m, tTelefonkonyv.V�ros, tTelefonkonyv.Ir�ny�t�sz�m, tTelefonkonyv.Telep�l�s, tTelefonkonyv.Utca, tTelefonkonyv.�p�let, lkSzem�lyek.[Munkav�gz�s helye - c�m]
FROM (tSzervezet INNER JOIN lkSzem�lyek ON tSzervezet.[Szervezeti egys�g vezet�j�nek azonos�t�ja] = lkSzem�lyek.[Ad�azonos�t� jel]) LEFT JOIN tTelefonkonyv ON lkSzem�lyek.[Hivatali email] = tTelefonkonyv.[E-mail c�m]
ORDER BY bfkh([Szervezetmenedzsment k�d]);

-- [lkSzervezetiVezet�kList�ja02]
SELECT lkSzervezetiVezet�kList�ja01.[BFKH k�d], lkSzervezetiVezet�kList�ja01.N�v, lkSzervezetiVezet�kList�ja01.[KIRA feladat megnevez�s] AS Feladat, lkSzervezetiVezet�kList�ja01.[Szervezeti egys�g vezet�je], lkSzervezetiVezet�kList�ja01.Besorol�sa, lkSzervezetiVezet�kList�ja01.[Hivatali email], N�(telefonsz�mjav�t�([lkSzervezetiVezet�kList�ja01]![Hivatali telefon]),telefonsz�mjav�t�([K�ls� vezet�kes telefonsz�m])) AS HivataliVezet�kes, telefonsz�mjav�t�([Hivatali mobil]) AS HivataliMobil, lkSzervezetiVezet�kList�ja01.[Munkav�gz�s helye - c�m]
FROM lkSzervezetiVezet�kList�ja01;

-- [lkSzervezetSzem�lyek]
SELECT tSzervezet.*, [Szervezetmenedzsment k�d]*1 AS Ad�jel
FROM tSzervezet
WHERE (((tSzervezet.OSZLOPOK)="St�tusz bet�lt�s"));

-- [lkSz�k�z�ket_tartalmaz�_szervek]
SELECT *
FROM (SELECT DISTINCT tSzem�lyek.[Szint 1 szervezeti egys�g n�v] AS SzervN�v, [Szervezeti egys�g k�dja] As K�d FROM tSzem�lyek UNION SELECT DISTINCT  tSzem�lyek.[Szint 2 szervezeti egys�g n�v], [Szervezeti egys�g k�dja] FROM tSzem�lyek UNION SELECT DISTINCT  tSzem�lyek.[Szint 3 szervezeti egys�g n�v], [Szervezeti egys�g k�dja] FROM tSzem�lyek UNION SELECT DISTINCT  tSzem�lyek.[Szint 4 szervezeti egys�g n�v], [Szervezeti egys�g k�dja] FROM tSzem�lyek UNION SELECT DISTINCT  tSzem�lyek.[Szint 5 szervezeti egys�g n�v], [Szervezeti egys�g k�dja] FROM tSzem�lyek UNION SELECT DISTINCT  tSzem�lyek.[Szint 6 szervezeti egys�g n�v], [Szervezeti egys�g k�dja] FROM tSzem�lyek UNION SELECT DISTINCT  tSzem�lyek.[Szint 7 szervezeti egys�g n�v], [Szervezeti egys�g k�dja] FROM tSzem�lyek UNION SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.[Szervezeti egys�g k�dja] FROM lkSzem�lyek UNION SELECT lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Szervezeti egys�g k�dja] FROM lkSzem�lyek   )  AS SzervezetUni�
WHERE (((SzervezetUni�.szervn�v) Like "*  *")) Or (((SzervezetUni�.szervn�v) Like "*   *")) Or (((SzervezetUni�.szervn�v) Like "*    *"));

-- [lkSzolg�latiId�Elismer�s]
SELECT tSzolg�latiId�Elsimer�s.[Szolg�lati elismer�sre jogosults�g / Jubileumi jutalom kezd� d�t] AS SzolgIdKezd, bfkh(Nz([Szervezeti egys�g k�d],0)) AS Kif1, [Azonos�t�]*1 AS Ad�jel, tSzolg�latiId�Elsimer�s.*
FROM tSzolg�latiId�Elsimer�s
WHERE (((tSzolg�latiId�Elsimer�s.Azonos�t�)<>"" Or (tSzolg�latiId�Elsimer�s.Azonos�t�) Is Not Null))
ORDER BY bfkh(Nz([Szervezeti egys�g k�d],0));

-- [lkSzolg�latiId�Elsimer�s]
SELECT tSzolg�latiId�Elsimer�s.[Szolg�lati elismer�sre jogosults�g / Jubileumi jutalom kezd� d�t] AS SzolgIdKezd, bfkh(Nz([Szervezeti egys�g k�d],0)) AS Kif1, [Azonos�t�]*1 AS Ad�jel, tSzolg�latiId�Elsimer�s.*
FROM tSzolg�latiId�Elsimer�s
WHERE ((([tSzolg�latiId�Elsimer�s].[Azonos�t�])<>"" Or ([tSzolg�latiId�Elsimer�s].[Azonos�t�]) Is Not Null))
ORDER BY bfkh(Nz([Szervezeti egys�g k�d],0));

-- [lksz�let�si�v�sNem]
SELECT lkSzem�lyek.Ad�jel, Year([Sz�let�si id�]) AS [Sz�l �v], IIf([Neme]="F�rfi",1,2) AS Nem
FROM lkSzem�lyek;

-- [lkT�blanevek]
SELECT MSysObjects.Name, MSysObjects.Flags
FROM MSysObjects
WHERE (((MSysObjects.Type)=1) AND ((MSysObjects.Flags)=0)) OR (((MSysObjects.Type)=5))
ORDER BY MSysObjects.Type, MSysObjects.Name;

-- [lkTart�san�res�ll�shelyek]
SELECT lk�res�ll�shelyekNemVezet�.[F�oszt�ly\Hivatal], lk�res�ll�shelyekNemVezet�.[Meg�resed�st�l eltelt h�napok], lk�res�ll�shelyek�llapotfelm�r�.[Legut�bbi �llapot], lk�res�ll�shelyek�llapotfelm�r�.[Legut�bbi �llapot ideje]
FROM lk�res�ll�shelyekNemVezet� INNER JOIN lk�res�ll�shelyek�llapotfelm�r� ON lk�res�ll�shelyekNemVezet�.[�ll�shely azonos�t�] = lk�res�ll�shelyek�llapotfelm�r�.[�ll�shely azonos�t�]
WHERE (((lk�res�ll�shelyekNemVezet�.[Meg�resed�st�l eltelt h�napok])=5 Or (lk�res�ll�shelyekNemVezet�.[Meg�resed�st�l eltelt h�napok])=4) AND ((lk�res�ll�shelyekNemVezet�.Jelleg)="A"))
ORDER BY lk�res�ll�shelyekNemVezet�.[Meg�resed�st�l eltelt h�napok] DESC , lk�res�ll�shelyek�llapotfelm�r�.[Legut�bbi �llapot ideje];

-- [lkTart�sT�voll�tElt�r�s�nyrNexon]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[St�tusz k�dja], lkSzem�lyek.[Tart�s t�voll�t t�pusa] AS Nexon, lk�ll�shelyek.[�ll�shely st�tusza] AS �nyr, kt_azNexon_Ad�jel02.NLink
FROM kt_azNexon_Ad�jel02 RIGHT JOIN (lkSzem�lyek LEFT JOIN lk�ll�shelyek ON lkSzem�lyek.[St�tusz k�dja] = lk�ll�shelyek.[�ll�shely azonos�t�]) ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null) AND ((lk�ll�shelyek.[�ll�shely st�tusza]) Not Like "*bet�lt�tt*" And (lk�ll�shelyek.[�ll�shely st�tusza])<>"bet�ltetlen") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Not Null And (lkSzem�lyek.[Tart�s t�voll�t t�pusa])<>"CSED" And (lkSzem�lyek.[Tart�s t�voll�t t�pusa])<>"Mentes�t�s felment�si / felmond�si id�n bel�l" And (lkSzem�lyek.[Tart�s t�voll�t t�pusa])<>"Mentes�t�s munk�ltat� enged�lye alapj�n") AND ((lk�ll�shelyek.[�ll�shely st�tusza]) Not Like "*tart�s*") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.BFKH;

-- [lkTart�sT�voll�t�sBet�lt�sT�pusElt�r�s]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[Tart�s t�voll�t t�pusa] AS [TT t�pus], lkSzem�lyek.[Tart�s t�voll�t v�ge] AS [TT v�ge], lkSzem�lyek.[Tart�s t�voll�t tervezett v�ge] AS [TT tervezett v�ge], lkSzervezetiBet�lt�sek.[St�tuszbet�lt�s t�pusa], kt_azNexon_Ad�jel02.NLink
FROM kt_azNexon_Ad�jel02 INNER JOIN (lkSzem�lyek INNER JOIN lkSzervezetiBet�lt�sek ON lkSzem�lyek.[Ad�azonos�t� jel] = lkSzervezetiBet�lt�sek.[Szervezetmenedzsment k�d]) ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[Tart�s t�voll�t t�pusa])<>"Mentes�t�s felment�si / felmond�si id�n bel�l" Or (lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null) AND ((lkSzervezetiBet�lt�sek.[St�tuszbet�lt�s t�pusa])="Felment�s alatt")) OR (((lkSzem�lyek.[Tart�s t�voll�t v�ge])<Date() Or (lkSzem�lyek.[Tart�s t�voll�t v�ge]) Is Null) AND ((lkSzem�lyek.[Tart�s t�voll�t tervezett v�ge])<Date() Or (lkSzem�lyek.[Tart�s t�voll�t tervezett v�ge]) Is Null) AND ((lkSzervezetiBet�lt�sek.[St�tuszbet�lt�s t�pusa])="Inakt�v")) OR (((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Null) AND ((lkSzervezetiBet�lt�sek.[St�tuszbet�lt�s t�pusa])="Inakt�v")) OR (((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Not Null And (lkSzem�lyek.[Tart�s t�voll�t t�pusa])<>"Mentes�t�s munk�ltat� enged�lye alapj�n (szabads�gra nem jogos�t�)") AND ((lkSzervezetiBet�lt�sek.[St�tuszbet�lt�s t�pusa])="�ltal�nos"))
ORDER BY lkSzem�lyek.BFKH, lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkTart�sT�voll�v�kAdott�vben]
SELECT lkSzem�lyek.[Szint 3 szervezeti egys�g n�v], lkSzem�lyek.[Szint 4 szervezeti egys�g n�v], lkSzem�lyek.[Szint 5 szervezeti egys�g n�v], lkSzem�lyek.[Tart�s t�voll�t kezdete], lkSzem�lyek.[Tart�s t�voll�t v�ge], lkSzem�lyek.[Tart�s t�voll�t tervezett v�ge]
FROM lkSzem�lyek
WHERE (((Year(dt�tal(2022))) Between Year(dt�tal([tart�s t�voll�t kezdete])) And IIf(Nz([tart�s t�voll�t v�ge],"")="",IIf(Nz([tart�s t�voll�t tervezett v�ge],"")="",Year(dt�tal(3000)),Year(dt�tal([tart�s t�voll�t tervezett v�ge]))),Year(dt�tal([tart�s t�voll�t v�ge])))) AND ((Nz([Tart�s t�voll�t kezdete],""))<>""))
ORDER BY lkSzem�lyek.[Szint 4 szervezeti egys�g n�v];

-- [lkTelefonsz�mMint�k]
SELECT lkSzem�lyek.[Hivatali telefon], felt�lt�(lkSzem�lyek.[Hivatali telefon]) AS Tel
FROM lkSzem�lyek
WHERE lkSzem�lyek.[Hivatali telefon] Is Not Null
UNION SELECT lkSzem�lyek.[Hivatali mobil],felt�lt�(lkSzem�lyek.[Hivatali mobil])
FROM lkSzem�lyek
WHERE lkSzem�lyek.[Hivatali mobil] Is Not Null and
"UNION
SELECT lkSzem�lyek.[Otthoni mobil],felt�lt�(lkSzem�lyek.[Otthoni mobil])
FROM lkSzem�lyek
WHERE lkSzem�lyek.[Otthoni mobil] Is Not Null
UNION
SELECT lkSzem�lyek.[Otthoni telefon],felt�lt�(lkSzem�lyek.[Otthoni telefon])
FROM lkSzem�lyek
WHERE lkSzem�lyek.[Otthoni telefon] Is Not Null
UNION
SELECT lkSzem�lyek.[Tov�bbi otthoni mobil],Felt�lt�(lkSzem�lyek.[Tov�bbi otthoni mobil])
FROM lkSzem�lyek
WHERE lkSzem�lyek.[Tov�bbi otthoni mobil] Is Not Null";

-- [lkTelephelyC�mek]
SELECT DISTINCT lkTelephelyek.Sorsz�m, lkTelephelyek.C�m_Szem�lyek
FROM lkTelephelyek;

-- [lkTelephelyC�mEllen�rz�s]
SELECT lkSzervezetiEgys�gekLegnagyobbL�tsz�m�Telephelyei.F�oszt�ly, lkSzervezetiEgys�gekLegnagyobbL�tsz�m�Telephelyei.Oszt�ly, Replace(Nz([C�m],"")," .",".") AS [Szervezet c�me], lkSzem�lyek.Munkav�gz�sC�me, kt_azNexon_Ad�jel02.NLink
FROM kt_azNexon_Ad�jel02 INNER JOIN (lkSzervezetiEgys�gekLegnagyobbL�tsz�m�Telephelyei INNER JOIN lkSzem�lyek ON lkSzervezetiEgys�gekLegnagyobbL�tsz�m�Telephelyei.BFKH = lkSzem�lyek.BFKH) ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((Replace(Nz([C�m],"")," .","."))<>"") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND (([Munkav�gz�sC�me]=Replace(Nz([lkSzervezetiEgys�gekLegnagyobbL�tsz�m�Telephelyei].[C�m],"")," .","."))=False))
ORDER BY lkSzervezetiEgys�gekLegnagyobbL�tsz�m�Telephelyei.F�oszt�ly;

-- [lkTelephelyEgyMegadottF�oszt�lyra]
SELECT lkSzem�lyek.Munkav�gz�sC�me, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, kt_azNexon_Ad�jel.NLink
FROM kt_azNexon_Ad�jel INNER JOIN lkSzem�lyek ON kt_azNexon_Ad�jel.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.F�oszt�ly) Like "*" & [A keresend� f�oszt�ly neve, vagy a nev�nek a r�szlete:] & "*"))
ORDER BY lkSzem�lyek.Munkav�gz�sC�me;

-- [lkTelephelyek]
SELECT tTelephelyek230301.Sorsz�m, tTelephelyek230301.Irsz, tTelephelyek230301.V�ros, tTelephelyek230301.C�m, tTelephelyek230301.Tulajdonos, tTelephelyek230301.�zemeltet�, IIf(Nz([Nexon c�m],"")="",([Irsz] & " " & [V�ros] & ", " & IIf(Left([Irsz],1)=1,num2num(Mid([Irsz],2,2),10,99) & ". ker�let, ","") & [C�m]),[Nexon c�m]) AS C�m_Szem�lyek, tTelephelyek230301.[Nexon c�m]
FROM tTelephelyek230301;

-- [lkTelephelyekC�mN�lk�l]
SELECT DISTINCT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Munkav�gz�s helye - megnevez�s], lkSzem�lyek.[Munkav�gz�s helye - c�m], Count(lkSzem�lyek.Ad�jel) AS CountOfAd�jel
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Munkav�gz�s helye - c�m]) Is Null)) OR (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((Len([Munkav�gz�s helye - c�m]))<3))
GROUP BY lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Munkav�gz�s helye - megnevez�s], lkSzem�lyek.[Munkav�gz�s helye - c�m];

-- [lkTelephelyekenDolgoz�k]
SELECT lkSzem�lyTelephelyek.[Szervezeti egys�g k�dja], lkSzem�lyTelephelyek.F�oszt�ly, lkSzem�lyTelephelyek.Oszt�ly, lkTelephelyek.Sorsz�m, lkSzem�lyTelephelyek.[Dolgoz� teljes neve], lkTelephelyek.Irsz, lkTelephelyek.V�ros, lkTelephelyek.C�m, lkTelephelyek.Tulajdonos, lkTelephelyek.�zemeltet�, 1 AS L�tsz�m
FROM lkTelephelyek RIGHT JOIN lkSzem�lyTelephelyek ON lkTelephelyek.C�m_Szem�lyek=lkSzem�lyTelephelyek.TelephelyC�me
ORDER BY bfkh([Szervezeti egys�g k�dja]);

-- [lkTelephelyekL�tsz�ma]
SELECT lkSzem�lyek.BFKH, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, IIf(Len([Munkav�gz�s helye - c�m])<2,[Munkav�gz�s helye - megnevez�s],[Munkav�gz�s helye - c�m]) AS C�m, Count(lkSzem�lyek.Ad�jel) AS L�tsz�m
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
GROUP BY lkSzem�lyek.BFKH, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, IIf(Len([Munkav�gz�s helye - c�m])<2,[Munkav�gz�s helye - megnevez�s],[Munkav�gz�s helye - c�m]);

-- [lkTelephelyenk�ntiL�tsz�m2]
SELECT lkSzem�lyek.[Munkav�gz�s helye - megnevez�s], lkSzem�lyek.[Munkav�gz�s helye - c�m], Count(lkSzem�lyek.Azonos�t�) AS [L�tsz�m (f�)]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)])>Date()-1 Or (lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)]) Is Null Or (lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)])=0))
GROUP BY lkSzem�lyek.[Munkav�gz�s helye - megnevez�s], lkSzem�lyek.[Munkav�gz�s helye - c�m]
ORDER BY Count(lkSzem�lyek.Azonos�t�) DESC;

-- [lkTelephelyenk�ntiL�tsz�mSzervezetenk�nt]
SELECT lkSzem�lyTelephelyek.[Munkav�gz�s helye - c�m] AS Telephely, lkSzem�lyTelephelyek.F�oszt�ly, Count(lkSzem�lyTelephelyek.ad�jel) AS L�tsz�m
FROM lkSzem�lyTelephelyek
GROUP BY lkSzem�lyTelephelyek.[Munkav�gz�s helye - c�m], lkSzem�lyTelephelyek.F�oszt�ly;

-- [lkTelephelyenk�ntiOszt�lyonk�ntiL�tsz�m]
SELECT lkSzem�lyek.BFKH, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.Munkav�gz�sC�me, Count(lkSzem�lyek.Ad�jel) AS L�tsz�m
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.Munkav�gz�sC�me) Is Not Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
GROUP BY lkSzem�lyek.BFKH, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.Munkav�gz�sC�me
ORDER BY lkSzem�lyek.BFKH, Count(lkSzem�lyek.Ad�jel) DESC;

-- [lktJ�r�si_�llom�ny]
SELECT tJ�r�si_�llom�ny.Sorsz�m, tJ�r�si_�llom�ny.N�v, tJ�r�si_�llom�ny.Ad�azonos�t�, tJ�r�si_�llom�ny.Mez�4 AS [Sz�let�si �v \ �res �ll�s], tJ�r�si_�llom�ny.Mez�5 AS Neme, Replace([J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH") AS [J�r�si Hivatal_], tJ�r�si_�llom�ny.Mez�7 AS Oszt�ly, tJ�r�si_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�], tJ�r�si_�llom�ny.Mez�9 AS [Ell�tott feladat], tJ�r�si_�llom�ny.Mez�10 AS Kinevez�s, tJ�r�si_�llom�ny.[Feladat jellege: szakmai (SZ) / funkcion�lis (F) feladatell�t�s;], tJ�r�si_�llom�ny.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ], tJ�r�si_�llom�ny.[Heti munka�r�k sz�ma], tJ�r�si_�llom�ny.Mez�14 AS [Bet�lt�s ar�nya], tJ�r�si_�llom�ny.[Besorol�si fokozat k�d:], tJ�r�si_�llom�ny.[Besorol�si fokozat megnevez�se:], tJ�r�si_�llom�ny.[�ll�shely azonos�t�], tJ�r�si_�llom�ny.Mez�18 AS [Havi illetm�ny], tJ�r�si_�llom�ny.Mez�19 AS [Eu finansz�rozott], tJ�r�si_�llom�ny.Mez�20 AS [Illetm�ny forr�sa], tJ�r�si_�llom�ny.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h], tJ�r�si_�llom�ny.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], tJ�r�si_�llom�ny.[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)], tJ�r�si_�llom�ny.[Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is], tJ�r�si_�llom�ny.[�gyf�lszolg�lati munkat�rs (1) �gyf�lszolg�lati h�tt�r munkat�rs], tJ�r�si_�llom�ny.Mez�26 AS [K�pes�t�st ad� v�gzetts�g], tJ�r�si_�llom�ny.Mez�27 AS KAB, tJ�r�si_�llom�ny.[KAB 001-3** Branch ID], tJ�r�si_�llom�ny.hat�lyaID, tJ�r�si_�llom�ny.azJ�r�siSor
FROM tJ�r�si_�llom�ny;

-- [lktKorm�nyhivatali_�llom�ny]
SELECT tKorm�nyhivatali_�llom�ny.Sorsz�m, tKorm�nyhivatali_�llom�ny.N�v, tKorm�nyhivatali_�llom�ny.Ad�azonos�t�, tKorm�nyhivatali_�llom�ny.Mez�4 AS [Sz�let�si �v \ �res �ll�s], tKorm�nyhivatali_�llom�ny.Mez�5 AS Neme, tKorm�nyhivatali_�llom�ny.Mez�6 AS F�oszt�ly, tKorm�nyhivatali_�llom�ny.Mez�7 AS Oszt�ly, tKorm�nyhivatali_�llom�ny.[�NYR SZERVEZETI EGYS�G AZONOS�T�], tKorm�nyhivatali_�llom�ny.Mez�9 AS [Ell�tott feladat], tKorm�nyhivatali_�llom�ny.Mez�10 AS Kinevez�s, tKorm�nyhivatali_�llom�ny.[Feladat jellege: szakmai (SZ) / funkcion�lis (F) feladatell�t�s;], tKorm�nyhivatali_�llom�ny.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ], tKorm�nyhivatali_�llom�ny.[Heti munka�r�k sz�ma], tKorm�nyhivatali_�llom�ny.Mez�14 AS [Bet�lt�s ar�nya], tKorm�nyhivatali_�llom�ny.[Besorol�si fokozat k�d:], tKorm�nyhivatali_�llom�ny.[Besorol�si fokozat megnevez�se:], tKorm�nyhivatali_�llom�ny.[�ll�shely azonos�t�], tKorm�nyhivatali_�llom�ny.Mez�18 AS [Havi illetm�ny], tKorm�nyhivatali_�llom�ny.Mez�19 AS [Eu finansz�rozott], tKorm�nyhivatali_�llom�ny.Mez�20 AS [Illetm�ny forr�sa], tKorm�nyhivatali_�llom�ny.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h], tKorm�nyhivatali_�llom�ny.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], tKorm�nyhivatali_�llom�ny.[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)], tKorm�nyhivatali_�llom�ny.[Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is], tKorm�nyhivatali_�llom�ny.[�gyf�lszolg�lati munkat�rs (1) �gyf�lszolg�lati h�tt�r munkat�rs], tKorm�nyhivatali_�llom�ny.Mez�26 AS [K�pes�t�st ad� v�gzetts�g], tKorm�nyhivatali_�llom�ny.Mez�27 AS KAB, tKorm�nyhivatali_�llom�ny.[KAB 001-3** Branch ID], tKorm�nyhivatali_�llom�ny.hat�lyaID, tKorm�nyhivatali_�llom�ny.azKorm�nyhivataliSor
FROM tKorm�nyhivatali_�llom�ny;

-- [lktKorm�nyhivataliRekordokSz�ma]
SELECT lktKorm�nyhivatali_�llom�ny.hat�lyaID, tHaviJelent�sHat�lya1.hat�lya, Count(lktKorm�nyhivatali_�llom�ny.[�ll�shely azonos�t�]) AS [CountOf�ll�shely azonos�t�]
FROM lktKorm�nyhivatali_�llom�ny INNER JOIN tHaviJelent�sHat�lya1 ON lktKorm�nyhivatali_�llom�ny.hat�lyaID = tHaviJelent�sHat�lya1.hat�lyaID
GROUP BY lktKorm�nyhivatali_�llom�ny.hat�lyaID, tHaviJelent�sHat�lya1.hat�lya
ORDER BY tHaviJelent�sHat�lya1.hat�lya;

-- [lktK�zpontos�tottak]
SELECT tK�zpontos�tottak.Sorsz�m, tK�zpontos�tottak.N�v, tK�zpontos�tottak.Ad�azonos�t�, tK�zpontos�tottak.Mez�4 AS [Sz�let�si �v \ �res �ll�s], "" AS Nem, Replace(IIf([Megyei szint VAGY J�r�si Hivatal]="Megyei szint",[tK�zpontos�tottak].[Mez�6],[Megyei szint VAGY J�r�si Hivatal]),"Budapest F�v�ros Korm�nyhivatala ","BFKH ") AS F�oszt, tK�zpontos�tottak.Mez�7 AS Oszt�ly, tK�zpontos�tottak.[Nexon sz�t�relemnek megfelel� szervezeti egys�g azonos�t�] AS [�NYR SZERVEZETI EGYS�G AZONOS�T�], tK�zpontos�tottak.Mez�10 AS [Ell�tott feladat], tK�zpontos�tottak.Mez�11 AS Kinevez�s, "SZ" AS [Feladat jellege], tK�zpontos�tottak.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ], 0 AS [Heti munka�r�k sz�ma], 1 AS [Bet�lt�s ar�nya], tK�zpontos�tottak.[Besorol�si fokozat k�d:], tK�zpontos�tottak.[Besorol�si fokozat megnevez�se:], tK�zpontos�tottak.[�ll�shely azonos�t�], tK�zpontos�tottak.Mez�17 AS [Havi illetm�ny], "" AS [Eu finansz�rozott], "" AS [Illetm�ny forr�sa], "" AS [Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h], tK�zpontos�tottak.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], tK�zpontos�tottak.[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)], tK�zpontos�tottak.[Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is], "" AS [�gyf�lszolg�lati munkat�rs (1) �gyf�lszolg�lati h�tt�r munkat�rs], "" AS [K�pes�t�st ad� v�gzetts�g], "" AS KAB, "" AS [KAB 001-3** Branch ID], tK�zpontos�tottak.hat�lyaID, tK�zpontos�tottak.azK�zpontos�tottakSor
FROM tK�zpontos�tottak;

-- [lktKSZDR - azonosak keres�se]
SELECT First(tKSZDR.[Ad�azonos�t� jel]) AS [Ad�azonos�t� jel Mez�], Count(tKSZDR.[Ad�azonos�t� jel]) AS AzonosakSz�ma
FROM tKSZDR
GROUP BY tKSZDR.[Ad�azonos�t� jel]
HAVING (((Count(tKSZDR.[Ad�azonos�t� jel]))>1));

-- [lkTmpEgyesMunkak�r�kF�oszt�lyaiL�tsz�m]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, Count(lkSzem�lyek.Ad�jel) AS L�tsz�m
FROM tTmpEgyesMunkak�r�kF�oszt�lyai INNER JOIN lkSzem�lyek ON tTmpEgyesMunkak�r�kF�oszt�lyai.F�oszt�ly = lkSzem�lyek.F�oszt�lyK�d
WHERE (((lkSzem�lyek.[KIRA feladat megnevez�s]) Not Like "*titk�rs�gi*") AND ((tTmpEgyesMunkak�r�kF�oszt�lyai.F�oszt�ly)=[lkSzem�lyek].[F�oszt�lyk�d]) AND ((lkSzem�lyek.Oszt�ly) Like [tTmpEgyesMunkak�r�kF�oszt�lyai].[Oszt�ly]))
GROUP BY lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly;

-- [lkTMPIlletm�nyMi�ta01]
SELECT lkSzem�lyekAdottNapon.BFKH, tmpR�gi�sJelenlegiIlletm�ny.Ad�azonos�t�, lkSzem�lyekAdottNapon.[Dolgoz� teljes neve] AS N�v, lkSzem�lyekAdottNapon.[KIRA feladat megnevez�s] AS Munkak�r, lkSzem�lyekAdottNapon.F�oszt�ly, lkSzem�lyekAdottNapon.Oszt�ly, lkLegkor�bbiKinevez�s.[Els� bel�p�se], tmpR�gi�sJelenlegiIlletm�ny.Jelenlegi40�r�s AS Illetm�nye, Max(tHaviJelent�sHat�lya1.hat�lya) AS MaxOfhat�lya
FROM tHaviJelent�sHat�lya1 INNER JOIN ((lkLegkor�bbiKinevez�s INNER JOIN tmpR�gi�sJelenlegiIlletm�ny ON lkLegkor�bbiKinevez�s.[Ad�azonos�t� jel] = tmpR�gi�sJelenlegiIlletm�ny.Ad�azonos�t�) INNER JOIN lkSzem�lyekAdottNapon ON tmpR�gi�sJelenlegiIlletm�ny.Ad�azonos�t� = lkSzem�lyekAdottNapon.[Ad�azonos�t� jel]) ON tHaviJelent�sHat�lya1.hat�lyaID = tmpR�gi�sJelenlegiIlletm�ny.hat�lyaID
WHERE ((([Jelenlegi40�r�s]=[R�gi40�r�s])=0)) Or (((DateSerial(Year(lkLegkor�bbiKinevez�s.[Els� bel�p�se]),Month(lkLegkor�bbiKinevez�s.[Els� bel�p�se]),1)=DateSerial(Year([hat�lya]),Month([hat�lya]),1))<>0))
GROUP BY lkSzem�lyekAdottNapon.BFKH, tmpR�gi�sJelenlegiIlletm�ny.Ad�azonos�t�, lkSzem�lyekAdottNapon.[Dolgoz� teljes neve], lkSzem�lyekAdottNapon.[KIRA feladat megnevez�s], lkSzem�lyekAdottNapon.F�oszt�ly, lkSzem�lyekAdottNapon.Oszt�ly, lkLegkor�bbiKinevez�s.[Els� bel�p�se], tmpR�gi�sJelenlegiIlletm�ny.Jelenlegi40�r�s
ORDER BY lkSzem�lyekAdottNapon.BFKH, tmpR�gi�sJelenlegiIlletm�ny.Ad�azonos�t�, Max(tHaviJelent�sHat�lya1.hat�lya) DESC;

-- [lkTMPIlletm�nyMi�ta02]
SELECT lkTMPIlletm�nyMi�ta01.BFKH, lkTMPIlletm�nyMi�ta01.Ad�azonos�t�, lkTMPIlletm�nyMi�ta01.N�v, lkTMPIlletm�nyMi�ta01.Munkak�r, lkTMPIlletm�nyMi�ta01.F�oszt�ly, lkTMPIlletm�nyMi�ta01.Oszt�ly, lkTMPIlletm�nyMi�ta01.[Els� bel�p�se], lkTMPIlletm�nyMi�ta01.Illetm�nye, DateSerial(Year([MaxOfhat�lya]),Month([MaxOfhat�lya])+IIf([lkTMPIlletm�nyMi�ta01].[Els� bel�p�se]=[lkTMPIlletm�nyMi�ta01].[MaxOfhat�lya],0,1),1) AS [Mi�ta kapja]
FROM lkTMPIlletm�nyMi�ta01;

-- [lktNFSZSzervezetek]
SELECT *
FROM (SELECT TOP 1 "BFKH.01.02.03" AS BFKH FROM tszem�lyek UNION
   SELECT TOP 1 "BFKH.01.02.04" AS BFKH FROM tszem�lyek UNION
   SELECT TOP 1 "BFKH.01.02.08" AS BFKH FROM tszem�lyek UNION
   SELECT TOP 1 "BFKH.01.02.09" AS BFKH FROM tszem�lyek UNION
   SELECT TOP 1 "BFKH.01.02.09" AS BFKH FROM tszem�lyek UNION
   SELECT TOP 1 "BFKH.01.02.10" AS BFKH FROM tszem�lyek UNION
   SELECT TOP 1 "BFKH.01.02.13" AS BFKH FROM tszem�lyek UNION
   SELECT TOP 1 "BFKH.01.02.18" AS BFKH FROM tszem�lyek UNION
   SELECT TOP 1 "BFKH.01.02.20" AS BFKH FROM tszem�lyek UNION
   SELECT TOP 1 "BFKH.01.02.21" AS BFKH FROM tszem�lyek UNION
   SELECT TOP 1 "BFKH.01.16" AS BFKH FROM tszem�lyek UNION
   SELECT TOP 1 "BFKH.01.16" AS BFKH FROM tszem�lyek UNION
   SELECT TOP 1 "BFKH.01.17" AS BFKH FROM tszem�lyek UNION
   SELECT TOP 1 "BFKH.01.17" AS BFKH FROM tszem�lyek 
)  AS SzervezetiEgys�gek;

-- [lkTov�bbfoglalkoztatottak]
SELECT lkSzem�lyek.Ad�jel, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Szerz�d�s/kinevez�s verzi�_�rv�nyess�g v�ge], lkSzem�lyek.[Hat�rozott idej� _szerz�d�s/kinevez�s lej�r], lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja], lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)], lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek oka: jogszab�lyi hiva], lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus], lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.[KIRA feladat megnevez�s], lkSzem�lyek.Feladatk�r
FROM lkKil�p�Uni� INNER JOIN lkSzem�lyek ON lkKil�p�Uni�.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])<[Jogviszony kezdete (bel�p�s d�tuma)]) AND ((lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek oka: jogszab�lyi hiva])="A korm�nytisztvisel� k�relm�re a t�rsadalombiztos�t�si nyugell�t�sr�l sz�l� 1997. �vi LXXXI. tv. 18. � (2a) bekezd�s�ben foglalt felt�tel fenn�ll�sa miatt [Kit. 107. � (2) bek. e) pont, 105. � (1) bekezd�s c]") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])<[Jogviszony kezdete (bel�p�s d�tuma)]) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((lkSzem�lyek.[Sz�let�si id�])<#5/17/1959#))
ORDER BY lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkT�rv�nyess�giFel�gyeleti�ll�shely]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus], ffsplit([Els�dleges feladatk�r],"-",2) AS Feladatk�r, lkSzem�lyek.[St�tusz k�dja], lkSzem�lyek.[Besorol�si  fokozat (KT)]
FROM lkSzem�lyek INNER JOIN tTmp ON lkSzem�lyek.[St�tusz k�dja] = tTmp.F1;

-- [lkT�rzssz�m_Szervezeti_egys�g]
SELECT [T�rzssz�m]*1 AS T�rzssz�m_, lkF�oszt�lyok.F�oszt�ly, lkSzem�lyek.[Szint 5 szervezeti egys�g n�v] AS Oszt�ly, Max(lkSzem�lyek.[Jogviszony sorsz�ma]) AS [MaxOfJogviszony sorsz�ma]
FROM lkSzem�lyek INNER JOIN lkF�oszt�lyok ON lkSzem�lyek.[Szervezeti egys�g k�dja] = lkF�oszt�lyok.[Szervezeti egys�g k�dja]
GROUP BY [T�rzssz�m]*1, lkF�oszt�lyok.F�oszt�ly, lkSzem�lyek.[Szint 5 szervezeti egys�g n�v];

-- [lkTT21_22_23]
SELECT TT21_22_23.F�oszt�ly, TT21_22_23.Oszt�ly, Sum(TT21_22_23.TTL�tsz�m2021) AS SumOfTTL�tsz�m2021, Sum(TT21_22_23.TTL�tsz�m2022) AS SumOfTTL�tsz�m2022, Sum(TT21_22_23.TTL�tsz�m2023) AS SumOfTTL�tsz�m2023, Sum(TT21_22_23.L�tsz�m2023) AS SumOfL�tsz�m2023
FROM (SELECT lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2021.F�oszt�ly, lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2021.Oszt�ly, lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2021.TTL�tsz�m2021, lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2021.TTL�tsz�m2022, lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2021.TTL�tsz�m2023, 0 as L�tsz�m2023
FROM lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2021
UNION
SELECT
lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2022.F�oszt�ly, lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2022.Oszt�ly, lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2022.TTL�tsz�m2021, lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2022.TTL�tsz�m2022, lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2022.TTL�tsz�m2023, 0 as L�tsz�m2023
FROM lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2022
UNION
SELECT lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2023.F�oszt�ly, lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2023.Oszt�ly, lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2023.TTL�tsz�m2021, lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2023.TTL�tsz�m2022, lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2023.TTL�tsz�m2023, 0 as L�tsz�m2023
FROM lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2023
UNION
SELECT lkL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt20230101.F�oszt�ly, lkL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt20230101.Oszt�ly, lkL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt20230101.TTL�tsz�m2021, lkL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt20230101.TTL�tsz�m2022, 0 as TTL�tsz�m2023, SumOfL�tsz�m2023
FROM lkL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt20230101)  AS TT21_22_23
GROUP BY TT21_22_23.F�oszt�ly, TT21_22_23.Oszt�ly;

-- [lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2021]
SELECT Replace(Nz(IIf(IsNull([tSzem�lyek20210101].[Szint 4 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek20210101].[Szint 3 szervezeti egys�g n�v]),[tSzem�lyek20210101].[Szint 2 szervezeti egys�g n�v] & "",[tSzem�lyek20210101].[Szint 3 szervezeti egys�g n�v] & ""),[tSzem�lyek20210101].[Szint 4 szervezeti egys�g n�v] & ""),""),"Budapest F�v�ros Korm�nyhivatala ","BFKH ") & "" AS F�oszt�ly, [Szint 5 szervezeti egys�g n�v] & "" AS Oszt�ly, Sum(IIf(Nz([Tart�s t�voll�t t�pusa],"")="",0,1)) AS TTL�tsz�m2021, Sum(0) AS TTL�tsz�m2022, Sum(0) AS TTL�tsz�m2023
FROM tSzem�lyek20210101
WHERE (((tSzem�lyek20210101.[St�tusz neve])="�ll�shely"))
GROUP BY Replace(Nz(IIf(IsNull([tSzem�lyek20210101].[Szint 4 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek20210101].[Szint 3 szervezeti egys�g n�v]),[tSzem�lyek20210101].[Szint 2 szervezeti egys�g n�v] & "",[tSzem�lyek20210101].[Szint 3 szervezeti egys�g n�v] & ""),[tSzem�lyek20210101].[Szint 4 szervezeti egys�g n�v] & ""),""),"Budapest F�v�ros Korm�nyhivatala ","BFKH ") & "", [Szint 5 szervezeti egys�g n�v] & "";

-- [lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2022]
SELECT Replace(Nz(IIf(IsNull([tSzem�lyek20220101].[Szint 4 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek20220101].[Szint 3 szervezeti egys�g n�v]),[tSzem�lyek20220101].[Szint 2 szervezeti egys�g n�v] & "",[tSzem�lyek20220101].[Szint 3 szervezeti egys�g n�v] & ""),[tSzem�lyek20220101].[Szint 4 szervezeti egys�g n�v] & ""),""),"Budapest F�v�ros Korm�nyhivatala ","BFKH ") & "" AS F�oszt�ly, [Szint 5 szervezeti egys�g n�v] & "" AS Oszt�ly, Sum(0) AS TTL�tsz�m2021, Sum(IIf(Nz([Tart�s t�voll�t t�pusa],"")="",0,1)) AS TTL�tsz�m2022, Sum(0) AS TTL�tsz�m2023
FROM tSzem�lyek20220101
WHERE (((tSzem�lyek20220101.[St�tusz neve])="�ll�shely"))
GROUP BY Replace(Nz(IIf(IsNull([tSzem�lyek20220101].[Szint 4 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek20220101].[Szint 3 szervezeti egys�g n�v]),[tSzem�lyek20220101].[Szint 2 szervezeti egys�g n�v] & "",[tSzem�lyek20220101].[Szint 3 szervezeti egys�g n�v] & ""),[tSzem�lyek20220101].[Szint 4 szervezeti egys�g n�v] & ""),""),"Budapest F�v�ros Korm�nyhivatala ","BFKH ") & "", [Szint 5 szervezeti egys�g n�v] & "";

-- [lkTTL�tsz�mF�oszt�lyonk�ntOszt�lyonk�nt2023]
SELECT Replace(Nz(IIf(IsNull([tSzem�lyek20230101].[Szint 4 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek20230101].[Szint 3 szervezeti egys�g n�v]),[tSzem�lyek20230101].[Szint 2 szervezeti egys�g n�v] & "",[tSzem�lyek20230101].[Szint 3 szervezeti egys�g n�v] & ""),[tSzem�lyek20230101].[Szint 4 szervezeti egys�g n�v] & ""),""),"Budapest F�v�ros Korm�nyhivatala ","BFKH ") & "" AS F�oszt�ly, [Szint 5 szervezeti egys�g n�v] & "" AS Oszt�ly, Sum(0) AS TTL�tsz�m2021, Sum(0) AS TTL�tsz�m2022, Sum(IIf(Nz([Tart�s t�voll�t t�pusa],"")="",0,1)) AS TTL�tsz�m2023, Sum(1) AS L�tsz�m2023
FROM tSzem�lyek20230101
WHERE (((tSzem�lyek20230101.[St�tusz neve])="�ll�shely"))
GROUP BY Replace(Nz(IIf(IsNull([tSzem�lyek20230101].[Szint 4 szervezeti egys�g n�v]),IIf(IsNull([tSzem�lyek20230101].[Szint 3 szervezeti egys�g n�v]),[tSzem�lyek20230101].[Szint 2 szervezeti egys�g n�v] & "",[tSzem�lyek20230101].[Szint 3 szervezeti egys�g n�v] & ""),[tSzem�lyek20230101].[Szint 4 szervezeti egys�g n�v] & ""),""),"Budapest F�v�ros Korm�nyhivatala ","BFKH ") & "", [Szint 5 szervezeti egys�g n�v] & "";

-- [lkTTv�ge01]
SELECT Year(IIf(dt�tal([Tart�s t�voll�t v�ge])=1,dt�tal([Tart�s t�voll�t tervezett v�ge]),dt�tal([Tart�s t�voll�t v�ge]))) AS V�ge�v, Month(IIf(dt�tal([Tart�s t�voll�t v�ge])=1,dt�tal([Tart�s t�voll�t tervezett v�ge]),dt�tal([Tart�s t�voll�t v�ge]))) AS V�geH�, 1 AS L�tsz�m, lkSzem�lyek.Azonos�t�, IIf(dt�tal([Tart�s t�voll�t v�ge])=1,dt�tal([Tart�s t�voll�t tervezett v�ge]),dt�tal([Tart�s t�voll�t v�ge])) AS D�tum
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null) AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Not Null));

-- [lkTTv�ge012024]
SELECT lkTTv�ge01.V�geH�, 0 AS 2026_�v, lkTTv�ge01.L�tsz�m AS 2024_�v, 0 AS 2025_�v
FROM lkTTv�ge01
WHERE (((lkTTv�ge01.D�tum) Between #1/1/2024# And #12/31/2024#));

-- [lkTTv�ge012025]
SELECT lkTTv�ge01.V�geH�, 0 AS 2026_�v, 0 AS 2024_�v, lkTTv�ge01.L�tsz�m AS 2025_�v
FROM lkTTv�ge01
WHERE (((lkTTv�ge01.D�tum) Between #1/1/2025# And #12/31/2025#));

-- [lkTTv�ge012026]
SELECT lkTTv�ge01.V�geH�, lkTTv�ge01.L�tsz�m AS 2026_�v, 0 AS 2024_�v, 0 AS 2025_�v
FROM lkTTv�ge01
WHERE (((lkTTv�ge01.D�tum) Between #1/1/2026# And #12/31/2026#));

-- [lkTTv�ge02]
SELECT *
FROM lkTTv�ge012026
UNION all
SELECT *
FROM lkTTv�ge012024
UNION ALL SELECT *
FROM lkTTv�ge012025;

-- [lkTTv�ge03]
SELECT tH�napok.h�nap AS [Tart�s t�voll�t v�ge], Sum(lkTTv�ge02.[2024_�v]) AS [2024 �v], Sum(lkTTv�ge02.[2025_�v]) AS [2025 �v], Sum([2026_�v]) AS [2026 �v]
FROM tH�napok INNER JOIN lkTTv�ge02 ON tH�napok.Azonos�t� = lkTTv�ge02.V�geH�
GROUP BY tH�napok.h�nap, lkTTv�ge02.V�geH�
ORDER BY lkTTv�ge02.V�geH�;

-- [lk�jBel�p�K�pz�s]
SELECT (Select count(Tmp.Azonos�t�) From lkSzem�lyek as Tmp Where Tmp.[Jogviszony t�pusa / jogviszony t�pus]<=lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus] and Tmp.[Jogviszony kezdete (bel�p�s d�tuma)]<=lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] And Tmp.[Dolgoz� teljes neve]<=lkSzem�lyek.[Dolgoz� teljes neve]) AS Sorsz�m, lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus] AS Jogviszony, lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS Bel�p�s, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.[Hivatali email] AS [E-mail c�m], lkSzem�lyek.Ad�jel AS [Ad�azonos�t� jel], [Sz�let�si hely] & ", " & [Sz�let�si id�] AS [Sz�let�si hely d�tum], lkSzem�lyek.[Anyja neve], lkSzem�lyek.[TAJ sz�m], lkKil�p�k.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja], lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)] AS Kil�p�s, lkSzem�lyek.[Jogfolytonos id� kezdete], lkSzem�lyek.[Szerz�d�s/Kinevez�s - pr�baid� v�ge], lkSzem�lyek.Nyugd�jas, lkSzem�lyek.[Nyugd�j t�pusa], lkSzem�lyek.[Nyugd�jas kor� tov�bbfoglalkoztat�si enged�llyel rendelkezik]
FROM lkKil�p�k RIGHT JOIN lkSzem�lyek ON lkKil�p�k.Ad�azonos�t� = lkSzem�lyek.[Ad�azonos�t� jel]
WHERE (((lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])="Korm�nyzati szolg�lati jogviszony" Or (lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus])="Munkaviszony") AND ((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)])>=#11/1/2022#) AND ((lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)])>="#2023. 05. 15.#" Or (lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)]) Is Null))
ORDER BY lkSzem�lyek.[Jogviszony t�pusa / jogviszony t�pus], lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)], lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkUtols�Besorol�s]
SELECT lkBesorol�siEredm�nyadatok.*
FROM lkBesorol�siEredm�nyadatok
WHERE (((lkBesorol�siEredm�nyadatok.[V�ltoz�s d�tuma])=(select max(a.[V�ltoz�s d�tuma]) from lkBesorol�siEredm�nyadatok as a where a.[Ad�azonos�t� jel] = lkBesorol�siEredm�nyadatok.[Ad�azonos�t� jel])));

-- [lkUtols�Besorol�sAkt�ve]
SELECT lkUtols�Besorol�s.[Ad�azonos�t� jel], lkSzem�lyek.[Dolgoz� teljes neve]
FROM lkUtols�Besorol�s INNER JOIN lkSzem�lyek ON lkUtols�Besorol�s.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"));

-- [lkUt�nevek]
SELECT Ut�nevekBesorol�sib�l.Keresztn�v INTO tUt�nevek
FROM (SELECT  ffsplit([Ut�n�v]," ",1) AS Keresztn�v
FROM lkBesorol�siEredm�nyadatok
UNION
SELECT  ffsplit([Ut�n�v]," ",2) AS Kif1
FROM lkBesorol�siEredm�nyadatok)  AS Ut�nevekBesorol�sib�l;

-- [lkUt�nevekGyakoris�ga]
SELECT Tal�latok.Keresztn�v, Count(lkSzem�lyek.[Ad�azonos�t� jel]) AS [CountOfAd�azonos�t� jel]
FROM (SELECT [Keresztn�v], * FROM lkSzem�lyek INNER JOIN tUt�nevek ON [lkSzem�lyek].[Dolgoz� Teljes Neve] like "* "&[tUt�nevek].[Keresztn�v]&" *")  AS Tal�latok
GROUP BY Tal�latok.Keresztn�v;

-- [lkUt�nevekNemekkel]
SELECT Ut�nevekBesorol�sib�l.Keresztn�v, Ut�nevekBesorol�sib�l.Neme INTO tUt�nevekNemekkel
FROM (SELECT ffsplit([Ut�n�v]," ",1) AS Keresztn�v, lkSzem�lyek.Neme
FROM lkSzem�lyek RIGHT JOIN lkBesorol�siEredm�nyadatok ON lkSzem�lyek.[Ad�azonos�t� jel] = lkBesorol�siEredm�nyadatok.[Ad�azonos�t� jel]
UNION
SELECT ffsplit([Ut�n�v]," ",2) AS Keresztn�v, lkSzem�lyek.Neme
FROM lkSzem�lyek RIGHT JOIN lkBesorol�siEredm�nyadatok ON lkSzem�lyek.[Ad�azonos�t� jel] = lkBesorol�siEredm�nyadatok.[Ad�azonos�t� jel]
)  AS Ut�nevekBesorol�sib�l;

-- [lkUt�n�vt�rbanNemSzerepl�Ut�nevek]
SELECT tUt�nevek.Keresztn�v, Right([Keresztn�v],2)="n�" AS Kif1
FROM tUt�nevek LEFT JOIN t�sszesUt�n�v ON tUt�nevek.Keresztn�v = t�sszesUt�n�v.Ut�n�v
WHERE (((t�sszesUt�n�v.Ut�n�v) Is Null) AND ((Right([Keresztn�v],2)="n�")=False));

-- [lk�res�ll�shelyek]
SELECT lkJ�r�siKorm�nyK�zpontos�tottUni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�], Replace([J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH") AS [F�oszt�ly\Hivatal], lkJ�r�siKorm�nyK�zpontos�tottUni�.[�ll�shely azonos�t�], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Besorol�si fokozat megnevez�se:], lkJ�r�siKorm�nyK�zpontos�tottUni�.Jelleg, lkJ�r�siKorm�nyK�zpontos�tottUni�.[Sz�let�si �v \ �res �ll�s] AS Mez�4, lkJ�r�siKorm�nyK�zpontos�tottUni�.[Besorol�si fokozat k�d:], lkJ�r�siKorm�nyK�zpontos�tottUni�.Kinevez�s AS [Meg�resed�s d�tuma], DateDiff("m",[Kinevez�s],Now()) AS [Meg�resed�st�l eltelt h�napok], TextToMD5Hex([�ll�shely azonos�t�]) AS Hash
FROM lkJ�r�siKorm�nyK�zpontos�tottUni�
WHERE (((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Sz�let�si �v \ �res �ll�s]) Like "�res*"))
ORDER BY Bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]);

-- [lk�res�ll�shelyek_Alapl�tsz�m]
SELECT Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�], [Szint5 - le�r�s] & [Szint6 - le�r�s] AS [F�oszt�ly\Hivatal], Uni�.[�ll�shely azonos�t�], Uni�.[Besorol�si fokozat megnevez�se:]
FROM tSzervezeti RIGHT JOIN (SELECT [�ll�shely azonos�t�], Mez�4, [Besorol�si fokozat megnevez�se:], [�NYR SZERVEZETI EGYS�G AZONOS�T�], [Besorol�si fokozat k�d:]                       FROM J�r�si_�llom�ny                       WHERE [Besorol�si fokozat k�d:] like "��*"           UNION SELECT [�ll�shely azonos�t�], Mez�4, [Besorol�si fokozat megnevez�se:], [�NYR SZERVEZETI EGYS�G AZONOS�T�], [Besorol�si fokozat k�d:]                       FROM Korm�nyhivatali_�llom�ny                       WHERE (((Korm�nyhivatali_�llom�ny.[Besorol�si fokozat k�d:]) like "��*"))    )  AS Uni� ON tSzervezeti.[Szervezetmenedzsment k�d] = Uni�.[�NYR SZERVEZETI EGYS�G AZONOS�T�]
ORDER BY Bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]);

-- [lk�res�ll�shelyek001]
SELECT lkJ�r�siKorm�nyK�zpontos�tottUni�.[J�r�si Hivatal] AS [F�oszt�ly\Hivatal], lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly, lkJ�r�siKorm�nyK�zpontos�tottUni�.[�ll�shely azonos�t�], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Besorol�si fokozat megnevez�se:], lkHaviJelent�sHat�lya.hat�lya
FROM lkJ�r�siKorm�nyK�zpontos�tottUni�, lkHaviJelent�sHat�lya
WHERE (((lkJ�r�siKorm�nyK�zpontos�tottUni�.[Sz�let�si �v \ �res �ll�s]) Like "�res*"));

-- [lk�res�ll�shelyek002]
SELECT IIf([Megyei szint VAGY J�r�si Hivatal]="megyei szint",[Mez�5],[Megyei szint VAGY J�r�si Hivatal]) AS F�oszt�ly, lkBel�p�kTeljes.Mez�6 AS Oszt�ly, lkBel�p�kTeljes.[�ll�shely azonos�t�], lkBel�p�kTeljes.[Besorol�si fokozat megnevez�se:], lkBel�p�kTeljes.[Jogviszony kezd� d�tuma]
FROM lkBel�p�kTeljes
WHERE (((lkBel�p�kTeljes.[Jogviszony kezd� d�tuma]) Between Date() And IIf(Day(Now()) Between 2 And 15,DateSerial(Year(Date()),Month(Date()),15),DateSerial(Year(Date()),Month(Date())+1,1))));

-- [lk�res�ll�shelyek003]
SELECT tKil�p�kUni�.F�oszt�ly, tKil�p�kUni�.Oszt�ly, tKil�p�kUni�.[�ll�shely azonos�t�], tKil�p�kUni�.[Besorol�si fokozat megnevez�se:], tKil�p�kUni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]
FROM tKil�p�kUni�
WHERE (((tKil�p�kUni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]) Between Date() And IIf(Day(Now()) Between 2 And 15,DateSerial(Year(Date()),Month(Date()),15),DateSerial(Year(Date()),Month(Date())+1,1))));

-- [lk�res�ll�shelyek004]
SELECT IIf([lk�res�ll�shelyek002].[F�oszt�ly] Is Null,[lk�res�ll�shelyek001].[F�oszt�ly\Hivatal],[lk�res�ll�shelyek002].[F�oszt�ly]) AS F�oszt�lya, IIf([lk�res�ll�shelyek002].[oszt�ly] Is Null,[lk�res�ll�shelyek001].[Oszt�ly],[lk�res�ll�shelyek002].[oszt�ly]) AS Oszt�lya, IIf([lk�res�ll�shelyek002].[�ll�shely azonos�t�] Is Null,[lk�res�ll�shelyek001].[�ll�shely azonos�t�],[lk�res�ll�shelyek002].[�ll�shely azonos�t�]) AS �ll�shely, IIf([lk�res�ll�shelyek002].[Besorol�si fokozat megnevez�se:] Is Null,[lk�res�ll�shelyek001].[Besorol�si fokozat megnevez�se:],[lk�res�ll�shelyek002].[Besorol�si fokozat megnevez�se:]) AS Besorol�s, IIf([lk�res�ll�shelyek002].[�ll�shely azonos�t�] Is Null,[lk�res�ll�shelyek001].[hat�lya],[lk�res�ll�shelyek002].[Jogviszony kezd� d�tuma]) AS D�tum
FROM lk�res�ll�shelyek001 LEFT JOIN lk�res�ll�shelyek002 ON lk�res�ll�shelyek001.[�ll�shely azonos�t�] = lk�res�ll�shelyek002.[�ll�shely azonos�t�]
WHERE (((lk�res�ll�shelyek002.[�ll�shely azonos�t�]) Is Null));

-- [lk�res�ll�shelyek005]
SELECT DISTINCT [004�s002].F�oszt�lya, [004�s002].Oszt�lya, [004�s002].�ll�shely, [004�s002].D�tum, [004�s002].Besorol�s, TextToMD5Hex([�ll�shely]) AS Hash, *
FROM (SELECT *
FROM lk�res�ll�shelyek004
UNION SELECT *
FROM  lk�res�ll�shelyek003)  AS 004�s002
ORDER BY [004�s002].D�tum;

-- [lk�res�ll�shelyek�llapotfelm�r�]
SELECT lk�res�ll�shelyek.[F�oszt�ly\Hivatal], lk�res�ll�shelyek.[�ll�shely azonos�t�], lk�res�ll�shelyek.[Besorol�si fokozat megnevez�se:], IIf(dt�tal([DeliveredDate])=0,"",dt�tal([DeliveredDate])) AS [Legut�bbi �llapot ideje], Nz([Visszajelz�sSz�vege],"Nincs folyamatban") AS [Legut�bbi �llapot]
FROM (tVisszajelz�sT�pusok RIGHT JOIN lk�zenetekVisszajelz�sek ON tVisszajelz�sT�pusok.Visszajelz�sK�d = lk�zenetekVisszajelz�sek.Visszajelz�sK�d) RIGHT JOIN lk�res�ll�shelyek ON lk�zenetekVisszajelz�sek.Hash = lk�res�ll�shelyek.Hash
WHERE (((lk�zenetekVisszajelz�sek.DeliveredDate)=(Select Max([DeliveredDate]) FROM [lk�zenetekVisszajelz�sek] as Tmp Where [lk�zenetekVisszajelz�sek].Hash=Tmp.hash) Or (lk�zenetekVisszajelz�sek.DeliveredDate) Is Null))
ORDER BY lk�res�ll�shelyek.[F�oszt�ly\Hivatal], lk�res�ll�shelyek.[�ll�shely azonos�t�];

-- [lk�res�ll�shelyekEredeti�llapot]
SELECT 182 AS az�zenet, TextToMD5Hex([�NYR]) AS Hash, tVisszajelz�sT�pusok.Visszajelz�sK�d
FROM tVisszajelz�sT�pusok RIGHT JOIN �nyr�sV�laszok240815 ON tVisszajelz�sT�pusok.Visszajelz�sSz�vege = �nyr�sV�laszok240815.�llapot
WHERE (((tVisszajelz�sT�pusok.Visszajelz�sK�d) Is Not Null));

-- [lk�res�ll�shelyek�rkezettVisszajelz�sekF�oszt�lyonk�nt]
SELECT Sz�ml�l�s.[F�oszt�ly\Hivatal], Sz�ml�l�s.[�rkezett v�lasz], Sz�ml�l�s.[Nem �rkezett v�lasz], Sz�ml�l�s.�sszesen, *
FROM (SELECT lk�res�ll�shelyek�llapotfelm�r�.[F�oszt�ly\Hivatal], Sum(IIf([Legut�bbi �llapot ideje]=DateSerial(Year(Now()),Month(Now()),Day(Now())),1,0)) AS [�rkezett v�lasz], Sum(IIf([Legut�bbi �llapot ideje]<>DateSerial(Year(Now()),Month(Now()),Day(Now())),1,0)) AS [Nem �rkezett v�lasz], Sum(1) as �sszesen
FROM lk�res�ll�shelyek�llapotfelm�r�
GROUP BY lk�res�ll�shelyek�llapotfelm�r�.[F�oszt�ly\Hivatal])  AS Sz�ml�l�s
WHERE (((Sz�ml�l�s.[�rkezett v�lasz])=0));

-- [lk�res�ll�shelyekHavib�l01]
SELECT lkJ�r�siKorm�nyK�zpontos�tottUni�.[�ll�shely azonos�t�], lkJ�r�siKorm�nyK�zpontos�tottUni�.Kinevez�s, IIf([Sz�let�si �v \ �res �ll�s]="�res �ll�s",True,False) AS �res, IIf([Kinevez�s]<Date(),True,False) AS Kor�bbi, IIf([Kinevez�s]>Date(),True,False) AS K�s�bbi, [Kinevez�s]=Date() AS Mai, Switch([�res] And [Kor�bbi],"�res",[�res] And [k�s�bbi],"bet�lt�tt",[�res] And [mai],"�res",Not [�res] And [Mai],"bet�lt�tt",Not [�res] And [kor�bbi],"bet�lt�tt",Not [�res] And [k�s�bbi],"�res") AS �llapot
FROM lkJ�r�siKorm�nyK�zpontos�tottUni�;

-- [lk�res�ll�shelyekNemVezet�]
SELECT lk�res�ll�shelyek.[�NYR SZERVEZETI EGYS�G AZONOS�T�], lk�res�ll�shelyek.[F�oszt�ly\Hivatal], lk�res�ll�shelyek.[�ll�shely azonos�t�], lk�res�ll�shelyek.[Besorol�si fokozat megnevez�se:], lk�res�ll�shelyek.[Besorol�si fokozat k�d:], lk�res�ll�shelyek.Jelleg, lk�res�ll�shelyek.[Meg�resed�st�l eltelt h�napok]
FROM lk�res�ll�shelyek
WHERE (((lk�res�ll�shelyek.[Besorol�si fokozat k�d:]) Not Like "*Ov*" And (lk�res�ll�shelyek.[Besorol�si fokozat k�d:]) Not Like "*Jhv*" And (lk�res�ll�shelyek.[Besorol�si fokozat k�d:]) Not Like "*ig." And (lk�res�ll�shelyek.[Besorol�si fokozat k�d:])<>"Fsp."));

-- [lk�res�ll�shelyekNemVezet�_besorol�sonk�ntimegoszl�s]
SELECT lk�res�ll�shelyekNemVezet�.[Besorol�si fokozat megnevez�se:], Count(lk�res�ll�shelyekNemVezet�.[�ll�shely azonos�t�]) AS [�res �ll�shelyek sz�ma]
FROM lk�res�ll�shelyekNemVezet�
GROUP BY lk�res�ll�shelyekNemVezet�.[Besorol�si fokozat megnevez�se:], lk�res�ll�shelyekNemVezet�.[Besorol�si fokozat k�d:]
ORDER BY lk�res�ll�shelyekNemVezet�.[Besorol�si fokozat k�d:];

-- [lk�res�ll�shelyekNemVezet�_szervezti�gank�ntimegoszl�s]
SELECT IIf(InStr(1,[F�oszt�ly\Hivatal],"ker�leti"),"Ker�leti hivatalok","F�oszt�lyok") AS �g, Count(lk�res�ll�shelyekNemVezet�.[�ll�shely azonos�t�]) AS [�res �ll�shelyek sz�ma]
FROM lk�res�ll�shelyekNemVezet�
GROUP BY IIf(InStr(1,[F�oszt�ly\Hivatal],"ker�leti"),"Ker�leti hivatalok","F�oszt�lyok")
ORDER BY Count(lk�res�ll�shelyekNemVezet�.[�ll�shely azonos�t�]) DESC;

-- [lk�res�ll�shelyekStatisztika]
SELECT Statisztika.Jelleg, Statisztika.[CountOf�ll�shely azonos�t�] AS L�tsz�m
FROM (SELECT "�sszes:" AS Jelleg, Count(lk�res�ll�shelyek.[�ll�shely azonos�t�]) AS [CountOf�ll�shely azonos�t�], 1 AS Sorsz�m
FROM lk�res�ll�shelyek�llapotfelm�r� INNER JOIN (lk�res�ll�shelyek INNER JOIN tBesorol�s_�talak�t� ON lk�res�ll�shelyek.[Besorol�si fokozat k�d:] = tBesorol�s_�talak�t�.[Az �ll�shely jel�l�se]) ON lk�res�ll�shelyek�llapotfelm�r�.[�ll�shely azonos�t�] = lk�res�ll�shelyek.[�ll�shely azonos�t�]

union SELECT "K�zpontos�tott:" AS Jelleg, Count(lk�res�ll�shelyek.[�ll�shely azonos�t�]) AS [CountOf�ll�shely azonos�t�], 2 AS Sorsz�m
FROM lk�res�ll�shelyek�llapotfelm�r� INNER JOIN (lk�res�ll�shelyek INNER JOIN tBesorol�s_�talak�t� ON lk�res�ll�shelyek.[Besorol�si fokozat k�d:] = tBesorol�s_�talak�t�.[Az �ll�shely jel�l�se]) ON lk�res�ll�shelyek�llapotfelm�r�.[�ll�shely azonos�t�] = lk�res�ll�shelyek.[�ll�shely azonos�t�]
WHERE (((lk�res�ll�shelyek.Jelleg)="K"))

union SELECT "Alapl�tsz�m:" AS Jelleg, Count(lk�res�ll�shelyek.[�ll�shely azonos�t�]) AS [CountOf�ll�shely azonos�t�], 3 AS Sorsz�m
FROM lk�res�ll�shelyek�llapotfelm�r� INNER JOIN (lk�res�ll�shelyek INNER JOIN tBesorol�s_�talak�t� ON lk�res�ll�shelyek.[Besorol�si fokozat k�d:] = tBesorol�s_�talak�t�.[Az �ll�shely jel�l�se]) ON lk�res�ll�shelyek�llapotfelm�r�.[�ll�shely azonos�t�] = lk�res�ll�shelyek.[�ll�shely azonos�t�]
WHERE (((lk�res�ll�shelyek.jelleg)="A"))

union SELECT "Vezet�k:" AS Jelleg, Count(lk�res�ll�shelyek.[�ll�shely azonos�t�]) AS [CountOf�ll�shely azonos�t�], 4 AS Sorsz�m
FROM lk�res�ll�shelyek�llapotfelm�r� INNER JOIN (lk�res�ll�shelyek INNER JOIN tBesorol�s_�talak�t� ON lk�res�ll�shelyek.[Besorol�si fokozat k�d:] = tBesorol�s_�talak�t�.[Az �ll�shely jel�l�se]) ON lk�res�ll�shelyek�llapotfelm�r�.[�ll�shely azonos�t�] = lk�res�ll�shelyek.[�ll�shely azonos�t�]
WHERE (((tBesorol�s_�talak�t�.Vezet�)=Yes) AND ((lk�res�ll�shelyek.Jelleg)="A"))

union SELECT "Netto �res:" AS Jelleg, Count(lk�res�ll�shelyek.[�ll�shely azonos�t�]) AS [CountOf�ll�shely azonos�t�], 5 AS Sorsz�m
FROM lk�res�ll�shelyek�llapotfelm�r� INNER JOIN (lk�res�ll�shelyek INNER JOIN tBesorol�s_�talak�t� ON lk�res�ll�shelyek.[Besorol�si fokozat k�d:] = tBesorol�s_�talak�t�.[Az �ll�shely jel�l�se]) ON lk�res�ll�shelyek�llapotfelm�r�.[�ll�shely azonos�t�] = lk�res�ll�shelyek.[�ll�shely azonos�t�]
WHERE (((lk�res�ll�shelyek�llapotfelm�r�.[Legut�bbi �llapot])="Nincs folyamatban" Or (lk�res�ll�shelyek�llapotfelm�r�.[Legut�bbi �llapot])="P�ly�zat ki�rva")) )  AS Statisztika
ORDER BY Statisztika.Sorsz�m;

-- [lk�res�ll�shelyekVezet�]
SELECT lk�res�ll�shelyek.[�NYR SZERVEZETI EGYS�G AZONOS�T�], lk�res�ll�shelyek.[F�oszt�ly\Hivatal], lk�ll�shelyek.Oszt�ly, lk�res�ll�shelyek.[�ll�shely azonos�t�], lk�ll�shelyek.[�ll�shely besorol�si kateg�ri�ja], lk�ll�shelyek.rang, lk�res�ll�shelyek.Jelleg, lk�ll�shelyek.[�ll�shely st�tusza], lk�ll�shelyek.[Hat�lyoss�g kezdete] AS [Mi�ta �res �NYR], lk�res�ll�shelyek.[Meg�resed�s d�tuma] AS [Mi�ta �res Nexon], Date()-[Hat�lyoss�g kezdete] AS [H�ny napja �res �NYR], Date()-[Hat�lyoss�g kezdete] AS [H�ny napja �res NEXON]
FROM lk�res�ll�shelyek RIGHT JOIN lk�ll�shelyek ON lk�res�ll�shelyek.[�ll�shely azonos�t�] = lk�ll�shelyek.[�ll�shely azonos�t�]
WHERE (((lk�ll�shelyek.[�ll�shely st�tusza])="bet�ltetlen - tart�san t�voll�v�" Or (lk�ll�shelyek.[�ll�shely st�tusza])="bet�ltetlen") AND ((lk�res�ll�shelyek.[Besorol�si fokozat k�d:]) Like "*Ov*" Or (lk�res�ll�shelyek.[Besorol�si fokozat k�d:]) Like "*Jhv*" Or (lk�res�ll�shelyek.[Besorol�si fokozat k�d:]) Like "*ig." Or (lk�res�ll�shelyek.[Besorol�si fokozat k�d:])="fsp."));

-- [lk�res�ll�shelyekVisszajelz�sekStatisztika0]
SELECT lk�res�ll�shelyek�llapotfelm�r�.[F�oszt�ly\Hivatal], Sum(IIf([Legut�bbi �llapot ideje]>=DateAdd("d",-5,dt�tal(Now())),1,0)) AS [�rkezett v�lasz], Sum(IIf(Nz([Legut�bbi �llapot ideje],0)<DateAdd("d",-5,dt�tal(Now())),1,0)) AS [Nem �rkezett v�lasz], Sum(1) AS �sszesen
FROM lk�res�ll�shelyek�llapotfelm�r�
GROUP BY lk�res�ll�shelyek�llapotfelm�r�.[F�oszt�ly\Hivatal];

-- [lk�res�ll�shelyekVisszajelz�sekStatisztikaA]
SELECT Switch([�rkezett v�lasz]=0,"Egy v�lasz sem �rkezett",[�rkezett v�lasz]<[�sszesen],"M�g nem �rkezett meg minden v�lasz",[�rkezett v�lasz]=[�sszesen],"Minden v�lasz meg�rkezett") AS Kateg�ria, Sum(1) AS db
FROM lk�res�ll�shelyekVisszajelz�sekStatisztika0 AS Sz�ml�l�s
GROUP BY Switch([�rkezett v�lasz]=0,"Egy v�lasz sem �rkezett",[�rkezett v�lasz]<[�sszesen],"M�g nem �rkezett meg minden v�lasz",[�rkezett v�lasz]=[�sszesen],"Minden v�lasz meg�rkezett");

-- [lk�res�ll�shelyekVisszajelz�sekStatisztikaB]
SELECT V�laszok.Kateg�ria AS Kateg�ria, V�laszok.[Nem �rkezett v�lasz] AS �rt�k
FROM (SELECT 1 AS Sorsz�m, "M�g meg nem �rkezett v�laszok sz�ma" AS Kateg�ria, Sum(lk�res�ll�shelyekVisszajelz�sekStatisztika0.[Nem �rkezett v�lasz]) AS [Nem �rkezett v�lasz]
FROM lk�res�ll�shelyekVisszajelz�sekStatisztika0
GROUP BY "M�g meg nem �rkezett v�laszok sz�ma"
UNION SELECT 2 AS Sorsz�m, "Be�rkezett v�laszok sz�ma" AS Kateg�ria, Sum(lk�res�ll�shelyekVisszajelz�sekStatisztika0.[�rkezett v�lasz]) as [�rkezett v�lasz]
FROM lk�res�ll�shelyekVisszajelz�sekStatisztika0
GROUP BY "Be�rkezett v�laszok sz�ma"
 )  AS V�laszok
ORDER BY V�laszok.Sorsz�m;

-- [lk�res�ll�shelyJelent�s]
SELECT bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]) AS BFKH, lkJ�r�siKorm�nyK�zpontos�tottUni�.[�ll�shely azonos�t�] AS �NYR, lkJ�r�siKorm�nyK�zpontos�tottUni�.[j�r�si hivatal] AS [szervezeti egys�g/ker�leti hivatal], lkJ�r�siKorm�nyK�zpontos�tottUni�.Oszt�ly, IIf([Sz�let�si �v \ �res �ll�s]="�res �ll�s","�res","") AS [Nexon szerint], lkJ�r�siKorm�nyK�zpontos�tottUni�.[Besorol�si fokozat megnevez�se:] AS Besorol�s, lk�res�ll�shelyekExcel.Feladatk�r, lk�res�ll�shelyekExcel.�llapot
FROM lk�res�ll�shelyekExcel RIGHT JOIN lkJ�r�siKorm�nyK�zpontos�tottUni� ON lk�res�ll�shelyekExcel.st�tusz = lkJ�r�siKorm�nyK�zpontos�tottUni�.[�ll�shely azonos�t�]
WHERE (((IIf([Sz�let�si �v \ �res �ll�s]="�res �ll�s","�res",""))="�res"))
ORDER BY bfkh([�NYR SZERVEZETI EGYS�G AZONOS�T�]);

-- [lk�res�ll�shelyKimutat�shoz]
SELECT �ll�shelyek.[�ll�shely azonos�t�], IIf(Nz([Dolgoz� teljes neve],"")="","Bet�ltetlen","Bet�lt�tt") AS �llapot, lkSzem�lyek.[Dolgoz� teljes neve] AS [Bet�lt� neve], lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)] AS Bel�p�s
FROM lkSzem�lyek RIGHT JOIN �ll�shelyek ON lkSzem�lyek.[St�tusz k�dja]=�ll�shelyek.[�ll�shely azonos�t�]
ORDER BY �ll�shelyek.[�ll�shely azonos�t�];

-- [lk�res�ll�sLegutols�Visszajelz�s]
SELECT lk�res�ll�shelyek.[�ll�shely azonos�t�], Nz([Visszajelz�sSz�vege],"") AS [Legut�bbi �llapot]
FROM (tVisszajelz�sT�pusok RIGHT JOIN lk�zenetekVisszajelz�sek ON tVisszajelz�sT�pusok.Visszajelz�sK�d = lk�zenetekVisszajelz�sek.Visszajelz�sK�d) RIGHT JOIN lk�res�ll�shelyek ON lk�zenetekVisszajelz�sek.Hash = lk�res�ll�shelyek.Hash
WHERE (((lk�zenetekVisszajelz�sek.DeliveredDate)=(Select Max([DeliveredDate]) FROM [lk�zenetekVisszajelz�sek] as Tmp Where [lk�zenetekVisszajelz�sek].Hash=Tmp.hash) Or (lk�zenetekVisszajelz�sek.DeliveredDate) Is Null))
ORDER BY lk�res�ll�shelyek.[�ll�shely azonos�t�];

-- [lk�resSzervezetiEgys�gek]
SELECT tSzervezeti.OSZLOPOK, tSzervezeti.[Bet�lt�tt st�tuszok sz�ma (db)], tSzervezeti.[Bet�ltetlen st�tuszok sz�ma (db)]
FROM tSzervezeti
WHERE (((tSzervezeti.OSZLOPOK) Like "Szervezeti egys�g �sszesen*") AND ((tSzervezeti.[Bet�lt�tt st�tuszok sz�ma (db)])=0));

-- [lk�zenetekVisszajelz�sek]
SELECT tBej�v�Visszajelz�sek.*, tBej�v��zenetek.*
FROM tBej�v��zenetek INNER JOIN tBej�v�Visszajelz�sek ON tBej�v��zenetek.az�zenet = tBej�v�Visszajelz�sek.az�zenet;

-- [lk�zenetekVisszajelz�sek01]
SELECT curr.Hash, curr.SenderEmailAddress, curr.DeliveredDate, tVisszajelz�sT�pusok.Visszajelz�sK�d, tVisszajelz�sT�pusok.Visszajelz�sSz�vege, curr.Hat�ly
FROM lk�zenetekVisszajelz�sek AS curr INNER JOIN tVisszajelz�sT�pusok ON curr.Visszajelz�sK�d = tVisszajelz�sT�pusok.Visszajelz�sK�d
WHERE curr.Hash = [Azonos�t�HASH]
    AND (
        curr.SenderEmailAddress <> 
        (SELECT TOP 1 prev.SenderEmailAddress 
         FROM lk�zenetekVisszajelz�sek AS prev
         WHERE prev.Hash = curr.Hash 
           AND prev.azVisszajelz�s < curr.azVisszajelz�s
         ORDER BY prev.azVisszajelz�s DESC)
        OR curr.Visszajelz�sK�d <> 
        (SELECT TOP 1 prev.Visszajelz�sK�d 
         FROM lk�zenetekVisszajelz�sek AS prev
         WHERE prev.Hash = curr.Hash 
           AND prev.azVisszajelz�s < curr.azVisszajelz�s
         ORDER BY prev.azVisszajelz�s DESC)
        OR curr.Hat�ly <> 
        (SELECT TOP 1 prev.Hat�ly 
         FROM lk�zenetekVisszajelz�sek AS prev
         WHERE prev.Hash = curr.Hash 
           AND prev.azVisszajelz�s < curr.azVisszajelz�s
         ORDER BY prev.azVisszajelz�s DESC)
        OR (SELECT TOP 1 prev.azVisszajelz�s 
            FROM lk�zenetekVisszajelz�sek AS prev
            WHERE prev.Hash = curr.Hash 
              AND prev.azVisszajelz�s < curr.azVisszajelz�s
            ORDER BY prev.azVisszajelz�s DESC) IS NULL
    )
ORDER BY curr.Hash, curr.DeliveredDate;

-- [lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m01]
SELECT lkV�rosOldalank�ntiL�tsz�m01.F�oszt�ly, lkV�rosOldalank�ntiL�tsz�m01.Ker�let, Sum(lkV�rosOldalank�ntiL�tsz�m01.f�) AS L�tsz�m
FROM lkV�rosOldalank�ntiL�tsz�m01
GROUP BY lkV�rosOldalank�ntiL�tsz�m01.F�oszt�ly, lkV�rosOldalank�ntiL�tsz�m01.Ker�let;

-- [lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02]
TRANSFORM Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m01.L�tsz�m) AS SumOfL�tsz�m
SELECT lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m01.F�oszt�ly
FROM lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m01
GROUP BY lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m01.F�oszt�ly
PIVOT lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m01.Ker�let in (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,"egy�b");

-- [lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m03]
SELECT "�sszesen:" AS F�oszt�ly, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[1]) AS SumOf1, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[2]) AS SumOf2, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[3]) AS SumOf3, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[4]) AS SumOf4, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[5]) AS SumOf5, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[6]) AS SumOf6, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[7]) AS SumOf7, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[8]) AS SumOf8, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[9]) AS SumOf9, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[10]) AS SumOf10, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[11]) AS SumOf11, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[12]) AS SumOf12, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[13]) AS SumOf13, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[14]) AS SumOf14, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[15]) AS SumOf15, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[16]) AS SumOf16, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[17]) AS SumOf17, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[18]) AS SumOf18, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[19]) AS SumOf19, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[20]) AS SumOf20, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[21]) AS SumOf21, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[22]) AS SumOf22, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.[23]) AS SumOf23, Sum(lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.egy�b) AS SumOfegy�b
FROM lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02
GROUP BY "�sszesen:";

-- [lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m04]
SELECT *
FROM (SELECT 1 as sor, lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02.*
FROM lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m02
UNION
SELECT 2 as sor, lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m03.*
FROM  lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m03)  AS 02�S03;

-- [lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m05]
SELECT lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m04.*, lkF�oszt�lyonk�ntiBet�lt�ttL�tsz�m.F�oszt�lyiL�tsz�m AS �sszesen
FROM lkF�oszt�lyonk�ntiBet�lt�ttL�tsz�m INNER JOIN lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m04 ON lkF�oszt�lyonk�ntiBet�lt�ttL�tsz�m.F�oszt�ly=lkV�rosKer�letenk�ntiF�oszt�lyonk�ntiL�tsz�m04.F�oszt�ly;

-- [lkV�rosKer�letenk�ntiL�tsz�m]
SELECT lkV�rosOldalank�ntiL�tsz�m01.Ker�let, Sum(lkV�rosOldalank�ntiL�tsz�m01.f�) AS SumOff�
FROM lkV�rosOldalank�ntiL�tsz�m01
GROUP BY lkV�rosOldalank�ntiL�tsz�m01.Ker�let;

-- [lkV�rosOldalank�ntiF�oszt�lyonk�ntL�tsz�m]
SELECT lkV�rosOldalank�ntiL�tsz�m01.Oldal, lkV�rosOldalank�ntiL�tsz�m01.F�oszt�ly, Sum(lkV�rosOldalank�ntiL�tsz�m01.f�) AS SumOff�
FROM lkV�rosOldalank�ntiL�tsz�m01
GROUP BY lkV�rosOldalank�ntiL�tsz�m01.Oldal, lkV�rosOldalank�ntiL�tsz�m01.F�oszt�ly;

-- [lkV�rosOldalank�ntiL�tsz�m01]
SELECT Mid(Replace([F�oszt�lyK�d],"BFKH.1.",""),1,InStr(1,Replace([F�oszt�lyK�d],"BFKH.1.",""),".")-1) AS Sor, lkSzem�lyek.F�oszt�ly, lkSzem�lyek.[Munkav�gz�s helye - c�m], Irsz([Munkav�gz�s helye - c�m])*1 AS irsz, ker�let([irsz]) AS Ker�let, IIf(Left([irsz],1)<>1,"Nem Budapest",IIf(Ker�let([irsz]) Between 1 And 3 Or ker�let([irsz]) Between 11 And 12 Or ker�let([irsz])=22,"Buda","Pest")) AS Oldal, 1 AS f�
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.F�oszt�ly;

-- [lkV�rosOldalank�ntiL�tsz�m02]
SELECT lkV�rosOldalank�ntiL�tsz�m01.Oldal, Sum(lkV�rosOldalank�ntiL�tsz�m01.f�) AS L�tsz�m
FROM lkV�rosOldalank�ntiL�tsz�m01
GROUP BY lkV�rosOldalank�ntiL�tsz�m01.Oldal;

-- [lkV�d�n�k00]
SELECT tV�d�n�k.Ad�jel, tV�d�n�k.D�tum, tV�d�n�k.V�d�n�, tV�d�n�k.[Vezet� v�d�n�], tV�d�n�k.CsVSz, [tV�d�n�k].[Ad�jel] & "" AS Ad�azonos�t�, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)]
FROM tV�d�n�k INNER JOIN lkSzem�lyek ON tV�d�n�k.Ad�jel = lkSzem�lyek.Ad�jel;

-- [lkV�d�n�k01]
SELECT lkN�peg�szs�g�gyiDolgoz�k.Ad�jel, "Budapest F�v�ros Korm�nyhivatala" AS Korm�nyhivatal, 0 AS Sorsz�m, lkN�peg�szs�g�gyiDolgoz�k.N�v, lkV�d�n�k00.Ad�azonos�t�, lkN�peg�szs�g�gyiDolgoz�k.[Sz�let�si �v \ �res �ll�s], lkN�peg�szs�g�gyiDolgoz�k.[Megyei szint], lkN�peg�szs�g�gyiDolgoz�k.F�oszt�ly, lkN�peg�szs�g�gyiDolgoz�k.Oszt�ly, lkN�peg�szs�g�gyiDolgoz�k.[�NYR SZERVEZETI EGYS�G AZONOS�T�], lkN�peg�szs�g�gyiDolgoz�k.[Ell�tott feladat], lkN�peg�szs�g�gyiDolgoz�k.Kinevez�s, lkN�peg�szs�g�gyiDolgoz�k.[Feladat jellege: szakmai (SZ) / funkcion�lis (F) feladatell�t�s;], lkN�peg�szs�g�gyiDolgoz�k.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ], lkN�peg�szs�g�gyiDolgoz�k.[Heti munka�r�k sz�ma], lkN�peg�szs�g�gyiDolgoz�k.[Bet�lt�s ar�nya], lkN�peg�szs�g�gyiDolgoz�k.[Besorol�si fokozat k�d:], lkN�peg�szs�g�gyiDolgoz�k.[Besorol�si fokozat megnevez�se:], lkN�peg�szs�g�gyiDolgoz�k.[�ll�shely azonos�t�], lkN�peg�szs�g�gyiDolgoz�k.[Havi illetm�ny], lkN�peg�szs�g�gyiDolgoz�k.[Eu finansz�rozott], lkN�peg�szs�g�gyiDolgoz�k.[Illetm�ny forr�sa], lkN�peg�szs�g�gyiDolgoz�k.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h], lkN�peg�szs�g�gyiDolgoz�k.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], lkN�peg�szs�g�gyiDolgoz�k.[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)], lkN�peg�szs�g�gyiDolgoz�k.[Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is], lkN�peg�szs�g�gyiDolgoz�k.[�gyf�lszolg�lati munkat�rs (1) �gyf�lszolg�lati h�tt�r munkat�rs], lkN�peg�szs�g�gyiDolgoz�k.[K�pes�t�st ad� v�gzetts�g], IIf([Megyei szint]<>"Megyei szint",[Megyei szint],"") AS [J�r�si hivatal neve], lkV�d�n�k00.V�d�n�, lkV�d�n�k00.[Vezet� v�d�n�], lkV�d�n�k00.CsVSz
FROM lkV�d�n�k00 INNER JOIN lkN�peg�szs�g�gyiDolgoz�k ON lkV�d�n�k00.Ad�azonos�t� = lkN�peg�szs�g�gyiDolgoz�k.Ad�azonos�t�;

-- [lkV�d�n�k02]
SELECT lkV�d�n�k01.Ad�jel, lkV�d�n�k01.Korm�nyhivatal, (Select Count(Tmp.Ad�jel) From lkV�d�n�k01 as Tmp Where Tmp.Ad�jel<=lkV�d�n�k01.Ad�jel) AS Sorsz�m, lkV�d�n�k01.N�v, lkV�d�n�k01.Ad�azonos�t�, lkV�d�n�k01.[Sz�let�si �v \ �res �ll�s], lkV�d�n�k01.[Megyei szint], lkV�d�n�k01.F�oszt�ly, lkV�d�n�k01.Oszt�ly, lkV�d�n�k01.[�NYR SZERVEZETI EGYS�G AZONOS�T�], lkV�d�n�k01.[Ell�tott feladat], lkV�d�n�k01.Kinevez�s, lkV�d�n�k01.[Feladat jellege: szakmai (SZ) / funkcion�lis (F) feladatell�t�s;], lkV�d�n�k01.[Foglalkoztat�si forma teljes (T) / r�szmunkaid�s (R), nyugd�jas ], lkV�d�n�k01.[Heti munka�r�k sz�ma], lkV�d�n�k01.[Bet�lt�s ar�nya], lkV�d�n�k01.[Besorol�si fokozat k�d:], lkV�d�n�k01.[Besorol�si fokozat megnevez�se:], lkV�d�n�k01.[�ll�shely azonos�t�], lkV�d�n�k01.[Havi illetm�ny], lkV�d�n�k01.[Eu finansz�rozott], lkV�d�n�k01.[Illetm�ny forr�sa], lkV�d�n�k01.[Garant�lt b�rminimumban r�szes�l (GB) / tart�s t�voll�v� nincs h], lkV�d�n�k01.[Tart�s t�voll�v� eset�n a t�voll�t jogc�me (CSED, GYED, GYES, Tp], lkV�d�n�k01.[Foglalkoztat�s id�tartama Hat�rozatlan (HL) / Hat�rozott (HT)], lkV�d�n�k01.[Legmagasabb iskolai v�gzetts�g 1=8 oszt�ly; 2=�retts�gi; 3=f�is], lkV�d�n�k01.[�gyf�lszolg�lati munkat�rs (1) �gyf�lszolg�lati h�tt�r munkat�rs], lkV�d�n�k01.[K�pes�t�st ad� v�gzetts�g], lkV�d�n�k01.[J�r�si hivatal neve], lkV�d�n�k01.V�d�n�, lkV�d�n�k01.[Vezet� v�d�n�], lkV�d�n�k01.CsVSz
FROM lkV�d�n�k01;

-- [lkV�gzetts�gek]
SELECT [Dolgoz� azonos�t�]*1 AS Ad�jel, tV�gzetts�gek.*
FROM tV�gzetts�gek;

-- [lkV�gzetts�gekMaxSz�ma]
SELECT Max(lkSzem�lyekV�gzetts�geinekSz�ma.V�gzetts�geinekASz�ma) AS MaxOfV�gzetts�geinekASz�ma
FROM lkSzem�lyekV�gzetts�geinekSz�ma;

-- [lkV�gzetts�g�sBesorol�s�sszeegyeztethetetlen]
SELECT lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.[St�tusz k�dja], lkSzem�lyek.[Iskolai v�gzetts�g foka] AS V�gzetts�g, lkSzem�lyek.[Besorol�si  fokozat (KT)] AS Besorol�s, kt_azNexon_Ad�jel02.NLink
FROM lkSzem�lyek INNER JOIN kt_azNexon_Ad�jel02 ON lkSzem�lyek.Ad�jel = kt_azNexon_Ad�jel02.Ad�jel
WHERE (((lkSzem�lyek.[Iskolai v�gzetts�g foka])="Szakk�z�piskola") AND ((lkSzem�lyek.[Besorol�si  fokozat (KT)])<>"Vezet�-hivatalitan�csos") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkSzem�lyek.[Iskolai v�gzetts�g foka])<>"F�iskolai vagy fels�fok� alapk�pz�s (BA/BsC)okl." And (lkSzem�lyek.[Iskolai v�gzetts�g foka])<>"Egyetemi /fels�fok� (MA/MsC) vagy osztatlan k�pz.") AND ((lkSzem�lyek.[Besorol�si  fokozat (KT)])="Vezet�-hivatalif�tan�csos") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.BFKH, lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkVezet�k]
SELECT DISTINCT lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.[Hivatali email], lkSzem�lyek.[Hivatali telefon], lkSzem�lyek.BFKH, lkSzem�lyek.Besorol�s2
FROM lkSzem�lyek INNER JOIN tBesorol�s_�talak�t� ON lkSzem�lyek.Besorol�s2 = tBesorol�s_�talak�t�.Besorol�si_fokozat
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((tBesorol�s_�talak�t�.Vezet�)=Yes))
ORDER BY lkSzem�lyek.BFKH;

-- [lkVezet�kIlletm�nye01]
SELECT DISTINCT lkSzem�lyek.BFKH, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.F�oszt�ly, lkSzem�lyek.Oszt�ly, lkSzem�lyek.Besorol�s2 AS Besorol�s, lkSzem�lyek.[Vezet�i megb�z�s t�pusa], [Kerek�tett 100 %-os illetm�ny (elt�r�tett)]*[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker]/40 AS [Brutt� illetm�ny]
FROM lkSzem�lyek INNER JOIN tBesorol�s_�talak�t� ON lkSzem�lyek.Besorol�s2 = tBesorol�s_�talak�t�.Besorol�si_fokozat
WHERE (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((tBesorol�s_�talak�t�.Vezet�)=Yes)) OR (((lkSzem�lyek.[Vezet�i megb�z�s t�pusa]) Is Not Null) AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely")) OR (((lkSzem�lyek.[St�tusz neve])="�ll�shely") AND ((Left(Replace(N�([feladatk�r],0),"Lez�rt_",""),2)*1) Between 11 And 14));

-- [lkVezet�kIlletm�nye02]
SELECT lkVezet�kIlletm�nye01.[Dolgoz� teljes neve] AS [Dolgoz� teljes neve], lkVezet�kIlletm�nye01.F�oszt�ly AS F�oszt�ly, lkVezet�kIlletm�nye01.Oszt�ly AS Oszt�ly, lkVezet�kIlletm�nye01.Besorol�s AS Besorol�s, lkVezet�kIlletm�nye01.[Vezet�i megb�z�s t�pusa] AS [Vezet�i megb�z�s t�pusa], lkVezet�kIlletm�nye01.[Brutt� illetm�ny] AS [Brutt� illetm�ny]
FROM lkVezet�kIlletm�nye01
ORDER BY lkVezet�kIlletm�nye01.BFKH;

-- [lkVezet�kSzakvizsgaHi�ny]
SELECT lkMindenVezet�.F�oszt�ly, lkMindenVezet�.Oszt�ly, lkMindenVezet�.[Dolgoz� teljes neve], lkMindenVezet�.Besorol�s2 AS [Besorol�si fokozat], lkK�zigazgat�siVizsga.[Vizsga t�pusa], lkK�zigazgat�siVizsga.[Oklev�l d�tuma], lkK�zigazgat�siVizsga.[Oklev�l sz�ma], lkK�zigazgat�siVizsga.Mentess�g, lkK�zigazgat�siVizsga.[Vizsga let�tel terv hat�rideje], lkK�zigazgat�siVizsga.[Vizsga let�tel t�ny hat�rideje]
FROM lkK�zigazgat�siVizsga RIGHT JOIN lkMindenVezet� ON lkK�zigazgat�siVizsga.Ad�jel = lkMindenVezet�.Ad�jel
WHERE (((lkK�zigazgat�siVizsga.[Vizsga t�pusa])="k�zigazgat�si szakvizsga" Or (lkK�zigazgat�siVizsga.[Vizsga t�pusa]) Is Null) AND ((lkK�zigazgat�siVizsga.[Oklev�l sz�ma]) Is Null Or (lkK�zigazgat�siVizsga.[Oklev�l sz�ma])="") AND ((lkK�zigazgat�siVizsga.Mentess�g)=False Or (lkK�zigazgat�siVizsga.Mentess�g) Is Null));

-- [lkVezet�kTart�sT�voll�ten]
SELECT lkSzem�lyek.F�oszt�ly AS F�oszt�ly, lkSzem�lyek.Oszt�ly AS Oszt�ly, lkSzem�lyek.[Dolgoz� teljes neve] AS N�v, lkSzem�lyek.Besorol�s2 AS Besorol�s, lkSzem�lyek.[Vezet�i beoszt�s megnevez�se] AS Beoszt�s, lkSzem�lyek.[Tart�s t�voll�t t�pusa] AS [T�voll�t t�pusa], kt_azNexon_Ad�jel02.NLink AS NLink
FROM kt_azNexon_Ad�jel02 RIGHT JOIN lkSzem�lyek ON kt_azNexon_Ad�jel02.Ad�jel = lkSzem�lyek.Ad�jel
WHERE (((lkSzem�lyek.[Vezet�i beoszt�s megnevez�se])="f�isp�n") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Not Null) AND ((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null)) OR (((lkSzem�lyek.[Vezet�i beoszt�s megnevez�se]) Like "*igazgat�*") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Not Null) AND ((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null)) OR (((lkSzem�lyek.Besorol�s2) Like "*igazgat�*") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Not Null) AND ((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null)) OR (((lkSzem�lyek.Besorol�s2)="f�isp�n") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Not Null) AND ((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null)) OR (((lkSzem�lyek.[Vezet�i beoszt�s megnevez�se])="oszt�lyvezet�") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Not Null) AND ((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null)) OR (((lkSzem�lyek.Besorol�s2)="oszt�lyvezet�") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Not Null) AND ((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null)) OR (((lkSzem�lyek.[Vezet�i beoszt�s megnevez�se]) Like "*ker�leti*") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Not Null) AND ((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null)) OR (((lkSzem�lyek.Besorol�s2) Like "f�oszt�ly*") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Not Null) AND ((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null)) OR (((lkSzem�lyek.[Vezet�i beoszt�s megnevez�se]) Like "f�oszt�ly*") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Not Null) AND ((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null)) OR (((lkSzem�lyek.Besorol�s2) Like "*ker�leti*") AND ((lkSzem�lyek.[Tart�s t�voll�t t�pusa]) Is Not Null) AND ((lkSzem�lyek.[Szervezeti egys�g k�dja]) Is Not Null))
ORDER BY bfkh(Nz([Szervezeti egys�g k�dja],"-"));

-- [lkVIIKer�letbeBel�p�k]
SELECT lkBel�p�kUni�.[Megyei szint VAGY J�r�si Hivatal] AS Ker�let, lkBel�p�kUni�.N�v, lkBel�p�kUni�.[Jogviszony kezd� d�tuma]
FROM lkBel�p�kUni�
WHERE (((lkBel�p�kUni�.[Megyei szint VAGY J�r�si Hivatal])="Budapest F�v�ros Korm�nyhivatala VII. Ker�leti Hivatala") AND ((lkBel�p�kUni�.[Jogviszony kezd� d�tuma]) Between #7/1/2023# And #7/31/2024#));

-- [lkVIIKer�letb�lKil�pettekHavonta]
SELECT lkKil�p�Uni�.[Megyei szint VAGY J�r�si Hivatal] AS Ker�let, DateSerial(Year([Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]),Month([Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])+1,1)-1 AS T�rgyh�, Sum(1) AS F�
FROM lkKil�p�Uni�
WHERE (((lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek oka: jogszab�lyi hiva]) Not Like "*l�tre*") AND ((lkKil�p�Uni�.[Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]) Between #7/1/2023# And #7/31/2024#))
GROUP BY lkKil�p�Uni�.[Megyei szint VAGY J�r�si Hivatal], DateSerial(Year([Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja]),Month([Jogviszony megsz�n�s�nek, megsz�ntet�s�nek id�pontja])+1,1)-1
HAVING (((lkKil�p�Uni�.[Megyei szint VAGY J�r�si Hivatal])="Budapest F�v�ros Korm�nyhivatala VII. Ker�leti Hivatala"));

-- [lkVIIKer�letiBet�lt�ttL�tsz�m01]
SELECT Replace([J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH") AS [Ker�leti hivatal], tHaviJelent�sHat�lya1.hat�lya, Sum(IIf([Mez�4]="�res �ll�s",0,1)) AS [Bet�lt�tt l�tsz�m], Sum(IIf([Mez�4]="�res �ll�s",1,0)) AS �res
FROM tHaviJelent�sHat�lya1 INNER JOIN tJ�r�si_�llom�ny ON tHaviJelent�sHat�lya1.hat�lyaID = tJ�r�si_�llom�ny.hat�lyaID
GROUP BY Replace([J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH"), tHaviJelent�sHat�lya1.hat�lya
HAVING (((Replace([J�r�si Hivatal],"Budapest F�v�ros Korm�nyhivatala","BFKH"))="BFKH VII. Ker�leti Hivatala") AND ((tHaviJelent�sHat�lya1.hat�lya) Between #7/1/2023# And #7/31/2024#));

-- [lkVIIKer�letiBet�lt�ttL�tsz�m02]
SELECT lkVIIKer�letiBet�lt�ttL�tsz�m01.[Ker�leti hivatal], lkVIIKer�letiBet�lt�ttL�tsz�m01.hat�lya, lkVIIKer�letiBet�lt�ttL�tsz�m01.[Bet�lt�tt l�tsz�m], lkVIIKer�letiBet�lt�ttL�tsz�m01.�res, [Bet�lt�tt l�tsz�m]+[�res] AS Enged�lyezett
FROM lkVIIKer�letiBet�lt�ttL�tsz�m01;

-- [lkVIIKer�letiKimutat�s]
SELECT lkVIIKer�letiBet�lt�ttL�tsz�m02.[Ker�leti hivatal], lkVIIKer�letiBet�lt�ttL�tsz�m02.hat�lya, lkVIIKer�letiBet�lt�ttL�tsz�m02.[Bet�lt�tt l�tsz�m], lkVIIKer�letiBet�lt�ttL�tsz�m02.�res, lkVIIKer�letiBet�lt�ttL�tsz�m02.Enged�lyezett, Nz([F�],0) AS Kil�pettek
FROM lkVIIKer�letb�lKil�pettekHavonta RIGHT JOIN lkVIIKer�letiBet�lt�ttL�tsz�m02 ON lkVIIKer�letb�lKil�pettekHavonta.T�rgyh� = lkVIIKer�letiBet�lt�ttL�tsz�m02.hat�lya;

-- [lkVirtu�lisKorm�nyablak]
SELECT drh�tra(z�rojeltelen�t�([Dolgoz� teljes neve])) AS [Dolgoz� neve], lkSzem�lyek.[Dolgoz� sz�let�si neve], lkSzem�lyek.[Anyja neve], [Sz�let�si hely] & ", " & [Sz�let�si id�] AS [Sz�let�si hely, id�], IIf(Len(Nz([Tart�zkod�si lakc�m],""))<15,[�lland� lakc�m],[Tart�zkod�si lakc�m]) AS Lakhely, lkSzem�lyek.[Ad�azonos�t� jel], lkSzem�lyek.[TAJ sz�m], ffsplit([Utal�si c�m],"|",2) AS Sz�mlasz�m, lkSzem�lyek.[Hivatali email], IIf(Nz([Hivatali telefon],"")="",[Hivatali telefon mell�k],[Hivatali telefon]) AS [Hivatali telefonsz�m], lkSzem�lyek.[Szint 1 szervezeti egys�g n�v], "Budapest" AS [Igazgat�si szerv sz�khelye], lkSzem�lyek.[Vezet� neve], [F�oszt�ly] & "/" & [Oszt�ly] AS [F�oszt�ly, oszt�ly], lkSzem�lyek.[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�t�s n�lk�li)], lkSzem�lyek.[St�tusz k�dja], lkSzem�lyek.[Besorol�si  fokozat (KT)], lkSzem�lyek.FEOR, lkSzem�lyek.Feladatk�r
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)]) Is Null Or (lkSzem�lyek.[Jogviszony v�ge (kil�p�s d�tuma)])>Date()) AND ((lkSzem�lyek.F�oszt�ly) Not Like "*f�oszt�ly*"))
ORDER BY lkSzem�lyek.F�oszt�lyK�d, lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkVirtu�lisKorm�nyablakP�ros�tani]
SELECT drh�tra(z�rojeltelen�t�([Dolgoz� teljes neve])) AS [Dolgoz� neve], lkSzem�lyek.[Dolgoz� sz�let�si neve], lkSzem�lyek.[Anyja neve], [Sz�let�si hely] & ", " & [Sz�let�si id�] AS [Sz�let�si hely, id�], IIf(Len(Nz([Tart�zkod�si lakc�m],""))<15,[�lland� lakc�m],[Tart�zkod�si lakc�m]) AS Lakhely, lkSzem�lyek.[Ad�azonos�t� jel], lkSzem�lyek.[TAJ sz�m], ffsplit([Utal�si c�m],"|",2) AS Sz�mlasz�m, lkSzem�lyek.[Hivatali email], IIf(Nz([Hivatali telefon],"")="",[Hivatali telefon mell�k],[Hivatali telefon]) AS [Hivatali telefonsz�m], lkSzem�lyek.[Szint 1 szervezeti egys�g n�v], "Budapest" AS [Igazgat�si szerv sz�khelye], lkSzem�lyek.[Vezet� neve], [F�oszt�ly] & "/" & [Oszt�ly] AS [F�oszt�ly, oszt�ly], lkSzem�lyek.[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�t�s n�lk�li)], lkSzem�lyek.[St�tusz k�dja], lkSzem�lyek.[Besorol�si  fokozat (KT)], lkSzem�lyek.FEOR, lkSzem�lyek.Feladatk�r
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.F�oszt�ly) Like "*ker�leti hivatal*") AND ((lkSzem�lyek.[St�tusz neve])="�ll�shely"))
ORDER BY lkSzem�lyek.F�oszt�lyK�d, lkSzem�lyek.[Dolgoz� teljes neve];

-- [lkVirtu�lisKorm�nyablakP�ros�tva]
SELECT tVirtu�lisKorm�nyablak.Ker�let, tVirtu�lisKorm�nyablak.[C�lfeladattal megb�zott szem�ly csal�di �s ut�neve], lkVirtu�lisKorm�nyablak.[Dolgoz� neve], lkVirtu�lisKorm�nyablak.[Dolgoz� sz�let�si neve], lkVirtu�lisKorm�nyablak.[Anyja neve], lkVirtu�lisKorm�nyablak.[Sz�let�si hely, id�], lkVirtu�lisKorm�nyablak.Lakhely, lkVirtu�lisKorm�nyablak.[Ad�azonos�t� jel], lkVirtu�lisKorm�nyablak.[TAJ sz�m], lkVirtu�lisKorm�nyablak.Sz�mlasz�m, lkVirtu�lisKorm�nyablak.[Hivatali email], lkVirtu�lisKorm�nyablak.[Hivatali telefonsz�m], lkVirtu�lisKorm�nyablak.[Szint 1 szervezeti egys�g n�v], lkVirtu�lisKorm�nyablak.[Igazgat�si szerv sz�khelye], lkVirtu�lisKorm�nyablak.[Vezet� neve], lkVirtu�lisKorm�nyablak.[F�oszt�ly, oszt�ly], lkVirtu�lisKorm�nyablak.[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�t�s n�lk�li)], lkVirtu�lisKorm�nyablak.[St�tusz k�dja], lkVirtu�lisKorm�nyablak.[Besorol�si  fokozat (KT)], lkVirtu�lisKorm�nyablak.FEOR, lkVirtu�lisKorm�nyablak.Feladatk�r
FROM tVirtu�lisKorm�nyablak LEFT JOIN lkVirtu�lisKorm�nyablak ON tVirtu�lisKorm�nyablak.[C�lfeladattal megb�zott szem�ly csal�di �s ut�neve] = lkVirtu�lisKorm�nyablak.[Dolgoz� neve];

-- [lkVisszajelz�sekKezel�se]
SELECT tBej�v��zenetek.*, tBej�v�Visszajelz�sek.*, tR�giHib�k.lek�rdez�sNeve, tVisszajelz�sT�pusok.Visszajelz�sSz�vege, tR�giHib�k.[Els� Id�pont] AS [Fenn�ll�s kezdete]
FROM tBej�v��zenetek INNER JOIN ((tR�giHib�k INNER JOIN tBej�v�Visszajelz�sek ON tR�giHib�k.[Els� mez�] = tBej�v�Visszajelz�sek.Hash) INNER JOIN tVisszajelz�sT�pusok ON tBej�v�Visszajelz�sek.Visszajelz�sK�d = tVisszajelz�sT�pusok.Visszajelz�sK�d) ON tBej�v��zenetek.az�zenet = tBej�v�Visszajelz�sek.az�zenet
WHERE (((tR�giHib�k.[Utols� Id�pont])=(select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve <>"lk�res�ll�shelyek�llapotfelm�r�" And lek�rdez�sneve <>"lkFontosHi�nyz�Adatok02") Or (tR�giHib�k.[Utols� Id�pont])=(select max([utols� id�pont]) from tR�giHib�k where lek�rdez�sneve ="lkFontosHi�nyz�Adatok02")));

-- [lkVisszajelz�sT�rt�nete]
SELECT lk�zenetekVisszajelz�sek.Hash, lk�zenetekVisszajelz�sek.SenderEmailAddress, tVisszajelz�sT�pusok.Visszajelz�sK�d, tVisszajelz�sT�pusok.Visszajelz�sSz�vege, lk�zenetekVisszajelz�sek.DeliveredDate
FROM lk�zenetekVisszajelz�sek INNER JOIN tVisszajelz�sT�pusok ON lk�zenetekVisszajelz�sek.Visszajelz�sK�d = tVisszajelz�sT�pusok.Visszajelz�sK�d
WHERE (((lk�zenetekVisszajelz�sek.Hash)="15ee45f6766e93397131c751708f6847" Or (lk�zenetekVisszajelz�sek.Hash)="Like [Azonos�t�HASH]"))
ORDER BY lk�zenetekVisszajelz�sek.Hash, lk�zenetekVisszajelz�sek.DeliveredDate;

-- [lkXVIker�leti_k�lt�z�s]
SELECT lkSzem�lyek.[Szervezeti egys�g k�dja], lkSzem�lyek.tSzem�lyek.Ad�jel, lkSzem�lyek.[TAJ sz�m], lkSzem�lyek.[Dolgoz� sz�let�si neve], lkSzem�lyek.[Sz�let�si id�], lkSzem�lyek.[Sz�let�si hely], lkSzem�lyek.[Anyja neve], Replace([�lland� lakc�m],"Magyarorsz�g, ","") AS Lakc�m, lkSzem�lyek.[Munkav�gz�s helye - c�m] AS [Nexon szerinti munkahely], "" AS [�gyint�z� neve], "" AS [�gyint�z� tel], "" AS [�gyint�z� email]
FROM lkSzem�lyek
WHERE (((lkSzem�lyek.[Szervezeti egys�g k�dja])="BFKH.1.2.16.4." Or (lkSzem�lyek.[Szervezeti egys�g k�dja])="BFKH.1.2.16.2." Or (lkSzem�lyek.[Szervezeti egys�g k�dja])="BFKH.1.2.16.1."));

-- [MSyslkLek�rdez�sekT�pusai]
SELECT DISTINCT MSysObjects.Name AS queryName
FROM (MSysQueries INNER JOIN MSysObjects ON MSysQueries.ObjectId = MSysObjects.Id) LEFT JOIN (SELECT * FROM MSysQueries WHERE Attribute=5)  AS src ON MSysQueries.ObjectId = src.ObjectId
WHERE (((MSysObjects.Name)>"~z") AND ((Mid("SelectMakTblAppendUpdateDeleteXtab  AltTblPassThUnion ",([msysqueries]![Flag]-1)*6+1,6))="SELECT" Or (Mid("SelectMakTblAppendUpdateDeleteXtab  AltTblPassThUnion ",([msysqueries]![Flag]-1)*6+1,6))="XTab") AND ((MSysQueries.Attribute)=1))
ORDER BY MSysObjects.Name;

-- [mSyslkMez�nevek]
SELECT IIf([MSysQueries_1].[Name1] Is Null,[MSysQueries_1].[Expression],[MSysQueries_1].[Name1]) AS Mez�N�v, Replace(Replace(utols�(IIf([MSysQueries_1].[Name1] Is Null,[MSysQueries_1].[Expression],[MSysQueries_1].[Name1]),"."),"[",""),"]","") AS Alias, MSysObjects.Name AS QueryName, MSysQueries.Name1, MSysQueries.Attribute, MSysQueries.Flag, MSysQueries_1.Attribute, MSysQueries_1.Flag, MSysQueries.Expression, MSysQueries_1.Expression, MSysQueries.ObjectId
FROM (MSysObjects RIGHT JOIN MSysQueries ON MSysObjects.Id = MSysQueries.ObjectId) LEFT JOIN MSysQueries AS MSysQueries_1 ON MSysQueries.ObjectId = MSysQueries_1.ObjectId
WHERE (((MSysQueries.Attribute)=1) AND ((MSysQueries.Flag)=1 Or (MSysQueries.Flag)=6) AND ((MSysQueries_1.Attribute)=6) AND ((MSysQueries_1.Flag)=0 Or (MSysQueries_1.Flag)=1)) OR (((MSysQueries.Attribute)=0) AND ((MSysQueries_1.Attribute)=6) AND ((MSysQueries_1.Flag)=0 Or (MSysQueries_1.Flag)=1))
ORDER BY MSysObjects.Name, MSysQueries.ObjectId;

-- [Oszt�lyvezet�k �tlagilletm�nye]
SELECT lkOszt�lyvezet�i�ll�shelyek.[Besorol�si  fokozat (KT)], Round(Avg([Illetm�ny])/100,0)*100 AS �tlagilletm�ny
FROM lkOszt�lyvezet�i�ll�shelyek
GROUP BY lkOszt�lyvezet�i�ll�shelyek.[Besorol�si  fokozat (KT)];

-- [oz_lkBel�p�k_Hi�ny2]
SELECT lkBel�p�k_Hi�ny.[Szem�lyn�v] AS N�v, lkBel�p�k_Hi�ny.[Ad�azonos�t�] AS Ad�azonos�t�, lkBel�p�k_Hi�ny.[Szervezeti egys�g] AS Megyei_szint_VAGY_J�r�si_Hivatal, lkBel�p�k_Hi�ny.[Szervezeti egys�g] AS Szervezeti_egys�gF�oszt�ly_megnevez�se, lkBel�p�k_Hi�ny.[Szervezeti egys�g] AS Szervezeti_egys�gOszt�ly_megnevez�se, lkBel�p�k_Hi�ny.[Szervezeti egys�g] AS �NYR_SZERVEZETI_EGYS�G_AZONOS�T�, lkBel�p�k_Hi�ny.[Ell�tand� feladat] AS Ell�tott_feladatok_megjel�l�sea_f�v�rosi_�s_megyei_korm�nyhi, lkBel�p�k_Hi�ny.[�ll�shely azonos�t�] AS �ll�shely_azonos�t�, lkBel�p�k_Hi�ny.[Kinevez�s kezdete] AS Jogviszony_kezd�_d�tuma, lkBel�p�k_Hi�ny.[Szerz�d�s_kinevez�s t�pusa] AS Foglalkoztat�s_id�tartama_Hat�rozatlan__HL____Hat�rozott__HT_, lkBel�p�k_Hi�ny.[Illetm�ny] AS Illetm�ny__Ft_h�_, lkBel�p�k_Hi�ny.[-] AS Szervezti_alapl�tsz�m__A_K�zpontos�tott_�ll�shely__K_, lkBel�p�k_Hi�ny.[Illetm�ny2] AS Illetm�ny754
FROM lkBel�p�k_Hi�ny;

-- [oz_lkHat�rozottak_Hi�ny2]
SELECT lkHat�rozottak_Hi�ny.[Szem�lyn�v] AS Tart�s_t�voll�v�_neve, lkHat�rozottak_Hi�ny.[Ad�azonos�t�] AS Ad�azonos�t�_tt, lkHat�rozottak_Hi�ny.[Szervezeti egys�g] AS Megyei_szint_VAGY_J�r�si_Hivatal, lkHat�rozottak_Hi�ny.[Szervezeti egys�g] AS Szervezeti_egys�gF�oszt�ly_megnevez�se, lkHat�rozottak_Hi�ny.[Szervezeti egys�g] AS Szervezeti_egys�gOszt�ly_megnevez�se, lkHat�rozottak_Hi�ny.[Szervezeti egys�g] AS �NYR_SZERVEZETI_EGYS�G_AZONOS�T�, lkHat�rozottak_Hi�ny.[Ell�tand� feladat] AS Ell�tott_feladatok_megjel�l�sea_f�v�rosi_�s_megyei_korm�nyhi, lkHat�rozottak_Hi�ny.[�ll�shely azonos�t�] AS �ll�shely_azonos�t�, lkHat�rozottak_Hi�ny.[Tart�s t�voll�t t�pusa] AS Tart�s_t�voll�v�_eset�n_a_t�voll�t_jogc�me__CSED__GYED__GYES, lkHat�rozottak_Hi�ny.[Tart�s t�voll�t �rv.kezdete] AS Tart�s_t�voll�t_kezdete, lkHat�rozottak_Hi�ny.[Tart�s t�voll�t �rv.v�ge] AS Tart�s_t�voll�t_v�rhat�_v�ge, lkHat�rozottak_Hi�ny.[Illetm�ny] AS Tart�san_t�voll�v�_illetm�ny�nek_teljes_�sszege, lkHat�rozottak_Hi�ny.[-] AS Tart�s_t�voll�v�_�ll�shely�n_hat�rozott_id�re_foglalkoztatot, lkHat�rozottak_Hi�ny.[Ad�azonos�t�] AS Ad�azonos�t�_tth, lkHat�rozottak_Hi�ny.[Szervezeti egys�g] AS Megyei_szint_VAGY_J�r�si_Hivatal164, lkHat�rozottak_Hi�ny.[Szervezeti egys�g] AS Szervezeti_egys�gF�oszt�ly_megnevez�se243, lkHat�rozottak_Hi�ny.[Szervezeti egys�g] AS Szervezeti_egys�gOszt�ly_megnevez�se328, lkHat�rozottak_Hi�ny.[Szervezeti egys�g] AS �NYR_SZERVEZETI_EGYS�G_AZONOS�T�411, lkHat�rozottak_Hi�ny.[Ell�tand� feladat] AS Ell�tott_feladatok_megjel�l�sea_f�v�rosi_�s_megyei_korm�nyhi490, lkHat�rozottak_Hi�ny.[�ll�shely azonos�t�] AS �ll�shely_azonos�t�599, lkHat�rozottak_Hi�ny.[Hat.Id� kezdete] AS Tart�s_t�voll�v�_st�tusz�n_foglalkoztatott_hat�rozott_idej�_, lkHat�rozottak_Hi�ny.[Hat.Id� lej�rta] AS Tart�s_t�voll�v�_st�tusz�n_foglalkoztatott_hat�rozott_idej�_1691, lkHat�rozottak_Hi�ny.[Illetm�ny] AS Tart�s_t�voll�v�_st�tusz�n_foglalkoztatott_illetm�ny�nek_tel
FROM lkHat�rozottak_Hi�ny;

-- [oz_lkJ�r�si_Hi�ny2]
SELECT lkJ�r�si_Hi�ny.[Szem�lyn�v] AS N�v, lkJ�r�si_Hi�ny.[Ad�azonos�t�] AS Ad�azonos�t�, lkJ�r�si_Hi�ny.[Sz�let�si id�] AS Sz�let�si_�v__�res_�ll�s__�res_�ll�s, lkJ�r�si_Hi�ny.[Nem] AS Dolgoz�_neme1_f�rfi2_n�, lkJ�r�si_Hi�ny.[Szervezeti egys�g] AS J�r�si_Hivatal, lkJ�r�si_Hi�ny.[Szervezeti egys�g] AS Szervezeti_egys�gOszt�ly_megnevez�se, lkJ�r�si_Hi�ny.[Szervezeti egys�g] AS �NYR_SZERVEZETI_EGYS�G_AZONOS�T�, lkJ�r�si_Hi�ny.[Ell�tand� feladat] AS Ell�tott_feladatok_megjel�l�sea_f�v�rosi_�s_megyei_korm�nyhi, lkJ�r�si_Hi�ny.[Kinevez�s kezdete] AS Kinevez�s_d�tuma�ll�shely_meg�resed�s�nek_d�tuma_most_ell�to, lkJ�r�si_Hi�ny.[Ell�tand� feladat jellege] AS Feladat_jellege__szakmai__SZ____funkcion�lis__F__feladatell�, lkJ�r�si_Hi�ny.[Foglalkoz�si viszony (Besorol�s t�pusa)] AS Foglalkoztat�si_forma_teljes__T____r�szmunkaid�s__R___nyugd�, lkJ�r�si_Hi�ny.[Heti �rakeret] AS Heti_munka�r�k_sz�ma, lkJ�r�si_Hi�ny.[-] AS �ll�shely_bet�lt�s�nek_ar�nya_�s�res_�ll�shely_bet�lt�s_ar�nya, lkJ�r�si_Hi�ny.[-] AS Besorol�si_fokozat_k�d_, lkJ�r�si_Hi�ny.[Besorol�si fokozat] AS Besorol�si_fokozat_megnevez�se_, lkJ�r�si_Hi�ny.[�ll�shely azonos�t�] AS �ll�shely_azonos�t�, lkJ�r�si_Hi�ny.[Illetm�ny] AS Havi_illetm�ny_teljes_�sszege__kerek�tve__FT_, lkJ�r�si_Hi�ny.[Szerz�d�s_kinevez�s t�pusa] AS Foglalkoztat�s_id�tartama_Hat�rozatlan__HL____Hat�rozott__HT_, lkJ�r�si_Hi�ny.[Legmagasabb fok� v�gzetts�ge] AS Legmagasabb_iskolai_v�gzetts�g_1_8__oszt�ly__2_�retts�gi__3_, lkJ�r�si_Hi�ny.[K�pes�t�st ad� v�gzetts�g] AS K�pes�t�st_ad�_v�gzetts�g_megnevez�se__az_az_egy_ami_a_felad
FROM lkJ�r�si_Hi�ny;

-- [oz_lkKil�p�k_Hi�ny2]
SELECT lkKil�p�k_Hi�ny.[Szem�lyn�v] AS N�v, lkKil�p�k_Hi�ny.[Ad�azonos�t�] AS Ad�azonos�t�, lkKil�p�k_Hi�ny.[Szervezeti egys�g] AS Megyei_szint_VAGY_J�r�si_Hivatal, lkKil�p�k_Hi�ny.[Szervezeti egys�g] AS Szervezeti_egys�gF�oszt�ly_megnevez�se, lkKil�p�k_Hi�ny.[Szervezeti egys�g] AS Szervezeti_egys�gOszt�ly_megnevez�se, lkKil�p�k_Hi�ny.[Szervezeti egys�g] AS �NYR_SZERVEZETI_EGYS�G_AZONOS�T�, lkKil�p�k_Hi�ny.[Ell�tand� feladat] AS Ell�tott_feladatok_megjel�l�sea_f�v�rosi_�s_megyei_korm�nyhi, lkKil�p�k_Hi�ny.[�ll�shely azonos�t�] AS �ll�shely_azonos�t�, lkKil�p�k_Hi�ny.[Jogviszony megsz�n�s indoka] AS Jogviszony_megsz�n�s�nek__megsz�ntet�s�nek_oka__jogszab�lyi_, lkKil�p�k_Hi�ny.[Kinevez�s kezdete] AS Jogviszony_kezd�_d�tuma, lkKil�p�k_Hi�ny.[Kinevez�s v�ge] AS Jogviszony_megsz�n�s�nek__megsz�ntet�s�nek_id�pontja, lkKil�p�k_Hi�ny.[Illetm�ny] AS Illetm�ny__Ft_h�_, lkKil�p�k_Hi�ny.[-] AS Szervezti_alapl�tsz�m__A_K�zpontos�tott_�ll�shely__K_
FROM lkKil�p�k_Hi�ny;

-- [oz_lkKorm�nyhivatali_Hi�ny2]
SELECT lkKorm�nyhivatali_Hi�ny.[Szem�lyn�v] AS N�v, lkKorm�nyhivatali_Hi�ny.[Ad�azonos�t�] AS Ad�azonos�t�, lkKorm�nyhivatali_Hi�ny.[Sz�let�si id�] AS Sz�let�si_�v__�res_�ll�s, lkKorm�nyhivatali_Hi�ny.[Nem] AS Dolgoz�_neme1_f�rfi2_n�, lkKorm�nyhivatali_Hi�ny.[Szervezeti egys�g] AS Szervezeti_egys�gF�oszt�ly_megnevez�se, lkKorm�nyhivatali_Hi�ny.[Szervezeti egys�g] AS Szervezeti_egys�gOszt�ly_megnevez�se, lkKorm�nyhivatali_Hi�ny.[Szervezeti egys�g] AS �NYR_SZERVEZETI_EGYS�G_AZONOS�T�, lkKorm�nyhivatali_Hi�ny.[Ell�tand� feladat] AS Ell�tott_feladatok_megjel�l�sea_f�v�rosi_�s_megyei_korm�nyhi, lkKorm�nyhivatali_Hi�ny.[Kinevez�s kezdete] AS Kinevez�s_d�tuma�ll�shely_meg�resed�s�nek_d�tuma_most_ell�to, lkKorm�nyhivatali_Hi�ny.[Ell�tand� feladat jellege] AS Feladat_jellege__szakmai__SZ____funkcion�lis__F__feladatell�, lkKorm�nyhivatali_Hi�ny.[Foglalkoz�si viszony (Besorol�s t�pusa)] AS Foglalkoztat�si_forma_teljes__T____r�szmunkaid�s__R___nyugd�, lkKorm�nyhivatali_Hi�ny.[Heti �rakeret] AS Heti_munka�r�k_sz�ma, lkKorm�nyhivatali_Hi�ny.[�ll�shely azonos�t�] AS �ll�shely_bet�lt�s�nek_ar�nya_�s�res_�ll�shely_bet�lt�s_ar�nya, lkKorm�nyhivatali_Hi�ny.[Besorol�si fokozat] AS Besorol�si_fokozat_megnevez�se_, lkKorm�nyhivatali_Hi�ny.[�ll�shely azonos�t�] AS �ll�shely_azonos�t�, lkKorm�nyhivatali_Hi�ny.[Illetm�ny] AS Havi_illetm�ny_teljes_�sszege__kerek�tve__FT_, lkKorm�nyhivatali_Hi�ny.[Szerz�d�s_kinevez�s t�pusa] AS Foglalkoztat�s_id�tartama_Hat�rozatlan__HL____Hat�rozott__HT_, lkKorm�nyhivatali_Hi�ny.[Legmagasabb fok� v�gzetts�ge] AS Legmagasabb_iskolai_v�gzetts�g_1_8__oszt�ly__2_�retts�gi__3_, lkKorm�nyhivatali_Hi�ny.[K�pes�t�st ad� v�gzetts�g] AS K�pes�t�st_ad�_v�gzetts�g_megnevez�se__az_az_egy_ami_a_felad
FROM lkKorm�nyhivatali_Hi�ny;

-- [oz_lkK�zpontos�tottak_Hi�ny2]
SELECT lkK�zpontos�tottak_Hi�ny.[Szem�lyn�v] AS N�v, lkK�zpontos�tottak_Hi�ny.[Ad�azonos�t�] AS Ad�azonos�t�, lkK�zpontos�tottak_Hi�ny.[Sz�let�si id�] AS Sz�let�si_�v__�res_�ll�s, lkK�zpontos�tottak_Hi�ny.[Szervezeti egys�g] AS Megyei_szint_VAGY_J�r�si_Hivatal, lkK�zpontos�tottak_Hi�ny.[Szervezeti egys�g] AS Szervezeti_egys�gF�oszt�ly_megnevez�se, lkK�zpontos�tottak_Hi�ny.[Szervezeti egys�g] AS Szervezeti_egys�gOszt�ly_megnevez�se, lkK�zpontos�tottak_Hi�ny.[Szervezeti egys�g] AS Nexon_sz�t�relemnek_megfelel�_szervezeti_egys�g_azonos�t�, lkK�zpontos�tottak_Hi�ny.[Ell�tand� feladat] AS Ell�tott_feladatok_megjel�l�sea_f�v�rosi_�s_megyei_korm�nyhi, lkK�zpontos�tottak_Hi�ny.[Kinevez�s kezdete] AS Kinevez�s_d�tuma�ll�shely_meg�resed�s�nek_d�tuma_most_ell�to, lkK�zpontos�tottak_Hi�ny.[Foglalkoz�si viszony (Besorol�s t�pusa)] AS Foglalkoztat�si_forma_teljes__T____r�szmunkaid�s__R___nyugd�, lkK�zpontos�tottak_Hi�ny.[-] AS �ll�shely_bet�lt�s�nek_ar�nya_�s�res_�ll�shely_bet�lt�s_ar�nya, lkK�zpontos�tottak_Hi�ny.[-] AS Besorol�si_fokozat_k�d_, lkK�zpontos�tottak_Hi�ny.[Besorol�si fokozat] AS Besorol�si_fokozat_megnevez�se_, lkK�zpontos�tottak_Hi�ny.[�ll�shely azonos�t�] AS �ll�shely_azonos�t�, lkK�zpontos�tottak_Hi�ny.[Illetm�ny] AS Havi_illetm�ny_teljes_�sszege__kerek�tve__FT_, lkK�zpontos�tottak_Hi�ny.[Szerz�d�s_kinevez�s t�pusa] AS Foglalkoztat�s_id�tartama_Hat�rozatlan__HL____Hat�rozott__HT_, lkK�zpontos�tottak_Hi�ny.[Legmagasabb fok� v�gzetts�ge] AS Legmagasabb_iskolai_v�gzetts�g_1_8__oszt�ly__2_�retts�gi__3_
FROM lkK�zpontos�tottak_Hi�ny;

-- [parlkEllen�rz�Lek�rdez�sek]
SELECT lkEllen�rz�Lek�rdez�sek3.Fejezetsorrend, lkEllen�rz�Lek�rdez�sek3.Leksorrend, lkEllen�rz�Lek�rdez�sek3.Ellen�rz�Lek�rdez�s, lkEllen�rz�Lek�rdez�sek3.LapN�v, lkEllen�rz�Lek�rdez�sek3.Oszt�ly, lkEllen�rz�Lek�rdez�sek3.Megjegyz�s, lkEllen�rz�Lek�rdez�sek3.T�blac�m, lkEllen�rz�Lek�rdez�sek3.vaneGraf, lkEllen�rz�Lek�rdez�sek3.azET�pus, lkEllen�rz�Lek�rdez�sek3.Kimenet, lkEllen�rz�Lek�rdez�sek3.KellVisszajelzes, lkEllen�rz�Lek�rdez�sek3.azUnion, lkEllen�rz�Lek�rdez�sek3.T�blaMegjegyz�s, lkEllen�rz�Lek�rdez�sek3.azHibaCsoport
FROM lkEllen�rz�Lek�rdez�sek3
WHERE (((lkEllen�rz�Lek�rdez�sek3.Oszt�ly)=[qWhere]) AND ((lkEllen�rz�Lek�rdez�sek3.Kimenet)=True))
ORDER BY lkEllen�rz�Lek�rdez�sek3.Fejezetsorrend, lkEllen�rz�Lek�rdez�sek3.Leksorrend;

-- [Szervezeti egys�gek pivot]
PARAMETERS �ss�l_egy_entert Long;
TRANSFORM First(lkF�oszt�lyokOszt�lyokSorsz�mmal.Oszt�ly) AS FirstOfOszt�ly
SELECT lkF�oszt�lyokOszt�lyokSorsz�mmal.F�oszt�ly
FROM lkF�oszt�lyokOszt�lyokSorsz�mmal
WHERE (((lkF�oszt�lyokOszt�lyokSorsz�mmal.bfkhk�d) Like "BFKH*"))
GROUP BY lkF�oszt�lyokOszt�lyokSorsz�mmal.F�oszt�ly
PIVOT lkF�oszt�lyokOszt�lyokSorsz�mmal.Sorsz In (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21);

-- [temp]
PARAMETERS [__Sorsz�m] Value;
SELECT DISTINCTROW *
FROM ktSzervezetTelephely AS lkTelephelyek
WHERE ((([__Sorsz�m])=[azTelephely]));

-- [tHaviJelent�sHat�lya]
SELECT tHaviJelent�sHat�lya1.*
FROM tHaviJelent�sHat�lya1;

-- [tJav�tand�Mez�nevek]
SELECT tJav_mez�k.azJav�tand�, tJav_mez�k.tT�bl�k_azonos�t�, tJav_t�bl�k.T�bla, tJav_t�bl�k.Ellen�rz�shez, tJav_mez�k.azNexonMez�k, tJav_mez�k.Eredeti, tNexonMez�k.[nexon mez� megnevez�se] AS Import, tJav_mez�k.T�bl�nBel�liSorsz�ma, tJav_mez�k.NemK�telez�, tJav_mez�k.NemK�telez��res�ll�shelyEset�n, tJav_t�bl�k.SzervezetK�d_mez�, tJav_mez�k.Sz�veg, tNexonMez�k.Megjegyz�s AS El�r�s, tJav_t�bl�k.�res�ll�shelyMez�k
FROM tJav_t�bl�k INNER JOIN (tJav_mez�k LEFT JOIN tNexonMez�k ON tJav_mez�k.azNexonMez�k = tNexonMez�k.azNexonMez�) ON tJav_t�bl�k.k�d = tJav_mez�k.tT�bl�k_azonos�t�;

-- [tkDolgoz�kV�gzetts�geiFelsorol�s01]
SELECT lkDolgoz�kV�gzetts�geiFelsorol�s01.V�gzetts�geinekASz�ma, lkDolgoz�kV�gzetts�geiFelsorol�s01.Ad�jel, lkDolgoz�kV�gzetts�geiFelsorol�s01.[V�gzetts�g neve], lkDolgoz�kV�gzetts�geiFelsorol�s01.Azonos�t�k INTO tDolgoz�kV�gzetts�geiFelsorol�s01
FROM lkDolgoz�kV�gzetts�geiFelsorol�s01;

-- [tkDolgoz�kV�gzetts�geiFelsorol�s02]
SELECT lkDolgoz�kV�gzetts�geiFelsorol�s02.Sorsz�m, lkDolgoz�kV�gzetts�geiFelsorol�s02.V�gzetts�geinekASz�ma, lkDolgoz�kV�gzetts�geiFelsorol�s02.Ad�jel, lkDolgoz�kV�gzetts�geiFelsorol�s02.[V�gzetts�g neve] INTO tDolgoz�kV�gzetts�geiFelsorol�s02
FROM lkDolgoz�kV�gzetts�geiFelsorol�s02;

-- [tlk tNexonAzonos�t�k - azonosak keres�se]
DELETE tNexonAzonos�t�k.Azonos�t�
FROM tNexonAzonos�t�k
WHERE (((tNexonAzonos�t�k.Azonos�t�) In (Select FirstOfAzonos�t� From [tNexonAzonos�t�k - azonosak keres�se])));

-- [tmp01]
SELECT tSzem�lyek_Import.Ad�jel AS Ad�jel, tSzem�lyek_Import.[Dolgoz� teljes neve] AS [Dolgoz� teljes neve], tSzem�lyek_Import.[Dolgoz� sz�let�si neve] AS [Dolgoz� sz�let�si neve], tSzem�lyek_Import.[Sz�let�si id�] AS [Sz�let�si id�], tSzem�lyek_Import.[Sz�let�si hely] AS [Sz�let�si hely], tSzem�lyek_Import.[Anyja neve] AS [Anyja neve], tSzem�lyek_Import.Neme AS Neme, tSzem�lyek_Import.T�rzssz�m AS T�rzssz�m, tSzem�lyek_Import.[Egyedi azonos�t�] AS [Egyedi azonos�t�], tSzem�lyek_Import.[Ad�azonos�t� jel] AS [Ad�azonos�t� jel], tSzem�lyek_Import.[TAJ sz�m] AS [TAJ sz�m], tSzem�lyek_Import.[�gyf�lkapu k�d] AS [�gyf�lkapu k�d], tSzem�lyek_Import.[Els�dleges �llampolg�rs�g] AS [Els�dleges �llampolg�rs�g], tSzem�lyek_Import.[Szem�lyi igazolv�ny sz�ma] AS [Szem�lyi igazolv�ny sz�ma], tSzem�lyek_Import.[Szem�lyi igazolv�ny �rv�nyess�g kezdete] AS [Szem�lyi igazolv�ny �rv�nyess�g kezdete], tSzem�lyek_Import.[Szem�lyi igazolv�ny �rv�nyess�g v�ge] AS [Szem�lyi igazolv�ny �rv�nyess�g v�ge], tSzem�lyek_Import.[Nyelvtud�s Angol] AS [Nyelvtud�s Angol], tSzem�lyek_Import.[Nyelvtud�s Arab] AS [Nyelvtud�s Arab], tSzem�lyek_Import.[Nyelvtud�s Bolg�r] AS [Nyelvtud�s Bolg�r], tSzem�lyek_Import.[Nyelvtud�s Cig�ny] AS [Nyelvtud�s Cig�ny], tSzem�lyek_Import.[Nyelvtud�s Cig�ny (lov�ri)] AS [Nyelvtud�s Cig�ny (lov�ri)], tSzem�lyek_Import.[Nyelvtud�s Cseh] AS [Nyelvtud�s Cseh], tSzem�lyek_Import.[Nyelvtud�s Eszperant�] AS [Nyelvtud�s Eszperant�], tSzem�lyek_Import.[Nyelvtud�s Finn] AS [Nyelvtud�s Finn], tSzem�lyek_Import.[Nyelvtud�s Francia] AS [Nyelvtud�s Francia], tSzem�lyek_Import.[Nyelvtud�s H�ber] AS [Nyelvtud�s H�ber], tSzem�lyek_Import.[Nyelvtud�s Holland] AS [Nyelvtud�s Holland], tSzem�lyek_Import.[Nyelvtud�s Horv�t] AS [Nyelvtud�s Horv�t], tSzem�lyek_Import.[Nyelvtud�s Jap�n] AS [Nyelvtud�s Jap�n], tSzem�lyek_Import.[Nyelvtud�s Jelnyelv] AS [Nyelvtud�s Jelnyelv], tSzem�lyek_Import.[Nyelvtud�s K�nai] AS [Nyelvtud�s K�nai], tSzem�lyek_Import.[Nyelvtud�s Latin] AS [Nyelvtud�s Latin], tSzem�lyek_Import.[Nyelvtud�s Lengyel] AS [Nyelvtud�s Lengyel], tSzem�lyek_Import.[Nyelvtud�s N�met] AS [Nyelvtud�s N�met], tSzem�lyek_Import.[Nyelvtud�s Norv�g] AS [Nyelvtud�s Norv�g], tSzem�lyek_Import.[Nyelvtud�s Olasz] AS [Nyelvtud�s Olasz], tSzem�lyek_Import.[Nyelvtud�s Orosz] AS [Nyelvtud�s Orosz], tSzem�lyek_Import.[Nyelvtud�s Portug�l] AS [Nyelvtud�s Portug�l], tSzem�lyek_Import.[Nyelvtud�s Rom�n] AS [Nyelvtud�s Rom�n], tSzem�lyek_Import.[Nyelvtud�s Spanyol] AS [Nyelvtud�s Spanyol], tSzem�lyek_Import.[Nyelvtud�s Szerb] AS [Nyelvtud�s Szerb], tSzem�lyek_Import.[Nyelvtud�s Szlov�k] AS [Nyelvtud�s Szlov�k], tSzem�lyek_Import.[Nyelvtud�s Szlov�n] AS [Nyelvtud�s Szlov�n], tSzem�lyek_Import.[Nyelvtud�s T�r�k] AS [Nyelvtud�s T�r�k], tSzem�lyek_Import.[Nyelvtud�s �jg�r�g] AS [Nyelvtud�s �jg�r�g], tSzem�lyek_Import.[Nyelvtud�s Ukr�n] AS [Nyelvtud�s Ukr�n], tSzem�lyek_Import.[Orvosi vizsg�lat id�pontja] AS [Orvosi vizsg�lat id�pontja], tSzem�lyek_Import.[Orvosi vizsg�lat t�pusa] AS [Orvosi vizsg�lat t�pusa], tSzem�lyek_Import.[Orvosi vizsg�lat eredm�nye] AS [Orvosi vizsg�lat eredm�nye], tSzem�lyek_Import.[Orvosi vizsg�lat �szrev�telek] AS [Orvosi vizsg�lat �szrev�telek], tSzem�lyek_Import.[Orvosi vizsg�lat k�vetkez� id�pontja] AS [Orvosi vizsg�lat k�vetkez� id�pontja], tSzem�lyek_Import.[Erk�lcsi bizony�tv�ny sz�ma] AS [Erk�lcsi bizony�tv�ny sz�ma], tSzem�lyek_Import.[Erk�lcsi bizony�tv�ny d�tuma] AS [Erk�lcsi bizony�tv�ny d�tuma], tSzem�lyek_Import.[Erk�lcsi bizony�tv�ny eredm�nye] AS [Erk�lcsi bizony�tv�ny eredm�nye], tSzem�lyek_Import.[Erk�lcsi bizony�tv�ny k�relem azonos�t�] AS [Erk�lcsi bizony�tv�ny k�relem azonos�t�], tSzem�lyek_Import.[Erk�lcsi bizony�tv�ny k�z�gyekt�l eltiltva] AS [Erk�lcsi bizony�tv�ny k�z�gyekt�l eltiltva], tSzem�lyek_Import.[Erk�lcsi bizony�tv�ny j�rm�vezet�st�l eltiltva] AS [Erk�lcsi bizony�tv�ny j�rm�vezet�st�l eltiltva], tSzem�lyek_Import.[Erk�lcsi bizony�tv�ny int�zked�s alatt �ll] AS [Erk�lcsi bizony�tv�ny int�zked�s alatt �ll], tSzem�lyek_Import.[Munkak�ri le�r�sok (csatolt dokumentumok f�jlnevei)] AS [Munkak�ri le�r�sok (csatolt dokumentumok f�jlnevei)], tSzem�lyek_Import.[Egy�b HR dokumentumok (csatolt dokumentumok f�jlnevei)] AS [Egy�b HR dokumentumok (csatolt dokumentumok f�jlnevei)], tSzem�lyek_Import.[Korm�nyhivatal r�vid neve] AS [Korm�nyhivatal r�vid neve], tSzem�lyek_Import.[Szervezeti egys�g k�dja] AS [Szervezeti egys�g k�dja], tSzem�lyek_Import.[Szervezeti egys�g neve] AS [Szervezeti egys�g neve], tSzem�lyek_Import.[Szervezeti munkak�r neve] AS [Szervezeti munkak�r neve], tSzem�lyek_Import.[Vezet�i megb�z�s t�pusa] AS [Vezet�i megb�z�s t�pusa], tSzem�lyek_Import.[St�tusz k�dja] AS [St�tusz k�dja], tSzem�lyek_Import.[St�tusz k�lts�ghely�nek k�dja] AS [St�tusz k�lts�ghely�nek k�dja], tSzem�lyek_Import.[St�tusz k�lts�ghely�nek neve ] AS [St�tusz k�lts�ghely�nek neve ], tSzem�lyek_Import.[L�tsz�mon fel�l l�trehozott st�tusz] AS [L�tsz�mon fel�l l�trehozott st�tusz], tSzem�lyek_Import.[St�tusz t�pusa] AS [St�tusz t�pusa], tSzem�lyek_Import.[St�tusz neve] AS [St�tusz neve], tSzem�lyek_Import.[T�bbes bet�lt�s] AS [T�bbes bet�lt�s], tSzem�lyek_Import.[Vezet� neve] AS [Vezet� neve], tSzem�lyek_Import.[Vezet� ad�azonos�t� jele] AS [Vezet� ad�azonos�t� jele], tSzem�lyek_Import.[Vezet� email c�me] AS [Vezet� email c�me], tSzem�lyek_Import.[�lland� lakc�m] AS [�lland� lakc�m], tSzem�lyek_Import.[Tart�zkod�si lakc�m] AS [Tart�zkod�si lakc�m], tSzem�lyek_Import.[Levelez�si c�m_] AS [Levelez�si c�m_], tSzem�lyek_Import.[�regs�gi nyugd�j-korhat�r el�r�s�nek id�pontja (d�tum)] AS [�regs�gi nyugd�j-korhat�r el�r�s�nek id�pontja (d�tum)], tSzem�lyek_Import.Nyugd�jas AS Nyugd�jas, tSzem�lyek_Import.[Nyugd�j t�pusa] AS [Nyugd�j t�pusa], tSzem�lyek_Import.[Nyugd�jas kor� tov�bbfoglalkoztat�si enged�llyel rendelkezik] AS [Nyugd�jas kor� tov�bbfoglalkoztat�si enged�llyel rendelkezik], tSzem�lyek_Import.[Megv�ltozott munkak�pess�g] AS [Megv�ltozott munkak�pess�g], tSzem�lyek_Import.[�nk�ntes tartal�kos katona] AS [�nk�ntes tartal�kos katona], tSzem�lyek_Import.[Utols� vagyonnyilatkozat lead�s�nak d�tuma] AS [Utols� vagyonnyilatkozat lead�s�nak d�tuma], tSzem�lyek_Import.[Vagyonnyilatkozat nyilv�ntart�si sz�ma] AS [Vagyonnyilatkozat nyilv�ntart�si sz�ma], tSzem�lyek_Import.[K�vetkez� vagyonnyilatkozat esed�kess�ge] AS [K�vetkez� vagyonnyilatkozat esed�kess�ge], tSzem�lyek_Import.[Nemzetbiztons�gi ellen�rz�s d�tuma] AS [Nemzetbiztons�gi ellen�rz�s d�tuma], tSzem�lyek_Import.[V�dett �llom�nyba tartoz� munkak�r] AS [V�dett �llom�nyba tartoz� munkak�r], tSzem�lyek_Import.[Vezet�i megb�z�s t�pusa1] AS [Vezet�i megb�z�s t�pusa1], tSzem�lyek_Import.[Vezet�i beoszt�s megnevez�se] AS [Vezet�i beoszt�s megnevez�se], tSzem�lyek_Import.[Vezet�i beoszt�s (megb�z�s) kezdete] AS [Vezet�i beoszt�s (megb�z�s) kezdete], tSzem�lyek_Import.[Vezet�i beoszt�s (megb�z�s) v�ge] AS [Vezet�i beoszt�s (megb�z�s) v�ge], tSzem�lyek_Import.[Iskolai v�gzetts�g foka] AS [Iskolai v�gzetts�g foka], tSzem�lyek_Import.[Iskolai v�gzetts�g neve] AS [Iskolai v�gzetts�g neve], tSzem�lyek_Import.[Alapvizsga k�telez�s d�tuma] AS [Alapvizsga k�telez�s d�tuma], tSzem�lyek_Import.[Alapvizsga let�tel t�nyleges hat�rideje] AS [Alapvizsga let�tel t�nyleges hat�rideje], tSzem�lyek_Import.[Alapvizsga mentess�g] AS [Alapvizsga mentess�g], tSzem�lyek_Import.[Alapvizsga mentess�g oka] AS [Alapvizsga mentess�g oka], tSzem�lyek_Import.[Szakvizsga k�telez�s d�tuma] AS [Szakvizsga k�telez�s d�tuma], tSzem�lyek_Import.[Szakvizsga let�tel t�nyleges hat�rideje] AS [Szakvizsga let�tel t�nyleges hat�rideje], tSzem�lyek_Import.[Szakvizsga mentess�g] AS [Szakvizsga mentess�g], tSzem�lyek_Import.[Foglalkoz�si viszony] AS [Foglalkoz�si viszony], tSzem�lyek_Import.[Foglalkoz�si viszony statisztikai besorol�sa] AS [Foglalkoz�si viszony statisztikai besorol�sa], tSzem�lyek_Import.[Dolgoz� szerz�d�ses/kinevez�ses munkak�re / kinevez�si okm�nyban] AS [Dolgoz� szerz�d�ses/kinevez�ses munkak�re / kinevez�si okm�nyban], tSzem�lyek_Import.[Beoszt�stervez�s helysz�nek] AS [Beoszt�stervez�s helysz�nek], tSzem�lyek_Import.[Beoszt�stervez�s tev�kenys�gek] AS [Beoszt�stervez�s tev�kenys�gek], tSzem�lyek_Import.[R�szleges t�vmunka szerz�d�s kezdete] AS [R�szleges t�vmunka szerz�d�s kezdete], tSzem�lyek_Import.[R�szleges t�vmunka szerz�d�s v�ge] AS [R�szleges t�vmunka szerz�d�s v�ge], tSzem�lyek_Import.[R�szleges t�vmunka szerz�d�s intervalluma] AS [R�szleges t�vmunka szerz�d�s intervalluma], tSzem�lyek_Import.[R�szleges t�vmunka szerz�d�s m�rt�ke] AS [R�szleges t�vmunka szerz�d�s m�rt�ke], tSzem�lyek_Import.[R�szleges t�vmunka szerz�d�s helysz�ne] AS [R�szleges t�vmunka szerz�d�s helysz�ne], tSzem�lyek_Import.[R�szleges t�vmunka szerz�d�s helysz�ne 2] AS [R�szleges t�vmunka szerz�d�s helysz�ne 2], tSzem�lyek_Import.[R�szleges t�vmunka szerz�d�s helysz�ne 3] AS [R�szleges t�vmunka szerz�d�s helysz�ne 3], tSzem�lyek_Import.[Egy�ni t�l�ra keret meg�llapod�s kezdete] AS [Egy�ni t�l�ra keret meg�llapod�s kezdete], tSzem�lyek_Import.[Egy�ni t�l�ra keret meg�llapod�s v�ge] AS [Egy�ni t�l�ra keret meg�llapod�s v�ge], tSzem�lyek_Import.[Egy�ni t�l�ra keret meg�llapod�s m�rt�ke] AS [Egy�ni t�l�ra keret meg�llapod�s m�rt�ke], tSzem�lyek_Import.[KIRA feladat azonos�t�ja - int�zm�ny prefix-szel ell�tva] AS [KIRA feladat azonos�t�ja - int�zm�ny prefix-szel ell�tva], tSzem�lyek_Import.[KIRA feladat azonos�t�ja] AS [KIRA feladat azonos�t�ja], tSzem�lyek_Import.[KIRA feladat megnevez�s] AS [KIRA feladat megnevez�s], tSzem�lyek_Import.[Osztott munkak�r] AS [Osztott munkak�r], tSzem�lyek_Import.[Funkci�csoport: k�d-megnevez�s] AS [Funkci�csoport: k�d-megnevez�s], tSzem�lyek_Import.[Funkci�: k�d-megnevez�s] AS [Funkci�: k�d-megnevez�s], tSzem�lyek_Import.[Dolgoz� k�lts�ghely�nek k�dja] AS [Dolgoz� k�lts�ghely�nek k�dja], tSzem�lyek_Import.[Dolgoz� k�lts�ghely�nek neve] AS [Dolgoz� k�lts�ghely�nek neve], tSzem�lyek_Import.Feladatk�r AS Feladatk�r, tSzem�lyek_Import.[Els�dleges feladatk�r] AS [Els�dleges feladatk�r], tSzem�lyek_Import.Feladatok AS Feladatok, tSzem�lyek_Import.FEOR AS FEOR, tSzem�lyek_Import.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� napi �raker] AS [Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� napi �raker], tSzem�lyek_Import.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker] AS [Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� heti �raker], tSzem�lyek_Import.[Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� havi �raker] AS [Elm�leti (szerz�d�s/kinevez�s szerinti) ledolgozand� havi �raker], tSzem�lyek_Import.[Szerz�d�s/Kinevez�s t�pusa] AS [Szerz�d�s/Kinevez�s t�pusa], tSzem�lyek_Import.Iktat�sz�m AS Iktat�sz�m, tSzem�lyek_Import.[Szerz�d�s/kinevez�s verzi�_�rv�nyess�g kezdete] AS [Szerz�d�s/kinevez�s verzi�_�rv�nyess�g kezdete], tSzem�lyek_Import.[Szerz�d�s/kinevez�s verzi�_�rv�nyess�g v�ge] AS [Szerz�d�s/kinevez�s verzi�_�rv�nyess�g v�ge], tSzem�lyek_Import.[Hat�rozott idej� _szerz�d�s/kinevez�s lej�r] AS [Hat�rozott idej� _szerz�d�s/kinevez�s lej�r], tSzem�lyek_Import.[Szerz�d�s dokumentum (csatolt dokumentumok f�jlnevei)] AS [Szerz�d�s dokumentum (csatolt dokumentumok f�jlnevei)], tSzem�lyek_Import.[Megjegyz�s (pl# hat�rozott szerz�d�s/kinevez�s oka)] AS [Megjegyz�s (pl# hat�rozott szerz�d�s/kinevez�s oka)], tSzem�lyek_Import.[Munkav�gz�s helye - megnevez�s] AS [Munkav�gz�s helye - megnevez�s], tSzem�lyek_Import.[Munkav�gz�s helye - c�m] AS [Munkav�gz�s helye - c�m], tSzem�lyek_Import.[Jogviszony t�pusa / jogviszony t�pus] AS [Jogviszony t�pusa / jogviszony t�pus], tSzem�lyek_Import.[Jogviszony sorsz�ma] AS [Jogviszony sorsz�ma], tSzem�lyek_Import.[KIRA jogviszony jelleg] AS [KIRA jogviszony jelleg], tSzem�lyek_Import.[K�lcs�nbe ad� c�g] AS [K�lcs�nbe ad� c�g], tSzem�lyek_Import.[Teljes�tm�ny�rt�kel�s - �rt�kel� szem�ly] AS [Teljes�tm�ny�rt�kel�s - �rt�kel� szem�ly], tSzem�lyek_Import.[Teljes�tm�ny�rt�kel�s - �rv�nyess�g kezdet] AS [Teljes�tm�ny�rt�kel�s - �rv�nyess�g kezdet], tSzem�lyek_Import.[Teljes�tm�ny�rt�kel�s - �rt�kelt id�szak kezdet] AS [Teljes�tm�ny�rt�kel�s - �rt�kelt id�szak kezdet], tSzem�lyek_Import.[Teljes�tm�ny�rt�kel�s - �rt�kelt id�szak v�ge] AS [Teljes�tm�ny�rt�kel�s - �rt�kelt id�szak v�ge], tSzem�lyek_Import.[Teljes�tm�ny�rt�kel�s d�tuma] AS [Teljes�tm�ny�rt�kel�s d�tuma], tSzem�lyek_Import.[Teljes�tm�ny�rt�kel�s - Be�ll�si sz�zal�k] AS [Teljes�tm�ny�rt�kel�s - Be�ll�si sz�zal�k], tSzem�lyek_Import.[Teljes�tm�ny�rt�kel�s - Pontsz�m] AS [Teljes�tm�ny�rt�kel�s - Pontsz�m], tSzem�lyek_Import.[Teljes�tm�ny�rt�kel�s - Megjegyz�s] AS [Teljes�tm�ny�rt�kel�s - Megjegyz�s], tSzem�lyek_Import.[Dolgoz�i jellemz�k] AS [Dolgoz�i jellemz�k], tSzem�lyek_Import.[Fizet�si oszt�ly (KA)/ Pedag�gusi fokozat (KA pedag�gus)/besorol] AS [Fizet�si oszt�ly (KA)/ Pedag�gusi fokozat (KA pedag�gus)/besorol], tSzem�lyek_Import.[Besorol�si  fokozat (KT)] AS [Besorol�si  fokozat (KT)], tSzem�lyek_Import.[Jogfolytonos id� kezdete] AS [Jogfolytonos id� kezdete], tSzem�lyek_Import.[Jogviszony kezdete (bel�p�s d�tuma)] AS [Jogviszony kezdete (bel�p�s d�tuma)], tSzem�lyek_Import.[Jogviszony v�ge (kil�p�s d�tuma)] AS [Jogviszony v�ge (kil�p�s d�tuma)], tSzem�lyek_Import.[Utols� munk�ban t�lt�tt nap] AS [Utols� munk�ban t�lt�tt nap], tSzem�lyek_Import.[Kezdem�nyez�s d�tuma] AS [Kezdem�nyez�s d�tuma], tSzem�lyek_Import.[Hat�lyoss� v�lik] AS [Hat�lyoss� v�lik], tSzem�lyek_Import.[HR kapcsolat megsz�n�s m�dja (Kil�p�s m�dja)] AS [HR kapcsolat megsz�n�s m�dja (Kil�p�s m�dja)], tSzem�lyek_Import.[HR kapcsolat megsz�nes indoka (Kil�p�s indoka)] AS [HR kapcsolat megsz�nes indoka (Kil�p�s indoka)], tSzem�lyek_Import.Indokol�s AS Indokol�s, tSzem�lyek_Import.[K�vetkez� munkahely] AS [K�vetkez� munkahely], tSzem�lyek_Import.[MT: Felmond�si id� kezdete KJT, KTTV: Felment�si id� kezdete] AS [MT: Felmond�si id� kezdete KJT, KTTV: Felment�si id� kezdete], tSzem�lyek_Import.[Felmond�si id� v�ge (MT) Felment�si id� v�ge (KJT, KTTV)] AS [Felmond�si id� v�ge (MT) Felment�si id� v�ge (KJT, KTTV)], tSzem�lyek_Import.[Munkav�gz�s al�li mentes�t�s kezdete (KJT, KTTV) Felment�si id� ] AS [Munkav�gz�s al�li mentes�t�s kezdete (KJT, KTTV) Felment�si id� ], tSzem�lyek_Import.[Munkav�gz�s al�li mentes�t�s v�ge (KJT, KTTV) Felment�si id� v�g] AS [Munkav�gz�s al�li mentes�t�s v�ge (KJT, KTTV) Felment�si id� v�g], tSzem�lyek_Import.[Tart�s t�voll�t t�pusa] AS [Tart�s t�voll�t t�pusa], tSzem�lyek_Import.[Tart�s t�voll�t kezdete] AS [Tart�s t�voll�t kezdete], tSzem�lyek_Import.[Tart�s t�voll�t v�ge] AS [Tart�s t�voll�t v�ge], tSzem�lyek_Import.[Tart�s t�voll�t tervezett v�ge] AS [Tart�s t�voll�t tervezett v�ge], tSzem�lyek_Import.[Helyettes�tett dolgoz� neve] AS [Helyettes�tett dolgoz� neve], tSzem�lyek_Import.[Szerz�d�s/Kinevez�s - pr�baid� v�ge] AS [Szerz�d�s/Kinevez�s - pr�baid� v�ge], tSzem�lyek_Import.[Utal�si c�m] AS [Utal�si c�m], tSzem�lyek_Import.[Alapilletm�ny / Munkab�r / Megb�z�si d�j (elt�r�t�s n�lk�li)] AS [Alapilletm�ny / Munkab�r / Megb�z�si d�j (elt�r�t�s n�lk�li)], tSzem�lyek_Import.[Garant�lt b�rminimumra t�rt�n� kieg�sz�t�s] AS [Garant�lt b�rminimumra t�rt�n� kieg�sz�t�s], tSzem�lyek_Import.Kerek�t�s AS Kerek�t�s, tSzem�lyek_Import.[Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S % (elt�r�t] AS [Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S % (elt�r�t], tSzem�lyek_Import.[Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S �sszeg (el] AS [Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S �sszeg (el], tSzem�lyek_Import.[Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY % (elt�r�t�s n�lk�li)] AS [Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY % (elt�r�t�s n�lk�li)], tSzem�lyek_Import.[Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY �sszeg (elt�r�t�s n�l] AS [Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY �sszeg (elt�r�t�s n�l], tSzem�lyek_Import.[Egy�b p�tl�k - �sszeg (elt�r�t�s n�lk�li)] AS [Egy�b p�tl�k - �sszeg (elt�r�t�s n�lk�li)], tSzem�lyek_Import.[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�t�s n�lk�li)] AS [Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�t�s n�lk�li)], tSzem�lyek_Import.[Kerek�tett 100 %-os illetm�ny (elt�r�t�s n�lk�li)] AS [Kerek�tett 100 %-os illetm�ny (elt�r�t�s n�lk�li)], tSzem�lyek_Import.[Elt�r�t�s %] AS [Elt�r�t�s %], tSzem�lyek_Import.[Alapilletm�ny / Munkab�r / Megb�z�si d�j (elt�r�tett)] AS [Alapilletm�ny / Munkab�r / Megb�z�si d�j (elt�r�tett)], tSzem�lyek_Import.[Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S % (elt�r�1] AS [Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S % (elt�r�1], tSzem�lyek_Import.[Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S �sszeg (e1] AS [Egy�b p�tl�k, GARANT�LT B�RMINIMUMRA VAL� KIEG�SZ�T�S �sszeg (e1], tSzem�lyek_Import.[Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY % (elt�r�tett)] AS [Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY % (elt�r�tett)], tSzem�lyek_Import.[Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY �sszeg (elt�r�tett)] AS [Egy�b p�tl�k, KEREK�T�SB�L AD�D� ILLETM�NY �sszeg (elt�r�tett)], tSzem�lyek_Import.[Egy�b p�tl�k - �sszeg (elt�r�tett)] AS [Egy�b p�tl�k - �sszeg (elt�r�tett)], tSzem�lyek_Import.[Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)] AS [Illetm�ny �sszesen kerek�t�s n�lk�l (elt�r�tett)], tSzem�lyek_Import.[Kerek�tett 100 %-os illetm�ny (elt�r�tett)] AS [Kerek�tett 100 %-os illetm�ny (elt�r�tett)], tSzem�lyek_Import.[Tov�bbi munkav�gz�s helye 1 Teljes munkaid� %-a] AS [Tov�bbi munkav�gz�s helye 1 Teljes munkaid� %-a], tSzem�lyek_Import.[Tov�bbi munkav�gz�s helye 2 Teljes munkaid� %-a] AS [Tov�bbi munkav�gz�s helye 2 Teljes munkaid� %-a], tSzem�lyek_Import.[KT: Kerek�tett 100 %-os illetm�ny (elt�r�tett) + Helyettes�t�si ] AS [KT: Kerek�tett 100 %-os illetm�ny (elt�r�tett) + Helyettes�t�si ], tSzem�lyek_Import.[Szint 1 szervezeti egys�g n�v] AS [Szint 1 szervezeti egys�g n�v], tSzem�lyek_Import.[Szint 1 szervezeti egys�g k�d] AS [Szint 1 szervezeti egys�g k�d], tSzem�lyek_Import.[Szint 2 szervezeti egys�g n�v] AS [Szint 2 szervezeti egys�g n�v], tSzem�lyek_Import.[Szint 2 szervezeti egys�g k�d] AS [Szint 2 szervezeti egys�g k�d], tSzem�lyek_Import.[Szint 3 szervezeti egys�g n�v] AS [Szint 3 szervezeti egys�g n�v], tSzem�lyek_Import.[Szint 3 szervezeti egys�g k�d] AS [Szint 3 szervezeti egys�g k�d], tSzem�lyek_Import.[Szint 4 szervezeti egys�g n�v] AS [Szint 4 szervezeti egys�g n�v], tSzem�lyek_Import.[Szint 4 szervezeti egys�g k�d] AS [Szint 4 szervezeti egys�g k�d], tSzem�lyek_Import.[Szint 5 szervezeti egys�g n�v] AS [Szint 5 szervezeti egys�g n�v], tSzem�lyek_Import.[Szint 5 szervezeti egys�g k�d] AS [Szint 5 szervezeti egys�g k�d], tSzem�lyek_Import.[AD egyedi azonos�t�] AS [AD egyedi azonos�t�], tSzem�lyek_Import.[Hivatali email] AS [Hivatali email], tSzem�lyek_Import.[Hivatali mobil] AS [Hivatali mobil], tSzem�lyek_Import.[Hivatali telefon] AS [Hivatali telefon], tSzem�lyek_Import.[Hivatali telefon mell�k] AS [Hivatali telefon mell�k], tSzem�lyek_Import.Iroda AS Iroda, tSzem�lyek_Import.[Otthoni e-mail] AS [Otthoni e-mail], tSzem�lyek_Import.[Otthoni mobil] AS [Otthoni mobil], tSzem�lyek_Import.[Otthoni telefon] AS [Otthoni telefon], tSzem�lyek_Import.[Tov�bbi otthoni mobil] AS [Tov�bbi otthoni mobil]
FROM tSzem�lyek_Import;

-- [tmplkHi�nyz�Kinevez�sekD�tumastb]
SELECT lkSzem�lyek.F�oszt�ly, kt_azNexon_Ad�jel02.azNexon, lkSzem�lyek.Ad�jel, lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)], tmpHi�nyz�Kinevez�sD�tuma.Azonos�t�, kt_azNexon_Ad�jel02.azNexon, lkSzem�lyek.[Dolgoz� teljes neve], lkSzem�lyek.[KIRA feladat megnevez�s], lkSzem�lyek.Feladatk�r, lkSzem�lyek.[Els�dleges feladatk�r], lkSzem�lyek.Feladatok, lkSzem�lyek.[KIRA feladat azonos�t�ja - int�zm�ny prefix-szel ell�tva], lkSzem�lyek.[KIRA feladat azonos�t�ja]
FROM kt_azNexon_Ad�jel02 INNER JOIN (tmpHi�nyz�Kinevez�sD�tuma INNER JOIN lkSzem�lyek ON tmpHi�nyz�Kinevez�sD�tuma.F1 = lkSzem�lyek.Ad�jel) ON kt_azNexon_Ad�jel02.Ad�jel = tmpHi�nyz�Kinevez�sD�tuma.F1
WHERE (((lkSzem�lyek.[Jogviszony kezdete (bel�p�s d�tuma)]) Between Date() And #5/13/2024#));

-- [tmplkNapokKil�p�k]
SELECT [F�oszt�ly] & [Oszt�ly] AS Kif1, tNapok03.Nap, Sum(tKiBel�p�kL�tsz�ma.F�) AS SumOfF�
FROM tKiBel�p�kL�tsz�ma INNER JOIN tNapok03 ON tKiBel�p�kL�tsz�ma.D�tum = tNapok03.D�tum
WHERE (((tNapok03.�v)=2023))
GROUP BY [F�oszt�ly] & [Oszt�ly], tNapok03.Nap;

-- [tNexonAzonos�t�k - azonosak keres�se]
SELECT tNexonAzonos�t�k.[Szem�ly azonos�t�], tNexonAzonos�t�k.[HR kapcsolat azonos�t�], First(tNexonAzonos�t�k.Azonos�t�) AS FirstOfAzonos�t�
FROM tNexonAzonos�t�k
GROUP BY tNexonAzonos�t�k.[Szem�ly azonos�t�], tNexonAzonos�t�k.[HR kapcsolat azonos�t�]
HAVING (((tNexonAzonos�t�k.[Szem�ly azonos�t�]) In (SELECT [Szem�ly azonos�t�] FROM [tNexonAzonos�t�k] As Tmp GROUP BY [Szem�ly azonos�t�],[HR kapcsolat azonos�t�] HAVING Count(*)>1  And [HR kapcsolat azonos�t�] = [tNexonAzonos�t�k].[HR kapcsolat azonos�t�])))
ORDER BY tNexonAzonos�t�k.[Szem�ly azonos�t�], tNexonAzonos�t�k.[HR kapcsolat azonos�t�], First(tNexonAzonos�t�k.Azonos�t�) DESC;

-- [tSzem�lyMez�k - azonosak keres�se]
SELECT tSzem�lyMez�k.Mez�n�v, tSzem�lyMez�k.T�pus, tSzem�lyMez�k.Az
FROM tSzem�lyMez�k
WHERE (((tSzem�lyMez�k.Mez�n�v) In (SELECT [Mez�n�v] FROM [tSzem�lyMez�k] As Tmp GROUP BY [Mez�n�v],[T�pus] HAVING Count(*)>1  And [T�pus] = [tSzem�lyMez�k].[T�pus])))
ORDER BY tSzem�lyMez�k.Mez�n�v, tSzem�lyMez�k.T�pus;

-- [tSzervezet]
SELECT tSzervezeti.*
FROM tSzervezeti;

-- [tSzervezetiEgys�gek - azonosak keres�se]
SELECT tSzervezetiEgys�gek.[Szervezeti egys�g k�dja], tSzervezetiEgys�gek.azSzervezet, tSzervezetiEgys�gek.F�oszt�ly, tSzervezetiEgys�gek.Oszt�ly
FROM tSzervezetiEgys�gek
WHERE (((tSzervezetiEgys�gek.[Szervezeti egys�g k�dja]) In (SELECT [Szervezeti egys�g k�dja] FROM [tSzervezetiEgys�gek] As Tmp GROUP BY [Szervezeti egys�g k�dja] HAVING Count(*)>1 )))
ORDER BY tSzervezetiEgys�gek.[Szervezeti egys�g k�dja];

-- [xxx_01_azNexon_�s_Ad�jel_a_tSzem�lyek_t�bl�hoz]
ALTER TABLE tSzem�lyek
ADD COLUMN Ad�jel Double, azNexon Double;
-- [xxx_02_Ad�azonos�t�_jel_Konv_Ad�jel]
UPDATE tSzem�lyek SET tSzem�lyek.Ad�jel = [Ad�azonos�t� jel]*1;

-- [xxx_03_azNexon_friss�t�se_tk_Nexon-b�l]
UPDATE kt_azNexon_Ad�jel INNER JOIN tSzem�lyek ON kt_azNexon_Ad�jel.Ad�jel=tSzem�lyek.Ad�jel SET tSzem�lyek.azNexon = [kt_azNexon_Ad�jel].[azNexon];

