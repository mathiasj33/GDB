3.
(a)
with anzGesamt as (select s.fakname, count(*) anz from studentenGF s group by s.fakname),
	anzMaennlich (fakname, anz) as (
      (select s.fakname, count(*) from studentenGF s group by s.fakname, s.geschlecht having s.geschlecht='M') 
       union 
      (select s.fakname, 0 from studentenGF s where not exists (select * from studentenGF s2 where s2.fakname = s.fakname and s2.geschlecht = 'M')))
    
select am.fakname, (1.00*am.anz)/ag.anz anteilMaennlich from anzMaennlich am, anzGesamt ag where am.fakname = ag.fakname

(b)

with vorlesungenFakultaet as (select v.vorlnr, p.fakname from vorlesungen v, professorenf p where v.gelesenvon = p.persnr)

select * from studentengf s where not exists 
(select * from vorlesungenFakultaet v where v.fakname = s.fakname and not exists
(select * from hoeren h where h.matrnr = s.matrnr and h.vorlnr = v.vorlnr))

Alternativ (mit count):

with vorlesungenFakultaet as (select v.vorlnr, p.fakname from vorlesungen v, professorenf p where v.gelesenvon = p.persnr),
	 hoerenAusFakultaet as (select s.matrnr, v.vorlnr from studentengf s, hoeren h, vorlesungenFakultaet v where
                            s.matrnr = h.matrnr and h.vorlnr = v.vorlnr and s.fakname = v.fakname)

select s.matrnr, s.fakname from studentengf s, hoerenAusFakultaet h
where s.matrnr = h.matrnr
group by s.matrnr, s.fakname
having count(*) = (select count(*) from vorlesungenFakultaet v where v.fakname = s.fakname)
union -- Es gibt Leute die an einer Fakultät sind, von der keine Vorlesungen gelesen werden
(select s.matrnr, s.fakname from studentengf s where not exists (select * from vorlesungenFakultaet v where v.fakname = s.fakname))