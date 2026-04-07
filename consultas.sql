SELECT nom,cognom FROM dades_ponent WHERE id=1;

SELECT nom,cognom FROM dades_ponent WHERE id<=4;

SELECT nom,cognom FROM dades_ponent WHERE id%2=0;

SELECT nom,cognom FROM dades_ponent WHERE id in (1,2,3);

SELECT nom,cognom FROM dades_ponent WHERE nom="anna";

SELECT nom,cognom FROM dades_ponent WHERE nom LIKE "a%";

SELECT COUNT(nom) FROM dades_ponent WHERE nom LIKE "an%";

SELECT COUNT(nom) FROM dades_ponent WHERE cognom = "rovira";

SELECT COUNT(nom) FROM dades_ponent WHERE nom = "anna" AND cognom = "rovira";

SELECT COUNT(nom) AS personas FROM dades_ponent WHERE nom = "anna" AND cognom = "rovira";

SELECT nom,cognom,empresa FROM dades_ponent WHERE nom = "anna" AND cognom = "rovira";

SELECT nom,cognom,empresa FROM dades_ponent WHERE nom = "anna" or cognom = "rovira";

SELECT COUNT(*) nom FROM dades_ponent WHERE nom = "anna" or cognom = "rovira" group by nom;

SELECT COUNT(*) nom FROM dades_ponent WHERE nom = "anna" or cognom = "rovira" group by nom order by count(*) ASC;

SELECT * from dades_ponent;

SELECT concat(nom, ' ', cognom) from dades_ponent;

SELECT substring(nom,1,3) from dades_ponent;

SELECT CURRENT_DATE;
