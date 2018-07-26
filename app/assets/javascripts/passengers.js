// load map data and set variables
var mapData = gon.passengers || gon.events;
var pointlist = [];
var userMarker = [];

// draw polyline
function drawPolyline(data) {
  var pathLine = L.polyline(data, {
    dashArray: '1,5',
    color: '#000000',
    weight: 2,
    opacity: 0.75,
    className: 'path',
    lineCap: 'square',
  });

  return pathLine;
}

// initiate Google Autocompletion API
google.maps.event.addDomListener(window, 'load', function () {
  initializeAutocomplete('event_address');
  initializeAutocomplete('user_events_attributes_0_address');
});

// monitor change on address form
function initializeAutocomplete(id) {
  var element = document.getElementById(id);
  if (element) {
    var autocomplete = new google.maps.places.Autocomplete(element, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
  }
}

// place a new userMarker on address change
function onPlaceChanged() {
  var place = this.getPlace();
  var coordinates = [place.geometry.location.lat(), place.geometry.location.lng()];
  var event = new CustomEvent('addMarker', { detail: coordinates });
  document.dispatchEvent(event);
}

// define geolocate button id
var x = document.getElementById('geolocate');

// use browser to get current user position
function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else {
    x.innerHTML = 'Geolocation is not supported by this browser.';
  }
}

// html geolocated address on map and into corresponding form
function showPosition(position) {
  geocodeLatLng(position.coords.latitude, position.coords.longitude);

  var coordinates = [position.coords.latitude, position.coords.longitude];
  var event = new CustomEvent('addMarker', { detail: coordinates });
  document.dispatchEvent(event);
}

//geocode and handle errors with notification
function geocodeLatLng(lat, lng) {
  var geocoder = new google.maps.Geocoder();
  var latlng = { lat, lng };
  geocoder.geocode({ location: latlng}, function (results, status) {
    if (status === 'OK') {
      if (results[0]) {
        document.getElementById('user_events_attributes_0_address').value = results[0].formatted_address;
      }
    } else {
      $.notify({
        message: gon.gpsErrorMsg,
      }, {
        type: 'danger',
        offset: {
          x: 25,
          y: 80,
        },
        placement: {
          align: 'right',
        },
        animate: {
          enter: 'animated bounceIn',
          exit: 'animated bounceOut',
        }
      });
    }
  });
}

// animate geolocate button on click
$(function () {
    $('.geolocate').on('click', function () {
        $('.fa-map-marker').addClass('animate-flicker');
        setTimeout(RemoveClass, 3500);
      });

    function RemoveClass() {
      $('.fa-map-marker').removeClass('animate-flicker');
    }
  });

// create user icon
var positionIcon = L.divIcon({
  html: '<div class="pin"></div><div class="pin-effect"></div>',
  iconSize: [100, 100],
  iconAnchor: [50, 50],
  className: 'marker',
});

// ################ //
// ### ON READY ### //
// ################ //

$(document).ready(function () {

  var map = L.map('map');

  // load tiles
  $(function mymap() {
      L.tileLayer('https://api.mapbox.com/styles/v1/julesvau/cjl26w2ce4t8u2sohaa3uec8d/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoianVsZXN2YXUiLCJhIjoiY2prNDd6NW5yMGFtOTNrbzQ5bWEweDgzbSJ9.-RD762orQSENzQ_f7TKU9g', {
          attribution: '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a> © <a href="http://cloudmade.com">Mapbox</a>',
          zoomControl: false,
          minZoom: 3,
          maxZoom: 14,
        }).addTo(map);

      // remove copyright
      map.attributionControl.setPrefix('');

      //set zoom actions
      map.removeControl(map.zoomControl);
      $('.zoomin').click(function () {map.setZoom(map.getZoom() + 1); });

      $('.zoomout').click(function () {map.setZoom(map.getZoom() - 1); });

      // add scale
      L.control.scale({
        imperial: false,
      }).addTo(map);

      // cluster config
      var markerClusters = L.markerClusterGroup({
          maxClusterRadius: 80,
          spiderfyOnMaxZoom: true,
          showCoverageOnHover: true,
          zoomToBoundsOnClick: true,
          spiderfyDistanceMultiplier: 3.5,
          spiderLegPolylineOptions: { weight: 2, color: '#000000', opacity: 1 },
          polygonOptions: { color: '#000000', weight: 2, opacity: 1, fillOpacity: 0.25 },
          iconCreateFunction: function (cluster) {
              var count = cluster.getChildCount();
              var digits = (count + '').length;
              return new L.divIcon({
                html: count,
                className: 'cluster digits-' + digits,
                iconSize: null,
              });
            }
        });      // end of cluster config

      // load map data
      function onEachFeature(feature, layer) {
        if (feature.properties && feature.properties.marker_html) {

          // if marker has popup (passenger show, edit and add to path)
          if (feature.properties && feature.properties.popupContent) {
            layer.bindPopup(feature.properties.popupContent, {
              offset: new L.Point(0, -10),
              keepInView: true,
              showOnMouseOver: true,
              maxWidth: 300, //minWidth: 200,    //maxHeight: 200
            });

            // open with mouse and tap
            layer.on('mouseover tap', function (e) {
                  this.openPopup();
                });

            // close on mouseout
            // layer.on('mouseout', function (e) {
            //     this.closePopup()
            // });

            // Open current passenger location and prompt contact
            if (feature.properties && feature.properties.popupContent && feature.properties.divclass == 'last-marker') {
              $(map).ready(function () {

                    // save initial bounds, fly to current location, open pop up
                    var initialBounds = map._lastCenter;
                    setTimeout(function () {
                      markerClusters.zoomToShowLayer(layer, function () {
                        map.flyTo([layer.feature.geometry.coordinates[1], layer.feature.geometry.coordinates[0]]);
                        layer.openPopup();
                      });
                    }, 1500);

                    // get back to initial global passenger path and open contact form
                    setTimeout(function () {
                      showContact();
                    }, 2000);

                  }); // end of map ready
            }

            var x = feature.geometry.coordinates[1];
            var y = feature.geometry.coordinates[0];
            pointlist.push([x, y]);

          } // end if popup data is available

          // create a marker with data
          layer.setIcon(new L.DivIcon({
            iconSize: new L.Point(80, 80),
            iconAnchor: [40, 20],
            className: 'divicon',
            html: feature.properties.marker_html,
          }));
        } // end if marker data is available
      } // end of map data loading

      // add loaded data to map as markers
      var markers = L.geoJSON(mapData, {
        onEachFeature: onEachFeature,
      }).addTo(markerClusters);

      // fit map bounds to markers if any
      if (mapData.length > 0) {
        map.fitBounds(markers.getBounds(), { maxZoom: 14, padding: [95, 95] });
      } else {
        map.setView(new L.LatLng(33, -33), 1);
      }

      // draw current polyline from db data on map
      drawPolyline(pointlist).addTo(map);

      // add markers cluster
      map.addLayer(markerClusters);

      // on path 'build'
      document.addEventListener('build', function (e) {

          // add geolocation coordinates
          pointlist.push([e.detail[0], e.detail[1]]);

          // draw new path
          drawPolyline(pointlist).addTo(map);
        }, false);

      // on path 'rebuild'
      document.addEventListener('rebuild', function (e) {

          // clear map
          function clearMap() {
            for (i in map._layers) {
              if (map._layers[i]._path != undefined) {
                try {
                  map.removeLayer(map._layers[i]);
                } catch (e) {
                  console.log('problem with ' + e + map._layers[i]);
                }
              }
            }
          }

          clearMap();

          // remove last point
          pointlist.splice(-1, 1);

          // add geolocation coordinates
          pointlist.push([e.detail[0], e.detail[1]]);

          // draw new path
          drawPolyline(pointlist).addTo(map);
        }, false);

    }); // end of map function

  // draw user icon with path and focus on it
  var drawUserMarkerIcon = function (lat, lng) {
    var coordinates = [lat, lng];
    var markerPresence = map.hasLayer(userMarker);

    if (markerPresence) {

      map.removeLayer(userMarker);

      var event = new CustomEvent('rebuild', { detail: coordinates });
      document.dispatchEvent(event);

      userMarker = L.marker([lat, lng], { icon: positionIcon }).addTo(map);
      map.flyTo([lat, lng]);

    } else {

      var event = new CustomEvent('build', { detail: coordinates });
      document.dispatchEvent(event);

      userMarker = L.marker([lat, lng], { icon: positionIcon }).addTo(map);
      map.flyTo([lat, lng]);
    }
  };

  if (document.body.classList.contains('registrations') /** || document.body.classList.contains('edit')**/ ) {

    // placegeolocated marker
    document.addEventListener('addMarker', function (e) {

        // draw new marker
        drawUserMarkerIcon(e.detail[0], e.detail[1]);
      }, false);

    // geocode address on click and add point of map click
    map.on('click', function (e) {
      var lat = e.latlng.lat;
      var lng = e.latlng.lng;

      // fills form
      geocodeLatLng(lat, lng);

      //Add a marker to show where user clicked.
      drawUserMarkerIcon(lat, lng);
    });
  } // end on registrations or edit

}); // end on load
