-- ISM Time Machine: initial faculty directory seed.
-- Names, roles and portrait files are transcribed from the UFE department
-- screenshots supplied by the project owner. Other profile fields are blank
-- until verified. Run this once after schema.sql in Supabase SQL Editor.

insert into public.teachers (full_name, position, department, photo_url, bio, degree, courses, research, sort_order)
select v.full_name, v.position, 'Мэдээллийн Системийн Менежментийн тэнхим', v.photo_url,
       v.bio, v.degree, v.courses, v.research, v.sort_order
from (values
 ('Н.Саранчимэг','Тэнхимийн эрхлэгч','/images/teachers/n-saranchimeg.png','','','{}'::text[],'{}'::text[],1),
 ('Ш.Ганболд','Зөвлөх багш','/images/teachers/sh-ganbold.png','','','{}'::text[],'{}'::text[],2),
 ('Д.Анхтуяа','Дэд профессор','/images/teachers/d-ankhtuya.png','','','{}'::text[],'{}'::text[],3),
 ('Ц.Гүндэгмаа','Ахлах багш','/images/teachers/ts-gundegmaa.png','','','{}'::text[],'{}'::text[],4),
 ('Л.Эрдэнэсайхан','Ахлах багш','/images/teachers/l-erdenesaikhan.png','','','{}'::text[],'{}'::text[],5),
 ('Г.Эрдэнэцэцэг','Ахлах багш','/images/teachers/g-erdenetsetseg.png','','','{}'::text[],'{}'::text[],6),
 ('Б.Бат-Оргил','Ахлах багш','/images/teachers/b-bat-orgil.png','','','{}'::text[],'{}'::text[],7),
 ('Д.Хулан','Ахлах багш','/images/teachers/d-khulan.png','Дэлгэрэнгүй намтар, сургалт болон судалгааны мэдээллийг UFE-ийн албан ёсны профайлаас шалгана уу.','MBA',array['Мэдээллийн системийн төслийн менежмент','Өгөгдлийн шинжилгээний үндэс / Python','Системийн шинжилгээ ба зохиомж'],array['Хиймэл оюун','Өгөгдлийн шинжилгээ','Машин сургалт','Өгөгдлийн агуулах','Блокчейн'],8),
 ('Н.Хөгжилт','Багш','/images/teachers/n-khogjilt.png','','','{}'::text[],'{}'::text[],9),
 ('Б.Гэрэлцолмон','Багш','/images/teachers/b-gereltsolmon.png','','','{}'::text[],'{}'::text[],10)
) as v(full_name,position,photo_url,bio,degree,courses,research,sort_order)
where not exists (select 1 from public.teachers t where t.full_name = v.full_name);
