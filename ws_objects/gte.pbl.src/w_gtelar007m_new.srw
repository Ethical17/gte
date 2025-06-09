$PBExportHeader$w_gtelar007m_new.srw
forward
global type w_gtelar007m_new from window
end type
type cbx_6 from checkbox within w_gtelar007m_new
end type
type cbx_5 from checkbox within w_gtelar007m_new
end type
type cbx_4 from checkbox within w_gtelar007m_new
end type
type cbx_3 from checkbox within w_gtelar007m_new
end type
type cbx_2 from checkbox within w_gtelar007m_new
end type
type cbx_1 from checkbox within w_gtelar007m_new
end type
type rb_1 from radiobutton within w_gtelar007m_new
end type
type st_1 from statictext within w_gtelar007m_new
end type
type cb_1 from commandbutton within w_gtelar007m_new
end type
type cb_2 from commandbutton within w_gtelar007m_new
end type
type st_2 from statictext within w_gtelar007m_new
end type
type ddlb_1 from dropdownlistbox within w_gtelar007m_new
end type
type ddlb_2 from dropdownlistbox within w_gtelar007m_new
end type
type dw_1 from datawindow within w_gtelar007m_new
end type
type dw_2 from datawindow within w_gtelar007m_new
end type
end forward

global type w_gtelar007m_new from window
boolean visible = false
integer width = 5509
integer height = 2292
boolean titlebar = true
string title = "(Gtelar007n) - Wages Summary"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cbx_6 cbx_6
cbx_5 cbx_5
cbx_4 cbx_4
cbx_3 cbx_3
cbx_2 cbx_2
cbx_1 cbx_1
rb_1 rb_1
st_1 st_1
cb_1 cb_1
cb_2 cb_2
st_2 st_2
ddlb_1 ddlb_1
ddlb_2 ddlb_2
dw_1 dw_1
dw_2 dw_2
end type
global w_gtelar007m_new w_gtelar007m_new

type variables
long ll_pbno,ll_user_level
string ls_temp, ls_dt,ls_2000,ls_500,ls_100,ls_50,ls_20,ls_10
datetime ld_dt
n_cst_powerfilter iu_powerfilter
end variables

event ue_option();if dw_1.visible = true then
	choose case gs_ueoption
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
		case "SFILTER"
				iu_powerfilter.checked = NOT iu_powerfilter.checked
				iu_powerfilter.event ue_clicked()
				m_main.m_file.m_filter.checked = iu_powerfilter.checked			
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
elseif dw_2.visible = true then
	choose case gs_ueoption
		case "PRINT"
				OpenWithParm(w_print,this.dw_2)
		case "PRINTPREVIEW"
				this.dw_2.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_2.modify("datawindow.print.preview = no")
		case "ZOOM"
				SetPointer (HourGlass!)											
				OpenwithParm (w_zoom,dw_2)
				SetPointer (Arrow!)						
		case "SAVEAS"
				this.dw_2.saveas()
		case "SFILTER"
				iu_powerfilter.checked = NOT iu_powerfilter.checked
				iu_powerfilter.event ue_clicked()
				m_main.m_file.m_filter.checked = iu_powerfilter.checked			
		case "FILTER"
				setnull(gs_filtertext)
				this.dw_2.setredraw(false)
				this.dw_2.setfilter(gs_filtertext)
				this.dw_2.filter()
				this.dw_2.groupcalc()
				if this.dw_2.rowcount() > 0 then;
					this.dw_2.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
		case "SORT"
				setnull(gs_sorttext)
				this.dw_2.setredraw(false)
				this.dw_2.setsort(gs_sorttext)
				this.dw_2.sort()
				this.dw_2.groupcalc()
				if this.dw_2.rowcount() > 0 then;
					this.dw_2.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
	end choose
end if
end event

on w_gtelar007m_new.create
this.cbx_6=create cbx_6
this.cbx_5=create cbx_5
this.cbx_4=create cbx_4
this.cbx_3=create cbx_3
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.rb_1=create rb_1
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.ddlb_2=create ddlb_2
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.cbx_6,&
this.cbx_5,&
this.cbx_4,&
this.cbx_3,&
this.cbx_2,&
this.cbx_1,&
this.rb_1,&
this.st_1,&
this.cb_1,&
this.cb_2,&
this.st_2,&
this.ddlb_1,&
this.ddlb_2,&
this.dw_1,&
this.dw_2}
end on

on w_gtelar007m_new.destroy
destroy(this.cbx_6)
destroy(this.cbx_5)
destroy(this.cbx_4)
destroy(this.cbx_3)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.rb_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.ddlb_2)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_2.modify("t_co.text = '"+gs_co_name+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_1.visible = true
dw_2.visible = false

//em_1.text = '01'+right(string(today(),'dd/mm/yyyy'),8)
setpointer(hourglass!)
declare c1 cursor for
select distinct to_char(LWW_STARTDATE,'dd/mm/yyyy')||'-'||to_char(LWW_ENDDATE,'dd/mm/yyyy'),LWW_STARTDATE
  from FB_LABOURWEEKLYWAGES a, fb_LABOURWAGESWEEK b
  where a.LWW_ID=b.LWW_ID
order by LWW_STARTDATE desc;

open c1;

IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_dt,:ld_dt;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_dt)
		fetch c1 into:ls_dt,:ld_dt;
	loop
	close c1;
end if

ddlb_2.additem('ALL')

declare c2 cursor for
select distinct LS_ID from FB_LABOURWEEKLYWAGES a,FB_LABOURWAGESWEEK b where a.LWW_ID = b.LWW_ID order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ll_pbno))
		fetch c2 into:ll_pbno;
	loop
	close c2;
end if

ddlb_2.text = 'ALL'


select pfa_permission into :ll_user_level from fb_pf_access where pfa_user_id=:gs_user and nvl(pfa_active,'N')='Y';
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Access',sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning : NO access Provided',sqlca.sqlerrtext)
	return 1
end if	

setpointer(Arrow!)
end event

type cbx_6 from checkbox within w_gtelar007m_new
integer x = 4425
integer y = 28
integer width = 201
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "10"
boolean checked = true
end type

type cbx_5 from checkbox within w_gtelar007m_new
integer x = 4261
integer y = 28
integer width = 201
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "20"
boolean checked = true
end type

type cbx_4 from checkbox within w_gtelar007m_new
integer x = 4082
integer y = 28
integer width = 201
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "50"
boolean checked = true
end type

type cbx_3 from checkbox within w_gtelar007m_new
integer x = 3886
integer y = 28
integer width = 233
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "100"
boolean checked = true
end type

type cbx_2 from checkbox within w_gtelar007m_new
integer x = 3685
integer y = 28
integer width = 233
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "500"
boolean checked = true
end type

type cbx_1 from checkbox within w_gtelar007m_new
integer x = 3451
integer y = 28
integer width = 256
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "2000"
boolean checked = true
end type

type rb_1 from radiobutton within w_gtelar007m_new
integer x = 14
integer y = 28
integer width = 439
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Paybook Wise"
end type

event clicked;if rb_1.checked then
	dw_1.visible = false
	dw_2.visible = true
else
	dw_1.visible = true
	dw_2.visible = false
end if	
end event

type st_1 from statictext within w_gtelar007m_new
integer x = 480
integer y = 36
integer width = 475
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Start && End Date : "
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtelar007m_new
integer x = 2839
integer y = 20
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
boolean default = true
end type

event clicked;//dw_1.settransobject(sqlca)

setpointer(hourglass!)

if isnull(ddlb_1.text)  then
	messagebox('Warning','Please Enter Week Start Date !!!')
	return 
end if

string ls_fr_dt

ls_fr_dt = left(ddlb_1.text,10)

if cbx_1.checked then
	ls_2000 = 'Y'
else
	ls_2000 = 'N'
end if

if cbx_2.checked then
	ls_500 = 'Y'
else
	ls_500 = 'N'
end if

if cbx_3.checked then
	ls_100 = 'Y'
else
	ls_100 = 'N'
end if

if cbx_4.checked then
	ls_50 = 'Y'
else
	ls_50 = 'N'
end if

if cbx_5.checked then
	ls_20 = 'Y'
else
	ls_20 = 'N'
end if

if cbx_6.checked then
	ls_10 = 'Y'
else
	ls_10 = 'N'
end if

select distinct AI_PFELIGIBLE into :ls_temp
from fb_attendanceincentive where  to_date(:ls_fr_dt,'dd/mm/yyyy') between trunc(AI_FROMDT) and nvl(AI_TODT,trunc(sysdate));

if ll_user_level<>0 then
	if rb_1.checked then
		dw_2.settransobject(sqlca)
		dw_2.retrieve(left(ddlb_1.text,10),ddlb_2.text,ls_temp,gs_garden_snm,gs_garden_state,ls_2000,ls_500,ls_100,ls_50,ls_20,ls_10,ll_user_level)
		if dw_2.rowcount() = 0 then
			messagebox('Information!','No data Found !!!')
			return 1
		end if
	else
		dw_1.settransobject(sqlca)
		dw_1.retrieve(left(ddlb_1.text,10),ddlb_2.text,ls_temp,gs_garden_snm,gs_garden_state,ls_2000,ls_500,ls_100,ls_50,ls_20,ls_10,ll_user_level)
		if dw_1.rowcount() = 0 then
			messagebox('Information!','No data Found !!!')
			return 1
		end if
	end if
else
	messagebox('Information!','No Access !!!')
end if
setpointer(Arrow!)
end event

type cb_2 from commandbutton within w_gtelar007m_new
integer x = 3104
integer y = 20
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -10
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

type st_2 from statictext within w_gtelar007m_new
integer x = 2153
integer y = 36
integer width = 347
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pay Book No."
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtelar007m_new
integer x = 955
integer y = 24
integer width = 1152
integer height = 608
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
end type

event selectionchanged;ls_dt = left(ddlb_1.text,10)
ddlb_2.reset()
ddlb_2.additem('ALL')

declare c2 cursor for
select distinct LS_ID from FB_LABOURWEEKLYWAGES a,FB_LABOURWAGESWEEK b 
where a.LWW_ID = b.LWW_ID and trunc(b.LWW_STARTDATE) = to_date(:ls_dt,'dd/mm/yyyy') order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ll_pbno))
		fetch c2 into:ll_pbno;
	loop
	close c2;
end if

ddlb_2.text = 'ALL'
end event

type ddlb_2 from dropdownlistbox within w_gtelar007m_new
integer x = 2501
integer y = 24
integer width = 325
integer height = 608
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
end type

type dw_1 from datawindow within w_gtelar007m_new
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 5445
integer height = 2056
string dataobject = "dw_gtelar007_mr_new"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

type dw_2 from datawindow within w_gtelar007m_new
event ue_leftbuttonup pbm_dwnlbuttonup
boolean visible = false
integer y = 124
integer width = 5440
integer height = 2056
integer taborder = 30
string dataobject = "dw_gtelar007bmr_new"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

