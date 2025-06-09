$PBExportHeader$w_gtehrr027.srw
forward
global type w_gtehrr027 from window
end type
type cb_2 from commandbutton within w_gtehrr027
end type
type cb_1 from commandbutton within w_gtehrr027
end type
type rb_2 from radiobutton within w_gtehrr027
end type
type rb_1 from radiobutton within w_gtehrr027
end type
type st_5 from statictext within w_gtehrr027
end type
type ddlb_1 from dropdownlistbox within w_gtehrr027
end type
type em_2 from editmask within w_gtehrr027
end type
type st_2 from statictext within w_gtehrr027
end type
type st_1 from statictext within w_gtehrr027
end type
type em_1 from editmask within w_gtehrr027
end type
type gb_1 from groupbox within w_gtehrr027
end type
type dw_1 from datawindow within w_gtehrr027
end type
end forward

global type w_gtehrr027 from window
integer width = 3643
integer height = 2752
boolean titlebar = true
string title = "(Gtehrr027) Employee Earning Details"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_option ( )
cb_2 cb_2
cb_1 cb_1
rb_2 rb_2
rb_1 rb_1
st_5 st_5
ddlb_1 ddlb_1
em_2 em_2
st_2 st_2
st_1 st_1
em_1 em_1
gb_1 gb_1
dw_1 dw_1
end type
global w_gtehrr027 w_gtehrr027

type variables
string ls_frym, ls_toym, ls_emptype
boolean lb_neworder, lb_query
datawindowchild idw_prod,idw_subexp
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

on w_gtehrr027.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_5=create st_5
this.ddlb_1=create ddlb_1
this.em_2=create em_2
this.st_2=create st_2
this.st_1=create st_1
this.em_1=create em_1
this.gb_1=create gb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.rb_2,&
this.rb_1,&
this.st_5,&
this.ddlb_1,&
this.em_2,&
this.st_2,&
this.st_1,&
this.em_1,&
this.gb_1,&
this.dw_1}
end on

on w_gtehrr027.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_5)
destroy(this.ddlb_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.gb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_CO_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject(sqlca)
rb_1.checked = true
end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_2.triggerevent(clicked!)
end if

end event

type cb_2 from commandbutton within w_gtehrr027
integer x = 3214
integer y = 24
integer width = 265
integer height = 100
integer taborder = 80
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

type cb_1 from commandbutton within w_gtehrr027
integer x = 2949
integer y = 24
integer width = 265
integer height = 100
integer taborder = 70
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

string ls_temp
ls_temp = em_1.text

if isnull(em_1.text) or em_1.text  = '0000-00' then
	messagebox('Alert!','Please Enter Valid "From" Year Month !!!')
	return 1
end if

if isnull(em_2.text) or em_2.text  = '0000-00' then
	messagebox('Alert!','Please Enter Valid "To" Year Month !!!')
	return 1
end if

if isnull(ddlb_1.text) or len(ddlb_1.text)  = 0 then
	messagebox('Alert!','Please Select Employee Type !!!')
	return 1
end if


dw_1.reset()
//dw_2.reset()



ls_frym = left(em_1.text,4) + right(em_1.text,2)
ls_toym = left(em_2.text,4) + right(em_2.text,2)

if ddlb_1.text = 'ALL' then
	ls_emptype = 'ALL'
else
ls_emptype = left(ddlb_1.text,2)
end if

if rb_1.checked = true then
	dw_1.show( )
	dw_1.dataobject = 'dw_gtehrr027'
	dw_1.settransobject(sqlca)
	dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
	dw_1.retrieve(ls_frym, ls_toym, trim(ls_emptype))
	setpointer(arrow!)
	if dw_1.rowcount() = 0  then
		messagebox('Alert!','No data found between the entered dates !!!')
		return 1
	end if
elseif rb_2.checked = true then
	dw_1.show( )
	dw_1.dataobject = 'dw_gtehrr027_s'
	dw_1.settransobject(sqlca)
	dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
	dw_1.retrieve(ls_frym, ls_toym, trim(ls_emptype))
	setpointer(arrow!)
	if dw_1.rowcount() = 0  then
		messagebox('Alert!','No data found between the entered dates !!!')
	return 1
	end if
end if




end event

type rb_2 from radiobutton within w_gtehrr027
integer x = 2597
integer y = 36
integer width = 343
integer height = 76
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Summary"
end type

type rb_1 from radiobutton within w_gtehrr027
integer x = 2318
integer y = 36
integer width = 343
integer height = 76
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Details"
end type

type st_5 from statictext within w_gtehrr027
integer x = 1577
integer y = 40
integer width = 297
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Emp Type : "
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtehrr027
integer x = 1874
integer y = 28
integer width = 379
integer height = 316
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"ALL","ST-Staff","SS-Sub Staff","AT-Apprentice"}
end type

type em_2 from editmask within w_gtehrr027
integer x = 1225
integer y = 28
integer width = 297
integer height = 88
integer taborder = 20
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
string mask = "yyyy-mm"
end type

type st_2 from statictext within w_gtehrr027
integer x = 850
integer y = 40
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
string text = "To (yyyymm) : "
boolean focusrectangle = false
end type

type st_1 from statictext within w_gtehrr027
integer x = 46
integer y = 40
integer width = 434
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From (yyyymm) : "
boolean focusrectangle = false
end type

type em_1 from editmask within w_gtehrr027
integer x = 489
integer y = 28
integer width = 297
integer height = 88
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
string mask = "yyyy-mm"
end type

type gb_1 from groupbox within w_gtehrr027
integer x = 2286
integer y = 24
integer width = 649
integer height = 96
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
end type

type dw_1 from datawindow within w_gtehrr027
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 128
integer width = 3497
integer height = 2488
integer taborder = 60
string title = "none"
string dataobject = "dw_gtehrr027"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = StyleBox!
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

