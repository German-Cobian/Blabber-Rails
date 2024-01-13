![](https://img.shields.io/badge/Microverse-blueviolet)
![](https://img.shields.io/static/v1?label=BY&message=German-cobian&color=red)


# Blabber-Rails

<hr>

## Description

> This is the back-end of a Chat application where users can message each other.

In this app all users (admin and regular) are allowed the following actions:

- To signup.
- To login.
- To see all users listed on the sidebar, by their username.
- To select a specific user that they desire to have a conversation with and, by clicking on the user's username, create a chat room where they can message the user and then receive replies. 
![message](/app/assets/Message.png?raw=true "message") 
![reply](/app/assets/Reply.png?raw=true "reply")

Admins are allowed these additional actions:

- To access the page for user management,
![Manage users 1](/app/assets/Manage-Users1.png?raw=true "manage-users1")
- To edit the priviledges of the apps other users,  
- To delete a user that is not a participant in any chat room.
![Manage users 2](/app/assets/Manage-Users2.png?raw=true "manage-users2")
<hr>

## Front-end Repository 

[ReactApp](https://github.com/German-Cobian/Blabber-React)

## Built With

- Major languages:
  * ![ruby version](https://img.shields.io/badge/Ruby-3.x-yellow)
- Frameworks:
  * ![rails version](https://img.shields.io/badge/Rails-7-red)
- Tools & Methods:
  * ![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)
<hr>

## Getting Started

If you have Rails 7 installed, you can skip to the [Setup](#setup) section

### Clone Repo

To get a local copy up and running follow these simple example steps.

```sh
git clone git@github.com:German-Cobian/Blabber-Rails.git
```
<hr>

## Prerequisites

The following technologies must be installed in your local machine:

 - Ruby.
 - Postgres ('pg', '~> 1.1')
 - Node.js 

Refer to [Section 3](https://guides.rubyonrails.org/v5.1/getting_started.html#:~:text=3%20Creating%20a%20New%20Rails%20Project) from the official [Rails Guide](https://rubyonrails.org/) for more detailed instructions on how to install these technologies.

### Install Rails
To install Rails run these commands in your terminal:

```sh
gem install rails
# wait a few seconds for it to download
# ...
# ...
# verify that it was installed by running
rails --version
```
<hr>

### System Dependencies

To automatically install all the dependencies needed run:

```sh
bundle install
```
<hr>

### Database Initialization
To initialize the database created  run:

```sh
rails db:setup
```
<hr>

### Start Server

To start the server
```sh
rails server
```
Which you can visit by going to http://localhost:3001 in your browser.
<hr>

## Created by

 👤 **German Cobian**

Platform | Badge |
 --- | --- |
 **GitHub**  | [@German Cobian](https://github.com/German-Cobian)
 **Twitter** |[@GermanCobian2](https://twitter.com/GermanCobian2)
 **LinkedIn** | [@German Cobian](https://www.linkedin.com/in/german-cobian/)
<hr>

## Contributing

Contributions, issues and feature requests are welcome!
Feel free to check the [issues page](git@github.com:German-Cobian/Blabber-Rails.git)
<hr>
 
## Show your support

Give a ⭐️ if you like this project!
<hr>

## Acknowledgments

SmartPuntoGob
<hr>

## 📝 License

This project is [MIT](https://github.com/German-Cobian/Blabber-Rails/blob/main/LICENSE) licensed.
