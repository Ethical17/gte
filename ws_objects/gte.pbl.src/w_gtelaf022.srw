$PBExportHeader$w_gtelaf022.srw
forward
global type w_gtelaf022 from window
end type
type cbx_1 from checkbox within w_gtelaf022
end type
type ddlb_1 from dropdownlistbox within w_gtelaf022
end type
type cb_2 from commandbutton within w_gtelaf022
end type
type cb_1 from commandbutton within w_gtelaf022
end type
type st_1 from statictext within w_gtelaf022
end type
end forward

global type w_gtelaf022 from window
integer width = 1563
integer height = 980
boolean titlebar = true
string title = "(w_gtelaf022) Process-Ration"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
boolean center = true
cbx_1 cbx_1
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
st_1 st_1
end type
global w_gtelaf022 w_gtelaf022

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
string ls_childcur_ind,ls_msp_ty,ls_msp_field,ls_major_dep,ls_rcno, ls_child_name
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
							  
							  update fb_labourspouse set last_ration_given = to_date(:fs_start_dt,'dd/mm/yyyy') where labour_id=:fs_labour and spouse_active='1';
							  if sqlca.sqlcode = -1 then
								messagebox('Error', 'Error occured while updating last ration given date of spouse : '+sqlca.sqlerrtext)
								return 1
							end if
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
 			  where ld.labour_id=lsp.labour_id and ld.child_active='1'  and spouse_active='1' and lsp.spouse_id= :fs_labour;
				
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
					select rownum, child_name, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
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
						
						fetch c2 into :ll_nochild, :ls_child_name, :ld_noy;
						
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
						
						 update fb_labourdependent set last_ration_given = to_date(:fs_start_dt,'dd/mm/yyyy') where 
						 labour_id=:fs_labour and child_name = :ls_child_name  and child_active='1' and  child_marital = 'U' and 
							(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
							   ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES') or
								(:ls_umgirl='Y' and CHILD_DEPENDENTTYPE = 'CHILD' and CHILD_GENDER = 'F' and child_marital = 'U' ));
								
						  if sqlca.sqlcode = -1 then
							messagebox('Error', 'Error occured while updating last ration given date of dependent (Labour ID : '+fs_labour+ ' Child name : '+ ls_child_name+' ) [cursor c2] : '+sqlca.sqlerrtext)
							return 1
						end if
						
						if ll_nochild = ll_nodep then
							exit
						end if
						fetch c2 into :ll_nochild, :ls_child_name, :ld_noy;
					loop
					close c2;
							  //end ration for child

			elseif ls_childcur_ind = 'B' then
				declare c21 cursor for
					select rownum, child_name, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
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
					
						fetch c21 into :ll_nochild, :ls_child_name, :ld_noy;
						
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
						
						 update fb_labourdependent set last_ration_given = to_date(:fs_start_dt,'dd/mm/yyyy') where 
						 labour_id= (select labour_id from fb_labourspouse where spouse_id= :fs_labour )
						 and child_name = :ls_child_name  and child_active='1' and  child_marital = 'U' and 
						(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
							( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES') or
							(:ls_umgirl='Y' and CHILD_DEPENDENTTYPE = 'CHILD' and CHILD_GENDER = 'F' and child_marital = 'U' ));
									
						  if sqlca.sqlcode = -1 then
							messagebox('Error', 'Error occured while updating last ration given date of dependent (Spouse of Labour ID : '+fs_labour+ ' Child name : '+ ls_child_name+' ) [cursor c21] : '+sqlca.sqlerrtext)
							return 1
						end if
						
						if ll_nochild = ll_nodep then
							exit
						end if
						fetch c21 into :ll_nochild, :ls_child_name, :ld_noy;
					loop
					close c21;
							  //end ration for child

			end if
			


		ElseIf fs_emp_sex = 'F' And fs_lab_marital = 'M' Then //female labour

               //	start find whether male spouse is working or not
               select lsp.labour_id labour_id into :ls_temp from fb_labourspouse lsp,fb_employee emp 
			 where emp.emp_id=lsp.labour_id 
			 and emp.emp_type in ('LP','SS','ST') 
			 and spouse_id=:fs_labour  
			 and spouse_active='1' 
			 and (emp_active = '1' or EMP_JOBLEAVINGDATE=TO_DATE('30-Nov-2024', 'DD-Mon-YYYY'));

			if sqlca.sqlcode  = 100 then	//start ration for child

					if ls_childcur_ind = 'A' then
						declare c3 cursor for
							select rownum, child_name, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
							from fb_labourdependent ld
							where labour_id=:fs_labour  and ld.child_active='1' and  child_marital = 'U' and 
									(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
										( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES') or
								(:ls_umgirl='Y' and CHILD_DEPENDENTTYPE = 'CHILD' and CHILD_GENDER = 'F' and child_marital = 'U' ));

							open c3;
							
								fetch c3 into :ll_nochild,:ls_child_name,:ld_noy;
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
								
								update fb_labourdependent set last_ration_given = to_date(:fs_start_dt,'dd/mm/yyyy') where 
								 labour_id=:fs_labour and child_name = :ls_child_name  and child_active='1' and  child_marital = 'U' and 
									(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
										( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES') or
										(:ls_umgirl='Y' and CHILD_DEPENDENTTYPE = 'CHILD' and CHILD_GENDER = 'F' and child_marital = 'U' ));
										
								  if sqlca.sqlcode = -1 then
									messagebox('Error', 'Error occured while updating last ration given date of dependent (Labour ID : '+fs_labour+ ' Child name : '+ ls_child_name+' ) [cursor c3] : '+sqlca.sqlerrtext)
									return 1
								end if
						
								if ll_nochild = ll_nodep then
									exit
								end if
							fetch c3 into :ll_nochild,:ls_child_name,:ld_noy;
							loop
						  close c3; //end ration for child
		
					elseif ls_childcur_ind = 'B' then
						declare c31 cursor for
							select rownum, child_name, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
							from fb_labourdependent ld,fb_labourspouse lsp 
							where ld.labour_id=lsp.labour_id and ld.child_active='1' and lsp.spouse_id= :fs_labour and ld.child_active='1' and  child_marital = 'U' and 
								(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
									( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES') or
								(:ls_umgirl='Y' and CHILD_DEPENDENTTYPE = 'CHILD' and CHILD_GENDER = 'F' and child_marital = 'U' ));


							open c31;
							
								fetch c31 into :ll_nochild,:ls_child_name,:ld_noy;
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
								
								 update fb_labourdependent set last_ration_given = to_date(:fs_start_dt,'dd/mm/yyyy') where 
								 labour_id= (select labour_id from fb_labourspouse where spouse_id= :fs_labour )
								 and child_name = :ls_child_name  and child_active='1' and  child_marital = 'U' and 
								(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
									( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES') or
									(:ls_umgirl='Y' and CHILD_DEPENDENTTYPE = 'CHILD' and CHILD_GENDER = 'F' and child_marital = 'U' ));
											
								  if sqlca.sqlcode = -1 then
									messagebox('Error', 'Error occured while updating last ration given date of dependent (Spouse of Labour ID : '+fs_labour+ ' Child name : '+ ls_child_name+' ) [cursor c31] : '+sqlca.sqlerrtext)
									return 1
								end if								
						
								if ll_nochild = ll_nodep then
									exit
								end if
							fetch c31 into :ll_nochild,:ls_child_name,:ld_noy;
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
							select rownum, child_name, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
							from fb_labourdependent ld 
							where labour_id=:fs_labour  and ld.child_active='1' and  child_marital = 'U' and 
									(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
									   ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES') or
								(:ls_umgirl='Y' and CHILD_DEPENDENTTYPE = 'CHILD' and CHILD_GENDER = 'F' and child_marital = 'U' ));

						open c4;
						
							fetch c4 into :ll_nochild, :ls_child_name :ld_noy;
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
							
							update fb_labourdependent set last_ration_given = to_date(:fs_start_dt,'dd/mm/yyyy') where 
							 labour_id=:fs_labour and child_name = :ls_child_name  and child_active='1' and  child_marital = 'U' and 
								(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
									( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES') or
									(:ls_umgirl='Y' and CHILD_DEPENDENTTYPE = 'CHILD' and CHILD_GENDER = 'F' and child_marital = 'U' ));
									
							  if sqlca.sqlcode = -1 then
								messagebox('Error', 'Error occured while updating last ration given date of dependent (Labour ID : '+fs_labour+ ' Child name : '+ ls_child_name+' ) [cursor c4] : '+sqlca.sqlerrtext)
								return 1
							end if							
					
							if ll_nochild = ll_nodep then
								exit
							end if
						fetch c4 into :ll_nochild, :ls_child_name :ld_noy;
						loop
					  close c4; //end ration for child
		
					elseif ls_childcur_ind = 'B' then
						declare c41 cursor for
							select rownum, child_name, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
							from fb_labourdependent ld,fb_labourspouse lsp 
							where ld.labour_id=lsp.labour_id and ld.child_active='1' and lsp.spouse_id= :fs_labour and ld.child_active='1' and  child_marital = 'U' and 
									(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
										( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES') or
								(:ls_umgirl='Y' and CHILD_DEPENDENTTYPE = 'CHILD' and CHILD_GENDER = 'F' and child_marital = 'U' ));
						open c41;
						
							fetch c41 into :ll_nochild, :ls_child_name, :ld_noy;
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
							
							 update fb_labourdependent set last_ration_given = to_date(:fs_start_dt,'dd/mm/yyyy') where 
							 labour_id= (select labour_id from fb_labourspouse where spouse_id= :fs_labour )
							 and child_name = :ls_child_name  and child_active='1' and  child_marital = 'U' and 
							(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_wsage) or
								( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES') or
								(:ls_umgirl='Y' and CHILD_DEPENDENTTYPE = 'CHILD' and CHILD_GENDER = 'F' and child_marital = 'U' ));
										
							  if sqlca.sqlcode = -1 then
								messagebox('Error', 'Error occured while updating last ration given date of dependent (Spouse of Labour ID : '+fs_labour+ ' Child name : '+ ls_child_name+' ) [cursor c41] : '+sqlca.sqlerrtext)
								return 1
							end if									
					
							if ll_nochild = ll_nodep then
								exit
							end if
						fetch c41 into :ll_nochild, :ls_child_name, :ld_noy;
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

on w_gtelaf022.create
this.cbx_1=create cbx_1
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.Control[]={this.cbx_1,&
this.ddlb_1,&
this.cb_2,&
this.cb_1,&
this.st_1}
end on

on w_gtelaf022.destroy
destroy(this.cbx_1)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
end on

event open;
if date(gd_dt) <> today() then
	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
	return 1
end if

string ls_dt
declare c1 cursor for
select to_char(rpfw_STARTDATE,'dd/mm/yyyy')||' - '|| to_char(rpfw_ENDDATE,'dd/mm/yyyy')||' [ '|| RPFW_EMP_TYPE||' ]'||' ('||RPFW_ID||')'
from fb_rationperiodforweek	 
where nvl(RPFW_PAIDFLAG,'0')='0'
order by  rpfw_STARTDATE desc;

open c1;

if sqlca.sqlcode = -1 then 
	messagebox('Error At Cursor','Error During Opening Cursor');
	return 1;
else
	setnull(ls_dt);
	fetch c1 into :ls_dt;	
	do while sqlca.sqlcode <> 100 
	
		ddlb_1.additem(ls_dt);
	
		setnull(ls_dt);
		fetch c1 into :ls_dt;	
	loop
	close c1;
end if;

this.tag = Message.StringParm
ll_user_level = long(this.tag)

if gs_garden_snm ='MT' then
	cbx_1.checked = true
	cbx_1.visible= true	
else
	cbx_1.visible= false	
end if

end event

type cbx_1 from checkbox within w_gtelaf022
boolean visible = false
integer x = 640
integer y = 372
integer width = 416
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Calculate ELP"
end type

type ddlb_1 from dropdownlistbox within w_gtelaf022
integer x = 101
integer y = 188
integer width = 1408
integer height = 480
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_gtelaf022
integer x = 914
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

type cb_1 from commandbutton within w_gtelaf022
integer x = 398
integer y = 612
integer width = 494
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Calculation Ration"
boolean default = true
end type

event clicked;string ls_cal_flag,ls_dt,ls_labour,ls_emp_sex,ls_lab_ty,ls_lab_marital,ls_field_id,ls_dob,ls_rcardno,ls_LS_ID
string ls_lrw_id,ls_fr_dt,ls_to_dt, ls_wr_emptype
double ld_workdaysration,ld_ration_rndoff

SetPointer(HourGlass!);

ls_dt = left(ddlb_1.text,10)
ls_lrw_id = left(right(ddlb_1.text,15),14)

//ls_lrw_id = left(right(ddlb_1.text,9),8)

if isnull(ls_dt) then 
	messagebox('Error At Date','Wages Start Date Should Be Entered, Please Check !!!')
	return 1
end if;

select RPFW_ID,RPFW_EMP_TYPE,RPFW_CALFLAG,to_char(RPFW_STARTDATE,'dd/mm/yyyy'),to_char(RPFW_ENDDATE,'dd/mm/yyyy')
    into :ls_lrw_id,:ls_wr_emptype,:ls_cal_flag,:ls_fr_dt,:ls_to_dt
  from fb_rationperiodforweek 
where RPFW_STARTDATE = to_date(:ls_dt,'dd/mm/yyyy') and RPFW_PAIDFLAG ='0' and RPFW_ID = :ls_lrw_id;

if sqlca.sqlcode =100 then
	messagebox('Wages Week Select ','Either the there is no such week or the ration against this week has been paid, Please Check...!')
	return 1
elseif sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Wages Week Select ',sqlca.sqlerrtext)
	return 1
end if;

select nvl(pd_value,0)	 into :ld_ration_rndoff from fb_param_detail 
where pd_doc_type = 'RICATARNDOFF' and to_date(:ls_dt,'dd/mm/yyyy') between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));

if sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Ration Parametere checking ',sqlca.sqlerrtext)
	return -1
end if;
	
if isnull(ld_ration_rndoff) then ld_ration_rndoff=0


if Ls_cal_flag='1' then
	if ll_user_level = 1 then
		if messagebox("Warning","The ration/ELP against this week has been calculated, Do you want to re-calculate",question!,yesno!)=1 then
			
			delete from fb_labourweeklyration where lrw_id = :ls_lrw_id;
        		if sqlca.sqlcode = -1 then
				messagebox('SQL ERROR: During Ration (Delete)',sqlca.sqlerrtext)
				return 1
			end if;
			
//			if gs_garden_snm = 'MT' then
//
//				delete from FB_LABELPDETAILS where LRW_ID = :ls_lrw_id;
//					if sqlca.sqlcode = -1 then
//					messagebox('SQL ERROR: During ELP Detail (Delete)',sqlca.sqlerrtext)
//					return 1
//				end if;
//			end if;
			
			update fb_rationperiodforweek set RPFW_CALFLAG ='0',RPFW_RICEWT=0,RPFW_ATTAWT=0
			where RPFW_ID = :ls_lrw_id;
			
			if sqlca.sqlcode = -1 then
				messagebox('SQL ERROR: During Ration Period (Update)',sqlca.sqlerrtext)
				return 1
			end if;
			
			commit using sqlca;

		else
			return 1
		end if	
	else
		messagebox("Warning","The ration/ELP against this week has been calculated, You Can not re-calculate",information!)
		return 1
	end if
	
end if

id_totricequan=0;id_totattaquan=0

//HOLIDAYNOPAY, SICKNOWAGES

//	  (kam.kamsub_nkamtype IN ('HOLIDAYNOPAY') AND :gs_garden_snm = 'MT') OR  As per MT Issue No : C0000184 this is removed on 08.01.2013

declare c1 cursor for 
SELECT   emp.emp_id labour_id, nvl(no_workdays,0) no_workdays, emp.emp_sex emp_sex, emp.emp_type emp_type, 
		     emp.emp_marital emp_marital, emp.field_id field_id, to_char(emp.emp_dob,'dd/mm/yyyy') dob, 
			  NVL (emp.emp_rationcardno, 0) rcardno ,LS_ID
  FROM fb_employee emp, 
  			( select lda.labour_id labour_id ,count(lda_status) no_workdays from fb_labourdailyattendance lda ,fb_kamsubhead kam 
			  WHERE lda.kamsub_id = kam.kamsub_id AND nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lda.lda_date between to_date(:ls_fr_dt,'dd/mm/yyyy') and  to_date(:ls_to_dt,'dd/mm/yyyy') and 
						( (lda.lda_wages > 0 AND kam.kamsub_nkamtype NOT IN ('SICKNOWAGES', 'SICKALLOWANCE', 'MATERNITY') ) OR 
						  (lda.lda_wages > 0 AND kam.kamsub_nkamtype IN ('SICKALLOWANCE', 'MATERNITY') AND ((:gs_garden_snm <> 'MT') or (:gs_garden_snm = 'MT' and lda.lda_nature = 'OUT')) ) OR 
						  (kam.kamsub_nkamtype IN ('HOLIDAYNOPAY', 'SICKNOWAGES') 
						  //AND :gs_garden_snm in ('FB','MT','MR','SP','LP','AB','AD','MH','DR') commented on 01/04/2020 as a temporary change for lockdown on advise of Ghosh Sir
						  ) OR
						  (kam.kamsub_nkamtype IN ('ANNUALLEAVE')) ) 
			group by lda.labour_id ) lda
 WHERE lda.labour_id(+) = emp.emp_id AND emp.emp_type = :ls_wr_emptype and ls_id in (select ls_id from fb_laboursheet where nvl(LS_RATIONCALFLAG,'Y') = 'Y');
// and emp.emp_id = 'T22732';
 //and EMP_ACTIVE='1'// and emp.emp_id ='LB00026'
// UNION ALL 
// SELECT   emp.emp_id labour_id, SUM (attdays) no_workdays, MAX (emp.emp_sex) emp_sex, MAX (emp.emp_type) emp_type, 
//              MAX (emp.emp_marital) emp_marital, MAX (emp.field_id) field_id, to_char(MAX (emp.emp_dob),'dd/mm/yyyy') dob, 
//				  MAX (NVL (emp.emp_rationcardno, 0)) rcardno ,LS_ID
//   FROM (SELECT   ea.emp_id emp_id, DECODE (SIGN (COUNT (ea.eatten_status) - 7), 1, 6, COUNT (ea.eatten_status) ) attdays 
//                   FROM fb_empattendance ea
//                  WHERE ea.eatten_date between to_date(:ls_fr_dt,'dd/mm/yyyy') and  to_date(:ls_to_dt,'dd/mm/yyyy') AND  (ea.eatten_status NOT IN ('AB', 'SI', 'MI')) 
//			GROUP BY ea.emp_id 
//			 UNION ALL 
//			  SELECT et.emp_id emp_id, DECODE (et.eatten_status, 'AB', -0, 'SI', -0, 'MI', -0,-1) attdays 
//				  FROM fb_empattendance et WHERE TO_CHAR (et.eatten_date, 'DY') = 'SUN' AND 
//						et.eatten_date between to_date(:ls_fr_dt,'dd/mm/yyyy') and  to_date(:ls_to_dt,'dd/mm/yyyy'))  atn,fb_employee emp
//	where atn.emp_id = emp.emp_id  and emp.emp_type = :ls_wr_emptype and ls_id in (select ls_id from fb_laboursheet where nvl(LS_RATIONCALFLAG,'Y') = 'Y')
//group by emp.emp_id ,LS_ID;

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return 1; 
else 

	ld_workdaysration= 0; 
	setnull(ls_labour);setnull(ls_emp_sex);setnull(ls_lab_ty);setnull(ls_lab_marital);setnull(ls_field_id);setnull(ls_dob);setnull(ls_rcardno);setnull(ls_LS_ID)

			  
	fetch c1 into :ls_labour,:ld_workdaysration,:ls_emp_sex,:ls_lab_ty,:ls_lab_marital,:ls_field_id,:ls_dob,:ls_rcardno,:ls_LS_ID;
	do while sqlca.sqlcode <> 100 
		
		if ld_workdaysration > 0 then	
						
			setnull(is_adultallow);setnull(is_childallallow)
			id_lmajattawt=0;id_lmajricewt=0;id_lmajattaprice=0;id_lmajriceprice=0;id_minworkdays=0;id_ldepmajattawt=0;id_ldepmajricewt=0;
			id_ldepmajattaprice=0;id_ldepmajriceprice=0;id_lminattawt=0;id_lminricewt=0;id_lminattaprice=0;id_lminriceprice=0;id_ldepminattawt=0;id_ldepminricewt=0;
			id_ldepminattaprice=0;id_ldepminriceprice=0;
			
			if gs_garden_snm = 'MV' or gs_garden_snm = 'MF' or gs_garden_snm = 'JP' then
				select ((to_date(:ls_fr_dt,'dd/mm/yyyy') - emp_dob) /365)  into :ld_labage  from fb_employee emp  where emp.emp_id = :ls_labour;
	
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Age Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			end if
			
			if (gs_garden_snm <> 'MV' and gs_garden_snm <> 'MF' and gs_garden_snm <> 'JP') or ((gs_garden_snm = 'MV' or gs_garden_snm = 'MF' or gs_garden_snm = 'JP') and ld_labage >= 18) then
			
				select sum(decode(trim(lrc_majorminorflag),'MAJOR',lrc_attawt,0)),sum(decode(trim(lrc_majorminorflag),'MAJOR',lrc_ricewt,0)),
						sum(decode(trim(lrc_majorminorflag),'MAJOR',lrc_attarate,0)),sum(decode(trim(lrc_majorminorflag),'MAJOR',lrc_ricerate,0)),
						sum(decode(trim(lrc_majorminorflag),'MAJOR',lrc_minworkdays,0)),
						max(decode(trim(lrc_majorminorflag),'MAJOR',lrc_adultallow,null)),max(decode(trim(lrc_majorminorflag),'MAJOR',lrc_childallallow,null)),
						sum(decode(trim(lrc_majorminorflag),'DEPMAJ',lrc_attawt,0)),sum(decode(trim(lrc_majorminorflag),'DEPMAJ',lrc_ricewt,0)),
						sum(decode(trim(lrc_majorminorflag),'DEPMAJ',lrc_attarate,0)),sum(decode(trim(lrc_majorminorflag),'DEPMAJ',lrc_ricerate,0)),
						sum(decode(trim(lrc_majorminorflag),'MINOR',lrc_attawt,0)),sum(decode(trim(lrc_majorminorflag),'MINOR',lrc_ricewt,0)),
						sum(decode(trim(lrc_majorminorflag),'MINOR',lrc_attarate,0)),sum(decode(trim(lrc_majorminorflag),'MINOR',lrc_ricerate,0)),
						sum(decode(trim(lrc_majorminorflag),'DEPMIN',lrc_attawt,0)),sum(decode(trim(lrc_majorminorflag),'DEPMIN',lrc_ricewt,0)),
						sum(decode(trim(lrc_majorminorflag),'DEPMIN',lrc_attarate,0)),sum(decode(trim(lrc_majorminorflag),'DEPMIN',lrc_ricerate,0))
					into :id_lmajattawt,:id_lmajricewt,:id_lmajattaprice,:id_lmajriceprice,:id_minworkdays,:is_adultallow,:is_childallallow,
						  :id_ldepmajattawt,:id_ldepmajricewt,:id_ldepmajattaprice,:id_ldepmajriceprice,
						  :id_lminattawt,:id_lminricewt,:id_lminattaprice,:id_lminriceprice,:id_ldepminattawt,:id_ldepminricewt,
						  :id_ldepminattaprice,:id_ldepminriceprice
				  from fb_labourrationchart 
				 where field_id=:ls_field_id and lrc_labourtype=decode(:ls_lab_ty,'LT','LT','LO','LT','LP') and to_date(:ls_fr_dt,'dd/mm/yyyy') between LRC_FRDT and nvl(LRC_TODT,trunc(sysdate)) and
						 lrc_noworkdays=(select min(lrc_noworkdays) from fb_labourrationchart 
												 where lrc_noworkdays>=decode(:ld_workdaysration,13,12,14,12,:ld_workdaysration) and field_id=:ls_field_id and lrc_labourtype=decode(:ls_lab_ty,'LT','LT','LO','LT','LP') and
														 to_date(:ls_fr_dt,'dd/mm/yyyy') between LRC_FRDT and nvl(LRC_TODT,trunc(sysdate)) );
	
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Ration Rates Select : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return 1; 
				end if;
	
				if ld_workdaysration >= id_minworkdays then
					ls_ration_alw = 'Y'
						If gs_garden_snm = 'MT' and ls_emp_sex = 'F' And ls_lab_marital = 'M' Then //female labour
							 //	start find whether male spouse is working or not
							select lsp.spouse_id into :ls_temp from fb_labourspouse lsp,fb_employee emp 
								 where emp.emp_id = lsp.labour_id and emp.emp_type in ('LP','SS','ST') and emp.emp_id = :ls_labour  and spouse_active='1';
							if sqlca.sqlcode = -1 then
								messagebox('Sql Error : During Getting Spouse Working Details: ',sqlca.sqlerrtext); 
								rollback using sqlca; 
								return 1; 
							elseif sqlca.sqlcode  = 0 then	
								select distinct 'x' into :ls_tmp2 from fb_employee where emp_id = :ls_temp  and EMP_ACTIVE = '1';
								if sqlca.sqlcode = -1 then
									messagebox('Sql Error : During Getting Spouse Active Details: ',sqlca.sqlerrtext); 
									rollback using sqlca; 
									return 1; 
								elseif sqlca.sqlcode  = 0 then	
									ls_ration_alw = 'N'
								elseif sqlca.sqlcode  = 100 then	
									ls_ration_alw = 'Y'
								end if
							elseif sqlca.sqlcode  = 100 then	
								ls_ration_alw = 'Y'
							end if
						end if
						if isnull(ls_ration_alw) then ls_ration_alw = 'N';
						
						if (gs_garden_snm <> 'MT' or (gs_garden_snm = 'MT' and ls_ration_alw = 'Y')) then
							if (ls_lab_ty = 'LP' or ls_lab_ty = 'LT' ) then
									id_ration = Round(wf_calculate_ration(ls_labour,ls_lab_ty, ls_lab_marital, ld_workdaysration, ls_emp_sex,ls_fr_dt,ls_lrw_id), 2)
							elseif (ls_lab_ty ='LO' ) then
								id_ration = Round(wf_calculate_ration(ls_labour,'LT', ls_lab_marital, ld_workdaysration, ls_emp_sex,ls_fr_dt,ls_lrw_id), 2)
							else
								id_ration = Round(wf_emp_calration(ls_labour,ls_lab_ty, ls_lab_marital, ld_workdaysration, ls_emp_sex,ls_fr_dt,ls_lrw_id), 2)
							end if
							id_ration = id_ration - Round((id_lmajriceprice * (id_labricewt - Round(id_labricewt, ld_ration_rndoff))) + (id_lmajattaprice * (id_labattawt - Round(id_labattawt,ld_ration_rndoff))) , 2)
							id_labricewt = Round(id_labricewt, ld_ration_rndoff)
							id_labattawt = Round(id_labattawt, ld_ration_rndoff)
						else
							 id_ration = 0
							 id_labricewt = 0
							 id_labattawt = 0
							 id_no_lab_depminor = 0
							 id_no_lab_depmajor = 0							
						end if
						
				else
						 id_ration = 0
						 id_labricewt = 0
						 id_labattawt = 0
						 id_no_lab_depminor = 0
						 id_no_lab_depmajor = 0
				end if
			else
				 id_ration = 0
				 id_labricewt = 0
				 id_labattawt = 0
				 id_no_lab_depminor = 0
				 id_no_lab_depmajor = 0
			end if
//			if gs_garden_snm <> 'MK' then
				if isnull(ls_rcardno) or len(trim(ls_rcardno))=0 then
					 id_ration = 0
					 id_labricewt = 0
					 id_labattawt = 0
					 id_no_lab_depminor = 0
					 id_no_lab_depmajor = 0
				end if
	//		end if			
	//		if cbx_1.checked then
	//		   if wf_elpcal(ls_labour,ls_fr_dt,ls_to_dt,ls_lrw_id) = - 1 then
	//				return 1
	//		   end if
	//		end if
			id_netpayable = 0; id_elp_bf = 0; id_elp_cf = 0; id_elp = 0; id_penalty = 0;
			
				insert into fb_labourweeklyration(lrw_id,labour_id,lwr_ricewt,lwr_attawt,lwr_rationded,lwr_nomin,lwr_nomaj,lwr_workdays,
				  lwr_elp,ls_id,LWR_GL,lwr_taskgl,lwr_coinbf,lwr_lastcoinbf,lwr_netelp,field_id,lwr_emptype,lwr_penalty)
			 values( :ls_lrw_id,:ls_labour,:id_labricewt,:id_labattawt,:id_ration,:id_no_lab_depminor,:id_no_lab_depmajor,:ld_workdaysration,
						:id_elp,:ls_LS_ID,0,0,nvl(:id_elp_cf,0) ,nvl(:id_elp_bf,0),nvl(:id_netpayable,0),:ls_field_id,:ls_lab_ty,nvl(:id_penalty,0));
						 
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Ration Calculation (Insert): ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return 1; 
			end if;
			
			ld_workdaysration= 0; 
		end if
		setnull(ls_labour);setnull(ls_emp_sex);setnull(ls_lab_ty);setnull(ls_lab_marital);setnull(ls_field_id);setnull(ls_dob);setnull(ls_rcardno);setnull(ls_LS_ID)
		fetch c1 into :ls_labour,:ld_workdaysration,:ls_emp_sex,:ls_lab_ty,:ls_lab_marital,:ls_field_id,:ls_dob,:ls_rcardno,:ls_LS_ID;
	loop;
	close c1;

	update fb_rationperiodforweek set RPFW_CALFLAG ='1',RPFW_RICEWT=:id_totricequan,RPFW_ATTAWT=:id_totattaquan
	where RPFW_ID = :ls_lrw_id;
	

	if sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Ration Period (Update)',sqlca.sqlerrtext)
		return 1
	end if;
        
	commit using sqlca;
	messagebox('Confirmation','The Ration Has Been Sucessfully Calculate, Please Check....!',information!)
end if;
setpointer(arrow!)

end event

type st_1 from statictext within w_gtelaf022
integer x = 535
integer y = 112
integer width = 416
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Ration Period"
alignment alignment = center!
boolean focusrectangle = false
end type

