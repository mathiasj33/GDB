Aufgabe 1)

with studentSWS(matrnr,SWS) as (
  		select s.matrnr,sum(sws) from studenten s, hoeren h, vorlesungen v where s.matrnr = h.matrnr and h.vorlnr = v.vorlnr 			group by s.matrnr 
  		union
  		select s.matrnr,0 from studenten s where not exists (select * from hoeren h where h.matrnr = s.matrnr)
  ),
averageSWS as (select avg(SWS) from studentSWS)

select * from studentSWS s where s.SWS > (select * from averageSWS)


Aufgabe 2)

with gehoertePruefungen as (
  		select * from pruefen p, hoeren h where h.matrnr = p.matrnr and h.vorlnr = p.vorlnr),
   	 nichtGehoertePruefungen as (
       	select * from pruefen p where not exists (select * from hoeren h where h.matrnr = p.matrnr and h.vorlnr = p.vorlnr)),
     gehoertSchnitt as (select avg(g.note) from gehoertePruefungen g),
     nichtGehoertSchnitt as (select avg(ng.note) from nichtGehoertePruefungen ng)
        
select * from gehoertSchnitt, nichtGehoertSchnitt

Aufgabe 3)

select s.* from studenten s where not exists (select * from pruefen p where p.matrnr = s.matrnr and not exists (select * from hoeren h where h.matrnr = s.matrnr and h.vorlnr = p.vorlnr))



