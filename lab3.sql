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