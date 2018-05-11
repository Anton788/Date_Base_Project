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
Вывести номер, адрес и наиболее успешные классы(те у которых коэффициент обучаемости самый большой) каждой школы,
получающей грант.
 */
SELECT school_no
    , address_txt
    , (class_num
    , character_value) AS best_class
FROM(
    (SELECT CLASS.school_id
         , school_no
         , class_num
         , address_txt
         , progress_coeff
         , character_value
         , grant_amt
     FROM
        SCHOOL
    INNER JOIN
        CLASS
    ON SCHOOL.school_id = CLASS.school_id) X
    INNER JOIN
    (SELECT CLASS.school_id
         , MAX(progress_coeff) AS best_coeff
            FROM
                CLASS
                INNER JOIN
                SCHOOL S2
                    ON CLASS.school_id = S2.school_id
            GROUP BY CLASS.school_id
        ) Y
    ON X.school_id = Y.school_id AND
    best_coeff = progress_coeff) Z
WHERE Z.grant_amt NOTNULL
;

/*
Вывести учителей, которые работают в нескольких школах.
 */
SELECT first_nm
    , second_nm
FROM(
    PARTY
    INNER JOIN
    (SELECT PARTY.party_id
         , COUNT (school_id)
    FROM (
        (SELECT
            SCHOOL.school_id
            , party_id
        FROM (
            SCHOOL
            INNER JOIN
            SCHOOL_X_PARTY
            ON SCHOOL.school_id = SCHOOL_X_PARTY.school_id)) X
        INNER JOIN
        PARTY
        ON X.party_id = PARTY.party_id
    )
    GROUP by PARTY.party_id
    HAVING COUNT (school_id) >= 2) Y
    ON PARTY.party_id = Y.party_id
);


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

/*
Для каждой библиотеки, посчитать сколько в нее ходит учеников. Выыести адрес и количество учеников-посетителей.
 */

SELECT  address_txt
    , COUNT(party_id) AS NUMBER_OF_STUDENTS
FROM (
    SELECT library_id
        , address_txt
        , Party.party_id
        , party_type_code
    FROM
        (SELECT LIBRARY.library_id, address_txt, party_id
         FROM
             LIBRARY
            INNER JOIN
             PARTY_X_LIBRARY
                ON LIBRARY.library_id = PARTY_X_LIBRARY.library_id) X
            INNER JOIN
                PARTY
            ON X.party_id = PARTY.party_id) Y
    WHERE
        party_type_code = 'Ученик'
GROUP BY
    address_txt
;
