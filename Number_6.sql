CREATE TABLE TOWN(
    town_id SERIAL PRIMARY KEY
    ,   town_nm VARCHAR(30)
    ,   mayor_nm VARCHAR(60)
    ,   education_coeff FLOAT CHECK(education_coeff < 100
                                AND education_coeff > 0)
);

INSERT INTO TOWN(town_nm, mayor_nm, education_coeff)
    VALUES ('Kemerovo', 'Grigory Petrov', 56.5),
        ('Kursk', 'Dmitriy Akunin', 47.567);

UPDATE TOWN
SET town_nm = 'Moscow', education_coeff = 89.9
WHERE town_id = 1
;

SELECT *
FROM TOWN
;

DELETE FROM TOWN;

DROP TABLE TOWN;

CREATE TABLE PARTY(
    party_id SERIAL PRIMARY KEY
    ,   town_id INTEGER NOT NULL REFERENCES TOWN(town_id)
    ,   party_type_code VARCHAR(10) NOT NULL CHECK (party_type_code = 'Учитель'
                                                    OR party_type_code = 'Ученик'
                                                    OR party_type_code = 'Горожанин')
    ,   first_nm VARCHAR(20)
    ,   second_nm VARCHAR(20)
    ,   birth_dt VARCHAR(10)
);

INSERT INTO PARTY(town_id, party_type_code, first_nm, second_nm, birth_dt)
    VALUES (1, 'Учитель', 'Olga', 'Busova', '02.03.1966');

UPDATE PARTY
SET town_id = 1, party_type_code = 'Ученик', first_nm  = 'Matvey', second_nm = 'Kifilskyi'
;

SELECT party_type_code, first_nm, second_nm
FROM PARTY
;

DELETE FROM PARTY;

DROP TABLE PARTY;