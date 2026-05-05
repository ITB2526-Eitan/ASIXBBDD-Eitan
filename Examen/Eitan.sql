-- ============================================================
-- EXAMEN DE SQL — 1r ASIX · RA4: Consultes, Funcions i JOINs
-- Mòdul: Bases de Dades · Curs 2025-2026 · VERSIÓ 2
-- ============================================================
--
-- INSTRUCCIONS:
--   1. Substitueix "NomCognom" al nom d'aquest fitxer pel teu
--      nom i cognom reals (sense espais ni accents).
--      Exemple: examen_sql_MartaGarcia.sql
--
--   2. Escriu el teu nom complet a la línia següent:
--
-- Alumne/a: __Eitan Alexander Garcia Ravelo_______________________
--
--   3. Escriu la teva resposta SQL JUST A SOTA de cada
--      enunciat, dins del bloc indicat.
--      Per a les preguntes teòriques, escriu la resposta
--      com a comentaris SQL (línies que comencin per --).
--
--   4. Entrega ÚNICAMENT aquest fitxer .sql
--
-- ============================================================


-- ============================================================
-- CONTEXT A — Congrés TechSummit (base de dades: tech_summit)
-- ============================================================
-- Taules disponibles:
--   dades_ponent (id, nom, cognom, empresa, ordinadors, rate, complex_rate)
--     · ordinadors : nombre d'ordinadors assignats al ponent (0–4)
--     · rate       : valoració del ponent (enters 5–10)
--     · complex_rate: valoració ponderada (decimals 5.0–10.0)
--   sessio (id, titol, hora, sala)
--     · hora       : hora d'inici de la sessió (TIME)
-- ============================================================

USE tech_summit;


-- ------------------------------------------------------------
-- Pregunta 1 [3 punts]
-- ------------------------------------------------------------
-- El departament de comunicació del congrés TechSummit necessita
-- generar etiquetes identificatives per als ponents.
-- Escriviu una consulta sobre dades_ponent que mostri:
--
--   · codi_ponent : les 3 primeres lletres del cognom en majúscules,
--                   seguides de l'id del ponent completat amb zeros
--                   per l'esquerra fins a 4 dígits.
--                   Exemple: cognom='García', id=7 → 'GAR0007'
--
--   · nom_complet : nom i cognom en format "COGNOM, Nom"
--                   (cognom tot en majúscules, coma, espai,
--                    nom amb primera lletra en majúscula i resta en minúscules)
--
--   · L'empresa on treballa cada ponent.
--
-- Ordena alfabèticament per cognom.
-- ------------------------------------------------------------

-- Escriu aquí la teva consulta SQL:



-- ------------------------------------------------------------
-- Pregunta 2 [3 punts]
-- ------------------------------------------------------------
-- El comitè organitzador vol analitzar les valoracions dels ponents
-- amb diverses transformacions numèriques.
-- Escriviu una consulta sobre dades_ponent que mostri per a cada ponent:
--
--   · El nom i el cognom.
--   · La valoració (rate) arrodonida a l'enter més proper.
--   · La valoració complexa (complex_rate) truncada a 1 decimal.
--   · La diferència entre el sostre (ceiling) del rate i
--     el terra (floor) del complex_rate, en una columna 'diferencia'.
--   · Si el nombre d'ordinadors és parell o senar:
--     valors 'Parell' o 'Senar' en una columna 'paritat'.
--
-- Mostra únicament els ponents amb complex_rate superior a 0.
-- ------------------------------------------------------------

-- Escriu aquí la teva consulta SQL:




-- ------------------------------------------------------------
-- Pregunta 4 [3 punts]
-- ------------------------------------------------------------
-- El sistema de gestió vol classificar automàticament els ponents
-- i el seu equipament.
-- Escriviu una consulta sobre dades_ponent que mostri per a cada ponent:
--
--   · El nom complet (nom i cognom en una sola columna).
--   · La seva valoració (rate).
--   · Una columna 'categoria':
--       'Expert'    si rate és 9 o 10
--       'Avançat'   si rate és 7 o 8
--       'Intermedi'  si rate és 5 o 6
--   · Una columna 'equipament':
--       'Molt equipat' si té 3 o més ordinadors
--       'Equipat'      si en té 1 o 2
--       'Sense equip'  si no en té cap
--
-- Ordena per categoria (Experts primers, Intermedis al final)
-- i, dins de cada categoria, per valoració de major a menor.
-- ------------------------------------------------------------

-- Escriu aquí la teva consulta SQL:


-- ------------------------------------------------------------
-- Pregunta 5 [3 punts]
-- ------------------------------------------------------------
-- La direcció vol un resum de la participació per empresa.
-- Escriviu una consulta sobre dades_ponent que mostri per a cada empresa:
--
--   · El nom de l'empresa.
--   · El nombre de ponents que té al congrés.
--   · La valoració mitjana dels seus ponents, arrodonida a 2 decimals.
--   · La valoració màxima i la valoració mínima entre els seus ponents.
--
-- Ordena per nombre de ponents de major a menor; en cas d'empat,
-- per nom d'empresa alfabèticament.
-- ------------------------------------------------------------

-- Escriu aquí la teva consulta SQL:

SELECT dades_ponent.empresa, count(dades_ponent.id) as total, avg(dades_ponent.rate), max(dades_ponent.rate), min(dades_ponent.rate)
from dades_ponent
GROUP BY dades_ponent.id
ORDER BY total and dades_ponent.empresa;

-- ------------------------------------------------------------
-- Pregunta 6 [3 punts]
-- ------------------------------------------------------------
-- L'equip d'organització vol conèixer l'ocupació de les sales
-- i el programa horari.
-- Escriviu una consulta sobre la taula sessio que mostri,
-- per a cada sala:
--
--   · El nom de la sala.
--   · El nombre de sessions programades en aquella sala.
--   · L'hora de la primera sessió del dia (la més matinera).
--   · L'hora de l'última sessió del dia (la més tardana).
--
-- Ordena els resultats per nombre de sessions de major a menor.
-- ------------------------------------------------------------

-- Escriu aquí la teva consulta SQL:

SELECT sessio.sala, count(sessio.id), min(sessio.hora), max(sessio.hora)
from sessio
GROUP BY sessio.sala
ORDER BY count(sessio.id) desc;


-- ------------------------------------------------------------
-- Pregunta 7 [3 punts]
-- ------------------------------------------------------------
-- El comitè de qualitat vol identificar les empreses amb
-- presència significativa i alta qualitat al congrés.
-- Escriviu una consulta sobre dades_ponent que mostri el nom de
-- l'empresa, el nombre de ponents i la valoració mitjana
-- (arrodonida a 2 decimals), però ÚNICAMENT de les empreses
-- que compleixin TOTES DUES condicions simultàniament:
--
--   · Que tinguin MÉS D'UN ponent al congrés.
--   · Que la valoració mitjana dels seus ponents sigui SUPERIOR A 7.
--
-- Ordena per valoració mitjana de major a menor.
-- ------------------------------------------------------------

-- Escriu aquí la teva consulta SQL:

SELECT dades_ponent.empresa, count(dades_ponent.id) as total, round(avg(rate), 2) as media
from dades_ponent
group by dades_ponent.empresa
having total > 1 and media > 7
ORDER BY media desc;



-- ------------------------------------------------------------
-- Pregunta 8 [3 punts]
-- ------------------------------------------------------------
-- El director del congrés necessita un informe de representació
-- empresarial en format compacte.
-- Escriviu una consulta que, per a cada empresa, mostri:
--
--   · El nom de l'empresa.
--   · El nombre de ponents.
--   · Una llista de tots els noms complets (nom + cognom) dels seus
--     ponents en una SOLA COLUMNA ('llista_ponents'), separats pel
--     text ' | ' i ordenats alfabèticament per cognom.
--
-- Ordena les empreses per ordre alfabètic del seu nom.
-- ------------------------------------------------------------

-- Escriu aquí la teva consulta SQL:

select dades_ponent.empresa, count(dades_ponent.id), concat(dades_ponent.nom, '|', dades_ponent.cognom) as llista_ponents
from dades_ponent
GROUP BY dades_ponent.id
ORDER BY dades_ponent.empresa;


-- ------------------------------------------------------------
-- Pregunta 9 [3 punts]
-- ------------------------------------------------------------
-- La junta directiva vol un informe executiu complet per a la
-- selecció d'empreses col·laboradores.
-- Escriviu una consulta sobre dades_ponent que mostri per a cada empresa:
--
--   · El nom de l'empresa.
--   · El nombre de ponents.
--   · La suma total d'ordinadors assignats a tots els seus ponents.
--   · La valoració complexa (complex_rate) mitjana, truncada a 1 decimal.
--   · Una columna 'classificacio':
--       'Premium'   si té més de 2 ponents I la valoració màxima és >= 9
--       'Risc'      si la valoració mínima és < 6 (independentment de la resta)
--       'Estàndard' en qualsevol altre cas
--
-- Mostra ÚNICAMENT les empreses amb ALMENYS 2 PONENTS i una
-- SUMA TOTAL D'ORDINADORS SUPERIOR A 3.
-- Ordena per nombre de ponents de major a menor; en cas d'empat,
-- per valoració complexa mitjana de major a menor.
-- ------------------------------------------------------------

-- Escriu aquí la teva consulta SQL:




-- ============================================================
-- SECCIÓ 2 — PREGUNTES TEÒRIQUES I CONCEPTUALS
-- Escriu les respostes com a comentaris SQL (línies amb --)
-- ============================================================


-- ------------------------------------------------------------
-- Pregunta 10 [3 punts] — Teoria: NATURAL JOIN
-- ------------------------------------------------------------
-- Respon a les tres preguntes sobre el NATURAL JOIN:
--
-- a) En què consisteix el NATURAL JOIN? Quin resultat produeix
--    i com determina les columnes de connexió entre dues taules?
--
-- b) Per quin motiu NO és recomanable usar-lo en entorns
--    professionals o en equips de treball?
--
-- c) Quina alternativa hauries de fer servir i per quin motiu
--    és preferible?
-- ------------------------------------------------------------

-- Escriu aquí la teva resposta (com a comentaris --):
--
-- a) El NATURAL JOIN és un tipus de JOIN que combina dues taules basant-se en columnes 
-- amb el mateix nom i tipus,
-- com a resultat dona totes les files amb valors coincidents
--   
-- b) No es recomanable usar-lo en entorns professionals perquè pot portar a 
-- imprevistos si hi han dos columnes iguals pero amb diferents significats
--
-- c) L'alternativa preferible és usar un JOIN explícit amb una clàusula ON, 
-- que permet controlar exactament les columnes que es faran servir 



-- ------------------------------------------------------------
-- Pregunta 11 [3 punts] — Teoria: FULL OUTER JOIN
-- ------------------------------------------------------------
-- MySQL no implementa el FULL OUTER JOIN. Respon i desenvolupa:
--
-- a) Quin resultat produiria un FULL OUTER JOIN si existís a MySQL?
--    En quina situació de negoci seria útil?
--
-- b) Com es pot simular el mateix resultat a MySQL?
--    Escriu la plantilla SQL genèrica per a dues taules genèriques
--    A i B (no cal cap context concret).
-- ------------------------------------------------------------

-- Escriu aquí la teva resposta (com a comentaris --):
--
-- a)
--
-- b) Explicació:
--
--    Plantilla SQL:




-- ============================================================
-- CONTEXT B — Empresa IT (base de dades: joins)
-- ============================================================
-- Taules disponibles:
--   departament (id, nom, ubicacio, pressupost, telefon)
--   empleat     (id, nom, cognom, salari, data_alta, id_departament)
--     · data_alta       : data d'incorporació a l'empresa (DATE)
--     · id_departament  : clau forana cap a departament (NOT NULL)
-- ============================================================

USE GestionProveedores;


-- ------------------------------------------------------------
-- Pregunta 3 [3 punts]
-- ------------------------------------------------------------
-- El departament de Recursos Humans vol fer una auditoria del personal.
-- Escriviu una consulta sobre la taula empleat que mostri per a cada empleat:
--
--   · El nom complet (nom i cognom en una sola columna).
--   · La data d'alta en format europeu 'DD/MM/YYYY',
--     en una columna 'data_incorporacio'.
--   · L'any i el mes d'incorporació en columnes separades
--     ('any_incorporacio' i 'mes_incorporacio').
--   · El nombre d'anys complets que porta treballant a l'empresa,
--     calculat a partir de la data d'avui, en una columna 'anys_antiguitat'.
--
-- Ordena els resultats dels empleats més antics als més nous.
-- ------------------------------------------------------------

-- Escriu aquí la teva consulta SQL:


-- ------------------------------------------------------------
-- Pregunta 12 [3 punts]
-- ------------------------------------------------------------
-- La cap de Personal vol un directori actualitzat de tots els
-- treballadors amb la informació del seu departament.
-- Escriviu una consulta que mostri, per a cada empleat que estigui
-- assignat a un departament:
--
--   · El seu nom complet (nom i cognom).
--   · El nom del departament on treballa.
--   · La ubicació del departament.
--
-- Ordena per nom de departament i, dins de cada departament,
-- per cognom de l'empleat.
-- ------------------------------------------------------------

-- Escriu aquí la teva consulta SQL:

SELECT empleats.nom, empleats.cognom, departaments.nom, departaments.ubicacio
from empleats
LEFT JOIN departaments on empleats.id_departament = departaments.id
ORDER BY departaments.nom and empleats.cognom;


-- ------------------------------------------------------------
-- Pregunta 13 [3 punts]
-- ------------------------------------------------------------
-- L'empresa vol un informe de recursos humans que inclogui TOTS
-- ELS DEPARTAMENTS, fins i tot aquells que no tinguin cap empleat.
-- Escriviu una consulta que mostri per a cada departament:
--
--   · El nom del departament.
--   · La seva ubicació.
--   · El nombre d'empleats (0 si no en té cap).
--   · El salari mitjà dels seus empleats (pot ser NULL si no en té cap).
--
-- Ordena per nombre d'empleats de major a menor i, en cas d'empat,
-- per nom de departament.
-- ------------------------------------------------------------

-- Escriu aquí la teva consulta SQL:

SELECT departaments.nom, departaments.ubicacio, avg(empleats.salari), count(empleats.id)
from departaments 
LEFT JOIN empleats on departaments.id = empleats.id_departament
GROUP BY departaments.id;


-- ------------------------------------------------------------
-- Pregunta 14 [3 punts]
-- ------------------------------------------------------------
-- Arran d'una reestructuració interna, s'han creat nous departaments
-- que han quedat sense empleats assignats.
-- Escriviu una consulta que mostri ÚNICAMENT els departaments sense
-- cap empleat: el nom del departament, la seva ubicació i el pressupost.
--
-- Pensa bé quin tipus d'unió cal usar i quina condició ha de tenir
-- el filtre perquè funcioni correctament.
-- ------------------------------------------------------------

-- Escriu aquí la teva consulta SQL:

SELECT departaments.nom, departaments.ubicacio, departaments.pressupost
from empleats
LEFT JOIN departaments on departaments.id = empleats.id_departament
where empleats.id_departament is null;


-- ============================================================
-- CONTEXT C — Plataforma de Cinema CineMax (base de dades: cinemax)
-- ============================================================
-- Taules disponibles:
--   genere_cine (id, nom)
--   director    (id, nom, id_genere_cine, pais, any_debut, en_actiu)
--     · en_actiu      : 1 = director amb producció activa, 0 = no actiu (TINYINT)
--     · id_genere_cine: pot ser NULL
--   pelicula    (id, titol, any_estrena, durada_min, taquilla, id_director)
--     · id_director : pot ser NULL (pel·lícules en postproducció sense director)
--     · taquilla    : nombre total d'espectadors (INT)
-- ============================================================

USE cinemax;


-- ------------------------------------------------------------
-- Pregunta 15 [3 punts]
-- ------------------------------------------------------------
-- CineMax vol publicar un catàleg complet de TOTES LES PEL·LÍCULES
-- de la col·lecció, incloses les que estan en postproducció i
-- encara no tenen director assignat.
-- Escriviu una consulta que mostri per a cada pel·lícula:
--
--   · El títol de la pel·lícula.
--   · L'any d'estrena.
--   · La durada en minuts.
--   · El nom del director.
--     Si la pel·lícula no té director assignat, ha de mostrar
--     'Director per confirmar'.
--
-- Ordena per any d'estrena de més recent a més antic i,
-- en cas d'empat, per títol alfabèticament.
-- ------------------------------------------------------------

-- Escriu aquí la teva consulta SQL:

SELECT pelicula.titol, pelicula.any_estrena, pelicula.durada_min, 
IFNULL(director.nom, 'Director per confirmar') as nom_director
from pelicula
LEFT JOIN director on pelicula.id_director = director.id
ORDER BY pelicula.any_estrena desc, pelicula.titol asc;


-- ------------------------------------------------------------
-- Pregunta 16 [3 punts]
-- ------------------------------------------------------------
-- El departament de continguts vol analitzar el rendiment dels
-- directors amb més producció.
-- Escriviu una consulta que mostri per a cada director:
--
--   · El nom del director.
--   · El nombre total de pel·lícules que ha dirigit.
--   · La suma total d'espectadors (taquilla) de totes les seves
--     pel·lícules.
--
-- Mostra ÚNICAMENT els directors que tinguin ALMENYS 2 PEL·LÍCULES
-- i una TAQUILLA TOTAL SUPERIOR A 0.
-- Ordena per taquilla total de major a menor.
-- ------------------------------------------------------------

-- Escriu aquí la teva consulta SQL:

SELECT director.nom, count(pelicula.id) as num_peliculas, sum(pelicula.taquilla) as taquilla_total
from director
JOIN pelicula on director.id = pelicula.id_director
GROUP BY director.id
HAVING num_peliculas >= 2 and taquilla_total > 0
ORDER BY taquilla_total desc;

-- ============================================================
-- CONTEXT D — Federació Esportiva Catalana (base de dades: esports)
-- ============================================================
-- Taules disponibles:
--   modalitat  (id, nom)
--   club       (id, nom, localitat)
--   entrenador (id, nom, cognom, id_modalitat, num_llicencia, id_club)
--   esportista (id, nom, cognom, data_naix, num_federat, id_entrenador)
--     · id_entrenador : clau forana cap a entrenador (NOT NULL)
-- ============================================================

USE esports;


-- ------------------------------------------------------------
-- Pregunta 17 [3 punts]
-- ------------------------------------------------------------
-- La Federació Esportiva Catalana necessita un directori complet
-- de tots els entrenadors federats.
-- Escriviu una consulta que mostri per a cada entrenador:
--
--   · El seu nom complet (nom i cognom).
--   · El nom de la seva modalitat esportiva.
--   · El nom del club on treballa.
--   · La localitat del club.
--
-- Ordena els resultats per nom de modalitat i, dins de cada
-- modalitat, per cognom de l'entrenador.
-- ------------------------------------------------------------

-- Escriu aquí la teva consulta SQL:

SELECT entrenador.nom, entrenador.cognom, modalitat.nom, club.nom, club.localitat
FROM entrenador
LEFT JOIN modalitat on modalitat.id = entrenador.id_modalitat
LEFT JOIN club on club.id = entrenador.id_club
ORDER BY modalitat.nom, entrenador.cognom;


-- ------------------------------------------------------------
-- Pregunta 18 [3 punts]
-- ------------------------------------------------------------
-- La Federació vol analitzar la distribució de la càrrega de
-- treball entre clubs i modalitats.
-- Escriviu una consulta que mostri, per a cada combinació de
-- modalitat esportiva i club:
--
--   · El nom de la modalitat.
--   · El nom del club.
--   · El nombre d'entrenadors d'aquella modalitat que hi treballen.
--   · El nombre total d'esportistes que entrenen.
--
-- Mostra ÚNICAMENT les combinacions on el nombre total d'esportistes
-- sigui SUPERIOR A 3.
-- Ordena per nombre d'esportistes de major a menor.
-- ------------------------------------------------------------

-- Escriu aquí la teva consulta SQL:

SELECT modalitat.nom, club.nom, count(entrenador.id), count(esportista.id)
FROM entrenador
LEFT JOIN modalitat on modalitat.id = entrenador.id_modalitat
LEFT JOIN club on club.id = entrenador.id_club
LEFT JOIN esportista on entrenador.id = esportista.id_entrenador
GROUP BY modalitat.nom, club.nom
HAVING count(esportista.id) > 3
ORDER BY count(esportista.id) desc;


-- ============================================================
-- FI DE L'EXAMEN
-- Recorda: el nom d'aquest fitxer ha de ser
--   examen_sql_NomCognom.sql
-- i ha d'incloure el teu nom complet al comentari de l'inici.
-- ============================================================
