$PBExportHeader$w_gtelar077.srw
forward
global type w_gtelar077 from window
end type
type st_4 from statictext within w_gtelar077
end type
type dp_1 from datepicker within w_gtelar077
end type
type ddlb_3 from dropdownlistbox within w_gtelar077
end type
type st_3 from statictext within w_gtelar077
end type
type st_2 from statictext within w_gtelar077
end type
type ddlb_1 from dropdownlistbox within w_gtelar077
end type
type st_1 from statictext within w_gtelar077
end type
type cb_1 from commandbutton within w_gtelar077
end type
type cb_2 from commandbutton within w_gtelar077
end type
type ddlb_2 from dropdownlistbox within w_gtelar077
end type
type dw_1 from datawindow within w_gtelar077
end type
end forward

global type w_gtelar077 from window
integer width = 5111
integer height = 2936
boolean titlebar = true
string title = "(Gtelar001) - Labour Master"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_4 st_4
dp_1 dp_1
ddlb_3 ddlb_3
st_3 st_3
st_2 st_2
ddlb_1 ddlb_1
st_1 st_1
cb_1 cb_1
cb_2 cb_2
ddlb_2 ddlb_2
dw_1 dw_1
end type
global w_gtelar077 w_gtelar077

type variables
long ll_pbno
string ls_active_ind
n_cst_powerfilter iu_powerfilter
end variables

event ue_option();choose case gs_ueoption
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

end event

on w_gtelar077.create
this.st_4=create st_4
this.dp_1=create dp_1
this.ddlb_3=create ddlb_3
this.st_3=create st_3
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.ddlb_2=create ddlb_2
this.dw_1=create dw_1
this.Control[]={this.st_4,&
this.dp_1,&
this.ddlb_3,&
this.st_3,&
this.st_2,&
this.ddlb_1,&
this.st_1,&
this.cb_1,&
this.cb_2,&
this.ddlb_2,&
this.dw_1}
end on

on w_gtelar077.destroy
destroy(this.st_4)
destroy(this.dp_1)
destroy(this.ddlb_3)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.ddlb_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

ddlb_2.reset()
ddlb_2.additem('ALL')
setpointer(hourglass!)
declare c2 cursor for
select distinct ls_id from FB_LABOURSHEET where ls_id is not null order by 1;

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
setpointer(arrow!)
end event

type st_4 from statictext within w_gtelar077
integer x = 50
integer y = 28
integer width = 329
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "As On Date :"
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gtelar077
integer x = 411
integer y = 24
integer width = 370
integer height = 84
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2024-01-30"), Time("08:31:23.000000"))
integer textsize = -10
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
boolean valueset = true
end type

type ddlb_3 from dropdownlistbox within w_gtelar077
integer x = 2871
integer y = 16
integer width = 453
integer height = 508
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "ALL"
boolean sorted = false
string item[] = {"ALL","Active - 1","Inactive - 0"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_type	


ls_type = left(ddlb_1.text,2)
setpointer(hourglass!)

ddlb_2.reset()
ddlb_2.additem('00')

declare c2 cursor for
select distinct b.ls_id from FB_EMPLOYEE a,FB_LABOURSHEET b 
where a.ls_id = b.ls_id and emp_type = decode(nvl(:ls_type,'AL'),'AL',emp_type,:ls_type) and b.ls_id is not null order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ll_pbno))
		fetch c2 into:ll_pbno;
	loop
	close c2;
end if

ddlb_2.text = '00'
setpointer(arrow!)
end event

type st_3 from statictext within w_gtelar077
integer x = 2647
integer y = 28
integer width = 357
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Status"
boolean focusrectangle = false
end type

type st_2 from statictext within w_gtelar077
integer x = 1957
integer y = 28
integer width = 357
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pay Book No. "
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtelar077
integer x = 1211
integer y = 16
integer width = 677
integer height = 508
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "ALL"
boolean sorted = false
string item[] = {"ALL","LP - Permanent ","LT - Temporary","LO - Outside"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_type	


ls_type = left(ddlb_1.text,2)
setpointer(hourglass!)

ddlb_2.reset()
ddlb_2.additem('00')

declare c2 cursor for
select distinct b.ls_id from FB_EMPLOYEE a,FB_LABOURSHEET b 
where a.ls_id = b.ls_id and emp_type = decode(nvl(:ls_type,'AL'),'AL',emp_type,:ls_type) and b.ls_id is not null order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ll_pbno))
		fetch c2 into:ll_pbno;
	loop
	close c2;
end if

ddlb_2.text = '00'
setpointer(arrow!)
end event

type st_1 from statictext within w_gtelar077
integer x = 800
integer y = 28
integer width = 402
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Employee Type:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtelar077
integer x = 3346
integer y = 8
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
boolean default = true
end type

event clicked;dw_1.settransobject(sqlca)

setpointer(hourglass!)

if isnull(ddlb_2.text) or len(ddlb_2.text) = 0 then
	messagebox('Warning','Please Enter Pay Book No. !!!')
	return 
end if

if ddlb_3.text = 'ALL' then
	ls_active_ind  = 'ALL'
else
	ls_active_ind = right(ddlb_3.text,1)
end if

dw_1.retrieve(long(ddlb_2.text),left(ddlb_1.text,2),ls_active_ind,dp_1.text)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if

setpointer(arrow!)

end event

type cb_2 from commandbutton within w_gtelar077
integer x = 3611
integer y = 8
integer width = 265
integer height = 100
integer taborder = 30
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

type ddlb_2 from dropdownlistbox within w_gtelar077
integer x = 2322
integer y = 16
integer width = 297
integer height = 636
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
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

type dw_1 from datawindow within w_gtelar077
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 5079
integer height = 2672
string dataobject = "dw_gtelar077"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
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

