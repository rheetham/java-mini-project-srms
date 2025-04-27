document.addEventListener('DOMContentLoaded', function() {
    // Form validation for add/edit student forms
    const forms = document.querySelectorAll('form');
    
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            let isValid = true;
            
            // Validate roll number (alphanumeric, 5-15 characters)
            const rollNumber = form.querySelector('#rollNumber');
            if (!/^[a-zA-Z0-9]{5,15}$/.test(rollNumber.value)) {
                alert('Roll number must be 5-15 alphanumeric characters');
                isValid = false;
            }
            
            // Validate email
            const email = form.querySelector('#email');
            if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) {
                alert('Please enter a valid email address');
                isValid = false;
            }
            
            // Validate contact number (10 digits)
            const contactNumber = form.querySelector('#contactNumber');
            if (!/^\d{10,15}$/.test(contactNumber.value)) {
                alert('Contact number must be 10-15 digits');
                isValid = false;
            }
            
            // Validate date of birth (must be in the past)
            const dob = form.querySelector('#dateOfBirth');
            if (new Date(dob.value) >= new Date()) {
                alert('Date of birth must be in the past');
                isValid = false;
            }
            
            if (!isValid) {
                e.preventDefault();
            }
        });
    });
    
    // Confirmation for delete actions
    const deleteButtons = document.querySelectorAll('.btn-delete');
    deleteButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            if (!confirm('Are you sure you want to delete this student?')) {
                e.preventDefault();
            }
        });
    });
});