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
