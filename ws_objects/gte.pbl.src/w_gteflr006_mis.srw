$PBExportHeader$w_gteflr006_mis.srw
forward
global type w_gteflr006_mis from window
end type
type st_2 from statictext within w_gteflr006_mis
end type
type dp_2 from datepicker within w_gteflr006_mis
end type
type dp_1 from datepicker within w_gteflr006_mis
end type
type rb_1 from radiobutton within w_gteflr006_mis
end type
type st_1 from statictext within w_gteflr006_mis
end type
type cb_1 from commandbutton within w_gteflr006_mis
end type
type cb_2 from commandbutton within w_gteflr006_mis
end type
type rb_4 from radiobutton within w_gteflr006_mis
end type
type rb_3 from radiobutton within w_gteflr006_mis
end type
type rb_2 from radiobutton within w_gteflr006_mis
end type
type gb_1 from groupbox within w_gteflr006_mis
end type
type gb_2 from groupbox within w_gteflr006_mis
end type
type dw_1 from datawindow within w_gteflr006_mis
end type
end forward

global type w_gteflr006_mis from window
integer width = 4603
integer height = 2848
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
end type
global w_gteflr006_mis w_gteflr006_mis

type variables
long ll_year,ll_lyear, ll_pyear
double ld_teamade,ld_teamade_ly, ld_teamade_py, ld_recper_td,ld_recper_tdt, ld_recper_td_ly,ld_recper_tdt_ly, ld_recper_td_py,ld_recper_tdt_py
double ld_ar_ly, ld_arcov_ly, ld_arcov_todt_ly, ld_mdays_ly, ld_totalgl_ly, ld_mdays_todt_ly, ld_totgl_todt_ly, ld_cnt_ly
double ld_ar_py, ld_arcov_py, ld_arcov_todt_py, ld_mdays_py, ld_totalgl_py, ld_mdays_todt_py, ld_totgl_todt_py, ld_cnt_py
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
//elseif dw_2.visible = true then
//	choose case gs_ueoption
//	case "PRINT"
//			OpenWithParm(w_print,this.dw_2)
//	case "PRINTPREVIEW"
//			this.dw_2.modify("datawindow.print.preview = yes")
//	case "ZOOM"
//			SetPointer (HourGlass!)											
//			OpenwithParm (w_zoom,dw_2)
//			SetPointer (Arrow!)						
//	case "RESETPREVIEW"
//			this.dw_2.modify("datawindow.print.preview = no")
//	case "SAVEAS"
//			this.dw_2.saveas()
//	case "SFILTER"
//			iu_powerfilter.checked = NOT iu_powerfilter.checked
//			iu_powerfilter.event ue_clicked()
//			m_main.m_file.m_filter.checked = iu_powerfilter.checked			
//	case "FILTER"
//			setnull(gs_filtertext)
//			this.dw_2.setredraw(false)
//			this.dw_2.setfilter(gs_filtertext)
//			this.dw_2.filter()
//			this.dw_2.groupcalc()
//			if this.dw_2.rowcount() > 0 then;
//				this.dw_2.setredraw(true)
//			else
//				Messagebox('Warning','Data Not Available In Given Criteria')
//			end if
//	case "SORT"
//			setnull(gs_sorttext)
//			this.dw_2.setredraw(false)
//			this.dw_2.setsort(gs_sorttext)
//			this.dw_2.sort()
//			this.dw_2.groupcalc()
//			if this.dw_2.rowcount() > 0 then;
//				this.dw_2.setredraw(true)
//			else
//				Messagebox('Warning','Data Not Available In Given Criteria')
//			end if
//	end choose
end if
end event

on w_gteflr006_mis.create
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
this.dw_1}
end on

on w_gteflr006_mis.destroy
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
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
//dw_2.modify("t_co.text = '"+gs_co_name+"'")
//dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dp_1.value = datetime('01'+right(string(today(),'dd/mm/yyyy'),8))
end event

type st_2 from statictext within w_gteflr006_mis
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

type dp_2 from datepicker within w_gteflr006_mis
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
datetime value = DateTime(Date("2016-03-03"), Time("08:48:49.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_gteflr006_mis
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
datetime value = DateTime(Date("2016-03-03"), Time("08:48:49.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type rb_1 from radiobutton within w_gteflr006_mis
boolean visible = false
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
end type

type st_1 from statictext within w_gteflr006_mis
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

type cb_1 from commandbutton within w_gteflr006_mis
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
//dw_2.settransobject(sqlca)

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

string ls_year_ind,ls_frdt,ls_todt,ls_ysdt,ra_frdt_ly,ra_todt_ly,ra_ysdt_ly,ra_frdt_py,ra_todt_py,ra_ysdt_py
double ld_tm_today, ld_tm_todate,ld_tm_today_ly,ld_tm_todate_ly,ld_tm_today_py,ld_tm_todate_py 
double ld_gltoday,ld_gltodate, ld_gltoday_ly,ld_gltodate_ly, ld_gltoday_py,ld_gltodate_py

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
		decode(:ls_year_ind,'C','01/01/'||to_char((to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1)),to_char(to_date((decode(sign(to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-2,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1)||'0401'),'yyyymmdd'),'dd/mm/yyyy')),
		(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'dd/mm/')||to_char((to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-2))),
		decode(substr(:ls_todt,1,5),'29/02',('28/02/'||(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-2)), (to_char(to_date(:ls_todt,'dd/mm/yyyy'),'dd/mm/')||(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-2))),
		decode(:ls_year_ind,'C','01/01/'||to_char((to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-2)),to_char(to_date((decode(sign(to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-3,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-2)||'0401'),'yyyymmdd'),'dd/mm/yyyy'))
  into :ls_ysdt,:ra_frdt_ly, :ra_todt_ly, :ra_ysdt_ly, :ra_frdt_py, :ra_todt_py, :ra_ysdt_py from dual;

if sqlca.sqlcode =-1 then
	messagebox('SQL Error During Date Select',sqlca.sqlerrtext)
	return 1
end if


ll_year = long(right(string(date(dp_1.text)),4))
ll_lyear = long(right(string(date(dp_1.text)),4)) -1
ll_pyear= long(right(string(date(dp_1.text)),4)) - 2

select sum(decode(sign(GLFP_PLUCKINGDATE - to_date(:ls_frdt,'dd/mm/yyyy')),-1,0,decode(sign(GLFP_PLUCKINGDATE - to_date(:ls_todt,'dd/mm/yyyy')),1,0,nvl(GWTM_TEAMADE,0)))),
		sum(decode(sign(GLFP_PLUCKINGDATE - to_date(:ls_ysdt,'dd/mm/yyyy')),-1,0,decode(sign(GLFP_PLUCKINGDATE - to_date(:ls_todt,'dd/mm/yyyy')),1,0,nvl(GWTM_TEAMADE,0))))
  into :ld_tm_today,:ld_tm_todate 
from fb_glforproduction a,fb_gardenwiseteamade b 
where a.GLFP_PK = b.GLFP_PK and (GWTM_TYPE in ('O') or (GWTM_TYPE in ('N','E') and SUP_ID = :gs_supid)) and 
		trunc(GLFP_PLUCKINGDATE) between to_date(:ls_ysdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy');

//select nvl(sum(nvl(GWTM_TEAMADE,0)),0) into :ld_teamade from fb_glforproduction a,fb_gardenwiseteamade b 
//where a.GLFP_PK = b.GLFP_PK and GWTM_TYPE in ('N','O') and to_number(to_char(GLFP_PLUCKINGDATE,'YYYY')) = :ll_year and SUP_ID = :gs_supid;

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Total Teamade',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

select sum(decode(sign(GLFP_PLUCKINGDATE - to_date(:ra_frdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(GLFP_PLUCKINGDATE - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,nvl(GWTM_TEAMADE,0)))),
		sum(decode(sign(GLFP_PLUCKINGDATE - to_date(:ra_ysdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(GLFP_PLUCKINGDATE - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,nvl(GWTM_TEAMADE,0))))
  into :ld_tm_today_ly,:ld_tm_todate_ly
from fb_glforproduction a,fb_gardenwiseteamade b 
where a.GLFP_PK = b.GLFP_PK and (GWTM_TYPE in ('O') or (GWTM_TYPE in ('N','E') and SUP_ID = :gs_supid)) and 
		trunc(GLFP_PLUCKINGDATE) between to_date(:ra_ysdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy');

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Total Teamade',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

select sum(decode(sign(GLFP_PLUCKINGDATE - to_date(:ra_frdt_py,'dd/mm/yyyy')),-1,0,decode(sign(GLFP_PLUCKINGDATE - to_date(:ra_todt_py,'dd/mm/yyyy')),1,0,nvl(GWTM_TEAMADE,0)))),
		sum(decode(sign(GLFP_PLUCKINGDATE - to_date(:ra_ysdt_py,'dd/mm/yyyy')),-1,0,decode(sign(GLFP_PLUCKINGDATE - to_date(:ra_todt_py,'dd/mm/yyyy')),1,0,nvl(GWTM_TEAMADE,0))))
  into :ld_tm_today_py,:ld_tm_todate_py 
from fb_glforproduction a,fb_gardenwiseteamade b 
where a.GLFP_PK = b.GLFP_PK and (GWTM_TYPE in ('O') or (GWTM_TYPE in ('N','E') and SUP_ID = :gs_supid)) and 
		trunc(GLFP_PLUCKINGDATE) between to_date(:ra_ysdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy');
		
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Total Teamade',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if
				
//select sum(nvl(SPR_GL,0)) into :ld_totgl from fb_sectionpluckinground where to_number(to_char(SPR_DATE,'YYYY')) = :ll_year;

SELECT sum(decode(sign(glt.pluckingdate - to_date(:ls_frdt,'dd/mm/yyyy')),-1,0,decode(sign(glt.pluckingdate - to_date(:ls_todt,'dd/mm/yyyy')),1,0,nvl(glt.gt_quantity,0)))) ctoday, 
 	 	   sum(decode(sign(glt.pluckingdate - to_date(:ls_ysdt,'dd/mm/yyyy')),-1,0,decode(sign(glt.pluckingdate - to_date(:ls_todt,'dd/mm/yyyy')),1,0,nvl(glt.gt_quantity,0)))) ctodate
   into :ld_gltoday,:ld_gltodate
  FROM fb_gltransaction glt, fb_supplier sup
WHERE glt.sup_id = sup.sup_id AND glt.gt_type in ('OWNATTE' ,'OWNUSER')    and NVL (glt.gt_quantity, 0) > 0    and
		  glt.pluckingdate between to_date(:ls_ysdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy') ;
		  
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Total Green Leaf',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

SELECT sum(decode(sign(glt.pluckingdate - to_date(:ra_frdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(glt.pluckingdate - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,nvl(glt.gt_quantity,0)))) ctoday, 
 	 	   sum(decode(sign(glt.pluckingdate - to_date(:ra_ysdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(glt.pluckingdate - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,nvl(glt.gt_quantity,0)))) ctodate
   into :ld_gltoday_ly,:ld_gltodate_ly
  FROM fb_gltransaction glt, fb_supplier sup
WHERE glt.sup_id = sup.sup_id AND glt.gt_type in ('OWNATTE' ,'OWNUSER')   and NVL (glt.gt_quantity, 0) > 0    and
		  glt.pluckingdate between to_date(:ra_ysdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy') ;
		  
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Total Green Leaf',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

SELECT sum(decode(sign(glt.pluckingdate - to_date(:ra_frdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(glt.pluckingdate - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,nvl(glt.gt_quantity,0)))) ctoday, 
 	 	   sum(decode(sign(glt.pluckingdate - to_date(:ra_ysdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(glt.pluckingdate - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,nvl(glt.gt_quantity,0)))) ctodate
   into :ld_gltoday_py,:ld_gltodate_py
  FROM fb_gltransaction glt, fb_supplier sup
WHERE glt.sup_id = sup.sup_id AND glt.gt_type in ('OWNATTE' ,'OWNUSER')   and NVL (glt.gt_quantity, 0) > 0    and
		  glt.pluckingdate between to_date(:ra_ysdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy') ;
		  
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Total Green Leaf',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

if isnull(ld_tm_today) then ld_tm_today = 0
if isnull(ld_tm_todate) then ld_tm_todate = 0
if isnull(ld_gltoday) then ld_gltoday = 0
if isnull(ld_gltodate) then ld_gltodate = 0

if ld_gltoday = 0 then
	ld_recper_td = 0
else
	ld_recper_td = round((ld_tm_today / ld_gltoday ) * 100,2)
end if

if ld_gltodate = 0 then
	ld_recper_tdt = 0
else
	ld_recper_tdt = round((ld_tm_todate / ld_gltodate ) * 100,2)
end if

if isnull(ld_tm_today_ly) then ld_tm_today_ly = 0
if isnull(ld_tm_todate_ly) then ld_tm_todate_ly = 0
if isnull(ld_gltoday_ly) then ld_gltoday_ly = 0
if isnull(ld_gltodate_ly) then ld_gltodate_ly = 0

if ld_gltoday_ly = 0 then
	ld_recper_td_ly = 0
else
	ld_recper_td_ly = round((ld_tm_today_ly / ld_gltoday_ly ) * 100,2)
end if

if ld_gltodate_ly = 0 then
	ld_recper_tdt_ly = 0
else
	ld_recper_tdt_ly = round((ld_tm_todate_ly / ld_gltodate_ly ) * 100,2)
end if

if isnull(ld_tm_today_py) then ld_tm_today_py = 0
if isnull(ld_tm_todate_py) then ld_tm_todate_py = 0
if isnull(ld_gltoday_py) then ld_gltoday_py = 0
if isnull(ld_gltodate_py) then ld_gltodate_py = 0

if ld_gltoday_py = 0 then
	ld_recper_td_py = 0
else
	ld_recper_td_py = round((ld_tm_today_py / ld_gltoday_py ) * 100,2)
end if

if ld_gltodate_py = 0 then
	ld_recper_tdt_py = 0
else
	ld_recper_tdt_py = round((ld_tm_todate_py / ld_gltodate_py ) * 100,2)
end if



//SELECT  sum(decode(sign(TASK_DATE - to_date(:ra_frdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(TASK_DATE - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,nvl(areacovered,0)))) areacovered,
//           sum(decode(sign(TASK_DATE - to_date(:ra_ysdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(TASK_DATE - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,nvl(areacovered,0)))) areacovered_todate,
//           sum(decode(sign(TASK_DATE - to_date(:ra_frdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(TASK_DATE - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,(nvl(c.TASK_PMATODAYTY,0) + nvl(c.TASK_PFATODAYTY,0) + nvl(c.TASK_TMATODAYTY,0) + nvl(c.TASK_TFATODAYTY,0) + nvl(c.TASK_OMATODAYTY,0) + nvl(c.TASK_OFATODAYTY,0) + 
//            ((nvl(c.TASK_PMADTODAYTY,0) + nvl(c.TASK_PFADTODAYTY,0) + nvl(c.TASK_PMCTODAYTY,0) + nvl(c.TASK_PFCTODAYTY,0) +
//              nvl(c.TASK_TMADTODAYTY,0) + nvl(c.TASK_TFADTODAYTY,0) + nvl(c.TASK_TMCTODAYTY,0) + nvl(c.TASK_TFCTODAYTY,0) +
//              nvl(c.TASK_OMADTODAYTY,0) + nvl(c.TASK_OFADTODAYTY,0) + nvl(c.TASK_OMCTODAYTY,0) + nvl(c.TASK_OFCTODAYTY,0)) * 0.5))))) mandays,
//            sum(decode(sign(TASK_DATE - to_date(:ra_frdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(TASK_DATE - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,(nvl(f.TASK_PMACOUNTTODAYTY,0) + nvl(f.TASK_PFACOUNTTODAYTY,0) + nvl(f.TASK_TMACOUNTTODAYTY,0) + nvl(f.TASK_TFACOUNTTODAYTY,0) + 
//            nvl(f.TASK_OMACOUNTTODAYTY,0) + nvl(f.TASK_OFACOUNTTODAYTY,0) + nvl(f.TASK_PMADCOUNTTODAYTY,0) + nvl(f.TASK_PFADCOUNTTODAYTY,0) + 
//            nvl(f.TASK_TMADCOUNTTODAYTY,0) + nvl(f.TASK_TFADCOUNTTODAYTY,0) + nvl(f.TASK_OMADCOUNTTODAYTY,0) + nvl(f.TASK_OFADCOUNTTODAYTY,0) + 
//            nvl(f.TASK_PMCCOUNTTODAYTY,0) + nvl(f.TASK_PFCCOUNTTODAYTY,0) + nvl(f.TASK_TMCCOUNTTODAYTY,0) + nvl(f.TASK_TFCCOUNTTODAYTY,0) + 
//            nvl(f.TASK_OMCCOUNTTODAYTY,0) + nvl(f.TASK_OFCCOUNTTODAYTY,0)))))  totalgl,
//           sum(decode(sign(TASK_DATE - to_date(:ra_ysdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(TASK_DATE - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,(nvl(c.TASK_PMATODAYTY,0) + nvl(c.TASK_PFATODAYTY,0) + nvl(c.TASK_TMATODAYTY,0) + nvl(c.TASK_TFATODAYTY,0) + nvl(c.TASK_OMATODAYTY,0) + nvl(c.TASK_OFATODAYTY,0) + 
//            ((nvl(c.TASK_PMADTODAYTY,0) + nvl(c.TASK_PFADTODAYTY,0) + nvl(c.TASK_PMCTODAYTY,0) + nvl(c.TASK_PFCTODAYTY,0) +
//              nvl(c.TASK_TMADTODAYTY,0) + nvl(c.TASK_TFADTODAYTY,0) + nvl(c.TASK_TMCTODAYTY,0) + nvl(c.TASK_TFCTODAYTY,0) +
//              nvl(c.TASK_OMADTODAYTY,0) + nvl(c.TASK_OFADTODAYTY,0) + nvl(c.TASK_OMCTODAYTY,0) + nvl(c.TASK_OFCTODAYTY,0)) * 0.5))))) mandays_todate,
//            sum(decode(sign(TASK_DATE - to_date(:ra_ysdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(TASK_DATE - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,(nvl(f.TASK_PMACOUNTTODAYTY,0) + nvl(f.TASK_PFACOUNTTODAYTY,0) + nvl(f.TASK_TMACOUNTTODAYTY,0) + nvl(f.TASK_TFACOUNTTODAYTY,0) + 
//            nvl(f.TASK_OMACOUNTTODAYTY,0) + nvl(f.TASK_OFACOUNTTODAYTY,0) + nvl(f.TASK_PMADCOUNTTODAYTY,0) + nvl(f.TASK_PFADCOUNTTODAYTY,0) + 
//            nvl(f.TASK_TMADCOUNTTODAYTY,0) + nvl(f.TASK_TFADCOUNTTODAYTY,0) + nvl(f.TASK_OMADCOUNTTODAYTY,0) + nvl(f.TASK_OFADCOUNTTODAYTY,0) + 
//            nvl(f.TASK_PMCCOUNTTODAYTY,0) + nvl(f.TASK_PFCCOUNTTODAYTY,0) + nvl(f.TASK_TMCCOUNTTODAYTY,0) + nvl(f.TASK_TFCCOUNTTODAYTY,0) + 
//            nvl(f.TASK_OMCCOUNTTODAYTY,0) + nvl(f.TASK_OFCCOUNTTODAYTY,0)))))  totalgl_todate
//into :ld_arcov_ly, :ld_arcov_todt_ly, :ld_mdays_ly, :ld_totalgl_ly, :ld_mdays_todt_ly, :ld_totgl_todt_ly				
//FROM FB_FIELD a, FB_SECTION b, FB_TASKACTIVEDAILY c, 
//        (select * from FB_PRUNINGSESSION where PRUN_YEAR =  to_number(to_char(to_date(:ra_frdt_ly,'dd/mm/yyyy'),'YYYY'))) d,
//         FB_KAMSUBHEAD e, FB_TASKACTIVEMEASUREMENT f, 
//         FB_SECTIONPLUCKINGROUND g,
//        (SELECT SECTION_ID, SUM(nvl(SPR_AREACOVERED,0)) areacovered FROM FB_SECTIONPLUCKINGROUND WHERE trunc(SPR_DATE) between to_date(:ra_ysdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy') group by SECTION_ID) h
//WHERE  a.FIELD_ID = b.FIELD_ID AND b.SECTION_ID = c.SECTION_ID AND b.SECTION_ID = d.SECTION_ID(+) AND nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and
//            c.TASK_ID = e.KAMSUB_ID AND c.TASKDATE_ID = f.TASKSECTION_ID AND c.TASK_DATE = g.SPR_DATE (+) AND 
//            c.SECTION_ID = g.SECTION_ID (+) AND e.KAMSUB_TYPE = 'PLUCK' AND b.SECTION_ID = h.SECTION_ID(+)  and
//            TASK_DATE between to_date(:ra_ysdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy');

SELECT  sum(nvl(b.SECTION_AREA,0)) sectionarea, sum(nvl(areacovered,0)) areacovered,sum(nvl(areacovered_todate,0)) areacovered_todate,
           sum(nvl(mandays,0)) mandays, sum(nvl(totalgl,0)) totalgl, sum(nvl(mandays_todate,0)) mandays_todate, sum(nvl(totalgl_todate,0)) totalgl_todate,sum(to_number(SECTION_ACTUALPLANTS))/sum(nvl(b.SECTION_AREA,0))
into :ld_ar_ly,:ld_arcov_ly, :ld_arcov_todt_ly, :ld_mdays_ly, :ld_totalgl_ly, :ld_mdays_todt_ly, :ld_totgl_todt_ly,:ld_cnt_ly           
FROM FB_FIELD a, FB_SECTION b, 
		(select * from FB_PRUNINGSESSION where PRUN_YEAR =  to_number(to_char(to_date(:ra_frdt_ly,'dd/mm/yyyy'),'YYYY'))) d,
		(select section_id,sum(mandays) mandays, sum(nvl(totalgl,0)) totalgl, sum(nvl(mandays_todate,0)) mandays_todate, sum(nvl(totalgl_todate,0)) totalgl_todate  from
			(select SECTION_ID,sum(decode(sign(TASK_DATE - to_date(:ra_frdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(TASK_DATE - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,(nvl(c.TASK_PMATODAYTY,0) + nvl(c.TASK_PFATODAYTY,0) + nvl(c.TASK_TMATODAYTY,0) + nvl(c.TASK_TFATODAYTY,0) + nvl(c.TASK_OMATODAYTY,0) + nvl(c.TASK_OFATODAYTY,0) + 
						 ((nvl(c.TASK_PMADTODAYTY,0) + nvl(c.TASK_PFADTODAYTY,0) + nvl(c.TASK_PMCTODAYTY,0) + nvl(c.TASK_PFCTODAYTY,0) +
							nvl(c.TASK_TMADTODAYTY,0) + nvl(c.TASK_TFADTODAYTY,0) + nvl(c.TASK_TMCTODAYTY,0) + nvl(c.TASK_TFCTODAYTY,0) +
							nvl(c.TASK_OMADTODAYTY,0) + nvl(c.TASK_OFADTODAYTY,0) + nvl(c.TASK_OMCTODAYTY,0) + nvl(c.TASK_OFCTODAYTY,0)) * 0.5))))) mandays,
						 sum(decode(sign(TASK_DATE - to_date(:ra_frdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(TASK_DATE - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,(nvl(f.TASK_PMACOUNTTODAYTY,0) + nvl(f.TASK_PFACOUNTTODAYTY,0) + nvl(f.TASK_TMACOUNTTODAYTY,0) + nvl(f.TASK_TFACOUNTTODAYTY,0) + 
							nvl(f.TASK_OMACOUNTTODAYTY,0) + nvl(f.TASK_OFACOUNTTODAYTY,0) + nvl(f.TASK_PMADCOUNTTODAYTY,0) + nvl(f.TASK_PFADCOUNTTODAYTY,0) + 
							nvl(f.TASK_TMADCOUNTTODAYTY,0) + nvl(f.TASK_TFADCOUNTTODAYTY,0) + nvl(f.TASK_OMADCOUNTTODAYTY,0) + nvl(f.TASK_OFADCOUNTTODAYTY,0) + 
							nvl(f.TASK_PMCCOUNTTODAYTY,0) + nvl(f.TASK_PFCCOUNTTODAYTY,0) + nvl(f.TASK_TMCCOUNTTODAYTY,0) + nvl(f.TASK_TFCCOUNTTODAYTY,0) + 
							nvl(f.TASK_OMCCOUNTTODAYTY,0) + nvl(f.TASK_OFCCOUNTTODAYTY,0)))))  totalgl,
						 sum(decode(sign(TASK_DATE - to_date(:ra_ysdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(TASK_DATE - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,(nvl(c.TASK_PMATODAYTY,0) + nvl(c.TASK_PFATODAYTY,0) + nvl(c.TASK_TMATODAYTY,0) + nvl(c.TASK_TFATODAYTY,0) + nvl(c.TASK_OMATODAYTY,0) + nvl(c.TASK_OFATODAYTY,0) + 
						 ((nvl(c.TASK_PMADTODAYTY,0) + nvl(c.TASK_PFADTODAYTY,0) + nvl(c.TASK_PMCTODAYTY,0) + nvl(c.TASK_PFCTODAYTY,0) +
							nvl(c.TASK_TMADTODAYTY,0) + nvl(c.TASK_TFADTODAYTY,0) + nvl(c.TASK_TMCTODAYTY,0) + nvl(c.TASK_TFCTODAYTY,0) +
							nvl(c.TASK_OMADTODAYTY,0) + nvl(c.TASK_OFADTODAYTY,0) + nvl(c.TASK_OMCTODAYTY,0) + nvl(c.TASK_OFCTODAYTY,0)) * 0.5))))) mandays_todate,
						 sum(decode(sign(TASK_DATE - to_date(:ra_ysdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(TASK_DATE - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,(nvl(f.TASK_PMACOUNTTODAYTY,0) + nvl(f.TASK_PFACOUNTTODAYTY,0) + nvl(f.TASK_TMACOUNTTODAYTY,0) + nvl(f.TASK_TFACOUNTTODAYTY,0) + 
						 nvl(f.TASK_OMACOUNTTODAYTY,0) + nvl(f.TASK_OFACOUNTTODAYTY,0) + nvl(f.TASK_PMADCOUNTTODAYTY,0) + nvl(f.TASK_PFADCOUNTTODAYTY,0) + 
						 nvl(f.TASK_TMADCOUNTTODAYTY,0) + nvl(f.TASK_TFADCOUNTTODAYTY,0) + nvl(f.TASK_OMADCOUNTTODAYTY,0) + nvl(f.TASK_OFADCOUNTTODAYTY,0) + 
						 nvl(f.TASK_PMCCOUNTTODAYTY,0) + nvl(f.TASK_PFCCOUNTTODAYTY,0) + nvl(f.TASK_TMCCOUNTTODAYTY,0) + nvl(f.TASK_TFCCOUNTTODAYTY,0) + 
						 nvl(f.TASK_OMCCOUNTTODAYTY,0) + nvl(f.TASK_OFCCOUNTTODAYTY,0)))))  totalgl_todate
				from 
				FB_TASKACTIVEDAILY c, FB_KAMSUBHEAD e, FB_TASKACTIVEMEASUREMENT f
				where c.TASKDATE_ID = f.TASKSECTION_ID AND c.TASK_ID = e.KAMSUB_ID AND e.KAMSUB_TYPE = 'PLUCK' AND
						nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and TASK_DATE between to_date(:ra_ysdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy')
				group by SECTION_ID
				union all
				select SECTION_ID, 0,
						 sum(decode(sign(trunc(SPR_DATE) - to_date(:ra_frdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(trunc(SPR_DATE) - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,nvl(SPR_GL,0)))) cash_gl, 0,
						 sum(decode(sign(trunc(SPR_DATE) - to_date(:ra_ysdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(trunc(SPR_DATE) - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,nvl(SPR_GL,0)))) cash_gl_ytd
				from FB_SECTIONPLUCKINGROUND where SPR_PLUCCKTYPE = 'C' and 
					  trunc(SPR_DATE) between to_date(:ra_ysdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy')
				group by SECTION_ID) 
			group by SECTION_ID) g, 
		(SELECT SECTION_ID, 
                sum(decode(sign(SPR_DATE - to_date(:ra_frdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,nvl(SPR_AREACOVERED,0)))) areacovered,
                sum(decode(sign(SPR_DATE - to_date(:ra_ysdt_ly,'dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date(:ra_todt_ly,'dd/mm/yyyy')),1,0,nvl(SPR_AREACOVERED,0)))) areacovered_todate 
         FROM FB_SECTIONPLUCKINGROUND WHERE SPR_DATE between to_date(:ra_ysdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy') group by SECTION_ID) h
WHERE  a.FIELD_ID = b.FIELD_ID AND b.SECTION_ID = d.SECTION_ID(+) AND b.SECTION_ID = g.SECTION_ID (+) AND b.SECTION_ID = h.SECTION_ID(+) and 
       nvl(SECTION_TYPE,'S') = 'S';
		 
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Last Year Data',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

SELECT  sum(nvl(b.SECTION_AREA,0)) sectionarea, sum(nvl(areacovered,0)) areacovered,sum(nvl(areacovered_todate,0)) areacovered_todate,
           sum(nvl(mandays,0)) mandays, sum(nvl(totalgl,0)) totalgl, sum(nvl(mandays_todate,0)) mandays_todate, sum(nvl(totalgl_todate,0)) totalgl_todate,sum(to_number(SECTION_ACTUALPLANTS))/sum(nvl(b.SECTION_AREA,0)) plantpopulation
into :ld_ar_py,:ld_arcov_py, :ld_arcov_todt_py, :ld_mdays_py, :ld_totalgl_py, :ld_mdays_todt_py, :ld_totgl_todt_py,:ld_cnt_py           
FROM FB_FIELD a, FB_SECTION b, 
		(select * from FB_PRUNINGSESSION where PRUN_YEAR =  to_number(to_char(to_date(:ra_frdt_py,'dd/mm/yyyy'),'YYYY'))) d,
		(select section_id,sum(mandays) mandays, sum(nvl(totalgl,0)) totalgl, sum(nvl(mandays_todate,0)) mandays_todate, sum(nvl(totalgl_todate,0)) totalgl_todate  from
			(select SECTION_ID,sum(decode(sign(TASK_DATE - to_date(:ra_frdt_py,'dd/mm/yyyy')),-1,0,decode(sign(TASK_DATE - to_date(:ra_todt_py,'dd/mm/yyyy')),1,0,(nvl(c.TASK_PMATODAYTY,0) + nvl(c.TASK_PFATODAYTY,0) + nvl(c.TASK_TMATODAYTY,0) + nvl(c.TASK_TFATODAYTY,0) + nvl(c.TASK_OMATODAYTY,0) + nvl(c.TASK_OFATODAYTY,0) + 
						 ((nvl(c.TASK_PMADTODAYTY,0) + nvl(c.TASK_PFADTODAYTY,0) + nvl(c.TASK_PMCTODAYTY,0) + nvl(c.TASK_PFCTODAYTY,0) +
							nvl(c.TASK_TMADTODAYTY,0) + nvl(c.TASK_TFADTODAYTY,0) + nvl(c.TASK_TMCTODAYTY,0) + nvl(c.TASK_TFCTODAYTY,0) +
							nvl(c.TASK_OMADTODAYTY,0) + nvl(c.TASK_OFADTODAYTY,0) + nvl(c.TASK_OMCTODAYTY,0) + nvl(c.TASK_OFCTODAYTY,0)) * 0.5))))) mandays,
						 sum(decode(sign(TASK_DATE - to_date(:ra_frdt_py,'dd/mm/yyyy')),-1,0,decode(sign(TASK_DATE - to_date(:ra_todt_py,'dd/mm/yyyy')),1,0,(nvl(f.TASK_PMACOUNTTODAYTY,0) + nvl(f.TASK_PFACOUNTTODAYTY,0) + nvl(f.TASK_TMACOUNTTODAYTY,0) + nvl(f.TASK_TFACOUNTTODAYTY,0) + 
							nvl(f.TASK_OMACOUNTTODAYTY,0) + nvl(f.TASK_OFACOUNTTODAYTY,0) + nvl(f.TASK_PMADCOUNTTODAYTY,0) + nvl(f.TASK_PFADCOUNTTODAYTY,0) + 
							nvl(f.TASK_TMADCOUNTTODAYTY,0) + nvl(f.TASK_TFADCOUNTTODAYTY,0) + nvl(f.TASK_OMADCOUNTTODAYTY,0) + nvl(f.TASK_OFADCOUNTTODAYTY,0) + 
							nvl(f.TASK_PMCCOUNTTODAYTY,0) + nvl(f.TASK_PFCCOUNTTODAYTY,0) + nvl(f.TASK_TMCCOUNTTODAYTY,0) + nvl(f.TASK_TFCCOUNTTODAYTY,0) + 
							nvl(f.TASK_OMCCOUNTTODAYTY,0) + nvl(f.TASK_OFCCOUNTTODAYTY,0)))))  totalgl,
						 sum(decode(sign(TASK_DATE - to_date(:ra_ysdt_py,'dd/mm/yyyy')),-1,0,decode(sign(TASK_DATE - to_date(:ra_todt_py,'dd/mm/yyyy')),1,0,(nvl(c.TASK_PMATODAYTY,0) + nvl(c.TASK_PFATODAYTY,0) + nvl(c.TASK_TMATODAYTY,0) + nvl(c.TASK_TFATODAYTY,0) + nvl(c.TASK_OMATODAYTY,0) + nvl(c.TASK_OFATODAYTY,0) + 
						 ((nvl(c.TASK_PMADTODAYTY,0) + nvl(c.TASK_PFADTODAYTY,0) + nvl(c.TASK_PMCTODAYTY,0) + nvl(c.TASK_PFCTODAYTY,0) +
							nvl(c.TASK_TMADTODAYTY,0) + nvl(c.TASK_TFADTODAYTY,0) + nvl(c.TASK_TMCTODAYTY,0) + nvl(c.TASK_TFCTODAYTY,0) +
							nvl(c.TASK_OMADTODAYTY,0) + nvl(c.TASK_OFADTODAYTY,0) + nvl(c.TASK_OMCTODAYTY,0) + nvl(c.TASK_OFCTODAYTY,0)) * 0.5))))) mandays_todate,
						 sum(decode(sign(TASK_DATE - to_date(:ra_ysdt_py,'dd/mm/yyyy')),-1,0,decode(sign(TASK_DATE - to_date(:ra_todt_py,'dd/mm/yyyy')),1,0,(nvl(f.TASK_PMACOUNTTODAYTY,0) + nvl(f.TASK_PFACOUNTTODAYTY,0) + nvl(f.TASK_TMACOUNTTODAYTY,0) + nvl(f.TASK_TFACOUNTTODAYTY,0) + 
						 nvl(f.TASK_OMACOUNTTODAYTY,0) + nvl(f.TASK_OFACOUNTTODAYTY,0) + nvl(f.TASK_PMADCOUNTTODAYTY,0) + nvl(f.TASK_PFADCOUNTTODAYTY,0) + 
						 nvl(f.TASK_TMADCOUNTTODAYTY,0) + nvl(f.TASK_TFADCOUNTTODAYTY,0) + nvl(f.TASK_OMADCOUNTTODAYTY,0) + nvl(f.TASK_OFADCOUNTTODAYTY,0) + 
						 nvl(f.TASK_PMCCOUNTTODAYTY,0) + nvl(f.TASK_PFCCOUNTTODAYTY,0) + nvl(f.TASK_TMCCOUNTTODAYTY,0) + nvl(f.TASK_TFCCOUNTTODAYTY,0) + 
						 nvl(f.TASK_OMCCOUNTTODAYTY,0) + nvl(f.TASK_OFCCOUNTTODAYTY,0)))))  totalgl_todate
				from 
				FB_TASKACTIVEDAILY c, FB_KAMSUBHEAD e, FB_TASKACTIVEMEASUREMENT f
				where c.TASKDATE_ID = f.TASKSECTION_ID AND c.TASK_ID = e.KAMSUB_ID AND e.KAMSUB_TYPE = 'PLUCK' AND
						nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and TASK_DATE between to_date(:ra_ysdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy')
				group by SECTION_ID
				union all
				select SECTION_ID, 0,
						 sum(decode(sign(trunc(SPR_DATE) - to_date(:ra_frdt_py,'dd/mm/yyyy')),-1,0,decode(sign(trunc(SPR_DATE) - to_date(:ra_todt_py,'dd/mm/yyyy')),1,0,nvl(SPR_GL,0)))) cash_gl, 0,
						 sum(decode(sign(trunc(SPR_DATE) - to_date(:ra_ysdt_py,'dd/mm/yyyy')),-1,0,decode(sign(trunc(SPR_DATE) - to_date(:ra_todt_py,'dd/mm/yyyy')),1,0,nvl(SPR_GL,0)))) cash_gl_ytd
				from FB_SECTIONPLUCKINGROUND where SPR_PLUCCKTYPE = 'C' and 
					  trunc(SPR_DATE) between to_date(:ra_ysdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy')
				group by SECTION_ID) 
			group by SECTION_ID) g, 
		(SELECT SECTION_ID, 
                sum(decode(sign(SPR_DATE - to_date(:ra_frdt_py,'dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date(:ra_todt_py,'dd/mm/yyyy')),1,0,nvl(SPR_AREACOVERED,0)))) areacovered,
                sum(decode(sign(SPR_DATE - to_date(:ra_ysdt_py,'dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date(:ra_todt_py,'dd/mm/yyyy')),1,0,nvl(SPR_AREACOVERED,0)))) areacovered_todate 
         FROM FB_SECTIONPLUCKINGROUND WHERE SPR_DATE between to_date(:ra_ysdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy') group by SECTION_ID) h
WHERE  a.FIELD_ID = b.FIELD_ID AND b.SECTION_ID = d.SECTION_ID(+) AND b.SECTION_ID = g.SECTION_ID (+) AND b.SECTION_ID = h.SECTION_ID(+) and 
       nvl(SECTION_TYPE,'S') = 'S';

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Prior Year Data',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if				

//if rb_3.checked then
//	dw_2.show()
//	dw_1.hide()
//	dw_2.retrieve(ls_frdt,ls_todt,ls_ysdt,ld_recper)
//elseif rb_4.checked then
//	dw_1.show()
//	dw_2.hide()	
	dw_1.retrieve(ls_frdt,ls_todt,ls_ysdt,ld_recper_td,ld_recper_tdt, ld_ar_ly, ld_arcov_ly, ld_arcov_todt_ly, ld_mdays_ly, ld_totalgl_ly, ld_mdays_todt_ly, ld_totgl_todt_ly, ld_recper_td_ly,ld_recper_tdt_ly, ld_ar_py, ld_arcov_py, ld_arcov_todt_py, ld_mdays_py, ld_totalgl_py, ld_mdays_todt_py, ld_totgl_todt_py, ld_recper_td_py,ld_recper_tdt_py,ld_cnt_ly,ld_cnt_py)
//end if

setpointer(arrow!)

end event

type cb_2 from commandbutton within w_gteflr006_mis
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

type rb_4 from radiobutton within w_gteflr006_mis
boolean visible = false
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

type rb_3 from radiobutton within w_gteflr006_mis
boolean visible = false
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

type rb_2 from radiobutton within w_gteflr006_mis
boolean visible = false
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
boolean checked = true
end type

type gb_1 from groupbox within w_gteflr006_mis
boolean visible = false
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

type gb_2 from groupbox within w_gteflr006_mis
boolean visible = false
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

type dw_1 from datawindow within w_gteflr006_mis
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 144
integer width = 4416
integer height = 2056
string dataobject = "dw_gteflr006_mis"
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

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

