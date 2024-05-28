-- A partir du script SQL Gaulois, écrivez et executez les requêtes suivantes : --

-- 1. Nom des lieux qui finissent par 'um'

SELECT *
FROM lieu
WHERE nom_lieu
LIKE '%um'