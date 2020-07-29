(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["layouts-admin-layout-admin-layout-module"],{

/***/ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/dashboard/dashboard.component.html":
/*!************************************************************************************************!*\
  !*** ./node_modules/raw-loader/dist/cjs.js!./src/app/pages/dashboard/dashboard.component.html ***!
  \************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("\n<div class=\" content\">\n  <div class=\" row\">\n    <div class=\" col-12\">\n      <div class=\" card card-chart\">\n        <div class=\" card-header\">\n          <div class=\" row\">\n            <div class=\" col-sm-6 text-left\">\n              <h5 class=\" card-category\">Total Shipments</h5>\n              <h2 class=\" card-title\">Performance</h2>\n            </div>\n            <div class=\" col-sm-6\">\n              <div\n                class=\" btn-group btn-group-toggle float-right\"\n                data-toggle=\"buttons\"\n              >\n                <label class=\" btn btn-sm btn-danger btn-simple\" (click)=\"data=datasets[0];updateOptions();clicked=true;clicked1=false;clicked2=false\" [ngClass]=\"{'active':clicked===true}\">\n                  <input checked=\"checked\" name=\"options\" type=\"radio\" />\n\n                  <span\n                    class=\" d-none d-sm-block d-md-block d-lg-block d-xl-block\"\n                  >\n                    Accounts\n                  </span>\n                  <span class=\" d-block d-sm-none\">\n                    <i class=\" tim-icons icon-single-02\"> </i>\n                  </span>\n                </label>\n                <label class=\" btn btn-sm btn-danger btn-simple\" (click)=\"data=datasets[1];updateOptions();clicked=false;clicked1=true;clicked2=false\" [ngClass]=\"{'active':clicked1===true}\">\n                  <input\n                    class=\" d-none d-sm-none\"\n                    name=\"options\"\n                    type=\"radio\"\n                  />\n\n                  <span\n                    class=\" d-none d-sm-block d-md-block d-lg-block d-xl-block\"\n                  >\n                    Purchases\n                  </span>\n                  <span class=\" d-block d-sm-none\">\n                    <i class=\" tim-icons icon-gift-2\"> </i>\n                  </span>\n                </label>\n                <label class=\" btn btn-sm btn-danger btn-simple\" (click)=\"data=datasets[2];updateOptions();clicked=false;clicked1=false;clicked2=true\" [ngClass]=\"{'active':clicked2===true}\">\n                  <input class=\" d-none\" name=\"options\" type=\"radio\" />\n\n                  <span\n                    class=\" d-none d-sm-block d-md-block d-lg-block d-xl-block\"\n                  >\n                    Sessions\n                  </span>\n                  <span class=\" d-block d-sm-none\">\n                    <i class=\" tim-icons icon-tap-02\"> </i>\n                  </span>\n                </label>\n              </div>\n            </div>\n          </div>\n        </div>\n        <div class=\" card-body\">\n          <div class=\" chart-area\"><canvas id=\"chartBig1\"> </canvas></div>\n        </div>\n      </div>\n    </div>\n  </div>\n  <div class=\" row\">\n    <div class=\" col-lg-4\">\n      <div class=\" card card-chart\">\n        <div class=\" card-header\">\n          <h5 class=\" card-category\">Total Shipments</h5>\n          <h3 class=\" card-title\">\n            <i class=\" tim-icons icon-bell-55 text-danger-states\"> </i> 763,215\n          </h3>\n        </div>\n        <div class=\" card-body\">\n          <div class=\" chart-area\"><canvas id=\"chartLineRed\"> </canvas></div>\n        </div>\n      </div>\n    </div>\n    <div class=\" col-lg-4\">\n      <div class=\" card card-chart\">\n        <div class=\" card-header\">\n          <h5 class=\" card-category\">Daily Sales</h5>\n          <h3 class=\" card-title\">\n            <i class=\" tim-icons icon-delivery-fast text-info\"> </i> 3,500€\n          </h3>\n        </div>\n        <div class=\" card-body\">\n          <div class=\" chart-area\"><canvas id=\"CountryChart\"> </canvas></div>\n        </div>\n      </div>\n    </div>\n    <div class=\" col-lg-4\">\n      <div class=\" card card-chart\">\n        <div class=\" card-header\">\n          <h5 class=\" card-category\">Completed Tasks</h5>\n          <h3 class=\" card-title\">\n            <i class=\" tim-icons icon-send text-success\"> </i> 12,100K\n          </h3>\n        </div>\n        <div class=\" card-body\">\n          <div class=\" chart-area\"><canvas id=\"chartLineGreen\"> </canvas></div>\n        </div>\n      </div>\n    </div>\n  </div>\n  <div class=\" row\">\n    <div class=\" col-lg-6 col-md-12\">\n      <div class=\" card card-tasks\">\n        <div class=\" card-header\">\n          <h6 class=\" title d-inline\">Tasks(5)</h6>\n          <p class=\" card-category d-inline\">today</p>\n          <div ngbDropdown>\n            <button\n              class=\" btn btn-link btn-icon\"\n              data-toggle=\"dropdown\"\n              ngbDropdownToggle\n              type=\"button\"\n            >\n              <i class=\" tim-icons icon-settings-gear-63\"> </i>\n            </button>\n            <div\n              aria-labelledby=\"dropdownMenuLink\"\n              class=\" dropdown-menu-right\"\n              ngbDropdownMenu\n            >\n              <a href=\"javascript:void(0)\" ngbDropdownItem> Action </a>\n              <a href=\"javascript:void(0)\" ngbDropdownItem> Another action </a>\n              <a href=\"javascript:void(0)\" ngbDropdownItem> Something else </a>\n            </div>\n          </div>\n        </div>\n        <div class=\" card-body\">\n          <div class=\" table-full-width table-responsive\">\n            <table class=\" table\">\n              <tbody>\n                <tr>\n                  <td>\n                    <div class=\" form-check\">\n                      <label class=\" form-check-label\">\n                        <input\n                          class=\" form-check-input\"\n                          type=\"checkbox\"\n                          value=\"\"\n                        />\n\n                        <span class=\" form-check-sign\">\n                          <span class=\" check\"> </span>\n                        </span>\n                      </label>\n                    </div>\n                  </td>\n                  <td>\n                    <p class=\" title\">Update the Documentation</p>\n                    <p class=\" text-muted\">\n                      Dwuamish Head, Seattle, WA 8:47 AM\n                    </p>\n                  </td>\n                  <td class=\" td-actions text-right\">\n                    <button class=\" btn btn-link\" type=\"button\" placement=\"left\" ngbTooltip=\"Edit Task\" container=\"body\" >\n                      <i class=\" tim-icons icon-pencil\"> </i>\n                    </button>\n                  </td>\n                </tr>\n                <tr>\n                  <td>\n                    <div class=\" form-check\">\n                      <label class=\" form-check-label\">\n                        <input\n                          checked=\"\"\n                          class=\" form-check-input\"\n                          type=\"checkbox\"\n                          value=\"\"\n                        />\n\n                        <span class=\" form-check-sign\">\n                          <span class=\" check\"> </span>\n                        </span>\n                      </label>\n                    </div>\n                  </td>\n                  <td>\n                    <p class=\" title\">GDPR Compliance</p>\n                    <p class=\" text-muted\">\n                      The GDPR is a regulation that requires businesses to\n                      protect the personal data and privacy of Europe citizens\n                      for transactions that occur within EU member states.\n                    </p>\n                  </td>\n                  <td class=\" td-actions text-right\">\n                    <button class=\" btn btn-link\" type=\"button\" placement=\"left\" ngbTooltip=\"Edit Task\" container=\"body\" >\n                      <i class=\" tim-icons icon-pencil\"> </i>\n                    </button>\n                  </td>\n                </tr>\n                <tr>\n                  <td>\n                    <div class=\" form-check\">\n                      <label class=\" form-check-label\">\n                        <input\n                          class=\" form-check-input\"\n                          type=\"checkbox\"\n                          value=\"\"\n                        />\n\n                        <span class=\" form-check-sign\">\n                          <span class=\" check\"> </span>\n                        </span>\n                      </label>\n                    </div>\n                  </td>\n                  <td>\n                    <p class=\" title\">Solve the issues</p>\n                    <p class=\" text-muted\">\n                      Fifty percent of all respondents said they would be more\n                      likely to shop at a company\n                    </p>\n                  </td>\n                  <td class=\" td-actions text-right\">\n                    <button class=\" btn btn-link\" type=\"button\" placement=\"left\" ngbTooltip=\"Edit Task\" container=\"body\" >\n                      <i class=\" tim-icons icon-pencil\"> </i>\n                    </button>\n                  </td>\n                </tr>\n                <tr>\n                  <td>\n                    <div class=\" form-check\">\n                      <label class=\" form-check-label\">\n                        <input\n                          class=\" form-check-input\"\n                          type=\"checkbox\"\n                          value=\"\"\n                        />\n\n                        <span class=\" form-check-sign\">\n                          <span class=\" check\"> </span>\n                        </span>\n                      </label>\n                    </div>\n                  </td>\n                  <td>\n                    <p class=\" title\">Release v2.0.0</p>\n                    <p class=\" text-muted\">\n                      Ra Ave SW, Seattle, WA 98116, SUA 11:19 AM\n                    </p>\n                  </td>\n                  <td class=\" td-actions text-right\">\n                    <button class=\" btn btn-link\" type=\"button\" placement=\"left\" ngbTooltip=\"Edit Task\" container=\"body\"  >\n                      <i class=\" tim-icons icon-pencil\"> </i>\n                    </button>\n                  </td>\n                </tr>\n                <tr>\n                  <td>\n                    <div class=\" form-check\">\n                      <label class=\" form-check-label\">\n                        <input\n                          class=\" form-check-input\"\n                          type=\"checkbox\"\n                          value=\"\"\n                        />\n\n                        <span class=\" form-check-sign\">\n                          <span class=\" check\"> </span>\n                        </span>\n                      </label>\n                    </div>\n                  </td>\n                  <td>\n                    <p class=\" title\">Export the processed files</p>\n                    <p class=\" text-muted\">\n                      The report also shows that consumers will not easily\n                      forgive a company once a breach exposing their personal\n                      data occurs.\n                    </p>\n                  </td>\n                  <td class=\" td-actions text-right\">\n                    <button class=\" btn btn-link\" type=\"button\" placement=\"left\" ngbTooltip=\"Edit Task\" container=\"body\" >\n                      <i class=\" tim-icons icon-pencil\"> </i>\n                    </button>\n                  </td>\n                </tr>\n                <tr>\n                  <td>\n                    <div class=\" form-check\">\n                      <label class=\" form-check-label\">\n                        <input\n                          class=\" form-check-input\"\n                          type=\"checkbox\"\n                          value=\"\"\n                        />\n\n                        <span class=\" form-check-sign\">\n                          <span class=\" check\"> </span>\n                        </span>\n                      </label>\n                    </div>\n                  </td>\n                  <td>\n                    <p class=\" title\">Arival at export process</p>\n                    <p class=\" text-muted\">\n                      Capitol Hill, Seattle, WA 12:34 AM\n                    </p>\n                  </td>\n                  <td class=\" td-actions text-right\">\n                    <button class=\" btn btn-link\" type=\"button\" placement=\"left\" ngbTooltip=\"Edit Task\" container=\"body\" >\n                      <i class=\" tim-icons icon-pencil\"> </i>\n                    </button>\n                  </td>\n                </tr>\n              </tbody>\n            </table>\n          </div>\n        </div>\n      </div>\n    </div>\n    <div class=\" col-lg-6 col-md-12\">\n      <div class=\" card\">\n        <div class=\" card-header\">\n          <h4 class=\" card-title\">Simple Table</h4>\n        </div>\n        <div class=\" card-body\">\n          <div class=\" table-responsive\">\n            <table class=\" table tablesorter\" id=\"\">\n              <thead class=\" text-primary\">\n                <tr>\n                  <th>Name</th>\n                  <th>Country</th>\n                  <th>City</th>\n                  <th class=\" text-center\">Salary</th>\n                </tr>\n              </thead>\n              <tbody>\n                <tr>\n                  <td>Dakota Rice</td>\n                  <td>Niger</td>\n                  <td>Oud-Turnhout</td>\n                  <td class=\" text-center\">$36,738</td>\n                </tr>\n                <tr>\n                  <td>Minerva Hooper</td>\n                  <td>CuraÃ§ao</td>\n                  <td>Sinaai-Waas</td>\n                  <td class=\" text-center\">$23,789</td>\n                </tr>\n                <tr>\n                  <td>Sage Rodriguez</td>\n                  <td>Netherlands</td>\n                  <td>Baileux</td>\n                  <td class=\" text-center\">$56,142</td>\n                </tr>\n                <tr>\n                  <td>Philip Chaney</td>\n                  <td>Korea, South</td>\n                  <td>Overland Park</td>\n                  <td class=\" text-center\">$38,735</td>\n                </tr>\n                <tr>\n                  <td>Doris Greene</td>\n                  <td>Malawi</td>\n                  <td>Feldkirchen in KÃ¤rnten</td>\n                  <td class=\" text-center\">$63,542</td>\n                </tr>\n                <tr>\n                  <td>Mason Porter</td>\n                  <td>Chile</td>\n                  <td>Gloucester</td>\n                  <td class=\" text-center\">$78,615</td>\n                </tr>\n                <tr>\n                  <td>Jon Porter</td>\n                  <td>Portugal</td>\n                  <td>Gloucester</td>\n                  <td class=\" text-center\">$98,615</td>\n                </tr>\n              </tbody>\n            </table>\n          </div>\n        </div>\n      </div>\n    </div>\n  </div>\n</div>\n");

/***/ }),

/***/ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/icons/icons.component.html":
/*!****************************************************************************************!*\
  !*** ./node_modules/raw-loader/dist/cjs.js!./src/app/pages/icons/icons.component.html ***!
  \****************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("\n<div class=\" content\">\n  <div class=\" row\">\n    <div class=\" col-md-12\">\n      <div class=\" card\">\n        <div class=\" card-header\">\n          <h5 class=\" title\">100 Awesome Nucleo Icons</h5>\n          <p class=\" category\">\n            Handcrafted by our friends from\n            <a href=\"https://nucleoapp.com/?ref=1712\"> NucleoApp </a>\n          </p>\n        </div>\n        <div class=\" card-body all-icons\">\n          <div class=\" row\">\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-alert-circle-exc\"> </i>\n                <p>icon-alert-circle-exc</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-align-center\"> </i>\n                <p>icon-align-center</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-align-left-2\"> </i>\n                <p>icon-align-left-2</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-app\"> </i>\n                <p>icon-app</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-atom\"> </i>\n                <p>icon-atom</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-attach-87\"> </i>\n                <p>icon-attach-87</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-badge\"> </i>\n                <p>icon-badge</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-bag-16\"> </i>\n                <p>icon-bag-16</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-bank\"> </i>\n                <p>icon-bank</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-basket-simple\"> </i>\n                <p>icon-basket-simple</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-bell-55\"> </i>\n                <p>icon-bell-55</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-bold\"> </i>\n                <p>icon-bold</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-book-bookmark\"> </i>\n                <p>icon-book-bookmark</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-double-right\"> </i>\n                <p>icon-double-right</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-bulb-63\"> </i>\n                <p>icon-bulb-63</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-bullet-list-67\"> </i>\n                <p>icon-bullet-list-67</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-bus-front-12\"> </i>\n                <p>icon-bus-front-12</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-button-power\"> </i>\n                <p>icon-button-power</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-camera-18\"> </i>\n                <p>icon-camera-18</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-calendar-60\"> </i>\n                <p>icon-calendar-60</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-caps-small\"> </i>\n                <p>icon-caps-small</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-cart\"> </i>\n                <p>icon-cart</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-chart-bar-32\"> </i>\n                <p>icon-chart-bar-32</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-chart-pie-36\"> </i>\n                <p>icon-chart-pie-36</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-chat-33\"> </i>\n                <p>icon-chat-33</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-check-2\"> </i>\n                <p>icon-check-2</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-cloud-download-93\"> </i>\n                <p>icon-cloud-download-93</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-cloud-upload-94\"> </i>\n                <p>icon-cloud-upload-94</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-coins\"> </i>\n                <p>icon-coins</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-compass-05\"> </i>\n                <p>icon-compass-05</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-controller\"> </i>\n                <p>icon-controller</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-credit-card\"> </i>\n                <p>icon-credit-card</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-delivery-fast\"> </i>\n                <p>icon-delivery-fast</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-email-85\"> </i>\n                <p>icon-email-85</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-gift-2\"> </i>\n                <p>icon-gift-2</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-globe-2\"> </i>\n                <p>icon-globe-2</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-headphones\"> </i>\n                <p>icon-headphones</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-heart-2\"> </i>\n                <p>icon-heart-2</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-html5\"> </i>\n                <p>icon-html5</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-double-left\"> </i>\n                <p>icon-double-left</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-image-02\"> </i>\n                <p>icon-image-02</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-istanbul\"> </i>\n                <p>icon-istanbul</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-key-25\"> </i>\n                <p>icon-key-25</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-laptop\"> </i>\n                <p>icon-laptop</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-light-3\"> </i>\n                <p>icon-light-3</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-link-72\"> </i>\n                <p>icon-link-72</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-lock-circle\"> </i>\n                <p>icon-lock-circle</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-map-big\"> </i>\n                <p>icon-map-big</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-minimal-down\"> </i>\n                <p>icon-minimal-down</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-minimal-left\"> </i>\n                <p>icon-minimal-left</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-minimal-right\"> </i>\n                <p>icon-minimal-right</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-minimal-up\"> </i>\n                <p>icon-minimal-up</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-mobile\"> </i>\n                <p>icon-mobile</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-molecule-40\"> </i>\n                <p>icon-molecule-40</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-money-coins\"> </i>\n                <p>icon-money-coins</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-notes\"> </i>\n                <p>icon-notes</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-palette\"> </i>\n                <p>icon-palette</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-paper\"> </i>\n                <p>icon-paper</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-pin\"> </i>\n                <p>icon-pin</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-planet\"> </i>\n                <p>icon-planet</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-puzzle-10\"> </i>\n                <p>icon-puzzle-10</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-pencil\"> </i>\n                <p>icon-pencil</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-satisfied\"> </i>\n                <p>icon-satisfied</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-scissors\"> </i>\n                <p>icon-scissors</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-send\"> </i>\n                <p>icon-send</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-settings-gear-63\"> </i>\n                <p>icon-settings-gear-63</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-settings\"> </i>\n                <p>icon-settings</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-wifi\"> </i>\n                <p>icon-wifi</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-single-02\"> </i>\n                <p>icon-single-02</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-single-copy-04\"> </i>\n                <p>icon-single-copy-04</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-sound-wave\"> </i>\n                <p>icon-sound-wave</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-spaceship\"> </i>\n                <p>icon-spaceship</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-square-pin\"> </i>\n                <p>icon-square-pin</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-support-17\"> </i>\n                <p>icon-support-17</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-tablet-2\"> </i>\n                <p>icon-tablet-2</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-tag\"> </i>\n                <p>icon-tag</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-tap-02\"> </i>\n                <p>icon-tap-02</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-tie-bow\"> </i>\n                <p>icon-tie-bow</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-time-alarm\"> </i>\n                <p>icon-time-alarm</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-trash-simple\"> </i>\n                <p>icon-trash-simple</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-trophy\"> </i>\n                <p>icon-trophy</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-tv-2\"> </i>\n                <p>icon-tv-2</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-upload\"> </i>\n                <p>icon-upload</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-user-run\"> </i>\n                <p>icon-user-run</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-vector\"> </i>\n                <p>icon-vector</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-video-66\"> </i>\n                <p>icon-video-66</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-wallet-43\"> </i>\n                <p>icon-wallet-43</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-volume-98\"> </i>\n                <p>icon-volume-98</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-watch-time\"> </i>\n                <p>icon-watch-time</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-world\"> </i>\n                <p>icon-world</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-zoom-split\"> </i>\n                <p>icon-zoom-split</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-refresh-01\"> </i>\n                <p>icon-refresh-01</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-refresh-02\"> </i>\n                <p>icon-refresh-02</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-shape-star\"> </i>\n                <p>icon-shape-star</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-components\"> </i>\n                <p>icon-components</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-triangle-right-17\"> </i>\n                <p>icon-triangle-right-17</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-button-pause\"> </i>\n                <p>icon-button-pause</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-simple-remove\"> </i>\n                <p>icon-simple-remove</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-simple-add\"> </i>\n                <p>icon-simple-add</p>\n              </div>\n            </div>\n            <div\n              class=\" font-icon-list col-lg-2 col-md-3 col-sm-4 col-xs-6 col-xs-6\"\n            >\n              <div class=\" font-icon-detail\">\n                <i class=\" tim-icons icon-simple-delete\"> </i>\n                <p>icon-simple-delete</p>\n              </div>\n            </div>\n          </div>\n        </div>\n      </div>\n    </div>\n  </div>\n</div>\n");

/***/ }),

/***/ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/map/map.component.html":
/*!************************************************************************************!*\
  !*** ./node_modules/raw-loader/dist/cjs.js!./src/app/pages/map/map.component.html ***!
  \************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("\n<div class=\" content\">\n  <div class=\" row\">\n    <div class=\" col-md-12\">\n      <div class=\" card card-plain\">\n        <div class=\" card-header\">Google Maps</div>\n        <div class=\" card-body\"><div class=\" map\" id=\"map\"></div></div>\n      </div>\n    </div>\n  </div>\n</div>\n");

/***/ }),

/***/ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/notifications/notifications.component.html":
/*!********************************************************************************************************!*\
  !*** ./node_modules/raw-loader/dist/cjs.js!./src/app/pages/notifications/notifications.component.html ***!
  \********************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("<div class=\" content\">\n  <div class=\" row\">\n    <div class=\" col-md-6\">\n      <div class=\" card\">\n        <div class=\" card-header\">\n          <h4 class=\" card-title\">Notifications Style</h4>\n        </div>\n        <div class=\" card-body\">\n          <ngb-alert [type]=\"'info'\" [dismissible]=\"false\">\n            <span> This is a plain notification </span>\n          </ngb-alert>\n          <ngb-alert [type]=\"'info'\" *ngIf=\"!staticAlertClosed\" [dismissible]=\"false\">\n            <button type=\"button\" aria-hidden=\"true\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\" (click)=\"staticAlertClosed = true\">\n              <i class=\"tim-icons icon-simple-remove\"></i>\n            </button>\n            <span> This is a notification with close button. </span>\n          </ngb-alert>\n          <ngb-alert\n            class=\" alert-with-icon\"\n            data-notify=\"container\"\n            [type]=\"'info'\"*ngIf=\"!staticAlertClosed1\" [dismissible]=\"false\">\n              <button type=\"button\" aria-hidden=\"true\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\" (click)=\"staticAlertClosed1 = true\">\n                <i class=\"tim-icons icon-simple-remove\"></i>\n              </button>\n            <span class=\" tim-icons icon-bell-55\" data-notify=\"icon\">\n            </span>\n            <span data-notify=\"message\">\n              This is a notification with close button and icon.\n            </span>\n          </ngb-alert>\n          <ngb-alert\n            class=\" alert-with-icon\"\n            data-notify=\"container\"\n            [type]=\"'info'\"\n            *ngIf=\"!staticAlertClosed2\" [dismissible]=\"false\">\n              <button type=\"button\" aria-hidden=\"true\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\" (click)=\"staticAlertClosed2 = true\">\n                <i class=\"tim-icons icon-simple-remove\"></i>\n              </button>\n            <span class=\" tim-icons icon-bell-55\" data-notify=\"icon\">\n            </span>\n            <span data-notify=\"message\">\n              This is a notification with close button and icon and have\n              many lines. You can see that the icon and the close button\n              are always vertically aligned. This is a beautiful\n              notification. So you don't have to worry about the style.\n            </span>\n          </ngb-alert>\n        </div>\n      </div>\n    </div>\n    <div class=\" col-md-6\">\n      <div class=\" card\">\n        <div class=\" card-header\">\n          <h4 class=\" card-title\">Notification states</h4>\n        </div>\n        <div class=\" card-body\">\n          <ngb-alert [type]=\"'primary'\" *ngIf=\"!staticAlertClosed3\" [dismissible]=\"false\">\n            <button type=\"button\" aria-hidden=\"true\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\" (click)=\"staticAlertClosed3 = true\">\n              <i class=\"tim-icons icon-simple-remove\"></i>\n            </button>\n            <span>\n              <b> Primary - </b> This is a regular notification made\n              with \".alert-primary\"\n            </span>\n          </ngb-alert>\n          <ngb-alert [type]=\"'info'\" *ngIf=\"!staticAlertClosed4\" [dismissible]=\"false\">\n            <button type=\"button\" aria-hidden=\"true\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\" (click)=\"staticAlertClosed4 = true\">\n              <i class=\"tim-icons icon-simple-remove\"></i>\n            </button>\n            <span>\n              <b> Info - </b> This is a regular notification made with\n              \".alert-info\"\n            </span>\n          </ngb-alert>\n          <ngb-alert [type]=\"'success'\" *ngIf=\"!staticAlertClosed5\" [dismissible]=\"false\">\n            <button type=\"button\" aria-hidden=\"true\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\" (click)=\"staticAlertClosed5 = true\">\n              <i class=\"tim-icons icon-simple-remove\"></i>\n            </button>\n            <span>\n              <b> Success - </b> This is a regular notification made\n              with \".alert-success\"\n            </span>\n          </ngb-alert>\n          <ngb-alert [type]=\"'warning'\" *ngIf=\"!staticAlertClosed6\" [dismissible]=\"false\">\n            <button type=\"button\" aria-hidden=\"true\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\" (click)=\"staticAlertClosed6 = true\">\n              <i class=\"tim-icons icon-simple-remove\"></i>\n            </button>\n            <span>\n              <b> Warning - </b> This is a regular notification made\n              with \".alert-warning\"\n            </span>\n          </ngb-alert>\n          <ngb-alert [type]=\"'danger'\" *ngIf=\"!staticAlertClosed7\" [dismissible]=\"false\">\n            <button type=\"button\" aria-hidden=\"true\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\" (click)=\"staticAlertClosed7 = true\">\n              <i class=\"tim-icons icon-simple-remove\"></i>\n            </button>\n            <span>\n              <b> Danger - </b> This is a regular notification made with\n              \".alert-danger\"\n            </span>\n          </ngb-alert>\n        </div>\n      </div>\n    </div>\n    <div class=\" col-md-12\">\n      <div class=\" card\">\n        <div class=\" card-body\">\n          <div class=\" places-buttons\">\n            <div class=\" row\">\n              <div class=\" col-md-6 ml-auto mr-auto text-center\">\n                <h4 class=\" card-title\">Notifications Places</h4>\n                <p class=\" category\">Click to view notifications</p>\n              </div>\n            </div>\n            <div class=\" row\">\n              <div class=\" col-lg-8 ml-auto mr-auto\">\n                <div class=\" row\">\n                  <div class=\" col-md-4\">\n                    <button\n                      class=\" btn btn-danger btn-block\"\n                      (click)=\"showNotification('top', 'left')\"\n                    >\n                      Top Left\n                    </button>\n                  </div>\n                  <div class=\" col-md-4\">\n                    <button\n                      class=\" btn btn-danger btn-block\"\n                      (click)=\"showNotification('top', 'center')\"\n                    >\n                      Top Center\n                    </button>\n                  </div>\n                  <div class=\" col-md-4\">\n                    <button\n                      class=\" btn btn-danger btn-block\"\n                      (click)=\"showNotification('top', 'right')\"\n                    >\n                      Top Right\n                    </button>\n                  </div>\n                </div>\n              </div>\n            </div>\n            <div class=\" row\">\n              <div class=\" col-lg-8 ml-auto mr-auto\">\n                <div class=\" row\">\n                  <div class=\" col-md-4\">\n                    <button\n                      class=\" btn btn-danger btn-block\"\n                      (click)=\"showNotification('bottom', 'left')\"\n                    >\n                      Bottom Left\n                    </button>\n                  </div>\n                  <div class=\" col-md-4\">\n                    <button\n                      class=\" btn btn-danger btn-block\"\n                      (click)=\"\n                        showNotification('bottom', 'center')\n                      \"\n                    >\n                      Bottom Center\n                    </button>\n                  </div>\n                  <div class=\" col-md-4\">\n                    <button\n                      class=\" btn btn-danger btn-block\"\n                      (click)=\"showNotification('bottom', 'right')\"\n                    >\n                      Bottom Right\n                    </button>\n                  </div>\n                </div>\n              </div>\n            </div>\n          </div>\n        </div>\n      </div>\n    </div>\n  </div>\n</div>\n");

/***/ }),

/***/ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/tables/tables.component.html":
/*!******************************************************************************************!*\
  !*** ./node_modules/raw-loader/dist/cjs.js!./src/app/pages/tables/tables.component.html ***!
  \******************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("\n<div class=\" content\">\n  <div class=\" row\">\n    <div class=\" col-md-12\">\n      <div class=\" card\">\n        <div class=\" card-header\">\n          <h4 class=\" card-title\">Simple Table</h4>\n        </div>\n        <div class=\" card-body\">\n          <div class=\" table-responsive\">\n            <table class=\" table tablesorter\" id=\"\">\n              <thead class=\" text-primary\">\n                <tr>\n                  <th>Name</th>\n                  <th>Country</th>\n                  <th>City</th>\n                  <th class=\" text-center\">Salary</th>\n                </tr>\n              </thead>\n              <tbody>\n                <tr>\n                  <td>Dakota Rice</td>\n                  <td>Niger</td>\n                  <td>Oud-Turnhout</td>\n                  <td class=\" text-center\">$36,738</td>\n                </tr>\n                <tr>\n                  <td>Minerva Hooper</td>\n                  <td>CuraÃ§ao</td>\n                  <td>Sinaai-Waas</td>\n                  <td class=\" text-center\">$23,789</td>\n                </tr>\n                <tr>\n                  <td>Sage Rodriguez</td>\n                  <td>Netherlands</td>\n                  <td>Baileux</td>\n                  <td class=\" text-center\">$56,142</td>\n                </tr>\n                <tr>\n                  <td>Philip Chaney</td>\n                  <td>Korea, South</td>\n                  <td>Overland Park</td>\n                  <td class=\" text-center\">$38,735</td>\n                </tr>\n                <tr>\n                  <td>Doris Greene</td>\n                  <td>Malawi</td>\n                  <td>Feldkirchen in KÃ¤rnten</td>\n                  <td class=\" text-center\">$63,542</td>\n                </tr>\n                <tr>\n                  <td>Mason Porter</td>\n                  <td>Chile</td>\n                  <td>Gloucester</td>\n                  <td class=\" text-center\">$78,615</td>\n                </tr>\n                <tr>\n                  <td>Jon Porter</td>\n                  <td>Portugal</td>\n                  <td>Gloucester</td>\n                  <td class=\" text-center\">$98,615</td>\n                </tr>\n              </tbody>\n            </table>\n          </div>\n        </div>\n      </div>\n    </div>\n    <div class=\" col-md-12\">\n      <div class=\" card card-plain\">\n        <div class=\" card-header\">\n          <h4 class=\" card-title\">Table on Plain Background</h4>\n          <p class=\" category\">Here is a subtitle for this table</p>\n        </div>\n        <div class=\" card-body\">\n          <div class=\" table-responsive\">\n            <table class=\" table tablesorter\" id=\"\">\n              <thead class=\" text-primary\">\n                <tr>\n                  <th>Name</th>\n                  <th>Country</th>\n                  <th>City</th>\n                  <th class=\" text-center\">Salary</th>\n                </tr>\n              </thead>\n              <tbody>\n                <tr>\n                  <td>Dakota Rice</td>\n                  <td>Niger</td>\n                  <td>Oud-Turnhout</td>\n                  <td class=\" text-center\">$36,738</td>\n                </tr>\n                <tr>\n                  <td>Minerva Hooper</td>\n                  <td>CuraÃ§ao</td>\n                  <td>Sinaai-Waas</td>\n                  <td class=\" text-center\">$23,789</td>\n                </tr>\n                <tr>\n                  <td>Sage Rodriguez</td>\n                  <td>Netherlands</td>\n                  <td>Baileux</td>\n                  <td class=\" text-center\">$56,142</td>\n                </tr>\n                <tr>\n                  <td>Philip Chaney</td>\n                  <td>Korea, South</td>\n                  <td>Overland Park</td>\n                  <td class=\" text-center\">$38,735</td>\n                </tr>\n                <tr>\n                  <td>Doris Greene</td>\n                  <td>Malawi</td>\n                  <td>Feldkirchen in KÃ¤rnten</td>\n                  <td class=\" text-center\">$63,542</td>\n                </tr>\n                <tr>\n                  <td>Mason Porter</td>\n                  <td>Chile</td>\n                  <td>Gloucester</td>\n                  <td class=\" text-center\">$78,615</td>\n                </tr>\n                <tr>\n                  <td>Jon Porter</td>\n                  <td>Portugal</td>\n                  <td>Gloucester</td>\n                  <td class=\" text-center\">$98,615</td>\n                </tr>\n              </tbody>\n            </table>\n          </div>\n        </div>\n      </div>\n    </div>\n  </div>\n</div>\n");

/***/ }),

/***/ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/typography/typography.component.html":
/*!**************************************************************************************************!*\
  !*** ./node_modules/raw-loader/dist/cjs.js!./src/app/pages/typography/typography.component.html ***!
  \**************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("\n<div class=\" content\">\n  <div class=\" row\">\n    <div class=\" col-md-12\">\n      <div class=\" card\">\n        <div class=\" card-header mb-5\">\n          <h5 class=\" card-category\">Black Table Heading</h5>\n          <h3 class=\" card-title\">Created using Poppins Font Family</h3>\n        </div>\n        <div class=\" card-body\">\n          <div class=\" typography-line\">\n            <h1><span> Header 1 </span> The Life of Black Dashboard</h1>\n          </div>\n          <div class=\" typography-line\">\n            <h2><span> Header 2 </span> The Life of Black Dashboard</h2>\n          </div>\n          <div class=\" typography-line\">\n            <h3><span> Header 3 </span> The Life of Black Dashboard</h3>\n          </div>\n          <div class=\" typography-line\">\n            <h4><span> Header 4 </span> The Life of Black Dashboard</h4>\n          </div>\n          <div class=\" typography-line\">\n            <h5><span> Header 5 </span> The Life of Black Dashboard</h5>\n          </div>\n          <div class=\" typography-line\">\n            <h6><span> Header 6 </span> The Life of Black Dashboard</h6>\n          </div>\n          <div class=\" typography-line\">\n            <p>\n              <span> Paragraph </span> I will be the leader of a company that\n              ends up being worth billions of dollars, because I got the\n              answers. I understand culture. I am the nucleus. I think thatâs a\n              responsibility that I have, to push possibilities, to show people,\n              this is the level that things could be at.\n            </p>\n          </div>\n          <div class=\" typography-line\">\n            <span> Quote </span>\n            <blockquote>\n              <p class=\" blockquote blockquote-danger\">\n                \"I will be the leader of a company that ends up being worth\n                billions of dollars, because I got the answers. I understand\n                culture. I am the nucleus. I think that's a responsibility that\n                I have, to push possibilities, to show people, this is the level\n                that things could be at.\" <br />\n\n                <br />\n\n                <small> - Noaa </small>\n              </p>\n            </blockquote>\n          </div>\n          <div class=\" typography-line\">\n            <span> Muted Text </span>\n            <p class=\" text-muted\">\n              I will be the leader of a company that ends up being worth\n              billions of dollars, because I got the answers...\n            </p>\n          </div>\n          <div class=\" typography-line\">\n            <span> Primary Text </span>\n            <p class=\" text-primary\">\n              I will be the leader of a company that ends up being worth\n              billions of dollars, because I got the answers...\n            </p>\n          </div>\n          <div class=\" typography-line\">\n            <span> Info Text </span>\n            <p class=\" text-info\">\n              I will be the leader of a company that ends up being worth\n              billions of dollars, because I got the answers...\n            </p>\n          </div>\n          <div class=\" typography-line\">\n            <span> Success Text </span>\n            <p class=\" text-success\">\n              I will be the leader of a company that ends up being worth\n              billions of dollars, because I got the answers...\n            </p>\n          </div>\n          <div class=\" typography-line\">\n            <span> Warning Text </span>\n            <p class=\" text-warning\">\n              I will be the leader of a company that ends up being worth\n              billions of dollars, because I got the answers...\n            </p>\n          </div>\n          <div class=\" typography-line\">\n            <span> Danger Text </span>\n            <p class=\" text-danger\">\n              I will be the leader of a company that ends up being worth\n              billions of dollars, because I got the answers...\n            </p>\n          </div>\n          <div class=\" typography-line\">\n            <h2>\n              <span> Small Tag </span> Header with small subtitle <br />\n\n              <small> Use \"small\" tag for the headers </small>\n            </h2>\n          </div>\n          <div class=\" typography-line\">\n            <span> Lists </span>\n            <div class=\" row\">\n              <div class=\" col-md-3\">\n                <h5>Unordered List</h5>\n                <ul>\n                  <li>List Item</li>\n                  <li>List Item</li>\n                  <li class=\" list-unstyled\">\n                    <ul>\n                      <li>List Item</li>\n                      <li>List Item</li>\n                      <li>List Item</li>\n                    </ul>\n                  </li>\n                  <li>List Item</li>\n                </ul>\n              </div>\n              <div class=\" col-md-3\">\n                <h5>Ordered List</h5>\n                <ol>\n                  <li>List Item</li>\n                  <li>List Item</li>\n                  <li>List item</li>\n                  <li>List Item</li>\n                </ol>\n              </div>\n              <div class=\" col-md-3\">\n                <h5>Unstyled List</h5>\n                <ul class=\" list-unstyled\">\n                  <li>List Item</li>\n                  <li>List Item</li>\n                  <li>List item</li>\n                  <li>List Item</li>\n                </ul>\n              </div>\n              <div class=\" col-md-3\">\n                <h5>Inline List</h5>\n                <ul class=\" list-inline\">\n                  <li class=\" list-inline-item\">List1</li>\n                  <li class=\" list-inline-item\">List2</li>\n                  <li class=\" list-inline-item\">List3</li>\n                </ul>\n              </div>\n            </div>\n          </div>\n          <div class=\" typography-line\">\n            <span> Code </span>\n            <p>\n              This is <code> .css-class-as-code </code> , an example of an\n              inline code element. Wrap inline code within a\n              <code> <code>...</code> </code> tag.\n            </p>\n            <pre>\n1. #This is an example of preformatted text.<br>\n\n2. #Here is another line of code\n</pre>\n          </div>\n        </div>\n      </div>\n    </div>\n  </div>\n</div>\n");

/***/ }),

/***/ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/user/user.component.html":
/*!**************************************************************************************!*\
  !*** ./node_modules/raw-loader/dist/cjs.js!./src/app/pages/user/user.component.html ***!
  \**************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony default export */ __webpack_exports__["default"] = ("\n<div class=\" content\">\n  <div class=\" row\">\n    <div class=\" col-md-8\">\n      <div class=\" card\">\n        <div class=\" card-header\"><h5 class=\" title\">Edit Profile</h5></div>\n        <div class=\" card-body\">\n          <form>\n            <div class=\" row\">\n              <div class=\" col-md-5 pr-md-1\">\n                <div class=\" form-group\">\n                  <label> Company (disabled) </label>\n                  <input\n                    class=\" form-control\"\n                    disabled=\"\"\n                    placeholder=\"Company\"\n                    type=\"text\"\n                    value=\"Creative Code Inc.\"\n                  />\n                </div>\n              </div>\n              <div class=\" col-md-3 px-md-1\">\n                <div class=\" form-group\">\n                  <label> Username </label>\n                  <input\n                    class=\" form-control\"\n                    placeholder=\"Username\"\n                    type=\"text\"\n                    value=\"michael23\"\n                  />\n                </div>\n              </div>\n              <div class=\" col-md-4 pl-md-1\">\n                <div class=\" form-group\">\n                  <label for=\"exampleInputEmail1\"> Email address </label>\n                  <input\n                    class=\" form-control\"\n                    placeholder=\"mike@email.com\"\n                    type=\"email\"\n                  />\n                </div>\n              </div>\n            </div>\n            <div class=\" row\">\n              <div class=\" col-md-6 pr-md-1\">\n                <div class=\" form-group\">\n                  <label> First Name </label>\n                  <input\n                    class=\" form-control\"\n                    placeholder=\"Company\"\n                    type=\"text\"\n                    value=\"Mike\"\n                  />\n                </div>\n              </div>\n              <div class=\" col-md-6 pl-md-1\">\n                <div class=\" form-group\">\n                  <label> Last Name </label>\n                  <input\n                    class=\" form-control\"\n                    placeholder=\"Last Name\"\n                    type=\"text\"\n                    value=\"Andrew\"\n                  />\n                </div>\n              </div>\n            </div>\n            <div class=\" row\">\n              <div class=\" col-md-12\">\n                <div class=\" form-group\">\n                  <label> Address </label>\n                  <input\n                    class=\" form-control\"\n                    placeholder=\"Home Address\"\n                    type=\"text\"\n                    value=\"Bld Mihail Kogalniceanu, nr. 8 Bl 1, Sc 1, Ap 09\"\n                  />\n                </div>\n              </div>\n            </div>\n            <div class=\" row\">\n              <div class=\" col-md-4 pr-md-1\">\n                <div class=\" form-group\">\n                  <label> City </label>\n                  <input\n                    class=\" form-control\"\n                    placeholder=\"City\"\n                    type=\"text\"\n                    value=\"Mike\"\n                  />\n                </div>\n              </div>\n              <div class=\" col-md-4 px-md-1\">\n                <div class=\" form-group\">\n                  <label> Country </label>\n                  <input\n                    class=\" form-control\"\n                    placeholder=\"Country\"\n                    type=\"text\"\n                    value=\"Andrew\"\n                  />\n                </div>\n              </div>\n              <div class=\" col-md-4 pl-md-1\">\n                <div class=\" form-group\">\n                  <label> Postal Code </label>\n                  <input\n                    class=\" form-control\"\n                    placeholder=\"ZIP Code\"\n                    type=\"number\"\n                  />\n                </div>\n              </div>\n            </div>\n            <div class=\" row\">\n              <div class=\" col-md-8\">\n                <div class=\" form-group\">\n                  <label> About Me </label>\n                  <textarea\n                    class=\" form-control\"\n                    cols=\"80\"\n                    placeholder=\"Here can be your description\"\n                    rows=\"4\"\n                    value=\"Mike\"\n                  >\nLamborghini Mercy, Your chick she so thirsty, I'm in that two seat Lambo.\n</textarea\n                  >\n                </div>\n              </div>\n            </div>\n          </form>\n        </div>\n        <div class=\" card-footer\">\n          <button class=\" btn btn-fill btn-danger\" type=\"submit\">Save</button>\n        </div>\n      </div>\n    </div>\n    <div class=\" col-md-4\">\n      <div class=\" card card-user\">\n        <div class=\" card-body\">\n          <p class=\" card-text\"></p>\n          <div class=\" author\">\n            <div class=\" block block-one\"></div>\n            <div class=\" block block-two\"></div>\n            <div class=\" block block-three\"></div>\n            <div class=\" block block-four\"></div>\n            <a href=\"javascript:void(0)\">\n              <img alt=\"...\" class=\" avatar\" src=\"assets/img/emilyz.jpg\" />\n\n              <h5 class=\" title\">Mike Andrew</h5>\n            </a>\n            <p class=\" description\">Ceo/Co-Founder</p>\n          </div>\n          <div class=\" card-description\">\n            Do not be scared of the truth because we need to restart the human\n            foundation in truth And I love you like Kanye loves Kanye I love\n            Rick Owens’ bed design but the back is...\n          </div>\n        </div>\n        <div class=\" card-footer\">\n          <div class=\" button-container\">\n            <button\n              class=\" btn btn-icon btn-round btn-facebook\"\n              href=\"javascript:void(0)\"\n            >\n              <i class=\" fab fa-facebook\"> </i>\n            </button>\n            <button\n              class=\" btn btn-icon btn-round btn-twitter\"\n              href=\"javascript:void(0)\"\n            >\n              <i class=\" fab fa-twitter\"> </i>\n            </button>\n            <button\n              class=\" btn btn-icon btn-round btn-google\"\n              href=\"javascript:void(0)\"\n            >\n              <i class=\" fab fa-google-plus\"> </i>\n            </button>\n          </div>\n        </div>\n      </div>\n    </div>\n  </div>\n</div>\n");

/***/ }),

/***/ "./src/app/layouts/admin-layout/admin-layout.module.ts":
/*!*************************************************************!*\
  !*** ./src/app/layouts/admin-layout/admin-layout.module.ts ***!
  \*************************************************************/
/*! exports provided: AdminLayoutModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "AdminLayoutModule", function() { return AdminLayoutModule; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "./node_modules/tslib/tslib.es6.js");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/__ivy_ngcc__/fesm5/core.js");
/* harmony import */ var _angular_common_http__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/common/http */ "./node_modules/@angular/common/__ivy_ngcc__/fesm5/http.js");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/router */ "./node_modules/@angular/router/__ivy_ngcc__/fesm5/router.js");
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/common */ "./node_modules/@angular/common/__ivy_ngcc__/fesm5/common.js");
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @angular/forms */ "./node_modules/@angular/forms/__ivy_ngcc__/fesm5/forms.js");
/* harmony import */ var _admin_layout_routing__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! ./admin-layout.routing */ "./src/app/layouts/admin-layout/admin-layout.routing.ts");
/* harmony import */ var _pages_dashboard_dashboard_component__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! ../../pages/dashboard/dashboard.component */ "./src/app/pages/dashboard/dashboard.component.ts");
/* harmony import */ var _pages_icons_icons_component__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! ../../pages/icons/icons.component */ "./src/app/pages/icons/icons.component.ts");
/* harmony import */ var _pages_map_map_component__WEBPACK_IMPORTED_MODULE_9__ = __webpack_require__(/*! ../../pages/map/map.component */ "./src/app/pages/map/map.component.ts");
/* harmony import */ var _pages_notifications_notifications_component__WEBPACK_IMPORTED_MODULE_10__ = __webpack_require__(/*! ../../pages/notifications/notifications.component */ "./src/app/pages/notifications/notifications.component.ts");
/* harmony import */ var _pages_user_user_component__WEBPACK_IMPORTED_MODULE_11__ = __webpack_require__(/*! ../../pages/user/user.component */ "./src/app/pages/user/user.component.ts");
/* harmony import */ var _pages_tables_tables_component__WEBPACK_IMPORTED_MODULE_12__ = __webpack_require__(/*! ../../pages/tables/tables.component */ "./src/app/pages/tables/tables.component.ts");
/* harmony import */ var _pages_typography_typography_component__WEBPACK_IMPORTED_MODULE_13__ = __webpack_require__(/*! ../../pages/typography/typography.component */ "./src/app/pages/typography/typography.component.ts");
/* harmony import */ var _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_14__ = __webpack_require__(/*! @ng-bootstrap/ng-bootstrap */ "./node_modules/@ng-bootstrap/ng-bootstrap/__ivy_ngcc__/fesm5/ng-bootstrap.js");














// import { RtlComponent } from "../../pages/rtl/rtl.component";

var AdminLayoutModule = /** @class */ (function () {
    function AdminLayoutModule() {
    }
    AdminLayoutModule = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["NgModule"])({
            imports: [
                _angular_common__WEBPACK_IMPORTED_MODULE_4__["CommonModule"],
                _angular_router__WEBPACK_IMPORTED_MODULE_3__["RouterModule"].forChild(_admin_layout_routing__WEBPACK_IMPORTED_MODULE_6__["AdminLayoutRoutes"]),
                _angular_forms__WEBPACK_IMPORTED_MODULE_5__["FormsModule"],
                _angular_common_http__WEBPACK_IMPORTED_MODULE_2__["HttpClientModule"],
                _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_14__["NgbModule"],
            ],
            declarations: [
                _pages_dashboard_dashboard_component__WEBPACK_IMPORTED_MODULE_7__["DashboardComponent"],
                _pages_user_user_component__WEBPACK_IMPORTED_MODULE_11__["UserComponent"],
                _pages_tables_tables_component__WEBPACK_IMPORTED_MODULE_12__["TablesComponent"],
                _pages_icons_icons_component__WEBPACK_IMPORTED_MODULE_8__["IconsComponent"],
                _pages_typography_typography_component__WEBPACK_IMPORTED_MODULE_13__["TypographyComponent"],
                _pages_notifications_notifications_component__WEBPACK_IMPORTED_MODULE_10__["NotificationsComponent"],
                _pages_map_map_component__WEBPACK_IMPORTED_MODULE_9__["MapComponent"],
            ]
        })
    ], AdminLayoutModule);
    return AdminLayoutModule;
}());



/***/ }),

/***/ "./src/app/layouts/admin-layout/admin-layout.routing.ts":
/*!**************************************************************!*\
  !*** ./src/app/layouts/admin-layout/admin-layout.routing.ts ***!
  \**************************************************************/
/*! exports provided: AdminLayoutRoutes */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "AdminLayoutRoutes", function() { return AdminLayoutRoutes; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "./node_modules/tslib/tslib.es6.js");
/* harmony import */ var _pages_dashboard_dashboard_component__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../pages/dashboard/dashboard.component */ "./src/app/pages/dashboard/dashboard.component.ts");
/* harmony import */ var _pages_icons_icons_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../pages/icons/icons.component */ "./src/app/pages/icons/icons.component.ts");
/* harmony import */ var _pages_map_map_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ../../pages/map/map.component */ "./src/app/pages/map/map.component.ts");
/* harmony import */ var _pages_notifications_notifications_component__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ../../pages/notifications/notifications.component */ "./src/app/pages/notifications/notifications.component.ts");
/* harmony import */ var _pages_user_user_component__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ../../pages/user/user.component */ "./src/app/pages/user/user.component.ts");
/* harmony import */ var _pages_tables_tables_component__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! ../../pages/tables/tables.component */ "./src/app/pages/tables/tables.component.ts");
/* harmony import */ var _pages_typography_typography_component__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! ../../pages/typography/typography.component */ "./src/app/pages/typography/typography.component.ts");








// import { RtlComponent } from "../../pages/rtl/rtl.component";
var AdminLayoutRoutes = [
    { path: "dashboard", component: _pages_dashboard_dashboard_component__WEBPACK_IMPORTED_MODULE_1__["DashboardComponent"] },
    { path: "icons", component: _pages_icons_icons_component__WEBPACK_IMPORTED_MODULE_2__["IconsComponent"] },
    { path: "maps", component: _pages_map_map_component__WEBPACK_IMPORTED_MODULE_3__["MapComponent"] },
    { path: "notifications", component: _pages_notifications_notifications_component__WEBPACK_IMPORTED_MODULE_4__["NotificationsComponent"] },
    { path: "user", component: _pages_user_user_component__WEBPACK_IMPORTED_MODULE_5__["UserComponent"] },
    { path: "tables", component: _pages_tables_tables_component__WEBPACK_IMPORTED_MODULE_6__["TablesComponent"] },
    { path: "typography", component: _pages_typography_typography_component__WEBPACK_IMPORTED_MODULE_7__["TypographyComponent"] },
];


/***/ }),

/***/ "./src/app/pages/dashboard/dashboard.component.ts":
/*!********************************************************!*\
  !*** ./src/app/pages/dashboard/dashboard.component.ts ***!
  \********************************************************/
/*! exports provided: DashboardComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "DashboardComponent", function() { return DashboardComponent; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "./node_modules/tslib/tslib.es6.js");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/__ivy_ngcc__/fesm5/core.js");
/* harmony import */ var chart_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! chart.js */ "./node_modules/chart.js/dist/Chart.js");
/* harmony import */ var chart_js__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(chart_js__WEBPACK_IMPORTED_MODULE_2__);



var DashboardComponent = /** @class */ (function () {
    function DashboardComponent() {
        this.clicked = true;
        this.clicked1 = false;
        this.clicked2 = false;
    }
    DashboardComponent.prototype.ngOnInit = function () {
        var gradientChartOptionsConfigurationWithTooltipBlue = {
            maintainAspectRatio: false,
            legend: {
                display: false
            },
            tooltips: {
                backgroundColor: '#f5f5f5',
                titleFontColor: '#333',
                bodyFontColor: '#666',
                bodySpacing: 4,
                xPadding: 12,
                mode: "nearest",
                intersect: 0,
                position: "nearest"
            },
            responsive: true,
            scales: {
                yAxes: [{
                        barPercentage: 1.6,
                        gridLines: {
                            drawBorder: false,
                            color: 'rgba(29,140,248,0.0)',
                            zeroLineColor: "transparent",
                        },
                        ticks: {
                            suggestedMin: 60,
                            suggestedMax: 125,
                            padding: 20,
                            fontColor: "#2380f7"
                        }
                    }],
                xAxes: [{
                        barPercentage: 1.6,
                        gridLines: {
                            drawBorder: false,
                            color: 'rgba(29,140,248,0.1)',
                            zeroLineColor: "transparent",
                        },
                        ticks: {
                            padding: 20,
                            fontColor: "#2380f7"
                        }
                    }]
            }
        };
        var gradientChartOptionsConfigurationWithTooltipPurple = {
            maintainAspectRatio: false,
            legend: {
                display: false
            },
            tooltips: {
                backgroundColor: '#f5f5f5',
                titleFontColor: '#333',
                bodyFontColor: '#666',
                bodySpacing: 4,
                xPadding: 12,
                mode: "nearest",
                intersect: 0,
                position: "nearest"
            },
            responsive: true,
            scales: {
                yAxes: [{
                        barPercentage: 1.6,
                        gridLines: {
                            drawBorder: false,
                            color: 'rgba(29,140,248,0.0)',
                            zeroLineColor: "transparent",
                        },
                        ticks: {
                            suggestedMin: 60,
                            suggestedMax: 125,
                            padding: 20,
                            fontColor: "#9a9a9a"
                        }
                    }],
                xAxes: [{
                        barPercentage: 1.6,
                        gridLines: {
                            drawBorder: false,
                            color: 'rgba(225,78,202,0.1)',
                            zeroLineColor: "transparent",
                        },
                        ticks: {
                            padding: 20,
                            fontColor: "#9a9a9a"
                        }
                    }]
            }
        };
        var gradientChartOptionsConfigurationWithTooltipRed = {
            maintainAspectRatio: false,
            legend: {
                display: false
            },
            tooltips: {
                backgroundColor: '#f5f5f5',
                titleFontColor: '#333',
                bodyFontColor: '#666',
                bodySpacing: 4,
                xPadding: 12,
                mode: "nearest",
                intersect: 0,
                position: "nearest"
            },
            responsive: true,
            scales: {
                yAxes: [{
                        barPercentage: 1.6,
                        gridLines: {
                            drawBorder: false,
                            color: 'rgba(29,140,248,0.0)',
                            zeroLineColor: "transparent",
                        },
                        ticks: {
                            suggestedMin: 60,
                            suggestedMax: 125,
                            padding: 20,
                            fontColor: "#9a9a9a"
                        }
                    }],
                xAxes: [{
                        barPercentage: 1.6,
                        gridLines: {
                            drawBorder: false,
                            color: 'rgba(233,32,16,0.1)',
                            zeroLineColor: "transparent",
                        },
                        ticks: {
                            padding: 20,
                            fontColor: "#9a9a9a"
                        }
                    }]
            }
        };
        var gradientChartOptionsConfigurationWithTooltipOrange = {
            maintainAspectRatio: false,
            legend: {
                display: false
            },
            tooltips: {
                backgroundColor: '#f5f5f5',
                titleFontColor: '#333',
                bodyFontColor: '#666',
                bodySpacing: 4,
                xPadding: 12,
                mode: "nearest",
                intersect: 0,
                position: "nearest"
            },
            responsive: true,
            scales: {
                yAxes: [{
                        barPercentage: 1.6,
                        gridLines: {
                            drawBorder: false,
                            color: 'rgba(29,140,248,0.0)',
                            zeroLineColor: "transparent",
                        },
                        ticks: {
                            suggestedMin: 50,
                            suggestedMax: 110,
                            padding: 20,
                            fontColor: "#ff8a76"
                        }
                    }],
                xAxes: [{
                        barPercentage: 1.6,
                        gridLines: {
                            drawBorder: false,
                            color: 'rgba(220,53,69,0.1)',
                            zeroLineColor: "transparent",
                        },
                        ticks: {
                            padding: 20,
                            fontColor: "#ff8a76"
                        }
                    }]
            }
        };
        var gradientChartOptionsConfigurationWithTooltipGreen = {
            maintainAspectRatio: false,
            legend: {
                display: false
            },
            tooltips: {
                backgroundColor: '#f5f5f5',
                titleFontColor: '#333',
                bodyFontColor: '#666',
                bodySpacing: 4,
                xPadding: 12,
                mode: "nearest",
                intersect: 0,
                position: "nearest"
            },
            responsive: true,
            scales: {
                yAxes: [{
                        barPercentage: 1.6,
                        gridLines: {
                            drawBorder: false,
                            color: 'rgba(29,140,248,0.0)',
                            zeroLineColor: "transparent",
                        },
                        ticks: {
                            suggestedMin: 50,
                            suggestedMax: 125,
                            padding: 20,
                            fontColor: "#9e9e9e"
                        }
                    }],
                xAxes: [{
                        barPercentage: 1.6,
                        gridLines: {
                            drawBorder: false,
                            color: 'rgba(0,242,195,0.1)',
                            zeroLineColor: "transparent",
                        },
                        ticks: {
                            padding: 20,
                            fontColor: "#9e9e9e"
                        }
                    }]
            }
        };
        var gradientBarChartConfiguration = {
            maintainAspectRatio: false,
            legend: {
                display: false
            },
            tooltips: {
                backgroundColor: '#f5f5f5',
                titleFontColor: '#333',
                bodyFontColor: '#666',
                bodySpacing: 4,
                xPadding: 12,
                mode: "nearest",
                intersect: 0,
                position: "nearest"
            },
            responsive: true,
            scales: {
                yAxes: [{
                        gridLines: {
                            drawBorder: false,
                            color: 'rgba(29,140,248,0.1)',
                            zeroLineColor: "transparent",
                        },
                        ticks: {
                            suggestedMin: 60,
                            suggestedMax: 120,
                            padding: 20,
                            fontColor: "#9e9e9e"
                        }
                    }],
                xAxes: [{
                        gridLines: {
                            drawBorder: false,
                            color: 'rgba(29,140,248,0.1)',
                            zeroLineColor: "transparent",
                        },
                        ticks: {
                            padding: 20,
                            fontColor: "#9e9e9e"
                        }
                    }]
            }
        };
        this.canvas = document.getElementById("chartLineRed");
        this.ctx = this.canvas.getContext("2d");
        var gradientStroke = this.ctx.createLinearGradient(0, 230, 0, 50);
        gradientStroke.addColorStop(1, 'rgba(233,32,16,0.2)');
        gradientStroke.addColorStop(0.4, 'rgba(233,32,16,0.0)');
        gradientStroke.addColorStop(0, 'rgba(233,32,16,0)'); //red colors
        var data = {
            labels: ['JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'],
            datasets: [{
                    label: "Data",
                    fill: true,
                    backgroundColor: gradientStroke,
                    borderColor: '#ec250d',
                    borderWidth: 2,
                    borderDash: [],
                    borderDashOffset: 0.0,
                    pointBackgroundColor: '#ec250d',
                    pointBorderColor: 'rgba(255,255,255,0)',
                    pointHoverBackgroundColor: '#ec250d',
                    pointBorderWidth: 20,
                    pointHoverRadius: 4,
                    pointHoverBorderWidth: 15,
                    pointRadius: 4,
                    data: [80, 100, 70, 80, 120, 80],
                }]
        };
        var myChart = new chart_js__WEBPACK_IMPORTED_MODULE_2___default.a(this.ctx, {
            type: 'line',
            data: data,
            options: gradientChartOptionsConfigurationWithTooltipRed
        });
        this.canvas = document.getElementById("chartLineGreen");
        this.ctx = this.canvas.getContext("2d");
        var gradientStroke = this.ctx.createLinearGradient(0, 230, 0, 50);
        gradientStroke.addColorStop(1, 'rgba(66,134,121,0.15)');
        gradientStroke.addColorStop(0.4, 'rgba(66,134,121,0.0)'); //green colors
        gradientStroke.addColorStop(0, 'rgba(66,134,121,0)'); //green colors
        var data = {
            labels: ['JUL', 'AUG', 'SEP', 'OCT', 'NOV'],
            datasets: [{
                    label: "My First dataset",
                    fill: true,
                    backgroundColor: gradientStroke,
                    borderColor: '#00d6b4',
                    borderWidth: 2,
                    borderDash: [],
                    borderDashOffset: 0.0,
                    pointBackgroundColor: '#00d6b4',
                    pointBorderColor: 'rgba(255,255,255,0)',
                    pointHoverBackgroundColor: '#00d6b4',
                    pointBorderWidth: 20,
                    pointHoverRadius: 4,
                    pointHoverBorderWidth: 15,
                    pointRadius: 4,
                    data: [90, 27, 60, 12, 80],
                }]
        };
        var myChart = new chart_js__WEBPACK_IMPORTED_MODULE_2___default.a(this.ctx, {
            type: 'line',
            data: data,
            options: gradientChartOptionsConfigurationWithTooltipGreen
        });
        var chart_labels = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
        this.datasets = [
            [100, 70, 90, 70, 85, 60, 75, 60, 90, 80, 110, 100],
            [80, 120, 105, 110, 95, 105, 90, 100, 80, 95, 70, 120],
            [60, 80, 65, 130, 80, 105, 90, 130, 70, 115, 60, 130]
        ];
        this.data = this.datasets[0];
        this.canvas = document.getElementById("chartBig1");
        this.ctx = this.canvas.getContext("2d");
        var gradientStroke = this.ctx.createLinearGradient(0, 230, 0, 50);
        gradientStroke.addColorStop(1, 'rgba(233,32,16,0.2)');
        gradientStroke.addColorStop(0.4, 'rgba(233,32,16,0.0)');
        gradientStroke.addColorStop(0, 'rgba(233,32,16,0)'); //red colors
        var config = {
            type: 'line',
            data: {
                labels: chart_labels,
                datasets: [{
                        label: "My First dataset",
                        fill: true,
                        backgroundColor: gradientStroke,
                        borderColor: '#ec250d',
                        borderWidth: 2,
                        borderDash: [],
                        borderDashOffset: 0.0,
                        pointBackgroundColor: '#ec250d',
                        pointBorderColor: 'rgba(255,255,255,0)',
                        pointHoverBackgroundColor: '#ec250d',
                        pointBorderWidth: 20,
                        pointHoverRadius: 4,
                        pointHoverBorderWidth: 15,
                        pointRadius: 4,
                        data: this.data,
                    }]
            },
            options: gradientChartOptionsConfigurationWithTooltipRed
        };
        this.myChartData = new chart_js__WEBPACK_IMPORTED_MODULE_2___default.a(this.ctx, config);
        this.canvas = document.getElementById("CountryChart");
        this.ctx = this.canvas.getContext("2d");
        var gradientStroke = this.ctx.createLinearGradient(0, 230, 0, 50);
        gradientStroke.addColorStop(1, 'rgba(29,140,248,0.2)');
        gradientStroke.addColorStop(0.4, 'rgba(29,140,248,0.0)');
        gradientStroke.addColorStop(0, 'rgba(29,140,248,0)'); //blue colors
        var myChart = new chart_js__WEBPACK_IMPORTED_MODULE_2___default.a(this.ctx, {
            type: 'bar',
            responsive: true,
            legend: {
                display: false
            },
            data: {
                labels: ['USA', 'GER', 'AUS', 'UK', 'RO', 'BR'],
                datasets: [{
                        label: "Countries",
                        fill: true,
                        backgroundColor: gradientStroke,
                        hoverBackgroundColor: gradientStroke,
                        borderColor: '#1f8ef1',
                        borderWidth: 2,
                        borderDash: [],
                        borderDashOffset: 0.0,
                        data: [53, 20, 10, 80, 100, 45],
                    }]
            },
            options: gradientBarChartConfiguration
        });
    };
    DashboardComponent.prototype.updateOptions = function () {
        this.myChartData.data.datasets[0].data = this.data;
        this.myChartData.update();
    };
    DashboardComponent = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["Component"])({
            selector: "app-dashboard",
            template: Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__importDefault"])(__webpack_require__(/*! raw-loader!./dashboard.component.html */ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/dashboard/dashboard.component.html")).default
        }),
        Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [])
    ], DashboardComponent);
    return DashboardComponent;
}());



/***/ }),

/***/ "./src/app/pages/icons/icons.component.ts":
/*!************************************************!*\
  !*** ./src/app/pages/icons/icons.component.ts ***!
  \************************************************/
/*! exports provided: IconsComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "IconsComponent", function() { return IconsComponent; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "./node_modules/tslib/tslib.es6.js");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/__ivy_ngcc__/fesm5/core.js");


var IconsComponent = /** @class */ (function () {
    function IconsComponent() {
    }
    IconsComponent.prototype.ngOnInit = function () { };
    IconsComponent = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["Component"])({
            selector: "app-icons",
            template: Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__importDefault"])(__webpack_require__(/*! raw-loader!./icons.component.html */ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/icons/icons.component.html")).default
        }),
        Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [])
    ], IconsComponent);
    return IconsComponent;
}());



/***/ }),

/***/ "./src/app/pages/map/map.component.ts":
/*!********************************************!*\
  !*** ./src/app/pages/map/map.component.ts ***!
  \********************************************/
/*! exports provided: MapComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "MapComponent", function() { return MapComponent; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "./node_modules/tslib/tslib.es6.js");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/__ivy_ngcc__/fesm5/core.js");


var MapComponent = /** @class */ (function () {
    function MapComponent() {
    }
    MapComponent.prototype.ngOnInit = function () {
        var myLatlng = new google.maps.LatLng(40.748817, -73.985428);
        var mapOptions = {
            zoom: 13,
            center: myLatlng,
            scrollwheel: false,
            styles: [{
                    "elementType": "geometry",
                    "stylers": [{
                            "color": "#1d2c4d"
                        }]
                },
                {
                    "elementType": "labels.text.fill",
                    "stylers": [{
                            "color": "#8ec3b9"
                        }]
                },
                {
                    "elementType": "labels.text.stroke",
                    "stylers": [{
                            "color": "#1a3646"
                        }]
                },
                {
                    "featureType": "administrative.country",
                    "elementType": "geometry.stroke",
                    "stylers": [{
                            "color": "#4b6878"
                        }]
                },
                {
                    "featureType": "administrative.land_parcel",
                    "elementType": "labels.text.fill",
                    "stylers": [{
                            "color": "#64779e"
                        }]
                },
                {
                    "featureType": "administrative.province",
                    "elementType": "geometry.stroke",
                    "stylers": [{
                            "color": "#4b6878"
                        }]
                },
                {
                    "featureType": "landscape.man_made",
                    "elementType": "geometry.stroke",
                    "stylers": [{
                            "color": "#334e87"
                        }]
                },
                {
                    "featureType": "landscape.natural",
                    "elementType": "geometry",
                    "stylers": [{
                            "color": "#023e58"
                        }]
                },
                {
                    "featureType": "poi",
                    "elementType": "geometry",
                    "stylers": [{
                            "color": "#283d6a"
                        }]
                },
                {
                    "featureType": "poi",
                    "elementType": "labels.text.fill",
                    "stylers": [{
                            "color": "#6f9ba5"
                        }]
                },
                {
                    "featureType": "poi",
                    "elementType": "labels.text.stroke",
                    "stylers": [{
                            "color": "#1d2c4d"
                        }]
                },
                {
                    "featureType": "poi.park",
                    "elementType": "geometry.fill",
                    "stylers": [{
                            "color": "#023e58"
                        }]
                },
                {
                    "featureType": "poi.park",
                    "elementType": "labels.text.fill",
                    "stylers": [{
                            "color": "#3C7680"
                        }]
                },
                {
                    "featureType": "road",
                    "elementType": "geometry",
                    "stylers": [{
                            "color": "#304a7d"
                        }]
                },
                {
                    "featureType": "road",
                    "elementType": "labels.text.fill",
                    "stylers": [{
                            "color": "#98a5be"
                        }]
                },
                {
                    "featureType": "road",
                    "elementType": "labels.text.stroke",
                    "stylers": [{
                            "color": "#1d2c4d"
                        }]
                },
                {
                    "featureType": "road.highway",
                    "elementType": "geometry",
                    "stylers": [{
                            "color": "#2c6675"
                        }]
                },
                {
                    "featureType": "road.highway",
                    "elementType": "geometry.fill",
                    "stylers": [{
                            "color": "#9d2a80"
                        }]
                },
                {
                    "featureType": "road.highway",
                    "elementType": "geometry.stroke",
                    "stylers": [{
                            "color": "#9d2a80"
                        }]
                },
                {
                    "featureType": "road.highway",
                    "elementType": "labels.text.fill",
                    "stylers": [{
                            "color": "#b0d5ce"
                        }]
                },
                {
                    "featureType": "road.highway",
                    "elementType": "labels.text.stroke",
                    "stylers": [{
                            "color": "#023e58"
                        }]
                },
                {
                    "featureType": "transit",
                    "elementType": "labels.text.fill",
                    "stylers": [{
                            "color": "#98a5be"
                        }]
                },
                {
                    "featureType": "transit",
                    "elementType": "labels.text.stroke",
                    "stylers": [{
                            "color": "#1d2c4d"
                        }]
                },
                {
                    "featureType": "transit.line",
                    "elementType": "geometry.fill",
                    "stylers": [{
                            "color": "#283d6a"
                        }]
                },
                {
                    "featureType": "transit.station",
                    "elementType": "geometry",
                    "stylers": [{
                            "color": "#3a4762"
                        }]
                },
                {
                    "featureType": "water",
                    "elementType": "geometry",
                    "stylers": [{
                            "color": "#0e1626"
                        }]
                },
                {
                    "featureType": "water",
                    "elementType": "labels.text.fill",
                    "stylers": [{
                            "color": "#4e6d70"
                        }]
                }
            ]
        };
        var map = new google.maps.Map(document.getElementById("map"), mapOptions);
        var marker = new google.maps.Marker({
            position: myLatlng,
            title: "Hello World!"
        });
        // To add the marker to the map, call setMap();
        marker.setMap(map);
    };
    MapComponent = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["Component"])({
            selector: "app-map",
            template: Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__importDefault"])(__webpack_require__(/*! raw-loader!./map.component.html */ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/map/map.component.html")).default
        }),
        Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [])
    ], MapComponent);
    return MapComponent;
}());



/***/ }),

/***/ "./src/app/pages/notifications/notifications.component.ts":
/*!****************************************************************!*\
  !*** ./src/app/pages/notifications/notifications.component.ts ***!
  \****************************************************************/
/*! exports provided: NotificationsComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "NotificationsComponent", function() { return NotificationsComponent; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "./node_modules/tslib/tslib.es6.js");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/__ivy_ngcc__/fesm5/core.js");
/* harmony import */ var ngx_toastr__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ngx-toastr */ "./node_modules/ngx-toastr/__ivy_ngcc__/fesm5/ngx-toastr.js");



var NotificationsComponent = /** @class */ (function () {
    function NotificationsComponent(toastr) {
        this.toastr = toastr;
        this.staticAlertClosed = false;
        this.staticAlertClosed1 = false;
        this.staticAlertClosed2 = false;
        this.staticAlertClosed3 = false;
        this.staticAlertClosed4 = false;
        this.staticAlertClosed5 = false;
        this.staticAlertClosed6 = false;
        this.staticAlertClosed7 = false;
    }
    NotificationsComponent.prototype.showNotification = function (from, align) {
        var color = Math.floor((Math.random() * 5) + 1);
        switch (color) {
            case 1:
                this.toastr.info('<span class="tim-icons icon-bell-55" [data-notify]="icon"></span> Welcome to <b>Black Dashboard Angular</b> - a beautiful freebie for every web developer.', '', {
                    disableTimeOut: true,
                    closeButton: true,
                    enableHtml: true,
                    toastClass: "alert alert-info alert-with-icon",
                    positionClass: 'toast-' + from + '-' + align
                });
                break;
            case 2:
                this.toastr.success('<span class="tim-icons icon-bell-55" [data-notify]="icon"></span> Welcome to <b>Black Dashboard Angular</b> - a beautiful freebie for every web developer.', '', {
                    disableTimeOut: true,
                    closeButton: true,
                    enableHtml: true,
                    toastClass: "alert alert-success alert-with-icon",
                    positionClass: 'toast-' + from + '-' + align
                });
                break;
            case 3:
                this.toastr.warning('<span class="tim-icons icon-bell-55" [data-notify]="icon"></span> Welcome to <b>Black Dashboard Angular</b> - a beautiful freebie for every web developer.', '', {
                    disableTimeOut: true,
                    closeButton: true,
                    enableHtml: true,
                    toastClass: "alert alert-warning alert-with-icon",
                    positionClass: 'toast-' + from + '-' + align
                });
                break;
            case 4:
                this.toastr.error('<span class="tim-icons icon-bell-55" [data-notify]="icon"></span> Welcome to <b>Black Dashboard Angular</b> - a beautiful freebie for every web developer.', '', {
                    disableTimeOut: true,
                    enableHtml: true,
                    closeButton: true,
                    toastClass: "alert alert-danger alert-with-icon",
                    positionClass: 'toast-' + from + '-' + align
                });
                break;
            case 5:
                this.toastr.show('<span class="tim-icons icon-bell-55" [data-notify]="icon"></span> Welcome to <b>Black Dashboard Angular</b> - a beautiful freebie for every web developer.', '', {
                    disableTimeOut: true,
                    closeButton: true,
                    enableHtml: true,
                    toastClass: "alert alert-primary alert-with-icon",
                    positionClass: 'toast-' + from + '-' + align
                });
                break;
            default:
                break;
        }
    };
    NotificationsComponent.prototype.ngOnInit = function () { };
    NotificationsComponent.ctorParameters = function () { return [
        { type: ngx_toastr__WEBPACK_IMPORTED_MODULE_2__["ToastrService"] }
    ]; };
    NotificationsComponent = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["Component"])({
            selector: "app-notifications",
            template: Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__importDefault"])(__webpack_require__(/*! raw-loader!./notifications.component.html */ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/notifications/notifications.component.html")).default
        }),
        Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [ngx_toastr__WEBPACK_IMPORTED_MODULE_2__["ToastrService"]])
    ], NotificationsComponent);
    return NotificationsComponent;
}());



/***/ }),

/***/ "./src/app/pages/tables/tables.component.ts":
/*!**************************************************!*\
  !*** ./src/app/pages/tables/tables.component.ts ***!
  \**************************************************/
/*! exports provided: TablesComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "TablesComponent", function() { return TablesComponent; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "./node_modules/tslib/tslib.es6.js");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/__ivy_ngcc__/fesm5/core.js");


var TablesComponent = /** @class */ (function () {
    function TablesComponent() {
    }
    TablesComponent.prototype.ngOnInit = function () { };
    TablesComponent = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["Component"])({
            selector: "app-tables",
            template: Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__importDefault"])(__webpack_require__(/*! raw-loader!./tables.component.html */ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/tables/tables.component.html")).default
        }),
        Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [])
    ], TablesComponent);
    return TablesComponent;
}());



/***/ }),

/***/ "./src/app/pages/typography/typography.component.ts":
/*!**********************************************************!*\
  !*** ./src/app/pages/typography/typography.component.ts ***!
  \**********************************************************/
/*! exports provided: TypographyComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "TypographyComponent", function() { return TypographyComponent; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "./node_modules/tslib/tslib.es6.js");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/__ivy_ngcc__/fesm5/core.js");


var TypographyComponent = /** @class */ (function () {
    function TypographyComponent() {
    }
    TypographyComponent.prototype.ngOnInit = function () { };
    TypographyComponent = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["Component"])({
            selector: "app-typography",
            template: Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__importDefault"])(__webpack_require__(/*! raw-loader!./typography.component.html */ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/typography/typography.component.html")).default
        }),
        Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [])
    ], TypographyComponent);
    return TypographyComponent;
}());



/***/ }),

/***/ "./src/app/pages/user/user.component.ts":
/*!**********************************************!*\
  !*** ./src/app/pages/user/user.component.ts ***!
  \**********************************************/
/*! exports provided: UserComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "UserComponent", function() { return UserComponent; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "./node_modules/tslib/tslib.es6.js");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/__ivy_ngcc__/fesm5/core.js");


var UserComponent = /** @class */ (function () {
    function UserComponent() {
    }
    UserComponent.prototype.ngOnInit = function () { };
    UserComponent = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
        Object(_angular_core__WEBPACK_IMPORTED_MODULE_1__["Component"])({
            selector: "app-user",
            template: Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__importDefault"])(__webpack_require__(/*! raw-loader!./user.component.html */ "./node_modules/raw-loader/dist/cjs.js!./src/app/pages/user/user.component.html")).default
        }),
        Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__metadata"])("design:paramtypes", [])
    ], UserComponent);
    return UserComponent;
}());



/***/ })

}]);
//# sourceMappingURL=layouts-admin-layout-admin-layout-module.js.map