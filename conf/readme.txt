- email: javier.udoit.org@gmail.com
- firebase specifics:
  + proyecto: udoit-9ab93 (udoit)
  + proyecto google analytics: udoit
  + registro apps:
    * Android:
      - packet name (com.companyname.appname): com.udoitorg.udoit
      - configuration file
         + Copy in : lib/conf/firebase/android/google-services.json
         + added contents to: android/google-services.json
    * Web:
      - packet name (com.companyname.appname): com.udoitorg.udoit
      - setup firebase hosting server name:
        + udoit-org.web.app
      - Add firebase SDK:
	<!-- The core Firebase JS SDK is always required and must be listed first -->
	<script src="/__/firebase/8.0.1/firebase-app.js"></script>

	<!-- TODO: Add SDKs for Firebase products that you want to use
	     https://firebase.google.com/docs/web/setup#available-libraries -->
	<script src="/__/firebase/8.0.1/firebase-analytics.js"></script>

	<!-- Initialize Firebase -->
	<script src="/__/firebase/init.js"></script>
      - install nvm:
	+ cmd: curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
	+ restart shell
	+ cmd: nvm list
	+ choose most recent node-stable-version
	+ cmd: nvm install node-stable-version

      - Install firebase CLI:
	+ cmd: sudo npm install -g firebase-tools
	
      - Firebase hosting:
        + cmd: firebase login
	+ cmd: firebase init
	+ options chosen:
? What file should be used for Database Rules? database.rules.json
  
? What do you want to use as your public directory? (public) build/web
? Configure as a single-page app (rewrite all urls to /index.html)? Yes
? Set up automatic builds and deploys with GitHub? No
? File build/web/index.html already exists. Overwrite? No

	+ Add to firebase.json:
		{
		  "hosting": {
		    "site": "udoit-org", --> añade esta linea
		    "public": "public",
		    ...
		  }
		}

	+ complie for web:
		+ cmd: flutter build web // will create new build in our build/web folder
    + deploy model:
		+ real firestore:
			+ cmd: firebase deploy // will deploy version found in build/web to firebase
    	+ emulated firestore:
			+ cmd: firebase init emulators
			+ cmd: firebase emulators:start



1. flutter channel master

2. flutter upgrade

3. flutter config --enable-web

4. flutter devices

5. flutter create web_app

6. flutter run -d chrome (run project on chrome)
		
