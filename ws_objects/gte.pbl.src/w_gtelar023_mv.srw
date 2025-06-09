$PBExportHeader$w_gtelar023_mv.srw
forward
global type w_gtelar023_mv from window
end type
type ddlb_1 from dropdownlistbox within w_gtelar023_mv
end type
type st_4 from statictext within w_gtelar023_mv
end type
type em_3 from editmask within w_gtelar023_mv
end type
type st_2 from statictext within w_gtelar023_mv
end type
type em_2 from editmask within w_gtelar023_mv
end type
type st_3 from statictext within w_gtelar023_mv
end type
type st_1 from statictext within w_gtelar023_mv
end type
type em_1 from editmask within w_gtelar023_mv
end type
type cb_1 from commandbutton within w_gtelar023_mv
end type
type cb_2 from commandbutton within w_gtelar023_mv
end type
type dw_1 from datawindow within w_gtelar023_mv
end type
end forward

global type w_gtelar023_mv from window
integer width = 3520
integer height = 2524
boolean titlebar = true
string title = "(W_Gtelar023) Tea Distribution Sheet"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_1 ddlb_1
st_4 st_4
em_3 em_3
st_2 st_2
em_2 em_2
st_3 st_3
st_1 st_1
em_1 em_1
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_gtelar023_mv w_gtelar023_mv

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

on w_gtelar023_mv.create
this.ddlb_1=create ddlb_1
this.st_4=create st_4
this.em_3=create em_3
this.st_2=create st_2
this.em_2=create em_2
this.st_3=create st_3
this.st_1=create st_1
this.em_1=create em_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.ddlb_1,&
this.st_4,&
this.em_3,&
this.st_2,&
this.em_2,&
this.st_3,&
this.st_1,&
this.em_1,&
this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_gtelar023_mv.destroy
destroy(this.ddlb_1)
destroy(this.st_4)
destroy(this.em_3)
destroy(this.st_2)
destroy(this.em_2)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

setpointer(hourglass!)

end event

type ddlb_1 from dropdownlistbox within w_gtelar023_mv
integer x = 2272
integer y = 12
integer width = 411
integer height = 376
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string item[] = {"LP - Permanent","LT - Temporary"}
end type

type st_4 from statictext within w_gtelar023_mv
integer x = 2062
integer y = 24
integer width = 160
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Type :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_3 from editmask within w_gtelar023_mv
integer x = 1819
integer y = 16
integer width = 160
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
string mask = "###.000"
string minmax = "1~~31"
end type

type st_2 from statictext within w_gtelar023_mv
integer x = 1632
integer y = 24
integer width = 142
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Qty :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_2 from editmask within w_gtelar023_mv
integer x = 1399
integer y = 16
integer width = 165
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = center!
string mask = "#0"
string minmax = "1~~31"
end type

type st_3 from statictext within w_gtelar023_mv
integer x = 887
integer y = 24
integer width = 521
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Min. Work Days :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_gtelar023_mv
integer x = 5
integer y = 24
integer width = 576
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year/Month (yyyymm):"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_1 from editmask within w_gtelar023_mv
integer x = 594
integer y = 16
integer width = 233
integer height = 84
integer taborder = 10
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
string mask = "yyyymm"
end type

type cb_1 from commandbutton within w_gtelar023_mv
integer x = 2738
integer y = 4
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

if isnull(em_1.text) or len(em_1.text) = 0 then
	messagebox('Warning','Please Enter Valid Year/Month  !!!')
	return 
end if
if isnull(em_2.text) or len(em_2.text) = 0 or long(em_2.text) < 0 then
	messagebox('Warning','Please Enter Minimum Working Days !!!')
	return 
end if
if isnull(em_3.text) or len(em_3.text) = 0 or double(em_3.text) = 0 then
	messagebox('Warning','Please Enter Tea Quantity !!!')
	return 
end if
if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning','Please Select Employee Type !!!')
	return 
end if

dw_1.retrieve(em_1.text,long(em_2.text),double(em_3.text),left(ddlb_1.text,2))

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if
end event

type cb_2 from commandbutton within w_gtelar023_mv
integer x = 3035
integer y = 4
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

type dw_1 from datawindow within w_gtelar023_mv
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 108
integer width = 3433
integer height = 2200
string dataobject = "dw_gtelar023_mv"
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

