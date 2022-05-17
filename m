Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816B4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 09:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245061AbiEQJjq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 05:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244935AbiEQJjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:39:42 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C41B46659
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:39:17 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(11175:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Tue, 17 May 2022 17:37:45 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Tue, 17 May 2022 17:37:37 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2507.006; Tue, 17 May 2022 17:37:37 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
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
Subject: RE: [PATCH v15 04/10] dt-bindings: clock: Add bindings for SP7021
 clock driver
Thread-Topic: [PATCH v15 04/10] dt-bindings: clock: Add bindings for SP7021
 clock driver
Thread-Index: AQHYZcsP5QfLdHxDWUuwmqTXvmezs60h11EAgAD/DuA=
Date:   Tue, 17 May 2022 09:37:37 +0000
Message-ID: <79e5886ab80840d6b4b6bc48be01d29e@cqplus1.com>
References: <cover.1652329411.git.qinjian@cqplus1.com>
 <b5ca5d417be079a2a40a6e79ac1b246b6359a49e.1652329411.git.qinjian@cqplus1.com>
 <20220517021918.7190EC385AA@smtp.kernel.org>
In-Reply-To: <20220517021918.7190EC385AA@smtp.kernel.org>
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

PiA+ICsgICAgY2xrYzogY2xvY2stY29udHJvbGxlckA5YzAwMDAwMCB7DQo+ID4gKyAgICAgIGNv
bXBhdGlibGUgPSAic3VucGx1cyxzcDcwMjEtY2xrYyI7DQo+ID4gKyAgICAgIHJlZyA9IDwweDlj
MDAwMDAwIDB4MjgwPjsNCj4gDQo+IFRoZSBxdWVzdGlvbiBpcyB3aGF0IG90aGVyIGRldmljZSBj
b21wYXRpYmxlIGlzIGluIGhlcmU/IFRoZSByZXNldA0KPiBjb250cm9sbGVyPw0KPiANCg0KVGhp
cyByZWcgcmVnaW9uIGNvbmZsaWN0IHdpdGggcmVzZXQvcGlubXV4L3VzYmMvdXBoeSBkcml2ZXJz
Lg0KVG8gdXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSwNCkkgbXVzdCBzcGxpdCB1
cCB0aGUgb3JpZ2luIDEgcmVnaW9uIGludG8gNCBzbWFsbCBwaWVjZXMsDQphbmQgY2FsbCBkZXZt
X3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UoKSA0IHRpbWVzLg0KRGlkIEkgc2hvdWxkIGZvbGxv
dyB0aGlzIHdheT8NCg0K
