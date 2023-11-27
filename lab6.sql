/*Exercise 1*/

-- Napisz i wykonaj zapytanie (użyj INSERT), które dodaje do tabeli czekoladki następujące informacje:
-- idczekoladki: W98,
-- nazwa: Biały kieł,
-- czekolada: biała,
-- orzechy: laskowe,
-- nadzienie: marcepan,
-- opis: Rozpływające się w rękach i kieszeniach,
-- koszt: 45 gr,
-- masa: 20 g.

INSERT INTO 
	czekoladki (idczekoladki, nazwa, czekolada, orzechy, nadzienie, opis, koszt, masa) 
VALUES 
	('W98', 'Biały kieł', 'biała', 'laskowe', 'marcepan','Rozpływające się w rękach i kieszeniach', 0.45, 20)


INSERT INTO
	klienci (idklienta, nazwa, ulica, miejscowosc, kod, telefon)
VALUES
	(90, 'Matusiak Edward', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38'),
	(91, 'Matusiak Alina', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38'),
	(92, 'Kimono Franek', 'Karateków 8', 'Mistrz', '30-029', '501 498 324')


INSERT INTO
	klienci (idklienta, nazwa, ulica, miejscowosc, kod, telefon)
VALUES
(
	93,
	(SELECT nazwa FROM klienci WHERE idklienta = 90),
	(SELECT ulica FROM klienci WHERE idklienta = 90),
	(SELECT miejscowosc FROM klienci WHERE idklienta = 90),
	(SELECT kod FROM klienci WHERE idklienta = 90),
	(SELECT telefon FROM klienci WHERE idklienta = 90)
)



/*Exercise 2*/

INSERT INTO 
	czekoladki (idczekoladki,nazwa, czekolada, opis, koszt, masa)
VALUES
	('X91', 'Niewidzialna Nieznajoma', NULL , 'Niewidzialna czekoladka wspomagajaca odchudzanie.', 0.26, 0),
	('M98', 'Mleczny Raj', 'mleczna',  'Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem.', 0.26, 36)

/*Exercise 3*/

DELETE FROM czekoladki WHERE idczekoladki IN ('X91', 'M98')

/*Exercise 4*/

-- 1. Zmiana nazwiska Izy Matusiak na Nowak.
-- Obniżenie kosztu czekoladek o identyfikatorach (idczekoladki): W98, M98 i X91, o 10%.

UPDATE klienci SET nazwa = 'Iza Nowak' WHERE idklienta = 93


-- 2. Ustalenie kosztu czekoladek o nazwie Nieznana Nieznajoma na taką samą jak cena czekoladki o identyfikatorze W98.

UPDATE czekoladki SET koszt = (SELECT koszt FROM czekoladki WHERE idczekoladki = 'W98') WHERE nazwa = 'Niewidzialna Nieznajoma'

--OR

UPDATE czekoladki cz1 SET koszt = cz2.koszt
FROM czekoladki cz2
WHERE cz1.nazwa = 'Niewidzialna Nieznajoma' AND cz2.idczekoladki = 'W98';

-- 3. ★ Zmiana nazwy z Leningrad na Piotrograd w tabeli klienci.

UPDATE klienci SET miejscowosc='Piotrgard' WHERE miejscowosc = 'Leningrad'

-- 4. ★ Podniesienie kosztu czekoladek, których dwa ostatnie znaki identyfikatora (idczekoladki) są większe od 90, o 15 groszy.

UPDATE czekoladki cz SET koszt = cz.koszt + 0.15 WHERE substr(cz.idczekoladki, 2, 2)::int > 90

/*Exercise 5*/
-- Napisz instrukcje usuawające:
-- 1. klientach o nazwisku Matusiak,

DELETE FROM klienci WHERE nazwa LIKE 'Matusiak%'

-- 2. ★ klientach o identyfikatorze większym niż 91,

DELETE FROM klienci WHERE idklienta > 91

-- 3. ★ czekoladkach, których koszt jest większy lub równy 0.45 lub masa jest większa lub równa 36, lub masa jest równa 0.

DELETE FROM czekoladki
WHERE 
	koszt >= 0.45
	OR
	masa >= 36
	OR 
	masa = 0

/*Exercise 6*/

-- Napisz skrypt zawierający instrukcje INSERT wstawiające do bazy danych Cukiernia dwa nowe rekordy do tabeli Pudelka oraz odpowiednie rekordy związane z tymi pudełkami do tabeli Zawartosc. Każde z nowych pudełek ma zawierać łącznie co najmniej 10 czekoladek, w co najmniej 4 różnych smakach.

INSERT INTO 
	pudelka (idpudelka, nazwa, opis, cena, stan)
VALUES 
	(
		'clrc', 
		'Kolorowe Kawałki Słodyczy', 
		'"Kolorowe Kawałki Słodyczy" to magiczne pudełko, które przenosi Cię w świat niezwykłych doznań smakowych.',
		21.37,
		2137
	),
	(
		'fach',
		'Fantazja Czekoladowa',
		'"Fantazja Czekoladowa" to pudełko, w którym każde spojrzenie staje się przygodą, a każdy kęs to podróż w krainę wyjątkowych smaków.',
		37.21,
		2137
	
	)

INSERT INTO 
	zawartosc (idpudelka, idczekoladki, sztuk)
VALUES
	('clrc', 'b07', 2),
	('clrc', 'd03', 1),
	('clrc', 'd09', 4),
	('clrc', 'd11', 3),
	('fach', 'f02', 6),
	('fach', 'f01', 3),
	('fach', 'm04', 2),
	('fach', 'm07', 3)


/*Exercise 8*/

-- 1. Napisz instrukcję UDPATE, która dla pudełek dodanych w poprzednich dwóch zadaniach, zwiększa o 1 liczbę czekoladek każdego smaku, które w nich występują.

UPDATE zawartosc 
SET
sztuk = sztuk + 1
WHERE idpudelka IN ('clrc', 'fach')

-- 2. Napisz skrypt zawierający instrukcje UPDATE, które modyfikują tabelę czekoladki zastępując w kolumnach: czekolada, orzechy i nadzienie wartości Null wartością “brak”.

UPDATE czekoladki
SET 
	czekolada = COALESCE(czekolada, 'brak'),
	nadzienie = COALESCE(nadzienie, 'brak'),
	orzechy = COALESCE(orzechy, 'brak');

-- 3. ★ Napisz skrypt zawierający instrukcje UPDATE, które anulują zmiany wprowadzone w poprzednim punkcie.

UPDATE czekoladki
SET 
    czekolada = CASE WHEN czekolada = 'brak' THEN NULL ELSE czekolada END,
    orzechy = CASE WHEN orzechy = 'brak' THEN NULL ELSE orzechy END,
    nadzienie = CASE WHEN nadzienie = 'brak' THEN NULL ELSE nadzienie END;
