--1.-
use joins;





--EXERCICIS DE JOINs EN MySQL
--
--\===========================
--
--Base de dades: GestionProveedores
--
--Curs: Gestió de Bases de Dades
--
--
--
--En aquests exercicis practicaràs els diferents tipus de JOIN de MySQL: JOIN (INNER JOIN), LEFT JOIN, LEFT OUTER JOIN, RIGHT JOIN i RIGHT OUTER JOIN. Per a cada escenari trobaràs una breu descripció del context i una sèrie de consultes que hauràs de resoldre.
--
--
--
--Recorda la diferència clau:
--
--\- INNER JOIN / JOIN -> només les files que tenen coincidència a les dues taules
--
--\- LEFT JOIN / LEFT OUTER JOIN -> totes les files de l'esquerra, amb NULL si no hi ha coincidència a la dreta
--
--\- RIGHT JOIN / RIGHT OUTER JOIN -> totes les files de la dreta, amb NULL si no hi ha coincidència a l'esquerra
--
--
--
--
--\=====================================================================
--
--PAR 1 - passejador, raca i gos  (LEFT JOIN)
--
--Taules: passejador, raca, gos
--
--\=====================================================================
--
--
--
--ESCENARI
--
--\--------
--
--L'empresa "Quatre Potes" ofereix un servei de passeig de gossos a domicili. Cada gos pot tenir un passejador assignat, però hi ha gossos recentment incorporats que encara no en tenen cap. D'altra banda, tots els passejadors estan donats d'alta al sistema, independentment de si tenen gossos assignats en aquest moment. Les races es gestionen ara en una taula independent.
--
--
--
--ESQUEMA
--
--\-------
--
--passejador(id, nom, cognom, telefon, email, anys_experiencia)
--
--raca(id, nom)
--
--gos(id, nom, id_raca, edat, pes, id_passejador)  -- id_passejador pot ser NULL
--
--
--
--EXERCICIS
--
--\---------
--
--1\. Llista el nom de tots els gossos i el nom del seu passejador. Inclou també els gossos que encara no tenen passejador assignat (han d'aparèixer amb NULL).
--
--   -> Tipus de JOIN: LEFT JOIN   (<- TOTES les files de l'esquerra + NULL on no hi ha coincidència a la dreta)

SELECT gos.id, gos.nom, gos.id_passejador, passejador.id, passejador.nom
from passejador 
left join gos
on passejador.id = gos.id_passejador
ORDER by gos.id;


--2\. Mostra tots els passejadors amb el nombre de gossos que tenen assignats. Inclou els passejadors que no tenen cap gos (han d'aparèixer amb 0).


SELECT passejador.nom, Count(gos.id) as perros
from passejador 
LEFT JOIN gos on passejador.id = gos.id_passejador
GROUP BY passejador.id;




--3\. Quins gossos NO tenen passejador assignat? Mostra el nom i la raça (nom de la raça, fent JOIN amb la taula raca).

SELECT gos.id, gos.nom, gos.id_raca, raca.nom
from gos
left JOIN raca ON raca.id = gos.id_raca
where gos.id_passejador is NULL;


--4\. Llista el nom i cognoms dels passejadors que sí que tenen almenys un gos assignat, ordenats alfabèticament.

Select passejador.nom, passejador.cognom
from passejador
join gos on passejador.id = gos.id_passejador
GROUP BY passejador.id
ORDER BY passejador.nom;

--5\. Mostra una llista amb el nom del passejador, els anys d'experiència i el nom del gos, ordenada per anys d'experiència descendent. 
--Inclou passejadors sense gossos.

SELECT passejador.nom, passejador.anys_experiencia, gos.nom
from passejador
left join gos on passejador.id = gos.id_passejador
ORDER BY passejador.anys_experiencia DESC;

--6\. Llista les races que NO tenen cap gos assignat. Mostra el nom de la raça.

SELECT raca.nom, gos.id
from raca
left JOIN gos on raca.id = gos.id_raca
where gos.id IS NULL;


--7\. Quants gos hi ha de cada raça? Mostra el nom de la raça i el nombre de gossos, incloent les races sense cap gos (amb 0). 
--Ordena per nombre de gos descendent.


SELECT raca.nom, Count(gos.id) as perros
from raca
left join gos on raca.id = gos.id_raca
GROUP BY raca.id
ORDER BY perros desc;

--8\. Mostra el nom del gos, el nom de la seva raça i el nom del seu passejador. 
--Inclou els gossos sense passejador (NULL). Utilitza dos JOINs en la mateixa consulta.

SELECT gos.nom, raca.nom, passejador.nom
from gos
left JOIN passejador on passejador.id = gos.id_passejador
left JOIN raca on raca.id = gos.id_raca;



--\=====================================================================
--
--PAR 2 - departament i empleat  (JOIN / INNER JOIN)
--
--Taules: departament, empleat
--
--\=====================================================================
--
--
--
--ESCENARI
--
--\--------
--
--L'empresa tecnologica "ITB Solutions" te la seva plantilla organitzada per departaments. 
--Cada empleat pertany obligatoriament a un departament. 
--L'equip de RRHH necessita diverses consultes per gestionar la informacio de personal.
--
--
--
--ESQUEMA
--
--\-------
--
--departament(id, nom, ubicacio, pressupost, telefon)
--
--empleat(id, nom, cognom, salari, data_alta, id_departament)  -- NOT NULL
--
--
--
--EXERCICIS
--
--\---------
--
--1\. Llista el nom i cognom de tots els empleats juntament amb el nom del departament al qual pertanyen.
--
--   -> Tipus de JOIN: INNER JOIN   (<- només files amb coincidència en les dues taules; INNER pot escriure's sense aquest mot)

SELECT empleat.nom, empleat.cognom, departament.nom
from empleat
INNER join departament on departament.id = empleat.id_departament;



--2\. Quina es la mitjana salarial per departament? Mostra el nom del departament i la mitjana.
--
--   -> Tipus de JOIN: JOIN + GROUP BY   (<- idèntic a INNER JOIN; només files amb coincidència en les dues taules)

SELECT departament.nom, AVG(empleat.salari) as media
FROM departament
join empleat on departament.id = empleat.id_departament
GROUP BY departament.id;

--3\. Llista els empleats del departament de "Tecnologia" amb el seu salari, ordenats de major a menor salari.

SELECT empleat.nom, empleat.salari, departament.nom
from empleat
join departament on departament.id = empleat.id_departament
where departament.nom = "Tecnologia"
ORDER BY empleat.salari;



--4\. Quin departament té més empleats? Mostra el nom del departament i el nombre d'empleats.

SELECT departament.nom, count(empleat.id)
from departament
join empleat on departament.id = empleat.id_departament;


--5\. Mostra els empleats contractats l'any 2023 o posterior, amb el nom del seu departament i la seva ubicacio.
--
--
--
--
--
--\=====================================================================
--
--PAR 3 - categoria i producte  (RIGHT JOIN)
--
--Taules: categoria, producte
--
--\=====================================================================
--
--
--
--ESCENARI
--
--\--------
--
--La botiga en linia "MercatWeb" te un catàleg de productes organitzats per categoria. Recentment s'han afegit nous productes al sistema sense assignar-los a cap categoria. L'equip de continguts vol revisar l'estat del cataleg.
--
--
--
--ESQUEMA
--
--\-------
--
--categoria(id, nom, descripcio, activa, data_creacio)
--
--producte(id, nom, preu, estoc, codi_barres, id_categoria)  -- pot ser NULL
--
--
--
--EXERCICIS
--
--\---------
--
--1\. Llista tots els productes amb el nom de la seva categoria. Inclou els productes que no tenen categoria assignada (han d'apareixer amb NULL).
--
--   -> Tipus de JOIN: RIGHT JOIN (producte a la dreta)   (<- TOTES les files de la dreta + NULL on no hi ha coincidència a l'esquerra)
--
--
--
--2\. Quantes categories no tenen cap producte assignat? Llista-les.
--
--
--
--
--3\. Mostra el nom de cada categoria i quants productes té, incloent les categories sense productes (amb 0).
--
--
--
--
--4\. Llista els productes sense categoria que tinguin un preu superior a 50 euros.
--
--
--
--
--5\. Quines categories actives no tenen cap producte en estoc?
--
--
--
--
--
--\=====================================================================
--
--PAR 4 - ciutat, client i comanda  (LEFT OUTER JOIN)
--
--Taules: ciutat, client, comanda
--
--\=====================================================================
--
--
--
--ESCENARI
--
--\--------
--
--El restaurant "Cal Victor" ha posat en marxa un sistema de comandes en línia. Molts clients s'han registrat pero encara no han fet cap comanda. El gerent vol analitzar quins clients han comprat i quins no per enviar campanyes de marqueting personalitzades. Les ciutats s'han centralitzat ara en una taula independent, tant per als clients com per a l'adreca d'enviament de les comandes.
--
--
--
--ESQUEMA
--
--\-------
--
--ciutat(id, nom, codi_postal)
--
--client(id, nom, cognom, email, telefon, id_ciutat)  -- FK a ciutat
--
--comanda(id, data_comanda, total, estat, adreca_enviament, id_client, id_ciutat_enviament)  -- id_client NOT NULL, id_ciutat_enviament FK a ciutat
--
--
--
--EXERCICIS
--
--\---------
--
--1\. Llista tots els clients amb les seves comandes. Els clients sense cap comanda han d'apareixer igualment (amb NULL a les columnes de comanda).
--
--   -> Tipus de JOIN: LEFT OUTER JOIN   (<- idèntic a LEFT JOIN; OUTER és opcional i no canvia res)
--
--
--
--2\. Quins clients NO han fet mai cap comanda? Mostra el seu nom, cognom i correu electronic.
--
--
--
--
--3\. Mostra el total gastat per cada client (suma de totes les seves comandes), incloent els clients que no han gastat res (0 o NULL).
--
--
--
--
--4\. Quants clients de Barcelona han fet almenys una comanda? (Necessites JOIN amb la taula ciutat per obtenir el nom de la ciutat.)
--
--
--
--
--5\. Llista els clients que han fet comandes amb estat "cancel·lat", mostrant el nom del client i la data de la comanda.
--
--
--
--
--6\. Llista tots els clients amb el nom de la seva ciutat de residència. Inclou els clients sense ciutat assignada (NULL).
--
--
--
--
--7\. Quantes comandes s'han enviat a Barcelona? (Utilitza id_ciutat_enviament i fes JOIN amb ciutat.)
--
--
--
--
--8\. Quines ciutats han rebut més comanda d'enviament? Mostra el nom de la ciutat i el nombre de comandes, ordenat de major a menor.
--
--
--
--
--
--\=====================================================================
--
--PAR 5 - especialitats, professor i assignatura  (RIGHT OUTER JOIN)
--
--Taules: especialitat_prof, professor, assignatura
--
--\=====================================================================
--
--
--
--ESCENARI
--
--\--------
--
--L'institut "ITB" gestiona el seu quadre de professors i assignatures. A l'inici de curs algunes assignatures encara no tenen professor assignat. La cap d'estudis necessita saber quines assignatures queden sense cobertura per poder contractar nous docents. Les especialitats es gestionen ara en una taula independent.
--
--
--
--ESQUEMA
--
--\-------
--
--especialitat_prof(id, nom)
--
--professor(id, nom, cognom, id_especialitat, anys_experiencia, email)  -- FK a especialitat_prof
--
--assignatura(id, nom, credits, curs, quadrimestre, id_professor, id_especialitat)  -- id_professor pot ser NULL; id_especialitat FK a especialitat_prof
--
--
--
--EXERCICIS
--
--\---------
--
--1\. Llista totes les assignatures amb el nom del professor que les imparteix. Les assignatura sense professor han d'apareixer igualment (amb NULL).
--
--   -> Tipus de JOIN: RIGHT OUTER JOIN (assignatura a la dreta)   (<- idèntic a RIGHT JOIN; OUTER és opcional i no canvia res)
--
--
--
--2\. Quines assignatures NO tenen professor assignat? Mostra el nom de l'assignatura, els credits i el curs.
--
--
--
--
--3\. Quants professors imparteixen assignatura de 1r curs?
--
--
--
--
--4\. Mostra el nom del professor i la llista d'assignatures que imparteix, per als professors amb mes de 10 anys d'experiencia.
--
--
--
--
--5\. Quina es la distribució d'assignatures per quadrimestre? Mostra el quadrimestre i el nombre d'assignatures (amb o sense professor).
--
--
--
--
--6\. Llista els professor amb el nom de la seva especialitat (fent JOIN amb especialitat_prof). Mostra nom, cognom i especialitat.
--
--
--
--
--7\. Quantes assignatura hi ha per cada especialitat? Mostra el nom de l'especialitat i el nombre d'assignatura, incloent especialitats sense cap assignatures (amb 0).
--
--
--
--
--8\. Quines especialitats no tenen cap professor assignat? Fes servir RIGHT OUTER JOIN per obtenir totes les especialitats, incloent les que no apareixen a professor.
--
--
--
--
--
--\=====================================================================
--
--PAR 6 - especialitats, hospital, metge i pacient  (JOIN)
--
--Taules: especialitat_med, hospital, metge, pacient
--
--\=====================================================================
--
--
--
--ESCENARI
--
--\--------
--
--El centre medic "Salut Plus" porta el registre de metges i pacients. Cada pacient té assignat un metge de capcalera. La direccio medica vol analitzar la carrega de treball i la distribució de pacients entre els professionals. Les especialitats i els hospital ara estan en taules independents.
--
--
--
--ESQUEMA
--
--\-------
--
--especialitat_med(id, nom)
--
--hospital(id, nom, ciutat)
--
--metge(id, nom, cognom, id_especialitat, num_col_legiat, id_hospital)  -- FKs a especialitat_med i hospital
--
--pacient(id, nom, cognom, data_naixement, num_seguretat_social, id_metge)  -- NOT NULL
--
--
--
--EXERCICIS
--
--\---------
--
--1\. Llista el nom i cognom de cada pacient juntament amb el nom del seu metge de capcalera i l'especialitat d'aquest (nom de l'especialitat, fent JOIN amb especialitat_med).
--
--
--
--
--2\. Quants pacients té assignats cada metge? Mostra el nom del metge i el total de pacients, ordenat de mes a menys.
--
--
--
--
--3\. Llista els pacients assignats a metge de l'especialitat "Cardiologia". (Necessites JOIN amb especialitat_med per filtrar pel nom.)
--
--
--
--
--4\. Quants metges treballen a l'"Hospital Clínic" i quants pacient tenen en total? (Necessites JOIN amb hospital.)
--
--
--
--
--5\. Mostra el nom dels pacients nascuts abans de l'any 1970, juntament amb el nom del seu metge.
--
--
--
--
--6\. En quin hospital treballa en Miquel Moreno? Mostra el nom de l'hospital i la ciutat.
--
--
--
--
--7\. Quants metges treballa a cada hospital? Mostra el nom de l'hospital i el nombre de metges, ordenat de mes a menys.
--
--
--
--
--8\. Quants pacients té cada hospital (sumant els pacients dels metges que hi treballen)? Mostra el nom de l'hospital i el total de pacient.
--
--
--
--
--
--\=====================================================================
--
--PAR 7 - conductor, marca, model i vehicle  (LEFT JOIN)
--
--Taules: conductor, marca, model, vehicle
--
--\=====================================================================
--
--
--
--ESCENARI
--
--\--------
--
--L'empresa de lloguer de vehicle "AutoFlota" gestiona una flota de cotxes i els conductors que els poden utilitzar. Alguns vehicles estan disponibles sense conductor assignat (disponibles per llogar), i alguns conductors estan registrats pero sense vehicle en aquest moment. Les marques i models es gestionen ara en taules independents.
--
--
--
--ESQUEMA
--
--\-------
--
--conductor(id, nom, cognom, num_llicencia, anys_carnet, telefon)
--
--marca(id, nom)
--
--model(id, nom, id_marca)  -- FK a marca
--
--vehicle(id, id_model, matricula, any_fabricacio, id_conductor)  -- id_conductor pot ser NULL; FK a model i conductor
--
--
--
--EXERCICIS
--
--\---------
--
--1\. Llista tots els conductors amb el vehicle que tenen assignat (matrícula i any de fabricació). Mostra també els conductor sense vehicle (NULL).
--
--
--
--
--2\. Quins conductors NO tenen cap vehicle assignat? Mostra el nom, cognom i número de llicència.
--
--
--
--
--3\. Llista els vehicles que SÍ tenen conductor assignat, mostrant matrícula, nom de la marca, nom del model i nom del conductor.
--
--
--
--
--4\. Quants vehicle te assignats cada conductor? Inclou conductors amb 0 vehicle.
--
--
--
--
--5\. Mostra els conductors amb més de 10 anys de carnet que tenen un vehicle del any 2020 o posterior.
--
--
--
--
--6\. Llista tots els vehicles amb el nom de la marca i el model (fent JOINs amb model i marca). Inclou els vehicle sense conductor (NULL).
--
--
--
--
--7\. Quantes marques no tenen cap vehicle assignat a la flota?
--
--
--
--
--8\. Quants vehicles té cada marca? Mostra el nom de la marca i el nombre de vehicles, ordenat de major a menor.
--
--
--
--
--
--\=====================================================================
--
--PAR 8 - gèneres, artista i àlbums  (RIGHT JOIN)
--
--Taules: genere, artista, album
--
--\=====================================================================
--
--
--
--ESCENARI
--
--\--------
--
--El segell discografic "SonicLabel" te un catàleg d'artistes i àlbums. Alguns àlbums són recopilatoris o bandes sonores que no pertanyen a cap artista concret. La direccio comercial vol analitzar el cataleg per detectar quins artista generen mes vendes. Els gèneres musicals es gestionen ara en una taula independent.
--
--
--
--ESQUEMA
--
--\-------
--
--genere(id, nom)
--
--artista(id, nom, id_genere, pais, any_debut, actiu)  -- FK a genere
--
--album(id, titol, any_publicacio, num_cancons, vendes, id_artista)  -- pot ser NULL
--
--
--
--EXERCICIS
--
--\---------
--
--1\. Llista tots els àlbums amb el nom de l'artista. Inclou els àlbums sense artista assignat (recopilatoris).
--
--
--
--
--2\. Quins àlbums NO tenen artista assignat? Mostra el titol i l'any de publicacio.
--
--
--
--
--3\. Quin es el total de vendes per artista? Mostra el nom de l'artista i la suma de vendes, ordenat de major a menor.
--
--
--
--
--4\. Llista els àlbums publicats entre 2010 i 2020 juntament amb el nom de l'artista (si en te).
--
--
--
--
--5\. Quants album ha publicat cada artista que estigui actiu (actiu = 1)?
--
--
--
--
--6\. Llista tots els artistes amb el nom del seu gènere musical (fent JOIN amb genere). Mostra nom de l'artista, gènere i país.
--
--
--
--
--7\. Quins gèneres no tenen cap artista actiu? (Utilitza RIGHT JOIN o LEFT JOIN per obtenir tots els gèneres.)
--
--
--
--
--8\. Quants àlbums s'han publicat per gènere? Mostra el nom del gènere i el nombre d'àlbums, incloent gèneres sense àlbums (amb 0).
--
--
--
--
--
--\=====================================================================
--
--RESUM DELS TIPUS DE JOIN PRACTICATS
--
--\=====================================================================
--
--
--
--Par 1  passejador-raca-gos      -> LEFT JOIN
--
--Par 2  departament-empleat         -> JOIN / INNER JOIN
--
--Par 3  categoria-producte          -> RIGHT JOIN
--
--Par 4  ciutat-client-comanda      -> LEFT OUTER JOIN
--
--Par 5  especialitat_prof-professor-assignatura -> RIGHT OUTER JOIN
--
--Par 6  especialitat_med-hospital-metge-pacient -> JOIN
--
--Par 7  conductor-marca-model-vehicle -> LEFT JOIN
--
--Par 8  genere-artista-album       -> RIGHT JOIN
--
--
--
--RECORDATORI:
--
--\- LEFT JOIN = LEFT OUTER JOIN (OUTER es opcional)
--
--\- RIGHT JOIN = RIGHT OUTER JOIN (OUTER es opcional)
--
--\- JOIN = INNER JOIN (INNER es opcional)
--
--\- NATURAL JOIN -> existeix en SQL estandard pero no funciona be a MySQL: EVITA'L
--
--\- FULL JOIN -> no existeix a MySQL: cal simular-lo amb UNION de LEFT + RIGHT JOIN
--