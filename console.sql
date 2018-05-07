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
    town_id INTEGER NOT NULL PRIMARY KEY,
    town_nm VARCHAR(30),
    mayor_nm VARCHAR(60),
    education_coeff FLOAT CHECK(education_coeff < 100 AND education_coeff > 0)
);

CREATE TABLE PARTY(
    party_id INTEGER NOT NULL PRIMARY KEY ,
    town_id INTEGER NOT NULL REFERENCES TOWN(town_id),
    party_type_code VARCHAR(10) NOT NULL CHECK (party_type_code = 'Учитель' or
    party_type_code = 'Ученик' or party_type_code = 'Горожанин'),
    first_nm VARCHAR(20),
    second_nm VARCHAR(20),
    birth_dt DATE
);

CREATE TABLE POLICE_DEPARTMENT(
    police_id INTEGER NOT NULL PRIMARY KEY ,
    town_id INTEGER NOT NULL REFERENCES TOWN(town_id),
    address_txt VARCHAR(100),
    phone_no VARCHAR(11),
    close_case_coeff FLOAT CHECK (close_case_coeff < 100 AND close_case_coeff >= 0)
);

CREATE TABLE PARTY_X_POLICE_DEPARTMENT(
    police_id INTEGER NOT NULL REFERENCES POLICE_DEPARTMENT(police_id),
    party_id INTEGER NOT NULL REFERENCES PARTY(party_id)
);

CREATE TABLE LIBRARY(
    library_id INTEGER NOT NULL PRIMARY KEY,
    town_id INTEGER NOT NULL REFERENCES TOWN(town_id),
    address_txt VARCHAR(100),
    phone_no VARCHAR(11),
    main_book_nm VARCHAR(25)
);

CREATE TABLE PARTY_x_LIBRARY(
    library_id INTEGER NOT NULL REFERENCES LIBRARY(library_id),
    party_id INTEGER NOT NULL REFERENCES PARTY(party_id)
);

CREATE TABLE SCHOOL(
    school_id INTEGER NOT NULL PRIMARY KEY ,
    town_id INTEGER NOT NULL REFERENCES TOWN(town_id),
    school_no INTEGER NOT NULL,
    address_txt VARCHAR(100) NOT NULL,
    grant_amt INTEGER,
    yard_flg INTEGER CHECK (yard_flg <= 1 AND yard_flg >= 0),
    sponsor_nm VARCHAR(30)
);

CREATE TABLE SCHOOL_X_PARTY(
    school_id INTEGER NOT NULL REFERENCES SCHOOL(school_id),
    party_id INTEGER NOT NULL  REFERENCES PARTY(party_id)
);

CREATE TABLE CLASS(
    class_id INTEGER NOT NULL PRIMARY KEY ,
    school_id INTEGER NOT NULL REFERENCES SCHOOL(school_id),
    class_num INTEGER NOT NULL CHECK (class_num >= 1 AND class_num <= 11),
    character_value VARCHAR(1),
    progress_coeff FLOAT CHECK (progress_coeff <= 100 AND progress_coeff >= 0)
);

CREATE TABLE CLASS_X_PARTY(
    class_id INTEGER NOT NULL REFERENCES CLASS(class_id),
    party_id INTEGER NOT NULL REFERENCES PARTY(party_id)
);
 