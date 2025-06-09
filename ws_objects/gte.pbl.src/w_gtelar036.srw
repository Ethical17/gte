$PBExportHeader$w_gtelar036.srw
forward
global type w_gtelar036 from window
end type
type rb_2 from radiobutton within w_gtelar036
end type
type rb_1 from radiobutton within w_gtelar036
end type
type st_1 from statictext within w_gtelar036
end type
type em_1 from editmask within w_gtelar036
end type
type cb_1 from commandbutton within w_gtelar036
end type
type cb_2 from commandbutton within w_gtelar036
end type
type dw_2 from datawindow within w_gtelar036
end type
type gb_1 from groupbox within w_gtelar036
end type
type dw_1 from datawindow within w_gtelar036
end type
end forward

global type w_gtelar036 from window
integer width = 3022
integer height = 2732
boolean titlebar = true
string title = "(Gtelar036) LIP and RD Register"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
rb_2 rb_2
rb_1 rb_1
st_1 st_1
em_1 em_1
cb_1 cb_1
cb_2 cb_2
dw_2 dw_2
gb_1 gb_1
dw_1 dw_1
end type
global w_gtelar036 w_gtelar036

type variables
long ll_pbno
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
		case "PDF"
				this.dw_1.saveas("C:\reports\Gtelar036.pdf",pdf!,true)				
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
		case "PDF"
				this.dw_2.saveas("C:\reports\Gtelar036.pdf",pdf!,true)				
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

on w_gtelar036.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_1=create st_1
this.em_1=create em_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_2=create dw_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.Control[]={this.rb_2,&
this.rb_1,&
this.st_1,&
this.em_1,&
this.cb_1,&
this.cb_2,&
this.dw_2,&
this.gb_1,&
this.dw_1}
end on

on w_gtelar036.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.gb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

setpointer(hourglass!)

end event

type rb_2 from radiobutton within w_gtelar036
integer x = 1179
integer y = 40
integer width = 215
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "LIP"
end type

type rb_1 from radiobutton within w_gtelar036
integer x = 933
integer y = 40
integer width = 215
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "RD"
boolean checked = true
end type

type st_1 from statictext within w_gtelar036
integer x = 5
integer y = 28
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

type em_1 from editmask within w_gtelar036
integer x = 585
integer y = 20
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

type cb_1 from commandbutton within w_gtelar036
integer x = 1495
integer y = 28
integer width = 247
integer height = 92
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
dw_2.settransobject(sqlca)
setpointer(hourglass!)

if isnull(em_1.text) or len(em_1.text) = 0 then
	messagebox('Warning','Please Enter Valid Year/Month  !!!')
	return 
end if

if rb_1.checked then
	dw_1.show()
	dw_2.hide()
	dw_1.retrieve(em_1.text)
else
	dw_2.show()
	dw_1.hide()
	dw_2.retrieve(em_1.text)
end if
if rb_1.checked then
if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if
else
if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if
end if
end event

type cb_2 from commandbutton within w_gtelar036
integer x = 1746
integer y = 28
integer width = 247
integer height = 92
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

type dw_2 from datawindow within w_gtelar036
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 148
integer width = 2857
integer height = 2200
integer taborder = 20
string dataobject = "dw_gtelar036a"
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

type gb_1 from groupbox within w_gtelar036
integer x = 905
integer width = 553
integer height = 136
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_1 from datawindow within w_gtelar036
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 148
integer width = 2857
integer height = 2200
string dataobject = "dw_gtelar036"
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

