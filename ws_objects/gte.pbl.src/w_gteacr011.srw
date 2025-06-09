$PBExportHeader$w_gteacr011.srw
forward
global type w_gteacr011 from window
end type
type st_3 from statictext within w_gteacr011
end type
type ddlb_1 from dropdownlistbox within w_gteacr011
end type
type dp_2 from datepicker within w_gteacr011
end type
type st_2 from statictext within w_gteacr011
end type
type dp_1 from datepicker within w_gteacr011
end type
type st_1 from statictext within w_gteacr011
end type
type cb_2 from commandbutton within w_gteacr011
end type
type cb_1 from commandbutton within w_gteacr011
end type
type dw_1 from datawindow within w_gteacr011
end type
end forward

global type w_gteacr011 from window
integer width = 3269
integer height = 2408
boolean titlebar = true
string title = "gteacr011- Remittance Register"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_3 st_3
ddlb_1 ddlb_1
dp_2 dp_2
st_2 st_2
dp_1 dp_1
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteacr011 w_gteacr011

type variables
string ls_item_ty
n_cst_powerfilter iu_powerfilter
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

on w_gteacr011.create
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.dp_2=create dp_2
this.st_2=create st_2
this.dp_1=create dp_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_3,&
this.ddlb_1,&
this.dp_2,&
this.st_2,&
this.dp_1,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteacr011.destroy
destroy(this.st_3)
destroy(this.ddlb_1)
destroy(this.dp_2)
destroy(this.st_2)
destroy(this.dp_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject(sqlca)

ddlb_1.text = 'All (A)'
end event

type st_3 from statictext within w_gteacr011
integer x = 14
integer y = 28
integer width = 462
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Remittance Type :"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gteacr011
integer x = 480
integer y = 20
integer width = 507
integer height = 396
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string item[] = {"Remittance Kind (K)","Remittance Cash (C)","All (A)"}
borderstyle borderstyle = stylelowered!
end type

type dp_2 from datepicker within w_gteacr011
integer x = 1906
integer y = 12
integer width = 393
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2012-05-30"), Time("16:03:46.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_2 from statictext within w_gteacr011
integer x = 1778
integer y = 28
integer width = 119
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To :"
alignment alignment = center!
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gteacr011
integer x = 1385
integer y = 12
integer width = 393
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2012-05-30"), Time("16:03:46.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_1 from statictext within w_gteacr011
integer x = 992
integer y = 28
integer width = 393
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Period From :"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gteacr011
integer x = 2578
integer y = 12
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

event clicked;Close(parent)
end event

type cb_1 from commandbutton within w_gteacr011
integer x = 2313
integer y = 12
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;string ls_frym
setpointer(hourglass!)

if date(dp_1.text) > date(dp_2.text) then 
	messagebox('Error At Date','The "From" Date Must be less than "TO" date, Please check..!')
	return 1
end if;

dw_1.settransobject(sqlca)
dw_1.retrieve(dp_1.text,dp_2.text,left(right(ddlb_1.text,2),1))

setpointer(arrow!)
end event

type dw_1 from datawindow within w_gteacr011
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 120
integer width = 3141
integer height = 2100
string dataobject = "dw_gteacr011"
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

