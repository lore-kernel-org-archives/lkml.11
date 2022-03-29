Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C10C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 09:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbiC2JOB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 05:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbiC2JNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:13:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB519A9AB;
        Tue, 29 Mar 2022 02:12:12 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KSP1519TXzfZFW;
        Tue, 29 Mar 2022 17:10:33 +0800 (CST)
Received: from kwepemi500013.china.huawei.com (7.221.188.120) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 17:12:10 +0800
Received: from kwepemi500013.china.huawei.com ([7.221.188.120]) by
 kwepemi500013.china.huawei.com ([7.221.188.120]) with mapi id 15.01.2308.021;
 Tue, 29 Mar 2022 17:12:10 +0800
From:   zhengyongjun <zhengyongjun3@huawei.com>
To:     Paolo Abeni <pabeni@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
        "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
        "claudiu.manoil@nxp.com" <claudiu.manoil@nxp.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIG5ldDogZHNhOiBmZWxpeDogZml4IHBvc3NpYmxl?=
 =?utf-8?Q?_NULL_pointer_dereference?=
Thread-Topic: [PATCH] net: dsa: felix: fix possible NULL pointer dereference
Thread-Index: AQHYQ0VCxcMD8urjZU2VYgBSBGj7r6zVifmAgACJZUA=
Date:   Tue, 29 Mar 2022 09:12:10 +0000
Message-ID: <42986bf785de4d1aac454a9463f46915@huawei.com>
References: <20220329081214.124061-1-zhengyongjun3@huawei.com>
 <b4d4ee6c553f9cd983d12f88eb6a12ca3cb39962.camel@redhat.com>
In-Reply-To: <b4d4ee6c553f9cd983d12f88eb6a12ca3cb39962.camel@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.64]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciBwb2ludCBvdXQgbXkgbWlzdGFrZSA6KQ0KLS0tLS3pgq7ku7bljp/ku7YtLS0t
LQ0K5Y+R5Lu25Lq6OiBQYW9sbyBBYmVuaSBbbWFpbHRvOnBhYmVuaUByZWRoYXQuY29tXSANCuWP
kemAgeaXtumXtDogMjAyMuW5tDPmnIgyOeaXpSAxNzowMA0K5pS25Lu25Lq6OiB6aGVuZ3lvbmdq
dW4gPHpoZW5neW9uZ2p1bjNAaHVhd2VpLmNvbT47IGFuZHJld0BsdW5uLmNoOyB2aXZpZW4uZGlk
ZWxvdEBnbWFpbC5jb207IGYuZmFpbmVsbGlAZ21haWwuY29tOyBkYXZlbUBkYXZlbWxvZnQubmV0
OyBrdWJhQGtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCuaKhOmAgTogdmxhZGltaXIub2x0ZWFuQG54cC5jb207IGNsYXVkaXUu
bWFub2lsQG54cC5jb207IGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tOyBVTkdMaW51eERy
aXZlckBtaWNyb2NoaXAuY29tDQrkuLvpopg6IFJlOiBbUEFUQ0hdIG5ldDogZHNhOiBmZWxpeDog
Zml4IHBvc3NpYmxlIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZQ0KDQpIZWxsbywNCg0KT24gVHVl
LCAyMDIyLTAzLTI5IGF0IDA4OjEyICswMDAwLCBaaGVuZyBZb25nanVuIHdyb3RlOg0KPiBBcyB0
aGUgcG9zc2libGUgZmFpbHVyZSBvZiB0aGUgYWxsb2NhdGlvbiwga3phbGxvYygpIG1heSByZXR1
cm4gTlVMTCANCj4gcG9pbnRlci4NCj4gVGhlcmVmb3JlLCBpdCBzaG91bGQgYmUgYmV0dGVyIHRv
IGNoZWNrIHRoZSAnc2dpJyBpbiBvcmRlciB0byBwcmV2ZW50IA0KPiB0aGUgZGVyZWZlcmVuY2Ug
b2YgTlVMTCBwb2ludGVyLg0KPiANCj4gRml4ZXM6IDIzYWUzYTc4Nzc3MTggKCJuZXQ6IGRzYTog
ZmVsaXg6IGFkZCBzdHJlYW0gZ2F0ZSBzZXR0aW5ncyBmb3IgcHNmcHEiKS4NCg0KSXQgbG9va3Mg
bGlrZSB0aGUgZml4ZXMgdGFnIGhhcyBiZWVuIGNvcnJ1cHRlZCAodHJhaWxpbmcgJ3EnKS4gV291
bGQgeW91IG1pbmQgcG9zdGluZyBhIHYyIHdpdGggdGhhdCBmaXhlZCA/DQoNClRoYW5rcywNCg0K
UGFvbG8NCg0K
