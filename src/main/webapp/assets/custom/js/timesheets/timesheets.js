function createStaffE(staff){
    return `<div class="card mb-3">
                                <div class="card-body">
                                    <div class="d-flex">
                                        <div class="flex-grow-1"><i
                                                class="mdi mdi-checkbox-blank-circle me-2 text-info"></i>
                                                <a data-id="`+staff.id+`" href="#" class="fw-medium staff-name">`+staff.fullname+`</a></div>
                                        <span class="btn-load">
                                            <span class="spinner-border flex-shrink-0 d-none"></span>
                                        </span>
                                    </div>
                                    <p class="text-muted text-truncate-two-lines mb-0"></p></div>
                            </div>`;
}

function convertListTimesheetToCalendar(timesheetList){

    return timesheetList.map(function(t) {
        return {
            id: t.id,
            title: t.content,
            start: t.workDate,
            allDay: true,
            className: "bg-soft-primary"
        };
    });
}