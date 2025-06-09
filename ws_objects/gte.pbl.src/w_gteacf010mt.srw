$PBExportHeader$w_gteacf010mt.srw
forward
global type w_gteacf010mt from window
end type
type cb_6 from commandbutton within w_gteacf010mt
end type
type em_3 from editmask within w_gteacf010mt
end type
type st_2 from statictext within w_gteacf010mt
end type
type dw_1 from datawindow within w_gteacf010mt
end type
type ddlb_1 from dropdownlistbox within w_gteacf010mt
end type
type cb_2 from commandbutton within w_gteacf010mt
end type
type cb_1 from commandbutton within w_gteacf010mt
end type
type st_1 from statictext within w_gteacf010mt
end type
end forward

global type w_gteacf010mt from window
integer width = 4590
integer height = 2588
boolean titlebar = true
string title = "(w_gteacf010) Process-Wages to Account"
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
dw_1 dw_1
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
st_1 st_1
end type
global w_gteacf010mt w_gteacf010mt

type variables
long ll_ctr
string ls_temp,ls_lwwid,ls_chklwf,ls_ac_dt,ls_frdt,ls_todt,ls_dt
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

on w_gteacf010mt.create
this.cb_6=create cb_6
this.em_3=create em_3
this.st_2=create st_2
this.dw_1=create dw_1
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.Control[]={this.cb_6,&
this.em_3,&
this.st_2,&
this.dw_1,&
this.ddlb_1,&
this.cb_2,&
this.cb_1,&
this.st_1}
end on

on w_gteacf010mt.destroy
destroy(this.cb_6)
destroy(this.em_3)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
end on

event open;//string ls_dt
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if

declare c1 cursor for
select to_char(lww_startdate,'dd/mm/yyyy')||' - '|| to_char(LWW_ENDDATE,'dd/mm/yyyy')||' ('||a.LWW_ID||')' ,lww_startdate
 from fb_labourwagesweek a,(select distinct LWW_ID from fb_labourweeklywages where labour_vou_no is null) b 
where a.LWW_ID=b.LWW_ID and lww_paidflag='0' and 
          ((to_char(lww_startdate,'mm')<>to_char(LWW_ENDDATE,'mm') and LWW_PARTWEEK_VOU_NO is not null) or
	      (to_char(lww_startdate,'mm')=to_char(LWW_ENDDATE,'mm')))
order by  lww_startdate desc;

open c1;

if sqlca.sqlcode = -1 then 
	messagebox('SQL Error During Opening Cursor',sqlca.sqlerrtext);
	return 1;
else
	setnull(ls_lwwid);
	fetch c1 into :ls_lwwid:ls_dt;	
	do while sqlca.sqlcode <> 100 
	
		ddlb_1.additem(ls_lwwid);
	
		setnull(ls_lwwid);
		fetch c1 into :ls_lwwid,:ls_dt;	
	loop
	close c1;
end if;
end event

type cb_6 from commandbutton within w_gteacf010mt
integer x = 3593
integer y = 4
integer width = 343
integer height = 104
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
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
		if luo_fames.wf_wages_to_account_mt(ls_lwwid,ls_frdt,ls_todt,ls_ac_dt) = -1 then 
			rollback using sqlca;
			return 1;
		end if;
	end if

commit using sqlca;
dw_1.reset()
ddlb_1.reset( )
SetPointer(Arrow!);
DESTROY n_fames
messagebox('Information;',' JV Created Successfully')
cb_6.enabled = false

///reset dropdown

declare c1 cursor for
select to_char(lww_startdate,'dd/mm/yyyy')||' - '|| to_char(LWW_ENDDATE,'dd/mm/yyyy')||' ('||a.LWW_ID||')' ,lww_startdate
 from fb_labourwagesweek a,(select distinct LWW_ID from fb_labourweeklywages where labour_vou_no is null) b 
where a.LWW_ID=b.LWW_ID and lww_paidflag='0' and 
          ((to_char(lww_startdate,'mm')<>to_char(LWW_ENDDATE,'mm') and LWW_PARTWEEK_VOU_NO is not null) or
	      (to_char(lww_startdate,'mm')=to_char(LWW_ENDDATE,'mm')))
order by  lww_startdate desc;

open c1;

if sqlca.sqlcode = -1 then 
	messagebox('SQL Error During Opening Cursor',sqlca.sqlerrtext);
	return 1;
else
	setnull(ls_lwwid);
	fetch c1 into :ls_lwwid:ls_dt;	
	do while sqlca.sqlcode <> 100 
	
		ddlb_1.additem(ls_lwwid);
	
		setnull(ls_lwwid);
		fetch c1 into :ls_lwwid,:ls_dt;	
	loop
	close c1;
end if;
end event

type em_3 from editmask within w_gteacf010mt
integer x = 3145
integer y = 16
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

event modified;if isdate(em_3.text) = false then 
	messagebox('Error At Process date','Please Enter Account Process date...!')
	cb_6.enabled = false	
	return 1
else
	ls_temp=em_3.text
	cb_6.enabled = true
end if;	
end event

type st_2 from statictext within w_gteacf010mt
integer x = 2633
integer y = 36
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

type dw_1 from datawindow within w_gteacf010mt
integer x = 32
integer y = 128
integer width = 4489
integer height = 2416
integer taborder = 50
string title = "none"
string dataobject = "dw_gteacf010mt"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_1 from dropdownlistbox within w_gteacf010mt
integer x = 480
integer y = 12
integer width = 1403
integer height = 368
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_gteacf010mt
integer x = 2235
integer y = 4
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

type cb_1 from commandbutton within w_gteacf010mt
integer x = 1915
integer y = 4
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


if isnull(ls_lwwid) then 
	messagebox('Error At Date','Wages Start Date Should Be Entered, Please Check !!!')
	return 1
end if;

//messagebox('a',ls_lwwid+'-'+ls_frdt+'-'+ls_todt)
dw_1.settransobject(sqlca)
dw_1.Retrieve(ls_lwwid,ls_frdt,ls_todt)

SetPointer(Arrow!);
end event

type st_1 from statictext within w_gteacf010mt
integer x = 5
integer y = 28
integer width = 475
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

