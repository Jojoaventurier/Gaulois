-- A partir du script SQL Gaulois, écrivez et executez les requêtes suivantes : --

-- 1. Nom des lieux qui finissent par 'um'

    SELECT *
    FROM lieu
    WHERE nom_lieu
    LIKE '%um'


-- 2. Nombre de personnages par lieu (trié par nombre de personnages décroissant)

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


-- 3. Nom des personnages + spécialité + adresse et lieu d'habitation, triés par lieu puis par nom de personnage

    SELECT nom_personnage, id_specialite, adresse_personnage, id_lieu
    FROM personnage
    ORDER BY id_lieu, nom_personnage


-- 4. Nom des spécialités avec nombre de personnages par spécialité (trié par nombre de personnages décroissant)

    SELECT specialite.nom_specialite, COUNT(nom_personnage)
    FROM personnage
    LEFT JOIN specialite ON personnage.id_specialite = specialite.id_specialite
    GROUP BY personnage.id_specialite
    ORDER BY COUNT(id_personnage) DESC


-- 5. Nom, date et lieu des batailles, classées de la plus récente à la plus ancienne (dates affichées au format jj/mm/aaaa)

    SELECT nom_bataille, DATE_FORMAT(date_bataille, '%d-%m-%Y'), lieu.nom_lieu
    FROM bataille
    INNER JOIN lieu ON bataille.id_lieu = lieu.id_lieu
    ORDER BY (date_bataille)

        -- (Note: Avec RIGHT JOIN ou LEFT JOIN, au lieu de INNER JOIN, on peut afficher en plus les lieux dans lesquels il n'y a pas eu de bataille, ce qui n'est pas le cas avec INNER JOIN)


-- 6. Nom des potions + coût de réalisation de la potion (trié par coût décroissant)

    SELECT potion.nom_potion, composer.id_potion, SUM(qte * cout_ingredient) 
    FROM composer
    INNER JOIN ingredient ON composer.id_ingredient = ingredient.id_ingredient
    INNER JOIN potion ON composer.id_potion = potion.id_potion
    GROUP BY id_potion
    ORDER BY SUM(qte * cout_ingredient) DESC


-- 7. Nom des ingrédients + coût + quantité de chaque ingrédient qui composent la potion 'Santé'.

    SELECT ingredient.nom_ingredient, cout_ingredient, qte, qte * cout_ingredient
    FROM composer
    INNER JOIN potion ON composer.id_potion = potion.id_potion
    INNER JOIN ingredient ON composer.id_ingredient = ingredient.id_ingredient
    WHERE composer.id_potion = 3

    
-- 8. Nom du ou des personnages qui ont pris le plus de casques dans la bataille 'Bataille du village gaulois'

    SELECT personnage.nom_personnage, SUM(qte) AS casques_pris
    FROM prendre_casque
    INNER JOIN personnage ON prendre_casque.id_personnage = personnage.id_personnage
    WHERE id_bataille = 1
    GROUP BY prendre_casque.id_personnage   
    ORDER BY casques_pris DESC

-- 9. Nom des personnages et leur quantité de potion bue (en les classant du plus grand buveur au plus petit)

    SELECT nom_personnage, dose_boire, date_boire
    FROM boire
    INNER JOIN personnage ON boire.id_personnage = personnage.id_personnage
    ORDER BY dose_boire DESC


-- 10. Nom de la bataille où le nombre de casques pris a été le plus important

    SELECT bataille.nom_bataille, SUM(qte) AS casques_pris
    FROM prendre_casque
    INNER JOIN bataille ON prendre_casque.id_bataille = bataille.id_bataille
    GROUP BY prendre_casque.id_bataille   
    ORDER BY casques_pris DESC


-- 11. Combien existe-t-il de casques de chaque type et quel est leur coût total ? (classés par nombre décroissant)

    SELECT nom_type_casque, SUM(cout_casque), COUNT(id_casque) AS nb_par_type
    FROM casque
    INNER JOIN type_casque ON casque.id_type_casque = type_casque.id_type_casque
    GROUP BY casque.id_type_casque
    ORDER BY nb_par_type DESC


-- 12. Nom des potions dont un des ingrédients est le poisson frais. 



-- 13. Nom du/des lieu(x) possédant le plus d'habitants, en dehors du village gaulois.

-- 14. Nom des personnages qui n'ont jamais vu aucune potion

-- 15. Nom du/des personnages qui n'ont pas le droit de boire de la potion 'magique'. 