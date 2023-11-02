/*Exercise 1*/

-- 1. wyświetla listę klientów (nazwa, ulica, miejscowość) posortowaną według nazw klientów,

SELECT nazwa, ulica, miejscowosc FROM public.klienci ORDER BY nazwa ASC;

-- 2. wyświetla listę klientów posortowaną malejąco według nazw miejscowości, a w ramach tej samej miejscowości rosnąco według nazw klientów,

SELECT nazwa, ulica, miejscowosc FROM public.klienci ORDER BY miejscowosc DESC, nazwa ASC

-- 3. wyświetla listę klientów z Krakowa lub z Warszawy posortowaną malejąco według nazw miejscowości, a w ramach tej samej miejscowości rosnąco według nazw klientów (zapytanie utwórz na dwa sposoby stosując w kryteriach or lub in).

SELECT nazwa, ulica, miejscowosc FROM klienci WHERE miejscowosc = 'Warszawa' OR miejscowosc = 'Kraków' ORDER BY nazwa ASC

--OR

SELECT nazwa, ulica, miejscowosc FROM klienci WHERE miejscowosc IN ('Warszawa', 'Kraków') ORDER BY nazwa ASC

-- 4.  wyświetla listę klientów posortowaną malejąco według nazw miejscowości,

SELECT nazwa, ulica, miejscowosc FROM klienci ORDER BY miejscowosc DESC

-- 5.  wyświetla listę klientów z Krakowa posortowaną według nazw klientów.

SELECT nazwa, ulica, miejscowosc FROM klienci WHERE miejscowosc = 'Kraków' ORDER BY nazwa ASC

/*Exercise 2*/

-- 1. wyświetla nazwę i masę czekoladek, których masa jest większa niż 20 g
SELECT
	nazwa, masa
FROM
	czekoladki
WHERE
	masa > 20


-- 2. wyświetla nazwę, masę i koszt produkcji czekoladek, których masa jest większa niż 20 g i koszt produkcji jest większy niż 25 gr,

SELECT
	nazwa, masa, koszt
FROM
	czekoladki
WHERE
	masa > 20 AND koszt * 100 > 25


-- 3. j.w. ale koszt produkcji musi być podany w groszach,
SELECT
	nazwa, masa, (koszt*100)::int
FROM
	czekoladki
WHERE
	masa > 20 AND koszt*100 > 25

-- 4. wyświetla nazwę oraz rodzaj czekolady, nadzienia i orzechów dla czekoladek, które są w mlecznej czekoladzie i nadziane malinami lub są w mlecznej czekoladzie i nadziane truskawkami lub zawierają orzechy laskowe, ale nie są w gorzkiej czekoladzie,

SELECT
	nazwa, czekolada, nadzienie, orzechy
FROM
	czekoladki
WHERE
	czekolada = 'mleczna' AND nadzienie = 'maliny' 
	OR
	czekolada = 'mleczna' AND nadzienie = 'truskawki'
	OR
	orzechy = 'laskowe' AND NOT czekolada = 'gorzka'

--OR

SELECT
	nazwa,
	czekolada,
	nadzienie,
	orzechy
FROM
	czekoladki
WHERE
	czekolada = 'mleczna' AND nadzienie IN ('maliny', 'truskawki') 
	OR
	orzechy = 'laskowe' AND NOT czekolada = 'gorzka'

-- 5. wyświetla nazwę i koszt produkcji czekoladek, których koszt produkcji jest większy niż 25 gr, 

SELECT
	nazwa, koszt
FROM
	czekoladki
WHERE
	koszt*100 > 25

-- 6. wyświetla nazwę i rodzaj czekolady dla czekoladek, które są w białej lub mlecznej czekoladzie

SELECT
	nazwa, czekolada
FROM
	czekoladki
WHERE
	czekolada IN ('mleczna', 'biała')

/*Exercise 3*/

-- 1. 124 * 7 + 45,
SELECT 124 * 7 + 45

-- 2. 2 ^ 20,
SELECT 2^20 
SELECT power(2, 20)

-- 3. ★ √3,
SELECT |/ 3
SELECT sqrt(3) 

-- 4. π
SELECT pi()


/*Exercise 4*/

SELECT 
	idczekoladki, nazwa, masa, koszt
FROM
	czekoladki
WHERE
	masa BETWEEN 15 AND 24

-- 2. koszt produkcji mieści się w przedziale od 25 do 35 gr,

SELECT 
	idczekoladki, nazwa, masa, koszt
FROM
	czekoladki
WHERE
	koszt*100 BETWEEN 25 AND 35

-- 3. ★ masa mieści się w przedziale od 25 do 35 g lub koszt produkcji mieści się w przedziale od 15 do 24 gr.

SELECT 
	idczekoladki, nazwa, masa, koszt
FROM
	czekoladki
WHERE
	masa BETWEEN 25 AND 35
	OR
	koszt*100 BETWEEN 15 AND 24

/*Exercise 5*/


-- 1. zawierają jakieś orzechy,

SELECT 
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	orzechy IS NOT null

-- 2. nie zawierają orzechów,

SELECT 
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	orzechy IS null

-- 3. zawierają jakieś orzechy lub jakieś nadzienie,

SELECT 
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	orzechy IS NOT null
	OR
	nadzienie IS NOT null

-- 4. są w mlecznej lub białej czekoladzie (użyj IN) i nie zawierają orzechów,

SELECT 
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	czekolada IN ('biała', 'mleczna')
	AND
	orzechy IS null

-- 5. nie są ani w mlecznej ani w białej czekoladzie i zawierają jakieś orzechy lub jakieś nadzienie,

SELECT 
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	czekolada NOT IN ('biała', 'mleczna')
	AND
	(orzechy IS NOT null
	OR
	nadzienie IS NOT null)

-- 6. ★ zawierają jakieś nadzienie,

SELECT 
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	nadzienie IS NOT null

-- 7. ★ nie zawierają nadzienia,

SELECT 
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	nadzienie IS null

-- 8. ★ nie zawierają orzechów ani nadzienia,

SELECT 
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	orzechy IS null
	AND
	nadzienie IS null

-- 9. ★ są w mlecznej lub białej czekoladzie i nie zawierają nadzienia.

SELECT 
	idczekoladki, nazwa, czekolada, orzechy, nadzienie
FROM
	czekoladki
WHERE
	czekolada IN ('mleczna', 'biała')
	AND
	nadzienie IS NULL

/*Exercise 6*/


-- 1.  masa mieści się w przedziale od 15 do 24 g lub koszt produkcji mieści się w przedziale od 15 do 24 gr,

SELECT 
	idczekoladki, nazwa, masa, koszt
FROM
	czekoladki
WHERE
	masa BETWEEN 15 AND 24 
	OR
	koszt*100 BETWEEN 15 AND 24

-- 2. [masa mieści się w przedziale od 15 do 24 g i koszt produkcji mieści się w przedziale od 15 do 24 gr] lub [masa mieści się w przedziale od 25 do 35 g i koszt produkcji mieści się w przedziale od 25 do 35 gr],

SELECT 
	idczekoladki, nazwa, masa, koszt
FROM
	czekoladki
WHERE
	(masa BETWEEN 15 AND 24 AND koszt*100 BETWEEN 15 and 24)
	OR
	(masa BETWEEN 25 AND 35 AND koszt*100 BETWEEN 25 and 35)

-- 3. ★ masa mieści się w przedziale od 15 do 24 g i koszt produkcji mieści się w przedziale od 15 do 24 gr,

SELECT 
	idczekoladki, nazwa, masa, koszt
FROM
	czekoladki
WHERE
	masa BETWEEN 15 AND 24 
	AND 
	koszt*100 BETWEEN 15 and 24


-- 4. ★ masa mieści się w przedziale od 25 do 35 g, ale koszt produkcji nie mieści się w przedziale od 25 do 35 gr,

SELECT 
	idczekoladki, nazwa, masa, koszt
FROM
	czekoladki
WHERE
	masa BETWEEN 25 AND 35 
	AND 
	(koszt*100 < 25 OR koszt*100 > 35)

-- 5. ★ masa mieści się w przedziale od 25 do 35 g, ale koszt produkcji nie mieści się ani w przedziale od 15 do 24 gr, ani w przedziale od 25 do 35 gr.

SELECT 
	idczekoladki, nazwa, masa, koszt
FROM
	czekoladki
WHERE
	masa BETWEEN 25 AND 35 
	AND 
	(koszt*100 < 15 OR koszt*100 > 35)

/*Exercise 7*/

-- #TODO
-- • Wydaj polecenie \a i ponownie wykonaj to samo zapytanie.
-- • Wydaj polecenie \f ' ' i ponownie wykonaj to samo zapytanie.
-- • Wydaj polecenie \H i ponownie wykonaj to samo zapytanie.
-- • Stosując polecenie \o przekieruj wyniki zapytania do pliku wynik.html. Ponownie wykonaj to samo zapytanie. Na drugiej konsoli sprawdź efekt jego realizacji.
-- • Przywróć standardowe parametry wyświetlania wyników w psql.

/*Exercise 8*/

-- #TODO
-- 1.★ W pliku zapytanie1.sql umieść zapytanie wyświetlające pola: idczekoladki, nazwa i opis z tabeli czekoladki. Wykonaj skrypt z poziomu psql.
--        2★ Zmodyfikuj skrypt tak, aby wynik w formacie HTML był umieszczany w pliku zapytanie1.html.

