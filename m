Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65EEC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 07:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbiDNHLJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 03:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiDNHLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:11:06 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A46BE4B86E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:08:18 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(1174:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Thu, 14 Apr 2022 15:05:15 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 14 Apr 2022 15:06:12 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Thu, 14 Apr 2022 15:06:12 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v13 4/9] dt-bindings: clock: Add bindings for SP7021 clock
 driver
Thread-Topic: [PATCH v13 4/9] dt-bindings: clock: Add bindings for SP7021
 clock driver
Thread-Index: AQHYTXFtZBGBuhiVAkyYeiqgxa8/hazs4N6AgAIgI/A=
Date:   Thu, 14 Apr 2022 07:06:12 +0000
Message-ID: <b1b85440f7d647a0adf014b091e31c10@cqplus1.com>
References: <cover.1649659095.git.qinjian@cqplus1.com>
 <f8d5675d1bc32962af6379f78a171ed35b181ebc.1649659095.git.qinjian@cqplus1.com>
 <c2a7f2e0-1a21-bb0c-9221-c184cfaa3626@linaro.org>
In-Reply-To: <c2a7f2e0-1a21-bb0c-9221-c184cfaa3626@linaro.org>
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

DQo+ID4gKyNpZm5kZWYgX0RUX0JJTkRJTkdTX0NMT0NLX1NVTlBMVVNfU1A3MDIxX0gNCj4gPiAr
I2RlZmluZSBfRFRfQklORElOR1NfQ0xPQ0tfU1VOUExVU19TUDcwMjFfSA0KPiA+ICsNCj4gPiAr
I2RlZmluZSBYVEFMICAgICAgICAgICAgMjcwMDAwMDANCj4gDQo+IFRoaXMgbG9va3MgbGlrZSBm
cmVxdWVuY3kgd2hpY2ggdXN1YWxseSBkb2VzIG5vdCBiZWxvbmcgdG8gYmluZGluZ3MuIFdoeQ0K
PiBkbyB5b3UgbmVlZCBpdCBoZXJlPw0KPiANCg0KT0ssIEknbGwgcmVtb3ZlIGl0Lg0K
