$PBExportHeader$w_gtehrr001.srw
forward
global type w_gtehrr001 from window
end type
type st_1 from statictext within w_gtehrr001
end type
type ddlb_1 from dropdownlistbox within w_gtehrr001
end type
type rb_2 from radiobutton within w_gtehrr001
end type
type rb_1 from radiobutton within w_gtehrr001
end type
type cb_1 from commandbutton within w_gtehrr001
end type
type cb_2 from commandbutton within w_gtehrr001
end type
type dw_1 from datawindow within w_gtehrr001
end type
type gb_1 from groupbox within w_gtehrr001
end type
end forward

global type w_gtehrr001 from window
integer width = 4311
integer height = 2300
boolean titlebar = true
string title = "(Gtehrr001) - Employeee Master"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_1 st_1
ddlb_1 ddlb_1
rb_2 rb_2
rb_1 rb_1
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
gb_1 gb_1
end type
global w_gtehrr001 w_gtehrr001

type variables
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

on w_gtehrr001.create
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.st_1,&
this.ddlb_1,&
this.rb_2,&
this.rb_1,&
this.cb_1,&
this.cb_2,&
this.dw_1,&
this.gb_1}
end on

on w_gtehrr001.destroy
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

end event

type st_1 from statictext within w_gtehrr001
integer x = 736
integer y = 48
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

type ddlb_1 from dropdownlistbox within w_gtehrr001
integer x = 1147
integer y = 44
integer width = 677
integer height = 508
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
string item[] = {"ALL","ST - Staff","SS - Sub Staff","AT - Apprentice"}
borderstyle borderstyle = stylelowered!
end type

type rb_2 from radiobutton within w_gtehrr001
integer x = 361
integer y = 60
integer width = 283
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inactive"
end type

type rb_1 from radiobutton within w_gtehrr001
integer x = 50
integer y = 60
integer width = 283
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Active"
boolean checked = true
end type

type cb_1 from commandbutton within w_gtehrr001
integer x = 1865
integer y = 44
integer width = 265
integer height = 100
integer taborder = 40
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

if isnull(ddlb_1.text) or len(trim(ddlb_1.text)) = 0 then
	messagebox('Warning','Please Select Employee Type...!!')
	return 1
end if	

if rb_1.checked then
	dw_1.retrieve(left(trim(ddlb_1.text),2),'1')
else
	dw_1.retrieve(left(trim(ddlb_1.text),2),'0')
end if

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Parameter')
	return 1
end if
setpointer(arrow!)
end event

type cb_2 from commandbutton within w_gtehrr001
integer x = 2130
integer y = 44
integer width = 265
integer height = 100
integer taborder = 50
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

type dw_1 from datawindow within w_gtehrr001
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 160
integer width = 4206
integer height = 2004
string dataobject = "dw_gtehrr001"
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

type gb_1 from groupbox within w_gtehrr001
integer x = 18
integer width = 686
integer height = 160
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Status"
end type

