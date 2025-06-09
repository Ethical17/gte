$PBExportHeader$w_gtelar002.srw
forward
global type w_gtelar002 from window
end type
type rb_2 from radiobutton within w_gtelar002
end type
type rb_1 from radiobutton within w_gtelar002
end type
type st_3 from statictext within w_gtelar002
end type
type ddlb_3 from dropdownlistbox within w_gtelar002
end type
type ddlb_2 from dropdownlistbox within w_gtelar002
end type
type cb_2 from commandbutton within w_gtelar002
end type
type cb_1 from commandbutton within w_gtelar002
end type
type st_1 from statictext within w_gtelar002
end type
type ddlb_1 from dropdownlistbox within w_gtelar002
end type
type st_2 from statictext within w_gtelar002
end type
type gb_1 from groupbox within w_gtelar002
end type
type dw_2 from datawindow within w_gtelar002
end type
type dw_1 from datawindow within w_gtelar002
end type
end forward

global type w_gtelar002 from window
integer width = 3557
integer height = 2388
boolean titlebar = true
string title = "(Gtelar002) - Labour Census"
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
st_3 st_3
ddlb_3 ddlb_3
ddlb_2 ddlb_2
cb_2 cb_2
cb_1 cb_1
st_1 st_1
ddlb_1 ddlb_1
st_2 st_2
gb_1 gb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_gtelar002 w_gtelar002

type variables
long ll_pbno
string ls_type
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

on w_gtelar002.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_3=create st_3
this.ddlb_3=create ddlb_3
this.ddlb_2=create ddlb_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.st_2=create st_2
this.gb_1=create gb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.rb_2,&
this.rb_1,&
this.st_3,&
this.ddlb_3,&
this.ddlb_2,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.ddlb_1,&
this.st_2,&
this.gb_1,&
this.dw_2,&
this.dw_1}
end on

on w_gtelar002.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_3)
destroy(this.ddlb_3)
destroy(this.ddlb_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.st_2)
destroy(this.gb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

ddlb_2.reset()
ddlb_2.additem('ALL')
setpointer(hourglass!)
declare c2 cursor for
select distinct ls_id from FB_LABOURSHEET where ls_id is not null order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ll_pbno))
		fetch c2 into:ll_pbno;
	loop
	close c2;
end if

ddlb_2.text = 'ALL'


ddlb_3.reset()
ddlb_3.additem('ALL')
setpointer(hourglass!)
declare c3 cursor for
select distinct rh_manid||' ('||RH_ID||')' from fb_residentialhouse where nvl(rh_active_ind,'N') = 'Y' order by 1;

open c3;

IF sqlca.sqlcode = 0 THEN 
	fetch c3 into :ls_type;
	
	do while sqlca.sqlcode <> 100
		ddlb_3.additem(ls_type)
		fetch c3 into:ls_type;
	loop
	close c3;
end if

ddlb_3.text = 'ALL'
setpointer(arrow!)

end event

type rb_2 from radiobutton within w_gtelar002
integer x = 1719
integer y = 32
integer width = 521
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Labour Line Wise"
end type

event clicked;ddlb_3.enabled = true
ddlb_2.enabled = false
end event

type rb_1 from radiobutton within w_gtelar002
integer x = 1161
integer y = 32
integer width = 466
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pay Book Wise"
boolean checked = true
end type

event clicked;ddlb_3.enabled = false
ddlb_2.enabled = true
end event

type st_3 from statictext within w_gtelar002
integer x = 1870
integer y = 132
integer width = 357
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Labour Line"
boolean focusrectangle = false
end type

type ddlb_3 from dropdownlistbox within w_gtelar002
integer x = 2226
integer y = 124
integer width = 695
integer height = 636
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean enabled = false
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_2 from dropdownlistbox within w_gtelar002
integer x = 1504
integer y = 124
integer width = 297
integer height = 636
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
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

type cb_2 from commandbutton within w_gtelar002
integer x = 3227
integer y = 120
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

type cb_1 from commandbutton within w_gtelar002
integer x = 2962
integer y = 120
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
setpointer(hourglass!)

if isnull(ddlb_2.text) or len(ddlb_2.text) = 0 then
	messagebox('Warning','Please Enter Pay Book No. !!!')
	return 
end if
if rb_1.checked then
	dw_2.visible = false
	dw_1.visible = true
	dw_1.retrieve(long(ddlb_2.text),left(ddlb_1.text,2))
elseif  rb_2.checked then
	dw_1.visible = false
	dw_2.visible = true
	dw_2.retrieve(left(right(ddlb_3.text,9),8),left(ddlb_1.text,2))
end if

if dw_1.rowcount() = 0 and dw_2.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if

setpointer(arrow!)

end event

type st_1 from statictext within w_gtelar002
integer x = 18
integer y = 36
integer width = 402
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Employee Type:"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtelar002
integer x = 430
integer y = 20
integer width = 677
integer height = 508
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "ALL"
boolean sorted = false
string item[] = {"ALL","LP - Permanent ","LT - Temporary","LO - Outside"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;
ls_type = left(ddlb_1.text,2)
setpointer(hourglass!)

ddlb_2.reset()
ddlb_2.additem('ALL')

declare c2 cursor for
select distinct b.ls_id from FB_EMPLOYEE a,FB_LABOURSHEET b 
where a.ls_id = b.ls_id and emp_type = decode(nvl(:ls_type,'AL'),'AL',emp_type,:ls_type) and b.ls_id is not null order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ll_pbno))
		fetch c2 into:ll_pbno;
	loop
	close c2;
end if

ddlb_2.text = 'ALL'
setpointer(arrow!)
end event

type st_2 from statictext within w_gtelar002
integer x = 1138
integer y = 132
integer width = 357
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pay Book No. "
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_gtelar002
integer x = 1147
integer width = 1157
integer height = 120
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_2 from datawindow within w_gtelar002
event ue_leftbuttonup pbm_dwnlbuttonup
boolean visible = false
integer y = 224
integer width = 3502
integer height = 2056
integer taborder = 40
string dataobject = "dw_gtelar002a"
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

type dw_1 from datawindow within w_gtelar002
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 224
integer width = 3502
integer height = 2056
string dataobject = "dw_gtelar002"
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

