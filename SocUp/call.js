let localVideo = document.getElementById("local-video")
let remoteVideo = document.getElementById("remote-video")

localVideo.style.opacity = 0
remoteVideo.style.opacity = 0

remoteVideo.onplaying = () => { remoteVideo.style.opacity = 1 }
localVideo.onplaying = () => { localVideo.style.opacity = 1 }


var getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia;

let peer
function init(userId) {
    peer = new Peer(userId, {

        port: 443,
        path: '/'
    })

    // peer.on('open', () => {
    //     iOS.onPeerConnected()
    // })

    listen()
}

let localStream
function listen() {
    var getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia;
    peer.on('call', (call) => {
        getUserMedia({
            audio: true, 
            video: true
        }, (stream) => {
            localVideo.srcObject = stream
            localStream = stream

            call.answer(stream)
            call.on('stream', (remoteStream) => {
                remoteVideo.srcObject = remoteStream

                remoteVideo.className = "primary-video"
                localVideo.className = "secondary-video"

            }, function(err){
                console.log('failed to get remote stream',err);
            });
        }, function(err) {
            console.log('Failed to get local stream' ,err);
        })
        
    })
}

function startCall(otherUserId) {
    
    getUserMedia({
        audio: true,
        video: true
    }, (stream) => {

        localVideo.srcObject = stream
        localStream = stream

        var call = peer.call(otherUserId, stream)
        call.on('stream', (remoteStream) => {
            remoteVideo.srcObject = remoteStream

            remoteVideo.className = "primary-video"
            localVideo.className = "secondary-video"
        },  function(err){
            console.log('failed to get remote stream',err);
        })

    },function(err) {
        console.log('Failed to get local stream' ,err)
    });
}

//function toggleVideo(b) {
//    if (b == "true") {
//        localStream.getVideoTracks()[0].enabled = true
//    } else {
//        localStream.getVideoTracks()[0].enabled = false
//    }
//} 
//
//function toggleAudio(b) {
//    if (b == "true") {
//        localStream.getAudioTracks()[0].enabled = true
//    } else {
//        localStream.getAudioTracks()[0].enabled = false
//    }
//} 

function toggleVideo(button) {
    if (button.getAttribute("data-enabled") === "true") {
        localStream.getVideoTracks()[0].enabled = false;
        button.setAttribute("data-enabled", "false");
    } else {
        localStream.getVideoTracks()[0].enabled = true;
        button.setAttribute("data-enabled", "true");
    }
}

function toggleAudio(button) {
    if (button.getAttribute("data-enabled") === "true") {
        localStream.getAudioTracks()[0].enabled = false;
        button.setAttribute("data-enabled", "false");
    } else {
        localStream.getAudioTracks()[0].enabled = true;
        button.setAttribute("data-enabled", "true");
    }
}
