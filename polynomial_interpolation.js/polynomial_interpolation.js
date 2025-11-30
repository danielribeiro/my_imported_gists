function draw(ctx, f, width, height) {
   var y;
   var ch = height/2;
   var cw = width/2;
   ctx.beginPath();
   ctx.moveTo(0, ch-f(-width));
   for (var x=-width+1; x<width; x++) {
     y = ch-f(x);
     ctx.lineTo(x+cw, y);
   }
   ctx.lineWidth = 2;
   ctx.stroke();
}

// draw coordination function
function coords(ctx, width, height) {
   ctx.beginPath();
   var cw = width/2;
   var ch = height/2;
   ctx.moveTo(cw, height);
   ctx.lineTo(cw, 0);
   ctx.moveTo(0, ch);
   ctx.lineTo(width, ch);
   ctx.strokeStyle = "rgb(0,0,0)";
   ctx.stroke();

   //y arrow
   ctx.beginPath();
   ctx.moveTo(cw-4, 14);
   ctx.lineTo(cw, 0);
   ctx.lineTo(cw+4, 14);
   ctx.closePath();
   ctx.fill();

   //x arrow
   ctx.beginPath();
   ctx.moveTo(width-14, ch-4);
   ctx.lineTo(width, ch);
   ctx.lineTo(width-14, ch+4);
   ctx.closePath();
   ctx.fill();

   ctx.font = "12pt Arial";
   ctx.fillText("y", cw+10, 15);
   ctx.fillText("x", width-10, ch+20);
}

function horner(array, x_scale, y_scale) {
   function recur(x, i, array) {
      if (i == 0) {
         return x*array[0];
      } else {
         return array[i] + x*recur(x, --i, array);
      }
   }
   return function(x) {
      return recur(x*x_scale, array.length-1, array)*y_scale;
   };
}

// initialize array
function zeros(n) {
   var array = new Array(n);
   for (var i=n; i--;) {
     array[i] = 0;
   }
   return array;
}

function denominator(i, points) {
   var result = 1;
   var x_i = points[i].x;
   for (var j=points.length; j--;) {
      if (i != j) {
        result *= x_i - points[j].x;
      }
   }
   return result;
}

// calculate coefficients for Li polynomial
function interpolation_polynomial(i, points) {
   var coefficients = zeros(points.length);
   coefficients[0] = 1/denominator(i,points);
    //new Array(points.length);
   /*for (var s=points.length; s--;) {
      coefficients[s] = 1/denominator(i,points);
   }*/
   var new_coefficients;

   for (var k = 0; k<points.length; k++) {
      if (k == i) {
        continue;
      }
      new_coefficients = zeros(points.length);
      for (var j=k; j--;) {
         new_coefficients[j+1] += coefficients[j];
         new_coefficients[j] -= points[k].x*coefficients[j];
      }   
      coefficients = new_coefficients;
   }
   console.log(coefficients);
   return coefficients;
}

// calculate coefficients of polynomial
function Lagrange(points) {
   var polynomial = zeros(points.length);
   var coefficients;
   for (var i=0; i<points.length; ++i) {
     coefficients = interpolation_polynomial(i, points);
     //console.log(coefficients);
     for (var k=0; k<points.length; ++k) {
       // console.log(points[k].y*coefficients[k]);
        polynomial[k] += points[k].y*coefficients[k];
     }
   }
   return polynomial;
}



$(function() {
   // canvas use init
   var canvas = $('canvas');
   var ctx = canvas[0].getContext("2d");
   var height = canvas.attr('height');
   var width = canvas.attr('width');
    
   coords(ctx, width, height);
    
   // helper function
   function draw_function(color, f) {
      ctx.strokeStyle = color;
      draw(ctx, f, width, height);
   }

   // draw polynomial
   draw_function("rgb(0,0,150)", horner([10,-3,3,-1,20], 0.008, 4));
   var points = new Array(10);
   // polynomial function (without scale)
   var W = horner([10,-3,3,-1,20], 1, 1);
   // create random points
   for (var i=0; i<10; ++i) {
      points[i] = {x: Math.random()};
      points[i].y = W(points[i].x);
   }
   // sort the points
   points = points.sort(function(a, b) {
       return a.x==b.x ? 0 : a.x>b.x ? 1 : -1;
   });
   var poly = Lagrange(points);
   console.log(poly);
    // try do draw function using polynomial from interpolation
    // should be similar (or the same) to original polynomial
   draw_function("rgb(150,0,0)", horner(poly.reverse(), 0.008, 4));
   

});