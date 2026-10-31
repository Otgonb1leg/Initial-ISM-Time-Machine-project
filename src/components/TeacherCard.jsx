import { Link } from 'react-router-dom'
import { ArrowUpRight, BookOpen } from 'lucide-react'
export default function TeacherCard({ teacher }) {
  return <Link to={`/faculty/${teacher.id}`} className="group block border-b border-line pb-6">
    <div className="aspect-[4/4.5] overflow-hidden bg-[#e6e4dc]">
      {teacher.photo_url ? <img src={teacher.photo_url} alt={teacher.full_name} className="h-full w-full object-cover transition duration-500 group-hover:scale-[1.04]"/> : <div className="flex h-full flex-col items-center justify-center text-[#8a8d88]"><span className="font-display text-6xl">{teacher.full_name?.charAt(0) || 'Б'}</span><span className="mt-2 text-[10px] uppercase tracking-[.2em]">Faculty portrait</span></div>}
    </div>
    <div className="flex items-start justify-between gap-3 pt-4"><div><p className="text-[10px] uppercase tracking-[.17em] text-muted">{teacher.position || 'Багш'}</p><h3 className="mt-1 font-display text-xl leading-snug group-hover:underline">{teacher.full_name}</h3>{teacher.degree && <p className="mt-1 text-xs text-muted">{teacher.degree}</p>}</div><ArrowUpRight size={18} className="mt-1 shrink-0 transition group-hover:-translate-y-1 group-hover:translate-x-1"/></div>
    <div className="mt-4 flex items-center gap-2 text-xs text-muted"><BookOpen size={14}/>{teacher.courses?.length ? `${teacher.courses.length} хичээл` : 'Профайл үзэх'}</div>
  </Link>
}
