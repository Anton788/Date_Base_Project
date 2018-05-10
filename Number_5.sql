/*
Города, адрес полицейских участков и коеффициент раскрываемости, где коэффициент раскрываемости дел выше 50%
 */
SELECT town_nm
    ,   address_txt
    ,   close_case_coeff
FROM TOWN
    INNER JOIN
     POLICE_DEPARTMENT P
        ON TOWN.town_id = P.town_id  AND
            close_case_coeff > 50

/*
Вывести номер, адрес и количество классов каждой школы, получающей грант.
 */
SELECT school_no
    , address_txt
    , COUNT(class_num)*COUNT(character_value)
FROM
     SCHOOL
    INNER JOIN
     CLASS
    ON SCHOOL.school_id = CLASS.school_id AND
        grant_amt NOTNULL
GROUP BY school_no
    ,   address_txt
;

/*
Вывести учителей, которые работают в нескольких школах.
 */
SELECT first_nm
    , second_nm
FROM (
    SELECT first_nm
        , second_nm
        , COUNT(school_no)
    FROM (
        SCHOOL
        INNER JOIN
        SCHOOL_X_PARTY
        ON SCHOOL.school_id = SCHOOL_X_PARTY.school_id) X
        INNER JOIN
        PARTY
        ON X.party_id = PARTY.party_id
    GROUP BY first_nm
        , second_nm
    HAVING
        COUNT(school_no) >= 2) AS X2
;


/*
Вывести учителей, которые работают в нескольких школах и у которых есть класс с 2 или более учениками.
 */
SELECT first_nm
    , second_nm
FROM (
    SELECT first_nm
        , second_nm
    FROM (SCHOOL
        INNER JOIN
        SCHOOL_X_PARTY
        ON SCHOOL.school_id = SCHOOL_X_PARTY.school_id) X
        INNER JOIN
        PARTY
        ON X.party_id = PARTY.party_id
    GROUP BY first_nm
            , second_nm
    HAVING COUNT(school_no) >= 2) AS X2
INTERSECT
SELECT first_nm
    , second_nm
    FROM (
        SELECT first_nm
            , second_nm
            , class_id
        FROM (
            SELECT school_id
                , PARTY.town_id
                , first_nm
                , second_nm
            FROM (
                SELECT SCHOOL.school_id
                    , town_id
                    , school_no
                    , party_id
                FROM SCHOOL
               INNER JOIN
                SCHOOL_X_PARTY
                    ON SCHOOL.school_id= SCHOOL_X_PARTY.school_id) X
            INNER JOIN
             PARTY
                ON X.party_id = PARTY.party_id) Y
        INNER JOIN
                CLASS
                ON CLASS.school_id = Y.school_id) Z
    WHERE
        Z.class_id = (SELECT class_id
                            FROM PARTY
                        INNER JOIN
                            CLASS_X_PARTY C2
                            ON PARTY.party_id = C2.party_id
                        GROUP BY
                            class_id
                        HAVING
                            COUNT(C2.party_id) >= 2)
;