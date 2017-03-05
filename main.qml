import QtQuick 2.5
import QtQuick.Window 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

Window {
    id: window
    visible: true
    title: "hydron-qt"
    minimumWidth: 640
    minimumHeight: 480

    SplitView {
        id: mainView
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent
        orientation: Qt.Horizontal

        ColumnLayout {
            anchors.top: parent.top
            anchors.left: parent.left
            Layout.minimumWidth: 200
            Layout.preferredWidth: parent.width * 0.3
            Layout.maximumWidth: parent.width * 0.9

            SearchBar {
                id: searchBar
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.left: parent.left
            }

            Item {
                id: previewContainer
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.left: parent.left
                Layout.fillHeight: true

                Text {
                    text: "preview"
                }
            }
        }

        ScrollView {
            Browser {
                id: browser
                Layout.fillWidth: true
                Layout.minimumWidth: 200
            }
        }
    }
}
