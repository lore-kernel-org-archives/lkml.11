Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A74BC433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 01:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiBQBmg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 20:42:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiBQBme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 20:42:34 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 24200FABC1;
        Wed, 16 Feb 2022 17:42:17 -0800 (PST)
Received: by ajax-webmail-mail-app4 (Coremail) ; Thu, 17 Feb 2022 09:42:00
 +0800 (GMT+08:00)
X-Originating-IP: [180.169.129.130]
Date:   Thu, 17 Feb 2022 09:42:00 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jing Leng" <3090101217@zju.edu.cn>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, ruslan.bilovol@gmail.com,
        pavel.hofman@ivitera.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Jing Leng" <jleng@ambarella.com>
Subject: Re: [PATCH] usb: gadget: f_uac1: add set requests support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <YgzTsLV/nSKp7FWP@kroah.com>
References: <20220216094301.2448-1-3090101217@zju.edu.cn>
 <YgzTsLV/nSKp7FWP@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <770c0d3f.ab34b.17f0557e359.Coremail.3090101217@zju.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: cS_KCgC3vuLopw1i22s7CQ--.61219W
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwQEBVNG3FjiPwABsL
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZyBLSCwKCj4gU28gaXMgdGhpcyBhIGJ1ZyBpbiB0aGUgSG9zdCBzaWRlIHRvIG5vdCBk
byBzdHVmZiBsaWtlIHRoaXM/ICBXaHkgbm90Cj4gZml4IGl0IHRoZXJlIGluc3RlYWQ/Cj4gCj4g
V2hlcmUgaXMgdGhlIHJlcXVpcmVtZW50IHRoYXQgdGhpcyBjb21tYW5kIG11c3QgYmUgaGFuZGxl
ZCBieSB0aGUKPiBkZXZpY2U/Cj4gCgpGaXJzdCB3ZSBuZWVkIHRvIGNsYXJpZnkgdHdvIGlzc3Vl
cy4KCjEuIERvZXMgdGhlIFVidW50dSBnbyBiZXlvbmQgdGhlIFVBQzEgc3BlY2lmaWNhdGlvbj8K
Tm8uIApPbiBwYWdlIDY2IG9mIHRoZSBVQUMxIHNwZWNpZmljYXRpb24gKApodHRwczovL3d3dy51
c2Iub3JnL3NpdGVzL2RlZmF1bHQvZmlsZXMvYXVkaW8xMC5wZGYpOgpUaGUgYlJlcXVlc3QgY2Fu
IGJlIFNFVF9DVVIsIFNFVF9NSU4sIFNFVF9NQVgsIFNFVF9SRVMgb3IgU0VUX01FTS4KSW4gbW9z
dCBjYXNlcywgb25seSB0aGUgQ1VSIGFuZCBNRU0gYXR0cmlidXRlIHdpbGwgYmUgc3VwcG9ydGVk
IGZvcgp0aGUgU2V0IHJlcXVlc3QuIEhvd2V2ZXIsIHRoaXMgc3BlY2lmaWNhdGlvbiBkb2VzIG5v
dCBwcmV2ZW50IGEKZGVzaWduZXIgZnJvbSBtYWtpbmcgb3RoZXIgYXR0cmlidXRlcyBwcm9ncmFt
bWFibGUuClN1cHBsZW1lbnQ6IFdpbmRvd3MgMTAgb25seSBzZW5kcyBTRVRfQ1VSIHJlcXVlc3Qu
CgoyLiBEb2VzIHRoZSBvbGQgdmVyc2lvbiBrZXJuZWwgaGF2ZSB0aGUgcHJvYmxlbSBvbiB0aGUg
VWJ1bnR1PwpOTy4gKGUuZy4gbGludXgtNS4xMCkKVGhlIHByb2JsZW0gaXMgaW50cm9kdWNlZCBi
eSB0aGUgZm9sbG93aW5nIG1vZGlmaWNhdGlvbjoKICAgIGNvbW1pdCAwMzU2ZTYyODNjNzE3NzM5
MWQxNDQ2MTJmNGIxMjk4NmVkNWM0ZjZlCiAgICBBdXRob3I6IFJ1c2xhbiBCaWxvdm9sIDxydXNs
YW4uYmlsb3ZvbEBnbWFpbC5jb20+CiAgICBEYXRlOiAgIE1vbiBKdWwgMTIgMTQ6NTU6MjkgMjAy
MSArMDIwMAoKICAgICAgICB1c2I6IGdhZGdldDogZl91YWMxOiBhZGQgdm9sdW1lIGFuZCBtdXRl
IHN1cHBvcnQKClNpbmNlIFVidW50dSBkb2Vzbid0IGdvIGJleW9uZCB0aGUgVUFDMSBzcGVjaWZp
Y2F0aW9uIGFuZCB0aGUgcHJvYmxlbQppcyBpbnRyb2R1Y2VkIGJ5IG5ldyB2ZXJzaW9uIGtlcm5l
bCwgV2h5IGRvbid0IHdlIHBlcmZlY3QgaXQgb24gCmtlcm5lbCBzaWRlPwoKVGhhbmtzCkppbmcg
TGVuZw==
