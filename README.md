Title: Simple Blog
Features:
This system following functions:

- Function 1: Registration
o Registration a new account: email, name, password, role, status (email as ID).
o The default role of new account is member.
o The default status of new account is New.
o Password must be encrypted using SHA-256 before store in database.
- Function 2: Login
o The actor enters ID and password, the function checks if the ID with the password is in the available
account list, then grant the access permission. If not, a message would appear no notify that account is
not found.
o Login function includes logout and welcome functions.
- Function 3: Article Search
o List the available article in the system and sort by date: tittle, shortDescription, author, date.
o Each page has a maximum of 20 records displayed. Paging is required to use.
o User inputs the text that they want to find and click the Search button or the Enter key. A list article which
contain the search keyword (search by content).
o Login is not required.
- Function 4: Article Detail
o List the available article in the system and sort by date.
o Each page has a maximum of 20 records displayed. Paging is required to use.
o When clicking on the title column in each record, the details of the article are displayed: title, short
description, content, author, posting date and the list of corresponding comments.
o Login is not required.
- Function 5: Post the article
o In order to post the article to the blog an authentication is required.
o If the user has not authenticated, the system redirect to the login page.
o Members can post their articles on the blog and wait for the admin's approval.
o The default status of the article is New. The status will be changed to Active if the admin accepts that post.
o Only member can use this function.
- Function 6: Post the comment
o In order to post the comment an authentication is required.
o If the user has not authenticated, the system redirect to the login page.
o Members can post their comment on the article.
o Only member can use this function
- Function 7: Blog process
o List first 20 articles in the system order by date. Paging is required to use.
o Support search function: by article name, status (New, Delete, Active).
o User inputs the text that they want to find and select article’s status after that click the Search button or
the Enter key. A list article which contain the search keyword (search by content)
o Delete or approval the selected article.
o Update list article after delete or approval.
o Delete action is update the status to Deleted.
o Approval action is change the status to Active
o Only admin account can use this function.
- Function 8: Authentication available email
o Authentication available email when registering a user.
o When registering a new account, the system will send a confirmation code to the email address.
o After entering the verification code, the status of the account will change to Active.
o Only member can use this function.
