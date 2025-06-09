$PBExportHeader$w_gteflr005n.srw
forward
global type w_gteflr005n from window
end type
type em_2 from editmask within w_gteflr005n
end type
type st_3 from statictext within w_gteflr005n
end type
type st_2 from statictext within w_gteflr005n
end type
type ddlb_1 from dropdownlistbox within w_gteflr005n
end type
type cb_2 from commandbutton within w_gteflr005n
end type
type cb_1 from commandbutton within w_gteflr005n
end type
type st_1 from statictext within w_gteflr005n
end type
type dp_1 from datepicker within w_gteflr005n
end type
type dw_1 from datawindow within w_gteflr005n
end type
end forward

global type w_gteflr005n from window
integer width = 4818
integer height = 2392
boolean titlebar = true
string title = "(Gteflr005) - Daily Plucking"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_2 em_2
st_3 st_3
st_2 st_2
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
st_1 st_1
dp_1 dp_1
dw_1 dw_1
end type
global w_gteflr005n w_gteflr005n

type variables
n_cst_powerfilter iu_powerfilter
string ls_division,ls_text,ls_file
long li_filenum,ll_user_level
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

on w_gteflr005n.create
this.em_2=create em_2
this.st_3=create st_3
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.dp_1=create dp_1
this.dw_1=create dw_1
this.Control[]={this.em_2,&
this.st_3,&
this.st_2,&
this.ddlb_1,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.dp_1,&
this.dw_1}
end on

on w_gteflr005n.destroy
destroy(this.em_2)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dp_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")


ddlb_1.reset()
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

ddlb_1.text = 'ALL'

select pfa_permission into :ll_user_level from fb_pf_access where pfa_user_id=:gs_user and nvl(pfa_active,'N')='Y';
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Access',sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning : NO access Provided',sqlca.sqlerrtext)
	return 1
end if	

setpointer(arrow!)

em_2.text = right(string(today()),4)
end event

type em_2 from editmask within w_gteflr005n
integer x = 2766
integer y = 16
integer width = 247
integer height = 88
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "0000"
boolean spin = true
string displaydata = "~t/"
double increment = 1
string minmax = "2000~~2999"
end type

type st_3 from statictext within w_gteflr005n
integer x = 2295
integer y = 28
integer width = 494
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Prunning Season : "
boolean focusrectangle = false
end type

type st_2 from statictext within w_gteflr005n
integer x = 23
integer y = 32
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

type ddlb_1 from dropdownlistbox within w_gteflr005n
integer x = 242
integer y = 20
integer width = 1179
integer height = 608
integer taborder = 20
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

type cb_2 from commandbutton within w_gteflr005n
integer x = 3291
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
string text = "&Close"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_gteflr005n
integer x = 3026
integer y = 8
integer width = 265
integer height = 100
integer taborder = 20
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

string ls_year_ind,ls_frdt,ls_todt,ls_ysdt,ls_ly_frdt,ls_ly_todt,ls_ly_ysdt

ls_frdt = dp_1.text 
ls_year_ind='C'

select decode(:ls_year_ind,'C','01/01/'||to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'),to_char(to_date((decode(sign(to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy')))||'0401'),'yyyymmdd'),'dd/mm/yyyy')),
		decode(substr(:ls_frdt,1,5),'29/02',('28/02/'||(to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1)), (to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'dd/mm/')||(to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1))),
		decode(:ls_year_ind,'C','01/01/'||to_char((to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1)),to_char(to_date((decode(sign(to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-2,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1)||'0401'),'yyyymmdd'),'dd/mm/yyyy'))
  into :ls_ysdt,:ls_ly_frdt,:ls_ly_ysdt from dual;

ls_division = left(right(ddlb_1.text,6),5)



	if ll_user_level =1 then
	///   PLUCKING SUMARY ALL
		ls_text = " CREATE OR REPLACE VIEW FBVW_PLUCKINGSUMMARY (ty, so,recdesc,ctoday,ctodate,ltoday,ltodate) AS  "&
		+" select   'A' ty, 10 so, 'Green Leaf' recdesc,sum(nvl(ctoday,0)) ctoday ,sum(ctodate) ctodate,sum(ltoday) ltoday,sum(ltodate)ltodate"&
		+" from            "&
		+" (SELECT   sum(decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ctoday ,"&
		+" sum(decode(sign(b.LDA_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ctodate , "&
		+" sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ltoday ,"&
		+" sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ltodate               "&
		+" FROM   FB_EMPLOYEE a, FB_LABOURDAILYATTENDANCE b,  FB_KAMSUBHEAD f"&
		+" WHERE  EMP_ID =b.LABOUR_ID AND KAMSUB_ACTIVE_IND = 'Y' and f.KAMSUB_TYPE = 'PLUCK' AND b.KAMSUB_ID = f.KAMSUB_ID(+) AND (trunc(b.LDA_DATE) between to_date('"+ls_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_frdt+"','dd/mm/yyyy')"&
		+" or trunc(b.LDA_DATE) between to_date('"+ls_ly_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_ly_frdt+"','dd/mm/yyyy') )"&
		+" union all"&
		+" select sum(decode(sign(SPR_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(SPR_GL,0)) ))) ctoday,"&
		+" sum(decode(sign(SPR_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(SPR_GL,0)) ))) ctodate,                     "&
		+" sum(decode(sign(SPR_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(SPR_GL,0)) ))) ltoday ,"&
		+" sum(decode(sign(SPR_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(SPR_GL,0)) ))) ltodate  "&
		+" from FB_SECTIONPLUCKINGROUND,(select KAMSUB_AFRATE from fb_kamsubhead where KAMSUB_ID = 'ESUB0163' and KAMSUB_TYPE='PLUCK'  and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and to_date('"+ls_frdt+"','dd/mm/yyyy') between KAMSUB_FRDT and nvl(KAMSUB_TODT,trunc(sysdate)))"&
		+" where SPR_PLUCCKTYPE = 'C' AND (trunc(SPR_DATE) between to_date('"+ls_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_frdt+"','dd/mm/yyyy')  or trunc(SPR_DATE) between to_date('"+ls_ly_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_ly_frdt+"','dd/mm/yyyy') ) )"&
		+" union all   "&
		+" select   'A' ty, 20 so, 'Mandays', sum(nvl(ctoday,0)) ctoday ,sum(ctodate) ctodate,sum(ltoday) ltoday,sum(ltodate)ltodate"&
		+" from            "&
		+" (SELECT   sum(decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ctoday ,"&
		+" sum(decode(sign(b.LDA_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ctodate , "&
		+" sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ltoday ,"&
		+" sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ltodate               "&
		+" FROM   FB_EMPLOYEE a, FB_LABOURDAILYATTENDANCE b,  FB_KAMSUBHEAD f"&
		+" WHERE  EMP_ID =b.LABOUR_ID AND KAMSUB_ACTIVE_IND = 'Y' and f.KAMSUB_TYPE = 'PLUCK' AND b.KAMSUB_ID = f.KAMSUB_ID(+) AND (trunc(b.LDA_DATE) between to_date('"+ls_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_frdt+"','dd/mm/yyyy')"&
		+" or trunc(b.LDA_DATE) between to_date('"+ls_ly_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_ly_frdt+"','dd/mm/yyyy') )"&
		+" union all"&
		+" select sum(decode(sign(SPR_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,((nvl(SPR_GL,0) * nvl(SPR_PLKRATE,0)) / nvl(KAMSUB_AFRATE,0)) ))) ctoday,"&
		+" sum(decode(sign(SPR_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,((nvl(SPR_GL,0) * nvl(SPR_PLKRATE,0)) / nvl(KAMSUB_AFRATE,0)) ))) ctodate,                     "&
		+" sum(decode(sign(SPR_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,((nvl(SPR_GL,0) * nvl(SPR_PLKRATE,0)) / nvl(KAMSUB_AFRATE,0)) ))) ltoday ,"&
		+" sum(decode(sign(SPR_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,((nvl(SPR_GL,0) * nvl(SPR_PLKRATE,0)) / nvl(KAMSUB_AFRATE,0)) ))) ltodate  "&
		+" from FB_SECTIONPLUCKINGROUND,(select KAMSUB_AFRATE from fb_kamsubhead where KAMSUB_ID = 'ESUB0163' and KAMSUB_TYPE='PLUCK'  and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and to_date('"+ls_frdt+"','dd/mm/yyyy') between KAMSUB_FRDT and nvl(KAMSUB_TODT,trunc(sysdate)))"&
		+" where SPR_PLUCCKTYPE = 'C' AND (trunc(SPR_DATE) between to_date('"+ls_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_frdt+"','dd/mm/yyyy')  or trunc(SPR_DATE) between to_date('"+ls_ly_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_ly_frdt+"','dd/mm/yyyy') ) )"&
		+" union all        "&
		+" SELECT  'A' ty, 30 so, 'Area Covered' recdesc,"&
		+" sum(decode(sign(i.SPR_DATE  - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(i.SPR_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,nvl(SPR_AREACOVERED,0)))) ctoday, "&
		+" sum(decode(sign(i.SPR_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(i.SPR_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,nvl(SPR_AREACOVERED,0)))) ctodate,"&
		+" sum(decode(sign(i.SPR_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(i.SPR_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,nvl(SPR_AREACOVERED,0)))) ltoday, "&
		+" sum(decode(sign(i.SPR_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(i.SPR_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,nvl(SPR_AREACOVERED,0)))) ltodate"&
		+" FROM   FB_KAMSUBHEAD f,  FB_SECTIONPLUCKINGROUND i"&
		+" WHERE  i.KAMSUB_ID = f.KAMSUB_ID AND  i.SECTION_ID in ( select SECTION_ID from fb_section where field_id = decode('"+ls_division+"','ALL',field_id,'"+ls_division+"')) and "&
		+" f.KAMSUB_TYPE = 'PLUCK' and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and"&
		+" (i.SPR_DATE between to_date('"+ls_ysdt+"','dd/mm/yyyy') and to_date('"+ls_frdt+"','dd/mm/yyyy') or "&
		+" i.SPR_DATE between to_date('"+ls_ly_ysdt+"','dd/mm/yyyy') and to_date('"+ls_ly_frdt+"','dd/mm/yyyy') )                          "&
		+" union all"&
		+" SELECT 'B' ty,50 so, 'Rainfall (In Inch)' recdesc, "&
		+" sum(decode(sign(wr_date - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(wr_date - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,nvl(wr_rainfall,0)))) ctoday, "&
		+" sum(decode(sign(wr_date - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(wr_date - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,nvl(wr_rainfall,0)))) ctodate, "&
		+" sum(decode(sign(wr_date - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(wr_date - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,nvl(wr_rainfall,0)))) ltoday, "&
		+" sum(decode(sign(wr_date - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(wr_date - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,nvl(wr_rainfall,0)))) ltodate "&
		+" FROM fb_weatherreport "&
		+" WHERE (wr_date between to_date('"+ls_ysdt+"','dd/mm/yyyy') and to_date('"+ls_frdt+"','dd/mm/yyyy') or "&
		+" wr_date between to_date('"+ls_ly_ysdt+"','dd/mm/yyyy') and to_date('"+ls_ly_frdt+"','dd/mm/yyyy')) "&
		+" group by 50,'Rainfall (In Inch)'        "&
		+" union all"&
		+" SELECT 'B' ty,60 so, 'Temperature (Max)' recdesc, "&
		+" max(decode(sign(wr_date - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(wr_date - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,nvl(WR_MAXTEMP,0)))) ctoday, "&
		+" max(decode(sign(wr_date - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(wr_date - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,nvl(WR_MAXTEMP,0)))) ctodate, "&
		+" max(decode(sign(wr_date - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(wr_date - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,nvl(WR_MAXTEMP,0)))) ltoday, "&
		+" max(decode(sign(wr_date - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(wr_date - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,nvl(WR_MAXTEMP,0)))) ltodate "&
		+" FROM (SELECT wr_date, NVL (max (WR_MAXTEMP), 0) WR_MAXTEMP, NVL (max (WR_MINTEMP), 0) WR_MINTEMP"&
		+" FROM fb_weatherreport "&
		+" GROUP BY (wr_date)) "&
		+" WHERE (wr_date between to_date('"+ls_ysdt+"','dd/mm/yyyy') and to_date('"+ls_frdt+"','dd/mm/yyyy') or "&
		+" wr_date between to_date('"+ls_ly_ysdt+"','dd/mm/yyyy') and to_date('"+ls_ly_frdt+"','dd/mm/yyyy')) "&
		+" group by 60,'Temperature (Max)'"&
		+" union all"&
		+" SELECT 'B' ty,70 so, 'Temperature (Min)' recdesc, "&
		+" min(decode(sign(wr_date - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,100,decode(sign(wr_date - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,100,nvl(WR_MINTEMP,0)))) ctoday, "&
		+" min(decode(sign(wr_date - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,100,decode(sign(wr_date - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,100,nvl(WR_MINTEMP,0)))) ctodate, "&
		+" min(decode(sign(wr_date - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,100,decode(sign(wr_date - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,100,nvl(WR_MINTEMP,0)))) ltoday, "&
		+" min(decode(sign(wr_date - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,100,decode(sign(wr_date - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,100,nvl(WR_MINTEMP,0)))) ltodate "&
		+" FROM (SELECT wr_date, NVL (max (WR_MAXTEMP), 0) WR_MAXTEMP, NVL (max (WR_MINTEMP), 0) WR_MINTEMP"&
		+" FROM fb_weatherreport "&
		+" GROUP BY (wr_date)) "&
		+" WHERE (wr_date between to_date('"+ls_ysdt+"','dd/mm/yyyy') and to_date('"+ls_frdt+"','dd/mm/yyyy') or "&
		+" wr_date between to_date('"+ls_ly_ysdt+"','dd/mm/yyyy') and to_date('"+ls_ly_frdt+"','dd/mm/yyyy')) "&
		+" group by 70,'Temperature (Min)'"
		
		
			if fileexists("c:\temp\PLUCKING SUMARY ALL.txt") = true then
				filedelete("c:\temp\PLUCKING SUMARY ALL.txt")
			end if
		
			ls_file = "c:\temp\PLUCKING SUMARY ALL.txt"
			
			li_filenum =  fileopen(ls_file,linemode!,write!,lockreadwrite!,replace!)
			
			
			
			filewriteex(li_filenum,ls_text)
			fileclose(li_filenum) 
			 
		
		execute immediate :ls_text using sqlca;
		if sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: During PLUCKING SUMARY ALL View Creation',sqlca.sqlerrtext)
			return
		end if
		
		setnull(ls_text)
		
		//PLucker Summary All
		ls_text = " CREATE OR REPLACE VIEW FBVW_PLUCKERSUMMARY (so, recdesc,ctoday,ctodate,ltoday,ltodate) AS  "&
	+" SELECT   10 so, 'Green Leaf (Permanent)' recdesc,sum(decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ctoday ,"&
	+"                   sum(decode(sign(b.LDA_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ctodate , "&
	+"                    sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ltoday ,"&
	+"                    sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ltodate               "&
	+"    FROM   FB_EMPLOYEE a, FB_LABOURDAILYATTENDANCE b,  FB_KAMSUBHEAD f"&
	+"    WHERE  EMP_ID =b.LABOUR_ID AND KAMSUB_ACTIVE_IND = 'Y' and f.KAMSUB_TYPE = 'PLUCK' AND b.KAMSUB_ID = f.KAMSUB_ID(+) AND (trunc(b.LDA_DATE) between to_date('"+ls_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_frdt+"','dd/mm/yyyy')"&
	+"                    or trunc(b.LDA_DATE) between to_date('"+ls_ly_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_ly_frdt+"','dd/mm/yyyy') ) and emp_type='LP'"&
	+" union all"&
	+" SELECT   20 so, 'Green Leaf (Temporary)' recdesc,sum(decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ctoday ,"&
	+"                   sum(decode(sign(b.LDA_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ctodate , "&
	+"                    sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ltoday ,"&
	+"                    sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ltodate               "&
	+"    FROM   FB_EMPLOYEE a, FB_LABOURDAILYATTENDANCE b,  FB_KAMSUBHEAD f"&
	+"    WHERE  EMP_ID =b.LABOUR_ID AND KAMSUB_ACTIVE_IND = 'Y' and f.KAMSUB_TYPE = 'PLUCK' AND b.KAMSUB_ID = f.KAMSUB_ID(+) AND (trunc(b.LDA_DATE) between to_date('"+ls_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_frdt+"','dd/mm/yyyy')"&
	+"                    or trunc(b.LDA_DATE) between to_date('"+ls_ly_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_ly_frdt+"','dd/mm/yyyy') ) and emp_type='LT'"&
	+" union all"&
	+"  select 35 so, 'Green Leaf (Cash)' recdesc,sum(decode(sign(SPR_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(SPR_GL,0)) ))) ctoday,"&
	+"            sum(decode(sign(SPR_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(SPR_GL,0)) ))) ctodate,                     "&
	+"            sum(decode(sign(SPR_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(SPR_GL,0)) ))) ltoday ,"&
	+"             sum(decode(sign(SPR_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(SPR_GL,0)) ))) ltodate  "&
	+" from FB_SECTIONPLUCKINGROUND,(select KAMSUB_AFRATE from fb_kamsubhead where KAMSUB_ID = 'ESUB0163' and KAMSUB_TYPE='PLUCK'  and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and to_date('"+ls_frdt+"','dd/mm/yyyy') between KAMSUB_FRDT and nvl(KAMSUB_TODT,trunc(sysdate)))"&
	+" where SPR_PLUCCKTYPE = 'C' AND (trunc(SPR_DATE) between to_date('"+ls_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_frdt+"','dd/mm/yyyy')  or trunc(SPR_DATE) between to_date('"+ls_ly_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_ly_frdt+"','dd/mm/yyyy') )"&
	+" union all"&
	+" SELECT    40 so, 'Mandays (Permanent)', sum(decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ctoday ,"&
	+"                   sum(decode(sign(b.LDA_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ctodate , "&
	+"                    sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ltoday ,"&
	+"                    sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ltodate               "&
	+"    FROM   FB_EMPLOYEE a, FB_LABOURDAILYATTENDANCE b,  FB_KAMSUBHEAD f"&
	+"    WHERE  EMP_ID =b.LABOUR_ID AND KAMSUB_ACTIVE_IND = 'Y' and f.KAMSUB_TYPE = 'PLUCK' AND b.KAMSUB_ID = f.KAMSUB_ID(+) AND (trunc(b.LDA_DATE) between to_date('"+ls_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_frdt+"','dd/mm/yyyy')"&
	+"                    or trunc(b.LDA_DATE) between to_date('"+ls_ly_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_ly_frdt+"','dd/mm/yyyy') ) and emp_type='LP'"&
	+" union all"&
	+" SELECT    50 so, 'Mandays (Temporary)', sum(decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ctoday ,"&
	+"                   sum(decode(sign(b.LDA_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ctodate , "&
	+"                    sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ltoday ,"&
	+"                    sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ltodate               "&
	+"    FROM   FB_EMPLOYEE a, FB_LABOURDAILYATTENDANCE b,  FB_KAMSUBHEAD f"&
	+"    WHERE  EMP_ID =b.LABOUR_ID AND KAMSUB_ACTIVE_IND = 'Y' and f.KAMSUB_TYPE = 'PLUCK' AND b.KAMSUB_ID = f.KAMSUB_ID(+) AND (trunc(b.LDA_DATE) between to_date('"+ls_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_frdt+"','dd/mm/yyyy')"&
	+"                    or trunc(b.LDA_DATE) between to_date('"+ls_ly_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_ly_frdt+"','dd/mm/yyyy') ) and emp_type='LT'"&
	+" union all"&
	+" select  65 so, 'Mandays (Cash)', sum(decode(sign(SPR_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,((nvl(SPR_GL,0) * nvl(SPR_PLKRATE,0)) / nvl(KAMSUB_AFRATE,0)) ))) ctoday,"&
	+"            sum(decode(sign(SPR_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,((nvl(SPR_GL,0) * nvl(SPR_PLKRATE,0)) / nvl(KAMSUB_AFRATE,0)) ))) ctodate,                     "&
	+"            sum(decode(sign(SPR_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,((nvl(SPR_GL,0) * nvl(SPR_PLKRATE,0)) / nvl(KAMSUB_AFRATE,0)) ))) ltoday ,"&
	+"             sum(decode(sign(SPR_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(SPR_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,((nvl(SPR_GL,0) * nvl(SPR_PLKRATE,0)) / nvl(KAMSUB_AFRATE,0)) ))) ltodate  "&
	+" from FB_SECTIONPLUCKINGROUND,(select KAMSUB_AFRATE from fb_kamsubhead where KAMSUB_ID = 'ESUB0163' and KAMSUB_TYPE='PLUCK'  and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and to_date('"+ls_frdt+"','dd/mm/yyyy') between KAMSUB_FRDT and nvl(KAMSUB_TODT,trunc(sysdate)))"&
	+" where SPR_PLUCCKTYPE = 'C' AND (trunc(SPR_DATE) between to_date('"+ls_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_frdt+"','dd/mm/yyyy')  or trunc(SPR_DATE) between to_date('"+ls_ly_ysdt+"','dd/mm/yyyy') AND to_date('"+ls_ly_frdt+"','dd/mm/yyyy') ) "
		
		
		if fileexists("c:\temp\PLUCKER SUMARY ALL.txt") = true then
				filedelete("c:\temp\PLUCKER SUMARY ALL.txt")
		end if
		
			ls_file = "c:\temp\PLUCKER SUMARY ALL.txt"
			
			li_filenum =  fileopen(ls_file,linemode!,write!,lockreadwrite!,replace!)
			
			
			
			filewriteex(li_filenum,ls_text)
			fileclose(li_filenum) 
			 
		
		execute immediate :ls_text using sqlca;
		if sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: During PLUCKER SUMARY ALL View Creation',sqlca.sqlerrtext)
			return
		end if
	
	
		execute immediate :ls_text using sqlca;
		if sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: During PLUCKING SUMARY View Creation',sqlca.sqlerrtext)
			return
		end if
		
	elseif ll_user_level=2 then
	
	///   PLUCKING SUMMARY PF
			setnull(ls_text)
			ls_text = " CREATE OR REPLACE VIEW FBVW_PLUCKINGSUMMARY (ty, so,recdesc,ctoday,ctodate,ltoday,ltodate) AS  "&
			+"  select ty,so,recdesc,sum(ctoday) ctoday,sum(ctodate) ctodate,sum(ltoday) ltoday, sum(ltodate) ltodate"&
+"  from (         "&
+"  select   'A' ty, 10 so, 'Green Leaf' recdesc,sum(nvl(ctoday,0)) ctoday ,sum(ctodate) ctodate,sum(ltoday) ltoday,sum(ltodate)ltodate"&
+"  from            "&
+"  (SELECT   sum(decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ctoday ,"&
+"  sum(decode(sign(b.LDA_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ctodate , "&
+"  sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ltoday ,"&
+"  sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ltodate               "&
+"  FROM   FB_EMPLOYEE a, FB_LABOURDAILYATTENDANCE b,  FB_KAMSUBHEAD f,"&
+"  (select LABOUR_ID, x.LWW_ID"&
+"  from FB_LABOURWEEKLYWAGES x "&
+"  where nvl(LABOUR_PF, 0) > 0 and x.LWW_ID in (SELECT DISTINCT LWW_ID"&
+"  FROM fb_labourwagesweek  "&
+"  WHERE ( (LWW_STARTDATE BETWEEN TO_DATE('"+ls_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_frdt+"', 'dd/mm/yyyy')) or"&
+"  (LWW_ENDDATE BETWEEN TO_DATE('"+ls_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_frdt+"', 'dd/mm/yyyy')) or "&
+"  (LWW_STARTDATE BETWEEN TO_DATE('"+ls_ly_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_ly_frdt+"', 'dd/mm/yyyy')) or"&
+"  (LWW_ENDDATE BETWEEN TO_DATE('"+ls_ly_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_ly_frdt+"', 'dd/mm/yyyy'))))) w"&
+"  WHERE  EMP_ID =b.LABOUR_ID AND KAMSUB_ACTIVE_IND = 'Y' and f.KAMSUB_TYPE = 'PLUCK' AND b.KAMSUB_ID = f.KAMSUB_ID(+) "&
+"  and  EMP_ID = w.LABOUR_ID and b.LWW_ID=w.Lww_id"&
+"  union all"&
+"  select sum(decode(sign(GL_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(GL_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(GL_PERPLUCKER,0)) ))),"&
+"  sum(decode(sign(GL_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(GL_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(GL_PERPLUCKER,0)) ))) ctodate , "&
+"  sum(decode(sign(GL_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(GL_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(GL_PERPLUCKER,0)) ))) ltoday ,"&
+"  sum(decode(sign(GL_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(GL_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(GL_PERPLUCKER,0)) ))) ltodate"&
+"  from fb_cashpluck_gl "&
+"  where GL_DATE between TO_DATE('"+ls_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_frdt+"', 'dd/mm/yyyy')"&
+"  )"&
+"  union all   "&
+"  select   'A' ty, 20 so, 'Mandays', sum(nvl(ctoday,0)) ctoday ,sum(nvl(ctodate,0)) ctodate,sum(nvl(ltoday,0)) ltoday,sum(nvl(ltodate,0))ltodate"&
+"  from            "&
+"  (SELECT   sum(decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ctoday ,"&
+"  sum(decode(sign(b.LDA_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ctodate , "&
+"  sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ltoday ,"&
+"  sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ltodate               "&
+"  FROM   FB_EMPLOYEE a, FB_LABOURDAILYATTENDANCE b,  FB_KAMSUBHEAD f,"&
+"  (select LABOUR_ID, x.LWW_ID"&
+"  from FB_LABOURWEEKLYWAGES x "&
+"  where nvl(LABOUR_PF, 0) > 0 and x.LWW_ID in (SELECT DISTINCT LWW_ID"&
+"  FROM fb_labourwagesweek  "&
+"  WHERE ( (LWW_STARTDATE BETWEEN TO_DATE('"+ls_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_frdt+"', 'dd/mm/yyyy')) or"&
+"  (LWW_ENDDATE BETWEEN TO_DATE('"+ls_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_frdt+"', 'dd/mm/yyyy')) or "&
+"  (LWW_STARTDATE BETWEEN TO_DATE('"+ls_ly_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_ly_frdt+"', 'dd/mm/yyyy')) or"&
+"  (LWW_ENDDATE BETWEEN TO_DATE('"+ls_ly_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_ly_frdt+"', 'dd/mm/yyyy'))))) w"&
+"  WHERE  EMP_ID =b.LABOUR_ID AND KAMSUB_ACTIVE_IND = 'Y' and f.KAMSUB_TYPE = 'PLUCK' AND b.KAMSUB_ID = f.KAMSUB_ID(+)    "&
+"  and  EMP_ID = w.LABOUR_ID and b.LWW_ID=w.Lww_id"&
+"  )"&
+"  union all        "&
+"  SELECT  'A' ty, 30 so, 'Area Covered' recdesc,"&
+"  sum(decode(sign(i.SPR_DATE  - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(i.SPR_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,nvl(SPR_AREACOVERED,0)))) ctoday, "&
+"  sum(decode(sign(i.SPR_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(i.SPR_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,nvl(SPR_AREACOVERED,0)))) ctodate,"&
+"  sum(decode(sign(i.SPR_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(i.SPR_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,nvl(SPR_AREACOVERED,0)))) ltoday, "&
+"  sum(decode(sign(i.SPR_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(i.SPR_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,nvl(SPR_AREACOVERED,0)))) ltodate"&
+"  FROM   FB_KAMSUBHEAD f,  FB_SECTIONPLUCKINGROUND i"&
+"  WHERE  i.KAMSUB_ID = f.KAMSUB_ID AND  i.SECTION_ID in ( select SECTION_ID from fb_section where field_id = decode('"+ls_division+"','ALL',field_id,'"+ls_division+"')) and "&
+"  f.KAMSUB_TYPE = 'PLUCK' and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and"&
+"  (i.SPR_DATE between to_date('"+ls_ysdt+"','dd/mm/yyyy') and to_date('"+ls_frdt+"','dd/mm/yyyy') or "&
+"  i.SPR_DATE between to_date('"+ls_ly_ysdt+"','dd/mm/yyyy') and to_date('"+ls_ly_frdt+"','dd/mm/yyyy') )                          "&
+"  union all"&
+"  SELECT 'B' ty,50 so, 'Rainfall (In Inch)' recdesc, "&
+"  sum(decode(sign(wr_date - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(wr_date - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,nvl(wr_rainfall,0)))) ctoday, "&
+"  sum(decode(sign(wr_date - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(wr_date - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,nvl(wr_rainfall,0)))) ctodate, "&
+"  sum(decode(sign(wr_date - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(wr_date - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,nvl(wr_rainfall,0)))) ltoday, "&
+"  sum(decode(sign(wr_date - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(wr_date - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,nvl(wr_rainfall,0)))) ltodate "&
+"  FROM fb_weatherreport "&
+"  WHERE (wr_date between to_date('"+ls_ysdt+"','dd/mm/yyyy') and to_date('"+ls_frdt+"','dd/mm/yyyy') or "&
+"  wr_date between to_date('"+ls_ly_ysdt+"','dd/mm/yyyy') and to_date('"+ls_ly_frdt+"','dd/mm/yyyy')) "&
+"  group by 50,'Rainfall (In Inch)'        "&
+"  union all"&
+"  SELECT 'B' ty,60 so, 'Temperature (Max)' recdesc, "&
+"  max(decode(sign(wr_date - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(wr_date - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,nvl(WR_MAXTEMP,0)))) ctoday, "&
+"  max(decode(sign(wr_date - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(wr_date - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,nvl(WR_MAXTEMP,0)))) ctodate, "&
+"  max(decode(sign(wr_date - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(wr_date - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,nvl(WR_MAXTEMP,0)))) ltoday, "&
+"  max(decode(sign(wr_date - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(wr_date - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,nvl(WR_MAXTEMP,0)))) ltodate "&
+"  FROM (SELECT wr_date, NVL (max (WR_MAXTEMP), 0) WR_MAXTEMP, NVL (max (WR_MINTEMP), 0) WR_MINTEMP"&
+"  FROM fb_weatherreport "&
+"  GROUP BY (wr_date)) "&
+"  WHERE (wr_date between to_date('"+ls_ysdt+"','dd/mm/yyyy') and to_date('"+ls_frdt+"','dd/mm/yyyy') or "&
+"  wr_date between to_date('"+ls_ly_ysdt+"','dd/mm/yyyy') and to_date('"+ls_ly_frdt+"','dd/mm/yyyy')) "&
+"  group by 60,'Temperature (Max)'"&
+"  union all"&
+"  SELECT 'B' ty,70 so, 'Temperature (Min)' recdesc, "&
+"  min(decode(sign(wr_date - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,100,decode(sign(wr_date - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,100,nvl(WR_MINTEMP,0)))) ctoday, "&
+"  min(decode(sign(wr_date - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,100,decode(sign(wr_date - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,100,nvl(WR_MINTEMP,0)))) ctodate, "&
+"  min(decode(sign(wr_date - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,100,decode(sign(wr_date - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,100,nvl(WR_MINTEMP,0)))) ltoday, "&
+"  min(decode(sign(wr_date - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,100,decode(sign(wr_date - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,100,nvl(WR_MINTEMP,0)))) ltodate "&
+"  FROM (SELECT wr_date, NVL (max (WR_MAXTEMP), 0) WR_MAXTEMP, NVL (max (WR_MINTEMP), 0) WR_MINTEMP"&
+"  FROM fb_weatherreport "&
+"  GROUP BY (wr_date)) "&
+"  WHERE (wr_date between to_date('"+ls_ysdt+"','dd/mm/yyyy') and to_date('"+ls_frdt+"','dd/mm/yyyy') or "&
+"  wr_date between to_date('"+ls_ly_ysdt+"','dd/mm/yyyy') and to_date('"+ls_ly_frdt+"','dd/mm/yyyy')) "&
+"  group by 70,'Temperature (Min)'"&
+"  )"&
+"  group by  ty,so,recdesc"
			
			if fileexists("c:\temp\PLUCKING SUMARY ALL.txt") = true then
				filedelete("c:\temp\PLUCKING SUMARY ALL.txt")
		end if
		
			ls_file = "c:\temp\PLUCKING SUMARY ALL.txt"
			
			li_filenum =  fileopen(ls_file,linemode!,write!,lockreadwrite!,replace!)
			
			
			
			filewriteex(li_filenum,ls_text)
			fileclose(li_filenum) 
			 
		
		execute immediate :ls_text using sqlca;
		if sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: During PLUCKING SUMARY PF View Creation',sqlca.sqlerrtext)
			return
		end if
		
		
			
			//PLUCKER SUMMARY PF
			setnull(ls_text)
			ls_text = " CREATE OR REPLACE VIEW FBVW_PLUCKERSUMMARY (so, recdesc,ctoday,ctodate,ltoday,ltodate) AS  "&
			+"  SELECT   10 so, 'Green Leaf (Permanent)' recdesc,sum(decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ctoday ,"&
+"  sum(decode(sign(b.LDA_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ctodate , "&
+"  sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ltoday ,"&
+"  sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ltodate               "&
+"  FROM   FB_EMPLOYEE a, FB_LABOURDAILYATTENDANCE b,  FB_KAMSUBHEAD f,"&
+"  (select LABOUR_ID, x.LWW_ID"&
+"  from FB_LABOURWEEKLYWAGES x "&
+"  where nvl(LABOUR_PF, 0) > 0 and x.LWW_ID in (SELECT DISTINCT LWW_ID"&
+"  FROM fb_labourwagesweek  "&
+"  WHERE ( (LWW_STARTDATE BETWEEN TO_DATE('"+ls_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_frdt+"', 'dd/mm/yyyy')) or"&
+"  (LWW_ENDDATE BETWEEN TO_DATE('"+ls_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_frdt+"', 'dd/mm/yyyy')) or "&
+"  (LWW_STARTDATE BETWEEN TO_DATE('"+ls_ly_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_ly_frdt+"', 'dd/mm/yyyy')) or"&
+"  (LWW_ENDDATE BETWEEN TO_DATE('"+ls_ly_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_ly_frdt+"', 'dd/mm/yyyy'))))) w"&
+"  WHERE  EMP_ID =b.LABOUR_ID AND KAMSUB_ACTIVE_IND = 'Y' and f.KAMSUB_TYPE = 'PLUCK' AND b.KAMSUB_ID = f.KAMSUB_ID(+) "&
+"  and  EMP_ID = w.LABOUR_ID and b.LWW_ID=w.Lww_id  and emp_type='LP'"&
+"  union all"&
+"  SELECT   20 so, 'Green Leaf (Temporary)' recdesc,sum(decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ctoday ,"&
+"  sum(decode(sign(b.LDA_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ctodate , "&
+"  sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ltoday ,"&
+"  sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) ))) ltodate               "&
+"  FROM   FB_EMPLOYEE a, FB_LABOURDAILYATTENDANCE b,  FB_KAMSUBHEAD f,"&
+"  (select LABOUR_ID, x.LWW_ID"&
+"  from FB_LABOURWEEKLYWAGES x "&
+"  where nvl(LABOUR_PF, 0) > 0 and x.LWW_ID in (SELECT DISTINCT LWW_ID"&
+"  FROM fb_labourwagesweek  "&
+"  WHERE ( (LWW_STARTDATE BETWEEN TO_DATE('"+ls_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_frdt+"', 'dd/mm/yyyy')) or"&
+"  (LWW_ENDDATE BETWEEN TO_DATE('"+ls_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_frdt+"', 'dd/mm/yyyy')) or "&
+"  (LWW_STARTDATE BETWEEN TO_DATE('"+ls_ly_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_ly_frdt+"', 'dd/mm/yyyy')) or"&
+"  (LWW_ENDDATE BETWEEN TO_DATE('"+ls_ly_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_ly_frdt+"', 'dd/mm/yyyy'))))) w"&
+"  WHERE  EMP_ID =b.LABOUR_ID AND KAMSUB_ACTIVE_IND = 'Y' and f.KAMSUB_TYPE = 'PLUCK' AND b.KAMSUB_ID = f.KAMSUB_ID(+) "&
+"  and  EMP_ID = w.LABOUR_ID and b.LWW_ID=w.Lww_id and emp_type='LT'"&
+"  union all"&
+"  select   30 so, 'Green Leaf (Cash)' recdesc,sum(decode(sign(GL_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(GL_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(GL_PERPLUCKER,0)) ))),"&
+"  sum(decode(sign(GL_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(GL_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(nvl(GL_PERPLUCKER,0)) ))) ctodate , "&
+"  sum(decode(sign(GL_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(GL_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(GL_PERPLUCKER,0)) ))) ltoday ,"&
+"  sum(decode(sign(GL_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(GL_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(nvl(GL_PERPLUCKER,0)) ))) ltodate"&
+"  from fb_cashpluck_gl "&
+"  where GL_DATE between TO_DATE('"+ls_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_frdt+"', 'dd/mm/yyyy')"&
+"  union all"&
+"  SELECT    40 so, 'Mandays (Permanent)', sum(decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ctoday ,"&
+"  sum(decode(sign(b.LDA_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ctodate , "&
+"  sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ltoday ,"&
+"  sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ltodate               "&
+"  FROM   FB_EMPLOYEE a, FB_LABOURDAILYATTENDANCE b,  FB_KAMSUBHEAD f,"&
+"  (select LABOUR_ID, x.LWW_ID"&
+"  from FB_LABOURWEEKLYWAGES x "&
+"  where nvl(LABOUR_PF, 0) > 0 and x.LWW_ID in (SELECT DISTINCT LWW_ID"&
+"  FROM fb_labourwagesweek  "&
+"  WHERE ( (LWW_STARTDATE BETWEEN TO_DATE('"+ls_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_frdt+"', 'dd/mm/yyyy')) or"&
+"  (LWW_ENDDATE BETWEEN TO_DATE('"+ls_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_frdt+"', 'dd/mm/yyyy')) or "&
+"  (LWW_STARTDATE BETWEEN TO_DATE('"+ls_ly_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_ly_frdt+"', 'dd/mm/yyyy')) or"&
+"  (LWW_ENDDATE BETWEEN TO_DATE('"+ls_ly_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_ly_frdt+"', 'dd/mm/yyyy'))))) w"&
+"  WHERE  EMP_ID =b.LABOUR_ID AND KAMSUB_ACTIVE_IND = 'Y' and f.KAMSUB_TYPE = 'PLUCK' AND b.KAMSUB_ID = f.KAMSUB_ID(+) "&
+"  and  EMP_ID = w.LABOUR_ID and b.LWW_ID=w.Lww_id and emp_type='LP'"&
+"  union all"&
+"  SELECT    50 so, 'Mandays (Temporary)', sum(decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ctoday ,"&
+"  sum(decode(sign(b.LDA_DATE - to_date('"+ls_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ctodate , "&
+"  sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ltoday ,"&
+"  sum(decode(sign(b.LDA_DATE - to_date('"+ls_ly_ysdt+"','dd/mm/yyyy')),-1,0,decode(sign(b.LDA_DATE - to_date('"+ls_ly_frdt+"','dd/mm/yyyy')),1,0,(1) ))) ltodate               "&
+"  FROM   FB_EMPLOYEE a, FB_LABOURDAILYATTENDANCE b,  FB_KAMSUBHEAD f,"&
+"  (select LABOUR_ID, x.LWW_ID"&
+"  from FB_LABOURWEEKLYWAGES x "&
+"  where nvl(LABOUR_PF, 0) > 0 and x.LWW_ID in (SELECT DISTINCT LWW_ID"&
+"  FROM fb_labourwagesweek  "&
+"  WHERE ( (LWW_STARTDATE BETWEEN TO_DATE('"+ls_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_frdt+"', 'dd/mm/yyyy')) or"&
+"  (LWW_ENDDATE BETWEEN TO_DATE('"+ls_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_frdt+"', 'dd/mm/yyyy')) or "&
+"  (LWW_STARTDATE BETWEEN TO_DATE('"+ls_ly_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_ly_frdt+"', 'dd/mm/yyyy')) or"&
+"  (LWW_ENDDATE BETWEEN TO_DATE('"+ls_ly_ysdt+"', 'dd/mm/yyyy') AND TO_DATE('"+ls_ly_frdt+"', 'dd/mm/yyyy'))))) w"&
+"  WHERE  EMP_ID =b.LABOUR_ID AND KAMSUB_ACTIVE_IND = 'Y' and f.KAMSUB_TYPE = 'PLUCK' AND b.KAMSUB_ID = f.KAMSUB_ID(+) "&
+"  and  EMP_ID = w.LABOUR_ID and b.LWW_ID=w.Lww_id and emp_type='LT'"
				
				
				if fileexists("c:\temp\PLUCKER SUMARY ALL.txt") = true then
				filedelete("c:\temp\PLUCKER SUMARY ALL.txt")
		end if
		
			ls_file = "c:\temp\PLUCKER SUMARY ALL.txt"
			
			li_filenum =  fileopen(ls_file,linemode!,write!,lockreadwrite!,replace!)
			
			
			
			filewriteex(li_filenum,ls_text)
			fileclose(li_filenum) 
			 
		
		execute immediate :ls_text using sqlca;
		if sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: During PLUCKER SUMARY PF View Creation',sqlca.sqlerrtext)
			return
		end if
			
			
		else
			messagebox('Information!','No Access !!!')
			return 1	
		end if
		
	if ll_user_level = 1 then 
		dw_1.dataobject='dw_gteflr005n'
		dw_1.settransobject(sqlca)
	elseif ll_user_level = 2  then 
		dw_1.dataobject='dw_gteflr005np'
		dw_1.settransobject(sqlca)
	end if

	
	
	dw_1.retrieve(ls_division,ls_frdt,ls_ysdt,ls_ly_frdt,ls_ly_ysdt, long(em_2.text))

setpointer(arrow!)

end event

type st_1 from statictext within w_gteflr005n
integer x = 1449
integer y = 28
integer width = 421
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Plucking Date : "
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gteflr005n
integer x = 1883
integer y = 12
integer width = 389
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2024-07-30"), Time("13:51:46.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dw_1 from datawindow within w_gteflr005n
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 120
integer width = 4485
integer height = 2088
string dataobject = "dw_gteflr005n"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
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

