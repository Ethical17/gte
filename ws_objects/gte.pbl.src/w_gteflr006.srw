$PBExportHeader$w_gteflr006.srw
forward
global type w_gteflr006 from window
end type
type st_2 from statictext within w_gteflr006
end type
type dp_2 from datepicker within w_gteflr006
end type
type dp_1 from datepicker within w_gteflr006
end type
type rb_1 from radiobutton within w_gteflr006
end type
type st_1 from statictext within w_gteflr006
end type
type cb_1 from commandbutton within w_gteflr006
end type
type cb_2 from commandbutton within w_gteflr006
end type
type rb_4 from radiobutton within w_gteflr006
end type
type rb_3 from radiobutton within w_gteflr006
end type
type rb_2 from radiobutton within w_gteflr006
end type
type gb_1 from groupbox within w_gteflr006
end type
type gb_2 from groupbox within w_gteflr006
end type
type dw_1 from datawindow within w_gteflr006
end type
type dw_2 from datawindow within w_gteflr006
end type
end forward

global type w_gteflr006 from window
integer width = 4494
integer height = 2536
boolean titlebar = true
string title = "(Gteflr006) - Division/Section Wise Plucking Performance"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_2 st_2
dp_2 dp_2
dp_1 dp_1
rb_1 rb_1
st_1 st_1
cb_1 cb_1
cb_2 cb_2
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
gb_1 gb_1
gb_2 gb_2
dw_1 dw_1
dw_2 dw_2
end type
global w_gteflr006 w_gteflr006

type variables
long ll_year
double ld_teamade,ld_recper,ld_totgl
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
	case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_2)
			SetPointer (Arrow!)						
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
end if
end event

on w_gteflr006.create
this.st_2=create st_2
this.dp_2=create dp_2
this.dp_1=create dp_1
this.rb_1=create rb_1
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.gb_1=create gb_1
this.gb_2=create gb_2
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.st_2,&
this.dp_2,&
this.dp_1,&
this.rb_1,&
this.st_1,&
this.cb_1,&
this.cb_2,&
this.rb_4,&
this.rb_3,&
this.rb_2,&
this.gb_1,&
this.gb_2,&
this.dw_1,&
this.dw_2}
end on

on w_gteflr006.destroy
destroy(this.st_2)
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.rb_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_2.modify("t_co.text = '"+gs_co_name+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dp_1.value = datetime('01'+right(string(today(),'dd/mm/yyyy'),8))
end event

type st_2 from statictext within w_gteflr006
integer x = 2322
integer y = 48
integer width = 137
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To : "
alignment alignment = center!
boolean focusrectangle = false
end type

type dp_2 from datepicker within w_gteflr006
integer x = 2469
integer y = 32
integer width = 389
integer height = 100
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2016-03-01"), Time("12:52:33.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_gteflr006
integer x = 1915
integer y = 32
integer width = 389
integer height = 100
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2016-03-01"), Time("12:52:33.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type rb_1 from radiobutton within w_gteflr006
integer x = 41
integer y = 44
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Financial"
boolean checked = true
end type

type st_1 from statictext within w_gteflr006
integer x = 1536
integer y = 48
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
string text = "Period From : "
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gteflr006
integer x = 2875
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

if isnull(dp_1.text) or dp_1.text='00/00/0000' then
	messagebox('Warning','Please Enter The "From" Date !!!')
	return 
end if

if isnull(dp_2.text) or dp_2.text='00/00/0000' then
	messagebox('Warning','Please Enter The "To" Date !!!')
	return 
end if

if date(dp_1.text) > date(dp_2.text)  then
	messagebox('Warning ','The From Date Should be <= TO Date , Please check ...!')
	return 1
end if

string ls_year_ind,ls_frdt,ls_todt,ls_ysdt,ls_ly_frdt,ls_ly_todt,ls_ly_ysdt

if rb_1.checked then
	ls_year_ind = 'F' 
else
	ls_year_ind = 'C' 
end if

ls_frdt = dp_1.text 
ls_todt = dp_2.text

select decode(:ls_year_ind,'C','01/01/'||to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'),to_char(to_date((decode(sign(to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy')))||'0401'),'yyyymmdd'),'dd/mm/yyyy')),
		(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'dd/mm/')||to_char((to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1))),
		decode(substr(:ls_todt,1,5),'29/02',('28/02/'||(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1)), (to_char(to_date(:ls_todt,'dd/mm/yyyy'),'dd/mm/')||(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1))),
		decode(:ls_year_ind,'C','01/01/'||to_char((to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1)),to_char(to_date((decode(sign(to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-2,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1)||'0401'),'yyyymmdd'),'dd/mm/yyyy'))
  into :ls_ysdt,:ls_ly_frdt,:ls_ly_todt,:ls_ly_ysdt from dual;

if sqlca.sqlcode =-1 then
	messagebox('SQL Error During Date Select',sqlca.sqlerrtext)
	return 1
end if


ll_year = long(right(string(date(dp_1.text)),4))

select nvl(sum(nvl(GWTM_TEAMADE,0)),0) into :ld_teamade from fb_glforproduction a,fb_gardenwiseteamade b 
where a.GLFP_PK = b.GLFP_PK and GWTM_TYPE in ('N','O') and to_number(to_char(GLFP_PLUCKINGDATE,'YYYY')) = :ll_year and SUP_ID = :gs_supid;

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Total Teamade',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if
				
select sum(nvl(SPR_GL,0)) into :ld_totgl from fb_sectionpluckinground where to_number(to_char(SPR_DATE,'YYYY')) = :ll_year;
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Total Green Leaf',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

if isnull(ld_teamade) then ld_teamade = 0
if isnull(ld_totgl) then ld_totgl = 0
if ld_totgl = 0 then
	ld_recper = 0
else
	ld_recper = round(ld_teamade / ld_totgl * 100,2)
end if
if rb_3.checked then
	dw_2.show()
	dw_1.hide()
	dw_2.retrieve(ls_frdt,ls_todt,ls_ysdt,ld_recper)
elseif rb_4.checked then
	dw_1.show()
	dw_2.hide()	
	dw_1.retrieve(ls_frdt,ls_todt,ls_ysdt,ld_recper)
end if

setpointer(arrow!)

end event

type cb_2 from commandbutton within w_gteflr006
integer x = 3141
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

type rb_4 from radiobutton within w_gteflr006
integer x = 773
integer y = 44
integer width = 283
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Division"
boolean checked = true
end type

type rb_3 from radiobutton within w_gteflr006
integer x = 1070
integer y = 44
integer width = 379
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Prune Style"
end type

type rb_2 from radiobutton within w_gteflr006
integer x = 393
integer y = 44
integer width = 329
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Calender"
end type

type gb_1 from groupbox within w_gteflr006
integer x = 9
integer width = 731
integer height = 132
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year"
end type

type gb_2 from groupbox within w_gteflr006
integer x = 745
integer width = 754
integer height = 132
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

type dw_1 from datawindow within w_gteflr006
integer y = 144
integer width = 4416
integer height = 2056
string dataobject = "dw_gteflr006"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_gteflr006
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 144
integer width = 4416
integer height = 2056
string dataobject = "dw_gteflr006a"
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

