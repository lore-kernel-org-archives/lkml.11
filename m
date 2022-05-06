Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7983C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 May 2022 02:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388295AbiEFCUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 22:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355450AbiEFCUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 22:20:15 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE6FF5FF1A
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 19:16:10 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(24036:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 06 May 2022 10:11:01 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Fri, 6 May 2022 10:10:59 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2507.006; Fri, 6 May 2022 10:10:59 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Rob Herring <robh@kernel.org>
CC:     "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: arm: sunplus: Add bindings for Sunplus
 SP7021 SoC boards
Thread-Topic: [PATCH] dt-bindings: arm: sunplus: Add bindings for Sunplus
 SP7021 SoC boards
Thread-Index: AQHYYEvJxSJNIGo0mkK2E3PzgUGrA60QWceAgADB+hA=
Date:   Fri, 6 May 2022 02:10:59 +0000
Message-ID: <cb39f05e5f904360b1f88560252e7506@cqplus1.com>
References: <20220505064430.124657-1-qinjian@cqplus1.com>
 <YnRQ4ya2trphqQuo@robh.at.kernel.org>
In-Reply-To: <YnRQ4ya2trphqQuo@robh.at.kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.110.18]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIHJlcGx5LCBJJ2xsIGtlZXAgdXBkYXRpbmcgdGhlIG9yaWdpbmFsIHBh
dGNoIHNlcmllcy4NClBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaC4NCg0KDQpCZXN0IHJlZ2FyZHMs
DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQropoPlgaUg
UWluSmlhbg0KU3VuTWVkaWEgVGVjaG5vbG9neShDaGVuZ2R1KUNvLixMdGQNCuWHjOmYs+aIkOiK
r+enkeaKgO+8iOaIkOmDve+8ieaciemZkOWFrOWPuA0KVGVsOjg2LTI4LTg3ODQ4Njg4IEVYVCA1
NDc2DQpGYXg6ODYtMjgtODc4NDg2ODYNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgTWF5IDYsIDIw
MjIgNjozNCBBTQ0KPiBUbzogcWluamlhblvopoPlgaVdIDxxaW5qaWFuQGNxcGx1czEuY29tPg0K
PiBDYzoga3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGR0LWJpbmRpbmdzOiBh
cm06IHN1bnBsdXM6IEFkZCBiaW5kaW5ncyBmb3IgU3VucGx1cyBTUDcwMjEgU29DIGJvYXJkcw0K
PiANCj4gT24gVGh1LCBNYXkgMDUsIDIwMjIgYXQgMDI6NDQ6MzBQTSArMDgwMCwgUWluIEppYW4g
d3JvdGU6DQo+ID4gVGhpcyBpbnRyb2R1Y2VzIGJpbmRpbmdzIGZvciBib2FyZHMgYmFzZWQgU3Vu
cGx1cyBTUDcwMjEgU29DLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBpcyBzZXBhcmF0ZWQgZnJvbSB0
aGUgcGF0Y2ggc2VyaWVzOg0KPiA+IEFkZCBTdW5wbHVzIFNQNzAyMSBTb0MgU3VwcG9ydC4gWzFd
DQo+ID4gVG8gc2ltcGx5IHRoaW5nLCBJIGV4dHJhY3QgaXQgZnJvbSB0aGUgb3JpZ2luYWwgYW5k
IHJlc2VuZCB0aGlzIHBhdGNoLg0KPiANCj4gVGhpcyBpbmZvcm1hdGlvbiBkb2Vzbid0IGJlbG9u
ZyBpbiB0aGUgY29tbWl0IG1zZy4gWW91IHNob3VsZCBwdXQNCj4gY29udGV4dCBsaWtlIHRoaXMg
YmVsb3cgdGhlICctLS0nLg0KPiANCj4gV2hvIHN1Z2dlc3RlZCBzcGxpdHRpbmcgdGhpcyBvdXQ/
IE5vcm1hbGx5LCBuZXcgU29DIGZhbWlsaWVzIHNlcmllcyBhcmUNCj4gYXBwbGllZCBhcyBhIHdo
b2xlIGJ5IHRoZSBTb0MgbWFpbnRhaW5lcnMgKEFybmQvT2xvZikuDQo+IA0KPiBSb2INCg==
