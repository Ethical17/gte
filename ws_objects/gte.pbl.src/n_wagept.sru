$PBExportHeader$n_wagept.sru
forward
global type n_wagept from nonvisualobject
end type
end forward

global type n_wagept from nonvisualobject
end type
global n_wagept n_wagept

type variables
double id_totricequan,id_totattaquan,id_lmajattawt,id_lmajricewt,id_lmajattaprice,id_lmajriceprice,id_minworkdays, id_ldepmajattawt,id_ldepmajricewt,id_ldepmajattaprice,id_ldepmajriceprice, &
            id_lminattawt,id_lminricewt,id_lminattaprice,id_lminriceprice,id_ldepminattawt,id_ldepminricewt, id_ldepminattaprice,id_ldepminriceprice,id_labricewt,id_labattawt,id_no_lab_depminor,id_no_lab_depmajor
string is_adultallow,is_childallallow
double ld_ELECT1_IAMT, ld_ELECT1_NAMT, ld_ELECT2_IAMT, ld_ELECT2_NAMT, ld_ELECT3_IAMT, ld_ELECT3_NAMT,  ld_ELECT4_IAMT, ld_ELECT4_NAMT, ld_ACMS01_IAMT, ld_ACMS01_NAMT, ld_BPUJA1_IAMT, ld_BPUJA1_NAMT 
double ld_BPUJA2_IAMT, ld_BPUJA2_NAMT, ld_BMASAN_IAMT, ld_BMASAN_NAMT, ld_CBME_IAMT, ld_CBME_NAMT,ld_CHURCH_IAMT, ld_CHURCH_NAMT, ld_ICICI_IAMT, ld_ICICI_NAMT
double  ld_PUJA1_IAMT, ld_PUJA1_NAMT, ld_PUJA2_IAMT, ld_PUJA2_NAMT, ld_PUJA3_IAMT, ld_PUJA3_NAMT, ld_PUJA4_IAMT, ld_PUJA4_NAMT,  ld_PUJA5_IAMT, ld_PUJA5_NAMT, ld_MEDICAL_IAMT, ld_MEDICAL_NAMT, ld_tndays
double ld_ELECT1_adjAMT, ld_ELECT2_adjAMT, ld_ELECT3_adjAMT, ld_ELECT4_adjAMT, ld_ACMS01_adjAMT, ld_BPUJA1_adjAMT, ld_BPUJA2_adjAMT, ld_BMASAN_adjAMT, ld_CBME_adjAMT
double ld_CHURCH_adjAMT, ld_ICICI_adjAMT, ld_PUJA1_adjAMT, ld_PUJA2_adjAMT, ld_PUJA3_adjAMT, ld_PUJA4_adjAMT, ld_PUJA5_adjAMT, ld_MEDICAL_adjAMT, ld_copr_amt,ld_cvfood,ld_tcvfood
double ld_ACKS_IAMT, ld_CLUB_IAMT, ld_ITAX_IAMT, ld_GROUPINSU_IAMT, ld_CANTEEN_IAMT, ld_LPG_IAMT, ld_LIGHTALOW, ld_SEASONALOW,ld_CHARGEALOW, ld_COMPUTERALOW, ld_otamt, ld_othours 
datetime ld_ELECT1_FDT, ld_ELECT2_FDT,ld_ELECT3_FDT, ld_ELECT4_FDT, ld_ACMS01_FDT, ld_BPUJA1_FDT,ld_BPUJA2_FDT, ld_BMASAN_FDT,ld_CBME_FDT,ld_CHURCH_FDT
datetime	ld_ICICI_FDT, ld_PUJA1_FDT,ld_PUJA2_FDT,ld_PUJA3_FDT, ld_PUJA4_FDT,	ld_PUJA5_FDT, ld_MEDICAL_FDT

end variables

forward prototypes
public function double wf_calcutaeration (string fs_labour, string fs_lab_ty, string fs_lab_marital, double fd_attndays, string fs_emp_sex, string fs_start_dt, string fs_lww_id)
public function integer wf_substaffration (string fs_lwwid, string fs_start_dt)
public function double wf_fortnight_firstweek_workdays (string fs_lww_id, string fs_lab_id, string fs_st_dt)
public function integer wf_upd_weekly_status (string fs_lww_id)
public function integer wf_emp_wagecal (string fs_ym, string fs_chklwf, string fs_chkration)
public function integer wf_wagecal_2w (string fs_st_dt, double fd_lwf, double fd_subs)
public function integer wf_wagecal (string fs_st_dt, double fd_lwf, double fd_subs)
public function integer wf_wagecal_2wdb (string fs_st_dt, double fd_lwf, double fd_subs)
public function integer wf_wagecal_db (string fs_st_dt, double fd_lwf, double fd_subs)
end prototypes

public function double wf_calcutaeration (string fs_labour, string fs_lab_ty, string fs_lab_marital, double fd_attndays, string fs_emp_sex, string fs_start_dt, string fs_lww_id);Double ld_tot_amt, ld_rationprice ,ld_msp_attndays,ld_mindaysmspouse
long ll_nochild ,ll_noy
string ls_childcur_ind,ls_temp,ls_msp_ty,ls_msp_field

  ll_nochild  = 0

  id_labricewt=0;id_labattawt=0;id_no_lab_depminor=0;id_no_lab_depmajor=0

  ld_rationprice = 0

  If fd_attndays >= id_minworkdays Then
    //start ration for self
     If fs_lab_ty = 'LP' Then
        id_labricewt = id_lmajricewt
        id_labattawt = id_lmajattawt
        id_totricequan = id_totricequan + id_lmajricewt
        id_totattaquan = id_totattaquan + id_lmajattawt
        ld_rationprice = ld_rationprice + (id_lmajricewt * id_lmajriceprice) + (id_lmajattawt * id_lmajattaprice)
        ld_tot_amt = ld_rationprice
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
				  ld_tot_amt = ld_tot_amt + ld_rationprice
              	End If
            End If

	  	End If	//end ration for spouse if feasible


     ElseIf fs_lab_ty = 'LT' Then
        id_labricewt = id_lmajricewt
        id_labattawt = id_lmajattawt
        id_totricequan = id_totricequan + id_lmajricewt
        id_totattaquan = id_totattaquan + id_lmajattawt
        ld_rationprice = ld_rationprice + (id_lmajricewt * id_lmajriceprice) + (id_lmajattawt * id_lmajattaprice)
        ld_tot_amt = ld_rationprice
     End If
//end ration for self
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

     If (ls_childcur_ind = 'A' or  ls_childcur_ind = 'B' ) And fs_lab_ty = 'LP' Then  //has child dependent

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
							(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between 3 and 16) or
							   ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) <= 18 and child_schoolflag='YES'));

					open c2;
		
					if sqlca.sqlcode = -1 then 
						messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
						rollback using sqlca; 
						return -1; 
					end if;
					
						fetch c2 into :ll_nochild,:ll_noy;
						
						do while sqlca.sqlcode <> 100 
						
						 If ll_noy <= 10 Then
							  id_labricewt = id_labricewt + id_ldepminricewt
							  id_labattawt = id_labattawt + id_ldepminattawt
		
							  id_totricequan = id_totricequan + id_ldepminricewt
							  id_totattaquan = id_totattaquan + id_ldepminattawt
							  ld_rationprice = ld_rationprice + (id_ldepminricewt * id_ldepminriceprice) + (id_ldepminattawt * id_ldepminattaprice)
							  id_no_lab_depminor = id_no_lab_depminor + 1
						Else
							 id_labricewt = id_labricewt + 2 * id_ldepminricewt
							 id_labattawt = id_labattawt + 2 * id_ldepminattawt
		
							  id_totricequan = id_totricequan + (2 * id_ldepminricewt)
							  id_totattaquan = id_totattaquan + (2 * id_ldepminattawt)
							  ld_rationprice = ld_rationprice + ((2 * id_ldepminricewt) * id_ldepminriceprice) + ((2 * id_ldepminattawt) * id_ldepminattaprice)
							  id_no_lab_depmajor = id_no_lab_depmajor + 1
												
						End If
						
						if ll_nochild = 2 then
							exit
						end if
						fetch c2 into :ll_nochild,:ll_noy;
					loop
					close c2;
							  //end ration for child

			elseif ls_childcur_ind = 'B' then
				declare c21 cursor for
					select rownum, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
					from fb_labourdependent ld,fb_labourspouse lsp 
 			  		where ld.labour_id=lsp.labour_id and ld.child_active='1' and lsp.spouse_id= :fs_labour and ld.child_active='1' and  child_marital = 'U' and 
							(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between 3 and 16) or
							   ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) <= 18 and child_schoolflag='YES'));

					open c21;
		
					if sqlca.sqlcode = -1 then 
						messagebox('Sql Error : During Opening Cursor C21 : ',sqlca.sqlerrtext); 
						rollback using sqlca; 
						return -1; 
					end if;
					
						fetch c21 into :ll_nochild,:ll_noy;
						
						do while sqlca.sqlcode <> 100 
						
						 If ll_noy <= 10 Then
							  id_labricewt = id_labricewt + id_ldepminricewt
							  id_labattawt = id_labattawt + id_ldepminattawt
		
							  id_totricequan = id_totricequan + id_ldepminricewt
							  id_totattaquan = id_totattaquan + id_ldepminattawt
							  ld_rationprice = ld_rationprice + (id_ldepminricewt * id_ldepminriceprice) + (id_ldepminattawt * id_ldepminattaprice)
							  id_no_lab_depminor = id_no_lab_depminor + 1
						Else
							 id_labricewt = id_labricewt + 2 * id_ldepminricewt
							 id_labattawt = id_labattawt + 2 * id_ldepminattawt
		
							  id_totricequan = id_totricequan + (2 * id_ldepminricewt)
							  id_totattaquan = id_totattaquan + (2 * id_ldepminattawt)
							  ld_rationprice = ld_rationprice + ((2 * id_ldepminricewt) * id_ldepminriceprice) + ((2 * id_ldepminattawt) * id_ldepminattaprice)
							  id_no_lab_depmajor = id_no_lab_depmajor + 1
												
						End If
						
						if ll_nochild = 2 then
							exit
						end if
						fetch c21 into :ll_nochild,:ll_noy;
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
									(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between 3 and 16) or
										( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) <= 18 and child_schoolflag='YES'));

							open c3;
							
								fetch c3 into :ll_nochild,:ll_noy;
								do while sqlca.sqlcode <> 100 
						
								 If ll_noy <= 10 Then
									  id_labricewt = id_labricewt + id_ldepminricewt
									  id_labattawt = id_labattawt + id_ldepminattawt
				
									  id_totricequan = id_totricequan + id_ldepminricewt
									  id_totattaquan = id_totattaquan + id_ldepminattawt
									  ld_rationprice = ld_rationprice + (id_ldepminricewt * id_ldepminriceprice) + (id_ldepminattawt * id_ldepminattaprice)
									  id_no_lab_depminor = id_no_lab_depminor + 1
								Else
									 id_labricewt = id_labricewt + 2 * id_ldepminricewt
									 id_labattawt = id_labattawt + 2 * id_ldepminattawt
				
									  id_totricequan = id_totricequan + (2 * id_ldepminricewt)
									  id_totattaquan = id_totattaquan + (2 * id_ldepminattawt)
									  ld_rationprice = ld_rationprice + ((2 * id_ldepminricewt) * id_ldepminriceprice) + ((2 * id_ldepminattawt) * id_ldepminattaprice)
									  id_no_lab_depmajor = id_no_lab_depmajor + 1
														
								End If
						
								if ll_nochild = 2 then
									exit
								end if
							fetch c3 into :ll_nochild,:ll_noy;
							loop
						  close c3; //end ration for child
		
					elseif ls_childcur_ind = 'B' then
						declare c31 cursor for
							select rownum, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
							from fb_labourdependent ld,fb_labourspouse lsp 
							where ld.labour_id=lsp.labour_id and ld.child_active='1' and lsp.spouse_id= :fs_labour and ld.child_active='1' and  child_marital = 'U' and 
									(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between 3 and 16) or
										( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) <= 18 and child_schoolflag='YES'));

							open c31;
							
								fetch c31 into :ll_nochild,:ll_noy;
								do while sqlca.sqlcode <> 100 
						
								 If ll_noy <= 10 Then
									  id_labricewt = id_labricewt + id_ldepminricewt
									  id_labattawt = id_labattawt + id_ldepminattawt
				
									  id_totricequan = id_totricequan + id_ldepminricewt
									  id_totattaquan = id_totattaquan + id_ldepminattawt
									  ld_rationprice = ld_rationprice + (id_ldepminricewt * id_ldepminriceprice) + (id_ldepminattawt * id_ldepminattaprice)
									  id_no_lab_depminor = id_no_lab_depminor + 1
								Else
									 id_labricewt = id_labricewt + 2 * id_ldepminricewt
									 id_labattawt = id_labattawt + 2 * id_ldepminattawt
				
									  id_totricequan = id_totricequan + (2 * id_ldepminricewt)
									  id_totattaquan = id_totattaquan + (2 * id_ldepminattawt)
									  ld_rationprice = ld_rationprice + ((2 * id_ldepminricewt) * id_ldepminriceprice) + ((2 * id_ldepminattawt) * id_ldepminattaprice)
									  id_no_lab_depmajor = id_no_lab_depmajor + 1
														
								End If
						
								if ll_nochild = 2 then
									exit
								end if
							fetch c31 into :ll_nochild,:ll_noy;
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
									(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between 3 and 16) or
									   ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) <= 18 and child_schoolflag='YES'));

						open c4;
						
							fetch c4 into :ll_nochild,:ll_noy;
							do while sqlca.sqlcode <> 100 
					
							 If ll_noy <= 10 Then
								  id_labricewt = id_labricewt + id_ldepminricewt
								  id_labattawt = id_labattawt + id_ldepminattawt
			
								  id_totricequan = id_totricequan + id_ldepminricewt
								  id_totattaquan = id_totattaquan + id_ldepminattawt
								  ld_rationprice = ld_rationprice + (id_ldepminricewt * id_ldepminriceprice) + (id_ldepminattawt * id_ldepminattaprice)
								  id_no_lab_depminor = id_no_lab_depminor + 1
							Else
								 id_labricewt = id_labricewt + 2 * id_ldepminricewt
								 id_labattawt = id_labattawt + 2 * id_ldepminattawt
			
								  id_totricequan = id_totricequan + (2 * id_ldepminricewt)
								  id_totattaquan = id_totattaquan + (2 * id_ldepminattawt)
								  ld_rationprice = ld_rationprice + ((2 * id_ldepminricewt) * id_ldepminriceprice) + ((2 * id_ldepminattawt) * id_ldepminattaprice)
								  id_no_lab_depmajor = id_no_lab_depmajor + 1
													
							End If
					
							if ll_nochild = 2 then
								exit
							end if
						fetch c4 into :ll_nochild,:ll_noy;
						loop
					  close c4; //end ration for child
		
					elseif ls_childcur_ind = 'B' then
						declare c41 cursor for
							select rownum, (((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365)) noy
							from fb_labourdependent ld,fb_labourspouse lsp 
							where ld.labour_id=lsp.labour_id and ld.child_active='1' and lsp.spouse_id= :fs_labour and ld.child_active='1' and  child_marital = 'U' and 
									(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) between 3 and 16) or
										( ((to_date(:fs_start_dt,'dd/mm/yyyy') - child_dob)/365) <= 18 and child_schoolflag='YES'));
						open c41;
						
							fetch c41 into :ll_nochild,:ll_noy;
							do while sqlca.sqlcode <> 100 
					
							 If ll_noy <= 10 Then
								  id_labricewt = id_labricewt + id_ldepminricewt
								  id_labattawt = id_labattawt + id_ldepminattawt
			
								  id_totricequan = id_totricequan + id_ldepminricewt
								  id_totattaquan = id_totattaquan + id_ldepminattawt
								  ld_rationprice = ld_rationprice + (id_ldepminricewt * id_ldepminriceprice) + (id_ldepminattawt * id_ldepminattaprice)
								  id_no_lab_depminor = id_no_lab_depminor + 1
							Else
								 id_labricewt = id_labricewt + 2 * id_ldepminricewt
								 id_labattawt = id_labattawt + 2 * id_ldepminattawt
			
								  id_totricequan = id_totricequan + (2 * id_ldepminricewt)
								  id_totattaquan = id_totattaquan + (2 * id_ldepminattawt)
								  ld_rationprice = ld_rationprice + ((2 * id_ldepminricewt) * id_ldepminriceprice) + ((2 * id_ldepminattawt) * id_ldepminattaprice)
								  id_no_lab_depmajor = id_no_lab_depmajor + 1
													
							End If
					
							if ll_nochild = 2 then
								exit
							end if
						fetch c41 into :ll_nochild,:ll_noy;
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

public function integer wf_substaffration (string fs_lwwid, string fs_start_dt);string ls_emp_id,ls_emp_sex,ls_emp_ty
double ld_majricewt ,ld_majattawt,ld_majricerate,ld_majattarate,ld_depmajricewt,ld_depmajattawt,ld_depmajricerate,ld_depmajattarate,ld_depminricewt,ld_depminattawt,&
		 ld_depminricerate,ld_depminattarate,ld_majriceprice,ld_majattaprice ,ld_depmajriceprice,ld_depmajattaprice,ld_depminriceprice,ld_depminattaprice,ld_attawt,ld_ricewt,ld_rationded

long ll_nomajor,ll_nodepmajor,ll_nodepminor,ll_cnt

	delete from fb_substaffweeklyration where lww_id=:fs_lwwid;

				   ld_majricewt =0;ld_majattawt=0;ld_majricerate=0;ld_majattarate=0;ld_depmajricewt=0;ld_depmajattawt=0;ld_depmajricerate=0;ld_depmajattarate=0;
				   ld_depminricewt=0;ld_depminattawt=0;ld_depminricerate=0;ld_depminattarate=0;
				   ld_majriceprice=0;ld_majattaprice=0;ld_depmajriceprice=0;ld_depmajattaprice=0;ld_depminriceprice=0;ld_depminattaprice=0;
					
				select sum(decode(trim(lrc_majorminorflag),'MAJOR',lrc_attawt,0)),sum(decode(trim(lrc_majorminorflag),'MAJOR',lrc_ricewt,0)),
						sum(decode(trim(lrc_majorminorflag),'MAJOR',lrc_attarate,0)),sum(decode(trim(lrc_majorminorflag),'MAJOR',lrc_ricerate,0)),
						sum(decode(trim(lrc_majorminorflag),'DEPMAJ',lrc_attawt,0)),sum(decode(trim(lrc_majorminorflag),'DEPMAJ',lrc_ricewt,0)),
						sum(decode(trim(lrc_majorminorflag),'DEPMAJ',lrc_attarate,0)),sum(decode(trim(lrc_majorminorflag),'DEPMAJ',lrc_ricerate,0)),
						sum(decode(trim(lrc_majorminorflag),'DEPMIN',lrc_attawt,0)),sum(decode(trim(lrc_majorminorflag),'DEPMIN',lrc_ricewt,0)),
						sum(decode(trim(lrc_majorminorflag),'DEPMIN',lrc_attarate,0)),sum(decode(trim(lrc_majorminorflag),'DEPMIN',lrc_ricerate,0))
				   into :ld_majricewt ,:ld_majattawt,:ld_majricerate,:ld_majattarate,:ld_depmajricewt,:ld_depmajattawt,:ld_depmajricerate,
						:ld_depmajattarate,:ld_depminricewt,:ld_depminattawt,:ld_depminricerate,:ld_depminattarate
				  from (select distinct lrc_majorminorflag,lrc_ricewt,lrc_attawt,lrc_ricerate,lrc_attarate
			  			   from fb_labourrationchart
						 where lrc_majorminorflag in('MAJOR','DEPMAJ','DEPMIN') and lrc_labourtype='LP' and lrc_noworkdays=6 and 
							  	to_date(:fs_start_dt,'dd/mm/yyyy') between LRC_FRDT and nvl(LRC_TODT,trunc(sysdate))) ;


              if sqlca.sqlcode = 100 then
				Messagebox("SQL Error: During :The Ration chart Select",sqlca.sqlerrtext)
				return -1
              elseif sqlca.sqlcode = -1 then
				Messagebox("Attention","The Ration chart for employee has not been registered.")
				return -1
              End If

		//  end ration deduction cal

		  ld_majriceprice = 0;ld_majattaprice = 0;ld_depmajriceprice = 0;ll_nodepmajor=0;ld_depmajattaprice = 0;ld_depminriceprice = 0;
		  ld_depminattaprice = 0;ll_nodepminor=0;ld_attawt = 0;ld_ricewt = 0;ld_rationded = 0;
		  setnull(ls_emp_id);setnull(ls_emp_sex);setnull(ls_emp_ty);
            ll_nomajor = 1

			declare c1 cursor for
				select emp.emp_id emp_id,emp.emp_sex,emp.emp_type emp_type from fb_employee emp where emp.emp_active='1' and emp.emp_type='SS';
			
			open c1;
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error: During Cursor C1 Open',sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if;
			
				fetch c1 into :ls_emp_id,:ls_emp_sex,:ls_emp_ty;
			do while sqlca.sqlcode <> 0

				 If ls_emp_ty = 'SS' And ls_emp_sex = 'M' Then
			  
						  select count(1) into :ll_cnt from fb_empspouse esp,fb_employee emp 
						  where esp.emps_id=emp.emp_id and emp.emp_type in('LP','LT','SS','ST') and esp.emp_id=:ls_emp_id and esp.emps_active='1';
						  
					  if ll_cnt =0 then	//SPOUSE IS NOT WORKING
						ll_cnt=0
						select count(1) into :ll_cnt from fb_empspouse where emp_id=:ls_emp_id and emps_active='1';
								 
						If ll_cnt >= 1 Then //SPOUSE IS ACTIVE
							ll_nodepmajor = ll_nodepmajor + 1
						End If
					 End If
					 
						 select sum(decode(empd_maritalstatus,'U',1,0)),(nvl(:ll_nodepmajor,0) + sum(decode(empd_maritalstatus,'W',1,0)))
						 into :ll_nodepminor,:ll_nodepmajor
						from fb_empdependents ld
						where EMP_ID =:ls_emp_id and empd_active='1' and 
								( (EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='M' and EMPD_MARITALSTATUS ='U' and 
									(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - EMPD_DOB)/365) <= 18) or
										( ((to_date(:fs_start_dt,'dd/mm/yyyy') - EMPD_DOB)/365) <= 21 and EMPD_SCHOOLFLAG='YES')) ) or
								  (EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
								  (:ls_emp_ty = 'ST' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
								  (:ls_emp_ty = 'ST' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) or
								  (:ls_emp_ty = 'ST' and EMPD_DEPENDENTTYPE='MOTHER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) );

							  if sqlca.sqlcode = -1 then
								Messagebox('SQL ERROR: During Dependent Select (Male)',sqlca.sqlerrtext)
								return -1
							  End If
							  
				elseIf ls_emp_ty = 'SS' And ls_emp_sex = 'F' Then
					
						  select count(1) into :ll_cnt from fb_empspouse esp,fb_employee emp 
						  where esp.emps_id=emp.emp_id and emp.emp_type in ('SS') and esp.emp_id=:ls_emp_id and esp.emps_active='1';
						  
					  if ll_cnt =0 then	//no male spouse as staff for this emp
					  	
						 select sum(decode(empd_maritalstatus,'U',1,0)),(nvl(:ll_nodepmajor,0) + sum(decode(empd_maritalstatus,'W',1,0)))
						 into :ll_nodepminor,:ll_nodepmajor
						from fb_empdependents ld
						where EMP_ID =:ls_emp_id and empd_active='1' and 
								( (EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='M' and EMPD_MARITALSTATUS ='U' and 
									(  ( ((to_date(:fs_start_dt,'dd/mm/yyyy') - EMPD_DOB)/365) <= 18) or
										( ((to_date(:fs_start_dt,'dd/mm/yyyy') - EMPD_DOB)/365) <= 21 and EMPD_SCHOOLFLAG='YES')) ) or
								  (EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
								  (:ls_emp_ty = 'ST' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
								  (:ls_emp_ty = 'ST' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) or
								  (:ls_emp_ty = 'ST' and EMPD_DEPENDENTTYPE='MOTHER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) )	;				 

							  if sqlca.sqlcode = -1 then
								Messagebox('SQL ERROR: During Dependent Select (Male)',sqlca.sqlerrtext)
								return -1
							  End If
					  end if
				end if

						  ld_majriceprice = Round(ld_majricewt * ld_majricerate * ll_nomajor, 2)
						  ld_majattaprice = Round(ld_majattawt * ld_majattarate * ll_nomajor, 2)
						  ld_depmajriceprice = Round(ld_depmajricewt * ld_depmajricerate * ll_nodepmajor, 2)
						  ld_depmajattaprice = Round(ld_depmajattawt * ld_depmajattarate * ll_nodepmajor, 2)
						  ld_depminriceprice = Round(ld_depminricewt * ld_depminricerate * ll_nodepminor, 2)
						  ld_depminattaprice = Round(ld_depminattawt * ld_depminattarate * ll_nodepminor, 2)
						  ld_attawt = (ld_majattawt * ll_nomajor) + (ld_depmajattawt * ll_nodepmajor) + (ld_depminattawt * ll_nodepminor)
						  ld_ricewt = (ld_majricewt * ll_nomajor) + (ld_depmajricewt * ll_nodepmajor) + (ld_depminricewt * ll_nodepminor)
						  ld_rationded = ld_majriceprice + ld_majattaprice + ld_depmajriceprice + ld_depmajattaprice + ld_depminriceprice + ld_depminattaprice
						  
						  insert into fb_substaffweeklyration(emp_id,lww_id,ricewt,attawt,rationded,nominor,noadult) 
						  values  (:ls_emp_id, :fs_lwwid ,:ld_ricewt,Lld_ricewt,:ld_rationded,:ll_nodepminor,:ll_nodepmajor) ;

						  if sqlca.sqlcode = -1 then
							Messagebox('SQL ERROR: During Ration chart Insert ',sqlca.sqlerrtext)
							return -1
						  End If

						  ld_majriceprice = 0;ld_majattaprice = 0;ld_depmajriceprice = 0;ll_nodepmajor=0;ld_depmajattaprice = 0;ld_depminriceprice = 0;
						  ld_depminattaprice = 0;ll_nodepminor=0;ld_attawt = 0;ld_ricewt = 0;ld_rationded = 0;
						  setnull(ls_emp_id);setnull(ls_emp_sex);setnull(ls_emp_ty);
						  
					fetch c1 into :ls_emp_id,:ls_emp_sex,:ls_emp_ty;
			loop
			close c1;
return 1


end function

public function double wf_fortnight_firstweek_workdays (string fs_lww_id, string fs_lab_id, string fs_st_dt);string ls_temp, ls_stdt, ls_enddt
double ld_fortnight_firstweek_workdays
long ll_cnt
ll_cnt = 0;ld_fortnight_firstweek_workdays=0;

select to_char(rpfw.rpfw_startdate,'dd/mm/yyyy'), to_char(RPFW_ENDDATE,'dd/mm/yyyy') into :ls_stdt, :ls_enddt
  from fb_rationperiodforweek rpfw
  where rpfw.RPFW_LWW_ID=:fs_lww_id and rpfw.rpfw_startdate <> to_date(:fs_st_dt,'dd/mm/yyyy');
  
if sqlca.sqlcode =0 then  
  
     select distinct 'x' into :ls_temp from fb_laboursheet ls,fb_employee l 
	 where l.ls_id=ls.ls_id and ls.ls_fortnightration='1' and l.emp_id= :fs_lab_id;

    if sqlca.sqlcode =0 then  
		
		select count(1) into :ld_fortnight_firstweek_workdays from fb_labourdailyattendance lda,fb_kamsubhead kam
		where kam.kamsub_id=lda.kamsub_id and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and trunc(lda.lda_date) between to_date(:ls_stdt,'dd/mm/yyyy') and to_date(:ls_enddt,'dd/mm/yyyy') and 
				((nvl(lda.lda_wages,0)+nvl(lda.lda_elp,0)) > 0 or trim(kam.kamsub_nkamtype)='SICKNOWAGES') AND labour_id= :fs_lab_id;

	elseif sqlca.sqlcode = 100 then
       	ld_fortnight_firstweek_workdays = 0
    elseif sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During First Week Work Days Select ',sqlca.sqlerrtext)
		return -1
    end If
elseif sqlca.sqlcode = 100 then
    		ld_fortnight_firstweek_workdays = 0
       	select count(1) into :ll_cnt from fb_laboursheet ls,fb_employee l where l.ls_id=ls.ls_id and ls.ls_fortnightration='1' and l.emp_id= :fs_lab_id;
     	 if sqlca.sqlcode =0 then  
			If ll_cnt = 1 Then
				ld_fortnight_firstweek_workdays = -1
			end If
		elseif sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: During Select ',sqlca.sqlerrtext)
			return -1
		end if;
else
	messagebox('SQL ERROR: During Ration Period Start & End Date Select ',sqlca.sqlerrtext)
	return -1
end if;

return ld_fortnight_firstweek_workdays;
end function

public function integer wf_upd_weekly_status (string fs_lww_id);datetime ld_lda_dt
string ls_labourid_old,ls_first_read,ls_emp_status,ls_status,ls_labour_id,ls_temp

update fb_labourweeklystatus set LWS_STATUS=' ' where LWW_ID = :fs_lww_id;

if sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Initilisation of Weekly Status ',sqlca.sqlerrtext)
	return -1
end if;

ls_first_read ='Y'

declare c1 cursor for 
 select lda.labour_id labourid, lda_date,
		 decode(trim(kam.kamsub_nkamtype),'OTHERS',decode(lda_status,1,'F','H'),'ABSENT','A','MATERNITY','M','SICKALLOWANCE','S','SICKNOWAGES','s',
		 'HOLIDAYPAY','O','HOLIDAYNOPAY','o','ACCIDENTHAZIRA','C','ANNUALLEAVE','R','CASUALLEAVE','R','SUBSTINANCEALLOWANCE','R','x') status
  from fb_labourdailyattendance lda,fb_kamsubhead kam 
where lda.kamsub_id=kam.kamsub_id  and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lda.lww_id= :fs_lww_id
order by lda.labour_id,2;
open c1; 

 if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
 else 

	setnull(ls_labour_id);setnull(ls_status);setnull(ld_lda_dt)

	fetch c1 into :ls_labour_id,:ld_lda_dt,:ls_status;
	
	do while sqlca.sqlcode <> 100 
		
		if ls_first_read='Y' or ls_labourid_old <> ls_labour_id then
			
			if ls_first_read='N' then
				
				select distinct 'x' into :ls_temp from fb_labourweeklystatus where LWW_ID = :fs_lww_id and LABOUR_ID= :ls_labourid_old ;
				
				if sqlca.sqlcode = -1 then
					messagebox('SQL ERROR: Select Weekly Status ',sqlca.sqlerrtext)
					return -1
				elseif sqlca.sqlcode = 0 then
					update fb_labourweeklystatus set LWS_STATUS = :ls_emp_status where LWW_ID = :fs_lww_id and LABOUR_ID= :ls_labourid_old ;
					if sqlca.sqlcode = -1 then
						messagebox('SQL ERROR: Update Weekly Status ',sqlca.sqlerrtext)
						return -1
					end if
				else
					insert into fb_labourweeklystatus (LWW_ID,LABOUR_ID,LWS_STATUS) values ( :fs_lww_id,:ls_labourid_old, :ls_emp_status );
					if sqlca.sqlcode = -1 then
						messagebox('SQL ERROR: Insert Weekly Status ',sqlca.sqlerrtext)
						return -1
					end if
				end if
			end if
			
			ls_emp_status = ls_status
			ls_first_read='N'
			ls_labourid_old = ls_labour_id;
		else
			ls_emp_status = ls_emp_status + '-' + ls_status
		end if

		setnull(ls_labour_id);setnull(ld_lda_dt);setnull(ls_status);
		
		fetch c1 into :ls_labour_id,:ld_lda_dt,:ls_status;
		
	loop

		select distinct 'x' into :ls_temp from fb_labourweeklystatus where LWW_ID = :fs_lww_id and LABOUR_ID= :ls_labourid_old ;
		
		if sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: Select Weekly Status ',sqlca.sqlerrtext)
			return -1
		elseif sqlca.sqlcode = 0 then
			update fb_labourweeklystatus set LWS_STATUS = :ls_emp_status where LWW_ID = :fs_lww_id and LABOUR_ID= :ls_labourid_old ;
			if sqlca.sqlcode = -1 then
				messagebox('SQL ERROR: Update Weekly Status ',sqlca.sqlerrtext)
				return -1
			end if
		else
			insert into fb_labourweeklystatus (LWW_ID,LABOUR_ID,LWS_STATUS) values ( :fs_lww_id,:ls_labourid_old, :ls_emp_status );
			if sqlca.sqlcode = -1 then
				messagebox('SQL ERROR: Insert Weekly Status ',sqlca.sqlerrtext)
				return -1
			end if
		end if
	close c1;	
 end if	

RETURN 1
end function

public function integer wf_emp_wagecal (string fs_ym, string fs_chklwf, string fs_chkration);string ls_temp,ls_emp_id,ls_emp_pfdedcode,ls_emp_sex,ls_emp_type ,ls_emp_house,ls_emp_elect,ls_emp_statustype,ls_emp_statusdays,ls_status,ls_emp_pfno
double ld_adhoc,ld_egd_id,ld_basic,ld_ead_da,ld_ead_vda,ld_ead_cvrforpf,ld_ead_hr,ld_ead_electric,ld_ead_fuel,ld_ead_pensionfundded,ld_ead_pfcontded,&
		  ld_ead_ptaxded,ld_ead_revstampaboveded,ld_ead_lwfded,ld_coincf,ld_coinbf, ld_nodays,ld_tot_days,ld_ndays,ld_basicded,ld_cvrded,ld_da,ld_vda,ld_cvrforpf,&
		  ld_hr,ld_electric,ld_fuel,ld_pensionded ,ld_pfcontded,ld_lwfded,ld_advanceded ,ld_lipded ,ld_ptgross,ld_ptaxded,ld_totearn,ld_totded,ld_netpayable,ld_pfadvanceded,ld_pffpf_rnd_off,ld_rnd_off, ld_elededamt, &
		  ld_electadvded, ld_medadvded, ld_festadvded, ld_pfintadvded

double ld_majricewt ,ld_majattawt,ld_majricerate,ld_majattarate,ld_depmajricewt,ld_depmajattawt,ld_depmajricerate,ld_depmajattarate,ld_depminricewt,ld_depminattawt,&
		 ld_depminricerate,ld_depminattarate,ld_majriceprice,ld_majattaprice ,ld_depmajriceprice,ld_depmajattaprice,ld_depminriceprice,ld_depminattaprice,ld_attawt,ld_ricewt,&
		 ld_rationded,ld_pension,ld_pt_elec,ld_pt_fuel,ld_nKoilAmo,ld_nrd,ld_cyclealw,ld_sdays,ld_brationwt,ld_brationamt, ld_vol_pfper, ld_vol_pfamt, ld_pf_eb_amt, ld_eb_amt

long ll_nomajor,ll_nodepmajor,ll_nodepminor,ll_nodepminorphase2,ll_cnt,ll_revstampded,ll_no_weeks,ll_nodepmajor1

 
string ls_spouse,ls_mchild,ls_wsister,ls_umsister,ls_wmother,ls_major_dep,ls_umgirl, ls_koil_ind, ls_ebpf_ind
long ll_mstage,ll_wsage,ll_sage,ll_minorage,ll_nodep

// select distinct eps_paidflag  into :ls_temp from fb_emppaymentstatus
//  where ((eps_year * 100) + eps_month) = to_char(add_months(to_date(:fs_ym,'YYYYMM'),-1),'yyyymm');
//
//
//if ls_temp = '0' Then
//	messagebox('Last Month Payment Pending','The payment for last month Is still pending, Please check Pay Last Month First...!')
//	return -1
//End If
ld_nKoilAmo = 0;
setnull(ls_temp)

 select distinct eps_paidflag  into :ls_temp from fb_emppaymentstatus where ((eps_year * 100) + eps_month) = :fs_ym;

if  ls_temp = '1' Then
	messagebox('Payment Error','The Payment has already been paid against this month and year')
	return -1
End If

ld_tot_days=0;

select to_number(to_char(last_day(to_date(:fs_ym,'yyyymm')),'dd')) into :ld_tot_days from dual;

if sqlca.sqlcode =-1 then
	messagebox('SQL Error : During Select Total No Days ',sqlca.sqlerrtext)
	return -1
End If

if isnull(ld_tot_days) then ld_tot_days=0

setnull(ls_temp)
          
		ld_majricewt =0;ld_majattawt=0;ld_majricerate=0;ld_majattarate=0;ld_depmajricewt=0;ld_depmajattawt=0;ld_depmajricerate=0;ld_depmajattarate=0;
		ld_depminricewt=0;ld_depminattawt=0;ld_depminricerate=0;ld_depminattarate=0;ll_nodepmajor1 = 0;ld_nrd=0;ld_cyclealw=0
		ld_majriceprice=0;ld_majattaprice=0;ld_depmajriceprice=0;ld_depmajattaprice=0;ld_depminriceprice=0;ld_depminattaprice=0;
		
    if gs_garden_snm = 'MT' then
		select count(1) into :ll_no_weeks from fb_rationperiodforweek where to_char(RPFW_ENDDATE,'yyyymm') = :fs_ym;
		if sqlca.sqlcode =-1 then
			messagebox('SQL Error : During No of Weeks Payment ',sqlca.sqlerrtext)
			return -1
		End If	
	elseif gs_garden_snm = 'AB' or gs_garden_snm = 'SP' or gs_garden_snm = 'MR' or gs_garden_snm = 'LP' or gs_garden_snm = 'AD' or gs_garden_snm = 'MH' or gs_garden_snm = 'DR'  then
		ll_no_weeks = 4
	else
		select count(1) into :ll_no_weeks from fb_labourwagesweek where to_char(lww_enddate,'yyyymm') = :fs_ym;
		if sqlca.sqlcode =-1 then
			messagebox('SQL Error : During No of Weeks Payment ',sqlca.sqlerrtext)
			return -1
		End If		
	end if
	 
	if isnull(ll_no_weeks) then ll_no_weeks=0
	
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
			 where lrc_majorminorflag in ('MAJOR','DEPMAJ','DEPMIN') and lrc_labourtype='LP' and lrc_noworkdays=6 and FIELD_ID = :gs_storeid and 
					:fs_ym between to_char(LRC_FRDT,'yyyymm') and to_char(nvl(LRC_TODT,trunc(sysdate)),'yyyymm') and lrc_active_ind = 'Y');

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
	if isnull(ld_eb_amt) then ld_eb_amt = 0;
	if isnull(ld_pf_eb_amt) then ld_pf_eb_amt = 0;
	
	
	select sum(decode(pd_doc_type,'PENSIONAMT',pd_value,0)) , sum(decode(pd_doc_type,'PFFPFROUND',pd_value,0)),
			sum(decode(pd_doc_type,'ROUNDOFF',pd_value,0))
	into :ld_pension,:ld_pffpf_rnd_off,:ld_rnd_off
	from fb_param_detail 
	where pd_doc_type in ('PENSIONAMT','PFFPFROUND','ROUNDOFF') and to_date(:fs_ym,'yyyyMM') between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));

	if sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
		return -1
	end if;
	if isnull(ld_pension) then ld_pension=0
	if isnull(ld_pffpf_rnd_off) then ld_pffpf_rnd_off=0;
	if isnull(ld_rnd_off) then ld_rnd_off=0;
	
	delete from fb_emppayment where ((ep_year * 100) + ep_month) = :fs_ym;
	
	if sqlca.sqlcode =-1 then
		messagebox('SQL Error : During Employee Payment (Delete) ',sqlca.sqlerrtext)
		return -1
	End If



declare c1 cursor for 
 select emp.emp_id emp_id,emp.emp_adhoc emp_adhoc,emp.edg_id egd_id,emp.EMP_PFNO,emp.emp_pfdedcode emp_pfdedcode,emp.emp_sex,
          emp.emp_type emp_type,emp.emp_house emp_house,emp.emp_elect emp_elect,
         emp.EBS_BASICAMOUNT ebs_basicamount,ead.ead_da ead_da,ead.ead_vda ead_vda,ead.ead_cvrforpf ead_cvrforpf,ead.ead_hr ead_hr,
         ead.ead_electric ead_electric,ead.ead_fuel ead_fuel,ead.ead_pensionfundded ead_pensionfundded,ead.ead_pfcontded ead_pfcontded,
         ead.ead_ptaxded ead_ptaxded,ead.ead_revenuestampaboveded ead_revstampaboveded,ead.ead_lwfded ead_lwfded ,
         emp.EMP_RD,emp.EMP_CYCLEALLOW, nvl( electamt,0) electamt, nvl(EMP_KEROSININD,'N') EMP_KEROSININD,ead.ead_cvfood,
         nvl(EMP_LIGHTALOW,0), nvl(EMP_SEASONALOW,0), nvl(EMP_CHARGEALOW,0), nvl(EMP_COMPUTERALOW,0), nvl(emp_vol_pfper,0),
         ls_ebpf_ind, nvl(eb_amt,0) eb_amt 
  from fb_employee emp ,(select * from fb_empallowancededuction where 
                                      (((EAD_YEAR * 100) +  EAD_MONTH), EAD_GRADE) in (select max(((EAD_YEAR * 100) +  EAD_MONTH)), EAD_GRADE 
                                          from fb_empallowancededuction where ((EAD_YEAR * 100) +  EAD_MONTH) <= :fs_ym group by EAD_GRADE)) ead,
        (select ED_EMPID, nvl(ED_AMOUNT,0) electamt from FB_EMPELECTRICDED where  (nvl(ED_YEAR,0) * 100 + nvl(ED_MONTH,0)) = :fs_ym),
        (select EB_EMPID, nvl(EB_PFFLAG,'N') ls_ebpf_ind,  nvl(EB_AMOUNT,0) eb_amt  from fb_extrabenefits where EB_YRMON  = :fs_ym) 
  where emp.emp_active='1' and emp.emp_type in('EXE','SS','ST','AT') and EAD_GRADE=EMP_GRADE and emp_id  = ED_EMPID(+) and emp_id  = EB_EMPID(+);
					//and emp.emp_id= 'P00039'; 

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
end if 

		setnull(ls_emp_id);setnull(ls_emp_pfdedcode);setnull(ls_emp_sex);setnull(ls_emp_type);setnull(ls_emp_house);setnull(ls_emp_elect);setnull(ls_emp_pfno); setnull(ls_ebpf_ind);
		ld_adhoc=0;ld_egd_id=0;ld_basic=0;ld_ead_da=0;ld_ead_vda=0;ld_ead_cvrforpf=0;ld_ead_hr=0;ld_ead_electric=0;ld_ead_fuel=0;
		ld_ead_pensionfundded=0;ld_ead_pfcontded=0;ld_ead_ptaxded=0;ld_ead_revstampaboveded=0;ld_ead_lwfded =0;ld_nrd=0;ld_cyclealw=0
		ld_nodays=0;ld_ndays=0;ld_basicded=0;ld_cvrded=0;ld_da=0;ld_vda=0;ld_cvrforpf=0;ld_hr=0;ld_electric=0;ld_fuel=0;ld_pfadvanceded=0
		ld_pensionded =0;ld_pfcontded=0;ld_lwfded=0;ld_advanceded =0;ld_lipded =0;ld_ptgross=0;ld_ptaxded=0;ld_totearn=0;ld_totded=0; ld_netpayable=0;
		ll_nomajor = 0;ll_nodepmajor = 0;ll_nodepmajor = 0;ll_nodepminorphase2 = 0; ld_attawt = 0; ld_ricewt = 0;ld_rationded = 0 ; ld_cvfood = 0;
		ld_majriceprice = 0;ld_majattaprice = 0;ld_depmajriceprice = 0;ld_depmajattaprice = 0;ld_depminriceprice = 0;ld_depminattaprice = 0;ld_elededamt = 0; setnull(ls_koil_ind);
		ld_LIGHTALOW = 0; ld_SEASONALOW = 0; ld_CHARGEALOW = 0; ld_COMPUTERALOW = 0; ld_vol_pfper = 0;  ld_eb_amt = 0; ld_electadvded = 0; ld_medadvded = 0; ld_festadvded = 0;ld_pfintadvded=0;

	fetch c1 into :ls_emp_id,:ld_adhoc,:ld_egd_id,:ls_emp_pfno,:ls_emp_pfdedcode,:ls_emp_sex,:ls_emp_type ,:ls_emp_house,:ls_emp_elect,
				     :ld_basic,:ld_ead_da,:ld_ead_vda,:ld_ead_cvrforpf,:ld_ead_hr,:ld_ead_electric,:ld_ead_fuel,:ld_ead_pensionfundded,
					:ld_ead_pfcontded,:ld_ead_ptaxded,:ld_ead_revstampaboveded,:ld_ead_lwfded,:ld_nrd,:ld_cyclealw,:ld_elededamt, :ls_koil_ind,
					:ld_cvfood,:ld_LIGHTALOW, :ld_SEASONALOW, :ld_CHARGEALOW, :ld_COMPUTERALOW, :ld_vol_pfper,  :ls_ebpf_ind, :ld_eb_amt ;
	
	do while sqlca.sqlcode <> 100 
			
  			if isnull(ld_adhoc) then ld_adhoc = 0;
            //start calculate employee monthly working status
		  select count(1) into :ld_nodays from fb_empattendance where emp_id=:ls_emp_id and to_char(EATTEN_DATE,'yyyymm') = :fs_ym ;
		 
            If ld_nodays <> ld_tot_days Then
                MessageBox('Attendance Error','Please give the attendance of all days for Employee ' +ls_emp_id+'  then you can calculate it ')
                return -1
            End If
				
			ls_emp_statustype=""; ls_emp_statusdays=""
			ld_tndays = 0;
			
//			select upper(eatten_status) status,count(*) nodays  from fb_empattendance
//			 where emp_id=:ls_emp_id and to_char(eatten_date,'yyyymm')= :fs_ym 
//			group by upper(eatten_status)
//			order by 1;

//			select upper(eatten_status) status,
//			           sum(decode(upper(eatten_status),'SP',decode(:gs_garden_snm,'MT',decode(eatten_hajari,'F',1,'H',0.5,'T',0.75,'O',0.25,1),1),1)) nodays, count(*) ndays  from fb_empattendance
//			 where emp_id=:ls_emp_id and to_char(eatten_date,'yyyymm')= :fs_ym 
//			group by upper(eatten_status)
//			order by 1;

			declare c2 cursor for 

			select upper(eatten_status) status,
					 sum(decode(upper(eatten_status),'SP',decode(:gs_garden_snm,'MT',decode(eatten_hajari,'F',1,'H',0.5,'T',0.75,'O',0.25,1),'MR',decode(eatten_hajari,'F',1,'H',0.5,'T',0.75,'O',0.25,1),'SP',decode(eatten_hajari,'F',1,'H',0.5,'T',0.75,'O',0.25,1),'AB',decode(eatten_hajari,'F',1,'H',0.5,'T',0.75,'O',0.25,1),'LP',decode(eatten_hajari,'F',1,'H',0.5,'T',0.75,'O',0.25,1),'AD',decode(eatten_hajari,'F',1,'H',0.5,'T',0.75,'O',0.25,1),'MH',decode(eatten_hajari,'F',1,'H',0.5,'T',0.75,'O',0.25,1),'DR',decode(eatten_hajari,'F',1,'H',0.5,'T',0.75,'O',0.25,1),1),1)) nodays, count(*) ndays  from fb_empattendance
			where emp_id=:ls_emp_id and to_char(eatten_date,'yyyymm')= :fs_ym 
			group by upper(eatten_status);
			
 			
			 
			 open c2;
	           	setnull(ls_status);ld_ndays=0;ld_sdays = 0;
			 
			 	fetch c2  into :ls_status,:ld_ndays,:ld_sdays;
				do while sqlca.sqlcode <> 100 
					
					if ls_emp_statustype="" then
						ls_emp_statustype = ls_status
						ls_emp_statusdays = string(ld_sdays)
					else
						ls_emp_statustype = ls_emp_statustype + '-' +ls_status
						ls_emp_statusdays = ls_emp_statusdays+ '-' +string(ld_sdays)
					end if
					
					if ls_status = 'A' or ls_status='AB' or ls_status='HW' or ls_status='SO' then
//						if gs_garden_state = '03' then // as per discussion with rahman sir on 23rd Nov 2015 for all gardens amt ded for one day = ld_basic / 26
							ld_basicded = ld_basicded + ld_ndays * (ld_basic / 26)   /////for tripura on 30082012
//						else
//						  	ld_basicded = ld_ndays * (ld_basic / ld_tot_days)
//						end if
//						  ld_adhoc = ld_adhoc - ld_ndays * (ld_adhoc / ld_tot_days) //TO BE CONFIRMED  // as per discussion with rahman sir on 23rd Nov 2015 for all gardens amt ded for one day = ld_basic / 26
						  ld_adhoc = ld_adhoc - ld_ndays * (ld_adhoc / 26) //TO BE CONFIRMED
						  ld_CVRDED = ld_ndays
					elseif ls_status = 's' or ls_status='SI' then
						if (gs_garden_snm = 'FB' or gs_garden_snm = 'KG' or gs_garden_snm = 'MT' or gs_garden_snm = 'AB' or gs_garden_snm = 'SP' or gs_garden_snm = 'MR' or gs_garden_snm = 'LP' or gs_garden_snm = 'AD' or gs_garden_snm = 'MH' or gs_garden_snm = 'DR' ) and ls_emp_type = 'SS' then
//							  ld_basicded = ld_basicded + (ld_ndays * ((ld_basic / ld_tot_days) * (1 - (2/3))))  // as per discussion with rahman sir on 23rd Nov 2015 for all gardens amt ded for one day = ld_basic / 26
							  ld_basicded = ld_basicded + (ld_ndays * ((ld_basic / 26) * (1 - (2/3))))
//						else
//							  ld_adhoc = ld_adhoc - ld_ndays * (ld_adhoc / ld_tot_days) //TO BE CONFIRMED			=== As per issue no C0001043 dated 20-Oct-2013	in case of sick adhoc is not deducted.
						end if
						  ld_CVRDED = ld_ndays
					elseif ls_status = 'SP'  then
						 ld_basicded = ld_basicded + (ld_ndays * 0.5 *((ld_basic /26))) 
						 // THIS PART HAS BEEN COMMENTED ON THE BASIS OF MAIL BY SUBHASISH SIR ON 31/05/22
//						if gs_garden_snm = 'MT' or gs_garden_snm = 'AB' or gs_garden_snm = 'SP' or gs_garden_snm = 'MR' or gs_garden_snm = 'LP'  or gs_garden_snm = 'AD' or gs_garden_snm = 'MH' or gs_garden_snm = 'DR' then
////							  ld_basicded = ld_basicded + (ld_ndays * ((ld_basic / ld_tot_days)))          // In case of Suspend no salary paid.
//							  ld_basicded = ld_basicded + (ld_ndays * ((ld_basic / 26)))          			// as per discussion with rahman sir on 23rd Nov 2015 for all gardens amt ded for one day = ld_basic / 26
//						elseif gs_garden_snm = 'FB'  then
////							  ld_basicded = ld_basicded + (ld_ndays * 0.5 *((ld_basic / ld_tot_days)))   // In case of Suspend half salary paid.
//							  ld_basicded = ld_basicded + (ld_ndays * 0.5 *((ld_basic /26)))   			// as per discussion with rahman sir on 23rd Nov 2015 for all gardens amt ded for one day = ld_basic / 26
//						end if	  
					end if
					// change on 28072018
//					if trim(ls_status) <> 'WR'  then
//						if ls_status = 'SP' then 
//							ld_ndays = ld_ndays * 2
//						end if
//						if ls_status = 'AB' or ls_status = 'WR' then
//							ld_ndays = 0
//						end if
//						ld_tndays = ld_tndays + ld_ndays
//					end if
					//					
					
	           		setnull(ls_status);ld_ndays=0;ld_sdays = 0;
					fetch c2  into :ls_status,:ld_ndays,:ld_sdays;
				loop
				
			 if isnull(ls_emp_statustype) or ls_emp_statustype=""	then
				MessageBox('Attendance Error','Please give the attendance for Employee.Then you can calculate it ')
				return -1
			 end if
			close c2;
			
		//	end calculate employee monthly working status
		
		
			if gs_garden_snm = 'MT' or gs_garden_snm = 'FB'  or gs_garden_snm = 'MK' then
				
				select sum(decode(upper(eatten_status),'AB',0,'WR',0,1)) into :ld_tndays from fb_empattendance where emp_id=:ls_emp_id and to_char(eatten_date,'yyyymm')= :fs_ym;
				
				if ld_tndays > 26 then
					ld_tcvfood = 26 *  ld_cvfood
				else
					ld_tcvfood = ld_tndays * ld_cvfood
				end if
			else
				ld_tcvfood = 0
			end if
		
			
            ld_basic = ld_basic - ld_basicded
            If ld_basic < 0 Then  ld_basic = 0
            If ld_adhoc < 0 Then ld_adhoc = 0
		   if gs_garden_snm = 'AB' or gs_garden_snm = 'SP' or gs_garden_snm = 'MR' or gs_garden_snm = 'LP'  or gs_garden_snm = 'AD' or gs_garden_snm = 'MH' or gs_garden_snm = 'DR' then	
				select sum(nvl(OT_HOURS,0)) into :ld_othours from fb_overtime where to_char(OT_DT,'YYYYMM') = :fs_ym and OT_EMP_ID = :ls_emp_id;
				if sqlca.sqlcode = -1 then
					messagebox('SQL ERROR: During Getting OT Details ',sqlca.sqlerrtext)
					return -1
				end if;   
				if isnull(ld_othours) then ld_othours = 0;
				ld_otamt = (((((ld_basic + ld_da + ld_vda) / 26 / 8) * 2) + 1.44) * ld_othours)
			end if

            If Trim(ls_emp_type) = 'ST' Or Trim(ls_emp_type) = 'SS' Or Trim(ls_emp_type) = 'AT' Then
				ld_da = ld_basic * ld_ead_da / 100
				ld_vda = ld_basic * ld_ead_vda / 100
//				If Trim(ls_emp_type) = 'ST'  Then
//					ld_cvrforpf = ld_ead_cvrforpf //ration qty.(actual Up-issue UP) to be calculated later
//				Else
				if ld_basicded > 0 then   ///  on 30082012
					ld_cvrforpf = ld_ead_cvrforpf - ((ld_ead_cvrforpf / ld_tot_days) * ld_CVRDED)
				else
					ld_cvrforpf = ld_ead_cvrforpf
				End If
				ld_hr = ld_basic * ld_ead_hr / 100
				ld_electric = ld_ead_electric //slabwise to be calculated later
				ld_fuel = ld_ead_fuel //slabwise to be calculated later
				If ld_basic = 0  then
					ld_cvrforpf = 0
					ld_electric = 0
					ld_fuel = 0
				end if				
            Else
				ld_da = 0;ld_vda = 0;ld_cvrforpf = 0;ld_hr = 0;ld_electric = 0;ld_fuel = 0
            End If
		   
		  if isnull(ld_cyclealw) then ld_cyclealw = 0;
		   if isnull(ld_LIGHTALOW) then ld_LIGHTALOW = 0;
		   if isnull(ld_SEASONALOW) then ld_SEASONALOW = 0;
		   if isnull(ld_CHARGEALOW) then ld_CHARGEALOW = 0;
		   if isnull(ld_COMPUTERALOW) then ld_COMPUTERALOW = 0;
			
			if ls_ebpf_ind = 'Y' then
				ld_pf_eb_amt = ld_eb_amt
			else
				ld_pf_eb_amt = 0
			end if
				
				
		   if gs_garden_snm <> 'NP' and gs_garden_snm <> 'SH' and gs_garden_snm <> 'MB' and gs_garden_snm <> 'DL' and gs_garden_snm <> 'AB' and gs_garden_snm <> 'SP' and gs_garden_snm <> 'MR' and gs_garden_snm <> 'LP'   and gs_garden_snm <> 'AD' and gs_garden_snm <> 'MH' and gs_garden_snm <> 'DR' then
				if  (ls_emp_pfdedcode ='1' or ls_emp_pfdedcode ='2' ) then
					If ls_emp_pfdedcode = '2' Then
							ld_pensionded = round(((ld_basic + ld_da + ld_vda + ld_cvrforpf + ld_tcvfood + ld_pf_eb_amt) * ld_ead_pensionfundded / 100),ld_pffpf_rnd_off)
							
							if ld_pensionded > ld_pension then
								ld_pensionded = ld_pension
							end if	
							
							ld_pfcontded = round((((ld_basic + ld_da + ld_vda + ld_cvrforpf + ld_tcvfood + ld_pf_eb_amt) * (ld_ead_pfcontded + ld_ead_pensionfundded) / 100) - ld_pensionded),ld_pffpf_rnd_off)
						
					Else
							ld_pfcontded = round(((ld_basic + ld_da + ld_vda + ld_cvrforpf + ld_tcvfood + ld_pf_eb_amt) * (ld_ead_pfcontded + ld_ead_pensionfundded) / 100),ld_pffpf_rnd_off)
							ld_pensionded = 0
					End If
				end if
			elseif gs_garden_snm = 'AB' or gs_garden_snm = 'SP' or gs_garden_snm = 'MR' or gs_garden_snm = 'LP'  or gs_garden_snm = 'AD' or gs_garden_snm = 'MH' or gs_garden_snm = 'DR' then
				if  (ls_emp_pfdedcode ='1' or ls_emp_pfdedcode ='2' ) then
					If ls_emp_pfdedcode = '2' Then
						ld_pensionded = round(((ld_basic + ld_da + ld_vda + ld_cvrforpf + ld_tcvfood + ld_otamt + ld_cyclealw + ld_LIGHTALOW + ld_SEASONALOW + ld_CHARGEALOW + ld_COMPUTERALOW + ld_pf_eb_amt) * ld_ead_pensionfundded / 100),ld_pffpf_rnd_off)
					
						if ld_pensionded > ld_pension then
							ld_pensionded = ld_pension
						end if
							//ld_pfcontded = round((((ld_basic + ld_da + ld_vda + ld_cvrforpf) * (ld_ead_pfcontded + ld_ead_pensionfundded) / 100) - ld_pensionded),ld_pffpf_rnd_off)
							//Commented as per the mail and issue track from  MR.Paridha on (Mon 01/05/2023 09:42)
							//uncomented as per the mail from  MR.Paridha on (Thu 11/05/2023 09:30)
						ld_pfcontded = round((((ld_basic + ld_da + ld_vda + ld_cvrforpf + ld_tcvfood  + ld_otamt + ld_cyclealw + ld_LIGHTALOW + ld_SEASONALOW + ld_CHARGEALOW + ld_COMPUTERALOW + ld_pf_eb_amt) * (ld_ead_pfcontded + ld_ead_pensionfundded) / 100) - ld_pensionded),ld_pffpf_rnd_off)
					Else
						//	ld_pfcontded = round((((ld_basic + ld_da + ld_vda + ld_cvrforpf) * (ld_ead_pfcontded + ld_ead_pensionfundded) / 100) - ld_pensionded),ld_pffpf_rnd_off)
							
							//Commented as per the mail and issue track from  MR.Paridha on (Mon 01/05/2023 09:42)
							//uncomented as per the mail from  MR.Paridha on (Thu 11/05/2023 09:30)
						ld_pfcontded = round(((ld_basic + ld_da + ld_vda + ld_cvrforpf + ld_tcvfood + ld_otamt + ld_cyclealw + ld_LIGHTALOW + ld_SEASONALOW + ld_CHARGEALOW + ld_COMPUTERALOW + ld_pf_eb_amt) * (ld_ead_pfcontded + ld_ead_pensionfundded) / 100),ld_pffpf_rnd_off)
						ld_pensionded = 0
					End If
				end if				
			elseif gs_garden_snm = 'NP' or gs_garden_snm = 'SH' or gs_garden_snm = 'MB' or gs_garden_snm = 'DL' then

				if isnull(ld_adhoc) then ld_adhoc = 0
				if isnull(ld_cyclealw) then ld_cyclealw = 0
				if isnull(ld_cvrforpf) then ld_cvrforpf = 0
				
				if  (ls_emp_pfdedcode ='1' or ls_emp_pfdedcode ='2' ) then
					If ls_emp_pfdedcode = '2' Then
						ld_pensionded = round(((ld_basic + ld_adhoc + ld_cyclealw+ ld_da + ld_vda + ld_cvrforpf + ld_pf_eb_amt) * ld_ead_pensionfundded / 100),ld_pffpf_rnd_off)
					
						if ld_pensionded > ld_pension then
							ld_pensionded = ld_pension
						end if
						
						ld_pfcontded = round((((ld_basic + ld_adhoc + ld_cyclealw + ld_da + ld_vda + ld_cvrforpf + ld_pf_eb_amt) * (ld_ead_pfcontded + ld_ead_pensionfundded) / 100) - ld_pensionded),ld_pffpf_rnd_off)
					Else
						ld_pfcontded = round(((ld_basic + ld_adhoc + ld_cyclealw + ld_da + ld_vda + ld_cvrforpf + ld_pf_eb_amt) * (ld_ead_pfcontded + ld_ead_pensionfundded) / 100),ld_pffpf_rnd_off)
						ld_pensionded = 0
					End If
				end if
			end if				
            
            If fs_chklwf = 'Y' Then
                ld_lwfded = ld_ead_lwfded //some checking may be required
            Else
                ld_lwfded = 0
            End If
		   If ld_basic = 0  then
				ld_lwfded = 0
		   end if
				
            //1 start electricded,advanceded and rationded cal
            select ewd_advanceded,EWD_PFADVDED,ewd_lipded,ewd_electricded, ewd_medadvded, ewd_festadvded,ewd_pfinterestded into :ld_advanceded ,:ld_pfadvanceded,:ld_lipded, :ld_electadvded, :ld_medadvded, :ld_festadvded,:ld_pfintadvded from fb_empwisededuction 
		  where emp_id=:ls_emp_id and ((ewd_year * 100) + ewd_month) = :fs_ym ; 
		  
		  if sqlca.sqlcode =100 then
                ld_advanceded = 0;ld_pfadvanceded=0
                ld_lipded = 0; ld_electadvded = 0; ld_medadvded = 0; ld_festadvded = 0;ld_pfintadvded=0;
            End If
		   if gs_garden_snm='MT' then
	
				select nvl(ki_rate,0) * decode(:ls_emp_type,'ST',nvl(ki_quantity,0) * 2,nvl(ki_quantity,0)) into :ld_nKoilAmo
				  from fb_kerosinissue
				 where ki_yearmonth =  to_number(:fs_ym);
						  
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During KOIL (Dedn): ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 
				end if;
				if isnull(ld_nKoilAmo) then ld_nKoilAmo = 0;
			else
				ld_nKoilAmo = 0		
			 end if 
			
				
				
            //end electric deduction
            //start ration
		   if gs_garden_snm <> 'MT' then            
				If ld_basic > 0 and fs_chkration ='Y' Then
	//                Call clculateration(rstpay!emp_id, rstpay!emp_sex, Trim(rstpay!emp_type))
				  setnull(ls_spouse);setnull(ls_mchild);setnull(ls_major_dep);setnull(ls_umgirl);setnull(ls_wsister);setnull(ls_umsister);setnull(ls_wmother)
				  ll_mstage=0;ll_wsage=0;ll_sage=0;ll_minorage=0;ll_nodep=0;
				  
	
				  select nvl(RP_SPOUSE_IND,'N'), nvl(RP_CH_IND,'N'), rp_major_dpind,nvl(RP_CH_STARTAGE,0), nvl(RP_CH_WSCH_AGE,0), nvl(RP_CH_SCH_AGE,0), nvl(RP_MINOR_DEPAGE,0), nvl(RP_NOOF_DEP,0),nvl(rp_um_fch,'N'),nvl(RP_WIDOW_SISTER,'N'), nvl(RP_UNMARRIED_SISTER,'N'), nvl(RP_WIDOW_MOTHER,'N')
				  into :ls_spouse,:ls_mchild,:ls_major_dep,:ll_mstage,:ll_wsage,:ll_sage,:ll_minorage,:ll_nodep,:ls_umgirl,:ls_wsister,:ls_umsister,:ls_wmother
				  from fb_rationparam 
				  where RP_EMPTYPE = :ls_emp_type and to_date(:fs_ym,'yyyymm') between RP_PERIOD_FROM and nvl(RP_PERIOD_TO,trunc(sysdate));
				
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
					 If (ls_emp_type = 'ST' or ls_emp_type = 'AT') And ls_emp_sex = 'M' Then
				  
							  select count(1) into :ll_cnt from fb_empspouse esp,fb_employee emp 
							  where esp.emps_id=emp.emp_id and emp.emp_type in('LP','LT','SS','ST','AT') and esp.emp_id=:ls_emp_id and esp.emps_active='1';
							  
						  if ll_cnt =0 then	//SPOUSE IS NOT WORKING
							ll_cnt=0
							select count(1) into :ll_cnt from fb_empspouse where emp_id=:ls_emp_id and emps_active='1';
									 
							If ll_cnt >= 1 Then //SPOUSE IS ACTIVE
								ll_nodepmajor = ll_nodepmajor + 1
							End If
						 End If
						 
							 select sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) - :ll_minorage),1,0,1),0)),
									 sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) - :ll_minorage),1,1,0),0)),
									 sum(decode(empd_maritalstatus,'W',1,'M',1,0))
							 into :ll_nodepminorphase2,:ll_nodepminor,:ll_nodepmajor1
							from fb_empdependents ld
							where EMP_ID =:ls_emp_id and empd_active='1' and 
									( (:ls_mchild='Y' and EMPD_DEPENDENTTYPE='CHILD' and  EMPD_MARITALSTATUS ='U' and 
										(  ( ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) between :ll_mstage and :ll_wsage) or
												( ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) between :ll_mstage and :ll_sage and EMPD_SCHOOLFLAG='YES')) ) or
									  (:ls_umgirl='Y' and EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
									  (:ls_umsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
									  (:ls_wsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) or
									  (:ls_wmother='Y' and EMPD_DEPENDENTTYPE='MOTHER' and EMPD_SEX='F' ) );
	
	
								  if sqlca.sqlcode = -1 then
									Messagebox('SQL ERROR: During Dependent Select (Male)',sqlca.sqlerrtext)
									return -1
								  End If
								  
							if isnull(ll_nodepminorphase2) then ll_nodepminorphase2 = 0
							if isnull(ll_nodepminor) then ll_nodepminor = 0
							if isnull(ll_nodepmajor1) then ll_nodepmajor1 = 0
							
							ll_nodepmajor = ll_nodepmajor + ll_nodepmajor1 + ll_nodepminor
					
								  
					elseIf (ls_emp_type = 'ST' or ls_emp_type = 'AT')  And ls_emp_sex = 'F' Then
						
							  select count(1) into :ll_cnt from fb_empspouse esp,fb_employee emp 
							  where esp.emps_id=emp.emp_id and emp.emp_type in ('ST','AT') and esp.emp_id=:ls_emp_id and esp.emps_active='1';
							  
						  if ll_cnt =0 then	//no male spouse as staff for this emp
							
							 select sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) - :ll_minorage),1,0,1),0)),
									 sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) - :ll_minorage),1,1,0),0)),
									  sum(decode(empd_maritalstatus,'W',1,'M',1,0))
								into :ll_nodepminorphase2,:ll_nodepminor,:ll_nodepmajor1
							  from fb_empdependents ld
							where EMP_ID =:ls_emp_id and empd_active='1' and 
									( (:ls_mchild='Y' and EMPD_DEPENDENTTYPE='CHILD' and  EMPD_MARITALSTATUS ='U' and 
										(  ( ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) between :ll_mstage and :ll_wsage) or
												( ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) between :ll_mstage and :ll_sage and EMPD_SCHOOLFLAG='YES')) ) or
									  (:ls_umgirl='Y' and EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
									  (:ls_umsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
									  (:ls_wsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) or
									  (:ls_wmother='Y' and EMPD_DEPENDENTTYPE='MOTHER' and EMPD_SEX='F'  ) );
	
								  if sqlca.sqlcode = -1 then
									Messagebox('SQL ERROR: During Dependent Select (Male)',sqlca.sqlerrtext)
									return -1
								  End If
								  
							if isnull(ll_nodepminorphase2) then ll_nodepminorphase2 = 0
							if isnull(ll_nodepminor) then ll_nodepminor = 0
							if isnull(ll_nodepmajor1) then ll_nodepmajor1 = 0
							
							ll_nodepmajor = ll_nodepmajor + ll_nodepmajor1 + ll_nodepminor
								  
						  end if
					elseIf (ls_emp_type = 'SS' ) And ls_emp_sex = 'M' Then
				  
						select count(1) into :ll_cnt from fb_empspouse esp,fb_employee emp 
						 where esp.emps_id=emp.emp_id and emp.emp_type in ('ST') and esp.emp_id=:ls_emp_id and esp.emps_active='1';
							  
						  if ll_cnt =0 then	//no spouse as Staff
							ll_cnt=0
							select count(1) into :ll_cnt  from fb_empspouse esp,fb_employee emp 
							 where esp.emps_id=emp.emp_id and emp.emp_type in ('LP','LT','SS') and esp.emp_id=:ls_emp_id and esp.emps_active='1' ;
							 
							  if ll_cnt =0 then	//spouse IS NOT WORKING
								ll_cnt=0
								 
								select count(1) into :ll_cnt from fb_empspouse where emp_id=:ls_emp_id and emps_active='1';
										 
								If ll_cnt >= 1 Then //SPOUSE IS ACTIVE
									ll_nodepmajor = ll_nodepmajor + 1
								End If
							 end if
	
							 select sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) - :ll_minorage),1,0,1),0)),
									 sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) - :ll_minorage),1,1,0),0)),
									  sum(decode(empd_maritalstatus,'W',1,0))
								 into :ll_nodepminorphase2,:ll_nodepminor,:ll_nodepmajor1
								from fb_empdependents ld
							 where EMP_ID =:ls_emp_id and empd_active='1' and 
									( (:ls_mchild='Y' and EMPD_DEPENDENTTYPE='CHILD' and  EMPD_MARITALSTATUS ='U' and 
										(  ( ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) between :ll_mstage and :ll_wsage) or
												( ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) between :ll_mstage and :ll_sage and EMPD_SCHOOLFLAG='YES')) ) or
									  (:ls_umgirl='Y' and EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
									  (:ls_umsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
									  (:ls_wsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) or
									  (:ls_wmother='Y' and EMPD_DEPENDENTTYPE='MOTHER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) );
							 
	//								( (EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='M' and EMPD_MARITALSTATUS ='U'  and ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) <= 18 ) or
	//								  (EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) );
		
								  if sqlca.sqlcode = -1 then
									Messagebox('SQL ERROR: During Dependent Select (Male)',sqlca.sqlerrtext)
									return -1
								  End If
								  
							if isnull(ll_nodepminorphase2) then ll_nodepminorphase2 = 0
							if isnull(ll_nodepminor) then ll_nodepminor = 0
							if isnull(ll_nodepmajor1) then ll_nodepmajor1 = 0
							
							ll_nodepmajor = ll_nodepmajor + ll_nodepmajor1 + ll_nodepminor
								  
						 End If
					elseIf (ls_emp_type = 'SS' )  And ls_emp_sex = 'F' Then
						
							  select count(1) into :ll_cnt from fb_empspouse esp,fb_employee emp 
							  where esp.emps_id=emp.emp_id and emp.emp_type in ('SS','ST') and esp.emp_id=:ls_emp_id and esp.emps_active='1';
							  
						  if ll_cnt =0 then	//no male spouse as staff for this emp
							
							 select sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) - :ll_minorage),1,0,1),0)),
									 sum(decode(empd_maritalstatus,'U',decode(sign(((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) - :ll_minorage),1,1,0),0)),
									 sum(decode(empd_maritalstatus,'W',1,0))
								 into :ll_nodepminorphase2,:ll_nodepminor,:ll_nodepmajor1
								from fb_empdependents ld
							where EMP_ID =:ls_emp_id and empd_active='1' and 
									( (:ls_mchild='Y' and EMPD_DEPENDENTTYPE='CHILD' and  EMPD_MARITALSTATUS ='U' and 
										(  ( ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) between :ll_mstage and :ll_wsage) or
												( ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) between :ll_mstage and :ll_sage and EMPD_SCHOOLFLAG='YES')) ) or
									  (:ls_umgirl='Y' and EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
									  (:ls_umsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) or
									  (:ls_wsister='Y' and EMPD_DEPENDENTTYPE='SISTER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) or
									  (:ls_wmother='Y' and EMPD_DEPENDENTTYPE='MOTHER' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='W' ) );
	
	//								( (EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='M' and EMPD_MARITALSTATUS ='U'  and ((to_date(:fs_ym,'yyyymm') - EMPD_DOB)/365) <= 18 ) or
	//								  (EMPD_DEPENDENTTYPE='CHILD' and EMPD_SEX='F' and EMPD_MARITALSTATUS ='U' ) );
	
								  if sqlca.sqlcode = -1 then
									Messagebox('SQL ERROR: During Dependent Select (Male)',sqlca.sqlerrtext)
									return -1
								  End If
							if isnull(ll_nodepminorphase2) then ll_nodepminorphase2 = 0
							if isnull(ll_nodepminor) then ll_nodepminor = 0
							if isnull(ll_nodepmajor1) then ll_nodepmajor1 = 0
							
							ll_nodepmajor = ll_nodepmajor + ll_nodepmajor1 + ll_nodepminor
								  
						  end if
					end if
	
				  if isnull(ll_nomajor) then ll_nomajor=0
				  if isnull(ll_nodepmajor) then ll_nodepmajor=0
				  if isnull(ll_nodepminor) then ll_nodepminor=0
				  if isnull(ll_nodepminorphase2) then ll_nodepminorphase2=0
				  
				    if isnull(ld_majriceprice) then ld_majriceprice=0
				    if isnull(ld_majattaprice) then ld_majattaprice=0
				    if isnull(ld_depmajriceprice) then ld_depmajriceprice=0
				    if isnull(ld_depmajattaprice) then ld_depmajattaprice=0					
					if isnull(ld_depminriceprice) then ld_depminriceprice=0
				    if isnull(ld_depminattaprice) then ld_depminattaprice=0					 
				    if isnull(ld_depmajriceprice) then ld_depmajriceprice=0
				    if isnull(ld_depmajattaprice) then ld_depmajattaprice=0
									 
				  ld_majriceprice = Round(ld_majricewt * ld_majricerate * ll_nomajor, 2)
						 ld_majattaprice = Round(ld_majattawt * ld_majattarate * ll_nomajor, 2)
						 ld_depmajriceprice = Round(ld_depmajricewt * ld_depmajricerate * ll_nodepmajor, 2)
						 ld_depmajattaprice = Round(ld_depmajattawt * ld_depmajattarate * ll_nodepmajor, 2)
//						 ld_depminriceprice = Round((ld_depminricewt * ld_depminricerate * ll_nodepminor) + (ld_depminricewt * ld_depminricerate * ll_nodepminorphase2), 2)
//						 ld_depminattaprice = Round((ld_depminattawt * ld_depminattarate * ll_nodepminor) + (ld_depminattawt * ld_depminattarate * ll_nodepminorphase2), 2)
//						 ld_attawt = (ld_majattawt * ll_nomajor) + (ld_depmajattawt * ll_nodepmajor) + (ld_depminattawt * ll_nodepminor) + (ld_depminattawt * ll_nodepminorphase2)
//						 ld_ricewt = (ld_majricewt * ll_nomajor) + (ld_depmajricewt * ll_nodepmajor) + (ld_depminricewt * ll_nodepminor) + (ld_depminricewt * ll_nodepminorphase2)
						 ld_depminriceprice = Round( (ld_depminricewt * ld_depminricerate * ll_nodepminorphase2), 2)
						 ld_depminattaprice = Round( (ld_depminattawt * ld_depminattarate * ll_nodepminorphase2), 2)						 
						 ld_attawt = (ld_majattawt * ll_nomajor) + (ld_depmajattawt * ll_nodepmajor) +  (ld_depminattawt * ll_nodepminorphase2)
						 ld_ricewt = (ld_majricewt * ll_nomajor) + (ld_depmajricewt * ll_nodepmajor) +  (ld_depminricewt * ll_nodepminorphase2)
						 ld_rationded = ld_majriceprice + ld_majattaprice + ld_depmajriceprice + ld_depmajattaprice + ld_depminriceprice + ld_depminattaprice
						 
					Else
						 ld_attawt = 0
						 ld_ricewt = 0
						 ld_rationded = 0
					End If
			//   end ration
		   elseif gs_garden_snm = 'MT' then
				SELECT sum(nvl(RICEWT,0)) RICEWT, sum(nvl(ATTAWT,0)) ATTAWT, sum(nvl(RATIONDED,0)) RATION
				into :ld_ricewt, :ld_attawt, :ld_rationded
				FROM FB_SUBSTAFFWEEKLYRATION b,fb_rationperiodforweek c
				WHERE emp_id = :ls_emp_id AND (b.LWW_ID=c.RPFW_ID) AND to_char(RPFW_ENDDATE,'YYYYMM') = :fs_ym;
				
		  		if sqlca.sqlcode = -1 then
					Messagebox('SQL ERROR: During Getting Ration Details',sqlca.sqlerrtext)
					return -1
				End If			
				
//				ld_brationwt = (35 - (ld_attawt + ld_ricewt))
//				ld_brationamt = (35 - (ld_attawt + ld_ricewt)) * 2
//				
//				ld_rationded = ld_rationded + ld_brationamt

				if isnull(ld_rationded) then ld_rationded = 0;
				if isnull(ld_ricewt) then ld_ricewt = 0;
				if isnull(ld_attawt) then ld_attawt = 0;
				
				if ld_rationded > 0 then
					ld_brationwt = (35 - (ld_attawt + ld_ricewt))
					ld_brationamt = (35 - (ld_attawt + ld_ricewt)) * 2
				else
					ld_brationwt = 0
					ld_brationamt = 0
				end if
				
				if isnull(ld_brationwt) then ld_brationwt = 0;
				if isnull(ld_brationamt) then ld_brationamt = 0;			
				
				if (ld_attawt + ld_ricewt) > 35 then
					ld_rationded = 35 * 0.40
				else
					ld_rationded = ld_rationded + ld_brationamt
				end if
	
//				update FB_SUBSTAFFWEEKLYRATION set BALRATION_WT = :ld_brationwt, BALRATION_TDED = :ld_brationamt
//				where (EMP_ID, LWW_ID) in (select EMP_ID, LWW_ID FROM FB_SUBSTAFFWEEKLYRATION b,fb_rationperiodforweek c
//														WHERE emp_id = :ls_emp_id AND (b.LWW_ID = c.RPFW_ID) AND to_char(RPFW_ENDDATE,'YYYYMM') = :fs_ym );
//
//				if sqlca.sqlcode = -1 then
//					Messagebox('SQL ERROR: During Updating Ration Details',sqlca.sqlerrtext)
//					return -1
//				End If			
//
		   end if		//elseif gs_garden_snm = 'MT' then
		   if isnull(ld_rationded) then ld_rationded=0
		   if isnull(ld_attawt) then ld_attawt=0
		   if isnull(ld_ricewt) then ld_ricewt=0
		   if isnull(ld_basic) then ld_basic=0
		   if isnull(ld_da) then ld_da=0
		   if isnull(ld_vda) then ld_vda=0
		   if isnull(ld_adhoc) then ld_adhoc=0
		   if isnull(ld_hr) then ld_hr=0
		   if isnull(ld_electric) then ld_electric=0
		   if isnull(ld_fuel) then ld_fuel=0
            if isnull(ld_cyclealw) then ld_cyclealw=0
		   if isnull(ld_otamt) then ld_otamt=0
		   if isnull(ld_LIGHTALOW) then ld_LIGHTALOW=0
		   if isnull(ld_SEASONALOW) then ld_SEASONALOW=0
		   if isnull(ld_CHARGEALOW) then ld_CHARGEALOW=0
		   if isnull(ld_COMPUTERALOW) then ld_COMPUTERALOW=0
//		   ld_pf_eb_amt = 0; ld_eb_amt = 0;	
			
			ld_ptgross = (ld_basic + ld_da + ld_vda + ld_adhoc + ld_hr + ld_electric + ld_fuel + ld_tcvfood + ld_otamt + ld_cyclealw + ld_LIGHTALOW + ld_SEASONALOW + ld_CHARGEALOW + ld_COMPUTERALOW + ld_eb_amt)
            
			//            start PTAX
			select epd_ptax into :ld_ptaxded  from fb_empptaxdeduction 
			where EPD_STATE_CODE = :gs_garden_state and 
					nvl(round(:ld_ptgross),0) between epd_startslab and epd_endslab and 
					to_date(:fs_ym,'yyyymm') between EPD_DT_FROM and nvl(EPD_DT_TO,trunc(sysdate));
		  
		  if sqlca.sqlcode = -1 then
			Messagebox('SQL ERROR: During PTAX (Select)',sqlca.sqlerrtext)
			return -1
		 elseIf sqlca.sqlcode = 100 Then
                ld_ptaxded  = 0
           End If
            //end PTAX
//--------------------				
			if gs_garden_snm = 'MR'  or gs_garden_snm = 'SP'   or gs_garden_snm = 'LP' or gs_garden_snm = 'AB' or gs_garden_snm = 'AD' or gs_garden_snm = 'MH' or gs_garden_snm = 'DR' then
		
				select CD_AMOUNT into :ld_copr_amt from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type =  'COOPRATIVE';
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting Coopretive Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_copr_amt = 0;
				end if
				
				select CD_AMOUNT into :ld_ELECT1_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'ELECT1' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting Electric1 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_ELECT1_IAMT = 0;
				end if

				select CD_AMOUNT into :ld_ELECT2_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'ELECT2' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting Electric2 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_ELECT2_IAMT = 0;
				end if
				
				select CD_AMOUNT into :ld_ELECT3_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'ELECT3' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting Electric3 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_ELECT3_IAMT = 0;
				end if
				
				select CD_AMOUNT into :ld_ELECT4_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'ELECT4' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting Electric4 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_ELECT4_IAMT = 0;
				end if

				select CD_AMOUNT into :ld_ACMS01_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'ACMS01' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting ACMS Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_ACMS01_IAMT = 0;
				end if
				
				select CD_AMOUNT into :ld_BPUJA1_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'BPUJA1' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting BPUJA1 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_BPUJA1_IAMT = 0;
				end if
				
				select CD_AMOUNT into :ld_BPUJA2_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'BPUJA2' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting BPUJA2 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_BPUJA2_IAMT = 0;
				end if
				
				select CD_AMOUNT into :ld_ACKS_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'ACKS' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting BMASAN Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_ACKS_IAMT = 0;
				end if
				
				select CD_AMOUNT into :ld_CLUB_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'CLUB' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting CBME Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_CLUB_IAMT = 0;
				end if
				
				select CD_AMOUNT into :ld_ITAX_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'ITAX' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting CHURCH Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_ITAX_IAMT = 0;
				end if
				
				select CD_AMOUNT into :ld_ICICI_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'ICICI' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting ICICI Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_ICICI_IAMT = 0;
				end if

				select CD_AMOUNT into :ld_PUJA1_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'PUJA1' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting PUJA1 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_PUJA1_IAMT = 0;
				end if

				select CD_AMOUNT into :ld_PUJA2_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'PUJA2' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting PUJA2 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_PUJA2_IAMT = 0;
				end if

				select CD_AMOUNT into :ld_PUJA3_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'PUJA3' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting PUJA3 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_PUJA3_IAMT = 0;
				end if

				select CD_AMOUNT into :ld_PUJA4_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'PUJA4' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting PUJA4 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_PUJA4_IAMT = 0;
				end if

				select CD_AMOUNT into :ld_PUJA5_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'PUJA5' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting PUJA5 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_PUJA5_IAMT = 0;
				end if

				select CD_AMOUNT into :ld_GROUPINSU_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'GROUPINSU' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting MEDICAL Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_GROUPINSU_IAMT = 0;
				end if

				select CD_AMOUNT into :ld_CANTEEN_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'CANTEEN' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting MEDICAL Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_CANTEEN_IAMT = 0;
				end if

				select CD_AMOUNT into :ld_LPG_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'LPG' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting MEDICAL Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_LPG_IAMT = 0;
				end if

				select CD_AMOUNT into :ld_MEDICAL_IAMT from fb_empdeduction where CD_EMP_ID = :ls_emp_id and CD_YEARMN = :fs_ym and cd_ded_type = 'MEDICAL' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting MEDICAL Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_MEDICAL_IAMT = 0;
				end if

				  
			end if				
//----------------		  
		  if isnull(ld_ptgross) then ld_ptgross = 0	
		  if isnull(ld_ptaxded) then ld_ptaxded = 0	
		  if isnull(ld_hr) then ld_hr=0
		  if isnull(ld_electric) then ld_electric=0
		  if isnull(ld_fuel) then ld_fuel=0
		  if isnull(ld_pensionded) then ld_pensionded=0
		  if isnull(ld_pfcontded) then ld_pfcontded=0
		  if isnull(ld_lipded) then ld_lipded=0
		  if isnull(ld_ptaxded) then ld_ptaxded=0
		  if isnull(ld_lwfded) then ld_lwfded=0
		  if isnull(ld_rationded) then ld_rationded=0
		  if isnull(ld_advanceded) then ld_advanceded=0
		  if isnull(ld_pfadvanceded) then ld_pfadvanceded=0
		  if isnull(ld_ead_revstampaboveded) then ld_ead_revstampaboveded=0
		  if isnull(ld_cyclealw) then ld_cyclealw=0
		  if isnull(ld_nrd) then ld_nrd=0
		  if isnull(ld_nKoilAmo) then ld_nKoilAmo=0
		  if isnull(ld_lipded) then ld_lipded=0
		if isnull(ld_ELECT1_IAMT) then ld_ELECT1_IAMT=0 
		if isnull(ld_ELECT2_IAMT) then ld_ELECT2_IAMT=0  
		if isnull(ld_ELECT3_IAMT) then ld_ELECT3_IAMT=0 
		if isnull(ld_ELECT4_IAMT) then ld_ELECT4_IAMT=0 
		if isnull(ld_ACMS01_IAMT) then ld_ACMS01_IAMT=0 
		if isnull(ld_BPUJA1_IAMT) then ld_BPUJA1_IAMT=0 
		if isnull(ld_BPUJA2_IAMT) then ld_BPUJA2_IAMT=0 
		if isnull(ld_ACKS_IAMT) then ld_ACKS_IAMT=0 
		if isnull(ld_CLUB_IAMT) then ld_CLUB_IAMT=0 
		if isnull(ld_ITAX_IAMT) then ld_ITAX_IAMT=0 
		if isnull(ld_ICICI_IAMT) then ld_ICICI_IAMT=0 
		if isnull(ld_PUJA1_IAMT) then ld_PUJA1_IAMT=0 
		if isnull(ld_PUJA2_IAMT) then ld_PUJA2_IAMT=0 
		if isnull(ld_PUJA3_IAMT) then ld_PUJA3_IAMT=0 
		if isnull(ld_PUJA4_IAMT) then ld_PUJA4_IAMT=0 
		if isnull(ld_PUJA5_IAMT) then ld_PUJA5_IAMT=0 
		if isnull(ld_MEDICAL_IAMT) then ld_MEDICAL_IAMT=0 
		if isnull(ld_copr_amt) then ld_copr_amt=0 
		if isnull(ld_GROUPINSU_IAMT) then ld_GROUPINSU_IAMT = 0
		if isnull(ld_CANTEEN_IAMT) then ld_CANTEEN_IAMT = 0
		if isnull(ld_LPG_IAMT) then ld_LPG_IAMT = 0
		if isnull(ld_vol_pfamt) then ld_vol_pfamt = 0
		if isnull(ld_electadvded) then ld_electadvded=0
		if isnull(ld_medadvded) then ld_medadvded=0
		if isnull(ld_festadvded) then ld_festadvded=0
		if isnull(ld_pfintadvded) then ld_pfintadvded=0
		  
		  if ls_koil_ind = 'N' then
			ld_nKoilAmo = 0
		 end if
		if isnull(ld_vol_pfper) then ld_vol_pfper = 0;
		
		  if gs_garden_snm = 'FB' or gs_garden_snm = 'MT' or gs_garden_snm = 'MK'  then
			     ld_totearn = ld_basic + ld_da + ld_vda + ld_adhoc + ld_cyclealw + ld_tcvfood + ld_eb_amt
				ld_totded = (ld_pensionded + ld_pfcontded + ld_lipded + ld_ptaxded + ld_lwfded + ld_rationded + ld_advanceded + ld_pfadvanceded + ld_nKoilAmo + ld_nrd + ld_elededamt + ld_electadvded + ld_medadvded + ld_festadvded+ld_pfintadvded)
		  elseif gs_garden_snm= 'MR'  or gs_garden_snm= 'SP'   or gs_garden_snm= 'LP' or gs_garden_snm= 'AB'  or gs_garden_snm = 'MH' or gs_garden_snm = 'DR' then
			     ld_totearn =  ld_basic + ld_da + ld_vda + ld_adhoc + ld_hr + ld_electric + ld_fuel	+ ld_cyclealw + ld_tcvfood + ld_otamt + ld_LIGHTALOW + ld_SEASONALOW + ld_CHARGEALOW + ld_COMPUTERALOW + ld_eb_amt
				ld_totded  = (ld_pensionded + ld_pfcontded + ld_lipded + ld_ptaxded + ld_lwfded + ld_rationded + ld_advanceded + ld_pfadvanceded + ld_nKoilAmo + ld_nrd + ld_elededamt + ld_ELECT1_IAMT + ld_ELECT2_IAMT + ld_ELECT3_IAMT + ld_ELECT4_IAMT + ld_ACMS01_IAMT + ld_BPUJA1_IAMT + ld_BPUJA2_IAMT + ld_ACKS_IAMT + ld_CLUB_IAMT + ld_ITAX_IAMT + ld_ICICI_IAMT + ld_PUJA1_IAMT + ld_PUJA2_IAMT + ld_PUJA3_IAMT + ld_PUJA4_IAMT + ld_PUJA5_IAMT + ld_MEDICAL_IAMT + ld_copr_amt + ld_GROUPINSU_IAMT + ld_CANTEEN_IAMT + ld_LPG_IAMT  + ld_electadvded + ld_medadvded + ld_festadvded + ld_pfintadvded)			
		  elseif  gs_garden_snm = 'AD' then
			     ld_totearn =  ld_basic + ld_da + ld_vda + ld_adhoc + ld_hr + ld_electric + ld_fuel	+ ld_cyclealw + ld_tcvfood + ld_otamt + ld_LIGHTALOW + ld_SEASONALOW + ld_CHARGEALOW + ld_COMPUTERALOW + ld_eb_amt
				ld_vol_pfamt = round(ld_totearn * ld_vol_pfper / 100,2)
				ld_totded  = (ld_pensionded + ld_pfcontded + ld_lipded + ld_ptaxded + ld_lwfded + ld_rationded + ld_advanceded + ld_pfadvanceded + ld_nKoilAmo + ld_nrd + ld_elededamt + ld_ELECT1_IAMT + ld_ELECT2_IAMT + ld_ELECT3_IAMT + ld_ELECT4_IAMT + ld_ACMS01_IAMT + ld_BPUJA1_IAMT + ld_BPUJA2_IAMT + ld_ACKS_IAMT + ld_CLUB_IAMT + ld_ITAX_IAMT + ld_ICICI_IAMT + ld_PUJA1_IAMT + ld_PUJA2_IAMT + ld_PUJA3_IAMT + ld_PUJA4_IAMT + ld_PUJA5_IAMT + ld_MEDICAL_IAMT + ld_copr_amt + ld_GROUPINSU_IAMT + ld_CANTEEN_IAMT + ld_LPG_IAMT + ld_vol_pfamt + ld_electadvded + ld_medadvded + ld_festadvded + ld_pfintadvded)			
		  else	
			     ld_totearn =  ld_basic + ld_da + ld_vda + ld_adhoc + ld_hr + ld_electric + ld_fuel	+ ld_cyclealw + ld_eb_amt
				ld_totded  = (ld_pensionded + ld_pfcontded + ld_lipded + ld_ptaxded + ld_lwfded + ld_rationded + ld_advanceded + ld_pfadvanceded + ld_nKoilAmo + ld_nrd + ld_elededamt  + ld_electadvded + ld_medadvded + ld_festadvded + ld_pfintadvded)
		  end if
			
			if gs_garden_snm =  'MT'  then
				if isnull(ld_totearn) then ld_totearn=0
				if isnull(ld_totded) then ld_totded=0				
				select ep_coinbf into :ld_coinbf from fb_emppayment 
				where emp_id=:ls_emp_id and ((ep_year * 100)+ep_month)=to_char(add_months(to_date(:fs_ym,'yyyymm'),-1),'yyyymm');
				
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Labour Coin BF Select : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 
				elseif sqlca.sqlcode =100 then
					 ld_coinbf=0;
				end if;
			     if isnull(ld_coinbf) then ld_coinbf=0
				ld_coincf =  mod( (ld_totearn - ld_totded + ld_coinbf),ld_rnd_off)
				
				If  ((ld_totearn - ld_totded + ld_coinbf) - ld_coincf) >= ld_ead_revstampaboveded Then //TO BE CHANGED
					 ll_revstampded = 1
				Else
					 ll_revstampded = 0
				End If
				ld_totded = ld_totded + ll_revstampded 
				ld_coincf =  mod( (ld_totearn - ld_totded + ld_coinbf),ld_rnd_off)
				
					if (ld_totearn - ld_totded +ld_coinbf) <= 0 then		// LESS RD
						ld_totded = ld_totded - ld_nrd;ld_nrd=0
						if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS LIP
							ld_totded = ld_totded - ld_lipded;ld_lipded=0
							if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS KOIL
								ld_totded = ld_totded - ld_nKoilAmo;ld_nKoilAmo=0
								if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS LWF
									ld_totded = ld_totded - ld_lwfded; ld_lwfded=0
									if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS ELECTRICITY
										ld_totded = ld_totded - (ld_elededamt); ld_elededamt =0
										if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS Advance
											ld_totded = ld_totded - (ld_advanceded); ld_advanceded =0
											if (ld_totearn - ld_totded +ld_coinbf) <= 0 then
												ld_totded = ld_totded - ld_rationded; ld_rationded=0
											end if
										end if
									end if
								end if
							end if
						end if
					end if
				if (ld_totearn - ld_totded) = 0 then 
					ld_netpayable = 0;
				else
					ld_netpayable = (ld_totearn - ld_totded + ld_coinbf) - ld_coincf
				end if
			elseif gs_garden_snm= 'MR'  or gs_garden_snm= 'SP'   or gs_garden_snm= 'LP' or gs_garden_snm= 'AB'  or gs_garden_snm = 'AD' or gs_garden_snm = 'MH' or gs_garden_snm = 'DR' then
				if isnull(ld_totearn) then ld_totearn=0
				if isnull(ld_totded) then ld_totded=0				
				select ep_coinbf into :ld_coinbf from fb_emppayment 
				where emp_id=:ls_emp_id and ((ep_year * 100)+ep_month)=to_char(add_months(to_date(:fs_ym,'yyyymm'),-1),'yyyymm');
				
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Labour Coin BF Select : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 
				elseif sqlca.sqlcode =100 then
					 ld_coinbf=0;
				end if;
			     if isnull(ld_coinbf) then ld_coinbf=0
				ld_coincf =  mod( (ld_totearn - ld_totded + ld_coinbf),ld_rnd_off)
				
				If  ((ld_totearn - ld_totded + ld_coinbf) - ld_coincf) >= ld_ead_revstampaboveded Then //TO BE CHANGED
					 ll_revstampded = 1
				Else
					 ll_revstampded = 0
				End If
				ld_totded = ld_totded + ll_revstampded 
				ld_coincf =  mod( (ld_totearn - ld_totded + ld_coinbf),ld_rnd_off)
				
//					if (ld_totearn - ld_totded +ld_coinbf) <= 0 then		// LESS RD
//						ld_totded = ld_totded - ld_nrd;ld_nrd=0
//						if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS LIP
//							ld_totded = ld_totded - ld_lipded;ld_lipded=0
//							if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS KOIL
//								ld_totded = ld_totded - ld_nKoilAmo;ld_nKoilAmo=0
//								if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS LWF
//									ld_totded = ld_totded - ld_lwfded; ld_lwfded=0
//									if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS ELECTRICITY
//										ld_totded = ld_totded - (ld_elededamt); ld_elededamt =0
//										if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS Advance
//											ld_totded = ld_totded - (ld_advanceded); ld_advanceded =0
//											if (ld_totearn - ld_totded +ld_coinbf) <= 0 then
//												ld_totded = ld_totded - ld_rationded; ld_rationded=0
//											end if
//										end if
//									end if
//								end if
//							end if
//						end if
//					end if
					if (ld_totearn - ld_totded +ld_coinbf) <= 0 then		// LESS ld_ELECT1_IAMT
						ld_totded = ld_totded - ld_ELECT1_IAMT;ld_ELECT1_IAMT=0
						if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS ld_ELECT2_IAMT
							ld_totded = ld_totded - ld_ELECT2_IAMT;ld_ELECT2_IAMT=0
							if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS ld_ELECT3_IAMT
								ld_totded = ld_totded - ld_ELECT3_IAMT;ld_ELECT3_IAMT=0
								if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS ld_ELECT4_IAMT
									ld_totded = ld_totded - ld_ELECT4_IAMT; ld_ELECT4_IAMT=0
									if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS ld_ACMS01_IAMT
										ld_totded = ld_totded - ld_ACMS01_IAMT; ld_ACMS01_IAMT =0
										if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS ld_BPUJA1_IAMT
											ld_totded = ld_totded - ld_BPUJA1_IAMT; ld_BPUJA1_IAMT=0
											   if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_BPUJA2_IAMT
											  	 ld_totded = ld_totded - ld_BPUJA2_IAMT; ld_BPUJA2_IAMT=0
												 if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_BMASAN_IAMT
											  	    ld_totded = ld_totded - ld_ACKS_IAMT; ld_ACKS_IAMT=0
													if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_CBME_IAMT
													   ld_totded = ld_totded - ld_CLUB_IAMT; ld_CLUB_IAMT=0
														if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_CHURCH_IAMT
													       ld_totded = ld_totded - ld_ITAX_IAMT; ld_ITAX_IAMT=0
														   if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_ICICI_IAMT
													          ld_totded = ld_totded - ld_ICICI_IAMT; ld_ICICI_IAMT=0
															 if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_PUJA1_IAMT
													              ld_totded = ld_totded - (ld_PUJA1_IAMT + ld_PUJA2_IAMT + ld_PUJA3_IAMT + ld_PUJA4_IAMT+ ld_PUJA5_IAMT); ld_PUJA1_IAMT=0; ld_PUJA2_IAMT=0;ld_PUJA3_IAMT=0;ld_PUJA4_IAMT=0;ld_PUJA5_IAMT=0;
															      if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_MEDICAL_IAMT
													                  ld_totded = ld_totded - ld_MEDICAL_IAMT; ld_MEDICAL_IAMT=0
																	if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_copr_amt
													                     ld_totded = ld_totded - ld_copr_amt; ld_copr_amt=0
																	   if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_GROUPINSU_IAMT 
													                        ld_totded = ld_totded - ld_GROUPINSU_IAMT; ld_GROUPINSU_IAMT=0
																		 if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_CANTEEN_IAMT 
																			ld_totded = ld_totded - ld_CANTEEN_IAMT; ld_CANTEEN_IAMT=0
																			if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS   ld_LPG_IAMT ld_pfadvanceded
																			   ld_totded = ld_totded - ld_LPG_IAMT; ld_LPG_IAMT=0
																				if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS    ld_pfadvanceded
																					ld_totded = ld_totded - ld_pfadvanceded; ld_pfadvanceded=0
																					if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS   elecadvance, medical advance, festival advance
																						ld_totded = ld_totded - ld_electadvded; ld_electadvded=0
																						if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS  medical advance, festival advance
																							ld_totded = ld_totded - ld_medadvded; ld_medadvded=0
																							if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS   festival advance
																								ld_totded = ld_totded - ld_festadvded; ld_festadvded=0
																								if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS   PFInt advance
																									ld_totded = ld_totded - ld_pfintadvded; ld_pfintadvded=0
																				 				end if
																				 			end if
																				 		end if
																				 	end if
																				 end if
																		     end if
																		 end if
																	   end if
													                  end if
													               end if
													           end if
													        end if
													     end if
													end if
											      end if
											   end if
										end if
									end if
								end if
							end if
						end if
					end if
				if (ld_totearn - ld_totded) = 0 then 
					ld_netpayable = 0;
				else
					ld_netpayable = (ld_totearn - ld_totded + ld_coinbf) - ld_coincf
				end if				
			else
				ld_coincf =0;ld_coinbf=0;
				if isnull(ld_totearn) then ld_totearn=0
				if isnull(ld_totded) then ld_totded=0
				If  (ld_totearn - ld_totded) >= ld_ead_revstampaboveded Then //TO BE CHANGED
					 ll_revstampded = 1
				Else
					 ll_revstampded = 0
				End If
				ld_totded = ld_totded + ll_revstampded 
				ld_netpayable = (ld_totearn - ld_totded)
				if gs_garden_state = '03' or gs_garden_snm = 'DL' then
					ld_netpayable  = round(ld_netpayable ,0)
				end if
			end if
			
		   if isnull(ld_netpayable) then ld_netpayable = 0
		   
		   if gs_garden_snm <>  'MR' and  gs_garden_snm <> 'LP' and gs_garden_snm <> 'SP' and gs_garden_snm <> 'AB'  and  gs_garden_snm <> 'AD' and gs_garden_snm <> 'MH' and gs_garden_snm <> 'DR' then
			insert into fb_emppayment (emp_id,ep_year,ep_month,ep_basicamount,ep_daamount,ep_vdaamount,ep_cvrforpfamount,ep_hramount,ep_electricamount,ep_fuelamount,
						  ep_pensionfunddedamount,ep_pfcontdedamount,ep_lipdedamount,ep_ptaxdedamount,ep_revenuestampdedamount,ep_lwfdedamount,ep_electricdedamount,
						  ep_advancededamount,EP_pfADVANCEDEDAMOUNT ,ep_rationdedamount,ep_coinbf,ep_lastcoinbf,ep_netpayable,ep_ricewt,ep_attawt,ep_statustype,ep_statusdays,
						  ep_adhoc,EP_KOIL,EP_RD,ep_allowwopf,EP_ALLOWWPF, EP_EB_AMT,EP_ELECTADVANCEDED, EP_MEDICALADVANCEDED, EP_FESTIVALADVANCEDED,EP_PFINTADVANCEDED)
			 values (:ls_emp_id ,to_char(to_date(:fs_ym,'yyyymm'),'yyyy'),to_char(to_date(:fs_ym,'yyyymm'),'mm'),:ld_basic ,:ld_da ,:ld_vda ,:ld_cvrforpf , :ld_hr , :ld_electric ,
						:ld_fuel,:ld_pensionded ,:ld_pfcontded ,:ld_lipded ,:ld_ptaxded ,:ll_revstampded ,:ld_lwfded ,decode(:gs_garden_snm, 'FB',0,:ld_elededamt) ,:ld_advanceded ,:ld_pfadvanceded,:ld_rationded ,:ld_coincf ,
						:ld_coinbf ,:ld_netpayable ,:ld_ricewt ,:ld_attawt , :ls_emp_statustype,Trim(:ls_emp_statusdays) ,:ld_adhoc,:ld_nKoilAmo,:ld_nrd,:ld_cyclealw, :ld_tcvfood,:ld_eb_amt, nvl(:ld_electadvded,0), nvl(:ld_medadvded,0), nvl(:ld_festadvded,0), nvl(:ld_pfintadvded,0));
	
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error : During Insert in EMP Payment ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			end if
		elseif  gs_garden_snm = 'AD' then
			insert into fb_emppayment (emp_id,ep_year,ep_month,ep_basicamount,ep_daamount,ep_vdaamount,ep_cvrforpfamount,ep_hramount,ep_electricamount,ep_fuelamount,
						  ep_pensionfunddedamount,ep_pfcontdedamount,ep_lipdedamount,ep_ptaxdedamount,ep_revenuestampdedamount,ep_lwfdedamount,ep_electricdedamount,
						  ep_advancededamount,EP_pfADVANCEDEDAMOUNT ,ep_rationdedamount,ep_coinbf,ep_lastcoinbf,ep_netpayable,ep_ricewt,ep_attawt,ep_statustype,ep_statusdays,
						  ep_adhoc,EP_KOIL,EP_RD,ep_allowwopf,EP_ALLOWWPF,LIGHTALOW, SEASONALOW, CHARGEALOW, COMPUTERALOW, ELECTRICDED2, ELECTRICDED3, ELECTRICDED4, ACMS01, 
						  BPUJA1, BPUJA2, ACKS, CLUB, ITAX, COOPERATIVE, ICICI, PUJA1, PUJA2, PUJA3, PUJA4, PUJA5, MEDICAL, GROUPINSU, CANTEEN, LPG,OT_AMOUNT,EP_vol_pfamt, EP_EB_AMT,
						  EP_ELECTADVANCEDED, EP_MEDICALADVANCEDED, EP_FESTIVALADVANCEDED,EP_PFINTADVANCEDED)
			 values (:ls_emp_id ,to_char(to_date(:fs_ym,'yyyymm'),'yyyy'),to_char(to_date(:fs_ym,'yyyymm'),'mm'),:ld_basic ,:ld_da ,:ld_vda ,:ld_cvrforpf , :ld_hr , :ld_electric ,
						:ld_fuel,:ld_pensionded ,:ld_pfcontded ,:ld_lipded ,:ld_ptaxded ,:ll_revstampded ,:ld_lwfded ,decode(:gs_garden_snm, 'FB',0,(nvl(:ld_electric,0) + nvl(:ld_ELECT1_IAMT,0))) ,:ld_advanceded ,:ld_pfadvanceded,:ld_rationded ,:ld_coincf ,
						:ld_coinbf ,:ld_netpayable ,:ld_ricewt ,:ld_attawt , :ls_emp_statustype,Trim(:ls_emp_statusdays) ,:ld_adhoc,:ld_nKoilAmo,:ld_nrd,:ld_cyclealw, :ld_tcvfood,
						:ld_LIGHTALOW, :ld_SEASONALOW, :ld_CHARGEALOW, :ld_COMPUTERALOW,nvl(:ld_ELECT2_IAMT,0) ,nvl(:ld_ELECT3_IAMT,0),nvl(:ld_ELECT4_IAMT,0),nvl(:ld_ACMS01_IAMT,0),
						nvl(:ld_BPUJA1_IAMT,0),nvl(:ld_BPUJA2_IAMT,0),	nvl(:ld_ACKS_IAMT,0), nvl(:ld_CLUB_IAMT,0), nvl(:ld_ITAX_IAMT,0), nvl(:ld_copr_amt,0), nvl(:ld_ICICI_IAMT,0), nvl(:ld_PUJA1_IAMT,0), nvl(:ld_PUJA2_IAMT,0), nvl(:ld_PUJA3_IAMT,0), nvl(:ld_PUJA4_IAMT,0),
						nvl(:ld_PUJA5_IAMT,0), nvl(:ld_MEDICAL_IAMT,0),  nvl(:ld_GROUPINSU_IAMT,0), nvl(:ld_CANTEEN_IAMT,0), nvl(:ld_LPG_IAMT,0),nvl(:ld_otamt,0),:ld_vol_pfamt, :ld_eb_amt, nvl(:ld_electadvded,0), nvl(:ld_medadvded,0), nvl(:ld_festadvded,0), nvl(:ld_pfintadvded,0));	
						
				if sqlca.sqlcode = -1 then 
					messagebox('Sql Error : During Insert in EMP Payment ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 
				end if	
		else
			insert into fb_emppayment (emp_id,ep_year,ep_month,ep_basicamount,ep_daamount,ep_vdaamount,ep_cvrforpfamount,ep_hramount,ep_electricamount,ep_fuelamount,
						  ep_pensionfunddedamount,ep_pfcontdedamount,ep_lipdedamount,ep_ptaxdedamount,ep_revenuestampdedamount,ep_lwfdedamount,ep_electricdedamount,
						  ep_advancededamount,EP_pfADVANCEDEDAMOUNT ,ep_rationdedamount,ep_coinbf,ep_lastcoinbf,ep_netpayable,ep_ricewt,ep_attawt,ep_statustype,ep_statusdays,
						  ep_adhoc,EP_KOIL,EP_RD,ep_allowwopf,EP_ALLOWWPF,LIGHTALOW, SEASONALOW, CHARGEALOW, COMPUTERALOW, ELECTRICDED2, ELECTRICDED3, ELECTRICDED4, ACMS01, 
						  BPUJA1, BPUJA2, ACKS, CLUB, ITAX, COOPERATIVE, ICICI, PUJA1, PUJA2, PUJA3, PUJA4, PUJA5, MEDICAL, GROUPINSU, CANTEEN, LPG,OT_AMOUNT, EP_EB_AMT,
						  EP_ELECTADVANCEDED, EP_MEDICALADVANCEDED, EP_FESTIVALADVANCEDED,EP_PFINTADVANCEDED)
			 values (:ls_emp_id ,to_char(to_date(:fs_ym,'yyyymm'),'yyyy'),to_char(to_date(:fs_ym,'yyyymm'),'mm'),:ld_basic ,:ld_da ,:ld_vda ,:ld_cvrforpf , :ld_hr , :ld_electric ,
						:ld_fuel,:ld_pensionded ,:ld_pfcontded ,:ld_lipded ,:ld_ptaxded ,:ll_revstampded ,:ld_lwfded ,decode(:gs_garden_snm, 'FB',0,(nvl(:ld_electric,0) + nvl(:ld_ELECT1_IAMT,0))) ,:ld_advanceded ,:ld_pfadvanceded,:ld_rationded ,:ld_coincf ,
						:ld_coinbf ,:ld_netpayable ,:ld_ricewt ,:ld_attawt , :ls_emp_statustype,Trim(:ls_emp_statusdays) ,:ld_adhoc,:ld_nKoilAmo,:ld_nrd,:ld_cyclealw, :ld_tcvfood,
						:ld_LIGHTALOW, :ld_SEASONALOW, :ld_CHARGEALOW, :ld_COMPUTERALOW,nvl(:ld_ELECT2_IAMT,0) ,nvl(:ld_ELECT3_IAMT,0),nvl(:ld_ELECT4_IAMT,0),nvl(:ld_ACMS01_IAMT,0),
						nvl(:ld_BPUJA1_IAMT,0),nvl(:ld_BPUJA2_IAMT,0),	nvl(:ld_ACKS_IAMT,0), nvl(:ld_CLUB_IAMT,0), nvl(:ld_ITAX_IAMT,0), nvl(:ld_copr_amt,0), nvl(:ld_ICICI_IAMT,0), nvl(:ld_PUJA1_IAMT,0), nvl(:ld_PUJA2_IAMT,0), nvl(:ld_PUJA3_IAMT,0), nvl(:ld_PUJA4_IAMT,0),
						nvl(:ld_PUJA5_IAMT,0), nvl(:ld_MEDICAL_IAMT,0),  nvl(:ld_GROUPINSU_IAMT,0), nvl(:ld_CANTEEN_IAMT,0), nvl(:ld_LPG_IAMT,0),nvl(:ld_otamt,0),:ld_eb_amt, nvl(:ld_electadvded,0), nvl(:ld_medadvded,0), nvl(:ld_festadvded,0), nvl(:ld_pfintadvded,0));
	
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error : During Insert in EMP Payment ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			end if
		end if		
		

		
		
		setnull(ls_emp_id);setnull(ls_emp_pfdedcode);setnull(ls_emp_sex);setnull(ls_emp_type);setnull(ls_emp_house);setnull(ls_emp_elect);setnull(ls_emp_pfno); setnull(ls_ebpf_ind);
		ld_adhoc=0;ld_egd_id=0;ld_basic=0;ld_ead_da=0;ld_ead_vda=0;ld_ead_cvrforpf=0;ld_ead_hr=0;ld_ead_electric=0;ld_ead_fuel=0;
		ld_ead_pensionfundded=0;ld_ead_pfcontded=0;ld_ead_ptaxded=0;ld_ead_revstampaboveded=0;ld_ead_lwfded =0;ld_nrd=0;ld_cyclealw=0
		ld_nodays=0;ld_ndays=0;ld_basicded=0;ld_cvrded=0;ld_da=0;ld_vda=0;ld_cvrforpf=0;ld_hr=0;ld_electric=0;ld_fuel=0;ld_pfadvanceded=0
		ld_pensionded =0;ld_pfcontded=0;ld_lwfded=0;ld_advanceded =0;ld_lipded =0;ld_ptgross=0;ld_ptaxded=0;ld_totearn=0;ld_totded=0; ld_netpayable=0;
		ll_nomajor = 0;ll_nodepmajor = 0;ll_nodepmajor = 0;ll_nodepminorphase2 = 0; ld_attawt = 0; ld_ricewt = 0;ld_rationded = 0 ;ll_nodepmajor1 = 0; ld_cvfood = 0;
		ld_majriceprice = 0;ld_majattaprice = 0;ld_depmajriceprice = 0;ld_depmajattaprice = 0;ld_depminriceprice = 0;ld_depminattaprice = 0;ld_elededamt = 0; setnull(ls_koil_ind);
		ld_LIGHTALOW = 0; ld_SEASONALOW = 0; ld_CHARGEALOW = 0; ld_COMPUTERALOW = 0; ld_vol_pfper = 0; ld_eb_amt = 0; ld_electadvded = 0; ld_medadvded = 0; ld_festadvded = 0;ld_pfintadvded=0;

	fetch c1 into :ls_emp_id,:ld_adhoc,:ld_egd_id,:ls_emp_pfno,:ls_emp_pfdedcode,:ls_emp_sex,:ls_emp_type ,:ls_emp_house,:ls_emp_elect,
				     :ld_basic,:ld_ead_da,:ld_ead_vda,:ld_ead_cvrforpf,:ld_ead_hr,:ld_ead_electric,:ld_ead_fuel,:ld_ead_pensionfundded,
					:ld_ead_pfcontded,:ld_ead_ptaxded,:ld_ead_revstampaboveded,:ld_ead_lwfded,:ld_nrd,:ld_cyclealw,:ld_elededamt, :ls_koil_ind,
					:ld_cvfood,:ld_LIGHTALOW, :ld_SEASONALOW, :ld_CHARGEALOW, :ld_COMPUTERALOW, :ld_vol_pfper, :ls_ebpf_ind, :ld_eb_amt ;
					
        Loop
close c1;

select distinct 'x' into :ls_temp from fb_emppaymentstatus where eps_month=to_char(to_date(:fs_ym,'yyyymm'),'mm') and eps_year=to_char(to_date(:fs_ym,'yyyymm'),'yyyy');

  If sqlca.sqlcode = 0 Then
      update fb_emppaymentstatus set eps_paycalflag='1',eps_caldate=sysdate ,eps_lwfflag= decode(:fs_chklwf,'Y',1,0)
	  where eps_month=to_char(to_date(:fs_ym,'yyyymm'),'mm') and eps_year=to_char(to_date(:fs_ym,'yyyymm'),'yyyy');
  Else
      insert into fb_emppaymentstatus(eps_month,eps_year,eps_advanceconfirm,eps_paycalflag,eps_paidflag,eps_lwfflag,eps_caldate)
	  values(to_char(to_date(:fs_ym,'yyyymm'),'mm'),to_char(to_date(:fs_ym,'yyyymm'),'yyyy'),'0','1','0',decode(:fs_chklwf,'Y',1,0),sysdate);
  End If

commit using sqlca;

MessageBox("Confirmation","Employee Payment calculated,Sucessfully")

return 1
end function

public function integer wf_wagecal_2w (string fs_st_dt, double fd_lwf, double fd_subs);string fs_lww_id,ls_temp,ls_labour_id,ls_emp_status,ls_emp_sex,ls_emp_type,ls_emp_marital,ls_electricflag,ls_pfno,ls_pfdedcode,ls_FIELD_ID,LS_LWFFLAG,LS_SUBSFLAG,ls_fortnightration, ls_lpg_issue_dt
long ll_edg_id,ll_payid,ll_adoleage,ll_weekstatus,ll_nodays
double ld_mdays,ld_sickdays,ld_sickwagesdays,ld_hajiradays,ld_withpaydays,ld_workdaysration,ld_mwages,ld_sickwages,ld_holidaypay,ld_hajiraearn,ld_otherearn,ld_elpearn,ld_totearn,ld_dedgroup,ld_fdconc
double ld_pf,ld_fpf,ld_coinbf,ld_coincf,ld_netpayable
double ld_rnd_off,ld_tpf_rt,ld_pf_rt,ld_fpf_rt,ld_revst_range,ld_revst,ld_fdconc_rt,ld_penalty,ld_weekly_advance,ld_Ptax
double ld_nlip,ld_nele,ld_nele_unit,ld_nlwf,ld_nrd,ld_nKoilAmo,ld_nadvance
double ld_First_days,ld_ration,ld_totded,ld_lwf,ld_subs,ld_electric,ld_advance,ld_pfadvded,ld_pfintded, ld_electadvded, ld_medadvded, ld_festadvded, ld_lpg_subsidy_ded,ld_excesswage,ld_last_dedamt
double ld_atinc_rt,ld_atinc_days,ld_atinc_mindays,ld_atinc_amt,ld_atinc_w2days,ld_half_hajira,ld_w2_half_hajira
string ls_atinc_range,ls_atinc_pfind,ls_w2_stdt,ls_end_dt,ls_lwwid_excess
 
id_totricequan=0; id_totattaquan=0;ll_nodays=0;ll_weekstatus=0


	select lww_id,((LWW_ENDDATE - LWW_STARTDATE) + 1),to_char(LWW_STARTDATE + 7,'dd/mm/yyyy'),to_char(LWW_ENDDATE,'dd/mm/yyyy')
	into :fs_lww_id,:ll_nodays,:ls_w2_stdt,:ls_end_dt
	from fb_labourwagesweek 
	where lww_startdate= to_date(:fs_st_dt,'dd/mm/yyyy') and lww_paidflag='0';
	
	if sqlca.sqlcode =100 then
		messagebox('Wages Week Select ','Either the there is no such week or the wages against this week has been paid, Please Check...!')
		return -1
	elseif sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Wages Week Select ',sqlca.sqlerrtext)
		return -1
	end if;
	
	select distinct 'x' into :ls_temp from fb_labourrationchart
	 where to_date(:fs_st_dt,'dd/mm/yyyy')  between LRC_FRDT and nvl(LRC_TODT,trunc(sysdate));
	
	if sqlca.sqlcode =100 then
		messagebox('Ration Chart checking','The Ration Chart has not been prepared Please Check...!')
		return -1
	elseif sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Ration Chart checking ',sqlca.sqlerrtext)
		return -1
	end if;

	select distinct 'x' into :ls_temp from fb_rationperiodforweek where RPFW_LWW_ID =  :fs_lww_id and RPFW_CALFLAG='0';
	
	if sqlca.sqlcode =0 then
		messagebox('Ration Chart checking','The Ration Against this Period has not been paid. First pay the ration for this period, Please Check...!')
		return -1
	elseif sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Ration Payment checking ',sqlca.sqlerrtext)
		return -1
	end if;
	
	if gs_garden_snm='MT' then
		
		select distinct 'x' into :ls_temp from fb_labourwagadvweek where LWW_ID =  :fs_lww_id and LWAW_PAIDFLAG='0';
		
		if sqlca.sqlcode =0 then
			messagebox('Weekly Advance checking','The Weekly Advance Against this Period has not been paid. First pay the Weekly Advance for this period, Please Check...!')
			return -1
		elseif sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: During Weekly Advance Payment checking ',sqlca.sqlerrtext)
			return -1
		end if;
		
	end if	
	
	select max(length(LWS_STATUS)) into :ll_weekstatus from fb_labourweeklystatus where LWW_ID = :fs_lww_id;
	
	if sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Attendance Status checking ',sqlca.sqlerrtext)
		return -1
	end if;
	
	if isnull(ll_weekstatus) then ll_weekstatus=0
	
	w_mdi.setmicrohelp('Calculation of Week Status is Going on ....!')
	
	if ((ll_nodays * 2) <> (ll_weekstatus +1)) then
		IF WF_UPD_WEEKLY_STATUS(fs_lww_id) = -1 THEN
			return -1
		end if
	end if
	w_mdi.setmicrohelp('Calculation of Week Status is Completed  ....!')
	
	select sum(decode(pd_doc_type,'FOODCOMP',pd_value,0)) ,
			sum(decode(pd_doc_type,'ROUNDOFF',pd_value,0)),
			sum(decode(pd_doc_type,'PFFPFRT',decode(pd_code,'1',pd_value,0),0)),
			sum(decode(pd_doc_type,'PFFPFRT',decode(pd_code,'2',pd_value,0),0)),
			sum(decode(pd_doc_type,'PFFPFRT',decode(pd_code,'3',pd_value,0),0)),
			sum(decode(pd_doc_type,'REVSTAMP',decode(pd_code,'1',pd_value,0),0)),
			sum(decode(pd_doc_type,'REVSTAMP',decode(pd_code,'2',pd_value,0),0)),
			sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0))
	into :ld_fdconc_rt,:ld_rnd_off,:ld_tpf_rt,:ld_pf_rt,:ld_fpf_rt,:ld_revst_range,:ld_revst,:ll_adoleage
	from fb_param_detail 
	where pd_doc_type in ('ROUNDOFF','FOODCOMP','PFFPFRT','REVSTAMP','ADOLEAGE') and
	to_date(:fs_st_dt,'dd/mm/yyyy') between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));

	if sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
		return -1
	end if;
	
	if isnull(ld_fdconc_rt) then ld_fdconc_rt=0
	if isnull(ld_rnd_off) then ld_rnd_off=0
	if isnull(ld_tpf_rt) then ld_tpf_rt=0
	if isnull(ld_pf_rt) then ld_pf_rt=0
	if isnull(ld_fpf_rt) then ld_fpf_rt=0
	if isnull(ld_revst_range) then ld_revst_range=0
	if isnull(ld_revst) then ld_revst=0
	if isnull(ll_adoleage) then ll_adoleage=0
	
// select emp.emp_id,mdays,mwages,sickdays,sickwages,sickwagesdays,holidaypay,hajiradays,hajiraearn,otherearn,withpaydays,workdaysration,elpearn,totearn,
// 		  lws.lws_status weekstatus,emp.emp_sex emp_sex,trim(emp.emp_type) emp_type,emp_marital,emp.emp_elect electricflag,
// 		  emp.edg_id edg_id,emp.emp_pfno pfno,emp_pfdedcode pfdedcode,nvl(edg.edg_electricded,0) dedgroup,
//		  ls.FIELD_ID,ls.LS_LWFFLAG,ls.LS_SUBSFLAG,emp.ls_id,ls.ls_fortnightration,
//		  atinc_rt,nvl(atinc_days,0) atinc_days, nvl(atinc_w2days,0) atinc_w2days ,nvl(AI_RATERANGE,'N'), nvl(AI_MINDAYS,0),nvl(AI_PFELIGIBLE,'N'),
//		  nvl(halfhajiradays,0),nvl(w2_halfhajiradays,0), nvl(EMP_LIP,0) EMP_LIP
//   from (select lda.lww_id lwwid,lda.labour_id labourid,
//					sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',nvl(lda_status,0),0)) mdays,
//					sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',lda_wages,0)) mwages,
//					sum(decode(trim(kam.kamsub_nkamtype),'SICKALLOWANCE',lda_status,'SICKNOWAGES',lda_status,0)) sickdays,
//					sum(decode(trim(kam.kamsub_nkamtype),'SICKALLOWANCE',lda_wages,'SICKNOWAGES',lda_wages,0)) sickwages,
//					sum(decode(trim(kam.kamsub_nkamtype),'SICKALLOWANCE',decode(nvl(lda_wages,0),0,0,lda_status),'SICKNOWAGES',decode(nvl(lda_wages,0),0,0,lda_status),0)) sickwagesdays,
//					sum(decode(trim(kam.kamsub_nkamtype),'HOLIDAYPAY',lda_wages,0)) holidaypay,
//					sum(decode(trim(kam.kamsub_nkamtype),'HOLIDAYPAY',nvl(lda_status,0),0)) holidaypayday,
//					sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',nvl(lda_status,0),0)) hajiradays,
//					sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',nvl(lda_wages,0),(nvl(lda_wages,0)-nvl(lda_elp,0))),0)) hajiraearn,
//					sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',0,'SICKALLOWANCE',0,'SICKNOWAGES',0,'OTHERS',0,lda_wages)) otherearn,
//					sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',decode(nvl(lda_wages,0),0,0,lda_status),'SICKALLOWANCE',decode(nvl(lda_wages,0),0,0,lda_status),'SICKNOWAGES',decode(nvl(lda_wages,0),0,0,lda_status),'OTHERS',decode(nvl(lda_wages,0),0,0,lda_status),decode(nvl(lda_wages,0),0,0,lda_status) )) withpaydays,
//					sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',decode(nvl(lda_wages,0),0,0,lda_status),'SICKALLOWANCE',lda_status,'SICKNOWAGES',lda_status,'OTHERS',decode(nvl(lda_wages,0),0,0,lda_status),decode(nvl(lda_wages,0),0,0,lda_status))) workdaysration,
//					sum(lda_elp) elpearn,
//					sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) totearn,
//					nvl(decode(sign((((to_date(:fs_st_dt,'dd/mm/yyyy') - EMP_DOB)/365)) - :ll_adoleage),1,AI_RATEADULT,AI_RATEADOLE),0) atinc_rt,
//		  			((nvl(sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',decode(lda_status,1,decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,0,1),0),0)),0) - 
//					  nvl(sum(decode(trim(KAMSUB_NAME),'SUS',nvl(decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,0,lda_status),0),0)),0) - 
//					  decode(AI_LEAVEWITHWAGES,'N',nvl(sum(decode(trim(KAMSUB_NAME),'LWW',nvl(decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,0,lda_status),0),0)),0),0) ) + 
//					  decode(AI_SICKWITHWAGES,'Y',nvl(sum(decode(trim(kam.kamsub_nkamtype),'SICKALLOWANCE',decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,0,lda_status),'SICKNOWAGES',decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,0,lda_status),0)),0),0) +
//		    				decode(AI_MATERNITY,'Y',nvl(sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',nvl(decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,0,lda_status),0),0)),0),0) +  
//						decode(AI_HOLIDAY,'Y',nvl(sum(decode(trim(kam.kamsub_nkamtype),'HOLIDAYPAY',nvl(decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,0,lda_status),0),0)),0),0)) atinc_days,
//		  			((nvl(sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',decode(lda_status,1,decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,1,0),0),0)),0) - 
//					  nvl(sum(decode(trim(KAMSUB_NAME),'SUS',nvl(decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,lda_status,0),0),0)),0) - 
//					  decode(AI_LEAVEWITHWAGES,'N',nvl(sum(decode(trim(KAMSUB_NAME),'LWW',nvl(decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,lda_status,0),0),0)),0),0) ) + 
//					  decode(AI_SICKWITHWAGES,'Y',nvl(sum(decode(trim(kam.kamsub_nkamtype),'SICKALLOWANCE',decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,lda_status,0),'SICKNOWAGES',decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,lda_status,0),0)),0),0) +
//		    				decode(AI_MATERNITY,'Y',nvl(sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',nvl(decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,lda_status,0),0),0)),0),0) +  
//						decode(AI_HOLIDAY,'Y',nvl(sum(decode(trim(kam.kamsub_nkamtype),'HOLIDAYPAY',nvl(decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,lda_status,0),0),0)),0),0)) atinc_w2days,
//				  	AI_RATERANGE,AI_MINDAYS,AI_PFELIGIBLE,
//					sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',decode(to_number(lda_status),0.5,decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,0,1),0.25,decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,0,1),0.75,decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,0,1),0),0)) halfhajiradays,
//					sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',decode(to_number(lda_status),0.5,decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,1,0),0.25,decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,1,0),0.75,decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,1,0),0),0)) w2_halfhajiradays	  
//		  from fb_labourdailyattendance lda,fb_kamsubhead kam ,fb_employee emp,
//				 (select AI_LABOURTYPE,AI_RATERANGE,AI_RATEADULT,AI_RATEADOLE,AI_MINDAYS, AI_SICKWITHWAGES, AI_HOLIDAY, AI_MATERNITY, AI_LEAVEWITHWAGES, AI_PFELIGIBLE
//					 from fb_attendanceincentive
//				  where to_date(:fs_st_dt,'dd/mm/yyyy') between AI_FROMDT and nvl(AI_TODT,trunc(sysdate)) )
//		 where lda.kamsub_id=kam.kamsub_id  and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and emp.emp_id=lda.labour_id and lda.lww_id= :fs_lww_id and emp.emp_type = AI_LABOURTYPE(+) 
//		 group by lda.lww_id,lda.labour_id, emp_dob,AI_RATEADULT,AI_RATEADOLE,AI_LEAVEWITHWAGES,AI_SICKWITHWAGES,AI_MATERNITY,AI_HOLIDAY,AI_RATERANGE,AI_MINDAYS,AI_PFELIGIBLE) lkw,
//		 fb_labourweeklystatus lws,fb_employee emp,fb_electricdedgroup edg,fb_laboursheet ls
//  where emp.emp_id=lkw.labourid(+) and emp.edg_id=edg.edg_id(+) and 
//             lkw.lwwid=lws.lww_id(+) and lkw.labourid=lws.labour_id(+) and 
//             lkw.lwwid=:fs_lww_id and emp.ls_id = ls.ls_id(+)	
	
declare c1 cursor for 
 select emp.emp_id,mdays,mwages,sickdays,sickwages,sickwagesdays,holidaypay,hajiradays,hajiraearn,otherearn,withpaydays,workdaysration,elpearn,totearn,
 		  lws.lws_status weekstatus,emp.emp_sex emp_sex,trim(emp.emp_type) emp_type,emp_marital,emp.emp_elect electricflag,
 		  emp.edg_id edg_id,emp.emp_pfno pfno,emp_pfdedcode pfdedcode,nvl(edg.edg_electricded,0) dedgroup,
		  ls.FIELD_ID,ls.LS_LWFFLAG,ls.LS_SUBSFLAG,emp.ls_id,ls.ls_fortnightration,
		  atinc_rt,nvl(atinc_days,0) atinc_days, nvl(atinc_w2days,0) atinc_w2days ,nvl(AI_RATERANGE,'N'), nvl(AI_MINDAYS,0),nvl(AI_PFELIGIBLE,'N'),
		  nvl(halfhajiradays,0),nvl(w2_halfhajiradays,0), nvl(EMP_LIP,0) EMP_LIP
   from (select lda.lww_id lwwid,lda.labour_id labourid,
					sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',nvl(lda_status,0),0)) mdays,
					sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',lda_wages,0)) mwages,
					sum(decode(trim(kam.kamsub_nkamtype),'SICKALLOWANCE',lda_status,'SICKNOWAGES',lda_status,0)) sickdays,
					sum(decode(trim(kam.kamsub_nkamtype),'SICKALLOWANCE',lda_wages,'SICKNOWAGES',lda_wages,0)) sickwages,
					sum(decode(trim(kam.kamsub_nkamtype),'SICKALLOWANCE',decode(nvl(lda_wages,0),0,0,lda_status),'SICKNOWAGES',decode(nvl(lda_wages,0),0,0,lda_status),0)) sickwagesdays,
					sum(decode(trim(kam.kamsub_nkamtype),'HOLIDAYPAY',lda_wages,0)) holidaypay,
					sum(decode(trim(kam.kamsub_nkamtype),'HOLIDAYPAY',nvl(lda_status,0),0)) holidaypayday,
					sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',nvl(lda_status,0),0)) hajiradays,
					sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',nvl(lda_wages,0),(nvl(lda_wages,0)-nvl(lda_elp,0))),0)) hajiraearn,
					sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',0,'SICKALLOWANCE',0,'SICKNOWAGES',0,'OTHERS',0,lda_wages)) otherearn,
					sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',decode(nvl(lda_wages,0),0,0,lda_status),'SICKALLOWANCE',decode(nvl(lda_wages,0),0,0,lda_status),'SICKNOWAGES',decode(nvl(lda_wages,0),0,0,lda_status),'OTHERS',decode(nvl(lda_wages,0),0,0,lda_status),decode(nvl(lda_wages,0),0,0,lda_status) )) withpaydays,
					sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',decode(nvl(lda_wages,0),0,0,lda_status),'SICKALLOWANCE',lda_status,'SICKNOWAGES',lda_status,'OTHERS',decode(nvl(lda_wages,0),0,0,lda_status),decode(nvl(lda_wages,0),0,0,lda_status))) workdaysration,
					sum(lda_elp) elpearn,
					sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) totearn,
					nvl(decode(sign(get_diff(to_date(:fs_st_dt,'dd/mm/yyyy'),EMP_DOB,'B') - :ll_adoleage),1,AI_RATEADULT,AI_RATEADOLE),0) atinc_rt,//(((to_date(:fs_st_dt,'dd/mm/yyyy') - EMP_DOB)/365))

					((nvl(sum(decode(trim(kam.kamsub_nkamtype),'OTHERS', decode(sign(lda_wages - 0),1,decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),-1,1,0),0) ,0)),0) - 
                      nvl(sum(decode(trim(KAMSUB_NAME),'SUS',nvl(decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),-1,1,0),0),0)),0) - 
                      decode(AI_LEAVEWITHWAGES,'N',nvl(sum(decode(trim(KAMSUB_NAME),'LWW',nvl(decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),-1,1,0),0),0)),0),0) ) + 
                      decode(AI_SICKWITHWAGES,'Y',nvl(sum(decode(trim(kam.kamsub_nkamtype),'SICKALLOWANCE',decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),-1,1,0),'SICKNOWAGES',decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),-1,0,0),0)),0),0) +
                            decode(AI_MATERNITY,'Y',nvl(sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',nvl(decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),-1,1,0),0),0)),0),0) +  
                        decode(AI_HOLIDAY,'Y',nvl(sum(decode(trim(kam.kamsub_nkamtype),'HOLIDAYPAY',nvl(decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),-1,1,0),0),0)),0),0)) atinc_days,
                      ((nvl(sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',decode(sign(lda_wages - 0),1,decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),-1,0,1),0),0)),0) - 
                      nvl(sum(decode(trim(KAMSUB_NAME),'SUS',nvl(decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),-1,0,1),0),0)),0) - 
                      decode(AI_LEAVEWITHWAGES,'N',nvl(sum(decode(trim(KAMSUB_NAME),'LWW',nvl(decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),-1,0,1),0),0)),0),0) ) + 
                      decode(AI_SICKWITHWAGES,'Y',nvl(sum(decode(trim(kam.kamsub_nkamtype),'SICKALLOWANCE',decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),-1,0,1),'SICKNOWAGES',decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),-1,0,0),0)),0),0) +
                            decode(AI_MATERNITY,'Y',nvl(sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',nvl(decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),-1,0,1),0),0)),0),0) +  
                        decode(AI_HOLIDAY,'Y',nvl(sum(decode(trim(kam.kamsub_nkamtype),'HOLIDAYPAY',nvl(decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),-1,0,1),0),0)),0),0))	atinc_w2days,
				  	AI_RATERANGE,AI_MINDAYS,AI_PFELIGIBLE,
					sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',decode(to_number(lda_status),0.5,decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,0,1),0.25,decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,0,1),0.75,decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,0,1),0),0)) halfhajiradays,
					sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',decode(to_number(lda_status),0.5,decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,1,0),0.25,decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,1,0),0.75,decode(sign(lda_date - to_date(:ls_w2_stdt,'dd/mm/yyyy')),1,1,0),0),0)) w2_halfhajiradays	  
		  from fb_labourdailyattendance lda,fb_kamsubhead kam ,fb_employee emp,
				 (select AI_LABOURTYPE,AI_RATERANGE,AI_RATEADULT,AI_RATEADOLE,AI_MINDAYS, AI_SICKWITHWAGES, AI_HOLIDAY, AI_MATERNITY, AI_LEAVEWITHWAGES, AI_PFELIGIBLE
					 from fb_attendanceincentive
				  where to_date(:fs_st_dt,'dd/mm/yyyy') between AI_FROMDT and nvl(AI_TODT,trunc(sysdate)) )
		 where lda.kamsub_id=kam.kamsub_id  and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and emp.emp_id=lda.labour_id and lda.lww_id= :fs_lww_id and emp.emp_type = AI_LABOURTYPE(+) 
		 group by lda.lww_id,lda.labour_id, emp_dob,AI_RATEADULT,AI_RATEADOLE,AI_LEAVEWITHWAGES,AI_SICKWITHWAGES,AI_MATERNITY,AI_HOLIDAY,AI_RATERANGE,AI_MINDAYS,AI_PFELIGIBLE) lkw,
		 fb_labourweeklystatus lws,fb_employee emp,fb_electricdedgroup edg,fb_laboursheet ls
  where emp.emp_id=lkw.labourid(+) and emp.edg_id=edg.edg_id(+) and 
             lkw.lwwid=lws.lww_id(+) and lkw.labourid=lws.labour_id(+) and 
             lkw.lwwid=:fs_lww_id and emp.ls_id = ls.ls_id(+);// and emp.emp_id = 'P10257';
		 
open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 

	setnull(ls_labour_id);setnull(ls_emp_status);	setnull(ls_emp_sex);setnull(ls_emp_type);setnull(ls_emp_marital);setnull(ls_electricflag);
	setnull(ls_pfno);setnull(ls_pfdedcode);setnull(ls_FIELD_ID);
	ld_mdays= 0; ld_sickdays= 0; ld_sickwagesdays= 0; ld_hajiradays= 0; ld_withpaydays= 0; ld_workdaysration= 0; ll_edg_id=0;
	ld_mwages= 0; ld_sickwages= 0; ld_holidaypay= 0; ld_hajiraearn= 0; ld_otherearn= 0; ld_elpearn= 0; ld_totearn= 0; ld_dedgroup=0;ld_fdconc=0
	ld_pf = 0;ld_fpf = 0;ll_payid=0;ld_coinbf=0;ld_coincf=0;ld_netpayable=0;
	ld_atinc_amt=0;ld_atinc_rt=0;ld_atinc_days=0;ld_atinc_w2days=0;ld_atinc_mindays=0;ld_half_hajira=0;ld_w2_half_hajira=0 ; ld_nlip = 0
	setnull(ls_atinc_pfind);setnull(ls_atinc_range)

	ld_lwf = fd_lwf ; ld_subs = fd_subs

	fetch c1 into :ls_labour_id,:ld_mdays,:ld_mwages,:ld_sickdays,:ld_sickwages,:ld_sickwagesdays,:ld_holidaypay,:ld_hajiradays,:ld_hajiraearn,
				    :ld_otherearn,:ld_withpaydays,:ld_workdaysration,:ld_elpearn,:ld_totearn,
				    :ls_emp_status,	:ls_emp_sex,:ls_emp_type,:ls_emp_marital,:ls_electricflag,:ll_edg_id,:ls_pfno,:ls_pfdedcode,:ld_dedgroup,
				    :ls_FIELD_ID,:LS_LWFFLAG,:LS_SUBSFLAG,:ll_payid,:ls_fortnightration,
					:ld_atinc_rt,:ld_atinc_days,:ld_atinc_w2days,:ls_atinc_range,:ld_atinc_mindays,:ls_atinc_pfind,:ld_half_hajira,:ld_w2_half_hajira,:ld_nlip;

	do while sqlca.sqlcode <> 100 
 
	w_mdi.setmicrohelp('Calculation of Wages For Labour ID '+ls_labour_id+'  Is going on  ....!')
		
//			if ls_electricflag ='YES' then r
//				ll_edg_id
//			end if
//			   To Be Check the below logic

//				if ls_fortnightration = '1' then
//					ld_First_days = wf_fortnight_firstweek_workdays(fs_lww_id,ls_labour_id,fs_st_dt)
//
//					If ld_First_days > 0 Then
//						ld_workdaysration = ld_workdaysration + ld_First_days
//					End If
//				end if

				if ld_atinc_rt > 0 then 
					if ld_atinc_mindays <= ld_atinc_days then
						//Commented on 08/01/2020 because we are considering half hazira in the above main query so no need to add here
						//ld_atinc_days = round((ld_atinc_days + ld_half_hajira),0)
						ld_atinc_days = round(ld_atinc_days,0)
						if ls_atinc_range ='W' then
							ld_atinc_amt = ld_atinc_rt
						else
//							if ld_atinc_days > 6 then
//							   ld_atinc_days = 6
//							end if
							ld_atinc_amt = ld_atinc_days * ld_atinc_rt
						end if
					end if
					
					if isnull(ld_atinc_amt) then ld_atinc_amt=0
					if ld_atinc_w2days > 0 then		// For Second week
						if ld_atinc_mindays <= ld_atinc_w2days then
							//Commented on 08/01/2020 because we are considering half hazira in the above main query so no need to add here
							//ld_atinc_w2days = round((ld_atinc_w2days + ld_w2_half_hajira),0) 
							ld_atinc_w2days = round(ld_atinc_w2days,0) 
							if ls_atinc_range ='W' then
								ld_atinc_amt = ld_atinc_amt + ld_atinc_rt
							else
//								if ld_atinc_w2days > 6 then
//							  	   ld_atinc_w2days = 6
//								end if
								ld_atinc_amt = ld_atinc_amt + (ld_atinc_w2days * ld_atinc_rt)
							end if	
						end if	
					end if
					ld_totearn = ld_totearn + ld_atinc_amt
				end if
						
				
				if LS_LWFFLAG="0" then 
					ld_lwf = 0
				else
					if ld_withpaydays < 3 then
						ld_lwf = 0
					end if
				end if
				
				if LS_SUBSFLAG = "0" then
					ld_subs = 0
				end if

////			Ration 

		if gs_garden_snm='MT' then

			select sum(nvl(lwr_rationded,0)) rationded,sum(nvl(lwr_ricewt,0)) ricewt,sum(nvl(lwr_attawt,0)),sum(LWR_NOMIN),sum(LWR_NOMAJ),
					sum(nvl(lwr_penalty,0)) penalty,sum(nvl(lwr_netelp,0)) elpearn
				 into :ld_ration,:id_labricewt,:id_labattawt,:id_no_lab_depminor,:id_no_lab_depmajor,:ld_penalty,:ld_elpearn
				from fb_labourweeklyration
			  where labour_id = :ls_labour_id and lrw_id in (select RPFW_ID from fb_rationperiodforweek 
			  												where RPFW_CALFLAG ='1' and RPFW_PAIDFLAG ='1' and RPFW_LWW_ID = :fs_lww_id);
			  
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Ration (Select ): ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			end if;
		else
			select sum(nvl(lwr_rationded,0)) rationded,sum(nvl(lwr_ricewt,0)) ricewt,sum(nvl(lwr_attawt,0)),sum(LWR_NOMIN),sum(LWR_NOMAJ)
				 into :ld_ration,:id_labricewt,:id_labattawt,:id_no_lab_depminor,:id_no_lab_depmajor
				from fb_labourweeklyration
			  where labour_id = :ls_labour_id and lrw_id in (select RPFW_ID from fb_rationperiodforweek where RPFW_CALFLAG ='1' and RPFW_LWW_ID = :fs_lww_id);
			  
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Ration (Select ): ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			end if;
		end if			
			
			if isnull(ld_penalty) then ld_penalty=0
			if gs_garden_snm='MT' then

				select sum(nvl(lwaw_advance,0)) rationded into :ld_weekly_advance
					from fb_labourwagadvweek lwaw,fb_labourweeklyadvance lwadv
					where lwaw.lwaw_id=lwadv.lwaw_id and lwaw.lww_id=:fs_lww_id and labour_id = :ls_labour_id ;
				  
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Weekly Advance (Select ): ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 
				end if;
	
		//			select sum(decode(lidt.lidt_wfieldname,'LABOUR_LIP',lwid.leid_dedamo)) lip,
		//					sum(decode(lidt.lidt_wfieldname,'LABOUR_ELECTRICITY',lwid.leid_dedamo)) ele,
		//					sum(decode(lidt.lidt_wfieldname,'LABOUR_ELECTRICITY',lwid.leid_units)) ele_unit,
		//					sum(decode(lidt.lidt_wfieldname,'LABOUR_LWF',lwid.leid_dedamo)) lwf,
		//					sum(decode(lidt.lidt_wfieldname,'LABOUR_RD',lwid.leid_dedamo)) rd,
		//					sum(decode(lidt.lidt_wfieldname,'LABOUR_KOIL',lwid.leid_dedamo)) KoilAmo,
		//					sum(decode(lidt.lidt_wfieldname,'LABOUR_ADVANCE',lwid.leid_dedamo)) advance
		//			 into :ld_nlip,:ld_nele,:ld_nele_unit,:ld_nlwf,:ld_nrd,:ld_nKoilAmo,:ld_nadvance
		//			  from fb_labissuededtype lidt,fb_labissuededtypedetails lidtd,fb_labweeklyissueded lwid 
		//			 where lidt.lidt_id=lidtd.lidt_id and 
		//					  lidtd.lidtd_id=lwid.lidtd_id and lidtd.lww_id=:fs_lww_id and lwid.labour_id =:ls_labour_id ;
							  
//				if sqlca.sqlcode = -1 then
//					messagebox('Sql Error : During LIP/RD/KOIL/etc (Dedn): ',sqlca.sqlerrtext); 
//					rollback using sqlca; 
//					return -1; 
//				end if;
			
			end if  // MT

			select (advanceded+excess_wages),pfadvanceded,pfinterestded,electricded, elecadvded, medadvded, festadvded,excess_wages  into :ld_advance,:ld_pfadvded,:ld_pfintded,:ld_electric, :ld_electadvded, :ld_medadvded, :ld_festadvded,:ld_excesswage
			from fb_labadvancededuction where labour_id=:ls_labour_id and lww_id=:fs_lww_id;
			
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Advance Select : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			elseif sqlca.sqlcode =100 then
				 ld_advance=0;ld_pfadvded=0;ld_pfintded=0;ld_electric=0; ld_electadvded = 0; ld_medadvded = 0; ld_festadvded = 0;ld_excesswage=0;
			end if;
			
			select lsm_subs_amount, to_char(lsm_issue_date, 'dd/mm/yyyy') into :ld_lpg_subsidy_ded, :ls_lpg_issue_dt from fb_lpg_subsidy_mast where emp_id = :ls_labour_id and lsm_subs_amount - nvl(lsm_recovered_amt, 0) > 0
			and lsm_issue_Date = (select min(lsm_issue_date) from  fb_lpg_subsidy_mast where emp_id = :ls_labour_id and lsm_subs_amount - nvl(lsm_recovered_amt, 0) > 0 );
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Getting LPG Subsidy Deduction Amt. : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 		
			elseif sqlca.sqlcode = 100 then
				ld_lpg_subsidy_ded = 0;
			end if
			
			if gs_garden_snm= 'MR'  or gs_garden_snm= 'SP'   or gs_garden_snm= 'LP' or gs_garden_snm= 'AB' or gs_garden_snm = 'AD'  or gs_garden_snm= 'MH'  or gs_garden_snm= 'DR' then

					
 				select CD_AMOUNT into :ld_copr_amt from fb_labcopdeduction where CD_EMP_ID = :ls_labour_id and LWW_ID = :fs_lww_id and cd_ded_type =  'COOPRATIVE';
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting Coopretive Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_copr_amt = 0;
				end if
				
				select CD_AMOUNT into :ld_ELECT1_IAMT from fb_labcopdeduction where CD_EMP_ID = :ls_labour_id and LWW_ID = :fs_lww_id and cd_ded_type = 'ELECT1' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting Electric1 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_ELECT1_IAMT = 0;
				end if

				select CD_AMOUNT into :ld_ELECT2_IAMT from fb_labcopdeduction where CD_EMP_ID = :ls_labour_id and LWW_ID = :fs_lww_id and cd_ded_type = 'ELECT2' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting Electric2 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_ELECT2_IAMT = 0;
				end if
				
				select CD_AMOUNT into :ld_ELECT3_IAMT from fb_labcopdeduction where CD_EMP_ID = :ls_labour_id and LWW_ID = :fs_lww_id and cd_ded_type = 'ELECT3' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting Electric3 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_ELECT3_IAMT = 0;
				end if
				
				select CD_AMOUNT into :ld_ELECT4_IAMT from fb_labcopdeduction where CD_EMP_ID = :ls_labour_id and LWW_ID = :fs_lww_id and cd_ded_type = 'ELECT4' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting Electric4 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_ELECT4_IAMT = 0;
				end if

				select CD_AMOUNT into :ld_ACMS01_IAMT from fb_labcopdeduction where CD_EMP_ID = :ls_labour_id and LWW_ID = :fs_lww_id and cd_ded_type = 'ACMS01' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting ACMS Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_ACMS01_IAMT = 0;
				end if
				
				select CD_AMOUNT into :ld_BPUJA1_IAMT from fb_labcopdeduction where CD_EMP_ID = :ls_labour_id and LWW_ID = :fs_lww_id and cd_ded_type = 'BPUJA1' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting BPUJA1 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_BPUJA1_IAMT = 0;
				end if
				
				select CD_AMOUNT into :ld_BPUJA2_IAMT from fb_labcopdeduction where CD_EMP_ID = :ls_labour_id and LWW_ID = :fs_lww_id and cd_ded_type = 'BPUJA2' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting BPUJA2 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_BPUJA2_IAMT = 0;
				end if
				
				if gs_garden_snm = 'SP' then 
					ld_BPUJA2_IAMT = 0;
				end if				
				
				select CD_AMOUNT into :ld_BMASAN_IAMT from fb_labcopdeduction where CD_EMP_ID = :ls_labour_id and LWW_ID = :fs_lww_id and cd_ded_type = 'BMASAN' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting BMASAN Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_BMASAN_IAMT = 0;
				end if
				
				select CD_AMOUNT into :ld_CBME_IAMT from fb_labcopdeduction where CD_EMP_ID = :ls_labour_id and LWW_ID = :fs_lww_id and cd_ded_type = 'CBME' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting CBME Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_CBME_IAMT = 0;
				end if
				
				select CD_AMOUNT into :ld_CHURCH_IAMT from fb_labcopdeduction where CD_EMP_ID = :ls_labour_id and LWW_ID = :fs_lww_id and cd_ded_type = 'CHURCH' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting CHURCH Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_CHURCH_IAMT = 0;
				end if
				
				select CD_AMOUNT into :ld_ICICI_IAMT from fb_labcopdeduction where CD_EMP_ID = :ls_labour_id and LWW_ID = :fs_lww_id and cd_ded_type = 'ICICI' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting ICICI Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_ICICI_IAMT = 0;
				end if

				select CD_AMOUNT into :ld_PUJA1_IAMT from fb_labcopdeduction where CD_EMP_ID = :ls_labour_id and LWW_ID = :fs_lww_id and cd_ded_type = 'PUJA1' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting PUJA1 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_PUJA1_IAMT = 0;
				end if

				select CD_AMOUNT into :ld_PUJA2_IAMT from fb_labcopdeduction where CD_EMP_ID = :ls_labour_id and LWW_ID = :fs_lww_id and cd_ded_type = 'PUJA2' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting PUJA2 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_PUJA2_IAMT = 0;
				end if

				select CD_AMOUNT into :ld_PUJA3_IAMT from fb_labcopdeduction where CD_EMP_ID = :ls_labour_id and LWW_ID = :fs_lww_id and cd_ded_type = 'PUJA3' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting PUJA3 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_PUJA3_IAMT = 0;
				end if

				select CD_AMOUNT into :ld_PUJA4_IAMT from fb_labcopdeduction where CD_EMP_ID = :ls_labour_id and LWW_ID = :fs_lww_id and cd_ded_type = 'PUJA4' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting PUJA4 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_PUJA4_IAMT = 0;
				end if

				select CD_AMOUNT into :ld_PUJA5_IAMT from fb_labcopdeduction where CD_EMP_ID = :ls_labour_id and LWW_ID = :fs_lww_id and cd_ded_type = 'PUJA5' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting PUJA5 Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_PUJA5_IAMT = 0;
				end if

				select CD_AMOUNT into :ld_MEDICAL_IAMT from fb_labcopdeduction where CD_EMP_ID = :ls_labour_id and LWW_ID = :fs_lww_id and cd_ded_type = 'MEDICAL' ;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Getting MEDICAL Amt. : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 		
				elseif sqlca.sqlcode = 100 then
					ld_MEDICAL_IAMT = 0;
				end if
				  
			end if
			/*		If ls_emp_type = "LP" Then 
						If Round((ld_withpaydays), 0) >= 7 And ld_mdays > 0 Then
							ld_fdconc = Round(ld_fdconc_rt * 6, 2) 
						Else
							ld_fdconc = Round(ld_fdconc_rt * round((ld_withpaydays), 0), 2)
						End If
					Else
						ld_fdconc = 0
					End If*/

		// PF Deduction
					If len(trim(ls_pfno)) > 0 and (ls_pfdedcode ='1' or ls_pfdedcode ='2' ) Then
						
							select distinct 'x' into :ls_temp from fb_exemptmaster
								where EM_LSID = :ll_payid and EM_PFIND= 'Y' and to_date(:fs_st_dt,'dd/mm/yyyy') between EM_FROMDT and nvl(EM_TODT,trunc(sysdate));
								
							if sqlca.sqlcode = -1 then
								messagebox('Sql Error : During Exampt PF Select : ',sqlca.sqlerrtext); 
								rollback using sqlca; 
								return -1; 
							elseif sqlca.sqlcode =0 then	
								ld_pf = 0
								ld_fpf = 0
							else
								
							// Food Compensation 
								If Round((ld_withpaydays), 0) >= 7 And ld_mdays > 0 Then
									ld_fdconc = Round(ld_fdconc_rt * 6, 2) 
								Else
									ld_fdconc = Round(ld_fdconc_rt * round((ld_withpaydays), 0), 2)
								End If

								if ls_atinc_pfind ='N' then		// If PF Applicable in Attendance Incentive
									 If ls_pfdedcode = '1' Then 
										  ld_pf = Round(ld_tpf_rt * (ld_totearn + ld_fdconc - ld_atinc_amt ) / 100, 2)
										  ld_fpf = 0
									 Else
										  ld_fpf = Round(ld_fpf_rt * (ld_totearn + ld_fdconc - ld_atinc_amt ) / 100, 2)
										  ld_pf = Round(ld_pf_rt * (ld_totearn + ld_fdconc - ld_atinc_amt ) / 100, 2)
									 End If 
								else
									 If ls_pfdedcode = '1' Then 
										  ld_pf = Round(ld_tpf_rt * (ld_totearn + ld_fdconc) / 100, 2)
										  ld_fpf = 0
									 Else
										  ld_fpf = Round(ld_fpf_rt * (ld_totearn + ld_fdconc) / 100, 2)
										  ld_pf = Round(ld_pf_rt * (ld_totearn + ld_fdconc) / 100, 2)
									 End If 									
								end if
							end if
					Else
						ld_pf = 0
						ld_fpf = 0
					End If		

					if isnull(ld_pf) then ld_pf=0
					if isnull(ld_fpf) then ld_fpf=0
					if isnull(ld_nele) then ld_nele=0
					if isnull(ld_electric) then ld_electric=0
					if isnull(ld_ration) then ld_ration=0
					if isnull(ld_nadvance) then ld_nadvance=0
					if isnull(ld_advance) then ld_advance=0
					if isnull(ld_lwf) then ld_lwf=0
					if isnull(ld_weekly_advance) then ld_weekly_advance=0
					if isnull(ld_elpearn) then ld_elpearn=0
					if isnull(ld_nlip) then ld_nlip=0
					if isnull(ld_nrd) then ld_nrd=0
					if isnull(ld_nKoilAmo) then ld_nKoilAmo=0
					if isnull(ld_subs) then ld_subs=0
					if isnull(ld_pfadvded) then ld_pfadvded=0
					if isnull(ld_pfintded) then ld_pfintded=0
					if isnull(ld_ELECT1_IAMT) then ld_ELECT1_IAMT=0 
					if isnull(ld_ELECT2_IAMT) then ld_ELECT2_IAMT=0  
					if isnull(ld_ELECT3_IAMT) then ld_ELECT3_IAMT=0 
					if isnull(ld_ELECT4_IAMT) then ld_ELECT4_IAMT=0 
					if isnull(ld_ACMS01_IAMT) then ld_ACMS01_IAMT=0 
					if isnull(ld_BPUJA1_IAMT) then ld_BPUJA1_IAMT=0 
					if isnull(ld_BPUJA2_IAMT) then ld_BPUJA2_IAMT=0 
					if isnull(ld_BMASAN_IAMT) then ld_BMASAN_IAMT=0 
					if isnull(ld_CBME_IAMT) then ld_CBME_IAMT=0 
					if isnull(ld_CHURCH_IAMT) then ld_CHURCH_IAMT=0 
					if isnull(ld_ICICI_IAMT) then ld_ICICI_IAMT=0 
					if isnull(ld_PUJA1_IAMT) then ld_PUJA1_IAMT=0 
					if isnull(ld_PUJA2_IAMT) then ld_PUJA2_IAMT=0 
					if isnull(ld_PUJA3_IAMT) then ld_PUJA3_IAMT=0 
					if isnull(ld_PUJA4_IAMT) then ld_PUJA4_IAMT=0 
					if isnull(ld_PUJA5_IAMT) then ld_PUJA5_IAMT=0 
					if isnull(ld_MEDICAL_IAMT) then ld_MEDICAL_IAMT=0 
					if isnull(ld_copr_amt) then ld_copr_amt=0 
					if isnull(ld_electadvded) then ld_electadvded=0
					if isnull(ld_medadvded) then ld_medadvded=0
					if isnull(ld_festadvded) then ld_festadvded=0
					if isnull(ld_lpg_subsidy_ded) then ld_lpg_subsidy_ded=0
					if isnull(ld_excesswage) then ld_excesswage=0
					
					
				if gs_garden_snm='MT' then
					ld_totded = ld_pf + ld_fpf + ld_nele + ld_electric + ld_ration + ld_nadvance + ld_advance + ld_lwf + ld_weekly_advance + ld_elpearn + ld_nlip + ld_nrd + ld_nKoilAmo + ld_subs + ld_pfadvded + ld_pfintded + ld_electadvded + ld_medadvded + ld_festadvded
				elseif gs_garden_snm= 'MR' or gs_garden_snm= 'LP' or gs_garden_snm= 'SP' or gs_garden_snm= 'AB'  or gs_garden_snm = 'AD'  or gs_garden_snm= 'MH'  or gs_garden_snm= 'DR' then
					ld_totded = ld_pf + ld_fpf + ld_electric + ld_ration + ld_advance + ld_lwf + ld_subs  + ld_nlip + ld_pfadvded + ld_pfintded + ld_ELECT1_IAMT + ld_ELECT2_IAMT + ld_ELECT3_IAMT + ld_ELECT4_IAMT + ld_ACMS01_IAMT + ld_BPUJA1_IAMT + ld_BPUJA2_IAMT + ld_BMASAN_IAMT + ld_CBME_IAMT + ld_CHURCH_IAMT + ld_ICICI_IAMT + ld_PUJA1_IAMT + ld_PUJA2_IAMT + ld_PUJA3_IAMT + ld_PUJA4_IAMT + ld_PUJA5_IAMT + ld_MEDICAL_IAMT + ld_copr_amt  + ld_electadvded + ld_medadvded + ld_festadvded
				else
					ld_totded = ld_pf + ld_fpf + ld_electric + ld_ration + ld_advance + ld_lwf + ld_subs + ld_pfadvded + ld_pfintded  + ld_electadvded + ld_medadvded + ld_festadvded
				end if
				
				if isnull(ld_totded) then ld_totded=0
				
				select labour_coinbf into :ld_coinbf from fb_labourweeklywages 
				where labour_id=:ls_labour_id and lww_id=(select max(lww_id) from fb_labourweeklywages where labour_id=:ls_labour_id and lww_id < :fs_lww_id);
				
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Labour Coin BF Select : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 
				elseif sqlca.sqlcode =100 then
					 ld_coinbf=0;
				end if;
			
				if gs_garden_snm='MT' then
					if (ld_totearn - ld_totded +ld_coinbf) <= 0 then		// LESS RD
						ld_totded = ld_totded - ld_nrd;ld_nrd=0
						if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS LIP
							ld_totded = ld_totded - ld_nlip;ld_nlip=0
							if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS KOIL
								ld_totded = ld_totded - ld_nKoilAmo;ld_nKoilAmo=0
								if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS LWF
									ld_totded = ld_totded - ld_lwf; ld_lwf=0
									if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS ELECTRICITY
										ld_totded = ld_totded - (ld_nele + ld_electric); ld_nele =0; ld_electric =0
										if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS Advance
											ld_totded = ld_totded - (ld_nadvance + ld_advance); ld_nadvance =0; ld_advance=0
											if (ld_totearn - ld_totded +ld_coinbf) <= 0 then
												ld_totded = ld_totded - ld_subs; ld_subs=0
											end if
										end if
									end if
								end if
							end if
						end if
					end if
				elseif gs_garden_snm= 'MR' or gs_garden_snm= 'LP' or gs_garden_snm= 'SP' or gs_garden_snm= 'AB'  or gs_garden_snm = 'AD'  or gs_garden_snm= 'MH'  or gs_garden_snm= 'DR' then
					if (ld_totearn - ld_totded +ld_coinbf) <= 0 then		// LESS ld_ELECT1_IAMT
						ld_totded = ld_totded - ld_ELECT1_IAMT;ld_ELECT1_IAMT=0
						if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS ld_ELECT2_IAMT
							ld_totded = ld_totded - ld_ELECT2_IAMT;ld_ELECT2_IAMT=0
							if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS ld_ELECT3_IAMT
								ld_totded = ld_totded - ld_ELECT3_IAMT;ld_ELECT3_IAMT=0
								if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS ld_ELECT4_IAMT
									ld_totded = ld_totded - ld_ELECT4_IAMT; ld_ELECT4_IAMT=0
									if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS ld_ACMS01_IAMT
										ld_totded = ld_totded - ld_ACMS01_IAMT; ld_ACMS01_IAMT =0
										if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS ld_BPUJA1_IAMT
											ld_totded = ld_totded - ld_BPUJA1_IAMT; ld_BPUJA1_IAMT=0
											if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_subs
												ld_totded = ld_totded - ld_subs; ld_subs=0
											   if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_BPUJA2_IAMT
											  	 ld_totded = ld_totded - ld_BPUJA2_IAMT; ld_BPUJA2_IAMT=0
												 if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_BMASAN_IAMT
											  	    ld_totded = ld_totded - ld_BMASAN_IAMT; ld_BMASAN_IAMT=0
													if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_CBME_IAMT
													   ld_totded = ld_totded - ld_CBME_IAMT; ld_CBME_IAMT=0
														if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_CHURCH_IAMT
													       ld_totded = ld_totded - ld_CHURCH_IAMT; ld_CHURCH_IAMT=0
														   if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_ICICI_IAMT
													          ld_totded = ld_totded - ld_ICICI_IAMT; ld_ICICI_IAMT=0
															 if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_PUJA1_IAMT
													              ld_totded = ld_totded - (ld_PUJA1_IAMT + ld_PUJA2_IAMT + ld_PUJA3_IAMT + ld_PUJA4_IAMT+ ld_PUJA5_IAMT); ld_PUJA1_IAMT=0; ld_PUJA2_IAMT=0;ld_PUJA3_IAMT=0;ld_PUJA4_IAMT=0;ld_PUJA5_IAMT=0;
															      if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_MEDICAL_IAMT
													                  ld_totded = ld_totded - ld_MEDICAL_IAMT; ld_MEDICAL_IAMT=0
																	if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_copr_amt
													                     ld_totded = ld_totded - ld_copr_amt; ld_copr_amt=0
																		if (ld_totearn - ld_totded +ld_coinbf) <= 0 then // LESS ld_nlip
																			ld_totded = ld_totded - ld_nlip; ld_nlip=0
																		end if
																	end if
													               end if
													           end if
													        end if
													     end if
													end if
											      end if
											   end if
											end if
										end if
									end if
								end if
							end if
						end if
					end if
				else
					if (ld_totearn - ld_totded +ld_coinbf) <= 0 then
						ld_totded = ld_totded - ld_lwf; ld_lwf=0
						if (ld_totearn - ld_totded +ld_coinbf) <= 0 then
							ld_totded = ld_totded - ld_subs; ld_subs=0
						end if
					end if
				end if
				
//				ld_ptax
				select epd_ptax into :ld_Ptax  from fb_empptaxdeduction 
			  	where EPD_STATE_CODE = :gs_garden_state and 
				  		(nvl(:ld_fdconc,0) + nvl(:ld_totearn,0) + nvl(:ld_pf,0) + nvl(:ld_fpf,0)) between epd_startslab and epd_endslab and  EPD_DT_TO is null;
			  
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During PTAX Select ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 
				elseIf sqlca.sqlcode = 100 Then
					 ld_Ptax  = 0
				End If

				ld_totded = ld_totded + ld_Ptax 
				if isnull(ld_totearn) then ld_totearn=0
				
				///// lpg subsidy
				if (ld_totearn - ld_totded + ld_coinbf) > ld_lpg_subsidy_ded and ld_lpg_subsidy_ded > 0 then
					ld_totded = ld_totded + ld_lpg_subsidy_ded
					update fb_lpg_subsidy_mast set lsm_recovered_amt = :ld_lpg_subsidy_ded where emp_id = :ls_labour_id and lsm_issue_date = to_date(:ls_lpg_issue_dt, 'dd/mm/yyyy');
					if sqlca.sqlcode =-1 then
						messagebox('Error', 'Error occured while updating recovered amount in LPG Subsidy Master : '+sqlca.sqlerrtext )
						rollback using sqlca;
						return -1;
					end if
				else
					ld_lpg_subsidy_ded = 0
				end if
				////
				
				if ((ld_totearn - ld_totded + ld_coinbf) - ld_coincf)  >= ld_revst_range then
					ld_totded = ld_totded + ld_RevSt
				end if
				
				
				if (ld_totearn - ld_totded + ld_coinbf) < 0 then
					ld_coincf = ld_totearn - ld_totded + ld_coinbf
				else
					ld_coincf =  mod( (ld_totearn - ld_totded + ld_coinbf),ld_rnd_off)
				end if 
						
                  ld_netpayable = (ld_totearn - ld_totded + ld_coinbf) - ld_coincf
						
				if gs_garden_snm =  'SP' then
					ld_BPUJA2_IAMT = ld_coincf
					ld_coincf = 0
				end if						
			
				if isnull(ld_netpayable) or ld_netpayable < 0 then ld_netpayable = 0;
				
				 
				if gs_garden_snm <>  'MR' and  gs_garden_snm <> 'LP' and gs_garden_snm <> 'SP' and gs_garden_snm <> 'AB'  and gs_garden_snm <> 'AD'  and gs_garden_snm <> 'MH'  and gs_garden_snm <> 'DR' then
					insert into fb_labourweeklywages (labour_id,lww_id,labour_weekstatus,labour_hajiradays,labour_maternitydays,labour_sickdays,labour_wages,labour_maternityearn,labour_sickearn,labour_elpearn,
							labour_otherearn,labour_foodconc,labour_pf,labour_fpf,labour_lwf,labour_advance,labour_electricity,labour_ration,labour_coinbf,labour_netpayableamount,labour_lastcoinbf,labour_holidaypay,
							labour_ricewt,labour_attawt,LS_ID,labour_penalty,labour_wagadvance,labour_lip,labour_rd,labour_ptax,labour_revst,labour_koil,labour_electunits,
							labour_subsded,labour_pfadvanceded,labour_pfinterestded,labour_rationdays,labour_minor,labour_major,labour_elegrdedamt,LABOUR_ATTN_INC,LABOUR_ELECTADVANCEDED, LABOUR_MEDICALADVANCEDED, LABOUR_FESTIVALADVANCEDED, LABOUR_LPG_SUBS_DED)
					values(:ls_labour_id,:fs_lww_id,nvl(trim(:ls_emp_status),'A-A-A-A-A-A-O'),nvl(:ld_hajiradays,0),nvl(:ld_mdays,0),nvl(:ld_sickwagesdays ,0),nvl(:ld_hajiraearn,0),nvl(:ld_mwages,0),nvl(:ld_sickwages,0),nvl(:ld_elpearn,0),
							nvl(:ld_otherearn,0),nvl(:ld_fdconc,0),nvl(:ld_pf ,0),nvl(:ld_fpf,0),nvl(:ld_lwf,0),nvl(:ld_advance,0),nvl(:ld_electric,0),nvl(:ld_ration,0),nvl(:ld_coincf,0) ,nvl(:ld_netpayable,0),nvl(:ld_coinbf,0),nvl(:ld_holidaypay,0) ,
							nvl(:id_labricewt,0),nvl(:id_labattawt,0),:ll_payid,nvl(:ld_penalty,0),nvl(:ld_weekly_advance,0),nvl(:ld_nlip,0),nvl(:ld_nrd,0),nvl(:ld_Ptax,0),nvl(:ld_RevSt,0),nvl(:ld_nKoilAmo,0),nvl(:ld_nele_unit,0),
							nvl(:ld_subs ,0),nvl(:ld_pfadvded,0),nvl(:ld_pfintded,0),nvl(:ld_workdaysration,0),nvl(:id_no_lab_depminor,0) ,nvl(:id_no_lab_depmajor,0) ,nvl(:ll_edg_id,0),
							nvl(:ld_atinc_amt,0), nvl(:ld_electadvded,0), nvl(:ld_medadvded,0), nvl(:ld_festadvded,0), nvl(:ld_lpg_subsidy_ded, 0));
	
					if sqlca.sqlcode = -1 then
						messagebox('Sql Error : During Labour Wages Insert: ('+ls_labour_id+') ',sqlca.sqlerrtext); 
						rollback using sqlca; 
						return -1; 
					end if
				else
					insert into fb_labourweeklywages (labour_id,lww_id,labour_weekstatus,labour_hajiradays,labour_maternitydays,labour_sickdays,labour_wages,labour_maternityearn,labour_sickearn,labour_elpearn,
							labour_otherearn,labour_foodconc,labour_pf,labour_fpf,labour_lwf,labour_advance,labour_electricity,labour_ration,labour_coinbf,labour_netpayableamount,labour_lastcoinbf,labour_holidaypay,
							labour_ricewt,labour_attawt,LS_ID,labour_penalty,labour_wagadvance,labour_lip,labour_rd,labour_ptax,labour_revst,labour_koil,labour_electunits,
							labour_subsded,labour_pfadvanceded,labour_pfinterestded,labour_rationdays,labour_minor,labour_major,labour_elegrdedamt,LABOUR_ATTN_INC,
							ELECTRICDED2, ELECTRICDED3, ELECTRICDED4, ACMS01, BPUJA1, BPUJA2, BMASAN, CBME, CHURCH, COOPERATIVE, ICICI, PUJA1, PUJA2, PUJA3, PUJA4, PUJA5, MEDICAL,LABOUR_ELECTADVANCEDED, LABOUR_MEDICALADVANCEDED, LABOUR_FESTIVALADVANCEDED, LABOUR_LPG_SUBS_DED)
					values(:ls_labour_id,:fs_lww_id,nvl(trim(:ls_emp_status),'A-A-A-A-A-A-O'),nvl(:ld_hajiradays,0),nvl(:ld_mdays,0),nvl(:ld_sickwagesdays ,0),nvl(:ld_hajiraearn,0),nvl(:ld_mwages,0),nvl(:ld_sickwages,0),nvl(:ld_elpearn,0),
							nvl(:ld_otherearn,0),nvl(:ld_fdconc,0),nvl(:ld_pf ,0),nvl(:ld_fpf,0),nvl(:ld_lwf,0),nvl(:ld_advance,0),(nvl(:ld_electric,0) + nvl(:ld_ELECT1_IAMT,0)),nvl(:ld_ration,0),nvl(:ld_coincf,0) ,nvl(:ld_netpayable,0),nvl(:ld_coinbf,0),nvl(:ld_holidaypay,0) ,
							nvl(:id_labricewt,0),nvl(:id_labattawt,0),:ll_payid,nvl(:ld_penalty,0),nvl(:ld_weekly_advance,0),nvl(:ld_nlip,0),nvl(:ld_nrd,0),nvl(:ld_Ptax,0),nvl(:ld_RevSt,0),nvl(:ld_nKoilAmo,0),nvl(:ld_nele_unit,0),
							nvl(:ld_subs ,0),nvl(:ld_pfadvded,0),nvl(:ld_pfintded,0),nvl(:ld_workdaysration,0),nvl(:id_no_lab_depminor,0) ,nvl(:id_no_lab_depmajor,0) ,nvl(:ll_edg_id,0),
							nvl(:ld_atinc_amt,0),nvl(:ld_ELECT2_IAMT,0) ,nvl(:ld_ELECT3_IAMT,0),nvl(:ld_ELECT4_IAMT,0),nvl(:ld_ACMS01_IAMT,0),nvl(:ld_BPUJA1_IAMT,0),nvl(:ld_BPUJA2_IAMT,0),
							nvl(:ld_BMASAN_IAMT,0), nvl(:ld_CBME_IAMT,0), nvl(:ld_CHURCH_IAMT,0), nvl(:ld_copr_amt,0), nvl(:ld_ICICI_IAMT,0), nvl(:ld_PUJA1_IAMT,0), nvl(:ld_PUJA2_IAMT,0), nvl(:ld_PUJA3_IAMT,0), nvl(:ld_PUJA4_IAMT,0),
							nvl(:ld_PUJA5_IAMT,0), nvl(:ld_MEDICAL_IAMT,0), nvl(:ld_electadvded,0), nvl(:ld_medadvded,0), nvl(:ld_festadvded,0), nvl(:ld_lpg_subsidy_ded, 0));
	
					if sqlca.sqlcode = -1 then
						messagebox('Sql Error : During Labour Wages Insert: ('+ls_labour_id+') ',sqlca.sqlerrtext); 
						rollback using sqlca; 
						return -1; 
					end if					
				end if
			
			
			
			if(ld_excesswage>0) then				
				select nvl(last_lwwid,''),nvl(last_dedamt,0) into :ls_lwwid_excess,:ld_last_dedamt from fb_labourexcesswagesded where labour_id=:ls_labour_id;
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Advance Select : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 
				elseif sqlca.sqlcode =100 then
					ls_lwwid_excess='';ld_last_dedamt =0;
				end if;
				
				if(ls_lwwid_excess=fs_lww_id) then
					update fb_labourexcesswagesded set TOTDED_AMOUNT=TOTDED_AMOUNT-:ld_last_dedamt where labour_id=:ls_labour_id and nvl(LEWD_STOPIND,'N')='N';
						if sqlca.sqlcode = -1 then
							messagebox('Sql Error : During Labour Excess Amount Updation of reprocess: ('+ls_labour_id+') ',sqlca.sqlerrtext); 
							rollback using sqlca; 
							return -1; 
						end if	
				end if
					update fb_labourexcesswagesded set TOTDED_AMOUNT=TOTDED_AMOUNT+:ld_excesswage,LAST_UPDATE_DT=sysdate,last_lwwid=:fs_lww_id,last_dedamt=:ld_excesswage where labour_id=:ls_labour_id and nvl(LEWD_STOPIND,'N')='N';
						if sqlca.sqlcode = -1 then
							messagebox('Sql Error : During Labour Excess Amount Updation: ('+ls_labour_id+') ',sqlca.sqlerrtext); 
							rollback using sqlca; 
							return -1; 
						end if						
			end if

			setnull(ls_labour_id);setnull(ls_emp_status);	setnull(ls_emp_sex);setnull(ls_emp_type);setnull(ls_emp_marital);setnull(ls_electricflag);
			setnull(ls_pfno);setnull(ls_pfdedcode);setnull(ls_FIELD_ID);setnull(ls_fortnightration)
			ld_mdays= 0; ld_sickdays= 0; ld_sickwagesdays= 0; ld_hajiradays= 0; ld_withpaydays= 0; ld_workdaysration= 0; ll_edg_id=0;
			ld_mwages= 0; ld_sickwages= 0; ld_holidaypay= 0; ld_hajiraearn= 0; ld_otherearn= 0; ld_elpearn= 0;  ld_totearn= 0; ld_dedgroup=0;ld_fdconc=0
			ld_pf = 0;ld_fpf = 0;ld_lwf=0; ll_payid=0;ld_coinbf=0;ld_coincf=0;ld_netpayable=0;
			ld_electric =0; ld_ration =0;ld_advance =0;ld_subs  =0;ld_pfadvded  =0;ld_pfintded =0;ld_half_hajira=0;ld_w2_half_hajira=0;  ld_nlip = 0;
			ld_atinc_amt=0;ld_atinc_rt=0;ld_atinc_days=0;ld_atinc_w2days=0;ld_atinc_mindays=0; setnull(ls_atinc_pfind);setnull(ls_atinc_range)
			ld_lwf = fd_lwf ; ld_subs = fd_subs ;  ld_electadvded = 0; ld_medadvded = 0; ld_festadvded = 0; ld_lpg_subsidy_ded = 0;ld_excesswage=0;

	fetch c1 into :ls_labour_id,:ld_mdays,:ld_mwages,:ld_sickdays,:ld_sickwages,:ld_sickwagesdays,:ld_holidaypay,:ld_hajiradays,:ld_hajiraearn,
				    :ld_otherearn,:ld_withpaydays,:ld_workdaysration,:ld_elpearn,:ld_totearn,
				    :ls_emp_status,	:ls_emp_sex,:ls_emp_type,:ls_emp_marital,:ls_electricflag,:ll_edg_id,:ls_pfno,:ls_pfdedcode,:ld_dedgroup,
				    :ls_FIELD_ID,:LS_LWFFLAG,:LS_SUBSFLAG,:ll_payid,:ls_fortnightration,
					:ld_atinc_rt,:ld_atinc_days,:ld_atinc_w2days,:ls_atinc_range,:ld_atinc_mindays,:ls_atinc_pfind,:ld_half_hajira,:ld_w2_half_hajira,:ld_nlip;
					 
	loop;
	close c1;
end if;			

	w_mdi.setmicrohelp('Wages Calculation Completed ....!')

if (fd_lwf + fd_subs) > 0 then
	update fb_labourwagesweek set lww_rice=:id_totricequan,lww_atta=:id_totattaquan,lww_paycalflag='1',lww_lwfflag='1' where lww_id=:fs_lww_id;
else
	update fb_labourwagesweek set lww_rice=:id_totricequan,lww_atta=:id_totattaquan,lww_paycalflag='1',lww_lwfflag='0' where lww_id=:fs_lww_id;
end if

if sqlca.sqlcode = -1 then
	messagebox('Sql Error : During Labour Wage Week (Update) ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
end if

update fb_rationperiodforweek set RPFW_PAIDFLAG ='1' where RPFW_CALFLAG ='1' and RPFW_LWW_ID = :fs_lww_id;

if sqlca.sqlcode = -1 then
	messagebox('Sql Error : During Labour Wage Week (Update) ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
end if

update fb_labourexcesswagesded set lewd_stopind='N';
if sqlca.sqlcode = -1 then
	messagebox('Sql Error : During Excess Wages Indicator Update ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
end if

////delete from fb_rationfortnightsheet where rpfw_id = (select rpfw_id from fb_rationperiodforweek rpfw where rpfw_lww_id=:fs_lww_id);
////
////if sqlca.sqlcode = -1 then
////	messagebox('Sql Error : During Fortnight Wages sheet (Delete)',sqlca.sqlerrtext); 
////	rollback using sqlca; 
////	return -1; 
////end if
////
////insert into fb_rationfortnightsheet  (rpfw_id,ls_id) 
////select distinct RPFW_ID,ls_id from 
////	(select RPFW_ID from fb_rationperiodforweek where rpfw_lww_id=:fs_lww_id),
////	(select ls_id from fb_laboursheet where LS_FORTNIGHTRATION='1');
////
////if sqlca.sqlcode = -1 then
////	messagebox('Sql Error : During Fortnight Wages sheet (Insert)',sqlca.sqlerrtext); 
////	rollback using sqlca; 
////	return -1; 
////end if

//if wf_substaffration(fs_lww_id,fs_st_dt) = -1 then
//	rollback using sqlca; 
//	return -1; 
//end if

commit using sqlca;		
	w_mdi.setmicrohelp('Ready ....!')

return 1;	

end function

public function integer wf_wagecal (string fs_st_dt, double fd_lwf, double fd_subs);string fs_lww_id,ls_temp,ls_labour_id,ls_emp_status,ls_emp_sex,ls_emp_type,ls_emp_marital,ls_electricflag,ls_pfno,ls_pfdedcode,ls_FIELD_ID,LS_LWFFLAG,LS_SUBSFLAG,ls_fortnightration, ls_lpg_issue_dt
long ll_edg_id,ll_payid,ll_adoleage,ll_weekstatus,ll_nodays
double ld_mdays,ld_sickdays,ld_sickwagesdays,ld_hajiradays,ld_withpaydays,ld_workdaysration,ld_mwages,ld_sickwages,ld_holidaypay,ld_hajiraearn,ld_otherearn,ld_elpearn,ld_totearn,ld_dedgroup,ld_fdconc
double ld_pf,ld_fpf,ld_coinbf,ld_coincf,ld_netpayable,ld_nelpearn,ld_pm_elp,ld_pm_penalty
double ld_rnd_off,ld_tpf_rt,ld_pf_rt,ld_fpf_rt,ld_revst_range,ld_revst,ld_fdconc_rt,ld_penalty,ld_weekly_advance,ld_Ptax,ld_revst_ded
double ld_nlip,ld_nele,ld_nele_unit,ld_nlwf,ld_nrd,ld_nKoilAmo,ld_nadvance
double ld_First_days,ld_ration,ld_totded,ld_lwf,ld_subs,ld_electric,ld_advance,ld_pfadvded,ld_pfintded, ld_electadvded, ld_medadvded, ld_festadvded, ld_lpg_subsidy_ded
double ld_atinc_rt,ld_atinc_days,ld_atinc_mindays,ld_atinc_amt,ld_atinc_w2days,ld_half_hajira,ld_w2_half_hajira,ld_rcamt,ld_rationcomp,ld_pffpf_rnd_off, ld_brationwt,ld_brationamt
string ls_atinc_range,ls_atinc_pfind
 
id_totricequan=0; id_totattaquan=0;ll_nodays=0;ll_weekstatus=0;ld_pm_elp = 0; ld_pm_penalty = 0
 

	select lww_id,((LWW_ENDDATE - LWW_STARTDATE) + 1) into :fs_lww_id,:ll_nodays
	from fb_labourwagesweek  
	where lww_startdate= to_date(:fs_st_dt,'dd/mm/yyyy') and lww_paidflag='0';
	
	if sqlca.sqlcode =100 then
		messagebox('Wages Week Select ','Either the there is no such week or the wages against this week has been paid, Please Check...!')
		return -1
	elseif sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Wages Week Select ',sqlca.sqlerrtext)
		return -1
	end if;
	
	select distinct 'x' into :ls_temp from fb_labourrationchart
	 where to_date(:fs_st_dt,'dd/mm/yyyy')  between LRC_FRDT and nvl(LRC_TODT,trunc(sysdate));
	
	if sqlca.sqlcode =100 then
		messagebox('Ration Chart checking','The Ration Chart has not been prepared Please Check...!')
		return -1
	elseif sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Ration Chart checking ',sqlca.sqlerrtext)
		return -1
	end if;

	select distinct 'x' into :ls_temp from fb_rationperiodforweek where RPFW_LWW_ID =  :fs_lww_id and RPFW_CALFLAG='0';
	
	if sqlca.sqlcode =0 then
		messagebox('Ration Chart checking','The Ration Against this Period has not been paid. First pay the ration for this period, Please Check...!')
		return -1
	elseif sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Ration Payment checking ',sqlca.sqlerrtext)
		return -1
	end if;
	
	if gs_garden_snm='MT' then
		
		select distinct 'x' into :ls_temp from fb_labourwagadvweek where LWW_ID =  :fs_lww_id and LWAW_PAIDFLAG='0';
		
		if sqlca.sqlcode =0 then
			messagebox('Weekly Advance checking','The Weekly Advance Against this Period has not been paid. First pay the Weekly Advance for this period, Please Check...!')
			return -1
		elseif sqlca.sqlcode = -1 then
			messagebox('SQL ERROR: During Weekly Advance Payment checking ',sqlca.sqlerrtext)
			return -1
		end if;
		
	end if	
	
	select max(length(LWS_STATUS)) into :ll_weekstatus from fb_labourweeklystatus where LWW_ID = :fs_lww_id;
	
	if sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Attendance Status checking ',sqlca.sqlerrtext)
		return -1
	end if;
	
	if isnull(ll_weekstatus) then ll_weekstatus=0
	
	w_mdi.setmicrohelp('Calculation of Week Status is Going on ....!')
//	if gs_garden_snm <> 'KG' then
		if ((ll_nodays * 2) <> (ll_weekstatus +1)) then
			IF WF_UPD_WEEKLY_STATUS(fs_lww_id) = -1 THEN
				return -1
			end if
		end if
//	else
//		if ((ll_nodays) <> (ll_weekstatus +1)) then
//			IF WF_UPD_WEEKLY_STATUS(fs_lww_id) = -1 THEN
//				return -1
//			end if
//		end if		
//	end if
	w_mdi.setmicrohelp('Calculation of Week Status is Completed  ....!')
	
	select sum(decode(pd_doc_type,'FOODCOMP',pd_value,0)) ,
			sum(decode(pd_doc_type,'ROUNDOFF',pd_value,0)),
			sum(decode(pd_doc_type,'PFFPFROUND',pd_value,0)),
			sum(decode(pd_doc_type,'PFFPFRT',decode(pd_code,'1',pd_value,0),0)),
			sum(decode(pd_doc_type,'PFFPFRT',decode(pd_code,'2',pd_value,0),0)),
			sum(decode(pd_doc_type,'PFFPFRT',decode(pd_code,'3',pd_value,0),0)),
			sum(decode(pd_doc_type,'REVSTAMP',decode(pd_code,'1',pd_value,0),0)),
			sum(decode(pd_doc_type,'REVSTAMP',decode(pd_code,'2',pd_value,0),0)),
			sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0))
	into :ld_fdconc_rt,:ld_rnd_off,:ld_pffpf_rnd_off,:ld_tpf_rt,:ld_pf_rt,:ld_fpf_rt,:ld_revst_range,:ld_revst,:ll_adoleage
	from fb_param_detail 
	where pd_doc_type in ('ROUNDOFF','FOODCOMP','PFFPFRT','REVSTAMP','ADOLEAGE','PFFPFROUND') and
			to_date(:fs_st_dt,'dd/mm/yyyy') between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));

	if sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
		return -1
	end if;
	
	if isnull(ld_fdconc_rt) then ld_fdconc_rt=0
	if isnull(ld_rnd_off) then ld_rnd_off=0
	if isnull(ld_tpf_rt) then ld_tpf_rt=0
	if isnull(ld_pf_rt) then ld_pf_rt=0
	if isnull(ld_fpf_rt) then ld_fpf_rt=0
	if isnull(ld_revst_range) then ld_revst_range=0
	if isnull(ld_revst) then ld_revst=0
	if isnull(ll_adoleage) then ll_adoleage=0
	if isnull(ld_pffpf_rnd_off) then ld_pffpf_rnd_off = 0
	
declare c1 cursor for 
	 select emp.emp_id,mdays,mwages,sickdays,sickwages,sickwagesdays,holidaypay,hajiradays,hajiraearn,otherearn,withpaydays,workdaysration,elpearn,penalty,totearn,
			  lws.lws_status weekstatus,emp.emp_sex emp_sex,trim(emp.emp_type) emp_type,emp_marital,emp.emp_elect electricflag,
			  emp.edg_id edg_id,emp.emp_pfno pfno,emp_pfdedcode pfdedcode,nvl(edg.edg_electricded,0) dedgroup,
			  ls.FIELD_ID,ls.LS_LWFFLAG,ls.LS_SUBSFLAG,emp.ls_id,ls.ls_fortnightration,
			  nvl(decode(sign(get_diff(to_date(:fs_st_dt,'dd/mm/yyyy'),EMP_DOB,'B') - :ll_adoleage),1,AI_RATEADULT,AI_RATEADOLE),0) atinc_rt,//(((to_date(:fs_st_dt,'dd/mm/yyyy') - EMP_DOB)/365))
			  ((nvl(fullhajiradays,0) - nvl(susdays,0) - decode(AI_LEAVEWITHWAGES,'N',nvl(lwwdays,0),0) - decode(:gs_garden_snm,'UB',nvl(lwwdays,0) ,0) ) + decode(AI_SICKWITHWAGES,'Y',nvl(sickwagesdays,0),0) +
				 decode(AI_MATERNITY,'Y',nvl(mdays,0),0) +  decode(AI_HOLIDAY,'Y',nvl(holidaypayday,0),0)) atinc_days,
				0 ,
			  nvl(AI_RATERANGE,'N'), nvl(AI_MINDAYS,0),nvl(AI_PFELIGIBLE,'N'),
			  nvl(halfhajiradays,0),0, nvl(emp_lip,0) lip, nvl(emp_rd,0) rd
		from (select lda.lww_id lwwid,lda.labour_id labourid,
							  sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',1,0)) mdays,
							  sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',lda_wages,0)) mwages,
							  sum(decode(trim(kam.kamsub_nkamtype),'SICKALLOWANCE',1,'SICKNOWAGES',lda_status,0)) sickdays,
							  sum(decode(trim(kam.kamsub_nkamtype),'SICKALLOWANCE',lda_wages,'SICKNOWAGES',lda_wages,0)) sickwages,
							  sum(decode(trim(kam.kamsub_nkamtype),'SICKALLOWANCE',decode(nvl(lda_wages,0),0,0,1),'SICKNOWAGES',decode(nvl(lda_wages,0),0,0,lda_status),0)) sickwagesdays,
							  sum(decode(trim(kam.kamsub_nkamtype),'HOLIDAYPAY',lda_wages,0)) holidaypay,
							  sum(decode(trim(kam.kamsub_nkamtype),'HOLIDAYPAY',1,0)) holidaypayday,
							  sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',nvl(lda_status,0),0)) hajiradays,
							  sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',nvl(lda_wages,0),(nvl(lda_wages,0)-nvl(lda_elp,0))),0)) hajiraearn,
							  sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',0,'SICKALLOWANCE',0,'SICKNOWAGES',0,'OTHERS',0,lda_wages)) otherearn,
							  sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',decode(nvl(lda_wages,0),0,0,lda_status),'SICKALLOWANCE',decode(nvl(lda_wages,0),0,0,lda_status),'SICKNOWAGES',decode(nvl(lda_wages,0),0,0,lda_status),'OTHERS',decode(nvl(lda_wages,0),0,0,lda_status),decode(nvl(lda_wages,0),0,0,lda_status) )) withpaydays,
							  sum(decode(trim(kam.kamsub_nkamtype),'MATERNITY',decode(nvl(lda_wages,0),0,0,lda_status),'SICKALLOWANCE',lda_status,'SICKNOWAGES',lda_status,'OTHERS',decode(nvl(lda_wages,0),0,0,lda_status),decode(nvl(lda_wages,0),0,0,lda_status))) workdaysration,
							  sum(decode(:gs_garden_snm,'MT',decode(sign(nvl(lda_elp,0)-1),-1,0,nvl(lda_elp,0)),nvl(lda_elp,0))) elpearn,
							  sum(decode(:gs_garden_snm,'MT',decode(sign(nvl(lda_elp,0)-1),-1,nvl(lda_elp,0) * -1,0),0)) penalty,
							  sum(decode(nvl(LDA_ENTRY_BY,'ADMIN'),'ADMIN',(nvl(lda_wages,0)+nvl(lda_elp,0)),nvl(lda_wages,0))) totearn,
							  sum(decode(trim(KAMSUB_NAME),'LWW',1,0)) lwwdays,
							  sum(decode(trim(KAMSUB_NAME),'SUS',nvl(lda_status,0),0)) susdays,
							  sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',decode(lda_status,1,1,0),0)) fullhajiradays,
							  sum(decode(trim(kam.kamsub_nkamtype),'OTHERS',decode(to_number(lda_status),0.5,1,0.25,1,0.75,1,0),0)) halfhajiradays
				 from fb_labourdailyattendance lda,fb_kamsubhead kam 
				where lda.kamsub_id=kam.kamsub_id  and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and lda.lww_id= :fs_lww_id
				group by lda.lww_id,lda.labour_id) lkw,
				fb_labourweeklystatus lws,fb_employee emp,fb_electricdedgroup edg,
				fb_laboursheet ls,
				(select AI_LABOURTYPE,AI_RATERANGE,AI_RATEADULT,AI_RATEADOLE,AI_MINDAYS, AI_SICKWITHWAGES, AI_HOLIDAY, AI_MATERNITY, AI_LEAVEWITHWAGES, AI_PFELIGIBLE
					from fb_attendanceincentive
				 where to_date(:fs_st_dt,'dd/mm/yyyy') between AI_FROMDT and nvl(AI_TODT,trunc(sysdate)) )
	  where emp.emp_id=lkw.labourid(+) and emp.edg_id=edg.edg_id(+) and 
					 lkw.lwwid=lws.lww_id(+) and lkw.labourid=lws.labour_id(+) and 
					 lkw.lwwid=:fs_lww_id and emp.ls_id = ls.ls_id(+) and
					emp.emp_type = AI_LABOURTYPE(+); // and emp_id= 'LA00010' ;
		 
open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else 

	setnull(ls_labour_id);setnull(ls_emp_status);	setnull(ls_emp_sex);setnull(ls_emp_type);setnull(ls_emp_marital);setnull(ls_electricflag);
	setnull(ls_pfno);setnull(ls_pfdedcode);setnull(ls_FIELD_ID);
	ld_mdays= 0; ld_sickdays= 0; ld_sickwagesdays= 0; ld_hajiradays= 0; ld_withpaydays= 0; ld_workdaysration= 0; ll_edg_id=0;
	ld_mwages= 0; ld_sickwages= 0; ld_holidaypay= 0; ld_hajiraearn= 0; ld_otherearn= 0; ld_elpearn= 0; ld_totearn= 0; ld_dedgroup=0;ld_fdconc=0
	ld_pf = 0;ld_fpf = 0;ll_payid=0;ld_coinbf=0;ld_coincf=0;ld_netpayable=0;ld_nlip = 0;ld_nrd = 0;ld_revst_ded=0
	ld_atinc_amt=0;ld_atinc_rt=0;ld_atinc_days=0;ld_atinc_w2days=0;ld_atinc_mindays=0;ld_half_hajira=0;ld_w2_half_hajira=0
	setnull(ls_atinc_pfind);setnull(ls_atinc_range)

	ld_lwf = fd_lwf ; ld_subs = fd_subs

	fetch c1 into :ls_labour_id,:ld_mdays,:ld_mwages,:ld_sickdays,:ld_sickwages,:ld_sickwagesdays,:ld_holidaypay,:ld_hajiradays,:ld_hajiraearn,
				    :ld_otherearn,:ld_withpaydays,:ld_workdaysration,:ld_elpearn,:ld_penalty,:ld_totearn,
				    :ls_emp_status,	:ls_emp_sex,:ls_emp_type,:ls_emp_marital,:ls_electricflag,:ll_edg_id,:ls_pfno,:ls_pfdedcode,:ld_dedgroup,
				    :ls_FIELD_ID,:LS_LWFFLAG,:LS_SUBSFLAG,:ll_payid,:ls_fortnightration,
					:ld_atinc_rt,:ld_atinc_days,:ld_atinc_w2days,:ls_atinc_range,:ld_atinc_mindays,:ls_atinc_pfind,:ld_half_hajira,:ld_w2_half_hajira,:ld_nlip,:ld_nrd;

	do while sqlca.sqlcode <> 100 

	w_mdi.setmicrohelp('Calculation of Wages For Labour ID '+ls_labour_id+'  Is going on  ....!')
		
//			if ls_electricflag ='YES' then r
//				ll_edg_id
//			end if
//			   To Be Check the below logic

//				if ls_fortnightration = '1' then
//					ld_First_days = wf_fortnight_firstweek_workdays(fs_lww_id,ls_labour_id,fs_st_dt)
//
//					If ld_First_days > 0 Then
//						ld_workdaysration = ld_workdaysration + ld_First_days
//					End If
//				end if

				if ld_atinc_rt > 0 then
					if gs_garden_snm='UB' then  //// change 30.11.2012
						if ld_atinc_mindays <= (ld_atinc_days + ld_half_hajira) then
							ld_atinc_days = round((ld_atinc_days + ld_half_hajira),0)
							if ls_atinc_range ='W' then
								ld_atinc_amt = ld_atinc_rt
							else
	//							if ld_atinc_days > 6 then
	//							   ld_atinc_days = 6
	//							end if
								ld_atinc_amt = ld_atinc_days * ld_atinc_rt
							end if
						end if
					elseif gs_garden_snm='KG' then   //// change 19.08.2015
						ld_atinc_days = 0
						if left(ls_emp_status,11) = 'F-F-F-F-F-F' or left(ls_emp_status,11) = 'F-F-F-F-F-O' then	//'F-F-F-F-F-F-o-F-F-F-F-F-O-A'
							ld_atinc_days = 6
						elseif left(ls_emp_status,9) = 'F-F-F-F-F' or mid(ls_emp_status,3,9) = 'F-F-F-F-F' then
							ld_atinc_days = 5
						else
							ld_atinc_days = 0
						end if
						
						if mid(ls_emp_status,15,11) = 'F-F-F-F-F-F' or mid(ls_emp_status,15,11) = 'F-F-F-F-F-O' or mid(ls_emp_status,15,11) = 'F-F-O-F-F-F' then	//'F-F-F-F-F-F-o-F-F-F-F-F-O-A'
							ld_atinc_days = ld_atinc_days + 6
						elseif mid(ls_emp_status,15,9) = 'F-F-F-F-F' or mid(ls_emp_status,17,9) = 'F-F-F-F-F' or mid(ls_emp_status,17,9) = 'F-F-F-F-O' or mid(ls_emp_status,17,9) = 'F-F-O-F-F' then
							ld_atinc_days = ld_atinc_days + 5
						else
							ld_atinc_days = ld_atinc_days + 0
						end if
						
						if ld_atinc_mindays <= ld_atinc_days then
							ld_atinc_days = round((ld_atinc_days + ld_half_hajira),0)
							if ls_atinc_range ='W' then
								ld_atinc_amt = ld_atinc_rt
							else
	//							if ld_atinc_days > 6 then
	//							   ld_atinc_days = 6
	//							end if
								ld_atinc_amt = ld_atinc_days * ld_atinc_rt
							end if
						end if					
					else  //// change 30.11.2012
						if ld_atinc_mindays <= ld_atinc_days then
							ld_atinc_days = round((ld_atinc_days + ld_half_hajira),0)
							if ls_atinc_range ='W' then
								ld_atinc_amt = ld_atinc_rt
							else
	//							if ld_atinc_days > 6 then
	//							   ld_atinc_days = 6
	//							end if
								ld_atinc_amt = ld_atinc_days * ld_atinc_rt
							end if
						end if
					end if  //// change 30.11.2012
					if isnull(ld_atinc_amt) then ld_atinc_amt=0
					if ld_atinc_w2days > 0 then		// For Second week
						if ld_atinc_mindays <= ld_atinc_w2days then
							ld_atinc_w2days = round((ld_atinc_w2days + ld_w2_half_hajira),0)
							if ls_atinc_range ='W' then
								ld_atinc_amt = ld_atinc_amt + ld_atinc_rt
							else
//								if ld_atinc_w2days > 6 then
//							  	   ld_atinc_w2days = 6
//								end if
								ld_atinc_amt = ld_atinc_amt + (ld_atinc_w2days * ld_atinc_rt)
							end if	
						end if	
					end if
					if gs_garden_snm = 'JP' and ll_payid = 9 then
						ld_atinc_amt = 0
					end if
					ld_totearn = ld_totearn + ld_atinc_amt
				end if
						
				
				if LS_LWFFLAG="0" then 
					ld_lwf = 0
				else
					if ld_withpaydays < 3 then
						ld_lwf = 0
					end if
				end if
				
				if LS_SUBSFLAG = "0" then
					ld_subs = 0
				end if
				
				if ld_totearn <= 0 then ld_lwf = 0
				if ld_totearn <= 0 then ld_subs = 0
				
////			Ration 

		if gs_garden_snm='MT' then

			select sum(nvl(lwr_rationded,0)) rationded,sum(nvl(lwr_ricewt,0)) ricewt,sum(nvl(lwr_attawt,0)),sum(LWR_NOMIN),sum(LWR_NOMAJ)
				 into :ld_ration,:id_labricewt,:id_labattawt,:id_no_lab_depminor,:id_no_lab_depmajor
				from fb_labourweeklyration
			  where labour_id = :ls_labour_id and lrw_id in (select RPFW_ID from fb_rationperiodforweek 
			  												where RPFW_CALFLAG ='1' and RPFW_PAIDFLAG ='1' and RPFW_LWW_ID = :fs_lww_id);
			  
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Ration (Select ): ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			end if;
			
//			ld_brationwt = (35 - (id_labattawt + id_labricewt))
//			ld_brationamt = (35 - (id_labattawt + id_labricewt)) * 2
//			
//			if (id_labattawt + id_labricewt) > 35 then
//				ld_ration = 35 * 0.40
//			else
//				ld_ration = ld_ration + ld_brationamt
//			end if

			if isnull(ld_ration) then ld_ration = 0;
			if isnull(id_labricewt) then id_labricewt = 0;
			if isnull(id_labattawt) then id_labattawt = 0;
			
			if ld_ration > 0 then
				ld_brationwt = (35 - (id_labattawt + id_labricewt))
				ld_brationamt = (35 - (id_labattawt + id_labricewt)) * 2
			else
				ld_brationwt = 0
				ld_brationamt = 0
			end if
			
			if isnull(ld_brationwt) then ld_brationwt = 0;
			if isnull(ld_brationamt) then ld_brationamt = 0;			
			
			if (id_labattawt + id_labricewt) > 35 then
				ld_ration = 35 * 0.40
			else
				ld_ration = ld_ration + ld_brationamt
			end if
			
			

			update fb_labourweeklyration set LWR_BALRATION_WT = :ld_brationwt, LWR_BALRATION_TDED = :ld_brationamt
			where (labour_id ,lrw_id) in (select labour_id , max(lrw_id) from fb_labourweeklyration
													where labour_id = :ls_labour_id and lrw_id in (select RPFW_ID from fb_rationperiodforweek where RPFW_CALFLAG ='1' and RPFW_PAIDFLAG ='1' and RPFW_LWW_ID = :fs_lww_id)                                                           
																												 group by labour_id);
													
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Balance RAtion Update: ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			end if;
													
			if right(fs_st_dt,4) + mid(fs_st_dt,4,2) = '201208' then
				
				select sum(decode(sign(nvl(lda_elp,0)-1),-1,0,nvl(lda_elp,0))) elpearn,
						sum(decode(sign(nvl(lda_elp,0)-1),-1,nvl(lda_elp,0) * -1,0)) penalty		
					 into :ld_pm_elp,:ld_pm_penalty
					from fb_labourdailyattendance
				  where labour_id = :ls_labour_id and trunc(lda_date) between to_date('30/07/2012','dd/mm/yyyy') and to_date('31/07/2012','dd/mm/yyyy');
				  
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Ration (Select extra elp): ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 
				end if;
				if isnull(ld_pm_elp) then ld_pm_elp = 0;
				if isnull(ld_pm_penalty) then ld_pm_penalty = 0;
				
				ld_totearn = ld_totearn + ld_pm_elp - ld_pm_penalty
				ld_elpearn = ld_elpearn + ld_pm_elp
				ld_penalty = ld_penalty + ld_pm_penalty
				
			end if	
		else
			select sum(nvl(lwr_rationded,0)) rationded,sum(nvl(lwr_ricewt,0)) ricewt,sum(nvl(lwr_attawt,0)),sum(LWR_NOMIN),sum(LWR_NOMAJ)
				 into :ld_ration,:id_labricewt,:id_labattawt,:id_no_lab_depminor,:id_no_lab_depmajor
				from fb_labourweeklyration
			  where labour_id = :ls_labour_id and lrw_id in (select RPFW_ID from fb_rationperiodforweek where RPFW_CALFLAG ='1' and RPFW_LWW_ID = :fs_lww_id);
			  
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Ration (Select ): ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			end if;
		end if			
			
			if isnull(ld_penalty) then ld_penalty=0
	if gs_garden_snm='MT' then

			select sum(nvl(lwaw_advance,0)) rationded into :ld_weekly_advance
				from fb_labourwagadvweek lwaw,fb_labourweeklyadvance lwadv
				where lwaw.lwaw_id=lwadv.lwaw_id and lwaw.lww_id=:fs_lww_id and labour_id = :ls_labour_id ;
			  
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Weekly Advance (Select ): ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			end if;
			if ls_emp_type = 'LP' then
				select round(nvl(ki_rate,0) * nvl(ki_quantity,0),2) into :ld_nKoilAmo
				  from fb_kerosinissue
				 where ki_yearmonth =  to_number(to_char(to_date(:fs_st_dt,'dd/mm/yyyy'),'yyyymm'));
						  
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During KOIL (Dedn): ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 
				end if;
			else
				ld_nKoilAmo = 0
			end if 
			if isnull(ld_nKoilAmo) then ld_nKoilAmo = 0;
		end if

			select advanceded,pfadvanceded,pfinterestded,electricded,elecadvded, medadvded, festadvded  into :ld_advance,:ld_pfadvded,:ld_pfintded,:ld_electric, :ld_electadvded, :ld_medadvded, :ld_festadvded
			from fb_labadvancededuction where labour_id=:ls_labour_id and lww_id=:fs_lww_id;
			
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Advance Select : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			elseif sqlca.sqlcode =100 then
				 ld_advance=0;ld_pfadvded=0;ld_pfintded=0;ld_electric=0; ld_electadvded = 0; ld_medadvded = 0; ld_festadvded = 0;
			end if;
			
			select lsm_subs_amount, to_char(lsm_issue_date, 'dd/mm/yyyy') into :ld_lpg_subsidy_ded, :ls_lpg_issue_dt from fb_lpg_subsidy_mast where emp_id = :ls_labour_id and lsm_subs_amount - nvl(lsm_recovered_amt, 0) > 0
			and lsm_issue_Date = (select min(lsm_issue_date) from  fb_lpg_subsidy_mast where emp_id = :ls_labour_id and lsm_subs_amount - nvl(lsm_recovered_amt, 0) > 0 );
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Getting LPG Subsidy Deduction Amt. : ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 		
			elseif sqlca.sqlcode = 100 then
				ld_lpg_subsidy_ded = 0;
			end if
			
			/*		If ls_emp_type = "LP" Then 
						If Round((ld_withpaydays), 0) >= 7 And ld_mdays > 0 Then
							ld_fdconc = Round(ld_fdconc_rt * 6, 2) 
						Else
							ld_fdconc = Round(ld_fdconc_rt * round((ld_withpaydays), 0), 2)
						End If
					Else
						ld_fdconc = 0
					End If*/

		// PF Deduction
					If len(trim(ls_pfno)) > 0 and (ls_pfdedcode ='1' or ls_pfdedcode ='2' ) Then
						
							select distinct 'x' into :ls_temp from fb_exemptmaster
								where EM_LSID = :ll_payid and EM_PFIND= 'Y' and to_date(:fs_st_dt,'dd/mm/yyyy') between EM_FROMDT and nvl(EM_TODT,trunc(sysdate));
								
							if sqlca.sqlcode = -1 then
								messagebox('Sql Error : During Exampt PF Select : ',sqlca.sqlerrtext); 
								rollback using sqlca; 
								return -1; 
							elseif sqlca.sqlcode =0 then	
								ld_pf = 0
								ld_fpf = 0
							else
								
							// Food Compensation 
								If Round((ld_withpaydays), 0) >= 7 And ld_mdays > 0 Then
									ld_fdconc = Round(ld_fdconc_rt * 6, 2) 
								Else
									ld_fdconc = Round(ld_fdconc_rt * round((ld_withpaydays), 0), 2)
								End If

								if ls_atinc_pfind ='N' then		// If PF Applicable in Attendance Incentive
									 If ls_pfdedcode = '1' Then 
										  ld_pf = Round(ld_tpf_rt * (ld_totearn + ld_fdconc - ld_atinc_amt ) / 100, ld_pffpf_rnd_off)
										  ld_fpf = 0
									 Else
										  ld_fpf = Round(ld_fpf_rt * (ld_totearn + ld_fdconc - ld_atinc_amt ) / 100, ld_pffpf_rnd_off)
										  ld_pf = Round((ld_fpf_rt + ld_pf_rt) * (ld_totearn + ld_fdconc) / 100,ld_pffpf_rnd_off) - ld_fpf
									 End If 
								else
									 If ls_pfdedcode = '1' Then 
										  ld_pf = Round(ld_tpf_rt * (ld_totearn + ld_fdconc) / 100,ld_pffpf_rnd_off)
										  ld_fpf = 0
									 Else
										  ld_fpf = Round(ld_fpf_rt * (ld_totearn + ld_fdconc) / 100,ld_pffpf_rnd_off)
										  ld_pf = Round((ld_fpf_rt + ld_pf_rt) * (ld_totearn + ld_fdconc) / 100,ld_pffpf_rnd_off) - ld_fpf
									 End If 
								end if
							end if
					Else
						ld_pf = 0
						ld_fpf = 0
					End If		

					if isnull(ld_pf) then ld_pf=0
					if isnull(ld_fpf) then ld_fpf=0
					if isnull(ld_nele) then ld_nele=0
					if isnull(ld_electric) then ld_electric=0
					if isnull(ld_ration) then ld_ration=0
					if isnull(ld_nadvance) then ld_nadvance=0
					if isnull(ld_advance) then ld_advance=0
					if isnull(ld_lwf) then ld_lwf=0
					if isnull(ld_weekly_advance) then ld_weekly_advance=0
					if isnull(ld_elpearn) then ld_elpearn=0
					if isnull(ld_penalty) then ld_penalty=0
					if isnull(ld_nlip) then ld_nlip=0
					if isnull(ld_nrd) then ld_nrd=0
					if isnull(ld_nKoilAmo) then ld_nKoilAmo=0
					if isnull(ld_subs) then ld_subs=0
					if isnull(ld_pfadvded) then ld_pfadvded=0
					if isnull(ld_pfintded) then ld_pfintded=0
					if isnull(ld_totearn) then ld_totearn=0
					if isnull(ld_electadvded) then ld_electadvded=0
					if isnull(ld_medadvded) then ld_medadvded=0
					if isnull(ld_festadvded) then ld_festadvded=0
					if isnull(ld_lpg_subsidy_ded) then ld_lpg_subsidy_ded=0
										
				// Ration Compensation Amount To Be added in wages in other earning in case to temporary worker in FB
				// For temporary worker ration is not given as discussed with Govind and Lahari Sir dated 21/07/2012.
				ld_rcamt = 0
				if gs_garden_snm = 'FB'  and  (ls_emp_type = 'LP' or ls_emp_type = 'LT')	then
					select nvl(ls_rcamt,0) into :ld_rcamt from fb_laboursheet where  LS_RATIONCOMFLAG = '1' and ls_id = :ll_payid;
					if sqlca.sqlcode = -1 then
						messagebox('Sql Error : During Getting Ration Compensation Amount ',sqlca.sqlerrtext); 
						rollback using sqlca; 
						return -1; 	
					end if
					
					if isnull(ld_rcamt) then ld_rcamt = 0;
					
					ld_rationcomp =  (ld_hajiradays  + ld_sickdays) * ld_rcamt
					ld_ration = (-1) * ld_rationcomp
				end if
				
				// Ration Compensation Amount To Be added in wages in other earning in case to temporary worker in FB
					
				if gs_garden_snm='MT' then
					ld_totded = ld_pf + ld_fpf + ld_nele + ld_electric + ld_ration + ld_nadvance + ld_advance + ld_lwf + ld_weekly_advance + ld_elpearn + ld_nlip + ld_nrd + ld_nKoilAmo + ld_subs + ld_pfadvded + ld_pfintded + ld_electadvded + ld_medadvded + ld_festadvded
				elseif gs_garden_state = '03' then
					ld_totded = ld_pf + ld_fpf + ld_electric + ld_ration + ld_advance + ld_lwf + ld_subs + ld_pfadvded + ld_pfintded + ld_nlip + ld_electadvded + ld_medadvded + ld_festadvded
				else
					ld_totded = ld_pf + ld_fpf + ld_electric + ld_ration + ld_advance + ld_lwf + ld_subs + ld_pfadvded + ld_pfintded + ld_nlip + ld_electadvded + ld_medadvded + ld_festadvded
				end if
				
				if isnull(ld_totded) then ld_totded=0
				
				select labour_coinbf into :ld_coinbf from fb_labourweeklywages 
				where labour_id=:ls_labour_id and lww_id=(select max(lww_id) from fb_labourweeklywages where labour_id=:ls_labour_id and lww_id < :fs_lww_id);
				
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During Labour Coin BF Select : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 
				elseif sqlca.sqlcode =100 then
					 ld_coinbf=0;
				end if;
			
				if gs_garden_snm='MT' then
					if (ld_totearn - ld_totded +ld_coinbf) <= 0 then		// LESS RD
						ld_totded = ld_totded - ld_nrd;ld_nrd=0
						if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS LIP
							ld_totded = ld_totded - ld_nlip;ld_nlip=0
							if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS KOIL
								ld_totded = ld_totded - ld_nKoilAmo;ld_nKoilAmo=0
								if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS LWF
									ld_totded = ld_totded - ld_lwf; ld_lwf=0
									if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS ELECTRICITY
										ld_totded = ld_totded - (ld_nele + ld_electric); ld_nele =0; ld_electric =0
										if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS Advance
											ld_totded = ld_totded - (ld_nadvance + ld_advance); ld_nadvance =0; ld_advance=0
											if (ld_totearn - ld_totded +ld_coinbf) <= 0 then
												ld_totded = ld_totded - ld_subs; ld_subs=0
											end if
										end if
									end if
								end if
							end if
						end if
					end if
				else
					if (ld_totearn - ld_totded +ld_coinbf) <= 0 then	// LESS LIP
						ld_totded = ld_totded - ld_nlip;ld_nlip=0
						if (ld_totearn - ld_totded +ld_coinbf) <= 0 then
							ld_totded = ld_totded - ld_lwf; ld_lwf=0
							if (ld_totearn - ld_totded +ld_coinbf) <= 0 then
								ld_totded = ld_totded - ld_subs; ld_subs=0
							end if
						end if
					end if
				end if
				
//				ld_ptax
				select epd_ptax into :ld_Ptax  from fb_empptaxdeduction 
			  	where EPD_STATE_CODE = :gs_garden_state and 
				  		(nvl(:ld_fdconc,0) + nvl(:ld_totearn,0) + nvl(:ld_pf,0) + nvl(:ld_fpf,0)) between epd_startslab and epd_endslab and  EPD_DT_TO is null;
			  
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During PTAX Select ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return -1; 
				elseIf sqlca.sqlcode = 100 Then
					 ld_Ptax  = 0
				End If

				ld_totded = ld_totded + ld_Ptax 
				if isnull(ld_totearn) then ld_totearn=0
				
				///// lpg subsidy
				if (ld_totearn - ld_totded + ld_coinbf) > ld_lpg_subsidy_ded and ld_lpg_subsidy_ded > 0 then
					ld_totded = ld_totded + ld_lpg_subsidy_ded
					update fb_lpg_subsidy_mast set lsm_recovered_amt = :ld_lpg_subsidy_ded where emp_id = :ls_labour_id and lsm_issue_date = to_date(:ls_lpg_issue_dt, 'dd/mm/yyyy');
					if sqlca.sqlcode =-1 then
						messagebox('Error', 'Error occured while updating recovered amount in LPG Subsidy Master : '+sqlca.sqlerrtext )
						rollback using sqlca;
						return -1;
					end if
				else
					ld_lpg_subsidy_ded = 0
				end if
				////
				
				if ((ld_totearn - ld_totded + ld_coinbf) - ld_coincf)  >= ld_revst_range then
					ld_revst_ded = ld_RevSt
					ld_totded = ld_totded + ld_revst_ded
				end if
				if gs_garden_snm = 'JP' and ll_payid = 9 then
					ld_coincf = 0
				else   	
					if (ld_totearn - ld_totded + ld_coinbf) < 0 then
						ld_coincf = ld_totearn - ld_totded + ld_coinbf
					else
						ld_coincf =  mod( (ld_totearn - ld_totded + ld_coinbf),ld_rnd_off)
					end if
				end if
				
			  ld_netpayable = (ld_totearn - ld_totded + ld_coinbf) - ld_coincf
				
			  
			  if isnull(ld_netpayable) or ld_netpayable < 0 then ld_netpayable = 0;
			  
			  if ld_netpayable <= 0 then
				ld_subs = 0
			  end if
				
                  insert into fb_labourweeklywages (labour_id,lww_id,labour_weekstatus,labour_hajiradays,labour_maternitydays,labour_sickdays,labour_wages,labour_maternityearn,labour_sickearn,labour_elpearn,
						labour_otherearn,labour_foodconc,labour_pf,labour_fpf,labour_lwf,labour_advance,labour_electricity,labour_ration,labour_coinbf,labour_netpayableamount,labour_lastcoinbf,labour_holidaypay,
						labour_ricewt,labour_attawt,LS_ID,labour_penalty,labour_wagadvance,labour_lip,labour_rd,labour_ptax,labour_revst,labour_koil,labour_electunits,
						labour_subsded,labour_pfadvanceded,labour_pfinterestded,labour_rationdays,labour_minor,labour_major,labour_elegrdedamt,LABOUR_ATTN_INC,LABOUR_ELECTADVANCEDED, LABOUR_MEDICALADVANCEDED, LABOUR_FESTIVALADVANCEDED, LABOUR_LPG_SUBS_DED)
                  values(:ls_labour_id,:fs_lww_id,nvl(trim(:ls_emp_status),'A-A-A-A-A-A-O'),nvl(:ld_hajiradays,0),nvl(:ld_mdays,0),nvl(:ld_sickwagesdays ,0),nvl(:ld_hajiraearn,0),nvl(:ld_mwages,0),nvl(:ld_sickwages,0),nvl(:ld_elpearn,0),
						nvl(:ld_otherearn,0),nvl(:ld_fdconc,0),nvl(:ld_pf ,0),nvl(:ld_fpf,0),nvl(:ld_lwf,0),nvl(:ld_advance,0),nvl(:ld_electric,0),nvl(:ld_ration,0),nvl(:ld_coincf,0) ,nvl(:ld_netpayable,0),nvl(:ld_coinbf,0),nvl(:ld_holidaypay,0) ,
						nvl(:id_labricewt,0),nvl(:id_labattawt,0),:ll_payid,nvl(:ld_penalty,0),nvl(:ld_weekly_advance,0),nvl(:ld_nlip,0),nvl(:ld_nrd,0),nvl(:ld_Ptax,0),nvl(:ld_revst_ded,0),nvl(:ld_nKoilAmo,0),nvl(:ld_nele_unit,0),
						decode(nvl(:ld_netpayable,0),0,0,nvl(:ld_subs ,0)),nvl(:ld_pfadvded,0),nvl(:ld_pfintded,0),nvl(:ld_workdaysration,0),nvl(:id_no_lab_depminor,0) ,nvl(:id_no_lab_depmajor,0) ,nvl(:ll_edg_id,0),
						nvl(:ld_atinc_amt,0), nvl(:ld_electadvded,0), nvl(:ld_medadvded,0), nvl(:ld_festadvded,0), nvl(:ld_lpg_subsidy_ded, 0));

			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Labour Wages Insert: ('+ls_labour_id+') ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return -1; 
			end if

			setnull(ls_labour_id);setnull(ls_emp_status);	setnull(ls_emp_sex);setnull(ls_emp_type);setnull(ls_emp_marital);setnull(ls_electricflag);
			setnull(ls_pfno);setnull(ls_pfdedcode);setnull(ls_FIELD_ID);setnull(ls_fortnightration)
			ld_mdays= 0; ld_sickdays= 0; ld_sickwagesdays= 0; ld_hajiradays= 0; ld_withpaydays= 0; ld_workdaysration= 0; ll_edg_id=0;
			ld_mwages= 0; ld_sickwages= 0; ld_holidaypay= 0; ld_hajiraearn= 0; ld_otherearn= 0; ld_elpearn= 0;  ld_totearn= 0; ld_dedgroup=0;ld_fdconc=0
			ld_pf = 0;ld_fpf = 0;ld_lwf=0; ll_payid=0;ld_coinbf=0;ld_coincf=0;ld_netpayable=0;ld_nelpearn =0;ld_nlip = 0;ld_nrd = 0;ld_revst_ded=0
			ld_electric =0; ld_ration =0;ld_advance =0;ld_subs  =0;ld_pfadvded  =0;ld_pfintded =0;ld_half_hajira=0;ld_w2_half_hajira=0
			ld_atinc_amt=0;ld_atinc_rt=0;ld_atinc_days=0;ld_atinc_w2days=0;ld_atinc_mindays=0; setnull(ls_atinc_pfind);setnull(ls_atinc_range)
			ld_lwf = fd_lwf ; ld_subs = fd_subs;ld_pm_elp = 0;ld_pm_penalty = 0; ld_electadvded = 0; ld_medadvded = 0; ld_festadvded = 0; ld_lpg_subsidy_ded = 0;

	fetch c1 into :ls_labour_id,:ld_mdays,:ld_mwages,:ld_sickdays,:ld_sickwages,:ld_sickwagesdays,:ld_holidaypay,:ld_hajiradays,:ld_hajiraearn,
				    :ld_otherearn,:ld_withpaydays,:ld_workdaysration,:ld_elpearn,:ld_penalty,:ld_totearn,
				    :ls_emp_status,	:ls_emp_sex,:ls_emp_type,:ls_emp_marital,:ls_electricflag,:ll_edg_id,:ls_pfno,:ls_pfdedcode,:ld_dedgroup,
				    :ls_FIELD_ID,:LS_LWFFLAG,:LS_SUBSFLAG,:ll_payid,:ls_fortnightration,
					:ld_atinc_rt,:ld_atinc_days,:ld_atinc_w2days,:ls_atinc_range,:ld_atinc_mindays,:ls_atinc_pfind,:ld_half_hajira,:ld_w2_half_hajira,:ld_nlip,:ld_nrd;
					 
	loop;
	close c1;
end if;			

	w_mdi.setmicrohelp('Wages Calculation Completed ....!')

if (fd_lwf + fd_subs) > 0 then
	update fb_labourwagesweek set lww_rice=:id_totricequan,lww_atta=:id_totattaquan,lww_paycalflag='1',lww_lwfflag='1' where lww_id=:fs_lww_id;
else
	update fb_labourwagesweek set lww_rice=:id_totricequan,lww_atta=:id_totattaquan,lww_paycalflag='1',lww_lwfflag='0' where lww_id=:fs_lww_id;
end if

if sqlca.sqlcode = -1 then
	messagebox('Sql Error : During Labour Wage Week (Update) ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
end if

update fb_rationperiodforweek set RPFW_PAIDFLAG ='1' where RPFW_CALFLAG ='1' and RPFW_LWW_ID = :fs_lww_id;

if sqlca.sqlcode = -1 then
	messagebox('Sql Error : During Labour Wage Week (Update) ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
end if
if gs_garden_snm='MT' or gs_garden_snm='MK' then
	update fb_labourwagadvweek set lwaw_calflag = '1' where lww_id=:fs_lww_id;
	if sqlca.sqlcode = -1 then 
		messagebox('Sql Error : During Paid Flag Updation ',sqlca.sqlerrtext); 
		rollback using sqlca; 
		return 1; 
	end if
	update fb_elpperiod set elw_PAIDFLAG = '1' where lww_id = :fs_lww_id;
	if sqlca.sqlcode = -1 then 
		messagebox('Sql Error : During Paid Flag Updation ',sqlca.sqlerrtext); 
		rollback using sqlca; 
		return 1; 
	end if
	
end if
////delete from fb_rationfortnightsheet where rpfw_id = (select rpfw_id from fb_rationperiodforweek rpfw where rpfw_lww_id=:fs_lww_id);
////
////if sqlca.sqlcode = -1 then
////	messagebox('Sql Error : During Fortnight Wages sheet (Delete)',sqlca.sqlerrtext); 
////	rollback using sqlca; 
////	return -1; 
////end if
////
////insert into fb_rationfortnightsheet  (rpfw_id,ls_id) 
////select distinct RPFW_ID,ls_id from 
////	(select RPFW_ID from fb_rationperiodforweek where rpfw_lww_id=:fs_lww_id),
////	(select ls_id from fb_laboursheet where LS_FORTNIGHTRATION='1');
////
////if sqlca.sqlcode = -1 then
////	messagebox('Sql Error : During Fortnight Wages sheet (Insert)',sqlca.sqlerrtext); 
////	rollback using sqlca; 
////	return -1; 
////end if

//if wf_substaffration(fs_lww_id,fs_st_dt) = -1 then
//	rollback using sqlca; 
//	return -1; 
//end if

commit using sqlca;		
	w_mdi.setmicrohelp('Ready ....!')

return 1;	

end function

public function integer wf_wagecal_2wdb (string fs_st_dt, double fd_lwf, double fd_subs);string fs_lww_id,ls_temp
long ll_weekstatus,ll_nodays

 select lww_id,((LWW_ENDDATE - LWW_STARTDATE) + 1) into :fs_lww_id,:ll_nodays from fb_labourwagesweek  where lww_startdate= to_date(:fs_st_dt,'dd/mm/yyyy') and lww_paidflag='0';
	
	if sqlca.sqlcode =100 then
		messagebox('Wages Week Select ','Either the there is no such week or the wages against this week has been paid, Please Check...!')
		return -1
	elseif sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Wages Week Select ',sqlca.sqlerrtext)
		return -1
	end if;
	
	select distinct 'x' into :ls_temp from fb_labourrationchart where to_date(:fs_st_dt,'dd/mm/yyyy')  between LRC_FRDT and nvl(LRC_TODT,trunc(sysdate));
	
	if sqlca.sqlcode =100 then
		messagebox('Ration Chart checking','The Ration Chart has not been prepared Please Check...!')
		return -1
	elseif sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Ration Chart checking ',sqlca.sqlerrtext)
		return -1
	end if;

	select distinct 'x' into :ls_temp from fb_rationperiodforweek where RPFW_LWW_ID =  :fs_lww_id and RPFW_CALFLAG='0';
	
	if sqlca.sqlcode =0 then
		messagebox('Ration Chart checking','The Ration Against this Period has not been paid. First pay the ration for this period, Please Check...!')
		return -1
	elseif sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Ration Payment checking ',sqlca.sqlerrtext)
		return -1
	end if;
	
//	select max(length(LWS_STATUS)) into :ll_weekstatus from fb_labourweeklystatus where LWW_ID = :fs_lww_id;
//	
//	if sqlca.sqlcode = -1 then
//		messagebox('SQL ERROR: During Attendance Status checking ',sqlca.sqlerrtext)
//		return -1
//	end if;
//	
//	if isnull(ll_weekstatus) then ll_weekstatus=0
//	
//	w_mdi.setmicrohelp('Calculation of Week Status is Going on ....!')
//	
//	if ((ll_nodays * 2) <> (ll_weekstatus +1)) then
//		
//		declare p2 procedure for up_UPD_WEEKLY_STATUS(:fs_lww_id);
//		
//		if sqlca.sqlcode = -1 then
//			messagebox('SQL Error: During Procedure Declare of up_wagecal_2w',sqlca.sqlerrtext)					
//			return 1
//		end if
//
//////		sqlca.dbparm = "procedureintransaction=1"
//		execute p2;
//		if sqlca.sqlcode = -1 then
//			messagebox('SQL Error: During Procedure Execute of up_wagecal_2w',sqlca.sqlerrtext)
////			sqlca.dbparm = "procedureintransaction=0"
//			return 1
//		end if
////		sqlca.dbparm = "procedureintransaction=0"
//		
////		IF WF_UPD_WEEKLY_STATUS(fs_lww_id) = -1 THEN
////			return -1
////		end if
//	end if
	
	w_mdi.setmicrohelp('Salary Calculation is Started ....!')
	
		declare p3 procedure for up_wagecal_2w(:fs_st_dt,:fd_lwf,:fd_subs,:gs_garden_snm,:gs_gstn_stcd);
		
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error: During Procedure Declare of up_wagecal_2w',sqlca.sqlerrtext)					
			return 1
		end if

//		sqlca.dbparm = "procedureintransaction=1"
		execute p3;
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error: During Procedure Execute of up_wagecal_2w',sqlca.sqlerrtext)
//			sqlca.dbparm = "procedureintransaction=0"
			return 1
		end if
//		sqlca.dbparm = "procedureintransaction=0"

commit using sqlca;		
	w_mdi.setmicrohelp('Ready ....!')

return 1;	

end function

public function integer wf_wagecal_db (string fs_st_dt, double fd_lwf, double fd_subs);string fs_lww_id,ls_temp,ls_labour_id,ls_emp_status,ls_emp_sex,ls_emp_type,ls_emp_marital,ls_electricflag,ls_pfno,ls_pfdedcode,ls_FIELD_ID,LS_LWFFLAG,LS_SUBSFLAG,ls_fortnightration, ls_lpg_issue_dt
long ll_edg_id,ll_payid,ll_adoleage,ll_weekstatus,ll_nodays
double ld_mdays,ld_sickdays,ld_sickwagesdays,ld_hajiradays,ld_withpaydays,ld_workdaysration,ld_mwages,ld_sickwages,ld_holidaypay,ld_hajiraearn,ld_otherearn,ld_elpearn,ld_totearn,ld_dedgroup,ld_fdconc
double ld_pf,ld_fpf,ld_coinbf,ld_coincf,ld_netpayable,ld_nelpearn,ld_pm_elp,ld_pm_penalty
double ld_rnd_off,ld_tpf_rt,ld_pf_rt,ld_fpf_rt,ld_revst_range,ld_revst,ld_fdconc_rt,ld_penalty,ld_weekly_advance,ld_Ptax,ld_revst_ded
double ld_nlip,ld_nele,ld_nele_unit,ld_nlwf,ld_nrd,ld_nKoilAmo,ld_nadvance
double ld_First_days,ld_ration,ld_totded,ld_lwf,ld_subs,ld_electric,ld_advance,ld_pfadvded,ld_pfintded, ld_electadvded, ld_medadvded, ld_festadvded, ld_lpg_subsidy_ded
double ld_atinc_rt,ld_atinc_days,ld_atinc_mindays,ld_atinc_amt,ld_atinc_w2days,ld_half_hajira,ld_w2_half_hajira,ld_rcamt,ld_rationcomp,ld_pffpf_rnd_off, ld_brationwt,ld_brationamt
string ls_atinc_range,ls_atinc_pfind
 
id_totricequan=0; id_totattaquan=0;ll_nodays=0;ll_weekstatus=0;ld_pm_elp = 0; ld_pm_penalty = 0
 
	
	select distinct 'x' into :ls_temp from fb_labourrationchart
	 where to_date(:fs_st_dt,'dd/mm/yyyy')  between LRC_FRDT and nvl(LRC_TODT,trunc(sysdate));
	
	if sqlca.sqlcode =100 then
		messagebox('Ration Chart checking','The Ration Chart has not been prepared Please Check...!')
		return -1
	elseif sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Ration Chart checking ',sqlca.sqlerrtext)
		return -1
	end if;

	select distinct 'x' into :ls_temp from fb_rationperiodforweek where RPFW_LWW_ID =  :fs_lww_id and RPFW_CALFLAG='0';
	
	if sqlca.sqlcode =0 then
		messagebox('Ration Chart checking','The Ration Against this Period has not been paid. First pay the ration for this period, Please Check...!')
		return -1
	elseif sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Ration Payment checking ',sqlca.sqlerrtext)
		return -1
	end if;
	
	
	w_mdi.setmicrohelp('Calculation of Week Status is Going on ....!')
	
		declare p1 procedure for up_wagecal(:fs_st_dt,:fd_lwf,:fd_subs,:gs_garden_snm,:gs_gstn_stcd);
		
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error: During Procedure Declare of up_wagecal',sqlca.sqlerrtext)					
			return 1
		end if

		execute p1;
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error: During Procedure Execute of up_wagecal',sqlca.sqlerrtext)
			return 1
		end if

commit using sqlca;		
	w_mdi.setmicrohelp('Ready ....!')
	
	
	

return 1;	

end function

on n_wagept.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_wagept.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

