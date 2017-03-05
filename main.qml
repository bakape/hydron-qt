import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

ApplicationWindow {
	id: window
	visible: true
	title: "hydron-qt"
	minimumWidth: 640
	minimumHeight: 480

	toolBar: ToolBar {
		focus: true

		RowLayout {
			anchors.fill: parent

			SearchBar {
				focus: true
				Layout.fillWidth: true
			}
		}
	}

	ScrollView {
		anchors.fill: parent

		Browser {
			id: browser
			anchors.fill: parent
		}
	}
}
