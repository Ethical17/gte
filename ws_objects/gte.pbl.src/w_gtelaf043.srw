$PBExportHeader$w_gtelaf043.srw
forward
global type w_gtelaf043 from window
end type
type cb_10 from commandbutton within w_gtelaf043
end type
type cb_9 from commandbutton within w_gtelaf043
end type
type cb_5 from commandbutton within w_gtelaf043
end type
type cb_3 from commandbutton within w_gtelaf043
end type
type cb_1 from commandbutton within w_gtelaf043
end type
type cb_8 from commandbutton within w_gtelaf043
end type
type cb_7 from commandbutton within w_gtelaf043
end type
type cb_6 from commandbutton within w_gtelaf043
end type
type em_1 from editmask within w_gtelaf043
end type
type st_3 from statictext within w_gtelaf043
end type
type st_2 from statictext within w_gtelaf043
end type
type ddlb_1 from dropdownlistbox within w_gtelaf043
end type
type cb_2 from commandbutton within w_gtelaf043
end type
type cb_4 from commandbutton within w_gtelaf043
end type
type dw_1 from datawindow within w_gtelaf043
end type
end forward

global type w_gtelaf043 from window
integer width = 5586
integer height = 3124
boolean titlebar = true
string title = "(w_gtelaf043) Employee Mobile Attendance"
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
cb_5 cb_5
cb_3 cb_3
cb_1 cb_1
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
em_1 em_1
st_3 st_3
st_2 st_2
ddlb_1 ddlb_1
cb_2 cb_2
cb_4 cb_4
dw_1 dw_1
end type
global w_gtelaf043 w_gtelaf043

type variables
long ll_ctr, ll_cnt,l_ctr,ll_paybook,ll_temp,ll_user_level,ll_last,ll_retage,ll_year,ll_adoleage, ll_child,ll_round,ll_paybook_old,ll_noofpunching,ll_timegap,ll_timegap2,ll_timegap3
string ls_temp,ls_del_ind,ls_labour_id,ls_tmp_id,ls_entry_user,ls_last,ls_count,ls_emp_name,ls_paybook,ls_lwwid,ls_kam_id, ls_protect_flg,ls_dt,ls_task_ind, ls_prorata_ind, ls_job_id,ls_first_read
string ls_kam_id_old, ls_holidayflg,ls_prevatd,ls_nextatd, ls_emp_ty, ls_sex, ls_cam_ind, ls_sec1,ls_sec2,ls_sec3, ls_sec1_old,ls_sec2_old,ls_sec3_old, ls_secind,ls_measureind,ls_ccind, ls_lwwind,ls_div,ls_kamtype
string ls_nkam_type,ls_kam_sname,ls_JUNGLIFOOT_ind,ls_emptype,ls_gsnm, ls_daily_rate,ls_paidfg, ls_calfg,ls_pwvn, ls_nature, ls_rec,ls_kamsub, ls_covid
boolean lb_neworder, lb_query
datetime ld_dt,ld_rundt,ld_stdt,ldenddt,ld_dob
double ld_measure, ld_rate,ld_afrate, ld_ahrate, ld_adfrate, ld_adhrate, ld_cfrate,ld_chrate, ld_status, ld_wages,ld_lwwopn,ld_lwwavail,ld_sick, ld_mat,ld_task
double ld_wages_old,ld_rtcp1,ld_rtcp2,ld_rtcp3,ld_rtlo1,ld_rtlo2,ld_rtlo3,ld_rtup1,ld_rtup2,ld_rtup3,ld_wagrtn,ld_exshwages,ld_labage,ld_elp, ld_kincentive,ld_sl, ld_m1,ld_m2,ld_m3,ld_m4,ld_rcp_diff
datawindowchild dwc_section1,dwc_section2,dwc_section3
n_cst_powerfilter iu_powerfilter
string ls_date
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_empid)
public function double wf_kamjari_rate (datetime fd_date, string fs_labourid, string fs_kamid, double fd_attendance, long fl_row)
public function integer wf_lwwopening (string fs_emp, long fl_lsid, datetime fd_dt)
public function integer wf_saveactivitydaily (string fs_date, string fs_labourid, string fd_kamid, string fs_secid, double fd_mandays, double fd_wages, double fd_measure, string fs_oldnew_ind, string fs_cam_ind, string fs_emp_ty, string fs_sex)
public function integer wf_cal_wages (double ld_measure1, double ld_measure2, double ld_measure3, long fl_row, double ld_status1)
end prototypes

event ue_option();//choose case gs_ueoption
//	case "PRINT"
//			OpenWithParm(w_print,this.dw_1)
//	case "PRINTPREVIEW"
//			this.dw_1.modify("datawindow.print.preview = yes")
//	case "RESETPREVIEW"
//			this.dw_1.modify("datawindow.print.preview = no")
//	case "ZOOM"
//			SetPointer (HourGlass!)											
//			OpenwithParm (w_zoom,dw_1)
//			SetPointer (Arrow!)						
//	case "SAVEAS"
//			this.dw_1.saveas()
//	case "FILTER"
//			setnull(gs_filtertext)
//			this.dw_1.setredraw(false)
//			this.dw_1.setfilter(gs_filtertext)
//			this.dw_1.filter()
//			this.dw_1.groupcalc()
//			if this.dw_1.rowcount() > 0 then;
//				this.dw_1.setredraw(true)
//			else
//				Messagebox('Warning','Data Not Available In Given Criteria')
//			end if
//	case "SORT"
//			setnull(gs_sorttext)
//			this.dw_1.setredraw(false)
//			this.dw_1.setsort(gs_sorttext)
//			this.dw_1.sort()
//			this.dw_1.groupcalc()
//			if this.dw_1.rowcount() > 0 then;
//				this.dw_1.setredraw(true)
//			else
//				Messagebox('Warning','Data Not Available In Given Criteria')
//			end if
//end choose
//
//
end event

public function integer wf_check_fillcol (integer fl_row);if dw_1.rowcount() > 0 and fl_row > 0 then
	if (not isnull(dw_1.getitemstring(fl_row,'kamsub_id')) or len(dw_1.getitemstring(fl_row,'kamsub_id')) > 0) and dw_1.getitemstring(fl_row,'kamsub_id') <> 'ESUB0258' and &
		 (isnull(dw_1.getitemnumber(fl_row,'lda_status')) or dw_1.getitemnumber(fl_row,'lda_status')=0 or &
		 isnull(dw_1.getitemnumber(fl_row,'lda_wages'))) then
	     messagebox('Warning: One Of The Following Fields Are Blank','Attendance, Wage, Please Check !!!')
		 return -1
	elseif gs_garden_snm = 'KG' and (not isnull(dw_1.getitemstring(fl_row,'kamsub_id')) or len(dw_1.getitemstring(fl_row,'kamsub_id')) > 0) and dw_1.getitemstring(fl_row,'kamsub_id') <> 'ESUB0258' and &
		    ( ( (dw_1.getitemstring(fl_row,'kamsub_secind') = 'Y' and  (isnull(dw_1.getitemstring(fl_row,'lda_sectionid1')) or len(dw_1.getitemstring(fl_row,'lda_sectionid1')) = 0) ) or & 
			  (dw_1.getitemstring(fl_row,'kamsub_measind') = 'Y' and (isnull(dw_1.getitemnumber(fl_row,'lda_mfj_count1')) or dw_1.getitemnumber(fl_row,'lda_mfj_count1') = 0)) )) then
		messagebox('Warning: One Of The Following Fields Are Blank','Section, Measure, Please Check !!!')
		return -1	
	elseif (not isnull(dw_1.getitemstring(fl_row,'kamsub_id')) or len(dw_1.getitemstring(fl_row,'kamsub_id')) > 0) and dw_1.getitemstring(fl_row,'kamsub_id') <> 'ESUB0258' and &
		    ( ( ( (isnull(dw_1.getitemstring(fl_row,'lda_sectionid1')) or len(dw_1.getitemstring(fl_row,'lda_sectionid1')) = 0) ) or & 
			  (dw_1.getitemstring(fl_row,'kamsub_measind') = 'Y' and (isnull(dw_1.getitemnumber(fl_row,'lda_mfj_count1')) or dw_1.getitemnumber(fl_row,'lda_mfj_count1') = 0)) )) then
		messagebox('Warning: One Of The Following Fields Are Blank','Section, Measure, Please Check !!!')
		return -1	
	elseif gs_garden_snm = 'MT' and dw_1.getitemstring(fl_row,'kamsub_id') = 'ESUB0163' and (isnull(dw_1.getitemstring(fl_row,'lda_mfj_junglifoot')) or (dw_1.getitemstring(fl_row,'lda_mfj_junglifoot') <> 'J' and dw_1.getitemstring(fl_row,'lda_mfj_junglifoot') <> 'F')) then
		messagebox('Warning: Jungli / Foot Indicator Is Incorrect','Incase Of Plucking Jungli/Foot Indicator Must Be Jungli Or Foot (Not NONE) , Please Check !!!')
		return -1			
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
where pd_doc_type in ('CHILDAGE','ADOLEAGE') and trunc(:fd_date) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));

if sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
	return -1
end if;


select get_diff(trunc(:fd_date),trunc(EMP_DOB),'B'),EMP_TYPE  into :ld_labage, :ls_emptype  from fb_employee emp  where emp.emp_id= :ls_labour_id;

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Labour Age Detail',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if
// trunc(:ld_dt) between KAMSUB_FRDT and nvl(KAMSUB_TODT,sysdate) 
//if gs_garden_snm='FB' and ls_emptype = 'LO' then
//	if cbx_4.checked = true then	
//		select rate afrate, 0 ahrate into :ld_afrate, :ld_ahrate from fb_cashpluckingrate
//		where trim(kamsub_id) = :fs_kamid and trunc(:fd_date) between trunc(cp_dt_from) and trunc(nvl(cp_dt_to,sysdate));
//		
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Labour Cash Rate Detail',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		end if
//	elseif cbx_4.checked = false then
//		select kamsub_afrate afrate,kamsub_ahrate ahrate into :ld_afrate, :ld_ahrate from fb_fboutsiderwgrate
//		where trim(kamsub_id) = :fs_kamid and trunc(:fd_date) between trunc(KAMSUB_FRDT) and trunc(nvl(KAMSUB_TODT,sysdate));
//		
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		end if		
//	end if
//else	
	select kam.kamsub_afrate afrate, kam.kamsub_ahrate ahrate, kam.kamsub_adfrate adfrate, kam.kamsub_adhrate adhrate, kam.kamsub_cfrate cfrate,kam.kamsub_chrate chrate 
		into :ld_afrate, :ld_ahrate, :ld_adfrate, :ld_adhrate, :ld_cfrate,:ld_chrate 
	 from fb_kamsubhead kam
	where trim(kam.kamsub_id) = :fs_kamid and trunc(:fd_date) between trunc(KAMSUB_FRDT) and trunc(nvl(KAMSUB_TODT,sysdate)) and nvl(KAMSUB_ACTIVE_IND,'N')='Y';
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
//end if

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
//	if ld_prorata_hours > 0 and ls_prorata_ind ='Y'  then
	if ld_prorata_hours > 0  then // changes on 200618 as per somnath mark prorata for all emp and will remove prorata manually
		If ld_labage <= ll_child Then //(144 months=12 years)
			 If fd_attendance = 1 Then
				 ld_rate =ld_cFrate - round(((ld_cFrate / 8) * ld_prorata_hours),0)
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
//elseif gs_garden_snm='FB' and ls_emptype = 'LO' then
//	if cbx_4.checked = true then
//		ld_rate = ld_aFrate
//	else
//		 If fd_attendance = 1 Then
//			 ld_rate = ld_aFrate
//		elseIf fd_attendance = 0.5 Then
//			 ld_rate = ld_aHrate
//		else
//			 ld_rate = ld_aFrate * fd_attendance
//		 End If		
//	end if
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
		return -1
	elseif sqlca.sqlcode = 0 then
		update fb_taskactivedaily set TASK_PMATODAYTY = nvl(TASK_PMATODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_PFATODAYTY = nvl(TASK_PFATODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_TMATODAYTY = nvl(TASK_TMATODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_TFATODAYTY = nvl(TASK_TFATODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_OMATODAYTY = nvl(TASK_OMATODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_OFATODAYTY = nvl(TASK_OFATODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_PMADTODAYTY = nvl(TASK_PMADTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_PFADTODAYTY = nvl(TASK_PFADTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_TMADTODAYTY = nvl(TASK_TMADTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_TFADTODAYTY = nvl(TASK_TFADTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_OMADTODAYTY = nvl(TASK_OMADTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_OFADTODAYTY = nvl(TASK_OFADTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_PMCTODAYTY = nvl(TASK_PMCTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_PFCTODAYTY = nvl(TASK_PFCTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_TMCTODAYTY = nvl(TASK_TMCTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_TFCTODAYTY = nvl(TASK_TFCTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_OMCTODAYTY = nvl(TASK_OMCTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_OFCTODAYTY = nvl(TASK_OFCTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
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
											  TASK_OMAWTODAYTY = nvl(TASK_OMAWTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_OFAWTODAYTY = nvl(TASK_OFAWTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_OMADWTODAYTY = nvl(TASK_OMADWTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
											  TASK_OFADWTODAYTY = nvl(TASK_OFADWTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0),  
											  TASK_OMCWTODAYTY = nvl(TASK_OMCWTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),   
											  TASK_OFCWTODAYTY = nvl(TASK_OFCWTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),
											  TASK_TOTWAGESTODAYTY = nvl(TASK_TOTWAGESTODAYTY,0) - nvl(:fd_wages,0)
		where TASK_ID = :fd_kamid and TASK_DATE = to_date(:fs_date,'dd/mm/yyyy') and SECTION_ID = :fs_secid;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Updating taskactivedaily Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return -1
		end if
		
		update fb_taskactivemeasurement set 	 TASK_PMACOUNTTODAYTY = nvl(TASK_PMACOUNTTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
															 TASK_PFACOUNTTODAYTY = nvl(TASK_PFACOUNTTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_TMACOUNTTODAYTY = nvl(TASK_TMACOUNTTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
															 TASK_TFACOUNTTODAYTY = nvl(TASK_TFACOUNTTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_OMACOUNTTODAYTY = nvl(TASK_OMACOUNTTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_OFACOUNTTODAYTY = nvl(TASK_OFACOUNTTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_PMADCOUNTTODAYTY = nvl(TASK_PMADCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_PFADCOUNTTODAYTY = nvl(TASK_PFADCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_TMADCOUNTTODAYTY = nvl(TASK_TMADCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_TFADCOUNTTODAYTY = nvl(TASK_TFADCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
															 TASK_OMADCOUNTTODAYTY = nvl(TASK_OMADCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
															 TASK_OFADCOUNTTODAYTY = nvl(TASK_OFADCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_PMCCOUNTTODAYTY = nvl(TASK_PMCCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
															 TASK_PFCCOUNTTODAYTY = nvl(TASK_PFCCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0),
															 TASK_TMCCOUNTTODAYTY = nvl(TASK_TMCCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
															 TASK_TFCCOUNTTODAYTY = nvl(TASK_TFCCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
															 TASK_OMCCOUNTTODAYTY = nvl(TASK_OMCCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0),
															 TASK_OFCCOUNTTODAYTY  = nvl(TASK_OFCCOUNTTODAYTY,0) - decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0)
		where TASKSECTION_ID = (select TASKDATE_ID from fb_taskactivedaily where TASK_ID = :fd_kamid and TASK_DATE = to_date(:fs_date,'dd/mm/yyyy') and SECTION_ID = :fs_secid);
	
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Updating taskactivemeasurement Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return -1
		end if
	end if	
	
elseif fs_oldnew_ind = 'N' then
	select distinct 'x' into :ls_temp from fb_taskactivedaily where TASK_ID = :fd_kamid and TASK_DATE = to_date(:fs_date,'dd/mm/yyyy') and SECTION_ID = :fs_secid;
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting taskactivedaily Detail',sqlca.sqlerrtext)
		rollback using sqlca;
		return -1
	elseif sqlca.sqlcode = 0 then
			
		update fb_taskactivedaily set TASK_PMATODAYTY = nvl(TASK_PMATODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_PFATODAYTY = nvl(TASK_PFATODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_TMATODAYTY = nvl(TASK_TMATODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_TFATODAYTY = nvl(TASK_TFATODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_OMATODAYTY = nvl(TASK_OMATODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_OFATODAYTY = nvl(TASK_OFATODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
											  TASK_PMADTODAYTY = nvl(TASK_PMADTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_PFADTODAYTY = nvl(TASK_PFADTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_TMADTODAYTY = nvl(TASK_TMADTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_TFADTODAYTY = nvl(TASK_TFADTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_OMADTODAYTY = nvl(TASK_OMADTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_OFADTODAYTY = nvl(TASK_OFADTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
											  TASK_PMCTODAYTY = nvl(TASK_PMCTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_PFCTODAYTY = nvl(TASK_PFCTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_TMCTODAYTY = nvl(TASK_TMCTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_TFCTODAYTY = nvl(TASK_TFCTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_OMCTODAYTY = nvl(TASK_OMCTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
											  TASK_OFCTODAYTY = nvl(TASK_OFCTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
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
											  TASK_OMAWTODAYTY = nvl(TASK_OMAWTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_OFAWTODAYTY = nvl(TASK_OFAWTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
											  TASK_OMADWTODAYTY = nvl(TASK_OMADWTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
											  TASK_OFADWTODAYTY = nvl(TASK_OFADWTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0),  
											  TASK_OMCWTODAYTY = nvl(TASK_OMCWTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),   
											  TASK_OFCWTODAYTY = nvl(TASK_OFCWTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),
											  TASK_TOTWAGESTODAYTY = nvl(TASK_TOTWAGESTODAYTY,0) + nvl(:fd_wages,0)
		where TASK_ID = :fd_kamid and TASK_DATE = to_date(:fs_date,'dd/mm/yyyy') and SECTION_ID = :fs_secid;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Updating taskactivedaily Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return -1
		end if
		
//		update fb_taskactivemeasurement set 	 TASK_PMACOUNTTODAYTY = nvl(TASK_PMACOUNTTODAYTY,0) + decode(m_fs_emp_ty,'LP',decode(m_fs_sex,'M',decode(m_fs_cam_ind,'AA',nvl(m_fd_measure,0),0),0),0), 
//															 TASK_PFACOUNTTODAYTY = nvl(TASK_PFACOUNTTODAYTY,0) + decode(m_fs_emp_ty,'LP',decode(m_fs_sex,'F',decode(m_fs_cam_ind,'AA',nvl(m_fd_measure,0),0),0),0),
//															 TASK_TMACOUNTTODAYTY = nvl(TASK_TMACOUNTTODAYTY,0) + decode(m_fs_emp_ty,'LT',decode(m_fs_sex,'M',decode(m_fs_cam_ind,'AA',nvl(m_fd_measure,0),0),0),0), 
//															 TASK_TFACOUNTTODAYTY = nvl(TASK_TFACOUNTTODAYTY,0) + decode(m_fs_emp_ty,'LT',decode(m_fs_sex,'F',decode(m_fs_cam_ind,'AA',nvl(m_fd_measure,0),0),0),0),
//															 TASK_OMACOUNTTODAYTY = nvl(TASK_OMACOUNTTODAYTY,0) + decode(m_fs_emp_ty,'LO',decode(m_fs_sex,'M',decode(m_fs_cam_ind,'AA',nvl(m_fd_measure,0),0),0),0),
//															 TASK_OFACOUNTTODAYTY = nvl(TASK_OFACOUNTTODAYTY,0) + decode(m_fs_emp_ty,'LO',decode(m_fs_sex,'F',decode(m_fs_cam_ind,'AA',nvl(m_fd_measure,0),0),0),0),
//															 TASK_PMADCOUNTTODAYTY = nvl(TASK_PMADCOUNTTODAYTY,0) + decode(m_fs_emp_ty,'LP',decode(m_fs_sex,'M',decode(m_fs_cam_ind,'AD',nvl(m_fd_measure,0),0),0),0),
//															 TASK_PFADCOUNTTODAYTY = nvl(TASK_PFADCOUNTTODAYTY,0) + decode(m_fs_emp_ty,'LP',decode(m_fs_sex,'F',decode(m_fs_cam_ind,'AD',nvl(m_fd_measure,0),0),0),0),
//															 TASK_TMADCOUNTTODAYTY = nvl(TASK_TMADCOUNTTODAYTY,0) + decode(m_fs_emp_ty,'LT',decode(m_fs_sex,'M',decode(m_fs_cam_ind,'AD',nvl(m_fd_measure,0),0),0),0),
//															 TASK_TFADCOUNTTODAYTY = nvl(TASK_TFADCOUNTTODAYTY,0) + decode(m_fs_emp_ty,'LT',decode(m_fs_sex,'F',decode(m_fs_cam_ind,'AD',nvl(m_fd_measure,0),0),0),0), 
//															 TASK_OMADCOUNTTODAYTY = nvl(TASK_OMADCOUNTTODAYTY,0) + decode(m_fs_emp_ty,'LO',decode(m_fs_sex,'M',decode(m_fs_cam_ind,'AD',nvl(m_fd_measure,0),0),0),0), 
//															 TASK_OFADCOUNTTODAYTY = nvl(TASK_OFADCOUNTTODAYTY,0) + decode(m_fs_emp_ty,'LO',decode(m_fs_sex,'F',decode(m_fs_cam_ind,'AD',nvl(m_fd_measure,0),0),0),0),
//															 TASK_PMCCOUNTTODAYTY = nvl(TASK_PMCCOUNTTODAYTY,0) + decode(m_fs_emp_ty,'LP',decode(m_fs_sex,'M',decode(m_fs_cam_ind,'CH',nvl(m_fd_measure,0),0),0),0), 
//															 TASK_PFCCOUNTTODAYTY = nvl(TASK_PFCCOUNTTODAYTY,0) + decode(m_fs_emp_ty,'LP',decode(m_fs_sex,'F',decode(m_fs_cam_ind,'CH',nvl(m_fd_measure,0),0),0),0),
//															 TASK_TMCCOUNTTODAYTY = nvl(TASK_TMCCOUNTTODAYTY,0) + decode(m_fs_emp_ty,'LT',decode(m_fs_sex,'M',decode(m_fs_cam_ind,'CH',nvl(m_fd_measure,0),0),0),0), 
//															 TASK_TFCCOUNTTODAYTY = nvl(TASK_TFCCOUNTTODAYTY,0) + decode(m_fs_emp_ty,'LT',decode(m_fs_sex,'F',decode(m_fs_cam_ind,'CH',nvl(m_fd_measure,0),0),0),0), 
//															 TASK_OMCCOUNTTODAYTY = nvl(TASK_OMCCOUNTTODAYTY,0) + decode(m_fs_emp_ty,'LO',decode(m_fs_sex,'M',decode(m_fs_cam_ind,'CH',nvl(m_fd_measure,0),0),0),0),
//															 TASK_OFCCOUNTTODAYTY  = nvl(TASK_OFCCOUNTTODAYTY,0) + decode(m_fs_emp_ty,'LO',decode(m_fs_sex,'F',decode(m_fs_cam_ind,'CH',nvl(m_fd_measure,0),0),0),0)
//		where TASKSECTION_ID = (select TASKDATE_ID from fb_taskactivedaily where TASK_ID = m_fd_kamid and TASK_DATE = to_date(m_fs_date,'dd/mm/yyyy') and SECTION_ID = m_fs_secid);
//	
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Updating taskactivemeasurement Detail',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return -1
//		end if
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
				  decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0),
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',:fd_mandays,0),0),0), 
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
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0), 
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_wages,0),0),0),0),  
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),   
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_wages,0),0),0),0),
				 nvl(:fd_wages,0),:fs_secid,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Inserting taskactivedaily Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return -1
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
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),  
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0),   
				 decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0),
				 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
				 
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Inserting taskactivemeasurement Detail',sqlca.sqlerrtext)
			rollback using sqlca;
			return -1
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
		
		select emp.emp_dob labdob, ((:ld_dt - emp_dob) /365), emp_type, ls_id,field_id into :ld_dob, :ld_labage, :ls_emptype, :ll_paybook,:ls_div
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
				where TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'CHILD' and
						(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N')));
						
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			elseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
				select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0), nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
				into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
				from fb_task 
				where TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADOLE' and
						(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if 		
			elseIf ld_labage > ll_adoleage then
				select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0), nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
				into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
				from fb_task 
				where TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADULT' and
						(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if 
			end if	
		end if		
		ld_wagrtn = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status1,fl_row)
		

if gs_garden_snm='MT' then		
	select PH_HOURS into :ld_prorata_hours from fb_prorata_hours where PH_DATE = trunc(:ld_dt);
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Prorat Hours ',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 100 then
		ld_prorata_hours=0
	end if
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
		
//		if gs_garden_snm='FB' and ls_emptype = 'LO' and cbx_4.checked = true then
//			ld_wages = ld_measure * ld_wagrtn
//			dw_1.setitem(fl_row,'lda_wages',ld_wages)
//		elseif gs_garden_snm='FB' and cbx_4.checked = false and ls_daily_rate = 'Y' then
//			
//			select kam.kamsub_afrate afrate into :ld_afrate from fb_kamsubhead kam
//			where trim(kam.kamsub_id) = :ls_kam_id and trunc(:ld_dt) between KAMSUB_FRDT and nvl(KAMSUB_TODT,sysdate) ;
//			
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			end if	
//			if isnull(ld_afrate) then ld_afrate = 0;			
//			ld_wages = ld_afrate
//			dw_1.setitem(fl_row,'lda_wages',ld_wages)
//			dw_1.setitem(fl_row,'lda_elp',0)
//		else
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
//		end if
end function

on w_gtelaf043.create
this.cb_10=create cb_10
this.cb_9=create cb_9
this.cb_5=create cb_5
this.cb_3=create cb_3
this.cb_1=create cb_1
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.em_1=create em_1
this.st_3=create st_3
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_4=create cb_4
this.dw_1=create dw_1
this.Control[]={this.cb_10,&
this.cb_9,&
this.cb_5,&
this.cb_3,&
this.cb_1,&
this.cb_8,&
this.cb_7,&
this.cb_6,&
this.em_1,&
this.st_3,&
this.st_2,&
this.ddlb_1,&
this.cb_2,&
this.cb_4,&
this.dw_1}
end on

on w_gtelaf043.destroy
destroy(this.cb_10)
destroy(this.cb_9)
destroy(this.cb_5)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.em_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.dw_1)
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
//rb_1.triggerevent(clicked!)

setnull(ld_dt)

ddlb_1.reset()

//ld_dt = datetime(dp_1.value)

ddlb_1.additem('ALL {00}')

setnull(ls_paybook)

ls_gsnm = gs_garden_snm

DECLARE c2 CURSOR FOR  
select initcap(LS_MANID)||' {'||lpad(to_char(ls_id),2,'0')||'}' from fb_laboursheet 
 where ls_id in (select distinct ls_id from fb_employee e where e.emp_active='1') AND 
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

//if gs_garden_state = '03' then
//	cbx_1.checked = true
////	dw_1.settaborder('lda_status',0)
//	cb_5.enabled = false
//else
//	cbx_1.checked = false
//	cb_5.enabled = true
//end if

//if gs_garden_snm = 'FB'  then
//	cbx_4.visible = true
//else
//	cbx_4.visible = false
//end if


setpointer(arrow!)

dw_1.GetChild ("lda_sectionid1", dwc_section1)
dw_1.GetChild ("lda_sectionid2", dwc_section2)
dw_1.GetChild ("lda_sectionid3", dwc_section3)
dwc_section1.settransobject(sqlca)
dwc_section2.settransobject(sqlca)
dwc_section3.settransobject(sqlca)	

//if gs_garden_snm = 'AB' or gs_garden_snm = 'SP' or gs_garden_snm = 'LP' or gs_garden_snm = 'MR'  or gs_garden_snm = 'AD' or gs_garden_snm = 'MH' or gs_garden_snm = 'DR'  then
//	cb_7.visible = true
//	cb_7.enabled = true	
//else
//	cb_7.visible = false 
//	cb_7.enabled = false		
//end if


select distinct 'X' into :ls_temp from grfdata_mr.tb_applabourattendance where DA_RPCODE=:gs_unit and nvl(DA_ISSYNCED,0)=0 and DA_WORKERCODE not like 'C%';

if sqlca.sqlcode = -1 then
	messagebox("Error occured while checking grfdata_mr.tb_applabourattendance"," Contact IT dept. Error" +sqlca.sqlerrtext );
	return 1	
elseif  sqlca.sqlcode = 0 then
	cb_3.visible = true;
else 
	cb_3.visible = false;
end if
//
end event

event key;//IF KeyDown(KeyEscape!) THEN
//	cb_4.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF1!) THEN
//	cb_1.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF2!) THEN
//	cb_2.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF3!) THEN
//	if dw_1.rowcount() > 0  then
//		cb_3.triggerevent(clicked!)
//	end if
//end if

end event

type cb_10 from commandbutton within w_gtelaf043
integer x = 914
integer y = 16
integer width = 443
integer height = 100
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Check Discrepancy"
end type

event clicked;opensheetwithparm(w_gtelar081,this.tag,w_mdi,0,layered!)
end event

type cb_9 from commandbutton within w_gtelaf043
integer x = 398
integer y = 16
integer width = 494
integer height = 100
integer taborder = 100
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Process Attendance "
end type

event clicked;	select distinct 'x' into :ls_rec from fb_mobile_attendance where nvl(lma_pst_ind,'N') = 'N';
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Employee Attendance Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 100 then
		messagebox('Warning!','There Is No Un Processed Record, Please Check !!!')
		return 1
	end if	

	IF MessageBox("Attendance Process  Alert", 'Do You Want To Process Attendance ....?' ,Exclamation!, YesNo!, 2) = 1 THEN

		setpointer(hourglass!)	
		
		//messagebox('Parameter','gs_user -'+gs_user + ' gs_garden_snm -'+gs_garden_snm+ ' gs_gstn_stcd -'+ gs_gstn_stcd)
		declare p2 procedure for up_daily_labour_Attn(:gs_user,:gs_garden_snm,:gs_gstn_stcd);
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error: During Procedure Declare of up_daily_labour_Attn',sqlca.sqlerrtext)					
			return 1
		end if

		execute p2;
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error: During Procedure Execute of up_lab_daily_attn',sqlca.sqlerrtext)
			return 1
		end if
		
		Messagebox('Information !','Attendance Process Completed !!!')
		setpointer(arrow!)	
	else
		return
	end if 

end event

type cb_5 from commandbutton within w_gtelaf043
boolean visible = false
integer x = 3954
integer y = 12
integer width = 494
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "Process Attendance "
end type

event clicked;	select distinct 'x' into :ls_rec from fb_mobile_attendance where nvl(lma_pst_ind,'N') = 'N';
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Employee Attendance Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 100 then
		messagebox('Warning!','There Is No Un Processed Record, Please Check !!!')
		return 1
	end if	

	IF MessageBox("Attendance Process  Alert", 'Do You Want To Process Attendance ....?' ,Exclamation!, YesNo!, 2) = 1 THEN

		setpointer(hourglass!)	
		
		select nvl(MAX(JOB_ID),0) into :ls_last from fb_labourdailyattendance where JOB_ID like 'JOB%';
		ls_last = right(ls_last,10)
		ll_cnt = long(ls_last)		

		setnull(ld_dt);setnull(ls_labour_id);setnull(ls_emp_name);setnull(ls_div);setnull(ls_emp_ty);setnull(ls_sex); setnull(ls_kam_id);setnull(ls_sec1);
		ld_labage=0;ld_wages=0;ll_paybook=0;ld_status=0;ld_measure = 0;
		ls_first_read = 'Y'; ll_paybook_old = 0;
		
		DECLARE c1 CURSOR FOR  
				
				select ls_id, FIELD_ID, to_date(to_char(LMA_DATE,'dd/MM/yyyy'),'dd/MM/yyyy') LMA_DATE, LMA_WORKERID, get_diff(trunc(LMA_DATE),trunc(EMP_DOB),'B') empage, emp_type, emp_sex, 
						LMA_KAMSUBHEADID, decode(LMA_COSTCENTRE4,'M',LMA_SECTIONID1,'SEC0099') section_id, LMA_NTWTT, nvl(lma_status,0)
				from fb_mobile_attendance, fb_employee a 
				where LMA_WORKERID = emp_id and nvl(lma_pst_ind,'N') = 'N' and nvl(EMP_ACTIVE,'1') = '1' and emp_type in ('LP','LT','LO') and
						 not exists (select distinct labour_id from fb_labourdailyattendance b where trunc(lda_date) = trunc(LMA_DATE) and b.labour_id = a.emp_id)
				order by LMA_DATE,LMA_KAMSUBHEADID desc ;
		
		open c1;

		IF sqlca.sqlcode = 0 THEN
			
			fetch c1 into :ll_paybook,:ls_div,:ld_dt,:ls_labour_id,:ld_labage,:ls_emp_ty,:ls_sex,:ls_kam_id,:ls_sec1,:ld_measure,:ld_status;
			
			do while sqlca.sqlcode <> 100

				if isnull(ls_sec1) or len(ls_sec1) = 0 then
					select section_id into :ls_sec1 from fb_section a, fb_employee b where a.field_id = b.field_id and emp_id = :ls_labour_id and section_name like 'O%' and section_type= 'C';
					IF sqlca.sqlcode = -1 then 
						messagebox('Error', 'Error occured while selecting section from master as section is blank in mobile attendance : '+sqlca.sqlerrtext)
						return 1
					elseif sqlca.sqlcode = 100 then
						messagebox('Warning', 'No section found for Others in section master')
						return 1
					end if
				end if
				
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

				ll_adoleage = 0 ;ll_child=0
			 
				select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0)) into :ll_adoleage, :ll_child
				from fb_param_detail 
				where pd_doc_type in ('CHILDAGE','ADOLEAGE') and trunc(:ld_dt) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));
				
				if sqlca.sqlcode = -1 then
					messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
					return 1
				end if;
				
				
				If ld_labage <= ll_child Then
					ls_cam_ind = 'CH'
				ElseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
					ls_cam_ind = 'AD'
				ElseIf ld_labage > ll_adoleage Then
					ls_cam_ind = 'AA'
				End If	
				
				ll_cnt = ll_cnt + 1
				select lpad(:ll_cnt,10,'0') into :ls_count from dual;
				ls_job_id = 'JOB'+ls_count
				
				// Checking Maternity and setting Kamkari
				
				select distinct 'x' into :ls_temp from fb_maternity	where mt_empid = :ls_labour_id and trunc(:ld_dt) between trunc(mt_fromdt) and trunc(mt_todt);
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					
					select distinct KAMSUB_ID, trim(KAMSUB_TYPE) into :ls_kam_id,:ls_kamtype from fb_kamsubhead where trim(kamsub_nkamtype)='MATERNITY' and nvl(KAMSUB_ACTIVE_IND,'N')='Y';
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
					ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,0)
					
					if isnull(ld_wages) then ; ld_wages=0; end if
					
					ls_prorata_ind = 'N'
				
					declare p2 procedure for up_lab_daily_attn( :ld_dt, :ls_labour_id,:ls_kam_id,:ld_wages,:ld_status,:ls_job_id,:ls_sec1,:ls_lwwid,0,'','','','M',:ls_prorata_ind,:gs_user);
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error: During Procedure Declare of up_lab_daily_attn MAternity',sqlca.sqlerrtext)					
						return 1
					end if

					execute p2;
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error: During Procedure Execute of up_lab_daily_attn MAternity',sqlca.sqlerrtext)
						return 1
					end if
				
				elseif sqlca.sqlcode = 100 then
					
					If ld_labage <= ll_child Then //(144 months=12 years)
				
						if gs_garden_snm = 'FB' or gs_garden_snm = 'MK' or gs_garden_snm = 'ME' or gs_garden_snm = 'KG' or gs_garden_snm = 'BE' or gs_garden_snm = 'MV' or gs_garden_snm = 'SP' then
							select distinct 'x' into :ls_temp from fb_task_fulbari 
							where TASK_EMPTYPE = :ls_emp_ty and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'CHILD' ;
							if sqlca.sqlcode = -1 then
								messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
								rollback using sqlca;
								return 1
							elseif sqlca.sqlcode = 0 then
								ls_task_ind = 'Y'
							elseif sqlca.sqlcode = 100 then
								ls_task_ind = 'N'
							end if					
						else
							select distinct 'x' into :ls_temp	from fb_task 
							where TASK_ID = :ls_kam_id and trunc(:ld_dt) between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'CHILD' ;
							if sqlca.sqlcode = -1 then
								messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
								rollback using sqlca;
								return 1
							elseif sqlca.sqlcode = 0 then
								ls_task_ind = 'Y'
							elseif sqlca.sqlcode = 100 then
								ls_task_ind = 'N'
							end if
						end if
					elseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
						if gs_garden_snm = 'FB' or gs_garden_snm = 'MK' or gs_garden_snm = 'ME' or gs_garden_snm = 'KG' or gs_garden_snm = 'BE' or gs_garden_snm = 'MV' or gs_garden_snm = 'SP' then
							select distinct 'x' into :ls_temp from fb_task_fulbari 
							where TASK_EMPTYPE = :ls_emp_ty and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADOLE' ;
							if sqlca.sqlcode = -1 then
								messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
								rollback using sqlca;
								return 1
							elseif sqlca.sqlcode = 0 then
								ls_task_ind = 'Y'
							elseif sqlca.sqlcode = 100 then
								ls_task_ind = 'N'
							end if					
						else				
							select distinct 'x' into :ls_temp	from fb_task  
							where TASK_ID = :ls_kam_id and trunc(:ld_dt)  between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'ADOLE';
							if sqlca.sqlcode = -1 then
								messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
								rollback using sqlca;
								return 1
							elseif sqlca.sqlcode = 0 then
								ls_task_ind = 'Y'
							elseif sqlca.sqlcode = 100 then	
									ls_task_ind = 'N'	
							end if 
						end if
					elseIf ld_labage > ll_adoleage then
						if gs_garden_snm = 'FB' or gs_garden_snm = 'MK' or gs_garden_snm = 'ME' or gs_garden_snm = 'KG' or gs_garden_snm = 'BE' or gs_garden_snm = 'MV' or gs_garden_snm = 'SP' then
							select distinct 'x' into :ls_temp from fb_task_fulbari 
							where TASK_EMPTYPE = :ls_emp_ty and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADULT' ;
							if sqlca.sqlcode = -1 then
								messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
								rollback using sqlca;
								return 1
							elseif sqlca.sqlcode = 0 then
								ls_task_ind = 'Y'
							elseif sqlca.sqlcode = 100 then	
									ls_task_ind = 'N'	
							end if					
					else				
						select distinct 'x' into :ls_temp	from fb_task 
						where TASK_ID = :ls_kam_id and trunc(:ld_dt)  between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'ADULT';
						if sqlca.sqlcode = -1 then
							messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
							rollback using sqlca;
							return 1
						elseif sqlca.sqlcode = 0 then
							ls_task_ind = 'Y'
						elseif sqlca.sqlcode = 100 then
							ls_task_ind = 'N'
						end if 
					end if
				end if						
				if ls_task_ind = 'Y' then	
					if gs_garden_snm = 'FB' or gs_garden_snm = 'MK' or gs_garden_snm = 'ME' or gs_garden_snm = 'KG' or gs_garden_snm = 'BE' or gs_garden_snm = 'MV' or gs_garden_snm = 'SP' then
						If ld_labage <= ll_child Then //(144 months=12 years)
								select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0) , nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
								into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
								from fb_task_fulbari 
								where TASK_EMPTYPE = :ls_emp_ty and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'CHILD' ;
								if sqlca.sqlcode = -1 then
									messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
									rollback using sqlca;
									return 1
								end if
						elseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
								select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0) , nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
								into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
								from fb_task_fulbari 
								where TASK_EMPTYPE = :ls_emp_ty and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADOLE' ;
								if sqlca.sqlcode = -1 then
									messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
									rollback using sqlca;
									return 1
								end if 		
						elseIf ld_labage > ll_adoleage then
								select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0) , nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
								into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
								from fb_task_fulbari 
								where TASK_EMPTYPE = :ls_emp_ty and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADULT'  ;
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
								where TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'CHILD';// and
								if sqlca.sqlcode = -1 then
									messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
									rollback using sqlca;
									return 1
								end if
							elseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
								select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0), nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
								into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
								from fb_task 
								where TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADOLE' ;//and
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
								if sqlca.sqlcode = -1 then
									messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
									rollback using sqlca;
									return 1
								end if 
							end if	
						end if
						ld_wagrtn = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,0)					

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
						
						ld_task = ld_rtcp1	
						
						select nvl(INC_AMTPERDAY,0) into :ld_kincentive from fb_incentive 
						where INC_REC_TYPE = 'K' and KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(trunc(INC_TODT),trunc(sysdate));
						if sqlca.sqlcode = -1 then
							messagebox('Error : While Getting Kamjari Incentive Details',sqlca.sqlerrtext)
							rollback using sqlca;
							return 1
						elseif sqlca.sqlcode = 100 then
							if gs_garden_state = '03' and ld_measure >= ld_rtcp1 then
								if ls_kam_id = 'ESUB0163' then
									ld_wages = ld_wages  + 0.6
									ld_exshwages = ld_exshwages + 0.6
								end if
							end if
						elseif sqlca.sqlcode = 0 then
							if isnull(ld_kincentive) then ld_kincentive = 0;
							ld_wages = ld_wages + ld_kincentive
						end if

					///////////////////
					else
						ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,0)
						select nvl(INC_AMTPERDAY,0) into :ld_kincentive from fb_incentive 
						where INC_REC_TYPE = 'K' and KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(trunc(INC_TODT),trunc(sysdate));
						if sqlca.sqlcode = -1 then
							messagebox('Error : While Getting Kamjari Incentive Details',sqlca.sqlerrtext)
							rollback using sqlca;
							return 1
						elseif sqlca.sqlcode = 100 then
							if gs_garden_state = '03' and ld_measure >= ld_rtcp1 then
								if ls_kam_id = 'ESUB0163' then // changed on 13012014 as per issue no C0001277
									ld_wages = ld_wages  + 0.6
									ld_exshwages = ld_exshwages + 0.6
								end if
							end if
						elseif sqlca.sqlcode = 0 then
							if isnull(ld_kincentive) then ld_kincentive = 0;
								ld_wages = ld_wages + ld_kincentive
							end if
					end if
					
					ls_prorata_ind = 'N'
									
					////////////////////////////////		covid indicator uncheck	
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
					
					////////////////////////////////
					
					//LDA_ELP
					declare p3 procedure for up_lab_daily_attn(:ld_dt,:ls_labour_id,:ls_kam_id,:ld_wages,:ld_status,:ls_job_id,:ls_sec1,:ls_lwwid,:ld_exshwages,:ls_task_ind,:ld_measure,:ld_task, 'M', :ld_prorata_hours,:gs_user);
					
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error: During Procedure Declare of up_lab_daily_attn NOrmal',sqlca.sqlerrtext)				
						return 1
					end if

					execute p3;		
					
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error: During Procedure Execute of up_lab_daily_attn NOrmal',sqlca.sqlerrtext)
						return 1
					end if
				end if
				
			// Start MES


					declare p4 procedure for up_upd_mes(to_char(:ld_dt,'dd/mm/yyyy'),:ls_kam_id,:ld_wages,'W','N');
					
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error: During Procedure Declare of up_upd_mes',sqlca.sqlerrtext)				
						return 1
					end if

					execute p4;		
					
					if sqlca.sqlcode = -1 then
						messagebox('SQL Error: During Procedure Execute of up_upd_mes',sqlca.sqlerrtext)
						return 1
					end if

			// Start Task Activity
					
					if (not isnull(ls_sec1) or len(ls_sec1) > 0) then
						declare p5 procedure for up_save_activity_daily(:ld_dt,:ls_labour_id,:ls_kam_id,:ls_sec1,:ld_status,:ld_wages,:ld_measure,'N',:ls_cam_ind,:ls_emp_ty,:ls_sex);
						if sqlca.sqlcode = -1 then
							messagebox('SQL Error: During Procedure Declare of up_save_activity_daily',sqlca.sqlerrtext)				
							return 1
						end if
						
						execute p5;
						if sqlca.sqlcode = -1 then
							messagebox('SQL Error: During Procedure Execute of up_save_activity_daily',sqlca.sqlerrtext)
							return 1
						end if
					end if
					
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
					
					update fb_mobile_attendance set LMA_PST_IND = 'Y' where  trunc(LMA_DATE) = to_date(to_char(:ld_dt,'dd/mm/yyyy'),'dd/mm/yyyy') and  LMA_WORKERID = :ls_labour_id;
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Updating Mobile Attendance Table',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
						
						
				setnull(ls_labour_id);setnull(ls_emp_name);setnull(ls_div);setnull(ls_emp_ty);setnull(ls_sex); setnull(ls_kam_id);setnull(ls_sec1);
				ld_labage=0;ld_wages=0;ll_paybook=0;ld_status=0;ld_measure = 0; ld_exshwages = 0; ld_wagrtn = 0; ld_wages = 0; ld_measure = 0; ld_task = 0;

				fetch c1 into :ll_paybook,:ls_div,:ld_dt,:ls_labour_id,:ld_labage,:ls_emp_ty,:ls_sex,:ls_kam_id,:ls_sec1,:ld_measure,:ld_status;
				
			loop
		END IF
		close c1;
			
		commit using sqlca;

		Messagebox('Information !','Attendance Process Completed !!!')
		setpointer(arrow!)	
	else
		return
	end if 

end event

type cb_3 from commandbutton within w_gtelaf043
integer x = 14
integer y = 16
integer width = 389
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Upload Mobile"
end type

event clicked;integer l_fnum
long l_flen,l_bytes_read,l_rec_len,l_count,l_fexit, l_ctr1
string l_byte,l_rec_val,ls_filename,lf_fnamed,ls_id,ls_sn,ls_sid,ls_sild, ls_oldmail
string l_field0,l_field2,l_field3,l_field4,l_field5,l_field6,l_field7,l_field8,l_field9,l_field10,l_field1
string l_field11,l_field12,l_field13,l_field14,l_field15,l_field16,l_field17,l_field18,l_field19,l_field20
string l_field21,l_field22,l_field23,l_field24,l_field25,l_field26,l_field27,l_field28,l_field29,l_field30
string l_field31,l_field32,l_field33,l_field34,l_field35,l_field36,l_field37,l_field38,l_field39,l_field40
string l_field41,l_field42,l_field43,l_field44,l_field45,l_field46
string ls_third_party,ls_cust_id,ls_inven_id
double ld_stax_per,ld_fob,ld_ldp, ld_stat
string ls_item

//date l_field1

l_count = 0; ld_stat = 0;
setpointer(HourGlass!)
dw_1.settransobject(sqlca)


if date(em_1.text) > date(today()) then
	messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
	return 1
end if

if isnull(em_1.text) or em_1.text = '00/00/0000' then
	messagebox('Warning!','Please Select A Reading Date !!!')
	return 1
end if

ls_date=em_1.text 

declare c1 cursor for
select to_char(DA_DATE,'dd/mm/yyyy') DA_DATE,'' macid,DA_WORKERCODE,DA_WORKCODE,'' da_workcodename,
		TO_CHAR(DA_TIME1, 'HH:MI:SS PM') DA_TIME1,DA_WORKZONE1,DA_COSTCENTRE1,DA_GROSSWT1,DA_TAREWT1,DA_REDUCTION1,DA_ROUNDOFF1,DA_NETWT1,DA_USERCODE1,
		TO_CHAR(DA_TIME2, 'HH:MI:SS PM') DA_TIME2,DA_WORKZONE2,DA_COSTCENTRE2,DA_GROSSWT2,DA_TAREWT2,DA_REDUCTION2,DA_ROUNDOFF2,DA_NETWT2,DA_USERCODE2,
		TO_CHAR(DA_TIME3, 'HH:MI:SS PM') DA_TIME3,DA_WORKZONE3,DA_COSTCENTRE3,DA_GROSSWT3,DA_TAREWT3,DA_REDUCTION3,DA_ROUNDOFF3,DA_NETWT3,DA_USERCODE3,
		TO_CHAR(DA_TIME4, 'HH:MI:SS PM') DA_TIME4,DA_WORKZONE4,DA_COSTCENTRE4,DA_GROSSWT4,DA_TAREWT4,DA_REDUCTION4,DA_ROUNDOFF4,DA_NETWT4,DA_USERCODE4,
		DA_TOTALGROSSWT,DA_TOTALTAREWT,DA_TOTALREDUCTION,DA_TOTALROUNDOFF,DA_TOTALNETWT 
from grfdata_mr.tb_applabourattendance where DA_RPCODE=:gs_unit and nvl(DA_ISSYNCED,0)=0 
and DA_WORKERCODE not like 'C%' ; 
open(w_import_rows_information)
close c1;
open c1; 
if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 
	setnull(l_field1 ); setnull(l_field2);setnull(l_field3);setnull(l_field4);setnull(l_field5);
	setnull(l_field6);setnull(l_field7);setnull(l_field8);setnull(l_field9);setnull(l_field10);setnull(l_field11);setnull(l_field12);setnull(l_field13);setnull(l_field14);
	setnull(l_field15);setnull(l_field16);setnull(l_field17);setnull(l_field18);setnull(l_field19);setnull(l_field20);setnull(l_field21);setnull(l_field22);setnull(l_field23);
	setnull(l_field24);setnull(l_field25);setnull(l_field26);setnull(l_field27);setnull(l_field28);setnull(l_field29);setnull(l_field30);setnull(l_field31);setnull(l_field32);
	setnull(l_field33);setnull(l_field34);setnull(l_field35);setnull(l_field36);setnull(l_field37);setnull(l_field38);setnull(l_field39);setnull(l_field40);setnull(l_field41);
	setnull(l_field42);setnull(l_field43);setnull(l_field44);setnull(l_field45);setnull(l_field46);

	fetch c1 into :l_field1,:l_field2,:l_field3,:l_field4,:l_field5,:l_field6,:l_field7,:l_field8,:l_field9,:l_field10,:l_field11,:l_field12,:l_field13,:l_field14,	:l_field15,:l_field16,:l_field17,:l_field18,:l_field19,:l_field20,:l_field21,:l_field22,:l_field23,:l_field24,:l_field25,:l_field26,:l_field27,:l_field28,:l_field29,:l_field30,:l_field31,:l_field32,:l_field33,:l_field34,:l_field35,:l_field36,:l_field37,:l_field38,:l_field39,:l_field40,:l_field41,:l_field42,:l_field43,:l_field44,:l_field45,:l_field46;

	do while sqlca.sqlcode <> 100        
		
		if len(l_field1) > 0 and len(l_field4) > 0 then
				
				if gs_loginuser = 'msote' then
					l_field3 = trim(l_field3)
					l_field3 = left(l_field3,len(l_field3) - 1)
				end if
				ll_noofpunching=0;
				select kamsub_id,pm_noofpunching,pm_timegap,pm_timegap2,pm_timegap3 into :ls_kamsub,:ll_noofpunching,:ll_timegap,:ll_timegap2,:ll_timegap3 
				from fb_punchingmaster where kamsub_id = trim(:l_field4) and  pm_todt is null and to_date(:l_field1,'dd/mm/yyyy') >= pm_frdt ;  
				if sqlca.sqlcode = 100 then
					select kamsub_id,pm_noofpunching,pm_timegap,pm_timegap2,pm_timegap3 into :ls_kamsub,:ll_noofpunching,:ll_timegap,:ll_timegap2,:ll_timegap3 
					from fb_punchingmaster where kamsub_id = trim(:l_field4) and to_date(:l_field1,'dd/mm/yyyy') between pm_frdt and pm_todt;
					if sqlca.sqlcode = -1 then
						messagebox("Error occured while checking punching master 1",sqlca.sqlerrtext + " :l_field4 -" + l_field4 + " :l_field1 -" +  l_field1)
						rollback using sqlca;
						close(w_import_rows_information)
						fileclose(l_fnum)
						return 1	
					end if
				elseif sqlca.sqlcode = -1 then
					messagebox("Error occured while checking punching master 2",sqlca.sqlerrtext + " :l_field4 -" + l_field4 + " :l_field1 -" +  l_field1)
					rollback using sqlca;
					close(w_import_rows_information)
					fileclose(l_fnum)
					return 1	
				end if
				if  ll_noofpunching = 4   then 
					if ((len(l_field6) > 0) and (len(l_field15) > 0)  and (len(l_field24) > 0) and (len(l_field33) > 0))  then
						if (secondsafter(time(l_field6),time(l_field15)) + 600 >= ll_timegap*60) and (secondsafter(time(l_field15),time(l_field24)) +600 >= ll_timegap2*60) and (secondsafter(time(l_field24),time(l_field33)) +600 >= ll_timegap3*60) then
							ld_stat = 1	
						else
							ld_stat = 0.5
						end if																
					elseif ((len(l_field6) > 0) or len(l_field15) > 0 or (len(l_field24) > 0) or (len(l_field33) > 0)) then
						ld_stat = 0.5
					else
						ld_stat = 0
					end if
				 elseif  ll_noofpunching = 3   then
					if ((len(l_field6) > 0) and (len(l_field15) > 0)  and (len(l_field24) > 0))  then
						if secondsafter(time(l_field6),time(l_field15)) + 600 >= ll_timegap*60 and secondsafter(time(l_field15),time(l_field24)) + 600 >= ll_timegap2*60 then
							ld_stat = 1	
						else
							ld_stat = 0.5
						end if																
					elseif ((len(l_field6) > 0) or (len(l_field15) > 0) or (len(l_field24) > 0)) then
						ld_stat = 0.5
					else
						ld_stat = 0
					end if
				elseif  ll_noofpunching = 2 then
					if ((len(l_field6) > 0) and (len(l_field15) > 0)) and (secondsafter(time(l_field6),time(l_field15)) + 600 >= ll_timegap*60)  then
						ld_stat = 1
					elseif ((len(l_field6) > 0) and (len(l_field24) > 0))  and (secondsafter(time(l_field6),time(l_field24)) + 600 >= ll_timegap*60)  then  //(not isnull(l_field6) and not isnull(l_field24))  then
						ld_stat = 1
					elseif ((len(l_field15) > 0) and (len(l_field24) > 0))  and (secondsafter(time(l_field15),time(l_field24)) + 600 >= ll_timegap*60)  then //elseif (not isnull(l_field15) and not isnull(l_field24)) then
						ld_stat = 1
					elseif ((len(l_field6) > 0) or (len(l_field15) > 0 or len(l_field24) > 0)) then
						ld_stat = 0.5
					end if
				else
					if ((len(l_field6) > 0) and (len(l_field15) > 0))  then
						ld_stat = 1
					elseif ((len(l_field6) > 0) and (len(l_field24) > 0))  then  //(not isnull(l_field6) and not isnull(l_field24))  then
						ld_stat = 1
					elseif ((len(l_field15) > 0) and (len(l_field24) > 0))  then //elseif (not isnull(l_field15) and not isnull(l_field24)) then
						ld_stat = 1
					elseif ((len(l_field6) > 0) or (len(l_field15) > 0) or (len(l_field24) > 0)) then
						ld_stat = 0.5
					end if
				end if	
				
				declare p2 procedure for up_import_mobile_attn( to_date(:l_field1,'dd/mm/yyyy'), :l_field3,:gs_unit ,:ld_stat);
				
				if sqlca.sqlcode = -1 then
					messagebox('SQL Error: During Procedure Declare of up_import_mobile_attn',sqlca.sqlerrtext)
				
					return 1
				end if

				execute p2;		
				
				if sqlca.sqlcode = -1 then
					messagebox('SQL Error: During Procedure Execute of up_import_mobile_attn',sqlca.sqlerrtext)
					return 1
				end if
				
		end if
		l_bytes_read = fileread(l_fnum,l_byte)
		l_count = l_count + 1
		w_import_rows_information.sle_1.text= string(l_count) 	
	
		setnull(l_field1 ); setnull(l_field2);setnull(l_field3);setnull(l_field4);setnull(l_field5);
		setnull(l_field6);setnull(l_field7);setnull(l_field8);setnull(l_field9);setnull(l_field10);setnull(l_field11);setnull(l_field12);setnull(l_field13);setnull(l_field14);
		setnull(l_field15);setnull(l_field16);setnull(l_field17);setnull(l_field18);setnull(l_field19);setnull(l_field20);setnull(l_field21);setnull(l_field22);setnull(l_field23);
		setnull(l_field24);setnull(l_field25);setnull(l_field26);setnull(l_field27);setnull(l_field28);setnull(l_field29);setnull(l_field30);setnull(l_field31);setnull(l_field32);
		setnull(l_field33);setnull(l_field34);setnull(l_field35);setnull(l_field36);setnull(l_field37);setnull(l_field38);setnull(l_field39);setnull(l_field40);setnull(l_field41);
		setnull(l_field42);setnull(l_field43);setnull(l_field44);setnull(l_field45);setnull(l_field46);
		
		fetch c1 into :l_field1,:l_field2,:l_field3,:l_field4,:l_field5,:l_field6,:l_field7,:l_field8,:l_field9,:l_field10,:l_field11,:l_field12,:l_field13,:l_field14,	:l_field15,:l_field16,:l_field17,:l_field18,:l_field19,:l_field20,:l_field21,:l_field22,:l_field23,:l_field24,:l_field25,:l_field26,:l_field27,:l_field28,:l_field29,:l_field30,:l_field31,:l_field32,:l_field33,:l_field34,:l_field35,:l_field36,:l_field37,:l_field38,:l_field39,:l_field40,:l_field41,:l_field42,:l_field43,:l_field44,:l_field45,:l_field46;

		loop;	 


end if;
close(w_import_rows_information)


messagebox('Success','Data Imported -'+ string(l_count) 	)

return 1

end event

type cb_1 from commandbutton within w_gtelaf043
boolean visible = false
integer x = 14
integer y = 16
integer width = 389
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "Import Mobile"
end type

event clicked;integer l_fnum
long l_flen,l_bytes_read,l_rec_len,l_count,l_fexit, l_ctr1
string l_byte,l_rec_val,ls_filename,lf_fnamed,ls_id,ls_sn,ls_sid,ls_sild, ls_oldmail
string l_field0,l_field1,l_field2,l_field3,l_field4,l_field5,l_field6,l_field7,l_field8,l_field9,l_field10
string l_field11,l_field12,l_field13,l_field14,l_field15,l_field16,l_field17,l_field18,l_field19,l_field20
string l_field21,l_field22,l_field23,l_field24,l_field25,l_field26,l_field27,l_field28,l_field29,l_field30
string l_field31,l_field32,l_field33,l_field34,l_field35,l_field36,l_field37,l_field38,l_field39,l_field40
string l_field41,l_field42,l_field43,l_field44,l_field45,l_field46
string ls_third_party,ls_cust_id,ls_inven_id
double ld_stax_per,ld_fob,ld_ldp, ld_stat
string ls_item
l_count = 0; ld_stat = 0;
l_fexit = GetFileOpenName("Select The Attendance TXT File", &
		+ ls_filename, lf_fnamed, "TXT", &
		+ "TXT Files (*.TXT),*.TXT")

lf_fnamed = upper(left(lf_fnamed,len(lf_fnamed) - 4))

setpointer(HourGlass!)
dw_1.settransobject(sqlca)

IF l_fexit = 1 THEN 	
	open(w_import_rows_information)
	l_flen = filelength(ls_filename)
	l_fnum = fileopen(ls_filename)
	l_bytes_read = fileread(l_fnum,l_byte)
	do while l_bytes_read <> -100
			l_rec_val = l_byte
			l_rec_len = len(l_rec_val)
			l_rec_val = right(l_rec_val,l_rec_len)
			l_field1   = f_get_string_position(l_rec_val,"~~")
			l_field2   = f_get_string_position(l_rec_val,"~~")
			l_field3   = f_get_string_position(l_rec_val,"~~")
			l_field4   = f_get_string_position(l_rec_val,"~~")
			l_field5   = f_get_string_position(l_rec_val,"~~")
			l_field6   = f_get_string_position(l_rec_val,"~~")
			l_field7   = f_get_string_position(l_rec_val,"~~")
			l_field8   = f_get_string_position(l_rec_val,"~~")
			l_field9   = f_get_string_position(l_rec_val,"~~")
			l_field10  = f_get_string_position(l_rec_val,"~~")
			l_field11  = f_get_string_position(l_rec_val,"~~")
			l_field12  = f_get_string_position(l_rec_val,"~~")
			l_field13  = f_get_string_position(l_rec_val,"~~")
			l_field14  = f_get_string_position(l_rec_val,"~~")
			l_field15  = f_get_string_position(l_rec_val,"~~")
			l_field16  = f_get_string_position(l_rec_val,"~~")
			l_field17  = f_get_string_position(l_rec_val,"~~")
			l_field18  = f_get_string_position(l_rec_val,"~~")
			l_field19  = f_get_string_position(l_rec_val,"~~")
			l_field20  = f_get_string_position(l_rec_val,"~~")
			l_field21  = f_get_string_position(l_rec_val,"~~")
			l_field22  = f_get_string_position(l_rec_val,"~~")
			l_field23  = f_get_string_position(l_rec_val,"~~")
			l_field24  = f_get_string_position(l_rec_val,"~~")
			l_field25  = f_get_string_position(l_rec_val,"~~")
			l_field26  = f_get_string_position(l_rec_val,"~~")
			l_field27  = f_get_string_position(l_rec_val,"~~")
			l_field28  = f_get_string_position(l_rec_val,"~~")
			l_field29  = f_get_string_position(l_rec_val,"~~")
			l_field30  = f_get_string_position(l_rec_val,"~~")
			l_field31  = f_get_string_position(l_rec_val,"~~")
			l_field32  = f_get_string_position(l_rec_val,"~~")
			l_field33  = f_get_string_position(l_rec_val,"~~")
			l_field34  = f_get_string_position(l_rec_val,"~~")
			l_field35  = f_get_string_position(l_rec_val,"~~")
			l_field36  = f_get_string_position(l_rec_val,"~~")
			l_field37  = f_get_string_position(l_rec_val,"~~")
			l_field38  = f_get_string_position(l_rec_val,"~~")
			l_field39  = f_get_string_position(l_rec_val,"~~")
			l_field40  = f_get_string_position(l_rec_val,"~~")
			l_field41  = f_get_string_position(l_rec_val,"~~")
			l_field42  = f_get_string_position(l_rec_val,"~~")
			l_field43  = f_get_string_position(l_rec_val,"~~")
			l_field44  = f_get_string_position(l_rec_val,"~~")
			l_field45  = f_get_string_position(l_rec_val,"~~")
			l_field46  = f_get_string_position(l_rec_val,"~~")

			if len(l_field1) > 0 and len(l_field4) > 0 then
				
				if gs_loginuser = 'msote' then
					l_field3 = trim(l_field3)
					l_field3 = left(l_field3,len(l_field3) - 1)
				end if
				
				sqlca.dbparm = "procedureintransaction=1"
				
				
				select 'X' into :ls_temp from fb_employee where emp_id =  ltrim(rtrim(:l_field3)) and emp_active = '1'  and emp_inactivetype = 'Regular';
				if sqlca.sqlcode = -1 then
					messagebox('Error occured while checking employee master',sqlca.sqlerrtext)
					rollback using sqlca;
					close(w_import_rows_information)
					fileclose(l_fnum)
					sqlca.dbparm="procedureintransaction=0"
					return 1	
				elseif sqlca.sqlcode = 0 then
					select distinct ltrim(rtrim(:l_field3)) into :ls_temp from fb_mobile_attendance where LMA_DATE = to_date(:l_field1,'dd/mm/yyyy') and LMA_WORKERID = ltrim(rtrim(:l_field3));
					if sqlca.sqlcode = 0 then
						messagebox("Warning",'Record Already Present For Worker :' +l_field3+' On Date : '+l_field1+',  Please Check')
						rollback using sqlca;
						close(w_import_rows_information)
						fileclose(l_fnum)
						return 1	
	//					update fb_mobile_attendance set LMA_STATUS = 1, LMA_NTWTT = LMA_NTWTT + to_number(:l_field46)
	//					where LMA_DATE = to_date(:l_field1,'dd/mm/yyyy') and LMA_WORKERID = ltrim(rtrim(:l_field3)) and LMA_KAMSUBHEADID = ltrim(rtrim(:l_field4));
	//					if sqlca.sqlcode = -1 then
	//						messagebox("SQL Error : During Updating Worker Details !!!",SQLCA.SQLErrtext,Information!)
	//						rollback using sqlca;
	//						close(w_import_rows_information)
	//						fileclose(l_fnum)
	//						return 1
	//					end if				
					elseif sqlca.sqlcode =100 then
						ld_stat = 0;
						setnull(ls_kamsub);ll_noofpunching = 0; ll_timegap = 0;
						select kamsub_id,pm_noofpunching,pm_timegap,pm_timegap2,pm_timegap3 into :ls_kamsub,:ll_noofpunching,:ll_timegap,:ll_timegap2,:ll_timegap3 from 
						fb_punchingmaster where kamsub_id = trim(:l_field4) and  pm_todt is null and to_date(:l_field1,'dd/mm/yyyy') >= pm_frdt ;  
						if sqlca.sqlcode = 100 then
							select kamsub_id,pm_noofpunching,pm_timegap,pm_timegap2,pm_timegap3 into :ls_kamsub,:ll_noofpunching,:ll_timegap,:ll_timegap2,:ll_timegap3 from 
							fb_punchingmaster where kamsub_id = trim(:l_field4) and to_date(:l_field1,'dd/mm/yyyy') between pm_frdt and pm_todt;
							if sqlca.sqlcode = -1 then
								messagebox("Error occured while checking punching master 1",sqlca.sqlerrtext)
								rollback using sqlca;
								close(w_import_rows_information)
								fileclose(l_fnum)
								return 1	
							end if
						elseif sqlca.sqlcode = -1 then
							messagebox("Error occured while checking punching master 2",sqlca.sqlerrtext)
							rollback using sqlca;
							close(w_import_rows_information)
							fileclose(l_fnum)
							return 1	
						end if
						if  ll_noofpunching = 4   then 
							if (len(l_field6) > 0 and len(l_field15) > 0  and len(l_field24) > 0 and len(l_field33) > 0)  then
								if secondsafter(time(l_field6),time(l_field15)) >= ll_timegap*60 and secondsafter(time(l_field15),time(l_field24)) >= ll_timegap2*60 and secondsafter(time(l_field24),time(l_field33)) >= ll_timegap3*60 then
									ld_stat = 1	
								else
									ld_stat = 0.5
								end if																
							elseif (len(l_field6) > 0 or len(l_field15) > 0 or len(l_field24) > 0 or len(l_field33) > 0) then
								ld_stat = 0.5
							else
								ld_stat = 0
							end if
						elseif  ll_noofpunching = 3   then
							if (len(l_field6) > 0 and len(l_field15) > 0  and len(l_field24) > 0)  then
								if secondsafter(time(l_field6),time(l_field15)) >= ll_timegap*60 and secondsafter(time(l_field15),time(l_field24)) >= ll_timegap2*60 then
									ld_stat = 1	
								else
									ld_stat = 0.5
								end if																
							elseif (len(l_field6) > 0 or len(l_field15) > 0 or len(l_field24) > 0) then
								ld_stat = 0.5
							else
								ld_stat = 0
							end if
						elseif  ll_noofpunching = 2 then
							if (len(l_field6) > 0 and len(l_field15) > 0) and secondsafter(time(l_field6),time(l_field15)) >= ll_timegap*60  then
								ld_stat = 1
							elseif (len(l_field6) > 0 and len(l_field24) > 0)  and secondsafter(time(l_field6),time(l_field24)) >= ll_timegap*60  then  //(not isnull(l_field6) and not isnull(l_field24))  then
								ld_stat = 1
							elseif (len(l_field15) > 0 and len(l_field24) > 0)  and secondsafter(time(l_field15),time(l_field24)) >= ll_timegap*60  then //elseif (not isnull(l_field15) and not isnull(l_field24)) then
								ld_stat = 1
							elseif (len(l_field6) > 0 or len(l_field15) > 0 or len(l_field24) > 0) then
								ld_stat = 0.5
							end if
						else
							if (len(l_field6) > 0 and len(l_field15) > 0)  then
								ld_stat = 1
							elseif (len(l_field6) > 0 and len(l_field24) > 0)  then  //(not isnull(l_field6) and not isnull(l_field24))  then
								ld_stat = 1
							elseif (len(l_field15) > 0 and len(l_field24) > 0)  then //elseif (not isnull(l_field15) and not isnull(l_field24)) then
								ld_stat = 1
							elseif (len(l_field6) > 0 or len(l_field15) > 0 or len(l_field24) > 0) then
								ld_stat = 0.5
							end if
						end if

						
						insert into fb_mobile_attendance (LMA_DATE, LMA_MACNO, LMA_WORKERID, LMA_KAMSUBHEADID, LMA_KAMSUBNAM, 
																LMA_TIME1, LMA_SECTIONID1, LMA_COSTCENTRE1, LMA_GRWT1, LMA_TRWT1, LMA_RDWT1, LMA_RDOFF, LMA_NTWT1, LMA_USRCD1, 
																LMA_TIME2, LMA_SECTIONID2, LMA_COSTCENTRE2, LMA_GRWT2, LMA_TRWT2, LMA_RDWT2, LMA_RDOF2, LMA_NTWT2, LMA_USRCD2, 
																LMA_TIME3, LMA_SECTIONID3, LMA_COSTCENTRE3, LMA_GRWT3, LMA_TRWT3, LMA_RDWT3, LMA_RDOF3, LMA_NTWT3, LMA_USRCD3, 
																LMA_TIME4, LMA_SECTIONID4, LMA_COSTCENTRE4, LMA_GRWT4, LMA_TRWT4, LMA_RDWT4, LMA_RDOF4, LMA_NTWT4, LMA_USRCD4, 
																LMA_GRWTT, LMA_TRWTT, LMA_RDWTT, LMA_RDOFT, LMA_NTWTT,LMA_STATUS)
						values (to_date(:l_field1,'dd/mm/yyyy'),ltrim(rtrim(:l_field2)),ltrim(rtrim(:l_field3)),ltrim(rtrim(:l_field4)),ltrim(rtrim(:l_field5)),
								  ltrim(rtrim(:l_field6)),ltrim(rtrim(:l_field7)), trim(:l_field8),to_number(:l_field9),to_number(:l_field10),to_number(:l_field11),to_number(:l_field12),to_number(:l_field13),ltrim(rtrim(:l_field14)),
								  ltrim(rtrim(:l_field15)),ltrim(rtrim(:l_field16)), trim(:l_field17),to_number(:l_field18),to_number(:l_field19),to_number(:l_field20),to_number(:l_field21),to_number(:l_field22),ltrim(rtrim(:l_field23)),
								  ltrim(rtrim(:l_field24)),ltrim(rtrim(:l_field25)), trim(:l_field26),to_number(:l_field27),to_number(:l_field28),to_number(:l_field29),to_number(:l_field30),to_number(:l_field31),ltrim(rtrim(:l_field32)),
								  ltrim(rtrim(:l_field33)),ltrim(rtrim(:l_field34)), 'M',to_number(:l_field36),to_number(:l_field37),to_number(:l_field38),to_number(:l_field39),to_number(:l_field40),ltrim(rtrim(:l_field41)),
								  to_number(:l_field42),to_number(:l_field43),to_number(:l_field44),to_number(:l_field45),to_number(:l_field46),:ld_stat);
		
						if sqlca.sqlcode = -1 then
							messagebox("SQL Error : During Insert Worker Details !!!"+l_field3,SQLCA.SQLErrtext,Information!)
							rollback using sqlca;
							close(w_import_rows_information)
							fileclose(l_fnum)
							sqlca.dbparm="procedureintransaction=0"
							return 1
						end if
					end if
				end if
			end if		
		
			l_bytes_read = fileread(l_fnum,l_byte)
			l_count = l_count + 1
			w_import_rows_information.sle_1.text= string(l_count) 
			//messagebox('Count',l_count)
	loop
	commit using sqlca;
	fileclose(l_fnum)
	close(w_import_rows_information)
	setpointer(arrow!) 
	messagebox("Import File Information",'Total ' + string(l_count) + ' Rows Imported.....')
	sqlca.dbparm="procedureintransaction=0"
else
	setpointer(arrow!) 
	messagebox("file","File Does Not Exists -> " + ls_filename)
end if

return 1

end event

type cb_8 from commandbutton within w_gtelaf043
boolean visible = false
integer x = 398
integer y = 16
integer width = 494
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "Process Attendance "
end type

event clicked;//
//if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
//	messagebox('Warning!','Please Select A Pay Book No. Or "ALL {00}" !!!')
//	return 1
//end if
//
//
//ll_paybook = long(left(right(ddlb_1.text,3),2))

select distinct 'x' into :ls_rec from fb_mobile_attendance where nvl(lma_pst_ind,'N') = 'N';
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Employee Attendance Details',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning!','There Is No Un Processed Record, Please Check !!!')
	return 1
end if	

IF MessageBox("Attendance Process  Alert", 'Do You Want To Process Attendance ....?' ,Exclamation!, YesNo!, 2) = 1 THEN

	setpointer(hourglass!)	
	n_fames luo_fames
	luo_fames = Create n_fames

	
	select nvl(MAX(JOB_ID),0) into :ls_last from fb_labourdailyattendance where JOB_ID like 'JOB%';
	ls_last = right(ls_last,10)
	ll_cnt = long(ls_last)
	
		
	setnull(ld_dt);setnull(ls_labour_id);setnull(ls_emp_name);setnull(ls_div);setnull(ls_emp_ty);setnull(ls_sex); setnull(ls_kam_id);setnull(ls_sec1);
	ld_labage=0;ld_wages=0;ll_paybook=0;ld_status=0;ld_measure = 0;
	ls_first_read = 'Y'; ll_paybook_old = 0;
	
	DECLARE c1 CURSOR FOR  
	select ls_id, FIELD_ID, LMA_DATE, LMA_WORKERID, ((trunc(LMA_DATE) - emp_dob) /365) empage, emp_type, emp_sex, 
			LMA_KAMSUBHEADID, decode(LMA_COSTCENTRE4,'M',LMA_SECTIONID1,'SEC0099') section_id, LMA_NTWTT, nvl(lma_status,0)
	from fb_mobile_attendance, fb_employee a 
	where LMA_WORKERID = emp_id and nvl(lma_pst_ind,'N') = 'N' and nvl(EMP_ACTIVE,'1') = '1' and emp_type in ('LP','LT','LO') and
			 not exists (select distinct labour_id from fb_labourdailyattendance b where trunc(lda_date) = trunc(LMA_DATE) and b.labour_id = a.emp_id)
	order by LMA_DATE,LMA_KAMSUBHEADID desc ;
	
	open c1;
	
	IF sqlca.sqlcode = 0 THEN
		fetch c1 into :ll_paybook,:ls_div,:ld_dt,:ls_labour_id,:ld_labage,:ls_emp_ty,:ls_sex,:ls_kam_id,:ls_sec1,:ld_measure,:ld_status;
		
		do while sqlca.sqlcode <> 100
			
			if isnull(ls_sec1) or len(ls_sec1) = 0 then
				select section_id into :ls_sec1 from fb_section a, fb_employee b where a.field_id = b.field_id and emp_id = :ls_labour_id and section_name like 'O%' and section_type= 'C';
				IF sqlca.sqlcode = -1 then 
					messagebox('Error', 'Error occured while selecting section from master as section is blank in mobile attendance : '+sqlca.sqlerrtext)
					return 1
				elseif sqlca.sqlcode = 100 then
					messagebox('Warning', 'No section found for Others in section master')
					return 1
				end if
			end if
			

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
			
			ll_adoleage = 0 ;ll_child=0
		 
			select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0)) into :ll_adoleage, :ll_child
			from fb_param_detail 
			where pd_doc_type in ('CHILDAGE','ADOLEAGE') and trunc(:ld_dt) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));
			
			if sqlca.sqlcode = -1 then
				messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
				return 1
			end if;
			
			
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
			ls_job_id = 'JOB'+ls_count
			
			// Checking Maternity and setting Kamkari
			
			select distinct 'x' into :ls_temp from fb_maternity	where mt_empid = :ls_labour_id and trunc(:ld_dt) between trunc(mt_fromdt) and trunc(mt_todt);
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 0 then
				
				select distinct KAMSUB_ID, trim(KAMSUB_TYPE) into :ls_kam_id,:ls_kamtype from fb_kamsubhead where trim(kamsub_nkamtype)='MATERNITY' and nvl(KAMSUB_ACTIVE_IND,'N')='Y';
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if

//				select section_id into :ls_sec1 from fb_section
//				where substr(SECTION_NAME,1,1)||'KAM' = :ls_kamtype and FIELD_ID=decode(:ls_kamtype,'FKAM','NA',:ls_div) and 
//						( ((:ls_kamtype <> 'OKAM' and :ls_kamtype <> 'NKAM')) or ((:ls_kamtype = 'OKAM' or :ls_kamtype = 'NKAM') and section_type= 'C') );
//				
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting Section From Section Master',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				end if		
				
				//ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,1,0)
				ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,0)
				
				if isnull(ld_wages) then ; ld_wages=0; end if
				
				if gs_garden_snm='MT' then		
					select PH_HOURS into :ld_prorata_hours from fb_prorata_hours where PH_DATE = trunc(:ld_dt);
					
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting Prorat Hours ',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					elseif sqlca.sqlcode = 100 then
						ld_prorata_hours = 0
					end if
					
					if ld_prorata_hours > 0 then
						ls_prorata_ind = 'Y'
					else
						ls_prorata_ind = 'N'
					end if
				else
					ls_prorata_ind = 'N'
				end if
				
				insert into fb_labourdailyattendance(LDA_DATE, LABOUR_ID, KAMSUB_ID, LDA_WAGES, LDA_STATUS, JOB_ID, 
																lda_sectionid1,LWW_ID, LDA_ELP, LDA_LATTA, lda_prorataind, LDA_ENTRY_BY, LDA_ENTRY_DT)
				values(:ld_dt,:ls_labour_id,:ls_kam_id,:ld_wages,:ld_status,:ls_job_id,:ls_sec1,:ls_lwwid,0,'M',:ls_prorata_ind,:gs_user,sysdate);
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Data Into Attendance Table : ',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				
			elseif sqlca.sqlcode = 100 then
				
			If ld_labage <= ll_child Then //(144 months=12 years)
			
				if gs_garden_snm = 'FB' or gs_garden_snm = 'MK' or gs_garden_snm = 'ME' or gs_garden_snm = 'KG' or gs_garden_snm = 'BE' or gs_garden_snm = 'MV' or gs_garden_snm = 'SP' then
					
					select distinct 'x' into :ls_temp
					from fb_task_fulbari 
					where TASK_EMPTYPE = :ls_emp_ty and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'CHILD' ;
					
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					elseif sqlca.sqlcode = 0 then
						ls_task_ind = 'Y'
					elseif sqlca.sqlcode = 100 then
						ls_task_ind = 'N'
					end if					
				else
					select distinct 'x' into :ls_temp	from fb_task 
					where TASK_ID = :ls_kam_id and trunc(:ld_dt) between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'CHILD' ;
					//and	(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N')));
					
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					elseif sqlca.sqlcode = 0 then
						ls_task_ind = 'Y'
					elseif sqlca.sqlcode = 100 then
						ls_task_ind = 'N'
					end if
				end if
			elseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
				if gs_garden_snm = 'FB' or gs_garden_snm = 'MK' or gs_garden_snm = 'ME' or gs_garden_snm = 'KG' or gs_garden_snm = 'BE' or gs_garden_snm = 'MV' or gs_garden_snm = 'SP' then
					
					select distinct 'x' into :ls_temp
					from fb_task_fulbari 
					where TASK_EMPTYPE = :ls_emp_ty and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADOLE' ;
					
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					elseif sqlca.sqlcode = 0 then
						ls_task_ind = 'Y'
					elseif sqlca.sqlcode = 100 then
						ls_task_ind = 'N'
					end if					
				else				
					select distinct 'x' into :ls_temp	from fb_task  
					where TASK_ID = :ls_kam_id and trunc(:ld_dt)  between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'ADOLE';
					//and (:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
					
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					elseif sqlca.sqlcode = 0 then
						ls_task_ind = 'Y'
					elseif sqlca.sqlcode = 100 then
//						if messagebox('Warning !!! :',' Task Not Defined For This Date, Want To Continue? ', Exclamation!, YesNo!, 1) = 2 then
//							return
//						else
							ls_task_ind = 'N'
//						end if
					end if 
				end if
			elseIf ld_labage > ll_adoleage then
				if gs_garden_snm = 'FB' or gs_garden_snm = 'MK' or gs_garden_snm = 'ME' or gs_garden_snm = 'KG' or gs_garden_snm = 'BE' or gs_garden_snm = 'MV' or gs_garden_snm = 'SP' then
					
					select distinct 'x' into :ls_temp
					from fb_task_fulbari 
					where TASK_EMPTYPE = :ls_emp_ty and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADULT' ;
					
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					elseif sqlca.sqlcode = 0 then
						ls_task_ind = 'Y'
					elseif sqlca.sqlcode = 100 then
//						if messagebox('Warning !!! :',' Task Not Defined For This Date, Want To Continue? ', Exclamation!, YesNo!, 1) = 2 then
//							return
//						else
							ls_task_ind = 'N'
//						end if
					end if					
				else				
					select distinct 'x' into :ls_temp	from fb_task 
					where TASK_ID = :ls_kam_id and trunc(:ld_dt)  between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'ADULT';
	//				and (:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
							
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					elseif sqlca.sqlcode = 0 then
						ls_task_ind = 'Y'
					elseif sqlca.sqlcode = 100 then
//						if messagebox('Warning !!! :',' Task Not Defined For This Date, Want To Continue? ', Exclamation!, YesNo!, 1) = 2 then
//							return
//						else
							ls_task_ind = 'N'
//						end if
					end if 
				end if
			end if						
				
//				select distinct KAMSUB_ID, trim(KAMSUB_TYPE) into :ls_kam_id,:ls_kamtype from fb_kamsubhead where trim(kamsub_nkamtype)='ABSENT';
//				
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				end if
//				
//				select section_id into :ls_sec1 from fb_section where substr(SECTION_NAME,1,1)||'KAM' = :ls_kamtype and FIELD_ID= :ls_div;
//				
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting Section From Section Master',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				end if		

//				select section_id into :ls_sec1 from fb_section
//				where substr(SECTION_NAME,1,1)||'KAM' = :ls_kamtype and FIELD_ID=decode(:ls_kamtype,'FKAM','NA',:ls_div) and 
//						( ((:ls_kamtype <> 'OKAM' and :ls_kamtype <> 'NKAM')) or ((:ls_kamtype = 'OKAM' or :ls_kamtype = 'NKAM') and section_type= 'C') );
//				
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting Section From Section Master',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				end if		

				//ld_wages=0
				if ls_task_ind = 'Y' then
//					If ld_labage <= ll_child Then //(144 months=12 years)
//			
//						select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0), nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
//						into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
//						from fb_task 
//						where TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'CHILD' and
//								(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N')));
//								
//						if sqlca.sqlcode = -1 then
//							messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
//							rollback using sqlca;
//							return 1
//						end if
//					elseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
//						select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0), nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
//						into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
//						from fb_task 
//						where TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADOLE' and
//								(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
//						if sqlca.sqlcode = -1 then
//							messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
//							rollback using sqlca;
//							return 1
//						end if 		
//					elseIf ld_labage > ll_adoleage then
//						select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0), nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
//						into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
//						from fb_task 
//						where TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADULT' and
//								(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
//						if sqlca.sqlcode = -1 then
//							messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
//							rollback using sqlca;
//							return 1
//						end if 
//					end if	
					if gs_garden_snm = 'FB' or gs_garden_snm = 'MK' or gs_garden_snm = 'ME' or gs_garden_snm = 'KG' or gs_garden_snm = 'BE' or gs_garden_snm = 'MV' or gs_garden_snm = 'SP' then
						If ld_labage <= ll_child Then //(144 months=12 years)
				
							select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0) , nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
							into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
							from fb_task_fulbari 
							where TASK_EMPTYPE = :ls_emp_ty and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'CHILD' ;
									
							if sqlca.sqlcode = -1 then
								messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
								rollback using sqlca;
								return 1
							end if
						elseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
							select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0) , nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
							into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
							from fb_task_fulbari 
							where TASK_EMPTYPE = :ls_emp_ty and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADOLE' ;
							if sqlca.sqlcode = -1 then
								messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
								rollback using sqlca;
								return 1
							end if 		
						elseIf ld_labage > ll_adoleage then
							select nvl(TASK_CHANGEPOINT,0), nvl(TASK_CHANGEPOINT2,0), nvl(TASK_CHANGEPOINT3,0), nvl(TASK_RATELOWER,0), nvl(TASK_RATELOWER2,0) , nvl(TASK_RATELOWER3,0) ,nvl(TASK_RATEUPPER,0), nvl(TASK_RATEUPPER2,0), nvl(TASK_RATEUPPER3,0)
							into :ld_rtcp1,:ld_rtcp2,:ld_rtcp3,:ld_rtlo1,:ld_rtlo2,:ld_rtlo3,:ld_rtup1,:ld_rtup2,:ld_rtup3
							from fb_task_fulbari 
							where TASK_EMPTYPE = :ls_emp_ty and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADULT'  ;
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
							where TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'CHILD';// and
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
							where TASK_ID = :ls_kam_id and :ld_dt between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADOLE' ;//and
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

					ld_wagrtn = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,0)					

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
					ld_task = ld_rtcp1
//					wf_cal_wages(ld_measure,0,0,0,ld_status)
				/////////////////////
				//		dw_1.setitem(fl_row,'lda_task',ld_rtcp1)
				//		dw_1.setitem(fl_row,'lda_elp',ld_exshwages)
				//		ls_kam_id = dw_1.getitemstring(fl_row,'kamsub_id')
				//		ls_daily_rate = dw_1.getitemstring(fl_row,'lda_daily_rateind')
				//		
				//		ld_dt = dw_1.getitemdatetime(fl_row,'lda_date')
				//		
				//		if gs_garden_snm='FB' and ls_emptype = 'LO' and cbx_4.checked = true then
				//			ld_wages = ld_measure * ld_wagrtn
				//			dw_1.setitem(fl_row,'lda_wages',ld_wages)
				//		elseif gs_garden_snm='FB' and cbx_4.checked = false and ls_daily_rate = 'Y' then
				//			
				//			select kam.kamsub_afrate afrate into :ld_afrate from fb_kamsubhead kam
				//			where trim(kam.kamsub_id) = :ls_kam_id and trunc(:ld_dt) between KAMSUB_FRDT and nvl(KAMSUB_TODT,sysdate) ;
				//			
				//			if sqlca.sqlcode = -1 then
				//				messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
				//				rollback using sqlca;
				//				return 1
				//			end if	
				//			if isnull(ld_afrate) then ld_afrate = 0;			
				//			ld_wages = ld_afrate
				//			dw_1.setitem(fl_row,'lda_wages',ld_wages)
				//			dw_1.setitem(fl_row,'lda_elp',0)
				//		else
							select nvl(INC_AMTPERDAY,0) into :ld_kincentive from fb_incentive 
							where INC_REC_TYPE = 'K' and KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(trunc(INC_TODT),trunc(sysdate));
							if sqlca.sqlcode = -1 then
								messagebox('Error : While Getting Kamjari Incentive Details',sqlca.sqlerrtext)
								rollback using sqlca;
								return 1
							elseif sqlca.sqlcode = 100 then
								if gs_garden_state = '03' and ld_measure >= ld_rtcp1 then
									if ls_kam_id = 'ESUB0163' then // changed on 13012014 as per issue no C0001277
										ld_wages = ld_wages  + 0.6
										ld_exshwages = ld_exshwages + 0.6
									end if
								end if
							elseif sqlca.sqlcode = 0 then
								if isnull(ld_kincentive) then ld_kincentive = 0;
								ld_wages = ld_wages + ld_kincentive
							end if
				//		end if
				///////////////////


				else
					ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,0)
					select nvl(INC_AMTPERDAY,0) into :ld_kincentive from fb_incentive 
							where INC_REC_TYPE = 'K' and KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(trunc(INC_TODT),trunc(sysdate));
							if sqlca.sqlcode = -1 then
								messagebox('Error : While Getting Kamjari Incentive Details',sqlca.sqlerrtext)
								rollback using sqlca;
								return 1
							elseif sqlca.sqlcode = 100 then
								if gs_garden_state = '03' and ld_measure >= ld_rtcp1 then
									if ls_kam_id = 'ESUB0163' then // changed on 13012014 as per issue no C0001277
										ld_wages = ld_wages  + 0.6
										ld_exshwages = ld_exshwages + 0.6
									end if
								end if
							elseif sqlca.sqlcode = 0 then
								if isnull(ld_kincentive) then ld_kincentive = 0;
								ld_wages = ld_wages + ld_kincentive
							end if
				end if
				
				if gs_garden_snm='MT' then		
					select PH_HOURS into :ld_prorata_hours from fb_prorata_hours where PH_DATE = trunc(:ld_dt);
					
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting Prorat Hours ',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					elseif sqlca.sqlcode = 100 then
						ld_prorata_hours = 0
					end if
					
					if ld_prorata_hours > 0 then
						ls_prorata_ind = 'Y'
					else
						ls_prorata_ind = 'N'
					end if
				else
					ls_prorata_ind = 'N'
				end if				
								
				////////////////////////////////		covid indicator uncheck	
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
				
				////////////////////////////////
				
				//LDA_ELP
				insert into fb_labourdailyattendance(LDA_DATE, LABOUR_ID, KAMSUB_ID, LDA_WAGES, LDA_STATUS, JOB_ID,lda_sectionid1,LWW_ID, LDA_ELP, 
															   LDA_TASKIND, LDA_MFJ_COUNT1, LDA_TASK, LDA_LATTA,lda_prorataind,LDA_ENTRY_BY, LDA_ENTRY_DT)
				values(:ld_dt,:ls_labour_id,:ls_kam_id,:ld_wages,:ld_status,:ls_job_id,:ls_sec1,:ls_lwwid,:ld_exshwages,:ls_task_ind,:ld_measure,:ld_task, 'M', :ld_prorata_hours,:gs_user,sysdate);
				
		
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Data Into Attendance Table : ',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				
			end if
			
		// Start MES
			//	if ld_wages > 0 then 
					if luo_fames.wf_upd_mes(string(ld_dt,'dd/mm/yyyy'),ls_kam_id,ld_wages,'W','N') = -1 then 
						rollback using sqlca;
						return 1;
					end if
			//	end if
		// Start Task Activity
				
				if (not isnull(ls_sec1) or len(ls_sec1) > 0) then
//					if wf_saveactivitydaily(string(ld_dt,'dd/mm/yyyy'),ls_labour_id,ls_kam_id,ls_sec1,1,ld_wages,ld_measure,'N',ls_cam_ind,ls_emp_ty,ls_sex) = -1 then 
					if wf_saveactivitydaily(string(ld_dt,'dd/mm/yyyy'),ls_labour_id,ls_kam_id,ls_sec1,ld_status,ld_wages,ld_measure,'N',ls_cam_ind,ls_emp_ty,ls_sex) = -1 then 

						rollback using sqlca;
						return 1;
					end if
				end if
				
//				if ls_first_read = 'Y' or ll_paybook <> ll_paybook_old then
//					ll_paybook_old = ll_paybook
//					ls_first_read = 'N'
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
				
					update fb_mobile_attendance set LMA_PST_IND = 'Y' where  trunc(LMA_DATE) = to_date(to_char(:ld_dt,'dd/mm/yyyy'),'dd/mm/yyyy') and  LMA_WORKERID = :ls_labour_id;
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Updating Mobile Attendance Table',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
					
					
			setnull(ls_labour_id);setnull(ls_emp_name);setnull(ls_div);setnull(ls_emp_ty);setnull(ls_sex); setnull(ls_kam_id);setnull(ls_sec1);
			ld_labage=0;ld_wages=0;ll_paybook=0;ld_status=0;ld_measure = 0; ld_exshwages = 0; ld_wagrtn = 0; ld_wages = 0; ld_measure = 0; ld_task = 0;

			fetch c1 into :ll_paybook,:ls_div,:ld_dt,:ls_labour_id,:ld_labage,:ls_emp_ty,:ls_sex,:ls_kam_id,:ls_sec1,:ld_measure,:ld_status;
			
		loop
	END IF
	close c1;
		

	
	DESTROY n_fames
	commit using sqlca;

	Messagebox('Information !','Attendance Process Completed !!!')
	setpointer(arrow!)	
else
	return
end if 

end event

type cb_7 from commandbutton within w_gtelaf043
boolean visible = false
integer x = 3950
integer y = 16
integer width = 443
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "Import EasyWay"
end type

event clicked;integer l_fnum
long l_flen,l_bytes_read,l_rec_len,l_count,l_fexit, l_ctr1
string l_byte,l_rec_val,ls_filename,lf_fnamed,ls_id,ls_sn,ls_sid,ls_sild, ls_oldmail
string l_field0,l_field1,l_field2,l_field3,l_field4,l_field5,l_field6,l_field7,l_field8,l_field9,l_field10
string l_field11,l_field12,l_field13,l_field14,l_field15,l_field16,l_field17,l_field18,l_field19,l_field20
string l_field21,l_field22,l_field23,l_field24,l_field25,l_field26,l_field27,l_field28,l_field29,l_field30
string l_field31,l_field32,l_field33,l_field34,l_field35,l_field36,l_field37,l_field38,l_field39,l_field40
string l_field41,l_field42,l_field43,l_field44,l_field45,l_field46
string ls_third_party,ls_cust_id,ls_inven_id
double ld_stax_per,ld_fob,ld_ldp, ld_stat

l_count = 0; ld_stat = 0;
l_fexit = GetFileOpenName("Select The Attendance TXT File", &
		+ ls_filename, lf_fnamed, "TXT", &
		+ "TXT Files (*.TXT),*.TXT")

lf_fnamed = upper(left(lf_fnamed,len(lf_fnamed) - 4))

setpointer(HourGlass!)

IF l_fexit = 1 THEN 	
	open(w_import_rows_information)
	l_flen = filelength(ls_filename)
	l_fnum = fileopen(ls_filename)
	l_bytes_read = fileread(l_fnum,l_byte)
	do while l_bytes_read <> -100
			l_rec_val = l_byte
			l_rec_len = len(l_rec_val)
			l_rec_val = right(l_rec_val,l_rec_len)
			l_field1   = f_get_string_position(l_rec_val,",")
			l_field2   = f_get_string_position(l_rec_val,",")
			l_field3   = f_get_string_position(l_rec_val,",")
			l_field4   = f_get_string_position(l_rec_val,",")
			l_field5   = f_get_string_position(l_rec_val,",")
			l_field6   = f_get_string_position(l_rec_val,",")
			l_field7   = f_get_string_position(l_rec_val,",")
			l_field8   = f_get_string_position(l_rec_val,",")
			l_field9   = f_get_string_position(l_rec_val,",")
			l_field10  = f_get_string_position(l_rec_val,",")
			l_field11  = f_get_string_position(l_rec_val,",")
			l_field12  = f_get_string_position(l_rec_val,",")
			l_field13  = f_get_string_position(l_rec_val,",")
			l_field14  = f_get_string_position(l_rec_val,",")
			l_field15  = f_get_string_position(l_rec_val,",")
			l_field16  = f_get_string_position(l_rec_val,",")
			l_field17  = f_get_string_position(l_rec_val,",")
			l_field18  = f_get_string_position(l_rec_val,",")
			l_field19  = f_get_string_position(l_rec_val,",")
			l_field20  = f_get_string_position(l_rec_val,",")
			l_field21  = f_get_string_position(l_rec_val,",")
			l_field22  = f_get_string_position(l_rec_val,",")
			l_field23  = f_get_string_position(l_rec_val,",")
			l_field24  = f_get_string_position(l_rec_val,",")
			l_field25  = f_get_string_position(l_rec_val,",")
			

			if len(l_field1) > 0 then

				if len(l_field3) = 6 then
					l_field3 = left(l_field3,2)+'/'+mid(l_field3,3,2)+'/20'+right(l_field3,2)
				end if
				select distinct ltrim(rtrim(:l_field5)) into :ls_temp from fb_mobile_attendance where LMA_DATE = to_date(:l_field3,'dd/mm/yyyy') and LMA_WORKERID = ltrim(rtrim(:l_field5));
				if sqlca.sqlcode = 0 then
				   messagebox("Warning",'Record Already Present For Worker :' +l_field5+' On Date : '+l_field3+',  Please Check')
					rollback using sqlca;
					close(w_import_rows_information)
				   fileclose(l_fnum)
					return 1	
//					update fb_mobile_attendance set LMA_STATUS = 1, LMA_NTWTT = LMA_NTWTT + to_number(:l_field46)
//					where LMA_DATE = to_date(:l_field1,'dd/mm/yyyy') and LMA_WORKERID = ltrim(rtrim(:l_field3)) and LMA_KAMSUBHEADID = ltrim(rtrim(:l_field4));
//					if sqlca.sqlcode = -1 then
//						messagebox("SQL Error : During Updating Worker Details !!!",SQLCA.SQLErrtext,Information!)
//						rollback using sqlca;
//						close(w_import_rows_information)
//						fileclose(l_fnum)
//						return 1
//					end if				
				elseif sqlca.sqlcode =100 then
					ld_stat = 1;
//					messagebox('212',string(len(l_field15)))
//					if ((not isnull(l_field6) or len(l_field6) > 0) and (not isnull(l_field15) or len(l_field15) > 0))  then
//					if (len(l_field6) > 0 and len(l_field15) > 0)  then
//						ld_stat = 1
//					elseif (len(l_field6) > 0 and len(l_field24) > 0)  then  //(not isnull(l_field6) and not isnull(l_field24))  then
//						ld_stat = 1
//					elseif (len(l_field15) > 0 and len(l_field24) > 0)  then //elseif (not isnull(l_field15) and not isnull(l_field24)) then
//						ld_stat = 1
//					elseif (len(l_field6) > 0 or len(l_field15) > 0 or len(l_field24) > 0) then
//						ld_stat = 0.5
//					end if
					if l_field6 = 'B116' then
						l_field6 = 'G161'
					elseif l_field6 = 'D292' then
						l_field6 = 'D105'
					elseif l_field6 = 'A416' then
						l_field6 = 'K291'
					elseif l_field6 = 'D102' then
						l_field6 = 'D101'
					elseif l_field6 = 'B621' then
						l_field6 = 'E261'	
					elseif l_field6 = 'D122' then
						l_field6 = 'D121'	
					elseif l_field6 = 'C601' then
						l_field6 = 'C101'	
					elseif l_field6 = 'C602' then
						l_field6 = 'C101'	
					elseif l_field6 = 'C701' then
						l_field6 = 'C101'	
					elseif l_field6 = 'C102' then
						l_field6 = 'C101'	
					elseif l_field6 = 'B622' then
						l_field6 = 'B612'	
					elseif l_field6 = 'D122' then
						l_field6 = 'D121'	
					elseif l_field6 = 'D141' then
						l_field6 = 'D131'	
					elseif l_field6 = 'D151' then
						l_field6 = 'D109'	
					elseif l_field6 = 'E161' then
						l_field6 = 'E151'	
					elseif l_field6 = 'D152' then
						l_field6 = 'OS'	
					elseif l_field6 = 'D313' then
						l_field6 = 'D131'	
					elseif l_field6 = 'D153' then
						l_field6 = 'D131'	
					elseif l_field6 = 'F122' then
						l_field6 = 'F121'	
					elseif l_field6 = 'G111' then
						l_field6 = 'A422'	
					elseif l_field6 = 'G112' then
						l_field6 = 'A422'	
					elseif l_field6 = 'K261' then
						l_field6 = 'A271'	
					elseif l_field6 = 'G111' then
						l_field6 = 'A422'	
					elseif l_field6 = 'G122' then
						l_field6 = 'A422'	
					elseif l_field6 = 'B502' then
						l_field6 = 'B501'	
					elseif l_field6 = 'D104' then
						l_field6 = 'D109'	
					elseif l_field6 = 'D103' then
						l_field6 = 'D109'
					elseif l_field6 = 'K241' then
						l_field6 = 'G141'													
					elseif l_field6 = 'F232' then
						l_field6 = 'A512'		
					elseif l_field6 = 'A243' then
						l_field6 = 'A241'													
					elseif l_field6 = 'A242' then
						l_field6 = 'A241'													
					elseif l_field6 = 'A402' then
						l_field6 = 'A401'													
					elseif l_field6 = 'A421' then
						l_field6 = 'A401'													
					elseif l_field6 = 'A212' then
						l_field6 = 'A202'	
					elseif l_field6 = 'E411' then
						l_field6 = 'A202'
					elseif l_field6 = 'A166' then
						l_field6 = 'A161'
					elseif l_field6 = 'B114' then
						l_field6 = 'B111'
					elseif l_field6 = 'B116' then
						l_field6 = 'G201'
					elseif l_field6 = 'B505' then
						l_field6 = 'B501'
					elseif l_field6 = 'F311' then
						l_field6 = 'D109'
					elseif l_field6 = 'E292' then
						l_field6 = 'D105'
					elseif l_field6 = 'J361' then
						l_field6 = 'E321'
					elseif l_field6 = 'A229' then
						 l_field6 = 'A221'
					elseif l_field6 = 'C402' then
						l_field6 = 'C101'	
					elseif  l_field6 = 'E441' then
						l_field6 = 'E421'	
					end if

					select KAMSUB_ID into :ls_kam_id from fb_kamsubhead where KAMSUB_NAME = ltrim(rtrim(:l_field6)) and KAMSUB_ACTIVE_IND = 'Y';
					if sqlca.sqlcode = -1 then
						messagebox("Sql Error During Getting Kamjari",SQLCA.SQLErrtext,Information!)
						rollback using sqlca;
					elseif sqlca.sqlcode = 100 then
						messagebox("Warning",'Kamjari Not In Master :' +l_field6+',  Please Check')
						rollback using sqlca;
						return
					end if
					
					insert into fb_mobile_attendance (LMA_DATE, LMA_WORKERID, LMA_KAMSUBHEADID, LMA_KAMSUBNAM, LMA_NTWT1, LMA_NTWT2, LMA_NTWT3,LMA_NTWT4, LMA_NTWTT,LMA_STATUS,LMA_COSTCENTRE4)
					values (to_date(:l_field3,'dd/mm/yyyy'),trim(:l_field5),ltrim(rtrim(:ls_kam_id)),ltrim(rtrim(:l_field6)),to_number(:l_field10),to_number(:l_field11),to_number(:l_field12),to_number(:l_field13),
							(to_number(:l_field10) + to_number(:l_field11) + to_number(:l_field12) + to_number(:l_field13)),:ld_stat,'E');
	
					if sqlca.sqlcode = -1 then
						messagebox("SQL Error : During Insert Worker Details !!!",SQLCA.SQLErrtext,Information!)
						rollback using sqlca;
						close(w_import_rows_information)
						fileclose(l_fnum)
						return 1
					end if
				elseif sqlca.sqlcode = -1 then
					 messagebox("SQL Error : During Checking Worker Record !!!",SQLCA.SQLErrtext,Information!)
					rollback using sqlca;
					close(w_import_rows_information)
				     fileclose(l_fnum)
					return 1	
				end if
				
			end if		
		
			l_bytes_read = fileread(l_fnum,l_byte)
			l_count = l_count + 1
			w_import_rows_information.sle_1.text= string(l_count) 
			//messagebox('Count',l_count)
	loop
	commit using sqlca;
	fileclose(l_fnum)
	close(w_import_rows_information)
	setpointer(arrow!) 
	messagebox("Import File Information",'Total ' + string(l_count) + ' Rows Imported.....')
else
	setpointer(arrow!) 
	messagebox("file","File Does Not Exists -> " + ls_filename)
end if

return 1

end event

type cb_6 from commandbutton within w_gtelaf043
boolean visible = false
integer x = 4274
integer y = 16
integer width = 155
integer height = 104
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
((to_date('06/12/2014','dd/mm/yyyy') - emp_dob) /365), emp_type, emp_sex,lda_status
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

type em_1 from editmask within w_gtelaf043
integer x = 1664
integer y = 16
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

type st_3 from statictext within w_gtelaf043
integer x = 1367
integer y = 28
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

type st_2 from statictext within w_gtelaf043
integer x = 2011
integer y = 32
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

type ddlb_1 from dropdownlistbox within w_gtelaf043
integer x = 2249
integer y = 16
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

type cb_2 from commandbutton within w_gtelaf043
integer x = 3488
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
//if cbx_1.checked = false or (gs_garden_snm <> 'MV' and gs_garden_snm <> 'GP' and gs_garden_snm <> 'JP'  and gs_garden_snm <> 'MF' and gs_garden_snm <> 'GF') then
	if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
		messagebox('Warning!','Please Select A Pay Book No. !!!')
		return 1
	end if
//end if
ld_rundt = datetime(em_1.text) 
ll_paybook = long(left(right(ddlb_1.text,3),2))

select lww_paidflag, LWW_PAYCALFLAG,LWW_PARTWEEK_VOU_NO into :ls_paidfg, :ls_calfg, :ls_pwvn from fb_labourwagesweek 
where trunc(:ld_rundt) between trunc(lww_startdate) and trunc(lww_enddate);

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
	
elseif sqlca.sqlcode = 0 then
	if isnull(ls_pwvn) then ls_pwvn = 'X';
	if ls_paidfg = '1' then
		ls_protect_flg = 'Y'
	elseif ls_paidfg <> '1' then
		if ll_user_level = 1 and ls_pwvn <> 'X' and mid(string(ld_rundt),4,2) <> mid(string(today()),4,2) then
			ls_protect_flg = 'Y'
		elseif ll_user_level = 1 and ls_pwvn <> 'X' and mid(string(ld_rundt),4,2) = mid(string(today()),4,2) then
			ls_protect_flg = 'N'
		elseif ll_user_level = 1 and ls_pwvn = 'X' then
			ls_protect_flg = 'N'
		end if
	elseif ls_paidfg = '0' and ls_calfg = '0' then
		ls_protect_flg = 'N'
	end if
end if	

lb_neworder =false
lb_query = false
dw_1.settransobject(sqlca)
dw_1.SetRedraw (FALSE)
dw_1.Object.datawindow.querymode = 'no'
dw_1.Retrieve(gs_garden_snm,string(ld_rundt,'dd/mm/yyyy'),ll_paybook,ls_protect_flg)
dw_1.settaborder('labour_id',0)
dw_1.SetRedraw (TRUE)


end event

type cb_4 from commandbutton within w_gtelaf043
integer x = 3703
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

type dw_1 from datawindow within w_gtelaf043
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
event ue_dwnkey pbm_dwnkey
event ue_kewdwn pbm_keydown
integer x = 9
integer y = 128
integer width = 4599
integer height = 2084
integer taborder = 100
string dataobject = "dw_gtelaf043"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;//if lb_query = false then
// if lb_neworder = true then	
//	if currentrow <> dw_1.rowcount() then
//		IF wf_check_fillcol(currentrow) = -1 THEN
//			return 1
//		END IF
////		if newrow > currentrow and dw_1.rowcount() > 1 and gs_garden_snm = 'MT' then
////			ls_labour_id = dw_1.getitemstring(currentrow,'labour_id')
////			ld_dt = dw_1.getitemdatetime(currentrow,'lda_date')
////			ls_kam_id = dw_1.getitemstring(currentrow,'kamsub_id')
////			ld_status = dw_1.getitemnumber(currentrow,'lda_status')
////
////			select nvl(INC_AMTPERDAY,0) into :ld_wages from fb_incentive 
////			where INC_REC_TYPE = 'L' and KAMSUB_ID = :ls_labour_id and trunc(:ld_dt) between INC_FRDT and nvl(INC_TODT,trunc(sysdate));
////			if sqlca.sqlcode = -1 then
////				messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
////				rollback using sqlca;
////				return 1
////			elseif sqlca.sqlcode = 100 then
////				ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,currentrow)
////				
////				select nvl(INC_AMTPERDAY,0) into :ld_kincentive from fb_incentive 
////				where INC_REC_TYPE = 'K' and KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(trunc(INC_TODT),trunc(sysdate));
////				if sqlca.sqlcode = -1 then
////					messagebox('Error : While Getting Kamjari Incentive Details',sqlca.sqlerrtext)
////					rollback using sqlca;
////					return 1
////				elseif sqlca.sqlcode = 0 then
////					if isnull(ld_kincentive) then ld_kincentive = 0;
////					ld_wages = ld_wages + ld_kincentive
////				end if				
////			end if
////			dw_1.setitem(currentrow,'lda_wages',ld_wages)				
////		end if		
//	END If
//	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1 and cbx_1.checked = true then
//		ls_kam_id = dw_1.getitemstring(currentrow,'kamsub_id')
//		ls_sec1 = dw_1.getitemstring(currentrow,'lda_sectionid1')
//		if gs_garden_snm <> 'MF' and gs_garden_snm <> 'GF' and (ls_kam_id = 'ESUB0163' or ls_kam_id = 'ESUB0434' or ls_kam_id = 'ESUB0435') then //= 'ESUB0163' then
//			if len(ls_sec1) > 0  or not isnull(ls_sec1) then
//				setnull(ls_temp)
//				
//				select distinct 'x' into :ls_temp	from fb_sectionpluckinground where trunc(SPR_DATE) = trunc(:ld_dt) and section_id = :ls_sec1;
//				
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				elseif sqlca.sqlcode = 100 then
//					messagebox('Warning!','Round Days Entry Not Done For The Section, Please Check !!!')
//					dw_1.setitem(currentrow,'lda_sectionid1',ls_temp)
//					return 1
//				end if
//			end if
//		end if		
//		
//		dw_1.setitem(newrow,'lda_entry_by',gs_user)
//		dw_1.setitem(newrow,'lda_entry_dt',datetime(today()))
//		dw_1.setitem(newrow,'lda_date',dw_1.getitemdatetime(currentrow,'lda_date'))
//		dw_1.setitem(newrow,'kamsub_id',dw_1.getitemstring(currentrow,'kamsub_id'))
//		dw_1.setitem(newrow,'lda_wages',dw_1.getitemnumber(currentrow,'lda_wages'))		
//		dw_1.setitem(newrow,'lda_sectionid1',dw_1.getitemstring(currentrow,'lda_sectionid1'))
//		dw_1.setitem(newrow,'gs_gsnm',dw_1.getitemstring(currentrow,'gs_gsnm'))
//		dw_1.setitem(newrow,'lda_taskind',dw_1.getitemstring(currentrow,'lda_taskind')) 
//		dw_1.setitem(newrow,'ls_id',dw_1.getitemnumber(currentrow,'ls_id'))
//		dw_1.setitem(newrow,'lda_prorataind',dw_1.getitemstring(currentrow,'lda_prorataind'))
//		dw_1.setitem(newrow,'lww_id',dw_1.getitemstring(currentrow,'lww_id'))
//		dw_1.setcolumn('labour_id') 
//	end if
//	
//	if newrow > currentrow and dw_1.rowcount() > 1 and gs_garden_snm = 'MT' then
//		//dw_1.setitem(newrow,'lda_sectionid1',dw_1.getitemstring(currentrow,'lda_sectionid1'))
//		dw_1.setitem(newrow,'confirm_ind','Y')
//	end if
//	
//	if dw_1.rowcount() > 1 and cbx_3.checked = true then
//		//dw_1.getitemstring(currentrow,'kamsub_id')
//		if currentrow = 0 then 
//			currentrow = currentrow + 1
//		end if
//		ls_kam_id = dw_1.getitemstring(currentrow,'kamsub_id')
//		ls_sec1 = dw_1.getitemstring(currentrow,'lda_sectionid1')
//		if gs_garden_snm <> 'MF' and gs_garden_snm <> 'GF' and (ls_kam_id = 'ESUB0163' or ls_kam_id = 'ESUB0434' or ls_kam_id = 'ESUB0435') then //= 'ESUB0163' then
//			if len(ls_sec1) > 0  or not isnull(ls_sec1) then
//				setnull(ls_temp)
//				
//				select distinct 'x' into :ls_temp	from fb_sectionpluckinground where trunc(SPR_DATE) = trunc(:ld_dt) and section_id = :ls_sec1;
//				
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				elseif sqlca.sqlcode = 100 then
//					messagebox('Warning!','Round Days Entry Not Done For The Section, Please Check !!!')
//					dw_1.setitem(currentrow,'lda_sectionid1',ls_temp)
//					return 1
//				end if
//			end if
//		end if		
//		
//		if isnull(dw_1.getitemstring(newrow,'kamsub_id'))  then
//			dw_1.setitem(newrow,'kamsub_id',dw_1.getitemstring(currentrow,'kamsub_id'))
//			dw_1.setitem(newrow,'lda_sectionid1',dw_1.getitemstring(currentrow,'lda_sectionid1'))
//			dw_1.setitem(newrow,'kamsub_secind',dw_1.getitemstring(currentrow,'kamsub_secind')) 
//			dw_1.setitem(newrow,'lda_taskind',dw_1.getitemstring(currentrow,'lda_taskind')) 
//			dw_1.setitem(newrow,'kamsub_measind',dw_1.getitemstring(currentrow,'kamsub_measind'))
//			dw_1.setitem(newrow,'kamsub_costcind',dw_1.getitemstring(currentrow,'kamsub_costcind'))
//			dw_1.setitem(newrow,'lda_status',dw_1.getitemnumber(currentrow,'lda_status'))
//			dw_1.setitem(newrow,'lda_wages',dw_1.getitemnumber(currentrow,'lda_wages'))		
//			dw_1.setcolumn('kamsub_id')
//		end if
//	end if
//	
// end if
//end if
//
end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event ue_dwnkey;//if lb_neworder = true then
//	if cbx_1.checked = true or ls_gsnm = 'KG' or ls_gsnm = 'DL' then
//		IF KeyDown(KeyF6!) THEN
//			dw_1.deleterow(dw_1.getrow())
//		end if
////		IF KeyDown(KeyEnter!) THEN
////			if dw_1.getrow() = 1 then
////				dw_1.triggerevent(itemchanged!)
////			end if
////		end if		
//		if dw_1.rowcount() = 0 then
//			cb_3.enabled = false
//		end if
//	end if
//end if
//
end event

event ue_kewdwn;//if lb_neworder = true then
//	if cbx_1.checked = true or ls_gsnm = 'KG'  or ls_gsnm = 'DL' then
//		IF KeyDown(KeyF6!) THEN
//			dw_1.deleterow(dw_1.getrow())
//		end if
////		IF KeyDown(KeyEnter!) THEN
////			if dw_1.getrow() = 1 then
////				dw_1.triggerevent(itemchanged!)
////			end if
////		end if
//		if dw_1.rowcount() = 0 then
//			cb_3.enabled = false
//		end if
//	end if
//end if
//
end event

event itemchanged;//if lb_query = false then
//	if dwo.name = 'labour_id' then
//		ls_labour_id = data
//		ld_dt = dw_1.getitemdatetime(row,'lda_date')
//		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
//		ld_status = dw_1.getitemnumber(row,'lda_status')
//		
//		select emp_name, ls_id,field_id,emp_type into :ls_emp_name, :ll_paybook,:ls_div,:ls_emptype from fb_employee a 
//		where nvl(EMP_ACTIVE,'1') = '1' and emp_type in ('LP','LT','LO') and EMP_ID = :ls_labour_id;
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 100 then
//			messagebox('Warning !!!','Invalid Employee Code, Please Check !!!')
//			return 1
//		end if
//		
//		select distinct 'x' into :ls_temp from fb_labourdailyattendance where lda_date =  :ld_dt and labour_id = :ls_labour_id;
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Labour Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 0 then
//			messagebox('Duplicate Entry !!!','Attendance Entry Of This Labour Already Exists For This Date, Please Check !!!')
//			return 1
//		end if
//		
//		if wf_check_duplicate_rec(ls_labour_id) = -1 then return 1
//		
//		select distinct 'x' into :ls_temp from fb_maternity 
//		where mt_empid = :ls_labour_id and trunc(:ld_dt) between trunc(mt_fromdt) and trunc(mt_todt);
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 0 then
//			select distinct KAMSUB_ID into :ls_kam_id from fb_kamsubhead where trim(kamsub_nkamtype)='MATERNITY';
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			end if
//			dw_1.setitem(row,'kamsub_id',ls_kam_id)
//			dw_1.modify("kamsub_id.protect = '1'")
//		else
//			dw_1.modify("kamsub_id.protect = '0'")
//		end if
//			dw_1.setitem(row,'emp_name',ls_emp_name)
//			dw_1.setitem(row,'ls_id',ll_paybook)
//			
//		select distinct 'x' into :ls_temp  from fb_kamsubhead 
//		where KAMSUB_ID = :ls_kam_id and KAMSUB_TYPE = 'NKAM' and trim(KAMSUB_NKAMTYPE) in ('SICKALLOWANCE','ABSENT','HOLIDAYNOPAY','SICKNOWAGES');
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 100 then	
//			select nvl(INC_AMTPERDAY,0) into :ld_wages from fb_incentive 
//			where INC_REC_TYPE = 'L' and KAMSUB_ID = :ls_labour_id and trunc(:ld_dt) between INC_FRDT and nvl(INC_TODT,trunc(sysdate));
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode = 100 then
//				ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
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
//			dw_1.setitem(row,'lda_wages',ld_wages)
//		end if
//	else
//		ls_labour_id = dw_1.getitemstring(row,'labour_id')
//	end if
//	
//	if dwo.name = 'lda_taskind' then
//		if data = 'N' then
//			ld_status = dw_1.getitemnumber(row,'lda_status')
//			ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
//			ls_labour_id = dw_1.getitemstring(row,'labour_id')
//			ld_dt = dw_1.getitemdatetime(row,'lda_date')
//			ls_labour_id = dw_1.getitemstring(row,'labour_id')
//			select distinct 'x' into :ls_temp  from fb_kamsubhead 
//			where KAMSUB_ID = :ls_kam_id and KAMSUB_TYPE = 'NKAM' and trim(KAMSUB_NKAMTYPE) in ('SICKALLOWANCE','ABSENT','HOLIDAYNOPAY','SICKNOWAGES');
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting Kanjari Details',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode = 100 then	
//				select nvl(INC_AMTPERDAY,0) into :ld_wages from fb_incentive 
//				where INC_REC_TYPE = 'L' and KAMSUB_ID = :ls_labour_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(INC_TODT,trunc(sysdate));
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				elseif sqlca.sqlcode = 100 then
//					ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
//						select nvl(INC_AMTPERDAY,0) into :ld_kincentive from fb_incentive 
//						where INC_REC_TYPE = 'K' and KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(trunc(INC_TODT),trunc(sysdate));
//						if sqlca.sqlcode = -1 then
//							messagebox('Error : While Getting Kamjari Incentive Details',sqlca.sqlerrtext)
//							rollback using sqlca;
//							return 1
//						elseif sqlca.sqlcode = 0 then
//							if isnull(ld_kincentive) then ld_kincentive = 0;
//							ld_wages = ld_wages + ld_kincentive
//						end if	
//				end if
//			else
//				ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
//			end if
//			dw_1.setitem(row,'lda_wages',ld_wages)
//			ld_elp = 0
//			dw_1.setitem(row,'lda_elp',ld_elp)
//		else
//			wf_cal_wages(dw_1.getitemnumber(row,'lda_mfj_count1'),dw_1.getitemnumber(row,'lda_mfj_count2'),dw_1.getitemnumber(row,'lda_mfj_count3'),row,dw_1.getitemnumber(row,'lda_status'))
//		end if
//	end if
//	if dwo.name = 'lda_mfj_junglifoot'  then
//		dw_1.setitem(row,'lda_elp',0)
//		dw_1.setitem(row,'lda_mfj_count1',0)
//		ls_JUNGLIFOOT_ind = trim(data)
//		ld_status = dw_1.getitemnumber(row,'lda_status')
//		ll_paybook = dw_1.getitemnumber(row,'ls_id')
//		ld_dt = dw_1.getitemdatetime(row,'lda_date')
//		ls_lwwind = dw_1.getitemstring(row,'lda_lwwind')
//		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
//		
//		ld_labage = 0
//
//		select FIELD_ID,round((trunc(sysdate) - trunc(EMP_DOB))/365), ((:ld_dt - emp_dob) /365), emp_type, ls_id into :ls_div,:ll_year,:ld_labage, :ls_emptype, :ll_paybook  from fb_employee where emp_id = :ls_labour_id; 
//		
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Employee Age',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		end if
//				
//		select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0))
//		into :ll_adoleage, :ll_child
//		from fb_param_detail 
//		where pd_doc_type in ('CHILDAGE','ADOLEAGE') and
//				 trunc(:ld_dt) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));
//	
//		if sqlca.sqlcode = -1 then
//			messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
//			return 1
//		end if;
//
//		If ld_labage <= ll_child Then //(144 months=12 years)
//			select distinct 'x' into :ls_temp	from fb_task 
//			where TASK_ID = :ls_kam_id and trunc(:ld_dt) between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'CHILD' and
//					(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N')));
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode = 0 then
//				if gs_garden_snm = 'MB' and cbx_2.checked = true then
//					dw_1.setitem(row,'lda_taskind','Y')
//					dw_1.modify("lda_taskind.protect = '0'")
//				elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
//					dw_1.setitem(row,'lda_taskind','N')
//					dw_1.modify("lda_taskind.protect = '1'")
//				elseif gs_garden_snm <> 'MB' then
//					dw_1.setitem(row,'lda_taskind','Y')
//					dw_1.modify("lda_taskind.protect = '0'")					
//				end if
//			elseif sqlca.sqlcode = 100 then
//				dw_1.setitem(row,'lda_taskind','N')
//				dw_1.modify("lda_taskind.protect = '1'")
//			end if
//		elseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
//			select distinct 'x' into :ls_temp	from fb_task  
//			where TASK_ID = :ls_kam_id and trunc(:ld_dt)  between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADOLE' and
//					(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode = 0 then
//				if gs_garden_snm = 'MB' and cbx_2.checked = true then
//					dw_1.setitem(row,'lda_taskind','Y')
//					dw_1.modify("lda_taskind.protect = '0'")
//				elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
//					dw_1.setitem(row,'lda_taskind','N')
//					dw_1.modify("lda_taskind.protect = '1'")
//				elseif gs_garden_snm <> 'MB' then
//					dw_1.setitem(row,'lda_taskind','Y')
//					dw_1.modify("lda_taskind.protect = '0'")					
//				end if				
//			elseif sqlca.sqlcode = 100 then
//				dw_1.setitem(row,'lda_taskind','N')
//				dw_1.modify("lda_taskind.protect = '1'")
//			end if 		
//		elseIf ld_labage > ll_adoleage then
//			select distinct 'x' into :ls_temp	from fb_task 
//			where TASK_ID = :ls_kam_id and trunc(:ld_dt)  between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADULT' and
//					(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode = 0 then
//				if gs_garden_snm = 'MB' and cbx_2.checked = true then
//					dw_1.setitem(row,'lda_taskind','Y')
//					dw_1.modify("lda_taskind.protect = '0'")
//				elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
//					dw_1.setitem(row,'lda_taskind','N')
//					dw_1.modify("lda_taskind.protect = '1'")
//				elseif gs_garden_snm <> 'MB' then
//					dw_1.setitem(row,'lda_taskind','Y')
//					dw_1.modify("lda_taskind.protect = '0'")					
//				end if				
//			elseif sqlca.sqlcode = 100 then
//				dw_1.setitem(row,'lda_taskind','N')
//				dw_1.modify("lda_taskind.protect = '1'")
//			end if 
//		end if
////		if dw_1.getitemstring(row,'lda_taskind') = 'Y' then
//		if dw_1.getitemnumber(row,'lda_mfj_count1') <> 0 then
//			wf_cal_wages(dw_1.getitemnumber(row,'lda_mfj_count1'),dw_1.getitemnumber(row,'lda_mfj_count2'),dw_1.getitemnumber(row,'lda_mfj_count3'),row,dw_1.getitemnumber(row,'lda_status'))
//		end if 
////		end if
//	end if	
//	
//	if dwo.name = 'kamsub_id'  then
//		dw_1.setitem(row,'lda_elp',0)
//		ls_kam_id = trim(data)
//		ld_status = dw_1.getitemnumber(row,'lda_status')
//		ll_paybook = dw_1.getitemnumber(row,'ls_id')
//		ld_dt = dw_1.getitemdatetime(row,'lda_date')
//		ls_lwwind = dw_1.getitemstring(row,'lda_lwwind')
//		ls_JUNGLIFOOT_ind = dw_1.getitemstring(row,'lda_mfj_junglifoot')
////		dw_1.setitem(row,'lda_status',1)
////		dwc_section1.SetFilter ("string(spr_date,'dd/mm/yyyy') = '"+string(ld_dt,'dd/mm/yyyy')+"'")
////		dwc_section1.settransobject(sqlca)
////		dwc_section1.filter()
////		dwc_section2.SetFilter ("string(spr_date,'dd/mm/yyyy') = '"+string(ld_dt,'dd/mm/yyyy')+"'")
////		dwc_section2.settransobject(sqlca)	
////		dwc_section2.retrieve()
////		dwc_section3.SetFilter ("string(spr_date,'dd/mm/yyyy') = '"+string(ld_dt,'dd/mm/yyyy')+"'")
////		dwc_section3.settransobject(sqlca)	
////		dwc_section3.retrieve()		
//		ll_year = 0;
//		ld_lwwopn = wf_lwwopening(ls_labour_id,ll_paybook,ld_dt)
//	//	messagebox('opn',string(ld_lwwopn))
//		
//		// Checking Employee Retirement Age
//		setnull(ls_temp);setnull(ll_temp);
//		//dw_1.setitem(newrow,'lda_sectionid1',dw_1.getitemstring(currentrow,'lda_sectionid1'))
//		//if 
//		if ls_gsnm = 'KG' then
//			dw_1.settaborder('lda_sectionid2',0)
//			dw_1.settaborder('lda_taskind',0)
//		end if
//		
//		if ls_gsnm = 'DL' then
//			dw_1.settaborder('lda_sectionid2',0)
//		end if			
//		dw_1.setitem(row,'lda_sectionid1',ls_temp)
//		dw_1.setitem(row,'lda_sectionid2',ls_temp)
//		dw_1.setitem(row,'lda_sectionid3',ls_temp)
//		dw_1.setitem(row,'lda_mfj_count1',ll_temp)
//		dw_1.setitem(row,'lda_mfj_count2',ll_temp)
//		dw_1.setitem(row,'lda_mfj_count3',ll_temp)
//		ld_labage = 0
//		select FIELD_ID,round((trunc(sysdate) - trunc(EMP_DOB))/365), ((:ld_dt - emp_dob) /365), emp_type, ls_id into :ls_div,:ll_year,:ld_labage, :ls_emptype, :ll_paybook  from fb_employee where emp_id = :ls_labour_id; 
//		
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Employee Age',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		end if
//		
//		select nvl(KAMSUB_SECIND,'N') KAMSUB_SECIND, nvl(KAMSUB_MEASIND,'N') KAMSUB_MEASIND, nvl(KAMSUB_COSTCIND,'N') KAMSUB_COSTCIND, KAMSUB_NAME ,trim(kamsub_nkamtype),trim(KAMSUB_TYPE)
//		into :ls_secind,:ls_measureind,:ls_ccind,:ls_kam_sname,:ls_nkam_type,:ls_kamtype
//		from fb_kamsubhead where KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(KAMSUB_FRDT) and trunc(nvl(KAMSUB_TODT,sysdate));
//
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Section, Measure & Costcenter Ind',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		end if
//
//		dw_1.setitem(row,'kamsub_secind',ls_secind) 
//		dw_1.setitem(row,'kamsub_measind',ls_measureind)
//		dw_1.setitem(row,'kamsub_costcind',ls_ccind)
//
//		if ls_kamtype ='OKAM' or ls_kamtype = 'NKAM' or ls_kamtype = 'FKAM' then
//
//			select section_id into :ls_sec1 from fb_section  where substr(SECTION_NAME,1,1)||'KAM' = :ls_kamtype and FIELD_ID=:ls_div and section_type='C';
//			
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting Section From Section Master',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode=0 then
//				dw_1.setitem(row,'lda_sectionid1',ls_sec1)
//			end if
//
//		end if
//		
//		select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0))
//		into :ll_adoleage, :ll_child
//		from fb_param_detail 
//		where pd_doc_type in ('CHILDAGE','ADOLEAGE') and
//				 trunc(:ld_dt) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));
//	
//		if sqlca.sqlcode = -1 then
//			messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
//			return 1
//		end if;
//
//		
// 		if gs_garden_snm = 'FB' or gs_garden_snm = 'MK' or gs_garden_snm = 'ME' or gs_garden_snm = 'KG' or gs_garden_snm = 'BE' then
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
//				where TASK_EMPTYPE = :ls_emptype and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and trunc(:ld_dt)  between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'ADULT' ;
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
//		else
//			If ld_labage <= ll_child Then //(144 months=12 years)
//				select distinct 'x' into :ls_temp	from fb_task 
//				where TASK_ID = :ls_kam_id and trunc(:ld_dt) between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'CHILD' and
//						(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N')));
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
//				select distinct 'x' into :ls_temp	from fb_task  
//				where TASK_ID = :ls_kam_id and trunc(:ld_dt)  between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'ADOLE' and
//						(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
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
//				select distinct 'x' into :ls_temp	from fb_task 
//				where TASK_ID = :ls_kam_id and trunc(:ld_dt)  between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'ADULT' and
//						(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
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
//			messagebox('Warning!','Employee ('+ls_labour_id+') Has Reached Retirement Age, Please Check !!!')
//			//return 1
//		end if
//		
//		// Checking Employee Retirement Age
//		
//		select distinct 'x' into :ls_temp from fb_kamsubhead,fb_expenseacsubhead 
//		where kamsub_id = eacsubhead_id and nvl(KAMSUB_ACTIVE_IND,'Y') = 'Y' and KAMSUB_TODT is null and KAMSUB_ID = :ls_kam_id;
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 100 then
//			messagebox('Warning!','Invalid Kamjari ID, Please Check !!!')
////			if ls_gsnm <> 'KG' then
//			return 1
////			end if
//		end if
//		
//			ld_sick = 0;ld_sl = 0;
//			if trim(ls_nkam_type) = 'SICKALLOWANCE' then
//					select nvl(count(1),0) into :ld_sick from fb_labourdailyattendance where LABOUR_ID = :ls_labour_id and KAMSUB_ID = (select KAMSUB_ID from fb_kamsubhead where nvl(KAMSUB_ACTIVE_IND,'Y') = 'Y' and KAMSUB_NKAMTYPE = 'SICKALLOWANCE') and
//											trunc(LDA_DATE) between to_date('01/01/'||to_char(sysdate,'YYYY'),'dd/mm/yyyy') and trunc(:ld_dt);
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				end if
//				if isnull(ld_sick) then ld_sick = 0;
//				
//				select nvl(pd_value,0) into :ld_sl from fb_param_detail 
//				where pd_doc_type = 'SICKALLOWANCE' and trunc(:ld_dt) between trunc(PD_PERIOD_FROM) and nvl(PD_PERIOD_TO,trunc(sysdate));
//	
//				if sqlca.sqlcode = -1 then
//					messagebox('SQL ERROR: During Parametere Getting Sick Leave Days ',sqlca.sqlerrtext)
//					return 1
//				end if;
//				
//				if isnull(ld_sl) then ld_sl = 0;
//				
//				if ld_sick >= ld_sl then
//					messagebox('Warning !','This Employee ('+ls_labour_id+') Has Already Availed ' + string(ld_sl) +' Days Sick leave This Year, Pleae Check !!!')
//					return 1
//				end if
//			end if
//			
//			if trim(ls_kam_sname) = 'LWW' then
//				if ls_lwwind = 'Y' then
//				// as per LWW calculation opening should come		
//					ld_lwwopn = wf_lwwopening(ls_labour_id,ll_paybook,ld_dt)
//					select nvl(count(1),0) into :ld_lwwavail from fb_labourdailyattendance where LABOUR_ID = :ls_labour_id and KAMSUB_ID = (select KAMSUB_ID from fb_kamsubhead where nvl(KAMSUB_ACTIVE_IND,'Y') = 'Y' and KAMSUB_NAME = 'LWW') and
//												trunc(LDA_DATE) between to_date('01/01/'||to_char(sysdate,'YYYY'),'dd/mm/yyyy') and trunc(sysdate) and lda_lwwind = 'Y';
//					if sqlca.sqlcode = -1 then
//						messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
//						rollback using sqlca;
//						return 1
//					end if
//					if isnull(ld_lwwopn) then ld_lwwopn = 0;
//					if isnull(ld_lwwavail) then ld_lwwavail = 0;
//					if gs_garden_snm <> 'MK' then 
//						if (ld_lwwopn - ld_lwwavail) <= 0 then
//							messagebox('Warning !','LWW Balance Is Nil For This Employee, Pleae Check !!!')
//							return 1
//						end if
//					elseif gs_garden_snm = 'MK' and string(ld_dt,'YYYY') < '2017' then 
//						if (ld_lwwopn - ld_lwwavail) <= 0 then
//							messagebox('Warning !','LWW Balance Is Nil For This Employee, Pleae Check !!!')
//							return 1
//						end if						
//					end if
//				else
//					select nvl(LWW_DAYS,0) into :ld_lwwopn from fb_lablww a,fb_lablwwperiod b where a.LLP_ID = b.LLP_ID and labour_id = :ls_labour_id and to_char(LLP_STARTDATE,'YYYY') = (to_number(to_char(sysdate,'YYYY')) - 1);
//					if sqlca.sqlcode = -1 then
//						messagebox('Error : While Getting LWW Opening Details',sqlca.sqlerrtext)
//						rollback using sqlca;
//						return 1
//					end if
//					select nvl(count(1),0) into :ld_lwwavail from fb_labourdailyattendance where LABOUR_ID = :ls_labour_id and KAMSUB_ID = (select KAMSUB_ID from fb_kamsubhead where nvl(KAMSUB_ACTIVE_IND,'Y') = 'Y' and KAMSUB_NAME = 'LWW') and
//												trunc(LDA_DATE) between to_date('01/01/'||to_char(sysdate,'YYYY'),'dd/mm/yyyy') and trunc(sysdate);
//					if sqlca.sqlcode = -1 then
//						messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
//						rollback using sqlca;
//						return 1
//					end if
//					if isnull(ld_lwwopn) then ld_lwwopn = 0;
//					if isnull(ld_lwwavail) then ld_lwwavail = 0;
//					if gs_garden_snm <> 'MK' then 
//						if (ld_lwwopn - ld_lwwavail) <= 0 then
//							messagebox('Warning !','LWW Balance Is Nil For This Employee, Pleae Check !!!')
//							return 1
//						end if
//					elseif gs_garden_snm = 'MK' and string(ld_dt,'YYYY') <> '2017' then 
//						if (ld_lwwopn - ld_lwwavail) <= 0 then
//							messagebox('Warning !','LWW Balance Is Nil For This Employee, Pleae Check !!!')
//							return 1
//						end if						
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
//		
//		ls_labour_id = dw_1.getitemstring(row,'labour_id')
//		select distinct 'x' into :ls_temp  from fb_kamsubhead 
//		where KAMSUB_ID = :ls_kam_id and KAMSUB_TYPE = 'NKAM' and trim(KAMSUB_NKAMTYPE) in ('SICKALLOWANCE','ABSENT','HOLIDAYNOPAY','SICKNOWAGES');
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Kanjari Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 100 then	
//			select nvl(INC_AMTPERDAY,0) into :ld_wages from fb_incentive 
//			where INC_REC_TYPE = 'L' and KAMSUB_ID = :ls_labour_id and trunc(:ld_dt) between INC_FRDT and nvl(INC_TODT,trunc(sysdate));
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode = 100 then
//				ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
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
//		else
//			ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)			
//		end if
//		dw_1.setitem(row,'lda_wages',ld_wages)
//		if ld_wages = 0 then
//			dw_1.setitem(row,'lda_elp',0)
//		end if
//	end if	
//	
//	if dwo.name = 'lda_daily_rateind' then
//		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
//		ld_dt = dw_1.getitemdatetime(row,'lda_date')
//		
//		if (gs_garden_snm='FB' or gs_garden_snm='MT') and cbx_4.checked = false and data = 'Y' then
//			
//			select kam.kamsub_afrate afrate into :ld_afrate from fb_kamsubhead kam
//			where trim(kam.kamsub_id) = :ls_kam_id and trunc(:ld_dt) between trunc(KAMSUB_FRDT) and trunc(nvl(KAMSUB_TODT,sysdate));
//			
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			end if	
//			if isnull(ld_afrate) then ld_afrate = 0;			
//			ld_wages = ld_afrate
//			dw_1.setitem(row,'lda_wages',ld_wages)
//			dw_1.setitem(row,'lda_elp',0)
//		elseif data = 'N' then
//			wf_cal_wages(dw_1.getitemnumber(row,'lda_mfj_count1'),dw_1.getitemnumber(row,'lda_mfj_count2'),dw_1.getitemnumber(row,'lda_mfj_count3'),row,dw_1.getitemnumber(row,'lda_status'))
//		end if
//	end if
//	
//	IF dwo.name = 'lda_prorataind'  then
//		ls_labour_id = dw_1.getitemstring(row,'labour_id')
//		ld_dt = dw_1.getitemdatetime(row,'lda_date')
//		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
//		ld_status = dw_1.getitemnumber(row,'lda_status')
//
//			select nvl(INC_AMTPERDAY,0) into :ld_wages from fb_incentive 
//			where INC_REC_TYPE = 'L' and KAMSUB_ID = :ls_labour_id and trunc(:ld_dt) between INC_FRDT and nvl(INC_TODT,trunc(sysdate));
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode = 100 then
//				//ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
//				wf_cal_wages(dw_1.getitemnumber(row,'lda_mfj_count1'),dw_1.getitemnumber(row,'lda_mfj_count2'),dw_1.getitemnumber(row,'lda_mfj_count3'),row,dw_1.getitemnumber(row,'lda_status'))
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
//			dw_1.setitem(row,'lda_wages',ld_wages)
//	end if	
//
//	if dwo.name = 'lda_status'  then
//		ld_status = double(data)
//		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
//		ls_labour_id = dw_1.getitemstring(row,'labour_id')
//		ld_dt = dw_1.getitemdatetime(row,'lda_date')
//		ls_labour_id = dw_1.getitemstring(row,'labour_id')
//		
//		if gs_garden_state = '03' then
//			if double(data) <> 0 and double(data) <> 1  and double(data) <> 0.50 then
//				messagebox('Invalid Status','Status Can Not Be (1/3, or 1/4), Please Check !!!')
//				return 1
//			end if
//		end if
//			
//		if upper(gs_loginuser) <> 'MCOTE' then
//			if double(data) > 1 then
//				messagebox('Invalid Status','Status Can Not Be Other Than (FULL, Half, 1/3, or 1/4), Please Check !!!')
//				return 1
//			end if
//		end if
//			
//		select nvl(INC_AMTPERDAY,0) into :ld_wages from fb_incentive 
//		where INC_REC_TYPE = 'L' and KAMSUB_ID = :ls_labour_id and trunc(:ld_dt) between INC_FRDT and nvl(INC_TODT,trunc(sysdate));
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Labour Incentive Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 100 then
//			ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
//			
//			select nvl(INC_AMTPERDAY,0) into :ld_kincentive from fb_incentive 
//			where INC_REC_TYPE = 'K' and KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(trunc(INC_TODT),trunc(sysdate));
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting Kamjari Incentive Details',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode = 0 then
//				if isnull(ld_kincentive) then ld_kincentive = 0;
//				ld_wages = ld_wages + ld_kincentive
//			end if				
//			
//		end if
//		dw_1.setitem(row,'lda_wages',ld_wages) 
//		if dw_1.getitemnumber(row,'lda_mfj_count1') > 0 then
////			ld_wagrtn = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
////			dw_1.setitem(row,'lda_wages',ld_wages)
//			if dw_1.getitemstring(row,'lda_taskind') = 'Y' then
//				wf_cal_wages(dw_1.getitemnumber(row,'lda_mfj_count1'),dw_1.getitemnumber(row,'lda_mfj_count2'),dw_1.getitemnumber(row,'lda_mfj_count3'),row,ld_status)
//			end if
//		end if
//	else
//		ld_status = getitemnumber(row,'lda_status')
//	end if	
//
////	if dwo.name = 'lda_sectionid1'  then
////		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
////		
////		select distinct 'x' into :ls_temp from 
////		(select KAMSUB_ID from FB_KAMSUBHEAD where KAMSUB_ID in
////					 (select distinct EACSUBHEAD_ID from FB_EXPENSEACSUBHEAD where EACHEAD_ID in ('SLEG0012','SLEG0013','SLEG0022','SLEG0024')) or KAMSUB_ID = 'ESUB0163')
////		where KAMSUB_ID = :ls_kam_id;
////		
////		if sqlca.sqlcode = -1 then
////			messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
////			rollback using sqlca;
////			return 1
////		elseif sqlca.sqlcode = 100 then
////			messagebox('Warning!','Section Not Required For This Type Of Kamjari, Please Check !!!')
////			setnull(ls_temp)
////			dw_1.setitem(row,'lda_sectionid1',ls_temp)
////			return 1
////		end if
////	end if	
//	
//	if dwo.name = 'lda_sectionid1' then
//		ls_sec1 = trim(data)
//		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
//		ls_secind = dw_1.getitemstring(row,'kamsub_secind') 
//		ld_dt = dw_1.getitemdatetime(row,'lda_date')
//		setnull(ls_temp)
//		dw_1.setitem(row,'confirm_ind','Y')	
//		select distinct SECTION_TYPE into :ls_temp from fb_section where SECTION_ID = :ls_sec1;
//		
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Section Type (1)',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		end if
//		if gs_garden_snm = 'MT' and dw_1.getitemnumber(row,'lda_wages') = 0 then
//			ls_labour_id = dw_1.getitemstring(row,'labour_id')
//			
//			select nvl(INC_AMTPERDAY,0) into :ld_wages from fb_incentive 
//			where INC_REC_TYPE = 'L' and KAMSUB_ID = :ls_labour_id and trunc(:ld_dt) between INC_FRDT and nvl(INC_TODT,trunc(sysdate));
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode = 100 then
//				ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
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
//			dw_1.setitem(row,'lda_wages',ld_wages)		
//		end if
////		if ls_secind = 'N' and ls_temp='S' and (not isnull(ls_sec1) or len(ls_sec1) > 0) then
////			messagebox('Warning!','Section Not Required For This Kamjari Id, Please Check !!!')
////			dw_1.setitem(row,'lda_sectionid1',ls_temp)
////			cb_3.enabled = false
////			return 1
////		end if
////		select nvl(KAMSUB_SECIND,'N') KAMSUB_SECIND, nvl(KAMSUB_MEASIND,'N') KAMSUB_MEASIND, nvl(KAMSUB_COSTCIND,'N') KAMSUB_COSTCIND
////		into :ls_secind,:ls_measureind,:ls_ccind
////		from fb_kamsubhead where KAMSUB_TODT is null and KAMSUB_ID = :ls_kam_id;
////		
////		if sqlca.sqlcode = -1 then
////			messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
////			rollback using sqlca;
////			return 1
////		elseif sqlca.sqlcode = 0 then
////			if ls_secind = 'N' and (not isnull(ls_sec1) or len(ls_sec1) > 0) then
////				messagebox('Warning!','Section Not Required For This Kamjari Id, Please Check !!!')
////				dw_1.setitem(row,'lda_sectionid1',ls_temp)
////				return 1
////			end if
////		end if
//		setnull(ls_temp)
//		if data = dw_1.getitemstring(row,'lda_sectionid2') or data = dw_1.getitemstring(row,'lda_sectionid3') then
//			messagebox('Warning!','Section ID 1,Section Id 2 And Section Id 3 Should Be Different, Please Check !!!')
//			dw_1.setitem(row,'lda_sectionid1',ls_temp)
//			return 1
//		end if
//	end if
//	
//	if dwo.name = 'lda_sectionid2' then
//		ls_sec2 = data
//		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
//		ls_secind = dw_1.getitemstring(row,'kamsub_secind') 
//		ld_dt = dw_1.getitemdatetime(row,'lda_date')
//		setnull(ls_temp)
//		
//		select distinct SECTION_TYPE into :ls_temp from fb_section where SECTION_ID = :ls_sec2;
//		
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Section Type (2) ',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		end if
//
////		if ls_secind = 'N' and ls_temp='S' and (not isnull(ls_sec2) or len(ls_sec2) > 0) then
////			messagebox('Warning!','Section Not Required For This Kamjari Id, Please Check !!!')
////			dw_1.setitem(row,'lda_sectionid2',ls_temp)
////			cb_3.enabled = false
////			return 1
////		end if
//		setnull(ls_temp)
//		if data = dw_1.getitemstring(row,'lda_sectionid1') or data = dw_1.getitemstring(row,'lda_sectionid3') then
//			messagebox('Warning!','Section ID 1,Section Id 2 And Section Id 3 Should Be Different, Please Check !!!')
//			dw_1.setitem(row,'lda_sectionid2',ls_temp)
//			return 1
//		end if
//	end if
//	
//	if dwo.name = 'lda_sectionid3' then
//		ls_sec3 = data
//		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
//		ls_secind = dw_1.getitemstring(row,'kamsub_secind') 
//		ld_dt = dw_1.getitemdatetime(row,'lda_date')
//		setnull(ls_temp)
//		
//		select distinct SECTION_TYPE into :ls_temp from fb_section where SECTION_ID = :ls_sec3;
//		
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Section Type (3) ',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		end if
////		if ls_secind = 'N' and  ls_temp='S' and (not isnull(ls_sec3) or len(ls_sec3) > 0) then
////			messagebox('Warning!','Section Not Required For This Kamjari Id, Please Check !!!')
////			dw_1.setitem(row,'lda_sectionid3',ls_temp)
////			cb_3.enabled = false
////			return 1
////		end if
//		setnull(ls_temp)
//		if data = dw_1.getitemstring(row,'lda_sectionid1') or data = dw_1.getitemstring(row,'lda_sectionid2') then
//			messagebox('Warning!','Section ID 1,Section Id 2 And Section Id 3 Should Be Different, Please Check !!!')
//			dw_1.setitem(row,'lda_sectionid3',ls_temp)
//			return 1
//		end if
//	end if
//
//	
//	if dwo.name = 'lda_mfj_count1' then		
//		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
//		ls_measureind = dw_1.getitemstring(row,'kamsub_measind')
//		ld_dt = dw_1.getitemdatetime(row,'lda_date')
//		ls_sec1 = dw_1.getitemstring(row,'lda_sectionid1')
//		ld_status = dw_1.getitemnumber(row,'lda_status')
//		ls_labour_id = dw_1.getitemstring(row,'labour_id')
//		//if isnull(ls_measureind) then ls_measureind = 'N';
//
//		ld_wagrtn = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
//		if gs_garden_snm <> 'MF' and gs_garden_snm <> 'GF' and (ls_kam_id = 'ESUB0163' or ls_kam_id = 'ESUB0434' or ls_kam_id = 'ESUB0435') then //= 'ESUB0163' then
//			if len(ls_sec1) > 0  or not isnull(ls_sec1) then
//				setnull(ls_temp)
//				
//				select distinct 'x' into :ls_temp	from fb_sectionpluckinground where trunc(SPR_DATE) = trunc(:ld_dt) and section_id = :ls_sec1;
//				
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				elseif sqlca.sqlcode = 100 then
//					messagebox('Warning!','Round Days Entry Not Done For The Section, Please Check !!!')
//					dw_1.setitem(row,'lda_sectionid1',ls_temp)
//					return 1
//				end if
//			end if
//		end if
//		
//		if ls_measureind = 'N' and (not isnull(data)  or double(data) <> 0) then
//			messagebox('Warning!','Measure Not Required For This Kamjari Id, Please Check !!!')
//			dw_1.setitem(row,'lda_mfj_count1',0)
//			cb_3.enabled = false
//			return 1
//		end if
//		
//		if gs_garden_snm='FB' and ls_emptype = 'LO' and cbx_4.checked = true then
//			 ld_m1 = double(data)
//			 ld_m2 = dw_1.getitemnumber(row,'lda_mfj_count2')
//			 ld_m3 = dw_1.getitemnumber(row,'lda_mfj_count3')
//			 if isnull(ld_m1) then ld_m1 = 0;
//			 if isnull(ld_m2) then ld_m2 = 0;
//			 if isnull(ld_m3) then ld_m3 = 0;
//			ld_measure = ld_m1 + ld_m2 + ld_m3
//			ld_wages = ld_measure * ld_wagrtn
//			dw_1.setitem(row,'lda_wages',ld_wages)
//		else		
//			if dw_1.getitemstring(row,'lda_taskind') = 'Y' then
//				wf_cal_wages(double(data),dw_1.getitemnumber(row,'lda_mfj_count2'),dw_1.getitemnumber(row,'lda_mfj_count3'),row,dw_1.getitemnumber(row,'lda_status'))
//			end if
//		end if
//		if (gs_garden_snm = 'KG') and ld_measure > 999 then
//			messagebox('Warning!','Measure 1 is in 3 Gigits, Please Check !!!')
//			return 1
//		end if
//		if (gs_garden_snm = 'DL') and ld_measure > 99 then
//			messagebox('Warning!','Measure 1 is in 3 Gigits, Please Check !!!')
//		end if
//		
//	end if 
//	
//	if dwo.name = 'lda_mfj_count2' then
//		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
//		ls_measureind = dw_1.getitemstring(row,'kamsub_measind')
//		ld_dt = dw_1.getitemdatetime(row,'lda_date')
//		ls_sec1 = dw_1.getitemstring(row,'lda_sectionid2')
//		ld_status = dw_1.getitemnumber(row,'lda_status')
//		ls_labour_id = dw_1.getitemstring(row,'labour_id')
//		
//		ld_wagrtn = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
//		if gs_garden_snm <> 'MF' and gs_garden_snm <> 'GF' and (ls_kam_id = 'ESUB0163' or ls_kam_id = 'ESUB0434' or ls_kam_id = 'ESUB0435') then
//			if len(ls_sec1) > 0  or not isnull(ls_sec1) then
//				setnull(ls_temp)
//				
//				select distinct 'x' into :ls_temp	from fb_sectionpluckinground where trunc(SPR_DATE) = trunc(:ld_dt) and section_id = :ls_sec1;
//				
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				elseif sqlca.sqlcode = 100 then
//					messagebox('Warning!','Round Days Entry Not Done For The Section, Please Check !!!')
//					dw_1.setitem(row,'lda_sectionid2',ls_temp)
//					return 1
//				end if
//			end if		
//		end if
//		
//		if ls_measureind = 'N' and (not isnull(data)  or double(data) <> 0) then
//			dw_1.setitem(row,'lda_mfj_count2',0)
//			cb_3.enabled = false
//			return 1
//		end if
//		if gs_garden_snm='FB' and ls_emptype = 'LO' and cbx_4.checked = true then
//			 ld_m1 = dw_1.getitemnumber(row,'lda_mfj_count1')
//			 ld_m2 = double(data)
//			 ld_m3 = dw_1.getitemnumber(row,'lda_mfj_count3')
//			 if isnull(ld_m1) then ld_m1 = 0;
//			 if isnull(ld_m2) then ld_m2 = 0;
//			 if isnull(ld_m3) then ld_m3 = 0;
//			ld_measure = ld_m1 + ld_m2 + ld_m3
//			ld_wages = ld_measure * ld_wagrtn
//			dw_1.setitem(row,'lda_wages',ld_wages)
//		else				
//			if dw_1.getitemstring(row,'lda_taskind') = 'Y' then
//				wf_cal_wages(dw_1.getitemnumber(row,'lda_mfj_count1'),double(data),dw_1.getitemnumber(row,'lda_mfj_count3'),row,dw_1.getitemnumber(row,'lda_status'))
//			end if
//		end if
//	end if
//	
//	if dwo.name = 'lda_mfj_count3' then
//		ls_kam_id = dw_1.getitemstring(row,'kamsub_id')
//		ls_measureind = dw_1.getitemstring(row,'kamsub_measind')
//		ld_dt = dw_1.getitemdatetime(row,'lda_date')
//		ls_sec1 = dw_1.getitemstring(row,'lda_sectionid3')
//		ld_status = dw_1.getitemnumber(row,'lda_status')
//		ls_labour_id = dw_1.getitemstring(row,'labour_id')
//		
//		ld_wagrtn = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
//		
//		if gs_garden_snm <> 'MF' and gs_garden_snm <> 'GF' and  (ls_kam_id = 'ESUB0163' or ls_kam_id = 'ESUB0434' or ls_kam_id = 'ESUB0435') then
//			if len(ls_sec1) > 0  or not isnull(ls_sec1) then
//				setnull(ls_temp)
//				
//				select distinct 'x' into :ls_temp	from fb_sectionpluckinground where trunc(SPR_DATE) = trunc(:ld_dt) and section_id = :ls_sec1;
//				
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				elseif sqlca.sqlcode = 100 then
//					messagebox('Warning!','Round Days Entry Not Done For The Section, Please Check !!!')
//					dw_1.setitem(row,'lda_sectionid3',ls_temp)
//					return 1
//				end if
//			end if		
//		end if
//		
//		if ls_measureind = 'N' and (not isnull(data)  or double(data) <> 0) then
//			dw_1.setitem(row,'lda_mfj_count3',0)
//			cb_3.enabled = false
//			return 1
//		end if
//		if gs_garden_snm='FB' and ls_emptype = 'LO' and cbx_4.checked = true then
//			 ld_m1 = dw_1.getitemnumber(row,'lda_mfj_count1')
//			 ld_m2 = dw_1.getitemnumber(row,'lda_mfj_count2')
//			 ld_m3 = double(data)
//			 if isnull(ld_m1) then ld_m1 = 0;
//			 if isnull(ld_m2) then ld_m2 = 0;
//			 if isnull(ld_m3) then ld_m3 = 0;
//			ld_measure = ld_m1 + ld_m2 + ld_m3
//			ld_wages = ld_measure * ld_wagrtn
//			dw_1.setitem(row,'lda_wages',ld_wages)
//		else				
//			if dw_1.getitemstring(row,'lda_taskind') = 'Y' then
//				wf_cal_wages(dw_1.getitemnumber(row,'lda_mfj_count1'),dw_1.getitemnumber(row,'lda_mfj_count2'),double(data),row,dw_1.getitemnumber(row,'lda_status'))
//			end if
//		end if
//	end if
//
//	dw_1.setitem(row,'lda_entry_by',gs_user)
//	dw_1.setitem(row,'lda_entry_dt',datetime(today()))
//	
//	if cbx_1.checked = true then
//		if dw_1.getrow() = dw_1.rowcount() and lb_neworder = true then
//			dw_1.insertrow(0)
//		end if
//	end if
//	cb_3.enabled = true
//end if
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

event itemfocuschanged;//if gs_garden_snm = 'MT' then
//	if dwo.name = 'kamsub_id'  and lb_neworder = true then
//		dw_1.setitem(row,'lda_elp',0)
//		ls_kam_id = trim(dw_1.getitemstring(row,'kamsub_id'))
//		ld_status = dw_1.getitemnumber(row,'lda_status')
//		ll_paybook = dw_1.getitemnumber(row,'ls_id')
//		ld_dt = dw_1.getitemdatetime(row,'lda_date')
//		ls_lwwind = dw_1.getitemstring(row,'lda_lwwind')
//		ls_JUNGLIFOOT_ind = dw_1.getitemstring(row,'lda_mfj_junglifoot')
//		dw_1.setitem(row,'confirm_ind','Y')
////		dwc_section1.SetFilter ("string(spr_date,'dd/mm/yyyy') = '"+string(ld_dt,'dd/mm/yyyy')+"'")
////		dwc_section1.settransobject(sqlca)
////		dwc_section1.filter()
////		dwc_section2.SetFilter ("string(spr_date,'dd/mm/yyyy') = '"+string(ld_dt,'dd/mm/yyyy')+"'")
////		dwc_section2.settransobject(sqlca)	
////		dwc_section2.retrieve()
////		dwc_section3.SetFilter ("string(spr_date,'dd/mm/yyyy') = '"+string(ld_dt,'dd/mm/yyyy')+"'")
////		dwc_section3.settransobject(sqlca)	
////		dwc_section3.retrieve()		
//		
//		ld_lwwopn = wf_lwwopening(ls_labour_id,ll_paybook,ld_dt)
//	//	messagebox('opn',string(ld_lwwopn))
//		
//		// Checking Employee Retirement Age
//		setnull(ls_temp);setnull(ll_temp);
////		dw_1.setitem(row,'lda_sectionid1',ls_temp)
////		dw_1.setitem(row,'lda_sectionid2',ls_temp)
////		dw_1.setitem(row,'lda_sectionid3',ls_temp)
//		dw_1.setitem(row,'lda_mfj_count1',ll_temp)
//		dw_1.setitem(row,'lda_mfj_count2',ll_temp)
//		dw_1.setitem(row,'lda_mfj_count3',ll_temp)
//		ld_labage = 0;
//
//		select FIELD_ID,round((trunc(sysdate) - trunc(EMP_DOB))/365), ((:ld_dt - emp_dob) /365), emp_type, ls_id into :ls_div,:ll_year,:ld_labage, :ls_emptype, :ll_paybook  from fb_employee where emp_id = :ls_labour_id; 
//		
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Employee Age',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		end if
//		
//		select nvl(KAMSUB_SECIND,'N') KAMSUB_SECIND, nvl(KAMSUB_MEASIND,'N') KAMSUB_MEASIND, nvl(KAMSUB_COSTCIND,'N') KAMSUB_COSTCIND, KAMSUB_NAME ,trim(kamsub_nkamtype),trim(KAMSUB_TYPE)
//		into :ls_secind,:ls_measureind,:ls_ccind,:ls_kam_sname,:ls_nkam_type,:ls_kamtype
//		from fb_kamsubhead where KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(KAMSUB_FRDT) and trunc(nvl(KAMSUB_TODT,sysdate));
//
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Section, Measure & Costcenter Ind',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		end if
//
//		dw_1.setitem(row,'kamsub_secind',ls_secind) 
//		dw_1.setitem(row,'kamsub_measind',ls_measureind)
//		dw_1.setitem(row,'kamsub_costcind',ls_ccind)
//
//		if ls_kamtype ='OKAM' or ls_kamtype = 'NKAM' then
//
//			select section_id into :ls_sec1 from fb_section  where substr(SECTION_NAME,1,1)||'KAM' = :ls_kamtype and FIELD_ID=:ls_div and section_type='C';
//			
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting Section From Section Master',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode=0 then
//				dw_1.setitem(row,'lda_sectionid1',ls_sec1)
//			end if
//
//		end if
//		
//		select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0))
//		into :ll_adoleage, :ll_child
//		from fb_param_detail 
//		where pd_doc_type in ('CHILDAGE','ADOLEAGE') and
//				 trunc(:ld_dt) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));
//	
//		if sqlca.sqlcode = -1 then
//			messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
//			return 1
//		end if;
//
//		
//// 		if gs_garden_snm = 'FB' then
////		
////			If ld_labage <= ll_child Then //(144 months=12 years)
////				select distinct 'x' into :ls_temp	from fb_task_fulbari 
////				where TASK_EMPTYPE = :ls_emptype and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and trunc(:ld_dt) between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'CHILD';
////				if sqlca.sqlcode = -1 then
////					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
////					rollback using sqlca;
////					return 1
////				elseif sqlca.sqlcode = 0 then
////					if gs_garden_snm = 'MB' and cbx_2.checked = true then
////						dw_1.setitem(row,'lda_taskind','Y')
////						dw_1.modify("lda_taskind.protect = '0'")
////					elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
////						dw_1.setitem(row,'lda_taskind','N')
////						dw_1.modify("lda_taskind.protect = '1'")
////					elseif gs_garden_snm <> 'MB' then
////						dw_1.setitem(row,'lda_taskind','Y')
////						dw_1.modify("lda_taskind.protect = '0'")					
////					end if
////				elseif sqlca.sqlcode = 100 then
////					dw_1.setitem(row,'lda_taskind','N')
////					dw_1.modify("lda_taskind.protect = '1'")
////				end if
////			elseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
////				select distinct 'x' into :ls_temp	from fb_task_fulbari  
////				where TASK_EMPTYPE = :ls_emptype and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and trunc(:ld_dt)  between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADOLE';
////				if sqlca.sqlcode = -1 then
////					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
////					rollback using sqlca;
////					return 1
////				elseif sqlca.sqlcode = 0 then
////					if gs_garden_snm = 'MB' and cbx_2.checked = true then
////						dw_1.setitem(row,'lda_taskind','Y')
////						dw_1.modify("lda_taskind.protect = '0'")
////					elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
////						dw_1.setitem(row,'lda_taskind','N')
////						dw_1.modify("lda_taskind.protect = '1'")
////					elseif gs_garden_snm <> 'MB' then
////						dw_1.setitem(row,'lda_taskind','Y')
////						dw_1.modify("lda_taskind.protect = '0'")					
////					end if				
////				elseif sqlca.sqlcode = 100 then
////					dw_1.setitem(row,'lda_taskind','N')
////					dw_1.modify("lda_taskind.protect = '1'")
////				end if 		
////			elseIf ld_labage > ll_adoleage then
////				select distinct 'x' into :ls_temp	from fb_task_fulbari 
////				where TASK_EMPTYPE = :ls_emptype and TASK_PAYBOOK = :ll_paybook and TASK_ID = :ls_kam_id and trunc(:ld_dt)  between TASK_DT_FROM and TASK_DT_TO and TASK_TYPE = 'ADULT' ;
////				if sqlca.sqlcode = -1 then
////					messagebox('Error : While Getting Labour Task Rate Detail',sqlca.sqlerrtext)
////					rollback using sqlca;
////					return 1
////				elseif sqlca.sqlcode = 0 then
////					if gs_garden_snm = 'MB' and cbx_2.checked = true then
////						dw_1.setitem(row,'lda_taskind','Y')
////						dw_1.modify("lda_taskind.protect = '0'")
////					elseif gs_garden_snm = 'MB' and cbx_2.checked = false then
////						dw_1.setitem(row,'lda_taskind','N')
////						dw_1.modify("lda_taskind.protect = '1'")
////					elseif gs_garden_snm <> 'MB' then
////						dw_1.setitem(row,'lda_taskind','Y')
////						dw_1.modify("lda_taskind.protect = '0'")					
////					end if				
////				elseif sqlca.sqlcode = 100 then
////					dw_1.setitem(row,'lda_taskind','N')
////					dw_1.modify("lda_taskind.protect = '1'")
////				end if 
////			end if
////		else  //if gs_garden_snm = 'FB' then
//			If ld_labage <= ll_child Then //(144 months=12 years)
//				select distinct 'x' into :ls_temp	from fb_task 
//				where TASK_ID = :ls_kam_id and trunc(:ld_dt) between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'CHILD' and
//						(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N')));
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
//				select distinct 'x' into :ls_temp	from fb_task  
//				where TASK_ID = :ls_kam_id and trunc(:ld_dt)  between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'ADOLE' and
//						(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
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
//				select distinct 'x' into :ls_temp	from fb_task 
//				where TASK_ID = :ls_kam_id and trunc(:ld_dt)  between trunc(TASK_DT_FROM) and trunc(nvl(TASK_DT_TO,sysdate)) and TASK_TYPE = 'ADULT' and
//						(:gs_garden_snm <> 'MT' or (:gs_garden_snm ='MT' and nvl(task_fieldid,'N') = nvl(:ls_div,'N') and nvl(task_pruntype,'N') = decode(:ls_JUNGLIFOOT_ind,'J','UNPRUN','F','PRUN','N'))) ;
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
////		end if
////		if isnull(ll_year) then ll_year = 0
////		ll_retage = 0; 
////		select nvl(PD_VALUE,0) into :ll_retage from fb_param_detail where PD_DOC_TYPE = 'RETIREMENT' and PD_PERIOD_TO is null;
////		if sqlca.sqlcode = -1 then
////			messagebox('Error : While Getting Retirement Age',sqlca.sqlerrtext)
////			rollback using sqlca;
////			return 1
////		end if
////		if isnull(ll_retage) then ll_retage = 0
////		
////		if ld_labage >= ll_retage then
////			messagebox('Warning!1','Employee ('+ls_labour_id+') Has Reached Retirement Age, Please Check !!!')
////			//return 1
////		end if
//		
//		// Checking Employee Retirement Age
//		ls_labour_id = dw_1.getitemstring(row,'labour_id')
//		select distinct 'x' into :ls_temp from fb_kamsubhead,fb_expenseacsubhead 
//		where kamsub_id = eacsubhead_id and nvl(KAMSUB_ACTIVE_IND,'Y') = 'Y' and KAMSUB_TODT is null and KAMSUB_ID = :ls_kam_id;
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 100 then
//			messagebox('Warning!','Invalid Kamjari ID, Please Check !!!')
//			return 1
//		end if
//		
//			ld_sick = 0;ld_sl = 0;
//			if trim(ls_nkam_type) = 'SICKALLOWANCE' then
//					select nvl(count(1),0) into :ld_sick from fb_labourdailyattendance where LABOUR_ID = :ls_labour_id and KAMSUB_ID = (select KAMSUB_ID from fb_kamsubhead where nvl(KAMSUB_ACTIVE_IND,'Y') = 'Y' and KAMSUB_NKAMTYPE = 'SICKALLOWANCE') and
//											trunc(LDA_DATE) between to_date('01/01/'||to_char(sysdate,'YYYY'),'dd/mm/yyyy') and trunc(:ld_dt);
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				end if
//				if isnull(ld_sick) then ld_sick = 0;
//				
//				select nvl(pd_value,0) into :ld_sl from fb_param_detail 
//				where pd_doc_type = 'SICKALLOWANCE' and trunc(:ld_dt) between trunc(PD_PERIOD_FROM) and nvl(PD_PERIOD_TO,trunc(sysdate));
//	
//				if sqlca.sqlcode = -1 then
//					messagebox('SQL ERROR: During Parametere Getting Sick Leave Days ',sqlca.sqlerrtext)
//					return 1
//				end if;
//				
//				if isnull(ld_sl) then ld_sl = 0;
//				
//				if ld_sick >= ld_sl then
//					messagebox('Warning !1','This Employee ('+ls_labour_id+') Has Already Availed ' + string(ld_sl) +' Days Sick leave This Year, Pleae Check !!!')
//					return 1
//				end if
//			end if
////			
////			if trim(ls_kam_sname) = 'LWW' then
////				if ls_lwwind = 'Y' then
////				// as per LWW calculation opening should come
////					ld_lwwopn = wf_lwwopening(ls_labour_id,ll_paybook,ld_dt)
////					select nvl(count(1),0) into :ld_lwwavail from fb_labourdailyattendance where LABOUR_ID = :ls_labour_id and KAMSUB_ID = (select KAMSUB_ID from fb_kamsubhead where KAMSUB_NAME = 'LWW') and
////												trunc(LDA_DATE) between to_date('01/01/'||to_char(sysdate,'YYYY'),'dd/mm/yyyy') and trunc(sysdate) and lda_lwwind = 'Y';
////					if sqlca.sqlcode = -1 then
////						messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
////						rollback using sqlca;
////						return 1
////					end if
////					if isnull(ld_lwwopn) then ld_lwwopn = 0;
////					if isnull(ld_lwwavail) then ld_lwwavail = 0;
////					if (ld_lwwopn - ld_lwwavail) <= 0 then
////						messagebox('Warning !','LWW Balance Is Nil For This Employee, Pleae Check !!!')
////						return 1
////					end if
////
////				else
////					select nvl(LWW_DAYS,0) into :ld_lwwopn from fb_lablww a,fb_lablwwperiod b where a.LLP_ID = b.LLP_ID and labour_id = :ls_labour_id and to_char(LLP_STARTDATE,'YYYY') = (to_number(to_char(sysdate,'YYYY')) - 1);
////					if sqlca.sqlcode = -1 then
////						messagebox('Error : While Getting LWW Opening Details',sqlca.sqlerrtext)
////						rollback using sqlca;
////						return 1
////					end if
////					select nvl(count(1),0) into :ld_lwwavail from fb_labourdailyattendance where LABOUR_ID = :ls_labour_id and KAMSUB_ID = (select KAMSUB_ID from fb_kamsubhead where KAMSUB_NAME = 'LWW') and
////												trunc(LDA_DATE) between to_date('01/01/'||to_char(sysdate,'YYYY'),'dd/mm/yyyy') and trunc(sysdate);
////					if sqlca.sqlcode = -1 then
////						messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
////						rollback using sqlca;
////						return 1
////					end if
////					if isnull(ld_lwwopn) then ld_lwwopn = 0;
////					if isnull(ld_lwwavail) then ld_lwwavail = 0;
////					if (ld_lwwopn - ld_lwwavail) <= 0 then
////						messagebox('Warning !','LWW Balance Is Nil For This Employee, Pleae Check !!!')
////						return 1
////					end if
////				end if
////			end if
////
////		if (trim(ls_nkam_type) = 'MATERNITY' or trim(ls_nkam_type) = 'SICKALLOWANCE'  or trim(ls_nkam_type) = 'SICKNOWAGES')  then
////			dw_1.setitem(row,'inout_ind','Y')
////			dw_1.setitem(row,'lda_nature','OUT')
////		else
////			setnull(ls_temp)
////			dw_1.setitem(row,'inout_ind','N')
////			dw_1.setitem(row,'lda_nature',ls_temp)
////		end if
//		
//		ls_labour_id = dw_1.getitemstring(row,'labour_id')
//
//		select nvl(INC_AMTPERDAY,0) into :ld_wages from fb_incentive 
//		where INC_REC_TYPE = 'L' and KAMSUB_ID = :ls_labour_id and trunc(:ld_dt) between INC_FRDT and nvl(INC_TODT,trunc(sysdate));
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting LWW Availed Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 100 then
//			ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id,ld_status,row)
//			
//			select nvl(INC_AMTPERDAY,0) into :ld_kincentive from fb_incentive 
//			where INC_REC_TYPE = 'K' and KAMSUB_ID = :ls_kam_id and trunc(:ld_dt) between trunc(INC_FRDT) and nvl(trunc(INC_TODT),trunc(sysdate));
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting Kamjari Incentive Details',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode = 0 then
//				if isnull(ld_kincentive) then ld_kincentive = 0;
//				ld_wages = ld_wages + ld_kincentive
//			end if				
//			
//		end if
//		dw_1.setitem(row,'lda_wages',ld_wages)
//		if ld_wages = 0 then
//			dw_1.setitem(row,'lda_elp',0)
//		end if
//	end if
//end if
end event

