Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54250C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jul 2022 02:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbiGRCHc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jul 2022 22:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiGRCHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 22:07:31 -0400
Received: from out199-7.us.a.mail.aliyun.com (out199-7.us.a.mail.aliyun.com [47.90.199.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AEED120
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 19:07:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=liusong@linux.alibaba.com;NM=1;PH=DW;RN=3;SR=0;TI=W4_0.1.30_DEFAULT_21283DCF_1658108728623_o7001c54a;
Received: from WS-web (liusong@linux.alibaba.com[W4_0.1.30_DEFAULT_21283DCF_1658108728623_o7001c54a]) at Mon, 18 Jul 2022 10:07:26 +0800
Date:   Mon, 18 Jul 2022 10:07:26 +0800
From:   "liusong" <liusong@linux.alibaba.com>
To:     "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "linux-mm" <linux-mm@kvack.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "liusong" <liusong@linux.alibaba.com>
Message-ID: <40912cc7-4d8d-41f0-8256-add55ae41597.liusong@linux.alibaba.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gbW0vZG1hcG9vbC5jOiBhdm9pZCBkdXBsaWNhdGUgbWVtc2V0IHdpdGhp?=
  =?UTF-8?B?biBkbWFfcG9vbF9hbGxvYw==?=
X-Mailer: [Alimail-Mailagent revision 7410][W4_0.1.30][DEFAULT][Chrome]
MIME-Version: 1.0
References: <1657769100-66142-1-git-send-email-liusong@linux.alibaba.com>,<20220716180110.eb9402180137d0ce84e3971c@linux-foundation.org>,<13d6bf0e-b22b-4414-a091-264877904ab9.liusong@linux.alibaba.com>
x-aliyun-mail-creator: W4_0.1.30_DEFAULT_QvNTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwMy4wLjAuMCBTYWZhcmkvNTM3LjM2La
In-Reply-To: <13d6bf0e-b22b-4414-a091-264877904ab9.liusong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBjYW4gbm90IG9ubHkgY29uc2lkZXIgZGlyZWN0IGFsbG9jLCB3aXRoIGNvbmZp
ZyBDT05GSUdfRE1BX0RFQ0xBUkVfQ09IRVJFTlQsCmluICJkbWFfYWxsb2NfZnJvbV9kZXZfY29o
ZXJlbnQiLCB3aGljaCB3aWxsIGFsc28gZXhwbGljaXRseSBtZW1zZXQgdGhlIGFsbG9jYXRlZCBt
ZW1vcnkgdG8gMCwKc28gdGhpcyBzaXR1YXRpb24gbmVlZHMgdG8gYmUgY29uc2lkZXJlZC4gSXQg
aXMgYmVuZWZpY2lhbCB0byB0aGUgcHJvY2VzcyBvZiBjYWxsaW5nICJkbWFfcG9vbF96YWxsb2Mi
LgpOZXh0LCBhIFYyIHBhdGNoIHdpbGwgYmUgc3VibWl0dGVkLgoKVGhhbmtzLg==
