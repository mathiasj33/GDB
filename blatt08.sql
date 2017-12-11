with anzGesamt as (select s.fakname, count(*) anz from studentenGF s group by s.fakname),
	anzMaennlich (fakname, anz) as (
      (select s.fakname, count(*) from studentenGF s group by s.fakname, s.geschlecht having s.geschlecht='M') 
       union 
      (select s.fakname, 0 from studentenGF s where not exists (select * from studentenGF s2 where s2.fakname = s.fakname and s2.geschlecht = 'M')))
    
select am.fakname, (1.00*am.anz)/ag.anz anteilMaennlich from anzMaennlich am, anzGesamt ag where am.fakname = ag.fakname