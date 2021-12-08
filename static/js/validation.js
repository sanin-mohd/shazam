


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
            otp:{
                required:true
            },
            full_name:{
                required:true
            },
            address_line_1:{
                required:true
            },
            address_line_2:{
                required:true
            },
            city:{
                required:true
            },
            zip_code:{
                required:true
            },
            state:{
                required:true
            },
            country:{
                required:true
            },
            mobile:{
                required:true
            },
            landmark:{
                required:true
            },

        },
        
    });

});