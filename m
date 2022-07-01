Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC67CCA479
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 11:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbiGALA7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 07:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbiGALA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:00:57 -0400
Received: from jari.cn (unknown [218.92.28.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A982F80481;
        Fri,  1 Jul 2022 04:00:54 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Fri, 1 Jul 2022
 18:55:17 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.66]
Date:   Fri, 1 Jul 2022 18:55:17 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: ipconfig: use strscpy to replace strlcpy
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6635dc9f.d16.181b966989f.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBHUW+V0r5iSPdFAA--.879W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAICmFEYxsvOAAHsO
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUCw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ClRoZSBzdHJsY3B5IHNob3VsZCBub3QgYmUgdXNlZCBiZWNhdXNlIGl0IGRvZXNuJ3QgbGltaXQg
dGhlIHNvdXJjZQpsZW5ndGguIFByZWZlcnJlZCBpcyBzdHJzY3B5LgoKU2lnbmVkLW9mZi1ieTog
WHVlQmluZyBDaGVuIDxjaGVueHVlYmluZ0BqYXJpLmNuPgotLS0KIG5ldC9pcHY0L2lwY29uZmln
LmMgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ldC9pcHY0L2lwY29uZmlnLmMgYi9uZXQvaXB2NC9pcGNv
bmZpZy5jCmluZGV4IDIzNDJkZWJkNzA2Ni4uZTkwYmMwYWE4NWM3IDEwMDY0NAotLS0gYS9uZXQv
aXB2NC9pcGNvbmZpZy5jCisrKyBiL25ldC9pcHY0L2lwY29uZmlnLmMKQEAgLTE3NjUsMTUgKzE3
NjUsMTUgQEAgc3RhdGljIGludCBfX2luaXQgaXBfYXV0b19jb25maWdfc2V0dXAoY2hhciAqYWRk
cnMpCiAJCQljYXNlIDQ6CiAJCQkJaWYgKChkcCA9IHN0cmNocihpcCwgJy4nKSkpIHsKIAkJCQkJ
KmRwKysgPSAnXDAnOwotCQkJCQlzdHJsY3B5KHV0c25hbWUoKS0+ZG9tYWlubmFtZSwgZHAsCisJ
CQkJCXN0cnNjcHkodXRzbmFtZSgpLT5kb21haW5uYW1lLCBkcCwKIAkJCQkJCXNpemVvZih1dHNu
YW1lKCktPmRvbWFpbm5hbWUpKTsKIAkJCQl9Ci0JCQkJc3RybGNweSh1dHNuYW1lKCktPm5vZGVu
YW1lLCBpcCwKKwkJCQlzdHJzY3B5KHV0c25hbWUoKS0+bm9kZW5hbWUsIGlwLAogCQkJCQlzaXpl
b2YodXRzbmFtZSgpLT5ub2RlbmFtZSkpOwogCQkJCWljX2hvc3RfbmFtZV9zZXQgPSAxOwogCQkJ
CWJyZWFrOwogCQkJY2FzZSA1OgotCQkJCXN0cmxjcHkodXNlcl9kZXZfbmFtZSwgaXAsIHNpemVv
Zih1c2VyX2Rldl9uYW1lKSk7CisJCQkJc3Ryc2NweSh1c2VyX2Rldl9uYW1lLCBpcCwgc2l6ZW9m
KHVzZXJfZGV2X25hbWUpKTsKIAkJCQlicmVhazsKIAkJCWNhc2UgNjoKIAkJCQlpZiAoaWNfcHJv
dG9fbmFtZShpcCkgPT0gMCAmJgpAQCAtMTgyMCw3ICsxODIwLDcgQEAgX19zZXR1cCgibmZzYWRk
cnM9IiwgbmZzYWRkcnNfY29uZmlnX3NldHVwKTsKIAogc3RhdGljIGludCBfX2luaXQgdmVuZG9y
X2NsYXNzX2lkZW50aWZpZXJfc2V0dXAoY2hhciAqYWRkcnMpCiB7Ci0JaWYgKHN0cmxjcHkodmVu
ZG9yX2NsYXNzX2lkZW50aWZpZXIsIGFkZHJzLAorCWlmIChzdHJzY3B5KHZlbmRvcl9jbGFzc19p
ZGVudGlmaWVyLCBhZGRycywKIAkJICAgIHNpemVvZih2ZW5kb3JfY2xhc3NfaWRlbnRpZmllcikp
CiAJICAgID49IHNpemVvZih2ZW5kb3JfY2xhc3NfaWRlbnRpZmllcikpCiAJCXByX3dhcm4oIkRI
Q1A6IHZlbmRvcmNsYXNzIHRvbyBsb25nLCB0cnVuY2F0ZWQgdG8gXCIlc1wiXG4iLAotLSAKMi4y
NS4xCg==
