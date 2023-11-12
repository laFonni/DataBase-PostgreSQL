/*Exercise 2*/
-- 1. zostały złożone przez klienta, który ma na imię Antoni,

SELECT datarealizacji, idzamowienia, k.nazwa
FROM zamowienia z
INNER JOIN klienci k ON z.idklienta = k.idklienta
WHERE k.nazwa LIKE '%Antoni'

-- 2. zostały złożone przez klientów z mieszkań (zwróć uwagę na pole ulica),

SELECT idzamowienia, datarealizacji, k.ulica
FROM zamowienia z
INNER JOIN klienci k ON z.idklienta = k.idklienta
WHERE k.ulica LIKE '%/%'

-- 3. ★ zostały złożone przez klienta z Krakowa do realizacji w listopadzie 2013 roku.

SELECT idzamowienia, datarealizacji, k.miejscowosc
FROM zamowienia z
INNER JOIN klienci k ON z.idklienta = k.idklienta
WHERE 
	k.miejscowosc LIKE 'Kraków' 
	AND
	z.datarealizacji::varchar LIKE '2013-11-__'

/*Exercise 3*/

-- 1. złożyli zamówienia z datą realizacji nie starszą niż sprzed piętnastu lat,

SELECT DISTINCT k.idklienta, nazwa, ulica, miejscowosc
FROM klienci k JOIN zamowienia z ON k.idklienta = z.idklienta
WHERE z.datarealizacji >= NOW() - INTERVAL '15 YEARS'


-- 2. zamówili pudełko Kremowa fantazja lub Kolekcja jesienna,

SELECT DISTINCT k.idklienta, k.nazwa, k.ulica, k.miejscowosc
FROM klienci k 
	INNER JOIN zamowienia z ON k.idklienta = z.idklienta
	INNER JOIN artykuly a ON z.idzamowienia = a.idzamowienia
	INNER JOIN pudelka p ON p.idpudelka = a.idpudelka
WHERE 
	p.nazwa IN ('Kremowa fantazja', 'Kolekcja jesienna')

-- 3. złożyli przynajmniej jedno zamówienie,

SELECT DISTINCT k.idklienta, k.nazwa, k.ulica, k.miejscowosc
FROM klienci k 
	INNER JOIN zamowienia z ON k.idklienta = z.idklienta
WHERE z.idklienta IS NOT NULL

--OR

SELECT k.idklienta, k.nazwa, k.ulica, k.miejscowosc FROM klienci k
WHERE k.idklienta IN (SELECT idklienta FROM zamowienia)

-- 4. nie złożyli żadnych zamówień,

SELECT DISTINCT k.idklienta, k.nazwa, k.ulica, k.miejscowosc
FROM klienci k 
	INNER JOIN zamowienia z ON k.idklienta = z.idklienta
WHERE z.idklienta IS NULL

-- 5. ★ złożyli zamówienia z datą realizacji w listopadzie 2013,

SELECT DISTINCT k.idklienta, k.nazwa, k.ulica, k.miejscowosc
FROM klienci k 
	INNER JOIN zamowienia z ON k.idklienta = z.idklienta
WHERE z.datarealizacji::varchar LIKE '2013-11-__'

-- 6. ★ zamówili co najmniej 2 sztuki pudełek Kremowa fantazja lub Kolekcja jesienna w ramach jednego zamówienia,

SELECT DISTINCT k.idklienta, k.nazwa, k.ulica, k.miejscowosc
FROM klienci k 
	INNER JOIN zamowienia z ON k.idklienta = z.idklienta
	INNER JOIN artykuly a ON z.idzamowienia = a.idzamowienia
	INNER JOIN pudelka p ON a.idpudelka = p.idpudelka
WHERE 
	a.sztuk >= 2
	AND
	p.nazwa IN ('Kremowa fantazja', 'Kolekcja jesienna')

-- 7. ★ zamówili pudełka, które zawierają czekoladki z migdałami.

SELECT DISTINCT k.idklienta, k.nazwa, k.ulica, k.miejscowosc
FROM klienci k 
	INNER JOIN zamowienia z ON k.idklienta = z.idklienta
	INNER JOIN artykuly a ON z.idzamowienia = a.idzamowienia
	INNER JOIN pudelka p ON a.idpudelka = p.idpudelka
	INNER JOIN zawartosc w ON p.idpudelka = w.idpudelka
	INNER JOIN czekoladki c ON w.idczekoladki = c.idczekoladki
WHERE 
	c.orzechy LIKE 'migdały'

/*Exercise 4*/

-- 1. wszystkich pudełek,

SELECT p.nazwa, c.nazwa as czekoladki, z.sztuk
FROM 
	pudelka p 
	JOIN zawartosc z ON z.idpudelka = p.idpudelka
	JOIN czekoladki c ON c.idczekoladki = z.idczekoladki

-- 2. pudełka o wartości klucza głównego heav,

SELECT p.nazwa, c.nazwa as czekoladki, z.sztuk
FROM 
	pudelka p 
	JOIN zawartosc z ON z.idpudelka = p.idpudelka
	JOIN czekoladki c ON c.idczekoladki = z.idczekoladki
WHERE 
	p.idpudelka = 'heav'

-- 3. ★ pudełek, których nazwa zawiera słowo Kolekcja.

SELECT p.nazwa, c.nazwa as czekoladki, z.sztuk
FROM 
	pudelka p 
	JOIN zawartosc z ON z.idpudelka = p.idpudelka
	JOIN czekoladki c ON c.idczekoladki = z.idczekoladki
WHERE 
	p.nazwa ~ '^(K|k)olekcja'

/*Exercise 5*/

-- 1. zawierają czekoladki o wartości klucza głównego d09

SELECT p.idpudelka, p.nazwa, p.opis, p.cena
FROM 
	pudelka p 
	JOIN zawartosc z ON z.idpudelka = p.idpudelka
	JOIN czekoladki c ON c.idczekoladki = z.idczekoladki
WHERE 
	c.idczekoladki = 'd09'

-- 2. zawierają przynajmniej jedną czekoladkę, której nazwa zaczyna się na S,

SELECT DISTINCT p.idpudelka, p.nazwa, p.opis, p.cena
FROM 
	pudelka p 
	JOIN zawartosc z ON z.idpudelka = p.idpudelka
	JOIN czekoladki c ON c.idczekoladki = z.idczekoladki
WHERE 
	c.nazwa LIKE 'S%'
	

-- 3. zawierają przynajmniej 4 sztuki czekoladek jednego gatunku (o takim samym kluczu głównym),

SELECT DISTINCT p.idpudelka, p.nazwa, p.opis, p.cena
FROM 
	pudelka p 
	JOIN zawartosc z ON z.idpudelka = p.idpudelka
	JOIN czekoladki c ON c.idczekoladki = z.idczekoladki
WHERE 
	z.sztuk >=4

-- 4. zawierają czekoladki z nadzieniem truskawkowym,

SELECT DISTINCT p.idpudelka, p.nazwa, p.opis, p.cena
FROM 
	pudelka p 
	JOIN zawartosc z ON z.idpudelka = p.idpudelka
	JOIN czekoladki c ON c.idczekoladki = z.idczekoladki
WHERE 
	c.nadzienie LIKE 'truskawki'
	

-- 5. nie zawierają czekoladek w gorzkiej czekoladzie,

SELECT p.idpudelka, p.nazwa, p.opis, p.cena FROM pudelka p
EXCEPT
SELECT p.idpudelka, p.nazwa, p.opis, p.cena
FROM 
	pudelka p 
	JOIN zawartosc z ON z.idpudelka = p.idpudelka
	JOIN czekoladki c ON c.idczekoladki = z.idczekoladki
WHERE 
	c.czekolada LIKE 'gorzka'

-- 6. ★ zawierają co najmniej 3 sztuki czekoladki Gorzka truskawkowa,

SELECT p.idpudelka, p.nazwa, p.opis, p.cena
FROM 
	pudelka p 
	JOIN zawartosc z ON z.idpudelka = p.idpudelka
	JOIN czekoladki c ON c.idczekoladki = z.idczekoladki
WHERE 
	z.sztuk >= 3
	AND
	c.czekolada LIKE 'gorzka'
	AND
	c.nadzienie LIKE 'truskawki'

-- 7. ★ nie zawierają czekoladek z orzechami,

SELECT p.idpudelka, p.nazwa, p.opis, p.cena FROM pudelka p 
EXCEPT
SELECT p.idpudelka, p.nazwa, p.opis, p.cena
FROM 
	pudelka p 
	JOIN zawartosc z ON z.idpudelka = p.idpudelka
	JOIN czekoladki c ON c.idczekoladki = z.idczekoladki
WHERE 
	c.orzechy IS NOT NULL

-- 8. ★ zawierają czekoladki Gorzka truskawkowa,

SELECT p.idpudelka, p.nazwa, p.opis, p.cena
FROM 
	pudelka p 
	JOIN zawartosc z ON z.idpudelka = p.idpudelka
	JOIN czekoladki c ON c.idczekoladki = z.idczekoladki
WHERE 
	c.nazwa LIKE 'Gorzka truskawkowa'

-- 9. ★ zawierają przynajmniej jedną czekoladkę bez nadzienia.

SELECT distinct p.idpudelka, p.nazwa, p.opis, p.cena
FROM 
	pudelka p 
	JOIN zawartosc z ON z.idpudelka = p.idpudelka
	JOIN czekoladki c ON c.idczekoladki = z.idczekoladki
WHERE 
	c.nadzienie IS NULL

/*Exercise 6*/

-- 1. Wyświetl wartości kluczy głównych oraz nazwy czekoladek, których koszt jest większy od kosztu czekoladki o wartości  klucza głównego równej d08.

SELECT DISTINCT c.idczekoladki, c.nazwa
FROM 
	czekoladki c
WHERE c.koszt > (SELECT koszt FROM czekoladki WHERE idczekoladki = 'd08')

-- 2. Kto (identyfikator klienta, nazwa klienta) złożył zamówienie na dowolne pudełko, które zamawiała Górka Alicja.

SELECT kk.idklienta, kk.nazwa
FROM
    klienci kk
    INNER JOIN zamowienia zz ON kk.idklienta = zz.idklienta
    INNER JOIN artykuly aa ON zz.idzamowienia = aa.idzamowienia
    INNER JOIN (
        SELECT a.idpudelka
        FROM
            klienci k
            INNER JOIN zamowienia z ON k.idklienta = z.idklienta
            INNER JOIN artykuly a ON z.idzamowienia = a.idzamowienia
        WHERE k.nazwa = 'Górka Alicja'
    ) gorka ON aa.idpudelka = gorka.idpudelka
WHERE kk.miejscowosc <> 'katowice'
GROUP BY kk.idklienta, kk.nazwa
ORDER BY kk.nazwa ASC

-- 3. ★ Kto (identyfikator klienta, nazwa klienta) złożył zamówienie na dowolne pudełko, które zamawiali klienci z Katowic.

WITH kat AS (
    SELECT a.idpudelka
    FROM
        klienci k
        INNER JOIN zamowienia z ON k.idklienta = z.idklienta
        INNER JOIN artykuly a ON z.idzamowienia = a.idzamowienia
    WHERE k.miejscowosc = 'Katowice'
)
SELECT kk.idklienta, kk.nazwa
FROM
    klienci kk
    INNER JOIN zamowienia zz ON kk.idklienta = zz.idklienta
    INNER JOIN artykuly aa ON zz.idzamowienia = aa.idzamowienia
    INNER JOIN kat ON aa.idpudelka = kat.idpudelka
WHERE kk.miejscowosc <> 'Katowice'
GROUP BY kk.idklienta, kk.nazwa
ORDER BY kk.nazwa ASC