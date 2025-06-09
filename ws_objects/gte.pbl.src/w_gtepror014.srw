$PBExportHeader$w_gtepror014.srw
forward
global type w_gtepror014 from window
end type
type em_3 from editmask within w_gtepror014
end type
type st_3 from statictext within w_gtepror014
end type
type st_2 from statictext within w_gtepror014
end type
type dp_2 from datepicker within w_gtepror014
end type
type dp_1 from datepicker within w_gtepror014
end type
type st_1 from statictext within w_gtepror014
end type
type cb_1 from commandbutton within w_gtepror014
end type
type cb_2 from commandbutton within w_gtepror014
end type
type dw_1 from datawindow within w_gtepror014
end type
end forward

global type w_gtepror014 from window
integer width = 3438
integer height = 2296
boolean titlebar = true
string title = "(Gtepror014) - Manufacturing Report Season Wise"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_3 em_3
st_3 st_3
st_2 st_2
dp_2 dp_2
dp_1 dp_1
st_1 st_1
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_gtepror014 w_gtepror014

type variables
n_cst_powerfilter iu_powerfilter 
long ll_season
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

on w_gtepror014.create
this.em_3=create em_3
this.st_3=create st_3
this.st_2=create st_2
this.dp_2=create dp_2
this.dp_1=create dp_1
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.em_3,&
this.st_3,&
this.st_2,&
this.dp_2,&
this.dp_1,&
this.st_1,&
this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_gtepror014.destroy
destroy(this.em_3)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_1.settransobject(sqlca)
dp_1.value = datetime('01'+right(string(today(),'dd/mm/yyyy'),8))

string ls_text

em_3.text = string(today(),'YYYY')

ls_text = "CREATE OR REPLACE VIEW FBVW_DMRS (PARTICULARS, GTTYPE, NAME, PLUCKINGDATE, QUANTITY,Season) AS  "&
		 + " SELECT   'GREEN LEAF', DECODE (glt.gt_type, 'OWNATTE', 'OWN', 'OWNUSER', 'OWN',glt.gt_type), "&
		  + "          sup.sup_name, glt.pluckingdate, SUM(NVL(glt.gt_quantity,0) * decode(glt.gt_type,'TRANSFER',-1,'SALE',-1,1)),GT_SEASON "&
		   + " FROM fb_gltransaction glt,fb_supplier sup  "&       
		  + " WHERE glt.sup_id = sup.sup_id  "&    
		  + "GROUP BY (DECODE (glt.gt_type, 'OWNATTE', 'OWN', 'OWNUSER', 'OWN',glt.gt_type), sup.sup_name, glt.pluckingdate),GT_SEASON  "&      
		  + " HAVING SUM(NVL(glt.gt_quantity,0) * decode(glt.gt_type,'TRANSFER',-1,'SALE',-1,1)) <> 0 "& 
		  + " UNION ALL "&
		  + " SELECT 'GL FOR PRODUCTION', 'ALL', DECODE (TRIM (sup.sup_type), 'OWN', 'OWN', sup.sup_name), "&
		   + "      glfp.glfp_pluckingdate, SUM (NVL (glfp.glfp_glforproduction, 0)),GWTM_SEASON  "&
		  + "  FROM fb_glforproduction glfp, fb_gardenwiseteamade gwtm, fb_supplier sup  "&
		  + " WHERE glfp.sup_id = sup.sup_id AND glfp.glfp_pk = gwtm.glfp_pk AND gwtm.gwtm_type not in ('O' ,'E')  "&
		  + " GROUP BY (DECODE (TRIM (sup.sup_type), 'OWN', 'OWN', sup.sup_name), glfp.glfp_pluckingdate ),GWTM_SEASON"& 
		  + " HAVING NVL (SUM (glfp.glfp_glforproduction), 0) <> 0  "&    
          + " UNION ALL "&
		 + " SELECT 'GARDENWISE TEA MADE', 'MFG. TEA', DECODE (TRIM (sup.sup_type), 'OWN', 'OWN', sup.sup_name), glfp.glfp_pluckingdate, NVL (SUM (gwtm.gwtm_teamade), 0),GWTM_SEASON "&
		  + "  FROM fb_glforproduction glfp,fb_supplier sup,fb_gardenwiseteamade gwtm  "&
		  + " WHERE glfp.sup_id = sup.sup_id AND glfp.glfp_pk = gwtm.glfp_pk AND gwtm.gwtm_type = 'N'  "&
		  + " GROUP BY DECODE (TRIM (sup.sup_type), 'OWN', 'OWN', sup.sup_name), glfp.glfp_pluckingdate  ,GWTM_SEASON"&
		  + " HAVING NVL (SUM (gwtm.gwtm_teamade), 0) <> 0  "&
		  + " UNION ALL "& 
		  + " SELECT 'GARDENWISE TEA MADE', 'EXCESS TEA', DECODE (TRIM (sup.sup_type), 'OWN', 'OWN', sup.sup_name),  "&
		   + "      glfp.glfp_pluckingdate, NVL (SUM (gwtm.gwtm_teamade), 0),GWTM_SEASON "&
		   + " FROM fb_glforproduction glfp, fb_supplier sup,fb_gardenwiseteamade gwtm  "&
		   + " WHERE glfp.sup_id = sup.sup_id AND glfp.glfp_pk = gwtm.glfp_pk AND gwtm.gwtm_type = 'E' "&
		   + " GROUP BY (DECODE (TRIM (sup.sup_type), 'OWN', 'OWN', sup.sup_name), glfp.glfp_pluckingdate,GWTM_SEASON ) "&
		   + " HAVING NVL (SUM (gwtm.gwtm_teamade), 0) <> 0  "&
		  + " UNION ALL "&
		  + " SELECT 'GARDENWISE TEA MADE', 'PURCHASE TEA',sup.sup_name, pt.pt_date,NVL (SUM (ddu.ddu_quantity), 0),0 "&
		   + "  FROM fb_purteamade pt, fb_dailydryerunsorted ddu, fb_supplier sup  "&
		  + " WHERE pt.sup_id = sup.sup_id     AND pt.ddp_pk = ddu.ddp_pk  "&
		  + " GROUP BY (sup.sup_name, pt.pt_date)     HAVING NVL (SUM (ddu.ddu_quantity), 0) <> 0   "&
		  + " UNION ALL  "&
		  + " SELECT   'CATEGORYWISE TEA MADE', 'ALL', tpc.tpc_manid,ddp.ddp_pluckingdate, NVL (SUM (ddu.ddu_quantity), 0),DDP_SEASON "&
		   + " FROM fb_dailydryerproduct ddp, fb_dailydryerunsorted ddu, fb_teamadeproductcategory tpc "&
		   + " WHERE ddu.tpc_id = tpc.tpc_id AND ddp.ddp_pk = ddu.ddp_pk AND ddp.ddp_type <> 'O' "&
		  + " GROUP BY (tpc.tpc_manid, ddp.ddp_pluckingdate,DDP_SEASON) HAVING NVL (SUM (ddu.ddu_quantity), 0) <> 0 "&
		  + " UNION ALL "&
		  + " SELECT   'SORTED TEA MADE', 'ALL', tpc.tpc_manid, dtmp.dtmp_sortdate, NVL (SUM (dtmp.dtmp_sortquantodayty), 0),DTMP_SEASON "&
		   + " FROM fb_dailysortedteamadeproduct dtmp, fb_teamadeproduct tmp, fb_teamadeproductcategory tpc  "&
		   + " WHERE tpc.tpc_id = tmp.tpc_id AND dtmp.tmp_id = tmp.tmp_id  "&
		  + " GROUP BY (tpc.tpc_manid, dtmp.dtmp_sortdate,DTMP_SEASON)  "&
		  + " HAVING NVL (SUM (dtmp.dtmp_sortquantodayty), 0) <> 0   "&
		  + " UNION ALL "&
		  + " SELECT   'PACKED TEA MADE', 'ALL', tpc.tpc_manid, dtp.dtp_date, NVL(SUM ((dtpd.dtpd_srnoend - dtpd.dtpd_srnostart + 1) * dtpd.dtpd_indwt ), 0 ),DTP_SEASON "&
		  + " FROM fb_dailyteapacked dtp, fb_dtpdetails dtpd, fb_teamadeproductcategory tpc, fb_teamadeproduct tmp  "&
		  + " WHERE tpc.tpc_id = tmp.tpc_id AND dtpd.tmp_id = tmp.tmp_id AND dtp.dtp_id = dtpd.dtp_id  "&
		  + " GROUP BY (tpc.tpc_manid, dtp.dtp_date,DTP_SEASON) "&
		  + " HAVING NVL (SUM (  (dtpd.dtpd_srnoend - dtpd.dtpd_srnostart + 1) * dtpd.dtpd_indwt),0) <> 0 "&
		  + " UNION ALL "&
		  + " SELECT   'DESPATCH TEA MADE', 'ALL', tpc.tpc_manid, si.si_date, NVL (SUM (  (SID.sid_srnoend - SID.sid_srnostart + 1) * dtpd.dtpd_indwt ),0 ),SID_SEASON "&
		  + " FROM fb_saleinvoice si, fb_sidetails SID, fb_dtpdetails dtpd,fb_teamadeproductcategory tpc, fb_teamadeproduct tmp  "&
		  + " WHERE tpc.tpc_id = tmp.tpc_id AND dtpd.tmp_id = tmp.tmp_id AND SID.dtpd_id = dtpd.dtpd_id AND si.si_id = SID.si_id AND si.si_active = '1'  "&
		  + " GROUP BY (tpc.tpc_manid, si.si_date,SID_SEASON)  "&
		  + " HAVING NVL (SUM ((SID.sid_srnoend - SID.sid_srnostart + 1) * dtpd.dtpd_indwt ), 0) <> 0 "&
		  + " UNION ALL "&
		  + " SELECT   'UNSORTED', 'ALL', tpc.tpc_manid, pludate, SUM (qty),0  "&
		  + " FROM (SELECT ddu.tpc_id tpc_id, ddp.ddp_pluckingdate pludate, NVL (SUM (ddu.ddu_quantity), 0) qty  "&
		   + "       FROM fb_dailydryerproduct ddp, fb_dailydryerunsorted ddu  "&
		    + "     WHERE ddp.ddp_pk = ddu.ddp_pk AND ddp.ddp_type <> 'O'  "&
		     + "   GROUP BY (ddu.tpc_id, ddp.ddp_pluckingdate)  union all select   TPC_ID,  PT_DATE, sum(nvl(PT_QUANTITY,0)) from fb_packteatransfer  where pt_trantype = 'R' group by TPC_ID,  PT_DATE "&
		     + "   UNION ALL  "&
		     + "   SELECT   tmp.tpc_id tpc_id, dtmp_sortdate pludate, -NVL (SUM (dtmp.dtmp_sortquantodayty), 0) qty  "&
		     + "     FROM fb_dailysortedteamadeproduct dtmp, fb_teamadeproduct tmp WHERE dtmp.tmp_id = tmp.tmp_id  "&
		     + "    GROUP BY (tmp.tpc_id, dtmp.dtmp_sortdate)) d1, fb_teamadeproductcategory tpc  "&
		  + " WHERE (tpc.tpc_id = d1.tpc_id)  "&
		 + " GROUP BY (tpc.tpc_manid, pludate)  "&
		 + " HAVING SUM (qty) <> 0 "&
		 + " UNION ALL "&
		 + " SELECT 'SORTED BUT NOT PACKED', 'ALL', tpc.tpc_manid, pludate, SUM (qty),0 "&
		  + "  FROM (SELECT tmp.tpc_id tpc_id, dtmp_sortdate pludate, NVL (SUM (dtmp.dtmp_sortquantodayty), 0) qty "&
		   + "         FROM fb_dailysortedteamadeproduct dtmp, fb_teamadeproduct tmp  "&
		   + "        WHERE dtmp.tmp_id = tmp.tmp_id  "&
		   + "       GROUP BY (tmp.tpc_id, dtmp.dtmp_sortdate)  "&
		  + "        UNION ALL  "&
		   + "       SELECT tmp.tpc_id tpc_id, dtp.dtp_date pludate, -NVL (SUM((dtpd.dtpd_srnoend - dtpd.dtpd_srnostart + 1 ) * dtpd.dtpd_indwt),0 ) qty  "&
		   + "         FROM fb_dailyteapacked dtp, fb_dtpdetails dtpd, fb_teamadeproduct tmp  "&
		   + "        WHERE dtp.dtp_id = dtpd.dtp_id AND tmp.tmp_id = dtpd.tmp_id  "&
		   + "       GROUP BY (tmp.tpc_id, dtp.dtp_date)) d1, fb_teamadeproductcategory tpc  "&
		  + " WHERE (tpc.tpc_id = d1.tpc_id)  "&
		  + "GROUP BY (tpc.tpc_manid, pludate) HAVING SUM (qty) <> 0  "&
		  + " UNION ALL "&
		  + " SELECT 'PACKED BUT AWAITING DESPATCH', 'ALL', tpc.tpc_manid, pludate, SUM (qty),0  "&
		   + "  FROM (SELECT tmp.tpc_id tpc_id, dtp.dtp_date pludate, NVL(SUM((dtpd.dtpd_srnoend - dtpd.dtpd_srnostart + 1 ) * dtpd.dtpd_indwt ), 0 ) qty  "&
		    + "        FROM fb_dailyteapacked dtp, fb_dtpdetails dtpd,fb_teamadeproduct tmp  "&
		    + "       WHERE dtp.dtp_id = dtpd.dtp_id AND tmp.tmp_id = dtpd.tmp_id  "&
		    + "      GROUP BY (tmp.tpc_id, dtp.dtp_date)  "&
             + "     UNION ALL  "&
             + "     SELECT tmp.tpc_id tpc_id, si.si_date pludate, -NVL (SUM((SID.sid_srnoend - SID.sid_srnostart + 1) * dtpd.dtpd_indwt ),0) qty  "&
             + "       FROM fb_dtpdetails dtpd LEFT OUTER JOIN fb_sidetails SID ON dtpd.dtpd_id = SID.dtpd_id LEFT OUTER JOIN fb_saleinvoice si ON SID.si_id = si.si_id,fb_teamadeproduct tmp  "&
             + "      WHERE dtpd.tmp_id = tmp.tmp_id AND si.si_active = '1'  "&
             + "      GROUP BY (tmp.tpc_id, si.si_date)) d1, fb_teamadeproductcategory tpc  "&
           + " WHERE (tpc.tpc_id = d1.tpc_id) "&
          + " GROUP BY (tpc.tpc_manid, pludate) "& 
          + " HAVING SUM (qty) <> 0 "&
          + " UNION ALL  "&
          + " SELECT 'FACTORY TOTAL STOCK', 'ALL', tpc.tpc_manid, pludate, SUM (qty),0  "&
           + " FROM (SELECT ddu.tpc_id tpc_id, ddp.ddp_pluckingdate pludate, NVL(SUM(ddu.ddu_quantity), 0) qty  "&
           + "         FROM fb_dailydryerproduct ddp, fb_dailydryerunsorted ddu  "&
           + "        WHERE ddp.ddp_pk = ddu.ddp_pk AND ddp.ddp_type <> 'O'  "&
           + "       GROUP BY (ddu.tpc_id, ddp.ddp_pluckingdate) union all select   TPC_ID,  PT_DATE, sum(nvl(PT_QUANTITY,0)) from fb_packteatransfer  where pt_trantype = 'R' group by TPC_ID,  PT_DATE  UNION ALL  "&
           + "   SELECT tmp.tpc_id tpc_id, si.si_date pludate, -NVL (SUM((SID.sid_srnoend - SID.sid_srnostart + 1) * dtpd.dtpd_indwt ),0) qty  "&
           + "         FROM fb_dtpdetails dtpd LEFT OUTER JOIN fb_sidetails SID ON dtpd.dtpd_id = SID.dtpd_id LEFT OUTER JOIN fb_saleinvoice si ON SID.si_id = si.si_id ,fb_teamadeproduct tmp  "&
           + "        WHERE dtpd.tmp_id = tmp.tmp_id AND si.si_active = '1' "&
           + "       GROUP BY (tmp.tpc_id, si.si_date)) d1,fb_teamadeproductcategory tpc  "&
          + " WHERE (tpc.tpc_id = d1.tpc_id)  "&
         + " GROUP BY (tpc.tpc_manid, pludate) HAVING SUM (qty) <> 0"&
         + " UNION ALL  "&
         + " SELECT   'ALL', 'ALL', 'RAINFALL IN INCH', wr.wr_date, NVL (SUM (wr.wr_rainfall), 0),0  "&
         + " FROM fb_weatherreport wr  "&
         + " GROUP BY (wr.wr_date) HAVING NVL (SUM (wr.wr_rainfall), 0) <> 0  "&
         + " UNION ALL  "&
         + " SELECT 'MANDAYS', 'ALL', 'MANUFACTURE MANDAYS' , tad.task_date,  "&
          + "    tad.task_pmatodayty + tad.task_pfatodayty + 0.5 * tad.task_pmadtodayty + 0.5 * tad.task_pfadtodayty + 0.5 * tad.task_pmctodayty + 0.5 * tad.task_pfctodayty + tad.task_tmatodayty + tad.task_omatodayty + tad.task_tfatodayty + tad.task_ofatodayty + 0.5 * tad.task_tmadtodayty + 0.5 * tad.task_tfadtodayty + 0.5 * tad.task_tmctodayty + 0.5 * tad.task_tfctodayty + 0.5 * tad.task_omadtodayty + 0.5 * tad.task_ofadtodayty + 0.5 * tad.task_omctodayty + 0.5 * tad.task_ofctodayty, 0 "&
          + "  FROM fb_taskactivedaily tad, fb_kamsubhead kam, fb_expenseacsubhead esub  "&
          + " WHERE tad.task_id = kam.kamsub_id AND nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and kam.kamsub_id = esub.eacsubhead_id AND (esub.eachead_id IN ('SLEG0016')) "&
          + " UNION ALL  "&
          + " SELECT 'FUEL CONSUMPTION', 'ALL', UPPER (ct.ct_manid), ddp.DDP_STARTRUNTIME, NVL(SUM(ddc.ddc_unitconsumed), 0),0 "&
           + " FROM fb_dailydryerproduct ddp, fb_dailydryerconsumption ddc, fb_consumptiontype ct, fb_machine mac  "&
          + " WHERE ddp.ddp_pk = ddc.ddp_pk AND ddp.dryer_id = mac.machine_id AND TRIM (mac.machine_type) in ('DRY','SORT','TROUGH','CTC','BOILER') AND ddc.ct_id = ct.ct_id  "&
          + " GROUP BY (UPPER (ct.ct_manid), ddp.DDP_STARTRUNTIME)  "&
          + " HAVING NVL (SUM (ddc.ddc_unitconsumed), 0) <> 0 "&
           + " WITH READ ONLY "
			  
//		 + " SELECT   'GREEN LEAF', DECODE (glt.gt_type, 'OWNATTE', 'OWN', 'OWNUSER', 'OWN',glt.gt_type), "&
//		 + "           sup.sup_name, glt.pluckingdate, SUM(NVL(glt.gt_quantity,0) * decode(glt.gt_type,'TRANSFER',-1,'SALE',-1,1)) "&
//		 + "   FROM fb_gltransaction glt,fb_supplier sup         "&
//		 + "  WHERE glt.sup_id = sup.sup_id      "&
//		 + " GROUP BY (DECODE (glt.gt_type, 'OWNATTE', 'OWN', 'OWNUSER', 'OWN',glt.gt_type), sup.sup_name, glt.pluckingdate)        "&
//		 + "  HAVING SUM(NVL(glt.gt_quantity,0) * decode(glt.gt_type,'TRANSFER',-1,'SALE',-1,1)) <> 0  "&
//		 + " UNION ALL "&
//		 + " SELECT 'GL FOR PRODUCTION', 'ALL', DECODE (TRIM (sup.sup_type), 'OWN', 'OWN', sup.sup_name), "&
//		 + "        glfp.glfp_pluckingdate, SUM (NVL (glfp.glfp_glforproduction, 0))  "&
//		 + "   FROM fb_glforproduction glfp, fb_gardenwiseteamade gwtm, fb_supplier sup  "&
//		 + "  WHERE glfp.sup_id = sup.sup_id AND glfp.glfp_pk = gwtm.glfp_pk AND gwtm.gwtm_type not in ('O' ,'E')  "&
//		 + " GROUP BY (DECODE (TRIM (sup.sup_type), 'OWN', 'OWN', sup.sup_name), glfp.glfp_pluckingdate ) "&
//		 + "  HAVING NVL (SUM (glfp.glfp_glforproduction), 0) <> 0      "&
//		 + " UNION ALL  "&
//		 + " SELECT 'GARDENWISE TEA MADE', 'MFG. TEA', DECODE (TRIM (sup.sup_type), 'OWN', 'OWN', sup.sup_name), glfp.glfp_pluckingdate, NVL (SUM (gwtm.gwtm_teamade), 0) "&
//		 + "   FROM fb_glforproduction glfp,fb_supplier sup,fb_gardenwiseteamade gwtm  "&
//		 + "  WHERE glfp.sup_id = sup.sup_id AND glfp.glfp_pk = gwtm.glfp_pk AND gwtm.gwtm_type = 'N'  "&
//		 + "  GROUP BY (DECODE (TRIM (sup.sup_type), 'OWN', 'OWN', sup.sup_name), glfp.glfp_pluckingdate ) "&
//		 + " HAVING NVL (SUM (gwtm.gwtm_teamade), 0) <> 0  "&
//		 + " UNION ALL  "&
//		 + " SELECT 'GARDENWISE TEA MADE', 'EXCESS TEA', DECODE (TRIM (sup.sup_type), 'OWN', 'OWN', sup.sup_name),  "&
//		 + "        glfp.glfp_pluckingdate, NVL (SUM (gwtm.gwtm_teamade), 0) "&
//		 + "   FROM fb_glforproduction glfp, fb_supplier sup,fb_gardenwiseteamade gwtm  "&
//		 + "   WHERE glfp.sup_id = sup.sup_id AND glfp.glfp_pk = gwtm.glfp_pk AND gwtm.gwtm_type = 'E' "&
//		 + "  GROUP BY (DECODE (TRIM (sup.sup_type), 'OWN', 'OWN', sup.sup_name), glfp.glfp_pluckingdate ) "&
//		 + "  HAVING NVL (SUM (gwtm.gwtm_teamade), 0) <> 0  "&
//		 + " UNION ALL "&
//		 + " SELECT 'GARDENWISE TEA MADE', 'PURCHASE TEA',sup.sup_name, pt.pt_date,NVL (SUM (ddu.ddu_quantity), 0) "&
//		 + "   FROM fb_purteamade pt, fb_dailydryerunsorted ddu, fb_supplier sup  "&
//		 + "  WHERE pt.sup_id = sup.sup_id     AND pt.ddp_pk = ddu.ddp_pk  "&
//		 + " GROUP BY (sup.sup_name, pt.pt_date)     HAVING NVL (SUM (ddu.ddu_quantity), 0) <> 0   "&
//		 + " UNION ALL  "&
//		 + " SELECT   'CATEGORYWISE TEA MADE', 'ALL', tpc.tpc_manid,ddp.ddp_pluckingdate, NVL (SUM (ddu.ddu_quantity), 0)  "&
//		 + "   FROM fb_dailydryerproduct ddp, fb_dailydryerunsorted ddu, fb_teamadeproductcategory tpc "&
//		 + "  WHERE ddu.tpc_id = tpc.tpc_id AND ddp.ddp_pk = ddu.ddp_pk AND ddp.ddp_type <> 'O' "&
//		 + " GROUP BY (tpc.tpc_manid, ddp.ddp_pluckingdate) HAVING NVL (SUM (ddu.ddu_quantity), 0) <> 0  "&
//		 + " UNION ALL  "&
//		 + " SELECT   'SORTED TEA MADE', 'ALL', tpc.tpc_manid, dtmp.dtmp_sortdate, NVL (SUM (dtmp.dtmp_sortquantodayty), 0) "&
//		 + "   FROM fb_dailysortedteamadeproduct dtmp, fb_teamadeproduct tmp, fb_teamadeproductcategory tpc  "&
//		 + "  WHERE tpc.tpc_id = tmp.tpc_id AND dtmp.tmp_id = tmp.tmp_id  "&
//		 + " GROUP BY (tpc.tpc_manid, dtmp.dtmp_sortdate)  "&
//		 + " HAVING NVL (SUM (dtmp.dtmp_sortquantodayty), 0) <> 0   "&
//		 + " UNION ALL  "&
//		 + " SELECT   'PACKED TEA MADE', 'ALL', tpc.tpc_manid, dtp.dtp_date, NVL(SUM ((dtpd.dtpd_srnoend - dtpd.dtpd_srnostart + 1) * dtpd.dtpd_indwt ), 0 ) "&
//		 + " FROM fb_dailyteapacked dtp, fb_dtpdetails dtpd, fb_teamadeproductcategory tpc, fb_teamadeproduct tmp  "&
//		 + " WHERE tpc.tpc_id = tmp.tpc_id AND dtpd.tmp_id = tmp.tmp_id AND dtp.dtp_id = dtpd.dtp_id  "&
//		 + " GROUP BY (tpc.tpc_manid, dtp.dtp_date) "&
//		 + " HAVING NVL (SUM (  (dtpd.dtpd_srnoend - dtpd.dtpd_srnostart + 1) * dtpd.dtpd_indwt),0) <> 0  "&
//		 + " UNION ALL "&
//		 + " SELECT   'DESPATCH TEA MADE', 'ALL', tpc.tpc_manid, si.si_date, NVL (SUM (  (SID.sid_srnoend - SID.sid_srnostart + 1) * dtpd.dtpd_indwt ),0 ) "&
//		 + " FROM fb_saleinvoice si, fb_sidetails SID, fb_dtpdetails dtpd,fb_teamadeproductcategory tpc, fb_teamadeproduct tmp  "&
//		 + " WHERE tpc.tpc_id = tmp.tpc_id AND dtpd.tmp_id = tmp.tmp_id AND SID.dtpd_id = dtpd.dtpd_id AND si.si_id = SID.si_id AND si.si_active = '1'  "&
//		 + " GROUP BY (tpc.tpc_manid, si.si_date)  "&
//		 + " HAVING NVL (SUM ((SID.sid_srnoend - SID.sid_srnostart + 1) * dtpd.dtpd_indwt ), 0) <> 0 "&
//		 + " UNION ALL "&
//		 + " SELECT   'UNSORTED', 'ALL', tpc.tpc_manid, pludate, SUM (qty)  "&
//		 + " FROM (SELECT ddu.tpc_id tpc_id, ddp.ddp_pluckingdate pludate, NVL (SUM (ddu.ddu_quantity), 0) qty  "&
//		 + "         FROM fb_dailydryerproduct ddp, fb_dailydryerunsorted ddu "& 
//		 + "        WHERE ddp.ddp_pk = ddu.ddp_pk AND ddp.ddp_type <> 'O'  "&
//		 + "       GROUP BY (ddu.tpc_id, ddp.ddp_pluckingdate)  union all select   TPC_ID,  PT_DATE, sum(nvl(PT_QUANTITY,0)) from fb_packteatransfer  where pt_trantype = 'R' group by TPC_ID,  PT_DATE "&
//		 + "       UNION ALL  "&
//		 + "       SELECT   tmp.tpc_id tpc_id, dtmp_sortdate pludate, -NVL (SUM (dtmp.dtmp_sortquantodayty), 0) qty  "&
//		 + "         FROM fb_dailysortedteamadeproduct dtmp, fb_teamadeproduct tmp WHERE dtmp.tmp_id = tmp.tmp_id  "&
//		 + "        GROUP BY (tmp.tpc_id, dtmp.dtmp_sortdate)) d1, fb_teamadeproductcategory tpc  "&
//		 + "  WHERE (tpc.tpc_id = d1.tpc_id)  "&
//		 + " GROUP BY (tpc.tpc_manid, pludate)  "&
//		 + " HAVING SUM (qty) <> 0  "&
//		 + " UNION ALL  "&
//		 + " SELECT 'SORTED BUT NOT PACKED', 'ALL', tpc.tpc_manid, pludate, SUM (qty)  "&
//		 + "   FROM (SELECT tmp.tpc_id tpc_id, dtmp_sortdate pludate, NVL (SUM (dtmp.dtmp_sortquantodayty), 0) qty "&
//		 + "           FROM fb_dailysortedteamadeproduct dtmp, fb_teamadeproduct tmp  "&
//		 + "          WHERE dtmp.tmp_id = tmp.tmp_id  "&
//		 + "         GROUP BY (tmp.tpc_id, dtmp.dtmp_sortdate)  "&
//		 + "         UNION ALL  "&
//		 + "         SELECT tmp.tpc_id tpc_id, dtp.dtp_date pludate, -NVL (SUM((dtpd.dtpd_srnoend - dtpd.dtpd_srnostart + 1 ) * dtpd.dtpd_indwt),0 ) qty  "&
//		 + "           FROM fb_dailyteapacked dtp, fb_dtpdetails dtpd, fb_teamadeproduct tmp  "&
//		 + "          WHERE dtp.dtp_id = dtpd.dtp_id AND tmp.tmp_id = dtpd.tmp_id  "&
//		 + "         GROUP BY (tmp.tpc_id, dtp.dtp_date)) d1, fb_teamadeproductcategory tpc  "&
//		 + "  WHERE (tpc.tpc_id = d1.tpc_id)  "&
//		 + " GROUP BY (tpc.tpc_manid, pludate) HAVING SUM (qty) <> 0  "&
//		 + " UNION ALL "&
//		 + " SELECT 'PACKED BUT AWAITING DESPATCH', 'ALL', tpc.tpc_manid, pludate, SUM (qty)  "&
//		 + "   FROM (SELECT tmp.tpc_id tpc_id, dtp.dtp_date pludate, NVL(SUM((dtpd.dtpd_srnoend - dtpd.dtpd_srnostart + 1 ) * dtpd.dtpd_indwt ), 0 ) qty  "&
//		 + "           FROM fb_dailyteapacked dtp, fb_dtpdetails dtpd,fb_teamadeproduct tmp  "&
//		 + "          WHERE dtp.dtp_id = dtpd.dtp_id AND tmp.tmp_id = dtpd.tmp_id  "&
//		 + "         GROUP BY (tmp.tpc_id, dtp.dtp_date)  "&
//		 + "         UNION ALL  "&
//		 + "         SELECT tmp.tpc_id tpc_id, si.si_date pludate, -NVL (SUM((SID.sid_srnoend - SID.sid_srnostart + 1) * dtpd.dtpd_indwt ),0) qty  "&
//		 + "           FROM fb_dtpdetails dtpd LEFT OUTER JOIN fb_sidetails SID ON dtpd.dtpd_id = SID.dtpd_id LEFT OUTER JOIN fb_saleinvoice si ON SID.si_id = si.si_id,fb_teamadeproduct tmp  "&
//		 + "          WHERE dtpd.tmp_id = tmp.tmp_id AND si.si_active = '1'  "&
//		 + "          GROUP BY (tmp.tpc_id, si.si_date)) d1, fb_teamadeproductcategory tpc  "&
//		 + "  WHERE (tpc.tpc_id = d1.tpc_id) "&
//		 + " GROUP BY (tpc.tpc_manid, pludate)  "&
//		 + " HAVING SUM (qty) <> 0 UNION ALL  "&
//		 + " SELECT 'FACTORY TOTAL STOCK', 'ALL', tpc.tpc_manid, pludate, SUM (qty)  "&
//		 + "   FROM (SELECT ddu.tpc_id tpc_id, ddp.ddp_pluckingdate pludate, NVL(SUM(ddu.ddu_quantity), 0) qty  "&
//		 + "           FROM fb_dailydryerproduct ddp, fb_dailydryerunsorted ddu "& 
//		 + "          WHERE ddp.ddp_pk = ddu.ddp_pk AND ddp.ddp_type <> 'O'  "&
//		 + "         GROUP BY (ddu.tpc_id, ddp.ddp_pluckingdate) union all select   TPC_ID,  PT_DATE, sum(nvl(PT_QUANTITY,0)) from fb_packteatransfer  where pt_trantype = 'R' group by TPC_ID,  PT_DATE  UNION ALL  "&
//		 + " 	SELECT tmp.tpc_id tpc_id, si.si_date pludate, -NVL (SUM((SID.sid_srnoend - SID.sid_srnostart + 1) * dtpd.dtpd_indwt ),0) qty  "&
//		 + "           FROM fb_dtpdetails dtpd LEFT OUTER JOIN fb_sidetails SID ON dtpd.dtpd_id = SID.dtpd_id LEFT OUTER JOIN fb_saleinvoice si ON SID.si_id = si.si_id ,fb_teamadeproduct tmp  "&
//		 + "          WHERE dtpd.tmp_id = tmp.tmp_id AND si.si_active = '1' "&
//		 + "         GROUP BY (tmp.tpc_id, si.si_date)) d1,fb_teamadeproductcategory tpc  "&
//		 + "  WHERE (tpc.tpc_id = d1.tpc_id)  "&
//		 + " GROUP BY (tpc.tpc_manid, pludate) HAVING SUM (qty) <> 0  "&
//		 + " UNION ALL  "&
//		 + " SELECT   'ALL', 'ALL', 'RAINFALL IN INCH', wr.wr_date, NVL (SUM (wr.wr_rainfall), 0)  "&
//		 + " FROM fb_weatherreport wr  "&
//		 + " GROUP BY (wr.wr_date) HAVING NVL (SUM (wr.wr_rainfall), 0) <> 0  "&
//		 + " UNION ALL  "&
//		 + " SELECT 'MANDAYS', 'ALL', 'MANUFACTURE MANDAYS' , tad.task_date,  "&
//		 + " 	tad.task_pmatodayty + tad.task_pfatodayty + 0.5 * tad.task_pmadtodayty + 0.5 * tad.task_pfadtodayty + 0.5 * tad.task_pmctodayty + 0.5 * tad.task_pfctodayty + tad.task_tmatodayty + tad.task_omatodayty + tad.task_tfatodayty + tad.task_ofatodayty + 0.5 * tad.task_tmadtodayty + 0.5 * tad.task_tfadtodayty + 0.5 * tad.task_tmctodayty + 0.5 * tad.task_tfctodayty + 0.5 * tad.task_omadtodayty + 0.5 * tad.task_ofadtodayty + 0.5 * tad.task_omctodayty + 0.5 * tad.task_ofctodayty "&
//		 + "   FROM fb_taskactivedaily tad, fb_kamsubhead kam, fb_expenseacsubhead esub  "&
//		 + "  WHERE tad.task_id = kam.kamsub_id AND nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and kam.kamsub_id = esub.eacsubhead_id AND (esub.eachead_id IN ('SLEG0016')) "&
//		 + " UNION ALL  "&
//		 + " SELECT 'FUEL CONSUMPTION', 'ALL', UPPER (ct.ct_manid), ddp.DDP_STARTRUNTIME, NVL(SUM(ddc.ddc_unitconsumed), 0) "&
//		 + "   FROM fb_dailydryerproduct ddp, fb_dailydryerconsumption ddc, fb_consumptiontype ct, fb_machine mac  "&
//		 + " WHERE ddp.ddp_pk = ddc.ddp_pk AND ddp.dryer_id = mac.machine_id AND TRIM (mac.machine_type) in ('DRY','SORT','TROUGH','CTC','BOILER') AND ddc.ct_id = ct.ct_id  "&
//		 + " GROUP BY (UPPER (ct.ct_manid), ddp.DDP_STARTRUNTIME)  "&
//		 + " HAVING NVL (SUM (ddc.ddc_unitconsumed), 0) <> 0 "&
//		 + "  WITH READ ONLY "


execute immediate :ls_text using sqlca;
if sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During DMR View Creation',sqlca.sqlerrtext)
	return
end if
end event

type em_3 from editmask within w_gtepror014
integer x = 1691
integer y = 40
integer width = 197
integer height = 84
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
borderstyle borderstyle = stylelowered!
string mask = "0000"
end type

type st_3 from statictext within w_gtepror014
integer x = 1458
integer y = 48
integer width = 247
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Season :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_gtepror014
integer x = 795
integer y = 52
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

type dp_2 from datepicker within w_gtepror014
integer x = 942
integer y = 36
integer width = 389
integer height = 100
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2015-06-17"), Time("14:59:03.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_gtepror014
integer x = 389
integer y = 36
integer width = 389
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2015-06-17"), Time("14:59:03.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_1 from statictext within w_gtepror014
integer x = 9
integer y = 52
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

type cb_1 from commandbutton within w_gtepror014
integer x = 2048
integer y = 36
integer width = 265
integer height = 100
integer taborder = 40
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

//if rb_1.checked then
//	ls_year_ind = 'F' 
//else
	ls_year_ind = 'C' 
//end if

ls_frdt = dp_1.text 
ls_todt = dp_2.text
ll_season = long(em_3.text)

select decode(:ls_year_ind,'C','01/01/'||to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'),to_char(to_date((decode(sign(to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy')))||'0401'),'yyyymmdd'),'dd/mm/yyyy')),
		(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'dd/mm/')||to_char((to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1))),
		(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'dd/mm/')||(to_number(to_char(to_date(:ls_todt,'dd/mm/yyyy'),'yyyy'))-1)),
		decode(:ls_year_ind,'C','01/01/'||to_char((to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1)),to_char(to_date((decode(sign(to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-2,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1)||'0401'),'yyyymmdd'),'dd/mm/yyyy'))
  into :ls_ysdt,:ls_ly_frdt,:ls_ly_todt,:ls_ly_ysdt from dual;

dw_1.retrieve(ls_frdt,ls_todt,ls_ysdt,ls_ly_frdt,ls_ly_todt,ls_ly_ysdt,ls_year_ind,ll_season) 

setpointer(arrow!)

end event

type cb_2 from commandbutton within w_gtepror014
integer x = 2313
integer y = 36
integer width = 265
integer height = 100
integer taborder = 50
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

type dw_1 from datawindow within w_gtepror014
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 144
integer width = 3387
integer height = 2028
string dataobject = "dw_gtepror014"
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

