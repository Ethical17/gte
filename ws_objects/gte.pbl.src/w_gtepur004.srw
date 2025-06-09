$PBExportHeader$w_gtepur004.srw
forward
global type w_gtepur004 from window
end type
type ddlb_1 from dropdownlistbox within w_gtepur004
end type
type st_4 from statictext within w_gtepur004
end type
type rb_2 from radiobutton within w_gtepur004
end type
type rb_1 from radiobutton within w_gtepur004
end type
type st_2 from statictext within w_gtepur004
end type
type st_1 from statictext within w_gtepur004
end type
type cb_2 from commandbutton within w_gtepur004
end type
type cb_4 from commandbutton within w_gtepur004
end type
type dp_1 from datepicker within w_gtepur004
end type
type dp_2 from datepicker within w_gtepur004
end type
type dw_1 from datawindow within w_gtepur004
end type
type dw_2 from datawindow within w_gtepur004
end type
type gb_1 from groupbox within w_gtepur004
end type
end forward

global type w_gtepur004 from window
integer width = 4210
integer height = 2536
boolean titlebar = true
string title = "(W_gtepur004) H.O. Purchase Detail"
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
rb_2 rb_2
rb_1 rb_1
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_4 cb_4
dp_1 dp_1
dp_2 dp_2
dw_1 dw_1
dw_2 dw_2
gb_1 gb_1
end type
global w_gtepur004 w_gtepur004

type variables
boolean lb_neworder, lb_query
string ls_frym,ls_toym,ls_sup_id,ls_temp
n_cst_powerfilter iu_powerfilter 
end variables

forward prototypes
public function integer wf_inquiry (long fl_year)
end prototypes

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

public function integer wf_inquiry (long fl_year);dw_1.settransobject(sqlca)
dw_1.retrieve(gs_user,fl_year)
return 1
end function

on w_gtepur004.create
this.ddlb_1=create ddlb_1
this.st_4=create st_4
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_4=create cb_4
this.dp_1=create dp_1
this.dp_2=create dp_2
this.dw_1=create dw_1
this.dw_2=create dw_2
this.gb_1=create gb_1
this.Control[]={this.ddlb_1,&
this.st_4,&
this.rb_2,&
this.rb_1,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_4,&
this.dp_1,&
this.dp_2,&
this.dw_1,&
this.dw_2,&
this.gb_1}
end on

on w_gtepur004.destroy
destroy(this.ddlb_1)
destroy(this.st_4)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.dp_1)
destroy(this.dp_2)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.gb_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_2.modify("t_co.text = '"+gs_co_name+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
lb_query = false	
lb_neworder = false
dw_2.hide()
setpointer(hourglass!)
	ddlb_1.reset()
	ddlb_1.additem('ALL')
	
	declare c1 cursor for
		
   select initcap(SUP_NAME)||'('||SUP_ID||')' 
	 from fb_supplier where  nvl(SUP_ACTIVE,'0')='1' and (SUP_TYPE='HO' OR SUP_TYPE='BOTH')
	 order by 1;
	 
	open c1;
	
	IF sqlca.sqlcode = 0 THEN
		fetch c1 into :ls_temp;
		
		do while sqlca.sqlcode <> 100
			ddlb_1.additem(ls_temp)
			fetch c1 into :ls_temp;
		loop
		close c1;
	end if
	ddlb_1.text='ALL'
setpointer(arrow!)



end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type ddlb_1 from dropdownlistbox within w_gtepur004
integer x = 1106
integer y = 112
integer width = 1358
integer height = 856
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_gtepur004
integer x = 837
integer y = 120
integer width = 302
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Supplier : "
boolean focusrectangle = false
end type

type rb_2 from radiobutton within w_gtepur004
integer x = 393
integer y = 32
integer width = 279
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Details"
end type

event clicked;dw_1.visible = false
dw_2.visible = true
end event

type rb_1 from radiobutton within w_gtepur004
integer x = 46
integer y = 32
integer width = 343
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Summary"
boolean checked = true
end type

event clicked;dw_2.visible = false
dw_1.visible = true
end event

type st_2 from statictext within w_gtepur004
integer x = 1554
integer y = 28
integer width = 247
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To Date :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_gtepur004
integer x = 791
integer y = 28
integer width = 297
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Date :"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gtepur004
integer x = 2203
integer y = 4
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
end type

event clicked;if  isnull(dp_1.text) or isnull(dp_2.text)then 
	messagebox('Error At Date','From Date/To Date Should Be Entered')
	return 1
end if;

if  isnull(ddlb_1.text) or ddlb_1.text = "" then 
	messagebox('Error At Supplier','Please Select Supplier')
	return 1
end if;

ls_sup_id = left(right(ddlb_1.text,9),8)

ls_frym =dp_1.text
ls_toym =dp_2.text
if rb_1.checked then
	dw_1.show()
	dw_2.visible = false
	dw_1.settransobject(sqlca)
	dw_1.retrieve(ls_frym,ls_toym,ls_sup_id)
else
	dw_2.show()
	dw_1.visible = false
	dw_2.settransobject(sqlca)
	dw_2.retrieve(ls_frym,ls_toym,'0',ls_sup_id)
end if	
end event

type cb_4 from commandbutton within w_gtepur004
integer x = 2464
integer y = 4
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
end type

event clicked;close(parent)
end event

type dp_1 from datepicker within w_gtepur004
integer x = 1106
integer y = 8
integer width = 379
integer height = 96
integer taborder = 30
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2021-01-25"), Time("10:21:41.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_2 from datepicker within w_gtepur004
integer x = 1801
integer y = 8
integer width = 379
integer height = 96
integer taborder = 60
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2021-01-25"), Time("10:21:41.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dw_1 from datawindow within w_gtepur004
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 27
integer y = 224
integer width = 3749
integer height = 1936
integer taborder = 50
string dataobject = "dw_gtepur004"
boolean vscrollbar = true
boolean resizable = true
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event clicked;if row > 0 then
	dw_2.show()
	ls_frym =dp_1.text
     ls_toym =dp_2.text

	dw_2.settransobject(sqlca)
	dw_2.retrieve(ls_frym,ls_toym,dw_1.getitemstring(row,'garden_inv_id'),dw_1.getitemstring(row,'sup_id'))
		
end if
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

type dw_2 from datawindow within w_gtepur004
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 27
integer y = 224
integer width = 3429
integer height = 1936
integer taborder = 60
string dataobject = "dw_gtepur004a"
boolean vscrollbar = true
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event rbuttondown;if rb_1.checked then
	DW_2.HIDE()
	DW_1.SHOW()
end if
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

type gb_1 from groupbox within w_gtepur004
integer x = 32
integer width = 672
integer height = 116
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylebox!
end type

