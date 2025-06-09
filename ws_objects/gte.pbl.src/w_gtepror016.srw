$PBExportHeader$w_gtepror016.srw
forward
global type w_gtepror016 from window
end type
type rb_3 from radiobutton within w_gtepror016
end type
type st_2 from statictext within w_gtepror016
end type
type dp_2 from datepicker within w_gtepror016
end type
type dp_1 from datepicker within w_gtepror016
end type
type rb_2 from radiobutton within w_gtepror016
end type
type st_1 from statictext within w_gtepror016
end type
type cb_1 from commandbutton within w_gtepror016
end type
type cb_2 from commandbutton within w_gtepror016
end type
type rb_4 from radiobutton within w_gtepror016
end type
type rb_1 from radiobutton within w_gtepror016
end type
type gb_1 from groupbox within w_gtepror016
end type
type gb_2 from groupbox within w_gtepror016
end type
type dw_1 from datawindow within w_gtepror016
end type
type dw_2 from datawindow within w_gtepror016
end type
end forward

global type w_gtepror016 from window
integer width = 3730
integer height = 2404
boolean titlebar = true
string title = "(Gtepror016) - Productivity Report"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
rb_3 rb_3
st_2 st_2
dp_2 dp_2
dp_1 dp_1
rb_2 rb_2
st_1 st_1
cb_1 cb_1
cb_2 cb_2
rb_4 rb_4
rb_1 rb_1
gb_1 gb_1
gb_2 gb_2
dw_1 dw_1
dw_2 dw_2
end type
global w_gtepror016 w_gtepror016

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

on w_gtepror016.create
this.rb_3=create rb_3
this.st_2=create st_2
this.dp_2=create dp_2
this.dp_1=create dp_1
this.rb_2=create rb_2
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.rb_4=create rb_4
this.rb_1=create rb_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.rb_3,&
this.st_2,&
this.dp_2,&
this.dp_1,&
this.rb_2,&
this.st_1,&
this.cb_1,&
this.cb_2,&
this.rb_4,&
this.rb_1,&
this.gb_1,&
this.gb_2,&
this.dw_1,&
this.dw_2}
end on

on w_gtepror016.destroy
destroy(this.rb_3)
destroy(this.st_2)
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.rb_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.rb_4)
destroy(this.rb_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_2.modify("t_co.text = '"+gs_co_name+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dp_1.value = datetime('01'+right(string(today(),'dd/mm/yyyy'),8))
end event

type rb_3 from radiobutton within w_gtepror016
integer x = 389
integer y = 48
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
string text = "Summary"
end type

event clicked;dw_2.visible = true
dw_1.visible = false
end event

type st_2 from statictext within w_gtepror016
integer x = 2482
integer y = 52
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

type dp_2 from datepicker within w_gtepror016
integer x = 2629
integer y = 36
integer width = 389
integer height = 100
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2018-09-08"), Time("15:29:33.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_gtepror016
integer x = 2075
integer y = 36
integer width = 389
integer height = 100
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2018-09-08"), Time("15:29:33.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type rb_2 from radiobutton within w_gtepror016
integer x = 1157
integer y = 48
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

type st_1 from statictext within w_gtepror016
integer x = 1696
integer y = 52
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

type cb_1 from commandbutton within w_gtepror016
integer x = 3035
integer y = 36
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
		(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'dd/mm/')||(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1)),
		decode(:ls_year_ind,'C','01/01/'||to_char((to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1)),to_char(to_date((decode(sign(to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-2,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1)||'0401'),'yyyymmdd'),'dd/mm/yyyy'))
  into :ls_ysdt,:ls_ly_frdt,:ls_ly_todt,:ls_ly_ysdt from dual;

if sqlca.sqlcode =-1 then
	messagebox('SQL Error During Date Select',sqlca.sqlerrtext)
	return 1
end if

double ld_mdays, ld_ydays,ld_lmdays, ld_lydays

//select count(distinct GLFP_PLUCKINGDATE) into :ld_mdays  from fb_glforproduction where to_char(GLFP_PLUCKINGDATE,'YYYYMM') = substr(:ls_todt,7,4)||substr(:ls_todt,4,2) and trunc(GLFP_PLUCKINGDATE) < to_date(:ls_todt,'dd/mm/yyyy');

select sum(DDP_RUNHOURS) / count(distinct DRYER_ID)  into :ld_mdays  from fb_dailydryerproduct where trim(DRYER_ID) in (select distinct MACHINE_ID from fb_machine where trim(MACHINE_TYPE) = 'CTC') and to_char(trunc(DDP_STARTRUNTIME),'YYYYMM') = substr(:ls_todt,7,4)||substr(:ls_todt,4,2) and trunc(DDP_STARTRUNTIME) < to_date(:ls_todt,'dd/mm/yyyy');

select sum(DDP_RUNHOURS) / count(distinct DRYER_ID)  into :ld_ydays  from fb_dailydryerproduct where trim(DRYER_ID) in (select distinct MACHINE_ID from fb_machine where trim(MACHINE_TYPE) = 'CTC') and to_char(trunc(DDP_STARTRUNTIME),'YYYY') = substr(:ls_todt,7,4) and trunc(DDP_STARTRUNTIME) < to_date(:ls_todt,'dd/mm/yyyy');

select sum(DDP_RUNHOURS) / count(distinct DRYER_ID)  into :ld_lmdays  from fb_dailydryerproduct where trim(DRYER_ID) in (select distinct MACHINE_ID from fb_machine where trim(MACHINE_TYPE) = 'CTC') and to_char(trunc(DDP_STARTRUNTIME),'YYYYMM') = substr(:ls_ly_todt,7,4)||substr(:ls_ly_todt,4,2) and trunc(DDP_STARTRUNTIME) < to_date(:ls_ly_todt,'dd/mm/yyyy');

select sum(DDP_RUNHOURS) / count(distinct DRYER_ID)  into :ld_lydays  from fb_dailydryerproduct where trim(DRYER_ID) in (select distinct MACHINE_ID from fb_machine where trim(MACHINE_TYPE) = 'CTC') and to_char(trunc(DDP_STARTRUNTIME),'YYYY') = substr(:ls_ly_todt,7,4) and trunc(DDP_STARTRUNTIME) < to_date(:ls_ly_todt,'dd/mm/yyyy');

//select count(distinct GLFP_PLUCKINGDATE) into :ld_ydays from fb_glforproduction where to_char(GLFP_PLUCKINGDATE,'YYYY') = substr(:ls_todt,7,4) and trunc(GLFP_PLUCKINGDATE) < to_date(:ls_todt,'dd/mm/yyyy');

//select count(distinct GLFP_PLUCKINGDATE) into :ld_lmdays  from fb_glforproduction where to_char(GLFP_PLUCKINGDATE,'YYYYMM') = substr(:ls_ly_todt,7,4)||substr(:ls_ly_todt,4,2) and trunc(GLFP_PLUCKINGDATE) < to_date(:ls_ly_todt,'dd/mm/yyyy');
//
//select count(distinct GLFP_PLUCKINGDATE) into :ld_lydays from fb_glforproduction where to_char(GLFP_PLUCKINGDATE,'YYYY') = substr(:ls_ly_todt,7,4) and trunc(GLFP_PLUCKINGDATE) < to_date(:ls_ly_todt,'dd/mm/yyyy');


if rb_4.checked then
	dw_2.visible = false
	dw_1.visible = true	
	dw_1.retrieve(ls_frdt,ls_todt,ls_ysdt,ls_ly_frdt,ls_ly_todt,ls_ly_ysdt,ld_mdays,ld_ydays,ld_lmdays, ld_lydays)
elseif rb_3.checked then
	dw_1.visible = false
	dw_2.visible = true
	dw_2.retrieve(ls_frdt,ls_todt,ls_ysdt,ls_ly_frdt,ls_ly_todt,ls_ly_ysdt,ld_mdays,ld_ydays,ld_lmdays, ld_lydays)
end if

setpointer(arrow!)

end event

type cb_2 from commandbutton within w_gtepror016
integer x = 3301
integer y = 36
integer width = 265
integer height = 100
integer taborder = 70
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

type rb_4 from radiobutton within w_gtepror016
integer x = 78
integer y = 48
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detail"
boolean checked = true
end type

event clicked;dw_1.visible = true
dw_2.visible = false
end event

type rb_1 from radiobutton within w_gtepror016
integer x = 818
integer y = 48
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

type gb_1 from groupbox within w_gtepror016
integer x = 741
integer y = 4
integer width = 773
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
string text = "Year"
end type

type gb_2 from groupbox within w_gtepror016
integer x = 23
integer y = 4
integer width = 713
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
end type

type dw_1 from datawindow within w_gtepror016
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 144
integer width = 3639
integer height = 2028
string dataobject = "dw_gtepror016"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
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

type dw_2 from datawindow within w_gtepror016
event ue_leftbuttonup pbm_dwnlbuttonup
boolean visible = false
integer y = 144
integer width = 3639
integer height = 2028
integer taborder = 60
string dataobject = "dw_gtepror007_summ"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
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

