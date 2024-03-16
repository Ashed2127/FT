import Chapa from 'chapa';
import express from 'express';

const router = express.Router();
let checkoutUrl; // Define a variable in a shared scope
export const responseData = async (req, res) => {
    try {
        const user = req.body;
        const api_key = 'CHASECK_TEST-sAZLjV7jiqT7HF5XBFofZxT5Zz416nCn';

        const userData = {
            amount: user.amount,
            currency: user.currency,
            email: user.email,
            first_name: user.first_name,
            last_name: user.last_name,
            callback_url: 'https://checkout.chapa.co/checkout/payment/:token',
            return_url: 'http://localhost:8082/',
            customization: {
                title: 'I love e-commerce',
                description: 'It is time to pay'
            }
        };

        const chapaResponse = new Chapa(api_key);
        const response = await chapaResponse.initialize(userData, { autoRef: true });

        if (response.status === 'success') {
            checkoutUrl = response.data.checkout_url;
            
            console.log('url: ', checkoutUrl);

            // Send the checkoutUrl as a response
            return res.status(200).json({ checkoutUrl });
        } else {
            return res.status(500).json({ error: 'Payment initiation failed.' });
        }
    } catch (error) {
        console.error('Error during payment initiation:', error);
        return res.status(500).json({ error: 'Internal server error.' });
    }
};

// Handle fetching checkout URL
export const getCheckoutUrl = async (req, res) => {
    try {
        // Here, you would fetch the checkout URL from your database or some other source
        if (checkoutUrl) {
            return checkoutUrl ; // Return the stored checkoutUrl
        } else {
            return res.status(404).json({ error: 'Checkout URL not found.' });
        }
    } catch (error) {
        console.error('Error fetching checkout URL:', error);
        return res.status(500).json({ error: 'Internal server error.' });
    }
};

export default router;