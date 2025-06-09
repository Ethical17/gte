$PBExportHeader$w_gteacf011.srw
forward
global type w_gteacf011 from window
end type
type cb_6 from commandbutton within w_gteacf011
end type
type em_3 from editmask within w_gteacf011
end type
type st_2 from statictext within w_gteacf011
end type
type ddlb_1 from dropdownlistbox within w_gteacf011
end type
type cb_2 from commandbutton within w_gteacf011
end type
type cb_1 from commandbutton within w_gteacf011
end type
type st_1 from statictext within w_gteacf011
end type
type dw_1 from datawindow within w_gteacf011
end type
end forward

global type w_gteacf011 from window
integer width = 3995
integer height = 3032
boolean titlebar = true
string title = "(w_gteacf011) Process-Part week Wages"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
event ue_option ( )
cb_6 cb_6
em_3 em_3
st_2 st_2
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
st_1 st_1
dw_1 dw_1
end type
global w_gteacf011 w_gteacf011

type variables
long ll_ctr
string ls_temp,ls_lwwid,ls_chklwf,ls_ac_dt,ls_frdt,ls_todt
double ld_lwf, ld_subs
end variables

event ue_option();	choose case gs_ueoption
		case "PRINT"
				OpenWithParm(w_print,this.dw_1)
		case "PRINTPREVIEW"
				this.dw_1.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_1.modify("datawindow.print.preview = no")
		case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_1)
			SetPointer (Arrow!)						
		case "SAVEAS"
				this.dw_1.saveas()
		case "FILTER"
				setnull(gs_filtertext)
				this.dw_1.setredraw(false)
				this.dw_1.setfilter(gs_filtertext)
				this.dw_1.filter()
				this.dw_1.groupcalc()
				if this.dw_1.rowcount() > 0 then;
					this.dw_1.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
		case "SORT"
				setnull(gs_sorttext)
				this.dw_1.setredraw(false)
				this.dw_1.setsort(gs_sorttext)
				this.dw_1.sort()
				this.dw_1.groupcalc()
				if this.dw_1.rowcount() > 0 then;
					this.dw_1.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
	end choose

end event

on w_gteacf011.create
this.cb_6=create cb_6
this.em_3=create em_3
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.cb_6,&
this.em_3,&
this.st_2,&
this.ddlb_1,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.dw_1}
end on

on w_gteacf011.destroy
destroy(this.cb_6)
destroy(this.em_3)
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dw_1)
end on

event open;if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if

declare c1 cursor for
 select to_char(lww_startdate,'dd/mm/yyyy')||' - '|| to_char(LWW_ENDDATE,'dd/mm/yyyy')||' ('||a.LWW_ID||')' 
 from fb_labourwagesweek a
where lww_paidflag='0' and to_char(lww_startdate,'mm')<>to_char(LWW_ENDDATE,'mm') and LWW_PARTWEEK_VOU_NO is null
order by  lww_startdate desc;

open c1;

if sqlca.sqlcode = -1 then 
	messagebox('Error At Cursor','Error During Opening Cursor');
	return 1;
else
	setnull(ls_lwwid);
	fetch c1 into :ls_lwwid;	
	do while sqlca.sqlcode <> 100 
	
		ddlb_1.additem(ls_lwwid);
	
		setnull(ls_lwwid);
		fetch c1 into :ls_lwwid;	
	loop
	close c1;
end if;
end event

type cb_6 from commandbutton within w_gteacf011
integer x = 3415
integer y = 8
integer width = 343
integer height = 104
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "A/C Process"
end type

event clicked; n_fames luo_fames
 luo_fames = Create n_fames
 
 if isdate(em_3.text) = false then
	messagebox('Error :','Please Enter Valid Account Process date')
	rollback using sqlca;
	return 1;
else
	ls_ac_dt=em_3.text
end if;	

if f_check_mep(ls_ac_dt) = -1 then return 1

SetPointer(HourGlass!);

ls_lwwid = left(right(ddlb_1.text,14),13)
ls_frdt = left(ddlb_1.text,10)
ls_todt = right(left(ddlb_1.text,23),10)

//if f_check_fin_yr(datetime(ls_ac_dt)) = -1 then;	return 1;end if;
	if isnull(ls_ac_dt) =  false then		
		if luo_fames.wf_partweek_wages_to_account(ls_lwwid,ls_frdt,ls_todt,ls_ac_dt) = -1 then 
			rollback using sqlca;
			return 1;
		end if;
	end if

commit using sqlca;
dw_1.reset()
ddlb_1.reset()
SetPointer(Arrow!);

DESTROY n_fames
messagebox('Information;',' JV Created Successfully')
cb_6.enabled = false

///reset drop down

declare c1 cursor for
 select to_char(lww_startdate,'dd/mm/yyyy')||' - '|| to_char(LWW_ENDDATE,'dd/mm/yyyy')||' ('||a.LWW_ID||')' 
 from fb_labourwagesweek a
where lww_paidflag='0' and to_char(lww_startdate,'mm')<>to_char(LWW_ENDDATE,'mm') and LWW_PARTWEEK_VOU_NO is null
order by  lww_startdate desc;

open c1;

if sqlca.sqlcode = -1 then 
	messagebox('Error At Cursor','Error During Opening Cursor');
	return 1;
else
	setnull(ls_lwwid);
	fetch c1 into :ls_lwwid;	
	do while sqlca.sqlcode <> 100 
	
		ddlb_1.additem(ls_lwwid);
	
		setnull(ls_lwwid);
		fetch c1 into :ls_lwwid;	
	loop
	close c1;
end if;
end event

type em_3 from editmask within w_gteacf011
integer x = 2967
integer y = 12
integer width = 411
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type st_2 from statictext within w_gteacf011
integer x = 2455
integer y = 32
integer width = 498
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = " A/C Process Date :"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gteacf011
integer x = 517
integer y = 16
integer width = 1285
integer height = 820
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_gteacf011
integer x = 2135
integer y = 8
integer width = 311
integer height = 112
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_gteacf011
integer x = 1815
integer y = 8
integer width = 320
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
boolean default = true
end type

event clicked;SetPointer(HourGlass!);
 n_wagept luo_wagept
 luo_wagept = Create n_wagept


ls_lwwid = left(right(ddlb_1.text,14),13)
ls_frdt = left(ddlb_1.text,10)
ls_todt = right(left(ddlb_1.text,23),10)


if isnull(ls_frdt) then 
	messagebox('Error At Date','Wages Start Date Should Be Entered, Please Check !!!')
	return 1
end if;
 
select distinct 'x' into :ls_temp from 
(select Emp_name, LABOUR_ID,  attn_pd.LWW_ID actualweekid ,to_char(LWW_STARTDATE,'dd/mm/yyyy') Startdate,to_char(LWW_ENDDATE,'dd/mm/yyyy') enddate,to_char(LDA_DATE,'dd/mm/yyyy') attendancedate, attn.LWW_ID weekid
 from (select LDA_DATE, LABOUR_ID, KAMSUB_ID,LWW_ID
        from fb_labourdailyattendance
       where LDA_DATE between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy'))attn,
      (select LWW_ID,LWW_STARTDATE, LWW_ENDDATE from fb_labourwagesweek
        where lww_startdate between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy') or
              LWW_ENDDATE between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy'))attn_pd, fb_employee
where LDA_DATE between LWW_STARTDATE and LWW_ENDDATE and attn.labour_id = emp_id and attn.LWW_ID <> attn_pd.LWW_ID    
union all
select Emp_name, LABOUR_ID,  attn_pd.LWW_ID actualweekid ,to_char(LWW_STARTDATE,'dd/mm/yyyy') Startdate,to_char(LWW_ENDDATE,'dd/mm/yyyy') enddate,to_char(LDA_DATE,'dd/mm/yyyy') attendancedate, attn.LWW_ID weekid
 from  (select LWW_ID,LWW_STARTDATE, LWW_ENDDATE from fb_labourwagesweek
        where lww_startdate between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy') or
              LWW_ENDDATE between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy'))attn_pd, 
              fb_employee, fb_labourdailyattendance attn
where LDA_DATE not between LWW_STARTDATE and LWW_ENDDATE and attn.labour_id = emp_id and attn.LWW_ID = attn_pd.LWW_ID);

if sqlca.sqlcode = 0 then
	messagebox('Warning!','There is descripancy in Attendance, Please Check !!!')
//	openwithparm(w_gtelar043,ls_frdt+ls_todt)
	opensheetwithparm(w_gtelar043,ls_frdt+ls_todt,w_mdi,0,layered!)
	return 1
	
elseif sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Checking Descripancy !',sqlca.sqlerrtext)
	return 1
end if;	


if isnull(ls_lwwid) then 
	messagebox('Error At Date','Wages Start Date Should Be Entered, Please Check !!!')
	return 1
end if;


dw_1.settransobject(sqlca)
dw_1.Retrieve(ls_lwwid,ls_frdt,ls_todt)
if dw_1.rowcount() > 0 then
	SELECT LAST_DAY(to_date(:ls_frdt,'DD/MM/YYYY')) into:ls_ac_dt FROM DUAL;	
	em_3.text = ls_ac_dt
end if

SetPointer(Arrow!);
end event

type st_1 from statictext within w_gteacf011
integer x = 27
integer y = 28
integer width = 480
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Wages Start Date :"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gteacf011
integer x = 27
integer y = 124
integer width = 3470
integer height = 2768
integer taborder = 50
string title = "none"
string dataobject = "dw_gteacf011"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

