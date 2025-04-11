set search_path to YrkesCo;

--Vilken student som går i vilken klass på vilken skola

select
	s.förnamn,
	s.efternamn,
	bo.program_id || bo.år as klass,
	sk.skolnamn
from
	student s
inner join antagen_student ans on ans.student_id = s.student_id
inner join klass k on k.klass_id = ans.klass_id
inner join beviljad_omgång bo on bo.bo_id = k.bo_id
inner join skola sk on sk.skol_id = s.skol_id
order by klass, sk.skolnamn;

-- konsulter deras bolagm timpris samt vart deras företag ligger
select
	p.förnamn,
	p.efternamn,
	kb.bolagsnamn,
	k.timpris,
	a.gatuadress,
	s.stad
from
	personal p
inner join konsult k on k.personal_id = p.personal_id
inner join konsultbolag kb on kb.org_nummer = k.org_nummer
inner join adress a on a.adress_id = kb.adress_id
inner join stad s on s.stad_id = a.stad_id;

-- ledningsgrupp med företags rep, student rep och skol rep
select
	lg.program_id,
	f.representant,
	f.företag_namn,
	s.förnamn || ' ' || s.efternamn as student_representant,
	p.förnamn || ' ' || p.efternamn as skol_represetant,
	sk.skolnamn
from
	ledningsgrupp lg
inner join ledningsföretag lf on lf.ledningsgrupp_id = lg.ledningsgrupp_id
inner join företag f on f.företag_org_nummer = lf.företag_org_nummer
inner join ledningstudent ls on ls.ledningsgrupp_id = lg.ledningsgrupp_id
inner join student s on s.student_id = ls.student_id
inner join skola sk on sk.skol_id = lg.skol_id
inner join ledningspersonal lp on lp.ledningsgrupp_id = lg.ledningsgrupp_id
inner join personal p on p.personal_id = lp.personal_id;

-- program och kurserna dem innehåller
select
	p.program_id,
	p.programnamn,
	string_agg(k.kurskod, ', ') as kurs_innehåll
from
	program p
inner join kursprogram kp on kp.program_id = p.program_id
inner join kurs k on k.kurskod = kp.kurskod
group by p.program_id;


