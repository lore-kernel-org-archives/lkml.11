Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F0FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 04:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244924AbiBIEIc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 23:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347630AbiBID70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:59:26 -0500
X-Greylist: delayed 982 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 19:59:24 PST
Received: from m13151.mail.163.com (m13151.mail.163.com [220.181.13.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50467C061579
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=+gO8T
        07vX7kDCL0Yg8uMsti+0sKsRe0cSU2LfwKZ0vU=; b=bi3NkR1cEHTMidvlnEdYJ
        kHgBa5owuSLnm98UsmwS4ygRPNet8hjckc5zYuukoGNMwt6RJFcupCpVq7YjvWEf
        +AB39YkjF88gEX5n0fe3a9SumNm10s6ERS2DBS+WYQhTwUGoRA/rYE8Hexa0yLmi
        yN40EGRpVwvZ5AGvnQcwMk=
Received: from chengchaohang$163.com ( [114.251.148.34] ) by
 ajax-webmail-wmsvr151 (Coremail) ; Wed, 9 Feb 2022 11:42:39 +0800 (CST)
X-Originating-IP: [114.251.148.34]
Date:   Wed, 9 Feb 2022 11:42:39 +0800 (CST)
From:   "chaohang.cheng" <chengchaohang@163.com>
To:     leon@kernel.org, maorg@nvidia.com, jgg@ziepe.ca,
        logang@deltatee.com, thunder.leizhen@huawei.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib/scatterlist: Provide scatterlist hexdump.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <56c6ead2.33c5.17edc937b42.Coremail.chengchaohang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: l8GowACnr0swOANiy6MxAA--.13202W
X-CM-SenderInfo: xfkh0wpfkd0xxdqjqiywtou0bp/xtbBzRyivF0CR+iuTgABse
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogImNoYW9oYW5nLmNoZW5nIiA8Y2hhb2hhbmcuY2hlbmdAaG9yaXpvbi5haT4KCkEgc2Nh
dHRlcmxpc3QgaGV4ZHVtcCBpcyBlc3NlbnRpYWwgZHVyaW5nIGRlYnVnLCBzb21ldGltZXMuCgpT
aWduZWQtb2ZmLWJ5OiBjaGFvaGFuZy5jaGVuZyA8Y2hhb2hhbmcuY2hlbmdAaG9yaXpvbi5haT4K
LS0tCiBpbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmggfCAxNyArKysrKysrKysrKysrKysrKwog
MSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L3NjYXR0ZXJsaXN0LmggYi9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmgKaW5kZXggN2Zm
OWQ2Mzg2YzEyLi5lZjhlY2FhYzAwMTYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvc2NhdHRl
cmxpc3QuaAorKysgYi9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmgKQEAgLTU2Myw0ICs1NjMs
MjEgQEAgYm9vbCBzZ19taXRlcl9za2lwKHN0cnVjdCBzZ19tYXBwaW5nX2l0ZXIgKm1pdGVyLCBv
ZmZfdCBvZmZzZXQpOwogYm9vbCBzZ19taXRlcl9uZXh0KHN0cnVjdCBzZ19tYXBwaW5nX2l0ZXIg
Km1pdGVyKTsKIHZvaWQgc2dfbWl0ZXJfc3RvcChzdHJ1Y3Qgc2dfbWFwcGluZ19pdGVyICptaXRl
cik7CiAKKy8qCisgKiBIZXhkdW1wIHNjYXR0ZXJsaXN0CisgKgorICogQHNnOiBzdHJ1Y3Qgc2Nh
dHRlcmxpc3QqIC4KKyAqIGl0IHN0YW5kcyBmb3IgdGhlIGhlYWQgb2YgYSBzY2F0dGVybGlzdCAu
CisgKgorICogbm90ZTogcHJpbnRfaGV4X2R1bXBfZGVidWcgaXMgYSBkeW5hbWljIGRlYnVnIC4K
KyAqCisgKi8KKyNkZWZpbmUgU0dfSEVYRFVNUChzZykJCQkJCQkJXAorZG8gewkJCQkJCQkJCVwK
KwlzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnX3RtcCA9IE5VTEw7CQkJCVwKKwlmb3IgKHNnX3RtcCA9
IHNnOyBzZ190bXA7IHNnX3RtcCA9IHNnX25leHQoc2dfdG1wKSkJCVwKKwkJcHJpbnRfaGV4X2R1
bXBfZGVidWcoIiIsIERVTVBfUFJFRklYX09GRlNFVCwJCVwKKwkJCTE2LCAxLCBzZ192aXJ0KHNn
X3RtcCksIHNnX3RtcC0+bGVuZ3RoLCB0cnVlKTsJXAorfSB3aGlsZSAoMCkKKwogI2VuZGlmIC8q
IF9MSU5VWF9TQ0FUVEVSTElTVF9IICovCi0tIAoyLjI1LjEK
