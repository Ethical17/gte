$PBExportHeader$w_gtelar027.srw
forward
global type w_gtelar027 from window
end type
type ddlb_1 from dropdownlistbox within w_gtelar027
end type
type rb_2 from radiobutton within w_gtelar027
end type
type rb_1 from radiobutton within w_gtelar027
end type
type st_1 from statictext within w_gtelar027
end type
type cb_1 from commandbutton within w_gtelar027
end type
type cb_2 from commandbutton within w_gtelar027
end type
type gb_1 from groupbox within w_gtelar027
end type
type dw_1 from datawindow within w_gtelar027
end type
type dw_2 from datawindow within w_gtelar027
end type
end forward

global type w_gtelar027 from window
integer width = 2985
integer height = 2308
boolean titlebar = true
string title = "(Gtelar027) - Discipline Records & Notice Letter"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_1 ddlb_1
rb_2 rb_2
rb_1 rb_1
st_1 st_1
cb_1 cb_1
cb_2 cb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
end type
global w_gtelar027 w_gtelar027

type variables
string ls_min_date_fix,ls_min_date,ls_max_date,ls_emp_ty,ls_empid,ls_empname,ls_pre_labid,ls_ins_flag,ls_period,ls_dt
long ll_absent_threshold,ll_absent,ll_count, ll_cnt
datetime ld_dt
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
else
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

on w_gtelar027.create
this.ddlb_1=create ddlb_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.ddlb_1,&
this.rb_2,&
this.rb_1,&
this.st_1,&
this.cb_1,&
this.cb_2,&
this.gb_1,&
this.dw_1,&
this.dw_2}
end on

on w_gtelar027.destroy
destroy(this.ddlb_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_2.modify("t_co.text = '"+gs_co_name+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")


setpointer(hourglass!)
//string ls_dt, ls_period

ddlb_1.reset()

declare c1 cursor for
select distinct (to_char(FD_PERIOD_FR,'dd/mm/yyyy')||' - '||to_char(FD_PERIOD_TO,'dd/mm/yyyy')) lww_id,FD_PERIOD_FR
   from fb_disciplinary 
 order by FD_PERIOD_FR desc;

open c1;
IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_period,:ls_dt;
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_period)
		setnull(ls_period);setnull(ls_dt)
		fetch c1 into :ls_period,:ls_dt;
	loop
close c1;
end if


end event

type ddlb_1 from dropdownlistbox within w_gtelar027
integer x = 1330
integer y = 36
integer width = 974
integer height = 856
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

type rb_2 from radiobutton within w_gtelar027
integer x = 457
integer y = 44
integer width = 361
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Disciplinary"
end type

event clicked;dw_1.hide()
dw_2.show()

ddlb_1.reset()

declare c1 cursor for
select distinct (to_char(FD_PERIOD_FR,'dd/mm/yyyy')||' - '||to_char(FD_PERIOD_TO,'dd/mm/yyyy')) lww_id,FD_PERIOD_FR
   from fb_disciplinary where FD_TYPE = 'D'
 order by FD_PERIOD_FR desc;

open c1;
IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_period,:ls_dt;
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_period)
		setnull(ls_period);setnull(ls_dt)
		fetch c1 into :ls_period,:ls_dt;
	loop
close c1;
end if
end event

type rb_1 from radiobutton within w_gtelar027
integer x = 41
integer y = 44
integer width = 411
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Absenteeism"
boolean checked = true
end type

event clicked;dw_2.hide()
dw_1.show()

setpointer(hourglass!)

ddlb_1.reset()

declare c1 cursor for
select distinct (to_char(FD_PERIOD_FR,'dd/mm/yyyy')||' - '||to_char(FD_PERIOD_TO,'dd/mm/yyyy')) lww_id,FD_PERIOD_FR
   from fb_disciplinary where FD_TYPE = 'A'
 order by FD_PERIOD_FR desc;

open c1;
IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_period,:ls_dt;
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_period)
		setnull(ls_period);setnull(ls_dt)
		fetch c1 into :ls_period,:ls_dt;
	loop
close c1;
end if
end event

type st_1 from statictext within w_gtelar027
integer x = 905
integer y = 48
integer width = 430
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From && To Date"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtelar027
integer x = 2327
integer y = 32
integer width = 265
integer height = 100
integer taborder = 50
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


if rb_1.checked then
	dw_1.retrieve(left(ddlb_1.text,10),right(ddlb_1.text,10))
	if dw_1.rowcount() = 0  then
		messagebox('Alert!','No data found between the entered dates !!!')
		return 1
	end if
elseif rb_2.checked then
	dw_2.retrieve(left(ddlb_1.text,10),right(ddlb_1.text,10))
	if  dw_2.rowcount() = 0 then
		messagebox('Alert!','No data found between the entered dates !!!')
		return 1
	end if
end if

setpointer(arrow!)




end event

type cb_2 from commandbutton within w_gtelar027
integer x = 2592
integer y = 32
integer width = 265
integer height = 100
integer taborder = 60
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

type gb_1 from groupbox within w_gtelar027
integer x = 14
integer width = 837
integer height = 136
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_1 from datawindow within w_gtelar027
integer y = 136
integer width = 2939
integer height = 2056
string dataobject = "dw_gtelar027"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_gtelar027
integer y = 136
integer width = 2935
integer height = 2056
integer taborder = 30
string dataobject = "dw_gtelar027a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

