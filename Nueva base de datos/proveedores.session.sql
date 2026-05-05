SELECT nombre, id from Proveedor where nombre LIKE "C%";

--SELECT nombre, id from Suministro where id in (5,8,9,11,12,14);



SELECT Proveedor.id, Proveedor.nombre, Suministro.id, Suministro.nombre, Suministro.proveedor_id from Proveedor, Suministro where Proveedor.id = proveedor_id  ORDER BY Proveedor.id, Suministro.id;

-- buscar la id del proveedor de chorizos
SELECT Suministro.id, Suministro.nombre, Suministro.proveedor_id, Proveedor.id, Proveedor.nombre
from Proveedor, Suministro 

where Suministro.nombre like "%horizo%" 
    and Proveedor.id = proveedor_id
ORDER BY Proveedor.id, Suministro.id; 




------------------------------------------------------------------
-------             Con Join             -------------------------
------------------------------------------------------------------




 
SELECT Suministro.id, Suministro.nombre, Suministro.proveedor_id, Proveedor.id, Proveedor.nombre
from Proveedor JOIN Suministro 
on Proveedor.id = proveedor_id
where Suministro.nombre like "%horizo%" 
ORDER BY Proveedor.id, Suministro.id; 


-- on



--Inner
--outer
--left
--right

SELECT Perro.id, Perro.nombre, Persona.id, Persona.nombre 
from Perro INNER join Persona
on id_persona = Persona.id;


SELECT Perro.id, Perro.nombre, Persona.id, Persona.nombre 
from Perro left outer join Persona
on id_persona = Persona.id;


SELECT Perro.id, Perro.nombre, Persona.id, Persona.nombre 
from Perro RIGHT outer join Persona
on id_persona = Persona.id;

SELECT Perro.id, Perro.nombre, Persona.id, Persona.nombre 
from Perro LEFT join Persona
on id_persona = Persona.id;



SELECT Perro.id, Perro.nombre, Persona.id, Persona.nombre 
from Perro RIGHT join Persona
on id_persona = Persona.id;

SELECT Perro.id, Perro.nombre, Persona.id, Persona.nombre 
from Perro join Persona
on Persona.id = id_persona;
