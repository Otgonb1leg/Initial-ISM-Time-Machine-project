# ISM Time Machine

ISM тэнхимийн багш нарын академик профайл, сургалт, судалгаа болон түүхэн үйл явдлыг харуулах React веб аппликейшний эхний хувилбар.

## Шаардлага
- Node.js 18+
- Supabase project (өгөгдлийн сантай холбох үед)

## Локал орчинд ажиллуулах

```bash
npm install
npm run dev
```

Vite terminal дээр гарсан localhost холбоосыг browser-оор нээнэ.

## Supabase холболт
1. Supabase дээр шинэ project үүсгэнэ.
2. Project Settings → API хэсгээс Project URL болон anon/public key авна.
3. Root хавтас дахь `.env.example` файлыг `.env` болгон хуулна.
4. `VITE_SUPABASE_URL` болон `VITE_SUPABASE_ANON_KEY` утгуудыг бөглөнө.
5. Supabase SQL Editor дээр `supabase/schema.sql` файлын SQL-ийг бүхэлд нь ажиллуулна.
6. Authentication → Users хэсгээс админ хэрэглэгч үүсгэнэ.
7. SQL Editor дээр schema.sql-ийн төгсгөлд байгаа admin role grant query-г өөрийн email-ээр тохируулж ажиллуулна.
8. Development server-ээ дахин асаана.

## Одоогийн боломжууд
- Нүүр хуудас, статистик үзүүлэлт
- Багш нарын жагсаалт, нэр/хичээл/судалгаагаар хайлт
- Хичээлээр шүүх
- Багшийн дэлгэрэнгүй профайл
- Тэнхимийн түүхийн timeline
- Supabase Auth-д суурилсан админ нэвтрэлт
- Багш нэмэх, засах, устгах CRUD
- Supabase PostgreSQL schema болон RLS policy
- Faculty portrait storage bucket policy
- Responsive editorial дизайн

## Анхаарах зүйл
- Одоогийн багшийн нэр, зураг, түүхэн он жилүүд нь зөвхөн placeholder/demo өгөгдөл. Бодит мэдээлэл биш.
- Бодит багшийн нэр, зураг, намтар, имэйл, бүтээлийг зөвшөөрөлтэй бөгөөд баталгаатай эх сурвалжаас авч оруулна.
- Frontend-д зөвхөн Supabase anon key ашиглана. `service_role` key-г хэзээ ч frontend эсвэл `.env`-ийн `VITE_` хувьсагчид бүү оруул.
- RLS идэвхтэй байна. Admin эрх өгөөгүй хэрэглэгч өгөгдөл нэмэх, засах, устгах боломжгүй.

## Дараагийн хөгжүүлэлтийн ажил
1. Education, experience, publications хүснэгтийн CRUD UI-г профайлд холбох.
2. Timeline event CRUD болон зураг upload UI нэмэх.
3. Supabase Storage upload form нэмэх.
4. Admin role bootstrap-ийг шалгаж, админ үүсгэх зааврыг дагах.
5. Алдаа/ачаалж буй/хоосон төлөвийн UI болон validation нэмэх.
6. Browser, mobile responsive тест хийж Vercel-д байрлуулах.

## ISM багш нарын эхний бүрэлдэхүүн
- `src/data.js` файлд хэрэглэгчийн илгээсэн UFE department page screenshot-аас нэр, албан тушаал, дарааллыг оруулсан 10 профайл бий.
- Зургууд `public/images/teachers/` хавтаст хадгалагдсан.
- Баталгаажаагүй намтар, боловсрол, хичээл, судалгааны мэдээллийг зориудаар хоосон үлдээсэн. Д.Хулан багшийн нэмэлт мэдээлэл өмнө шалгасан UFE профайлаас оруулсан.
- Supabase ашиглах бол эхлээд `supabase/schema.sql`, дараа нь `supabase/seed-teachers.sql` файлыг SQL Editor дээр ажиллуул.
- `seed-teachers.sql` нь ижил бүтэн нэртэй багш аль хэдийн байвал давхар бүртгэхгүй.
