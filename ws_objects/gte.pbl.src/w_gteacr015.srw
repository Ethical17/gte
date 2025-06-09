$PBExportHeader$w_gteacr015.srw
forward
global type w_gteacr015 from window
end type
type rb_3 from radiobutton within w_gteacr015
end type
type rb_2 from radiobutton within w_gteacr015
end type
type rb_1 from radiobutton within w_gteacr015
end type
type cb_2 from commandbutton within w_gteacr015
end type
type cb_1 from commandbutton within w_gteacr015
end type
type gb_1 from groupbox within w_gteacr015
end type
type dw_1 from datawindow within w_gteacr015
end type
type dw_3 from datawindow within w_gteacr015
end type
type dw_2 from datawindow within w_gteacr015
end type
end forward

global type w_gteacr015 from window
integer width = 4837
integer height = 2416
boolean titlebar = true
string title = "(W_gteacr015) - Ledger Master"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
dw_1 dw_1
dw_3 dw_3
dw_2 dw_2
end type
global w_gteacr015 w_gteacr015

type variables
string ls_item_ty
n_cst_powerfilter iu_powerfilter
end variables

event ue_option();if rb_1.checked then
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
elseif rb_2.checked then
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

on w_gteacr015.create
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_3=create dw_3
this.dw_2=create dw_2
this.Control[]={this.rb_3,&
this.rb_2,&
this.rb_1,&
this.cb_2,&
this.cb_1,&
this.gb_1,&
this.dw_1,&
this.dw_3,&
this.dw_2}
end on

on w_gteacr015.destroy
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.dw_2)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_2.modify("t_co.text = '"+gs_co_name+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_3.modify("t_co.text = '"+gs_co_name+"'")
dw_3.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_2.hide()

	
end event

type rb_3 from radiobutton within w_gteacr015
integer x = 837
integer y = 32
integer width = 567
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Expense Sub Head"
end type

type rb_2 from radiobutton within w_gteacr015
integer x = 402
integer y = 32
integer width = 402
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sub Ledger"
end type

type rb_1 from radiobutton within w_gteacr015
integer x = 46
integer y = 32
integer width = 302
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ledger"
boolean checked = true
end type

type cb_2 from commandbutton within w_gteacr015
integer x = 1760
integer y = 16
integer width = 265
integer height = 100
integer taborder = 30
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

type cb_1 from commandbutton within w_gteacr015
integer x = 1481
integer y = 16
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;if rb_1.checked then
	dw_2.hide()
	dw_3.hide()
	dw_1.show()
	dw_1.settransobject(sqlca)
	dw_1.retrieve('ALL')
elseif rb_2.checked then
	dw_1.hide()
	dw_3.hide()
	dw_2.show()
	dw_2.settransobject(sqlca)
	dw_2.retrieve('ALL')
elseif rb_3.checked then
	dw_1.hide()
	dw_2.hide()
	dw_3.show()
	dw_3.settransobject(sqlca)
	dw_3.retrieve('ALL')
end if
setpointer(arrow!)
end event

type gb_1 from groupbox within w_gteacr015
integer x = 32
integer width = 1435
integer height = 120
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_1 from datawindow within w_gteacr015
integer y = 124
integer width = 3584
integer height = 2100
string dataobject = "dw_gteacr017"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if row > 0 then
	dw_2.show()
	dw_2.settransobject(sqlca)
	dw_2.retrieve(dw_1.getitemstring(row,'ACLEDGER_ID'))
end if
end event

type dw_3 from datawindow within w_gteacr015
integer y = 124
integer width = 3575
integer height = 2100
string dataobject = "dw_gteacr016"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;DW_1.HIDE()
DW_3.HIDE()
DW_2.SHOW()
end event

type dw_2 from datawindow within w_gteacr015
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 4677
integer height = 2100
string dataobject = "dw_gteacr015"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event clicked;if row > 0 then
	if dw_2.getitemstring(row,'exp_head_ind') ='Y' then
		dw_1.hide()
		dw_2.hide()
		dw_3.show()
		dw_3.settransobject(sqlca)
		dw_3.retrieve(dw_2.getitemstring(row,'acsubledger_id'))
	end if
end if
end event

event rbuttondown;DW_2.HIDE()
DW_3.HIDE()
DW_1.SHOW()
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

