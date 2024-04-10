//let heading = document.querySelector("h1")
//heading.innerHTML = "this is h1 tag changed"
//above code is to check wheather javascript is working fine or not 
//hello()

//hello()
let localVideo = document.getElementById("local-video")
let remoteVideo = document.getElementById("remote-video")

//localVideo.style.opacity = 0
//remoteVideo.style.opacity = 0
localVideo.style.opacity = 1
remoteVideo.style.opacity = 1
//
//localVideo.onplaying = () => { localVideo.style.opacity = 1 }
//remoteVideo.onplaying = () => { remoteVideo.style.opacity = 1 }

//function hello(){
//   let heading = document.querySelector("h1")
//    heading.innerHTML ="changed h1 tag"
//}


let peer
function init(userId) {
    peer = new Peer(userId, {

        port: 443,
        path: '/'
    })

//    peer.on('open', () => {
//        Android.onPeerConnected()
//    })

    listen()
}

let localStream
function listen() {
    peer.on('call', (call) => {

        navigator.getUserMedia({
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

            })

        })
        
    })
}

function startCall(otherUserId) {
    navigator.getUserMedia({
        audio: true,
        video: true
    }, (stream) => {

        localVideo.srcObject = stream
        localStream = stream

        const call = peer.call(otherUserId, stream)
        call.on('stream', (remoteStream) => {
            remoteVideo.srcObject = remoteStream

            remoteVideo.className = "primary-video"
            localVideo.className = "secondary-video"
        })

    })
}

function toggleVideo(b) {
    if (b == "true") {
        localStream.getVideoTracks()[0].enabled = true
    } else {
        localStream.getVideoTracks()[0].enabled = false
    }
} 

function toggleAudio(b) {
    if (b == "true") {
        localStream.getAudioTracks()[0].enabled = true
    } else {
        localStream.getAudioTracks()[0].enabled = false
    }
} 
