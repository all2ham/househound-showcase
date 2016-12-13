/**
 * Created by allan on 16-01-09.
 */
var handler = StripeCheckout.configure({
    key: 'pk_test_KsA06xkO3PoVT5hwohSLYNMs',
    image: 'https://s3.amazonaws.com/stripe-uploads/acct_15YsmQF1raSeIB9Dmerchant-icon-1425185729626-thisistheonedotjpeg.png',
    locale: 'auto',
    token: function(token) {
        "<%= Rails.application.secrets[:stripe][:publishable_key] %>"
    }
});

$('#customButton').on('click', function(e) {
    // Open Checkout with further options
    handler.open({
        name: 'HouseHound',
        description: "<%= plan.name %>",
        currency: "CAD",
        email:"<%= current_user.email %>",
        amount: <%= plan.stripe_total %>
});
e.preventDefault();
});

// Close Checkout on page navigation
$(window).on('popstate', function() {
    handler.close();
});