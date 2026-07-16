const express = require("express");
const helmet = require("helmet");
const morgan = require("morgan");
const client = require("prom-client");

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use(helmet());
app.use(morgan("combined"));

/* --------------------------------------------------
   Sample Data
---------------------------------------------------*/

let users = [
    { id: 1, name: "Prashant" },
    { id: 2, name: "John" }
];

/* --------------------------------------------------
   Prometheus Metrics
---------------------------------------------------*/

const register = new client.Registry();

client.collectDefaultMetrics({
    register
});

const httpRequestCounter = new client.Counter({
    name: "http_requests_total",
    help: "Total HTTP Requests",
    labelNames: ["method", "route", "status"]
});

const httpErrorCounter = new client.Counter({
    name: "http_errors_total",
    help: "Total HTTP Errors",
    labelNames: ["method", "route", "status"]
});

const httpDuration = new client.Histogram({
    name: "http_request_duration_seconds",
    help: "HTTP Request Duration",
    labelNames: ["method", "route", "status"],
    buckets: [0.1,0.3,0.5,1,2,5]
});

register.registerMetric(httpRequestCounter);
register.registerMetric(httpErrorCounter);
register.registerMetric(httpDuration);

/* --------------------------------------------------
   Metrics Middleware
---------------------------------------------------*/

app.use((req,res,next)=>{

    const end = httpDuration.startTimer();

    res.on("finish",()=>{

        httpRequestCounter.inc({
            method:req.method,
            route:req.route ? req.route.path : req.path,
            status:res.statusCode
        });

        if(res.statusCode>=400){

            httpErrorCounter.inc({
                method:req.method,
                route:req.route ? req.route.path : req.path,
                status:res.statusCode
            });

        }

        end({
            method:req.method,
            route:req.route ? req.route.path : req.path,
            status:res.statusCode
        });

    });

    next();

});

/* --------------------------------------------------
   Routes
---------------------------------------------------*/

app.get("/",(req,res)=>{

    res.json({
        message:`Welcome to NodeJS App running on Amazon EKS Env ${process.env.env}`
    });

});

app.get("/health",(req,res)=>{

    res.status(200).json({
        status:"UP"
    });

});

app.get("/ready",(req,res)=>{

    res.status(200).json({
        status:"READY"
    });

});

app.get("/users",(req,res)=>{

    res.json(users);

});

app.post("/users",(req,res)=>{

    const user={
        id:users.length+1,
        name:req.body.name
    };

    users.push(user);

    res.status(201).json(user);

});

app.get("/metrics",async(req,res)=>{

    res.set("Content-Type",register.contentType);

    res.end(await register.metrics());

});

/* --------------------------------------------------
   404
---------------------------------------------------*/

app.use((req,res)=>{

    res.status(404).json({
        message:"Route Not Found"
    });

});

/* --------------------------------------------------
   Error Handler
---------------------------------------------------*/

app.use((err,req,res,next)=>{

    console.error(err);

    res.status(500).json({
        message:"Internal Server Error"
    });

});

/* --------------------------------------------------
   Start Server
---------------------------------------------------*/

const server=app.listen(PORT,()=>{

    console.log(`Server Started on ${PORT}`);

});

/* --------------------------------------------------
   Graceful Shutdown
---------------------------------------------------*/

process.on("SIGTERM",()=>{

    console.log("SIGTERM received");

    server.close(()=>{

        console.log("Server stopped");

    });

});

process.on("SIGINT",()=>{

    console.log("SIGINT received");

    server.close(()=>{

        console.log("Server stopped");

        process.exit(0);

    });

});