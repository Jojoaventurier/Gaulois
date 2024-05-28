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
    ORDER BY COUNT(nom_personnage) DESC

        -- ou mieux--

        SELECT lieu.nom_lieu, personnage.id_lieu, COUNT(personnage.id_lieu)
        FROM personnage
        LEFT JOIN lieu ON personnage.id_lieu = lieu.id_lieu
        GROUP BY personnage.id_lieu
        ORDER BY COUNT(nom_personnage) DESC


-- 3. Nom des personnages + spécialité + adresse et lieu d'habitation, triés par lieu puis par nom de personnage

    SELECT nom_personnage, id_specialite, adresse_personnage, id_lieu
    FROM personnage
    ORDER BY id_lieu, nom_personnage


-- 4. Nom des spécialités avec nombre de personnages par spécialité (trié par nombre de personnages décroissant)

    SELECT specialite.nom_specialite, COUNT(nom_personnage)
    FROM personnage
    LEFT JOIN specialite ON personnage.id_specialite = specialite.id_specialite
    GROUP BY nom_specialite
    ORDER BY COUNT(nom_personnage) DESC


-- 5. Nom, date et lieu des batailles, classées de la plus récente à la plus ancienne (dates affichées au format jj/mm/aaaa)

    SELECT nom_bataille, date_bataille, lieu.nom_lieu
    FROM bataille
    INNER JOIN lieu ON bataille.id_lieu = lieu.id_lieu
    ORDER BY (date_bataille)

        -- Note: Avec RIGHT JOIN ou LEFT JOIN, au lieu de INNER JOIN, on peut afficher en plus les lieux dans lesquels il n'y a pas eu de bataille, ce qui n'est pas le cas avec INNER JOIN

-- 6. Nom des potions + coût de réalisation de la potion (trié par coût décroissant)

-- 7. Nom des ingrédients + coût + quantité de chaque ingrédient qui composent la potion 'Santé'.

-- 8. Nom du ou des personnages qui ont pris le plus de casques dans la bataille 'Bataille du village gaulois'

-- 9. Nom des personnages et leur quantité de potion bue (en les classant du plus grand buveur au plus petit)

-- 10. Nom de la bataille où le nombre de casques pris a été le plus important

-- 11. Combien existe-t-il de casques de chaque type et quel est leur coût total ? (classés par nombre décroissant)

-- 12. Nom des potions dont un des ingrédients est le poisson frais. 

-- 13. Nom du/des lieu(x) possédant le plus d'habitants, en dehors du village gaulois.

-- 14. Nom des personnages qui n'ont jamais vu aucune potion

-- 15. Nom du/des personnages qui n'ont pas le droit de boire de la potion 'magique'. 