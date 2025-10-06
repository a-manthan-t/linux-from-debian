import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Pane {
	id:root
	
	width: Screen.width
	height: Screen.height
	padding: 0	
	property date dateTime: new Date()
	property var days: [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" ]
	property var months: [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ]
	
	Timer {
		id: timer
		interval: 1000; running: true; repeat: true;
		onTriggered: root.dateTime = new Date()
	}

	Image {
		anchors.fill: parent
		source: "file:///usr/share/sddm/themes/default_login/Background.jpg"
		fillMode: Image.PreserveAspectCrop
	}

	ColumnLayout {
		anchors.centerIn: parent
		spacing: 20
		width: 300
		
		ColumnLayout {
			Layout.alignment: Qt.AlignHCenter

			Text {
				id: time
				Layout.alignment: Qt.AlignHCenter
				text: String(root.dateTime.getHours()).padStart(2, "0") + ":" + String(root.dateTime.getMinutes()).padStart(2, "0")
				font.pixelSize: 80
				color: "white"
			}

			Text {
				id: date
				Layout.bottomMargin: 20
				Layout.alignment: Qt.AlignHCenter
				text: root.days[root.dateTime.getDay()] + " " + root.dateTime.getDate() + " " + root.months[root.dateTime.getMonth()]
				font.pixelSize: 20
				color: "white"
			}
		}

		TextField {
			id: usernameInput
			placeholderText: "Username"
			font.pixelSize: 14
			palette.text: "white"
			Layout.fillWidth: true
			selectByMouse: true
			onAccepted: {
				error.visible = false
				sddm.login(usernameInput.text, passwordInput.text, 0)
			}

			background: Rectangle {
				color: "#40000000"
				radius: 15
			}
		}
		
		TextField {
			id: passwordInput
			property string passwordText: ""
			placeholderText: "Password"
			echoMode: TextInput.Password
			font.pixelSize: 14
			palette.text: "white"
			Layout.fillWidth: true
			selectByMouse: true
			onAccepted: {
				error.visible = false
				sddm.login(usernameInput.text, passwordInput.text, 0)
			}

			background: Rectangle {
				color: "#40000000"
				radius: 15
			}
		}

		Button {
			text: "Login"
			font.pixelSize: 14
			Layout.fillWidth: true
			onClicked: {
				error.visible = false
				sddm.login(usernameInput.text, passwordInput.text, 0)
			}
			Keys.onReturnPressed: {
				error.visible = false
				sddm.login(usernameInput.text, passwordInput.text, 0)
			}

			background: Rectangle {
				radius: 15
			}
		}

		RowLayout {
			Layout.alignment: Qt.AlignHCenter
			spacing: 20
			
			Button {
				text: "Reboot"
				palette.buttonText: "#c5c8c6"
				Layout.fillWidth: true
				Layout.alignment: Qt.AlignLeft
				onClicked: sddm.reboot()
				Keys.onReturnPressed: sddm.reboot()
				
				background: Rectangle {
					color: "#40000000"
					radius: 15
				}
			}

			Button {
				text: " Stop "
				palette.buttonText: "#c5c8c6"
				Layout.fillWidth: true
				Layout.alignment: Qt.AlignRight
				onClicked: sddm.powerOff()
				Keys.onReturnPressed: sddm.powerOff()

				background: Rectangle {
					color: "#40000000"
					radius: 15
				}
			}
		}

		Text {
			id: error
			text: "Login failed"
			color: "#dc3e3e"
			visible: false
			wrapMode: Label.Wrap
			Layout.alignment: Qt.AlignHCenter
			font.pixelSize: 14
		}

		Connections {
			target: sddm
			onLoginFailed: {
				error.visible = true
			}
		}
	}
}

