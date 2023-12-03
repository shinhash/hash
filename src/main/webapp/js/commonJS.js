// homepage
function goHome(){
	let formInfo = document.createElement("form");
	formInfo.setAttribute("id", "pageControllDiv");
	formInfo.setAttribute("method", "post");
	formInfo.setAttribute("action", "/main/mainpage");
	document.body.appendChild(formInfo);
	formInfo.submit();
}

// bbsCatalList page
function goBbsCatalList(){
	let formInfo = document.createElement("form");
	formInfo.setAttribute("id", "pageControllDiv");
	formInfo.setAttribute("method", "post");
	formInfo.setAttribute("action", "/board/bbsCatalList");	
	document.body.appendChild(formInfo);
	formInfo.submit();
}

// postList page
function goPostList(bbsCatalIdInfo){
	let formInfo = document.createElement("form");
	formInfo.setAttribute("id", "pageControllDiv");
	formInfo.setAttribute("method", "post");
	formInfo.setAttribute("action", "/board/postListView");
	
	let bbsCatalId = document.createElement("input");
	bbsCatalId.setAttribute("name", "bbsCatalId");
	bbsCatalId.setAttribute("type", "hidden");
	bbsCatalId.setAttribute("value", bbsCatalIdInfo);
	
	formInfo.appendChild(bbsCatalId);
	
	document.body.appendChild(formInfo);
	formInfo.submit();
}

// sign in page
function goSignIn(){
	let formInfo = document.createElement("form");
	formInfo.setAttribute("id", "pageControllDiv");
	formInfo.setAttribute("method", "post");
	formInfo.setAttribute("action", "/sign/signInPage");
	document.body.appendChild(formInfo);
	formInfo.submit();
}

// sign up page
function goSignUp(){
	let formInfo = document.createElement("form");
	formInfo.setAttribute("id", "pageControllDiv");
	formInfo.setAttribute("method", "post");
	formInfo.setAttribute("action", "/sign/signUpPage");
	document.body.appendChild(formInfo);
	formInfo.submit();
}

// logout Process
function logout(){
	let formInfo = document.createElement("form");
	formInfo.setAttribute("id", "pageControllDiv");
	formInfo.setAttribute("method", "post");
	formInfo.setAttribute("action", "/sign/logoutProcess");
	document.body.appendChild(formInfo);
	formInfo.submit();
}
	
// null check
function isNull(inputTemp){
	var isNullRst = false;
	if(typeof inputTemp === "undefined" || inputTemp == "" || inputTemp == null){
		isNullRst = true;
	}
	return isNullRst;
}