<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style></style>
<script type="text/javascript">

    $(document).ready(function(){
        $("#sendMessageModal").on('hide.bs.modal', function (e) {
            $("#sendMessageModal").find("#recvId").text("");
            $("#sendMessageModal").find("#writeNote").val("");
            e.stopImmediatePropagation();
        });
        $("#userReportModal").on('hide.bs.modal', function (e) {

            $("#userReportModal").find("#reportTargetIdModal").text("");
            $("#userReportModal").find("#reportLinkModal").val("");
            $("#userReportModal").find("#reportContentModal").val("");
            $("#reportType").val("1").prop("selected", true);
            e.stopImmediatePropagation();
        });
        // 쪽지 보내기 버튼
        $(document).on("click", ".user-message", function (e){
            e.preventDefault();

            //var recvUserId = $(e.currentTarget).next().text();
            //var recvUserId = $(e.currentTarget).parent().parent().next().text(); // ^^..
            var recvUserId = $(this).attr('idx')


            $('#sendMessageModal').find("#recvId").text(recvUserId);

            $('#sendMessageModal').modal('show');
        })

        // 쪽지 전송 버튼
    $("#sendMsg").on("click", function () {
        var modal = $('#sendMessageModal');
        var recvId = modal.find("#recvId").text();
        var content = modal.find("#writeNote").val();
        var sendUserId = '${sessionScope.user.userId}';

        $.ajax(
            {
                url : "/msg/json/message_send_inlist",
                method : "POST",
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                data :{
                    msgRoom : 0,
                    other_id : recvId,
                    msgContent : content
                },
                success : function(data)
                {
                    alert("메세지를 보냈습니다. ")

                    var sendUserId = '${sessionScope.user.userId}';
                    console.log("message.socket::::" + socket);
                    if(socket) {
                        // websocket에 보내기!!! (message, 보내는이, 받는이)
                        let socketMessage = "message,"+sendUserId+","+recvId;
                        console.log("socketM::::" + socketMessage);
                        socket.send(socketMessage);
                    }


                    modal.find("#recvId").text("");
                    modal.find("#writeNote").val("");
                    $('#sendMessageModal').modal('hide');
                }

            });//end ajax


        });//end sendMsg

        // 상대방 프로필 보기
        $(document).on("click", ".user-view", function (e){
            e.preventDefault();
            //var recvUserId = $(e.currentTarget).next().text();
            var recvUserId = $(this).attr('idx')
            self.location='/user/getUserProfile/'+recvUserId;
        })

        // 상대방 신고하기 버튼 클릭
        $(document).on("click", ".user-report", function (e){
            e.preventDefault();
            var recvUserId = $(this).attr('idx')
            var link = window.location.href;

            var modal = $('#userReportModal');
            modal.find("#reportTargetIdModal").text(recvUserId);
            modal.find("#reportLinkModal").text(link);
            $('#userReportModal ').modal('show');
        })

        // 상대방 신고하기
        $("#reportModal").on("click", function () {

            var modal = $('#userReportModal');
            var reportTargetId = modal.find("#reportTargetIdModal").text();
            var reportLink = modal.find("#reportLinkModal").text();
            var reportUserId = '${sessionScope.user.userId}';
            var reportType = modal.find("#reportType").val();
            var reportContent = modal.find("#reportContentModal").val();


            $.ajax(
                {
                    url : "/qna/json/addReport",
                    method : "POST",
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    data :{
                        reportUserId : reportUserId,
                        reportTargetId : reportTargetId,
                        reportContent : reportContent,
                        reportLink : reportLink,
                        reportType : reportType
                    },
                    success : function(data)
                    {
                        alert(" 신고처리 되었습니다. ")

                        modal.find("#reportTargetIdModal").text("");
                        modal.find("#reportLinkModal").val("");
                        modal.find("#reportContentModal").val("");
                        $("#reportType").val("1").prop("selected", true);

                        $('#userReportModal').modal('hide');
                    }

                });//end ajax


        });//end sendMsg

    });

</script>
<body>


<!-- 쪽지 Modal -->
<div class="modal fade" id="sendMessageModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="sendMessageModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="sendMessageModalLabel">쪽지 보내기</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"></span>
                </button>
            </div>
            <div class="modal-body">
                <div>
                    <span>받는 사람 : </span>
                    <span id="recvId"></span>
                </div>
                <div class="writing_area">
                    <textarea id="writeNote" style="resize:none;" rows="5" cols="55" title="쪽지 내용을 입력해 주세요."></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="sendMsg" name="sendMsg">보내기</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>

            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="userReportModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="userReportModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form class="report-form">
                <div class="modal-body">

                    <div style="display:flex; justify-content: center; margin-top: 10px;">
                        <h5 style="margin: 0; box-shadow: inset 0 -11px 0 #fae100; font-size: 22px; width: fit-content;" id="userReportModalLabel">신고하기</h5>
                    </div>

                    <hr/>

                    <div style="padding: 0 5px;">
                        <div style="display: flex; flex-direction: column;">
                            <span style="font-weight: bold;">신고 대상</span>
                            <span id="reportTargetIdModal" style="margin-top: 5px; background-color: rgba(37,50,60,0.07); padding: 10px 15px;border-radius: 5px;width: fit-content;"></span>
                        </div>

                        <div style="display: flex; flex-direction: column; margin: 10px 0;">
                            <span style="font-weight: bold;">신고 링크</span>
                            <span id="reportLinkModal" style="margin-top: 5px; background-color: rgba(37,50,60,0.07); padding: 10px 15px;border-radius: 5px;width: fit-content;"></span>
                        </div>


                        <div style="margin: 10px 0;">
                            <label for="reportType" class="reportType-label" style="font-weight: bold;">신고 유형</label>
                            <select class="form-select form-control" id="reportType" name="reportType" aria-label="Default select example" style="padding-left: 0; padding-right: 0;">
                                <option selected style="color: grey; padding-right: 0; padding-left: 0;">신고 유형을 선택해주세요</option>
                                <option value="1">광고/도배</option>
                                <option value="2">욕설/인신공격</option>
                                <option value="3">개인정보침해</option>
                                <option value="4">음란성/선정성</option>
                                <option value="5">명예훼손/저작권</option>
                                <option value="6">기타</option>
                            </select>
                        </div>

                        <div class="writing_area" style="display: flex; flex-direction: column; margin: 10px 0;">
                            <span style="margin-bottom: 5px; font-weight: bold;">신고 내용</span>
                            <textarea id="reportContentModal" style="resize:none; border: 0; background-color: rgba(37,50,60,0.07); border-radius: 5px; min-height: 100px; padding: 8px;"
                                      rows="2" cols="55" title="신고 내용을 입력해 주세요." ></textarea>
                        </div>

                    </div>

                    <hr/>

                    <div style="display: flex; justify-content: center;">
                        <button type="button" class="btn btn-cancle" data-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-default" id="reportModal" name="reportModal">신고</button>
                    </div>
                </div>
            </form>

        </div>
    </div>
</div>

</body>