$PBExportHeader$w_gteacr009.srw
forward
global type w_gteacr009 from window
end type
type em_1 from editmask within w_gteacr009
end type
type st_1 from statictext within w_gteacr009
end type
type cb_2 from commandbutton within w_gteacr009
end type
type cb_1 from commandbutton within w_gteacr009
end type
type dw_1 from datawindow within w_gteacr009
end type
end forward

global type w_gteacr009 from window
integer width = 4649
integer height = 2492
boolean titlebar = true
string title = "(W_gteacr009) Variance Analysis"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_1 em_1
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteacr009 w_gteacr009

type variables
string ls_item_ty
n_cst_powerfilter iu_powerfilter
end variables

event ue_option();	choose case gs_ueoption
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

on w_gteacr009.create
this.em_1=create em_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.em_1,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteacr009.destroy
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject(sqlca)

STRING LS_TEXT

LS_TEXT	= "create OR REPLACE view FB_MONTHLYEXPENSEBUDGET_vw as "&
	+ "(select 'O' meb_type ,MOB_YEAR +1 MEB_YEAR, 1 MEB_MONTH,EACSUBHEAD_ID,MOB_JANPRICE bg_amt from fb_monthlyothersbudget union all "&
	+ " select 'O' meb_type ,MOB_YEAR +1 MEB_YEAR, 2 MEB_MONTH,EACSUBHEAD_ID,MOB_FEBPRICE bg_amt from fb_monthlyothersbudget union all "&
	+ " select 'O' meb_type ,MOB_YEAR +1 MEB_YEAR, 3 MEB_MONTH,EACSUBHEAD_ID,MOB_MARPRICE bg_amt from fb_monthlyothersbudget union all "&
	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 4 MEB_MONTH,EACSUBHEAD_ID,MOB_APRPRICE bg_amt from fb_monthlyothersbudget union all  "&
	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 5 MEB_MONTH,EACSUBHEAD_ID,MOB_MAYPRICE bg_amt from fb_monthlyothersbudget union all "&
	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 6 MEB_MONTH,EACSUBHEAD_ID,MOB_JUNPRICE bg_amt from fb_monthlyothersbudget union all  "&
	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 7 MEB_MONTH,EACSUBHEAD_ID,MOB_JULPRICE bg_amt from fb_monthlyothersbudget union all  "&
	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 8 MEB_MONTH,EACSUBHEAD_ID,MOB_AUGPRICE bg_amt from fb_monthlyothersbudget union all  "&
	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 9 MEB_MONTH,EACSUBHEAD_ID,MOB_SEPPRICE bg_amt from fb_monthlyothersbudget union all  "&
	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 10 MEB_MONTH,EACSUBHEAD_ID,MOB_OCTPRICE bg_amt from fb_monthlyothersbudget union all  "&
	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 11 MEB_MONTH,EACSUBHEAD_ID,MOB_NOVPRICE bg_amt from fb_monthlyothersbudget union all  "&
	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 12 MEB_MONTH,EACSUBHEAD_ID,MOB_DECPRICE bg_amt from fb_monthlyothersbudget union all "&
	+ " select 'W' meb_type ,MWB_YEAR +1 MEB_YEAR, 1 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_JANMANDAYS,0) * NVL(MWB_JANRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR +1, 1,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR +1 MEB_YEAR, 2 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_FEBMANDAYS,0) * NVL(MWB_FEBRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR +1, 2,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR +1 MEB_YEAR, 3 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_MARMANDAYS,0) * NVL(MWB_MARRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR +1, 3,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 4 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_APRMANDAYS,0) * NVL(MWB_APRRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 4,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 5 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_MAYMANDAYS,0) * NVL(MWB_MAYRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 5,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 6 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_JUNMANDAYS,0) * NVL(MWB_JUNRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 6,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 7 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_JULMANDAYS,0) * NVL(MWB_JULRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 7,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 8 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_AUGMANDAYS,0) * NVL(MWB_AUGRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 8,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 9 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_SEPMANDAYS,0) * NVL(MWB_SEPRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 9,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 10 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_OCTMANDAYS,0) * NVL(MWB_OCTRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 10,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 11 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_NOVMANDAYS,0) * NVL(MWB_NOVRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 11,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 12 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_DECMANDAYS,0) * NVL(MWB_DECRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 12,EACSUBHEAD_ID union all "&
	+ " select 'T' meb_type ,MSB_YEAR +1 MEB_YEAR, 1 MEB_MONTH,EACSUBHEAD_ID,MSB_JANPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all "&
	+ " select 'T' meb_type ,MSB_YEAR +1 MEB_YEAR, 2 MEB_MONTH,EACSUBHEAD_ID,MSB_FEBPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all "&
	+ " select 'T' meb_type ,MSB_YEAR +1 MEB_YEAR, 3 MEB_MONTH,EACSUBHEAD_ID,MSB_MARPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all "&
	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 4 MEB_MONTH,EACSUBHEAD_ID,MSB_APRPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 5 MEB_MONTH,EACSUBHEAD_ID,MSB_MAYPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all "&
	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 6 MEB_MONTH,EACSUBHEAD_ID,MSB_JUNPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 7 MEB_MONTH,EACSUBHEAD_ID,MSB_JULPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 8 MEB_MONTH,EACSUBHEAD_ID,MSB_AUGPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 9 MEB_MONTH,EACSUBHEAD_ID,MSB_SEPPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 10 MEB_MONTH,EACSUBHEAD_ID,MSB_OCTPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 11 MEB_MONTH,EACSUBHEAD_ID,MSB_NOVPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 12 MEB_MONTH,EACSUBHEAD_ID,MSB_DECPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all "&
	+ " select 'S' meb_type ,MSAB_YEAR +1 MEB_YEAR, 1 MEB_MONTH,EACSUBHEAD_ID,MSAB_JANSALARY bg_amt from fb_monthlysalarybudget union all "&
	+ " select 'S' meb_type ,MSAB_YEAR +1 MEB_YEAR, 2 MEB_MONTH,EACSUBHEAD_ID,MSAB_FEBSALARY bg_amt from fb_monthlysalarybudget union all "&
	+ " select 'S' meb_type ,MSAB_YEAR +1 MEB_YEAR, 3 MEB_MONTH,EACSUBHEAD_ID,MSAB_MARSALARY bg_amt from fb_monthlysalarybudget union all "&
	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 4 MEB_MONTH,EACSUBHEAD_ID,MSAB_APRSALARY bg_amt from fb_monthlysalarybudget union all  "&
	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 5 MEB_MONTH,EACSUBHEAD_ID,MSAB_MAYSALARY bg_amt from fb_monthlysalarybudget union all "&
	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 6 MEB_MONTH,EACSUBHEAD_ID,MSAB_JUNSALARY bg_amt from fb_monthlysalarybudget union all  "&
	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 7 MEB_MONTH,EACSUBHEAD_ID,MSAB_JULSALARY bg_amt from fb_monthlysalarybudget union all  "&
	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 8 MEB_MONTH,EACSUBHEAD_ID,MSAB_AUGSALARY bg_amt from fb_monthlysalarybudget union all  "&
	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 9 MEB_MONTH,EACSUBHEAD_ID,MSAB_SEPSALARY bg_amt from fb_monthlysalarybudget union all  "&
	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 10 MEB_MONTH,EACSUBHEAD_ID,MSAB_OCTSALARY bg_amt from fb_monthlysalarybudget union all  "&
	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 11 MEB_MONTH,EACSUBHEAD_ID,MSAB_NOVSALARY bg_amt from fb_monthlysalarybudget union all  "&
	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 12 MEB_MONTH,EACSUBHEAD_ID,MSAB_DECSALARY bg_amt from fb_monthlysalarybudget) "


EXECUTE IMMEDIATE :LS_TEXT USING SQLCA;

LS_TEXT	= "create OR REPLACE view FB_TMBUDGET_vw as " &
	+ " (select 'WCWF' tmb_type, (MTMB_YEAR + 1) tmb_year, 1 tmb_month, nvl(MTMB_JANTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR + 1) tmb_year, 2 tmb_month, nvl(MTMB_FEBTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR + 1) tmb_year, 3 tmb_month, nvl(MTMB_MARTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR) tmb_year, 4 tmb_month, nvl(MTMB_APRTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR) tmb_year, 5 tmb_month, nvl(MTMB_MAYTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR) tmb_year, 6 tmb_month, nvl(MTMB_JUNTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR) tmb_year, 7 tmb_month, nvl(MTMB_JULTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR) tmb_year, 8 tmb_month, nvl(MTMB_AUGTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR) tmb_year, 9 tmb_month, nvl(MTMB_SEPTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR) tmb_year, 10 tmb_month, nvl(MTMB_OCTTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR) tmb_year, 11 tmb_month, nvl(MTMB_NOVTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCWF' tmb_type, (MTMB_YEAR) tmb_year, 12 tmb_month, nvl(MTMB_DECTEAMADEOWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR + 1) tmb_year, 1 tmb_month, nvl(MTMB_JANTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR + 1) tmb_year, 2 tmb_month, nvl(MTMB_FEBTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR + 1) tmb_year, 3 tmb_month, nvl(MTMB_MARTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR) tmb_year, 4 tmb_month, nvl(MTMB_APRTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR) tmb_year, 5 tmb_month, nvl(MTMB_MAYTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR) tmb_year, 6 tmb_month, nvl(MTMB_JUNTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR) tmb_year, 7 tmb_month, nvl(MTMB_JULTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR) tmb_year, 8 tmb_month, nvl(MTMB_AUGTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR) tmb_year, 9 tmb_month, nvl(MTMB_SEPTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR) tmb_year, 10 tmb_month, nvl(MTMB_OCTTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR) tmb_year, 11 tmb_month, nvl(MTMB_NOVTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'PURC' tmb_type, (MTMB_YEAR) tmb_year, 12 tmb_month, nvl(MTMB_DECTEAMADEPUR,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR + 1) tmb_year, 1 tmb_month, nvl(MTMB_JANTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR + 1) tmb_year, 2 tmb_month, nvl(MTMB_FEBTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR + 1) tmb_year, 3 tmb_month, nvl(MTMB_MARTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR) tmb_year, 4 tmb_month, nvl(MTMB_APRTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR) tmb_year, 5 tmb_month, nvl(MTMB_MAYTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR) tmb_year, 6 tmb_month, nvl(MTMB_JUNTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR) tmb_year, 7 tmb_month, nvl(MTMB_JULTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR) tmb_year, 8 tmb_month, nvl(MTMB_AUGTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR) tmb_year, 9 tmb_month, nvl(MTMB_SEPTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR) tmb_year, 10 tmb_month, nvl(MTMB_OCTTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR) tmb_year, 11 tmb_month, nvl(MTMB_NOVTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'WCOF' tmb_type, (MTMB_YEAR) tmb_year, 12 tmb_month, nvl(MTMB_DECTMOWN_OF,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR + 1) tmb_year, 1 tmb_month, nvl(MTMB_JANTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR + 1) tmb_year, 2 tmb_month, nvl(MTMB_FEBTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR + 1) tmb_year, 3 tmb_month, nvl(MTMB_MARTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR) tmb_year, 4 tmb_month, nvl(MTMB_APRTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR) tmb_year, 5 tmb_month, nvl(MTMB_MAYTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR) tmb_year, 6 tmb_month, nvl(MTMB_JUNTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR) tmb_year, 7 tmb_month, nvl(MTMB_JULTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR) tmb_year, 8 tmb_month, nvl(MTMB_AUGTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR) tmb_year, 9 tmb_month, nvl(MTMB_SEPTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR) tmb_year, 10 tmb_month, nvl(MTMB_OCTTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR) tmb_year, 11 tmb_month, nvl(MTMB_NOVTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET union all " &
	+ "  select 'OFWC' tmb_type, (MTMB_YEAR) tmb_year, 12 tmb_month, nvl(MTMB_DECTMOF_OWN,0) bg_qty from FB_MONTHLYTEAMADEBUDGET) " &
 
 EXECUTE IMMEDIATE :LS_TEXT USING SQLCA;
end event

type em_1 from editmask within w_gteacr009
integer x = 841
integer y = 16
integer width = 256
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyymm"
end type

type st_1 from statictext within w_gteacr009
integer x = 87
integer y = 32
integer width = 709
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year / Month (YYYYMM):"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gteacr009
integer x = 1376
integer y = 16
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
boolean cancel = true
end type

event clicked;Close(parent)
end event

type cb_1 from commandbutton within w_gteacr009
integer x = 1111
integer y = 16
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
end type

event clicked; double ld_actcrop_tot_tp,ld_actcrop_tot,ld_lyrcrop_tot,ld_actcrop_pur_tp,ld_actcrop_pur,ld_lyrcrop_pur,ld_actcrop_sal_tp,ld_actcrop_sal,ld_lyrcrop_sal,ld_budcrop_own,ld_budcrop_own_tot,ld_budcrop_pur,ld_budcrop_pur_tot
string ls_todt, ls_ysdt,ls_ly_todt,ls_ly_ysdt

setpointer(hourglass!)

ls_todt = em_1.text 

select to_char(to_date((decode(sign(to_number(to_char(to_date(:ls_todt,'yyyymm'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'yyyymm'),'yyyy'))-1,to_number(to_char(to_date(:ls_todt,'yyyymm'),'yyyy')))||'0401'),'yyyymmdd'),'yyyymm'),
		to_char(to_date((to_char(to_date(:ls_todt,'yyyymm'),'dd/mm/')||(to_number(to_char(to_date(:ls_todt,'yyyymm'),'yyyy'))-1)),'dd/mm/yyyy'),'yyyymm'),
		to_char(to_date((decode(sign(to_number(to_char(to_date(:ls_todt,'yyyymm'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_todt,'yyyymm'),'yyyy'))-2,to_number(to_char(to_date(:ls_todt,'yyyymm'),'yyyy'))-1)||'0401'),'yyyymmdd'),'yyyymm')
  into :ls_ysdt,:ls_ly_todt,:ls_ly_ysdt from dual;

if sqlca.sqlcode =-1 then
	messagebox('SQL Error During Date Select',sqlca.sqlerrtext)
	return 1
end if

dw_1.settransobject(sqlca)
dw_1.retrieve(ls_todt,ls_ysdt,ls_ly_todt,ls_ly_ysdt)
setpointer(arrow!)

end event

type dw_1 from datawindow within w_gteacr009
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 4526
integer height = 2152
boolean bringtotop = true
string dataobject = "dw_gteacr009"
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

