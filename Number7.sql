DROP VIEW IF EXISTS PARTY_V;
DROP VIEW IF EXISTS POLICE_D;
DROP VIEW IF EXISTS TOWN_V;
DROP VIEW IF EXISTS LIBRARY_V;
DROP VIEW IF EXISTS SCHOOL_V;
DROP VIEW IF EXISTS CLASS_V;

CREATE VIEW PARTY_V
    AS (
        SELECT party_type_code
            ,   first_nm
            ,   second_nm
            ,   (CASE
                    WHEN
                        party_type_code = 'Учитель'
                            THEN
                                SUBSTRING(birth_dt, 0, 3) || '*******' || SUBSTRING(birth_dt, 8, 3)
                    ELSE
                        birth_dt
                END)
        FROM
            PARTY
);

CREATE VIEW POLICE_D
    AS (
        SELECT address_txt
            ,   CASE
                    WHEN
                        TRUE
                        THEN
                            SUBSTRING(phone_no, 1, 2) || '*******' || SUBSTRING(phone_no, 10, 2)
                END
            ,   close_case_coeff
        FROM
            POLICE_DEPARTMENT
);

CREATE VIEW LIBRARY_V
    AS (
        SELECT address_txt
            ,   CASE
            WHEN
                TRUE
                THEN
                    SUBSTRING(phone_no, 1, 2) || '*******' || SUBSTRING(phone_no, 10, 2)
                END
            ,   main_book_nm
        FROM
            LIBRARY
);

CREATE VIEW SCHOOL_V
    AS (
        SELECT school_no
            ,   address_txt
            ,   grant_amt
            ,   yard_flg
            ,   CASE
                    WHEN
                        sponsor_nm NOTNULL
                        THEN
                            SUBSTRING(sponsor_nm, 0, 3) || '****'
                    ELSE
                        sponsor_nm
                END
        FROM
            SCHOOL
);

CREATE VIEW CLASS_V
    AS (
        SELECT class_num
            ,    character_value
            ,   CASE
                    WHEN progress_coeff < 50
                        THEN
                            NULL
                    ELSE progress_coeff
                END
        FROM
            CLASS
);