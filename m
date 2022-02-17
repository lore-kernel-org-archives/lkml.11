Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46938C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 02:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiBQCsJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 21:48:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiBQCsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 21:48:07 -0500
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 774CA1FFC8E;
        Wed, 16 Feb 2022 18:47:52 -0800 (PST)
Received: by ajax-webmail-mail-app2 (Coremail) ; Thu, 17 Feb 2022 10:47:44
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.171.246]
Date:   Thu, 17 Feb 2022 10:47:44 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5ZGo5aSa5piO?= <duoming@zju.edu.cn>
To:     "Jakub Kicinski" <kuba@kernel.org>
Cc:     linux-hams@vger.kernel.org, ajk@comnets.uni-bremen.de,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] drivers: hamradio: 6pack: fix UAF bug caused by
 mod_timer()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <20220215203955.7d7a3eed@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20220216023549.50223-1-duoming@zju.edu.cn>
 <20220215203955.7d7a3eed@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <cbb5412.b171f.17f05941412.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgDHzyNQtw1imZHyAQ--.39720W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgEEAVZdtYMQOwACsS
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUCw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIHRpbWUgYW5kIHBvaW50aW5nIG91
dCBwcm9ibGVtcyBpbiBteSBwYXRjaC4KSSBoYXZlIHNlbnQgdGhlIG1vZGlmaWVkIHBhdGNoIGFn
YWluIGp1c3Qgbm93LgoKV2UgdXNlIHB0eSB0byBzaW11bGF0ZSA2cGFjayBkZXZpY2UsIHRoZSBy
ZWxlYXNlZCByZXNvdXJjZSBpcyB0dHlfc3RydWN0LT50dHlfcG9ydAppbiB0dHkgbGF5ZXIuIAoK
VGhlIGZyZWUgdHJhY2UgaXMgc2hvd24gYXMgYmVsb3c6CnR0eV9yZWxlYXNlKCktPnR0eV9yZWxl
YXNlX3N0cnVjdCgpLT5yZWxlYXNlX3R0eSgpLT50dHlfa3JlZl9wdXQoKS0+CnF1ZXVlX3JlbGVh
c2Vfb25lX3R0eSgpLT5yZWxlYXNlX29uZV90dHkoKS0+cHR5X2NsZWFudXAoKS0+dHR5X3BvcnRf
cHV0KHR0eS0+cG9ydCk7CgpUaGUgdXNlIHRyYWNlIGlzIHNob3duIGFzIGJlbG93OgpzcF94bWl0
X29uX2FpcigpLT5wdHlfd3JpdGUoKS0+dHR5X2ZsaXBfYnVmZmVyX3B1c2goKS0+dHR5X3NjaGVk
dWxlX2ZsaXAocG9ydCk7CgoKQmVzdCB3aXNoZXMsCkR1b21pbmcgWmhvdQoK
