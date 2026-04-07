
use tech_summit;

-- =========================================================
-- Alumne: Eitan Garcia Ravelo
-- =========================================================

-- 1. Volem fer etiquetes per les portes dels espais on es faran les conferències amb els noms dels ponents.
-- Fes una consulta per obtenir el nom de tots els ponents en majúscules.
-- 

SELECT upper(nom) from dades_ponent; 

-- 2. El departament de màrqueting necessita un llistat de contacte per al catàleg de mà de l'esdeveniment.
-- Obté el cognom de tots els ponents en minúscules i l'empresa on treballen, ordenats per empresa de la A a la Z.

SELECT lower(cognom), empresa from tech_summit.dades_ponent ORDER BY empresa DESC LIMIT 10;

-- 3. Per a la impressió de les targetes de visita oficials, ens demanen un format combinat de nom i cognom.
-- Genera un llistat amb un únic text per registre amb el nom i el cognom separats per un espai i posa-li l'àlies 'Nom_Complet'.

SELECT concat(nom,' ',cognom) as "nom_complet" FROM tech_summit.dades_ponent;

-- * 4. El sistema d'inventari necessita codis de referència curts per a cada expert segons el seu lloc de treball.
-- Fes una consulta en la que generi una columna anomenada 'Codi' amb les 3 primeres lletres de l'empresa i mostra també el nom del ponent.

SELECT substring(empresa, 1, 3) as Codi, nom from tech_summit.dades_ponent;

-- 5. L'equip de xarxes socials vol verificar si els títols de les sessions caben en els seus bàners publicitaris.
-- Mostra el títol de cada sessió i la seva longitud, filtrant només aquelles que fan més de 20 caràcters.
-- Si cal, pots afegir més camps a la base de dades per a aquesta consulta.



-- 6. Per a un llistat d'estil vintage, volem canviar l'estètica dels cognoms dels ponents en la base de dades.
-- Mostra el cognom substituint totes les lletres 'a' per '@' i anomena la columna 'Cognom_Modificat'.

SELECT REPLACE(cognom, 'a', '@') as Cognom_modificat from dades_ponent;

-- 7. S'ha detectat que alguns noms d'empresa es van introduir amb espais accidentals als costats.
-- Mostra el camp empresa net d'espais prefixats o sufixats i el nom del ponent per a tots els IDs entre 1 i 5.
-- Pots afegir registres amb aquesta errada per a provar la teva consulta.

SELECT trim(empresa), nom from dades_ponent where id BETWEEN 1 and 5;

-- 8. El personal de recepció necessita un format de llista que identifiqui ràpidament el ponent amb el seu ID.
-- Crea un text que mostri el nom i l'ID entre parèntesis, filtrant només ponents de l'empresa 'tech corp'.

SELECT concat(nom, ' (',id,')') from dades_ponent WHERE empresa = 'tech corp';

-- 9. En la web del congrés no hi ha espai per a títols llargs en el menú lateral.
-- Selecciona les sessions mostrant només les 10 primeres lletres seguides del text '...' i posa l'àlies 'Titol_Curt'.

SELECT concat(substring(titol, 1, 10), '.....' ) as Titol_Curt from sessio;

-- 10. L'equip de disseny vol fer un joc visual amb la darrera lletra dels cognoms dels ponents.
-- Obté un llistat amb el nom, el cognom i la darrera lletra del cognom de tots els ponents, ordenat alfabèticament pel nom.

SELECT nom, cognom, RIGHT(cognom, 1) from dades_ponent ORDER BY nom;

-- 11. Per decidir l'ordre de les entrevistes, volem assignar una prioritat aleatòria a cada expert per no beneficiar ningú.
-- Genera un número decimal aleatori entre 0 i 1 per a cada ponent i mostra'l en una columna nova al costat del seu nom i cognom.

SELECT nom, cognom, floor(rand() * 2) FROM dades_ponent;


-- 12. Volem fer un sorteig d'una tauleta d'última generació entre tots els ponents de l'esdeveniment.
-- Fes una consulta, on li assignis a cada ponent un número de loteria sencer entre 1 i 100 i mostra'l a una columna anomenada Numero_Sorteig'.
-- Per fer les consultes 13, 14, i 15, has d'afegir un nou camp complex_rate, on no fagis l'arodoniment



-- * 13. La direcció vol veure els nivells dels ponents (complex_rate) sense complicacions de decimals per simplificar l'informe.
-- Mostra un llistat amb el nom del ponent i el seu 'complex_rate' truncat a 0 decimals, però només per a aquells que tinguin un 'rate' superior a 7.

-- * 14. Per a un informe estadístic que anirà a premsa, necessitem arrodonir les puntuacions al sencer més proper.
-- Selecciona el nom, l'empresa i el 'complex_rate' arrodonit (ROUND), ordenant els resultats de major a menor puntuació segons aquest arrodoniment.

-- * 15. L'organització ha decidit ser generosa i pujar la categoria dels ponents al següent nivell sencer.
-- Obté el nom i el 'rate' arrodonit sempre a l'alça (CEILING) per a tots els ponents, excepte els que treballen a 'innovate asix'.

-- 16. El departament de comptabilitat vol aplicar la política de "mínims de qualitat" en les valoracions internes.
-- Mostra el 'complex_rate' arrodonit sempre a la baixa (FLOOR) i el nom, filtrant només els ponents amb ID parell que tinguin un 'complexrate' superior a 6.

-- 17. S'ha detectat un error en l'entrada de dades manual i algunes puntuacions de 'rate' podrien haver-se gravat amb signe negatiu.
-- Fes una consulta que retorni el valor absolut del 'rate' i el nom del ponent per assegurar que totes les dades del llistat siguin positives.
-- Afegeix els registres amb aquest error per a provar la consulta.

-- 18. Necessitem calcular la potència de càlcul teòrica disponible segons els equips (ordenadores) que aporta cada ponent.
-- Obté un llistat amb el nom i el resultat d'elevar 2 al nombre d'ordinadors, posant l'àlies 'Capacitat_Calcul' a la columna resultant.

-- 19. Volem dividir els ponents en dos grups de treball segons si el seu identificador a la base de dades és parell o senar.
-- Fes un llistat que obtingui el nom del ponent i el residu de dividir l'ID per 2, ordenant el llistat final per aquest residu.

-- 20. El departament de qualitat necessita conèixer la ràtio de "puntuació per equip" de cada expert del congrés.
-- Divideix el 'rate' pel nombre d'ordinadors, arrodoneix el resultat a 2 decimals i mostra el nom del ponent en la mateixa fila, per a tots els ponents.

-- 21. La gerència vol saber la dimensió total del cos de ponents que participen en el Tech Summit d'enguany.
-- Fes una consulta que compti quants ponents hi ha registrats en total a la taula de dades.

-- 22. L'equip de logística necessita saber quants endolls i ordinadors s'han de gestionar en total a les sales.
-- Calcula la suma de la columna 'ordinadors' per a tots els ponents de la base de dades, móstra el resultat amb l'àlies 'endolls'.

-- 23. Per avaluar el nivell general de l'esdeveniment, volem saber la qualitat mitjana dels nostres ponents.
-- Obté la mitjana de la puntuació 'rate' de tots els ponents i anomena la columna resultant com a 'Mitjana_Qualitat'.

-- 24. Volem fer una menció especial i felicitar el ponent que ha obtingut la millor valoració de tot l'esdeveniment.
-- Troba quina és la puntuació 'rate' més alta registrada a la taula, sense importar de quin ponent es tracti.

-- 25. Per planificar el transport, volem saber quina és la càrrega mínima de material informàtic que porta un professor.
-- Obté el nombre mínim d'ordinadors que porta un sol ponent d'entre tots els registres del llistat.

-- 26. El departament d'agenda vol confirmar el volum de continguts i xerrades que s'han preparat.
-- Fes una consulta que compti quantes sessions o xerrades diferents hi ha programades a la taula de sessions.

-- 27. L'empresa patrocinadora 'tech corp' vol saber exactament quants dels seus treballadors estan actius al congrés.
-- Compta quants ponents pertanyen a l'empresa 'tech corp' fent servir una restricció de filtrat.

-- 28. Volem analitzar els recursos que aporten els ponents que s'han incorporat més tard al llistat (ID superior a 2).
-- Calcula la suma total d'ordinadors que porten aquests ponents específics.

-- 29. L'organització vol donar un premi als ponents d'elit, aquells que tenen un 'rate' excel·lent de 9 o 10.
-- Calcula la mitjana d'ordinadors que porten exclusivament els ponents que compleixen aquesta condició de nivell.

-- 30. L'equip de publicacions vol saber el volum de text total dels títols per calcular l'espai de la cartelleria.
-- Obté la suma de la longitud de tots els títols de les sessions programades.

-- 31. Necessitem un informe del volum de participació corporativa per saber quines empreses dominen l'esdeveniment.
-- Agrupa els ponents per empresa i mostra el nom de l'empresa i quants ponents n'hi ha de cada una.

-- 32. Volem saber com es distribueixen els equips informàtics segons el nivell d'expertesa dels professors.
-- Agrupa per cada nivell de 'rate' existent i calcula la suma total d'ordinadors per a cadascun d'aquests grups.

-- 33. Hi ha sales que podrien estar massa saturades si tenen massa xerrades assignades.
-- Obté el nom de les sales que tenen més d'una sessió programada utilitzant una restricció sobre l'agrupament.

-- 34. Volem analitzar si els experts tenen prou eines segons el seu nivell acadèmic.
-- Agrupa els ponents pel seu 'rate', mostra la mitjana d'equips de cada grup i filtra només aquells on la mitjana superi 1.

-- 35. L'equip de dades vol fer una estadística curiosa per saber si hi ha lletres més "populars" entre els ponents.
-- Mostra la primera lletra del nom i quants ponents tenen aquesta inicial, agrupat per aquesta lletra i ordenat pel recompte.

-- 36. Hi ha ponents que encara no han estat avaluats i la columna 'rate' té valors buits o desconeguts.
-- Mostra un llistat amb el nom i el 'rate', però si el valor és NULL, mostra un 5 com a valor mínim de seguretat.
-- Modifica les dades qeu calgui per provar aquesta consulta.

-- 37. Per a la llista pública de ponents a la web, no volem que ningú aparegui sense una empresa assignada.
-- Obté el nom i cognom, i si un ponent no té empresa, mostra el text 'Freelance' en una columna anomenada 'Empresa_Publica'.
-- Modifica les dades qeu calgui per provar aquesta consulta.

-- 38. Volem automatitzar la classificació visual dels ponents segons la seva valoració en el panell de control.
-- Crea un llistat amb una columna 'Estatus' que mostri 'Expert' si el rate és igual o superior a 9 i 'Standard' en cas contrari.

-- 39. Logística vol saber quines sales necessiten reforç de personal de protocol segons la seva importància.
-- Fes un llistat que mostri, per a cada sessió,  el títol de la sessió i posa 'Sala_Principal' si la xerrada és a la 'sala a' o 'Sala_Secundaria' si és a qualsevol altra.

-- 40. El departament de recursos humans vol una escala de rangs molt més clara per classificar els perfils.
-- Fes un llistat que mostri a cada registre el nom i l'empresa, i usa una estructura condicional per mostrar: de 5-6 'Junior', de 7-8 'Senior', i de 9-10 'Master'.

-- 41. El sistema de seguretat necessita imprimir en cada informe el dia exacte en què s'ha consultat la base de dades.
-- Fes una consulta que mostri la data actual del servidor amb l'àlies 'Data_Consulta'.

-- 42. Per al registre de logs de l'aplicació mòbil del congrés, necessitem el segell de temps complet.
-- Obté  la data i l'hora exacta del sistema (NOW) en una columna anomenada 'Timestamp_Execucio'.

-- 43. Volem saber quant de temps de marge tenim des que va començar l'any del congrés per tancar els comptes.
-- Calcula quants dies han passat des de l'1 de gener de 2026 fins al dia d'avui.

-- 44. El servei de neteja només necessita saber a quina hora en punt comencen les sessions per organitzar els torns.
-- Fes un llistat que mostri a cada registre mostri el títol de la sessió i només el valor de l'hora d'inici (sense minuts), ordenat cronològicament.

-- 45. L'equip del catering vol organitzar els torns de l'esmorzar i del dinar segons l'horari de les xerrades.
-- Fes un llistat que mostri a cada registre mostri el títol de la sessió i posa 'Torn_1' si l'hora és anterior a les 11:30:00, o 'Torn_2' si és posterior.

-- 46. Per a un missatge de benvinguda automatitzat a les pantalles, volem ajuntar el nom del ponent i la data actual.
-- Mostra un llistat que ajunti en una sola columna el nom del professor i la data d'avui (CURDATE).

-- 47. El tècnic de so vol saber quants minuts han passat des de l'inici del dia per calibrar les taules de mescles.
-- Calcula el total de minuts que han trascorren de les 00:00:00 per a cada sessió a partir de la seva hora d'inici.

-- 48. Per motius de traçabilitat, volem saber quin usuari és el responsable de les consultes actuals.
-- Selecciona el nom de l'usuari que està connectat actualment a la base de dades del Tech Summit.

-- 49. El servei de manteniment informàtic ha de verificar si el servidor és prou modern per al nou programari.
-- Obté una consulta que retorni la versió del servidor de base de dades que estem fent servir.

-- 50. Volem confirmar que estem operant sobre la base de dades de l'esdeveniment i no sobre una de proves.
-- Mostra el nom de la base de dades que està activa en aquest instant de la connexió.

-- 51. Per protegir les dades personals en fitxers externs, volem crear un identificador xifrat basat en el cognom.
-- Genera un codi MD5 a partir del cognom del ponent i mostra'l al costat del seu nom real.

-- 52. Per exportar els llistats a un sistema de correu antic, necessitem un format de text pla molt senzill.
-- Concatena el nom, el cognom i l'empresa separats per barres verticals ('|') i posa l'àlies 'Registre_Exportacio'.

-- 53. Els títols de les sessions a la web del congrés han de seguir un format de codi d'URL sense espais.
-- Mostra el títol en majúscules i canvia tots els espais per guions baixos ('_'), filtrant només les sessions de la 'sala b'.

-- 54. Volem saber quina és la xerrada amb el títol més llarg per ajustar el tamany de la lletra als monitors.
-- Obté la longitud del títol més extens de tota la taula de sessions i mostra només el número de caràcters.

-- 55. El departament de disseny vol imprimir unes xapes rodones petites on només hi caben noms de 4 caràcters.
-- Selecciona el nom i cognom dels ponents que tenen un nom de exactament 4 caràcters, ordenats per l'empresa.

-- 56. Per a un joc de pistes durant el descans, volem mostrar només una part del nom dels ponents.
-- Mostra les lletres que van de la posició 2 a la 5 del nom de cada ponent i anomena la columna 'Pista_Nom'.

-- 57. Volem crear un efecte visual curiós en la pantalla de benvinguda de la sala d'actes.
-- Mostra el nom del ponent i el seu mateix nom escrit totalment a l'inrevés (REVERSE) en una columna nova.

-- 58. El departament de qualitat vol simular un increment del 25% en totes les puntuacions de nivell.
-- Multiplica el 'rate' per 1.25, arrodoneix el resultat a 1 decimal i mostra-ho en un llistat al costat del nom del ponent.

-- 59. L'equip de dades necessita fer una operació matemàtica complexa sobre els identificadors de les xerrades.
-- Calcula el quadrat de l'ID de cada sessió i obté la suma total de tots aquests valors quadràtics.

-- 60. Volem generar uns codis de seguretat exponencials per als ponents segons la seva posició al llistat.
-- Obté un llistat amb l'ID del ponent i el resultat d'elevar l'ID al seu propi valor d'ID, amb l'àlies 'Hash_Exponencial'.

-- 61. Per donar visibilitat a tothom, volem triar un ponent a l'atzar cada vegada que carreguem la web.
-- Obté el nom i l'empresa d'un sol ponent triat de forma aleatòria de tota la base de dades.

-- 62. Volem fer tres torns diferents de recollida d'acreditacions segons l'ordre d'inscripció.
-- Fes un llistat que mostri el nom del ponent i el residu de dividir el seu ID per 3 per saber a quin torn pertany.

-- 63. La impremta ens pregunta quina és l'empresa amb el nom més curt per estalviar espai en els fulletons.
-- Troba quina és la longitud mínima del camp empresa i mostra també el nom d'aquella empresa específica.

-- 64. Necessitem un llistat informatiu per als panells de cada planta que indiqui la sessió i la sala.
-- Fes un llistat que mostri concatenat el text 'Xerrada: ', el títol, ' Ubicació: ' i la sala en una columna anomenada 'Guia_Sessio'.

-- 65. Per evitar que la web mostri espais buits quan un ponent no porta material propi.
-- Mostra un llistat amb el nom del ponent i el nombre d'ordinadors, però si és NULL, mostra el text 'Material_Propi'.

-- 66. L'equip de manteniment vol saber el volum de feina a la 'sala a' i la 'sala b'.
-- Compta quantes sessions es fan en aquestes dues sales en total fent servir una condició de filtratge.

-- 67. Volem analitzar l'impacte dels ponents que pertanyen a l'empresa 'innovate asix'.
-- Obté la suma de tots els IDs dels ponents que treballen en aquesta empresa concreta.

-- 68. Per a un estudi sobre la diversitat de noms en els congressos de tecnologia d'enguany.
-- Obté quina és la mitjana de caràcters (longitud) que tenen els cognoms de tots els ponents que participen.

-- 69. Per a un format de llista més compacte per a dispositius mòbils antics.
-- Fes un llistat que mostri el nom del ponent i només la primera lletra del seu cognom seguida d'un punt (ex: 'anna g.').

-- 70. El cost d'assegurar cada ordinador que entra a l'edifici és de 50€.
-- Calcula quin és el cost total d'assegurança per a cada ponent segons la quantitat d'equips que porta.

-- 71. L'equip de coordinació de tarda necessita la graella de xerrades a partir del migdia.
-- Selecciona totes les sessions que comencen a les 13:00:00 o més tard, mostrant el títol i l'hora d'inici.

-- 72. Volem detectar títols de xerrades que puguin tenir espais innecessaris que trenquin el disseny.
-- Fes un llistat que mostri el títol i una columna amb la diferència entre la seva longitud real i la seva longitud si li treiem els espais.

-- 73. Per a un exercici de nivell variable, volem establir un llindar de referència que canviï.
-- Genera un número aleatori que es trobi exactament entre el valor mínim de 'rate' i el valor màxim guardats a la taula.

-- 74. Volem saber quins noms de ponent són més "sonors" per a la megafonia.
-- Obté un llistat dels ponents que tenen més d'una lletra 'a' al seu nom, comparant la longitud original amb la del nom sense 'a'.

-- 75. Per a la pòlissa de riscos laborals del Tech Summit, necessitem calcular l'IVA dels equips.
-- Obté el 21% de la suma total d'ordinadors de tots els ponents multiplicada per una base de 100€ per unitat.

-- 76. El departament de trànsit de persones vol saber quins horaris estan més saturats de xerrades.
-- Agrupa les sessions per l'hora d'inici i mostra l'hora i quantes n'hi ha a cada franja.

-- 77. Per crear els indicadors que aniran penjats del sostre dels passadissos.
-- Fes un llistat que mostri la sala i el títol de la sessió ajuntats amb una fletxa " >>> " i posa l'àlies 'Indicador_Direccio'.

-- 78. Volem identificar el cognom més llarg per assegurar-nos que cap nom queda tallat en els llistats.
-- Troba el cognom que té més caràcters de tota la taula i mostra la seva longitud màxima.

-- 79. Necessitem un filtre ràpid per a la gestió d'accessos segons si la sessió és de matí o de tarda.
-- Fes un llistat que on tinguis una columna que mostri 'MATI' si la sessió comença abans de les 14:00:00 o 'TARDA' si comença més tard.

-- 80. Volem comparar la diferència tècnica entre els dos ponents més veterans (ID 1 i ID 2).
-- Calcula la diferència absoluta entre el nombre d'equips del ponent amb ID 1 i el ponent amb ID 2 en una sola consulta.

-- 81. Per a la secció de crèdits finals de la web, volem un ordre alfabètic invers.
-- Mostra el títol de totes les sessions en minúscules i ordenades de la Z a la A.

-- 82. Volem saber la riquesa de col·laboracions empresarials que tenim en aquesta edició.
-- Compta quantes empreses diferents (sense repetir) participen en total en el Tech Summit.

-- 83. Per crear un efecte animat de càrrega de dades en el panell de l'administrador.
-- Mostra l'ID, el nom i una columna nova on el nom aparegui repetit 5 vegades seguides per a cada registre.

-- 84. Hi ha hagut un canvi d'última hora en el nom de les instal·lacions de l'esdeveniment.
-- Obté un llistat on la paraula 'sala' del camp sala aparegui substituïda pel text 'AULARI_TECNIC'.

-- 85. Per a les estadístiques que s'enviaran a la Generalitat, necessitem la mitjana d'equips sense decimals.
-- Calcula la mitjana d'ordinadors de tots els ponents i trunca el resultat (TRUNCATE) per mostrar només la part sencer.

-- 86. Si el prestigi dels nostres professors augmenta de manera exponencial segons la seva nota actual.
-- Calcula el 'rate' elevat al quadrat per a cada ponent i mostra el resultat al costat de la seva empresa.

-- 87. Per a un sistema d'etiquetatge que segueix les normes d'arxiu tradicionals.
-- Fes un llistat que mostri el cognom en majúscules, seguit d'una coma i el nom original (ex: 'ROVIRA, marc').

-- 88. L'equip de màrqueting ja està pensant en el Tech Summit del 2027.
-- Calcula quants dies falten des d'avui mateix fins al 15 de febrer de 2027 fent servir una funció de diferència de dates.

-- 89. Volem trobar ràpidament quines xerrades tracten sobre Intel·ligència Artificial.
-- Fes un llistat que mostri el títol de la sessió i la posició numèrica on apareix el text 'ia' dins del títol de cada xerrada.

-- 90. Per a una integració amb un sistema de gestió d'hotels que només accepta camps de 20 caràcters fixos.
-- Fes un llistat que mostri el nom del ponent omplint amb asteriscs '*' a l'esquerra fins a arribar exactament als 20 caràcters.

-- 91. Volem crear una puntuació de referència paral·lela que no canviï cada vegada que s'executa la consulta.
-- Fes un llistat que mostri el 'rate' multiplicat per un número aleatori fixant la llavor (seed) amb el número 50.

-- 92. El departament de manteniment vol fer una revisió als ponents que porten un nombre d'equips que es pugui aparellar.
-- Selecciona tots els ponents que porten un nombre parell d'ordinadors i mostra el seu nom i cognom.

-- 93. Per a la creació de comptes de correu temporals per a l'ús de la xarxa Wi-Fi interna.
-- Fes un llistat que mostri concatenat el nom del ponent amb el sufix '@itb.cat' i anomena la columna 'Email_WiFi_Intern'.

-- 94. El departament d'anàlisi estratègica vol una xifra d'impacte tecnològic per cada expert.
-- Calcula el valor del 'rate' elevat al nombre d'ordinadors per a cada ponent i mostra també la seva empresa.  Fes un llistat.


-- 95. Per a la capçalera de l'informe de tancament de trimestre.
-- Fes una consulta que mostri la data d'avui i el número del mes actual (MONTH) en dues columnes amb àlies propis.

-- 96. Volem preveure l'espai i el consum elèctric si l'any vinent cada ponent d''innovate asix' portés 2 ordinadors més.
-- Fes un llistat que mostri el nom i el nombre d'ordinadors actuals sumant-li 2 unitats, només per als ponents d'aquesta empresa.

-- 97. Per crear un efecte de misteri en els fulletons publicitaris de les xerrades.
-- Selecciona el títol de cada sessió però retalla'l de manera que no es mostrin les 3 darreres lletres.

-- 98. Volem donar un tracte preferent en la llista de trasllats al ponent que es va inscriure primer.
-- Fes un llistat que mostri el nom i una columna que digui 'Cap_de_Llista' si l'ID és igual a 1, o 'Resta_de_Ponents' en cas contrari.

-- 99. Per a un índex ràpid de participació que sumi el nivell acadèmic i els recursos materials.
-- Obté la suma de les columnes 'rate' i 'ordenadores' per a cada ponent en una columna anomenada 'Index_Global'.

-- 100. Per donar per finalitzat el llistat oficial de dades del Tech Summit 2026.
-- Selecciona el nom, el cognom i l'empresa, i afegeix una darrera columna fixa amb el text 'REGISTRE_VERIFICAT'.  Mostra el llistat