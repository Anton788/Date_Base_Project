DROP VIEW IF EXISTS PARTY_V_TOWN;
DROP VIEW IF EXISTS SCHOOL_V_TOWN;

CREATE VIEW SCHOOL_V_TOWN
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
            ,   town_nm
            ,   education_coeff
        FROM
            SCHOOL
        INNER JOIN
            TOWN
            ON SCHOOL.town_id = TOWN.town_id
);

CREATE VIEW PARTY_V_TOWN
    AS (SELECT party_type_code,
            ,   first_nm
            ,   second_nm
            ,   (CASE
                    WHEN
                        party_type_code = 'Учитель'
                        AND TOWN.town_id = 1
                            THEN
                                SUBSTRING(birth_dt, 0, 3) || '*******' || SUBSTRING(birth_dt, 8, 3)
                    ELSE
                        birth_dt
                    END)
            ,   town_nm
            ,   education_coeff
    FROM
        PARTY
    INNER JOIN
        TOWN
    ON PARTY.town_id = TOWN.town_id
);
