$PBExportHeader$w_gtehrr007.srw
forward
global type w_gtehrr007 from window
end type
type rb_3 from radiobutton within w_gtehrr007
end type
type rb_2 from radiobutton within w_gtehrr007
end type
type rb_1 from radiobutton within w_gtehrr007
end type
type st_1 from statictext within w_gtehrr007
end type
type ddlb_2 from dropdownlistbox within w_gtehrr007
end type
type ddlb_1 from dropdownlistbox within w_gtehrr007
end type
type cb_2 from commandbutton within w_gtehrr007
end type
type st_3 from statictext within w_gtehrr007
end type
type cb_1 from commandbutton within w_gtehrr007
end type
type gb_1 from groupbox within w_gtehrr007
end type
type dw_3 from datawindow within w_gtehrr007
end type
type dw_1 from datawindow within w_gtehrr007
end type
type dw_2 from datawindow within w_gtehrr007
end type
end forward

global type w_gtehrr007 from window
integer width = 4571
integer height = 2608
boolean titlebar = true
string title = "(Gtehrr007) - Employee Bonus"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
st_1 st_1
ddlb_2 ddlb_2
ddlb_1 ddlb_1
cb_2 cb_2
st_3 st_3
cb_1 cb_1
gb_1 gb_1
dw_3 dw_3
dw_1 dw_1
dw_2 dw_2
end type
global w_gtehrr007 w_gtehrr007

type variables
long ll_pbno
string ls_type, ls_yrmn
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
elseif rb_3.checked then
	choose case gs_ueoption
		case "PRINT"
				OpenWithParm(w_print,this.dw_3)
		case "PRINTPREVIEW"
				this.dw_3.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_3.modify("datawindow.print.preview = no")
		case "SAVEAS"
				this.dw_3.saveas()
		case "SFILTER"
				iu_powerfilter.checked = NOT iu_powerfilter.checked
				iu_powerfilter.event ue_clicked()
				m_main.m_file.m_filter.checked = iu_powerfilter.checked
		case "FILTER"
				setnull(gs_filtertext)
				this.dw_3.setredraw(false)
				this.dw_3.setfilter(gs_filtertext)
				this.dw_3.filter()
				this.dw_3.groupcalc()
				if this.dw_3.rowcount() > 0 then;
					this.dw_3.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
		case "SORT"
				setnull(gs_sorttext)
				this.dw_3.setredraw(false)
				this.dw_3.setsort(gs_sorttext)
				this.dw_3.sort()
				this.dw_3.groupcalc()
				if this.dw_3.rowcount() > 0 then;
					this.dw_3.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
	end choose	
end if
end event

event open;//dw_1.modify("t_co.text = '"+gs_co_name+"'")
//dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_2.hide()
dw_3.hide()
dw_1.show()
setpointer(hourglass!)

ddlb_1.reset()

declare c1 cursor for
select distinct to_char(EBP_STARTDATE,'YYYY') from FB_EMPBONUSPERIOD where lbs_emp_type not in ('LP','LO','LT') order by 1 desc;

open c1;

IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_yrmn;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_yrmn)
		fetch c1 into:ls_yrmn;
	loop
	close c1;
end if


setpointer(arrow!)
end event

on w_gtehrr007.create
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_1=create st_1
this.ddlb_2=create ddlb_2
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.st_3=create st_3
this.cb_1=create cb_1
this.gb_1=create gb_1
this.dw_3=create dw_3
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.rb_3,&
this.rb_2,&
this.rb_1,&
this.st_1,&
this.ddlb_2,&
this.ddlb_1,&
this.cb_2,&
this.st_3,&
this.cb_1,&
this.gb_1,&
this.dw_3,&
this.dw_1,&
this.dw_2}
end on

on w_gtehrr007.destroy
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_1)
destroy(this.ddlb_2)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.dw_3)
destroy(this.dw_1)
destroy(this.dw_2)
end on

type rb_3 from radiobutton within w_gtehrr007
integer x = 2944
integer y = 44
integer width = 265
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "15 + 5"
end type

event clicked;dw_2.hide()
dw_1.hide()
dw_3.show()
end event

type rb_2 from radiobutton within w_gtehrr007
integer x = 2555
integer y = 44
integer width = 311
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Summary"
end type

event clicked;dw_1.hide()
dw_2.show()
dw_3.hide()
end event

type rb_1 from radiobutton within w_gtehrr007
integer x = 2245
integer y = 44
integer width = 279
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detail"
boolean checked = true
end type

event clicked;dw_2.hide()
dw_1.show()
dw_3.hide()
end event

type st_1 from statictext within w_gtehrr007
integer x = 1006
integer y = 40
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
string text = "Employee Type:"
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within w_gtehrr007
integer x = 1435
integer y = 28
integer width = 677
integer height = 508
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "ALL"
boolean sorted = false
string item[] = {"ALL - ALL","EXE - Executive","ST  - Staff","SS  - Sub Staff"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_1 from dropdownlistbox within w_gtehrr007
integer x = 571
integer y = 28
integer width = 411
integer height = 520
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_gtehrr007
integer x = 3282
integer y = 24
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
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)

setpointer(hourglass!)

if isnull(ddlb_1.text) or ddlb_1.text='0000' then
	messagebox('Warning','Please Bonus Year !!!')
	return 
end if
if rb_1.checked then
	dw_1.show()
	dw_3.hide()
	dw_2.hide()
	dw_1.retrieve(ddlb_1.text,left(ddlb_2.text,3))
	if dw_1.rowcount() = 0 then
		messagebox('Alert!','No Data Found !!!')
		return 1
	end if
elseif rb_2.checked then
	dw_1.hide()
	dw_3.hide()
	dw_2.show()
	dw_2.retrieve(ddlb_1.text,left(ddlb_2.text,3))
	if dw_2.rowcount() = 0 then
		messagebox('Alert!','No Data Found !!!')
		return 1
	end if
elseif rb_3.checked then
	dw_1.hide()
	dw_2.hide()
	dw_3.show()
	dw_3.retrieve(ddlb_1.text,left(ddlb_2.text,3))
	if dw_3.rowcount() = 0 then
		messagebox('Alert!','No Data Found !!!')
		return 1
	end if
end if

end event

type st_3 from statictext within w_gtehrr007
integer x = 27
integer y = 40
integer width = 549
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bonus Year (YYYY) : "
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtehrr007
integer x = 3543
integer y = 24
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

type gb_1 from groupbox within w_gtehrr007
integer x = 2217
integer width = 1015
integer height = 128
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

type dw_3 from datawindow within w_gtehrr007
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 132
integer width = 4507
integer height = 2344
integer taborder = 50
string title = "none"
string dataobject = "dw_gtehrr007bf"
boolean hscrollbar = true
boolean vscrollbar = true
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

type dw_1 from datawindow within w_gtehrr007
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 132
integer width = 4507
integer height = 2344
string title = "none"
string dataobject = "dw_gtehrr007"
boolean hscrollbar = true
boolean vscrollbar = true
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

type dw_2 from datawindow within w_gtehrr007
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 132
integer width = 4507
integer height = 2344
integer taborder = 40
string dataobject = "dw_gtehrr007s"
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

