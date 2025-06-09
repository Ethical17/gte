$PBExportHeader$w_gteflr011.srw
forward
global type w_gteflr011 from window
end type
type ddlb_1 from dropdownlistbox within w_gteflr011
end type
type st_3 from statictext within w_gteflr011
end type
type st_2 from statictext within w_gteflr011
end type
type dp_2 from datepicker within w_gteflr011
end type
type dp_1 from datepicker within w_gteflr011
end type
type rb_1 from radiobutton within w_gteflr011
end type
type st_1 from statictext within w_gteflr011
end type
type cb_1 from commandbutton within w_gteflr011
end type
type cb_2 from commandbutton within w_gteflr011
end type
type rb_2 from radiobutton within w_gteflr011
end type
type gb_1 from groupbox within w_gteflr011
end type
type dw_1 from datawindow within w_gteflr011
end type
end forward

global type w_gteflr011 from window
integer width = 3863
integer height = 2848
boolean titlebar = true
string title = "(Gteflr011) - Yield Register"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_1 ddlb_1
st_3 st_3
st_2 st_2
dp_2 dp_2
dp_1 dp_1
rb_1 rb_1
st_1 st_1
cb_1 cb_1
cb_2 cb_2
rb_2 rb_2
gb_1 gb_1
dw_1 dw_1
end type
global w_gteflr011 w_gteflr011

type variables
n_cst_powerfilter iu_powerfilter
string ls_division
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

on w_gteflr011.create
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.st_2=create st_2
this.dp_2=create dp_2
this.dp_1=create dp_1
this.rb_1=create rb_1
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.rb_2=create rb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.Control[]={this.ddlb_1,&
this.st_3,&
this.st_2,&
this.dp_2,&
this.dp_1,&
this.rb_1,&
this.st_1,&
this.cb_1,&
this.cb_2,&
this.rb_2,&
this.gb_1,&
this.dw_1}
end on

on w_gteflr011.destroy
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.rb_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.rb_2)
destroy(this.gb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dp_1.value = datetime('01'+right(string(today(),'dd/mm/yyyy'),8))

ddlb_1.additem('ALL')

declare c2 cursor for
select FIELD_NAME||' ('||FIELD_ID||')' from FB_FIELD where nvl(FIELD_ACTIVE_IND,'Y') = 'Y' order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ls_division;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_division)
		fetch c2 into:ls_division;
	loop
	close c2;
end if
ddlb_1.additem('OTHER')

ddlb_1.text = 'ALL'
setpointer(arrow!)
end event

type ddlb_1 from dropdownlistbox within w_gteflr011
integer x = 242
integer y = 148
integer width = 1266
integer height = 608
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
end type

type st_3 from statictext within w_gteflr011
integer x = 23
integer y = 160
integer width = 215
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Division"
boolean focusrectangle = false
end type

type st_2 from statictext within w_gteflr011
integer x = 1545
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

type dp_2 from datepicker within w_gteflr011
integer x = 1691
integer y = 32
integer width = 389
integer height = 100
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2013-10-29"), Time("09:50:33.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_gteflr011
integer x = 1138
integer y = 32
integer width = 389
integer height = 100
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2013-10-29"), Time("09:50:33.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type rb_1 from radiobutton within w_gteflr011
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

type st_1 from statictext within w_gteflr011
integer x = 759
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

type cb_1 from commandbutton within w_gteflr011
integer x = 2112
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
double ld_tm_today,ld_tm_todate,ld_gltoday,ld_gltodate,ld_recper_today,ld_recper_todate

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

select sum(decode(sign(GLFP_PLUCKINGDATE - to_date(:ls_frdt,'dd/mm/yyyy')),-1,0,decode(sign(GLFP_PLUCKINGDATE - to_date(:ls_todt,'dd/mm/yyyy')),1,0,nvl(GWTM_TEAMADE,0)))),
		sum(decode(sign(GLFP_PLUCKINGDATE - to_date(:ls_ysdt,'dd/mm/yyyy')),-1,0,decode(sign(GLFP_PLUCKINGDATE - to_date(:ls_todt,'dd/mm/yyyy')),1,0,nvl(GWTM_TEAMADE,0))))
  into :ld_tm_today,:ld_tm_todate 
from fb_glforproduction a,fb_gardenwiseteamade b 
where a.GLFP_PK = b.GLFP_PK and (GWTM_TYPE in ('O') or (GWTM_TYPE in ('N','E') and SUP_ID = :gs_supid)) and 
		trunc(GLFP_PLUCKINGDATE) between to_date(:ls_ysdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy');

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Total Teamade',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

//SELECT sum(decode(sign(glt.pluckingdate - to_date(:ls_frdt,'dd/mm/yyyy')),-1,0,decode(sign(glt.pluckingdate - to_date(:ls_todt,'dd/mm/yyyy')),1,0,decode(gt_type,'SALE',-nvl(glt.gt_quantity,0),'TRANSFER',-nvl(glt.gt_quantity,0),nvl(glt.gt_quantity,0)) ))) ctoday, 
// 	 	   sum(decode(sign(glt.pluckingdate - to_date(:ls_ysdt,'dd/mm/yyyy')),-1,0,decode(sign(glt.pluckingdate - to_date(:ls_todt,'dd/mm/yyyy')),1,0,decode(gt_type,'SALE',-nvl(glt.gt_quantity,0),'TRANSFER',-nvl(glt.gt_quantity,0),nvl(glt.gt_quantity,0)) ))) ctodate
//   into :ld_gltoday,:ld_gltodate
//  FROM fb_gltransaction glt, fb_supplier sup
//WHERE glt.sup_id = sup.sup_id AND glt.gt_type in ('OWNATTE' ,'OWNUSER','SALE','TRANSFER')    and NVL (glt.gt_quantity, 0) > 0    and
//		  glt.pluckingdate between to_date(:ls_ysdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy') ;

SELECT sum(decode(sign(glt.pluckingdate - to_date(:ls_frdt,'dd/mm/yyyy')),-1,0,decode(sign(glt.pluckingdate - to_date(:ls_todt,'dd/mm/yyyy')),1,0,nvl(glt.gt_quantity,0)))) ctoday, 
 	 	   sum(decode(sign(glt.pluckingdate - to_date(:ls_ysdt,'dd/mm/yyyy')),-1,0,decode(sign(glt.pluckingdate - to_date(:ls_todt,'dd/mm/yyyy')),1,0,nvl(glt.gt_quantity,0)))) ctodate
   into :ld_gltoday,:ld_gltodate
  FROM fb_gltransaction glt, fb_supplier sup
WHERE glt.sup_id = sup.sup_id AND glt.gt_type in ('OWNATTE' ,'OWNUSER')    and NVL (glt.gt_quantity, 0) > 0    and
		  glt.pluckingdate between to_date(:ls_ysdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy') ;


//select sum( totalgl) ,sum(totalgl_todate) into :ld_gltoday,:ld_gltodate
// from (select 'K',c.section_id,sum(decode(sign(TASK_DATE - to_date(:ls_frdt,'dd/mm/yyyy')),-1,0,decode(sign(TASK_DATE - to_date(:ls_todt,'dd/mm/yyyy')),1,0,
//						(nvl(f.TASK_PMACOUNTTODAYTY,0) + nvl(f.TASK_PFACOUNTTODAYTY,0) + nvl(f.TASK_TMACOUNTTODAYTY,0) + nvl(f.TASK_TFACOUNTTODAYTY,0) + 
//							nvl(f.TASK_OMACOUNTTODAYTY,0) + nvl(f.TASK_OFACOUNTTODAYTY,0) + nvl(f.TASK_PMADCOUNTTODAYTY,0) + nvl(f.TASK_PFADCOUNTTODAYTY,0) + 
//								nvl(f.TASK_TMADCOUNTTODAYTY,0) + nvl(f.TASK_TFADCOUNTTODAYTY,0) + nvl(f.TASK_OMADCOUNTTODAYTY,0) + nvl(f.TASK_OFADCOUNTTODAYTY,0) + 
//						 nvl(f.TASK_PMCCOUNTTODAYTY,0) + nvl(f.TASK_PFCCOUNTTODAYTY,0) + nvl(f.TASK_TMCCOUNTTODAYTY,0) + nvl(f.TASK_TFCCOUNTTODAYTY,0) + 
//						 nvl(f.TASK_OMCCOUNTTODAYTY,0) + nvl(f.TASK_OFCCOUNTTODAYTY,0)))))  totalgl,
//						sum(decode(sign(TASK_DATE - to_date(:ls_ysdt,'dd/mm/yyyy')),-1,0,decode(sign(TASK_DATE - to_date(:ls_todt,'dd/mm/yyyy')),1,0,
//								(nvl(f.TASK_PMACOUNTTODAYTY,0) + nvl(f.TASK_PFACOUNTTODAYTY,0) + nvl(f.TASK_TMACOUNTTODAYTY,0) + nvl(f.TASK_TFACOUNTTODAYTY,0) + 
//								nvl(f.TASK_OMACOUNTTODAYTY,0) + nvl(f.TASK_OFACOUNTTODAYTY,0) + nvl(f.TASK_PMADCOUNTTODAYTY,0) + nvl(f.TASK_PFADCOUNTTODAYTY,0) + 
//								nvl(f.TASK_TMADCOUNTTODAYTY,0) + nvl(f.TASK_TFADCOUNTTODAYTY,0) + nvl(f.TASK_OMADCOUNTTODAYTY,0) + nvl(f.TASK_OFADCOUNTTODAYTY,0) + 
//								nvl(f.TASK_PMCCOUNTTODAYTY,0) + nvl(f.TASK_PFCCOUNTTODAYTY,0) + nvl(f.TASK_TMCCOUNTTODAYTY,0) + nvl(f.TASK_TFCCOUNTTODAYTY,0) + 
//								nvl(f.TASK_OMCCOUNTTODAYTY,0) + nvl(f.TASK_OFCCOUNTTODAYTY,0)))))  totalgl_todate
//					from FB_TASKACTIVEDAILY c, FB_KAMSUBHEAD e,  FB_TASKACTIVEMEASUREMENT f 
//					where c.TASKDATE_ID = f.TASKSECTION_ID AND c.TASK_ID = e.KAMSUB_ID AND e.KAMSUB_TYPE = 'PLUCK' AND
//							TASK_DATE between to_date(:ls_ysdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy') 
//					group by  'K',c.section_id union all
//					select 'C',SECTION_ID,
//						 sum(decode(sign(SPR_DATE - to_date(:ls_frdt,'dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date(:ls_todt,'dd/mm/yyyy')),1,0,SPR_GL))) cash_gl,
//						 sum(decode(sign(SPR_DATE - to_date(:ls_ysdt,'dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date(:ls_todt,'dd/mm/yyyy')),1,0,SPR_GL))) cash_gl_todate
//				 from FB_SECTIONPLUCKINGROUND where SPR_PLUCCKTYPE='C' and SPR_DATE between to_date(:ls_ysdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy') 
//				group by 'C',SECTION_ID) e;
		
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
	ld_recper_today = 0
else
	ld_recper_today = round((ld_tm_today / ld_gltoday ) * 100,2)
end if

if ld_gltodate = 0 then
	ld_recper_todate = 0
else
	ld_recper_todate = round((ld_tm_todate / ld_gltodate ) * 100,2)
end if
ls_division = left(right(ddlb_1.text,6),5)

dw_1.retrieve(ls_frdt,ls_todt,ls_ysdt,ld_recper_today,ld_recper_todate,ld_tm_today,ld_tm_todate,ld_gltoday,ld_gltodate, ls_division)

setpointer(arrow!)

end event

type cb_2 from commandbutton within w_gteflr011
integer x = 2377
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

type rb_2 from radiobutton within w_gteflr011
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

type gb_1 from groupbox within w_gteflr011
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

type dw_1 from datawindow within w_gteflr011
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 248
integer width = 3803
integer height = 1952
string dataobject = "dw_gteflr011"
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

