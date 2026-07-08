$PBExportHeader$w_gtelar084.srw
forward
global type w_gtelar084 from window
end type
type rb_2 from radiobutton within w_gtelar084
end type
type rb_1 from radiobutton within w_gtelar084
end type
type st_3 from statictext within w_gtelar084
end type
type em_2 from editmask within w_gtelar084
end type
type st_2 from statictext within w_gtelar084
end type
type em_1 from editmask within w_gtelar084
end type
type cb_2 from commandbutton within w_gtelar084
end type
type cb_1 from commandbutton within w_gtelar084
end type
type st_1 from statictext within w_gtelar084
end type
type dw_1 from datawindow within w_gtelar084
end type
type gb_1 from groupbox within w_gtelar084
end type
end forward

global type w_gtelar084 from window
integer width = 5408
integer height = 2472
boolean titlebar = true
string title = "Plucker Performance Section And Weightment"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_option ( )
rb_2 rb_2
rb_1 rb_1
st_3 st_3
em_2 em_2
st_2 st_2
em_1 em_1
cb_2 cb_2
cb_1 cb_1
st_1 st_1
dw_1 dw_1
gb_1 gb_1
end type
global w_gtelar084 w_gtelar084

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

on w_gtelar084.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_3=create st_3
this.em_2=create em_2
this.st_2=create st_2
this.em_1=create em_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.rb_2,&
this.rb_1,&
this.st_3,&
this.em_2,&
this.st_2,&
this.em_1,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.dw_1,&
this.gb_1}
end on

on w_gtelar084.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_3)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.em_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;dw_1.settransobject(sqlca)

em_1.text = string(today())
em_2.text = "0"



end event

type rb_2 from radiobutton within w_gtelar084
integer x = 1591
integer y = 36
integer width = 302
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 67108864
string text = "Summary"
end type

type rb_1 from radiobutton within w_gtelar084
integer x = 1326
integer y = 36
integer width = 256
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 67108864
string text = "Detail"
boolean checked = true
end type

type st_3 from statictext within w_gtelar084
integer x = 2597
integer y = 44
integer width = 1285
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 67108864
string text = "NOTE :- If Eff percentage Is Zero(0) Means All Data"
boolean focusrectangle = false
end type

type em_2 from editmask within w_gtelar084
integer x = 1038
integer y = 40
integer width = 242
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type st_2 from statictext within w_gtelar084
integer x = 613
integer y = 48
integer width = 421
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Eff percentage :-"
boolean focusrectangle = false
end type

type em_1 from editmask within w_gtelar084
integer x = 224
integer y = 40
integer width = 366
integer height = 80
integer taborder = 10
integer textsize = -9
integer weight = 400
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

type cb_2 from commandbutton within w_gtelar084
integer x = 2341
integer y = 32
integer width = 247
integer height = 88
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

type cb_1 from commandbutton within w_gtelar084
event ue_option ( )
integer x = 2057
integer y = 32
integer width = 247
integer height = 88
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

event clicked;string ls_date,ls_eff
integer li_eff_per
date ld_date

ls_date = trim(em_1.text)
ls_eff = trim(em_2.text)

// VALIDATION - Date
if isnull(em_1.text) or len(trim(em_1.text)) <= 0 then
    messagebox('Error', 'Please Enter Date !!!')
    em_1.setfocus()
    return 1
end if

if not isdate(ls_date) then
    messagebox('Error', 'Please Enter Valid Date as (DD/MM/YYYY) !!!')
    em_1.setfocus()
    return 1
end if

ld_date = date(ls_date)

// VALIDATION - Eff %
if isnull(em_2.text) or len(trim(em_2.text)) <= 0 then
    messagebox('Error', 'Please Enter Efficiency Percentage !!!')
    em_2.setfocus()
    return 1
end if

if not isnumber(ls_eff) then
    messagebox('Error', 'Efficiency Percentage Must Be a Number (0-100) !!!')
    em_2.setfocus()
    return 1
end if

li_eff_per = integer(ls_eff)

if li_eff_per < 0 or li_eff_per > 100 then
    messagebox('Error', 'Efficiency Percentage Must Be Between 0 and 100 !!!')
    em_2.setfocus()
    return 1
end if

// RETRIEVE DataWindow

if rb_1.checked=true then
	dw_1.dataobject='dw_gtelar084'
else
	dw_1.dataobject='dw_gtelar084b'
end if

dw_1.settransobject(sqlca)
dw_1.retrieve(ls_date, string(li_eff_per))

dw_1.visible=true


if dw_1.rowcount() = 0 then
    messagebox('Information', 'No Records Found For Selected Criteria !!!')
end if

end event

type st_1 from statictext within w_gtelar084
integer x = 55
integer y = 48
integer width = 201
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = " Date : "
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gtelar084
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 37
integer y = 140
integer width = 5038
integer height = 2220
string title = "none"
string dataobject = "dw_gtelar084"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

type gb_1 from groupbox within w_gtelar084
integer x = 1317
integer y = 16
integer width = 713
integer height = 116
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 67108864
string text = "none"
end type

