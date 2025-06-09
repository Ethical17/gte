$PBExportHeader$w_gtelaf004.srw
forward
global type w_gtelaf004 from window
end type
type em_1 from editmask within w_gtelaf004
end type
type cb_2 from commandbutton within w_gtelaf004
end type
type cb_1 from commandbutton within w_gtelaf004
end type
type st_1 from statictext within w_gtelaf004
end type
end forward

global type w_gtelaf004 from window
integer width = 1810
integer height = 1272
boolean titlebar = true
string title = "(w_gtelaf004) Process-Holiday"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
boolean center = true
em_1 em_1
cb_2 cb_2
cb_1 cb_1
st_1 st_1
end type
global w_gtelaf004 w_gtelaf004

type variables
//string ls_temp,ls_temp1,ls_frdt,ls_chklwf, ls_lwwid,ls_emp_id, ls_kam,ls_abkam
string ls_hd_dt,ls_hd_pdt,ls_hd_ndt,ls_hp_paidind,ls_lwwid,ls_labour_id,ls_div,ls_emp_ty,ls_sex,ls_cam_ind,ls_count,ls_jobid,ls_kam_id,ls_kamtype,ls_sec1,ls_election
string ls_temp,ls_pb,ls_pb2
//double ld_lwf, ld_subs
long ll_user_level,ll_child,ll_adoleage,ll_payid, ll_temp
double ld_labage,ld_wages, ld_tot,ld_tot1
datetime ld_frdt,ld_pwkdt,ld_nwkdt
end variables

forward prototypes
public function integer wf_saveactivitydaily (string fs_date, string fs_labourid, string fd_kamid, string fs_secid, double fd_mandays, double fd_wages, double fd_measure, string fs_oldnew_ind, string fs_cam_ind, string fs_emp_ty, string fs_sex)
public function double wf_kamjari_rate (string fs_kamid, string fs_emp_age, string fs_date)
end prototypes

public function integer wf_saveactivitydaily (string fs_date, string fs_labourid, string fd_kamid, string fs_secid, double fd_mandays, double fd_wages, double fd_measure, string fs_oldnew_ind, string fs_cam_ind, string fs_emp_ty, string fs_sex);long ll_last
string ls_taskdate_id
ll_last=0

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
			return 1
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
			return 1
		end if
		
		update fb_taskactivemeasurement set 	 TASK_PMACOUNTTODAYTY = nvl(TASK_PMACOUNTTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
															 TASK_PFACOUNTTODAYTY = nvl(TASK_PFACOUNTTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_TMACOUNTTODAYTY = nvl(TASK_TMACOUNTTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0), 
															 TASK_TFACOUNTTODAYTY = nvl(TASK_TFACOUNTTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_OMACOUNTTODAYTY = nvl(TASK_OMACOUNTTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_OFACOUNTTODAYTY = nvl(TASK_OFACOUNTTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AA',nvl(:fd_measure,0),0),0),0),
															 TASK_PMADCOUNTTODAYTY = nvl(TASK_PMADCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_PFADCOUNTTODAYTY = nvl(TASK_PFADCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_TMADCOUNTTODAYTY = nvl(TASK_TMADCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_TFADCOUNTTODAYTY = nvl(TASK_TFADCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
															 TASK_OMADCOUNTTODAYTY = nvl(TASK_OMADCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0), 
															 TASK_OFADCOUNTTODAYTY = nvl(TASK_OFADCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'AD',nvl(:fd_measure,0),0),0),0),
															 TASK_PMCCOUNTTODAYTY = nvl(TASK_PMCCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
															 TASK_PFCCOUNTTODAYTY = nvl(TASK_PFCCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LP',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0),
															 TASK_TMCCOUNTTODAYTY = nvl(TASK_TMCCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
															 TASK_TFCCOUNTTODAYTY = nvl(TASK_TFCCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LT',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0), 
															 TASK_OMCCOUNTTODAYTY = nvl(TASK_OMCCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'M',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0),
															 TASK_OFCCOUNTTODAYTY  = nvl(TASK_OFCCOUNTTODAYTY,0) + decode(:fs_emp_ty,'LO',decode(:fs_sex,'F',decode(:fs_cam_ind,'CH',nvl(:fd_measure,0),0),0),0)
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
			ls_taskdate_id = 'TASKDATE'+string(ll_last,'0000000000')
		
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
		values(:fd_kamid,to_date(:fs_date,'dd/mm/yyyy'),:ls_taskdate_id,
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
		values(:ls_taskdate_id,
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
			return 1
		end if
		
	end if
//	commit using sqlca;
end if
return 1
end function

public function double wf_kamjari_rate (string fs_kamid, string fs_emp_age, string fs_date);double ld_rate

select nvl(decode(:fs_emp_age,'AA',kamsub_afrate,'AD',kamsub_adfrate,'CH',kamsub_cfrate,0),0) into :ld_rate 
 from fb_kamsubhead 
where trim(kamsub_id) = :fs_kamid and to_date(:fs_date,'dd/mm/yyyy') between trunc(KAMSUB_FRDT) and trunc(nvl(KAMSUB_TODT,sysdate));

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
	rollback using sqlca;
	return -1
elseif sqlca.sqlcode =100 then
	ld_rate=0
end if

if isnull(ld_rate) then ld_rate=0

return  ld_rate
end function

on w_gtelaf004.create
this.em_1=create em_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.Control[]={this.em_1,&
this.cb_2,&
this.cb_1,&
this.st_1}
end on

on w_gtelaf004.destroy
destroy(this.em_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
end on

event open;////if f_openwindow(dw_1) = -1 then	
////	close(this)
////	return 1
////end if
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if
//
//declare c1 cursor for
//select distinct FH_DATE from fb_holiday where nvl(FH_ACTIVE_IND,'N') = 'Y' order by FH_DATE;
//
//open c1;
//
//if sqlca.sqlcode = -1 then 
//	messagebox('Error At Cursor','Error During Opening Cursor');
//	return 1;
//else
//	setnull(ld_frdt);
//	fetch c1 into :ld_frdt;	
//	do while sqlca.sqlcode <> 100 
//	
//		ddlb_1.additem(string(ld_frdt,'dd/mm/yyyy'));
//	
//		setnull(ld_frdt);
//		fetch c1 into :ld_frdt;	
//	loop
//	close c1;
//end if;
//
//this.tag = Message.StringParm
//ll_user_level = long(this.tag)
//
////if ll_user_level = 3 then
////	cb_1.enabled = false
////end if
//
end event

type em_1 from editmask within w_gtelaf004
integer x = 695
integer y = 236
integer width = 411
integer height = 80
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

event modified;ls_hd_dt = trim(em_1.text)

select distinct 'X' into :ls_temp  from fb_holiday where fh_date = to_date(:ls_hd_dt,'dd/mm/yyyy') ;

if sqlca.sqlcode = -1 then 
	messagebox('Error','Error While Checking Holiday');
	return 1;
elseif sqlca.sqlcode = 100 then 
	messagebox('Warning','No such Holiday');
	return 1;
end if
end event

type cb_2 from commandbutton within w_gtelaf004
integer x = 837
integer y = 612
integer width = 311
integer height = 112
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

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_gtelaf004
integer x = 389
integer y = 612
integer width = 448
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Holiday Process"
boolean default = true
end type

event clicked;ls_hd_dt = trim(em_1.text)

if isnull(ls_hd_dt) or len(ls_hd_dt) = 0  then 
	messagebox('Error At Date','Please Select A Holiday Date, Please Check !!!')
	return 1
end if;

//messagebox('Check1','ls_hd_dt'+ls_hd_dt)

select distinct  FH_PWK_DATE, FH_NWK_DATE into :ld_pwkdt,:ld_nwkdt from fb_holiday where fh_date = to_date(:ls_hd_dt,'dd/mm/yyyy') ;
if sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Select Holiday Previous/Next day selection ',sqlca.sqlerrtext)
	return 1
end if;

//messagebox('Check2','ld_pwkdt  '+ string(ld_pwkdt,'dd/mm/yyyy') +  '  ld_nwkdt ' + string(ld_nwkdt,'dd/mm/yyyy'))


select sum(nvl(totemp,0) - nvl(enteredlabour,0)) Balance into :ld_tot1
from (select ls_id, count(emp_id) totemp from fb_employee where ls_id is not null and emp_active ='1' and EMP_JDATE <= trunc(:ld_pwkdt) - 1 and emp_type in ('LP','LT','LO') group by ls_id) a, 
        (select ls_id, count(labour_id) enteredlabour from fb_labourdailyattendance,(select * from fb_employee where EMP_JDATE <= trunc(:ld_pwkdt) - 1 and emp_type in ('LP','LT','LO')) 
         where ls_id is not null and emp_id = labour_id(+) and emp_active ='1' and trunc(lda_date) = trunc(:ld_pwkdt) 
        group by ls_id) b, fb_laboursheet c
where a.ls_id = b.ls_id(+) and a.ls_id = c.ls_id and LS_ACTIVE_IND = 'Y' ;

if sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Absent All Run Checking ',sqlca.sqlerrtext)
	return 1
end if;

//messagebox('Check3','ld_tot1  '+ string(ld_tot1) )

select sum(nvl(totemp,0) - nvl(enteredlabour,0)) Balance into :ld_tot
from (select ls_id, count(emp_id) totemp from fb_employee where ls_id is not null and emp_active ='1' and EMP_JDATE <= trunc(:ld_nwkdt) - 1 and emp_type in ('LP','LT','LO') group by ls_id) a, 
        (select ls_id, count(labour_id) enteredlabour from fb_labourdailyattendance,(select * from fb_employee where EMP_JDATE <= trunc(:ld_nwkdt) - 1 and emp_type in ('LP','LT','LO')) 
        where ls_id is not null and emp_id = labour_id(+) and emp_active ='1' and trunc(lda_date) = trunc(:ld_nwkdt) 
        group by ls_id) b, fb_laboursheet c
where a.ls_id = b.ls_id(+) and a.ls_id = c.ls_id and LS_ACTIVE_IND = 'Y';

if sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Absent All Run Checking ',sqlca.sqlerrtext)
	return 1
end if;

//messagebox('Check4','ld_tot  '+ string(ld_tot) )

if ((ld_tot1 > 0) or (ld_tot > 0)) then
	messagebox("Absent ALL Alert",'Absent ALL Not Run For Day Before or After The Holiday, Please Check !!!')
	return 1
end if

declare c2 cursor for
select ls_id from fb_laboursheet where nvl(LS_HWPFLAG,0) = 0;

open c2;
if sqlca.sqlcode = -1 then
	messagebox('Error occured while opening cursor C2',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1;
elseif sqlca.sqlcode = 0 then
	fetch c2 into :ls_pb;
	do while sqlca.sqlcode <> 100
		ls_pb2 = ls_pb2 + ls_pb + ', '
		fetch c2 into :ls_pb;
	loop
end if
close c2;

if len(ls_pb2) > 0 then
	ls_pb2 = left(ls_pb2,len(ls_pb2)-2)
	ls_pb2 = 'Following paybooks are not getting paid holiday :- '+ls_pb2+'. '
end if


IF MessageBox("Holiday Alert",+ls_pb2+' Do You Want To Process The Holiday  ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

SetPointer(Hourglass!);

	declare p2 procedure for up_labour_Holiday(:ls_hd_dt,:gs_user,:gs_garden_snm,:gs_gstn_stcd);
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error: During Procedure Declare of up_labour_Holiday',sqlca.sqlerrtext)					
			return 1
		end if

		execute p2;
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error: During Procedure Execute of up_labour_Holiday',sqlca.sqlerrtext)
			return 1
		end if
	
setpointer(arrow!)	
Messagebox('Information !','Holiday Process Completed !!!')
end if


end event

type st_1 from statictext within w_gtelaf004
integer x = 279
integer y = 252
integer width = 411
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Holiday Date :"
alignment alignment = right!
boolean focusrectangle = false
end type

