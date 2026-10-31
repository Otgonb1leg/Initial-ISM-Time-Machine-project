import { Link, NavLink } from 'react-router-dom'
import { ArrowUpRight, Menu, X } from 'lucide-react'
import { useState } from 'react'

const nav = [{ to: '/', label: 'Нүүр' }, { to: '/faculty', label: 'Багш нар' }, { to: '/timeline', label: 'Тэнхимийн түүх' }, { to: '/admin', label: 'Удирдлага' }]
export default function Layout({ children }) {
  const [open, setOpen] = useState(false)
  return <div className="min-h-screen bg-paper text-ink">
    <header className="sticky top-0 z-40 border-b border-line/90 bg-paper/95 backdrop-blur">
      <div className="container-shell flex h-[76px] items-center justify-between">
        <Link to="/" className="flex items-center gap-3" onClick={() => setOpen(false)}>
          <span className="grid h-10 w-10 place-items-center bg-ink font-display text-lg text-white">I</span>
          <span><span className="block text-sm font-bold tracking-[.18em]">ISM</span><span className="block text-[10px] uppercase tracking-[.19em] text-muted">Time Machine</span></span>
        </Link>
        <nav className="hidden items-center gap-8 md:flex">{nav.map(n => <NavLink key={n.to} to={n.to} className={({isActive}) => `nav-link ${isActive ? 'nav-link-active' : ''}`}>{n.label}</NavLink>)}</nav>
        <Link to="/faculty" className="hidden items-center gap-2 text-xs font-semibold uppercase tracking-wider md:flex">Explore archive <ArrowUpRight size={15}/></Link>
        <button className="md:hidden" onClick={() => setOpen(!open)} aria-label="Цэс нээх">{open ? <X/> : <Menu/>}</button>
      </div>
      {open && <nav className="container-shell flex flex-col gap-4 pb-5 md:hidden">{nav.map(n => <NavLink key={n.to} onClick={() => setOpen(false)} to={n.to} className="text-sm">{n.label}</NavLink>)}</nav>}
    </header>
    <main>{children}</main>
    <footer className="mt-24 border-t border-line"><div className="container-shell flex flex-col justify-between gap-5 py-9 text-xs text-muted sm:flex-row"><div><div className="font-bold tracking-[.16em] text-ink">ISM TIME MACHINE</div><p className="mt-2">Мэдээллийн Системийн Менежментийн тэнхим</p></div><p>People. Knowledge. History. · Academic Digital Archive</p></div></footer>
  </div>
}
