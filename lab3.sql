 /*Exercise 1*/

-- 1. między 12 i 20 listopada 2013,

SELECT
	idzamowienia, datarealizacji
FROM 
	zamowienia
WHERE
	EXTRACT(YEAR FROM datarealizacji) = 2013
	AND
	EXTRACT(MONTH FROM datarealizacji) = 11
	AND
	EXTRACT(DAY FROM datarealizacji) BETWEEN 12 AND 20

-- 2. między 1 i 6 grudnia lub między 15 i 20 grudnia 2013

SELECT 
	idzamowienia, datarealizacji
FROM 
	zamowienia
WHERE
    datarealizacji BETWEEN '2013-12-01' AND '2013-12-06'
    OR
    datarealizacji BETWEEN '2013-12-15' AND '2013-12-20'

-- 3. w grudniu 2013 (nie używaj funkcji date_part ani extract),

SELECT 
	idzamowienia, datarealizacji
FROM 
	zamowienia
WHERE
    datarealizacji BETWEEN '2013-12-01' AND '2013-12-31'

--OR

SELECT idzamowienia, datarealizacji
FROM zamowienia
WHERE datarealizacji::varchar LIKE '2013-12-__'

-- 4. w listopadzie 2013 (w tym i kolejnych zapytaniach użyj funkcji date_part lub extract),

SELECT 
	idzamowienia, datarealizacji
FROM 
	zamowienia
WHERE
	date_part('year', datarealizacji ) = 2013
	AND
    EXTRACT(MONTH FROM datarealizacji) = 11

-- 5. ★ w listopadzie lub grudniu 2013,

SELECT 
	idzamowienia, datarealizacji
FROM 
	zamowienia
WHERE
	date_part('year', datarealizacji ) = 2013
	AND
    EXTRACT(MONTH FROM datarealizacji) BETWEEN 11 AND 12

-- 6. ★ 17, 18 lub 19 dnia miesiąca,

SELECT 
	idzamowienia, datarealizacji
FROM 
	zamowienia
WHERE
	date_part('day', datarealizacji ) IN (17,18,19)
	

-- 7. ★ 46 lub 47 tygodniu roku.

SELECT 
	idzamowienia, datarealizacji
FROM 
	zamowienia
WHERE
	date_part('week', datarealizacji ) IN (46, 47)


/*Exercise 2*/

-- 1. rozpoczyna się na literę 'S',

SELECT
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	nazwa LIKE 'S%'

-- 2. rozpoczyna się na literę 'S' i kończy się na literę 'i',

SELECT
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	nazwa LIKE 'S%i'

-- 3. rozpoczyna się na literę 'S' i zawiera słowo rozpoczynające się na literę 'm',

SELECT
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	nazwa ~ '^S' and nazwa ~ ' m'

-- 4. rozpoczyna się na literę 'A', 'B' lub 'C',

SELECT
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	nazwa ~'^(A|B|C)'

-- 5. zawiera rdzeń 'orzech' (może on wystąpić na początku i wówczas będzie pisany z wielkiej litery),

SELECT
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	nazwa LIKE '%orzech%' 
	OR 
	nazwa LIKE 'Orzech%'

-- 6. ★ rozpoczyna się na literę 'S' i zawiera w środku literę 'm',

SELECT
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	nazwa LIKE 'S%m%'

-- 7. ★ zawiera słowo 'maliny' lub 'truskawki',

SELECT
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	nazwa LIKE '%maliny%' OR nazwa LIKE '%truskawki%'

--OR

SELECT 
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM 
	czekoladki
WHERE 
	nazwa ~* '(^| )maliny|truskawki'

--8. ★ nie rozpoczyna się żadną z liter: 'D'-'K', 'S' i 'T',

SELECT
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	nazwa !~ '^[D-K,S,T]'

-- 9. ★ rozpoczyna się od 'Slod' ('Słod'),

SELECT
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	nazwa LIKE 'Słod%'

-- 10. ★ składa się dokładnie z jednego słowa.

SELECT
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	nazwa !~' '

--OR

SELECT
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	nazwa ~ '^\w+$'

/*Exercise 3*/

--1. wyświetla unikalne nazwy miast, z których pochodzą klienci cukierni i które składają się z więcej niż jednego słowa,

SELECT DISTINCT 
	miejscowosc
FROM 
	klienci
WHERE 
	miejscowosc LIKE '% %'

-- 2. wyświetla nazwy i numery telefonów klientów, którzy podali numer stacjonarny telefonu (np. 012 222 22 00),

SELECT 
	nazwa, telefon
FROM
	klienci
WHERE	
	telefon LIKE '___ ___ __ __'

--OR

SELECT 
	nazwa, telefon
FROM 
	klienci
WHERE 
	telefon ~ '^[0-9]{3} [0-9]{3} [0-9]{2} [0-9]{2}$'

--3.★ wyświetla nazwy i numery telefonów klientów, którzy podali numer komórkowy telefonu,

SELECT
	nazwa, telefon 
FROM
	klienci
WHERE
	telefon LIKE '___ ___ ___'
	
-- OR

SELECT
	nazwa, telefon 
FROM
	klienci
WHERE
	telefon ~'^[0-9]{3} [0-9]{3} [0-9]{3}'

/* Exercise 4 */

-- 1. masa mieści się w przedziale od 15 do 24 g lub koszt produkcji mieści się w przedziale od 15 do 24 gr,

(SELECT 
	idczekoladki, nazwa, masa, koszt
From 
	czekoladki
WHERE 
	masa BETWEEN 15 AND 24 )
UNION
(SELECT 
	idczekoladki, nazwa, masa, koszt
From 
	czekoladki
WHERE 
	koszt*100 BETWEEN 15 AND 24)

-- 2. masa mieści się w przedziale od 25 do 35 g, ale koszt produkcji nie mieści się w przedziale od 25 do 35 gr,

(SELECT 
	idczekoladki, nazwa, masa, koszt
From 
	czekoladki
WHERE 
	masa BETWEEN 25 AND 35 )
INTERSECT
(SELECT 
	idczekoladki, nazwa, masa, koszt
From 
	czekoladki
WHERE 
	koszt*100 NOT BETWEEN 25 AND 35)

-- 3. [masa mieści się w przedziale od 15 do 24 g i koszt produkcji mieści się w przedziale od 15 do 24 gr] lub [masa mieści się w przedziale od 25 do 35 g i koszt produkcji mieści się w przedziale od 25 do 35 gr],

(
    (SELECT idczekoladki, nazwa, masa, koszt
    FROM czekoladki
    WHERE masa BETWEEN 15 AND 24)
    INTERSECT
    (SELECT idczekoladki, nazwa, masa, koszt
    FROM czekoladki
    WHERE koszt BETWEEN 0.15 AND 0.24)
)
UNION
(
    (SELECT idczekoladki, nazwa, masa, koszt
    FROM czekoladki
    WHERE masa BETWEEN 25 AND 35)
    INTERSECT
    (SELECT idczekoladki, nazwa, masa, koszt
    FROM czekoladki
    WHERE koszt BETWEEN 0.25 AND 0.35)
)


-- 4. ★ masa mieści się w przedziale od 15 do 24 g i koszt produkcji mieści się w przedziale od 15 do 24 gr,

(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE masa BETWEEN 15 AND 24)
INTERSECT
(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE koszt BETWEEN 0.15 AND 0.24)

-- 6. ★ masa mieści się w przedziale od 25 do 35 g, ale koszt produkcji nie mieści się ani w przedziale od 15 do 24 gr, ani w przedziale od 29 do 35 gr.

(SELECT
	idczekoladki, nazwa, masa, koszt
FROM
	czekoladki
WHERE
	masa BETWEEN 25 AND 35)
INTERSECT
(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE 
	koszt NOT BETWEEN 0.15 AND 0.24)
INTERSECT
(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE 
	koszt NOT BETWEEN 0.29 AND 0.35)

/* Exercise 5 */

-- 1. identyfikatory klientów, którzy nigdy nie złożyli żadnego zamówienia,

(SELECT idklienta
FROM klienci )
EXCEPT
(SELECT idklienta
FROM zamowienia
)

-- 2. identyfikatory pudełek, które nigdy nie zostały zamówione,

(SELECT idpudelka
FROM pudelka )
EXCEPT
(SELECT idpudelka
FROM artykuly
)

-- 3. ★ nazwy klientów, czekoladek i pudełek, które zawierają rz (lub Rz),

SELECT * FROM
(
	SELECT nazwa FROM klienci 
	UNION 
	SELECT nazwa FROM pudelka
	UNION
	SELECT nazwa FROM czekoladki
)
WHERE nazwa LIKE '%rz%' OR nazwa LIKE '%Rz%'

-- 4. ★ identyfikatory czekoladek, które nie występują w żadnym pudełku.

(SELECT idczekoladki FROM czekoladki)
EXCEPT 
(SELECT idczekoladki FROM zawartosc)

/* Exercise 6 */

-- 1. identyfikator meczu, sumę punktów zdobytych przez gospodarzy i sumę punktów zdobytych przez gości,

SELECT 
	idmeczu,
	(SELECT SUM(s) FROM UNNEST(gospodarze) s) as gospodarze,
	(SELECT SUM(s) FROM UNNEST(goscie) s) as goscie
FROM siatkowka.statystyki

-- 2. identyfikator meczu, sumę punktów zdobytych przez gospodarzy i sumę punktów zdobytych przez gości, dla meczów, które skończyły się po 5 setach i zwycięzca ostatniego seta zdobył w nim ponad 15 punktów,



-- 3. identyfikator i wynik meczu w formacie x:y, np. 3:1 (wynik jest pojedynczą kolumną – napisem),
-- 4. ★ identyfikator meczu, sumę punktów zdobytych przez gospodarzy i sumę punktów zdobytych przez gości, dla meczów, w których gospodarze zdobyli ponad 100 punktów,
-- 5. ★ identyfikator meczu, liczbę punktów zdobytych przez gospodarzy w pierwszym secie, sumę punktów zdobytych w meczu przez gospodarzy, dla meczów, w których pierwiastek kwadratowy z liczby punktów zdobytych przez gospodarzy w pierwszym secie jest mniejszy niż logarytm o podstawie 2 z sumy punktów zdobytych w meczu przez gospodarzy. ;)