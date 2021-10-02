Title: Simple Blog
Features:
This system following functions:

- Function 1: Registration
  * Registration a new account: email, name, password, role, status (email as ID).
  * The default role of new account is member.
  * The default status of new account is New.
  * Password must be encrypted using SHA-256 before store in database.
- Function 2: Login
  * The actor enters ID and password, the function checks if the ID with the password is in the available
account list, then grant the access permission. If not, a message would appear no notify that account is
not found.
  * Login function includes logout and welcome functions.
- Function 3: Article Search
  * List the available article in the system and sort by date: tittle, shortDescription, author, date.
  * Each page has a maximum of 20 records displayed. Paging is required to use.
  * User inputs the text that they want to find and click the Search button or the Enter key. A list article which
contain the search keyword (search by content).
  * Login is not required.
- Function 4: Article Detail
  * List the available article in the system and sort by date.
  * Each page has a maximum of 20 records displayed. Paging is required to use.
  * When clicking on the title column in each record, the details of the article are displayed: title, short
description, content, author, posting date and the list of corresponding comments.
  * Login is not required.
- Function 5: Post the article
  * In order to post the article to the blog an authentication is required.
  * If the user has not authenticated, the system redirect to the login page.
  * Members can post their articles on the blog and wait for the admin's approval.
  * The default status of the article is New. The status will be changed to Active if the admin accepts that post.
  * Only member can use this function.
- Function 6: Post the comment
  * In order to post the comment an authentication is required.
  * If the user has not authenticated, the system redirect to the login page.
  * Members can post their comment on the article.
  * Only member can use this function
- Function 7: Blog process
  * List first 20 articles in the system order by date. Paging is required to use.
  * Support search function: by article name, status (New, Delete, Active).
  * User inputs the text that they want to find and select article’s status after that click the Search button or
 the Enter key. A list article which contain the search keyword (search by content)
  * Delete or approval the selected article.
  * Update list article after delete or approval.
  * Delete action is update the status to Deleted.
  * Approval action is change the status to Active
  * Only admin account can use this function.
- Function 8: Authentication available email
  * Authentication available email when registering a user.
  * When registering a new account, the system will send a confirmation code to the email address.
  * After entering the verification code, the status of the account will change to Active.
  * Only member can use this function.

Home Page Image:
![1](https://user-images.githubusercontent.com/59483840/135701748-1e7e80ca-ea0e-4655-9e2e-0dff0b6bd5ee.PNG)
![2](https://user-images.githubusercontent.com/59483840/135701755-40fb294e-439a-4f0f-8673-94ea45db441f.PNG)
Aricle detail Image:
![3](https://user-images.githubusercontent.com/59483840/135701760-59b3408a-bddb-456f-aaf6-6b86179e0b32.PNG)
![4](https://user-images.githubusercontent.com/59483840/135701758-217a94ba-c19d-4cdc-8187-4056ac5bec89.PNG)
