Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF598C19F2B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jul 2022 02:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbiG1CIQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jul 2022 22:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbiG1CIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:08:14 -0400
Received: from azure-sdnproxy-1.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CF0B059241;
        Wed, 27 Jul 2022 19:08:10 -0700 (PDT)
Received: by ajax-webmail-mail-app2 (Coremail) ; Thu, 28 Jul 2022 10:07:55
 +0800 (GMT+08:00)
X-Originating-IP: [218.12.16.28]
Date:   Thu, 28 Jul 2022 10:07:55 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   duoming@zju.edu.cn
To:     "Jakub Kicinski" <kuba@kernel.org>
Cc:     linux-hams@vger.kernel.org, ralf@linux-mips.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] netrom: fix sleep in atomic context bugs in
 timer handlers
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <20220727183647.23ae46f8@kernel.org>
References: <20220726032420.5516-1-duoming@zju.edu.cn>
 <20220727183647.23ae46f8@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7ee70f8a.625d3.182428f792f.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgBHC7F87+FinOCVAQ--.27542W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgIEAVZdta2TewAnsZ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgpPbiBXZWQsIDI3IEp1bCAyMDIyIDE4OjM2OjQ3IC0wNzAwIEpha3ViIEtpY2luc2tp
IHdyb3RlOgoKPiBPbiBUdWUsIDI2IEp1bCAyMDIyIDExOjI0OjIwICswODAwIER1b21pbmcgWmhv
dSB3cm90ZToKPiA+IG5yX2hlYXJ0YmVhdF9leHBpcnkKPiA+ICAgbnJfd3JpdGVfaW50ZXJuYWwK
PiA+ICAgICBucl90cmFuc21pdF9idWZmZXIKPiAKPiB2b2lkIG5yX3RyYW5zbWl0X2J1ZmZlcihz
dHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBza19idWZmICpza2IpCj4gewo+IFsuLi5dCj4gCWlmICgh
bnJfcm91dGVfZnJhbWUoc2tiLCBOVUxMKSkgewo+IAo+ID4gICAgICAgbnJfcm91dGVfZnJhbWUK
PiAKPiBpbnQgbnJfcm91dGVfZnJhbWUoc3RydWN0IHNrX2J1ZmYgKnNrYiwgYXgyNV9jYiAqYXgy
NSkKPiB7Cj4gWy4uLl0KPiAJaWYgKGF4MjUgIT0gTlVMTCkgewo+IAkJcmV0ID0gbnJfYWRkX25v
ZGUobnJfc3JjLCAiIiwgJmF4MjUtPmRlc3RfYWRkciwgYXgyNS0+ZGlnaXBlYXQsCj4gCj4gYXgy
NSBtdXN0IGJlIE5VTEwgb24gdGhpcyBwYXRoIEFGQUlDVC4KPiAKPiA+ICAgICAgICAgbnJfYWRk
X25vZGUKPiA+ICAgICAgICAgICBrbWVtZHVwKC4uLEdGUF9LRVJORUwpIC8vbWF5IHNsZWVwCgpU
aGFuayB5b3UgZm9yIHlvdXIgdGltZSBhbmQgc3VnZ2VzdGlvbnMsIEkgdW5kZXJzdGFuZC4KCkJl
c3QgcmVnYXJkcywKRHVvbWluZyBaaG91
