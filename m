Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29ABC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 05:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbiDNFuS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 01:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiDNFuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 01:50:15 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B3524BBAA;
        Wed, 13 Apr 2022 22:47:48 -0700 (PDT)
Received: by ajax-webmail-mail-app2 (Coremail) ; Thu, 14 Apr 2022 13:47:39
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.3.190]
Date:   Thu, 14 Apr 2022 13:47:39 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Duoming Zhou" <duoming@zju.edu.cn>
Cc:     krzk@kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, alexander.deucher@amd.com,
        akpm@linux-foundation.org, broonie@kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH V2 2/3] drivers: nfc: nfcmrvl: fix double free bug in
 nfc_fw_download_done()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <538873335b034d7d97a08d2343e898cfa924918a.1649913521.git.duoming@zju.edu.cn>
References: <cover.1649913521.git.duoming@zju.edu.cn>
 <538873335b034d7d97a08d2343e898cfa924918a.1649913521.git.duoming@zju.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2c2717d.10593.180269cebc8.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: by_KCgB3FMR7tVdiwEG7AQ--.18820W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwUSElNG3GUX+gATsU
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUCw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gdGhlcmUsCgpTb3JyeSwgdGhlIGFjdHVhbCBjYXNlIGRvZXMgbm90IG1hdGNoIHRoZSBk
ZXNjcmlwdGlvbi4gVGhlIG5ldGxpbmsgb3BlcmF0aW9ucyBtYXkgaGFzIG5vdGhpbmcgdG8gZG8g
d2l0aCB0aGUgZG91YmxlIGZyZWUgYW5kIHdlIHdpbGwgZHluYW1pY2FsbHkgY2hlY2sgdGhpcyBh
Z2Fpbi4KClNvcnJ5IGFnYWluIGZvciB0aGUgZmFsc2UgdGFnIGFuZCB0aGUgZmFsc2UgYWxhcm0u
IFQuVAoKUmVnYXJkcwpMaW4gTWE=
