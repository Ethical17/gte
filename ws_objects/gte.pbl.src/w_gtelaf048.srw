$PBExportHeader$w_gtelaf048.srw
forward
global type w_gtelaf048 from window
end type
type st_10 from statictext within w_gtelaf048
end type
type dp_1 from datepicker within w_gtelaf048
end type
type st_9 from statictext within w_gtelaf048
end type
type st_8 from statictext within w_gtelaf048
end type
type st_7 from statictext within w_gtelaf048
end type
type st_6 from statictext within w_gtelaf048
end type
type st_5 from statictext within w_gtelaf048
end type
type st_4 from statictext within w_gtelaf048
end type
type st_3 from statictext within w_gtelaf048
end type
type st_2 from statictext within w_gtelaf048
end type
type cb_2 from commandbutton within w_gtelaf048
end type
type cb_1 from commandbutton within w_gtelaf048
end type
type st_1 from statictext within w_gtelaf048
end type
type em_1 from editmask within w_gtelaf048
end type
type em_2 from editmask within w_gtelaf048
end type
end forward

global type w_gtelaf048 from window
integer width = 1609
integer height = 1164
boolean titlebar = true
string title = "(w_gtelaf048) Ration Ratio Updation"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
boolean center = true
st_10 st_10
dp_1 dp_1
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
cb_2 cb_2
cb_1 cb_1
st_1 st_1
em_1 em_1
em_2 em_2
end type
global w_gtelaf048 w_gtelaf048

type variables
string is_adultallow,is_childallallow, ls_ration_alw,ls_temp, ls_tmp2
long ll_user_level
double id_ration, id_totricequan,id_totattaquan,id_lmajattawt,id_lmajricewt,id_lmajattaprice,id_lmajriceprice,id_minworkdays, id_ldepmajattawt,id_ldepmajricewt,id_ldepmajattaprice,id_ldepmajriceprice, &
            id_lminattawt,id_lminricewt,id_lminattaprice,id_lminriceprice,id_ldepminattawt,id_ldepminricewt, id_ldepminattaprice,id_ldepminriceprice,id_labricewt,id_labattawt,id_no_lab_depminor,id_no_lab_depmajor, &
		 id_elp_cf ,id_elp,id_penalty,id_elp_bf,id_netpayable,ld_labage
end variables

forward prototypes
public function double wf_calculate_ration (string fs_labour, string fs_lab_ty, string fs_lab_marital, double fd_attndays, string fs_emp_sex, string fs_start_dt, string fs_lww_id)
public function integer wf_elpcal (string fs_labour_id, string fs_fr_dt, string fs_to_dt, string fs_lrw_id)
public function double wf_emp_calration (string fs_labour, string fs_lab_ty, string fs_lab_marital, double fd_attndays, string fs_emp_sex, string fs_start_dt, string fs_lww_id)
end prototypes

public function double wf_calculate_ration (string fs_labour, string fs_lab_ty, string fs_lab_marital, double fd_attndays, string fs_emp_sex, string fs_start_dt, string fs_lww_id);Double ld_rationprice ,ld_msp_attndays,ld_mindaysmspouse,ld_noy
long ll_nochild 
string ls_childcur_ind,ls_msp_ty,ls_msp_field,ls_major_dep,ls_rcno
string ls_spouse,ls_mchild,ls_wsister,ls_umsister,ls_wmother,ls_umgirl
long ll_mstage,ll_wsage,ll_sage,ll_minorage,ll_nodep

  ll_nochild  = 0

  id_labricewt=0;id_labattawt=0;id_no_lab_depminor=0;id_no_lab_depmajor=0 

  ld_rationprice = 0; setnull(ls_rcno);
  
  select RP_SPOUSE_IND, RP_CH_IND, rp_major_dpind,nvl(RP_CH_STARTAGE,0), nvl(RP_CH_WSCH_AGE,0), nvl(RP_CH_SCH_AGE,0), nvl(RP_MINOR_DEPAGE,0), nvl(RP_NOOF_DEP,0),RP_WIDOW_SISTER, RP_UNMARRIED_SISTER, RP_WIDOW_MOTHER, nvl(rp_um_fch,'N')
  into :ls_spouse,:ls_mchild,:ls_major_dep,:ll_mstage,:ll_wsage,:ll_sage,:ll_minorage,:ll_nodep,:ls_wsister,:ls_umsister,:ls_wmother,:ls_umgirl
  from fb_rationparam where RP_EMPTYPE = :fs_lab_ty and to_date(:fs_start_dt,'dd/mm/yyyy') between RP_PERIOD_FROM and nvl(RP_PERIOD_TO,trunc(sysdate));

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Ration Parameter Select : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
end if;


//				select sum(decode(trim(lrc_majorminorflag),'MAJOR',lrc_attawt,0)),sum(decode(trim(lrc_majorminorflag),'MAJOR',lrc_ricewt,0)),
//						sum(decode(trim(lrc_majorminorflag),'MAJOR',lrc_attarate,0)),sum(decode(trim(lrc_majorminorflag),'MAJOR',lrc_ricerate,0)),
//						sum(decode(trim(lrc_majorminorflag),'MAJOR',lrc_minworkdays,0)),
//						max(decode(trim(lrc_majorminorflag),'MAJOR',lrc_adultallow,null)),max(decode(trim(lrc_majorminorflag),'MAJOR',lrc_childallallow,null)),
//						sum(decode(trim(lrc_majorminorflag),'DEPMAJ',lrc_attawt,0)),sum(decode(trim(lrc_majorminorflag),'DEPMAJ',lrc_ricewt,0)),
//						sum(decode(trim(lrc_majorminorflag),'DEPMAJ',lrc_attarate,0)),sum(decode(trim(lrc_majorminorflag),'DEPMAJ',lrc_ricerate,0)),
//						sum(decode(trim(lrc_majorminorflag),'MINOR',lrc_attawt,0)),sum(decode(trim(lrc_majorminorflag),'MINOR',lrc_ricewt,0)),
//						sum(decode(trim(lrc_majorminorflag),'MINOR',lrc_attarate,0)),sum(decode(trim(lrc_majorminorflag),'MINOR',lrc_ricerate,0)),
//						sum(decode(trim(lrc_majorminorflag),'DEPMIN',lrc_attawt,0)),sum(decode(trim(lrc_majorminorflag),'DEPMIN',lrc_ricewt,0)),
//						sum(decode(trim(lrc_majorminorflag),'DEPMIN',lrc_attarate,0)),sum(decode(trim(lrc_majorminorflag),'DEPMIN',lrc_ricerate,0))
//					into :id_lmajattawt,:id_lmajricewt,:id_lmajattaprice,:id_lmajriceprice,:id_minworkdays,:is_adultallow,:is_childallallow,
//						  :id_ldepmajattawt,:id_ldepmajricewt,:id_ldepmajattaprice,:id_ldepmajriceprice,
//						  :id_lminattawt,:id_lminricewt,:id_lminattaprice,:id_lminriceprice,:id_ldepminattawt,:id_ldepminricewt,
//						  :id_ldepminattaprice,:id_ldepminriceprice
						  
						  
select nvl(emp_rationcardno,'X') into :ls_rcno  from fb_employee where emp_id = :fs_labour;

if isnull(ls_rcno) then ls_rcno = 'X';

  If fd_attndays >= id_minworkdays Then
    //start ration for self
     If fs_lab_ty = 'LP' or ((gs_garden_snm <> 'MT' and fs_lab_ty = 'LT') or (gs_garden_snm = 'MT' and fs_lab_ty = 'LT' and ls_rcno <> 'X'))  Then
        id_labricewt = id_lmajricewt
        id_labattawt = id_lmajattawt
        id_totricequan = id_totricequan + id_lmajricewt
        id_totattaquan = id_totattaquan + id_lmajattawt
        ld_rationprice = ld_rationprice + (id_lmajricewt * id_lmajriceprice) + (id_lmajattawt * id_lmajattaprice)
		  
	   If ls_spouse = 'Y' Then
				//        start ration for spouse if feasible
			  If fs_emp_sex = 'M' And is_adultallow = 'YES' Then
	
					select nvl(lsp.spouse_id,'a') into  :ls_temp from fb_labourspouse lsp where lsp.labour_id=:fs_labour and spouse_active='1';
	
					 if sqlca.sqlcode = 0 then // spouse found
						if ls_temp ='a' then		// spouse does not work(give ration)
							  id_labricewt = id_labricewt + id_ldepmajricewt
							  id_labattawt = id_labattawt + id_ldepmajattawt
							  id_totricequan = id_totricequan + id_ldepmajricewt
							  id_totattaquan = id_totattaquan + id_ldepmajattawt
							  ld_rationprice = ld_rationprice + (id_ldepmajricewt * id_ldepmajriceprice) + (id_ldepmajattawt * id_ldepmajattaprice)
								id_no_lab_depmajor = id_no_lab_depmajor + 1
						 End If
					  End If
	
			End If	//end ration for spouse if feasible
		End if
     End If //end ration for self
	  
	ls_childcur_ind = 'X'

	select distinct 'x' into :ls_temp from fb_labourdependent ld where ld.labour_id=:fs_labour  and ld.child_active='1';

	if sqlca.sqlcode = 0 then
		ls_childcur_ind = 'A'
	elseif sqlca.sqlcode = 100 then
	      If fs_emp_sex = 'F' Then
	           select distinct 'x' into :ls_temp from fb_labourdependent ld,fb_labourspouse lsp 
 			  where ld.labour_id=lsp.labour_id and ld.child_active='1' and lsp.spouse_id= :fs_labour;
				
			if sqlca.sqlcode = 0 then
				ls_childcur_ind = 'B'
			end if;				
			
	      End If
    End If

     If (ls_childcur_ind = 'A' or  ls_childcur_ind = 'B' ) And ls_mchild = 'Y' Then  //has child dependent

        If fs_emp_sex = 'M' And fs_lab_marital = 'M' Then
			/*
			select count(1) into :ll_cnt from fb_labourspouse lsp,fb_employee emp where emp.emp_id=lsp.spouse_id and emp.emp_type in ('SS','ST') and lsp.labour_id=:fs_labour and spouse_active='1';
			
                 If ll_cnt = 1 Then
                   //GoTo L1
                 End If 		*/
					  
					 
                 //start ration for child
			if ls_childcur_ind = 'A' then
				declare c2 cursor for
					select rownum, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
					from fb_labourdependent ld
					where labour_id=:fs_labour  and ld.child_active='1' and  child_marital = 'U' and 
							(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
							   ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES') or
								(:ls_umgirl='Y' and CHILD_DEPENDENTTYPE = 'CHILD' and CHILD_GENDER = 'F' and child_marital = 'U' ));

//						 select sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) - :ll_minorage),1,0,1),0)),
//									 sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) - :ll_minorage),1,1,0),0)),
//									 sum(decode(empd_maritalstatus,'W',1,0))
//							 into :ll_nodepminorphase2,:ll_nodepminor,:ll_nodepmajor1
//							from fb_empdependents ld
//							where EMP_ID =:ls_emp_id and empd_active='1' and 
//									( (:ls_mchild='Y' and EMPD_DEPENDENTTYPE='CHILD' and  EMPD_MARITALSTATUS ='U' and 
//										(  ( ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) between :ll_mstage and :ll_wsage) or
//												( ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) between :ll_mstage and :ll_sage and EMPD_SCHOOLFLAG='YES')) ) or
//									  (:ls_umgirl='Y' and EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
//									  (:ls_umsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
//									  (:ls_wsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) or
//									  (:ls_wmother='Y' and EMPD_DEPENDENTTYPE='MOTHER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) );


					open c2;
		
					if sqlca.sqlcode = -1 then 
						messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
						rollback using sqlca; 
						return -1; 
					end if;
					
						fetch c2 into :ll_nochild,:ld_noy;
						
						do while sqlca.sqlcode <> 100 
						
						 If ld_noy <= ll_minorage Then
							  id_labricewt = id_labricewt + id_ldepminricewt
							  id_labattawt = id_labattawt + id_ldepminattawt
		
							  id_totricequan = id_totricequan + id_ldepminricewt
							  id_totattaquan = id_totattaquan + id_ldepminattawt
							  ld_rationprice = ld_rationprice + (id_ldepminricewt * id_ldepminriceprice) + (id_ldepminattawt * id_ldepminattaprice)
							  id_no_lab_depminor = id_no_lab_depminor + 1
						Else
								if (ls_major_dep ='D' ) then
									id_labricewt = id_labricewt + (2 * id_ldepminricewt)
									id_labattawt = id_labattawt + (2 * id_ldepminattawt)
									
									id_totricequan = id_totricequan + (2 * id_ldepminricewt)
									id_totattaquan = id_totattaquan + (2 * id_ldepminattawt)
									ld_rationprice = ld_rationprice + ((2 * id_ldepminricewt) * id_ldepminriceprice) + ((2 * id_ldepminattawt) * id_ldepminattaprice)
								else
									id_labricewt = id_labricewt + id_ldepmajricewt
									id_labattawt = id_labattawt + id_ldepmajattawt
									
									id_totricequan = id_totricequan + id_ldepmajricewt
									id_totattaquan = id_totattaquan + id_ldepmajattawt
									ld_rationprice = ld_rationprice + (id_ldepmajricewt * id_ldepmajriceprice) + (id_ldepmajattawt * id_ldepmajattaprice)
								end if							
							  id_no_lab_depmajor = id_no_lab_depmajor + 1
												
						End If
						
						if ll_nochild = ll_nodep then
							exit
						end if
						fetch c2 into :ll_nochild,:ld_noy;
					loop
					close c2;
							  //end ration for child

			elseif ls_childcur_ind = 'B' then
				declare c21 cursor for
					select rownum, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
					from fb_labourdependent ld,fb_labourspouse lsp 
 			  		where ld.labour_id=lsp.labour_id and ld.child_active='1' and lsp.spouse_id= :fs_labour and ld.child_active='1' and  child_marital = 'U' and 
							(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
							   ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES') or
								(:ls_umgirl='Y' and CHILD_DEPENDENTTYPE = 'CHILD' and CHILD_GENDER = 'F' and child_marital = 'U' ));

					open c21;
		
					if sqlca.sqlcode = -1 then 
						messagebox('Sql Error : During Opening Cursor C21 : ',sqlca.sqlerrtext); 
						rollback using sqlca; 
						return -1; 
					end if;
					
						fetch c21 into :ll_nochild,:ld_noy;
						
						do while sqlca.sqlcode <> 100 
						
						 If ld_noy <= ll_minorage Then
							  id_labricewt = id_labricewt + id_ldepminricewt
							  id_labattawt = id_labattawt + id_ldepminattawt
		
							  id_totricequan = id_totricequan + id_ldepminricewt
							  id_totattaquan = id_totattaquan + id_ldepminattawt
							  ld_rationprice = ld_rationprice + (id_ldepminricewt * id_ldepminriceprice) + (id_ldepminattawt * id_ldepminattaprice)
							  id_no_lab_depminor = id_no_lab_depminor + 1
						Else
								if (ls_major_dep ='D' ) then
									id_labricewt = id_labricewt + (2 * id_ldepminricewt)
									id_labattawt = id_labattawt + (2 * id_ldepminattawt)
									
									id_totricequan = id_totricequan + (2 * id_ldepminricewt)
									id_totattaquan = id_totattaquan + (2 * id_ldepminattawt)
									ld_rationprice = ld_rationprice + ((2 * id_ldepminricewt) * id_ldepminriceprice) + ((2 * id_ldepminattawt) * id_ldepminattaprice)
								else
									id_labricewt = id_labricewt + id_ldepmajricewt
									id_labattawt = id_labattawt + id_ldepmajattawt
									
									id_totricequan = id_totricequan + id_ldepmajricewt
									id_totattaquan = id_totattaquan + id_ldepmajattawt
									ld_rationprice = ld_rationprice + (id_ldepmajricewt * id_ldepmajriceprice) + (id_ldepmajattawt * id_ldepmajattaprice)
								end if							
							  id_no_lab_depmajor = id_no_lab_depmajor + 1
												
						End If
						
						if ll_nochild = ll_nodep then
							exit
						end if
						fetch c21 into :ll_nochild,:ld_noy;
					loop
					close c21;
							  //end ration for child

			end if
			


		ElseIf fs_emp_sex = 'F' And fs_lab_marital = 'M' Then //female labour

                 //	start find whether male spouse is working or not
                 select lsp.labour_id labour_id into :ls_temp from fb_labourspouse lsp,fb_employee emp 
			 where emp.emp_id=lsp.labour_id and emp.emp_type in ('LP','SS','ST') and spouse_id=:fs_labour  and spouse_active='1';

			if sqlca.sqlcode  = 100 then	//start ration for child

					if ls_childcur_ind = 'A' then
						declare c3 cursor for
							select rownum, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
							from fb_labourdependent ld
							where labour_id=:fs_labour  and ld.child_active='1' and  child_marital = 'U' and 
									(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
										( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES') or
								(:ls_umgirl='Y' and CHILD_DEPENDENTTYPE = 'CHILD' and CHILD_GENDER = 'F' and child_marital = 'U' ));

							open c3;
							
								fetch c3 into :ll_nochild,:ld_noy;
								do while sqlca.sqlcode <> 100 
						
								 If ld_noy <= ll_minorage Then
									  id_labricewt = id_labricewt + id_ldepminricewt
									  id_labattawt = id_labattawt + id_ldepminattawt
				
									  id_totricequan = id_totricequan + id_ldepminricewt
									  id_totattaquan = id_totattaquan + id_ldepminattawt
									  ld_rationprice = ld_rationprice + (id_ldepminricewt * id_ldepminriceprice) + (id_ldepminattawt * id_ldepminattaprice)
									  id_no_lab_depminor = id_no_lab_depminor + 1
								Else
									if (ls_major_dep ='D' ) then
										id_labricewt = id_labricewt + (2 * id_ldepminricewt)
										id_labattawt = id_labattawt + (2 * id_ldepminattawt)
										
										id_totricequan = id_totricequan + (2 * id_ldepminricewt)
										id_totattaquan = id_totattaquan + (2 * id_ldepminattawt)
										ld_rationprice = ld_rationprice + ((2 * id_ldepminricewt) * id_ldepminriceprice) + ((2 * id_ldepminattawt) * id_ldepminattaprice)
									else
										id_labricewt = id_labricewt + id_ldepmajricewt
										id_labattawt = id_labattawt + id_ldepmajattawt
										
										id_totricequan = id_totricequan + id_ldepmajricewt
										id_totattaquan = id_totattaquan + id_ldepmajattawt
										ld_rationprice = ld_rationprice + (id_ldepmajricewt * id_ldepmajriceprice) + (id_ldepmajattawt * id_ldepmajattaprice)
									end if							
									  id_no_lab_depmajor = id_no_lab_depmajor + 1
														
								End If
						
								if ll_nochild = ll_nodep then
									exit
								end if
							fetch c3 into :ll_nochild,:ld_noy;
							loop
						  close c3; //end ration for child
		
					elseif ls_childcur_ind = 'B' then
						declare c31 cursor for
							select rownum, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
							from fb_labourdependent ld,fb_labourspouse lsp 
							where ld.labour_id=lsp.labour_id and ld.child_active='1' and lsp.spouse_id= :fs_labour and ld.child_active='1' and  child_marital = 'U' and 
								(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
									( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES') or
								(:ls_umgirl='Y' and CHILD_DEPENDENTTYPE = 'CHILD' and CHILD_GENDER = 'F' and child_marital = 'U' ));


							open c31;
							
								fetch c31 into :ll_nochild,:ld_noy;
								do while sqlca.sqlcode <> 100 
						
								 If ld_noy <= ll_minorage Then
									  id_labricewt = id_labricewt + id_ldepminricewt
									  id_labattawt = id_labattawt + id_ldepminattawt
				
									  id_totricequan = id_totricequan + id_ldepminricewt
									  id_totattaquan = id_totattaquan + id_ldepminattawt
									  ld_rationprice = ld_rationprice + (id_ldepminricewt * id_ldepminriceprice) + (id_ldepminattawt * id_ldepminattaprice)
									  id_no_lab_depminor = id_no_lab_depminor + 1
								Else
									if (ls_major_dep ='D' ) then
										id_labricewt = id_labricewt + (2 * id_ldepminricewt)
										id_labattawt = id_labattawt + (2 * id_ldepminattawt)
										
										id_totricequan = id_totricequan + (2 * id_ldepminricewt)
										id_totattaquan = id_totattaquan + (2 * id_ldepminattawt)
										ld_rationprice = ld_rationprice + ((2 * id_ldepminricewt) * id_ldepminriceprice) + ((2 * id_ldepminattawt) * id_ldepminattaprice)
									else
										id_labricewt = id_labricewt + id_ldepmajricewt
										id_labattawt = id_labattawt + id_ldepmajattawt
										
										id_totricequan = id_totricequan + id_ldepmajricewt
										id_totattaquan = id_totattaquan + id_ldepmajattawt
										ld_rationprice = ld_rationprice + (id_ldepmajricewt * id_ldepmajriceprice) + (id_ldepmajattawt * id_ldepmajattaprice)
									end if							
									  id_no_lab_depmajor = id_no_lab_depmajor + 1
														
								End If
						
								if ll_nochild = ll_nodep then
									exit
								end if
							fetch c31 into :ll_nochild,:ld_noy;
							loop
						  close c31; //end ration for child
					end if
			
				  
               Else //start if male spouse has not picked ration
						
                     select emp.emp_type emp_type,emp.field_id field_id,SUM(LKW.NODAYS) attendancedays 
				    into :ls_msp_ty,:ls_msp_field,:ld_msp_attndays
				 from (select lda.lww_id LWWID,lda.labour_id LABOURID,kam.kamsub_nkamtype NKAMTYPE,sum(lda_status) NODAYS,sum(lda_wages) WAGES,sum(lda_elp) ELP 
				 		   from fb_labourdailyattendance lda,fb_kamsubhead kam 
						  where lda.kamsub_id=kam.kamsub_id and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y'  group by (lda.lww_id,lda.labour_id,kam.kamsub_nkamtype) ) lkw,fb_labourspouse lsp,fb_employee emp 
				 where emp.emp_id=lsp.labour_id and lsp.labour_id=lkw.LABOURID and lkw.LWWID=:fs_lww_id and 
				 		  trim(lkw.NKAMTYPE) in ('OTHERS','MATERNITY','SICKALLOWANCE','SICKATTENDANCE','SICKNOWAGES') and lsp.labour_id=:ls_temp
				GROUP BY emp.emp_type,emp.field_id;

				if sqlca.sqlcode = 0 then
                     	select lrc_minworkdays into :ld_mindaysmspouse from fb_labourrationchart 
					where field_id=:ls_msp_field and lrc_labourtype=:ls_msp_ty and lrc_majorminorflag='MAJOR' and 
							lrc_noworkdays=(select max(lrc_noworkdays) from fb_labourrationchart);

	                     if sqlca.sqlcode =100 then
					  	ld_msp_attndays = 0
                     	  	ld_mindaysmspouse = 1 //default setting
                     	End If
				end if

                     // end pick minworkdays for male spouse

                     If ld_msp_attndays < ld_mindaysmspouse Then
                                //start ration for child

					if ls_childcur_ind = 'A' then
						declare c4 cursor for
							select rownum, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
							from fb_labourdependent ld 
							where labour_id=:fs_labour  and ld.child_active='1' and  child_marital = 'U' and 
									(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
									   ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES') or
								(:ls_umgirl='Y' and CHILD_DEPENDENTTYPE = 'CHILD' and CHILD_GENDER = 'F' and child_marital = 'U' ));

						open c4;
						
							fetch c4 into :ll_nochild,:ld_noy;
							do while sqlca.sqlcode <> 100 
					
							 If ld_noy <= ll_minorage Then
								  id_labricewt = id_labricewt + id_ldepminricewt
								  id_labattawt = id_labattawt + id_ldepminattawt
			
								  id_totricequan = id_totricequan + id_ldepminricewt
								  id_totattaquan = id_totattaquan + id_ldepminattawt
								  ld_rationprice = ld_rationprice + (id_ldepminricewt * id_ldepminriceprice) + (id_ldepminattawt * id_ldepminattaprice)
								  id_no_lab_depminor = id_no_lab_depminor + 1
							Else
									if (ls_major_dep ='D' ) then
										id_labricewt = id_labricewt + (2 * id_ldepminricewt)
										id_labattawt = id_labattawt + (2 * id_ldepminattawt)
										
										id_totricequan = id_totricequan + (2 * id_ldepminricewt)
										id_totattaquan = id_totattaquan + (2 * id_ldepminattawt)
										ld_rationprice = ld_rationprice + ((2 * id_ldepminricewt) * id_ldepminriceprice) + ((2 * id_ldepminattawt) * id_ldepminattaprice)
									else
										id_labricewt = id_labricewt + id_ldepmajricewt
										id_labattawt = id_labattawt + id_ldepmajattawt
										
										id_totricequan = id_totricequan + id_ldepmajricewt
										id_totattaquan = id_totattaquan + id_ldepmajattawt
										ld_rationprice = ld_rationprice + (id_ldepmajricewt * id_ldepmajriceprice) + (id_ldepmajattawt * id_ldepmajattaprice)
									end if							
								  id_no_lab_depmajor = id_no_lab_depmajor + 1
													
							End If
					
							if ll_nochild = ll_nodep then
								exit
							end if
						fetch c4 into :ll_nochild,:ld_noy;
						loop
					  close c4; //end ration for child
		
					elseif ls_childcur_ind = 'B' then
						declare c41 cursor for
							select rownum, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
							from fb_labourdependent ld,fb_labourspouse lsp 
							where ld.labour_id=lsp.labour_id and ld.child_active='1' and lsp.spouse_id= :fs_labour and ld.child_active='1' and  child_marital = 'U' and 
									(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
										( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES') or
								(:ls_umgirl='Y' and CHILD_DEPENDENTTYPE = 'CHILD' and CHILD_GENDER = 'F' and child_marital = 'U' ));
						open c41;
						
							fetch c41 into :ll_nochild,:ld_noy;
							do while sqlca.sqlcode <> 100 
					
							 If ld_noy <= ll_minorage Then
								  id_labricewt = id_labricewt + id_ldepminricewt
								  id_labattawt = id_labattawt + id_ldepminattawt
			
								  id_totricequan = id_totricequan + id_ldepminricewt
								  id_totattaquan = id_totattaquan + id_ldepminattawt
								  ld_rationprice = ld_rationprice + (id_ldepminricewt * id_ldepminriceprice) + (id_ldepminattawt * id_ldepminattaprice)
								  id_no_lab_depminor = id_no_lab_depminor + 1
							Else
									if (ls_major_dep ='D' ) then
										id_labricewt = id_labricewt + (2 * id_ldepminricewt)
										id_labattawt = id_labattawt + (2 * id_ldepminattawt)
										
										id_totricequan = id_totricequan + (2 * id_ldepminricewt)
										id_totattaquan = id_totattaquan + (2 * id_ldepminattawt)
										ld_rationprice = ld_rationprice + ((2 * id_ldepminricewt) * id_ldepminriceprice) + ((2 * id_ldepminattawt) * id_ldepminattaprice)
									else
										id_labricewt = id_labricewt + id_ldepmajricewt
										id_labattawt = id_labattawt + id_ldepmajattawt
										
										id_totricequan = id_totricequan + id_ldepmajricewt
										id_totattaquan = id_totattaquan + id_ldepmajattawt
										ld_rationprice = ld_rationprice + (id_ldepmajricewt * id_ldepmajriceprice) + (id_ldepmajattawt * id_ldepmajattaprice)
									end if							
								  id_no_lab_depmajor = id_no_lab_depmajor + 1
													
							End If
					
							if ll_nochild = ll_nodep then
								exit
							end if
						fetch c41 into :ll_nochild,:ld_noy;
						loop
					  close c41; //end ration for child
					end if
				end if
                    End If //end if male spouse has not picked ration
          End If //end find whether spouse is working or not
      End If
End If

return ld_rationprice

end function

public function integer wf_elpcal (string fs_labour_id, string fs_fr_dt, string fs_to_dt, string fs_lrw_id);long ll_labage,ll_roundoff
string ls_elpdet
double ld_gl, ld_task

setnull(id_elp_cf );setnull(id_elp);setnull(id_penalty);setnull(id_elp_bf)

select lwr_coinbf into :id_elp_bf from fb_labourweeklyration 
where (labour_id,lrw_id) in (select labour_id,max(lrw_id) from fb_labourweeklyration 
							         where labour_id=:fs_labour_id and lrw_id<:fs_lrw_id group by labour_id);
										
if sqlca.sqlcode = -1 then
	messagebox('Sql Error : During Labour ELP BF (Select) ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
end if

if isnull(id_elp_bf) then id_elp_bf=0

 select sum(decode(sign(LDA_ELP),-1,0,nvl(LDA_ELP,0))),sum(decode(sign(LDA_ELP),-1,nvl(LDA_ELP,0),0)) into :id_elp ,:id_penalty
    from fb_labourdailyattendance lda
 where lda.labour_id = :fs_labour_id and lda.lda_date between to_date(:fs_fr_dt,'dd/mm/yyyy') and  to_date(:fs_to_dt,'dd/mm/yyyy') and
           nvl(LDA_ELP,0) != 0 ;

if sqlca.sqlcode = -1 then
	messagebox('Sql Error : During Labour ELP (Select) ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
end if

if isnull(id_elp) then id_elp=0


 select pd_value into :ll_roundoff from fb_param_detail  
 where PD_DOC_TYPE='ROUNDOFF' and to_date(:fs_fr_dt,'dd/mm/yyyy') between PD_PERIOD_from and nvl(PD_PERIOD_to,trunc(sysdate));
 
 if sqlca.sqlcode = -1 then
	messagebox('Sql Error : During Labour ELP (Select) ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
end if

if isnull(ll_roundoff) then ll_roundoff=0

id_elp_cf = Mod((id_elp + id_elp_bf),ll_roundoff) 
id_netpayable = (id_elp + id_elp_bf) - id_elp_cf

declare c2 cursor for 
select ROUND(lda.LDA_TASK,0) TASK,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) glcount 
from fb_labourdailyattendance lda
where lda.labour_id = :fs_labour_id and lda.lda_date between to_date(:fs_fr_dt,'dd/mm/yyyy') and  to_date(:fs_to_dt,'dd/mm/yyyy') and
           nvl(LDA_ELP,0) >0 order by lda.lda_date;

open c2; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor c2 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 

	ld_gl= 0; ld_task= 0; ls_elpdet=""

	fetch c2 into :ld_task,:ld_gl;
	do while sqlca.sqlcode <> 100 
		ls_elpdet = ls_elpdet + string(ld_gl, "00") + "   " + string(ld_task, "00")
		ld_gl= 0; ld_task= 0; 
		fetch c2 into :ld_task,:ld_gl;
	loop
	close c2;
	if ls_elpdet <> ""   then
	end if


	INSERT INTO FB_LABELPDETAILS (LRW_ID,LABOUR_ID,ELP_DETAILS,ELP_STATUS) 
	VALUES (:fs_lrw_id,:fs_labour_id,:ls_elpdet,'WEEKLY');
	
	if sqlca.sqlcode = -1 then
		messagebox('Sql Error : During Labour ELP Detail (Insert) ',sqlca.sqlerrtext); 
		rollback using sqlca; 
		return -1; 
	end if
end if;	

return 1
		
end function

public function double wf_emp_calration (string fs_labour, string fs_lab_ty, string fs_lab_marital, double fd_attndays, string fs_emp_sex, string fs_start_dt, string fs_lww_id);Double ld_rationprice ,ld_msp_attndays,ld_mindaysmspouse,ld_noy
long ll_nochild 
string ls_childcur_ind,ls_msp_ty,ls_msp_field,ls_major_dep
string ls_spouse,ls_mchild,ls_wsister,ls_umsister,ls_wmother
long ll_mstage,ll_wsage,ll_sage,ll_minorage,ll_nodep

  ll_nochild  = 0

  id_labricewt=0;id_labattawt=0;id_no_lab_depminor=0;id_no_lab_depmajor=0 

  ld_rationprice = 0
  
  select RP_SPOUSE_IND, RP_CH_IND,rp_major_dpind, nvl(RP_CH_STARTAGE,0), nvl(RP_CH_WSCH_AGE,0), nvl(RP_CH_SCH_AGE,0), nvl(RP_MINOR_DEPAGE,0), nvl(RP_NOOF_DEP,0),RP_WIDOW_SISTER, RP_UNMARRIED_SISTER, RP_WIDOW_MOTHER
  into :ls_spouse,:ls_mchild,:ls_major_dep,:ll_mstage,:ll_wsage,:ll_sage,:ll_minorage,:ll_nodep,:ls_wsister,:ls_umsister,:ls_wmother
  from fb_rationparam where RP_EMPTYPE = :fs_lab_ty and to_date(:fs_start_dt,'dd/mm/yyyy') between RP_PERIOD_FROM and nvl(RP_PERIOD_TO,trunc(sysdate));

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Ration Parameter Select : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
end if;

  If fd_attndays >= id_minworkdays Then
    //start ration for self "
     If fs_lab_ty = 'ST' or fs_lab_ty = 'SS' or fs_lab_ty = 'AT' Then
        id_labricewt = id_lmajricewt
        id_labattawt = id_lmajattawt
        id_totricequan = id_totricequan + id_lmajricewt
        id_totattaquan = id_totattaquan + id_lmajattawt
        ld_rationprice = ld_rationprice + (id_lmajricewt * id_lmajriceprice) + (id_lmajattawt * id_lmajattaprice)
		  
	  If fs_emp_sex = 'M' And is_adultallow = 'YES' Then

		select nvl(lsp.spouse_id,'a') into  :ls_temp from fb_labourspouse lsp where lsp.labour_id=:fs_labour and spouse_active='1';

		 if sqlca.sqlcode = 0 then // spouse found
			if ls_temp ='a' then		// spouse does not work(give ration)
				  id_labricewt = id_labricewt + id_ldepmajricewt
				  id_labattawt = id_labattawt + id_ldepmajattawt
				  id_totricequan = id_totricequan + id_ldepmajricewt
				  id_totattaquan = id_totattaquan + id_ldepmajattawt
				  ld_rationprice = ld_rationprice + (id_ldepmajricewt * id_ldepmajriceprice) + (id_ldepmajattawt * id_ldepmajattaprice)
			 End If
		  End If

	End If	//end ration for spouse if feasible
 End If //end ration for self
	  
	ls_childcur_ind = 'X'

	select distinct 'x' into :ls_temp from fb_labourdependent ld where ld.labour_id=:fs_labour  and ld.child_active='1';

	if sqlca.sqlcode = 0 then
		ls_childcur_ind = 'A'
	elseif sqlca.sqlcode = 100 then
	      If fs_emp_sex = 'F' Then
	           select distinct 'x' into :ls_temp from fb_labourdependent ld,fb_labourspouse lsp 
 			  where ld.labour_id=lsp.labour_id and ld.child_active='1' and lsp.spouse_id= :fs_labour;
				
			if sqlca.sqlcode = 0 then
				ls_childcur_ind = 'B'
			end if;				
			
	      End If
    End If

     If (ls_childcur_ind = 'A' or  ls_childcur_ind = 'B' ) And ls_mchild = 'Y' Then  //has child dependent

        If fs_emp_sex = 'M' And fs_lab_marital = 'M' Then
			/*
			select count(1) into :ll_cnt from fb_labourspouse lsp,fb_employee emp where emp.emp_id=lsp.spouse_id and emp.emp_type in ('SS','ST') and lsp.labour_id=:fs_labour and spouse_active='1';
			
                 If ll_cnt = 1 Then
                   //GoTo L1
                 End If 		*/
					  
                 //start ration for child
			if ls_childcur_ind = 'A' then
				declare c2 cursor for
					select rownum, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
					from fb_labourdependent ld
					where labour_id=:fs_labour  and ld.child_active='1' and  child_marital = 'U' and 
							(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
							   ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES'));

					open c2;
		
					if sqlca.sqlcode = -1 then 
						messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
						rollback using sqlca; 
						return -1; 
					end if;
					
						fetch c2 into :ll_nochild,:ld_noy;
						
						do while sqlca.sqlcode <> 100 
							
						 If  ld_noy <= ll_minorage Then
							  id_labricewt = id_labricewt + id_ldepminricewt
							  id_labattawt = id_labattawt + id_ldepminattawt
		
							  id_totricequan = id_totricequan + id_ldepminricewt
							  id_totattaquan = id_totattaquan + id_ldepminattawt
							  ld_rationprice = ld_rationprice + (id_ldepminricewt * id_ldepminriceprice) + (id_ldepminattawt * id_ldepminattaprice)
							  id_no_lab_depminor = id_no_lab_depminor + 1
						Else
								if (ls_major_dep ='D' ) then
									id_labricewt = id_labricewt + (2 * id_ldepminricewt)
									id_labattawt = id_labattawt + (2 * id_ldepminattawt)
									
									id_totricequan = id_totricequan + (2 * id_ldepminricewt)
									id_totattaquan = id_totattaquan + (2 * id_ldepminattawt)
									ld_rationprice = ld_rationprice + ((2 * id_ldepminricewt) * id_ldepminriceprice) + ((2 * id_ldepminattawt) * id_ldepminattaprice)
								else
									id_labricewt = id_labricewt + id_ldepmajricewt
									id_labattawt = id_labattawt + id_ldepmajattawt
									
									id_totricequan = id_totricequan + id_ldepmajricewt
									id_totattaquan = id_totattaquan + id_ldepmajattawt
									ld_rationprice = ld_rationprice + (id_ldepmajricewt * id_ldepmajriceprice) + (id_ldepmajattawt * id_ldepmajattaprice)
								end if							
							  id_no_lab_depmajor = id_no_lab_depmajor + 1
												
						End If
						
						if ll_nochild = ll_nodep then
							exit
						end if
						fetch c2 into :ll_nochild,:ld_noy;
					loop
					close c2;
							  //end ration for child

			elseif ls_childcur_ind = 'B' then
				declare c21 cursor for
					select rownum, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
					from fb_labourdependent ld,fb_labourspouse lsp 
 			  		where ld.labour_id=lsp.labour_id and ld.child_active='1' and lsp.spouse_id= :fs_labour and ld.child_active='1' and  child_marital = 'U' and 
							(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
							   ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES'));

					open c21;
		
					if sqlca.sqlcode = -1 then 
						messagebox('Sql Error : During Opening Cursor C21 : ',sqlca.sqlerrtext); 
						rollback using sqlca; 
						return -1; 
					end if;
					
						fetch c21 into :ll_nochild,:ld_noy;
						
						do while sqlca.sqlcode <> 100 
						
						 If ( ld_noy <= ll_minorage  ) Then
							  id_labricewt = id_labricewt + id_ldepminricewt
							  id_labattawt = id_labattawt + id_ldepminattawt
		
							  id_totricequan = id_totricequan + id_ldepminricewt
							  id_totattaquan = id_totattaquan + id_ldepminattawt
							  ld_rationprice = ld_rationprice + (id_ldepminricewt * id_ldepminriceprice) + (id_ldepminattawt * id_ldepminattaprice)
							  id_no_lab_depminor = id_no_lab_depminor + 1
						Else
							if (ls_major_dep ='D' ) then
								id_labricewt = id_labricewt + (2 * id_ldepminricewt)
								id_labattawt = id_labattawt + (2 * id_ldepminattawt)
								
								id_totricequan = id_totricequan + (2 * id_ldepminricewt)
								id_totattaquan = id_totattaquan + (2 * id_ldepminattawt)
								ld_rationprice = ld_rationprice + ((2 * id_ldepminricewt) * id_ldepminriceprice) + ((2 * id_ldepminattawt) * id_ldepminattaprice)
							else
								id_labricewt = id_labricewt + id_ldepmajricewt
								id_labattawt = id_labattawt + id_ldepmajattawt
								
								id_totricequan = id_totricequan + id_ldepmajricewt
								id_totattaquan = id_totattaquan + id_ldepmajattawt
								ld_rationprice = ld_rationprice + (id_ldepmajricewt * id_ldepmajriceprice) + (id_ldepmajattawt * id_ldepmajattaprice)
							end if							
							  id_no_lab_depmajor = id_no_lab_depmajor + 1
												
						End If
						
						if ll_nochild = ll_nodep then
							exit
						end if
						fetch c21 into :ll_nochild,:ld_noy;
					loop
					close c21;
							  //end ration for child

			end if
			


		ElseIf fs_emp_sex = 'F' And fs_lab_marital = 'M' Then //female labour

                 //	start find whether male spouse is working or not
                 select lsp.labour_id labour_id into :ls_temp from fb_labourspouse lsp,fb_employee emp 
			 where emp.emp_id=lsp.labour_id and emp.emp_type in('LP','SS','ST') and spouse_id=:fs_labour  and spouse_active='1';

			if sqlca.sqlcode  = 100 then	//start ration for child

					if ls_childcur_ind = 'A' then
						declare c3 cursor for
							select rownum, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
							from fb_labourdependent ld
							where labour_id=:fs_labour  and ld.child_active='1' and  child_marital = 'U' and 
									(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
										( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES'));

							open c3;
							
								fetch c3 into :ll_nochild,:ld_noy;
								do while sqlca.sqlcode <> 100 
						
								 If ( ld_noy <= ll_minorage  ) Then
									  id_labricewt = id_labricewt + id_ldepminricewt
									  id_labattawt = id_labattawt + id_ldepminattawt
				
									  id_totricequan = id_totricequan + id_ldepminricewt
									  id_totattaquan = id_totattaquan + id_ldepminattawt
									  ld_rationprice = ld_rationprice + (id_ldepminricewt * id_ldepminriceprice) + (id_ldepminattawt * id_ldepminattaprice)
									  id_no_lab_depminor = id_no_lab_depminor + 1
								Else
									if (ls_major_dep ='D' ) then
										id_labricewt = id_labricewt + (2 * id_ldepminricewt)
										id_labattawt = id_labattawt + (2 * id_ldepminattawt)
										
										id_totricequan = id_totricequan + (2 * id_ldepminricewt)
										id_totattaquan = id_totattaquan + (2 * id_ldepminattawt)
										ld_rationprice = ld_rationprice + ((2 * id_ldepminricewt) * id_ldepminriceprice) + ((2 * id_ldepminattawt) * id_ldepminattaprice)
									else
										id_labricewt = id_labricewt + id_ldepmajricewt
										id_labattawt = id_labattawt + id_ldepmajattawt
										
										id_totricequan = id_totricequan + id_ldepmajricewt
										id_totattaquan = id_totattaquan + id_ldepmajattawt
										ld_rationprice = ld_rationprice + (id_ldepmajricewt * id_ldepmajriceprice) + (id_ldepmajattawt * id_ldepmajattaprice)
									end if							
									  id_no_lab_depmajor = id_no_lab_depmajor + 1
														
								End If
						
								if ll_nochild = ll_nodep then
									exit
								end if
							fetch c3 into :ll_nochild,:ld_noy;
							loop
						  close c3; //end ration for child
		
					elseif ls_childcur_ind = 'B' then
						declare c31 cursor for
							select rownum, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
							from fb_labourdependent ld,fb_labourspouse lsp 
							where ld.labour_id=lsp.labour_id and ld.child_active='1' and lsp.spouse_id= :fs_labour and ld.child_active='1' and  child_marital = 'U' and 
									(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
										( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES'));

							open c31;
							
								fetch c31 into :ll_nochild,:ld_noy;
								do while sqlca.sqlcode <> 100 
						
								 If ( ld_noy <= ll_minorage  ) Then
									  id_labricewt = id_labricewt + id_ldepminricewt
									  id_labattawt = id_labattawt + id_ldepminattawt
				
									  id_totricequan = id_totricequan + id_ldepminricewt
									  id_totattaquan = id_totattaquan + id_ldepminattawt
									  ld_rationprice = ld_rationprice + (id_ldepminricewt * id_ldepminriceprice) + (id_ldepminattawt * id_ldepminattaprice)
									  id_no_lab_depminor = id_no_lab_depminor + 1
								Else
									if (ls_major_dep ='D' ) then
										id_labricewt = id_labricewt + (2 * id_ldepminricewt)
										id_labattawt = id_labattawt + (2 * id_ldepminattawt)
										
										id_totricequan = id_totricequan + (2 * id_ldepminricewt)
										id_totattaquan = id_totattaquan + (2 * id_ldepminattawt)
										ld_rationprice = ld_rationprice + ((2 * id_ldepminricewt) * id_ldepminriceprice) + ((2 * id_ldepminattawt) * id_ldepminattaprice)
									else
										id_labricewt = id_labricewt + id_ldepmajricewt
										id_labattawt = id_labattawt + id_ldepmajattawt
										
										id_totricequan = id_totricequan + id_ldepmajricewt
										id_totattaquan = id_totattaquan + id_ldepmajattawt
										ld_rationprice = ld_rationprice + (id_ldepmajricewt * id_ldepmajriceprice) + (id_ldepmajattawt * id_ldepmajattaprice)
									end if							
									  id_no_lab_depmajor = id_no_lab_depmajor + 1
														
								End If
						
								if ll_nochild = ll_nodep then
									exit
								end if
							fetch c31 into :ll_nochild,:ld_noy;
							loop
						  close c31; //end ration for child
					end if
			
				  
               Else //start if male spouse has not picked ration
						
                     select emp.emp_type emp_type,emp.field_id field_id,SUM(LKW.NODAYS) attendancedays 
				    into :ls_msp_ty,:ls_msp_field,:ld_msp_attndays
				 from (select lda.lww_id LWWID,lda.labour_id LABOURID,kam.kamsub_nkamtype NKAMTYPE,sum(lda_status) NODAYS,sum(lda_wages) WAGES,sum(lda_elp) ELP 
				 		   from fb_labourdailyattendance lda,fb_kamsubhead kam 
						  where lda.kamsub_id=kam.kamsub_id and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y'  group by (lda.lww_id,lda.labour_id,kam.kamsub_nkamtype) ) lkw,fb_labourspouse lsp,fb_employee emp 
				 where emp.emp_id=lsp.labour_id and lsp.labour_id=lkw.LABOURID and lkw.LWWID=:fs_lww_id and 
				 		  trim(lkw.NKAMTYPE) in ('OTHERS','MATERNITY','SICKALLOWANCE','SICKATTENDANCE','SICKNOWAGES') and lsp.labour_id=:ls_temp
				GROUP BY emp.emp_type,emp.field_id;

				if sqlca.sqlcode = 0 then
                     	select lrc_minworkdays into :ld_mindaysmspouse from fb_labourrationchart 
					where field_id=:ls_msp_field and lrc_labourtype=:ls_msp_ty and lrc_majorminorflag='MAJOR' and 
							lrc_noworkdays=(select max(lrc_noworkdays) from fb_labourrationchart);

	                     if sqlca.sqlcode =100 then
					  	ld_msp_attndays = 0
                     	  	ld_mindaysmspouse = 1 //default setting
                     	End If
				end if

                     // end pick minworkdays for male spouse

                     If ld_msp_attndays < ld_mindaysmspouse Then
                                //start ration for child

					if ls_childcur_ind = 'A' then
						declare c4 cursor for
							select rownum, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
							from fb_labourdependent ld 
							where labour_id=:fs_labour  and ld.child_active='1' and  child_marital = 'U' and 
									(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
										( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES'));

						open c4;
						
							fetch c4 into :ll_nochild,:ld_noy;
							do while sqlca.sqlcode <> 100 
					
							 If ( ld_noy <= ll_minorage  ) Then
								  id_labricewt = id_labricewt + id_ldepminricewt
								  id_labattawt = id_labattawt + id_ldepminattawt
			
								  id_totricequan = id_totricequan + id_ldepminricewt
								  id_totattaquan = id_totattaquan + id_ldepminattawt
								  ld_rationprice = ld_rationprice + (id_ldepminricewt * id_ldepminriceprice) + (id_ldepminattawt * id_ldepminattaprice)
								  id_no_lab_depminor = id_no_lab_depminor + 1
							Else
									if (ls_major_dep ='D' ) then
										id_labricewt = id_labricewt + (2 * id_ldepminricewt)
										id_labattawt = id_labattawt + (2 * id_ldepminattawt)
										
										id_totricequan = id_totricequan + (2 * id_ldepminricewt)
										id_totattaquan = id_totattaquan + (2 * id_ldepminattawt)
										ld_rationprice = ld_rationprice + ((2 * id_ldepminricewt) * id_ldepminriceprice) + ((2 * id_ldepminattawt) * id_ldepminattaprice)
									else
										id_labricewt = id_labricewt + id_ldepmajricewt
										id_labattawt = id_labattawt + id_ldepmajattawt
										
										id_totricequan = id_totricequan + id_ldepmajricewt
										id_totattaquan = id_totattaquan + id_ldepmajattawt
										ld_rationprice = ld_rationprice + (id_ldepmajricewt * id_ldepmajriceprice) + (id_ldepmajattawt * id_ldepmajattaprice)
									end if							
								  id_no_lab_depmajor = id_no_lab_depmajor + 1
													
							End If
					
							if ll_nochild = ll_nodep then
								exit
							end if
						fetch c4 into :ll_nochild,:ld_noy;
						loop
					  close c4; //end ration for child
		
					elseif ls_childcur_ind = 'B' then
						declare c41 cursor for
							select rownum, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
							from fb_labourdependent ld,fb_labourspouse lsp 
							where ld.labour_id=lsp.labour_id and ld.child_active='1' and lsp.spouse_id= :fs_labour and ld.child_active='1' and  child_marital = 'U' and 
									(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
										( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES'));

						open c41;
						
							fetch c41 into :ll_nochild,:ld_noy;
							do while sqlca.sqlcode <> 100 
					
							 If ( ld_noy <= ll_minorage  ) Then
								  id_labricewt = id_labricewt + id_ldepminricewt
								  id_labattawt = id_labattawt + id_ldepminattawt
			
								  id_totricequan = id_totricequan + id_ldepminricewt
								  id_totattaquan = id_totattaquan + id_ldepminattawt
								  ld_rationprice = ld_rationprice + (id_ldepminricewt * id_ldepminriceprice) + (id_ldepminattawt * id_ldepminattaprice)
								  id_no_lab_depminor = id_no_lab_depminor + 1
							Else
									if (ls_major_dep ='D' ) then
										id_labricewt = id_labricewt + (2 * id_ldepminricewt)
										id_labattawt = id_labattawt + (2 * id_ldepminattawt)
										
										id_totricequan = id_totricequan + (2 * id_ldepminricewt)
										id_totattaquan = id_totattaquan + (2 * id_ldepminattawt)
										ld_rationprice = ld_rationprice + ((2 * id_ldepminricewt) * id_ldepminriceprice) + ((2 * id_ldepminattawt) * id_ldepminattaprice)
									else
										id_labricewt = id_labricewt + id_ldepmajricewt
										id_labattawt = id_labattawt + id_ldepmajattawt
										
										id_totricequan = id_totricequan + id_ldepmajricewt
										id_totattaquan = id_totattaquan + id_ldepmajattawt
										ld_rationprice = ld_rationprice + (id_ldepmajricewt * id_ldepmajriceprice) + (id_ldepmajattawt * id_ldepmajattaprice)
									end if							
								  id_no_lab_depmajor = id_no_lab_depmajor + 1
													
							End If
					
							if ll_nochild = ll_nodep then
								exit
							end if
						fetch c41 into :ll_nochild,:ld_noy;
						loop
					  close c41; //end ration for child
					end if
				end if
                    End If //end if male spouse has not picked ration
          End If //end find whether spouse is working or not
      End If
End If

return ld_rationprice

end function

on w_gtelaf048.create
this.st_10=create st_10
this.dp_1=create dp_1
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.em_1=create em_1
this.em_2=create em_2
this.Control[]={this.st_10,&
this.dp_1,&
this.st_9,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.em_1,&
this.em_2}
end on

on w_gtelaf048.destroy
destroy(this.st_10)
destroy(this.dp_1)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.em_2)
end on

event open;string ls_riceper, ls_attaper
if date(gd_dt) <> today() then
	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
	return 1
end if

select distinct round((LRC_ATTAWT/(LRC_RICEWT + LRC_ATTAWT))*100,0) attaper, round((LRC_ricewt/(LRC_RICEWT + LRC_ATTAWT))*100,0) riceper into :ls_attaper,:ls_riceper 
from fb_labourrationchart where lrc_todt is null and lrc_active_ind = 'Y';

if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while checking exisiting ration ratio'+sqlca.sqlerrtext)
	return 1;
elseif sqlca.sqlcode = 100 then 
	messagebox('Error','Existing ration ratio not found')
	return 1;
end if

st_5.text = ls_attaper+'%'
st_6.text = ls_riceper+'%'


this.tag = Message.StringParm
ll_user_level = long(this.tag)


end event

type st_10 from statictext within w_gtelaf048
integer x = 37
integer y = 532
integer width = 320
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "From Date : "
alignment alignment = center!
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gtelaf048
integer x = 41
integer y = 620
integer width = 411
integer height = 88
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2020-06-17"), Time("18:33:16.000000"))
integer textsize = -10
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_9 from statictext within w_gtelaf048
integer x = 818
integer y = 532
integer width = 233
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Rice"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_8 from statictext within w_gtelaf048
integer x = 503
integer y = 532
integer width = 238
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Atta"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within w_gtelaf048
integer x = 471
integer y = 440
integer width = 608
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "<-------New Ratio ------>"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_gtelaf048
integer x = 818
integer y = 340
integer width = 233
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Rice"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_gtelaf048
integer x = 503
integer y = 340
integer width = 238
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Atta"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_gtelaf048
integer x = 818
integer y = 248
integer width = 233
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Rice"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_gtelaf048
integer x = 503
integer y = 248
integer width = 238
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Atta"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_gtelaf048
integer x = 471
integer y = 160
integer width = 608
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "<-----Current Ratio ---->"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gtelaf048
integer x = 914
integer y = 776
integer width = 311
integer height = 112
integer taborder = 50
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

type cb_1 from commandbutton within w_gtelaf048
integer x = 398
integer y = 776
integer width = 517
integer height = 112
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Update Ratio"
boolean default = true
end type

event clicked;string ls_attaper, ls_riceper, ls_frdt
date ld_temp
SetPointer(HourGlass!);
IF isnull(em_1.text) or em_1.text = '0.00' then 
	messagebox('Warning','Please enter valid Atta weight')
	return 1;
end if

IF isnull(em_2.text) or em_2.text = '0.00' then 
	messagebox('Warning','Please enter valid Rice weight')
	return 1;
end if

if isnull(dp_1.text) or dp_1.text = '00/00/0000' or dp_1.text = 'none' then
	messagebox('Warning','Please enter valid From Date')
	return 1;
end if

select max(trunc(lrc_frdt)) into :ld_temp from fb_labourrationchart;
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while checking date of current active ration chart'+sqlca.sqlerrtext)
	rollback using sqlca;
	return 1;
elseif sqlca.sqlcode = 100 then
	messagebox('Error','No record found while checking date of current active ration chart'+sqlca.sqlerrtext)
	rollback using sqlca;
	return 1;
end if

ls_attaper = em_1.text
ls_riceper = em_2.text
ls_frdt = dp_1.text

if date(ls_frdt) <= ld_temp then
	messagebox('Warning','Date should be greater than current active ration chart date')
	return 1
end if 

if (double(ls_attaper)+double(ls_riceper)) <> 100.00 then
	messagebox('Warning','Sum of rice % and atta % should be equal to 100')
	return 1
end if

update fb_labourrationchart set lrc_active_ind = 'N' where  lrc_todt is null and lrc_active_ind = 'Y' ;
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while updating existing records'+sqlca.sqlerrtext)
	rollback using sqlca;
	return 1;
elseif sqlca.sqlcode = 100 then
	messagebox('Error','No record found while updating existing records'+sqlca.sqlerrtext)
	rollback using sqlca;
	return 1;
end if


insert into fb_labourrationchart
select LRC_MAJORMINORFLAG, LRC_LABOURTYPE,  ((:ls_riceper/100)*(LRC_RICEWT + LRC_ATTAWT)) LRC_RICEWT, ((:ls_attaper/100)*(LRC_RICEWT + LRC_ATTAWT)) LRC_ATTAWT, LRC_RICERATE, LRC_ATTARATE, LRC_NOWORKDAYS, FIELD_ID, LRC_MINWORKDAYS, LRC_ADULTALLOW, LRC_CHILDALLALLOW, ((:ls_riceper/100)*(LRC_RICEWT + LRC_ATTAWT)*LRC_RICERATE) LRC_RICEAMO, ((:ls_attaper/100)*(LRC_RICEWT + LRC_ATTAWT)*LRC_ATTARATE) LRC_ATTAAMO, :gs_user LRC_ENTRY_BY, trunc(sysdate) LRC_ENTRY_DT, 'Y' LRC_ACTIVE_IND, trunc(to_date(:ls_frdt,'dd/mm/yyyy')) LRC_FRDT, LRC_TODT
from fb_labourrationchart where lrc_todt is null and lrc_active_ind = 'N' ;
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while inserting new records '+sqlca.sqlerrtext)
	rollback using sqlca;
	return 1;
elseif sqlca.sqlcode = 100 then
	messagebox('Error','No record found while inserting new records'+sqlca.sqlerrtext)
	rollback using sqlca;
	return 1;
end if 

update fb_labourrationchart set lrc_todt = trunc(to_date(:ls_frdt,'dd/mm/yyyy'))-1 where  lrc_todt is null and lrc_active_ind = 'N';

if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while updating existing records'+sqlca.sqlerrtext)
	rollback using sqlca;
	return 1;
elseif sqlca.sqlcode = 100 then
	messagebox('Error','No record found while updating existing records'+sqlca.sqlerrtext)
	rollback using sqlca;
	return 1;
end if 


commit using sqlca;
	messagebox('Confirmation','The Ration Ration has been successfully updated, Please Check....!',information!)
SetPointer(arrow!);
end event

type st_1 from statictext within w_gtelaf048
integer x = 485
integer y = 60
integer width = 585
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Ration Ratio Updation"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_1 from editmask within w_gtelaf048
integer x = 553
integer y = 620
integer width = 174
integer height = 76
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type em_2 from editmask within w_gtelaf048
integer x = 837
integer y = 620
integer width = 174
integer height = 76
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

