$PBExportHeader$w_gtehrr012.srw
forward
global type w_gtehrr012 from window
end type
type rb_2 from radiobutton within w_gtehrr012
end type
type rb_1 from radiobutton within w_gtehrr012
end type
type st_3 from statictext within w_gtehrr012
end type
type cb_2 from commandbutton within w_gtehrr012
end type
type cb_1 from commandbutton within w_gtehrr012
end type
type ddlb_1 from dropdownlistbox within w_gtehrr012
end type
type gb_3 from groupbox within w_gtehrr012
end type
type dw_1 from datawindow within w_gtehrr012
end type
end forward

global type w_gtehrr012 from window
integer width = 3607
integer height = 2884
boolean titlebar = true
string title = "(w_gtehrr012) - Ration Distribution (Sub Staff)"
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
cb_2 cb_2
cb_1 cb_1
ddlb_1 ddlb_1
gb_3 gb_3
dw_1 dw_1
end type
global w_gtehrr012 w_gtehrr012

type variables
string ls_LWW_ID 
long ll_si,ll_pbno
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

on w_gtehrr012.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_3=create st_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.ddlb_1=create ddlb_1
this.gb_3=create gb_3
this.dw_1=create dw_1
this.Control[]={this.rb_2,&
this.rb_1,&
this.st_3,&
this.cb_2,&
this.cb_1,&
this.ddlb_1,&
this.gb_3,&
this.dw_1}
end on

on w_gtehrr012.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.ddlb_1)
destroy(this.gb_3)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_1.settransobject(sqlca)



setpointer(hourglass!)
string ls_dt, ls_period

ddlb_1.reset()

declare c1 cursor for
select distinct (to_char(RPFW_STARTDATE,'dd/mm/yyyy')||' ('||RPFW_ID||')') lww_id,RPFW_STARTDATE
  from fb_rationperiodforweek where RPFW_CALFLAG = '1' 
 order by RPFW_STARTDATE desc;

//select RPFW_ID,to_char(RPFW_ENDDATE,'dd/mm/yyyy') into :ls_lrw_id,:ls_to_dt
//   from fb_rationperiodforweek   where trunc(RPFW_STARTDATE) = to_date(:ls_fr_dt,'dd/mm/yyyy');
// order by rpfw_startdate desc

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

setpointer(arrow!)
end event

type rb_2 from radiobutton within w_gtehrr012
integer x = 507
integer y = 36
integer width = 389
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Subalvita"
end type

type rb_1 from radiobutton within w_gtehrr012
integer x = 41
integer y = 36
integer width = 389
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Main Boon"
boolean checked = true
end type

type st_3 from statictext within w_gtehrr012
integer x = 978
integer y = 28
integer width = 325
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ration Week"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gtehrr012
integer x = 2775
integer y = 12
integer width = 256
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Close"
end type

event clicked;Close(parent)
end event

type cb_1 from commandbutton within w_gtehrr012
integer x = 2519
integer y = 12
integer width = 256
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "OK"
end type

event clicked;if rb_1.checked then
		dw_1.settransobject(sqlca)
		dw_1.reset()
		dw_1.retrieve(left(right(ddlb_1.text,15),14),'MB')
		if dw_1.rowcount() = 0 then
			messagebox('Information!','No data Found !!!')
			return 1
		end if	
elseif rb_2.checked then
		dw_1.settransobject(sqlca)
		dw_1.reset()
		dw_1.retrieve(left(right(ddlb_1.text,15),14),'SU')
		if dw_1.rowcount() = 0 then
			messagebox('Information!','No data Found !!!')
			return 1
		end if	
end if
end event

type ddlb_1 from dropdownlistbox within w_gtehrr012
integer x = 1317
integer y = 16
integer width = 1147
integer height = 1104
integer taborder = 10
integer textsize = -8
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

type gb_3 from groupbox within w_gtehrr012
integer x = 9
integer width = 923
integer height = 120
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_1 from datawindow within w_gtehrr012
integer y = 120
integer width = 3552
integer height = 1924
integer taborder = 50
string dataobject = "dw_gtehrr012"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

