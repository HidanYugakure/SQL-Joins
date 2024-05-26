CREATE DATABASE Restaurant;
USE Restaurant;

CREATE TABLE Yemekler (
    Id INT PRIMARY KEY IDENTITY (1,1),
    Ad NVARCHAR(150) NOT NULL,
    Qiymet DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Masalar (
    Id INT PRIMARY KEY IDENTITY (1,1),
    Nomre INT NOT NULL
);

CREATE TABLE Sifarish (
    Id INT PRIMARY KEY IDENTITY (1,1),
    MasaId INT NOT NULL FOREIGN KEY REFERENCES Masalar(Id),
    YemekId INT NOT NULL FOREIGN KEY REFERENCES Yemekler(Id),
    Tarix DATETIME NOT NULL,
    Saat DATETIME NOT NULL
);

INSERT INTO Yemekler (Ad, Qiymet) VALUES
('Pizza', 10.00),
('Burger', 8.50),
('Salad', 5.00);

INSERT INTO Masalar (Nomre) VALUES
(1),
(2),
(3);

INSERT INTO Sifarish (MasaId, YemekId, Tarix, Saat) VALUES
(1, 1, '2024-05-25', '2024-05-25 12:00:00'),
(2, 2, '2024-05-25', '2024-05-25 12:30:00'),
(3, 3, '2024-05-25', '2024-05-25 13:00:00');

SELECT M.Id, M.Nomre, COUNT(S.Id) AS SifarisSayi
FROM Masalar M
LEFT JOIN Sifarish S ON M.Id = S.MasaId
GROUP BY M.Id, M.Nomre;

SELECT Y.Id, Y.Ad, COUNT(S.Id) AS SifarisSayi
FROM Yemekler Y
LEFT JOIN Sifarish S ON Y.Id = S.YemekId
GROUP BY Y.Id, Y.Ad;

SELECT S.Id, S.MasaId, S.Tarix, S.Saat, Y.Ad AS YemekAdi
FROM Sifarish S
JOIN Yemekler Y ON S.YemekId = Y.Id;

SELECT S.Id, S.Tarix, S.Saat, Y.Ad AS YemekAdi, M.Nomre AS MasaNomresi
FROM Sifarish S
JOIN Yemekler Y ON S.YemekId = Y.Id
JOIN Masalar M ON S.MasaId = M.Id;

SELECT M.Id, M.Nomre, SUM(Y.Qiymet) AS UmumiMebleg
FROM Masalar M
LEFT JOIN Sifarish S ON M.Id = S.MasaId
LEFT JOIN Yemekler Y ON S.YemekId = Y.Id
GROUP BY M.Id, M.Nomre;

SELECT DATEDIFF(HOUR, MIN(S.Saat), MAX(S.Saat)) AS SaatFarki
FROM Sifarish S
WHERE S.MasaId = 1;

SELECT M.Id, M.Nomre
FROM Masalar M
LEFT JOIN Sifarish S ON M.Id = S.MasaId
WHERE S.Id IS NULL;

SELECT * 
FROM Sifarish
WHERE Saat < DATEADD(MINUTE, -30, GETDATE());


