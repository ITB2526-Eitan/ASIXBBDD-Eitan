# Examen de SQL — 1r ASIX · Versió 2

## RA4: Consultes, Funcions i JOINs

| | |
|---|---|
| **Mòdul** | Bases de Dades |
| **Curs** | 2025–2026 |
| **Durada de la sessió** | 3 hores |
| **Data** | _________________ |
| **Alumne/a** | _________________ |

---

## Normes de l'examen

- **No es permet cap apunt**, llibre ni dispositiu no autoritzat.
- **No es permet cap pantalla o pestanya oberta** que no sigui la del classroom, la de l'script d'entrega, o la de l'IDE.
- Disposeu d'**una connexió a la base de dades** per provar les vostres consultes.
- **L'únic arxiu que heu d'entregar** és el fitxer `.sql` amb les vostres respostes.
- Cinc minuts abans del final de la sessió, deixeu d'escriure i prepareu l'entrega.
- Abans d'entregar, escriviu un **comentari SQL a l'inici del fitxer** amb el vostre nom i cognoms complets.
- **Nom del fitxer d'entrega:** `examen_sql_NomCognom.sql`  
  (exemple: `examen_sql_MartaGarcia.sql`)

---

## Bases de dades disponibles

### Context A — Congrés TechSummit

Gestió d'un congrés de tecnologia. Conté les taules:

```
dades_ponent (id, nom, cognom, empresa, ordinadors, rate, complex_rate)
```

- `ordinadors`: nombre d'ordinadors assignats al ponent (valors: 0–4)
- `rate`: valoració del ponent com a expert (valors enters: 5–10)
- `complex_rate`: valoració ponderada (valors decimals: 5.0–10.0)

```
sessio (id, titol, hora, sala)
```

- `hora`: hora d'inici de la sessió (tipus TIME)

---

### Context B — Empresa IT

Empresa del sector tecnològic. Conté les taules:

```
departament (id, nom, ubicacio, pressupost, telefon)
empleat     (id, nom, cognom, salari, data_alta, id_departament)
```

- `data_alta`: data d'incorporació a l'empresa (tipus DATE)
- `id_departament`: clau forana cap a `departament` (NOT NULL)

---

### Context C — Plataforma de Cinema CineMax (`cinemax`)

Plataforma de streaming especialitzada en cinema independent. Conté les taules:

```
genere_cine (id, nom)
director    (id, nom, id_genere_cine, pais, any_debut, en_actiu)
pelicula    (id, titol, any_estrena, durada_min, taquilla, id_director)
```

- `en_actiu`: indica si el director té producció activa (TINYINT: 1 = sí, 0 = no)
- `id_director` a la taula `pelicula`: pot ser NULL (pel·lícules en producció sense director assignat)
- `taquilla`: nombre total d'espectadors (INT)

---

### Context D — Federació Esportiva Catalana (`esports`)

Organisme que agrupa clubs i esportistes federats de Catalunya. Conté les taules:

```
modalitat  (id, nom)
club       (id, nom, localitat)
entrenador (id, nom, cognom, id_modalitat, num_llicencia, id_club)
esportista (id, nom, cognom, data_naix, num_federat, id_entrenador)
```

- `id_entrenador` a la taula `esportista`: clau forana cap a `entrenador` (NOT NULL)

---

### Secció 1 — Funcions sense JOINs

---

#### Pregunta 1 · [3 punts] · Context A

El departament de comunicació del congrés TechSummit necessita generar **etiquetes identificatives** per als ponents. Escriviu una consulta sobre la taula `dades_ponent` que mostri les columnes següents:

- **`codi_ponent`**: les 3 primeres lletres del cognom en majúscules, seguides de l'`id` del ponent completat amb zeros per l'esquerra fins a tenir 4 dígits.  
  Exemple: si el cognom és *'García'* i l'id és *7*, el codi ha de ser `'GAR0007'`.
- **`nom_complet`**: el nom i el cognom del ponent en format `COGNOM, Nom`, on el cognom va tot en majúscules, seguit d'una coma, un espai, i el nom amb la primera lletra en majúscula i la resta en minúscules.
- El nom de l'empresa on treballa cada ponent.

Ordena els resultats alfabèticament per cognom.

---

#### Pregunta 2 · [3 punts] · Context A

El comitè organitzador vol analitzar les valoracions dels ponents amb diverses transformacions numèriques. Escriviu una consulta sobre `dades_ponent` que mostri per a cada ponent:

- El nom i el cognom.
- La valoració (`rate`) arrodonida a l'enter més proper.
- La valoració complexa (`complex_rate`) truncada a 1 decimal.
- La diferència entre el sostre (*ceiling*) del `rate` i el terra (*floor*) del `complex_rate`, en una columna anomenada `diferencia`.
- Si el nombre d'ordinadors (`ordinadors`) és **parell o senar**: valors `'Parell'` o `'Senar'` en una columna anomenada `paritat`.

Mostra únicament els ponents que tinguin una valoració complexa superior a 0.

---

#### Pregunta 3 · [3 punts] · Context B

El departament de Recursos Humans de l'Empresa IT vol fer una **auditoria del personal**. Escriviu una consulta sobre la taula `empleat` que mostri per a cada empleat:

- El nom complet (nom i cognom en una sola columna).
- La data d'alta en format europeu `DD/MM/YYYY`, en una columna anomendada `data_incorporacio`.
- L'any i el mes d'incorporació en columnes separades (`any_incorporacio` i `mes_incorporacio`).
- El nombre d'**anys complets** que porta treballant a l'empresa, calculat a partir de la data d'avui, en una columna anomendada `anys_antiguitat`.

Ordena els resultats dels empleats **més antics als més nous**.

---

#### Pregunta 4 · [3 punts] · Context A

El sistema de gestió vol classificar automàticament els ponents i el seu equipament. Escriviu una consulta sobre `dades_ponent` que mostri per a cada ponent:

- El nom complet (nom i cognom en una sola columna).
- La seva valoració (`rate`).
- Una columna **`categoria`** amb la classificació del ponent:
  - `'Expert'` si rate és 9 o 10
  - `'Avançat'` si rate és 7 o 8
  - `'Intermedi'` si rate és 5 o 6
- Una columna **`equipament`** que indiqui la disponibilitat de material:
  - `'Molt equipat'` si té 3 o més ordinadors
  - `'Equipat'` si en té 1 o 2
  - `'Sense equip'` si no en té cap

Ordena per categoria (Experts primers, Intermedis al final) i, dins de cada categoria, per valoració de major a menor.

---

#### Pregunta 5 · [3 punts] · Context A

La direcció del congrés TechSummit vol un **resum de la participació per empresa**. Escriviu una consulta sobre `dades_ponent` que mostri, per a cada empresa:

- El nom de l'empresa.
- El nombre de ponents que té al congrés.
- La valoració mitjana dels seus ponents, arrodonida a 2 decimals.
- La valoració màxima i la valoració mínima entre els seus ponents.

Ordena per nombre de ponents de major a menor; en cas d'empat, per nom d'empresa alfabèticament.

---

#### Pregunta 6 · [3 punts] · Context A

L'equip d'organització del congrés vol conèixer l'**ocupació de les sales** i el programa horari. Escriviu una consulta sobre la taula `sessio` que mostri, per a cada sala:

- El nom de la sala.
- El nombre de sessions programades en aquella sala.
- L'hora de la **primera** sessió del dia (la més matinera).
- L'hora de l'**última** sessió del dia (la més tardana).

Ordena els resultats per nombre de sessions de major a menor.

---

#### Pregunta 7 · [3 punts] · Context A

El comitè de qualitat vol identificar les empreses amb **presència significativa i alta qualitat** al congrés. Escriviu una consulta sobre `dades_ponent` que mostri el nom de l'empresa, el nombre de ponents i la valoració mitjana (arrodonida a 2 decimals), però **únicament** de les empreses que compleixin **totes dues** condicions de manera simultània:

- Que tinguin **més d'un ponent** al congrés.
- Que la valoració mitjana dels seus ponents sigui **superior a 7**.

Ordena per valoració mitjana de major a menor.

---

#### Pregunta 8 · [3 punts] · Context A

El director del congrés necessita un **informe de representació empresarial en format compacte**. Escriviu una consulta que, per a cada empresa, mostri:

- El nom de l'empresa.
- El nombre de ponents.
- Una llista de tots els noms complets (nom + cognom) dels seus ponents en una **sola columna** (`llista_ponents`), separats pel text `' | '` i ordenats alfabèticament per cognom.

Ordena les empreses per ordre alfabètic del seu nom.

---

#### Pregunta 9 · [3 punts] · Context A

La junta directiva vol un **informe executiu complet** per a la selecció d'empreses col·laboradores. Escriviu una consulta sobre `dades_ponent` que mostri per a cada empresa:

- El nom de l'empresa.
- El nombre de ponents.
- La suma total d'ordinadors assignats a tots els seus ponents.
- La valoració complexa (`complex_rate`) mitjana, truncada a 1 decimal.
- Una columna **`classificacio`** que indiqui:
  - `'Premium'` si l'empresa té més de 2 ponents **i** la valoració màxima és >= 9.
  - `'Risc'` si la valoració mínima és < 6, independentment de la resta.
  - `'Estàndard'` en qualsevol altre cas.

Mostra **únicament** les empreses amb **almenys 2 ponents** i una **suma total d'ordinadors superior a 3**. Ordena per nombre de ponents de major a menor i, en cas d'empat, per valoració complexa mitjana de major a menor.

---

### Secció 2 — Preguntes teòriques i conceptuals

> Escriviu totes les respostes d'aquesta secció com a **comentaris SQL** dins el fitxer d'entrega, a continuació de l'enunciat de cada pregunta.

---

#### Pregunta 10 · [3 punts] · Conceptual

Respon a les tres preguntes sobre el `NATURAL JOIN`:

a) En què consisteix el `NATURAL JOIN`? Quin resultat produeix i com determina les columnes de connexió entre les dues taules?

b) Per quin motiu **no** és recomanable usar-lo en bases de dades en entorns professionals o en equips de treball?

c) Quina alternativa hauries de fer servir i per quin motiu és preferible?

---

#### Pregunta 11 · [3 punts] · Conceptual

MySQL no implementa el `FULL OUTER JOIN`. Respon i desenvolupa:

a) Quin resultat produiria un `FULL OUTER JOIN` si existís a MySQL? En quina situació de negoci seria útil?

b) Com es pot **simular** el mateix resultat a MySQL? Escriu la **plantilla SQL genèrica** per a dues taules genèriques `A` i `B` (no cal cap context concret).

---

### Secció 3 — JOINs

---

#### Pregunta 12 · [3 punts] · Context B

La cap de Personal de l'Empresa IT vol un **directori actualitzat** de tots els treballadors amb la informació del seu departament. Escriviu una consulta que mostri, per a cada empleat **que estigui assignat a un departament**, el seu nom complet (nom i cognom), el nom del departament on treballa i la ubicació del departament.

Ordena els resultats per nom de departament i, dins de cada departament, per cognom de l'empleat.

---

#### Pregunta 13 · [3 punts] · Context B

L'empresa vol un informe de recursos humans que inclogui **tots els departaments**, fins i tot aquells que no tinguin cap empleat assignat. Escriviu una consulta que mostri per a cada departament: el nom del departament, la seva ubicació, el **nombre d'empleats** que té (si no en té cap, ha de mostrar `0`) i el **salari mitjà** dels seus empleats (pot ser NULL si no en té cap).

Ordena per nombre d'empleats de major a menor i, en cas d'empat, per nom de departament.

---

#### Pregunta 14 · [3 punts] · Context B

Arran d'una reestructuració interna, s'han creat nous departaments que han quedat sense empleats assignats. Escriviu una consulta que mostri **únicament** els departaments sense cap empleat: el nom del departament, la seva ubicació i el seu pressupost.

Pensa bé quin tipus d'unió cal usar i quina condició ha de tenir el filtre perquè funcioni correctament.

---

#### Pregunta 15 · [3 punts] · Context C

La plataforma CineMax vol publicar a la seva web un **catàleg complet de totes les pel·lícules** de la col·lecció, incloses les que estan en fase de postproducció i encara no tenen director assignat. Escriviu una consulta que mostri, per a cada pel·lícula: el títol, l'any d'estrena, la durada en minuts i el nom del director. Si una pel·lícula no té director assignat, ha de mostrar el text `'Director per confirmar'` a la columna del director.

Ordena per any d'estrena de més recent a més antic i, en cas d'empat, per títol alfabèticament.

---

#### Pregunta 16 · [3 punts] · Context C

El departament de continguts de CineMax vol analitzar el rendiment dels **directors amb més producció**. Escriviu una consulta que mostri, per a cada director: el seu nom, el nombre total de pel·lícules que ha dirigit i la suma total d'espectadors (`taquilla`) de totes les seves pel·lícules. Mostra **únicament** els directors que tinguin **almenys 2 pel·lícules** i una **taquilla total superior a 0**. Ordena per taquilla total de major a menor.

---

#### Pregunta 17 · [3 punts] · Context D

La Federació Esportiva Catalana necessita un **directori complet de tots els entrenadors federats**. Escriviu una consulta que mostri per a cada entrenador: el seu nom complet (nom i cognom), el nom de la seva modalitat esportiva, el nom del club on treballa i la localitat del club.

Ordena els resultats per nom de modalitat i, dins de cada modalitat, per cognom de l'entrenador.

---

#### Pregunta 18 · [3 punts] · Context D

La Federació vol analitzar la **distribució de la càrrega de treball** entre clubs i modalitats. Escriviu una consulta que mostri, per a cada combinació de modalitat esportiva i club: el nom de la modalitat, el nom del club, el nombre d'entrenadors d'aquella modalitat que hi treballen i el nombre total d'esportistes que entrenen. Mostra **únicament** les combinacions on el nombre total d'esportistes sigui **superior a 3**. Ordena per nombre d'esportistes de major a menor.

---

## Rúbrica de correcció

| Nivell | Descripció | Punts |
|---|---|:---:|
| **Expert** | La consulta s'executa sense errors i retorna exactament el resultat esperat (columnes correctes, valors correctes, ordre correcte si s'especifica). | **3** |
| **Avançat** | La consulta no s'executa (error de sintaxi) però l'estructura i la lògica estan ben plantejades: taules correctes, clàusules adequades, lògica coherent. L'error és menor i corregible amb un petit canvi. | **1** |
| **Iniciat** | La consulta no s'executa, o s'executa però retorna un resultat incorrecte o mal plantejat, o ambdues coses. | **0** |

**Preguntes teòriques (P10, P11):** s'aplica la mateixa escala valorant la correcció i completesa de l'explicació i, per a P11, la correcció de la plantilla SQL.

### Puntuació total

> **Nota final = (punts obtinguts / 54) × 10**

| | |
|---|---|
| Preguntes | 18 |
| Puntuació màxima per pregunta | 3 punts |
| **Puntuació màxima total** | **54 punts** |
| Nota mínima per aprovar (5) | 27 punts |
