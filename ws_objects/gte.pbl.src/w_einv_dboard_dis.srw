$PBExportHeader$w_einv_dboard_dis.srw
forward
global type w_einv_dboard_dis from window
end type
type cb_2 from commandbutton within w_einv_dboard_dis
end type
type cb_1 from commandbutton within w_einv_dboard_dis
end type
type dp_2 from datepicker within w_einv_dboard_dis
end type
type st_3 from statictext within w_einv_dboard_dis
end type
type dp_1 from datepicker within w_einv_dboard_dis
end type
type st_2 from statictext within w_einv_dboard_dis
end type
type dw_1 from datawindow within w_einv_dboard_dis
end type
end forward

global type w_einv_dboard_dis from window
integer width = 3584
integer height = 2424
boolean titlebar = true
string title = "w_einv_dboard_dis"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dp_2 dp_2
st_3 st_3
dp_1 dp_1
st_2 st_2
dw_1 dw_1
end type
global w_einv_dboard_dis w_einv_dboard_dis

on w_einv_dboard_dis.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dp_2=create dp_2
this.st_3=create st_3
this.dp_1=create dp_1
this.st_2=create st_2
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dp_2,&
this.st_3,&
this.dp_1,&
this.st_2,&
this.dw_1}
end on

on w_einv_dboard_dis.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dp_2)
destroy(this.st_3)
destroy(this.dp_1)
destroy(this.st_2)
destroy(this.dw_1)
end on

type cb_2 from commandbutton within w_einv_dboard_dis
integer x = 1797
integer y = 8
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Close"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_einv_dboard_dis
integer x = 1531
integer y = 8
integer width = 265
integer height = 100
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

event clicked;string ls_unit_id

dw_1.settransobject(sqlca)

if len(trim(dp_1.text)) = 0 or isnull(dp_1.text) then
	messagebox ('From date is blank','please Enter the from date.')
	return
end if

if len(trim(dp_2.text)) = 0 or isnull(dp_2.text) then
	messagebox ('To date is blank','please Enter the To date.')
	return
end if

if date(dp_2.text) < date(dp_1.text) then
	messagebox ('Enter the correct To Date','To Date cannot be less than from date.')
	return
end if

// Active unit id fetch
select unit_id into :ls_unit_id from fb_gardenmaster where unit_active_ind='Y';

// Retrieve
dw_1.retrieve(ls_unit_id, dp_1.text, dp_2.text)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No data found between the entered dates !!!')
	return
end if
end event

type dp_2 from datepicker within w_einv_dboard_dis
integer x = 1056
integer y = 8
integer width = 357
integer height = 100
integer taborder = 20
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2026-03-09"), Time("10:16:24.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_3 from statictext within w_einv_dboard_dis
integer x = 923
integer y = 24
integer width = 160
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_einv_dboard_dis
integer x = 544
integer y = 8
integer width = 352
integer height = 100
integer taborder = 10
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2026-03-09"), Time("10:16:24.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_2 from statictext within w_einv_dboard_dis
integer x = 37
integer y = 24
integer width = 507
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From (dd/mm/yyyy):"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_einv_dboard_dis
integer x = 37
integer y = 136
integer width = 3131
integer height = 2004
string title = "none"
string dataobject = "dw_einv_dboard_dis"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

