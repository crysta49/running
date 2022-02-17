package com.srpost.cm.fe.bbs;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.cm.bo.base.bbs.conf.BbsConfBean;
import com.srpost.cm.bo.base.bbs.conf.BbsConfUtil;
import com.srpost.cm.bo.base.bbs.core.BbsBean;
import com.srpost.cm.bo.base.bbs.core.BbsUtil;
import com.srpost.cm.bo.base.bbs.core.IBbsService;
import com.srpost.cm.bo.base.user.UserBean;
import com.srpost.cm.bo.base.user.UserUtil;
import com.srpost.salmon.bean.BaseFileBean;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.FileUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.web.mvc.controller.BaseController;

import static com.srpost.salmon.constant.StringPool.N;
import static com.srpost.salmon.constant.StringPool.ONE;
import static com.srpost.salmon.constant.StringPool.Y;

/**
 * 고객단 게시판 컨트롤러
 * 
 * @author  finkle
 * @date    2015-12-29
 * @since   2.0
 */
@Controller
@RequestMapping(value="/fe/bbs")
public class FeBbsController extends BaseController {

    @Resource
    IBbsService service;

    /**
     * 게시물 목록 조회
     */
    @RequestMapping(value="NR_list.do", method=RequestMethod.GET)
    public String list(BbsBean bean, ModelMap model) {

        Integer bbsCd = bean.getBbsCd();
        if ( StringUtil.isEmpty(bbsCd) ) {
            return alertAndBack(model, Message.BASE_BBS_FAIL_KEY);
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if ( StringUtil.isEmpty(confBean) ) {
            return alertAndBack(model, "bbs.conf.no.exist.fail");
        }

        bean.setDelYn(N);
        
        // 공개글 사용일 경우 고객단에서는 공개글만 조회
        if (StringUtil.equals(Y, confBean.getOpenYn()))
            bean.setOpenYn(Y);
        
        model.addAttribute("confBean", confBean);
        model.addAttribute("pagerBean", service.list(bean, confBean));
        
        return baseUrl + BbsConfUtil.getFolderNm(confBean) + "/NR_list";
    }

    /**
     * 게시물 상세 조회
     */
    @RequestMapping(value="NR_view.do", method=RequestMethod.GET)
    public String view(BbsBean bean, 
    		HttpServletRequest request, HttpServletResponse response, ModelMap model) {

        Integer bbsCd = bean.getBbsCd();
        if ( StringUtil.isEmpty(bbsCd) ) {
            return alertAndBack(model, Message.BASE_BBS_FAIL_KEY);
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if ( StringUtil.isEmpty(confBean) ) {
            return alertAndBack(model, "bbs.conf.no.exist.fail");
        }
        
        // 이전, 다음글 조회를 위한 값 설정 : 삭제여부, 공개여부
        bean.setDelYn(N);
        if (StringUtil.equals(Y, confBean.getOpenYn()))
            bean.setOpenYn(Y);
        
        BbsBean dataBean = service.viewWithPrevNext(bean, confBean, BbsUtil.needUpdateReadCnt(bean, request, response));
        
        if ( StringUtil.isEmpty(dataBean) ) {
            return alertAndBack(model, Message.COMMON_NODATA_FAIL_KEY);
        }

        // 삭제 게시글일 경우
        if ( StringUtil.equals(Y, dataBean.getDelYn()) ) {
            return alertAndBack(model, "bbs.already.deleteted.fail");
        }
        
        // 비공개 게시글일 경우
        if ( StringUtil.equals(N, dataBean.getOpenYn()) ) {
            if ( !FeBbsUtil.hasAuth(request, dataBean.getUserKey()) ) {
                return alertAndBack(model, "bbs.no.open.data.fail");
            }
        }

        model.addAttribute("confBean", confBean);
        model.addAttribute("dataBean", dataBean);

        return baseUrl + BbsConfUtil.getFolderNm(confBean) + "/NR_view";
    }
    
    /**
     * 게시물 등록 폼
     */
    @RequestMapping(value="NR_insertForm.do", method=RequestMethod.GET)
    public String insertForm(BbsBean bean, HttpServletRequest request, ModelMap model) {

        Integer bbsCd = bean.getBbsCd();
        if ( StringUtil.isEmpty(bbsCd) ) {
            return alertAndBack(model, Message.BASE_BBS_FAIL_KEY);
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if ( StringUtil.isEmpty(confBean) ) {
            return alertAndBack(model, "bbs.conf.no.exist.fail");
        }
        
        model.addAttribute("confBean", confBean);
        
        // 관리자 전용일 경우
        if ( StringUtil.equals(Y, confBean.getAdmYn()) ) {
            return alertAndBack(model, Message.COMMON_ACCESS_FAIL_KEY);
        }
        
        UserBean userBean = UserUtil.getSession(request);
        if (userBean == null) {
            return alertAndBack(model, "bbs.login.require.fail");
        }
        bean.setUserBean(userBean);
        
        return baseUrl + BbsConfUtil.getFolderNm(confBean) + "/NR_insertForm";
    }

    /**
     * 게시물 등록 액션
     */
    @RequestMapping(value="TR_insertAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(BbsBean bean, HttpServletRequest request, ModelMap model) {
        
        Integer bbsCd = bean.getBbsCd();
        if ( StringUtil.isEmpty(bbsCd) ) {
            return responseText(model, Message.fail(Message.BASE_BBS_FAIL_KEY));
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if ( StringUtil.isEmpty(confBean) ) {
            return responseText(model, Message.fail("bbs.conf.no.exist.fail"));
        }
        
        if ( StringUtil.equals(Y, confBean.getAdmYn()) ) {
            return responseText(model, Message.fail(Message.COMMON_ACCESS_FAIL_KEY));
        }
        
        UserBean userBean = UserUtil.getSession(request);
        if (userBean == null) {
            return responseText(model, Message.fail("bbs.login.require.fail"));
        }
        
        if (StringUtil.equals(confBean.getTypeCd(), BbsConfUtil.QNA)) {
            bean.setAlertCds(BbsUtil.parseAlertCds(request));
        }
        
        List<BaseFileBean> fileList = FileUtil.getUploadFile(request);
        bean.setFileList(fileList);
        
        int affected = service.insertAction(bean, confBean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_INSERT_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    
    /**
     * 게시물 댓글 폼 (계층형)
     */
    @RequestMapping(value="NR_replyForm.do", method=RequestMethod.GET)
    public String replyForm(BbsBean bean, HttpServletRequest request, ModelMap model) {

        Integer bbsCd = bean.getBbsCd();
        if ( StringUtil.isEmpty(bbsCd) ) {
            return alertAndBack(model, Message.BASE_BBS_FAIL_KEY);
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if ( StringUtil.isEmpty(confBean) ) {
            return alertAndBack(model, "bbs.conf.no.exist.fail");
        }
        
        model.addAttribute("confBean", confBean);
        
        // 관리자 전용일 경우
        if ( StringUtil.equals(Y, confBean.getAdmYn()) ) {
            return alertAndBack(model, Message.COMMON_ACCESS_FAIL_KEY);
        }

        BbsBean dataBean = service.view(bean, confBean, false);
        if ( StringUtil.isEmpty(dataBean) ) {
            return alertAndBack(model, Message.COMMON_NODATA_FAIL_KEY);
        }
        
        dataBean.setTitle("RE: " + dataBean.getTitle());

        model.addAttribute("dataBean", dataBean);
        
        UserBean userBean = UserUtil.getSession(request);
        if (userBean == null) {
            return alertAndBack(model, "bbs.login.require.fail");
        }
        dataBean.setUserBean(userBean);
        
        return baseUrl + BbsConfUtil.getFolderNm(confBean) + "/NR_replyForm";
    }
    
    /**
     * 게시물 댓글 액션 (계층형)
     */
    @RequestMapping(value="TR_replyAction.do", method=RequestMethod.POST)
    public ModelAndView replyAction(BbsBean bean, HttpServletRequest request, ModelMap model) {

        Integer bbsCd = bean.getBbsCd();
        if ( StringUtil.isEmpty(bbsCd) ) {
            return responseText(model, Message.fail(Message.BASE_BBS_FAIL_KEY));
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if ( StringUtil.isEmpty(confBean) ) {
            return responseText(model, Message.fail("bbs.conf.no.exist.fail"));
        }
        
        if ( StringUtil.equals(Y, confBean.getAdmYn()) ) {
            return responseText(model, Message.fail(Message.COMMON_ACCESS_FAIL_KEY));
        }
        
        UserBean userBean = UserUtil.getSession(request);
        if (userBean == null) {
            return responseText(model, Message.fail("bbs.login.require.fail"));
        }
        
        List<BaseFileBean> fileList = FileUtil.getUploadFile(request);
        bean.setFileList(fileList);
        
        int affected = service.insertAction(bean, confBean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_INSERT_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 게시물 수정 폼
     */
    @RequestMapping(value="NR_updateForm.do", method=RequestMethod.GET)
    public String updateForm(BbsBean bean, HttpServletRequest request, ModelMap model) {

        Integer bbsCd = bean.getBbsCd();
        if ( StringUtil.isEmpty(bbsCd) ) {
            return alertAndBack(model, Message.BASE_BBS_FAIL_KEY);
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if ( StringUtil.isEmpty(confBean) ) {
            return alertAndBack(model, "bbs.conf.no.exist.fail");
        }
        
        model.addAttribute("confBean", confBean);
        
        BbsBean dataBean = service.view(bean, confBean, false);
        if ( StringUtil.isEmpty(dataBean) ) {
            return alertAndBack(model, Message.COMMON_NODATA_FAIL_KEY);
        }
        
        if (StringUtil.equals(confBean.getTypeCd(), BbsConfUtil.QNA)) {
            // 처리상태가 완료일 경우 수정 불가
            if (StringUtil.equals(dataBean.getStatusCd(), BbsConfUtil.COMPLETE)) {
                return alertAndBack(model, Message.COMMON_NOSUPPORT_FAIL_KEY);
            }
        }
        
        if ( !FeBbsUtil.hasAuth(request, dataBean.getUserKey()) ) {
            return alertAndBack(model, Message.COMMON_ACCESS_FAIL_KEY);
        }
        
        model.addAttribute("dataBean", dataBean);
        
        return baseUrl + BbsConfUtil.getFolderNm(confBean) + "/NR_updateForm";
    }
    
    /**
     * 게시물 수정 액션
     */
    @RequestMapping(value="TR_updateAction.do", method=RequestMethod.POST)
    public ModelAndView updateAction(BbsBean bean, HttpServletRequest request, ModelMap model) {

        Integer bbsCd = bean.getBbsCd();
        if ( StringUtil.isEmpty(bbsCd) ) {
            return responseText(model, Message.fail(Message.BASE_BBS_FAIL_KEY));
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if ( StringUtil.isEmpty(confBean) ) {
            return responseText(model, Message.fail("bbs.conf.no.exist.fail"));
        }
        
        BbsBean dataBean = service.view(bean, confBean, false);
        if ( StringUtil.isEmpty(dataBean) ) {
            return responseText(model, Message.fail(Message.COMMON_NODATA_FAIL_KEY));
        }
        
        if ( !FeBbsUtil.hasAuth(request, dataBean.getUserKey()) ) {
            return responseText(model, Message.fail(Message.COMMON_ACCESS_FAIL_KEY));
        }        
        
        if (StringUtil.equals(confBean.getTypeCd(), BbsConfUtil.QNA)) {
            // 처리상태가 완료일 경우 수정 불가
            if (StringUtil.equals(dataBean.getStatusCd(), BbsConfUtil.COMPLETE)) {
                return responseText(model, Message.fail(Message.COMMON_NOSUPPORT_FAIL_KEY));
            }
            bean.setAlertCds(BbsUtil.parseAlertCds(request));
        }
        
        List<BaseFileBean> fileList = FileUtil.getUploadFile(request);
        bean.setFileList(fileList);

        int affected = service.updateAction(bean, confBean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 게시물 삭제 액션
     */
    @RequestMapping(value="TR_deleteAction.do", method=RequestMethod.POST)
    public ModelAndView deleteAction(BbsBean bean, HttpServletRequest request, ModelMap model) {

        Integer bbsCd = bean.getBbsCd();
        if ( StringUtil.isEmpty(bbsCd) ) {
            return responseText(model, Message.fail(Message.BASE_BBS_FAIL_KEY));
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if ( StringUtil.isEmpty(confBean) ) {
            return responseText(model, Message.fail("bbs.conf.no.exist.fail"));
        }
        
        BbsBean dataBean = service.view(bean, confBean, false);
        if ( StringUtil.isEmpty(dataBean) ) {
            return responseText(model, Message.fail(Message.COMMON_NODATA_FAIL_KEY));
        }
        
        if (StringUtil.equals(confBean.getTypeCd(), BbsConfUtil.QNA)) {
            // 처리상태가 접수가 아닐 경우 삭제 불가
            if (!StringUtil.equals(dataBean.getStatusCd(), BbsConfUtil.RECEIVE)) {
                return responseText(model, Message.fail(Message.COMMON_NOSUPPORT_FAIL_KEY));
            }
        }
        
        if ( !FeBbsUtil.hasAuth(request, dataBean.getUserKey()) ) {
            return responseText(model, Message.fail(Message.COMMON_ACCESS_FAIL_KEY));
        }
        
        int affected = service.deleteAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_DELETE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
}
