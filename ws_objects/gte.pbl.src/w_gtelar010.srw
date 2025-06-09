$PBExportHeader$w_gtelar010.srw
forward
global type w_gtelar010 from window
end type
type st_2 from statictext within w_gtelar010
end type
type ddlb_3 from dropdownlistbox within w_gtelar010
end type
type rb_6 from radiobutton within w_gtelar010
end type
type rb_5 from radiobutton within w_gtelar010
end type
type rb_4 from radiobutton within w_gtelar010
end type
type rb_3 from radiobutton within w_gtelar010
end type
type st_3 from statictext within w_gtelar010
end type
type st_1 from statictext within w_gtelar010
end type
type cb_2 from commandbutton within w_gtelar010
end type
type cb_1 from commandbutton within w_gtelar010
end type
type ddlb_2 from dropdownlistbox within w_gtelar010
end type
type ddlb_1 from dropdownlistbox within w_gtelar010
end type
type gb_2 from groupbox within w_gtelar010
end type
type gb_3 from groupbox within w_gtelar010
end type
type rb_2 from radiobutton within w_gtelar010
end type
type rb_1 from radiobutton within w_gtelar010
end type
type gb_1 from groupbox within w_gtelar010
end type
type dw_1 from datawindow within w_gtelar010
end type
type dw_4 from datawindow within w_gtelar010
end type
type dw_3 from datawindow within w_gtelar010
end type
type dw_2 from datawindow within w_gtelar010
end type
end forward

global type w_gtelar010 from window
integer width = 3899
integer height = 2156
boolean titlebar = true
string title = "(Gtelar010) - Ration Distribution"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_2 st_2
ddlb_3 ddlb_3
rb_6 rb_6
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
st_3 st_3
st_1 st_1
cb_2 cb_2
cb_1 cb_1
ddlb_2 ddlb_2
ddlb_1 ddlb_1
gb_2 gb_2
gb_3 gb_3
rb_2 rb_2
rb_1 rb_1
gb_1 gb_1
dw_1 dw_1
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
end type
global w_gtelar010 w_gtelar010

type variables
string ls_LWW_ID ,ls_field_id,ls_field
long ll_si,ll_pbno
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
elseif rb_2.checked and rb_3.checked then
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
elseif rb_2.checked and rb_4.checked then
	choose case gs_ueoption
		case "PRINT"
				OpenWithParm(w_print,this.dw_3)
		case "PRINTPREVIEW"
				this.dw_3.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_3.modify("datawindow.print.preview = no")
	case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_3)
			SetPointer (Arrow!)						
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
elseif rb_5.checked or rb_6.checked then
	choose case gs_ueoption
		case "PRINT"
				OpenWithParm(w_print,this.dw_4)
		case "PRINTPREVIEW"
				this.dw_4.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_4.modify("datawindow.print.preview = no")
	case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_4)
			SetPointer (Arrow!)						
		case "SAVEAS"
				this.dw_4.saveas()
		case "SFILTER"
				iu_powerfilter.checked = NOT iu_powerfilter.checked
				iu_powerfilter.event ue_clicked()
				m_main.m_file.m_filter.checked = iu_powerfilter.checked			
		case "FILTER"
				setnull(gs_filtertext)
				this.dw_4.setredraw(false)
				this.dw_4.setfilter(gs_filtertext)
				this.dw_4.filter()
				this.dw_4.groupcalc()
				if this.dw_4.rowcount() > 0 then;
					this.dw_4.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
		case "SORT"
				setnull(gs_sorttext)
				this.dw_4.setredraw(false)
				this.dw_4.setsort(gs_sorttext)
				this.dw_4.sort()
				this.dw_4.groupcalc()
				if this.dw_4.rowcount() > 0 then;
					this.dw_4.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
	end choose
end if	
end event

on w_gtelar010.create
this.st_2=create st_2
this.ddlb_3=create ddlb_3
this.rb_6=create rb_6
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.st_3=create st_3
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.ddlb_2=create ddlb_2
this.ddlb_1=create ddlb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.Control[]={this.st_2,&
this.ddlb_3,&
this.rb_6,&
this.rb_5,&
this.rb_4,&
this.rb_3,&
this.st_3,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.ddlb_2,&
this.ddlb_1,&
this.gb_2,&
this.gb_3,&
this.rb_2,&
this.rb_1,&
this.gb_1,&
this.dw_1,&
this.dw_4,&
this.dw_3,&
this.dw_2}
end on

on w_gtelar010.destroy
destroy(this.st_2)
destroy(this.ddlb_3)
destroy(this.rb_6)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.ddlb_2)
destroy(this.ddlb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_1.settransobject(sqlca)

dw_2.modify("t_co.text = '"+gs_co_name+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_2.settransobject(sqlca)
dw_3.modify("t_co.text = '"+gs_co_name+"'")
dw_3.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_3.settransobject(sqlca)
dw_4.modify("t_co.text = '"+gs_co_name+"'")
dw_4.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_4.settransobject(sqlca)


setpointer(hourglass!)
string ls_dt, ls_period

if gs_garden_snm <> 'FB' then
	dw_1.visible = true
	dw_4.visible = false
	gb_3.visible = false
	rb_5.visible = false
	rb_6.visible = false		
	gb_1.visible = true
	rb_1.visible = true
	rb_2.visible = true
elseif gs_garden_snm = 'FB' then
	st_1.visible = false
	ddlb_2.visible = false
	dw_4.visible = true
	dw_1.visible = false
	gb_1.visible = false
	rb_1.visible = false
	rb_2.visible = false
	rb_1.checked = false
	gb_2.visible = false
	rb_3.visible = false
	rb_4.visible = false	
	gb_3.visible = true
	rb_5.visible = true
	rb_6.visible = true	
end if


ddlb_1.reset()

declare c1 cursor for
select distinct (to_char(RPFW_STARTDATE,'dd/mm/yyyy')||' - '||to_char(RPFW_ENDDATE,'dd/mm/yyyy')||' ('||RPFW_ID||')') lww_id,rpfw_startdate
   from fb_labourweeklyration a, fb_rationperiodforweek b 
   where a.LRW_ID = b.RPFW_ID
 order by rpfw_startdate desc;

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


ddlb_3.reset( )

ddlb_3.additem('00-ALL')

declare c2 cursor for
select distinct field_name || ' (' ||FIELD_ID ||')' from fb_field order by substr(field_name || ' (' ||FIELD_ID ||')',-6,6);

open c2;
IF sqlca.sqlcode = 0 THEN 
		fetch c2 into :ls_field;
	do while sqlca.sqlcode <> 100
		ddlb_3.additem(ls_field)
		setnull(ls_field);
		fetch c2 into :ls_field;
	loop
	close c2;
end if

rb_3.visible = false
rb_4.visible = false
gb_2.visible = false

setpointer(arrow!)

end event

type st_2 from statictext within w_gtelar010
integer x = 2418
integer y = 28
integer width = 233
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Field ID"
boolean focusrectangle = false
end type

type ddlb_3 from dropdownlistbox within w_gtelar010
integer x = 2674
integer y = 12
integer width = 1147
integer height = 1104
integer taborder = 50
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

event selectionchanged;
setpointer(hourglass!)
setnull(ls_LWW_ID)

ls_LWW_ID = left(right(ddlb_1.text,15),14)
ls_field_id = left(right(ddlb_3.text,6),5)

ddlb_2.reset( )

ddlb_2.additem('00-ALL')

declare c3 cursor for
select distinct a.ls_id
   from FB_EMPLOYEE a, fb_labourweeklyration c 
   where a.emp_id = c.LABOUR_ID and c.LRW_ID = :ls_LWW_ID and a.field_id = decode(substr(:ls_field_id,1,2),'00',a.field_id,:ls_field_id)
 order by 1;

open c3;
IF sqlca.sqlcode = 0 THEN 
	fetch c3 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ll_pbno))
		fetch c3 into:ll_pbno;
	loop
	close c3;
end if

setpointer(arrow!)

end event

type rb_6 from radiobutton within w_gtelar010
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

event clicked;dw_1.visible=false
dw_2.visible=false
dw_3.visible=false
dw_4.visible=true
end event

type rb_5 from radiobutton within w_gtelar010
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

event clicked;dw_1.visible=false
dw_2.visible=false
dw_3.visible=false
dw_4.visible=true
end event

type rb_4 from radiobutton within w_gtelar010
integer x = 466
integer y = 140
integer width = 384
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Without Gap"
end type

event clicked;dw_1.visible=false
dw_2.visible=false
dw_3.visible=true
dw_4.visible=false
end event

type rb_3 from radiobutton within w_gtelar010
integer x = 41
integer y = 140
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "With Gap"
boolean checked = true
end type

event clicked;dw_1.visible=false
dw_2.visible=true
dw_3.visible=false
dw_4.visible=false


end event

type st_3 from statictext within w_gtelar010
integer x = 978
integer width = 233
integer height = 116
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Labour Weeks"
boolean focusrectangle = false
end type

type st_1 from statictext within w_gtelar010
integer x = 969
integer y = 144
integer width = 343
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pay Book No:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gtelar010
integer x = 1961
integer y = 120
integer width = 256
integer height = 100
integer taborder = 40
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

type cb_1 from commandbutton within w_gtelar010
integer x = 1705
integer y = 120
integer width = 256
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "OK"
end type

event clicked;if(ddlb_3.text = '00-ALL') then
	ls_field_id = '00'
else
	ls_field_id = left(right(ddlb_3.text,6),5)
end if

if rb_1.checked then
	dw_1.settransobject(sqlca)
	dw_1.retrieve(left(right(ddlb_1.text,15),14),long(left(ddlb_2.text,2)),ls_field_id)
	//dw_1.retrieve(left(right(ddlb_1.text,9),8),long(left(ddlb_2.text,2)))
	if dw_1.rowcount() = 0 then
		messagebox('Information!','No data Found !!!')
		return 1
	end if
elseif rb_2.checked then
	if rb_3.checked then
		dw_2.settransobject(sqlca)
		dw_2.retrieve(left(right(ddlb_1.text,15),14),long(left(ddlb_2.text,2)),ls_field_id)
		if dw_2.rowcount() = 0 then
			messagebox('Information!','No data Found !!!')
			return 1
		end if
	elseif rb_4.checked then
		dw_3.settransobject(sqlca)
		dw_3.retrieve(left(right(ddlb_1.text,15),14),long(left(ddlb_2.text,2)),ls_field_id)
		if dw_3.rowcount() = 0 then
			messagebox('Information!','No data Found !!!')
			return 1
		end if
	end if
elseif rb_5.checked then
		dw_4.settransobject(sqlca)
		dw_4.reset()
		dw_4.retrieve(left(right(ddlb_1.text,15),14),'MB')
		if dw_4.rowcount() = 0 then
			messagebox('Information!','No data Found !!!')
			return 1
		end if	
elseif rb_6.checked then
		dw_4.settransobject(sqlca)
		dw_4.reset()
		dw_4.retrieve(left(right(ddlb_1.text,15),14),'SU')
		if dw_4.rowcount() = 0 then
			messagebox('Information!','No data Found !!!')
			return 1
		end if	
end if
end event

type ddlb_2 from dropdownlistbox within w_gtelar010
integer x = 1358
integer y = 128
integer width = 334
integer height = 1104
integer taborder = 20
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

type ddlb_1 from dropdownlistbox within w_gtelar010
integer x = 1225
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

event selectionchanged;
setpointer(hourglass!)
setnull(ls_LWW_ID)

ls_LWW_ID = left(right(ddlb_1.text,15),14)

ddlb_3.reset( )

ddlb_3.additem('00-ALL')

declare c2 cursor for
select distinct b.field_name || ' (' ||a.FIELD_ID ||')'
   from FB_EMPLOYEE a, fb_labourweeklyration c,fb_field b
   where a.emp_id = c.LABOUR_ID and a.field_id = b.field_id and c.LRW_ID = :ls_LWW_ID
 order by substr(b.field_name || ' (' ||a.FIELD_ID ||')',-6,6);

open c2;
IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ls_field;
	
	do while sqlca.sqlcode <> 100
		ddlb_3.additem(string(ls_field))
		fetch c2 into:ls_field;
	loop
	close c2;
end if

setpointer(arrow!)

end event

type gb_2 from groupbox within w_gtelar010
integer x = 5
integer y = 104
integer width = 919
integer height = 124
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_3 from groupbox within w_gtelar010
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

type rb_2 from radiobutton within w_gtelar010
integer x = 544
integer y = 32
integer width = 352
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Book Wise"
end type

event clicked;if rb_3.checked = true then
	dw_2.visible=true
	dw_1.visible=false
	dw_3.visible=false
	dw_4.visible=false
elseif rb_4.checked = true then
	dw_3.visible=true
	dw_1.visible=false
	dw_2.visible=false
	dw_4.visible=false
end if

gb_2.visible = true
rb_3.visible = true
rb_4.visible = true

end event

type rb_1 from radiobutton within w_gtelar010
integer x = 27
integer y = 32
integer width = 530
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ration Card Wise"
boolean checked = true
end type

event clicked;dw_1.visible=true
dw_2.visible=false
dw_3.visible=false
dw_4.visible=false

rb_3.visible = false
rb_4.visible = false
gb_2.visible = false
end event

type gb_1 from groupbox within w_gtelar010
integer x = 9
integer width = 923
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

type dw_1 from datawindow within w_gtelar010
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 224
integer width = 3849
integer height = 1924
string dataobject = "dw_gtelar010"
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

type dw_4 from datawindow within w_gtelar010
boolean visible = false
integer y = 224
integer width = 3849
integer height = 1924
integer taborder = 50
string dataobject = "dw_gtelar010dw"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_gtelar010
boolean visible = false
integer y = 224
integer width = 3849
integer height = 1924
integer taborder = 40
string dataobject = "dw_gtelar010cw"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_gtelar010
boolean visible = false
integer y = 224
integer width = 3849
integer height = 1924
integer taborder = 30
string dataobject = "dw_gtelar010bw"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

