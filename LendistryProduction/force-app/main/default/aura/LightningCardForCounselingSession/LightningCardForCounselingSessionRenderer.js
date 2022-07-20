({
    unrender: function () {
        this.superUnrender();
        window.onbeforeunload = function (evt) {
            var message = '!! Leaving this page may cause loss of data !!\n';
            if (typeof evt == 'undefined') evt = window.event;
            if (evt) evt.returnValue = message;
            alert(message);
            return message; 
        }
        // do custom unrendering here
    }
})