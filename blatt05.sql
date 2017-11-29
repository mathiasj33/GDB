/*Aufgabe 3*/
with kenntSich(MatrNr1, MatrNr2) as (
  		select distinct s1.matrnr, s2.matrnr from studenten s1, studenten s2, hoeren h1, hoeren h2 where
  				s1.matrnr = h1.matrnr and h1.vorlnr = h2.vorlnr and h2.matrnr = s2.matrnr)
                
select matrnr1, 1.0*count(*)/(select count(*) from studenten) Bekanntheitsgrad from kenntsich group by matrnr1 order by bekanntheitsgrad desc


/*Aufgabe 4*/
with zehnkampfd ( name , disziplin , punkte ) as (
values
( ' Bolt ' , ' 100 m ' , 50) , /*50*/
( ' Bolt ' , ' Weitsprung ' , 50) ,
( ' Eaton ' , ' 100 m ' , 40) ,
( ' Eaton ' , ' Weitsprung ' , 60) ,
( ' Suarez ' , ' 100 m ' , 60 ) ,
( ' Suarez ' , ' Weitsprung ' , 60) ,
( ' Behrenbruch ' , ' 100 m ' , 30) ,
( ' Behrenbruch ' , ' Weitsprung ' , 50)
),

worseThanBolt as (
  select distinct z1.name from zehnkampfd z1 join zehnkampfd z2 on z1.disziplin=z2.disziplin where z2.name=' Bolt ' and z2.punkte >= z1.punkte) 


select distinct z.name from Zehnkampfd z where not exists
(select * from worseThanBolt w where z.name = w.name) /*Eigentlich mit minus aber das mag HyPer nicht...*/

