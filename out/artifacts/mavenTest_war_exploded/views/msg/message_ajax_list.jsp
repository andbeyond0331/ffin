<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:forEach var="tmp" items="${list}">
    <div class="chat_list_box${tmp.msgRoom } chat_list_box">
        <div type="button" class="chat_list" msgRoom="${tmp.msgRoom }" other-id="${tmp.other_id }">
            <!-- active-chat -->
            <div class="chat_people">
                <div class="chat_img" >
                    <a href="other_profile?other_id=${tmp.other_id }">
                        <img src="../../../resources/image/${tmp.profile}" alt="sunil" >
                    </a>
                </div>
                <div class="chat_ib">
                    <h5>${tmp.other_id }<span class="chat_date">${tmp.msgSendDate }</span>
                    </h5>
                    <div class="row">
                        <div class="col-8">
                            <p>${tmp.msgContent }</p>

                        </div>
                        <c:if test="${tmp.unread > 0 }">
                            <div class="col-4 unread${tmp.msgRoom }">
                                <span class="badge bg-danger">${tmp.unread }</span>
                            </div>
                        </c:if>
                            <%-- 만약 현재사용자가 안읽은 메세지 갯수가 0보다 클때만 badge를 표시한다. --%>

                    </div>
                </div>
            </div>
        </div>
    </div>
</c:forEach>
