import QtQuick 2.0
import QtQuick.Window 2.2

Rectangle {
    id: root
    color: "black"

    // Image du compte-tour (fond)
    Image {
        id: background
        source: "images/background.png"
        anchors.centerIn: parent
        width: 1920
        height: 1080

        // Image de l'aiguille
        Image {
            id: needle
            source: "images/aiguille.png"
            x: 243
            y: 668
            width: 20
            height: 160

            // IMPORTANT : définir le point de rotation en bas de l’aiguille
            transformOrigin: Item.Bottom

            // Animation de rotation (0° -> 270° par ex. pour couvrir le cadran)
            SequentialAnimation on rotation {
                loops: 1
                NumberAnimation { from: -100; to: 90; duration: 1000; easing.type: Easing.InOutQuad }
                NumberAnimation { from: 90; to: -30; duration: 200; easing.type: Easing.OutQuad }
                NumberAnimation { from: -30; to: 90; duration: 1100; easing.type: Easing.InOutQuad }
                NumberAnimation { from: 90; to: -30; duration: 200; easing.type: Easing.OutQuad }
                NumberAnimation { from: -30; to: 90; duration: 1300; easing.type: Easing.InOutQuad }
                NumberAnimation { from: 90; to: -30; duration: 200; easing.type: Easing.OutQuad }
                NumberAnimation { from: -30; to: 90; duration: 1700; easing.type: Easing.InOutQuad }
                NumberAnimation { from: 90; to: -30; duration: 200; easing.type: Easing.OutQuad }
                NumberAnimation { from: -30; to: 90; duration: 2500; easing.type: Easing.InOutQuad }
                NumberAnimation { from: 90; to: -30; duration: 200; easing.type: Easing.OutQuad }
                NumberAnimation { from: -30; to: 90; duration: 4100; easing.type: Easing.InOutQuad }
                NumberAnimation { from: 90; to: -30; duration: 200; easing.type: Easing.OutQuad }
                NumberAnimation { from: -30; to: 90; duration: 7300; easing.type: Easing.InOutQuad }
                NumberAnimation { from: 90; to: -30; duration: 200; easing.type: Easing.OutQuad }
                NumberAnimation { from: -30; to: 80; duration: 14500; easing.type: Easing.InOutQuad }
            }
        }
        
        Rectangle {
            x: 253 - 24   // centre X - rayon
            y: 832 - 24   // centre Y - rayon
            width: 48     // diamètre
            height: 48
            radius: 24    // arrondi complet = cercle
            color: "black"
        }
    }

}
