// jstree
$(function() {
    $('#orgDepartment').jstree({
        'core' : {
            'data' : [
                {
                    "text" : "오티아이[OTI]", "icon" : "fa-solid fa-building",
                    "children" : [
                        { "text" : "공공사업본부", "icon" : "fas fa-users", 
                          "children" : [
                            { "text" : "공공사업Div1.", "icon" : "fas fa-users" },
                            { "text" : "공공사업Div2.", "icon" : "fas fa-users" },
                            { "text" : "공공사업Div3.", "icon" : "fas fa-users" }
                          ]
                        },
                        { "text" : "전략사업본부", "icon" : "fas fa-users",
                            "children" : [
                                { "text" : "전략사업Div1.", "icon" : "fas fa-users" },
                                { "text" : "전략사업Div2.", "icon" : "fas fa-users" },
                                { "text" : "전략사업Div3.", "icon" : "fas fa-users" }
                            ]
                         },
                        { "text" : "경영지원실", "icon" : "fas fa-users",
                            "children" : [
                                { "text" : "인사팀", "icon" : "fas fa-users" },
                                { "text" : "재무팀", "icon" : "fas fa-users" }
                            ]
                         },
                        { "text" : "대표이사", "icon" : "fas fa-user" }
                    ]
                }
            ]
        },
        "themes" : {
            "dots" : false,
            "icons" : true
        }
    });
});