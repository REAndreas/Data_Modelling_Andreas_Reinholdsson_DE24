
set search_path to yrkesco;


select * from klass;

select  * from antagen_student;

select * from beviljade_omgångar bo ;

select * from ledningsföretag;

select * from företag;

select * from ledningstudent;

select * from adress;


-- Vilka som ingår i Ledningsgrupperna 
SELECT lg.program_id,sk.skolnamn ,p.f_namn as personal, y.titel, s.f_namn as student, f.företag_namn, f.representant
from ledningsgrupp lg
inner join ledningspersonal lp on lg.ledningsgrupp_id = lp.ledningsgrupp_id
inner join personal p on lp.personal_id = p.personal_id
inner join ledningstudent ls on lg.ledningsgrupp_id = ls.ledningsgrupp_id
inner join student s on ls.student_id = s.student_id
inner join yrkesroll y on p.yrkes_id = y.yrkes_id
inner join skola sk on lg.skol_id = sk.skol_id
inner join ledningsföretag lf on lg.ledningsgrupp_id = lf.ledningsgrupp_id
inner join företag f on lf.företag_org_nummer = f.företag_org_nummer
order by lg.program_id;


-- Utbildningsledare som ansvarar för vilka klasser
SELECT bo.program_id || bo.år as klass, p.f_namn ||' '|| p.e_namn as Utbildningsledare, s.skolnamn
FROM personal p
inner join klass kl on p.personal_id = kl.personal_id
inner join yrkesroll y on p.yrkes_id = y.yrkes_id
inner join beviljade_omgångar bo on kl.bo_id = bo.bo_id
inner join skola s on kl.skol_id = s.skol_id 
inner join "program" p2 on bo.program_id = p2.program_id 
where y.yrkes_id = 1;


-- Vilka Studenter som bor på vilka adresser med deras personnummer
select s.f_namn as förnamn, s.e_namn as efternamn,pu.personnummer ,a.gatuadress, st.stad
from student s
inner join person_uppgifter pu on s.pu_id = pu.pu_id
inner join adress a on  pu.adress_id = a.adress_id
inner join stad st on a.stad_id = st.stad_id 


