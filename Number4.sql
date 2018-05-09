DROP  DATABASE IF EXISTS My_project;
DROP TABLE IF EXISTS TOWN CASCADE;
DROP TABLE IF EXISTS PARTY CASCADE;
DROP TABLE IF EXISTS POLICE_DEPARTMENT CASCADE;
DROP TABLE IF EXISTS PARTY_X_POLICE_DEPARTMENT CASCADE ;
DROP TABLE IF EXISTS SCHOOL CASCADE ;
DROP TABLE IF EXISTS LIBRARY CASCADE ;
DROP TABLE IF EXISTS PARTY_x_LIBRARY CASCADE ;
DROP TABLE IF EXISTS SCHOOL_X_PARTY CASCADE ;
DROP TABLE IF EXISTS CLASS CASCADE ;
DROP TABLE IF EXISTS CLASS_X_PARTY CASCADE ;
CREATE DATABASE My_project;


CREATE TABLE TOWN(
    town_id SERIAL PRIMARY KEY,
    town_nm VARCHAR(30),
    mayor_nm VARCHAR(60),
    education_coeff FLOAT CHECK(education_coeff < 100 AND education_coeff > 0)
);
INSERT INTO TOWN(town_nm, mayor_nm, education_coeff)
    VALUES ('Kemerovo', 'Grigory Petrov', 56.5),
        ('Kursk', 'Dmitriy Akunin', 47.567),
        ('Korolev', 'Aleksandr Hodorev', 78.59);

CREATE TABLE PARTY(
    party_id SERIAL PRIMARY KEY ,
    town_id INTEGER NOT NULL REFERENCES TOWN(town_id),
    party_type_code VARCHAR(10) NOT NULL CHECK (party_type_code = 'Учитель' or
    party_type_code = 'Ученик' or party_type_code = 'Горожанин'),
    first_nm VARCHAR(20),
    second_nm VARCHAR(20),
    birth_dt VARCHAR(10)
);
INSERT INTO PARTY(town_id, party_type_code, first_nm, second_nm, birth_dt)
    VALUES (1, 'Учитель', 'Olga', 'Busova', '02.03.1966'),
        (1, 'Учитель', 'Kiril', 'Masuka', '05.07.1940'),
        (1, 'Ученик', 'Nastya', 'Volkova', '06.03.2003'),
        (1, 'Ученик', 'Oleg', 'Belov', '09.07.2002'),
        (1, 'Ученик', 'Slava', 'Perlov', '18.09.2002'),
        (2, 'Учитель', 'Parfyan', 'Argrusovich', '01.03.1980'),
        (2, 'Учитель', 'Isus', 'Navin', '09.11.1960'),
        (2, 'Ученик', 'Abagar', 'Orlov', '17.08.2000'),
        (2, 'Ученик', 'Maria', 'Frolova', '23.09.2001'),
        (2, 'Ученик', 'Albert', 'Gurkin', '12.04.2003'),
        (3, 'Учитель', 'Inocentiy', 'Paleolog', '09.09.1974'),
        (3, 'Учитель', 'Kerson', 'Punishvary', '27.10.1989'),
        (3, 'Ученик', 'Abagar', 'Orlov', '17.08.2000'),
        (3, 'Ученик', 'Maria', 'Frolova', '23.09.2001'),
        (3, 'Ученик', 'Albert', 'Geribalskiy', '12.04.2003'),
        (1, 'Горожанин', 'Artem', 'Miasniakov', '13.06.1973'),
        (1, 'Горожанин', 'Matvey', 'Grebenshiakov', '31.01.1978'),
        (2, 'Горожанин', 'Gregor', 'Finogenov', '21.05.1991'),
        (2, 'Горожанин', 'Anton', 'Deripaska', '18.07.1979'),
        (3, 'Горожанин', 'Veronika', 'Saakashvili', '24.08.1999'),
        (3, 'Горожанин', 'Maria', 'Timoshkina', '02.12.1970');
CREATE TABLE POLICE_DEPARTMENT(
    police_id SERIAL PRIMARY KEY ,
    town_id INTEGER NOT NULL REFERENCES TOWN(town_id),
    address_txt VARCHAR(100),
    phone_no VARCHAR(11),
    close_case_coeff FLOAT CHECK (close_case_coeff < 100 AND close_case_coeff >= 0)
);

INSERT INTO POLICE_DEPARTMENT(town_id, address_txt, phone_no, close_case_coeff)
    VALUES (1, 'Pervomaiskaya building 32/6', 89145678283, 67),
        (1, 'Pionerskaya building 12-A k. 4', 89778673386, 82),
        (1, 'Tereshkovoy building 5', 89883927273, 73),
        (2, 'Lenina building 6, k. 5', 89143325678, 46),
        (2, 'Kominterna building 3', 89235868724, 83),
        (2, 'Ogareva building 7', 89567741345, 67),
        (3, 'Mendeleeva building 34 k.1', 89236835613, 75),
        (3, 'Krasnooktiaborskay building 3 k. 2', 89015675413, 56),
        (3, 'Krivouhova building 7', 89124578719, 59);


CREATE TABLE PARTY_X_POLICE_DEPARTMENT(
    police_id INTEGER NOT NULL REFERENCES POLICE_DEPARTMENT(police_id),
    party_id INTEGER NOT NULL REFERENCES PARTY(party_id)
);

INSERT INTO PARTY_X_POLICE_DEPARTMENT(police_id, party_id)
    VALUES (1, 17),
        (1, 4),
        (2, 16),
        (2, 17),
        (3, 5),
        (3, 16),
        (4, 19),
        (5, 19),
        (5, 18),
        (6, 18),
        (4, 10),
        (6, 7),
        (7, 20),
        (8, 21),
        (9, 20),
        (9, 21),
        (7, 15),
        (8, 12);

CREATE TABLE LIBRARY(
    library_id SERIAL PRIMARY KEY,
    town_id INTEGER NOT NULL REFERENCES TOWN(town_id),
    address_txt VARCHAR(100),
    phone_no VARCHAR(11),
    main_book_nm VARCHAR(30)
);

INSERT INTO LIBRARY(town_id, address_txt, phone_no, main_book_nm)
    VALUES (1, 'street Pionerskaya, building 12a', '89099217511','Dorian Gray'),
        (2,'street Lomonosova, building №2','84955138955','Hobbit'),
        (3,'street Gogolaya, building 21','89095164346','Lights in the ocean'),
        (1,'Lucky street, building 4','84982341109','Murder on the Orient Express'),
        (1,'street Pionerskaya, building 1','89091234567','Pride and prejudice'),
        (2,'street Pervomayskaya, building 1','84954312122','Crime and punishment'),
        (2, 'Menyaeva street, building 3', '89163368214', 'Tristan and Isolda'),
        (3, 'Korolevskaya street, building 77', '84955168955', 'Dontsova style'),
        (3, 'Reterburshskaya street, building 56', '89165673218', 'Russian vs American');

CREATE TABLE PARTY_X_LIBRARY(
    library_id INTEGER NOT NULL REFERENCES LIBRARY(library_id),
    party_id INTEGER NOT NULL REFERENCES PARTY(party_id)
);

INSERT INTO PARTY_X_LIBRARY(library_id, party_id)
    VALUES (1, 17),
        (1, 5),
        (4, 5),
        (4, 2),
        (5, 3),
        (2, 7),
        (2, 6),
        (6, 18),
        (7, 8),
        (3, 21),
        (8, 13),
        (8, 12),
        (9, 15);

CREATE TABLE SCHOOL(
    school_id SERIAL PRIMARY KEY ,
    town_id INTEGER NOT NULL REFERENCES TOWN(town_id),
    school_no INTEGER NOT NULL,
    address_txt VARCHAR(100) NOT NULL,
    grant_amt INTEGER,
    yard_flg INTEGER CHECK (yard_flg <= 1 AND yard_flg >= 0),
    sponsor_nm VARCHAR(30)
);

INSERT INTO SCHOOL(town_id, school_no, address_txt, grant_amt, yard_flg, sponsor_nm)
    VALUES(1, 13, 'Pionerskaya street, building 8', NULL , 1, NULL),
        (1, 5, 'Gedeleva street, building 34', 100000, 0, NULL ),
        (2, 77, 'Traurnay street, building 13', NULL, 1, 'ADIDAS'),
        (2, 42, 'Ulianovskaya street, building 8', 1000000, 1, 'POST OF RUSSIA'),
        (3, 1, 'Mendeleevskaya street, building 11', NULL , 0, 'AZINO 777'),
        (3, 17, 'Oktybrskaya street, building 4', 2000000, 1, NULL );

CREATE TABLE SCHOOL_X_PARTY(
    school_id INTEGER NOT NULL REFERENCES SCHOOL(school_id),
    party_id INTEGER NOT NULL  REFERENCES PARTY(party_id)
);

INSERT INTO SCHOOL_X_PARTY(school_id, party_id)
    VALUES(1, 1),
        (2, 2),
        (2, 1),
        (3, 6),
        (3, 7),
        (4, 7),
        (5, 11),
        (6, 11),
        (6, 12);

CREATE TABLE CLASS(
    class_id SERIAL PRIMARY KEY ,
    school_id INTEGER NOT NULL REFERENCES SCHOOL(school_id),
    class_num INTEGER NOT NULL CHECK (class_num >= 1 AND class_num <= 11),
    character_value VARCHAR(1),
    progress_coeff FLOAT CHECK (progress_coeff <= 100 AND progress_coeff >= 0)
);

INSERT INTO CLASS(school_id, class_num, character_value, progress_coeff)
    VALUES(1, 7, 'A', 67.5),
        (2, 8, 'A', 45.789),
        (2, 9, 'B', 67.9),
        (3, 7, 'A', 59.123),
        (3, 9, 'C', 33.8),
        (4, 8, 'B', 52.4),
        (5, 10, 'A', 46.78),
        (6, 9, 'C', 56.55);


CREATE TABLE CLASS_X_PARTY(
    class_id INTEGER NOT NULL REFERENCES CLASS(class_id),
    party_id INTEGER NOT NULL REFERENCES PARTY(party_id)
);

INSERT INTO CLASS_X_PARTY(class_id, party_id) VALUES
    (1, 3),
    (2, 4),
    (3, 5),
    (4, 10),
    (5, 9),
    (6, 8),
    (7, 15),
    (8, 14),
    (8, 13);