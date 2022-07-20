import {api, LightningElement, track} from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import sendTrackRecordedTime from '@salesforce/apex/CounsellorlListcontroller.trackRecordedTime';
import SendsessionStopTime from '@salesforce/apex/CounsellorlListcontroller.stopSessionTemp';
import strUserId from '@salesforce/user/Id';

export default class TheAutomaticTimeTracking extends LightningElement {

    @api recordId;
    @track showStartBtn = true;
    @track timeVal = '00:00:00';
    @track timeHours;
    @track timeMinutes;
    @track timeSeconds;
    timeIntervalInstance;
    totalMilliseconds = 0;
    @api currenRecordId;
    @track showAutoTimerButton = false;
    @track showManualTimerButton = false;
    @track manualHours;
    @track manualMinutes;
    formChanged = true;
    //Getting the current url
    testURL = window.location.href;
    //Filtering the URL to get the Id
    newURL = this.testURL.match(/[a-z0-9]\w{4}0\w{12}|[a-z0-9]\w{4}0\w{9}/g);

    connectedCallback() {
        this.currenRecordId = this.newURL;
    }
    constructor() {
        super();
        // this.formChanged = IsTrueOrNOT;
        window.console.log('--this.formChanged-->', this.formChanged);
        window.addEventListener('beforeunload', (event) => {
            //  if (formChanged) {
            event.returnValue = 'You have unfinished changes!';
            //==========================================================
            SendsessionStopTime({LogInUserID: strUserId,sessionStopTime: null })
                .then(result => {
                    var response = result;
                })
                .catch(error => {
                    window.console.log('error==>', error);
                });
            
            //==========================================================
            // Cancel the event as stated by the standard.
            event.preventDefault();
            // Chrome requires returnValue to be set.
            event.returnValue = 'sample value';
            // }
        });
    }
    start(event) {
        this.showStartBtn = false;
        this.showManualTimerButton = true;
        var parentThis = this;
        //this.checkBrowserEvents(formChanged);
        // Run timer code in every 100 milliseconds
        this.timeIntervalInstance = setInterval(function() {

            // Time calculations for hours, minutes, seconds and milliseconds
            var hours = Math.floor((parentThis.totalMilliseconds % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes = Math.floor((parentThis.totalMilliseconds % (1000 * 60 * 60)) / (1000 * 60));
            var seconds = Math.floor((parentThis.totalMilliseconds % (1000 * 60)) / 1000);
            var milliseconds = Math.floor((parentThis.totalMilliseconds % (1000)));
            // Output the result in the timeVal variable
            parentThis.timeVal = hours + ":" + minutes + ":" + seconds; //+ ":" + milliseconds;
            parentThis.timeHours = hours;
            parentThis.timeMinutes = minutes;
            parentThis.timeSeconds = seconds;
            parentThis.totalMilliseconds += 100;
        }, 100);

    }

    stop(event) {
        this.formChanged = true;

        //this.checkBrowserEvents(formChanged);
        this.showStartBtn = true;
        window.console.log('this.parentRecordId==>', this.currenRecordId[0]);
        sendTrackRecordedTime({
                hour: this.timeHours,
                minute: this.timeMinutes,
                second: this.timeSeconds,
                parentRecordID: this.currenRecordId[0]
            })
            .then(result => {
                var response = result;
                this.showToast();
            })
            .catch(error => {
                this.showErrorToast();
                window.console.log('error==>', error);
            });

        clearInterval(this.timeIntervalInstance);
    }

    reset(event) {
        this.showStartBtn = true;
        this.timeVal = '0:0:0:0';
        this.timeHours = '00';
        this.timeMinutes = '00';
        this.timeSeconds = '00';
        this.totalMilliseconds = 0;
        clearInterval(this.timeIntervalInstance);
        this.showResetToast();
    }
    submit(event) {
        //alert(this.template.querySelector(".manualHoursClass").value);
        this.showAutoTimerButton = true;
        this.timeHours = this.template.querySelector(".manualHoursClass").value;
        this.timeMinutes = this.template.querySelector(".manualMinutesClass").value;
        //this.checkBrowserEvents(formChanged);
        this.showStartBtn = true;
        window.console.log('this.parentRecordId==>', this.currenRecordId[0]);
        sendTrackRecordedTime({
                hour: this.timeHours,
                minute: this.timeMinutes,
                second: '0',
                parentRecordID: this.currenRecordId[0]
            })
            .then(result => {
                var response = result;
                this.showToast();
            })
            .catch(error => {
                this.showErrorToast();
                this.showAutoTimerButton = false;
                window.console.log('error==>', error);
            });

        clearInterval(this.timeIntervalInstance);
    }
    showErrorToast() {
        const evt = new ShowToastEvent({
            title: 'Toast Error',
            message: 'Something Went Wrong',
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
    showResetToast() {
        const evt = new ShowToastEvent({
            title: 'Toast Success',
            message: 'Time reset successfully done.',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
    showToast() {
        const event = new ShowToastEvent({
            title: 'Toast message',
            message: 'Time Submitted Successfully',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
    checkBrowserEvents(IsTrueOrNOT) {
        this.formChanged = IsTrueOrNOT;
        window.console.log('--this.formChanged-->', this.formChanged);
        // super();
        window.addEventListener('beforeunload', (event) => {
            if (formChanged) {
                event.returnValue = 'You have unfinished changes!';
                // Cancel the event as stated by the standard.
                event.preventDefault();
                // Chrome requires returnValue to be set.
                event.returnValue = 'sample value';
            }
        });
    }

}