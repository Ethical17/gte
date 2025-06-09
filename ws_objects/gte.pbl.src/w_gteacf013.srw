$PBExportHeader$w_gteacf013.srw
forward
global type w_gteacf013 from window
end type
type cb_6 from commandbutton within w_gteacf013
end type
type em_3 from editmask within w_gteacf013
end type
type st_2 from statictext within w_gteacf013
end type
type ddlb_1 from dropdownlistbox within w_gteacf013
end type
type cb_2 from commandbutton within w_gteacf013
end type
type cb_1 from commandbutton within w_gteacf013
end type
type st_1 from statictext within w_gteacf013
end type
type dw_1 from datawindow within w_gteacf013
end type
end forward

global type w_gteacf013 from window
integer width = 4599
integer height = 2984
boolean titlebar = true
string title = "(w_gteacf013) Process-Salary to Account"
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
global w_gteacf013 w_gteacf013

type variables
long ll_ctr
string ls_temp,ls_frmm,ls_chklwf,ls_ac_dt,ls_frdt,ls_todt
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

on w_gteacf013.create
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

on w_gteacf013.destroy
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
select distinct ((eps_year * 100) + eps_month) from fb_emppaymentstatus where nvl(EPS_PAYCALFLAG,'0')='1' and nvl(EPS_PAIDFLAG,'0')='0'
order by  1 desc ;

open c1;

if sqlca.sqlcode = -1 then 
	messagebox('Error At Cursor','Error During Opening Cursor');
	return 1;
else
	setnull(ls_frmm);
	fetch c1 into :ls_frmm;	
	do while sqlca.sqlcode <> 100 
	
		ddlb_1.additem(ls_frmm);
	
		setnull(ls_frmm);
		fetch c1 into :ls_frmm;	
	loop
	close c1;
end if;
end event

type cb_6 from commandbutton within w_gteacf013
integer x = 2679
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
 setpointer(hourglass!)
 if isdate(em_3.text) = false then
	messagebox('Error :','Please Enter Valid Account Process date')
	rollback using sqlca;
	return 1;
else
	ls_ac_dt=em_3.text
end if;	

if f_check_mep(ls_ac_dt) = -1 then return 1

ls_frmm=ddlb_1.text

//if f_check_fin_yr(datetime(ls_ac_dt)) = -1 then;	return 1;end if;
	if isnull(ls_ac_dt) =  false then		
		if luo_fames.wf_salary_to_account(ls_frmm,date(ls_ac_dt)) = -1 then 
			rollback using sqlca;
			return 1;
		end if;
	end if

commit using sqlca;
dw_1.reset()
ddlb_1.reset()
DESTROY n_fames
messagebox('Information;',' JV Created Successfully')
cb_6.enabled = false
 setpointer(arrow!)
 
 ///reset dropdown
 declare c1 cursor for
select distinct ((eps_year * 100) + eps_month) from fb_emppaymentstatus where nvl(EPS_PAYCALFLAG,'0')='1'
order by  1 desc ;

open c1;

if sqlca.sqlcode = -1 then 
	messagebox('Error At Cursor','Error During Opening Cursor');
	return 1;
else
	setnull(ls_frmm);
	fetch c1 into :ls_frmm;	
	do while sqlca.sqlcode <> 100 
	
		ddlb_1.additem(ls_frmm);
	
		setnull(ls_frmm);
		fetch c1 into :ls_frmm;	
	loop
	close c1;
end if;
end event

type em_3 from editmask within w_gteacf013
integer x = 2231
integer y = 8
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

type st_2 from statictext within w_gteacf013
integer x = 1719
integer y = 28
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

type ddlb_1 from dropdownlistbox within w_gteacf013
integer x = 535
integer y = 12
integer width = 608
integer height = 368
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

type cb_2 from commandbutton within w_gteacf013
integer x = 1422
integer y = 8
integer width = 265
integer height = 100
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

type cb_1 from commandbutton within w_gteacf013
integer x = 1157
integer y = 8
integer width = 265
integer height = 100
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

ls_frmm=ddlb_1.text

if isnull(ls_frmm) then 
	messagebox('Error At Date','Wages Start Date Should Be Entered, Please Check !!!')
	return 1
end if;

//messagebox('a',ls_lwwid+'-'+ls_frdt+'-'+ls_todt)
dw_1.settransobject(sqlca)
dw_1.Retrieve(ls_frmm)

SetPointer(Arrow!);
end event

type st_1 from statictext within w_gteacf013
integer x = 14
integer y = 28
integer width = 517
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Salary Year-Month :"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gteacf013
integer x = 27
integer y = 112
integer width = 4521
integer height = 2748
integer taborder = 50
string title = "none"
string dataobject = "dw_gteacf013"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

