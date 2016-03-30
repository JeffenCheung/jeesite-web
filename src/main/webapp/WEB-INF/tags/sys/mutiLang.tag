<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="langKey" type="java.lang.String" required="true" description="语言内容键值"%>
<%@ attribute name="langArg" type="java.lang.String" required="false" description="语言内容变量替换值(半角逗号分割)"%>
<c:if test="${not empty langKey}">
	${fns:getLang(langKey, langArg)}
</c:if>
