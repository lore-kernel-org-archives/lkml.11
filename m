Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF6EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 05:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244282AbiDOFNa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 01:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349474AbiDOFNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:13:12 -0400
Received: from cstnet.cn (smtp83.cstnet.cn [159.226.251.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D28254754C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:10:43 -0700 (PDT)
Received: by ajax-webmail-APP-09 (Coremail) ; Fri, 15 Apr 2022 13:10:36
 +0800 (GMT+08:00)
X-Originating-IP: [124.16.96.42]
Date:   Fri, 15 Apr 2022 13:10:36 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5r2Y5bqG6ZyW?= <panqinglin2020@iscas.ac.cn>
To:     "Anup Patel" <apatel@ventanamicro.com>
Cc:     "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Alexandre Ghiti" <alexandre.ghiti@canonical.com>,
        "Atish Patra" <atishp@atishpatra.org>,
        "Alistair Francis" <Alistair.Francis@wdc.com>,
        "Anup Patel" <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "Mayuresh Chitale" <mchitale@ventanamicro.com>
Subject: Re: Re: [PATCH] RISC-V: mm: Fix set_satp_mode() for platform not
 having Sv57
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn cnic.cn
In-Reply-To: <CAK9=C2V0kiV1_12kMDxv6d4nsQZ81-9W5=JifLhNaiZMoHJyuQ@mail.gmail.com>
References: <20220412033335.1384230-1-apatel@ventanamicro.com>
 <4c4c7a.17284.1802b8c14cc.Coremail.panqinglin2020@iscas.ac.cn>
 <CAK9=C2V0kiV1_12kMDxv6d4nsQZ81-9W5=JifLhNaiZMoHJyuQ@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <373ad9c1.173d2.1802ba15993.Coremail.panqinglin2020@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: swCowABHcM5N_lhik6QBAA--.12846W
X-CM-SenderInfo: 5sdq1xpqjox0asqsiq5lvft2wodfhubq/1tbiCQgRDF02bFOZcQAC
        si
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW51cCwKCiZndDsgCiZndDsgV2UgY2FuJ3QgYXNzdW1lIHRoYXQgaXQgd2lsbCBiZSB0aGUg
c2FtZSBwZ2RfaW5kZXggZm9yIFN2NDggYW5kIFN2NTcuCiZndDsgCiZndDsgRm9yIGV4YW1wbGUs
IHNvbWUgaHlwb3RoZXRpY2FsIFNvQyBtaWdodCBoYXZlIFJBTSBzdGFydGluZyBhZnRlciAxVEIg
c3BhY2UuCiZndDsgCiZndDsgV2Ugc2hvdWxkIGVuc3VyZSB0aGF0IGVhcmx5X3BnX2RpciBpcyBj
bGVhbmVkIGVudGlyZWx5IGZvciBkZXRlY3RpbmcgdGhlIG5leHQKJmd0OyBtb2RlLgomZ3Q7IAoK
R290IGl0LiBZb3VyIGlkZWEgaXMgcmVhbGx5IG1vcmUgc3RhYmxlLiBUaGFuayB5b3UgZm9yIHBv
aW50aW5nIG91dCB0aGF0IQoKWW91cnMsClFpbmdsaW4K
