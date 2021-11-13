


$(document).ready(function () {

    $("#form").validate({ // initialize the plugin
        rules: {
            vendor_name: {
                required: true 
            },
            GST_number: {
                required: true, digits:true,
                minlength:8,maxlength:8
            },
            username: {
                required: true 
            },
            first_name: {
                required: true 
            },
            last_name: {
                required: true 
            },
            
            password: {
                required: true,
                minlength: 4
            },confirm_password: {
                required: true,
                minlength: 4
            },
            email: {
                required: true,
                email:true
                
            },
            mobile: {
                required: true,digits:true,minlength:10,maxlength:10
                
                
            },
            logo:{
                required:true
            },
            dp:{
                required:true
            },

        },
        
    });

});