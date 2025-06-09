$PBExportHeader$w_gtelar046.srw
forward
global type w_gtelar046 from window
end type
type st_5 from statictext within w_gtelar046
end type
type em_1 from editmask within w_gtelar046
end type
type ddlb_4 from dropdownlistbox within w_gtelar046
end type
type st_4 from statictext within w_gtelar046
end type
type ddlb_3 from dropdownlistbox within w_gtelar046
end type
type st_3 from statictext within w_gtelar046
end type
type ddlb_2 from dropdownlistbox within w_gtelar046
end type
type cb_2 from commandbutton within w_gtelar046
end type
type cb_1 from commandbutton within w_gtelar046
end type
type ddlb_1 from dropdownlistbox within w_gtelar046
end type
type st_1 from statictext within w_gtelar046
end type
type dw_1 from datawindow within w_gtelar046
end type
type st_2 from statictext within w_gtelar046
end type
end forward

global type w_gtelar046 from window
integer width = 4224
integer height = 2732
boolean titlebar = true
string title = "(Gtelar046) - Labour Details"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_5 st_5
em_1 em_1
ddlb_4 ddlb_4
st_4 st_4
ddlb_3 ddlb_3
st_3 st_3
ddlb_2 ddlb_2
cb_2 cb_2
cb_1 cb_1
ddlb_1 ddlb_1
st_1 st_1
dw_1 dw_1
st_2 st_2
end type
global w_gtelar046 w_gtelar046

type variables
long ll_pbno
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

on w_gtelar046.create
this.st_5=create st_5
this.em_1=create em_1
this.ddlb_4=create ddlb_4
this.st_4=create st_4
this.ddlb_3=create ddlb_3
this.st_3=create st_3
this.ddlb_2=create ddlb_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.dw_1=create dw_1
this.st_2=create st_2
this.Control[]={this.st_5,&
this.em_1,&
this.ddlb_4,&
this.st_4,&
this.ddlb_3,&
this.st_3,&
this.ddlb_2,&
this.cb_2,&
this.cb_1,&
this.ddlb_1,&
this.st_1,&
this.dw_1,&
this.st_2}
end on

on w_gtelar046.destroy
destroy(this.st_5)
destroy(this.em_1)
destroy(this.ddlb_4)
destroy(this.st_4)
destroy(this.ddlb_3)
destroy(this.st_3)
destroy(this.ddlb_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.st_2)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject(sqlca)
ddlb_1.text = 'All'
ddlb_2.text = 'All'
ddlb_3.text = 'All'
ddlb_4.text = 'All'

//Send(Handle(dw_1), 274, 61488, 0)


end event

type st_5 from statictext within w_gtelar046
integer x = 1897
integer y = 44
integer width = 329
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "As on date :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_1 from editmask within w_gtelar046
integer x = 2231
integer y = 36
integer width = 425
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type ddlb_4 from dropdownlistbox within w_gtelar046
integer x = 1349
integer y = 136
integer width = 549
integer height = 400
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
string item[] = {"All","Having PF No."}
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_gtelar046
integer x = 965
integer y = 148
integer width = 379
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "PF Catg. : "
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_3 from dropdownlistbox within w_gtelar046
integer x = 343
integer y = 136
integer width = 576
integer height = 400
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
string item[] = {"All","LP","LT","LO"}
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_gtelar046
integer x = 46
integer y = 148
integer width = 288
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Lab. Type : "
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within w_gtelar046
integer x = 1349
integer y = 32
integer width = 544
integer height = 400
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
string item[] = {"All","Active"}
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_gtelar046
integer x = 2254
integer y = 128
integer width = 274
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_gtelar046
integer x = 1966
integer y = 128
integer width = 274
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Run"
end type

event clicked;dw_1.retrieve(ddlb_1.text, ddlb_2.text,ddlb_3.text, ddlb_4.text,em_1.text)
if dw_1.rowcount() = 0 then
	messagebox('Information!','No data Found !!!')
	return 1
end if
end event

type ddlb_1 from dropdownlistbox within w_gtelar046
integer x = 338
integer y = 32
integer width = 590
integer height = 400
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
string item[] = {"All","Upto 58 Years"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_gtelar046
integer x = 27
integer y = 44
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Age group : "
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gtelar046
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 5
integer y = 236
integer width = 3945
integer height = 2164
string dataobject = "dw_gtelar046"
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

type st_2 from statictext within w_gtelar046
integer x = 974
integer y = 44
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Active Status : "
boolean focusrectangle = false
end type

