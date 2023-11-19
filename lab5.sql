/*Exercise 1*/

-- 1. łącznej liczby czekoladek w bazie danych (w tabeli czekoladki),

SELECT COUNT(*) FROM czekoladki cz

-- 2. łącznej liczby czekoladek z nadzieniem (na 2 sposoby) - podpowiedź: count(*), count(nazwaKolumny),

SELECT DISTINCT COUNT(*) FROM czekoladki cz where cz.nadzienie IS NOT NULL

--OR

SELECT DISTINCT COUNT(cz.nadzienie) FROM czekoladki cz

-- 3. identyfikator pudełka, w którym jest najwięcej czekoladek (jeśli jest kilka takich pudełek to tylko jedno, przy użyciu LIMIT 1),

SELECT idpudelka
FROM zawartosc
GROUP BY idpudelka
ORDER BY SUM(sztuk) DESC
LIMIT 1

-- 4. ★ identyfikatorów pudełek i łącznej liczby czekoladek zawartej w każdym z nich,

SELECT idpudelka, SUM(sztuk) as suma
FROM zawartosc
GROUP BY idpudelka

-- 5. ★ identyfikatorów pudełek i łącznej liczby czekoladek bez orzechów zawartej w każdym z nich (uwaga: należy pokazać 0 przy pudełkach mających tylko czekoladki z orzechami),

SELECT p.idpudelka, COALESCE(liczba, 0) 
FROM 
	 pudelka p 
	 LEFT JOIN(
	 	SELECT z.idpudelka, SUM(z.sztuk) as liczba
		FROM zawartosc z
		 	INNER JOIN czekoladki cz ON z.idczekoladki = cz.idczekoladki
	 	WHERE cz.orzechy IS NULL
		GROUP BY z.idpudelka
	 )	USING(idpudelka)

-- 6. ★ identyfikatorów pudełek i łącznej liczby czekoladek w mlecznej czekoladzie zawartej w każdym z nich (uwaga: należy pokazać 0 przy pudełkach mających tylko czekoladki bez mlecznej czekolady).

SELECT p.idpudelka, COALESCE(liczba, 0)
FROM 
	pudelka p
	LEFT JOIN(
		SELECT z.idpudelka, SUM(z.sztuk) as liczba
		FROM 
			zawartosc z
			INNER JOIN czekoladki cz USING(idczekoladki)
		WHERE cz.czekolada LIKE 'mleczna' 
		GROUP BY z.idpudelka
	) USING(idpudelka)
 

/*Exercise 2*/

-- 1. identyfikatorów i masy poszczególnych pudełek,

SELECT p.idpudelka, SUM(z.sztuk * cz.masa)
FROM
	pudelka p
	JOIN zawartosc z USING(idpudelka)
	JOIN czekoladki cz USING(idczekoladki)
GROUP BY p.idpudelka

-- 2. identyfikatora i masy pudełka o największej masie (przy użyciu LIMIT 1),

SELECT p.idpudelka, SUM(z.sztuk * cz.masa) as suma
FROM
	pudelka p
	JOIN zawartosc z USING(idpudelka)
	JOIN czekoladki cz USING(idczekoladki)
GROUP BY p.idpudelka
ORDER BY suma DESC
LIMIT 1

-- 3. ★ średniej masy pudełka w ofercie cukierni,

SELECT AVG(m.suma) 
FROM
	(SELECT SUM(z.sztuk * cz.masa) as suma
	FROM
	 	pudelka p
		JOIN zawartosc z USING(idpudelka)
		JOIN czekoladki cz USING(idczekoladki)
	GROUP BY p.idpudelka
) m

-- 4. ★ identyfikatorów pudełek i średniej wagi pojedynczej czekoladki w każdym z nich,

SELECT p.idpudelka, (SUM(z.sztuk * cz.masa) / SUM(z.sztuk)) as srednia
FROM
	pudelka p
	INNER JOIN zawartosc z USING(idpudelka)
	INNER JOIN czekoladki cz USING(idczekoladki)
GROUP BY p.idpudelka

/*Exercise 3*/

-- 1. liczby zamówień na poszczególne dni,

SELECT datarealizacji, COUNT(*) FROM zamowienia GROUP BY datarealizacji

-- 2. łącznej liczby wszystkich zamówień,

SELECT COUNT(*) FROM zamowienia 

-- 3. ★ łącznej wartości wszystkich zamówień,

SELECT SUM(a.sztuk * p.cena) 
FROM
	pudelka p
	INNER JOIN artykuly a USING(idpudelka)
	INNER JOIN zamowienia z USING(idzamowienia)
	

-- 4. ★ identyfikatorów klientów, liczby złożonych przez nich zamówień i łącznej wartości złożonych przez nich zamówień (uwaga: należy pokazać 0 przy klientach, którzy nie złożyli żadnych zamówień).

SELECT
	k.idklienta,
	COALESCE(z.liczba_zam, 0) as liczba_zam,
	COALESCE(s.laczna_war, 0) as laczna_war
FROM 
	klienci k
	LEFT JOIN (
		SELECT idklienta, COUNT(z.idzamowienia) as liczba_zam
		FROM zamowienia z
		GROUP BY idklienta
	) z USING(idklienta)
	LEFT JOIN (
		SELECT z.idklienta, SUM(a.sztuk * p.cena) as laczna_war
		FROM zamowienia z
			INNER JOIN artykuly a USING(idzamowienia)
			INNER JOIN pudelka p USING(idpudelka)
		GROUP BY z.idklienta
	) s USING(idklienta)


/*Exercise 4*/

-- 1.identyfikatora czekoladki, która występuje w największej liczbie pudełek (przy użyciu LIMIT 1),

SELECT cz.idczekoladki
FROM 
	czekoladki cz
	INNER JOIN zawartosc z USING(idczekoladki)
	INNER JOIN pudelka p USING(idpudelka)
GROUP BY 
	cz.idczekoladki
ORDER BY 
	COUNT(p.idpudelka) DESC
LIMIT 1

-- 2. identyfikatora pudełka, które zawiera najwięcej czekoladek bez orzechów (uwaga: jeśli kilka pudełek ma taką samą największą liczbę to należy pokazać wszystkie),

WITH x AS(
	SELECT pud.idpudelka, SUM(zaw.sztuk) as suma
	FROM 
		pudelka pud
		INNER JOIN zawartosc zaw USING(idpudelka)
		INNER JOIN czekoladki cze USING(idczekoladki)
	WHERE cze.orzechy IS NULL
	GROUP BY pud.idpudelka
	)
SELECT p.idpudelka
	FROM 
		pudelka p
		INNER JOIN zawartosc z USING(idpudelka)
		INNER JOIN czekoladki cz USING(idczekoladki)
WHERE cz.orzechy IS NULL
GROUP BY p.idpudelka
HAVING SUM(z.sztuk) = (SELECT MAX(x.suma) FROM x)

-- 3. ★ identyfikatora czekoladki, która występuje w najmniejszej liczbie pudełek (uwaga: jeśli kilka czekoladek ma taką samą najmniejszą liczbę to należy pokazać wszystkie) (uwaga: może istnieć czekoladka, która nie występuje w żadnym pudełku),

WITH xyz AS(
	SELECT cz.idczekoladki, COUNT(z.idczekoladki) as suma
	FROM
		czekoladki cz
		LEFT JOIN zawartosc z USING(idczekoladki)
		
	GROUP BY cz.idczekoladki
	)
SELECT cz.idczekoladki
FROM
	czekoladki cz
	LEFT JOIN zawartosc z USING(idczekoladki)
GROUP BY cz.idczekoladki
HAVING COUNT(z.idpudelka) = (SELECT MIN(xyz.suma) FROM xyz)


-- 4. ★ identyfikatora pudełka, które jest najczęściej zamawiane przez klientów (przy użyciu LIMIT 1).

SELECT a.idpudelka
FROM artykuly a
GROUP BY a.idpudelka
ORDER BY COUNT(*) DESC
LIMIT 1


/*Exercise 5*/

-- 1. liczby zamówień na poszczególne kwartały,

SELECT date_part('quarter', z.datarealizacji) as kwartal, COUNT(z.idzamowienia)
FROM zamowienia z
GROUP BY kwartal
ORDER BY COUNT(z.idzamowienia)


-- 2. liczby zamówień na poszczególne miesiące,

SELECT date_part('month', z.datarealizacji) as kwartal, COUNT(z.idzamowienia)
FROM zamowienia z
GROUP BY kwartal
ORDER BY COUNT(z.idzamowienia)

-- 3. ★ liczby zamówień do realizacji w poszczególnych tygodniach,

SELECT date_part('week', z.datarealizacji) as kwartal, COUNT(z.idzamowienia)
FROM zamowienia z
GROUP BY kwartal
ORDER BY COUNT(z.idzamowienia)


-- 4. ★ liczby zamówień do realizacji w poszczególnych miejscowościach.

SELECT k.miejscowosc, COUNT(z.idzamowienia)
FROM klienci k
	LEFT JOIN zamowienia z USING(idklienta)
GROUP BY k.miejscowosc
ORDER BY COUNT(z.idzamowienia)

/*Exercise 6*/

-- 1. łącznej masy wszystkich pudełek czekoladek znajdujących się w cukierni,

WITH xyz AS(
	SELECT p.idpudelka, SUM(cz.masa * z.sztuk) suma
	FROM 
		pudelka p 
		INNER JOIN zawartosc z USING(idpudelka)
		INNER JOIN czekoladki cz USING(idczekoladki)
	GROUP BY p.idpudelka
	)
SELECT SUM(xyz.suma)
FROM xyz

-- 2. ★ łącznej wartości wszystkich pudełek czekoladek znajdujących się w cukierni.

SELECT SUM(p.cena)
FROM pudelka p

/*Exercise 7*/

-- 1. zysk ze sprzedaży jednej sztuki poszczególnych pudełek (różnica między ceną pudełka i kosztem jego wytworzenia),

SELECT p.idpudelka, p.cena - SUM(cz.koszt * z.sztuk)
FROM
	pudelka p 
	INNER JOIN zawartosc z USING(idpudelka)
	INNER JOIN czekoladki cz USING(idczekoladki)
GROUP BY p.idpudelka

-- 2. zysk ze sprzedaży zamówionych pudełek,

WITH tablica_zamowien AS (
	WITH tablica_zysku AS (
	SELECT p.idpudelka, p.cena - SUM(cz.koszt * z.sztuk) as zysk_pudelka
	FROM
		pudelka p 
		INNER JOIN zawartosc z USING(idpudelka)
		INNER JOIN czekoladki cz USING(idczekoladki)
	GROUP BY p.idpudelka
	)
	SELECT zam.idzamowienia, SUM(a.sztuk * tablica_zysku.zysk_pudelka) AS zysk
	FROM 
		zamowienia zam
		INNER JOIN artykuly a USING(idzamowienia)
		INNER JOIN tablica_zysku USING(idpudelka)
	GROUP BY zam.idzamowienia
	)
SELECT SUM(tablica_zamowien.zysk)
FROM 
	tablica_zamowien

-- 3. ★ zysk ze sprzedaży wszystkich pudełek czekoladek w cukierni.

WITH tablica_zysku AS (
	SELECT p.idpudelka, p.cena - SUM(z.sztuk * cz.koszt) as zysk
	FROM
		pudelka p
		INNER JOIN zawartosc z USING(idpudelka)
		INNER JOIN czekoladki cz USING(idczekoladki)
	GROUP BY p.idpudelka
	)


SELECT SUM(tablica_zysku.zysk) 
FROM tablica_zysku

/*Exercise 8*/

-- 1. Napisz zapytanie wyświetlające: liczbę porządkową i identyfikator pudełka czekoladek (idpudelka). Identyfikatory pudełek mają być posortowane alfabetycznie, rosnąco. Liczba porządkowa jest z przedziału 1..N, gdzie N jest ilością pudełek.

SELECT
	ROW_NUMBER() OVER (ORDER BY p.idpudelka ASC) AS lp, p.idpudelka
FROM pudelka p
ORDER BY p.idpudelka ASC

--OR

SELECT COUNT(p2.idpudelka) as lp, p1.idpudelka
FROM pudelka p1 JOIN pudelka p2 ON p1.idpudelka >= p2.idpudelka
GROUP BY p1.idpudelka
ORDER BY p1.idpudelka ASC