/*
Created By  : Jahangir Sheikh
Created on  : August 2015
Description : This functionality created by jahangir to extend the functionality of unobstrusive.
*/

(function ($validator) {
    var formValInfo = "";

    $validator.setDefaults({ ignore: "" });

    var unobtrusiveExtend = {
        attachCommonValidator: function (element, uniqueId, callbackfnc) {
            var $element = element;
            $element.attr("data-val", "true");
            $element.attr("data-val-commonvalidator", "Invalid.");
            $element.attr("data-val-commonvalidator-id", uniqueId);
            this.common_val_methods[uniqueId] = callbackfnc;
        },
        getModelPrefix: function (fieldName) {
            return fieldName.substr(0, fieldName.lastIndexOf(".") + 1);
        },
        common_val_methods: {}
    };

    $.extend($validator.unobtrusive, unobtrusiveExtend);

    $validator.unobtrusive.adapters.add("requiredIf", ["controlname"],
            function (options) {
                options.rules.requiredIf = {
                    controlname: options.params.controlname
                };
                options.messages.requiredIf = options.message;
            }
        );
    $validator.unobtrusive.adapters.add("commonvalidator", ["id"],
            function (options) {
                //alert(options.params.id)
                options.rules.commonvalidator = {
                    id: options.params.id
                };
                options.messages.commonvalidator = options.message;
            }
        );
    
    $validator.addMethod("requiredIf", function (value, element, param) {
        alert(element.name)
        // check if dependency is met
        if ($(param.controlname).val() == "required") {
            switch (element.nodeName.toLowerCase()) {
                case 'select':
                    // could be an array for select-multiple or a string, both are fine this way
                    var val = $(element).val();
                    return val && val.length > 0;
                case 'input':
                    if (this.checkable(element))
                        return this.getLength(value, element) > 0;
                default:
                    return $.trim(value).length > 0;
            }
        }
        else {
            return true;
        }
    });
    
    jQuery.validator.addMethod("commonvalidator", function (value, element, param) {
        try {
            var $element = $(element),
                form = $element.parents("form")[0]
            if (!formValInfo) {
                formValInfo = $(form).data('validator');
            }
            var options = {};
            if (!$validator.unobtrusive.common_val_methods[param.id].call(this, value, element, param, options)) {
                formValInfo.settings.messages[element.name].commonvalidator = options.errMessage;
                return false;
            }
            
        } catch (e) {
            //alert(element.name)
            formValInfo.settings.messages[element.name].commonvalidator = "Something went wrong... Please contact to administrator...";
            return false;
        }
        return true;
    }, "");
})(jQuery.validator)
