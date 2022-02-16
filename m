Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF5CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 02:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343761AbiBPCee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 21:34:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbiBPCec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:34:32 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 666449A4EA;
        Tue, 15 Feb 2022 18:34:19 -0800 (PST)
Received: by ajax-webmail-mail-app2 (Coremail) ; Wed, 16 Feb 2022 10:34:00
 +0800 (GMT+08:00)
X-Originating-IP: [180.169.129.130]
Date:   Wed, 16 Feb 2022 10:34:00 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5Ya36Z2Z?= <3090101217@zju.edu.cn>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, jleng@ambarella.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_uvc: fix superspeedplus transfer
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <Yguzht2JJtF+8N76@kroah.com>
References: <Ygow+EB1P84VflBb@kroah.com>
 <20220215021647.4316-1-3090101217@zju.edu.cn> <Yguzht2JJtF+8N76@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6ca9a5a8.ae1fb.17f0061243d.Coremail.3090101217@zju.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: by_KCgBHRFCYYgxiFbnrAQ--.40657W
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwIDBVNG3Fih1gAAsh
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZyBLSCwKClNvcnJ5IGZvciB0aGUgdHJvdWJsZSwgYXMgYSBuZXcgY29udHJpYnV0b3Ig
dG8ga2VybmVsLgpBbHRob3VnaCBJIGhhdmUgcmVhZGVkIHRoZSBkb2N1bWVudCB0aGF0IGhvdyB0
byBzdWJtaXQgcGF0Y2hlcywKSSdtIHN0aWxsIG1pc3Npbmcgc29tZSBkZXRhaWxzLgoKPiBXaGF0
IGRvZXMgImNhbGwgdHJhY2UiIGhlcmUgbWVhbj8gIElzIHRoaXMgYW4gZXJyb3I/ICBTb21ldGhp
bmcgZWxzZT8KSXQgaXMgImNhbGwgdHJhY2UiIHdoZW4gdGhlIGtlcm5lbCBhY2Nlc3NlZCBOVUxM
IHBvaW50ZXIgYW5kIGhhbmRlZC4KCj4gWW91IGRpZCBub3QgcmVhZCB0aGUgaW5mb3JtYXRpb24g
dGhhdCBteSBib3QgdG9sZCB5b3UgdG8gcmVhZCwgZm9yIGhvdwo+IHRvIHByb3Blcmx5IHZlcnNp
b24geW91ciBwYXRjaGVzIDooCj4gCj4gUGxlYXNlIGdvIGJhY2sgYW5kIGRvIHNvIHdoZW4geW91
IHJlc2VuZCBhbGwgb2YgdGhlbS4KPiAKPiBBbHNvIHRoaXMgaXMgbm90IGEgcGF0Y2ggc2VyaWVz
PyAgV2h5IG5vdD8KCkkgcmVhZGVkIHRoZSBib3QgdG9sZCwgYnV0IEkgc3RpbGwgbWlzc2VkIGl0
LgpUaGUgbmV3IHBhdGNoIG9ubHkgYWRkcyBtb3JlIGRldGFpbGVkIHBhdGNoIGRlc2NyaXB0aW9u
LgpTbyBpdCBpcyBub3QgYSBwYXRjaCBzZXJpZXMuCgp0aGFua3MsCgpKaW5nIExlbmc=
