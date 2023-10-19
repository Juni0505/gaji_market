<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/chat.css" rel='stylesheet' type='text/css'>
<link rel="icon" href="favicon.ico" type="image/x-icon">
</head>

<body>
	<div class="wrapper">
		<div class="container">
			<div class="left">
				<div class="top">
					<!-- 채팅중인 회원 검색 기능 -->
					<input type="text" placeholder="Search" /> <a href="javascript:;" class="search"></a>
				</div>
				<!-- 채팅중인 회원 list -->
				<ul class="people">
					<c:forEach var="item1" items="${chatRoomList}" varStatus="status">
						<input type="hidden" id="${item1.chatId }" value="${item1.chatId }">
						<li class="person" data-chat="person${status.count}" data-chatid="${item1.chatId}">
							<img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/382994/dog.png" alt="" />
							<span class="name">${item1.nickname}</span>
							<c:forEach var="item2" items="${item1.chatInfo}">
								<span class="time">
									<script>
										var dateString = "${item2.createAt}";
										var date = new Date(dateString);
										var today = new Date();

										var year = date.getFullYear();
										var month = date.getMonth() + 1;
										var day = date.getDate();
										var hours = date.getHours();
										var minutes = date.getMinutes();

										if (today.getMonth() == month) {
											if (today.getDate() == day) {
												if (hours > 12) {
													document.write("오후 " + (hours - 12) + ":" + minutes);
												} else {
													document.write("오전 " + hours + ":" + minutes);
												}
											}
										} else {
											document.write(month + 1 + "월 " + day + "일");
										}
									</script>
								</span>
								<span class="preview">${item2.message }</span>
							</c:forEach>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="right">
				<div class="top">
					<!-- 현재 채팅중인 회원 이름 정보 -->
					<span>To: <span class="name"></span></span>
				</div>

				<div class="chat" data-chat="person1">
					<div class="conversation-start">
						<span>Today, 5:38 PM</span>
					</div>
					<c:forEach var="item1" items="${chatMessage}">
						<div class="bubble you">${item1.senderId }</div>
						<c:choose>
							<c:when test="${item1.senderId eq pageContext.request.userPrincipal.name}">
								<div class="bubble me">${item1.message}</div>
							</c:when>
							<c:otherwise>
								<div class="bubble you">${item1.message}</div>
							</c:otherwise>
						</c:choose>
						<!-- <div class="bubble you">${item1.senderId }</div> -->
					</c:forEach>
				</div>
				<div class="chat" data-chat="person2">
					<div class="conversation-start">
					</div>
				</div>

				<div class="write">
					<a href="javascript:;" class="write-link attach"></a> <input type="text" id="msg" /> <a
						href="javascript:;" class="write-link smiley"></a>
					<button class="write-link send" type="button" id="button-send"></button>
				</div>
			</div>
		</div>
	</div>

	<script>
	let activeChat;
	// chatId를 많이 사용하므로 전역변수 선언
	var chatId;
	// 현제 접속 된 계정
	var username = "${username}";
	// socket들을 담을 객체 생성
	var endPoint = "${pageContext.request.contextPath}/chat";
	$(document).ready(function () {
		// 활성 채팅 설정 및 friends, chat 객체 생성
		document.querySelector('.chat[data-chat=person2]').classList.add('active-chat');
		document.querySelector('.person[data-chat=person2]').classList.add('active');
		
		let friends = {
				list: document.querySelector('ul.people'),
				all: document.querySelectorAll('.left .person'),
				name: ''
			},
			chat = {
				container: document.querySelector('.container .right'),
				current: null,
				person: null,
				name: document.querySelector('.container .right .top .name')
			};

		// 친구 클릭 이벤트 처리
		console.log("friends.all.forEach 실행 전2");
		friends.all.forEach(f => {
			console.log("friends.all.forEach");
			f.addEventListener('mousedown', () => {
				// 클릭한 noRoom값 전달
				chatId = parseInt(f.getAttribute('data-chatid'));
				if (!f.classList.contains('active')) {
					setActiveChat(f)
				}
			});
		});


		// 리스트에서 메시지 시간 체크
		function formatDate(dateString) {
			var date = new Date(dateString);
			var today = new Date();
			var year = date.getFullYear();
			var month = date.getMonth() + 1;
			var day = date.getDate();
			var hours = date.getHours();
			var minutes = date.getMinutes();

			if (today.getMonth() == month) {
				if (today.getDate() == day) {
					if (hours > 12) {
						return "오후 " + (hours - 12) + ":" + minutes;
					} else {
						return "오전 " + hours + ":" + minutes;
					}
				}
			} else {
				return month + 1 + "월 " + day + "일";
			}
		}

		// 채팅 활성화 및 비활성화
		function setActiveChat(f) {
			if (chatId != null){
				if(stomp != null)
					stomp.disconnect();							
			}

			$.ajax({
				type: 'get',
				url: '${pageContext.request.contextPath}/chat/selectRoom',
				data: { "chatId": chatId },
				dataType: "json",
				success: function (result) { // 결과 성공 콜백함수
					console.log(result);
					friends.list.querySelector('.active').classList.remove('active');
					f.classList.add('active');
					chat.current = chat.container.querySelector('.active-chat');
					chat.person = f.getAttribute('data-chat');
					chat.current.classList.remove('active-chat');
					chat.container.querySelector('[data-chat="' + chat.person + '"]').classList.add('active-chat');
					friends.name = f.querySelector('.name').innerText;
					chat.name.innerHTML = friends.name;
					// WebSocket 연결 생성 함수
					createWebSocketConnection(username);

					htmlVal = '		<div class="conversation-start"><span></div>'; // TODO(1013 김종호 날짜 기록)
					for (var i = 0; i < result.length; i++) {
						var item1 = result[i];
						if (item1.senderId == '${pageContext.request.userPrincipal.name}') {
							htmlVal += `					<div class="bubble me">\${item1.message}</div>`;
						} else {
							htmlVal += `					<div class="bubble you">\${item1.message}</div>`;
						}
					}
					//</div>
					chat.container.querySelector('[data-chat="' + chat.person + '"]').innerHTML = htmlVal;
					activeChat = document.querySelector('.chat.active-chat');
				},
				error: function (request, status, error) { // 결과 에러 콜백함수
					console.log(error)
				}
			});
		}  // setActiveChat
		let stomp;
		// socket 생성
		function createWebSocketConnection(person) {
			var ws = new SockJS(endPoint);
			stomp = Stomp.over(ws);

			$("#button-send").on("click", (e) => {
				send();
			}); // click event send 

			// 엔터 키 입력시 send() 실행F
			$("#msg").on("keydown", (e) => {
				if (e.key === "Enter") {
					e.preventDefault();
					e.stopPropagation();
					send();
				}
			}); // keydown event enter 

		


		stomp.connect({}, function (frame) {
			console.log('Connected: ' + frame);
			/* 
			stomp.subscribe("sub/chat/room/" + chatId, function (chat) {
				printMessage(JSON.parse(msg.body).Message);
			});
				*/
			stomp.subscribe("/sub/chat/room/" + chatId, function (chat) {
				var content = JSON.parse(chat.body);

				if (activeChat) {
					const messageElement = document.createElement('div');
					if(username == content.senderId){
						messageElement.className = 'bubble me';
					}else {
						messageElement.className = 'bubble you';
					}
					messageElement.textContent = content.message;
					activeChat.appendChild(messageElement);
				}
			});
		});  // connect cb function
		}  // createWebSocketConnection
		// 메시지 보내기
		function send() {
			if (!activeChat) {
				return;
			}
			// 메시지 내용 message 변수에 저장
			const message = $("#msg").val().trim();

			if (message !== "") {
				// 메시지 정보를 /chat/room으로 보냄
				stomp.send("/pub/chat/message", {}, JSON.stringify({
					'senderId': username,
					'chatId': chatId,
					'message': message
				}))
				console.log("보내짐");
				$('#msg').val('');
			}

			// 메시지 내용이 있다면 화면에 메시지 내용 출력
			/* 
			if (message !== "") {
				const messageElement = document.createElement('div');
				messageElement.className = 'bubble me';
				messageElement.textContent = message;
				activeChat.appendChild(messageElement);
				$('#msg').val('');
			}
			*/
		} // send function	

		
	});  // document ready
	</script>
</body>
</html>