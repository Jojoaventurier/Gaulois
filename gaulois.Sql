

-- 1. 

    SELECT *
    FROM lieu
    WHERE nom_lieu
    LIKE '%um'


-- 2. 

    SELECT id_lieu, COUNT(personnage.id_lieu)
    FROM personnage
    GROUP BY personnage.id_lieu
    ORDER BY COUNT(id_personnage) DESC

        -- ou mieux--

        SELECT lieu.nom_lieu, personnage.id_lieu, COUNT(personnage.id_lieu)
        FROM personnage
        LEFT JOIN lieu ON personnage.id_lieu = lieu.id_lieu
        GROUP BY personnage.id_lieu
        ORDER BY COUNT(id_personnage) DESC


-- 3. 

    SELECT nom_personnage, id_specialite, adresse_personnage, id_lieu
    FROM personnage
    ORDER BY id_lieu, nom_personnage


-- 4. 

    SELECT specialite.nom_specialite, COUNT(nom_personnage)
    FROM personnage
    LEFT JOIN specialite ON personnage.id_specialite = specialite.id_specialite
    GROUP BY personnage.id_specialite
    ORDER BY COUNT(id_personnage) DESC


-- 5. 

    SELECT nom_bataille, DATE_FORMAT(date_bataille, '%d-%m-%Y'), lieu.nom_lieu
    FROM bataille
    INNER JOIN lieu ON bataille.id_lieu = lieu.id_lieu
    ORDER BY (date_bataille)

        -- (Note: Avec RIGHT JOIN ou LEFT JOIN, au lieu de INNER JOIN, on peut afficher en plus les lieux dans lesquels il n'y a pas eu de bataille, ce qui n'est pas le cas avec INNER JOIN)


-- 6. 

    SELECT potion.nom_potion, composer.id_potion, SUM(qte * cout_ingredient) 
    FROM composer
    INNER JOIN ingredient ON composer.id_ingredient = ingredient.id_ingredient
    INNER JOIN potion ON composer.id_potion = potion.id_potion
    GROUP BY id_potion
    ORDER BY SUM(qte * cout_ingredient) DESC


-- 7. 

    SELECT nom_ingredient, cout_ingredient, qte, qte * cout_ingredient AS 'total coût ingrédients'
    FROM composer c, ingredient i, potion p
    WHERE c.id_ingredient = i.id_ingredient
    AND c.id_potion = p.id_potion
    AND p.nom_potion LIKE 'Santé'

            -- ou moins bien :  (pas spécialement besoin de sous requête) --
        SELECT nom_ingredient, cout_ingredient, qte, qte * cout_ingredient AS 'total coût ingrédients'
        FROM composer c, ingredient i
        WHERE c.id_ingredient = i.id_ingredient
        AND c.id_potion LIKE (SELECT DISTINCT p.id_potion
                                    FROM composer c, potion p
                                    WHERE c.id_potion = p.id_potion
                                    AND p.nom_potion = 'Santé')

    
-- 8. 

    SELECT personnage.nom_personnage, SUM(qte) AS casques_pris
    FROM prendre_casque
    INNER JOIN personnage ON prendre_casque.id_personnage = personnage.id_personnage
    WHERE id_bataille = 1
    GROUP BY prendre_casque.id_personnage   
    ORDER BY casques_pris DESC


    -- CORRECTION :
     -- manque la somme des casques différents ramassés ? -- -- manque la somme des casques différents ramassés ? -- -- manque la somme des casques différents ramassés ? --
     -- manque la somme des casques différents ramassés ? -- -- manque la somme des casques différents ramassés ? -- -- manque la somme des casques différents ramassés ? --
            SELECT nom_personnage, qte AS 'Nb de casques'
            FROM personnage v, bataille b, prendre_casque pc
            WHERE v.id_personnage = pc.id_personnage
            AND b.id_bataille = pc.id_bataille
            AND nom_bataille = 'Bataille du village gaulois'
            AND qte IN (SELECT MAX(qte)
            FROM bataille b, prendre_casque pc
            WHERE b.id_bataille = pc.id_bataille
            AND nom_bataille = 'Bataille du village gaulois')
    -- manque la somme des casques différents ramassés ? -- -- manque la somme des casques différents ramassés ? -- -- manque la somme des casques différents ramassés ? --
    -- manque la somme des casques différents ramassés ? -- -- manque la somme des casques différents ramassés ? -- -- manque la somme des casques différents ramassés ? --


-- 9. 

    SELECT nom_personnage, SUM(dose_boire) AS 'Total bu'
    FROM boire b, personnage p
    WHERE b.id_personnage = p.id_personnage
    GROUP BY nom_personnage
    ORDER BY SUM(dose_boire) DESC


-- 10. 

    SELECT bataille.nom_bataille, SUM(qte) AS casques_pris
    FROM prendre_casque
    INNER JOIN bataille ON prendre_casque.id_bataille = bataille.id_bataille
    GROUP BY prendre_casque.id_bataille   
    ORDER BY casques_pris DESC


-- 11. 

    SELECT nom_type_casque, SUM(cout_casque), COUNT(id_casque) AS nb_par_type
    FROM casque
    INNER JOIN type_casque ON casque.id_type_casque = type_casque.id_type_casque
    GROUP BY casque.id_type_casque
    ORDER BY nb_par_type DESC


-- 12. 

    SELECT nom_potion
    FROM composer c, potion p, ingredient i
    WHERE c.id_potion = p.id_potion
    AND c.id_ingredient = i.id_ingredient
    AND i.nom_ingredient LIKE 'Poisson frais'


-- 13. 

    SELECT nom_lieu, COUNT(id_personnage) AS compte
    FROM personnage
    RIGHT JOIN lieu ON personnage.id_lieu = lieu.id_lieu
    WHERE personnage.id_lieu != 1
    GROUP BY lieu.nom_lieu
    ORDER BY compte DESC

            -- CORRECTION : 

            SELECT nom_lieu, COUNT(*) AS 'Recensement'
            FROM personnage v, lieu l
            WHERE v.id_lieu = l.id_lieu
            AND nom_lieu != 'Village gaulois'
            GROUP BY l.id_lieu
            HAVING COUNT(*) = 
                (SELECT MAX(x) 
                FROM (SELECT COUNT(id_personnage) AS x
                        FROM personnage v, lieu l
                        WHERE v.id_lieu = l.id_lieu
                        AND nom_lieu != 'Village gaulois'
                        GROUP BY l.id_lieu) y)



-- 14.

    SELECT nom_personnage
    FROM boire
    RIGHT JOIN personnage ON boire.id_personnage = personnage.id_personnage
    WHERE dose_boire IS NULL


-- 15. 

    SELECT nom_personnage
    FROM autoriser_boire
    RIGHT JOIN personnage ON autoriser_boire.id_personnage = personnage.id_personnage
    WHERE autoriser_boire.id_personnage IS NULL



----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------- PARTIE 2 ---------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------


-- A. 

        INSERT INTO personnage (
        
            nom_personnage,
            adresse_personnage,
            image_personnage,
            id_lieu,
            id_specialite
        )
        
        VALUES (
        
            'Champdeblix',
            'ferme Hantassion',
            DEFAULT,
            (SELECT id_lieu FROM lieu WHERE nom_lieu LIKE 'Rotomagus'),
            (SELECT id_specialite FROM specialite WHERE nom_specialite LIKE 'Agriculteur')
        )

        -- (NOTE : pas besoin de mettre id_personnage, puisqu'il est configuré en "auto-increment")

        

-- B. 

        INSERT INTO autoriser_boire (
            id_potion, 
            id_personnage 
        )

        VALUES (
            (SELECT id_potion 
            FROM personnage pe, potion po 
            WHERE pe.id_personnage = po.id_personnage 
            AND nom_personnage = 'Iélosubmarine'),
            
            (SELECT id_personnage 
            FROM personnage 
            WHERE nom_personnage = 'Bonemine')
        )

-- C. 

    DELETE *
    FROM casque c
    JOIN type_casque tp ON c.id_type_casque = tp.id_type_casque
    LEFT JOIN prendre_casque pc ON c.id_casque = pc.id_casque --> je ne comprends pas pourquoi le résultate n'est pas le même avec RIGHT JOIN // peut être utiliser FULL OUTER JOIN pour éviter les surprises
    WHERE tp.nom_type_casque ='Grec'
    AND id_bataille IS NULL

-- D. 

    UPDATE personnage p, lieu l
    SET adresse_personnage = 'Prison', 
        p.id_lieu = (SELECT id_lieu FROM lieu  WHERE nom_lieu = 'Condate')
    WHERE p.nom_personnage LIKE 'Zérozérosix'
    AND p.id_lieu = l.id_lieu

-- E. 

    DELETE c.id_ingredient
    FROM composer c, ingredient i, potion p
    WHERE c.id_ingredient =	i.id_ingredient
    AND c.id_potion = p.id_potion
    AND nom_potion = 'Soupe'
    AND nom_ingredient = 'Persil'

-- F. 

    UPDATE prendre_casque pc
    SET pc.id_casque = (SELECT id_casque FROM casque WHERE nom_casque = 'Weisenau')
    WHERE pc.id_personnage = (SELECT id_personnage FROM personnage WHERE nom_personnage LIKE 'Obélix')
    AND pc.id_casque = (SELECT id_casque FROM casque WHERE nom_casque = 'Ostrogoth')
    AND pc.id_bataille = (SELECT id_bataille FROM bataille WHERE nom_bataille = 'Attaque de la banque postale')

