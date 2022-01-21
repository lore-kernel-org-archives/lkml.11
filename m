Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03E9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jan 2022 08:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379399AbiAUIOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jan 2022 03:14:08 -0500
Received: from mx1.cqplus1.com ([113.204.237.245]:56398 "EHLO mx1.cqplus1.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349312AbiAUIOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:14:06 -0500
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(24953:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 21 Jan 2022 16:12:08 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 21 Jan 2022 16:12:16 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Fri, 21 Jan 2022 16:12:16 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v8 05/10] dt-bindings: clock: Add bindings for SP7021
 clock driver
Thread-Topic: [PATCH v8 05/10] dt-bindings: clock: Add bindings for SP7021
 clock driver
Thread-Index: AQHYDpzAjD1mpaSE106CHAXS2FP9QKxtHzbQ
Date:   Fri, 21 Jan 2022 08:12:16 +0000
Message-ID: <d9af9a9e14aa4718b38047adaa9bc30b@cqplus1.com>
References: <cover.1642751015.git.qinjian@cqplus1.com>
 <504303c7cf92af8368dcda0cdde3b9c15a833418.1642751015.git.qinjian@cqplus1.com>
In-Reply-To: <504303c7cf92af8368dcda0cdde3b9c15a833418.1642751015.git.qinjian@cqplus1.com>
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

PiBBZGQgZG9jdW1lbnRhdGlvbiB0byBkZXNjcmliZSBTdW5wbHVzIFNQNzAyMSBjbG9jayBkcml2
ZXIgYmluZGluZ3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBRaW4gSmlhbiA8cWluamlhbkBjcXBs
dXMxLmNvbT4NCj4gLS0tDQo+IEFkZCBjbG9ja3MgJiBjbG9jay1uYW1lcy4NCj4gLS0tDQoNClNv
cnJ5LCBmb3Jnb3QgdXBkYXRlIHRoZSBzdGF0dXMgb2YgdGhpcyBwYXRjaA0KDQpSZXZpZXdlZC1i
eTogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPg0KUmV2aWV3ZWQtYnk6IFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+DQoNCg==
