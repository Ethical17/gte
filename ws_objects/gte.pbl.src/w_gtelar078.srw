$PBExportHeader$w_gtelar078.srw
forward
global type w_gtelar078 from window
end type
type st_1 from statictext within w_gtelar078
end type
type em_1 from editmask within w_gtelar078
end type
type cb_1 from commandbutton within w_gtelar078
end type
type cb_2 from commandbutton within w_gtelar078
end type
type dw_1 from datawindow within w_gtelar078
end type
end forward

global type w_gtelar078 from window
integer width = 6176
integer height = 2668
boolean titlebar = true
string title = "(Gtelar078) - Labour Gratuity "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_1 st_1
em_1 em_1
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_gtelar078 w_gtelar078

type variables
long ll_pbno
string ls_temp, ls_dt,ls_labid,ls_measure,ls_measure1,ls_first_read,ls_old_labour
datetime ld_dt
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

on w_gtelar078.create
this.st_1=create st_1
this.em_1=create em_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.em_1,&
this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_gtelar078.destroy
destroy(this.st_1)
destroy(this.em_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

end event

type st_1 from statictext within w_gtelar078
integer x = 37
integer y = 28
integer width = 343
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "As On Date:"
boolean focusrectangle = false
end type

type em_1 from editmask within w_gtelar078
integer x = 375
integer y = 24
integer width = 293
integer height = 80
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "DD/MM/YYYY"
end type

type cb_1 from commandbutton within w_gtelar078
integer x = 695
integer y = 12
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

event clicked;dw_1.settransobject(sqlca)

if date(em_1.text) > date(today()) then
	messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
	return 1
end if

if isnull(em_1.text) or em_1.text = '00/00/0000' then
	messagebox('Warning!','Please Select A Reading Date !!!')
	return 1
end if

setpointer(hourglass!)

dw_1.retrieve(em_1.text)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if
setpointer(Arrow!)
end event

type cb_2 from commandbutton within w_gtelar078
integer x = 960
integer y = 12
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

type dw_1 from datawindow within w_gtelar078
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 18
integer y = 124
integer width = 5170
integer height = 2372
string dataobject = "dw_gtelar078"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
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

