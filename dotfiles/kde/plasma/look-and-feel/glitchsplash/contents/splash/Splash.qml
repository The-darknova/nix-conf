import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    color: "black"
    anchors.fill: parent

    Image {
        id: bgLow
        source: "images/bg_low.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        opacity: 0
    }

    SequentialAnimation {
        running: true
        loops: Animation.Infinite

        NumberAnimation {
            target: bgLow
            property: "opacity"
            from: 0
            to: 1
            duration: 1500
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: bgLow
            property: "opacity"
            from: 1
            to: 0
            duration: 1500
            easing.type: Easing.InOutQuad
        }
    }
}
