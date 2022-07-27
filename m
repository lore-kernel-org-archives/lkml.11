Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9108CC00144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jul 2022 02:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239897AbiG0CGc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jul 2022 22:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiG0CGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 22:06:30 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A78F73120A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 19:06:29 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.188:60274.1938016156
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-10.133.8.199 (unknown [172.18.0.188])
        by chinatelecom.cn (HERMES) with SMTP id 288702800A5;
        Wed, 27 Jul 2022 10:06:25 +0800 (CST)
X-189-SAVE-TO-SEND: liuxp11@chinatelecom.cn
Received: from  ([172.18.0.188])
        by app0023 with ESMTP id 9ac46f9363654edea7bffdb32a988069 for mawupeng1@huawei.com;
        Wed, 27 Jul 2022 10:06:27 CST
X-Transaction-ID: 9ac46f9363654edea7bffdb32a988069
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.188
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
Date:   Wed, 27 Jul 2022 10:06:25 +0800
From:   "liuxp11@chinatelecom.cn" <liuxp11@chinatelecom.cn>
To:     mawupeng <mawupeng1@huawei.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "david@redhat.com" <david@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] memblock tests: compiling error
References: <1658804705-16996-1-git-send-email-liuxp11@chinatelecom.cn>, 
        <9bf50501-fac5-cd59-660e-52a6b779865f@huawei.com>
X-Priority: 3
X-GUID: 62D3FD94-EA2C-434A-A264-E025182DDFDF
X-Has-Attach: no
X-Mailer: Foxmail 7.2.20.258[cn]
Mime-Version: 1.0
Message-ID: <202207271006248558685@chinatelecom.cn>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIDIwMjIvNy8yNiAxMTowNSwgTGl1IFhpbnBlbmcgd3JvdGU6Cgo+PiBtZW1ibG9jay5vOiBJ
biBmdW5jdGlvbiBgbWVtYmxvY2tfZmluZF9pbl9yYW5nZS5jb25zdHByb3AuOSc6Cgo+PiBtZW1i
bG9jay5jOigudGV4dCsweDQ2NTEpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBwcl93YXJuX3Jh
dGVsaW1pdGVkJwoKPj4gbWVtYmxvY2subzogSW4gZnVuY3Rpb24gYG1lbWJsb2NrX21hcmtfbWly
cm9yJzoKCj4+IG1lbWJsb2NrLmM6KC50ZXh0KzB4NzE3MSk6IHVuZGVmaW5lZCByZWZlcmVuY2Ug
dG8gYG1pcnJvcmVkX2tlcm5lbGNvcmUnCgo+PiBGaXhzOiA5MDJjMmQ5MTU4MiAoIm1lbWJsb2Nr
OiBEaXNhYmxlIG1pcnJvciBmZWF0dXJlIGlmIGtlcm5lbGNvcmUgaXMgbm90Cj4+IHNwZWNpZmll
ZCIpCgo+Rml4cyBzaG91bGQgbm90IGhhdmUgd29yZCB3YXJwLgoKCj5UZXN0ZWQtYnk6IE1hIFd1
cGVuZyA8bWF3dXBlbmcxQGh1YXdlaS5jb20+CgpJIHdpbGwgc2VuZCBwYXRjaCB2Miwgc3VjaCBh
cywKCkZpeHM6IDkwMmMyZDkxNTgyICgibWVtYmxvY2s6IERpc2FibGUgbWlycm9yIGZlYXR1cmUg
aWYga2VybmVsY29yZSBpcyBub3QKc3BlY2lmaWVkIikgYW5kIDE0ZDlhNjc1ZmQwICgibW06IFJh
dGVsaW1pdGVkIG1pcnJvcmVkIG1lbW9yeSByZWxhdGVkIHdhcm5pbmciKQoKPiArI2RlZmluZSBw
cl93YXJuX3JhdGVsaW1pdGVkKGZtdCwgLi4uKSAgICBwcmludGYoZm10LCAjI19fVkFfQVJHU19f
KTsKCkFuZCByZW1vdmVkIHRoZSBjb21tYS4KCgp0aGFua3MgeW91ciB0ZXN0LApMaXUgWGlucGVu
ZwoK

