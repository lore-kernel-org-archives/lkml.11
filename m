Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10509C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 08:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiCWIsV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 04:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiCWIsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:48:20 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE0CB6E4EB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:46:42 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(7828:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Wed, 23 Mar 2022 16:44:09 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 23 Mar 2022 16:44:39 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Wed, 23 Mar 2022 16:44:39 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
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
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v11 2/9] dt-bindings: reset: Add bindings for SP7021 reset
 driver
Thread-Topic: [PATCH v11 2/9] dt-bindings: reset: Add bindings for SP7021
 reset driver
Thread-Index: AQHYPbVznEjGDkREfkyqc2C0ll94iqzKt7sAgAF7uwD//+1fAIAAh2Tg
Date:   Wed, 23 Mar 2022 08:44:39 +0000
Message-ID: <ab6f62e8995f4b3485c971b49e0ef8b4@cqplus1.com>
References: <cover.1647928315.git.qinjian@cqplus1.com>
 <55db801055793f43678e902395913330ecb8fbbf.1647928316.git.qinjian@cqplus1.com>
 <a7194fbf-8423-9b49-1443-68dd33e23783@kernel.org>
 <678d1f84d9d240b9983f9d3b82db17d4@cqplus1.com>
 <6dbeda18-a11c-609d-7a8f-bf2e6f27aea7@kernel.org>
In-Reply-To: <6dbeda18-a11c-609d-7a8f-bf2e6f27aea7@kernel.org>
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

PiBZb3UgbW92ZWQgbm93IGNvbXBhdGlibGUgc28gbm90LiBGaXJzdCBnb2VzIGNvbXBhdGlibGUs
IHRoZW4gZ29lcyByZWcuDQo+IA0KPiBjbG9jay1jb250cm9sbGVyQC4uLi4gew0KPiAgIGNvbXBh
dGlibGUgPSAuLi4uOw0KPiAgIHJlZyA9IC4uLjsNCj4gICBoZXJlIGdvZXMgdGhlIHJlc3Q7DQo+
IH0NCj4gDQo+IE15IHJldmlldyB0YWcgd2FzIGNvbmRpdGlvbmFsIGJlY2F1c2UgSSBhc2tlZCB0
byBjaGFuZ2UgdGhlIGNvZGUuIFN1Y2gNCj4gcmV2aWV3IHRhZyBzaG91bGQgYmUgdXNlZCBieSB5
b3UgaWYgeW91IGltcGxlbWVudCB3aGF0IEkgYXNrZWQgZm9yLg0KPiANCg0KVGhhbmtzIGZvciB5
b3VyIHBhdGllbnQsIEknbGwgZml4ZWQgaXQgaW4gbmV4dCBwYXRjaC4NCg==
