$PBExportHeader$w_gtelaf015.srw
forward
global type w_gtelaf015 from window
end type
type cb_10 from commandbutton within w_gtelaf015
end type
type cb_9 from commandbutton within w_gtelaf015
end type
type cb_8 from commandbutton within w_gtelaf015
end type
type cb_7 from commandbutton within w_gtelaf015
end type
type cbx_4 from checkbox within w_gtelaf015
end type
type cb_6 from commandbutton within w_gtelaf015
end type
type cbx_3 from checkbox within w_gtelaf015
end type
type cbx_2 from checkbox within w_gtelaf015
end type
type cbx_1 from checkbox within w_gtelaf015
end type
type cb_5 from commandbutton within w_gtelaf015
end type
type rb_2 from radiobutton within w_gtelaf015
end type
type rb_1 from radiobutton within w_gtelaf015
end type
type st_3 from statictext within w_gtelaf015
end type
type st_2 from statictext within w_gtelaf015
end type
type ddlb_1 from dropdownlistbox within w_gtelaf015
end type
type cb_2 from commandbutton within w_gtelaf015
end type
type cb_1 from commandbutton within w_gtelaf015
end type
type st_1 from statictext within w_gtelaf015
end type
type cb_4 from commandbutton within w_gtelaf015
end type
type cb_3 from commandbutton within w_gtelaf015
end type
type gb_1 from groupbox within w_gtelaf015
end type
type dw_1 from datawindow within w_gtelaf015
end type
type em_1 from editmask within w_gtelaf015
end type
type dp_1 from datepicker within w_gtelaf015
end type
end forward

global type w_gtelaf015 from window
integer width = 5120
integer height = 3124
boolean titlebar = true
string title = "(w_gtelaf015) Employee Attendance"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_10 cb_10
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cbx_4 cbx_4
cb_6 cb_6
cbx_3 cbx_3
cbx_2 cbx_2
cbx_1 cbx_1
cb_5 cb_5
rb_2 rb_2
rb_1 rb_1
st_3 st_3
st_2 st_2
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
st_1 st_1
cb_4 cb_4
cb_3 cb_3
gb_1 gb_1
dw_1 dw_1
em_1 em_1
dp_1 dp_1
end type
global w_gtelaf015 w_gtelaf015

type variables
long ll_ctr, ll_cnt,l_ctr,ll_paybook,ll_temp,ll_user_level,ll_last,ll_retage,ll_year,ll_adoleage, ll_child,ll_round,ll_row
string ls_temp,ls_del_ind,ls_labour_id,ls_tmp_id,ls_entry_user,ls_last,ls_count,ls_emp_name,ls_paybook,ls_lwwid,ls_kam_id, ls_protect_flg,ls_dt,ls_task_ind, ls_prorata_ind
string ls_kam_id_old, ls_holidayflg,ls_prevatd,ls_nextatd, ls_emp_ty, ls_sex, ls_cam_ind, ls_sec1,ls_sec2,ls_sec3, ls_sec1_old,ls_sec2_old,ls_sec3_old, ls_secind,ls_measureind,ls_ccind, ls_lwwind,ls_div,ls_kamtype
string ls_nkam_type,ls_kam_sname,ls_JUNGLIFOOT_ind,ls_emptype,ls_gsnm, ls_daily_rate,ls_paidfg, ls_calfg,ls_pwvn, ls_nature, ls_date,ls_latta, ls_covid
boolean lb_neworder, lb_query
datetime ld_dt,ld_rundt,ld_stdt,ldenddt,ld_dob, ld_pwlastday
double ld_measure, ld_rate,ld_afrate, ld_ahrate, ld_adfrate, ld_adhrate, ld_cfrate,ld_chrate, ld_status, ld_wages,ld_lwwopn,ld_lwwavail,ld_sick, ld_mat, ld_covidsl
double ld_wages_old,ld_rtcp1,ld_rtcp2,ld_rtcp3,ld_rtlo1,ld_rtlo2,ld_rtlo3,ld_rtup1,ld_rtup2,ld_rtup3,ld_wagrtn,ld_exshwages,ld_labage,ld_elp, ld_kincentive,ld_sl, ld_m1,ld_m2,ld_m3,ld_m4,ld_rcp_diff
datawindowchild dwc_section1,dwc_section2,dwc_section3
n_cst_powerfilter iu_powerfilter
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_empid)
public function double wf_kamjari_rate (datetime fd_date, string fs_labourid, string fs_kamid, double fd_attendance, long fl_row)
public function integer wf_lwwopening (string fs_emp, long fl_lsid, datetime fd_dt)
public function integer wf_saveactivitydaily (string fs_date, string fs_labourid, string fd_kamid, string fs_secid, double fd_mandays, double fd_wages, double fd_measure, string fs_oldnew_ind, string fs_cam_ind, string fs_emp_ty, string fs_sex)
public function integer wf_cal_wages (double ld_measure1, double ld_measure2, double ld_measure3, long fl_row, double ld_status1)
end prototypes

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

public function integer wf_check_fillcol (integer fl_row);dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 0 and fl_row > 0 then
	if (not isnull(dw_1.getitemstring(fl_row,'kamsub_id')) or len(dw_1.getitemstring(fl_row,'kamsub_id')) > 0) and dw_1.getitemstring(fl_row,'kamsub_id') <> 'ESUB0258' and &
		 (isnull(dw_1.getitemnumber(fl_row,'lda_status')) or dw_1.getitemnumber(fl_row,'lda_status')=0 or &
		 isnull(dw_1.getitemnumber(fl_row,'lda_wages'))) then
	     messagebox('Warning: One Of The Following Fields Are Blank','Attendance, Wage, Please Check !!!')
		dw_1.SelectRow(fl_row, TRUE)
		 return -1
	elseif gs_garden_snm = 'KG' and (not isnull(dw_1.getitemstring(fl_row,'kamsub_id')) or len(dw_1.getitemstring(fl_row,'kamsub_id')) > 0) and dw_1.getitemstring(fl_row,'kamsub_id') <> 'ESUB0258' and &
		    ( ( (dw_1.getitemstring(fl_row,'kamsub_secind') = 'Y' and  (isnull(dw_1.getitemstring(fl_row,'lda_sectionid1')) or len(dw_1.getitemstring(fl_row,'lda_sectionid1')) = 0) ) or & 
			  (dw_1.getitemstring(fl_row,'kamsub_measind') = 'Y' and (isnull(dw_1.getitemnumber(fl_row,'lda_mfj_count1')) or dw_1.getitemnumber(fl_row,'lda_mfj_count1') = 0)) )) then
		messagebox('Warning: One Of The Following Fields Are Blank','Section, Measure, Please Check !!!')
		dw_1.SelectRow(fl_row, TRUE)
		return -1	
	elseif (not isnull(dw_1.getitemstring(fl_row,'kamsub_id')) or len(dw_1.getitemstring(fl_row,'kamsub_id')) > 0) and dw_1.getitemstring(fl_row,'kamsub_id') <> 'ESUB0258' and &
		    ( ( ( (isnull(dw_1.getitemstring(fl_row,'lda_sectionid1')) or len(dw_1.getitemstring(fl_row,'lda_sectionid1')) = 0) ) or & 
			  (dw_1.getitemstring(fl_row,'kamsub_measind') = 'Y' and (isnull(dw_1.getitemnumber(fl_row,'lda_mfj_count1')) or dw_1.getitemnumber(fl_row,'lda_mfj_count1') = 0)) )) then
		messagebox('Warning: One Of The Following Fields Are Blank','Section, Measure, Please Check !!!')
		dw_1.SelectRow(fl_row, TRUE)
		return -1	
//	elseif gs_garden_snm = 'MT' and dw_1.getitemstring(fl_row,'kamsub_id') = 'ESUB0163' and (isnull(dw_1.getitemstring(fl_row,'lda_mfj_junglifoot')) or (dw_1.getitemstring(fl_row,'lda_mfj_junglifoot') <> 'J' and dw_1.getitemstring(fl_row,'lda_mfj_junglifoot') <> 'F')) then
//		messagebox('Warning: Jungli / Foot Indicator Is Incorrect','Incase Of Plucking Jungli/Foot Indicator Must Be Jungli Or Foot (Not NONE) , Please Check !!!')
//		return -1			
	end if
end if
return 1

end function

public function integer wf_check_duplicate_rec (string fs_empid);long fl_row
string ls_empid1


dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_empid1 = dw_1.getitemstring(fl_row,'labour_id')
		if ls_empid1 = fs_empid then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function double wf_kamjari_rate (datetime fd_date, string fs_labourid, string fs_kamid, double fd_attendance, long fl_row);select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0))
into :ll_adoleage, :ll_child
from fb_param_detail 
where pd_doc_type in ('CHILDAGE','ADOLEAGE') and
		 trunc(:fd_date) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));

if sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
	return -1
end if;


//select ((:fd_date - emp_dob) /365),EMP_TYPE  into :ld_labage, :ls_emptype  from fb_employee emp  where emp.emp_id= :ls_labour_id;

select get_diff(:fd_date,emp_dob,'B'),EMP_TYPE  into :ld_labage, :ls_emptype  from fb_employee emp  where emp.emp_id= :ls_labour_id;
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Labour Age Detail',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if
// trunc(:ld_dt) between KAMSUB_FRDT and nvl(KAMSUB_TODT,sysdate) 
if gs_garden_snm='FB' and ls_emptype = 'LO' then
	if cbx_4.checked = true then	
		select rate afrate, 0 ahrate into :ld_afrate, :ld_ahrate from fb_cashpluckingrate
		where trim(kamsub_id) = :fs_kamid and trunc(:fd_date) between trunc(cp_dt_from) and trunc(nvl(cp_dt_to,sysdate));
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Labour Cash Rate Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	elseif cbx_4.checked = false then
		select kamsub_afrate afrate,kamsub_ahrate ahrate into :ld_afrate, :ld_ahrate from fb_fboutsiderwgrate
		where trim(kamsub_id) = :fs_kamid and trunc(:fd_date) between trunc(KAMSUB_FRDT) and trunc(nvl(KAMSUB_TODT,sysdate));
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if		
	end if
else	
	select kam.kamsub_afrate afrate, kam.kamsub_ahrate ahrate, kam.kamsub_adfrate adfrate, kam.kamsub_adhrate adhrate, kam.kamsub_cfrate cfrate,kam.kamsub_chrate chrate 
		into :ld_afrate, :ld_ahrate, :ld_adfrate, :ld_adhrate, :ld_cfrate,:ld_chrate 
	 from fb_kamsubhead kam
	where trim(kam.kamsub_id) = :fs_kamid and trunc(:fd_date) between trunc(KAMSUB_FRDT) and trunc(nvl(KAMSUB_TODT,sysdate));
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
end if

if gs_garden_snm='MT' then		
	select PH_HOURS into :ld_prorata_hours from fb_prorata_hours where PH_DATE = trunc(:fd_date);
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Prorat Hours ',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 100 then
		ld_prorata_hours=0
	end if
	
	if dw_1.getcolumnname() = 'lda_prorataind' then
		ls_prorata_ind = dw_1.gettext()
	else
		ls_prorata_ind = dw_1.getitemstring(dw_1.getrow(),'lda_prorataind')
	end if
	
//	if ld_prorata_hours > 0 and dw_1.getitemstring(fl_row,'lda_prorataind') ='Y'  then
	if ld_prorata_hours > 0 and ls_prorata_ind ='Y'  then
		If ld_labage <= ll_child Then //(144 months=12 years)
			 If fd_attendance = 1 Then
				 ld_rate = ld_cFrate - round(((ld_cFrate / 8) * ld_prorata_hours),0)
			elseIf fd_attendance = 0.5 Then
				 ld_rate = ld_cHrate - round(((ld_cHrate / 8) * ld_prorata_hours),0)
			else
				 ld_rate = ld_cFrate - round((((ld_cFrate * fd_attendance) / 8) * ld_prorata_hours),0)
			 End If
		 ElseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
			 If fd_attendance = 1 Then
				 ld_rate = ld_adfrate - round(((ld_adfrate / 8) * ld_prorata_hours),0)
			 elseIf fd_attendance = 0.5 Then
				 ld_rate = ld_adhrate - round(((ld_adhrate / 8) * ld_prorata_hours),0)
			else
				 ld_rate = ld_adfrate - round((((ld_adfrate * fd_attendance) / 8) * ld_prorata_hours),0)
			 End If
		 ElseIf ld_labage > ll_adoleage Then
			 If fd_attendance = 1 Then
				 ld_rate = ld_afrate - round(((ld_afrate / 8) * ld_prorata_hours),0)
			elseIf fd_attendance = 0.5 Then
				 ld_rate = ld_ahrate - round(((ld_ahrate / 8) * ld_prorata_hours),0)
			else
				 ld_rate = ld_afrate - round((((ld_afrate * fd_attendance) / 8) * ld_prorata_hours),0)
			 End If
		End If
	else
		If ld_labage <= ll_child Then //(144 months=12 years)
			 If fd_attendance = 1 Then
				 ld_rate = ld_cFrate
			elseif fd_attendance = 0.5 Then
				 ld_rate = ld_cHrate
			 else
				 ld_rate = ld_cFrate * fd_attendance
			End If
		 ElseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
			 If fd_attendance = 1 Then
				 ld_rate = ld_adfrate
			elseIf fd_attendance = 0.5 Then
				 ld_rate = ld_adhrate
			else
				 ld_rate = ld_adfrate * fd_attendance
			 End If
		 ElseIf ld_labage > ll_adoleage Then
			 If fd_attendance = 1 Then
				 ld_rate = ld_afrate
			elseIf fd_attendance = 0.5 Then
				 ld_rate = ld_ahrate
			else
				 ld_rate = ld_afrate * fd_attendance
			 End If
		End If
	end if	
elseif gs_garden_snm='FB' and ls_emptype = 'LO' then
	if cbx_4.checked = true then
		ld_rate = ld_aFrate
	else
		 If fd_attendance = 1 Then
			 ld_rate = ld_aFrate
		elseIf fd_attendance = 0.5 Then
			 ld_rate = ld_aHrate
		else
			 ld_rate = ld_aFrate * fd_attendance
		 End If		
	end if
else	// Other than Matelli
		If ld_labage <= ll_child Then //(144 months=12 years)
			 If fd_attendance = 1 Then
				 ld_rate = ld_cFrate
			elseIf fd_attendance = 0.5 Then
				 ld_rate = ld_cHrate
			else
				 ld_rate = ld_cFrate * fd_attendance
			 End If
		
		 ElseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
			 If fd_attendance = 1 Then
				 ld_rate = ld_adfrate
			elseIf fd_attendance = 0.5 Then
				 ld_rate = ld_adhrate
			else
				 ld_rate = ld_adfrate * fd_attendance
			 End If
		 ElseIf ld_labage > ll_adoleage Then
			 If fd_attendance = 1 Then
				 ld_rate = ld_afrate
			elseIf fd_attendance = 0.5 Then
				 ld_rate = ld_ahrate
			else
				 ld_rate = ld_afrate * fd_attendance
			 End If
		End If
end if

return ld_rate
end function

public function integer wf_lwwopening (string fs_emp, long fl_lsid, datetime fd_dt);string ls_LBP_ID ,ls_start_dt,ls_end_dt,ls_ID,ls_PFFLAG,ls_AVERAGEFLAG,ls_DAYSROUND,ls_LTYPE,ls_OTYPE,ls_PAIDHOLIDAY,ls_MATERNITY,ls_SICKALLOWANCE,Ls_PFROUND,Ls_NETROUND
double ld_LWWRATE,Ld_MINWDAYS,ld_FOODCONC,ld_earn
long ll_WDAYSDIVIDEBY
string ls_sql,ls_wdays,ls_wagesamo,ls_days,ls_earn,ls_fdconc,ls_pf,ls_fpf,ls_net,ls_rate

setnull(ls_LBP_ID);setnull(ls_start_dt);setnull(ls_end_dt);setnull(ls_ID);setnull(ls_PFFLAG);setnull(ls_AVERAGEFLAG);setnull(Ls_PFROUND);setnull(Ls_NETROUND)
setnull(ls_DAYSROUND);setnull(ls_PAIDHOLIDAY);setnull(ls_MATERNITY);setnull(ls_SICKALLOWANCE);setnull(ls_LTYPE);setnull(ls_OTYPE)
setnull(ls_sql);setnull(ls_wdays);setnull(ls_wagesamo);setnull(ls_days);setnull(ls_earn);setnull(ls_fdconc);setnull(ls_pf);setnull(ls_fpf);setnull(ls_net);setnull(ls_rate)
ld_LWWRATE=0;ld_FOODCONC=0;ll_WDAYSDIVIDEBY=0;Ld_MINWDAYS=0;ld_earn = 0;

select LLP_ID ,to_char(LLP_STARTDATE,'dd/mm/yyyy'),to_char(LLP_ENDDATE,'dd/mm/yyyy'),a.LS_ID,LLP_PFFLAG,
		LLP_WDAYSDIVIDEBY,LLP_AVERAGEFLAG,LLP_LWWRATE,LLP_DAYSROUND,LLP_FOODCONC,LLP_PAIDHOLIDAY,LLP_MATERNITY,
		LLP_SICKALLOWANCE,LLP_MINWDAYS,LLP_PFROUND,LLP_NETROUND,LS_LABOURTYPE,LS_OUTSIDERTYPE
into :ls_LBP_ID ,:ls_start_dt,:ls_end_dt,:ls_ID,:ls_PFFLAG,:ll_WDAYSDIVIDEBY,:ls_AVERAGEFLAG,:ld_LWWRATE,:ls_DAYSROUND,
	 				:ld_FOODCONC,:ls_PAIDHOLIDAY,:ls_MATERNITY,:ls_SICKALLOWANCE,:Ld_MINWDAYS,:Ls_PFROUND,:Ls_NETROUND,:ls_LTYPE,:ls_OTYPE		
  from fb_lablwwperiod a,( select distinct LS_ID,LS_LABOURTYPE,LS_OUTSIDERTYPE from fb_LABOURSHEET where LS_ACTIVE_IND = 'Y') b
 where trunc(:fd_dt) between trunc(LLP_STARTDATE) and trunc(LLP_ENDDATE) and a.LS_ID = b.ls_id and a.ls_id = :fl_lsid
 order by 1;

if sqlca.sqlcode = -1 then
	messagebox('SQL Error: During C1 Cursor',sqlca.sqlerrtext)
	return 1
end if

		If (ls_LTYPE = 'LP' Or ls_LTYPE = 'LT' Or (ls_LTYPE = 'LO' And ls_OTYPE = 'FACTORY')) Then
//			
//			 ls_wdays = "(SUM (lda.lda_status))"
//			 If ls_DAYSROUND = '1' Then
//					ls_days = "(round(SUM (lda.lda_status)/" + string(ll_WDAYSDIVIDEBY) + ",0))"
//			 Else
//					ls_days = "(round(SUM (lda.lda_status)/" + string(ll_WDAYSDIVIDEBY)  + ",2))"
//			 End If
//			 ls_wagesamo = "(round(SUM (lda.lda_wages + lda.lda_elp),2))"
//			 If ls_AVERAGEFLAG = '1' Then
//					ls_rate = "(ROUND(" + ls_wagesamo + " / " + ls_wdays + ",2))"
//			 Else
//					ls_rate = "(" + string(ld_LWWRATE) + ")"
//			 End If
//			 ls_earn = "(round(" + ls_days + " * " + ls_rate + " ,2))"
			 
//			 round( decode(:ls_DAYSROUND,'1',(round(SUM (lda.lda_status)/ :ll_WDAYSDIVIDEBY,0)),(round(SUM (lda.lda_status)/ :ll_WDAYSDIVIDEBY,2)) ) *  decode(:ls_AVERAGEFLAG,'1',(ROUND( (round(SUM (lda.lda_wages + lda.lda_elp),2)) / (SUM (lda.lda_status)),2)),:ld_LWWRATE) ,2)
		
//			 If ls_PAIDHOLIDAY = '0' And ls_MATERNITY = '0' And ls_SICKALLOWANCE = '0' Then
//			 		ls_sql = ls_sql + "    AND not exists (select kam.kamsub_id from fb_kamsubhead kam  where kam.kamsub_id = lda.kamsub_id and trim(kam.kamsub_nkamtype) in ('HOLIDAYPAY','MATERNITY','SICKALLOWANCE') ) "
//			 ElseIf ls_PAIDHOLIDAY = '0' And ls_MATERNITY = '0' And ls_SICKALLOWANCE = '1' Then
//			 		ls_sql = ls_sql + "    AND not exists (select kam.kamsub_id from fb_kamsubhead kam  where kam.kamsub_id = lda.kamsub_id and trim(kam.kamsub_nkamtype) in ('HOLIDAYPAY','MATERNITY') ) "
//			 ElseIf ls_PAIDHOLIDAY = '0' And ls_MATERNITY = '1' And ls_SICKALLOWANCE = '0' Then
//			 		ls_sql = ls_sql + "    AND not exists (select kam.kamsub_id from fb_kamsubhead kam  where kam.kamsub_id = lda.kamsub_id and trim(kam.kamsub_nkamtype) in ('HOLIDAYPAY','SICKALLOWANCE') ) "
//			 ElseIf ls_PAIDHOLIDAY = '1' And ls_MATERNITY = '0' And ls_SICKALLOWANCE = '0' Then
//			 		ls_sql = ls_sql + "    AND not exists (select kam.kamsub_id from fb_kamsubhead kam  where kam.kamsub_id = lda.kamsub_id and trim(kam.kamsub_nkamtype) in ('MATERNITY','SICKALLOWANCE') ) "
//			 ElseIf ls_PAIDHOLIDAY = '1' And ls_MATERNITY = '1' And ls_SICKALLOWANCE = '0' Then
//			 		ls_sql = ls_sql + "    AND not exists (select kam.kamsub_id from fb_kamsubhead kam  where kam.kamsub_id = lda.kamsub_id and trim(kam.kamsub_nkamtype) in ('SICKALLOWANCE') ) "
//			 ElseIf ls_PAIDHOLIDAY = '1' And ls_MATERNITY = '0' And ls_SICKALLOWANCE = '1' Then
//			 		ls_sql = ls_sql + "    AND not exists (select kam.kamsub_id from fb_kamsubhead kam  where kam.kamsub_id = lda.kamsub_id and trim(kam.kamsub_nkamtype) in ('MATERNITY') ) "
//			 ElseIf ls_PAIDHOLIDAY = '0' And ls_MATERNITY = '1' And ls_SICKALLOWANCE = '1' Then
//			 		ls_sql = ls_sql + "    AND not exists (select kam.kamsub_id from fb_kamsubhead kam  where kam.kamsub_id = lda.kamsub_id and trim(kam.kamsub_nkamtype) in ('HOLIDAYPAY') ) "
//			 ElseIf ls_PAIDHOLIDAY = '1' And ls_MATERNITY = '1' And ls_SICKALLOWANCE = '1' Then
//				ls_sql = ls_sql + " "
//			 End If
//			 ls_sql = ls_sql + "     AND (lda.lda_wages + lda.lda_elp) > 0 "
//			 ls_sql = ls_sql + "     AND emp.ls_id = '" + ls_id +"' "
//			 ls_sql = ls_sql + "     AND emp.emp_id = '" + fs_emp +"' "			 
//			 ls_sql = ls_sql + "     AND lda.lda_date between to_date('" +ls_start_dt+"','DD/MM/YYYY') and to_date('" +ls_end_dt+"','DD/MM/YYYY')  "
//			 ls_sql = ls_sql + "     GROUP BY emp.emp_id,nvl(emp.emp_pfdedcode,0)"

			 SELECT round( decode(:ls_DAYSROUND,'1',(round(SUM (lda.lda_status)/ :ll_WDAYSDIVIDEBY,0)),(round(SUM (lda.lda_status)/ :ll_WDAYSDIVIDEBY,2)) ) *  decode(:ls_AVERAGEFLAG,'1',(ROUND( (round(SUM (lda.lda_wages + lda.lda_elp),2)) / (SUM (lda.lda_status)),2)),:ld_LWWRATE) ,2) into :ld_earn
			 FROM fb_labourdailyattendance lda, fb_employee emp 
			 WHERE emp.emp_id = lda.labour_id and
					 not exists (select kam.kamsub_id from fb_kamsubhead kam  where kam.kamsub_id = lda.kamsub_id and nvl(KAMSUB_ACTIVE_IND,'Y') = 'Y' and trim(kam.kamsub_nkamtype) in 
						(decode(:ls_PAIDHOLIDAY,'0','HOLIDAYPAY',' '),decode(:ls_MATERNITY,'0','MATERNITY',' '),
						  decode(:ls_SICKALLOWANCE,'0','SICKALLOWANCE',' '))) AND (lda.lda_wages + lda.lda_elp) > 0 AND emp.ls_id = :ls_id AND 
				  emp.emp_id = :fs_emp AND trunc(lda.lda_date) between to_date(:ls_start_dt,'DD/MM/YYYY') and to_date(:ls_end_dt,'DD/MM/YYYY');

			if sqlca.sqlcode =-1 then
				messagebox('SQL Error: During Select',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if
		end if
		if isnull(ld_earn) then ld_earn = 0;

setpointer(Arrow!)

return ld_earn
end function

public function integer wf_saveactivitydaily (string fs_date, string fs_labourid, string fd_kamid, string fs_secid, double fd_mandays, double fd_wages, double fd_measure, string fs_oldnew_ind, string fs_cam_ind, string fs_emp_ty, string fs_sex);ll_last=0

if fs_oldnew_ind = 'O' then
		select distinct 'x' into :ls_temp from fb_taskactivedaily where TASK_ID = :fd_kamid and TASK_DATE = to_date(:fs_date,'dd/mm/yyyy') and SECTION_ID = :fs_secid;
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting taskactivedaily Detail',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		update fb_taskactivedaily set TASK_PMATODAYTY = nvl(TASK_PMATODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_PFATODAYTY = nvl(TASK_PFATODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_TMATODAYTY = nvl(TASK_TMATODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_TFATODAYTY = nvl(TASK_TFATODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_OMATODAYTY = nvl(TASK_OMATODAYTY,0) - decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_OFATODAYTY = nvl(TASK_OFATODAYTY,0) - decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_PMADTODAYTY = nvl(TASK_PMADTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_PFADTODAYTY = nvl(TASK_PFADTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_TMADTODAYTY = nvl(TASK_TMADTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_TFADTODAYTY = nvl(TASK_TFADTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_OMADTODAYTY = nvl(TASK_OMADTODAYTY,0) - decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_OFADTODAYTY = nvl(TASK_OFADTODAYTY,0) - decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_PMCTODAYTY = nvl(TASK_PMCTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_PFCTODAYTY = nvl(TASK_PFCTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_TMCTODAYTY = nvl(TASK_TMCTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_TFCTODAYTY = nvl(TASK_TFCTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_OMCTODAYTY = nvl(TASK_OMCTODAYTY,0) - decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_OFCTODAYTY = nvl(TASK_OFCTODAYTY,0) - decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_PMAWTODAYTY = nvl(TASK_PMAWTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0),
											  TASK_PFAWTODAYTY = nvl(TASK_PFAWTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_PMADWTODAYTY = nvl(TASK_PMADWTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0),
											  TASK_PFADWTODAYTY = nvl(TASK_PFADWTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
											  TASK_PMCWTODAYTY = nvl(TASK_PMCWTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
											  TASK_PFCWTODAYTY = nvl(TASK_PFCWTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
											  TASK_TMAWTODAYTY = nvl(TASK_TMAWTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_TFAWTODAYTY = nvl(TASK_TFAWTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_TMADWTODAYTY = nvl(TASK_TMADWTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
											  TASK_TFADWTODAYTY = nvl(TASK_TFADWTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
											  TASK_TMCWTODAYTY = nvl(TASK_TMCWTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
											  TASK_TFCWTODAYTY = nvl(TASK_TFCWTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
											  TASK_OMAWTODAYTY = nvl(TASK_OMAWTODAYTY,0) - decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_OFAWTODAYTY = nvl(TASK_OFAWTODAYTY,0) - decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_OMADWTODAYTY = nvl(TASK_OMADWTODAYTY,0) - decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
											  TASK_OFADWTODAYTY = nvl(TASK_OFADWTODAYTY,0) - decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0),  
											  TASK_OMCWTODAYTY = nvl(TASK_OMCWTODAYTY,0) - decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),   
											  TASK_OFCWTODAYTY = nvl(TASK_OFCWTODAYTY,0) - decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),
											  TASK_TOTWAGESTODAYTY = nvl(TASK_TOTWAGESTODAYTY,0) - nvl(:fd_wages,0)
		where TASK_ID = :fd_kamid and TASK_DATE = to_date(:fs_date,'dd/mm/yyyy') and SECTION_ID = :fs_secid;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Updating taskactivedaily Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		update fb_taskactivemeasurement set 	 TASK_PMACOUNTTODAYTY = nvl(TASK_PMACOUNTTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
															 TASK_PFACOUNTTODAYTY = nvl(TASK_PFACOUNTTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_TMACOUNTTODAYTY = nvl(TASK_TMACOUNTTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
															 TASK_TFACOUNTTODAYTY = nvl(TASK_TFACOUNTTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_OMACOUNTTODAYTY = nvl(TASK_OMACOUNTTODAYTY,0) - decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_OFACOUNTTODAYTY = nvl(TASK_OFACOUNTTODAYTY,0) - decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_PMADCOUNTTODAYTY = nvl(TASK_PMADCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_PFADCOUNTTODAYTY = nvl(TASK_PFADCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_TMADCOUNTTODAYTY = nvl(TASK_TMADCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_TFADCOUNTTODAYTY = nvl(TASK_TFADCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
															 TASK_OMADCOUNTTODAYTY = nvl(TASK_OMADCOUNTTODAYTY,0) - decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
															 TASK_OFADCOUNTTODAYTY = nvl(TASK_OFADCOUNTTODAYTY,0) - decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_PMCCOUNTTODAYTY = nvl(TASK_PMCCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
															 TASK_PFCCOUNTTODAYTY = nvl(TASK_PFCCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0),
															 TASK_TMCCOUNTTODAYTY = nvl(TASK_TMCCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
															 TASK_TFCCOUNTTODAYTY = nvl(TASK_TFCCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
															 TASK_OMCCOUNTTODAYTY = nvl(TASK_OMCCOUNTTODAYTY,0) - decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0),
															 TASK_OFCCOUNTTODAYTY  = nvl(TASK_OFCCOUNTTODAYTY,0) - decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0)
		where TASKSECTION_ID = (select TASKDATE_ID from fb_taskactivedaily where TASK_ID = :fd_kamid and TASK_DATE = to_date(:fs_date,'dd/mm/yyyy') and SECTION_ID = :fs_secid);
	
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Updating taskactivemeasurement Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	end if	
	
elseif fs_oldnew_ind = 'N' then
	select distinct 'x' into :ls_temp from fb_taskactivedaily where TASK_ID = :fd_kamid and TASK_DATE = to_date(:fs_date,'dd/mm/yyyy') and SECTION_ID = :fs_secid;
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting taskactivedaily Detail',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
			
		update fb_taskactivedaily set TASK_PMATODAYTY = nvl(TASK_PMATODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_PFATODAYTY = nvl(TASK_PFATODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_TMATODAYTY = nvl(TASK_TMATODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_TFATODAYTY = nvl(TASK_TFATODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_OMATODAYTY = nvl(TASK_OMATODAYTY,0) + decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_OFATODAYTY = nvl(TASK_OFATODAYTY,0) + decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_PMADTODAYTY = nvl(TASK_PMADTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_PFADTODAYTY = nvl(TASK_PFADTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_TMADTODAYTY = nvl(TASK_TMADTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_TFADTODAYTY = nvl(TASK_TFADTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_OMADTODAYTY = nvl(TASK_OMADTODAYTY,0) + decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_OFADTODAYTY = nvl(TASK_OFADTODAYTY,0) + decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_PMCTODAYTY = nvl(TASK_PMCTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_PFCTODAYTY = nvl(TASK_PFCTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_TMCTODAYTY = nvl(TASK_TMCTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_TFCTODAYTY = nvl(TASK_TFCTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_OMCTODAYTY = nvl(TASK_OMCTODAYTY,0) + decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_OFCTODAYTY = nvl(TASK_OFCTODAYTY,0) + decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_PMAWTODAYTY = nvl(TASK_PMAWTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0),
											  TASK_PFAWTODAYTY = nvl(TASK_PFAWTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_PMADWTODAYTY = nvl(TASK_PMADWTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0),
											  TASK_PFADWTODAYTY = nvl(TASK_PFADWTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
											  TASK_PMCWTODAYTY = nvl(TASK_PMCWTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
											  TASK_PFCWTODAYTY = nvl(TASK_PFCWTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
											  TASK_TMAWTODAYTY = nvl(TASK_TMAWTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_TFAWTODAYTY = nvl(TASK_TFAWTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_TMADWTODAYTY = nvl(TASK_TMADWTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
											  TASK_TFADWTODAYTY = nvl(TASK_TFADWTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
											  TASK_TMCWTODAYTY = nvl(TASK_TMCWTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
											  TASK_TFCWTODAYTY = nvl(TASK_TFCWTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
											  TASK_OMAWTODAYTY = nvl(TASK_OMAWTODAYTY,0) + decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_OFAWTODAYTY = nvl(TASK_OFAWTODAYTY,0) + decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_OMADWTODAYTY = nvl(TASK_OMADWTODAYTY,0) + decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
											  TASK_OFADWTODAYTY = nvl(TASK_OFADWTODAYTY,0) + decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0),  
											  TASK_OMCWTODAYTY = nvl(TASK_OMCWTODAYTY,0) + decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),   
											  TASK_OFCWTODAYTY = nvl(TASK_OFCWTODAYTY,0) + decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),
											  TASK_TOTWAGESTODAYTY = nvl(TASK_TOTWAGESTODAYTY,0) + nvl(:fd_wages,0)
		where TASK_ID = :fd_kamid and TASK_DATE = to_date(:fs_date,'dd/mm/yyyy') and SECTION_ID = :fs_secid;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Updating taskactivedaily Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		update fb_taskactivemeasurement set 	 TASK_PMACOUNTTODAYTY = nvl(TASK_PMACOUNTTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
															 TASK_PFACOUNTTODAYTY = nvl(TASK_PFACOUNTTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_TMACOUNTTODAYTY = nvl(TASK_TMACOUNTTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
															 TASK_TFACOUNTTODAYTY = nvl(TASK_TFACOUNTTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_OMACOUNTTODAYTY = nvl(TASK_OMACOUNTTODAYTY,0) + decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_OFACOUNTTODAYTY = nvl(TASK_OFACOUNTTODAYTY,0) + decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_PMADCOUNTTODAYTY = nvl(TASK_PMADCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_PFADCOUNTTODAYTY = nvl(TASK_PFADCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_TMADCOUNTTODAYTY = nvl(TASK_TMADCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_TFADCOUNTTODAYTY = nvl(TASK_TFADCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
															 TASK_OMADCOUNTTODAYTY = nvl(TASK_OMADCOUNTTODAYTY,0) + decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
															 TASK_OFADCOUNTTODAYTY = nvl(TASK_OFADCOUNTTODAYTY,0) + decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_PMCCOUNTTODAYTY = nvl(TASK_PMCCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
															 TASK_PFCCOUNTTODAYTY = nvl(TASK_PFCCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0),
															 TASK_TMCCOUNTTODAYTY = nvl(TASK_TMCCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
															 TASK_TFCCOUNTTODAYTY = nvl(TASK_TFCCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
															 TASK_OMCCOUNTTODAYTY = nvl(TASK_OMCCOUNTTODAYTY,0) + decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0),
															 TASK_OFCCOUNTTODAYTY  = nvl(TASK_OFCCOUNTTODAYTY,0) + decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0)
		where TASKSECTION_ID = (select TASKDATE_ID from fb_taskactivedaily where TASK_ID = :fd_kamid and TASK_DATE = to_date(:fs_date,'dd/mm/yyyy') and SECTION_ID = :fs_secid);
	
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Updating taskactivemeasurement Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	elseif sqlca.sqlcode = 100 then
			if ll_last=0 then
				select nvl(MAX(substr(TASKDATE_ID,9,10)),0) into :ll_last from fb_taskactivedaily;
			end if
			ll_last = ll_last + 1
			ls_tmp_id = 'TASKDATE'+string(ll_last,'0000000000')
		
		insert into fb_taskactivedaily(TASK_ID, TASK_DATE, TASKDATE_ID, 
											 TASK_PMATODAYTY, TASK_PFATODAYTY, TASK_TMATODAYTY, TASK_TFATODAYTY, 
											 TASK_OMATODAYTY, TASK_OFATODAYTY, 
											 TASK_PMADTODAYTY, TASK_PFADTODAYTY, TASK_TMADTODAYTY, TASK_TFADTODAYTY, 
											 TASK_OMADTODAYTY, TASK_OFADTODAYTY, 
											 TASK_PMCTODAYTY, TASK_PFCTODAYTY, TASK_TMCTODAYTY, TASK_TFCTODAYTY, 
											 TASK_OMCTODAYTY, TASK_OFCTODAYTY, 
											 TASK_PMAWTODAYTY, TASK_PFAWTODAYTY, TASK_PMADWTODAYTY, TASK_PFADWTODAYTY, 
											 TASK_PMCWTODAYTY, TASK_PFCWTODAYTY, 
											 TASK_TMAWTODAYTY, TASK_TFAWTODAYTY, TASK_TMADWTODAYTY, TASK_TFADWTODAYTY,
											 TASK_TMCWTODAYTY, TASK_TFCWTODAYTY, 
											 TASK_OMAWTODAYTY, TASK_OFAWTODAYTY, TASK_OMADWTODAYTY,TASK_OFADWTODAYTY, 
											 TASK_OMCWTODAYTY, TASK_OFCWTODAYTY, 
											 TASK_TOTWAGESTODAYTY, SECTION_ID,
											 TASK_PMATODATETY, TASK_PFATODATETY, TASK_TMATODATETY, TASK_TFATODATETY, 
											 TASK_OMATODATETY, TASK_OFATODATETY, TASK_PMADTODATETY, TASK_PFADTODATETY, 
											 TASK_TMADTODATETY, TASK_TFADTODATETY, TASK_OMADTODATETY, TASK_OFADTODATETY, 
											 TASK_PMCTODATETY, TASK_PFCTODATETY, TASK_TMCTODATETY, TASK_TFCTODATETY, 
											 TASK_OMCTODATETY, TASK_OFCTODATETY, TASK_TOTWAGESTODATETY)
		values(:fd_kamid,to_date(:fs_date,'dd/mm/yyyy'),:ls_tmp_id,
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
				  decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0), 
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),  
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0),  
				 decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),   
				 decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),
				 nvl(:fd_wages,0),:fs_secid,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Inserting taskactivedaily Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	
		insert into fb_taskactivemeasurement (TASKSECTION_ID, TASK_PMACOUNTTODAYTY, TASK_PFACOUNTTODAYTY, TASK_TMACOUNTTODAYTY, 
															TASK_TFACOUNTTODAYTY, TASK_OMACOUNTTODAYTY, TASK_OFACOUNTTODAYTY, TASK_PMADCOUNTTODAYTY, 
															TASK_PFADCOUNTTODAYTY, TASK_TMADCOUNTTODAYTY, TASK_TFADCOUNTTODAYTY, 
															TASK_OMADCOUNTTODAYTY, TASK_OFADCOUNTTODAYTY, TASK_PMCCOUNTTODAYTY, TASK_PFCCOUNTTODAYTY, 
															TASK_TMCCOUNTTODAYTY, TASK_TFCCOUNTTODAYTY, TASK_OMCCOUNTTODAYTY, TASK_OFCCOUNTTODAYTY,
															TASK_PMACOUNTTODATETY, TASK_PFACOUNTTODATETY, TASK_TMACOUNTTODATETY, TASK_TFACOUNTTODATETY, 
															TASK_OMACOUNTTODATETY, TASK_OFACOUNTTODATETY, TASK_PMADCOUNTTODATETY, TASK_PFADCOUNTTODATETY, 
															TASK_TMADCOUNTTODATETY, TASK_TFADCOUNTTODATETY, TASK_OMADCOUNTTODATETY, 
															TASK_OFADCOUNTTODATETY, TASK_PMCCOUNTTODATETY, TASK_PFCCOUNTTODATETY, TASK_TMCCOUNTTODATETY, 
															TASK_TFCCOUNTTODATETY, TASK_OMCCOUNTTODATETY, TASK_OFCCOUNTTODATETY)
		values(:ls_tmp_id,
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),  
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'CT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0),   
				 decode(:fs_emp_ty,'CT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0),
				 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
				 
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Inserting taskactivemeasurement Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
	end if
//	commit using sqlca;
end if
return 1
end function

public function integer wf_cal_wages (double ld_measure1, double ld_measure2, double ld_measure3, long fl_row, double ld_status1);		//string ls_JUNGLIFOOT_ind
	ld_wages = 0;	ld_exshwages = 0;ld_rtcp1=0;ld_rtcp2=0;ld_rtlo1=0;ld_rtlo2=0;ld_rtup1=0;ld_rtup2=0
 
		if isnull(ld_measure1) then ld_measure1 = 0;
		if isnull(ld_measure2) then ld_measure2 = 0;
		if isnull(ld_measure3) then ld_measure3 = 0;
		
		ld_measure =  ld_measure1 + ld_measure2 + ld_measure3

//		ld_status1 = dw_1.getitemnumber(fl_row,'lda_status')
		ls_kam_id = dw_1.getitemstring(fl_row,'kamsub_id')
		ls_labour_id = dw_1.getitemstring(fl_row,'labour_id')
		ld_dt = dw_1.getitemdatetime(fl_row,'lda_date')
		ls_JUNGLIFOOT_ind = dw_1.getitemstring(fl_row,'lda_mfj_junglifoot')
		
		select emp.emp_dob labdob, get_diff(:ld_dt,emp_dob,'B'), emp_type, ls_id,field_id into :ld_dob, :ld_labage, :ls_emptype, :ll_paybook,:ls_div//, ((:ld_dt - emp_dob) /365)
		  from fb_employee emp
		 where emp.emp_id= :ls_labour_id;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Labour Age Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		
		select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0))
		into :ll_adoleage, :ll_child
		from fb_param_detail 
		where pd_doc_type in ('CHILDAGE','ADOLEAGE') and
				 trunc(:ld_dt) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));
	
		if sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
			return -1
		end if;
 		if gs_garden_snm = 'FB' or gs_garden_snm = 'MK' or gs_garden_snm = 'ME' or gs_garden_snm = 'KG' or gs_garden_snm = 'BE' or gs_garden_snm = 'MV' or gs_garden_snm = 'SP' then
			If ld_labage <= ll_child Then //(144 months=12 years)
	
				select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0) , nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
				into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
				from fb_task_fulbari 
				where TASK_EMPTYPE = :ls_emptype and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'CHILD' ;
						
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			elseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
				select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0) , nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
				into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
				from fb_task_fulbari 
				where TASK_EMPTYPE = :ls_emptype and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADOLE' ;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if 		
			elseIf ld_labage > ll_adoleage then
				select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0) , nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
				into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
				from fb_task_fulbari 
				where TASK_EMPTYPE = :ls_emptype and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADULT'  ;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if 
			end if
		else
			If ld_labage <= ll_child Then //(144 months=12 years)
	
				select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0), nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
				into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
				from fb_task 
				where TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'CHILD'; //and
						//(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N')));
						
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			elseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
				select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0), nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
				into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
				from fb_task 
				where TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADOLE';// and
						//(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if 		
			elseIf ld_labage > ll_adoleage then
				select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0), nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
				into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
				from fb_task 
				where TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADULT';// and
						//(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if 
			end if	
		end if		
		ld_wagrtn = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status1,fl_row)
		
//		if gs_garden_snm ='MB'		then	// For MONOBAG
//		
//			if ld_measure >= ld_rtcp1 then
//				ld_wages = (ld_wagrtn - (ld_rtcp1 * ld_rtlo1) + (ld_measure * ld_rtup1))
//				ld_exshwages = ld_wages - ld_wagrtn
//			else
//				ld_wages = (ld_wagrtn - (ld_rtcp1 * ld_rtlo1) + (ld_measure * ld_rtlo1))
//			    ld_exshwages = ld_wages - ld_wagrtn 
//			end if
		// Plucking Incentive If Applicable
		
//				double ld_incrt, ld_inckg	,ld_incamt
//				
//				select sum(decode(PD_DOC_TYPE,'PLUINCRT',nvl(PD_VALUE,0),0)), sum(decode(PD_DOC_TYPE ,'PLUINCKG',nvl(PD_VALUE,0),0))
//					into :ld_incrt, :ld_inckg
//				  from fb_param_detail 
//				 where PD_DOC_TYPE in ('PLUINCRT','PLUINCKG') and :ld_dt between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate)) ;
//				 
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : Getting Incentive KG/Rate',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				end if 			
//				if isnull(ld_incrt) then ld_incrt=0
//				if isnull(ld_inckg) then ld_inckg=0			
//				
//				if ld_measure > ld_inckg then
//					ld_incamt = (ld_measure - ld_inckg) * ld_incrt
//				end if
//				ld_wages = ld_wages + ld_incamt
//				ld_exshwages = ld_exshwages + ld_incamt
//		 END Plucking Incentive If Applicable

//		else	// Other Than MONOBAG
if gs_garden_snm='MT' then		
	select PH_HOURS into :ld_prorata_hours from fb_prorata_hours where PH_DATE = trunc(:ld_dt);
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Prorat Hours ',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 100 then
		ld_prorata_hours=0
	end if
//Comented As per discussion with Sanjay Sir & Novin Sarkar (Matellie) on 21-May-2014
//	if dw_1.getcolumnname() = 'lda_prorataind' then
//		ls_prorata_ind = dw_1.gettext()
//	else
//		ls_prorata_ind = dw_1.getitemstring(dw_1.getrow(),'lda_prorataind')
//	end if
//
//	if ld_prorata_hours > 0 and ls_prorata_ind ='Y'  then
//		 ld_rtcp1 = ld_rtcp1 - truncate(((ld_rtcp1 / 8) * ld_prorata_hours),0)
//		 ld_rtcp2 = ld_rtcp2 - truncate(((ld_rtcp2 / 8) * ld_prorata_hours),0)
//	end if
end if

if gs_garden_snm = 'FB' then
	ls_sec1 = dw_1.getitemstring(fl_row,'lda_sectionid1')
	if not isnull(ls_sec1) or len(ls_sec1) > 0  then
		select max(nvl(SPR_ROUND,0)) into :ll_round from fb_sectionpluckinground where SECTION_ID = :ls_sec1 and trunc(SPR_DATE) = trunc(:ld_dt);
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Round Days ',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then
			ll_round = 0
		end if
		if isnull(ll_round) then ll_round = 0;
		if ll_round > 0 and ll_round <= 5 then
			ld_rcp_diff = ld_rtcp2 - ld_rtcp1
			ld_rtcp1 = round((ld_rtcp1 * (100 - 40) / 100),0)
			ld_rtcp2 = ld_rtcp1 + ld_rcp_diff
		elseif ll_round = 6 then
			ld_rcp_diff = ld_rtcp2 - ld_rtcp1
			ld_rtcp1 = round((ld_rtcp1 * (100 - 30) / 100),0)
			ld_rtcp2 = ld_rtcp1 + ld_rcp_diff
		elseif ll_round = 7 or ll_round = 8 then
			ld_rcp_diff = ld_rtcp2 - ld_rtcp1
			ld_rtcp1 = round((ld_rtcp1 * (100 - 15) / 100),0)
			ld_rtcp2 = ld_rtcp1 + ld_rcp_diff			
		end if
	end if
end if //gs_garden_snm = 'FB' then

if isnull(ld_rtcp3) then ld_rtcp3 = 0
if ld_rtcp3 = 0 then		
	if ld_measure = ld_rtcp1 then
		ld_wages = ld_wagrtn
	elseif ld_measure > ld_rtcp1 and ld_measure <= ld_rtcp2 then
		ld_wages = ld_wagrtn + ((ld_measure - ld_rtcp1) * ld_rtup1)
		ld_exshwages = ((ld_measure - ld_rtcp1) * ld_rtup1)
	elseif ld_measure > ld_rtcp2 then
		ld_wages = ld_wagrtn + ((ld_rtcp2 - ld_rtcp1) * ld_rtup1) + ((ld_measure - ld_rtcp2) * ld_rtup2)
		ld_exshwages = ((ld_rtcp2 - ld_rtcp1) * ld_rtup1) + ((ld_measure - ld_rtcp2) * ld_rtup2)
	elseif ld_measure >= (ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) and ld_measure < ld_rtcp1 then
		ld_wages = ld_wagrtn - ((ld_rtcp1 - ld_measure) * ld_rtlo1)
		ld_exshwages =  (-1) * ((ld_rtcp1 - ld_measure) * ld_rtlo1)
	elseif ld_measure < (ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) then
		if ld_rtlo2 > 0 then
			ld_wages = ld_wagrtn - ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) - ld_measure) * ld_rtlo2) )
			ld_exshwages =  (-1) * ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) - ld_measure) * ld_rtlo2) )
		elseif ld_rtlo2 = 0 then
			ld_wages = ld_wagrtn - ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) - ld_measure) * ld_rtlo1) )
			ld_exshwages =  (-1) * ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) - ld_measure) * ld_rtlo1) )
		end if
	end if
elseif ld_rtcp3 > 0 then	
	if ld_measure = ld_rtcp1 then
		ld_wages = ld_wagrtn
	elseif ld_measure > ld_rtcp1 and ld_measure <= ld_rtcp2 then
		ld_wages = ld_wagrtn + ((ld_measure - ld_rtcp1) * ld_rtup1)
		ld_exshwages = ((ld_measure - ld_rtcp1) * ld_rtup1)
	elseif ld_measure > ld_rtcp2 and ld_measure <= ld_rtcp3 then
		ld_wages = ld_wagrtn + ((ld_rtcp2 - ld_rtcp1) * ld_rtup1) + ((ld_measure - ld_rtcp2) * ld_rtup2)
		ld_exshwages = ((ld_rtcp2 - ld_rtcp1) * ld_rtup1) + ((ld_measure - ld_rtcp2) * ld_rtup2)
	elseif ld_measure > ld_rtcp3 and ld_rtcp3 > 0 then
		ld_wages = ld_wagrtn + ((ld_rtcp2 - ld_rtcp1) * ld_rtup1) + ((ld_rtcp3 - ld_rtcp2) * ld_rtup2) + ((ld_measure - ld_rtcp3) * ld_rtup3)
		ld_exshwages = ((ld_rtcp2 - ld_rtcp1) * ld_rtup1) + ((ld_rtcp3 - ld_rtcp2) * ld_rtup2) + ((ld_measure - ld_rtcp3) * ld_rtup3)
	elseif ld_measure >= (ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) and ld_measure < ld_rtcp1 then
		ld_wages = ld_wagrtn - ((ld_rtcp1 - ld_measure) * ld_rtlo1)
		ld_exshwages =  (-1) * ((ld_rtcp1 - ld_measure) * ld_rtlo1)
	elseif ld_measure >= (ld_rtcp1 - (ld_rtcp2 - ld_rtcp1) - (ld_rtcp3 - ld_rtcp2)) and ld_measure < (ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) then
		if ld_rtlo2 > 0 then
			ld_wages = ld_wagrtn - ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) - ld_measure) * ld_rtlo2) )
			ld_exshwages =  (-1) * ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) - ld_measure) * ld_rtlo2) )
		elseif ld_rtlo2 = 0 then
			ld_wages = ld_wagrtn - ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) - ld_measure) * ld_rtlo1) )
			ld_exshwages =  (-1) * ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1)) - ld_measure) * ld_rtlo1) )
		end if
	elseif ld_measure < (ld_rtcp1 - (ld_rtcp2 - ld_rtcp1) - (ld_rtcp3 - ld_rtcp2)) then
		if ld_rtlo3 > 0 then
			ld_wages = ld_wagrtn - ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp3 - (ld_rtcp2 - ld_rtcp1)) - ld_rtcp1) * ld_rtlo2) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1) - (ld_rtcp3 - ld_rtcp2)) - ld_measure) * ld_rtlo3) )
			ld_exshwages =  (-1) * ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp3 - (ld_rtcp2 - ld_rtcp1)) - ld_rtcp1) * ld_rtlo2) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1) - (ld_rtcp3 - ld_rtcp2)) - ld_measure) * ld_rtlo3) )
		elseif ld_rtlo3 = 0 then
			ld_wages = ld_wagrtn - ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp3 - (ld_rtcp2 - ld_rtcp1)) - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1) - (ld_rtcp3 - ld_rtcp2)) - ld_measure) * ld_rtlo1) )
			ld_exshwages =  (-1) * ( ((ld_rtcp2 - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp3 - (ld_rtcp2 - ld_rtcp1)) - ld_rtcp1) * ld_rtlo1) + (((ld_rtcp1 - (ld_rtcp2 - ld_rtcp1) - (ld_rtcp3 - ld_rtcp2)) - ld_measure) * ld_rtlo1) )
		end if	
	end if
end if
		

		dw_1.setitem(fl_row,'lda_task',ld_rtcp1)
		dw_1.setitem(fl_row,'lda_elp',ld_exshwages)
		ls_kam_id = dw_1.getitemstring(fl_row,'kamsub_id')
		ls_daily_rate = dw_1.getitemstring(fl_row,'lda_daily_rateind')
		
		ld_dt = dw_1.getitemdatetime(fl_row,'lda_date')
		
		if gs_garden_snm='FB' and ls_emptype = 'LO' and cbx_4.checked = true then
			ld_wages = ld_measure * ld_wagrtn
			dw_1.setitem(fl_row,'lda_wages',ld_wages)
		elseif gs_garden_snm='FB' and cbx_4.checked = false and ls_daily_rate = 'Y' then
			
			select kam.kamsub_afrate afrate into :ld_afrate from fb_kamsubhead kam
			where trim(kam.kamsub_id) = :ls_kam_id and trunc(:ld_dt) between KAMSUB_FRDT and nvl(KAMSUB_TODT,sysdate) ;
			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if	
			if isnull(ld_afrate) then ld_afrate = 0;			
			ld_wages = ld_afrate
			dw_1.setitem(fl_row,'lda_wages',ld_wages)
			dw_1.setitem(fl_row,'lda_elp',0)
		else
			select nvl(INC_AMTPERDAY,0) into :ld_kincentive from fb_incentive 
			where INC_REC_TYPE = 'K' and KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(trunc(INC_TODT),trunc(sysdate));
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Kamjari Incentive Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 100 then
				if gs_garden_state = '03' and ld_measure >= ld_rtcp1 then
					if ls_kam_id = 'ESUB0163' then // changed on 13012014 as per issue no C0001277
						dw_1.setitem(fl_row,'lda_wages',ld_wages + 0.6)
						dw_1.setitem(fl_row,'lda_elp',ld_exshwages + 0.6)
					else
						dw_1.setitem(fl_row,'lda_wages',ld_wages)
						dw_1.setitem(fl_row,'lda_elp',ld_exshwages)						
					end if
				else
					dw_1.setitem(fl_row,'lda_wages',ld_wages)
				end if
			elseif sqlca.sqlcode = 0 then
				if isnull(ld_kincentive) then ld_kincentive = 0;
				ld_wages = ld_wages + ld_kincentive
				dw_1.setitem(fl_row,'lda_wages',ld_wages)
				//dw_1.setitem(fl_row,'lda_latta',ld_kincentive) 
			end if
		end if
end function

on w_gtelaf015.create
this.cb_10=create cb_10
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cbx_4=create cbx_4
this.cb_6=create cb_6
this.cbx_3=create cbx_3
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.cb_5=create cb_5
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_3=create st_3
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.gb_1=create gb_1
this.dw_1=create dw_1
this.em_1=create em_1
this.dp_1=create dp_1
this.Control[]={this.cb_10,&
this.cb_9,&
this.cb_8,&
this.cb_7,&
this.cbx_4,&
this.cb_6,&
this.cbx_3,&
this.cbx_2,&
this.cbx_1,&
this.cb_5,&
this.rb_2,&
this.rb_1,&
this.st_3,&
this.st_2,&
this.ddlb_1,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.cb_4,&
this.cb_3,&
this.gb_1,&
this.dw_1,&
this.em_1,&
this.dp_1}
end on

on w_gtelaf015.destroy
destroy(this.cb_10)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cbx_4)
destroy(this.cb_6)
destroy(this.cbx_3)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.cb_5)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.em_1)
destroy(this.dp_1)
end on

event open;dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
//dw_1.modify("t_co.text = '"+gs_co_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)
rb_1.triggerevent(clicked!)

setnull(ld_dt)

ddlb_1.reset()

ld_dt = datetime(dp_1.value)

ddlb_1.additem('ALL {00}')

setnull(ls_paybook)

ls_gsnm = gs_garden_snm

DECLARE c2 CURSOR FOR  
select initcap(LS_MANID)||' {'||lpad(to_char(ls_id),2,'0')||'}' from fb_laboursheet 
 where ls_id in (select distinct ls_id from fb_employee e where (e.emp_active='1' or EMP_JOBLEAVINGDATE = TO_DATE('30-Nov-2024', 'DD-Mon-YYYY'))) AND 
		 (:ls_gsnm = 'FB' or (:ls_gsnm <> 'FB' and  ls_outsidertype<>'NON FACTORY')) AND 
		 ls_id not in (select ls_id from fb_laboursheetattendance lsa,fb_labourwagesweek lww 
		  				 where lsa.lww_id=lww.lww_id  and trunc(lsa.lsa_date) = trunc(:ld_dt) and 
							  	 (lsa.lsa_attendanceconfirm='1' or lww.lww_paidflag='1'))  and LS_ACTIVE_IND = 'Y'
 order by to_number(ls_id);

open c2;

IF sqlca.sqlcode = 0 THEN
	fetch c2 into :ls_paybook;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(string(ls_paybook))
		fetch c2 into :ls_paybook;
	loop
	close c2;
end if

ddlb_1.text = 'ALL {00}'

if gs_garden_state = '03' then
	cbx_1.checked = true
//	dw_1.settaborder('lda_status',0)
	cb_5.enabled = false
	cb_8.enabled = false
else
	cbx_1.checked = false
	cb_5.enabled = true
	cb_8.enabled = true
end if

if gs_garden_snm = 'FB'  then
	cbx_4.visible = true
else
	cbx_4.visible = false
end if


setpointer(arrow!)

dw_1.GetChild ("lda_sectionid1", dwc_section1)
dw_1.GetChild ("lda_sectionid2", dwc_section2)
dw_1.GetChild ("lda_sectionid3", dwc_section3)
dwc_section1.settransobject(sqlca)
dwc_section2.settransobject(sqlca)
dwc_section3.settransobject(sqlca)	
if gs_garden_snm = 'AB' or gs_garden_snm = 'SP' or gs_garden_snm = 'LP' or gs_garden_snm = 'MR'  or gs_garden_snm = 'AD' or gs_garden_snm = 'MH' or gs_garden_snm = 'DR' then
	cb_8.visible = true
else 
	cb_8.visible = false
end if 


end event

event key;//IF KeyDown(KeyEscape!) THEN
//	cb_4.triggerevent(clicked!)
//end if
IF KeyDown(KeyF1!) THEN
	cb_1.triggerevent(clicked!)
end if
IF KeyDown(KeyF2!) THEN
	cb_2.triggerevent(clicked!)
end if
IF KeyDown(KeyF3!) THEN
	if dw_1.rowcount() > 0  then
		cb_3.triggerevent(clicked!)
	end if
end if
end event

type cb_10 from commandbutton within w_gtelaf015
boolean visible = false
integer x = 4613
integer y = 372
integer width = 366
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "LWW ALL"
end type

event clicked;if gs_garden_state = '03' then
	ld_dt = datetime(em_1.text)
	if isnull(ld_dt) or em_1.text = '00/00/0000' then
		messagebox('Warning!','Please Select A Attendance Date !!!')
		return 1
	end if
	
	if date(em_1.text) > date(today()) then
		messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
		return 1
	end if		
else
	if isnull(dp_1.text) or dp_1.text = '00/00/0000' then
		messagebox('Warning!','Please Select A Attendance Date !!!')
		return 1
	end if
	
	if date(dp_1.text) > date(today()) then
		messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
		return 1
	end if
	ld_dt = datetime(dp_1.text)
end if

if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning!','Please Select A Pay Book No. Or "ALL {00}" !!!')
	return 1
end if


ll_paybook = long(left(right(ddlb_1.text,3),2))

IF MessageBox(" Alert", 'Do You Want To Set LWW For ALL ....?' ,Exclamation!, YesNo!, 2) = 1 THEN

	setpointer(hourglass!)	
	n_fames luo_fames
	luo_fames = Create n_fames

	ll_adoleage = 0 ;ll_child=0
 
	select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0)) into :ll_adoleage, :ll_child
	from fb_param_detail 
	where pd_doc_type in ('CHILDAGE','ADOLEAGE') and trunc(:ld_dt) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));
	
	if sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
		return 1
	end if;
	
	select nvl(MAX(JOB_ID),0) into :ls_last from fb_labourdailyattendance where JOB_ID like 'JOB%';
	ls_last = right(ls_last,10)
	ll_cnt = long(ls_last)
	
	select lww_startdate,lww_enddate,lww_id into :ld_stdt, :ldenddt, :ls_lwwid from fb_labourwagesweek 
	where trunc(:ld_dt) between trunc(lww_startdate) and trunc(lww_enddate) and lww_paidflag='0';
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 100 then
		messagebox('Warning!','The Entered Attendance Either Not Found Or Wages Against This Week Has Been Paid, Please Check !!!')
		return 1
	end if	
		
	setnull(ls_labour_id);setnull(ls_emp_name);setnull(ls_div);setnull(ls_emp_ty);setnull(ls_sex)
	ld_labage=0;ld_wages=0
	
	DECLARE c1 CURSOR FOR  
	select EMP_ID, initcap(emp_name) emp_name,FIELD_ID, get_diff(:ld_dt,emp_dob,'B'), emp_type, emp_sex// ((trunc(:ld_dt) - emp_dob) /365)
	  from fb_employee a 
	where nvl(EMP_ACTIVE,'1') = '1' and emp_type in ('LP','LT','LO') and LS_ID = decode(nvl(:ll_paybook,0),0,LS_ID,:ll_paybook) and 
			not exists (select distinct labour_id from fb_labourdailyattendance b where trunc(lda_date) = trunc(:ld_dt) and b.labour_id = a.emp_id)
	order by emp_id;
	
	open c1;
	
	IF sqlca.sqlcode = 0 THEN
		fetch c1 into :ls_labour_id,:ls_emp_name,:ls_div,:ld_labage,:ls_emp_ty,:ls_sex;
		
		do while sqlca.sqlcode <> 100
			
			If ld_labage <= ll_child Then
				ls_cam_ind = 'CH'
			ElseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
				ls_cam_ind = 'AD'
			ElseIf ld_labage > ll_adoleage Then
				ls_cam_ind = 'AA'
			End If	
		
//			ls_cam_ind,ls_emp_ty,ls_sex
			ll_cnt = ll_cnt + 1
			select lpad(:ll_cnt,10,'0') into :ls_count from dual;
			ls_tmp_id = 'JOB'+ls_count
			
			// Checking Maternity and setting Kamkari
			
			select distinct 'x' into :ls_temp from fb_maternity	where mt_empid = :ls_labour_id and trunc(:ld_dt) between trunc(mt_fromdt) and trunc(mt_todt);
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 0 then
				
				select distinct KAMSUB_ID, trim(KAMSUB_TYPE) into :ls_kam_id,:ls_kamtype from fb_kamsubhead where trim(kamsub_nkamtype)='MATERNITY';
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				

				select section_id into :ls_sec1 from fb_section
				where substr(SECTION_NAME,1,1)||'KAM' = :ls_kamtype and FIELD_ID=decode(:ls_kamtype,'FKAM','NA',:ls_div) and 
						( ((:ls_kamtype <> 'OKAM' and :ls_kamtype <> 'NKAM')) or ((:ls_kamtype = 'OKAM' or :ls_kamtype = 'NKAM') and section_type= 'C') );
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Section From Section Master',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if		
				
				ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,1,0)
				
				if isnull(ld_wages) then ; ld_wages=0; end if
				
				insert into fb_labourdailyattendance(LDA_DATE, LABOUR_ID, KAMSUB_ID, LDA_WAGES, LDA_STATUS, JOB_ID, 
																lda_sectionid1,LWW_ID, LDA_ELP, LDA_ENTRY_BY, LDA_ENTRY_DT)
				values(:ld_dt,:ls_labour_id,:ls_kam_id,:ld_wages,0,:ls_tmp_id,:ls_sec1,:ls_lwwid,0,:gs_user,sysdate);
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Data Into Attendance Table : ',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				
			elseif sqlca.sqlcode = 100 then
				
				select distinct KAMSUB_ID, trim(KAMSUB_TYPE) into :ls_kam_id,:ls_kamtype from fb_kamsubhead where trim(kamsub_nkamtype)='ANNUALLEAVE' and trim(kamsub_type) = 'NKAM';
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				
//				select section_id into :ls_sec1 from fb_section where substr(SECTION_NAME,1,1)||'KAM' = :ls_kamtype and FIELD_ID= :ls_div;
//				
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting Section From Section Master',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				end if		

				select section_id into :ls_sec1 from fb_section
				where substr(SECTION_NAME,1,1)||'KAM' = :ls_kamtype and FIELD_ID=decode(:ls_kamtype,'FKAM','NA',:ls_div) and 
						( ((:ls_kamtype <> 'OKAM' and :ls_kamtype <> 'NKAM')) or ((:ls_kamtype = 'OKAM' or :ls_kamtype = 'NKAM') and section_type= 'C') );
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Section From Section Master',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if		

				ld_wages=0
				insert into fb_labourdailyattendance(LDA_DATE, LABOUR_ID, KAMSUB_ID, LDA_WAGES, LDA_STATUS, JOB_ID, 
																lda_sectionid1,LWW_ID, LDA_ELP, LDA_ENTRY_BY, LDA_ENTRY_DT)
				values(:ld_dt,:ls_labour_id,:ls_kam_id,0,0,:ls_tmp_id,:ls_sec1,:ls_lwwid,0,:gs_user,sysdate);
		
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Data Into Attendance Table : ',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				
			end if
			
		// Start MES
				if ld_wages > 0 then 
					if luo_fames.wf_upd_mes(string(ld_dt,'dd/mm/yyyy'),ls_kam_id,ld_wages,'W','N') = -1 then 
						rollback using sqlca;
						return 1;
					end if
				end if
		// Start Task Activity
				
				if (not isnull(ls_sec1) or len(ls_sec1) > 0) then
					if wf_saveactivitydaily(string(ld_dt,'dd/mm/yyyy'),ls_labour_id,ls_kam_id,ls_sec1,1,ld_wages,0,'N',ls_cam_ind,ls_emp_ty,ls_sex) = -1 then 
						rollback using sqlca;
						return 1;
					end if
				end if
				
			setnull(ls_labour_id);setnull(ls_emp_name);setnull(ls_div);setnull(ls_emp_ty);setnull(ls_sex);setnull(ls_kamtype);setnull(ls_sec1);setnull(ls_kam_id);
			ld_labage=0;ld_wages=0

			fetch c1 into :ls_labour_id,:ls_emp_name,:ls_div,:ld_labage,:ls_emp_ty,:ls_sex;
			
		loop
	END IF
	close c1;
		
	select distinct 'x' into :ls_temp from fb_laboursheetattendance where LWW_ID = :ls_lwwid and trunc(LSA_DATE) = trunc(:ld_dt) and LS_ID = decode(nvl(:ll_paybook,0),0,LS_ID,:ll_paybook);
	if sqlca.sqlcode = -1 then
		messagebox('Error : While getting detail',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		update fb_laboursheetattendance set LSA_ATTENDANCEFLAG = '0', LSA_ATTENDANCECONFIRM = '0' 
		where LWW_ID = :ls_lwwid and LSA_DATE = trunc(:ld_dt) and LS_ID = decode(nvl(:ll_paybook,0),0,LS_ID,:ll_paybook);
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Updating table (fb_laboursheetattendance)',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	elseif sqlca.sqlcode = 100 then
		
		insert into fb_laboursheetattendance(LWW_ID, LS_ID, LSA_ATTENDANCEFLAG, LSA_DATE, LSA_ATTENDANCECONFIRM) 
		select :ls_lwwid,LS_ID,'0',trunc(:ld_dt),'0'  from fb_laboursheet
		where LS_ID = decode(nvl(:ll_paybook,0),0,LS_ID,:ll_paybook);
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Inserting Record 2',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	end if	
	
	DESTROY n_fames
	commit using sqlca;
	//cb_1.enabled = false
	Messagebox('Information !','Process Completed !!!')
	setpointer(arrow!)	
else
	return
end if 
end event

type cb_9 from commandbutton within w_gtelaf015
integer x = 4297
integer y = 16
integer width = 366
integer height = 100
integer taborder = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Absent ALL"
end type

event clicked;if gs_garden_state = '03' then
	ld_dt = datetime(em_1.text)
	if isnull(ld_dt) or em_1.text = '00/00/0000' then
		messagebox('Warning!','Please Select A Attendance Date !!!')
		return 1
	end if
	
	if date(em_1.text) > date(today()) then
		messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
		return 1
	end if		
else
	if isnull(dp_1.text) or dp_1.text = '00/00/0000' then
		messagebox('Warning!','Please Select A Attendance Date !!!')
		return 1
	end if
	
	if date(dp_1.text) > date(today()) then
		messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
		return 1
	end if
	ld_dt = datetime(dp_1.text)
end if

if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning!','Please Select A Pay Book No. Or "ALL {00}" !!!')
	return 1
end if


ll_paybook = long(left(right(ddlb_1.text,3),2))

IF MessageBox("Absent ALL  Alert", 'Do You Want To Absent ALL ....?' ,Exclamation!, YesNo!, 2) = 1 THEN
	
	select distinct 'X' into :ls_temp from fb_mobile_attendance where trunc(lma_date) = trunc(:ld_dt) and not exists (select distinct 'x' from fb_mobile_attendance where trunc(lma_date) = trunc(:ld_dt) and nvl(lma_pst_ind,'N') = 'Y' );
	if sqlca.sqlcode = 0 then
		if MessageBox("Warning", 'Imported Mobile Attendance has not been processed yet, Do you still want to proceed....?' ,Exclamation!, YesNo!, 2) = 2 then
			return 1
		end if
	elseif sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
		return 1
	end if
		

	setpointer(hourglass!)		
	
	select lww_startdate,lww_enddate,lww_id into :ld_stdt, :ldenddt, :ls_lwwid from fb_labourwagesweek 
	where trunc(:ld_dt) between trunc(lww_startdate) and trunc(lww_enddate) and lww_paidflag='0';
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 100 then
		messagebox('Warning!','The Entered Attendance Either Not Found Or Wages Against This Week Has Been Paid, Please Check !!!')
		return 1
	end if	
		
		declare p2 procedure for up_daily_labour_AbsentALL(:gs_user,:ld_dt,:ll_paybook,:ls_lwwid);
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error: During Procedure Declare of up_daily_labour_AbsentALL',sqlca.sqlerrtext)					
			return 1
		end if

		execute p2;
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error: During Procedure Execute of up_daily_labour_AbsentALL',sqlca.sqlerrtext)
			return 1
		end if	
	
		
	
	Messagebox('Information !','Process Completed !!!')
	setpointer(arrow!)	
else
	return
end if 
end event

type cb_8 from commandbutton within w_gtelaf015
integer x = 4681
integer y = 12
integer width = 366
integer height = 100
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "LWW ALL"
end type

event clicked;if gs_garden_state = '03' then
	ld_dt = datetime(em_1.text)
	if isnull(ld_dt) or em_1.text = '00/00/0000' then
		messagebox('Warning!','Please Select A Attendance Date !!!')
		return 1
	end if
	
	if date(em_1.text) > date(today()) then
		messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
		return 1
	end if		
else
	if isnull(dp_1.text) or dp_1.text = '00/00/0000' then
		messagebox('Warning!','Please Select A Attendance Date !!!')
		return 1
	end if
	
	if date(dp_1.text) > date(today()) then
		messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
		return 1
	end if
	ld_dt = datetime(dp_1.text)
end if

if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning!','Please Select A Pay Book No. Or "ALL {00}" !!!')
	return 1
end if


select lww_startdate,lww_enddate,lww_id into :ld_stdt, :ldenddt, :ls_lwwid from fb_labourwagesweek 
	where trunc(:ld_dt) between trunc(lww_startdate) and trunc(lww_enddate) and lww_paidflag='0';


ll_paybook = long(left(right(ddlb_1.text,3),2))

IF MessageBox(" Alert", 'Do You Want To Set LWW For ALL ....?' ,Exclamation!, YesNo!, 2) = 1 THEN

	declare p2 procedure for up_daily_labour_LWW(:gs_user,:ld_dt,:ll_paybook,:ls_lwwid);
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error: During Procedure Declare of up_daily_labour_LWW',sqlca.sqlerrtext)					
			return 1
		end if

		execute p2;
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error: During Procedure Execute of up_daily_labour_LWW',sqlca.sqlerrtext)
			return 1
		end if	
else
	return
end if 
end event

type cb_7 from commandbutton within w_gtelaf015
boolean visible = false
integer x = 4713
integer y = 248
integer width = 297
integer height = 104
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Back atd upd"
end type

event clicked; ll_adoleage = 0 ;ll_child=0
 double ld_measure1,ld_measure2,ld_measure3	
 long ll_noof_sec
 
 setpointer(hourglass!);
 
 ls_date = dp_1.text
 
	select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0)) into :ll_adoleage, :ll_child
	from fb_param_detail 
	where pd_doc_type in ('CHILDAGE','ADOLEAGE') and trunc(sysdate) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));
	
	if sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
		return 1
	end if;
	
	setnull(ls_labour_id);setnull(ls_kam_id);setnull(ls_sec1);setnull(ls_sec2);setnull(ls_sec3); setnull(ls_emp_ty);setnull(ls_sex);setnull(ls_cam_ind);	ld_wages=0;ld_labage=0
	ld_measure1=0;ld_measure2=0;ld_measure3	=0 ; 
	
//	select to_char(lda_date,'dd/mm/yyyy'), labour_id,KAMSUB_ID,LDA_SECTIONID1,lda_mfj_count1,nvl(lda_wages,0) wages,((to_date(:ls_date,'dd/mm/yyyy') - emp_dob) /365) dob, emp_type, emp_sex,lda_status
//from fb_labourdailyattendance a,fb_employee e
//where LDA_DATE between '01-Jan-2018' and '31-jan-2018' and labour_id=emp_id and KAMSUB_ID <> 'ESUB0258' and labour_id = 'LA00233' and KAMSUB_ID = 'ESUB0056'
//order by 1,2;

	
DECLARE c2 CURSOR FOR  
select labour_id,KAMSUB_ID,LDA_SECTIONID1,lda_mfj_count1,nvl(lda_wages,0) wages,get_diff(to_date(:ls_date,'dd/mm/yyyy'), emp_dob,'B') dob, emp_type, emp_sex,lda_status//((to_date(:ls_date,'dd/mm/yyyy') - emp_dob) /365)
from fb_labourdailyattendance a,fb_employee e
where LDA_DATE =  to_date(:ls_date,'dd/mm/yyyy') and labour_id=emp_id and KAMSUB_ID <> 'ESUB0258' 
order by 1,2;

open c2;

IF sqlca.sqlcode = 0 THEN
//	fetch c2 into :ls_date, :ls_labour_id,:ls_kam_id,:ls_sec1,:ld_measure1,:ld_wages,:ld_labage,:ls_emp_ty,:ls_sex,:ld_status;
	fetch c2 into :ls_labour_id,:ls_kam_id,:ls_sec1,:ld_measure1,:ld_wages,:ld_labage,:ls_emp_ty,:ls_sex,:ld_status;
	do while sqlca.sqlcode <> 100

    select kam.kamsub_afrate afrate, kam.kamsub_ahrate ahrate, kam.kamsub_adfrate adfrate, kam.kamsub_adhrate adhrate, kam.kamsub_cfrate cfrate,kam.kamsub_chrate chrate 
        into :ld_afrate, :ld_ahrate, :ld_adfrate, :ld_adhrate, :ld_cfrate,:ld_chrate 
     from fb_kamsubhead kam
    where trim(kam.kamsub_id) = :ls_kam_id and to_date(:ls_date,'dd/mm/yyyy') between trunc(KAMSUB_FRDT) and trunc(nvl(KAMSUB_TODT,sysdate));
    
    if sqlca.sqlcode = -1 then
        messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
        rollback using sqlca;
        return 1
    end if
	 
//	 messagebox('Rate 1',string(ld_afrate))
//	 messagebox('Kamsubhead',ls_kam_id)

        If ld_labage <= ll_child Then //(144 months=12 years)
             If ld_status = 1 Then
                 ld_rate = ld_cFrate
            elseif ld_status = 0.5 Then
                 ld_rate = ld_cHrate
             else
                 ld_rate = ld_cFrate * ld_status
            End If
         ElseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
             If ld_status = 1 Then
                 ld_rate = ld_adfrate
            elseIf ld_status = 0.5 Then
                 ld_rate = ld_adhrate
            else
                 ld_rate = ld_adfrate * ld_status
             End If
         ElseIf ld_labage > ll_adoleage Then
             If ld_status = 1 Then
                 ld_rate = ld_afrate
            elseIf ld_status = 0.5 Then
                 ld_rate = ld_ahrate
            else
                 ld_rate = ld_afrate * ld_status
             End If
        End If

			n_fames luo_fames
			luo_fames = Create n_fames
			
			if not isnull(ls_kam_id) then

				if luo_fames.wf_upd_mes(ls_date,ls_kam_id,ld_wages,'W','Y') = -1 then 
					rollback using sqlca;
					return 1;
				end if
				if luo_fames.wf_upd_mes(ls_date,ls_kam_id,ld_rate,'W','N') = -1 then 
					rollback using sqlca;
					return 1;
				end if
//				messagebox('Old Wages',ld_wages)
//				messagebox('New Wages',ld_rate)
//				If ld_labage <= ll_child Then
//					ls_cam_ind = 'CH'
//				ElseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
//					ls_cam_ind = 'AD'
//				ElseIf ld_labage > ll_adoleage Then
//					ls_cam_ind = 'AA'
//				End If	
//					if isnull(ld_measure1) then ld_measure1 = 0
//					ll_noof_sec  = 0 
//					if len(ls_sec1) > 0 then ; ll_noof_sec  = ll_noof_sec + 1; end if ;
				
//				if (not isnull(ls_sec1) or len(ls_sec1) > 0) then
//					if wf_saveactivitydaily(ls_date,ls_labour_id,ls_kam_id,ls_sec1,ld_status,0,ld_measure1,'O',ls_cam_ind,ls_emp_ty,ls_sex) = -1 then 
//						rollback using sqlca;
//						return 1;
//					end if
//					if wf_saveactivitydaily(ls_date,ls_labour_id,ls_kam_id,ls_sec1,ld_status,(ld_rate - ld_wages),ld_measure1,'N',ls_cam_ind,ls_emp_ty,ls_sex) = -1 then 
//						rollback using sqlca;
//						return 1;
//					end if
//					
//				end if


				update fb_labourdailyattendance set lda_wages = :ld_rate where lda_date = to_date(:ls_date,'dd/mm/yyyy') and LABOUR_ID = :ls_labour_id;
				
			end if
			
			 if sqlca.sqlcode = -1 then
				  messagebox('Error : While Updating Labour Wages Detail',sqlca.sqlerrtext)
				  rollback using sqlca;
				  return 1
			 end if
			

			setnull(ls_labour_id);setnull(ls_kam_id);setnull(ls_sec1);setnull(ls_sec2);setnull(ls_sec3); setnull(ls_emp_ty);setnull(ls_sex);setnull(ls_cam_ind);	ld_wages=0;ld_labage=0;ld_status=0
			ld_measure1=0;ld_measure2=0;ld_measure3=0;ll_noof_sec=0; 
			
//		fetch c2 into :ls_date, :ls_labour_id,:ls_kam_id,:ls_sec1,:ld_measure1,:ld_wages,:ld_labage,:ls_emp_ty,:ls_sex,:ld_status;
		fetch c2 into :ls_labour_id,:ls_kam_id,:ls_sec1,:ld_measure1,:ld_wages,:ld_labage,:ls_emp_ty,:ls_sex,:ld_status;
		
	loop
	close c2;
	DESTROY n_fames
	
	commit using sqlca;
	setpointer(Arrow!);
	messagebox('Info!!','Process Complete')
end if






end event

type cbx_4 from checkbox within w_gtelaf015
integer x = 1262
integer width = 192
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cash"
end type

type cb_6 from commandbutton within w_gtelaf015
boolean visible = false
integer x = 4791
integer y = 68
integer width = 155
integer height = 172
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Taskpost"
end type

event clicked; ll_adoleage = 0 ;ll_child=0
 double ld_measure1,ld_measure2,ld_measure3	
 long ll_noof_sec
 
	select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0)) into :ll_adoleage, :ll_child
	from fb_param_detail 
	where pd_doc_type in ('CHILDAGE','ADOLEAGE') and trunc(sysdate) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));
	
	if sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
		return 1
	end if;
	
			setnull(ls_labour_id);setnull(ls_kam_id);setnull(ls_sec1);setnull(ls_sec2);setnull(ls_sec3); setnull(ls_emp_ty);setnull(ls_sex);setnull(ls_cam_ind);	ld_wages=0;ld_labage=0
			ld_measure1=0;ld_measure2=0;ld_measure3	=0
			
DECLARE c2 CURSOR FOR  
select labour_id,KAMSUB_ID,LDA_SECTIONID1,lda_sectionid2,lda_sectionid3,lda_mfj_count1,lda_mfj_count2,lda_mfj_count3,decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0)),
get_diff(to_date('06/12/2014','dd/mm/yyyy'),emp_dob,'B'), emp_type, emp_sex,lda_status//((to_date('06/12/2014','dd/mm/yyyy') - emp_dob) /365)
from fb_labourdailyattendance a,fb_employee e
where LDA_DATE='06-Dec-2014' and labour_id=emp_id//and LDA_ENTRY_BY in ('BARTHOLOME','BIREN') 
;

open c2;

IF sqlca.sqlcode = 0 THEN
	fetch c2 into :ls_labour_id,:ls_kam_id,:ls_sec1,:ls_sec2,:ls_sec3,:ld_measure1,:ld_measure2,:ld_measure3,:ld_wages,:ld_labage,:ls_emp_ty,:ls_sex,:ld_status;
	do while sqlca.sqlcode <> 100
		If ld_labage <= ll_child Then
			ls_cam_ind = 'CH'
		ElseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
			ls_cam_ind = 'AD'
		ElseIf ld_labage > ll_adoleage Then
			ls_cam_ind = 'AA'
		End If	
			if isnull(ld_measure1) then ld_measure1 = 0
			if isnull(ld_measure2) then ld_measure2 = 0
			if isnull(ld_measure3) then ld_measure3 = 0
				ll_noof_sec  = 0 
				if len(ls_sec1) > 0 then ; ll_noof_sec  = ll_noof_sec + 1; end if ;
				if len(ls_sec2) > 0 then ; ll_noof_sec  = ll_noof_sec + 1; end if ;
				if len(ls_sec3) > 0 then ; ll_noof_sec  = ll_noof_sec + 1; end if ;
			
				if (not isnull(ls_sec1) or len(ls_sec1) > 0) then
					if wf_saveactivitydaily('06/12/2014',ls_labour_id,ls_kam_id,ls_sec1,(ld_status / ll_noof_sec),(ld_wages / ll_noof_sec),ld_measure1,'N',ls_cam_ind,ls_emp_ty,ls_sex) = -1 then 
						rollback using sqlca;
						return 1;
					end if
				end if
				if (not isnull(ls_sec2) or len(ls_sec2) > 0) then
					if wf_saveactivitydaily('06/12/2014',ls_labour_id,ls_kam_id,ls_sec2,(ld_status / ll_noof_sec),(ld_wages / ll_noof_sec),ld_measure2,'N',ls_cam_ind,ls_emp_ty,ls_sex) = -1 then 
						rollback using sqlca;
						return 1;
					end if
				end if
				if (not isnull(ls_sec3) or len(ls_sec3) > 0) then
					if wf_saveactivitydaily('06/12/2014',ls_labour_id,ls_kam_id,ls_sec3,(ld_status / ll_noof_sec),(ld_wages / ll_noof_sec),ld_measure3,'N',ls_cam_ind,ls_emp_ty,ls_sex) = -1 then 
						rollback using sqlca;
						return 1;
					end if
				end if

			setnull(ls_labour_id);setnull(ls_kam_id);setnull(ls_sec1);setnull(ls_sec2);setnull(ls_sec3); setnull(ls_emp_ty);setnull(ls_sex);setnull(ls_cam_ind);	ld_wages=0;ld_labage=0;ld_status=0
			ld_measure1=0;ld_measure2=0;ld_measure3=0;ll_noof_sec=0
			
		fetch c2 into :ls_labour_id,:ls_kam_id,:ls_sec1,:ls_sec2,:ls_sec3,:ld_measure1,:ld_measure2,:ld_measure3,:ld_wages,:ld_labage,:ls_emp_ty,:ls_sex,:ld_status;
		
	loop
	close c2;
	commit using sqlca;
end if






end event

type cbx_3 from checkbox within w_gtelaf015
integer x = 3118
integer y = 28
integer width = 274
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Replicate"
end type

type cbx_2 from checkbox within w_gtelaf015
integer x = 2912
integer y = 28
integer width = 197
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ticca"
end type

type cbx_1 from checkbox within w_gtelaf015
integer x = 1262
integer y = 76
integer width = 146
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "ID"
end type

type cb_5 from commandbutton within w_gtelaf015
boolean visible = false
integer x = 4297
integer y = 16
integer width = 366
integer height = 100
integer taborder = 110
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "Absent ALL"
end type

event clicked;if gs_garden_state = '03' then
	ld_dt = datetime(em_1.text)
	if isnull(ld_dt) or em_1.text = '00/00/0000' then
		messagebox('Warning!','Please Select A Attendance Date !!!')
		return 1
	end if
	
	if date(em_1.text) > date(today()) then
		messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
		return 1
	end if		
else
	if isnull(dp_1.text) or dp_1.text = '00/00/0000' then
		messagebox('Warning!','Please Select A Attendance Date !!!')
		return 1
	end if
	
	if date(dp_1.text) > date(today()) then
		messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
		return 1
	end if
	ld_dt = datetime(dp_1.text)
end if

if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning!','Please Select A Pay Book No. Or "ALL {00}" !!!')
	return 1
end if


ll_paybook = long(left(right(ddlb_1.text,3),2))

IF MessageBox("Absent ALL  Alert", 'Do You Want To Absent ALL ....?' ,Exclamation!, YesNo!, 2) = 1 THEN
	
	select distinct 'X' into :ls_temp from fb_mobile_attendance where trunc(lma_date) = trunc(:ld_dt) and not exists (select distinct 'x' from fb_mobile_attendance where trunc(lma_date) = trunc(:ld_dt) and nvl(lma_pst_ind,'N') = 'Y' );
	if sqlca.sqlcode = 0 then
		if MessageBox("Warning", 'Imported Mobile Attendance has not been processed yet, Do you still want to proceed....?' ,Exclamation!, YesNo!, 2) = 2 then
			return 1
		end if
	elseif sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
		return 1
	end if
		

	setpointer(hourglass!)	
	n_fames luo_fames
	luo_fames = Create n_fames

	ll_adoleage = 0 ;ll_child=0
 
	select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0)) into :ll_adoleage, :ll_child
	from fb_param_detail 
	where pd_doc_type in ('CHILDAGE','ADOLEAGE') and trunc(:ld_dt) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));
	
	if sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
		return 1
	end if;
	
	select nvl(MAX(JOB_ID),0) into :ls_last from fb_labourdailyattendance where JOB_ID like 'JOB%';
	ls_last = right(ls_last,10)
	ll_cnt = long(ls_last)
	
	select lww_startdate,lww_enddate,lww_id into :ld_stdt, :ldenddt, :ls_lwwid from fb_labourwagesweek 
	where trunc(:ld_dt) between trunc(lww_startdate) and trunc(lww_enddate) and lww_paidflag='0';
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 100 then
		messagebox('Warning!','The Entered Attendance Either Not Found Or Wages Against This Week Has Been Paid, Please Check !!!')
		return 1
	end if	
		
	setnull(ls_labour_id);setnull(ls_emp_name);setnull(ls_div);setnull(ls_emp_ty);setnull(ls_sex)
	ld_labage=0;ld_wages=0
	
	DECLARE c1 CURSOR FOR  
//	select EMP_ID, initcap(emp_name) emp_name,FIELD_ID, ((trunc(:ld_dt) - emp_dob) /365), emp_type, emp_sex
//	  from fb_employee a 
//	where nvl(EMP_ACTIVE,'1') = '1' and emp_type in ('LP','LT','LO') and LS_ID = decode(nvl(:ll_paybook,0),0,LS_ID,:ll_paybook) and 
//			not exists (select distinct labour_id from fb_labourdailyattendance b where trunc(lda_date) = trunc(:ld_dt) and b.labour_id = a.emp_id)
//	order by emp_id;

	select EMP_ID, initcap(emp_name) emp_name,FIELD_ID, get_diff(trunc(:ld_dt),emp_dob,'B') , emp_type, emp_sex
	  from fb_employee a 
	where nvl(EMP_ACTIVE,'1') = '1' and emp_type in ('LP','LT','LO') and LS_ID = decode(nvl(:ll_paybook,0),0,LS_ID,:ll_paybook) and 
			not exists (select distinct labour_id from fb_labourdailyattendance b where trunc(lda_date) = trunc(:ld_dt) and b.labour_id = a.emp_id)
	order by emp_id;
	
	open c1;
	
	IF sqlca.sqlcode = 0 THEN
		fetch c1 into :ls_labour_id,:ls_emp_name,:ls_div,:ld_labage,:ls_emp_ty,:ls_sex;
		
		do while sqlca.sqlcode <> 100
			
			If ld_labage <= ll_child Then
				ls_cam_ind = 'CH'
			ElseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
				ls_cam_ind = 'AD'
			ElseIf ld_labage > ll_adoleage Then
				ls_cam_ind = 'AA'
			End If	
		
//			ls_cam_ind,ls_emp_ty,ls_sex
			ll_cnt = ll_cnt + 1
			select lpad(:ll_cnt,10,'0') into :ls_count from dual;
			ls_tmp_id = 'JOB'+ls_count
			
			// Checking Maternity and setting Kamkari
			
			select distinct 'x' into :ls_temp from fb_maternity	where mt_empid = :ls_labour_id and trunc(:ld_dt) between trunc(mt_fromdt) and trunc(mt_todt);
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 0 then
				
				select distinct KAMSUB_ID, trim(KAMSUB_TYPE) into :ls_kam_id,:ls_kamtype from fb_kamsubhead where trim(kamsub_nkamtype)='MATERNITY';
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				
//				dw_1.setitem(row,'kamsub_secind',ls_secind) 
//				dw_1.setitem(row,'kamsub_measind',ls_measureind)
//				dw_1.setitem(row,'kamsub_costcind',ls_ccind)
//		
//				if ls_kamtype ='OKAM' or ls_kamtype = 'NKAM' then
//		
//					select section_id into :ls_sec1 from fb_section  where substr(SECTION_NAME,1,1)||'KAM' = :ls_kamtype and FIELD_ID=:ls_div and section_type='C';
//					
//					if sqlca.sqlcode = -1 then
//						messagebox('Error : While Getting Section From Section Master',sqlca.sqlerrtext)
//						rollback using sqlca;
//						return 1
//					elseif sqlca.sqlcode=0 then
//						dw_1.setitem(row,'lda_sectionid1',ls_sec1)
//					end if
//		
//				end if

//				select section_id into :ls_sec1 from fb_section
//				where substr(SECTION_NAME,1,1)||'KAM' = :ls_kamtype and FIELD_ID=decode(:ls_kamtype,'FKAM','NA',:ls_div);
//				
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting Section From Section Master',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				end if		
//

				select section_id into :ls_sec1 from fb_section
				where substr(SECTION_NAME,1,1)||'KAM' = :ls_kamtype and FIELD_ID=decode(:ls_kamtype,'FKAM','NA',:ls_div) and 
						( ((:ls_kamtype <> 'OKAM' and :ls_kamtype <> 'NKAM')) or ((:ls_kamtype = 'OKAM' or :ls_kamtype = 'NKAM') and section_type= 'C') );
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Section From Section Master',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if		
				
				ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,1,0)
				
				if isnull(ld_wages) then ; ld_wages=0; end if
				
				insert into fb_labourdailyattendance(LDA_DATE, LABOUR_ID, KAMSUB_ID, LDA_WAGES, LDA_STATUS, JOB_ID, 
																lda_sectionid1,LWW_ID, LDA_ELP, LDA_ENTRY_BY, LDA_ENTRY_DT)
				values(:ld_dt,:ls_labour_id,:ls_kam_id,:ld_wages,1,:ls_tmp_id,:ls_sec1,:ls_lwwid,0,:gs_user,sysdate);
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Data Into Attendance Table : ',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				
			elseif sqlca.sqlcode = 100 then
				
				select distinct KAMSUB_ID, trim(KAMSUB_TYPE) into :ls_kam_id,:ls_kamtype from fb_kamsubhead where trim(kamsub_nkamtype)='ABSENT';
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				
//				select section_id into :ls_sec1 from fb_section where substr(SECTION_NAME,1,1)||'KAM' = :ls_kamtype and FIELD_ID= :ls_div;
//				
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting Section From Section Master',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				end if		

				select section_id into :ls_sec1 from fb_section
				where substr(SECTION_NAME,1,1)||'KAM' = :ls_kamtype and FIELD_ID=decode(:ls_kamtype,'FKAM','NA',:ls_div) and 
						( ((:ls_kamtype <> 'OKAM' and :ls_kamtype <> 'NKAM')) or ((:ls_kamtype = 'OKAM' or :ls_kamtype = 'NKAM') and section_type= 'C') );
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Section From Section Master',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if		

				ld_wages=0
				insert into fb_labourdailyattendance(LDA_DATE, LABOUR_ID, KAMSUB_ID, LDA_WAGES, LDA_STATUS, JOB_ID, 
																lda_sectionid1,LWW_ID, LDA_ELP, LDA_ENTRY_BY, LDA_ENTRY_DT)
				values(:ld_dt,:ls_labour_id,:ls_kam_id,0,0,:ls_tmp_id,:ls_sec1,:ls_lwwid,0,:gs_user,sysdate);
		
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Data Into Attendance Table : ',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				
			end if
			
		// Start MES
				if ld_wages > 0 then 
					if luo_fames.wf_upd_mes(string(ld_dt,'dd/mm/yyyy'),ls_kam_id,ld_wages,'W','N') = -1 then 
						rollback using sqlca;
						return 1;
					end if
				end if
		// Start Task Activity
				
				if (not isnull(ls_sec1) or len(ls_sec1) > 0) then
					if wf_saveactivitydaily(string(ld_dt,'dd/mm/yyyy'),ls_labour_id,ls_kam_id,ls_sec1,1,ld_wages,0,'N',ls_cam_ind,ls_emp_ty,ls_sex) = -1 then 
						rollback using sqlca;
						return 1;
					end if
				end if
				
			setnull(ls_labour_id);setnull(ls_emp_name);setnull(ls_div);setnull(ls_emp_ty);setnull(ls_sex);setnull(ls_kamtype);setnull(ls_sec1);setnull(ls_kam_id);
			ld_labage=0;ld_wages=0

			fetch c1 into :ls_labour_id,:ls_emp_name,:ls_div,:ld_labage,:ls_emp_ty,:ls_sex;
			
		loop
	END IF
	close c1;
		
	select distinct 'x' into :ls_temp from fb_laboursheetattendance where LWW_ID = :ls_lwwid and trunc(LSA_DATE) = trunc(:ld_dt) and LS_ID = decode(nvl(:ll_paybook,0),0,LS_ID,:ll_paybook);
	if sqlca.sqlcode = -1 then
		messagebox('Error : While getting detail',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		update fb_laboursheetattendance set LSA_ATTENDANCEFLAG = '0', LSA_ATTENDANCECONFIRM = '0' 
		where LWW_ID = :ls_lwwid and LSA_DATE = trunc(:ld_dt) and LS_ID = decode(nvl(:ll_paybook,0),0,LS_ID,:ll_paybook);
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Updating table (fb_laboursheetattendance)',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	elseif sqlca.sqlcode = 100 then
		
		insert into fb_laboursheetattendance(LWW_ID, LS_ID, LSA_ATTENDANCEFLAG, LSA_DATE, LSA_ATTENDANCECONFIRM) 
		select :ls_lwwid,LS_ID,'0',trunc(:ld_dt),'0'  from fb_laboursheet
		where LS_ID = decode(nvl(:ll_paybook,0),0,LS_ID,:ll_paybook);
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Inserting Record 2',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	end if	
	
	DESTROY n_fames
	commit using sqlca;
	//cb_1.enabled = false
	Messagebox('Information !','Process Completed !!!')
	setpointer(arrow!)	
else
	return
end if 
end event

type rb_2 from radiobutton within w_gtelaf015
integer x = 229
integer y = 36
integer width = 210
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Query"
end type

event clicked;dp_1.enabled = false
em_1.enabled = true
cb_1.enabled = false
cb_2.enabled = true
st_1.visible = false
dp_1.visible = false
st_3.visible = true
em_1.visible = true
cb_5.enabled = true
cb_8.enabled = true
end event

type rb_1 from radiobutton within w_gtelaf015
integer x = 27
integer y = 36
integer width = 192
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "New"
boolean checked = true
end type

event clicked;dp_1.enabled = true
em_1.enabled = false
cb_1.enabled = true
cb_2.enabled = false
st_1.visible = true
dp_1.visible = true
st_3.visible = false
em_1.visible = false
if gs_garden_state = '03' then
	cb_5.enabled = false
	cb_8.enabled = false
else
	cb_5.enabled = true
	cb_8.enabled = true
end if
end event

type st_3 from statictext within w_gtelaf015
integer x = 571
integer y = 40
integer width = 283
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Query Date"
boolean focusrectangle = false
end type

type st_2 from statictext within w_gtelaf015
integer x = 1454
integer y = 36
integer width = 238
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pay Book"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtelaf015
integer x = 1691
integer y = 20
integer width = 1216
integer height = 820
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
end type

type cb_2 from commandbutton within w_gtelaf015
integer x = 3607
integer y = 16
integer width = 215
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;if date(em_1.text) > date(today()) then
	messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
	return 1
end if

if isnull(em_1.text) or em_1.text = '00/00/0000' then
	messagebox('Warning!','Please Select A Reading Date !!!')
	return 1
end if
if cbx_1.checked = false or (gs_garden_snm <> 'MV' and gs_garden_snm <> 'GP' and gs_garden_snm <> 'JP'  and gs_garden_snm <> 'MF' and gs_garden_snm <> 'GF') then
	if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
		messagebox('Warning!','Please Select A Pay Book No. !!!')
		return 1
	end if
end if
ld_rundt = datetime(em_1.text) 
ll_paybook = long(left(right(ddlb_1.text,3),2))

select lww_paidflag, LWW_PAYCALFLAG,nvl(LWW_PARTWEEK_VOU_NO,'X') into :ls_paidfg, :ls_calfg, :ls_pwvn from fb_labourwagesweek 
where trunc(:ld_rundt) between trunc(lww_startdate) and trunc(lww_enddate);

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Wage Week Details',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode = 0 then
//	if isnull(ls_pwvn) then ls_pwvn = 'X';
	select last_day(lww_startdate) into :ld_pwlastday from fb_labourwagesweek where trunc(:ld_rundt) between trunc(lww_startdate) and trunc(lww_enddate);
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Wage Week Last Day Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
	
	if ls_paidfg = '1' then
		ls_protect_flg = 'Y'
	elseif ls_paidfg = '0' then
		if ls_pwvn <> 'X' and ld_rundt <= ld_pwlastday then
			ls_protect_flg = 'Y'
		elseif ls_pwvn <> 'X' and ld_rundt > ld_pwlastday then
			ls_protect_flg = 'N'
		elseif ls_pwvn = 'X' and  ll_user_level = 1 then
			ls_protect_flg = 'N'
		else 
			ls_protect_flg = 'Y'
		end if
	else 
		ls_protect_flg = 'Y'
	end if
end if	

if isnull(ls_protect_flg) then ls_protect_flg = 'Y'

lb_neworder =false
lb_query = false
dw_1.settransobject(sqlca)
dw_1.SetRedraw (FALSE)
dw_1.Object.datawindow.querymode = 'no'
dw_1.Retrieve(gs_garden_snm,string(ld_rundt,'dd/mm/yyyy'),ll_paybook,ls_protect_flg,upper(left(gs_loginuser,2)))
dw_1.settaborder('labour_id',0)
dw_1.SetRedraw (TRUE)


end event

type cb_1 from commandbutton within w_gtelaf015
integer x = 3397
integer y = 16
integer width = 215
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&New"
end type

event clicked;if lb_neworder = false then
	if dw_1.modifiedcount() > 0 then
		if messagebox("Confirmation","Row has been modified, Do You Want To Add New Record ...!",question!,yesno!,1) = 2 then
			return
		end if
	end if
end if

lb_neworder = false
setpointer(hourglass!)
dw_1.reset()
dw_1.settransobject(sqlca)
setnull(ls_holidayflg)

ld_dt = datetime(dp_1.value)

if isnull(dp_1.text) or dp_1.text = '00/00/0000' then
	messagebox('Warning!','Please Select A Attendance Date !!!')
	return 1
end if

if date(dp_1.text) > date(today()) then
	messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
	return 1
end if

if (isnull(ddlb_1.text) or len(ddlb_1.text) = 0) and cbx_1.checked = false then
	messagebox('Warning!','Please Select A Pay Book No. !!!')
	return 1
end if
setnull(ld_stdt);setnull(ldenddt);setnull(ls_lwwid);

	select lww_startdate,lww_enddate,lww_id into :ld_stdt, :ldenddt, :ls_lwwid from fb_labourwagesweek 
	where trunc(:ld_dt) between trunc(lww_startdate) and trunc(lww_enddate) and lww_paidflag='0';
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 100 then
		messagebox('Warning!','The Entered Attendance Either Not Found Or Wages Against This Week Has Been Paid, Please Check !!!')
		return 1
	end if	
	
ld_dt = datetime(dp_1.text)
//ll_paybook = long(left(ddlb_1.text,2))
setnull(ls_kam_id);setnull(ls_JUNGLIFOOT_ind);
if cbx_1.checked = false then
	ll_paybook = long(left(right(ddlb_1.text,3),2))

//	select distinct 'x' into :ls_temp	from fb_employee 
//	where emp_active='1' and ls_id= :ll_paybook and 
//			 not exists ( select labour_id from fb_labourdailyattendance where trunc(lda_date) = trunc(:ld_dt) - 1 and emp_id = labour_id);
//	//select distinct 'x' into :ls_temp from fb_labourdailyattendance where trunc(LDA_DATE) =  trunc(:ld_dt) - 1;
//	if sqlca.sqlcode = -1 then
//		messagebox('Error : While Getting Previous Day Attendance Details',sqlca.sqlerrtext)
//		rollback using sqlca;
//		return 1
//	elseif sqlca.sqlcode  = 0 then
//		messagebox('Warning!','Previous Day Attendance Reading Not Found or Incomplete, Please Check1 !!!')
//		return 1
//	end if	

	
	if gs_garden_snm ='MT' then
		select PH_HOURS into :ld_prorata_hours from fb_prorata_hours where PH_DATE = trunc(:ld_dt);
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Prorat Hours ',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then
			ld_prorata_hours=0
		end if
	end if
	if gs_garden_snm = 'FB' or gs_garden_snm = 'MK' or gs_garden_snm = 'ME' or gs_garden_snm = 'KG' or gs_garden_snm = 'BE' or gs_garden_snm = 'MV' or gs_garden_snm = 'SP' then
		DECLARE c1 CURSOR FOR  
		select EMP_ID, emp_name,task_ind from fb_employee a,(select distinct TASK_EMPTYPE, TASK_PAYBOOK, TASK_TYPE,'Y' task_ind from fb_task_fulbari where  trunc(:ld_dt) between TASK_DT_FROM and TASK_DT_TO) 
		where  case when (trunc(:ld_dt) < '01-Dec-2024' and EMP_JOBLEAVINGDATE = TO_DATE('30-Nov-2024', 'DD-Mon-YYYY')) then '1' else  NVL(EMP_ACTIVE, '1') end  = '1'     
		and emp_type in ('LP','LT','LO') and LS_ID = :ll_paybook and 
				not exists (select distinct labour_id from fb_labourdailyattendance b where trunc(lda_date) = trunc(:ld_dt) and b.labour_id = a.emp_id) and
				decode( sign((round(get_diff(trunc(:ld_dt),emp_dob,'B') * 12)) - 144),1,decode( sign(get_diff(trunc(:ld_dt),emp_dob,'B') - 216),1,'ADULT','ADOLE'),'CHILD') = TASK_TYPE(+) and emp_type = TASK_EMPTYPE (+) and ls_id = TASK_PAYBOOK(+)//decode( sign((round((( trunc(:ld_dt) - emp_dob) /365) * 12)) - 144),1,decode( sign(get_diff(trunc(:ld_dt),emp_dob,'B') - 216),1,'ADULT','ADOLE'),'CHILD') = TASK_TYPE(+) and emp_type = TASK_EMPTYPE (+) and ls_id = TASK_PAYBOOK(+)
		order by emp_id;
		
		open c1;
		
		IF sqlca.sqlcode = 0 THEN
			fetch c1 into :ls_labour_id,:ls_emp_name,:ls_task_ind;
			
			do while sqlca.sqlcode <> 100
				dw_1.scrolltorow(dw_1.insertrow(0))
				dw_1.setitem(dw_1.getrow(),'gs_gsnm',gs_garden_snm)
				dw_1.setitem(dw_1.getrow(),'ra_loginusr',upper(left(gs_loginuser,2)))
				dw_1.setitem(dw_1.getrow(),'ls_id',ll_paybook)
				dw_1.setitem(dw_1.getrow(),'lda_date',ld_dt)
				dw_1.setitem(dw_1.getrow(),'labour_id',ls_labour_id)
				dw_1.setitem(dw_1.getrow(),'emp_name',ls_emp_name)
				
				if ld_prorata_hours > 0 then
					dw_1.setitem(dw_1.getrow(),'lda_prorataind','Y')
				end if
				
				dw_1.setitem(dw_1.getrow(),'lww_id',ls_lwwid)
				dw_1.setitem(dw_1.getrow(),'lda_entry_by',gs_user)
				dw_1.setitem(dw_1.getrow(),'lda_entry_dt',datetime(today()))
				dw_1.setitem(dw_1.getrow(),'lda_taskind',ls_task_ind)
				
				// Checking Maternity and setting Kamkari
				select distinct 'x' into :ls_temp from fb_maternity	where mt_empid = :ls_labour_id and trunc(:ld_dt) between trunc(mt_fromdt) and trunc(mt_todt);
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					select distinct KAMSUB_ID into :ls_kam_id from fb_kamsubhead where TRIM(kamsub_nkamtype)='MATERNITY';
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
					dw_1.setitem(dw_1.getrow(),'kamsub_id',ls_kam_id)
				end if
				// Checking Maternity and setting Kamkari
				
	//			if ls_holidayflg = 'Y' then
	//				select distinct KAMSUB_ID into :ls_prevatd from fb_labourdailyattendance where trunc(lda_date) = trunc(:ld_dt) - 1 and LABOUR_ID = :ls_emp_id;
	//				if sqlca.sqlcode = -1 then
	//					messagebox('Error : While Getting Employee Previous Day Attendance Details',sqlca.sqlerrtext)
	//					rollback using sqlca;
	//					return 1
	//				end if	
	//				select distinct KAMSUB_ID into :ls_nextatd from fb_labourdailyattendance where trunc(lda_date) = trunc(:ld_dt) + 1 and LABOUR_ID = :ls_emp_id;
	//				if sqlca.sqlcode = -1 then
	//					messagebox('Error : While Getting Employee Next Day Attendance Details',sqlca.sqlerrtext)
	//					rollback using sqlca;
	//					return 1
	//				end if	
	//				if ls_prevatd = 'ESUB0258' and ls_nextatd = 'ESUB0258' then
	//					dw_1.setitem(dw_1.getrow(),'kamsub_id','ESUB0258')
	//					dw_1.setitem(dw_1.getrow(),'lda_status',0)
	//					dw_1.setitem(dw_1.getrow(),'lda_wages',0)
	//				else
	//					dw_1.setitem(dw_1.getrow(),'kamsub_id','ESUB0259')
	//					dw_1.setitem(dw_1.getrow(),'lda_status',1)
	//					dw_1.setitem(dw_1.getrow(),'lda_wages',wf_kamjari_rate(ld_dt,ls_emp_id,'ESUB0259',1,0,dw_1.getrow()))
	//				end if
	//			end if
				fetch c1 into :ls_labour_id,:ls_emp_name,:ls_task_ind;
			loop
		END IF
		close c1;
		
	elseif gs_garden_snm = 'MT' then
		DECLARE c2 CURSOR FOR  
		select EMP_ID, emp_name,task_ind, kam, jf, lda_nature from fb_employee a,(select distinct TASK_TYPE,'Y' task_ind from fb_task where  trunc(:ld_dt) between TASK_DT_FROM and TASK_DT_TO),
		(select labour_id,KAMSUB_ID kam,LDA_MFJ_JUNGLIFOOT jf, lda_nature 
		from fb_labourdailyattendance 
		where (labour_id, lda_date) in (select labour_id,MAX(LDA.LDA_DATE) from fb_kamsubhead kam,fb_labourdailyattendance lda 
									where lda.kamsub_id= kam.kamsub_id and nvl(KAMSUB_ACTIVE_IND,'Y') = 'Y' and
									TRIM(kam.kamsub_nkamtype) NOT IN ('ABSENT','HOLIDAYNOPAY') group by (lda.labour_id))) c
		where case when (trunc(:ld_dt) < '01-Dec-2024' and EMP_JOBLEAVINGDATE = TO_DATE('30-Nov-2024', 'DD-Mon-YYYY')) then '1' else  NVL(EMP_ACTIVE, '1') end  = '1'     and emp_type in ('LP','LT','LO') and LS_ID = :ll_paybook and a.emp_id = c.labour_id (+) and
				not exists (select distinct b.labour_id from fb_labourdailyattendance b where trunc(lda_date) = trunc(:ld_dt) and b.labour_id = a.emp_id) //and
				//decode( sign((round((( trunc(:ld_dt) - emp_dob) /365) * 12)) - 144),1,decode( sign(get_diff(trunc(:ld_dt),emp_dob,'B') * 12)) - 216),1,'ADULT','ADOLE'),'CHILD') = TASK_TYPE(+)
		order by a.emp_id;
		
		open c2;
		
		IF sqlca.sqlcode = 0 THEN
			fetch c2 into :ls_labour_id,:ls_emp_name,:ls_task_ind, :ls_kam_id,:ls_JUNGLIFOOT_ind,:ls_nature;
			
			do while sqlca.sqlcode <> 100
				dw_1.scrolltorow(dw_1.insertrow(0))
				dw_1.setitem(dw_1.getrow(),'gs_gsnm',gs_garden_snm)
				dw_1.setitem(dw_1.getrow(),'ra_loginusr',upper(left(gs_loginuser,2)))
				dw_1.setitem(dw_1.getrow(),'ls_id',ll_paybook)
				dw_1.setitem(dw_1.getrow(),'lda_date',ld_dt)
				dw_1.setitem(dw_1.getrow(),'labour_id',ls_labour_id)
				dw_1.setitem(dw_1.getrow(),'emp_name',ls_emp_name)
				dw_1.setitem(dw_1.getrow(),'kamsub_id',ls_kam_id)
				dw_1.setitem(dw_1.getrow(),'lda_nature',ls_nature)
				dw_1.setitem(dw_1.getrow(),'lda_mfj_junglifoot',ls_JUNGLIFOOT_ind)
				dw_1.setitem(dw_1.getrow(),'confirm_ind','N')
				
				if ld_prorata_hours > 0 then
					dw_1.setitem(dw_1.getrow(),'lda_prorataind','Y')
				end if
				
				dw_1.setitem(dw_1.getrow(),'lww_id',ls_lwwid)
				dw_1.setitem(dw_1.getrow(),'lda_entry_by',gs_user)
				dw_1.setitem(dw_1.getrow(),'lda_entry_dt',datetime(today()))
				dw_1.setitem(dw_1.getrow(),'lda_taskind',ls_task_ind)
				
				// Checking Maternity and setting Kamkari
				select distinct 'x' into :ls_temp from fb_maternity	where mt_empid = :ls_labour_id and trunc(:ld_dt) between trunc(mt_fromdt) and trunc(mt_todt);
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					select distinct KAMSUB_ID into :ls_kam_id from fb_kamsubhead where TRIM(kamsub_nkamtype)='MATERNITY';
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
					dw_1.setitem(dw_1.getrow(),'kamsub_id',ls_kam_id)
				end if
				// Checking Maternity and setting Kamkari
				
	//			if ls_holidayflg = 'Y' then
	//				select distinct KAMSUB_ID into :ls_prevatd from fb_labourdailyattendance where trunc(lda_date) = trunc(:ld_dt) - 1 and LABOUR_ID = :ls_emp_id;
	//				if sqlca.sqlcode = -1 then
	//					messagebox('Error : While Getting Employee Previous Day Attendance Details',sqlca.sqlerrtext)
	//					rollback using sqlca;
	//					return 1
	//				end if	
	//				select distinct KAMSUB_ID into :ls_nextatd from fb_labourdailyattendance where trunc(lda_date) = trunc(:ld_dt) + 1 and LABOUR_ID = :ls_emp_id;
	//				if sqlca.sqlcode = -1 then
	//					messagebox('Error : While Getting Employee Next Day Attendance Details',sqlca.sqlerrtext)
	//					rollback using sqlca;
	//					return 1
	//				end if	
	//				if ls_prevatd = 'ESUB0258' and ls_nextatd = 'ESUB0258' then
	//					dw_1.setitem(dw_1.getrow(),'kamsub_id','ESUB0258')
	//					dw_1.setitem(dw_1.getrow(),'lda_status',0)
	//					dw_1.setitem(dw_1.getrow(),'lda_wages',0)
	//				else
	//					dw_1.setitem(dw_1.getrow(),'kamsub_id','ESUB0259')
	//					dw_1.setitem(dw_1.getrow(),'lda_status',1)
	//					dw_1.setitem(dw_1.getrow(),'lda_wages',wf_kamjari_rate(ld_dt,ls_emp_id,'ESUB0259',1,0,dw_1.getrow()))
	//				end if
	//			end if
				fetch c2 into :ls_labour_id,:ls_emp_name,:ls_task_ind, :ls_kam_id,:ls_JUNGLIFOOT_ind, :ls_nature;
			loop
		END IF
		close c2;	
	else
		DECLARE c3 CURSOR FOR  
		select EMP_ID, emp_name,task_ind from fb_employee a,(select distinct TASK_TYPE,'Y' task_ind from fb_task where  trunc(:ld_dt) between TASK_DT_FROM and TASK_DT_TO) 
		where case when (trunc(:ld_dt) < '01-Dec-2024' and EMP_JOBLEAVINGDATE = TO_DATE('30-Nov-2024', 'DD-Mon-YYYY')) then '1' else  NVL(EMP_ACTIVE, '1') end  = '1' and emp_type in ('LP','LT','LO') and LS_ID = :ll_paybook and 
				not exists (select distinct labour_id from fb_labourdailyattendance b where trunc(lda_date) = trunc(:ld_dt) and b.labour_id = a.emp_id) and
				decode( sign((round(get_diff(:ld_dt,emp_dob,'B') * 12)) - 144),1,decode( sign((round(get_diff(:ld_dt,emp_dob,'B') * 12)) - 216),1,'ADULT','ADOLE'),'CHILD') = TASK_TYPE(+)
		order by emp_id;
		
		open c3;
		
		IF sqlca.sqlcode = 0 THEN
			fetch c3 into :ls_labour_id,:ls_emp_name,:ls_task_ind;
			
			do while sqlca.sqlcode <> 100
				dw_1.scrolltorow(dw_1.insertrow(0))
				dw_1.setitem(dw_1.getrow(),'gs_gsnm',gs_garden_snm)
				dw_1.setitem(dw_1.getrow(),'ra_loginusr',upper(left(gs_loginuser,2)))
				dw_1.setitem(dw_1.getrow(),'ls_id',ll_paybook)
				dw_1.setitem(dw_1.getrow(),'lda_date',ld_dt)
				dw_1.setitem(dw_1.getrow(),'labour_id',ls_labour_id)
				dw_1.setitem(dw_1.getrow(),'emp_name',ls_emp_name)
				
				
				if ld_prorata_hours > 0 then
					dw_1.setitem(dw_1.getrow(),'lda_prorataind','Y')
				end if
				
				dw_1.setitem(dw_1.getrow(),'lww_id',ls_lwwid)
				dw_1.setitem(dw_1.getrow(),'lda_entry_by',gs_user)
				dw_1.setitem(dw_1.getrow(),'lda_entry_dt',datetime(today()))
				dw_1.setitem(dw_1.getrow(),'lda_taskind',ls_task_ind)
				
				// Checking Maternity and setting Kamkari
				select distinct 'x' into :ls_temp from fb_maternity	where mt_empid = :ls_labour_id and trunc(:ld_dt) between trunc(mt_fromdt) and trunc(mt_todt);
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					select distinct KAMSUB_ID into :ls_kam_id from fb_kamsubhead where TRIM(kamsub_nkamtype)='MATERNITY';
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
					ll_row = dw_1.getrow()
					dw_1.setitem(dw_1.getrow(),'kamsub_id',ls_kam_id)
					ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,1,ll_row)			
					dw_1.setitem(dw_1.getrow(),'lda_wages',ld_wages)

				end if
				// Checking Maternity and setting Kamkari
				
	//			if ls_holidayflg = 'Y' then
	//				select distinct KAMSUB_ID into :ls_prevatd from fb_labourdailyattendance where trunc(lda_date) = trunc(:ld_dt) - 1 and LABOUR_ID = :ls_emp_id;
	//				if sqlca.sqlcode = -1 then
	//					messagebox('Error : While Getting Employee Previous Day Attendance Details',sqlca.sqlerrtext)
	//					rollback using sqlca;
	//					return 1
	//				end if	
	//				select distinct KAMSUB_ID into :ls_nextatd from fb_labourdailyattendance where trunc(lda_date) = trunc(:ld_dt) + 1 and LABOUR_ID = :ls_emp_id;
	//				if sqlca.sqlcode = -1 then
	//					messagebox('Error : While Getting Employee Next Day Attendance Details',sqlca.sqlerrtext)
	//					rollback using sqlca;
	//					return 1
	//				end if	
	//				if ls_prevatd = 'ESUB0258' and ls_nextatd = 'ESUB0258' then
	//					dw_1.setitem(dw_1.getrow(),'kamsub_id','ESUB0258')
	//					dw_1.setitem(dw_1.getrow(),'lda_status',0)
	//					dw_1.setitem(dw_1.getrow(),'lda_wages',0)
	//				else
	//					dw_1.setitem(dw_1.getrow(),'kamsub_id','ESUB0259')
	//					dw_1.setitem(dw_1.getrow(),'lda_status',1)
	//					dw_1.setitem(dw_1.getrow(),'lda_wages',wf_kamjari_rate(ld_dt,ls_emp_id,'ESUB0259',1,0,dw_1.getrow()))
	//				end if
	//			end if
				fetch c3 into :ls_labour_id,:ls_emp_name,:ls_task_ind;
			loop
		END IF
		close c3;			
	end if
	dw_1.setfocus()
	dw_1.scrolltorow(1)
	dw_1.setcolumn('kamsub_id')
else
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setitem(dw_1.getrow(),'lda_date',ld_dt)
	dw_1.setitem(dw_1.getrow(),'lda_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'lda_entry_dt',datetime(today()))
	dw_1.settaborder('labour_id',5)
	dw_1.setcolumn('labour_id')
    dw_1.setitem(dw_1.getrow(),'gs_gsnm',gs_garden_snm)
	dw_1.setitem(dw_1.getrow(),'ra_loginusr',upper(left(gs_loginuser,2)))
	dw_1.setitem(dw_1.getrow(),'ls_id',ll_paybook)
	if ld_prorata_hours > 0 then
		dw_1.setitem(dw_1.getrow(),'lda_prorataind','Y')
	end if
	dw_1.setitem(dw_1.getrow(),'lww_id',ls_lwwid)
	dw_1.setitem(dw_1.getrow(),'lda_taskind',ls_task_ind)
end if
lb_neworder = true
lb_query = false

setpointer(arrow!)
end event

type st_1 from statictext within w_gtelaf015
integer x = 462
integer y = 40
integer width = 407
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Attendance Date"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_gtelaf015
integer x = 4027
integer y = 16
integer width = 215
integer height = 100
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;if dw_1.modifiedcount() > 0 or dw_1.deletedcount() > 0 then
	IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		close(parent)
	else
		return
	end if
else
	close(parent)
end if
end event

type cb_3 from commandbutton within w_gtelaf015
integer x = 3817
integer y = 16
integer width = 215
integer height = 100
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	for ll_ctr = dw_1.rowcount() to 1 step -1
		if gs_garden_snm <> 'MT' then
			IF (isnull(dw_1.getitemstring(ll_ctr,'kamsub_id')) or len(dw_1.getitemstring(ll_ctr,'kamsub_id')) = 0 or isnull(dw_1.getitemstring(ll_ctr,'labour_id')) or  len(dw_1.getitemstring(ll_ctr,'labour_id')) = 0) THEN
				 dw_1.deleterow(ll_ctr)
			END IF
		elseif lb_neworder = true and ( isnull(dw_1.getitemstring(ll_ctr,'confirm_ind')) or dw_1.getitemstring(ll_ctr,'confirm_ind') = 'N') then
			dw_1.deleterow(ll_ctr)
		end if 
	next	
	if gs_garden_snm = 'MT' then
		for ll_ctr = dw_1.rowcount() to 1 step -1
			if lb_neworder = true and dw_1.getitemnumber(ll_ctr,'lda_wages') = 0 and &
				(dw_1.getitemstring(ll_ctr,'kamsub_id') <> 'ESUB0258' and  dw_1.getitemstring(ll_ctr,'kamsub_id') <> 'ESUB0259' and &
			      dw_1.getitemstring(ll_ctr,'kamsub_id') <> 'ESUB0260' and dw_1.getitemstring(ll_ctr,'kamsub_id') <> 'ESUB0061')   then
				dw_1.deleterow(ll_ctr)
			end if
		next	
	end if

	if dw_1.rowcount() > 0 then
		for ll_ctr = 1 to dw_1.rowcount() 
			IF wf_check_fillcol(ll_ctr) = -1 THEN
				return 1
			END IF
		next
	end if

	if lb_neworder = true then
		select nvl(MAX(JOB_ID),0) into :ls_last from fb_labourdailyattendance where JOB_ID like 'JOB%';
		ls_last = right(ls_last,10)
		ll_cnt = long(ls_last)
	end if

	 ll_adoleage = 0 ;ll_child=0
 
	select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0)) into :ll_adoleage, :ll_child
	from fb_param_detail 
	where pd_doc_type in ('CHILDAGE','ADOLEAGE') and trunc(sysdate) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));
	
	if sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
		return 1
	end if;

	
	if dw_1.rowcount() > 0 then
		for ll_ctr = 1 to dw_1.rowcount( ) 
			if lb_neworder = true then
				ll_cnt = ll_cnt + 1
				select lpad(:ll_cnt,10,'0') into :ls_count from dual;
				ls_tmp_id = 'JOB'+ls_count
				dw_1.setitem(ll_ctr,'job_id',ls_tmp_id)
			end if		
			ls_tmp_id = dw_1.getitemstring(ll_ctr,'job_id')
			ls_lwwid = dw_1.getitemstring(ll_ctr,'lww_id')
			ll_paybook = dw_1.getitemnumber(ll_ctr,'ls_id')
			ld_dt = dw_1.getitemdatetime(ll_ctr,'lda_date')
			ls_kam_id = dw_1.getitemstring(ll_ctr,'kamsub_id')
			ls_labour_id = dw_1.getitemstring(ll_ctr,'labour_id')
			
			select distinct 'x' into :ls_temp from fb_laboursheetattendance where LWW_ID = :ls_lwwid and trunc(LSA_DATE) = trunc(:ld_dt) and LS_ID = :ll_paybook;
			if sqlca.sqlcode = -1 then
				messagebox('Error : While getting detail',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 0 then
				update fb_laboursheetattendance set LSA_ATTENDANCEFLAG = '0', LSA_ATTENDANCECONFIRM = '0' 
				where LWW_ID = :ls_lwwid and LSA_DATE = trunc(:ld_dt) and LS_ID = :ll_paybook;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Updating table (fb_laboursheetattendance)',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			elseif sqlca.sqlcode = 100 then
				insert into fb_laboursheetattendance(LWW_ID, LS_ID, LSA_ATTENDANCEFLAG, LSA_DATE, LSA_ATTENDANCECONFIRM) 
				values(:ls_lwwid,:ll_paybook,'0',trunc(:ld_dt),'0');
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Record 2',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			end if	
			
			/////////////////////////////// covid uncheck
			
			select distinct kamsub_nkamtype into :ls_nkam_type from fb_kamsubhead where kamsub_id = :ls_kam_id and nvl(KAMSUB_ACTIVE_IND, 'N') = 'Y' and KAMSUB_TODT is null;
			if sqlca.sqlcode = -1 then
				messagebox('SQL ERROR: During checking kamsub nkamtype ',sqlca.sqlerrtext)
				return 1
			end if;
			
			if trim(ls_nkam_type) = 'OTHERS' then 
				select nvl(emp_covid_active, 'N') into :ls_covid from fb_employee where emp_id = :ls_labour_id;
				if sqlca.sqlcode = -1 then
					messagebox('SQL ERROR: During checking covid indicator 2',sqlca.sqlerrtext)
					return 1
				end if;
				
				if ls_covid = 'Y' then
					update fb_employee set EMP_COVID_ACTIVE = 'N', EMP_COVID_ENDDT =  trunc(:ld_dt) where emp_id = :ls_labour_id and emp_covid_active = 'Y' AND EMP_COVID_DT <=  trunc(:ld_dt); 
					if sqlca.sqlcode = -1 then
						messagebox('SQL ERROR: During updating covid indicator ',sqlca.sqlerrtext)
						return 1
					end if;
				end if
			end if
			
			//////////////////////////////////
			
			n_fames luo_fames
			luo_fames = Create n_fames

			double ld_measure1,ld_measure2,ld_measure3,ld_measure1_old,ld_measure2_old,ld_measure3_old,ld_status_old
			long ll_noof_sec,ll_noof_sec_old
			ls_dt = string(dw_1.getitemdatetime(ll_ctr,'lda_date'),'dd/mm/yyyy')
			ls_labour_id = dw_1.getitemstring(ll_ctr,'labour_id')
			ls_kam_id = dw_1.getitemstring(ll_ctr,'kamsub_id')
			ld_wages = dw_1.getitemnumber(ll_ctr,'lda_wages')
			ls_sec1 = dw_1.getitemstring(ll_ctr,'lda_sectionid1')
			ls_sec2 = dw_1.getitemstring(ll_ctr,'lda_sectionid2')
			ls_sec3 = dw_1.getitemstring(ll_ctr,'lda_sectionid3') 
			ld_measure1 = dw_1.getitemnumber(ll_ctr,'lda_mfj_count1') 
			ld_measure2 = dw_1.getitemnumber(ll_ctr,'lda_mfj_count2') 
			ld_measure3 = dw_1.getitemnumber(ll_ctr,'lda_mfj_count3') 
			
			ld_status = dw_1.getitemnumber(ll_ctr,'lda_status')
			
			ls_kam_id_old = dw_1.getitemstring(ll_ctr,'kamsub_id_old')
			ld_wages_old = dw_1.getitemnumber(ll_ctr,'lda_wages_old')
			ls_sec1_old = dw_1.getitemstring(ll_ctr,'lda_sectionid1_old')
			ls_sec2_old = dw_1.getitemstring(ll_ctr,'lda_sectionid2_old')
			ls_sec3_old = dw_1.getitemstring(ll_ctr,'lda_sectionid3_old') 
			ld_measure1_old = dw_1.getitemnumber(ll_ctr,'lda_mfj_count1_old') 
			ld_measure2_old = dw_1.getitemnumber(ll_ctr,'lda_mfj_count2_old') 
			ld_measure3_old = dw_1.getitemnumber(ll_ctr,'lda_mfj_count3_old') 
			ld_status_old = dw_1.getitemnumber(ll_ctr,'lda_status_old')

			if isnull(ld_measure1) then ld_measure1 = 0
			if isnull(ld_measure2) then ld_measure2 = 0
			if isnull(ld_measure3) then ld_measure3 = 0
			if isnull(ld_measure1_old) then ld_measure1_old = 0
			if isnull(ld_measure2_old) then ld_measure2_old = 0
			if isnull(ld_measure3_old) then ld_measure3_old = 0
			ld_measure = ld_measure1 + ld_measure2 + ld_measure3

			
				 ld_labage=0;setnull(ls_emp_ty);setnull(ls_sex);setnull(ls_cam_ind)
				 
				select get_diff(to_date(:ls_dt,'dd/mm/yyyy'),emp_dob,'B'), emp_type, emp_sex  into :ld_labage,:ls_emp_ty, :ls_sex//((to_date(:ls_dt,'dd/mm/yyyy') - emp_dob) /365)
				  from fb_employee emp where emp.emp_id= :ls_labour_id;
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Age Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				
				
				//CHECK FOR MATERNITY mASTER check
				setnull(LS_TEMP)
				
				SELECT DISTINCT 'x' INTO :LS_TEMP FROM fb_maternity WHERE  trunc(:ld_dt) BETWEEN MT_FROMDT AND MT_TODT AND MT_EMPID=:ls_labour_id;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While CHECKING MATERNITY',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				ELSEIF sqlca.sqlcode = 0 then
					setnull(LS_TEMP)
					select distinct KAMSUB_ID into :LS_TEMP from fb_kamsubhead where trim(kamsub_nkamtype)='MATERNITY' and KAMSUB_toDT is null ;
					if sqlca.sqlcode = -1 then
						messagebox('Error : While CHECKING MATERNITY in Kamjhari',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					elseif sqlca.sqlcode =0 then
						IF LS_TEMP<>ls_kam_id THEN
								messagebox('Warrning...!','For Labour ( '+ls_labour_id+' ) other than MATERNITY will not allowed')
								rollback using sqlca;
								return 1
						END IF
					elseif  sqlca.sqlcode =100 then
						messagebox('Warrning...!','Kindly Define Maternity in kamjhari Rate')
						rollback using sqlca;
						return 1
					end if
				end if
				
	
				If ld_labage <= ll_child Then
					ls_cam_ind = 'CH'
				ElseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
					ls_cam_ind = 'AD'
				ElseIf ld_labage > ll_adoleage Then
					ls_cam_ind = 'AA'
				End If

				ll_noof_sec  = 0 
				if len(ls_sec1) > 0 then ; ll_noof_sec  = ll_noof_sec + 1; end if ;
				if len(ls_sec2) > 0 then ; ll_noof_sec  = ll_noof_sec + 1; end if ;
				if len(ls_sec3) > 0 then ; ll_noof_sec  = ll_noof_sec + 1; end if ;

				ll_noof_sec_old  = 0 
				if len(ls_sec1_old) > 0 then ; ll_noof_sec_old  = ll_noof_sec_old + 1; end if ;
				if len(ls_sec2_old) > 0 then ; ll_noof_sec_old  = ll_noof_sec_old + 1; end if ;
				if len(ls_sec3_old) > 0 then ; ll_noof_sec_old  = ll_noof_sec_old + 1; end if ;

			if dw_1.GetItemStatus(ll_ctr,0,Primary!) = New!	or dw_1.GetItemStatus(ll_ctr,0,Primary!) = NewModified!	then
				if luo_fames.wf_upd_mes(ls_dt,ls_kam_id,ld_wages,'W','N') = -1 then 
					rollback using sqlca;
					return 1;
				end if 

		// Start Task Activity
				
				if (not isnull(ls_sec1) or len(ls_sec1) > 0) then
					if wf_saveactivitydaily(ls_dt,ls_labour_id,ls_kam_id,ls_sec1,(ld_status / ll_noof_sec),(ld_wages / ll_noof_sec),ld_measure1,'N',ls_cam_ind,ls_emp_ty,ls_sex) = -1 then 
						rollback using sqlca;
						return 1;
					end if
				end if
				if (not isnull(ls_sec2) or len(ls_sec2) > 0) then
					if wf_saveactivitydaily(ls_dt,ls_labour_id,ls_kam_id,ls_sec2,(ld_status / ll_noof_sec),(ld_wages / ll_noof_sec),ld_measure2,'N',ls_cam_ind,ls_emp_ty,ls_sex) = -1 then 
						rollback using sqlca;
						return 1;
					end if
				end if
				if (not isnull(ls_sec3) or len(ls_sec3) > 0) then
					if wf_saveactivitydaily(ls_dt,ls_labour_id,ls_kam_id,ls_sec3,(ld_status / ll_noof_sec),(ld_wages / ll_noof_sec),ld_measure3,'N',ls_cam_ind,ls_emp_ty,ls_sex) = -1 then 
						rollback using sqlca;
						return 1;
					end if
				end if
				
		// End Task Activity
				
			elseif dw_1.GetItemStatus(ll_ctr,0,Primary!) = DataModified!	then
				
				if luo_fames.wf_upd_mes(ls_dt,ls_kam_id_old,ld_wages_old,'W','Y') = -1 then 
					rollback using sqlca;
					return 1;
				end if
				if luo_fames.wf_upd_mes(ls_dt,ls_kam_id,ld_wages,'W','N') = -1 then 
					rollback using sqlca;
					return 1;
				end if
	// Start Task Activity
				// OLD Value Records				
				if (not isnull(ls_sec1_old) or len(ls_sec1_old) > 0) then
					if wf_saveactivitydaily(ls_dt,ls_labour_id,ls_kam_id_old,ls_sec1_old,(ld_status_old / ll_noof_sec_old),(ld_wages_old / ll_noof_sec_old),ld_measure1_old,'O',ls_cam_ind,ls_emp_ty,ls_sex) = -1 then 
						rollback using sqlca;
						return 1;
					end if
				end if
				if (not isnull(ls_sec2_old) or len(ls_sec2_old) > 0) then
					if wf_saveactivitydaily(ls_dt,ls_labour_id,ls_kam_id_old,ls_sec2_old,(ld_status_old / ll_noof_sec_old),(ld_wages_old / ll_noof_sec_old),ld_measure2_old,'O',ls_cam_ind,ls_emp_ty,ls_sex) = -1 then 
						rollback using sqlca;
						return 1;
					end if
				end if
				if (not isnull(ls_sec3_old) or len(ls_sec3_old) > 0) then
					if wf_saveactivitydaily(ls_dt,ls_labour_id,ls_kam_id_old,ls_sec3_old,(ld_status_old / ll_noof_sec_old),(ld_wages_old / ll_noof_sec_old),ld_measure3_old,'O',ls_cam_ind,ls_emp_ty,ls_sex) = -1 then 
						rollback using sqlca;
						return 1;
					end if
				end if
				// New Changed Records
				
				if (not isnull(ls_sec1) or len(ls_sec1) > 0) then
					if wf_saveactivitydaily(ls_dt,ls_labour_id,ls_kam_id,ls_sec1,(ld_status / ll_noof_sec),(ld_wages / ll_noof_sec),ld_measure1,'N',ls_cam_ind,ls_emp_ty,ls_sex) = -1 then 
						rollback using sqlca;
						return 1;
					end if
				end if
				if (not isnull(ls_sec2) or len(ls_sec2) > 0) then
					if wf_saveactivitydaily(ls_dt,ls_labour_id,ls_kam_id,ls_sec2,(ld_status / ll_noof_sec),(ld_wages / ll_noof_sec),ld_measure2,'N',ls_cam_ind,ls_emp_ty,ls_sex) = -1 then 
						rollback using sqlca;
						return 1;
					end if
				end if
				if (not isnull(ls_sec3) or len(ls_sec3) > 0) then
					if wf_saveactivitydaily(ls_dt,ls_labour_id,ls_kam_id,ls_sec3,(ld_status / ll_noof_sec),(ld_wages / ll_noof_sec),ld_measure3,'N',ls_cam_ind,ls_emp_ty,ls_sex) = -1 then 
						rollback using sqlca;
						return 1;
					end if
				end if
				// end Task Activity
			end if
			
		next	
	end if
	
	DESTROY n_fames
//	messagebox('Information;',' MES Posting Successfully Completed')

	
	if dw_1.update(true,false) = 1 then
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		dw_1.reset()
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
else
	return
end if 
end event

type gb_1 from groupbox within w_gtelaf015
integer x = 14
integer width = 457
integer height = 124
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylebox!
end type

type dw_1 from datawindow within w_gtelaf015
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
event ue_dwnkey pbm_dwnkey
event ue_kewdwn pbm_keydown
integer x = 9
integer y = 160
integer width = 4599
integer height = 2052
integer taborder = 100
string dataobject = "dw_gtelaf015"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
//		if newrow > currentrow and dw_1.rowcount() > 1 and gs_garden_snm = 'MT' then
//			ls_labour_id = dw_1.getitemstring(currentrow,'labour_id')
//			ld_dt = dw_1.getitemdatetime(currentrow,'lda_date')
//			ls_kam_id = dw_1.getitemstring(currentrow,'kamsub_id')
//			ld_status = dw_1.getitemnumber(currentrow,'lda_status')
//
//			select nvl(INC_AMTPERDAY,0) into :ld_wages from fb_incentive 
//			where INC_REC_TYPE = 'L' and KAMSUB_ID = :ls_labour_id and trunc(:ld_dt) between INC_FRDT and nvl(INC_TODT,trunc(sysdate));
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode = 100 then
//				ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,currentrow)
//				
//				select nvl(INC_AMTPERDAY,0) into :ld_kincentive from fb_incentive 
//				where INC_REC_TYPE = 'K' and KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(trunc(INC_TODT),trunc(sysdate));
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting Kamjari Incentive Details',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				elseif sqlca.sqlcode = 0 then
//					if isnull(ld_kincentive) then ld_kincentive = 0;
//					ld_wages = ld_wages + ld_kincentive
//				end if				
//			end if
//			dw_1.setitem(currentrow,'lda_wages',ld_wages)				
//		end if		
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1 and cbx_1.checked = true then
		ls_kam_id = dw_1.getitemstring(currentrow,'kamsub_id')
		ls_sec1 = dw_1.getitemstring(currentrow,'lda_sectionid1')
		if gs_garden_snm <> 'MF' and gs_garden_snm <> 'GF' and (ls_kam_id = 'ESUB0163' or ls_kam_id = 'ESUB0434' or ls_kam_id = 'ESUB0435') then //= 'ESUB0163' then
			if len(ls_sec1) > 0  or not isnull(ls_sec1) then
				setnull(ls_temp)
				
				select distinct 'x' into :ls_temp	from fb_sectionpluckinground where trunc(SPR_DATE) = trunc(:ld_dt) and section_id = :ls_sec1;
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 100 then
					messagebox('Warning!','Round Days Entry Not Done For The Section, Please Check !!!')
					dw_1.setitem(currentrow,'lda_sectionid1',ls_temp)
					return 1
				end if
			end if
		end if		
		
		dw_1.setitem(newrow,'lda_entry_by',gs_user)
		dw_1.setitem(newrow,'lda_entry_dt',datetime(today()))
		dw_1.setitem(newrow,'lda_date',dw_1.getitemdatetime(currentrow,'lda_date'))
		dw_1.setitem(newrow,'kamsub_id',dw_1.getitemstring(currentrow,'kamsub_id'))
		dw_1.setitem(newrow,'lda_wages',dw_1.getitemnumber(currentrow,'lda_wages'))		
		dw_1.setitem(newrow,'lda_sectionid1',dw_1.getitemstring(currentrow,'lda_sectionid1'))
		dw_1.setitem(newrow,'gs_gsnm',dw_1.getitemstring(currentrow,'gs_gsnm'))
		dw_1.setitem(newrow,'ra_loginusr',dw_1.getitemstring(currentrow,'ra_loginusr'))
		dw_1.setitem(newrow,'lda_taskind',dw_1.getitemstring(currentrow,'lda_taskind')) 
		dw_1.setitem(newrow,'ls_id',dw_1.getitemnumber(currentrow,'ls_id'))
		dw_1.setitem(newrow,'lda_prorataind',dw_1.getitemstring(currentrow,'lda_prorataind'))
		dw_1.setitem(newrow,'lww_id',dw_1.getitemstring(currentrow,'lww_id'))
		dw_1.setcolumn('labour_id') 
	end if
	
	if newrow > currentrow and dw_1.rowcount() > 1 and gs_garden_snm = 'MT' then
		//dw_1.setitem(newrow,'lda_sectionid1',dw_1.getitemstring(currentrow,'lda_sectionid1'))
		dw_1.setitem(newrow,'confirm_ind','Y')
	end if
	
	if dw_1.rowcount() > 1 and cbx_3.checked = true then
		//dw_1.getitemstring(currentrow,'kamsub_id')
		if currentrow = 0 then 
			currentrow = currentrow + 1
		end if
		ls_kam_id = dw_1.getitemstring(currentrow,'kamsub_id')
		ls_sec1 = dw_1.getitemstring(currentrow,'lda_sectionid1')
		if gs_garden_snm <> 'MF' and gs_garden_snm <> 'GF' and (ls_kam_id = 'ESUB0163' or ls_kam_id = 'ESUB0434' or ls_kam_id = 'ESUB0435') then //= 'ESUB0163' then
			if len(ls_sec1) > 0  or not isnull(ls_sec1) then
				setnull(ls_temp)
				
				select distinct 'x' into :ls_temp	from fb_sectionpluckinground where trunc(SPR_DATE) = trunc(:ld_dt) and section_id = :ls_sec1;
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 100 then
					messagebox('Warning!','Round Days Entry Not Done For The Section, Please Check !!!')
					dw_1.setitem(currentrow,'lda_sectionid1',ls_temp)
					return 1
				end if
			end if
		end if		
		
		if isnull(dw_1.getitemstring(newrow,'kamsub_id'))  then
			dw_1.setitem(newrow,'kamsub_id',dw_1.getitemstring(currentrow,'kamsub_id'))
			dw_1.setitem(newrow,'lda_sectionid1',dw_1.getitemstring(currentrow,'lda_sectionid1'))
			dw_1.setitem(newrow,'kamsub_secind',dw_1.getitemstring(currentrow,'kamsub_secind')) 
			dw_1.setitem(newrow,'lda_taskind',dw_1.getitemstring(currentrow,'lda_taskind')) 
			dw_1.setitem(newrow,'kamsub_measind',dw_1.getitemstring(currentrow,'kamsub_measind'))
			dw_1.setitem(newrow,'kamsub_costcind',dw_1.getitemstring(currentrow,'kamsub_costcind'))
			dw_1.setitem(newrow,'lda_status',dw_1.getitemnumber(currentrow,'lda_status'))
			dw_1.setitem(newrow,'lda_wages',dw_1.getitemnumber(currentrow,'lda_wages'))		
			dw_1.setcolumn('kamsub_id')
		end if
	end if
	
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event ue_dwnkey;if lb_neworder = true then
	if cbx_1.checked = true or ls_gsnm = 'KG' or ls_gsnm = 'DL' then
		IF KeyDown(KeyF6!) THEN
			dw_1.deleterow(dw_1.getrow())
		end if
//		IF KeyDown(KeyEnter!) THEN
//			if dw_1.getrow() = 1 then
//				dw_1.triggerevent(itemchanged!)
//			end if
//		end if		
		if dw_1.rowcount() = 0 then
			cb_3.enabled = false
		end if
	end if
end if

end event

event ue_kewdwn;if lb_neworder = true then
	if cbx_1.checked = true or ls_gsnm = 'KG'  or ls_gsnm = 'DL' then
		IF KeyDown(KeyF6!) THEN
			dw_1.deleterow(dw_1.getrow())
		end if
//		IF KeyDown(KeyEnter!) THEN
//			if dw_1.getrow() = 1 then
//				dw_1.triggerevent(itemchanged!)
//			end if
//		end if
		if dw_1.rowcount() = 0 then
			cb_3.enabled = false
		end if
	end if
end if

end event

event itemchanged;if lb_query = false then
	if dwo.name = 'labour_id' then
		ls_labour_id = data
		ld_dt = dw_1.getitemdatetime(row,'lda_date')
		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
		ld_status = dw_1.getitemnumber(row,'lda_status')
		
		select emp_name, ls_id,field_id,emp_type into :ls_emp_name, :ll_paybook,:ls_div,:ls_emptype from fb_employee a 
		where nvl(EMP_ACTIVE,'1') = '1' and emp_type in ('LP','LT','LO') and EMP_ID = :ls_labour_id;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning !!!','Invalid Employee Code, Please Check !!!')
			return 1
		end if
		
		select distinct 'x' into :ls_temp from fb_labourdailyattendance where lda_date =  :ld_dt and labour_id = :ls_labour_id;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Labour Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 0 then
			messagebox('Duplicate Entry !!!','Attendance Entry Of This Labour Already Exists For This Date, Please Check !!!')
			return 1
		end if
		
		if wf_check_duplicate_rec(ls_labour_id) = -1 then return 1
		
		select distinct 'x' into :ls_temp from fb_maternity 
		where mt_empid = :ls_labour_id and trunc(:ld_dt) between trunc(mt_fromdt) and trunc(mt_todt);
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 0 then
			select distinct KAMSUB_ID into :ls_kam_id from fb_kamsubhead where trim(kamsub_nkamtype)='MATERNITY';
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if
			dw_1.setitem(row,'kamsub_id',ls_kam_id)
			dw_1.modify("kamsub_id.protect = '1'")
		else
			dw_1.modify("kamsub_id.protect = '0'")
		end if
			dw_1.setitem(row,'emp_name',ls_emp_name)
			dw_1.setitem(row,'ls_id',ll_paybook)
			
		select distinct 'x' into :ls_temp  from fb_kamsubhead 
		where KAMSUB_ID = :ls_kam_id and KAMSUB_TYPE = 'NKAM' and trim(KAMSUB_NKAMTYPE) in ('SICKALLOWANCE','ABSENT','HOLIDAYNOPAY','SICKNOWAGES');
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then	
			select nvl(INC_AMTPERDAY,0) into :ld_wages from fb_incentive 
			where INC_REC_TYPE = 'L' and KAMSUB_ID = :ls_labour_id and trunc(:ld_dt) between INC_FRDT and nvl(INC_TODT,trunc(sysdate));
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 100 then
				ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
				
				select nvl(INC_AMTPERDAY,0) into :ld_kincentive from fb_incentive 
				where INC_REC_TYPE = 'K' and KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(trunc(INC_TODT),trunc(sysdate));
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Kamjari Incentive Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					if isnull(ld_kincentive) then ld_kincentive = 0;
					ld_wages = ld_wages + ld_kincentive
				end if				
			end if
			dw_1.setitem(row,'lda_wages',ld_wages)
		end if
	else
		ls_labour_id = dw_1.getitemstring(row,'labour_id')
	end if
	
	if dwo.name = 'lda_taskind' then
		if data = 'N' then
			ld_status = dw_1.getitemnumber(row,'lda_status')
			ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
			ls_labour_id = dw_1.getitemstring(row,'labour_id')
			ld_dt = dw_1.getitemdatetime(row,'lda_date')
			ls_labour_id = dw_1.getitemstring(row,'labour_id')
			select distinct 'x' into :ls_temp  from fb_kamsubhead 
			where KAMSUB_ID = :ls_kam_id and KAMSUB_TYPE = 'NKAM' and trim(KAMSUB_NKAMTYPE) in ('SICKALLOWANCE','ABSENT','HOLIDAYNOPAY','SICKNOWAGES');
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Kanjari Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 100 then	
				select nvl(INC_AMTPERDAY,0) into :ld_wages from fb_incentive 
				where INC_REC_TYPE = 'L' and KAMSUB_ID = :ls_labour_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(INC_TODT,trunc(sysdate));
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 100 then
					ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
						select nvl(INC_AMTPERDAY,0) into :ld_kincentive from fb_incentive 
						where INC_REC_TYPE = 'K' and KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(trunc(INC_TODT),trunc(sysdate));
						if sqlca.sqlcode = -1 then
							messagebox('Error : While Getting Kamjari Incentive Details',sqlca.sqlerrtext)
							rollback using sqlca;
							return 1
						elseif sqlca.sqlcode = 0 then
							if isnull(ld_kincentive) then ld_kincentive = 0;
							ld_wages = ld_wages + ld_kincentive
						end if	
				end if
			else
				ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
			end if
			dw_1.setitem(row,'lda_wages',ld_wages)
			ld_elp = 0
			dw_1.setitem(row,'lda_elp',ld_elp)
		else
			wf_cal_wages(dw_1.getitemnumber(row,'lda_mfj_count1'),dw_1.getitemnumber(row,'lda_mfj_count2'),dw_1.getitemnumber(row,'lda_mfj_count3'),row,dw_1.getitemnumber(row,'lda_status'))
		end if
	end if
	if dwo.name = 'lda_mfj_junglifoot'  then
		dw_1.setitem(row,'lda_elp',0)
		dw_1.setitem(row,'lda_mfj_count1',0)
		ls_JUNGLIFOOT_ind = trim(data)
		ld_status = dw_1.getitemnumber(row,'lda_status')
		ll_paybook = dw_1.getitemnumber(row,'ls_id')
		ld_dt = dw_1.getitemdatetime(row,'lda_date')
		ls_lwwind = dw_1.getitemstring(row,'lda_lwwind')
		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
		
		ld_labage = 0

		select FIELD_ID,get_diff(trunc(sysdate),trunc(EMP_DOB),'B'), ((:ld_dt - emp_dob) /365), emp_type, ls_id into :ls_div,:ll_year,:ld_labage, :ls_emptype, :ll_paybook  from fb_employee where emp_id = :ls_labour_id; //round((trunc(sysdate) - trunc(EMP_DOB))/365)
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Employee Age',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
				
		select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0))
		into :ll_adoleage, :ll_child
		from fb_param_detail 
		where pd_doc_type in ('CHILDAGE','ADOLEAGE') and
				 trunc(:ld_dt) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));
	
		if sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
			return 1
		end if;

		If ld_labage <= ll_child Then //(144 months=12 years)
			select distinct 'x' into :ls_temp	from fb_task 
			where TASK_ID = :ls_kam_id and trunc(:ld_dt) between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'CHILD';// and
					//(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N')));
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 0 then
				if gs_garden_snm = 'MB' and cbx_2.checked = true then
					dw_1.setitem(row,'lda_taskind','Y')
					dw_1.modify("lda_taskind.protect = '0'")
				elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
					dw_1.setitem(row,'lda_taskind','N')
					dw_1.modify("lda_taskind.protect = '1'")
				elseif gs_garden_snm <> 'MB' then
					dw_1.setitem(row,'lda_taskind','Y')
					dw_1.modify("lda_taskind.protect = '0'")					
				end if
			elseif sqlca.sqlcode = 100 then
				dw_1.setitem(row,'lda_taskind','N')
				dw_1.modify("lda_taskind.protect = '1'")
			end if
		elseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
			select distinct 'x' into :ls_temp	from fb_task  
			where TASK_ID = :ls_kam_id and trunc(:ld_dt)  between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADOLE';// and
					//(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 0 then
				if gs_garden_snm = 'MB' and cbx_2.checked = true then
					dw_1.setitem(row,'lda_taskind','Y')
					dw_1.modify("lda_taskind.protect = '0'")
				elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
					dw_1.setitem(row,'lda_taskind','N')
					dw_1.modify("lda_taskind.protect = '1'")
				elseif gs_garden_snm <> 'MB' then
					dw_1.setitem(row,'lda_taskind','Y')
					dw_1.modify("lda_taskind.protect = '0'")					
				end if				
			elseif sqlca.sqlcode = 100 then
				dw_1.setitem(row,'lda_taskind','N')
				dw_1.modify("lda_taskind.protect = '1'")
			end if 		
		elseIf ld_labage > ll_adoleage then
			select distinct 'x' into :ls_temp	from fb_task 
			where TASK_ID = :ls_kam_id and trunc(:ld_dt)  between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADULT';// and
					//(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 0 then
				if gs_garden_snm = 'MB' and cbx_2.checked = true then
					dw_1.setitem(row,'lda_taskind','Y')
					dw_1.modify("lda_taskind.protect = '0'")
				elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
					dw_1.setitem(row,'lda_taskind','N')
					dw_1.modify("lda_taskind.protect = '1'")
				elseif gs_garden_snm <> 'MB' then
					dw_1.setitem(row,'lda_taskind','Y')
					dw_1.modify("lda_taskind.protect = '0'")					
				end if				
			elseif sqlca.sqlcode = 100 then
				dw_1.setitem(row,'lda_taskind','N')
				dw_1.modify("lda_taskind.protect = '1'")
			end if 
		end if
//		if dw_1.getitemstring(row,'lda_taskind') = 'Y' then
		if dw_1.getitemnumber(row,'lda_mfj_count1') <> 0 then
			wf_cal_wages(dw_1.getitemnumber(row,'lda_mfj_count1'),dw_1.getitemnumber(row,'lda_mfj_count2'),dw_1.getitemnumber(row,'lda_mfj_count3'),row,dw_1.getitemnumber(row,'lda_status'))
		end if 
//		end if
	end if	
	
	if dwo.name = 'kamsub_id'  then
		dw_1.setitem(row,'lda_elp',0)
		ls_kam_id = trim(data)
		ld_status = dw_1.getitemnumber(row,'lda_status')
		ll_paybook = dw_1.getitemnumber(row,'ls_id')
		ld_dt = dw_1.getitemdatetime(row,'lda_date')
		ls_lwwind = dw_1.getitemstring(row,'lda_lwwind')
		ls_JUNGLIFOOT_ind = dw_1.getitemstring(row,'lda_mfj_junglifoot')
//		dw_1.setitem(row,'lda_status',1)
//		dwc_section1.SetFilter ("string(spr_date,'dd/mm/yyyy') = '"+string(ld_dt,'dd/mm/yyyy')+"'")
//		dwc_section1.settransobject(sqlca)
//		dwc_section1.filter()
//		dwc_section2.SetFilter ("string(spr_date,'dd/mm/yyyy') = '"+string(ld_dt,'dd/mm/yyyy')+"'")
//		dwc_section2.settransobject(sqlca)	
//		dwc_section2.retrieve()
//		dwc_section3.SetFilter ("string(spr_date,'dd/mm/yyyy') = '"+string(ld_dt,'dd/mm/yyyy')+"'")
//		dwc_section3.settransobject(sqlca)	
//		dwc_section3.retrieve()		
		ll_year = 0;
		ld_lwwopn = wf_lwwopening(ls_labour_id,ll_paybook,ld_dt)
	//	messagebox('opn',string(ld_lwwopn))
		
		// Checking Employee Retirement Age
		setnull(ls_temp);setnull(ll_temp);
		//dw_1.setitem(newrow,'lda_sectionid1',dw_1.getitemstring(currentrow,'lda_sectionid1'))
		//if 
		if ls_gsnm = 'KG' then
			dw_1.settaborder('lda_sectionid2',0)
			dw_1.settaborder('lda_taskind',0)
		end if
		
		if ls_gsnm = 'DL' then
			dw_1.settaborder('lda_sectionid2',0)
		end if			
		dw_1.setitem(row,'lda_sectionid1',ls_temp)
		dw_1.setitem(row,'lda_sectionid2',ls_temp)
		dw_1.setitem(row,'lda_sectionid3',ls_temp)
		dw_1.setitem(row,'lda_mfj_count1',ll_temp)
		dw_1.setitem(row,'lda_mfj_count2',ll_temp)
		dw_1.setitem(row,'lda_mfj_count3',ll_temp)
		ld_labage = 0
		select FIELD_ID,get_diff(trunc(sysdate),trunc(EMP_DOB),'B'),get_diff(:ld_dt ,trunc(EMP_DOB),'B'), emp_type, ls_id into :ls_div,:ll_year,:ld_labage, :ls_emptype, :ll_paybook  from fb_employee where emp_id = :ls_labour_id; //round((trunc(sysdate) - trunc(EMP_DOB))/365)   ((:ld_dt - emp_dob) /365)
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Employee Age',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		select nvl(KAMSUB_SECIND,'N') KAMSUB_SECIND, nvl(KAMSUB_MEASIND,'N') KAMSUB_MEASIND, nvl(KAMSUB_COSTCIND,'N') KAMSUB_COSTCIND, KAMSUB_NAME ,trim(kamsub_nkamtype),trim(KAMSUB_TYPE)
		into :ls_secind,:ls_measureind,:ls_ccind,:ls_kam_sname,:ls_nkam_type,:ls_kamtype
		from fb_kamsubhead where KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(KAMSUB_FRDT) and trunc(nvl(KAMSUB_TODT,sysdate));

		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Section, Measure & Costcenter Ind',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if

		dw_1.setitem(row,'kamsub_secind',ls_secind) 
		dw_1.setitem(row,'kamsub_measind',ls_measureind)
		dw_1.setitem(row,'kamsub_costcind',ls_ccind)

		if ls_kamtype ='OKAM' or ls_kamtype = 'NKAM' or ls_kamtype = 'FKAM' then

			select section_id into :ls_sec1 from fb_section  where substr(SECTION_NAME,1,1)||'KAM' = :ls_kamtype and FIELD_ID=:ls_div and section_type='C';
			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Section From Section Master',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode=0 then
				dw_1.setitem(row,'lda_sectionid1',ls_sec1)
			end if

		end if
		
		select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0))
		into :ll_adoleage, :ll_child
		from fb_param_detail 
		where pd_doc_type in ('CHILDAGE','ADOLEAGE') and
				 trunc(:ld_dt) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));
	
		if sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
			return 1
		end if;

		
 		if gs_garden_snm = 'FB' or gs_garden_snm = 'MK' or gs_garden_snm = 'ME' or gs_garden_snm = 'KG' or gs_garden_snm = 'BE' or gs_garden_snm = 'MV' or gs_garden_snm = 'SP' then
		
			If ld_labage <= ll_child Then //(144 months=12 years)
				select distinct 'x' into :ls_temp	from fb_task_fulbari 
				where TASK_EMPTYPE = :ls_emptype and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and trunc(:ld_dt) between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'CHILD';
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					if gs_garden_snm = 'MB' and cbx_2.checked = true then
						dw_1.setitem(row,'lda_taskind','Y')
						dw_1.modify("lda_taskind.protect = '0'")
					elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
						dw_1.setitem(row,'lda_taskind','N')
						dw_1.modify("lda_taskind.protect = '1'")
					elseif gs_garden_snm <> 'MB' then
						dw_1.setitem(row,'lda_taskind','Y')
						dw_1.modify("lda_taskind.protect = '0'")					
					end if
				elseif sqlca.sqlcode = 100 then
					dw_1.setitem(row,'lda_taskind','N')
					dw_1.modify("lda_taskind.protect = '1'")
				end if
			elseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
				select distinct 'x' into :ls_temp	from fb_task_fulbari  
				where TASK_EMPTYPE = :ls_emptype and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and trunc(:ld_dt)  between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADOLE';
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					if gs_garden_snm = 'MB' and cbx_2.checked = true then
						dw_1.setitem(row,'lda_taskind','Y')
						dw_1.modify("lda_taskind.protect = '0'")
					elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
						dw_1.setitem(row,'lda_taskind','N')
						dw_1.modify("lda_taskind.protect = '1'")
					elseif gs_garden_snm <> 'MB' then
						dw_1.setitem(row,'lda_taskind','Y')
						dw_1.modify("lda_taskind.protect = '0'")					
					end if				
				elseif sqlca.sqlcode = 100 then
					dw_1.setitem(row,'lda_taskind','N')
					dw_1.modify("lda_taskind.protect = '1'")
				end if 		
			elseIf ld_labage > ll_adoleage then
				select distinct 'x' into :ls_temp	from fb_task_fulbari 
				where TASK_EMPTYPE = :ls_emptype and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and trunc(:ld_dt)  between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'ADULT' ;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					if gs_garden_snm = 'MB' and cbx_2.checked = true then
						dw_1.setitem(row,'lda_taskind','Y')
						dw_1.modify("lda_taskind.protect = '0'")
					elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
						dw_1.setitem(row,'lda_taskind','N')
						dw_1.modify("lda_taskind.protect = '1'")
					elseif gs_garden_snm <> 'MB' then
						dw_1.setitem(row,'lda_taskind','Y')
						dw_1.modify("lda_taskind.protect = '0'")					
					end if				
				elseif sqlca.sqlcode = 100 then
					dw_1.setitem(row,'lda_taskind','N')
					dw_1.modify("lda_taskind.protect = '1'")
				end if 
			end if
		else
			If ld_labage <= ll_child Then //(144 months=12 years)
				select distinct 'x' into :ls_temp	from fb_task 
				where TASK_ID = :ls_kam_id and trunc(:ld_dt) between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'CHILD'; //and
						//(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N')));
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					if gs_garden_snm = 'MB' and cbx_2.checked = true then
						dw_1.setitem(row,'lda_taskind','Y')
						dw_1.modify("lda_taskind.protect = '0'")
					elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
						dw_1.setitem(row,'lda_taskind','N')
						dw_1.modify("lda_taskind.protect = '1'")
					elseif gs_garden_snm <> 'MB' then
						dw_1.setitem(row,'lda_taskind','Y')
						dw_1.modify("lda_taskind.protect = '0'")					
					end if
				elseif sqlca.sqlcode = 100 then
					dw_1.setitem(row,'lda_taskind','N')
					dw_1.modify("lda_taskind.protect = '1'")
				end if
			elseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
				select distinct 'x' into :ls_temp	from fb_task  
				where TASK_ID = :ls_kam_id and trunc(:ld_dt)  between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'ADOLE';// and
						//(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					if gs_garden_snm = 'MB' and cbx_2.checked = true then
						dw_1.setitem(row,'lda_taskind','Y')
						dw_1.modify("lda_taskind.protect = '0'")
					elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
						dw_1.setitem(row,'lda_taskind','N')
						dw_1.modify("lda_taskind.protect = '1'")
					elseif gs_garden_snm <> 'MB' then
						dw_1.setitem(row,'lda_taskind','Y')
						dw_1.modify("lda_taskind.protect = '0'")					
					end if				
				elseif sqlca.sqlcode = 100 then
					dw_1.setitem(row,'lda_taskind','N')
					dw_1.modify("lda_taskind.protect = '1'")
				end if 		
			elseIf ld_labage > ll_adoleage then
				select distinct 'x' into :ls_temp	from fb_task 
				where TASK_ID = :ls_kam_id and trunc(:ld_dt)  between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'ADULT';// and
						//(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					if gs_garden_snm = 'MB' and cbx_2.checked = true then
						dw_1.setitem(row,'lda_taskind','Y')
						dw_1.modify("lda_taskind.protect = '0'")
					elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
						dw_1.setitem(row,'lda_taskind','N')
						dw_1.modify("lda_taskind.protect = '1'")
					elseif gs_garden_snm <> 'MB' then
						dw_1.setitem(row,'lda_taskind','Y')
						dw_1.modify("lda_taskind.protect = '0'")					
					end if				
				elseif sqlca.sqlcode = 100 then
					dw_1.setitem(row,'lda_taskind','N')
					dw_1.modify("lda_taskind.protect = '1'")
				end if 
			end if			
		end if
		if isnull(ll_year) then ll_year = 0
		ll_retage = 0;
		select nvl(PD_VALUE,0) into :ll_retage from fb_param_detail where PD_DOC_TYPE = 'RETIREMENT' and PD_PERIOD_TO is null;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Retirement Age',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		if isnull(ll_retage) then ll_retage = 0
		
		if ld_labage >= ll_retage then
			messagebox('Warning!','Employee ('+ls_labour_id+') Has Reached Retirement Age, Please Check !!!')
			//return 1
		end if
		
		// Checking Employee Retirement Age
		
		select distinct 'x' into :ls_temp from fb_kamsubhead,fb_expenseacsubhead 
		where kamsub_id = eacsubhead_id and nvl(KAMSUB_ACTIVE_IND,'Y') = 'Y' and KAMSUB_TODT is null and KAMSUB_ID = :ls_kam_id;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning!','Invalid Kamjari ID, Please Check !!!')
//			if ls_gsnm <> 'KG' then
			return 1
//			end if
		end if
		
			ld_sick = 0;ld_sl = 0; setnull(ls_covid)
			if trim(ls_nkam_type) = 'SICKALLOWANCE' then
					select nvl(count(1),0) into :ld_sick from fb_labourdailyattendance where LABOUR_ID = :ls_labour_id and KAMSUB_ID = (select KAMSUB_ID from fb_kamsubhead where nvl(KAMSUB_ACTIVE_IND,'Y') = 'Y' and KAMSUB_NKAMTYPE = 'SICKALLOWANCE') and
											trunc(LDA_DATE) between to_date('01/01/'||to_char(trunc(:ld_dt),'YYYY'),'dd/mm/yyyy') and trunc(:ld_dt);
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				if isnull(ld_sick) then ld_sick = 0;
				
				select nvl(pd_value,0) into :ld_sl from fb_param_detail 
				where pd_doc_type = 'SICKALLOWANCE' and trunc(:ld_dt) between trunc(PD_PERIOD_FROM) and nvl(PD_PERIOD_TO,trunc(sysdate));
	
				if sqlca.sqlcode = -1 then
					messagebox('SQL ERROR: During Parametere Getting Sick Leave Days ',sqlca.sqlerrtext)
					return 1
				end if;
				
				select nvl(emp_covid_active, 'N') into :ls_covid from fb_employee where emp_id = :ls_labour_id;
				if sqlca.sqlcode = -1 then
					messagebox('SQL ERROR: During checking covid indicator ',sqlca.sqlerrtext)
					return 1
				end if;
				
				if isnull(ld_sl) then ld_sl = 0;
				
				///////////////////
				
				//commented BY piyush 08/11/2024 as sick leave is crossing 14 days limit Delloite
				
//				if ls_covid = 'Y' then
//					select nvl(pd_value,0) into :ld_covidsl from fb_param_detail 
//					where pd_doc_type = 'COVIDSICKALLOW' and trunc(:ld_dt) between trunc(PD_PERIOD_FROM) and nvl(PD_PERIOD_TO,trunc(sysdate));
//					if sqlca.sqlcode = -1 then
//						messagebox('SQL ERROR: During Parametere Getting Covid Sick Leave Days',sqlca.sqlerrtext)
//						return 1
//					end if;
//					
//					ld_sl = ld_sl + ld_covidsl
//				end if
				//////////////////////////
							
				
				if ld_sick >= ld_sl then
					messagebox('Warning !','This Employee ('+ls_labour_id+') Has Already Availed ' + string(ld_sl) +' Days Sick leave This Year, Pleae Check !!!')
					return 1
				end if
			end if
			
			if trim(ls_kam_sname) = 'LWW' then
				if ls_lwwind = 'Y' then
				// as per LWW calculation opening should come		
					ld_lwwopn = wf_lwwopening(ls_labour_id,ll_paybook,ld_dt)
					select nvl(count(1),0) into :ld_lwwavail from fb_labourdailyattendance where LABOUR_ID = :ls_labour_id and KAMSUB_ID = (select KAMSUB_ID from fb_kamsubhead where nvl(KAMSUB_ACTIVE_IND,'Y') = 'Y' and KAMSUB_NAME = 'LWW') and
												trunc(LDA_DATE) between to_date('01/01/'||to_char(sysdate,'YYYY'),'dd/mm/yyyy') and trunc(sysdate) and lda_lwwind = 'Y';
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
					if isnull(ld_lwwopn) then ld_lwwopn = 0;
					if isnull(ld_lwwavail) then ld_lwwavail = 0;
					if gs_garden_snm <> 'MK' and gs_garden_snm <> 'UB' then 
						if (ld_lwwopn - ld_lwwavail) <= 0 then
							messagebox('Warning !','LWW Balance Is Nil For This Employee, Pleae Check !!!')
							return 1
						end if
					elseif (gs_garden_snm = 'MK' or gs_garden_snm = 'UB') and string(ld_dt,'YYYY') < '2018' then 
						if (ld_lwwopn - ld_lwwavail) <= 0 then
							messagebox('Warning !','LWW Balance Is Nil For This Employee, Pleae Check !!!')
							return 1
						end if						
					end if
				else
					select sum(nvl(LWW_DAYS,0)) into :ld_lwwopn from fb_lablww a,fb_lablwwperiod b where a.LLP_ID = b.LLP_ID and labour_id = :ls_labour_id and to_char(LLP_STARTDATE,'YYYY') = (to_number(to_char(sysdate,'YYYY')) - 1);
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting LWW Opening Details',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
					select nvl(count(1),0) into :ld_lwwavail from fb_labourdailyattendance where LABOUR_ID = :ls_labour_id and KAMSUB_ID = (select KAMSUB_ID from fb_kamsubhead where nvl(KAMSUB_ACTIVE_IND,'Y') = 'Y' and KAMSUB_NAME = 'LWW') and
												trunc(LDA_DATE) between to_date('01/01/'||to_char(sysdate,'YYYY'),'dd/mm/yyyy') and trunc(sysdate);
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
					if isnull(ld_lwwopn) then ld_lwwopn = 0;
					if isnull(ld_lwwavail) then ld_lwwavail = 0;
					if gs_garden_snm <> 'MK' and gs_garden_snm <> 'UB' then 
						if (ld_lwwopn - ld_lwwavail) <= 0 then
							messagebox('Warning !','LWW Balance Is Nil For This Employee, Pleae Check !!!')
							return 1
						end if
					elseif (gs_garden_snm = 'MK' or gs_garden_snm = 'UB') and string(ld_dt,'YYYY') < '2018' then 
						if (ld_lwwopn - ld_lwwavail) <= 0 then
							messagebox('Warning !','LWW Balance Is Nil For This Employee, Pleae Check !!!')
							return 1
						end if						
					end if
				end if
			end if

		if (trim(ls_nkam_type) = 'MATERNITY' or trim(ls_nkam_type) = 'SICKALLOWANCE'  or trim(ls_nkam_type) = 'SICKNOWAGES')  then
			dw_1.setitem(row,'inout_ind','Y')
			dw_1.setitem(row,'lda_nature','OUT')
		else
			setnull(ls_temp)
			dw_1.setitem(row,'inout_ind','N')
			dw_1.setitem(row,'lda_nature',ls_temp)
		end if
		
		ls_labour_id = dw_1.getitemstring(row,'labour_id')
		select distinct 'x' into :ls_temp  from fb_kamsubhead 
		where KAMSUB_ID = :ls_kam_id and KAMSUB_TYPE = 'NKAM' and trim(KAMSUB_NKAMTYPE) in ('SICKALLOWANCE','ABSENT','HOLIDAYNOPAY','SICKNOWAGES');
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Kanjari Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then	
			select nvl(INC_AMTPERDAY,0) into :ld_wages from fb_incentive 
			where INC_REC_TYPE = 'L' and KAMSUB_ID = :ls_labour_id and trunc(:ld_dt) between INC_FRDT and nvl(INC_TODT,trunc(sysdate));
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 100 then
				ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
				
				select nvl(INC_AMTPERDAY,0) into :ld_kincentive from fb_incentive 
				where INC_REC_TYPE = 'K' and KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(trunc(INC_TODT),trunc(sysdate));
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Kamjari Incentive Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					if isnull(ld_kincentive) then ld_kincentive = 0;
					ld_wages = ld_wages + ld_kincentive
				end if			
			end if
		else
			ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)			
		end if
		dw_1.setitem(row,'lda_wages',ld_wages)
		if ld_wages = 0 then
			dw_1.setitem(row,'lda_elp',0)
		end if
	end if	
	
	if dwo.name = 'lda_daily_rateind' then
		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
		ld_dt = dw_1.getitemdatetime(row,'lda_date')
		
		if (gs_garden_snm='FB' or gs_garden_snm='MT') and cbx_4.checked = false and data = 'Y' then
			
			select kam.kamsub_afrate afrate into :ld_afrate from fb_kamsubhead kam
			where trim(kam.kamsub_id) = :ls_kam_id and trunc(:ld_dt) between trunc(KAMSUB_FRDT) and trunc(nvl(KAMSUB_TODT,sysdate));
			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if	
			if isnull(ld_afrate) then ld_afrate = 0;			
			ld_wages = ld_afrate
			dw_1.setitem(row,'lda_wages',ld_wages)
			dw_1.setitem(row,'lda_elp',0)
		elseif data = 'N' then
			wf_cal_wages(dw_1.getitemnumber(row,'lda_mfj_count1'),dw_1.getitemnumber(row,'lda_mfj_count2'),dw_1.getitemnumber(row,'lda_mfj_count3'),row,dw_1.getitemnumber(row,'lda_status'))
		end if
	end if
	
	IF dwo.name = 'lda_prorataind'  then
		ls_labour_id = dw_1.getitemstring(row,'labour_id')
		ld_dt = dw_1.getitemdatetime(row,'lda_date')
		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
		ld_status = dw_1.getitemnumber(row,'lda_status')

			select nvl(INC_AMTPERDAY,0) into :ld_wages from fb_incentive 
			where INC_REC_TYPE = 'L' and KAMSUB_ID = :ls_labour_id and trunc(:ld_dt) between INC_FRDT and nvl(INC_TODT,trunc(sysdate));
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 100 then
				//ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
				wf_cal_wages(dw_1.getitemnumber(row,'lda_mfj_count1'),dw_1.getitemnumber(row,'lda_mfj_count2'),dw_1.getitemnumber(row,'lda_mfj_count3'),row,dw_1.getitemnumber(row,'lda_status'))
				
				select nvl(INC_AMTPERDAY,0) into :ld_kincentive from fb_incentive 
				where INC_REC_TYPE = 'K' and KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(trunc(INC_TODT),trunc(sysdate));
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Kamjari Incentive Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					if isnull(ld_kincentive) then ld_kincentive = 0;
					ld_wages = ld_wages + ld_kincentive
				end if				
			end if
			dw_1.setitem(row,'lda_wages',ld_wages)
	end if	

	if dwo.name = 'lda_status'  then
		ld_status = double(data)
		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
		ls_labour_id = dw_1.getitemstring(row,'labour_id')
		ld_dt = dw_1.getitemdatetime(row,'lda_date')
		ls_labour_id = dw_1.getitemstring(row,'labour_id')
		
		if gs_garden_state = '03' then
			if double(data) <> 0 and double(data) <> 1  and double(data) <> 0.50 then
				messagebox('Invalid Status','Status Can Not Be (1/3, or 1/4), Please Check !!!')
				return 1
			end if
		end if
			
		if upper(gs_loginuser) <> 'MCOTE' then
			if double(data) > 1 then
				messagebox('Invalid Status','Status Can Not Be Other Than (FULL, Half, 1/3, or 1/4), Please Check !!!')
				return 1
			end if
		end if
			
		select nvl(INC_AMTPERDAY,0) into :ld_wages from fb_incentive 
		where INC_REC_TYPE = 'L' and KAMSUB_ID = :ls_labour_id and trunc(:ld_dt) between INC_FRDT and nvl(INC_TODT,trunc(sysdate));
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Labour Incentive Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then
			ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
			
			select nvl(INC_AMTPERDAY,0) into :ld_kincentive from fb_incentive 
			where INC_REC_TYPE = 'K' and KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(trunc(INC_TODT),trunc(sysdate));
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Kamjari Incentive Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 0 then
				if isnull(ld_kincentive) then ld_kincentive = 0;
				ld_wages = ld_wages + ld_kincentive
			end if				
			
		end if
		dw_1.setitem(row,'lda_wages',ld_wages) 
		if dw_1.getitemnumber(row,'lda_mfj_count1') > 0 then
//			ld_wagrtn = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
//			dw_1.setitem(row,'lda_wages',ld_wages)
			if dw_1.getitemstring(row,'lda_taskind') = 'Y' then
				wf_cal_wages(dw_1.getitemnumber(row,'lda_mfj_count1'),dw_1.getitemnumber(row,'lda_mfj_count2'),dw_1.getitemnumber(row,'lda_mfj_count3'),row,ld_status)
			end if
		end if
	else
		ld_status = getitemnumber(row,'lda_status')
	end if	

//	if dwo.name = 'lda_sectionid1'  then
//		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
//		
//		select distinct 'x' into :ls_temp from 
//		(select KAMSUB_ID from FB_KAMSUBHEAD where KAMSUB_ID in
//					 (select distinct EACSUBHEAD_ID from FB_EXPENSEACSUBHEAD where EACHEAD_ID in ('SLEG0012','SLEG0013','SLEG0022','SLEG0024')) or KAMSUB_ID = 'ESUB0163')
//		where KAMSUB_ID = :ls_kam_id;
//		
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 100 then
//			messagebox('Warning!','Section Not Required For This Type Of Kamjari, Please Check !!!')
//			setnull(ls_temp)
//			dw_1.setitem(row,'lda_sectionid1',ls_temp)
//			return 1
//		end if
//	end if	
	
	if dwo.name = 'lda_sectionid1' then
		ls_sec1 = trim(data)
		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
		ls_secind = dw_1.getitemstring(row,'kamsub_secind') 
		ld_dt = dw_1.getitemdatetime(row,'lda_date')
		setnull(ls_temp)
		dw_1.setitem(row,'confirm_ind','Y')	
		select distinct SECTION_TYPE into :ls_temp from fb_section where SECTION_ID = :ls_sec1;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Section Type (1)',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		if gs_garden_snm = 'MT' and dw_1.getitemnumber(row,'lda_wages') = 0 then
			ls_labour_id = dw_1.getitemstring(row,'labour_id')
			
			select nvl(INC_AMTPERDAY,0) into :ld_wages from fb_incentive 
			where INC_REC_TYPE = 'L' and KAMSUB_ID = :ls_labour_id and trunc(:ld_dt) between INC_FRDT and nvl(INC_TODT,trunc(sysdate));
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 100 then
				ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
				
				select nvl(INC_AMTPERDAY,0) into :ld_kincentive from fb_incentive 
				where INC_REC_TYPE = 'K' and KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(trunc(INC_TODT),trunc(sysdate));
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Kamjari Incentive Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					if isnull(ld_kincentive) then ld_kincentive = 0;
					ld_wages = ld_wages + ld_kincentive
				end if				
			end if
			dw_1.setitem(row,'lda_wages',ld_wages)		
		end if
//		if ls_secind = 'N' and ls_temp='S' and (not isnull(ls_sec1) or len(ls_sec1) > 0) then
//			messagebox('Warning!','Section Not Required For This Kamjari Id, Please Check !!!')
//			dw_1.setitem(row,'lda_sectionid1',ls_temp)
//			cb_3.enabled = false
//			return 1
//		end if
//		select nvl(KAMSUB_SECIND,'N') KAMSUB_SECIND, nvl(KAMSUB_MEASIND,'N') KAMSUB_MEASIND, nvl(KAMSUB_COSTCIND,'N') KAMSUB_COSTCIND
//		into :ls_secind,:ls_measureind,:ls_ccind
//		from fb_kamsubhead where KAMSUB_TODT is null and KAMSUB_ID = :ls_kam_id;
//		
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 0 then
//			if ls_secind = 'N' and (not isnull(ls_sec1) or len(ls_sec1) > 0) then
//				messagebox('Warning!','Section Not Required For This Kamjari Id, Please Check !!!')
//				dw_1.setitem(row,'lda_sectionid1',ls_temp)
//				return 1
//			end if
//		end if
		setnull(ls_temp)
		if data = dw_1.getitemstring(row,'lda_sectionid2') or data = dw_1.getitemstring(row,'lda_sectionid3') then
			messagebox('Warning!','Section ID 1,Section Id 2 And Section Id 3 Should Be Different, Please Check !!!')
			dw_1.setitem(row,'lda_sectionid1',ls_temp)
			return 1
		end if
	end if
	
	if dwo.name = 'lda_sectionid2' then
		ls_sec2 = data
		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
		ls_secind = dw_1.getitemstring(row,'kamsub_secind') 
		ld_dt = dw_1.getitemdatetime(row,'lda_date')
		setnull(ls_temp)
		
		select distinct SECTION_TYPE into :ls_temp from fb_section where SECTION_ID = :ls_sec2;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Section Type (2) ',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if

//		if ls_secind = 'N' and ls_temp='S' and (not isnull(ls_sec2) or len(ls_sec2) > 0) then
//			messagebox('Warning!','Section Not Required For This Kamjari Id, Please Check !!!')
//			dw_1.setitem(row,'lda_sectionid2',ls_temp)
//			cb_3.enabled = false
//			return 1
//		end if
		setnull(ls_temp)
		if data = dw_1.getitemstring(row,'lda_sectionid1') or data = dw_1.getitemstring(row,'lda_sectionid3') then
			messagebox('Warning!','Section ID 1,Section Id 2 And Section Id 3 Should Be Different, Please Check !!!')
			dw_1.setitem(row,'lda_sectionid2',ls_temp)
			return 1
		end if
	end if
	
	if dwo.name = 'lda_sectionid3' then
		ls_sec3 = data
		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
		ls_secind = dw_1.getitemstring(row,'kamsub_secind') 
		ld_dt = dw_1.getitemdatetime(row,'lda_date')
		setnull(ls_temp)
		
		select distinct SECTION_TYPE into :ls_temp from fb_section where SECTION_ID = :ls_sec3;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Section Type (3) ',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
//		if ls_secind = 'N' and  ls_temp='S' and (not isnull(ls_sec3) or len(ls_sec3) > 0) then
//			messagebox('Warning!','Section Not Required For This Kamjari Id, Please Check !!!')
//			dw_1.setitem(row,'lda_sectionid3',ls_temp)
//			cb_3.enabled = false
//			return 1
//		end if
		setnull(ls_temp)
		if data = dw_1.getitemstring(row,'lda_sectionid1') or data = dw_1.getitemstring(row,'lda_sectionid2') then
			messagebox('Warning!','Section ID 1,Section Id 2 And Section Id 3 Should Be Different, Please Check !!!')
			dw_1.setitem(row,'lda_sectionid3',ls_temp)
			return 1
		end if
	end if

	
	if dwo.name = 'lda_mfj_count1' then		
		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
		ls_measureind = dw_1.getitemstring(row,'kamsub_measind')
		ld_dt = dw_1.getitemdatetime(row,'lda_date')
		ls_sec1 = dw_1.getitemstring(row,'lda_sectionid1')
		ld_status = dw_1.getitemnumber(row,'lda_status')
		ls_labour_id = dw_1.getitemstring(row,'labour_id')
		//if isnull(ls_measureind) then ls_measureind = 'N';

		ld_wagrtn = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
		if gs_garden_snm <> 'MF' and gs_garden_snm <> 'GF' and (ls_kam_id = 'ESUB0163' or ls_kam_id = 'ESUB0434' or ls_kam_id = 'ESUB0435') then //= 'ESUB0163' then
			if len(ls_sec1) > 0  or not isnull(ls_sec1) then
				setnull(ls_temp)
				
				select distinct 'x' into :ls_temp	from fb_sectionpluckinground where trunc(SPR_DATE) = trunc(:ld_dt) and section_id = :ls_sec1;
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 100 then
					messagebox('Warning!','Round Days Entry Not Done For The Section, Please Check !!!')
					dw_1.setitem(row,'lda_sectionid1',ls_temp)
					return 1
				end if
			end if
		end if
		
		if ls_measureind = 'N' and (not isnull(data)  or double(data) <> 0) then
			messagebox('Warning!','Measure Not Required For This Kamjari Id, Please Check !!!')
			dw_1.setitem(row,'lda_mfj_count1',0)
			cb_3.enabled = false
			return 1
		end if
		
		if gs_garden_snm='FB' and ls_emptype = 'LO' and cbx_4.checked = true then
			 ld_m1 = double(data)
			 ld_m2 = dw_1.getitemnumber(row,'lda_mfj_count2')
			 ld_m3 = dw_1.getitemnumber(row,'lda_mfj_count3')
			 if isnull(ld_m1) then ld_m1 = 0;
			 if isnull(ld_m2) then ld_m2 = 0;
			 if isnull(ld_m3) then ld_m3 = 0;
			ld_measure = ld_m1 + ld_m2 + ld_m3
			ld_wages = ld_measure * ld_wagrtn
			dw_1.setitem(row,'lda_wages',ld_wages)
		else		
			if dw_1.getitemstring(row,'lda_taskind') = 'Y' then
				wf_cal_wages(double(data),dw_1.getitemnumber(row,'lda_mfj_count2'),dw_1.getitemnumber(row,'lda_mfj_count3'),row,dw_1.getitemnumber(row,'lda_status'))
			end if
		end if
		if (gs_garden_snm = 'KG') and ld_measure > 999 then
			messagebox('Warning!','Measure 1 is in 3 Gigits, Please Check !!!')
			return 1
		end if
		if (gs_garden_snm = 'DL') and ld_measure > 99 then
			messagebox('Warning!','Measure 1 is in 3 Gigits, Please Check !!!')
		end if
		
	end if 
	
	if dwo.name = 'lda_mfj_count2' then
		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
		ls_measureind = dw_1.getitemstring(row,'kamsub_measind')
		ld_dt = dw_1.getitemdatetime(row,'lda_date')
		ls_sec1 = dw_1.getitemstring(row,'lda_sectionid2')
		ld_status = dw_1.getitemnumber(row,'lda_status')
		ls_labour_id = dw_1.getitemstring(row,'labour_id')
		
		ld_wagrtn = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
		if gs_garden_snm <> 'MF' and gs_garden_snm <> 'GF' and (ls_kam_id = 'ESUB0163' or ls_kam_id = 'ESUB0434' or ls_kam_id = 'ESUB0435') then
			if len(ls_sec1) > 0  or not isnull(ls_sec1) then
				setnull(ls_temp)
				
				select distinct 'x' into :ls_temp	from fb_sectionpluckinground where trunc(SPR_DATE) = trunc(:ld_dt) and section_id = :ls_sec1;
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 100 then
					messagebox('Warning!','Round Days Entry Not Done For The Section, Please Check !!!')
					dw_1.setitem(row,'lda_sectionid2',ls_temp)
					return 1
				end if
			end if		
		end if
		
		if ls_measureind = 'N' and (not isnull(data)  or double(data) <> 0) then
			dw_1.setitem(row,'lda_mfj_count2',0)
			cb_3.enabled = false
			return 1
		end if
		if gs_garden_snm='FB' and ls_emptype = 'LO' and cbx_4.checked = true then
			 ld_m1 = dw_1.getitemnumber(row,'lda_mfj_count1')
			 ld_m2 = double(data)
			 ld_m3 = dw_1.getitemnumber(row,'lda_mfj_count3')
			 if isnull(ld_m1) then ld_m1 = 0;
			 if isnull(ld_m2) then ld_m2 = 0;
			 if isnull(ld_m3) then ld_m3 = 0;
			ld_measure = ld_m1 + ld_m2 + ld_m3
			ld_wages = ld_measure * ld_wagrtn
			dw_1.setitem(row,'lda_wages',ld_wages)
		else				
			if dw_1.getitemstring(row,'lda_taskind') = 'Y' then
				wf_cal_wages(dw_1.getitemnumber(row,'lda_mfj_count1'),double(data),dw_1.getitemnumber(row,'lda_mfj_count3'),row,dw_1.getitemnumber(row,'lda_status'))
			end if
		end if
	end if
	
	if dwo.name = 'lda_mfj_count3' then
		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
		ls_measureind = dw_1.getitemstring(row,'kamsub_measind')
		ld_dt = dw_1.getitemdatetime(row,'lda_date')
		ls_sec1 = dw_1.getitemstring(row,'lda_sectionid3')
		ld_status = dw_1.getitemnumber(row,'lda_status')
		ls_labour_id = dw_1.getitemstring(row,'labour_id')
		
		ld_wagrtn = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
		
		if gs_garden_snm <> 'MF' and gs_garden_snm <> 'GF' and  (ls_kam_id = 'ESUB0163' or ls_kam_id = 'ESUB0434' or ls_kam_id = 'ESUB0435') then
			if len(ls_sec1) > 0  or not isnull(ls_sec1) then
				setnull(ls_temp)
				
				select distinct 'x' into :ls_temp	from fb_sectionpluckinground where trunc(SPR_DATE) = trunc(:ld_dt) and section_id = :ls_sec1;
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 100 then
					messagebox('Warning!','Round Days Entry Not Done For The Section, Please Check !!!')
					dw_1.setitem(row,'lda_sectionid3',ls_temp)
					return 1
				end if
			end if		
		end if
		
		if ls_measureind = 'N' and (not isnull(data)  or double(data) <> 0) then
			dw_1.setitem(row,'lda_mfj_count3',0)
			cb_3.enabled = false
			return 1
		end if
		if gs_garden_snm='FB' and ls_emptype = 'LO' and cbx_4.checked = true then
			 ld_m1 = dw_1.getitemnumber(row,'lda_mfj_count1')
			 ld_m2 = dw_1.getitemnumber(row,'lda_mfj_count2')
			 ld_m3 = double(data)
			 if isnull(ld_m1) then ld_m1 = 0;
			 if isnull(ld_m2) then ld_m2 = 0;
			 if isnull(ld_m3) then ld_m3 = 0;
			ld_measure = ld_m1 + ld_m2 + ld_m3
			ld_wages = ld_measure * ld_wagrtn
			dw_1.setitem(row,'lda_wages',ld_wages)
		else				
			if dw_1.getitemstring(row,'lda_taskind') = 'Y' then
				wf_cal_wages(dw_1.getitemnumber(row,'lda_mfj_count1'),dw_1.getitemnumber(row,'lda_mfj_count2'),double(data),row,dw_1.getitemnumber(row,'lda_status'))
			end if
		end if
	end if
	
	setnull(ls_latta)
	dw_1.setitem(row,'lda_latta',ls_latta)
	dw_1.setitem(row,'lda_entry_by',gs_user)
	dw_1.setitem(row,'lda_entry_dt',datetime(today()))
	
	if cbx_1.checked = true then
		if dw_1.getrow() = dw_1.rowcount() and lb_neworder = true then
			dw_1.insertrow(0)
		end if
	end if
	cb_3.enabled = true
end if
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

event itemfocuschanged;if gs_garden_snm = 'MT' then
	if dwo.name = 'kamsub_id'  and lb_neworder = true then
		dw_1.setitem(row,'lda_elp',0)
		ls_kam_id = trim(dw_1.getitemstring(row,'kamsub_id'))
		ld_status = dw_1.getitemnumber(row,'lda_status')
		ll_paybook = dw_1.getitemnumber(row,'ls_id')
		ld_dt = dw_1.getitemdatetime(row,'lda_date')
		ls_lwwind = dw_1.getitemstring(row,'lda_lwwind')
		ls_JUNGLIFOOT_ind = dw_1.getitemstring(row,'lda_mfj_junglifoot')
		dw_1.setitem(row,'confirm_ind','Y')
//		dwc_section1.SetFilter ("string(spr_date,'dd/mm/yyyy') = '"+string(ld_dt,'dd/mm/yyyy')+"'")
//		dwc_section1.settransobject(sqlca)
//		dwc_section1.filter()
//		dwc_section2.SetFilter ("string(spr_date,'dd/mm/yyyy') = '"+string(ld_dt,'dd/mm/yyyy')+"'")
//		dwc_section2.settransobject(sqlca)	
//		dwc_section2.retrieve()
//		dwc_section3.SetFilter ("string(spr_date,'dd/mm/yyyy') = '"+string(ld_dt,'dd/mm/yyyy')+"'")
//		dwc_section3.settransobject(sqlca)	
//		dwc_section3.retrieve()		
		
		ld_lwwopn = wf_lwwopening(ls_labour_id,ll_paybook,ld_dt)
	//	messagebox('opn',string(ld_lwwopn))
		
		// Checking Employee Retirement Age
		setnull(ls_temp);setnull(ll_temp);
//		dw_1.setitem(row,'lda_sectionid1',ls_temp)
//		dw_1.setitem(row,'lda_sectionid2',ls_temp)
//		dw_1.setitem(row,'lda_sectionid3',ls_temp)
		dw_1.setitem(row,'lda_mfj_count1',ll_temp)
		dw_1.setitem(row,'lda_mfj_count2',ll_temp)
		dw_1.setitem(row,'lda_mfj_count3',ll_temp)
		ld_labage = 0;

		select FIELD_ID,get_diff(trunc(sysdate),trunc(EMP_DOB),'B'),get_diff(:ld_dt ,trunc(EMP_DOB),'B'), emp_type, ls_id into :ls_div,:ll_year,:ld_labage, :ls_emptype, :ll_paybook  from fb_employee where emp_id = :ls_labour_id; //round((trunc(sysdate) - trunc(EMP_DOB))/365), ((:ld_dt - emp_dob) /365)
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Employee Age',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		select nvl(KAMSUB_SECIND,'N') KAMSUB_SECIND, nvl(KAMSUB_MEASIND,'N') KAMSUB_MEASIND, nvl(KAMSUB_COSTCIND,'N') KAMSUB_COSTCIND, KAMSUB_NAME ,trim(kamsub_nkamtype),trim(KAMSUB_TYPE)
		into :ls_secind,:ls_measureind,:ls_ccind,:ls_kam_sname,:ls_nkam_type,:ls_kamtype
		from fb_kamsubhead where KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(KAMSUB_FRDT) and trunc(nvl(KAMSUB_TODT,sysdate));

		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Section, Measure & Costcenter Ind',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if

		dw_1.setitem(row,'kamsub_secind',ls_secind) 
		dw_1.setitem(row,'kamsub_measind',ls_measureind)
		dw_1.setitem(row,'kamsub_costcind',ls_ccind)

		if ls_kamtype ='OKAM' or ls_kamtype = 'NKAM' then

			select section_id into :ls_sec1 from fb_section  where substr(SECTION_NAME,1,1)||'KAM' = :ls_kamtype and FIELD_ID=:ls_div and section_type='C';
			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Section From Section Master',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode=0 then
				dw_1.setitem(row,'lda_sectionid1',ls_sec1)
			end if

		end if
		
		select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0))
		into :ll_adoleage, :ll_child
		from fb_param_detail 
		where pd_doc_type in ('CHILDAGE','ADOLEAGE') and
				 trunc(:ld_dt) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));
	
		if sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
			return 1
		end if;

		
// 		if gs_garden_snm = 'FB' then
//		
//			If ld_labage <= ll_child Then //(144 months=12 years)
//				select distinct 'x' into :ls_temp	from fb_task_fulbari 
//				where TASK_EMPTYPE = :ls_emptype and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and trunc(:ld_dt) between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'CHILD';
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				elseif sqlca.sqlcode = 0 then
//					if gs_garden_snm = 'MB' and cbx_2.checked = true then
//						dw_1.setitem(row,'lda_taskind','Y')
//						dw_1.modify("lda_taskind.protect = '0'")
//					elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
//						dw_1.setitem(row,'lda_taskind','N')
//						dw_1.modify("lda_taskind.protect = '1'")
//					elseif gs_garden_snm <> 'MB' then
//						dw_1.setitem(row,'lda_taskind','Y')
//						dw_1.modify("lda_taskind.protect = '0'")					
//					end if
//				elseif sqlca.sqlcode = 100 then
//					dw_1.setitem(row,'lda_taskind','N')
//					dw_1.modify("lda_taskind.protect = '1'")
//				end if
//			elseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
//				select distinct 'x' into :ls_temp	from fb_task_fulbari  
//				where TASK_EMPTYPE = :ls_emptype and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and trunc(:ld_dt)  between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADOLE';
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				elseif sqlca.sqlcode = 0 then
//					if gs_garden_snm = 'MB' and cbx_2.checked = true then
//						dw_1.setitem(row,'lda_taskind','Y')
//						dw_1.modify("lda_taskind.protect = '0'")
//					elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
//						dw_1.setitem(row,'lda_taskind','N')
//						dw_1.modify("lda_taskind.protect = '1'")
//					elseif gs_garden_snm <> 'MB' then
//						dw_1.setitem(row,'lda_taskind','Y')
//						dw_1.modify("lda_taskind.protect = '0'")					
//					end if				
//				elseif sqlca.sqlcode = 100 then
//					dw_1.setitem(row,'lda_taskind','N')
//					dw_1.modify("lda_taskind.protect = '1'")
//				end if 		
//			elseIf ld_labage > ll_adoleage then
//				select distinct 'x' into :ls_temp	from fb_task_fulbari 
//				where TASK_EMPTYPE = :ls_emptype and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and trunc(:ld_dt)  between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADULT' ;
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				elseif sqlca.sqlcode = 0 then
//					if gs_garden_snm = 'MB' and cbx_2.checked = true then
//						dw_1.setitem(row,'lda_taskind','Y')
//						dw_1.modify("lda_taskind.protect = '0'")
//					elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
//						dw_1.setitem(row,'lda_taskind','N')
//						dw_1.modify("lda_taskind.protect = '1'")
//					elseif gs_garden_snm <> 'MB' then
//						dw_1.setitem(row,'lda_taskind','Y')
//						dw_1.modify("lda_taskind.protect = '0'")					
//					end if				
//				elseif sqlca.sqlcode = 100 then
//					dw_1.setitem(row,'lda_taskind','N')
//					dw_1.modify("lda_taskind.protect = '1'")
//				end if 
//			end if
//		else  //if gs_garden_snm = 'FB' then
			If ld_labage <= ll_child Then //(144 months=12 years)
				select distinct 'x' into :ls_temp	from fb_task 
				where TASK_ID = :ls_kam_id and trunc(:ld_dt) between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'CHILD';// and
						//(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N')));
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					if gs_garden_snm = 'MB' and cbx_2.checked = true then
						dw_1.setitem(row,'lda_taskind','Y')
						dw_1.modify("lda_taskind.protect = '0'")
					elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
						dw_1.setitem(row,'lda_taskind','N')
						dw_1.modify("lda_taskind.protect = '1'")
					elseif gs_garden_snm <> 'MB' then
						dw_1.setitem(row,'lda_taskind','Y')
						dw_1.modify("lda_taskind.protect = '0'")					
					end if
				elseif sqlca.sqlcode = 100 then
					dw_1.setitem(row,'lda_taskind','N')
					dw_1.modify("lda_taskind.protect = '1'")
				end if
			elseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
				select distinct 'x' into :ls_temp	from fb_task  
				where TASK_ID = :ls_kam_id and trunc(:ld_dt)  between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'ADOLE';// and
						//(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					if gs_garden_snm = 'MB' and cbx_2.checked = true then
						dw_1.setitem(row,'lda_taskind','Y')
						dw_1.modify("lda_taskind.protect = '0'")
					elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
						dw_1.setitem(row,'lda_taskind','N')
						dw_1.modify("lda_taskind.protect = '1'")
					elseif gs_garden_snm <> 'MB' then
						dw_1.setitem(row,'lda_taskind','Y')
						dw_1.modify("lda_taskind.protect = '0'")					
					end if				
				elseif sqlca.sqlcode = 100 then
					dw_1.setitem(row,'lda_taskind','N')
					dw_1.modify("lda_taskind.protect = '1'")
				end if 		
			elseIf ld_labage > ll_adoleage then
				select distinct 'x' into :ls_temp	from fb_task 
				where TASK_ID = :ls_kam_id and trunc(:ld_dt)  between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'ADULT';// and
						//(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					if gs_garden_snm = 'MB' and cbx_2.checked = true then
						dw_1.setitem(row,'lda_taskind','Y')
						dw_1.modify("lda_taskind.protect = '0'")
					elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
						dw_1.setitem(row,'lda_taskind','N')
						dw_1.modify("lda_taskind.protect = '1'")
					elseif gs_garden_snm <> 'MB' then
						dw_1.setitem(row,'lda_taskind','Y')
						dw_1.modify("lda_taskind.protect = '0'")					
					end if				
				elseif sqlca.sqlcode = 100 then
					dw_1.setitem(row,'lda_taskind','N')
					dw_1.modify("lda_taskind.protect = '1'")
				end if 
			end if			
//		end if
//		if isnull(ll_year) then ll_year = 0
//		ll_retage = 0; 
//		select nvl(PD_VALUE,0) into :ll_retage from fb_param_detail where PD_DOC_TYPE = 'RETIREMENT' and PD_PERIOD_TO is null;
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Retirement Age',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		end if
//		if isnull(ll_retage) then ll_retage = 0
//		
//		if ld_labage >= ll_retage then
//			messagebox('Warning!1','Employee ('+ls_labour_id+') Has Reached Retirement Age, Please Check !!!')
//			//return 1
//		end if
		
		// Checking Employee Retirement Age
		ls_labour_id = dw_1.getitemstring(row,'labour_id')
		select distinct 'x' into :ls_temp from fb_kamsubhead,fb_expenseacsubhead 
		where kamsub_id = eacsubhead_id and nvl(KAMSUB_ACTIVE_IND,'Y') = 'Y' and KAMSUB_TODT is null and KAMSUB_ID = :ls_kam_id;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning!','Invalid Kamjari ID, Please Check !!!')
			return 1
		end if
		
			ld_sick = 0;ld_sl = 0;
			if trim(ls_nkam_type) = 'SICKALLOWANCE' then
					select nvl(count(1),0) into :ld_sick from fb_labourdailyattendance where LABOUR_ID = :ls_labour_id and KAMSUB_ID = (select KAMSUB_ID from fb_kamsubhead where nvl(KAMSUB_ACTIVE_IND,'Y') = 'Y' and KAMSUB_NKAMTYPE = 'SICKALLOWANCE') and
											trunc(LDA_DATE) between to_date('01/01/'||to_char(sysdate,'YYYY'),'dd/mm/yyyy') and trunc(:ld_dt);
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				if isnull(ld_sick) then ld_sick = 0;
				
				select nvl(pd_value,0) into :ld_sl from fb_param_detail 
				where pd_doc_type = 'SICKALLOWANCE' and trunc(:ld_dt) between trunc(PD_PERIOD_FROM) and nvl(PD_PERIOD_TO,trunc(sysdate));
	
				if sqlca.sqlcode = -1 then
					messagebox('SQL ERROR: During Parametere Getting Sick Leave Days ',sqlca.sqlerrtext)
					return 1
				end if;
				
				if isnull(ld_sl) then ld_sl = 0;
				
				if ld_sick >= ld_sl then
					messagebox('Warning !1','This Employee ('+ls_labour_id+') Has Already Availed ' + string(ld_sl) +' Days Sick leave This Year, Pleae Check !!!')
					return 1
				end if
			end if
//			
//			if trim(ls_kam_sname) = 'LWW' then
//				if ls_lwwind = 'Y' then
//				// as per LWW calculation opening should come
//					ld_lwwopn = wf_lwwopening(ls_labour_id,ll_paybook,ld_dt)
//					select nvl(count(1),0) into :ld_lwwavail from fb_labourdailyattendance where LABOUR_ID = :ls_labour_id and KAMSUB_ID = (select KAMSUB_ID from fb_kamsubhead where KAMSUB_NAME = 'LWW') and
//												trunc(LDA_DATE) between to_date('01/01/'||to_char(sysdate,'YYYY'),'dd/mm/yyyy') and trunc(sysdate) and lda_lwwind = 'Y';
//					if sqlca.sqlcode = -1 then
//						messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
//						rollback using sqlca;
//						return 1
//					end if
//					if isnull(ld_lwwopn) then ld_lwwopn = 0;
//					if isnull(ld_lwwavail) then ld_lwwavail = 0;
//					if (ld_lwwopn - ld_lwwavail) <= 0 then
//						messagebox('Warning !','LWW Balance Is Nil For This Employee, Pleae Check !!!')
//						return 1
//					end if
//
//				else
//					select nvl(LWW_DAYS,0) into :ld_lwwopn from fb_lablww a,fb_lablwwperiod b where a.LLP_ID = b.LLP_ID and labour_id = :ls_labour_id and to_char(LLP_STARTDATE,'YYYY') = (to_number(to_char(sysdate,'YYYY')) - 1);
//					if sqlca.sqlcode = -1 then
//						messagebox('Error : While Getting LWW Opening Details',sqlca.sqlerrtext)
//						rollback using sqlca;
//						return 1
//					end if
//					select nvl(count(1),0) into :ld_lwwavail from fb_labourdailyattendance where LABOUR_ID = :ls_labour_id and KAMSUB_ID = (select KAMSUB_ID from fb_kamsubhead where KAMSUB_NAME = 'LWW') and
//												trunc(LDA_DATE) between to_date('01/01/'||to_char(sysdate,'YYYY'),'dd/mm/yyyy') and trunc(sysdate);
//					if sqlca.sqlcode = -1 then
//						messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
//						rollback using sqlca;
//						return 1
//					end if
//					if isnull(ld_lwwopn) then ld_lwwopn = 0;
//					if isnull(ld_lwwavail) then ld_lwwavail = 0;
//					if (ld_lwwopn - ld_lwwavail) <= 0 then
//						messagebox('Warning !','LWW Balance Is Nil For This Employee, Pleae Check !!!')
//						return 1
//					end if
//				end if
//			end if
//
//		if (trim(ls_nkam_type) = 'MATERNITY' or trim(ls_nkam_type) = 'SICKALLOWANCE'  or trim(ls_nkam_type) = 'SICKNOWAGES')  then
//			dw_1.setitem(row,'inout_ind','Y')
//			dw_1.setitem(row,'lda_nature','OUT')
//		else
//			setnull(ls_temp)
//			dw_1.setitem(row,'inout_ind','N')
//			dw_1.setitem(row,'lda_nature',ls_temp)
//		end if
		
		ls_labour_id = dw_1.getitemstring(row,'labour_id')

		select nvl(INC_AMTPERDAY,0) into :ld_wages from fb_incentive 
		where INC_REC_TYPE = 'L' and KAMSUB_ID = :ls_labour_id and trunc(:ld_dt) between INC_FRDT and nvl(INC_TODT,trunc(sysdate));
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then
			ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
			
			select nvl(INC_AMTPERDAY,0) into :ld_kincentive from fb_incentive 
			where INC_REC_TYPE = 'K' and KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(trunc(INC_TODT),trunc(sysdate));
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Kamjari Incentive Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 0 then
				if isnull(ld_kincentive) then ld_kincentive = 0;
				ld_wages = ld_wages + ld_kincentive
			end if				
			
		end if
		dw_1.setitem(row,'lda_wages',ld_wages)
		if ld_wages = 0 then
			dw_1.setitem(row,'lda_elp',0)
		end if
	end if
end if
end event

type em_1 from editmask within w_gtelaf015
integer x = 869
integer y = 28
integer width = 320
integer height = 88
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "DD/MM/YYYY"
end type

event modified;dw_1.reset()
if not isdate(em_1.text) or isnull(em_1.text) then
	messagebox('Warning!', 'Please Enter A Valid Date !!!')
	return 1
end if

ls_dt = trim(em_1.text)

select distinct 'x' into :ls_temp from fb_labourdailyattendance where trunc(LDA_DATE) = to_date(:ls_dt,'dd/mm/yyyy');
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Attendance Date',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning!','Invalid Date, Attendance For This Date Is Not Available, Please Check !!!')
	return 1
end if		

setpointer(hourglass!)
ddlb_1.reset()

ddlb_1.additem('ALL {00}')

ld_dt = datetime(em_1.text)
setnull(ls_paybook)


//select distinct initcap(LS_MANID)||' {'||lpad(to_char(ls_id),2,'0')||'}',to_number(ls_id) from fb_laboursheet order by to_number(ls_id);

DECLARE c1 CURSOR FOR  
select initcap(LS_MANID)||' {'||lpad(to_char(ls_id),2,'0')||'}' from fb_laboursheet 
 where ls_id in  (select distinct ls_id from fb_labourdailyattendance lsa
		  				 where trunc(lsa.lda_date) = trunc(:ld_dt))
 order by to_number(ls_id);



open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_paybook;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(string(ls_paybook))
		fetch c1 into :ls_paybook;
	loop
	close c1;
end if

ddlb_1.text = ('ALL {00}')

setpointer(arrow!)
end event

type dp_1 from datepicker within w_gtelaf015
integer x = 873
integer y = 28
integer width = 384
integer height = 84
integer taborder = 20
boolean border = true
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2025-04-29"), Time("15:04:54.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

event valuechanged;setpointer(hourglass!)
ddlb_1.reset()

ld_dt = datetime(dp_1.value)
setnull(ls_paybook)

ddlb_1.additem('ALL {00}')
ls_gsnm = gs_garden_snm

DECLARE c1 CURSOR FOR  
select initcap(LS_MANID)||' {'||lpad(to_char(ls_id),2,'0')||'}' from fb_laboursheet 
 where ls_id in (select distinct ls_id from fb_employee e where case when (trunc(:ld_dt) < '01-Dec-2024' and e.EMP_JOBLEAVINGDATE = TO_DATE('30-Nov-2024', 'DD-Mon-YYYY')) then '1' else  NVL(e.EMP_ACTIVE, '1') end  = '1') AND 
		 (:ls_gsnm = 'FB' or (:ls_gsnm <> 'FB' and  ls_outsidertype<>'NON FACTORY')) AND  
		 ls_id not in (select ls_id from fb_laboursheetattendance lsa,fb_labourwagesweek lww 
		  				 where lsa.lww_id=lww.lww_id  and trunc(lsa.lsa_date) = trunc(:ld_dt) and 
							  	 (lsa.lsa_attendanceconfirm='1' or lww.lww_paidflag='1'))
 order by to_number(ls_id);

open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_paybook;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(string(ls_paybook))
		fetch c1 into :ls_paybook;
	loop
	close c1;
end if

setpointer(arrow!)

end event

