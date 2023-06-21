<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=5A53DsGwddaFFyXqIjgmU8VGi3Vsx3Yb8DYy3kT7"></script>
	
	    
	</head>
<body onload="initMap()">
<div id="map_div" style="position: relative;">
    <div class="_map_layer_overlay">
        <div class="__space_10_h"></div>
        <div class="_map_overlay_row">
            <input type="text" class="_search_entry" id="searchAddress" placeholder="목적지를 입력하세요" onkeyup="onKeyupSearchLocation(this);">
            <button onclick="apiSearchLocation();" style="margin-top: 14px; margin-bottom: 14px;    pointer-events: all;" >
                <img src="/lib/img/_icon/search.svg" alt="">
            </button>
        </div>
        <div class="__space_15_h"></div>
        <div class="_map_overlay_row">
            <div class="_btn_radio" data-cate="편의점" onclick="searchCategory(this)">편의점</div>
            <div class="__space_10_w"></div>
            <div class="_btn_radio" data-cate="까페" onclick="searchCategory(this)">카페</div>
            <div class="__space_10_w"></div>
            <div class="_btn_radio" data-cate="지하철" onclick="searchCategory(this)">지하철</div>
            <div class="__space_10_w"></div>
            <div class="_btn_radio" data-cate="TV맛집" onclick="searchCategory(this)">TV 맛집</div>
        </div>
        <div class="__flex_expand"></div>
        <div id="apiResult" class="_map_overlay_row">
            <div class="_result_panel_bg ">
                <div class="_result_panel">
                    <div class="__disable_text">검색할 주소를 입력하세요.</div>
                    <div class="__disable_text">마우스 왼쪽버튼으로 "주소찾기" 장소를 선택하세요.</div>
                    <div class="__disable_text">카테고리를 선택하세요.</div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var map = new Tmapv2.Map("map_div", { // 지도가 생성될 div
        center: new Tmapv2.LatLng(37.570028, 126.986072),    // 지도의 중심좌표
        width : "750px", // 지도의 넓이
        height : "750px", // 지도의 높이
        zoom : 13, // 지도의 줌레벨
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
        
    // (장소 API) API [검색] 버튼 동작
    function apiSearchLocation() {
        searchPois();
    }
    function onKeyupSearchLocation(obj) {
        if (window.event.keyCode == 13) {
            searchPois();
        }
    }
    
    // (장소API) 주소 찾기
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
            // icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_p.png",
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
                            <p class="_result_text_line">새주소 : ${newRoadAddr}</p>
                            <p class="_result_text_line">지번주소 : ${jibunAddr}</p>
                            <p class="_result_text_line">좌표 (WSG84) : ${lat}, ${lon}</p>
                            <p class="_result_text_line"></p>
                        </div>
                        <div>
                            <div class="_search_item_button_panel">
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
                        //icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_" + k + ".png",
                        iconHTML:`
                            <div class='_t_marker' style="position:relative;" >
                            <img src="/lib/img/_icon/marker_grey.svg" style="width:48px;height:48px;position:absolute;"/>
                            <div style="position:absolute; width:48px;height:42px; display:flex; align-items:center; justify-content: center; color:#FAFBFF; font-family: 'SUIT';font-style: normal;font-weight: 700;font-size: 15px;line-height: 19px;">
                            ${Number(k)+1}</div>
                            </div>
                        `,
                        iconSize : new Tmapv2.Size(24, 38),
                        title : name,
                        label: `<span style="display:none;">${k}_${id}</span>`,
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
                                ${Number(forK)+1}</div>
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
                            ${Number(thisK)+1}</div>
                            </div>
                        `);
                        poiDetail(thisId, thisK);
                    });
                    
                    innerHtml += `
                        <div class="_search_item" id="poi_${k}">
                            <div class="_search_item_poi">
                                <div class="_search_item_poi_icon _search_item_poi_icon_grey">
                                    <div class="_search_item_poi_icon_text">${Number(k)+1}</div>
                                </div>
                            </div>
                            <div class="_search_item_info">
                                <p class="_search_item_info_title">${name}</p>
                                <p class="_search_item_info_address">${fullAddressRoad}</p>
                                <p class="_search_item_info_address">중심점 : ${lat}, ${lon}</p>
                                <p class="_search_item_info_address">입구점 : ${frontLat}, ${frontLon}</p>
                            </div>
                            <div class="_search_item_button_panel">
                                <div class="_search_item_button __color_blue" onclick='poiDetail("${id}", "${k}");'>
                                    상세정보
                                </div>
                            </div>
                            <div class="_search_item_button_panel">
                            </div>
                            
                        </div>
                        ${(resultpoisData.length-1) == Number(k) ? "": '<div class="_search_item_split"></div>'}
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
                ${Number(forK)+1}</div>
                </div>
            `);
             // marker z-index 초기화
             $(tMarker.getOtherElements()).next('div').css('z-index', 100);
        }
        markerPoi[thisK].setIconHTML(`
            <div class='_t_marker' style="position:relative;" >
            <img src="/lib/img/_icon/marker_blue.svg" style="width:48px;height:48px;position:absolute;"/>
            <div style="position:absolute; width:48px;height:42px; display:flex; align-items:center; justify-content: center; color:#FAFBFF; font-family: 'SUIT';font-style: normal;font-weight: 700;font-size: 15px;line-height: 19px;">
            ${Number(thisK)+1}</div>
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
                    bldAddr += ` ${bldNo1}`;
                }
                if(bldNo2 !== "") {
                    bldAddr += `-${bldNo2}`;
                }
                var content = `
                    <div class="_tmap_preview_popup_text">
                        <div class="_tmap_preview_popup_info">
                            <div class="_tmap_preview_popup_title">${name}</div>
                            <div class="_tmap_preview_popup_address">${bldAddr}</div>
                            <div class="_tmap_preview_popup_address">${zipCode}</div>
                            <div class="_tmap_preview_popup_address">${bizCatName}</div>
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
                    content += `<div class="_tmap_preview_popup_address">${tel}</div>`;
                }
                if(parkingString !== "") {
                    content += `<div class="_tmap_preview_popup_address">${parkingString}</div>`;
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
        
    // (장소API) 카테고리 검색
    function searchCategory(obj) {
        // btn 강조
        $(obj).siblings('._btn_radio').removeClass('__color_blue_fill');
        $(obj).addClass('__color_blue_fill');
        var checkedSearchKeyword = $(obj).data("cate");
        var optionObj = {
            resCoordType: "WGS84GEO",
            radius: 1,
            count: 10
        }
        var params = {
            onComplete: function(result) {
                var resultpoisData = result._responseData.searchPoiInfo.pois.poi;
                // 2. 기존 마커, 팝업 제거
                reset();
                $("#searchAddress").val('');
                if(marker1) {
                    marker1.setMap(null);
                }
                
                var innerHtml =  // Search Reulsts 결과값 노출 위한 변수
                `
                <div class="_result_panel_bg _scroll_padding">
                    <div class="_result_panel_scroll">
                `;
                var positionBounds = new Tmapv2.LatLngBounds(); //맵에 결과물 확인 하기 위한 LatLngBounds객체 생성
                
                // 3. POI 마커 표시
                for(var k in resultpoisData){
                    // POI 마커 정보 저장
                    var lat = Number(resultpoisData[k].noorLat);
                    var lon = Number(resultpoisData[k].noorLon);
                    
                    var frontLat = Number(resultpoisData[k].frontLat);
                    var frontLon = Number(resultpoisData[k].frontLon);
                    
                    var name = resultpoisData[k].name;
                    
                    var fullAddressRoad = [resultpoisData[k].upperAddrName, resultpoisData[k].middleAddrName, resultpoisData[k].lowerAddrName, resultpoisData[k].roadName].join(" ");
                    
                    // POI 정보의 ID
                    var id = resultpoisData[k].id;
                    
                    // 좌표 설정
                    var markerPosition = new Tmapv2.LatLng(lat, lon);
                    
                    // Marker 설정
                    const marker3 = new Tmapv2.Marker({
                        position : markerPosition,
                        // icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_" + k + ".png",
                        iconHTML:`
                            <div class='_t_marker' style="position:relative;" >
                            <img src="/lib/img/_icon/marker_grey.svg" style="width:48px;height:48px;position:absolute;"/>
                            <div style="position:absolute; width:48px;height:42px; display:flex; align-items:center; justify-content: center; color:#FAFBFF; font-family: 'SUIT';font-style: normal;font-weight: 700;font-size: 15px;line-height: 19px;">
                            ${Number(k)+1}</div>
                            </div>
                        `,
                        iconSize : new Tmapv2.Size(24, 38),
                        title : name,
                        label: `<span style="display:none;">${k}_${id}</span>`,
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
                                ${Number(forK)+1}</div>
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
                            ${Number(thisK)+1}</div>
                            </div>
                        `);
                        poiDetail(thisId, thisK);
                    });
                    // 결과창에 나타날 검색 결과 html
                    innerHtml += `
                        <div class="_search_item" id="poi_${k}">
                            <div class="_search_item_poi">
                                <div class="_search_item_poi_icon _search_item_poi_icon_grey">
                                    <div class="_search_item_poi_icon_text">${Number(k)+1}</div>
                                </div>
                            </div>
                            <div class="_search_item_info">
                                <p class="_search_item_info_title">${name}</p>
                                <p class="_search_item_info_address">${fullAddressRoad}</p>
                                <p class="_search_item_info_address">중심점 : ${lat}, ${lon}</p>
                                <p class="_search_item_info_address">입구점 : ${frontLat}, ${frontLon}</p>
                            </div>
                            <div class="_search_item_button_panel">
                                <div class="_search_item_button __color_blue" onclick='poiDetail("${id}", "${k}");'>
                                    상세정보
                                </div>
                            </div>
                        </div>
                        ${(resultpoisData.length-1) == Number(k) ? "": `<div class="_search_item_split"></div>`}
                    `;
                    // 마커들을 담을 배열에 마커 저장
                    markerPoi.push(marker3);
                    positionBounds.extend(markerPosition);    // LatLngBounds의 객체 확장
                }
                
                innerHtml += "</div></div>";
                $("#apiResult").html(innerHtml);    //searchResult 결과값 노출
                map.panToBounds(positionBounds);    // 확장된 bounds의 중심으로 이동시키기
                map.zoomOut();
            }, 
            onProgress: function() {},
            onError: function() {}
        }
        tData.getPOIDataFromLonLatJson('37.570028', '126.986072', checkedSearchKeyword, optionObj, params);
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