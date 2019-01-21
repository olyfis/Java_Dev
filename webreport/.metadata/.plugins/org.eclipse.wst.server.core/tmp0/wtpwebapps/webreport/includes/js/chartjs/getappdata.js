// A $( document ).ready() block.
$( document ).ready(function() {
    console.log( "ready!" );
    $.ajax({
    	type: 'Get',
        url: 'http://localhost:8181/webreport/getchart',
        dataType: "json",
        success: function(data) {
        	console.log(data);
        	var pending_arr = [];
        	var released_arr = [];
        	
        	for (var i in data) {
        		console.log("Pending:" + data[i].pending);
        		console.log("Released:" + data[i].release);
        		pending_arr.push(data[i].pending)
        		released_arr.push(data[i].release)
        	}
        	var p = pending_arr[0];
        	var r = released_arr[0];
        	
        	/*
        	new Chart(document.getElementById("mycanvas"), {
        	    type: 'bar',
        	    scaleOverride : true,
                scaleSteps : 1,
               // scaleStepWidth : 50,
                scaleStartValue : 0,
                
        	    data: {
        	    	//labels: ["Pending", "Released"],
        	    	
        	    	datasets: [
        	    		
        	            {
        	              label: "Pending",
        	              backgroundColor: "#3e95cd",
        	          
        	              data: [p ]
        	            }, {
        	              label: "Released",
        	              backgroundColor: "#8e5ea2",
        	               
        	              data: [r]
        	            }
        	          ]
        	    },
        	    options: {
 
        	      title: {
        	        display: true,
        	        text: '> 95% Shipped By Status'
        	      }
        	    }
        	});
        	
        	*/
        	
        	/*
        	
        	scales: {
        		yAxes: [{
        			
        			ticks: {
                        beginAtZero: true,
                        steps: 5,
                        stepValue: 1,
                        max: 60 //max value for the chart is 60
                        }
                    
        			
        		}]
        		
      
            }
        */
        	var config = {
        			type: 'bar',
            	    
        			
                    data: {
            	    	//labels: ["Pending", "Released"],
            	    	
            	    	datasets: [	
            	            {
            	              label: "Pending Booking",
            	              backgroundColor: "#3e95cd",
            	              scaleOverride : true,
                              scaleSteps : 1,
                              scaleStepWidth : 1,
                              scaleStartValue : 0,
            	              data: [p ]
            	            }, {
            	              label: "Order Released",
            	              backgroundColor: "#8e5ea2",
            	               
            	              data: [r]
            	            }
            	          ]
            	    },
                    
                    
            	    options: {
                        responsive: true,
                        legend: {
                            position: 'bottom',
                        },
                        hover: {
                            mode: 'label'
                        },
                        scales: {
                            xAxes: [{
                                    display: true,
                                    scaleLabel: {
                                        display: true,
                                        //labelString: 'Month'
                                    }
                                }],
                            yAxes: [{
                                    display: true,
                                    ticks: {
                                        beginAtZero: true,
                                        steps: 10,
                                        stepValue: 5,
                                        max: 50
                                    }
                                }]
                        },
                        title: {
                            display: true,
                            text: '> 95% Shipped By Status'
                        }
                    }
        	
        	
        	
        	}
        	  var ctx = document.getElementById("mycanvas").getContext("2d");
              new Chart(ctx, config);
        	
        	console.log("************** Pending: " + pending_arr[0] );
        	console.log("************** Released: " + released_arr[0] );
        }, // end ajax success
        error:	function(data) {
        	console.log(data);
        },  // end ajax error
        
    }); // end ajax
  
});