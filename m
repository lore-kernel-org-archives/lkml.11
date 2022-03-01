Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEAFC433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 06:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbiCAGtf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 01:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiCAGtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:49:33 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F033457A2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:48:52 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-122-WdwIAktFNf2mPBI1Zr5aEQ-1; Tue, 01 Mar 2022 06:48:50 +0000
X-MC-Unique: WdwIAktFNf2mPBI1Zr5aEQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Tue, 1 Mar 2022 06:48:49 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Tue, 1 Mar 2022 06:48:49 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Abhinav Kumar' <quic_abhinavk@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "khsieh@codeaurora.org" <khsieh@codeaurora.org>,
        "nganji@codeaurora.org" <nganji@codeaurora.org>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "aravindh@codeaurora.org" <aravindh@codeaurora.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>
Subject: RE: [PATCH] devcoredump: increase the device delete timeout to 10
 mins
Thread-Topic: [PATCH] devcoredump: increase the device delete timeout to 10
 mins
Thread-Index: AQHYLOuC8GeBLyfvf0C5oMN+SX9icKyqFqUw
Date:   Tue, 1 Mar 2022 06:48:49 +0000
Message-ID: <8fa2f879e33e4e42b76e21c6fbdcb023@AcuMS.aculab.com>
References: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
 <YgZD8vPqB7ISpRpZ@kroah.com>
 <654d620b-9e14-c47f-b48c-762dc0bd32a1@quicinc.com>
 <Ygdb63FrorUsX/Hg@kroah.com>
 <b9156bde-137c-2fac-19e0-b205ab4d6016@quicinc.com>
 <7db7d01fcf5a3edce61161769c0e6eb1541237bf.camel@sipsolutions.net>
 <2add9ba7-7bc8-bd1d-1963-61e8154b0e3c@quicinc.com>
 <989efb15-cc5e-8f6d-c313-118f01498e33@quicinc.com>
In-Reply-To: <989efb15-cc5e-8f6d-c313-118f01498e33@quicinc.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWJoaW5hdiBLdW1hcg0KPiBTZW50OiAyOCBGZWJydWFyeSAyMDIyIDIxOjM4DQouLi4N
Cj4gV2UgYWxzbyBkaWQgc29tZSBwcm9maWxpbmcgYXJvdW5kIGhvdyBtdWNoIGluY3JlYXNpbmcg
dGhlIGJsb2NrIHNpemUNCj4gaGVscHMgYW5kIGhlcmUgaXMgdGhlIGRhdGE6DQo+IA0KPiBCbG9j
ayBzaXplCWNvc3QNCj4gDQo+IDRLQgkgICAgICAgIDIyOXMNCj4gOEtCCSAgICAgICAgIDg2cw0K
DQpZb3UgbXVzdCBoYXZlIGFuIE8obl4yKSBvcGVyYXRpb24gaW4gdGhlcmUgLSBmaW5kIGl0Lg0K
DQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K

