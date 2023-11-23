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
