Aufgabe 1)

a)
with ubahn(Von, Nach, Dauer) as (
  		values
  		('GFZ', 'Garching', 2),
  		('Garching', 'GH', 2),
  		('GH', 'Froetmanning', 4),
  		('Froetmanning', 'Kieferngarten', 2),
  		('Kieferngarten', 'Freimann', 1)
  ),
recursive erreicht(von,nach) as (
	(select u.von, u.nach from ubahn u)
	union all
	(select u.von, e.nach from erreicht e, ubahn u where e.von = u.nach))

select distinct * from erreicht where von = 'GFZ'

b)
with recursive huelle(von,nach,dauer) as (
	(select u.von, u.nach, u.dauer from ubahn u)
	union all
	(select u.von, e.nach, u.dauer+e.dauer from erreicht e, ubahn u where e.von = u.nach))

select h.nach, h.dauer from huelle where h.von = 'Name'

c)
with recursive huelle(von,nach) as (
	(select u.von, u.nach from ubahn u)
	union all
	(select u.von, e.nach from huelle h, ubahn u where h.von = u.nach)),
     recursive doppelhuelle(von, nach) as ( --????
	(select h.nach, h.von from huelle)
	union all
	(select h.von, d.nach from huelle h, doppelhuelle d where h.nach = d.von)

select distinct * from doppelhuelle

Einfacher: zwei mal die transitive Hülle und vereinigen
Problem: Zweimal gleichzeitig in die Richtung laufen: Endlosschleife.

Symmetrische Relation: Terminiert nicht

