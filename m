Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7659CC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 09:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381001AbiFQJhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 05:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbiFQJhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:37:40 -0400
X-Greylist: delayed 368 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Jun 2022 02:37:36 PDT
Received: from cstnet.cn (smtp85.cstnet.cn [159.226.251.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4A1EDB1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:37:36 -0700 (PDT)
Received: by ajax-webmail-APP-13 (Coremail) ; Fri, 17 Jun 2022 17:31:25
 +0800 (GMT+08:00)
X-Originating-IP: [49.77.99.12]
Date:   Fri, 17 Jun 2022 17:31:25 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5a2Z5rui?= <sunying@nj.iscas.ac.cn>
To:     linux-kernel@vger.kernel.org
Subject: Will the "CONFIG_CGROUP_DEBUG"  x86_64 default configuration be
 turned off in later versions?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <f12557f.8fe4.1817100c80f.Coremail.sunying@nj.iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: twCowABXG_TuSaxiOTcDAA--.14173W
X-CM-SenderInfo: 5vxq5xdqj60y4olvutnvoduhdfq/1tbiCQ0AAWKY1i0dwwABsb
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksCkkgbm90aWNlZCB0aGF0IGFmdGVyIHY1LjE4LjAtcmMxIHRoZSBkZWZhdWx0IGNvbmZpZ3Vy
YXRpb24gb2YgIkNPTkZJR19DR1JPVVBfREVCVUciIGF0IHg4Nl82NCBhcmNoaXRlY3R1cmUgaXMg
dHVybmVkIG9uLCBpcyB0aGlzIGNvbmZpZ3VyYXRpb24ganVzdCB1c2VkIGZvciBjZ3JvdXBzIGRl
YnVnZ2luZywgd2lsbCBpdCBiZSB0dXJuZWQgb2ZmIGluIGxhdGVyIHZlcnNpb25zPwpUaGUgY29u
ZmlndXJhdGlvbiBpcyBzZXQgaW4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdC9sb2cvYXJjaC94ODYvY29uZmlncy94ODZfNjRf
ZGVmY29uZmlnIC4KClRoYW5rcyEKCgo=
