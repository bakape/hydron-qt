import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtMultimedia 5.5
import "util.js" as Util

Rectangle {
    visible: false
    color: SystemPalette.base || "white"
    focus: true

    SplitView {
        anchors.fill: parent

        ScrollView {
            Layout.preferredWidth: 200
            Layout.minimumWidth: 0
            Layout.maximumWidth: parent.width * 0.7
            width: 200

            ListView {
                id: tags
                anchors.fill: parent
                interactive: false
                boundsBehavior: Flickable.StopAtBounds
                model: ListModel {}
                delegate: Text {
                    text: tag
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true

            Text {
                id: error
                visible: false
                anchors.fill: parent
                anchors.centerIn: parent
            }

            Image {
                id: image
                visible: false
                asynchronous: true
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
            }

            AnimatedImage {
                id: animated
                visible: false
                asynchronous: true
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
            }

            // MediaPlayer can not be hidden. Need to contain it.
            Rectangle {
                id: mediaContainer
                visible: false
                anchors.fill: parent

                // TODO: Media controls

                MediaPlayer {
                    id: media
                    loops: MediaPlayer.Infinite
                    autoPlay: true
                    autoLoad: true
                }

                VideoOutput {
                    anchors.fill: parent
                    source: media
                }

                MouseArea {
                    id: playArea
                    anchors.fill: parent
                    onPressed: {
                        if (media.playbackState === MediaPlayer.PlayingState) {
                            media.pause()
                        } else {
                            media.play()
                        }
                    }
                }
            }
        }
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Escape) {
            empty()
            browser.forceActiveFocus()
        }

        // TODO: Keyboard navigation in this mode

    }

    MouseArea {
        enabled: true
        acceptedButtons: Qt.AllButtons

        onClicked: {
            console.log("clicked")
        }
    }

    function render(data) {
        fileView.visible = true
        forceActiveFocus()
        window.toolBar.visible = false
        browser.visible = false

        switch (data.type) {
        case "jpg":
        case "png":
        case "webp":
        case "tiff":
        case "ico":
        case "bmp":
            image.visible = true
            image.source = Util.sourcePath(data.sha1, data.type)
            break
        case "gif":
            animated.visible = true
            animated.source = Util.sourcePath(data.sha1, data.type)
            break
        case "webm":
        case "ogg":
        case "mkv":
        case "mp4":
        case "avi":
        case "mov":
        case "wmv":
        case "flv":
            mediaContainer.visible = true
            media.source = Util.sourcePath(data.sha1, data.type)
            break
        case "mp3":
        case "aac":
        case "wave":
        case "flac":
        case "midi":
            image.visible = true
            image.source = Util.thumbPath(data.sha1, data.thumbIsPNG)
            mediaContainer.visible = true
            media.source = Util.sourcePath(data.sha1, data.type)
            break
        default: // PSD, PDF and others
            error.visble = true
            error.text = "Preview not available for this file type"
            return
        }

        // Fetch the tags
        tags.model.clear()
        var xhr = new XMLHttpRequest()
        xhr.onreadystatechange = function () {
            if (xhr.readyState !== XMLHttpRequest.DONE
                    || xhr.status !== 200
                    || !xhr.responseText
                    ) {
                return
            }

            // Need to clear again, because this callback
            // is asynchrounous
            tags.model.clear()
            var res = JSON.parse(xhr.responseText)
            if (!res.length) {
                // Was deleted
                return
            }
            var t = res[0].tags
            for (var i = 0; i < t.length; i++) {
                tags.model.append({tag: t[i]})
            }
        }
        xhr.open("GET", "http://localhost:8010/get/" + data.sha1)
        xhr.send()
    }

    // Reset to empty state
    function empty() {
        browser.visible = true
        visible = false
        window.toolBar.visible = true

        tags.model.clear()

        error.visible = false

        animated.source = ""
        animated.visible = false

        image.source = ""
        image.visible = false

        mediaContainer.visible = false
        media.source = ""
    }
}
