$PBExportHeader$w_gtedsr006.srw
forward
global type w_gtedsr006 from window
end type
type rb_2 from radiobutton within w_gtedsr006
end type
type rb_1 from radiobutton within w_gtedsr006
end type
type cb_1 from commandbutton within w_gtedsr006
end type
type st_2 from statictext within w_gtedsr006
end type
type dp_2 from datepicker within w_gtedsr006
end type
type dp_1 from datepicker within w_gtedsr006
end type
type st_1 from statictext within w_gtedsr006
end type
type cb_2 from commandbutton within w_gtedsr006
end type
type gb_1 from groupbox within w_gtedsr006
end type
type dw_1 from datawindow within w_gtedsr006
end type
type dw_2 from datawindow within w_gtedsr006
end type
end forward

global type w_gtedsr006 from window
integer width = 5961
integer height = 2312
boolean titlebar = true
string title = "(Gtedsr006) - Dispatch Register"
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
cb_1 cb_1
st_2 st_2
dp_2 dp_2
dp_1 dp_1
st_1 st_1
cb_2 cb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
end type
global w_gtedsr006 w_gtedsr006

type variables
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

on w_gtedsr006.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_1=create cb_1
this.st_2=create st_2
this.dp_2=create dp_2
this.dp_1=create dp_1
this.st_1=create st_1
this.cb_2=create cb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.rb_2,&
this.rb_1,&
this.cb_1,&
this.st_2,&
this.dp_2,&
this.dp_1,&
this.st_1,&
this.cb_2,&
this.gb_1,&
this.dw_1,&
this.dw_2}
end on

on w_gtedsr006.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_2.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dp_1.value = datetime('01'+right(string(today(),'dd/mm/yyyy'),8))
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_2.hide()
dw_1.show()

end event

type rb_2 from radiobutton within w_gtedsr006
integer x = 352
integer y = 36
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

event clicked;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_1.hide()
dw_2.show()
dw_2.reset()
dw_2.retrieve(dp_1.text,dp_2.text)
if dw_2.rowcount() = 0 then
	messagebox('Alert!','No Data Found Between The Entered Dates !!!')
	return 1
end if
end event

type rb_1 from radiobutton within w_gtedsr006
integer x = 41
integer y = 36
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

event clicked;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_2.hide()
dw_1.show()
dw_1.reset()
dw_1.retrieve(dp_1.text,dp_2.text)
if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found Between The Entered Dates !!!')
	return 1
end if
end event

type cb_1 from commandbutton within w_gtedsr006
integer x = 2350
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

setpointer(hourglass!)

if isnull(dp_1.text) or isnull(dp_2.text) or dp_1.text='00/00/0000' or dp_2.text = '00/00/0000' then
	messagebox('Warning','Please Enter From And To Date')
	return 
end if

if Date(dp_1.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','From Date Should Be <= Current Date  !!!')
	return 1
end if

if Date(dp_2.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','To Date Should Be <= Current Date  !!!')
	return 1
end if

if Date(dp_1.text) > Date(dp_2.text) then
	messagebox('Alert!','From Date Should Be <= Than To Date !!!')
	return 1
end if

if rb_1.checked then
	dw_1.show()
	dw_2.hide()
	dw_1.retrieve(dp_1.text,dp_2.text)
else
	dw_1.hide()
	dw_2.show()
	dw_2.retrieve(dp_1.text,dp_2.text)
end if

setpointer(arrow!)

if dw_1.rowcount() = 0 and dw_2.rowcount() = 0 then
	messagebox('Alert!','No Data Found Between The Entered Dates !!!')
	return 1
end if


end event

type st_2 from statictext within w_gtedsr006
integer x = 1582
integer y = 44
integer width = 229
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To Date :"
boolean focusrectangle = false
end type

type dp_2 from datepicker within w_gtedsr006
integer x = 1819
integer y = 24
integer width = 370
integer height = 100
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2021-05-12"), Time("13:26:43.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

event valuechanged;//string ls_frdt,ls_todt
//long ll_pbno
//
//ls_frdt = dp_1.text
//ls_todt = dp_2.text
//
//setpointer(hourglass!)
//
//ddlb_2.reset()
//ddlb_2.additem('ALL')
//
//declare c2 cursor for
//select distinct ls_id
// from FB_EMPLOYEE a, FB_LABOURDAILYATTENDANCE b 
// where  b.LABOUR_ID = a.emp_ID AND trunc(b.LDA_DATE) between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy') order by 1;
//
//open c2;
//
//IF sqlca.sqlcode = 0 THEN 
//	fetch c2 into :ll_pbno;
//	
//	do while sqlca.sqlcode <> 100
//		ddlb_2.additem(string(ll_pbno))
//		fetch c2 into:ll_pbno;
//	loop
//	close c2;
//end if
//
//ddlb_2.text = 'ALL'
//setpointer(arrow!)
end event

type dp_1 from datepicker within w_gtedsr006
integer x = 1152
integer y = 24
integer width = 370
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2021-05-12"), Time("13:26:43.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

event valuechanged;//string ls_frdt,ls_todt
//long ll_pbno
//
//ls_frdt = dp_1.text
//ls_todt = dp_2.text
//
//setpointer(hourglass!)
//
//ddlb_2.reset()
//ddlb_2.additem('ALL')
//
//declare c2 cursor for
//select distinct ls_id
// from FB_EMPLOYEE a, FB_LABOURDAILYATTENDANCE b 
// where  b.LABOUR_ID = a.emp_ID AND trunc(b.LDA_DATE) between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy') order by 1;
//
//open c2;
//
//IF sqlca.sqlcode = 0 THEN 
//	fetch c2 into :ll_pbno;
//	
//	do while sqlca.sqlcode <> 100
//		ddlb_2.additem(string(ll_pbno))
//		fetch c2 into:ll_pbno;
//	loop
//	close c2;
//end if
//
//ddlb_2.text = 'ALL'
//setpointer(arrow!)
end event

type st_1 from statictext within w_gtedsr006
integer x = 846
integer y = 44
integer width = 293
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Date : "
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gtedsr006
integer x = 2615
integer y = 24
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

type gb_1 from groupbox within w_gtedsr006
integer x = 14
integer width = 686
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

type dw_1 from datawindow within w_gtedsr006
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 128
integer width = 5486
integer height = 2056
string dataobject = "dw_gtedsr006"
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

type dw_2 from datawindow within w_gtedsr006
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 128
integer width = 3200
integer height = 2056
integer taborder = 60
string dataobject = "dw_gtedsr006a"
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

