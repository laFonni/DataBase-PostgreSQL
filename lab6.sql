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


-- Napisz i wykonaj zapytanie, które doda do tabeli czekoladki następujące pozycje, wykorzystaj wartości NULL w poleceniu INSERT:
-- IDCzekoladki: X91,
-- Nazwa: Nieznana Nieznajoma,
-- Opis: Niewidzialna czekoladka wspomagajaca odchudzanie.,
-- Koszt: 26 gr,
-- Masa: 0g,

-- IDCzekoladki: M98,
-- Nazwa: Mleczny Raj,
-- Czekolada: Mleczna,
-- Opis: Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem.,
-- Koszt: 26 gr,
-- Masa: 36 g,

INSERT INTO 
	czekoladki ()

/*Exercise 2*/