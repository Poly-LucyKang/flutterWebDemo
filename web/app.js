window.state = {
    reserved1: '전역변수처럼 사용가능'
}

        // 현재 플랫폼을 확인하는 함수
    function getPlatform() {
        if (navigator.userAgent.indexOf('Android') !== -1) {
        return 'android';
      } else if (navigator.userAgent.indexOf('iPhone') !== -1 || navigator.userAgent.indexOf('iPad') !== -1) {
        return 'ios';
      } else {
        return 'web'; // Flutter Web에서 실행될 때는 'web'으로 인식
      }
    }

    function sendFruitName(fruitName) {
      const platform = getPlatform();
      if (platform === 'android') {
        // Android에서만 사용할 코드 (postMessage 방식)
         window.polyWebBridge.sendFruitName(fruitName);
          console.log("[KHJ] app js platform android: " + fruitName);
      } else if (platform === 'ios') {
        // iOS에서만 사용할 코드 (window.webkit.messageHandlers)
        window.webkit.messageHandlers.polyWebBridge.postMessage(fruitName);
          console.log("[KHJ] app js platform iOS: " + fruitName);
      } else {
        // Flutter Web에서는 콘솔에 출력하거나 다른 처리를 할 수 있음
        console.log('[KHJ] app js platform web: ' + fruitName);
      }
    }