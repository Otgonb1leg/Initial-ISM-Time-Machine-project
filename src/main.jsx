import React, { useCallback, useEffect, useState } from 'react'
import { createRoot } from 'react-dom/client'
import { BrowserRouter, Route, Routes } from 'react-router-dom'
import Layout from './components/Layout'
import Home from './pages/Home'
import Faculty from './pages/Faculty'
import TeacherDetail from './pages/TeacherDetail'
import Timeline from './pages/Timeline'
import Admin from './pages/Admin'
import { demoTeachers, demoTimeline } from './data'
import { isSupabaseConfigured, supabase } from './lib/supabase'
import './style.css'

function App(){
 const [teachers,setTeachers]=useState(demoTeachers); const [timeline,setTimeline]=useState(demoTimeline)
 const reloadTeachers=useCallback(async()=>{if(!isSupabaseConfigured)return;const {data,error}=await supabase.from('teachers').select('*').order('sort_order').order('full_name');if(!error&&data)setTeachers(data)},[])
 useEffect(()=>{reloadTeachers();if(isSupabaseConfigured)supabase.from('timeline_events').select('*').order('event_year').then(({data,error})=>{if(!error&&data?.length)setTimeline(data.map(x=>({...x,year:x.event_year})))})},[reloadTeachers])
 return <BrowserRouter><Layout><Routes><Route path="/" element={<Home teachers={teachers} timeline={timeline}/>}/><Route path="/faculty" element={<Faculty teachers={teachers}/>}/><Route path="/faculty/:id" element={<TeacherDetail teachers={teachers}/>}/><Route path="/timeline" element={<Timeline timeline={timeline}/>}/><Route path="/admin" element={<Admin teachers={teachers} reloadTeachers={reloadTeachers}/>}/><Route path="*" element={<div className="container-shell py-24"><h1 className="page-title">404 — Хуудас олдсонгүй</h1></div>}/></Routes></Layout></BrowserRouter>
}

createRoot(document.getElementById('root')).render(<React.StrictMode><App/></React.StrictMode>)
