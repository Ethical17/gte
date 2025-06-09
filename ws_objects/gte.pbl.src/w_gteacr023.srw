$PBExportHeader$w_gteacr023.srw
forward
global type w_gteacr023 from window
end type
type dp_2 from datepicker within w_gteacr023
end type
type st_2 from statictext within w_gteacr023
end type
type dp_1 from datepicker within w_gteacr023
end type
type st_1 from statictext within w_gteacr023
end type
type cb_2 from commandbutton within w_gteacr023
end type
type cb_1 from commandbutton within w_gteacr023
end type
type dw_1 from datawindow within w_gteacr023
end type
end forward

global type w_gteacr023 from window
integer width = 4713
integer height = 2780
boolean titlebar = true
string title = "gteacr023 -Exception Report"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
dp_2 dp_2
st_2 st_2
dp_1 dp_1
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteacr023 w_gteacr023

type variables
string ls_item_ty,ls_frym, ls_toym
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

on w_gteacr023.create
this.dp_2=create dp_2
this.st_2=create st_2
this.dp_1=create dp_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.dp_2,&
this.st_2,&
this.dp_1,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteacr023.destroy
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


end event

type dp_2 from datepicker within w_gteacr023
integer x = 1074
integer y = 16
integer width = 393
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2025-02-06"), Time("14:43:46.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_2 from statictext within w_gteacr023
integer x = 891
integer y = 32
integer width = 151
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

type dp_1 from datepicker within w_gteacr023
integer x = 475
integer y = 16
integer width = 393
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2025-02-06"), Time("14:43:46.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_1 from statictext within w_gteacr023
integer x = 14
integer y = 32
integer width = 443
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

type cb_2 from commandbutton within w_gteacr023
integer x = 1751
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

type cb_1 from commandbutton within w_gteacr023
integer x = 1486
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

event clicked;if isnull(dp_1.text) or dp_1.text='00/00/0000' then
	messagebox('Warning','Please Enter The "From" Date !!!')
	return 
end if

if isnull(dp_2.text) or dp_2.text='00/00/0000' then
	messagebox('Warning','Please Enter The "To" Date !!!')
	return 
end if

if date(dp_1.text) > date(dp_2.text)  then
	messagebox('Warning ','The From Date Should be <= TO Date , Please check ...!')
	return 1
end if

ls_frym =dp_1.text
ls_toym =dp_2.text

dw_1.show()
dw_1.settransobject(sqlca)
dw_1.retrieve(ls_frym,ls_toym)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found')
	return 1
end if
end event

type dw_1 from datawindow within w_gteacr023
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 120
integer width = 4366
integer height = 2112
integer taborder = 30
string dataobject = "dw_gteacr023"
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

event clicked;//if row > 0 then
//	dw_2.show()
//	ls_frym =dp_1.text
//     ls_toym =dp_2.text
//
//	dw_2.settransobject(sqlca)
//	dw_2.retrieve(ls_frym,ls_toym,dw_1.getitemstring(row,'sup_id'))	
//end if
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

