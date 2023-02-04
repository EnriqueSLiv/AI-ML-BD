
select nombremodelo, nombremarca, nombregrupoempresarial, matricula, nombrecolor, fechacompra, nombrecoaseguradora, npoliza, totalkms
from kcfleetcontrol.coche 
join kcfleetcontrol.modelo
on modelo=idmodelo and fechabaja='4000-01-01'
join kcfleetcontrol.marca
on marca=idmarca
join kcfleetcontrol.grupoempresarial
on grupoempresarial=idgrupoempresarial
join kcfleetcontrol.color
on color=idcolor
join kcfleetcontrol.coaseguradora
on coaseguradora=idcoaseguradora;