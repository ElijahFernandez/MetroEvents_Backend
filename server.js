const express = require("express")
const mysql = require("mysql")
const cors = require("cors")


const app = express();
app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "metro_events"
})

// route for signup
app.post('/signup', (req, res) => {
    const sql = "INSERT INTO user (`email`, `password`, `first_name`, `last_name`) VALUES (?) ";
    const values = [
        req.body.email,
        req.body.password,
        req.body.first_name,
        req.body.last_name,
    ]
    db.query(sql, [values], (err, data) => {
        if(err) {
            return res.json("Error");
        }
        return res.json(data);
    }) 
})

// route for user/organizer login
app.post('/login', (req, res) => {
    const sql = "SELECT * FROM user WHERE `email` = ? AND `password` = ?";

    db.query(sql, [req.body.email, req.body.password], (err, data) => {
        if(err) {
            return res.json("Error");
        }
        if(data.length > 0) {
            const userId = data[0].user_id;
            return res.json({ success: true, userId: userId });
        } else {
            return res.json({ success: false, message: "Invalid credentials" });
        }
    }) 
})

// route for admin login

app.post('/adminlogin', (req, res) => {
    const sql = "SELECT * FROM admin WHERE `email` = ? AND `password` = ?";

    db.query(sql, [req.body.email, req.body.password], (err, data) => {
        if(err) {
            return res.json("Error");
        }
        if(data.length > 0) {
            const adminId = data[0].admin_id;
            return res.json({ success: true, adminId: adminId });
        } else {
            return res.json({ success: false, message: "Invalid credentials" });
        }
    }) 
})


// Route to fetch all events
app.get('/events', (req, res) => {
    const sql = "SELECT * FROM events";
    db.query(sql, (err, result) => {
        if (err) {
            res.status(500).json({ error: 'Error fetching events' });
        } else {
            res.json(result);
        }
    });
});

// route for organizer_request
app.post('/organizerRequest', (req, res) => {
    const sql = "INSERT INTO organizer_request (`user_id`, `request_status`) VALUES (?) ";
    const values = [
        req.body.userId,
        req.body.request_status
    ]
    db.query(sql, [values], (err, data) => {
        if(err) {
            return res.json("Error");
        }
        return res.json(data);
    })  
})

// Route to fetch all user to organizer requests
app.get('/fetchRequests', (req, res) => {
    const sql = "SELECT * FROM organizer_request";
    db.query(sql, (err, result) => {
        if (err) {
            res.status(500).json({ error: 'Error fetching request' });
        } else {
            res.json(result);
        }
    });
});


// Route to handle DELETE request for deleting a user record
app.delete('/users/:userId', (req, res) => {
    const userIdToDelete = req.params.userId;

    // Execute SQL DELETE query to delete the record with userIdToDelete
    const sql = "DELETE FROM users WHERE user_id = ?";
    db.query(sql, [userIdToDelete], (err, result) => {
        if (err) {
            console.error('Error deleting record:', err);
            res.status(500).json({ error: 'Error deleting record' });
        } else {
            console.log('Record deleted successfully');
            res.status(200).json({ message: 'Record deleted successfully' });
        }
    });
});

// app.post('/userToOrganizer', (req, res) => {
//     const sql = "INSERT INTO organizer (`user_id`) VALUES (?) ";
//     const values = [
//         req.body.user_id,
//     ]
//     db.query(sql, [values], (err, data) => {
//         if(err) {
//             return res.json("Error");
//         }
//         const deleteSql = "DELETE FROM organizer_request WHERE user_id = ?";

//         db.query()
//     }) 
// })

// route to inserting user as organizer then deleting the record

app.post('/approveRequest', (req, res) => {
    const userId = req.body.user_id;
    const requestId = req.body.request_id;

    // Insert the user_id into the organizer table
    const insertSql = "INSERT INTO organizer (user_id) VALUES (?)";
    db.query(insertSql, [userId], (insertErr, insertData) => {
        if (insertErr) {
            return res.status(500).json({ error: 'Error inserting user into organizer table' });
        }

        // Delete the corresponding record f    rom the organizer_request table
        const deleteSql = "DELETE FROM organizer_request WHERE request_id = ?";
        db.query(deleteSql, [requestId], (deleteErr, deleteData) => {
            if (deleteErr) {
                return res.status(500).json({ error: 'Error deleting record from organizer_request table' });
            }

            // If both insert and delete operations are successful, return success response
            return res.status(200).json({ message: 'User successfully moved to organizer table' });
        });
    });
});


// SQL query to check if the user is an organizer
const checkOrganizerQuery = "SELECT COUNT(*) AS isOrganizer FROM organizer WHERE user_id = ?";

// Route to check if the user is an organizer
app.post('/checkOrganizer', (req, res) => {
    const userId = req.body.user_id;

    // Execute the SQL query
    db.query(checkOrganizerQuery, userId, (err, result) => {
        if (err) {
            console.error("Error checking organizer status:", err);
            return res.json(0); // Return 0 indicating error
        }

        // Check if the user is an organizer
        const isOrganizer = result[0].isOrganizer === 1 ? 1 : 0;
        return res.json(isOrganizer); // Return 1 if the user is an organizer, otherwise 0
    });
});


// route for event creation
app.post('/eventCreation', (req, res) => {
    const sql = "INSERT INTO events (`organizer_id`, `title`, `start_date`, `end_date`, `description`) VALUES (?) ";
    const values = [
        req.body.organizer_id,
        req.body.title,
        req.body.start_date,
        req.body.end_date,
        req.body.description
    ]

    db.query(sql, [values], (err, data) => {
        if(err) {
            return res.json("Error");
        }
        return res.json(data);
    });
});

// route for event registration
app.post('/home/eventRegistrationPending', (req, res) => {
    const sql = "INSERT INTO event_registration (`user_id`, `event_id`, `registration_status`, `registration_date`) VALUES (?) ";
    const values = [
        req.body.ls_user_id,
        req.body.curr_event_id,
        req.body.pending,
        req.body.date_now,
    ]

    db.query(sql, [values], (err, data) => {
        if(err) {
            return res.json("Error");
        }
        return res.json(data);
    });
});


// // Route to fetch all events given user_id
// app.get('/registeredEvents', (req, res) => {
//     const sql = `
//         SELECT e.* 
//         FROM events e
//         INNER JOIN event_registration er ON e.event_id = er.event_id
//         WHERE er.user_id = ?`;
//     db.query(sql, [req.query.user_id], (err, result) => {
//         if (err) {
//             res.status(500).json({ error: 'Error fetching registered events' });
//         } else {
//             res.json(result);
//         }
//     });
// });

// // Route to delete an event registration
// app.delete('/eventRegistration/:eventId', (req, res) => {
//     const eventId = req.params.eventId;

//     const sql = "DELETE FROM event_registration WHERE event_id = ?";
//     db.query(sql, [eventId], (err, result) => {
//         if (err) {
//             console.error('Error deleting event registration:', err);
//             res.status(500).json({ error: 'Error deleting event registration' });
//         } else {
//             console.log('Event registration deleted successfully');
//             res.status(200).json({ message: 'Event registration deleted successfully' });
//         }
//     });
// });

// Route to delete an event registration
app.delete('/eventRegistration/:eventId/:userId', (req, res) => {
    const eventId = req.params.eventId;
    const userId = req.params.userId;

    const sql = "DELETE FROM event_registration WHERE event_id = ? AND user_id = ?";
    db.query(sql, [eventId, userId], (err, result) => {
        if (err) {
            console.error('Error deleting event registration:', err);
            res.status(500).json({ error: 'Error deleting event registration' });
        } else {
            console.log('Event registration deleted successfully');
            res.status(200).json({ message: 'Event registration deleted successfully' });
        }
    });
});

// // Route to fetch all events given user_id
// app.get('/registeredEvents', (req, res) => {
//     const sql = `
//         SELECT e.* 
//         FROM events e
//         INNER JOIN event_registration er ON e.event_id = er.event_id
//         WHERE er.user_id = ?`;
//     db.query(sql, [req.query.user_id], (err, result) => {
//         if (err) {
//             res.status(500).json({ error: 'Error fetching registered events' });
//         } else {
//             res.json(result);
//         }
//     });
// });

// // Route to fetch all events given user_id
app.get('/registeredEvents', (req, res) => {
    const sql = `
        SELECT 
            e.title, 
            e.start_date, 
            e.end_date, 
            e.description, 
            er.registration_status AS registration_status, 
            e.organizer_id,
            er.event_id AS event_id
        FROM 
            events e
        INNER JOIN 
            event_registration er ON e.event_id = er.event_id
        WHERE 
            er.user_id = '${req.query.user_id}'`;
    db.query(sql, (err, result) => {
        if (err) {
            res.status(500).json({ error: 'Error fetching registered events' });
        } else {
            res.json(result);
        }
    });
});

// // Route to fetch all events given user_id
app.get('/approvedEvents', (req, res) => {
    const sql = `
        SELECT 
            e.title, 
            e.start_date, 
            e.end_date, 
            e.description, 
            er.registration_status AS registration_status, 
            e.organizer_id
        FROM 
            events e
        INNER JOIN 
            approved_requests er ON e.event_id = er.event_id
        WHERE 
            er.user_id = '${req.query.user_id}'`;
    db.query(sql, (err, result) => {
        if (err) {
            res.status(500).json({ error: 'Error fetching registered events' });
        } else {
            res.json(result);
        }
    });
});



// Route to fetch event registration requests with event titles
app.get('/eventRegistrationsWithTitles', (req, res) => {
    const sql = `
        SELECT er.*, e.title AS event_title
        FROM event_registration er
        INNER JOIN events e ON er.event_id = e.event_id
    `;
    db.query(sql, (err, result) => {
        if (err) {
            console.error('Error fetching event registrations with titles:', err);
            res.status(500).json({ error: 'Error fetching event registrations with titles' });
        } else {
            res.status(200).json(result);
        }
    });
});

// route to approve user event request
app.post('/approveEventRequest', (req, res) => {
    const registrationId = req.body.registration_id;
    const userId = req.body.user_id;
    const eventId = req.body.event_id;
    // Insert into approved_requests table
    const insertApprovedSql = "INSERT INTO approved_requests (registration_id, user_id, event_id, registration_status, registration_date) SELECT registration_id, user_id, event_id, 'Approved', CURRENT_TIMESTAMP FROM event_registration WHERE registration_id = ?";
    db.query(insertApprovedSql, [registrationId], (insertApprovedErr, insertApprovedData) => {
        if (insertApprovedErr) {
            return res.status(500).json({ error: 'Error inserting into approved_requests table' });
        }

        // Delete from event_registration table
        const deleteEventRegSql = "DELETE FROM event_registration WHERE registration_id = ?";
        db.query(deleteEventRegSql, [registrationId], (deleteEventRegErr, deleteEventRegData) => {
            if (deleteEventRegErr) {
                return res.status(500).json({ error: 'Error deleting record from event_registration table' });
            }

            // Insert into notifications table
            const insertNotificationSql = "INSERT INTO notifications (user_id, organizer_id, event_id, notification_date, message) VALUES (?, ?, ?, CURRENT_TIMESTAMP, ?)";
            const message = `Your request for the event has been approved.`;
            db.query(insertNotificationSql, [userId, req.organizer_id, eventId, message], (insertNotificationErr, insertNotificationData) => {
                if (insertNotificationErr) {
                    return res.status(500).json({ error: 'Error inserting into notifications table' });
                }

                // If all operations are successful, return success response
                return res.status(200).json({ message: 'Request approved and notification sent successfully' });
            });
        });
    });
});

// Route to retrieve user notifications
app.get('/notifications/:userId', (req, res) => {
    const userId = req.params.userId;

    const getNotificationsSql = "SELECT * FROM notifications WHERE user_id = ?";
    db.query(getNotificationsSql, [userId], (err, results) => {
        if (err) {
            console.error('Error fetching notifications:', err);
            return res.status(500).json({ error: 'Error fetching notifications' });
        }

        return res.status(200).json(results);
    });
});


app.listen(8081, ()=> {
    console.log("listening");
})