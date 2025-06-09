$PBExportHeader$w_gtehrf010.srw
forward
global type w_gtehrf010 from window
end type
type ddlb_1 from dropdownlistbox within w_gtehrf010
end type
type cb_2 from commandbutton within w_gtehrf010
end type
type cb_1 from commandbutton within w_gtehrf010
end type
type st_1 from statictext within w_gtehrf010
end type
end forward

global type w_gtehrf010 from window
integer width = 1563
integer height = 980
boolean titlebar = true
string title = "(w_gtehrf010) Process-Ration (Sub Staff)"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
boolean center = true
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
st_1 st_1
end type
global w_gtehrf010 w_gtehrf010

type variables
string is_adultallow,is_childallallow,ls_frdt,ls_cal_flag,ls_wr_emptype
long ll_user_level
double id_ration, id_totricequan,id_totattaquan,id_lmajattawt,id_lmajricewt,id_lmajattaprice,id_lmajriceprice,id_minworkdays, id_ldepmajattawt,id_ldepmajricewt,id_ldepmajattaprice,id_ldepmajriceprice, &
            id_lminattawt,id_lminricewt,id_lminattaprice,id_lminriceprice,id_ldepminattawt,id_ldepminricewt, id_ldepminattaprice,id_ldepminriceprice,id_labricewt,id_labattawt,id_no_lab_depminor,id_no_lab_depmajor, &
		 id_elp_cf ,id_elp,id_penalty,id_elp_bf,id_netpayable, ld_absdays,ll_nodepmajor2
end variables

forward prototypes
public function double wf_calculate_ration (string fs_labour, string fs_lab_ty, string fs_lab_marital, double fd_attndays, string fs_emp_sex, string fs_start_dt, string fs_lww_id)
public function integer wf_elpcal (string fs_labour_id, string fs_fr_dt, string fs_to_dt, string fs_lrw_id)
public function double wf_emp_calration (string fs_labour, string fs_lab_ty, string fs_lab_marital, double fd_attndays, string fs_emp_sex, string fs_start_dt, string fs_lww_id)
end prototypes

public function double wf_calculate_ration (string fs_labour, string fs_lab_ty, string fs_lab_marital, double fd_attndays, string fs_emp_sex, string fs_start_dt, string fs_lww_id);Double ld_rationprice ,ld_msp_attndays,ld_mindaysmspouse,ld_noy
long ll_nochild 
string ls_childcur_ind,ls_temp,ls_msp_ty,ls_msp_field,ls_major_dep
string ls_spouse,ls_mchild,ls_wsister,ls_umsister,ls_wmother
long ll_mstage,ll_wsage,ll_sage,ll_minorage,ll_nodep

  ll_nochild  = 0

  id_labricewt=0;id_labattawt=0;id_no_lab_depminor=0;id_no_lab_depmajor=0 

  ld_rationprice = 0
  
  select RP_SPOUSE_IND, RP_CH_IND, rp_major_dpind,nvl(RP_CH_STARTAGE,0), nvl(RP_CH_WSCH_AGE,0), nvl(RP_CH_SCH_AGE,0), nvl(RP_MINOR_DEPAGE,0), nvl(RP_NOOF_DEP,0),RP_WIDOW_SISTER, RP_UNMARRIED_SISTER, RP_WIDOW_MOTHER
  into :ls_spouse,:ls_mchild,:ls_major_dep,:ll_mstage,:ll_wsage,:ll_sage,:ll_minorage,:ll_nodep,:ls_wsister,:ls_umsister,:ls_wmother
  from fb_rationparam where RP_EMPTYPE = :fs_lab_ty and to_date(:fs_start_dt,'dd/mm/yyyy') between RP_PERIOD_FROM and nvl(RP_PERIOD_TO,trunc(sysdate));

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Ration Parameter Select : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
end if;

  If fd_attndays >= id_minworkdays Then
    //start ration for self
     If fs_lab_ty = 'LP' or fs_lab_ty = 'LT' Then
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
							   ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES'));

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
							   ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES'));

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
										( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES'));

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
									( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES'));


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
						  where lda.kamsub_id=kam.kamsub_id and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' group by (lda.lww_id,lda.labour_id,kam.kamsub_nkamtype) ) lkw,fb_labourspouse lsp,fb_employee emp 
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
										( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between :ll_mstage and :ll_sage and child_schoolflag='YES'));
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

declare c1 cursor for 
select ROUND(lda.LDA_TASK,0) TASK,(nvl(LDA_MFJ_COUNT1,0) + nvl(LDA_MFJ_COUNT2,0) + nvl(LDA_MFJ_COUNT3,0)) glcount 
from fb_labourdailyattendance lda
where lda.labour_id = :fs_labour_id and lda.lda_date between to_date(:fs_fr_dt,'dd/mm/yyyy') and  to_date(:fs_to_dt,'dd/mm/yyyy') and
           nvl(LDA_ELP,0) >0 order by lda.lda_date;

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 

	ld_gl= 0; ld_task= 0; ls_elpdet=""

	fetch c1 into :ld_task,:ld_gl;
	do while sqlca.sqlcode <> 100 
		ls_elpdet = ls_elpdet + string(ld_gl, "00") + "   " + string(ld_task, "00")
		ld_gl= 0; ld_task= 0; 
		fetch c1 into :ld_task,:ld_gl;
	loop;
	close c1;
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
string ls_childcur_ind,ls_temp,ls_msp_ty,ls_msp_field,ls_major_dep
string ls_spouse,ls_mchild,ls_wsister,ls_umsister,ls_wmother
long ll_mstage,ll_wsage,ll_sage,ll_minorage,ll_nodep

  ll_nochild  = 0

  id_labricewt=0;id_labattawt=0;id_no_lab_depminor=0;id_no_lab_depmajor=0 

  ld_rationprice = 0
  
  select RP_SPOUSE_IND, RP_CH_IND,rp_major_dpind, nvl(RP_CH_STARTAGE,0), nvl(RP_CH_WSCH_AGE,0), nvl(RP_CH_SCH_AGE,0), nvl(RP_MINOR_DEPAGE,0), nvl(RP_NOOF_DEP,0),RP_WIDOW_SISTER, RP_UNMARRIED_SISTER, RP_WIDOW_MOTHER
  into :ls_spouse,:ls_mchild,:ls_major_dep,:ll_mstage,:ll_wsage,:ll_sage,:ll_minorage,:ll_nodep,:ls_wsister,:ls_umsister,:ls_wmother
  from fb_rationparam where RP_EMPTYPE = decode(:fs_lab_ty,'SS','LP',:fs_lab_ty) and to_date(:fs_start_dt,'dd/mm/yyyy') between RP_PERIOD_FROM and nvl(RP_PERIOD_TO,trunc(sysdate));

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Ration Parameter Select : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
end if;

//		ll_nomajor = 1
//		 If (ls_emp_type = 'ST' or ls_emp_type = 'AT') And ls_emp_sex = 'M' Then
//	  
//				  select count(1) into :ll_cnt from fb_empspouse esp,fb_employee emp 
//				  where esp.emps_id=emp.emp_id and emp.emp_type in('LP','LT','SS','ST','AT') and esp.emp_id=:ls_emp_id and esp.emps_active='1';
//				  
//			  if ll_cnt =0 then	//SPOUSE IS NOT WORKING
//				ll_cnt=0
//				select count(1) into :ll_cnt from fb_empspouse where emp_id=:ls_emp_id and emps_active='1';
//						 
//				If ll_cnt >= 1 Then //SPOUSE IS ACTIVE
//					ll_nodepmajor = ll_nodepmajor + 1
//				End If
//			 End If
//			 
//				 select sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) - :ll_minorage),1,0,1),0)),
//						 sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) - :ll_minorage),1,1,0),0)),
//						 (nvl(:ll_nodepmajor,0) + sum(decode(empd_maritalstatus,'W',1,0)))
//				 into :ll_nodepminorphase2,:ll_nodepminor,:ll_nodepmajor
//				from fb_empdependents ld
//				where EMP_ID =:ls_emp_id and empd_active='1' and 
//						( (:ls_mchild='Y' and EMPD_DEPENDENTTYPE='CHILD' and  EMPD_MARITALSTATUS ='U' and 
//							(  ( ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) between :ll_mstage and :ll_wsage) or
//									( ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) between :ll_mstage and :ll_sage and EMPD_SCHOOLFLAG='YES')) ) or
//						  (:ls_umgirl='Y' and EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
//						  (:ls_umsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
//						  (:ls_wsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) or
//						  (:ls_wmother='Y' and EMPD_DEPENDENTTYPE='MOTHER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) );
//
//
//					  if sqlca.sqlcode = -1 then
//						Messagebox('SQL ERROR: During Dependent Select (Male)',sqlca.sqlerrtext)
//						return -1
//					  End If
//					  
//		elseIf (ls_emp_type = 'ST' or ls_emp_type = 'AT')  And ls_emp_sex = 'F' Then
//			
//				  select count(1) into :ll_cnt from fb_empspouse esp,fb_employee emp 
//				  where esp.emps_id=emp.emp_id and emp.emp_type in ('ST','AT') and esp.emp_id=:ls_emp_id and esp.emps_active='1';
//				  
//			  if ll_cnt =0 then	//no male spouse as staff for this emp
//				
//				 select sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) - :ll_minorage),1,0,1),0)),
//						 sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) - :ll_minorage),1,1,0),0)),
//						 (nvl(:ll_nodepmajor,0) + sum(decode(empd_maritalstatus,'W',1,0)))
//					into :ll_nodepminorphase2,:ll_nodepminor,:ll_nodepmajor
//				  from fb_empdependents ld
//				where EMP_ID =:ls_emp_id and empd_active='1' and 
//						( (:ls_mchild='Y' and EMPD_DEPENDENTTYPE='CHILD' and  EMPD_MARITALSTATUS ='U' and 
//							(  ( ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) between :ll_mstage and :ll_wsage) or
//									( ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) between :ll_mstage and :ll_sage and EMPD_SCHOOLFLAG='YES')) ) or
//						  (:ls_umgirl='Y' and EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
//						  (:ls_umsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
//						  (:ls_wsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) or
//						  (:ls_wmother='Y' and EMPD_DEPENDENTTYPE='MOTHER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) );
//
//					  if sqlca.sqlcode = -1 then
//						Messagebox('SQL ERROR: During Dependent Select (Male)',sqlca.sqlerrtext)
//						return -1
//					  End If
//			  end if
//		elseIf (ls_emp_type = 'SS' ) And ls_emp_sex = 'M' Then
//	  
//			select count(1) into :ll_cnt from fb_empspouse esp,fb_employee emp 
//			 where esp.emps_id=emp.emp_id and emp.emp_type in ('ST') and esp.emp_id=:ls_emp_id and esp.emps_active='1';
//				  
//			  if ll_cnt =0 then	//no spouse as Staff
//				ll_cnt=0
//				select count(1) into :ll_cnt  from fb_empspouse esp,fb_employee emp 
//				 where esp.emps_id=emp.emp_id and emp.emp_type in ('LP','LT','SS') and esp.emp_id=:ls_emp_id and esp.emps_active='1' ;
//				 
//				  if ll_cnt =0 then	//spouse IS NOT WORKING
//					ll_cnt=0
//					 
//					select count(1) into :ll_cnt from fb_empspouse where emp_id=:ls_emp_id and emps_active='1';
//							 
//					If ll_cnt >= 1 Then //SPOUSE IS ACTIVE
//						ll_nodepmajor = ll_nodepmajor + 1
//					End If
//				 end if
//
//				 select sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) - :ll_minorage),1,0,1),0)),
//						 sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) - :ll_minorage),1,1,0),0)),
//						 (nvl(:ll_nodepmajor,0) + sum(decode(empd_maritalstatus,'W',1,0)))
//					 into :ll_nodepminorphase2,:ll_nodepminor,:ll_nodepmajor
//					from fb_empdependents ld
//				 where EMP_ID =:ls_emp_id and empd_active='1' and 
//						( (:ls_mchild='Y' and EMPD_DEPENDENTTYPE='CHILD' and  EMPD_MARITALSTATUS ='U' and 
//							(  ( ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) between :ll_mstage and :ll_wsage) or
//									( ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) between :ll_mstage and :ll_sage and EMPD_SCHOOLFLAG='YES')) ) or
//						  (:ls_umgirl='Y' and EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
//						  (:ls_umsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
//						  (:ls_wsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) or
//						  (:ls_wmother='Y' and EMPD_DEPENDENTTYPE='MOTHER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) );
//				 
////								( (EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='M' and EMPD_MARITALSTATUS ='U'  and ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) <= 18 ) or
////								  (EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) );
//
//					  if sqlca.sqlcode = -1 then
//						Messagebox('SQL ERROR: During Dependent Select (Male)',sqlca.sqlerrtext)
//						return -1
//					  End If
//			 End If
//		elseIf (ls_emp_type = 'SS' )  And ls_emp_sex = 'F' Then
//			
//				  select count(1) into :ll_cnt from fb_empspouse esp,fb_employee emp 
//				  where esp.emps_id=emp.emp_id and emp.emp_type in ('SS','ST') and esp.emp_id=:ls_emp_id and esp.emps_active='1';
//				  
//			  if ll_cnt =0 then	//no male spouse as staff for this emp
//				
//				 select sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) - :ll_minorage),1,0,1),0)),
//						 sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) - :ll_minorage),1,1,0),0)),
//						 (nvl(:ll_nodepmajor,0) + sum(decode(empd_maritalstatus,'W',1,0)))
//					 into :ll_nodepminorphase2,:ll_nodepminor,:ll_nodepmajor
//					from fb_empdependents ld
//				where EMP_ID =:ls_emp_id and empd_active='1' and 
//						( (:ls_mchild='Y' and EMPD_DEPENDENTTYPE='CHILD' and  EMPD_MARITALSTATUS ='U' and 
//							(  ( ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) between :ll_mstage and :ll_wsage) or
//									( ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) between :ll_mstage and :ll_sage and EMPD_SCHOOLFLAG='YES')) ) or
//						  (:ls_umgirl='Y' and EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
//						  (:ls_umsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
//						  (:ls_wsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) or
//						  (:ls_wmother='Y' and EMPD_DEPENDENTTYPE='MOTHER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) );
//
////								( (EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='M' and EMPD_MARITALSTATUS ='U'  and ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) <= 18 ) or
////								  (EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) );
//
//					  if sqlca.sqlcode = -1 then
//						Messagebox('SQL ERROR: During Dependent Select (Male)',sqlca.sqlerrtext)
//						return -1
//					  End If
//			  end if
//		end if
//
//	  if isnull(ll_nomajor) then ll_nomajor=0
//	  if isnull(ll_nodepmajor) then ll_nodepmajor=0
//	  if isnull(ll_nodepminor) then ll_nodepminor=0
//	  if isnull(ll_nodepminorphase2) then ll_nodepminorphase2=0
//						 
//	  		ld_majriceprice = Round(ld_majricewt * ld_majricerate * ll_nomajor, 2)
//			 ld_majattaprice = Round(ld_majattawt * ld_majattarate * ll_nomajor, 2)
//			 ld_depmajriceprice = Round(ld_depmajricewt * ld_depmajricerate * ll_nodepmajor, 2)
//			 ld_depmajattaprice = Round(ld_depmajattawt * ld_depmajattarate * ll_nodepmajor, 2)
//			 ld_depminriceprice = Round((ld_depminricewt * ld_depminricerate * ll_nodepminor) + (ld_depminricewt * ld_depminricerate * ll_nodepminorphase2), 2)
//			 ld_depminattaprice = Round((ld_depminattawt * ld_depminattarate * ll_nodepminor) + (ld_depminattawt * ld_depminattarate * ll_nodepminorphase2), 2)
//			 ld_attawt = (ld_majattawt * ll_nomajor) + (ld_depmajattawt * ll_nodepmajor) + (ld_depminattawt * ll_nodepminor) + (ld_depminattawt * ll_nodepminorphase2)
//			 ld_ricewt = (ld_majricewt * ll_nomajor) + (ld_depmajricewt * ll_nodepmajor) + (ld_depminricewt * ll_nodepminor) + (ld_depminricewt * ll_nodepminorphase2)
//			 ld_rationded = ld_majriceprice + ld_majattaprice + ld_depmajriceprice + ld_depmajattaprice + ld_depminriceprice + ld_depminattaprice
//			 
//		Else
//			 ld_attawt = 0
//			 ld_ricewt = 0
//			 ld_rationded = 0
//		End If
		
return ld_rationprice

end function

on w_gtehrf010.create
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.Control[]={this.ddlb_1,&
this.cb_2,&
this.cb_1,&
this.st_1}
end on

on w_gtehrf010.destroy
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
end on

event open;if date(gd_dt) <> today() then
	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
	return 1
end if


declare c1 cursor for
select to_char(rpfw_STARTDATE,'dd/mm/yyyy')||' - '|| to_char(rpfw_ENDDATE,'dd/mm/yyyy')||' ('||RPFW_ID||')'
from fb_rationperiodforweek	 
where nvl(RPFW_PAIDFLAG,'0')='0' and RPFW_EMP_TYPE = 'LP'
order by  rpfw_STARTDATE desc;

open c1;

if sqlca.sqlcode = -1 then 
	messagebox('Error At Cursor','Error During Opening Cursor');
	return 1;
else
	setnull(ls_frdt);
	fetch c1 into :ls_frdt;	
	do while sqlca.sqlcode <> 100 
	
		ddlb_1.additem(ls_frdt);
	
		setnull(ls_frdt);
		fetch c1 into :ls_frdt;	
	loop
	close c1;
end if;

this.tag = Message.StringParm
ll_user_level = long(this.tag)

if ll_user_level = 3 then
	cb_1.enabled = false
end if
end event

type ddlb_1 from dropdownlistbox within w_gtehrf010
integer x = 101
integer y = 208
integer width = 1312
integer height = 376
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_gtehrf010
integer x = 869
integer y = 672
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

type cb_1 from commandbutton within w_gtehrf010
integer x = 352
integer y = 672
integer width = 494
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Calculation Ration"
boolean default = true
end type

event clicked;string ls_dt,ls_labour,ls_emp_sex,ls_lab_ty,ls_lab_marital,ls_field_id,ls_dob,ls_rcardno,ls_LS_ID
string ls_lrw_id,ls_fr_dt,ls_to_dt
double ld_workdaysration,ld_ration_rndoff

double ld_majricewt ,ld_majattawt,ld_majricerate,ld_majattarate,ld_depmajricewt,ld_depmajattawt,ld_depmajricerate,ld_depmajattarate,ld_depminricewt,ld_depminattawt,&
		 ld_depminricerate,ld_depminattarate,ld_majriceprice,ld_majattaprice ,ld_depmajriceprice,ld_depmajattaprice,ld_depminriceprice,ld_depminattaprice,ld_attawt,ld_ricewt,ld_rationded,ld_pension,ld_pt_elec,ld_pt_fuel

long ll_nomajor,ll_nodepmajor,ll_nodepminor,ll_cnt,ll_revstampded,ll_no_weeks,ll_nodepmajor1


string ls_spouse,ls_mchild,ls_wsister,ls_umsister,ls_wmother,ls_major_dep,ls_umgirl
long ll_mstage,ll_wsage,ll_sage,ll_minorage,ll_nodep

SetPointer(HourGlass!);

ls_fr_dt = left(ddlb_1.text,10)
ls_lrw_id = left(right(ddlb_1.text,15),14)

//ls_lrw_id = left(right(ddlb_1.text,9),8)

if isnull(ls_fr_dt) then 
	messagebox('Error At Date','Start Date Should Be Entered, Please Check !!!')
	return 1
end if;

select RPFW_ID,RPFW_EMP_TYPE,RPFW_CALFLAG,to_char(RPFW_STARTDATE,'dd/mm/yyyy'),to_char(RPFW_ENDDATE,'dd/mm/yyyy')
    into :ls_lrw_id,:ls_wr_emptype,:ls_cal_flag,:ls_fr_dt,:ls_to_dt
  from fb_rationperiodforweek 
where RPFW_STARTDATE = to_date(:ls_fr_dt,'dd/mm/yyyy') and RPFW_EMP_TYPE = 'LP' and RPFW_PAIDFLAG ='0' and RPFW_ID = :ls_lrw_id;

if sqlca.sqlcode =100 then
	messagebox('Wages Week Select ','Either the there is no such week or the ration against this week has been paid, Please Check...!')
	return 1
elseif sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Wages Week Select ',sqlca.sqlerrtext)
	return 1
end if;

select nvl(pd_value,0)	 into :ld_ration_rndoff from fb_param_detail 
where pd_doc_type = 'RICATARNDOFF' and to_date(:ls_fr_dt,'dd/mm/yyyy') between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));

if sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Ration Parametere checking ',sqlca.sqlerrtext)
	return -1
end if;
	
if isnull(ld_ration_rndoff) then ld_ration_rndoff=0


			
	delete from fb_substaffweeklyration where LWW_ID = :ls_lrw_id;
		if sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Ration (Delete)',sqlca.sqlerrtext)
		return 1
	end if;
	
//			if gs_garden_snm ='MT' then
//
//				delete from FB_LABELPDETAILS where LRW_ID = :ls_lrw_id;
//					if sqlca.sqlcode = -1 then
//					messagebox('SQL ERROR: During ELP Detail (Delete)',sqlca.sqlerrtext)
//					return 1
//				end if;
//			end if;
	
	commit using sqlca;

id_totricequan=0;id_totattaquan=0


declare c1 cursor for
 SELECT   emp.emp_id labour_id, SUM (attdays) no_workdays, MAX (emp.emp_sex) emp_sex, MAX (emp.emp_type) emp_type, 
              MAX (emp.emp_marital) emp_marital, MAX (emp.field_id) field_id, to_char(MAX (emp.emp_dob),'dd/mm/yyyy') dob, 
				  MAX (NVL (emp.emp_rationcardno, 0)) rcardno ,LS_ID
   FROM (SELECT   ea.emp_id emp_id, DECODE (SIGN (COUNT (ea.eatten_status) - 16), 1, 15, COUNT (ea.eatten_status) ) attdays 
                   FROM fb_empattendance ea
                  WHERE ea.eatten_date between to_date(:ls_fr_dt,'dd/mm/yyyy') and  to_date(:ls_to_dt,'dd/mm/yyyy') AND  (ea.eatten_status NOT IN ('AB', 'SI', 'MI')) 
			GROUP BY ea.emp_id 
			 UNION ALL 
			  SELECT et.emp_id emp_id, DECODE (et.eatten_status, 'AB', -0, 'SI', -0, 'MI', -0,-1) attdays 
				  FROM fb_empattendance et WHERE TO_CHAR (et.eatten_date, 'DY') = 'SUN' AND 
						et.eatten_date between to_date(:ls_fr_dt,'dd/mm/yyyy') and  to_date(:ls_to_dt,'dd/mm/yyyy'))  atn,fb_employee emp
	where atn.emp_id = emp.emp_id   and 
			 ((:gs_garden_snm <> 'MT' and emp.emp_type = 'SS') or (:gs_garden_snm = 'MT' and emp.emp_type in ('SS','ST','AT')))
group by emp.emp_id ,LS_ID;
// SELECT   emp.emp_id labour_id, 6, emp.emp_sex emp_sex, emp.emp_type emp_type, 
//             emp.emp_marital emp_marital, emp.field_id field_id, to_char(emp.emp_dob,'dd/mm/yyyy') dob, 
//				  NVL (emp.emp_rationcardno, 0) rcardno ,LS_ID, nvl(abs_days,0) abs_days 
//   FROM fb_employee emp, (select emp_id, sum(nvl(decode(eatten_status, 'AB', 1, 'SI', 1,0),0)) abs_days from fb_empattendance 
//										where EATTEN_DATE between to_date(:ls_fr_dt,'dd/mm/yyyy') and to_date(:ls_to_dt,'dd/mm/yyyy') group by emp_id) att
//	where emp.emp_id = att.emp_id and ((:gs_garden_snm <> 'MT' and emp.emp_type = 'SS') or (:gs_garden_snm = 'MT' and emp.emp_type in ('SS','ST','AT'))) and emp.emp_active='1' ;

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return 1; 
else 

	ld_workdaysration= 0; ld_absdays = 0;
	setnull(ls_labour);setnull(ls_emp_sex);setnull(ls_lab_ty);setnull(ls_lab_marital);setnull(ls_field_id);setnull(ls_dob);setnull(ls_rcardno);setnull(ls_LS_ID)

			  
//	fetch c1 into :ls_labour,:ld_workdaysration,:ls_emp_sex,:ls_lab_ty,:ls_lab_marital,:ls_field_id,:ls_dob,:ls_rcardno,:ls_LS_ID,:ld_absdays;
	fetch c1 into :ls_labour,:ld_workdaysration,:ls_emp_sex,:ls_lab_ty,:ls_lab_marital,:ls_field_id,:ls_dob,:ls_rcardno,:ls_LS_ID;
	do while sqlca.sqlcode <> 100 
		
		if ld_workdaysration > 0 then	
			if gs_garden_snm <> 'MT' then
				ld_workdaysration = 6
			end if
         		 ll_no_weeks = 1
					ld_majricewt =0;ld_majattawt=0;ld_majricerate=0;ld_majattarate=0;ld_depmajricewt=0;ld_depmajattawt=0;ld_depmajricerate=0;ld_depmajattarate=0;
					ld_depminricewt=0;ld_depminattawt=0;ld_depminricerate=0;ld_depminattarate=0;ll_nodepmajor = 0;
					ld_majriceprice=0;ld_majattaprice=0;ld_depmajriceprice=0;ld_depmajattaprice=0;ld_depminriceprice=0;ld_depminattaprice=0;
			
						
				select (sum(decode(trim(lrc_majorminorflag),'MAJOR',lrc_attawt,0)) * nvl(:ll_no_weeks,0)) ,(sum(decode(trim(lrc_majorminorflag),'MAJOR',lrc_ricewt,0)) * nvl(:ll_no_weeks,0)),
						sum(decode(trim(lrc_majorminorflag),'MAJOR',lrc_attarate,0)),sum(decode(trim(lrc_majorminorflag),'MAJOR',lrc_ricerate,0)),
						(sum(decode(trim(lrc_majorminorflag),'DEPMAJ',lrc_attawt,0)) * nvl(:ll_no_weeks,0)),(sum(decode(trim(lrc_majorminorflag),'DEPMAJ',lrc_ricewt,0)) * nvl(:ll_no_weeks,0)),
						sum(decode(trim(lrc_majorminorflag),'DEPMAJ',lrc_attarate,0)),sum(decode(trim(lrc_majorminorflag),'DEPMAJ',lrc_ricerate,0)),
						(sum(decode(trim(lrc_majorminorflag),'DEPMIN',lrc_attawt,0)) * nvl(:ll_no_weeks,0)),(sum(decode(trim(lrc_majorminorflag),'DEPMIN',lrc_ricewt,0)) * nvl(:ll_no_weeks,0)) ,
						sum(decode(trim(lrc_majorminorflag),'DEPMIN',lrc_attarate,0)),sum(decode(trim(lrc_majorminorflag),'DEPMIN',lrc_ricerate,0))
					into :ld_majattawt ,:ld_majricewt,:ld_majattarate,:ld_majricerate,:ld_depmajattawt,:ld_depmajricewt,:ld_depmajattarate,
						:ld_depmajricerate,:ld_depminattawt,:ld_depminricewt,:ld_depminattarate,:ld_depminricerate
				  from (select distinct lrc_majorminorflag,lrc_ricewt,lrc_attawt,lrc_ricerate,lrc_attarate
							from fb_labourrationchart
						 where lrc_majorminorflag in('MAJOR','DEPMAJ','DEPMIN') and lrc_labourtype='LP' and lrc_noworkdays= :ld_workdaysration and 
								to_date(:ls_fr_dt,'dd/mm/yyyy') between LRC_FRDT and nvl(LRC_TODT,trunc(sysdate)));
			
				if	sqlca.sqlcode =100 then
					MessageBox('Ration Chart Error',"The Ration chart for employee has not been registered. Please Check...!")
					return -1
				End If
				
				if isnull(ld_majricewt) then ld_majricewt=0
				if isnull(ld_majattawt) then ld_majattawt=0
				if isnull(ld_majricerate) then ld_majricerate=0
				if isnull(ld_majattarate) then ld_majattarate=0
				if isnull(ld_depmajricewt) then ld_depmajricewt=0
				if isnull(ld_depmajattawt) then ld_depmajattawt=0
				if isnull(ld_depmajricerate) then ld_depmajricerate=0
				if isnull(ld_depmajattarate) then ld_depmajattarate=0
				if isnull(ld_depminricewt) then ld_depminricewt=0
				if isnull(ld_depminattawt) then ld_depminattawt=0
				if isnull(ld_depminricerate) then ld_depminricerate=0
				if isnull(ld_depminattarate) then ld_depminattarate=0

			if ld_workdaysration >= id_minworkdays then
				
				  setnull(ls_spouse);setnull(ls_mchild);setnull(ls_major_dep);setnull(ls_umgirl);setnull(ls_wsister);setnull(ls_umsister);setnull(ls_wmother)
				  ll_mstage=0;ll_wsage=0;ll_sage=0;ll_minorage=0;ll_nodep=0;
				  
	
				  select nvl(RP_SPOUSE_IND,'N'), nvl(RP_CH_IND,'N'), rp_major_dpind,nvl(RP_CH_STARTAGE,0), nvl(RP_CH_WSCH_AGE,0), nvl(RP_CH_SCH_AGE,0), nvl(RP_MINOR_DEPAGE,0), nvl(RP_NOOF_DEP,0),nvl(rp_um_fch,'N'),nvl(RP_WIDOW_SISTER,'N'), nvl(RP_UNMARRIED_SISTER,'N'), nvl(RP_WIDOW_MOTHER,'N')
				  into :ls_spouse,:ls_mchild,:ls_major_dep,:ll_mstage,:ll_wsage,:ll_sage,:ll_minorage,:ll_nodep,:ls_umgirl,:ls_wsister,:ls_umsister,:ls_wmother
				  from fb_rationparam 
				  where RP_EMPTYPE = :ls_lab_ty and to_date(:ls_fr_dt,'dd/mm/yyyy') between RP_PERIOD_FROM and nvl(RP_PERIOD_TO,trunc(sysdate));
				
				if sqlca.sqlcode = -1 then 
					messagebox('Sql Error : During Ration Parameter Select : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 
				elseif sqlca.sqlcode =100 then
					messagebox('Ration Parameter Error','The Ration Parameter Not in Master Please set the Master of Ration Parameter First')
					rollback using sqlca;
					return -1
				end if;
				  

				ll_nomajor = 1
				 If (ls_lab_ty = 'ST' or ls_lab_ty = 'AT') And ls_emp_sex = 'M' Then
			  
						  select count(1) into :ll_cnt from fb_empspouse esp,fb_employee emp 
						  where esp.emps_id=emp.emp_id and emp.emp_type in('LP','LT','SS','ST','AT') and esp.emp_id=:ls_labour and esp.emps_active='1';
						  
					  if ll_cnt =0 then	//SPOUSE IS NOT WORKING
						ll_cnt=0
						select count(1) into :ll_cnt from fb_empspouse where emp_id=:ls_labour and emps_active='1';
								 
						If ll_cnt >= 1 Then //SPOUSE IS ACTIVE
							ll_nodepmajor = ll_nodepmajor + 1
						End If
					 End If
					 
						 select sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:ls_fr_dt,'dd/mm/yyyy') - EMPD_DOB)/365) - :ll_minorage),1,0,1),0)),
								 sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:ls_fr_dt,'dd/mm/yyyy') - EMPD_DOB)/365) - :ll_minorage),1,1,0),0)),
								 sum(decode(empd_maritalstatus,'W',1,0))
						 into :ll_nodepminor,:ll_nodepmajor2,:ll_nodepmajor1
						from fb_empdependents ld
						where EMP_ID =:ls_labour and empd_active='1' and 
								( (:ls_mchild='Y' and EMPD_DEPENDENTTYPE='CHILD' and  EMPD_MARITALSTATUS ='U' and 
									(  ( ((to_date(:ls_fr_dt,'dd/mm/yyyy') - EMPD_DOB)/365) between :ll_mstage and :ll_wsage) or
									   ( ((to_date(:ls_fr_dt,'dd/mm/yyyy') - EMPD_DOB)/365) between :ll_mstage and :ll_sage and EMPD_SCHOOLFLAG='YES')) ) or
								  (:ls_umgirl='Y' and EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
								  (:ls_umsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
								  (:ls_wsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) or
								  (:ls_wmother='Y' and EMPD_DEPENDENTTYPE='MOTHER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) );
		
		
							  if sqlca.sqlcode = -1 then
								Messagebox('SQL ERROR: During Dependent Select (Male)',sqlca.sqlerrtext)
								return -1
							  End If
						if isnull(ll_nodepminor) then ll_nodepminor = 0
						if isnull(ll_nodepmajor1) then ll_nodepmajor1 = 0
						if isnull(ll_nodepmajor2) then ll_nodepmajor2 = 0
						
						ll_nodepmajor = ll_nodepmajor + ll_nodepmajor2 + ll_nodepmajor1
							  
							  
				elseIf (ls_lab_ty = 'ST' or ls_lab_ty = 'AT')  And ls_emp_sex = 'F' Then
					
						  select count(1) into :ll_cnt from fb_empspouse esp,fb_employee emp 
						  where esp.emps_id=emp.emp_id and emp.emp_type in ('ST','AT') and esp.emp_id=:ls_labour and esp.emps_active='1';
						  
					  if ll_cnt =0 then	//no male spouse as staff for this emp
						
						 select sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:ls_fr_dt,'dd/mm/yyyy') - EMPD_DOB)/365) - :ll_minorage),1,0,1),0)),
								 sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:ls_fr_dt,'dd/mm/yyyy') - EMPD_DOB)/365) - :ll_minorage),1,1,0),0)),
								  sum(decode(empd_maritalstatus,'W',1,0))
							into :ll_nodepminor,:ll_nodepmajor2,:ll_nodepmajor1
						  from fb_empdependents ld
						where EMP_ID =:ls_labour and empd_active='1' and 
								( (:ls_mchild='Y' and EMPD_DEPENDENTTYPE='CHILD' and  EMPD_MARITALSTATUS ='U' and 
									(  ( ((to_date(:ls_fr_dt,'dd/mm/yyyy') - EMPD_DOB)/365) between :ll_mstage and :ll_wsage) or
											( ((to_date(:ls_fr_dt,'dd/mm/yyyy') - EMPD_DOB)/365) between :ll_mstage and :ll_sage and EMPD_SCHOOLFLAG='YES')) ) or
								  (:ls_umgirl='Y' and EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
								  (:ls_umsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
								  (:ls_wsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) or
								  (:ls_wmother='Y' and EMPD_DEPENDENTTYPE='MOTHER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) );
		
							  if sqlca.sqlcode = -1 then
								Messagebox('SQL ERROR: During Dependent Select (Male)',sqlca.sqlerrtext)
								return -1
							  End If
						if isnull(ll_nodepminor) then ll_nodepminor = 0
						if isnull(ll_nodepmajor1) then ll_nodepmajor1 = 0
						if isnull(ll_nodepmajor2) then ll_nodepmajor2 = 0
						
						ll_nodepmajor = ll_nodepmajor + ll_nodepmajor2 + ll_nodepmajor1
						
					  end if
				elseIf (ls_lab_ty = 'SS' ) And ls_emp_sex = 'M' Then
			  
					select count(1) into :ll_cnt from fb_empspouse esp,fb_employee emp 
					 where esp.emps_id=emp.emp_id and emp.emp_type in ('ST') and esp.emp_id=:ls_labour and esp.emps_active='1';
						  
					  if ll_cnt =0 then	//no spouse as Staff
						ll_cnt=0
						select count(1) into :ll_cnt  from fb_empspouse esp,fb_employee emp 
						 where esp.emps_id=emp.emp_id and emp.emp_type in ('LP','LT','SS') and esp.emp_id=:ls_labour and esp.emps_active='1' ;
						 
						  if ll_cnt =0 then	//spouse IS NOT WORKING
							ll_cnt=0
							 
							select count(1) into :ll_cnt from fb_empspouse where emp_id=:ls_labour and emps_active='1';
									 
							If ll_cnt >= 1 Then //SPOUSE IS ACTIVE
								ll_nodepmajor = ll_nodepmajor + 1
							End If
						 end if
		
						 select sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:ls_fr_dt,'dd/mm/yyyy') - EMPD_DOB)/365) - :ll_minorage),1,0,1),0)),
								 sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:ls_fr_dt,'dd/mm/yyyy') - EMPD_DOB)/365) - :ll_minorage),1,1,0),0)),
								 sum(decode(empd_maritalstatus,'W',1,0))
							 into :ll_nodepminor,:ll_nodepmajor2,:ll_nodepmajor1
							from fb_empdependents ld
						 where EMP_ID =:ls_labour and empd_active='1' and 
								( (:ls_mchild='Y' and EMPD_DEPENDENTTYPE='CHILD' and  EMPD_MARITALSTATUS ='U' and 
									(  ( ((to_date(:ls_fr_dt,'dd/mm/yyyy') - EMPD_DOB)/365) between :ll_mstage and :ll_wsage) or
											( ((to_date(:ls_fr_dt,'dd/mm/yyyy') - EMPD_DOB)/365) between :ll_mstage and :ll_sage and EMPD_SCHOOLFLAG='YES')) ) or
								  (:ls_umgirl='Y' and EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
								  (:ls_umsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
								  (:ls_wsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) or
								  (:ls_wmother='Y' and EMPD_DEPENDENTTYPE='MOTHER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) );
						 
							  if sqlca.sqlcode = -1 then
								Messagebox('SQL ERROR: During Dependent Select (Male)',sqlca.sqlerrtext)
								return -1
							  End If

						if isnull(ll_nodepminor) then ll_nodepminor = 0
						if isnull(ll_nodepmajor1) then ll_nodepmajor1 = 0
						if isnull(ll_nodepmajor2) then ll_nodepmajor2 = 0
						
						ll_nodepmajor = ll_nodepmajor + ll_nodepmajor2 + ll_nodepmajor1
							  
					 End If
				elseIf (ls_lab_ty = 'SS' )  And ls_emp_sex = 'F' Then
					
						  select count(1) into :ll_cnt from fb_empspouse esp,fb_employee emp 
						  where esp.emps_id=emp.emp_id and emp.emp_type in ('SS','ST') and esp.emp_id=:ls_labour and esp.emps_active='1';
						  
					  if ll_cnt =0 then	//no male spouse as staff for this emp
						
						 select sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:ls_fr_dt,'dd/mm/yyyy') - EMPD_DOB)/365) - :ll_minorage),1,0,1),0)),
								 sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:ls_fr_dt,'dd/mm/yyyy') - EMPD_DOB)/365) - :ll_minorage),1,1,0),0)),
								 sum(decode(empd_maritalstatus,'W',1,0))
							into :ll_nodepminor,:ll_nodepmajor2,:ll_nodepmajor1
							from fb_empdependents ld
						where EMP_ID =:ls_labour and empd_active='1' and 
								( (:ls_mchild='Y' and EMPD_DEPENDENTTYPE='CHILD' and  EMPD_MARITALSTATUS ='U' and 
									(  ( ((to_date(:ls_fr_dt,'dd/mm/yyyy') - EMPD_DOB)/365) between :ll_mstage and :ll_wsage) or
											( ((to_date(:ls_fr_dt,'dd/mm/yyyy') - EMPD_DOB)/365) between :ll_mstage and :ll_sage and EMPD_SCHOOLFLAG='YES')) ) or
								  (:ls_umgirl='Y' and EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
								  (:ls_umsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
								  (:ls_wsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) or
								  (:ls_wmother='Y' and EMPD_DEPENDENTTYPE='MOTHER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) );
		
							  if sqlca.sqlcode = -1 then
								Messagebox('SQL ERROR: During Dependent Select (Male)',sqlca.sqlerrtext)
								return -1
							  End If

						if isnull(ll_nodepminor) then ll_nodepminor = 0
						if isnull(ll_nodepmajor1) then ll_nodepmajor1 = 0
						if isnull(ll_nodepmajor2) then ll_nodepmajor2 = 0

						ll_nodepmajor = ll_nodepmajor + ll_nodepmajor2 + ll_nodepmajor1
							  
					  end if
				end if
		
				  if isnull(ll_nomajor) then ll_nomajor=0
				  if isnull(ll_nodepmajor) then ll_nodepmajor=0
				  if isnull(ll_nodepminor) then ll_nodepminor=0
								 
					ld_majriceprice = Round(ld_majricewt * ld_majricerate * ll_nomajor, 2)
					 ld_majattaprice = Round(ld_majattawt * ld_majattarate * ll_nomajor, 2)
					 ld_depmajriceprice = Round(ld_depmajricewt * ld_depmajricerate * ll_nodepmajor, 2)
					 ld_depmajattaprice = Round(ld_depmajattawt * ld_depmajattarate * ll_nodepmajor, 2)
					 ld_depminriceprice = Round(ld_depminricewt * ld_depminricerate * ll_nodepminor, 2)
					 ld_depminattaprice = Round(ld_depminattawt * ld_depminattarate * ll_nodepminor, 2)
					 ld_attawt = (ld_majattawt * ll_nomajor) + (ld_depmajattawt * ll_nodepmajor) + (ld_depminattawt * ll_nodepminor) 
					 ld_ricewt = (ld_majricewt * ll_nomajor) + (ld_depmajricewt * ll_nodepmajor) + (ld_depminricewt * ll_nodepminor) 
					 ld_rationded = ld_majriceprice + ld_majattaprice + ld_depmajriceprice + ld_depmajattaprice + ld_depminriceprice + ld_depminattaprice
					 
				Else
					 ld_attawt = 0
					 ld_ricewt = 0
					 ld_rationded = 0
				End If
			else
					 ld_rationded = 0
					 ld_ricewt = 0
					 ld_attawt = 0
					 ll_nodepminor = 0
					 ll_nodepmajor = 0
			end if

		insert into fb_substaffweeklyration(EMP_ID, LWW_ID, RICEWT, ATTAWT, RATIONDED, NOMINOR, NOADULT,workdays)
		 values(:ls_labour, :ls_lrw_id,:ld_ricewt,:ld_attawt,:ld_rationded,nvl(:ll_nodepminor,0) ,:ll_nodepmajor,:ld_workdaysration);
					 
		if sqlca.sqlcode = -1 then
			messagebox('Sql Error : During Ration Calculation (Insert): ',sqlca.sqlerrtext); 
			rollback using sqlca; 
			return 1; 
		end if;
		
		ld_workdaysration= 0; ld_absdays = 0;ll_nomajor =0; ll_nodepminor = 0;ll_nodepmajor = 0;
		setnull(ls_labour);setnull(ls_emp_sex);setnull(ls_lab_ty);setnull(ls_lab_marital);setnull(ls_field_id);setnull(ls_dob);setnull(ls_rcardno);setnull(ls_LS_ID)
//		fetch c1 into :ls_labour,:ld_workdaysration,:ls_emp_sex,:ls_lab_ty,:ls_lab_marital,:ls_field_id,:ls_dob,:ls_rcardno,:ls_LS_ID,:ld_absdays;
		fetch c1 into :ls_labour,:ld_workdaysration,:ls_emp_sex,:ls_lab_ty,:ls_lab_marital,:ls_field_id,:ls_dob,:ls_rcardno,:ls_LS_ID;
	loop;
	close c1;
        
	commit using sqlca;
	messagebox('Confirmation','The Ration Has Been Sucessfully Calculate, Please Check....!',information!)
end if;
setpointer(arrow!)

end event

type st_1 from statictext within w_gtehrf010
integer x = 466
integer y = 128
integer width = 489
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Week Start Date"
alignment alignment = center!
boolean focusrectangle = false
end type

