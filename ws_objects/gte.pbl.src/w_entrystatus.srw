$PBExportHeader$w_entrystatus.srw
forward
global type w_entrystatus from window
end type
type ddlb_1 from dropdownlistbox within w_entrystatus
end type
type st_3 from statictext within w_entrystatus
end type
type cb_2 from commandbutton within w_entrystatus
end type
type cb_1 from commandbutton within w_entrystatus
end type
type dw_1 from datawindow within w_entrystatus
end type
end forward

global type w_entrystatus from window
integer width = 2757
integer height = 2524
boolean titlebar = true
string title = "(w_datastatus)"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_1 ddlb_1
st_3 st_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_entrystatus w_entrystatus

type variables

string ls_gl
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

on w_entrystatus.create
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.ddlb_1,&
this.st_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_entrystatus.destroy
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject( sqlca);

end event

type ddlb_1 from dropdownlistbox within w_entrystatus
integer x = 293
integer width = 878
integer height = 640
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string item[] = {"Finance","Purchase","Inventory","Dispatch","Production","Field","HR","Labour","Budget"}
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_entrystatus
integer x = 50
integer y = 24
integer width = 265
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Module"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_entrystatus
integer x = 1458
integer y = 8
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_entrystatus
integer x = 1198
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
string text = "&Run"
end type

event clicked;dw_1.settransobject(sqlca)


if isnull(ddlb_1.text) or len(ddlb_1.text) <1 then 
	messagebox('Error :','Please Select a Valid Module Name') 
end if


setpointer(hourglass!)

dw_1.retrieve(ddlb_1.text)
setpointer(arrow!)

end event

type dw_1 from datawindow within w_entrystatus
integer x = 37
integer y = 128
integer width = 2597
integer height = 2208
string dataobject = "dw_entrystatus"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

