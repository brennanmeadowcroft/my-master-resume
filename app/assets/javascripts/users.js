// function onLinkedInLoad() {
// 	IN.Event.on(IN, "auth", onLinkedInAuth);
// }

// function onLinkedInAuth() {
// 	IN.API.Profile("me").result(displayProfiles);
// }

// function displayProfiles(profiles) {
// 	member = profiles.values[0];
// 	document.getElementById("profiles").innerHTML = 
// 		"<li id=\"" + member.id + "\"><img src=\"/assets/linkedin-logo.png\" width=\"75\" /></li>" +
// 		"<li>"<%= link_to "Import Profile Info", linkedin_user_path %>"Import Profile Info</a></li>" + 
// 		"<li>Import Positions</li>";
// 	$('#linkedin_id').val(member.id);
// 	$('#user_first_name').val(member.firstName);
// 	$('#user_last_name').val(member.lastName);
// 	$('#user_phone').val(member.phoneNumbers);
// 	$('#user_address_1').val(member.mainAddress);
// 	$('#user_website').val(member.memberUrlResources);
// }

// function onLinkedInImportSkills() {
// 	IN.API.Profile("me")
// 		.fields(["skills"])
// 		.result(importSkills);
// }

// function importSkills(profiles) {
// 	member = profiles.values[0];

// 	var counter = 0;
// 	var numberSkills = member.length;
// 	var formHTML = "";

// 	while(counter < numberSkills) {
// 		formHTML += '<input type="text" value="' + member.skills[counter] + '">'
// 		counter ++;
// 	}

// 	$('#skillForm').append(formHTML);
// }