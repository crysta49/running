package com.srpost.salmon.web.mvc.view;

import static com.srpost.salmon.constant.Constant.ENCODING;
import static com.srpost.salmon.constant.Constant.JSON_VIEW_DATA_KEY;
import static com.srpost.salmon.constant.Constant.JSON_VIEW_PASS_KEY;
import static com.srpost.salmon.constant.StringPool.EMPTY;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;
import org.springframework.web.servlet.view.AbstractView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.srpost.salmon.bean.BaseKeyValueBean;
import com.srpost.salmon.lang.StringUtil;

/**
 * application/json 뷰
 *
 * @author  finkle
 * @date    2014-10-16
 * @since   2.0
 */
public class JsonView extends AbstractView {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Override
    protected void prepareResponse(HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("application/json; charset=" + ENCODING);
        response.setCharacterEncoding(ENCODING);
    }

    @Override
    protected void renderMergedOutputModel(@SuppressWarnings("rawtypes") Map model, HttpServletRequest request, HttpServletResponse response) throws Exception {

        Object object = model.get(JSON_VIEW_DATA_KEY);
        if (object != null) {

            Object pass = model.get(JSON_VIEW_PASS_KEY);
            if (pass != null) {
                response.getWriter().write( StringUtil.toString(object) );
            } else {

                if (object instanceof Integer || object instanceof String) {
                    BaseKeyValueBean baseKeyValueBean = new BaseKeyValueBean();
                    baseKeyValueBean.setValue(StringUtil.toString(object));
                    object = baseKeyValueBean;
                }

                ObjectMapper objMapper = new ObjectMapper();
                String jackson = objMapper.writeValueAsString(object);
                response.getWriter().write( jackson );
            }
        } else {
            Exception ex = (Exception)model.get(SimpleMappingExceptionResolver.DEFAULT_EXCEPTION_ATTRIBUTE);
            if (ex != null)
                response.getWriter().write( StringUtil.toString(ex) );
            else
                response.getWriter().write( EMPTY );
        }
    }
}