$PBExportHeader$w_gtelar058.srw
forward
global type w_gtelar058 from window
end type
type dp_2 from datepicker within w_gtelar058
end type
type dp_1 from datepicker within w_gtelar058
end type
type ddlb_1 from dropdownlistbox within w_gtelar058
end type
type st_3 from statictext within w_gtelar058
end type
type cb_2 from commandbutton within w_gtelar058
end type
type cb_1 from commandbutton within w_gtelar058
end type
type st_2 from statictext within w_gtelar058
end type
type st_1 from statictext within w_gtelar058
end type
type dw_1 from datawindow within w_gtelar058
end type
end forward

global type w_gtelar058 from window
integer width = 4247
integer height = 2624
boolean titlebar = true
string title = "(Gtelar058) - ELP Report  "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_option ( )
dp_2 dp_2
dp_1 dp_1
ddlb_1 ddlb_1
st_3 st_3
cb_2 cb_2
cb_1 cb_1
st_2 st_2
st_1 st_1
dw_1 dw_1
end type
global w_gtelar058 w_gtelar058

type variables
string ls_frdt, ls_todt, ls_bookno
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

on w_gtelar058.create
this.dp_2=create dp_2
this.dp_1=create dp_1
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_2=create st_2
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.dp_2,&
this.dp_1,&
this.ddlb_1,&
this.st_3,&
this.cb_2,&
this.cb_1,&
this.st_2,&
this.st_1,&
this.dw_1}
end on

on w_gtelar058.destroy
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_1)
end on

event open;string ls_temp
dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")


ddlb_1.additem('ALL')

declare c1 cursor for
select distinct ls_id
 from FB_LABOURSHEET
 order by 1;
 
 open c1 ;
 
 if sqlca.sqlcode = 0 then
	fetch c1 into :ls_temp ;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem( ls_temp)
		fetch c1 into :ls_temp ;
	loop
	close c1;
end if 





		
		
end event

event key;if KeyDown(KeyEscape!) then
	cb_2.triggerevent(Clicked!)
end if 
end event

type dp_2 from datepicker within w_gtelar058
integer x = 750
integer y = 16
integer width = 366
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2018-09-17"), Time("11:09:59.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_gtelar058
integer x = 219
integer y = 12
integer width = 366
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2018-09-17"), Time("11:09:59.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type ddlb_1 from dropdownlistbox within w_gtelar058
integer x = 1591
integer y = 20
integer width = 411
integer height = 376
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_gtelar058
integer x = 1202
integer y = 36
integer width = 375
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pay Book No. - "
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gtelar058
integer x = 2382
integer y = 16
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_gtelar058
integer x = 2080
integer y = 16
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Run"
end type

event clicked;dw_1.settransobject(sqlca)

if isnull(dp_1.text) or dp_1.text = "00/00/0000" then
	messagebox("Warning","Please Enter From Date")
end if 

if isnull(dp_2.text) or dp_2.text = "00/00/0000" then
	messagebox("Warning","Please Enter To Date")
end if 


ls_frdt = dp_1.text
ls_todt = dp_2.text

setpointer(hourglass!)

dw_1.retrieve(ls_frdt,ls_todt,ls_bookno)

setpointer(arrow!)
if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Date !!!')
	return 1
end if
end event

type st_2 from statictext within w_gtelar058
integer x = 631
integer y = 32
integer width = 137
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To : "
boolean focusrectangle = false
end type

type st_1 from statictext within w_gtelar058
integer x = 27
integer y = 32
integer width = 215
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From : "
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gtelar058
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 128
integer width = 3218
integer height = 2340
string title = "none"
string dataobject = "dw_gtelar058"
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

