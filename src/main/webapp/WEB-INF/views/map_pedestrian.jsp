<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!-- 선언부 -->

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=5A53DsGwddaFFyXqIjgmU8VGi3Vsx3Yb8DYy3kT7"></script>
    
    
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<title>보행자 경로</title>

</head>


<!--MAIN HOME UI-->

<body>
<div id="map_div" style="position: relative;"></div>
    <input type="hidden" id="searchAddress" />
    <input type="hidden" id="startx" />
    <input type="hidden" id="starty" />
    <input type="hidden" id="endx" />
    <input type="hidden" id="endy" />
    <div class="_map_layer_overlay">
        <div class="__space_15_h"></div>
        <div class="_map_overlay_row">
            <input type="text" id="searchStartAddress" class="_search_entry _search_entry_short" placeholder="출발지를 입력하세요" onkeyup="onKeyupSearchPoi(this);">
            <button onclick="clickSearchPois(this);" class="_search_address_btn" style="margin-top: 14px; margin-bottom: 14px; pointer-events: all; cursor: pointer;">
            </button>
            <div class="__space_13_w"></div>
            <input type="text" id="searchEndAddress" class="_search_entry _search_entry_short" placeholder="목적지를 입력하세요" onkeyup="onKeyupSearchPoi(this);">
            <button onclick="clickSearchPois(this);" class="_search_address_btn" style="margin-top: 14px; margin-bottom: 14px; pointer-events: all; cursor: pointer;">
            </button>
            <div class="__space_10_w"></div>
            <div class="_btn_action _btn_action-search __color_grey" onclick="apiSearchRoutes();">검색</div>
        </div>
        <div class="__flex_expand"></div>
        <div id="apiResult" class="_map_overlay_row">
            <div class="_result_panel_bg ">
                <div class="_result_panel">
                     
                    <div class="__disable_text">보행자 경로 안내</div>
                </div>
            </div>
        </div>
    </div>


<script>
    var map = new Tmapv2.Map("map_div", { // 지도가 생성될 div
        center: new Tmapv2.LatLng(37.56063619099832, 127.01233863830606),    // 지도의 중심좌표
        width : "750px", // 지도의 넓이
        height : "750px", // 지도의 높이
        zoom : 11, // 지도의 줌레벨
        httpsMode: true,    // https모드 설정
    });
    
    // 지도 타입 변경: ROAD
    map.setMapType(Tmapv2.Map.MapType.ROAD);
    /* API시작 */
    // 마커 초기화
    var markerStart = null;
    var markerEnd = null;
    var markerWp = [];
    var markerPoi = [];
    var markerPoint = [];
    var markerArr = [], lineArr = [], labelArr = [];
    var marker1 = new Tmapv2.Marker({
        icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_a.png",
        iconSize : new Tmapv2.Size(24, 38),
        map : map
    });
    var tData = new Tmapv2.extension.TData();
        
    
    // (장소API) 주소 찾기
    //경로 탐색 우클릭 시 인접도로 검색
    map.addListener("contextmenu", function onContextmenu(evt) {
        var mapLatLng = evt.latLng;
        //기존 마커 삭제
        marker1.setMap(null);
        var markerPosition = new Tmapv2.LatLng(
                mapLatLng._lat, mapLatLng._lng);
        //마커 올리기
        marker1 = new Tmapv2.Marker({
            position : markerPosition,
            icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_p.png",
            iconHTML: `
            <div class='_t_marker' style="position:relative;" >
                <img src="/lib/img/_icon/marker_blue.svg" style="width:48px;height:48px;position:absolute;"/>
                <div style="position:absolute; width:48px;height:42px; display:flex; align-items:center; justify-content: center; color:#FAFBFF; font-family: 'SUIT';font-style: normal;font-weight: 700;font-size: 15px;line-height: 19px;">
                P</div>
            </div>
            `,
            offset: new Tmapv2.Point(24, 38),
            iconSize : new Tmapv2.Size(24, 38),
            map : map
        });
        var lon = mapLatLng._lng;
        var lat = mapLatLng._lat;
        if(labelArr.length > 0){
            for(var i in labelArr){
                labelArr[i].setMap(null);
            }
            labelArr = [];
        }
        // poi 마커 지우기
        if(markerPoi.length > 0){
            for(var i in markerPoi){
                markerPoi[i].setMap(null);
            }
            markerPoi = [];
        }
        var params = {
            appKey : '5A53DsGwddaFFyXqIjgmU8VGi3Vsx3Yb8DYy3kT7',
            lon,
lat
        }
        const option = {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json;charset=utf-8',
            },
            body: JSON.stringify(params),
        };
        $.ajax({
            method:"GET",
            url:"https://apis.openapi.sk.com/tmap/road/nearToRoad?version=1",//가까운 도로 찾기 api 요청 url입니다.
            async:false,
            data:{
                appKey : "5A53DsGwddaFFyXqIjgmU8VGi3Vsx3Yb8DYy3kT7",
                lon,
                lat
            },
            success:function(response){
                
                var resultHeader, resultlinkPoints;
                
                if(response.resultData.header){
                    resultHeader = response.resultData.header;
                    resultlinkPoints = response.resultData.linkPoints;
                    
                    var tDistance = resultHeader.totalDistance;
                    var tTime = resultHeader.speed;	
                    var rName = resultHeader.roadName;
                    
                    
                    // 기존 라인 지우기
                    if(lineArr.length > 0){
                        for(var k=0; k<lineArr.length ; k++){
                            lineArr[k].setMap(null);
                        }
                        //지운뒤 배열 초기화
                        lineArr = [];
                    }
                    
                    var drawArr = [];
                    
                    // Tmapv2.LatLng객체로 이루어진 배열을 만듭니다.
                    for(var i in resultlinkPoints){
                        var lineLatLng = new Tmapv2.LatLng(resultlinkPoints[i].location.latitude, resultlinkPoints[i].location.longitude);
                        
                        drawArr.push(lineLatLng);
                    }
                    
                    //그리기
                    var polyline_ = new Tmapv2.Polyline({
                            path : drawArr,	//만든 배열을 넣습니다.
                            strokeColor : "#FF0000",
                            strokeWeight: 6,
                            map : map
                    });
                    
                    //라인 정보를 배열에 담습니다.
                    lineArr.push(polyline_);
                    let resultStr = `
                        <div class="_result_panel_bg">
                            <div class="_result_panel_area">
                                <div class="__reverse_geocoding_result" style="flex-grow: 1;">
                                    <p class="_result_text_line">총거리 : \${tDistance}m</p>
                                    <p class="_result_text_line">제한속도 : \${tTime}km/h</p>
                                    <p class="_result_text_line">도로명 : \${rName}</p>
                                    <p class="_result_text_line"></p>
                                </div>
                                <div>
                                    <div class="_search_item_button_panel">
                                            <div class="_search_item_button" onclick="enterDest('start', '\${rName}', '\${lon}', '\${lat}');">
                                                출발
                                            </div>
                                            <div class="_search_item_button" onclick="enterDest('end', '\${rName}', '\${lon}', '\${lat}');">
                                                도착
                                            </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        `;
                    var resultDiv = document.getElementById("apiResult");
                    resultDiv.innerHTML = resultStr;
                    
                }else{
                    $("#result").text("가까운 도로 검색 결과가 없습니다.");
                }
            },
            error:function(request,status,error){
                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });
        // tData.getAddressFromGeoJson(lat, lon, optionObj, params);
    });
    map.addListener("click", function onClick(evt) {
        var mapLatLng = evt.latLng;
        //기존 마커 삭제
        marker1.setMap(null);
        // 기존 라인 지우기
        if(lineArr.length > 0){
            for(var k=0; k<lineArr.length ; k++){
                lineArr[k].setMap(null);
            }
            //지운뒤 배열 초기화
            lineArr = [];
        }
        var markerPosition = new Tmapv2.LatLng(
                mapLatLng._lat, mapLatLng._lng);
        //마커 올리기
        marker1 = new Tmapv2.Marker({
            position : markerPosition,
            icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_p.png",
            iconHTML: `
            <div class='_t_marker' style="position:relative;" >
                <img src="/lib/img/_icon/marker_blue.svg" style="width:48px;height:48px;position:absolute;"/>
                <div style="position:absolute; width:48px;height:42px; display:flex; align-items:center; justify-content: center; color:#FAFBFF; font-family: 'SUIT';font-style: normal;font-weight: 700;font-size: 15px;line-height: 19px;">
                P</div>
            </div>
            `,
            offset: new Tmapv2.Point(24, 38),
            iconSize : new Tmapv2.Size(24, 38),
            map : map
        });
        var lon = mapLatLng._lng;
        var lat = mapLatLng._lat;
       
        var optionObj = {
            coordType: "WGS84GEO",       //응답좌표 타입 옵션 설정 입니다.
            addressType: "A10"           //주소타입 옵션 설정 입니다.
        };
        var params = {
            onComplete:function(result) { //데이터 로드가 성공적으로 완료 되었을때 실행하는 함수 입니다.
                // 기존 팝업 지우기
                if(labelArr.length > 0){
                    for(var i in labelArr){
                        labelArr[i].setMap(null);
                    }
                    labelArr = [];
                }
                
                // poi 마커 지우기
                if(markerPoi.length > 0){
                    for(var i in markerPoi){
                        markerPoi[i].setMap(null);
                    }
                    markerPoi = [];
                }
                $("#searchAddress").val('');
                $("._btn_radio").removeClass('__color_blue_fill');
                var arrResult = result._responseData.addressInfo;
                var fullAddress = arrResult.fullAddress.split(",");
                var newRoadAddr = fullAddress[2];
                var jibunAddr = fullAddress[1];
                if (arrResult.buildingName != '') {//빌딩명만 존재하는 경우
                    jibunAddr += (' ' + arrResult.buildingName);
                }
                let resultStr = `
                <div class="_result_panel_bg">
                    <div class="_result_panel_area">
                        <div class="__reverse_geocoding_result" style="flex-grow: 1;">
                            <p class="_result_text_line">새주소 : \${newRoadAddr}</p>
                            <p class="_result_text_line">지번주소 : \${jibunAddr}</p>
                            <p class="_result_text_line">좌표 (WSG84) : \${lat}, \${lon}</p>
                            <p class="_result_text_line"></p>
                        </div>
                        <div>
                            <div class="_search_item_button_panel">
                                    <div class="_search_item_button" onclick="enterDest('start', '\${newRoadAddr}', '\${lon}', '\${lat}');">
                                        출발
                                    </div>
                                    <div class="_search_item_button" onclick="enterDest('end', '\${newRoadAddr}', '\${lon}', '\${lat}');">
                                        도착
                                    </div>
                            </div>
                        </div>
                    </div>
                </div>
                `;
                
                var resultDiv = document.getElementById("apiResult");
                resultDiv.innerHTML = resultStr;
            },      
            onProgress:function() {},   //데이터 로드 중에 실행하는 함수 입니다.
            onError:function() {        //데이터 로드가 실패했을때 실행하는 함수 입니다.
                alert("onError");
            }             
        };
        tData.getAddressFromGeoJson(lat, lon, optionObj, params);
    });
    // (장소API) 통합 검색 함수
    function searchPois() {
        var searchKeyword = $("#searchAddress").val();
        var optionObj = {
            resCoordType : "WGS84GEO",
            reqCoordType : "WGS84GEO",
            count: 10
        };
        var params = {
            onComplete: function(result) {
                // 데이터 로드가 성공적으로 완료되었을 때 발생하는 이벤트입니다.
                var resultpoisData = result._responseData.searchPoiInfo.pois.poi;
                // 기존 마커, 팝업 제거
                reset();
                $("._btn_radio").removeClass('__color_blue_fill');
                if(marker1) {
                    marker1.setMap(null);
                }
                
                var innerHtml =    // Search Reulsts 결과값 노출 위한 변수
                `
                <div class="_result_panel_bg _scroll_padding">
                    <div class="_result_panel_scroll">
                `;
                var positionBounds = new Tmapv2.LatLngBounds();        //맵에 결과물 확인 하기 위한 LatLngBounds객체 생성
                
                for(var k in resultpoisData){
                    // POI 정보의 ID
                    var id = resultpoisData[k].id;
                    
                    var name = resultpoisData[k].name;
                    
                    var lat = Number(resultpoisData[k].noorLat);
                    var lon = Number(resultpoisData[k].noorLon);
                    
                    var frontLat = Number(resultpoisData[k].frontLat);
                    var frontLon = Number(resultpoisData[k].frontLon);
                    
                    var markerPosition = new Tmapv2.LatLng(lat, lon);
                    
                    var fullAddressRoad = resultpoisData[k].newAddressList.newAddress[0].fullAddressRoad;
                    
                    const marker3 = new Tmapv2.Marker({
                        position : markerPosition,
                        icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_" + k + ".png",
                        iconHTML:`
                            <div class='_t_marker' style="position:relative;" >
                            <img src="/lib/img/_icon/marker_grey.svg" style="width:48px;height:48px;position:absolute;"/>
                            <div style="position:absolute; width:48px;height:42px; display:flex; align-items:center; justify-content: center; color:#FAFBFF; font-family: 'SUIT';font-style: normal;font-weight: 700;font-size: 15px;line-height: 19px;">
                            \${Number(k)+1}</div>
                            </div>
                        `,
                        iconSize : new Tmapv2.Size(24, 38),
                        title : name,
                        label: `<span style="display:none;">\${k}_\${id}</span>`,
                        map:map
                    });
                    
                    // 마커 클릭 이벤트 추가
                    marker3.addListener("click", function(evt) {
                        for(let tMarker of markerPoi) {
                            const labelInfo = $(tMarker.getOtherElements()).text();
                            const forK = labelInfo.split("_")[0];
                            tMarker.setIconHTML(`
                                <div class='_t_marker' style="position:relative;" >
                                <img src="/lib/img/_icon/marker_grey.svg" style="width:48px;height:48px;position:absolute;"/>
                                <div style="position:absolute; width:48px;height:42px; display:flex; align-items:center; justify-content: center; color:#FAFBFF; font-family: 'SUIT';font-style: normal;font-weight: 700;font-size: 15px;line-height: 19px;">
                                \${Number(forK)+1}</div>
                                </div>
                            `);
                             // marker z-index 초기화
                             $(tMarker.getOtherElements()).next('div').css('z-index', 100);
                        }
                        // 선택한 marker z-index 처리 
                        $(marker3.getOtherElements()).next('div').css('z-index', 101);
                        const labelInfo = $(marker3.getOtherElements()).text();
                        const thisK = labelInfo.split("_")[0];
                        const thisId = labelInfo.split("_")[1];
                        marker3.setIconHTML(`
                            <div class='_t_marker' style="position:relative;" >
                            <img src="/lib/img/_icon/marker_blue.svg" style="width:48px;height:48px;position:absolute;"/>
                            <div style="position:absolute; width:48px;height:42px; display:flex; align-items:center; justify-content: center; color:#FAFBFF; font-family: 'SUIT';font-style: normal;font-weight: 700;font-size: 15px;line-height: 19px;">
                            \${Number(thisK)+1}</div>
                            </div>
                        `);
                        poiDetail(thisId, thisK);
                    });
                    
                    innerHtml += `
                        <div class="_search_item" id="poi_\${k}">
                            <div class="_search_item_poi">
                                <div class="_search_item_poi_icon _search_item_poi_icon_grey">
                                    <div class="_search_item_poi_icon_text">\${Number(k)+1}</div>
                                </div>
                            </div>
                            <div class="_search_item_info">
                                <p class="_search_item_info_title">\${name}</p>
                                <p class="_search_item_info_address">\${fullAddressRoad}</p>
                                <p class="_search_item_info_address">중심점 : \${lat}, \${lon}</p>
                                <p class="_search_item_info_address">입구점 : \${frontLat}, \${frontLon}</p>
                            </div>
                            <div class="_search_item_button_panel">
                                <div class="_search_item_button __color_blue" onclick='poiDetail("\${id}", "\${k}");'>
                                    상세정보
                                </div>
                            </div>
                            <div class="_search_item_button_panel">
                                <div class="_search_item_button" onclick="enterDest('start', '\${name}', '\${lon}', '\${lat}');">
                                    출발
                                </div>
                                <div class="_search_item_button" onclick="enterDest('end', '\${name}', '\${lon}', '\${lat}');">
                                    도착
                                </div>
                            </div>
                            
                        </div>
                        \${(resultpoisData.length-1) == Number(k) ? "": `<div class="_search_item_split"></div>`}
                    `;
                    markerPoi.push(marker3);
                    positionBounds.extend(markerPosition);    // LatLngBounds의 객체 확장
                }
                
                innerHtml += "</div></div>";
                $("#apiResult").html(innerHtml);    //searchResult 결과값 노출
                map.panToBounds(positionBounds);    // 확장된 bounds의 중심으로 이동시키기
                map.zoomOut();
            },
            onProgress: function() {},
            onError: function(){}
        }
        tData.getPOIDataFromSearchJson(searchKeyword, optionObj, params);
        
    }    
        
    // POI 상세검색 함수
    function poiDetail(poiId, thisK) {
        for(let tMarker of markerPoi) {
            const labelInfo = $(tMarker.getOtherElements()).text();
            const forK = labelInfo.split("_")[0];
            tMarker.setIconHTML(`
                <div class='_t_marker' style="position:relative;" >
                <img src="/lib/img/_icon/marker_grey.svg" style="width:48px;height:48px;position:absolute;"/>
                <div style="position:absolute; width:48px;height:42px; display:flex; align-items:center; justify-content: center; color:#FAFBFF; font-family: 'SUIT';font-style: normal;font-weight: 700;font-size: 15px;line-height: 19px;">
                \${Number(forK)+1}</div>
                </div>
            `);
             // marker z-index 초기화
             $(tMarker.getOtherElements()).next('div').css('z-index', 100);
        }
        markerPoi[thisK].setIconHTML(`
            <div class='_t_marker' style="position:relative;" >
            <img src="/lib/img/_icon/marker_blue.svg" style="width:48px;height:48px;position:absolute;"/>
            <div style="position:absolute; width:48px;height:42px; display:flex; align-items:center; justify-content: center; color:#FAFBFF; font-family: 'SUIT';font-style: normal;font-weight: 700;font-size: 15px;line-height: 19px;">
            \${Number(thisK)+1}</div>
            </div>
        `);
        // 선택한 marker z-index 처리 
        $(markerPoi[thisK].getOtherElements()).next('div').css('z-index', 101);
        var scrollOffset = $("#poi_"+thisK)[0].offsetTop - $("._result_panel_scroll")[0].offsetTop
        $("._result_panel_scroll").animate({scrollTop: scrollOffset}, 'slow');
        $("._result_panel_scroll ._search_item_poi_icon").removeClass("_search_item_poi_icon_blue");
        $("#poi_"+thisK).find('._search_item_poi_icon').addClass("_search_item_poi_icon_blue");
        // 기존 라벨 지우기
        if(labelArr.length > 0){
            for(var i in labelArr){
                labelArr[i].setMap(null);
            }
            labelArr = [];
        }
    
        var optionObj = {
            resCoordType: "WGS84GEO"
        }
        var params = {
            onComplete: function(result) {
                // 응답받은 POI 정보
                var detailInfo = result._responseData.poiDetailInfo;
                console.log(detailInfo);
                var name = detailInfo.name;
                var bldAddr = detailInfo.bldAddr;
                var tel = detailInfo.tel;
                var bizCatName = detailInfo.bizCatName;
                var parkingString = (detailInfo.parkFlag == "0"? "주차 불가능": (detailInfo.parkFlag == "1" ? "주차 가능": ""));
                var zipCode = detailInfo.zipCode;
                var lat = Number(detailInfo.lat);
                var lon = Number(detailInfo.lon);
                var bldNo1 = detailInfo.bldNo1;
                var bldNo2 = detailInfo.bldNo2;
                
                var labelPosition = new Tmapv2.LatLng(lat, lon);
                if(bldNo1 !== "") {
                    bldAddr += ` \${bldNo1}`;
                }
                if(bldNo2 !== "") {
                    bldAddr += `-\${bldNo2}`;
                }
                var content = `
                    <div class="_tmap_preview_popup_text">
                        <div class="_tmap_preview_popup_info">
                            <div class="_tmap_preview_popup_title">\${name}</div>
                            <div class="_tmap_preview_popup_address">\${bldAddr}</div>
                            <div class="_tmap_preview_popup_address">\${zipCode}</div>
                            <div class="_tmap_preview_popup_address">\${bizCatName}</div>
                `;
                // 상세보기 클릭 시 지도에 표출할 popup창
/*                     var content = "<div style=' border-radius:10px 10px 10px 10px;background-color:#2f4f4f; position: relative;"
                        + "line-height: 15px; padding: 5 5px 2px 4; right:65px; width:150px; padding: 5px;'>"
                        + "<div style='font-size: 11px; font-weight: bold ; line-height: 15px; color : white'>"
                        + name
                        + "</br>"
                        + address 
                        + "</br>"
                        + bizCatName;
 */                            
                if(tel !== "") {
                    content += `<div class="_tmap_preview_popup_address">\${tel}</div>`;
                }
                if(parkingString !== "") {
                    content += `<div class="_tmap_preview_popup_address">\${parkingString}</div>`;
                }
                
                content += "</div></div>";
            
                var labelInfo2 = new Tmapv2.InfoWindow({
                    position: labelPosition, //Popup 이 표출될 맵 좌표
                    content: content, //Popup 표시될 text
                    border:'0px solid #FF0000', //Popup의 테두리 border 설정.
                    background: false,
                    offset: new Tmapv2.Point(-12, -6),
                    type: 2, //Popup의 type 설정.
                    align: Tmapv2.InfoWindowOptions.ALIGN_CENTERTOP,
                    map: map //Popup이 표시될 맵 객체
                });
/* 
                var labelInfo2 = new Tmapv2.Label({
                    position : labelPosition,
                    content : content,
                    zIndex: 999,
                    align: 'ct',
                    map : map
                });
                 */
                //popup 생성
    
                // LABEL이 마커보다 상위에 표시되도록 수정함. 
                $("#map_div ._tmap_preview_popup_text").parent().parent().css('z-index', 10);
                // popup들을 담을 배열에 팝업 저장
                labelArr.push(labelInfo2);
                
                map.setCenter(labelPosition);
            },
            onProgress: function() {},
            onError: function() {}
        }
        tData.getPOIDataFromIdJson(poiId,optionObj, params);
    }        
    
    // 지도에 그릴 모드 선택
    var drawMode = "apiRoutesPedestrian";
    // 경로 API [검색] 버튼 동작
    async function apiSearchRoutes() {
        marker1.setMap(null);
        var startx = $("#startx").val();
        var starty = $("#starty").val();
        var endx = $("#endx").val();
        var endy = $("#endy").val();
        if($("._btn_action").hasClass('__color_grey')) {
            return false;
        }
        if(startx == "" || starty == "" || endx == "" || endy == "") {
            alert("정확한 주소를 입력하세요.");
            return false;
        }

        
        $("#apiResult").empty();
        reset();
        
        await routesPedestrian();

    }
    
    // (경로API) 보행자 경로 안내 API
    function routesPedestrian() {
        return new Promise(function(resolve, reject) {
            // 출발지, 목적지의 좌표를 조회
            var startx = $("#startx").val();
            var starty = $("#starty").val();
            var endx = $("#endx").val();
            var endy = $("#endy").val();
            var startLatLng = new Tmapv2.LatLng(starty, startx);
            var endLatLng = new Tmapv2.LatLng(endy, endx);
            var optionObj = {
                reqCoordType: "WGS84GEO",
                resCoordType: "WGS84GEO",
            };
            var params = {
                onComplete: function (result) {
                    var resultData = result._responseData.features;
                    //결과 출력
                    var appendHtml = `
                        <div class="_route_item">
                            <div class="_route_item_type \${drawMode == "apiRoutesPedestrian" ? "__color_blue" : ""}" onclick="routesRedrawMap('apiRoutesPedestrian');" style="cursor:">보행자 경로 안내</div>
                            <div class="_route_item_info">\${((resultData[0].properties.totalTime) / 60).toFixed(0)}분 | \${((resultData[0].properties.totalDistance) / 1000).toFixed(1)}km</div>
                        </div>
                    `;
                    // $("#apiResult").append(appendHtml);
                    writeApiResultHtml("apiRoutesPedestrian", appendHtml);
                    if (drawMode == "apiRoutesPedestrian") {
                        //기존 그려진 라인 & 마커가 있다면 초기화
                        reset();
                        // 시작마커설정
                        markerStart = new Tmapv2.Marker({
                            position: new Tmapv2.LatLng(starty, startx),
                            icon: "http://topopen.tmap.co.kr/imgs/start.png",
                            iconHTML: `
                            <div class='_t_marker' style="position:relative;" >
                                <img src="/lib/img/_icon/marker_red.svg" style="width:48px;height:48px;position:absolute;"/>
                                <div style="position:absolute; width:48px;height:42px; display:flex; align-items:center; justify-content: center; color:#FAFBFF; font-family: 'SUIT';font-style: normal;font-weight: 700;font-size: 15px;line-height: 19px;">
                                출발</div>
                            </div>
                            `,
                            offset: new Tmapv2.Point(24, 38),
                            iconSize: new Tmapv2.Size(24, 38),
                            map: map
                        });
                        // 도착마커설정
                        markerEnd = new Tmapv2.Marker({
                            position: new Tmapv2.LatLng(endy, endx),
                            icon: "http://topopen.tmap.co.kr/imgs/arrival.png",
                            iconHTML: `
                            <div class='_t_marker' style="position:relative;" >
                                <img src="/lib/img/_icon/marker_red.svg" style="width:48px;height:48px;position:absolute;"/>
                                <div style="position:absolute; width:48px;height:42px; display:flex; align-items:center; justify-content: center; color:#FAFBFF; font-family: 'SUIT';font-style: normal;font-weight: 700;font-size: 15px;line-height: 19px;">
                                도착</div>
                            </div>
                            `,
                            offset: new Tmapv2.Point(24, 38),
                            iconSize: new Tmapv2.Size(24, 38),
                            map: map
                        });
                        // markerArr.push(marker_s);
                        // markerArr.push(marker_e);
                        // GeoJSON함수를 이용하여 데이터 파싱 및 지도에 그린다.
                        var jsonObject = new Tmapv2.extension.GeoJSON();
                        var jsonForm = jsonObject.read(result._responseData);
                        jsonObject.drawRoute(map, jsonForm, {}, function (e) {
                            // 경로가 표출된 이후 실행되는 콜백 함수.
                            for (var m of e.markers) {
                                markerArr.push(m);
                            }
                            for (var l of e.polylines) {
                                lineArr.push(l);
                            }
                            var positionBounds = new Tmapv2.LatLngBounds(); //맵에 결과물 확인 하기 위한 LatLngBounds객체 생성
                            for (var polyline of e.polylines) {
                                for (var latlng of polyline.getPath().path) {
                                    positionBounds.extend(latlng);  // LatLngBounds의 객체 확장
                                }
                            }
                            map.panToBounds(positionBounds);
                            map.zoomOut();
                        });
                    }
                    resolve();
                },
                onProgress: function () {
                },
                onError: function () {
                }
            };
            tData.getRoutePlanForPeopleJson(startLatLng, endLatLng, "출발지", "도착지", optionObj, params);
        });
    }
    function clickSearchPois(buttonObj) {
        const $input = $(buttonObj).prev('input');
        if($(buttonObj).hasClass('_search_address_btn')) {
            $("#searchAddress").val($input.val());
            searchPois();
        } else if($(buttonObj).parent('div').hasClass('waypoint_input')) {
            // 경유지 제거
            const $_deleteObj = $(buttonObj).parent('div.waypoint_input');
            clearWaypoint($_deleteObj[0]);
        } else {
            const type = $input.attr('id') || '';
            if(type == "searchStartAddress") {
                $("#startx").val('');
                $("#starty").val('');
                if(markerStart) {
                    markerStart.setMap(null);
                }
        
            } else if(type == "searchEndAddress") {
                $("#endx").val('');
                $("#endy").val('');
                if(markerEnd) {
                    markerEnd.setMap(null);
                }
            }
            $input.val('');
            $("#searchAddress").val('');
            $(buttonObj).removeClass('_delete_address_btn');
            $(buttonObj).addClass('_search_address_btn');
            $("._btn_action").addClass('__color_grey');
/*                 if(($("#searchStartAddress").val() == "") || ($("#searchEndAddress").val() == "")) {
                console.log("remove1");
                $("._btn_action").addClass('__color_grey');
            } else {
                console.log("remove2");
                $("._btn_action").removeClass('__color_grey');
            }
 */            }
    }
    
    //(경로API공통) 엔터키 통합검색 함수
    function onKeyupSearchPoi(inputText) {
        /*
        if(($("#searchStartAddress").val() == "") || ($("#searchEndAddress").val() == "")) {
            $("._btn_action").addClass('__color_grey');
        } else {
            $("._btn_action").removeClass('__color_grey');
        }
        */
        $("._btn_action").addClass('__color_grey');
        if($(inputText).next('button').hasClass('_delete_address_btn')) {
            $(inputText).val('');
        }
        $(inputText).next('button').removeClass('_delete_address_btn');
        $(inputText).next('button').addClass('_search_address_btn');
        if (window.event.keyCode == 13) {
            // 엔터키가 눌렸을 때 실행하는 반응
            var isWaypoint = $(inputText).parent('div.waypoint_input').length == 1;
            if(isWaypoint) {
                // 경유지입력시 엔터키대상 li에대해 class추가
                $(".waypoint_input").each(function() {
                    $(this).removeClass('texton');
                });
                $(inputText).parent('div.waypoint_input').addClass('texton');
            }
            $("#searchAddress").val($(inputText).val());
            searchPois();
        }
    }
    
    // (경로API공통) 지도위의 경로 안내 효과 다시그림
    function routesRedrawMap(mode, carmode) {
        
        if (mode == "apiRoutesPedestrian") {
            drawMode = mode;
            routesPedestrian();
        } else if (mode == "apiRoutesCar" || mode == "apiRoutesMulti") {
            drawMode = mode+"_"+carmode;
            routesCar(carmode);
        }
        $("#apiResult").find('._route_item_type').removeClass('__color_blue');
        $("#apiResult").find('#'+drawMode).find('._route_item_type').addClass('__color_blue');
    }
    // (경로API공통) 출발지와 도착지의 좌표를 설정한다.
    function enterDest(type, address, x, y) {
        marker1.setMap(null);
        // 기존 라인 지우기
        if(lineArr.length > 0){
            for(var i in lineArr) {
                lineArr[i].setMap(null);
            }
            //지운뒤 배열 초기화
            lineArr = [];
        }
        // 경로찾기 point 마커 지우기
        if(markerPoint.length > 0){
            for(var i in markerPoint){
                markerPoint[i].setMap(null);
            }
            markerPoint = [];
        }
        if(type == 'start') {
            if(markerStart) {
                markerStart.setMap(null);
            }
            $("#startx").val(x);
            $("#starty").val(y);
            $("#searchStartAddress").val(address);
            $("#searchStartAddress").next('button').removeClass('_search_address_btn');
            $("#searchStartAddress").next('button').addClass('_delete_address_btn');
            
            markerStart = new Tmapv2.Marker({
                position : new Tmapv2.LatLng(y, x),
                icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png",
                iconHTML: `
                <div class='_t_marker' style="position:relative;" >
                    <img src="/lib/img/_icon/marker_red.svg" style="width:48px;height:48px;position:absolute;"/>
                    <div style="position:absolute; width:48px;height:42px; display:flex; align-items:center; justify-content: center; color:#FAFBFF; font-family: 'SUIT';font-style: normal;font-weight: 700;font-size: 15px;line-height: 19px;">
                    출발</div>
                </div>
                `,
                offset: new Tmapv2.Point(24, 38),
                iconSize : new Tmapv2.Size(24, 38),
                map : map
            });
        } else if(type == 'end') {
            if(markerEnd) {
                markerEnd.setMap(null);
            }
            $("#endx").val(x);
            $("#endy").val(y);
            $("#searchEndAddress").val(address);
            $("#searchEndAddress").next('button').removeClass('_search_address_btn');
            $("#searchEndAddress").next('button').addClass('_delete_address_btn');
            
            markerEnd = new Tmapv2.Marker({
                position : new Tmapv2.LatLng(y, x),
                icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_e.png",
                iconHTML: `
                <div class='_t_marker' style="position:relative;" >
                    <img src="/lib/img/_icon/marker_red.svg" style="width:48px;height:48px;position:absolute;"/>
                    <div style="position:absolute; width:48px;height:42px; display:flex; align-items:center; justify-content: center; color:#FAFBFF; font-family: 'SUIT';font-style: normal;font-weight: 700;font-size: 15px;line-height: 19px;">
                    도착</div>
                </div>
                `,
                offset: new Tmapv2.Point(24, 38),
                iconSize : new Tmapv2.Size(24, 38),
                map : map
            });
        } else if(type == 'wp') {
            const currentSize = $(".waypoint_input").length;
            const prependHtml = `
            <div class="__space_10_h"></div>
            <div class="waypoint_input _wp_not_empty _map_overlay_row" data-idx="0">
                <input type="hidden" name="multipos" value="\${x},\${y}">
                <input type="text" value="\${address}" class="_search_entry _search_entry_short" onkeyup="onKeyupSearchPoi(this);" placeholder="경유지를 입력하세요." style="padding-right: 45px;">
                <button onclick="clickSearchPois(this);" class="_delete_address_btn" style="margin-top: 14px; margin-bottom: 14px; pointer-events: all; cursor: pointer;"></button>
                <div style="width: 90px;"></div>
            </div>
            `;
            const emptyHtml = `
            <div class="__space_10_h"></div>
            <div class="waypoint_input _map_overlay_row" data-idx="0">
                <input type="hidden" name="multipos" />
                <input type="text" class="_search_entry _search_entry_short" onkeyup="onKeyupSearchPoi(this);" placeholder="경유지를 입력하세요." style="padding-right: 45px;">
                <button onclick="clickSearchPois(this);" class="_search_address_btn" style="margin-top: 14px; margin-bottom: 14px; pointer-events: all; cursor: pointer;"></button>
                <div style="width: 90px;"></div>
            </div>
            `;
            if(currentSize < 5) {
                const $_deleteObj = $("#wpList .waypoint_input:last");
                $_deleteObj.prev('.__space_10_h').remove();
                $_deleteObj.remove();
                $("#wpList").append(prependHtml);
                $("#wpList").append(emptyHtml);
            } else {
                const $_deleteObj = $("#wpList .waypoint_input:last");
                $_deleteObj.prev('.__space_10_h').remove();
                $_deleteObj.remove();
                $("#wpList").append(prependHtml);
            }
            redrawRouteMarker();
        }
        /* 검색버튼 활성화/비활성화 체크  */
        var startx = $("#startx").val();
        var starty = $("#starty").val();
        var endx = $("#endx").val();
        var endy = $("#endy").val();
        if(startx == "" || starty == "" || endx == "" || endy == "") {
            $("._btn_action").addClass('__color_grey');
        } else {
            $("._btn_action").removeClass('__color_grey');
        }
        
        // reset();
    }
    function clearWaypoint(destObj) {
        const currentSize = $(".waypoint_input._wp_not_empty").length;
        console.log("clearWaypoint: ", currentSize);
        const emptyHtml = `
            <div class="__space_10_h"></div>
            <div class="waypoint_input _map_overlay_row" data-idx="0">
                <input type="hidden" name="multipos" />
                <input type="text" class="_search_entry _search_entry_short" onkeyup="onKeyupSearchPoi(this);" placeholder="경유지를 입력하세요." style="padding-right: 45px;">
                <button onclick="clickSearchPois(this);" class="_search_address_btn" style="margin-top: 14px; margin-bottom: 14px; pointer-events: all; cursor: pointer;"></button>
                <div style="width: 90px;"></div>
            </div>
            `;
        const $_deleteObj = $(destObj);
        $_deleteObj.prev('.__space_10_h').remove();
        $_deleteObj.remove();
        if(currentSize == 5) {
        $("#wpList").append(emptyHtml);
        }
        redrawRouteMarker();
    }
    /* 경로검색시 경유지 마커 다시 그림 */
    function redrawRouteMarker() {
        if(markerWp.length > 0){
            for(var i in markerWp) {
                markerWp[i].setMap(null);
            }
            //지운뒤 배열 초기화
            markerWp = [];
        }
        $(".waypoint_input").each(function(idx) {
            // 차례번호 재생성
            $(this).attr('data-idx', idx);
            var pos = $(this).find("input[name='multipos']").val();
            if(pos == "") {
                return true;
            }
            var viaX = pos.split(',')[0];
            var viaY = pos.split(',')[1];
            markerWp[idx] = new Tmapv2.Marker({
                position : new Tmapv2.LatLng(viaY, viaX),
                icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_" + idx + ".png",
                iconHTML: `
                <div class='_t_marker' style="position:relative;" >
                    <img src="/lib/img/_icon/marker_blue.svg" style="width:48px;height:48px;position:absolute;"/>
                    <div style="position:absolute; width:48px;height:42px; display:flex; align-items:center; justify-content: center; color:#FAFBFF; font-family: 'SUIT';font-style: normal;font-weight: 700;font-size: 15px;line-height: 19px;">
                    \${idx+1}</div>
                </div>
                `,
                offset: new Tmapv2.Point(24, 38),
                iconSize : new Tmapv2.Size(24, 38),
                map:map
            });
        });
    }
    // (경로API공통) API 결과값 기록
    function writeApiResultHtml(type, string) {
        if($("#apiResult div#results").length == 0) {
            $("#apiResult").empty();
            $("#apiResult").html(`
                <div class="_result_panel_bg">
                    <div class="_result_panel_scroll">
                        <div class="__space_10_h"></div>
                        <div id="results"></div>
                        <div id="apiRoutesPedestrian"></div>
                        <div id="apiRoutesCar"></div>
                        <div id="apiRoutesMulti"></div>
                    </div>
                </div>
            `);
        }
        if(type.startsWith("apiRoutesCar_")) {
            if($("#apiResult #apiRoutesCar").find("#"+type).length == 0 ) {
                $("#apiResult #apiRoutesCar").append(`<div id="\${type}">\${string}</div>`);
            }
        } else if(type.startsWith("apiRouteSequential_") || type.startsWith("routesOptimization")) {
            if($("#apiResult #apiRoutesMulti").find("#"+type).length == 0 ) {
                $("#apiResult #apiRoutesMulti").append(`<div id="\${type}">\${string}</div>`);
            }
        } else {
            $("#apiResult").find("#"+type).html(string);
        }
    }   
    // (API 공통) 맵에 그려져있는 라인, 마커, 팝업을 지우는 함수
    function reset() {
        // 기존 라인 지우기
        if(lineArr.length > 0){
            for(var i in lineArr) {
                lineArr[i].setMap(null);
            }
            //지운뒤 배열 초기화
            lineArr = [];
        }
    
        // 기존 마커 지우기
        if(markerStart) {
            markerStart.setMap(null);
        }
        if(markerEnd) {
            markerEnd.setMap(null);
        }
        if(markerArr.length > 0){
            for(var i in markerArr){
                markerArr[i].setMap(null);
            }
            markerArr = [];
        }
        // poi 마커 지우기
        if(markerPoi.length > 0){
            for(var i in markerPoi){
                markerPoi[i].setMap(null);
            }
            markerPoi = [];
        }
        // 경로찾기 point 마커 지우기
        if(markerPoint.length > 0){
            for(var i in markerPoint){
                markerPoint[i].setMap(null);
            }
            markerPoint = [];
        }
        
        // 기존 팝업 지우기
        if(labelArr.length > 0){
            for(var i in labelArr){
                labelArr[i].setMap(null);
            }
            labelArr = [];
        }
    }
</script>

</body>



</html>