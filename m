Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE22C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 02:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241387AbiCWCqP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 22:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240812AbiCWCqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:46:11 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EAA36F4BE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 19:44:33 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(7832:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Wed, 23 Mar 2022 10:40:26 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 23 Mar 2022 10:40:52 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Wed, 23 Mar 2022 10:40:52 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Subject: RE: [PATCH v11 0/9] Add Sunplus SP7021 SoC Support
Thread-Topic: [PATCH v11 0/9] Add Sunplus SP7021 SoC Support
Thread-Index: AQHYPbV1SsKXsmp1VUKTEITYbA9OsKzKtY4AgAGLvVA=
Date:   Wed, 23 Mar 2022 02:40:51 +0000
Message-ID: <be7f6ea70a5146a190c750695aead7f5@cqplus1.com>
References: <cover.1647928315.git.qinjian@cqplus1.com>
 <YjmrdlQqoqUNcs7R@bogus>
In-Reply-To: <YjmrdlQqoqUNcs7R@bogus>
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

PiANCj4gTm90IHJlbGF0ZWQgdG8gdGhpcyBzZXJpZXMsIGJ1dCB0byB0aGUgcGxhdGZvcm0gaW4g
Z2VuZXJhbC4gWW91IHN0aWxsDQo+IG5lZWQgdG8gcmVzb2x2ZWQgdGhlIGJvb3QvY3B1LW1ldGhv
ZCBmb3IgdGhpcyBwbGF0Zm9ybSBiZWZvcmUgeW91IGFkZA0KPiBzdXBwb3J0IGZvciBhbGwgdGhl
IDQgY3B1cyBvbiB0aGlzIHBsYXRmb3JtLiBJIHJlbWVtYmVyIGRpc2N1c3NpbmcgYWJvdXQNCj4g
Q1BVSWRsZSBvbiBhIHNlcGFyYXRlIHRocmVhZC4gSSB0aG91Z2h0IHRoaXMgaXMgYmVzdCB0aHJl
YWQgdG8gcmVtaW5kIHRoYXQNCj4gc28gdGhhdCBpdCBpcyBhZGRyZXNzZWQgYmVmb3JlIHdlIHNl
ZSBlaXRoZXIgY3B1aWRsZSBvciBjcHVob3RwbHVnIHN1cHBvcnQNCj4gb24gdGhpcyBwbGF0Zm9y
bS4NCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IFN1ZGVlcA0KDQpUaGFua3MgZm9yIHlvdXIgY29t
bWVudHMuDQpDdXJyZW50bHksICB3ZSBib290IGFsbCA0IGNvcmVzIHZpYSBwc2NpIHN1Y2Nlc3Nm
dWxseS4NCg0K
